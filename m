Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5547C67861
	for <u-boot@archiver.kernel.org>; Tue,  9 Apr 2024 04:31:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3657880D5;
	Tue,  9 Apr 2024 06:31:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="AoQcF1qS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0DF38811D; Tue,  9 Apr 2024 06:31:12 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E837880B5
 for <u-boot@lists.denx.de>; Tue,  9 Apr 2024 06:31:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1712637065; x=1713241865; i=xypron.glpk@gmx.de;
 bh=dJZqN95zXBt8nxSmj5OtnnNt261IP4+yf9aqISKmCfI=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=AoQcF1qSJThSk4i8AmjpAtUA0kn8t+uPDAPkvLjrVbhcRja4NDbGFP4bcvfEcfj2
 0S7YaNaJwyFverlTsQvJtYvmrJ7YAKm+EMO/MRPMCR0MlRplF7vrxTmS7ij0tg28Y
 vHQncrs1vlxndaCzdDXjiFhxBVvooaZBgPtMEHhGGVQM4YKZzXh6wdioWkOUJeAP8
 +mSqo2jWEr1gvuBm4jca/41/GkFqKJPWAWYau7AMOFN/+9dAZ3cKZdbw1u1ygHkcd
 IPHK5wsDVom8bcnrbX2zVfgZW7hl9az2/+Qf46TazmlKiMD+pd3jzdMoajj7vxzld
 XF55euezW4Jjfyyrlw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([62.143.245.32]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MAOJP-1s5v6p3qtX-00BqUX; Tue, 09
 Apr 2024 06:31:05 +0200
Message-ID: <185bd37a-9e1d-4daf-8bd6-57ce598e95fc@gmx.de>
Date: Tue, 9 Apr 2024 06:31:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/16] board: am64x: Define capsule update firmware info
To: Jonathan Humphreys <j-humphreys@ti.com>
Cc: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Judith Mendez <jm@ti.com>, Christian Gmeiner <christian.gmeiner@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>, Simon Glass <sjg@chromium.org>,
 Nikhil M Jain <n-jain1@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Andrew Davis <afd@ti.com>, Maxime Ripard <mripard@kernel.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>,
 Bryan Brattlof <bb@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Nishanth Menon <nm@ti.com>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20240408223134.165877-1-j-humphreys@ti.com>
 <20240408223134.165877-3-j-humphreys@ti.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240408223134.165877-3-j-humphreys@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yruGJDJUcSb7NPHZniqg9KLWD1f1lvFYYZWQNkRUZHNTFCkGQsB
 CYFQqZoDA7aqcMn0eTsFJjeuqfxv+HyuzCNIN+gwasASLBSQGZYvzSCxlUdsc9JHugMOcmH
 1OzmtzaK6+WS2WqSWJ7QeVq05V5/rgDE5rx2sm22Hxybr8IfuA9a7k3GpEQVmBpyoYMB+Jo
 agamjPqRw10OABf39AbDA==
UI-OutboundReport: notjunk:1;M01:P0:eFZpE8Fu5KI=;x8kxXwSLf05iiJahr7hiFg38PwM
 NnO078dn7d8rkAbCHiB6p4FTc8NpQ32v08Js51QbmVVFtJVeLtk7cctl2iuQJ1/I5DISyNGAM
 VO11zjFsVPJPcB0U9JzehhuLxBj+ktf0/p0b2swDe2aSO6i1eyIH1gA0iNbAgyb0ljlM7FcIh
 iZjHofQmBYmF5nuMUOIceKKD8/icncEQwb0capUueLtOSbO8H29YLOjbgez+0l/MzrqHSE9aV
 1RFgAsLjV4eXX8HGMj840UIDGAHagAv/tSTC35kCJ0lI7N7Xh5ag+AMkZyUA89vJ3N1CcToRN
 BbSIrzQvPzK0/3zv7YfrdhmBIuP7ZHgVtgJicoaVx66SZ5basxdCnTI4GKO96YeoQbjOuTown
 j9/lL8uzhBCduTr1I/YiFxHyqDrWJRcOEX55+vXNgOSlIPhkzj521wUo6Cj7GqklX7wgo4rEH
 4OhJuVcBOgnOhj5Spz4XK4DtDY9FsfXdP/i8k1m2GsqEuz8uHysWomcpbOMDjsSn/JrbIrEdf
 A/utLiWna42LuWllt8XmknsyUooHGAOMQ/JJ8ZhVJpIwAjzSCY5RIdBo1+Bs0tFa23BcSCFPP
 e+RzT/fKfuyRfQzWw78XkOTwkcTyPSFvB/CSaGouvi6+sfLP0gIeqITTl2yV8wv3HWJvF92DJ
 SjGpQtUTBUS48TT1whDorUw89KrTtWYTZaDbHn6tLJG+dF9ajVoE/jmFFyOfp1DKNA94tPLXN
 HBqkOZNTGQRvuVy8l303l8PIWaPqfWplhBzFYkSjdTvrNk9SzkKND0kxZ1iHhfU0zWGHocQPc
 5fVbzPHFmVuQPgxdbsQy1H1BWJfuIvixiie+ENw6uTY/w=
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

