Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9955E937E3
	for <u-boot@archiver.kernel.org>; Sun, 12 Apr 2026 13:00:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A2D4841D5;
	Sun, 12 Apr 2026 15:00:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bJ/lV6t+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C0088416F; Sat, 11 Apr 2026 17:40:16 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7524580077
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 17:40:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b8f9568e074so503384066b.0
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 08:40:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775922014; cv=none;
 d=google.com; s=arc-20240605;
 b=f171l2IK7c6ddtcxeITeY/zNVBNYy0cKeb05cdfO89ExfMedUAWNo07wTFawupKX/M
 3m0eryciS2oG77zGxIKtf3SsmmzC+uiX58Vxm9Xmh4Ha5oAS0Abzq96z458DU/oQPbx5
 rzatTjjhky5j0aX+SkyPIhmdY8pHEwa0zDfpxY0bsYQMh+vrd8Yl8SUI9oAnjXAt4S3V
 iPLj7Mu47tMb+J8bOTZeZYAo2vXb55HA2DrWBc9k+8Koy45/mTzg/+GwTekIxzHcUf+9
 KZ5CP6F/USqFfdiOr77OwAWVPi1SCv+qLSKgVdaXdI/jPgl8NZLuP0cqK2n6m0Sf9G/N
 RUjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=VvrpgtLMCqaY26AVZV+Tas5WArMqsVgFYcBKxo6jJwg=;
 fh=pKV29h6PBf5SbuSFTM/GZF+KoVG4OaOclZXc+5Qi1tM=;
 b=g7Vd8zE7WtdWaRXafFOUiNHUl3UPYYo8iJtB2F98dssm75WNx9M9ssWLlImTNAmvNZ
 Ti70BIqcpZbEgdK1xS62D3/3sAIn7eLXqBK3vV8XXBToS0x8nhU75En9nfB3Kf2W5uZO
 WzD+fEqpTpRI2ZSnksIAXBNVwlNhLQVovK4hOWwyEEjH1liwn2WwmZwD7cOk5ZlY07s8
 BUkjEebrWxpO3OI7emOxwBLK23ogJoRDxEfPkEUEIAyePiYxxHXFNtkBOklHyFH3WbzU
 F2EpFLGzlUvc/jaWxnmu4qsdsxzeEgOLnM869ZpgnXPiQ+B6HJ7DeCRr3IpKF4HzwMqJ
 rH4g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775922014; x=1776526814; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VvrpgtLMCqaY26AVZV+Tas5WArMqsVgFYcBKxo6jJwg=;
 b=bJ/lV6t+Rr/t2fAkvtim/0tSeQkIlGAUy4VNGrOWfT6OpYW12LHdLBzersdqQgIqpf
 qz2Ai1tarRNb7IoMiUCdfNDxtweRF4jegWQQfaBK4R0JmnMrmTaeHrJud3Z/wLxhiDyJ
 xcHCpVDhd4yKAFCRdu54JCDM+sq+WNeLBeIdQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775922014; x=1776526814;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VvrpgtLMCqaY26AVZV+Tas5WArMqsVgFYcBKxo6jJwg=;
 b=FkNTePkdbSJB4u/vABxkm+t+y2pfmOlpery3Ztky/BFtKspHhyl0aUPYWFy2dhUG8V
 10Ej5iOgfoKl0W+flbDX3dclTyjKgtciTGvuy9ydOenPiPJ9x6423vsm4EL1Us6S8bW7
 krD8UvYxRfaheCl8ZbvGcM/5zY5KqJL8TIPGhz5Wy4sGqB26RMUfzg8sXQ6p2RLcgy/J
 2LMFvIB/yq2ajtxMWapKE0KKSvjuTW2IqdNPC3vg31U0FkLsswGxSJPVdwJuv1215BA+
 0xFSFkf1e9J8qxlETIrbLnsQm7w3JWW9Hu22bdlkw59JLrqsVAY16/2xqVv9L0WqfLZS
 C3Pw==
