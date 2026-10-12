Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C344CA9EC5
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 14:03:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 53EE380A82;
	Mon, 12 Oct 2026 14:03:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xmBT4lF1Jtoh; Mon, 12 Oct 2026 14:03:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8374C80A98
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791813781;
	b=ZlrO4UFd/twiWg1sWh3MOu+BYijoN/oM9Idr8m/+sItN0Y1BSwa9NAwbvHTh6Kuxh7/5
	 1jRi+5/bp1WF9lp7pNl93gep7acLnLhlK6lIcP3IlHKHao6v36DDb82h/+g9xOFrsFaED
	 UHu89yeLj0y+/SjssVFUDJ1Q4FQUOrZySHB0iKeuw7eC8e/OCajO24a07ZmqjfJRf0wkG
	 1KEmmlYdkcCQluHB0YpaiYlu9lHltIdIYxo04wTU8KrVty3/JHYPi0LO2RNjNDfQ54Ure
	 bi84poG1MYn5ER3/sTDG65E9NMMpXlUZ53+IOTqZ9t6ftTVclC/wXRitDDic7PjWKAA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791813781;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=2r2TOzs/arxiuRGvpOx/vUxaNWBM63D03bUOQyLkuzo=;
	b=VptyGuqoqkYcVmt3NU78ZicWElDVxLbuMiBkUD8cbvKSo2+ASyn5Ob+ZR77Ewy41oxVb
	 Tf6DJMDUJTWAj/28wnilPDJmUECcWMNT+tUd6WXa2MZE99rc0b/AsicsiTcma+ztOunrw
	 DuX3fN77zNBSmdj4/EQ9uf/g6so6XOEExDu0dOkkXq2V1eZsNwXfK8FW9j1fNpAlIj8Oz
	 BF0iYkM29RHHysgTi2fRgVhT2jsbdFo6w+Bv6mwfNcP1Wb/repBYKtj0HWDJmeUdRTDJA
	 sdhmFmBlJJV+64ZcgyWvaqbAVFJBoZ9rerQFOI5tG+KH22XnaYyJ6tiNVTRpWh412kw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791813781;
	bh=2r2TOzs/arxiuRGvpOx/vUxaNWBM63D03bUOQyLkuzo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QDPyxwwMpjXIDBd7IQyO0CAhH3p5Nx0dPeTWsjNPEjgTzRWN8CfMJzWRx1MglfQMW
	 FWglkdKUzTjs65twpgitQXfSehKOnRCzuh0lQ4r1zUe1HSl3NtAJbo2XmLFWvUFixF
	 UmbdAfKp1zbJ+m9QjEM5XSGaZrhKP2eQmrGuakO1eHM7M6vSKGOs3Q3G3QY6dPja4Q
	 ENYBljH0OioEcWc+8/YUtrEmjhu5DHx8RI2Uxcmt9a6OHArBxN6a2byuAPQy0/ElV1
	 UzZiLPlcLMWV1RHFvCK7QjULRYHAx+qd6IGRmZ+9v4FuYI4HS3uTEDPUFet8ZidDDN
	 UWyUH0OrMBhOQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8374C80A98;
	Mon, 12 Oct 2026 14:03:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id ACEC9179
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:03:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AAA5A40057
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:03:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YmwAGQh5jtIe for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 14:03:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 049EE4004D
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1033"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791813780;
 b=I15A9Do5ylS4Wbrrf+7N+QtA8XbPuMb/pb77hcNpBq+u4ioRxaCys6T594UzOkmmObPl
 KrZHIbiN6eYbL8Y1q07Ga/U9bSVyW59k+nIghdzg/QC5nMeO+uParuua5HD7SqfcarnEv
 Xl/5+n8ZO9tgCnpsE/ekEQ/d1G/tK05QAqvS+nmNtcvz07DWttIoKusqqbbtxtJTOPDej
 FqUedrGSBh8Lwv/fvZJ10jg35zHF8eQtEaSzRqstfqqmRM/PSq3TXKyd6MTpEdIePMvnI
 aGyENNQorbDylmDHFm0WtQSsT0BR0EhxPYGphUAh7k/uZV147xy3alh3BpREUE/BQ6w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791813780;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=2r2TOzs/arxiuRGvpOx/vUxaNWBM63D03bUOQyLkuzo=;
 b=nqA5+iqo+yWafuBp7+XOmvxYKIhNt7YVRU+cUF8UXQpZkecCUDrjzAzIteXZ2ny70pfH
 Drz1EhKeii9Cvl0HFTD7GL+cVSeJoMOCvrfosnOXV8mULepwiEFahRPcFUsa3FszdQjHl
 myMQrsWA0X0Xem5z+lzvFOm71HuSRGeGJ+vSJyaPGJh+/FYQvSJwo6D1x1auLB3wMwCWB
 ambYXk6XMT8O2eOotjrPzaF9Q9r2TUR8NXGL7y60Mgl5JbREVLZ78pQCs0/JPLOLrT2Lt
 DIlKySle9p27xsoQAo+Sx9V3bqS7I01GtQQDNAOymRF44xibOUdnloxxTFppBNwco0g==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=OYaXXtcq; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::1033"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=OYaXXtcq
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 049EE4004D
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:02:59 +0000 (UTC)
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-3ab450c0873so1600718a91.3
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 07:02:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791813779; cv=none;
 d=google.com; s=arc-20260327;
 b=WSp+r8gypVh6tWEe6sWdKJvxIs9onSD0xu9eL6ykyLP9lCuriuUgyjHna3XsaieTFN
 YDH6NZPpylEUVRkIOASv3jtccmtdnXuUDtIMz05O7+ulkoXpUMtrUH6kpyyQocqfMokT
 o1Wd1mX1jF5jxXtO7cLQJxG9slb5o51GoPWXT0y7ILTnXLYtqsihQUiOsRApGaq3477q
 C658SKRGuoosd11q//vMy7g6m9afNBwFr2BXrXMRFHF8kJteFjCsiSWOamEngpcxsqTs
 7uT14klw5A5IPJfRfacH+Zrd72eZEpCVRjvAaZ1mI0bIbnFTzFcYS06975lzxoVU7xGD
 kk8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=2r2TOzs/arxiuRGvpOx/vUxaNWBM63D03bUOQyLkuzo=;
 fh=rDOkmCQJ9cozxuZkgmyNWj5k0ThXnY0U4gnSEgE31/k=;
 b=RkoDeCfWxUJmi3VcQkjkJib0syl+0wXq1FMi7jMYCnWJ4gS2sdRJoomvVm6q2f7dwy
 nkX7Pe8gGC+yokcPLsnZNykvmA7g3/HPb7VnCz+XOU/JCIw0i0ZKjN3JfNGp9HEFopkV
 LMcEkXWZPIW6beDA8Kknntl2R9UkdKpGK2gYF7Lfn9LwLhvo/xtXCl6e320FCEIBgv5h
 DI+ZId6k/JIyY0EM7/CXDoTwOVdH/xgTpu2QR1HQgPyDVAf/3KL8YKd5H/4r7QtIJgty
 9fuf5h1Q1kEld3Ya1lnfF5Hgm5kmeU/fizDkj9hObGGTyJ6Q7+La/0NzT2uQOyybiogh
 ny2A==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791813779; x=1792418579;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=2r2TOzs/arxiuRGvpOx/vUxaNWBM63D03bUOQyLkuzo=;
 b=OYaXXtcqY9ofHrAEbja99Z/+njXBAM92DLwbXeNGP9esy1TYrLByoRAjXdi+29VvwS
 wcpCPv+HpzrLLYlPCdoPpQvXVIg5rJXATrkF7/CSW/iPbA6BnSyiotuwogmakDVapz/b
 B1LnSNkPxjKvDM+Mp4BVUkRSGHFe00c6b5p0w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791813779; x=1792418579;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=2r2TOzs/arxiuRGvpOx/vUxaNWBM63D03bUOQyLkuzo=;
 b=soCVv9pZvbqmbEb/fFalZCc5dMV1FaxW5RrhnKbyNkVyQkZqZ5mkjsCwx9U9kl9Ahx
 3VzP5iknFvRJ8VI29IAgc8A9qB2DgSwcJOVmx5B2lHNK4bUbMVQZO1BTVbYvuhRtVRb+
 tE/TBra5J/LAtl8xXE/gxwGp0zDBrB49JORFelkmlXPNM9bwCC7Bfef32kNUM+DCcrK3
 9ZG/kk+Ss9NCt645E/JxzdbDzEJ3VkchM5JTu6QeBevQpNIU6cpJSvTl2QvQuppfQyPI
 FiRUHlNrC6KPzbgN6I8kBeCKkpqDHbQ9eMgnIQfEfy6cSD0BNp58l0svLCFiWGO5L0AT
 VOBg==
