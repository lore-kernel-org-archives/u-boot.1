Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76D361125839
	for <u-boot@archiver.kernel.org>; Wed, 11 Mar 2026 14:25:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BC4184180;
	Wed, 11 Mar 2026 15:23:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="XFjOHZlS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A9418407E; Wed, 11 Mar 2026 15:20:53 +0100 (CET)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 572C084010
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 15:20:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=fairphone.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=luca.weiss@fairphone.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-6615c766e60so10683954a12.3
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 07:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1773238851; x=1773843651; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QUkvLncpobMGDhoXgKoOEevHd602vqLboY4VefW6oMI=;
 b=XFjOHZlSuHNM90m4ccBaZV8vOPJipaTWx6vONsEz26NVZ1/q99EgfciJLo92Ek8iCQ
 mvbtirlqIzDaWnRq1Ykdl437YFDIWd9oa4GPKgDG4GDhYNZQFm7MAtirSG4+V9ipHHEp
 /Gzrbg3lO0ngVmk98DfyalFbxz0eqRDfYXZDeynyHEKrVSchILnbUqnGrmsssg++mEO7
 54YaZ9zK0eHxPLbS5w8TJXrJk4lhZeL6+lJ82a8shng2ez90/QwUUhVkleMvUaBxqDNs
 xDDz1Z2caqNgFAH94iMgWcOB+jyemJY8S4Eyy6LQVTM4NI0k/ZmEUzsZANe02kaqbajq
 HBHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773238851; x=1773843651;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=QUkvLncpobMGDhoXgKoOEevHd602vqLboY4VefW6oMI=;
 b=VH+gC+ruMe4TtILDeRWigeqx3bfPWAnXj3pQBOWg2Tqfv3IyDVyEF/sGFFvm+yezDE
 7wTf/Jy90fBaYpDW0zdjyrV1/qrTAakWFjpB9qwcxljN+xe2UDBpKzgW7jvaIlF5CY+/
 H+P7aibbfbnuncQt0PJQfxB1gmhVft5vxIEIsfHYsTmeHKHDo+TM5oIiVq5B79MFqR6D
 Qft40LHxyGkd87H277JWc2NdgpYGJCrOFBZvJ7sFyxBoT6OBWNXAEWQaXIj+qVQ86FDB
 RhEeMZdO74vbjWZtACg45GIaNA509CLWxL5NOw5uiZR0tbKCk3E103bia3v/YaRYFeN0
 anpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9W9bzkrnUpcPTV3bO4B8cCPZWaAOkuAafWtjYGCdgsd9PaxIjbEafzJ7+bOhfM7jvGC6Rqko=@lists.denx.de
X-Gm-Message-State: AOJu0YxhAbKGT3ZC+LsRBBnhwvbeD9vgebUat0Le7ZOSJvkZY0Qdonap
 V58NVVab804ddvJoY6L7rLGIvluyaglOE9rKJ0u6gqaWN+6waeGhHbCL9cGyF4n9vVY=
X-Gm-Gg: ATEYQzzYJsvZemlm/TolJQALleLR7yFwJMWshnFU/QYdPiPtAcfU88VYiiUGTyqPsig
 rLEZaNw1tYQcPa0dABLTH1ZP9Erwv8yGo/0t9LF5rzeV3EJC5GRx0iUkU6cEub/7fO7vDYYk5S2
 AsRMiPaCHMkJGEqmil9aOywV89PTByPVem9lxFY+Aqf6f8gzhVyJ0AH0ACOf86IeY+MK5OEQo/s
 jKHrPOZXI6v4WRQBKtOcxi4pfLpA+ALcRZekcn8S+MCnIBIiQBJWdFJviv9X4dkG8fstW8XuhRp
 7MiJIwclXXuSr0vZERN1z2gWFnyL8RHtSWblJ3PXoD9q9bAXjQv9c9J/oJpgt4CiZio+Edy8HL5
 sFqzcPy9pXzv7+csk83lCcY0CBo981/psVwWsepALE2voV/1x1g5ktXGC/kUjNofOb/CmY/CC7Q
 tCiQ+Drsyq5Qi66oGEtceo6UF5AJYIJHVd8SYKwgRsBKBxQznf/befVwYN0B/LO5/J5gTQ8Kq13
 keVCQ==
X-Received: by 2002:a05:6402:5251:b0:662:bb58:6047 with SMTP id
 4fb4d7f45d1cf-66319dde801mr1517098a12.17.1773238850718; 
 Wed, 11 Mar 2026 07:20:50 -0700 (PDT)
Received: from [172.16.240.100] (144-178-202-138.static.ef-service.nl.
 [144.178.202.138]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6631503c903sm543467a12.20.2026.03.11.07.20.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2026 07:20:50 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 11 Mar 2026 15:20:45 +0100
Subject: [PATCH 5/7] gpio: qcom: Support GPIOs on PM7550 PMIC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260311-milos-bringup-v1-5-eb905c467f10@fairphone.com>
References: <20260311-milos-bringup-v1-0-eb905c467f10@fairphone.com>
In-Reply-To: <20260311-milos-bringup-v1-0-eb905c467f10@fairphone.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Danila Tikhonov <danila@jiaxyga.com>, 
 David Wronek <david.wronek@mainlining.org>, 
 Alexey Minnekhanov <alexeymin@postmarketos.org>, 
 Lukasz Majewski <lukma@denx.de>, Aelin Reidel <aelin@mainlining.org>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Rui Miguel Silva <rui.silva@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Sam Day <me@samcday.com>, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773238844; l=857;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=qfcBes8IT15rybMB1eCyL2J0fqkGS4V3Wo5N1Hy7R58=;
 b=b3ZILql3vkgslfNsj8vjDy3IxbwheOnjJjoPklH9yyKB3AS9T6y/c2XSe2ioPsoGdQuBKXRwd
 7MXwLohs3DOAdzaQU3NdiTqz+I7rF7iMdScGsumMibAefvSQqoiPN7K
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=
X-Mailman-Approved-At: Wed, 11 Mar 2026 15:23:27 +0100
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

The GPIOs on PM7550 work fine using the qcom_spmi_gpio driver and
enables the use of the Volume Up button on the Fairphone (Gen. 6)
smartphone.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/gpio/qcom_spmi_gpio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/qcom_spmi_gpio.c b/drivers/gpio/qcom_spmi_gpio.c
index 1a7c7c48dfc..77a69140213 100644
--- a/drivers/gpio/qcom_spmi_gpio.c
+++ b/drivers/gpio/qcom_spmi_gpio.c
@@ -747,6 +747,7 @@ static const struct udevice_id qcom_spmi_pmic_gpio_ids[] = {
 	{ .compatible = "qcom,pm6350-gpio" },
 	{ .compatible = "qcom,pm660l-gpio" },
 	{ .compatible = "qcom,pm7325-gpio" },
+	{ .compatible = "qcom,pm7550-gpio" },
 	{ .compatible = "qcom,pm8550-gpio" },
 	{ .compatible = "qcom,pm8550b-gpio" },
 	{ .compatible = "qcom,pm8550ve-gpio" },

-- 
2.53.0

