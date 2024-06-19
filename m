Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4087DC27C53
	for <u-boot@archiver.kernel.org>; Wed, 19 Jun 2024 21:23:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 907F98840F;
	Wed, 19 Jun 2024 23:23:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Quk9/EAv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3857B88485; Wed, 19 Jun 2024 23:23:34 +0200 (CEST)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 035B7882E8
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 23:23:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-25c9af0102cso142663fac.0
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 14:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718832211; x=1719437011; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uq7P1K781PJfTuQYFqdxa/EpTMsg/ZlpqIfKJ4dCE5k=;
 b=Quk9/EAvlsHYQCJ2p8XKgegXv21eQDmAaxGMkuoiURVXz6C/YpLkvM89cKz7+nJN6B
 1E9w574UsqUKEi2vaah22kONfHvPi3WD9KPOAoONNFWznmVfsl4jVv0/bbagAj4DS0MD
 82ksFxOBdxkb9408nGME6roO2glIyBeNd93gDHfm7589Ed43cA/4dtv79bwTzewPEXok
 O5d3Z0rJwLqx1IEUVnoGLD9oulf5gZQW7CPXrikyBKppPc9gnsio36HvPbnU5EKd4HpH
 HeBcdQLiSL5hJCKS63acof0UT4xuk9GqeVr+BFuYbZJknUnUHj+gJXlMZiwWrysEm7K6
 bksg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718832211; x=1719437011;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uq7P1K781PJfTuQYFqdxa/EpTMsg/ZlpqIfKJ4dCE5k=;
 b=BBv++Y7SZCJ35b4Prhs8DrfjGgO440MdCJwVvZ2Z1NQGexmabzMeEoKk/hq4jX1eDt
 IoBerLwoG8PDeYv2XhFniAmlvqEYIQ8597lPDYpYrbHYDNSTFgCERJ4UpBUIm247cSE2
 wn8C+HrVOxYuKUKkbHcIDvbvQ6gMghckqPqF0f7g9i8ev3kscCeT7QTGaH02jGLzefYj
 WWKyzAbpBT2aUS2EC/a8j3e+zBICdNoZ+AOOlwHLTUU3IC/L1o27QD4ROL1TRoZW9tKG
 B7AutYbGf5Ar9j3/CagDe1JYGhHWIxpuNMuBY0TZQWZ2U9U23YboPQ+bFEVm412CjcWz
 MqUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdiBCeEo84mTxvBm4VJ6RbdJBf8pD37OvPEtQOozPpOU6o7H4nqxuD8pkYpk3bvFyWwPK/zxdhUQt2UWgbhZ2JotiiyA==
X-Gm-Message-State: AOJu0YzPbZ0lFayg2xLJz3LsZ+fpbE5JvpRyw5TCu+bZqEAVX1azjvUi
 b58r4jVwMeIu1zu7UGyRY0muEvkLnZ9YLeQXtKEZ7c3MzPHsWkkBUlS6w/bxzdI=
X-Google-Smtp-Source: AGHT+IFyD1jNMKMmjApdXRxvEieTaesr/GyvDOHkkVVVTdXm5Ri40ytx1mHBbhbkiJZES+5kZLv9xw==
X-Received: by 2002:a05:6871:1cc:b0:258:38d5:652b with SMTP id
 586e51a60fabf-25c94901693mr4343154fac.1.1718832210653; 
 Wed, 19 Jun 2024 14:23:30 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-25699395c3fsm3922629fac.57.2024.06.19.14.23.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jun 2024 14:23:30 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Joshua Watt <jpewhacker@gmail.com>, Simon Glass <sjg@chromium.org>,
 Lukasz Majewski <l.majewski@majess.pl>, u-boot@lists.denx.de
Subject: [PATCH] cmd: gpt: Fix freeing gpt_pte in gpt_verify()
Date: Wed, 19 Jun 2024 16:23:30 -0500
Message-Id: <20240619212330.24842-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
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

In case when either gpt_verify_headers() or gpt_verify_partitions()
fails, the memory allocated for gpt_pte will be freed in those functions
internally, but gpt_pte will still contain non-NULL dangling pointer.
The attempt to free it in those cases in gpt_verify() leads to "use
after free" error, which leads to a "Synchronous abort" exception.

This issue was found by running the next command on the device with
incorrect partition table:

    => gpt verify mmc 0 $partitions

which results to:

    No partition list provided - only basic check
    "Synchronous Abort" handler, esr 0x96000021, far 0xba247bff
    ....

Fix the issue by only freeing gpt_pte if none of those functions failed.

Fixes: bbb9ffac6066 ("gpt: command: Extend gpt command to support GPT table verification")
Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 cmd/gpt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/cmd/gpt.c b/cmd/gpt.c
index 7aaf1889a5ac..98e1185014ed 100644
--- a/cmd/gpt.c
+++ b/cmd/gpt.c
@@ -683,7 +683,8 @@ static int gpt_verify(struct blk_desc *blk_dev_desc, const char *str_part)
 	free(str_disk_guid);
 	free(partitions);
  out:
-	free(gpt_pte);
+	if (!ret)
+		free(gpt_pte);
 	return ret;
 }
 
-- 
2.39.2

