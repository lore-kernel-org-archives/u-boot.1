Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C0460A261A
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 14:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=gQLTnAhH;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=dU7xWLe5
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 349F380F52;
	Mon, 16 Nov 2026 14:01:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KYBX1hyod98u; Mon, 16 Nov 2026 14:01:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F11AB80F49
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794837670;
	b=iD2YY52pizy7mnc5HTT6TX4RfElGRL9qjXxa1wIw45o+CTqroJ1xuoLlYylbVnyBzBRP
	 YL9gQ0Q9QoJVcBkk78+LC1srg3vnOZ3Otr5MkbfS5+z+ewOAvcX6ZuwGfTWF0IXqj3hJj
	 2CwgllL3tVb6LtaB2x7nh/+onz92uHbd7BGIGKq8gkKEleo12LX/5R3vibJXcu+NBc9vY
	 mow7qLBPfb6SMX4af1eDxz9WMr5XmgHd0he1hJHcbcaGP9BXt7XnUg0pyaaCHy1XfQKJz
	 /2497e7tSXa88iEGsH0e5JqAjyUwSw70knMAVXpL6vgb3BVOSV6EWpEZtC8V+jpK81g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794837670;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=L1CkhpPVhBk2GV4Sx+cfCgelCk005/vT+M8cUq891FE=;
	b=sWU6Bxn9QQw7ZRVvCaS2xRnIExIa1MF0IQIfHm2bvqowo/1tUeQdpjg1lvNo+ecV4kYe
	 1QH2esazL2yUWbdZp6TxV1NV79JlIsD7q67kWh5NJ6oyeVNcjVixtVRwoccHLzoteGkLy
	 xaEkIH5+qmkTDS2Obd0LHRW8APRwRC+8E+o4EAkC7KtuL6wuvqnuvWW/C0G46susKqaVn
	 BZ4161rYC8BoGJwqZ4CpPRphjG65fk3soKaOMOkE2vo4ZDr4oTyutsfnNcUBCKgR+o2W9
	 KO4/zAHcd3vjqnI67hIKxtO9E60NPGgvDSUCR0xn8KLjsdniujUp986Jdk5Ijh1m+eg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794837670;
	bh=L1CkhpPVhBk2GV4Sx+cfCgelCk005/vT+M8cUq891FE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gQLTnAhHodLXGfBh2d9FEJUqLhVd7Femnav75mf2OvefpTDmkZ8/ZTFCzyJkeJaGY
	 raoRD8tQ3XoNacnrsCKr152hOiIAEmv5aDjLA0gqJklyN0lOwesA2XFQiQtcXtiCQR
	 1pFElyaDARDSwly6GwF1Ly4L6GacqCrV6kog7r/dOUrackjuQdWWOBd+Km97h0bAoX
	 //j7p3GdC1g8quXA6ItkS8vWWQLB7fA587dfuBebUEZmbRDlF1j/e3apSXevYcjxv8
	 /Hl/0A0sZJPXUj4+YumGpng+88A+FafHVJoGE+lgSBnptF78zSgNULnx88aCooSY/6
	 SSIvtytOT9wXA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F11AB80F49;
	Mon, 16 Nov 2026 14:01:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1730B2FE
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 14:01:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 084CF607F5
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 14:01:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Oj-W4RR4QQ21 for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 14:01:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8F3746078A
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42b; helo=mail-wr1-x42b.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=dU7xWLe5
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8F3746078A
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 14:01:05 +0000 (UTC)
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-48fd2e38825so2234688f8f.2
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 06:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794837663; x=1795442463;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=L1CkhpPVhBk2GV4Sx+cfCgelCk005/vT+M8cUq891FE=;
 b=dU7xWLe59J2JYH80Fqu81G+/o9zIN2jXlaPL1uTAtLDCzuLfAf63dvE8I3SC+ehba/
 5GX90YvLn81h07msYr4BCTcP57hTVmtLRKxyUOQ+ODamMowHp3mCoa4XAxp7Ht3kXaGZ
 lEjIrLgoQZfxM8PWxpSuLaPW7AKecMKbng9nRJ489KG5noVJ+x7AUmom2pENbIBuuB/c
 JB+16CFr/TmClEkJeI+KnE+cMKvA5BKT2KLymI8JimHGDL2lPkc4zFkWQfKkeLzXauv/
 rL8ib0GzKJNpB0UP6LLcr7UOoBNs0ZXGuOMV4Got8KHsGtzeV44IvzG8JUaBhyoDQJzF
 QYSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794837663; x=1795442463;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=L1CkhpPVhBk2GV4Sx+cfCgelCk005/vT+M8cUq891FE=;
 b=iPqSDkssnAP8ZjUvKOzn9R7Kvu9Y7kVjLWtrdU/RR6FtwZsEckFwC/izdxBFZ6puRL
 XHg80CoziXEkem/v1sNEmd1N57+xhgCVdeJNZziEP4KnDeXSCJ5DkFdZ2NhTZTuvTbBd
 44OvjY9j2DnGo+S1Gykih2ItYF5JOxnU22FUkQ+AGvwtJyc1ESvHCU9b9fDqEQ2R4F50
 n3128ZGb4kNYzxyqGrL7WFsRGO5Sg1dYhwZn/l3JgRxzP5kf0yRToc/36Fhk8vzaLlUt
 jvrAwpCXHononejBuus8hBV7lnUvJh/F7UUnP3ka+vGhJ0sIYaIFxtGY2k7kVmGUUK3A
 LyOg==
