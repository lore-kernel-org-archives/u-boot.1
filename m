Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D343D606A339
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 19:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=a4IMkdiA;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Y2JV4Uxr
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AFFA660A55;
	Fri, 23 Oct 2026 19:01:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rC9HMPVrlVYz; Fri, 23 Oct 2026 19:00:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1F38C60A5A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792782058;
	b=GtCQguDwMr+cB1ZNv/4sC34Tm0RZoXj6645GuHSqvZN81I2VuuH6sRJZoSGGhXBlKfAE
	 /YvxnQc+1I5aJ+0/CnlguyPWlWH5AUcVBthfH9ZUqtGJtANC+en8apmUKHC9YFXGzpsUV
	 qvdp9kCow/F7NnjL7JJRf6jiO7iigCBRkSCDruKT419bBkKRaBqp7fBgWS3gbooEKa2bo
	 5HZS6HTpulDFzUdulaVRNqgKivuCun0hdQJdDryat7tnlVCKX7/irf9WuNdKwnv2ci1Yn
	 /VMqrqY1InwXLwQ4mMX5/hiSUKspO8gKekSmMlL+sNRnLpA3dJzcj+IKht/as85lCIQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792782058;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=LQqAjfNYPZ/92kcsWjWoLNe08OJUI1ADRPkXQI9EiEM=;
	b=W/PFb76f010d05Cs04oMjVL5eM+FUO+cTmVTmVv/dA8O6V1y7oVYrjMDZ+czoZZObXK1
	 qcSsU+YDawJYDtvkcUPlVkYnN1RROB5ChEQKL51t90DUb4AasNIYB/ckrTIskGij1H5X1
	 WGP1Lg4aJwoyDu8u90P1f3OV2wAnZmoSHAZQ+x7TmC/FAb69+nUL/F++YHmZiHBYdgs9K
	 qi+do1B2CJ6GspZ1nLIbiDDGG1VntdsipDSxuuDzQVtqAjfxnTMH7fZPNnCtLnZcW9ETn
	 nsTJb07K5ZwXNxiRVJOEAQzF+Q68QKaIAfV8C7gq4u+ndxLpCxIQxVq/4LxAcNufp3Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Y2JV4Uxr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792782058;
	bh=LQqAjfNYPZ/92kcsWjWoLNe08OJUI1ADRPkXQI9EiEM=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=a4IMkdiAzdONLiJAnmCuxovYULSa0LAxCnzwLpjE5ngTlvjeXpx0uu16BpODDyn2U
	 WYB5ctseXA3HwY88LT/t3mdh8Iv3KMg8qikSiLlIFvkIMDTk96neVCxhXCJ2iFyU10
	 5mZzrTYSLtsaTRyazrxA66/S54nB0T2nN7FdIg09WfO3YjsSiEoBrm4AXRLONcFLOv
	 9Oi7Zq9XjfF3cueIhgEXHc/AGiv76b/bKd+FwSL6NBTk5+bPdOhYhTppGlzo7SY8SA
	 pNpjy2QiBvYt1hDR77Z5+W6nbKBKK4Wd46vVUhWozoRzXCzr9bRxi3z+jJMp4VnMSB
	 DPfQgTuwHGpWQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1F38C60A5A;
	Fri, 23 Oct 2026 19:00:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 570C7388
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 19:00:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3AA7F6090B
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 19:00:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JyocKV0umIuD for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 19:00:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 44BBF608FC
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792782050;
 b=PsvLeS4qaVxHRS5uT8JG36zFfKQQtiKGjQ1tM9NiZNOF1CW1ofnspkBWIgv6y4Y98dSN
 xjPVfrLRpte54Exhj+lhCQFvOAxShq6l+WjTFjajC49M2pEMSDRXnJa4GDnuhoC+VA1pX
 HFvgHrHwwCKqjmJ1lXx1+jIrRuGkvtmaCMahPLwGyY1+FP3c+cCRXf20m7WMOP0zgPZoB
 6/DuN09lO7+nfjfOx7jS+h4o+jJI2wPVUkocEEO3SwBbZ/0CvHBvbX0sPf+dfb4He9eOZ
 SDEFc8w+/5H1KSE2K01qZv9TBXZHgPZ8RHUSezMQ97HVcFD9GFRfP0TASJh5wrELfxQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792782050;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=LQqAjfNYPZ/92kcsWjWoLNe08OJUI1ADRPkXQI9EiEM=;
 b=G232edJ3G7ZikUpTz22if6d++gVujr2ja4HlcGmTQZxVI3B3dalaNK9kDrMFszSPXFH9
 ebV+E8uafpJvXoUXaDTBkTa9ttyGByuBy8Etmrs9yzFQSNjqsns+hYjpfnCy2ocL5eQ1O
 uAoS0KifSDwrnfVGiABamxS05/Dc2s4bZKRy5notarQUz0TgLZJoDthVVLtQ5Pwlf7Bmj
 3NvWKCdob6zHIqIpmUrXz0n0v1irXrsWAtjIP4PIxq3+tlJkx+jWr8c2l/UU05qf1eWaM
 3uxpsg1f7JFmR6ZVuu0HKb+qd0yOe8rqKZxw3VxXJqqpGGk+98T9iep8T2bVE9TIXBQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Y2JV4Uxr; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com;
 envelope-from=ansuelsmth@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=Y2JV4Uxr
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 44BBF608FC
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 19:00:49 +0000 (UTC)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4a208d93758so12835225e9.3
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 12:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792782048; x=1793386848;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=LQqAjfNYPZ/92kcsWjWoLNe08OJUI1ADRPkXQI9EiEM=;
 b=Y2JV4UxrwGuRuDkBcmWKMPf7+UxNO/tb03Vo0b+WsLid0AddeoSjF9JadZF9uf/M59
 hTDLuWn2g6opQUnDPHiDUhMr7fPAmwB/Bl5sz+DozBIv+/htfoDfK7l8Mt4FLPtEYk/x
 VR1Rwc1B0821ITVF7UrGKj5M31LguVJAOauRBhrETstTpy3xObCzHaRxUkMlw+KfANVf
 Gr4Clk75PI/pvIDZYul0wd1wjU8DDZDV/Yv7y3UQ/CIT9vvf0Y93N79NH4w6GU7cpHKa
 rSOMBi14ceRSNPqoB5QNsJdlTRRSUwpV8rdkf9YYQUVed3WbnLbtkKKBkvkc0R1PBH6S
 ehIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792782048; x=1793386848;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=LQqAjfNYPZ/92kcsWjWoLNe08OJUI1ADRPkXQI9EiEM=;
 b=r6661hsnEsgIGiwLwjq3G9L8YHdRUkgTv8YGfWDJeOm+O/bAMDYNd3B3VFg+I0u/EA
 1mMexOzDHFITSBdje0KKJcdAor60Iipugn5L0lkoM5AUOapffFvSt5jqSfQOaSS2SlyJ
 p5uCvxfkwsCXwtpjDR0A/dUHFgNznCjKzG0nDcTZ4ACiu+lMJLag1ofqzeny3zVX0gq8
 jacSW5zNYR5ou/oxN9nKBjInXFhdZDAN6iAMJfCbCLuUTBUen+ks8nrqf+9wyBO4vk0w
 UiMWf6X8TJjVG3zLLr84XkMwOGKdjUJ2LxeTXaIXaW0fzNmcjGPr9ddpvH64HjUnuMER
 OjNw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxSGz62eO6jj0JfaAIeU6yQEcAuzzK+jdgmgEtMoqBsaoi70wlwb5v3ZqH516z1Y/8lau0N0F0=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLyaq3Cz5ev/uDfB5ZHYravSWRdIiqwKzNN+GS+uDMKvbVocSF9
 qtlEHj/54JVP66QdsIKLACQTJHpbFirIAtgWnywrKuqt41/mIVDywxW5WZUNkQ==
