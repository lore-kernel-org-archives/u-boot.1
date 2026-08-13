Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53121C5B572
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 06:34:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1496A40961;
	Thu, 13 Aug 2026 06:34:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rTqiq2KZjBAB; Thu, 13 Aug 2026 06:34:42 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5E71C40958
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786602882;
	bh=sdPE7K5p0Jc7YZjWJptVR0eOATXXIPuGhyOhF+mPwms=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ulKD5KyCCDbsNOzZqgTPg5BzHDtoF6WDUSdlOqDk37jc9nr1D7owsGh+oVkuM6xrf
	 cwc+FPhd++bADSfLYTW/2LP2QVcSmup1KY52ib/pFKnpzlFI7nBJSx6zzKTcpa/4G2
	 LD7mLPAHtMpxLRGX+0e0OFlXIj/nEEBcvjn4vfUND0R7iWj/PwaJ9PXGpTy3LZ96Sw
	 p69/VTA2CqFEu4tm5pOUXzfpZwPtSblL4DtZI0uQHqpTrExkQpdfCDW3IgiUNJv4TY
	 vRx7DijlX03iyX586ThXtF8Q2HM4k/BYfFG90VmgBk59DLle788Xa2NInerf0Z/8TQ
	 pjLrXTW7uFWTw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5E71C40958;
	Thu, 13 Aug 2026 06:34:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 16F59109
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 06:34:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F13BC40126
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 06:34:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IlKk6LzwBemG for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 06:34:40 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.227.15.18;
 helo=mout.gmx.net; envelope-from=xypron.glpk@gmx.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org A171D40121
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A171D40121
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A171D40121
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 06:34:39 +0000 (UTC)
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MDhlV-1wkjyJ2J7v-00FX7c; Thu, 13
 Aug 2026 08:34:32 +0200
Date: Thu, 13 Aug 2026 08:34:23 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 u-boot@lists.u-boot-project.org
CC: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, 
 =?ISO-8859-1?Q?Vincent_Stehl=E9?= <vincent.stehle@arm.com>,
 Aristo Chen <aristo.chen@canonical.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_4/4=5D_efidebug=3A_capsule=3A_add_a_?=
 =?US-ASCII?Q?command_to_list_updatable_firmware_images?=
User-Agent: Thunderbird for Android
In-Reply-To: <20260813-efi-esrt-last-attempt-v1-4-3be172f47d9d@oss.qualcomm.com>
References: <20260813-efi-esrt-last-attempt-v1-0-3be172f47d9d@oss.qualcomm.com>
 <20260813-efi-esrt-last-attempt-v1-4-3be172f47d9d@oss.qualcomm.com>
Message-ID: <9A49653C-9CF5-40D3-96E0-DC8273640213@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6Btp6g5CiXQ07MhekpiPl0iznJo5AzQHditC40pX9/6Lx1W1igL
 12iUREml1Aa/q8SjFfXz3Yrx4aKQT+eofFBi3mJOaon0xsiguP/OC/+ymktckZuJ7FCGJHK
 RpmT9BjQi9BwNVI8oaJQurx8ICAUE1g4QovKManiKev4emi8eIgAxlge8lM9vAGNoajNKuZ
 fqVW4ldvthbImn9pY+5MA==
