Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5068AC4706C
	for <u-boot@archiver.kernel.org>; Tue, 16 Jan 2024 08:07:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B65348786B;
	Tue, 16 Jan 2024 09:07:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MBmzSDOB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58D1F87876; Tue, 16 Jan 2024 09:07:56 +0100 (CET)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21B1D87852
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 09:07:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-33761e291c1so5391331f8f.0
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 00:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1705392473; x=1705997273;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OizmD4lOXARKMcibmPfTjq1f5D4H4Ed29ydoWdEhBVg=;
 b=MBmzSDOBQTmeOoij+OBhI9rBO9sJ7u7oXAi2KL0FzPx580HDZtKCtWTp+7PSZxkanm
 KuQ4jkDMjcBPZd1DV82g4T3BoJs0c9sG9uQEiiffjysYP+a870BcZChaVjnbIt/bFg75
 GwL1NwU2BAwgr2wiBH4Acb51AWwLg0HHYPniNkBpPmoOlSghLhEJD0g8GH6HL7IcaL6M
 manb0vcq9wf5UiuJnI3HSVlL9LHX4VtPvprKw4+rgCjs/MVtLBsdFzNidyvikAmu9HsH
 L1YWpFuILifwh0zIbp6fLXOAfM1SkB4J/VdW9ukKtCP4cFp69zczSDdB5eBVjzZPr3bR
 QsJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705392473; x=1705997273;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OizmD4lOXARKMcibmPfTjq1f5D4H4Ed29ydoWdEhBVg=;
 b=awGPK707YAyBm0G+BAoyvWnZmXGoqqZHwvpW3XrVaDpStpdcwumMbgnZznZ0R3Krsq
 Svg3O6Hup/Pj2qhIqd2g8W46VL8AQhk3JGDgFo6/wsWLd7BXnaBVLHhaFciqqYiIuwxR
 laDTApwu5/r3M3SAQWAnuZUrdxOkgPQj/Q6cm+MTmipGY1XHPBpu6R3BWCB6O3VW0qwM
 Y8heRuF/vzorrI5gMZKMdq3kXOMD43NdUNcIVtd67jlzFepPUGHwyArK/oj4k5v87zxk
 0xN0TIEtu4FgEk6G7W17WnV4r8mDDdZ3DUC5tA1JFdk2VUoC+GIBsq+6DCCzcYr9ZPF7
 TZ6g==
X-Gm-Message-State: AOJu0YyZJtB9dUwO/Dl1dcFATD9QNiBxri2YR/B/E78TOfHNMgyFjEQz
 02sr2MEbho8AimoM40ZvrSMESbTd+z1W/g==
X-Google-Smtp-Source: AGHT+IEBK5ZguNiIJDRtscr6F1qkCLOc/XknhYnu+I17kV4B1CqIMH0H7hOf6rRt5lgtw1jW3O8Dow==
X-Received: by 2002:a05:600c:3d91:b0:40e:862a:8ac2 with SMTP id
 bi17-20020a05600c3d9100b0040e862a8ac2mr79610wmb.124.1705392473198; 
 Tue, 16 Jan 2024 00:07:53 -0800 (PST)
Received: from [192.168.2.36] ([82.66.159.240])
 by smtp.gmail.com with ESMTPSA id
 hn33-20020a05600ca3a100b0040e621feca9sm16866019wmb.17.2024.01.16.00.07.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jan 2024 00:07:52 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20240112-maintainers-ab-v1-0-f2a538eab18a@baylibre.com>
References: <20240112-maintainers-ab-v1-0-f2a538eab18a@baylibre.com>
Subject: Re: [PATCH 0/2] MAINTAINERS: add Mattijs for Android AB / AVB
Message-Id: <170539247262.184714.869845925205582585.b4-ty@baylibre.com>
Date: Tue, 16 Jan 2024 09:07:52 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2
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

On Fri, 12 Jan 2024 09:40:43 +0100, Mattijs Korpershoek wrote:
> Igor has not been active for quite some time on lore:
> https://lore.kernel.org/all/?q=igor.opaniuk@gmail.com
> 
> It seems that Android AB and AVB could use some help maintaining.
> 
> I'm interested in helping with maintaining the android_ab
> command. I'm a long time android/aosp developer and my daily job is
> still doing android work.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu)

[1/2] MAINTAINERS: add Mattijs for Android AB
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/dbc949f74687597a08be3a1186489e60172f8e43
[2/2] MAINTAINERS: add Mattijs for Android AVB
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/05fac1a6187b7e97e75bbd40738686ae12948bf8

--
Mattijs
