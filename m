Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6A50C982DC
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 12:14:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5292240AF8;
	Fri, 18 Sep 2026 12:14:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Kdq6kQYHzlke; Fri, 18 Sep 2026 12:14:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 7525640BB5
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789733660;
	b=BDRHcB1/QPpqT4/kTLuPqKyDzIz+mBNNdAOkM8M4vVE19JXysVAvFd7n3uJim9+/H8Mp
	 ToQmUmTpS6D6BslIuG+AgOzeMHTzCRtzZ4PGOlxb6nYNRPx6zLYeiS8364eW+3oJBo0kl
	 E1bYeeuVDUGNrDeKFt2qM4cwPmcbNS3jkhqLoaKpveXaOSEem/z8xbm/GYVOXc5MHU/ar
	 CEmsOWT8B4Asn/YXYifoLLi+tyJleduyiyDQX1JGD6Qa2V0hIGI4+zQnryuMs6nI7yS2u
	 9+upIGK2DEMSUcsJ8ziewjVNHaii0GL8xImPwuvElo9uUtmyK6+59rkRfJQGscVNO9g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789733660;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Sj/vOJEiQUlRfph3oMfQHpK7ibCPjI/q9rWmdNZLmr4=;
	b=MlgwueP+Gb4pbEneWNvN5TqGyGQ0Y7VWiVKJUa2hVkmAlU7nG+U9sxHyUy9RHCOtVJEN
	 /DPPelnAQHNJr191ODovoPSeFmC/+l2KD8icq2y3YJIP0/jsQW+kBZihfCRIJaUNgXS20
	 90i/URhXBZEof6yrmkK3LuTSGXL+V8WKDMLVnyE5TNKz6fBRw7/SByfdKReqXph6VSh69
	 0Hw7O6lkMM5DOQK9yq+5h0v4L+bKp6UDM1Snzb/bvA0Yl3X3TZTilwXK+XzWR57Pwj3Qg
	 9IaibjvzKpyGF/XZK5AEC2UqHzYuTfHVprbXkTPMf/87s9g1FcDYIE5x4g133g10b/w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789733660;
	bh=Sj/vOJEiQUlRfph3oMfQHpK7ibCPjI/q9rWmdNZLmr4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yw9kvjYs9ZO4tccQcGHD1vuIXXj2K8AwHuWXJpkyNj8miaE8/TGLeIcZQelOXJifb
	 hl4xu49Q68FFIAoEFolVELgErY+qFCe37Qf7sxYTfaW7BbBSsRMgwd298ScGxH0OlZ
	 /gHmpjldeQCiun1midi+SP/18OpYf1WNKsQ6DpP7knrs+n7LXMGmyPzp7kv5E2Twnm
	 CeHOGByNZD9RQZuugP7ysA7968R4JcevoGxkI1IgAu6PjO1/Dv+31oHyfGkyFdYCnv
	 SYKjhjTK56cH7nN+iPGa8azzO+1pPQ9zrMlHzBiKt0g/CJhxRzPAF9YL7rAqi+Jbev
	 xOH/nAMF9PYxw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7525640BB5;
	Fri, 18 Sep 2026 12:14:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id C8E8A13D
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 12:14:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BAB5860D67
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 12:14:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RHunz2gbHmNQ for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 12:14:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org AAD9060B9B
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789733657;
 b=F3JWeUyAFY5qQbVi+sO3NdI3ReYm3yzS+YR8oRo/ClVdkgaTbpDPO3EtsF89GipRXCRP
 u5KmE87d36zH3quQiJOn3RQwc4tqnfZN3fPx6zAIdkwmlB6ShT+Y3yWAOU4WzD4TzpAbN
 uaZJy0Cyp/x5nR6Eafok42nERLzf/t1i4oMn2gZ7yvKg7hf5nqGqZWH988vg4IQEEG2b7
 aI4DmkeR6hArxBvFh0LwhrNXBZfBsLP/uX2K1wqIVxrIpdI1du60Uhj7c99M7h2+wXFzc
 MsQbNdu2U94mXeCMUAns2tcTfp3zIInbNTZeK8LkPN1oU7o36V4+Vj7vuaOf/fQ/k6Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789733657;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=Sj/vOJEiQUlRfph3oMfQHpK7ibCPjI/q9rWmdNZLmr4=;
 b=gOSXBc57cQRxQ2p451On3mV8pwFMCZPNx2TbG17gfcKZHAN3SL11oR0zVQOUMswk1whD
 0W8lBizU9MULRUaFojTgtjs72SB5qVC+nq74b0roUO5Q5oOSHpW0nM8IqWv/gVbIDb2Sk
 3ZGuMJFIxKM5mgTiVwdJ5x60dzSh1dyrIjyN52YEWudmjbbL9BhgYZ1W830cJ56MAEiy0
 6dDX6HIFA4wybgUCiObkdJB+8Y7Jgxixb5m0GWmox54JMTG09HsEsAZr83oZdIaR73k/3
 HeEPiQoVJxFHSf3s/jyBDmzmmvWNvVWQLrPU1CT0Iew1EQMtzMs8T6Er9HAwVVdGZzQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=flipper.net; 
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=S7pELUoJ; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net
 header.a=rsa-sha256 header.s=google header.b=S7pELUoJ
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AAD9060B9B
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 12:14:16 +0000 (UTC)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e721b5503so6739635e9.0
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 05:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1789733654; x=1790338454;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Sj/vOJEiQUlRfph3oMfQHpK7ibCPjI/q9rWmdNZLmr4=;
 b=S7pELUoJcuHDVnqWdb9VodQIldSz3xVyzjhgfyDLhVD4N+yqE6IK1MOlSJyqEZfJOf
 v3mL7Ilurv3ti7th4UU8otgWuT6DqLVeHyppQsa5HUoXciUPpN62Kv/EF44zpy2sCI74
 hzJqCf64/SHK0uozrIJnAwux9dU+JE6B8BFB6T7ErNnOW+Ke0vYNJGK7Pbhj155ZtcOj
 AqVt2ocTXqmjG6z1iaMtK16w3HXwGTf4twWQpBWaGzD5kqsKvNQmQZyvL+Y3ZiEkLMBp
 8CHYsLXbUngw8lJVOKJZ/Kjp1a90mc6N/nGUCEPdDHJ0wLdi7PXq+O5fChNqPXNBHqbF
 IhcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789733654; x=1790338454;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Sj/vOJEiQUlRfph3oMfQHpK7ibCPjI/q9rWmdNZLmr4=;
 b=xoKfVGcW43CHhviesj0vCdGSWpym3W5rMRUYIzTtcXtPiDbza44Bvs9g8OpwTQej16
 hgT/CRPhcCQaU2WKv2/j1D+5UX3wu8K1jYZtKSs0x0vNfJZvppSRfsUvJCLv+TFFSwZo
 PRJf77HaWdBf9ivEBSwmxStCMc6WMIHaioBdnpBw5phKgLNV6fAdD9SIsQ3MH1SAx5WU
 zo5Q2NXj6GEZseW6uMnkxS7Kpllwu7BDN8YBhPwnR3pmo4oq1hoR8qlc3583eBFmxwVr
 lQoPzf3p1nsEvRVE3HncGhwDAZFKkK1uF8Swwk57iYtmNerzQiVOIdXnY+Ky+KNSMddO
 lcMg==
