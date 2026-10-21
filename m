Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FD6606A319
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 12:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=AmjTXAxf;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=I6wLDria
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B17D760856;
	Wed, 21 Oct 2026 12:48:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m3_Jw8lH5KU2; Wed, 21 Oct 2026 12:48:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8A61B608B2
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792586881;
	b=fJDCxC7ByfvDxzRVPtllr+lH8ebaZrj/wDb1+z6F9XC+063ISFLJ39hFIG5qNkZpJLF8
	 UV0lnVfCxn51wVTMR3l6YDHZMr1S4wtWvCU//f67OlBeekqkvLBpGjvYdkHW7bprLaBdQ
	 ZNhlFFPnsnuFGxO8JjgBWZ7HSSM4BWYJ0nVOTAJjFxyUvTa89p65/HMGwn/BKd2VSuDV/
	 3Bj0L8E5yESn4EkecD8Yy+Mr3+sqVG5IARnVSaBVBxAt1IQiPeF1by/PKty7sqULIMVEa
	 +2L0twj9lTW2M/4YWnJpM9H94HET4szUNPD1KPBtcWB24jggW/yJAWkHnAXTg8D553w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792586881;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=chVRqe5C+7QK7Cv5eZiu07BLRMnfCfCVMjVJ0bHXjHs=;
	b=hRfv1+noohVMyIHSJuocrbr5zDvmib68gi+a2+LCb7smkxaQEiOpK9TYS5p+qslZQlAj
	 wSZBgWsdDUg05Y7h+1GA95XFt+1QFOiixWIFv1bsB2yF3sW3EGGrbJd6EHXrNNwcSiIPe
	 5fdH1JYup4d/q22DWk1pBOFkyzXr4K9TymMYXIJO/BhkMRMmDWdL4Gb9IluQ2RzVHLNUd
	 rjZaZ/1jBvKnVEOrdK3yqDLi8SBv8bZ1BQSConh3tR4s+YEbamCHROKh+yeXruHYgJ2GY
	 rbo8RU6lIHnA/egKD26Nglo2mnwHtrQIuolqXAP9Bc08hereXoZ8ao5VLvg7MYm4LIw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792586881;
	bh=chVRqe5C+7QK7Cv5eZiu07BLRMnfCfCVMjVJ0bHXjHs=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AmjTXAxfgaT9pdV7+yNyBE9xpCaZ8ktUlXgxiM7WoxpAUwhzxqXuW0ofugonr9OaL
	 IrBXLl5rJESpTC9ZCQkWk7m7AVRayCKo5Z6xGFmwBHcyWoKHLRj0/Le7/Jdz2c380V
	 q1e80lFDQoVps5n8jg9SdbwMW5nXGY7qdkzkAVI4zjazj9jFDq7UDPJktCCEJxjdYf
	 kX2h/H2B0yfB07i/gOTIu2QqcT0FtEyP5V0HxhrkPxMD159+nL3H0XN3QmQim2tfiT
	 z1NR6MemwmRGj4sn6feOMawNCey0Hy575cdm9PYIIxeEwkQ7GrfTcU+QDiDnvVH2A1
	 OG8vVT3Ae6u/A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8A61B608B2;
	Wed, 21 Oct 2026 12:48:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id B23AB1AB
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 12:47:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 97D42810C5
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 12:47:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kBVpPR6MQH1d for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 12:47:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4AF0B80FFF
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::535"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792586877;
 b=hKglMlNb3Sr1XiilKbGjZt6X39fb9Rax9YWdXjklYAr3ia9fPplilk3cDPiJKHrEC4Ye
 0DoUmXlp4nBsZrwRY9fAVJDrfFZl9vSK2rVry79NOBsK/rw5wrTZwjV1NLakJO6rXYXsB
 QyPcoUa2tni2GQRhLlh+ydPaY6y9SfqPGcQlphGme8cPCYw8Mz5K1Ib79osKKTyWeH+mg
 85pH2qd4wMH6bC9M2dRrhTJqZ3uD/pmgt/TCoSkIDj662EPlK8l2Bfv+wIm83JREs5e5o
 eEnaq58v08Ejeauf4eK4YbBbTGzlaKez/oRR+N1L5CCj2zFbnzVMVHHkhNHNsLCwHdg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792586877;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=chVRqe5C+7QK7Cv5eZiu07BLRMnfCfCVMjVJ0bHXjHs=;
 b=UZY8JTQ7/fTmlEeugArCCTnUYb/jk8IW0CKq3HnI2ZrUZw7rP0cpVek/uQTCEvahOXbr
 Iysc9+9ZTEOXlX51DUoPduCW0joBRqn0oJXQdcCZLfm2x9FZ/yiAGfI/BYxRSXZHSCb5Z
 zQtVCWRJ9HBBLTFs9qT+1gG/6r/j2KIq0YrACzEVtMNsshgG/385rix3uSgbvqXY0BEsz
 GXZmwuwr0Y1fslge/v0w65YgIEivA+kSP6AhN3z4nz+nCScMqO5aRWwESMrXo1s6WGvTT
 a3bhuDQWlHXQsaNsSJ81t9svxfHUuocmoTtix+OzNFINoQM+2ebUrVbOqDLQEwT393g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=I6wLDria; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::535"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::535; helo=mail-ed1-x535.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=I6wLDria
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4AF0B80FFF
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 12:47:56 +0000 (UTC)
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-6b1b13e09ffso876176a12.3
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 05:47:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792586875; cv=none;
 d=google.com; s=arc-20260327;
 b=ZVWxQrGW63Hb/cNPX36elDWhK1wZNK0Ovacx1m9Kjj9DY5ErfB/NXayhaqnFaK7R3J
 SszEe8B4ibGj7+qiKStwh3vWWPmPvZ5kODaulEN0ZDgOJplpqZmZtCSHe41Ku4qDhgDp
 TmuCZ839lFhZSisDamudTsJWXxx2MDn4O08DJ+llJj79FKuisjiOYRltVmBp1igDhSsK
 mlTCEIoNZiAbCdewij2hz/nBttNaiaOCQmSftSPI3nA0au9PXJAuaGln0BsPs3ramY8t
 G8+ZY2o3Lvk6Hqsm+n5Jzy/iJ+Eq4b2xFYyjJtlsbMqbF1JZRvSA4LNPChZQoPOasp3L
 mxQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=chVRqe5C+7QK7Cv5eZiu07BLRMnfCfCVMjVJ0bHXjHs=;
 fh=5AWcIrbOXF7+5ReDmahTRk66ErvUwFH6JYmKho88x6c=;
 b=V8OEOyyGtLgNP8lRgvm7u44hBjB/lGyyiDKEyaQbYo0/PYiyh2dKREkAgtKPSbcvlc
 V4LmFGTYH7rJ8M/blKRzT4MYEN1x4IWkfYSwxLoilh96s2M/jr0EAbF7FOHiQ7ewSTkm
 DaSVXtnNnKsVwHVRY7cLHrlP0K/U36rXYQaD8N04E3zjuCkiAQcS96zTXI4avNjxERm6
 uPAoAxl9Ot5PHEGhyvUtOHtsu0jRelfousvmwYHSpa/RmlgM38WgZ70a8fkP4zf2GBfL
 GYfQqG29dgIUuf5GCltJejFU8sEe7kmBfCGQFtnYLJZzc9HP+yyuiFGJuAsn5/tkxrKs
 FM7g==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792586875; x=1793191675;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=chVRqe5C+7QK7Cv5eZiu07BLRMnfCfCVMjVJ0bHXjHs=;
 b=I6wLDriaQXXrCHgCkK43c3Vj1KssCYrh/9D8am3PoT9XQx80i2effs+jY2MEcsCFoq
 ImDMvSZBLqp+FHrOdA3ixO4HiT3wrONAKRLvGnwkJiQgjfcx9dqixjppcQNVlOaYPR6T
 7RbGTD2x5KA4ej5bQz639tOXdsKiCOyqRBqc4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792586875; x=1793191675;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=chVRqe5C+7QK7Cv5eZiu07BLRMnfCfCVMjVJ0bHXjHs=;
 b=Uo1l7wwS0BhWEdjhAY+J/jAy1LtJ5rfPkIwJJEUhllothuh0X/qZhOQnI8Nxzg6toi
 yJaQ0WtAf4t2aG4egFanGnBRSEdY2k8x/qYdHNnSZC5JJRx5MZpnPxVcXinRWb1t+Ji3
 ozDwM7s74zJK+0YdnZjcS06P7YtflrTwqZZ6kdZFOVJn0sTshcOPrz0GoF4iuzqyvf9f
 yOwlXOFF6ckfVefx/3hl5uaqjoThmRgrO67Q/M1V6nobP87NCEiSVi9OSDMz+NUz3of7
 Z5BHPzUQSfzk7VCY+Oqf/8/ozXsyc46ReIptLaf2wBGDbUET4+U7SRIXd+elDM326zsv
 R1jw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwLiXPyTsWYelkR9p3Xe0ucrBuqRrlrQOs69sq3A95w/mceYV44t7zmBnDQqFVe1hVtyPhlPOc=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYK1fUFnmIDtSzS1dM3RLZaYKk/Y4iPDWI5sDI6UelLUlg0XJGVq
 YJX+RoDpQyQbmhdqk8vtBhxUmOnUpuYlqv1nhxLSH14LeIzmawWZ52CCiFzLtH2UBlaFx/DWOT/
 OK8kAuPxVnJdanL4rgF6E2MgTAGsE9NItVZTSsEKwjWMC8ox0i9MBhw==
