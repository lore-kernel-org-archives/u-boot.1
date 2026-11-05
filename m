Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF275606A31B
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 23:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=t33hHMSj;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=lgQej/VX
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 88947811E4;
	Thu,  5 Nov 2026 23:46:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QpF8Fu4esn-X; Thu,  5 Nov 2026 23:46:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9D88A811F1
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793922398;
	b=PZLXYHQMskz7N1BdD6ePWT3UoBJqp9j6MvyUOOBRxu4qRX3PGZRS3ZqLk16VjGIukovc
	 JsdMGj/wtBLtCYR4/KS7eNZqfNIO6peFaDAd50SuQk5lH6Yzb9GBbVFSpWoY2na30aSPa
	 RmYKirSob1hDEs1qM7c4fV2IPUlhQAh5cSxaPDSjGh6kwGjDOOMmEX5z+jDAGc6UTAX3Q
	 yhDngCe3tsWhyNU0rGQyc6Iew1fOiXws6CFaxmfYnQh7HlZD94SuDBWtL/ETDT3vrblMY
	 a0Kqgudzu2z6C9qiUdgpBPCIMjmRO26+C32edTEoXQGfSUn4bhZQPdTB1Guj0lq7LTQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793922398;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=p2vcQoxRWjpy1rUqpU61ZrPwSMPtS7tzYVKBVzRqsOQ=;
	b=BvNFSMg/OdlEcAi0gtEtb2TCwvitJJTz5OEY6AuUu9amuiL7RSLluvIU558G4j+cBu0o
	 SxRkv5dDNzAzJEuf0Zx+iT4yGsO2uXnIrlMtrQ1/W8DrlcziaY9T2+PFHFE18iF/6su//
	 FD+S/hJNyOQOFlVCyoakBx2Ogue7ITg5/zEFpCnvPH+AtfkfXucE8OFsFL/EXVF1lhiqz
	 YqsyVA2WISZcggSIG3+5/RLIEiagLdL1CUbjNKMajk4PGLwAYDxnlZPNAvsye1RbHgANY
	 9cruhmFUjjd1uUoWu21B7OWYECpa20L3I2Ff+Jcg1LQPj9YOvbVuKdb5Ky0aeTnD+4A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793922398;
	bh=p2vcQoxRWjpy1rUqpU61ZrPwSMPtS7tzYVKBVzRqsOQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=t33hHMSjOxdTHiYTl3COLmFNz6vXYvw//Tu5b9Bhi6p0KDRmw0dV9eLQ2NG+DCBpg
	 gV5EtAK/nF2HM36JYc+uo1wzCMJMvIxB8Ixps6LopiGyTco9vZ0ER8upER10dKPAn5
	 tpWLdyO+auNcnXvrQPLitmsgXEXLDwQrpMQAobS7tE/Af5UwOU5Y9WAQnJiWYKKE6+
	 b6nhw2x8gTysfqfSxsFJuPCN43XI/8MTAnq+ij1q6dVnT+sCuGMbzT8IE2+5qEpgo5
	 cYpywxakGXTVlhkZd6FuZ+338+oRXPuWMELLdn9UlaqZosamzsy6JwFak8keHTqgau
	 +88zb5Ks24Iog==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9D88A811F1;
	Thu,  5 Nov 2026 23:46:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id BCC6B49B
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 23:46:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AD59240815
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 23:46:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N83vigM1QKP5 for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 23:46:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 00F624050E
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32d; helo=mail-ot1-x32d.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=lgQej/VX
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 00F624050E
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 23:46:31 +0000 (UTC)
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-8253bc5a613so86686a34.0
 for <u-boot@lists.u-boot-project.org>; Thu, 05 Nov 2026 15:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793922390; x=1794527190;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=p2vcQoxRWjpy1rUqpU61ZrPwSMPtS7tzYVKBVzRqsOQ=;
 b=lgQej/VX3zd2j7TGhIPeGpKvPMrKGgMEZcFfFmU3oQeshxwTXvjdTmfwZaCocucmZW
 E5NjjT/UyNrd2VN7p9Wz5GqY1qMDPCqy5i9Xj1w6zlJ+cFffJ1o3CircHDTq0Rm2hnix
 YfDfPLHdD6qH5pZjW0nrUQs6L4ByNhhVP53XTjMC42o8klo2KWEJtirCyfNwT+RnZ9VX
 8NYLPo9DocN3NjKYc1VX+qFHDYf3PhyoN5wXl1ZfDDv8dzjOFfGk6Q3BhmaIMzitBF3G
 ABs7o/2z4S5HypEpbqP83nYAnMAjxBF8maq//Wa/I9W33pHN8woEyYY+66gi0A2d3E2l
 6nHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793922390; x=1794527190;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=p2vcQoxRWjpy1rUqpU61ZrPwSMPtS7tzYVKBVzRqsOQ=;
 b=MaaFkqfyGMgZerzB3uf580LQBOis3OOkp3DBeLXLxGZHlULXOBjDj3bcKb5ZlEuPOk
 c+R2WXUgmMzueZmwhuQXa1kZ8Gw9B4GsfuY37V7U+tk9/zIVMFrh6DVGee0IFqWWM+uh
 PU9FpMJWwQo+HLw5Rg4dnaU4HvCIAGb0Ime+OZ7B7tk7zn4ooH9HF19l0j6PW8P8QMpT
 S7faWrZOwSItOsafpn4I8jHM9vnT3wtJ8jj4NMXqo7pBCT3boONbDrlbHnuu6MgT1C1+
 lg5N2XUNTiuJebaXehOVh8Wns4VOHormS7N+mzS35W7mGPQ8vqPRH6o4dJL3dVIBjPJK
 GQTg==
