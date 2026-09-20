Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EC96C982E1
	for <u-boot@archiver.kernel.org>; Sun, 20 Sep 2026 15:49:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 58A2340DA6;
	Sun, 20 Sep 2026 15:49:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iPq3RYiYWB8A; Sun, 20 Sep 2026 15:49:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org E769440E20
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789919364;
	b=G0vGJRasuFbakTYrXscWnw3GTZxe9a6v8wKDcuCsiqkRrVWIZ/D9o99AxxmyIu7q+vbh
	 lZhSV9rlWED9J/XX+lBgP9oFv7O3WGmKc1Alb6EkoVUagFloGPaPYeDbOMh9DMLAIxzRe
	 L/0sU3iynFPBR/yhj7hcUpk1AFg0nbCWX4KgqcSmuD9G2tUAkRhOJTCduSW8n0R7lqIBn
	 AZKiq+tTqDRyLxk2M3NAmXf6L7rEFhNg93m/9aoaXuNd1143I2LzNbRziV37yPSMpODbB
	 Z3VpScX3QUy3vOPswe+cWt7YhTQCbNC/cguLG1rZ+XQBn2/5rVkHC9FARIb/kdkbHIw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789919364;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Sender:From:Subject:
	 Date:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=t0xNPY414gmS710B+2VBGddtrSGRTnRHqfHxFovRC+w=;
	b=Qwy+iXMdDHUi9/teKMaPrvxSJXYc72tzjVKseAC2uN/x6XBEsRYEt5qW6YhBrQKBspSS
	 F5ZC5FY7pU5EtFFiUWodWN8gLTlhtlhboWg4QcniIjiPYmQF0oK0xNJ/Cvd5D3CPGPy5D
	 jB5V9j4nDxVQXnmpHU9sO1ILyCuzsHBBtMTjRG2CgiKClS7l/Ys/3v9TuD6HL/bkRFABd
	 3Lr1UYQ3Fi//TR+5Pa3PjVQChdylI8tIFNRWBMsX1s1cdFPYEJByraGj5J6BKlGZtiqhw
	 gazzqPnzw95EaaDRBOG2PFNBXB4sIg5nnvN8MVBt4FXyxvT5HOPrbjEjX9bmtbd5Baw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789919364;
	bh=t0xNPY414gmS710B+2VBGddtrSGRTnRHqfHxFovRC+w=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=MawDQpJL5U52oCQ4yJZWFzlQyOdewDIQpsQAMTzZWNUuYOvCtQdoa0AWihoJuEl8p
	 fSvhn00Cs8349AdLiKZ7gY5Wu8PB701GsR8XeL0DzD6Xft3mMEEyqlc0zdpLpRH06N
	 sOMwkK6w7KCSjPCVG60gtf8x1KGJFXPSV+VoanSGXnZwMVYbsApv/CofzSBghR20BC
	 e/42crTQOdz9bDZbeuJLUxpIeIiayw5iwfzM5kRoa14JP3deb43DRh30JV53y2/Sz8
	 dbJDHaS7O+BqOz4pmajg5O5GpejG1cmEX8On0WbJjkAxi0J+RzFk2k2JieI26Q9G6p
	 ex0o48i9DqDNA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E769440E20;
	Sun, 20 Sep 2026 15:49:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id DFF8C37A
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 14:16:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D128780F19
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 14:16:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3xXFc8owAyRS for <u-boot@lists.u-boot-project.org>;
 Sun, 20 Sep 2026 14:16:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 7D57B80F15
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789913773;
 b=B7DXKX/jVNymhomvEHTHmT1UhtoTKcyJtLyh3G/oKzv2WxlNGrZeIABtWrCpEa8R+C5D
 9xCPiqkr3oUsaGoTdwtVQYvseIYE2+8SuU+WuoG7xxbrnK1NPhakp/I/XgcTWZxcPwecI
 Wq4p9xbDEaVb7kPN/+ZJ7U02jSDCF2MggMrHWiCy3ea/OkQKu0M6tQ/5i2bcQd/igMxjQ
 GV6oZGZ5x3rgc+qSxhvVbS2I1B0U/wIRQqnCj7FyFffapj55NHYTnJwnohplvbIqpMhJd
 G4nJLDqODxPRNFRM+tEAVvjQH5t3SLZqTUMuEVUE41ELrh0bw4hYvAMfulkZX2s9kuQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789913773;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Sender:From:Subject:Date:Message-Id:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
 bh=t0xNPY414gmS710B+2VBGddtrSGRTnRHqfHxFovRC+w=;
 b=IMe8T1wprq/hEJ1xzH4BsPoEEukHbuVYJvVBhVflv/5gAf9fjFUqwTSF9G+F5riMHhuR
 BZdyhPRSsGUVuxqSQ9j5CvnufE+ezSDYpZezdK17PeHFlHIffnemxx9HwGGLOcrn1//rB
 9TTQas8jIMWkhUo97YqB/FfJJrk/gX08kFhBL50Ji3XCnxYHbVSKut06FDIUqwuOzK0ye
 EBpo1NI+7P8YsW9qMl4flc/zC70Uv/Ig8Tm1YWTW0ZgR6o4Iyy9D3Ggty0e8bE97R3b7U
 U5A1f/ZSriW+6BQO03z8BAHKptnhK9hieow8NOL9LWnWunPwz6+QW5OULEm4z9EZu3A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=qv8XgOS6; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com;
 envelope-from=massimo.pegorer+oss@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=qv8XgOS6
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7D57B80F15
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 14:16:12 +0000 (UTC)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49b912d37b6so9197355e9.0
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 07:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789913771; x=1790518571;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=t0xNPY414gmS710B+2VBGddtrSGRTnRHqfHxFovRC+w=;
 b=qv8XgOS6IsFpWZmWY72AefBEBJb/+7Plch4Nvqqz0GBhnBZ4n5gUC+EbmnlyjWKBaw
 Ipsc/j1aJYHHC7iL4goFCA5aGhdKEHz4qLKft+7DtVGwYurRPHSue7kOJ3sQPObpq+wB
 cYcinR0ey6naWgKoNQYoO4kN7SkjDLoZ94t4hYAZdNfzB8mt2Qf7wVU/TohAz6JtTAYJ
 GcIgWukM4hl0JNq4txLWg8TTqeGX3MleNHAoPisfRssFoLiAzTHtPU7+WIf+MPy4fHRN
 FUKMzbATvfsEJFZxd0AXT8632ZOEMAcqvdlj1x+4xDXBXckIIMn7nVJzGX4fUQehw/Vq
 vaog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789913771; x=1790518571;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:sender:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=t0xNPY414gmS710B+2VBGddtrSGRTnRHqfHxFovRC+w=;
 b=Bqiwpf5p0f6tjfrBsYrxLT3UqwJVuFvjNFmJaCDQ3EPu8KhfxyVbchvvACxI7MCaQD
 /ABDZlhtLKOw7IFISCbv3Tq3rNBmFBsRSep16l88We+MvXFEUt/7/dwl82SViu41jbwh
 a9feZG2xhqqmrXBMJIJjdJ9q0niB09WHKZXRy8ZYvRIGPK9gSZo+GeG6C7agpigDGO00
 ciIbeqdfSHSA/o9riJAPcb6FSOkDXojnuPFkl2kIdqgV3SKx8vQ+d7JOjp8qIBECWrVv
 YJ5rj3mndWBQAJY7ogGe75F+N+aZgwqyP/KcU/DjR6LnCp0/DzyVI0vjt14FY3xdMKAR
 UR8A==
