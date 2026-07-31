Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C25AC54F54
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 12:40:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CBFF3410F1;
	Fri, 31 Jul 2026 12:40:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WjYmbWPVtlr0; Fri, 31 Jul 2026 12:40:52 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E2E2E41104
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785501652;
	bh=yJzaw7XQ2x4ZgNOBZPHaS5n6CUbcPd3jlhOmq0ic9d0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=L7bESI5I/9FvIl7sXd1flVfuqFH9CCWfWTkI/qMs2uT2eN2R2yhiko260AFxsAk43
	 REQeiVPy//QqFAa59orhWZCacR5bojYZziLT84R2UrklhJHYdNrWBGtECxzg8x00YO
	 fO+QmchBPDxFArIk3NSxdM5W7DObbvIpwPWPc+Sar6MOTYEOOdbD7VGsf/qBRIp0iz
	 Eaa9JuOgHXTEk0r5AlVmPP6Bw6SVCoJKvx+RD+3bHuGRzW12D0XT124J/aXcuh1R3i
	 q6I/wr21F0k2lEa8aMarkTp8j2ATISaG12UDTCfpK8sDOOARk57Xdb2c6UjJOcysBO
	 7YQEalbwlKP0w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E2E2E41104;
	Fri, 31 Jul 2026 12:40:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 85F0C2E9
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 12:40:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 83EEC4047C
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 12:40:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kpWkW7QT3qEt for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 12:40:49 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::435; helo=mail-wr1-x435.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 4A7F040471
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4A7F040471
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4A7F040471
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 12:40:49 +0000 (UTC)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-47f9ab7ee38so552618f8f.2
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 05:40:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785501647; x=1786106447;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yJzaw7XQ2x4ZgNOBZPHaS5n6CUbcPd3jlhOmq0ic9d0=;
 b=pIAKPAEtr5E6ywRsk+iUchk0+dfjmdxTuJDcyuWheandrC7JvMbyPbmVgm3Pfgovvj
 p2cf6PVDXmGQyLU1pn/J/4CTFAMIsu/TK8C7k9b1NyY+62HRXI6tQaRvzTDj21qfOAx3
 3NuFfzcIFiV2NeYgH1rMA6rtZL16iOLYuYCy6lmvz21v5Oq3TMVjCY5XjO7rcOXn5BCC
 +XVknXp6PKcKYwTPVy1ElpEnzJCYc99PmF8F5etuxdaLdWE2ph2hh9m7rV6jTKzS4isi
 ftZnl6rt1O4Ias0HCd7epp9/isR56zZosQlJc63kl0iV37dHwpHpQ8rFdx+mUVc423KV
 yGpA==
X-Gm-Message-State: AOJu0Yx2+YXdGnZIvzY8rGqKc5qjb3xDmV3dXhNqBwZWX7jrWB8xWldX
 frXlvWQ/zsHMDXWhEAQzsY6l2OI98FKkoFRJCnoyBaow5R7vVz5VyiGhNFlD4jDfm1M=
X-Gm-Gg: AR+sD10BNacD6ZtHabO6BvlnfdUgU7iLKRLO8RoLm9Pi2+SDSF8qQdmwTUYXPNBl9w2
 oFntZ2xPSe8tB9UauutxsMbEco8+o9iA0Owm0X7QqQnel2a6wvbYoadNEfhjKjhvgC6sskLEOVn
 0J/xUpMkcGEdMpVdWDmbGiXuPCIrIYGk6KKK/q2ZNvpgI4B4EsibF+gaccHUEJnBBIN62Dbzh7U
 NU+d1RMGd7jBZDODhJMXvCGXWx4FHTNkwLnAKiTItArXMKb3pTQwlsPwZV250IlBhM6yp0hWKdy
 vUktid00CfDH9LBuv1MsrTdI/vRPlN9lpiyqRgGJamGy8/eb+pmOTiK0AiNUSuVvkTmAsm6wWPG
 rcQ0BE2zQvrYr1Q0wMI2ZwW9G/MpeoABWCpcsyhabdSprKnA4XOMu3XuZlC4let1yTX/8g095EM
 brqTkSgpex6kMgu+HW7BTVSPBThhFZhdRc5VxHALrRb8fwABozNXMO53NAAPrB+n6RllHKrKxCr
 0DZUQtQgUzO+QqGyePSNSdoVXrWMXIyssDPbKBOkA==
