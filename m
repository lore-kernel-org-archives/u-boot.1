Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6159C43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 17:21:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C02F84A27;
	Wed,  8 Jul 2026 19:21:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=0leil.net header.i=@0leil.net header.b="eXjBiVe3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D070184A49; Wed,  8 Jul 2026 19:21:36 +0200 (CEST)
Received: from smtp-bc0e.mail.infomaniak.ch (smtp-bc0e.mail.infomaniak.ch
 [IPv6:2001:1600:19:7ff8::bc0e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 605B684A27
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 19:21:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0000.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:7:10::a6b])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gwPyh00JLz4gF;
 Wed,  8 Jul 2026 19:21:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1783531291;
 bh=1fhymfP5POY1NZSMLuSWYXey0UM89tCXqOThvNTCdNk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=eXjBiVe3cQoHvF+L0XgcUn5DYBEM5b9wM/sN1bh+DyVUZzx8s7Rmj4Ws3Izc2ZrPF
 B7BGbiAjHG5Wgk2JHu94J3ZjfhXbR7jbKl1cFcBzUd3Hz+xXa5lcYIYOPDT4fG4DYL
 TzfsbTMQplQlKqVKXh+CWIwJdgpsDki/GexZg68Npoux5UDVs1RxwlrKA9FENmz1EI
 BH09Fejp7yxj/nknmEnURvIX2ZvkES5BUk+goDGuIz5oNU9AhmzMuM0v3XkNBRjS6Z
 I1lap9Tk/eLtt++3pSgfyD2dwwgzonrvDhIGkbXx/h/0CmG0yQKyNobyVZH4aEnGq1
 gOH8n+mh08ihw==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4gwPyg2ggKzbj3; Wed,  8 Jul 2026 19:21:31 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Wed, 08 Jul 2026 19:21:14 +0200
Subject: [PATCH 2/3] doc: CONTRIBUTE: tell people reviewing *is* contributing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-other-contrib-v1-2-8b3bd4d265ef@cherry.de>
References: <20260708-other-contrib-v1-0-8b3bd4d265ef@cherry.de>
In-Reply-To: <20260708-other-contrib-v1-0-8b3bd4d265ef@cherry.de>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Peter Robinson <pbrobinson@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Tony Dinh <mibodhi@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.15-dev-47773
X-Infomaniak-Routing: alpha
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

From: Quentin Schulz <quentin.schulz@cherry.de>

We are "a bit" struggling with reviewing things and it's most of the
time maintainers or long time contributors reviewing patches on the
mailing list.

Hint that reviewing is also contributing to the project and that even if
you don't feel you're an expert, your review is still welcome and can
help us catch bugs before they are merged.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 doc/CONTRIBUTE.rst | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/doc/CONTRIBUTE.rst b/doc/CONTRIBUTE.rst
index 0179d55dbcc0..cd9a381a3eb8 100644
--- a/doc/CONTRIBUTE.rst
+++ b/doc/CONTRIBUTE.rst
@@ -38,6 +38,15 @@ script. Please don't send patches as attachments, and ensure corporate mail
 systems don't reformat patches, append disclaimers or other unnecessary notes.
 The b4 tool automates a number of components mentioned above.
 
+Code is not the only thing you can contribute to the project. As most
+open-source projects, the U-Boot project suffers from a lack of reviewers.
+Consider spending some time reading patches on `the mailing list archive
+<https://lists.denx.de/pipermail/u-boot/>`_ and providing feedback to
+contributors when something could be improved or if you have questions. Contrary
+to what's most often believed, you do not need to be an expert to review patches
+and the project will benefit from people with different skillsets and experience
+looking at the same patches and each catch different bugs.
+
 Patch Series
 ------------
 

-- 
2.55.0

