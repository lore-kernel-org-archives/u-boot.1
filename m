Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A294CCD194
	for <u-boot@archiver.kernel.org>; Wed, 15 Oct 2025 15:44:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5EE85807B1;
	Wed, 15 Oct 2025 17:44:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="X4dHsCex";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80F418357F; Wed, 15 Oct 2025 17:44:45 +0200 (CEST)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BEDD800D7
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 17:44:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-57bb7ee3142so7366591e87.0
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 08:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1760543082; x=1761147882; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bdR3Eybqybvkoe5gfdilTrKwlfsLGCbeXJMho5sQuJk=;
 b=X4dHsCexPn45cu/BKVhSsOF364U+P1osAPMktuV3+Surs0r4huoDN5iZVATCO1YPdB
 XErV6Acl96rjLE6240yfKJnVNYMYzQihXz9DMmxddcp10Bxpig/x8gWN6ik0eoRR2FhD
 GWrCQLtfaMXBywfcu01GRmht3JBJnhAmkPrKY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760543082; x=1761147882;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bdR3Eybqybvkoe5gfdilTrKwlfsLGCbeXJMho5sQuJk=;
 b=ALqSTlaouGZKi1emJkaRnRY3I/0Lxk/1rPSSrsseymb7zEoZ7kl02h7QeYToLF8HVE
 rD73i3HtgdJL51HAJHbyT2n2bxxDTq+3w5YZuLwa8JGo9ABvYJgQddU7uC/ysXRwk4q/
 HUk1TsZ8/4atBeg5x9IYBGsLIPiPoKDOqPgggJjKaGNRdVdNIYGTxZ2PvaDOQp2DfjeT
 EYrgLxxPMLMHQwp/XdtIYBDoe+LWJHm+rdq5DnaGZ/72q7eytfsmFl8qv+hG7jAOjVRq
 G9bE1PbrKeZsbHwh2LLwbazOP4OlBGpomjZG6/NMcDvKi+1rzlSFYrltK/N3pC+4r7ey
 JzjQ==
X-Gm-Message-State: AOJu0YycPnfiMgwffek0VKk0E9DEte/RjOP6nudmPLR9eYDA5Gkthg8+
 3uL84GcQ0QMjJGofuAxvP9/VxjKjv19tQBxB/fh+bYQBYmEjfW85hx0kinyt7LgsETJWd+84DQe
 kItYmbbsr038=
X-Gm-Gg: ASbGncsNBV952/UFvcWvzoUcYTWTaV1VTkJzwO1QBOrgQhw+qdZTB9GPAG+4fZ1W7zq
 ve98U0N8IHseRANuoD2ESjTDphLRy5Z5XfSnOOiTJyugPdptYcaGM9dhoI1y/C7eaWqpiL2Oln+
 D23nL3KJ9ZNcD6H3AqORWv8PbXVGrpEGo9ZhmJg9EvYLk9mGCjMgxAwtg4aizwgzM3SFr6GdLeO
 cfWPcZiVzEGaFFb+pTSJ3sZ2N4xIHU89Hrx7+hGnoUDkQ09qVjXInkcdbb9GjSIqj3RHdB1wTlf
 fj3W5PUbhhz1MDxJbKlR0TgrNfshu/tasR6YkIeJGQo0FdihFfsdD/locHu6I4or+n2TrTqjT5A
 eBgi5YR1GPO4bAwb8Az8myKmO+lTwksV5FwDICQX4V/1J54gv
X-Google-Smtp-Source: AGHT+IG53bZ5ERcM4yVtyKN5Ho2DX6aWpupClYtKvaYbOm70mCKXBAm5usuL7ijZr42Ex9QB/UID7Q==
X-Received: by 2002:a05:6512:63d9:b0:590:9a11:9c23 with SMTP id
 2adb3069b0e04-5909a119ec4mr3488335e87.55.1760543081688; 
 Wed, 15 Oct 2025 08:44:41 -0700 (PDT)
Received: from chromium.org ([91.209.212.108])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-59088563cbesm6363777e87.64.2025.10.15.08.44.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 08:44:40 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Moritz Fischer <moritzf@google.com>,
 Sam Protsenko <semen.protsenko@linaro.org>
Subject: [PATCH v4 01/11] boot: Try all bootmeths on the final partition
Date: Wed, 15 Oct 2025 16:44:04 +0100
Message-ID: <20251015154423.908468-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251015154423.908468-1-sjg@chromium.org>
References: <20251015154423.908468-1-sjg@chromium.org>
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

At present, normally when one bootmeth fails on a partition, we move on
and try the next bootmeth. However, this was not the case for the final
partition due to a bug. Rework the logic so that all partitions are
treated the same.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v4:
- Reword the commit message as Tom suggested

 boot/bootflow.c | 34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/boot/bootflow.c b/boot/bootflow.c
index 7ed076c898f..deb5f42ba65 100644
--- a/boot/bootflow.c
+++ b/boot/bootflow.c
@@ -221,27 +221,25 @@ static int iter_incr(struct bootflow_iter *iter)
 	if (iter->err == BF_NO_MORE_DEVICES)
 		return BF_NO_MORE_DEVICES;
 
-	if (iter->err != BF_NO_MORE_PARTS) {
-		/* Get the next boothmethod */
-		if (++iter->cur_method < iter->num_methods) {
-			iter->method = iter->method_order[iter->cur_method];
-			return 0;
-		}
+	/* Get the next boothmethod */
+	if (++iter->cur_method < iter->num_methods) {
+		iter->method = iter->method_order[iter->cur_method];
+		return 0;
+	}
+
+	/*
+	 * If we have finished scanning the global bootmeths, start the
+	 * normal bootdev scan
+	 */
+	if (IS_ENABLED(CONFIG_BOOTMETH_GLOBAL) && global) {
+		iter->num_methods = iter->first_glob_method;
+		iter->doing_global = false;
 
 		/*
-		 * If we have finished scanning the global bootmeths, start the
-		 * normal bootdev scan
+		 * Don't move to the next dev as we haven't tried this
+		 * one yet!
 		 */
-		if (IS_ENABLED(CONFIG_BOOTMETH_GLOBAL) && global) {
-			iter->num_methods = iter->first_glob_method;
-			iter->doing_global = false;
-
-			/*
-			 * Don't move to the next dev as we haven't tried this
-			 * one yet!
-			 */
-			inc_dev = false;
-		}
+		inc_dev = false;
 	}
 
 	if (iter->flags & BOOTFLOWIF_SINGLE_PARTITION)
-- 
2.43.0

