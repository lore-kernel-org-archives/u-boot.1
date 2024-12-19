Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FAABE77184
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 22:03:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75E438021A;
	Thu, 19 Dec 2024 23:03:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="pCtyFp/L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32A258021D; Thu, 19 Dec 2024 23:03:24 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABB2780196
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 23:03:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1734645787; x=1735250587; i=xypron.glpk@gmx.de;
 bh=mbZdiXmaEmFVTzk1PE4T81jLe1QCBeeVFQSzdMqHFGA=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=pCtyFp/LMQdqWEx9x6h8btenbiiK+rbe3CGQtE8StfcdunO3xqpFhpLRsDP7vCJK
 vYRQt9jU9YQyNTtiHMf3Dz6kpUNKrDpitl/NO9p64O1JpIIvU9Z/h4DwzMu3SkmvU
 Wi2ZLztxRjlxwg6dqhect1yL/KUtRgIuYgcK5uQbyUTIhz/bsEZTBpRFVwIkLmdfR
 5IFK7YS/QPLr9swUyKaXO/iWDHw9pdqA8KasZJcf1yfaSb5ypgx+a04AvelwpC1JP
 H47Z8tyga2pf5sfBWltarHvFlBwLsNkrkfOKaWHgk+YQwoSScne38vsUoVr7JnNg6
 /BxkLnp9Yrg34auykQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MIMfc-1tIuy7034m-00DU5B; Thu, 19
 Dec 2024 23:03:07 +0100
Date: Thu, 19 Dec 2024 23:03:01 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>, Tim Harvey <tharvey@gateworks.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Devarsh Thakkar <devarsht@ti.com>
CC: u-boot@lists.denx.de, kernel@salutedevices.com, rockosov@gmail.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_1/3=5D_include/fdt=5Fsupport=3A_fix_doc?=
 =?US-ASCII?Q?style_to_comply_with_kernel-doc_requirements?=
User-Agent: Thunderbird for Android
In-Reply-To: <20241220-board_fdt_chosen_bootargs_improvements-v1-1-f6a7181787c5@salutedevices.com>
References: <20241220-board_fdt_chosen_bootargs_improvements-v1-0-f6a7181787c5@salutedevices.com>
 <20241220-board_fdt_chosen_bootargs_improvements-v1-1-f6a7181787c5@salutedevices.com>
Message-ID: <A9293F70-4610-4500-9182-40B51A072D62@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AOndjUmshozsxSiqm+T6BeodcXSsfZSGl6dLrawD8MRCVY8zBrt
 7WSNke1911JhuBQ4/REz1OfbDG3XOylxENi9zLTHbBLjPnd5xmYm1GDV+OQmdShFqZKupMS
 TNiIUfMnnkadqN+MhfEoFxzAEAsQGcpAsa1uqLUKoLTDSyFmIHzjYFd2yrzAGIGxnA6n4yW
 1bKQZ3OPkAjsIYxfvjCeg==