X-Forwarded-Encrypted: i=1;
 AKwUvBxhoBWmSS4/isxHLghr+6lnPfAwrkBJgardjtfMwFblksuFPvquOJdDJigWA5oF6SwVg6YIwlU=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kXVJfmaf/EHORmVvZFiRhECk3c7ibOJ5DSB8g0/RHPxmFXqMj9
 p/WewgXiuon9xdwCQ348ojd1TUBOzGlj2YlAo573+ZNKQQWaGO1DJv8M
X-Gm-Gg: AYBFou3ou7KOvNNNLthN21dyRhSySC/5aFGsVXQBKBAjK4+PTAoJV53RYfX5uLvTnfL
 YRco95yEOZpuD0luUk9kyO1YigU5TfSdGvlxmy0Pai4PX1Jj1LIPQDsIpPUb6cbcSMxttU9JSn9
 HRwtbtAZN4uzqSds9DKXGmeV0mVxDzFPsx4xP00xky2sjZge+fXOixJiAhWy7DEXp/cYNk1Qr8c
 PvCqtkAqyodndb5qwD46a1G4vSCYAqhpVQHN6TiTUq3X4NB+WvCy566Bglv0ogAE2dqiJ12hGKE
 njbAgnHRXqOiUhpRUwNpuq32QFvMumnaUU82IJpAdOYE4y+Hga5q0Q7MMkg1rhrMbZBe92mRZSQ
 6/h/FHLq6RjO2M/1SMydttPc2D+ztnxrXjziIEzy0OHwh6vsGygWKJQOj4Fj05j0vJi2haovosl
 2cxlPscUGaJKgUnS2fMhHnOh9C46Xns5YuYPegBgWrRl8W//p28HDWX9+U/ON1mK4/qy2z9F5Sj
 JzUU89G
