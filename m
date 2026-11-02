Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1078E609A70E
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 16:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Wme6rUio;
	dkim=pass (2048-bit key, unprotected) header.d=fris.de header.i=@fris.de header.a=rsa-sha256 header.s=mail header.b=JduNHOsR
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E350F60835;
	Mon,  2 Nov 2026 16:21:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Z7nyXKKOQkAT; Mon,  2 Nov 2026 16:21:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CAFD060820
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793636479;
	b=ntrQHRdWVFqKhhs1PSVMXlQnH93Blr2S4COWlDoX8bT10Rnb4AP00hazpvwBURTWodO1
	 ZRiOVJUxz/dN6Z7JA3gUqsKM/8V+dqJVztXNEtWPt9GvoEsH/0Rf2HAkyGXmJNUNFxFQn
	 D3Al9s4wOSA+Z7cHRBTNlbXbAxJd6sQXMasH5xdU8vP42bqoxwDkDkKOElfSycWXoqEUH
	 IgB6n9xtqCcqIkNVdCZD5ciU7RSPotySgM2WLiydXvHA4g4C26fRDsoFPabWTi8hxxZ+p
	 FOmnzl+hTLQSMluUIIqta0EvUV92SsxgnfkjUHGb2YLSb9qYzUY013hTbq8CIcSSH6Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793636479;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:From:
	 DKIM-Signature:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Developer-Signature:X-Developer-Key:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=rfwli5Esp4Q0cyGpe58UfDegSolr6+kGAwBoMa0jrc4=;
	b=AhuOo54jk4L0QiZBKgYY8lhK4ks3yTWJgNzuW2MRyvL3AAtlA725y9T2CHdq5uIGUScB
	 IrKw0MXhxxgcZWhdCBC9xU77dW4H0Y1GJfxij+JEVEGLItPO6DQzegjBAkWOU3WMGb6z+
	 FgYZRi0/Smn8QFN6njVwHywKJVz7cCZ8tiPpLmdBoNv1dmP21D0vczqad1N5/J1jLqc1G
	 VRAupd3DBVWFhY0eUztsQhTOAxXcFjwNIvV2fq6rzUz4ebQzdwFEgPqH8+eoA+jODsAop
	 CxKjh4JR8qvsQU4GqOuzy8lnwSVbZTFeqD2Nk6bEI+eLv/cvkSmSvvTVM2vhZfx1YOQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=fris.de;
	dkim=pass header.d=fris.de header.i=@fris.de header.a=rsa-sha256 header.s=mail header.b=JduNHOsR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793636478;
	bh=rfwli5Esp4Q0cyGpe58UfDegSolr6+kGAwBoMa0jrc4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Wme6rUioQb+nYT9SCAU1VMWI3nSwYgDbJF/EurXbhmbRPfNhxW+73pxcXMScWU0P3
	 APiGpJkN9vKOBUkNijtfw3xpeiB6x19xu5RrWvZFIjObINkzDe++ppkzoeIviJ7oDH
	 JnGYGI3cvqE1z/n4c846lIXy/AbZd/El+tUP0oQmt4goWafHev99tPGdZEwILOI6we
	 rrZx336daTJT2fGR4QkNb9duQBzu21mwwqfM+JDCgsepA05Xjkh28K9Mkg6GNnD/0t
	 hsUhdLNNf5GvOssDtXL10NyLycci5WpyUK9LP2XHMnGWQoNR118rZk/A6QBq3zcuQY
	 sQuxnJSn18FAw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CAFD060820;
	Mon,  2 Nov 2026 16:21:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 992102A8
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 16:20:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8ABE86060D
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 16:20:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Tg0wWnuSp4eu for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 16:20:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 426DC607F2
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=116.203.77.234
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793636455;
 b=np5qiy97suhK9KK+LKvN3C2MfZmL3sxvCbAzibjJfHeoqaueSJ4MxnMUgtlHzQ0omzsc
 tlpHZLnaO0iVUe4p2NXSgQwDIgV6FpCWzOKydzSDfTyZg2WC0XxwUBm3SI6fJMbUg64Jb
 NNgHDdcSH1qAhrwC0VEzkIswq7geVGz5iFoAiHr3OGxjeKTJ8YCMJhiU7MwveNNonoT8V
 DYnCYSH+3Dcx+1J96wTlOIapq6EIn+GAXQB3uD84Mavm+xQe6xbU2orB7dpdIBpEAd/q/
 l4sOHn/YiPAKVxbkfwIj33Y/StgwVhtYBm/8KnqSTBPIr/23E1UdDVGpCD+WaCHGSdA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793636455;
 h=Received-SPF:From:DKIM-Signature:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Developer-Signature:X-Developer-Key;
 bh=rfwli5Esp4Q0cyGpe58UfDegSolr6+kGAwBoMa0jrc4=;
 b=WmxE6vyQUNtKbdzSCCtvnRDMPKWuEap0lZPqzDKdS+u3uxJm5kQB/DrPsC87WQoCbzVq
 +7V0TBPrrVobfrpLBuLJqACGsie6zSNQ3GUCRpgyLWzn57awyInWwFlRMklNo3csHyW9S
 1IytpCg+glyA7ID210r/7iDWZjo7yrqi3NngAVz7KN9TiS7a5RG1BZ0csUppKQdtNLbRW
 ip32kvbjzjfvnZaM1G58oT2Lk/ElQ0T/CaNSLQWbKa9zAf6iwKI2ax2+YpsSxWs26sRlB
 fQAs8r5+slUlUS33GLYKb8AZW5FjGJ7lxeDeE1j1ZebQIgfSDVwq1rNq2Y6TED9wmyw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=fris.de;
 dkim=pass header.d=fris.de header.i=@fris.de header.a=rsa-sha256 header.s=mail
 header.b=JduNHOsR; 
 arc=none smtp.remote-ip=116.203.77.234
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.203.77.234;
 helo=mail.fris.de; envelope-from=frieder@fris.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de
 header.a=rsa-sha256 header.s=mail header.b=JduNHOsR
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 426DC607F2
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 16:20:54 +0000 (UTC)
From: Frieder Schrempf <frieder@fris.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=mail;
 t=1793636450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rfwli5Esp4Q0cyGpe58UfDegSolr6+kGAwBoMa0jrc4=;
 b=JduNHOsRWLidyYumO6ts5hX6tpNjva/LN+C9Tpp1CgVg2hayfbwcECnRxlpb17IrS2DX5M
 4OQjYwcTpGs0ns3npwZ0On2t9F2ybKfD6CBYS1Fq1uh4qp4vNd8aQ++tu+wm8rJ+XoCWay
 GbCmpqioe6MbH7KTa2em+1+2ny374jpADm61t1PoWeNBvC2a4u0QDdqczMA0qGrG/W/7CL
 ztdqE6G0YZgOcsmqpb7Fo6d6uI3hM2C4lRt3jSHGWmXypMbr8FLXt+22PcDzpwnwPi6HPu
 Oyj73FvV+O5aRH8DeVKslTgXEXU2w65kHlpeQcL6CZgw1/WTMTLTQFEc9i3SZw==
