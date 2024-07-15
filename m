Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99ED0C3DA4B
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 23:05:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E34F788385;
	Tue, 16 Jul 2024 01:05:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="WN9mk1PC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A27AB88385; Tue, 16 Jul 2024 01:05:19 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B90958891F
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 01:05:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1721084710; x=1721689510; i=xypron.glpk@gmx.de;
 bh=tvKegADZHRq984V3jSSra+RiIAi5JJW/AHR+ZUJORfE=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=WN9mk1PCcWVAZyM0U2ClkD68eCodri95/gxeechoqVAIqYNCcPiAbiQdXq8DEpsZ
 4IQJkAFYKZl5+hFMFUmNx/Vz2RG6UQJPaGqZtV+KoXtNi5J/mbYSfFqiek0xm9Fux
 tocJuccwEdUVzbTlIktAocLRmQA0C86cZUCSCfb3fEjQbNs/MoG0f/Y0d8XAhPha4
 BoEDNauFjDBa8KpvlD/B8UtuJDE4HL8kQ2dxcCtZYcfGXiyXSiXNYxa/LIPqj2frZ
 Ix/PH72Oy0TGNXUVI8DkbBsuaZ/9z8O0f5zM2a52AZ6hPtyBnfV6qIi/0WnC3Y2SK
 1dzwF+OAf2Ir3HZObA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([62.143.93.80]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MdNcA-1ruA0E3EQK-00hx0S; Tue, 16
 Jul 2024 01:05:10 +0200
Message-ID: <df31db43-7161-4743-bbef-90f70b2bcd28@gmx.de>
Date: Tue, 16 Jul 2024 01:05:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/13] boot: Correct indentation in efi bootmeth
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Bin Meng <bmeng@tinylab.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Shantur Rathore <i@shantur.com>, U-Boot Mailing List <u-boot@lists.denx.de>
References: <20240715101354.97895-1-sjg@chromium.org>
 <20240715101354.97895-13-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240715101354.97895-13-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JvcA+ubrE1p2ClcFje20q9bfgATD025kOiBsMzgNcLHv/CKNTml
 g7bXbTOoKwsGVu+gB4IAjiC1EZcvEnPp21cmZy1glyXkkpylanTpaL+cgJG31JKd948hCoX
 QtCkFhdgv9OWbfOWuYLqkCR1bn0K3q6V79N5PyaTEsa7xo2sayQR4AEXBBeMJ5ctEBZ2FoE
 E9knrNnKL9x01PhK/d4/g==
UI-OutboundReport: notjunk:1;M01:P0:7ZPRRz+wF90=;oMVatjxKeZSugUeydi7mP++uwJH
 QuqT5JsIeyY/rOlwbBlCjB9/V4W5N6+HVZ1Aw9s3eFfAf7b0FKTmIJXCmkpSK8oD5iqy97fh7
 4ZJvZtDXsqklvXcARip4VtjVdA9jHV+y448aNFKSe9NlYt/PIy7HmjvxYveAtKN1nez0O6aVH
 WpHnEl5hyGQHhmuqEpJ8X9I7cWEB1cbebvkmcYVVNuCJNaLqO/Tojh64RCLLCaT59BelQKcyY
 i8noSdfiQjAbnNds1i6ayEktlxPfHLwmTOWHD4klcqX2UWARNe9s9RB5p+XLj7BTp2KbM2C2/
 rRP3xn4133exvWKF+M+p9OI0q6OMEa/QfTHujHhRt8vETpWZOO7cMutBevr/TLcDtpGW15MGb
 sfGgs6gKYJkkT+WiFAzwWrzYssqy0+iVPq729RzPHIpBajNg61KUjNeT3vUsA+fiXR7Du5COV
 lbLi9AghFa71u6gdCPhSiXWbk8LiGyImtPBcaH33EzKmkVtK5IXdBoCILf1Vw12Mzh4vMyxJE
 o8NKuasi2obtLu8KfwTHKKiXnafx0LmxpbeGB6pvFcN27BLm5+KsyXwltDzl1e46a8da4Oh88
 WdFWPrO/JNx8MsttK3YXSl1IsDxYIC/pr3d1ioIcrMWFrjsd2QNQiLWyadCvZUHcj9ad7uNoZ
 RKYMOlT/eH7E+a/x8fO8LkodJ0X3T7QKZVlBtaUi7fxLACOPb3kX2Kjsw7j2OfkuYobhPsr7B
 O9PsfeJf6ekquziXzJs3XJiEgax8tQ1T8Lsnfec8haEReBtq6ZBViyHT2G81yqiczhI2/6SJC
 bG1Tdyg/aeyskBF6laEK3CDQ==
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

On 7/15/24 12:13, Simon Glass wrote:
> Fix a minor indentation / whitespace problem in a comment.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Heinrich Schuchardt <xypron.glkp@gmx.de>

> ---
>
>   boot/bootmeth_efi.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
> index 56a6e47f5b2..39232eb2e25 100644
> --- a/boot/bootmeth_efi.c
> +++ b/boot/bootmeth_efi.c
> @@ -265,7 +265,7 @@ static int distro_efi_read_bootflow_net(struct bootf=
low *bflow)
>   		return log_msg_ret("sz", -EINVAL);
>   	bflow->size =3D size;
>
> -    /* bootfile should be setup by dhcp*/
> +	/* bootfile should be setup by dhcp */
>   	bootfile_name =3D env_get("bootfile");
>   	if (!bootfile_name)
>   		return log_msg_ret("bootfile_name", ret);