X-Gm-Gg: AYBFou2qan1VpkAnP10+sMKGpmR3JeGESvP2U81MDVA3q/5cj+C4UAzK8fhbbvlis1y
 m6O33oIqStys5Jn+TLIKe5M8lFYsATaMtoDDh0jjHYXgq3YN9n6AYMvS1vDULXOCCQdeDNMWnjB
 KYGcAT5oLmo3kik3BQ/RzzcVQuq9jML2PcKCTJ8PhS2nFsA20/GiBm7kPe8KMxREpdhOefOKBxn
 8cwwmuIeBiaapK/9cKNQMaXJNmdPKXR3fepqMSsLptN3EejJmnG3QytyiAOIZENgV3wDp/TG1/1
 UR3C374gD1OlEqsJmOw6zm+cX7/WNeAvCnmTP1cPa9uQXT1PQqUqq7zfPWSc6Lgt6WWgJrgYwp/
 1JaMpKQ1YhvR3FZDR503SCe60x3ctyuHmJcuO2IsZV2e5Mc3XZTSQcosHXa2JcPpEUVPSSu9wg7
 lhGGWJIIY0Xzb1NotwlbSIGLFaFhkKgcz6eBYOIbYiq2UG65UHdrDLIfPRBDpMem2M70rZUj6P9
 xgNW5S1aLN9RbsbyQRpAy/EYuiIFPRSjZDRulZNop+15we8RnocCVcWT7LTphZDGilwiw6vPM3D
 +ykQYmaZsiPWYQTnDV6Wx1NlIUQkBaxioAI26GCZpfA9ia0hkMbNgVJm+nQT
