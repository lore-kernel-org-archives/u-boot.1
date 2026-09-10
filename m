Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AAD6C79FBB
	for <u-boot@archiver.kernel.org>; Thu, 10 Sep 2026 22:08:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BACE140B91;
	Thu, 10 Sep 2026 22:08:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8qyPA-XDYE5b; Thu, 10 Sep 2026 22:08:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org CA50340B81
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789078115;
	b=qtz8GRz8VlXxwM30JBl6pSka4hwebpx21OXfGjakZTayttrdi0KGijdSMEScxJujfipK
	 xifh7NUPOqh1Su6N317d0cSayrY6rnR3zx9rwqSIQDizXdjDzE1Q877pWCwRwM8j5X9hC
	 ffOcE1quWDcAOwMSfoVDgRW7DjoXQI1IgG+Ctv58w7yWynRujuBiQnVq1nF++EtyoVgEL
	 5VlQ1PWFjxtdc6tnvR7sE5cs+LARjYMvZB9DWqoz7UIHwMTdN7PZuv/XPLNQTmYLGh3FC
	 7W4KHn9GcvuKV4NiUp8aiStK1IZvkk+b28ZpL83gVWU7nvywE88idNUgl7ryHF24PwQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789078115;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=DI508Ptwc/eAB9uEmrvbCuYFkMEIrjxgO9wmndM4Dgg=;
	b=HA5rUz8Nh8ItMcBIJo3UUTIs6Er3yCwXt25d3dfOLiKqsYqT1aLRWkc9eTTJ1FcZLyri
	 NpiM13SE7SNg6Afcse9xCplrKYA57gmt9geD5rDwiWBQpVIxI1o3dHW6rElVReMIDV9FX
	 yWaqR5RnGuDDOgRskkSYaPEU8j28hDqhJjOawHUeyNAXLEKBpkQeMHdEg3i0yXf8nltz9
	 1ink3cmLVRNMW7JoSB6HKSnJEv+1PVGUvaAIzoqONVZVl1MiTjibRdybZIRkpojGNmDGA
	 94fXILONNnkuEeYEzg2aIaTnwBN4fi1N4hGKFT/G10SRsSaSObs6dlAZVaDDrxJfEXg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789078114;
	bh=DI508Ptwc/eAB9uEmrvbCuYFkMEIrjxgO9wmndM4Dgg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Nf0qh9CGRxSChmosA5YnLoBp2FH4JcUFuHdPvL+SfiIByMslLJNhrfz497+BAu7Bg
	 x5SbRJHPhzdknKdaGz2Ilg1vefarG4f796pmXJw+YH05WnUexYgLJ38B1nSaIZcNi4
	 YHmXLSJpd1obJQsZQaQrt+DaNpOzB+qpHXUvz0nnoZoGqvrBHPwxr7+p3kv+AME0GR
	 icjVOF4y8e0V3XbWGeM8N+cHbp4Vp+mn79eRoP0pv+C5rviMBSHW92uDtIb2cgNq6s
	 g9X5HczwBG8pxlBXRIpHm+MVmWe/GtXKNETZ4v0xmFUJ3VOoZWqW7SIVNzEUgRO0SR
	 L3gC1rbBSHk5g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CA50340B81;
	Thu, 10 Sep 2026 22:08:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 051032D0
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 22:08:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EACED810F0
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 22:08:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZlGrQHndbawG for <u-boot@lists.u-boot-project.org>;
 Thu, 10 Sep 2026 22:08:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org AB145810CF
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789078109;
 b=q+cb0wSE5B+/H3uh7aqwC8RufYRLHr+cxhMot0mPWwQv7jDzeJmySA6iiHg8zQM+X9Ls
 g1P92M8WEPoiHT0hTW/Vskj+EkiGA8cGJ+vRZiUsjL5rB+J7q+rdqUk6Usf/iUBlQCG/2
 BZ0AfiPjvOC7dm1q2/V5AVc4kcS7YfD7bXCLbmt4Nzvc25Q2Ed6yBCld7eSXHm6ejgvUl
 jBMN8tNwsg2Q7kPW67NfM8R5vZ2rSGu6w2snfX0fYx0YXnNATTeoa3pc66IAWTp0HFLZS
 EsHcXXy4dIWUme/W2oyVFhgJ3f2IpUGYwl3JIYIiO0d11iqlFu9FVU3ymjkwBCuttgQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789078109;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=DI508Ptwc/eAB9uEmrvbCuYFkMEIrjxgO9wmndM4Dgg=;
 b=IsDjSBe/3mfFbCDSrAlShWUwMvt0btJegZBYhZvensI0P1HSovwWgHFTTgItw2QjpTsb
 9ByVn274N3KMZXgsbzZCpSf4MS2XzndVKlb1mMaACJm2vOsnYcGGE6+NzPI9Zupq+syXp
 eqqlg2jYWnFVFzWG2jSuW39syYh2G4wSWGOrzQe/MkLIeBgZqXxEvQBcNRFixgfQO6zk4
 ymlwh6LlVQy94fssU3KAviBg4MdXSvTyGtJFMAPNtyo4opN5+n/OWbAMMkWbDZck6IYIQ
 rJeYytowpVf67CP2N6beaaVlqAVMJLyy3GRsDJ+nlH6bvCKVrGD90cGHCJ41IWQ5f0g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=cqSaPPYg; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=cqSaPPYg
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AB145810CF
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 22:08:28 +0000 (UTC)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-49b0d78a801so3000315e9.2
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 15:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789078106; x=1789682906;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DI508Ptwc/eAB9uEmrvbCuYFkMEIrjxgO9wmndM4Dgg=;
 b=cqSaPPYgi/wy+sc5nZQYBQY10RaybF0vWYlHQaF2Pd3MbSLO69uUJSmJIwaErDs8tz
 K6a53WLAFBRgHS78VT8JlDt9nsjs6WMPpHEBPEAYvmYygNSNx4BzQ9uSr2zm9e+98Lbx
 0hDwDrL1akJFsFvj4kasD78BoZD/zL2fY89kueAIKu/ZnsBnjX37r5ORJiJQ0YmV1s7Q
 4bGiKs8hOMq9wHOFraJsu7OskpCIDIsB/T/SkWyAyy2kEDQC08/NBkkHMW1TmAez+OTT
 QBDSFevJmYglcheT4mnaGvGwmkIYttxYJKw8y6/qNhP/W4ksiH9k0PX/8sOeWcAfvwBw
 dN/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789078106; x=1789682906;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=DI508Ptwc/eAB9uEmrvbCuYFkMEIrjxgO9wmndM4Dgg=;
 b=P71905ixM0OTOoatKlwNBfsp6pedm6ZrcL2C4oliTs2d1gfzLbatYnJ5LAiMrPJDaF
 AZz5sapLyOFjDpOHG5NIl6JL3XzYNUdtRqGIKi7ACwGM5HGDHc44yhY2xH/8hvR+tu85
 NtILMzx7RQl5b7wrNgYilZrqqt+kLHv5oNVZZ+LfYBWp5m+qto+DuZBR0BPbQP0Q9vnZ
 XKJQLVS3swl0FdhlVXxD7lvDJQ9Tr7UlEruqcOXHlf7qhfpaJ7OfYcZo0HAFBg8UkIzk
 ajGNGTYZzkggB3fHAwTAynIfWHsZRXlpzTSuvim+K4OrP2qRO4sKiGtiYv7AOR2Maztk
 eLjw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzgGQxjCW8uBcnlJRyUfVNm67MxLPfEYYYVIVtwOb0RNuRD7RZcnWnmcwEAdxQHhPlUyYNn5sY=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nskEZH6KomcfM5MBUBvJYgbK4Mpu1PCOyWAdTrfsVHA5laT3jj
 WHo0yHpC8/rM0NU6vOBju1VY9L6Wrvz3KoFKukzbWedpVHFXXQe1ixD0
