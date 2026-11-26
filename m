Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE84606A338
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 13:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=hqe2zU5j;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o4A4lF1G
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4096D40A10;
	Thu, 26 Nov 2026 13:33:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H2-WwlLKLBAL; Thu, 26 Nov 2026 13:33:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4267E40A02
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795700024;
	b=Efk63BZyIfB2IV3WcqoZyXIkQC5lcR5Wa5eFgRVWNteItdv8SZzi3O7eubZMLOrQteGN
	 X5XMFtoXhNZCLZ519wi4fT/e8eRZJsr5C6vA6qPvxB0ZLq8nfRJvmINufXiG5ieNZzBQ4
	 f9V3WEKpf7tJelE7LSRoWXbFzVeO01DgO9wvo5eiWFIg9V/a44uWZ0z2ykgQMdNfrD+DB
	 eRglzm/Ta3YEASo4QO4sqDJBamo37lALbPnI+O/zw1DwqCn6SGnnUBfobCLBSFV5Y7NcR
	 Ar443RBf3YQk+2Jb+Z+9t6g/68ZDT87gieK4n/IEGgwAQlfgJhWEXwKMqxA71+VL90A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795700024;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=JTKMc/P8YLysIXyOXpRrE33p+J6dqWj9VcZ4/RxYcpA=;
	b=hq17hWQa34c5jx2NBiYGKeKNI/7Re/lBcuLcXzeAk1oRuskwIH+Bg2NI+L7+fJxdmY01
	 GO8WJNgFzU0p+BSDEO7pzwMp+UYvWS+xJ5F6s+UzDaRR7DA+J9iE3rc8+10u1Fg0cO78E
	 gK5YexM07s9PUJS764uJDUd12CBCfbkngr5GF7eelINidpjLLgvo5vnB5eBTXDZJ6WxcO
	 OUXBUypq8pImoS/Ta3lzSkOZMBAfj1BuPYAZBnmdwzhzztv2r9vilYO4vK8JNnYelt76o
	 Zip+h5NMVkaWRBY457LG6l0o/0RBnjlLub7WVAnpw/FBHXGUGLjB6aYZAHn6x9UF6Mg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o4A4lF1G;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795700024;
	bh=JTKMc/P8YLysIXyOXpRrE33p+J6dqWj9VcZ4/RxYcpA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hqe2zU5jH0fYQi6m5YxQA6hKaeMJQETvW2JHHa0wZTO0XddpM+Tuz2SxYl28ni0c4
	 gQMLRU61/hb7henrXG1QWWUW4v5k3j+VhXELlxt3llBJrLF8snUEtMel81J7Li4FAo
	 2T2z5iTiqsf4vRdusKYVB90eQdbSsJykB6vs+pjr0VR3jKdoCwEjjAW6+L/cxCahPW
	 ujcA7w3drB7n48FvrWt/Bp0FVhHA/C6HcxbLeCZSsQq5eQ/i7imtimNLg04f3tG2ty
	 aa9CbU5Tj6X7FmpcGGxuyGtRTH98O3R9uNpfMWUJmXDeh86j5ftSa/CzYCsUNUyNeR
	 d8NeaenGMESYg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4267E40A02;
	Thu, 26 Nov 2026 13:33:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5DAC222B
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 06:53:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 43B1B4079A
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 06:53:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ILLXxIWJugzH for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 06:53:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6F76A405C8
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::331"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::331; helo=mail-ot1-x331.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=o4A4lF1G
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6F76A405C8
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 06:53:35 +0000 (UTC)
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-843b6f8e2c7so6705851a34.1
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 22:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795676015; x=1796280815;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JTKMc/P8YLysIXyOXpRrE33p+J6dqWj9VcZ4/RxYcpA=;
 b=o4A4lF1GSiGpU5KegtfAvynuJTI9BwdxGDgVW6g7ON9nH7jGs1Z8horNftoAbPTCJz
 nV/nd2QG9V1yWkKlhFVwMcAaPU3Hd9zGjTQtqyZ3M2J0g2szZUnjV70wTAEqBp0am2v/
 xOEK+ueRMa5pDlKZoXd70jMVIx+g9jjlvkQyQbnGxgMhXGol4aCDGHq1H9Td2kB+023U
 i2xz/nEaSkB2HxoO3wpR44YftCgdEJju4L/528QhqNNmJJvSFs6dfxOf7gwqSsTYuP2J
 WMN+t/roY0vX6szdQroYepKuxnqAI/w7gtphjCnf3H2arlQNCxlJXd7Jr8Lc0ObmwDdY
 PkLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795676015; x=1796280815;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JTKMc/P8YLysIXyOXpRrE33p+J6dqWj9VcZ4/RxYcpA=;
 b=igOSHsIzvxxYwAXCh47imIxci6GBHjJbGVvh2dwH7YQkEbZu56vQuwRfUMazjZUxox
 CL1fM/9GI/XNffPiNgSbzIOcCOxlrUumiBPToYhm+5LG49QQEUSrNzji5jxRRryRNVEZ
 bEDsYnZUp6eBxmO2M+rR/M/+fbIPIJeDlj653SVbBMHsemPhdIPiaWeuk7bBqIQqGhws
 4XSMT6sA5FlZ/7K7x9dN8A/4J3H1HN4lE6tltYRnUGElX7FUoUQIY5FSeNbFTET39h20
 noafoDJnNi6OSPDpYomIR+rSnbAe7omeBWMpdFe8vJMe+FlpDonXOvEAVYg0qhY1JK3v
 pg8Q==
