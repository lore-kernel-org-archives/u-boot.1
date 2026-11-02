Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E65606A324
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 22:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=dtl5JmrK;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=ZPGuJeBW
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 07D166066A;
	Mon,  2 Nov 2026 22:12:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YLexiBldDrMt; Mon,  2 Nov 2026 22:12:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 12EAE605E8
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793657532;
	b=fyTSx/W4AGkLvZdcJEOutY2q3mpoGuOFN2ewK+VZ+z3+2BGhNop2fr9O9+c9uinkPg0A
	 wv0SjIhrfqtB3UC2DqancytD16a1+bnFb+aSkzP6zlXmXB5eUJ50pHRvX0Y0ws3gtrU0o
	 v0RiEMHh4lapiRcC4kSYv8XpRelSV98af+vdqCBYzZ3WtFWMTF3IN6l9u3bTjR01zSdO9
	 PX7n5L6WAFBnGFhl5nhUb9S8Oqm9YGswHPdcXCDUbHzjBm4GflD3swcRJywmFCMNsi5Nq
	 iGrAbqTLExI8h4UX696P8DWVd9dxu8z8A02ZgvayjdcYQT7ChXIqWMn/76HupGBvXrg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793657532;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=jDn11ZXU5WlnBjGYuwukyG9WQyfpHu0R0IrlrVZMAJU=;
	b=SAelYrfki4kvZeG7eF/eQP7ygyF4bTSNNrebsIhkkS/Seebzj+/q8HQj732OSlWLgl+Y
	 Xbp4OBph0LpMVOnmnCtGu+YKBumvUDJy2iSBMdewlRYnFblarAfNfI627BCehOzn2hqOo
	 FaAmy9xZGeixJP4kQLnsZ4YL3M+dhp46mzVYUc/M48iCe7Dk7XrRlpfJ0lOOkM/shEfCC
	 oWlGYE+ArUvubLFxm/Gl44zeqwmtSe7MthN6/xzTl53CGTcWtN4qGC+cHbT7FHUyCpNm7
	 /colvj+7PvVuph20t3HjYN8FQv4W6yFNlqRw/+WVLX6f3bn1En/6Nz9nm5u52vNRwcg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793657532;
	bh=jDn11ZXU5WlnBjGYuwukyG9WQyfpHu0R0IrlrVZMAJU=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dtl5JmrKnpGRVe5LF6AfSbk5ZcLUSwwZvS8ZGbE525XzDPDyTzmM7z9ZccsYk8U9D
	 dYgYbDZL9w7+0oG9fkVHEGnUwlY/AiZDG/UxS3SRiobM1joUVwbQh6TrihST5bg5m2
	 9ewfn93OMD0DJ8XUZY1HjE4MpuV1agTGPrVW5AQMZBcOE/MVsUhCKxRIEQnFahuWrg
	 WRJm2cIPyTlr6fFW1d2AxhJDdGOSKahBqHGdP1n+Ylwo4prEaI63CX42lvROzvjVHs
	 9szkClV1PiW/47Mdvq5kqfY9+NEHsc00BHCO48gpueE+X/5PsiKWH+ffuZ96N9N+sO
	 8At8WTZtINo9w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 12EAE605E8;
	Mon,  2 Nov 2026 22:12:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id E0B6AA15
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 22:12:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D20F5400BE
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 22:12:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o8StsxT38shV for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 22:12:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org EE28F40098
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::9"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793657530;
 b=CoM8qn/+gNugHGcDz0RgF81tsvjZaRGM2pHia0ZiyiYUiWOirdDDMXRKB1r/YOqvoPZN
 RNLNQe86GY4HqOUj16vwgLYaqvxI2VWrSQyuwBXIVCCN3/XcnppCMaNcdAWKuW2FWoI9+
 0iv7CRO5UpeoioCNaeVLn8kukQ5X+M2sP/O0TR4o7IGDZS20NX75SvafmLPgvcd6X5Qh5
 n2VNmyAy6rnHkelAV3b6MtlFL2kOAr8BZJAjBDDgvGP7HK8oD9PfCoFefJ5R3f5g5B+QB
 gwXBHgIDAhxZoQBRFZqBLTA7LfdQbEGqWB2srJFumXWcRwORQ9ETLI2Ta/86uy0NunA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793657530;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:In-Reply-To:References:Subject:Message-Id:Date:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-Mailer;
 bh=jDn11ZXU5WlnBjGYuwukyG9WQyfpHu0R0IrlrVZMAJU=;
 b=U++bGwiFyp7B2kOXzVr+4lYIjILiu1xZferFXcsJP2roktwxP5paJGr9hUWFdiKdYDYY
 /bEUK6FiehqHLhQ7RXaOQqSp5boPINIuR76UFYeTlonJK3BCuACbVMO57Oj+8TrPRGQdd
 V5Jc8Cqe8MqWXY0gd6AGRlwewKg5mdK+vP/JBppKD+EJJQISDoBbijrfKgtMfreOgX5W4
 Mx1qIC+t/6czqiplCHiN0RTqaa70DuqD/6PH1D1y7bFuZZbjsGPacjf4Cp5oXS8Am1wDv
 wDG5JQACoV9k8ZEyH40WAPhktlq3WPiURVoh8C9HAOPMCTL1FqVgnBugsn/JwFKYeQA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=ZPGuJeBW; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::9"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::9;
 helo=mail-oo2-x09.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=ZPGuJeBW