UI-OutboundReport: notjunk:1;M01:P0:cW3KooPWu+w=;RMVQYtz3zinOUogyf4dAJ1A66sZ
 Y9AIyHg8BkCgZEuChq1kgb4cjG9ibQERh9Ij4BZRL8R5C+QaKRkcqdgUzfe21MfDoX9Gjx8xB
 qwthu8hM9hlGyireWEMCdvv6WWrXCep9ex5yGDw22cHhfABrW/g9n4IUa3nLeucmTajxCinyJ
 k/VahmECalvnmJPOHu03vaj5CJzlDU2ClJswGB31w83V9KzOEwyQ2ObpI3+DL1/x3c032bleA
 QXn/6mHQAmnRsu9M5+ADaGaPLylMZObqp8JN9o7dPsaww/NEZQLjDUnmAYl4zgDyl/saCoUIK
 +OeCSNHEXdNHmpdr16eQTddA+6mPl/Q9ETD63M4JFsUZiRJAkODgohwrbI49MlkjaKZg/HDpd
 fJyxQOLc3kP2ThrMQQjOBY4OuJySCcEjVKLXQI49o1m9R7m5iX7aSptRJSuKjwdvjqkMwPF9C
 7CvnWv5rhQ4uUnaL6zD1/+XfelbNCZumTzczcPKuVCZ/hREmdNB7VodLsCITB4QvFRk7uJRXn
 9AePglwvuNzYc9T99NiKt9QsdZ0rMb5FXDoYb2Wl0dYd+x0SK1t9FJITGbd7ETK90godJySNk
 9fyI+EjroDdimLLg8KRKffSdexFgsIFJevuGl4CfLfNjP+Ou3AYssO81gEO+JZK6YOtgL2SyW
 1wOFu2WOvZwT3+TSspnLaesu7IW5CJ4fU/2gMnLXlxRQtJUKgZLk0qASwiYKG+bFVN+0qBZch
 AC5q9MSkilp/6IIo04vVvnQPl+Vkeb5yyboyzTqVdKBnxqbB7pSJpZP0bW6cfU4rH93Tm1edD
 Z1IpTaGpUup9Sy+tMyqPvzaozrchA4oIthY6+hwAoIRvkX55y1foio1DgoYrTOU1jOMNKznwP
 qgvRvdyPITe8TpxXO0ktRex0dTwV6Yuxdd1DxZI3oRpzbM4G4GkrxkEwvLXPOyoPDCc5qX/8T
 H/rNcHy0UboVzfZCUIECD8koXqD+cEf8JLYBqncWYT8jJPPcQLZ0e9U5Ov1iS6DIKVuIeqXUy
 zt2mifRrhCZSXrbb0SQR0q7hWstxt7fv2biuiJNTBOmRwF7tkmGjnEhsbDAxHtVZcGfv4fFmO
 zTssB3xSAZ0/6ajaXs5Hf8N23tFORV
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

Am 19=2E Dezember 2024 22:42:08 MEZ schrieb Dmitry Rokosov <ddrokosov@salut=
edevices=2Ecom>:
>No errors from kernel-doc with this patch applied:
>$ =2E/scripts/kernel-doc -v -none include/fdt_support=2Eh
>    include/fdt_support=2Eh:17: info: Scanning doc for arch_fixup_fdt
>    include/fdt_support=2Eh:37: info: Scanning doc for fdt_root
>    include/fdt_support=2Eh:48: info: Scanning doc for fdt_chosen
>    include/fdt_support=2Eh:59: info: Scanning doc for fdt_initrd
>    include/fdt_support=2Eh:100: info: Scanning doc for fdt_fixup_memory
>    include/fdt_support=2Eh:115: info: Scanning doc for fdt_fixup_memory_=
banks
>    include/fdt_support=2Eh:148: info: Scanning doc for fdt_fixup_display
>    include/fdt_support=2Eh:176: info: Scanning doc for fdt_record_loadab=
le
>    include/fdt_support=2Eh:205: info: Scanning doc for ft_board_setup
>    include/fdt_support=2Eh:218: info: Scanning doc for board_rng_seed
>    include/fdt_support=2Eh:231: info: Scanning doc for board_fdt_chosen_=
bootargs
>    include/fdt_support=2Eh:251: info: Scanning doc for ft_system_setup
>    include/fdt_support=2Eh:266: info: Scanning doc for fdt_shrink_to_min=
imum
>    include/fdt_support=2Eh:301: info: Scanning doc for fdt_copy_fixed_pa=
rtitions
>    include/fdt_support=2Eh:314: info: Scanning doc for fdt_translate_add=
ress
>    include/fdt_support=2Eh:327: info: Scanning doc for fdt_translate_dma=
_address
>    include/fdt_support=2Eh:342: info: Scanning doc for fdt_get_dma_range
>    include/fdt_support=2Eh:464: info: Scanning doc for fdt_get_cells_len
>    include/fdt_support=2Eh:480: info: Scanning doc for fdtdec_get_child_=
count
>    include/fdt_support=2Eh:500: info: Scanning doc for fdt_kaslrseed
>
>Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices=2Ecom>

Thanks for eliminating @param=2E

Acked-by: Heinrich Schuchardt <xypron=2Eglpk@gmx=2Ede>



