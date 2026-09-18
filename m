Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23F21C982D7
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 18:20:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 379C460DBC;
	Fri, 18 Sep 2026 18:20:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Vsoy8Ql82RYT; Fri, 18 Sep 2026 18:20:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 3086860DAA
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789755645;
	b=RB3lFOsVS4TKj/J8eX2LTaxKRXKVGwr4DG+VeQ44bCLGCNGFcljmUjEl0nFkU7BgLCpR
	 Accq/hdpfemDW+qppQplcAhvwyWM9xww0RaH4P923HAhJTGSrR0DKkMBWRs+iPcK/FO2Q
	 uHF38NcDItZqDrl4mq+FBAE4/ntKRV3OQsGV0pao7r3lP10ysu4ZZIybwU3epgSUgaBe3
	 V3Mcy5Idpe4UvqZ1yF8CwH4tmvWVsMu6I4FId/e3ThCYVoLWGBYUSXh41AvCcA92/wIC1
	 Yh+JTmfIzuz3WsXtkTJVCyfwhOiNSNAYj5+M3rFIssu3zOtcVJFfkj5hffGnBuqrVAg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789755645;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Cc:Subject:
	 From:To:X-Mailer:References:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=4/LZ0o0NCAjCc6C098f8/BmgNchDh7PXYJYBxr1AXEo=;
	b=UyKQ4Xyg+RlT6QbxnDoaHvnCs+xFyKEK+LU/ToMkaR1dnCS8Yrm1GCEjreAU1zha5izG
	 gwMehpZKTNYcNlLiUdyb2f3dUqUkNZ85BN0vsAS7rYvmF1gPGCquAqRH5U6stGRvl0B5j
	 FOP8M7mfgwV17/LqZ1Tcyt3ee1WFWT+4Y/I1YIdlLoa6/GN7g3d3IsgOqNIMAr7vBjJ3Y
	 66VzyT82CS5/TRjVu4ywQVJmToYyk6dlknqXJYvkMMIOqYit1bcOfbsOMCDpxJFyWw/8a
	 sDBFDPhdIcuYTsl2IhcMiOfsgLMv4JODZleaSkgRTzPK79BDsXqwEyiTGt+oTBL6cIg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789755645;
	bh=4/LZ0o0NCAjCc6C098f8/BmgNchDh7PXYJYBxr1AXEo=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DiLPBXEOJ7hK1qokjMJ6IazXo0an8EenZA1ogeb5TJXmaUwT8dSKmorXDoN42/qzb
	 rEEUfjF2ASWaiufsG5PRJiqcdPveMDc+3tbOHLuPBEv+7KGk06n/np8ov7ggAo+zkl
	 c9fqfyd6uS1jd2mSsllKdL5RYGUYJroqQnT5UEL+7sMCgQcnE0S14W5APRg9i+qHgv
	 YoqMd0u38DZBnLuf/ICJreE6v2TsgfosKXiLxdfAMau5ldDkQ60ZVQJqMnvZHBf4I7
	 ilORVLa/yq66/w4VGRgvGESYVU6j62lYPWCq4ULMoSIvTIlZoM/dw12hUdL6oeBbqw
	 iemzhNvewqbEQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3086860DAA;
	Fri, 18 Sep 2026 18:20:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 77D80237
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 18:20:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5D62740BE6
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 18:20:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4ZRBIRi4RSNg for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 18:20:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org F25B040BE2
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789755642;
 b=K97BZ1iVnZrBjanuJeSHgJf3GF3h3b/DQaIxIi+sd4253gpozLO0hVuUWr21kooVVXmB
 VVVMIa/l457Pr8Zus7FOadxXw3YHPJJuOKap4ejbBOaey+4CrvTPjZiluiNnromHJcOFO
 ggoKrUB1zpBnNMUcKv8Vkwww4T1ORgHvfVd1l9U6PqMMLQyRB5BdXfhqVC3lwloqyZWkK
 2GG6UFPmVii6pfw/m/Lo+XeU5jgU5pzwQCZifEwRt6qToVWsvGqBi0MIHqA0p4r+z/7lO
 uPg2ACGRtxsIraoKpHeeRj5b6S9hzyU9lfw7kN1oYmgljKWmrXffy3J2ZhYMdK1kdBg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789755642;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
 bh=4/LZ0o0NCAjCc6C098f8/BmgNchDh7PXYJYBxr1AXEo=;
 b=SW5qW6vRUFDMobJ6np91FrSuTaWoYYpYnCd/NjjCq4bmp3NfACf91vkoEyBK45a2Fifo
 1GAlegXPGBdtFGm8OJnMYjeqYPsNWmnrhJ/CeJ1PlB05XZpyi6d460XHz9850xCvuVzlG
 QvAu9KKifnVU7bKfPpFchCA8ce5KGoAhvcAztxrtkC7hqZX98vss6eBnK5SaGxAsQjCuA
 kPLocCBdZscwseXCueL6JaRz2iOI/RBN9JuqZ0URoGpTmvSusCYhseOEZCR5EXbM3Wvr/
 Le1HTAyHVfDIwUh9d9A7XNSepennQouMTx6draSEYmhDkK0XBbuYCRQUMlXUdkw5xDw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=P+BlIFn8; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=P+BlIFn8
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F25B040BE2
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 18:20:40 +0000 (UTC)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e83a388f8so6975085e9.1
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 11:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789755639; x=1790360439;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=4/LZ0o0NCAjCc6C098f8/BmgNchDh7PXYJYBxr1AXEo=;
 b=P+BlIFn8ONsOD2bn22dIRnqT3nog9SfWGXcEKKU0U9akVtuyC8gjzBzAYMn6dytA6h
 RCfEad6DRXVkaSsYnEpBU5ik47WoQHxds7VKZ49MCr0YsUwZUqjR7wVbS0f8hI97RpkW
 6qsRBZYu1ijc5NBAJF9caF8E+Zff5WeXs23CMpHRoKlSVUns3w3XTDa0dv1j0P/3YsDG
 I6h3ujjcBQzCReBTr1U3KMkBdYYB356HQDbZ/SCo4rUVdwx7MLmnX02/Xx/U+fHvqnVp
 YeAhxAM5k7JhHyVwMkFENYORfvNUS7UOerMdTwLibuPSuiVgHh7eDMmkD3wN7XusXafL
 5Upw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789755639; x=1790360439;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4/LZ0o0NCAjCc6C098f8/BmgNchDh7PXYJYBxr1AXEo=;
 b=BIT3LY6sx7wVQrsFlZkadwnJO2F7ABAOSJwJW9MyZly2zudR5YZ/YeBjD4XPldWPec
 fdzdmdaFJx/XK7Zpp1DCk3kD7WHan9kfmG/2V8+NbNnBC9EiT3MJPuKCgtN/kNvx8gq1
 zPCXeaPQkU5OExzw7I8jVNXe4qnapGBFv7uAPNEBjdF4hNgnYyBMZsgoSAZD0dZ1ozg+
 egA0pYuU7v75Of5ZTGG6hfM6s+9RTd2UBikxAzaUTcdPGgCvtGHdnaD/vt8CGCM9VdWg
 t/3CKz3GcRCJNqKBKhMkc4C9DTZKj/BJxjJNroN6AMuQLz964uRTfvy+gNxyb2vxPyIH
 BP4Q==
