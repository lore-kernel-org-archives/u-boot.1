Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28340C2D0CD
	for <u-boot@archiver.kernel.org>; Mon, 19 May 2025 19:48:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C27382A39;
	Mon, 19 May 2025 21:48:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=benjarobin.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=benjarobin.fr header.i=@benjarobin.fr header.b="BwFVSG4d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1523D82B4A; Mon, 19 May 2025 21:48:32 +0200 (CEST)
Received: from 1.mo573.mail-out.ovh.net (1.mo573.mail-out.ovh.net
 [178.33.111.213])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B138082952
 for <u-boot@lists.denx.de>; Mon, 19 May 2025 21:48:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=benjarobin.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dev@benjarobin.fr
Received: from director2.derp.mail-out.ovh.net
 (director2.derp.mail-out.ovh.net [79.137.60.36])
 by mo573.mail-out.ovh.net (Postfix) with ESMTPS id 4b1Ssm73FXz13qP;
 Mon, 19 May 2025 19:48:28 +0000 (UTC)
Received: from director2.derp.mail-out.ovh.net
 (director2.derp.mail-out.ovh.net. [127.0.0.1])
 by director2.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <dev@benjarobin.fr>; Mon, 19 May 2025 19:48:28 +0000 (UTC)
Received: from mta6.priv.ovhmail-u1.ea.mail.ovh.net (unknown [10.110.188.147])
 by director2.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4b1Ssm5cx6z1xw6; Mon, 19 May 2025 19:48:28 +0000 (UTC)
Received: from benjarobin.fr (unknown [10.1.6.5])
 by mta6.priv.ovhmail-u1.ea.mail.ovh.net (Postfix) with ESMTPSA id 35625D43EF0; 
 Mon, 19 May 2025 19:48:28 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-96R0019dd5078b-d4c7-4286-b2e5-0e913c6719f1,
 880E29993F4B42E3B0EE10B0FA7623E09C5A3C3C) smtp.auth=dev@benjarobin.fr
X-OVh-ClientIp: 86.194.82.154
From: Benjamin ROBIN <dev@benjarobin.fr>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, Benjamin ROBIN <dev@benjarobin.fr>
Subject: [PATCH] bootm: Fix bootz, bmi->images pointer was uninitialized
Date: Mon, 19 May 2025 21:48:00 +0200
Message-ID: <20250519194800.5550-1-dev@benjarobin.fr>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 10019383272961424297
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefvddvvdeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeeuvghnjhgrmhhinhcutffquefkpfcuoeguvghvsegsvghnjhgrrhhosghinhdrfhhrqeenucggtffrrghtthgvrhhnpeehhffgjeekhfeljeetueektdetudfhheefuefhkeejgfeihfejfeeuveeigeetudenucfkphepuddvjedrtddrtddruddpkeeirdduleegrdekvddrudehgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepuggvvhessggvnhhjrghrohgsihhnrdhfrhdpnhgspghrtghpthhtohepgedprhgtphhtthhopeguvghvsegsvghnjhgrrhhosghinhdrfhhrpdhrtghpthhtohepshhjghestghhrhhomhhiuhhmrdhorhhgpdhrtghpthhtohepthhrihhniheskhhonhhsuhhlkhhordgtohhmpdhrtghpthhtohepuhdqsghoohhtsehlihhsthhsrdguvghngidruggvpdfovfetjfhoshhtpehmohehjeefmgdpmhhouggvpehsmhhtphhouhht
DKIM-Signature: a=rsa-sha256; bh=beRToN7fYgPWuvDt6v/ME5aIrGOCubrN4zII5LtcMiE=; 
 c=relaxed/relaxed; d=benjarobin.fr; h=From;
 s=ovhmo1728415-selector1; t=1747684109; v=1;
 b=BwFVSG4doRAVlYDGXojPljtIfnrNBQJbBtSRLrwl1Cb6VrldIDdAoyurGmuhFOVWn4ENG6/O
 3aBA0qVnWrf58PPZtKdZ8BBZdT/W7H7XrmQXj6wOY60p8/RqpNB/7d/WsgapPFGx9pxhFt+iEpn
 1maovn7wEjCRVaVYPcRFp22WA8p3XPei71XQA/4V1/0qs7UUhIbuWBWIXyoS9UUsxNSyUSGs2Pv
 VXSerDdGxcsmO1AcgQPAaUbkETrytuf+pAcJgIIulU2ymcDwXJ4JvyO+QIfGGw/qWp22xjdBbfd
 f45ROzOWnE7CcKs1GR2aZteSFN4YwVkbjqkch/jfTPk/Q==
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
is stored in stack the generated error is kind of random, but most of
the time this will generate: "ramdisk - allocation error"

Signed-off-by: Benjamin ROBIN <dev@benjarobin.fr>
---
 boot/bootm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index f6aa32746b7e..f6fddc151809 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -1169,7 +1169,7 @@ void bootm_init(struct bootm_info *bmi)
 {
 	memset(bmi, '\0', sizeof(struct bootm_info));
 	bmi->boot_progress = true;
-	if (IS_ENABLED(CONFIG_CMD_BOOTM))
+	if (IS_ENABLED(CONFIG_CMD_BOOTM) || IS_ENABLED(CONFIG_CMD_BOOTZ))
 		bmi->images = &images;
 }
 
-- 
2.49.0

