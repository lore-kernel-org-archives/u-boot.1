Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 968DCC3DA59
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 12:48:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B80188C84;
	Sat, 20 Jul 2024 14:44:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="IHxc3r3F";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="YxH9FgzX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDD7888CA2; Sat, 20 Jul 2024 14:44:01 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E427D88C79
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 14:43:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4WR5nq3F89z9sSs;
 Sat, 20 Jul 2024 14:43:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721479439;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pZnzuT/GjuEPwGGMgWS/IBv3czZPBwqX8u/sTtaIOcs=;
 b=IHxc3r3Fdohp7UkedUC1k/iZrwSIn6Cf16PGfrGlhVFjbkKxhJScWeZe4kq1AQzXroaLcA
 cSKUXflhmHPB8BK074yqfHIxM8phsh6/yBT8TewcrWs/5njoE6iZHBgOVDO7n02YWaG+EO
 YEXHskWdLvlbxIYR+ncfk2T65awdGmNWE5Gm6LmcTpyfEFrBM1mwI7KVHHBk4tfYIL933y
 PXqEMUA7eDD1YLQ8FwZb4mPdqyh3Vc46Rm941LTfku5NbtPA2KivNb1VzZq/MpGpUBoSXG
 zNDz70C62JZ3BlAmjoRM4KtijEM6BH0Lf01QIs9RpDeYRZ0EXbb6xQcT40H+wA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721479437;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pZnzuT/GjuEPwGGMgWS/IBv3czZPBwqX8u/sTtaIOcs=;
 b=YxH9FgzXq9Vz/cduGT8eGsUxCHZuU8mXFNdKX0PyWRMH+2Fh7pPtBttyMYI0yeOIXgeyTP
 a0ICQ7vQ/E0bUdYVWKwGsi5bdlZ/U8sWeYmXNnxBMqugZwQIa7AeXNMF1g4fOQGlc5sKf4
 o16QznD6kjHOLqXgzbsR6XaP0rCx0cAKniOambLaMM/HbnJNwEl/6m6uGVHw0FJqzenLBf
 YdPRb7FGYsnUB83xWQxUzECkA4lRp9fJBEXmXo0Cg2Fxh3enQUoAYNPXzD3/HIExL20H6R
 XhHotdUVxDDgA4pO59pwBodaSflvz4M2ftoriaLVbx79uZD19Gts2oEn6gjFpg==
To: u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 29/40] drivers: scsi: Remove duplicate newlines
Date: Sat, 20 Jul 2024 14:40:54 +0200
Message-ID: <20240720124239.7553-29-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240720124239.7553-1-marek.vasut+renesas@mailbox.org>
References: <20240720124239.7553-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 7ec406002881853df55
X-MBO-RS-META: 3d9foaqmc6wkxyc5oxczzstuqckidiz3
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
 drivers/scsi/scsi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
index 73cb83548eb..51cacf34792 100644
--- a/drivers/scsi/scsi.c
+++ b/drivers/scsi/scsi.c
@@ -345,7 +345,6 @@ static int scsi_read_capacity(struct udevice *dev, struct scsi_cmd *pccb,
 	return 0;
 }
 
-
 /*
  * Some setup (fill-in) routines
  */
-- 
2.43.0