X-Gm-Message-State: AOJu0Yze7zQIh3/2EVVlEZGS1hdfmiL+6e4Og3BT5X1td/yFVmfuYMdS
 RpixYn5hAoC6XEXUDRFAxTCM48/gXzmAc06ou0a3ktTlwIdQJqC+kKci1t4rzTRuFeSIMxjviMU
 Us38OPOFvYlTTEVImSc1YWbMpBY0zE7YF9Bvz+hTs
X-Gm-Gg: AeBDiesxUBQh12n/1XJPNavT5BiUDM+lxvuixv+7JM3j3PEHGZ3YvF2HK6vGwa9g5Zt
 0yCHPjHcPHGzDPAd+sTEwp/D1HGY8ltEy9Jcaa4u4SeQdnhPETjAntJ+vtcPrLz2C+eRZiPFxTs
 crRm4cQaAbngYcYOOSywGa4hu4WEYbdkgPvR8Kwyl72an3/aDKU6LF6pGbUnQX7LPIgQ116VSEt
 QVmgR1B2L8OsNiowDSjlu1WjuHvbXzmZL07OHs+g1E2OXJffTlC6gLCc6xe68OwF4orcAbSMJn0
 n3YAmA==
X-Received: by 2002:a17:907:c80f:b0:b9d:43a7:6c13 with SMTP id
 a640c23a62f3a-b9d7267b5d5mr445369366b.41.1775922013885; Sat, 11 Apr 2026
 08:40:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260411-qcom_spl-v2-0-9609557cf562@seznam.cz>
 <20260411-qcom_spl-v2-4-9609557cf562@seznam.cz>
In-Reply-To: <20260411-qcom_spl-v2-4-9609557cf562@seznam.cz>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 11 Apr 2026 09:39:57 -0600
X-Gm-Features: AQROBzAE8V8nuew5Kx6yctTGXLue_czhmAYwW7e_VIIUJwHRpnd-oAfcOPcBtpg
Message-ID: <CAFLszTjUEagZUEHTGYRjm6KvNKFCUpPcZZ+oFugJ-Tit8GZinQ@mail.gmail.com>
Subject: Re: [PATCH v2 04/10] mach-snapdragon: boot0.h: split out
 msm8916_boot0.h
To: michael.srba@seznam.cz
Cc: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, 
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Anshul Dalal <anshuld@ti.com>, 
 Peng Fan <peng.fan@nxp.com>, Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Andrew Davis <afd@ti.com>, 
 Hrushikesh Salunke <h-salunke@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Ye Li <ye.li@nxp.com>, Andre Przywara <andre.przywara@arm.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, Dhruva Gole <d-gole@ti.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Jerome Forissier <jerome.forissier@arm.com>, 
 Heiko Schocher <hs@nabladev.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@denx.de>,
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Michal Simek <michal.simek@amd.com>, 
 Yao Zi <me@ziyao.cc>, Peter Korsgaard <peter@korsgaard.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Tingting Meng <tingting.meng@altera.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, Alice Guo <alice.guo@nxp.com>, 
 George Chan <gchan9527@gmail.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Alexey Charkov <alchark@gmail.com>, Ronald Wahl <ronald.wahl@legrand.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sun, 12 Apr 2026 15:00:19 +0200
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

On 2026-04-11T00:00:12, Michael Srba <michael.srba@seznam.cz> wrote:
> mach-snapdragon: boot0.h: split out msm8916_boot0.h
>
> Prepare for supporting alternative boot0.h per-SoC by splitting out
> the existing msm8916-specific code.
>
> Signed-off-by: Michael Srba <Michael.Srba@seznam.cz>
>
> arch/arm/mach-snapdragon/include/mach/boot0.h      | 57 ++--------------------
>  .../mach-snapdragon/include/mach/msm8916_boot0.h   | 54 ++++++++++++++++++++
>  2 files changed, 59 insertions(+), 52 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
