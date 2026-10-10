Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88DA3CA6017
	for <u-boot@archiver.kernel.org>; Sat, 10 Oct 2026 13:12:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BF32560631;
	Sat, 10 Oct 2026 13:12:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RGvOOsi54gkj; Sat, 10 Oct 2026 13:12:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 48EE9608E3
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791637935;
	b=WHVenxN6Oyh0pZsqzidca3a3zj47TDoOVQQzxGouoTfJY4KdGpyr9BNWC0kBVfDcJIUM
	 qqh0756ZkaHCHiNA9k35Ifr/nBXnZaZcGYgApnXapwgFj8f7kv1XpbsNO55nF/qU2t5B/
	 BMkLE09ERwc59e7tCHNOMhlZxZRoRetPjqy7LE853Wdy1KyXN7vyNC6l/o6cGt9QWCopB
	 WbD86GUSurQWezwodmDHIdnGh4/KmQ5qM7jZYz1sirssHxXi1PXq86M23kQTRdETc/iwk
	 S1K9msMOsjjMAlcK5zCwYUf+oGzjjQ8lwCdy+To/vLpAgHYVgqNWboDIt/4brRQHeIw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791637935;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=N2MfyzrPQoVWgePR5emSu7LkdCgZ4zvzIbMXyijj8oc=;
	b=f24Phbg4D72NGSFFF0T6u97Erwi/5kIdOLwALmNagYOvTfCD9vWmeHxjgEL/b+JjB0h7
	 8d4BzshhIBEELI9x/Kyl5HgqfcARDR1wTEOJODD+Z9KaIj6r7Gve3dXyOREIDg1yaMmm0
	 Jw7wIl/iWI/OvYb8XD4QaiBRw+ehghBRUhnGyYSLoSYJzp9EFdpG/JZGyJfPIjLneQqq1
	 z2pzCrI+ChuSZriADKl2J1nKkrSBjkdTCWlhlOwSJ5rqnkcMT2tJi0bwCv59O+LTZRSgR
	 HHN0bJqztHp8lVA8q50O1yxyww5HPEuYixWoB4jd3bsD55dzyVmSIPXpV/j9AaFKLhQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791637935;
	bh=N2MfyzrPQoVWgePR5emSu7LkdCgZ4zvzIbMXyijj8oc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=enJnBr2TZL03+3zXEaSzswD0UqCEIBTbeSjMrQCiMMPNVo9RHHiiIXsgKDeEM4GPS
	 aEoRAZ2lCw2jhFnSGkgaGnbJthuzvdkUGz3dqqzGR5Cd7bWAAKzNls9x1M3KYsRNAJ
	 B9y6z0toknY0MItpOm/F4OSQRhJkb7Qf0tlz49TsL3LJsqokClO8Y6r7vo7Q0m7XRr
	 JiuGsHOMUxjBvdjekPUKGFaAbhP0VOiERCQAnoNsfKSOlu4Su+la4+tOsqpMGkk64P
	 W7geQzRZAatXZ/xhMnAU2IeK1FUVgHyKC4ZBQWUBC3OYnBKnp7k7kPGjZyT2kNV7aq
	 nHGTxt4bKY3yg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 48EE9608E3;
	Sat, 10 Oct 2026 13:12:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id BEA6922B
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 13:12:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A47864080E
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 13:12:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VF0b2a_9WLvC for <u-boot@lists.u-boot-project.org>;
 Sat, 10 Oct 2026 13:12:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8D40B40809
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::62a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791637933;
 b=LkMwM1a1/nlD+Ombkzu1bU+oa4NOjidolZUnag43SoMWKhtgI4BiBFDr6dhFpwzOVfxy
 Jz/+P07kyjT+ZthsCVJ3n0Jv+pHncXJCuU1uwhn+Jks7y5whk3xkpXWzGM9zJu5izmqa0
 TGuH40gfCz9V7NLEAwctLOpqSTQdmjjlXTUubPW8ktCb9owBrVwWBMJDZu7JY5m69ke21
 DsNd1LMyopscTZ7bEBk+L0u5c2ZEQXgzhMvKh33KSx0NwWq5rB+d8WlepExdqTQ/i/uqJ
 eDmJd6bhwlAPGQkIdbJrwaUNRZ54zSgozwdP3qXf0875SMh2rwiOjrgXdlPth3vG2YQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791637933;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=N2MfyzrPQoVWgePR5emSu7LkdCgZ4zvzIbMXyijj8oc=;
 b=HVQHUPJt8BvswM60hTUHSjDDHXxknzXXrk/FTK+FSWDFe7XvopY5wRNT+VjQq0xotT3f
 BX1MRkgFwEjnTkLvXh7TRYHzbNyaSUrU6F2RNucNMSxFo0R/uYIGeiJSg+jR2o/GtYxfT
 Sc1dhG9AshBSy0NbtK8ERprp/uX1jlaO1iWUpjbi16RL5GMyV84JHrZpYI2ySjh2+6Y0a
 u+4rAg0sKFyglfEd03hoPJ/iVBhmI/sh+YI9KZzX2+keKgVEw56C5+W/TFpqm90u6td+I
 nuvmMOBxbFWQ7wwkplXkdoQ4jpxKBlrgU9EuDhUtmuR9sm0O/NLfDpipzRpg9fFDvsA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=flipper.net;
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=Dqwqcuba; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::62a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62a; helo=mail-ej1-x62a.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net
 header.a=rsa-sha256 header.s=google header.b=Dqwqcuba
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8D40B40809
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 13:12:12 +0000 (UTC)
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-c2dcbcc546fso68682166b.3
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 06:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1791637930; x=1792242730;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=N2MfyzrPQoVWgePR5emSu7LkdCgZ4zvzIbMXyijj8oc=;
 b=DqwqcubaIb2MVMu1086TvR3y6KnyAMKiObGLnlo6hqUu6el4eTZq4sVz3Qgm1zdzIV
 etShxT/mk6r3h+/O3ZmVpxqPVnjEd4SG6/yh+84gJHRQO9ivzlTldUVu7T+lFKP/76/S
 33EeAPor2zsq/aXxAXCW5nn/2JENjI/AMRoG95/z8f6WTbLsZiEGuq7aCXjoNIlzXLBh
 cD5MzP78xgJu1itt5wj/hVvE/X1Dh+zG+59MC0HzKzbcF3a5kP+5Gv2mig31cR1JqaWM
 FyFsBEjV+SBnR1xlXV0uVBSX5Vh1bs2KwMVdMo755fiErXoE0GpEEncmFNkfJlzbPOrn
 PT7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791637930; x=1792242730;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=N2MfyzrPQoVWgePR5emSu7LkdCgZ4zvzIbMXyijj8oc=;
 b=BedbpXL2llOqVZ9IZuWwtLfGv2M+Lr04pajIJf6QXT7R3OCHCB3eUYEOYpYZ9bVUYw
 CsFeqBFuxf6vEM/KwvyoSKZgsc0mxXp8ErnJABn9pv36HeOUDHuieFrJfhFT6z23Hd0X
 sFYT99WO8wkmRkgh2u9n9jSNNjYf3LTFZGjt28LOOyPwPagbu7oiCmCumAPisjwFNTvv
 Psl2OWzAKqff0rK51RXezyYj4CcjNEhCzmyeyqnU6owC5mcLjVlgEk6GyB8i+gq26SLS
 O+k3+2jL2L//BqND4FJgKmoAbqio1G9Yn7I8dgvMcEzW0z31k2hIHr9PT05RolV2gEvy
 6OMQ==
