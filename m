Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB8A4C83F1A
	for <u-boot@archiver.kernel.org>; Sun, 20 Jul 2025 15:31:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DEB8683015;
	Sun, 20 Jul 2025 17:31:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="G3HGfQ0r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C68CA8304F; Sun, 20 Jul 2025 17:31:36 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F04382FCA
 for <u-boot@lists.denx.de>; Sun, 20 Jul 2025 17:31:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1753025471; x=1753630271; i=xypron.glpk@gmx.de;
 bh=qEqeo7JtLOwf/kef1mvWhXUqj/FMpFgbmHereKY9ra8=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=G3HGfQ0rOogNnhA392Z5dcMH9fXAjmn6G2dR8S2yMXvHVSaSkTZ0OKg7yfVMk07i
 0b0ktkkyOnThbD6tdvud5OCFsfy6M4DADed2zXgDdwyFjwicMn4IG4/1xnvxXpRrM
 MOj+Drinfm8pT7vDLZjetK+EWORPIZwsrSlso5tkijzc/YbeD9KQHd2BrQhtosSc6
 L7c2/CymwG+p1briAGS3ezzgpU7UjWkXtl+ebaDxkLW7fz0fHaCbipOvuQi4XNAE+
 7T0kl6+8jR85W7yW6TfKUCS0/B/6D2Y9C5fooyA2nxT7cKtptJn36EjaKSd3hoax5
 /vAn1UxX5r/j2fe1Vw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([46.114.105.188]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MHoRA-1uPosK2CbW-0046OL; Sun, 20
 Jul 2025 17:31:10 +0200
Date: Sun, 20 Jul 2025 17:31:06 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: "Lucien.Jheng" <lucienzx159@gmail.com>, u-boot@lists.denx.de,
 marek.vasut+renesas@mailbox.org, tien.fong.chee@altera.com,
 trini@konsulko.com, sjg@chromium.org, seanga2@gmail.com
CC: lucienzx159@gmail.com, lucien.jheng@airoha.com, frank-w@public-files.de,
 daniel@makrotopia.org, albert-al.lee@airoha.com
Subject: =?US-ASCII?Q?Re=3A_=5BU-Boot=2C_v1=2C_1/1=5D_misc=3A_f?=
 =?US-ASCII?Q?s=5Floader=3A_Add_request=5Ffirmware?=
 =?US-ASCII?Q?=5Finto=5Fbuf=5Fvia=5Fenv_API_for_envi?=
 =?US-ASCII?Q?ronment-based_firmware_loading?=
User-Agent: Thunderbird for Android
In-Reply-To: <20250720150404.25844-1-lucienzx159@gmail.com>
References: <20250720150404.25844-1-lucienzx159@gmail.com>
Message-ID: <D82B6BCE-BBA5-482D-9DF3-FAEC5E9C8122@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lbJkm9eFDoT0xiUQ6bv77IKwfGZcod0jsmbsqX7C3CiwvNfEd46
 I4/zz21WAlWAZcEh/zQqRVJdnayrIALF0NMIDjpPvYelFyaJYRMTeo6NBs7J2+da0az7C7Z
 ubCa64val/FbsboPPRiOFiD2MCcl8O/ejRxjBeBiGobxUHtdPJeUYDgv7lY+HMKW3nhvBI9
 tNwlUVqR8xGDk0AouVBuw==
UI-OutboundReport: notjunk:1;M01:P0:cZ+JZyXyXY4=;b8OlCptxEl1CMlA5rz8ZhcJSt+T
 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
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

Am 20=2E Juli 2025 17:04:04 MESZ schrieb "Lucien=2EJheng" <lucienzx159@gmai=
l=2Ecom>:
>This commit adds request_firmware_into_buf_via_env() to the fs_loader dri=
ver,
>enabling firmware loading into a buffer
>using environment variables for path and size=2E
>It supports multiple entries via indexed variable names
>(e=2Eg=2E, "fw_dir0", "fw_size0")=2E
>This provides flexible, scriptable firmware loading without hardcoded det=
ails=2E

It is unclear where this function will be used=2E Is this a part of a larg=
er patch series that you are planning to send?

>
>Signed-off-by: Lucien=2EJheng <lucienzx159@gmail=2Ecom>
>---
>Change log:
>- Re-sending as previous version and add more maintainers to review=2E
>
> drivers/misc/fs_loader=2Ec | 59 ++++++++++++++++++++++++++++++++++++++++
> include/fs_loader=2Eh      | 18 ++++++++++++
> 2 files changed, 77 insertions(+)
>
>diff --git a/drivers/misc/fs_loader=2Ec b/drivers/misc/fs_loader=2Ec
>index 66803f4b997=2E=2Ea4f4448f5cc 100644
>--- a/drivers/misc/fs_loader=2Ec
>+++ b/drivers/misc/fs_loader=2Ec
>@@ -228,6 +228,65 @@ int request_firmware_into_buf(struct udevice *dev,
> 	return ret;
> }
>
>+/**
>+ * request_firmware_into_buf_via_env - Load firmware using environment v=
ariables=2E

request_firmware_into_buf_via_env() - =2E=2E=2E

>+ * @dev: An instance of a driver=2E
>+ * @buf: Address of buffer to load firmware into=2E
>+ * @offset: Offset of a file for start reading into buffer=2E
>+ * @fw_index: Index of the firmware entry to load=2E
>+ *
>+ * This function loads firmware into the provided buffer using environme=
nt
>+ * variables to determine the firmware file path, address, and size=2E I=
t supports
>+ * multiple firmware entries by using indexed environment variable names=
 such as
>+ * "fw_dir0", "fw_size0", etc=2E

Your patch series should comprise documentation of the new variables=2E

>+ *
>+ * Return: Size of total read, negative value when error=2E
>+ */
>+int request_firmware_into_buf_via_env(struct udevice *dev,
>+				      void *buf, u32 offset,
>+				      unsigned int fw_index)
>+{
>+	char var_name[32];
>+	size_t size;
>+	int ret;
>+
>+	for (unsigned int index =3D 0; index < fw_index; index++) {
>+		snprintf(var_name, sizeof(var_name), "fw_dir%u", index);
>+		const char *name =3D env_get(var_name);
>+
>+		if (!name) {
>+			printf("Error: env var %s not set=2E\n", var_name);
>+			goto fail;
>+		}
>+
>+		snprintf(var_name, sizeof(var_name), "fw_size%u", index);
>+		size =3D env_get_hex(var_name, 0);
>+		if (!size) {
>+			printf("Error: env var %s is invalid or zero=2E\n", var_name);
>+			goto fail;
>+		}
>+
>+		ret =3D request_firmware_into_buf(dev, name, buf, size, offset);
>+		if (ret < 0) {
>+			printf("Error: Failed to load firmware %s, size 0x%zx=2E\n",
>+			       name, size);
>+			return ret;
>+		}
>+
>+		buf =3D (void *)((uintptr_t)buf + size);
>+	}
>+
>+	return 0;
>+fail:
>+	printf("Error: Failed to load firmware via environment variables=2E\n"

Please use log_err()=2E (Multiple instances)

Please remove the "Error: " prefix=2E The word "failed" clearly expresses =
that an error occurred=2E

The usage description below should be moved to the command that calls this=
 function=2E

Best regards

Heinrich

>+	       "Set these environment variables for each firmware index:\n"
>+	       "  fw_dirN   - path to firmware file (e=2Eg=2E, fw_dir0)\n"
>+	       "  fw_sizeN  - size of firmware (e=2Eg=2E, fw_size0)\n"
>+	       "Where N is the firmware index (0, 1, =2E=2E=2E)=2E\n");
>+
>+	return -EINVAL;
>+}
>+
> static int fs_loader_of_to_plat(struct udevice *dev)
> {
> 	u32 phandlepart[2];
>diff --git a/include/fs_loader=2Eh b/include/fs_loader=2Eh
>index 5eb5b7ab4a1=2E=2E0d130daacfc 100644
>--- a/include/fs_loader=2Eh
>+++ b/include/fs_loader=2Eh
>@@ -64,4 +64,22 @@ int request_firmware_into_buf(struct udevice *dev,
>  * Return: 0 on success, negative value on error
>  */
> int get_fs_loader(struct udevice **dev);
>+
>+/**
>+ * request_firmware_into_buf_via_env - Load firmware using environment v=
ariables=2E
>+ * @dev: An instance of a driver=2E
>+ * @buf: Address of buffer to load firmware into=2E
>+ * @offset: Offset of a file for start reading into buffer=2E
>+ * @fw_index: Index of the firmware entry to load=2E
>+ *
>+ * This function loads firmware into the provided buffer using environme=
nt
>+ * variables to determine the firmware file path, address, and size=2E I=
t supports
>+ * multiple firmware entries by using indexed environment variable names=
 such as
>+ * "fw_dir0", "fw_size0", etc=2E
>+ *
>+ * Return: Size of total read, negative value when error=2E
>+ */
>+int request_firmware_into_buf_via_env(struct udevice *dev,
>+				      void *buf, u32 offset,
>+				      unsigned int fw_index);
> #endif
>--
>2=2E34=2E1
>

