Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C736606A319
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 07:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=oA0dSD8C;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JESKSlny
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 310CD811B1;
	Thu, 22 Oct 2026 07:09:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OmKXE8lE-vIP; Thu, 22 Oct 2026 07:09:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org EE1E4811FF
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792652957;
	b=m30kFaoeyIYDepkeFxXIXQNfXYKPI5UlsNw0+s9jpEO2yTqI36Go1MJ/WEc+ouHTuSk1
	 mEyapbXX2bnqh1/MixiFxKmjkVnbEc78U/LtbC8QlBVzPRH/mYdrT4xzT8oSfiDEcDiGO
	 /0pkeKmj/QcbLpNML/PiQxttJa0JEP+21MICRFUbZtJPcPWyIu0eiQ29o3SpMLOrgZJa5
	 hJAKhhoJswQenXO2oInjipJkwMpoh50tyEPcIYHKfnum5FMAK25+ckOseZ9VTOv8B+3m6
	 devr2yq4indJze4Z5ZVgU6zLgwTnUi2ziM3U27b35GnWVtHgOrXVWce3tFDSCQyjMeA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792652957;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=WJYFR+7j35ry4LFfFzfam85xbSp/jIWWvwhbVARIPWs=;
	b=OH/1qFP3F0U6z3sVimpkQWixWtdmliBlmY2IJ/DVpbRCTUQdrkkAhhnRoVUKxQZd5SGV
	 VlTBkQSprlmKd2bH7r0rk+/KZHQnSEUeGN2FfK8XTD27LMoxJc4DRhgdieaClEqH+lPVH
	 qQPFy8y0Z8gdtNBQl/XSoRUbpuxzwDuoD/uQYbDtiCVDQ53X6b+KZqYPv2eTXCB5xHizb
	 2Y4maLumYfly1HfMhapoPcivhExzXPVMSC172jwhlRMrZXSpXR8tNHm6g9ksUZK1qdQY/
	 tJoq8AEoQSwnrKbssqeqMtgE/SOV3Ef3KV+YUw7LpMOHIQ/v1j5vN0ExNU0tXsD5WBA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792652957;
	bh=WJYFR+7j35ry4LFfFzfam85xbSp/jIWWvwhbVARIPWs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oA0dSD8CaA1sP7O+jX1UYDahWWj6cFcBTQzFFCxnF0sMlQQHcSw+FDtCbtwR++sy0
	 UDIVXypHRhe3PQwPDwDUbwpHTBb7aJcYKLIVsMo3ncNxb4cYaZ9VdmrgBWrFkJjc/g
	 kWETsBnY9N2jBcTMky+10Y3OutOIjoCk7ClUfcYIZ6xRNYLkOMOrrXDR+LERy06LK+
	 oKMThr9DSImlH7HtH0aHqIuiPm2gJr5ZoKLX5j5q1bkpXgzcG29O9MPTrB/4R+8et/
	 by61ESz87YBfgT6HU/lsZG8S7LVfWTFsDF2ob8CBKQsV7W59SPUqPbg9Ef3AP/VJbc
	 0QVmOMUqiLBww==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EE1E4811FF;
	Thu, 22 Oct 2026 07:09:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 731A2371
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 07:09:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 59A4A4070A
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 07:09:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Gx3jPm6sQVhk for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 07:09:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 22B38406E6
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792652949;
 b=jcA2ACzucrHXTiFhHE6qGGTym7xr4FG/ShJpFlp9sNPE1PaWlvE3o9VQmB21cU03dQKY
 brS5JsllkZbXbeCQ1bGtEUocubb5ERWnUvg6QH65AszRVNHFWUaG4gIpdg26zMQB4jtNP
 SdAZ5TrH65bB2F8YxqH0rXmHKvltvOm83n9VgwJEO7276EMCSxEuXRNPb/9MUe3N8yKfB
 bsjROURHMmEa0scywr1dyUy6VQ1ebvcCCNGxAb+rA1wJlSmjhLCn9HgMw0kIPw00K1SyK
 hX9v3SB9kgKNEq2vD8/nHotZhoqHbl6fRHa9/KC1INkc7XkznL8Hsz4/wNbOl2reM/w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792652949;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=WJYFR+7j35ry4LFfFzfam85xbSp/jIWWvwhbVARIPWs=;
 b=sWa6Du68HtDancLH3nqSO6g+P5IlaQMLvXSE+6GWjLwL8T+sHFAD31MX0BP/GkS+WfSd
 td/veOVejFuJ8fZ8FomYwbvGbv2+EmnoEpUpyO3uRVrI0R09AQY+cTWiI05VWQCKG28Pw
 VHPGXLBJ+JnZT3Wz3aDE/2El+yK/Ed5L9+2+udu9nTy/Wyl6HX4NaYmjjaz42rRaegwHv
 N6AX4bAJIBqtBTV72GrBzJi9cxKjV8pJPSAO27bcp4U/PVcK03gLUYvC8CubtCs8aLfs2
 o928Vs2344iPYMk4iUmkz6VWLDojeEqC2qrwDyRxsnl9Ws2YhIhZkzMY+36/W8SWJ1w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=JESKSlny; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42d; helo=mail-wr1-x42d.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=JESKSlny
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 22B38406E6
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 07:09:08 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-48bbb06e746so884882f8f.3
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 00:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792652947; x=1793257747;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WJYFR+7j35ry4LFfFzfam85xbSp/jIWWvwhbVARIPWs=;
 b=JESKSlnyANYca81iUJMf6k6CJreV2Hig+GwJ9vpnGEst2lU1dCUg1PYx4pkdwsXmZN
 oaQXYHKjYUDNXhB2M9XvXFobnV2ejEIXzx2nZ+fGSKgTgykDQpxf/truw24fFgf/HSMM
 AsucZXFEkUSz7/ELvK4LZuAtvTd72UTiQFx2rVYz90Qy1D7qz5VqAAlwGH4u3udYkg4x
 Zxyo+j8h4+88Mly5FWt3Rlj3LJQ2I+LFEdA0rxRP6BOJ4EoN9a7YKHyjOURDwYB5/HdL
 utpkIkBBRQymYJsO3c4kU/asjkJMOAoJbfoi05utKByKvuzG1BfdKg/+5gw3Cq1A//zk
 utSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792652947; x=1793257747;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=WJYFR+7j35ry4LFfFzfam85xbSp/jIWWvwhbVARIPWs=;
 b=uNLczjpCVHzliQty8bXb3WssHp1QPFE1krIwPpKI7wLvOR3Nx0w14fbXiSIEt4Bl8U
 LKVJp1xkl8a8Uhnc1sKSK4w8fH7VjCKaC3O/jnbLWvkOlZyVjc0oD8h24npF7XWHm4sJ
 vnP2J2JO0oUxVqxXTcTGN5xP8iKPaOFTNEYapxArohxcyT+kZ2AmDL0PiEmxGXwCAUys
 dK9HTI7YunM0bvDRudc7a+c+wg59elaFdlDZXt5P6hoWqOqPaj084fxoYIMnIBC75UGz
 c2aomNypR0ZQp1c6JBEmVaOjK7mmWgoQEGmvOWnhRb1Q0ETJiJqyk4PGRUMgxPag9xYp
 U58A==