Received: from mail-oo2-x09.google.com (mail-oo2-x09.google.com
 [IPv6:2607:f8b0:4864:31::9])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EE28F40098
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 22:12:09 +0000 (UTC)
Received: by mail-oo2-x09.google.com with SMTP id
 006d021491bc7-6de19ccd89bso718203eaf.0
 for <u-boot@lists.u-boot-project.org>; Mon, 02 Nov 2026 14:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793657529; x=1794262329;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jDn11ZXU5WlnBjGYuwukyG9WQyfpHu0R0IrlrVZMAJU=;
 b=ZPGuJeBWbkKuj37Ds9ZmPoeUhOnE/ydit7RlK7WRbBf+Wbsi9V3TuLsMgYOS/3fOIu
 5w0w3/KdPCSxxbQaY2k5mB31JlhcGbdHQXrWIoQdXL0VLto3PxQYFRvKYNFovMqph+7N
 9n07mkpKXbqROOKMaG+GzqR74vUHgEHCCJUrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793657529; x=1794262329;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=jDn11ZXU5WlnBjGYuwukyG9WQyfpHu0R0IrlrVZMAJU=;
 b=xlCfvO+eWQ64ZbL4PWNgLtcZZMf2UG1+E1bndKy9cfOXicdImg0lLt5n18FhtkDXcJ
 rn1WMD87fWWvoytvfEzxl3ADZh0EDsj8q1ccM3y04+vjaumz6UUvxaofWFB70pWqF17a
 vzajmZie34Rdrw/jpT1IAogmctbaPCq5ii7lfZy1czTfFVjVo7E77v5q/A3qz9iy9Xg/
 5y472tMxAUMm88YU66J7cb82ncHBY2POPrrPPQ5DSFh78s2ZSqzzt0KYy57z1vqx3zGx
 CrIcKymRffaeR5KHzZbGWHRXRz1iNSd0rznXbPQxZLQHi2tQ0q47bSKOaKSKfyvY7nxM
 nSdA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzeZLRTnDEbx3z3CPG5XzTo4tWfl3MN6Ol/p67AO8JzzBctwcNN7s4mXdNvGc/Z3xPmn5CwNQE=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLVuUDbjDyYnyB6yg1U/L/LaCpvPCIJ7x86ipq79VfTEm8EUZaG
 kai8vNNvTtd+3953IJz9rfMPtXSwZlMXuI9ttnKi2vbPiTQKryKiHRLgS+uEw2hiE1sWw2Ckz9Z
 gpdk/S8DrGFefEl4=
X-Gm-Gg: AYBFou3NU9L8tilbZyCILn2+WDoLB+e3ALWG2YAN/LRRLsIIkX2R41WebIXpEY3jOth
 KKSd3MzAerZKC6Tyxy97/YWlQbjtv0NiGL9WFIAdBva+yrCdQkKzjMBXqWM7bYJFZ0eK38bMCDu
 cDrIVbkOs3Rd7mqztGdCi518iNZiMM+SpE9QSfF+dFKn5Fjhdj1ybKSREahnS+qxsHaXSdVCESi
 dvEbU96ec0B1cSRSdPKVCmY98h5jxCFNjb7gAxkYDTtlVoXA3IRWAWJglhZv1MxAz1LAVheaHkG
 tcWTZPChX5UCESt0pjZJFdkk1IzPsRjiqvkLu6czi3pz1zkoBPwQ6gvMkX58mTKQ61kzWMKdaej
 4mvo0ClV+1Nb/9yBkPxBms3299YDT5vh0bT5QieA71dm5ZaoxetBsUBYXCYHE//3SacmiS+AhFX
 VU/3kldAEGJ60QZwhASJw8Yh4PAJ+pUvFEgh0rIrzaOcZKcE0XgkiO+Dx5lL/Zkc4GLK3LkkINk
 NVU3w9YonAdiKf5V23UFndjeT+s/izWdpE1VV5Kj+88B0cv0dXOYfbeINHVpoQF12RvPQSnDstN
 14Z5k1EonvEpci0fbORtIKjP2q4XPdn04B0hTSWVAjix6O7IcQ1og/72fuSYjddiYtj+f9xq1Bf
 yCE62hYZrywKXkbbccJGDeHHAhVRL3CgvJs+kXFujUv7EUr8jJnh1PA7M/dSU33mR5sAzJ8L3HE
 uxTp+mnipOroeZ7BiHhAspCyr0Z6lNmw==