X-Gm-Gg: AYBFou3p2wQCwapSTcl7QgX3rIhp2cSUycHhT11mur4kpYST3IxwIUTJ2XwBuUiBPKl
 TabRU9hUzjXXSCBGkXQdekHf0WvB+aJvbbQBxT2NjkwPalkaIn8C04GVOtGPL+uPUIhLOjcCy/r
 pPuLv0IsegLPtvF5yQbHR4LUjXInwz5SlkWdPWsG3migaSH4VsAidmhBbD9nFnMWDqufL9+MwVK
 2yvpkrUllC22PKy4EUVSau7AL8iI+dhDXJUROaVSFnbSmfWO2AQCHKpc3w4wGGeiO2Pc9cqLz4H
 goMveOhzS47q1N5HWGIrcW46kzrHjMMBdb6r/VHGelIWQdrYBPZ6YgwVM/2dVzfSFAJbctjm6SO
 2nMa3F55Sw7ZK/x/CgNiiGzuJ7cd7hsK4oFDk++WQL3Ij6jfaBNuUmZmHg4jZR15vU3TeQqNvDA
 bzVhed/HXiXJsEntRjzuZNMF9ACu0vuM40Qi+HQdJgcVQlrpGrLG1Pyi5MxN+s5j+R43o4P0VW4
 mD3
