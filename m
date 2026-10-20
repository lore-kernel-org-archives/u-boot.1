Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD13F60A260A
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 10:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=sDvBhUwd;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WZKwDCIk
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A6A93810DD;
	Tue, 20 Oct 2026 10:16:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qFD1bxbt83bC; Tue, 20 Oct 2026 10:16:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org EC7648115C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792491391;
	b=nL49kOP1gmxJ9xoInBhNkxJZ1Z+VWQP6pMNDTrPSEbyRvCzJXwblZind837X1DPM3LZr
	 oeiK2RQOffQyZdZsfxTSRFvi2WcV6XPZWPxMMlwOcjAwARdfgOi4+pGpdc7NofnmtrbKb
	 1y1Wy/LrsRYY/xwMdUY53EMnxiSguFOpzLdx7kT6APDYk+yUAGt59I68VPKMCSecGIEZe
	 C/wkoDYTeGGiYWuqV2Imy3fUX48grHmsrumDChxqkIM1LUAOZc3gPY4xN1GS7S5WORX4f
	 nJWhiDe9xuymZBPKVQjU9IBpNBNw4Z4SmU6QW+aQLCsnzlO6kVQUq4FrmmMq75wYzjA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792491391;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=xnpCQYl/ekKd+ylY0lTBLIFC/gjY+mOCyIIlVnuonGg=;
	b=ZQ/hJ2cPBrRYsAEKi2qj0Lf23u3s3a+GKziR/JpU8sHjigW5Z1sSfj9y62aoItAZ9iEg
	 7zbuiGSOlVld4UFkR8tWjqsA3C42qasFUjR23YHWakJ8ePOxXvYcfv8jw491hAsyUNVX5
	 ELZ54SyOZJQQM1rAIsJrXp5MSXLZ2oxAPrhOOi0huyu2/4OG+L0K/maEMtNmSppuqeYv9
	 MTyTChpZTLc5GTjpSmIY9ACCyzcLkVE7Wg0C2I0/TtNivzwOiWxCmLYwxgY8fyCxoiSMP
	 dAjVzp4WXRPV0mQIBha0gR3UiaEfrjos8J3Jk0hIhyznEjQSd3RW27UfN/JjStudbPA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792491391;
	bh=xnpCQYl/ekKd+ylY0lTBLIFC/gjY+mOCyIIlVnuonGg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sDvBhUwdGLxRDWEuzQlrbUNdrOgeCTJlGL207dZ4Btf5Un9tbeubDxICsnOc+AzM+
	 AO1hZ/mdA2wtkIEkGnBj7IyrUrvzQnf+fkGv/mtpGCzGeyPmubpWlstLMJa0KhCj0J
	 KerIaKj1SylUuVFIIGxgEMu3yWobUNxVWR1luB4bD9k4c4J3NdM5akFhnjFmTK7pjT
	 4Y3dKqcXKHSlmmq4GMgshKwo1A9nv/V1I3EoClQvtGvSahophaFubPFMPDL7j2FBeA
	 dmepGRI/3lKFgwmRA8vU/T9n/vP71tlXjXBh3VPZ2ZRSh/gBRoQqcc3mtsWjwpekgi
	 yCkMcoV/3v21Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EC7648115C;
	Tue, 20 Oct 2026 10:16:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5875D1DE
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 10:16:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3E34160825
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 10:16:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6qtpgSytS6oi for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 10:16:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org EE7C460822
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::336"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792491377;
 b=feJfTc5eZyL8PCjp3r6PfiMnvEM2+/gmucamdveU785QtghbJ46Kqx6Uw7oJNZF6Edr2
 /Ij/dPta2cUBE9aazxkx28FoJSIyCAIrzhgqFwzkaGpxD6q5qJfPYf7VxzgjhjqraVbUI
 Vp3DD1h4Igvmlo6u3K1Zc1luEIPV2L2BU+cM+X2RLrBxqXdrvhY5vcsmk8TQKnhrEO94q
 M9+u5FBaL96mWeY36lfoyAwS89Hxj/S1jWivgwpZouzpfrBUiMykCn7x8VwEth4YKZKya
 so17S1Sjo0+oZUIlvRntrbVFgddxNTNxRysRv13FlUTwXyNW1MuxVzNG1+vm9r0Id4Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792491377;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=xnpCQYl/ekKd+ylY0lTBLIFC/gjY+mOCyIIlVnuonGg=;
 b=TqxFRQSbckpVuX25p2zuEmrM7nG+Vg0sF78uDOkyIqUj5WFCyO1kHq2MOZ3Ax7z4Tb+M
 Tv+7j6WMcMKdPhWrMPeuMMSN4FFmS4CAZCCyKp4LimqIdEIfIA1wbR6PCnDVi8KXbHNhx
 BvFAaCeqe7IppNlC4e61BagKX5J5E9xiT7Pnpv9Y/Fg9WMazLUdI1j/VvU2XxVZwuiCMT
 RwP09uNE4H80SkQaqY/pzFZZjXeUIG61Yt3VaddLEmYVVqHCqU2GXlt8CAyWBRovvgshP
 XuiROxWWIXJGnEO46nBGNaF5933VzgTWhf7nU363OhdMX3HbZavGNioDyKN9sbL3rbw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=WZKwDCIk; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::336"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::336; helo=mail-wm1-x336.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=WZKwDCIk
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EE7C460822
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 10:16:16 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4a1dfd49525so19421215e9.0
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 03:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792491375; x=1793096175;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xnpCQYl/ekKd+ylY0lTBLIFC/gjY+mOCyIIlVnuonGg=;
 b=WZKwDCIkk5DSosOLg4kkQ09r9hKIyhfUCbdLv/UDSE5qtWhBJbNzrxlhbVEcfswct/
 h1cU2WGIehmqIqsPsq839dQFN0hyIjasKe52Wzl69/gqo8OgqNRqYdbh0vujkBd8dFnX
 U6MVgClPluf+LfDIhQ269GoCDro1wEKXfTBmLOKUqiqpjM+10xOcNMVf52rDYc5vSvd2
 5SBy2ucHUxaRRTNJw7/qoptBnw9SYpGT1Vgmah0Ok+8BGtqJ1BF3KZutvB/HwtDZGzAx
 Gk6irB6DTSITrW5Sk6b/rCv5BZb5QC4dB8kCzCTHiDCGVY2KFSDT4WKmwYThVYHPLwu6
 B8Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792491375; x=1793096175;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xnpCQYl/ekKd+ylY0lTBLIFC/gjY+mOCyIIlVnuonGg=;
 b=Vtfnp5Sv9E+W7QzXkUmk5tX4l/OM7hzTISWDUbPavXK2gJgeFXhjxxKDHM0/vzMxnx
 MXKE/fXm3D3Agh6NnGsmElAr+aQk2jJIFrJynGyKheNfgujBxKDC0nEw5I++7mZYbg5T
 fXNZCN9b4OwUo9T2Nu9KsWNJ0t1iOTdyZZI2mEXEnBc+T/fkEPRP6bVAydGnBG5KY0Lc
 btgKdOF28dqwensUxCtPeCmOdZ4OaEjwolbfKWriwM9SHqctyrANI/nX1QZL2RtBKl0W
 6QTqUFrf8k2aHBlvhFzalRP1q75ZN/MlLln8b7EdxW5vW+ubYT2xTVQFtpf7NI9MmT0H
 WK6Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBzOzj60GU6Klu89ZD88gKTQFSPUAuW2GysGqUyFiHXc06xcj5z+6WtjQQXTBLEuI6/NriL4p8c=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJz9PLu3+z2oduH96wSa0vyStoY/c8HvnoBF2pmo3lkE3M+grE0
 4ghIkTv00lN+hymnQ+zDP+cLttTcT7O2e0u9tCqqTpMd+FqyechEw+Ye
