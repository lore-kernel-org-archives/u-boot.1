Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4C8606A333
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 19:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ZZYe2cwC;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EZzRnt8w
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4BAC260A68;
	Fri, 23 Oct 2026 19:01:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5CO1RVZGo93O; Fri, 23 Oct 2026 19:01:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3531E60A6F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792782062;
	b=tfSBguCkT/EkRkYZrt4DxoTJIuV3XWw/iC7PBomuad/dQ3ElBQm7gUsSUM8+6aGPmCb7
	 5I/vpA0SJeB+lBlQKyNA47OIFn1+v3PHVXKhLqIECKp24xoDsdpAPwm7qNDlhn08t+qK7
	 9BXPUOXHKtH5GPgUO5VXAaRD90zlh6sWy8Z5+4IyHwlMU/1ChAvjHnBeV30eOC4JkS/Je
	 Rzmp7HnqE47NmhEIaBCSsnfw/K3LPnKhIJjM2kjbOcwqygJliD+UohZFHTF0lBlZFNi9Z
	 iZfcBWQnQ1m9m0eLaZUXNEXDc+rUp3MsVPAF/AEjFK8SwRMWWnQ/1KxYtnHbwzmYA2A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792782062;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Sh7h8n0QEWPLVHz1h4Ln8ZlU4kSwm9trtgOwK38NxuE=;
	b=RarrXFy1BwjilO0yFfiVx1b/cEteWor8iydzyP/EPhhpm7J/ouTL62SELGBY0vCUALUg
	 uMxOL1XPtiX2dYz8BrVqEGyhZ+//0sh0xRStKAqMxV6nX7uAGcMjd52CzE423VPtpJxxf
	 Txna8GfETSGBOUNLkET0E+gnqt+QAtpnj8URvrOrTp8vtx9g1mUJu8DEEJHthGRMRpXE8
	 OKISNeOmXowM6ukQN1LevnusKlslaENgXxKGFeQiQ1FJC3fjosUB6vtnAsW10FHWCU6LE
	 gCmG5ID1QoEbg4OVCIYRx4+hcYkxhPVtblxpUWNXQFvQP5hIzqCR1acxOZkYNxLH0uw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EZzRnt8w;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792782062;
	bh=Sh7h8n0QEWPLVHz1h4Ln8ZlU4kSwm9trtgOwK38NxuE=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZZYe2cwCQQWS963qqpX+41CTKmGEpZk5JejaWqNwiyihVBrHIeiSbM1xH740UOhN2
	 vgV8u4iOex/YJNa+kmspMdALFCNb0dhsNCkxH+qU5iIYiLvBLoA8yVYO/yVEXmBG5e
	 1wit+nDabdTGI5iE8u/qGJKr640PYJue8Z7Gq+mMvfpfPg/xyBHeR8WgwhtugHcVa2
	 hAubSCOSttTuwUHzY6AYlzEfSDmZ7lUhwdDDjcbFkc5CqAGJKaFEtC5Ne+2GABrvd6
	 VoGE5Bmz2N3RWh4JCstTtPQPOxzw2sF+p/23EuIApunbr3bWjl0JHwt43/WTm8BoLU
	 C/jL0HPT2ZlcA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3531E60A6F;
	Fri, 23 Oct 2026 19:01:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id C915A3C4
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 19:00:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C675560A55
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 19:00:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Rt6d4XhXq10b for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 19:00:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org F19896090B
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::334"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792782057;
 b=S+7mlvyTqZeEYK2bX7slTbTFULx8eJP5IbnTHr/TTSWTUXtSqzYOXcoy9gTrOL+YdzzC
 vEI3IQXH33aUGTJdGXsY1vq1qX5mOzdPelA+vo3oerrmtJDL/KpwEhPkEJ/iBV/a9gdFL
 eMa8ZUPxpFc9DzaYfFkGt65coHjPJSmKscKIt2xEPjax5iVc/U98oUcNBAk/f/SO2NCpH
 XB6KGHG/30eehxoP7kAGmpPola9Z6ta4FVRzJVoTar+s9yJ3bZ3SmCeINeE8xGOAmw/Kp
 BC0Sc7bRRkgKRaoVan8Ci+2khjxYGezdKVMaZu78vdV93Gu1eQ8k/MKdaBzFCdBuKKQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792782057;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=Sh7h8n0QEWPLVHz1h4Ln8ZlU4kSwm9trtgOwK38NxuE=;
 b=Yusdqp3wmJwL0ykVH7TRUWpFh6QNdLxZZlJZXKUMYsTKSvBO0JWQIPB/235IVrWSZLjt
 n+HPugl5NVdtaaHkLikAb2ArgbRBLoxnoeCWd0vVeTuj7eH2MlRxpRVaDpCt/tVR8y4+M
 g5G+0WkzdwgWxHhHQuvuMHylIovNQsvFMHyFiXb99RH2rr+d18oo8MvBFZ1NNtv6/54/D
 FfL82aMjKVoyGbwaxsNAeN21xkhm6VRvzaX3R72k9JGFz1wTyGgpjU0BQFgMlou1gO6gt
 QGktHh0z2Ewnq21EVTw0/n5lk0uD2lAVxwYAgPWGuigYUUb/0BNwujjclh4Bd1QS3tQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=EZzRnt8w; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::334"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::334; helo=mail-wm1-x334.google.com;
 envelope-from=ansuelsmth@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=EZzRnt8w
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F19896090B
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 19:00:56 +0000 (UTC)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4a214af2076so7228885e9.0
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 12:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792782054; x=1793386854;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Sh7h8n0QEWPLVHz1h4Ln8ZlU4kSwm9trtgOwK38NxuE=;
 b=EZzRnt8wTtsU0BnXdi/wzZOT3QY/Ftm9NigVnEIS5Nnwu/rZkiK6iZdrS4oscBn+a6
 jDL5Gx1PkDwjm+sAxkgm/4DiGQrztx5xLm64z8HmdQ9MldsLy1uVleseRTfm7GsvRBMo
 17rKspA3s6HkA14nIzkZFadfanOOo3SXkqUp/SXUagkGh3mroDLPZzRzMOnP5dFnXSfO
 WalhsJOXqOHRwgZRV5tbFZ4p5ACx/O5zlhnBK1gxt2xoviGjfSmzflJQ6ACyLn0bxDHb
 9Sg0uR33e0pWmLm5nSfm7A6y/Xqb2D+TKWLPkoj0Cv5fi7jA0z9cycxMBoNfQOJ1Cvo2
 TIpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792782054; x=1793386854;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Sh7h8n0QEWPLVHz1h4Ln8ZlU4kSwm9trtgOwK38NxuE=;
 b=oIJbXcWFxAXZCcY4VwYVtDGm3A9EpSlt3YvRbKP8bhN5RJOsmQyRm7VLFfN9rPm6Hi
 w4agJ4dZ2sKyG3x726jfOVrkThKXrjyZVGz7P50zbfnlZAupHtuBGwSOxvODk8n6gpo3
 o50gbZKARGgfN+e3EiNqD5S15IxQc7eWVATd1nxY3srX+kErE02Dx0IKdKt953InmH4D
 OMVZ7gcMZb9gOamb54ztOV9E87GBGggD0aL2mzOobDnBKCuPdl4gutD5xpU7cUAa87zZ
 44NNbHZI66PSlU3yFBEtVwEcL0lyRKFRE3P31xgyO4PdsVXGZeLOOnQUR91G8mjlF2ba
 LkIw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzY69qvOYvTi9wzcC5+4/mqJp6INpCBKaiLLvs10QKl1iuiMIHMVEii2fuglLvgdh2LXekONwM=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIA4g3+lOSPA5R7s+muQ9TZ+E4QyenJuyD6NfRgoFWVEkXaY/Uq
 fTvhmZNk2F5Ojo35D6ka9eH5fR0InAXHh3BLMdafuWau2U7abYW1pU+o