X-Received: by 2002:a05:600c:6290:b0:49d:2579:1894 with SMTP id
 5b1f17b1804b1-49e619a047dmr8662795e9.6.1789078105987; 
 Thu, 10 Sep 2026 15:08:25 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e62231360sm4795595e9.4.2026.09.10.15.08.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 15:08:25 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Vincent Jardin <vjardin@free.fr>,
 Ye Li <ye.li@nxp.com>, Michal Simek <michal.simek@amd.com>,
 Aristo Chen <aristo.chen@canonical.com>, u-boot@lists.u-boot-project.org,
 Mehmet Fide <mehmet.fide@screeningeagle.com>
Subject: [PATCH v2 4/4] test: dm: check the regulators claim their GPIOs at
 probe time
Date: Fri, 11 Sep 2026 00:08:18 +0200
Message-ID: <20260910220818.3093364-5-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260910220818.3093364-1-mehmet.fide@gmail.com>
References: <20260910220818.3093364-1-mehmet.fide@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Mehmet Fide <mehmet.fide@screeningeagle.com>

Give sandbox a fixed regulator with an enable GPIO and a gpio regulator
with a voltage GPIO and check the two phases explicitly: after
of_to_plat() the pin is unclaimed in the GPIO name table and its
simulated direction is still the input default; only probe() requests
it and turns it into an output; enabling the regulator, or switching
its voltage, then moves the pin.

The pins come from the pinmux-gpios bank, whose two cells also carry
the flags the way a real regulator node does; the base-gpios bank has
no offset left that the other tests or its hogs do not use. The gpio
regulator driver was not built for sandbox before.

Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
---

Notes:
    Changes in v2:
    - move the regulator to c8 in the pinmux-gpios bank, a10 is a hog pin
      (Simon Glass)
    - name the node fixed-gpio-reg instead of the compatible (Simon Glass)
    - add a gpio regulator on c9 and a test for it, enable
      CONFIG_DM_REGULATOR_GPIO in the sandbox defconfigs (Simon Glass)
    - check the simulated pad direction, not only the name table (Simon Glass)

 arch/sandbox/dts/test.dts          | 18 ++++++++++
 configs/sandbox64_defconfig        |  1 +
 configs/sandbox_defconfig          |  1 +
 configs/sandbox_flattree_defconfig |  1 +
 configs/sandbox_noinst_defconfig   |  1 +
 configs/sandbox_spl_defconfig      |  1 +
 configs/sandbox_vpl_defconfig      |  1 +
 test/dm/regulator.c                | 58 ++++++++++++++++++++++++++++++
 8 files changed, 82 insertions(+)

diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index a5d8d3977a0..b05f4c24c3a 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -883,6 +883,24 @@
 		compatible = "sandbox,fpga";
 	};
 