X-Gm-Message-State: APuU4Z/fRAtskGiD6XOkvqolGrYvy5KxZV1B0JMS/dcNNCGkWWlKsX9C
 vN0TQO3xKpFY67zMbg8FXFIwZPXNlxU8oFsre9Nq6u5Ya+X/3Cqh1hAJLkW+W8fVX7Q=
X-Gm-Gg: AZFdTZciiJK4bIdgJdD/6QPt06Z47+HvXYE7zBX7BVccptoLl8tOA/SYhYd1RmnYMmX
 HOxjU+xegQqkEmtCmENiEXIS49AJiNK74+pk6JR0HeH8dNL7FvLB8dfalpLyTC6FYR1AsUykPq9
 xZLxPSMJ5fQRXiNTz2FY3bv70kyWmCZZKBLPFsoUIAzdRAyEAcnWPFcWHJsOPT5K7KyWDt3os2l
 tPWL3MN33M3ACSJ/+J52n1pKGulljRtkmzjOm18G0x5z81vQjRdFps/eBkfCqs1duZhHAzBQvBU
 3nTYswHheG8sRIYJqX2Lrkdh6pJZSXSZduktzo7OYeD8v7Yh/FpEPHs8/9rmuCHBKqAwaNL7SDH
 QrfgfQeUvT8JKCnKLjPmR5nwZLloUVcoAEez9wwVQ3OI5uqbTDBgtinz5lu7vg5vDj5qL6wGvLL
 5E4jMbDkw0Xbnk71PeIkLtxqrAoWUxiZXQGF9PI/SjHcPCyzmBBMsjsLn4iDRWM+K+xKpoQibEF
 OXfvpFjCJDf82DER/Hn1zaYX2mvH6QUqQnTG5xHjD/lIX7r0rL4oafKhKpXppLQVuvJt/a5bM/+
 8wxYiD5W6vEkRbgFi9B0JwU7cHssY44Oaa0keF7bOvp+Mcm8iRpov8sRk27SZ9A/LvdvMOoU/zz
 3HbOldAqySEHkHFpP9MyPVNJBCPxuYWh/I02leF55X727mpl91P3Ac/mZndddAxm1MoA=
X-Received: by 2002:a05:6000:1a88:b0:493:8704:ad42 with SMTP id
 ffacd0b85a97d-49c6d63fbecmr23934886f8f.7.1794837663355; 
 Mon, 16 Nov 2026 06:01:03 -0800 (PST)
Received: from macbook.homenet.telecomitalia.it
 (host-95-246-144-141.retail.telecomitalia.it. [95.246.144.141])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c69406640sm22119355f8f.12.2026.11.16.06.01.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 06:01:02 -0800 (PST)
From: Carlo Caione <ccaione@baylibre.com>
Date: Mon, 16 Nov 2026 15:00:50 +0100
Subject: [PATCH v3 4/7] spl: ram: allow loading FIT images from a supplied
 buffer
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-ccaione-upstream-spl-fastboot-boot-v3-4-7b39e7a348c6@baylibre.com>
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
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

RAM FIT loading currently assumes a configured image address. Downloaded
images need the same loader with a caller-provided buffer and length so
reads cannot run beyond the received data.

Expose a reusable RAM FIT loader with header validation, bounded reads
and overlap-safe copying. Keep preloaded images working when their buffer
size is unknown. Add tests for embedded and external FIT data.

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 MAINTAINERS           |  1 +
 common/spl/spl_ram.c  | 45 +++++++++++++++++++++++++++------------------
 include/spl.h         |  9 +++++++++
 test/image/Kconfig    |  9 +++++++++
 test/image/Makefile   |  1 +
 test/image/spl_load.c |  4 +++-
 test/image/spl_ram.c  | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 98 insertions(+), 19 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ae3e9819d45..ad224d913ac 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1933,5 +1933,6 @@ Q:	http://patchwork.ozlabs.org/project/uboot/list/
 S:	Maintained
 T:	git https://git.u-boot-project.org/u-boot/u-boot.git
 F:	configs/tools-only_defconfig
