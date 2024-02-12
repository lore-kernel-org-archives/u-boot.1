Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 544C6C4829B
	for <u-boot@archiver.kernel.org>; Mon, 12 Feb 2024 07:50:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E51487F02;
	Mon, 12 Feb 2024 08:48:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A96A87808; Mon, 12 Feb 2024 08:48:33 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id C480A87EF4
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 08:48:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D0290FEC;
 Sun, 11 Feb 2024 23:49:11 -0800 (PST)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0EC2F3F762;
 Sun, 11 Feb 2024 23:48:26 -0800 (PST)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Yann Gautier <yann.gautier@st.com>,
 Etienne Carriere <etienne.carriere@foss.st.com>,
 Michal Simek <michal.simek@amd.com>,
 Jassi Brar <jaswinder.singh@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v2 15/21] test: fwu: align the FWU metadata access test with
 version 2
Date: Mon, 12 Feb 2024 13:17:06 +0530
Message-Id: <20240212074712.3657076-16-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240212074712.3657076-1-sughosh.ganu@linaro.org>
References: <20240212074712.3657076-1-sughosh.ganu@linaro.org>
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

With the FWU metadata support having been migrated to version 2, make
corresponding changes to the test for accessing the FWU metadata.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---

Changes since V1:
* Use the helper functions from the previous patch to access the
  image information in the metadata.

 test/dm/fwu_mdata.c            |  56 ++++++++-------
 test/dm/fwu_mdata_disk_image.h | 124 ++++++++++++++-------------------
 2 files changed, 83 insertions(+), 97 deletions(-)

diff --git a/test/dm/fwu_mdata.c b/test/dm/fwu_mdata.c
index 52018f610f..cbeceaee93 100644
--- a/test/dm/fwu_mdata.c
+++ b/test/dm/fwu_mdata.c
@@ -88,10 +88,15 @@ static int write_mmc_blk_device(struct unit_test_state *uts)
 	return 0;
 }
 
-static int dm_test_fwu_mdata_read(struct unit_test_state *uts)
+static int fwu_mdata_access_setup(struct unit_test_state *uts,
+				   struct fwu_mdata **mdata)
 {
+	u32 mdata_size;
 	struct udevice *dev;
-	struct fwu_mdata mdata = { 0 };
+
+	ut_assertok(setup_blk_device(uts));
+	ut_assertok(populate_mmc_disk_image(uts));
+	ut_assertok(write_mmc_blk_device(uts));
 
 	/*
 	 * Trigger lib/fwu_updates/fwu.c fwu_boottime_checks()
@@ -100,13 +105,24 @@ static int dm_test_fwu_mdata_read(struct unit_test_state *uts)
 	event_notify_null(EVT_MAIN_LOOP);
 
 	ut_assertok(uclass_first_device_err(UCLASS_FWU_MDATA, &dev));
-	ut_assertok(setup_blk_device(uts));
-	ut_assertok(populate_mmc_disk_image(uts));
-	ut_assertok(write_mmc_blk_device(uts));
 
-	ut_assertok(fwu_get_mdata(&mdata));
+	ut_assertok(fwu_get_mdata_size(&mdata_size));
 
-	ut_asserteq(mdata.version, 0x1);
+	*mdata = malloc(mdata_size);
+	ut_assertnonnull(*mdata);
+
+	return 0;
+}
+
+static int dm_test_fwu_mdata_read(struct unit_test_state *uts)
+{
+	struct fwu_mdata *mdata = NULL;
+
+	fwu_mdata_access_setup(uts, &mdata);
+
+	ut_assertok(fwu_get_mdata(mdata));
+
+	ut_asserteq(mdata->version, 0x2);
 
 	return 0;
 }
@@ -114,29 +130,21 @@ DM_TEST(dm_test_fwu_mdata_read, UT_TESTF_SCAN_FDT);
 
 static int dm_test_fwu_mdata_write(struct unit_test_state *uts)
 {
+	u8 num_banks;
 	u32 active_idx;
-	struct udevice *dev;
-	struct fwu_mdata mdata = { 0 };
-
-	/*
-	 * Trigger lib/fwu_updates/fwu.c fwu_boottime_checks()
-	 * to populate g_dev global pointer in that library.
-	 */
-	event_notify_null(EVT_MAIN_LOOP);
+	struct fwu_mdata *mdata = NULL;
 
-	ut_assertok(setup_blk_device(uts));
-	ut_assertok(populate_mmc_disk_image(uts));
-	ut_assertok(write_mmc_blk_device(uts));
-
-	ut_assertok(uclass_first_device_err(UCLASS_FWU_MDATA, &dev));
+	fwu_mdata_access_setup(uts, &mdata);
 
-	ut_assertok(fwu_get_mdata(&mdata));
+	ut_assertok(fwu_get_mdata(mdata));
+	num_banks = fwu_get_fw_desc(mdata)->num_banks;
+	ut_asserteq(2, num_banks);
 
-	active_idx = (mdata.active_index + 1) % CONFIG_FWU_NUM_BANKS;
+	active_idx = (mdata->active_index + 1) % num_banks;
 	ut_assertok(fwu_set_active_index(active_idx));
 
-	ut_assertok(fwu_get_mdata(&mdata));
-	ut_asserteq(mdata.active_index, active_idx);
+	ut_assertok(fwu_get_mdata(mdata));
+	ut_asserteq(mdata->active_index, active_idx);
 
 	return 0;
 }
