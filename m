Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7337C88E75
	for <u-boot@archiver.kernel.org>; Mon, 14 Sep 2026 14:17:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 993B06071C;
	Mon, 14 Sep 2026 14:17:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uy7w-Sq03gwU; Mon, 14 Sep 2026 14:17:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 73AC960706
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789395467;
	b=dKlhTGNVfajxw4ihxkioo6Ge0kZZoBCW03kL3Qav6raxq74UPglW/lkSgtQmmLg8kvG9
	 U6yfHNSYO8yZL7MTwNY/KQXZzeUNUWqJLzlzlzZY1XltpSn+u+274Z5PBxsEW3SUGTp7E
	 xDNo7MFj7bCDeRiycZ1FbyrKgnv6RhEvBqelvKGbMHaNQFz74usHy5Pzkywg0p4re19ok
	 6xz58Hbb3VlKXV1hHHs6GPqwDkK8b+MFvL2cegJJaUwzt3ufCqNc8OyUpO/N45G+rJWtc
	 iQGAVBNd2aLsOw7A+AC0nTPK5kqb+Q2VSPg99hgM0fCmJ4AtL+9RQoMt6wqfB1UTF1Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789395467;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=uAazX60UNTMtVrOsQ4SnMbMvtO3FHhW0P1y0ahqDHXI=;
	b=ddDq9yMUJWf755q+TDXHhHBfNfqBQjf59BBQAZJPnqhvqRvlrluea1gxHumoKslWBywb
	 GsbyXTSxmmpqxdnYw/52TPLkUmXeQQ62rQKhe6NAKyd8JI2m1XfYGRKfO/v9SUgnrBTIX
	 bUhxojKESeko2N6OltPDQvtT26jFZqcU+2caWCa3BVcfoavW6gKgfwG57/40RB7L08vZS
	 NWQr35ONqqq+92W6bBGKfO4v3Sk7ztaccNcZ8As4R/zHwk2jTnTV0GPODP/kU9UBACW/y
	 N3EfPzvYSQ97zcTk57DqNSIUV0S4cVUWnhT1+CZWpYeTAGgQS11pxqEVknFPzM9Ulcw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789395467;
	bh=uAazX60UNTMtVrOsQ4SnMbMvtO3FHhW0P1y0ahqDHXI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qCLoHfXR6gUUT1hPsGxTsbIu0OZonGCainhvmlG14NRPKG1Z+/GIonota2TEFikAi
	 ixDIMto1hBSux6o31s40u8LehWhxSONF3KpuXyEmkS15Eq+vyrf+E5RwGfXIVcYpl2
	 dP8bpN+/H/yzpvFKxnNL14BUxN7fpDu92gZTltAEImid9/UzUFelSt3Jz7nwzTSxrA
	 fu1agUmoAlFbVpY1iM/qUjQXEPthcu20xung2bGoQO8hE2CgYv+DRX9G9jrdl/jBd3
	 j6onlBkCc8C7/IyxtgGVN0dL2cWQS0KcFT3gQvPmBt3R+Kl1qOqAzHR75++s/OFrZD
	 FZ1CsimDFbKbQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 73AC960706;
	Mon, 14 Sep 2026 14:17:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3527849D
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 11:10:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1BDC740631
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 11:10:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AZsY42tlbJcF for <u-boot@lists.u-boot-project.org>;
 Mon, 14 Sep 2026 11:10:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 005924062C
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789384217;
 b=Lur6OqpOgLU1KwWsWWrfKCebVrwj510+lASNX2I9b0si/PToLWyEu3p5aSpzAjaHbUlu
 AAzU4QqLG9E3ftNH+EA5Ozt7JYrsAwZ4W26xw74MuowDIFSnICL3hrcanFU3WTlEdL1Ah
 umiXBn7+aqoWvEmj33UbwUq73o8eiknCTOeG6JTnoQVwsaTzzud2firVT+LQN9xaAVP54
 sMUasBYWgMFOjgnm4OUy/dtGghS4ImhNDDXUnKxSrABORXpJU3Jr7NznejaNpmGJmf267
 nMpfPn7bMX7zxkn9qMLIjN8oFjC5thFmhSo3Km/Y1rdrMpRUFSQnCO+WHvyQQfg0kqQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789384217;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=uAazX60UNTMtVrOsQ4SnMbMvtO3FHhW0P1y0ahqDHXI=;
 b=sr0t4Qovm4OfxglRQWLaEhkvGsoRUUaPvRxKCQ9HHowcMTXu5gEioAEF8qxtpnD1vFAM
 r+2uJQGtad3m9lFVmG0MF2HzViq96BY9A+DDVk/P+6Yxxttj/kzbC4ZX+Urh9L7PkfuXA
 5EqzrhHmFLrF27l8EB92KSKsdW2Bi0uBxSohGEhwUHrgmI6cMGQQOIIr/9+tnav6/7emA
 ++ztoPaYNmLLTow//vYZuMFj6IllKKTpaMM46eZeQzV2lIBDq1ZNFDMKKDmF/0u0aIY7g
 NkHgDoWeVxZlmqdi5qXEC8Dl6FkSmB05E+skjHB6VOfQCp4zWd1Y4J2LEbolJhALNkg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b=kqrtJc9o; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=harsimransingh.tungal@arm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=kqrtJc9o
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 005924062C
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 11:10:16 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D5EDB1E5E;
 Mon, 14 Sep 2026 04:01:42 -0700 (PDT)
