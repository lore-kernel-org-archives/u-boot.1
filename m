Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45285C3DA59
	for <u-boot@archiver.kernel.org>; Mon, 22 Jul 2024 23:32:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E251D887E6;
	Tue, 23 Jul 2024 01:30:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="KlBhToVu";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="BX0b+c+W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5CB487F82; Tue, 23 Jul 2024 01:30:06 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E08F38862D
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 01:29:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4WSc2C4zc9z9sWt;
 Tue, 23 Jul 2024 01:29:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721690995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OtXSq8S51i0rXv08UTT8bFX7x5ZV9oVVb1F3syN8nxU=;
 b=KlBhToVuwTapco9FxyNOzYEYgUlRtCh87VYqmZliS85i++Drz5+lBBsjDtg4dWaWXtJB2n
 DWupLvwzpcgBejply7pzJHrEg4mo0K5XjcPTK4g0UACzkij+Q9Hey+YcM19hFutCQp2jkm
 fLo+TWRjnu3+Y+FFG6pak/Fx3RVeQzPx/M5AlGzLKkYkbcvi9hQ+J3Zysc3Z/f5pDzVFHI
 S8rUXvl9o7rl036nEOXszf1qlavmBNHsvdJtzCi8pxMsfBg5vhumKUBHdWYfKVtpvElVp6
 +tPo9YMXaBD4ezysN4aERyfTsoD+b2KBBxsYyts6Sx6r2qrYvR8HcZj7JheTLw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721690993;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OtXSq8S51i0rXv08UTT8bFX7x5ZV9oVVb1F3syN8nxU=;
 b=BX0b+c+WBMHRMnXClAFhjba5ms8QU6riJNAyBZRMaT55VzKjrktKX2QyAGIqbnL+YDe37v
 KAAyqmiD3JwLHhI+8AE+MLr9OjDiCZ5MN7V45aP53NAzl8Ppgjg8PeoNoUOe+o/2o8q+Y4
 IPEVU0uqf1xmlmLTKnsg6olMaP0Mmko8D/jJKuW85ROFg3zsuTZOWFZUwYBGKBUl2kGTOn
 d2wN7zl7DeGAEz1ujdegf4lMZn2cgw1evQDob7tb0aZ2diZ9UsmIhvvcEPUBafBIXae7k4
 CL+LFyIulYm0jieis5NjrFCWb9I/UNEBiR9q4idlUCs810a8UA/+abRjRwsE5Q==
To: u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 08/15] include: mtd: Remove duplicate newlines
Date: Tue, 23 Jul 2024 01:28:27 +0200
Message-ID: <20240722232910.91249-8-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240722232910.91249-1-marek.vasut+renesas@mailbox.org>
References: <20240722232910.91249-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 410f7de7b5917e3e0d0
X-MBO-RS-META: nag4cqu536uhktpocbzs37qbcpje881m
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
 include/mtd/ubi-user.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/mtd/ubi-user.h b/include/mtd/ubi-user.h
index 8d472cc0138..cc95fa2edea 100644
--- a/include/mtd/ubi-user.h
+++ b/include/mtd/ubi-user.h
@@ -421,7 +421,6 @@ struct ubi_map_req {
 	__s8  padding[3];
 } __packed;
 
-
 /**
  * struct ubi_set_vol_prop_req - a data structure used to set an UBI volume
  *                               property.
-- 
2.43.0

