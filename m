Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FC72CD6E6B
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 12:34:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28EB0849E5;
	Thu,  4 Jun 2026 14:30:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="GbQo6Rmu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80CAB848BF; Thu,  4 Jun 2026 14:24:45 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09A758484F
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 14:24:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1780575855; x=1781180655; i=xypron.glpk@gmx.de;
 bh=zqZjXmjGz8hsLNI/kehqBx8dvx24YN7UiPqamdL/Clg=;
 h=X-UI-Sender-Class:Date:From:To:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=GbQo6RmuywtBAfEeVPpGxLab5k0ysQc6ckgmb+qGzRCr80IKgwpTiyaYXwwe2e6Q
 qh8WVLu3dd6X8dR66z70cpD3xQGl3RhJSilk2KGtknMD1bTP+TjaT4BeSH+Zn2SzS
 pamPDlKxPzD1Rn/dDtsUyb9T3Q6G+kwf6IuZB655NDBLjK+x+NlYC5h5r6mWQZzx8
 VHZSOu4vdRYuvrhWOmlzT+KhfWGutCFggym24kjyAlxz0fpgInREReOXjbfHXQTyn
 iEPSymSuHltXcLNZhYozCJ8HR4hP31PGol0IkO9ZaoXeDLVF7GKVolGBzDyYiRwDu
 TR7ZmFk4kCJVlSTB0w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MTzay-1weMEG48I6-00YBOz; Thu, 04
 Jun 2026 14:24:15 +0200
Date: Thu, 04 Jun 2026 14:24:05 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 rayagonda.kokatanur@broadcom.com, trini@konsulko.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org, sumit.garg@kernel.org,
 peng.fan@nxp.com, jh80.chung@samsung.com, lukma@denx.de, sjg@chromium.org,
 alpernebiyasak@gmail.com, tien.fong.chee@altera.com, anshuld@ti.com,
 alif.zakuan.yuslaimi@altera.com, afd@ti.com, marek.vasut+renesas@mailbox.org, 
 tingting.meng@altera.com, alice.guo@nxp.com, quentin.schulz@cherry.de,
 ilias.apalodimas@linaro.org, varadarajan.narayanan@oss.qualcomm.com,
 mkorpershoek@kernel.org, andre.przywara@arm.com, h-salunke@ti.com,
 alchark@gmail.com, dinesh.maniyam@altera.com, luca.weiss@fairphone.com,
 balaji.selvanathan@oss.qualcomm.com, aswin.murugan@oss.qualcomm.com,
 danila@jiaxyga.com, n-francis@ti.com, ycliang@andestech.com,
 mateuslima.ti@gmail.com, justin@tidylabs.net, jamie.gibbons@microchip.com,
 david.wronek@mainlining.org, james.hilliard1@gmail.com,
 bdklingerman@gmail.com, sughosh.ganu@arm.com, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v4_13/13=5D_doc=3A_board/qua?=
 =?US-ASCII?Q?lcomm=3A_Update_RDP_build_instructions?=
User-Agent: Thunderbird for Android
In-Reply-To: <20260604093132.757583-14-varadarajan.narayanan@oss.qualcomm.com>
References: <20260604093132.757583-1-varadarajan.narayanan@oss.qualcomm.com>
 <20260604093132.757583-14-varadarajan.narayanan@oss.qualcomm.com>
Message-ID: <8E8836F5-487B-4B2B-9A9F-F02A00BB91DD@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WDPG5HBPzjBEGDn7U97pS8VVueTIIPgyoTY7MszrQNCrYPrVXbd
 1rjnC3VIlSIBHegX2djpuCaNpoT7n0E4YihVfrVXkg2Lg60RdB9w11KKSYZ6UFKg+SUa5aB
 wAaEi742ERWJS1IR4Eqbgld2C+wNZ1uS6u4xMnUa6IiXSl4lrDo+Pl3goEEhG9JzR9RA78K
 gk5S3bG42Ufsvc17fApAg==
UI-OutboundReport: notjunk:1;M01:P0:1wXan/99ask=;lUWEpwDDcLrFlBaA5KJ2gkzsjLF
 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
X-Mailman-Approved-At: Thu, 04 Jun 2026 14:30:17 +0200
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

