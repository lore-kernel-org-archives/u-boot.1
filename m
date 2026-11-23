Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EDF606A330
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 22:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=dGa0KSIQ;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m8NDJTRJ
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A666D80C71;
	Mon, 23 Nov 2026 22:21:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Zaa6hhNwUu_M; Mon, 23 Nov 2026 22:21:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B85EA80BDB
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795472514;
	b=sxbaMHthjP82Gq7p1HDFzeeD26SJDRTCi3dPp9YknNTKXwIPtijNyWLgXfjXYC/IO9Sl
	 N/RP7kM0HXeo7JbyxaNKZ9W1W5Mr3kPMFgpIjkx/rNt1NWr9qVn+xDj5PFJvCjNzl1Myy
	 64zq2t/pmwh3SPopeyOMDJLK9eWbkOZbqRixP/PPuYOKmNxDAkCKrkvcGsy5lDS/ErGt6
	 1x7+vUeqnXvGFOtw6EnqzKHK37aZ+ev8AHqFAbJ5Hf4cf2ncBiDKkfCuiWadKVS3E1WNL
	 KyGsegSBA/EsDaSW5Eku5wzojQa/KsIYfPupKYkShH/6a0byAdfSOtJ6mPn/yHxGlzg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795472514;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=qyuHeV+FP9GupXn26bjIL1viOX5asMNeubDQ2Q0XK54=;
	b=cI3o75rXj7wzlo1hRqdDtScu6PxSGGnZVziqwhxLhH4KmfoMhvmCl8ArSgNjbbOXhqcG
	 qvkqo2RWWs0xHHdffg0wMAA0NYSAYsNii9bXfXny1FjOUOQAxI4oAIsMQBFWfN+uASBew
	 iRtftaDOPDpLxbmEW4cmI3yZ1b4JmrRyvFmJ/LjmXEuWTRuxEeX1I3AezB1fWxBi/p8QN
	 Mcg2s9vQVsiarE6RYuS469QUCIe2NUFXxYCKoNxBAkZBynmaft37vAyzBmmV7ig5mr+8V
	 +dbiMXzTkZPU7aiWBYhcWMpb7xnNlxOhkk6Nu5U8y0mMQGAvLkldxjESb4ft59Ww1Cg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795472514;
	bh=qyuHeV+FP9GupXn26bjIL1viOX5asMNeubDQ2Q0XK54=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=dGa0KSIQ/PdEkfrEFSH7UXRJ53C6GHF3Mf9cLAK8hLJmb99DMqRNEFfHYY1qK1TBX
	 tGZalSyVP94GQFVMenPzzfxTgxsZ85iCszD7kMA4nUyDpi+gA1pS4mtM5x8cvMVD5A
	 moHYUtzdMfYF6J3myr/AnkbfeRYpxULz6CpVWPRWX2njtIuiZGiUxcvhwOOxXiG+aS
	 FLitU3eQYXMx8T6XfJZ5EIwCwbMWhfy3qUTI2O5j9zPGmFQnTiEi2jyK1mD1fIfjl+
	 e/58Ls4Fg9WCRNtWg6jwLWCJJla3MsEAEh2p/MDwH7yegbfoXob4k4mslyfEUSC+96
	 eDBtRg7JDMCsg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B85EA80BDB;
	Mon, 23 Nov 2026 22:21:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 44E5A310
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 22:21:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 36726605EF
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 22:21:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Nc7_hrmWCKJU for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 22:21:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 34D72605E9
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c33"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c33; helo=mail-oo1-xc33.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=m8NDJTRJ
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 34D72605E9
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 22:21:51 +0000 (UTC)
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-716d052dc23so1717935eaf.1
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 14:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795472510; x=1796077310;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=qyuHeV+FP9GupXn26bjIL1viOX5asMNeubDQ2Q0XK54=;
 b=m8NDJTRJOrtT7EIFvYA+GtiBADxLWZzWJ4OQGJk1M23u9sM1Rj0pa/XFjoPg31fkTP
 29I7vwU5tpLYZQdnyf6Sid3jKPQiXd24zvWtihXSdIbSW7O8P9or2oZAh5M55MqU3SLc
 nBM6Ahw42X3X/IXOU+iVeH4qzty21JNHGaMC7SaklR8iHh2DrItPNA5r9JveZRjtwddg
 mkNEvDzzY1pG6j0wGOnFqnBD8zHZPiyHuFFHPmQrGfmD/G3pZeNKzzL+FVroGukSew6a
 wFRi5gZgUXCxMyzP/Y1VQ2F62JyTxHakzTEL9oykO5TRPac+fFEL9qBMVTrj/wHRVirP
 yrRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795472510; x=1796077310;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=qyuHeV+FP9GupXn26bjIL1viOX5asMNeubDQ2Q0XK54=;
 b=u78TqP8cpYEnY5gpeb/CLbocnxUTmurdiiOdqjWwFoSMdLrx9z+t1XwnyiK3bQJHHa
 WBH9JxFSev+rvDQ76mAWxnsORlvAANYQx+GQF8uuRiS+aHsMRV870JBOOkt04XweZCQr
 TXhYyMnBPYCquFxKtpYxFjL/rafbBFpaXwOzsW31tB/oSQFbojrcF+S4ohDWj0MYa1Mj
 aVkCKT8RYqPaEXippLGGidySLPcGFFh12pF7bf5exZ5QPQMoPNoakkYE9usi3yDRuenl
 SObxgGE7B1cQjr4Z6xwk53TxIKWORsvzEQF4B4nKNhFnDQc7GAqsQ22PhPuZqBgcGXj/
 /+Fg==
