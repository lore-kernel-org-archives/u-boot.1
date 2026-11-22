Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF6F606A320
	for <u-boot@archiver.kernel.org>; Sun, 22 Nov 2026 00:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=xvezguGI;
	dkim=pass (4096-bit key, unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=Yw8c5YRG
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 32E356074C;
	Sun, 22 Nov 2026 00:33:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Vc1w5q84Tr7K; Sun, 22 Nov 2026 00:33:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org F07CB6073E
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795307603;
	b=RWaWwTsjuUo81kFjInsJux25+gRjjh9Sf745dP6K3nl1BUa4jQpWnO7ciMjm7o6egHFX
	 si7j1xaOhHmWOprGENWbWgrVlfhplSCzcPEEctvHGuh+honaKF5PzJuTwZ/x8UwRghj4B
	 FiiRZHnAEkzQ1cWcS0xo1+rxlRwX/OMpjZ2ggW7VI5CPUspA/W+2wDHOSJv1M5MSKL+gi
	 FboQNoWyTlRAY7AG2MdGd8FwaI3FRhiL5k/Yi0+qh3tc8PwSao2/yNcAA860cLfexW99t
	 APSq9hYvsyJ03rbuAcvihG88+rE0gg2Y2mdYNo/O0nqsj6n0tlZUeIYlbTQ6i3OE7YA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795307603;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=9/4G1G6iRzmPLZNdwffZq2ksaFNC2qz43VrMEU9SJJw=;
	b=mSHQbosPvZghxVGBnfNV4h0PyiWwhG7I2CgX+/7GGKeselaSThJndI7btEC0PASr+gdE
	 gNNa3XAEELZgwCLliTlx3CdiYaJuKofH4bz1CYMshPWqkbQKwZ0appIduvHmjOhl1DHDr
	 vlLWdf083ZVHY6ReWUMna3JEldjk5NbkE94Puz5BaLaEyQrENFUjRqdv6zPThkMqF6DTc
	 2CJo7+G19wFpBc9rY8c1OhGcwzQFjtLlaStH9+mbqjhdYpFUo7wpD1kTPD77JskJsZlci
	 APONj1F1QHYJrr0jzpHJuBOqpC+rhoYgOVWXRpFnboyhPDBGrpZN6T3I1i/8vifVW1A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795307603;
	bh=9/4G1G6iRzmPLZNdwffZq2ksaFNC2qz43VrMEU9SJJw=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=xvezguGIMMmRW3K3pWp4m4Hu4sUx/gjFnOL13hBR8Yfvjs2A8+kvD3jgFZOBIQXSo
	 zR8Fj2XEnOoq1aWRQB9b4KPmgzshKjlpAlwdIxRlrsbCxABKxr3Xqeb4594lfJ4jI5
	 wfOzif5sjV12DEoucoz6fMmJIT2pPYwZtham5k8Tkx0EZ+VGhWFcWtzymSoyHQO9+l
	 lMbf/K2ZvZJ65UwxvGyGk/+YRchXpKMtdiaIyCYmSj/r1dFiXCRJ6t7k03XnV4YK0p
	 wk9Pc/8D7IqDUp/bpB5ugpz9x2Q20j+HvpRXsK0XNsu95ZCzCzE5DaqHFD1IpfrORO
	 PvHKw+dm3x6JQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id F07CB6073E;
	Sun, 22 Nov 2026 00:33:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0C96B260
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 00:33:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E6B7F406AF
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 00:33:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Fo-xs3qN03xV for <u-boot@lists.u-boot-project.org>;
 Sun, 22 Nov 2026 00:33:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9176E405BF
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.120
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.120;
 helo=smtp-relay-canonical-0.canonical.com;
 envelope-from=heinrich.schuchardt@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=Yw8c5YRG
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9176E405BF
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 00:33:18 +0000 (UTC)
Received: from LT03 (dynamic-176-006-023-119.176.6.pool.telefonica.de
 [176.6.23.119])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 6473A42CE1; 
 Sun, 22 Nov 2026 00:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1795307596;
 bh=9/4G1G6iRzmPLZNdwffZq2ksaFNC2qz43VrMEU9SJJw=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=Yw8c5YRGrGZBjSkXQNlfivNbVxYmn6Vmqqmq/Hdbj5+FRkrjgmEXgZrHOPBh9rV66
 UzJNNBujdrGo/m1szRq80klrmRREUi55hC4imwPkKnpDVwYrvy2lUgvkxgNqjUCXY7
 JPl7Xl4uzKDctT6lgYP/na99ZtNzWzh4TOmnPmAfxVjTgWM6YOtaVZTPzyhLgIBQAc
 V+t+hFRRtIpq4AZkh7wS5puzvc7h5oxZWbXj2Lyxka6QyWti4eSn/mv6BfLJKXGEO6
 mDzsxDti1U7t6G6iJVdVsGEBiI8azaf48aWFc/r0BFrDyFgYak5eFyvGN8xFzt0FIC
 UNXK7mPpLpA5VkNvXuZD0lt01GV++ZjTKkOInuT8QiZlLD1t3DoyFpp5P4ho6mFLgs
 S8n55xHDmm/Gs5D6YLW1a4CDHIgRZ03LJj6cnskCqe888XIsv5vAGd+NlfthFYkZCV
 +B6V+LbiKIT6dWaOjnrvUjkJ0UB/SxQCPZbSbLpmJ6teIEGpcwjZGiNzHnFJCKITGy
 H6O8OAvOCKWGctlBFztBl/amIspkwtKPDQWoTkOG0KFp4nhgu1ctRO1LpQ8Y/aeuro
 KLWBMegB7FPhgONVGrL1INFN+3bzabbjq7AQqVsqaV6BjWW9MQkYQDXfCVI4jqDKd+
 tw1Gfeccx8yh1QUfBg9nQTMs=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Ying-Chun Liu <paul.liu@linaro.org>,
 u-boot@lists.u-boot-project.org,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] efi_loader: correct EFI_SYSTEM_TABLE_POINTER crc32
Date: Sun, 22 Nov 2026 01:33:12 +0100
Message-ID: <20261122003312.134216-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The UEFI specification 2.12 draft clarifies that the crc32 value
must not include padding bytes at the end of the structure but
instead should only be calculated over the exactly 20 bytes of
the fields defining the structure (Mantis 2521).

Fixes: aaf7be96c2c1 ("efi: add EFI_SYSTEM_TABLE_POINTER for debug")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/efi_loader/efi_debug_support.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/efi_loader/efi_debug_support.c b/lib/efi_loader/efi_debug_support.c
index 8d0c133871e..e191e5121e3 100644
--- a/lib/efi_loader/efi_debug_support.c
+++ b/lib/efi_loader/efi_debug_support.c
@@ -45,9 +45,12 @@ efi_status_t efi_initialize_system_table_pointer(void)
 
 	systab_pointer->signature = EFI_SYSTEM_TABLE_SIGNATURE;
 	systab_pointer->efi_system_table_base = (uintptr_t)&systab;
+	/* Don't include trailing padding bytes in CRC32. */
 	systab_pointer->crc32 = crc32(0,
 				      (const unsigned char *)systab_pointer,
-				      sizeof(struct efi_system_table_pointer));
+				      offsetof(struct efi_system_table_pointer,
+					       crc32) +
+				      sizeof(systab_pointer->crc32));
 
 	return EFI_SUCCESS;
 }
-- 
2.53.0

