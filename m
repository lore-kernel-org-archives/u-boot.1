Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F32606A31C
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 06:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=j3She+Ki;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rGR4J5IX
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 85C8D60A83;
	Fri, 27 Nov 2026 06:36:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9U27tap7aHUB; Fri, 27 Nov 2026 06:36:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 75E8460A67
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795761396;
	b=K0V3TJ5UfQdQJkNAjJ3JYi2JozD3DiCfoYkW2PNOIVLTw8FOlbwFNFPw4GAQHdDliwsW
	 jrvPTZO/4BetgzjbUw70Gjj3FET61g1jqE7qtZKz7bCMLEoqq8YnS5oICkr14D3miDVhq
	 X7hljdi/r4WT7o8PVLPwDEyRrUuXKuavIvoy3bMLGV7CrVD5+VB5cu7O3xgaAsq58ddDb
	 EfrwLADBZyRyfAPoZJmS9EIGYJaedA+NiW+p1iUkjN7HF02eQ1qjHBZ0FhsaIjecmCyb0
	 icOg6TEW72BrFDBFjUqFnCXZoqvN13sO8IHmyBdIm/+Wgfff8blNkdE17lWj0g6enAg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795761396;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=TuVER0CfSrmLTFsnU6SN3oHn7ZIxqRoRgTWvNLBSdCI=;
	b=U9d2NftKn/WXhmSEPtdRi5OrziqIBkSqyeSeQonTnHiyMJBuuuPaUnunKT29rArgE5B1
	 4exVOD9IPrqimWC+o0cveiIFSHX7xfA8stBXQJBOid6y4Rvl97whqVrnwo/LSLfD0COIm
	 eVGqP/wVSWd9tECdDeJgL4JBOj5Qqu9ZLzAIX3JscsnHtH4+/kZM/kAO1y+vw5ryLICG5
	 A54l5cBhJhJ6ooeIlZpA7ILxFFAoOBZxP1S7B25Orsn1RbCwqYngiTrj7RxsWTGBggLXU
	 AynDwKkdErTbpUCr3/mG4ydrSCabR0bynnBMXHzQTBFH+y29L8Ujs3vPcXW1IsWbQxg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795761396;
	bh=TuVER0CfSrmLTFsnU6SN3oHn7ZIxqRoRgTWvNLBSdCI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=j3She+KiFI85gTCA9DUguJzeLGC+vkjjBq52ZoHOBaEYyaHMIFsUHB3n7X2d2/CHf
	 eCHCK8xtxw7ffmTeOV2uge7QdRCyjm6R24c6Q2OpZMxQmLz8Mqjfxp6NSp+ZXHFA1c
	 /4ew3hmYTmALzvLjue4OB42ymLf3Ka8VUs7BTd1160gi246eC0HJ9ii4/oG5yV0diQ
	 N79FFF6bgIFoCbd9XPFP7i3a8S+4oFmPCiLH38SYbpNoPAt1JWg6PULi6L0w9RyEKf
	 Y8TfJhjjtE234Mf10EZ2udGAhSG6zHfjlhXN0HEYJqBfXjwiJMdZYSu8ztoxr2h1uD
	 eMY2TFDipNuKw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 75E8460A67;
	Fri, 27 Nov 2026 06:36:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 595033C0
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 06:36:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4A02F81201
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 06:36:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id et0ykpXM9ryR for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 06:36:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 61815811FD
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::132a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::132a; helo=mail-dy1-x132a.google.com;
 envelope-from=visitorckw@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=rGR4J5IX
