Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FD4606A31D
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 16:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=qw0WyfKb;
	dkim=pass (2048-bit key, unprotected) header.d=fris.de header.i=@fris.de header.a=rsa-sha256 header.s=mail header.b=VF1Jd+Zj
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 212D5605C9;
	Thu, 29 Oct 2026 16:23:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gBgrL69pj9if; Thu, 29 Oct 2026 16:23:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 59F99606BB
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793291018;
	b=UMN3QPXRPS8+dZAsa/zcuLjoaDJJhDw4J4fPGrWmPK3KOxsLPQ6/pEIAFRuXaLlkXEa6
	 JBL40Sj6ff9wPr9XII2wIn3Jyw1rrPri6Mjrw+N7qXo52exVH4xPPOsEFjC7pOop+mJ+b
	 PUk8a1+2/MeoCwHmnuTVqVPhsNEz7c5NmEit38tR5vOX33PUiYcNOeSrwYvtykqcTuB7A
	 XNXyS375c+jzSFlPTyMtaFdO+z5HI7oH75YqjWp4iuAEIQVPYTWZbxrRcROi35cyNNz5A
	 X3jZKBXndrNc1Z/t0BpUi8sL0cQAYGnvbdG6EZqTf2E1anGziRyKMYdy30TlS/kufyw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793291018;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:From:
	 DKIM-Signature:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Developer-Signature:X-Developer-Key:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=tYJ2Mtsu6eGFaplHE/D60Qr7vKJHK9p4Ht0erSkvo2c=;
	b=K9CBBeha5nCVJdNKmrmWpgA6JleJ41VW+x1TGdW0xrlPAYYhnIOQW3RS6TYDqvpqwwPh
	 YRnkxBkCipjzbFFPORdVVcz0VsMsSSzMEhyCKxoAi3Mi0gCudJBIy9qfaxPYurdwEhTgM
	 73YP0ghV4vLK++GYhjIRRjGjb5D9kZ2dpoLARu4CZYqP2tWOcPIg3j2dC2F26XCZ4SKjj
	 ipRMYfkmVoQw5jMA2QBUqOme7SYlA7ruJUnb8ZylNsiJ4pvLCp+YPes6MZ6d84CUjEEFS
	 ebvVMclofcpCzfGoUWaJMz6mE+z4TbA5xwvOTpT724dypGk9dtngI6ghFPHr3/FKSWg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793291018;
	bh=tYJ2Mtsu6eGFaplHE/D60Qr7vKJHK9p4Ht0erSkvo2c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qw0WyfKbdgAbb+XpV1nsbq8fNOX94C1Uw1Pdhiq6U8THeDOEzcRKQg9+MXqFvtoat
	 0cqtPNDb2jDclPEy/jrbxvwldZfv3sRSbVCGfz58rLibHmJvKz96dixzLu6Ef+W7bL
	 lBi/NkNLaVyibsCUJIImzfAh13LBp0EMhQRSPD04JrRUQ9OlS4uKcbqT6m1OCVzIam
	 75o99/YtSGOydatZ8MteInyhDCex1Wj3JxDEn9H6Dxbbu4vWGVZMp8qp7Ug9dhB2fJ
	 ciP1UCMcFFRrTIToIvbkIpR/aB2rypqUTbgeR81grzBIMPLIoxSkm0DJfoHP54f3P1
	 6+fHleN4LayvQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 59F99606BB;
	Thu, 29 Oct 2026 16:23:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6BB5DE89
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 16:23:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 51E9A40243
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 16:23:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YTgckh-_yTUU for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 16:23:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 817F940012
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=116.203.77.234
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793291009;
 b=pNu+aWEd0A3BrgtTlfaShiwocwYJAjxv0uRU60m/re1e+5qFgRVk/k99gp8KltOQOIT4
 aPz6Q7RuxadIKvDIb367vBBjgqlfcoib7myQh6eNmD0ilgrGKAUTK4AzhlGOkD7H3bAM4
 y8jZ8PEazgL6FuWm3pNbKdjv5KhrlQSwMmswzZ3ipJknGAGDl6ndhXAJ7xyE3OInl/hYi
 uwsmNzdcOjRBwK0UHKE2xx9MwLKsjaTW8nChGpEjp4jSP4qpew4g2Q1lbQArt0v3QiSQ7
 ZkUO3c9rErQ2jYfkdk1YDZTuHMgfagi8ziTHkV9pWtCrcqcDQ29YSCR48Z6CvVEonkQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793291009;
 h=Received-SPF:From:DKIM-Signature:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Developer-Signature:X-Developer-Key;
 bh=tYJ2Mtsu6eGFaplHE/D60Qr7vKJHK9p4Ht0erSkvo2c=;
 b=NVIcY+Ng0Rn8GbIKJLC4vIU1l25sJsGXAOaJeDOOeMXuOpk8IuywN3srANSKgWB1t8TD
 T4AAoKC/I7iObAZQ7RwyK5NKgQK+UvkMXBygZg7ltO3dzWo8r5lnAiM7X/lMq4LuLl5+f
 gmDNpfaXId/62twMs/UTGCm8v/VauHR3LPyLseFw9XEt4L+cRJA2IfXUHrKGl177/q1Fb
 2oj3HnX6pox+imk2XkJCAlEzI6+Tr1mAM9Sp+dci+Pj8nHd3I3mQilsTI4ymRndxK/H9P
 9z6ewV33waafBijalLoQMLqwj4M9hYQ7ZBTN3xyjR8T63fIwD7p8XOy7rE9aJJYIZ5Q==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=fris.de;
 dkim=pass header.d=fris.de header.i=@fris.de header.a=rsa-sha256 header.s=mail
 header.b=VF1Jd+Zj; 
 arc=none smtp.remote-ip=116.203.77.234
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.203.77.234;
 helo=mail.fris.de; envelope-from=frieder@fris.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=fris.de header.i=@fris.de header.a=rsa-sha256
 header.s=mail header.b=VF1Jd+Zj
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 817F940012
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 16:23:27 +0000 (UTC)
From: Frieder Schrempf <frieder@fris.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=mail;
 t=1793291004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tYJ2Mtsu6eGFaplHE/D60Qr7vKJHK9p4Ht0erSkvo2c=;
 b=VF1Jd+ZjbEHL/DZ9AaKY15DgcGUEtpuQGfgei+0EG4igRlLBYpf1W9aHjtuMG3AqTh+k2t
 0FDge6qNkT9kEWMtFBRteY7QZC/8jsIci3M3tMaIYv1yjKPNznAX/ivXRkVic5RlHGCw6l
 CP/bjDvi717IJYcFr+OiR5jrUCrsGf5EAnPxI0R33kW2dWG2MJndtZpkcCshKAU70poVIQ
 vzV9AOuvyDwo8VSxnW4/+OiPgiQtbnmVpTN6xvCtK7sQydLDexc0+LlmiKzVBJgfadirAB
 yTIrLPM9O/FW5DjMrP15klOXkZfx76a64g+UVmW7uZ3Gc9X9t/adz68GGWbKkA==
