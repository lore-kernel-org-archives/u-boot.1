Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83DBAF3ED4B
	for <u-boot@archiver.kernel.org>; Sat, 11 Apr 2026 11:25:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB2AB84154;
	Sat, 11 Apr 2026 13:25:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="ly7B2f7C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEC318416F; Sat, 11 Apr 2026 13:25:48 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18BEB84118
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 13:25:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1775906730; x=1776511530; i=xypron.glpk@gmx.de;
 bh=ftbUYyLcEFoL8Ucz87P39nPbFObNxWgYn3Ggl+DcNB0=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=ly7B2f7CKIRGSsNZUyPQ0suiouJTc8phb9smm1Ek/yO6v/7CefuWXo/iDPsISGP6
 nP681Ll452UjUAjm+7Pm9eUom9ZM/zpVaAe01yKty6O+qTFp5QlKH1y4yft/JmRsM
 OEID9LfWKLRtCe6VG6fc3C0IwXyK8JHNKLyKi/VP08CwxfK7EZ3JzGJyMH4+mgwtg
 A5SavIL80f7mhxARKK37eDKSR0i1bnJF7tFs/dgS0L3GTyIWQ625IY7PZYxlehcAU
 g3A1aMP6LnSsb6AgCn0Xl02pd0KbtVT7g2tjgoFks4PEwZff6jjPKwjoJjPbbUPl9
 ODquhDCX7l5mLmgvGw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MYvY2-1vyNKM0Rrk-00Y5rf; Sat, 11
 Apr 2026 13:25:30 +0200
Date: Sat, 11 Apr 2026 13:25:25 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Guillaume Ranquet <ranquet.guillaume@gmail.com>, u-boot@lists.denx.de
CC: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Tom Rini <trini@konsulko.com>,
 Jeremy Compostella <jeremy.compostella@intel.com>,
 Peng Fan <peng.fan@nxp.com>, Yao Zi <me@ziyao.cc>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Shiji Yang <yangshiji66@outlook.com>, Jonas Karlman <jonas@kwiboo.se>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Guillaume Ranquet <granquet@missingno.tech>
Subject: Re: [PATCH v2] arch/x86/lib: implement cmdline configuration property
User-Agent: Thunderbird for Android
In-Reply-To: <20260403-cmdline-v2-1-83e22c82f02f@missingno.tech>
References: <20260403-cmdline-v2-1-83e22c82f02f@missingno.tech>
Message-ID: <4D95B3CE-66CD-45E0-9DB8-2CDD45622920@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xTeF26Orn/hWmU5zGeNHwJ+SZ72TdL+Nl0Su9KDooIpYNTXN0Qz
 WeWcMBh44fsPYyJuwZHeAufVik7/AyPvYg0a3Gn5ky2rHnkFbiQE2e62IxdJx04ml42ijQD
 +hTkT+B7nlh5NtoR9ZFAQpE5BvFgXACIgS4z90MzlVjMlvYryyYVENSbt8gmgimxPu4EPZP
 74MmCvGUQBVUDMVrHwMDQ==
UI-OutboundReport: notjunk:1;M01:P0:jwTjzkEwPAg=;v8jMTTIJXbnc6wrjfQELAhlcIEs
 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
 pz/KcyuvYVapIGQ==
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

Am 3=2E April 2026 16:28:23 MESZ schrieb Guillaume Ranquet <ranquet=2Eguill=
aume@gmail=2Ecom>:
>Implement the cmdline configuration property as described in the spec
>[1]


I can't see in the spec that the command line property is x86 specific=2E =
Why would you try to implement it in arch/x86?

Best regards

Heirich