X-Gm-Message-State: AFq9FYLyxP4dFgv7LjIMp6t04UbM1vSuf7upAausAb7tDoLJgoz5Mjpp
 w61YCuEecfWTHR41466Lbt1J+iradZ+Wxnb47myZGwDnFm6rRJ937nKcddsax1yphy6xcaUikXM
 EkBC+M/ulARC1aTmtNLWC3HmbHInedz2DNUBba+AvdyT5+X3xpXTb9d5f
X-Gm-Gg: AYBFou3AI2nIv9yYUdWt5K5yfGK54FTiwq+zAZ1LR0kt8jW0ai7g5scZtJenfc4HG3Z
 R4DW/658/XUZWxkQRjgg1tEyT0AQA0eyHBICyNLM3HoR1WDxo83PkmID2cafxljkW93HP0xCTF6
 Gg/J9uHmazxQxREAB/NfA5URQW3q0IXoYSoLEQCehY1fQvW+5QllmFEjcsr0IG9ZF2Lbip15czb
 nCB1CLA/msQLHk3xrf+uISGPOj0Nl9c+LwJc8xlul8gsD/yTUAAJ4otpaY7o7kKFj6Y+Injcol1
 AFMC3+D3Vx3j09m7FJrbsfU96ZgI3avhL3OQTSDhk/rlUuKNBrVWtGY=
