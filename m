Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3261C3600B
	for <u-boot@archiver.kernel.org>; Thu, 27 Mar 2025 15:33:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8459881DB4;
	Thu, 27 Mar 2025 16:33:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id C630F81DCA; Thu, 27 Mar 2025 16:33:28 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 7313481951
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 16:33:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1AA521655;
 Thu, 27 Mar 2025 08:33:31 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.manchester.arm.com [10.32.100.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 93FDE3F694;
 Thu, 27 Mar 2025 08:33:24 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Cc: Marek Vasut <marex@denx.de>, Michal Simek <michal.simek@amd.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: [PATCH 02/18] zlib: annotate switch/case fallthrough cases
Date: Thu, 27 Mar 2025 15:32:57 +0000
Message-Id: <20250327153313.2105227-3-andre.przywara@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250327153313.2105227-1-andre.przywara@arm.com>
References: <20250327153313.2105227-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The inflate state machine in zlib uses switch/case fall-through's
extensively, as it sometimes advances the state, and lets the
conveniently placed next case statement handle the new state already.
The pattern here is:
		state->mode = LEN;
	case LEN:

Annotate those occasions with the "fallthrough;" macro, to let compilers
know this is fine when using -Wimplicit-fallthrough.

This mimics the upstream commit 76f70abbc73f:
Author:  Mark Adler <madler@alumni.caltech.edu>
Date:    Sun Mar 27 00:12:38 2022 -0700
Subject: Add fallthrough comments for gcc.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 lib/zlib/inflate.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/lib/zlib/inflate.c b/lib/zlib/inflate.c
index b4c72cc2c5c..2b7a464f74f 100644
--- a/lib/zlib/inflate.c
+++ b/lib/zlib/inflate.c
@@ -420,6 +420,7 @@ __rcode int ZEXPORT inflate(z_streamp strm, int flush)
             if (state->flags & 0x0200) CRC2(state->check, hold);
             INITBITS();
             state->mode = TIME;
+            fallthrough;
         case TIME:
             NEEDBITS(32);
             if (state->head != Z_NULL)
@@ -427,6 +428,7 @@ __rcode int ZEXPORT inflate(z_streamp strm, int flush)
             if (state->flags & 0x0200) CRC4(state->check, hold);
             INITBITS();
             state->mode = OS;
+            fallthrough;
         case OS:
             NEEDBITS(16);
             if (state->head != Z_NULL) {
@@ -436,6 +438,7 @@ __rcode int ZEXPORT inflate(z_streamp strm, int flush)
             if (state->flags & 0x0200) CRC2(state->check, hold);
             INITBITS();
             state->mode = EXLEN;
+            fallthrough;
         case EXLEN:
             if (state->flags & 0x0400) {
                 NEEDBITS(16);
@@ -448,6 +451,7 @@ __rcode int ZEXPORT inflate(z_streamp strm, int flush)
             else if (state->head != Z_NULL)
                 state->head->extra = Z_NULL;
             state->mode = EXTRA;
+            fallthrough;
         case EXTRA:
             if (state->flags & 0x0400) {
                 copy = state->length;
@@ -471,6 +475,7 @@ __rcode int ZEXPORT inflate(z_streamp strm, int flush)
             }
             state->length = 0;
             state->mode = NAME;
+            fallthrough;
         case NAME:
             if (state->flags & 0x0800) {
                 if (have == 0) goto inf_leave;
@@ -492,6 +497,7 @@ __rcode int ZEXPORT inflate(z_streamp strm, int flush)
                 state->head->name = Z_NULL;
             state->length = 0;
             state->mode = COMMENT;
+            fallthrough;
         case COMMENT:
             if (state->flags & 0x1000) {
                 if (have == 0) goto inf_leave;
@@ -512,6 +518,7 @@ __rcode int ZEXPORT inflate(z_streamp strm, int flush)
             else if (state->head != Z_NULL)
                 state->head->comment = Z_NULL;
             state->mode = HCRC;
+            fallthrough;
         case HCRC:
             if (state->flags & 0x0200) {
                 NEEDBITS(16);
@@ -535,6 +542,7 @@ __rcode int ZEXPORT inflate(z_streamp strm, int flush)
             strm->adler = state->check = REVERSE(hold);
             INITBITS();
             state->mode = DICT;
+            fallthrough;
         case DICT:
             if (state->havedict == 0) {
                 RESTORE();
@@ -542,9 +550,11 @@ __rcode int ZEXPORT inflate(z_streamp strm, int flush)
             }
             strm->adler = state->check = adler32(0L, Z_NULL, 0);
             state->mode = TYPE;
+            fallthrough;
         case TYPE:
 	    schedule();
             if (flush == Z_BLOCK) goto inf_leave;
+            fallthrough;
         case TYPEDO:
             if (state->last) {
                 BYTEBITS();
@@ -590,6 +600,7 @@ __rcode int ZEXPORT inflate(z_streamp strm, int flush)
                     state->length));
             INITBITS();
             state->mode = COPY;
+            fallthrough;
         case COPY:
             copy = state->length;
             if (copy) {
@@ -625,6 +636,7 @@ __rcode int ZEXPORT inflate(z_streamp strm, int flush)
             Tracev((stderr, "inflate:       table sizes ok\n"));
             state->have = 0;
             state->mode = LENLENS;
+            fallthrough;
         case LENLENS:
             while (state->have < state->ncode) {
                 NEEDBITS(3);
@@ -646,6 +658,7 @@ __rcode int ZEXPORT inflate(z_streamp strm, int flush)
             Tracev((stderr, "inflate:       code lengths ok\n"));
             state->have = 0;
             state->mode = CODELENS;
+            fallthrough;
         case CODELENS:
             while (state->have < state->nlen + state->ndist) {
                 for (;;) {
@@ -720,6 +733,7 @@ __rcode int ZEXPORT inflate(z_streamp strm, int flush)
             }
             Tracev((stderr, "inflate:       codes ok\n"));
             state->mode = LEN;
+            fallthrough;
         case LEN:
 	    schedule();
             if (have >= 6 && left >= 258) {
@@ -764,6 +778,7 @@ __rcode int ZEXPORT inflate(z_streamp strm, int flush)
             }
             state->extra = (unsigned)(this.op) & 15;
             state->mode = LENEXT;
+            fallthrough;
         case LENEXT:
             if (state->extra) {
                 NEEDBITS(state->extra);
@@ -772,6 +787,7 @@ __rcode int ZEXPORT inflate(z_streamp strm, int flush)
             }
             Tracevv((stderr, "inflate:         length %u\n", state->length));
             state->mode = DIST;
+            fallthrough;
         case DIST:
             for (;;) {
                 this = state->distcode[BITS(state->distbits)];
@@ -797,6 +813,7 @@ __rcode int ZEXPORT inflate(z_streamp strm, int flush)
             state->offset = (unsigned)this.val;
             state->extra = (unsigned)(this.op) & 15;
             state->mode = DISTEXT;
+            fallthrough;
         case DISTEXT:
             if (state->extra) {
                 NEEDBITS(state->extra);
@@ -817,6 +834,7 @@ __rcode int ZEXPORT inflate(z_streamp strm, int flush)
             }
             Tracevv((stderr, "inflate:         distance %u\n", state->offset));
             state->mode = MATCH;
+            fallthrough;
         case MATCH:
             if (left == 0) goto inf_leave;
             copy = out - left;
@@ -872,6 +890,7 @@ __rcode int ZEXPORT inflate(z_streamp strm, int flush)
             }
 #ifdef GUNZIP
             state->mode = LENGTH;
+            fallthrough;
         case LENGTH:
             if (state->wrap && state->flags) {
                 NEEDBITS(32);
@@ -885,6 +904,7 @@ __rcode int ZEXPORT inflate(z_streamp strm, int flush)
             }
 #endif
             state->mode = DONE;
+            fallthrough;
         case DONE:
             ret = Z_STREAM_END;
             goto inf_leave;
@@ -894,6 +914,7 @@ __rcode int ZEXPORT inflate(z_streamp strm, int flush)
         case MEM:
             return Z_MEM_ERROR;
         case SYNC:
+            fallthrough;
         default:
             return Z_STREAM_ERROR;
         }
-- 
2.25.1