X-Gm-Message-State: APuU4Z9/egoERwkq0q7dtNJxDPoB6bOqYBx3YuY2uh7QvUMtPaZyUs5V
 UuK6k+Cph+LahifGe1NeFBPDJCnoKxWHiexXa/MOvV5U2dxdgRQn3JJ7Cz3NA756rYlSPhz6iEl
 /Od9fXUI=
X-Gm-Gg: AYBFou2DiBJZ5ngSfv7zYo+yW8cCjsQab92kz1GTdAE7NfLx00EnbfB54I1K9zWgWpD
 LVVpZH77If6t1jpHd5Nd8WhJd6vFE9WBB1fIzR/QUAhOBCsRo7ZL3+Hr+jBVm+u8aT0bhD7p7wD
 HaQS6G6tJMi1Odgo0UTJSCskglu6hYtiuhdhTGisHFY+pSU8udCILMcyIQch3BHia0oAG6TJudU
 IldibqRJFNLvQ27tlQGaly7xG6xFGLVQVb3S958jR59y5+q0o042sBIqMsM746dDhUz6zz/TAyu
 +cF0SrWyp/WwY+By8WlrD2JTIEo8SwKHhbMYRTjOJUEijR5H63XQ3BQzVc3y51T4BC5ZofWAURs
 EuK6YbrBt2nBovn5/eJfQyD+WvESpeGt8IpqM3/7w4BqWmnVXLQYrJxJrYXLew1LO9tS3LivNa7
 sK27EYOzidtNKZy5QbmS5JHTqNaurmM+Clw5BQ3eeomPhLReCnCeoTxMKf04+xYe7mUOMlcvwDQ
 ZU8lEEMkzrDOKxpkz04zVqwcVdJ0e4D0nREOsfs7nLi/0JrKLK4E623HxsJFOYignuxyz1Ft1Bc
 pS0IuiM0qbLoaVzLCzMe/9E0NQSqxPg4kQ==
X-Received: by 2002:a05:6830:43a7:b0:806:d79a:c932 with SMTP id
 46e09a7af769-85f1d07b04cmr1002290a34.20.1793922390492; 
 Thu, 05 Nov 2026 15:46:30 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7f36:1c5c:8ddb:3ed6])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85f1de4e53dsm592122a34.20.2026.11.05.15.46.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 15:46:29 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 05 Nov 2026 17:45:24 -0600
