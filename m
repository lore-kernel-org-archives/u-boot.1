Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1A14C44520
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 18:05:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 64DC2606C6;
	Mon, 20 Jul 2026 18:05:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TTG3u9WhT3ah; Mon, 20 Jul 2026 18:05:31 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9BF8560708
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784570731;
	bh=FegLAxNDuRR4YSCCV1mSzPu1oUaICxZCWZsO9mOyWdo=;
	h=References:In-Reply-To:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=pMoYzYBI38TANWdXHjPI/TJ78UiyY0zCW/9a12n3JMsHl5IdBQkpgsVmzt+Smp5DT
	 aEszUuApmsbLuYl0F1VHEBOtpiUI3m1O1t6hhkq7TIy/tCo3c9nFkyjV7l0Rh/Tzbu
	 BDDamU1XLnpcgzctyDzN1QBN8JaJcZkhyGtWrLwpaRNpDdryxOrnZpIGn3uJtvJKOH
	 CsHdobVG5jZ0WEw3LtFCcjeqouenJPdJZeBIIXXjgbnpxLe8q1zHScAeAqPZzq2dpg
	 lsSH26jDgZV4R86+6lCE1qcfXM4acMxZeEU9HFzmGIjO12ewBiH7H+0DNakcQ+wafP
	 JY5oL3Z+NfFVw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9BF8560708;
	Mon, 20 Jul 2026 18:05:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id A4280313
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 18:05:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8A714606D6
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 18:05:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tUGiypWyPaaM for <u-boot@lists.u-boot-project.org>;
 Mon, 20 Jul 2026 18:05:29 +0000 (UTC)
