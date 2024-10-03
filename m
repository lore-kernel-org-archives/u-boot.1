Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4F5DCFA745
	for <u-boot@archiver.kernel.org>; Fri,  4 Oct 2024 05:02:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 742B588F95;
	Fri,  4 Oct 2024 06:57:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WoZp1V+C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBCDD88D7F; Fri,  4 Oct 2024 00:05:40 +0200 (CEST)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD46488D94
 for <u-boot@lists.denx.de>; Fri,  4 Oct 2024 00:05:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-4581e7f31eeso11112221cf.0
 for <u-boot@lists.denx.de>; Thu, 03 Oct 2024 15:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727993137; x=1728597937; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UP2fvAgPN+fmqR4PGJist9b0sruintAhJQAjyc30bWE=;
 b=WoZp1V+CSosjSMbu8q+AbiO+CnAcwkSAEqE0qLvcnLRVNrU7xfryD8AdgxPfB82/AR
 +EeqCcFJVYyFfKUsDP49MJZeTnPq9VzspfL9hg0QfhrBed0D1rZ7ev0VuayrJUGJm+hI
 93vgY08/TkcUrBEZhJIYG/xeZB5v5p9oyGKWcIVnd8TPQMAscLKOua3zExxUQmTqRdkj
 +pliIdQaXFAktxmskiur6O9DvXSmfzR93TuU4Rlg3aXZZtUYhMOAS0VcGDPd3b+b4s/2
 JclzDs1LkeNWGa8FWlZqSxB5h+a8PZTfjzhx+0EoI58RDYT62uqilon/D/6fhJwVynDz
 P88A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727993137; x=1728597937;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UP2fvAgPN+fmqR4PGJist9b0sruintAhJQAjyc30bWE=;
 b=IHQWCanzkw4TUBgQUjiO62KJ64s3gKWWs2Ht31HPz8YZC+IkmI6YdCR9esalXx/rqU
 VwbGc6tdKJwOH1V1KEcuZFp5RFV3gIwL/KCN1n97BRqYfjugEd67nwjSoAA37jr+1PF7
 KrM8MyoTmPap7YGYr9TBNS+XqJYYhrfeL5FlurJanc9+mO712IOHJHCvXSvZGsWfQ7Fr
 e36dGltgDm5tDRa3Mb9E9LGVsVvmjaobexv4LpymZIo6+9Q7HBBVy30MhctDYalf+wN8
 yz3xROwRKPrZT0yOAmjEJZ02MNcZzJodXPx7wHc56Ku2UfZ9svRAPAAxZkzW8h7uk3MR
 Fgmg==
X-Gm-Message-State: AOJu0YxWg6+9b8NrgGeLyhYLtCNc/R6A91lThTd10vWHRiXlD8Kg84fh
 1cOucPw+AxTvOSo7N8bjyXD5WNDPuwlam82tf63D5VIK1ho/O+Uml9US1k+ScDByIsAtru7Wxvz
 o
X-Google-Smtp-Source: AGHT+IFz5iQJlRsyHJXggGj4JDBCkZOzgRAQkj0i6YXbJUYBFHLa+WqiqrY74WZVmxUgd3abldOoIA==
X-Received: by 2002:ac8:5792:0:b0:45b:1d3:d9a8 with SMTP id
 d75a77b69052e-45d9ba85fdcmr10226361cf.27.1727993137251; 
 Thu, 03 Oct 2024 15:05:37 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45d92ddf5c4sm9001541cf.18.2024.10.03.15.05.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2024 15:05:36 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: manish.pandey2@arm.com, Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>,
 Mario Six <mario.six@gdsys.cc>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sean Anderson <seanga2@gmail.com>, Sumit Garg <sumit.garg@linaro.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Andrew Davis <afd@ti.com>,
 Bryan Brattlof <bb@ti.com>, "Leon M. Busch-George" <leon@georgemail.eu>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Marek Vasut <marex@denx.de>, Paul Barker <paul.barker.ct@bp.renesas.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kongyang Liu <seashell11234455@gmail.com>,
 Greg Malysa <greg.malysa@timesys.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Eddie James <eajames@linux.ibm.com>
Subject: [PATCH v8 26/27] test: Remove ASN1 library test
Date: Thu,  3 Oct 2024 14:50:39 -0700
Message-Id: <20241003215112.3103601-27-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241003215112.3103601-1-raymond.mao@linaro.org>
References: <20241003215112.3103601-1-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 04 Oct 2024 06:57:18 +0200
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
Changes in v5
- None.
Changes in v6
- None.
Changes in v7
- None.
Changes in v8
- None

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

