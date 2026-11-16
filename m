Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2676D606A31C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 10:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=PP9TouKq;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=xIVpnEF3
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 02956406C7;
	Mon, 16 Nov 2026 10:59:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fsppAcsy2kwQ; Mon, 16 Nov 2026 10:59:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4FD7D406C4
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794826797;
	b=F3rFP/9wgijxuknw/oOW5k00cS6t/5e6wjdOsigsvQJ3ja59SAz6Ti3QJyvx1AO2gyMl
	 fHWtzchwIKLrXgBheyNuz6X4GRruKcE4Z62ceIlOmwu0k9BH1i916eWD/KGycmYK8hgW0
	 sdM8sbMQ8tFBDCzUHgA9NP6eUNZv8fTe4CrEcw2ohJLuB+EjyCg9a9ZyYQQTlPdfNrT7X
	 xtLu0tpO0T0FMG1UFD/wDAAGPzcAwJTIoT29CDBUrY0Uc39q13XXU8pSBl1j7CM8ayPpm
	 bNYAcMt1gODIXHIDjLHz6/y1ckESQHbxgQTyi8ehpvYAgDKbpOBfq4rHiJdrqeRIOvA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794826797;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=7+wRgfE05c4/EZmJwZ9M3VrF13KNXJTp1fI+/8Tu81Q=;
	b=oRj+Nuk1K+WaqNY1wXBfSdvLDbvipGg5VQEqlW2s7OgFx0gTaaK8CvMf/HqBeTDPU6mZ
	 xmcVBaWx3ieYTiqcYUFOMOJ48gER9/mvwngTBDUGZm6sABlKGkoSwckQGk2uJ773UVjsV
	 7wnThYIxJS1EUAP+55ULkkNCzBuH88ZczOlj7hfm29PWZubwA04NOsk5lCdPso/r+S/X4
	 Y6/BymbCq4/ySdU/a56j8+JAraJY6Qrj+NsL8/Q50132Prd8gu+pWpWYo9HYN1HljWlmr
	 4cG6VlFxCHGurFjrQ6eu9w00qQR4mFMMEwaZ/GQM1q7O80WEL104KsyJHAMAK//VHRQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794826797;
	bh=7+wRgfE05c4/EZmJwZ9M3VrF13KNXJTp1fI+/8Tu81Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PP9TouKqJRW2jfSLAvJQz8jRBu8W6qJ3u88M5wubJLPnRag40jI5WaB+fca/8SQnL
	 616hl9TOL8EVTaCXxew7pzlO+5+bU0o0lLQj/La8eAfV0Lc7QOWVy97ywQPyOhELdg
	 drBIOMMnpmSjjWGSVCM8mBPuiefjag96xGiSzFPzGpkY7Gi3s3BtLKdnp0ZSRdJ3nF
	 wolZtTEq7M0YM31elwe1icKQ1nQlM7pmP+kyHc7LiYH993bw9rpliZPh4ZdV+UQ9iZ
	 aSGnt37y1jQVrXlEL5UurKgasLIWtIxosBAN1Yl9HqN3WzPjcRQdW+t4meOjmkLt0w
	 1fNkGJ3XzihqA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4FD7D406C4;
	Mon, 16 Nov 2026 10:59:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id D77312FE
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:59:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B48F460614
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:59:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RMveWJGbfTux for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 10:59:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 970CC607B8
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com;
 envelope-from=andrew.goodbody@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=xIVpnEF3
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 970CC607B8
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:59:37 +0000 (UTC)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4bb6ba3b244so8917155e9.3
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 02:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794826776; x=1795431576;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7+wRgfE05c4/EZmJwZ9M3VrF13KNXJTp1fI+/8Tu81Q=;
 b=xIVpnEF3RUe49r7hM9JWLY7qOKSpsWb+tfM7MIJPCApNuqp2KDrSpxXRDWIjpnLCYW
 U5UcT4+KfVs1iczHLkrFM93qHO6b29S6bfNE861C5dEX/2B/n3YhNLrBqAgQ8de98bp3
 eEI1dYlnECgWTXcIOLNtFwkN59pSINrpSAMjOeWpe7DVX6Ls6YBCGFK2HHjtZ+v8el3/
 OvpT+uXe14iKKjcczwpiVsxPjFxPCRG3evknZutW0PoFabfX/JLhUabmZYGhh3tS7ZMX
 BkeCjEqFhmrl62QFs5Kl0MMr7C5VJnyOD62sfGfiEMHqeuUZCWxzKXIC7AhHv0xOTbuk
 UpMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794826776; x=1795431576;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7+wRgfE05c4/EZmJwZ9M3VrF13KNXJTp1fI+/8Tu81Q=;
 b=xhpkAA+Gmsrw3vrOjFPpEHDw77D2mtpKfx2lebIDzcOllJaW8FpAuv25n71VAhdvaI
 jzVdAPTQev/gs7jAK7DRblChehKHIBQ2cgwqyydDMsqxeEcrWXnVyVpswKyJk0SRsQUV
 Iy6IlIkG+vKRw9bFSAP0wnOZ12hoL1chZtCH4nl4KNUaDixGRSLr0kzcF53BZQtxsDst
 kfpub2recVgpDGO1SuVMbpPwG5fFX0aA6kPd0YolNNcs9XNF58LsI0D76rJpxpasi2WS
 c6GR7AtjXxpnmkHtmpj5z8nymk0TMg/6gGnZKBFYMLxh7OTZnYLaYyNuFlE1PXfWKwTC
 mGow==
