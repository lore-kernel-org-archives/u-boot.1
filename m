Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3059FC83F12
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 19:12:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A63186459;
	Mon, 28 Aug 2023 21:12:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="t+VLCP//";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE6A986456; Mon, 28 Aug 2023 21:12:51 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 534898647D
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 21:12:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-062-143-244-162.um16.pools.vodafone-ip.de
 [62.143.244.162])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id AD2993F6C3; 
 Mon, 28 Aug 2023 19:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1693249968;
 bh=08dpzTVGrpuZRnb29pY80h7d3XTxmxlp5mdtKcAfn2w=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=t+VLCP//V42m9/jkTVtYCXcatSt3E7KLxHPM35mbFjk+scLxw10LFprknWLxveqlc
 iJNjiEbBPYcaQ30OvQN/D44HhXO/H0qZc+hrQ6vtx/2Pi3X90SzicJIvZYvlwKzNBb
 O3Nw5pbxCXa/EJZP3lhPT4ZzOkYIIVFoWvFr+nqjH7NtvO793eNDUUGcJ7oj0wfD7U
 ASdca0VnlMNDld4Ot6NJpGWrSaknESMG7ViKJK/hlTtUYvz8PQ5wte5b1SqM5fjAGr
 AhnEQCp0IUiR+Rt4+NewJ5lfTj+NxZPP2hu941wEfR1RzXuQzNwpUm5lKXCFWNyVGp
 C+d6Gxcyz8Gcg==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 0/2] doc: event: document all events
Date: Mon, 28 Aug 2023 21:13:31 +0200
Message-Id: <20230828191333.77249-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
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

Document all events and add event.h to the HTML documentation.

Heinrich Schuchardt (2):
  dm: event: document all events
  doc: add events.h to documentation

 doc/api/event.rst |  9 +++++
 doc/api/index.rst |  1 +
 include/event.h   | 97 ++++++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 101 insertions(+), 6 deletions(-)
 create mode 100644 doc/api/event.rst

-- 
2.40.1

