Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A789C48BC1
	for <u-boot@archiver.kernel.org>; Wed, 14 Feb 2024 18:35:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1D3C87D57;
	Wed, 14 Feb 2024 19:35:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=foundries.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=foundries.io header.i=@foundries.io header.b="SzKZo+Lo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2F9A87D6C; Wed, 14 Feb 2024 19:35:05 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 362A987D38
 for <u-boot@lists.denx.de>; Wed, 14 Feb 2024 19:35:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=foundries.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@foundries.io
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a26f73732c5so840975366b.3
 for <u-boot@lists.denx.de>; Wed, 14 Feb 2024 10:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=foundries.io; s=google; t=1707935698; x=1708540498; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FvFJAdZAFUJyzS1WaO3bLDMHxE7A84ohIZOBxh+qx1M=;
 b=SzKZo+LoQS8Vq+tbjxhsGIj7P7KHf9d4v5KwVwUv9IigEl4mOBCNiC5BW9A9i12K+L
 Yo5H5ooFf/VSgTGnO1CeclZ+MPirWY//BnsG03UXZuw/Q03eWCbN7ntQb/9p7hQTQP6H
 0bPcJAzmfXz3u+4VgCcxnlVww8hf25zi7JALsdHQBfNzb0SHRf/bbg0c6+T6eJ2WidOJ
 /k3CC9w7st4lAapitwKtP/E5qQnhkNr6oFXHwUelKEqx3DIW9RVbzctKVee9SCOeFgLq
 h/Fht8yOM+35Kw3UQLeA7Ea4eTfjctpgf57O/DJDZF3+23ZdGQBwR4zU05XAxO0IUc5c
 4CVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707935698; x=1708540498;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FvFJAdZAFUJyzS1WaO3bLDMHxE7A84ohIZOBxh+qx1M=;
 b=hWVorYKXSbjbsw4SXD/rgg285QMJnYFX69CTi7qJofi8WO84LjIP7346MmxSUyttki
 ySkmZy1apr04ltHoV35LOB72AmTewDNOVxDJce3+swZgdwjkq8PfVMG2HG36Xl98LnVZ
 bseS89mMcPKW1ShRmvRuQlIFlxXTRU6MPhEg+Nu2x8Ace4gZsyUJvZeGTaTcM1UW2is7
 aj8e0gGzrGAfwKhBktDRAgv87Rd/55W8BGlilqrg7edlfZlwytaMG3L8PFk8CdwAl7pZ
 89Z/MfVSnJRNPsJCmRgs/he9cU7tdrBLKFrwiB96G2F6+TzSxw2LKfRYXbDh7EPdz2x3
 uuGw==
X-Gm-Message-State: AOJu0YwBTiOsxwILwzfDaDDx0dT56FLgBYqDoY3gb6KHWpmyN7ArrhAI
 qj3NXx6VJdo7hyhrk8FisjBy8eYBtGXnhEaArmkRJ+1S7YLjkneeO87d9UVoWdDV1okzRymOshy
 OsmU=
X-Google-Smtp-Source: AGHT+IEIk661G/DrYQTMSZEkXC3hbm7HaqquiAPGQEc2J0rtXPijgGrIb0CQy9zIVIRpWWuNk2XZCA==
X-Received: by 2002:a17:906:2312:b0:a3d:26ec:dec2 with SMTP id
 l18-20020a170906231200b00a3d26ecdec2mr2559973eja.2.1707935698517; 
 Wed, 14 Feb 2024 10:34:58 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWLSChg+ClwkuKiw4Lc4L1sbb5gq7WxpXIQioTq3lD1HOxuXMOqLOMV7Gu/My178VywXrNp7mBV2w618NjhUQAbA5H0nrP7MQJ/DAI3St2S7qt41y/sOMZBJ2JD4h5IXKQjJtjAmYO4drFQA9AJAb8DvS9SSCrFbrD/0JPgtO6bzKa3FhsYRUyvWsDjxbyJNAd4JQt+n0bo+uMEhKe+RozRvnxMs793OKq4hITg804vsxoVI9qVHNdm+53Fs2JnYLGt/4bWx7sSK9c6JHq+bEm+Tgo8ZuRtGH207D6fgIYw8dqBFk1JVxyN2uBhj7vBO44x6jhZtITvhyKS4ZmuasZGFr2xAQV8nq4ORQG27Psb1XJYcFiEAnU0iE0xWVSSr/KaDnOC+15Qe0xy/NxpCKuCALnSDhLq45Q=
Received: from localhost ([185.186.156.113]) by smtp.gmail.com with ESMTPSA id
 tz15-20020a170907c78f00b00a3d153fba90sm1609058ejc.220.2024.02.14.10.34.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 10:34:56 -0800 (PST)
From: Igor Opaniuk <igor.opaniuk@foundries.io>
X-Google-Original-From: Igor Opaniuk <igor.opaniuk@gmail.com>
To: u-boot@lists.denx.de
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Bin Meng <bmeng@tinylab.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Roger Knecht <rknecht@pm.me>,
 Sean Edmond <seanedmond@microsoft.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 3/5] cmd: optee_rpmb: build cmd for sandbox
Date: Wed, 14 Feb 2024 19:34:42 +0100
Message-Id: <20240214183444.493629-4-igor.opaniuk@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240214183444.493629-1-igor.opaniuk@gmail.com>
References: <20240214183444.493629-1-igor.opaniuk@gmail.com>
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

Support CMD_OPTEE_RPMB for SANDBOX configurations.
Test:

$ ./u-boot -d arch/sandbox/dts/test.dtb
...
=> optee_rpmb write_pvalue test_variable test_value
Wrote 11 bytes
=> optee_rpmb read_pvalue test_variable 11
Read 11 bytes, value = test_value

Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>
---

 cmd/Kconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index a86b5705174..8ad8c0c542c 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1370,7 +1370,9 @@ config CMD_CLONE
 
 config CMD_OPTEE_RPMB
 	bool "Enable read/write support on RPMB via OPTEE"
-	depends on SUPPORT_EMMC_RPMB && OPTEE
+	depends on (SUPPORT_EMMC_RPMB && OPTEE) || SANDBOX_TEE
+	default y if SANDBOX_TEE
+	select OPTEE_TA_AVB if SANDBOX_TEE
 	help
 	  Enable the commands for reading, writing persistent named values
 	  in the Replay Protection Memory Block partition in eMMC by
-- 
2.34.1