Am 4=2E Juni 2026 11:31:32 MESZ schrieb Varadarajan Narayanan <varadarajan=
=2Enarayanan@oss=2Equalcomm=2Ecom>:
>Add details about the SPL & U-Boot proper build steps, converting to
>flashable images, source URLs for the needed binaries and scripts=2E
>
>Signed-off-by: Varadarajan Narayanan <varadarajan=2Enarayanan@oss=2Equalc=
omm=2Ecom>
>---
>v4: Replace script based image creation with binman based command
>
>v3: Use '-' for sub heading instead of '=3D'
>    Add location for template=2Eits and sort the list alphabetically
>---
> doc/board/qualcomm/rdp=2Erst | 83 +++++++++++++++++++++++++++++++++++++-
> 1 file changed, 82 insertions(+), 1 deletion(-)
>
>diff --git a/doc/board/qualcomm/rdp=2Erst b/doc/board/qualcomm/rdp=2Erst
>index 99cf8eba57c=2E=2E354dc9d06e1 100644
>--- a/doc/board/qualcomm/rdp=2Erst
>+++ b/doc/board/qualcomm/rdp=2Erst
>@@ -42,17 +42,98 @@ on your device with::
>=20
> U-Boot should be running after a reboot (``reset``)=2E
>=20
>+Build steps for IPQ5210 based Qualcomm Dragonwing F8 & N8 Platforms:
>+--------------------------------------------------------------------
>+
>+Please refer to the following URLs for more details about the platforms=
=2E
>+
>+	F8: https://www=2Equalcomm=2Ecom/networking-infrastructure/products/f-s=
eries/f8-platform
>+
>+	N8: https://www=2Equalcomm=2Ecom/networking-infrastructure/products/n-s=
eries/n8-platform
>+
>+1=2E Since U-Boot SPL is enabled on these platforms, the build command g=
enerates
>+   both the U-Boot SPL and U-Boot proper images=2E Assuming ${uboot_dir}=
 is the
>+   top of the U-Boot sources and ${out_dir} as the output directory,
>+
>+	$ cd ${uboot_dir}
>+	$ export CROSS_COMPILE=3D<aarch64 toolchain prefix>
>+	$ make -j8 O=3D${out_dir} qcom_ipq5210_mmc_defconfig
>+	$ make -j8 O=3D${out_dir}
>+
>+   U-Boot SPL image:	${out_dir}/spl/u-boot-spl=2Ewrap-elf
>+   U-Boot image:	${out_dir}/u-boot=2Eelf
>+
>+2=2E Convert the SPL image to multi ELF
>+
>+	$ cd ${out_dir}/spl
>+	$ python elftombn=2Epy -f u-boot-spl=2Ewrap-elf -o u-boot-spl=2Embn -v7
>+	$ python `create_multielf=2Epy` -f u-boot-spl=2Embn,tmel-ipq52xx-patch=
=2Eelf \
>+					-o u-boot-spl=2Emelf
>+
>+   This u-boot-spl=2Emelf should be flashed into 0:SPL partition=2E
>+   Please see below for the location of `tmel-ipq52xx-patch=2Eelf`
>+
>+3=2E Convert the U-Boot image to bootloader image
>+
>+	$ cd ${out_dir}
>+	$ python elftombn=2Epy -f u-boot=2Eelf -o u-boot=2Embn -v7
>+
>+   The u-boot=2Embn has to be combined with `qc_config=2Eelf`, `QCLib=2E=
elf`, `TFA`
>+   and `OPTEE`=2E Please see below for the location for these ELFs=2E TF=
A and OPTEE
>+   can be built from the sources using the following commands
>+
>+   TFA:

Thank you for the documentation provided=2E

Unfortunately this does not look properly formatted for Sphinx=2E

You can build thr HTML documentation with

make htmldocs

Ensure no warning is reported=2E


Here you might want to use:

Build TF-A with:

=2E=2E code-block:: bash

>+	$ make PLAT=3Dipq52xx QTISECLIB_PATH=3Dpath/to/`libqtisec_dbg=2Ea` SPD=
=3Dopteed

Please, remove the '$ ' prompts and indent by 4 spaces=2E

Best regards

Heinrich

