Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185E9606A319
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 08:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=B3d7mRvI;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=KQFiG9f+
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EA48081201;
	Thu, 22 Oct 2026 08:26:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kP5w2cCU0v2A; Thu, 22 Oct 2026 08:26:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2A8D281237
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792657590;
	b=fWoSwqion1BZ7HGAnwKeeDAvwwxjcelLBq/eXems9yrg72SAhnpKzG4G9S0Cuf6B3F/K
	 CoSJh3GvHH679JwPj+GUMNaeJxZ7T5/Q6vqmW9kZuR+w/l9wuymBhymXafu1jvh45K5SQ
	 k1nOlSyH6x1pRWC0Vg7RY6Zf88nycop7vTV6Jhb+gbUxMx3yVmm3N6/z6kCMgWVUXWG17
	 8w7BJwT2avZPFeB6JQRTISbRuExy0bGeKfBgmo1h00ks3fJJr/OP/MxYnSZ/lvmPGLsHL
	 DdXzOd5GWjWjy70LQ5XL5wXGvGg188OxhwTIgjv79MywyeORrl8tG0Sww61awuu55/A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792657590;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=JKna6eq7De66ko1qa8QLur76Yd1mVHgalC1ECotp5Fs=;
	b=jI6k16wImEW1P7a/y/P0XwxifRCphpadcdEVtZElhKd0drd97J/q2iYrPFsZ7CNvW7DG
	 E8AN/O3K3MekHc6eDSYD3cjeQ85sp3ord0vMqH4/qpMqaaiH0LSOydf+Y7+HnITtc6dJk
	 PGErCH5ihCqCWEETzCev17TWXC3l97wEnPjm3uBT25bRHn7ZN0V3ptNxfOTPPyoMy/d7m
	 vezqm7UeTQYTaaftAzABNcnOgLo64GI9RfGeyYIWPnqSl6+A3LvP3SMmgboqbC92v+YTA
	 8TjR2pcZ4f0Eq265RzBwDXsBnG12wqzKsD0QAhZbKN82mo7fwbMfZKVu6P2R1khyM6g==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792657590;
	bh=JKna6eq7De66ko1qa8QLur76Yd1mVHgalC1ECotp5Fs=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=B3d7mRvIleT5gnjrndn+TG60ctVVqJOwNdja/jixeqCFzJ7RVjd+4BBK4h5ItTNcA
	 FksN62rjRS0S/DBYYSdMl8Qu8MDVLz08eZburMP8WYLPc3T2NbnLGa5Wue5xA9BEXs
	 wds0q7sb9oszMnJ1MwaNAHhAB0nZB3flIX2DQS876c3KMkycuRGCiDXV3jShDdblYn
	 V/pSgsw8JLC1iIo5QsM0PwBwVbEw+y7HXS4rp5bBtALALbxqzxTvgTbgfiRwIU955j
	 Ja6j+eQLhNL3Vx/qcX0wHyqR0l7qEFNlVXNAjutS/6AOB/T3EaUxf+oCPV9YCYb5V4
	 e4Ge1K/Ju7mjw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2A8D281237;
	Thu, 22 Oct 2026 08:26:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7D40F371
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 08:26:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6F3D660823
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 08:26:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k9hNc5vYYUBv for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 08:26:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A5EDF6081D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::62d"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792657587;
 b=Ro5giYkGzQcUH9AzBc5uQtJXhAmhGr1lqgMMJWZSj9AR4Pj3WyEOCCm6s5TyEBfXUIqu
 Mr+fgVh+OxfV57s2Ccw/V8WT6t59kwYSx6Roc3HU4ySM6T6gyGvhUaTrmr72NZxlGEYOD
 zoR74VitvZPovhJn+MgZ5o4uLKepZ1yDNdpbduwB8fm7KyY8gthrFb0CsBFzaFo1rZKkQ
 Zv0A6NphWuPXZaVNrBp4mG6ByfeLfUMr33X24/wQYX5ZccpQkwlz9vhAWlCIi8xMt5fnz
 X0c9b/dPF+Yw2EkaQwmetpqy2JP5nTQiclUo8FBxdaP799iVFiHEaWj7vzUDObYSdMw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792657587;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=JKna6eq7De66ko1qa8QLur76Yd1mVHgalC1ECotp5Fs=;
 b=UO5r3Zro/VD90F3PWhnTMPV0eTBpioWBRWfJFGhCsdHIp+8K2v/t/2KulWi8PPRd/64u
 pp6GNNds/3Rs0Z9a99qNTnxH6xNlugInClsjiGVIbvh1Ly+mqf1hH7R57hpN7kDJxwoch
 CnWnS/l39EMo686/UGR0oCB1nAKqv9n18LgbweoskdlMadjQVMIfA6WcAe/78gjOk3Cqd
 yum7s55Gaf+GWM39BMkGy9t4EaI+y8LJV7waBpookorXTc1fh4i2Nwmgbo1ItBhrZvpHg
 Tykj5gQRgZAliddk4rNDMpqyA5tcnbpufpsBTlfuToUsnUuQO3LVU6QeuppHyQrUQQA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=KQFiG9f+; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::62d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=KQFiG9f+
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A5EDF6081D
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 08:26:27 +0000 (UTC)
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2e8fe8e343fso10648555ad.2
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 01:26:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792657587; cv=none;
 d=google.com; s=arc-20260327;
 b=dTbGS8dCb9OD+WLqD6btiCNsZuPrejk/aLkbjXRaqUs/qrwsdz1nEh5yTBxCsqhCHB
 QXDQfl9lGQR9Ragkwx1opmAXY5SG6Lp81RrYxmHUPN7Kk5R9H5yfNJ8HoT1ckLKqftnW
 2thSm+EnKqjie2/n3ULKQX0nojQVLDkUCq2u2sWcwoVG7H54oBfI4/cp0BuwQ+RhlKZn
 oNUqXSSzWOBSoETTyyal85X10ok+oqKKBdwG9oR14rWLLquGGnZ6sN4iSvRKojoMr27g
 AxWwszZXIqeXU94BUA/Bv35aJOSdOv2QimNs3mHz26sDOFKSMDxqt55oRQVXXp3wD/3r
 QkBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=JKna6eq7De66ko1qa8QLur76Yd1mVHgalC1ECotp5Fs=;
 fh=M66JeLsX3FwAOPR0/QJjOnUXIl3rC8R2uz+1YSMReM0=;
 b=l95aGOV7Am3sXCDr6efQ9PmdM0IElGp+41/8L5/d1OGgcRUc2k8C8mcg5YCZShIdda
 PV5MwB6E4r5MG+nyzZoMyD/ne21JyGw7OVvNXxz8yPReqG/uP2Gx1joXtsZSE2OfQHTI
 i8+Z2ONAyuo77IudfFYGHXFk3Lrmc5+foJzWj1NG1Xxr/Zky5IFNzhCg+vd8DjNlUdjS
 Li2wWLQYS6939wIt4yBY54duBo49qp3JBMsmLqlK6QbI108lKrgDVmiX+V06A6N+pq77
 Bsu3IYt/Lva3SqoCUsw3+R1MevDaQEFxUMxQaRD9eZWiw1Gv01dyiIXytzuoOUuIExGh
 J4Zw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792657586; x=1793262386;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=JKna6eq7De66ko1qa8QLur76Yd1mVHgalC1ECotp5Fs=;
 b=KQFiG9f+y8TlK/SOF2OppdR+5ZI+/2ya0SchS2c43IpxapemT1iU3h5x/9/+SGgij4
 Qwo4U4vHa7r20tUbnzWFEGbOM7lS7YWd4X0cO0pFAfNmKIAPgFdoFoyue63asNqTGxxr
 /qtKXGgYCsPUM2u2F74G2aJ60HvpTkRA6yPjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792657586; x=1793262386;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=JKna6eq7De66ko1qa8QLur76Yd1mVHgalC1ECotp5Fs=;
 b=2nRxIygoHIU8dVjDfSvt/ZCq+TpS83b6lXILprLJzvwOUTEANDGNAbGkQ623MoNnd+
 qBOWDQaohXOWe4Eu0fy9UK/x2T0pqIsEa292+K2ulkuYx0I+hEW1vYXh+q3DiyzVHmdi
 XhJcEVXFiuSlJkJBo7dNmy+Ib4JxCals1ZH+o7d+2pfsS7oeBayXycKYL3OVQQZRcwgu
 jWNttdkSxLLcF/a1HQAob0AeJZic/C0wyk7Ifv1IQ5ywSsE/fvrQVRL4WPrvuH+qG5WZ
 Jch2L9Jzpg+hmszoRkDFWaqg3hYhXlqmn21fWJ2kgobftXtrVSOBpjzj9CTnTfmbN2f/
 VMzg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwQIjp3TUhORYEggWBiT9w+eHSVouzcFUPLMGFyQVv+nDDoWqFCEIKvMpNRjV+CuJ8UudO91eE=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIzfPlLe9t1LjfyTQPJijFIxsvB2vQoYpp+4nqsC7uUqciB2BVI
 IL5AblF0jJloPBf7ERTKFEiKX5xgCU+j+yrvux3HZfZ1OdJ70aoZnOwDDt4zcQZo4naXao/KOZA
 HIKOy+g7YQ3Wn/8jyi6z99PZLyOhd7ikTy/UOlY8+erKxxHoxYUccPg==