diff --git a/test/dm/fwu_mdata_disk_image.h b/test/dm/fwu_mdata_disk_image.h
index b9803417c8..b15b06b9de 100644
--- a/test/dm/fwu_mdata_disk_image.h
+++ b/test/dm/fwu_mdata_disk_image.h
@@ -6,107 +6,85 @@
  */
 
 #define FWU_MDATA_DISK_IMG { 0x00010000, { \
-	{0x000001c0, "\x02\x00\xee\x02\x02\x00\x01\x00"}, /* ........ */ \
+	{0x000001c0, "\x02\x00\xee\xff\xff\xff\x01\x00"}, /* ........ */ \
 	{0x000001c8, "\x00\x00\x7f\x00\x00\x00\x00\x00"}, /* ........ */ \
 	{0x000001f8, "\x00\x00\x00\x00\x00\x00\x55\xaa"}, /* ......U. */ \
 	{0x00000200, "\x45\x46\x49\x20\x50\x41\x52\x54"}, /* EFI PART */ \
 	{0x00000208, "\x00\x00\x01\x00\x5c\x00\x00\x00"}, /* ....\... */ \
-	{0x00000210, "\xa6\xf6\x92\x20\x00\x00\x00\x00"}, /* ... .... */ \
+	{0x00000210, "\x52\x5f\x3a\xa1\x00\x00\x00\x00"}, /* R_:..... */ \
 	{0x00000218, "\x01\x00\x00\x00\x00\x00\x00\x00"}, /* ........ */ \
 	{0x00000220, "\x7f\x00\x00\x00\x00\x00\x00\x00"}, /* ........ */ \
 	{0x00000228, "\x22\x00\x00\x00\x00\x00\x00\x00"}, /* "....... */ \
 	{0x00000230, "\x5e\x00\x00\x00\x00\x00\x00\x00"}, /* ^....... */ \
-	{0x00000238, "\xde\x99\xa2\x7e\x46\x34\xeb\x47"}, /* ...~F4.G */ \
-	{0x00000240, "\x87\xf6\x4f\x75\xe8\xd5\x7d\xc7"}, /* ..Ou..}. */ \
+	{0x00000238, "\xf5\xf3\x9d\xb9\x92\xdd\x48\x60"}, /* ......H` */ \
+	{0x00000240, "\x9a\x04\xe5\x2b\x11\xcb\x42\x61"}, /* ...+..Ba */ \
 	{0x00000248, "\x02\x00\x00\x00\x00\x00\x00\x00"}, /* ........ */ \
 	{0x00000250, "\x80\x00\x00\x00\x80\x00\x00\x00"}, /* ........ */ \
-	{0x00000258, "\x2a\x64\x03\x83\x00\x00\x00\x00"}, /* .d...... */ \
+	{0x00000258, "\xc4\x80\x68\xad\x00\x00\x00\x00"}, /* ..h..... */ \
 	{0x00000400, "\xa0\x84\x7a\x8a\x87\x83\xf6\x40"}, /* ..z....@ */ \
 	{0x00000408, "\xab\x41\xa8\xb9\xa5\xa6\x0d\x23"}, /* .A.....# */ \