Received: from e132995.arm.com (unknown [10.57.49.141])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 198703F86F;
 Mon, 14 Sep 2026 04:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1789383706; bh=SPpkK/FWDfPDjrbLIfGa8MwHp+0IPQ0N7DyvxWwbA/Q=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=kqrtJc9oIuzoVe0kjlNZsqVI2cgsqULnytZgAaLY0xrk/SbCxwZb4DoyQYkEdnVFF
 FX4OCNdbFbE7EASAKbw5yIM5UVbfxPDltBy6KNanKF47op0rnS9itHF/x2d/xarpLJ
 H6fV5c8Gavfo/3KP9BxIFKl0mhMpfMYaslJIC3ao=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Devaraj Ranganna <Devaraj.Ranganna@arm.com>,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Subject: [PATCH v5 11/22] efi_loader: make FF-A MM communication runtime-safe
Date: Mon, 14 Sep 2026 12:00:55 +0100
Message-Id: <20260914110106.1974894-12-harsimransingh.tungal@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260914110106.1974894-1-harsimransingh.tungal@arm.com>
References: <20260914110106.1974894-1-harsimransingh.tungal@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 14 Sep 2026 14:17:12 +0000
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

Make the FF-A MM communication helper usable from EFI runtime code. The
boot path copies requests into the configured FF-A shared buffer, while
the runtime path operates directly on the runtime communication buffer.

Use range-based cache maintenance on the active shared-buffer request
and response sizes, and document the shared-buffer cacheline-alignment
requirements in Kconfig.

Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>

---
Changelog:
===============

v3:

Simon:

- Restrict arm64 cache maintenance to the cacheline-rounded request and
  response sizes
- Reword the commit message for the BUILD_BUG_ON() checks

v2:

Ilias, Simon:

- Collapse boot and runtime MM communication helpers
- Document the FF-A shared buffer cacheline-alignment requirement and
  add BUILD_BUG_ON() checks for the address and size
---
 lib/efi_loader/Kconfig            |   4 +
 lib/efi_loader/efi_variable_tee.c | 130 +++++++++++++++++++++---------
 2 files changed, 95 insertions(+), 39 deletions(-)

diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index 4cb13ae7c8a..a9791b8f2e3 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -195,6 +195,8 @@ config FFA_SHARED_MM_BUF_SIZE
 	  the MM SP in secure world.
 	  The size of the memory region must be a multiple of the size of the maximum
 	  translation granule size that is specified in the ID_AA64MMFR0_EL1 System register.
+	  For arm64 FF-A cache maintenance, this size must also be aligned to
+	  CONFIG_SYS_CACHELINE_SIZE.
 	  It is assumed that the MM SP knows the size of the shared MM communication buffer.
 
 config FFA_SHARED_MM_BUF_OFFSET
@@ -211,6 +213,8 @@ config FFA_SHARED_MM_BUF_ADDR
 	  This defines the address of the shared MM communication buffer
 	  used for communication between the MM feature in U-Boot and
 	  the MM SP in secure world.
+	  For arm64 FF-A cache maintenance, this address must also be aligned to
+	  CONFIG_SYS_CACHELINE_SIZE.
 	  It is assumed that the MM SP knows the address of the shared MM communication buffer.
 
 config EFI_VARIABLE_SF_OFFSET
diff --git a/lib/efi_loader/efi_variable_tee.c b/lib/efi_loader/efi_variable_tee.c
index 9cae7b7e5ac..7f35ac7dd22 100644
--- a/lib/efi_loader/efi_variable_tee.c
+++ b/lib/efi_loader/efi_variable_tee.c
@@ -22,6 +22,7 @@
 #include <efi_api.h>
 #include <efi_loader.h>
 #include <efi_variable.h>
+#include <linux/build_bug.h>
 #include <linux/kernel.h>
 #include <malloc.h>
 #include <mapmem.h>
