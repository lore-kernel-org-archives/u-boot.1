Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7303EC982CF
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 12:50:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2E033407C6;
	Thu, 17 Sep 2026 12:50:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RJ4yXnrbFqXP; Thu, 17 Sep 2026 12:50:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 6B3F1407CC
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789649455;
	b=rNhVBQqCzfyjDVShag5jmxvE0pwGYVFiHnCWxXti5XPPAXzL9XJL5+DIDuBZ8QULCpwA
	 QPUJZM3gQ2klypZF6Wv5zIANYqspvtuOhRjdbNCSKhu087Tm/oZHnEfZsgTjnIJR7BVjH
	 /Lmn69KbZ7hRlgNP6EhKicscJgGM1RfAMjdIiUWO4b0rhB6CGtO4QABAeBK3UopaeywEf
	 KuZmp0eMss5mIVxkcpc9KDYVWmjU1z9WZNDqHRD+N1jVs7NKgkIHQdG4PVj+B/7eUzTNz
	 6j+r9Bsjl4IGf5ZNiS7cgAF60lPm8+mvH8L49Ai2JHlXIYTG23Ea6yAQJUBGxCT2fWg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789649455;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=v35UJVO9Ci9mMi5Ru51tUFkJ0b7yEWbfkKcKYON+/oo=;
	b=CxiBbias5rzQH94gsqS9n2ltHGqsW5zunZWkH8z0ZAd5WQebhjdftAktgCN201xhKdEM
	 h1kEDmoN0Azh0D1d4koF28r6h6zR+dGiXnxOypy+tx+e8/7h33MAunDRtGyr+5lQGXHYq
	 ULJ/fzCa4EprqBjUA2JLr8Xyi0EMSWdWHabRtz/qcsGd6jC3U3tuOq9M69m3jYadPSoI2
	 025Y2DA+jroPO3WiyUyLofQgV/C0AOd2hdrM28/QykbcZzIcb09hbQ2Qcu4FuHUGqdJFZ
	 x6jlKok6UPPzmaAHwrz8MjmPKb8sZa7s2+ZmfI+dPffgdNgLGdnjH3aQ0fwG1LznUOQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789649455;
	bh=v35UJVO9Ci9mMi5Ru51tUFkJ0b7yEWbfkKcKYON+/oo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fVUkz+z5tVvYn/2eEEUi0fZB9cPoF/xiOnYSkmSCMzc6ZcKz+kKbmkVHGi+5vXt4P
	 iL9Oyiyn8fkFKAKgkA0dwcBHIRktB8FwT9N6/6CXWx8wniJklSzzhzEKE52DGZwTan
	 462ipcmt3NeOxzurGJ7PJEYHKYabXD5iOap5EBdXJ+DGIO/3bZJ1IXQbaF4HWBQHXn
	 sSe5GhBtrgHxB5AKdUDj6jy7pg2siREk6s3x/RESil9tud04ldpL+Lj7f9kYl98a9y
	 clBl4en7LSUfe/ty2fmFeMIsO0SKgduZTCfb0tpMWOV9T+g+Eosl1oXMWpjW80rGfh
	 h5gSvG17HIVCg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6B3F1407CC;
	Thu, 17 Sep 2026 12:50:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id B337C37A
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 12:50:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9A16E40346
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 12:50:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nWYSYV4AkrUi for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 12:50:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 9F6AA4035F
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789649451;
 b=Pql+yb8ImcG4C456/id3+yDDBXUTF7EzJVnLE5KABAbIvfpLgwS/OwsrS5StiGkAGYNX
 WbbiAVgJVO6GrB7NOfYbVqW7jEJ+SmYfaA7BujJGJePxYbvRdCgOJubzsi2yflFtMqjgs
 O5/TUvaYYHiF2KFna12YL7WnbvdQeJiS4rY4LznmfZXw0uov13ejar2irPJgyNTgBryUV
 ViQI+1b3wcEksiZ9akwbqMWypnY4iRxLcGQQ+RGnTZSomKNDwBolcbmH82i4WvwQmVgx4
 whNWIEVzqMg+wPpcVmu0BJd35y3j6CYqNbuXfJwCd3z3UfNMPoeuYaFcW87hlg0hIZA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789649451;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=v35UJVO9Ci9mMi5Ru51tUFkJ0b7yEWbfkKcKYON+/oo=;
 b=raiWvpYwFOIoKW3aCdc+fWE6J9otEGo4QuLfTy9VzH0KGG3cEL952m2QXYE3S0P7VkZk
 8izpo7Ao+Z50yZPNMy3q6buoM2bZXl0Ns7ZETr7MXdERda76il7j/wvHXNaBbPjDvG0i7
 WjNrs0eIaKB6QGNpHXADZ/Aop0Zhe4cSfQeyj6ceRNmaNq+UNvPYIr7l4d8MqKaGVWUDt
 fXdi9OwY21rHrwDlFqiSPYxV3jhtDiyVmTx7eEK1d6fGmetbpyTPbG9qFMgAM+M28dhYw
 sZU2MFDn/TD9h4wygKiii5qWURcb2NtLimvpn/gsbxd6btRICVOFkQBmFw0HY4ovJ1g==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=khm+AEJj; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=khm+AEJj
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9F6AA4035F
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 12:50:50 +0000 (UTC)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e620fa473so4842695e9.1
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 05:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1789649448; x=1790254248;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=v35UJVO9Ci9mMi5Ru51tUFkJ0b7yEWbfkKcKYON+/oo=;
 b=khm+AEJjLaxHm5T5fEFyWy+7/4W9Ty3rPr8uMskA++1pjormdO/3P3sLdX9532UEg+
 VvDC8/8yxjfIaPHrk7KHS+dDA3TWPl+2r9t7VqzBwgmWNv9i7whpgstV8PeRl7wYNYQs
 dspLUfHO56V19WTWTmlVJx8Y1ltorE0liWwEjZpYWysU9O2kF6fv7iBWb8mdn0zV4I5f
 O1oN+Z7OgHSKdEud232Cj/1daXf2LsI673ApJXbFbGeGakq9Mrn8VoL6ezNYnhV3ueOJ
 Eg1M/0OsVi6nQ3cCGAHHuOPNxV4fEGP6MKy7DIsvj+7HwTGlvosakBNWxDQhgPlBA3ob
 m1bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789649448; x=1790254248;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=v35UJVO9Ci9mMi5Ru51tUFkJ0b7yEWbfkKcKYON+/oo=;
 b=uWL+/LjvxyIiwbO4y+7rmbBVDU1gUycuxEkJzSVf5xKFyyaI2ENJKyPJKsmzW0DaBG
 BtuU4LjTxvK3rInIYIUYrlsxgDS9SLVqC8uMuuwzCu3lRfH3klxNv8e3aBYCAA3TZ7rH
 O6nt2jWPalgd7hL1ZpvXRvLMB7gsweSEq/E5FLvoUnbwYnZ1Smoipun9DRFSd8+yvbOy
 6J4tI7PNNjYY/8+20c1KC4qqi44GLFr1OUUX1LIEEfAH9zmYWUrL6YaYZGXDyj+B8b9y
 Qlsl/Hwpi05yQDOM4nY+VA3ozk/b00NBaos4/2JWcw15DQMdQq5Mef9s0B8PyLn3HP8a
 Of6g==
