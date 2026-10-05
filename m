Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D33D3CA5FF5
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 22:50:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B8B17406AB;
	Mon,  5 Oct 2026 22:50:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Aj-F6KZ--Fw0; Mon,  5 Oct 2026 22:50:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 749144064E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791240647;
	b=WhlA7M8snRc4b5GHzfXtvOvOAoYdrLHvZlK/X3Q3BIWLDYBJhjvaYn5apaO/rszzRgzG
	 K/9sFneVDw8PrJ4iJNvYL2j3imWy16uXpqPt4hwmyJa9MCTvDjaam03oCxciPElOEokzU
	 uu++jnK+gDcv/+R1dzRVFiOZb9rlr0acC4mYbYLsoHhQnAaZy/yBotzOKb6AthSOpTqCB
	 M1ibarkN5N6p74M0YKTyI5MCeYVc/wJ4itDUh4rb/oDpfPvq4b4NoXLve3a8Mif+XPSxe
	 TjYJ9KsaS0xhGWK2sl3fOkpqV/O2YJSNwteFAG6HwnMd9MDvjJBaBYdJYDu/odydK+w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791240647;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=jfr6iHp9avK4uALIw4jheUVymWRd2OnemHQhQhrJccU=;
	b=cLT+v/VLXrwDBokqCET3BVXMYuoKrxnS9cKI+AVzGpct91GQPsZiqzSzvaFjDWE0CsiX
	 kmasIYb2NPQVVSWZCDoekBxAy0sXJ46wxfFKMapWLgiNTe9gc+pTNOeCLSmSQDu/jaRvB
	 UaSz/ks3TOY3U+Iu7KaDFKI6o6b1WRyOnpak//cVzQQX1OIgSWXLwddaovtCDY0jBzLKP
	 VLb3H8h5z7xxWp1zo2BEn7yhPi6hSMSc+ADrai7WyNGpo39PqXqVlV5Mtl6pmYCBtNLfo
	 7mjQTOzHQ3g/zERBjdNh1szo9gxaz7hiBurGKuS0IHDMHgSy1S7UJFkEAwRByLrYabA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791240647;
	bh=jfr6iHp9avK4uALIw4jheUVymWRd2OnemHQhQhrJccU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NnxbLiRtw5DdKTyFzdEkSe/ZDiMK2EIn0ckXYKER917Q5hXVVCFEkajNQQX9a7Z/o
	 LxkZmUHbU+2jKzJcIXkRAH2kM7kX6xMqxA3vrD37WRisOuCfjAGdkrjGjRvMlKMT4D
	 4w5OnacFAQ48XRA85WCQuBzf0VrZhmmxlGsc9VTmT4uOQRm4wpeeymP1d3VUYRwe0x
	 CJrVotTBdLxlzCm3vaSakepBTX2tMwbI6c3lb4qULU+kt31k3SDBpC1cSJYtK+sS9H
	 xCnEZyUYRvpUwfpthQ5QfauhFUCgbla4HlKc74dx/G0Ena9gIfTCA3N+nWEaTDtc5P
	 uA7MzCykhRudQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 749144064E;
	Mon,  5 Oct 2026 22:50:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 37D5234E
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 22:43:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1DF166069E
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 22:43:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kxWSMErCedB5 for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 22:43:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 00EDD60699
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::26"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791240220;
 b=IxzjBQm4rkdiyzkv+ZJKj68nUY8PYCeYZSik+Llcs12DJ/BOAWVr041rrED7SH9Cmay3
 /NnURAuEwgLZe6hQwoUNoceiu39Qiv2aJrutNL7UK5atsS+1wHzLfJJpd1UGNy2fSWpKg
 fbvUEZAKrS6uruZLOHNvM0GK5+gT3vKQ1aKSdzOg4Jo7aBVbahMhYSnkNfppDpEV1Myqy
 iEBwENLBDHHc8IZyWLxlyDijZGX4eZW7tfKmyzJWi4qsvnaozH7vEiPW9/MVDGNLkBPm/
 9czEo4Sl45i6Ge5h8kLbbi7ebl4iqjSPvM80J4iNA4gxboMR2q7F3jLuMzFOoMi38dg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791240220;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=jfr6iHp9avK4uALIw4jheUVymWRd2OnemHQhQhrJccU=;
 b=Uq5dAvMb93z7vmmQJnViA6MO90ZQgw7eJaKBXJlMcvpFAXcagpVKzxqXPVZqY969lFf6
 At/XoYAOEmIOxOBuaWQLMI7sDQyliVJNS6A20FnawHncCN1C+SXn+3JjPCJzZD4nlM9WH
 iACTaaRKC6oBwhwUgQ2n0a3yeUvqq0In9HVavlcKxjv8mxIsv1EYdly2qOBwhKX+1EOJh
 u2aVlCvVxQtb0Rra1XONa+2U0+CSv7MkocZQMVkRYtVvXD0crGMza6fQqJWdKoGN2+8Pt
 lEXecaw1PVnEivw8JmhtI1NSGdnvqNeqDbNTZsJ4H8NtOjwtwJEksdmw+hXJFaG5wlA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=mKyRXytU; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::26"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:31::26; helo=mail-oo2-x26.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=mKyRXytU
