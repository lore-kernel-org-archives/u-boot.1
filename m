Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183F9606A32A
	for <u-boot@archiver.kernel.org>; Sat, 21 Nov 2026 12:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=qldE1VEW;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=OPgDVwVO
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B8F6B40AA1;
	Sat, 21 Nov 2026 12:35:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aw6S3pojyvnT; Sat, 21 Nov 2026 12:35:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 23A0040D5F
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795264522;
	b=l2/T2T1DuIiXOT8uZF3LHz0fHZt8ujL78rjK6xfvjYrXkQe5rotPwlcm9qcbRute7MA9
	 ozMlSTEYXyrI8FyEz+3OBdDR3aq1HUqAA8HHLeuOEa0r5PwigphztYTWlvegxvpYTEuBp
	 jJvBQWb7TEv/AEYQXrqcmLA9T4GiNt7Kk9GmwWJekw+BUfylUHERX6X3DlBHmIftNivg9
	 D0l2bYBdJVnFx+JVvAoo8hLANfigt14mv1TsokuhPhwzPvJFPARwi6BOaKmD1Br1QK3Qg
	 v8uFI3CmJSh1s2hLdwkjgz64wNx9FeA7U91ZhKmin2Tkpp+ba02VqF5MegEslU92LUQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795264522;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=YSD9g6FFXv0vRxyn/97d+a5eAOdcqaL2sKElpiqE8M8=;
	b=bjF/MMD2MVCqpQ4MBaLgna4k6HE5Oo4lte9DPDYmtCjjHMjzsbuBAJyf3AocOQnJZs0z
	 kmq8hfBkFadSeY+poNu5YciwSBj91IH6PcKXVDN/av9TwIu8OPnmL4h/swjY/b/O1Xvcu
	 RmsPcu2OD1YUagENzSmg661D0fsSWf0HZEnTtT2atvE7OxHmC1rbqYsmFEZEh8WMHp10v
	 x0HYGPapZQCtfFAboG0ksn7L7KTFoUujaCus3+ZztD5khQ4bWJS3yWhDxc/EuQXOB/O0o
	 Jz4w8jp0HxnrP5Xpza739fdqVIjBTBrfwBtu6+iQLKtU9qiKKfnVBqIUu7S5508mhdQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795264522;
	bh=YSD9g6FFXv0vRxyn/97d+a5eAOdcqaL2sKElpiqE8M8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qldE1VEWdGKZuogLcN55VmRqsGe9lD/3JR9fU54Jb/sfrQKnGk1L8U0Alrpa2g7uw
	 vYRfrd0aRvbXP44UyZU0R+KJ0YODfQ/APIYGO5z5xvzdRVipYuKLmgSai8X4a29UPg
	 iStsbkSDqNQ1AF3zqrgYZ41HHiewnSPP0bmvGE6EJeCNZw9u0bcqglhEDrSiGiLQdp
	 2IL9gEX8A+MyhmKqVvpyF4lwiU+4awogWZktZlJ0a8RPtn+Ot/FVWj3oOl6OPAxbU6
	 PRsfV9rQO6T0jnIj7U/tW0RkoPzGlkjMc5emJLNokyeMH18VAqoX9fVIeeKaOFgEIs
	 LiZIRW+bHunCg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 23A0040D5F;
	Sat, 21 Nov 2026 12:35:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 638D7465
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 12:35:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 44F04606E8
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 12:35:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1CahRGjAbVW1 for <u-boot@lists.u-boot-project.org>;
 Sat, 21 Nov 2026 12:35:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0781960666
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::436"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::436; helo=mail-wr1-x436.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=OPgDVwVO
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0781960666
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 12:35:15 +0000 (UTC)
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-4a42b34e930so1532267f8f.2
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 04:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1795264514; x=1795869314;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YSD9g6FFXv0vRxyn/97d+a5eAOdcqaL2sKElpiqE8M8=;
 b=OPgDVwVOkqrDXPE0VfPK2saIV958memu0xuYxAX3wZm0XIBHAIK1H55Evtt+m/KDGT
 o9Y3a3OL1ZGM3TI2VQiPzzsgzd/fWib0kM4AEp41kiH64Kf1vhg3qOVtEp60V14y/ux7
 1ZWIPojVu77PQK+Tokb6dLOg3KmGHhBn37npA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795264514; x=1795869314;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=YSD9g6FFXv0vRxyn/97d+a5eAOdcqaL2sKElpiqE8M8=;
 b=V1DK085V3PsqqsiqmXkkjnmJzbaHiPtRK4Jlm5Y6Y1ZZHVJqkbZNDDZszsz85GG3sR
 PcrmKIqSCpOIbPVS1fJYzVnmdE+B3JE7pCARC1R6UE6pjFGaSJT5PvJTa9vkK/lTmz6x
 za5o+o9piiN1HBo+JCgDIYI1AxSxln19tBO1jVG2XC3OLfe2lABiCxVp0umS1Jv68sDt
 LszTrhIaOHWVRgrTwCasWmU0izAu7gRzsvKnXfELXRLCcyvr9ABK4inqdSDCSK6B7rTf
 HZK+98Qtz4/w39fcgW1VREzN+iBCe80CBhjFEGLuc+KtNfXD45ScmYykQy3DRyclL1Ep
 ft/g==
