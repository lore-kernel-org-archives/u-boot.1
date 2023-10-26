Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 168DCC25B48
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 15:40:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E26487B23;
	Thu, 26 Oct 2023 17:40:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Iyj5oJ8W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A32187AEB; Thu, 26 Oct 2023 17:40:19 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12F1187B23
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 17:40:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-31fa15f4cc6so749096f8f.2
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 08:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698334816; x=1698939616; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=muSYw7lzaJcwm4ACVS22wbcZfBvffUQZYMjAC3WR6Js=;
 b=Iyj5oJ8WH7aGSKQ8BjuUgwM3YhNXF+RhRP16dvw27Q7dZjZCOH0GU1FmWPIR6H2vLe
 nBI97FwZKPZ/m211Y0N/6iwxNLWakINdjyUNWjjh+MdNgGKwevgKLqNrNJs8jD4+Lb86
 aMWWeNXcJAZGmEjFfdMnn734yQ29Nwn3txWquYgIS8Dn6s6EezjZxSjxmrwaYfmllza2
 bZZa5yCB5jUJBGSkrtVbe75KX+l9e6jvm6t49VYDtxIhOzes2+M1qjUPQv0zNd8gALyg
 sgPL72G2GYF48ERJqJad4BkG0cXoM7VpiPRYxlW5jOS1SVFoLA1iydPIBvn++WCF16tJ
 IrQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698334816; x=1698939616;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=muSYw7lzaJcwm4ACVS22wbcZfBvffUQZYMjAC3WR6Js=;
 b=WjxCkL3rI0WRoiqvwuWnOoR8hUxwurnQ1Pn7yr7V2XwuKCQ9oD5aMBdgpTElZPluq7
 JTnHmS5+H9Yn0sFykh4IJj7X9RTgZP+JH/xPmlyqsM189XG0y0baiUHxmUFxZQP9Gb/V
 /sUiToYk2CL3s+0pqr1KNVu38ubxA2pl1UizQ9ekDMp9AQR096OMrkza4vyGbtEUnCxm
 2OMua3qbr8Yn5iPvPg+j+AC1urph++Fp6sLzqxKHF3qPLO/CEa1VRjXgvKmf1iak/+B3
 UgZeqopQ2pjA6ODQxPoHt1p58tqyMFHLx/y906Z6IcrZWa4OuZkLE65C3+f42Ip1J+Yc
 sOkg==
X-Gm-Message-State: AOJu0YxZiawwP1JMYiPkHsExqGRjig1K7TOZJXojBNJyyg9OPLY0ObCo
 M7UhmofTF5ztZcxUFRppQJv2QCKUyfrg11iuEfq1VCaB
X-Google-Smtp-Source: AGHT+IEfI3n/CBj9bCOvuCAdR77ymvg7U443RwwulXhb452bHI4Zbp6Coscre07W5CPB1WLRwbyW1A==
X-Received: by 2002:adf:ee82:0:b0:32d:a853:af6e with SMTP id
 b2-20020adfee82000000b0032da853af6emr6888wro.1.1698334816539; 
 Thu, 26 Oct 2023 08:40:16 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 f5-20020a056000128500b0032179c4a46dsm14407967wrx.100.2023.10.26.08.40.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Oct 2023 08:40:16 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Jagan Teki <jagan@amarulasolutions.com>, 
 Igor Prusov <ivprusov@sberdevices.ru>
Cc: prusovigor@gmail.com, kernel@sberdevices.ru, u-boot-amlogic@groups.io, 
 u-boot@lists.denx.de, sjg@chromium.org
In-Reply-To: <20231024225140.366571-1-ivprusov@sberdevices.ru>
References: <20231024225140.366571-1-ivprusov@sberdevices.ru>
Subject: Re: [PATCH v2 0/2] ARM: amlogic: Add A1 SPIFC support
Message-Id: <169833481579.2657867.140379270621827287.b4-ty@linaro.org>
Date: Thu, 26 Oct 2023 17:40:15 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
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

On Wed, 25 Oct 2023 01:51:38 +0300, Igor Prusov wrote:
> A1 family boards have new version of SPIFC controller, that is
> incompatible with meson_spifc driver. This series ports A1 SPIFC driver
> from Linux and enables it for ad401 board.
> 
> Changes in V2:
>  - more details in Kconfig help message
>  - removed unused field of struct amlogic_spifc_a1
>  - add missed check for NULL during probe
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic)

[1/2] spi: add support for Amlogic A1 SPI Flash Controller
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/bb6c1ebf99da01f2cdd2aaf751cc35723ed202e6
[2/2] ARM: amlogic: ad401: enable SPIFC
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/f22373511ca75bb098c3195e47f91d2b1ee8bc53

-- 
Neil