X-Gm-Message-State: AFuF++lnvDkR30NYomxEIBGKu1It8jCMfysB4qPfbF9QRpYqRUFztJwx
 8G/+2HSIJAlwFMKTGJGYXnwbdp4IC4RiHruARF9iojYzwH/lERAistTGtiow0YFVXUWNmMI6CcF
 Yhjqm
X-Gm-Gg: AYBFou0zxi9JcsR1cJAq7geH6MWN9JaIHR5CpTfLtvjUFqomhl0mcvAEuzikx6RmiiY
 /vXvy+/4vPxQ4S8gmytdlUQsGMrh1qVUDbCu2vZKux5w9aT3JDTHz83qH/cxSHWW0SBZdC8MaKQ
 J5SN/+/6oj2ty0gpF2fNooJ0YhdL/qNNtUxFCb3VXAFlSV1HKY2MWrQFXMGk7cKIU3llVVOKlyy
 z8wqzG/7r8qQ9ar3NaMy44I3sDPKk0SegyLeeNagnaqD/bqk4pC/NOEhmfV+Z47FA7ExeGChhRQ
 PUaFNOn1BjO5LLDfNRCU1KZkv6op2HDgkJSojVyDBql8VSDaD6MuI/uAyQcZq5FPazrUz9c4APW
 yDFiQvJDp338gN953W4Oh88tZMruv5wGxTovh4ZWlzjjSyt2agthWAsNun7rvaGvoakZuvSPuOm
 0lkzJG6rZv7drBxxA5A5a6SRau/rq20JHcXt7AFyxTyMM7XGHHZNFvsFycPkaDTeIHbfN3gRwPQ
 EB27wPKfqeD/SFbDBed2KDMTF36NfY+FudQv4eU8Q7p92fpLDc=
