Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3358C5DF9D
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 16:47:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E6AD580D9F;
	Mon, 24 Aug 2026 16:47:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vizdSg7xJA6V; Mon, 24 Aug 2026 16:47:43 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787589956;
	bh=fMwwX0wjaGbPfILTlAay1EU0VhwLuv+VN3wxeP/afWY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=W9ZSKGBxqKlmg+TbQBU/VvCbMNBgoVA4Vyxhq8q7G1e4uRp0LaWT8Eudl3VKLHnRC
	 RM7vGkxUddq87WguhmiW0Uscf6JCQVb3mnjigm+lKW5ScDZx1qy/M0vWEMZAiHYCFf
	 Yqzh4qom9lR+xysccT/39Sri0oRp4RPKWDNX2APKKjh1B6InycuyM/Z37YVJK5NE/1
	 +wtr3tZRxQctDQPeLUEka1ER6kIQ2SB2IfuRYF1CcAN6SgzwgdHCpVzbGOD435qsiy
	 n12L5+SuqTn1tXprZET4EH9qG4JLRA0JXPR/GCJNA2gqTrMlV5a1EIApd7BbC3NUaF
	 Ol14GzwfpN7PQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5FCEC80DFC;
	Mon, 24 Aug 2026 16:45:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id D83AC2FD
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:43:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D572540540
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:43:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6uaJpov7JCoj for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 15:43:54 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::629; helo=mail-ej1-x629.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=pKLUjmjh
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AE8284053E
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:43:53 +0000 (UTC)
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-c15fc4707f5so29439066b.3
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787586231; x=1788191031;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fMwwX0wjaGbPfILTlAay1EU0VhwLuv+VN3wxeP/afWY=;
 b=pKLUjmjhNKqMD7sUyC4pW2uk7xM1FdVbQIl7fokfWG7WbSe/ePc+Mt2az8jjF54qIZ
 zcyKxDFVK/jEZSLetwoOa/04UI7sFogqMiAn9Gdtv1A1vujc/v4prSJ5S7MMRXWqD4mI
 vTUS2xkoDRP6veJk8yojU4R93g/kq3StMNX0zbAXdwA8f0Jm6NYlfS1cxGz4gFnUGXkW
 lwFkLi1LF3id837kCMvv2c5e2q2pbTHhPffDLTss2Gb9+xWcQve9/szlbiU4LnuxhnoV
 L6i1SL2OUUOz/KwQP9xTsYwB6bGT9LkCvckwqO+X9HpKrAG4TpuxOyCNZC9v3qxU72a0
 8XkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787586231; x=1788191031;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=fMwwX0wjaGbPfILTlAay1EU0VhwLuv+VN3wxeP/afWY=;
 b=mc+WdqRjSVAIacc6V49pcE0qsIG2MHpshcI96RWxDMxA+vtDAem9q3ACEBXjlgU+oi
 U4VkUWr9mydJRmTT3uK+c36530G/A3Ujxs8hHsxnM4rNaENFCRT9/PsCi56CCJ2ACW8/
 tmDPeboW7WHUwZX+lxt4yMAJwoJa91VSlUsm1WsJvW9yEdKd/M4cQPiW7BN3AXxvJtlf
 bI1O+yLkt7gcZRUkYu164+3IvODH3BRoNGRmVCeOrT3oM9tSSCUYv63k1U5jBF9mbctY
 HbWpDssSbQ+t6EgqtNxWBV6uIi1q9b6I4xWLJz8tYkYrERNmdJPd2twTdcjSaE8+WtMk
 WpJw==
X-Gm-Message-State: AFuF++nHRh15IUnrEk6FcRKHBrEIn5FT4H/VsU428k9Ptn+PDGMYW2ya
 u4x0R1Zecwuk9OVPmhqLGDMBnOhYLs93hmzxWDFUykGVTugQhCW8Z0pQp2t74bGizx6PdC+SNlw
 nr+YC
