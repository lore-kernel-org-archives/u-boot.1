Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 529BACCA471
	for <u-boot@archiver.kernel.org>; Fri,  3 Oct 2025 12:48:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 219BC83775;
	Fri,  3 Oct 2025 14:48:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mainlining.org header.i=@mainlining.org header.b="FqHlBtIp";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="lDBW/Hcy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2EF96836D1; Fri,  3 Oct 2025 12:02:46 +0200 (CEST)
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 115208366F
 for <u-boot@lists.denx.de>; Fri,  3 Oct 2025 12:02:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=david.wronek@mainlining.org
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=To:Message-Id:Subject:Date:From; t=1759485672; bh=fEpgUVaAAmfCX+giTMNp4v1
 9Ff5MD5Oa9HMuCYPROLE=; b=FqHlBtIpWM0I6tf+IZbIS5KMYTZEQG7fGn2Lu7SCWOPb4AcmoT
 uLtiXM9UzG32bhWyfMA0tVQsnpwW8BNT+7inumsJRm2LUs+QQVqiBF5QcBvuB0nYs9KBzT0vyKU
 e0Quxy4OfV9QSdTUh8xrMu8o+osXkxcT61U8DwQnMHHh5Ak22S4TPsjVQokE+cz5pMgn+PTuhrr
 ADQ1jt+p1vK1G+2Olp6Bplz0qoHea9kgt2IZR90Gm0K4ZqfhB9V+3XMKNzc+nnkuEs/uSvqETkg
 qzGis16LuLkxRa4LBG2SA71IEm0doBkr8bZKoFGdCYlTtHBAtUdc2KclDzCAAuPQgMw==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=To:Message-Id:Subject:Date:From; t=1759485672; bh=fEpgUVaAAmfCX+giTMNp4v1
 9Ff5MD5Oa9HMuCYPROLE=; b=lDBW/Hcy2zF9EnSSEwDl8RQjFmp+w9Wimpd7hyrVNojMAFb+9M
 UTb1Uz6DV9NkI37/0aFwVsaHYY+46snUHdCQ==;
From: David Wronek <david.wronek@mainlining.org>
Date: Fri, 03 Oct 2025 12:01:13 +0200
Subject: [PATCH v2 5/5] gpio: qcom_spmi: add pm660l
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251003-sdm670-v2-5-52c0fa481286@mainlining.org>
References: <20251003-sdm670-v2-0-52c0fa481286@mainlining.org>
In-Reply-To: <20251003-sdm670-v2-0-52c0fa481286@mainlining.org>
To: Alexey Minnekhanov <alexeymin@postmarketos.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Christopher Obbard <christopher.obbard@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Julius Lehmann <lehmanju@devpi.de>, Lukasz Majewski <lukma@denx.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Rui Miguel Silva <rui.silva@linaro.org>, Sam Day <me@samcday.com>, 
 Sean Anderson <seanga2@gmail.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Tom Rini <trini@konsulko.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: linux@mainlining.org, ~postmarketos/upstreaming@lists.sr.ht, 
 u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 David Wronek <david.wronek@mainlining.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759485669; l=774;
 i=david.wronek@mainlining.org; s=20250914; h=from:subject:message-id;
 bh=v4XYGqrrCaty+ws46Q0yxcD4tkyKS5feC7+2U2s93cM=;
 b=ilAg0Ba+9AyPzo6lZu8qALgts9oKZqqKDVtzF5VsORrUvqa5/YXC/WCcsizKyiyJvDeIJ1vsO
 hl9rfEgxK8zDG+r88q0mi/kiS/ui9Se5bRBeJfW4eDNaVCct28Whnch
X-Developer-Key: i=david.wronek@mainlining.org; a=ed25519;
 pk=NtKhS1PfXjRIaJwWcYTu7JS0cX3GEmccZo+a6erVTfU=
X-Mailman-Approved-At: Fri, 03 Oct 2025 14:48:13 +0200
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

This is used for the volume keys on some SDM670 devices.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: David Wronek <david.wronek@mainlining.org>
---
 drivers/gpio/qcom_spmi_gpio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/qcom_spmi_gpio.c b/drivers/gpio/qcom_spmi_gpio.c
index 22c8072534e..220b77dfa93 100644
--- a/drivers/gpio/qcom_spmi_gpio.c
+++ b/drivers/gpio/qcom_spmi_gpio.c
@@ -743,6 +743,7 @@ static int qcom_spmi_pmic_gpio_probe(struct udevice *dev)
 }
 
 static const struct udevice_id qcom_spmi_pmic_gpio_ids[] = {
+	{ .compatible = "qcom,pm660l-gpio" },
 	{ .compatible = "qcom,pm8550-gpio" },
 	{ .compatible = "qcom,pm8550b-gpio" },
 	{ .compatible = "qcom,pm8550ve-gpio" },

-- 
2.51.0