X-Gm-Gg: AYBFou2Uob4eY/oVQJxocCg4cYDrr0eHNvaAoLYZ+9mNIpXdE4GxTNNIHvzN/GqxwT9
 yMvPmBvOJfF2kZ85xa1N7ufQ6MMtUTaP5X+U84j7SdyrRvSGsOVpYuktbUQ7qvBuFxetB0lfuec
 4fh+tHpPgjVBC+T0BdiPn4iP2AMzEnBA1HrRWvKavtHaOJTJNQPrxLcnF2G8h2dbrg9GxYh/eS+
 5iowzmfRZEu9y7LnXeSrviD0hlX4Azyz1tUBmviamnDjsObdPj0WKpsSDC0fAvpMASHDCJprMJo
 1OSW1QyiBSFnPW8i0x72LZ22UCWwTL52FUmU8UfriIAlrUeGYwa5qJnZ+Xdb0wl/+ZGaJZriw7z
 KV7ANeYx2/zsxM370nlR3nwslwD6QRz7TnMkKzHRS5Vcok52tQbZ7VlEskIMLea1Z1uy9X3LkfG
 QaJUqe9o5Ca7MvrZ8LFqiTbg/7VZlc1HkGjHnyUp1pMc8McPmmbKexCzvnsZi28hFC4iYj+i2Xm
 DtdNah+QEa7uBFQkXbDR5VY++cQv+aZYIe+QncFZYRodsaE7hAWS6Q6u38PXRS0BYbKHOp8XwrX
 mRyrPLeAbVAkmc+zTwLVQfyL9ZN1EmmWXgTsrEEnZUDWUTWQGYZ66uIfKNHn