X-Gm-Gg: AYBFou0IO/ON2FSp+ziHn/mayznDaMY1z5NzOpE5xLTDge5MBngwr5LNPBQyWcMDW4u
 dVJxuKH4pRVntCBwQSgxDGygjVM9yX80Me+4kRtjoWQrSTWY3S7hzNjgbntXVvFJk9Gcp8AU2G7
 lQoaHRxn+j+J3GNv1v635rkUaD/kfBMVLaTQgcVYMuWwpjXfLc5ClrIe1VcPqZcaC2+ARlAoXg8
 7krOPzP/j4q3XcMc/SmnAI6dz+KVBUx6liu763lL65gNgmrp0UsLw3GkwvNw+GsfQ6gqGE7bPcr
 /b6afZ4JgPwQ7e9Ly5oxpjRcBQeBCB8WuKVK/EL1ETc5SfNP6DK6YRz7yVsRbGjn2lsbfk0OTSQ
 laFcfic4q+E7p45f455AfQ/w2Ss9jsq0rlSo=
X-Received: by 2002:a05:6402:e96:b0:6b4:329:10aa with SMTP id
 4fb4d7f45d1cf-6b408eddf12mr1330935a12.39.1792586874529; Wed, 21 Oct 2026
 05:47:54 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 21 Oct 2026 14:47:51 +0200
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 21 Oct 2026 11:40:32 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260902211501.127915-2-bhargavdas100@gmail.com>
References: <20260902211501.127915-1-bhargavdas100@gmail.com>
 <20260902211501.127915-2-bhargavdas100@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 21 Oct 2026 14:47:51 +0200
