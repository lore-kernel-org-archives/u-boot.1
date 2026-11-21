Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CA3606A331
	for <u-boot@archiver.kernel.org>; Sat, 21 Nov 2026 12:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Gauz6lQJ;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=X+UEjDgN
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6AB7340667;
	Sat, 21 Nov 2026 12:05:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TUQmnlXVLpK3; Sat, 21 Nov 2026 12:05:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A440F40639
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795262740;
	b=Byn5+jJ/2IA/n6PRxzAEcI05GpBf4H/WdsZLcWcIKkngbxAAlXRe9DsIpWk6BuWpLnt6
	 +SqA/aHq+2pu+q/mOBgpvciJ0+PXezu+uIN3eBhEfD5HOx52O6bFwq953/RRqIO8UQeHo
	 VpB8nS3Ig3pv4ej0TXlPegSV8AqAJ2b9Ad5qk9RVPkSzgOhaAaD+fq1kVQ8LYwcdelWEp
	 2x8pmmV+IvSlLl8pxfKW4dHgFILMeUH1QY9Q3pw2+zWsFHLPFMAuIA/UB1L0Wtt9prCLD
	 65GfCKAur7/UUk6PCQ93eZ9BBzEGsKFobGm6pWzR3UV6/404A93O5EAvjDB+Su5a6Uw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795262740;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=uY6fn6JqpL+72OUajloPKvK2VGzt1m5fx9icSfVAktc=;
	b=dcwtrKENAVVumorGamaD50UF9FFXWKJCWO5GPe1jsNzagxa7GlAyEmohuFwZxPNJ9zeS
	 CUvzvzXgHuggM+YGHUlxYqyh3ZiUOtbL+vXM9Yv8GxlVD1GZ+iBAHU8RezjazLLH7WADR
	 TRXx/Plr4O1YunIRv3cN0QG9IWAs08OEidyT7FWpfpNWMQFroVJENTUj9BAwPH3xzTW+0
	 /D7yBXwLwJi+s9J7NGX5S1peaLSRgdGPOSbUO/roYNsR0Cq7ghVb/24Cwfk1gOsT0s+26
	 OzwM86FdK+j98XuxbJf2Rdm1cEW6LAdbq2UyvFBz1VNeEAJQzi0co/AkIJ3rZsz/Dog==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=free.fr;
	dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=X+UEjDgN;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795262740;
	bh=uY6fn6JqpL+72OUajloPKvK2VGzt1m5fx9icSfVAktc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Gauz6lQJ3yWSdRzRURclIigQLq0vDNsNLYTK/3duj3cBkQy6fxy/I2BJuh0reSzRB
	 qpDXcMAndd42zvFq8EwXQgJtbQUlSKcxxZog7oPxl8yNN5HYqg/tu2/7nNl0f6TI5G
	 ZC3PvqPpoh0sMS5CZ8YMbnArlK7TeKKBHbYP8y37SXBfhRhZaK7mWPfJ8EDM3eZf55
	 QZk/p0qIJhvUFNjab5xX20AG2tI9x11yMyXyPULfhajWHj4lBPenVGuVtPoxjUq+Y2
	 JUVeZmhOfEAMOtf963GZBkX/imaJF3A8uxw746GZ0UMi0TiCal5QPZpunVOttihW5S
	 SoFqaMDGRzU9w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A440F40639;
	Sat, 21 Nov 2026 12:05:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id CDF0F759
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 12:05:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BFA3140639
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 12:05:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VukOHmcXsYcS for <u-boot@lists.u-boot-project.org>;
 Sat, 21 Nov 2026 12:05:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A4886405B6
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=212.27.42.1
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.27.42.1;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=X+UEjDgN
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A4886405B6
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 12:05:37 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 1A617B0054C;
 Sat, 21 Nov 2026 13:05:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1795262736;
 bh=LRpngjgOQGelkVWrq5cgz2xjZ4tt5UOtl2f0T2NOIh4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=X+UEjDgNpjje8SK/lIEA5mjg59bdComh6DKAqFBCr8QJQ0qG/0CdkOJMVE0KYuESg
 HbwlY4so8ZhpgrnEnSxuquwTxgGqWk+dLVVa2VI5XI/PB7yR3bFT5Q8+8V8pQtcPak
 PJolkCbwITEGxGG9MwIdGknzWf5wa0BS6ZnBQdUqHNfEPteoY5PId/uNqnBEXeI6aV
 LYLNgdwN7WF3K50hEldwZqex4xbDQNzvBDDHihWKdxqCdvCr95yxM7ndo9BnrNcT/h
 wmdTLRW2j63MiuEAB5gMf/DdruvSZfJ4vrHtVyG0mjJMAW6Uop5A9xmmdth5+ca4Qy
 cFgSP/XRrdlIQ==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Suraj Kakade <suraj.hanumantkakade@amd.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Denis Mukhin <dmukhin@ford.com>, Tom Rini <trini@konsulko.com>,
 E Shattow <e@freeshell.de>, Rasmus Villemoes <rv@rasmusvillemoes.dk>,
 Simon Glass <sjg@chromium.org>,
 Markus Schneider-Pargmann <msp@baylibre.com>,
 Vincent Jardin <vjardin@free.fr>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Sumit Garg <sumit.garg@kernel.org>
Subject: [PATCH v3 1/4] dts/upstream: mips: no repeat of the dtbs rule of
 scripts/Makefile.dts
Date: Sat, 21 Nov 2026 13:04:41 +0100
Message-ID: <20261121120445.3795725-2-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261121120445.3795725-1-vjardin@free.fr>
References: <20261121120445.3795725-1-vjardin@free.fr>
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

dts/upstream/src/mips/Makefile includes scripts/Makefile.dts, which
already adds $(dtb-y) to targets and defines the dtbs rule, and then
defines both a second time.

The boston build warns:

  dts/upstream/src/mips/Makefile:12: warning: overriding recipe for target 'dtbs'
  scripts/Makefile.dts:27: warning: ignoring old recipe for target 'dtbs'

Fixes: d3730b53d9ae ("dts/upstream: Add Makefile for MIPS")
Signed-off-by: Vincent Jardin <vjardin@free.fr>

---

Changes in v3:
- New patch. The boston builds already warned about the dtbs rule that
  the MIPS Makefile repeats; "scripts: Makefile.dts: build the device
  tree with DEVICE_TREE= too" (Tom Rini)

 dts/upstream/src/mips/Makefile | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/dts/upstream/src/mips/Makefile b/dts/upstream/src/mips/Makefile
index 9a8f6aa3584..0b44161d5db 100644
--- a/dts/upstream/src/mips/Makefile
+++ b/dts/upstream/src/mips/Makefile
@@ -2,13 +2,7 @@
 
 include $(srctree)/scripts/Makefile.dts
 
-targets += $(dtb-y)
-
 # Add any required device tree compiler flags here
 DTC_FLAGS += -a 0x8
 
-PHONY += dtbs
-dtbs: $(addprefix $(obj)/, $(dtb-y))
-	@:
-
 clean-files := */*.dtb */*.dtbo
-- 
2.43.0

