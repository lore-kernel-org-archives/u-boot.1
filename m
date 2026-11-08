Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73352606A31C
	for <u-boot@archiver.kernel.org>; Sun,  8 Nov 2026 16:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=YBigyOaQ;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=LzPc9h8D
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2B5D180D30;
	Sun,  8 Nov 2026 16:02:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5qnxtzW73lCb; Sun,  8 Nov 2026 16:02:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7E1D380D39
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794153769;
	b=Pk01cMd00bUNqBdoFgY3zJEodrO7U3DSwR9oXo7GokEdu/AJmvWTqJZBLJ0jyJlKKWmW
	 wcemhY5nVGl5GEySdBGWdvnpsFHZEv5BsGWo7eLrm6yQlflPL0UMotkI40z1LwYdfiZb2
	 yp+eTYJuHP88I4R23VW6qdSsaAt7fjG0AjygdSCs4l9hlj2iNK1tkxJnHZx/GJmXq0Chh
	 OFyM/pYY9BEAYI6xpM3D1lzWZv8K1tpYnTEjejPHQ0NNk+HuKtQ2lTlln345LEpK5f9De
	 lu9zTNu48nJgrAmmmMzf028ol9h8OJW0I/aJAXdBD504WSKLiIpoLgxv9l+3rZQgK4Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794153769;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=03oa3dSbqCoOuvk/MDKtGhXwYp882kl8y9scLNC5omk=;
	b=NUCYonEKdjLHGw3F3/6BWNJkZDvEGJ9XIV4nXM/tIF9jFr1+b0yucGLZ3sWO+iL8KJ2e
	 bMim9VC+Tg2rS4hxfRz0/4i2T43pz1cKzDlss2C2ccSmmvkDdtMoHmpGQVXI3Ogv7cmSA
	 lrR55XEGvz1+3O1TigUnwmGTGyLIvs8bpfD0+swHSw5VNwbpxh0eY1YvIHt8FRK57GMdJ
	 olm6waASUKdSt9FSLcyAJz8cols3y0GxjrZ+ljWPnHSsOYaE8L86Q7WHkJNnivVBeVBRR
	 LFTPlNBQFUklEZ0wIjeYfHY9D3jdI/DcO2q12XmJwHIfWzpePnALUljMq5oLeVElhxA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794153769;
	bh=03oa3dSbqCoOuvk/MDKtGhXwYp882kl8y9scLNC5omk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YBigyOaQKNVgFqoI8Hvi3oZgCpavxYOPLYV9fkyJuoJkdO2bDFkWZQd8H4/V/p7Dj
	 ymev1PkIh6uHsFdtkncV0W18makt8UruXH23iOBJ9dgRBAhqBfqPBgVMTTqYn4a/B2
	 z9+my1+zdJW/gnYCU0zFMpNKP4FfMzYQjw85t0X5Yxvsiwqh/WxcEioUf1d696nS+A
	 hTrY8tu6kJe1dIhrRmu1Lq3brn+Cfwi5l0Q8z9vp2KeiAV9Tt8SZS9BseItw0CxewM
	 MXK4RB21cSk3gBk0Nd5CmA2z4oB5k1sHKe+zXEKz1uEGT/DlKYZmYT1znvoZ4GdA3B
	 ATfz0jMTHbscA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7E1D380D39;
	Sun,  8 Nov 2026 16:02:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2AFB5932
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 16:02:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1C9C7400A8
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 16:02:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Hn0orztKlhXu for <u-boot@lists.u-boot-project.org>;
 Sun,  8 Nov 2026 16:02:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org D66424005E
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a01:e0c:1:1599::10"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:e0c:1:1599::10;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=LzPc9h8D
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [IPv6:2a01:e0c:1:1599::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D66424005E
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 16:02:46 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 19240B0056A;
 Sun,  8 Nov 2026 17:02:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1794153764;
 bh=q5dM49ffMHf3Qri1D2cA71H6x8pCvO6KdzAjYC+T7Pw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=LzPc9h8DN8EYCLGDLgAOomPDj0T/SYwVTy9txnrOXfyw5tynv6xc+zKFxpIvoagr0
 fxQvuXZbF3HDAYd+tU7NJ1cRcsvJmPSjLqIsJKZiDzub6CXGnwsMlAHYHenf2aqxIQ
 yg+xw9LZdlWruMQG2gx5SlXXO5u9VluTWVph67JT1PAVYMlArUiV1P51Bh1+9dLX2W
 kKyyKckLuyPDH2lFm5yPcOem1NcYWXjW9deu2bMBrqj8ioZ7Ht17QXQWp4e6pL9w5X
 RV6HTYy5tAjE8w1SgT0XEEy/qMjr7tlmNoutiki8q9JzqMq1kydAr7QNMMnPfmPsBq
 WUUrxgvn2lCag==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Suraj Kakade <suraj.hanumantkakade@amd.com>,
 Markus Schneider-Pargmann <msp@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Denis Mukhin <dmukhin@ford.com>, Simon Glass <sjg@chromium.org>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>, Tom Rini <trini@konsulko.com>,
 Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v1 1/3] scripts: Makefile.dts: build the device tree with
 DEVICE_TREE= too
Date: Sun,  8 Nov 2026 16:50:17 +0100
Message-ID: <20261108155019.1485598-2-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261108155019.1485598-1-vjardin@free.fr>
References: <20261108155019.1485598-1-vjardin@free.fr>
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

The directories built based on scripts/Makefile.dts,
dts/upstream/src/<arch> and its vendor directories, list the device trees
of Kconfig only:
CONFIG_DEFAULT_DEVICE_TREE, CONFIG_OF_LIST and CONFIG_SPL_OF_LIST.

If "make DEVICE_TREE=<name>" selects another one in dts/Makefile, nothing
builds it, it stops with:

  Device Tree Source (dts/upstream/src/arm64/freescale/<name>.dtb) is not
  correctly specified.

The arch/<arch>/dts directories are not affected: their dtb-y lists are
explicit and DEVICE_TREE picks one of them.

Signed-off-by: Vincent Jardin <vjardin@free.fr>
---

 scripts/Makefile.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/Makefile.dts b/scripts/Makefile.dts
index 3871a4ad412..fd9ff420585 100644
--- a/scripts/Makefile.dts
+++ b/scripts/Makefile.dts
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0+
 
-dtb-y += $(patsubst %,%.dtb,$(subst ",,$(CONFIG_DEFAULT_DEVICE_TREE) $(CONFIG_OF_LIST) $(CONFIG_SPL_OF_LIST)))
+dtb-y += $(patsubst %,%.dtb,$(sort $(DEVICE_TREE) \
+	$(subst ",,$(CONFIG_DEFAULT_DEVICE_TREE) $(CONFIG_OF_LIST) $(CONFIG_SPL_OF_LIST))))
 dtb-y += $(patsubst %,%.dtbo,$(subst ",,$(CONFIG_OF_OVERLAY_LIST)))
 
 ifeq ($(CONFIG_OF_UPSTREAM_BUILD_VENDOR),y)
-- 
2.43.0

