Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BA1FCD128A
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 12:04:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7DCE8825A;
	Thu, 11 Apr 2024 14:04:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cMjHhl+X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7AC4388261; Thu, 11 Apr 2024 14:04:23 +0200 (CEST)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18F5487E47
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 14:04:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3c5f91cc169so1910471b6e.0
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 05:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712837060; x=1713441860; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Zc540aKxPupNGiFP5/Gdfbh7FQhsqjR/FLRZrY5C34g=;
 b=cMjHhl+Xl3wfPZPHLfRaTCoS1AL2HSG7IyRkkyw0nr6yz63wVyxKXt2DZ2NpcDprH6
 wAoYMTMTyH3LmacC1VukqTcQ4++5Dfop8pK4WIAnjAYBPxZ9eWtZF8ysLeLp9O6wIaYz
 Jm5cK6u8iUa8Ovihqi63P2+Z1yPZlcvnSqOjyPr5CpapjB5MxL0SSex1oUPleZtTltq+
 L67aOv8ljfdbw8OFWJUt3Y48nM6B8mc96sdeYPlpMA9vkAdOosXD0QPtYdjde0mkck5T
 0jgWcIOncivKPmcCeSvqkii6EpWf7YYHddfC67gRMA/VdNcV6mFpncKs3Asn8UqFWZj9
 igTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712837060; x=1713441860;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Zc540aKxPupNGiFP5/Gdfbh7FQhsqjR/FLRZrY5C34g=;
 b=Zt8jJYZ7CNoA0Y7jGlVsHe2FfUBfCUSYewAWe41gZLR7oLHK6qqUJHtSnobFEhve/u
 ehyyo4xH/GW4aXv3S6wuMyp2geijq2GVUrnVYA8s1yHYpIeTpsUoTCVY74iTUNm7YsAY
 m6Qj1FRGGGrUverLqX1McckNQ8vxkQCcLelTxpoG9UvPxnsrJHAtGx13wvn9wYEcTJHw
 RJ+AnuJS4SYu7DFM4IyyldFxuarm1rFJnf5D35kSeFNJX8ka+a7mS2B81qG8b76XXlq3
 jHVYs1vb+aUpSCTUmYMuTPrHAOr5TkQXkFFnLHcG3+h8NDJv6olI7WMWzcofTAiUDgFI
 SAtQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8NIWwF6GaThnadxY2h0NeTwJUOqmrk8kbuMk7EATqqcfhI05tFsy4y+gJZwY0UAfV42EPTut5GeqFZG3OgbupNKny9Q==
X-Gm-Message-State: AOJu0YxtrINZAWZCHVRk+m5M5S+YDLnh60yFSe+LQUluJwWCbmtVw1lg
 Rjo74A2J1gTmNBBa/lS9MKPSaEodKidDpK8TVnzcBkCHhEgewKJEQ7v4tz326phY/AU7hwPDz3Z
 NgJ9QBKlTPXQFblhpfwMLf7x1bpH5bZsniAHGGg==
X-Google-Smtp-Source: AGHT+IH58td14+VAyAz+viDHETB0rZFJYjKc0RmdGYhxzQeYmcfnm1144Yd9jTD+ySEmsE6xHMtp+4Dpf7NTGbjfep4=
X-Received: by 2002:a05:6808:1524:b0:3c6:942:4dd0 with SMTP id
 u36-20020a056808152400b003c609424dd0mr5964888oiw.57.1712837058407; Thu, 11
 Apr 2024 05:04:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240410-b4-qcom-rbx-soc-v2-0-5120a9c7f6ce@linaro.org>
In-Reply-To: <20240410-b4-qcom-rbx-soc-v2-0-5120a9c7f6ce@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Thu, 11 Apr 2024 17:34:06 +0530
Message-ID: <CAFA6WYNBnj_CvTO0d8HKMRozks2XWGVzmGyGTx4U3=L9YrGAYw@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] qcom: pinctrl drivers for qcm2290/sm6115/sm8250
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
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

On Wed, 10 Apr 2024 at 23:23, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Introduce pinctrl drivers for three new SoCs and enable them.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
> Changes in v2:
> - Fix a few formatting issues
> - Link to v1: https://lore.kernel.org/r/20240408-b4-qcom-rbx-soc-v1-0-900db37b8bdf@linaro.org
>
> ---
> Caleb Connolly (4):
>       pinctrl: qcom: add qcm2290 pinctrl driver
>       pinctrl: qcom: add sm6115 pinctrl driver
>       pinctrl: qcom: add sm8250 pinctrl driver
>       qcom_defconfig: enable pinctrl for new qcm2290/sm6115/sm8250
>

Acked-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

>  configs/qcom_defconfig                 |   3 +
>  drivers/pinctrl/qcom/Kconfig           |  21 ++++
>  drivers/pinctrl/qcom/Makefile          |   3 +
>  drivers/pinctrl/qcom/pinctrl-qcm2290.c |  70 ++++++++++++
>  drivers/pinctrl/qcom/pinctrl-sm6115.c  | 200 +++++++++++++++++++++++++++++++++
>  drivers/pinctrl/qcom/pinctrl-sm8250.c  |  99 ++++++++++++++++
>  6 files changed, 396 insertions(+)
> ---
> change-id: 20240408-b4-qcom-rbx-soc-44ee99c8b799
> base-commit: 4ba549b0a4e67c563785ab144edf47e108b34822
>
> // Caleb (they/them)
>
