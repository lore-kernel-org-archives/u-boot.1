Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 534E2CA5FCE
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 05:13:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 12EA580E87;
	Mon,  5 Oct 2026 05:13:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uKnkRyVhELkG; Mon,  5 Oct 2026 05:13:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org A51B080E59
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791177197;
	b=fnYpSgF79T2XYN/pmVZfdJWvzQORAO34YOoMg8XV8m9yau8PtBIaqWwffTPUEfWpsTRT
	 9lL6ZbqgMC9U5VExDDg2EhUTzpG0pJxJBRR89DAUVu4owLUHH+lCoP2DTBAGl4ej0uqXP
	 ip6LE/qu3CkvE9iMaJyJl5nSgHn9HB/KgxPp8tX7zME3+KIQ3Igs6HqkXYdWtlkjZZSrM
	 KvF+naN4k1Im33G5+dxy2KvL4epIn5Pa/G3/yHRJzVLJ8LmY+eMuLMkD04rBlvpg6MsL/
	 7neIf0apgsHCr7rBmH95W1RDuJRH9syDazMUExQND71mavzZJb0MNXf+Ix1pYmBjwtw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791177197;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=kSJbqxf5Z4XwLOW6EsmenlAC/4+YYjcDCV0W7/MTPNk=;
	b=ez86PTHtk4acwEsy2C8mGEimnYEL6agiI7bEgyhsNlDiXH6eFC4OQQGhsw2++3sY3IWQ
	 pDVzU9t16h0fflsvsAyICNtCharB3bFqe3duHrj6T60gtPGJKdWyYRS4oClaRAdWhKAS2
	 ZtYs43Hqy0aIH2GgzOLg26IUjR255Y/cRUU2VOMki/lP/WvOcZSie37xj0UaI5t6xljhv
	 p7V2LMRMcag2a/Q6YapPJVNo9MG6zpQBgN8Y1xVJDDtALM6Aecz9MEzAkdr14eCVJg8l5
	 9Ga4WqPdYfAQDGUIgMGRZDjmGSDDrby4B/KHD1cP5BxtzcRBX4ruhWylqIEXasYNX/Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791177197;
	bh=kSJbqxf5Z4XwLOW6EsmenlAC/4+YYjcDCV0W7/MTPNk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=B6VEWDzcEcNwu7afaFe+khDk3cgDbdn6uzA6PYXjNOqDfeRtSWx+6UjdPtsvAKDcu
	 2SU5iJrDdUc4qio3yJV4eX39zK7lWf9hl3qJdBteZ3EekqCgNQB/t0kJq/YyKvsyCT
	 BipBgNeWNHJQF7RhRqAzUP8TGx5/fEDpYxC75bPEIqPOzBS9MhUWAjAX0uSVA0eXn6
	 vQD9naqEvOI7DfE63tSjWaxc0J9U/iPwfg5scIdShBfV5YAw2wRLrjxdibQVmLYGh9
	 pZjfMsRL5nWSiP7sxAolKWEJx7be4csyxTBFlUs3H6JypksrGleAYqjkM5WKivJXIN
	 G5CvNRPrSl87w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A51B080E59;
	Mon,  5 Oct 2026 05:13:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id CB98B2E0
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 20:48:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C97AA6060D
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 20:48:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JqlHS9-kSTea for <u-boot@lists.u-boot-project.org>;
 Sun,  4 Oct 2026 20:48:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 12BAF60607
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791146919;
 b=pi6UdPslUIWtW+xIsVpJRG6viTc6LoFqQR5taOl/uGCo+mxZ/Cr3eLraP/ztkOfto4C9
 TgJNEqAuErUbNGGs/MQXu3oievm4OHXBtYBnzkSLDYHynUZLo+gi7QQtI5rOrdlgv60t3
 hCuo+/wNAYxwA39PG/suLj8ooIVAv5ZizuMkO2uwVnHfYyh7zxqtujLx09Kz1rrIvqK4N
 tbBbinkGWkORxfA4K2qLbnxqpHEH9CHOcs2qrZt55YW3oSm9FJC/BEGdJ0rMPbcWoS+vc
 7iPxUVDRxxVF++FvloRTYOugEKg1A54EY5zdfSrn+KnzbsC4v4hNvu8mZrli57MLl6w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791146919;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=kSJbqxf5Z4XwLOW6EsmenlAC/4+YYjcDCV0W7/MTPNk=;
 b=RSYILUqVzRPipZrZ9nVE3ylq2hcbx9y1DAsAwJi1Pm/66lNt+gSVAOtK6VHnKR1d2O0K
 vt4ZslZSVVUPrj9aj3s+/y/M03LlAgtO4se0BDrHvZcLhSsZoxpjHQ5FB6kwsu/gigOzc
 dARagtpBudSCoANspojfsIUFrXxXgQ455Q380DZDpLILvyxEzSUU+VqNHP13/kFrvzh0/
 Hi8C2vsfLs9yREiUFu1ndlXax/kvDQini9z3x2UavT/6ks5AFdbimZZxQUqIyGmesTdfX
 OdsrPy/UPQNPN0KijGZrEsB26jBJtIXkaZEAydMfrkRLRjEnVluPoJoZzUNHyD9vlyA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=F6BCm1gr; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=devnull+petr.hodina.protonmail.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=F6BCm1gr
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 12BAF60607
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 20:48:38 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id B712E60200;
 Sun,  4 Oct 2026 20:48:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 664A1C2BCC7;
 Sun,  4 Oct 2026 20:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1791146916;
 bh=RzOlb2zoDHejdGIX7nFqk42hjaIeuofKnVw1z5R0z0Q=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=F6BCm1grVt6O701VS3vBNKuoK5DDcKcajINz9qoRtc1ioKT41rpro1cMX7idAd8eY
 v+ENIUDq/pfIGHyheU0y/EQNg6B31E9JdTEiqFMrnYbBbl78c3RUU1NRAzb6yEhVvT
 8N1oE3ARgdXE2uJv/qT5lstlGuAQKb7ItMVVoFvfWUNSwLiK4r5t19WMDky61LmxJw
 0thBMZ7pmJt+/ZM4cLhIuKjEAUF2ttLmpG1YIiOAYWAcSyEyflv7AS8tHoKFKtsIVn
 LpAJ0NLCtDzuZF1l2ItN1XMG6v9bvUz0F4dJVtTd7jV7W9WjpFxfqD9QltfkVWwNN+
 Bsm4L31DUPRCw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 43B59CA5FEC;
 Sun,  4 Oct 2026 20:48:36 +0000 (UTC)