+	fixed_gpio_reg: fixed-gpio-reg {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-gpio-enabled";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		enable-active-high;
+		gpio = <&gpio_c 8 GPIO_ACTIVE_HIGH>;
+	};
+
+	gpio_reg: gpio-reg {
+		compatible = "regulator-gpio";
+		regulator-name = "gpio-switched";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+		gpios = <&gpio_c 9 GPIO_ACTIVE_HIGH>;
+		states = <1800000 0>, <3300000 1>;
+	};
+
 	pinctrl-gpio {
 		compatible = "sandbox,pinctrl-gpio";
 
diff --git a/configs/sandbox64_defconfig b/configs/sandbox64_defconfig
index 070ef0b6369..59e08d03f77 100644
--- a/configs/sandbox64_defconfig
+++ b/configs/sandbox64_defconfig
@@ -220,6 +220,7 @@ CONFIG_DM_REGULATOR=y
 CONFIG_REGULATOR_ACT8846=y
 CONFIG_DM_REGULATOR_MAX77686=y
 CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_DM_REGULATOR_GPIO=y
 CONFIG_REGULATOR_RK8XX=y
 CONFIG_REGULATOR_S5M8767=y
 CONFIG_DM_REGULATOR_SANDBOX=y
diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index c6edd9d2423..5ebbe5ca8f6 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -308,6 +308,7 @@ CONFIG_DM_REGULATOR=y
 CONFIG_REGULATOR_ACT8846=y
 CONFIG_DM_REGULATOR_MAX77686=y
 CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_DM_REGULATOR_GPIO=y
 CONFIG_REGULATOR_RK8XX=y
 CONFIG_REGULATOR_S5M8767=y
 CONFIG_DM_REGULATOR_SANDBOX=y
diff --git a/configs/sandbox_flattree_defconfig b/configs/sandbox_flattree_defconfig
index 9546fbf730f..57f915d4ba9 100644
--- a/configs/sandbox_flattree_defconfig
+++ b/configs/sandbox_flattree_defconfig
@@ -175,6 +175,7 @@ CONFIG_DM_REGULATOR=y
 CONFIG_REGULATOR_ACT8846=y
 CONFIG_DM_REGULATOR_MAX77686=y
 CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_DM_REGULATOR_GPIO=y
 CONFIG_REGULATOR_S5M8767=y
 CONFIG_DM_REGULATOR_SANDBOX=y
 CONFIG_REGULATOR_TPS65090=y
diff --git a/configs/sandbox_noinst_defconfig b/configs/sandbox_noinst_defconfig
index 0708b65ea80..7a755012795 100644
--- a/configs/sandbox_noinst_defconfig
+++ b/configs/sandbox_noinst_defconfig
@@ -219,6 +219,7 @@ CONFIG_DM_REGULATOR=y
 CONFIG_REGULATOR_ACT8846=y
 CONFIG_DM_REGULATOR_MAX77686=y
 CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_DM_REGULATOR_GPIO=y
 CONFIG_REGULATOR_RK8XX=y
 CONFIG_REGULATOR_S5M8767=y
 CONFIG_DM_REGULATOR_SANDBOX=y
diff --git a/configs/sandbox_spl_defconfig b/configs/sandbox_spl_defconfig
index 11f16f5d622..60b497f4888 100644
--- a/configs/sandbox_spl_defconfig
+++ b/configs/sandbox_spl_defconfig
@@ -186,6 +186,7 @@ CONFIG_DM_REGULATOR=y
 CONFIG_REGULATOR_ACT8846=y
 CONFIG_DM_REGULATOR_MAX77686=y
 CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_DM_REGULATOR_GPIO=y
 CONFIG_REGULATOR_RK8XX=y
 CONFIG_REGULATOR_S5M8767=y
 CONFIG_DM_REGULATOR_SANDBOX=y
diff --git a/configs/sandbox_vpl_defconfig b/configs/sandbox_vpl_defconfig
index c7df8571663..c85bfbfb3b1 100644
--- a/configs/sandbox_vpl_defconfig
+++ b/configs/sandbox_vpl_defconfig
@@ -193,6 +193,7 @@ CONFIG_DM_REGULATOR=y
 CONFIG_REGULATOR_ACT8846=y
 CONFIG_DM_REGULATOR_MAX77686=y
 CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_DM_REGULATOR_GPIO=y
 CONFIG_REGULATOR_RK8XX=y
 CONFIG_REGULATOR_S5M8767=y
 CONFIG_DM_REGULATOR_SANDBOX=y
diff --git a/test/dm/regulator.c b/test/dm/regulator.c
index 51007d4079d..123cee6f499 100644
--- a/test/dm/regulator.c
+++ b/test/dm/regulator.c
@@ -12,6 +12,7 @@
 #include <log.h>
 #include <malloc.h>
 #include <dm/device-internal.h>
+#include <asm/gpio.h>
 #include <dm/root.h>
 #include <dm/util.h>
 #include <dm/test.h>
@@ -195,6 +196,63 @@ static int dm_test_power_regulator_set_get_current(struct unit_test_state *uts)
 }
 DM_TEST(dm_test_power_regulator_set_get_current, UTF_SCAN_FDT);
 
