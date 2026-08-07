Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97827C5AC7C
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 08:14:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5D5E760690;
	Fri,  7 Aug 2026 08:14:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6JcSn7uctkod; Fri,  7 Aug 2026 08:14:06 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 560FB608BB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786090446;
	bh=U0hU71nqlqe5dBVzVK0z6NWmVbFwV6MiYhpeg++byg4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=K/qTeymKH+KjfP392uQD65iUadQ9vIW5P6t7XyQpQIkQYYvdS840Z0oOZ/nThHXQc
	 GauW6RSTXBl6/nBsnT6WMfVNJoReuVS3p9qxHj6ABvHDKhvOavHsKnug14opGzLfY9
	 yET6viAToutmWD5ITFrhhBmOSncGgFKrAdX0v4yQq5Qs+qImE/1HlBJ0gqqBW3cOPA
	 5ioKv1+ONFHcKEMX90bDbZeTYfH1EG7GNdSc8zO5q6wFa1kGk9lS9yXo3f7tvMDJoU
	 VgClgaeeGwCRo4hulxOnvGkX3fZ5KLhud/wZHued2+ENI2quMtm2ljHBwL4IlPYEFM
	 //mOFxW5e3Fxw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 560FB608BB;
	Fri,  7 Aug 2026 08:14:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5E70A397
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 08:14:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 44BE5811D3
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 08:14:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 10Y34ib51fFI for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 08:14:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a02:6b8:c02:900:1:45:d181:d202; helo=forward202b.mail.yandex.net;
 envelope-from=nikita.shubin@maquefel.me; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 5E85B811D4
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5E85B811D4
Received: from forward202b.mail.yandex.net (forward202b.mail.yandex.net
 [IPv6:2a02:6b8:c02:900:1:45:d181:d202])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5E85B811D4
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 08:14:01 +0000 (UTC)
Received: from forward102b.mail.yandex.net (forward102b.mail.yandex.net
 [IPv6:2a02:6b8:c02:900:1:45:d181:d102])
 by forward202b.mail.yandex.net (postfix) with ESMTPS id 05DECC408F
 for <u-boot@lists.u-boot-project.org>; Fri, 07 Aug 2026 11:06:38 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-89.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-89.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c11:2281:0:640:870e:0])
 by forward102b.mail.yandex.net (postfix) with ESMTPS id 9C649C007B;
 Fri, 07 Aug 2026 11:06:31 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-89.sas.yp-c.yandex.net (smtp)
 with ESMTPSA id L6FKBuIeKuQ0-HhRSpZUO; 
 Fri, 07 Aug 2026 11:06:31 +0300
X-Yandex-Fwd: 1
From: Nikita Shubin <nikita.shubin@maquefel.me>
Date: Fri, 07 Aug 2026 11:06:42 +0300
Subject: [PATCH 5/5] spl: fit: Add test to check loadables
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-riscv-full-fit-support-v1-5-21a34f79c350@maquefel.me>
References: <20260807-riscv-full-fit-support-v1-0-21a34f79c350@maquefel.me>
In-Reply-To: <20260807-riscv-full-fit-support-v1-0-21a34f79c350@maquefel.me>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Daniel Golle <daniel@makrotopia.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Francesco Valla <francesco@valla.it>, 
 Nikita Shubin <nikita.shubin@maquefel.me>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786089998; l=7011;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=JMyZ7RK7fpHYl+XLJsYN4lNOj9NQC7iwSVLMm94zDac=;
 b=evE4LdprhjFRtzBKNKzeEInwdvYY3w2IdhOkKUwik0/ohAKc+ZErTdQpo/kEi8ljMlknRx+ll
 PDBHkm2S+5XCGxENIqXusYjURBIjFJKWHU2SJo4cNLfJfsJvn+4pjdc
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=maquefel.me; s=mail; 
 t=1786089991; bh=U0hU71nqlqe5dBVzVK0z6NWmVbFwV6MiYhpeg++byg4=;
 h=Cc:In-Reply-To:Message-Id:To:Date:References:From:Subject;
 b=AtOqqYM6zoiuMp/Vfej3lic23cx0fbaQsNnZWn8gL+jm1rfTat6HL+vt56W5iWAFd
 26U1oMIDYg2mzxbd5XGZLafgBMFVrw4lGYddGi9BWjCmEgFNfHAe28QQRGn6WaT6x0
 i4N565fbTpEmDSL991RFnWWxlShqN8uL83HA9pl8=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=maquefel.me
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=maquefel.me header.i=@maquefel.me
 header.a=rsa-sha256 header.s=mail header.b=AtOqqYM6
X-Mailman-Original-Authentication-Results: mail-nwsmtp-smtp-production-main-89.sas.yp-c.yandex.net;
 dkim=pass header.i=@maquefel.me
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Add spl_test_firmware_image() to check lodables correctly provided by
spl_load_fit_image().

We create special image with U-Boot, firmware and empty dtb. Then invoke
spl_load_fit_image(), check everything (including dtb) loaded correctly
and then check if loaded dtb contains "/fit-images/u-boot".

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 test/image/spl_load.c | 195 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 195 insertions(+)