X-Gm-Message-State: AFq9FYJftsTwyr25R25tzl6zpUI2rlQajCNh98jlwTIvRNOjIzxAkdu5
 pgWL9CS6XssxYy7LeHzBSm+GRM8AVz1uArfSx5WlCfaRqa0O8ZXLYR3l4YoF45fqK4A=
X-Gm-Gg: AYBFou1Z31hRKcE2TCB2yNpH2kewegB9ut98uurNUHMJT60QVo1l7VIzNTpZVCpq2h0
 YEeBD8yvolPh0H4nFWHxWkhWWtS9rPL32EtrR1aub+4bJAU0wC1mdxHi1Zflu8RMyY1qqChmbQd
 H/pR1uWRzCHFLWEq7sHqL+wjJ+R/cVNDXqEIzGETfJPWWD9zSSpbTIDQsqQOubg2Jagk3lLQ7+v
 3ayPbcZE/EEdm9hfv7RZkdjFUP5iNO+1LFz6SBhIBF/XdnOZV44XacyXTsTQ8Joxe0T1fP1da1c
 1+mRZvtDrUM70X7/f5Rjk0fIDQxUUNCmOKzSlzfRziO02KBJYV2ROl7Gx4DI0DTXMrkySuIfG3l
 ZbF2J5HoTHXn5f29TdIc7qSn1G8KmP+BpygZcvd3CAcRrAWpVpKtn3fP2Hv4n4McnuPXbA8GJRS
 ZDvL9IMkpQf2IR6XYyVwfUK0mMs4NGnLwJ9AKK36CMckTy8CDrDICy5fJ3TWbDc+TKx+IJ4MIc1
 Sj0+Tlp8eTVBjvPz2YYRtiQP841aSw=
