Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B95606A323
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 12:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=K87lqSO2;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cyzIlIhM
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3494C407E0;
	Tue, 17 Nov 2026 12:27:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id C5bT4fOtne77; Tue, 17 Nov 2026 12:27:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 554AA407D0
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794918458;
	b=G2dyzy3ZIuRxPrRyuOWLpm5FcCt/bnVF4eM7tgG2pjMnAVBIr0ooW7abJd/0uAb7HmAu
	 c6M8tJYJVX6bZlHk9uSx+fZf8o7Z33TbVr2cKfxlk5ti7ItYTaPyA1fii0ivb+s8InwK2
	 mUFxRRFPfZuWENcUsPa4qlXUe9egL8wKewh+yutOACzAYx64Rf+GkRfAnjQnEkis0Ysbo
	 0FPEi5qTkfyHhDXEvauoSp3v5XIUreK7KFUe0m+K+nKrAT+3walU9Ckyc5iSAFCBXFdrW
	 fxOiziKWxyIhZPHWQLVZDedGQmY16TUIUJyoIZi2T10L4wmd41fcU+jGhpWoC8jMmEQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794918458;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=JRo8IzQ/JwXsRwbZt3MEnNiwFqRRuuJNm84yXN+8mOY=;
	b=HrROg38HPlX123AjslilhYomBeLt563sEG3AMAvIwnsDRIsCIcV0b4K9M/YLlpYSaw/U
	 jtTdlleMFejC+IiCtoqaLJXX026ws7CgYTmJ4poMApRZIMqKWn0NpJRNMBEd25pP2mi9K
	 0cSIujMsNZVJQHZw16h91mye7mL1zl4B5hSft+MEZQPbThc7OtO70him0okLrrwoMkqzP
	 0BACprJdrfWXki0phhyA9GYtFC2H5lms8krX2ufis+KqHcBVMEXa3i0sLBam8EO/sQfyW
	 3W0EIOccO4oesDBxWKs3xWGsk8yCo7vZTrUf8KXVEfVfo7Y/PTHU+LJy9jKN6B3ZC4g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794918458;
	bh=JRo8IzQ/JwXsRwbZt3MEnNiwFqRRuuJNm84yXN+8mOY=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=K87lqSO2jr6F6SJBML1uMhMTTRb1Pe7hub+l9gkRFRofcytOpOY/C9S81KHdrwYGR
	 SiPFWJKnr/UtLNkXeK2YuPRaoMRos4H3qpoDtvx3twRmY8JObHHSnQFdzCYTkJyIPb
	 I/xbKYblTbBatgjvPbEdgaGFM3AL5nJ/tceE8Dx1t7octJG43m2WdS2xDLOokLyJfZ
	 zmF2Lnv7eEHlsSqZK1hLSSjhvaGZeVgzJKX653yqPcM5xpHBeu2s0f55YzJIOkycjg
	 sa9DIrc6ZJhIVYg4uaNUtVaYqN1Ui7JgNT4ZmQrM4dLvUuVZgLZaPf/i6w8iyoaGz9
	 yHwbBlMtDrJsA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 554AA407D0;
	Tue, 17 Nov 2026 12:27:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7C7112FB
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 12:27:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6E5B080FC6
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 12:27:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P1qUmxTF8aD3 for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 12:27:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7AEAD80FA9
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com;
 envelope-from=ansuelsmth@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=cyzIlIhM
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7AEAD80FA9
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 12:27:33 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4bb666304fdso6929185e9.0
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 04:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794918452; x=1795523252;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=JRo8IzQ/JwXsRwbZt3MEnNiwFqRRuuJNm84yXN+8mOY=;
 b=cyzIlIhMEGw8CdsFPmGV//ti9MV2+2pAkC1b1CFHQd6dPWSzW+jnUCwZq2ULmOtN99
 Hvu2CrBi9jgQyBphKQ5qTY9vSlkEvr41UFmnqcpbLaYysPAKF8lvqe27LplGVubR4NLB
 p2mDu2w53rH/ve2BEexl2jDduBsHeGwTZy8JVSrPIZc9iUTD263SB1JrejzU4IaBJUr8
 72PXJzKSxAnY2wdKPjR3+E83pStIRVZXHFYonmxd6+V46C7YhK2BVb6WMsXhdeNnSybm
 rYgp0A/OkVa2Jf6/lxf8b13+aDM0C0Fd1m61/2Ct9f1zgL6z8IG4eSPDsZmLK156SFaT
 4fug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794918452; x=1795523252;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=JRo8IzQ/JwXsRwbZt3MEnNiwFqRRuuJNm84yXN+8mOY=;
 b=vSq2TkmRwoHVfMq9k2OVLVD8raJQaEhj0qYaSLCt6Ek7TN/nGeJlNcnqS4Y8Q0mIGu
 Ad1J013BoivHEl1Hm7sRth2t/IWaVuBHg01Rdn1uEj5v8Xxcok6Y7FtXhBbmuB4sI1o6
 gtbk0c8BLUpi2hxfDrtozB0bmvpzD/vobW9fbcnN4rZJDRResu2exdYYZNrAPwu7HiQw
 ebnMmHxptTwtt0he+9B9Gyl6ih7QuasHghwAiyl/5Yg6f9iGiNl9qKZrGoRrZ4SqvvHA
 FQZmg3lVlyjH7gpMFArkrkC4jWBZc+DQ8GHSnH01T8KMMrDK4U/jY5oeXXKQxJR5TUPW
 HKSw==
