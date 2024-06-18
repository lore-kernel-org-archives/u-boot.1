Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB834C27C4F
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 14:53:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31A2788365;
	Tue, 18 Jun 2024 16:53:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="a9JTVC3D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAC1688363; Tue, 18 Jun 2024 16:53:22 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9D31880F5
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 16:53:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-6f96f8489feso3122400a34.0
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 07:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718722399; x=1719327199; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ih/2KKDGDoDzbe53aYoZcAkNzRSMUDOJFrP9DR0dFN8=;
 b=a9JTVC3D1zCVBgDSG6CcCrNv2fI2pxS9FVljdu/cmdBxamTKSwNrzkgWkZksBeTR7o
 rKmpAZITMcXVKSjFnb1IKrWNdHVJNrdL5nZeITKaCci73Yi089nITNV73aa+wD3Qxh6E
 DY54k2A3wopbTbcj7HgWIPLU/67Ef+yQowXnI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718722399; x=1719327199;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ih/2KKDGDoDzbe53aYoZcAkNzRSMUDOJFrP9DR0dFN8=;
 b=oQdZojEkRItWXZJNi/CdfsZh1LRdVlhsyX43+BhHD35ERL4r5JNIMRHjZ+I841VBKV
 NHr/BDkG222OEOj1QNxf6WiHrZRhbWqiNz3LJKx49C6H6gIySMfs+nZl1OPOoHLbToVS
 iKayFdSEOPh2qpvilOMtroSY/HnkJQN5cP+tTevu92t4jfY2uFQlapcSLnsZeequXl9U
 TdDqjfWjnAeg3NA6cKAbQTHzUhzTmGh1/pOfD9lJLSJwt2/+VCGIKLT9zgyIHYf6+2Wr
 M18EA1BAOEPbOtX2kGCnwnF2xPmtXdDeE627f/MwRiElHQ+Lp5RFiOgDzwGUWOD6clIs
 T16Q==
X-Gm-Message-State: AOJu0YwJPGFEvvMQqLZdzi33K3UhsUhlveiX8C+X/NVwDqCAjfLzSPy/
 V4NzD7EIM180tgRdtdUO0Kb08ZZlkj6JaHv/doG4Uh+ehDQK/an9FLmBkZF/3kg3DaUwJ7s64+p
 NWFLHfg==
X-Google-Smtp-Source: AGHT+IGqN6ypb+TQWFiGtcOVxQIdqjSFNcKlruVe48+yuv9rbsJ5M1wzB2dwV/ak5ctfau8qBmPD7g==
X-Received: by 2002:a05:6870:1716:b0:254:9ec6:c8cd with SMTP id
 586e51a60fabf-25c948ec852mr20266fac.7.1718722399397; 
 Tue, 18 Jun 2024 07:53:19 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-45.totalplay.net.
 [187.190.205.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2567a94b7besm3202888fac.6.2024.06.18.07.53.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jun 2024 07:53:19 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240605013742.576403-1-trini@konsulko.com>
References: <20240605013742.576403-1-trini@konsulko.com>
Subject: Re: [PATCH 1/3] efi_loader: select BLK not depends on BLK
Message-Id: <171872239876.3307069.2225464519713333435.b4-ty@konsulko.com>
Date: Tue, 18 Jun 2024 08:53:18 -0600
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

On Tue, 04 Jun 2024 19:37:40 -0600, Tom Rini wrote:

> The BLK symbol is used both for "we have a block device subsystem
> enabled" and "we need to utilize the block device library functions". In
> the case of efi_loader, it is the case of "we need to utilize the block
> device library", so select rather than depends on it. In turn, also
> disable EFI_LOADER on platforms which did not have it on previously due
> to a lack of block devices. They can enable it themselves if desired.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


