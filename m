Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A01ECD6E6E
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 20:42:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34B38849D8;
	Thu,  4 Jun 2026 22:42:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=valla.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="W5gEO5f+";
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=valla.it header.i=@valla.it header.b="Jn1rxFPo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 528C384975; Thu,  4 Jun 2026 22:41:58 +0200 (CEST)
Received: from delivery.antispam.mailspamprotection.com
 (delivery.antispam.mailspamprotection.com [185.56.87.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64575848BF
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 22:41:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@valla.it
ARC-Seal: i=1; cv=none; a=rsa-sha256;
 d=outgoing.instance-europe-west4-dcpc.prod.antispam.mailspamprotection.com;
 s=arckey; t=1780605716; 
 b=pt9jADW9CY1IoYNzE3qglH53wIN7qoOZruSXctV2dCinRf7H1qvjbvov+WIRoZ+gpQuaPrKqGg
 QAE0XjgJ7mhKIjBGGRvW3xsIkWLIPHoJDNvBcM/ii3i3e5igdIrmeqB6tEHsNjaDEdN4U0DRLp
 Gj8C5QdE3A2mdNg3hvhkwMVXWt3vkTbY0iFrzdTj66QGwriDMXsH1Vxs8PtwZtvMsutDgvyiT4
 GgEmVNoQ3Y7VQ8pNkoK2ge1vKyeA5odrlXqdoPtKfDcsScAm04mDZHrh9+Zoq/gHYE12cwLrrn
 cJx9gthDkZA2ZO7G6JnIlUMXg8OhiBMVks4421dOPrUWdw==;
ARC-Authentication-Results: i=1;
 outgoing.instance-europe-west4-dcpc.prod.antispam.mailspamprotection.com;
 smtp.remote-ip=35.214.173.214; 
 iprev=pass (214.173.214.35.bc.googleusercontent.com)
 smtp.remote-ip=35.214.173.214; 
 auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
 dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
 arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed;
 d=outgoing.instance-europe-west4-dcpc.prod.antispam.mailspamprotection.com;
 s=arckey; t=1780605716; 
 bh=CHv3xR/UDFMUwqEOPUX/At5C3RkuxUMWGs/yHoHJPhk=;
 h=Cc:To:In-Reply-To:References:Message-ID:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:DKIM-Signature:DKIM-Signature;
 b=Lfy5y1Lk9UICJcAdcQQJCLdCy6BOX4S5LGkiu4tKUeVmgKFxLNvkIAnv+V3Pzc2LPiPIcaQ/YF
 SZMowka0h2C3B//+Yhs2bpLRRNdxOVwV02d+is0H27ydjNZUGF3DQKgloh7OtKNPzjGuKyDYfb
 EF3qtX/cZdVuvvvHE142WV0RekyhzmYU5bxi1+RJBJu2DC+720Yb6+or91tkIVZOV7qIfFeuo3
 iyy9eXNd8HgY8uNAZ84BEHJhCPjms7SMSELIXr9iWUnQV26McBBRAHzVnSFI0NdqOhBvPyvZed
 o4vYxKnP7hh/PvXoCmMlIxV6cxAJSKcbwtYD/qrhGuTzdw==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
 :Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject
 :Date:From:Reply-To:List-Unsubscribe;
 bh=bUo+fB2D3PvECJETRiyy7AEuQAMsstci5E4gd3y+yj4=; b=W5gEO5f+AThL8r4Fzv7yVCJ9gI
 wdBJ9S/ymV81lpZSrNjFu5UotG1T3mJiwzQHSsvbQk4+QJ/db2IwBpnkpWbxrBzk3PNCxuIsCmCCX
 z8FyYtYZWPqM7jUoBneqcW1Q5YZnoH3nWtzRibc0nWI6mqGl2xWt31yVCBUTJn8L1TyI=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214]
 helo=esm19.siteground.biz)
 by instance-europe-west4-dcpc.prod.antispam.mailspamprotection.com with
 esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384 (Exim 4.99.4)
 (envelope-from <francesco@valla.it>) id 1wVEt0-00000007IvF-1TmX
 for u-boot@lists.denx.de; Thu, 04 Jun 2026 20:41:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
 s=default; h=Cc:To:Subject:Date:From:list-help:list-unsubscribe:
 list-subscribe:list-post:list-owner:list-archive;
 bh=bUo+fB2D3PvECJETRiyy7AEuQAMsstci5E4gd3y+yj4=; b=Jn1rxFPoOKuTv/arys5OWmKKS+
 EQrmuMy+75HEisu9vJOWkMtP78NjqPSQGG65Pdj3eNqH82z1+bWb/Yq8ToBk94Em3c63tCqgIhlW+
 rLUC9ktwgbR1OQEYch/Kynx9gVDczylgN/05MjOc/98Ez2fZwN78h3WoHMmhIoJyVheg=;
Received: from [95.248.69.182] (port=60898 helo=[192.168.178.43])
 by esm19.siteground.biz with essmtpa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.99.3) (envelope-from <francesco@valla.it>)
 id 1wVEsm-00000000GnV-2ZcA; Thu, 04 Jun 2026 20:41:40 +0000