Date: Mon, 02 Nov 2026 17:20:28 +0100
Subject: [PATCH v2 11/12] test: boot: Test finding the RAUC partitions by name
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-main-v2-11-4537bcb19d66@kontron.de>
References: <20261102-main-v2-0-4537bcb19d66@kontron.de>
In-Reply-To: <20261102-main-v2-0-4537bcb19d66@kontron.de>
To: Martin Schwan <m.schwan@phytec.de>, u-boot@lists.u-boot-project.org
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Alexey Charkov <alchark@flipper.net>, Daniel Golle <daniel@makrotopia.org>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut <marex@nabladev.com>, 
 Michal Simek <michal.simek@amd.com>, Francesco Valla <francesco@valla.it>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=10842;
 i=frieder.schrempf@kontron.de; h=from:subject:message-id;
 bh=/JL0Jzpjv783E3NR1OQNS+6+n89vd5zA1mvyAgVRwsI=;
 b=owGbwMvMwCWWWSatKlDTJMZ4Wi2JIevFjrgrSWbVU25s3b63reuWgIaO7fkf37aVvlnBLpKw/
 E0El92pjlIWBjEuBlkxRRYpfovXtmaxPvLHqqNg5rAygQxh4OIUgIksYmRk+O2x6sxWtxcF3PP0
 VX8cmDaTyTfw1EzDtjnHpa313ee2b2D4H/XTq6Pv29Z5FU05txg33ffcccRrlqlYnLdBg/lBVcN
 cDgA=
X-Developer-Key: i=frieder.schrempf@kontron.de; a=openpgp;
 fpr=1A0F38EB3D365D4C1FC67B5A69761B25107C8216
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Frieder Schrempf <frieder.schrempf@kontron.de>

