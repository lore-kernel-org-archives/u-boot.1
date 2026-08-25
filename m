Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FAD6C61DB9
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 18:16:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C357760706;
	Tue, 25 Aug 2026 18:16:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eNSAu5hrF-nc; Tue, 25 Aug 2026 18:16:36 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787681796;
	bh=7T6e1E2PU/XDLuK2EMaC/RR7tSIAVZie1KvJVBW9Y2Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JAU/6ndq6j439XN/cqHK0x+5JLdOlWCgEJO0GmUN4j865jO+WxOZHi6LUPWpcqGu5
	 hNrPYDtT7kgipGVAgHPI4gBsEa6F0+fNe0WFZwgcyKMb0p1T2M9WdE1MDT8mBRVAa+
	 P/PUdU5a+EE/Plzzk/PHnriYQSNcPY6g0HiMZBx5MmGf9EBrNHjhP/xkivpCh1c1m3
	 vBLbG0lbkxR4STxeqlfY4YU70IJazfOjhgJeY9sR2gGyLuE73P08QEgo1Gn84P2dWf
	 mInxPIL8MscJFxicEuLh4SyOP6YTQIjAfVakcClFRc66zKIr0d0xV4MxjehD6d6rsG
	 N0YAQ4W5PSrgw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A1E38606F6;
	Tue, 25 Aug 2026 18:16:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3A63D105
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 18:16:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 201CD606F6
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 18:16:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A7-2CgMwbv7Q for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 18:16:35 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::62e; helo=mail-pl1-x62e.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=Rujo0Ezh
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 20234606E5
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 18:16:34 +0000 (UTC)
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2ceaf8a1265so2125225ad.2
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 11:16:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787681794; cv=none;
 d=google.com; s=arc-20260327;
 b=soFzRVb0ZNqFCt4MHngxuh2pR53RBhSnZzU898FLIc2a3Gk2wQ+Sxk1o2Y/GVOqhSt
 FDL5i0hPcGPbuHIrACMlNyCMFbf96X3Xq1+Ike10Rd9WdWCECE+Q9vnbP/Wj8F8Y5PLk
 Hz7aw5oB/WRqQdNKLH7HgLBJVHf7FO7q4ZLkazgSxBBiY2e+VKqNSnTVBnR2cUVKHuXv
 S/SJ25FRHGKGc4XmrHph+3S3qSNddPePhOsCC9K+NfUQ57boGPcbATBG927uPhDnEkuy
 BvPgZngfiY2XP5+Io/2fs5u1pnS+sbEXgVcJAfvAy6h+kPU0r00tucSq9RJr6nv2BIZT
 jvWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=7T6e1E2PU/XDLuK2EMaC/RR7tSIAVZie1KvJVBW9Y2Y=;
 fh=xfnv/Ak23Gf9bCZfR9PubHxWHEbUheBWJDcNj5Q3J7Y=;
 b=VmWithGxLsS6Y5yAEgjEc+9kceOqaldySER233SqCApmrMM5jg4+HauFl2sCcEb+le
 RkZ8G0AsYdZ1YUo5oROm4Mo/eaPSGAhw53pEs0KY3uWVBBHmcld7HJFYYyF+v2SXDVBE
 +2dzEHAzFuw7RR96L21SoXa553+AaTS6c/tz9x/AQR2FtMYgsaamqpEL1O3ELNn30+VT
 SfQ0kl0M652MZj38t+63UIJDxMn6E3CXhmqKDSr+TGE3vinfaLM+jUXl16VpcGZA/xZW
 XR2inYDjUVCEmnlbZ9FqB5tZfFEjxR2jRtgp3bgO/CHPDAJO6eZCB3F5flpQjNMiyZHr
 j+GQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1787681794; x=1788286594;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=7T6e1E2PU/XDLuK2EMaC/RR7tSIAVZie1KvJVBW9Y2Y=;
 b=Rujo0EzhDpLt3t1NqJD2znnq8BrVNIQAgRkM2yRLxCn1pkKJqIGy6IRJDIlzQxuiY2
 /jn+H2VVzC7AijjUFp66YQ5wZHyE6OkqPKvw1BL0wMDdGkmufK73nBHGQ4ZfNiWcXyRs
 VKiTkd2CXD74d17Hb5846ApceEhHj55OxVO3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787681794; x=1788286594;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=7T6e1E2PU/XDLuK2EMaC/RR7tSIAVZie1KvJVBW9Y2Y=;
 b=dMiLpyDggPUUlfKR3u976/AgOI3643ItDGyvPhsxjeX3w9jdwxABOWwMl84EenmiCD
 0WXUaPmM0Pw0tPd6rvns4JPW9miP3XiUPbAWRTxYSpRbkIp/fbyuTioDAnQLHPZ6HoDf
 d7+5a18aB/1MbQMP3S4npwYDp/egO0RHqgHoWAcfqzue3b2p4kkLbs4PKbIENi19nnY5
 65zGceK5bwixzuODwmbm3OW7GGHBkB1oR3bcjRJFUPtOwwexkYVfBMJUNG2zER2Xh5gi
 rJbH19x5Q6t9ws0rbuN/zXLA8WRK/ltZ3ExsMaQtoXUAllrqbBAo1k7YiKB+ZCoAC5wT
 QeqQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpdWjwSJr3fC8uoqeYIRE52MF/F+BXFCK8zR7hXWwlTypPodq67MJtxFm3Y2dGQ0v2tgAtF2BI=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++m06mw7Wb1dQ9e7Q7V8Pw6WeCpCmKRfUmKrnqiK6PKcFvb0a8Sx
 obno+hk4FsF6QrpuqiVBQKSdu5obDNj6yGMgAsGicRUU571LKzecR2hadN8yol3DtmaqqD9LcOO
 IQByptD9qs27CfqEzo/O6qBFsW6Smh8eqyLEX6noK
