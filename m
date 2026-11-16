Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72966606A332
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 20:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Re+HchMh;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=DWB01hpw
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7149A80BF5;
	Mon, 16 Nov 2026 20:45:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H1sHJ0puRHQF; Mon, 16 Nov 2026 20:45:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7FB2D81068
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794861944;
	b=Hgf+g79EAjHkZLgdLtAzg84ZGHYcxRxeOHSqjqxIEGFDsS70kXHbbPuqDtkGSIvuFCUx
	 MoL0gQbQiGRzWN/MqLEQggL1UEwiS7O7jtUsFB79rGxDzTesaKbW50wmNtHXO2K7qO5/H
	 vQTExSnoJmzoxZmsgeaiJzdj2Se2II8hCH+c9khTZt8Pk3ZY1Lok2NGacn3a7CPE4jnIE
	 lDzHGA+gptXXXUYe/npqQNeJBGp323BjzTAe3PPHvf4wIXJqqTYOUfaQZljXhJuHHoe6D
	 Ur92XeLN3oPrpKDGKeZu2ucE174r4c8AC7CidHQ3XZJPzbacndAOKf1cLWWn0lx1ZaA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794861944;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=TaKoZIoa3R8qF7tBqK1AQqgDPS4OKwZRJwbNotzYEmo=;
	b=JMpG/+8+zFBgkdqxIzq75KSxcx17+VNLVlX2ErCNH2kSDM7mwIoWH2VVyLWoZrWVvob8
	 pC9f1ZXP64lWGSqc1BAwoNJegaMrPCedOekWRG9efW2oc6gUYvKX4m3N+hOlUG3Z6vhmK
	 35xvJbc5yUm1hdPJqa431JVuoBKzfwM1xZXJSw2UFcvGLmifoBQlJ1jmN6CLLBUSDkOnb
	 3BHUWSMSS3uuH1aFC/UQge6Rtj5tTtmI2kFJ8jfOFjLg/MValG34kvS7xeS2gELViOdkh
	 /SvqKrOf7lC7VMi/TQHZLPkUZhpEoehpAE7fsypsb7inNJnmMJ/1y6Xvcm71QSHNWwg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794861944;
	bh=TaKoZIoa3R8qF7tBqK1AQqgDPS4OKwZRJwbNotzYEmo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Re+HchMhAQinDhRLK4ufGsJXQk6WTJMcfs4Uzy9MzGzVBccRZNgdWQAlshk/PDCr7
	 1z0F1wpxC9tGRt1kgBmH8QKFYbkK3vwlykHrnuqJjoinCMmHtpW7Gdh7U377Gm2lwg
	 Nc1Xj2k7rZh6NhewylmZIJFA0Kaes1/fpKw7DXmli9bJAJymaMLbkI+/dqZw6hyxMD
	 lVaDhZfe0ZaaO4xK4yN+jW0JCPUiy7EK0UMI+Z7nlqvpVB8zAqmVargClkZ6f2yzhS
	 ysrVaJBd9pAikkPCKTihVaGqyZIZmqib8/wNluBMUaoLIt6VucdnNg6F5IDCcduvUQ
	 7z382yYu4+xBg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7FB2D81068;
	Mon, 16 Nov 2026 20:45:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6ACDC28C
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 20:45:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4D36A6080F
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 20:45:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mwISHx-PuOOa for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 20:45:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 60C0A6073B
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=DWB01hpw
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 60C0A6073B
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 20:45:35 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4a35d5d4a20so47810485e9.2
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 12:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794861934; x=1795466734;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TaKoZIoa3R8qF7tBqK1AQqgDPS4OKwZRJwbNotzYEmo=;
 b=DWB01hpwvIMnTH5z7AW4eRKbUJvaSIzA7QKFHzTDqprvDakySlr6rM0lLjEpv9NcHN
 DA2jJvFeHxulNKO5ZiwVURG/aUOtF05UEgYjUUHuYBwyfBCEWiV5PnkY2Mhfeg0KRGGq
 uabxoDcRbrbzRZQiM0xmHQMASIA9Q13yB+I8FFayZeuYrkSFjvJzOirQWSW1OrQz94zy
 j1qRKaKOQ2UT8s8HEG5tmCSnt8Oje3JG3qxN9EWsaHogGwIcQ7MS9k5xH1N4zz7Ezgs3
 NiyroUyKY0P+rQ3L4s8lFZcrDkK/sav3LuEvsyl4VA9iVWU/hcErRRKEQUHbiC/rtpRJ
 diXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794861934; x=1795466734;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TaKoZIoa3R8qF7tBqK1AQqgDPS4OKwZRJwbNotzYEmo=;
 b=iqJtZs9eYV4RTRXcX4VRUC/0ziGK1p0BbQ4BAwM26vJL/Rioa2J9YGcX36O2U+jKCv
 YRvSknzgheXQRts2la6ETFBQ5N56Oj51nDjsfvHWCuJjmL2qqAO8Ev0mK/a+Y1WH+dLu
 fiO0bQ9D5j1HJhRWk1G+xLjOQPOb7yAQLDy+0VEEPdpekOex2qqR5oEvOV91z8UAq/LC
 vCF/KhQgHraDWmamUux7lnvNDJFDNfOlR9DUDtlmhfOfgz1EOJsjyoA9cAh+PIjS9h06
 Zcq71zSmI2Z1BaLqR5qlqnNZTVXKQ0d82kHLqiijBEovZEGhB3zYQDqUHbahfdGq7tZl
 qhRA==
