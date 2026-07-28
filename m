Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 672B2C531F9
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 11:36:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1AF55409FD;
	Tue, 28 Jul 2026 11:36:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vQJ5AvT1YLra; Tue, 28 Jul 2026 11:36:27 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 09632409F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785238587;
	bh=aJYf3PfZm58tpJJOi3BPxC2n8ZfBSQXoh+DEVvzwq5E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=H+gss/vKc1hjz86sGfWyO4cXHmVz86ScxYYA2aczVRuqp4an+2tcD6dgXFGgrPnY5
	 EcQMGNdgPvYlYBB1rJCJwdd2Xj10hAiLPR79AEu9K8PKta2HGRIHH/hGuV/q7k5Q37
	 qsX2o3NtsqrSna62a4NDbRafoLdGZdiWLp97UcoJBcU9ARzQMk5aIeRQpXwpBISNGV
	 hzzeRfIDJJizQ/lQkroqFWMblYSEbbWZo7nSRu9AQYooqhQwZuZXeLt1Gcl6p38eug
	 ZnxvKmPaWxfrZguiO/ISRC8vQR1y7TfbIW8xyQ+3QoWa4HXBOLv0SvJMxQ78pnJ6t1
	 obyUJUSjVKbZg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 09632409F3;
	Tue, 28 Jul 2026 11:36:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4162445B
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:36:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2705C60873
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:36:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2Rb1aYgBJHyw for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 11:36:24 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=sergio.prado@e-labworks.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 3138660866
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3138660866
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3138660866
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:36:23 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99DC18494B; Tue, 28 Jul 2026 13:36:21 +0200 (CEST)
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com
 [IPv6:2607:f8b0:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E3F382991
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 13:36:19 +0200 (CEST)
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-ca97d139d8dso2173386a12.2
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 04:36:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785238578; x=1785843378;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=aJYf3PfZm58tpJJOi3BPxC2n8ZfBSQXoh+DEVvzwq5E=;
 b=I56K7qVBxwDJ3qPchRruMxQa8cP6qsKGpNNSz8X6i2aCwgtrEBREVrDbxcxbK+VLnZ
 HAeoL49dztu/9+bFRa4y2onJcn+nTpyZKO/hYOgkSjCYiC+/EQfnc+l1Ch9lB49wy5ev
 dJM0oA3Jeh0bgFzslzpwPpryIrB//UVkdTdJwCOjoNT9n/lWNUWzKgEc2hARXB3MdCRN
 KDXa3iFnhYPpVEgU3M1KTiSOve418evG/q43tyNMg2FXVeEIKKzQjerY5UtBBxtjbn0m
 xrpL1Z8ROuzeS6NzI91+0QtpnCGoV2QLzNtx8trl1nbDuCYkeUwqbBuqcpSN9Q5sA/VN
 EAjA==
X-Gm-Message-State: AOJu0YyDIV+KTiY/LEDMJU6KNGT6xz++fhkz/+/7BtG2DtIBogH61dFq
 LUt2JIEU6IBNkQDJVJntbjcFJtE94o698YrNK7vX/4EcTF/hVgraAqMdXIftq62qCrclmHgrdFX
 jKDQH
X-Gm-Gg: AR+sD12+Bc5lKeXDDBd8MbWh1GEd8nivmo67GzZtI30UcU78yT/L3JugaTEsR5fIm12
 m38xGgczpic4TPOrBJTgEf/Dw70ECaRiZdraXVDqm7XxAZlDYvxdTgkt1UMDBD655XO4XQudwBd
 5a3kORQhGhG8KikLWX6kE97J89GkcLR5pXs3Chj+oSfWYjqGanLEtbb6ZDP4jYd78uiy5J5ip9K
 6Gp0jVHqCc++7iToL7XoRYU036AH/80ARYP2c9DFtWU0m5XlfyUjOvYoR+/p0HMH/EmQDQbIAzD
 dc9zKgKsGFfkiI0Dcw1WZqV1C9H7sbnUAzYvFPpO+05ZyFK93C+de+ChPfSnooBmEL4Ldio7Az1
 iyOb8XunUTRFuosG08pFBiDvT2L/3m01nzBB5rPk1NDZm3uyF5+TukkneHtC9n61j8meJGCY9D8
 oDfdptqfm7+w==
X-Received: by 2002:a05:6a21:3204:b0:3c6:5673:2bd1 with SMTP id
 adf61e73a8af0-3c8ba5da101mr2454179637.42.1785238577674; 
 Tue, 28 Jul 2026 04:36:17 -0700 (PDT)
Received: from desktop.. ([2804:7f0:6400:919d:7be6:2bc2:d3d3:8617])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc419c52sm42603976eec.10.2026.07.28.04.36.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 04:36:17 -0700 (PDT)
From: Sergio Prado <sergio.prado@e-labworks.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, alpernebiyasak@gmail.com,
 marek.vasut+renesas@mailbox.org, ilias.apalodimas@linaro.org,
 pbrobinson@gmail.com, sughosh.ganu@arm.com, sergio.prado@e-labworks.com,
 wolfgang.wallner@at.abb.com, xypron.glpk@gmx.de, quentin.schulz@cherry.de,
 jj251510319013@gmail.com, Wojciech.Dubowik@mt.com
Subject: [PATCH v6 5/5] binman: Add BINMAN_X509_KEYFILE to override the
 signing key
Date: Tue, 28 Jul 2026 08:35:35 -0300
Message-Id: <20260728113535.128601-6-sergio.prado@e-labworks.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260728113535.128601-1-sergio.prado@e-labworks.com>
References: <20260728113535.128601-1-sergio.prado@e-labworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=e-labworks-com.20251104.gappssmtp.com; s=20251104; t=1785238578; x=1785843378;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aJYf3PfZm58tpJJOi3BPxC2n8ZfBSQXoh+DEVvzwq5E=;
 b=wZtdXSnZo8k98P0JEmUh7Ihds1uBIPzxlBeNLLvfY56P4j53dm6fNRPROsOnQnXHra
 Rye+0aPagZFGTy6b/+udeszMcl6YgdDLQg3W/PSpJfvGBFM3+WeP3hkOOdXfAbZE4GoX
 MmGKPChglAF6IsNN9U+4cjEYWA2eab5QOuuglepgJMRxfTU5F8q4Tm4OfMakgrdpEIRM
 rfBNQZOKFxz+i7bjo7nwxTM/SSdr//KsizoIR+r87EprrrEPE/qbFPA2tDN+NFJB1GF0
 KNhbmBgrqjDFG6yXs1xdMVZ1kIjgv38HM/T3MJ1FUP6A+r4Fod5Op4drKcUminL7jj+B
 cv6w==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=fail (p=none dis=none)
 header.from=e-labworks.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org; spf=none
 smtp.mailfrom=e-labworks.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=e-labworks-com.20251104.gappssmtp.com
 header.i=@e-labworks-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=wZtdXSnZ
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none)
 header.from=e-labworks.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=none
 smtp.mailfrom=sergio.prado@e-labworks.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=e-labworks-com.20251104.gappssmtp.com
 header.i=@e-labworks-com.20251104.gappssmtp.com header.b="wZtdXSnZ"; 
 dkim-atps=neutral
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