-	{0x00000410, "\x3d\x6c\xb9\xaa\x20\xb2\x18\x4c"}, /* =l.. ..L */ \
-	{0x00000418, "\xbc\x87\x1c\x9f\xe0\x35\x9b\x73"}, /* .....5.s */ \
+	{0x00000410, "\x02\xa0\xf1\x31\xc0\x4c\x42\xd1"}, /* ...1.LB. */ \
+	{0x00000418, "\xbd\x0b\xa0\xa3\xd9\xe8\x4b\x64"}, /* ......Kd */ \
 	{0x00000420, "\x22\x00\x00\x00\x00\x00\x00\x00"}, /* "....... */ \
-	{0x00000428, "\x31\x00\x00\x00\x00\x00\x00\x00"}, /* 1....... */ \
-	{0x00000438, "\x55\x00\x6e\x00\x6b\x00\x6e\x00"}, /* U.n.k.n. */ \
-	{0x00000440, "\x6f\x00\x77\x00\x6e\x00\x00\x00"}, /* o.w.n... */ \
+	{0x00000428, "\x23\x00\x00\x00\x00\x00\x00\x00"}, /* #....... */ \
 	{0x00000480, "\xa0\x84\x7a\x8a\x87\x83\xf6\x40"}, /* ..z....@ */ \
 	{0x00000488, "\xab\x41\xa8\xb9\xa5\xa6\x0d\x23"}, /* .A.....# */ \
-	{0x00000490, "\x57\x24\xf6\xe6\x0b\x6f\x66\x4e"}, /* W$...ofN */ \
-	{0x00000498, "\xb3\xd5\x99\x50\xa5\xc6\x4e\xc1"}, /* ...P..N. */ \
-	{0x000004a0, "\x32\x00\x00\x00\x00\x00\x00\x00"}, /* 2....... */ \
-	{0x000004a8, "\x41\x00\x00\x00\x00\x00\x00\x00"}, /* A....... */ \
-	{0x000004b8, "\x55\x00\x6e\x00\x6b\x00\x6e\x00"}, /* U.n.k.n. */ \
-	{0x000004c0, "\x6f\x00\x77\x00\x6e\x00\x00\x00"}, /* o.w.n... */ \
-	{0x00004400, "\x4e\xd5\x3f\x43\x01\x00\x00\x00"}, /* N.?C.... */ \
+	{0x00000490, "\x55\x2e\xe8\x5c\x7f\x10\x4b\xe7"}, /* U..\..K. */ \
+	{0x00000498, "\xb1\xb8\x3a\x84\xb7\x63\x1d\xcd"}, /* ..:..c.. */ \
+	{0x000004a0, "\x24\x00\x00\x00\x00\x00\x00\x00"}, /* $....... */ \
+	{0x000004a8, "\x25\x00\x00\x00\x00\x00\x00\x00"}, /* %....... */ \
+	{0x00004400, "\x71\x30\xcf\xf7\x02\x00\x00\x00"}, /* q0...... */ \
 	{0x00004408, "\x00\x00\x00\x00\x01\x00\x00\x00"}, /* ........ */ \