Subject: [PATCH v2 2/8] spl: add the devicetree of the next phase to the
 bloblist
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-mtk-mt8189-tfa-fdt-v2-2-c168a7b4041c@baylibre.com>
References: <20261105-mtk-mt8189-tfa-fdt-v2-0-c168a7b4041c@baylibre.com>
In-Reply-To: <20261105-mtk-mt8189-tfa-fdt-v2-0-c168a7b4041c@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
 Raymond Mao <raymondmaoca@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>
Cc: u-boot@lists.u-boot-project.org, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Julien Stephan <jstephan@baylibre.com>, Carlo Caione <ccaione@baylibre.com>, 
 Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5402; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=si9Qtu4CEmafH5gfD5IACncRKK+7gIXsIIu1/vwfOAM=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq7RUjCBqSbaOcw70S60Ji/mVHffRbdUJzfqgJb
 CQuYhG5jQuJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCau0VIxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AATkH/jfB6+DgcmcK/FPb/6uta1dvWYFtsH7MqaeERSo
 Qq2Gh4clsBrQ/WxK7aRBFKf0Sqyii4ONHoPjkyquuuFNdkl4u19UB9P5wn3FBSTTKJcHDdwCGTi
 MJItGOPSkEzQ1vQ1gGfLXfxM3hRN0Q5Z9cOdTOCjjESzzJMpq0693jKDwS5eebDvs/lZkaR9Jw/
 ZzDVFTN1Y4PDHNLCkjrOY11Nzlc/mh8Fmfl2b4pOvERebjJVEWybvqw9NtcjmMx02tT8539OpKM
 TbQ67YcGrrl/mxa1N7v2W5cMLHOMaJPy0E2h0/87BrfzXMbMpoiGfJR8/z0pE8W0KmITT9MOXkj
 VF9c=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add SPL_BLOBLIST_FDT to copy the devicetree that SPL loads for the next
phase into the bloblist, unless the bloblist already has one.

The next phase then takes its devicetree from the bloblist and applies
the devicetree overlays in the bloblist to it with the existing code. An
earlier boot stage, e.g. the one that initializes the DRAM, can then pass
an overlay with only what it knows, without having to provide the whole
devicetree of the next phase.

If the bloblist has no room for the devicetree, move it to a bigger
buffer from the SPL heap, so that the earlier boot stage does not have
to know how big the devicetree is. The next phase only finds the moved
bloblist through the registers, so depend on SPL_BLOBLIST_PASS_REGS. If
the devicetree cannot be added, report it and carry on; the next phase
then decides whether it can boot without it.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 common/Kconfig   | 18 ++++++++++++
 common/spl/spl.c | 83 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 101 insertions(+)

diff --git a/common/Kconfig b/common/Kconfig
index 5b728cfe324..c0251c95740 100644
--- a/common/Kconfig
+++ b/common/Kconfig
@@ -1251,6 +1251,24 @@ config SPL_BLOBLIST_PASS_REGS
 	  default jump_to_image() uses them, other implementations need to do
 	  the same.
 
+config SPL_BLOBLIST_FDT
+	bool "Add the devicetree of the next phase to the bloblist"
+	depends on SPL_LOAD_FIT || SPL_LOAD_FIT_FULL
+	depends on SPL_BLOBLIST_PASS_REGS
+	help
+	  Copy the devicetree that SPL loads for the next phase, normally
+	  U-Boot proper, into the bloblist, unless the bloblist already has
+	  one. The next phase then takes its devicetree from the bloblist and
+	  applies any devicetree overlays in the bloblist to it, so an earlier
+	  boot stage only has to pass an overlay with what it knows, e.g. the
+	  DRAM layout.
+
+	  If the bloblist does not have room for the devicetree, plus
+	  SYS_FDT_PAD for applying the overlays, SPL moves it to a bigger
+	  buffer from its malloc() heap and passes the new address to the
+	  next phase in registers. That memory must stay intact until the
+	  next phase has relocated the bloblist.
+
 endif # SPL_BLOBLIST
 
 if TPL_BLOBLIST
