Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453B4606A331
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 13:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=akn01vCt;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VDgEh2Qq
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1066381304;
	Tue, 10 Nov 2026 13:05:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id B8TVFcaNIJ-D; Tue, 10 Nov 2026 13:05:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0B2AB8128F
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794315954;
	b=bNdSiOPDiI1kTTvtPz1fCF84ULWjWiHyriA5j8sA/gDqQdES7WauSnMs7ivFrPHsu4vH
	 4FuxnlF0IUSF5FapuBt1XD78A7qAg9kt4aUgEG631VapIkUCJakBu/Cy5/SJI4wLs7xg4
	 vD77wWF2fIc1d7q+ihQJkiiVDaDmzySd/nkvrXTygwR4Bxh+QM3WUxmD5v/g29EZD96eX
	 g1VV8oJP5at+/DJ7fjhW+jreN4olH0NG90qtO9EBmuKdz0PlK8lM5sxa15Tpbwm7H6lOB
	 Ng6dxgQlo5bSRMg0RUfIz/KjT8DnZsWbWgULqLXR3XTFg8O7LRbyakTB1ON4tysdoKQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794315954;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=soEsv77lCl+prJ49i0A+7WVwhiQmQfJV31uqKFcd5p4=;
	b=mAmNHr+o4+NrghmMn21j73QuCzu8/Gkd5VvBckeg5AIEtqTNrvQB3VTt7WJ37rpaQRnk
	 1wBXuLKwHSK5CimXTLjnAGA0XEw0vi8vDVwStFmNqorg3H9eB7EQxrTKz5B5Yfw9tX24L
	 R94zjC7yOktaniUBRK1ILsrHaQg2qaQsznZeOmKrZQIniv1sywPuXYDn3WjSjKgl1ZHQV
	 Ta0wSFuoVi8KBJiR5WfDi4gY1DS2yriX6T2JurnoeLKFIc1MTp6WI78PHsUS7T09doD2v
	 23/kpQzwRrhTmDXRayrcEvEv8onsWSJ8a/gShqteJdb20akC3kxRkhuzlP829Jfa0oA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794315954;
	bh=soEsv77lCl+prJ49i0A+7WVwhiQmQfJV31uqKFcd5p4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=akn01vCt8VJZl8rUykpwsngC7AMVLXdJaxhEOi26a99ODt19CBCz+3QM3Tzvg60sR
	 ojJ70yr0dSDL3XSKxY+1BrHUIrndTK3hqBfhuDoskAx1lOSOWsH4lL32t1PyYWIFvM
	 SSxdnunJa9Vc0tenabLlkl8P5qai6NfCAagZqx6vBnzLD6ZGZKzp3Drk21IZAhDr0g
	 Zezt/5PrpVHvkR8d0O4lfM9UodinQUjhXt7ocd8Wj8lUIrwdUzT7APw2artYY3B0ec
	 jR/A8Nf2GlfFkw5yKRodxY6x8PZ49hTZM+JzcvqqR5cViSzZeDqpwnDmCFvuK1P02w
	 YCiljClKeACeQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0B2AB8128F;
	Tue, 10 Nov 2026 13:05:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2A789335
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 06:20:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1C89460790
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 06:20:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uU54pTgOPM9Z for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 06:20:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 228B4607FC
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=devnull+aiyengar1990.gmail.com@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=VDgEh2Qq
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 228B4607FC
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 06:20:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4009743544;
 Tue, 10 Nov 2026 06:20:12 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id CBC291F008A2;
 Tue, 10 Nov 2026 06:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794291612;
 bh=soEsv77lCl+prJ49i0A+7WVwhiQmQfJV31uqKFcd5p4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=VDgEh2QqnhMCUtfe2E2eqY9tgXXCC6FtcvdSbSAkT5DB6tCeWRO8uBUWecghucJpn
 Uu4YHGmGJq2D20KGGPnrf3SgYAFdz2iZz+hYJiAx5NaJDLNr6G9NRQnfFCA3gVX6uL
 ZXg7kOQsgh2MTrmjArbD+KYq1VyMHyVIVc4O7l6xijZQyd5rt2Zm9rjsY3xaQtMnnt
 zUL6At9nDQGr3+CO5ma+/i+SZtRWwNXx2NGhbllazlmvTTHlWyVo4tc7InG8Zyk08h
 ZrNHQScfxbF5stD0LbjjwI+L2OZjhDTNEFQwoAzXUPe4QpaCH5MiKDplU1nd+A7FRG
 6eFHcQUBglP/w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 5E1D6488FB;
 Tue, 10 Nov 2026 06:20:10 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Tue, 10 Nov 2026 06:20:11 +0000
