Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D3BDC47DB3
	for <u-boot@archiver.kernel.org>; Fri,  2 Feb 2024 12:32:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18F0E87CF4;
	Fri,  2 Feb 2024 13:31:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ROuMXJT4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF9478784B; Fri,  2 Feb 2024 10:44:43 +0100 (CET)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com
 [IPv6:2607:f8b0:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7715D875B9
 for <u-boot@lists.denx.de>; Fri,  2 Feb 2024 10:44:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seashell11234455@gmail.com
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6dfefb490f9so839531b3a.1
 for <u-boot@lists.denx.de>; Fri, 02 Feb 2024 01:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706867079; x=1707471879; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ohpC55d9yZLK3GTuEnNR6EZtIO+SPBzQ/rL5n3InUqk=;
 b=ROuMXJT4QJLx+hj0sfhw07VC7Ah/XIjZbbMg164d6OzRf7uHJElNUS4ZaBrqJ8vscl
 0PJ+UM0FtZF3KtXzmJJ1no2znv98LC/eU4haE3TrwpivhVsNMBDwdGnfSz+7fECUK5MQ
 Xs/c8OjzBh8LF/CqSy5iuoyAOBCLcFsBcKJvtXGZjtSm2K8WJPc+Rk8AUNC7BhKuV0cG
 N4cUCkmHNJd4oWs5/lsn8XG1+M4enhpf4YS69ZMLKjeT+OtlaHR438xFQFypDRk2B3Ze
 25mnMYS90T3Egnqi3PycmVmU6V9ID4Ee9GgSiqtX37eA8pQxqEFw1ENon+2xA29h3BiP
 cL6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706867079; x=1707471879;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ohpC55d9yZLK3GTuEnNR6EZtIO+SPBzQ/rL5n3InUqk=;
 b=tZb8k6MnUdxRi7aqm2zzfUYIkcgpxR9cRRQuSbxiF5OlMKMBi1Lf5UFKtUVuMbCBC+
 aKgTHLW1W/JyfRMghGuwUSdNgKneNNfaD1J2NDhW/5XEHFGoBFlTQJhviARCqGNK/Jl7
 H+qmkvl5FbZiXEg9j5PhREegPYQ/ksBFeP6i0lQNinJhRS+nHOJNKdAbl3Cy7UeDnSrR
 46d8qy08VdwEQ4nWjF3HHFSEx/c0ValqtsuNHT61UjwCBbu8hrkTKTUdQPSCMXKEhCgr
 oToXqe7ykVFZDRO7KYjhrVg0F3VvQtFxy7Ab19uqn1wO390erAQk/OhdGjSENRqnc93g
 8j5g==
X-Gm-Message-State: AOJu0Yw0YRiDPN+K01I1urpfYqFgd763S1D8AbhBGkpDu6c4Kv+eo8HG
 vDM+EXCTt0eu+brqvV9H1cg+jp/14Vl4nJ/hTxiSLxk6YAu/7/gKuxucjvdDpMTi8Vnz
X-Google-Smtp-Source: AGHT+IFjlyYf69H8klLNkYVwRSN2fKOfNYsD4XLwniq5a1dpVbIXSkHdxZ4kFHZvOJ/HO5FRxyp5mg==
X-Received: by 2002:a05:6a00:1989:b0:6db:afd4:f54c with SMTP id
 d9-20020a056a00198900b006dbafd4f54cmr2102257pfl.0.1706867078733; 
 Fri, 02 Feb 2024 01:44:38 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCVvUtYeHclp+U+VhiBt3o/a+sTe97mPZNkIxArNzxfQSlf7ICGRq9n90wv2x0X6skesmshGupCKifg6RGai/Jcg26He3DgxfbR+Ekz8tsjXJeWSpFrqkQ==
Received: from localhost.localdomain ([125.126.161.226])
 by smtp.gmail.com with ESMTPSA id
 fn27-20020a056a002fdb00b006dd8985e7c6sm1190979pfb.1.2024.02.02.01.44.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Feb 2024 01:44:38 -0800 (PST)
From: Kongyang Liu <seashell11234455@gmail.com>
To: u-boot@lists.denx.de
Cc: Leo <ycliang@andestech.com>, Rick Chen <rick@andestech.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/4] riscv: dts: sophgo: Add clk node
Date: Fri,  2 Feb 2024 17:43:34 +0800
Message-ID: <20240202094418.334221-3-seashell11234455@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240202094418.334221-1-seashell11234455@gmail.com>
References: <20240202094418.334221-1-seashell11234455@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 02 Feb 2024 13:31:24 +0100
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

Add clk node for cv18xx SoCs according to patch from Linux kernel.

Link: https://lore.kernel.org/all/IA1PR20MB4953355805F79ABDD7FE9129BB6D2@IA1PR20MB4953.namprd20.prod.outlook.com/

Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>
---

 arch/riscv/dts/cv1800b.dtsi | 4 ++++
 arch/riscv/dts/cv18xx.dtsi  | 6 ++++++
 2 files changed, 10 insertions(+)

diff --git a/arch/riscv/dts/cv1800b.dtsi b/arch/riscv/dts/cv1800b.dtsi
index 165e9e320a..baf641829e 100644
--- a/arch/riscv/dts/cv1800b.dtsi
+++ b/arch/riscv/dts/cv1800b.dtsi
@@ -16,3 +16,7 @@
 &clint {
 	compatible = "sophgo,cv1800b-clint", "thead,c900-clint";
 };
+
+&clk {
+	compatible = "sophgo,cv1800-clk";
+};
diff --git a/arch/riscv/dts/cv18xx.dtsi b/arch/riscv/dts/cv18xx.dtsi
index 2d6f4a4b1e..6ea1b2784d 100644
--- a/arch/riscv/dts/cv18xx.dtsi
+++ b/arch/riscv/dts/cv18xx.dtsi
@@ -53,6 +53,12 @@
 		dma-noncoherent;
 		ranges;
 
+		clk: clock-controller@3002000 {
+			reg = <0x03002000 0x1000>;
+			clocks = <&osc>;
+			#clock-cells = <1>;
+		};
+
 		gpio0: gpio@3020000 {
 			compatible = "snps,dw-apb-gpio";
 			reg = <0x3020000 0x1000>;
-- 
2.41.0

