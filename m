Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5158CCD4F54
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 02:31:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83DFA8404D;
	Mon, 25 May 2026 04:30:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="X56z9nWU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58AE483FF5; Mon, 25 May 2026 02:32:07 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21AF38039B
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 02:32:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=colinmca242@gmail.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7e612d0693eso1811240a34.3
 for <u-boot@lists.denx.de>; Sun, 24 May 2026 17:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779669124; x=1780273924; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VcP/kXFEgijBI8ytYUMORCAhHYN/qvhyzvndP0NJVDY=;
 b=X56z9nWUBTgBliNm3mIaxAssdy72hiS3sdCy+Hebphrht1uTn0eQ3AFIa66fKL4D1M
 VHohA/GEynLqvbJmHhXCjOePpaa6QK6Bi9WrUX7wlN7wJivhlzVzw3bbqXWt4/n3qJxS
 GD/vKwKhY7PtD9ublTbFTQ7DoURqu1qEkA8ZYsAB92mQg0Z4Qx4ipRrLludjJZkxjuay
 NkghDbo7sdvMJ4QEn2woWHhEuHinrIfQS2bEiKs0k3tFRr9HbSY4xLm4jzoS/+XwIopI
 21QW+oWpDuEKBwd8J0x7ewzeg6kD7b9VodpGYLafOBO1i7Ad2BS6P8Iez8aKDXqoxPAC
 1g3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779669124; x=1780273924;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VcP/kXFEgijBI8ytYUMORCAhHYN/qvhyzvndP0NJVDY=;
 b=BN7MibFjsUoGoLc+bOz1z1xQ3G0O7UDcxMWfH8mCUFKcnpsMPwShM5vMKvnCwx5F1y
 5g3wmPyrnNl6CKwR1OblNOWf8X9CeGFfmhphaBgh4ulu8UbA6M3OvuDEq/wPhJNPJ+dJ
 5vNPnh5KGzDomySqCMLXI/SgrYMv61X+gg8O+eiTXIUWRdlNubBiz7x1iv11w9bCKC0V
 UXaZ4XNGha4MKngKg39n9BuDVFgzXXc5+K9r7ror3Jq+fW+0H1BdDhL2jKt6575VwGmE
 32gbKcJHHco6aX8q8SWyIPDpvOyxP+HEfuIy612FSoPBMHkvuZJhsG04W+ACBUCNaf9j
 4Uaw==
X-Gm-Message-State: AOJu0YyEgMyBlzP5uuZP36Alg2jUy/pSFri1kohT+B4+hSBZo85MTbhY
 80cnNYSTuMQItqqNo+0VZ8kHjaorWwMApGvP2qebfsj6HivCSj7/eWOqiqb5aQ==
X-Gm-Gg: Acq92OHJaLahyge4qUNlMcVeA9pHs+sPdXhGgm/78dwlE6ImyRUgQdoaTmAZV2A3TBN
 LGg09NbeITFO9zIlbfk8I3tpujUyZ7GXdpMjOQba/9N0GeSY9nkq1ukfWlXKzpUlU8JCwzJ9wmr
 YzRMfZ2ZneLMCwGM3jJSizrcuIoH4eq2EuhLlyYl3fbIUvZFEcb2PSrpO7hFjoe6v/1UNRvttuO
 MtqGmwGIEPI46sNTlVxDKQFlcuv0dmHugddnIng+gVb9hgBnCRS2wPWiAEC7MrLNwxfy+EmUuwx
 cXk1dg1SOTqLOG5A12j4N/a+ex/kc/wd7w+woCG65VDjSm1zlCjFmucZs6EhEZCbhMKENSGgfN6
 7O7dKSNKtQ2MTiqx4QiaHYPjk5xLjco29g45UkxUdns1KSkX7/+AWBO4xlurJT+hcluRr1skC/f
 a1z+qrgcE16+DpONoTWPsD+6v/Zhc/CqGKGQXReKKQJsfVx0GBoHHyE48=
X-Received: by 2002:a05:6830:349f:b0:7dc:d679:3eb1 with SMTP id
 46e09a7af769-7e5fef00377mr7566271a34.25.1779669123622; 
 Sun, 24 May 2026 17:32:03 -0700 (PDT)
Received: from monolith.tailfd8bbe.ts.net ([136.37.200.217])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e6065e7cddsm6625159a34.18.2026.05.24.17.32.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 May 2026 17:32:03 -0700 (PDT)
From: Colin Pinnell McAllister <colinmca242@gmail.com>
To: u-boot@lists.denx.de
Cc: Colin Pinnell McAllister <colinmca242@gmail.com>
Subject: [PATCH v2] android_ab: fix slot selection
Date: Mon, 25 May 2026 00:31:58 +0000
Message-Id: <20260525003158.11319-1-colinmca242@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260313201415.255744-1-colin.mcallister@garmin.com>
References: <20260313201415.255744-1-colin.mcallister@garmin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 25 May 2026 04:30:57 +0200
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

The boot selection rules state that a slot is bootable if it is not
corrupted and either has tries remaining or has already booted
successfully. However, slots that have tries_remaining == 0 and
successful_boot == 1 will be disregarded when picking the slot to
attempt.

Updates the selection logic so slots marked successful remain eligible
even when their tries counter is zero. Debug message now also includes
the successful_boot value.

Signed-off-by: Colin Pinnell McAllister <colinmca242@gmail.com>
---
Changes in v2:
* No changes, just sending the patch from a gmail address

 boot/android_ab.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/boot/android_ab.c b/boot/android_ab.c
index 13e82dbcb7f..f2b1110aa24 100644
--- a/boot/android_ab.c
+++ b/boot/android_ab.c
@@ -289,11 +289,14 @@ int ab_select_slot(struct blk_desc *dev_desc, struct disk_partition *part_info,
 	slot = -1;
 	for (i = 0; i < abc->nb_slot; ++i) {
 		if (abc->slot_info[i].verity_corrupted ||
-		    !abc->slot_info[i].tries_remaining) {
+		    (!abc->slot_info[i].tries_remaining &&
+		     !abc->slot_info[i].successful_boot)) {
 			log_debug("ANDROID: unbootable slot %d tries: %d, ",
 				  i, abc->slot_info[i].tries_remaining);
-			log_debug("corrupt: %d\n",
+			log_debug("corrupt: %d, ",
 				  abc->slot_info[i].verity_corrupted);
+			log_debug("successful: %d\n",
+				  abc->slot_info[i].successful_boot);
 			continue;
 		}
 		log_debug("ANDROID: bootable slot %d pri: %d, tries: %d, ",
-- 
2.34.1

