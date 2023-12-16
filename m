Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 140DBC46CA2
	for <u-boot@archiver.kernel.org>; Sat, 16 Dec 2023 20:11:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D9D487C4A;
	Sat, 16 Dec 2023 21:11:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="SxstWDX7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4050E87B0F; Sat, 16 Dec 2023 21:11:27 +0100 (CET)
Received: from mail-vk1-xa4a.google.com (mail-vk1-xa4a.google.com
 [IPv6:2607:f8b0:4864:20::a4a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2AE9A87B0F
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 21:11:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=3awR-ZQcKBp4KMPGRXDEMMEJC.AMKS-9MMRJGQRQ.BCLV.BC@flex--moritzf.bounces.google.com
Received: by mail-vk1-xa4a.google.com with SMTP id
 71dfb90a1353d-4b2c93002cbso686236e0c.2
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 12:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1702757483; x=1703362283; darn=lists.denx.de;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=R+TXkMJ/t6Q+3fjY90wLx224mzpS5P1fMn5YjECxOas=;
 b=SxstWDX7cD5/oJe6sQWpa1kXRc7M3MdeQKMiwJZA8pJNd0jOyopPFLbyNRNleF8qFG
 RUzkinOpcxBBaE+cHeyyNUCdegCiW556N2kc5foGv3QBOC+an500PjbDcydMYqSgP9gK
 VQUliZsTSP90cWuAisgVmB7JFxh8nWr/O28u83+/wQLmhoLC0bfjkwVE1MOOBObnlqlo
 NSN7NZZzO/GdBhrEPTF66nS/+cFiRwrjYOIkDb9WWDXG0vGXxQA86zh/OssM3yWuas6z
 IIJv6y7faOX/rf2ifeLqS25k7U0Z3+KR8YI+s4WKQ9k36AxJjdHygIFVUV2+lN35ii/N
 xP2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702757483; x=1703362283;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=R+TXkMJ/t6Q+3fjY90wLx224mzpS5P1fMn5YjECxOas=;
 b=Rj4f1MFU7BGYYaB7HUs/qB3sFOwe4rZoC1upa7iCZlAx8l+LQSZFsF8uB3FExC7mqx
 vk01Bl330tWX7lej2n08a0x8cEGQ554hjsgII1ov0rIY/mrjo/wnpvNENpOqLT3oHIiF
 OCvKgq2mKonRZK9xM6sth8kzeDP2YYmR2dXVVG7jbyUQKMM29YXbpSe4zhg1pa+REnDv
 pah8FNw4Wbnl5yJLREAA1XtwyUqs82OFlSPsZuVdjD9K64pbQFkWUqs4o++7aOR4gshP
 2MT7dRJxg+xKbut1ZuC1reWfxwpfbSoT56Vm4WAph+AzldhWNl9qe1EXA8p4THSKZL9X
 9neA==
X-Gm-Message-State: AOJu0YyEzCB/a7MyQ2HCaw90OPyNuRhARMeLX8M7mMXMfy4GOz/Ex23H
 debtbTy1aGU13TqLrykydbdZQRCyr/Dq
X-Google-Smtp-Source: AGHT+IGwePY9dUe876CZQIU5Z1jp7ZjbvOCDP02RrvTMWUfWzvp89BU19TL/2yu502bEKxvaLO/scCCHZPDf
X-Received: from morats.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:d9e])
 (user=moritzf job=sendgmr) by 2002:a05:6102:1612:b0:464:a368:25fc
 with SMTP
 id cu18-20020a056102161200b00464a36825fcmr380819vsb.4.1702757483712; Sat, 16
 Dec 2023 12:11:23 -0800 (PST)
Date: Sat, 16 Dec 2023 20:11:19 +0000
In-Reply-To: <20231216201120.2735840-1-moritzf@google.com>
Mime-Version: 1.0
References: <20231216201120.2735840-1-moritzf@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231216201120.2735840-2-moritzf@google.com>
Subject: [PATCH v2 2/2] nvme: Update scan namespace to keep trying on busy
From: Moritz Fischer <moritzf@google.com>
To: bmeng.cn@gmail.com, sjg@chromium.org, wenbin.song@nxp.com, 
 u-boot@lists.denx.de, trini@konsulko.com
Cc: mdf@kernel.org, patrick@blueri.se, Moritz Fischer <moritzf@google.com>
Content-Type: text/plain; charset="UTF-8"
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

A busy controller shouldn't be game-over for all controllers,
so keep trying on hitting -EBUSY.

This change brings the actual behavior of the routine in line
with what the descriptions says.

Fixes: 982388eaa991 ("nvme: Add NVM Express driver support")
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Moritz Fischer <moritzf@google.com>
---
Changes from V1:
- Added Simon's Reviewed-by
---

 drivers/nvme/nvme.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/nvme.c b/drivers/nvme/nvme.c
index ec45f831a3..59a139baa0 100644
--- a/drivers/nvme/nvme.c
+++ b/drivers/nvme/nvme.c
@@ -695,7 +695,9 @@ int nvme_scan_namespace(void)
 		if (ret) {
 			log_err("Failed to probe '%s': err=%dE\n", dev->name,
 				ret);
-			return ret;
+			/* Bail if we ran out of memory, else keep trying */
+			if (ret != -EBUSY)
+				return ret;
 		}
 	}
 
-- 
2.43.0.472.g3155946c3a-goog

