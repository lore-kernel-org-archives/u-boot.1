Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559C7606A331
	for <u-boot@archiver.kernel.org>; Sat, 14 Nov 2026 00:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=QhdYSw/5
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2A4AC81547;
	Sat, 14 Nov 2026 00:12:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZA8sNxnZ30Y3; Sat, 14 Nov 2026 00:12:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 79144812FA
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794615141;
	b=MQFJ3PrDGLPqKU6F6eYV4bkhIpo5lkHu30pQ1SVoOdLHMe+vkijeDuRSbGEwBm4H2+Y3
	 y8ZqlsBp1jtHynJKnQuwipwkxD/AYZg2gYvjA692vr+vtIMIRCSarczOJuY7mJB1vQOF9
	 Ce5/EOSW0UGZhqFtSDykySmjUoAgkGvlFnYd0k4xjwRIkwTjTxCSIfULL0slfCzX1PECi
	 Sh08zWbIIu6LXyyutYROxdgAiMPO4jp9OsP+VPTUHbfI+OsDIkRgngfdCcWMQJjFrp8Bd
	 oPmpMU0s7MW/8lrQc3cO9OoL3nEBgMTVWKHp2E8bCXsvj6hxZUZHlBxCTi6AZcA167g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794615141;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:Date:
	 From:To:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=8O+DgGzv+2xQypEZiKNRRRPsRsN3qAsvBPt3wG1tijk=;
	b=IWYkrKiGL2QH/dumrtCfX9z/pjsFqYL4dK4yhXKfBNEsvIoQ9aTtSAAqMaffos4oFmrK
	 7qPyjm8veiIHjjQBrJkZ1lbAEMEx7Ntrekn0Iz+uzkGapnRFMYhiLiu3JzGjCkjUP+4Up
	 pKAsIUfzh6h3fSCL8KMl2GdG+iw7OOzqs/lR4Fajssx7xJUEIsffh7rZUhoBjD0rDC691
	 CtT5eFL4omGxD6IuJR6triVgCmC4JDaqkgVTTZiSywY447y6pYRT3A0TWErpSNtvYlEvk
	 MHJU2nzX2A9vJPPcoJF8b1ZOgL8VrgoZFWwFwcZ/4uB/pCMvuRFcJIkbseeSQJUOZBQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794615141;
	bh=8O+DgGzv+2xQypEZiKNRRRPsRsN3qAsvBPt3wG1tijk=;
	h=Date:From:To:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QhdYSw/5seboXls20RIB/fU18hLytkqD5vfcW0p/rvWRkZGJMLLHE6Lmxbk3nNvmQ
	 LaGhEUvFcUeTElDm4lmWeGt1eS5a5n3Fh8HCNL3o17YjiJDM0PUAWdiVbb6AIO7LPB
	 x1EfAEWM9hpS/JauY1Lxk32UbN9H4C3wUmZkd4XLN3CCusuY3zt5NGLTUA6gC0gGCC
	 XwdS0R0cPPFgyiH2gl+CwgiNP8XPNeKGvXn3sVQUPiuyi5RJisLXkueSZyjsOkyAFe
	 iGQLd4wmwn8pbXRV8rhrnJoJSqIBK5u7D9+7sNKA1DTti7N6j1ohFq8ri6JyFrvYyc
	 0xqB3+bQ55XTw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 79144812FA;
	Sat, 14 Nov 2026 00:12:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2A0B9260
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 00:12:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1BC904061D
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 00:12:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pi7en2yvbmsE for <u-boot@lists.u-boot-project.org>;
 Sat, 14 Nov 2026 00:12:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3C9AE40611
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a07:2ec0:3002::65"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a07:2ec0:3002::65;
 helo=pidgin.makrotopia.org; envelope-from=daniel@makrotopia.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3C9AE40611
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 00:12:18 +0000 (UTC)
Received: from local by pidgin.makrotopia.org with esmtpsa
 (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768) (Exim 4.100.1)
 (envelope-from <daniel@makrotopia.org>) id 1xS1NJ-0000000007z-4B1u;
 Sat, 14 Nov 2026 00:12:10 +0000
Date: Sat, 14 Nov 2026 00:12:07 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Alexey Brodkin <alexey.brodkin@synopsys.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>,
 Yao Zi <me@ziyao.cc>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Daniel Golle <daniel@makrotopia.org>,
 Aristo Chen <aristo.chen@canonical.com>,
 =?iso-8859-1?Q?Jo=E3o?= Loureiro <joaofl@gmail.com>,
 uboot-snps-arc@synopsys.com, u-boot@lists.u-boot-project.org,
 openwrt-devel@lists.openwrt.org
Subject: [PATCH 8/9] test: dm: sf: Check the block count after re-probing
Message-ID: <038d7127b0665d1b76a69922d91b7625f9f82ede.1794614777.git.daniel@makrotopia.org>
References: <cover.1794614777.git.daniel@makrotopia.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1794614777.git.daniel@makrotopia.org>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a test which removes and probes the SPI flash again, checking that
the number of child block devices stays the same. Compare with the
initial count so the test also works with CONFIG_MTD_BLOCK disabled.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 test/dm/sf.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/test/dm/sf.c b/test/dm/sf.c
index 0ec02ac694b..5c3a02d6f79 100644
--- a/test/dm/sf.c
+++ b/test/dm/sf.c
@@ -12,6 +12,7 @@
 #include <spi_flash.h>
 #include <asm/state.h>
 #include <asm/test.h>
+#include <dm/device-internal.h>
 #include <dm/test.h>
 #include <dm/util.h>
 #include <test/test.h>
@@ -106,3 +107,34 @@ static int dm_test_spi_flash_func(struct unit_test_state *uts)
 	return 0;
 }
 DM_TEST(dm_test_spi_flash_func, UTF_SCAN_PDATA | UTF_SCAN_FDT);
+
+static int sf_count_blk(struct udevice *dev)
+{
+	struct udevice *child;
+	int count = 0;
+
+	list_for_each_entry(child, &dev->child_head, sibling_node)
+		if (device_get_uclass_id(child) == UCLASS_BLK)
+			count++;
+
+	return count;
+}
+
+/* Test that probing the flash again does not add a block device */
+static int dm_test_spi_flash_reprobe_blk(struct unit_test_state *uts)
+{
+	struct udevice *dev;
+	int count;
+
+	ut_assertok(uclass_first_device_err(UCLASS_SPI_FLASH, &dev));
+	count = sf_count_blk(dev);
+
+	ut_assertok(device_remove(dev, DM_REMOVE_NORMAL));
+	ut_assertok(device_probe(dev));
+	ut_asserteq(count, sf_count_blk(dev));
+
+	sandbox_sf_unbind_emul(state_get_current(), 0, 0);
+
+	return 0;
+}
+DM_TEST(dm_test_spi_flash_reprobe_blk, UTF_SCAN_PDATA | UTF_SCAN_FDT);
-- 
2.56.0
