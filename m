Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DB86CA5FC4
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 12:26:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 24A8240D48;
	Fri,  2 Oct 2026 12:26:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gX9NQhfvm6ip; Fri,  2 Oct 2026 12:26:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 0BCDC40E13
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790944007;
	b=YkxqBpBvUOADWyocvkS06ocwZ+uB+r3Ed/x+kMUanB2HFODj2iAVnpcq3BeouFLF6YVi
	 kMlE1Ze3A6bj+BL5zz4rayGt3Z8udBOOqlyDI7aGOrF0h/tS/O65umAkfJG/c8jCeN+YN
	 B694sbaBvFIgL+5lJmzJFBQp12uKT+AtMdOkNK8f2eYRK/WWNYjDvNASu2MQNoR75oGcU
	 sKhFglUmDjY8E1eMgnG48u3+XlAH0lmh+uDZ8vHAtqoFqbMkWIXnx1ysb0sLBuJKWpWYY
	 M8Wj3fKvepfjb+hdhZyOv+w/WkUy7bivPgFknMgnWCjsR3osjm2DwRbnRk++rNuOQhg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790944007;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=6Lu4BLLZxqp5grBLWGQzUbnQzqdGX5riotyEltzCrZk=;
	b=YiFhG3iKdpQI/uCC9AokI7cnFGYSDNKGtzNKKAuKk11/6eRs93ZuL6AyyEE5Uis8vyzv
	 tUPm8OAlXPgLG8KO2ITQa5OA9Ty3xz8rJ4MMPIeRLr5LplVBl/nCHOStvWl5D/BB53n3a
	 iHztz2tPaidFjjjcaEmxXAYPCxq9ixgz795dxxfvAyrxeXATLbY0JbjI2to/9cisctCLM
	 7w6frlusIBRFrhhDWhotccGQVv30g6Um14BBaOCrtAL9ESG9J0mZZx18fMXmnnAvv3tZp
	 S9IyAao8fhDe0U5ePANUei27+rVLZvH6wN3Y7y5KBGevs4YOPUiOuDRuUm1FSGrStYQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790944007;
	bh=6Lu4BLLZxqp5grBLWGQzUbnQzqdGX5riotyEltzCrZk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lafAXsuTMoZwAqxHuKHiR9C4WKJpsj04V+L5H0bcr1AhcqNiPkHAvqzguRV7bEhFF
	 v5sxWJfXc9EolcoKGc0B2NWfsOZ9Sl9O4gx+nHzrFiu9Rxjy+yF236xy+S3HN6mGJz
	 1NiFcc1q+BWR4izI9IHeztsrZlwKBc+FGXyD4uBhs6qg0ysC8juOQ0yWSyi6fWPdrB
	 gOazx8Sd2TNwUJ4fSfQBYZR3PI4stDRBKi+iZLJu8uuJguWxTpivOxn/5LzBssc/dm
	 h5FPCP0LRVth2BNMh9rMqsNvB4UbUditrP0MNMmdp9QuaWhcEbONDEzAGTKtUNnFUi
	 PJbYoojZI3qKw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0BCDC40E13;
	Fri,  2 Oct 2026 12:26:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id A490C32F
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 07:34:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8A5EE60823
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 07:34:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y3L907B_UzNr for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 07:34:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org AC0806071D
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.122
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790926482;
 b=nsh3Sb4pX3uJKLPUvw70xx3op6t2JHfIGZWre8tlgZO5mGARNJiS8nMDavNz9/gpvxsB
 8g5B7+CiMcgLVNynBSkdIu/EVxWFTVL5s1LsWJTEzTRlKT8QErCpDUVU6HAJE3/wG6KSR
 tB+GnXN8nLpOmFJE3anHTxHU17CL6Wvk2+4RHEQ5ftgODxnUjTZPxHfhxy1tXkHR08i8Q
 ykuRXmNYmfrYh3p0khBGnyiBRx+HQm+9BiNdZqIW3JyT66Q9hJhRt76Al21OqSW1lccn/
 xit2ClqavK/YuV3S/7H9NYv/4ZYgHeID0ZXaX240gsEfZHJuMQWtHKNwCxSB3p09Xbg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790926482;
 h=Received-SPF:Received:DKIM-Signature:Received:
 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=6Lu4BLLZxqp5grBLWGQzUbnQzqdGX5riotyEltzCrZk=;
 b=X4D+A3MOaWIptH+S26hf5Zbzx7FDBPM3jkfjnRrVqY/ccTQSqbG10KbcOYnYwHTobmL9
 ePUmdtlVduobpRssU1BwqGzFvPY+o7yi4gd/Y48vBRVknVKAeS96E71J4jPfeHgCl6CAq
 JBj6kVasHAvITwm88bK0fjfaIHcsu+Od8buC9+5iFDiZL2fHexfLyNEnqDrzH2uvd429l
 Ixtw2rrv5mrNRKvAO2LDd/9WvljjzWXLKnQcTTzvEYxURDxC/xy+nN9Js+eqSiXGc+lQU
 YGywETKKiIhcPlduyrzQMjBE6S5RJNpOkCdmCLYjudR5aR3UHsRE/Ze+QTupLJdiV2g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=canonical.com; 
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b=DeCYM6Ou; 
 arc=none smtp.remote-ip=185.125.188.122
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=DeCYM6Ou
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AC0806071D
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 07:34:42 +0000 (UTC)
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A0C4044DF7
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 07:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1790926480;
 bh=6Lu4BLLZxqp5grBLWGQzUbnQzqdGX5riotyEltzCrZk=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=DeCYM6OuzbPG3CSJTU2EsWN8rtFY7XQ+edda433vxbdRpjypj1cjI7RKE+peW1348
 wOeknS3UzOMvzdsIY3YFUB6//Zci2NAQRTo+RUZGq3Kmt6fhQr70XZLdlFQaRHkLhz
 0BXBJF0Xb/oLO9E8s76ZUf6ltkzo6FG/WXnArZpPDPQu84WNr0lHizVjwVl5uGjGow
 6nlqSOMfC2rCfDjkPVqh/BVcNJ4/MbSwHhZGkdHOEGJHJy9dr+BEUaIFoFVSSu4j8j
 bJhDa17jLT7VtwstBUcKpvvdPamJ1QuDv4/5v6idY7gJ1KwMGSQY0C6S+WlLEum4vI
 kKrMCT88iO+MDwxracpQQiqoR6g0cYg4FcO/VgqF/vE2cnUAKytfkftzD5n0h4pbft
 rMkgp/q+EWCy+/HTfG2wjl16K0tQKWcN1B64FFLFjmpyhKMQB/OeBXf1s39t3Rorci
 C4AOBqwTULphde6+KCimlIOGD+DQ26N0hmYTZN3MNTnn5jXmhpQzNFDTMXk6w+qCz6
 OkPo3N3lnRR+CEOmcxs+xfAwpGrkYPKB+oihya4voL9lx5feYTUyzLQn00i65yBz8H
 x0tX64mjsLTzm7b//Bg2HgrtJfZSfWiWGkHJWDpt91a6cf998utwjOSqRnVhvKL04t
 WD+kPdBjIVsUuaBHGRy6wcrQ=
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3a47617a0b3so5599398a91.2
 for <u-boot@lists.u-boot-project.org>; Fri, 02 Oct 2026 00:34:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790926479; x=1791531279;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6Lu4BLLZxqp5grBLWGQzUbnQzqdGX5riotyEltzCrZk=;
 b=kHlpxcMkqLqqqa5wcd5JU0ldWwzKz7I0Zn71dtRaW5ebhxFllt47YiLZwUJJ756cX8
 hFCxZBrcbBeQpGppg16OpgEozb1KCr8PerQgB6bV+iGd0N8BfswQDVAjJnYNhwliZ3s+
 57hJaDBCWqivO5XcThxYMpGDcS1Q6S5YveNOHdse6fx4ZNhyn70/mtcf+wPCKYyrWfdy
 b4GSsSxxxb2Yp90FtT59gRFo6WxdtFHEwqXrc+g8LbSZLVoZ0uG6i8xqvupyC3iM5nNv
 ab1DZqV9VehH4i6I1fEOuICkFIczlhKtjRFXOLtUQMU+SfyTadYesbiib4mJt3AB74ec
 5o+w==
