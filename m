Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7370BC54798
	for <u-boot@archiver.kernel.org>; Tue, 27 Feb 2024 13:24:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E293487F88;
	Tue, 27 Feb 2024 14:24:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="CIgIuC9+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81E8587BF4; Tue, 27 Feb 2024 14:24:03 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D9E987FD2
 for <u-boot@lists.denx.de>; Tue, 27 Feb 2024 14:24:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1709040202; x=1709645002; i=xypron.glpk@gmx.de;
 bh=M0dhkUN99JMnOqtSM4p/6skSPLT3pp1Wkbo7cxMV/6E=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=CIgIuC9+0OPDlChEmDFPQcwIo4bQNjb4FHoeoGyLD/Qi+VLGkXzkIONUrlFnBE4O
 Ax2HLOodbJm77YT6s5dfrMFpazqonq5meoZFxh5GAjFeHUQrpU/qvz1kYBv8UoYxt
 TjCN8KT6N7AyS8pbxtkixyG8EMU1NJYUxSofvfiroZyga2ud/tyxFrLV6Hry/Yf7C
 jwY0OdL6pJ7UQHgWGkdGbNUf2BEGyIQA4K0j/gdQjswApHvoGxkGD56tChFcr9s3C
 QZnJBZlQEy6wYpAH0NR8JaMrHb7bu6C6dGsmVbEB5ZKmuThnq8hNfd0gr6a6W6uP2
 p+IBBLo+iGVhqfRwUg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.67] ([95.222.37.56]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MdNcA-1r5cfy09Ds-00ZMaZ; Tue, 27
 Feb 2024 14:23:22 +0100
Message-ID: <f293e3f8-f475-496d-b1f8-2cee265ed24a@gmx.de>
Date: Tue, 27 Feb 2024 14:23:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/4] spinand: bind mtdblock
Content-Language: en-US
To: Alexey Romanov <avromanov@salutedevices.com>
Cc: kernel@salutedevices.com, u-boot@lists.denx.de,
 dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com,
 frieder.schrempf@kontron.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 bmeng@tinylab.org, tobias@waldekranz.com, jpewhacker@gmail.com,
 marek.vasut+renesas@mailbox.org, kever.yang@rock-chips.com,
 jbx6244@gmail.com, abdellatif.elkhlifi@arm.com, michal.simek@amd.com,
 mikhail.kshevetskiy@iopsys.eu, patrice.chotard@foss.st.com
References: <20240227100441.1811047-1-avromanov@salutedevices.com>
 <20240227100441.1811047-4-avromanov@salutedevices.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240227100441.1811047-4-avromanov@salutedevices.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3iHl9Cj2OCKMVl9QY0BWgfuKm9fGd4nkl8IeTeg69hHVO7/lquv
 AbAUw2yy+3ATOoFl2yv1IDHq0JYuUeTNlmoKXYKKAdwJH8aDh6v3qQ1kXr3yR0/b3Eknz36
 NS1une609yL3XhFMGxjlXfM80FNxTnTcz51wp3U/RSMFK56q0G5IxHK0KKSUCLJ/2BLhoY8
 ywWUqM3cWOlYaKl9WC6BQ==
