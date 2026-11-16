Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5299606A32C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 10:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ObpveCZT;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=OSl15Iml
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9B871607DC;
	Mon, 16 Nov 2026 10:59:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b8sMp5MQOzes; Mon, 16 Nov 2026 10:59:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CE424607B9
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794826783;
	b=lTF3n7Qf53MzRjjeNJ0V3MZuTApd3mYOy79azFD7j8gaq24Wl6J7Hl2lngwsPNIlbtH1
	 oBv4gwsRqyMkgbOFQzksT5mOWCtAmppWM+2ivbHGDz7SuKeKOk905pytlXNQDl0O+rZOn
	 yK1K+yWPLv2OQ4prrw92OB1Y3o1Y4FcuahCO8y3goUI7y5N3K2DRPsEtBCG8Jj9ijp8UA
	 020PUB1RIkXh20LDr3Im+eLEZl3tk4n2alsyMe/7+LVc+wVs8ElbrrbfGAvgD5pPD7fM9
	 r3qCrGDbnYfgpfSos0qVBmKWja3bzywYs8H8nPfKnqKN11HzG5mguYvYa7gERoqBlkA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794826783;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=A9f14Du1Xru0UudhfNsrkHUKhKJvwd1p9eClG47J8Gk=;
	b=nJsX/TZFYkpCDhZPHO2tn/+X9tDbiFV7be9ryqXbhLh6Pf5LVyrz1z1w3A5a9VoTM+L5
	 0wET307vfqQzlAIEcio8kvn68l0mcDTrtRWIcOM4cmqlDC2LGeXoeH6MSd8GOwB0Uip6A
	 LJgzaOMcbCT1nFDb1YihGDvv1Mg/crL59VGSuarFFYEoFafxGG5tzgZ9YwEAxeaBeLuts
	 N0PHYJT83xHhxKrnnVneQWDuAk4YO3Q/KNJXLM5PDTYvki7d/tuHgOI4b/k5XyZ3kIWWn
	 082aXn3BAaWv99hY/DSW66yamAK6hFVl7VbgPvrVmR8XYyjW3WvLyqpJ/8tvexn4F8g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794826783;
	bh=A9f14Du1Xru0UudhfNsrkHUKhKJvwd1p9eClG47J8Gk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ObpveCZTfR/xqLhY5x5pN4iUERw5ZypW791imxrzzx76/zHwV0ypU0FXJzkZ2axVw
	 DS1jLyGdwmlBkYJUCrIcbt+O/FBtDAJmaGqL752XWo/FatBxbCIr+YR2d1Xa4i33Xu
	 Du+UIO4heBN5SgeCFl8Ms/p2tU6w5ECqJT9hi9Gys9TWrikgOqiOK0pphLH727gW5l
	 pEiIa4alvRNdgOQdjTkxe+59zmat9OamxCmLf2Lnj9ukFNqPrg/Lj4UomcOliexsjB
	 rCU4ckgiSKc3dtj1LZ+U+myPXwVvM8Sj9P+f/dc6FRUw8t68xGETtCgOiBPLC1dZjo
	 qFjrgLd3ebNGg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CE424607B9;
	Mon, 16 Nov 2026 10:59:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7A73728C
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:59:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6CA444057C
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:59:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bIAYyJ-5ui2A for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 10:59:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1155640572
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com;
 envelope-from=andrew.goodbody@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=OSl15Iml
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1155640572
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:59:31 +0000 (UTC)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4ac95761c85so20239505e9.2
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 02:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794826770; x=1795431570;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=A9f14Du1Xru0UudhfNsrkHUKhKJvwd1p9eClG47J8Gk=;
 b=OSl15ImlIyRLdcGJqX8d5qbXDOTmfEgDSR2mHODJwitAVtQEGnu4t5/Cu87bw8DDSj
 ilHZCnsGNrfv7VkuvsqKMqprzorQNCHWxosmP7MmNGF/1ArqNzcnIRLiucJpC8CmO/B8
 YazJpyrAvfv7ot97QRB4psUz567t3Lz/mHSdrYp+6VpGa/47hyHSc69aqX7HK7WFUrJC
 KK8QT0rjlCEtkP8yi+MqHUDpV6hCehG8rTRmKiYtnbWw0/KdMx952fQpuqj1narWp893
 RreTaZgnwdMc5/hVMgUSWbv73+K+ujmZdD5ySLGxp20DX9OeoK52z4mris5WnMSu4Iqh
 R0TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794826770; x=1795431570;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=A9f14Du1Xru0UudhfNsrkHUKhKJvwd1p9eClG47J8Gk=;
 b=Sq8ptwtU1CVzGUU7D/ujrniUc+JsL2bpQEpAzDV6VYIiRak0s0qiI+m3E1MVMqTXD+
 g5a0Ddx9uPE+vlD0EhZls/6M3IfNKjW/zXvZOdcYWwVqFNUe3nFcCyjPdOuEMKx6ZYJx
 mEV7ZMxFxGigwI7F4p4wOMpobM5PpIQO5ALGU38s7Kmj6UF56vOXWzBIB8Dxtt1tKRlV
 QdQyrPbn6mOxHx+/Rh4soxUBMUJpTz9x0sxXVEufccS6JL6Vs+SnGkvzqp8uDdqn+tqJ
 Xti8LlVvWebaTNS++zI+xW65vhxYI1Avt/blOp7kVQ9iEbs08k/ffIF+4ejmfuDyrxQS
 e8vQ==
