Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11C97C77B7F
	for <u-boot@archiver.kernel.org>; Mon, 23 Jun 2025 23:49:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5441382D60;
	Tue, 24 Jun 2025 01:49:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JExbnS4J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E889A82D21; Tue, 24 Jun 2025 01:49:20 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CB918210D
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 01:49:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3a54700a46eso2666172f8f.1
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 16:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750722558; x=1751327358; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QRL8f8fDn0DOQwJ7Ab8HjS4aIm22X/LClYFoKwweCsg=;
 b=JExbnS4JotFipuZFi9uDbfpf0PAIouPs40TQ5Jh6Foq0/wp9Yvnzdo0qKpaNjWfU8J
 5jMoKmz5LG9LLxyZLr7+bhJXN5DEVyQ+xGx2xOWvIcIvMKqIbBQLoN3X01TlkOwTRZep
 q+eZo0bjCBKUnY+GRSlhrEFLdpZ5VGcYnbfBPxv2wIfPntbAW0a+44ppOx18+RpIM9or
 KSlX1Fy3zsOPc0yxRiIMdXxgYfYQnuk2Ol50dziRPK5KIuwW/Pvy8DEbytWW8dIc7/MM
 Ge6sXtbC8SIk4awxHdF3xfsG59f0Vs0oYdMB5tJV4AdjRyxhTMzBAELquTL6sv9s8oLt
 5MVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750722558; x=1751327358;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QRL8f8fDn0DOQwJ7Ab8HjS4aIm22X/LClYFoKwweCsg=;
 b=I1goNV7mRqAGNRGVnP8hqAJ5On2HItJySGrmRYVLqAW+lze0AcXm1NWKD+wtceIONo
 iK2AzxDGLDU+8LNBdkS0QFUQGCuzuDzuegR0Zp9M21CkZ0K4KRmPMk7WpUYRoroGjVvI
 piFegO3lQj7N9yPPf1vNchRqtWypBkTtHT21zBdlkbjUUnbH1EWTyq6DtDqfdz0L9Rse
 zthb8Vf6Yn9hrFLK/W/cGP1Xl3yyjIZqII2rsRTlpn5NgmxWRyRvX3T1TWTjXzquaEQo
 5TrrhIK1tDt0GCMVh1b9xGYbeoqFaqhxTHE3Ju/z7rTp/YqVvJrqcVYO9tzEjS/+x3F5
 AI/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqUx639eXcoJE0s3LkbNQhnx/wfqhXox9EcuizNfRAVviGEOn7orhZuquCvO6Bbv8xqLWhb5M=@lists.denx.de
X-Gm-Message-State: AOJu0YzA2a3VTQ1uRlym8VJWEg+6mPqtaDuYAM1zl8ZUfj3D3QL9TY5y
 hDsXDSFlpma+SlXkJ3QXR5092ZY5pyMfI+kyW0mjUEtDjTEJIfRQAwRI41/gjxZQnqc=
X-Gm-Gg: ASbGncuVSS+xx0DeolvHjrdRTiZ83Tsvies9OtVB1OYuvQCOlVPK+3j/QOcmjNRWn54
 TnZQlFgjbzHxo4eaTYt0Xv51DzAwlXn17Z2aLwt/7twfB6vg1weZ38Q67kDEU9kWIA3dhIDyjar
 lKKcJIFZy5ENYjpnLGD7mvQlI75/rsTxVHZYrOloZwlDgEAzTby8ppPsA3VFJibjIQPKOa5N3lp
 yLsR6E3wmqxQBa1mym+dwHEhZKpzRyMDXi7ITiaO1Ejil1fL1qUTsDVACzVO3BPK1otjbRhr/7s
 SkAkNwBnGaG5dycbtXyUgfSqYB9RLQJlNMRzilK0z7XK0QmnoKjEBTsFgQnFwrY6UPbV+W9Dh/Y
 NLqbyan73/sY=
X-Google-Smtp-Source: AGHT+IEKfVp+Hmdm37VeqRWUCxUtxnffu/uy81yK7wsZXFEo+PN5pXZgR9XwUWHSeSAKgOpzZyAbwg==
X-Received: by 2002:a05:6000:2906:b0:3a3:7ba5:93a5 with SMTP id
 ffacd0b85a97d-3a6d130b3b5mr10972682f8f.26.1750722557807; 
 Mon, 23 Jun 2025 16:49:17 -0700 (PDT)
Received: from toyger.tail248178.ts.net ([213.240.182.16])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6e7fb5716sm432284f8f.0.2025.06.23.16.49.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 16:49:15 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: trini@konsulko.com, neil.armstrong@linaro.org, lukma@denx.de, 
 seanga2@gmail.com, Volodymyr_Babchuk@epam.com, lehmanju@devpi.de, 
 sjg@chromium.org, robert.marko@sartura.hr, dmitry.baryshkov@linaro.org, 
 andersson@kernel.org, u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>
In-Reply-To: <20250304110105.2762124-3-quic_varada@quicinc.com>
References: <20250304110105.2762124-1-quic_varada@quicinc.com>
 <20250304110105.2762124-3-quic_varada@quicinc.com>
Subject: Re: [PATCH v1 2/6] dts: ipq5424-rdp466-u-boot: add override dtsi
Message-Id: <175072255531.128390.7779840369106566506.b4-ty@linaro.org>
Date: Tue, 24 Jun 2025 01:49:15 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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


On Tue, 04 Mar 2025 16:31:01 +0530, Varadarajan Narayanan wrote:
> Add initial support for the IPQ5424 MMC based RDP platforms.
> Define memory layout statically.
> 
> 

Applied, thanks!

[2/6] dts: ipq5424-rdp466-u-boot: add override dtsi
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/9997cc261a32

Best regards,
-- 
Casey Connolly <casey.connolly@linaro.org>

