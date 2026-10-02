Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BC45CA5FC4
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 16:36:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C63CE812CF;
	Fri,  2 Oct 2026 16:36:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aiPZT_Lul2u1; Fri,  2 Oct 2026 16:36:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 1DB308131B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790958974;
	b=PbFJdsN8u3rsPolR/d3IQTSLUSPLJwhs0GhOtlNAYCBQvjKqFUxJVBAToY83HsQLXKu6
	 w9wecv8quTDq9whae0VVvYXzK2i8L6mGVEIEM0i4KzOucxch4QI704No9c6ZV8+A7Zblu
	 SqVcj/ke0btwRG/YKDHwaF974Ye+VW+sG5ZLEaVGbhRe+5d8+HwIf7yLPePdG1DFfmcbH
	 RApeXd/hirYsjdW7XJJyiOJrhVT0/9r27cxiNHlt/VRjf8wHckaENT0c58fdr/LbxJSSK
	 4Knl9v/iosb5WgzY5inEFISQH3D4ToI1EK0WOdSNPwl5PUEH1F8HfAy28Su80uv/jRQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790958974;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Sender:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=nL52/LGN2PD5uXv5pWvd7aBxwvRwuWnN1+MmzWND2wc=;
	b=BuxSKQXtIgP3IXcTjKnWWHoL1IvhwC2zw2eeMVwPEKl1EVNdaOrgL+O9fjjnx3qX/3jP
	 iA4GNFC1vu8RQcX5DJENYihHFvU0U/hhg+P6BEdF0KJd94K48GbGXuyt7M1MHzyj/d7P/
	 HBdflBdxLUr05UlAATCI9w/Zo051NfItdWc/VVtgLOROdsVZVLaE2ms/gV3MQQIPss1ng
	 xbWihtRsSFTNsh15NRDN3x1BOkouBvlreOgyJD81hlBCzTQo1BA/ajoGST+H6ZzCaQngH
	 HbYsHT/kSnx/sv0b7y/aZwUmdteErX0s5uWlbwD+GESiezkhsccVqWWMx583YTk87SA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=APHyYTAD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790958974;
	bh=nL52/LGN2PD5uXv5pWvd7aBxwvRwuWnN1+MmzWND2wc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ClzbtMluD5BN1IVGVpmW7seEI7WbXnK0LCUPhk4scCDUqKIxUh6GrrjVG1ODCiPxf
	 Z86X9dgsKcVZXnzG9pMJfoBRPH76pIUwmkFV8C+dnc5O2BPLHVvQCFuycsPnbsTukR
	 h7w6NhoVWkknDgNAyiSE6pizECrHN1B0z9j7h2Xa2rM+6TwHfOechCURqiynQkCpUS
	 Cu6xXBCN0XjfWvZE4jfxcK2mkpOCqPXJWnPY1dZnzwhzjKdSoxZ9N8fRGtlqTKm4dv
	 5DbfBnDSDoVYeVrVdR98gZ71VOJ+GvDM8piZ7ZaG1VKUXWnITMgh34W2UVsEnGSHoj
	 MQffV5A2Z4mtw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1DB308131B;
	Fri,  2 Oct 2026 16:36:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9C0BB34E
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 16:36:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 78440812A0
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 16:36:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id p4OdO8nKU2Ue for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 16:36:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 7E7E981235
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790958968;
 b=XgWJ0rgsKu3+yGrCE45l34SPBnswrgkduUueN9O2vqLYwzXZPMRiORXgRLnCJ+Q6fkWj
 AnwE6Zw5m2EakKtrz1QjJSznd28VKLyqifz05Gq9rN9wlnHdE1AQeyrESPi6iJII4eVm/
 Szyo7iTu6a2nKW0C6/Lg/G9oyGEloQF8pCpEuCkthtxaQtiPM82POXzS3TRm9CrsDqqCW
 ZSf4FcDgFwMMijNPq6A/GeRHSP2fXhsE72XGHpcka7rS7d8gfA9caQTzuzTldTmmf4dx+
 yqL73oyL/tZnoFcyUekAB6Q+N/wbFGQrBHtw995hoqJnRsoe1hyp5tZuobUaAbm39ww==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790958968;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Sender:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 X-Mailer;
 bh=nL52/LGN2PD5uXv5pWvd7aBxwvRwuWnN1+MmzWND2wc=;
 b=exu9XHXNSMGqTkIdUzTjVJ/ra4+hAcrqn7Aj6+1FZe2CM08o//i5g5UfVBGPU0L4FA6S
 9NKIs0zVwkfv/AbkRp51H+nlQVKetD33ZDKu5JobRHWO+/ryUVsHqcvMVsk3H2v1HeEsA
 8PSqf0MOcq/LZuJVL8JmQ9q3ZBFEy1+PAO0B7M327UgWmwDd84UUOAMHDd/cXtFCNJuUn
 iW1l3K8nvt6kSv/dgLWCvGJwx/fPfCQntXF1miol1Hgtqp9k+WtQAJOmmT9GlbnnYm3E8
 xD8gr7ebEye3ZTyBO6h1xOETaijlz4wU09imY325EBGhbb9//cE+VFUtpmjUbF8gugA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=APHyYTAD; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com;
 envelope-from=massimo.pegorer+oss@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=APHyYTAD
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7E7E981235
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 16:36:07 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4a006d3fe83so413495e9.0
 for <u-boot@lists.u-boot-project.org>; Fri, 02 Oct 2026 09:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790958966; x=1791563766;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=nL52/LGN2PD5uXv5pWvd7aBxwvRwuWnN1+MmzWND2wc=;
 b=APHyYTADBJEXrjEpVcIXBtLmV1TH29yNVSZNlhHyoowBzbdBA66tuCiJsAC2ZVuW61
 vnIEiIcY/X4gWufCFMPN2Mmp2RUITS333338UelqveISkhqt5WCea5EVml6RKhE7olW/
 Y94TL1wgx8zfZ0bMGzA1StU16Dh8xjql6K7I9P8um70aE/1UrNUQtIssFe++u0xTwTjb
 SYf8g+RzYtFZCH5zUNAzF3fi3kZu6GoLyPgHnwVkvmCXSxqRaSMJzq2PuYUs8dgV6Fb1
 tz/9MFtou7u/TPDg3oPRubni5nkD8XHEtHyO248D52ZFjwUnEqpb8hT8uxP/SQEKZyDa
 2lLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790958966; x=1791563766;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nL52/LGN2PD5uXv5pWvd7aBxwvRwuWnN1+MmzWND2wc=;
 b=WacNT1Hi2I0nb5RgJ2eDLoFeyHP6LNGRg7TEJXNbKUgssmAkGSIp2/XLjB/XeiNBa7
 0vgUqRlOaXWe6/KXLsj3FEANzdaqzZtY0MCMrkDPlsu8cKc/GU0SqYWsr52qDypsYkAw
 L4e0jYRfN+xN/+W+2USdznZqSEGKxQzSuZWvbyItBibyzntzc8OmV0gmF5FGlTc2sZDl
 byo9uij+1JNfK/xbXm+ncg3FfMU4LWdjx7DtgTrgJ16vNKOryDG837S3BEgjqwORHmu/
 ySpPtHHIrjQnMbLVTCd1fvobza3Sw4BKOqECbgg4KSJhxVsNTRyHvCDPdyGkqyZuevld
 RxzQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByudom7EtAcxIw39wixUSEQa+T8Lzc3oGjQXXZzvoyYr3Dxt+lg1hS2NLzfvB7tFIRfoH9/5ME=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nR5w0IVait1aJrAk7iF+ARzuj6bxMLQQQn8THKSjBIglQhmrUy
 rGIJjS+Rv2ueE4/mcjBAL4EGt3RhyPWdw9si9/ReaIUn95LWYA0tIHQq