UI-OutboundReport: notjunk:1;M01:P0:LQLzfJgSE/w=;kE0VagRC6/aylbtkJ1cRklS6uCd
 s9Pr7hXfYIarlMxF0QZdNxyV1X+4SwWTeO9wAUaq0RkmHAWzzqLSz+AA6lxp6+F4iN+zuDSuV
 NPihoQehRdy/1Mp/2QSj8TiD0aKC8hNC4TyMDe0gMUO2wx6GY/nPzXQU9Oipd+nMBO6SRXWdy
 nZdTuW1q10neX+Tvoqt0JcmkN+0RWTu30/5DxN//PGFQLecUPiY7z7tZpidRODGuStU3R1kuV
 JQGydCy3b98TRksnUROI04OFiEQ3uczeaJ0dadfrIwOHzIE4HFqHkKkczkErRtnd8NFnPd3dz
 fRUTNwyMPANzTeYMmf5lZpqxWkux6uNAHzrXRnIuYH9VJK9mPF6g2r8geCh0+kAg8xGCiLT3P
 cBAH7gdTbQQKXIuyZkdWqGII07R38pMsdrLcWNDEDp2Yax/TvtSGUsfh0ZRzZ/gOArU8jPxhG
 7hZ9EfrSg+anshIZf5F9EHmOQcH9IhjDiPpK4f3rlg/R+f0ats0bi12YtywXO/bGsEHQ7Nv13
 pae/2wT/sHUgcpDCq1lMpMJiWLgQIIdCyJj+sHBGleNtT7SZHdznIo5ftgbeRnIHLk7LUFHyg
 4xQvisPRJ7Xx3MLNLfKv09p/hYcjcXgue7s5UGNrO/hs0skEphOJfJH8Aj4EFNjQvnH3Wpfe2
 CWyDEvqAGruJcLr0HOwxQQx0sUjQOVIdSrb9e8vzx2oyvbuualumGNox6Wl15o6jnCcSbpwr0
 v5hskk+EbCzzpqAAct5kECBCHVohEXlhD3R2x6DDw5SIQwG1nwT/3amDSxDGcFypclO2e10S9
 0dJivL6OBJaNtiJeRi5ksM7lirPWnUJyLHWyL9nwKXvbI=
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

On 27.02.24 11:04, Alexey Romanov wrote:
> Bind SPI-NAND driver to MTD block driver.
>
> Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> ---
>   drivers/mtd/nand/spi/core.c | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
>
> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
> index 2a3dbcfcb4..1d9cf66e4a 100644
> --- a/drivers/mtd/nand/spi/core.c
> +++ b/drivers/mtd/nand/spi/core.c
> @@ -36,6 +36,10 @@
>   #include <linux/printk.h>
>   #endif
>
> +struct spinand_plat {
> +	struct mtd_info *mtd;
> +};
> +
>   /* SPI NAND index visible in MTD names */
>   static int spi_nand_idx;
>
> @@ -1174,12 +1178,22 @@ static void spinand_cleanup(struct spinand_devic=
e *spinand)
>   	kfree(spinand->scratchbuf);
>   }
>
> +#if CONFIG_IS_ENABLED(BLK)
> +static int spinand_bind(struct udevice *dev)
> +{
> +	struct spinand_plat *plat =3D dev_get_plat(dev);
> +
> +	return mtd_bind(dev, &plat->mtd);
> +}
> +#endif
> +
>   static int spinand_probe(struct udevice *dev)
>   {
>   	struct spinand_device *spinand =3D dev_get_priv(dev);
>   	struct spi_slave *slave =3D dev_get_parent_priv(dev);
>   	struct mtd_info *mtd =3D dev_get_uclass_priv(dev);
>   	struct nand_device *nand =3D spinand_to_nand(spinand);
> +	struct spinand_plat *plat =3D dev_get_plat(dev);
>   	int ret;
>
>   #ifndef __UBOOT__
> @@ -1219,6 +1233,8 @@ static int spinand_probe(struct udevice *dev)
>   	if (ret)
>   		goto err_spinand_cleanup;
>
> +	plat->mtd =3D mtd;
> +
>   	return 0;
>
>   err_spinand_cleanup:
> @@ -1288,6 +1304,10 @@ U_BOOT_DRIVER(spinand) =3D {
>   	.of_match =3D spinand_ids,
>   	.priv_auto	=3D sizeof(struct spinand_device),
>   	.probe =3D spinand_probe,
> +#if CONFIG_IS_ENABLED(BLK)


Please, have a look at doc/develop/designprinciples.rst:168:

     * Avoid ``#ifdefs`` where possible

Please, use 'if CONFIG_IS_ENABLED(BLK)' in the bind function.

Best regards

Heinrich

> +	.bind =3D spinand_bind,
> +#endif
> +	.plat_auto =3D sizeof(struct spinand_plat),
>   };
>
>   void board_nand_init(void)

