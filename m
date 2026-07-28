Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FD45C531F9
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 11:36:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0D977409F4;
	Tue, 28 Jul 2026 11:36:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mEHurq8XmklI; Tue, 28 Jul 2026 11:36:18 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8F4AF409DA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785238578;
	bh=y663qX+PxEG1Pdp95JWaWmk4i788NmLh6bPBSGhuO6w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fShhDsM/UhsWpnpeWpaySKvOO94/rqcXmP9mDpK1S4JYmLDCjLOBhDFb8QdSiGSue
	 gIObTwjbqr/fERz2vJTTsrw7MgdOy8b0Ju0CRhVaYMQXlIOSZjDItqsthtvOCXsRnA
	 Jq1yE2mX6Qh+O5zjJu/WBayLyJBU/nTJGdhFoCqbCbqR3PxEmie8qMpsjKc44yWnDn
	 4UP46UBNV44uP8dvirOb73k59Bs/7oiV504F6Dym9ioiHe2iVwESp5jignDRkhqfPl
	 NUv72EIhXiEbcuhW24gZgkS5PQM2K57iGB6kxu3sp3BjEjwrMz0A+BY3/KUGS8RxLS
	 ED9N1jmpfpKHQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8F4AF409DA;
	Tue, 28 Jul 2026 11:36:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 688A042A
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:36:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4EFBC607EF
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:36:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y0kE5dYW_rlv for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 11:36:16 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=sergio.prado@e-labworks.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org D634D607ED
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D634D607ED
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D634D607ED
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:36:15 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 332AA8494B; Tue, 28 Jul 2026 13:36:14 +0200 (CEST)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB78C82991
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 13:36:11 +0200 (CEST)
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-38d489b6b71so3583745a91.0
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 04:36:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785238570; x=1785843370;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=y663qX+PxEG1Pdp95JWaWmk4i788NmLh6bPBSGhuO6w=;
 b=aGGxcPe57bMdjtRzALO7heLIxh8h1P3ebBxaTJvXVMWxImiBNqxit5MD8ogtgwZ3O8
 /iOrLU/rSjtGnhUvZ7ECe06YEEviUKZCtfzYDyZD55lDr7auG5BMlrqIRX8Zt1MzBnhB
 UbtbGMzrsiIe5Sr9SpdBhfyxQFgSC9Lm/AQDp+def4mFjBRmQXtd62emIyOLPAqlZbWI
 2gydnYKl8J8XNRbP+1VEPcrMCWMziVGyPeuiZRmyJCUk0NFyYxzbZUnIWUNA+vPzoGH/
 i8QEZt30Dev85RhJJKuG1qPujnqzerI1B8bmNtFnihgOSowVkckxhkWljQrGWTY6c5WQ
 tddA==
X-Gm-Message-State: AOJu0Yz3gFleRmOJDPK02GeJqrRG5hsDhkdx5bPREOwNK6mOcQCfO9QY
 9fWjoS2zYRzdPfIIf5D/zVD46PdZjCtPzU2zhzuppkT0KOWpgK+k9WiW+BXV8i1hKfLAmrQSLCJ
 qfrfB
X-Gm-Gg: AR+sD11mGBqN8yKNXy0K1Hom+p+pua2hWB9C4as3JX+0Pqf6d+PPQ6Hwfz/iYMQ4gwK
 1IWsHm8Be/POpArhGX4UKN6PxOuqmjoP3+dAfs848am3OvI8Tosxh/61gO0Pivuw8EW5/g8bBNf
 Mdq9rkoYUzLjXj5O796DSIE4K40UqZkv7aupqTREMtNJ4/Kidhfi50xRvnFGLUliCsXsqK31Ryn
 D7/1eCKkVO+9hn7jx27c/47u5HMQfOghQkfmpSFtzAiSKnz6tUVRf4OKw1YjTzIHZOBjqD1lJ7g
 G20EpV/DcbVE31hU5NhqijUz0hPdlKVgEJcn4XGBas0KrGTyxcxvPTH3ci2ZJXiowKrNH/bYpp0
 j8vrXU1a+OUtYZc8qVpKSTkJMPXRsNCloXsY8hdx370yK8qUflsEuOdljjHSBJYoJncsL3v981c
 29mLiFJWRL+GM+vk1AH/bjbmzAdVVNwOiVCVlqimUzXvTJQ7W7CFCkHAKVi8LvdNhheIFmqzCV2
 fcOeBYI
X-Received: by 2002:a17:90b:1a8f:b0:36d:689a:cb27 with SMTP id
 98e67ed59e1d1-38f6a46a55bmr2130153a91.24.1785238570303; 
 Tue, 28 Jul 2026 04:36:10 -0700 (PDT)
Received: from desktop.. ([2804:7f0:6400:919d:7be6:2bc2:d3d3:8617])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc419c52sm42603976eec.10.2026.07.28.04.36.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 04:36:07 -0700 (PDT)
From: Sergio Prado <sergio.prado@e-labworks.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, alpernebiyasak@gmail.com,
 marek.vasut+renesas@mailbox.org, ilias.apalodimas@linaro.org,
 pbrobinson@gmail.com, sughosh.ganu@arm.com, sergio.prado@e-labworks.com,
 wolfgang.wallner@at.abb.com, xypron.glpk@gmx.de, quentin.schulz@cherry.de,
 jj251510319013@gmail.com, Wojciech.Dubowik@mt.com