Add a second RAUC test image (mmc13) with a GPT and named partitions,
and tests that give the partitions by name in the platform data of the
RAUC bootmeth. The bootmeth must find a bootflow on mmc13 if the
partitions of all slots exist, and none if those of one or all slots
are missing. On the RAUC test image mmc10, which stays on MBR and has
no partition names, it must find a bootflow by the partition numbers,
but none by the names. If it finds no bootflow, the RAUC variables must
not be set in the environment.

The RAUC tests now reset the options of the bootmeth to their default
values before each check, so that they don't depend on the Kconfig
values of the build.

Assisted-by: LLM
Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
Changes in v2:
- Set the partitions in the platform data of the bootmeth instead of
  CONFIG_BOOTMETH_RAUC_PART_NAMES in sandbox_defconfig, and drop the
  #ifdef (Simon)
- Keep mmc10 on MBR and use mmc13 with GPT partition names
- Also check matching names, a slot with missing partitions and
  finding mmc10 by partition numbers (Simon)
- Check that the RAUC variables are not set for an unused device
  (Simon)
- Move the tests next to bootflow_rauc() (Simon)
- Rename from "test: boot: Test the RAUC partition name check"
---
 arch/sandbox/dts/test.dts |   8 ++++
 test/boot/bootflow.c      | 118 +++++++++++++++++++++++++++++++++++++++++++---
 test/py/tests/test_ut.py  |  26 ++++++----
 3 files changed, 137 insertions(+), 15 deletions(-)

diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index 02a9ca29b79..895ecb97e87 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -51,6 +51,7 @@
 		mmc10 = "/mmc10";
 		mmc11 = "/mmc11";
 		mmc12 = "/mmc12";
+		mmc13 = "/mmc13";
 		pci0 = &pci0;
 		pci1 = &pci1;
 		pci2 = &pci2;
@@ -1406,6 +1407,13 @@
 		filename = "mmc12.img";
 	};
 
+	/* This is used for RAUC boot tests with GPT partition names */
+	mmc13 {
+		status = "disabled";
+		compatible = "sandbox,mmc";
+		filename = "mmc13.img";
+	};
+
 	pch {
 		compatible = "sandbox,pch";
 	};
diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index 20c371d984c..0c22ad58521 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -9,6 +9,7 @@
 #include <bootdev.h>
 #include <bootflow.h>
 #include <bootmeth.h>
+#include <bootmeth_rauc.h>
 #include <bootstd.h>
 #include <cli.h>
 #include <dm.h>
@@ -1626,17 +1627,23 @@ BOOTSTD_TEST(bootflow_efi, UTF_CONSOLE);
  * and bootmeth used, then runs @check. The bootdev order is restored even if
  * @check fails, since bootstd frees it when it is removed.
  *
+ * The options of the bootmeth are reset to their defaults, so that the tests
+ * do not depend on the Kconfig values. @check can change them.
+ *
  * @uts: Unit test state
  * @mmc_dev: MMC device to use, e.g. "mmc10"
  * @check: Checks to run with the RAUC bootmeth
  * Returns 0 on success, -ve on failure
  */
 static int bootflow_rauc_run(struct unit_test_state *uts, const char *mmc_dev,
-			     int (*check)(struct unit_test_state *uts))
+			     int (*check)(struct unit_test_state *uts,
+					  struct distro_rauc_plat *rplat))
 {
 	static const char *order[] = {NULL, NULL};
+	struct distro_rauc_plat *rplat;
 	struct bootstd_priv *std;
 	struct udevice *bootstd;
+	struct udevice *dev;
 	const char **old_order;
 	ofnode root;
 	ofnode node;
@@ -1653,20 +1660,23 @@ static int bootflow_rauc_run(struct unit_test_state *uts, const char *mmc_dev,
 	/* Enable the rauc bootmeth */
 	ut_assertok(uclass_first_device_err(UCLASS_BOOTSTD, &bootstd));
 	ut_assertok(device_bind(bootstd, DM_DRIVER_REF(bootmeth_rauc),
-				"rauc", 0, ofnode_null(), NULL));
+				"rauc", 0, ofnode_null(), &dev));
 	ut_assertok(bootmeth_set_order("rauc"));
