Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1214A6082BDA
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 09:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ww95RW6Z;
	dkim=pass (1024-bit key, unprotected) header.d=maquefel.me header.i=@maquefel.me header.a=rsa-sha256 header.s=mail header.b=FFqGgqql
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4625740483;
	Tue,  3 Nov 2026 09:53:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2QxXrQiXyyzD; Tue,  3 Nov 2026 09:53:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 279E8405E2
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793699627;
	b=PJ3285mHZRIayHV/Be29PXsqHE2D/+oaUloThI/0WyWHwcOWwvbYQUpR5DBjdkuOquIG
	 0s8SqdAjiUsFVUP7WXnPGLpjDt0wLQz5p13gTxXVJhlOKDkgagEPJ36hPnh7HFFpWsWMN
	 FnGxY8T9HE3fzmSu5ZFfKnlq0AT1Lbc1Xs7lwJNDBS6vZylgRBtBn5NUA0NVzlUnOWh9b
	 VcSgv28PjdeHGpfWuFebUqf7fk5rDzxJAH08WNrM9nlCpezFDekrEGNrUV/s74B6EjK3a
	 +WSfSgc5LK8IMy49RjZs8qt+qMzefrAN1MYfw7vY3YPRY4ucoyN693Q1JPetmw7kwkQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793699627;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:X-Yandex-Fwd:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=qwL8tqaD8QLS0C2uVB04hUiARp4X7WiKl3XPXDIuLFY=;
	b=RrXu6Hyos8ktnfXoeQHyL2TBceecbL4RIK6KTXvSnIHWM/lO1lsR1ELkTRyVWD7OtRSd
	 NROnNnc7wJJ1p3svOU4bAKlcekS4pe5gtwP/SSXqL1Ab8VypgGBkwIsPltcjDxNT8DrAA
	 xcu8UX1lIgDwIJQrbH0j4P9qrmtuvT9fdLf2f6qI3lrzbhHvhhbDeHcT9UqNwr1iqUOJ5
	 Qhb17tO+OrMxk+Rh2LIc/jnlSkgf7Tw/rLK8AToV2IJugmAcuWi/h0AG9UXua3vqQbHLy
	 d20U7Gvxd/dkDD2qmymsilXnINRsBTW/ciJXcLBPB0Fnf7X8xdfp106FHe8UF225qEQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793699626;
	bh=qwL8tqaD8QLS0C2uVB04hUiARp4X7WiKl3XPXDIuLFY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ww95RW6ZcPYpEMPTLjf+rta/4xeoSbHajLTtlBBs4SzdRBa3j/nzbEXg1GgBCmGAs
	 v1f4E9eOWpHZpBYdjJ5ex+KlL50KAqg8KQpe6hTG0qE1FNPlEegm6Ua95rAN9rP9EX
	 BMBuFLQkDxoQALF6pth7CgDTawHqVqNBcUKMUD5emJvpRpPjyqhhyIKFX1Ku93WFe4
	 qapdWXwptD8Yum/x/cWlWAFek83GFT/ePsunvhVjbHSGftJEaYVAANt2MDvpEOQNZt
	 x2ULgTEVIfNKZEDheeztxyQ6/G5FUJitSdmHFBYNbHlRn3kS1oTOzZpucgbWlrrKWz
	 mMeq1CSViLaUw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 279E8405E2;
	Tue,  3 Nov 2026 09:53:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id CD817D3A
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:53:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BFA2C40080
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:53:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D6lwyPkwi2bW for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 09:53:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 1191B4005E
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2a02:6b8:c0e:500:1:45:d181:d105"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793699623;
 b=JP+Ew0N2PxrystnKKii5cS+CElLTPTpwqFQlhjbThpVsJt8L+8ib1+Jy1HzGb7YoikOF
 QPjD1FHvlV/kebuDsf9hJ5U3EVDzip/pv7MEqy2twlCOXG5LktHc7DH+1aPpPo1jEHmwk
 W2uA0Z6k/aB3gdFM1/8RcwWxh5zOt8D7P9i9RmMeGqaEoLLSDmVbDKtDgMearVQq4dt1C
 sZ3z898qi1OGfP7AosPUeDF2OqeoV/fYiLCNF8dqlMGfgSI+PSopT9of57DMGW3jM6GxE
 WlU3C6IBaiY7JqSpRDUX4jkoAYTgadSSiYJ5VnzpfOTGl3RhLKlSSRrJJVHWEtKzmbg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793699623;
 h=Received-SPF:Received:Received:X-Yandex-Fwd:DKIM-Signature:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=qwL8tqaD8QLS0C2uVB04hUiARp4X7WiKl3XPXDIuLFY=;
 b=NRsrqKj1PtVHrq5eYhZpbcGRG9u1C0RVxa0yO2jAB9gBT+9IqComgGCia4nxKM2XqJ0j
 2tF1FpWpj+gE/Bv+kDbBq/2y8MIvycxzbAr8zpNJSDtoBHPnwBmJuLbYJ9Ihaj589D9ES
 2xDCnnB5tyfFiPlQUI+8pGf5bDRaWLyfoneIIP1g3/QBSQa+JfRtjFdzunpK2lp/qzgAy
 3nNOS/cxITdbIGKk29iCTOy/aOyD8QTkdFwHj9cPeiZ5SlI3Wixf9908KCY4y1jdmyJLN
 EVTZddmUM4NSVqQjSWSssfFmwD3pT+VaAmZtE2EHfX5c9nPTAiAW0qNSAYa6Vr22S/w==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=maquefel.me;
 dkim=pass header.d=maquefel.me header.i=@maquefel.me header.a=rsa-sha256
 header.s=mail header.b=FFqGgqql; 
 arc=none smtp.remote-ip="2a02:6b8:c0e:500:1:45:d181:d105"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a02:6b8:c0e:500:1:45:d181:d105; helo=forward105a.mail.yandex.net;
 envelope-from=nikita.shubin@maquefel.me; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=maquefel.me
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=maquefel.me header.i=@maquefel.me header.a=rsa-sha256
 header.s=mail header.b=FFqGgqql
