Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32365CCFA05
	for <u-boot@archiver.kernel.org>; Thu,  6 Nov 2025 17:01:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4282683C34;
	Thu,  6 Nov 2025 17:59:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YGWbU88X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E38E083C0C; Thu,  6 Nov 2025 17:59:53 +0100 (CET)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6EA483BEB
 for <u-boot@lists.denx.de>; Thu,  6 Nov 2025 17:59:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7c284d4867eso331665a34.3
 for <u-boot@lists.denx.de>; Thu, 06 Nov 2025 08:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762448390; x=1763053190; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QDB2vNszl9S3CEKQnDX8YaNz7KeZom0dp6G/mNHF3mY=;
 b=YGWbU88X46nRIT/g8lgv1DamrH7CRRqRQKlVTR0go2+WAj02nW1zIP/GMIMkQUmnM1
 1ctpzspSUo2RB7x+cH1MJQmwZUNTzhVNTtqybbUfUUGS7yaqr1nyublpwG3G0Fph94R3
 C7zvmTiZnQzWEbthAS4+PEf988KZaGYnr+aro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762448390; x=1763053190;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QDB2vNszl9S3CEKQnDX8YaNz7KeZom0dp6G/mNHF3mY=;
 b=J2NCJKJ76YJLAtHBr/1jn3276Op8HYc3Uu4hUWUTq1wfGRbmWFVUQs8qc55MKgmD/h
 Em4s0CweIX9OXQs468V+BpxE7Y+KnHJ+phdvX7b/OFZOfg5ZPXfxcTS86zvI3jkjf8tn
 HKSIj8k9DVKMKcPNTFetJ2d9IxaQFiiqp82jOdA8V1avHY0JQuYsn0ndLCIYNau5zU+P
 N6U4g59mE+dsQEjw+DiayR8dYvsjXr/7cH2adEf41Bwz1GBtvV/EVuWG5cRGoVOfG1oQ
 ElS7S1FSjprN6x4CdC9v1GoIjrdNer/W4O511FXLyXemIeoeuMAdV2ZdJw0/ViBmyiop
 3nUA==
X-Gm-Message-State: AOJu0YzDxMCcpi2jtYc9ZtZsSuB3rypkZdZaDK3ONbIBW1y6BXXkM+Sn
 GIdclh0kNGOkeDBO6D9jNDbLWGFb6Rk8NIdww43PjdFMenelHk2XgnfG5UvXw3C7BBI=
X-Gm-Gg: ASbGncvOwpYVudtX+2FGDlRY1ZpXl1zt4EZTq76+GYdKUn9jVEJwSZkiHwKAmx0Cx3V
 kSWjuvO9jdJTaMmmC9ryg2PY59QeDJ78t00aNqct9cW2+BxybNKsJHwb1qgBYvJoGsegdvJSDDp
 yovWpqiYH9ETAdrzSxb2Lt3NxJW03GpBKNarzfnDydc9IdzcGmKBqOFZodgwS9FdkZ1URgSxPHD
 3cgiLSbyUu0EaC63Nw/2fdy5ewVbbmB1HRP0TeO0WP3OYRK98FcGf6q6evvFOM7eVuNVTKT1hGf
 QN2MTalASKQ2fnnriWp5/bYdMc+GWqXiSF/32tgayxrEEsT0SeGBciiTJRPJkaJvhzTiDN9q29O
 W1Bl1v99Dms7cmBmrpr4N8cHXMKrcAaaZZ+PdRIJBATuQoYbP3ebdV4FKi9rF7SK2akatsDeM6a
 wOUnvv4SYtZjla7698qCk73wNAY9p5OvK11hRU0g==
X-Google-Smtp-Source: AGHT+IGl6WH50exq7WJCy/kURlnNi4l4POHNAB7wv7CTtW0N2VxgS6uLLTIzk/pkdkTz0HKT8JFZYg==
X-Received: by 2002:a05:6830:438b:b0:7c6:b104:e3db with SMTP id
 46e09a7af769-7c6efee93c4mr183774a34.23.1762448390579; 
 Thu, 06 Nov 2025 08:59:50 -0800 (PST)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c6f11323absm24819a34.23.2025.11.06.08.59.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Nov 2025 08:59:50 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Prasad Kale <prasad.kale@live.com>
Cc: Dan Murphy <dmurphy@ti.com>, Sean Anderson <seanga2@gmail.com>, 
 Anshul Dalal <anshuld@ti.com>
In-Reply-To: <YT2P288MB00915176E3C7F2F72F4C2A879BFBA@YT2P288MB0091.CANP288.PROD.OUTLOOK.COM>
References: <YT2P288MB00915176E3C7F2F72F4C2A879BFBA@YT2P288MB0091.CANP288.PROD.OUTLOOK.COM>
Subject: Re: [PATCH] Invalidate cached FAT device upon boot error
Message-Id: <176244838981.3056677.4621192779217217053.b4-ty@konsulko.com>
Date: Thu, 06 Nov 2025 10:59:49 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On Thu, 30 Oct 2025 22:33:01 +0530, Prasad Kale wrote:

> When spl boot device list has multiple FAT devices, any previousely
> registered FAT device should be deregistered before registering
> next FAT boot device, otherwise the function may not attempt boot
> from next FAT device.One of the situations where this issue can be
> observed is when the boot device list has two FAT partitions of a
> memory device and if booting fails on first partition (because of
> file or partition related errors), boot from next partition actually
> gets attempted on previous boot device only, as the previous device
> has remained marked as registered. Call the function that invalidates
> cached boot device in case of failure in booting from current FAT
> boot device.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] Invalidate cached FAT device upon boot error
      commit: c488907f91ec90bb6a93803b1db53e24b93b52ea
-- 
Tom


