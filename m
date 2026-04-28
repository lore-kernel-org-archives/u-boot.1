Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB7F7FF885D
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 10:56:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36CBB84669;
	Tue, 28 Apr 2026 12:56:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=0leil.net header.i=@0leil.net header.b="DfcFevpt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4ED084682; Tue, 28 Apr 2026 12:56:16 +0200 (CEST)
Received: from smtp-8fae.mail.infomaniak.ch (smtp-8fae.mail.infomaniak.ch
 [IPv6:2001:1600:4:17::8fae])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBDD284664
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 12:56:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:4:17::246b])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4g4cmt3RDHzxyt;
 Tue, 28 Apr 2026 12:56:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1777373774;
 bh=YujJAej4GyCoyMQfXWcVUylRWg7xJmLbEoq4R1mAfTw=;
 h=From:Subject:Date:To:Cc:From;
 b=DfcFevpt/Hdk1WCGI/nEART71xF+LnUnlmBYcGAc8PK2sbPK+Joo7KswtZnl2Tgxu
 /zsYeV0jd8nTq0WXhTA9UQoB8Orxen83KyZnJKdW3aBG4YmrrhgC9rBgbbmOgMpcg6
 wLJwHb+UaoF505UaCzqZpP8uQXeXIBnG1jB0BLVrmZV0GV68BVFLDyil/+fSmaNp3+
 YRI1S5ybWyoPq/EzUQmThetE+df7WkMgMnk+tOxpdtMQxGHzfo1hPwMKniWQjIylA1
 5xahZfw77M3w7VMA2obufy/6FNWbJtFjcHGjU9duBXtwDRtT9npcxtkMVMSv0Y+akf
 0FDW5hkaERLTw==
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4g4cms0hrhzkGt; Tue, 28 Apr 2026 12:56:13 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Subject: [PATCH 0/2] cmd: ufetch: print Net feature when NET_LWIP=y,
 prettyfy if NET=n
Date: Tue, 28 Apr 2026 12:56:03 +0200
Message-Id: <20260428-ufetch-net-v1-0-5d58c7618239@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQ5AMBBA4avIrDWpUsRVxKJqyliU9Eck4u6K5
 bd47wKPjtBDl13g8CBPm00o8gz0ouyMjKZkEFzUvBItiwaDXpjFwIpRNVKWSnDdQAp2h4bOb9Y
 Pv30cV9ThPcB9P1M1vsFuAAAA
X-Change-ID: 20260428-ufetch-net-1ba7553a20c7
To: u-boot@lists.denx.de
Cc: Casey Connolly <casey.connolly@linaro.org>, 
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>
X-Mailer: b4 0.15-dev-47773
X-Infomaniak-Routing: alpha
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

Make sure the Net feature is printed when NET_LWIP is enabled, not only
when NET_LEGACY is.

Only print comma and following whitespace as separator if there was a
feature printed before feature to be printed.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Quentin Schulz (2):
      cmd: ufetch: show net feature when NET_LWIP is selected
      cmd: ufetch: only show comma separator if there was a previous feature

 cmd/ufetch.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)
---
base-commit: 4433253ecf2041f9362a763bb6cb79960921ac7e
change-id: 20260428-ufetch-net-1ba7553a20c7

Best regards,
--  
Quentin Schulz <quentin.schulz@cherry.de>