Date: Thu, 29 Oct 2026 17:23:08 +0100
Subject: [PATCH 02/10] bootstd: rauc: Fix leak of the active slot name
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-main-v1-2-b5a878627107@kontron.de>
References: <20261029-main-v1-0-b5a878627107@kontron.de>
In-Reply-To: <20261029-main-v1-0-b5a878627107@kontron.de>
To: Martin Schwan <m.schwan@phytec.de>, u-boot@lists.u-boot-project.org
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Alexey Charkov <alchark@flipper.net>, Daniel Golle <daniel@makrotopia.org>, 
 Johan Jonker <jbx6244@gmail.com>, Francesco Valla <francesco@valla.it>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Michal Simek <michal.simek@amd.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2323;
 i=frieder.schrempf@kontron.de; h=from:subject:message-id;
 bh=pmfAN5+H/XiHWKNmxi7r7GzPWZOztkbjjBdL2q4esD8=;
 b=owGbwMvMwCWWWSatKlDTJMZ4Wi2JIetx0a8XjCfX2Xjf3Tg1RPh91q1JBcdfej0zmy+YYDHJ8
 detjiM7O0pZGMS4GGTFFFmk+C1e25rF+sgfq46CmcPKBDKEgYtTACbSf4Xhr+jCX+aXbh51PcZ6
 O1k/1m3Kww9HytVeytRvOXQ1v/Cu5j1Ghss+mk8e8n3+3GUyR6qre9Z9xUzzbY3qSUsPabBfURH
 tYwMA
