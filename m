Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9D3CE77188
	for <u-boot@archiver.kernel.org>; Sun, 12 Jan 2025 03:42:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEE1B801F5;
	Sun, 12 Jan 2025 04:42:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PpiTpjgu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E6EF80628; Sun, 12 Jan 2025 04:42:20 +0100 (CET)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB0F1805E9
 for <u-boot@lists.denx.de>; Sun, 12 Jan 2025 04:42:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-2a88c7fabdeso1546745fac.1
 for <u-boot@lists.denx.de>; Sat, 11 Jan 2025 19:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736653337; x=1737258137; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b5u5G11aunGI+aml/J793NesimzKzJxjlVD8EIiicUM=;
 b=PpiTpjguuWJ+o2gdhfOYFVuNFx9YwIsZ1yc7kqL3dpzh+L2Chxs354G8TV1fwQZxhZ
 blTQFT7rQ34XymrJYkEiBwPdaj0ka79Wr2xKwUwwqQR+/jnfPR+nv13iP/1cdGQJ2/in
 dNxwuE5k+grioKIZE2mvpvw0pCLDmnfpR4ZGfz3f4SjRfzkIdPCG9M0j0R6sYr466Rd9
 37SwRhPtGR01jxuh2U4OQ7LtpUjKszNZwRnge18jDKuOZ1xOomyHQmp6jsZLu8y0uVPt
 raPvSpv9YIVb3lR2Vn/hGVAATK7MLNHOWPSCkweEKbeU/8faaqvebJjAe4tI0ePZTTts
 rGnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736653337; x=1737258137;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b5u5G11aunGI+aml/J793NesimzKzJxjlVD8EIiicUM=;
 b=lKF9Dbbbjses5bRmg60iMFTgo7UIwM1UywtmNtoNrZG/iFdIxTQSMS4bBVeNhzOa21
 IJA04rDREebR6exi5fUrfUJS0xrgTGG+MUOQPNc0beFvQy435aLqZhbYr3GZ5U+fJjxC
 SzA+rmDJ9z9S3hKdV5sROXNV/VxdFoM/kSP0kXD+CePyZxel7hWxLYmdTajKR2DwqJ8P
 xYLsv5aCUkSrRhsdjOKgy5pFqRKYs4ACMHIwenfTx0m6iUhkvX/izCUh29Vmj+SpbsCB
 oXtlJ8gEPg2ahWpGIau6C3hqkRX5ukBXqpGLjr0GUTV1kkrr5M6jHXDucpvBJUjJekBE
 kH1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNASz4KWbmYAbKlJblSxgWNc/z21sNYSgt0MgGVuX6VTk3V2+Zl7lmmSilwTpRSoQfqc2m85I=@lists.denx.de
X-Gm-Message-State: AOJu0YzyFCP8+TH+I09IQaKY4eLcbh0uW/iotp/qtCyP5ZBo8sKlYFZJ
 zWzCn7fNExMMCN/Z81WBXYYWLp6GahAAYWJjqGBcPx68ZzfDAiQL3sVZIoi4Yzk=
X-Gm-Gg: ASbGnctNz4Elkkxdohao2omPKTJE7afMu9paXEEfUfovhBrCxxXLhRTxdG2yISUEvPW
 8MywpBoHtV5oOSAIwv65sbzDaWycc3/b5+gDRjfIpiJmViMlm22/C8U4AIVUGbRtQ8kt/ubGAxp
 XlJ8C4zrlc3+n+Ptmwqfpc7umSEGNgTlZZEW5LouBmtKoC2r6T5H34ZF7GMdmGzigw5NnfPAlp2
 wQsl/osER9jaIzZl2ALw47dkxV02nC9r/jc95tv+a3JmRBu7GHDye/vf3+U8+yNY0o=
X-Google-Smtp-Source: AGHT+IF+SZzolkTTQJRzxw480FqXajc/2T+iNRu0w0W5HRrI92fPIidBuoX5akS3Ta4bP1NVORd/eA==
X-Received: by 2002:a05:6870:1712:b0:29e:6bcd:3ba7 with SMTP id
 586e51a60fabf-2aa069191f6mr8474027fac.28.1736653336672; 
 Sat, 11 Jan 2025 19:42:16 -0800 (PST)
Received: from localhost ([2605:a601:a0f4:b000:264b:feff:fe59:d7f7])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2ad809af70bsm2558462fac.36.2025.01.11.19.42.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Jan 2025 19:42:16 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Martyn Welch <martyn.welch@collabora.com>, u-boot@lists.denx.de
Subject: [PATCH 2/3] bootstd: Probe bootmeth devices for bootmeths env var
Date: Sat, 11 Jan 2025 21:42:12 -0600
Message-Id: <20250112034213.13153-3-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250112034213.13153-1-semen.protsenko@linaro.org>
References: <20250112034213.13153-1-semen.protsenko@linaro.org>
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

Specifying efi_mgr in 'bootmeths' environment variable leads to NULL
pointer dereference when 'bootflow scan' is executed, with call trace
like this:

    priv->fake_dev // NULL pointer dereference
    .read_bootflow = efi_mgr_read_bootflow()
    bootmeth_get_bootflow()
    bootflow_check()
    bootflow_scan_first()
    do_bootflow_scan()
    'bootflow scan -l'

That happens because in case when 'bootmeths' env var is defined the
bootmeth_efi_mgr driver is not probed, and the memory for its private
data isn't allocated by .priv_auto. In case when 'bootmeths' env var is
not defined, the std->bootmeth_count is 0, and the execution flow in
bootmeth_setup_iter_order() takes "no ordering" path, which in turn runs
uclass_get_device_by_seq() -> ... -> device_probe(), so issue isn't
present there. But when 'bootmeths' is defined and contains efi_mgr, the
std->bootmeth_count > 0, so bootmeth_setup_iter_order() follows the "we
have an ordering" path, where devices are not probed. In other words:

    'bootmeths' defined           'bootmeths' not defined
    --------------------------------------------------------
    priv == NULL                    priv != NULL
         ^                                ^
         |                        device_alloc_priv()
     no probe                     device_of_to_plat()
         ^                        device_probe()
         |                        uclass_get_device_tail()
    dev = order[i]                uclass_get_device_by_seq()
         ^                                ^
         | have an ordering               | no ordering
         +----------------+---------------+
                          |
             bootmeth_setup_iter_order()
             bootflow_scan_first()
             do_bootflow_scan()

Add an explicit device_probe() call in "we have an ordering" case to fix
the issue.

Fixes: c627cfc14c08 ("bootstd: Allow scanning for global bootmeths separately")
Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 boot/bootmeth-uclass.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/boot/bootmeth-uclass.c b/boot/bootmeth-uclass.c
index ff36da78d5a1..049389403191 100644
--- a/boot/bootmeth-uclass.c
+++ b/boot/bootmeth-uclass.c
@@ -11,6 +11,7 @@
 #include <bootmeth.h>
 #include <bootstd.h>
 #include <dm.h>
+#include <dm/device-internal.h>
 #include <env_internal.h>
 #include <fs.h>
 #include <malloc.h>
@@ -146,6 +147,12 @@ int bootmeth_setup_iter_order(struct bootflow_iter *iter, bool include_global)
 				struct bootmeth_uc_plat *ucp;
 				bool is_global;
 
+				ret = device_probe(dev);
+				if (ret) {
+					ret = log_msg_ret("probe", ret);
+					goto err_order;
+				}
+
 				ucp = dev_get_uclass_plat(dev);
 				is_global = ucp->flags &
 					BOOTMETHF_GLOBAL;
-- 
2.39.5

