Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4140ACA5FF0
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 14:01:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D47AF406C5;
	Mon,  5 Oct 2026 14:01:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id p5IlNWgtB1UJ; Mon,  5 Oct 2026 14:01:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 6602140692
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791208880;
	b=GwPY9hW2BMtlr7ZQ5UsURZ+QXSQ+Sz71/pTvEHi3XPmUdKO9Hcj7iMjwrUzGMP1Izuzf
	 HPmhVU4cFRhBl6+1EXJyOlPuvh31M0qXWeT39IybqlUPFmoT/bte5MHkZhRLAZLWYyIGK
	 vxzrumh8EGQnrpu17oaTOzrQgQFV+O/sPiwFzCtv4uiq/XCsK4wqn9afzFitvrjxSVHB2
	 IqvkD5MlQZv5lMR/xSY5n1m5Fcoy1+nZI04L4YLauu9fKRy1cgxBRQS3b9FmMK5PdvEk5
	 WhPYIXETYJNEM7RilnDnisqUdLVUbifv2OCemPczQLEKQcTTntMzHdkdcYtlFulRTPw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791208880;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ls/g85Uo++wKf+hyNbodpSSlnRgNN+kiKh580/9dK48=;
	b=cQO9xXH4E4ruDGodo8kyO7JqEDRY61z4kYPbmaos2/dkEarcozkh6KGab+ebnRoWWDng
	 wQjYR4HhOv0UO0UsAEemNCw/yDAJSfmMKVaJ3hQZ1drCc+pi2RwkoRIT/yajUBDfHR2hn
	 62xpCaZD6vy3CScYKmX9mM09IVTVCq6v2tDqyi2SQkxpAvLUChLEkkvnZKtrBd0UCFNu8
	 ia8qLP+jJsOl9I5Utpufkr4zWkPqEPS5/DB4fkeR9nnkMEgQ/cWqm+Fd17NDSqngcG+Ai
	 wCTQIx77OU7gxJuB3Kaju57oVx23B/2Futq5EkGUgs+EQr/AcbcVewIT0R/Z04EbV0w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791208880;
	bh=ls/g85Uo++wKf+hyNbodpSSlnRgNN+kiKh580/9dK48=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=II13lx1t8ZRpIv1/pukA1kB6kfXLO+mOuVWHze9Y23HJgbuR6LHF4BZ0zS0aaUD/8
	 F8cXVmATMdcbF0wxB5ZmIlkp+9vp/8Dh3W8xF7dp2JH8sqLpmBKSAravG2PGM6h3C5
	 2oLWBo3jy8bb/NorWAJsWRQjj2rUGSZ3L2DBko9DHkFTWclmg+a+ZiiRlJBJ6hF9QH
	 nCorC1VBNSmko4fJwxOdPSUjXA9/Cs72UU33CwHCZZOr0CD1TXBHYUUvr740MnBrVL
	 x2+UcjoSpu4041633VTKH+ZDxjEvPk00iVyziV4M+L9wMEnJGjEC2oA8y8vp1t7IgQ
	 lJkzQCeFkCP8A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6602140692;
	Mon,  5 Oct 2026 14:01:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id B231B2E0
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 13:55:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AF68680BE0
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 13:55:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YloXZM2v8vnA for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 13:55:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org ECA4680BCF
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:41::24"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791208558;
 b=kVUUepPDwgd1lsSfvk6wJYGZ3f0V7MXLhueN+xpf0IWaWS9LFDoPIhVeVQK46pig45q3
 4emOPCrzjue8XFJMf9mhEyn7P0bM/RQ18ZdZQBZlJWMfxivRrI/yL0Ho2HLFBgR6au047
 2AornA8I7R8LPNsfZpNlRbQjsS1S6lkSxw9JKoVb2uuv0lahnBpOpqwyQgZVWtzA9w0kv
 tLmxO56VhXqvLyIT2qTHDRrG4Ww70Z+h0n/HdM2qnNzFA2PdWh78LmPKaSdY2xhJ8GRu1
 af+XNBJnJvhhROoDVXdqoWv2oBNqT0c+QkgJbUYm6mCuPqmPIYwBii7TB1NXfZ8AiBQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791208558;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=ls/g85Uo++wKf+hyNbodpSSlnRgNN+kiKh580/9dK48=;
 b=FGRUep5OlXwcnRLwWmyWsfLx7So1x/hQShIY5K1aTzul3m3p6qShK9arl2fD+bdjq8L5
 nScgi+z2ZNvXTW+7qqScqe+nKCvH5w98SntBexwnaRjLGTxh7QoiMswYiTWdBfj365kWV
 Ff6dMHwAfJvMcp8TTQESbP53WVZYj6W88et/0eYbkQ0HdB17TFrSGfcoljYUxS2qXJUkJ
 7OPf9W1NYSJcAi10FjYiEvySeaSgQc0z2ghIDOTucAW1TxEQyviU4NaL9PABQ+sgxBI30
 oKx1Ecx+aQqlX9Z0Hz8niVum1T4pKbByCc64CfSSnsYKEZXZllY/4O7+9nbv3UScIjw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=brivo.com; 
 dkim=pass header.d=brivo.com header.i=@brivo.com header.a=rsa-sha256
 header.s=google header.b=IRf59hBk; 
 arc=none smtp.remote-ip="2607:f8b0:4864:41::24"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:41::24; helo=mail-yx2-x24.google.com;
 envelope-from=sanderson@brivo.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=brivo.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=brivo.com header.i=@brivo.com
 header.a=rsa-sha256 header.s=google header.b=IRf59hBk
