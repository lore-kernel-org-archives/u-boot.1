Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D17FC982D8
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 17:19:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 413978133A;
	Fri, 18 Sep 2026 17:19:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bmRJs0i1OT5m; Fri, 18 Sep 2026 17:19:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 6E0F081334
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789751952;
	b=UP7KO5LZ5oagny1NJ/AJ2cYcdg9LpHsarqm5vDbeXTqQVHhuK7ZwcmwMJiJ4fUJQBFYp
	 JGw3lh8cufmC/fjT1zBi5a7cF/JGCWIaC1yf0OiMt4xGPMhWnGu2hIxFM1j/WjhFp3yr8
	 09vJfalOUS6qqbVhrSVsstbqUsl2oDoz5C555dAEKbRADBdgH4apHa8GStV+I8+C8uKwX
	 xFP4KFuY+YmqHm1LkNTMdMdLyLeSF8YseWsnsfb4zawcWyg/r38VxxFSLPr5GMKgUoacy
	 VJlNH6LrMeJdRuamLIwrY5nqvfbFHsw0l0OTlBISfOMSkBeI3phx/BwfDwwNNRHUAxw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789751952;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:From:To:Cc:
	 Subject:X-Mailer:References:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ZSfz8V90n6ldITA+c7R79f3taGj7r8rtYo1wbDMcpgw=;
	b=j1nl2adDR+FVZVCZIH5amb594ivKv27PiujpnQ5vRqW12s9gjmJvZLirCHMoRtntJP8/
	 AmOmJ1n5xPxyFQZ/ZS2kRjWDAKhj9AJl1djbu+/XqlCQG9XPIJTnWXfHa9OhuEqQ9Lq54
	 HWEY25z7dINoT39frFIh/eZIt6pITEahR7aYDlZKHDkEsyz1Gzyn7ur41hSGigUeDHZ1I
	 SVTaJNjbAjGjfexMN56imeq6cWEM6Rjgbtw2r5eFVewwS2imHYLcl5sYOq/MAzzPX9m3d
	 gAJjrNPLv8Fl9Pgxj4AUhA9KGr/is9Vpq7sjScO3SbQ7Pse4M+7KRnpsYwkXWZA1Grg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789751952;
	bh=ZSfz8V90n6ldITA+c7R79f3taGj7r8rtYo1wbDMcpgw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=q+gR3dhFIDfU8SBsFewoG98Gar49qvDhTpJlGdopqUJXJFlIineunqbm3bq2ZL9Xx
	 0U86Ho7eyz77wOcG8cq/VYcgxf/7i0BssKdWQXvkQ84TkPJh7sf6skHHQly5leILo7
	 l/Pc2SIUoO3jVLxtVJSONZXUdiGm9k6GHDU88z+iX4YEi4O4tnOu1Tjxwj4/hFVPjq
	 p2Mvan2prbEuX39RFyUXCGKE3rE6QdxaubJhN2VeS5q5pnvtgIVULpMYQMgpxgCsuc
	 +looDEOK2ib4aLRePJh0iXUAJLL0idjltnqyt3Q4ZD3KquHuPo/v4G/Fum6iMbXpa0
	 gEGCPgVGpYxIg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6E0F081334;
	Fri, 18 Sep 2026 17:19:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7A740237
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 17:19:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6BEFE60D95
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 17:19:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M9Qg7YPeO_8H for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 17:19:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 3E98B60D62
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:34::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789751950;
 b=ZoesXPtAmu/YGNlXzckHAmh8HDWr2uSg3Otlhwb9oI/mku3i9XuBdpVarmLfEh8knAAV
 m/1j9yGwvwPZQ7cxJrVeekEdkoKloPG0TTqPAWHfx8zeeaASnoAUj4XEXQjf1BE7nrXxT
 r6JNIed4UdLAgeVtvpBIksExU7EZ2rjOiF1BXlGiDQZcCTwLOfLd3VIgZkQQVzP80cCoz
 JiLFNRiod7864K8HrO74OoXzMrHE/Kc0/hHbHgg1AjKsEtGtQ1j4Cvp3CAHde/7UUEDGK
 38cfSnWRRbZE05A6WYKJWPPpGdxUOb1UHs7ldhlVv6KtkyYLt9h3USB4UpqppnVR5bA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789751950;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
 From:To:Cc:Subject:X-Mailer:References:In-Reply-To;
 bh=ZSfz8V90n6ldITA+c7R79f3taGj7r8rtYo1wbDMcpgw=;
 b=fzN7r8wKD9wd415eWZhzdiDf4sux91fmRtEym+9L7as+HFqipznVGV5tk4dqtWe7OQ6U
 EfNJoQ9VRD6cleZcqaORHgypJXLqHw3m9lrWWxW6tSgpdXXifuLqRSX8Eq+/+H+16I6i9
 hN1PoEtefXgZBn6uJV5VuxlbJEeTBV5DhxSsVXywx7wPzeVXhHDLmLzyfYe4g9C6RKxrc
 1lEkjNsnBZ0w4bIcbd/QBKUk800oyQgUHvV1v7iU65fFY6a40cFqKl4GmQMtEVyENTLF+
 y/clyUPFWQtqk0Uci9So6TCBIwSr3EBR84OGU9T6YQujqd7RAW/42Y6OAZM2yIJHNKQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=n8wg3xJw; 
 arc=none smtp.remote-ip="2a00:1450:4864:34::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:34::10; helo=mail-ej2-x10.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=n8wg3xJw
