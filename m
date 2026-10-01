Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D223CCA5FB3
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 08:20:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6D35A60B94;
	Thu,  1 Oct 2026 08:20:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TDdcWhw5XViN; Thu,  1 Oct 2026 08:20:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 9AD4260BD8
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790842808;
	b=IOY4iA9/QjCjxRnjHjsZdfaNwuGL/dULYmcHf9Lmo2nVy6WbWIwFHWupqLqyn6Udra86
	 u1cgMtxi54w97j4029Lb20aW3rVJ+pxseAPzftTpvnEsOn8dsdTqlE3vDLnucZkMoIt85
	 HYXSe8yq2zegmGPV3LCtwCM4AURUABG5kP7JIY19WAhlh4Ls8ATAPiJ1wMOoK8OrPnlXL
	 8BGud3m6rhaIfEiCDEbt2YoUZDEzD63g1q9i+J7PN40IGvUZE6IIvdTZSHx1u6ryxzdNf
	 DvtcIi6MFsAUSZnbF+9TGm9iklfFqKQCjueN4vRf7goUAOaq+I9SgijWLxNcISAMakg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790842808;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=hiWBnbi9yUctfts4Yaqb4OZuMr2tXVoHMCfgqsuj0LA=;
	b=mMsm5vpEccA7AKwbe2i1HNsk9me+sqB/HpQl57GR/xmpJaXwUMa4tIySGGzIaRs0+Rkj
	 dkJ1IcTN25sAPsEzQvlETxgJwKIhdCq48RH+a5j6cT9SBc6pbJDuiEKX0s4wnRffuKNa8
	 ueotCVsgYXk+Vd/SMnzfXKYd0jlSgTjDyDaiHRDI33JV0lV8yB4ZYiEmZhKCxWiVmtQIP
	 IrzxhCbvek39K5+OIoSccPD2R/VESsneQsq4vn/bpgNcH52XbK0pB1NOCeA1nCrr4kLhn
	 Dqm0ugMgLXT1VP6cof1KRca1l2BmmJMbX4CbhUdEtEnAbFv8LjOHdFYQsq/+NpMhI8Q==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=lH5F0pR7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790842808;
	bh=hiWBnbi9yUctfts4Yaqb4OZuMr2tXVoHMCfgqsuj0LA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zRfAwV7KH3pyrXlW9AhO6hHNwG0nZPGu8gE9KD5aTIcxzgdlgGTR+hQubGWdk/A3p
	 fN0fWBj5VV8YhqcoGBKTZDtCA4kHaeK995NX2rc0mBijVMASjnrl7edt3iM/rwULOg
	 pEdoSHiAJdlryEM0EGthoM/uISVb1sx0H38oZBBEPPaFA7oPLl7Ph++yaZifTkIP/V
	 stmjxoKzGmundROZn2kRFVwd81S1tuTUaIlnL+XXzQ9x89GlqRJ0cDwWVGAGAGbi52
	 RFqcutAtcx2ReP13f3ARWEDHoUWReUG8hx2QHFYsYYgeLR3FR4Qy72xVwz/kbCCNhj
	 71pfWeVTNDsqA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9AD4260BD8;
	Thu,  1 Oct 2026 08:20:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id CF818263
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 08:20:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B54D560BD8
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 08:20:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S09BbX7xwMWZ for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 08:20:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 8DA5A60B94
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::c"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790842807;
 b=TPztmkuwP8Dr99WhVIpWxxr9UgqF/+8GehBATdIthKDEp1T+o+Q5R1CRCMKOU0YH6e91
 YWD1v8X07sMnVLCdlqDi63JUQr9ofeUkhdz/aI630FlVQbHHf3VGba0HCejXAIO51SOto
 XMzDy9WUEOYZRiWt43A6OCDWnnEDMw7N+D/IwZuifreN7bw31ZceDvqX/PewaclVY8txi
 39Od2TxEJIOpKFq2lyxMUB2GiPgTnQ8WLcvFdhoYFJI4WtXPWr04Y0yhdek0tj/uPZx6D
 /zFNXgdZcgjRLq8hNuFn4NmvbNh7uXmQsqmrGD7uenvpIEb8kYi81tlVMHSdmMJesuA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790842807;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=hiWBnbi9yUctfts4Yaqb4OZuMr2tXVoHMCfgqsuj0LA=;
 b=tZcKPhgHrlJ5xjeeLMdx+MKlQsV+hdldj6SKeClo2kHx6uZFcVUrbBpwLm72/7ULSIyi
 UXzUA6erPskVa7lod65S8gkdQm+ospaDWEduqKZGpgPJ8MSrgrGE6p7f/MUUPT26yRnkC
 RrmRI9OLGF+pizptHPcX8pf6i/MPzGJCMNjCoLlgQqIN46fpfBnvqEfxHUpAUrzlux+HX
 0iUhn4FHi5SH64JEdLbZr21YUWw3p0YMoP12d1RHvYFPKNJNw0Kom9s5YQTgSkso0YfGP
 sY+c1No7hNFybgQ6n+0K+MigJp5nm2anMa39vC0DbYJ6XDDWaxUSmbjl4GL9i46aq2w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=lH5F0pR7; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::c"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:33::c;
 helo=mail-ed2-x0c.google.com; envelope-from=sjg@chromium.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=lH5F0pR7