+F:	test/image/spl_ram.c
 F:	*
 F:	*/
diff --git a/common/spl/spl_ram.c b/common/spl/spl_ram.c
index 0c501cf02f2..75a3e5904b8 100644
--- a/common/spl/spl_ram.c
+++ b/common/spl/spl_ram.c
@@ -16,32 +16,43 @@
 #include <spl.h>
 #include <linux/libfdt.h>
 
+struct spl_ram_image {
+	const void *data;
+	size_t size;
+};
+
 static ulong spl_ram_load_read(struct spl_load_info *load, ulong sector,
 			       ulong count, void *buf)
 {
-	ulong addr = 0;
+	struct spl_ram_image *image = load->priv;
 
 	debug("%s: sector %lx, count %lx, buf %lx\n",
 	      __func__, sector, count, (ulong)buf);
 
-	if (IS_ENABLED(CONFIG_SPL_LOAD_FIT)) {
-		addr = IF_ENABLED_INT(CONFIG_SPL_LOAD_FIT,
-				      CONFIG_SPL_LOAD_FIT_ADDRESS);
+	if (sector >= image->size)
+		return 0;
+	count = min_t(ulong, count, image->size - sector);
+	memmove(buf, image->data + sector, count);
+	return count;
+}
 
-#ifdef	CONFIG_SPL_PCI_DFU
-		if (spl_boot_device() == BOOT_DEVICE_PCIE)
-			addr = CONFIG_SPL_PCI_DFU_SPL_LOAD_FIT_ADDRESS;
-#endif
-	}
-	addr += sector;
-	if (CONFIG_IS_ENABLED(IMAGE_PRE_LOAD))
-		addr += image_load_offset;
+int spl_ram_load_fit(struct spl_image_info *spl_image, void *fit, size_t size)
+{
+	struct spl_ram_image image = { .data = fit, .size = size };
+	struct spl_load_info load;
 
-	memcpy(buf, (void *)addr, count);
+	if (!CONFIG_IS_ENABLED(LOAD_FIT))
+		return -EOPNOTSUPP;
+	if (size < sizeof(struct fdt_header) || fdt_check_header(fit) ||
+	    fdt_totalsize(fit) > size)
+		return -EINVAL;
 
-	return count;
+	spl_load_init(&load, spl_ram_load_read, &image, 1);
+	return spl_load_simple_fit(spl_image, &load, 0, fit);
 }
 
