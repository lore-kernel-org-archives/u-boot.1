Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FC3606A32A
	for <u-boot@archiver.kernel.org>; Sat, 21 Nov 2026 12:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=aHFnfyb1;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=EFijx55S
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9A07940A73;
	Sat, 21 Nov 2026 12:35:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pk8pms0tEl1h; Sat, 21 Nov 2026 12:35:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BE4B940A70
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795264510;
	b=bxBJFiyruEJNXALv2VTban4Lgw4/gNcMcy4YfOmV+FUip4sJXm6p5G7n5CCwC6abK2BN
	 +gCewFRLODHv9CKb8VOmnLVdPJ8NuXs+EfGJFPVERXuzY+glDuFwG1r4fqAG78hySphvO
	 zl4TdSYkFu7BlJVEpz56wURGV8eWkkUIkvKdH+fIYpOr8is7uxtNhJ/n82j2gc7zcPDiP
	 PDQrvXdLkT2aaANtNBk5k/zTMK+xVQZdRkrDtwlkF+6J2PNMe/9R/g1Of0BorixfuASF+
	 VkBjb1lLfWkI/+DLvPAYL4aR5woamAhwKkyNiirAxBVJhW6A/L6eD/0jNJOLtdqm3vA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795264510;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=VgvOaiH/qm46mfVizQ0Arz8U9z7YKGAni48trVXXReM=;
	b=p8ow3AAysVXLEnKOxjfwF6l4lkbppgXyBD4ZYDIvnZa6V33zKAn4ijEQQkly2du3JTUp
	 I3RX83W4uPBCQbO553xKpK/NeFKYFAj7y4XRdStxQGfFuTFAUNYRjmkQmKhyqmVOKjRXZ
	 5B3K96HVKmT9EP5P5RSbxVOqzD/PEqACCxFISzQU6U6Qp3k5V5Bg84rFTgOQhylP23aCB
	 o54+Rc3wlI86L3kqU2PBHNSGzdvF1p5XkAGK3+lF3ST4b15ig0aIUxHDbvv8UWxKJEKMe
	 2GH34hURcI2Jjlpj1EyKyy/C4PE0hjZqBS5APt50ySpQS3o3+oumDu3OMnMh3MlT1Vg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=amarulasolutions.com;
	dkim=pass header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=EFijx55S;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795264510;
	bh=VgvOaiH/qm46mfVizQ0Arz8U9z7YKGAni48trVXXReM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aHFnfyb11egC+No9R3fq2G3zj8Xx8KXXETzFmy1rJydT1gguPc8psvmI6n8LxAx9+
	 oRmAxZygDdqpYYfIYz3ulmIaQFTk4Ys5f+c2OtJUL66ZrgVurQFE+Qjb4tUfCSnjfP
	 F/ynY5P/6FFAU0AkYmaBuQ8rkeMWPXSwT1VQM2oqLXXYt/+o2H5t4RVwW/VML85sQw
	 jM1/SCmXWchXHrnaEAbQq3e4k9wy5iJAtOUpFaBOb/ykHzzAeLIGz8wAfdguugFamJ
	 xTiAKY9OBeqidsybaAzZLMiwSJVUKqqLC4vvnf8X+6sSnuPYkVwsfSepchYqNCixPG
	 PLSvH6/ZNZ9Vg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BE4B940A70;
	Sat, 21 Nov 2026 12:35:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id CDEE79C1
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 12:35:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 80B8B409FC
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 12:35:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zqi6K2MIrsc8 for <u-boot@lists.u-boot-project.org>;
 Sat, 21 Nov 2026 12:35:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7D14540891
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::329"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com
 header.a=rsa-sha256 header.s=google header.b=EFijx55S
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7D14540891
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 12:35:03 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4bb68c197c7so21676805e9.1
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 04:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1795264502; x=1795869302;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VgvOaiH/qm46mfVizQ0Arz8U9z7YKGAni48trVXXReM=;
 b=EFijx55SwENz5UrMIk5jvjwH2oF8e0+5AcYPa2cTDjaoM8kNn1ACIDbx8dtyXGII/J
 dt+2JTWoz+jmITtn+Zbp5NLnsjGcXUtcewpaQ5VNAoiLTVKpXiWQDPE7A2BVhGQsX4VK
 TLDkbJLQI+ettCMMyBBXpZQ0DMJAzRxQ986yE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795264502; x=1795869302;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=VgvOaiH/qm46mfVizQ0Arz8U9z7YKGAni48trVXXReM=;
 b=wzMiudjnohHa+rYeeyCMaSribSYhpmzyfgbobyIGm2NOykBFfO/smC09Log7tV6ToW
 9vCPYGs2fxDCMJgApsvgv7GnkY7gw37HBb8BtEcrjQ1C+fv4+iGTAV/VTq1bgwkhGeWt
 ARlspJz6uo7C55AFJh/p8iwp/lYrRI9hFoksdaIQvxwKSs07C3WmAxVx1uI3LRu8OhtQ
 9P7/o00PTdFEaUZvZNUG/Aig44tLoZa57hjJbZRf7G1hThfDudj7q4aOPvMorSLQjzeM
 QoGqH8FOLJ0syokvdM3kCTaS+ipnP0NP34tjLGQTszdLK7qqxXTJ4wnU/t6lS8ifIYHK
 V3cA==
X-Gm-Message-State: APuU4Z8/ODWUt6PemPH7uUmuuWCMlWwhsvDsEHnazW5C2k//2kjHFrkJ
 9xY8T722ztvLA6mDNUnXJxKm3mWpfDwIBQwGH8EBEKIm1N7ZLErZIjCgEg461igfyM/+QJ3KTEd
 qt6cZ