X-Developer-Key: i=frieder.schrempf@kontron.de; a=openpgp;
 fpr=1A0F38EB3D365D4C1FC67B5A69761B25107C8216
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Frieder Schrempf <frieder.schrempf@kontron.de>

find_active_slot() returns a strdup() copy of the slot name, which
distro_rauc_boot() never frees, so every boot attempt leaks it. The
strdup() result is not checked either and if it fails, get_slot() passes
NULL to strcmp().

Check the strdup() result and free the copy right after looking up
the slot. Use the name of the slot from then on.

Fixes: 7e5c2c782fb9 ("bootstd: Add implementation for bootmeth rauc")
Assisted-by: LLM
Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 boot/bootmeth_rauc.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/boot/bootmeth_rauc.c b/boot/bootmeth_rauc.c
index 4a3f05103eb..3442b9e99d4 100644
--- a/boot/bootmeth_rauc.c
+++ b/boot/bootmeth_rauc.c
@@ -347,6 +347,10 @@ static int find_active_slot(char **slot_name, ulong *slot_tries)
 				return log_msg_ret("env", ret);
 			}
 			*slot_name = strdup(boot_order_list[i]);
+			if (!*slot_name) {
+				str_free_list(boot_order_list);
+				return log_msg_ret("buf", -ENOMEM);
+			}
 			*slot_tries = tries;
 			slot_found = true;
 		}
@@ -415,16 +419,17 @@ static int distro_rauc_boot(struct udevice *dev, struct bootflow *bflow)
 	if (ret)
 		return log_msg_ret("env", ret);
 
-	/* Kernel command line arguments */
-	sprintf(raucargs, "rauc.slot=%s", active_slot);
-	ret = env_set("raucargs", raucargs);
-	if (ret)
-		return log_msg_ret("env", ret);
-
 	/* Active slot info */
 	slot = get_slot(priv, active_slot);
+	free(active_slot);
 	if (!slot)
 		return log_msg_ret("env", -ENOENT);
+
+	/* Kernel command line arguments */
+	sprintf(raucargs, "rauc.slot=%s", slot->name);
+	ret = env_set("raucargs", raucargs);
+	if (ret)
+		return log_msg_ret("env", ret);
 	ret = env_set_hex("distro_bootpart", slot->boot_part);
 	if (ret)
 		return log_msg_ret("env", ret);
@@ -441,7 +446,7 @@ static int distro_rauc_boot(struct udevice *dev, struct bootflow *bflow)
 		return log_msg_ret("load", ret);
 
 	log_info("INFO: Booting slot %s, %lu of %d tries left\n",
-		 active_slot, active_slot_tries, CONFIG_BOOTMETH_RAUC_DEFAULT_TRIES);
+		 slot->name, active_slot_tries, CONFIG_BOOTMETH_RAUC_DEFAULT_TRIES);
 
 	log_debug("devtype: %s\n", env_get("devtype"));
 	log_debug("devnum: %s\n", env_get("devnum"));

-- 
2.56.0

