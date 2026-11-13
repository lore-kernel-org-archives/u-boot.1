Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65173606A327
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 15:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=DTkq6mB6;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=P/cQP78N
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9085D607F7;
	Fri, 13 Nov 2026 15:26:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fH84ROkK13_A; Fri, 13 Nov 2026 15:26:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7E1E2606F6
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794583570;
	b=dhMmc8nL/ugB7xxZkwSonaWJJYxbq80LQNCg12Eyi+LCmQSqyqxr/cJqEJlDmVAqOYmz
	 YdNwEZ8xtvMV0agkdthxYEfsQ4ECFKBjmzCUFXE3p1MY0NBseVF0WSmeiwOdellD37zSj
	 2ePs2uRXMHlTnkMyy63FpbD7Xb2IgxnZplGmRtDMavdPgNtQ7Rjlt/RbeNR+Y9Mi71D8k
	 lllzP29HkqF0Dq+7WD/mqDF0l1fPtQ4gy8Zk8bANUbKVypTg0kGqr9SdYHy4MTrDLXcKq
	 38YzRlLG3bHv2TRbP5uEJ7qg42ZkHlNkB0u53QCcjCIvXuf7m7TMnQCmXo4CHWc/a1g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794583570;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=I85b9mQ/0M+UtEgMAaPSS/YG6Nyk8/QcAMjl//FysRs=;
	b=Imetp2ME+/zKMCknEsa8TopUzewH19h3ggzxS30tN7+WgytEtAITCqEuHknVBpvoAElL
	 C37KpWqEp6cu1qUI+GYeRvfCYSRcBLz4rrkDVtzSQxXGP7GVIbuSt6H74lkzXGcMgGCl5
	 0womRN1e4ZK3wQR88TIbUHys2EUmz/tn2dfrjmYO4iwzGEqxkNY6eYlLYlUZ55HZBhtVv
	 CdUt5aFRN35rwF7ZDMOuOMvtYLtf/gZqMMXSf5GmRiPi8C0qRV7wfwU0wWKeCJnNg1qlh
	 ZhRXxEA6id8yxo1XggHnI4wK5qVlcJWxR1bJxEKdiHwT9RZX/Adqw8sODITOFqGkylg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794583569;
	bh=I85b9mQ/0M+UtEgMAaPSS/YG6Nyk8/QcAMjl//FysRs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DTkq6mB6nWQ3B+TN/Z+9rm7bpOjHcyOKWkm7hC+TpHzfOsYa+FJUdNVyCTxOlC987
	 NuO6cuVbcq3OjPizV+9inXaSjECQc2q69Jlq7OtF+lWJzCdmlu/KmSzil6niKzT/fq
	 G7GpmeeTwQ18JX2p6eYPpY6QPgcZlaCJFaSU9NQxYRSZLBB8VGmGLHiyiF0xkmhGuH
	 T7cz7NfmdhjvESu5pWh1KAgDKUTXZlBbm259rH+IOfgs1f4cFa6RMt6+OxFYonxgdC
	 FV2s7BQdJbZdnU81BWOKyFxEcLOv/KRoj+R8nTxsCy2b/Gj0vEljcjMoCkudJtEiXn
	 uu9PrU9WDkdpw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7E1E2606F6;
	Fri, 13 Nov 2026 15:26:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id D808E28C
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 15:26:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C9A224009F
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 15:26:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GrXQdIUMHAcS for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 15:26:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org E498840093
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=P/cQP78N
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E498840093
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 15:26:04 +0000 (UTC)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4a1b07c3c5fso15985945e9.1
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 07:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794583562; x=1795188362;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=I85b9mQ/0M+UtEgMAaPSS/YG6Nyk8/QcAMjl//FysRs=;
 b=P/cQP78NNjiQ24J7EvbTFRDjYhsN/wMcogPmNLrNYz3OlyQgSgNtGopxdlgQhn4RNQ
 cD+eWZIst2sxillPtFMv7FSlQ/njD7rWMsG5+v5MdKgSyjp7dz3bxmAOfwmJrQT8adUT
 1yLyg1iLyNHSwFp+Wu7EJVKsaRae8tzGtgQUuyZo65ZXUvFU0OVG11y8eD0wHXPw3nEL
 AMQXpr6E07JQhUwfzHY/8L2Cr8Erh2VUTZIut/zmnNvwBpjJghbDP9DWpM/UfUq2ESjo
 LQI+MsgNbjQGrBVBJyKGa5Dny2hMikT47eC481GjlW1YURI4hDvm3zcCA3En2t2T9pIJ
 ZBGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794583562; x=1795188362;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=I85b9mQ/0M+UtEgMAaPSS/YG6Nyk8/QcAMjl//FysRs=;
 b=PyroMO7GoNsDObpjUI1aa4GynsmL/1chFxLmMvUVhJZtREbRwOy/Nq3MfvqfFbcImq
 KEs3q1ZR3RjSgcGU6EaTv+ordL5un+fBRAfpEMrFQK21GNxlq6AmjxTzXzqT+6buyH4D
 P3HmGAy0y2mKAbQoAtSnvFlSkv2/wtA6j7v3DrL3zw/nIrx9eUCsYU0p/sFFgRhW2Xol
 ncG1Cp44hBXlAiOn7HzUQNwGw6PNecaOesWgSxvImTGwIstO1P13loN6LH49VHOM0dAi
 iv7nFgRzqy9rMglXjwgSORiQcWdSgBBr7jeThPzpIkjDEXFXpCgt/OHkY+GuozwvCZMO
 63cw==
