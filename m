Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69D6CC88E72
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 10:07:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A2F0D60842;
	Thu, 17 Sep 2026 10:07:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Uth3inJ4HPup; Thu, 17 Sep 2026 10:07:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org F41ED60835
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789639657;
	b=FODLt4xWEEi5kbCekEdNxZd0EiDpAfjq/oNRzCX2n6DtN/mKLsRT6XFDM+lhTY/r+zfS
	 /TdwEtustaTIYMyKNH/iRhO6i587FFQF5G+iKLBP/SuyLAxweKMGSCIaB6mxWCs9QVE1Q
	 ZGDW/OzURxHMiY9dxQwHBGvTDNqbiRQ3k2mV6s08gcnOldV5VVplPvU8ZBRGYWMRKKDw+
	 hdFAIp+KV90hlMrKKpl5Ygg2OrfiVn9cnLGADJSuSaJ8ZBpESDK1TKtEc59P6XQJOSkRv
	 zP9HCT5zVvni7q8q3kk7s58oWTIc8e+vmHTDIe3zXWnZCCya3MjS98vJzCtG/3kRVQQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789639657;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Cc:Subject:
	 From:To:X-Mailer:References:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=JrjYVRaF517gPDnigDL2kXqxa4rnAU0gMTNr5nEihlA=;
	b=mQ5FRD+ShVc3lnEu7YF+XI6cVO7JtzTkyUMkGQdZC3uacu+y5ES1Kblr/nRFss5eAbiC
	 Xc7OJWNs4o3h6uc5I3ooP9ZsGwgaoY23B4Cq3raagSVs9yW7rV0rbeORqMEKZWkf/ZCxS
	 DLEvKG6gICEo7UOpEXMF3clnjbHOnpzp5Hsc4RGgQ/QCPmmjAwwmg8ym1Fj9nUDcgQZiN
	 9xUvT+Jc78vEnQXZ0vAtcUzAPpG83v9RcZlUXDvYu+rlEgCqeCwEEv+YwNvjAJWzuAh0r
	 FCWpbK0bBTfB5CXSOCbyIVHRiYlPD8HZ1nQdDoTLBT5b8GKXUsIfYpaR13bzHQO427Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789639657;
	bh=JrjYVRaF517gPDnigDL2kXqxa4rnAU0gMTNr5nEihlA=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FCgu4+UYUpESIV29FaGVna2zQi8aHIB/cAoeZuYeDJnT64QciGOfzgY+QfMC9V+++
	 L8Rftpq3f38OhwMePJeq1/A5UJzGJM1B5ER2W0gUwcCOPeteDKeM1FpVQ+M557h8nr
	 ZKiKuQ6zz5EpMhhOZpKuNYHWHO0tNp6AU5Q4vJHm6fVmQG9bEGFDJZ2gVk2OVZ8IRc
	 o3GIN+WIjc5M9ah9L2UcZgBMVpEy6JDJRxuGOeJ2mvpQniXvz13Q7ZG31YzbcXoFlq
	 BET+rSA9j8fmYPGkz+frQw6TW5LR9DXACZpUzlYeT2TfOQB9G6q8djD8UCj3oekbKa
	 IP9Cbt65Lzq5g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id F41ED60835;
	Thu, 17 Sep 2026 10:07:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 14B3C13D
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 10:07:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EE9A34043E
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 10:07:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mUffDQT_jp6g for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 10:07:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org CB8F24043C
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789639655;
 b=is9fykwaZc0BioKyGU8zZKnlmKkLs+UlXEs/GzaobwuIPg6m0lfs+ixtIS2q4PhKLvf+
 /KwAKuMYLw9rVTv3k8Dyk5cfWqIGAJhusjVYUD6etDYuWtfg44mdmzDLwljYwguCgrq/9
 RF5tZUqlCgX0FJ+K1mxBwi38NUHahs9aOx3D7i/mhcXWGIf5jXXUPPQLc7xopVT7akTef
 iK5kFLLY5T4c0Ubvik9Qzl0FHVN3qCZwdy2DFTAT3Phb+3K8EYyW6wYjKGdSF/DnVU5Ol
 ac7f9EXlV6LdLStWZDokGGkIzwxhqn47wzNIBRfPgDLPzbDNHym+P2s+WotoCVAdJoA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789639655;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
 bh=JrjYVRaF517gPDnigDL2kXqxa4rnAU0gMTNr5nEihlA=;
 b=aQNn518Qke0RfUSGPo/NfY1CgQpLTZTnVx8aw/iO4Lx97jUBBd/LFtp3X3V6LkvC7rJI
 R5XcDhGUxwNV1j+vQTjEkCiEuSd+WdrmkpKggmX9CgELkIGLxemmr1APUWKuYZkb65VV4
 6y5XEjz4yUOUryEgnrMoLQTPs818x5CK2tw/0YoyIbOnCBLcB1XRlqrw4JM0dRj9aTO+V
 IA28YVBhRQf4Nzqbhq650CB6IZodDru4hCCKrIP4B+95W4unNYrTHqTNB9C703vSY1cbn
 sg2F+87An26HbO/WjBLkTb2phdjiwa8XAM2dBkvVsdea+rM8Tf1h6JYjbRbHepR4ZRw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=Yl9dOFnK; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:30::10; helo=mail-wr2-x10.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=Yl9dOFnK
