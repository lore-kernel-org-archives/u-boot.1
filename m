Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A80DC55165
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 13:33:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 32D0080F94;
	Thu, 30 Jul 2026 13:33:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ixe3xcdg5TM3; Thu, 30 Jul 2026 13:33:19 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 49A3980F8D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785418399;
	bh=Mqj749JhhvYc8GVptk2YYQIG1m6ocFXKyWZ6MD7R7Wg=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sCLa7ofn+G3MwIGsSPljNxjaysV5d8TwGEVPPjvaCHViVeb8MbpVU3gO3prz2rBvB
	 5DNPJlKyIGaTHneWUAYhyO8BC4LW9MJsd+pUSkY2PHj14Z3w7pIZVkVJb+b3uMroQg
	 1XYzRsTzzGS/wMUVCHTz87pU7ro/52nUaVa3ZzGStFhzVV3Kp7pmcZNStc1+qXUWjK
	 +xBhWrr6TwglQvkz+bT4ZaIplG1Q3r/N+CKxHkVOAx3CB1qJ+LYXKKajDulMkDCACn
	 QBjKF5nwzZ+uqVWjXIOR5pbuiF2lZ2AzPHuQ+ufSpNXjA/D/1Sn5yrJI9kAiNrIvyM
	 XBtwmTstrBy/A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 49A3980F8D;
	Thu, 30 Jul 2026 13:33:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 03B4D27B
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 13:33:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 014FA6085F
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 13:33:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Rd1lfhOyXioW for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 13:33:17 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::530; helo=mail-ed1-x530.google.com;
 envelope-from=jbx6244@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 0D99660601
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0D99660601
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0D99660601
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 13:33:16 +0000 (UTC)
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-69c3044e4b2so347306a12.2
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 06:33:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785418395; x=1786023195;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Mqj749JhhvYc8GVptk2YYQIG1m6ocFXKyWZ6MD7R7Wg=;
 b=dfE/wePG+d1jvloMUfirfZBmBQzl2EDImEJHc0dlGyH92Uc3Iyx7ILrBkIhi9gw2Q3
 8AGUxGIOeORH1ND8GcIe46N2aQiBhP4wSbnRouaYzHNv9nSStl516/1uaEw0BzM1eDH8
 Btmc1CgIhiJYHEJNQ0IIkAvm5CAljUbt3NS+6kpEEczwm81ZrVOcbWgaj+ogt5xf/aBa
 UjF4Oz+Z8hPZrxOhu/A8669hl59ozGFDsIKSNbvpsC1ZIZPuAepO0jeTIOxITQ0MSpBk
 7aZscEs3yhFFJdzYHfbQK5A+cc/+bwO3zHnHHlgoysNtNvZHf8Zcai8k+30vlQjdJouf
 /1gg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoSTp1ZkyZL38Xdp7hJ8QVXiiQquZCOx8YtxvYcHuR0IwWEuFQPIv5E+lL3B7hN9+hupKxl0Bw=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzDXTN0TiHlx6YeCfHbTX+TIHwa83dz4y7gJnMsgTAeXpoSdEcB
 Z03bSInk1A2QB55GMhIQ1EpNRIKkidCatu+WLDD0eQtZDVk7Ds6NAwKduPSprA==
X-Gm-Gg: AR+sD135knDAqpli0ZJLuziNSpCSFTLLcfxT+URdKOz4/A59NC3fA/1o2XmwThgUj+E
 YPh8fivSlARuZ3e0EUf0Kz3QBYH83jQSDUxhHf9jWGrUWtkIID2V60n72LTtQS+Oee7wcKwOHoL
 gn+ebGqnwkJe02tuI2KTLOCJpwy4cKGMXiNwv/szeZ2z2Tp4+vdm8YDfdlpdVmPgnawtRgkQ3z9
 ETSqo8i0kCA+Ywl/ri06qX2AvWGrXLnAlo48YM9lFefUuaMG7IRkx9I9u8OBAuETVkIVNrAUafZ
 vvm6pM1RqbuiNxC4r8YNnW8OgRfujFtWOxlqeTMZgKS+xeqfJlJK+8mF2AwBki9IQ2anZ92jQtk
 rXLCJhXdN8RxA/WGxew/8X1vxdLzH78zpbFZFI7VCVpVcFQKUF1AEiPL77blQcIPJbQZWOXqgeV
 WY36t+v5lbiyrVEEM8HXfgXuUhFmOabjbqg8JK1FzySvzz5IE/nleP7LGXgzcdDsBz683cl+2FQ
 s6vnk4wSGdfHsX8ZpWqBHqATmk=
