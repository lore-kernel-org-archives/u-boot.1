Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC76606A885
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 22:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=jpTksEPu;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=KbwACVMX
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EE7F0407A4;
	Mon, 16 Nov 2026 22:34:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Du9fDZ9aqH8h; Mon, 16 Nov 2026 22:34:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D7FBE4078E
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794868460;
	b=fGl0AbhLiEEj9cJafdjwLOiJFrmS4KTJc7Xew4v4VgsrwtrDGas9L2RxucMqyjzxHwQJ
	 S3wUCOWjHVGTeN7VcS9wgV9YkwVylBUaPjOax6kb/iCPUcVwtZFqDUNjxBfU4BYwOvA2M
	 RPGKYLNGA3xOhxpbxXyqPnCiw1SlY/KgSpQ+O8o0WeNvVMi9t70IkM63dFEX8tVRtoiQo
	 0Q4pq6luDg/foeaIBScqEWqzZx2g7CDLYjmHVnTnYDOgJu8ytVjRrQGrrRVH4rN+ZgtfM
	 ji64WtjIYDfp4zkObSVLS6YQ83O01bG+Q56YgTyWdLbg11yQNRjo1C9QK0ggxmVbqAA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794868460;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=UAD5iumUHzHSM5DF5NecwaZT6IG9bQV+JaDguk/gSSI=;
	b=AcIe9+MiXoSfMYo+SdpTb+Z0oK//zK0HyifCwBSI70nNKNsMkVtzQSjqozdEq1EXnboS
	 4x2h5ZuE2A2DbV55xq8rAK3LVororZiP71INDnhvmvH9bmVf2ptfe+8Ufo2a1Ci4kPorL
	 lbextzR9hxBVrl7AyIo0R8u5zR5/xzCBuYxRSTOhDPa9gtnaPi3F1fBBbzpHm1fx3eyPI
	 cy44kz4q9eFeZqNsVjBDSxWu1+nL5p+lMImGO8+SY5vmiwhvQLU7bGwpUbypv+InmE8HO
	 jUmvD1FGna1v6qQD20HFiGYpa5qei8Uk2P4dPrviDiIfGXI2lWC7F0zRar4pIW0ioUg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=KbwACVMX;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794868460;
	bh=UAD5iumUHzHSM5DF5NecwaZT6IG9bQV+JaDguk/gSSI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jpTksEPuVDMZvnDu9dZjJ729KPmq+IvzMQvC6xcnHIUa7BauGJh4cUCwu5Bj48Bka
	 U13gsusVaobaiPQdtTi2olzAtBONq6dTr5nrBXMUG0NzDEcWH8RZljeo9bZPgrOK26
	 R3/93NDv1v1MDXKURFQDvRDCeju6UN1PgZ4L0jt/04+MDTW+jZhc+C8LxlXmcR/gbq
	 S0YXucOuo1NcmZubVSYPyQEzkJe8Ool8AVldbXQVRCJQdNLeSb9wxlnATp3NHT7PhT
	 QfDxCcqQOgWkKkcc+LBr5cL3DWkBH9cyIb8qyZEzTtSJUCeca7khkwmhsAp4+s7KxP
	 g/cjYsBfGYV8Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D7FBE4078E;
	Mon, 16 Nov 2026 22:34:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 765DC1E7
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 22:34:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5C0B34078E
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 22:34:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MpJeIMBKZ5CS for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 22:34:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 407E04078C
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::2b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::2b; helo=mail-oa1-x2b.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=KbwACVMX
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 407E04078C
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 22:34:16 +0000 (UTC)
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-4ad881b6517so3135775fac.2
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 14:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794868456; x=1795473256;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UAD5iumUHzHSM5DF5NecwaZT6IG9bQV+JaDguk/gSSI=;
 b=KbwACVMX4hQFk4PlzhuRGZjXTOk1eQ5RjjYToKuM+/vVlrUdVM2Tkjn3+5mMcC9SNu
 Hrx6omxMJQRL2wC2p0/GmvYnCyoTHRUItzFEIzErtNefcK/HXLX6AR6wZMhtrL7gjcNw
 n4dJN00TBtCqzeqXmsLIhzjnER+Fr8bT7M16NlMWfia1bnbSbl7g5QMzbYWzbkbThjKY
 spo55D7GeTfmTRuLXGnfqYVrLDzy2R19UaikGCB8cDIfK93yD0+6RF2t0h5L7GpFsCNR
 gB+15z0i/D0/ejXMTmjFfNqtBWTfNS51fFCV9HJpBDucfGBztpmqSbugodZCEyAAggqC
 ksvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794868456; x=1795473256;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UAD5iumUHzHSM5DF5NecwaZT6IG9bQV+JaDguk/gSSI=;
 b=Pl2pwGeX62jL4AxWP2yv4uY479juQ0Vn6RsdKkLcukI7LVT6AE+JOpASB7g5jPg3PE
 L8jGmLwNh0/u+mz8h3BZfutdDdKljBCgsfFEjspUO/jHOo2wQIv2Rdkj+mgafbdBGi/o
 U6MZDvoY12YjR+oc4B9JPfV6PgF9IzQ42QhKnU2RCAcXJH/3VABN8OnUXf/kXC1mNKAC
 ZtJMF6Wkrh1byVZn0Q0EAIYOFu1xoJtsxkLFhZmuRyM+PnBlcpfsiM9U5LdkC+WnmQlz
 RO/Onchp35RSS1JyPuZH7Pj+tTSbeYZzv+E01qFmMFHGkH6wKlD1NBmdczZzGJoOw8BF
 xZTA==
