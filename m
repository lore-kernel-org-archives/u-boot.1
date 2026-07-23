Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BB54C531CB
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 09:09:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 433C340818;
	Thu, 23 Jul 2026 09:09:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OTsWFPKBr-Ts; Thu, 23 Jul 2026 09:09:48 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0E8BE407A8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784797788;
	bh=oI3rZV8lDoDDJsh2GT0ahytxXDhm/J1K52CFnZZKgSg=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=gJwYnD9OJlnH1updObMbFfWCkuPUElJBMAS5B9FTaKj1WEIOFaSM5r4KNkrQ4MJzU
	 bFd8sd1ELagNdE+W+jfwpVdkhq52C2ukGL3SpMr8/LYyDh7NIWY4h/74L2W7zSahFF
	 bAg5kSzk71EtDKBUVyyVrKeUPvZRbojOi7teeDcuT87Yy4k/Ndc0FfabgOGsj96hTT
	 56kiizz5e5iUKC6XmP0gxerxa00odMDgETGpT4rGU+wEWukejCYSPt0SSXsrU4XZhp
	 oBxOxmwPPq7rnjL92MSmpO7aPvQzzJoVXpt8mbn+HKI60+hTwB5eofI2cGy3rrEvjp
	 12QQIxWMAdkvg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0E8BE407A8;
	Thu, 23 Jul 2026 09:09:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0371F707
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 09:09:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 00E9040243
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 09:09:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pzOYCSn0B7cP for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 09:09:46 +0000 (UTC)
Received-SPF: Neutral (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=romain.gantois@bootlin.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org B735F400DB
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B735F400DB
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B735F400DB
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 09:09:45 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80BD68404D; Thu, 23 Jul 2026 11:09:43 +0200 (CEST)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BA4E803F6
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 11:09:41 +0200 (CEST)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 3DC041A11A3;
 Thu, 23 Jul 2026 09:09:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 0F0C5602B8;
 Thu, 23 Jul 2026 09:09:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id B618711C102AA; 
 Thu, 23 Jul 2026 11:09:35 +0200 (CEST)
Date: Thu, 23 Jul 2026 11:09:22 +0200
Subject: [PATCH v3 1/2] linux/list.h: Add list_is_first()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-rzn1-usbf-v3-1-34dd7c4ddd99@bootlin.com>
References: <20260723-rzn1-usbf-v3-0-34dd7c4ddd99@bootlin.com>
In-Reply-To: <20260723-rzn1-usbf-v3-0-34dd7c4ddd99@bootlin.com>
To: u-boot@lists.denx.de
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Marek Vasut <marex@denx.de>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, 
 George Chan <gchan9527@gmail.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Herve Codina <herve.codina@bootlin.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Ralph Siemsen <ralph.siemsen@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Peng Fan <peng.fan@nxp.com>, Kory Maincent <kory.maincent@bootlin.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Philip Molloy <philip.molloy@analog.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Romain Gantois <romain.gantois@bootlin.com>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bootlin.com; s=dkim; 
 t=1784797779; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=oI3rZV8lDoDDJsh2GT0ahytxXDhm/J1K52CFnZZKgSg=;
 b=zapmvsysw4IebEZBz/cdP2LucCs9s2kjcYI806KWMz6p0ZPrsFIQ9gd6f8hRFWWSXmqQFQ
 XoN6LuYBONt3UjOzov0Cg358qj7yRl6c7p2856siStB0+DeOneg0XYcptV7JU6W9d60q0j
 kbrjuKIAZatjHps2J1v411JF+d2UDyiHAlpROcSxKXyNP8Otao3hpmAkUpHtHlqmBVWLJf
 NFYvCEjH3oXkaSNa5qZIW39s2VAPWni0SFvBoxdQPgdCipLApg0sQjaVLW7d3gL4P6F1TN
 AdRtwzV03OtBk1Y6dSXV4VKJyyqPpHmAIORt1SasoVJdlxcvof9m7eDUYmPLOw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=bootlin.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=zapmvsys
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none)
 header.from=bootlin.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=romain.gantois@bootlin.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="zapmvsys"; 
 dkim-atps=neutral
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
From: Romain Gantois via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Romain Gantois <romain.gantois@bootlin.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Include the list_is_first() kernel function, which will be used by the
Renesas USBF driver.

Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Herve Codina <herve.codina@bootlin.com>
Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
---
 include/linux/list.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/list.h b/include/linux/list.h
index 3dc38279716..dc788b1cb69 100644
--- a/include/linux/list.h
+++ b/include/linux/list.h
@@ -153,6 +153,16 @@ static inline void list_move_tail(struct list_head *list,
 	list_add_tail(list, head);
 }
 
+/**
+ * list_is_first -- tests whether @list is the first entry in list @head
+ * @list: the entry to test
+ * @head: the head of the list
+ */
+static inline int list_is_first(const struct list_head *list, const struct list_head *head)
+{
+	return list->prev == head;
+}
+
 /**
  * list_is_last - tests whether @list is the last entry in list @head
  * @list: the entry to test

-- 
2.55.0