X-Received: by 2002:a05:6000:2511:b0:47f:97bf:d891 with SMTP id
 ffacd0b85a97d-47fd2ab7867mr4204961f8f.1.1785501647274; 
 Fri, 31 Jul 2026 05:40:47 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-92-99-174-41.alshamil.net.ae.
 [92.99.174.41]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd41e296csm4493682f8f.12.2026.07.31.05.40.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 05:40:46 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 31 Jul 2026 16:40:03 +0400
Subject: [PATCH 4/6] test: dm: part: Check the GPT layout for large sector
 sizes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-gpt-4k-v1-4-a3f1f16b53ae@flipper.net>
References: <20260731-gpt-4k-v1-0-a3f1f16b53ae@flipper.net>
In-Reply-To: <20260731-gpt-4k-v1-0-a3f1f16b53ae@flipper.net>
To: u-boot@lists.u-boot-project.org, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Tom Rini <trini@konsulko.com>, Anton Burticica <mouse@ya.ru>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 Simon Glass <sjg@chromium.org>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Jacobe Zang <jacobe.zang@wesion.com>, Jagan Teki <jagan@edgeble.ai>, 
 Heiko Stuebner <heiko.stuebner@cherry.de>, Jonas Karlman <jonas@kwiboo.se>, 
 Suniel Mahesh <sunil@amarulasolutions.com>, 
 Klaus Goger <klaus.goger@cherry.de>, Tim Lunn <tim@feathertop.org>, 
 Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4870; i=alchark@flipper.net;
 h=from:subject:message-id; bh=zwdEBbrDwv+nCCpVroaddTQUFoAM0adlz9mrppfaJNw=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWTlTN8VvUVQ2+s0o6vZhadCP2TZNdoSM8+w3vumI8u+i
 ddrzrH2joksDGJcDJZiiixzvy2xnWrEN2uXh8dXmDmsTCBDpEUaGICAhYEvNzGv1EjHSM9U21DP
 0EjHWMeIgYtTAKba8STDP22OQvsp53wPbGd9fuFGblWsYOyd5NxHDQ+WSztLPMjnDmX4ZzAxcqH
 8Iq2jV3bx8p4U2f/5cK4+35OtUUlFhulKnyry2QA=
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1785501647; x=1786106447;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yJzaw7XQ2x4ZgNOBZPHaS5n6CUbcPd3jlhOmq0ic9d0=;
 b=msXPGkZrNHFhnlV5S9PL9ZvXk1VZlTGrIXrehdK0H1qebwSeNzLPCOthlqighCZxko
 CXufyJ2ayqsJvvlTCS4KEQwhoe9ZdHFiaUT7cvi7ivM/+bf3O+PqYD/X6+XuVy3wDtBf
 A1q5DicAXOk2PetvcScu+mGd9q6b+8iFTMvPlopa+uCMG2JibFAP4JHSguJDKQS7dfBZ
 7JKnBLLi8sLCPXsYBfYg66G9D/g3S6JFfF9UmezcYw0Mx6+xi1KyHF4t+MJioJOFtf0J
 34cH9JEzH9crwMi0cvUHL0goTLpDbPHPvghLDMJcArXv3KVAa3Ew4fb/N08V3FHnhXsR
 Nuuw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net
 header.a=rsa-sha256 header.s=google header.b=msXPGkZr
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

Add a test that runs gpt_fill_header() and gpt_fill_pte() over a range of
block sizes and checks that the partition entry array is sized and placed
consistently, in particular that the backup array ends exactly where the
backup GPT header begins.

Neither function performs any block I/O, so the test builds a synthetic
struct blk_desc rather than needing a block device with a configurable
block size. The expected array size is taken from the GPT header fields
rather than from GPT_ENTRY_NUMBERS, so the test still holds for builds
with a non-default CONFIG_EFI_PARTITION_ENTRIES_NUMBERS, such as
ARCH_SUNXI with 56 entries.

Without the preceding fixes this fails on the first block size other than
512:

  test/dm/part.c:313, dm_test_part_gpt_blksz():
      entry_lba + pte_blks == first_lba: Expected 0x12 (18), got 0x22 (34)

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 test/dm/part.c | 100 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/test/dm/part.c b/test/dm/part.c
index ad37d7f406f4..4b48322fb807 100644
--- a/test/dm/part.c
+++ b/test/dm/part.c
@@ -5,6 +5,8 @@
 
 #include <dm.h>
 #include <env.h>
+#include <malloc.h>
+#include <memalign.h>
 #include <mmc.h>
 #include <part.h>
 #include <part_efi.h>
@@ -248,3 +250,101 @@ static int dm_test_part_get_info_by_uuid(struct unit_test_state *uts)
 	return 0;
 }
 DM_TEST(dm_test_part_get_info_by_uuid, UTF_SCAN_PDATA | UTF_SCAN_FDT);
