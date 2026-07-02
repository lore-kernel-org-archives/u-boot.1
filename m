Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0CB6C43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 08:39:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2683584CB3;
	Thu,  2 Jul 2026 10:11:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="QjNmO7eD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8B0784CBC; Thu,  2 Jul 2026 10:11:24 +0200 (CEST)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D324F84C85
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 10:11:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=romain.gantois@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 741411A0DD5;
 Thu,  2 Jul 2026 08:11:22 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 3FBF95FF03;
 Thu,  2 Jul 2026 08:11:22 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 22D1B104C960E; 
 Thu,  2 Jul 2026 10:11:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1782979881; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=85SHqB9B4K72qA67HQGS3aWLfO5vNkClSRC2t6j4m2Q=;
 b=QjNmO7eDt31bH7fhgM6BsdDiKMyPpQPstELC9W1THYw0fQM+WbmEXqudcTO97/2EmHmKrB
 tFrG1ovkboQGhHcklfcmBTA1t8R2enrcl3CKBBzRz99ywVGxNZYS4g3qVb49ebe7ZBIsvY
 zXNDCzPYFG0ATv997/dUWpECjFJHx0BiOh+7Xf6FA6OOWKY9oVpTiKwj2mB8G75yQa5QsO
 bttyPG9RNuEpqS9LsHyI0WuIPoRIx+xdZkUaEkioOYFp8nPMS4vYRx0TaT+PC1jnupp+xs
 XGaGI3LCWrz8+l6inMeZOXOwAGzGTLVxdZkYuOhzBgYPVvOlW4KVXKyfXsQ8tw==
From: Romain Gantois <romain.gantois@bootlin.com>
Date: Thu, 02 Jul 2026 10:11:08 +0200
Subject: [PATCH v2 1/2] linux/list.h: Add list_is_first()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-rzn1-usbf-v2-1-00ceecebaea6@bootlin.com>
References: <20260702-rzn1-usbf-v2-0-00ceecebaea6@bootlin.com>
In-Reply-To: <20260702-rzn1-usbf-v2-0-00ceecebaea6@bootlin.com>
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
 Johan Jonker <jbx6244@gmail.com>
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
2.54.0