X-Gm-Message-State: AFq9FYIpJAmI8VPm8YB14KFrlHtPNoYf4rpa83geNt2RTaz5LSMdUj1W
 8nD2wij/FAru09KFtJDow2Osp6txjwCIVaZBqM2ZUIfcl63RwKldkbQX9YFlrDChGpKoufxVFSe
 FBzHtWQqiLDEyq4mYdGUCnVDmy/mk9TnlsUd2HcYxAxbUCtV8tydYEi8VBv/HoxavsqRxqxJ2sO
 PTFtLqFiB3xAHx+ntMZA==
X-Gm-Gg: AYBFou32JFHUDrJLKKW0dMfM8v+B7DwOZzxKdbizJLPNEud6aio0snt9LrJXrXGrjxg
 hiyHSF3/VoAeZdQwsk0DT1vmqAjEswKzqLK6SDNFxTDl13z4tA1/ADljGjUSvjsWrzVaDkKynou
 r0jVMVavUsO+DkDURW0EG2VC60AruKljL25RNsf+Es6RwC6PyujlcHHwtQUEN2Nfa5q/oOeGOsD
 gBBum/Jb5c0+7qb1KY4sXiSkJce01SYHHQIMyXohIO5efrZb6Y4DCWP9DO7viVVrND9aNS/hToL
 j3IxB1pYu6KgcVfP5YKuVV9jkrqGob4aHDXQcmGypwSIh1upo2IBn22DhhJE5mmBSXBVPrR09bH
 u+ufzzZYK9Z42dZpzTGn0fMGIRyVFWzeh42eWXxUSVlWrP9Vlujw=