-	{0x00004410, "\x52\xcf\xd7\x09\x20\x07\x10\x47"}, /* R... ..G */ \
-	{0x00004418, "\x91\xd1\x08\x46\x9b\x7f\xe9\xc8"}, /* ...F.... */ \
-	{0x00004420, "\xeb\x2b\x27\x49\xd8\x8d\xdf\x46"}, /* .+'I...F */ \
-	{0x00004428, "\x8d\x75\x35\x6c\x65\xef\xf4\x17"}, /* .u5le... */ \
-	{0x00004430, "\x86\x7a\x05\x10\xf1\xda\x93\x4f"}, /* .z.....O */ \
-	{0x00004438, "\xba\x7f\xb1\x95\xf7\xfa\x41\x70"}, /* ......Ap */ \
-	{0x00004440, "\x01\x00\x00\x00\x00\x00\x00\x00"}, /* ........ */ \
-	{0x00004448, "\x3e\xed\x62\xdb\x37\x62\xb4\x4f"}, /* >.b.7b.O */ \
-	{0x00004450, "\x80\xc4\x1b\x74\xd8\x46\xa8\xe7"}, /* ...t.F.. */ \
+	{0x00004410, "\x78\x00\x00\x00\x20\x00\x00\x00"}, /* x... ... */ \
+	{0x00004418, "\xfc\xfc\xff\xff\x00\x00\x00\x00"}, /* ........ */ \
+	{0x00004420, "\x02\x00\x01\x00\x50\x00\x18\x00"}, /* ....P... */ \
+	{0x00004428, "\x83\xdf\xd5\x19\xb0\x11\x7b\x45"}, /* ......{E */ \
+	{0x00004430, "\xbe\x2c\x75\x59\xc1\x31\x42\xa5"}, /* .,uY.1B. */ \
+	{0x00004438, "\x17\xc7\xa9\x08\x4a\xb0\x6b\x45"}, /* ....J.kE */ \
+	{0x00004440, "\x8c\x82\x6f\x8e\x19\x39\xc5\x8b"}, /* ..o..9.. */ \
+	{0x00004448, "\xcc\x28\x74\xd5\x9a\xbb\xe0\x42"}, /* .(t....B */ \
+	{0x00004450, "\xaa\x36\x3f\x5a\x13\x20\x59\xc7"}, /* .6?Z. Y. */ \
 	{0x00004458, "\x01\x00\x00\x00\x00\x00\x00\x00"}, /* ........ */ \
