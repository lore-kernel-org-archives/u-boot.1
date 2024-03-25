Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13479C54E64
	for <u-boot@archiver.kernel.org>; Mon, 25 Mar 2024 08:18:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D523287E01;
	Mon, 25 Mar 2024 09:18:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HFJZrCBI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34FF2870D2; Mon, 25 Mar 2024 09:18:16 +0100 (CET)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB55287E40
 for <u-boot@lists.denx.de>; Mon, 25 Mar 2024 09:18:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-513e14b2bd9so4973194e87.2
 for <u-boot@lists.denx.de>; Mon, 25 Mar 2024 01:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711354691; x=1711959491; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+y+BCQ+IezcAM6J9++TSwV2woiCiuaXVxZ2JRbW4Hm0=;
 b=HFJZrCBII3Vjlg/ebxFvtuUMVmw3GBa/v2RCh7WSV1pBdqs8YfbhjuaypjDNBiZ2nF
 1gOpIOVIa5UEgMMOcWeDP3j2Eue5l1OucQjLdCphgJpIIpf0a2Z0vfJBq77qFHO3/90c
 RXveTPy0yEwGtmqRCFqere6eN79v7/lOy0ThxO8FCUT9KZPxb6I4QkO1+1np4bbkKK4e
 x7m5VuJgGla6BRbaYk2cPotDz9BKvli5x6Mca4F6GuA6zfdZ0ft4WWfbVkcDD0nbz3/9
 LBg5YM99CbNWnbxL53U3i4Cr5pjSZeOEGmK2hxmRfZRUbm/o2HmLDsHsCi3SvKijM8ql
 Ol4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711354691; x=1711959491;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+y+BCQ+IezcAM6J9++TSwV2woiCiuaXVxZ2JRbW4Hm0=;
 b=TnEW1W2QMkD8PpYSqOPInVXPBfdsvVqo8a+g5a+N6aZ73P+LH6DutHK7AMlhH7lwKG
 1jtGAdpjJ5hj6z5TvLtPAoK6EbXKn3gxIVrRN/Ui51+nvYKi3AZdHyWqcig84kyxLOwf
 Xcmme/5+1RZuEeU9yKy56jETID+h6x70IT4EZ0Z1DkYsE3I1abVC6gmW4fxZExcULAC9
 15Jan008A0E62MqqKDUiIrVcQVdMISn1rfq4wKXrtlbNA9QYU9N1DWirwPzZoT+/MK6p
 1p59praqyeaSMDPvqm1b6ruPmU/ecpJBi3xVIiWmcaiSif7JDmqZJJRg278GK4cMkFvI
 7i7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDuZTqTMzdXZD3fA4cVyjWRHa+fH2IoYr3u66zGDFc98VVMdJa6v+ZjM5VyXO+27+haV1/J8o/D8J0iywbTl2M3vCHkQ==
X-Gm-Message-State: AOJu0YyT3rwshM+Q1cJnqa8jlFqErw0nNxUgk2YNXHFT+xgJCQ05e6u4
 TkJV+gXOG0J3C86NmStAx3htapzsFPxuayhkkyPo0iEYLPoS3Q9XqwZgXsdmtCo=
X-Google-Smtp-Source: AGHT+IFgTObAQNj8o+xWIbdNOtB5CeJcnuOh2lY3hl3ZM37N3Lio3dRWfP0YABeuGETGy1CKvxvbTw==
X-Received: by 2002:a19:9149:0:b0:513:dd23:7a02 with SMTP id
 y9-20020a199149000000b00513dd237a02mr4035607lfj.26.1711354690964; 
 Mon, 25 Mar 2024 01:18:10 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 m29-20020a05600c3b1d00b004146750314csm7686212wms.3.2024.03.25.01.18.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Mar 2024 01:18:10 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Vyacheslav Bocharov <adeep@lexina.in>, Tom Rini <trini@konsulko.com>, 
 Beniamino Galvani <b.galvani@gmail.com>, 
 Christian Hewitt <christianshewitt@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
In-Reply-To: <20240320-u-boot-fix-p200-serial-v2-1-972be646a301@linaro.org>
References: <20240320-u-boot-fix-p200-serial-v2-1-972be646a301@linaro.org>
Subject: Re: [PATCH v2] board: amlogic: fix buffler overflow in seria, mac
 & usid read
Message-Id: <171135469018.4116391.8263371182698704176.b4-ty@linaro.org>
Date: Mon, 25 Mar 2024 09:18:10 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4
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

On Wed, 20 Mar 2024 09:46:11 +0100, Neil Armstrong wrote:
> While meson_sm_read_efuse() doesn't overflow, the string is not
> zero terminated and env_set*() will buffer overflow and add random
> characters to environment.
> 
> 

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic)

[1/1] board: amlogic: fix buffler overflow in seria, mac & usid read
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/d54f87f09a36ac20154955297b7c999b368b0443

-- 
Neil