Received-SPF: Neutral (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 405176060E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 405176060E
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 405176060E
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 18:05:29 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3764842FC; Mon, 20 Jul 2026 20:05:27 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20BF080433
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 20:05:25 +0200 (CEST)
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-c15e03c2763so949423966b.0
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 11:05:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784570724; cv=none;
 d=google.com; s=arc-20260327;
 b=qSutCyZyIlZofBSlv9hWLTTfpLZxGnoZ/2Uhznu/LAFjTfAGJz6A8rZeoRuthELGei
 Be+jZ6CjEuef7NMVvlBz851+v5rqGtDBrpwfMKTAA24WTlhemvNHyYI36okCJf8XMnsH
 N9lRW+CoOk1QmgSFqzhbOXBMItze+crn6fH585MOJDfbsl6Fzi831u4aR7B+0YHvIvv7
 18NzRoMJrJzhdxxwchT+RMdKtvbEQD4GNuqJ9wbiTAUO64MAcJfHxpN+YMpTltvLqVBP
 eiQHa+vHGzwUX8KAuAhXpqnXhjSS84u9saVSzg4eKZ5hhGbGXN+NsGkwIbxR5IUJEgTF
 9B7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=FegLAxNDuRR4YSCCV1mSzPu1oUaICxZCWZsO9mOyWdo=;
 fh=S5IsS0p2q/mDhy6CofKU3XdI4SX18ALJnocWEeQR4Xw=;
 b=ImRk4VNTBHk8oatUqq3tKoAms/7mBnIxJ2uOlUwf9w9LqFehas4WtG3U5vMF0SoGdb
 46EdOV5lGB6vx429REe15DuIi3uh2UxQ9y0F9PYpRvDfoHsF2o/LQQgnkTgZt5dTkPfC
 dC41ek9b8oA22x4N+IUv+NlefGoyL3xun5mvoHwCuguYue6VH9C1PvF2iNnMWXZWCssa
 c6auFvMrixs6E1GQ/mSGazD2mzBzc5ajFdB7q7XfJ9aKF//YWdcnRCeM9r95l25xMoKl
 /h0Psr46b95CStwev2f3CvEFhPEclc/AOuHWJbRiiVtu45h8r3OOtKHnBnxf9PmxSso4
 a8CQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784570724; x=1785175524;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=FegLAxNDuRR4YSCCV1mSzPu1oUaICxZCWZsO9mOyWdo=;
 b=eISVmfSS5/B1xxP0/nihg9Hk14yI1w4h4OMyqK2FfT+K+dWIlQYfOnOtVRXSEDLRpw
 eyJfMOGgY6D5YnMPj0BFBzznWpJwy1ZmU0ddD6BIMyF4tgRZq6p3Ev5fA/s8BVy7jouI
 Z+3c6B9qZkTLsjqjUJlvPoTONLhAbHa1Lh0vy6LpecfjOOZE74CoSa2P+xcMPGaUmMBf
 n6RjFzTV6qQHHw3mqsIUybWLtA2o0cVJZ9FyYTmIf/yGhBPUdT7BHd0HC9Bi4mxxNzG1
 vKH4MlnBco/qB/+7Lt0ev22hQ7E/nNBF4u9Qedxr7nU+RuatOq5xBO9qQzeaJQRqpm0k
 NtaA==
X-Gm-Message-State: AOJu0Yy8F7zPCiDKP2K8LTX4DF1ufl3/4h21SahNPoTHEe8MRco3H+S+
 ElKCTSUeE5ArYdREJet5MggH073XmCG0lkR58dSyqtVudHtif1DaIocm4pY03PJ7r3ugRSH+9xd
 3xnH6kqh+cBXSiFzW2kSyHaItz4t0N/4ebPafVu0i755GzJDswDc=
X-Gm-Gg: AfdE7ckMcu3w3x44YPJ+AjensZuHbRw6MHU6SKb1hG0HqiuB6OV2lRFz2gC5Ty306et
 Igv7ITL1k5jn1pW0hqcMCeTFgMSA8CEvztR3FIFDB4KArVsEEeGn8z/1nWs7DH4VuGMiPRJuprJ
 TpNGT9QJ86VWStAe/gMFogQXKGCp7KpYq9EE3NSnGPpszHr63ZQk45EoUAYwQpiUDULDwZhwvrT
 WqHIbg97Atrw/WgYSw/gx0ogfavGffE0VzLqPtf4d2KSf8eKeqt4jzWBTt+
X-Received: by 2002:a17:907:3e93:b0:c12:b68f:1a72 with SMTP id
 a640c23a62f3a-c169240e51fmr880983166b.24.1784570724583; Mon, 20 Jul 2026
 11:05:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260713-rk3576-boost-v1-0-9d23aa08f674@flipper.net>
 <20260713-rk3576-boost-v1-4-9d23aa08f674@flipper.net>
In-Reply-To: <20260713-rk3576-boost-v1-4-9d23aa08f674@flipper.net>
Date: Mon, 20 Jul 2026 12:05:05 -0600
X-Gm-Features: AUfX_mwEc0VGfz8DFq847YkPiPRFcGBgYVhJ9OHwUSpCy28Pg4gh4I4CesusQ0k
Message-ID: <CAFLszTiOhpH1b9=_WbSBSQjMjbLcWUj-kieM8NqOnFhSRuf6sA@mail.gmail.com>
Subject: Re: [PATCH 4/7] rockchip: mkimage: Add option to change image offset
 alignment
To: alchark@flipper.net
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>, 
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Tom Rini <trini@konsulko.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Xuhui Lin <xuhui.lin@rock-chips.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1784570724; x=1785175524; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FegLAxNDuRR4YSCCV1mSzPu1oUaICxZCWZsO9mOyWdo=;
 b=MEaUEFX+Tc1Mngj+65CzQ1hneynrRh/x8KyTod32JJ/vd1sNtHEgrYD/qKCY3cYcwf
 PP/szp3IADsH7AmhuG7/cyU23x2nJpz9SvdssRDC8qgDAX2ZKdJWNKgX2aRjQS0lYTKI
 o4fPhCzSVzTcHLUqMTD2bGgEQ53aFO2Qsm0mY=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=MEaUEFX+
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=sjg@chromium.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=chromium.org header.i=@chromium.org header.b="MEaUEFX+";
 dkim-atps=neutral
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
From: Simon Glass via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Simon Glass <sjg@chromium.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Jonas,

On 2026-07-13T10:02:41, Alexey Charkov <alchark@flipper.net> wrote:
> rockchip: mkimage: Add option to change image offset alignment
>
> The vendor boot_merger tool support a ALIGN parameter that is used to
> define offset alignment of the embedded images.
>
> Vendor use this for RK3576 to change offset alignment from the common
> 2 KiB to 4 KiB, presumably it may have something to do with UFS.
> Testing with eMMC has shown that using a 512-byte alignment also work.
>
> Add support for overriding offset alignment in case this is needed for
> e.g. RK3576 in the future.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
>
> tools/rkcommon.c | 75 ++++++++++++++++++++++++++++++++++++--------------------
>  tools/rkcommon.h |  2 --
>  2 files changed, 49 insertions(+), 28 deletions(-)

> diff --git a/tools/rkcommon.c b/tools/rkcommon.c
> @@ -140,6 +140,7 @@ struct spl_info {
>       const uint32_t spl_size;
>       const bool spl_rc4;
>       const uint32_t header_ver;
> +     const uint32_t align;
>  };

The struct comment above documents each member, so please can you add
an @align line too, mentioning the units (512-byte blocks, matching the
vendor ALIGN parameter) and that 0 means the default 2 KiB alignment?

> diff --git a/tools/rkcommon.c b/tools/rkcommon.c
> @@ -625,7 +647,7 @@ int rkcommon_vrec_header(struct image_tool_params *params,
>        * 4 bytes of these images can safely be overwritten using the
>        * boot magic.
>        */
> -     tparams->header_size = RK_SPL_HDR_START;
> +     tparams->header_size = rkcommon_get_header_size(params);

The comment above this line still says "The header is always at 0x800",
but that is exactly what this patch changes - with an align override
the payload moves to 0x1000, as happens for rk3576 later in the series.
Please can you update it to say the header size depends on the header
version and the per-SoC alignment?

Regards,
Simon
