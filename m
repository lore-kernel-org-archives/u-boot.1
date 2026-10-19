Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9EF1CCF2DA
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 08:35:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 560D3605D8;
	Mon, 19 Oct 2026 08:35:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PiTitit7r6sM; Mon, 19 Oct 2026 08:35:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7F89D60612
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792398914;
	b=V/uIrtbsglibJTv+NXUSxaFkwkzLoSrX5LX3aTw42dToG2F3BTonXcLODibGt3i2id/C
	 i4qAF/G3TfY80XPF7zC4Mkw0yaZY0ZhBuanPD/AYwKl6NwDWNN3xR4xlABiD6QNg1l/6C
	 9z6TGaVVALFg3nZqTmm3U2vaZPwpUgrrJhEyhi1+opzF/0l4farVH34OAXBJJwcTzXSnx
	 Hk8U5CsvcGk7z0xhH4d6flbZTEx6SzAQ7BU3+L4Rha30pFTBZYXu2+TwBYnEch/Iae7mF
	 +OJZjzn7WlIgZCgf3nfIujQHgfPuJ6Ea3BjlBuuZngUPhzMNi9LInYPpev7gSvkGttA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792398914;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=yzjb6KvTk++T4iW1mH2pnED4/T6DhqVz0QZrf9DwyLg=;
	b=Rob0yDn9iroXhixAxsEme6p+9Yb/wudGr84o1NKHs/5ZZ5GD54Io7yQBWSugidTBWJ1o
	 SZUJ+qFezz+Ufa6ACLjnqw+LTpcrMQzSzSKlziGiM4Qu/PFDsDRvWLINlY8EtSErzPkdA
	 r3nsWvUDFISKVEW12GZmFtAlZzcG0pUtfGVqD9xCWdf9miT9p6fHhK+B/mmMGxFusY6M7
	 WKEQsj5Gy7ljdByKYccVVdlJNQxNID57I7uM3uQ6GXVHhmFgGtI5VvFgY6RadSV6nTj3W
	 Mk4YLwqfbkG/LE+RXycx0OQ5dqPtPK1AXQ+C51BGvCHvyS2WoAyIL2nr3NJSachJGQA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792398914;
	bh=yzjb6KvTk++T4iW1mH2pnED4/T6DhqVz0QZrf9DwyLg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gUzaPqJ2G6xq6K6N/p9d/2Rvsqxdpb78JG/EvzLV5K6DtgWTRXnuCdibVryvxMBy3
	 8J3MpQiK40SuB9VUSpQDZZMgXjolgCIUIdc2ET6bu8v4trrTtEn2Tl81Heky1HL6bh
	 ua7rfFkjkW1YX41ApHjwCSD69EX1UZ0JXeZN26tsUzmfR+yd5ueQGSJZEdy0Qn13hn
	 0dvfa4hgrUdi3RAGwgWhRNW2eckcYF2cNVTzPc7Xb05vELXQsQGjdkvzFbTl4i8FYW
	 nJ3Dixp6ruydeSSTcNXpKr+ozUmQIUsJ4lHBqSRTlCESCEpr7DTBFRNAuiuafve24Q
	 e3U5CaCSRdApQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7F89D60612;
	Mon, 19 Oct 2026 08:35:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 95FA31AB
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 08:35:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7C0FC4018B
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 08:35:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fE_895QTtnLa for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 08:35:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 57DE540062
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1133"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792398911;
 b=SdogOJTtbYucpCULRSa/2AReijfZQ9ZLKS6mhkiLC2JLdcPiANMCBLIDSS+7ZrvbjzXf
 AgGRHgPuTMfZx2xLisGqaLGys81pSyhJOqHFmEODDL39SC02wvBkLr7qK19ymB92E8zuA
 qs2ZzDHZFLGnWdDxwuBdyJxA8/VD8LMyFzznNfT34Lx3RUzmJZtxitojDvhne3ALHKKAB
 gcnexc7OCzg+0M+UkddOXh9eXE6PPk2y6wve/XmNv0WwzppGtahDB5A6t3HApFvhORqxL
 akwEOV1fxrufIIcEGPu5zHkRwSnItIgk80fpyi/uhz3+p/XVKQEO72TidgC6Rb4DoTQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792398911;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=yzjb6KvTk++T4iW1mH2pnED4/T6DhqVz0QZrf9DwyLg=;
 b=f0mp5wwPloBVLASqAE2rPPZToB1wjkniDRFo24eyhlDaQQvoyHCrUK58UvQejUD8QrtP
 dghsD4TFcYB5Anb4THAGBfgfjYyWt/jrtP/O5b97cqRz2Ah2ac52+cbn4fAkAfs8uc3ON
 CWGLlgUkxtGUpvObxkmiTzzESD+Vq78TrsaqSuxu0kp++5bIVB2JqKnp8H6+lnnxbkSS6
 RAukaANiUH65Xiol5N47rJGksotycpz0lYofjm41OtNZRcF6jp8XprT+Ivfvp5+sCedwH
 5uyDbiD0GPpSnV5fC3i6tTobTv5GMJwwq/vTS17cGeDvmSLInpsGbRRQRQDwhavsRMQ==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b="x/7x8eG0"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::1133"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1133; helo=mail-yw1-x1133.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=x/7x8eG0
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 57DE540062
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 08:35:09 +0000 (UTC)
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-8b0a28a720aso12846397b3.2
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 01:35:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792398909; cv=none;
 d=google.com; s=arc-20260327;
 b=VngNDEkcg3rfztYdQlap7xDCkQPkow8inu0lobnW3i2x8y9IMYA089Pz8g3bWJkDOC
 VVf6xEfNV1Gs6MSh/fETq0XzBCVTx9bK461TeqsQI51ikPh8ZlTaU6Qaf9CUdZAn/kB4
 5XwZVCSldpUzsEWDfeYrDAf6/Xv56Yr8O+CQ8ato8CVo+uno8w63H7V2I7+dO2ZlIMQL
 AG3xe6kuMCeT4sXahSDJvCkhXPIj3Ou/75rC+bslh17lgKPf2lVzEU3Ulkx2o2ew0Hb4
 zczS1aEsC0Ap4lHIdRJTE5dCA2qOglgeBqqy/GSesKMYfJ4OcGVdB2TxQvZ+XkSWFy1t
 q5tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=yzjb6KvTk++T4iW1mH2pnED4/T6DhqVz0QZrf9DwyLg=;
 fh=W8/f/M9jxjUraLqdVrNjjZeASRCwT0Jex7TG+FXiP8w=;
 b=DGLtWUg8N6eX3WvutlYI/MXt/LY2kOltJ8G1lFA7p+BJ/mVLxaUXrh9tes8/czALdz
 8aTvOnmXaA+JGDXO5TR82EVutsmcbpz/lygNQ0X+KzdL+kTbTZzKghLZg243nPpdu5CT
 NsxtxVTLo3SxuW2Ayl9QXc4R3dgyRYd6qrSn6G8XfPSCoODCcQdwJqwYQNoJwS9cgeXW
 2rCd+iNo7lMrkEis6ubpcjqgN8v4ql6MhIndXrat7lCo5O0ahbzSoQZaU33FwLdY4FtO
 Kf1JziuyaFFyLc0Ea9KNXYhYc81ZGAiJp+U5526if+K5QwY5/oU9yQ4SEb8yeXbGRdTa
 by4Q==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792398909; x=1793003709;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=yzjb6KvTk++T4iW1mH2pnED4/T6DhqVz0QZrf9DwyLg=;
 b=x/7x8eG0ejZcJVg0qIRms2wE9Bz+1z9UGT5MIhOUqtmNNRXz1s26TnVb4bW2Pt5rIv
 mQUBk3RI3qYDH2iU1aCwSX6hj4+ciDBamRMrFhD2k3uonEPqDFm1tgnG7wQeJnFxIqv6
 YsJ+Y8I3+A+4oHk4TKiNuvkG0xJdE6IbTro0NgwkApwNzO2wdAegy1Hc7NphK864Q7T1
 I2pVnTR5A+rLF+X15+wWPHrW01woukP+JHlnVCs70xgkes1+cJ4GFJYZWHh0iL6isvQJ
 us7D7jFZ9BVYsQfz0DKLZ+q0A93mlFEJeyeUd1M7s68Mrgfz55KL24e6kD8Mc1jqs9Wd
 LyoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792398909; x=1793003709;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=yzjb6KvTk++T4iW1mH2pnED4/T6DhqVz0QZrf9DwyLg=;
 b=fuJt8xhGsnBvpWnJnq1BpSJeXZdy+ozoTVCO6hp0LxJxpzwenIC/lVd6wdDv5kBgUq
 SDD0eyK0OrVSMtZ6h+dEAO0TYcbYHC2/EvZCxg/c9MZxKFFYnXcciCEla1d4nTVylhbT
 366ZK5FLNPY5SxkI8CnsHR06ylZJm2GClAuWNzS/uwUv4iNT3skt4W+REc/VSEkeApm1
 XLJ7kikm2X3GaBdC6mi8e5rwwvqpL8H0Kx4Zpqq1TXAoZOJnG+zt5Rfz/gBRhvkb5uWL
 KnpkDlHhqK3dsHweCVMTIEnws1e/HDwNLhee1VdlCCnF/VHvWZLRf+mahuBEah09sYJ0
 ONPQ==