diff --git a/common/spl/spl.c b/common/spl/spl.c
index 6d81984428c..7cc6a031b66 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -39,6 +39,7 @@
 #include <dm/device-internal.h>
 #include <dm/uclass-internal.h>
 #include <linux/compiler.h>
+#include <linux/libfdt.h>
 #include <fdt_support.h>
 #include <bootcount.h>
 #include <wdt.h>
@@ -465,6 +466,82 @@ static inline int write_spl_handoff(void) { return 0; }
 
 #endif /* HANDOFF */
 
+#if CONFIG_IS_ENABLED(BLOBLIST_FDT)
+/**
+ * spl_bloblist_grow() - Make sure the bloblist has room for a new blob
+ *
+ * The previous phase may have passed a bloblist with only little free space.
+ * If a blob of the given size does not fit, move the bloblist to a bigger
+ * buffer.
+ *
+ * @size: Size of the blob, without its record header
+ * Return: 0 if OK, -ENOMEM if there is no memory for a bigger bloblist
+ */
+static int spl_bloblist_grow(ulong size)
+{
+	struct bloblist_hdr *hdr = gd->bloblist;
+	ulong align, need;
+	void *buf;
+
+	need = ALIGN(bloblist_get_size(), BLOBLIST_BLOB_ALIGN) +
+	       sizeof(struct bloblist_rec) + ALIGN(size, BLOBLIST_BLOB_ALIGN);
+	if (need <= bloblist_get_total_size())
+		return 0;
+
+	align = max_t(ulong, BLOBLIST_ALIGN, 1UL << hdr->align_log2);
+	buf = memalign(align, need);
+	if (!buf)
+		return -ENOMEM;
+
+	log_debug("Moving bloblist to %p, size %lx\n", buf, need);
+
+	return bloblist_reloc(buf, need);
+}
+
+/**
+ * spl_bloblist_add_fdt() - Add the devicetree of the next phase to the bloblist
+ *
+ * Copy the devicetree that SPL loaded for the next phase into the bloblist,
+ * unless the bloblist already has one. If the bloblist is too small, it is
+ * moved to a bigger buffer first.
+ *
+ * @spl_image: Image that SPL is about to start
+ * Return: 0 if OK, -ENOENT if no devicetree was loaded, -ENOMEM if there is
+ * no memory for a bigger bloblist, -ENOSPC if the bloblist has no room for it
+ */
+static int spl_bloblist_add_fdt(struct spl_image_info *spl_image)
+{
+	void *fdt = spl_image_fdt_addr(spl_image);
+	void *blob;
+	int size, ret;
+
+	if (bloblist_find(BLOBLISTT_CONTROL_FDT, 0))
+		return 0;
+
+	if (!fdt)
+		return -ENOENT;
+
+	size = fdt_totalsize(fdt);
+	/* Leave room for the next phase to apply overlays to it */
+	ret = spl_bloblist_grow(size + CONFIG_SYS_FDT_PAD);
+	if (ret)
+		return ret;
+
+	blob = bloblist_add(BLOBLISTT_CONTROL_FDT, size, 0);
+	if (!blob)
+		return -ENOSPC;
+
+	memcpy(blob, fdt, size);
+
+	return 0;
+}
+#else
+static int spl_bloblist_add_fdt(struct spl_image_info *spl_image)
+{
+	return 0;
+}
+#endif /* BLOBLIST_FDT */
+
 /**
  * get_bootstage_id() - Get the bootstage ID to emit
  *
@@ -851,6 +928,12 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
 			hang();
 		}
 	}
+	if (CONFIG_IS_ENABLED(BLOBLIST_FDT)) {
+		ret = spl_bloblist_add_fdt(&spl_image);
+		if (ret)
+			printf(PHASE_PROMPT
+			       "Failed to add FDT to bloblist (ret=%d)\n", ret);
+	}
 	if (CONFIG_IS_ENABLED(BLOBLIST)) {
 		ret = bloblist_finish();
 		if (ret)

-- 
2.53.0