UI-OutboundReport: notjunk:1;M01:P0:WAxAde/olBY=;sUZ43AhuiXuvu6NRBAIFsSzc/2e
 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
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmx.de; 
 s=s31663417; t=1786602872; x=1787207672; i=xypron.glpk@gmx.de;
 bh=sdPE7K5p0Jc7YZjWJptVR0eOATXXIPuGhyOhF+mPwms=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=LUOMUhGeAJ76t3IRHeC9wocuffwPfkbi6yIxMMPhYDObTew9It4Yd0i5oFi/x1lV
 LxOL+ilqtcHhTzQpwYSq+22akZNi7uvEx6TG9WHHOCY5NxIihrvY8aYNw8w/ajEjd
 knZqxZVZLRK0q0vVn7zhrYqmQmR71opFwF74nENQnW7BNP0uCL9j331yRGE1sMO1M
 GmEr34EiSb0Q9QHrJr0XsMoooz+oJFDDn09wbdKybXsJuJcSNuezDresYsSAjcmSS
 ElpCYJb05ZJLoZtdIPuJzIogU2xDDUgG5Rt1SyfRr5E2q8k7MY/6uqN+wJFVpaul4
 lRcTQGRbJVnVWCVc7A==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=gmx.de
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmx.de header.i=xypron.glpk@gmx.de
 header.a=rsa-sha256 header.s=s31663417 header.b=LUOMUhGe
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Am 13=2E August 2026 07:50:20 MESZ schrieb Balaji Selvanathan <balaji=2Esel=
vanathan@oss=2Equalcomm=2Ecom>:
>There is no easy way to see which firmware images a capsule can actually
>target on a given board=2E On platforms that build their fw_images[] tabl=
e
>at runtime this is worse, since the set of images vary per board=2E
>
>Add "efidebug capsule images", which walks the installed Firmware
>Management Protocol handles and prints the image descriptors each one
>reports, along with the image index, name and type GUID=2E This is the
>same information capsule matching looks at, so it doubles as a quick way
>to check the GUIDs in a capsule line up with what the board expects
>before attempting an update=2E
>
>Signed-off-by: Balaji Selvanathan <balaji=2Eselvanathan@oss=2Equalcomm=2E=
com>
>---
> cmd/efidebug=2Ec                                     | 102 +++++++++++++=
++++++++
> =2E=2E=2E/test_efi_capsule/test_capsule_firmware_raw=2Epy  |  22 +++++

The documentation update is missing=2E

Best regards

Heinrich