X-Gm-Features: AclHuK-4H5VFHVvQihuRNdFDLnKRwt5Thg2Tnvf5i-hXKPzfdFORMW74h-_F5F8
Message-ID: <CAFLszTg_rNous1M9PDMHp8QWcNU3gCBAs89yfpshdAw-cjQJ6A@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] arm: Add RP2350 architecture support
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
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Bhargav,

On 2026-09-02T21:14:48, Bhargav Das <bhargavdas100@gmail.com> wrote:
> arm: Add RP2350 architecture support
>
> Add initial U-Boot architecture support for the RP2350 SoC.
>
> RP2350 specs:
> - CPU: Dual-core Arm Cortex-M33 or dual-core RISC-V Hazard3 @ 150MHz.
> - Memory: 520 KB on-chip SRAM, 4 MB on-board QSPI flash.
>
> Only Arm core support is added here.
>
> The architecture is added under arch/arm/mach-rp2xxx/.
>
> This patch implements early SoC bring-up:
>   - XOSC (12MHz crystal) startup
>   - PLL_SYS configuration to 150MHz
>   - CLK_REF/CLK_SYS/CLK_PERI clock switching
>   - UART1 early console init (115200 8N1)
>
> Cortex-M33 is an Armv8-M core, but U-Boot does not yet have a CPU_V8M
> architecture variant. Currently there is no arch_cpu_init() setup for this
> architecture.