+
+/*
+ * Check that the GPT layout adapts to the block size of the device. Neither
+ * gpt_fill_header() nor gpt_fill_pte() does any block I/O, so a synthetic
+ * descriptor is enough here; partition_entries_offset() reads the device tree
+ * '/config' node, which is available without scanning for devices.
+ */
+static int dm_test_part_gpt_blksz(struct unit_test_state *uts)
+{
+	static const struct {
+		unsigned long blksz;
+		lbaint_t lba;
+	} cases[] = {
+		{   512, 0x2000 },	/* 4MB, the traditional 34-block layout */
+		{  1024, 0x1000 },
+		{  2048,  0x800 },
+		{  4096,  0x400 },	/* 4K native media, e.g. UFS */
+		{  8192,  0x200 },
+		{ 16384,  0x100 },	/* the array fits in a single block... */
+		{ 32768,   0x40 },	/* ...on a device smaller than 34 blocks */
+	};
+
+	char str_disk_guid[UUID_STR_LEN + 1] =
+		"8d60b397-1bb6-4d33-80ee-b1587d24c2f8";
+	struct disk_partition part;
+	struct blk_desc desc;
+	gpt_header gpt_h;
+	gpt_entry *gpt_e;
+	int i;
+
+	gpt_e = calloc(GPT_ENTRY_NUMBERS, sizeof(gpt_entry));
+	ut_assertnonnull(gpt_e);
+
+	for (i = 0; i < ARRAY_SIZE(cases); i++) {
+		u64 entry_lba, first_lba, last_lba;
+		u32 pte_blks;
+
+		memset(&desc, '\0', sizeof(desc));
+		memset(&gpt_h, '\0', sizeof(gpt_h));
+		desc.blksz = cases[i].blksz;
+		desc.log2blksz = LOG2(desc.blksz);
+		desc.lba = cases[i].lba;
+
+		ut_assertok(gpt_fill_header(&desc, &gpt_h, str_disk_guid, 1));
+
+		/*
+		 * Size the array with BLOCK_CNT() rather than the
+		 * DIV_ROUND_UP() that gpt_pte_blocks() uses, so that this
+		 * checks the layout instead of restating the implementation.
+		 */
+		pte_blks = BLOCK_CNT(le32_to_cpu(gpt_h.num_partition_entries) *
+				     le32_to_cpu(gpt_h.sizeof_partition_entry),
+				     (&desc));
+		entry_lba = le64_to_cpu(gpt_h.partition_entry_lba);
+		first_lba = le64_to_cpu(gpt_h.first_usable_lba);
+		last_lba = le64_to_cpu(gpt_h.last_usable_lba);
+
+		ut_asserteq_64(1, le64_to_cpu(gpt_h.my_lba));
+		ut_asserteq_64(desc.lba - 1, le64_to_cpu(gpt_h.alternate_lba));
+
+		/* the primary array ends where the usable area begins */
+		ut_assert(entry_lba >= 2);
+		ut_asserteq_64(entry_lba + pte_blks, first_lba);
+		ut_assert(first_lba < last_lba);
+
+		/*
+		 * write_gpt_table() puts the backup array at
+		 * last_usable_lba + 1, so it has to end exactly where the
+		 * backup header begins
+		 */
+		ut_asserteq_64(le64_to_cpu(gpt_h.alternate_lba),
+			       last_lba + 1 + pte_blks);
+
+		/* a partition with no start and no size fills the disk */
+		memset(&part, '\0', sizeof(part));
+		disk_partition_set_uuid(&part, str_disk_guid);
+		ut_assertok(gpt_fill_pte(&desc, &gpt_h, gpt_e, &part, 1));
+		ut_asserteq_64(first_lba, le64_to_cpu(gpt_e[0].starting_lba));
+		ut_asserteq_64(last_lba, le64_to_cpu(gpt_e[0].ending_lba));
+
+		/* a partition overlapping the entry array is rejected */
+		part.start = entry_lba;
+		part.size = 1;
+		ut_asserteq(-ENOSPC,
+			    gpt_fill_pte(&desc, &gpt_h, gpt_e, &part, 1));
+
+		/* so is one running past the end of the usable area */
+		part.start = first_lba;
+		part.size = last_lba - first_lba + 2;
+		ut_asserteq(-E2BIG,
+			    gpt_fill_pte(&desc, &gpt_h, gpt_e, &part, 1));
+	}
+
+	free(gpt_e);
+
+	return 0;
+}
+DM_TEST(dm_test_part_gpt_blksz, 0);

-- 
2.54.0

