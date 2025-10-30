Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DFEACCF9F8
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 07:57:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30B4883946;
	Thu, 30 Oct 2025 08:57:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Spay7b1R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D602C83948; Thu, 30 Oct 2025 08:57:15 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB20F838D7
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 08:57:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1761811019; x=1762415819; i=xypron.glpk@gmx.de;
 bh=Yct1CYzC0z6uio7scQM0JOYcLxl2XwmNtTWoKUJvZ3k=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=Spay7b1RkvFJkFFkUzw9yzIEhI9ymoEk1SAKut8EKZM2hkDi41hTMco99qQEituq
 hDSBNNb69WefjZUtiPLN3/qfayIp7/K/DCH3hHv2rjM5gGMv1wzT//aYQntBe7QpS
 ykey1NlXYJp1Uz1qesN+kC/zcPggiv3NUua7OjV8XzK3q5AO65QWeSRd+7fy2Lmu4
 UXPCuPz9CVxaMR41JIzMBSAFlYf71cd5J6GTOLZlhwNiM2XZC7WWZxyf6EgfBZgW5
 B5qFGMceu/S7Da/qL33n+GEGSuV5TAfKtVuc4YNbuxAvRsQj0EAZAGeRLlbbWCVGq
 iyJsDbpB9FiL9uVSHA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.25.161.182] ([93.94.208.154]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MkYbu-1vzI8a472s-00lI4G; Thu, 30
 Oct 2025 08:56:59 +0100
Message-ID: <5bbc14d9-52b4-4ab0-8b37-095794feb897@gmx.de>
Date: Thu, 30 Oct 2025 08:56:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] ram: starfive: use SZ_8G for 8GB memory size
To: E Shattow <e@freeshell.de>
Cc: u-boot@lists.denx.de, Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Leo Liang <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>
References: <20251030062354.35413-1-e@freeshell.de>
 <20251030062354.35413-3-e@freeshell.de>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20251030062354.35413-3-e@freeshell.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0cQtUJIQbrz5vABe+XQEnIo2LCkbkW21T/I2oszJagZuEYmkg68
 ZclrnnbBYGyoncwKoxF9EXs2uC9zNJnMP2bG+OS/UWc7W6NzKFr9tKT/WKpdKSwvW4l8Flp
 TB/KJMRvScNIhErfRAkHxNRKsaYf7gOL4ro33dnxvHmxP0aD3Mfr8p1lRLsGAqWtw00SgAo
 r/h0cfFEw7VMMkc8gku+A==
UI-OutboundReport: notjunk:1;M01:P0:e8zhsTqmAWw=;riG80XwGCT1IcRKIAG+hkal9XKS
 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
 wUljA==
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

On 10/30/25 07:23, E Shattow wrote:
> Replace numeric literal with SZ_8G consistent with other uses of types
> from linux/types.h
>=20
> Signed-off-by: E Shattow <e@freeshell.de>

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>   drivers/ram/starfive/starfive_ddr.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/ram/starfive/starfive_ddr.c b/drivers/ram/starfive/=
starfive_ddr.c
> index 9e902f03ee9..f030192f6f4 100644
> --- a/drivers/ram/starfive/starfive_ddr.c
> +++ b/drivers/ram/starfive/starfive_ddr.c
> @@ -43,7 +43,7 @@ static int starfive_ddr_setup(struct udevice *dev, str=
uct starfive_ddr_priv *pri
>   		size =3D DDR_SIZE_4G;
>   		break;
>  =20
> -	case 0x200000000:
> +	case SZ_8G:
>   		size =3D DDR_SIZE_8G;
>   		break;
>  =20