Received: from mail-dy1-x132a.google.com (mail-dy1-x132a.google.com
 [IPv6:2607:f8b0:4864:20::132a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 61815811FD
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 06:36:32 +0000 (UTC)
Received: by mail-dy1-x132a.google.com with SMTP id
 5a478bee46e88-3866a784546so10616292eec.0
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 22:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795761392; x=1796366192;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TuVER0CfSrmLTFsnU6SN3oHn7ZIxqRoRgTWvNLBSdCI=;
 b=rGR4J5IXWNtJrU6oxsbJ5cen4TZd2KwPx9pEOhrTYGZo5CJAuMG4SuljSZldTx9iUe
 fglBG8AhLWlGW7JGuMOwcEGBNPWyqETF4OgO0Vc+Fe90WSKZ162xECjORJrXXl4P/X/g
 kg+tyKtAHkKCnVdpYHyqJvRcT8CtYWw2PYLeFkmCefnGxJezv3bg2B6u7PGb8o1VWNnj
 I0de2fDK7po5ks0auSH2Xssipa8jLGJV7JOOwbx6dzHOlsE4d7oeAorEWAoGd6vunIUr
 BJbOYd0g47v3q7NizCoeUqd7J4994zfsw6vvkF1Ieeg94WHmmazO65JoFDl9ep/9g52j
 A4xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795761392; x=1796366192;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=TuVER0CfSrmLTFsnU6SN3oHn7ZIxqRoRgTWvNLBSdCI=;
 b=KEtji80YQc2TsajSoZZHr9KxtjpgR8xXwKnRUSigjxlcUV379jWhuvAORebR9BCS1f
 tWsJneSQKNZtZcpxIYc5OHe6miczas21NAwC/iiBmd2bkITPdkJjxdcTo7YQCK+vkSN8
 Q0tHHlbpzTb+mwBj0rfsLjwBuvTJLjYbmy0BjtOt2jvz/nSkHXjitTK1UKKqoLGtlUh9
 NQkZfrKd3miNFDW0v+B3DN+uouT9Eajp2S91rE3KpJlIpFvg0vY0rdaS6H2GxBi5Hq0x
 fnetGt7QIMKPuD5yBmTNdUoVN6Qw6jR5BwK1bJVyTp8QZdDob+Dhdjh+CYXQWwfyiZSt
 Bxtw==
X-Gm-Message-State: APuU4Z9EBbKsjC7/2+9Bf0cn9TzW3yXLjyg5eXkdN3HZNryZYIRlDmKS
 AiftvjM95727XLRZvJiW/cwXvkSjJ/pjilO8QTQEvRgZSyk4BJAMsfp/
X-Gm-Gg: AZFdTZdJO83oDEXQzWFcmT7K57d3Y8dPYOxvG6fcJOboRpu6KM3yXgFsbSb6inNMKT1
 b+COmbfM/txFfvUnVEE0atyd3ZUIXyDV9vIdo9vb4BF3sVDkfNnlsSZ+Ts5MNQ2YkiZmMIte5bQ
 R+YtlDJE1UaiZgiI0rIZ832XQsZ6G/rgb/XxwpZqkqkb/6tG1o0AvuIqREIlBcn8ro7/zGgXu2N
 ufJRb+Fglv0v9yJGV5+P5ycLiLEAuBBxypTavq1sskcQ5PSHi1aV7tdXdMUzvWa6Qf2uVePr2HJ
 Kjfuwvn3OW3gIOW5Z0gFl+vdBwQEFGdYRs+61M1kNOYfCablGvkh+NbRx21bbRckRR3QIZELF3P
 fgIh4LB5sJKngAb+fiZTtVzDJXhIFpJWY2uBDGFySSf8VpnqQIX2RwzDmTREEXoxtLRIFFb4d1+
 nx4xnN9HWt0Kp1dnX5JByM1fBB2BPjtAL50TNo77X+E9wm5GaB1j1hLXgq/bG0r1aenK6eK2ss6
 X6UKIGeysI89CoyelL9Ol86ZAvf5f0/8w81L86bsbGgZGI5AXX9bm3s9m9qYBf/TemTByEcZHwg
 CJJBqs9BlGEl+5FgOkFLqoW8wqno+VQEI/seHVfSRrH+ATD0B8GhwOz0dPSxWqU8vA7PbdsGtWb
 tZjX4tcHliNOYmobgZ7JnFQvQ4MsAIE5voP+c4hCIlddM
X-Received: by 2002:a05:7300:1c17:b0:386:a105:fa66 with SMTP id
 5a478bee46e88-386a105fd17mr18016391eec.7.1795761392073; 
 Thu, 26 Nov 2026 22:36:32 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com
 (55.11.81.34.bc.googleusercontent.com. [34.81.11.55])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-385672c6f31sm67452444eec.15.2026.11.26.22.36.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 22:36:31 -0800 (PST)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: trini@konsulko.com,
	ilias.apalodimas@linaro.org
Cc: u-boot@lists.u-boot-project.org, sjg@chromium.org, marscheng@google.com,
 eleanor15x@gmail.com, jserv@ccns.ncku.edu.tw, visitorckw@gmail.com
Subject: [PATCH v2 1/8] dt-bindings: arm: google: Add dt bindings for
 frankel/blazer/mustang
Date: Fri, 27 Nov 2026 06:36:13 +0000
Message-ID: <20261127063620.399391-2-visitorckw@gmail.com>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
In-Reply-To: <20261127063620.399391-1-visitorckw@gmail.com>
References: <20261127063620.399391-1-visitorckw@gmail.com>
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Peter Griffin <peter.griffin@linaro.org>

Add binding documentation for Tensor G5 SoC (Laguna) which is referred
to in code as "lga" and three of the boards that use the Laguna SoC
Frankel (Pixel 10), Blazer (Pixel 10 Pro) and Mustang (Pixel 10 Pro XL).

Additionally update to use a more efficient and scalable way to express
the various names a SoC is known by.

Co-developed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Link: https://patch.msgid.link/20260918-contrib-pg-pixel10-initial-dts-v4-1-745eaca28b1a@linaro.org
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

[ upstream commit: ecf6405fa6c503c34eb4e7e905957d70d4018e93 ]

(cherry picked from commit 083c7465276a6f49b4f77896f0c82ee9cc9639e3)
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 dts/upstream/Bindings/arm/google.yaml | 48 ++++++++++++++++-----------
 1 file changed, 29 insertions(+), 19 deletions(-)

diff --git a/dts/upstream/Bindings/arm/google.yaml b/dts/upstream/Bindings/arm/google.yaml
index 99961e5282e..b5977e20f39 100644
--- a/dts/upstream/Bindings/arm/google.yaml
+++ b/dts/upstream/Bindings/arm/google.yaml
@@ -13,27 +13,16 @@ description: |
   ARM platforms using SoCs designed by Google branded "Tensor" used in Pixel
   devices.
 
-  Currently upstream this is devices using "gs101" SoC which is found in Pixel
-  6, Pixel 6 Pro and Pixel 6a.
-
-  Google have a few different names for the SoC:
-  - Marketing name ("Tensor")
-  - Codename ("Whitechapel")
-  - SoC ID ("gs101")
-  - Die ID ("S5P9845")
-
-  Likewise there are a couple of names for the actual device
-  - Marketing name ("Pixel 6")
-  - Codename ("Oriole")
-
-  Devicetrees should use the lowercased SoC ID and lowercased board codename,
-  e.g. gs101 and gs101-oriole.
+  Currently upstream this is devices using gs101 SoC which is found in Pixel
+  6, Pixel 6 Pro and Pixel 6a and Laguna SoC canonically referred to as lga
+  found in Pixel 10, Pixel 10 Pro and Pixel 10 Pro XL.
 
 properties:
   $nodename:
     const: '/'
   compatible:
     oneOf:
+      # Google Tensor G1 AKA gs101 AKA whitechapel AKA Die ID S5P9845 boards
       - description: Google Pixel 6 or 6 Pro (Oriole or Raven)
         items:
           - enum:
@@ -41,14 +30,35 @@ properties:
               - google,gs101-raven
           - const: google,gs101
 
-  # Bootloader requires empty ect node to be present
+      # Google Tensor G5 AKA lga (laguna) SoC and boards
+      - description:
+          Google Pixel 10, 10 Pro, 10 Pro XL (Frankel, Blazer,
+          Mustang).
+        items:
+          - enum:
+              - google,lga-blazer
+              - google,lga-frankel
+              - google,lga-mustang
+          - const: google,lga
+
   ect:
     type: object
     additionalProperties: false
 
-required:
-  - ect
-
 additionalProperties: true
 
+allOf:
+  # Bootloader requires empty ect node to be present
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: google,gs101
+    then:
+      required:
+        - ect
+    else:
+      properties:
+        ect: false
+
 ...
-- 
2.56.1.839.g22a8290db9-goog