X-Gm-Message-State: APuU4Z+pPgSBHwnGT1wJ+Az0DAxGGAXAVacqq6vFlmSsDM/YE/27w1KW
 74r6dqowHMaLAWt5Zj+To11YtOszlZHz8p2h6N6TbJbjxJG2lKlbwyBN
X-Gm-Gg: AZFdTZfALejmg6E2H9xmg3UfNsZLGmyWG/1I/JLreFXvYlaADl2q8DzhJSU9t3xKlvS
 hcPB7OwlkIbAGEyFkm6n6ycG+llDGaTYykW/KqUcRe1frouTJlYZnZmz1CP20ZnmKWLVjO+PFiR
 2xPTDFl9b0Abu3zSQpQ0apZzzfO8zEt8hRf3SjW3nhTjBhJeePqBUQUMRztqXNIPgXVGi05TDDL
 xJTq1b+2mVBYm2xa/Eeqv10OuEhDBccgfb2Ikd+ye8O1Hu6CvjG6XugqaAIRqaexa/gYfeofqPt
 b76R6zdWCnj1/yT+NWTa50ZW9Pi6CEKVUAeQtlCihh1O5loI3KGDxiKkg1qXe9n3M13GU0q5iW0
 AzzoDakuqLwgDOjU5NNscmsAAdI+NvoiP7jYa8jPn/VgBwCS+z2EeS7cJI2Qvtb9bHLEcdvdNuB
 AHj9WK4B7JnbWDyZo8oHmocNM2htxLFfb6P57gtGHK287sjOPeV+Ffy6MFbcY5PCMzkD7hQcGrn
 cz7wZbg4BmLYNrahNMi37yVFZUHqWrGBNvnbGuXvOIwv8v4+dG3agX0jRWs0SHZo4scXHdmGM2A
 UMct/x6oIV2xksqF0Eh9Qps+aHSw3dQErQlQmWUg29qDPMU+BHckk7fUBISWezT/qU/jwjd0XZV
 ONH8vkCpTyP/xYTu+9gdsLiwP4I8mLRdn+i9rHdYeL9b/eKO2Oeai5NHauXiZfuDHhXQV+splk3
 C73dsx/38PGBW18bcRjcPbG+qWGEm1mm9/xFiJjAHTgLMXhXC+mkk=
X-Received: by 2002:a05:6830:2b11:b0:862:a48e:24e1 with SMTP id
 46e09a7af769-863159e0b2emr20494388a34.17.1795676014912; 
 Wed, 25 Nov 2026 22:53:34 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-86385358ca2sm31041a34.21.2026.11.25.22.53.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 22:53:34 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 25 Nov 2026 23:53:03 -0700
Subject: [PATCH 14/19] spl: fit: read the exact size of an embedded FIT
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-submit-lwip-network-boot-v1-v1-14-63df291d9392@gmail.com>
References: <20261125-submit-lwip-network-boot-v1-v1-0-63df291d9392@gmail.com>
In-Reply-To: <20261125-submit-lwip-network-boot-v1-v1-0-63df291d9392@gmail.com>
To: Jerome Forissier <jerome.forissier@arm.com>, 
 Heiko Stuebner <heiko@sntech.de>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Johan Jonker <jbx6244@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Piyush Paliwal <piyushthepal@gmail.com>, 
 Mateusz Furdyna <mateusz.furdyna@nokia.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, David Lechner <dlechner@baylibre.com>, 
 Michael Srba <Michael.Srba@seznam.cz>, Peng Fan <peng.fan@nxp.com>, 
 Carlo Caione <ccaione@baylibre.com>, Daniel Golle <daniel@makrotopia.org>, 
 Alexey Charkov <alchark@flipper.net>, Anton Ivanov <anton@binarly.io>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Petr Hodina <petr.hodina@protonmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Alessandro Rubini <rubini@gnudd.com>, 
 Mingtian Li <limingtian@email.szu.edu.cn>, 
 Romain Gantois <romain.gantois@bootlin.com>, kongchen <3305708832@qq.com>, 
 Anshul Dalal <anshuld@ti.com>, Andre Przywara <andre.przywara@arm.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Aristo Chen <aristo.chen@canonical.com>, Heiko Schocher <hs@nabladev.com>, 
 Francesco Valla <francesco@valla.it>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.17-dev