X-Gm-Message-State: AFq9FYKO9VHf4NsP0hYFCpDNnT+qvAFsPIOJ9esjFvy0XF8Xs/DIWIP1
 r3xZe7Kycpc73shfMB0qtU5t6Y1ug2PHxY2yQtG+p8aU0QrXvf111fND5ihOLbsGpAwV425LcBc
 Vd47ZmxVY2mngxd505/zrUU3sMbQt52NHY5JuYJKwLA==
X-Gm-Gg: AYBFou14vFGE1S5XJtjmZdvzbE1qLs3h5cnjWXh1t6c7088/k/ehWUE3LAqNAHKLbpO
 Grq2ZCg2rVuloqyEUT2wvL5qCoiFVnTDQBE1UQ2MamLNbs5Kx82NMuy8mDEwyxRJ6boeZxKPcIK
 gahgb1D0ADRgXLrtsHpqtvXdBtzuXGtI8QWtkcEDH/BtvSwZ7bdBbOEfYiIx4Du1OS+BRY7h/Ii
 e7jSHP1aKOtRDGxI/ra6+3/Z7iQDPyuH5fgEn9VskGQgk6bTo/GVDUrCf+S0uGDg315Primbgt8
 Asc07V3gggzaBzMrIiZc/DzR7TI4GkvN1vzJQeEo6BTd3W6oMCRrip61VfOy/fE+BmWNCMbzw/S
 O4x8MM6AIHmZUXUwcJqefNM53mlGgmcJC8l+khQd+33uNEFoeOYad1vzpP50HQER/urKQpii3Bi
 l+3Fwa2+papvpMpOS0V1hM6keWfNV/pU56lj6Yna7qEeRLZfQ1I3NQExptHGi2qJf9QkwqA6F2G
 +ohT9OPtS+yYogUzkRtz4HrYATlXX+2ID73yQbTYEpSCdipPoq0AyXv+8e/4zLbncFr3BfHOcJm
 SH0B7D5aTaeU/edxTYfUTOfxUzzj0ob+QCanoS1DlrBYDoPrLoZS0GPRvBuBKSKSU3VEAYX+gF7
 i2yX2Zn6MX/GIOAKixvthXh8dtvsQB7ZjQZTpS5SNchfsH0pTi/qiBw==