X-Gm-Message-State: APuU4Z+HLjZzdOQ42EP2W8/8iVOMYPdz0lUWLHzvRJqyWalij5pXlHNZ
 JEQdTr5BoAxfFlnQwr+H3tqihOoNWxUKN+FId/XPGP96Dfc0xFAYVqcFrXOZjlvx+K0E3vSPQfm
 CjU5G
X-Gm-Gg: AZFdTZdmp3o4vFoaTFkSAqHlWHrXvjkFYLmn7+hKbA28+WIyIgW98fc7aL9a9tJXo6k
 AytyYOqmiB8A5ZKpGC7wk2zSg+sAtW8m47m3IfUHEk/+rrLRyt3ZBsd6JujESk3YbN7WVIp01ji
 UURuiP87PajGvj4FvYPqpcFRPacUrylDSDyXqHfz9xkkpLCsiZA/ARgyp8jN/yvTle73dEQ397q
 RhdJVnSIx/Y1hatW/zVt/Z9pBlPgFuKWr4ySw4YOatZp9cDUVQNM/ve2vddQLdYThjKAuuPaTbZ
 1IYtNdatsPYIF3mowjqBlcUGMd8MKwtt+fsgo581+oK2ZGERliao0HThbH+F9nuaaasEKYIWpQY
 erpwaoOxAoofLKEBBD7p1/G9hLdS3Da5GEL6tXDhxLSHdQb0ltjnetRa9e+gch2sLg3IY1SC2Cj
 lHM8FNyn1vMXlhRjN1p18E8Vj743peY7DMKlAFPpJw4PTTaDPmznlGKquPbLmbVVqbi3DF+ARyx
 z4af7qhpNk7/2kDDDbKyteS6pjeL9MQmYsURI/c0/v1wRUdBXWuojIQovMnHxjTqMWh/xO41bF7
 cqCYoQIaaqcykFsFUW2UF7pO0/XEuWvfgeDZM596j7G22YT9jecl23/bMa025SPYqi8doB/eYtD
 Z1c1YXPetYMi/ybqh4DtuEaAxBVpS69eurFojv3KcvbinwXK2xW7/se98DdAW1y8qNlcx0O1ZE3
 rgnNNHuwn2sWYRBGZw/Uzefb++7g==
X-Received: by 2002:a05:6000:2506:b0:48d:ba3b:af36 with SMTP id
 ffacd0b85a97d-4abb47b0f64mr15021069f8f.37.1795264514017; 
 Sat, 21 Nov 2026 04:35:14 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab658e2d1bsm11720564f8f.8.2026.11.21.04.35.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Nov 2026 04:35:13 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Heiko Schocher <hs@nabladev.com>,
 Michael Trimarchi <michael@amarulasolutions.com>, Ye Li <ye.li@nxp.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 09/25] video: dsi_host: add disable host interface
Date: Sat, 21 Nov 2026 13:33:59 +0100
Message-ID: <20261121123451.2471185-10-dario.binacchi@amarulasolutions.com>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Michael Trimarchi <michael@amarulasolutions.com>

Current operations structure has provided disable callback, but
there is no API from dsi_host uclass to use it.

Add this disable host interface, so that dsi bridge can call it
to disable host

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

(no changes since v1)

 drivers/video/dsi-host-uclass.c | 10 ++++++++++
 include/dsi_host.h              |  8 ++++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/video/dsi-host-uclass.c b/drivers/video/dsi-host-uclass.c
index fde275ad7e2e..745991f8dd94 100644
--- a/drivers/video/dsi-host-uclass.c
+++ b/drivers/video/dsi-host-uclass.c
@@ -34,6 +34,16 @@ int dsi_host_enable(struct udevice *dev)
 	return ops->enable(dev);
 }
 
+int dsi_host_disable(struct udevice *dev)
+{
+	struct dsi_host_ops *ops = dsi_host_get_ops(dev);
+
+	if (!ops->disable)
+		return -ENOSYS;
+
+	return ops->disable(dev);
+}
+
 UCLASS_DRIVER(dsi_host) = {
 	.id		= UCLASS_DSI_HOST,
 	.name		= "dsi_host",
diff --git a/include/dsi_host.h b/include/dsi_host.h
index 83f8839db68d..5873ab698d9e 100644
--- a/include/dsi_host.h
+++ b/include/dsi_host.h
@@ -70,4 +70,12 @@ int dsi_host_init(struct udevice *dev,
  */
 int dsi_host_enable(struct udevice *dev);
 
+/**
+ * dsi_host_disable
+ *
+ * @dev:	dsi host device
+ * @return 0 if OK, -ve on error
+ */
+int dsi_host_disable(struct udevice *dev);
+
 #endif
-- 
2.43.0