X-Gm-Gg: AZFdTZe9I47lWuHFqv7FVG6d7LVJzHH2JhNsINgm3dVCkT1LffwtBKIc0s5fsXnSz7D
 tKuqug++wA0MgSrlEegWIxLvafWFNjtd3PncUajCPyCTnp9dvOtsxtzIJf649OYXeQnwzkM4cdO
 MISaS1vuQPG3S1wqkgkDdctSDpe6grNQ4ElSc8DC8whiAnwDF7AI09Ud5enN+XcH6uql55deDeh
 Z8DuAiKSZOcZlOa352rPlVSjlOmoP24jz/W4cXpsKj7CRGj0ZHy/LI8BGzsajY+xzvsCBpqPR1x
 7RSML9GdsYVihZKT1w0d199kDzfxYmXnf4vK3t1pujz4h1B8LH1WVyeTtIiJNsOtkega8v6VQiA
 4Xh8SXxSER+ant9nP07I1sHnTEzv6dv2KwR9dTQyZC7dY5ELj9F38WTy7egXTu5x2Mmj4RylZu6
 3xVr3rInnieWTf120vBkTTKZThu1kSe4T/NxMFzgOL8oiR6d5VEmCeAuDeVDq33J6NBbz//oLoA
 a/Qo2gU67RhNCnxNuSs+enYwmCLTLwTvKwqLrfAE6hm2jn/w8C+R8aQt8NgsT9aif9cJvnQe1as
 qWU8AJ6sGGmCBngzY9pxBk3wq7ww30vHH61dMd8VouVBBkQrtjBhVNnv6ZEfcNBtjYO/caTIHqv
 nZUyDLWagjLra2v/cc6DEkJYq17lzkuPOI1OP2xCvkyL7RdkYQ7iS6kI4cD8/hT9QEp30pANNpB
 VzTEgrDXqw0+vo6YK1TmrlIoexEg==
X-Received: by 2002:a05:600c:4e16:b0:4bb:6f77:1e35 with SMTP id
 5b1f17b1804b1-4bb88810991mr146400905e9.21.1795264502079; 
 Sat, 21 Nov 2026 04:35:02 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab658e2d1bsm11720564f8f.8.2026.11.21.04.35.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Nov 2026 04:35:01 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Heiko Schocher <hs@nabladev.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Lukasz Majewski <lukma@nabladev.com>,
 Maksim Kiselev <bigunclemax@gmail.com>,
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 03/25] clk: clk-uclass: fix parent reference counting in
 clk_set_parent()
Date: Sat, 21 Nov 2026 13:33:53 +0100
Message-ID: <20261121123451.2471185-4-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261121123451.2471185-1-dario.binacchi@amarulasolutions.com>
References: <20261121123451.2471185-1-dario.binacchi@amarulasolutions.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

clk_set_parent() enables the new parent only if the clock is enabled,
but on failure it disables it unconditionally, dropping a reference it
never took. On success, it never releases the reference the clock holds
on its old parent, which then keeps running forever.

Disable the new parent on failure only if it was enabled, and release
the old parent once the clock has moved away from it, as Linux does in
__clk_set_parent_after().

Fixes: ac30d90f3367 ("clk: Ensure the parent clocks are enabled while reparenting")
Fixes: b493db39ea7f ("clk: Only enable the parent clock if the clock was enabled before reparenting")
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

Changes in v2:
- Add patch

 drivers/clk/clk-uclass.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
index 0069ce9a8875..c503f6733907 100644
--- a/drivers/clk/clk-uclass.c
+++ b/drivers/clk/clk-uclass.c
@@ -631,6 +631,7 @@ ulong clk_set_rate(struct clk *clk, ulong rate)
 int clk_set_parent(struct clk *clk, struct clk *parent)
 {
 	const struct clk_ops *ops;
+	struct clk *old_parent = NULL;
 	int ret;
 
 	debug("%s(clk=%p, parent=%p)\n", __func__, clk, parent);
@@ -641,6 +642,12 @@ int clk_set_parent(struct clk *clk, struct clk *parent)
 	if (!ops->set_parent)
 		return -ENOSYS;
 
+	if (CONFIG_IS_ENABLED(CLK_CCF)) {
+		old_parent = clk_get_parent(clk);
+		if (IS_ERR(old_parent))
+			old_parent = NULL;
+	}
+
 	if (clk->enable_count) {
 		ret = clk_enable(parent);
 		if (ret && ret != -ENOSYS) {
@@ -650,18 +657,18 @@ int clk_set_parent(struct clk *clk, struct clk *parent)
 	}
 
 	ret = ops->set_parent(clk, parent);
+	if (!ret && CONFIG_IS_ENABLED(CLK_CCF))
+		ret = device_reparent(clk->dev, parent->dev);
+
 	if (ret) {
-		clk_disable(parent);
+		if (clk->enable_count)
+			clk_disable(parent);
 		return ret;
 	}
 
-	if (CONFIG_IS_ENABLED(CLK_CCF)) {
-		ret = device_reparent(clk->dev, parent->dev);
-		if (ret) {
-			clk_disable(parent);
-			return ret;
-		}
-	}
+	/* The clock no longer keeps its old parent running */
+	if (clk->enable_count && old_parent)
+		clk_disable(old_parent);
 
 	return 0;
 }
-- 
2.43.0