X-Received: by 2002:a05:690c:d82:b0:870:107b:635d with SMTP id
 00721157ae682-8b0f21de1b9mr23957817b3.31.1792398908621; Mon, 19 Oct 2026
 01:35:08 -0700 (PDT)
MIME-Version: 1.0
References: <20261012-upstream-optee_rpmb_b4-v2-0-85d76a54273b@oss.qualcomm.com>
 <20261012-upstream-optee_rpmb_b4-v2-1-85d76a54273b@oss.qualcomm.com>
In-Reply-To: <20261012-upstream-optee_rpmb_b4-v2-1-85d76a54273b@oss.qualcomm.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 19 Oct 2026 11:34:32 +0300
X-Gm-Features: AclHuK_v8mRk9o2Wf7hON8H6XmPoBJ9Mqi-Ik7suJaLr4fOpTH1QHqhbBiJIk-U
Message-ID: <CAC_iWjLeSNEAdVoSg2GSYeupH8daBUwT-oVATjGv0W0H0yri1g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] optee: rpmb: select the RPMB partition per request
To: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Cc: u-boot@lists.u-boot-project.org, Jens Wiklander <jenswi@kernel.org>, 
 Tom Rini <trini@konsulko.com>, Jan Kiszka <jan.kiszka@siemens.com>
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