@@ -301,77 +302,128 @@ static int ffa_discover_mm_sp_id(void)
 }
 
 /**
- * ffa_mm_communicate() - Exchange EFI services data with  the MM partition using FF-A
+ * ffa_mm_communicate() - Exchange EFI services data with the MM partition using FF-A
  * @comm_buf:		locally allocated communication buffer used for rx/tx
- * @dsize:				communication buffer size
+ * @comm_buf_size:	communication buffer size
  *
  * Issue a door bell event to notify the MM partition (SP) running in OP-TEE
  * that there is data to read from the shared buffer.
  * Communication with the MM SP is performed using FF-A transport.
  * On the event, MM SP can read the data from the buffer and
  * update the MM shared buffer with response data.
- * The response data is copied back to the communication buffer.
+ * The response data is copied back to the communication buffer during the
+ * boot phase. At runtime, the communication buffer is already the FF-A
+ * shared buffer and is updated in place.
  *
- * Return:
- *
- * EFI status code
+ * Return: EFI status code
  */
-static efi_status_t ffa_mm_communicate(void *comm_buf, ulong comm_buf_size)
+static efi_status_t __efi_runtime ffa_mm_communicate(void *comm_buf,
+						     ulong comm_buf_size)
 {
+	ulong hdr_cache_size;
 	ulong tx_data_size;
+	ulong tx_cache_size;
 	int ffa_ret;
 	efi_status_t efi_ret;
 	struct efi_mm_communicate_header *mm_hdr;
-	void *virt_shared_buf;
+	u8 *shared_buf;
+	bool at_runtime = efi_at_runtime();
 
 	if (!comm_buf)
 		return EFI_INVALID_PARAMETER;
 
-	/* Discover MM partition ID at boot time */
-	if (!mm_sp_id && ffa_discover_mm_sp_id()) {
-		log_err("EFI: Failure to discover MM SP ID at boot time, FF-A MM comms failure\n");
-		return EFI_UNSUPPORTED;
+	if (!mm_sp_id) {
+		if (at_runtime)
+			return EFI_UNSUPPORTED;
+		if (ffa_discover_mm_sp_id())
+			return EFI_UNSUPPORTED;
 	}
 
 	mm_hdr = (struct efi_mm_communicate_header *)comm_buf;
 	tx_data_size = mm_hdr->message_len + sizeof(efi_guid_t) + sizeof(size_t);
+	hdr_cache_size = ALIGN(sizeof(*mm_hdr), CONFIG_SYS_CACHELINE_SIZE);
+	tx_cache_size = ALIGN(tx_data_size, CONFIG_SYS_CACHELINE_SIZE);
 
 	if (comm_buf_size != tx_data_size || tx_data_size > CONFIG_FFA_SHARED_MM_BUF_SIZE)
 		return EFI_INVALID_PARAMETER;
 
-	/* Copy the data to the shared buffer */
-
-	virt_shared_buf = map_sysmem((phys_addr_t)CONFIG_FFA_SHARED_MM_BUF_ADDR, 0);
-	memcpy(virt_shared_buf, comm_buf, tx_data_size);
+	if (at_runtime) {
+		shared_buf = comm_buf;
+	} else {
+		/* Copy the data to the shared buffer */
+		shared_buf = map_sysmem((phys_addr_t)CONFIG_FFA_SHARED_MM_BUF_ADDR, 0);
+		memcpy(shared_buf, comm_buf, tx_data_size);
+	}
 
 	/*
-	 * The secure world might have cache disabled for
-	 * the device region used for shared buffer (which is the case for Optee).
-	 * In this case, the secure world reads the data from DRAM.
-	 * Let's flush the cache so the DRAM is updated with the latest data.
+	 * Shared buffer cache maintenance for FF-A / OP-TEE communication:
+	 *
+	 * NS -> S (request path):
+	 *
+	 * The non-secure side populates the shared buffer. If the buffer is cached
+	 * in NS, the updated bytes may reside in dirty D-cache lines and not yet be
+	 * visible in DDR. Since the secure world typically reads the shared buffer
+	 * directly from DDR (e.g. with caches disabled / non-coherent mapping), we
+	 * must clean the corresponding cache lines to the Point of Coherency (PoC)
+	 * before entering secure world.
+	 *
+	 * S -> NS (response path):
+	 *
+	 * The secure world may update the same shared buffer in DDR. After returning
+	 * to non-secure, any cached copies of that region in NS may be stale. We
+	 * therefore invalidate the shared buffer range after the FF-A call to drop
+	 * those lines and force subsequent reads to fetch the latest data from DDR.
+	 *
+	 * Note: Whole-cache invalidation must not be used in EFI runtime context.
+	 * After ExitBootServices(), the OS owns the cache hierarchy; global
+	 * invalidation could drop OS dirty lines and violate the OS coherency
+	 * model. Always operate on the shared buffer range only.
 	 */
-#ifdef CONFIG_ARM64
-	invalidate_dcache_all();
-#endif
+	if (IS_ENABLED(CONFIG_ARM64)) {
+		BUILD_BUG_ON(CONFIG_FFA_SHARED_MM_BUF_ADDR %
+			     CONFIG_SYS_CACHELINE_SIZE);
+		BUILD_BUG_ON(CONFIG_FFA_SHARED_MM_BUF_SIZE %
+			     CONFIG_SYS_CACHELINE_SIZE);
+		flush_dcache_range((unsigned long)shared_buf,
+				   (unsigned long)(shared_buf +
+					   tx_cache_size));
+	}
 
 	/* Announce there is data in the shared buffer */
-
 	ffa_ret = ffa_notify_mm_sp();
 
 	switch (ffa_ret) {
 	case 0: {
 		ulong rx_data_size;
-		/* Copy the MM SP response from the shared buffer to the communication buffer */
-		rx_data_size = ((struct efi_mm_communicate_header *)virt_shared_buf)->message_len +
+		ulong rx_cache_size;
+
+		if (IS_ENABLED(CONFIG_ARM64))
+			invalidate_dcache_range((unsigned long)shared_buf,
+						(unsigned long)(shared_buf +
+							hdr_cache_size));
+
+		rx_data_size = ((struct efi_mm_communicate_header *)shared_buf)->message_len +
 			sizeof(efi_guid_t) +
 			sizeof(size_t);
 
-		if (rx_data_size > comm_buf_size) {
+		if (rx_data_size > comm_buf_size ||
+		    rx_data_size > CONFIG_FFA_SHARED_MM_BUF_SIZE) {
 			efi_ret = EFI_OUT_OF_RESOURCES;
 			break;
 		}
 
-		memcpy(comm_buf, virt_shared_buf, rx_data_size);
+		if (IS_ENABLED(CONFIG_ARM64)) {
+			rx_cache_size = ALIGN(rx_data_size,
+					      CONFIG_SYS_CACHELINE_SIZE);
+			if (rx_cache_size > hdr_cache_size)
+				invalidate_dcache_range((unsigned long)(shared_buf +
+							hdr_cache_size),
+						(unsigned long)(shared_buf +
+							rx_cache_size));
+		}
+
+		if (!at_runtime)
+			memcpy(comm_buf, shared_buf, rx_data_size);
 		efi_ret = EFI_SUCCESS;
 		break;
 	}
@@ -391,7 +443,8 @@ static efi_status_t ffa_mm_communicate(void *comm_buf, ulong comm_buf_size)
 		efi_ret = EFI_ACCESS_DENIED;
 	}
 
-	unmap_sysmem(virt_shared_buf);
+	if (!at_runtime)
+		unmap_sysmem(shared_buf);
 	return efi_ret;
 }
 
@@ -427,8 +480,8 @@ static enum mm_comms_select __efi_runtime get_mm_comms(void)
 #endif
 
 /**
- * mm_communicate() - Adjust the communication buffer to the MM SP and send
- * it to OP-TEE
+ * mm_communicate() - Adjust the communication buffer to the MM SP and send it
+ * to the selected MM transport
  *
  * @comm_buf:		locally allocated communication buffer
  * @dsize:		buffer size
@@ -438,11 +491,12 @@ static enum mm_comms_select __efi_runtime get_mm_comms(void)
  * When using the u-boot OP-TEE driver, StandAlonneMM is supported.
  * When using the u-boot FF-A  driver, any MM SP is supported.
  *
- * Return:		status code
+ * Return: status code
  */
-static efi_status_t mm_communicate(u8 *comm_buf, efi_uintn_t dsize)
+static efi_status_t __efi_runtime mm_communicate(u8 *comm_buf,
+						 efi_uintn_t dsize)
 {
-	efi_status_t ret;
+	efi_status_t ret = EFI_UNSUPPORTED;
 	struct efi_mm_communicate_header *mm_hdr;
 	struct smm_variable_communicate_header *var_hdr;
 #if CONFIG_IS_ENABLED(ARM_FFA_TRANSPORT)
@@ -457,16 +511,14 @@ static efi_status_t mm_communicate(u8 *comm_buf, efi_uintn_t dsize)
 	mm_comms = get_mm_comms();
 	if (mm_comms == MM_COMMS_FFA)
 		ret = ffa_mm_communicate(comm_buf, dsize);
-	else
+	else if (mm_comms == MM_COMMS_OPTEE)
 		ret = optee_mm_communicate(comm_buf, dsize);
 #else
-		ret = optee_mm_communicate(comm_buf, dsize);
+	ret = optee_mm_communicate(comm_buf, dsize);
 #endif
 
-	if (ret != EFI_SUCCESS) {
-		log_err("%s failed!\n", __func__);
+	if (ret != EFI_SUCCESS)
 		return ret;
-	}
 
 	return var_hdr->ret_status;
 }
-- 
2.34.1