Received: from forward105a.mail.yandex.net (forward105a.mail.yandex.net
 [IPv6:2a02:6b8:c0e:500:1:45:d181:d105])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1191B4005E
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:53:42 +0000 (UTC)
Received: from mail-nwsmtp-smtp-production-main-70
 (mail-nwsmtp-smtp-production-main-70.yp-c.yandex.net)
 by forward105a.mail.yandex.net (postfix) with ESMTPS id C1381147E4D;
 Tue, 03 Nov 2026 12:53:35 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-70 with ESMTPSA id
 OrH94I7pRiE0-mPqDy9md; Tue, 03 Nov 2026 12:53:35 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
 t=1793699615; bh=qwL8tqaD8QLS0C2uVB04hUiARp4X7WiKl3XPXDIuLFY=;
 h=Cc:In-Reply-To:Message-Id:To:Date:References:From:Subject;
 b=FFqGgqqlH+YwG7m3dFzsdGYx9Rdsi+IeRuQeyCHNXO/YuqLziYD2Yank0KIYxRCbR
 69SQ0Yf13ZKKseUiD7hGJ3MK9mX08zml7P4eB36GURDC/OPpl9ZtwZtJ7KMt8bmjBd
 hT1H6Vidf+g875Tf38AxPe8I0sLD5mBTdv5UwQTQ=
Authentication-Results: mail-nwsmtp-smtp-production-main-70;
 dkim=pass header.i=@maquefel.me
From: Nikita Shubin <nikita.shubin@maquefel.me>
Date: Tue, 03 Nov 2026 12:53:05 +0300
Subject: [PATCH v3 6/6] spl: fit: Add test to check loadables
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-riscv-full-fit-support-v3-6-e1dcdc9638e5@maquefel.me>
References: <20261103-riscv-full-fit-support-v3-0-e1dcdc9638e5@maquefel.me>
In-Reply-To: <20261103-riscv-full-fit-support-v3-0-e1dcdc9638e5@maquefel.me>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Daniel Golle <daniel@makrotopia.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>, 
 Nikita Shubin <nikita.shubin@maquefel.me>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793699606; l=6572;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=o0aGTB21AjytsF22cTS9OUj5CfWSSJVoMTq/R2Umm74=;
 b=NRyE1fdct2nAx+0udfR6JAZ7cums7igjT/cNdwOkiuXCb0Rg7Lz1Vrx/DuZ1NP4udLYLElies
 ZelzmFN1jxLDaoya+DMmMa/RdZ7I3fIeLhycUlaet/Cy88nYMBDU95/
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
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
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add spl_test_firmware_image() to check loadables correctly provided by
spl_load_fit_image().

