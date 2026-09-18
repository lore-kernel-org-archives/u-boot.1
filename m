Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9719EC982DA
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 12:14:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0D5FF40BA4;
	Fri, 18 Sep 2026 12:14:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T6JSTn6zu41J; Fri, 18 Sep 2026 12:14:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org F0B9C40AF8
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789733657;
	b=dZpfwRgiAa5n4TOlsFHVGXYBHehRW3LrWR2Roo/B2F2dr7IHEL7dEp9szxXtU2dxTy78
	 6jU6x6OlDCYPdVogn6RFYPEpRRlyqNtTbVpzoNOy4/4fKrXrAaEpkEH4qchynXA2AgDvi
	 Fs16n1dejJ+2ZSww8FMi8tLCPihT7QohU9Is7aDCxvnH55+jjAxxlOsugQp2ZdyiUp/3l
	 JmC+x5gppdh5VUFAF+bUsSg6EjbLgF5phByyhnlXCnaZvhX94uYp2NH2C8MZhhKQopNpa
	 B0QQg31dZTuLirU32S64fL0fX68XuU1XPFj19mDmcs1qKEa9YIcybFcC8+iKpt+mHQQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789733657;
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
	b=FAsxS/QF5g1K/KPtu82zEqlM3s8ImCmlvrCdjdlS7qmUo+t6M86xU1q2Apk/tgENN6oX
	 i/RaPrwpxcviDDG/4M8KuMVjU5TclPmBWBgLgkfWt1VO2JlqeGCsyysWb7mVaH/9P95JM
	 x+1GzqFfrmUl3B6hmR0GzNV5iABWEeZdFr0Lcq3g0vPv4eC+eUF8EF2hU1d14AG/XLKNN
	 oAu7xyNDfAD4JMd4JEj/pCcqieehMr7n87YbxPnJLGWenLqVLcD1GvLimEOe7OGDZWVD9
	 fu+Cs63m2z9XYtI3+BQtq3TqChKs2kQ4REppBimTBi6wWEbzJuD34wIPQ1y1w0JbGiw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789733657;
	bh=N2MfyzrPQoVWgePR5emSu7LkdCgZ4zvzIbMXyijj8oc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yt1i9D8Dj5EH0RbA/psP6tNDM03Xo3Qg8PbgBScMsZSZ2AUxSTbdwphjFyTQ68GYL
	 ghlxqp1Bp7qARhMVb0SRmqS2f51hZUtndmtmfoNnGFYMnFRcGDhSl3fhqa0Q/cM2eM
	 4WERpkmbEsARfOc4gY/y88Fh1nAO6xiOommExfU/zOAXy9Ry0gXkvnHW85kak1m4dF
	 LCXJ+N7Hvr6d3oAFC7cwkXa5jmlMr7M1XcQg24+DdEfQeh4c3uD5ZpzMnDXV7K6lG3
	 nfpgrP8klVsTDyVl0lx1ESiMhePvXWQWf9Yc1B+1MFc+K6EV77jjJYNIB+F2lnIQwr
	 lNzYxewhWW2gg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id F0B9C40AF8;
	Fri, 18 Sep 2026 12:14:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 108B242D
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 12:14:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EB8F560D67
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 12:14:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1rw3GF4jC3fN for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 12:14:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org D2BD960B9B
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789733655;
 b=P0kifXuL32PWz93CHijK6MP30ow97bggDCHCcFtsofjZmgTW0JsEpqiGPQjqbrSYkzp5
 REY1t9S66R4qOctvfmrc8GZOZw0nSbVi67R4nAm3Eb0gNrDro9zOEu2USI4Lqo61qfPey
 1mUcErkpb2U30pU1noeUGjpYiD/74zAfKjuWGrwnvIP8uh1JDt1eUnuyNHt2jAtAnqkzG
 pyFjfcgsEW8oRUq5jtZ0Pbu/0imYumykAeKnNr8ksItThuRO33Qer86F2M0dR2Gbg3y4B
 nzF9gkn623fGiJo9BIFntYC4oExJ/EMs3gtEyCnP0W1cimZt0ZHhs0FAMkIoSLrUrjQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789733655;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=N2MfyzrPQoVWgePR5emSu7LkdCgZ4zvzIbMXyijj8oc=;
 b=hNSDgYnTIZ5C+uAg/ZrVcnaiNKnbxJQZgkBVC/3VTiWi7LVkffK77LPuPfHHzRWtNWwA
 NmNPh7Teb2p1NFYHmf5ZGSK+lq10Mwnaqteh3uCMoEsMmBBh6mVW3pD9rOUtHlvEe1AhM
 7EbEtDkvRkI351/vl8so8ZZGBK1j9QmgsYgenxdjRHG6r9PxN/aEzXpLqbrmsXXu3ox7r
 VCoe98lhQlzDlGAzdQTAIBX2xKvf62rGYvnpSytM/n0ebG9N7gISA85YJW9LAy3xJEW3T
 B66gcfEolAmXbLCacf3Fzi8PJ05feRkX2/6eqW6AacnJnXEZ5O4FvSDs6hLJwd9EMNA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=flipper.net; 
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=WA+wHNDJ; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net
 header.a=rsa-sha256 header.s=google header.b=WA+wHNDJ
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D2BD960B9B
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 12:14:14 +0000 (UTC)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49b912d8239so5035595e9.0
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 05:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1789733652; x=1790338452;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=N2MfyzrPQoVWgePR5emSu7LkdCgZ4zvzIbMXyijj8oc=;
 b=WA+wHNDJ8QpICIYgEC5K8U2ox+3oSnGxpACEKhI++1t/fGrk4LvzGzBYHu7D9QRDKu
 rELOA++/lhbDVFOVSxtxcB/FYleYD9Wj5h/22BOSsccfCwoaCWhm4GNamHOeIXf8p0L6
 2toHSlAiVBe2PNX3YRImV5JC+L7gxAGa28uqo3DIRCLT/EB4dKbP0WlezRKrk/Pa3RL8
 sRz7rejxhacDt91cyB9OJrLTNA4suSS7ZvHJGhpG+Q2KMuY+v4KSqahniSDVF8Mbal/T
 Re9IoTpTiOc/VNqBrQQdfT6dOkbD1IN7v4isSil/alCX1plREO3RmYadmmtQu6NZSD1w
 OzVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789733652; x=1790338452;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=N2MfyzrPQoVWgePR5emSu7LkdCgZ4zvzIbMXyijj8oc=;
 b=N4a8JHOijbv6xNTi2rYFbopohWxNU4JVAtQ3hHnTo8GrP3Hf9uXR5D8cOZ6q1NFG1W
 C2bs600JFEqCWSq0lsVcpfwmD+QA1JhaX5ux2cIhum84oAqTwelR6vFYv2J/agJeUc5R
 h7mh96IgqxLdebSDAkvdTPYVaqrmBj3hB3zCHRYS7hmsi8xIDuptsMnZF31ybpd9O0rp
 JXP/GSvwKozmjqjFEMMfrdZQ7/xLoO9J6+C+SvNqYkw/MJRImPViGBKcCVvWzqXGkl6D
 LXmfLlbgh7sKqWe/EUvAZoBShYGsETuX7NZTDH67n/Kwy0EG3dME9ukaB6heSi5IauCH
 ipWw==
