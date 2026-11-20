Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE803606A696
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 21:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=LNgdswSA;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=DlmZA2QB
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 614E681779;
	Fri, 20 Nov 2026 21:50:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ND3mxM556xL6; Fri, 20 Nov 2026 21:50:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 539B88179B
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795211454;
	b=SjlmdIcaCX4mFIjppgZwo1LcF4RuYWtbiXuEi2SSk1sK0MVJ4NhYQBl7f/qWTG71nzQx
	 eK6bKwHaiNMewvHP16VN/yiTTBYOaeFcXQAkeUGP48/HvExqivfCjdSku76M/XDisHPdG
	 Nm62U76nbwRUB1JpbLNPhRUccS+39KednaqwT9Icmif8ysK1pZpSujl1Mizh6DFTw9R3j
	 DVPhzphHpk2q5dCr40yKUiFWScV7KuSBV9/vvFuED8Swli2+YU5tN6GthAM3mPjLP99hB
	 l56cBFZqClL4BmiTZBDUK+eJQ2F62t+R5c8QbGHInWxwCYsNww3jkatl8dqKDdFp+Dw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795211454;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=zKioeJJL7vCX8ELKXvvxBqOQ7oFFwfgXfKlWCZqRWYY=;
	b=pmU8Bu6hPSQOkX4xl6+Sbn61wMQeY95KYxeuK0Ea6uT+4vIyopCa2JkDFqkEHUh1LN1u
	 SZLGpKAjtQMZXxvIEp7QEWAv8b2bKYEVGjU+yzZjLIrcSY8hZjmrm3abi89GUf9922/5S
	 ArNXZ4ZAuuLdAFJ5NBtdyd8bMMQ6yRxCWbRg9ep/lOvvDfCXMLCjdoq59KMNr52qLNhYc
	 dro7fmLGOmNTlw5w+zUahozCI6kRWYqXovwgv874GYL2enbDvVZDyXzcgvYE+mBLGXIbh
	 vW/d8OXNtqZgG9GHcoqcBy3IrWJVG0yxc43SS6qIoxNFlHJmR7DsH0tPT70/LsGD9PQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795211454;
	bh=zKioeJJL7vCX8ELKXvvxBqOQ7oFFwfgXfKlWCZqRWYY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LNgdswSAWjPMhDJpu4kbBd2ZYvWnrHspojlqagrBe1iw1sgem13aMW8pUmW/WGQNh
	 /S+RVBDRlWpRE2QtezsxoZSbDBlmgsukl67ugVe4CcQz9FkVecPNYV5BmFaFDd6kwK
	 6WMvzRitH9i2F+kkUVF6vj6L6UMo+tAyN1ZDo8cbgJLYj8n9D6A8DDHucmNHrVhiB4
	 MCW+4M8ruwjd3F9n4hnPy5jr5iYUPuuRaQtuAvMwzr+tfkmvW3dSVa/j6WKLmhw3KA
	 F0BjoS/FSJlH+g69XoEJg+zzHgywUE8hG6KUaYGEyNCp1d+7MxdXQhGw35paQ0ekUA
	 6CfJoFcX8z0ng==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 539B88179B;
	Fri, 20 Nov 2026 21:50:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6172E465
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 21:50:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5F5E540B05
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 21:50:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HdSfa8QHJh6K for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 21:50:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 8D9C740176
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::33"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::33; helo=mail-oa1-x33.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=DlmZA2QB
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8D9C740176
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 21:50:49 +0000 (UTC)
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-4ada9579947so941915fac.1
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 13:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795211448; x=1795816248;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zKioeJJL7vCX8ELKXvvxBqOQ7oFFwfgXfKlWCZqRWYY=;
 b=DlmZA2QB2uV6MzoOh/i/+CKy3Hx5MdPKe6nPoMer6Qa/++vBmywbeHLLkIyTYOG2wT
 bomVt1Y3NFUCcwyZNI2ZcB5Gw9aVg6jZ6eggsoNmkj5e5eZhzAAjTS8QPzLrPCLVwrbo
 GW+BWnacPqRCmJ0HQcfwCdxX+RNwm1huJk0jDYY2wuv8p/4k9AgLo6m3nKI+22c3XPKt
 I9d2YJWcXgCnozX8k+E/4d/tJViG5VQLBz6LTVRv2DysEt2pmckr6PLH33suMzIQhoGG
 tLiYAw+WRb4DXK8ToTPqTjhBkiEbYPD/9bM8Ju8w0JVeXnGXSVRKRvnMomEbBgenxpR3
 Q7TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795211448; x=1795816248;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zKioeJJL7vCX8ELKXvvxBqOQ7oFFwfgXfKlWCZqRWYY=;
 b=sKSCQfFbuFju3YCTA5TvyD1fUMHmM3v0uHMu+Kx8KFvxnfVG8B1yWKZcjieV/pp3bg
 djzET4kEKGIOha/guSQ1cBce3ZPSgGK+4KBLO6mO9Q8XhtJuyXhDtmn3IVa+/X7nYsor
 0KN4OJYpxBX8v+PKSaLjoo/mZtWwDgpBflxOSPYSU8LsDgu9Em7epQgE8j4H2OgokKUb
 g3b3h5max1G/WCa10DtEuOaF7JEb6Dn2ZxEhlFm6W6ug5ED9rTNzqTV3KA1EvhlzywAy
 JX9v5j0OzGYylFIVYi64hUvvo7g6uNzHcwmdjeyoqTe25dY2Gtt1Qr/PEKZnhHtTTlVy
 mYDw==