X-Gm-Message-State: APuU4Z/NlmVDHxNF4rwIxg93pFkNqi//IGF2NVPVlkMwS7axr9g2x4oC
 jbKFUCAj9Cr0XTCVnAv9OOUALkPIGrIt3dtqUtvwT+TIwjJsE8J0cpvX
X-Gm-Gg: AZFdTZf5iepmmNTPZtOStDmUKXMWYmbmS3suF8R7Fum4jzFu8iub1PftCDPxU+Uc6D6
 c/3vgL/Wq0o2t6ThPg4VYFPwrRWdzTNnpFzlRreZZG26VbN1w78k3xKz+pcI9HiNXMg30PCDN1l
 MVnpOmsQrlOj5JNU0vh8BoIShFzqQQ1k9NROB8lZIFtyyugmro84MaN+dbKLzODyVkth2SvKEHg
 0zzF4KusNs9nKN9lsfTEg2zM+s2otP2ZneD+e8CGxEWhmp7DK2RyDXSadfxiLbZjO2yLhdrcQzC
 lphtEq08PBBSFT49kzR6thiYB0PLXUOMNU6S49tVeGqBncInI3V8eWDl6OfvmXwJQ87OPgF9fsG
 hVTpI1+U50vlksw8jbthJPE7F1EYNou/7Asbjxn+iH1nHZ0/frGC5cFgR47TsIM5qNMe8RcHit6
 zJUAb9Vn7Gu9wSdT9ocRdOg2p8HOJkZgjOEQR9WMFW6h368cqODF+imerdCOw0LoKeGWMdoK8c+
 euJqgv78H2gNgqCvw20d/fwJRhRLjzEj0z+O7iAcZfjS1yacfIlBBeWR8ONSAQMXLimMXB4h9qD
 dw6BiT98wWgcrTzCzCXJe7GfzWlhFhUNVasL4bkUNQJuyQ4/lvMkBb5OGIKC1jLfPlnyAT235/R
 U5z0ZpNHauaSF2FFcO0/FcY7CCi6St4x12b9qAd8vyLUnYTPQ15NIVitEls5txLeNU9773l6dN/
 MGf6yScevDmxbvZbv2hYCAufO694o9ntslLEj0VuIbCi5ClUnQbqcN
X-Received: by 2002:a05:6820:709b:20b0:71a:f209:f038 with SMTP id
 006d021491bc7-71b3957b875mr7008169eaf.74.1795472510535; 
 Mon, 23 Nov 2026 14:21:50 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4bc5f7ae7dcsm11533802fac.8.2026.11.23.14.21.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 14:21:50 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 23 Nov 2026 15:21:47 -0700
Subject: [PATCH] net: make default address settings available with lwIP
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-submit-lwip-net-env-defaults-v1-v1-1-db2e3436c5c3@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXNQQ6CMBBG4auQWTsJbQNBr2JcjPCjY7CStlQSw
 t2tunyb720UERSRTtVGAVmjvnwJc6iov4u/gXUoTba2rTHWcVyuT008vXVmj8TwmQeMskwpcjb
 sXC1t03VyhFBR5oBR19/hfPl3IR7o05elff8A8bIFVoMAAAA=
X-Change-ID: 20261123-submit-lwip-net-env-defaults-v1-330a6588a9ea
To: u-boot@lists.u-boot-project.org
Cc: Jerome Forissier <jerome.forissier@arm.com>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.17-dev
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-20.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Switching a board to lwIP drops its configured ipaddr, netmask,
gatewayip, serverip and rootpath from the default environment.
include/env_default.h already emits these variables for either stack,
but Kconfig hides the corresponding options behind NET_LEGACY.

Keep these options under NET so board configurations can supply the
same defaults with either stack.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 net/Kconfig | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/Kconfig b/net/Kconfig
index 6d6672b9662..61e47838dbd 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -175,17 +175,15 @@ config BOOTP_MAX_ROOT_PATH_LEN
 	help
 	  Maximum root path size, including the terminating NUL byte.
 
-if NET_LEGACY
-
 config USE_GATEWAYIP
-	bool "Set a default 'gateway' value in the environment"
+	bool "Set a default 'gatewayip' value in the environment"
 	help
 	  Defines a default value for the IP address of the default router
 	  where packets to other networks are sent to.  (Environment variable
 	  "gatewayip")
 
 config GATEWAYIP
-	string "Value of the default 'gateway' value in the environment"
+	string "Value of the default 'gatewayip' value in the environment"
 	depends on USE_GATEWAYIP
 
 config USE_IPADDR
@@ -222,13 +220,15 @@ config USE_SERVERIP
 	bool "Set a default 'serverip' value in the environment"
 	help
 	  Defines a default value for the IP address of a TFTP server to
-	  contact when using the "tftboot" command.  (Environment variable
+	  contact when using the "tftpboot" command.  (Environment variable
 	  "serverip")
 
 config SERVERIP
 	string "Value of the default 'serverip' value in the environment"
 	depends on USE_SERVERIP
 
+if NET_LEGACY
+
 config PROT_TCP
 	bool "TCP stack"
 	help

---
base-commit: d778970a189b977c14f93961d7009f404d895b5b
base-tree: https://git.u-boot-project.org/u-boot/custodians/u-boot-net.git for-next
change-id: 20261123-submit-lwip-net-env-defaults-v1-330a6588a9ea

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