X-Forwarded-Encrypted: i=1;
 AL+hErGh5iw/BNz8FdyF20dyGrJg5FUYaEuQaC2sGRs8dB/uIZvIfr7lpopalT5VIwby+QPxl84p87E=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8A8w5pGeuqIYxKi/kyhy1QvLyY87LU94yCxWruzMWVkXD34f3P
 fLPTedwz6JNxZqp1JcfRc2/EBsL2ZkY868mt7TElPBrdd/MY8M9Rp8HU1nhy0qxt6bc=
X-Gm-Gg: AYBFou23pp3F7EgNmma3GSVFDTeo3qmYtKud4PTCxtD84WW6TbkQohg1HgDZn34TFPO
 YzBkJIwJLYdm/PpEkCBAna6MAoDx0tbkDIw8NZEoUIf8o2yXPSjtALN3GanDPm4RRAwPCh0Mup5
 TjSY3mMBl+7Y2c9sKQ8wly9oBSURiJ2Dlx/63BRaQOyvoEao0oRl+xGz7IRYStZRpgbqE3H8zGU
 Froe+ziVzySHoSiX/dlY51ySIIM0oG875ZYUyYCMymXDEP816pfl1oEZki6LB3yXKxGZ+QwJdMi
 pCxUFa54kdEvTaNqQC31bgsg4fJoH6D/8rT0R2nI+PfZy67aKPmw3JUeD5SIAEJMnLsDhPHSebc
 mmqa/N6ORzaybpwHOkgbzt/aQXFPkfOcE48ujQcnWbYcbX79+dKNu09Z+96/jvhUZngR8lP55Zh
 Q51hzvVm3oL6+FKyp0Nen+1/P9q8LNQKs+jaWWhwYTbT/Ih/tQxq25wQWjOT1sElB6e67npUibY
 iHWZ9dINH7OzT6ySONOqC5vpPgyZF9srQkbes+RQM9pwY7M/V6iBeWcWYc0IRRSrCqoSWdF1Vrx
 jeKuOA1VucI2p+E+Yb5z2oXpWuMNCufT+TsOQQYRms5X/f26eL5KdY8XEQlKPrvBDvEcmDAglZa
 Dv/Fhfd8mWfHyomQ1yb0=
X-Received: by 2002:a05:600c:1daa:b0:4a1:dade:f049 with SMTP id
 5b1f17b1804b1-4bb55a4da43mr263926565e9.15.1794861934211; 
 Mon, 16 Nov 2026 12:45:34 -0800 (PST)
Received: from [127.0.0.1] (host-95-246-144-141.retail.telecomitalia.it.
 [95.246.144.141]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb78386902sm16855545e9.1.2026.11.16.12.45.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 12:45:33 -0800 (PST)
From: Carlo Caione <ccaione@baylibre.com>
Date: Mon, 16 Nov 2026 21:45:07 +0100
Subject: [PATCH v2 4/7] tee: optee: enumerate UFS RPMB services when
 consumers exist
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-genio720-ufs-rpmb-minimal-v2-4-b64eefcfb0f6@baylibre.com>
References: <20261116-genio720-ufs-rpmb-minimal-v2-0-b64eefcfb0f6@baylibre.com>
In-Reply-To: <20261116-genio720-ufs-rpmb-minimal-v2-0-b64eefcfb0f6@baylibre.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>, 
 u-boot@lists.u-boot-project.org, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>, 
 Carlo Caione <ccaione@baylibre.com>, Jens Wiklander <jenswi@kernel.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jan Kiszka <jan.kiszka@siemens.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Johan Jonker <jbx6244@gmail.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.16.0
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

RPMB-backed service discovery currently runs only with eMMC. With UFS
enabled, services advertised only by PTA_CMD_GET_DEVICES_RPMB are never
bound. Allow the query with either transport.

Skip enumeration when no service drivers are registered, so enabling
UFS support alone does not initialize storage unnecessarily.

Fixes: 3b39df3bc540 ("optee: implement the RPMB subsystem interface for UFS")
Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 drivers/tee/optee/core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index 2abdfd99e5d..53806670b6a 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -194,13 +194,17 @@ static int bind_service_drivers(struct udevice *dev)
 	int ret, ret2, ret3 = 0;
 	u32 tee_sess;
 
+	if (!ll_entry_count(struct optee_service, optee_service))
+		return 0;
+
 	ret = optee_open_enum_session(dev, &tee_sess);
 	if (ret)
 		return ret;
 
 	ret = optee_bind_services(dev, tee_sess, PTA_CMD_GET_DEVICES);
 	ret2 = optee_bind_services(dev, tee_sess, PTA_CMD_GET_DEVICES_SUPP);
-	if (CONFIG_IS_ENABLED(SUPPORT_EMMC_RPMB))
+	if (CONFIG_IS_ENABLED(SUPPORT_EMMC_RPMB) ||
+	    CONFIG_IS_ENABLED(SUPPORT_UFS_RPMB))
 		ret3 = optee_bind_services(dev, tee_sess,
 					   PTA_CMD_GET_DEVICES_RPMB);
 

-- 
2.56.0

