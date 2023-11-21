Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F37FC54FB9
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 11:37:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 391F787438;
	Tue, 21 Nov 2023 12:36:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="j3m0lQXb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F14DF875A7; Tue, 21 Nov 2023 12:36:13 +0100 (CET)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2699787251
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 12:36:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-7a6acc8e222so196874339f.0
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 03:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700566569; x=1701171369; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r47XcqkFZuYAnfencEDGtmt/7Hgak2gqzlP85DE5MJs=;
 b=j3m0lQXbQJJDMdJYnF+/vn3UG4WtDl8rNKQo6GyiLmyNatH0x4y5L6blvdF3NWa+LR
 Wgiiy2+VZ0+tEXnC7jinHDSVdCMgQ2bBbMFS9t06wC7vIGqDxX/RDCFDWlhBGQSPWRHP
 vcm3s8cNIr/GEzN3RF1lI0ojqp5Y/1fnjqcJA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700566569; x=1701171369;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r47XcqkFZuYAnfencEDGtmt/7Hgak2gqzlP85DE5MJs=;
 b=cwPUG6SaoOor2oi2SpmsTLjiJpDmwgAQJ4iynttfdL5gY5hZqpKo48W7E6vSb6U+2c
 VtsuJsXW1E4sHxVI5fc+/l854REPx90b6qv3Ylr11ILEw706cWkxnrlaZL0VLIOHR5x1
 QdocnnLtOiZ3v3nzCGrS1TiZF2UYDJZ7bDHkqP0fRVB01GPpplycD92uanfCI3x+CLTk
 xLttF8pknLDyO0xJwFPklNLxbefW9iwLUKfZpPq4pcvtSl4yGtYDAiS+/CLeLkiIh4um
 QSs6BONrJ/Hv9wKKgShv/kuW8R8N+Y7u2Ni43w4U7TRDMD9MYsuo4eE4ij+S/Lu0STgw
 qz4Q==
X-Gm-Message-State: AOJu0Yz6A8cSxQxI89vmvN7bMi+SGUxLJKQ79j5H0DkolOW4OueLdnQy
 X6cO2oHO/7jgOWd/zo6v0zm1vSxAXNUyRe3Xzyg8Mg==
X-Google-Smtp-Source: AGHT+IFRHxqZQXco21fegs3R9rYz3K71OBrU/cwYs6PXffiJXSvRBvtaMPR+itWMVwjarKLcUBW7pg==
X-Received: by 2002:a05:6602:6402:b0:790:ab53:ed16 with SMTP id
 gn2-20020a056602640200b00790ab53ed16mr13691787iob.21.1700566569613; 
 Tue, 21 Nov 2023 03:36:09 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 h10-20020a0566380f8a00b0045bb982a3d2sm2559190jal.60.2023.11.21.03.36.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 03:36:09 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH 7/7] WIP: efi: debugging
Date: Tue, 21 Nov 2023 04:35:53 -0700
Message-ID: <20231121113557.800353-8-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
In-Reply-To: <20231121113557.800353-1-sjg@chromium.org>
References: <20231121113557.800353-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

This works when run outside a test:

good:

/tmp/b/sandbox/u-boot -T
    -c "bootfl scan mmc; bootfl sel 1; bootfl list; bootfl b"

** Booting bootflow 'mmc7.bootdev.part_1' with efi
desc = 0000000018c86ee0
dev=mmc, devnr=7:1, path=efi/boot/bootsbox.efi, buffer=0000000011001000, size=1600
- boot device /VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,0000000000000000)/SD(7)/SD(3)/HD(1,MBR,0x2f7d9756,0x800,0x9000)
- image /efi\boot\bootsbox.efi
No EFI system partition
No EFI system partition
Failed to persist EFI variables
EFI using ACPI tables at 8ef8000
WARNING: Can't have ACPI table and device tree - ignoring DT.
Loaded from disk
Booting /efi\boot\bootsbox.efi
EFI: Call: efi_load_image(false, efi_root, file_path, source_buffer, source_size, &handle)
info->device_handle = 0000000018f180e0
loaded_image info for 0000000018f184e0: 0000000018f18470

