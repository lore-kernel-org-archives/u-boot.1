Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AC95E7717D
	for <u-boot@archiver.kernel.org>; Fri, 13 Dec 2024 10:24:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E687280104;
	Fri, 13 Dec 2024 11:23:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="r3jECoZg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83D7780283; Fri, 13 Dec 2024 11:23:44 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F5258010E
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 11:23:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mwalle@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id DA8B75C6B37;
 Fri, 13 Dec 2024 10:22:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6D91C4CED7;
 Fri, 13 Dec 2024 10:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1734085420;
 bh=GoktjOTJZk31I0H9uywDKF8dx3qKi0YwD3JzCHb4Hno=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=r3jECoZgGVyufpCWX6ZZpF5YhjWyCYcg1to+/qN8ichtnuK8+7Hl/bILl8U0XfrFG
 C9ALgaQ5zeawU3EkkS4NwBjpXRa5kzM4rcJhu9Mt3boVgoyWSAgOpCA0YB4Ivav3F6
 ZZdV1VZjjvVcz5eSEVim4OYBVJbOIEG/Jbj77ZKzCPTIMoXRIYAkYcDXqaiQlAisDB
 XUlG1DxDThq9HqeW2NMgZKbWmSlhGtDVjyrtCd/U7dwkdG+UhJlxpChENcyUNOdAow
 Ti/W5+0lbTQdi5FlGgPDnYlMjCnsv5ZNhUZICo80D2xYZ4RGrKA6BDvVtW1WQjlG9B
 Y4RO8rQzQArPA==
From: Michael Walle <mwalle@kernel.org>
To: Peng Fan <peng.fan@nxp.com>
Cc: u-boot@lists.denx.de, heiko.thiery@gmail.com, thomas.schaefer@kontron.com,
 Michael Walle <mwalle@kernel.org>
Subject: [PATCH 4/5] doc: board: sl28: fix table
Date: Fri, 13 Dec 2024 11:23:20 +0100
Message-Id: <20241213102321.2166920-5-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241213102321.2166920-1-mwalle@kernel.org>
References: <20241213102321.2166920-1-mwalle@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Convert the table to a correct reST table syntax.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 doc/board/kontron/sl28.rst | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/doc/board/kontron/sl28.rst b/doc/board/kontron/sl28.rst
index 2cb8ec62be4..5d47ce6c158 100644
--- a/doc/board/kontron/sl28.rst
+++ b/doc/board/kontron/sl28.rst
@@ -65,12 +65,14 @@ wdt command flags
 The `wdt start` as well as the `wdt expire` command take a flags argument.
 The supported bitmask is as follows.
 
-| Bit | Description                   |
-| --- | ----------------------------- |
-|   0 | Enable failsafe mode          |
-|   1 | Lock the control register     |
-|   2 | Disable board reset           |
-|   3 | Enable WDT_TIME_OUT# line     |
+===  ==============================
+Bit  Description
+===  ==============================
+  0  Enable failsafe mode
+  1  Lock the control register
+  2  Disable board reset
+  3  Enable WDT_TIME_OUT# line
+===  ==============================
 
 For example, you can use `wdt expire 1` to issue a reset and boot into the
 failsafe bootloader.
-- 
2.39.5