X-Forwarded-Encrypted: i=1;
 AKwUvBzsihpxTzrILXU1fFSqDelUP4yldCVAAUSm1IioqJ0N0EOlzs6EP57ZFFAW1PDsA+kEJ9OPhrw=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++k1TWEHZbOedyXBOjcWBn3FOmM/f2TdIMfv+CtWuEBnTJ/OC4XG
 I7RPxYNwhy5ZHeFFKaOKMJWt54l6EAy+fCMmYNZ/O1LBqQtDC/qSZGsOSSy+/gMahvo=
X-Gm-Gg: AYBFou3wCSaGwtYsZV3aRqOPZ8s7vp2sHIFirjg0F0+rB+mb+GeZPaIySeNmFcE9lh3
 /mJ87fUvt56w9PfZpw7fJLHhtVa5XWmFofBcJwG30sVpAN7yXIilWWZ+59j235mjXZbhYk4j2OZ
 TMKCiRY+5QUHF6Qid40PtL2sb0j1cnRx7zEK003IoCniGtbM3sih2vj5saukR/6ovuupukkIh1y
 czbYDA1JcCzJ46H35UMuogauK2h5KKszb7eQEylXneKw6firoKN065UUk/YoqdnGzWYxaHpVMLL
 tzBzopVs5DlbfNUQ1gs1FcCre4Pmjx6dsk0AMuudFlG40XwlPNY+kb7y5vsn/Ga5c6RJuEg2XbW
 RgtJX2X1oQsLO7YrrzfUgiWu6vjaiA2EzRxzVybd7vlA5vKy3AUocbl2//MGmeZrnp24FtTq7D+
 +Gfm3OrP8admFaGjS9jVebgrW+qEOU5DQcfdu9wRPO3JIL5l3qtsF7bm1s4pIIjypx5zNDoRZ0g
 JNAGv7HGE3l3N1mZp7skiYuFNh5LND+oC2B9jGt4mOH+7eTZ1lFUkHFqBAyrmf4iqV8Fyars9+U
 aeB0yduUh9D+++EV11h/V9DpquHLOEQxXhQHlhNzfIHkVgsA6gR82X0=
X-Received: by 2002:a05:600c:1d0a:b0:49e:7d74:7b7a with SMTP id
 5b1f17b1804b1-49eac45ba14mr72275685e9.6.1789649448324; 
 Thu, 17 Sep 2026 05:50:48 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fbd23f4e6sm88614255e9.8.2026.09.17.05.50.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 05:50:47 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 17 Sep 2026 14:51:57 +0200
