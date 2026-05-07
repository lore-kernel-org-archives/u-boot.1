Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02C5CCD343F
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 15:31:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89FD784B23;
	Thu,  7 May 2026 17:31:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BYdDs6U7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14C3184B2C; Thu,  7 May 2026 17:31:51 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 394EC84A44
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 17:31:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-67da63ae541so1681457a12.0
 for <u-boot@lists.denx.de>; Thu, 07 May 2026 08:31:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778167909; cv=none;
 d=google.com; s=arc-20240605;
 b=VvFhuET17tc/O/pHhTm1qiOJBadgNdGVcqPN1vTyW2p0jtLlXpYvCRSv7L7FnPncPd
 /3C88k3qVp99jJ8tpgR+HuYDX7N4Khiqj1B5Vk/Aq8WfyRzxtaK7TrihhfSymAdzviCO
 rsy7bdsFP/YB5JG4/rJljD2w39Ds1uRjgyeAtXE0qVAVD2CPwpsfXmsQ3g/LfBH5CsI3
 hkJ2uW4FPBVYYXxieERc/TA0RX3jzBPQXmjdd1t/rDMVCV9zM1CVkcZzW2cGXPsDk9tE
 U/A95pxf3MQxGTGGEkf93ojrIfYtxNCh4qZjsVnSl4CwCyxQ2Km5YSMeqvLOX0TObn3U
 4s6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=xLXm9dU5vDDgZwE3C3WdrJCN+QVFvi9m8q5a1llX7iI=;
 fh=ZaO1aIcB7nMLqaOtSBj40q7k5YB1on7u4y/3DMOuPiI=;
 b=d5bNDr5TgE2qEyIaL3On7oSDjtFjBrMYxfScaeX3nC5Y38PoHZNN7ZOBujOVXLnWHf
 wfIWUFm4iBnCEDvcDbWydPIPcfbsiOkqTtqMtTkHhty9ZSz0gCutuheCC+SMavF+XmT8
 z9nkXEeVRxwW2Gwvp+UJBfv+C8M89FhrWSDyZT0ADudArdqAdceqpjdQKxLcvr4UsLUZ
 obK+Mf+iaQ0GHXWTn6dvFW9Um83FnoIEsQ+ajcW9QRaYhKlSPqTJ4QGTyZ4G2jcgMHkV
 FkLnc+jsMYTJNmwkaHuL4OUCGshdrx1OYGPV/hjqDPw82hgvgwq2C6SWBOp9XS0sT6FR
 LRTQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778167909; x=1778772709; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xLXm9dU5vDDgZwE3C3WdrJCN+QVFvi9m8q5a1llX7iI=;
 b=BYdDs6U7b8huNSxPGKXLUizyKLnpAdcrzQaueyDCgq9RUVX3isdY7gsKk1n5EuxUFE
 kR0BusOHNNMw8aXZjrsDKJVU6yU1bGbabPzuYHcg0H1MHvMI2iqTqJA8439OSKiKPIEb
 wTXe3Ebu//35xj7G06x+cTAokQ4EM/3ojcS68=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778167909; x=1778772709;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xLXm9dU5vDDgZwE3C3WdrJCN+QVFvi9m8q5a1llX7iI=;
 b=cYsPuN6vAsttmvRffd6pRPGMpqSIY0KEgkc58W3ww8SVNMz9IxD8dJoh6fUd8LDW4Y
 26hbW9zQWO1O7eulTyu5K2EYARRCJmcOuzlYAS6Z5afuXssdpDHDsNcah+GYzlICvA58
 woZ+a0Hw4D0h/2v9P2e40ERX+p8aGaf6B74rzO2iQ2NGsQx5ilLMQrAxq4K5DeznPlQM
 s+CI5V9Ll9oxVBcElBIqxWIzgAex609NQpHLzMPt3V5rXg6+epSSIiyWQcCruovUBuBz
 ol9HrNMHwd/pqO5pObFtyplIgEP7feSreQrEzl/+HeWusTt/6bYIknsMU1JwRpUecSGj
 qadA==
