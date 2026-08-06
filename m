Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A9F5C55ABF
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 12:30:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4368D607E4;
	Thu,  6 Aug 2026 12:30:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ljX7Lw-fIcPG; Thu,  6 Aug 2026 12:30:29 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 663C06072E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786019429;
	bh=YfUOjUPmphXpqn0b50ahn2FOYmkIHPCbdgM9mVJWZVU=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=hsGhY2d/ahNeCkok0InFMsJeL7u1RwCYutkGk+bHRzFWJ7b8B3akpEYnmPgl5T1Se
	 f0z9atCB1egpTTT7UPGQggE5Gbt2VaaLkgTDOUzU87wsE2HD4KvKVvFkZOo5NoBcmr
	 HG3QWIovLZQa1F4peghtPDPUSebKQr1dUDJgTqCvT0d04rbWkRvsYUA2GZjl0wyJGh
	 ivfk58HT+ZQbc32I0+dqIsyrWUGyxpbVtlMYIIghC7rp07qffzHqBFPSJf7v3a8Wd1
	 FgFyUKJyxR/rIAIUszQZHBIY/MipcvdCOoWpxMshGjg1Z5ceuJ4PAabx6PKRwHOGdW
	 xQXO/b4lWcwpA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 663C06072E;
	Thu,  6 Aug 2026 12:30:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id E6BEB218
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 12:30:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CCB9480DE2
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 12:30:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pKnRySXPk16J for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 12:30:27 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=136.143.188.15;
 helo=sender4-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org B42C180CE9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B42C180CE9
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B42C180CE9
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 12:30:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1786019420; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Fj7X41HFffhwaKT4LSsA3o8eY7Y+w5oEA3+iSoppgRF0rBamNCedzocDdXcqUKatQd3ytPvSGfZVA5lPpK/E9ZXpKg+PvaRBOMwtmQx8gkG5dT10dduQ54TWwwBQ4Au0DQqRVeV2Q+iOq2EZwY12rOFkXK783K+Bf0YHkNsdv2I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1786019420;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=YfUOjUPmphXpqn0b50ahn2FOYmkIHPCbdgM9mVJWZVU=; 
 b=nk+z4+xuqphtg9h/vEZFuxl4E8eXKmwEGYJ+8tfxaKbmzY5uiHQkWOWPXDDMwTxILGymfAYqriT/qIH4noBAkLKJfUU3nUHape8y3RAlEu5dahPmjBYyl5iZZ6RFy19f6nb/GWvYD3fxddv30g+ZkSEEe9jO3oJNLob7lS1jQB0=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
Received: by mx.zohomail.com with SMTPS id 1786019418618111.74533494827017;
 Thu, 6 Aug 2026 05:30:18 -0700 (PDT)
From: Yao Zi <me@ziyao.cc>
To: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org,
	Yao Zi <me@ziyao.cc>
Subject: [PATCH v2] buildman: Differentiate 32-bit and 64-bit LoongArch
 variants
Date: Thu,  6 Aug 2026 12:29:57 +0000
Message-ID: <20260806122957.101125-1-me@ziyao.cc>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; t=1786019420; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=YfUOjUPmphXpqn0b50ahn2FOYmkIHPCbdgM9mVJWZVU=;
 b=UhelqqK6J1i0eiEq8y+nkeXlCAls+fZlkbWfl2e1hzgehA8uRl23zrFsZEHFVpRO
 RkSx9x6kRu2PanuXpNXth/AWrh0Eyvbtqxw2yipwKEQtHFEEuXy7PGzWUo33ypb/V0S
 nbQqN+UB1vFTvXdBTGxZ5Xjex4wITCTeAGSmd4NY=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=UhelqqK6
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

Similar to RISC-V and ARM, 32-bit and 64-bit LoongArch cannot be
distinguished solely by CONFIG_SYS_ARCH, but require different
toolchains if multilib is disabled in compiler, which is the case of
toolchain provided by kernel.org.

Override the parsed arch parameter for LoongArch configs based on
CONFIG_ARCH_LA64 Kconfig symbol.

Signed-off-by: Yao Zi <me@ziyao.cc>
Reviewed-by: Simon Glass <sjg@chromium.org>
---

This patch is based on the latest main branch.

Changed from v1
- Reword the commit message
- Catch only AttributeError in the except block
- Link to v1: https://lists.u-boot-project.org/pipermail/u-boot/2026-July/627018.html

 tools/buildman/boards.py | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/buildman/boards.py b/tools/buildman/boards.py
index 2fe43c3fc896..5d5d3a3822b1 100644
--- a/tools/buildman/boards.py
+++ b/tools/buildman/boards.py
@@ -309,6 +309,17 @@ class KconfigScanner:
             else:
                 params['arch'] = 'riscv64'
 
+        # fix-up for loongarch
+        if params['arch'] == 'loongarch':
+            try:
+                value = self._conf.syms.get('ARCH_LA64').str_value
+            except AttributeError:
+                value = ''
+            if value == 'y':
+                params['arch'] = 'loongarch64'
+            else:
+                params['arch'] = 'loongarch32'
+
         return params, warnings
 
 

base-commit: baa64b2f892890f00a377eac4a3e685472bb56b5
-- 
2.54.0

