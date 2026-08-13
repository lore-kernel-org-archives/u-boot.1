Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BD78C5CFCF
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 17:59:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D98F240C1A;
	Thu, 13 Aug 2026 17:59:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fxNXKpAQByUh; Thu, 13 Aug 2026 17:59:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 27B2640C16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786643962;
	bh=ufoNuBRlxgfW0Zs77mOaJuNbEPeGrGmzVIlxy/yP16E=;
	h=To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=weJvZyc5zz5LJrAN0tJyNlzFleI0nwjTOfhwGwVasHcitMafVzxGCFaNC3tmFRyQ9
	 nIckH/08l+vSkI+sq7xnrlGZgNSFI9HB1JzaG9Qh3IP9aN6/L2tZz1LknlfUpOTlTy
	 r/fTtwAZBmUh8nd9cbDHdGTgzAo5b+jMPByPSFg7rl6vPJAF2C/RpG5u2tWW3ZiWTP
	 5670HV5lHLTEZDbx8Ek5LI3U3oCRLJUY02NF8+OkkpoO7c7NyPhm8H9QViAYnUbIU9
	 kau2lEX3O2HS1OD816+cDO/I5I+1ODiRcSLzWG6yMBScDk+twWjkVpzBzw/dW7J6ZO
	 XyDhhG5/9ZXTg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 27B2640C16;
	Thu, 13 Aug 2026 17:59:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 894B9388
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 16:03:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6FD7E60AFD
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 16:03:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MqyKhZdIl2O1 for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 16:03:51 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 6A232608FA
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6A232608FA
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6A232608FA
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 16:03:51 +0000 (UTC)
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B44C63F135
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 16:03:49 +0000 (UTC)
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-7e9dc0f5900so2012251a34.0
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 09:03:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786637028; x=1787241828;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ufoNuBRlxgfW0Zs77mOaJuNbEPeGrGmzVIlxy/yP16E=;
 b=arRkK3W0mCxpsbTW9c0Eb6/jX3IkcewE4TNSfEKHi6f33yEx6VA9zEb/euXEmTSynG
 zBBm2hQdEXDXPsrXovAY5Z7VEFUjpN0z0gg69dcgE2JDWKvwUPHcWonDKQW3JQXDgn2U
 of9AyqiOo59saeHPyP05stnS29yzVpyZWPRgvRqZEwTdRlnSdl5iVeymID9j9YrCPKjY
 IKdnnxyIysmLRW6qRqHvoNzVX7gJkGxQl9F2sYoC8hRG1ADXFxM6UXC0aUs7uaPYoEcB
 dZMgajr6rJEjUu2QZujFKG/SX+UvwbRksq+sLenqHOdkBswRncNgmTrETBRgKCQ8AcFJ
 5kPg==
X-Gm-Message-State: AOJu0YztmvTV0zop49dXYcYYdO/2OdSITM0Ib3Wns5c/RMFLRwO9PL/j
 6z+j2tCfouX3JBLpMUPe7fANa77nbK6qpgsuDdbAsaTJ3FNz//KrHGAapOfIlQpVf4lEgDjQFpf
 Li0UwaADNKDF68fqPrJlUNstXsteA7woXtsu4nXEsGDB5K6l4udZw5nd6co1G25S2TTpBYQFtTT
 EGKl76kXrxD8yfkJ6bRw==
X-Gm-Gg: AR+sD11JiZtVY5/YrNAmVJWJxbD8xl8mGuYAWj+Fd2DvnCsE9Htv3Pqsm03+GNZa68p
 Zb1V4FAmzlZY9j+EkSCo9noJQuC67zGRY7oB0PU1a+/jHMDakMUK8DQ13decyXKXU5LKY1prWUG
 tRlGIGKCRTAhhpYkUgNfqoowSaA9NyPxCQ2yTDZMm+JwkeBar7+yBwWOiTJ4oEjtItieZS4yWiB
 C9eEGLG4qY/JOBpaUQPJR+ZnBTZtGbgJUWelxag6XDrlqf23IVXi0hsKSducZOUpowC9+mrMW4w
 EI7CGHiyMgdWYGhgGJFWPaNriGyZhjX3Hza0Vbo48wv88U07fN9ZtnQgneJ1TZTGoMDCmacifzB
 NCuEzCP0LEt6jUAv5QOr+7FrarUH9dhsTdnG//Pc39tFFRuQyB8M=
X-Received: by 2002:a17:90b:448f:b0:38e:4e61:c9e with SMTP id
 98e67ed59e1d1-3931f9af210mr2938100a91.21.1786636605240; 
 Thu, 13 Aug 2026 08:56:45 -0700 (PDT)
X-Received: by 2002:a17:90b:448f:b0:38e:4e61:c9e with SMTP id
 98e67ed59e1d1-3931f9af210mr2938081a91.21.1786636604683; 
 Thu, 13 Aug 2026 08:56:44 -0700 (PDT)
Received: from noble-uboot.lxd (124-218-37-86.cm.dynamic.apol.com.tw.
 [124.218.37.86]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3931f44de1esm3603538a91.13.2026.08.13.08.56.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 08:56:44 -0700 (PDT)
To: u-boot@lists.u-boot-project.org
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Martin Schwan <m.schwan@phytec.de>, Francois Berder <fberder@outlook.fr>,
 Denis Mukhin <dmukhin@ford.com>, Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v1 3/7] bootstd: rauc: Free string lists on error paths