X-Forwarded-Encrypted: i=1;
 AKwUvByTeD6dAsiBDLiGIwfbRgGR5w4C7kA0DvZwilYS3pldishdcQmyghR2+OXu2n9v4CQI6c+Gj+s=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mG9vhIx6fNHXF2KfhLJs5az27CoMAGOXzXMdHw7pGnpLIHFg6h
 LHjPZQWT5Ssiobqmz8XoEbqCe05a45QqsPhmYVc5HUynC72ZmaqIAwd8Yhk7yHP6vpg=
X-Gm-Gg: AYBFou2oP4VeUZwjbS9lieUMaS0okq4/gm4/K1sQl41WMzY4+Z5v1K6QK7WuSzpczGz
 kEKDRPrsH/koje1WFFUkotlJfqWE4JcMvwtJMVHwlqIVNc8DMjPxSAm8NtVOvDbes8mPex7Sw5L
 VSQqm1FXKTnABn4SrGApFUcLRBckoQtAK1ICdYAdR5WySRodsSWMY2KoLKCZ5ztmvCjT3l+nrY5
 bavQ0xm5kTKOA6Nsr/B4tvYZXznD3Cu6Uk1APbDI1Dp63S6EraIgGCAaKUvVEb1Phq1GrpILi8e
 ZK5chfUjEit+kQU3oWJim1FJrEIT/kK27af9H50OsRuihi+Ya2bkLfkgT5ulAwcDjXguJE3LOqD
 tLKypSeEhsfgek8oH1V6fY0Uy7qfvebzKQkrXE0lFxZRlW1nBjvpBjqtiLy+0wvbuJM1xAP16lI
 samxda7CoBW8SJYDqqo7YzwH0lOPKIq2yFD9vxTNkkDny5qGNv9yUPFZ+ST1H3oygfJwJ6cKILM
 YYnNs+7nPopwOQjf4RB2WtVUiX/Gdg3BfBJ1RKR8f+9wCRq2YdCIdrHhQ+5D8eewhvJgDO/8aGt
 zQnYo/Nbk0bMWeagYNm4YdvdoRR/nQSgspO5iA23BWg79qahSb03tddCvUy7NQhii/Gqi/X08C/
 Ow5toiKon/iH+eRQYuUuWCpo2ykUhvpDqJ6mAnXfHAnhzQ4VBGF8lnSzXlkXfs772QvswXL3GQ5
 1q1/CT+9wvPNBITRkH9CZbJvcWma/wL8uhKtYLBxu1DBfY2CPSgouqQfT3znt7qoS6x8eug0Eql
 TT7P++1JYRsWasDuHRJS2cL1wdblqa8iaOe1HtR3Ohvl2qUDM/dxUCSeZg2mPGqh35VeOgHAcvr
 DTs=