X-Received: by 2002:a05:600c:4e86:b0:499:8b13:3a98 with SMTP id
 5b1f17b1804b1-49fc56715d6mr29084755e9.4.1789733654603; 
 Fri, 18 Sep 2026 05:14:14 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-2-51-220-108.alshamil.net.ae.
 [2.51.220.108]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fc59286b6sm42755035e9.4.2026.09.18.05.14.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 05:14:14 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 18 Sep 2026 16:13:53 +0400
Subject: [PATCH v2 4/7] test: lib: Check the GPT round trip against a real
 block device
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-gpt-4k-v2-4-daefa4792e9f@flipper.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6663; i=alchark@flipper.net;
 h=from:subject:message-id; bh=zHOV0Htb0kGs6qSPXgyFvnqX+DAE6gPphtjVQqVSAYM=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWSt1eZ7q9J3vtGxe3ejd98CfZ77F4Vd/zlzBx34Hh0uM
 OFdp9u2joksDGJcDJZiiixzvy2xnWrEN2uXh8dXmDmsTCBDpEUaGICAhYEvNzGv1EjHSM9U21DP
 0EjHWMeIgYtTAKY6eyIjwzSDppC5L55UP9z1ykyK4aOg3W19z970RdoKSm371W/KRTIyfLDNnXO
 Dm2Pi0d0i5vP7lPr+3LGtvdoQ0dX136l9nmwhIwA=
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
 test/lib/part_efi.c | 144 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 144 insertions(+)

diff --git a/test/lib/part_efi.c b/test/lib/part_efi.c
index 75de002278f3..d913ca701825 100644
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
@@ -111,3 +114,144 @@ static int lib_test_gpt_blksz(struct unit_test_state *uts)
 	return 0;
 }
 LIB_TEST(lib_test_gpt_blksz, 0);