X-Received: by 2002:a05:6402:1ed0:b0:6a0:5294:d1a7 with SMTP id
 4fb4d7f45d1cf-6a090d3b53cmr198935a12.2.1785418394922; 
 Thu, 30 Jul 2026 06:33:14 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a07d393903sm626371a12.21.2026.07.30.06.33.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jul 2026 06:33:13 -0700 (PDT)
Message-ID: <0b776c6c-038f-4f13-b95b-0c47b4df62b9@gmail.com>
Date: Thu, 30 Jul 2026 15:33:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v3 02/12] rockchip: doc: change TPL phrase
To: u-boot@0leil.net
Cc: kever.yang@rock-chips.com, sjg@chromium.org, trini@konsulko.com,
 u-boot@lists.u-boot-project.org, eddie.cai.linux@gmail.com
References: <5aed2a27-bd7d-4b71-a6c1-0b46b41f3462@gmail.com>
Content-Language: en-US, ar-EG
In-Reply-To: <5aed2a27-bd7d-4b71-a6c1-0b46b41f3462@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785418395; x=1786023195;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Mqj749JhhvYc8GVptk2YYQIG1m6ocFXKyWZ6MD7R7Wg=;
 b=EbfBk1z6Gk2T3hnzrADPoZL8HsUKUYQZf/81QE65WoLbiowWqikJENg8LbAt5CyrzZ
 bCWrQwcq2jOpPLO6tsuxXy85PyajHbCdOBUA/0VH9NHi6d7tUE2OMHJJmt72G7ffFNwJ
 ZfLkz6CIoJ18hhZeDpZuVfLUpGYFVZm079vP7hBzSJ69b6WM6khmaie7RiKASqiEwDI4
 3vMeyVMiZ8Yhbid/1op8QMeGTCQqTHCuGh9EOzW0MtV85H+yqM7V5Mp1CbYetPMWWM0k
 th44TSNPdNPtLasSfuiU4QJGBKg+dDK5V2tH3zPff3u3CD0jjVjwUHExlY4nEggJnDnm
 MvZg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=EbfBk1z6
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

The TPL phrase in rockchip.rst has some spelling and logical
problems. Rewrite and add missing structure by changing to a
list view to better separate the 2 choices the user has to make.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---

Changed V3:
add commas
---
 doc/board/rockchip/rockchip.rst | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index 9351a5b8eae7..5144cbccef78 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -219,9 +219,11 @@ For SoCs whose TF-A code is not available as open source, use BL31 binary provid
 TPL
 ^^^

-For some SoCs U-Boot sources lack of support to inizialize DRAM.
-In these cases, to get a fully functional image following :ref:`PackageWithTPLandSPL`, use DDR binary provided by Rockchip rkbin repository as ROCKCHIP_TPL when building U-Boot.
-Otherwise, follow :ref:`PackageWithRockchipMiniloader`.
+* For SoCs with U-Boot sources to initialize DRAM, follow
+  :ref:`PackageWithTPLandSPL`.
+* For SoCs without U-Boot sources to initialize DRAM use the DDR binary provided
+  by the Rockchip rkbin repository as ROCKCHIP_TPL when building U-Boot, then follow
+  :ref:`PackageWithRockchipMiniloader`.

 U-Boot
 ^^^^^^
--
2.39.5

