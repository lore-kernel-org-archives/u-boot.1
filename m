Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7204F606A333
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 14:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=loChTZW+;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=Ojq+vSxZ
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CF3B780F19;
	Mon, 16 Nov 2026 14:01:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FqmWTVryaElO; Mon, 16 Nov 2026 14:01:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F0D7C80EDC
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794837663;
	b=aHZfuQN0FsEB54sPNXA63TxGaQW138ptWApCAYqGBi8pBM8evbvQsBUZ9pGBSehIFIj8
	 VLSTSj61xQOcdcInUGaKnRCPK1fy82Ok4XAlxbWY6ncfUEQW2oHi3Wi3j3jGNhY99fuTZ
	 DFFIyk4ywZkGk9rEhrCf/3cpWXoGeILcH+2GDcs1aDNBsac8fCa6FxRH3WNIF8mO19DTG
	 xuf6yAeDmwWpv5qT6a+9ORw83Tvn8CgeRkR1ABVQLSVtAkH9D3p+JMaL37lGPw8H02JPl
	 uhGOMdpi2QHAndrz04euRFmYseKjKJntR6mRkTSz8oRHQaovtc1lVge32GNoR9TFWHQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794837663;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=A5HiogpMdEZ8+wFEOZSFr2xI59/87Cz1IvHsmcehGvQ=;
	b=f/mlJQxWthRxC0oIfib+B7pu8/i6BwkVlkfdPTPZvsm4UVoq1mVuBrMYzEDP6NkcXIaf
	 YUZGTC0lzzAV8yba1jrBvTe7sKXgqUtXF6zcCWABl2Y3xOI8nWjWN1xzViPJgnhZnR0hv
	 2TLxMqxJInJR9Vt7W3WmTbjp5KqHgQ1JKzToHCLkj/k/DGH9km+mSZpoAriW646w3qCJ+
	 ayPdwWzLxA/KiUmdcl+c9V0r4UhSOM21wI0mvrHVfONFsBOX0R3mVLKfPmwT/fCKUKPJU
	 dhZ3kNSS+UR/DOzW+YbxscXxfUaB4pUazP4e+pFQnAjsXCpf4ljDUAYJrLbeIDRLTqA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794837663;
	bh=A5HiogpMdEZ8+wFEOZSFr2xI59/87Cz1IvHsmcehGvQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=loChTZW+qBVlHfYOvtTPUU5IQMhRzDgjPIvXL845zTc+Et0dXrUfLR5wlKVKpBxMs
	 6RFyGzP8yIyPr7zgbA6nv+UfsOer+56f3A/C0zgLAbWG/y8chSe2hRYqlws3/2M14j
	 wJULZfVa3u+Xqu5cnnHoebDqeV39SY/TSpCm0E6Ep/J8rvzJKLwQByt+MaHJcyhGvW
	 7PsUVThAPvxC7ANgzGoYp6OfbpV37qWhTAfdNrX90h5fPB/J/XTC9gVStjuYLmyu2U
	 a8BK8TBWU/03+XDHZTVvKw4BdPejvsd7xqJYvNeX25NpADof6r7OTjcgD3hz23cXgL
	 SBfcw6LasbP9A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F0D7C80EDC;
	Mon, 16 Nov 2026 14:01:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id C2E612FE
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 14:01:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B54BB6078A
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 14:01:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gN0dOptRd-QM for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 14:01:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 81A3F6078F
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::62a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62a; helo=mail-ej1-x62a.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=Ojq+vSxZ
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 81A3F6078F
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 14:00:59 +0000 (UTC)
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-c50d3ac6b51so179199166b.1
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 06:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794837657; x=1795442457;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=A5HiogpMdEZ8+wFEOZSFr2xI59/87Cz1IvHsmcehGvQ=;
 b=Ojq+vSxZZF3YZWQ9lR61HjWy4lxTIOzYF1AgrLbJYHhbyA70p94r9s+O24zT1b+6Nt
 kri/zF1Lb1j9V/ypMyqoyviHXCD2Zs2HTy3GYgdrfGSyi/AurINbrS6de59J+gTcUvWr
 M8zNzRTZUzBScA5i7OKTl7Wk9HX9Bfo6oLl6S1jx/dRuKV6v3AGUnNrkLTpgc0wibpwJ
 9jn0qfqMWqPog3M11tjc17wgQSilpfcCy6aly5pc7fycwZmY0ZaKragnoF3v6N6VRCna
 qWLwb+TpE/TpPNPI2zhGZ8nonO8gIBTwwfZeDPJUjCp8mbzhrBDCPwR41zT9wcUAy3p4
 FSGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794837657; x=1795442457;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=A5HiogpMdEZ8+wFEOZSFr2xI59/87Cz1IvHsmcehGvQ=;
 b=x4G2DBgQ8B29wkBI/YJ3iKhhIrF+Vpk2MKnzYd053tm/btzjqV/Njf0E6sbOIYKKME
 Hkhl2+Fr0q4IAUu1xGEP7Am0Q2f3u/LUo14Afab+m4UH3Vdtw+atBgoSuOABvM/Mx7Ak
 WEJBuGhdYkrQ9WAioDvO22rI9EmPtBGHuc3AIBmsWljSPzdvsdWjCTCsvLFNac+41PAv
 V5eXBOsKkZhBS0FgCqvi/OssRouciKw0duNY0HvyJ0U41tKewq72WAhikMhNbB+1uVBA
 KHrEb5Idg+hv9I+lTCufEMp+XLHmiuqfyDsN25Bp2PhVGuwlRqkKYRFMF1P1LXpiNyQ4
 8RxA==
