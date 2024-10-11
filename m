Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5EF2D0EE3F
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 21:57:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F478893EB;
	Fri, 11 Oct 2024 23:57:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Tr7V7sY7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1CEC893E4; Fri, 11 Oct 2024 23:57:03 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97030893E4
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 23:57:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1728683819; x=1729288619; i=xypron.glpk@gmx.de;
 bh=szZet1P2s381fZ0ugoKMk8Tz/AFfFPPtyfq67/CYRo8=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=Tr7V7sY73Oy2WM6PlpeCzb3bFFyWYe0hi4HDKBQ94N1ccwXtgTEl9ONUtogfkT3H
 C5qXMMK10D2iqtZHoeRofwkYMLC5X6n3STXi/EyW8fwJrUh8LnrJnqE6ys/acpxd5
 SwFWP+zwtyY1xmZggI2I2wyRefhOpg9PYuoAfFsOmvRpG8hO7dPA/87BcRKQf+i3J
 8pcuMS+U40cGZOKNl5JNOqAvdQEuy/nYIp4fKopHX6S1vO7LyeBxwji5rWizohlis
 VzSX6VxQFjtApunH7Ac+UcYRrg+pYHA8xfcOdbX+Z7eZBlj0dFNooGaFQf7gU+QzI
 HC6+Xr3fmxC0dyTsfQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([46.114.104.96]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MRTN9-1tMFZe049N-00Jlbk; Fri, 11
 Oct 2024 23:56:59 +0200
Date: Fri, 11 Oct 2024 23:56:56 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v4_2/5=5D_efi=3A_Show_the_locat?=
 =?US-ASCII?Q?ion_of_the_bounce_buffer_when_debugging?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20241011212126.747741-3-sjg@chromium.org>
References: <20241011212126.747741-1-sjg@chromium.org>
 <20241011212126.747741-3-sjg@chromium.org>
Message-ID: <A51D5AB2-A3A6-44E9-BE35-45B79081EB9E@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JTrwcnW9Tlr7+lSUlbFDSCDOJ9pYUx+0ejouBKMkBgLNbsceSR9
 I2cArpVEKiUdfO5p38fTiwCVaRXfXWBJYxtqznFmA4W/6PqQN/6yPia/speDOODkq2HAVp1
 zF8ymAw70gYHkM3eRplCp6bjbc973HsDUGXc+KZCIW2LK1b5CAkmfMdpEChyvmoN5edXk97
 luP7KwxgqtWvAOQDkicRg==
UI-OutboundReport: notjunk:1;M01:P0:HKpHrWszx7o=;iME5wd7E/CqvMo8xXHc23agcpFY
 zKQtuZU97O5V+0DGgqwTDDDARYx/2jKODsH3vpsK4hb6OrPRfY/GDkptGau0n3BklBqVs439u
 HQIYkPKrU2RaUlovdlnoyLr+xOGQHfg/056wpZehT2/ocexpiI63l/1KAWo5kj3tVMYt5T5kT
 qpgW7o6xSFPrVoWMaVXMDMifJyK5h2oeG/iOeWBxqyAFxa71cEtO9mNrhX+xEW0AA+ykSFyal
 mMV6d4VVymlbjIw1ynlCuzcFOdGRw+5Cv6e/qb8x6Kkg45dbGCCfMe2dpeibeO1t0jt1L+CXR
 x2xK4MMbM7P9XFt6SmwQgiNL5iiE0UPLBNtshCQACQazgYZiau5FoZRi2OMVtllR+rs/JSzax
 tS3jyIC6oEIRTyrXMQSNYxCTLxE2xDcpDFobwnXIKdqj+i6SYzL+Y2Yy/EBnMDr6GqnxMa/kz
 cECGfyaVk3RJcX0OA5aUKfWFAzw4mDKmUarjsJFxW2Zo1mnMT3fmSKypsubnJPSPL49QPGOlD
 aBdCarRinZw3LuZmdRa6yjQc5l6URNukC3uw5UKFGmfiUYC4cDKKFZJ7gvPd9UbMx6LVMCyNX
 hyfywGujmDjs1q7r0WZNfOO2CfCc92rtZk28JLzsLbeYWJUA2qYroBS0+CQYojr1yShSTfz/C
 4hn4CZFeFEpDDm3PlZxonfeDXpXMobE1/Y3vAXBqmSNWrlZsC8lycpDGusn65OSQfnxMpaDyx
 DmotQgLKiIfZl+ygcTyvdO32jfAfMBaVLjXdq3gWYITZhvB6yZNTwXSy9cXirZ7754g6qtYQh
 ZAyrskeiY/botWfAeka3D8MA==
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



Am 11=2E Oktober 2024 23:21:23 MESZ schrieb Simon Glass <sjg@chromium=2Eor=
g>:
>The EFI_LOADER_BOUNCE_BUFFER feature was added many years ago=2E It is
>still needed and 24 boards (lx2160ardb_tfa_stmm,
>lx2162aqds_tfa_SECURE_BOOT and the like) use it=2E
>
>This feature uses EFI page allocation to create a 64MB buffer 'in space'
>without any knowledge of where boards intend to load their images=2E This
>may result in image corruption or other problems=2E
>
>For example, if the feature is enabled on qemu_arm64 it puts the EFI
>bounce buffer at 1045MB, with the kernel at 1028MB and the ramdisk at
>1088MB=2E The kernel is probably smaller than 27MB but the buffer does
>overlap the ramdisk=2E
>
>The solution is probably to use BOUNCE_BUFFER instead, with the EFI
>version being dropped=2E For now, show the address of the EFI bounce
>buffer so people have a better chance to debug any problem=2E
>
>Signed-off-by: Simon Glass <sjg@chromium=2Eorg>
>---
>In response to questions on how to show this problem:
>
>First, add CONFIG_EFI_LOADER_BOUNCE_BUFFER=3Dy to
>configs/qemu_arm64_defconfig and build
>
>Then, to run:
>qemu-system-aarch64 -machine virt -nographic -cpu cortex-a57 \
>   -bios u-boot=2Ebin
>
>U-Boot 2024=2E10-00809-gae29e5f76e4a-dirty (Oct 11 2024 - 11:48:46 -0600)
>
>DRAM:  128 MiB
>Core:  51 devices, 14 uclasses, devicetree: board
>Flash: 64 MiB
>Loading Environment from Flash=2E=2E=2E *** Warning - bad CRC, using defa=
ult environment
>
>In:    serial,usbkbd
>Out:   serial,vidconsole
>Err:   serial,vidconsole
>No USB controllers found
>Net:   eth0: virtio-net#32
>
>starting USB=2E=2E=2E
>No USB controllers found
>Hit any key to stop autoboot:  0
>=3D> bootefi hello
>Enabling coop memory
>No EFI system partition
>No EFI system partition
>Failed to persist EFI variables
>Missing TPMv2 device for EFI_TCG_PROTOCOL
>Missing RNG device for EFI_RNG_PROTOCOL
>Warning: EFI bounce buffer 000000004157f000-000000004557f000
>Not loaded from disk
>Booting /MemoryMapped(0x0,0x47763730,0x31b0)
>EFI: Call: efi_load_image(false, efi_root, file_path, source_buffer, sour=
ce_size, &handle)
>EFI: 0 returned by efi_load_image(false, efi_root, file_path, source_buff=
er, source_size, &handle)
>Hello, world!
>Running on UEFI 2=2E10
>Firmware vendor: Das U-Boot
>Firmware revision: 20241000
>Have device tree
>Load options: <none>
>File path: <none>
>Boot device: /MemoryMapped(0x0,0x47763730,0x31b0)
>=3D> print kernel_addr_r
>kernel_addr_r=3D0x40400000
>=3D> print ramdisk_addr_r
>ramdisk_addr_r=3D0x44000000
>=3D>
>
>The EFI bounce buffer overlaps with the ramdisk=2E
>
>Changes in v4:
>- Reword the commit message since this feature is needed
>
> lib/efi_loader/efi_bootbin=2Ec | 9 +++++++++
> 1 file changed, 9 insertions(+)
>
>diff --git a/lib/efi_loader/efi_bootbin=2Ec b/lib/efi_loader/efi_bootbin=
=2Ec
>index a87006b3c0e=2E=2Eeefdd660cee 100644
>--- a/lib/efi_loader/efi_bootbin=2Ec
>+++ b/lib/efi_loader/efi_bootbin=2Ec
>@@ -209,6 +209,15 @@ efi_status_t efi_binary_run(void *image, size_t size=
, void *fdt)
> 		return -1;
> 	}
>=20
>+#ifdef CONFIG_EFI_LOADER_BOUNCE_BUFFER
>+	/*
>+	 * Add a warning about this buffer, since it may conflict with other
>+	 * things
>+	 */
>+	log_debug("Warning: EFI bounce buffer %p-%p\n", efi_bounce_buffer,
>+		  efi_bounce_buffer + EFI_LOADER_BOUNCE_BUFFER_SIZE);
>+#endif

Adding a debug message here is ok=2E

But writing "warning" in a debug message which is just printing an address=
 for a configuration selected item looks weird to me=2E

Best regards

Heinrich

>+
> 	ret =3D efi_install_fdt(fdt);
> 	if (ret !=3D EFI_SUCCESS)
> 		return ret;