Received: from mail-yx2-x24.google.com (mail-yx2-x24.google.com
 [IPv6:2607:f8b0:4864:41::24])
 by smtp1.osuosl.org (Postfix) with ESMTPS id ECA4680BCF
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 13:55:56 +0000 (UTC)
Received: by mail-yx2-x24.google.com with SMTP id
 00721157ae682-8aef5f85003so8719907b3.0
 for <u-boot@lists.u-boot-project.org>; Mon, 05 Oct 2026 06:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=brivo.com; s=google; t=1791208555; x=1791813355;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ls/g85Uo++wKf+hyNbodpSSlnRgNN+kiKh580/9dK48=;
 b=IRf59hBkfKndase4i4zFCOCw19q5cKGiUVGSxyTraRx35TFg5dUCnNTosxI7pcLKn3
 mDSNnK+B6WJlLq9Sew2X0Fm6NVfFj/O9f4Vf80wFC0uS9ampv46AyCnwoEOcj74MzgEl
 ojZZx4G/JmZ6YJqIa1GMbd5M7hJhAy8S/5qilFKkKjxmWgu6dX/FZVxQBQqsCy3tcUMp
 D2BjG96SNhqFw1f0jpWy3/b3oKroYJpifxNaVI46svUAhvfL9xQtjp8sKqHLwTMexpPs
 anPLIHLCUNfIz8x32qnI2XtheNvXQAkS3yy9zGUJ1Vf0omW6skFQkmnIigekViwRs0QX
 cMrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791208555; x=1791813355;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ls/g85Uo++wKf+hyNbodpSSlnRgNN+kiKh580/9dK48=;
 b=xfAiAfmhTR0DSwNsS9MH2wLII7kgfQpCS5zIFmolWXCvBnWHB7uXh62va81dlUu0F1
 PJGYSsju0UPJC9UFlv8KQtBx3aKWzODZdD5m3+crf4il/fscp1+JFso1pbpnrPMEk1td
 WMAcRauOvgr3KqyR4Kkj+q0/IPDxn6lkwWnd005dN0Lft1zp3AagDr+XpyQ/CN94nndh
 V0SneTu/rvB3rZ1Bel06vaQQG4G+fk/j6QkZm1f9cV2ZyYWOGQWNEKyGizG9GMrYadV/
 uEL2de/czz8+KCFpVz7ndxsErIuCWxmVWPZVtgY21ttG10IGnq5BGH216LuvwyBuZiXr
 letA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxxhbhX4yxAnJUL+GP3TUaWWdk9XJh8I2lcKL3m11yZD88RhyfWzWCapvTyprtET0HwYXHpd7I=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIjEIX6vK9dCYVoOZ3LIvUYyRPsQ/yCk8h0deQfVI2eKNbCFn9F
 ZrGC7PLKDLTuewau0fDb0jBFZLEo6FHzqv3D1voz/s1z/OmWCx7W1JsjRR4BUxqVdEkTUmie00e
 CPKoSCFA7ffE0oVGaDSBmQOUdsQY7Wu/ZT9niz5Q53KnlVhqQV+IBJAnSa23epTo=
