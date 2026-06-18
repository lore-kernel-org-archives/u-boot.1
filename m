Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38CC7CD98F2
	for <u-boot@archiver.kernel.org>; Thu, 18 Jun 2026 11:57:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0102849BB;
	Thu, 18 Jun 2026 13:57:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fggXZY7J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18963849BB; Thu, 18 Jun 2026 13:57:06 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CA8A8005D
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 13:57:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-460662fcb4eso631247f8f.0
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 04:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781783823; x=1782388623; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=H0KDeODvx198LYcfm7ScoQD4hPSdKX80b0/oH34lPCI=;
 b=fggXZY7JgY2kyWD7FdhbEcXAFnx7343HNhAenJYjxKNYMGUmbzqIgSurQJHMwCVjra
 lX4ObRJjwziz+bEEfu8mI58nInTQJ95AiikOgGoSoUCj8nOQvJROI309Li05jJ6Nu3Ut
 ZNFrARtYTzPO36kTdOaPSlW7Q/AyRTByKbrzjMwjSbFQ0rUoPHW68KSldbK+XtGe6usm
 W05barL9s0epIJh1xnNJAY9406lrMtfbzhpJQVxQPHHzETAkHyXUbwHN+kdTY6YrT6Iw
 vsPUMpNJC3XjFPN58dqKRnq1HP34NU5QFGFmI+/VQmd1lKL+mfYKSGDHZKJxhS/TCn5R
 /oPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781783823; x=1782388623;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=H0KDeODvx198LYcfm7ScoQD4hPSdKX80b0/oH34lPCI=;
 b=Dz/Z91vaueQ6VFGKKSAv73TlMo6qoJwscDMVakpozU9avbNBVFPLeGzpNjMVhyTw1T
 qx6byky7a20hMHqEUsvZg26bhJKlRJlVMxQJQSTruosoVuTHQSXWAxxQuLNkSgfTXiR8
 ELGwCnD8OGzZknx8OAfrCLpcWIB32CcxUzEi0lYPTLg9l1I7sEXSxyjvNp1rsZ3Ef3VF
 +LTapErzkjhxtjM6dl6iLs61bjjqYjdt+n3i4V8vIvUAE1mFVTB7yqbh574xOTA5J2sa
 9TO98G+M65ahfq94TFTskTT7a6+EbT9AIRkZJr33MAQNPSkoxe03MsqXdte/aM7DsnHY
 GQ8Q==
X-Gm-Message-State: AOJu0YywYZRYCWRmPepJ5b9iV3qqfZoSn1L1j/DBUYUFRX534DpmNRSF
 AB0mg/cJqAaA4JNi5lmQtDAhVOaniT08FXOC8PoMioIeXLGZ6B1y5Wh6gOulAAeN3BI=
X-Gm-Gg: AfdE7cmpPHCO6gQLEg90gxh3Atc6FX1hClt2AKEkQV+LrDgdB+nkVJr6YYa0rcJQstd
 d/oDuU9qN/Er69pi0I9JJDN36YhVoZdm4tnrkvZIskuZ6Wn+EHxAvBDocQg8UhFx7uqPRkFsMXx
 9PpjtI45u8AWAaMDt/KnHctffHSoIQMd7sx6xx0/zQkhO1XI/ffIgPbaSrouK0LceqaqCwxmgql
 ERnV7KHEVmlvqTpzX6sCcQLqt/nQch9wAKptIhUWnBjgw4YwBqPYAwM0/0/BdN1e1NeTOLArTqQ
 TNg0Mpue9o0qoP7OwkNXliYgcQlHMlXw+WBDJPHRXt67wwQdcdO4brGSKJP+NKZi8+2HtnDdTnr
 wCl6vdFQlpBWCSm3oDfaUj55JZpre/9KH/dzCYcJAMAJoOGz4T2YhR4FugS/LYhiHmCgD9DLgQU
 SG38Bz5bL8e1xGSBk4hIhCH/KfCy+ERO66dMXeAhwR0CzwAABagDzKqYizx9V4HchDug==