X-Gm-Gg: AYBFou3lMmZM6LoLjzr53UgNMUlYiyiHDHBVLJTXGdp2xJODmDNuz220HfKQnNPbYdN
 0i1Sy5EpIqjIe7O+PYhxwxxS0ES57PdEe7fbpl6AyO0v7kMQRTfRFhc/1zcgismWtNNBGG2cfKl
 4W/ngI1IKtqXIpB4DppMUoiDYt7QBkppBLbUH1pUsps5y6ETDJKpJlzhotzc3NOhQpFDoXc5jYL
 jv4uPCSEsk6saLX51t9gQ6HMkn9k0hBqDIm5tSGWU1HbKM0sBFT8MwiZ05oROUsufjwqOmgiOCn
 LsLnPxolXu2jU1Gbq+pANjOiG6EzvpsGG7cp7w8ZcnPe4jhUDuhilygtZhniD5Pz1vTJs/OYZRG
 hNlTPBzTqj7GYEQ3e3pB0vRflsjrjl2vc5DkTje0m4sfmGorAG4lgiGmM9m8h1fuBwXyUXzbkPd
 4cKcreIPQzwESKwFJh5w92ToPbVZhyHNCyF9T7bgsiNikFn9JBx4N9S7Ud1+S9wkhgBWQKVBa7x
 RBxTy8+h3hvSqw=
X-Received: by 2002:a05:600c:548d:b0:4a1:e250:b191 with SMTP id
 5b1f17b1804b1-4a1e250b1c7mr153063065e9.17.1792491374683; 
 Tue, 20 Oct 2026 03:16:14 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f2ca3597sm60140505e9.2.2026.10.20.03.16.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 03:16:14 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Fabio Estevam <festevam@gmail.com>, Stefan Agner <stefan@agner.ch>,
 Francesco Dolcini <francesco@dolcini.it>, u-boot@lists.u-boot-project.org,
 mehmet.fide@screeningeagle.com
Subject: [PATCH v7 5/9] dm: core: add ofnode_get_alias_seq()
Date: Tue, 20 Oct 2026 12:16:04 +0200
Message-ID: <20261020101608.2818265-6-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261020101608.2818265-1-mehmet.fide@gmail.com>
References: <20261020101608.2818265-1-mehmet.fide@gmail.com>
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
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