From: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>
Date: Sun, 04 Oct 2026 22:48:25 +0200
Subject: [PATCH 1/2] dfu: expand ${...} env references in dfu_alt_info
 before parsing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261004-b4-dfu-alt-info-env-expand-v1-1-700eb0e54b61@protonmail.com>
References: <20261004-b4-dfu-alt-info-env-expand-v1-0-700eb0e54b61@protonmail.com>
In-Reply-To: <20261004-b4-dfu-alt-info-env-expand-v1-0-700eb0e54b61@protonmail.com>
To: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>, 
 u-boot-qcom@groups.io
Cc: Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Tom Rini <trini@konsulko.com>, Sean Anderson <sean.anderson@linux.dev>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Antony Kurniawan Soemardi <linux@smankusors.com>, 
 Petr Pavlata <petr@acrux.cz>, David Heidelberg <david@ixit.cz>, 
 Petr Hodina <petr.hodina@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791146915; l=1237;
 i=petr.hodina@protonmail.com; s=20260107; h=from:subject:message-id;
 bh=zHNicPZo8C+Jci1O2ZgaLbRZF4h4ywq5+c81LYRcock=;
 b=TETMBfYEt56Vd2zQjwpcELzYtRy61nrRJ/aSWbTyfYizo3hUW7e5g23jRkhOEk3lMAKB8PrUR
 ksRjtjaPbF6Bez4vU4fbyAoi8rHKxbXZYkLHaKHB25cNujI0kwmjSaI
X-Developer-Key: i=petr.hodina@protonmail.com; a=ed25519;
 pk=3QaVc6AaAu1IsyyH86+LIOOFhD7kCws8Xhe+wwyE7Bg=
X-Endpoint-Received: by B4 Relay for petr.hodina@protonmail.com/20260107
 with auth_id=594
X-Original-From: Petr Hodina <petr.hodina@protonmail.com>
X-Mailman-Approved-At: Mon, 05 Oct 2026 05:12:03 +0000
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
Reply-To: petr.hodina@protonmail.com
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Petr Hodina <petr.hodina@protonmail.com>

As dfu_alt_info is read via env_get() it needs to expand the ${var}
references using cli_simple_process_macros.

Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
---
 drivers/dfu/dfu.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/dfu/dfu.c b/drivers/dfu/dfu.c
index 90d8b45ce8a..fa074db242c 100644
--- a/drivers/dfu/dfu.c
+++ b/drivers/dfu/dfu.c
@@ -6,6 +6,7 @@
  * author: Lukasz Majewski <l.majewski@samsung.com>
  */
 
+#include <cli.h>
 #include <env.h>
 #include <errno.h>
 #include <log.h>
@@ -178,7 +179,20 @@ int dfu_init_env_entities(char *interface, char *devstr)
 		return -EINVAL;
 	}
 
-	env_bkp = strdup(str_env);
+	/*
+	 * Expand the dfu_alt_info here as it's read via env_get() which
+	 * does not expand references the way hush does for a command line
+	 */
+	env_bkp = malloc(strlen(str_env) * 2 + 1);
+	if (!env_bkp)
+		return -ENOMEM;
+
+	if (cli_simple_process_macros(str_env, env_bkp,
+				      strlen(str_env) * 2 + 1)) {
+		pr_err("\"dfu_alt_info\" expansion ran out of space!\n");
+		free(env_bkp);
+		return -ENOSPC;
+	}
 	if (!interface && !devstr)
 		ret = dfu_config_interfaces(env_bkp);
 	else

-- 
2.55.0