Received: from mail-oo2-x26.google.com (mail-oo2-x26.google.com
 [IPv6:2607:f8b0:4864:31::26])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 00EDD60699
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 22:43:39 +0000 (UTC)
Received: by mail-oo2-x26.google.com with SMTP id
 006d021491bc7-6de64084488so1458976eaf.3
 for <u-boot@lists.u-boot-project.org>; Mon, 05 Oct 2026 15:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1791240219; x=1791845019;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jfr6iHp9avK4uALIw4jheUVymWRd2OnemHQhQhrJccU=;
 b=mKyRXytUKEm7ZdQSwMLMZDzJc4Vcb7DXxqy5PJaH1wQ3nK7gd1FuPZxFLQUHNWByDD
 6p7Mo1poSXbYGtvIHLPQMbiK6W+yJClaZTQSAl+52c6SjA5o6Oz/AZZlkHlOVhaqRowg
 eisY5ECp4Z4aiG9Ozph3h5i3bl4ieUls65ABjKvHxk5Bsm1OsT11mOcsExMMabbyiN68
 TgyetoKWgNXBm4+gP4zRmsr8P/CfsMMpAQ17Zwse9S8gYdZBSMPuj8LU73XqaOZ5Fcv5
 utmJGjawtQzD8Q92y0xJGvc0sH5LCvDGm2zNUacqAv/wJ0niLcY/glhjTUCm+dc/s+tQ
 5qCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791240219; x=1791845019;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jfr6iHp9avK4uALIw4jheUVymWRd2OnemHQhQhrJccU=;
 b=KUzJzmeZHLdcHPWLJE1XBw/+72oiINORTXgjzH/JvmkivHNCY1wjXptx3wnrW+C8SU
 N8lLforP8vzqfLvhlwhQ6ryTo3HXBJci2/7slJfykTYi1az2tKPjP1eakQxUFsS5Zoda
 6abxd5dq6rZzaAPuee+bFNPShHjWnBqz2JHU76prPxeUEiIB1ZQciS+olwE0blwtXFGz
 JjqJKqKExLo7DhEH39piKQmf0cQBO7eKaR2tqOZNxTv51YZh13alUzXM8p2aCBkLSZTq
 7CvbI2Hy51f2rqS2+UA85rrVni04WDs0oYG4RHP53NAcweeiGRx4XOb7QGFqRoem+9Yn
 jwfA==
X-Gm-Message-State: AFuF++lmOMV6TZvXrZhyhtKFb/Bu7ju7OgJp7eYoAA8OA52m6XPhNui4
 bkcSjLLKcFP1hJQc8P1kMi3bZ30eG30VxDfDE05C8fyipMTF+0ZrzPUE+pqSIvCEI1U=
