Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87037C61DFD
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 06:31:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4ED5080E5D;
	Wed,  2 Sep 2026 06:31:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hryUd23xHlKx; Wed,  2 Sep 2026 06:31:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788330698;
	bh=/WjBr1eJdbU6BLEBhVe59wkMQow5GNHN1fYJMxtfM/s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ugd+vVoYhriUglp+UCy2631GeQXgXJ6/onzglzTes8khwY84bI6nvKrysCDheR3eh
	 K37wrIN7+svouKmQc4BAUVhj8P52xZlJj9Ai5dwKNUYEppwxbgbBnRP0WyrRI3Tj9l
	 YSi9dWDkrQfUk0REgyk3+qepS0vtyPj/uNFo9MAXplSwXzyZpba32VBkQaUhydLjx4
	 y2ZQONT3GuoAkfswrzaOBytfpsB7Dr3WrAZqiJ3/JjVycD+ZBkB1OoPpu0dRvQj1XB
	 kz/GWnVIv5JU8TOCPCgMNF3bwivzY2K4Elwtd+vq65gyueynKL9Fi1Tj9zA2rZ69U2
	 XgFEuvEcLC8hQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 560BD80E81;
	Wed,  2 Sep 2026 06:31:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 910244AD
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 06:31:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 778074005C
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 06:31:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id E0Wkhs9WrqTV for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 06:31:35 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.154.239.91;
 helo=forward202a.mail.yandex.net; envelope-from=nikita.shubin@maquefel.me;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=maquefel.me
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=maquefel.me header.i=@maquefel.me header.a=rsa-sha256
 header.s=mail header.b=BYbE4PaC
Received: from forward202a.mail.yandex.net (forward202a.mail.yandex.net
 [178.154.239.91])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 90516400D5
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 06:31:35 +0000 (UTC)
Received: from forward101a.mail.yandex.net (forward101a.mail.yandex.net
 [IPv6:2a02:6b8:c0e:500:1:45:d181:d101])
 by forward202a.mail.yandex.net (postfix) with ESMTPS id CA16C8717F
 for <u-boot@lists.u-boot-project.org>; Wed, 02 Sep 2026 09:31:25 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-54.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-54.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c17:2010:0:640:2180:0])
 by forward101a.mail.yandex.net (postfix) with ESMTPS id D44F580C80;
 Wed, 02 Sep 2026 09:31:16 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-54.vla.yp-c.yandex.net (smtp)
 with ESMTPSA id 9VdE69DeMiE0-L1GtKsaY; 
 Wed, 02 Sep 2026 09:31:16 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
 t=1788330676; bh=/WjBr1eJdbU6BLEBhVe59wkMQow5GNHN1fYJMxtfM/s=;
 h=Cc:In-Reply-To:Message-Id:To:Date:References:From:Subject;
 b=BYbE4PaC4Lefx+CF2MRNBVGVjCsIABBZwdm7UhV36CSjalDAdZUPHJAegigA963bg
 XJRy5lVufdPVk5TNPWHNaPQHYwcPOsAFvQsH8HPx/J8ZsAq3AK6/IRjQEQQiinY6Hq
 hP/Lar4PMYkNfig/hMVXgNUXT4CWm3YEAEh3SCVc=
Authentication-Results: mail-nwsmtp-smtp-production-main-54.vla.yp-c.yandex.net;
 dkim=pass header.i=@maquefel.me
From: Nikita Shubin <nikita.shubin@maquefel.me>
Date: Wed, 02 Sep 2026 09:31:16 +0300
Subject: [PATCH v2 6/6] spl: fit: Add test to check loadables
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-riscv-full-fit-support-v2-6-493e904a129e@maquefel.me>
References: <20260902-riscv-full-fit-support-v2-0-493e904a129e@maquefel.me>
In-Reply-To: <20260902-riscv-full-fit-support-v2-0-493e904a129e@maquefel.me>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Daniel Golle <daniel@makrotopia.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>, 
 Nikita Shubin <nikita.shubin@maquefel.me>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788330671; l=6515;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=qoIaHq6HJ/o0/KFRx5ttfb+NLklL+q49xZ9hbezvwxA=;
 b=XsbBdqDjGWLzI2ev1nPXEPVGA3qtz6lzD4A+ftchuAz6x9jstiLra9d1WAAAuaywUTKdVSJjS
 2yI4sHZwqieDrdV+SwpNSEnzuyEZAJolIa8Oil+IkDAuzvu8nlSpoRr
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
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

Add spl_test_firmware_image() to check loadables correctly provided by
spl_load_fit_image().

We create special image with U-Boot, firmware and empty dtb. Then invoke
spl_load_fit_image(), check everything (including dtb) loaded correctly
and then check if loaded dtb contains "/fit-images/u-boot".

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 test/image/spl_load.c | 184 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 184 insertions(+)

diff --git a/test/image/spl_load.c b/test/image/spl_load.c
index c43c977f784..9d4f36c61c1 100644
--- a/test/image/spl_load.c
+++ b/test/image/spl_load.c
@@ -275,6 +275,190 @@ size_t create_image(void *dst, enum spl_test_image type,
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
+	ut_asserteq(img_size, create_firmware_fit(img, &info_uboot, &info_firmware, fdt_load_addr,
+		    NULL));
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
2.54.0