X-Gm-Gg: AYBFou1Evci3QHRGnYs0hIMn5zrI1Rfq7OSgphUAkR9cjaAzSTrbapnEuW4XeH7w8Ty
 K5lWHjEn9kE2T556e5hysD28GjIRsMjWqxBOOklVU7GChsZ9xr6Nn01LrEPS0DeNTL2KdWy8zu6
 p16VuyP5CDR9I/g+E7dYyOKQucx6Ssnz9ND5pRX5qDCs2s/HqtrSztPczBSibbQQWozwjFh5GCo
 8TESR/sOwxpi+oqToHrVmasYT5W16KiRKXIpcQpoEql4OrYztfqePrftn4Oco4k+hmc2zzadVKo
 Qjj+23v0GMrmvUW2GD9ofsysbNO/sh/r8iMNXLAcPyH3BcgMhWEBG6w7DFSjF584ke9xr2W6Odp
 7GmwG7ynMIDGGHiQfz/RwO6Xb0ewiy3vICG6jmi92zXN6lyBjyi2e/X+I
X-Received: by 2002:a17:903:3848:b0:2ea:7180:3aba with SMTP id
 d9443c01a7336-2ea71803f4amr396855ad.39.1792657586512; Thu, 22 Oct 2026
 01:26:26 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 22 Oct 2026 01:26:21 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 22 Oct 2026 01:25:16 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261020-test-avb-fixes-v2-9-997f8f04fd3f@kernel.org>