Subject: [PATCH v6 3/5] binman: ti_secure: drop the redundant keyfile re-read
Date: Tue, 28 Jul 2026 08:35:33 -0300
Message-Id: <20260728113535.128601-4-sergio.prado@e-labworks.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260728113535.128601-1-sergio.prado@e-labworks.com>
References: <20260728113535.128601-1-sergio.prado@e-labworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=e-labworks-com.20251104.gappssmtp.com; s=20251104; t=1785238570; x=1785843370;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=y663qX+PxEG1Pdp95JWaWmk4i788NmLh6bPBSGhuO6w=;
 b=IZM3poRAxJTQVJY57rD2sP9m2n2/Cu1sB+5SW5HkoopCGST4YjBfWu2Na+aHFaSIRn
 /u2EAlXTjy3HMugQ6cztcBfegzo79RezSuxTPCOVn6Sv23ZyV6mq1T2TdmGK2EWEDH+q
 FnlyZyuVZD9bmUa4HiO+GPKR1hUVx69N0EcZT7kt8fjt21CsV6xinx3eGFArwlrgn0l4
 TR6HJFgnICWCoxnmsmAaSogVV6C2+PsLMGjzSHIbgZL49j9sHsbFmAM79NafaZQy+K5u
 A4VcGJtPnIAjSRkxdsFPgSGgASxH1iUgeZbv/vF+2JSL4+uvTGSAZNcK/Vrxs0Cp9Nb4
 Szug==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=fail (p=none dis=none)
 header.from=e-labworks.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org; spf=none
 smtp.mailfrom=e-labworks.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=e-labworks-com.20251104.gappssmtp.com
 header.i=@e-labworks-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=IZM3poRA
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none)
 header.from=e-labworks.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=none
 smtp.mailfrom=sergio.prado@e-labworks.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=e-labworks-com.20251104.gappssmtp.com
 header.i=@e-labworks-com.20251104.gappssmtp.com header.b="IZM3poRA"; 
 dkim-atps=neutral
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

Entry_ti_secure and Entry_ti_secure_rom both call super().ReadNode() and
then read the 'keyfile' entry argument a second time, with exactly the
call that Entry_x509_cert.ReadNode() has already made. The second read is
pure duplication, and it means anything the parent does to
self.key_fname is silently discarded.

Drop it, so that the subclasses use the value their parent decided on,
and drop the EntryArg import which becomes unused.

No functional change.

Signed-off-by: Sergio Prado <sergio.prado@e-labworks.com>
---
 tools/binman/etype/ti_secure.py     | 3 ---
 tools/binman/etype/ti_secure_rom.py | 3 ---
 2 files changed, 6 deletions(-)

diff --git a/tools/binman/etype/ti_secure.py b/tools/binman/etype/ti_secure.py
index f6caa0286d97..705a05342a85 100644
--- a/tools/binman/etype/ti_secure.py
+++ b/tools/binman/etype/ti_secure.py
@@ -5,7 +5,6 @@
 
 # Support for generation of TI secured binary blobs
 
-from binman.entry import EntryArg
 from binman.etype.x509_cert import Entry_x509_cert
 from dataclasses import dataclass
 
@@ -110,8 +109,6 @@ class Entry_ti_secure(Entry_x509_cert):
 
     def ReadNode(self):
         super().ReadNode()
-        self.key_fname = self.GetEntryArgsOrProps([
-            EntryArg('keyfile', str)], required=True)[0]
         auth_in_place = fdt_util.GetInt(self._node, 'auth-in-place')
         if auth_in_place:
             self.firewall_cert_data['auth_in_place'] = auth_in_place
diff --git a/tools/binman/etype/ti_secure_rom.py b/tools/binman/etype/ti_secure_rom.py
index 7e90c6559409..f1bc9e7577e6 100644
--- a/tools/binman/etype/ti_secure_rom.py
+++ b/tools/binman/etype/ti_secure_rom.py
@@ -5,7 +5,6 @@
 
 # Support for generation of TI secured bootloaders booted by ROM
 
-from binman.entry import EntryArg
 from binman.etype.x509_cert import Entry_x509_cert
 
 import hashlib
@@ -71,8 +70,6 @@ class Entry_ti_secure_rom(Entry_x509_cert):
         self.sha = fdt_util.GetInt(self._node, 'sha', 512)
         self.core = fdt_util.GetString(self._node, 'core', 'secure')
         self.bootcore_opts = fdt_util.GetInt(self._node, 'core-opts')
-        self.key_fname = self.GetEntryArgsOrProps([
-            EntryArg('keyfile', str)], required=True)[0]
         if self.combined:
             self.sysfw_inner_cert = fdt_util.GetBool(self._node, 'sysfw-inner-cert', False)
             self.load_addr_sysfw = fdt_util.GetInt(self._node, 'load-sysfw', 0x00000000)
-- 
2.34.1