Hi Igor,

On Mon, 12 Oct 2026 at 22:56, Igor Opaniuk
<igor.opaniuk@oss.qualcomm.com> wrote:
>
> The supplicant switched the eMMC to the RPMB hardware partition when the
> device was first used and only switched back when the OP-TEE session was
> released. Between two RPMB requests other users of the same device switch
> it back to the user area: libavb does so for every partition read while
> verifying a chain, and the Android bootmeth reads boot/vendor_boot right
> after verification.
>
> With RPMB left selected those reads hit the RPMB partition, and the next
> RPMB frames were routed to whatever partition the other user left
> selected, which ends in status timeouts and I/O errors (seen with
> the AVB TA on QEMU's emulated eMMC).
>
> Select the RPMB partition around every data request and restore the
> previously selected partition afterwards.

Overall this seems correct, a few comments below.

[...]

> +/*
> + * The RPMB hardware partition is selected for the duration of a single
> + * request only. Between two requests other users of the same eMMC, for
> + * instance libavb reading the user area while verifying a chain of
> + * partitions, switch the device back to the user area. Keeping RPMB
> + * selected across requests would make those reads, and the following RPMB
> + * frames, hit the wrong partition.
> + */
> +static int select_rpmb_part(struct optee_private *priv)
> +{
> +       int rc;
> +
> +       priv->rpmb_original_part = mmc_get_blk_desc(priv->rpmb_mmc)->hwpart;
> +       rc = blk_select_hwpart_devnum(UCLASS_MMC, priv->rpmb_dev_id,
> +                                     MMC_PART_RPMB);
> +       if (rc)
> +               debug("Device id %d: cannot select RPMB partition: %d\n",
> +                     priv->rpmb_dev_id, rc);
> +
> +       return rc;
> +}
> +
> +static void restore_part(struct optee_private *priv)
> +{
> +       int rc;
> +
> +       rc = blk_select_hwpart_devnum(UCLASS_MMC, priv->rpmb_dev_id,
> +                                     priv->rpmb_original_part);
> +       if (rc)
> +               debug("%s: blk_select_hwpart_devnum() failed: %d\n",
> +                     __func__, rc);
> +}
> +
>  static u32 rpmb_get_dev_info(u16 dev_id, struct rpmb_dev_info *info)
>  {
>         struct mmc *mmc = find_mmc_device(dev_id);
> @@ -130,6 +146,7 @@ static u32 rpmb_process_request(struct optee_private *priv, void *req,
>  {
>         struct rpmb_req *sreq = req;
>         struct mmc *mmc;
> +       int rc;
>
>         if (req_size < sizeof(*sreq))
>                 return TEE_ERROR_BAD_PARAMETERS;
> @@ -139,9 +156,13 @@ static u32 rpmb_process_request(struct optee_private *priv, void *req,
>                 mmc = get_mmc(priv, sreq->dev_id);

get_mmc already selects rpmb_original_part, which we now always overwrite.

Cant we fold in select_rpmb_part() into get_mmc?

>                 if (!mmc)
>                         return TEE_ERROR_ITEM_NOT_FOUND;
> -               if (mmc_rpmb_route_frames(mmc, RPMB_REQ_DATA(req),
> -                                         req_size - sizeof(struct rpmb_req),
> -                                         rsp, rsp_size))
> +               if (select_rpmb_part(priv))
> +                       return TEE_ERROR_ITEM_NOT_FOUND;
> +               rc = mmc_rpmb_route_frames(mmc, RPMB_REQ_DATA(req),
> +                                          req_size - sizeof(struct rpmb_req),
> +                                          rsp, rsp_size);
> +               restore_part(priv);
> +               if (rc)
>                         return TEE_ERROR_BAD_PARAMETERS;
>                 return TEE_SUCCESS;
>
>
> --
> 2.53.0
>

Thanks
/Ilias