X-Gm-Message-State: APuU4Z9K5uF2HBQt5arPYVljlGBE8UjNIEf5g05Spsz8hPxCqK+Qarnc
 uucnwipQOU9FiAYFHHsKQGcROfw8O5GchydDlyJFlMHiXDWeSjfFwVU8hZs9BdstOM8=
X-Gm-Gg: AYBFou31DA7KEA1d/w8ZO++oXe+Kaa3OZ+f7ryM41RMkBoGnQ+TT18xgYGWVZGQBa/o
 k2N4z0k9yJbnCNweQIV5GlZZ+eJ4JKQksjEcIUQm+L85ByXKM0OxI8XFTtmnD0W3m2GXOeB2J3x
 tc7WnonyBEfYlkodOsE0fGve+mTpsH+WwVzB2dOL3VOsGZI265ixIu3ecxj51CNUiRlcuKstmAh
 1MqrCy9tbftIkJYYIy6Fo+zXUGonSvVCMags0Xpg4wSxWP+Kv8im07VF5zN7hb/mZglCPHW1rP+
 OxrHdeZzHSb3fL3jSxK2YBaD0rho8ZUTh9xw2iasoTAOQy7gINjBNCPSSVT8HAWz9ywArSHzd9j
 mo7dWY2mVWIiAjtGLpSKh8aKcu4X4xXoF4RkNUMOaBmC1Zqw5cbs2ZQiPk2y4wELxDdfGSk5LR7
 psx69wQhW7v+mdwwMTstbjHhPIsjya0ylbLYCHSaQWCr0/2VAerr9HPbpYasiMlRJQuwjUjZabc
 oboksSuN/bgADsn+yn5nL2RNeKblFiSdGZPAkOqBrgZTi3Q0mwPntc6Ucfm++wfT26c7xP0Y0ph
 1pLOSsgKFeqBVqYtJy8Lx8odfri85FkcYg==
X-Received: by 2002:a05:6808:6f98:b0:4d5:295c:a82c with SMTP id
 5614622812f47-56e6606b895mr9200863b6e.57.1794868455797; 
 Mon, 16 Nov 2026 14:34:15 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7056:3b5b:7d85:4921])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-56e70c58f9bsm10173280b6e.13.2026.11.16.14.34.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 14:34:15 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 16 Nov 2026 16:32:49 -0600
Subject: [PATCH v3 8/8] doc: board: mediatek: describe the Genio 520 and
 720 DRAM handoff
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-mtk-mt8189-tfa-fdt-v3-8-ca423d2d8038@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5729; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=q1n6XdC5OIbRxt3b1fcSNZNunzmT3L1Mlo8LhCHJIP8=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq+4TFuY9KCEerA4Zn3RTCO2x+Ze7mfCt1j0VOs
 eE4JDZL4G2JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCavuExRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/ADZYIAJnQdcvBvtHF+Nd+TGjgIyBMbw2G+I8GWYAfQCa
 CnAUROdsLtDBBlqoA4cKwi32XDt9xhxn87NaqqVST7IepQ1YXt3dDLX2ytBH1LXsQCekGmAKr5U
 UQ1MwYr4rVbZL8IwsnCvqo5pH4jOLwQqSkjQRYBbWhatG9/6QKg6eEpfz6mJV/H3u2ql9w5nFeM
 E5K26sCTU4tFnPlb2r+NvHd1w75E7iixA1YeUzwGxnVVST2+Or3O7TYniIrJzucgM31nTuyjPrX
 sr5T3OweoKODkOOu8Pl9A4JQJPDXcAWNyr/M4rWxtP3LqQJd2wQ0XyabEk4Jl9Gchf4O7RDyuAb
 87EQ=
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
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Describe how the DDR loader passes the DRAM description to U-Boot in a
transfer list, and add the transfer list to the DDR-loader handoff
contract.

Also state that U-Boot proper started by the platform BL2 now needs a
transfer list with its devicetree.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 doc/board/mediatek/mt8189-genio-evk.rst | 81 ++++++++++++++++++++++++++++++---
 1 file changed, 75 insertions(+), 6 deletions(-)

diff --git a/doc/board/mediatek/mt8189-genio-evk.rst b/doc/board/mediatek/mt8189-genio-evk.rst
index 184085b83c1..be6c9986fa8 100644
--- a/doc/board/mediatek/mt8189-genio-evk.rst
+++ b/doc/board/mediatek/mt8189-genio-evk.rst
@@ -35,8 +35,11 @@ In the usual boot chain, U-Boot provides only U-Boot proper::
      -> U-Boot proper (BL33)
 
 The platform BL2 initializes DRAM and loads BL31, BL32 and BL33. U-Boot proper