Subject: [PATCH 2/2] sunxi: dram: retry transient DRAM training failures
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261110-h616-dram-retry-v1-2-ccaa6d7a6ef1@gmail.com>
References: <20261110-h616-dram-retry-v1-0-ccaa6d7a6ef1@gmail.com>
In-Reply-To: <20261110-h616-dram-retry-v1-0-ccaa6d7a6ef1@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Arun Iyengar <aiyengar1990@gmail.com>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794291609; l=11853;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=pkTt44cowMEABBdnJtcSf3aeVl/tt+54OyF1o/KQoTM=;
 b=JEvm4hIFy+p7G2OApNGGrLjqavrYpHQKbII991X/qKynD+wX8/5v3baAJQlDJTMahbz8ylkcc
 6VwxVu4OvFBAVxUkDTe+8ts4pQv9nvrPlmQ9osDc6q/t1TUm8ILLEN2
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 10 Nov 2026 13:05:19 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Reply-To: aiyengar1990@gmail.com
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Arun Iyengar <aiyengar1990@gmail.com>

mctl_auto_detect_rank_width() takes the first bus width / rank
combination whose PHY training succeeds and panics if none does. That
assumes that training of the real geometry never fails. On an OrangePi
Zero2 (H616, 1 GiB DDR3, 32-bit, single rank) a watchdog reset of a
system that had been thrashing under OOM for minutes produced:

  DRAM:This DRAM setup is currently not supported.
  resetting ...
  U-Boot SPL ...
  DRAM: 512 MiB

In the first pass none of the four combinations trained; in the pass
after the panic-induced reset the 32-bit one still failed while a 16-bit
one trained, so the board ran with half of its RAM until the next
reboot. Idle resets of any kind never showed this (0 retries in 43
reboots, watchdog resets and cold boots). Hardware watchdog resets taken
while the DRAM was saturated (stress-ng cpu+vm+bigheap, SoC at about
75 C) reproduce it: in 21 such resets two needed a retry and one failed
all of three back-to-back passes (a few ms in total), so the transient
lasts longer than back-to-back attempts.

Make the detection robust against such transient failures:
- keep the most demanding combination that trained in any pass; once
  something trained, two more passes retry only the more demanding
  combinations, so a healthy board only pays for a couple of quickly
  failing attempts,
- while nothing trained, retry with an exponential backoff (20 ms
  doubling up to 320 ms, 12 passes, about 2.5 s) before panicking; after
  a delay was needed, the passes for the more demanding combinations are
  delayed as well,
- the size probe and the final init ignored the result of
  mctl_core_init(); retry them with the same backoff (the outcome of a
  persistent failure is unchanged). The final init is changed for all
  three users of the helpers (H6, H616, A523).

Every mctl_core_init() already resets and re-initializes the controller,
PHY and DRAM PLL and runs the DRAM reset/init sequence. If a retry was
needed the SPL prints " (training retried: pass N, M ms)" in the DRAM
line, so the event and the length of the transient stay visible.

Tested on an OrangePi Zero2 with hot watchdog resets as above (all
results 1 GiB unless noted):
- three back-to-back passes, no backoff: 21 resets, one panic; the SPL
  after the panic reset retried and found 1 GiB, where the unpatched
  SPL had settled for 512 MiB,