+	rplat = dev_get_plat(dev);
+	rplat->partitions = "1,2 3,4";
 
 	/* Change the device order, and restore it also if a check fails */
 	std = dev_get_priv(bootstd);
 	old_order = std->bootdev_order;
 	std->bootdev_order = order;
-	ret = check(uts);
+	ret = check(uts, rplat);
 	std->bootdev_order = old_order;
 
 	return ret;
 }
 
-static int bootflow_rauc_check(struct unit_test_state *uts)
+static int bootflow_rauc_check(struct unit_test_state *uts,
+			       struct distro_rauc_plat *rplat)
 {
 	ulong mem_start;
 
@@ -1746,7 +1756,8 @@ BOOTSTD_TEST(bootflow_rauc, UTF_CONSOLE | UTF_DM | UTF_SCAN_FDT);
  * Returns 0 on success, -EAGAIN if not supported, other -ve on failure
  */
 static int bootflow_rauc_run_env_fat(struct unit_test_state *uts,
-				     int (*check)(struct unit_test_state *uts))
+				     int (*check)(struct unit_test_state *uts,
+						  struct distro_rauc_plat *rplat))
 {
 	int ret;
 
@@ -1778,7 +1789,8 @@ static int bootflow_rauc_boot(struct unit_test_state *uts)
 	return 0;
 }
 
-static int bootflow_rauc_boot_twice_check(struct unit_test_state *uts)
+static int bootflow_rauc_boot_twice_check(struct unit_test_state *uts,
+					  struct distro_rauc_plat *rplat)
 {
 	/* Start with the default tries, also when running a second time */
 	ut_assertok(env_set("BOOT_A_LEFT", NULL));
@@ -1818,6 +1830,100 @@ static int bootflow_rauc_boot_twice(struct unit_test_state *uts)
 }
 BOOTSTD_TEST(bootflow_rauc_boot_twice, UTF_CONSOLE | UTF_DM | UTF_SCAN_FDT);
 