-	{0x00004460, "\xf5\x21\x70\x5a\xf2\xfe\xb4\x48"}, /* .!pZ...H */ \
-	{0x00004468, "\xaa\xba\x83\x2e\x77\x74\x18\xc0"}, /* ....wt.. */ \
-	{0x00004470, "\xeb\x2b\x27\x49\xd8\x8d\xdf\x46"}, /* .+'I...F */ \
-	{0x00004478, "\x8d\x75\x35\x6c\x65\xef\xf4\x17"}, /* .u5le... */ \
-	{0x00004480, "\x3b\x0e\xd2\x0b\x9f\xab\x86\x49"}, /* ;......I */ \
-	{0x00004488, "\xb7\x90\x8d\xf3\x9c\x9c\xa3\x82"}, /* ........ */ \
-	{0x00004490, "\x01\x00\x00\x00\x00\x00\x00\x00"}, /* ........ */ \
-	{0x00004498, "\x6d\xe4\x25\x0e\x15\xb6\xd3\x4c"}, /* m.%....L */ \
-	{0x000044a0, "\x94\xda\x51\x79\x8f\xb1\x9e\xb1"}, /* ..Qy.... */ \
-	{0x000044a8, "\x01\x00\x00\x00\x00\x00\x00\x00"}, /* ........ */ \
-	{0x00006400, "\x4e\xd5\x3f\x43\x01\x00\x00\x00"}, /* N.?C.... */ \
-	{0x00006408, "\x00\x00\x00\x00\x01\x00\x00\x00"}, /* ........ */ \
-	{0x00006410, "\x52\xcf\xd7\x09\x20\x07\x10\x47"}, /* R... ..G */ \
-	{0x00006418, "\x91\xd1\x08\x46\x9b\x7f\xe9\xc8"}, /* ...F.... */ \
-	{0x00006420, "\xeb\x2b\x27\x49\xd8\x8d\xdf\x46"}, /* .+'I...F */ \
-	{0x00006428, "\x8d\x75\x35\x6c\x65\xef\xf4\x17"}, /* .u5le... */ \
-	{0x00006430, "\x86\x7a\x05\x10\xf1\xda\x93\x4f"}, /* .z.....O */ \
-	{0x00006438, "\xba\x7f\xb1\x95\xf7\xfa\x41\x70"}, /* ......Ap */ \
-	{0x00006440, "\x01\x00\x00\x00\x00\x00\x00\x00"}, /* ........ */ \
-	{0x00006448, "\x3e\xed\x62\xdb\x37\x62\xb4\x4f"}, /* >.b.7b.O */ \
-	{0x00006450, "\x80\xc4\x1b\x74\xd8\x46\xa8\xe7"}, /* ...t.F.. */ \
-	{0x00006458, "\x01\x00\x00\x00\x00\x00\x00\x00"}, /* ........ */ \
-	{0x00006460, "\xf5\x21\x70\x5a\xf2\xfe\xb4\x48"}, /* .!pZ...H */ \
-	{0x00006468, "\xaa\xba\x83\x2e\x77\x74\x18\xc0"}, /* ....wt.. */ \
-	{0x00006470, "\xeb\x2b\x27\x49\xd8\x8d\xdf\x46"}, /* .+'I...F */ \
-	{0x00006478, "\x8d\x75\x35\x6c\x65\xef\xf4\x17"}, /* .u5le... */ \
-	{0x00006480, "\x3b\x0e\xd2\x0b\x9f\xab\x86\x49"}, /* ;......I */ \
-	{0x00006488, "\xb7\x90\x8d\xf3\x9c\x9c\xa3\x82"}, /* ........ */ \
-	{0x00006490, "\x01\x00\x00\x00\x00\x00\x00\x00"}, /* ........ */ \
-	{0x00006498, "\x6d\xe4\x25\x0e\x15\xb6\xd3\x4c"}, /* m.%....L */ \
-	{0x000064a0, "\x94\xda\x51\x79\x8f\xb1\x9e\xb1"}, /* ..Qy.... */ \
-	{0x000064a8, "\x01\x00\x00\x00\x00\x00\x00\x00"}, /* ........ */ \
+	{0x00004460, "\x6d\x7d\xe3\x2b\x81\x82\x38\x49"}, /* m}.+..8I */ \
+	{0x00004468, "\xbd\x7b\x9a\x5b\xbf\x80\x86\x9f"}, /* .{.[.... */ \
+	{0x00004470, "\x01\x00\x00\x00\x00\x00\x00\x00"}, /* ........ */ \
+	{0x00004800, "\x71\x30\xcf\xf7\x02\x00\x00\x00"}, /* q0...... */ \
+	{0x00004808, "\x00\x00\x00\x00\x01\x00\x00\x00"}, /* ........ */ \
+	{0x00004810, "\x78\x00\x00\x00\x20\x00\x00\x00"}, /* x... ... */ \
+	{0x00004818, "\xfc\xfc\xff\xff\x00\x00\x00\x00"}, /* ........ */ \
+	{0x00004820, "\x02\x00\x01\x00\x50\x00\x18\x00"}, /* ....P... */ \
+	{0x00004828, "\x83\xdf\xd5\x19\xb0\x11\x7b\x45"}, /* ......{E */ \
+	{0x00004830, "\xbe\x2c\x75\x59\xc1\x31\x42\xa5"}, /* .,uY.1B. */ \
+	{0x00004838, "\x17\xc7\xa9\x08\x4a\xb0\x6b\x45"}, /* ....J.kE */ \
+	{0x00004840, "\x8c\x82\x6f\x8e\x19\x39\xc5\x8b"}, /* ..o..9.. */ \
+	{0x00004848, "\xcc\x28\x74\xd5\x9a\xbb\xe0\x42"}, /* .(t....B */ \
+	{0x00004850, "\xaa\x36\x3f\x5a\x13\x20\x59\xc7"}, /* .6?Z. Y. */ \
+	{0x00004858, "\x01\x00\x00\x00\x00\x00\x00\x00"}, /* ........ */ \
+	{0x00004860, "\x6d\x7d\xe3\x2b\x81\x82\x38\x49"}, /* m}.+..8I */ \
+	{0x00004868, "\xbd\x7b\x9a\x5b\xbf\x80\x86\x9f"}, /* .{.[.... */ \
+	{0x00004870, "\x01\x00\x00\x00\x00\x00\x00\x00"}, /* ........ */ \
 	{0x0000be00, "\xa0\x84\x7a\x8a\x87\x83\xf6\x40"}, /* ..z....@ */ \
 	{0x0000be08, "\xab\x41\xa8\xb9\xa5\xa6\x0d\x23"}, /* .A.....# */ \
-	{0x0000be10, "\x3d\x6c\xb9\xaa\x20\xb2\x18\x4c"}, /* =l.. ..L */ \
-	{0x0000be18, "\xbc\x87\x1c\x9f\xe0\x35\x9b\x73"}, /* .....5.s */ \
+	{0x0000be10, "\x02\xa0\xf1\x31\xc0\x4c\x42\xd1"}, /* ...1.LB. */ \
+	{0x0000be18, "\xbd\x0b\xa0\xa3\xd9\xe8\x4b\x64"}, /* ......Kd */ \
 	{0x0000be20, "\x22\x00\x00\x00\x00\x00\x00\x00"}, /* "....... */ \
