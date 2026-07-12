Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2DF1C43458
	for <u-boot@archiver.kernel.org>; Sun, 12 Jul 2026 17:53:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F382F848A1;
	Sun, 12 Jul 2026 19:53:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.com header.i=boogiepop@gmx.com header.b="gRdIhDQH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FAB9849A9; Sun, 12 Jul 2026 19:53:25 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 348CE84852
 for <u-boot@lists.denx.de>; Sun, 12 Jul 2026 19:53:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=boogiepop@gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
 s=s31663417; t=1783878774; x=1784483574; i=boogiepop@gmx.com;
 bh=jt+CQE7lhiCDLCn3HCqtXy7Bva9ef8KjkMTCY9V9hv8=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=gRdIhDQHayTfnIq5CzpXtALkYPfnxXEpNIW8Lx1YmaPqlWc0QWFI8CGtzDM7clPx
 pru22aGBVwuQBB2zlMePPiLBkgxddf0dLFybDMKUeJXwQIq2wJ7JCnr+LV1ws0f/E
 27htWTPs7bB+iUEJcnQnl0647OGe1+MAmpJCu0j5aFAiZrKw+jlKt27LEIRolJJ/C
 QKYecyQ/ENkZOQJmSzem9O7ulA+ZgiRCK8FlDic7wimeVxSBxFkb/pMl5FwUkQqwP
 9Tts7KKovPJ5qDOWbXqs/ODmYgpLc0/06yyoT/gI6aXhKFxWMzDzBsRsg6ALiaKVC
 uW4kutdFbTsqD93H9Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M3DJl-1wm0EK3Zdd-004oD7; Sun, 12
 Jul 2026 19:52:53 +0200
Message-ID: <c3aab298-52cb-457b-9e56-c5213e83d4ee@gmx.com>
Date: Sun, 12 Jul 2026 19:52:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mtd: nand: raw: rockchip_nfc: fix ecc setup
To: Johan Jonker <jbx6244@gmail.com>, u-boot@0leil.net
Cc: kever.yang@rock-chips.com, sjg@chromium.org,
 dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com,
 trini@konsulko.com, u-boot@lists.denx.de
References: <c386c38c-4abf-4ac6-b9a1-a007438c0c5d@gmail.com>
Content-Language: en-US
From: boogie <boogiepop@gmx.com>
In-Reply-To: <c386c38c-4abf-4ac6-b9a1-a007438c0c5d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:I4b5Pp11kw0BqWRCP6DBBuaPZUUFCB7JFXT8cQrO1pmAZw1AzRH
 KQVtvdr+Q4n9kK61OtgQ9O7l/hjI8iMT8KW49Do34GHfKU9IpKstV3bRb8QTYtJWrb5j9V3
 xyPvYCkBUoUvoCYkq7SozEZV+EeWqyZaNqiVhqxMTpgcDDThKqK4KaWJFGnCF7LPGvEBIoY
 rMKX1bZU6fcfy9SRSGtiw==
UI-OutboundReport: notjunk:1;M01:P0:5lXgKdqOsWU=;QfHhvcHCjOBYTWH3lC8SR0AKnEx
 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
 z0UB8kEbRCnjl49lwEoTHaFx8JXtZz
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

Thanks for the patch.

This also fixes the bug, where you have an UBI layout spanning multiple=20
chips. First scan after the creation will work fine, but after the=20
device restart it ubi wont work anymore because the 2nd chip's first n=20
boot blocks are written in different layout.

example nand config with 2 chip selects

nand@0 {
	reg =3D <0>, <2>;
	label =3D "rk-nand-0";
	nand-bus-width =3D <8>;
	nand-ecc-mode =3D "hw";
	nand-ecc-step-size =3D <1024>;
	nand-ecc-strength =3D <40>;
	nand-is-boot-medium;
	rockchip,boot-blks =3D <8>;
	rockchip,boot-ecc-strength =3D <24>;
}

Tested-by: H=C3=BCseyin BIYIK <boogiepop@gmx.com>

On 7/12/26 17:56, Johan Jonker wrote:
> The Rockchip boot ROM only checks for nand chip 0 and with
> reduced ecc strength. Currently only the read page functions
> have a condition check added. Fix by adding the same condition
> to all read and write page functions.
>=20
> The NAND_IS_BOOT_MEDIUM option was introduced more recently
> then this driver. Use it to behave identical with the Linux
> driver.
>=20
> Fixes: b12dc5d6fa76 ("mtd: nand: NFC drivers for RK3308, RK2928 and othe=
rs")
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>   drivers/mtd/nand/raw/rockchip_nfc.c | 14 ++++++++------
>   1 file changed, 8 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/mtd/nand/raw/rockchip_nfc.c b/drivers/mtd/nand/raw/=
rockchip_nfc.c
> index ea8e67d1a23e..e788fda22a95 100644
> --- a/drivers/mtd/nand/raw/rockchip_nfc.c
> +++ b/drivers/mtd/nand/raw/rockchip_nfc.c
> @@ -440,7 +440,8 @@ static int rk_nfc_write_page_raw(struct mtd_info *mt=
d,
>   	int i, pages_per_blk;
>  =20
>   	pages_per_blk =3D mtd->erasesize / mtd->writesize;
> -	if ((page < (pages_per_blk * rknand->boot_blks)) &&
> +	if ((chip->options & NAND_IS_BOOT_MEDIUM) &&
> +	    (page < (pages_per_blk * rknand->boot_blks)) &&
>   	    rknand->boot_ecc !=3D ecc->strength) {
>   		/*
>   		 * There's currently no method to notify the MTD framework that
> @@ -560,7 +561,8 @@ static int rk_nfc_write_page_hwecc(struct mtd_info *=
mtd,
>   	 *
>   	 * Configure the ECC algorithm supported by the boot ROM.
>   	 */
> -	if (page < (pages_per_blk * rknand->boot_blks)) {
> +	if ((chip->options & NAND_IS_BOOT_MEDIUM) &&
> +	    (page < (pages_per_blk * rknand->boot_blks))) {
>   		boot_rom_mode =3D 1;
>   		if (rknand->boot_ecc !=3D ecc->strength)
>   			rk_nfc_hw_ecc_setup(chip, rknand->boot_ecc);
> @@ -624,8 +626,8 @@ static int rk_nfc_read_page_raw(struct mtd_info *mtd=
,
>   	int i, pages_per_blk;
>  =20
>   	pages_per_blk =3D mtd->erasesize / mtd->writesize;
> -	if ((page < (pages_per_blk * rknand->boot_blks)) &&
> -	    nfc->selected_bank =3D=3D 0 &&
> +	if ((chip->options & NAND_IS_BOOT_MEDIUM) &&
> +	    (page < (pages_per_blk * rknand->boot_blks)) &&
>   	    rknand->boot_ecc !=3D ecc->strength) {
>   		/*
>   		 * There's currently no method to notify the MTD framework that
> @@ -700,8 +702,8 @@ static int rk_nfc_read_page_hwecc(struct mtd_info *m=
td,
>   	 * are used by the boot ROM.
>   	 * Configure the ECC algorithm supported by the boot ROM.
>   	 */
> -	if (page < (pages_per_blk * rknand->boot_blks) &&
> -	    nfc->selected_bank =3D=3D 0) {
> +	if ((chip->options & NAND_IS_BOOT_MEDIUM) &&
> +	    (page < (pages_per_blk * rknand->boot_blks))) {
>   		boot_rom_mode =3D 1;
>   		if (rknand->boot_ecc !=3D ecc->strength)
>   			rk_nfc_hw_ecc_setup(chip, rknand->boot_ecc);