X-Gm-Gg: AYBFou1YadxfvHcUjk1OZhqYYEZkX7NDzPK4st1gY66UZHkK6pAs0t9L0Y7bmPTleqU
 LWqjPu5EMo7Ben/22cjgk7hMc7l1DfeD5RxXX2uBvXne4MN4XHcv4SOIVNyBxag38hirp4u09Fk
 iEFyN7oI3y6xYRpzil5gW2eJY7HXZTRpxScmcHJFJxbeMQxIqacsU6v1P4fr+xFF0pvCJntgzBT
 yqh+5JB1YEdkGFWXQ8URn5YiSdYKA1K79uB/8s7IPjXlt2dQWkN/di3wl4Ue/YEMFGl56pMec6S
 8PKyldg0zhPDuYLysSkRgV7yRY76MK5ic9LCnnQg9VkHZeUtONrjZCDjrENTuKMW13SxWgjSKIQ
 blObdHLkvSUU176qtlKk0QY+4Ce+gT+yWcXR18l7oSn/te3l2McsahMeSMisLlryD8H4gFz1hcx
 +xx6m5rDGBx0mHFr6qqRMOLIFXa1bjXNzocO9l6WCac2M9XMEraEE/Z9mV2on1waPtXVJLlk7Kl
 ds=
X-Received: by 2002:a05:6820:619:b0:6d7:7337:ddaf with SMTP id
 006d021491bc7-6df35a3dc86mr11024333eaf.59.1791240218752; 
 Mon, 05 Oct 2026 15:43:38 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:33e3:ea0f:8b95:f69b])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6e4c04d915bsm694448eaf.2.2026.10.05.15.43.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 15:43:37 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 05 Oct 2026 17:42:50 -0500
Subject: [PATCH v2 4/4] clk: mediatek: select mux inputs by rate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-clk-mtk-propagate-rate-v2-4-b823df57e4c8@baylibre.com>
References: <20261005-clk-mtk-propagate-rate-v2-0-b823df57e4c8@baylibre.com>
In-Reply-To: <20261005-clk-mtk-propagate-rate-v2-0-b823df57e4c8@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=11869;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=CeqErxZifCJFTpXdWkS+zZbnN8RIeIBTXTOCl7fk0tY=;
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqxCgEzHhEFJP6TAH5grkub/lGkkNsFwTuh5yVN
 4xiKeC3rwKJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCasQoBBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AuHAIAJkRKJPVbkeaGjCA6TE81XoSew8CA5DXQwOv7Sc
 SCKcI0QnPWn1pb2uRpwIXbZRSCPPAlbPIlK0+fmEtlD8Dx3pKF8sIHTel13ypmBGN22sFcF+uY9
 AL5De9+fWKI7CYSHNpaSGds4VkQRFlJsZkNaNQTYydBRWewrtTTkP56+xk8gNoN3Kw/MhOB8CX7
 VpTkntzV/2YIjZ/vqmb3CVCdxYHoTF7EH2GrJ9AQYhFZH6HFDSfP9inPoM+6lS2XfuysxNUO9FP
 EAbNndHNhp6PjSWffcS87Lrm4SwiWtU50Hr3NZE/AVOa5oCFgajS5evUiGQg+3PCmAjVq10z1I5
 fFNE=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Make set_rate on a mux, or on a gate in front of one, select the
fastest mux input that does not exceed the requested rate, as Linux does
for these muxes. Add round_rate so the result can be predicted without
touching the hardware. Both paths share one helper with an apply flag,
so they cannot disagree about what a request would produce.

Only a PLL can change its own frequency, so asking any other clock for
a rate fails with -EINVAL today. A display driver typically sets its
own PLL and then asks for its pixel clock, a gate behind a mux, for the
resulting rate, which only works if the request reaches the mux.

A request never retunes a PLL indirectly: it stops at a PLL or a fixed
factor, which report the rate they run at. PLLs are shared, the audio
PLLs in particular feed unrelated blocks, and U-Boot has no rate change
notifiers to keep that safe. Linux sets CLK_SET_RATE_PARENT on these
clocks, but relies on that protection.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mtk.c | 251 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 212 insertions(+), 39 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index 1d7a65904a1..e611d48f083 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -14,6 +14,7 @@
 #include <linux/bitops.h>
 #include <linux/delay.h>
 #include <linux/err.h>
+#include <linux/string.h>
 
 #include "clk-mtk.h"
 
