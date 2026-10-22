Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FAF606A319
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 19:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=lZwFonDF;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=glOuVt5e
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3144281325;
	Thu, 22 Oct 2026 19:02:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X3WiarZ0QwzY; Thu, 22 Oct 2026 19:02:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0E53E81387
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792695777;
	b=VadDK9wm8muCPk762HeIbJNwtIMY76PyF4cbiF7kuDQ5MVVPYvAHTpi4nPgzMgCLhc4p
	 gfAoXK9own/2OCt0XYL+F/h/KNQoTa+v4781numYKkVYydNOnMVz+knKaVQjfXhHU6mdY
	 e7IvuMAHNiSc962bMCzmIzbO5mxG1Zw+eER/Z5SKrUTsPxwnikTWXj3WZpVdSdpQmhP/F
	 0f6II9R3xf0P6RUpoohwi2C4R1uXraCIMoWLn7tGgA09fQbtHeOb2uqePegEY3Eu94en3
	 qeiAUx0FBt/vo6A8sPxvKSxUWmXA81kBKh1LNYszOTseyNatN4sMMaHuuijt7W4v+aw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792695777;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=vghzkyyudGx8FjPWFZd6bZPWyp+IWCgUOnbCef+uWRI=;
	b=jmy9XnueStFVtKNv5KeNC0NBtn0gxkP/TGwwskN2dX8yh8QBAu/NjXeOMje6vDGVArwx
	 54phDRTOdhgOKteaTRnnS3YK/GjwZuxMlEwCBZJ7ssMkfV/dSRwkTt0Zh9HIB7AelzejI
	 FpwcTPmGMzJxBCbc6GOINRc1iTKAb3QWu4dvInnstsnSH2Jf+Oyqw+VQlzU7xjarxBRI/
	 JqSmrSuGwT08Ef7M90gegctF5uhYPacldCiCJov7ywJXW78hHOH4rB2mOf8mP7/eoZslM
	 yiHHl0SNzbAbtFfDPWDsufquQHFM5pwSA2NUAMpk2CJJzYezFOv4bJWW96XboKNnd3A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792695777;
	bh=vghzkyyudGx8FjPWFZd6bZPWyp+IWCgUOnbCef+uWRI=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lZwFonDFqH2tjhlOJB0Sxuoa3yCoT29Y7gTuKuULHg1GnyZ7qoHYtzr/IUf2ETdg8
	 YF2+59u90YYYe5EZFKjjvcLpllIAA2NQkyfL+bxDDsf+HoHyDgRy4GC3HoxxZ/MnSF
	 jRIL6NoZyNg6YcixNatLaBY6dpV219t4RM+TkmjH0xETWiKlwBsksvaxKCrsKcWaQ7
	 zzpDKQKqYeVJP8w7ZnIlDuhzjbp/wYAH0RS9YpgF0yrxNNpluu16G2tFgsY9icvzp5
	 0Ngadq7FcPr3Cf2BqoFq7L5h7x2D1HMhgvxMRsYiLjRmB8HKICcjLMesEJP8PnOjTa
	 58Gx4Cu43kR9A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0E53E81387;
	Thu, 22 Oct 2026 19:02:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 40D713A7
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 19:02:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2431460821
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 19:02:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X6Uq64yy6Y82 for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 19:02:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3850E608C9
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792695767;
 b=tV2MClHmKu4oPxt5lHJkRUw4YgkbpWxJNFjEuHgtwLHornRqROx7S5/S/41B28G6QY5Z
 Q9bz/e/3DnLG3LqNI32SuJ07kltFwh5I7d7oNbBDUiT+tQs/78HbQgJW9XaZxZdFGmLa3
 DRzyjMQ/joy03j6NJ2QQ/mqNiDs8dKmt2ujMnLWZgy9GlQHOVK2Mkhgt6NqCyYcUPUeSv
 6hap/YRoJtUwS/7CVMH1uvML5Ao2JLGhZOICFoQ5nHEnHd86jiobTLyh4muRWPbV0dtpX
 jLF14hNLmkpkpY1jPSOfo5J8PCwo3j3T9C2WwDX2CXZEMVYFqLHRLs9uHT8WCUwYVwA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792695767;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=vghzkyyudGx8FjPWFZd6bZPWyp+IWCgUOnbCef+uWRI=;
 b=i9kOWCUr8zf4kW/qMFCJIt5N8K2BzVmN4KyD8IlCPtU1GysRO4Ev5+GHYWbVY8zu976i
 rrP/3H5DTQkUPMGCF6Zd3hvffJsH7ITrKN9oLBE7uBpGKywPZXG4NpkYziWb0YPcxttbS
 BHJKwmS/Z6Bz3ucGqoPoEqtkr4ehNGDuccE90Lj20gMDbzN+d6d2VLIqfC9Qzl/PapnzM
 292Ki6Adkvi+Helfd6vERbgd/kR5A9judqCpX3HR4KkTprunfHMWEmJFes+fo6cHPJx5p
 bIkzQmXJuLPa3tTRz/erOtHfi5SAwLt9Gq3Te9Md7V++ZXqCfD+9VEbJCX8Qk+PugNg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=glOuVt5e; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com;
 envelope-from=ansuelsmth@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=glOuVt5e
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3850E608C9
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 19:02:46 +0000 (UTC)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4a1dfd49525so1145015e9.0
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 12:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792695765; x=1793300565;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=vghzkyyudGx8FjPWFZd6bZPWyp+IWCgUOnbCef+uWRI=;
 b=glOuVt5e+ZpWdI87OXjWAmREbfCxYFJRVkulZkqKqYwiJL6gLoz1WqZsTg801fhjeS
 x6tGKG+wrWtSpO1mjZBke4u5Kr7qsZxwfe8LiBLK5CEOOrucsdGVmsm+AaGNvG2f7gJh
 A/uuxKC6H9ONWBQzHvHrE0ZAr87nPDlPh6w8xD2JxakhoQtTgimSyVVJ8IO6QT+NuOpk
 W0UFeBpNySK2kA3yGGwA7o18FQ+fFwsZDYWlvjvmSD/W64g1WUH1hPRskZQNlI2xBFEk
 c0MHbikYDkryWf7s959qNG7/CnoZ9T6a9O0c6B6siZqdFnwDD0o3bjt3gj2V3IOqYHxd
 3Afw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792695765; x=1793300565;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=vghzkyyudGx8FjPWFZd6bZPWyp+IWCgUOnbCef+uWRI=;
 b=YkSXIqVeeMdwDc0+fzY5bVPZR2Fkc6pLqc5OmcoDFgwLESGDD/LR9Ze9MJ64ddQwF+
 LWkgTzWsnml3Sl8ROfhtjly1+AZHKceakq5Knon1W5Yh35zscmHMLpxCk4TflJLJ70Hf
 rvYD1Yfol5lB8U+GVx9ThCwi9eNLwRZpJ2VfYyyl7QemzUilLLrccd95VJP/J2+J+Zio
 iB/fwxbNfTgwV02k6UWi7AhI3ARYLlmYYB33BJ1M+bSyASsniKXyVbJC3t0eqTUKss1z
 O/K8R3NqvsqsAf0Ec9kY+2RrnD4QLtKs6SoRXRSZEzM4JlYgkmezO+39D55I6jvLq0CN
 IQmg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxHYbWic/gbc1xb0UF/EeXOItzLwPV39ox+w5hKdxFSENc2l7nTepPPdPV4au3GhtHq7B57pzM=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJR+Yk4LSdcasd6fOt0YYCf66bVYZdkltwe4tVJbeIbuPnTT8UN
 DBZoq8SQC5tVzDVKVwPDSdGHWPSMcGjdRN6OpxeaOSn3H16AM688SfV+
