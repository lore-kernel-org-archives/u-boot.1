Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82165C369DC
	for <u-boot@archiver.kernel.org>; Sun,  4 May 2025 20:49:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2E2C80EE5;
	Sun,  4 May 2025 22:49:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MlqTLitX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4BC880F03; Sun,  4 May 2025 22:49:49 +0200 (CEST)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C6198091A
 for <u-boot@lists.denx.de>; Sun,  4 May 2025 22:49:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-40356cb3352so935740b6e.1
 for <u-boot@lists.denx.de>; Sun, 04 May 2025 13:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746391786; x=1746996586; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IwhE1GDNN485x2xxfpe7xkLNucJYHq0T/0Hg/mEGUMI=;
 b=MlqTLitX9BhCs60E+ykIFWMRprvGKDYuf2NpY0gqi0QDMgmbCQyp67ED9jv3btaFBh
 Hk9099681L825CKpA3sgpJOBRJ6M2ziYBKrOQnqOxV1gf5KsRFsTF/dOkgz/DsOsZbDA
 GkT4yh0JoeTnbBWz7cryit1nYluzh/XxhLDB4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746391786; x=1746996586;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IwhE1GDNN485x2xxfpe7xkLNucJYHq0T/0Hg/mEGUMI=;
 b=hsMEWLYPbV0nj8tanUhGHAXc4zmm5GOR67VokgBUJ1OS/mfUAg5u2vkZx08tDAdVqy
 QyJokAzClaCyAd6J/2giOWWbox2MF2GQvBSD8NKItQl+oEMSiQP8vieGDNxe7UdBJseP
 XnHn3IxjqzZJlA1zt+sCKWk3jIi1V7V561jbli91I4js2UwGoXYQPQUEi9K9nGnDGLyK
 0kDjo4+FeW8m+pLMikBbrXuISBEsxGQIcudA9lG2O8qfYAwlDiQXauBlnqdNXaeAdLyw
 sFxSWu+ve/1ZWXHFvrI/NXE2Xe6pp6eRzKihvDtP81XvqH9q5lwGtyLwRRKHEAEi38+t
 q7XA==
X-Gm-Message-State: AOJu0YzbQKu0BjJy00hRYS7hqWENZHFH8qtHezWyn1cyVtOZNlaniMx7
 GIO309M3W/Zv45trXo7+H/FvAB7S+QzhhIAZ3XlxpbeHh1zJ3LmVjYQhH6/x/K4=
X-Gm-Gg: ASbGncssU/oxVsW1fE2dh2U8o8mQAXmb3lkxR0Wpnfm9pf5wh43PzVpCHL4TNuznJJT
 XYbsLJfcWPR6aUuXa3NlGH+APLQAU4JpKA7/BIIg/EbKFcp9xKzdiRRJ6EAs265suZmijITxK+J
 C3KFR5z48bG35Skv8M9MEDn6dxMXmA8bNzQ7Ea7mwEmK8y3vF7wWBPSwwFfsJW7X7bSowcLJONP
 pZqJ+CqgEaiSOmBMiRWOPJvwL4XoRL/Gj37UMyDnOiSJsVqCCRnVm9RfxOtcmIPhnjGwJPbKvup
 Rq1RCo74lM1+ahXWyH0HJ3ccMVD7kS3RBE8zVoMZdyRH8W2EWsqm2K7zMqkXiKm2iERq0M2G3Yj
 H
X-Google-Smtp-Source: AGHT+IGS+jz9KmrwjEqwi5EHU2h3DUPrXRH85RyGOCIG2wMjQ9fyJyxeVH6C8XJjAJv1FX1MyI4THQ==
X-Received: by 2002:a05:6808:1b9b:b0:3f8:18a3:b1cc with SMTP id
 5614622812f47-40341475a4amr6833030b6e.12.1746391786082; 
 Sun, 04 May 2025 13:49:46 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4033dc82d91sm1569913b6e.44.2025.05.04.13.49.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 May 2025 13:49:45 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
In-Reply-To: <20250504194255.167587-1-marek.vasut+renesas@mailbox.org>
References: <20250504194255.167587-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PULL] u-boot-sh/master
Message-Id: <174639178469.1762039.15012274605574703543.b4-ty@konsulko.com>
Date: Sun, 04 May 2025 14:49:44 -0600
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

On Sun, 04 May 2025 21:42:38 +0200, Marek Vasut wrote:

> The following changes since commit dcea465e5e299903b889f5f426eac6d6523cbf84:
> 
>   Merge tag 'u-boot-imx-master-20250503' of https://gitlab.denx.de/u-boot/custodians/u-boot-imx (2025-05-04 08:51:43 -0600)
> 
> are available in the Git repository at:
> 
>   https://source.denx.de/u-boot/custodians/u-boot-sh.git master
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