X-Gm-Gg: AYBFou0x9aww0miEC4YRQJQFTzpjcR169/5IDeSdzRmaC+0u3/UucyuXiB3D34XSdrI
 mSBODn0IXpiybqyX3GB4Lbz2jhoinlyxuRibiePGTtzqxNX5/o3kT9lc+DCaCURSAsFZgKFg+u4
 f7ntdIezE51kP1fr4fSmXMgoNChaYarkDLrt81Oxg86tHKoC1Y6nJY27x3pv7+XbcseqmqYg3Za
 8zEGyxoQMnwZZzK41TAtp4zxP1msZFFs8A592Ltp55zjep/wQrw7TlcWO7Ed8I8Qo1VAqo6cHhO
 laE/9pkPN8QF04un4+Sfk1W0vaXglK0NV/dwkXAg5uGjAcjWgHYaUSzlxiNTa6f0utQylRrXvE2
 YZNthQqznWcwHvdj2b2Utwe+N+LQPxyMoDVVa7Pq9cneILZHMhlOc9Zw7e+sXd2tUACvwrR/l3H
 mPjCUKaAqtw5AVIvA/aMWycsdu+QqmEndjEGZjsk6YEgt3vC13CCiI20EfLyPw2J5u229V8yoTN
 Q==
X-Received: by 2002:a05:690c:ec3:b0:8ae:9080:2c24 with SMTP id
 00721157ae682-8ae90802d73mr35560277b3.29.1791208555359; 
 Mon, 05 Oct 2026 06:55:55 -0700 (PDT)
Received: from strozzi ([66.193.28.125]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-8ae328ee37asm39074437b3.10.2026.10.05.06.55.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 06:55:55 -0700 (PDT)
From: Sean Anderson <sanderson@brivo.com>
To: Jerome Forissier <jerome.forissier@arm.com>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Sean Anderson <sanderson@brivo.com>
Subject: [PATCH v2 1/2] net: mdio-mux: Don't crash if our parent never shows up
Date: Mon,  5 Oct 2026 09:55:47 -0400
Message-ID: <20261005135551.510145-2-sanderson@brivo.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261005135551.510145-1-sanderson@brivo.com>
References: <20261005135551.510145-1-sanderson@brivo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The parent MDIO bus may never show up (such as if there is an error
while probing it). Make sure to return an error instead of crashing.

Fixes: 8880edba06d5 ("net: add MDIO_MUX DM class")
Signed-off-by: Sean Anderson <sanderson@brivo.com>
---

(no changes since v1)

 net/mdio-mux-uclass.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/mdio-mux-uclass.c b/net/mdio-mux-uclass.c
index ee188b504d1..14143ca0ab6 100644
--- a/net/mdio-mux-uclass.c
+++ b/net/mdio-mux-uclass.c
@@ -86,6 +86,9 @@ static int mmux_read(struct udevice *ch, int addr, int devad,
 	struct udevice *parent_mdio = mmux_get_parent_mdio(mux);
 	int err;
 
+	if (!parent_mdio)
+		return -ENODEV;
+
 	err = mmux_change_sel(ch, true);
 	if (err)
 		return err;
@@ -104,6 +107,9 @@ static int mmux_write(struct udevice *ch, int addr, int devad,
 	struct udevice *parent_mdio = mmux_get_parent_mdio(mux);
 	int err;
 
+	if (!parent_mdio)
+		return -ENODEV;
+
 	err = mmux_change_sel(ch, true);
 	if (err)
 		return err;
@@ -121,6 +127,9 @@ static int mmux_reset(struct udevice *ch)
 	struct udevice *parent_mdio = mmux_get_parent_mdio(mux);
 	int err;
 
+	if (!parent_mdio)
+		return -ENODEV;
+
 	/* reset is optional, if it's not implemented just exit */
 	if (!mdio_get_ops(parent_mdio)->reset)
 		return 0;
-- 
2.53.0