X-Gm-Message-State: APuU4Z/NeN2Ngilc8sRn8WwssjbKKkh7N+uQrK45XiLn/xAYYPXEooBq
 gav67D7z8/McTQLgvC6MTo9sgtIJru2EE6oJDK4/5B9Iv3qWk30CMWhjyi1DGMg0BuU=
X-Gm-Gg: AYBFou2fs14W+cmmSnI+I9FjdLpLFbhFTzdq2jGpdxosFAOzNoDV4uPCUCroPKgqQhr
 LtTt/XKk7jG331LSUI+xo45q/s+6Sxa9phUqPD9xx2LviKXjxtpX7NQcil0ByLQ8fsSaZGVAGOI
 HVKcY6VsCL38m6OYr3Sa5gCI0VNn0qYvXpzD2YTvROxwgVzL8NybO6rCLHfNnnWCIm5s95ADjL4
 CNIz75nbd+/98gIJWIG3mDotcxPb5/FqC16K2ZPxJo14hBWUc6v5sqJFX1lX+7c2rz7+virUhca
 7crTAwuhWPucFWi8lJwS1ngsQwQeYlp0TDZP17OEPPd114Wh8fQT1rEGN52Dgw3laaS5lXrtnHA
 IDhxWiXptuvK2HpRUXXvlJ7n1CHG70E6nN/uIJryidW51aGlj6xuJPA+FBQn5OdT6yakJu3DZHq
 6B3bdnAVLiLQhOO/f5k+kcC7KFCPCAQY9PskNoOsnR3xe/ORvEKHNRiQiUrZp5wJENUFyLg8tQb
 t2vv/ycKJEFnqA8K4d+xAyXsTzLWNYW0Flsga9fH0/o62IM4cxifvNWDc/4zy/iWrP8TaZnan5k
 RQcu42lRKN7zu20ezXryvy3Uh/7ISq64
X-Received: by 2002:a05:6871:786:b0:494:75ba:c6d2 with SMTP id
 586e51a60fabf-4bc802e756cmr4355180fac.13.1795211448058; 
 Fri, 20 Nov 2026 13:50:48 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:d4f:b590:5bb3:988b])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4bd044fc4besm2846726fac.7.2026.11.20.13.50.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 13:50:46 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 20 Nov 2026 15:49:31 -0600
Subject: [PATCH v2 4/8] arm: dts: mediatek: prepare Genio 520 and 720 UFS
 for SPL
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-mtk-genio-720-spl-ufs-v2-4-3ef93cb27dcc@baylibre.com>
References: <20261120-mtk-genio-720-spl-ufs-v2-0-3ef93cb27dcc@baylibre.com>
In-Reply-To: <20261120-mtk-genio-720-spl-ufs-v2-0-3ef93cb27dcc@baylibre.com>
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, Carlo Caione <ccaione@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1107; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=XWXnx2Xtc0xy5tn7f6lj48EMq2b6rzNQQx7IPHXiZDg=; 
 b=kA0DAAoBwswgAf8Bj8AByyZiAGsAwIeh3rUXEbMsOMG6ghnsXH2Bj/qzVqVjJXsl3h9cVXa2Z
 okBSgQAAQoANBYhBOwY2Z5iDoPWnNhomMLMIAH/AY/ABQJrAMCHFhxkbGVjaG5lckBiYXlsaWJy
 ZS5jb20ACgkQwswgAf8Bj8BYtgf9GNHhKonRqE3x5MGqobMHKWiy62s+bNgp9oUWDL+BZ4FnPFT
 nWEQxbiFXa3cX0mYCM0+wMzhYdHX+VQIzskgL5LdhSnCFBjq6S509s9p76RYHkaZs5RahrLqNCg
 z5uQIQ4WhgzPyYrYIswl41ki0HX8f3PeSI9MwINPF5+ZSzbFYJJuepQPoMOG/cNJ5NpoOaHbxVC
 s8ymeczh5K1i79/gtoI+SXY/TJGe74nug924bfVyOWC2jnybXabbUo1YX5MAQ0794miOMo8s8H2
 FOfYP+SywW93vUtJDBjE7P1qxwDJSH1aWjRm+7668qviZpEPITeWIxc1N130nRx9JSC1iQ==
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Mark the UFS host controller and its UFS configuration clock
controllers for SPL, so that SPL can load the firmware FIT from UFS when
the UFS devicetree overlay enables the controller.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/dts/mt8371-genio-common-u-boot.dtsi | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/mt8371-genio-common-u-boot.dtsi b/arch/arm/dts/mt8371-genio-common-u-boot.dtsi
index 70c538a690e..7f614323c93 100644
--- a/arch/arm/dts/mt8371-genio-common-u-boot.dtsi
+++ b/arch/arm/dts/mt8371-genio-common-u-boot.dtsi
@@ -32,7 +32,10 @@
 };
 
 &gic {
-	/* Retain the eMMC interrupt parent even though SPL uses polling. */
+	/*
+	 * Retain the storage controllers' interrupt parent even though SPL
+	 * uses polling.
+	 */
 	bootph-pre-ram;
 };
 
@@ -64,6 +67,18 @@
 	bootph-pre-ram;
 };
 
+&ufshci {
+	bootph-pre-ram;
+};
+
+&ufscfg_ao_reg_clk {
+	bootph-pre-ram;
+};
+
+&ufscfg_pdn_reg_clk {
+	bootph-pre-ram;
+};
+
 &mmc0_default_pins {
 	bootph-pre-ram;
 

-- 
2.53.0