- 8-pass backoff (1.26 s): 21 resets, one panic after all 8 passes
  failed (the transient lasted about 3 s),
- 8-pass backoff plus the previous patch: 60 resets, no panic; 21 needed
  a retry, three of them only in pass 7 or 8 (1.3 to 1.7 s), hence the
  12-pass budget of this version.
The 12-pass version has been in use on that board since: 316 logged
boots, all 1 GiB, none needed a retry. H6 and A523 are build-tested
only.

Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 arch/arm/include/asm/arch-sunxi/dram_dw_helpers.h |   2 +
 arch/arm/mach-sunxi/dram_dw_helpers.c             | 167 +++++++++++++++++-----
 arch/arm/mach-sunxi/dram_sun50i_h6.c              |   2 +-
 arch/arm/mach-sunxi/dram_sun50i_h616.c            |   2 +-
 arch/arm/mach-sunxi/dram_sun55i_a523.c            |   2 +-
 5 files changed, 138 insertions(+), 37 deletions(-)

diff --git a/arch/arm/include/asm/arch-sunxi/dram_dw_helpers.h b/arch/arm/include/asm/arch-sunxi/dram_dw_helpers.h
index bc9e0d868c5..da73c353417 100644
--- a/arch/arm/include/asm/arch-sunxi/dram_dw_helpers.h
+++ b/arch/arm/include/asm/arch-sunxi/dram_dw_helpers.h
@@ -13,6 +13,8 @@
 
 bool mctl_core_init(const struct dram_para *para,
 		    const struct dram_config *config);