X-Gm-Gg: AR+sD12m9d45v2YXdfx541UFejNVu6J10PxL1gfghYGi6ja+q1ktWz2yrUED1hbCmZU
 Z1Oq08Q0WpmAwW4wtrMwxA8+PLRW7yEYlU7vtbVtxO6SUpdrGDE2MHFnt9PkLCjIJvcWr8GcbgD
 rJSBN0sG8NQdAnxsCHLtY6/vqKcQ3otXvSmcW8NG08IoMbrrJnsJnMs+Ar26SfkzJvrIPc46iTg
 Zx1ZjVG1naOTaHg2kMVJFdIbwY6FMgEtr5KfeGnno5Vd8rEtyJiEIcPXiWDQuPfAP0QFGhQFAZD
 D60HXItqSo3gZBaTievwcYAEIbfrgFkHJkUi81fPSX9dCLJWZvY799IYWzwQeDpEluBXO5ApvGL
 5Sv3cuZdx2Z6mT4qo/+/8WZUUL2QJwWFoDja65dD0QIuM7v+y4ymPn/muPRWZ8ue805Ox5yCuLU
 C+zWfcgXFuz82MlDBu6XGj36w7iYCVxrhRo2iPhZtGM80pbGzHeJkYiEeKnWIxOz0+BAcKvywB6
 55zBIAQYyAKfhXhZeKrE+/EWIwHFS2I
X-Received: by 2002:a17:906:4790:b0:c12:6db4:4bf4 with SMTP id
 a640c23a62f3a-c2469f9902fmr1692173166b.0.1787586231225; 
 Mon, 24 Aug 2026 08:43:51 -0700 (PDT)
Received: from monster (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c24968ba7b6sm1268749166b.62.2026.08.24.08.43.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 08:43:50 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@denx.de, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Anders Roxell <anders.roxell@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Subject: [PATCH v7 20/24] usb: musb-new: set endpoint capabilities
Date: Mon, 24 Aug 2026 17:41:29 +0200
Message-ID: <20260824154133.217744-21-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260824154133.217744-1-anders.roxell@linaro.org>
References: <20260824154133.217744-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 24 Aug 2026 16:43:55 +0000
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

musb-new sets maxpacket directly and leaves caps empty, so
usb_gadget_ep_match_desc() rejects every endpoint once epautoconf.c comes
from the kernel.

The shared fifo endpoints need both directions, the others only the one
they are wired for. The kernel driver already gets this right.

Take the caps and the usb_ep_set_maxpacket_limit() calls from the kernel
driver.

Compile tested only.

Suggested-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
Link: https://lore.kernel.org/u-boot/87v7az6l03.fsf@kernel.org/
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/usb/musb-new/musb_gadget.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/musb-new/musb_gadget.c b/drivers/usb/musb-new/musb_gadget.c
index 7daff5850f19..cb55f9ab458e 100644
--- a/drivers/usb/musb-new/musb_gadget.c
+++ b/drivers/usb/musb-new/musb_gadget.c
@@ -1841,17 +1841,32 @@ init_peripheral_ep(struct musb *musb, struct musb_ep *ep, u8 epnum, int is_in)
 	ep->end_point.name = ep->name;
 	INIT_LIST_HEAD(&ep->end_point.ep_list);
 	if (!epnum) {
-		ep->end_point.maxpacket = 64;
+		usb_ep_set_maxpacket_limit(&ep->end_point, 64);
+		ep->end_point.caps.type_control = 1;
 		ep->end_point.ops = &musb_g_ep0_ops;
 		musb->g.ep0 = &ep->end_point;
 	} else {
 		if (is_in)
-			ep->end_point.maxpacket = hw_ep->max_packet_sz_tx;
+			usb_ep_set_maxpacket_limit(&ep->end_point,
+						   hw_ep->max_packet_sz_tx);
 		else
-			ep->end_point.maxpacket = hw_ep->max_packet_sz_rx;
+			usb_ep_set_maxpacket_limit(&ep->end_point,
+						   hw_ep->max_packet_sz_rx);
+		ep->end_point.caps.type_iso = 1;
+		ep->end_point.caps.type_bulk = 1;
+		ep->end_point.caps.type_int = 1;
 		ep->end_point.ops = &musb_ep_ops;
 		list_add_tail(&ep->end_point.ep_list, &musb->g.ep_list);
 	}
+
+	if (!epnum || hw_ep->is_shared_fifo) {
+		ep->end_point.caps.dir_in = 1;
+		ep->end_point.caps.dir_out = 1;
+	} else if (is_in) {
+		ep->end_point.caps.dir_in = 1;
+	} else {
+		ep->end_point.caps.dir_out = 1;
+	}
 }
 
 /*
-- 
2.53.0

