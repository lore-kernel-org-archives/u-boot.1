Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27A31C5DF7D
	for <u-boot@archiver.kernel.org>; Fri, 21 Aug 2026 12:19:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 653EF60A69;
	Fri, 21 Aug 2026 12:19:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aYZYgNpLbdo3; Fri, 21 Aug 2026 12:19:18 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787314758;
	bh=OOGYSzS0Sx4fd/6rbjnCawFoPZTiUTxXMbMsVEUVZqo=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=caLIPCJ4o+Hhg102fX1MyCSSeDotBXnMo1ofacYcm5jqiu06xYqp6R8dEAbZooM1O
	 nE4gld/aIIC4cr1eWIQ+x4tU7OXM39WXYs5cKopjCNAIL4iN/BCt4TL7wEhBkFJow1
	 v4tkTHAoNsfjNVX/pogDl++DzMlHakC/jDnxo8lJ1YcEdDePfKtOokP/OsEa5+3HRQ
	 iDjQPOt9KLKIa8DcSIjVhbC5JCas9hCF8jfmBMMgTQkGyhYAPeiwAnhJdMbF/JIwgM
	 AotTZjlvHx0zHuR+Sj2D2Zol9LgwlSiyEtXm7SdfcjgxG45ZvmNmaLuNFF6CZrjhGG
	 WY866dBeUukjg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6EED660884;
	Fri, 21 Aug 2026 12:19:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id DA23229B
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 12:19:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CBDE9400DC
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 12:19:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AW6MVEyqyWDg for <u-boot@lists.u-boot-project.org>;
 Fri, 21 Aug 2026 12:19:16 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.161;
 helo=mout-p-103.mailbox.org; envelope-from=marek.vasut+renesas@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mailbox.org
 header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812
 header.b=LmFr2Z5+; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=T1zVr2J+
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 00B1540026
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 12:19:15 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4hRK9Y0nrdzKmKJ;
 Fri, 21 Aug 2026 14:19:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1787314753;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=OOGYSzS0Sx4fd/6rbjnCawFoPZTiUTxXMbMsVEUVZqo=;
 b=LmFr2Z5+fUaS1od0vVEZnHTyYKnGjpfEL++ZNcnIWqPtCleoAOzZsfuC2gZ6GKY1eKSdcZ
 BULfNRUhs6NrpC8F9M4KeT4s9G4Cu1qlfZdgVQQXTgFEKff8tX+f/vdAA9QJ1JBPhLz7fo
 MAuxHZZOgqRFBRvtwb9voXfMIhEWxZrVPa8Zo0w27nU04+wIOYF5I4UAWPKW4YeEGzhhgF
 njhx9jYAWbwlYIE5EY4VJDMVN5yu8SK9Mo6dJ9P5NCKanKk52rdN3/+uJu8m4B/VLzeru+
 sCQ5bLVP6r+lPEcA3WLHLnqyBbFhOK58YLaBv2+F25p55nSru/KuaiEg+hASNA==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=T1zVr2J+;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1787314751;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=OOGYSzS0Sx4fd/6rbjnCawFoPZTiUTxXMbMsVEUVZqo=;
 b=T1zVr2J+flvCqoFBoG15rlfuB5iR+YGArBrP0gAl+gybxqQsst/G3tVCXHzmQv5MgdZNez
 v3v0KMqeuIzizGZr8B+HCvwtgyfTwGIlj38lucJ9SL3OkfWQm3dpcHcNZ7TvkDP3TjCiEv
 tSGSE12eYMu0MiHft1FINwtCZpYqJXqNfq9B//yajfgIj+RoMaLqt9S3FZBvoBH9zFv0KJ
 rYfKOs4Hn+Th8+OeZFFROKbbuOre6cdTs8ADx1zX2lV4g2j1CBrEKBROX8qN3wz/Tyhm9P
 PrbQNZmmqLmAZGSzgch1C4KkLvm9IckNS0zo/0PL/abjwxkbtYxekayQSTcIzA==
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm64: dts: renesas: Drop bootph-all from PRR node on R-Car
 Gen5 R8A78000 X5H
Date: Fri, 21 Aug 2026 14:18:51 +0200
Message-ID: <20260821121908.212186-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 6hwq6w7n8b4r7k61uya9s39bhiixozq3
X-MBO-RS-ID: c181101799c2fcc59e0
X-Rspamd-Queue-Id: 4hRK9Y0nrdzKmKJ
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
Errors-To: u-boot-bounces@lists.u-boot-project.org

The PRR node is going to be folded into MFIS node in Linux 7.2.y DTs.
The PRR node is currently unused and does not require the bootph-all
DT property. Drop the property from the PRR node, and drop the entire
prr {} node phandle, thus unblocking Linux 7.2.y upstream DT update.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 arch/arm/dts/r8a78000-u-boot.dtsi | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/dts/r8a78000-u-boot.dtsi b/arch/arm/dts/r8a78000-u-boot.dtsi
index 67da58f6474..432a4252cdf 100644
--- a/arch/arm/dts/r8a78000-u-boot.dtsi
+++ b/arch/arm/dts/r8a78000-u-boot.dtsi
@@ -78,10 +78,6 @@
 	bootph-all;
 };
 
-&prr {
-	bootph-all;
-};
-
 &soc {
 	bootph-all;
 
-- 
2.53.0