X-Forwarded-Encrypted: i=1;
 AKwUvByDgVTD6MnZmyPitp6GQyuSTX25PPZNXRrECuxU5Amx6cWZMePSgA4FwphgZgQJ6zmvo17WCl4=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJddhal6qjCXnmd8G8EtIcEL3lmPyrc+Ry7WextAR+b7ZFkd2Lq
 lVt2eTlvSJb8WIoc8XP5EzeOQqe4tRl5lKZt3Dcjl5eCxGmapEwJkGle
X-Gm-Gg: AYBFou2RJuDWiyfkErSylE/SnygYd4veRlqI8X/Fr+rvklja23bVqbH5SNogd1ccGcC
 9+kzImVKT/Ji/EpTzzhkavyomWtEobZWCOY65JdJhmaDv9ApShfGoz7B41qWpDsCxQyiWF+BuSC
 YFGg+ft2Bu9jm1Gn8qIrExEeqZeDuDg13dzpVnBlpiWNI5BbiKWzxww/IWbePZhKyq2sPwxx0gP
 AA7Vl4H5n6cewHxbbcnLXXBIUxF70VnmelY6/m4N3JRgWe2bjP8Vqyt0XH4gqiwB0/pW1wOJNq7
 notAfX/smOBJVeVSKx6rHZ5RDGZtKPg7q8XL0eWZcMFIsOupyJoCExLqUNh6zD21Uo5JohpsjFU
 UIJoVDe7RI1nTzYqilIgYMAEaESfspKvQsLtVZ0ShA9OsAzRtfNBsNQ9gsyOyvlLCItWgc8CewO
 vxGD31o6os1o1hPU53/m5TUNk3gkZHtuzLzczw0/XNNvlmrOfflR4HpJt1BNaHQk0bH2OXk3L6S
 rbkBK6XH9wyKwd1PMuMdo/+JH12U7qAwVjMs/Q7aMPz+HCXp2+FasVuw6J6cg==
