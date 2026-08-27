Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3188CC61DB9
	for <u-boot@archiver.kernel.org>; Thu, 27 Aug 2026 19:54:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F3DF180F26;
	Thu, 27 Aug 2026 19:54:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qEic_2k6RXhb; Thu, 27 Aug 2026 19:54:19 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787860459;
	bh=v7FUSiDho3ocvJF0QmplEdpYgXNW81SAtLzQSv9Fltc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wPy/h0AY97q1ZLdWbUDVyYEtz6MIqhVz71rbhePFEYuNZKtW11riZvdGTnq3JvxTm
	 3U1vAlv/L1xxU7hBMG/daGvdHmdeLCRGsTFuZrAHjuk1qDzHgtkOBzfWp1coLUalZD
	 zBJpcR2bKF/CvBVXtELc/sMpulhjL79+Xoz/MqJH2CnOl/h6rwQoU/azi/Cg+QT4kv
	 tbDGaR56gCITvTuV4oM2LU6Gf+shWJ4SVZpOy5GOhin0Kz2U0QtvjkELSrldQrdxzw
	 jZvQ8YFZAWrsBsjS9r4Ga4cHliOOIPTcwaWhgVha+VeQakCYawaTl0tkcPlKpG5nRD
	 FhukKomfpW/3A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5A8C880EFC;
	Thu, 27 Aug 2026 19:54:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id A0D32334
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 19:54:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 87649400D7
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 19:54:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ghech3pkJwvL for <u-boot@lists.u-boot-project.org>;
 Thu, 27 Aug 2026 19:54:07 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=84.16.66.169;
 helo=smtp-42a9.mail.infomaniak.ch; envelope-from=foss+uboot@0leil.net;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=f0zBRMJb
Received: from smtp-42a9.mail.infomaniak.ch (smtp-42a9.mail.infomaniak.ch
 [84.16.66.169])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7BBBE400D5
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 19:54:06 +0000 (UTC)
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch
 [10.4.36.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hWBzd1j4rzYq;
 Thu, 27 Aug 2026 21:54:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1787860444;
 bh=v7FUSiDho3ocvJF0QmplEdpYgXNW81SAtLzQSv9Fltc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=f0zBRMJb72d92/sTrzBysz1sXaV1c7cKaYL0gVHR3twLjMJ8xPnEbVpD9SsPwagOV
 5K7Klhb9fnc9KX54bRQmT5wjenDYZbHfyrYQIQP5eqPRqQmKzImYVXjRBMhF02aC/W
 J/r7xW4NpaupKb8PFmYqtwfsw0X3Gmq5wD0vKlMrbdFmmPDWnhIBVgEBNGyqRsWE3q
 cgxTp55Tos2SY3nFcWMCfvC/bu6Q/ebp8uwg0ejE68G6SMepKwjS00tTQekBtcgIyo
 zANIAT7WOoUnAHp2Gg6jloaKZ0Noagye6bd1ph0+XeXCxCAREOhRsCuzDqsE3gIR+5
 R54epv33YS76g==
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4hWBzb3fd5zRhw; Thu, 27 Aug 2026 21:54:03 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
To: u-boot@lists.u-boot-project.org,
	u-boot-amlogic@groups.io
Cc: uboot-imx@nxp.com, trini@konsulko.com, sjg@chromium.org,
 neil.armstrong@linaro.org, marek.vasut+renesas@mailbox.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, adeep@lexina.in,
 sbabic@nabladev.com, festevam@gmail.com, smoch@web.de,
 alpernebiyasak@gmail.com, le.jin@siemens.com, jan.kiszka@siemens.com,
 iwamatsu@nigauri.org, pbrobinson@gmail.com, seanga2@gmail.com,
 bmeng.cn@gmail.com, lukma@denx.de, mkorpershoek@kernel.org,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH 38/45] doc: index: update link to mailing list info
Date: Thu, 27 Aug 2026 21:53:06 +0200
Message-ID: <20260827195313.129994-17-foss+uboot@0leil.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260825-linkcheck-v1-0-ee7573fe3a4a@cherry.de>
References: <20260825-linkcheck-v1-0-ee7573fe3a4a@cherry.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
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

From: Quentin Schulz <quentin.schulz@cherry.de>

The landing page of mailman with all mailing lists hosted on
lists.u-boot-project.org isn't really useful to the typical user as the
two other lists are for custodians or board maintainers. Therefore,
point at the information page for the most relevant mailing list for
most users.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 doc/index.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/index.rst b/doc/index.rst
index 6fe8ca0788b3..7397baeee0af 100644
--- a/doc/index.rst
+++ b/doc/index.rst
@@ -9,7 +9,7 @@ This is the top level of the U-Boot's documentation tree.  U-Boot
 documentation, like the U-Boot itself, is very much a work in progress;
 that is especially true as we work to integrate our many scattered
 documents into a coherent whole.  Please note that improvements to the
-documentation are welcome; join the U-Boot list at http://lists.u-boot-project.org
+documentation are welcome; join the U-Boot list at https://lists.u-boot-project.org/mailman/listinfo/u-boot
 if you want to help out.
 
 .. toctree::
