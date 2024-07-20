Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54F12C3DA49
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 12:48:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7705488CA8;
	Sat, 20 Jul 2024 14:44:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="d97iaDBJ";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="jpVwYkhX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 770A7886F9; Sat, 20 Jul 2024 14:43:59 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5AFD88C5F
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 14:43:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4WR5nn3Dzkz9smn;
 Sat, 20 Jul 2024 14:43:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721479437;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZktmtillKofkRBjq23/1cIulLPYV0WHUQqSGlPQTPnA=;
 b=d97iaDBJEyyBDOtoOc6A3KhyUp4MwSOGl6/RqNrFQ4hMgckudGoykWKT/o86PE9vJUk7rK
 KgNEnMxpilmVk5Pu7JiERixuIFSIRB9jf+zCzYLGv1ocMhmtRLdXDY+qWfDfiLqdnGcRgi
 nuideUDGFxy/8wtu8Ua+tvoclJgiHQsmpUON7n/yJSpyFLbZASgN8dWp3H00Nghun2uylZ
 ZEwDE5P9Xlmp2hTWed6IAdXjJ+24DmKfvdMDK0vL+sUsHu5QdLT8H22b3/OsNxAsWfUl3p
 ZQIvDtjVV97C98mP0lCqVW2kNIxoE3iNqDARRGqNtD2t1ky3S6bAvs4UdKvUtw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721479435;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZktmtillKofkRBjq23/1cIulLPYV0WHUQqSGlPQTPnA=;
 b=jpVwYkhXe/jtj6/NH9IO1FJhmiy1lfciz6zy4sWThqWBih59YA2FqcaL+aHi93LudHucc8
 k81mGZhQViHRUzBie4u1F0fnknNNYLf5uEgmEDppla5KhF+9ZmfsiqHT9T0LGKoTr4hLTC
 IBHcskx8arsJRM6P/CSwuCNtfxfG6s95G7NXh8aorqbZpCqtM7CCOcxIxr2Q/Ac/Ji59vL
 vAAmV/clpPwa7W4SPdoMl7mysNcRcNZRKh/gF4i1Kl4RAHpb5H67ciFp0lZUZSqH9vJCQ0
 mV29YKZaMLkC9dgacKeXMmkg4PSAi5gAHRg/z1bhqwNudUJm6VKqo2tqs/ic7A==
To: u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 27/40] drivers: reset: Remove duplicate newlines
Date: Sat, 20 Jul 2024 14:40:52 +0200
Message-ID: <20240720124239.7553-27-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240720124239.7553-1-marek.vasut+renesas@mailbox.org>
References: <20240720124239.7553-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 187066f06f2838fdd1d
X-MBO-RS-META: 7x9np74h35ht581pypgihebqj5wrjnyj
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

Drop all duplicate newlines. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 drivers/reset/reset-ast2500.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/reset/reset-ast2500.c b/drivers/reset/reset-ast2500.c
index 0ed5396b3e9..f3543fa8cc1 100644
--- a/drivers/reset/reset-ast2500.c
+++ b/drivers/reset/reset-ast2500.c
@@ -63,8 +63,6 @@ static int ast2500_reset_status(struct reset_ctl *reset_ctl)
 	return !!status;
 }
 
-
-
 static int ast2500_reset_probe(struct udevice *dev)
 {
 	int rc;
-- 
2.43.0