X-Received: by 2002:a17:90b:4b0d:b0:3a2:b0a1:456b with SMTP id
 98e67ed59e1d1-3a6cecb1b3bmr1231680a91.47.1790926478955; 
 Fri, 02 Oct 2026 00:34:38 -0700 (PDT)
X-Received: by 2002:a17:90b:4b0d:b0:3a2:b0a1:456b with SMTP id
 98e67ed59e1d1-3a6cecb1b3bmr1231659a91.47.1790926478516; 
 Fri, 02 Oct 2026 00:34:38 -0700 (PDT)
Received: from noble-uboot.lxd (124-218-37-86.cm.dynamic.apol.com.tw.
 [124.218.37.86]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a6cd44c2c9sm3172004a91.6.2026.10.02.00.34.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 00:34:38 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, Aristo Chen <aristo.chen@canonical.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Subject: [PATCH v1 5/6] dt-bindings: soc: imx8_pd: drop the duplicate
 PD_LVDS0_PWM definition
Date: Fri,  2 Oct 2026 07:31:55 +0000
Message-ID: <20261002073357.382228-6-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261002073357.382228-1-aristo.chen@canonical.com>
References: <20261002073357.382228-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 02 Oct 2026 12:26:15 +0000
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

PD_LVDS0_PWM is defined twice in a row with the same value. The LVDS1
block lists the same resources with a single PD_LVDS1_PWM, so this is a
plain duplicate, not a typo for a missing LVDS0 resource.

Drop the second copy. No functional change.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 include/dt-bindings/soc/imx8_pd.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/dt-bindings/soc/imx8_pd.h b/include/dt-bindings/soc/imx8_pd.h
index 682b608eef8..c54056fd9bc 100644
--- a/include/dt-bindings/soc/imx8_pd.h
+++ b/include/dt-bindings/soc/imx8_pd.h
@@ -18,7 +18,6 @@
 #define PD_LVDS0_I2C0               lvds0_i2c0
 #define PD_LVDS0_I2C1               lvds0_i2c1
 #define PD_LVDS0_PWM                lvds0_pwm
-#define PD_LVDS0_PWM                lvds0_pwm
 #define PD_LVDS0_GPIO               lvds0_gpio
 #define PD_DC_1                     dc1_power_domain
 #define PD_DC_1_PLL_0               dc1_pll0
-- 
2.43.0

