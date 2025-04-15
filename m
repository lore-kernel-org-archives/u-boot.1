Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24876C369AB
	for <u-boot@archiver.kernel.org>; Tue, 15 Apr 2025 21:19:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B796B82C0C;
	Tue, 15 Apr 2025 23:18:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yoDtx2xh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7CFB82B97; Tue, 15 Apr 2025 23:18:36 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7EB38209C
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 23:18:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-39c0dfba946so4465656f8f.3
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 14:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744751914; x=1745356714; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3ohqNOY5VP7rOggwHli2uwz++MOq8E8XGIM1+khD4xA=;
 b=yoDtx2xhnOgArlJIIZrqIr/oB9oBGQSDP555I/A591mQSmSo0A2VfCFrjvK4Jzj3La
 LruQWA233nltLl0lOUgV5yJ/LRRW7Z9rdl+BzFAnigDa5ivxRU1Vwfun7Ub6oiRq647k
 yM/Rt1y0YqdfW8SB4BM67d9KreRf7tn1wXgMyBolTFHPH/1vjhUdykKq9Kj+EnA5u+E9
 Jt98LMyA9ScZleZQE9BHl/0BjZ5YJakd6y3fbAUfofp+xZ2pNwBkJRXXvs0NC70pTEDu
 AOA06UBdvzn8/zwMNLWw7EN6PuMcjrP2TPDQIQPkECnRrBOtBAKk8HAZ7qJccJSyVJkD
 FjtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744751914; x=1745356714;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3ohqNOY5VP7rOggwHli2uwz++MOq8E8XGIM1+khD4xA=;
 b=mh4Z1yuk4ds5rPftFhlDgpiqwsli3mtgwA7rjPptt+O44ePN7jhxPC1SHa20vP6cHt
 9kWxsITUqLHFJYsu2tlr6WQahX/Uh5XruV9SamjPuXcO5bY+Zi6UdNEDoJh5aVb5iyho
 F/EtPdcLp9nq1M/xGftfJiJDqKDPfj/61vG/hWrFvlbn/Hp23c2LqYijXOmXUb3iQeK3
 YxGFLg/r7REo34NdAa2Fe5IBjGrtxVuvCqgP9hqSi80ycqqsS3t0xHAQkNCTYQo/TGxH
 Zw30BVAwFUKH2593JJ0dikdFiMbtkLypifGnaAY9XWTbVvgdJMiLsbIaw9ZtXOCiH1bB
 s+uQ==
X-Gm-Message-State: AOJu0YwPgl5yC/5LnNda7Wr0sYMAcoS38tPxzyuV6hpAjgtkeFeUp1SX
 Qqt+9AhM/nv2+xgky2Omk46Czx2OHA8DQflQTWRJ/oRAjW4jyaJC1xcHHGub5y3be6kLKq780Uj
 E7+0=
X-Gm-Gg: ASbGncvrerJRM6jlGHcy3lMIPfC+IpTNFen5mdPcenBDIqWs+yYFOOGjFTA8jWEbjlJ
 nRgFdow2a200bVXiLWr+L2yDQ+YxTQZbqfHydJSvmkWV/j1M1rOGMTOhTOtUmMIPJzW5EKzrnQo
 8cvQBmSUAzPPQYCecxo5kbjbTxNs/HSPGn9R8C6Zf130B5Uu0EHD6EN6YWGiSmYZx4mcQguQHDx
 lq0iGAvPMbwd8gRwElFL5NIbBfvrbpcobiKchyWppFldSG45Wn2nrdcD+JyE7sq6d8GQah/sV6J
 XgmsAIsp3jo1a3i5OtcTVhoeOB34Noga85LfrH0W7tTexu5s
X-Google-Smtp-Source: AGHT+IG9bBz7v+4MqiKrtGlE7Ea2rg64jtHIYjhXWuVKeVVvwMgNE1Ugkoq4SA7Yl26c1KmJJM+xpg==
X-Received: by 2002:a05:6000:4007:b0:391:2e6a:30fe with SMTP id
 ffacd0b85a97d-39ee276068emr764099f8f.39.1744751913997; 
 Tue, 15 Apr 2025 14:18:33 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:6ebc:6ce:770e:95f9])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eaf43cce3sm15530917f8f.74.2025.04.15.14.18.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 14:18:33 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>, Mario Six <mario.six@gdsys.cc>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 06/11] sandbox: provide static IP addresses for eth{2, 3, 5,
 6, 7}
Date: Tue, 15 Apr 2025 23:17:41 +0200
Message-ID: <20250415211819.1254435-7-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415211819.1254435-1-jerome.forissier@linaro.org>
References: <20250415211819.1254435-1-jerome.forissier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The tests in test/dm/eth.c and test/dm/dsa.c use interfaces that have
no static IP addresses configured in the board's default environment
file. That will be a problem when NET_LWIP=y because the lwIP stack
refuses to send ICMP packets through an interface that doesn't have an
IP ("no route to host"). Therefore and in preparation for enabling the
sandbox tests with NET_LWIP, provide such addresses in
board/sandbox/sandbox.env.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 board/sandbox/sandbox.env | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/board/sandbox/sandbox.env b/board/sandbox/sandbox.env
index a2c19702d64..29197f56e95 100644
--- a/board/sandbox/sandbox.env
+++ b/board/sandbox/sandbox.env
@@ -8,6 +8,11 @@ stderr=serial,vidconsole
 ethaddr=02:00:11:22:33:44
 eth6addr=02:00:11:22:33:47
 ipaddr=192.0.2.1
+ipaddr2=192.0.2.3
+ipaddr3=192.0.2.4
+ipaddr5=192.0.2.6
+ipaddr6=192.0.2.7
+ipaddr7=192.0.2.8
 
 /*
  * These are used for distro boot which is not supported. But once bootmethod
-- 
2.43.0

