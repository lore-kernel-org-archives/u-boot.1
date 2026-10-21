Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10FD606A31B
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 12:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=YX55O9fJ;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=dGJSIp43
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9B30A60A40;
	Wed, 21 Oct 2026 12:48:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oIYYDmxDASFS; Wed, 21 Oct 2026 12:48:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6F6A4607E4
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792586892;
	b=af95zw6Zh1n1j0Ys01qImg/gsp721H3qIoeTqIFLOM2dNoi1oOYeh6RKjRxET2CGvyJz
	 2wQvaqAss20u4P2aJr8RR6PlonWOMvQzaMTL+/a4fdZ1rqdaM5MAKRsettw51yiu9VtTZ
	 ePo8/wC/xk1oAeD9pP+fTvKGZJCNigTYuElXZ9R1xwYhehCT36nmaR/R/wPcCQcEPqC2n
	 E6Kcp0uztBjvydLnqmzz41vwUvlFKwB91iQ8xNCmw6lpfcLJvgPEij0eFtE/sbquQ5IVa
	 fOODQNuGNMtaghEPBuLB3cfgNPRNJq0ibIyvbBPLJm2efwMG6+0h6p+Y0TrN8WqKJXQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792586892;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=Wq1F1e1qlfRLaU6PM9fnElp5/geMQmxuJe1/yjscuSg=;
	b=lAC1k4BzkCTvVnFKbflAdqRJITz4gj6Hg2bEvplb9ZizTV/IA3Cq42YZqTy/bzcAOE5L
	 kaLijJpUgSrjK79acc60lNFPcCsFEiF3DtrfvADjkXtcn2nsOCl+9LC50iDcGYnnPbXmQ
	 6jBeZxwOmvxWNueZfcEGuYlIVMggbGjqGir9qrBDwQm3Q8ZiDHU/OB9lBj7luarRRu3RN
	 v+rr+iIoJ6VjEl5K171f0yiUxSKwLS+Q/C9ZMWRyBULYmQGYLIOv7Fv7bk3UJ7Nhdbh3q
	 LxsqGl1hcumaAWCFAJRiAZlS4vUYYeAanwwKwW2Mz8cbTx2jcXC5t3cXgGOA+jF021Q==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=dGJSIp43;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792586892;
	bh=Wq1F1e1qlfRLaU6PM9fnElp5/geMQmxuJe1/yjscuSg=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YX55O9fJ9VRbZfgBPk3TR13NYPtQI93vn4hHYPxLn1XP9Q4XZdLScU0tJeRyS9+wa
	 T/vBdU/DmKlzmNkSOhhcinw18SOXb/bAPmnuktOqP5ATDAkJ1BoLobhhqm5LIfhy9S
	 bzvT4aPvO0whX8aZfSrmH+wVh+zpXl9DWEEJYqnO9WT/YkywdtKaQi4GHYymbW6RIR
	 f1jSCCKgCEbrURiJtcguYI0ORhLGruF7QD+cvmb9HtGrXpkBrziq+8YWpUff98Tq5Y
	 aVjp4I+COaT0n0DpreNsIa3DJErlmcqBqVXcrfUXMVQqKGibSRNuFb2Cs2r/fHWa2P
	 6KEnmUo194cGg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6F6A4607E4;
	Wed, 21 Oct 2026 12:48:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id C1C4623A
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 12:48:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7F7656090B
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 12:48:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qe6InDetahrr for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 12:48:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1EDA8608F0
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52a"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792586886;
 b=slMg7MlZ/1eqdYadlw6ggOIzEyXBRMu+JI/UeKqFNTuNyvsjb3W8NbZr1FWYr3g+VD+g
 qef6b/3xLaQlv0XAI0r2vOehve3waXIe0JZSzW3dy7eaxUslGzv3rrlFy5/PR7Dab21eO
 I1SdixiMbW9OKBcXeHVQII4PvesT2MzWlWtXXp2D5frz4oZ27eioH27pQUZ8cq1JVQsv4
 tQzpJ6d61a2X0zJVqDcQ4MMfBBuHzdpDyRK/3MSMBNT4njQjHvglofGLQISCSfUdnP6Z5
 Ny7tKvuEQ8Mjn3fBtdsZ8nk9spVeJWlksEOabL8QpnF0v5WlTqpHpdWs9E8SC2F5P4Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792586886;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=Wq1F1e1qlfRLaU6PM9fnElp5/geMQmxuJe1/yjscuSg=;
 b=OyFFvU6ybGoGe1/FbdfEdRY3ZmVHJDsGP8Pcpdi7x2zoh+w9Cd0m8AFetBVCEZrFFV2B
 tk7gJD1/YjoNq44odY9iwS6BPp1FEzUsbw9kBtgNKvZMI94IPAbogX06oglbBGS46ACZ4
 CLEKCFC1ywzbOpjPiiIuSq7LwWXNai5eOfUkbc+LqF4FC6hJ+YdKPA15fz5WI2AvLcuWo
 ZhI45XlndX6GW7XwoNMryv5RJxRhl7PgVDONGaJU1mNVrnxAx+AtcB1ynSdrKhgPtYCyy
 vQjuaqpJwSV1HcNvyGnmBt+FNjVfbbsZebDkysO97iVBcoiIEIm53l44aG6y++S5Wxg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=dGJSIp43; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52a; helo=mail-ed1-x52a.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=dGJSIp43
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1EDA8608F0
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 12:48:05 +0000 (UTC)
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-6b1a86c0316so696389a12.0
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 05:48:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792586884; cv=none;
 d=google.com; s=arc-20260327;
 b=INEcrk7xpxjZ28xEIN6ng4xTOfZRnqTx2GrbmvUPZSaJOb4pURjRaWeNtEJZvEp8CV
 SiDd7deNRfY6nWHqOXJUP0wH5GUdtlSteBPwf4C/ZR2NnOrPaUJPi69mYRPu9/fGMB0f
 FILKnvqz4yOzZ4Gdkwr9HFFbxfvnPbVTv8qcTYAnslTWbQjFGDHRp0TUG0M7G0QASi/3
 Nd6XNO0g70NzeCiikBLTRWSGGfbSCbe83wsAY2M5IGH28w1XgYOkhL9x8XVYzle6Im6a
 u4+D3ZxnrCktCSkDo6Am3rHSR/TEiX+nYk6yF7RInmaw9B/Aj1BLITOYkN+lEJAZToaJ
 KV+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=Wq1F1e1qlfRLaU6PM9fnElp5/geMQmxuJe1/yjscuSg=;
 fh=oGO8v79Mbn/z8u0mZJ8gK0eJhwQrj/M4AgjffxTjAZs=;
 b=SeIH+mo/USXuCNe47a/IDJSDiGu7fm06/UojCG3G2G3NvSa4vN/lkMHJSKW4eY3RNE
 hMdH8kEDxtAWBx2HmndKJA6FsLtOntMYXOkhX6OETSpffVR8DSIxb/apuWx+KWluj/ml
 4qeZbOI9VlpMUJzSATwLY+5HsDnHhJ591q0uoX7ggmSSnxQ5BpB0yz5pN9hK+7k1Pl7w
 tDMe/rInITuL9TG0T7eTQF3d5RF6t4JpA0dRd4yDHhYIBl2KCi0EbLHTjvfJjeUrJVah
 PX7xvB2AZWHg/3t9sFwGfqaLe/Jmn5eYnZG10CV/TAwkpQFHy5Po8Jt6LT+xphn1ObAB
 ft6g==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792586884; x=1793191684;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Wq1F1e1qlfRLaU6PM9fnElp5/geMQmxuJe1/yjscuSg=;
 b=dGJSIp439Gmp18b3oRxJsucMtd2Q01ydzCN8uZ6iqYlARatr2Pv8SCltaEt9b/46aF
 KusZL39gCqMsBuDQGD4qtoZ43MOZK5sifijDUsILJ7viRLhC+O4AHJzfqtLiw9mCLRdd
 mhpNpTGMOHJv5Xtah6JjDu/FBm1vPtaGaxJQs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792586884; x=1793191684;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Wq1F1e1qlfRLaU6PM9fnElp5/geMQmxuJe1/yjscuSg=;
 b=sVNMvyRxx+tmeLYJF2ummB9HzvlvfEPnLVfTBzz7gDAQFA+VCliNoV0Ww23CMmnVpr
 LuvYkoDIDGK06x6JeFvd4JeWfm9jlBg9vK168DiT6jLz3ekG5sb1S89S9t9VF8GA/tro
 9b6lR16HgvM8i0ptxmO8hIeGAE7QJK9oUmlTom8xSlRzAIm8H0Xy7O6dG8ODNwTOX1qp
 J69Tvm7DepsNUm1rfurVEUAyebxAjhh1d8bLR03j038nu6OyNizRaaW2ullREVyqJGMW
 SEafrIwAgtSCwluZIOquk3hsj5qsm6D2azeb9yoUEABA3N753jvRwf/iBRoUvUgbEe/E
 SLdA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzS6FxH4y13IKyjdFq1O4ADJo/XT+TQyJnCIPozqfHT1MWrJfrN/vqpfVrU6jgt5dMuSv6pocM=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIfOGSgqqSPclvKA6m4Hkuk3row25wR6zLNWcCe636nZufdsVA7
 0Yc8nqXYmJXN4AledW6W2Wlmy1LybyMNmmynpqCjZDepACqUhL84X5fGUVMeF3q6p5InDYZaXH1
 RGRp8NabSFaV+2KVEo0VhXH90Rd6QUsfyrRAYJehr
