Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E04CCC5516F
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 16:36:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0890A80F35;
	Fri, 31 Jul 2026 16:35:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XVqiRAPKHISa; Fri, 31 Jul 2026 16:35:57 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 24E3980E71
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785515757;
	bh=JMJuC/VlGCp4KPJX3NmfQmEYWwewgE8Bt3N5NIsEbaA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=z3kUhz6+aPuMs3b53Rsv3kvvfo871nLSAoYKU9iqBe2SWrkzm4H82QY+ljikjiFGt
	 b6gR6PV/MV9Ly1Yx2UoDVVHfq2M/YqUEvPaL+AWLhy4SFmX444PjT5pCebpzuG5rIZ
	 t5uFjgYhkZhFV1qkogJ3lY1xVVeMp8kc2syay0Ari1Qd6oNirbYznNbobPUxxi9z8n
	 suo2S7/P8Nyj9+a54DC+S/Gu0u/6vY64cddngkRg+i+eblaYoSKEGtIIQqKdbK1Qqk
	 cb4NU9Fzdcs9+Luq1ZjHqYQekk6S8EkrwaXeyIqCvy7QL49RX5qKROvocW1OkUw73F
	 pR8tUanZjIc7Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 24E3980E71;
	Fri, 31 Jul 2026 16:35:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 68569282
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 16:34:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 66DE440708
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 16:34:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Iw7dJoB8VqkN for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 16:34:07 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::a29; helo=mail-vk1-xa29.google.com;
 envelope-from=ralph.siemsen@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org A700E4061C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A700E4061C
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com
 [IPv6:2607:f8b0:4864:20::a29])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A700E4061C
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 16:34:07 +0000 (UTC)
Received: by mail-vk1-xa29.google.com with SMTP id
 71dfb90a1353d-5bfaf91daa2so341012e0c.0
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 09:34:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785515646; x=1786120446;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JMJuC/VlGCp4KPJX3NmfQmEYWwewgE8Bt3N5NIsEbaA=;
 b=mgPKbGm1zztcQ+Z2lMYvoXWDpQc3mOZTeZNrlhQ+L9VyZDeVFFnJmmC+aVrYMrVJFb
 /h/aeaAOw0Gi2Dm7zsKv9u9t2y8TwCRrmB3sji7AhOAKGYOR/57fLR4i3McbJqyE5rH3
 aANvLCVuIusHAh1u0kNvHhv94sKn8nlyV7Edn9hkLY9L3LGd2bX3bX72rHwZ6PaOezP+
 mH5LATQM74Be4q2UOUWBlx52Dn8KZRzw6cP23svjUwmQ4g5eKsbsbnASU1Eh+n8J+2ia
 VFTkKk9dwi2q2C0xQ5lnpWpVnOFtu+lJ/jVW/l0QzXfKmWlQljq/R4wZ+M6O+lgyZGLL
 yZ8g==
X-Forwarded-Encrypted: i=1;
 AHgh+RrVvk8mGfA9z/8ae88n+TLAl1ynXpPTZd4w7S7ds8ncxmJ+ymEBxxi1BtHt63QNf9l6AGoYHPA=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzF7edVdlS2+GhdSrgJBeiLY3Sf61cWEcK9ig7V2iNveq250ZAB
 O1yFFNTzqzqZTJoM4+zBJ3AlRDs0WmUk+vrsQe/g2i/HoJnNhy+Bu+UINBbmhiOWYRc=
X-Gm-Gg: AR+sD11ABLpFdXADuqGe+uZfb968V6RfpV/PguImIY99RM+vmOgYZfZu/1nY7eJuUsQ
 Ytc//Rmlj713qXNwmZiNfGfLcz9rkF70s2qX0YniaTROeOEOMD2l/x0KAo9wehfYKVRrEH90sTr
 X0ReaNRSTXdYWRiTF15hMsR1Ioz+hh9QlGZqwwWOR0Y+TIy19UhVUAg2hBeyApkLWIxCPws62SD
 ITCWfGL82hCfhEdbuTrJ0+hXgj3154+29EQbh6//Tprnwt8jG9rUPcm076ChrWHCHL89mgtu4yL
 S/1wc/2IwaVQmvgD1X3K0fscIDJ6unJbZ6sYpitud3VXFEf1+EvlpMuBp5TFvPKonAOvW1TtBW1
 tjeDkorVl6qUGv9wcMQtwEAtEZdo7bHVsZuVqhcoXdw6+Rx0pxR5Os7yKsRQHPLdziHEf/tk7iM
 IWQeBPxC2SC0giMhHLy3VClpABoUwqQhXhsDM+9VPlHPw+Y0b1pW2lnzen4/pjeZUs5sduewDzb
 2hig0wr/1XSlghCdHQUtN+Pq0tG+EcPpXVXNzGGx0osuHVsWKXMsDtW7MiI
X-Received: by 2002:a05:6122:8b10:b0:5bf:6bf4:b215 with SMTP id
 71dfb90a1353d-5c38761572bmr264265e0c.2.1785515646118; 
 Fri, 31 Jul 2026 09:34:06 -0700 (PDT)
