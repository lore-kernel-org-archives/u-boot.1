Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE15AC3DA59
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 12:44:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FC698887C;
	Sat, 20 Jul 2024 14:43:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="IWdPs/Kb";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="cGsv5eNs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E03F8885D; Sat, 20 Jul 2024 14:43:38 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37F28883BB
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 14:43:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4WR5nM6mR6z9sWs;
 Sat, 20 Jul 2024 14:43:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721479416;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=shOjD/v63Hwr9FPl3+wixN/nMEVhvh4pqcsj2b/89W4=;
 b=IWdPs/KbTxfYxR73Cu6XHsHziVy9YR9Y5npoywfis8RYdhEp07uD5Ec2u9qKniq4W1Hntt
 HF9oMwv4LWRZY/Iqenif6PF/DgVvLXhs+3R+zl7/rGaRFV5sVvx18jYmjRkyoouBuP7Wfp
 +mSufxmW/Mj0+XlgMQ0b0LXKLbO7cvHYWaORowp48YgQesg5P1EWJ0Yk+w4O9rSb4d2Neo
 90l4bTqsFE30Eo5Mu0U7yXkmJXJNRpGszz7LIQq9m5MzKECXxckgZmAnmp2JzkpgPMn2Bb
 RbbkcqjxFoSXlYszv+VN+1FUkZy3n8QLcGpEI3llarI037n8ZJYSADqB5zpXNA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721479414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=shOjD/v63Hwr9FPl3+wixN/nMEVhvh4pqcsj2b/89W4=;
 b=cGsv5eNs4W3OmIaOF9wem5dAKKEhX/xeZ3kGKotpr5eWgUO8Xj/KOrIbXixcSMFCzSBZJ0
 mPQDGK0OMB59VlNUcAp2C8tscBMbN3IoVnA0u2+G4zvweLv5kvAsqfj0GxXkENQvUiQGxe
 qPZLWf+YJuItE68GOo1pLjVANhUXQETJFVYyHdC3m9jPw1Eqz8keguC9SCzhqSYeaI5gqg
 OJYVYkm0hdZNLf/wilqrSVkwGq/l6Pd+XQD8u/J+No9ss8pH509Ve/FcZurm9FrA417n8/
 O90AZxNwFk8qaNtPV7xlFlbBrYNY+L9Dw6Qzvf4LUFn9MT36iN45bRGDQziLcg==
To: u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 04/40] drivers: cache: Remove duplicate newlines
Date: Sat, 20 Jul 2024 14:40:29 +0200
Message-ID: <20240720124239.7553-4-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240720124239.7553-1-marek.vasut+renesas@mailbox.org>
References: <20240720124239.7553-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 1056139bbe036f1a4e8
X-MBO-RS-META: xy4sh4hay6op47tz6p4jki737oho7h6a
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
 drivers/cache/cache-l2x0.c    | 1 -
 drivers/cache/sandbox_cache.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/cache/cache-l2x0.c b/drivers/cache/cache-l2x0.c
index c7bdd9d064a..8b29af42338 100644
--- a/drivers/cache/cache-l2x0.c
+++ b/drivers/cache/cache-l2x0.c
@@ -62,7 +62,6 @@ static int l2x0_probe(struct udevice *dev)
 	return 0;
 }
 
-
 static const struct udevice_id l2x0_ids[] = {
 	{ .compatible = "arm,pl310-cache" },
 	{}
diff --git a/drivers/cache/sandbox_cache.c b/drivers/cache/sandbox_cache.c
index 2e20b83ab80..375892fafb0 100644
--- a/drivers/cache/sandbox_cache.c
+++ b/drivers/cache/sandbox_cache.c
@@ -27,7 +27,6 @@ static int snadbox_disable(struct udevice *dev)
 	return 0;
 }
 
-
 static const struct cache_ops sandbox_cache_ops = {
 	.get_info	= sandbox_get_info,
 	.enable		= sandbox_enable,
-- 
2.43.0

