Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A638606A32C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 22:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=FLTBDLDs;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=ovtDBZ1r
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6D77140769;
	Mon, 16 Nov 2026 22:34:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6-0nvgJ7fajU; Mon, 16 Nov 2026 22:34:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7164F4070E
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794868442;
	b=kcVjLrSTQ6c9m6odfMaKVDLAhEoPafzNp1pFVRumn0ODJ89u97PCqH8o9ZPjgBOhlG0P
	 KbyGoyVWIZSVRMhZAvhNKq9MnM9nwmCdC8p6CrbwHzaC/qCU/yzO0JBjBxOZBdnheLxsl
	 bccovNwjEvMFNAqMON2nOIDyfVIrdDOJ0A44MyDvpT6hzzT/DVLsMO8hJbTQ+oj+lNjDE
	 drrXbejPSj6sOAefStbKtlw/G970kFTVZr0et/biajPKpc4UpFpJhSYo5VeYmf++5FxOg
	 SGaKZP+AyV5dcJ0xwWkRS0lgrl4HfMYb24/JK7KMD7a0fs/6kcvKCWbh60eoBH+nRyA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794868442;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=AE0NqPk9tD9jHDenbPcgNnfp23hzCv1QvApHi1mN4k0=;
	b=CHDxFf/jMPfwd1xXmQYIDAFqEo81VEkJ2iGqJ3LIDMP8rJVrfoJEUWlR/uBUwEkEO5E/
	 Vm6wW3So4WyFRz3oEo0+0aO0Ct6X9nf5AINICxEigdZ6sek7dbYBktvdPPtZg7A/aZ2sH
	 4FvMgjOWJ/N+mhDuCM6sCWJJu3aeH8fe6ZP2gvply0cChr2qMMA2sgBsvkLEqYKiyJjgL
	 RhEfZgGVm1Q+8XbRFsZTc+kDq4BvawcJ9fECrviDUVx4W1e6kRGFQkQdRy/IBQaPs1RLW
	 IDoHTvVlNorJFc4TiZSLSOAo2xgtcebnsIMVdIY9GfcPJfFaf13jSw7BHpamywzaJug==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794868442;
	bh=AE0NqPk9tD9jHDenbPcgNnfp23hzCv1QvApHi1mN4k0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FLTBDLDsIs1QMwx3WRIYH1C0uxcWdo0TolwZYEprFWWF0CSsJ/MqYrjxbgu9O/w7L
	 z4wutP0AsY2NgWueJqBv6p9vXDf9p/nklI9Gr3T9C865spEqs/CUDOw5e9zyOcGTPp
	 qGyBE0yyGhKLW0Ods2D9agB+lRcu0mcBfYe7cpHZXHbFtPCmmC30fInCxKjsfQ/saG
	 TByftrS6oGJihV1OTbUqUteeDqsPrD3Ixfp8b1opapL4nwFZI/z1Gd44EZ3KoREO0n
	 caJDTimget86++/azo0WaV1V4ETLpsgIT7+RK9x20QpQPoZBlLAFCtrwnAVPvPafll
	 b0LL93Qc0RnQw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7164F4070E;
	Mon, 16 Nov 2026 22:34:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id A83DF49B
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 22:34:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8E8B9606A2
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 22:34:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AIS77sQLdwtj for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 22:33:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 91DFD605D6
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::2f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::2f; helo=mail-oa1-x2f.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=ovtDBZ1r
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 91DFD605D6
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 22:33:59 +0000 (UTC)
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-43bf9548df4so5331818fac.0
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 14:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794868438; x=1795473238;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AE0NqPk9tD9jHDenbPcgNnfp23hzCv1QvApHi1mN4k0=;
 b=ovtDBZ1rOgetoXN/ZpFifOPMeuBjHi6jn5MnRQKHMXmT8ghYfWTDK2CgxAQb84uR0y
 b0EzYr3s4sW54zYX/O5wPQ3yCOjfKECizF/PC4hs2Tc+pc4jE+N1WGOg+xKCKR1HDfep
 tkL/DUer2X7+jlMWTzs08TPrBZ4XNuYN4kTp8ytEModoPVmG5VBxGyltmFORcvHopOgG
 NSL56mNw93Jdyg7iHrf7wL6P5Vw+f1j5/pUFVX02bNgZxUJ6dgRJWQchFIJFzFyeqk9a
 2LDUN6w/JKDddQZ/TF3uXWNRn7DOb1PigbXG9ml1bMFTiXLeeNv8DTUfe7Ix57gjEVxl
 fxIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794868438; x=1795473238;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AE0NqPk9tD9jHDenbPcgNnfp23hzCv1QvApHi1mN4k0=;
 b=JZZMmREdx8vPqd2RBon/rkokGVgagnvtxUCeas0NIB6rkhPes35MiJYAxCdrxOjgTs
 QvvDcJv08hgmD26Tx3n+yQ/Vc+VYftL7seFtDDIidXo+Ik4rQx3D5DgghXLzn56UKDXh
 MNeqUa1A5U9TDqyhA8scjfWQspVb7gO/VLRU1yPo9E5pNoxUu+LDLXAPXpBvE7Nkau5v
 YEWDv45wN2Bm/lBtqV0VgWuYX+sY86YDuOtWkq2D/V3tnKWfQZUCxVcvdhAgvuaX3iyo
 PqqNNOr5WblaV3Qh/vvP/BWrqNpUnTLYKCIeS3vGDyjx6KOlHwIEwXj5640mXwRa4TyQ
 q0kw==