X-Gm-Gg: AYBFou0meox6nO23FuHigckYEGEKrgDwr8hbQZ+PEGZetwW8U0xcmTDrbIBVtv0P+7P
 ta3Uvt/Xb2crwJ8MupP2DZaQwVZrOtp2p/iD+HaJHHlCBExBO/msl3enqzb6+8Be38MjzGSidTA
 DTjgBsWdFF6Myzn6/Z7FxA4dX3zY5iMCck7TxcawtFwN8wgw9taZ9zS3JbKUqDNzWWUZqfG1Dbj
 YQ5LOBiD+d9mATIiHC2ImhX0xdcBRD6uYLJUAvD4Sx+pXkEWBKUkk6MpQMrte43+EtsLkECItQ5
 ks8ddusn784JMRBdg4/RXInQCnauPxIJK9ZHQUxsR7G03QXGugH4Pcr0N6o8wQc47kT1/6MNQ8T
 H9jnTGZygGdbxNBnWykycLSJbzM7ViXZIEXFVyS0uChf6P+3uMDvj+oYmMyuAY3lLsNBEyIOBeK
 15SBGbc9Hyl4pK33Ii1DJT5gu5rMNMcAW+a9IPfeN9HpbLxIpYXsvcG0FfzjjDIn10noLYbpHvS
 8rtebkuJw==
