Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D653CD343F
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 22:08:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCB8A84C2F;
	Fri,  8 May 2026 00:07:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="rCMxL0U6";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="PBaMnkb+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 902AE84B86; Fri,  8 May 2026 00:07:34 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4431184C27
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 00:07:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4gBRFH6Wm6z9ttL;
 Fri,  8 May 2026 00:07:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778191651;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=juRqpJewwuUCi5QIwb8bOz1MsLYqoXxqAcBZxV6A+J0=;
 b=rCMxL0U6LsAvFYlj4P2Z/5KCDME6LUjuUix+EpEjNegatglH9JLB8jDigBqPZzCjcK6iAk
 JEsE1dkomYao4aniKkc2tfDWSK5PkfWAYvaqf+xaw8+X2bC2pLaWLzQyCXM8v2aXPuDH59
 D0rZgLjCgSWJUCAvdUVotMD4Un++0Q1yfNmusufrbqKD2kcaorPwEO5KBy68IG5iKDgmJz
 2ENsewg8OZcOfedTrDnqxTk2ktKCxEnvoDboWVU1on7EiSAHyUnFslXQXxtoxp2cVM8lsC
 zzlIEKUONoTjRpKXFHs2Z57oKUu90c6jWQf8aq9Ja+Qtn4IEeUhNxwjcClbSkg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778191650;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=juRqpJewwuUCi5QIwb8bOz1MsLYqoXxqAcBZxV6A+J0=;
 b=PBaMnkb+EzLaNrjuiBVSt7ZVQa5UyKoz9dNi4Kqip9esPiC7tvNxoY2LgCMRF+kuteYUU5
 By6BlGS1sPACO4v+hEiu28ZpCO5seJkz0UhmEXEVQbwXGGXgHg7CB56GgumFdEKLVc103b
 mkqx0lZLbwWEUnzt1gXGVg90Lw1qo1/KzbRz2ai43yjT/HKY+0diIGRnAUc9AR17DCwqXX
 Mpb4433qw/YVaG10UUBZwFT3wVMaeg7uncNuc+7lAdETDLTlhdf1cHfn/CFm+7vUqrhclb
 xMzpmELI713KG90Yh0bSnc+2B7w61umZVoEhVrwYTperxFTgcwsLRNDy3Etg6w==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/3] misc: x86: Staticize and constify driver ops
Date: Fri,  8 May 2026 00:07:16 +0200
Message-ID: <20260507220725.209205-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260507220725.209205-1-marek.vasut+renesas@mailbox.org>
References: <20260507220725.209205-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: y5hejz6dhufeut437hitz1gq37fy73g4
X-MBO-RS-ID: b31f614d3976f025d56
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

Set the ops structure as static const. The structure is not accessible
from outside of this driver and is not going to be modified at runtime.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/misc/qfw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/qfw.c b/drivers/misc/qfw.c
index 0e002ac25f4..8a11637ca7f 100644
--- a/drivers/misc/qfw.c
+++ b/drivers/misc/qfw.c
@@ -152,7 +152,7 @@ UCLASS_DRIVER(qfw) = {
 	.per_device_auto	= sizeof(struct qfw_dev),
 };
 
-struct bootdev_ops qfw_bootdev_ops = {
+static const struct bootdev_ops qfw_bootdev_ops = {
 	.get_bootflow	= qfw_get_bootflow,
 };
 
-- 
2.53.0