X-Gm-Gg: AYBFou1dBnYFdS2HnOYMpTLkJSQKPhs+Hd8THULnvu1lRIkZICw2Y2vyevBNY7PaO7u
 YEmNoWDVy86ZRQ6wvmp4vXQqSfneEMU2qIk3Cxp9VAPgOu6lb2JDFPBoVXe5o1TWLQGOFoEYQCN
 on68RnmMf4uX6m4extdlRmy6VAMDpPxAStiwHqMDwaGtpKXnZQFOezNMxsIgeOR+VMFmw0jZof5
 FisGnjLBKKqZNaIpVjqZy5+aRy1fgeV6ZuMX4KzW3he04vcN916DHNJl/K8O6B9FgCrCIgctQ7t
 4TDRQEf6jZnv+3E2NvpRPvWjYNG0vRM5heftxRtIPojOU5CPEUKZ+LKtUqjlHLIO591dALjdcR0
 u9na2+Jd1RxfLnZ/7HAjVAjKczTd8Fx9eSlw=
X-Received: by 2002:a05:6402:3605:b0:6ac:6b18:345b with SMTP id
 4fb4d7f45d1cf-6b408e93cf8mr1325090a12.17.1792586883667; Wed, 21 Oct 2026
 05:48:03 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 21 Oct 2026 12:48:01 +0000
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 21 Oct 2026 11:40:37 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260902211501.127915-5-bhargavdas100@gmail.com>
References: <20260902211501.127915-1-bhargavdas100@gmail.com>
 <20260902211501.127915-5-bhargavdas100@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 21 Oct 2026 12:48:01 +0000
