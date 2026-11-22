Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE82606A32C
	for <u-boot@archiver.kernel.org>; Sun, 22 Nov 2026 16:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=lX8ZBGYw;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.a=rsa-sha256 header.s=default header.b=Y9NXQw6K;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=valla.it header.i=@valla.it header.a=rsa-sha256 header.s=default header.b=V3LuwQgE
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2B495404F8;
	Sun, 22 Nov 2026 16:04:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 60TM59RPc27r; Sun, 22 Nov 2026 16:04:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6F6F7403FC
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795363487;
	b=XdfGNSv1hbxntXJl+f27OEuddM92tfqNxQBeWa+s0+4NnKXfAC1yuMp3Kq92m858ozU+
	 3TDtY2w7aF/719KBXy5tpGYveoORyY0YnLaYNChM2eMnHR2bCCmzeNt+TqFIvKRTlTUbi
	 Dzav3jqqKgNf1r80boc/ZpaCc3yI8F677Zel5N1+k/pGMlEuYKSCnz9R9SLF+otMk9wHZ
	 C7w1Dsd59UOMqW1XWUjLLNMUbxcrhBCFMANSLbRadn30hLOfdiL4rkCygQNp1a4AVg5v8
	 CdCcaYpbk6TN1YvEA45l45chaKXa7vXbotfgMSEVsY8B0kcDAzNsyoJYrJambgV3iRQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795363487;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:DKIM-Signature:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-Source:X-Source-Args:X-Source-Dir:X-SGantispam-id:
	 X-AntiAbuse:AntiSpam-DLS:AntiSpam-DLSP:AntiSpam-DLSRS:AntiSpam-TS:
	 CFBL-Address:CFBL-Feedback-ID:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=vEIXuMGhhfQ5DBOIIkE6Sk481RMvdJJQp7QcKso0oao=;
	b=iXEgp8G54m/NqouYBNFqzYjn+kgyUetD1kdqma6kSPKDcpuPW/ugT1KD1b8g5DqnZrjv
	 uGLyTPaiSj1FKw6B7DTmDK61NEIp1whMFusx2U9At2fkivNKqpneaBDKKN7R37Wr7xYbd
	 PE+e767JWoupXZO8lfppm1CQkM5hhrnXwzumDEkQgmquMgzwHbVuc1t6cyhZCDNpNboRI
	 TdWlGgtV5RI+2HSQLEFfBtXfyFqbEs9OQlM/hiTca5OtY2AYxB9WaXWJPNs7mBEB49D+G
	 Iibw5F0Z9JHuXu+wiAVcjxeNxFBX5FFvSLw8iMt1BbGG+cAX0w3oYazB8on+18VYV7w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795363487;
	bh=vEIXuMGhhfQ5DBOIIkE6Sk481RMvdJJQp7QcKso0oao=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=lX8ZBGYwpat+zpctsWgXI2qQT2nU6O1aoi0KLxcb7d6T+RQTjrFsMsA6mocHV1c+6
	 L6XADpfoLBx3xc/CwUBaN4c8JiuY/ljkpPHsU72eUItsr6pm9cpFkW765linmj6vBH
	 u7usHe/2+/1fTEZRa1FwTOo98TzlbLJCTWoWj61I8xfFhwUMU9ZjE4D1xTP1tjmhPJ
	 TPUVdEdNTpQASO8FJJvaKVpV0GO/DaXLR0/QrB9jFMXsXaE07E7OlHgBLzrjn5tuCM
	 GnkL02gSS4c1LPJpQMMQNZzOZtbmwRIJeKljF9/7ytdtLXIzv4Yya6S7HBPRRqErsy
	 l4YwMs2fB+HFA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6F6F7403FC;
	Sun, 22 Nov 2026 16:04:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0C4A31AB
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 16:04:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 09E20400BC
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 16:04:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id djdu55-jRhgq for <u-boot@lists.u-boot-project.org>;
 Sun, 22 Nov 2026 16:04:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 0865B400B3
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=185.56.87.5
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.56.87.5;
 helo=delivery.antispam.mailspamprotection.com;
 envelope-from=francesco@valla.it; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=antispam.mailspamprotection.com
 header.i=@antispam.mailspamprotection.com header.a=rsa-sha256
 header.s=default header.b=Y9NXQw6K; 
 dkim=pass (1024-bit key,
 unprotected) header.d=valla.it header.i=@valla.it header.a=rsa-sha256
 header.s=default header.b=V3LuwQgE