X-Gm-Message-State: AFuF++lnHUL64QBdZWj7RrnPAnQpeW/zp9prJ2bZTfJNbUPdiTYdwXct
 clmI/5PQuFXrGyjieSAQPHUSeRDSGwfo0lw/ohgRW8ws/rYuTpGpiuvRSe4biEiZkCSDxogU1oc
 Zy39Z
X-Gm-Gg: AYBFou0fgd1LkzrEe7mXrjLARTDFKXTNaTo9CAXxNctKr6aklQlOuyGc4fUUeUyaswf
 qjopbEr+mYGVzyrcGLI4B6b5FFeFoNEteVoEZywZaniRZhAyRyfKzRS6JtB9jpWO5FciZt/74hL
 5zUFWzovVKtluvm7VCBnSLiQge8/arG14CTPbmhe0clrxb0bRgRxVpkWlRmRN7FpKNwuSx8rG8k
 egeATq+HUsb/h1aeZOu85+w3xKAmEgo1iyBaeI20k67N+tWuxLnr1G/qn2SaDBokACPGil1Newf
 dFbeUpLChal2ELPTP1P0VFiH3iL/6Bc4ez254i8Th0AibcDnTsNC8GvJ15dPl721n0gdVdMD2WE
 nohlaXHLsqqo51PzAAa1ahvKKiwe5KXfn4Na7IRccdZ59GndbwUfM1vIjWsZBgRdpcsIivckTsy
 Y0udx9gQJzUf1U2wxhqxIiCsUql+ge9mmhuoLz2DmBa2iDH6ZtH3oZq32O9T1yHE8FhPc2LKfKQ
 7qyMf7LyVJz9rj9s5grOqqc9C5+Ota3ynRcDqzEbYmWW7dW0Ow=
X-Received: by 2002:a05:600c:4e16:b0:49e:8377:c880 with SMTP id
 5b1f17b1804b1-49fc574a641mr26378295e9.33.1789733652395; 
 Fri, 18 Sep 2026 05:14:12 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-2-51-220-108.alshamil.net.ae.
 [2.51.220.108]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fc59286b6sm42755035e9.4.2026.09.18.05.14.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 05:14:12 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 18 Sep 2026 16:13:52 +0400
Subject: [PATCH v2 3/7] test: lib: Check the GPT layout for large sector sizes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-gpt-4k-v2-3-daefa4792e9f@flipper.net>
References: <20260918-gpt-4k-v2-0-daefa4792e9f@flipper.net>
In-Reply-To: <20260918-gpt-4k-v2-0-daefa4792e9f@flipper.net>
To: u-boot@lists.u-boot-project.org, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Alexey Charkov <alchark@flipper.net>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Denis Mukhin <dmukhin@ford.com>, Simon Glass <sjg@chromium.org>, 
 Paul Burton <paulburton@kernel.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5884; i=alchark@flipper.net;
 h=from:subject:message-id; bh=ZZblP5lKDL+vB6stTPVfqB/EW/xOFjxC+plkL2u6GbA=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWSt1eZblvVEZL9Xfllt0a4qt2u9Gxk+l/y/VL3beLZGi
 WPJPHaOjoksDGJcDJZiiixzvy2xnWrEN2uXh8dXmDmsTCBDpEUaGICAhYEvNzGv1EjHSM9U21DP
 0EjHWMeIgYtTAKY63ILhv5P9livrai51Lsw1zr6RkxL475TT7vbkVs8lwuErPlhZ5TMy9EhH9EV
 3OFZ0nI/a6CXh1Ji/zqZlXsW+9ebxXgfezwjlBAA=
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

