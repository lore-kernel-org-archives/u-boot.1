Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4B46FF8864
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 08:50:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B873184836;
	Wed, 29 Apr 2026 10:50:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="K3vw3H+1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8AC3E84839; Wed, 29 Apr 2026 10:50:12 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D31F84701
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 10:50:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4852a9c6309so111556545e9.0
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 01:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777452609; x=1778057409; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tP8S2vCnPUOTHCdSLjF83sI5WzpncuQq+LerM+aCeQI=;
 b=K3vw3H+1wHXouhbU5bnXIQ0ZBylRYL9qKpABE3HThGIGNJOE6F5qUDY/s9BXDoADom
 8WpAPLR4ahdveVkoBZ6nb6ldpyh6q0SwkbZtCcEZuamiVrm+z+IaKPqNOA5FXyG4AZrE
 y1vtECQBDc6It+N/htTfKM5LEri3P5Pa+mbAK0D9EpkVHIqAnJI4tcy6MmyKayipQQqv
 fu8G4k5uP896JTMZ9V/UTReIHKpIsGrP2o2UJUUL/pm6/50Y1mLAt2R9vWuJcoTqwfFJ
 rY4PizwZYFJt7h//SRlcdX9fYCFajU5LKs2dFm5gNP/LICSSwP/CLLXYTcPVaXWdt5Rv
 bCZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777452609; x=1778057409;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tP8S2vCnPUOTHCdSLjF83sI5WzpncuQq+LerM+aCeQI=;
 b=OKHTHtMNjlGct8IIZzzCvEAP1v4D9M6Ii8B5k26tYmVtHTCQoIWJlZWKpYJqHwIsqF
 q4kQ4EacUNo/CEkDdiORiTvBfLnByN3AenVw+kp9Wyj4VbLuEwa/8ZFAPjRKT4ilgHe9
 H0ZqtPW8nU4QmTCPvgIQyp3g7a1dmBOqhp1hLXyUK/gJfWVyon6v7VW9Ok35sHXesAg+
 whRlZSqHwrxuGA1aZeGsCMg+djnZaPUB9It1JlPqGYvCgBhLQ+KFLJkJhNu0Tpxjt4B7
 ZX/VphADhBLbR4igMJdHmAynRn0O+ca5HYfBx28ygc8toL85Zv1QrNDKzj1LHPKTQajg
 3Elw==
X-Gm-Message-State: AOJu0Yx4iqO+76eGMZPX3EShbjJOdDPwgzAsRMTfgJ3MNAJPJvCCwNf5
 5qQ+lrLdbHm3CcktLjT7KsA7+AFIOs2JApJ/iUQ3ziSNzuoi9+rwAr9JNh6Tk34Rno0=
X-Gm-Gg: AeBDievZyqOHi8Z221H/VQfqSlVI5h2QZAyTjDPGBHBv32pfL9fO0PREThF1hya8LHd
 sCQrilWFfMOjUBICaUyOXo5BMGPVUZm2OzTdMh6w7DEbUarRUDo86HNTZ04f5EUmSDQOkLQE4Dw
 CUTp/f4c95k3FRAiu1QZWvQ3OnTDoq0jTuAm/DwlyPN1oLlOpr0eXfjbjDK4RHV6Lmdtu4njUCm
 8ZyZ0Dw0I2eHwpmmYsO8km/eswmTlFX1R+NUOoQ6BTmNEFmmZ1dcweP2e8gaZg2Vgu1DyrM152o
 5g+RVE1z6mbFsSJaU6AM1ajBRC+lMZO7rmWypQgGO1zUmJwT/3D3j2Yk0KWYrQvbw0Dj+ZvbQ5I
 d7EzLEHuvX54IlgukcXAXvygh//qARZCg6dF4pXHgOYkvNjIqJVuko+lB5qy0Eaksi3iXbM3K5h
 pUy6pVEUbGfVxfbSw9LjIVdLt2pTxk1IvR7zmoCTBk3ZGlOrSCFWNQrCzkdCt3q97XtfFRoO/ss
 CgT+A0=
X-Received: by 2002:a05:600c:30d3:b0:485:3ff1:d5ed with SMTP id
 5b1f17b1804b1-48a782dbab7mr56656825e9.1.1777452608904; 
 Wed, 29 Apr 2026 01:50:08 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd86.dip0.t-ipconnect.de.
 [79.195.221.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a7c2f2eb8sm21729005e9.6.2026.04.29.01.50.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 01:50:08 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Cc: trini@konsulko.com, sumit.garg@kernel.org, jh80.chung@samsung.com, 
 peng.fan@nxp.com, neil.armstrong@linaro.org, tien.fong.chee@altera.com, 
 miquel.raynal@bootlin.com, msp@baylibre.com, 
 alif.zakuan.yuslaimi@altera.com, balaji.selvanathan@oss.qualcomm.com, 
 w.egorov@phytec.de, varadarajan.narayanan@oss.qualcomm.com, 
 rui.silva@linaro.org, ilias.apalodimas@linaro.org, me@samcday.com, 
 marek.vasut+renesas@mailbox.org
In-Reply-To: <20260213111009.1254360-1-aswin.murugan@oss.qualcomm.com>
References: <20260213111009.1254360-1-aswin.murugan@oss.qualcomm.com>
Subject: Re: [PATCH v8 0/4] Add QCOM RPMH Power Domain Driver Support
Message-Id: <177745260108.126665.6273956382353740536.b4-ty@b4>
Date: Wed, 29 Apr 2026 10:50:01 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1280;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=cHwaDmjlYwnrDH4mvDLNh4d7pAA/r2kAUXi+VE60c/Q=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhsyPx+zjTzRd/LlnxkVb7YrrucvlM1/1ubncd3nZFbqhM
 uKw5Zu8jlIWBkEOBlkxRRbxE8ssm9ZettfYvuACzBxWJpAhDFycAjCRzZ6MDMs/S73Z9OnmwXv8
 njHv5ZbJflq8bNO/zNW7igUN/3//OruN4TfrWUZG32knI4qbO/o6vvElWf/VTmD0DjvsttniTOJ
 Ek1gA
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


On Fri, 13 Feb 2026 16:40:05 +0530, Aswin Murugan wrote:
> Add QCOM RPMH Power Domain Driver Support
> 
> This patch series adds support for the Qualcomm RPMH power domain
> driver, responsible for managing power domains on Qualcomm SoCs.
> The driver is ported from the Linux kernel and adapted for
> U-Boot to enable proper power domain control on SA8775P platform.
> 
> [...]

Applied, thanks!

First and last time I use b4 review, the commit shas are wrong but you can find the patches in https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commits/casey/qcom-main-13Apr2026?ref_type=heads

Apologies


[1/4] power-domain: Add QCOM RPMH Power Domain Driver Support
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/e0ddd3e72ced
[2/4] power-domain: Add warning when power-domain driver is missing
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/e00528ba122c
[3/4] mach-snapdragon: Remove RPMH power domain DT fixup code
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/4ab832742202
[4/4] qcom_defconfig: Add QCOM_RPMH_POWER_DOMAIN config
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/43c5913549bf

Best regards,
-- 
// Casey (she/they)