X-Received: by 2002:a05:6000:2281:b0:486:f907:ebec with SMTP id
 ffacd0b85a97d-48e264e4654mr9506693f8f.31.1792652946837; 
 Thu, 22 Oct 2026 00:09:06 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e25835247sm10347613f8f.41.2026.10.22.00.09.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 00:09:06 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Fabio Estevam <festevam@gmail.com>, Stefan Agner <stefan@agner.ch>,
 Francesco Dolcini <francesco@dolcini.it>, u-boot@lists.u-boot-project.org,
 mehmet.fide@screeningeagle.com
Subject: [PATCH v8 05/10] dm: core: add ofnode_get_alias_seq()
Date: Thu, 22 Oct 2026 09:08:55 +0200
Message-ID: <20261022070900.616265-6-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261022070900.616265-1-mehmet.fide@gmail.com>
References: <20261022070900.616265-1-mehmet.fide@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Mehmet Fide <mehmet.fide@screeningeagle.com>

The sequence number an aliases entry gives a node can only be looked up
for a device, through dev_read_alias_seq(). A driver that has to know
the number of a node it does not own, one it reached through a phandle
for instance, has no livetree call for it and is left with fdtdec.

Move the body of dev_read_alias_seq() to the ofnode level and let both
of its variants call it. The flat lookup reads the tree the node belongs
to instead of gd->fdt_blob. The live lookup covered the control tree
only, as of_alias_scan() builds its table from that tree; a node of
another tree is now looked up in the /aliases node of its own tree. The
stem must match the alias exactly, which the previous patch makes the
flat lookup do as well.

Tests check the lookup on the live and on the flat tree, with a stem
that is only a prefix of an alias, and on another tree.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
---

