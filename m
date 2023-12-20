Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8E22C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 18:19:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12DF387650;
	Wed, 20 Dec 2023 19:19:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UBEGXLMa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9A0C87786; Wed, 20 Dec 2023 19:19:10 +0100 (CET)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1706875E9
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 19:19:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1d03f03cda9so17415ad.0
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 10:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703096347; x=1703701147; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s9fPI7qx+5BB28NhxmMc7cKosBCN26xeXGAgt17lAZ0=;
 b=UBEGXLMa1zlKX4hyTsJ37K6UE2JNXhKpeqpahJcX4rrLl7lRsbVDXGQJDkc03PS/NN
 HVF/K9qxfAetq2AEbyIagX72Ep9CFLLLGb3b4etsj6m7oJBB614c3y0YTK1EjBBiDGC2
 hj1K9DvNOsQ/gqJJzsalXUjeMJuhDY5MXbBo+Yoh4Xl42nT7dD5wt3PmDzBEVBakCRHt
 xo3+Q2V750MHlO9SIRQA+P/H8RJ24vUbQVpiCNrj9mL8P53Eet1qOfI+42tG4FFllXxN
 CieZ3xTDeosFyAUBFHNoCp85ngD+C8Bn+72KPi4X/bnEdri3I6ccsxFIBrt0SxMs1hl3
 hGkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703096347; x=1703701147;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s9fPI7qx+5BB28NhxmMc7cKosBCN26xeXGAgt17lAZ0=;
 b=LfPt82c0BIgot7qnawJ5nG5Dvgk6YhQ04yjvb4ugcmK0VmBJKCD0yP5oXP24Wl1GBH
 Tp5s0KBA8Iv0/YdiboPLJiVgcutwhFgHfKJMyOtFV0Axp/a3qBThtiNrF8ZO/URMjrfD
 ygvJmLscmDtNmx2IlDnjuk6rLtQj0n0Slb/M8sRUpgo4kxm9T3xtkIbl4zxM5jhc0j/o
 vEOIn9K4yYSzGv88ha0mI9aY06ocNf3YvbHUwK7Ftqy0db9wP0SH4oN1VoxnecYfcV1P
 YkDIogTlpZfJX18FcCC9ffrERT6+Sk9bpa5FnoynRYJl/KjDU0PjtBaIJBn/l7p+Lya8
 qo/Q==
X-Gm-Message-State: AOJu0YyO2FH5d8WNG0FsBkfJOkIRUaYdgkv5zf06gTGOFKqCmVwAC3uD
 3WOXMNRRdfu1DtGHHOBpHwEHK3Ly/yhGU5Ogmm8fnBqz
X-Google-Smtp-Source: AGHT+IHXPVMAo9GVVRgPeXstKSjPaYEmW+9s011l6jsVwf0Ghr1ML5+Vieg4pf/AzEi637n4Mk1xYURilE3/EcWsJl4=
X-Received: by 2002:a17:90a:fd85:b0:28b:c22f:b1c1 with SMTP id
 cx5-20020a17090afd8500b0028bc22fb1c1mr4369150pjb.1.1703096346966; Wed, 20 Dec
 2023 10:19:06 -0800 (PST)
MIME-Version: 1.0
References: <20231220-wip-y-moog-phytec-de-upstream_som_detection_fixes-v2-0-516abadb4f49@phytec.de>
In-Reply-To: <20231220-wip-y-moog-phytec-de-upstream_som_detection_fixes-v2-0-516abadb4f49@phytec.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 20 Dec 2023 15:18:54 -0300
Message-ID: <CAOMZO5C4B7tRLv8G=PDn97BpCL95uAb9UCBUO0cnCpX-N=vjEw@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] This series fixes various bugs in the phytec
 som_detection unit.
To: Yannic Moog <y.moog@phytec.de>
Cc: Teresa Remmet <t.remmet@phytec.de>, u-boot@lists.denx.de,
 upstream@lists.phytec.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, Dec 20, 2023 at 5:45=E2=80=AFAM Yannic Moog <y.moog@phytec.de> wrot=
e:
>
>
> ---
> Changes in v2:
> - fixed accidental squashing of changes -> split into 2 separate patches
>
> ---
> Yannic Moog (5):
>       board: phytec: imx8m_som_detection: change phytec_imx8m_detect retu=
rn type
>       board: phytec: imx8m_som_detection: fix uninitialized pointer bug
>       board: phytec: phytec_som_detection: fix eeprom_data zero check
>       board: phytec: som_detection: move definitions to source file
>       board: phytec: phytec_som_detection: fix uninitialized bug

Applied all to u-boot-imx/next, thanks.