+/* Reading the platform data must leave the pin untouched, probe claims it */
+static int check_gpio_claimed_in_probe(struct unit_test_state *uts,
+				       struct udevice *dev, struct gpio_desc *chk)
+{
+	ut_assertok(device_of_to_plat(dev));
+	ut_asserteq(GPIOF_UNUSED, gpio_get_function(chk->dev, chk->offset,
+						    NULL));
+	ut_asserteq(0, sandbox_gpio_get_direction(chk->dev, chk->offset));
+
+	ut_assertok(device_probe(dev));
+	ut_asserteq(GPIOF_OUTPUT, gpio_get_function(chk->dev, chk->offset,
+						    NULL));
+	ut_assert(sandbox_gpio_get_direction(chk->dev, chk->offset) > 0);
+
+	return 0;
+}
+
+/* The fixed regulator must claim its enable GPIO in probe, not before */
+static int dm_test_power_regulator_fixed_enable_gpio(struct unit_test_state *uts)
+{
+	struct gpio_desc chk;
+	struct udevice *dev;
+
+	ut_assertok(uclass_find_device_by_name(UCLASS_REGULATOR,
+					       "fixed-gpio-reg", &dev));
+	ut_assertok(dm_gpio_lookup_name("c8", &chk));
+	ut_assertok(check_gpio_claimed_in_probe(uts, dev, &chk));
+
+	ut_assertok(regulator_set_enable(dev, true));
+	ut_asserteq(1, sandbox_gpio_get_value(chk.dev, chk.offset));
+	ut_assertok(regulator_set_enable(dev, false));
+	ut_asserteq(0, sandbox_gpio_get_value(chk.dev, chk.offset));
+
+	return 0;
+}
+DM_TEST(dm_test_power_regulator_fixed_enable_gpio, UTF_SCAN_FDT);
+
+/* The gpio regulator must claim its voltage GPIO in probe, not before */
+static int dm_test_power_regulator_gpio_value_gpio(struct unit_test_state *uts)
+{
+	struct gpio_desc chk;
+	struct udevice *dev;
+
+	ut_assertok(uclass_find_device_by_name(UCLASS_REGULATOR, "gpio-reg",
+					       &dev));
+	ut_assertok(dm_gpio_lookup_name("c9", &chk));
+	ut_assertok(check_gpio_claimed_in_probe(uts, dev, &chk));
+
+	ut_assertok(regulator_set_value(dev, 3300000));
+	ut_asserteq(1, sandbox_gpio_get_value(chk.dev, chk.offset));
+	ut_assertok(regulator_set_value(dev, 1800000));
+	ut_asserteq(0, sandbox_gpio_get_value(chk.dev, chk.offset));
+
+	return 0;
+}
+DM_TEST(dm_test_power_regulator_gpio_value_gpio, UTF_SCAN_FDT);
+
 /* Test regulator set and get Enable method */
 static int dm_test_power_regulator_set_get_enable(struct unit_test_state *uts)
 {
-- 
2.55.0