X-Gm-Gg: AR+sD12DcpiCA+I66/f1c/iEc4nu9VAIdOnPstpJimoV8UrXLgrPYiK86ATS3aRUFCV
 UYbMiOz7/HpZy1UQT1hNzGUWxqbSGFdUJMh7kyJGBA518GXRupieLL6J0Nh8I/G3vd701Ajr2qK
 rTilh52fUhpbA0AJlTmZGlN1ZzIhPUzxxIHXXJ0v9Ay7P1JUUKq937klBLDLrFHT+HYFLeAj7ce
 Rm2AJv4uurNMKLEAk2Xy3tLe8Z6IPPqX8QlRXpuqFPP1qX4uFTGnKMerWC+NNPA+LbBWJulrQZJ
 SV0JWxL3Vw03HWodLRspoLAJ6M3euz4Hhtn7Vdu0FXI=
X-Received: by 2002:a17:902:f786:b0:2c9:bf82:dd11 with SMTP id
 d9443c01a7336-2d707a70d9fmr2800165ad.7.1787681793662; Tue, 25 Aug 2026
 11:16:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260820102523.1076815-1-mehmet.fide@gmail.com>
 <20260820102523.1076815-2-mehmet.fide@gmail.com>
In-Reply-To: <20260820102523.1076815-2-mehmet.fide@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 25 Aug 2026 12:16:18 -0600
X-Gm-Features: AcwNN1VrdN2ihfq41mu9LNU82eqW_4lhUsxC6ECReaV3lOhbAot5P9U6wigcUec
Message-ID: <CAFLszTgoFUjBBPEx8hzYop-2MyJ9O9b=2t8jRQ=4_9AaoCkaCA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dm: core: read the device tree into plat data
 after pinctrl
To: mehmet.fide@gmail.com
Cc: Marek Vasut <marek.vasut+usb@mailbox.org>, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org, 
 Mehmet Fide <mehmet.fide@screeningeagle.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Mehmet,

On 2026-08-20T10:25:21, Mehmet Fide <mehmet.fide@gmail.com> wrote:
> dm: core: read the device tree into plat data after pinctrl
>
> device_probe() calls device_of_to_plat() before it applies the "default"
> pinctrl state of the device, so a driver that acquires resources there
> sees them undone by the pinctrl state that follows.
>
> It has not always been that way. When the pinctrl uclass arrived in
> commit d90a5a30dec1 ("pinctrl: add pin control uclass support") the
> state was selected before ->ofdata_to_platdata() was called, and it
> stayed that way for four years. Commit 29f7d05a347a ("dm: core: Move
> ofdata_to_platdata() call earlier") then moved the call up so that the
> platform data would be read before the device is probed, which is
> reasonable in itself, but it also moved it above the pinctrl state,
> which nothing asked for.
>
> GPIOs are where this hurts. On most SoCs the direction of a pin lives in
> the GPIO block, so a pinctrl state cannot disturb it, but on Vybrid the
> output buffer enable is a bit of the pad register that pinctrl writes as
> well. A fixed regulator asks for its enable GPIO in of_to_plat(), so the
> pin is configured as an output and the pinctrl state of the same device
> then turns it back into an input. The USB host VBUS regulator of a
> Colibri VF50 is one of those: its pad reads 0x22ed once the regulator
> has been probed, the value from the device tree, output buffer disabled,
> and no USB device is ever powered.
>
> Move the call back below the pinctrl step. That is also the order Linux
> uses, and the order the board code of these boards used before the
> driver model: set the pin muxing up first, then take the pin. The
> pinctrl step itself cannot move up instead, because it relies on
> DM_FLAG_ACTIVATED having been set to break the recursion described above
> it.
>
> Nothing between the two positions needs plat data: the parent probe, the
> power domain and the pinctrl call all work off the device tree.
> [...]
>
> drivers/core/device.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Please check my comments on v1 when patchwork is back up:

https://patchwork.ozlabs.org/project/uboot/patch/20260819143543.427396-2-mehmet.fide@gmail.com/

Regards,
Simon