References: <20261020-test-avb-fixes-v2-0-997f8f04fd3f@kernel.org>
 <20261020-test-avb-fixes-v2-9-997f8f04fd3f@kernel.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 22 Oct 2026 01:26:21 -0700
X-Gm-Features: AclHuK8PJkUzNpmYZ-W4Ot3mvdRFXS1wmcuGQpGuKxDPaNEw2VNPCj3xxBYzNvE
Message-ID: <CAFLszTiY1RbqFQQX2yP+r1coYEwpkU0M2qxTfvwgnGCyBhiPng@mail.gmail.com>
Subject: Re: [PATCH v2 09/10] test/py: avb: Add sandbox AVB testing with
 dedicated mmc12 device
To: mkorpershoek@kernel.org
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.u-boot-project.org, 
 Jan Kehren <jan.kehren@emteria.com>, Guillaume La Roque <glaroque@baylibre.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Mattijs,

On 2026-10-20T09:25:49, Mattijs Korpershoek <mkorpershoek@kernel.org> wrote:
> test/py: avb: Add sandbox AVB testing with dedicated mmc12 device
>
> Right now, sandbox runs the AVB tests using mmc1.img, which contains a
> fedora image.
> This does not really make sense. We should test on an mmc device which
> has a proper vbmeta partition instead.
>
> Add a new mmc12 in sandbox which contains all required partitions for
> proper AVB testing.
> Use the mmc12 device in the avb tests only when running in sandbox.
> The mmc12 DT node gets enabled by the avb_device_id fixture if CMD_BIND
> is available.
>
> Note: the vbmeta.img has been generated using:
>
>     $ ./avbtool.py add_hash_footer \
>                    --image boot.img \
>                    --partition_name boot \
>                    --partition_size 4194304
>
> [...]
>
>  arch/sandbox/dts/test.dts                   |  8 +++
>  test/py/tests/test_android/android_image.py | 15 ++++++
>  test/py/tests/test_android/test_abootimg.py | 77 +++++++++++++++++++++++++++++
>  test/py/tests/test_android/test_avb.py      | 26 ++++++++++
>  4 files changed, 126 insertions(+)

> diff --git a/test/py/tests/test_android/test_avb.py b/test/py/tests/test_android/test_avb.py
> @@ -22,7 +25,30 @@ temp_addr2 = 0x90002000
> +        mmc_dev = 0xc
> +        fname = os.path.join(ubman.config.source_dir, f'mmc{mmc_dev}.img')
> +        if not os.path.exists(fname):
> +            setup_android_avb_image(ubman)
> +            ubman.restart_uboot()

Just to check, is the restart needed? The mmc12 node is disabled, so
nothing probes it until the 'bind' below. Since sandbox_mmc_probe() is
where the file gets mapped, the new image should be picked up without
restarting U-Boot.

> diff --git a/test/py/tests/test_android/test_avb.py b/test/py/tests/test_android/test_avb.py
> @@ -22,7 +25,30 @@ temp_addr2 = 0x90002000
> +        ubman.run_command(f'bind /mmc{mmc_dev} mmc_sandbox')
> +        # Run mmc list to ensure that mmc_sandbox driver is probed
> +        ubman.run_command('mmc list')

The fixture has function scope, so this bind runs for each AVB test in
the same U-Boot session. Since bind_by_node_path() doesn't check
whether the node already has a device, each later test adds another
mmc12 device with the same alias seq. The tests may still pass because
the first device is found first, but it leaves junk in driver model.
Please can you either unbind after the test (yield, then 'unbind
/mmc12') or bind only if the device isn't already there? It would also
be worth checking the bind output, so that a failure shows up here
rather than later as a confusing 'avb verify' error.

I'm also wondering whether we lose something by not doing the
disk-image setup upfront? Can we still run C tests on it?

Regards,
Simon
