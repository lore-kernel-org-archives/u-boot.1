Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42EC4C88E75
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 03:16:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0BDDA60C26;
	Fri, 18 Sep 2026 03:16:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0auB5nZEJWiu; Fri, 18 Sep 2026 03:16:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 55B6860C18
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789701410;
	b=PzRTBIM9/PJiLMBdPBAlADPnDk5zpXzF3sPwkyFE4yy3UDipEVyAsC8slJ0dGYnJ5cpt
	 nnoRMckgeKvINRAzj9F8989i13PB12jn0chNNcvlyYP6z0rSVtPsrq34pI7TeV3nGfXIw
	 oWmWZwOnnh6QVIiWT0lIbkL+5Z9rpU8lX9RlrSFjFpKxd3xlS3qdcodiC3gat2c/Xxx/u
	 L66wdtS9N/Tz1lJsvlMuiS7lZTS6w8oGYMYc865GA7PFYZuo1aZkxQjG6R20Qs51y4Z00
	 mYaFYUF3bndEOYDlOx2/3c0VZjoEgDe75rxLBUNQ4o0PfDjnjuBs/sHeiPVm5lJGs9Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789701410;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=GRGzfUMCrl4b72ZmzdYuvmmlk3C1mrROKjUoXCURV/s=;
	b=J1ilXPqFSa/8HiP9sdktKhqTP4H0kUTaHr0A66QPYqh+OZXKSCZMadL0hJFIMRysOEdV
	 UxkJ8C1YBeo2v82+U11HqZT2aanF3Ck1IUJeXipofxXQ7etwg+KoTCP20FxHUwzG18fso
	 MR9dSO6A4WStAUn8sAiJ2hrpljJ428ZosQXYueJZFNImnpm6wud7bH3JPup+MtE0Cbpvc
	 /tmS9Re2zzGcVSDLS+3nRt47T46iE9ldh2wY+bkyX1qrYYawmeQpnGv9fG7OQ8AVnnD4e
	 QV5RvPbJI3D63IRbqJsD24IiRZgSvyNd2FViEc80DDyMXQlr8YzVfEnLWx4Mkm3pdIw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789701410;
	bh=GRGzfUMCrl4b72ZmzdYuvmmlk3C1mrROKjUoXCURV/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YIk+2dfdhx87hLiRNrZvZpEdQrJ6CMAiVf48sMJ/LDTERYJlXnXfyGt2r4/Ygi/Kz
	 jQkChYSNtOU5x/cVVl3VfB7EY/oiyVknjY5/Rq6i4dEQdR2sM5sZiSpnBfrgR192Bq
	 85Oe4P6vnkK4btrJvKWUs+1R3R+NXEPd6iCj2xFMOyh59ksWKyO4Ov1j7pkwQklKn3
	 BmEF/zCImfNPC4xnus9dLGe66y2rNAqZ+jymVU1K3w8KheOxUmT2nsz1x4/rNMM7r/
	 Rm0qaF4qJKNgz1tNt4R48QQb9RQrXCDInQdHs103wX06o1SdEDjyC9tMQ0IxGZf5Ed
	 /MsHqdFstoWLA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 55B6860C18;
	Fri, 18 Sep 2026 03:16:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4FC0F3AF
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 03:16:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4215D40492
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 03:16:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m4kUMuSBNt7c for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 03:16:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org B303F4008E
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:39::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789701407;
 b=o6ST0Ud9fxVw6ZSl0DBoAv0rvkN3+UfpQl7S3RZEX5A26mBpb5HTMwiImA37HYQiEHWr
 pt6FWZo9ctFmYZpnecnCF+/nwW5MEAxnKLCk/EIX2K00qJrsNcMhHNDs1VQtTZDyYsv0b
 v2VdJOecU3WtpS4qif+H2rZLlRGxC9kL1Sqzf3vdgjnTbO2dKEKWD2zGS89DVIY5ZNQc0
 AaV76UuIp/quFbQ9EyOIolyvitz0/w1WiwRrI1NzhnSqNg0wo4NPCH8OGyHWSm0+hOOif
 FTahz4XRRfqhQ0Mv4qBOjbjS4PaScJx71hAolPU4OAOACakfYZaSx3I4Ih7WNfzTXPw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789701407;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:X-Google-Original-From:To:Cc:Subject:Date:Message-Id:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=GRGzfUMCrl4b72ZmzdYuvmmlk3C1mrROKjUoXCURV/s=;
 b=R3ftrfxiZocrMr1/7tR9hXeFonS7kzIY2x1Mnv+EWTUgE+NEZX0mes5OfJE6r10+d4MC
 ugEvDUWV3BIPWMljP3vq8w7itv9hFWZt2ePfPQTsZGTaDtjIN+8r6Mkq0rea2TH8zwUzw
 VkG4vKWgWVH8YTHfwMOt00IeR2k+775IVeVaBA/8QmA38it0GqqNCXZVq3/ki37De0DmA
 uruZQij3JDCC1TX/FA3MGz3T8HxjBGdlIZdUbRWw+14qMk/OZWoROYBuOgXw8gh78D6I+
 zsEwk/7MZaMDhSt0Y40y0V7ChpWqjOMK/mKnTGmlruWldliClN2GIjq37+vj/mNRQ4A==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b="UX/vYKBh"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:39::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:39::10; helo=mail-pj2-x10.google.com;
 envelope-from=jim.t90615@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=UX/vYKBh