X-Received: by 2002:a05:600c:ad7:b0:49c:f13d:ffed with SMTP id
 5b1f17b1804b1-4a01eb4c01dmr99615955e9.17.1790958965812; 
 Fri, 02 Oct 2026 09:36:05 -0700 (PDT)
Received: from [127.0.1.1] ([151.51.234.237]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b382f9ae1sm7135338f8f.39.2026.10.02.09.36.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 09:36:05 -0700 (PDT)
Sender: Massimo Pegorer <massimo.pegorer@gmail.com>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Fri, 02 Oct 2026 18:36:00 +0200
Subject: [PATCH 3/4] arm: rockchip: Avoid BSS SPL config options when unneeded
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-config-v1-3-11bb20983682@gmail.com>
References: <20261002-config-v1-0-11bb20983682@gmail.com>
In-Reply-To: <20261002-config-v1-0-11bb20983682@gmail.com>
To: Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org, 
 Quentin Schulz <u-boot@0leil.net>
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>
X-Mailer: b4 0.15.2
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

The configuration options SPL_BSS_START_ADDR and SPL_BSS_MAX_SIZE are
guarded by SPL_HAS_BSS_LINKER_SECTION and SPL_BSS_LIMIT options in the
common/spl/Kconfig file where they are originally defined. Addition of
a second config statement without 'depends on' guard causes these two
options to be put in the configuration even when the guard is not
selected, which is unneeded and sounds wrong.

Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
---
 arch/arm/mach-rockchip/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index 1a2e7847c9e..5ed774159be 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -836,11 +836,13 @@ config SPL_HAS_BSS_LINKER_SECTION
 	default y if ARM64
 
 config SPL_BSS_START_ADDR
+	depends on SPL_HAS_BSS_LINKER_SECTION
 	default 0x63f80000 if SPL_TEXT_BASE = 0x60000000
 	default 0x43f80000 if SPL_TEXT_BASE = 0x40000000
 	default 0x03f80000 if SPL_TEXT_BASE = 0x00000000
 
 config SPL_BSS_MAX_SIZE
+	depends on SPL_BSS_LIMIT
 	default 0x8000 if SPL_BSS_START_ADDR = 0x63f80000
 	default 0x8000 if SPL_BSS_START_ADDR = 0x43f80000
 	default 0x8000 if SPL_BSS_START_ADDR = 0x03f80000

-- 
2.34.1

