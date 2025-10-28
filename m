Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFAF5CCF9E0
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 11:13:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CEFB832AD;
	Tue, 28 Oct 2025 12:13:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NwOiHTaw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A44448352B; Tue, 28 Oct 2025 12:13:41 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76D8280422
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 12:13:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-b6d2f5c0e8eso76090766b.3
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 04:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761650019; x=1762254819; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5FN/eU4ymqTl4L+cFAoGy6ti0Nt5WbHicjbM3fUhWqU=;
 b=NwOiHTawccclfpcVgnl2ixqcmo1zFKIAqEZok1oovVTNy86bBaqx9WAns1rmTepvgj
 l3Xi0eSII9zjIvbpwYN8xLLknIccqHM8RUlvTZf9oeAG3NdE7QcKXQNXDzPh0S87H6ry
 HP/dtyXGrZ+J7oIyELAFWb/EyvPzh/0XeDpiiHyxUHJ7SoGcs0XitfsLXO7Ttyn/Y16I
 1XImj7FcrJQhJ+Ss8Dcl6JJAs8Q3QbSZ433ru4HcWBorVXJ91gYBITTMtQNiZzyPNzel
 jrikN4cB/3pjuGjAaHZQrARx/jIZ51NLdazH/WFoK/B06q2Lf0hh7DaBPMrE9vylTkth
 O5wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761650019; x=1762254819;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5FN/eU4ymqTl4L+cFAoGy6ti0Nt5WbHicjbM3fUhWqU=;
 b=BvqDSiRzADXq9jmiUyD0wdgqJJaH5LHaFdvGDyXdto+I9LetyUGlP6KOz6QAAV7XL2
 /rtb96igR3CO7+XDoHKttBzMaOeOPQ3dG19rVQ3TNTJq/b6h7abdTmS8FHLN60HDvDf1
 Fi/tvmKYfjv9jUwVWoEKabSwjdBOrnNfrWHAVqltmAQf325z3Fh8cGFoLdGlAfGEj2NA
 LnMTtXmT8Guyfo2KLHHgow/AtTPbCoKNelolZYJt3ijDHv7kNHWD1bV8ssq9Yw5SYZjz
 1vVEPonkYU5KL0OEKrVuninV7f7t6dCETBrQqTSlltR1ol4w6h1ytBQKsFN7+UHKLhHR
 cRUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjsJgje78WYOcC+6pHgrxFI4VdegY29+LE7SDbsz+qdnvux9hy9hyPeRy0kObov9nVP7VYgok=@lists.denx.de
X-Gm-Message-State: AOJu0YxCV70/d+zC7BQWa/gKMGwmkG6I3ec5ODk7gWT95W3gmfOST2Mk
 DLOgHQiGaaariqBjnZ1+k1mpnvPIeTi6XsnlzwBB1sU87FQa4Np306VnH8d+INuy8ho=
X-Gm-Gg: ASbGncs3AY9uE48T6T5Z/W4SCBAADUwrrR544zOofjosDfbCcPJM6p9LkDSDy9W6vem
 t/8DvxW7GGdS4ewAO/fBcLQeEVwLfy55OeKvUf23S3pbzjUK8s7YBG561RivL+Q6CMa0JX2T5R1
 SqJb9nyEmoku3fOA1FhHx5IUPue1tYFbu2HfgVOb8EjafRJvPgzoPPyECrIvSDCPoBtRlY0vngU
 t2fHlU0+Ivh8UDpkGCAfqSLlDRFyvsdWchRD8MMUfAI3T70S9TFcGqYEsVKOX/b/7K0kjrzYOlu
 d92RSAw7B/tFHfln0mH3JG2lROEecx/Wi53kyjFthdjzGq6/D8vuxQCTWBFxRVDkZVLsiiS1NLv
 TvmgEt63XXTCOmN1h9Ses6qvcy5q+SCQOQRVGuGGd2griQnc0PL7rdjE2++inm6FjRzMm9+/Pe0
 1+bESQmw+XaEuUdbx4tTKS3xV+kch3+evSmBFHGnMhhzr/RgHUBkTl
X-Google-Smtp-Source: AGHT+IHcOJqu4eyp+3q70M32I6iEBumeOKFOVlNYk9IrGvOcZEuHWu9YwRFaNvgBQWBXPQWzdnjmvg==
X-Received: by 2002:a17:907:7208:b0:b3e:8252:cd47 with SMTP id
 a640c23a62f3a-b6dba55be29mr355223266b.31.1761650018837; 
 Tue, 28 Oct 2025 04:13:38 -0700 (PDT)
Received: from lion.tail248178.ts.net (p5b29e67b.dip0.t-ipconnect.de.
 [91.41.230.123]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6d85353ff7sm1067051766b.22.2025.10.28.04.13.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 04:13:37 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io,
	u-boot@lists.denx.de
Subject: [PATCH] tools: qcom: mkmbn: fix Elf constructor
Date: Tue, 28 Oct 2025 12:13:08 +0100
Message-ID: <20251028111334.2508482-1-casey.connolly@linaro.org>
X-Mailer: git-send-email 2.51.0
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

The Elf class constructor was missing two optional parameters: the Ehdr
object and a list of Phdr's to populate the Elf.

Add these back so that the parse() method will work correctly.

Fixes: 9fe658c97f5e ("tools: qcom: add mkmbn.py")
Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 tools/qcom/mkmbn/elf.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/qcom/mkmbn/elf.py b/tools/qcom/mkmbn/elf.py
index 86f12d1f4e5d..7737adc6a4e2 100644
--- a/tools/qcom/mkmbn/elf.py
+++ b/tools/qcom/mkmbn/elf.py
@@ -171,11 +171,11 @@ def _align(i: int, alignment: int) -> int:
 class Elf:
 	ehdr: Ehdr
 	phdrs: List[Phdr]
 
-	def __init__(self):
-		self.ehdr = Ehdr()
-		self.phdrs: List[Phdr] = []
+	def __init__(self, ehdr: Ehdr | None = None, phdrs: List[Phdr] | None = None):
+		self.ehdr = ehdr or Ehdr()
+		self.phdrs: List[Phdr] = phdrs or []
 
 	def total_header_size(self):
 		return self.ehdr.e_phoff + len(self.phdrs) * self.ehdr.e_phentsize
 
-- 
2.51.0