X-Gm-Message-State: APuU4Z+02Dc8o/mZACIN7cGgyLE2EiQ8suCcmQk16GehQz0zMiXKqPzh
 QSvvdGOdmdraSWz0h+Nfbh85y03UtCB5mrAxwtmhOcq+TsiiVsARbFyuU0wd0yRy5A4=
X-Gm-Gg: AYBFou31gBitEdSdiOBTxgKJckUxk5Pc/uV97JifHkvF9jrM/pHqMePRGQPWBiHdoUG
 vzLPSJAYANFU25PYnjej7Axg0ruGKbHcYfNm3M4Ym0/h3qH6MckbO1x0gTKhtXmdd1FuRc4cwwH
 2Nxwk/LWoU5HSOBK3HW6V0dmEgdTJWpBug/WYgMAeRNhStmLbAEws7bjC7hAsZozgG2cMad2MGZ
 Wv3Lp3E8EawOXVlM+yQJw6ovUFxK5/G77hTTvcKDpysckfbDNmN3RsACdIV1F0wIC7xf8ijR8PU
 C21JK3qoaMi1T8uQZhtBwxNAf8u05U7RAYT40Bz9dHqrmBiZ9HXfzJu+NMBtmSZ4CgeUCd4ZX2W
 5eoWaL+dUtIo1ExGSDKZnrwwHaAZrSDUp2WnbvOI6ZLTk58zWUAMN/aNUdLxxN1gnunRuVUzNyy
 FZtdVtJzpI4O43LblaCAAyOa041Ig4298xxYjQFXjn5/JAEPMP8ew3JDnNZ24Ysa8a5yLEDdoiP
 QJketDA7ypp+qYHxU47ygWBFstdigpW8tt1Gutit4EzO7RW/2qkD6qy295sLwPMB7RDKn5JFSj4
 eBj1XwxBYYRb5iymVAbhATPXdz7GjmAUULEaVyK0h04dn4p1/t+NLfccAgoub5KFWN3gyRnuAnc
 S2bhUUo1aBhaxIE/JZvWqIMrnvTMWs7FhWzAZcClo9vvFtQ==
X-Received: by 2002:a17:907:8e88:b0:c3f:8c92:3b54 with SMTP id
 a640c23a62f3a-c507b02df5emr1212036766b.0.1794837657227; 
 Mon, 16 Nov 2026 06:00:57 -0800 (PST)
Received: from macbook.homenet.telecomitalia.it
 (host-95-246-144-141.retail.telecomitalia.it. [95.246.144.141])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c69406640sm22119355f8f.12.2026.11.16.06.00.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 06:00:56 -0800 (PST)
From: Carlo Caione <ccaione@baylibre.com>
Date: Mon, 16 Nov 2026 15:00:47 +0100
Subject: [PATCH v3 1/7] spl: fit: reject failures loading an explicitly
 requested FDT
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-ccaione-upstream-spl-fastboot-boot-v3-1-7b39e7a348c6@baylibre.com>
References: <20261116-ccaione-upstream-spl-fastboot-boot-v3-0-7b39e7a348c6@baylibre.com>
In-Reply-To: <20261116-ccaione-upstream-spl-fastboot-boot-v3-0-7b39e7a348c6@baylibre.com>
To: u-boot@lists.u-boot-project.org, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Sebastian Siewior <bigeasy@linutronix.de>, 
 Rob Herring <robh@kernel.org>, York Sun <york.sun@nxp.com>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Francesco Valla <francesco@valla.it>, 
 Anton Ivanov <anton@binarly.io>, Aristo Chen <aristo.chen@canonical.com>, 
 Carlo Caione <ccaione@baylibre.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Petr Hodina <petr.hodina@protonmail.com>, 
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, 
 Lukasz Majewski <lukma@nabladev.com>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut <marex@nabladev.com>, 
 Michal Simek <michal.simek@amd.com>, Peng Fan <peng.fan@nxp.com>, 
 Daniel Golle <daniel@makrotopia.org>, Sam Day <me@samcday.com>, 
 Pengpeng Hou <pengpeng@iscas.ac.cn>, Alexey Charkov <alchark@flipper.net>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
X-Mailer: b4 0.16.0
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A U-Boot image may embed its device tree, but a FIT which explicitly
names an FDT must not boot after that FDT fails to load or verify.
External FDT data is copied to its load address before verification,
so ignoring the error can leave an unverified device tree for U-Boot.

Keep support for U-Boot images without a separate FDT, but reject
failures for an explicitly requested FDT in both firmware and loadables.

