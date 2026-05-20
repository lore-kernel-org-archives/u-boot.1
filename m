Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DF85CD4F3C
	for <u-boot@archiver.kernel.org>; Wed, 20 May 2026 13:08:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 375FB84815;
	Wed, 20 May 2026 15:08:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UTCkRp08";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A5C584832; Wed, 20 May 2026 15:08:01 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01527847F6
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 15:07:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4891c00e7aeso36353465e9.2
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 06:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779282477; x=1779887277; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ps1MQNLZ0vzja/ive02JaIUdpI/pR8J8+FnFR3dZXNk=;
 b=UTCkRp08VzIHskANtcw2uhxKNL1SzJaENsF0NQhkl35uQFN18lIH2C3nGxZekcv63S
 n1VYslYo7X9NXz6WAeWil4p/9DEWTgDVW2B2V7l97APlh/3vWvPnXsex7lDQWtnMdNoq
 biFzZiMXNgSLcmDxeNucVskEgeNsAc9z5zTjA9x6Cs1UXt+wehxib5Ll2AN1mRLJJfcO
 0nPSzvvpxve5yp6S4cnoGapqcw2Y6BoMimKwdT4Jhc7uFclYy9Tw+E1yiyAUHH7PZUsc
 bJse/H9rjSnPgW2JXscS39m39iAfXuGqLLB6AlL1prmEDni6YtAZJQqXgC9Lh2Sn9aKn
 SCAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779282477; x=1779887277;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ps1MQNLZ0vzja/ive02JaIUdpI/pR8J8+FnFR3dZXNk=;
 b=F2QnSq/dlYwCMNtG4HHUYrkLGTLRiMvt/4eiO7NC5Vl4H1DyLFmj636h2LWEHoewqN
 burT7hEi0UGxOa1+MfTZHt02cG/QXy518zsHcMX+hAchiryDghHv3To2lW1Fx61DhQ0N
 MJuKx7JvQ6FERKruW/YhmRWBiDH2ely6OPIv48/X2jnHz7oEJtracgsRDOBjf/bgf5gc
 sIp/Edjd/oaVUPgabvqc6anqupMkMuU35m3F5qcojc9SRSHqox7wYWd1dOOQR9fEqhMV
 UJvo+0tcp6JL2YS/vlYNrv65GqAx4tYUTwYqHnxgvcbV9ry/1OR+9z4Rx5CQ2XmGbEjV
 chlQ==
X-Gm-Message-State: AOJu0YzMh8ReoyHa4PXSvL3vHUSVXYDt2y3fGN6rdfWDizIsXRS0s4zu
 QeSdS//u97KGQFNEfyPUGkBn3aPcg132aNahbOhbzpitrfWTeeU4I4ia6bfxV70PI5w=
X-Gm-Gg: Acq92OGIrOzmgWVUoVczY/h/F3c8gBzUo0NT/j3KJLy6mADIEqW54hG5OwLogVKiNy6
 3t7+N4ji/ebxg2AxP9Y++ssHpm6VLAhEY4mPcYQUnco4oS10etz+Obx7cTZ3Gd1RWefWtHNexf5
 IdA62Zr0STj9pwm119i8qup5/58bcX3aqYnLnbI9eYZE3bFAlBTDKQIsyn5DR2fce2gfF3V2/sV
 hPECaGXWyo9HeXaCMqS0NaFwSa2zs29K/LRj0XwRAAfGivbpLgMJ7EQRQOUo6Q5+TCJhqf85+ZG
 CH48HvuLEddURW74ZOxXyfOinhtfo74XMwv7JMzgCe5/p9eY3+//gxft0KCSdPyzMj/dxjgtdNL
 n1lMN5kG8CQQ6tMlDS+bRWAthJ27/Np8CwLlC3q1FOMbheB51vl4rFknio+Y2tU5/yTuXIgMnJI
 ZUdJsh0gMoAgUDLBDzyqNQAU9rFlZJMkID5Kwt3AsRyYi/
X-Received: by 2002:a05:600d:8448:b0:48f:fb0d:8d86 with SMTP id
 5b1f17b1804b1-48ffb0d8ea0mr265938865e9.32.1779282477257; 
 Wed, 20 May 2026 06:07:57 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48ffed60c8esm97613735e9.10.2026.05.20.06.07.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 06:07:56 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Casey Connolly <casey.connolly@linaro.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>, 
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>, 
 Yao Zi <me@ziyao.cc>, u-boot-qcom@groups.io
In-Reply-To: <20260508122144.512818-1-marek.vasut+renesas@mailbox.org>
References: <20260508122144.512818-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH] pci: pcie_dw_qcom: Staticize and constify driver ops
Message-Id: <177928247654.3007879.897450050126184217.b4-ty@b4>
Date: Wed, 20 May 2026 15:07:56 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.1
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

Hi,

On Fri, 08 May 2026 14:21:37 +0200, Marek Vasut wrote:
> Set the ops structure as static const. The structure is not accessible
> from outside of this driver and is not going to be modified at runtime.

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-ufs (u-boot-pci-fixes)

[1/1] pci: pcie_dw_qcom: Staticize and constify driver ops
      https://source.denx.de/u-boot/custodians/u-boot-ufs/-/commit/1f4f0f37d7567d4bad86dc42e8b04206d3c8daf9

-- 
Neil