From: Francesco Valla <francesco@valla.it>
Date: Thu, 04 Jun 2026 22:41:40 +0200
Subject: [PATCH 6/6] test: spl: add unit test for the "full" FIT loader
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-spl_fit_full_cleanup-v1-6-ec036b5872e2@valla.it>
References: <20260604-spl_fit_full_cleanup-v1-0-ec036b5872e2@valla.it>
In-Reply-To: <20260604-spl_fit_full_cleanup-v1-0-ec036b5872e2@valla.it>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 David Lechner <dlechner@baylibre.com>, Rasmus Villemoes <ravi@prevas.dk>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Michael Walle <mwalle@kernel.org>, Anshul Dalal <anshuld@ti.com>, 
 Marek Vasut <marek.vasut@mailbox.org>, Francesco Valla <francesco@valla.it>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3082; i=francesco@valla.it;
 h=from:subject:message-id; bh=CHv3xR/UDFMUwqEOPUX/At5C3RkuxUMWGs/yHoHJPhk=;
 b=owGbwMvMwCX2aH1OUIzHTgbG02pJDFmKjxn87r97ErdZZd51qxaT45vmL1968Uv1f60OoaMfL
 Rilva8e6yhlYRDjYpAVU2QJWXfj3p655t/SNjA+gpnDygQyhIGLUwAmEh/DyLDXzEDqc2zDccuD
 Kae2qa1burLV+f1TUUV3T7l9ok1WK8UY/oeUMO865HlOs+SfiXakAF/VT9lAD9Yo/zcp4td1u5o
 +cwMA
X-Developer-Key: i=francesco@valla.it; a=openpgp;
 fpr=CC70CBC9AA13257C6CCED8669601767CA07CA0EA
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - lists.denx.de
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: a6a0e63df814835ab884fc701b72051e
X-AntiAbuse: ID - a6a0e63df814835ab884fc701b72051e
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1wVEt0-00000007IvF-1TmX-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-dcpc.prod.antispam.mailspamprotection.com; 
 iprev=pass (214.173.214.35.bc.googleusercontent.com)
 smtp.remote-ip=35.214.173.214; 
 auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
 dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
 arc=none
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Following what is already done for the "simple" FIT loader, add a unit
test for the "full" loader.

Signed-off-by: Francesco Valla <francesco@valla.it>
---
 arch/sandbox/cpu/spl.c         | 37 +++++++++++++++++++++++++++++++++++++
 arch/sandbox/include/asm/spl.h | 14 ++++++++++++++
 test/image/spl_load_os.c       | 11 +++++++++++
 3 files changed, 62 insertions(+)

diff --git a/arch/sandbox/cpu/spl.c b/arch/sandbox/cpu/spl.c
index 7ee4975523e3..1668b58d3fbb 100644
--- a/arch/sandbox/cpu/spl.c
+++ b/arch/sandbox/cpu/spl.c
@@ -265,6 +265,43 @@ int sandbox_spl_load_fit(char *fname, int maxlen, struct spl_image_info *image)
 	return 0;
 }
 
+int sandbox_spl_load_fit_full(char *fname, int maxlen,
+			      struct spl_image_info *image)
+{
+	struct legacy_img_hdr *header;
+	long long size;
+	int ret;
+	int fd;
+
+	ret = sandbox_find_next_phase(fname, maxlen, true);
+	if (ret) {
+		printf("%s not found, error %d\n", fname, ret);
+		return log_msg_ret("nph", ret);
+	}
+
+	log_debug("reading from %s\n", fname);
+	fd = os_open(fname, OS_O_RDONLY);
+	if (fd < 0) {
+		printf("Failed to open '%s'\n", fname);
+		return log_msg_ret("ope", -errno);
+	}
+
+	if (os_get_filesize(fname, &size))
+		return log_msg_ret("fis", -ENOENT);
+
+	header = spl_get_load_buffer(0, size);
+
+	if (os_read(fd, header, size) != size)
+		return log_msg_ret("rea", -EIO);
+	os_close(fd);
+
+	ret = spl_load_fit_image(image, header);
+	if (ret)
+		return log_msg_ret("slf", ret);
+
+	return 0;
+}
+
 static int upl_load_from_image(struct spl_image_info *spl_image,
 			       struct spl_boot_device *bootdev)
 {
diff --git a/arch/sandbox/include/asm/spl.h b/arch/sandbox/include/asm/spl.h
index d824b2123a25..49a613ba92db 100644
--- a/arch/sandbox/include/asm/spl.h
+++ b/arch/sandbox/include/asm/spl.h
@@ -46,4 +46,18 @@ int sandbox_find_next_phase(char *fname, int maxlen, bool use_img);
  */
 int sandbox_spl_load_fit(char *fname, int maxlen, struct spl_image_info *image);
 
+/**
+ * sandbox_spl_load_fit_full() - Load the next phase from a FIT with the "full" loader
+ *
+ * Loads a FIT containing the next phase and sets it up for booting, using the
+ * "full" FIT loader
+ *
+ * @fname: Returns filename loaded
+ * @maxlen: Maximum length for @fname including \0
+ * @image: Place to put SPL-image information
+ * Return: 0 if OK, -ve on error
+ */
+int sandbox_spl_load_fit_full(char *fname, int maxlen,
+			      struct spl_image_info *image);
+
 #endif
diff --git a/test/image/spl_load_os.c b/test/image/spl_load_os.c
index d17cf116a0e8..ba9d7979a09b 100644
--- a/test/image/spl_load_os.c
+++ b/test/image/spl_load_os.c
@@ -21,3 +21,14 @@ static int spl_test_load(struct unit_test_state *uts)
 }
 SPL_TEST(spl_test_load, 0);
 
+static int spl_test_load_fit_full(struct unit_test_state *uts)
+{
+	struct spl_image_info image;
+	char fname[256];
+
+	ut_assertok(sandbox_spl_load_fit_full(fname, sizeof(fname), &image));
+
+	return 0;
+}
+SPL_TEST(spl_test_load_fit_full, 0);
+

-- 
2.54.0