EFI: 0 returned by efi_load_image(false, efi_root, file_path, source_buffer, source_size, &handle)
EFI: Call: efi_start_image(handle, &exit_data_size, &exit_data)
Hello, world!
Running on UEFI 2.10
Have ACPI 2.0 table
Have SMBIOS table
18f18470
Load options: <none>
finding
- search 0000000018c931a0 ret=0
File path: /efi\boot\bootsbox.efi
Vendor: Das U-Boot
Boot device: /VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,0000000000000000)/SD(7)/SD(3)/HD(1,MBR,0x2f7d9756,0x800,0x9000)
Exiting boot sevices
EFI: 5 returned by efi_start_image(handle, &exit_data_size, &exit_data)
Boot failed (err=-22)

bad:

rtv bootflow_efi

** Booting bootflow 'mmc7.bootdev.part_1' with efi
desc = 0000000018c86ee0
dev=mmc, devnr=8:1, path=efi/boot/bootsbox.efi, buffer=0000000011001000, size=1600
- boot device /VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,0000000000000000)/SD(7)/SD(3)/HD(1,MBR,0x2f7d9756,0x800,0x9000)
- image /efi\boot\bootsbox.efi
No EFI system partition
No EFI system partition
Failed to persist EFI variables
EFI using ACPI tables at 8ef8000
WARNING: Can't have ACPI table and device tree - ignoring DT.
Loaded from disk
Booting /efi\boot\bootsbox.efi
EFI: Call: efi_load_image(false, efi_root, file_path, source_buffer, source_size, &handle)
info->device_handle = 0000000000000000
loaded_image info for 0000000018c924e0: 0000000018f15080

EFI: 0 returned by efi_load_image(false, efi_root, file_path, source_buffer, source_size, &handle)
EFI: Call: efi_start_image(handle, &exit_data_size, &exit_data)
Hello, world!
Running on UEFI 2.10
Have ACPI 2.0 table
Have SMBIOS table
18f15080
Load options: <none>
finding
- search 0000000018c931a0 ret=0
File path: /efi\boot\bootsbox.efi
Missing device handle
Exiting boot sevices
EFI: 5 returned by efi_start_image(handle, &exit_data_size, &exit_data)
Boot failed (err=-22)
test/boot/bootflow.c:1091, bootflow_efi(): console:
Expected 'No EFI system partition',
     got 'desc = 0000000018c86ee0'
Test bootflow_efi failed 1 times
Failures: 1

(see 'Missing device handle')

It seems that the device number is inconsistent between generation and
decoding.

function rt_get_suite_and_name() {
	local arg
	#echo arg $arg
	suite=
	name=

	if [ "$1" = "-f" ]; then
		force="-f"
		shift
	fi
	arg="$1"
	rest="$2"

	# The symbol is something like this:
	#	_u_boot_list_2_ut_bootstd_test_2_vbe_simple_test_base
	# Split it into the suite name (bootstd) and test name
	# (vbe_simple_test_base)
	read suite name < \
		<(nm /tmp/b/$exec/u-boot |grep "list_2_ut.*$arg.*" \
			| cut -d' ' -f3 \
			| head -1 \
			| sed -n 's/_u_boot_list_2_ut_\(.*\)_test_2_/\1 /p')
	#echo suite $suite
	#echo name $name
	#name=${1#dm_test_}
	#name=${name#ut_dm_}
}

function rtv() {
	local exec=sandbox
	local suite name force rest
	rt_get_suite_and_name $*

	U_BOOT_PERSISTENT_DATA_DIR=/tmp/b/sandbox/persistent-data \
	/tmp/b/$exec/u-boot -v -T $rest -c "ut $suite $force $name"
}

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/bootflow.c               | 2 ++
 boot/bootmeth_efi.c           | 1 +
 cmd/bootefi.c                 | 1 +
 lib/efi_loader/efi_boottime.c | 5 +++++
 test/boot/bootflow.c          | 2 +-
 5 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/boot/bootflow.c b/boot/bootflow.c