@@ -249,46 +250,51 @@ static ulong mtk_ext_clock_get_rate(const struct mtk_clk_tree *tree, int id)
 }
 
 /*
- * In case the rate change propagation to parent clocks is undesirable,
- * this function is recursively called to find the parent to calculate
- * the accurate frequency.
+ * Build @out so that it refers to clock @parent on the provider selected by
+ * @flags, which lets the generic clk API be used to walk up the tree even
+ * when the parent lives on a different provider device (a topckgen divider
+ * feeding off an apmixedsys PLL, say).
+ *
+ * CLK_PARENT_EXT parents are not backed by a provider at all; callers have
+ * to handle them with mtk_ext_clock_get_rate() instead.
  */
-static ulong mtk_clk_find_parent_rate(struct clk *clk, int id,
-				      struct udevice *pdev)
+static int mtk_clk_lookup_parent(struct clk *clk, int parent, u16 flags,
+				 struct clk *out)
 {
 	struct ofnode_phandle_args args = {
 		.args_count = 1,
-		.args = { id },
+		.args = { parent },
 	};
-	struct clk parent = { };
-	int ret;
+	struct udevice *pdev;
 
-	if (pdev)
-		parent.dev = pdev;
-	else
-		parent.dev = clk->dev;
+	if ((flags & CLK_PARENT_MASK) == CLK_PARENT_EXT)
+		return -EINVAL;
 
-	args.node = dev_ofnode(parent.dev);
-	ret = ((struct clk_ops *)parent.dev->driver->ops)->of_xlate(&parent, &args);
-	if (ret)
-		return ret;
+	pdev = mtk_clk_parent_get_provider(flags);
+	if (IS_ERR(pdev))
+		return PTR_ERR(pdev);
+
+	memset(out, 0, sizeof(*out));
+	out->dev = pdev ?: clk->dev;
+	args.node = dev_ofnode(out->dev);
 
-	return clk_get_rate(&parent);
+	return ((struct clk_ops *)out->dev->driver->ops)->of_xlate(out, &args);
 }
 
 static ulong mtk_find_parent_rate(struct mtk_clk_priv *priv, struct clk *clk,
 				  const int parent, u16 flags)
 {
-	struct udevice *pdev;
+	struct clk pclk;
+	int ret;
 
 	if ((flags & CLK_PARENT_MASK) == CLK_PARENT_EXT)
 		return mtk_ext_clock_get_rate(priv->tree, parent);
 
-	pdev = mtk_clk_parent_get_provider(flags);
-	if (IS_ERR(pdev))
-		return PTR_ERR(pdev);
+	ret = mtk_clk_lookup_parent(clk, parent, flags, &pclk);
+	if (ret)
+		return ret;
 
-	return mtk_clk_find_parent_rate(clk, parent, pdev);
+	return clk_get_rate(&pclk);
 }
 
 static ulong mtk_clk_mux_get_rate(struct clk *clk, u32 off)
@@ -306,21 +312,10 @@ static ulong mtk_clk_mux_get_rate(struct clk *clk, u32 off)
 	return mtk_find_parent_rate(priv, clk, parent->id, parent->flags);
 }
 
-static int mtk_clk_mux_set_parent(void __iomem *base, u32 parent,
-				  u32 parent_type,
-				  const struct mtk_composite *mux)
+static void mtk_clk_mux_write_index(void __iomem *base, u32 index,
+				    const struct mtk_composite *mux)
 {
-	u32 val, index = 0;
-
-	/*
-	 * Assume parent_type in clk_tree to be always set. If it's not, assume
-	 * parent clk ID clash is not possible.
-	 */
-	while (mux->parent[index].id != parent ||
-	       (parent_type && (mux->parent[index].flags & CLK_PARENT_MASK) !=
-		parent_type))
-		if (++index == mux->num_parents)
-			return -EINVAL;
+	u32 val;
 
 	if (mux->flags & CLK_MUX_SETCLR_UPD) {
 		val = (mux->mux_mask << mux->mux_shift);
@@ -339,6 +334,25 @@ static int mtk_clk_mux_set_parent(void __iomem *base, u32 parent,
 		val |= index << mux->mux_shift;
 		writel(val, base + mux->mux_reg);
 	}
+}
+
+static int mtk_clk_mux_set_parent(void __iomem *base, u32 parent,
+				  u32 parent_type,
+				  const struct mtk_composite *mux)
+{
+	u32 index = 0;
+
+	/*
+	 * Assume parent_type in clk_tree to be always set. If it's not, assume
+	 * parent clk ID clash is not possible.
+	 */
+	while (mux->parent[index].id != parent ||
+	       (parent_type && (mux->parent[index].flags & CLK_PARENT_MASK) !=
+		parent_type))
+		if (++index == mux->num_parents)
+			return -EINVAL;
+
+	mtk_clk_mux_write_index(base, index, mux);
 
 	return 0;
 }
@@ -565,16 +579,37 @@ static ulong mtk_pll_get_rate(struct clk *clk)
 	return __mtk_pll_recalc_rate(pll, xtal_rate, pcw, postdiv);
 }
 
