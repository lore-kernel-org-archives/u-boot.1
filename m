Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BD0DC0219E
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 07:56:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7276F800CF;
	Tue, 11 Feb 2025 08:56:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zF/QCpUo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14C76803CC; Tue, 11 Feb 2025 08:56:02 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D96D80079
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 08:56:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-438a39e659cso35671425e9.2
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 23:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739260560; x=1739865360;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=f264kMv7Iv6tZjhMlungzZ4frgzsID1q1xcer9o8xqw=;
 b=zF/QCpUovML1haz1XepN4+bXZjfU65ZTnCxFM3rwQT3kXTQM53LzYySw644Pa4Fo/1
 GmnKOHYyC0C+aay21XPZOQD9E9LqIO3kFnoeDdK0yPOdSUQ/Et55/uQPzmqpyZBboI/T
 lWdd7bFqjtbfHZsjOnADAUVNrhCs/98qlnUef0IrxlblnU7Ie2XKCPxHWmMs1iSzkSKM
 y5c9vdjFGMZl4hOe8DdeMzvPuGdyT84e1AJgwBrSKNNsnV7zTSNWkyrlFEyjWLLwUgQU
 KfOIQqtv0ZE6yQLLSlWMASJiZmHRukEU2/+n/vHQLpo1xMLxqiyTdyZi/A7WHQhXASdx
 eUPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739260560; x=1739865360;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f264kMv7Iv6tZjhMlungzZ4frgzsID1q1xcer9o8xqw=;
 b=rrjb7mZB9FXSsZscqnHXX70Imt1Xzq2/2M7wsdso7oIYh75UMyAt5PC449nAhKcLdq
 0DZc1yGuv85kBS8QjMV+bb08vik8Zv4sLvoPiTfmIQG6ffBv0OPrLZct6awmQDPZvSI7
 YpfWgSMDEMGIYLp3bOHkjlDL4vDCLeqyq4A5JHXQycEqFqQ8xm0KB3ooST10/QcIlEdu
 9xqKz5d0ESN+WGcT8fJ5vPyo+Cvml9zJB9y5rueA8laDwpTdoxXPLAvBV4SztgmKUldf
 IUcliznJrGV/0P9L1oRllpymnsWkN4KP3pkNvx1trfThaXRaVc5r5R4aJFYSe4cfqGUo
 nWvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRD4zivfKEHJxcIWaxFeTBHvzT9LtIuNOpuJWRwQC5HZXLhkv9B6oAIY1YLiTK6uvxPvX9Dk8=@lists.denx.de
X-Gm-Message-State: AOJu0YxMyT1Xv9bkXalYPbjB5xKqTqu+Y+N2CZxYkkkkI1ajRLbKAwhc
 DT58ilIGORvWCdjmxhK+u3/UF/pVN5aNQWOJb1wA6zyCIdfvvWfwI3tW1Y/3qcs=
X-Gm-Gg: ASbGnctqx30oShvEaFQoTbdt93hO/S8h9J8fSrmT/XtK4cJ6Ax2hXXDEmgU4IPQC1PT
 s3o0NWmVORwYnjq5k/RMwaooJXEY2QmAZ1eRT8pz1vTKZIgfRpWmVE2qzjG6LKqOG4FCsnhYLkA
 IRnKF/9e/ZgYWLetmdJbjyoBD6si6lfBL2WJwPvSzusEBzWJJNFZRksJyyYMd1FQB3j+qyQiJUz
 EDIVcTaZamtSlM8EtDLiLv1hGqFzKSZ2UeLcK2jotwfViKbSWA2CEX9JGeThChorvHC0aR1lP62
 7di8b9grjB8VtD5os5LBzasl
X-Google-Smtp-Source: AGHT+IGf6DWxalsUTCOtgUYGaLAbpxJ5ruYb8tbG6anuOzQfygIB+mLrEoTnfE9p28N5x9gTLAsBqw==
X-Received: by 2002:a05:600c:b8c:b0:431:5863:4240 with SMTP id
 5b1f17b1804b1-439249a3ca8mr130582415e9.24.1739260559712; 
 Mon, 10 Feb 2025 23:55:59 -0800 (PST)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dd150eed5sm9326660f8f.28.2025.02.10.23.55.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 23:55:59 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Marek Vasut <marex@denx.de>, Patrice CHOTARD
 <patrice.chotard@foss.st.com>, u-boot@lists.denx.de
Cc: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>, Caleb Connolly
 <caleb.connolly@linaro.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Jan Kiszka <jan.kiszka@siemens.com>, Marek
 Vasut <marek.vasut+renesas@mailbox.org>, Mathieu Othacehe
 <othacehe@gnu.org>, Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Oliver Gaskell
 <Oliver.Gaskell@analog.com>, Patrick Rudolph
 <patrick.rudolph@9elements.com>, Paul Barker
 <paul.barker.ct@bp.renesas.com>, Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass
 <sjg@chromium.org>, Sjoerd Simons <sjoerd@collabora.com>, Tom Rini
 <trini@konsulko.com>
Subject: Re: [PATCH v5 0/9] Restore USB and add UMS support for STiH407-B2260
In-Reply-To: <c8790ad9-0e81-4780-8da8-bbc06377c360@denx.de>
References: <20250130163547.512990-1-patrice.chotard@foss.st.com>
 <4492fe8a-1b60-44da-93b7-383eae3fa269@foss.st.com>
 <c8790ad9-0e81-4780-8da8-bbc06377c360@denx.de>
Date: Tue, 11 Feb 2025 08:55:58 +0100
Message-ID: <87ikpg6hkh.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

Hi Patrice, Marek,

On lun., f=C3=A9vr. 10, 2025 at 14:42, Marek Vasut <marex@denx.de> wrote:

> On 2/10/25 11:28 AM, Patrice CHOTARD wrote:
>>=20
>> Hi Marek
>
> Hi,
>
>> Any chance to get this series merged in next U-Boot tag 2025.04-rc2 ?
> Gadget stuff is on Mattijs desk, please ping me in a few days if he=20
> doesn't pick it up, I'll do so then. Sorry for the delay.

Sorry about the delay, I missed this series because it was not assigned
to me on patchwork.

I will pick it up shortly.
