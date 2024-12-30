Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3943E77188
	for <u-boot@archiver.kernel.org>; Mon, 30 Dec 2024 10:31:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 265BE805C1;
	Mon, 30 Dec 2024 11:31:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BsBof99l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2D15805FE; Mon, 30 Dec 2024 11:31:06 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD51E80570
 for <u-boot@lists.denx.de>; Mon, 30 Dec 2024 11:31:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-436345cc17bso65747785e9.0
 for <u-boot@lists.denx.de>; Mon, 30 Dec 2024 02:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735554662; x=1736159462; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kbgci/+03PGM4WaGoKWJHQOJ8awfw42XY19W3gfsNqo=;
 b=BsBof99lStsGzhG0aGUGOciP6ROdttAYVu0p67adnfcBeH0m31Fk7WQ0dRYjUe9GGQ
 L5oWLtqXv3Zljuw9FYikM/bPpQ3r5/BHzVUPx6UuOjVWjXSqFTDZG1DMAGdgU+EwNjCX
 sDssENAVO9UZWd9UeNBI5n9eFuRgHd/5NCEatT78p//VS9VVxjKxV1JtTg1txGlrqqdx
 82PXkpq8AoxsgWUCcinTeKL5RHB7MqI4yRuZH0pCNIWuiLEhGt54kzHBp3TNzZ5QvXQb
 XIBuTD3QPXPGDO1p78iwcGunSCGiHgBkwKnHRVjlbtlJzjoyWoDvPpstdfYB0s+JJrkh
 jNDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735554662; x=1736159462;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kbgci/+03PGM4WaGoKWJHQOJ8awfw42XY19W3gfsNqo=;
 b=ldqE7VCEg3FWggbhR/Na1P6AOmyT8zQgw/vI/6h4zQcqCjCDUm9HmBiF1Kb/WmjEgu
 fwPsPlBCfoex7JIJ05Jpw0PH0uUvB2ctf4PeieaYhiEyonOBd0+S3+VQqjL5i/tj2JOI
 UL+1wFrxTxaTuCqkLRozj5Na0dPbkCg0c1eUPnJ6fwc5xxF8ZVjOg1Yp/syxklk5nLhU
 uFeXwQZThNamWBjp/8aalz4R8IuikPrlytCPYQPhRuA+YHsRCY9OpcmInjNR87uJguLw
 tQsa/qUY+2JpWNwMx+FzCDU8MFKABIMSuVSBwwZwxpyETaMCO5/BBAFbGil+CteaLYCj
 39BQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmIbPw2IKMc5clHcNwHOlRhgHo9Mks3/3IpeBogNuSdFYfwnakDEsvo8QaODLtn1KUglr9hgI=@lists.denx.de
X-Gm-Message-State: AOJu0Yw4RXAphfoCWP8HwL8GuFtx1dro6oQyxhlSlNF7T6D9CIUM1BhW
 +PZLDlE32yDCUxY81ywHiF/B4oIj95wcMMhqRXsqK1La0MJ+PfWSSIAXrZ6Xty0=
X-Gm-Gg: ASbGncuko9tK517Ajogbetge8ty+BisoH28be0HkgXOacK3Ah95MqiDEPEYG1Ib0PEj
 Im99bHsG9m0YqZhOEO2qiYoNoyAUcN6L4r42a+blj6YXVbYnKdHdtrVB/ZJJNLYHdRu0uuEvopu
 QrHk4hsyl5VKXIbHtEMq6hP3djEtTT9pL2RQguqcuvXVY/GHd8i+XjLMZgkY6GE5eA4yGv8w7BW
 7+ZoEjSw5ut/gPqgHTJbkBNl4+AzbA+rZR+jmV8gAdKoUAmBX14pe7ghqwvge0DGcARG1KD7PVe
 Ug==
X-Google-Smtp-Source: AGHT+IFU8Xd92SvaLVMn5jhreWFyC7AeSBLCUq+4qf/TEpyGA/rBICJEAgvgcTgpf88zKB9G8f65Jg==
X-Received: by 2002:a05:6000:4a1b:b0:385:f5b6:9c9d with SMTP id
 ffacd0b85a97d-38a22200054mr28319191f8f.33.1735554662220; 
 Mon, 30 Dec 2024 02:31:02 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c89e1c0sm30201550f8f.77.2024.12.30.02.31.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Dec 2024 02:31:01 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v2 0/6] ufs: core: initial cleanup and defines sync with
 Linux v6.12