X-Gm-Message-State: APuU4Z9ayF7QDchjtXFkkP6NtkaZtrwsA5nid/UfoB7+0ai9+zfZT5f3
 qE4xF8a8aUiZlhFToUGOtKuHhkCYPMf2222H23UNMAjNfhr2sguRYqVcN9Nge7KFXoU=
X-Gm-Gg: AYBFou2IBNyXTqjhUXAoHFKX/09FEHd0ZZ06ZBLUdh62VB9zTZZwxqLZPqJmdsTNTP8
 2e7vlBCMZ3ICusw7zWpfe3OjhYarJ4yjX2OuicEhy57/OJ4G2RbQB+w9IE0eSvPQkwNreukEVT/
 7nR1JMmdyKsY1QI/69/i4oJgGG19RTOGtZtgAVo7XJ51HeehLZOV1HWpnUbqQbE5RZryj2rwhnw
 G87LCDwOpR9iORvw5ZdFWdmhtuDzXoKb/1oetnsJOMV+kfUHEgoGcwMl4h9cZcHfezC0gi9IWl+
 QgGv/xsir9EW+rv9F8cRcED/9WnoOBPfHDPDsJ/LtGwzkwSn8u+5tj/wyCWS2/g0hjfzDpmLBcJ
 2JGfYuX0StdBZREdI1+6Illtex9nUiID8VsAbfo6PmewohlR7Gw3SWo7fqiQnmmnjiU1TlqBSVZ
 benyVzoMq3udXzXM/EEoWjKtNeLcMEhKiDcMegp84EvjMosIjMvr2LGIio7KYnhLSL75ZS4s6jF
 JdR2sNz8b8i+LkIEFmSd6mxsCgbYCMObz41QW8xvK87ZhCcu0g97EA1RSdRMRR/GY74wJZvmlRM
 mqj4XT+vxoB0XWgtIMyt+N/f15dVXzaqy/jgLafPsQYiv0Wrr0i6CnV0lkCrCTvBJQTUSw==
X-Received: by 2002:a05:600c:8b35:b0:4bb:6b6b:fbaa with SMTP id
 5b1f17b1804b1-4bb6b6bfc3dmr86431735e9.16.1794826769846; 
 Mon, 16 Nov 2026 02:59:29 -0800 (PST)
Received: from artemis3.elfringham ([2a0a:ef40:ee3:3401:d23b:e87d:8bff:70bb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb64ec7b58sm219594065e9.5.2026.11.16.02.59.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 02:59:29 -0800 (PST)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Mon, 16 Nov 2026 10:59:26 +0000
Subject: [PATCH v3 06/15] binman: Use mock environment to ignore DTC variable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-qcheck_fix-v3-6-b6cf7e96944b@linaro.org>
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

If the environment contains the DTC variable and it is set to a relative
path this can cause the tests testFitFdtListDir and
testFitFdtListDirDefault to fail as they change the current working
directory so that the value of DTC no longer points to a valid dtc
binary and so the tests fail. Instead create a mock environment that has
the DTC variable removed from it just for the duration of the test.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 tools/binman/ftest.py | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 567ffa96b2b..50fb25325a2 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -7984,18 +7984,26 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
     def testFitFdtListDir(self):
         """Test an image with an FIT with FDT images using fit,fdt-list-dir"""
         old_dir = os.getcwd()
+        local_env = os.environ.copy()
+        if 'DTC' in local_env:
+            local_env.pop('DTC')
         try:
-            os.chdir(self._indir)
-            self.CheckFitFdt('fit/fdt_dir.dts', False)
+            with unittest.mock.patch.dict('os.environ', local_env, clear=True):
+                os.chdir(self._indir)
+                self.CheckFitFdt('fit/fdt_dir.dts', False)
         finally:
             os.chdir(old_dir)
 
     def testFitFdtListDirDefault(self):
         """Test an FIT fit,fdt-list-dir where the default DT in is a subdir"""
         old_dir = os.getcwd()
+        local_env = os.environ.copy()
+        if 'DTC' in local_env:
+            local_env.pop('DTC')
         try:
-            os.chdir(self._indir)
-            self.CheckFitFdt('fit/fdt_dir.dts', False,
+            with unittest.mock.patch.dict('os.environ', local_env, clear=True):
+                os.chdir(self._indir)
+                self.CheckFitFdt('fit/fdt_dir.dts', False,
                              default_dt='rockchip/test-fdt2')
         finally:
             os.chdir(old_dir)

-- 
2.47.3