X-Forwarded-Encrypted: i=1;
 AL+hErFkADtCvmU4tSwmXgwIq4XnQGIWSl50lshPmCfrm/oIBnxZQoCS6rE7DdAqPR/CWrENYfj6GlA=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z950jbWNnP5i0kT0DdJafqe1Vs/JV6XcVI316L4UJkqF3xc5NPU
 Er1xLqaw/ksMMHvXb9ZfVe8EI3l3meay7IOkBHx1TpRzVGBXHchCSah5
X-Gm-Gg: AYBFou18WDSev/1D1SCYoOQ+zILuM+nLFDdgIQuVm6bYLr75CVeu7ILKHO6g9vArEs2
 cnlZdWulJOUHaOup1zX1D+TASZ9TfZ4ArxUh9G6dwQJCIn/mN7BEJrIHWHbSOslEtn8ygfRUilp
 xCLzwxHrWQ8i2fXFogdZ77PPRbI/GFzgwwQUnIuCYtAzMxVncFsqDyD0NJyB3DiTcl4+BzUWL+X
 JAU6JFIX7JC3cTbdrzyRAfPSiB+/Dvsb8Vhi/6H1fUCWNVvD+MHcCoGiEeSPz6B76HDTIfok+6K
 kS8nJPFVfbjm4qFAMlVBQV8slwkhDocgwb+nFcqPwYS4CIgX8pWXfjZJmYV5H0XS/YaD9XJn7n/
 J+FQvzpewOFGgzsiAK4ozV0J7tR+a5pVmdtYk8Wxp/Taly68O6wGN+5itT0w9FneTUQqJlfaaDx
 Adqxt4Rz+/mr0MQ4axx3k9BVSkf0fktfKIh5YZlVZC4iW46epTRvcE1/PoY1uhoLonxXQe41slN
 ceavZmKiPqcORl1WtV4VyRpMLajNcMckbSDIvw5YrQ7GKeUVm+nnxfWnVMak1j3GEIClys43AG3
 My8I57lCVk/YllAH+KHYE+/rixmmzUUTRKvPaY6AOOKKtnPZPFJxnY2jbvLpYWPFourh4ZLwbZ2
 gS42R1/olwZMXnKg5ZyJ7LlahXNuNFlEbJw==
X-Received: by 2002:a05:600c:4584:b0:4bb:5e8c:13bc with SMTP id
 5b1f17b1804b1-4bb7837a4b9mr53285865e9.7.1794918451827; 
 Tue, 17 Nov 2026 04:27:31 -0800 (PST)
Received: from Ansuel-XPS24.localdomain (93-34-92-103.ip49.fastwebnet.it.
 [93.34.92.103]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-4a33c344a58sm5243151f8f.34.2026.11.17.04.27.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 04:27:31 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heiko Schocher <hs@nabladev.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Charkov <alchark@flipper.net>, Michal Simek <michal.simek@amd.com>,
 Vincent Jardin <vjardin@free.fr>, Martin Schwan <m.schwan@phytec.de>,
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 =?UTF-8?q?Jo=C3=A3o=20Loureiro?= <joaofl@gmail.com>,
 Aristo Chen <aristo.chen@canonical.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Anshul Dalal <anshuld@ti.com>,
 Johan Jonker <jbx6244@gmail.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Marcello Sylvester Bauer <marcello.bauer@9elements.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Yao Zi <me@ziyao.cc>, Peng Fan <peng.fan@nxp.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 James Hilliard <james.hilliard1@gmail.com>, u-boot@lists.u-boot-project.org
Subject: [PATCH v12 5/9] misc: fw_loader: implement request_firmware_size() OP
Date: Tue, 17 Nov 2026 13:27:10 +0100
Message-ID: <20261117122715.7983-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261117122715.7983-1-ansuelsmth@gmail.com>
References: <20261117122715.7983-1-ansuelsmth@gmail.com>
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
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

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/misc/fw_loader/fs_loader.c        | 28 +++++++++++++++++++++++
 drivers/misc/fw_loader/fw_loader-uclass.c | 19 +++++++++++++++
 drivers/misc/fw_loader/internal.h         |  7 ++++++
 include/fw_loader.h                       |  9 ++++++++
 4 files changed, 63 insertions(+)

diff --git a/drivers/misc/fw_loader/fs_loader.c b/drivers/misc/fw_loader/fs_loader.c
index 01b0a221c8a7..00f72ae24233 100644
--- a/drivers/misc/fw_loader/fs_loader.c
+++ b/drivers/misc/fw_loader/fs_loader.c
@@ -191,8 +191,36 @@ out:
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
+	ret = fw_get_filesystem_mount(dev);
+	if (ret)
+		goto out;
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