Date: Mon, 30 Dec 2024 11:30:54 +0100
Message-Id: <20241230-topic-ufs-cleanup-v2-0-4c6d7994a45d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAF52cmcC/32NQQqDMBBFryKz7hQTtcWuvEdxkY4THZBEEg0t4
 t2beoAu34P//g6Rg3CER7FD4CRRvMugLwXQZNzIKENm0KWuldIlrn4Rws1GpJmN2xbU1e2uuLL
 Ucgt5twS28j6bzz7zJHH14XNeJPWz/2pJYYmmIbZN/VI0UDeLM8FffRihP47jCyjsn5GzAAAA
X-Change-ID: 20241120-topic-ufs-cleanup-23671e3fc9e9
To: Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>
Cc: michal.simek@amd.com, marek.vasut+renesas@mailbox.org, 
 bmeng.cn@gmail.com, venkatesh.abbarapu@amd.com, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>, Love Kumar <love.kumar@amd.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1290;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=UGuxo+JoLa9Ehuyb2mWIM17j0Js0zhbwQgu+vNVMQyw=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBncnZiCBj12vhNv7nkN8/PJXwDSqShiMahj2CQU1DL
 lNb8kmWJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ3J2YgAKCRB33NvayMhJ0TRfD/
 4gG/H+HAXYXnHtDLDT2328kyT7jACLyKdZRlgv4DGrajjvuZu4wgXKOHgucoEgAXg0SFY3+GuRJjgn
 cEEl+F8a5djlBESDXt4/iwveo0CSq5KWETE621PkFLfwtHIrU+mX1mv2vggyw6J583HXgq6H4rxpmX
 CLG381ap5TifNoDDJLufCPRpj4aRct11yKKQD/ympC5tatHku0p3Mw4U3HyzfAYF+rsLLH3CALnUn4
 rVVdPaWESH2TN09X3hL2rx8OopoDeXBuODqljbiccbGVuQEnQ7ci63HbX9ci1SAw5z7d2l2f/ekaH9
 5nU2zXZOlxxkYvf4tK0BaFiE7DDWA7HLzcLxZCJK2Z8xx1fT4tiZaNVADyGEW1j488JPg2lf2MCUji
 dJNpnDtJGPBntLnH6V/XVy1O4YGh1OviObc5WC+0qXDYXb9H0MJ1KncpULWTq9A6BWo8dnlnbEzgkv
 GLFXBhwYhQZh0/DauGM6Z1ZNRmjOSuDDEVoFjjqWPuNXXWhLMz9vSoahAULurwHMMkM6wOveCiSCfJ
 cWs6KIufT2z03MBC5g8TSA+mh8rT0AoMW8+KJJ9LbvSectLE6RB1RKM19WDn15BxXqn7rnIcKQ+zxC
 pws+PyGYTXSEYwg1s1EtoK+uMRKtzZbev7qL8NjenVDHqAQbnaVHbNYL1q+w==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

This serie fixes the build and checkpatch warnings, and
does a split of the ufs.h into a separate ufshci.h which
helps syndhronizing the defines from Linux v6.12.

No functional changes intended, tests on hardware
are welcome.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v2:
- Colect tested & review tags
- drop EXPORT SYMBOL of ufshcd_map_desc_id_to_length in patch 2
- Link to v1: https://lore.kernel.org/r/20241120-topic-ufs-cleanup-v1-0-a5cef54b1cdc@linaro.org

---
Neil Armstrong (6):
      ufs: core: include missing include/ufs.h
      ufs: core: mark unexported functions as static
      ufs: core: cosmetic fixups
      ufs: core: move ufshci defines in a separate header
      ufs: core: sync unipro.h with Linux v6.12
      ufs: core: sync ufshci.h with Linux v6.12

 drivers/ufs/ufs.c    |  44 +++--
 drivers/ufs/ufs.h    | 335 +-----------------------------------
 drivers/ufs/ufshci.h | 469 +++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/ufs/unipro.h | 128 ++++++++------
 4 files changed, 571 insertions(+), 405 deletions(-)
---
base-commit: d580a013cca67a8115fb88d260498bde181709a1
change-id: 20241120-topic-ufs-cleanup-23671e3fc9e9

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