Fixes: d879616e9e64 ("spl: fit: simplify logic for FDT loading for non-OS boots")
Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 common/spl/spl_fit.c  | 16 +++++++++++++---
 test/image/spl_load.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+), 3 deletions(-)

diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index 64e5f95546f..4e47118c022 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -490,12 +490,17 @@ static int spl_fit_append_fdt(struct spl_image_info *spl_image,
 	 */
 	image_info.load_addr = ALIGN(spl_image->load_addr + spl_image->size, 8);
 
+	/* The caller may ignore a missing FDT, so initialize the output. */
+	spl_image->fdt_addr = NULL;
+
 	/* Figure out which device tree the board wants to use */
 	node = spl_fit_get_image_node(ctx, FIT_FDT_PROP, index++);
 	if (node < 0) {
 		size_t size;
 
 		debug("%s: cannot find FDT node\n", __func__);
+		if (fdt_getprop(ctx->fit, ctx->conf_node, FIT_FDT_PROP, NULL))
+			return node;
 
 		/*
 		 * U-Boot did not find a device tree inside the FIT image. Use
@@ -896,6 +901,7 @@ int spl_load_simple_fit(struct spl_image_info *spl_image,
 	int ret;
 	int index = 0;
 	int firmware_node;
+	bool has_fdt;
 
 	ret = spl_simple_fit_read(&ctx, info, offset, fit);
 	if (ret < 0)
@@ -911,6 +917,8 @@ int spl_load_simple_fit(struct spl_image_info *spl_image,
 	if (ret < 0)
 		return ret;
 
+	has_fdt = fdt_getprop(ctx.fit, ctx.conf_node, FIT_FDT_PROP, NULL);
+
 	if (IS_ENABLED(CONFIG_SPL_FPGA))
 		spl_fit_load_fpga(&ctx, info, offset);
 
@@ -958,11 +966,11 @@ int spl_load_simple_fit(struct spl_image_info *spl_image,
 
 	/*
 	 * Booting a next-stage U-Boot may require us to append the FDT.
-	 * We allow this to fail, as the U-Boot image might embed its FDT.
+	 * A U-Boot image may omit it when the FDT is embedded in the binary.
 	 */
 	if (os_takes_devicetree(spl_image->os)) {
 		ret = spl_fit_append_fdt(spl_image, info, offset, &ctx);
-		if (ret < 0 && spl_image->os != IH_OS_U_BOOT)
+		if (ret < 0 && (has_fdt || spl_image->os != IH_OS_U_BOOT))
 			return ret;
 	}
 
@@ -999,7 +1007,9 @@ int spl_load_simple_fit(struct spl_image_info *spl_image,
 			debug("Loadable is %s\n", genimg_get_os_name(os_type));
 
 		if (os_takes_devicetree(os_type)) {
-			spl_fit_append_fdt(&image_info, info, offset, &ctx);
+			ret = spl_fit_append_fdt(&image_info, info, offset, &ctx);
+			if (ret < 0 && has_fdt)
+				return ret;
 			spl_image->fdt_addr = image_info.fdt_addr;
 		}
 
diff --git a/test/image/spl_load.c b/test/image/spl_load.c
index 334ec77b18e..166cf331194 100644
--- a/test/image/spl_load.c
+++ b/test/image/spl_load.c
@@ -367,6 +367,48 @@ SPL_IMG_TEST(spl_test_image, IMX8, 0);
 SPL_IMG_TEST(spl_test_image, FIT_INTERNAL, 0);
 SPL_IMG_TEST(spl_test_image, FIT_EXTERNAL, 0);
 
+static int spl_test_fit_missing_fdt(struct unit_test_state *uts)
+{
+	struct spl_image_info expected = {
+		.name = "missing FDT",
+		.size = SPL_TEST_DATA_SIZE,
+	};
+	struct spl_image_info loaded = {};
+	struct spl_load_info load;
+	size_t size, offset;
+	void *image;
+	int node, ret;
+
+	if (!IS_ENABLED(CONFIG_SPL_LOAD_FIT))
+		return -EAGAIN;
+	size = create_image(NULL, FIT_INTERNAL, &expected, &offset);
+	image = calloc(1, size + 128);
+	ut_assertnonnull(image);
+	generate_data(image + offset, expected.size, expected.name);
+	if (create_image(image, FIT_INTERNAL, &expected, NULL) != size) {
+		ret = -EINVAL;
+		goto out;
+	}
+	ret = fdt_open_into(image, image, size + 128);
+	if (ret)
+		goto out;
+	node = fdt_path_offset(image, "/configurations/config-1");
+	ret = fdt_setprop_string(image, node, FIT_FDT_PROP, "missing");
+	if (ret)
+		goto out;
+	spl_load_init(&load, spl_test_read, image, 1);
+	ret = spl_load_simple_fit(&loaded, &load, 0, image);
+	free(image);
+	ut_assert(ret < 0);
+	return 0;
+out:
+	free(image);
+	ut_assertok(ret);
+	return 0;
+}
+
+SPL_TEST(spl_test_fit_missing_fdt, 0);
+
 /*
  * Build a FIT with external data, overwrite one property of the image node
  * with a hostile value and check that loading fails with the expected error.

-- 
2.56.0