+
+#if CONFIG_IS_ENABLED(BLKMAP)
+
+#define GPT_TEST_LABEL	"gpttest"
+
+/**
+ * gpt_blkmap_create() - back a blkmap device with freshly allocated memory
+ *
+ * @uts:	test state
+ * @blksz:	requested block size
+ * @lba:	size of the device in blocks
+ * @bufp:	returns the backing buffer, to be freed by the caller
+ * @devp:	returns the blkmap device
+ * Return: 0 if OK, other value on error
+ */
+static int gpt_blkmap_create(struct unit_test_state *uts, unsigned long blksz,
+			     lbaint_t lba, void **bufp, struct udevice **devp)
+{
+	struct udevice *dev;
+	void *buf;
+
+	/*
+	 * blkmap devices are fixed at DEFAULT_BLKSZ, so this is the only size
+	 * that can be asked for today. Once blkmap can be created with a block
+	 * size, pass it through here and the cases below cover 4096 as well.
+	 */
+	ut_asserteq(DEFAULT_BLKSZ, blksz);
+
+	buf = memalign(ARCH_DMA_MINALIGN, lba * blksz);
+	ut_assertnonnull(buf);
+	memset(buf, '\0', lba * blksz);
+
+	ut_assertok(blkmap_create(GPT_TEST_LABEL, &dev));
+	ut_assertok(blkmap_map_mem(dev, 0, lba, buf));
+
+	*bufp = buf;
+	*devp = dev;
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
+	char str_disk_guid[UUID_STR_LEN + 1] =
+		"8d60b397-1bb6-4d33-80ee-b1587d24c2f8";
+	struct disk_partition parts[2], info;
+	struct udevice *dev, *blk;
+	struct blk_desc *desc;
+	gpt_header *gpt_head;
+	gpt_entry *gpt_pte;
+	void *buf;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(cases); i++) {
+		ut_assertok(gpt_blkmap_create(uts, cases[i].blksz,
+					      cases[i].lba, &buf, &dev));
+		ut_assertok(blk_get_from_parent(dev, &blk));
+		desc = dev_get_uclass_plat(blk);
+
+		ut_asserteq(cases[i].blksz, desc->blksz);
+		ut_asserteq_64(cases[i].lba, desc->lba);
+
+		gpt_head = malloc_cache_aligned(PAD_TO_BLOCKSIZE
+						(sizeof(gpt_header), desc));
+		ut_assertnonnull(gpt_head);
+
+		/* two partitions, the second one running to the end */
+		memset(parts, '\0', sizeof(parts));
+		strcpy((char *)parts[0].name, "first");
+		strcpy((char *)parts[1].name, "second");
+		parts[0].size = 0x100;
+		parts[1].size = 0x100;
+		disk_partition_set_uuid(&parts[0],
+					"a2a0d0eb-e5b9-3344-87c0-68b6b72699c7");
+		disk_partition_set_uuid(&parts[1],
+					"a2a0d0eb-e5b9-3344-87c0-68b6b72699c8");
+
+		ut_assertok(gpt_restore(desc, str_disk_guid, parts, 2));
+
+		/*
+		 * Read the table back and compare it against the layout it was
+		 * asked for. This walks gpt_verify_headers() and is_gpt_valid()
+		 * on the way, so it covers the header fields those two convert.
+		 */
+		gpt_pte = NULL;
+		ut_assertok(gpt_verify_partitions(desc, parts, 2, gpt_head,
+						  &gpt_pte));
+		free(gpt_pte);
+
+		/*
+		 * And parse it the way every other user of a disk does. Clear
+		 * the existing partition type to force part_init() to guess it
+		 * anew, otherwise whatever stale state remains sticks across
+		 * the part_init() call
+		 */
+		desc->part_type = PART_TYPE_UNKNOWN;
+		part_init(desc);
+		ut_asserteq(PART_TYPE_EFI, desc->part_type);
+		ut_assertok(part_get_info(desc, 1, &info));
+		ut_asserteq_64(parts[0].size, info.size);
+		ut_assertok(part_get_info(desc, 2, &info));
+		ut_asserteq_64(parts[1].size, info.size);
+
+		/* the backup header has to be in the very last block */
+		ut_asserteq(1, blk_dread(desc, cases[i].lba - 1, 1, gpt_head));
+		ut_asserteq_64(GPT_HEADER_SIGNATURE_UBOOT,
+			       le64_to_cpu(gpt_head->signature));
+		ut_asserteq_64(cases[i].lba - 1,
+			       le64_to_cpu(gpt_head->my_lba));
+		ut_asserteq_64(1, le64_to_cpu(gpt_head->alternate_lba));
+
+		free(gpt_head);
+		ut_assertok(blkmap_destroy(dev));
+		free(buf);
+	}
+
+	return 0;
+}
+LIB_TEST(lib_test_gpt_blkmap, 0);
+
+#endif /* BLKMAP */

-- 
2.55.0