-	{0x0000be28, "\x31\x00\x00\x00\x00\x00\x00\x00"}, /* 1....... */ \
-	{0x0000be38, "\x55\x00\x6e\x00\x6b\x00\x6e\x00"}, /* U.n.k.n. */ \
-	{0x0000be40, "\x6f\x00\x77\x00\x6e\x00\x00\x00"}, /* o.w.n... */ \
+	{0x0000be28, "\x23\x00\x00\x00\x00\x00\x00\x00"}, /* #....... */ \
 	{0x0000be80, "\xa0\x84\x7a\x8a\x87\x83\xf6\x40"}, /* ..z....@ */ \
 	{0x0000be88, "\xab\x41\xa8\xb9\xa5\xa6\x0d\x23"}, /* .A.....# */ \
-	{0x0000be90, "\x57\x24\xf6\xe6\x0b\x6f\x66\x4e"}, /* W$...ofN */ \
-	{0x0000be98, "\xb3\xd5\x99\x50\xa5\xc6\x4e\xc1"}, /* ...P..N. */ \
-	{0x0000bea0, "\x32\x00\x00\x00\x00\x00\x00\x00"}, /* 2....... */ \
-	{0x0000bea8, "\x41\x00\x00\x00\x00\x00\x00\x00"}, /* A....... */ \
-	{0x0000beb8, "\x55\x00\x6e\x00\x6b\x00\x6e\x00"}, /* U.n.k.n. */ \
-	{0x0000bec0, "\x6f\x00\x77\x00\x6e\x00\x00\x00"}, /* o.w.n... */ \
+	{0x0000be90, "\x55\x2e\xe8\x5c\x7f\x10\x4b\xe7"}, /* U..\..K. */ \
+	{0x0000be98, "\xb1\xb8\x3a\x84\xb7\x63\x1d\xcd"}, /* ..:..c.. */ \
+	{0x0000bea0, "\x24\x00\x00\x00\x00\x00\x00\x00"}, /* $....... */ \
+	{0x0000bea8, "\x25\x00\x00\x00\x00\x00\x00\x00"}, /* %....... */ \
 	{0x0000fe00, "\x45\x46\x49\x20\x50\x41\x52\x54"}, /* EFI PART */ \
 	{0x0000fe08, "\x00\x00\x01\x00\x5c\x00\x00\x00"}, /* ....\... */ \
-	{0x0000fe10, "\xa2\xce\x23\xfc\x00\x00\x00\x00"}, /* ..#..... */ \
+	{0x0000fe10, "\x56\x67\x8b\x7d\x00\x00\x00\x00"}, /* Vg.}.... */ \
 	{0x0000fe18, "\x7f\x00\x00\x00\x00\x00\x00\x00"}, /* ........ */ \
 	{0x0000fe20, "\x01\x00\x00\x00\x00\x00\x00\x00"}, /* ........ */ \
 	{0x0000fe28, "\x22\x00\x00\x00\x00\x00\x00\x00"}, /* "....... */ \
 	{0x0000fe30, "\x5e\x00\x00\x00\x00\x00\x00\x00"}, /* ^....... */ \
-	{0x0000fe38, "\xde\x99\xa2\x7e\x46\x34\xeb\x47"}, /* ...~F4.G */ \
-	{0x0000fe40, "\x87\xf6\x4f\x75\xe8\xd5\x7d\xc7"}, /* ..Ou..}. */ \
+	{0x0000fe38, "\xf5\xf3\x9d\xb9\x92\xdd\x48\x60"}, /* ......H` */ \
+	{0x0000fe40, "\x9a\x04\xe5\x2b\x11\xcb\x42\x61"}, /* ...+..Ba */ \
 	{0x0000fe48, "\x5f\x00\x00\x00\x00\x00\x00\x00"}, /* _....... */ \
 	{0x0000fe50, "\x80\x00\x00\x00\x80\x00\x00\x00"}, /* ........ */ \
-	{0x0000fe58, "\x2a\x64\x03\x83\x00\x00\x00\x00"}, /* .d...... */ \
+	{0x0000fe58, "\xc4\x80\x68\xad\x00\x00\x00\x00"}, /* ..h..... */ \
 	{0, NULL} } }
-- 
2.34.1

