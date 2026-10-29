Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F6B606A31A
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 00:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=zUl8IqlY;
	dkim=pass (2048-bit key, unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=F6aDrA+L
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 33F9F606EC;
	Thu, 29 Oct 2026 00:17:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R-wF4e6dzbxM; Thu, 29 Oct 2026 00:16:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6676A606F2
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793233019;
	b=pO9FfnMI2TN2wbdios6NJvDJeWUorUJ3o72VJRP70Ex+eu0tbvNffiZyv+yHTSaR4xC0
	 8G/Utp3Ina9+sZtcsinZTto9Qm+mmPQpaEZa2+lEv51EVhuO5LDI1Mlu59n1xBRZWEicw
	 zO/fl6L5EAcghi5qrhXWxc2ToL5enzNOGjh4OvTPFBAOBocCmMA9AVCEYiB/oo2uT4suI
	 vQmvw1UnBpaoHH9z5ZoNCQCPygvktF7gPhAoD8HKQXgS53i0qGZSe7iOcp/765HuIpuz3
	 qZ3UptW6RlL4V8A6KIVDB9fyk5EhWgyNBiwdyJ2/EEeM+E3g5aNbnLIDIYj5CxQFi+g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793233019;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=G3lFJxzqMmwPHVjAVpP2HiuZEldNbUhx1+PlBm7vq1g=;
	b=dbFZ8/izln7RCeotNMJoALlMzi+7/0jeKKhd/EfGBrJ3Bwa4mgZUqrP+ngRq1IPT61U3
	 6CkVZx50QLhJBpXWSiOOYdx5qxRRkebw3kcm8sqEJ6ZXQo5OWDM7LPuv1jfGTDMgmQYnz
	 VT/Lpj1tqZQeRCgxVnoQYAX9w5aInJql8OFWYCyV4NrsrMCxElJhw4rOn3NVlKfhUxQqV
	 t7RLn9WDPYIkv0VnSFiTMl0LKiVQyRKl9aIoaACvcUtoannl5AuI58CdEk9ZiWs2yUtiM
	 yhLCELCZBqK4ph80JKnV2vHfjhzWNnt2yFuJuADYK1m+uDkUpU9y9lsROpp30uNRFow==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=freeshell.de;
	dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=F6aDrA+L;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793233019;
	bh=G3lFJxzqMmwPHVjAVpP2HiuZEldNbUhx1+PlBm7vq1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zUl8IqlYkST+gSCA1cObPdLTIk3CZwLrmIYqHVAIlx+BBug+ffZvAFxGNZ7SJvrju
	 9LfC/NoohJsRkXJvi+9tOAwMrx7NlfhcL5HTKNkORTxkxHOiGMP8dkcrtv92te1xGO
	 r5hQy3XeGifevJL2+rHe5fGsMT0qaimzj6I896js87nQRkuyhrWlviYt015QS0jTjL
	 Aap3XKwU2/HLtiRcqEN/F0TdTgE+LrQA2xPl4KZdnAb6E8JoeEqyp8rSa4IGhrAkGk
	 SZKMsI2ROIHEtdYrlF17WIAvTP/7mrJvMvGN/6i4nKdZcTxmWzaPHkYIx4SEtkoFjT
	 JtjwCXj/t5VBg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6676A606F2;
	Thu, 29 Oct 2026 00:16:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id E7DF12A8
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 00:16:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CDDB5606F6
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 00:16:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ph4ss9JBw6Ts for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 00:16:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 39478606F0
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=116.202.128.144
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793233016;
 b=EGgY8ompY2kRAIFs4FjdiQmaAdOjb6kNSRojOGDrR+HRXoYTI+mkR5ZHmQV9eiKQ+tNi
 5nBnj7TZUkKiGdylkjY6Cz3ZXfIp+Nv6vkIBnKRQ0nMjbH1WSvDCyUw9wrqRYpJdA4A9i
 Z4j4xgZ/J5Tz5JCInheHBEb2/WAOvX7y7m1mZn+h6WwlbzgAdazQoAqmmmC35MAD7oKrX
 +iqOcfYOwAd2mqD+nqCSV/3LFPJjtpzjNXbyt3AdiHKO5sXNejTlmpOYLw1L5nbAN9elI
 sypivYehJ6Fc8GEWyHlBsHfiJmJWw3ap5Kg2PQ7JIZq/my/vOW7+hU1kMiSM+VPhcVw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793233016;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=G3lFJxzqMmwPHVjAVpP2HiuZEldNbUhx1+PlBm7vq1g=;
 b=thH+7ypKsW0wiI0+FpuQyEx7Pr6cwvysJqNyZOsOUGq5PcgdfdRtqwp2ogknMZmno/iv
 0Lfeaszi+PwO4UrRXS02gNXtjo+8xExrUI6a+paBZnzhoyzPnEorrkxYmg0ED80cOyUXk
 fKaYzrLT6w6Ozzktw7/JXrcNJCj8C3oMG0WUld3y7vhq6ghZgWHm3vDuAWKOHHcO3UnQl
 sB30l5lXArD8iLKq6HrYKVjrT3HEvDZJjHyGmRGLPsplhuTVMnMpbB/gYzmaAkbTK1LDu
 28gVtqRdqgrOmVvv9imuMHAriHbVdPKbIZwwjN9g+A7s5dtHdoIG69HC7BoT5kFvx5Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=freeshell.de;
 dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=F6aDrA+L; 
 arc=none smtp.remote-ip=116.202.128.144
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.202.128.144;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=F6aDrA+L
Received: from freeshell.de (freeshell.de [116.202.128.144])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 39478606F0
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 00:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1793233009;
 bh=G3lFJxzqMmwPHVjAVpP2HiuZEldNbUhx1+PlBm7vq1g=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=F6aDrA+LXz6QejcFTx6Ss8nGtaqPtnwSN2Cesuak4b3wGXDK/gKFDAGJSxP6pkdiv
 J/FfOzk39PA/KuyZvbduYBfiLkAnws3Gv0+YXF/TPlBxEDlUxgMuUvdPdA0fIABcD9
 CGVm/8O3KUGFtTYXCidrffO0kr+pmBoKW0DKPJpYQYUKi+wUX/qITrjlo8s/9iILOH
 HPLtQ4YfAxC74S+uGtcErlyLbPQ8kjxOKmjK8UagYy+GHzhp++DF/bAgLXtSFSNheq
 UB+hrvXRWzxT+PdzGwl1Jijsi86oQ+2VNSKnDxv7D+/w8MGc3mhN/M0acr1/QvJg1Q
 53nE2/O/UqYPw==
Received: from hay.lan (unknown [IPv6:2605:59ca:364f:d400:6ecf:39ff:fe00:8375])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 4E972B220892;
 Thu, 29 Oct 2026 01:16:48 +0100 (CET)
From: E Shattow <e@freeshell.de>
To: u-boot@lists.u-boot-project.org
Cc: E Shattow <e@freeshell.de>
Subject: [DNM PATCH v1 2/7] reduced SpacemiT K3 vendor BSP: add guards around
 config optioned k3.c code
Date: Wed, 28 Oct 2026 17:15:50 -0700
Message-ID: <20261029001555.1890775-3-e@freeshell.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261029001555.1890775-1-e@freeshell.de>
References: <20261029001555.1890775-1-e@freeshell.de>
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
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Do Not Merge

Informational purpose only, to aid mainline development of SpacemiT K3
support.
---
 board/spacemit/k3/k3.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/board/spacemit/k3/k3.c b/board/spacemit/k3/k3.c
index 40b7720eee6d..a06db6f3ffd6 100644
--- a/board/spacemit/k3/k3.c
+++ b/board/spacemit/k3/k3.c
@@ -421,6 +421,7 @@ static ulong read_boot_storage_emmc(ulong byte_addr, ulong byte_size, void* buff
 }
 #endif
 
+#if CONFIG_IS_ENABLED(SPI_FLASH)
 static ulong read_boot_storage_spinor(ulong byte_addr, ulong byte_size, void* buff)
 {
 	struct udevice *dev;
@@ -434,6 +435,7 @@ static ulong read_boot_storage_spinor(ulong byte_addr, ulong byte_size, void* bu
 		return 0;
 	}
 }
+#endif
 
 #if CONFIG_IS_ENABLED(SCSI)
 static ulong read_boot_storage_ufs(ulong byte_addr, ulong byte_size, void* buff)
@@ -450,7 +452,9 @@ static const struct boot_storage_op storage_op[] = {
 #if CONFIG_IS_ENABLED(MMC)
 	{ BOOT_MODE_EMMC, 0x140000, read_boot_storage_emmc, NULL },
 #endif
+#if CONFIG_IS_ENABLED(SPI_FLASH)
 	{ BOOT_MODE_NOR, 0x10000, read_boot_storage_spinor, NULL },
+#endif
 #if CONFIG_IS_ENABLED(SCSI)
 	{ BOOT_MODE_UFS, 0x140000, read_boot_storage_ufs, NULL },
 #endif
@@ -482,6 +486,7 @@ static bool write_boot_storage_emmc(ulong byte_addr, ulong byte_size, void* buff
 }
 #endif
 
+#if CONFIG_IS_ENABLED(SPI_FLASH)
 static bool write_boot_storage_spinor(ulong byte_addr, ulong byte_size, void* buff)
 {
 	struct udevice *dev;
@@ -497,6 +502,7 @@ static bool write_boot_storage_spinor(ulong byte_addr, ulong byte_size, void* bu
 	} else
 		return false;
 }
+#endif
 
 #if CONFIG_IS_ENABLED(SCSI)
 static bool write_boot_storage_ufs(ulong byte_addr, ulong byte_size, void* buff)
@@ -510,7 +516,9 @@ static const struct boot_storage_op storage_op[] = {
 #if CONFIG_IS_ENABLED(MMC)
 	{ BOOT_MODE_EMMC, 0x140000, read_boot_storage_emmc, write_boot_storage_emmc },
 #endif
+#if CONFIG_IS_ENABLED(SPI_FLASH)
 	{ BOOT_MODE_NOR, 0x10000, read_boot_storage_spinor, write_boot_storage_spinor },
+#endif
 #if CONFIG_IS_ENABLED(SCSI)
 	{ BOOT_MODE_UFS, 0x140000, read_boot_storage_ufs, write_boot_storage_ufs },
 #endif
@@ -707,7 +715,11 @@ uint32_t get_serial_number(char *sn, uint32_t max_size)
 			if ((0 != ret) || (0 == chipid)) {
 				seed = get_ticks();
 				for (i = 0; i < sizeof(chipid); i++) {
+#if IS_ENABLED(LIB_RAND)
 					((uint8_t*)&chipid)[i] = rand_r(&seed);
+#else
+					((uint8_t*)&chipid)[i] = 0;
+#endif
 				}
 			}
 			snprintf(temp, sizeof(temp), "%016llx", chipid);
@@ -748,7 +760,11 @@ void set_dev_serial_no(void)
 
 int board_init(void)
 {
+#if defined(CONFIG_DM_REGULATOR_SPM8XX) \
+|| CONFIG_IS_ENABLED(ESPI) \
+|| CONFIG_IS_ENABLED(RT7451_RETIMER)
 	int ret = 0;
+#endif
 
 #if CONFIG_IS_ENABLED(RT7451_RETIMER)
 	struct udevice *dev;
@@ -787,12 +803,15 @@ int board_init(void)
 
 void get_reboot_config(void)
 {
+#if CONFIG_IS_ENABLED(DM_PMIC)
 	int ret;
 
 	struct udevice *dev;
 	uint8_t value;
+#endif
 	reboot_config = get_boot_mode();
 
+#if CONFIG_IS_ENABLED(DM_PMIC)
 	ret = uclass_get_device_by_driver(UCLASS_PMIC,
 			DM_DRIVER_GET(spacemit_pm8xx), &dev);
 	if (ret) {
@@ -818,6 +837,7 @@ void get_reboot_config(void)
 		pr_err("spacemit reboot: PMIC write failed\n");
 		return;
 	}
+#endif
 }
 
 void run_fastboot_command(void)
@@ -1717,10 +1737,16 @@ void set_env_ethaddr(void)
 		return;
 	}
 
+#if IS_ENABLED(NET_RANDOM_ETHADDR)
 	/*if there is NO valid MAC address, create 4 random ethaddr */
 	maccount = 4;
 	pr_info("generate %d random ethaddr.\n", maccount);
 	net_random_ethaddr(mac_addr);
+#else
+	mac_addr[3] = 0;
+	mac_addr[4] = 0;
+	mac_addr[5] = 0;
+#endif
 	mac_addr[0] = 0xfe;
 	mac_addr[1] = 0xfe;
 	mac_addr[2] = 0xfe;
@@ -1911,6 +1937,7 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 	__maybe_unused struct fdt_memory mem;
 	int ret;
 
+#if CONFIG_IS_ENABLED(DM_VIDEO)
 	if (CONFIG_IS_ENABLED(FDT_SIMPLEFB)) {
 		/* reserved with no-map tag the video buffer */
 		mem.start = gd->video_bottom;
@@ -1918,6 +1945,7 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 
 		fdtdec_add_reserved_memory(blob, "framebuffer", &mem, NULL, 0, NULL, 0);
 	}
+#endif
 
 	ft_board_cpu_fixup(blob, bd);
 	ft_board_info_fixup(blob, bd);
-- 
2.53.0

