Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31B92D66B9A
	for <u-boot@archiver.kernel.org>; Wed, 17 Dec 2025 20:08:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CD3B83C23;
	Wed, 17 Dec 2025 21:08:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="pj+v9HY4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48BB883B49; Wed, 17 Dec 2025 19:43:16 +0100 (CET)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8867583BC9
 for <u-boot@lists.denx.de>; Wed, 17 Dec 2025 19:43:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-6575e760f06so1932338eaf.0
 for <u-boot@lists.denx.de>; Wed, 17 Dec 2025 10:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765996992; x=1766601792;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hexBsJcnfx8CtImgULtEh44i8uWCX2aGEGngjCWTNRQ=;
 b=pj+v9HY432vBWZpG6G9pnQUs2npsXDSzJ6aQVloZdJfHkiNdm4cN7jxUuNG20MMxeV
 mRDPFRoSpafAdXfcJZtPGSKDDEd0YKkUiC3GvJWxsqZZRnakbfOzaTrxzb5PWK13b7kv
 6TnXxXFdTkzlPdIu4Wp5+OFpDD1DpCMUUzYkDasxRkBYspzJINasJIiUoyEbdUAxtisl
 U0qNR3raw87EQQPqAqsRPyMJn8+T7o8hOTeN64gJ2y6MOJfANF+pd5aZLH6jHYo1cEu5
 rOrGIXlBU/YiUI5KFqHx8/MHulRY0Ym6EOVDk1yuOuaPuPNBQ8vBb4GxGPPAGrkaStzT
 oMeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765996992; x=1766601792;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=hexBsJcnfx8CtImgULtEh44i8uWCX2aGEGngjCWTNRQ=;
 b=dXZ3f6CjSyDvxTcmO3syojPJR6LawW/Kwx5w13mquV2oAiqAVtgIFG06D0R3DtjNzc
 dgfnxanywvzv2rsHqjX1kOC25SSjI1W8LgVYlMUMBTc/2MmmsZwg5Yy4HYRrD8+XAWGv
 kOCKgjUS97HtB8YEnjXefGB3awI9r8vs1qctLbjLuZVHb5QIUoZ8QD2ADB5qj6/bbGhe
 9y5FdHzwaA47FmUpCG7ggEaHdTojI9xIT+YAKHiJdmDWKY04fiZDYXyh8SjlZqJ9s+FP
 aTYgk5FHgcAJeEDzbHrl8y0PNx9vgyMfSL80A3xflWFfsoju9UPU7SCP2VatuuhSDFMX
 EXYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7i9juSsu05ft5oosYwZg9+Q/g2FTbB47+YZig5qxA986ErVxnNukDAjU9sxyUioD9vuyuYog=@lists.denx.de
X-Gm-Message-State: AOJu0YyhTjsMvJ1I8oaVPNQmzf340IWgyStsTpCO3OHc3la7h5CojA77
 LRbUEAkJUJLyBnolgbZiCz/4fh2oNVqIG2Ew8H0LzKTDyW/ALMX1cD2keYhqYIA9KWUfrrY/YGO
 /bSMZ
X-Gm-Gg: AY/fxX7QOTbSWSEovZWYnC6Bh9RUu24sg7MHkgqlfd1ldPv5AleWbg3OghwM2agQAxQ
 YuBhWZbAziWkg/AXaYuUG2XyQ7HIHhrjpauzOBA7MhGIjRMDSVsBZ7H87S/mp2Wl/EhtTfLH2MR
 ymfEu0H74OhLMCnsK2xpW8WakFW5ZAlGjelNtliOFKxTvFnfMO+u/LotA8Rv35vFscc+cs17oms
 JFAgPveW8cdIuISlNzWJrxJAhNRpOa7DJ3q+nasVlQ9uK3Xwbi06xljVJkf7CYo9n1XwUJS35Nr
 oMYzad9fVxGCEiVX0d/8ZaKPcGAtqN7KTbDOLD9PqteYc8yw6Kfxu3KripE+f2E+K/rdi6Ee6J1
 k9cqMnDb9bGpYLVCd4raqfjuLhUfQKtwstqqA46/N98oGrGi2OPtbUZMNKUuSP1N/w48YfWoVKe
 h7RtdW4cTkXqGGtQ==
X-Google-Smtp-Source: AGHT+IHScl7A7F/sZvn/ZEVSXnyCRX/JkOlZ8GdB6TB8jiZQqV0R8Np7CzU7ibXo6vMtO4Cq0M0AoQ==
X-Received: by 2002:a05:6820:4c01:b0:659:9a49:8e74 with SMTP id
 006d021491bc7-65b45283491mr7294512eaf.68.1765996992278; 
 Wed, 17 Dec 2025 10:43:12 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:11a:676d:852f:9349])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3fa18021a81sm91782fac.20.2025.12.17.10.43.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Dec 2025 10:43:11 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 17 Dec 2025 12:42:10 -0600
Subject: [PATCH v2 2/3] doc: pytest: mention additional requirements for venv
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251217-a-few-test-py-improvements-v2-2-e1f91e3bf551@baylibre.com>
References: <20251217-a-few-test-py-improvements-v2-0-e1f91e3bf551@baylibre.com>
In-Reply-To: <20251217-a-few-test-py-improvements-v2-0-e1f91e3bf551@baylibre.com>
To: Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marex@denx.de>, Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=982; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=t0I71TTAfeqo2Gv4SiHFWMcixu1bR0qUpeJHBXgvGWs=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpQvmvV+U7EdaICOBmlj+fT3eEqpCCeqQ/38+KC
 c5RJT/752yJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaUL5rxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A4u0IAJmkPWHBaMg3u/YuOy0ZlzBH01MdsDXdUN+nU00
 Rvgzcgvbufb6mqxID/ZGCipg8L9vHV315XhcBi55lZX4ixNPmb4g3EJfsOXv23RNKF2f12g5w4O
 /HjTHsuSJ2evac1uknKRzhCiQ/kFU+kVi/E6OVsgmX+ZDTwzsAbQjfudmZ830qWI8nCTv5shDpm
 iZb96IBYowOrL0c9ClZwvmFHBjrWFCAGrNVpiz7ZlzOF1oZqpDudEWbX4ahIUGivRR1y17qevO9
 Q1Wiu+6cMPIRrH7ML5kBylgsMDJhPreheZvhtfqxv9qMBAYVYjgWgMaE+Rph/U6vLIM6dTdhCpi
 eNVg=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Wed, 17 Dec 2025 21:08:13 +0100
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

Add a paragraph explaining that in addition to the requirements.txt
for test/py/test.py itself, users may need to install additional python
packages depending on the U-Boot configuration being built.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
v2 changes: none
---
 doc/develop/pytest/usage.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/doc/develop/pytest/usage.rst b/doc/develop/pytest/usage.rst
index df3821da20d..f8b32c07edd 100644
--- a/doc/develop/pytest/usage.rst
+++ b/doc/develop/pytest/usage.rst
@@ -90,6 +90,10 @@ environment.  This can be done via the following commands:
     $ . ./venv/bin/activate
     $ pip install -r test/py/requirements.txt
 
+In order to use the ``--build`` option of ``test.py`` there may be additional
+python packages required depending on the configuration being built. These can
+be found with ``find . -name "*.requirements*.txt"``.
+
 Testing sandbox
 ---------------
 

-- 
2.43.0