X-Received: by 2002:a05:6000:220b:b0:460:31d1:74de with SMTP id
 ffacd0b85a97d-46236275cafmr14078828f8f.10.1781783823585; 
 Thu, 18 Jun 2026 04:57:03 -0700 (PDT)
Received: from lion.localdomain (p5b29e032.dip0.t-ipconnect.de. [91.41.224.50])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46289c3b3a3sm14448355f8f.30.2026.06.18.04.57.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 04:57:03 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Thu, 18 Jun 2026 13:56:52 +0200
Subject: [PATCH v3 04/15] Revert "drivers: smem: sandbox"
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-b4-modernise-smem-v3-4-472391477988@linaro.org>
References: <20260618-b4-modernise-smem-v3-0-472391477988@linaro.org>
In-Reply-To: <20260618-b4-modernise-smem-v3-0-472391477988@linaro.org>
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>, 
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Casey Connolly <casey.connolly@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Alice Guo <alice.guo@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Philip Molloy <philip.molloy@analog.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Marek Vasut <marek.vasut@mailbox.org>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, Heiko Schocher <hs@nabladev.com>, 
 Michal Simek <michal.simek@amd.com>, Sughosh Ganu <sughosh.ganu@arm.com>, 
 Antony Kurniawan Soemardi <linux@smankusors.com>, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1594;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=l7WhGOyWkOO84gCFFvZo5hquiXEPIFtGi1BPHm2v5vk=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhizjuyxuDxdXTbN3KfW/3JZtqpd8SNnxvPuX71V/kkRvn
 dHaI9fVUcrCIMjBICumyCJ+Ypll09rL9hrbF1yAmcPKBDKEgYtTACYiy8PIsIV/qtnXD2+WtUgd
 ebtVhtngVOa/P1rh5tsV7d7vmuHucIGRYd3XnydKWDWYi13Ve3x7biwXsN/NKDsl7XyUOY+zkdC
 z/QA=
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

This reverts commit 7fd7e2cf339ea2ec570f6dae1cdfaf8e066eb4af.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 arch/sandbox/dts/test.dts   | 4 ----
 configs/sandbox64_defconfig | 2 --
 configs/sandbox_defconfig   | 2 --
 3 files changed, 8 deletions(-)

diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index 074e5c06ec82..1652848a6f5e 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -1587,12 +1587,8 @@
 		compatible = "sandbox,scsi";
 		sandbox,filepath = "scsi.img";
 	};
 
-	smem@0 {
-		compatible = "sandbox,smem";
-	};
-
 	sound {
 		compatible = "sandbox,sound";
 		cpu {
 			sound-dai = <&i2s 0>;
diff --git a/configs/sandbox64_defconfig b/configs/sandbox64_defconfig
index f5d5b21e7331..4f77edc2ee61 100644
--- a/configs/sandbox64_defconfig
+++ b/configs/sandbox64_defconfig
@@ -232,10 +232,8 @@ CONFIG_RAM=y
 CONFIG_REMOTEPROC_SANDBOX=y
 CONFIG_DM_RTC=y
 CONFIG_RTC_RV8803=y
 CONFIG_SANDBOX_SERIAL=y
-CONFIG_SMEM=y
-CONFIG_SANDBOX_SMEM=y
 CONFIG_SOUND_SANDBOX=y
 CONFIG_SOC_DEVICE=y
 CONFIG_SANDBOX_SPI=y
 CONFIG_SPMI=y
diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index 512dbd6a0c6c..331bfb20df92 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -327,10 +327,8 @@ CONFIG_RTC_MAX313XX=y
 CONFIG_RTC_RV8803=y
 CONFIG_RTC_HT1380=y
 CONFIG_SANDBOX_SERIAL=y
 CONFIG_SANDBOX_SM=y
-CONFIG_SMEM=y
-CONFIG_SANDBOX_SMEM=y
 CONFIG_SOUND_DA7219=y
 CONFIG_SOUND_MAX98357A=y
 CONFIG_SOUND_SANDBOX=y
 CONFIG_SOC_DEVICE=y

-- 
2.53.0