X-Gm-Features: AclHuK-qiTEcdUM0ma_8yvwYwp4nvHe91g_0GU26cXo8XreJcMU5F5hDFM6pSYM
Message-ID: <CAFLszTi9BYb2x1OzGn-zuGJg2k6-FgjXYU=Y6uymLh2B5xsX+Q@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] arm: rp2350: Add driver for RP2350 hardware timers
To: bhargavdas100@gmail.com
Cc: u-boot@lists.denx.de, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Bhargav,

On 2026-09-02T21:14:48, Bhargav Das <bhargavdas100@gmail.com> wrote:
> arm: rp2350: Add driver for RP2350 hardware timers
>
> Implement a Driver Model (DM) timer driver for the RP2350 SoC.
>
> Previously, CONFIG_TIMER was enabled purely to satisfy compilation and
> linker requirements. Because the platform relied on generic fallback
> definitions, invoking the `timer` command or any timing-related
> operation (such as delays or timeouts) caused the system to crash.
>
> The early system tick generation is initialized in mach-rp2xxx/rp2350.c
> before the main driver probes. Both timer0 and timer1 have been verified
> to work correctly. Enabled timer0 by default in the device tree.

Please use the imperative ('Enable timer0...') and drop the backticks.

>
> The early system tick generation is initialized in mach-rp2xxx/rp2350.c
> before the main driver probes. Both timer0 and timer1 have been verified
> to work correctly. Enabled timer0 by default in the device tree.
>
> Signed-off-by: Bhargav Das <bhargavdas100@gmail.com>
>
>  arch/arm/dts/rp2350-pico2.dts             |  4 ++
>  arch/arm/dts/rp2350.dtsi                  | 14 +++++++
>  arch/arm/include/asm/arch-rp2xxx/rp2350.h | 17 ++++++++-
>  arch/arm/mach-rp2xxx/rp2350.c             | 31 ++++++++++++++++
>  configs/rpi_pico2_defconfig               |  1 +
>  drivers/timer/Kconfig                     |  8 ++++
>  drivers/timer/Makefile                    |  1 +
>  drivers/timer/rp2350_timer.c              | 62 +++++++++++++++++++++++++++++++
>  8 files changed, 137 insertions(+), 1 deletion(-)

