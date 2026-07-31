Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB56FC54F54
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 11:23:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9FB5280F4D;
	Fri, 31 Jul 2026 11:23:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2qXrC9e7vTCM; Fri, 31 Jul 2026 11:23:20 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A848281080
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785497000;
	bh=UJTDomwXHALPEpHATqh4KeDlGgG/Kv9m0zBM+4RKMUI=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=quCgFcu2emp20P0oXjHYACasF2ThvILs/9OI0eleAKc9gePnZT7lfA7rcPWhRJ2xT
	 qlIvEFkU71+MOPdao0dmHuQ9hTsWcRWyn9KuTGdY3AWweUYvAx5Iiwjd76N8D6Prco
	 ZNtJUYK/rKwHOFLH/V3mVyBKS6stMfpfz2Qd+XUePrnLKTz2kzpT9vrJz88OxwcT9o
	 ef9N9VpHcjV7xU/KLSAJPHfkg6JvPbtkU8vZAfsqTMG4q/+UZvwoTvnvMoYSusJV6i
	 gun4RaQIXg/gXI3rP8shq79Y/H4nQZ5qAa7wL3FsYAjCXYlKfKRmE/5NIwPvRbv7uJ
	 4hm22Bp3q0CoQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A848281080;
	Fri, 31 Jul 2026 11:23:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id B9A512CE
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 11:23:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9F2FB81080
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 11:23:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cxwniu4nvjU6 for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 11:23:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=136.143.188.15;
 helo=sender4-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org C4B0780F4D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C4B0780F4D
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C4B0780F4D
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 11:23:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1785496992; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=TrplYjzSMIzjnG/h4+GzL6IsQZBVqgH+4IPIj7u2RT0vcv5UFN9DduZe2xqlqot6vHt2Ize5gt5sJtKJVMGovNBTO//DxBge/+R6kkqbXoBO08YSIY63nKBy0UVjO26WQMlYUDvd7YaG1tkaP3jF2bAYglPdnKPXT7wMP8bo9C8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1785496992;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=UJTDomwXHALPEpHATqh4KeDlGgG/Kv9m0zBM+4RKMUI=; 
 b=OnGMSCnqiIhjL3KuBBeOpEHpxOGEOyHU7x3Wu4lMrQpSDAhRsxgyuFHd8g8e/Ezn9Pcw33+6XXbdsxTjxAoCScB9MSNF6XOVwfzTRcvH/PMrSEDnnyeJelObRICHTQa+Erphd7wlUOh0CzhdnqJ9FqyuiBNJf0ihiJuZXVhjhHA=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
Received: by mx.zohomail.com with SMTPS id 1785496985649478.2735902381801;
 Fri, 31 Jul 2026 04:23:05 -0700 (PDT)
From: Yao Zi <me@ziyao.cc>
To: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org,
	Yao Zi <me@ziyao.cc>
Subject: [PATCH] buildman: Differentiate 32-bit and 64-bit LoongArch variants
Date: Fri, 31 Jul 2026 11:22:29 +0000
Message-ID: <20260731112229.2211474-1-me@ziyao.cc>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; t=1785496987; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=UJTDomwXHALPEpHATqh4KeDlGgG/Kv9m0zBM+4RKMUI=;
 b=Q4ZSkGpNhnEAFDriBOWQkDeR3ZuhrqZpKLC82iiVrEROMrZi0dfWUU+z6fZ7whzU
 L0TuFCHtWhBRUzFJVeJ1wipBWMuU+j4ET0FCzObaOSDzBau/zqzhM1A4QUDzFRw+Q4N
 7+kOrUk730O+iuDCKjDgkisi/DeV5B3A7ilDl5RU=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=Q4ZSkGpN
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

Similar to RISC-V and ARM, 32-bit and 64-bit LoongArch couldn't be
distinguished solely by CONFIG_SYS_ARCH, but require different
toolchains if multilib is disabled in compiler, which is the case of
toolchain provided by kernel.org.

Let's override the parsed arch parameter for LoongArch configs based
on CONFIG_ARCH_LA64 Kconfig symbol.

Signed-off-by: Yao Zi <me@ziyao.cc>
---
 tools/buildman/boards.py | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/buildman/boards.py b/tools/buildman/boards.py
index 2fe43c3fc896..a878053df59d 100644
--- a/tools/buildman/boards.py
+++ b/tools/buildman/boards.py
@@ -309,6 +309,17 @@ class KconfigScanner:
             else:
                 params['arch'] = 'riscv64'
 
+        # fix-up for loongarch
+        if params['arch'] == 'loongarch':
+            try:
+                value = self._conf.syms.get('ARCH_LA64').str_value
+            except:
+                value = ''
+            if value == 'y':
+                params['arch'] = 'loongarch64'
+            else:
+                params['arch'] = 'loongarch32'
+
         return params, warnings
 
 
-- 
2.54.0