On 4/9/24 00:31, Jonathan Humphreys wrote:
> Define the firmwares updatable via EFI capsule update.

Nits:

%s/firmwares/firmware/ (firmware is uncountable).

>
> Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
> ---
>   board/ti/am64x/evm.c | 33 +++++++++++++++++++++++++++++++++
>   1 file changed, 33 insertions(+)
>
> diff --git a/board/ti/am64x/evm.c b/board/ti/am64x/evm.c
> index b8de69da06c..876c5c25d42 100644
> --- a/board/ti/am64x/evm.c
> +++ b/board/ti/am64x/evm.c
> @@ -7,6 +7,7 @@
>    *
>    */
>
> +#include <efi_loader.h>
>   #include <asm/io.h>
>   #include <dm/uclass.h>
>   #include <k3-ddrss.h>
> @@ -27,6 +28,38 @@
>
>   DECLARE_GLOBAL_DATA_PTR;
>
> +#if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT)
> +struct efi_fw_image fw_images[] =3D {
> +	{
> +		.image_type_id =3D K3_TIBOOT3_IMAGE_GUID,
> +		.fw_name =3D u"K3_TIBOOT3",
> +		.image_index =3D 1,
> +	},
> +	{
> +		.image_type_id =3D K3_SPL_IMAGE_GUID,
> +		.fw_name =3D u"K3_SPL",
> +		.image_index =3D 2,
> +	},
> +	{
> +		.image_type_id =3D K3_UBOOT_IMAGE_GUID,
> +		.fw_name =3D u"K3_UBOOT",
> +		.image_index =3D 3,
> +	}
> +};
> +
> +struct efi_capsule_update_info update_info =3D {
> +	.dfu_string =3D "sf 0:0=3Dtiboot3.bin raw 0 100000;tispl.bin raw 10000=
0 200000;u-boot.img raw 300000 400000",

Is TI using other addresses than Phytec?

doc/board/phytec/phycore-am64x.rst:

   fatload mmc 1 ${loadaddr} tiboot3.bin
   sf update $loadaddr 0x0 $filesize
   fatload mmc 1 ${loadaddr} tispl.bin
   sf update $loadaddr 0x80000 $filesize
   fatload mmc 1 ${loadaddr} u-boot.img
   sf update $loadaddr 0x280000 $filesize

Please, add documentation in doc/board/ for all boards in the series
specifying the location of the firmware in flash memory and how to
update it(cf. section OSPI in doc/board/ti/am65x_evm.rst).

> +	.num_images =3D ARRAY_SIZE(fw_images),
> +	.images =3D fw_images,
> +};

The series has been assigned to me in Patchwork.

But changes should be tested and reviewed by the respective board
maintainers (Vignesh, Tom for AM64x) as I have no access to TI boards.

Best regards

Heinrich

> +
> +void set_dfu_alt_info(char *interface, char *devstr)
> +{
> +	env_set("dfu_alt_info", update_info.dfu_string);
> +}
> +
> +#endif /* EFI_HAVE_CAPSULE_SUPPORT */
> +
>   int board_init(void)
>   {
>   	return 0;