Subject: [PATCH 02/11] clk: mediatek: add a helper to declare gate-only
 clock trees
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-clk-mediatek-cleanups-v1-2-4dccf8ed98fc@baylibre.com>
References: <20260917-clk-mediatek-cleanups-v1-0-4dccf8ed98fc@baylibre.com>
In-Reply-To: <20260917-clk-mediatek-cleanups-v1-0-4dccf8ed98fc@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Chris Chen <chris-qj.chen@mediatek.com>, 
 "irving.ch.lin" <irving-ch.lin@mediatek.com>, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.15.2
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

Subsystem clock blocks only provide gates, and every one of them
declares the very same struct mtk_clk_tree boilerplate. clk-mt8189.c
already hides it behind a local GATE_CLK_TREE() macro.

Move that macro to clk-mtk.h as MTK_GATE_CLK_TREE() so that the other
MediaTek clock drivers can use it too. The tree name and the array of
external clock rates are now passed explicitly, as their names differ
from one driver to another.

No functional change.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/clk/mediatek/clk-mt8189.c | 23 +++++++----------------
 drivers/clk/mediatek/clk-mtk.h    | 22 ++++++++++++++++++++++
 2 files changed, 29 insertions(+), 16 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8189.c b/drivers/clk/mediatek/clk-mt8189.c
index 3724dffcc3a..8df09f4a129 100644
--- a/drivers/clk/mediatek/clk-mt8189.c
+++ b/drivers/clk/mediatek/clk-mt8189.c
@@ -1994,22 +1994,13 @@ static const struct udevice_id mt8189_vlpckgen[] = {
 	{ }
 };
 
-#define GATE_CLK_TREE(_name) \
-static const struct mtk_clk_tree _name##_tree = { \
-	.ext_clk_rates = ext_clock_rates, \
-	.num_ext_clks = ARRAY_SIZE(ext_clock_rates), \
-	.gates = _name, \
-	.num_gates = ARRAY_SIZE(_name), \
-	.gates_offs = _name[0].id, \
-}
-
-GATE_CLK_TREE(perao_clks);
-GATE_CLK_TREE(imp_clks);
-GATE_CLK_TREE(mm_clks);
-GATE_CLK_TREE(mminfra_config_clks);
-GATE_CLK_TREE(ufs_config_ao_clks);
-GATE_CLK_TREE(ufs_config_pdn_clks);
-GATE_CLK_TREE(vlpcfg_ao_clks);
+MTK_GATE_CLK_TREE(perao_clks_tree, perao_clks, ext_clock_rates);
+MTK_GATE_CLK_TREE(imp_clks_tree, imp_clks, ext_clock_rates);
+MTK_GATE_CLK_TREE(mm_clks_tree, mm_clks, ext_clock_rates);
+MTK_GATE_CLK_TREE(mminfra_config_clks_tree, mminfra_config_clks, ext_clock_rates);
+MTK_GATE_CLK_TREE(ufs_config_ao_clks_tree, ufs_config_ao_clks, ext_clock_rates);
+MTK_GATE_CLK_TREE(ufs_config_pdn_clks_tree, ufs_config_pdn_clks, ext_clock_rates);
+MTK_GATE_CLK_TREE(vlpcfg_ao_clks_tree, vlpcfg_ao_clks, ext_clock_rates);
 
 static const struct udevice_id of_match_mt8189_clk_gate[] = {
 	{ .compatible = "mediatek,mt8189-peri-ao", .data = (ulong)&perao_clks_tree },
diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index 9244542a2a5..e3a7ff75734 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -8,6 +8,7 @@
 #define __DRV_CLK_MTK_H
 
 #include <linux/bitops.h>
+#include <linux/kernel.h>
 
 #define MHZ				(1000 * 1000)
 
@@ -274,6 +275,27 @@ struct mtk_clk_tree {
 	enum mtk_clk_tree_type type;
 };
 
+/**
+ * MTK_GATE_CLK_TREE() - declare a clock tree made of gates only
+ * @_tree: name of the struct mtk_clk_tree to declare
+ * @_gates: struct mtk_gate array backing the tree
+ * @_ext_rates: array holding the rates of the external clocks
+ *
+ * Most subsystem clock blocks only provide gates, whose IDs are
+ * contiguous and start at the ID of the first entry of @_gates.
+ *
+ * @_tree is declared static, so this must be used from the file
+ * defining @_gates.
+ */
+#define MTK_GATE_CLK_TREE(_tree, _gates, _ext_rates)		\
+	static const struct mtk_clk_tree _tree = {		\
+		.ext_clk_rates = _ext_rates,			\
+		.num_ext_clks = ARRAY_SIZE(_ext_rates),		\
+		.gates = _gates,				\
+		.num_gates = ARRAY_SIZE(_gates),		\
+		.gates_offs = _gates[0].id,			\
+	}
+
 struct mtk_clk_priv {
 	void __iomem *base;
 	const struct mtk_clk_tree *tree;

-- 
2.55.0