U-Boot already has CPU_V8M, and the Renesas RSIP port (RCAR_64_RSIP)
uses it. It selects CPU_V7M_V8M, builds with -march=armv8-m.main and
reuses the armv7m CPU directory. Please can you select it instead of
CPU_V7M and update the commit message? That gives the compiler the
correct architecture, and the PMSAv8 MPU work can go on top later.

> [...]
>
>  arch/arm/Kconfig                          |   7 +
>  arch/arm/Makefile                         |   2 +
>  arch/arm/include/asm/arch-rp2xxx/rp2350.h | 352 ++++++++++++++++++++++++++++++
>  arch/arm/mach-rp2xxx/Kconfig              |  58 +++++
>  arch/arm/mach-rp2xxx/Makefile             |   4 +
>  arch/arm/mach-rp2xxx/image_def.S          |  23 ++
>  arch/arm/mach-rp2xxx/rp2350.c             | 213 ++++++++++++++++++
>  arch/arm/mach-rp2xxx/u-boot.lds           |  94 ++++++++
>  8 files changed, 753 insertions(+)

> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> @@ -2076,6 +2076,10 @@ config ARCH_STM32
> +config ARCH_RP2XXX
> +	bool "Raspberry Pi RP2xxx SoCs"
> +	select CPU_V7M

It would also be worth selecting DM, DM_SERIAL and OF_CONTROL here, as
ARCH_STM32 does, rather than relying on the defconfig.

> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> @@ -2336,6 +2340,9 @@ config SYS_KWD_CONFIG
> +
> +source "arch/arm/mach-rp2xxx/Kconfig"
> +

Please drop the extra blank line and put this in alphabetical order
with the other mach-* sources. The same applies to the machine- line
in arch/arm/Makefile: the comment above that list asks for it to be
sorted by CONFIG name, and the other entries use tabs.

> diff --git a/arch/arm/mach-rp2xxx/Kconfig b/arch/arm/mach-rp2xxx/Kconfig
> @@ -0,0 +1,58 @@
> +config TARGET_RPI_PICO2
> +	bool "Raspberry Pi Pico 2"
> +	help
> +	  Raspberry Pi Pico 2 board based on RP2350 SoC.
> +
> +source "board/raspberrypi/pico2/Kconfig"

board/raspberrypi/pico2/Kconfig only arrives in patch 3, so Kconfig
fails for every board at this commit. Please can you move
TARGET_RPI_PICO2 and this source line into patch 3?

> diff --git a/arch/arm/mach-rp2xxx/Kconfig b/arch/arm/mach-rp2xxx/Kconfig
> @@ -0,0 +1,58 @@
> +	help
> +	  Raspberry Pi RP2350 SoC.
> +	  Dual-core ARM Cortex-M33 with TrustZone,
> +	  520KB SRAM, supports up to 16MB XIP QSPI flash.

This says 16MB but rp2350.h says the XIP window is 32MB. Which is right?

> diff --git a/arch/arm/mach-rp2xxx/Kconfig b/arch/arm/mach-rp2xxx/Kconfig
> @@ -0,0 +1,58 @@
> +config RP2350_EARLY_UART
> +	bool "Enable early UART init for RP2350"
> +	default y

If this is disabled, the build fails: CONFIG_RP2350_EARLY_UART_TX_GPIO
and friends are not defined, but rp2350.c uses them unconditionally
and rp2350_soc_init() always calls rp2350_uart_early_init().

More generally, U-Boot already has CONFIG_DEBUG_UART_PL011 for this,
with board_debug_uart_init() doing the pinmux and reset. That would
remove the private PL011 register struct, the baud-rate constants and
these Kconfig options, and the DM pl01x driver takes over once it
probes. What do you think?

