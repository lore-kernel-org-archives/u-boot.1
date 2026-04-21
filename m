Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76583F8FA6E
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 12:37:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED64D84258;
	Tue, 21 Apr 2026 14:37:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="dHFdWahO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1437F842D2; Tue, 21 Apr 2026 09:45:59 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0639D80077
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 09:45:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aristo.chen@canonical.com
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 9BC823F7FD
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 07:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1776757556;
 bh=mniogYl2hDRWZ/lvSun0TkyuqBEO7dHuNVbbV+Nyq4Y=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=dHFdWahOO7lwGeZICj4oJeKIoCwr269wxFi4KzEXQSqAs/AmeMo34LUQhM+7sQaAv
 Pu+hciSdNGE5q8Fp0KTMsoW9UjgQaPzJeW9Zw/em7q8gGJlqZouKveaefHlPNflRQG
 kB572JLlNcA5LwFUIcg1deoZMTmlcJk83Rx7gYM2H3Yqo3zJw3o8tWEhhePb2ZuiQi
 MN+2KgLmVgFxhDLM45lUHPBEdTdHGxRJABbhmJgwBwoM0pkAU+3fCgqMHrk9tqEpcW
 hRlR0mg3RvV2dk1LyPtHrLX/ngmXL91Z/Sgytabvw0RiXVteTsNxC1Me6WjdPh3k14
 jPdNZOLo8AgmhNbQjt1vgAylFrP//MCePToHky5Zf2EalMPAM7pz/E8AOfNz4bNL3X
 HWeSBd5fyjgc5jCO6PjMOAx/jHZ6vpT/Mrj+YWf+i5jTWONPSqdO/p8jPGbdGi+++9
 JgCfIlLYI+Y0eRkS+ZHelJHZdjgJfambXGEbY8GjWHdyHI69uGCdV6HyXrnQuyWqUv
 dGdA3hPJNb25Fh00vcnLzSZdbNSMIMmGP1YryOuAWNY7yj3zGchlnWM7emVwyabV+w
 0bpgsJd0K7ufY67tdO1Kzg0zofbnS9L4Xod2FIF0CQCWCFd9LvSA5jtmer6ZsVxKU0
 cefuTKiRoIS3NZFISy5zC6uE=
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2adef9d486bso36133055ad.2
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 00:45:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776757555; x=1777362355;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mniogYl2hDRWZ/lvSun0TkyuqBEO7dHuNVbbV+Nyq4Y=;
 b=LTBK7b9FrjddF9sifapueEH/nDBxnA10Gg+VVU2StkILYhsMxvNZUFXANga26y8J1d
 jCAmk5zref+BG/qc5rHL7M+TAOb4b9kQaMI/hdOQu5d0urEMoc3tdZ6tJfT78HbOIIoM
 E7kvjBDJ8F4Txe79irGrmQGPCJNPSv85Av2QqQPzIbN3hWGxkr2oaZ2GolABH7rvQ78a
 kJ3mfhzccfTU/l60nEeRPovmSAAG+AJ3KYrZsdcDzVQmzsKM1ueH2iizZKcL+Km63iFc
 ba3hKaYWHb9OED/UJBzVvJH08gM8JhofAqaDTYEB0sGjyDYluKUeMLcb71BJcZcM93uj
 nIXg==
X-Gm-Message-State: AOJu0Ywe6ApZ8LFpxMZ4zOBxPZdFtAQuFH61zgugKshxsRyFhuqZhVoL
 nlxOdktIihmAsS/4rbleBEi5l4IzFEVJRdirpm+KDxQyjLycLTsJpj3o3CWK+kSdlyfDuC91Uyg
 RnU6wLgKrjsKG15jqJ8Qbe5gu2+Ijfke11rs0NSr9bXs7MXfZeRSJVZI6K6nL6H/J18C5gH/I86
 k79LvPSw==
X-Gm-Gg: AeBDietixNWInEn3Wm3UZ5xUY7Vc1KXzO5H2Hh3UyWtZLdcPoIxLqf5IIEdAdNhPm0M
 HRU43Y3Q7ge39ciBlKNO9dw8lT8zme0l+yqsX0uM9iAV5XMDj0ZXgqmEX4H4iLSK23yUg+EPAmk
 EXOJd/d5OI2lQL8J5Ld80JF/UU0dz/sNpaAiEf9iwkFPmhI6RlgzVaaDB8wr2/zuHcfWKOytj4s
 85+zxLt+nzBUoWCoYy6KjSrGduaSvuREtPG6x52qJT+G6+EHJY8+y5QZfh8A6IXAt8/Uon1jHZP
 bvp0UDmFIdZ+zU1L6PYMoZAcIdEnVw2MDmQhv2ERYJ1C5BF7gwgr2XBb5Elxj0wVHIm8jbZo2Oh
 QceIhnRrPgtEJ878eK0nq8QS8ipKaeMXN8xI2xGL3oeiTVXgTQAEN1wcSmng3+ta1I8juOum9e1
 FxYVUvjz4=
X-Received: by 2002:a17:903:124c:b0:2b2:57df:264d with SMTP id
 d9443c01a7336-2b5f9f61ad2mr186781055ad.33.1776757554786; 
 Tue, 21 Apr 2026 00:45:54 -0700 (PDT)
X-Received: by 2002:a17:903:124c:b0:2b2:57df:264d with SMTP id
 d9443c01a7336-2b5f9f61ad2mr186780675ad.33.1776757554112; 
 Tue, 21 Apr 2026 00:45:54 -0700 (PDT)
Received: from noble-uboot.lxd (124-218-37-86.cm.dynamic.apol.com.tw.
 [124.218.37.86]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab297c8sm118729345ad.67.2026.04.21.00.45.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 00:45:53 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: ggiordano@phytec.com, w.egorov@phytec.de, trini@konsulko.com,
 marek.vasut+renesas@mailbox.org, iwamatsu@nigauri.org, bb@ti.com,
 afd@ti.com, d.schultz@phytec.de, peng.fan@nxp.com,
 patrice.chotard@foss.st.com, hai.pham.ud@renesas.com, michal.simek@amd.com,
 Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v2 1/3] configs: r8a78000_ironhide: Drop duplicate
 CONFIG_SCMI_FIRMWARE
Date: Tue, 21 Apr 2026 07:44:38 +0000
Message-ID: <20260421074523.4930-1-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260420145353.3923395-1-aristo.chen@canonical.com>
References: <20260420145353.3923395-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 21 Apr 2026 14:37:42 +0200
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

CONFIG_SCMI_FIRMWARE=y is listed twice in the defconfig. Remove the
redundant occurrence so each option appears only once.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 configs/r8a78000_ironhide_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configs/r8a78000_ironhide_defconfig b/configs/r8a78000_ironhide_defconfig
index 64e2c278a7e..180704e75af 100644
--- a/configs/r8a78000_ironhide_defconfig
+++ b/configs/r8a78000_ironhide_defconfig
@@ -29,7 +29,6 @@ CONFIG_FIRMWARE=y
 CONFIG_NR_DRAM_BANKS=16
 CONFIG_POWER_DOMAIN=y
 CONFIG_RCAR_MFIS_MBOX=y
-CONFIG_SCMI_FIRMWARE=y
 CONFIG_RESET_SCMI=y
 CONFIG_SCMI_AGENT_MAILBOX=y
 CONFIG_SCMI_FIRMWARE=y
-- 
2.43.0