diff --git a/test/image/spl_load.c b/test/image/spl_load.c
index c43c977f784..314795e2506 100644
--- a/test/image/spl_load.c
+++ b/test/image/spl_load.c
@@ -275,6 +275,201 @@ size_t create_image(void *dst, enum spl_test_image type,
 	return 0;
 }
 
+static size_t create_firmware_fit(void *dst, struct spl_image_info *uboot_image,
+							struct spl_image_info *opensbi_image, ulong fdt_load_addr,
+							size_t *data_offset)
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
+	if (fdt_property_u32(dst, "#address-cells", 2))
+		return 0;
+	if (fdt_property_string(dst, FIT_DESC_PROP, ""))
+		return 0;
+	if (fdt_begin_node(dst, "images"))
+		return 0;
+
+	/* u-boot image node */
+	if (fdt_begin_node(dst, "u-boot"))
+		return 0;
+	if (fdt_property_u32(dst, FIT_DATA_OFFSET_PROP, 0))
+		return 0;
+	if (fdt_property_string(dst, FIT_DESC_PROP, uboot_image->name))
+		return 0;
+	if (fdt_property_string(dst, FIT_TYPE_PROP, "standalone"))
+		return 0;
+	if (fdt_property_string(dst, FIT_COMP_PROP, "none"))
+		return 0;
+	if (fdt_property_u32(dst, FIT_DATA_SIZE_PROP, uboot_image->size))
+		return 0;
+	if (fdt_property_string(dst, FIT_OS_PROP,
+				genimg_get_os_short_name(uboot_image->os)))
+		return 0;
+	if (fdt_property_string(dst, FIT_ARCH_PROP,
+				genimg_get_arch_short_name(IH_ARCH_DEFAULT)))
+		return 0;
+	if (fdt_property_u64(dst, FIT_ENTRY_PROP, uboot_image->entry_point))
+		return 0;
+	if (fdt_property_u64(dst, FIT_LOAD_PROP, uboot_image->load_addr))
+		return 0;
+	if (fdt_end_node(dst))
+		return 0;
+
+	/* opensbi image node */
+	if (fdt_begin_node(dst, "opensbi"))
+		return 0;
+	if (fdt_property_u32(dst, FIT_DATA_OFFSET_PROP, uboot_image->size))
+		return 0;
+	if (fdt_property_string(dst, FIT_DESC_PROP, opensbi_image->name))
+		return 0;
+	if (fdt_property_string(dst, FIT_TYPE_PROP, "firmware"))
+		return 0;
+	if (fdt_property_string(dst, FIT_COMP_PROP, "none"))
+		return 0;
+	if (fdt_property_u32(dst, FIT_DATA_SIZE_PROP, opensbi_image->size))
+		return 0;
+	if (fdt_property_string(dst, FIT_OS_PROP,
+				genimg_get_os_short_name(opensbi_image->os)))
+		return 0;
+	if (fdt_property_string(dst, FIT_ARCH_PROP,
+				genimg_get_arch_short_name(IH_ARCH_DEFAULT)))
+		return 0;
+	if (fdt_property_u64(dst, FIT_ENTRY_PROP, opensbi_image->entry_point))
+		return 0;
+	if (fdt_property_u64(dst, FIT_LOAD_PROP, opensbi_image->load_addr))
+		return 0;
+	if (fdt_end_node(dst)) /* opensbi */
+		return 0;
+
+	/* generate empty dtb */
+
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
+	if (fdt_property_u64(dst, FIT_LOAD_PROP, fdt_load_addr))
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
+	const char *uname;
+	ulong check_addr;
+	char str[100];
+	int noffset;
+	void *img;
+
+	img_size = create_firmware_fit(NULL, &info_uboot, &info_firmware, fdt_load_addr,
+								   &img_data);
+	ut_assert(img_size);
+	img = calloc(img_size, 1);
+	ut_assertnonnull(img);
+
+	data_uboot = img + img_data;
+	generate_data(data_uboot, data_size, "uboot_image");
+	data_firmware = data_uboot + info_uboot.size;
+	generate_data(data_firmware, info_firmware.size, "firmware_image");
+	ut_asserteq(img_size, create_firmware_fit(img, &info_uboot, &info_firmware, fdt_load_addr,
+				NULL));
+	ut_assertok(spl_load_fit_image(&info_read, img));
+	if (check_image_info(uts, &info_firmware, &info_read))
+		return CMD_RET_FAILURE;
+	ut_asserteq_mem(data_uboot, phys_to_virt(info_uboot.load_addr), info_uboot.size);
+	ut_asserteq_mem(data_firmware, phys_to_virt(info_read.load_addr), info_read.size);
+
+	/* check loadable and load address recorded successfully in empty dtb */
+	noffset = fdt_path_offset(phys_to_virt(fdt_load_addr), "/fit-images/u-boot");
+	ut_assert(noffset);
+
+	ut_assertok(fit_image_get_load(phys_to_virt(fdt_load_addr), noffset, &check_addr));
+	ut_asserteq(uboot_load_addr, check_addr);
+
+	free(img);
+	return 0;
+}
+SPL_TEST(spl_test_firmware_image, 0);
+
 int check_image_info(struct unit_test_state *uts, struct spl_image_info *info1,
 		     struct spl_image_info *info2)
 {

-- 
2.52.0

