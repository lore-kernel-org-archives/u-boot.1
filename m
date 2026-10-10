Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62BB7CA9EC3
	for <u-boot@archiver.kernel.org>; Sat, 10 Oct 2026 13:12:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A554760905;
	Sat, 10 Oct 2026 13:12:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tqeBuhL-gpEf; Sat, 10 Oct 2026 13:12:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A725060658
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791637940;
	b=ZGR7Js/PX4VOszcJmo1kWw0jIRELEi/L+JUTeppNCcKCO8BQbueDDoN8pI5xGzHQtrgW
	 Gg3n2yd3fPsS5Q2EORlvbU/Z/Ihd738Vc3AMLUF0h0N+Nq/cknwv5Ixl2HxSewBRmrLy4
	 RzbJFOnTYJ8uC1jtNGtArn09OO34d++UJ4yMyZOE00uBYJE0EdXZhogqKImAPJGzkk5qp
	 x68P37SyWIJCbv5Se6BodJiaMao4iuHtRSvlxbvWJw5fIepyvtpqvHhOPM7TGX8QBvV9i
	 97JY/8Yj7UxcHOL5ZPtS0Bz6G8TiynyCjXCmYk8yy6E/BNxys9tYNJ+Hinvtrx4ItQw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791637940;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=aG90lILIrrCKAuJ9/+0db0c3/ngX94oN/E4yzr8dmE8=;
	b=QsG7rbCdFaiYb01K6lVCs0eQPQStqUypvzUc/EpKQF8vGd4WJm3MmnRfz6DsqzzP5iey
	 w6LX6MDyUvdSWX1o4so7YVftld0Y/8vHeDX+eFZImP9dUtsDdFIPaWimhCOpb/ArDQDE0
	 5otwy3DU3c4OlWeg7eMnIy07rmGyAbZSrohyKTzyGGGaLdK78LsHQfXvgQJbnurPLo55i
	 8NmCmdr+2IJ6V0tI/fR3szFa6L0ZCGVC3dbiLnKUTBpXZM5V1XwXzYuDCZottSKYKkqcj
	 4RMPp9BK171TZR/AGLhinjktv2/piwSXZJqijURRQ+NZQG2RLrw4LP1PDAYJhPHUbKg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791637940;
	bh=aG90lILIrrCKAuJ9/+0db0c3/ngX94oN/E4yzr8dmE8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ALimyHu/KSfobVy6Vv6OyGN6JjhkO6fiLLi4nB4exTFVBUuTrRwQ04Cp9eVfbo9c8
	 oc6boT0VUN/SP9zLBhg2kMU8itg8xywh78Xzns4qXwld0lalHJWv0AvnS7Cj6uBmIu
	 u5KQN9pIvLqdpgdChH659pzioKNRbH2trsr5T6TxQU+gkUO3UyYxNIrE16YOG+LOzN
	 ocChM4mqVpE40jlcnQthptJIDKCFLKiFwhQhCfsE97beps4MZlIVTaMEJApQIt8Ugu
	 I8JLM80c0wiJHyMaavhA3YLK9TQ7NJ7pazD6mbN8S12UFWR83dOT0lIzPvdkFVF/P9
	 1sPW0W31M+z+A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A725060658;
	Sat, 10 Oct 2026 13:12:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id AAE7F156
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 13:12:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A888B4080E
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 13:12:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k14kYKGZrgYd for <u-boot@lists.u-boot-project.org>;
 Sat, 10 Oct 2026 13:12:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 76DEF40809
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::62c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791637934;
 b=djPdSWX4yI/4+wT3R9OQ5wNyBOP8pdABVDQH3oTfF+DXvjLDswW7P53hp4FEz+56yiv0
 7aEvZnaAOQ6B3x/q71a0xdqg06x2qI2uNDcaLtk3XlBRvn8TEbvulDW9l147gaSL461Oe
 sXc4TTgyjzT79b35Srt/dKUpMROhCxiAH5lMOWd4mzUj7qUgd5ejz3EHhxAZRIo2dkQGV
 kpYnRg79vHo42fcsXtW398+msgWffBeDhCcUICbGSbEhZ2yENyehHw5aYr8JQ+aTPq5F+
 DXL/QR334YGrEl5KoxsmLCB0B7r4HvKiMdzQYD/BWSsBzancI3NmnmwOeW7t8iZLK7w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791637934;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=aG90lILIrrCKAuJ9/+0db0c3/ngX94oN/E4yzr8dmE8=;
 b=EgBB4a3eatc0+rrVTTgUb7hpQHLeldfRncU5rrMYPUSCE8Khk0KbH1dLcGDkVh9ZPZ47
 Xlgow5MEzKGON1H/C1xiSqYPOvm3ixvwk5xl1jvYAhk5R50nYEoKlXBRn16UEAVcUuon7
 TdBU+RSGHvBfLn+MZcupRRvAAvdB+ooCYCdvTJLAnFtv+yTPqFGuRqk2Gmcb9xEBJw2aA
 VSBIDqVwhOGXVWbseuJjIJVwPktlaqOEfTlHqi0SsYqr5qCKkytXoFt5RDQPw8TzbSM0m
 vFz/3+A7yNdIAi4PadN/lKHh6vLLXHsGw1mrCQ0zT+vWnE7L3FvUeGznYzCG7Uby7lQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=flipper.net;
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b="JUzrjj/X"; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::62c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62c; helo=mail-ej1-x62c.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net
 header.a=rsa-sha256 header.s=google header.b=JUzrjj/X
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 76DEF40809
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 13:12:13 +0000 (UTC)
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-c29c6a3930bso80602466b.3
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 06:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1791637932; x=1792242732;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aG90lILIrrCKAuJ9/+0db0c3/ngX94oN/E4yzr8dmE8=;
 b=JUzrjj/XUXBNTOmX1o/bTrAYVcMwVjrFR7Xd1spUTRBfnsFb7YuVUSTypyfh0WKPqu
 Vvs5Qd5MnYAPtXJBEz9b7RN7KMNgpTn5SSvsAtVSICZR5EZC8XqFVCRaZFfeV2UeQ3EN
 Nm/sWeelG+reE6ni4jh/OQhH+SmdIQP0lpFz2sDKWp8USlIEXbPewkk53uhaNxHj3dxG
 bWyzlrptI4GjEKVmahYg1MtkndzKyHuF6v8Bd78yOpBR7ECuM6xDGOSj2MEBwTo3Oe8Y
 HylLSfHupSo9KlrNuZZApRHrvXPAVzcnHaGxaJqspMMhr12NdNAaiwOYKvIM2FjgQXhP
 iuiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791637932; x=1792242732;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aG90lILIrrCKAuJ9/+0db0c3/ngX94oN/E4yzr8dmE8=;
 b=zxRddzwAHUQwBBpmnJDhKxcRvNSGoRoAgfggHQNROoO2V7r/9rq7b9DkUyONcB6txa
 hrDs1Tpwf9EG5CyRT2gy3rY7CDmcICYGLhrZLPzWDacAijR7ziXeLnuDMFrQAVXksKxM
 QVTTXFxa269Vf1v6P9LIRsLZW8pKNdyJVZxEWbrm9j/vtNvUeQr8zNdU5g82t8GtlNat
 D7YCvvo6NYP7h8KyV3dtwy/ZcgVlt8bdTxpwPb8sWcwKbEPLSYRcE0GnOtnB4i9PG+JX
 Z5dqIzCPtu2eNrA5mskBmyBTByP+thfyWKFphq2alXXOoJ09SwGMPH4C+0vb+3U+xAfv
 KAog==