Received: from mail-ed2-x0c.google.com (mail-ed2-x0c.google.com
 [IPv6:2a00:1450:4864:33::c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8DA5A60B94
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 08:20:06 +0000 (UTC)
Received: by mail-ed2-x0c.google.com with SMTP id
 4fb4d7f45d1cf-6acae8342d2so4740834a12.3
 for <u-boot@lists.u-boot-project.org>; Thu, 01 Oct 2026 01:20:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790842804; cv=none;
 d=google.com; s=arc-20260327;
 b=MRSY7WFMqwnAsO9+LCMVi3D0HWj01zJulqf9FgNqf+v+KJJgVh+IfcuCMkR/ZcRp4q
 hEHrkC3U9MDLkJzzTZnxWd3R6XHyZTwvyNo22l8KBpGBWdIPuBlmAlliJsbv4kZbKJoW
 Ukuj35zvV1VZYcd5nSV70S6wk8qvpJdrELMGf1x0SGp+BUOAAUg5AIjgCizyU2AKDUCr
 tcEaL40XkdVM3d3lPggl+bc91JYqXFxwLEgoe2FnlojMbB73ipIJAvrF/Vm1T0Q8DZvh
 ynq+CiqVLVLnfR7MJYtze6YIKhKIdIoVqlQaUU52NBawfeNyr5DawagH+yh1W/p4pk4k
 AiXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=hiWBnbi9yUctfts4Yaqb4OZuMr2tXVoHMCfgqsuj0LA=;
 fh=A3QpOZMIzUL78Z6FOi15smG7qJvw83bc/2xCJs4E6Y4=;
 b=HoX/iAHr87TRoVf2R0LXkUTcRLDhNIeDhLDjl66De6vaF+Oqqe8o2dQLnEB69a12TF
 kuix/xd7GyXFYemeknHlO+pTMWorxGCRZzHrKwRAlLQD4KqtHeb/QRyPqVXsgvq+aW2v
 2cPlL6cAm6Zr+Qet8SCadeHtiQpwvDd1m9Ul3DjCVNJQENo0UxlWkiK2AMwIka3cBf6o
 aCMZxFACnBkW+j1Ubsj37HHcVclYwD7rpPRo4tZtKDbtb4APPoI/bpKVZV/aJC0Q4Tax
 aDjISVouQIJL95F9lfB27d8gDr8lVDxySeYr/BSCmJY18oSdnf987UkDCrPP24pRLsbY
 /UJA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790842804; x=1791447604;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=hiWBnbi9yUctfts4Yaqb4OZuMr2tXVoHMCfgqsuj0LA=;
 b=lH5F0pR76nV/wbMMa0xdOS2xdZJSYmzmfXESaSdUmGE6cdtQcADE4xwufbQcxy//hb
 nrLUbTWUGfvMngr6wLCKbNG2jJ06lzkD+BJN1z8ywF1ZefStzV1g8CLKTC/E8BMdeIgY
 Lzt5fYg6Mtgmiwck38qSkGDdteaSQWoGH0BSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790842804; x=1791447604;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=hiWBnbi9yUctfts4Yaqb4OZuMr2tXVoHMCfgqsuj0LA=;
 b=RAGQ3QZgsJ5umk0pB88OONV5dlRTO2LULFgJSfnyTX+/1RPznexIB//aSedsm3uP+q
 zmUeUkEfVibqApM+sAwfqFwFqaSlQlvCdXSz5+Oj1+aA5DJw1vZQ4DAF7EhfNqmWJILe
 CmKvo6gnYY1xLJ4hZbOg6F9Tig0S8nvcoGLe47msS3nWMD/V/3mhAHwaQba0sDldgkqT
 3xiEs9XwnicCQBb4NQOVnr6nBMwUc/f/oNoJ9eNmF+Hc1qKkw2ZqaolGIORck1b1cvWb
 SieIkMxJS9zeFgXyebsW9Tx3wtLCIHfbY71Qr2HIsGmUkp00V+pHb/KXt50/vsqwM83o
 Kz0Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBz9HPMxI9EBnG/rr3CcYRKm6j9VlR40dHW/ynjqthKLuGP90jMEwu5tjNkWKcmxdd0bzsFU4Zc=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLyQI3LShCzWJiIIcyK4SS5ZkMkyckRhJhaq+Odoacb0k+aaF8m
 eNJJraVo7E7RvYoAyke0Hk6+SbpZrKftCD5YKsSo+mYBoCv+suaY9mhRuMS4wb7bxtxU/6yECCA
 qpj74wywCJqUYTqFxuCNweqpUhTLnap1vviDt9NpL
X-Gm-Gg: AYBFou021TILeF5ifveU+nOw98RLuFEHun+LpQRwhJTBIOAvdHtz8cyc1uLkTwd9tS1
 IBaMZbVUDU0CndgkXeaAfjzIgXmWe3A1/HhYTQfice+dozr7gIWLa5RmAlETRJqFwVZ6sKN2fiu
 MldhejpI6RRBKavfd9ufSPLtTa9TfEJ+JEPnr/ARa8qKcy84h+unZsy976rWnUEIk/dcRbyZ5hp
 c+VolVBgdiG+syyrooJp60/4Rsy+G6DGHANKV2ZWyAVsN7OzCkKU8G4PEQ+4gRMkHdwOcBqKEuq
 OagVLRPCE97axiFd5hvKvBe4uGdwuo9D3Eck6FDqqIsJkuR+BVQfGs4m
X-Received: by 2002:a05:6402:23c3:b0:6aa:924d:8f2 with SMTP id
 4fb4d7f45d1cf-6ae199516e3mr3002470a12.28.1790842803990; Thu, 01 Oct 2026
 01:20:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260930090512.52342-1-michael.haener@siemens.com>
In-Reply-To: <20260930090512.52342-1-michael.haener@siemens.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 1 Oct 2026 09:19:52 +0100
X-Gm-Features: AclHuK8KhXgTrp5pHVWpSLUu2MMvSMZEe0AkgAptaocodCPldbfu2SD4eFkUCRo
Message-ID: <CAFLszThPOmn6Z3hA6H1r812kKdEWxtv_RV70BNW_w5U0M1TBDQ@mail.gmail.com>
Subject: Re: [PATCH] tpm: Add an option to start the TPM during init
To: michael.haener@siemens.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org
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

Hi Michael,

On 2026-09-30T09:05:12, Michael Haener <michael.haener@siemens.com> wrote:
> tpm: Add an option to start the TPM during init
>
> Add CONFIG_TPM_AUTOSTART, which runs the TPM startup and self-test
> sequence from an EVT_LAST_STAGE_INIT handler. This is the same thing the
> 'tpm autostart' command does, but it does not depend on a boot script or
> on the environment, so it cannot be skipped by a stale or edited env.
>
> Today a TPM is only started automatically when either CONFIG_MEASURED_BOOT
> is used (and then only from bootm) or when booting via EFI with
> CONFIG_EFI_TCG2_PROTOCOL. A plain booti/bootm therefore leaves the chip
> uninitialised and the OS has to start it itself, which Linux reports as
> "A TPM error (256) occurred attempting the self test". Boards have worked
> around this by putting 'tpm autostart' into their environment, see
> board/xilinx/zynqmp/zynqmp_kria.env.
>
> Boards that share one binary between variants with and without a TPM
> fitted can enable this safely: when no TPM device is found the startup is
> skipped silently.
>
> Signed-off-by: Michael Haener <michael.haener@siemens.com>
>
> drivers/tpm/Kconfig         | 15 +++++++++++++++
>  drivers/tpm/Makefile        |  1 +
>  drivers/tpm/tpm_autostart.c | 33 +++++++++++++++++++++++++++++++++
>  3 files changed, 49 insertions(+)

This seems like a good way to enable the TPM for boards that want it.
It would be good to document this somewhere, e.g. where we mention
MEASURED_BOOT

> diff --git a/drivers/tpm/tpm_autostart.c b/drivers/tpm/tpm_autostart.c
> @@ -0,0 +1,33 @@
> +     /* A board may share one binary between variants without a TPM. */
> +     ret = uclass_first_device_err(UCLASS_TPM, &dev);
> +     if (ret) {
> +             log_debug("No TPM found (err=%d)\n", ret);
> +             return 0;
> +     }

It seems odd to ignore an error in this case - if the board maintainer
says that a TPM must be present, then I would expect U-Boot to fail if
it is not.

In any case, uclass_first_device_err() also fails when the TPM is in
the devicetree but fails to probe, e.g. because of a bus or GPIO-reset
problem on a board that has the chip fitted. That is a real fault, but
log_debug() hides it. Please can you stay silent only for -ENODEV and
use log_warning() for anything else?

> diff --git a/drivers/tpm/tpm_autostart.c b/drivers/tpm/tpm_autostart.c
> @@ -0,0 +1,33 @@
> +     ret = tpm_auto_start(dev);
> +     if (ret)
> +             log_warning("TPM startup failed (err=%d)\n", ret);

tpm_auto_start() returns a u32, which may be a negative errno or a TPM
response code (e.g. TPM2_RC_INITIALIZE). A response code printed in
decimal from an int is hard to match against the spec, so please use a
u32 and %#x here, as report_return_code() does for the tpm command.

> diff --git a/drivers/tpm/tpm_autostart.c b/drivers/tpm/tpm_autostart.c
> @@ -0,0 +1,33 @@
> +EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, tpm_evt_autostart);

This is not really a driver, so lib/ (next to tpm_api.c) may be a
better home than drivers/tpm. What do you think?

Please can you enable this on sandbox and it would be nice to have a
test in test/dm/tpm.c, checking that the TPM is started after init and
that a missing TPM is handled. Your test could send the event.

A full self-test on a TPMv2 can take a noticeable time, so the help
should mention that this adds to the boot time on every boot, even
when the TPM is not used.

BTW, since the commit message mentions
board/xilinx/zynqmp/zynqmp_kria.env, you could convert that board in a
follow-up patch to show how the option is used.

Regards,
Simon
