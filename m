Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46858C2BBCA
	for <u-boot@archiver.kernel.org>; Sun, 23 Jun 2024 11:49:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09F9D883C8;
	Sun, 23 Jun 2024 13:49:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="oZVCXEmn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9737882B8; Sun, 23 Jun 2024 13:48:58 +0200 (CEST)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DEA5B883C8
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 13:48:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2ec50a5e230so19858251fa.0
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 04:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719143336; x=1719748136; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NJz2oYt4jSXTwcWTYQxqwNejhA7/1Al/S+D8dMqAk1g=;
 b=oZVCXEmn23Nub0scsZuD7M7ZqyyMZKsppvH1nQRYQISkHaCa3xdh/HrUN2TgxdB9LV
 Zv4ajb7TEXOW6CLRgT6fkIuIxBrMNFjqyR13e2XPrVZH8ZDFwRTREAsV6DOFqFT6sMvP
 Jy3TDBUdiubJimm275RY97Ofw0zfNSMRoKR227EsRIOTvt+LmGJh8HOXLLMC7qGA/Qma
 X1OjNBH1AhtT7TjFwKPPcSOaa4ZgGAGdug5AWlph0/2m9Gdrtlk/g0jzMar354wRGVdp
 os70vTOhCAMq6Z7sQzJVsVDuOAxoAXsB4KC5yNzWqx2D3hyhS421G09HuX1u48CIMgWK
 bmXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719143336; x=1719748136;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NJz2oYt4jSXTwcWTYQxqwNejhA7/1Al/S+D8dMqAk1g=;
 b=o9HSUaJSltGMXb491l9mi2Sz63gD0ZQvCle5XoHOIEQL3J6XnLLtQDycJ+JHXza0L1
 NgWYAmejovrSlpEuzBDG33QUp/M/wh2PY+Pfhk6CQkS8sKNlMJro8GfRXMAMktCZhXr2
 I8Dj7QfN90SIkU6lfX13YvtU0PXR3+DYH0qS204pJYv5X05yoFoeVMclQxG01yMwnfdr
 qeAE7fVohaA3ezePwo/J+g/VL78h5DX8nSU8w2JNftIyI2dHzXej6AvsAYeGtlZ9bDR6
 aYrU80XwWFDzsXhUp1kJ0545bRoPjy/mhu6uzl0nF7wKa+UxZsbGOXlxQZWvt6wTt/iW
 gyLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXttvSj77GEKzPEieJP40qPVkfv29917g3eR/YzOpGQ2ESvezNgKpWZCxA3qDmQEKhb+fk+XboMLp/zb+O0czanW4A6TQ==
X-Gm-Message-State: AOJu0YyfvzkRqsLkrJc3EBoZ+2nSCtgeWFMaeJX8jJk537oc/9y6zCrU
 Ex2ZFi9mHMfVTfY35H/EvoKEwUX3bR/4uoxPXrsoFLd916cb8IFKyuszchzHj5E=
X-Google-Smtp-Source: AGHT+IHEa7AdTVL4Z5DvKsnJdDVWOmBFK4+U8is8RNqns5tfJsC7XXESMYNj9aqCr25k5wFSfmKgow==
X-Received: by 2002:a2e:b0f5:0:b0:2ec:4086:ea6d with SMTP id
 38308e7fff4ca-2ec5b2695d9mr11802791fa.4.1719143335903; 
 Sun, 23 Jun 2024 04:48:55 -0700 (PDT)
Received: from localhost.localdomain (ppp046103020130.access.hol.gr.
 [46.103.20.130]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57d30534ffasm3402053a12.60.2024.06.23.04.48.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jun 2024 04:48:55 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de,
	sjg@chromium.org,
	trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tim Harvey <tharvey@gateworks.com>, Bin Meng <bmeng.cn@gmail.com>,
 Sean Anderson <sean.anderson@seco.com>,
 Michal Simek <michal.simek@amd.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, u-boot@lists.denx.de
Subject: [PATCH v2 3/8] efi_loader: remove unused TCG algo definitions
Date: Sun, 23 Jun 2024 14:48:13 +0300
Message-ID: <20240623114838.14639-4-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240623114838.14639-1-ilias.apalodimas@linaro.org>
References: <20240623114838.14639-1-ilias.apalodimas@linaro.org>
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

commit 97707f12fdab ("tpm: Support boot measurements") moved some of the
EFI TCG code to the TPM subsystem. Those definitions are now in tpm-v2.h.
Let's remove the stale entries

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 include/efi_tcg2.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/include/efi_tcg2.h b/include/efi_tcg2.h
index a75b5a35b6e7..54490969b2d1 100644
--- a/include/efi_tcg2.h
+++ b/include/efi_tcg2.h
@@ -25,14 +25,6 @@
 #define PE_COFF_IMAGE 0x0000000000000010
 
 #define EFI_TCG2_MAX_PCR_INDEX 23
-
-/* Algorithm Registry */
-#define EFI_TCG2_BOOT_HASH_ALG_SHA1    0x00000001
-#define EFI_TCG2_BOOT_HASH_ALG_SHA256  0x00000002
-#define EFI_TCG2_BOOT_HASH_ALG_SHA384  0x00000004
-#define EFI_TCG2_BOOT_HASH_ALG_SHA512  0x00000008
-#define EFI_TCG2_BOOT_HASH_ALG_SM3_256 0x00000010
-
 #define EFI_TCG2_FINAL_EVENTS_TABLE_VERSION 1
 
 #define TPM2_EVENT_LOG_SIZE CONFIG_EFI_TCG2_PROTOCOL_EVENTLOG_SIZE
-- 
2.45.2