We create special image with U-Boot, firmware and empty dtb. Then invoke
spl_load_fit_image(), check everything (including dtb) loaded correctly
and then check if loaded dtb contains "/fit-images/u-boot".

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 test/image/spl_load.c | 185 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 185 insertions(+)

diff --git a/test/image/spl_load.c b/test/image/spl_load.c
index 334ec77b18e..e6ec4c6e764 100644
--- a/test/image/spl_load.c
+++ b/test/image/spl_load.c
@@ -275,6 +275,191 @@ size_t create_image(void *dst, enum spl_test_image type,
 	return 0;
 }
 
+static int append_fit_node(void *fdt, const char *node_name, const char *type_str,
+			   size_t data_offset, struct spl_image_info *image)
+{
+	if (fdt_begin_node(fdt, node_name))
+		return -1;
+	if (fdt_property_u32(fdt, FIT_DATA_OFFSET_PROP, data_offset))
+		return -1;
+	if (fdt_property_string(fdt, FIT_DESC_PROP, image->name))
+		return -1;
+	if (fdt_property_string(fdt, FIT_TYPE_PROP, type_str))
+		return -1;
+	if (fdt_property_string(fdt, FIT_COMP_PROP, "none"))
+		return -1;
+	if (fdt_property_u32(fdt, FIT_DATA_SIZE_PROP, image->size))
+		return -1;
+	if (fdt_property_string(fdt, FIT_OS_PROP,
+				genimg_get_os_short_name(image->os)))
+		return -1;
+	if (fdt_property_string(fdt, FIT_ARCH_PROP,
+				genimg_get_arch_short_name(IH_ARCH_DEFAULT)))
+		return -1;
+	if (fdt_property_addr(fdt, FIT_ENTRY_PROP, image->entry_point))
+		return -1;
+	if (fdt_property_addr(fdt, FIT_LOAD_PROP, image->load_addr))
+		return -1;
+	if (fdt_end_node(fdt))
+		return -1;
+	return 0;
+}
+
+static size_t create_firmware_fit(void *dst, struct spl_image_info *uboot_image,
+				  struct spl_image_info *opensbi_image, ulong fdt_load_addr,
+				  size_t *data_offset)
+{
+	size_t prop_size = 1168;
+	size_t total_size = prop_size + uboot_image->size + opensbi_image->size;
+	size_t size = prop_size;
+	size_t fdt_size;
+	char tmp[256];
+	void *fdt;
+
+	if (data_offset)
+		*data_offset = size;
+
+	if (!dst)
+		goto out;
+
+	if (fdt_create(dst, size))
+		return 0;
+	if (fdt_finish_reservemap(dst))
+		return 0;
+	if (fdt_begin_node(dst, ""))
+		return 0;
+	if (fdt_property_u32(dst, FIT_TIMESTAMP_PROP, 0))
+		return 0;
+	if (fdt_property_u32(dst, "#address-cells", ADDRESS_CELLS))
+		return 0;
+	if (fdt_property_string(dst, FIT_DESC_PROP, ""))
+		return 0;
+	if (fdt_begin_node(dst, "images"))
+		return 0;
+
+	/* u-boot image node */
+	if (append_fit_node(dst, "u-boot", "standalone", 0, uboot_image))
+		return 0;
+
+	/* opensbi image node */
+	if (append_fit_node(dst, "opensbi", "firmware", uboot_image->size, opensbi_image))
+		return 0;
+
+	/* generate empty dtb */
+	if (fdt_create_empty_tree(&tmp, sizeof(tmp)))
+		return 0;
+	fdt_size = fdt_totalsize(tmp);
+
+	/* empty fdt node */
+	if (fdt_begin_node(dst, "fdt-1"))
+		return 0;
+	if (fdt_property_string(dst, FIT_TYPE_PROP, "flat_dt"))
+		return 0;
+	if (fdt_property_string(dst, FIT_COMP_PROP, "none"))
+		return 0;
+
+	if (fdt_property_addr(dst, FIT_LOAD_PROP, fdt_load_addr))
+		return 0;
+
+	if (fdt_property_placeholder(dst, FIT_DATA_PROP, fdt_size, &fdt))
+		return 0;
+
+	memcpy(fdt, tmp, fdt_size);
+	if (fdt_end_node(dst)) /* fdt-1 */
+		return 0;
+
+	if (fdt_end_node(dst)) /* images */
+		return 0;
+
+	/* configurations node */
+	if (fdt_begin_node(dst, "configurations"))
+		return 0;
+	if (fdt_property_string(dst, FIT_DEFAULT_PROP, "config-1"))
+		return 0;
+	if (fdt_begin_node(dst, "config-1"))
+		return 0;
+	if (fdt_property_string(dst, FIT_DESC_PROP, opensbi_image->name))
+		return 0;
+	if (fdt_property_string(dst, FIT_FIRMWARE_PROP, "opensbi"))
+		return 0;
+	if (fdt_property_string(dst, FIT_LOADABLE_PROP, "u-boot"))
+		return 0;
+	if (fdt_property_string(dst, FIT_FDT_PROP, "fdt-1"))
+		return 0;
+	if (fdt_end_node(dst)) /* config-1 */
+		return 0;
+	if (fdt_end_node(dst)) /* configurations */
+		return 0;
+	if (fdt_end_node(dst)) /* root */
+		return 0;
+	if (fdt_finish(dst))
+		return 0;
+
+	if (fdt_totalsize(dst) > size)
+		return 0;
+
+	fdt_set_totalsize(dst, size);
+
+out:
+	return total_size;
+}
+
+static int spl_test_firmware_image(struct unit_test_state *uts)
+{
+	size_t img_size, img_data, data_size = SPL_TEST_DATA_SIZE;
+	ulong uboot_load_addr = CONFIG_TEXT_BASE;
+	ulong firmware_load_addr = ALIGN(uboot_load_addr + data_size, 4096);
+	ulong fdt_load_addr = ALIGN(firmware_load_addr + data_size, 8);
+	struct spl_image_info info_uboot = {
+		.name = "U-Boot",
+		.os = IH_OS_U_BOOT,
+		.size = data_size,
+		.load_addr = CONFIG_TEXT_BASE,
+	}, info_firmware = {
+		.name = "RISC-V OpenSBI",
+		.os = IH_OS_OPENSBI,
+		.size = data_size,
+		.load_addr = firmware_load_addr,
+		.entry_point = firmware_load_addr,
+		.flags = SPL_FIT_FOUND,
+	}, info_read = { };
+	char *data_uboot, *data_firmware;
+	ulong check_addr;
+	int noffset;
+	void *img;
+
+	img_size = create_firmware_fit(NULL, &info_uboot, &info_firmware, fdt_load_addr,
+				       &img_data);
+	ut_assert(img_size);
+	img = calloc(img_size, 1);
+	ut_assertnonnull(img);
+
+	data_uboot = img + img_data;
+	generate_data(data_uboot, data_size, "uboot_image");
+	data_firmware = data_uboot + info_uboot.size;
+	generate_data(data_firmware, info_firmware.size, "firmware_image");
+	ut_asserteq(img_size, create_firmware_fit(img, &info_uboot,
+						  &info_firmware,
+						  fdt_load_addr, NULL));
+	ut_assertok(spl_load_fit_image(&info_read, img));
+	if (check_image_info(uts, &info_firmware, &info_read))
+		return CMD_RET_FAILURE;
+	ut_asserteq_mem(data_uboot, phys_to_virt(info_uboot.load_addr), info_uboot.size);
+	ut_asserteq_mem(data_firmware, phys_to_virt(info_read.load_addr), info_read.size);
+
+	/* check loadable and load address recorded successfully in empty dtb */
+	noffset = fdt_path_offset(phys_to_virt(fdt_load_addr), "/fit-images/u-boot");
+	ut_assert(noffset > 0);
+
+	ut_assertok(fit_image_get_load(phys_to_virt(fdt_load_addr), noffset, &check_addr));
+	ut_asserteq(uboot_load_addr, check_addr);
+
+	free(img);
+	return 0;
+}
+
+SPL_TEST(spl_test_firmware_image, 0);
+
 int check_image_info(struct unit_test_state *uts, struct spl_image_info *info1,
 		     struct spl_image_info *info2)
 {

-- 
2.55.0