X-Received: by 2002:a05:600c:a085:b0:49f:bd3c:bc23 with SMTP id
 5b1f17b1804b1-49fc5747887mr46065515e9.30.1789755638787; 
 Fri, 18 Sep 2026 11:20:38 -0700 (PDT)
Received: from localhost ([94.131.143.12]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48724564565sm439905f8f.19.2026.09.18.11.20.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Sep 2026 11:20:38 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 18 Sep 2026 21:20:36 +0300
Message-Id: <DLINF8X5LGMM.22DVNGKNPMAM8@linaro.org>
Cc: "Abdellatif El Khlifi" <abdellatif.elkhlifi@arm.com>, "Tom Rini"
 <trini@konsulko.com>, "Heinrich Schuchardt" <xypron.glpk@gmx.de>, "Simon
 Glass" <sjg@chromium.org>, "Devaraj Ranganna" <Devaraj.Ranganna@arm.com>
Subject: Re: [PATCH v5 13/22] efi_loader: enable TEE runtime SetVariable()
 over FF-A
From: "Ilias Apalodimas" <ilias.apalodimas@linaro.org>
To: "Harsimran Singh Tungal" <harsimransingh.tungal@arm.com>,
 <u-boot@lists.u-boot-project.org>
X-Mailer: aerc 0.17.0
References: <20260914110106.1974894-1-harsimransingh.tungal@arm.com>
 <20260914110106.1974894-14-harsimransingh.tungal@arm.com>
In-Reply-To: <20260914110106.1974894-14-harsimransingh.tungal@arm.com>
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

Hi Harsimran


[...]

> +							   efi_uintn_t name_size,
> +							   const efi_guid_t *vendor,
> +							   struct var_check_property *var_property)
> +{
> +	struct smm_variable_var_check_property *smm_property;
> +	efi_uintn_t payload_size;
> +	u8 *comm_buf =3D NULL;
> +	efi_status_t ret;
> +
> +	payload_size =3D sizeof(*smm_property) + name_size;
> +	if (payload_size > max_payload_size) {
> +		ret =3D EFI_INVALID_PARAMETER;
> +		return ret;
> +	}
> +	comm_buf =3D setup_mm_hdr((void **)&smm_property, payload_size,
> +				SMM_VARIABLE_FUNCTION_VAR_CHECK_VARIABLE_PROPERTY_SET,
> +				&ret);
> +	if (!comm_buf)
> +		return ret;
> +
> +	efi_memcpy_runtime(&smm_property->guid, vendor, sizeof(*vendor));
> +	smm_property->name_size =3D name_size;
> +	efi_memcpy_runtime(&smm_property->property, var_property,
> +			   sizeof(smm_property->property));
> +	efi_memcpy_runtime(smm_property->name, variable_name, name_size);
> +
> +	ret =3D mm_communicate(comm_buf, payload_size);
> +
> +	return ret;
> +}
> +
>  static efi_status_t get_property_int(const u16 *variable_name,
>  				     efi_uintn_t name_size,
>  				     const efi_guid_t *vendor,
> @@ -768,6 +800,49 @@ out:
>  	return ret;
>  }
>
> +static efi_status_t __efi_runtime get_property_int_runtime(const u16 *va=
riable_name,
> +							   efi_uintn_t name_size,
> +							   const efi_guid_t *vendor,
> +							   struct var_check_property *var_property)
> +{

The changes between this and the non-runtime version are limited to a few m=
emcpy/memset calls.
It's pretty easy to only keep the runtime version and get rid of all the du=
plication. Same
goes for the set_property_int()

> +	struct smm_variable_var_check_property *smm_property;
> +	efi_uintn_t payload_size;
> +	u8 *comm_buf =3D NULL;
> +	efi_status_t ret;
> +
> +	efi_memset_runtime(var_property, 0, sizeof(*var_property));
> +	payload_size =3D sizeof(*smm_property) + name_size;
> +	if (payload_size > max_payload_size) {
> +		ret =3D EFI_INVALID_PARAMETER;
> +		return ret;
> +	}
> +	comm_buf =3D setup_mm_hdr((void **)&smm_property, payload_size,
> +				SMM_VARIABLE_FUNCTION_VAR_CHECK_VARIABLE_PROPERTY_GET,
> +				&ret);
> +	if (!comm_buf)
> +		return ret;
> +
> +	efi_memcpy_runtime(&smm_property->guid, vendor, sizeof(smm_property->gu=
id));
> +	smm_property->name_size =3D name_size;
> +	efi_memcpy_runtime(smm_property->name, variable_name, name_size);
> +
> +	ret =3D mm_communicate(comm_buf, payload_size);
> +	/*
> +	 * Currently only R/O property is supported in StMM.
> +	 * Variables that are not set to R/O will not set the property in StMM
> +	 * and the call will return EFI_NOT_FOUND. We are setting the
> +	 * properties to 0x0 so checking against that is enough for the
> +	 * EFI_NOT_FOUND case.
> +	 */
> +	if (ret =3D=3D EFI_NOT_FOUND)
> +		return EFI_SUCCESS;
> +	if (ret !=3D EFI_SUCCESS)
> +		return ret;
> +	efi_memcpy_runtime(var_property, &smm_property->property, sizeof(*var_p=
roperty));
> +
> +	return EFI_SUCCESS;
> +}
> +
>  efi_status_t efi_get_variable_int(const u16 *variable_name,
>  				  const efi_guid_t *vendor,
>  				  u32 *attributes, efi_uintn_t *data_size,
> @@ -1001,7 +1076,7 @@ efi_status_t efi_set_variable_int(const u16 *variab=
le_name,
>  		var_property.property |=3D VAR_CHECK_VARIABLE_PROPERTY_READ_ONLY;
>  		var_property.attributes =3D attributes;
>  		var_property.minsize =3D 1;
> -		var_property.maxsize =3D var_acc->data_size;
> +		var_property.maxsize =3D data_size;
>  		ret =3D set_property_int(variable_name, name_size, vendor, &var_proper=
ty);
>  	}
>
> @@ -1078,7 +1153,7 @@ efi_query_variable_info_runtime(u32 attributes, u64=
 *max_variable_storage_size,
>  }
>
>  /**
> - * efi_set_variable_runtime() - runtime implementation of SetVariable()
> + * efi_set_variable_int_runtime() - runtime implementation of SetVariabl=
e()
>   *
>   * @variable_name:	name of the variable
>   * @guid:		vendor GUID
> @@ -1088,11 +1163,69 @@ efi_query_variable_info_runtime(u32 attributes, u=
64 *max_variable_storage_size,
>   * Return:		status code
>   */
>  static efi_status_t __efi_runtime EFIAPI
> -efi_set_variable_runtime(u16 *variable_name, const efi_guid_t *guid,
> -			 u32 attributes, efi_uintn_t data_size,
> -			 const void *data)
> +efi_set_variable_int_runtime(u16 *variable_name, const efi_guid_t *guid,
> +			     u32 attributes, efi_uintn_t data_size,
> +			     const void *data)
>  {
> -	return EFI_UNSUPPORTED;
> +	efi_status_t ret, mm_communicate_ret =3D EFI_SUCCESS;
> +	struct var_check_property var_property;
> +	struct smm_variable_access *var_acc;
> +	efi_uintn_t payload_size;
> +	efi_uintn_t name_size;
> +	u8 *comm_buf =3D NULL;
> +	bool ro;
> +
> +	if (!variable_name || variable_name[0] =3D=3D 0 || !guid)
> +		return EFI_INVALID_PARAMETER;
> +
> +	if (data_size > 0 && !data)
> +		return EFI_INVALID_PARAMETER;
> +
> +	/* Check payload size */
> +	name_size =3D u16_strsize(variable_name);
> +	payload_size =3D MM_VARIABLE_ACCESS_HEADER_SIZE + name_size + data_size=
;
> +	if (payload_size > max_payload_size)
> +		return EFI_INVALID_PARAMETER;
> +
> +	ro =3D !!(attributes & EFI_VARIABLE_READ_ONLY);
> +	attributes &=3D EFI_VARIABLE_MASK;
> +
> +	ret =3D get_property_int_runtime(variable_name, name_size, guid,
> +				       &var_property);
> +	if (ret !=3D EFI_SUCCESS)
> +		return ret;
> +
> +	if (var_property.property & VAR_CHECK_VARIABLE_PROPERTY_READ_ONLY)
> +		return EFI_WRITE_PROTECTED;
> +
> +	comm_buf =3D setup_mm_hdr((void **)&var_acc, payload_size,
> +				SMM_VARIABLE_FUNCTION_SET_VARIABLE, &ret);
> +	if (!comm_buf)
> +		return ret;
> +
> +	/* Fill in contents */
> +	efi_memcpy_runtime(&var_acc->guid, guid, sizeof(*guid));
> +	var_acc->data_size =3D data_size;
> +	var_acc->name_size =3D name_size;
> +	var_acc->attr =3D attributes;
> +	efi_memcpy_runtime(var_acc->name, variable_name, name_size);
> +	efi_memcpy_runtime((u8 *)var_acc->name + name_size, data, data_size);
> +
> +	/* Communicate */
> +	ret =3D mm_communicate(comm_buf, payload_size);
> +	if (ret !=3D EFI_SUCCESS)
> +		mm_communicate_ret =3D ret;
> +
> +	if (ro && !(var_property.property & VAR_CHECK_VARIABLE_PROPERTY_READ_ON=
LY)) {
> +		var_property.revision =3D VAR_CHECK_VARIABLE_PROPERTY_REVISION;
> +		var_property.property |=3D VAR_CHECK_VARIABLE_PROPERTY_READ_ONLY;
> +		var_property.attributes =3D attributes;
> +		var_property.minsize =3D 1;
> +		var_property.maxsize =3D data_size;
> +		ret =3D set_property_int_runtime(variable_name, name_size, guid, &var_=
property);
> +	}
> +
> +	return (mm_communicate_ret =3D=3D EFI_SUCCESS) ? ret : mm_communicate_r=
et;
>  }
>
>  /**
> @@ -1129,7 +1262,7 @@ void efi_variables_boot_exit_notify(void)
>  	efi_runtime_services.get_variable =3D efi_get_variable_runtime;
>  	efi_runtime_services.get_next_variable_name =3D
>  			efi_get_next_variable_name_runtime;


All the get_variable*() calls used to point to the function from efi_var_co=
mmon.c.
By changing this you are breaking the runtime case for OP-TEE since now we =
will get
EFI_OUT_OF_RESOURCES.
There's no easy way to fix this at runtime. For OP-TEE the kernel might rep=
lace this call
with an internal OP-TEE call if it's part of the firmware and announces it =
can provide
EFI runtime services. However, the default uuse case, which we don't suppor=
t SetVariable
at runtime only needs to keep working.

I'll post a script next week so you can replicate and test this in QEMU wit=
h OP-TEE etc.

Cheers
/Ilias

> -	efi_runtime_services.set_variable =3D efi_set_variable_runtime;
> +	efi_runtime_services.set_variable =3D efi_set_variable_int_runtime;
>  	efi_update_table_header_crc32(&efi_runtime_services.hdr);
>
>  	/* Record that ExitBootServices() has been called */