> diff --git a/arch/arm/dts/rp2350.dtsi b/arch/arm/dts/rp2350.dtsi
> @@ -33,5 +33,19 @@
> +		timer0: timer@400b0000 {
> +			compatible = "raspberrypi,rp2350-timer";
> +			reg = <0x400b0000 0x1000>;
> +			clock-frequency = <1000000>;	/* 1MHz microsecond tick */
> +			status = "disabled";
> +		};

Without bootph-all the timer is not bound before relocation, so if
anything calls udelay() or get_timer() in board_init_f(),
dm_timer_init() fails and get_ticks() panics. It may be fine today,
but it is easy to trip over, so it would be worth adding bootph-all
(or bootph-pre-ram).

> diff --git a/arch/arm/mach-rp2xxx/rp2350.c b/arch/arm/mach-rp2xxx/rp2350.c
> @@ -190,6 +190,35 @@ void rp2350_uart_early_init(void)
> +void rp2350_timer_init(void)
> +{
> +	struct rp2350_resets_regs *resets = RP2350_RESETS;
> +
> +	/* Release TIMER0 from reset */
> +	rp2350_reg_clr(&resets->reset, RESETS_RESET_TIMER0);
> +	rp2350_wait_reset_done(RESETS_RESET_TIMER0);
> +
> +	/* Release TIMER1 from reset */
> +	rp2350_reg_clr(&resets->reset, RESETS_RESET_TIMER1);
> +	rp2350_wait_reset_done(RESETS_RESET_TIMER1);
> +
> +	/* Start the TIMER0 tick generator at 1MHz */
> +	writel(RP2350_XOSC_HZ / 1000000, RP2350_TICKS_BASE + RP2350_TICKS_TIMER0_CYCLES);
> +	writel(TICKS_CTRL_ENABLE, RP2350_TICKS_BASE + RP2350_TICKS_TIMER0_CTRL);
> +
> +	/* Start the TIMER1 tick generator at 1MHz */
> +	writel(RP2350_XOSC_HZ / 1000000, RP2350_TICKS_BASE + RP2350_TICKS_TIMER1_CYCLES);
> +	writel(TICKS_CTRL_ENABLE, RP2350_TICKS_BASE + RP2350_TICKS_TIMER1_CTRL);
> +}

This starts both timers and both tick generators unconditionally,
though only timer0 is enabled in the DT. The 1MHz rate is also
hard-coded twice, here and in the clock-frequency property, so neither
can change without the other. I suggest doing this in
rp2350_timer_probe() for the timer being probed only, computing CYCLES
from the uclass clock_rate (which the uclass already reads from
clock-frequency). Then rp2350_timer_init() and its call in
rp2350_soc_init() can go. What do you think?

> diff --git a/arch/arm/mach-rp2xxx/rp2350.c b/arch/arm/mach-rp2xxx/rp2350.c
> @@ -210,4 +239,6 @@ void rp2350_soc_init(void)
> +	/* Start the 1MHz microsecond timer (TIMER0) */
> +	rp2350_timer_init();

The comment says TIMER0, but this starts both timers.

> diff --git a/drivers/timer/rp2350_timer.c b/drivers/timer/rp2350_timer.c
> @@ -0,0 +1,62 @@
> +	priv->base = dev_read_addr_ptr(dev);
> +	if (!priv->base)
> +		return -EINVAL;

Once the reset and tick set-up moves here, the reset bit and TICKS
offsets need to come from somewhere other than the hard-coded
TIMER0/TIMER1 macros. The driver data in rp2350_timer_ids[] or a
resets/ticks index in the DT would do it.

Regards,
Simon
