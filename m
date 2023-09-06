Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11479EE14D0
	for <u-boot@archiver.kernel.org>; Wed,  6 Sep 2023 21:33:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 883C386A44;
	Wed,  6 Sep 2023 23:30:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="MCYHiFFy";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="aHMVYtT6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18B2386A28; Wed,  6 Sep 2023 23:30:55 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2AA9869B1
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 23:30:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4RgwXW5Kf4z9sn0;
 Wed,  6 Sep 2023 23:30:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694035851;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y8Ghy+Vbs9B15efChrZAq4lXLhaUNQviJf2EeMgzpYA=;
 b=MCYHiFFyxGV7NMnQk9S26qFhSnFG95YMe6x91QkT4FqkjR6/NqHxAZwcmZiqT6XzakyTe3
 wzgIBy4YfjYCHknVUccWyiQS2MDGEtAjC+eHIREujpjblP4WdPqCJ77Ue0vsntijm2hY5s
 cbou2QGIH7KFVO8wOhpMaqAQp/6AYs3xVSRL2+LchGFdDF3HP1BOjpj6SqpAn6NINbZ0bP
 N20fU110CI6LvThDSmb8uqemDZG3guYhFHqvicM7v/5Q+9FXl+8XtcWLb8Lm5EeUCNpJFg
 IwJ/8cXvYwNGT/fiv8hs5gpRLWx2z2HnxZNPSnAae1J0vLa/zs6icypIoLtCiA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694035849;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y8Ghy+Vbs9B15efChrZAq4lXLhaUNQviJf2EeMgzpYA=;
 b=aHMVYtT6fksja+Ovfrx8r1X5Ol49sR/mE/fNXRPmU07t60GuWbShiv3LhZBEJRM2ozSXYd
 6cCSJ+ZvkTh43PheuE04vYOxb8/OKb0wDqRxtjFYQPLLJsaNmdd/kppHqlQVwUH/bQ9CEA
 7oTeJzfRbt1NgPfT+clnp/l51vrOxhVWqMpruUFC/JvDX8zbKwOfiKUgAaV2VV1xMrtyoC
 YhWDh1ASjNGxN+m49AnG1EaD7SV4DFjaGnCJDTSR2vLMLivo92SJvJbPYmwVSW2L/+/I6o
 yQq/s7JdUb31TgC0bTywxaQfMXG5gVsiPqy6goy1R1oYrOMSfE1LUJcJ5VTXlQ==
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 18/35] initcall: Remove unused NEEDS_MANUAL_RELOC code bits
Date: Wed,  6 Sep 2023 23:29:58 +0200
Message-Id: <20230906213015.203437-19-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230906213015.203437-1-marek.vasut+renesas@mailbox.org>
References: <20230906213015.203437-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 1b6adaca913140a7621
X-MBO-RS-META: j8wife86q736idqrxh9bteznth3uayaa
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

The last user of the NEEDS_MANUAL_RELOC has been removed in commit
26af162ac8f8 ("arch: m68k: Implement relocation")
Remove now unused NEEDS_MANUAL_RELOC code.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 include/initcall.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/include/initcall.h b/include/initcall.h
index 208effd8d13..62d3bb67f08 100644
--- a/include/initcall.h
+++ b/include/initcall.h
@@ -35,11 +35,4 @@ typedef int (*init_fnc_t)(void);
  */
 int initcall_run_list(const init_fnc_t init_sequence[]);
 
-/**
- * initcall_manual_reloc() - Do manual relocation on an initcall sequence
- *
- * @init_sequence: NULL-terminated init sequence to relocate
- */
-void initcall_manual_reloc(init_fnc_t init_sequence[]);
-
 #endif
-- 
2.40.1