index 6922e7e0c4e7..0513522a7ec4 100644
--- a/boot/bootflow.c
+++ b/boot/bootflow.c
@@ -464,6 +464,8 @@ void bootflow_init(struct bootflow *bflow, struct udevice *bootdev,
 
 void bootflow_free(struct bootflow *bflow)
 {
+	/* this is where we want to get to (will only happen with USB) */
+	printf("bootflow free\n");
 	free(bflow->name);
 	free(bflow->subdir);
 	free(bflow->fname);
diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
index ae936c8daa18..edee9e62a458 100644
--- a/boot/bootmeth_efi.c
+++ b/boot/bootmeth_efi.c
@@ -127,6 +127,7 @@ static void set_efi_bootdev(struct blk_desc *desc, struct bootflow *bflow)
 	 * this can go away.
 	 */
 	media_dev = dev_get_parent(bflow->dev);
+	printf("desc = %p\n", desc);
 	snprintf(devnum_str, sizeof(devnum_str), "%x:%x",
 		 desc ? desc->devnum : dev_seq(media_dev),
 		 bflow->part);
diff --git a/cmd/bootefi.c b/cmd/bootefi.c
index 20e5c94a33a4..3c014e5684aa 100644
--- a/cmd/bootefi.c
+++ b/cmd/bootefi.c
@@ -5,6 +5,7 @@
  *  Copyright (c) 2016 Alexander Graf
  */
 
+#define LOG_DEBUG
 #define LOG_CATEGORY LOGC_EFI
 
 #include <common.h>
diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
index 0b7579cb5af1..149da5798740 100644
--- a/lib/efi_loader/efi_boottime.c
+++ b/lib/efi_loader/efi_boottime.c
@@ -1820,6 +1820,7 @@ efi_status_t efi_setup_loaded_image(struct efi_device_path *device_path,
 
 	if (device_path) {
 		info->device_handle = efi_dp_find_obj(device_path, NULL, NULL);
+		printf("info->device_handle = %p\n", info->device_handle);
 
 		dp = efi_dp_append(device_path, file_path);
 		if (!dp) {
@@ -1828,6 +1829,7 @@ efi_status_t efi_setup_loaded_image(struct efi_device_path *device_path,
 		}
 	} else {
 		dp = NULL;
+		printf("\nno device handle\n");
 	}
 	ret = efi_add_protocol(&obj->header,
 			       &efi_guid_loaded_image_device_path, dp);
@@ -1842,6 +1844,7 @@ efi_status_t efi_setup_loaded_image(struct efi_device_path *device_path,
 			       &efi_guid_loaded_image, info);
 	if (ret != EFI_SUCCESS)
 		goto failure;
+	printf("loaded_image info for %p: %p\n\n", &obj->header, info);
 
 	*info_ptr = info;
 	*handle_ptr = obj;
@@ -2665,8 +2668,10 @@ static efi_status_t EFIAPI efi_locate_protocol(const efi_guid_t *protocol,
 		if (ret == EFI_SUCCESS)
 			goto found;
 	} else {
+		printf("finding\n");
 		list_for_each_entry(efiobj, &efi_obj_list, link) {
 			ret = efi_search_protocol(efiobj, protocol, &handler);
+			printf("- search %p ret=%lx\n", efiobj, ret);
 			if (ret == EFI_SUCCESS)
 				goto found;
 		}
diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index ad54ef6eaabc..76c65c46cc01 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -536,7 +536,7 @@ static int prep_mmc_bootdev(struct unit_test_state *uts, const char *mmc_dev,
 
 	order[2] = mmc_dev;
 
-	/* Enable the mmc4 node since we need a second bootflow */
+	/* Enable the requested mmc node since we need a second bootflow */
 	root = oftree_root(oftree_default());
 	node = ofnode_find_subnode(root, mmc_dev);
 	ut_assert(ofnode_valid(node));
-- 
2.43.0.rc1.413.gea7ed67945-goog