X-Gm-Message-State: APuU4Z/7Engc5t1Gmx4k/E47PBa2Hi3F5Q4ELxaQQQN/8CITYM2Ww0pN
 TEO8wQv8kjeW7oUO7FJbm/MFbxSWgPWSCgQwzz4kWaqadEaRrmaxu4M0O4ODwzGzH+9ORYYNaOb
 wFRmdTNc=
X-Gm-Gg: AYBFou2XJV8hzxArfL+/yPzvrRm8FWcdpDLYx2lg46CoQcIRWeBFwZRAmySYfqiHR9G
 TMFYjI6HaMLDLYg8dYzZz2DrygPJMkQ1ce41FeCHPG95PLf3d5m3cHp9fSxPZLSh5emevyan2OC
 8qcJVKXoy9+p1KpNwtEa/lhf7M3A9JFPU5LTuc0KuW/AfunCI8SW0r+0CFOsiGLFkfgEPyqaOn8
 k76zH+UQerWNdNo90t4RHMUa7UYggEFSLIWVGIePXlPfk4pf10jqgP1uv4lvlXxoq19oFfA0o/Q
 1bk0OuXMsAVu1XbVa1y0IJnjJcZYgIpJAMHatOV/eTt7mgUvlGCNcmJHk+2FFv0nWqjllwLMTGg
 +wuACuDrHESXf4rbrL33tVNUaNdMptNYWMkwNYNwleuaS6JHz4hsrYnUc43UyzIvh5PqxejaksT
 vTypvGChCA3bULtieWGpO2siGlIE1fb146Y6TsuaoDTSMsX+67xBlyE4DnCOyk5nLR6WfV0cPor
 3weUJk2vXvQxvdiz7NX0lsBALjgbEUwp0CsKycgDGsBZhfpqLJL5Kqhc2YxxUDkoa+6pv/uMBSY
 hkJJBR60SMNgva3SRIGKi6vw29N1nD3Qrw==
X-Received: by 2002:a05:6808:c125:b0:53b:87e5:8c95 with SMTP id
 5614622812f47-56e647dfa2amr9921044b6e.37.1794868438061; 
 Mon, 16 Nov 2026 14:33:58 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7056:3b5b:7d85:4921])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-56e70c58f9bsm10173280b6e.13.2026.11.16.14.33.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 14:33:56 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 16 Nov 2026 16:32:43 -0600
Subject: [PATCH v3 2/8] spl: add the devicetree of the next phase to the
 bloblist
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-mtk-mt8189-tfa-fdt-v3-2-ca423d2d8038@baylibre.com>
References: <20261116-mtk-mt8189-tfa-fdt-v3-0-ca423d2d8038@baylibre.com>
In-Reply-To: <20261116-mtk-mt8189-tfa-fdt-v3-0-ca423d2d8038@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5430; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=/RksWhAu3vkYvTePYfrdDR/XLcMWeFE3GDIyuO8zp0M=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq+4SdhINZB3xkzceCly3ksNqrer9FlE7GIKBWL
 a0atmLKOmaJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCavuEnRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AMnoH/RALOo3nkyNJchwdaYsciFN+/qgo5PQV5bugN7j
 oaRZU+hAJPKG4FpPXMm8bDhApgJMZoU8g7fe09aYRgNNdO9VGHv9wXbbNo1tdpniR5WXjTbtUC2
 jy4UZAonfHwvJ2qYbamdpEFziZJwBqzvfwWd/DwY9HPtwULr5xXsrEcJzm28UjbfouBXP3aoK/9
 c9NuMoqRKbwQJsMfgke/+g30yFr74jTcaUmuU9GhzbFHmDRMT4wjaR1U0Pl72JpKrVo4X/ZizTX
 8wSDWJEGfY+h4mDbAJhHz797d0xxKpFWh1aA5kFv/+B+nKEAif0jngy5pWPLEj0ZNMmlJ8hLCx5
 rcHY=
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
 common/spl/spl.c | 84 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 102 insertions(+)

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
index 6d81984428c..673420d9249 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -39,6 +39,8 @@
 #include <dm/device-internal.h>
 #include <dm/uclass-internal.h>
 #include <linux/compiler.h>
+#include <linux/kernel.h>
+#include <linux/libfdt.h>
 #include <fdt_support.h>
 #include <bootcount.h>
 #include <wdt.h>
@@ -465,6 +467,82 @@ static inline int write_spl_handoff(void) { return 0; }
 
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
@@ -851,6 +929,12 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
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