+bool mctl_core_init_retry(const struct dram_para *para,
+			  const struct dram_config *config);
 void mctl_auto_detect_rank_width(const struct dram_para *para,
 				 struct dram_config *config);
 void mctl_auto_detect_dram_size(const struct dram_para *para,
diff --git a/arch/arm/mach-sunxi/dram_dw_helpers.c b/arch/arm/mach-sunxi/dram_dw_helpers.c
index d27ef1925d7..e07c03caff9 100644
--- a/arch/arm/mach-sunxi/dram_dw_helpers.c
+++ b/arch/arm/mach-sunxi/dram_dw_helpers.c
@@ -7,48 +7,147 @@
  */
 
 #include <init.h>
+#include <log.h>
+#include <time.h>
+#include <linux/delay.h>
+#include <linux/kernel.h>
 #include <asm/arch/dram_dw_helpers.h>
 
+/*
+ * Bus width / rank combinations, most demanding first. Testing in this
+ * order matters, otherwise HW might not be fully utilized. For example,
+ * half bus width and rank = 1 combination would also work on HW with full
+ * bus width and rank = 2, but only 1/4 RAM would be visible.
+ */
+static const struct {
+	u8 bus_full_width;
+	u8 ranks;
+} mctl_geometries[] = {
+	{ 1, 2 },
+	{ 1, 1 },
+	{ 0, 2 },
+	{ 0, 1 },
+};
+
+/*
+ * PHY training can fail transiently for a geometry the board really has,
+ * e.g. after a watchdog reset taken while the DRAM was saturated. Such a
+ * failure can outlast several back-to-back attempts but is gone a few
+ * hundred ms to a few seconds later. Hence:
+ *
+ * - Keep the most demanding combination that trained in any pass instead
+ *   of the first one, so a narrower bus or a single rank is not silently
+ *   chosen over the real geometry. Once something trained, two more
+ *   passes retry only the more demanding combinations. Combinations the
+ *   board does not have fail training quickly, so this is the only cost
+ *   on a healthy board.
+ * - While nothing trained, retry with an exponential backoff (20 ms
+ *   doubling up to 320 ms, MCTL_MAX_PASSES passes, about 2.5 s in total)
+ *   before panicking. After such a delay was needed, the passes for the
+ *   more demanding combinations are delayed as well.
+ * - Each mctl_core_init() resets and re-initializes the controller, PHY
+ *   and DRAM PLL and runs the DRAM reset/init sequence, so every attempt
+ *   starts from scratch.
+ *
+ * If a retry was needed, " (training retried: pass N, M ms)" is printed in
+ * the DRAM line, so the event and the length of the transient are visible.
+ */
+#define MCTL_FAST_PASSES	3
+#define MCTL_MAX_PASSES		12
+#define MCTL_BACKOFF_MS_MIN	20
+#define MCTL_BACKOFF_MS_MAX	320
+
+static void mctl_backoff(unsigned int *ms)
+{
+	mdelay(*ms);
+	*ms = min(*ms * 2, (unsigned int)MCTL_BACKOFF_MS_MAX);
+}
+
+static void mctl_report_retry(unsigned int pass, ulong start)
+{
+	printf(" (training retried: pass %u, %lu ms)", pass, get_timer(start));
+}
+
+bool mctl_core_init_retry(const struct dram_para *para,
+			  const struct dram_config *config)
+{
+	unsigned int ms = MCTL_BACKOFF_MS_MIN;
+	ulong start = get_timer(0);
+	int i;
+
+	for (i = 0; i < MCTL_MAX_PASSES; i++) {
+		if (i)
+			mctl_backoff(&ms);
+		if (mctl_core_init(para, config)) {
+			if (i)
+				mctl_report_retry(i + 1, start);
+			return true;
+		}
+	}
+
+	debug("DRAM training failed %d times\n", MCTL_MAX_PASSES);
+
+	return false;
+}
+
 void mctl_auto_detect_rank_width(const struct dram_para *para,
 				 struct dram_config *config)
 {
+	const unsigned int none = ARRAY_SIZE(mctl_geometries);
+	unsigned int best = none, first = none, best_pass = 0;
+	unsigned int ms = MCTL_BACKOFF_MS_MIN;
+	unsigned int pass, i, extra = 0;
+	ulong start = get_timer(0);
+	bool delayed = false;
+
 	/* this is minimum size that it's supported */
 	config->cols = 8;
 	config->rows = 13;
 
-	/*
-	 * Strategy here is to test most demanding combination first and least
-	 * demanding last, otherwise HW might not be fully utilized. For
-	 * example, half bus width and rank = 1 combination would also work
-	 * on HW with full bus width and rank = 2, but only 1/4 RAM would be
-	 * visible.
-	 */
+	for (pass = 0; best > 0; pass++) {
+		if (best == none) {
+			/* nothing trained yet: back off and try again */
+			if (pass == MCTL_MAX_PASSES)
+				break;
+			if (pass) {
+				mctl_backoff(&ms);
+				delayed = true;
+			}
+		} else {
+			/* retry the more demanding combinations a few times */
+			if (!extra)
+				break;
+			extra--;
+			if (delayed)
+				mctl_backoff(&ms);
+		}
+
+		for (i = 0; i < best; i++) {
+			config->bus_full_width = mctl_geometries[i].bus_full_width;
+			config->ranks = mctl_geometries[i].ranks;
+			debug("testing %d-bit width, rank = %d\n",
+			      config->bus_full_width ? 32 : 16, config->ranks);
+			if (mctl_core_init(para, config)) {
+				if (pass == 0)
+					first = i;
+				if (best == none)
+					extra = MCTL_FAST_PASSES - 1;
+				best = i;
+				best_pass = pass;
+				break;
+			}
+		}
+	}
+
+	if (best == none)
+		panic("This DRAM setup is currently not supported.\n");
+
+	/* tell the user that the DRAM did not train on the first attempt */
+	if (best != first)
+		mctl_report_retry(best_pass + 1, start);
 
-	debug("testing 32-bit width, rank = 2\n");
-	config->bus_full_width = 1;
-	config->ranks = 2;
-	if (mctl_core_init(para, config))
-		return;
-
-	debug("testing 32-bit width, rank = 1\n");
-	config->bus_full_width = 1;
-	config->ranks = 1;
-	if (mctl_core_init(para, config))
-		return;
-
-	debug("testing 16-bit width, rank = 2\n");
-	config->bus_full_width = 0;
-	config->ranks = 2;
-	if (mctl_core_init(para, config))
-		return;
-
-	debug("testing 16-bit width, rank = 1\n");
-	config->bus_full_width = 0;
-	config->ranks = 1;
-	if (mctl_core_init(para, config))
-		return;
-
-	panic("This DRAM setup is currently not supported.\n");
+	config->bus_full_width = mctl_geometries[best].bus_full_width;
+	config->ranks = mctl_geometries[best].ranks;
 }
 
 static void mctl_write_pattern(void)
@@ -93,7 +192,7 @@ void mctl_auto_detect_dram_size(const struct dram_para *para,
 	/* max. config for columns, but not rows */
 	config->cols = 11;
 	config->rows = 13;
-	mctl_core_init(para, config);
+	mctl_core_init_retry(para, config);
 
 	/*
 	 * Store content so it can be restored later. This is important
@@ -119,7 +218,7 @@ void mctl_auto_detect_dram_size(const struct dram_para *para,
 	/* reconfigure to make sure that all active rows are accessible */
 	config->cols = 8;
 	config->rows = 17;
-	mctl_core_init(para, config);
+	mctl_core_init_retry(para, config);
 
 	/* store data again as it might be moved */
 	memcpy(buffer, (u32 *)CFG_SYS_SDRAM_BASE, sizeof(buffer));
diff --git a/arch/arm/mach-sunxi/dram_sun50i_h6.c b/arch/arm/mach-sunxi/dram_sun50i_h6.c
index ea26e6dd327..1efd59d17b4 100644
--- a/arch/arm/mach-sunxi/dram_sun50i_h6.c
+++ b/arch/arm/mach-sunxi/dram_sun50i_h6.c
@@ -610,7 +610,7 @@ unsigned long sunxi_dram_init(void)
 	mctl_auto_detect_rank_width(&para, &config);
 	mctl_auto_detect_dram_size(&para, &config);
 
-	mctl_core_init(&para, &config);
+	mctl_core_init_retry(&para, &config);
 
 	size = mctl_calc_size(&config);
 
diff --git a/arch/arm/mach-sunxi/dram_sun50i_h616.c b/arch/arm/mach-sunxi/dram_sun50i_h616.c
index 42a0550e015..a019dcf6e94 100644
--- a/arch/arm/mach-sunxi/dram_sun50i_h616.c
+++ b/arch/arm/mach-sunxi/dram_sun50i_h616.c
@@ -1352,7 +1352,7 @@ unsigned long sunxi_dram_init(void)
 	mctl_auto_detect_rank_width(&para, &config);
 	mctl_auto_detect_dram_size(&para, &config);
 
-	mctl_core_init(&para, &config);
+	mctl_core_init_retry(&para, &config);
 
 	size = mctl_calc_size(&config);
 
diff --git a/arch/arm/mach-sunxi/dram_sun55i_a523.c b/arch/arm/mach-sunxi/dram_sun55i_a523.c
index 1ffb62863e2..606ec9e1918 100644
--- a/arch/arm/mach-sunxi/dram_sun55i_a523.c
+++ b/arch/arm/mach-sunxi/dram_sun55i_a523.c
@@ -1503,7 +1503,7 @@ unsigned long sunxi_dram_init(void)
 	config.tpr12 = CONFIG_DRAM_SUNXI_TPR12;
 	config.tpr14 = CONFIG_DRAM_SUNXI_TPR14;
 
-	mctl_core_init(&para, &config);
+	mctl_core_init_retry(&para, &config);
 
 	size = mctl_calc_size(&config);
 

-- 
2.55.0


