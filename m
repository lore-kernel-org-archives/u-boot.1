Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20854C88E4C
	for <u-boot@archiver.kernel.org>; Fri, 11 Sep 2026 10:46:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C61E08129E;
	Fri, 11 Sep 2026 10:46:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y9rBiS4FqOHw; Fri, 11 Sep 2026 10:46:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 67D8E81291
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789123605;
	b=QxoUdHKxA1uFd6/EOPyy62+Fk3wJ3u+8N/OjZbMniLQBfAed2uJ+1H1cBJKXLCF61m/P
	 136YCJdOYDIZ0MYbeXAJSEfaDI0oeHto7kmjkle2Nj3pVUIGsjUFIwCn+5kpk0WcJZqLO
	 nT/ntdYrYpEMrDDgcSh9tpBs13dm753XXLxTVHrzgYzI4frQ2yv78dPOR7CVYKns1BZZR
	 esS8x/875TNOFbvb0E9+teaxvNtmGAZ1bZZutZZ+/SdVgjsh3pZzddSYE56tFmR/vxWmT
	 OxAvyCclIau6gU3wNNiXRUWa1G9FR7UEZEYp1kLt01rQMzzUfBXZG7L2OS1ZteTk/6Q==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789123605;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-ZohoMailClient:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=PBmc7fNhAJy3Oa/9v1ZniKjimeQ9jJJHfIah7UtQN7Q=;
	b=Ra6p/GaM13/4Ck7Fq/f0WLKRcgVtaPEcgluWQqKyucio3dP7EBevjfdgl+krHbkKft/j
	 NskF6lEsBhJDB/IAscFPk6OjqQFQpxIHkgxf74CgI2nW9T4S3e7GJut0OxxexIvGrMQdg
	 EyToWKkvMCZvZrRLLntGXQvOWg2ObyxW0fBCUsWqfIvolpPSm5IAVMVIP60B7mD6+F8+U
	 w2mbC11xyIjwc0k6icbHNOkwTWcABDjPSztFOGzhP39MjOlDkyjoQgCX7aEb8pCxppffI
	 7473Dj2d7F2bRsGOsN93br2Ujl06+Zwba0EfI+g7WP0oDG9E+0/a0MzVhdwqh1F0W4w==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789123605;
	bh=PBmc7fNhAJy3Oa/9v1ZniKjimeQ9jJJHfIah7UtQN7Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ySMzqYSm87O7coAPfIfRmpsenEUvzGQWj8ytkCBKyWgkkXE++rj4wYiyHDteEpeny
	 dhc0k1Ujk2+D2059J48DUioo/zki1tOEAWvYLHEGHoGzH7REwB7DEHyjMOZ689/ERt
	 3bQuurP79K+0lx8wsUVyIoY+UKH50c8t9X3QP61RvjAJbZc57ZLM4ZtZK5zgaGIj3m
	 4JZ91KvyaFd1UVe3qOMmSk6NPG2EOR3ct+JBbpKgR9ZRMPxl+40Sowt1Nare2jrcpy
	 VrpHE8IL/OSi/w1SdPXgyhmonJgHj0Bq6i8qOnWvaO8oFwaMfnO03Igs5pALWavOk3
	 B0Avi5IEhPvAA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 67D8E81291;
	Fri, 11 Sep 2026 10:46:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id B09FB769
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 10:46:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9671760C13
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 10:46:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Vzdlh0A8qF13 for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 10:46:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org BFA0360BF1
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789123601;
 b=Rty0sgJqHi/cc0UcS4f9qahIl5Ymdtc9CzyiFRJljy3UU18Gng0LPKqWfcQZbRbZgNhE
 Rw3b+3HcRo382YE1+Z+9rMI0/7//0uFcwIiexd+N/2l8BsDbfEQafygqHbq7lpYQ0p2t9
 v0LmV91dx2w+VLC2HooZfnvDP12k52qCGZIQKMFUfmhzcz8+soCdsaKlDmp3I6b4IbdpF
 YEBi1z80SzWM7S9ndKwzRTaz96MGDbzbbUBzo2RXLNcCD8MfJ9k6gRM3n2CbEKp8kRMW9
 MjVkEvcCuJTds+bg5YF/7RD1PQgWByJnSMvNdtAhHTvHR0zehP9OGV9MsNmxzMBvrng==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789123601;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-ZohoMailClient;
 bh=PBmc7fNhAJy3Oa/9v1ZniKjimeQ9jJJHfIah7UtQN7Q=;
 b=RNRUBOLmFkpZhNN91vNpDKlJPCWldyYAgN1nWs85bgF+6KKsbdbWOHabsV05sm4k67FG
 YtbPwTvNhS5uUzfiY+Wse/aAegM/5Rr+oA7iWcBYr1oTX7ivSRrDtqOWFJxfTI2lDM81r
 rx7U05GfcJqUvsJLGe+b+1WzdU7AaH/4IdR4wNUSmLXSLyuHzJrMfvRR0J9iHBkk5N3XQ
 G4PcPThgs2oH9iEMG2ZUJmPXoxAUpNnP68X/+KqkMRu4nIQ/6DBqLkaWRm0505+6/Pp0d
 eoRsybT1Pm14i67Hx1vnaK5D77X/hFyagp36EI74JezFgIippwNFXhT6KRfYDTOD6DQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=ziyao.cc; 
 dkim=pass header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b="fn25kc/x"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.15;
 helo=sender6-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=fn25kc/x
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com
 [165.173.180.15])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BFA0360BF1
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 10:46:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1789123593; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=GqkzwsPRZdO3q2LPFP7AXLScvfuPambcQlGm9cQhgND0K3vDawhhBg6I81yyWo/OLZcW6441RvTzyXCYo5Vx5O47ao9mxPdF3X2gGMAV8kSXDPIYuE03lgAuRrettwANkYnXDYIClA4OcrY3+wQe2kJyAiFebTso7DD9iwVTZf0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1789123593;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=PBmc7fNhAJy3Oa/9v1ZniKjimeQ9jJJHfIah7UtQN7Q=; 
 b=RwjBHjFpljyt/u2pwPY3rzzsVzDexuUuONJYZ4AQmsp+uvUxGQ5x608oaWZEBMfkzJTz8p1y3T0kZDIWHG1yFhPkpjI9Pe05C/uI59IF09MOaYTGtpoJMhVcDjY3uN7YORf1pjgjfefocQ1XIDOoh6p7WgmwZWfa3varaXhUAfE=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1789123593; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=PBmc7fNhAJy3Oa/9v1ZniKjimeQ9jJJHfIah7UtQN7Q=;
 b=fn25kc/xegZCsLLvlOJKymqJ8MFYFS1HmILatPROFvswHdIBaFaa2zG4ikIz+VDA
 n2V0fIiewjRzWSX6zYhF5I8nTzzT8O0eyBlgF1Wp6CgguC2+kDq4SJG91rtu1DksByi
 LLgoxM6PVYQNSIey+lkBAnn2Fw5pPraiQ/+Vd8vU=
