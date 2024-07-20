Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09FB3C3DA59
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 12:44:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D532B88BC0;
	Sat, 20 Jul 2024 14:43:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Yp6vnJQX";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="yTMjKtF+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B293588ACF; Sat, 20 Jul 2024 14:43:40 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D12E9883BB
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 14:43:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4WR5nQ445Dz9sT1;
 Sat, 20 Jul 2024 14:43:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721479418;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8Gov+Qt8JO6CVEDancy5Wz/BUwDqKDSTuhI2hjf4RMk=;
 b=Yp6vnJQXvx0y6Sf0TJCnAlSLfe49OOHSF+BifrZ34G7rpqOg8pqHlzfnAGIq9MIjjoYy43
 TB2k+SJbAmDQjjg+ew7AW5yjKPJduvkjML9twi7tDBjIcjVZ9lnDY/qZiTnjZgQw+4xc39
 ygUtghSv4Byhlwep0/OmalKF0Q7ctNDJAagLDMeanf/C+LDn4zouw0knrA1V2SxaGWy1NY
 XdEei2qkwP8dUjjXx4YbZr2/vgUHR4n54gDEl3BRmMJDQh5MOUT4SseHOVrTX/nSEN2fhm
 ysFiMWYNvjmtPboKW/5zCzZJFv6KjG2TDaZVpsZb98EvZNew4dDZzwEHFuwsGQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721479416;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8Gov+Qt8JO6CVEDancy5Wz/BUwDqKDSTuhI2hjf4RMk=;
 b=yTMjKtF+T+tK/u75wvSc7cR6zR4ERjw2y0vIGeBiGoxcGBq0WIqpxSd6CIpyvlXzSKjKXm
 qfgylBZ9zfutmfyK2w1+CW24S9BxR1u2j7zO34TYOPi8nx7I6tqSKK/F+U9M+C0j71xhmR
 O6ta1/RaMcMwY8XWEd/Z8yjFCFINCrsoPzlnDg5gNYBv0zduGS/7OYd86OPF7O19R8+rQ9
 zt10kwHWipyM70q+T15AnsN9gQQIoqMui3kSygzJKJjgcMV1p4sykwjWW+pP/xFF1nprWX
 9PY3QvD9kdz/s0Ii8iciuzjIcAs7aIynCrGsfjT+w0BCKr9uKCpJhKWEZFljCw==
To: u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 07/40] drivers: crypto: Remove duplicate newlines
Date: Sat, 20 Jul 2024 14:40:32 +0200
Message-ID: <20240720124239.7553-7-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240720124239.7553-1-marek.vasut+renesas@mailbox.org>
References: <20240720124239.7553-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 3e37eaa68c09b956f44
X-MBO-RS-META: a1cek7wkhe8adb9o6dtid5pmdep74356
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
 drivers/crypto/fsl/desc.h  | 1 -
 drivers/crypto/fsl/error.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/crypto/fsl/desc.h b/drivers/crypto/fsl/desc.h
index 5705c4f9447..eb108a9628b 100644
--- a/drivers/crypto/fsl/desc.h
+++ b/drivers/crypto/fsl/desc.h
@@ -691,7 +691,6 @@
 #define OP_ALG_RNG4_MAS                (0x1f3 << OP_ALG_RNG4_SHIFT)
 #define OP_ALG_RNG4_SK         (0x100 << OP_ALG_RNG4_SHIFT)
 
-
 /* Structures for Protocol Data Blocks */
 struct __packed pdb_ecdsa_verify {
 	uint32_t pdb_hdr;
diff --git a/drivers/crypto/fsl/error.c b/drivers/crypto/fsl/error.c
index 7b232d94c2a..dfcf5dbab35 100644
--- a/drivers/crypto/fsl/error.c
+++ b/drivers/crypto/fsl/error.c
@@ -26,7 +26,6 @@
 #define JRSTA_DECOERR_INDEX_MASK    0xff00
 #define JRSTA_DECOERR_ERROR_MASK    0x00ff
 
-
 static const struct {
 	u8 value;
 	const char *error_text;
-- 
2.43.0