Received: from mail-ej2-x10.google.com (mail-ej2-x10.google.com
 [IPv6:2a00:1450:4864:34::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3E98B60D62
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 17:19:09 +0000 (UTC)
Received: by mail-ej2-x10.google.com with SMTP id
 a640c23a62f3a-c293c683202so145821466b.3
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 10:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789751947; x=1790356747;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ZSfz8V90n6ldITA+c7R79f3taGj7r8rtYo1wbDMcpgw=;
 b=n8wg3xJwhfvzvZdmfV4y5xiKZU51Ha/ymsJJUn/doXAaLQmPy0CD8PI7hOORM6RgS0
 EQgWV8jXbSr92rLvDeXyeBJoBHhDbNwsqpSn6QIwzBtR4qfFIe6IOxEctmr6KtunLMuo
 9dqcuLLX+FckbQmzK+vBshiI3zlQjlheCVSo95mRx/J4TgqPYNfZ2TDGxV6O9u0AXKU/
 Ju2V+PQXFRvnSFTCHJ603cHIEOseEMMhhPe1ZwCyQ0J+HLgIXHhb/+122Sx8Tahgcspc
 QfJ61G8mn51egnuC5Lm+lMSpi5fcig9JtudoeWQoEfcUfKdI/PRbopeSiUyNOZoMaryl
 68wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789751947; x=1790356747;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZSfz8V90n6ldITA+c7R79f3taGj7r8rtYo1wbDMcpgw=;
 b=I77uvB281RgJrGBYZjmHgDSFED7Rn6guDBoaiVsou/MBgxBlAVMC6X2DcAR8xQC5MJ
 6hV8RKHwUDFB9ApDg/gPtbu/yTy6/FOsY0CrUOevL2Ho/osnWQkxHwCOw8njXJB9VoO+
 dAGkeTS3xOr6l3BNbqcHjE53xUYCPiY7mR++4aNfj8Z2ucPVoeLQeFBg7FRTP0arUZxx
 XyW8QqkpfuBdlQoC0nTCU0o6pXPx1e1Hvb2ly4Gd2bvlgoNGGKv7FWpWYSnxOBAj6GN+
 XdTjfCB3N0nd5Ff2FP0XBGbxW7ic5sn7pt8Bfm9RGGyGSdyVdG3EzMz2JUcQI6UVtCbM
 VQiw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzVp/FfD44HmgroAp/129QrRUeHva61nS5JosR7MB9dSmC6+Q9XuUm+hVOBWRQ0qekRLf19BlY=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++leQpxwc5o0734nvdHiPMvgZIZDOqGQkK65X5W/Lh1v9AgdKiXU
 CTAqF8TobmX1LHxhvT5+z+eHqAL4B4sWFMa87uXLV6BwGtdRY1le+OPQxpEPqKwQ8mzXGjGzcJZ
 5Y2DfDzo=
X-Gm-Gg: AYBFou14Ej4dSaoWDq6ihJi8fZ0Ieaap9OOFf6gt9IPr89foEXdRjoKaeL/Bje/Duez
 v9jIOy6tqeIBvF9xX3CmwVFSvsFcJu1O0LVrSo/Zf0J0CNrtrjS4xt9tUca25mmXcWYLMTChh4U
 sqWabmAJb75P4CR1pZrwpxia9Z8Rk962cQyYAqaiorGc1cCk+8kidQURBbZ+BInqZHnYktQh/e7
 pKBK2Jna9I515M6O4+cL9PMgJONhnic8Y4S8czKs/avzh60ddnfMnNzfWmAaA+p1k7bUnMgP5ue
 5613MEv+/1okydtk0wT/UJ/FR5d80DFSk5RgpOJxL429ct66ODuAA0pVibkSR2aDDH2IpIK0gpK
 BJptDkgN2PJ6whBXro6BI1ANDxc4PPWpYtzdmnl4e1lovR6dzE05RBxnN7yJFy1wCZ2Teii/irG
 OjcjeJ3lwSOOqmo2inTBIRxFPEFkq39VCmpMjLRN4aLca/N1I82IguWikmAnupb2usEHEDWv0cN
 Tst3SFHSxnNLzZe7sxBhDEB+iPO4jCCoTIozgP/JM1BpaYg/A4LnJJkfHP4OuMPNz6Nq2A8+vuP
 GfMMmAONVUXJoL//DDqqSIIyLRq4Uea+aBvt4hARGqDfdDJhg17sp62mjLzO/VIop9bJ5+YNP/m
 RpAp/OmRmNxuvIgGqqafkX3exxMKtiJbnx2XLi2dYIHqBTFE2wh9LmRvwoliNW/an6kwC6LEnuy
 6TYMhTCiZX+tdgnQXv4z4bvsWP5YiqdM7usaNC08sBP73WD5MnLCvWLJje9xfZzJIaMCvtYQibM
 u1j3eI9Z/FsZpWUBX63yMAuTRN+HwejXX6CeIAmH2iPO+MA8AV2P099tHy14uvAq8OnkGqS5hv7
 lxc=
X-Received: by 2002:a17:907:1c93:b0:c19:6104:e5e4 with SMTP id
 a640c23a62f3a-c2a159adbefmr313112966b.20.1789751947431; 
 Fri, 18 Sep 2026 10:19:07 -0700 (PDT)
Received: from localhost ([94.131.143.12]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2a1bbc6a88sm83826166b.54.2026.09.18.10.19.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Sep 2026 10:19:06 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 18 Sep 2026 20:19:05 +0300
Message-Id: <DLIM4554THB3.26ORA4HIE4U3S@linaro.org>
From: "Ilias Apalodimas" <ilias.apalodimas@linaro.org>
To: "Harsimran Singh Tungal" <harsimransingh.tungal@arm.com>,
 <u-boot@lists.u-boot-project.org>
Cc: "Abdellatif El Khlifi" <abdellatif.elkhlifi@arm.com>, "Tom Rini"
 <trini@konsulko.com>, "Heinrich Schuchardt" <xypron.glpk@gmx.de>, "Simon
 Glass" <sjg@chromium.org>, "Devaraj Ranganna" <Devaraj.Ranganna@arm.com>
Subject: Re: [PATCH v5 08/22] efi_loader: add MM SP status mapping for FF-A
 variables
X-Mailer: aerc 0.17.0
References: <20260914110106.1974894-1-harsimransingh.tungal@arm.com>
 <20260914110106.1974894-9-harsimransingh.tungal@arm.com>
In-Reply-To: <20260914110106.1974894-9-harsimransingh.tungal@arm.com>
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

On Mon Sep 14, 2026 at 2:00 PM EEST, Harsimran Singh Tungal wrote:
> Define the MM SP status values as an enum and add a runtime-safe helper
> for translating MM SP notification results to U-Boot errno values.
>
> The FF-A notification path uses the same mapping during boot and after
> ExitBootServices(), so keep the mapping table in EFI runtime rodata.
>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
> Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

> ---
> Changelog:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> v5:
>
> Ilias:
>
> - Include MM_SUCCESS in the MM SP response map
>
> v4:
>
> Ilias:
>
> - Replace MM status macros with an enum
>
> v3:
>
> Simon:
>
> - Add a comment explaining the sparse MM SP error map indexing
>
> v2:
>
> Ilias, Simon:
>
> - Reuse common MM SP error mapping
> ---
>  lib/efi_loader/efi_variable_tee.c | 50 ++++++++++++++++++++++++++-----
>  1 file changed, 43 insertions(+), 7 deletions(-)
>
> diff --git a/lib/efi_loader/efi_variable_tee.c b/lib/efi_loader/efi_varia=
ble_tee.c
> index 6a1fa39bb6f..bc15795e94f 100644
> --- a/lib/efi_loader/efi_variable_tee.c
> +++ b/lib/efi_loader/efi_variable_tee.c
> @@ -4,7 +4,7 @@
>   *
>   *  Copyright (C) 2019 Linaro Ltd. <sughosh.ganu@linaro.org>
>   *  Copyright (C) 2019 Linaro Ltd. <ilias.apalodimas@linaro.org>
> - *  Copyright 2022-2023 Arm Limited and/or its affiliates <open-source-o=
ffice@arm.com>
> + *  Copyright 2022-2026 Arm Limited and/or its affiliates <open-source-o=
ffice@arm.com>
>   *
>   *  Authors:
>   *    Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
> @@ -21,18 +21,34 @@
>  #include <efi_api.h>
>  #include <efi_loader.h>
>  #include <efi_variable.h>
> +#include <linux/kernel.h>
>  #include <malloc.h>
>  #include <mapmem.h>
>  #include <mm_communication.h>
>  #include <tee.h>
>
>  #if CONFIG_IS_ENABLED(ARM_FFA_TRANSPORT)
> -/* MM return codes */
> -#define MM_SUCCESS (0)
> -#define MM_NOT_SUPPORTED (-1)
> -#define MM_INVALID_PARAMETER (-2)
> -#define MM_DENIED (-3)
> -#define MM_NO_MEMORY (-5)
> +enum mm_sp_status {
> +	MM_SUCCESS =3D 0,
> +	MM_NOT_SUPPORTED =3D -1,
> +	MM_INVALID_PARAMETER =3D -2,
> +	MM_DENIED =3D -3,
> +	MM_NO_MEMORY =3D -5,
> +};
> +
> +/*
> + * MM_* failure codes are negative. Use -MM_* as sparse positive indices=
 so
> + * ffa_map_sp_event() can look up mm_sp_resp_map[-sp_event_ret]. The
> + * unassigned gap between MM_DENIED and MM_NO_MEMORY maps to -EACCES.
> + */
> +static const int __efi_runtime_rodata mm_sp_resp_map[] =3D {
> +	[MM_SUCCESS]		 =3D 0,
> +	[-MM_NOT_SUPPORTED]	 =3D -EINVAL,
> +	[-MM_INVALID_PARAMETER]	 =3D -EPERM,
> +	[-MM_DENIED]		 =3D -EACCES,
> +	[-MM_NO_MEMORY - 1]	 =3D -EACCES,
> +	[-MM_NO_MEMORY]		 =3D -EBUSY,
> +};
>
>  static const char *mm_sp_svc_uuid =3D MM_SP_UUID;
>  static u16 mm_sp_id;
> @@ -169,6 +185,26 @@ static efi_status_t optee_mm_communicate(void *comm_=
buf, ulong dsize)
>  }
>
>  #if CONFIG_IS_ENABLED(ARM_FFA_TRANSPORT)
> +/**
> + * ffa_map_sp_event() - Map MM SP response to errno
> + * @sp_event_ret: MM SP return code from MM SP notification
> + *
> + * Convert the MM SP return code into a standard U-Boot errno. This help=
er
> + * is marked __efi_runtime so it can be shared by both the boot and runt=
ime
> + * FF-A notification paths.
> + *
> + * Return: 0 on success, negative errno on failure
> + */
> +static int __efi_runtime ffa_map_sp_event(int sp_event_ret)
> +{
> +	int idx =3D -sp_event_ret;
> +
> +	if (idx >=3D 0 && idx < (int)ARRAY_SIZE(mm_sp_resp_map))
> +		return mm_sp_resp_map[idx];
> +
> +	return -EACCES;
> +}
> +
>  /**
>   * ffa_notify_mm_sp() - Announce there is data in the shared buffer
>   *