X-Gm-Message-State: AFq9FYLA1Y+ruKSm4mCzVgc2rnhXJsko7uoTQY95vGuQoROF2Cn7RVbW
 SRSTYVZo5YS8BttrM3OFScSxZHbTbhDAyluHzbpASeMfIeovPkdQV+Qk5I0DrB40fJ0=
X-Gm-Gg: AYBFou2p/St1XRXqoZgSy3b7FIlEPrYryDDBrEw23aQNktzUQmuziNRfSdZu0ruv8t/
 aAbhodkKmG44LNi1a4cSC2iRfbfjYbTTB7lx90GC7BhpbLYUTOLr24A7GCWbHuyN7jHoEs581dl
 ghLhpJ2FygniAr33tQevEkDx1PPX+VesG13GIEGLjXU1nBgrfiDTPk6WgGgvoxCx5mqIjaKOyhV
 BVzFWvR9pmbhN2TVaPfqn7QBvNkZkhhXRr0ymi96cQZUpcGJmGf5Gu9Cx+/qlj0LusaxMMOPw+s
 l90hYpRwdQ9aK9wNYRyUhvVMwAAruOPQxKi8+dIlTTprQUxuhNIJw5n09HG/r3LgZ37rVL/RUMJ
 3yBQ9H25LsMTun/AAhRMP9ozgl5H0a0to/z1yEoyDmV7UP/EDhGqHvgfWzMa3a7LhnW7/5bA8iU
 v3p8gsrfjsyP4riiXNU4GYqYtRESzXR8De9rb+PzVZ3N6vPaqQKupDlhFo6NqkQ5/jHiQlyxYJU
 5EKbUsHkn/JYmigArn0