> diff --git a/arch/arm/mach-rp2xxx/Kconfig b/arch/arm/mach-rp2xxx/Kconfig
> @@ -0,0 +1,58 @@
> +	help
> +	  Select which UART peripheral to use for early debug output.
> +	    0 = UART0  (default; TX=GPIO0, RX=GPIO1)
> +	    1 = UART1  (TX=GPIO4, RX=GPIO5)

The default is actually 1.

> diff --git a/arch/arm/mach-rp2xxx/rp2350.c b/arch/arm/mach-rp2xxx/rp2350.c
> @@ -0,0 +1,213 @@
> +#include <asm/armv7_mpu.h>

The MPU code has gone, so this include is not needed.

> diff --git a/arch/arm/mach-rp2xxx/rp2350.c b/arch/arm/mach-rp2xxx/rp2350.c
> @@ -0,0 +1,213 @@
> +	/* Reset PLL */
> +	rp2350_reg_set(&resets->reset, RESETS_RESET_PLL_SYS);
> +	rp2350_reg_clr(&resets->reset, RESETS_RESET_PLL_SYS);
> +	rp2350_wait_reset_done(RESETS_RESET_PLL_SYS);
> +
> +	/* Configure: REFDIV=1 */
> +	writel(1, &pll->cs);
> +
> +	/* Power up only VCO and set feedback divisor */
> +	writel(PLL_PWR_POSTDIVPD | PLL_PWR_DSMPD, &pll->pwr);
> +
> +	writel(125, &pll->fbdiv_int);  /* VCO = 12 * 125 = 1500MHz */

One thing I'd like to check here. This resets PLL_SYS without first
moving clk_sys off it. That is fine from a cold boot, but if U-Boot
starts with clk_sys already on the PLL (e.g. chain-loaded from an SDK
application), the CPU loses its clock. The SDK's clocks_init() first
switches clk_sys and clk_ref to their non-aux sources and waits for
SELECTED before touching the PLLs. That would also avoid changing the
clk_sys AUXSRC later while the glitchless mux may still be on aux.

Also, the SDK writes FBDIV_INT before powering up the VCO, and the
datasheet asks for the same order. Here it is the other way round.

> diff --git a/arch/arm/mach-rp2xxx/rp2350.c b/arch/arm/mach-rp2xxx/rp2350.c
> @@ -0,0 +1,213 @@
> +	/* set AUXSRC = PLL_SYS, leave SRC unchanged */
> +	clrsetbits_le32(&clocks->clk_sys_ctrl, (0x7 << 5),
> +			(CLK_SYS_SRC_PLL_SYS << 5));
> +
> +	/* switch glitchless mux to aux */
> +	clrsetbits_le32(&clocks->clk_sys_ctrl, 0x3, 0x1);
> +	clrsetbits_le32(&clocks->clk_sys_ctrl, 0x3, CLK_SYS_SRC_AUX);

The second and third writes do the same thing, since CLK_SYS_SRC_AUX
is 0x1. Please can you add defines for the SRC/AUXSRC masks and
shifts, ENABLE and the SELECTED bits, and use them here and for
clk_ref and clk_peri, instead of 0x3, 0x7 << 5, BIT(1) and BIT(11)?

The XOSC and PLL-lock loops have no timeout, unlike
rp2350_wait_reset_done(). It would be worth making them consistent.

> diff --git a/arch/arm/mach-rp2xxx/u-boot.lds b/arch/arm/mach-rp2xxx/u-boot.lds
> @@ -0,0 +1,94 @@
> +	.text :
> +	{
> +		*(.vectors)                /* Cortex-M33 vector table at image start */
> +		KEEP(*(.image_def))         /* RP2350 IMAGE_DEF block loop */
> +		arch/arm/cpu/armv7m/start.o (.text*)
> +	}

Apart from the .image_def line, this is a copy of
arch/arm/cpu/u-boot.lds, so it will drift as the common script
changes. Could you add KEEP(*(.image_def)) (or a more generic section
name) after *(.vectors) in the common script and drop this file?

Regards,
Simon
