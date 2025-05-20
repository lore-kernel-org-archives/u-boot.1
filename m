Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC395C54E71
	for <u-boot@archiver.kernel.org>; Tue, 20 May 2025 20:35:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E96182CB8;
	Tue, 20 May 2025 22:35:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=benjarobin.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=benjarobin.fr header.i=@benjarobin.fr header.b="S2T2B8ri";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95A8F82D09; Tue, 20 May 2025 22:35:31 +0200 (CEST)
Received: from 4.mo573.mail-out.ovh.net (4.mo573.mail-out.ovh.net
 [46.105.52.157])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9712682CB8
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 22:35:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=benjarobin.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dev@benjarobin.fr
Received: from director3.derp.mail-out.ovh.net
 (director3.derp.mail-out.ovh.net [152.228.215.222])
 by mo573.mail-out.ovh.net (Postfix) with ESMTPS id 4b25sY0gn1z12HD;
 Tue, 20 May 2025 20:35:29 +0000 (UTC)
Received: from director3.derp.mail-out.ovh.net
 (director3.derp.mail-out.ovh.net. [127.0.0.1])
 by director3.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <dev@benjarobin.fr>; Tue, 20 May 2025 20:35:28 +0000 (UTC)
Received: from mta3.priv.ovhmail-u1.ea.mail.ovh.net (unknown [10.109.139.140])
 by director3.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4b25sX6V8mz5xL9; Tue, 20 May 2025 20:35:28 +0000 (UTC)
Received: from benjarobin.fr (unknown [10.1.6.4])
 by mta3.priv.ovhmail-u1.ea.mail.ovh.net (Postfix) with ESMTPSA id 451A43A401F; 
 Tue, 20 May 2025 20:35:28 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-111S005b38caad1-975c-43dd-ab7e-8515644a02e8,
 EAD86587B2B6C3DD8ADE427FB1C91837DFE7FEC9) smtp.auth=dev@benjarobin.fr
X-OVh-ClientIp: 86.194.82.154
From: Benjamin ROBIN <dev@benjarobin.fr>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, Benjamin ROBIN <dev@benjarobin.fr>
Subject: [PATCH v2] bootm: Fix bmi->images pointer not initialized in some
 cases
Date: Tue, 20 May 2025 22:35:15 +0200
Message-ID: <20250520203515.25839-1-dev@benjarobin.fr>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 16685836623348120489
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdduudekucdltddurdegfedvrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeeuvghnjhgrmhhinhcutffquefkpfcuoeguvghvsegsvghnjhgrrhhosghinhdrfhhrqeenucggtffrrghtthgvrhhnpeehhffgjeekhfeljeetueektdetudfhheefuefhkeejgfeihfejfeeuveeigeetudenucfkphepuddvjedrtddrtddruddpkeeirdduleegrdekvddrudehgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepuggvvhessggvnhhjrghrohgsihhnrdhfrhdpnhgspghrtghpthhtohepgedprhgtphhtthhopeguvghvsegsvghnjhgrrhhosghinhdrfhhrpdhrtghpthhtohepshhjghestghhrhhomhhiuhhmrdhorhhgpdhrtghpthhtohepthhrihhniheskhhonhhsuhhlkhhordgtohhmpdhrtghpthhtohepuhdqsghoohhtsehlihhsthhsrdguvghngidruggvpdfovfetjfhoshhtpehmohehjeefmgdpmhhouggvpehsmhhtphhouhht
DKIM-Signature: a=rsa-sha256; bh=8qgOvSCWu2h0gb28gIcOXqL6PbBBW2NaXgY7gqiicss=; 
 c=relaxed/relaxed; d=benjarobin.fr; h=From;
 s=ovhmo1728415-selector1; t=1747773329; v=1;
 b=S2T2B8ri7aqpGEpSBSVSYZHiDE8TdDz4Le8SJdZPq/hKEW2aH3dHvyg97N4YmeAk58McYmLB
 NwJ75wTWwh9XaEE9StR7nwiznvhlwGcNzGbEGF3aMW0OIZwByXtyFxgJqfDdCdBbk+HOqNyycO+
 Iu9QbQ4HsgI6i+Vbr3FiJJfpryC5uS2EAS++elXk49ilGlqe4MMVRIJVlxsq/HOVWUPzqFjf/5y
 1TksZQoV/YRJ2r+/BaokOlMn0zLuwtXam35btQxq3ipXG6038fcNiYtk0scSP8x2SxKSF7VxEDn
 WUTS6RO9hFXo1rdhXb7Pg0da3QuFYqH4DXQ6Wv6WvMXuA==
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

When building with only bootz command, without bootm, images pointer
inside bootm_info structure is not initialized. And since this structure
is stored in stack, the generated error is kind of random, but most of
the time this will generate: "ramdisk - allocation error".

Also, after analysis, this problem could occur with the command booti,
if the command bootm is disabled.

Currently bootm_init() is called by: do_bootz(), do_bootm(), do_booti()
and by do_stm32prog(). And all of these commands execute bootm_run_states()
which access the images pointer stored into bootm_info structure.

So, to fix this issue, just do the assignment unconditionally.

Fixes: c2211ff65136 ("bootm: Add more fields to bootm_info")
Signed-off-by: Benjamin ROBIN <dev@benjarobin.fr>
---
 boot/bootm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index f6aa32746b7e..108ca7fb472e 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -1169,8 +1169,7 @@ void bootm_init(struct bootm_info *bmi)
 {
 	memset(bmi, '\0', sizeof(struct bootm_info));
 	bmi->boot_progress = true;
-	if (IS_ENABLED(CONFIG_CMD_BOOTM))
-		bmi->images = &images;
+	bmi->images = &images;
 }
 
 /**
-- 
2.49.0

