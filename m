Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81519C3DA59
	for <u-boot@archiver.kernel.org>; Mon, 22 Jul 2024 23:30:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A183E886A0;
	Tue, 23 Jul 2024 01:29:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="uAfGdJyk";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Hz0WZdBG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8634888644; Tue, 23 Jul 2024 01:29:56 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1332D88622
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 01:29:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4WSc265Ffpz9skn;
 Tue, 23 Jul 2024 01:29:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721690990;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s0QaXmbnn+hW/wnpaNOyFD54mKg0QP6mnDT5Fy6l77s=;
 b=uAfGdJyku1aSu0jGF+0DB5lteqskhF9FocHAfFEySjXBFT4swTv/C/CcsPDPlB6LKK+/H8
 mWB7GuaG8Jtt0hko0xbbsOCZrYm8cLcUlKrknoEueFZX15VHWqQBB/6oZ/2CgGLQHOMGMU
 U/L3yvlDpMyPn/AmrSS9kjb+qb2Sr4QIegAkC29xhTYz0s7soUpLIikNZdvhITNneLeZbK
 Vvp8LKEgdhneY9qfS7mCBlJ51W2WaDyQZ4B7Z0qxDjBxdozX2waJnGSVGENqJOsPl74V2a
 s5Yzag6hUrtOoaGmckQQKm1TPK+HZFb6RfzO4DdG5jPKQ5BR9X9wMG/Lyh9o0g==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721690988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s0QaXmbnn+hW/wnpaNOyFD54mKg0QP6mnDT5Fy6l77s=;
 b=Hz0WZdBGfSP4yxyxlYyvA8N1cTJN+VqujuCqMultBfeJqsT2tz+r4D8+L1pmPik7RtSI2w
 qELt4kbbiyGOcqAA6NtG2D3Yk+FRGWl8vZlaYoWSoHH0YffUGSZXyyC4VTm8fWl/BgPAaV
 VYX1OipfDInXgSX9kJ0ZZYhwDoAz2s2mDrFsqiftzqAgMX1PTLqfKu06tDqaqsrbsO2LiI
 gO78e40sKXFGyfz0HlefC8WdqMwCis+hleXHiIm54y0qG2JBU8a8XOLyqIphL9bBh3ySxN
 mYoGmCcaBWmQ/AxfiCqeL8Nys1PaC6ZaraDztdufCsCCP31GHsJUhNNqQ8Qbzg==
To: u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 02/15] include: dm: Remove duplicate newlines
Date: Tue, 23 Jul 2024 01:28:21 +0200
Message-ID: <20240722232910.91249-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240722232910.91249-1-marek.vasut+renesas@mailbox.org>
References: <20240722232910.91249-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: a41b0f3ecebd1090194
X-MBO-RS-META: zhxbcanw6oizwgscgfuepyjr8tngt3x8
X-Rspamd-Queue-Id: 4WSc265Ffpz9skn
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
 include/dm/of_addr.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/dm/of_addr.h b/include/dm/of_addr.h
index e7f3a280817..5fb5a4855b4 100644
--- a/include/dm/of_addr.h
+++ b/include/dm/of_addr.h
@@ -44,7 +44,6 @@ u64 of_translate_address(const struct device_node *np, const __be32 *in_addr);
  */
 u64 of_translate_dma_address(const struct device_node *np, const __be32 *in_addr);
 
-
 /**
  * of_get_dma_range() - get dma-ranges for a specific DT node
  *
-- 
2.43.0