X-Gm-Message-State: AOJu0YxvMTmoOOe3g1lo+Qd5kmrI23rrdAwFwx5GuuEs7JxcomN2036j
 ylL71uZhPvRs3ykHL6EBJ0AjFkPk3ZugB09CMhPyP6LhpDbuv7cQZYIIhAVnwuiuQseEaTLvQUM
 Edt2R9dKMIQrG9Mv4mv9jXE0l81Zipj0x4HmR3hWu
X-Gm-Gg: AeBDiesNNUhR0Sdi+bma0heWkjLk1krTGobRegacIBkRAaIq3kkCjph35PuEJwuUA6j
 2tVUMvn+qK1gTYFI+MyYOAZIUNyx9V5gIEin2Fd1bBguLHTKpyMGPdMohqEMXlo9rqWCYdjd0nL
 FenTmIXgjBrbAyM1AA+iFC3kHeAS8C8HNwp4ElAezxHt3tzZp7g2XYIIdxvZgT8cL36bLleWexN
 io8Q9QZrkcB16C/iaiT8+n0XzoIW7dB6JVGvBz6bFy0c7tUBzTgQsmOC0RSxnh4qBzQUqnl2OzB
 nYUBMbq0i3/QxOoD
X-Received: by 2002:a17:907:9617:b0:bb9:c23:573d with SMTP id
 a640c23a62f3a-bc56d5190a0mr520615966b.31.1778167908453; Thu, 07 May 2026
 08:31:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260504-b4-modernise-smem-v2-0-c01ec2ff3886@linaro.org>
 <20260504-b4-modernise-smem-v2-1-c01ec2ff3886@linaro.org>
In-Reply-To: <20260504-b4-modernise-smem-v2-1-c01ec2ff3886@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 7 May 2026 09:31:35 -0600
X-Gm-Features: AVHnY4JW_uDEvUHplQhXk8XaRMiD8Fw0cMiuPUC3V3Z3Jdg2oFdWUNyRcapfouc
Message-ID: <CAFLszTgwbSxN5tEZ7ShgaAi1JvGfT-ntPdeJ1q8rd2GcOeaFeQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/15] Revert "dm: SMEM (Shared memory) uclass"
To: Casey Connolly <casey.connolly@linaro.org>
Cc: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, 
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Alice Guo <alice.guo@nxp.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Stefan Roese <stefan.roese@mailbox.org>,
 Philip Molloy <philip.molloy@analog.com>, 
 Jerome Forissier <jerome.forissier@arm.com>,
 Marek Vasut <marek.vasut@mailbox.org>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Rasmus Villemoes <ravi@prevas.dk>, 
 Heiko Schocher <hs@nabladev.com>, Michal Simek <michal.simek@amd.com>, 
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Antony Kurniawan Soemardi <linux@smankusors.com>, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
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

Hi Casey,

On Mon, 4 May 2026 at 12:57, Casey Connolly <casey.connolly@linaro.org> wrote:
>
> SMEM is a highly Qualcomm specific interface, while having a dedicated
> UCLASS for it offers a nice abstraction, for things like memory layout
> parsing we need to use it before the driver model is available.

Do you mean before or after relocation?

>
> Therefore, it doesn't make sense to fit SMEM into the driver model.
> Instead let's adopt a model closer to Linux, and parse SMEM really early
> during boot (as soon as we have the FDT).
>
> This reverts commit 7b384eccc785b596f68448b155cbda26df57fb23.
>
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> ---
>  arch/arm/Kconfig           |  1 -
>  drivers/Kconfig            |  2 --
>  drivers/Makefile           |  1 -
>  drivers/smem/Kconfig       | 25 -------------
>  drivers/smem/Makefile      |  7 ----
>  drivers/smem/smem-uclass.c | 46 ------------------------
>  include/dm/uclass-id.h     |  1 -
>  include/smem.h             | 90 ----------------------------------------------
>  8 files changed, 173 deletions(-)

[..]

Regards,
Simon