Date: Thu, 13 Aug 2026 15:56:13 +0000
Message-ID: <20260813155617.184928-4-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260813155617.184928-1-aristo.chen@canonical.com>
References: <20260813155617.184928-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 13 Aug 2026 17:59:17 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=canonical.com; s=20251003; t=1786637029;
 bh=ufoNuBRlxgfW0Zs77mOaJuNbEPeGrGmzVIlxy/yP16E=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=AlAcmXQ/3v31khc6KVrt2WSGGKKU1S3HCXmpBPn92toO3chUnyXuQHwB9L453k4ZW
 DcGUglkAHZqRkfkGkT1C5pywPubPtaCr+h00gYzi4Fra9MqxQHg/bJ6qKtsAe8sxri
 IcdiXd0mJk8KGvuE8b15xdH9edmyGckZINdqBNauZV4OW6hZzy7ROaexyVLnWPliNl
 c2maOQEMy1E9JLH61Sp5w9EMVjaYymC7qeVRg0jymwQpb5CpSFAoqqCImxY+p+IYbx
 rvSRZtxk3GZdBrRb2lDpxaGT3wMvB/mzE+Ws+90uNkSH3wFkipAx0tH/uKgaE/KQ+j
 iE7EHX5sXXT1KK0ekKDXCXMBalku7XEHkGrIQ1sZtPxkOtk3A4wLSTVf8jVWYy6yLC
 YqZJ6UUG0H8jJu9YQq2+EIwZjLl/8NlvZSxMNSFcYwrvm2VkSsPeMkKJzvSlJFU4yy
 2zEbV8Ps9rWh1qjHtUTDLwzBsN/f6BMJG6onMeor9L4SU69go/QakspwsT/oZKeJD6
 8cXdfYNGQKihkGb0ZM2ACKpfGvSLR5z6Bfs0ip0NGit80m5Ge4tG6vZpmizE+Ij60Q
 Rzx9y78O/Hvmgkd5G6ezKqm9j9G0ZamsWrEmAluI6uZgrfcx3fE/Yp7EuY8+d4HjjW
 xTwSpAY57vO10rmu2BIvCu1M=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=canonical.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=AlAcmXQ/
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
From: Aristo Chen via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Aristo Chen <aristo.chen@canonical.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

str_to_list() allocates a copy of the input string plus a pointer
array, which must be released with str_free_list(). Several error
paths return early without doing so and leak both allocations:

- distro_rauc_scan_parts() when BOOT_ORDER names an unknown slot
- distro_rauc_read_bootflow() and find_active_slot() when reading or
  writing a BOOT_*_LEFT variable fails

The scan_parts leak is the most visible one: a stray BOOT_ORDER entry
leaks the list on every scan attempt, and scans can be retried
indefinitely from the U-Boot prompt.

Free the list before each early return.

Fixes: 7e5c2c782fb9 ("bootstd: Add implementation for bootmeth rauc")
Fixes: f271b0627001 ("bootstd: rauc: Only scan all partitions instead of boot files")
Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 boot/bootmeth_rauc.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/boot/bootmeth_rauc.c b/boot/bootmeth_rauc.c
index 3e76eabe2fb..12ab9fc5bbd 100644
--- a/boot/bootmeth_rauc.c
+++ b/boot/bootmeth_rauc.c
@@ -117,8 +117,10 @@ static int distro_rauc_scan_parts(struct bootflow *bflow)
 		const struct distro_rauc_slot *slot;
 
 		slot = get_slot(priv, boot_order_list[i]);
-		if (!slot)
+		if (!slot) {
+			str_free_list(boot_order_list);
 			return log_msg_ret("slot", -EINVAL);
+		}
 		if (desc) {
 			ret = fs_set_blk_dev_with_part(desc, slot->boot_part);
 			if (ret)
@@ -167,8 +169,10 @@ static int distro_rauc_read_bootflow(struct udevice *dev, struct bootflow *bflow
 		if (!env_get(boot_left)) {
 			log_debug("%s did not exist yet, setting default value\n",
 				  boot_left);
-			if (env_set_ulong(boot_left, CONFIG_BOOTMETH_RAUC_DEFAULT_TRIES))
+			if (env_set_ulong(boot_left, CONFIG_BOOTMETH_RAUC_DEFAULT_TRIES)) {
+				str_free_list(default_boot_order_list);
 				return log_msg_ret("env", -EPERM);
+			}
 		}
 	}
 	str_free_list(default_boot_order_list);
@@ -324,13 +328,17 @@ static int find_active_slot(char **slot_name, ulong *slot_tries)
 	for (i = 0; boot_order_list[i] && !slot_found; i++) {
 		sprintf(boot_left, "BOOT_%s_LEFT", boot_order_list[i]);
 		tries = env_get_ulong(boot_left, 10, ULONG_MAX);
-		if (tries == ULONG_MAX)
+		if (tries == ULONG_MAX) {
+			str_free_list(boot_order_list);
 			return log_msg_ret("env", -ENOENT);
+		}
 
 		if (tries) {
 			ret = env_set_ulong(boot_left, tries - 1);
-			if (ret)
+			if (ret) {
+				str_free_list(boot_order_list);
 				return log_msg_ret("env", ret);
+			}
 			*slot_name = strdup(boot_order_list[i]);
 			*slot_tries = tries;
 			slot_found = true;
@@ -346,8 +354,10 @@ static int find_active_slot(char **slot_name, ulong *slot_tries)
 			for (i = 0; boot_order_list[i]; i++) {
 				sprintf(boot_left, "BOOT_%s_LEFT", boot_order_list[i]);
 				ret = env_set_ulong(boot_left, CONFIG_BOOTMETH_RAUC_DEFAULT_TRIES);
-				if (ret)
+				if (ret) {
+					str_free_list(boot_order_list);
 					return log_msg_ret("env", ret);
+				}
 			}
 			str_free_list(boot_order_list);
 			ret = env_save();
-- 
2.43.0