X-Gm-Gg: AYBFou20mq3fbDOgkaoUsKeS1NBNmJcNIhZHahAVlM6LkpgGSk63/Sz8QR8URitnOIt
 PWtj20AyjjqBFZvbQCAjUNK2kGFqbWOU2H+Y2a52BteEej47L09zE1J8GeeBheX5XNCnpSOGHtM
 /7bynijKk1jkxPIRD43TU87nuHf0HnuyYX8RMRgyb1NrKQWtr/rWzW4zLYo9v5It7cZoYfq+l08
 de1nYsYrwTk1ZB7/lnvXJu25LNCJiEWBC/6r8Sj34X2VjgrLRy4xsFZ1N5UQVxrNzWi2PIEwBx1
 Mnc+R7+AWeAezYxjo+rsNz6nBvoIxkK6rxpgWi67Rmq+pp6JvBQt2ZsUt+J+b1dw4bN7WkUrQwB
 EKJGaXK6+1iLi4eCGa58xbieaMzVnW+AOhbaaqdZyo7WOTcu6WpbCpSO2dasuCxnEjZ7/LcvDs/
 qNKjW4ejwZ/VUS3uQ3ulL7m+WQfxxn3oCX0Wr8hMq6Az2Ni2OaHWG4sK8VsRurSY5E6/iXNFzdX
 0dvnNX7gVXY9ZK9bD85tQIRJJj+FPmAihHNPojP4QSOqVg1DezShSiX2/VEbQpxq2WjcUrm3WMF
 84Tax90CP3lIpeqekCG6nf2O7X+gdlZRuRcfx9tXCJTd2MEtzC8y/E7v65oCWH/gWsRj0IT1oOL
 2JdHQAA==
X-Received: by 2002:a5d:5f55:0:b0:48c:5304:5e50 with SMTP id
 ffacd0b85a97d-48e263ad234mr13584081f8f.0.1792695764667; 
 Thu, 22 Oct 2026 12:02:44 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (93-34-92-187.ip49.fastwebnet.it.
 [93.34.92.187]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-48e37a0e841sm189495f8f.54.2026.10.22.12.02.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 12:02:44 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Lukasz Majewski <lukma@denx.de>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Anshul Dalal <anshuld@ti.com>, Simon Glass <sjg@chromium.org>,
 Macpaul Lin <macpaul.lin@mediatek.com>,
 Julien Stephan <jstephan@baylibre.com>,
 Julien Masson <jmasson@baylibre.com>,
 Zhengping Zhang <zhengping.zhang@airoha.com>,
 David Lechner <dlechner@baylibre.com>, Wayen Yan <win847@gmail.com>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v3 11/16] ARM: dts: an7583: add mdio child node to switch node
Date: Thu, 22 Oct 2026 21:01:53 +0200
Message-ID: <20261022190206.666950-12-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261022190206.666950-1-ansuelsmth@gmail.com>
References: <20261022190206.666950-1-ansuelsmth@gmail.com>
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

From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>

Add mdio node to be able see integrated switch port states with mdio tools.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
[ improve commit title and description ]
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/arm/dts/an7583.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/dts/an7583.dtsi b/arch/arm/dts/an7583.dtsi
index 4f7b41665b1c..f0ba3da21c07 100644
--- a/arch/arm/dts/an7583.dtsi
+++ b/arch/arm/dts/an7583.dtsi
@@ -167,6 +167,11 @@
 		switch: switch@1fb58000 {
 			compatible = "airoha,an7583-switch";
 			reg = <0 0x1fb58000 0 0x8000>;
+
+			mdio: mdio {
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
 		};
 
 		syscon@1fbe3400 {
-- 
2.55.0