+#if CONFIG_IS_ENABLED(RAM_DEVICE) || CONFIG_IS_ENABLED(DFU) || \
+	CONFIG_IS_ENABLED(PCI_DFU)
 static int spl_ram_load_image(struct spl_image_info *spl_image,
 			      struct spl_boot_device *bootdev)
 {
@@ -81,11 +92,8 @@ static int spl_ram_load_image(struct spl_image_info *spl_image,
 
 	if (IS_ENABLED(CONFIG_SPL_LOAD_FIT) &&
 	    image_get_magic(header) == FDT_MAGIC) {
-		struct spl_load_info load;
-
 		debug("Found FIT\n");
-		spl_load_init(&load, spl_ram_load_read, NULL, 1);
-		ret = spl_load_simple_fit(spl_image, &load, 0, header);
+		ret = spl_ram_load_fit(spl_image, header, SIZE_MAX);
 	} else {
 		ulong u_boot_pos = spl_get_image_pos();
 
@@ -120,3 +128,4 @@ SPL_LOAD_IMAGE_METHOD("DFU", 0, BOOT_DEVICE_DFU, spl_ram_load_image);
 #if CONFIG_IS_ENABLED(PCI_DFU)
 SPL_LOAD_IMAGE_METHOD("PCIE", 0, BOOT_DEVICE_PCIE, spl_ram_load_image);
 #endif
+#endif
diff --git a/include/spl.h b/include/spl.h
index 390d18fd9d5..f884c24b85e 100644
--- a/include/spl.h
+++ b/include/spl.h
@@ -989,6 +989,15 @@ bool spl_was_boot_source(void);
  */
 int spl_dfu_cmd(int usbctrl, char *dfu_alt_info, char *interface, char *devstr);
 
+/**
+ * spl_ram_load_fit() - Load a FIT from a RAM buffer
+ * @spl_image: Receives the loaded image information
+ * @fit: FIT image, including any external data
+ * @size: Buffer size, or SIZE_MAX for a preloaded image of unknown size
+ * Return: 0 on success, or a negative error code
+ */
+int spl_ram_load_fit(struct spl_image_info *spl_image, void *fit, size_t size);
+
 /**
  * spl_mmc_clear_cache() - Clear cached MMC devices
  *
diff --git a/test/image/Kconfig b/test/image/Kconfig
index 45b6e8c52e6..1cb8337e0f4 100644
--- a/test/image/Kconfig
+++ b/test/image/Kconfig
@@ -41,6 +41,15 @@ config SPL_UT_LOAD_NET
 	help
 	  Test loading images over TFTP using the NET image load method.
 
+config SPL_UT_LOAD_RAM
+	bool "Test loading images from RAM"
+	depends on SANDBOX && SPL_LOAD_FIT
+	select SPL_RAM_SUPPORT
+	default y
+	help
+	  Test loading FIT images from a RAM buffer, including images with
+	  embedded and external payloads.
+
 config SPL_UT_LOAD_SPI
 	bool "Test loading from SPI Flash"
 	depends on SANDBOX && SPL_OF_REAL
diff --git a/test/image/Makefile b/test/image/Makefile
index 11ed25734e8..feca0611fcf 100644
--- a/test/image/Makefile
+++ b/test/image/Makefile
@@ -7,5 +7,6 @@ obj-$(CONFIG_SPL_UT_LOAD_FS) += spl_load_fs.o
 obj-$(CONFIG_SPL_UT_LOAD_NAND) += spl_load_nand.o
 obj-$(CONFIG_SPL_UT_LOAD_NET) += spl_load_net.o
 obj-$(CONFIG_SPL_NOR_SUPPORT) += spl_load_nor.o
+obj-$(CONFIG_SPL_UT_LOAD_RAM) += spl_ram.o
 obj-$(CONFIG_SPL_UT_LOAD_OS) += spl_load_os.o
 obj-$(CONFIG_SPL_UT_LOAD_SPI) += spl_load_spi.o
diff --git a/test/image/spl_load.c b/test/image/spl_load.c
index 166cf331194..0e3bc0d6caa 100644
--- a/test/image/spl_load.c
+++ b/test/image/spl_load.c
@@ -163,7 +163,9 @@ static size_t start_fit(void *dst, size_t fit_size, size_t data_size,
 static size_t create_fit(void *dst, struct spl_image_info *spl_image,
 			 size_t *data_offset, bool external)
 {
-	size_t prop_size = 596, total_size = prop_size + spl_image->size;
+	/* Both the image and configuration have a description. */
+	size_t prop_size = ALIGN(596 + 2 * (strlen(spl_image->name) + 1), 4);
+	size_t total_size = prop_size + spl_image->size;
 	size_t off, size;
 
 	if (external) {
diff --git a/test/image/spl_ram.c b/test/image/spl_ram.c
new file mode 100644
index 00000000000..5874ac02a3a
--- /dev/null
+++ b/test/image/spl_ram.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright (C) 2026 Carlo Caione <ccaione@baylibre.com> */
+
+#include <image.h>
+#include <mapmem.h>
+#include <spl.h>
+#include <test/spl.h>
+#include <test/ut.h>
+
+static int check_ram_image(struct unit_test_state *uts, void *image, size_t size,
+			   struct spl_image_info *expected, const void *data)
+{
+	struct spl_image_info loaded = {};
+
+	ut_assertok(spl_ram_load_fit(&loaded, image, size));
+	ut_assertok(check_image_info(uts, expected, &loaded));
+	ut_asserteq_mem(data, map_sysmem(loaded.load_addr, loaded.size), loaded.size);
+	return 0;
+}
+
+static int spl_test_ram(struct unit_test_state *uts, const char *name,
+			enum spl_test_image type)
+{
+	struct spl_image_info info = { .name = name, .size = SPL_TEST_DATA_SIZE };
+	size_t size, offset;
+	void *image;
+	int ret;
+
+	size = create_image(NULL, type, &info, &offset);
+	ut_assert(size);
+	image = calloc(1, size);
+	ut_assertnonnull(image);
+	generate_data(image + offset, info.size, name);
+	if (create_image(image, type, &info, NULL) != size) {
+		free(image);
+		return -EINVAL;
+	}
+	if (type == FIT_INTERNAL)
+		size = fdt_totalsize(image);
+	ret = check_ram_image(uts, image, size, &info, image + offset);
+	if (!ret)
+		ret = check_ram_image(uts, image, SIZE_MAX, &info, image + offset);
+	free(image);
+	return ret;
+}
+
+SPL_IMG_TEST(spl_test_ram, FIT_INTERNAL, 0);
+SPL_IMG_TEST(spl_test_ram, FIT_EXTERNAL, 0);

-- 
2.56.0

