Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F105CC52D7D
	for <u-boot@archiver.kernel.org>; Fri, 16 Aug 2024 03:47:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C189188AFF;
	Fri, 16 Aug 2024 05:47:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OoMnsfaV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2378488B06; Fri, 16 Aug 2024 05:47:30 +0200 (CEST)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 163F288ADB
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 05:47:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3db18842a4dso1373685b6e.0
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 20:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1723780046; x=1724384846; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bDHyMM9iMDjEhFOcBX2WncMH0WickGIHcWFjvO9euWw=;
 b=OoMnsfaVUoMpX+YtAgTRT2r/t358mtGHgxU2Q1MiSSc98qgTsw9RRXQLID5+suNbzL
 MZuabYbiUsh9kJ2nDdhKb/NmZkpdQDKkJwjhlMeUo1gxg3teTOGv0/E6/3x+hJX8aHpp
 n2E+AwNwLFYfeKk3GzcyglAvi8HQLDqCZhdMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723780046; x=1724384846;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bDHyMM9iMDjEhFOcBX2WncMH0WickGIHcWFjvO9euWw=;
 b=c42CxSFLEdbN+v5nE3fE6DPEKGBfxQt57cVqSdQJdivceHb0Eaep+w8fk6+bQeeKej
 F1eCZord7UClgYrVdx3ig9X+IJ5IYQP6xyCqaWomrpIqmSTeQtlZMHISjPlG+EmEhJuI
 J3+ewcfyFTrJV38ovcEnPZ5PKuJoYNm5lv0WkJgqDZ09OQGXioFQu27hqBq/cCSulv/+
 u9VKmc0JB0nZMK5Wqh4GBayzpTaWCTXbw0aTRQa63p2TlVruiEusbFMi9cFWZXXTQQhi
 MMSXcpoX2pDqd35zikBLrl2SzEBYYmXpMBPSjQFv4hfsO0qmD+6bjq4RVRkcGSzEBPo/
 hmlw==
X-Gm-Message-State: AOJu0YxdWfjZLdX++ge5huLnVCOag+pKa5MihYReL7Y+ZInX/k01SSyb
 mk9mf7VTOvDEwXbjrcuV6Pi7XcwXhBn3k/sweyQkboMgM18cqL9/YpzjA3gdA3I=
X-Google-Smtp-Source: AGHT+IEvnn7JoAa1Pr0evTjuIZzFOVpFbYk28S1VJVWTC1rVO1DmXmSGu6LkYAAjEHuuw1OfYUoTJg==
X-Received: by 2002:a05:6808:18a0:b0:3dd:8f4:403b with SMTP id
 5614622812f47-3dd3176ad5emr2155650b6e.24.1723780046560; 
 Thu, 15 Aug 2024 20:47:26 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-236.totalplay.net.
 [189.203.97.236]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5da8cd69811sm541522eaf.4.2024.08.15.20.47.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 20:47:26 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Richard Weinberger <richard@nod.at>
Cc: upstream+uboot@sigma-star.at, marek.vasut+renesas@mailbox.org, 
 eugeneuriev@gmail.com, bmeng.cn@gmail.com, sjg@chromium.org
In-Reply-To: <20240802100846.16619-1-richard@nod.at>
References: <20240802100846.16619-1-richard@nod.at>
Subject: Re: [PATCH 1/4] x86: Fix ptrdiff_t for x86_64
Message-Id: <172378004556.3540666.8333053758596725110.b4-ty@konsulko.com>
Date: Thu, 15 Aug 2024 21:47:25 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Fri, 02 Aug 2024 12:08:43 +0200, Richard Weinberger wrote:

> sbrk() assumes ptrdiff_t is large enough to enlarge/shrink the heap
> by LONG_MIN/LONG_MAX.
> So, use the long type, also to match the rest of the Linux ecosystem.
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


