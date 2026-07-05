Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C42B6C43458
	for <u-boot@archiver.kernel.org>; Mon,  6 Jul 2026 05:06:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDA8C807C4;
	Mon,  6 Jul 2026 07:06:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.com header.i=boogiepop@gmx.com header.b="RO2LxpdA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA85684832; Sun,  5 Jul 2026 22:03:04 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4EFF846F8
 for <u-boot@lists.denx.de>; Sun,  5 Jul 2026 22:03:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=boogiepop@gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
 s=s31663417; t=1783281782; x=1783886582; i=boogiepop@gmx.com;
 bh=T4BeLVnidWSzDpFuK1Yat0QmiYH2PyxyRvRWTvEFTfA=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=RO2LxpdAMMw7lDY5ke4JMSxj7UOM11pGLTt9A7qEBpbG/EZMWblIjkIli1ty4Tvo
 Q24sbbvRamP0+OuxQG5Jothay0CjYeoeOW+xre2/BtmPViLfeAgINtjLSPtVtxJwL
 W2QXwGFoSNMXkAuFw1VveQguoe46htaSCafdK2rfFviJDE6a1u6MX162+/q727YDB
 re2A6uT5hUnXxkynZV3lEf245HNYOefvMzq/ORiT+0dOfcOa8kcxoGEnM/F2l0rpd
 bSMXhh+TvRefM2dSRa3zUR5Ywdg5662tPEavXm1OyBQbuONnI3aQnFk5AMbGmgxTn
 5VSe5I8smUNA/5mYuQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M4JqV-1wgkAZ1ASP-00CQiw for
 <u-boot@lists.denx.de>; Sun, 05 Jul 2026 22:03:02 +0200
Message-ID: <731284c2-1dc8-4981-9c6a-e606bc45edb0@gmx.com>
Date: Sun, 5 Jul 2026 22:03:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mtd: nand: raw: rockchip_nfc: fix oobfree length
 calculation
To: u-boot@lists.denx.de
References: <12b6e0d5-637e-446e-9e4b-82c82e6fad40@gmail.com>
Content-Language: en-US
From: boogie <boogiepop@gmx.com>
In-Reply-To: <12b6e0d5-637e-446e-9e4b-82c82e6fad40@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DAlA5O1O5iGnKG6GzAL7DXGIGIuHNfbXB44MYy+s7m3EZy65UWC
 9RAX0QSMTdszwYo6RE/0o6Kmr6NVNztbQPoOLxcDxk8OeW04sxE4SLJ29gWHNmqxsf+hs25
 U3fonUlMIKCXHHYtt/oaaicHn/efZgzZGEyiQuLLoEH1Xpf82lbA87Uqn8IL7bis3qZ8y4r
 E67yN4pTZcCAOuVaA280Q==
UI-OutboundReport: notjunk:1;M01:P0:c0V1ah0ksk0=;ODhjDEWpNTPyF55RhUNPKKJXqPS
 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
 wh+2boqO5YFOaf9L0fsFW9PyBvQ=
X-Mailman-Approved-At: Mon, 06 Jul 2026 07:06:30 +0200
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

Hi Johan,

Thanks for the patch, i have tested this patch on my Medion MD98486=20
tablet, and it successfully fixes the issue.

Tested-by: H=C3=BCseyin BIYIK <boogiepop@gmx.com>

On 6/30/26 15:32, Johan Jonker wrote:
> The oobfree[0].length calculation depends on the
> rknand->metadata_size value, but this is calculated
> after the function rk_nfc_ecc_init is called. Move this
> calculation to a location before it's value is required.
>=20
> Fixes: 1b3fcb3c0456 ("mtd: nand: raw: rockchip_nfc: add layout structure=
")
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>   drivers/mtd/nand/raw/rockchip_nfc.c | 18 +++++++++---------
>   1 file changed, 9 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/mtd/nand/raw/rockchip_nfc.c b/drivers/mtd/nand/raw/=
rockchip_nfc.c
> index f730e15d0410..ea8e67d1a23e 100644
> --- a/drivers/mtd/nand/raw/rockchip_nfc.c
> +++ b/drivers/mtd/nand/raw/rockchip_nfc.c
> @@ -861,6 +861,15 @@ static int rk_nfc_ecc_init(struct rk_nfc *nfc, stru=
ct nand_chip *chip)
>   	ecc->steps =3D mtd->writesize / ecc->size;
>   	ecc->bytes =3D DIV_ROUND_UP(ecc->strength * fls(8 * chip->ecc.size), =
8);
>  =20
> +	rknand->metadata_size =3D NFC_SYS_DATA_SIZE * ecc->steps;
> +
> +	if (rknand->metadata_size < NFC_SYS_DATA_SIZE + 2) {
> +		dev_err(nfc->dev,
> +			"driver needs at least %d bytes of meta data\n",
> +			NFC_SYS_DATA_SIZE + 2);
> +		return -EIO;
> +	}
> +
>   	if (ecc->bytes * ecc->steps > mtd->oobsize - rknand->metadata_size)
>   		return -EINVAL;
>  =20
> @@ -974,15 +983,6 @@ static int rk_nfc_nand_chip_init(ofnode node, struc=
t rk_nfc *nfc, int devnum)
>   	ret =3D ofnode_read_u32(node, "rockchip,boot-ecc-strength", &tmp);
>   	rknand->boot_ecc =3D ret ? ecc->strength : tmp;
>  =20
> -	rknand->metadata_size =3D NFC_SYS_DATA_SIZE * ecc->steps;
> -
> -	if (rknand->metadata_size < NFC_SYS_DATA_SIZE + 2) {
> -		dev_err(dev,
> -			"driver needs at least %d bytes of meta data\n",
> -			NFC_SYS_DATA_SIZE + 2);
> -		return -EIO;
> -	}
> -
>   	if (!nfc->page_buf) {
>   		nfc->page_buf =3D kzalloc(NFC_MAX_PAGE_SIZE, GFP_KERNEL);
>   		if (!nfc->page_buf) {