X-Received: by 2002:a05:600c:818f:b0:4a3:12fb:1ef1 with SMTP id
 5b1f17b1804b1-4a312fb201dmr12242565e9.29.1792782054278; 
 Fri, 23 Oct 2026 12:00:54 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (93-34-92-187.ip49.fastwebnet.it.
 [93.34.92.187]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4a35a0aa097sm2481275e9.3.2026.10.23.12.00.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 12:00:51 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heiko Schocher <hs@nabladev.com>, Alexey Charkov <alchark@flipper.net>,
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Aristo Chen <aristo.chen@canonical.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Anshul Dalal <anshuld@ti.com>,
 Johan Jonker <jbx6244@gmail.com>, Neha Malcom Francis <n-francis@ti.com>,
 Marcello Sylvester Bauer <marcello.bauer@9elements.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Tan Siewert <tan.siewert@9elements.com>, Yao Zi <me@ziyao.cc>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Randolph Sapp <rs@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Martin Schwan <m.schwan@phytec.de>, u-boot@lists.u-boot-project.org
Subject: [PATCH v9 5/8] misc: fw_loader: implement request_firmware_size() OP
Date: Fri, 23 Oct 2026 21:00:26 +0200
Message-ID: <20261023190034.911023-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023190034.911023-1-ansuelsmth@gmail.com>
References: <20261023190034.911023-1-ansuelsmth@gmail.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

It might be useful to get the firmware size before reading it to allocate
the correct size. This is needed for case where the firmware size change
across different firmware version and is not always the same. In such case
the only way to handle this scenario is to allocate a big-enough buffer to
read the firmware.

To better handle this, introduce the request_firmware_size() OP to get the
firmware size before reading it. This way proper buffer can be allocated
and dynamic firmware size can be better supported.

FS loader is updated to handle the new .get_size() handler.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/misc/fw_loader/fs_loader.c        | 24 +++++++++++++++++++++++
 drivers/misc/fw_loader/fw_loader-uclass.c | 19 ++++++++++++++++++
 drivers/misc/fw_loader/internal.h         |  7 +++++++
 include/fw_loader.h                       |  9 +++++++++
 4 files changed, 59 insertions(+)

diff --git a/drivers/misc/fw_loader/fs_loader.c b/drivers/misc/fw_loader/fs_loader.c
index 6a1747e739d7..4d16e54ede8e 100644
--- a/drivers/misc/fw_loader/fs_loader.c
+++ b/drivers/misc/fw_loader/fs_loader.c
@@ -168,8 +168,32 @@ out:
 	return ret;
 }
 
