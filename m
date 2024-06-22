Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00B3BC27C53
	for <u-boot@archiver.kernel.org>; Sat, 22 Jun 2024 14:36:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 623D888001;
	Sat, 22 Jun 2024 16:36:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="R+y8tdiE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 231ED87FB5; Sat, 22 Jun 2024 16:36:27 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B62F87D8E
 for <u-boot@lists.denx.de>; Sat, 22 Jun 2024 16:36:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a6265d3ba8fso309797466b.0
 for <u-boot@lists.denx.de>; Sat, 22 Jun 2024 07:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719066985; x=1719671785; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2N8RNRcSBLmt0ZSK5CiACSpazEEoUvaXOylAXemtb1s=;
 b=R+y8tdiEptRjeRld33GnAlLW8a2VTVvvQw7iLhvVZStDHUulu36ZmPJ9D5+scty5cS
 3aClAF8yitrIM9U84QMzQH6mg0cQ56KI3hUWB0aZONSA46BpcacKk2xhfoWL0y6Oym9o
 ct62mrogkEad5NbB6VQA+rRjMZW07lccpsn4zUyPRtGTi8ogf5bJcQg/G6s6MhL7gH4R
 +hsfdAnFGSHBHhvqlcguhdmXUTtBKpyPqFw01cIxay8RKdiL5T5IZJw74/VElMEKbrJe
 uTUTaRY+9sT/lJzV3wm2xXD33BhOQApu3fDsw1mpugu53NQSllbYJurmzX38+c/xy72f
 aLKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719066985; x=1719671785;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2N8RNRcSBLmt0ZSK5CiACSpazEEoUvaXOylAXemtb1s=;
 b=mmbFmnSqHiRXKqRonRFIFbaY9+C0PHzbLazt/wiknYBU7I5SyQX0fvPhzRwu26mnbm
 M51Ii+6NmRTlBr840WcpYgDTXyAOP5nukyRogBTPadLlfqNhmQKgCcXcxdOb3AdbBPqC
 IOfvcNKBx0NEKJQG7C+mcf4lxrNQhT+Jm/y9ddQhGrPucqmX1RvkkvbAtJYqczP3loYA
 AntUXYq/HB6cQX34z60HuPoXCD8uxZpVa+hXekCBw9Id8Z15sAQAwVcQcB71P5VybyqS
 Vq7AftsO3SaMw8R0MAVvADcDZ5wgOrxKrIZtGE1FSseWkSJrMctwbHixifn71CPFitxj
 L7iw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+PR6wdAUYXDwAtztxUNL8DjKm1jptn3xplRgJ8dYoWlJF8gCflASbsixS9Su2av+ELRkYS/y77JNNGM9huSMnhDg5og==
X-Gm-Message-State: AOJu0Yz97uXIg58uzh5ESC09Q/w0Uwszrd6L/bKrwQNjBv4aPwxJyXI/
 hYh8iGYiWsE7MrcphtnCFv0e59ZbI5WSYleOEsndF6rITKbjxNDcz9UjNSv4IUU=
X-Google-Smtp-Source: AGHT+IFHbN3T4VLHB9egDAseHQV1DbZe26CvQU8F4qA3iTqYbf33HAWLVj8uBuDLWP65ATUA/S/GLA==
X-Received: by 2002:a17:907:c307:b0:a6f:2981:56c with SMTP id
 a640c23a62f3a-a7242da6a35mr29659866b.53.1719066984464; 
 Sat, 22 Jun 2024 07:36:24 -0700 (PDT)
Received: from localhost.localdomain (ppp046103020130.access.hol.gr.
 [46.103.20.130]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6fcf54a534sm204005366b.136.2024.06.22.07.36.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Jun 2024 07:36:23 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: sjg@chromium.org,
	trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tim Harvey <tharvey@gateworks.com>, Bin Meng <bmeng.cn@gmail.com>,
 Sean Anderson <sean.anderson@seco.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Michal Simek <michal.simek@amd.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, u-boot@lists.denx.de
Subject: [PATCH 1/7] tpm: fix the return code, if the eventlog buffer is full
Date: Sat, 22 Jun 2024 17:35:37 +0300
Message-ID: <20240622143601.187723-2-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240622143601.187723-1-ilias.apalodimas@linaro.org>
References: <20240622143601.187723-1-ilias.apalodimas@linaro.org>
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

We currently return 'No space left on device' if the eventlong buffer
we allocated is not enough. On a similar check later on that function
during the call to tcg2_log_init() we return 'No buffer space
available'. So switch both error codes to -ENOBUFS since we are always
checking a buffer and not a device.

Fixes: commit 97707f12fdab ("tpm: Support boot measurements")
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 lib/tpm-v2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/tpm-v2.c b/lib/tpm-v2.c
index a67daed2f3c1..91526af33acb 100644
--- a/lib/tpm-v2.c
+++ b/lib/tpm-v2.c
@@ -554,7 +554,7 @@ int tcg2_log_prepare_buffer(struct udevice *dev, struct tcg2_event_log *elog,
 		if (elog->log_size) {
 			if (log.found) {
 				if (elog->log_size < log.log_position)
-					return -ENOSPC;
+					return -ENOBUFS;
 
 				/*
 				 * Copy the discovered log into the user buffer
-- 
2.45.2