Notes:
    Changes in v8:
    - none, rebased on main
    
    Changes in v7:
    - Reviewed-by from Simon
    - rebased on main
    
    Changes in v6:
    - none
    
    Changes in v5:
    - the stem must match the alias exactly, as patch 1 makes the flat
      lookup do; the kernel-doc says so and the test checks a prefix stem
    - a node outside the control tree is looked up in the /aliases node of
      its own tree on the live tree too; a test uses the other tree of the
      sandbox tests, which gains two aliases
    - the checkpatch note moved here: the warnings are in the body the patch
      moves, which is unchanged, and the check is the DM_TEST layout every
      test in test/dm/ofnode.c uses
    
    Changes in v4:
    - added a test, run on the live and on the flat tree
    - the kernel-doc no longer promises -ENOENT for a missing alias, the
      live tree returns -ENODEV

 arch/sandbox/dts/other.dts |  5 ++++
 drivers/core/of_access.c   | 42 ++++++++++++++++++++++++++++++++
 drivers/core/ofnode.c      | 20 ++++++++++++++++
 drivers/core/read.c        | 20 ++--------------
 include/dm/of_access.h     |  7 ++++--
 include/dm/ofnode.h        | 16 +++++++++++++
 include/dm/read.h          |  8 ++-----
 test/dm/ofnode.c           | 49 ++++++++++++++++++++++++++++++++++++++
 8 files changed, 141 insertions(+), 26 deletions(-)

diff --git a/arch/sandbox/dts/other.dts b/arch/sandbox/dts/other.dts
index 515d6348b3f..50597e2d570 100644
--- a/arch/sandbox/dts/other.dts
+++ b/arch/sandbox/dts/other.dts
@@ -15,6 +15,11 @@
 	#address-cells = <1>;
 	#size-cells = <1>;
 
+	aliases {
+		other-test0 = "/node";
+		other-test1 = "/node/subnode";
+	};
+
 	node {
 		other-phandle = <&target>;
 
diff --git a/drivers/core/of_access.c b/drivers/core/of_access.c
index f910cc9a31b..2d19dfec25c 100644
--- a/drivers/core/of_access.c
+++ b/drivers/core/of_access.c
@@ -971,11 +971,53 @@ int of_alias_scan(void)
 	return 0;
 }
 