Received: from mail-pj2-x10.google.com (mail-pj2-x10.google.com
 [IPv6:2607:f8b0:4864:39::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B303F4008E
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 03:16:46 +0000 (UTC)
Received: by mail-pj2-x10.google.com with SMTP id
 d9443c01a7336-2db1ca069c8so2402355ad.3
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 20:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789701406; x=1790306206;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GRGzfUMCrl4b72ZmzdYuvmmlk3C1mrROKjUoXCURV/s=;
 b=UX/vYKBh4C8is5G6VSvJ2rD3HZ3lJgSIU00yznZNIRAr6+1QuInl4HJq+9qZGBrA/K
 2TswZ8iM1gFoak7YRj5E2yH8wHgZFFEDpypIja7APPy6pz/IX9ZbJaa8FqrSe2hWAlBj
 9ff1xfJAemOZ1+qgJ0MELYl0/KaUXmY2kdAUk0PonOaHEqy6sSAkaDtWymdEAYJcF0ow
 jafne9TsXIs4Ya2NzY0yesY8AMvfVXpcUc9MDRwOm8drUT9DGqYRJ5+J5rCGMzyXp9Cj
 9q8z0iMgUGVfCo/Gxoai7HvJNV1KWun8J3EbuvLG4roLBL7TcRAoHOFJfnBk1kqpW3ch
 oj8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789701406; x=1790306206;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=GRGzfUMCrl4b72ZmzdYuvmmlk3C1mrROKjUoXCURV/s=;
 b=x7HOFLF+W0qEAR2LDF5lzX6WHz01q+eM00D/yJpa/Jyc49NDFCosNjmXfrRlyg+r93
 W8EnYgs0Bb9BbQm9JSjEq6be7zfLoz2sG1Q3FgFc7LXbT2nAqW/abe+iy8ycZq+ms17t
 3gpGAoXFIu3MpNGCa6g07bzV3H1LWQVF55943Cc6LDY7GsXa6j24dTwATc58k3ErvsCe
 qAum3Hkvz/xZmtHVPBbGJBmzkHKFD9jb4vNkjdpWRnGhiTzFjDnv7HKrJ2RBBkjBBK3S
 0yq1iUwJFZHYPDRky1U8f4UhP4ZSa9UhhDp4b6jMboxHCN0mhFIOuhyMZDyhDaKuQscs
 p6lA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxxL+qbafUJP0GC9N00rK7rZ3xSDDOBAKucH/DOe5b9z6v0h6kfkWqPDhBFDdPL3V6Ossso59E=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kxSuxS2azrMckNgkOrF/HVt5Nr/8FzKjKyTRWKI8OQaIhNW6Xh
 M3yQckl7zmz6viEnfrqaRUgsx2ZV+4ow/ePB1DyX1TGv5BUE0HIrx6ve
X-Gm-Gg: AYBFou1nHIajpkusLxj6Aodn0K9yfEtaMgRf/X4R7VpM+hhgMlABhwbCLBX1EMlUEeM
 YyIq9qPyZERsISfqXghIPItjOhWlS4qBmGfhdAhon2PaHfa6H7TCQxf3LQmsZ9WH4DEarkbdfmT
 GlHre9xy5h8sFUzEX0mv9I34Oh+dheJtHW6zFMJ9RQbdZCXXoAbZRTTloA+jiAV2U10a5vXR/Tp
 3Ve6fWKIg7MrecZZY/WM8hhNQX0m/IuZ9IipMLYc9AabD4zlx3A2XMn1ThxxgxI5HeL34mWAXZw
 9I5aY4/oM1AkeGLlU/KGtAm2iS4SyDBF9kgID6ePD+JBE8BmVfpkiMsKbZu/+U3yQSJ4UvK7o66
 ymPEz0cAFFc21aI+4t/aNsLIZpfX1EvM7n6WHVAlfyZxOVxdAce/hu1vhnEYP49+DGmZvAift6I
 nsA0VUr4fr5lWyWP719mzjbR1A78Wn/QaCnvmQS5VpQn3Xjngc9rfaPzs6D3Sjw1NmNp0ApMxrW
 PJhKsduzr7rrsJclfk=
X-Received: by 2002:a17:903:22cb:b0:2dd:ad74:6d19 with SMTP id
 d9443c01a7336-2ddb1bca6d7mr25123995ad.31.1789701406369; 
 Thu, 17 Sep 2026 20:16:46 -0700 (PDT)
Received: from cs20-buildserver.. ([2402:7500:500:6259:4c39:1ad1:29eb:e47f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ddb75b53fesm874505ad.59.2026.09.17.20.16.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 20:16:45 -0700 (PDT)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com, jim.t90615@gmail.com, trini@konsulko.com,
 dhphadke@microsoft.com
Cc: u-boot@lists.denx.de, u-boot@lists.u-boot-project.org,
 Ted Lee <xrli@nuvoton.com>
Subject: [PATCH v1 6/6] ARM: dts: NPCM: modify ethernet delay time Modify
 npcm8xx ethernet reset delay time.
Date: Fri, 18 Sep 2026 11:15:54 +0800
Message-Id: <20260918031554.1855939-7-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260918031554.1855939-1-JJLIU0@nuvoton.com>
References: <20260918031554.1855939-1-JJLIU0@nuvoton.com>
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

From: Ted Lee <xrli@nuvoton.com>

Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
Signed-off-by: Ted Lee <xrli@nuvoton.com>
---
 arch/arm/dts/nuvoton-npcm845-evb.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/dts/nuvoton-npcm845-evb.dts b/arch/arm/dts/nuvoton-npcm845-evb.dts
index 1535defe38f..5d6da401b7d 100644
--- a/arch/arm/dts/nuvoton-npcm845-evb.dts
+++ b/arch/arm/dts/nuvoton-npcm845-evb.dts
@@ -152,7 +152,7 @@
 &gmac0 {
 	phy-mode = "sgmii";
 	snps,reset-active-low;
-	snps,reset-delays-us = <0 10000 1000000>;
+	snps,reset-delays-us = <0 10000 300000>;
 	snps,reset-gpio = <&gpio5 30 GPIO_ACTIVE_LOW>;    /* gpio190 */
 	status = "okay";
 };
@@ -160,7 +160,7 @@
 &gmac1 {
 	phy-mode = "rgmii-id";
 	snps,reset-active-low;
-	snps,reset-delays-us = <0 10000 1000000>;
+	snps,reset-delays-us = <0 10000 300000>;
 	snps,reset-gpio = <&gpio5 2 GPIO_ACTIVE_LOW>;    /* gpio162 */
 	phy-supply = <&vsbr2>;
 	phy-supply-microvolt = <1800000>;
@@ -189,7 +189,7 @@
 	snps,mdc-gpio = <&gpio2 27 GPIO_ACTIVE_HIGH>;     /* gpio91 */
 	snps,mdio-gpio = <&gpio2 28 GPIO_ACTIVE_HIGH>;    /* gpio92 */
 	snps,reset-active-low;
-	snps,reset-delays-us = <0 10000 1000000>;
+	snps,reset-delays-us = <0 10000 300000>;
 	snps,bitbang-delay = <1>;
 	snps,reset-gpio = <&gpio2 29 GPIO_ACTIVE_LOW>;    /* gpio93 */
 	status = "okay";
-- 
2.34.1