+/* Remove the RAUC variables, which are set when a device is found */
+static int bootflow_rauc_clear_env(struct unit_test_state *uts)
+{
+	ut_assertok(env_set("BOOT_ORDER", NULL));
+	ut_assertok(env_set("BOOT_A_LEFT", NULL));
+	ut_assertok(env_set("BOOT_B_LEFT", NULL));
+
+	return 0;
+}
+
+/* Check that scanning finds no bootflow and leaves the environment alone */
+static int bootflow_rauc_scan_none(struct unit_test_state *uts)
+{
+	ut_assertok(bootflow_rauc_clear_env(uts));
+	ut_assertok(run_command("bootflow scan", 0));
+	ut_assert_nextline("No bootflows found; try again with -l");
+	ut_assert_console_end();
+	ut_assertnull(env_get("BOOT_ORDER"));
+	ut_assertnull(env_get("BOOT_A_LEFT"));
+	ut_assertnull(env_get("BOOT_B_LEFT"));
+
+	return 0;
+}
+
+static int bootflow_rauc_part_names_check(struct unit_test_state *uts,
+					  struct distro_rauc_plat *rplat)
+{
+	/* The partitions of all slots are found by their names */
+	rplat->partitions = "boot_a,root_a boot_b,root_b";
+	ut_assertok(bootflow_rauc_clear_env(uts));
+	ut_assertok(run_command("bootflow scan", 0));
+	ut_assert_console_end();
+	ut_asserteq_str("A B", env_get("BOOT_ORDER"));
+
+	ut_assertok(run_command("bootflow list", 0));
+	ut_assert_nextlinen("Showing all");
+	ut_assert_nextlinen("Seq");
+	ut_assert_nextlinen("---");
+	ut_assert_nextlinen("  0  rauc         ready   mmc          0  mmc13.bootdev.whole      ");
+	ut_assert_nextlinen("---");
+	ut_assert_skip_to_line("(1 bootflow, 1 valid)");
+	ut_assert_console_end();
+
+	/* The partitions of slot B are missing */
+	rplat->partitions = "boot_a,root_a boot_c,root_c";
+	ut_assertok(bootflow_rauc_scan_none(uts));
+
+	/* The partitions of no slot are found */
+	rplat->partitions = "boot,rootfs boot2,rootfs2";
+	ut_assertok(bootflow_rauc_scan_none(uts));
+
+	return 0;
+}
+
+/* Test finding the RAUC partitions by their names */
+static int bootflow_rauc_part_names(struct unit_test_state *uts)
+{
+	if (!CONFIG_IS_ENABLED(BOOTMETH_RAUC))
+		return -EAGAIN;
+
+	return bootflow_rauc_run(uts, "mmc13", bootflow_rauc_part_names_check);
+}
+BOOTSTD_TEST(bootflow_rauc_part_names, UTF_CONSOLE | UTF_DM | UTF_SCAN_FDT);
+
+static int bootflow_rauc_part_names_mbr_check(struct unit_test_state *uts,
+					      struct distro_rauc_plat *rplat)
+{
+	/* The partitions are found by their numbers */
+	ut_assertok(bootflow_rauc_clear_env(uts));
+	ut_assertok(run_command("bootflow scan", 0));
+	ut_assert_console_end();
+
+	ut_assertok(run_command("bootflow list", 0));
+	ut_assert_skip_to_line("(1 bootflow, 1 valid)");
+	ut_assert_console_end();
+
+	/* MBR has no partition names */
+	rplat->partitions = "boot_a,root_a boot_b,root_b";
+	ut_assertok(bootflow_rauc_scan_none(uts));
+
+	return 0;
+}
+
+/* Test that the RAUC bootmeth rejects MBR devices if names are given */
+static int bootflow_rauc_part_names_mbr(struct unit_test_state *uts)
+{
+	if (!CONFIG_IS_ENABLED(BOOTMETH_RAUC))
+		return -EAGAIN;
+
+	return bootflow_rauc_run(uts, "mmc10",
+				 bootflow_rauc_part_names_mbr_check);
+}
+BOOTSTD_TEST(bootflow_rauc_part_names_mbr, UTF_CONSOLE | UTF_DM | UTF_SCAN_FDT);
+
 /*
  * Test the BLS bootmeth against entries that live below a '/boot/' prefix,
  * so that they are only found via the second bootstd prefix. The Fedora
diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
index 36d0f14973d..51eca5cf98b 100644
--- a/test/py/tests/test_ut.py
+++ b/test/py/tests/test_ut.py
@@ -583,10 +583,15 @@ def setup_efi_image(ubman):
     fsh.cleanup()
 
 
-def setup_rauc_image(ubman):
-    """Create a 40MB disk image with an A/B RAUC system on it"""
-    mmc_dev = 10
+def setup_rauc_image(ubman, mmc_dev, part_names=None):
+    """Create a disk image with an A/B RAUC system on it
 
+    Args:
+        ubman (ConsoleBase): Console to use
+        mmc_dev (int): MMC device number, e.g. 10
+        part_names (tuple of str): GPT names of the boot A, root A, boot B
+            and root B partitions, or None to use MBR
+    """
     boot = FsHelper(ubman.config, 'fat32', 8, 'rauc_boot')
     boot.setup()
 
@@ -606,11 +611,13 @@ def setup_rauc_image(ubman):
     root = FsHelper(ubman.config, 'ext4', 10, 'rauc_root')
     root.mk_fs()
 
-    img = DiskHelper(ubman.config, mmc_dev, 'mmc', True)
-    img.add_fs(boot, DiskHelper.VFAT, bootable=True)
-    img.add_fs(root, DiskHelper.EXT4)
-    img.add_fs(boot, DiskHelper.VFAT, bootable=True)
-    img.add_fs(root, DiskHelper.EXT4)
+    boot_a, root_a, boot_b, root_b = part_names or (None,) * 4
+    img = DiskHelper(ubman.config, mmc_dev, 'mmc', True,
+                     gpt=part_names is not None)
+    img.add_fs(boot, DiskHelper.VFAT, bootable=True, name=boot_a)
+    img.add_fs(root, DiskHelper.EXT4, name=root_a)
+    img.add_fs(boot, DiskHelper.VFAT, bootable=True, name=boot_b)
+    img.add_fs(root, DiskHelper.EXT4, name=root_b)
     img.create()
     boot.cleanup()
     root.cleanup()
@@ -626,7 +633,8 @@ def test_ut_dm_init_bootstd(ubman):
     setup_cros_image(ubman)
     setup_android_image(ubman)
     setup_efi_image(ubman)
-    setup_rauc_image(ubman)
+    setup_rauc_image(ubman, 10)
+    setup_rauc_image(ubman, 13, ('boot_a', 'root_a', 'boot_b', 'root_b'))
     setup_bls_prefix_image(ubman)
 
     # Restart so that the new mmc1.img is picked up

-- 
2.56.0