X-Gm-Message-State: APuU4Z99R4uJX/bbafWiO2nUy1Peh2OXE0odJ87RWCXZi9lKx09zM4X9
 P5JkPyKTz1WqD67d9c+qRUEffUzYyTFwKcUnKVyxkc7xIxvRGLtMDPrT8Zd/quvGP2M=
X-Gm-Gg: AYBFou3AsQYPJSbBOo52/nPd0U1ApIX5k3Avh4O5sZwM68Iaxer1oR/a/MVyPMQE7Et
 6Q80/9AucuYPwHqkXQs9JABAz9UBw+ERJDeKDeehoqZKmZghK9ll7DhAQtLrlsDiYI2F49OwjVg
 mzLCWX8FuwhrscdWi3Gsep47Pj/qKPHVfnSjtSqxwJ4Eu7I02Gu63n4EEEB/fyiZRCHaCIOxH+n
 Wckh6uJaQCLaEAup9nwhIwaK11pi8YZOtGH7JV37IFtVgQEvApviGLHXIl61W+itGVUJROOliUa
 QVAbN9CU/FHqDkg2BzpwMzPpZLTYegbVdVIwAzeBwWCeQzr1tN5OheAqgYiBkTo/q+J9UtEW5VI
 EfmV+CuHBvrpz36evHbOntRvvl3La9XEYdr+MM2F4oIiNa+zLXo/TnBIkBSuSvm4O3JD5yw9FBa
 1ob3fLFvStfEDPOBGN4SvRZp1PmGDqrXKh5/yxEAHKT1JxY3f6d5/2Lsx7hJMbaTJupKCK7qCEv
 wloOQPRA535hKMuJH7gxgdEHlgkE3I0CD5Jmb+k/bX0IZ1k4ge0tKqNM0w0d1xnO7r7TWj1SYip
 pBxtrnf7ix2SyjkP3A5Fa38Mm9alT/TxcpdPwOJ3dX4CnMUm
X-Received: by 2002:a05:600c:46cf:b0:4bb:6c71:b269 with SMTP id
 5b1f17b1804b1-4bb6c71c1f7mr81448195e9.28.1794826776036; 
 Mon, 16 Nov 2026 02:59:36 -0800 (PST)
Received: from artemis3.elfringham ([2a0a:ef40:ee3:3401:d23b:e87d:8bff:70bb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb64ec7b58sm219594065e9.5.2026.11.16.02.59.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 02:59:35 -0800 (PST)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Mon, 16 Nov 2026 10:59:32 +0000
Subject: [PATCH v3 12/15] tools: Fix typo in name of command mkeficapsule
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-qcheck_fix-v3-12-b6cf7e96944b@linaro.org>
References: <20261116-qcheck_fix-v3-0-b6cf7e96944b@linaro.org>
In-Reply-To: <20261116-qcheck_fix-v3-0-b6cf7e96944b@linaro.org>
To: u-boot@lists.u-boot-project.org, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Linus Walleij <linusw@kernel.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Anshul Dalal <anshuld@ti.com>, 
 Alexey Charkov <alchark@flipper.net>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Carlo Caione <ccaione@baylibre.com>, Yao Zi <me@ziyao.cc>, 
 Michal Simek <michal.simek@amd.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut <marex@nabladev.com>
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

The description for the config item TOOLS_MKEFICAPSULE has a typo, fix
it. efimkcapsule -> mkeficapsule

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 tools/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/Kconfig b/tools/Kconfig
index e151b30217e..78172e8f9a2 100644
--- a/tools/Kconfig
+++ b/tools/Kconfig
@@ -107,7 +107,7 @@ config TOOLS_SHA512
 	  Enable SHA512 support in the tools builds
 
 config TOOLS_MKEFICAPSULE
-	bool "Build efimkcapsule command"
+	bool "Build mkeficapsule command"
 	default y if EFI_HAVE_CAPSULE_SUPPORT
 	help
 	  This command allows users to create a UEFI capsule file and,

-- 
2.47.3