+/**
+ * fw_get_filesystem_firmware_size - get firmware size.
+ * @dev: An instance of a driver.
+ *
+ * Return: Size of firmware, negative value when error.
+ */
+static int fw_get_filesystem_firmware_size(struct udevice *dev)
+{
+	struct firmware *upriv = dev_get_uclass_priv(dev);
+	loff_t size;
+	int ret;
+
+	ret = __fw_get_filesystem_firmware_size(dev, upriv->name, &size);
+	if (ret)
+		goto out;
+
+	ret = size;
+
+out:
+	fw_get_filesystem_release(dev);
+	return ret;
+}
+
 static const struct fw_loader_ops fs_loader_ops = {
 	.get_firmware = fw_get_filesystem_firmware,
+	.get_size = fw_get_filesystem_firmware_size,
 };
 
 static const struct udevice_id fs_loader_ids[] = {
diff --git a/drivers/misc/fw_loader/fw_loader-uclass.c b/drivers/misc/fw_loader/fw_loader-uclass.c
index 7f19d6c4af4c..4e67f2559fa2 100644
--- a/drivers/misc/fw_loader/fw_loader-uclass.c
+++ b/drivers/misc/fw_loader/fw_loader-uclass.c
@@ -210,3 +210,22 @@ int request_firmware_into_buf(struct udevice *dev,
 
 	return ops->get_firmware(dev);
 }
+
+int request_firmware_size(struct udevice *dev, const char *name)
+{
+	const struct fw_loader_ops *ops;
+	int ret;
+
+	if (!dev)
+		return -EINVAL;
+
+	ret = _request_firmware_prepare(dev, name, NULL, 0, 0);
+	if (ret < 0) /* error */
+		return ret;
+
+	ops = fw_loader_get_ops(dev);
+	if (!ops->get_size)
+		return -EOPNOTSUPP;
+
+	return ops->get_size(dev);
+}
diff --git a/drivers/misc/fw_loader/internal.h b/drivers/misc/fw_loader/internal.h
index 9ff43e872554..1abe7504a81e 100644
--- a/drivers/misc/fw_loader/internal.h
+++ b/drivers/misc/fw_loader/internal.h
@@ -32,6 +32,13 @@ struct fw_loader_ops {
 	 * @dev:	Firmware Loader device to read firmware from
 	 */
 	int (*get_firmware)(struct udevice *dev);
+
+	/**
+	 * get_size() - get firmware size from Firmware Loader driver
+	 *
+	 * @dev:	Firmware Loader device to get firmware size from
+	 */
+	int (*get_size)(struct udevice *dev);
 };
 
 #define fw_loader_get_ops(dev)	((const struct fw_loader_ops *)(dev)->driver->ops)
diff --git a/include/fw_loader.h b/include/fw_loader.h
index 99c47380a172..01f242dcbefd 100644
--- a/include/fw_loader.h
+++ b/include/fw_loader.h
@@ -38,6 +38,15 @@ int request_firmware_into_buf(struct udevice *dev,
 			      const char *name,
 			      void *buf, size_t size, u32 offset);
 
+/**
+ * request_firmware_size - Get firmware size.
+ * @dev: An instance of a driver.
+ * @name: Name of firmware file.
+ *
+ * Return: Size of firmware, negative value when error.
+ */
+int request_firmware_size(struct udevice *dev, const char *name);
+
 /**
  * request_firmware_into_buf_via_script() -
  * Load firmware using a U-Boot script and copy to buffer
-- 
2.55.0