X-Received: by 2002:a05:6820:340e:20b0:703:10f3:89f1 with SMTP id
 006d021491bc7-714f2965e33mr3868176eaf.40.1793657528717; 
 Mon, 02 Nov 2026 14:12:08 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85d354d05e0sm9796351a34.15.2026.11.02.14.12.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 14:12:08 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Anshul Dalal <anshuld@ti.com>, Simon Glass <sjg@chromium.org>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Julien Masson <jmasson@baylibre.com>, 
 Zhengping Zhang <zhengping.zhang@airoha.com>, 
 David Lechner <dlechner@baylibre.com>, Wayen Yan <win847@gmail.com>, 
 u-boot@lists.u-boot-project.org, Lukasz Majewski <lukma@nabladev.com>, 
 Christian Marangi <ansuelsmth@gmail.com>
In-Reply-To: <20261022190206.666950-1-ansuelsmth@gmail.com>
References: <20261022190206.666950-1-ansuelsmth@gmail.com>
Subject: Re: [PATCH v3 00/16] arm: airoha: add AN7583 SoC support
Message-Id: <179365752716.536289.9179925765848155755.b4-ty@konsulko.com>
Date: Mon, 02 Nov 2026 16:12:07 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 22 Oct 2026 21:01:42 +0200, Christian Marangi wrote:

> This patch series adds AN7583 SoC support. It is based on u-boot patches
> of Christian Marangi airoha openwrt branch
> 
>   https://github.com/Ansuel/openwrt/commits/main-airoha-6.12/
> 
> AN7583 is not included to upstream linux, but actively supported by
> upstream openwrt. The patches were adapted for latest U-Boot.
> 
> [...]

Applied to u-boot/main, thanks!

[01/16] dt-bindings: clock: airoha: Document support for AN7583 clock
        commit: a074405c48d8cda0b0ceed10c7e51ba511dcba36
[02/16] dt-bindings: reset: airoha: Document support for AN7583 reset
        commit: 3d2f384cbdbb89519d71d8072185ec13eb7086ea
[03/16] airoha: add support for Airoha AN7583 SoC
        commit: 67f0bfe5ce35b1c712ba8800fa4130b07f903fd6
[04/16] arm: airoha: introduce AN7583 helpers to get SCU and CHIP_SCU regmaps
        commit: 28dbc043651eb2e426f010a706eb69120f456dcb
[05/16] clk: airoha: add support for Airoha AN7583 SoC clock
        commit: c91d9d30a6f25847fb8e75a31081ea1c83b4f43c
[06/16] reset: airoha: Add support for Airoha AN7583 reset
        commit: 351414dfeb8b8b23150b2cc605c97d4c30ed320c
[07/16] net: airoha: add support for Airoha AN7583
        commit: e9d7edcd068ae33bbd7f29bb3a01c1dee44f1234
[08/16] ARM: dts: an7583: add Ethernet node
        commit: d3d644d4bc7d0e90c4b0d82de8572e12a627d462
[09/16] ARM: dts: an7583: add MMC node
        commit: a0467e7700f0eb89f2b7cd6181e8b01298dea560
[10/16] configs: an7583: add mii/mdio support
        commit: c6a541aab0bd0882b1194189f02448e3de0b0278
[11/16] ARM: dts: an7583: add mdio child node to switch node
        commit: 662e7018c5ccae2a3023fa29f9fcb151cc3b27e3
[12/16] net: airoha: add support for Airoha AN7583 PCS driver
        commit: f35d551d7c90c4883584820bc68a0b44efb8ce20
[13/16] ARM: dts: an7583: add PCS nodes
        commit: 62dfad4272919b72b6c99e50ac7b755a63d95b1c
[14/16] configs: an7583: enable PCS for Airoha AN7583
        commit: 1e3dabfc93766895c89e30aafa1383014fe12548
[15/16] net: Add support for Airoha AN7583 MDIO Controller
        commit: 69d5621eb75fffd705a806a6bcc0cbdd5d02eca4
[16/16] configs: an7583: enable MDIO_AIROHA by default
        commit: 8a37399973625005675b0f6b26a0b69a86ce1dc3
-- 
Tom