-is linked at ``CONFIG_TEXT_BASE``, ``0x4c000000``. It takes the DRAM size from
-the ``memory`` node of its devicetree, which describes 8 GiB of DRAM.
+is linked at ``CONFIG_TEXT_BASE``, ``0x4c000000``.
+
+U-Boot proper requires a transfer list containing its devicetree, and does not
+start without one. The platform BL2 must therefore pass such a transfer list
+to BL33, together with the DRAM description described in `DRAM description`_.
 
 Building
 ~~~~~~~~
@@ -96,12 +99,71 @@ by name.
 Make sure the DIP switches and jumpers are set for eMMC, and use the default
 devicetree.
 
+DRAM description
+~~~~~~~~~~~~~~~~
+
+The DRAM size depends on the DRAM fitted to the board, and so do the regions
+which DRAM initialization reserves for use by the hardware, such as the DRAM
+controller's tracking buffers at the top of each rank. The devicetree built
+into U-Boot cannot describe them, so the DDR loader describes them in a
+devicetree overlay. It passes the overlay to SPL in a `Firmware Handoff`_
+transfer list, which U-Boot reads as its bloblist (see
+:doc:`/develop/bloblist`).
+
+The overlay contains a ``memory`` node with the DRAM size and a ``no-map``
+``reserved-memory`` node for each reserved region. The first compatible string
+of its root node must match the one of the U-Boot devicetree. For example, on
+a Genio 720 EVK with 8 GiB of DRAM::
+
+   /dts-v1/;
+   /plugin/;
+
+   / {
+           compatible = "mediatek,mt8391-evk";
+   };
+
+   &{/} {
+           reserved-memory {
+                   #address-cells = <2>;
+                   #size-cells = <2>;
+                   ranges;
+
+                   dramc-rk0@13fffe000 {
+                           reg = <0x1 0x3fffe000 0x0 0x2000>;
+                           no-map;
+                   };
+
+                   dramc-rk1@23fffe000 {
+                           reg = <0x2 0x3fffe000 0x0 0x2000>;
+                           no-map;
+                   };
+           };
+
+           memory@40000000 {
+                   device_type = "memory";
+                   reg = <0x0 0x40000000 0x2 0x0>;
+           };
+   };
+
+SPL adds the devicetree of U-Boot proper from the FIT to the transfer list and
+passes the list on to U-Boot proper, through the BL33 entry point arguments
+that it gives to BL31. U-Boot proper takes its devicetree from the transfer
+list, applies the overlay to it and passes the reserved regions on to the OS.
+If the transfer list has no room for the devicetree, SPL moves it to a bigger
+buffer, so the DDR loader only needs to make the transfer list big enough for
+its own entries.
+
+SPL stops if the DDR loader does not pass a transfer list with an overlay,
+since U-Boot would otherwise use a DRAM size that may be wrong and would not
+reserve the memory used by the DRAM controller.
+
 DDR-loader handoff contract
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 The contract between the DDR loader and U-Boot SPL consists of a fixed image
-layout, initialized DRAM and the execution state at the SPL entry point. The
-BootROM loads the image payload to ``CONFIG_MTK_GENIO_BROM_LOAD_ADDR``::
+layout, initialized DRAM, a transfer list describing the DRAM, and the
+execution state at the SPL entry point. The BootROM loads the image payload to
+``CONFIG_MTK_GENIO_BROM_LOAD_ADDR``::
 
    offset 0                                     +----------------------+
                                                 | DDR loader           |
@@ -129,10 +191,15 @@ The DDR loader must:
 * copy the complete ``CONFIG_SPL_MAX_SIZE`` byte SPL region from
   ``CONFIG_MTK_GENIO_BROM_LOAD_ADDR + CONFIG_MTK_GENIO_DDR_LOADER_SIZE``
   (``0x20a1000``) to ``CONFIG_SPL_TEXT_BASE``,
+* write the transfer list described in `DRAM description`_ to DRAM outside
+  the SPL region and the memory used by SPL and the images it loads, and
+  outside the memory used by U-Boot proper before relocation, since U-Boot
+  proper uses the list in place until it relocates,
 * leave the MMU and caches disabled, with all of its writes visible to the
   CPU, and
-* enter SPL at ``CONFIG_SPL_TEXT_BASE`` in AArch64 EL3h with exceptions
-  masked.
+* enter SPL at ``CONFIG_SPL_TEXT_BASE`` in AArch64 EL3h with exceptions masked,
+  and with the transfer list in ``x0`` to ``x3`` following the transfer list
+  register convention.
 
 SPL obtains platform information from its embedded control devicetree and
 initializes the console, clocks, pinctrl, watchdog and eMMC through U-Boot
@@ -236,3 +303,5 @@ a prebuilt Genio image for the target board::
 
 Writing an invalid image to eMMC boot0 can make the board unbootable. Preserve
 the platform recovery path while testing.
+
+.. _`Firmware Handoff`: https://github.com/FirmwareHandoff/firmware_handoff

-- 
2.53.0