X-Received: by 2002:a17:907:3f1f:b0:c29:3a1b:ec8e with SMTP id
 a640c23a62f3a-c31a9a04dfcmr488540366b.3.1791637931915; 
 Sat, 10 Oct 2026 06:12:11 -0700 (PDT)
Received: from alchark-surface.localdomain ([185.209.196.154])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c31a9a71d42sm240051766b.32.2026.10.10.06.12.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2026 06:12:11 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Sat, 10 Oct 2026 17:11:41 +0400
Subject: [PATCH v3 4/7] test: lib: Check the GPT round trip against a real
 block device
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261010-gpt-4k-v3-4-89fd290f85cb@flipper.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7587; i=alchark@flipper.net;
 h=from:subject:message-id; bh=VzeNFcuhvZca05FiAfV6PyYtCmOXFS84e+LJfJOHoQM=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWSdslz4304mbb6I9t6UHRMZ/Jp+B+fppFR/ebbuXM3tm
 ZytHubbOyayMIhxMViKKbLM/bbEdqoR36xdHh5fYeawMoEMkRZpYAACFga+3MS8UiMdIz1TbUM9
 QyMdYx0jBi5OAZjqDdGMDNfm3Awsvhsf5G3r9cRnjtfzoI+ntphwXHQ/H270xmn+58sM/2z/bmx
 kTZ0Wx574btKJaQ6bnlakbGd4dtdjySMlNsO/39gB
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

lib_test_gpt_blksz() drives gpt_fill_header() and gpt_fill_pte() with a
synthetic struct blk_desc. That is what lets it sweep block sizes no real
device here can provide, but it also means it cannot reach anything that
touches the medium, so the protective MBR, the header CRCs and every
conversion behind them go unchecked.

Add a companion test that backs a blkmap device with plain memory, writes
a table with gpt_restore(), reads it back with gpt_verify_partitions()
and parses it with part_get_info(), then checks that the backup header
really did land in the last block. That covers set_protective_mbr(),
is_pmbr_valid(), gpt_verify_headers(), is_gpt_valid() and
part_get_info_efi().

The two tests are complementary rather than alternatives: gpt_blksz
covers the block size arithmetic across sizes a device cannot easily
offer, gpt_blkmap covers the read and write paths a synthetic descriptor
cannot reach. Neither replaces the sandbox tests in
test/py/tests/test_gpt.py, which exercise the gpt command against images
built by sgdisk.