X-Received: by 2002:a05:600c:3b09:b0:49f:ce78:356c with SMTP id
 5b1f17b1804b1-49fce7836c8mr53193055e9.29.1789913770702; 
 Sun, 20 Sep 2026 07:16:10 -0700 (PDT)
Received: from [127.0.1.1] ([151.51.151.34]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fc57547easm184107005e9.3.2026.09.20.07.16.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2026 07:16:10 -0700 (PDT)
Sender: Massimo Pegorer <massimo.pegorer@gmail.com>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Subject: [PATCH RFC 00/11] rockchip: SoC info and reset cause printouts
Date: Sun, 20 Sep 2026 16:15:44 +0200
Message-Id: <20260920-reset-v1-0-42820216369f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJDqr2oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDSwML3aLU4tQS3VQzy0QTgxTjNNNkMyWg2oKi1LTMCrA50UpBbs5KsRD
 B4tKkrNTkEpAJSrW1AAPFzgBuAAAA
X-Change-ID: 20260908-reset-e69a40d3f5c6
To: Simon Glass <sjg@chromium.org>, Quentin Schulz <u-boot@0leil.net>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Kever Yang <kever.yang@rock-chips.com>, Lukasz Majewski <lukma@denx.de>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Heiko Schocher <hs@nabladev.com>, Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Levin Du <djw@t-chip.com.cn>, 
 Suniel Mahesh <sunil@amarulasolutions.com>, 
 Alexey Charkov <alchark@flipper.net>, Fabio Estevam <festevam@nabladev.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Chris Morgan <macromorgan@hotmail.com>, 
 Coia Prant <coiaprant@gmail.com>, 
 Frank Wunderlich <frank-w@public-files.de>, Andy Yan <andyshrk@163.com>, 
 Liangbin Lian <jjm2473@gmail.com>, Joseph Chen <chenjh@rock-chips.com>, 
 Tianling Shen <cnsztl@gmail.com>, Klaus Goger <klaus.goger@cherry.de>, 
 Heiko Stuebner <heiko.stuebner@cherry.de>, 
 Jacobe Zang <jacobe.zang@wesion.com>, Jiehui He <jiehui.he@foxmail.com>, 
 John Clark <inindev@gmail.com>, Sebastian Kropatsch <seb-dev@mail.de>, 
 Jagan Teki <jagan@edgeble.ai>, Ilya Katsnelson <me@0upti.me>, 
 Niu Zhihong <zhihong@nzhnb.com>, 
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>, 
 Tom Fitzhenry <tom@tom-fitzhenry.me.uk>, 
 Akash Gajjar <gajjar04akash@gmail.com>, 
 Maxim Moskalets <maximmosk4@gmail.com>, FUKAUMI Naoki <naoki@radxa.com>, 
 Eugen Hristev <ehristev@kernel.org>, 
 Jianfeng Liu <liujianfeng1994@gmail.com>, 
 Elon Zhang <zhangzj@rock-chips.com>, Joshua Riek <jjriek@verizon.net>, 
 Martin Herren <sputnik@on-the-web.ch>, Torsten Duwe <duwe@lst.de>, 
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Sun, 20 Sep 2026 15:49:13 +0000
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

Looking to provide a way to print reset cause on a board equipped with
a PX30 SoC I ran into the following existing issues related to Rockchip
SoCs:

1. It is not possible to select DISPLAY_CPUINFO configuration option
   with ARCH_ROCKCHIP, except for RK3399 RK3288 RK3568 RK3588 SoCs, due
   to incomplete definition of type 'struct rockchip_cru' caused by
   Rockchip common implementation of print_cpuinfo() function: see
   0f9872c4db11 for the RK3588 SoC "workaround", which I feel not
   optimal. Note that DISPLAY_CPUINFO has default y if ARM; therefore,
   it is deselected in each Rockchip defconfig except for listed SoCs.

2. It is not possible to deselect DISPLAY_CPUINFO configuration option
   with TARGET_ROC_PC_RK3399 due to missing get_reset_cause() symbol
   caused by mach-rockchip/Makefile skipping cpu-info.c. I do not see
   how e230c579a3f6 commit separated the reset cause from displaying
   cpuinfo as proposed.

3. For the most recent Rockchip SoCs (RK3588 RK3576 RK3568 RK3528 RK3506
   RK3308 PX30) the checkboard() function is implemented at mach level
   to print SoC information: it overrides the weak empty implementation
   called by show_board_info() when DISPLAY_BOARDINFO(_LATE) option is
   selected.

   Most of the other machs do not provide a checkboard() implementation
   leaving symbol available for overriding at board level. I did not
   find any "regulatory" definition in the documentation, but SoC info
   sounds to me more related to CPUINFO than to BOARDINFO, and other
   machs approach in my opinion seems more consistent with the function
   and configuration option names (checkboard and DISPLAY_BOARDINFO).
   Moreover, this approach has the advantage of allowing each board to
   implement its own checkboard() if needed (other hooks exist for
   board specific printout, of course).

4. Implementation of get_reset_cause() cannot be common in Rockchip mach
   due to different CRU_GLB_RST_ST register definitions from SoC to SoC:
   RK3288 and RK3399 share the same one, but RK3568 and RK3588 ones have
   more bit flags defined (and not all of them seem mutually exclusive),
   and PX30 and RK3308 common one differs again having WDT and TSADC bit
   flags swapped.

Here is my proposal, awaiting your comments and feedback:

1. Create a Rockchip common print_cpuinfo() suitable for any SoC/board,
   making possible DISPLAY_CPUINFO selection without build issues.

2. Avoid DISPLAY_CPUINFO deselection causes build issues for any board.

3. Make print_cpuinfo() to execute code that is currently in function
   named checkboard() at SoC level (if implemented), which prints more
   info than CONFIG_SYS_SOC. Of course, keep printing CONFIG_SYS_SOC if
   function is unavailable and on returning error.

4. Make print_cpuinfo() to execute code to get the SoC reset cause and
   to print its description if the reset cause is available.

5. Avoid DISPLAY_BOARDINFO(_LATE) printing the same SoC info now printed
   by DISPLAY_CPUINFO too: it seems redundant and quite misleading. This
   makes checkboard() implementation at Rockchip mach level unnecessary:
   remove it and leave the overriding option available for board level
   implementation if needed.

6. Select DISPLAY_CPUINFO in all Rockchip board configurations related
   to PX30 RK3308 and any RK35xx (all the SoCs that were providing a
   checkboard() implementation) that already have the DISPLAY_BOARDINFO
   and/or the DISPLAY_BOARDINFO_LATE option selected, to keep SoC info
   printout. BTW they are all of PX30 RK3308 and RK35xx board configs.

The whole series has been built with buildman for all of the involved
board configurations, i.e. those related to PX30 RK3288 RK3308 RK3399
RK35xx.

---
Massimo Pegorer (11):
      arm: rockchip: include SoC-specific CRU header file
      rockchip: cru: move code from header to source file
      rockchip: cru: remove unnecessary common cru.h file
      rockchip: cru: improve and simplify reset cause handling
      arm: rockchip: support DISPLAY_CPUINFO on all Rockchip SoC
      arm: rockchip: unbind cpu-info.c from DISPLAY_CPUINFO
      arm: rockchip: print SoC detailed info with DISPLAY_CPUINFO
      arm: rockchip: print reset cause only when available
      arm: rockchip: do not print SoC info with DISPLAY_BOARDINFO
      configs: rockchip: resync Anbernic RG-DS with savedefconfig
      configs: rockchip: add DISPLAY_CPUINFO to keep SoC info print

 arch/arm/include/asm/arch-rockchip/clock.h      | 11 +++++
 arch/arm/include/asm/arch-rockchip/cru.h        | 39 ----------------
 arch/arm/include/asm/arch-rockchip/cru_rk3399.h |  1 +
 arch/arm/mach-rockchip/Makefile                 |  2 +-
 arch/arm/mach-rockchip/cpu-info.c               | 61 ++++++++++++-------------
 arch/arm/mach-rockchip/px30/px30.c              | 12 ++---
 arch/arm/mach-rockchip/rk3288/clk_rk3288.c      | 37 ++++++++++++++-
 arch/arm/mach-rockchip/rk3288/rk3288.c          |  2 +-
 arch/arm/mach-rockchip/rk3308/rk3308.c          |  2 +-
 arch/arm/mach-rockchip/rk3399/clk_rk3399.c      | 37 ++++++++++++++-
 arch/arm/mach-rockchip/rk3399/rk3399.c          |  2 +-
 arch/arm/mach-rockchip/rk3506/rk3506.c          | 10 ++--
 arch/arm/mach-rockchip/rk3528/rk3528.c          | 10 ++--
 arch/arm/mach-rockchip/rk3568/clk_rk3568.c      | 35 ++++++++++++++
 arch/arm/mach-rockchip/rk3568/rk3568.c          | 12 ++---
 arch/arm/mach-rockchip/rk3576/rk3576.c          | 10 ++--
 arch/arm/mach-rockchip/rk3588/clk_rk3588.c      | 35 ++++++++++++++
 arch/arm/mach-rockchip/rk3588/rk3588.c          | 10 ++--
 board/firefly/roc-pc-rk3399/roc-pc-rk3399.c     |  4 +-
 configs/9tripod-x3568-v4-rk3568_defconfig       |  1 -
 configs/anbernic-rg-ds-rk3568_defconfig         |  6 ---
 configs/anbernic-rgxx3-rk3566_defconfig         |  1 -
 configs/bpi-r2-pro-rk3568_defconfig             |  1 -
 configs/cm3588-nas-rk3588_defconfig             |  1 -
 configs/coolpi-4b-rk3588s_defconfig             |  1 -
 configs/coolpi-cm5-evb-rk3588_defconfig         |  1 -
 configs/coolpi-cm5-genbook-rk3588_defconfig     |  1 -
 configs/easepi-r1-rk3568_defconfig              |  1 -
 configs/evb-px30_defconfig                      |  1 -
 configs/evb-rk3308_defconfig                    |  1 -
 configs/evb-rk3568_defconfig                    |  1 -
 configs/evb-rk3588_defconfig                    |  1 -
 configs/fastrhino-r66s-rk3568_defconfig         |  1 -
 configs/firefly-px30_defconfig                  |  1 -
 configs/gameforce-ace-rk3588s_defconfig         |  1 -
 configs/generic-rk3528_defconfig                |  1 -
 configs/generic-rk3568_defconfig                |  1 -
 configs/generic-rk3576_defconfig                |  1 -
 configs/generic-rk3588_defconfig                |  1 -
 configs/jaguar-rk3588_defconfig                 |  1 -
 configs/khadas-edge2-rk3588s_defconfig          |  1 -
 configs/lckfb-tspi-rk3566_defconfig             |  1 -
 configs/lubancat-2-rk3568_defconfig             |  1 -
 configs/mnt-reform2-rk3588_defconfig            |  1 -
 configs/nanopc-t6-rk3588_defconfig              |  1 -
 configs/nanopi-m5-rk3576_defconfig              |  1 -
 configs/nanopi-r3s-rk3566_defconfig             |  1 -
 configs/nanopi-r5c-rk3568_defconfig             |  1 -
 configs/nanopi-r5s-rk3568_defconfig             |  1 -
 configs/nanopi-r6c-rk3588s_defconfig            |  1 -
 configs/nanopi-r6s-rk3588s_defconfig            |  1 -
 configs/nanopi-r76s-rk3576_defconfig            |  1 -
 configs/nanopi-zero2-rk3528_defconfig           |  1 -
 configs/neu6a-io-rk3588_defconfig               |  1 -
 configs/neu6b-io-rk3588_defconfig               |  1 -
 configs/nova-rk3588s_defconfig                  |  1 -
 configs/odroid-go2_defconfig                    |  1 -
 configs/odroid-m1-rk3568_defconfig              |  1 -
 configs/odroid-m1s-rk3566_defconfig             |  1 -
 configs/odroid-m2-rk3588s_defconfig             |  1 -
 configs/omni3576-rk3576_defconfig               |  1 -
 configs/orangepi-3b-rk3566_defconfig            |  1 -
 configs/orangepi-5-max-rk3588_defconfig         |  1 -
 configs/orangepi-5-plus-rk3588_defconfig        |  1 -
 configs/orangepi-5-rk3588s_defconfig            |  1 -
 configs/orangepi-5-ultra-rk3588_defconfig       |  1 -
 configs/pinetab2-rk3566_defconfig               |  1 -
 configs/powkiddy-x55-rk3566_defconfig           |  1 -
 configs/px30-core-ctouch2-of10-px30_defconfig   |  1 -
 configs/px30-core-ctouch2-px30_defconfig        |  1 -
 configs/px30-core-edimm2.2-px30_defconfig       |  1 -
 configs/qnap-ts433-rk3568_defconfig             |  1 -
 configs/quartz64-a-rk3566_defconfig             |  1 -
 configs/quartz64-b-rk3566_defconfig             |  1 -
 configs/quartzpro64-rk3588_defconfig            |  1 -
 configs/radxa-cm3-io-rk3566_defconfig           |  1 -
 configs/radxa-e20c-rk3528_defconfig             |  1 -
 configs/radxa-e25-rk3568_defconfig              |  1 -
 configs/radxa-zero-3-rk3566_defconfig           |  1 -
 configs/ringneck-px30_defconfig                 |  1 -
 configs/roc-cc-rk3308_defconfig                 |  1 -
 configs/roc-pc-rk3576_defconfig                 |  1 -
 configs/roc-pc-rk3588s_defconfig                |  1 -
 configs/rock-2-rk3528_defconfig                 |  1 -
 configs/rock-3a-rk3568_defconfig                |  1 -
 configs/rock-3b-rk3568_defconfig                |  1 -
 configs/rock-3c-rk3566_defconfig                |  1 -
 configs/rock-4d-rk3576_defconfig                |  1 -
 configs/rock-5-itx-rk3588_defconfig             |  1 -
 configs/rock-5c-rk3588s_defconfig               |  1 -
 configs/rock-pi-s-rk3308_defconfig              |  1 -
 configs/rock-s0-rk3308_defconfig                |  1 -
 configs/rock5a-rk3588s_defconfig                |  1 -
 configs/rock5b-rk3588_defconfig                 |  1 -
 configs/sige1-rk3528_defconfig                  |  1 -
 configs/sige5-rk3576_defconfig                  |  1 -
 configs/sige7-rk3588_defconfig                  |  1 -
 configs/soquartz-blade-rk3566_defconfig         |  1 -
 configs/soquartz-cm4-rk3566_defconfig           |  1 -
 configs/soquartz-model-a-rk3566_defconfig       |  1 -
 configs/tiger-rk3588_defconfig                  |  1 -
 configs/toybrick-rk3588_defconfig               |  1 -
 configs/turing-rk1-rk3588_defconfig             |  1 -
 drivers/clk/rockchip/clk_rk3288.c               |  2 +-
 drivers/clk/rockchip/clk_rk3399.c               |  2 +-
 drivers/ram/rockchip/sdram_rk3288.c             |  2 +-
 drivers/ram/rockchip/sdram_rk3399.c             |  2 +-
 drivers/video/rockchip/rk3288_mipi.c            |  2 +-
 drivers/video/rockchip/rk3399_mipi.c            |  2 +-
 drivers/video/rockchip/rk_mipi.c                |  2 +-
 110 files changed, 229 insertions(+), 206 deletions(-)
---
base-commit: b8e0086b585791a771416ce51b58ce0097bc0b28
change-id: 20260908-reset-e69a40d3f5c6

Best regards,
--  
Massimo Pegorer <massimo.pegorer+oss@gmail.com>