Received: from delivery.antispam.mailspamprotection.com
 (delivery.antispam.mailspamprotection.com [185.56.87.5])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0865B400B3
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 16:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
 :Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject
 :Date:From:Reply-To:List-Unsubscribe;
 bh=vEIXuMGhhfQ5DBOIIkE6Sk481RMvdJJQp7QcKso0oao=; b=Y9NXQw6K2bLHqzZfarFYigqbCG
 JNQouUk7Gi6JoCEPa5GHHDy3XGRAEkrblZ2dQ+KKpGQ8/AAxxkQ+wedTCNQIP2/XQ+XFoBMtKAK7A
 kHmHzuPnincqniQMeoEe9VO94gQ8xeM19VKe1JPlBPPcjCHIim/Vimcs3cndy8fkHDpM=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214]
 helo=esm19.siteground.biz)
 by instance-europe-west4-4zq2.prod.antispam.mailspamprotection.com with
 esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <francesco@valla.it>) id 1xVA3U-00000005HQv-2oAJ
 for u-boot@lists.u-boot-project.org; Sun, 22 Nov 2026 16:04:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
 s=default; h=Cc:To:Subject:Date:From:list-help:list-unsubscribe:
 list-subscribe:list-post:list-owner:list-archive;
 bh=vEIXuMGhhfQ5DBOIIkE6Sk481RMvdJJQp7QcKso0oao=; b=V3LuwQgES5uaOtp5PC3m5zXBQg
 dUbZ1RtNLqCCw+R+NLAif4bMN063AwDx5G5xQDORAle4cgLG6Iv6/6JbHfP+HlOVflsnni0KIxjh5
 5t6WL1qc5aYOrftKRs0d3DNW0ZmhlAooD0Sxc2VK/lZQQF1ZGpSOyR77B009BQB0eQJY=;
Received: from [95.251.96.187] (port=62688 helo=[10.0.0.1])
 by esm19.siteground.biz with essmtpa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.100.1) (envelope-from <francesco@valla.it>)
 id 1xVA3L-000000005wb-2v8C; Sun, 22 Nov 2026 16:04:31 +0000
From: Francesco Valla <francesco@valla.it>
Date: Sun, 22 Nov 2026 17:04:20 +0100
Subject: [PATCH] boot: pxe: pass initrd to PE/COFF EFI applications
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261122-pxe-coff-initrd-v1-1-6b0feedf18c4@valla.it>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ7CIBBA0as0s3YSGFs0XsW4ADrUcUEbQEPS9
 O7FdvkW/6+QOQlneHQrJP5Jljk26EsH/m3jxChjM5AiozURLpXRzyGgRClpRDeY2723iq5OQ6u
 WxEHqcXy+Tuev+7Av/w1s2w6lOYN0cwAAAA==
X-Change-ID: 20261122-pxe-coff-initrd-b56784a023b1
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Alexey Charkov <alchark@flipper.net>, 
 Suraj Kakade <suraj.hanumantkakade@amd.com>, 
 Francesco Valla <francesco@valla.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2867; i=francesco@valla.it;
 h=from:subject:message-id; bh=1MQsO30/7dGAXKbDVY/0ydwRCCgF/FRp3vp/2ti2dwg=;
 b=owGbwMvMwCX2aH1OUIzHTgbG02pJDNnMQh1OT059k+m3WOWWtaav059fryOA8WBtq9iJH7PzP
 d+Hl6/uKGVhEONikBVTZAlZd+Penrnm39I2MD6CmcPKBDKEgYtTACZyNZ+RYfMCjffHf9nNsnos
 28+03DDq9LbE/7M/unBOENqn9MNZ9wvD/xqzjV4hfUbbcl2kMtZaLmi/8oH3rX/6I9vHPDr97qd
 XsAEA