X-Mailman-Approved-At: Thu, 26 Nov 2026 13:33:17 +0000
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

A FIT header with totalsize zero makes spl_simple_fit_read() request no
bytes, and the zero-byte read passes its length check. A load-only caller
that skips FIT parsing can then report success for an empty image. Reject
zero before alignment and before issuing this read.

A byte-addressed loader can also reject a complete FIT when its strings
block ends between word boundaries and the file has no trailing padding.
Only the start of external image data needs four-byte alignment.

Read the FIT at its declared length, preserving additional space a board
requires for authentication and transport alignment. Reject short reads
before parsing. Test zero size, an unpadded file, and a short read.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 common/spl/spl_fit.c  |  9 +++++++--
 test/image/spl_load.c | 56 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+), 2 deletions(-)

diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index 64e5f95546f..9182fa5c686 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -16,6 +16,7 @@
 #include <sysinfo.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
+#include <linux/err.h>
 #include <linux/libfdt.h>
 #include <linux/printk.h>
 
@@ -797,7 +798,11 @@ static int spl_simple_fit_read(struct spl_fit_info *ctx,
 	 * start. This is the base for the data-offset properties in each
 	 * image.
 	 */
-	size = ALIGN(fdt_totalsize(fit_header), 4);
+	size = fdt_totalsize(fit_header);
+	if (!size) {
+		log_debug("Invalid FIT size: %lu\n", size);
+		return -EINVAL;
+	}
 	size = board_spl_fit_size_align(size);
 	ctx->ext_data_offset = ALIGN(size, 4);
 
@@ -824,7 +829,7 @@ static int spl_simple_fit_read(struct spl_fit_info *ctx,
 	}
 
 	count = info->read(info, offset, aligned_size, buf);
-	if (!count) {
+	if (IS_ERR_VALUE(count) || count < size) {
 		/*
 		 * FIT could not be read. This means we should free the
 		 * memory allocated by board_spl_fit_buffer_addr().
diff --git a/test/image/spl_load.c b/test/image/spl_load.c
index 46136f058c5..de00e146b9c 100644
--- a/test/image/spl_load.c
+++ b/test/image/spl_load.c
@@ -424,6 +424,62 @@ SPL_IMG_TEST(spl_test_image, IMX8, 0);
 SPL_IMG_TEST(spl_test_image, FIT_INTERNAL, 0);
 SPL_IMG_TEST(spl_test_image, FIT_EXTERNAL, 0);
 
+struct fit_test_file {
+	const void *data;
+	size_t size;
+	bool partial;
+};
+
+static ulong fit_file_read(struct spl_load_info *load, ulong offset,
+			   ulong count, void *buf)
+{
+	struct fit_test_file *file = load->priv;
+
+	if (offset || (count > file->size && !file->partial))
+		return 0;
+	count = min_t(ulong, count, file->size);
+	memcpy(buf, file->data, count);
+	return count;
+}
+
+static int spl_test_fit_file_size(struct unit_test_state *uts)
+{
+	struct spl_image_info src = { .name = "fit-file", .size = 32 }, dst = {};
+	struct fit_test_file file = {};
+	struct spl_load_info load;
+	size_t capacity, actual;
+	void *fit;
+
+	if (!IS_ENABLED(CONFIG_SPL_LOAD_FIT) || IS_ENABLED(CONFIG_SPL_LOAD_FIT_FULL))
+		return -EAGAIN;
+	capacity = create_image(NULL, FIT_INTERNAL, &src, NULL);
+	fit = calloc(capacity, 1);
+	ut_assertnonnull(fit);
+	ut_asserteq(capacity, create_image(fit, FIT_INTERNAL, &src, NULL));
+	actual = fdt_totalsize(fit);
+	/* A valid FIT need not have padding after its strings block. */
+	if (!(actual % 4)) {
+		ut_assert(actual < capacity);
+		fdt_set_totalsize(fit, ++actual);
+	}
+	file.data = fit;
+	file.size = actual;
+	spl_load_init(&load, fit_file_read, &file, 1);
+	ut_assertok(spl_load_simple_fit(&dst, &load, 0, fit));
+	fdt_set_totalsize(fit, 0);
+	file.size = 0;
+	ut_asserteq(-EINVAL, spl_load_simple_fit(&dst, &load, 0, fit));
+	fdt_set_totalsize(fit, actual);
+	file.size = actual;
+	file.size--;
+	file.partial = true;
+	ut_asserteq(-EIO, spl_load_simple_fit(&dst, &load, 0, fit));
+	free(fit);
+	return 0;
+}
+
+SPL_TEST(spl_test_fit_file_size, 0);
+
 /*
  * Build a FIT with external data, overwrite one property of the image node
  * with a hostile value and check that loading fails with the expected error.

-- 
2.53.0

