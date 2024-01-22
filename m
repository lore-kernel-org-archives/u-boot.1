Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C133C47DAF
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 13:46:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7568C83CF3;
	Mon, 22 Jan 2024 14:46:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="k79UvTF8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25FC5807EC; Mon, 22 Jan 2024 14:46:38 +0100 (CET)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46A9B8573F
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 14:46:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: 8d091b26-b92c-11ee-abd4-005056999439
Received: from smtp.kpnmail.nl (unknown [10.31.155.7])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 8d091b26-b92c-11ee-abd4-005056999439;
 Mon, 22 Jan 2024 14:45:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=4PibAetrRn4F1BnOgsSPC6GgI4pARUR+H/k+x+7Cqgk=;
 b=k79UvTF8C8FnNDJB5NyfKTUyKbwox9CC8BShcLYGpnViof4m7FsSWdlaXphqbyzntLAmohBX7hZiZ
 pDf3S3KC9YZZERIkxdl52MS4HyhNYehjrco1BRMHmB3SKaLLmtyKnRfzJeQO5gr+Y23SKWsTGrudw/
 0YCvg9Y4EP9n4eWJhsK9PcBl/2iUeDdxO4VIWxS5wfmHIoqBoSZw0SdtAF5+LLaEd3V2zFYfv/vhO9
 jgSyWPgID3wmChCZXGNsBy6Q3qawf3Wrz1UP3KI8MhwcVCVANVhQUZ9DDspTuSZqaut4nSsI/yt/k8
 jXcOzf1IV1c+uU+43FwK+9+vYP4ElFQ==
X-KPN-MID: 33|Vhn9IvKhEiJ64/MErVFqjOh97ivXGDFIU8wHH5qoMguVcKNJePsoaXcm1NWqrfD
 dIiiMCfzkiPWH0ytkmlRWNxSUOLkInYe9lx0Ocoyqf6o=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|G+XlgwkNLy1Zd7IIW5aLeWSJ71V+4mq2gsMFwKITVZLonix7gJsELza0ZFxoSf0
 zV4nd+nlGHX/mLmu705JpHQ==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id a7a20d9b-b92c-11ee-ad2d-005056998788;
 Mon, 22 Jan 2024 14:46:34 +0100 (CET)
Date: Mon, 22 Jan 2024 14:46:33 +0100
Message-Id: <87h6j5scp2.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: trini@konsulko.com, sjg@chromium.org, u-boot@lists.denx.de,
 heinrich.schuchardt@canonical.com
In-Reply-To: <20240122130435.73871-1-heinrich.schuchardt@canonical.com>
 (message from Heinrich Schuchardt on Mon, 22 Jan 2024 14:04:35 +0100)
Subject: Re: [PATCH 1/1] lib: support SMBIOS3 table in uuid_guid_get_str()
References: <20240122130435.73871-1-heinrich.schuchardt@canonical.com>
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

> From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Date: Mon, 22 Jan 2024 14:04:35 +0100
> 
> As we support installing SMBIOS3 tables in U-Boot we need to add this GUID
> to the translation table used buy uuid_guid_get_str().
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Reviewed-by: Mark Kettenis <kettenis@openbsd.org>

> ---
>  lib/uuid.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/lib/uuid.c b/lib/uuid.c
> index 0be22bc05f7..2d7d99535e7 100644
> --- a/lib/uuid.c
> +++ b/lib/uuid.c
> @@ -176,6 +176,10 @@ static const struct {
>  		"SMBIOS table",
>  		SMBIOS_TABLE_GUID,
>  	},
> +	{
> +		"SMBIOS3 table",
> +		SMBIOS3_TABLE_GUID,
> +	},
>  	{
>  		"Runtime properties",
>  		EFI_RT_PROPERTIES_TABLE_GUID,
> -- 
> 2.43.0
> 
> 
