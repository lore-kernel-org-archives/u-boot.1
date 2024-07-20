Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6764BC3DA59
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 12:45:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA4798885D;
	Sat, 20 Jul 2024 14:43:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="TXLOhEyJ";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="uMfB5mZo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A0188886C; Sat, 20 Jul 2024 14:43:42 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA0BD88901
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 14:43:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4WR5nS3F2Vz9sT1;
 Sat, 20 Jul 2024 14:43:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721479420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3rxmLh3v5Dj9a+5VKhQzlbYYXhVzN4UeT85pZryrsj4=;
 b=TXLOhEyJr2UDkotPm7i+dxrocSx3tqL3e1E2wsdm3tcDfbNYG63wxaDiDbhY/I9l2Giez6
 W0+bQNukLFy/lZgqdtqHU9Wx8cTEX8Zy0G6ohAkm5dLxCFu6abQedl8JW1uPZv1UZ4KIWL
 1vUcFZURU8/n+PmitvabRQ9RaTGrnC5Esfb18QVt5UiaAUxrYjlvvLlU5jIj38U3uYCrIx
 W2QAo4S5mJOft0UHP6fMMjVTXVQhZdVbVBGwQkvPT2QUDss3CTqIcyVXpNwtCefhQ+0WP7
 0qxmReH+2Z1suJ6zzjiwniwQyuDcsxDlT+1YAZ3Nv/irNy5UuyuA3GwEgNqtNQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721479418;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3rxmLh3v5Dj9a+5VKhQzlbYYXhVzN4UeT85pZryrsj4=;
 b=uMfB5mZo7zuFIGJMPyQGrGwsjx39CYB5Td4GLWBYHxkNWdTVYnhh1lf1mGHLfTvAUPkIlp
 WHesLCk+Yy7VR0Kuc+lMeSKnhAMhOmy0IWyGWDqoXq301xcwm/fpk89ywv9nHZbC6wX7H5
 zwUFEucU2IKl29MNVmp9m8I3nhETKXErzJuMMWrllduo4ZAxMe1GRyUFMbFAyLKcZ1CuZz
 lHVoS73njQJqTPzF6Rl3P9wsmdp13nQahq1/O6CmEHx+zLCtN3QlwOs2Tc5d88XNHe4RTn
 0wMd8lhGCewTBt2ML8PM9N3+AoGchi63BPGeWhXa7G+tu6S/DXexJ3kgkDdzvw==
To: u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 09/40] drivers: dfu: Remove duplicate newlines
Date: Sat, 20 Jul 2024 14:40:34 +0200
Message-ID: <20240720124239.7553-9-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240720124239.7553-1-marek.vasut+renesas@mailbox.org>
References: <20240720124239.7553-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 8c931d58b55e7ea38cf
X-MBO-RS-META: cabxyfnehumd8rdfj6kgxbma9tnb35rt
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
 drivers/dfu/dfu_mmc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/dfu/dfu_mmc.c b/drivers/dfu/dfu_mmc.c
index cfa6334e439..8f7ecfa8fc7 100644
--- a/drivers/dfu/dfu_mmc.c
+++ b/drivers/dfu/dfu_mmc.c
@@ -269,7 +269,6 @@ int dfu_get_medium_size_mmc(struct dfu_entity *dfu, u64 *size)
 	}
 }
 
-
 static int mmc_file_buf_read(struct dfu_entity *dfu, u64 offset, void *buf,
 			     long *len)
 {
-- 
2.43.0

