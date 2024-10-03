Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F9D3CF34BE
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 19:23:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB08E88F44;
	Thu,  3 Oct 2024 21:23:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fKUap7OU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4E0F88F48; Thu,  3 Oct 2024 21:23:15 +0200 (CEST)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA18D88F3A
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 21:23:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-7ae6f4b1f16so7732585a.0
 for <u-boot@lists.denx.de>; Thu, 03 Oct 2024 12:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1727983392; x=1728588192; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mJgwMOtEPLkNymmayX32TFN/VhglWEgWCduOVxH1Y9I=;
 b=fKUap7OU2tfcuNw1+6XB1FS9D8baeF4wgM+8FvpAKIEnbH95Gwglw3FtDLo2oKPRBg
 580TbJjYazBut8OyMysk5+ECvTIJautzKg88uY/XH907pT4YX31iDxCaTFmh4PY0jtZI
 FVZuYxyTAeTD72A3f9lK0oVvDFid8gHVVXnBY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727983392; x=1728588192;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mJgwMOtEPLkNymmayX32TFN/VhglWEgWCduOVxH1Y9I=;
 b=xHE03ygW591cv7kO2fec0aj2hpu7IawIO299/30/D8SnQp0SrAE3owU+VAmPLV4gqw
 BLsEA38rF66Tn8uXh9eCQomFGk7N3v4uH4jsp1G1seFkKPFbgkMjtmgotySH2yg/L4wS
 O2ONBnyQNiWdE7u1JvQv5AYytlRutHbf/9CRRiCrqfCZxKw5yQ52nIbBmSCIFHwRrmij
 ZM5pLfsV5pVreVqH8RKvPdgJNVgMNwNH1Ak44FbstE8Py1gWAWqqbbRJrUEkIZOeBn6H
 b8229iBYL24NHNxCmLnlBXqHpjQ4916/PZj/jpAf1MKAeNXTIbZqOSHE2o/BLxnZkdMh
 WFbg==
X-Gm-Message-State: AOJu0YwGnPiBhc1lsQrYxqSgnuM7QW+iznLPZjGY8WNUkBEUNdFlr6fI
 hgThtvznlW52LojSH38XJb8QxlcLzZIqpUCVdfoFG+YRpe8B3SJshjMKbQ8q/oI=
X-Google-Smtp-Source: AGHT+IFy7EXjrwKSaDNCiwoJ2vgA7eQCPrrpt8HBUsS2HfCKVYtXqmcdHh3045E7nMH1KWDHYmddWg==
X-Received: by 2002:a05:620a:1923:b0:7ac:acb7:8059 with SMTP id
 af79cd13be357-7ae6f44c614mr43146585a.31.1727983392482; 
 Thu, 03 Oct 2024 12:23:12 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7ae6b29e222sm74464185a.1.2024.10.03.12.23.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2024 12:23:11 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Roman Stratiienko <r.stratiienko@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: u-boot@lists.denx.de, Guillaume La Roque <glaroque@baylibre.com>, 
 Julien Masson <jmasson@baylibre.com>
In-Reply-To: <20241003-android-fix-boot-v2-v1-1-13e8e44af4b7@baylibre.com>
References: <20241003-android-fix-boot-v2-v1-1-13e8e44af4b7@baylibre.com>
Subject: Re: [PATCH] boot: android: Fix ramdisk loading for v2 header
Message-Id: <172798338958.1632163.968986045161165335.b4-ty@konsulko.com>
Date: Thu, 03 Oct 2024 13:23:09 -0600
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

On Thu, 03 Oct 2024 14:42:39 +0200, Mattijs Korpershoek wrote:

> Before
> commit da3447d09fa0 ("android: Fix ramdisk loading for bootimage v3+"),
> the ramdisk was loaded from img_data.ramdisk_ptr, ignoring offset
> provided via mkbootimg.
> 
> commit da3447d09fa0 ("android: Fix ramdisk loading for bootimage v3+")
> rightfully fixes this by switching to use img_data.ramdisk_addr instead.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