X-Received: by 2002:a05:600c:a08:b0:4a1:f377:5c75 with SMTP id
 5b1f17b1804b1-4a211f0a748mr56725085e9.33.1792782047565; 
 Fri, 23 Oct 2026 12:00:47 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (93-34-92-187.ip49.fastwebnet.it.
 [93.34.92.187]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4a35a0aa097sm2481275e9.3.2026.10.23.12.00.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 12:00:46 -0700 (PDT)
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
Subject: [PATCH v9 3/8] misc: fw_loader: implement generic
 get_fw_loader_from_node()
Date: Fri, 23 Oct 2026 21:00:24 +0200
Message-ID: <20261023190034.911023-4-ansuelsmth@gmail.com>
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

Implement a generic function to get a FW loader dev from a node.

There is currently only get_fs_loader() but that is limited to chosen
node and is limited only to FS loader.

Introduce get_fw_loader_from_node() that will parse the
"firmware-loader" from a specified node and will search and probe a
matching FW loader device, if found.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/misc/fw_loader/fw_loader-uclass.c | 24 +++++++++++++++++++++++
 include/fw_loader.h                       | 14 +++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/drivers/misc/fw_loader/fw_loader-uclass.c b/drivers/misc/fw_loader/fw_loader-uclass.c
index 0d95fac8f42b..7f19d6c4af4c 100644
--- a/drivers/misc/fw_loader/fw_loader-uclass.c
+++ b/drivers/misc/fw_loader/fw_loader-uclass.c
@@ -7,6 +7,8 @@
 #include <blk.h>
 #include <dm.h>
 #include <dm/device.h>
+#include <dm/device-internal.h>
+#include <dm/uclass.h>
 #include <env.h>
 #include <errno.h>
 #include <fw_loader.h>
@@ -137,6 +139,28 @@ UCLASS_DRIVER(fw_loader) = {
 	.per_device_auto = sizeof(struct firmware),
 };
 
+int get_fw_loader_from_node(ofnode node, struct udevice **dev)
+{
+	struct udevice *fw_dev;
+	int ret;
+
+	node = ofnode_parse_phandle(node, "firmware-loader", 0);
+	if (!ofnode_valid(node))
+		return -ENODEV;
+
+	ret = uclass_get_device_by_ofnode(UCLASS_FIRMWARE_LOADER,
+					  node, &fw_dev);
+	if (ret)
+		return ret;
+
+	ret = device_probe(fw_dev);
+	if (ret)
+		return ret;
+
+	*dev = fw_dev;
+	return 0;
+}
+
 /**
  * _request_firmware_prepare - Prepare firmware struct.
  *
diff --git a/include/fw_loader.h b/include/fw_loader.h
index 56f5e3be6195..99c47380a172 100644
--- a/include/fw_loader.h
+++ b/include/fw_loader.h
@@ -6,8 +6,22 @@
 #ifndef _FW_LOADER_H_
 #define _FW_LOADER_H_
 
+#include <dm/ofnode_decl.h>
+
 struct udevice;
 
+/**
+ * get_fw_loader_from_node - Get FW loader dev from @node.
+ *
+ * @node: ofnode where "firmware-loader" phandle is stored.
+ * @dev: pointer where to store the FW loader dev.
+ *
+ * Search and probe a matching FW loader device, if found.
+ *
+ * Return: Negative value if fail, 0 for successful.
+ */
+int get_fw_loader_from_node(ofnode node, struct udevice **dev);
+
 /**
  * request_firmware_into_buf - Load firmware into a previously allocated buffer.
  * @dev: An instance of a driver.
-- 
2.55.0