> 2 files changed, 124 insertions(+)
>
>diff --git a/cmd/efidebug=2Ec b/cmd/efidebug=2Ec
>index e55de04c699=2E=2Ea9e445d03fa 100644
>--- a/cmd/efidebug=2Ec
>+++ b/cmd/efidebug=2Ec
>@@ -294,6 +294,104 @@ static int do_efi_capsule_res(struct cmd_tbl *cmdtp=
, int flag,
> 	return CMD_RET_SUCCESS;
> }
>=20
>+/**
>+ * do_efi_capsule_images() - list firmware images updatable by capsule
>+ *
>+ * @cmdtp:	Command table
>+ * @flag:	Command flag
>+ * @argc:	Number of arguments
>+ * @argv:	Argument array
>+ * Return:	CMD_RET_SUCCESS on success, CMD_RET_FAILURE on failure
>+ *
>+ * Implement efidebug "capsule images" sub-command=2E
>+ * Walk every Firmware Management Protocol instance and print the image
>+ * descriptors it reports, i=2Ee=2E the firmware images a capsule can ta=
rget
>+ * on this board along with their name, index and type GUID=2E
>+ *
>+ *     efidebug capsule images
>+ */
>+static int do_efi_capsule_images(struct cmd_tbl *cmdtp, int flag,
>+				 int argc, char * const argv[])
>+{
>+	struct efi_firmware_management_protocol *fmp;
>+	struct efi_firmware_image_descriptor *image_info, *desc;
>+	efi_uintn_t info_size, descriptor_size, no_handles;
>+	u32 descriptor_version, package_version;
>+	u16 *package_version_name;
>+	u8 descriptor_count;
>+	efi_handle_t *handles;
>+	efi_status_t ret;
>+	int i, j;
>+
>+	if (argc !=3D 1)
>+		return CMD_RET_USAGE;
>+
>+	ret =3D EFI_CALL(efi_locate_handle_buffer(BY_PROTOCOL,
>+						&efi_guid_firmware_management_protocol,
>+						NULL, &no_handles, &handles));
>+	if (ret !=3D EFI_SUCCESS || no_handles =3D=3D 0) {
>+		printf("No firmware images found\n");
>+		return CMD_RET_SUCCESS;
>+	}
>+
>+	printf("Image Index    Firmware Name         Image Type GUID\n");
>+	printf("=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D    =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
\n");
>+
>+	for (i =3D 0; i < no_handles; i++) {
>+		struct efi_handler *handler;
>+
>+		ret =3D efi_search_protocol(handles[i],
>+					  &efi_guid_firmware_management_protocol,
>+					  &handler);
>+		if (ret !=3D EFI_SUCCESS)
>+			continue;
>+		fmp =3D handler->protocol_interface;
>+
>+		info_size =3D 0;
>+		image_info =3D NULL;
>+		descriptor_version =3D 0;
>+		descriptor_count =3D 0;
>+		descriptor_size =3D 0;
>+		package_version =3D 0;
>+		package_version_name =3D NULL;
>+		ret =3D EFI_CALL(fmp->get_image_info(fmp, &info_size, image_info,
>+						   &descriptor_version,
>+						   &descriptor_count,
>+						   &descriptor_size,
>+						   &package_version,
>+						   &package_version_name));
>+		if (ret !=3D EFI_BUFFER_TOO_SMALL)
>+			continue;
>+
>+		image_info =3D malloc(info_size);
>+		if (!image_info)
>+			continue;
>+
>+		ret =3D EFI_CALL(fmp->get_image_info(fmp, &info_size, image_info,
>+						   &descriptor_version,
>+						   &descriptor_count,
>+						   &descriptor_size,
>+						   &package_version,
>+						   &package_version_name));
>+		if (ret =3D=3D EFI_SUCCESS &&
>+		    descriptor_version =3D=3D EFI_FIRMWARE_IMAGE_DESCRIPTOR_VERSION) {
>+			for (j =3D 0, desc =3D image_info; j < descriptor_count;
>+			     j++, desc =3D (void *)desc + descriptor_size)
>+				printf("%11d    %-21ls %pUl\n",
>+				       desc->image_index,
>+				       desc->image_id_name ? desc->image_id_name : u"",
>+				       &desc->image_type_id);
>+		}
>+
>+		efi_free_pool(package_version_name);
>+		free(image_info);
>+	}
>+
>+	efi_free_pool(handles);
>+
>+	return CMD_RET_SUCCESS;
>+}
>+
> static struct cmd_tbl cmd_efidebug_capsule_sub[] =3D {
> 	U_BOOT_CMD_MKENT(update, CONFIG_SYS_MAXARGS, 1, do_efi_capsule_update,
> 			 "", ""),
>@@ -309,6 +407,8 @@ static struct cmd_tbl cmd_efidebug_capsule_sub[] =3D =
{
> #endif
> 	U_BOOT_CMD_MKENT(result, CONFIG_SYS_MAXARGS, 1, do_efi_capsule_res,
> 			 "", ""),
>+	U_BOOT_CMD_MKENT(images, CONFIG_SYS_MAXARGS, 1, do_efi_capsule_images,
>+			 "", ""),
> };
>=20
> /**
>@@ -1618,6 +1718,8 @@ U_BOOT_LONGHELP(efidebug,
> 	"  - show capsule information\n"
> 	"efidebug capsule result [<capsule result var>]\n"
> 	"  - show a capsule update result\n"
>+	"efidebug capsule images\n"
>+	"  - list firmware images updatable by capsule\n"
> #ifdef CONFIG_EFI_ESRT
> 	"efidebug capsule esrt\n"
> 	"  - print the ESRT\n"
>diff --git a/test/py/tests/test_efi_capsule/test_capsule_firmware_raw=2Ep=
y b/test/py/tests/test_efi_capsule/test_capsule_firmware_raw=2Epy
>index b8cb483b380=2E=2Ee6246a83ff0 100644
>--- a/test/py/tests/test_efi_capsule/test_capsule_firmware_raw=2Epy
>+++ b/test/py/tests/test_efi_capsule/test_capsule_firmware_raw=2Epy
>@@ -238,3 +238,25 @@ class TestEfiCapsuleFirmwareRaw:
>             check_file_removed(ubman, disk_img, capsule_files)
>=20
>             verify_content(ubman, '100000', 'u-boot:Old')
>+
>+    def test_efi_capsule_fw6(
>+            self, u_boot_config, ubman, efi_capsule_data):
>+        """ Test Case 6
>+        List the firmware images updatable by capsule with
>+        'efidebug capsule images' and check the images sandbox exposes
>+        for raw capsule updates
>+        """
>+        ubman=2Erestart_uboot()
>+
>+        output =3D ubman=2Erun_command('efidebug capsule images')
>+
>+        # ensure that SANDBOX-UBOOT and SANDBOX-UBOOT-ENV are both liste=
d,
>+        # along with the image index each one is exposed at=2E
>+        assert '1' in output and 'SANDBOX-UBOOT' in output
>+        assert '2' in output and 'SANDBOX-UBOOT-ENV' in output
>+
>+        # ensure that SANDBOX_UBOOT_IMAGE_GUID is reported=2E
>+        assert '985F2937-7C2E-5E9A-8A5E-8E063312964B' in output
>+
>+        # ensure that SANDBOX_UBOOT_ENV_IMAGE_GUID is reported=2E
>+        assert '9E339473-C2EB-530A-A69B-0CD6BBBED40E' in output
>