X-Developer-Key: i=francesco@valla.it; a=openpgp;
 fpr=CC70CBC9AA13257C6CCED8669601767CA07CA0EA
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - lists.u-boot-project.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: bbccc9c5572202253d1cc0772307ae97
X-AntiAbuse: ID - bbccc9c5572202253d1cc0772307ae97
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1xVA3U-00000005HQv-2oAJ-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-4zq2.prod.antispam.mailspamprotection.com; 
 iprev=pass (214.173.214.35.bc.googleusercontent.com)
 smtp.remote-ip=35.214.173.214; 
 auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
 dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
 arc=none
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When the kernel downloaded by PXE/extlinux is a PE/COFF image (e.g. an
EFI stub kernel), label_boot() runs it with efi_binary_run(). The
initrd given in the label is downloaded to ramdisk_addr_r, but it is
never handed over to the EFI application, as efi_binary_run() is called
with a hardcoded NULL initrd with size equal to zero.

Track the size of the downloaded initrd and pass it, together with its
address, to efi_binary_run(), which exposes it to the EFI application
through the EFI_LOAD_FILE2 initrd protocol.

Fixes: 841abbc6d561 ("boot: pxe: support booting PE/COFF EFI applications")
Signed-off-by: Francesco Valla <francesco@valla.it>
---
 boot/pxe_utils.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
index c60429a5e12b..351777cd8bef 100644
--- a/boot/pxe_utils.c
+++ b/boot/pxe_utils.c
@@ -528,6 +528,7 @@ int label_boot(struct pxe_context *ctx, struct pxe_label *label)
 	char *zboot_argv[] = { "zboot", NULL, "0", NULL, NULL };
 	char *kernel_addr = NULL;
 	char *initrd_addr_str = NULL;
+	ulong initrd_size = 0;
 	char initrd_filesize[17];
 	char initrd_str[28];
 	char mac_str[29] = "";
@@ -586,15 +587,15 @@ int label_boot(struct pxe_context *ctx, struct pxe_label *label)
 		ulong size;
 		if (get_relfile_envaddr(ctx, label->initrd, "ramdisk_addr_r",
 					(enum bootflow_img_t)IH_TYPE_RAMDISK,
-					&size) < 0) {
+					&initrd_size) < 0) {
 			printf("Skipping %s for failure retrieving initrd\n",
 			       label->name);
 			goto cleanup;
 		}
-		strcpy(initrd_filesize, simple_xtoa(size));
+		strcpy(initrd_filesize, simple_xtoa(initrd_size));
 		initrd_addr_str = env_get("ramdisk_addr_r");
 		size = snprintf(initrd_str, sizeof(initrd_str), "%s:%lx",
-				initrd_addr_str, size);
+				initrd_addr_str, initrd_size);
 		if (size >= sizeof(initrd_str))
 			goto cleanup;
 	}
@@ -807,13 +808,18 @@ int label_boot(struct pxe_context *ctx, struct pxe_label *label)
 	if (IS_ENABLED(CONFIG_CMD_BOOTEFI) &&
 	    efi_check_pe(buf, kernel_size, NULL) == EFI_SUCCESS) {
 		void *fdt = EFI_FDT_USE_INTERNAL;
+		void *initrd = NULL;
 		efi_status_t efi_ret;
 
 		log_debug("using bootefi\n");
 		if (bootm_argv[3])
 			fdt = map_sysmem(hextoul(bootm_argv[3], NULL), 0);
 
-		efi_ret = efi_binary_run(buf, kernel_size, fdt, NULL, 0);
+		if (initrd_size)
+			initrd = map_sysmem(hextoul(initrd_addr_str, NULL), 0);
+
+		efi_ret = efi_binary_run(buf, kernel_size, fdt, initrd,
+					 initrd_size);
 		if (efi_ret != EFI_SUCCESS)
 			log_err("efi_binary_run failed (ret=%lu)\n", efi_ret);
 	/* Try bootm for legacy and FIT format image */

---
base-commit: e578056c766d653270b14557c2a9d8daec414c17
change-id: 20261122-pxe-coff-initrd-b56784a023b1

Best regards,
--  
Francesco Valla <francesco@valla.it>