A blkmap needs no host filesystem, so unlike 'host bind' this runs on
QEMU and on real hardware, which is what makes big-endian coverage
possible. Every blkmap is DEFAULT_BLKSZ today, so the block size stays a
parameter of the case table with a single entry, ready for a second one
should blkmap ever learn to be created with a block size.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 test/lib/part_efi.c | 170 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 170 insertions(+)

diff --git a/test/lib/part_efi.c b/test/lib/part_efi.c
index 75de002278f3..82153fdabfdc 100644
--- a/test/lib/part_efi.c
+++ b/test/lib/part_efi.c
@@ -4,6 +4,9 @@
  * Tests for the GPT layout helpers in disk/part_efi.c
  */
 
+#include <blk.h>
+#include <blkmap.h>
+#include <dm.h>
 #include <malloc.h>
 #include <memalign.h>
 #include <part.h>
@@ -111,3 +114,170 @@ static int lib_test_gpt_blksz(struct unit_test_state *uts)
 	return 0;
 }
 LIB_TEST(lib_test_gpt_blksz, 0);
+
+#if CONFIG_IS_ENABLED(BLKMAP)
+
+#define GPT_TEST_LABEL	"gpttest"
+
+/**
+ * gpt_blkmap_check() - write a GPT to a blkmap device and read it back
+ *
+ * @uts:	test state
+ * @dev:	blkmap device with nothing mapped yet
+ * @blksz:	block size the device has to report
+ * @lba:	size of the device in blocks
+ * @buf:	memory to back the device with, @lba blocks of @blksz
+ * @gpt_head:	buffer for one GPT header, padded to @blksz
+ * Return: 0 if OK, other value on error
+ */
+static int gpt_blkmap_check(struct unit_test_state *uts, struct udevice *dev,
+			    unsigned long blksz, lbaint_t lba, void *buf,
+			    gpt_header *gpt_head)
+{
+	char str_disk_guid[UUID_STR_LEN + 1] =
+		"8d60b397-1bb6-4d33-80ee-b1587d24c2f8";
+	struct disk_partition parts[2], info;
+	struct blk_desc *desc;
+	struct udevice *blk;
+	gpt_entry *gpt_pte;
+	u64 first_lba;
+
+	ut_assertok(blkmap_map_mem(dev, 0, lba, buf));
+	ut_assertok(blk_get_from_parent(dev, &blk));
+	desc = dev_get_uclass_plat(blk);
+
+	ut_asserteq(blksz, desc->blksz);
+	ut_asserteq_64(lba, desc->lba);
+
+	/* two partitions of a fixed size, neither with a start */
+	memset(parts, '\0', sizeof(parts));
+	strcpy((char *)parts[0].name, "first");
+	strcpy((char *)parts[1].name, "second");
+	parts[0].size = 0x100;
+	parts[1].size = 0x100;
+	disk_partition_set_uuid(&parts[0],
+				"a2a0d0eb-e5b9-3344-87c0-68b6b72699c7");
+	disk_partition_set_uuid(&parts[1],
+				"a2a0d0eb-e5b9-3344-87c0-68b6b72699c8");
+
+	ut_assertok(gpt_restore(desc, str_disk_guid, parts, 2));
+
+	/*
+	 * Read the table back and compare it against the layout it was asked
+	 * for. This walks gpt_verify_headers() and is_gpt_valid() on the way,
+	 * so it covers the header fields those two convert.
+	 */
+	gpt_pte = NULL;
+	ut_assertok(gpt_verify_partitions(desc, parts, 2, gpt_head, &gpt_pte));
+	free(gpt_pte);
+
+	/*
+	 * And parse it the way every other user of a disk does. Clear the
+	 * existing partition type to force part_init() to guess it anew,
+	 * otherwise whatever stale state remains sticks across the part_init()
+	 * call
+	 */
+	desc->part_type = PART_TYPE_UNKNOWN;
+	part_init(desc);
+	ut_asserteq(PART_TYPE_EFI, desc->part_type);
+
+	/*
+	 * gpt_verify_partitions() skips the start of a partition that was not
+	 * given one, and reads names through a different helper than
+	 * part_get_info() does, so check both here
+	 */
+	first_lba = le64_to_cpu(gpt_head->first_usable_lba);
+	ut_assertok(part_get_info(desc, 1, &info));
+	ut_asserteq_str((char *)parts[0].name, (char *)info.name);
+	ut_asserteq_64(first_lba, info.start);
+	ut_asserteq_64(parts[0].size, info.size);
+	ut_assertok(part_get_info(desc, 2, &info));
+	ut_asserteq_str((char *)parts[1].name, (char *)info.name);
+	ut_asserteq_64(first_lba + parts[0].size, info.start);
+	ut_asserteq_64(parts[1].size, info.size);
+
+	/* the backup header has to be in the very last block */
+	ut_asserteq(1, blk_dread(desc, lba - 1, 1, gpt_head));
+	ut_asserteq_64(GPT_HEADER_SIGNATURE_UBOOT,
+		       le64_to_cpu(gpt_head->signature));
+	ut_asserteq_64(lba - 1, le64_to_cpu(gpt_head->my_lba));
+	ut_asserteq_64(1, le64_to_cpu(gpt_head->alternate_lba));
+
+	return 0;
+}
+
+/*
+ * Write a GPT to a real block device, then read it back the way the rest of
+ * U-Boot does. gpt_verify_partitions() and part_get_info() both start by
+ * reading blocks, so neither is reachable from lib_test_gpt_blksz(), which has
+ * only a synthetic descriptor. Backing the device with memory through blkmap
+ * keeps this runnable anywhere rather than on sandbox alone.
+ */
+static int lib_test_gpt_blkmap(struct unit_test_state *uts)
+{
+	static const struct {
+		unsigned long blksz;
+		lbaint_t lba;
+	} cases[] = {
+		/*
+		 * Keep the disk small: the backing memory comes out of the
+		 * malloc pool, which is only a few MB on boards like malta.
+		 * Add a 4096-byte case here once blkmap can be created with a
+		 * block size.
+		 */
+		{ 512, 0x400 },
+	};
+
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(cases); i++) {
+		unsigned long blksz = cases[i].blksz;
+		lbaint_t lba = cases[i].lba;
+		gpt_header *gpt_head;
+		struct udevice *dev;
+		int ret, err;
+		void *buf;
+
+		/*
+		 * blkmap devices are fixed at DEFAULT_BLKSZ, so this is the
+		 * only size that can be asked for today
+		 */
+		ut_asserteq(DEFAULT_BLKSZ, blksz);
+
+		/*
+		 * Start from a dirty disk rather than a blank one, since
+		 * gpt_restore() has to write everything that is read back
+		 */
+		buf = memalign(ARCH_DMA_MINALIGN, lba * blksz);
+		ut_assertnonnull(buf);
+		memset(buf, 0xa5, lba * blksz);
+
+		gpt_head = malloc_cache_aligned(roundup(sizeof(gpt_header),
+							blksz));
+		ret = gpt_head ? blkmap_create(GPT_TEST_LABEL, &dev) : -ENOMEM;
+		if (ret) {
+			free(gpt_head);
+			free(buf);
+			ut_assertok(ret);
+		}
+
+		/*
+		 * A failed check returns early, so clean up here rather than
+		 * in the helper. The device lives under the real dm_root, and
+		 * one left bound would fail every later run in blkmap_create()
+		 * with -EBUSY, hiding whatever went wrong first.
+		 */
+		ret = gpt_blkmap_check(uts, dev, blksz, lba, buf, gpt_head);
+		err = blkmap_destroy(dev);
+		free(gpt_head);
+		free(buf);
+		if (ret)
+			return ret;
+		ut_assertok(err);
+	}
+
+	return 0;
+}
+LIB_TEST(lib_test_gpt_blkmap, 0);
+
+#endif /* BLKMAP */

-- 
2.55.0