-static ulong mtk_clk_set_rate(struct clk *clk, ulong rate)
+/*
+ * Report the rate the PLL would actually end up at if asked for @rate,
+ * without touching the hardware. The requested rate is rarely hit exactly
+ * because it has to be expressed as a pcw/post-divider pair, and it is
+ * clamped to the PLL's fmax.
+ */
+static ulong mtk_pll_round_rate(struct clk *clk, ulong rate)
 {
 	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
 	const struct mtk_parent *parent = &priv->tree->pll_parent;
+	const struct mtk_pll_data *pll = &priv->tree->plls[clk->id];
 	ulong xtal_rate;
 	u32 pcw = 0;
 	u32 postdiv;
 
-	if (!mtk_clk_id_is_pll(priv->tree, clk->id))
-		return -EINVAL;
+	xtal_rate = mtk_find_parent_rate(priv, clk, parent->id, parent->flags);
+	if (IS_ERR_VALUE(xtal_rate))
+		return xtal_rate;
+
+	mtk_pll_calc_values(pll, xtal_rate, &pcw, &postdiv, rate);
+
+	return __mtk_pll_recalc_rate(pll, xtal_rate, pcw, postdiv);
+}
+
+static ulong mtk_pll_set_rate(struct clk *clk, ulong rate)
+{
+	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
+	const struct mtk_parent *parent = &priv->tree->pll_parent;
+	ulong xtal_rate;
+	u32 pcw = 0;
+	u32 postdiv;
 
 	xtal_rate = mtk_find_parent_rate(priv, clk, parent->id, parent->flags);
 	if (IS_ERR_VALUE(xtal_rate))
@@ -688,6 +723,143 @@ static ulong mtk_clk_get_rate(struct clk *clk)
 	return -ENOENT;
 }
 
