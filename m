Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC948CAC5BB
	for <u-boot@archiver.kernel.org>; Wed,  1 Oct 2025 13:21:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AC73835B9;
	Wed,  1 Oct 2025 15:21:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PMp0wvV4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1604D800B1; Wed,  1 Oct 2025 15:21:24 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13AAB83335
 for <u-boot@lists.denx.de>; Wed,  1 Oct 2025 15:21:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ghidoliemanuele@gmail.com
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-b3e234fcd4bso618473666b.3
 for <u-boot@lists.denx.de>; Wed, 01 Oct 2025 06:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759324881; x=1759929681; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BsVOTrezTbYTSGW9hxeXt2++p5+OBmRPn9Hj55R7QP0=;
 b=PMp0wvV4+DKm9eMnzQbBhtL2SOfZYaDXwlPVuG2wppGdbuxkYC6ojWNep3Marf/T7J
 VPGUTXJlh/gFDxYYV1jL+/CdzA7UWxOMK3rfcdxMpS0+gfi3ZbemInqOibWhsjiuuq8A
 mZmHXPWtlFaDpogC3T+XlQkBYFz2F6o1RAAbvbL2TaG+eAoJh0OAXvL1fyotAJ3BDIwJ
 Zh3l5alji55oQwg9kNkii1HMYAbGYHqDhl0Oqic66QHK/YWcMRdc4PA6cX48J4PuOyzd
 /y9eABlEKDCZufF/H/H2kRlhmRMciW86RgQB7jnV027GJHUbfEqqbZEzWiHsfe+KikCm
 p3tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759324881; x=1759929681;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BsVOTrezTbYTSGW9hxeXt2++p5+OBmRPn9Hj55R7QP0=;
 b=h+FONPRRwfXKFTzLl3v2OGSol+HpMvZP/H0yjpJ4VnZfph8IA/B5wkimV89p0TLIIs
 6bdx9cuqRQcRV+e8WZDLsf13a3kGR+W4OVKCFS1f4etA8uC+xJ33bOnlk2P1XR6luENw
 gW6IsyOuXQnnIPAd1InOz6h6FwBsc6f8EMfuxlULn8yv4tGgjmJ9BJDJKHiB0IrxOsCV
 18r7ADF37RvNIs1oaLLIkctGa9pRwbFn43EazxdfwfqdyPe4/YhDNoWy6FJC8UYDAq+L
 Y+6HWHZtlm6thZ82deaZPBoH3iJQpw9mfAOaE6phzyoPd3yr/IyePUajBQZpuXvtT6CM
 9oFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/Y3p1GoKsCkJ65Yaxlm8adxO3Ya9TzeUtGpZKZs9l/1IKUgU9BEJrgfjN3AWaT+0+TfICJCo=@lists.denx.de
X-Gm-Message-State: AOJu0Yy58Hdn+s5y159JvQeWlcO66Eab5zpKhPguW4jZCsmjOojCnISW
 qW7QMUBN2k4mJdQzPh1B9Z635K1OORVzun0VpcRboEw56ZzZ78hbJZI6
X-Gm-Gg: ASbGnctiBLlhNqsNB5CfW9dJHKlHhN4B+vEhqK/iHowHIbZ+dQ9wEqvpcATD56yRJdQ
 L7IMstHMxcCDAQioBMRYKg4q/IB8EBRobbPNisPjHRsRDobuDBlTDV+m6ESU1dQrdsRwx0EpTHK
 jgJw7BFepdiJRYWMyXCeRQAkC5h6VUWZvVCN37rk4I+SEYIve604ZPnF4m34qXUE1x8eiteVQnk
 FLf/PsTFH3gqas6tKiPJ0KWjQwSy8QD8KMlh9XX2jrfc4Di1iLHxY2cfoNIUWQUY8EdPV1iimyb
 jeHihpj+T2iaA41IILUjr9JKexRpU+EqSDyQruaS4m3JbDCjMN7kE86pfqlyMiMOFvSRSPwB3Od
 XV+pS/lTVkW2jVS++4+ekUA9JvGPq3Zd9Kb5Vm+wbf1+SxHhmmxwwP3uzRPY7CkA7tX6vpALd8K
 QjdL3nj964sPRenUkWblmdjHPYd6GfiSUuiZ2Vu/YzOD6Nxzu2ad4hrflXeuJ09LtGMqhadqL7
X-Google-Smtp-Source: AGHT+IHtjGf0pWf/tqrphFZy3p9AJ0aIt5PUE2lOJ8l1YTR3u+0LVTfwaex9X3/rBXdr3E2NoIxYZg==
X-Received: by 2002:a17:907:948c:b0:b40:33ec:51ea with SMTP id
 a640c23a62f3a-b46e2436380mr408503966b.6.1759324881411; 
 Wed, 01 Oct 2025 06:21:21 -0700 (PDT)
Received: from emanuele-nb.corp.toradex.com
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b401d3d4124sm566956766b.75.2025.10.01.06.21.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Oct 2025 06:21:20 -0700 (PDT)
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
To: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	u-boot@lists.denx.de
Subject: [PATCH v1 0/4] configs: toradex: enable USB Gadget OS Descriptors
Date: Wed,  1 Oct 2025 15:21:03 +0200
Message-ID: <20251001132111.1490516-1-ghidoliemanuele@gmail.com>
X-Mailer: git-send-email 2.43.0
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

From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

USB OS Descriptors are used to install and configure the device without
requiring any user interaction on OS which support them (e.g. Windows).
Enable them in order to improve the user experience when fastboot is used.

Emanuele Ghidoli (4):
  configs: apalis-imx6: enable USB Gadget OS Descriptors for fastboot
  configs: colibri-*: enable USB Gadget OS Descriptors for fastboot
  configs: verdin-imx8m[mp]: enable USB Gadget OS Descriptors for
    fastboot
  configs: toradex-smarc-imx8mp: enable USB Gadget OS Descriptors for
    fastboot

 configs/apalis_imx6_defconfig          | 1 +
 configs/colibri-imx6ull-emmc_defconfig | 1 +
 configs/colibri-imx6ull_defconfig      | 1 +
 configs/colibri_imx6_defconfig         | 1 +
 configs/colibri_imx7_defconfig         | 1 +
 configs/colibri_imx7_emmc_defconfig    | 1 +
 configs/toradex-smarc-imx8mp_defconfig | 1 +
 configs/verdin-imx8mm_defconfig        | 1 +
 configs/verdin-imx8mp_defconfig        | 1 +
 9 files changed, 9 insertions(+)

-- 
2.43.0