X-Received: by 2002:a17:907:3d4e:b0:c29:f5d8:9c73 with SMTP id
 a640c23a62f3a-c31aa088b5cmr522306766b.34.1791637930088; 
 Sat, 10 Oct 2026 06:12:10 -0700 (PDT)
Received: from alchark-surface.localdomain ([185.209.196.154])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c31a9a71d42sm240051766b.32.2026.10.10.06.12.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2026 06:12:09 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Sat, 10 Oct 2026 17:11:40 +0400
Subject: [PATCH v3 3/7] test: lib: Check the GPT layout for large sector sizes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261010-gpt-4k-v3-3-89fd290f85cb@flipper.net>
References: <20261010-gpt-4k-v3-0-89fd290f85cb@flipper.net>
In-Reply-To: <20261010-gpt-4k-v3-0-89fd290f85cb@flipper.net>
To: u-boot@lists.u-boot-project.org, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Alexey Charkov <alchark@flipper.net>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Denis Mukhin <dmukhin@ford.com>, Simon Glass <sjg@chromium.org>, 
 Paul Burton <paulburton@kernel.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Andre Przywara <andre.przywara@arm.com>, Quentin Schulz <u-boot@0leil.net>, 
 Kever Yang <kever.yang@rock-chips.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5884; i=alchark@flipper.net;
 h=from:subject:message-id; bh=ZZblP5lKDL+vB6stTPVfqB/EW/xOFjxC+plkL2u6GbA=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWSdslz42pXFfIr4FMGnf1aWPkx3+2hSIGu/pj2we/Mrz
 8mbpswu7ZjIwiDGxWAppsgy99sS26lGfLN2eXh8hZnDygQyRFqkgQEIWBj4chPzSo10jPRMtQ31
 DI10jHWMGLg4BWCqxV8wMkwMlQvVm6c1rX5/9erpus794tEh/vN17X4+z7BcIOSSoMvwP/9hbdf
 egFzjtlX/jn6bkWPQvPex4g29OIv1C+rZ7ZvqGAE=
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
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

Put it in the lib suite rather than alongside the other partition tests in
test/dm/part.c. UT_DM depends on SANDBOX and test/dm/part.c is built for
sandbox only, while test/lib/ is compiled for every board that enables
CONFIG_UNIT_TEST, so the lib suite can also cover big-endian targets.

Without the preceding fixes this fails on the first block size other than
512:

  test/lib/part_efi.c:78, lib_test_gpt_blksz():
      entry_lba + pte_blks == first_lba: Expected 0x12 (18), got 0x22 (34)

Reviewed-by: Simon Glass <sjg@chromium.org>
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 test/lib/Makefile   |   1 +
 test/lib/part_efi.c | 113 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 114 insertions(+)

diff --git a/test/lib/Makefile b/test/lib/Makefile
index f25383a40e58..ed26afcc8a11 100644
--- a/test/lib/Makefile
+++ b/test/lib/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_LMB) += lmb.o
 obj-$(CONFIG_HAVE_SETJMP) += longjmp.o
 obj-$(CONFIG_SANDBOX) += membuf.o
 obj-$(CONFIG_HAVE_INITJMP) += initjmp.o
+obj-$(CONFIG_EFI_PARTITION) += part_efi.o
 obj-$(CONFIG_CONSOLE_RECORD) += test_print.o
 obj-$(CONFIG_SSCANF) += sscanf.o
 obj-$(CONFIG_$(PHASE_)STRTO) += str.o
diff --git a/test/lib/part_efi.c b/test/lib/part_efi.c
new file mode 100644
index 000000000000..75de002278f3
--- /dev/null
+++ b/test/lib/part_efi.c
@@ -0,0 +1,113 @@
+// SPDX-License-Identifier: GPL-2.0+
+// SPDX-FileCopyrightText: 2026 Flipper FZCO
+/*
+ * Tests for the GPT layout helpers in disk/part_efi.c
+ */
+
+#include <malloc.h>
+#include <memalign.h>
+#include <part.h>
+#include <part_efi.h>
+#include <asm/byteorder.h>
+#include <test/lib.h>
+#include <test/test.h>
+#include <test/ut.h>
+
+/*
+ * Check that the GPT layout adapts to the block size of the device. Neither
+ * gpt_fill_header() nor gpt_fill_pte() does any block I/O, so a synthetic
+ * descriptor is enough here, and no block device is needed. The only outside
+ * dependency is partition_entries_offset(), which reads the device tree
+ * '/config' node, and that is available without scanning for devices.
+ */
+static int lib_test_gpt_blksz(struct unit_test_state *uts)
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
+LIB_TEST(lib_test_gpt_blksz, 0);

-- 
2.55.0