X-Received: by 2002:a17:90b:3c04:b0:3ab:39e5:6268 with SMTP id
 98e67ed59e1d1-3ab3a92f39fmr8187006a91.53.1791813778918; Mon, 12 Oct 2026
 07:02:58 -0700 (PDT)
MIME-Version: 1.0
References: <20261010-b4-button-adc-get-code-v1-1-843d04f5dfd5@protonmail.com>
In-Reply-To: <20261010-b4-button-adc-get-code-v1-1-843d04f5dfd5@protonmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 12 Oct 2026 15:02:34 +0100
X-Gm-Features: AclHuK_0wTHhDOJUN6-OocS1NjkpsV80gs5HbfMReIp_Ckt9f-xY52seAhwqpd4
Message-ID: <CAFLszTg_r3YhTn8GJo=J_opEd8agt=Kx3PDV42ZaUR2Bpc2f0g@mail.gmail.com>
Subject: Re: [PATCH] button: adc: implement get_code()
To: petr.hodina@protonmail.com
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 David Heidelberg <david@ixit.cz>, Simon Glass <sjg@chromium.org>
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

Hi Petr,

On 2026-10-10T12:42:50, Petr Hodina via B4 Relay
<devnull+petr.hodina.protonmail.com@kernel.org> wrote:
> button: adc: implement get_code()
>
> Implement .get_code in button_adc_ops and add linux_code
> to button_adc_priv.

Please can you add a sentence on why this is needed, e.g. which caller
needs the key code from an adc-keys button (button-kbd, bootmenu, a
particular board)?

>
> Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
>
> drivers/button/button-adc.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)

> diff --git a/drivers/button/button-adc.c b/drivers/button/button-adc.c
> @@ -49,6 +51,16 @@ static enum button_state_t button_adc_get_state(struct udevice *dev)
> +static int button_adc_get_code(struct udevice *dev)
> +{
> +     struct button_adc_priv *priv = dev_get_priv(dev);
> +
> +     if (!priv->linux_code)
> +             return -ENODATA;
> +
> +     return priv->linux_code;
> +}

The sandbox test.dts already has linux,code values (KEY_F3/F4/F5) on
the adc-keys buttons. Please can you extend dm_test_button_keys_adc()
in test/dm/button.c to check button_get_code() for button3, button4
and button5?

> diff --git a/drivers/button/button-adc.c b/drivers/button/button-adc.c
> @@ -93,6 +105,8 @@ static int button_adc_of_to_plat(struct udevice *dev)
> +     priv->linux_code = ofnode_read_u32_default(dev_ofnode(dev),
> +                                                "linux,code", 0);

You can use dev_read_u32_default(dev, "linux,code", 0) here, which
fits on one line and matches the dev_read_u32() call in button-gpio.
Treating the property as optional is fine, even though the Linux
adc-keys binding requires it.

Regards,
Simon