+/**
+ * of_tree_alias_get_id() - Get an alias id from the /aliases node of a tree
+ *
+ * The lookup table covers the control tree only; a node of another tree is
+ * looked up in the /aliases node of that tree.
+ *
+ * @root:	Root of the tree the node belongs to
+ * @np:		Pointer to the given device_node
+ * @stem:	Alias stem of the given device_node
+ * Return: alias ID, if found, else -ENODEV
+ */
+static int of_tree_alias_get_id(struct device_node *root,
+				const struct device_node *np, const char *stem)
+{
+	const struct device_node *aliases;
+	int stem_len = strlen(stem);
+	struct property *pp;
+
+	aliases = of_find_node_opts_by_path(root, "/aliases", NULL);
+	if (!aliases)
+		return -ENODEV;
+
+	for_each_property_of_node(aliases, pp) {
+		const char *num = pp->name + stem_len;
+		ulong id;
+
+		if (strncmp(pp->name, stem, stem_len) || !isdigit(*num) ||
+		    strict_strtoul(num, 10, &id))
+			continue;
+		if (of_find_node_opts_by_path(root, pp->value, NULL) == np)
+			return id;
+	}
+
+	return -ENODEV;
+}
+
 int of_alias_get_id(const struct device_node *np, const char *stem)
 {
+	struct device_node *root = (struct device_node *)np;
 	struct alias_prop *app;
 	int id = -ENODEV;
 
+	while (root->parent)
+		root = root->parent;
+	if (root != gd->of_root)
+		return of_tree_alias_get_id(root, np, stem);
+
 	mutex_lock(&of_mutex);
 	list_for_each_entry(app, &aliases_lookup, link) {
 		if (strcmp(app->stem, stem) != 0)
diff --git a/drivers/core/ofnode.c b/drivers/core/ofnode.c
index b5d13c43db1..81d91ce5476 100644
--- a/drivers/core/ofnode.c
+++ b/drivers/core/ofnode.c
@@ -1233,6 +1233,26 @@ ofnode ofnode_get_aliases_node(const char *name)
 	return ofnode_path(prop);
 }
 
+int ofnode_get_alias_seq(ofnode node, const char *stem, int *seqp)
+{
+	int ret = -ENOTSUPP;
+
+	if (ofnode_is_np(node)) {
+		ret = of_alias_get_id(ofnode_to_np(node), stem);
+		if (ret >= 0) {
+			*seqp = ret;
+			ret = 0;
+		}
+	} else {
+#if CONFIG_IS_ENABLED(OF_CONTROL)
+		ret = fdtdec_get_alias_seq(ofnode_to_fdt(node), stem,
+					   ofnode_to_offset(node), seqp);
+#endif
+	}
+
+	return ret;
+}
+
 int ofnode_get_child_count(ofnode parent)
 {
 	ofnode child;
diff --git a/drivers/core/read.c b/drivers/core/read.c
index ba48862f44b..985f6128d97 100644
--- a/drivers/core/read.c
+++ b/drivers/core/read.c
@@ -356,24 +356,8 @@ const void *dev_read_prop_by_prop(struct ofprop *prop,
 
 int dev_read_alias_seq(const struct udevice *dev, int *devnump)
 {
-	ofnode node = dev_ofnode(dev);
-	const char *uc_name = dev->uclass->uc_drv->name;
-	int ret = -ENOTSUPP;
-
-	if (ofnode_is_np(node)) {
-		ret = of_alias_get_id(ofnode_to_np(node), uc_name);
-		if (ret >= 0) {
-			*devnump = ret;
-			ret = 0;
-		}
-	} else {
-#if CONFIG_IS_ENABLED(OF_CONTROL)
-		ret = fdtdec_get_alias_seq(gd->fdt_blob, uc_name,
-					   ofnode_to_offset(node), devnump);
-#endif
-	}
-
-	return ret;
+	return ofnode_get_alias_seq(dev_ofnode(dev),
+				    dev->uclass->uc_drv->name, devnump);
 }
 
 int dev_read_u32_array(const struct udevice *dev, const char *propname,
diff --git a/include/dm/of_access.h b/include/dm/of_access.h
index fe0de73d7e2..afbd32b2990 100644
--- a/include/dm/of_access.h
+++ b/include/dm/of_access.h
@@ -651,10 +651,13 @@ int of_alias_scan(void);
  * of_alias_get_id - Get alias id for the given device_node
  *
  * Travels the lookup table to get the alias id for the given device_node and
- * alias stem.
+ * alias stem. A node outside the control tree is looked up in the /aliases
+ * node of its own tree.
  *
  * @np:		Pointer to the given device_node
- * @stem:	Alias stem of the given device_node
+ * @stem:	Alias stem of the given device_node; an alias matches when its
+ *		name is the stem followed by the number, so "usb" does not match
+ *		usbphy0
  * Return: alias ID, if found, else -ENODEV
  */
 int of_alias_get_id(const struct device_node *np, const char *stem);
diff --git a/include/dm/ofnode.h b/include/dm/ofnode.h
index c905e86b283..c6eaebb4c75 100644
--- a/include/dm/ofnode.h
+++ b/include/dm/ofnode.h
@@ -1180,6 +1180,22 @@ const void *ofnode_read_aliases_prop(const char *propname, int *sizep);
  */
 ofnode ofnode_get_aliases_node(const char *propname);
 
+/**
+ * ofnode_get_alias_seq() - get the sequence number of a node from its alias
+ *
+ * The aliases node can name a node with a stem and a number, such as
+ * "serial2". This looks the node up in the aliases of its tree and returns
+ * the number.
+ *
+ * @node: Node to look for
+ * @stem: Alias stem, e.g. "serial". The stem must match exactly: an alias
+ *	matches when its name is the stem followed by the number, so "usb"
+ *	does not find usbphy0
+ * @seqp: Returns the sequence number of the alias, if found
+ * Return: 0 if a sequence number was found, -ve if not
+ */
+int ofnode_get_alias_seq(ofnode node, const char *stem, int *seqp);
+
 struct display_timing;
 /**
  * ofnode_decode_display_timing() - decode display timings
diff --git a/include/dm/read.h b/include/dm/read.h
index 12dcde6645c..d0c17c3d343 100644
--- a/include/dm/read.h
+++ b/include/dm/read.h
@@ -1168,12 +1168,8 @@ static inline const void *dev_read_prop_by_prop(struct ofprop *prop,
 
 static inline int dev_read_alias_seq(const struct udevice *dev, int *devnump)
 {
-#if CONFIG_IS_ENABLED(OF_CONTROL)
-	return fdtdec_get_alias_seq(gd->fdt_blob, dev->uclass->uc_drv->name,
-				    dev_of_offset(dev), devnump);
-#else
-	return -ENOTSUPP;
-#endif
+	return ofnode_get_alias_seq(dev_ofnode(dev),
+				    dev->uclass->uc_drv->name, devnump);
 }
 
 static inline int dev_read_u32_array(const struct udevice *dev,
diff --git a/test/dm/ofnode.c b/test/dm/ofnode.c
index 0f60c2a6281..d4c7380a412 100644
--- a/test/dm/ofnode.c
+++ b/test/dm/ofnode.c
@@ -523,6 +523,55 @@ static int dm_test_ofnode_read_aliases(struct unit_test_state *uts)
 }
 DM_TEST(dm_test_ofnode_read_aliases, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
+/* test ofnode_get_alias_seq() */
+static int dm_test_ofnode_get_alias_seq(struct unit_test_state *uts)
+{
+	int seq;
+
+	ut_assertok(ofnode_get_alias_seq(ofnode_path("/i2c@0"), "i2c", &seq));
+	ut_asserteq(0, seq);
+
+	ut_assertok(ofnode_get_alias_seq(ofnode_path("/some-bus/c-test@1"),
+					 "testfdt", &seq));
+	ut_asserteq(12, seq);
+
+	ut_assert(ofnode_get_alias_seq(ofnode_path("/i2c@0"), "spi", &seq) < 0);
+	ut_assert(ofnode_get_alias_seq(ofnode_path("/some-bus"), "testfdt",
+				       &seq) < 0);
+
+	/* the stem must match exactly: testbus3 is not a "test" alias */
+	ut_assert(ofnode_get_alias_seq(ofnode_path("/some-bus"), "test",
+				       &seq) < 0);
+
+	return 0;
+}
+DM_TEST(dm_test_ofnode_get_alias_seq, UTF_SCAN_FDT);
+
+/* test ofnode_get_alias_seq() with the 'other' tree */
+static int dm_test_ofnode_get_alias_seq_ot(struct unit_test_state *uts)
+{
+	oftree otree = get_other_oftree(uts);
+	int seq;
+
+	ut_assertok(ofnode_get_alias_seq(oftree_path(otree, "/node"),
+					 "other-test", &seq));
+	ut_asserteq(0, seq);
+	ut_assertok(ofnode_get_alias_seq(oftree_path(otree, "/node/subnode"),
+					 "other-test", &seq));
+	ut_asserteq(1, seq);
+
+	/* a prefix of the stem, and the aliases of the other tree */
+	ut_assert(ofnode_get_alias_seq(oftree_path(otree, "/node"), "other",
+				       &seq) < 0);
+	ut_assert(ofnode_get_alias_seq(oftree_path(otree, "/node"), "i2c",
+				       &seq) < 0);
+	ut_assert(ofnode_get_alias_seq(ofnode_path("/i2c@0"), "other-test",
+				       &seq) < 0);
+
+	return 0;
+}
+DM_TEST(dm_test_ofnode_get_alias_seq_ot, UTF_SCAN_FDT | UTF_OTHER_FDT);
+
 static int dm_test_ofnode_get_child_count(struct unit_test_state *uts)
 {
 	ofnode node, child_node;
-- 
2.55.0

