Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57371C30658
	for <u-boot@archiver.kernel.org>; Tue,  2 Jul 2024 18:34:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBE4A887FB;
	Tue,  2 Jul 2024 20:34:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="w6lw3L3l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54026887FC; Tue,  2 Jul 2024 20:34:54 +0200 (CEST)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com
 [IPv6:2607:f8b0:4864:20::82a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46D8E87D74
 for <u-boot@lists.denx.de>; Tue,  2 Jul 2024 20:34:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-4450187d3d4so34572651cf.2
 for <u-boot@lists.denx.de>; Tue, 02 Jul 2024 11:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719945291; x=1720550091; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bClAxjOX1z9/6SjRkI1NBq6SuVwLan6aXwxvc3seIZQ=;
 b=w6lw3L3lW2qnduLB6GglUZ2/sKx1hlf6f3j6sJlAby4Xs6EETdoivr9Mad/eEQGCvW
 3t5iTsAS31x/DzUaQdSfSH1Y3lnLonUV5v+FgkdJsdvf2MgeiTiqex/apxGsaagLhAp1
 ew9+gborSPjd6SPS2tAaJDNJd5b1qGQAFbXRwtcnkSJ3Im++ZrW64uRaG0dld2GukuVT
 PQuL2G/S+53fF4i0U3tXkQT36Ittc137DQ5nA3TunQo9luK8PMyWrHqbTwcE6tFVy6rX
 8mXg2LmnDt2tlcZ6JEOuTRYPA1lx6y2qILfCViuiVcRsDK8OoPLdZ/7jVjrRGyHcw9Dq
 abxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719945291; x=1720550091;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bClAxjOX1z9/6SjRkI1NBq6SuVwLan6aXwxvc3seIZQ=;
 b=OP3dWQ1TwgYBCMMW/DK9mQE5UxDr+MiPs7Gm+eOjFcxZABox3P50pouQP2d1PRiYoO
 ZOMSffhbaJZle1Rr0t31hoN5kbF2ccqsP97RiQkeuN7QyC4cE+FW5R8pLc+senIU55oX
 E7VuTqn+PVRnefOh+dTRWlcuvNPbFAxMy1XPx2NGCXCSSmTGj2Vf4IBIGNyqagGOe8RH
 wkV5SMWyG72aw7C4g37nmWcHfCc13mrqTNWHK6ac35JJfOyCyf0vx269OCj4/Vuah0SZ
 DOIqzmjW36MuYxkKLhxUAzOw/AmG8A3nGYfUjV3YQfdUZY8WPH7T2k64YKJmR9+1hBDz
 7l/Q==
X-Gm-Message-State: AOJu0YwNNpw+4gUHAeg6crMz2Fj88LATJeI5LNczDvJNntW79FATVoq/
 A6NRVx+g/Z0HGsCSm4mtOvjT2k0o6XFsm0L5C294LOdWB1gDBgoVvSOK8PM0bhSpvD6iguZccgw
 m
X-Google-Smtp-Source: AGHT+IF/5xZGayTe+/uSt3nDF3V4E/kqshNxB8st1eFF6Oor2+Lif8KtQ34FRTcFAV/Df51CKEdTMA==
X-Received: by 2002:a05:622a:47:b0:446:45f9:1fe7 with SMTP id
 d75a77b69052e-44662dff7d5mr118077351cf.2.1719945290738; 
 Tue, 02 Jul 2024 11:34:50 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-446514b613dsm43316351cf.84.2024.07.02.11.34.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 11:34:50 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: manish.pandey2@arm.com, Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>,
 Mario Six <mario.six@gdsys.cc>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, Jesse Taube <mr.bossman075@gmail.com>,
 Bryan Brattlof <bb@ti.com>, "Leon M. Busch-George" <leon@georgemail.eu>,
 Sergei Antonov <saproj@gmail.com>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilya Lukin <4.shket@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Bin Meng <bmeng@tinylab.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Subject: [PATCH v4 28/29] test: Remove ASN1 library test
Date: Tue,  2 Jul 2024 11:23:04 -0700
Message-Id: <20240702182325.2904421-29-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240702182325.2904421-1-raymond.mao@linaro.org>
References: <20240702182325.2904421-1-raymond.mao@linaro.org>
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

With MBEDTLS_LIB_X509 enabled, we don't build the original ASN1 lib,
So remove it from test.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
Changes in v2
- Initial patch.
Changes in v3
- None.
Changes in v4
- None.

 test/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/Kconfig b/test/Kconfig
index e2ec0994a2e..558a9cd49b4 100644
--- a/test/Kconfig
+++ b/test/Kconfig
@@ -32,7 +32,7 @@ if UT_LIB
 
 config UT_LIB_ASN1
 	bool "Unit test for asn1 compiler and decoder function"
-	depends on SANDBOX
+	depends on SANDBOX && !MBEDTLS_LIB_X509
 	default y
 	imply ASYMMETRIC_KEY_TYPE
 	imply ASYMMETRIC_PUBLIC_KEY_SUBTYPE
-- 
2.25.1