>---
> include/fdt_support=2Eh | 169 +++++++++++++++++++++++++++++-------------=
--------
> 1 file changed, 100 insertions(+), 69 deletions(-)
>
>diff --git a/include/fdt_support=2Eh b/include/fdt_support=2Eh
>index 9447a64e060da4c4f6e1c1b509dd477c29e040f4=2E=2Eed4f5ba26c19b2d0afcc4=
3c46bdee3c211c0441a 100644
>--- a/include/fdt_support=2Eh
>+++ b/include/fdt_support=2Eh
>@@ -14,11 +14,12 @@
> #include <abuf=2Eh>
>=20
> /**
>- * arch_fixup_fdt() - Write arch-specific information to fdt
>+ * arch_fixup_fdt() - write arch-specific information to fdt
>+ *
>+ * @blob: FDT blob to write to
>  *
>  * Defined in arch/$(ARCH)/lib/bootm-fdt=2Ec
>  *
>- * @blob:	FDT blob to write to
>  * Return: 0 if ok, or -ve FDT_ERR_=2E=2E=2E on failure
>  */
> int arch_fixup_fdt(void *blob);
>@@ -33,27 +34,33 @@ u32 fdt_getprop_u32_default(const void *fdt, const ch=
ar *path,
> 				const char *prop, const u32 dflt);
>=20
> /**
>- * Add data to the root of the FDT before booting the OS=2E
>+ * fdt_root() - add data to the root of the FDT before booting the OS
>+ *
>+ * @fdt: FDT address in memory
>  *
>  * See doc/device-tree-bindings/root=2Etxt
>  *
>- * @param fdt		FDT address in memory
>  * Return: 0 if ok, or -FDT_ERR_=2E=2E=2E on error
>  */
> int fdt_root(void *fdt);
>=20
> /**
>- * Add chosen data the FDT before booting the OS=2E
>+ * fdt_chosen() - add chosen data the FDT before booting the OS
>+ *
>+ * @fdt: FDT address in memory
>  *
>  * In particular, this adds the kernel command line (bootargs) to the FD=
T=2E
>  *
>- * @param fdt		FDT address in memory
>  * Return: 0 if ok, or -FDT_ERR_=2E=2E=2E on error
>  */
> int fdt_chosen(void *fdt);
>=20
> /**
>- * Add initrd information to the FDT before booting the OS=2E
>+ * fdt_initrd() - add initrd information to the FDT before booting the O=
S
>+ *
>+ * @fdt: Pointer to FDT in memory
>+ * @initrd_start: Start of ramdisk
>+ * @initrd_end: End of ramdisk
>  *
>  * Adds linux,initrd-start and linux,initrd-end properties to the /chose=
n node,
>  * creating it if necessary=2E
>@@ -63,9 +70,6 @@ int fdt_chosen(void *fdt);
>  *
>  * If @initrd_start =3D=3D @initrd_end this function does nothing and re=
turns 0=2E
>  *
>- * @fdt: Pointer to FDT in memory
>- * @initrd_start: Start of ramdisk
>- * @initrd_end: End of ramdisk
>  * Return: 0 if ok, or -FDT_ERR_=2E=2E=2E on error
>  */
> int fdt_initrd(void *fdt, ulong initrd_start, ulong initrd_end);
>@@ -93,29 +97,35 @@ void do_fixup_by_compat(void *fdt, const char *compat=
,
> void do_fixup_by_compat_u32(void *fdt, const char *compat,
> 			    const char *prop, u32 val, int create);
> /**
>+ * fdt_fixup_memory() - setup the memory node in the DT
>+ *
>+ * @blob: FDT blob to update
>+ * @start: Begin of DRAM mapping in physical memory
>+ * @size: Size of the single memory bank
>+ *
>  * Setup the memory node in the DT=2E Creates one if none was existing b=
efore=2E
>  * Calls fdt_fixup_memory_banks() to populate a single reg pair covering=
 the
>  * whole memory=2E
>  *
>- * @param blob		FDT blob to update
>- * @param start		Begin of DRAM mapping in physical memory
>- * @param size		Size of the single memory bank
>  * Return: 0 if ok, or -1 or -FDT_ERR_=2E=2E=2E on error
>  */
> int fdt_fixup_memory(void *blob, u64 start, u64 size);
>=20
> /**
>+ * fdt_fixup_memory_banks() - fill the DT mem node with multiple memory =
banks
>+ *
>+ * @blob: FDT blob to update
>+ * @start: Array of size <banks> to hold the start addresses=2E
>+ * @size: Array of size <banks> to hold the size of each region=2E
>+ * @banks: Number of memory banks to create=2E If 0, the reg property
>+ *         will be left untouched=2E
>+ *
>  * Fill the DT memory node with multiple memory banks=2E
>  * Creates the node if none was existing before=2E
>  * If banks is 0, it will not touch the existing reg property=2E This al=
lows
>  * boards to not mess with the existing DT setup, which may have been
>  * filled in properly before=2E
>  *
>- * @param blob		FDT blob to update
>- * @param start		Array of size <banks> to hold the start addresses=2E
>- * @param size		Array of size <banks> to hold the size of each region=2E
>- * @param banks		Number of memory banks to create=2E If 0, the reg
>- *			property will be left untouched=2E
>  * Return: 0 if ok, or -1 or -FDT_ERR_=2E=2E=2E on error
>  */
> #ifdef CONFIG_ARCH_FIXUP_FDT_MEMORY
>@@ -135,14 +145,17 @@ int fdt_find_and_setprop(void *fdt, const char *nod=
e, const char *prop,
> void fdt_fixup_qe_firmware(void *fdt);
>=20
> /**
>+ * fdt_fixup_display() - update native-mode property of display-timings
>+ *
>+ * @blob: FDT blob to update
>+ * @path: path within dt
>+ * @display: name of display timing to match
>+ *
>  * Update native-mode property of display-timings node to the phandle
>  * of the timings matching a display by name (case insensitive)=2E
>  *
>  * see kernel Documentation/devicetree/bindings/video/display-timing=2Et=
xt
>  *
>- * @param blob		FDT blob to update
>- * @param path		path within dt
>- * @param display	name of display timing to match
>  * Return: 0 if ok, or -FDT_ERR_=2E=2E=2E on error
>  */
> int fdt_fixup_display(void *blob, const char *path, const char *display)=
;
>@@ -160,18 +173,21 @@ static inline void fdt_fixup_crypto_node(void *blob=
, int sec_rev) {}
> #endif
>=20
> /**
>+ * fdt_record_loadable() - record info about a loadable in /fit-images
>+ *
>+ * @blob: FDT blob to update
>+ * @index: index of this loadable
>+ * @name: name of the loadable
>+ * @load_addr: address the loadable was loaded to
>+ * @size: number of bytes loaded
>+ * @entry_point: entry point (if specified, otherwise pass -1)
>+ * @type: type (if specified, otherwise pass NULL)
>+ * @os: os-type (if specified, otherwise pass NULL)
>+ * @arch: architecture (if specified, otherwise pass NULL)
>+ *
>  * Record information about a processed loadable in /fit-images (creatin=
g
>  * /fit-images if necessary)=2E
>  *
>- * @param blob		FDT blob to update
>- * @param index	        index of this loadable
>- * @param name          name of the loadable
>- * @param load_addr     address the loadable was loaded to
>- * @param size          number of bytes loaded
>- * @param entry_point   entry point (if specified, otherwise pass -1)
>- * @param type          type (if specified, otherwise pass NULL)
>- * @param os            os-type (if specified, otherwise pass NULL)
>- * @param arch		architecture (if specified, otherwise pass NULL)
>  * Return: 0 if ok, or -1 or -FDT_ERR_=2E=2E=2E on error
>  */
> int fdt_record_loadable(void *blob, u32 index, const char *name,
>@@ -186,37 +202,39 @@ int fdt_pci_dma_ranges(void *blob, int phb_off, str=
uct pci_controller *hose);
> int fdt_find_or_add_subnode(void *fdt, int parentoffset, const char *nam=
e);
>=20
> /**
>- * Add board-specific data to the FDT before booting the OS=2E
>+ * ft_board_setup() - add board-specific data to the FDT before booting =
the OS
>+ *
>+ * @blob: FDT blob to update
>+ * @bd: Pointer to board data
>  *
>  * Use CONFIG_SYS_FDT_PAD to ensure there is sufficient space=2E
>  * This function is called if CONFIG_OF_BOARD_SETUP is defined
>  *
>- * @param blob		FDT blob to update
>- * @param bd		Pointer to board data
>  * Return: 0 if ok, or -FDT_ERR_=2E=2E=2E on error
>  */
> int ft_board_setup(void *blob, struct bd_info *bd);
>=20
> /**
>- * board_rng_seed() - Provide a seed to be passed via /chosen/rng-seed
>+ * board_rng_seed() - provide a seed to be passed via /chosen/rng-seed
>+ *
>+ * @buf: a struct abuf for returning the seed and its size=2E
>  *
>  * This function is called if CONFIG_BOARD_RNG_SEED is set, and must
>  * be provided by the board=2E It should return, via @buf, some suitable
>  * seed value to pass to the kernel=2E Seed size could be set in a decim=
al
>  * environment variable rng_seed_size and it defaults to 64 bytes=2E
>  *
>- * @param buf         A struct abuf for returning the seed and its size=
=2E
>- * @return            0 if ok, negative on error=2E
>+ * Return: 0 if ok, negative on error=2E
>  */
> int board_rng_seed(struct abuf *buf);
>=20
> /**
>- * board_fdt_chosen_bootargs() - Arbitrarily amend fdt kernel command li=
ne
>+ * board_fdt_chosen_bootargs() - arbitrarily amend fdt kernel command li=
ne
>  *
>  * This is used for late modification of kernel command line arguments j=
ust
>  * before they are added into the /chosen node in flat device tree=2E
>  *
>- * @return: pointer to kernel command line arguments in memory
>+ * Return: pointer to kernel command line arguments in memory
>  */
> char *board_fdt_chosen_bootargs(void);
>=20
>@@ -229,13 +247,14 @@ char *board_fdt_chosen_bootargs(void);
> void ft_board_setup_ex(void *blob, struct bd_info *bd);
>=20
> /**
>- * Add system-specific data to the FDT before booting the OS=2E
>+ * ft_system_setup() - add system-specific data to the FDT before bootin=
g the OS
>+ *
>+ * @blob: FDT blob to update
>+ * @bd: pointer to board data
>  *
>  * Use CONFIG_SYS_FDT_PAD to ensure there is sufficient space=2E
>  * This function is called if CONFIG_OF_SYSTEM_SETUP is defined
>  *
>- * @param blob		FDT blob to update
>- * @param bd		Pointer to board data
>  * Return: 0 if ok, or -FDT_ERR_=2E=2E=2E on error
>  */
> int ft_system_setup(void *blob, struct bd_info *bd);
>@@ -245,6 +264,9 @@ void set_working_fdt_addr(ulong addr);
> /**
>  * fdt_shrink_to_minimum() - shrink FDT while allowing for some margin
>  *
>+ * @blob: FDT blob to update
>+ * @extrasize: additional bytes needed
>+ *
>  * Shrink down the given blob to 'minimum' size + some extrasize=2E
>  *
>  * The new size is enough to hold the existing contents plus @extrasize =
bytes,
>@@ -254,8 +276,6 @@ void set_working_fdt_addr(ulong addr);
>  * If there is an existing memory reservation for @blob in the FDT, it i=
s
>  * updated for the new size=2E
>  *
>- * @param blob		FDT blob to update
>- * @param extrasize	additional bytes needed
>  * Return: 0 if ok, or -FDT_ERR_=2E=2E=2E on error
>  */
> int fdt_shrink_to_minimum(void *blob, uint extrasize);
>@@ -277,9 +297,12 @@ static inline void fdt_fixup_mtdparts(void *fdt,
> #endif
>=20
> /**
>- * copy the fixed-partition nodes from U-Boot device tree to external bl=
ob
>+ * fdt_copy_fixed_partitions() - copy the fixed-partition nodes
>+ *
>+ * @blob: FDT blob to update
>+ *
>+ * Copy the fixed-partition nodes from U-Boot device tree to external bl=
ob
>  *
>- * @param blob		FDT blob to update
>  * Return: 0 if ok, or non-zero on error
>  */
> int fdt_copy_fixed_partitions(void *blob);
>@@ -287,39 +310,45 @@ int fdt_copy_fixed_partitions(void *blob);
> void fdt_del_node_and_alias(void *blob, const char *alias);
>=20
> /**
>- * Translate an address from the DT into a CPU physical address
>+ * fdt_translate_address() - translate an addr from the DT into a CPU ph=
ys addr
>+ *
>+ * @blob: pointer to device tree blob
>+ * @node_offset: node DT offset
>+ * @in_addr: pointer to the address to translate
>  *
>  * The translation relies on the "ranges" property=2E
>  *
>- * @param blob		Pointer to device tree blob
>- * @param node_offset	Node DT offset
>- * @param in_addr	Pointer to the address to translate
>  * Return: translated address or OF_BAD_ADDR on error
>  */
> u64 fdt_translate_address(const void *blob, int node_offset,
> 			  const __be32 *in_addr);
> /**
>- * Translate a DMA address from the DT into a CPU physical address
>+ * fdt_translate_dma_address() - translate a DMA address to a CPU phys a=
ddress
>  *
>+ * @blob: pointer to device tree blob
>+ * @node_offset: node DT offset
>+ * @in_addr: pointer to the DMA address to translate
>+ *
>+ * Translate a DMA address from the DT into a CPU physical address=2E
>  * The translation relies on the "dma-ranges" property=2E
>  *
>- * @param blob		Pointer to device tree blob
>- * @param node_offset	Node DT offset
>- * @param in_addr	Pointer to the DMA address to translate
>  * Return: translated DMA address or OF_BAD_ADDR on error
>  */
> u64 fdt_translate_dma_address(const void *blob, int node_offset,
> 			      const __be32 *in_addr);
>=20
> /**
>+ * fdt_get_dma_range() - get DMA ranges to perform bus/cpu translations
>+ *
>+ * @blob: pointer to device tree blob
>+ * @node_offset: node DT offset
>+ * @cpu: pointer to variable storing the range's cpu address
>+ * @bus: pointer to variable storing the range's bus address
>+ * @size: pointer to variable storing the range's size
>+ *
>  * Get DMA ranges for a specifc node, this is useful to perform bus->cpu=
 and
>  * cpu->bus address translations
>  *
>- * @param blob		Pointer to device tree blob
>- * @param node_offset	Node DT offset
>- * @param cpu		Pointer to variable storing the range's cpu address
>- * @param bus		Pointer to variable storing the range's bus address
>- * @param size		Pointer to variable storing the range's size
>  * Return: translated DMA address or OF_BAD_ADDR on error
>  */
> int fdt_get_dma_range(const void *blob, int node_offset, phys_addr_t *cp=
u,
>@@ -431,12 +460,12 @@ int fdt_overlay_apply_verbose(void *fdt, void *fdto=
);
> int fdt_valid(struct fdt_header **blobp);
>=20
> /**
>- * fdt_get_cells_len() - Get the length of a type of cell in top-level n=
odes
>+ * fdt_get_cells_len() - get the length of a type of cell in top-level n=
odes
>  *
>- * Returns the length of the cell type in bytes (4 or 8)=2E
>+ * @blob: pointer to device tree blob
>+ * @nr_cells_name: name to lookup, e=2Eg=2E "#address-cells"
>  *
>- * @blob: Pointer to device tree blob
>- * @nr_cells_name: Name to lookup, e=2Eg=2E "#address-cells"
>+ * Return: the length of the cell type in bytes (4 or 8)=2E
>  */
> int fdt_get_cells_len(const void *blob, char *nr_cells_name);
>=20
>@@ -446,11 +475,12 @@ int fdt_get_cells_len(const void *blob, char *nr_ce=
lls_name);
> int fdtdec_get_int(const void *blob, int node, const char *prop_name,
> 		int default_val);
>=20
>-/*
>- * Count child nodes of one parent node=2E
>+/**
>+ * fdtdec_get_child_count() - count child nodes of one parent node
>+ *
>+ * @blob: FDT blob
>+ * @node: parent node
>  *
>- * @param blob	FDT blob
>- * @param node	parent node
>  * Return: number of child node; 0 if there is not child node
>  */
> int fdtdec_get_child_count(const void *blob, int node);
>@@ -468,9 +498,10 @@ void fdt_fixup_pstore(void *blob);
> /**
>  * fdt_kaslrseed() - create a 'kaslr-seed' node in chosen
>  *
>- * @blob:	fdt blob
>- * @overwrite:	do not overwrite existing non-zero node unless true
>- * Return:	0 if OK, -ve on error
>+ * @blob: fdt blob
>+ * @overwrite: do not overwrite existing non-zero node unless true
>+ *
>+ * Return: 0 if OK, -ve on error
>  */
> int fdt_kaslrseed(void *blob, bool overwrite);
>=20
>