+/*
+ * Pass a rate request on to the parent of a gate. The request stops at a PLL,
+ * which reports the rate it already runs at: PLLs are shared, so only a
+ * request made directly on one may retune it.
+ *
+ * @apply selects whether to program the hardware or only report what the
+ * result would have been, so that the round and set paths below cannot
+ * disagree. Both return the resulting rate.
+ */
+static ulong mtk_clk_parent_rate_request(struct clk *clk, int parent, u16 flags,
+					 ulong rate, bool apply)
+{
+	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
+	struct mtk_clk_priv *ppriv;
+	struct clk pclk;
+	int ret;
+
+	/* an external clock runs at a fixed rate: take it or leave it */
+	if ((flags & CLK_PARENT_MASK) == CLK_PARENT_EXT)
+		return mtk_ext_clock_get_rate(priv->tree, parent);
+
+	ret = mtk_clk_lookup_parent(clk, parent, flags, &pclk);
+	if (ret)
+		return ret;
+
+	ppriv = dev_get_priv(pclk.dev);
+	if (mtk_clk_id_is_pll(ppriv->tree, pclk.id))
+		return clk_get_rate(&pclk);
+
+	if (!apply)
+		return clk_round_rate(&pclk, rate);
+
+	return clk_set_rate(&pclk, rate);
+}
+
+/*
+ * Select the fastest mux input that does not exceed @rate, as the Linux
+ * clk_mux_determine_rate_flags() does without CLK_MUX_ROUND_CLOSEST.
+ *
+ * A mux only ever picks between its inputs: it must not retune whatever PLL
+ * happens to sit behind one of them, because those are shared - the audio
+ * PLLs in particular feed unrelated blocks, and a display driver has no
+ * business moving them. Linux sets CLK_SET_RATE_PARENT on these muxes, but
+ * relies on rate change notifiers and exclusivity that U-Boot does not
+ * have to keep that safe. A driver that needs a rate no input currently
+ * provides has to set its own PLL first, the one its "pll" clock names, and
+ * then ask the mux for the resulting rate.
+ *
+ * An input running at 0 Hz is never selected, as in Linux.
+ *
+ * Unlike Linux, the new input is not enabled before the mux switches to
+ * it, and a PLL reports the rate its dividers are set to even while it is
+ * powered off. The known users already set and enable the PLL they need
+ * before asking the mux, so this is fine for now.
+ */
+static ulong mtk_clk_mux_rate_request(struct clk *clk, ulong rate, bool apply)
+{
+	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
+	const struct mtk_composite *mux;
+	ulong best_rate = 0;
+	u32 best_index = 0;
+	u32 i;
+
+	mux = &priv->tree->muxes[clk->id - priv->tree->muxes_offs];
+
+	for (i = 0; i < mux->num_parents; i++) {
+		const struct mtk_parent *parent = &mux->parent[i];
+		ulong prate;
+
+		prate = mtk_find_parent_rate(priv, clk, parent->id,
+					     parent->flags);
+		if (IS_ERR_VALUE(prate) || !prate || prate > rate)
+			continue;
+
+		if (prate > best_rate) {
+			best_index = i;
+			best_rate = prate;
+		}
+
+		if (prate == rate)
+			break;
+	}
+
+	if (!best_rate)
+		return -EINVAL;
+
+	if (apply)
+		mtk_clk_mux_write_index(priv->base, best_index, mux);
+
+	return best_rate;
+}
+
+/*
+ * Only a PLL can change its own frequency, and only when asked directly.
+ * Fixed clocks and fixed factors report the rate they run at, a mux picks
+ * between its inputs and a gate passes the request on to its parent.
+ */
+static ulong mtk_clk_rate_request(struct clk *clk, ulong rate, bool apply)
+{
+	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
+	const struct mtk_clk_tree *tree = priv->tree;
+
+	if (mtk_clk_id_is_pll(tree, clk->id))
+		return apply ? mtk_pll_set_rate(clk, rate) :
+			       mtk_pll_round_rate(clk, rate);
+
+	if (mtk_clk_id_is_fclk(tree, clk->id))
+		return tree->fclks[clk->id - tree->fclks_offs].rate;
+
+	if (mtk_clk_id_is_fdiv(tree, clk->id))
+		return mtk_factor_get_rate(clk, clk->id - tree->fdivs_offs);
+
+	if (mtk_clk_id_is_mux(tree, clk->id))
+		return mtk_clk_mux_rate_request(clk, rate, apply);
+
+	if (mtk_clk_id_is_gate(tree, clk->id)) {
+		const struct mtk_gate *gate;
+
+		gate = &tree->gates[clk->id - tree->gates_offs];
+
+		return mtk_clk_parent_rate_request(clk, gate->parent,
+						   gate->flags, rate, apply);
+	}
+
+	return -ENOENT;
+}
+
+static ulong mtk_clk_round_rate(struct clk *clk, ulong rate)
+{
+	return mtk_clk_rate_request(clk, rate, false);
+}
+
+static ulong mtk_clk_set_rate(struct clk *clk, ulong rate)
+{
+	return mtk_clk_rate_request(clk, rate, true);
+}
+
 static int mtk_clk_mux_enable(struct clk *clk)
 {
 	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
@@ -862,6 +1034,7 @@ const struct clk_ops mtk_clk_ops = {
 	.enable = mtk_clk_enable,
 	.disable = mtk_clk_disable,
 	.set_rate = mtk_clk_set_rate,
+	.round_rate = mtk_clk_round_rate,
 	.get_rate = mtk_clk_get_rate,
 	.set_parent = mtk_common_clk_set_parent,
 #if CONFIG_IS_ENABLED(CMD_CLK)

-- 
2.53.0