>+
>+   OPTEE:
>+	$ make PLATFORM=3Dqcom-ipq52xx -j16
>+
>+   These binaries can be combined into a flashable image using binman=2E
>+
>+   Assuming all the required binaries are available in ${uboot_dir}/binm=
an
>+
>+	$ export bm=3D${uboot_dir}/binman
>+	$ cd ${bm}
>+	$ ${uboot_dir}/tools/binman/binman			\
>+		--toolpath ${uboot_dir}/tools build		\
>+		-u						\
>+		-d ${out_dir}/u-boot=2Edtb			\
>+		-O ${bm}=2Eout					\
>+		-I ${uboot_dir}					\
>+		-I ${bm}					\
>+		-I ${uboot_dir}/board				\
>+		-I ${out_dir}/dts/upstream/src/arm64		\
>+		-a of-list=3D"qcom/ipq5210-rdp504"		\
>+		-a atf-bl31-path=3D${bm}/bl31=2Embn			\
>+		-a tee-os-path=3D${bm}/tee-pager_v2=2Embn		\
>+		-a qcom-config-path=3D${bm}/qc_config=2Eelf		\
>+		-a qcom-lib-path=3D${bm}/QCLib=2Eelf		\
>+		-a qcom-appsbl-path=3D${out_dir}/u-boot=2Embn	\
>+		-a default-dt=3D"qcom/ipq5210-rdp504"		\
>+		-a spl-bss-pad=3D1				\
>+		-a spl-dtb=3Dy					\
>+		-a of-spl-remove-props=3D"interrupt-parent interrupts"
>+
>+   This should be flashed into 0:BOOTLDR partition=2E
>+
> =2E=2E WARNING
> 	Boards with newer software versions would automatically go the emergenc=
y
> 	download (EDL) mode if U-Boot is not functioning as expected=2E If its =
a
> 	runtime failure at Uboot, the system will get reset (due to watchdog)
> 	and XBL will try to boot from next bank and if Bank B also doesn't have
> 	a functional image and is not booting fine, then the system will enter
>-	EDL=2E  A tool like bkerler's `edl`_ can be used for flashing with the
>+	EDL=2E  A tool like bkerler's `edl` can be used for flashing with the
> 	firehose loader binary appropriate for the board=2E
>=20
> 	Note that the support added is very basic=2E Restoring the original U-B=
oot
> 	on boards with older version of the software requires a debugger=2E
>=20
>+=2E=2E _create_multielf=2Epy: https://raw=2Egithubusercontent=2Ecom/core=
boot/coreboot/refs/heads/main/util/qualcomm/create_multielf=2Epy
> =2E=2E _elftombn=2Epy: https://git=2Ecodelinaro=2Eorg/clo/qsdk/oss/syste=
m/tools/meta/-/tree/NHSS=2EQSDK=2E13=2E0=2E5=2Er2/scripts?ref_type=3Dheads
> =2E=2E _edl: https://github=2Ecom/bkerler/edl
>+=2E=2E _libqtisec_dbg=2Ea: https://softwarecenter=2Equalcomm=2Ecom/nexus=
/generic/product/chip/software-product/IPQ5210=2ENLQ=2E14=2E0/ipq5210=2Enlq=
=2E14=2E0-qca-oem-qartifact/r00036=2E1/WIN=2ETFA=2E1=2E0=2ER4/apss_proc/out=
/proprietary/qtiseclib/output/ipq52xx/release/libqtisec_dbg=2Ea
>+=2E=2E _OPTEE: https://git=2Ecodelinaro=2Eorg/clo/trusted-firmware/optee=
_os/optee_os/-/tree/win=2Eoptee=2E1=2E0?ref_type=3Dheads
>+=2E=2E _qc_config=2Eelf: https://softwarecenter=2Equalcomm=2Ecom/nexus/g=
eneric/product/chip/software-product/IPQ5210=2ENLQ=2E14=2E0/ipq5210=2Enlq=
=2E14=2E0-qca-oem-qartifact/r00036=2E1/BOOT=2EMXF=2E2=2E3=2E1=2E1/boot_imag=
es/boot/QcomPkg/SocPkg/Hermosa/Bin/LC/RELEASE/qc_config=2Eelf
>+=2E=2E _QCLib=2Eelf: https://softwarecenter=2Equalcomm=2Ecom/nexus/gener=
ic/product/chip/software-product/IPQ5210=2ENLQ=2E14=2E0/ipq5210=2Enlq=2E14=
=2E0-qca-oem-qartifact/r00036=2E1/BOOT=2EMXF=2E2=2E3=2E1=2E1/boot_images/bo=
ot/QcomPkg/SocPkg/Hermosa/Bin/LC/RELEASE/QCLib=2Eelf
>+=2E=2E _TFA: https://git=2Ecodelinaro=2Eorg/clo/trusted-firmware/tf-a/tr=
usted-firmware-a/-/tree/win=2Etfa=2E1=2E0=2Er4?ref_type=3Dheads
>+=2E=2E _tmel-ipq52xx-patch=2Eelf: https://softwarecenter=2Equalcomm=2Eco=
m/nexus/generic/product/chip/software-product/IPQ5210=2ENLQ=2E14=2E0/ipq521=
0=2Enlq=2E14=2E0-qca-oem-qartifact/r00036=2E1/TMEL=2EWNS=2E2=2E4/tmel-ipq52=
xx-patch=2Eelf