Received: from maple.netwinder.org ([198.58.133.142])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-977e5eb9f77sm1084778241.0.2026.07.31.09.34.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 09:34:05 -0700 (PDT)
From: Ralph Siemsen <ralph.siemsen@linaro.org>
Date: Fri, 31 Jul 2026 12:33:36 -0400
Subject: [PATCH 07/17] net: designware: add r9a06g032 compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-rzn1-2026-07-v1-7-af2ce80db9d8@linaro.org>
References: <20260731-rzn1-2026-07-v1-0-af2ce80db9d8@linaro.org>
In-Reply-To: <20260731-rzn1-2026-07-v1-0-af2ce80db9d8@linaro.org>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 u-boot@lists.u-boot-project.org
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Senthil Nathan Thangaraj <senthilnathan.thangaraj@amd.com>, 
 Abbarapu Venkatesh Yadav <venkyada@qti.qualcomm.com>, 
 Padmarao Begari <padmarao.begari@amd.com>, 
 Naman Trivedi <naman.trivedimanojbhai@amd.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Sean Anderson <sean.anderson@linux.dev>, 
 Boon Khai Ng <boon.khai.ng@altera.com>, Ye Li <ye.li@nxp.com>, 
 Alice Guo <alice.guo@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Robert Marko <robert.marko@sartura.hr>, Jim Liu <jim.t90615@gmail.com>, 
 Ben Wolsieffer <ben.wolsieffer@hefring.com>, 
 Stanley Chu <yschu@nuvoton.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Angelo Dureghello <angelo@kernel-space.org>, Anshul Dalal <anshuld@ti.com>, 
 David Lechner <dlechner@baylibre.com>, Daniel Palmer <daniel@thingy.jp>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Phil Edworthy <phil.edworthy@renesas.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Udit Kumar <u-kumar1@ti.com>, Hai Pham <hai.pham.ud@renesas.com>, 
 Johan Jonker <jbx6244@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Ralph Siemsen <ralph.siemsen@linaro.org>
X-Mailer: b4 0.16-dev-401aa
X-Developer-Signature: v=1; a=openssh-sha256; t=1785515625; l=949;
 i=ralph.siemsen@linaro.org; h=from:subject:message-id;
 bh=Vgcsu1+pIApcCh/KcLl/+6FkxJcRgm6ojt/tRbntkPk=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgG/ALfT0jfT5dAzjFlh+rTh9j4pAiw
 vPQ/tR3mihuAFYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QI/sflNsMit8xZA0VH8iwR1yNxdLWqBDqsSI8s3ukqdlyvw6IiLSAxpTWRUqZIsYcVQVISAIdiU
 ye2538fsd1Ak=
X-Developer-Key: i=ralph.siemsen@linaro.org; a=openssh;
 fpr=SHA256:12SQdavZEBUxPbBBtqQJgZ9F8vSvwTB6kFlSNgb4IcM
X-Mailman-Approved-At: Fri, 31 Jul 2026 16:35:45 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785515646; x=1786120446;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JMJuC/VlGCp4KPJX3NmfQmEYWwewgE8Bt3N5NIsEbaA=;
 b=gevcHY6S/SGlR52t5342mOeDyrncyPE92yXZx5JS+SYVb/G0tVHwVaiYVDCe631g4S
 PFs2vmYAXW0jlZon381IlxC93t5/zxs8Aix8IbnNUvQivig3pk01oe+71iZA2YqkYTcr
 PMARCFczTllRTDnomJEr4RQnkIxyMPOKmt5fOu/jf3T36fACDB0ayjEwDnt54rVRTCDR
 D7Umv1UxmkNnu5Gnoxhyrn7rMHs0WOSCR0afGXPYGyMIwI6Cswzo/E9YYRqq1EhM1iSQ
 quTS+marCqc1BAN3wAxsoBy0hi3IGlJYjIl9XW3EGILMqAWxaLd/oFT370e8ENJ+h2kQ
 n5CQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=gevcHY6S
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

The existing Designware driver can be used on Renesas RZ/N1.
Add the corresponding compatible string to the driver.

See corresponding Linux commit
d7cc14bc9802 ("dt-bindings: net: snps,dwmac: add "renesas,rzn1"
compatible")

Signed-off-by: Ralph Siemsen <ralph.siemsen@linaro.org>
---
 drivers/net/designware.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/designware.c b/drivers/net/designware.c
index 6ed9c6d538a..650d47036aa 100644
--- a/drivers/net/designware.c
+++ b/drivers/net/designware.c
@@ -1059,6 +1059,7 @@ int designware_eth_of_to_plat(struct udevice *dev)
 static const struct udevice_id designware_eth_ids[] = {
 	{ .compatible = "allwinner,sun7i-a20-gmac" },
 	{ .compatible = "amlogic,meson6-dwmac" },
+	{ .compatible = "renesas,r9a06g032-gmac" },
 	{ .compatible = "st,stm32-dwmac" },
 	{ .compatible = "snps,arc-dwmac-3.70a" },
 	{ .compatible = "sophgo,cv1800b-dwmac" },

-- 
2.55.0