>
>[1]: https://fitspec=2Eosfw=2Efoundation/#id10
>
>Signed-off-by: Guillaume Ranquet <granquet@missingno=2Etech>
>---
>Changes in v2:
>- EDITME: describe what is new in this series revision=2E
>- EDITME: use bulletpoints and terse descriptions=2E
>- Link to v1: https://lore=2Ekernel=2Eorg/r/20260401-cmdline-v1-1-c56577f=
82960@missingno=2Etech
>---
> arch/x86/include/asm/zimage=2Eh |  2 +-
> arch/x86/lib/bootm=2Ec          | 10 +++++++++-
> arch/x86/lib/zimage=2Ec         |  6 +++---
> boot/image-fit=2Ec              | 30 +++++++++++++++++++++++++++++-
> include/image=2Eh               |  3 +++
> 5 files changed, 45 insertions(+), 6 deletions(-)
>
>diff --git a/arch/x86/include/asm/zimage=2Eh b/arch/x86/include/asm/zimag=
e=2Eh
>index 8b5426051701c8266395afd9232eb1ff30d38304=2E=2Eee0114a227a2b067a3a31=
26d7d80ab0cc89cea6e 100644
>--- a/arch/x86/include/asm/zimage=2Eh
>+++ b/arch/x86/include/asm/zimage=2Eh
>@@ -132,7 +132,7 @@ struct boot_params *load_zimage(char *image, unsigned=
 long kernel_size,
>  * Return: 0 (always)
>  */
> int setup_zimage(struct boot_params *setup_base, char *cmd_line, int aut=
o_boot,
>-		 ulong initrd_addr, ulong initrd_size, ulong cmdline_force);
>+		 ulong initrd_addr, ulong initrd_size, const char *cmdline_force);
>=20
> /**
>  * zboot_start() - Prepare to boot a zimage
>diff --git a/arch/x86/lib/bootm=2Ec b/arch/x86/lib/bootm=2Ec
>index cde4fbf35574a267b856a668659ece7e0a36367f=2E=2Ee029cc1ff18bd53eb873c=
0e56fd9d3b0a331b4c2 100644
>--- a/arch/x86/lib/bootm=2Ec
>+++ b/arch/x86/lib/bootm=2Ec
>@@ -61,6 +61,7 @@ int arch_fixup_memory_node(void *blob)
> static int boot_prep_linux(struct bootm_headers *images)
> {
> 	char *cmd_line_dest =3D NULL;
>+	const char *cmd_line_override =3D NULL;
> 	struct legacy_img_hdr *hdr;
> 	int is_zimage =3D 0;
> 	void *data =3D NULL;
>@@ -99,6 +100,13 @@ static int boot_prep_linux(struct bootm_headers *imag=
es)
> 			puts("Can't get image data/size!\n");
> 			goto error;
> 		}
>+
>+		ret =3D fit_image_get_cmdline(images->fit_hdr_os,
>+					    images->fit_noffset_cfg,
>+					    &cmd_line_override);
>+		if (ret)
>+			debug("unable to retrieve cmdline for zimage\n");
>+
> 		is_zimage =3D 1;
> #endif
> 	}
>@@ -125,7 +133,7 @@ static int boot_prep_linux(struct bootm_headers *imag=
es)
> 	printf("Setup at %#08lx\n", images->ep);
> 	ret =3D setup_zimage((void *)images->ep, cmd_line_dest,
> 			0, images->rd_start,
>-			images->rd_end - images->rd_start, 0);
>+			images->rd_end - images->rd_start, cmd_line_override);
>=20
> 	if (ret) {
> 		printf("## Setting up boot parameters failed =2E=2E=2E\n");
>diff --git a/arch/x86/lib/zimage=2Ec b/arch/x86/lib/zimage=2Ec
>index a5f2231aa523356de93368338b5fd249b8abad6e=2E=2Eaf7ee8dbcf3e8f402cb0c=
76767b8a587f205ad5d 100644
>--- a/arch/x86/lib/zimage=2Ec
>+++ b/arch/x86/lib/zimage=2Ec
>@@ -276,7 +276,7 @@ struct boot_params *load_zimage(char *image, unsigned=
 long kernel_size,
> }
>=20
> int setup_zimage(struct boot_params *setup_base, char *cmd_line, int aut=
o_boot,
>-		 ulong initrd_addr, ulong initrd_size, ulong cmdline_force)
>+		 ulong initrd_addr, ulong initrd_size, const char *cmdline_force)
> {
> 	struct setup_header *hdr =3D &setup_base->hdr;
> 	int bootproto =3D get_boot_protocol(hdr, false);
>@@ -333,7 +333,7 @@ int setup_zimage(struct boot_params *setup_base, char=
 *cmd_line, int auto_boot,
>=20
> 		/* build command line at COMMAND_LINE_OFFSET */
> 		if (cmdline_force)
>-			strcpy(cmd_line, (char *)cmdline_force);
>+			strcpy(cmd_line, cmdline_force);
> 		else
> 			build_command_line(cmd_line, auto_boot);
> 		if (IS_ENABLED(CONFIG_CMD_BOOTM)) {
>@@ -404,7 +404,7 @@ int zboot_setup(void)
>=20
> 	ret =3D setup_zimage(base_ptr, (char *)base_ptr + COMMAND_LINE_OFFSET,
> 			   0, state=2Einitrd_addr, state=2Einitrd_size,
>-			   (ulong)state=2Ecmdline);
>+			   state=2Ecmdline);
> 	if (ret)
> 		return -EINVAL;
>=20
>diff --git a/boot/image-fit=2Ec b/boot/image-fit=2Ec
>index e7c7212195f4a291e26ed6d3440a1b42274dacab=2E=2E1790af4a8e5a9c7d11f7d=
ee5f67226071f8f057e 100644
>--- a/boot/image-fit=2Ec
>+++ b/boot/image-fit=2Ec
>@@ -1096,6 +1096,32 @@ int fit_image_get_data(const void *fit, int noffse=
t, const void **data,
> 	return ret;
> }
>=20
>+/**
>+ * fit_image_get_cmdline - get image configuration command line
>+ * @fit: pointer to the FIT format image header
>+ * @cfg_noffset: configuration node offset
>+ * @cmdline: double pointer to char, will hold pointer to the cmdline
>+ *
>+ * fit_image_get_cmdline() gets the cmdline from the configuration node=
=2E
>+ * If the property is found its data start address is returned to the ca=
ller=2E
>+ *
>+ * returns:
>+ *     0, on success
>+ *     -1, on failure
>+ */
>+int fit_image_get_cmdline(const void *fit, int noffset, const char **cmd=
line)
>+{
>+	int len;
>+
>+	*cmdline =3D (const char *)fdt_getprop(fit, noffset, FIT_CMDLINE_PROP, =
&len);
>+	if (!*cmdline) {
>+		fit_get_debug(fit, noffset, FIT_CMDLINE_PROP, len);
>+		return -1;
>+	}
>+
>+	return 0;
>+}
>+
> /**
>  * fit_image_hash_get_algo - get hash algorithm name
>  * @fit: pointer to the FIT format image header
>@@ -2136,8 +2162,10 @@ int fit_image_load(struct bootm_headers *images, u=
long addr,
> 		fit_base_uname_config =3D fdt_get_name(fit, cfg_noffset, NULL);
> 		printf("   Using '%s' configuration\n", fit_base_uname_config);
> 		/* Remember this config */
>-		if (image_type =3D=3D IH_TYPE_KERNEL)
>+		if (image_type =3D=3D IH_TYPE_KERNEL) {
> 			images->fit_uname_cfg =3D fit_base_uname_config;
>+			images->fit_noffset_cfg =3D cfg_noffset;
>+		}
>=20
> 		if (FIT_IMAGE_ENABLE_VERIFY && images->verify) {
> 			puts("   Verifying Hash Integrity =2E=2E=2E ");
>diff --git a/include/image=2Eh b/include/image=2Eh
>index 34efac6056dd29307df359dce21e4f94d5fcbf2d=2E=2E9916e67168e3a4f5412fc=
26d318af32047c239e2 100644
>--- a/include/image=2Eh
>+++ b/include/image=2Eh
>@@ -365,6 +365,7 @@ struct bootm_headers {
> 	 * format, even for SPL, this extra data size seems worth it=2E
> 	 */
> 	const char	*fit_uname_cfg;	/* configuration node unit name */
>+	int		fit_noffset_cfg;	/* configuration node offset */
>=20
> 	void		*fit_hdr_os;	/* os FIT image header */
> 	const char	*fit_uname_os;	/* os subimage node unit name */
>@@ -1108,6 +1109,7 @@ int booti_setup(ulong image, ulong *relocated_addr,=
 ulong *size,
> #define FIT_TFA_BL31_PROP	"tfa-bl31"
> #define FIT_TEE_PROP		"tee"
> #define FIT_COMPAT_PROP		"compatible"
>+#define FIT_CMDLINE_PROP	"cmdline"
>=20
> #define FIT_MAX_HASH_LEN	HASH_MAX_DIGEST_SIZE
>=20
>@@ -1259,6 +1261,7 @@ int fit_get_data_node(const void *fit, const char *=
image_uname,
> int fit_get_data_conf_prop(const void *fit, const char *prop_name,
> 			   const void **data, size_t *size);
>=20
>+int fit_image_get_cmdline(const void *fit, int noffset, const char **cmd=
line);
> int fit_image_hash_get_algo(const void *fit, int noffset, const char **a=
lgo);
> int fit_image_hash_get_value(const void *fit, int noffset, uint8_t **val=
ue,
> 				int *value_len);
>
>---
>base-commit: 98cf83d81617f489d7ff7bf78d33e693e2799254
>change-id: 20260401-cmdline-ab954a4e8828
>
>Best regards,