X-Forwarded-Encrypted: i=1;
 AL+hErGRo9Ud+ATIioZVarUZEDsEI59VKVOsWWAFm98A+RqNcuHBvubV1iES/DOkcpBXDAypINN7F1Q=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9M4lGdhtatIh07OlJzUjKvpCffqNRQ23+7tNWfJOe5MPJd6Vl0
 KxMwwxqPf+bYVigZ25mqvny/2Q8xtcT+pCc5lnXLnpccpKBpBa0r4nok4kUddZ5ga6M=
X-Gm-Gg: AYBFou2jeXVCHrXGMYAO4X/4DMDf5Gudo4f6oGoQyU2LMouLBiE+QGXaIGDv5B0l60b
 cMLkj7ocMxT/N2cDLdIeMEddjRv8PTk4KEvlvokVRGOg5PGhPtFvEGhVArOd2Q6wPpClsDqyClz
 S3LmG1LE1dFWhgjFKcvfGuvLbNcn+NyIQmcp0bSGU4Uu+zQiC/Ch1Z9VAHdRUwubdkJKgpEgc2A
 hAv/huo7yr/QZPukpadNDofaoP3v83+UlmXe3yZ+UjhCzSkWijHjxH3flbW/LnmQMW8bmXbwz+K
 cJEzzKXsk34Cxo9paovY666UdRzjs1PByshTO28nAmQqyr9bnguLQGoed6HrCwwYp4Ov3aKsL0o
 XXYJAB7MRqHvmOZZMIlicNjdZHne6Djk4Hv0SkzH1f0tc7tY93A601XvyjNM9XsQK6eAf6lY1OY
 4k/WG7Vl2VDWIYvM/b/by3IIG8tHyXKYEK9ig+ftNd3/bH+X3S5mGEWUF/7pxElAqSQY34gdFD0
 oMc4zKnCp9LBpXP+WqsOn8nzHKrqi3tNnVb5wsBYKBp3byq5TsIz0CWn0XEgpuuHMShxr8x/GRh
 XhGlvXua0Lu35AQQdzUJb3oZj9DXybWbFZr/wAhXMNZ+RyJitSxEsI401r9407ssVtjoNRPpBfC
 tGxAEnO2Ua6jjLLoCrsrPs08mAKHX/ZRcMVsBLoIdZwC9+g==
X-Received: by 2002:a05:600c:4ecd:b0:4a2:1655:87db with SMTP id
 5b1f17b1804b1-4bb5599d31bmr61103945e9.0.1794583561025; 
 Fri, 13 Nov 2026 07:26:01 -0800 (PST)
Received: from macbook.homenet.telecomitalia.it
 (host-95-246-144-141.retail.telecomitalia.it. [95.246.144.141])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb55ace535sm70042255e9.6.2026.11.13.07.25.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 07:26:00 -0800 (PST)
From: Carlo Caione <ccaione@baylibre.com>
Date: Fri, 13 Nov 2026 16:25:39 +0100
Subject: [PATCH v3 3/5] usb: onboard-hub: fix the TUSB8020B speed comments
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-ccaione-upstream-mtk-g700-usb-v3-3-78b554604bbb@baylibre.com>
References: <20261113-ccaione-upstream-mtk-g700-usb-v3-0-78b554604bbb@baylibre.com>
In-Reply-To: <20261113-ccaione-upstream-mtk-g700-usb-v3-0-78b554604bbb@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Carlo Caione <ccaione@baylibre.com>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Alexey Charkov <alchark@flipper.net>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Julien Masson <jmasson@baylibre.com>
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

The TUSB8020B exposes product ID 8025 for its SuperSpeed hub and
product ID 8027 for its USB 2.0 hub. The comments in the match table
have these speeds reversed.

Correct the comments without changing the compatible strings or the
shared hub data. There is no functional change.

Fixes: 89aa34bf38f0 ("usb: onboard-hub: add TI TUSB8020B power and reset support")
Reported-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 common/usb_onboard_hub.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
index ead8bf44cd5..f0e84730482 100644
--- a/common/usb_onboard_hub.c
+++ b/common/usb_onboard_hub.c
@@ -312,10 +312,10 @@ static const struct udevice_id usb_onboard_hub_ids[] = {
 		.compatible = "usb424,5744",	/* USB5744 USB 3.0 */
 		.data = (ulong)&usb5744_data,
 	}, {
-		.compatible = "usb451,8025",	/* TUSB8020B USB 2.0 */
+		.compatible = "usb451,8025",	/* TUSB8020B USB 3.0 */
 		.data = (ulong)&tusb8020b_data,
 	}, {
-		.compatible = "usb451,8027",	/* TUSB8020B USB 3.0 */
+		.compatible = "usb451,8027",	/* TUSB8020B USB 2.0 */
 		.data = (ulong)&tusb8020b_data,
 	}, {
 		.compatible = "usb4b4,6504",	/* Cypress HX3 USB 3.0 */

-- 
2.56.0

