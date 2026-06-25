Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FB60CDB466
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 09:05:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBBE48495E;
	Thu, 25 Jun 2026 11:05:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="isWacYhL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D5728495B; Thu, 25 Jun 2026 11:05:46 +0200 (CEST)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A598847C8
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 11:05:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=romain.gantois@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 2F25F1A0991;
 Thu, 25 Jun 2026 09:05:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 016055FF03;
 Thu, 25 Jun 2026 09:05:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 40543106C8077; 
 Thu, 25 Jun 2026 11:05:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1782378342; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=eySjExOnmflClqC+pSLXwW/7fs4WUj/GExAZZAKppiw=;
 b=isWacYhL9UzNYdvlh9b4ccdeIC42fBhG0OYHi7iqT8n0/BSVTLBQeAZvCb/vlxPq1J/Zrm
 VlOvSYq6SUBy9f3mbIYZFVkTBNDfVnw+0wf6IOPzlaVFXw3ujZmlNFUhvB8m4iBe1pCG3A
 IvZn9zm8QKJ/DbdDmZAT0fSI63b4TsnKi0BvvLYdMKpCfs1yNPZD8AA8tJGsWtRFaS2g0L
 48dUV+ajfJMj7t3PAsxttFjLM8E0Dd7tyLdIdb5py956A8/qixMcEabe9gZL/KgwTOYhZE
 DJ7FUPk5tYx6CIW6Yj9stTngbHKDXFHM2z529w2RnGNNCWnDOdNEDG72TSMdGw==
From: Romain Gantois <romain.gantois@bootlin.com>
Date: Thu, 25 Jun 2026 11:05:25 +0200
Subject: [PATCH 1/2] linux/list.h: Add list_is_first()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-rzn1-usbf-v1-1-0e1a38f7b82c@bootlin.com>
References: <20260625-rzn1-usbf-v1-0-0e1a38f7b82c@bootlin.com>
In-Reply-To: <20260625-rzn1-usbf-v1-0-0e1a38f7b82c@bootlin.com>
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
 Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Peng Fan <peng.fan@nxp.com>, Kory Maincent <kory.maincent@bootlin.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Philip Molloy <philip.molloy@analog.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Romain Gantois <romain.gantois@bootlin.com>
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3
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

Include the list_is_first() kernel function, which will be used by the
Renesas USBF driver.

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
2.54.0