Received: by mx.zohomail.com with SMTPS id 1789123593065120.52650534172642;
 Fri, 11 Sep 2026 03:46:33 -0700 (PDT)
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 04/19] elf: Define LoongArch bits
Date: Fri, 11 Sep 2026 10:45:49 +0000
Message-ID: <20260911104604.2910944-5-me@ziyao.cc>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911104604.2910944-1-me@ziyao.cc>
References: <20260911104604.2910944-1-me@ziyao.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
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

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

They all come from glibc's elf.h

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Yao Zi <me@ziyao.cc>
Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Reviewed-by: Simon Glass <sjg@chromium.org>
---

No changes since v3

Changed from v2
- Collect tags
- Drop a redundant blank line between /* Version */ comment and
  EM_LOONGARCH definition

Changed from v1
- Re-title to "elf: Define LoongArch bits" (with the semicolon)
- No function changes involved

 include/elf.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/elf.h b/include/elf.h
index b88e6cf4032b..67d519cd9174 100644
--- a/include/elf.h
+++ b/include/elf.h
@@ -225,7 +225,7 @@ typedef struct {
 #define EM_MN10300	89		/* Matsushita MN10200 */
 #define EM_MN10200	90		/* Matsushita MN10200 */
 #define EM_PJ		91		/* picoJava */
-#define EM_NUM		92		/* number of machine types */
+#define EM_LOONGARCH	258	/* LoongArch */
 
 /* Version */
 #define EV_NONE		0		/* Invalid */
@@ -705,6 +705,12 @@ unsigned long elf_hash(const unsigned char *name);
 #define R_RISCV_64		2
 #define R_RISCV_RELATIVE	3
 
+/* LoongArch Relocations */
+#define R_LARCH_NONE				0
+#define R_LARCH_32				1
+#define R_LARCH_64				2
+#define R_LARCH_RELATIVE			3
+
 #ifndef __ASSEMBLY__
 unsigned long bootelf_exec(ulong (*entry)(int, char * const[]),
 			   int argc, char *const argv[]);
-- 
2.55.0