Received: from mail-wr2-x10.google.com (mail-wr2-x10.google.com
 [IPv6:2a00:1450:4864:30::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CB8F24043C
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 10:07:33 +0000 (UTC)
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-482f63546c3so534946f8f.1
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 03:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789639652; x=1790244452;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=JrjYVRaF517gPDnigDL2kXqxa4rnAU0gMTNr5nEihlA=;
 b=Yl9dOFnKk3/0UmzxcPIaJgCbWsP5BMITd/FApAQte48GPsXNSIAyPuvw0iNnCjuBl8
 gaSijpAPfCtSGBJuWZYP1Rjeq9+0u7hQFuOziuh34XurgjbYZkL3aITQnysUKQaZ5P45
 5kxPwQXdsyqy1ZmLsgsJ28l6IdI64a7ahSFV0eBWmkI0JtUiMOuaIXUCOsVZsyMCteES
 eTvCI4R8tnr97utS1R20y55hkAoD4mf5EFAxPrYJIjCbsIAGdaQprBfWJ2CnhlbDrbz3
 FKepRIP64MEw4jGjQ0qDwqaIOJQpuTUQaDDEE2c4Ile+kwb30MBDU25bX73hD+3bMW8M
 ypEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789639652; x=1790244452;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JrjYVRaF517gPDnigDL2kXqxa4rnAU0gMTNr5nEihlA=;
 b=qzWXuq8GErqxkEbGRiZHdn2TrMmTiv1n+XlgX/5aB9pjCl0XhZ3khQTUgPcRbxzpsi
 6P6usO9B3h/ALXL8M+3+BOD2joR68vinopXWEyndDXD22bagbjtdu3dA0SYAj4sboAh3
 yoPaZJdHbbJ2yF+Ozl2DPQRHQFq80br9MxNtfMTZfGFYe96odD74TleO3DMERQeFpMBW
 HQjyZME9nYc9tRpXqDIKTIG9bBMDt6px9SeE0vYdivTkCl3Xj7vFwdzfvvesj9N+xJet
 tzLThX1iozxnc6UwyT9qirAHS+JYMfo+lq/2WzOxaHGQwgdzIGdUquGKuiQL4aIimMV1
 VTZw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwitulYnC30a7eyEVtzpX08WUyZccMKtfjenRKdAEShjsdqYmhNhmyP1wxZ7m1HVVHp7v+St/I=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++m7EnlgHdyH9U+QCSq1YunoaFwZDmt2vOQo2PGD9SaXAwqQvYgo
 rBiGcWZDbZEwpmjOt3A8ZWR0+StHxWFkBK/9NAZNQeJmDQUe5ZMMy0RidqcGOW7860Y=
X-Gm-Gg: AYBFou35FXWv1Rb/4eGknupY3z89J08Ot+RJFyjy9x3bWY7NwOgINA1IBjy4JuWrx8T
 okIcQGQxMvDmvd9hXXJMj62Ie+q5y5TkHloZQOAwMPIXgUfrEaIoQXHasCBRbvLy1nRpHcZLh4T
 OuNoImS+PhNCEzR6G9pul4iJzEWpc6+ZzD2+iShOOdeH6BOhPBKhCR864VLHbZf7AIlDiYBTOZ9
 3ysDWaM1XfonJ6GZhztWxtvcK+ZNbJB6bl/wT+rZ04kIv9lnibYBj/MRiyR9tuE1Ldra1NoxUHK
 oStsahAEnr2/pmHz/jyoFYkeciXwboFblDycRoS/Y8ysIbwjTNh1k65pU9SoxfmjUxEywrvipCz
 sFv7ZVpWKUBUrr4zYPk/P2nAOGVemM2Hos1HXbRN+oH2en3km8tk91dtVQjM9tByZp7viYd4IvX
 k5+T01wUeekuULQp6srE9nDObeKZ2I1rmnjZdDKWbMvOo6efQztU7k4vyWCXBE5zyPKl83GBpCz
 xiIivRwOwfGqBfRKgOmIzlNlq4ymep2lB9DluNj7ixtqTsURh2NrDNYVqaukmafLXvG+kWiLoNd
 7VKPAu/KrIKaYfE42sJNdGYz+zUthOI893y1GXDCvE2JUOIUVqYAntxW7HYQlx0nx4GiH8enQ0c
 0BUphR61XEGyBafEEa0nz/I92O0t7AMhod4LlydAYuLok6euOm7hQ+fezMHNjcTtGyiYLE5uw9t
 3rgpdSCpOz6jQkXTynZU9DaC5DtlsfWbIh4cClFDMMYiO6WXxrcXXtExxY1ZNJcw8RPtbKW9dD/
 AvgUQkU9Fpw7bvSrR8Czb96hNud171QgedaTor9mwcmckkAl4EEQ4fRSU10QeE3K2Qdh2rvkEri
 3U9sEvletuaKJE0=
X-Received: by 2002:a05:6000:4011:b0:487:360:58d8 with SMTP id
 ffacd0b85a97d-4870d275186mr10094040f8f.46.1789639651639; 
 Thu, 17 Sep 2026 03:07:31 -0700 (PDT)
Received: from localhost ([94.131.143.12]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bef766dsm13842800f8f.4.2026.09.17.03.07.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Sep 2026 03:07:31 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 17 Sep 2026 13:07:30 +0300
Message-Id: <DLHIB5CCIX5P.9HZLAPIFH4QO@linaro.org>
Cc: "Jens Wiklander" <jens.wiklander@oss.qualcomm.com>, "Sai Sree Kartheek
 Adivi" <s-adivi@ti.com>, "Alexander Heinisch"
 <alexander.heinisch@siemens.com>, "Tanmay Kathpalia"
 <tanmay.kathpalia@altera.com>
Subject: Re: [PATCH v4 2/6] tee: optee: Avoid binding a service twice
From: "Ilias Apalodimas" <ilias.apalodimas@linaro.org>
To: "Jan Kiszka" <jan.kiszka@siemens.com>, "U-Boot Mailing List"
 <u-boot@lists.u-boot-project.org>
X-Mailer: aerc 0.17.0
References: <cover.1789023381.git.jan.kiszka@siemens.com>
 <35c5f18e0eece2d7a8e1cc82d3557a0ab4b4304b.1789023381.git.jan.kiszka@siemens.com>
In-Reply-To: <35c5f18e0eece2d7a8e1cc82d3557a0ab4b4304b.1789023381.git.jan.kiszka@siemens.com>
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

On Thu Sep 10, 2026 at 9:56 AM EEST, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> In case optee_bind_services is invoked more than once successfully, make
> sure that already bound services are not rebound, creating multiple
> instances of themselves. When introducing RPMB-driven service scanning
> this scenario could pop up.
>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>  drivers/tee/optee/core.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> index 2871760a7b7..e8ba8f6cddd 100644
> --- a/drivers/tee/optee/core.c
> +++ b/drivers/tee/optee/core.c
> @@ -83,6 +83,7 @@ static int bind_service_list(struct udevice *dev, struc=
t tee_shm *service_list,
>  {
>  	const struct tee_optee_ta_uuid *service_uuid =3D (const void *)service_=
list->addr;
>  	struct optee_service *service;
> +	struct udevice *service_dev;
>  	size_t idx;
>  	int ret;
>
> @@ -91,6 +92,11 @@ static int bind_service_list(struct udevice *dev, stru=
ct tee_shm *service_list,
>  		if (!service)
>  			continue;
>
> +		ret =3D device_find_child_by_name(dev, service->driver_name,
> +						&service_dev);
> +		if (!ret && dev_get_flags(service_dev) & DM_FLAG_BOUND)
> +			continue;
> +
>  		ret =3D device_bind_driver_to_node(dev, service->driver_name, service-=
>driver_name,
>  						 dev_ofnode(dev), NULL);
>  		if (ret) {