The key used to sign an x509 certificate entry comes from the image
description, either as a 'keyfile' property or as a 'keyfile' entry
argument. Neither is convenient for a build which must not carry the key,
such as one signing with an HSM.

Add a BINMAN_X509_KEYFILE make variable which, when set, passes
'-a keyfile=<value>' to binman and so overrides the image description for
every x509 certificate entry in the build::

    URI="pkcs11:token=mytoken;object=mykey;type=private"
    make BINMAN_X509_KEYFILE="$URI" OPENSSL_CONF=/path/to/openssl.cnf

The variable is a plain keyfile override, so it takes a path to a PEM key
file just as happily as a PKCS#11 URI; signing with an HSM is simply the
case which needs it most.

Signed-off-by: Sergio Prado <sergio.prado@e-labworks.com>
---
 Makefile                |  1 +
 tools/binman/binman.rst | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/Makefile b/Makefile
index 7f5d83658d75..c418fda1981f 100644
--- a/Makefile
+++ b/Makefile
@@ -1704,6 +1704,7 @@ cmd_binman = $(srctree)/tools/binman/binman $(if $(BINMAN_DEBUG),-D) \
 		-a vpl-dtb=$(CONFIG_VPL_OF_REAL) \
 		-a pre-load-key-path=${PRE_LOAD_KEY_PATH} \
 		-a of-spl-remove-props=$(CONFIG_OF_SPL_REMOVE_PROPS) \
+		$(if $(BINMAN_X509_KEYFILE),-a keyfile="$(BINMAN_X509_KEYFILE)") \
 		$(BINMAN_$(@F))
 
 OBJCOPYFLAGS_u-boot.ldr.hex := -I binary -O ihex
diff --git a/tools/binman/binman.rst b/tools/binman/binman.rst
index 106c34efb76c..ff61baf6d5fe 100644
--- a/tools/binman/binman.rst
+++ b/tools/binman/binman.rst
@@ -2232,6 +2232,18 @@ BINMAN_VERBOSE
     Sets the logging verbosity of binman by adding a `-v` argument. See
     :ref:`BinmanLogging`.
 
+BINMAN_X509_KEYFILE
+    Sets the key used to sign x509 certificate entries by adding an
+    `-a keyfile=<value>` argument, overriding whatever the image description
+    says. The value is either the filename of a PEM key file on disk or a
+    PKCS#11 URI naming a key held in an HSM, so this is the way to keep the
+    signing key out of the source tree::
+
+        URI="pkcs11:token=mytoken;object=mykey;type=private"
+        make BINMAN_X509_KEYFILE="$URI" OPENSSL_CONF=/path/to/openssl.cnf
+
+    See :ref:`SigningX509Hsm` for the URI forms which are accepted and the
+    OpenSSL configuration they need.
 
 Error messages
 --------------
-- 
2.34.1

