Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2225CC48297
	for <u-boot@archiver.kernel.org>; Tue,  6 Feb 2024 12:49:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 523BA87C77;
	Tue,  6 Feb 2024 13:49:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="hKKJfQqX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C42B87C78; Tue,  6 Feb 2024 13:49:14 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 164F1871A7
 for <u-boot@lists.denx.de>; Tue,  6 Feb 2024 13:49:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40fe2744e5cso3274115e9.1
 for <u-boot@lists.denx.de>; Tue, 06 Feb 2024 04:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1707223751; x=1707828551;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=626wuaiAikQ2JKp4zkrPeST6RdZd4CPB5jkPo5QOTkc=;
 b=hKKJfQqXR8kDkHe86t0rpg1REAVMpMhH+zAgK0LzwbRNuxDsTSPl/ZOrfCwBTPoquV
 Hfm1u8Q+J6F1Gqecbf/KcSC8CeFr3GW8wZmR4rQPYJQskZQO3PyqVhJyg6D8AYtRn5hG
 +l7mnv2rEwUHjwl/E7FV2ziqw03QURbDHMCIOTtZyhFtPbpTiT1Aj3iMg4N4OuP4eF7M
 IkT4rWe1WwThZpnPWLaXt+v5HWaZ+SSfSZbuLToUt6wYMf2A49XOx9T8ymGWaDFJv8cj
 X69lvBo73euo5tAwMAs9ddcBr+EVI3T+kZzu65VdnlrKXnzXOb9L7cffScQXT59Yon9E
 6wdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707223751; x=1707828551;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=626wuaiAikQ2JKp4zkrPeST6RdZd4CPB5jkPo5QOTkc=;
 b=SG+cgZ6Td4SxFxih+UgER8w4SGbZcq9frxZVZtFy0eCDWKk0aFGR9vDMfFT3QRrMgu
 KuYE50OXg4oeJDumb7KdFkJFtllzLe0N2egGcwySFA7KoCerjmXFf27fAC9RRM9bbsKx
 4Y1jEDT3nVP9WA7/Ppv3WfURmxrW3FHHMYk/nxkEwafgOoAi7op2h+vyFsBkzFsMwDCW
 Ipca2u5AAwYBCIIo3Y9xXtu8mpnZUizC7cfDwVdilpY+S9/SJ4hUIlE0XBDyDW9XeToJ
 sAkEcUuCUIBud2RdlK39Dm2Tn6HRBSCg+47ZA9mJTWVbx+0py+I3WRhbuoOT0BqjIvsd
 FrEQ==
X-Gm-Message-State: AOJu0YzPUS8cRHm4n68wqfCN/fxyd6tnvWwSIoj2hTnI9N1kwW2fKK2z
 lJj5XhnAJPs3zvFzdpgN16qqhIINysgR8yduErCw3u89rUQEoAugowKHv43IAY7cd3s52SrD7yb
 8
X-Google-Smtp-Source: AGHT+IFkrCqCS2DM64jk9wNNwppJmz4Xbi/pEmEw+N+WXQYfWS6+Xz4iJxBpJx6PShGMqxtlKon/EQ==
X-Received: by 2002:a05:600c:358d:b0:40f:d31a:66c8 with SMTP id
 p13-20020a05600c358d00b0040fd31a66c8mr7081348wmq.17.1707223751398; 
 Tue, 06 Feb 2024 04:49:11 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUjwmf2S4n7j6GAN8pyEAAOBerNrUeqfELlChOq+kI0mmwiu0i8OYm1pwOSbqM2vDl1eXuIf0VHsbwd27Q2shYpMlG9AqH5I4eUsWBevvxYVM8S67ZSGq3n6Q/IQm3OLO8=
Received: from [192.168.2.40] ([82.66.159.240])
 by smtp.gmail.com with ESMTPSA id
 o5-20020a05600c510500b0040fddaf9ff4sm1948911wms.40.2024.02.06.04.49.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Feb 2024 04:49:11 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: u-boot@lists.denx.de, Sean Anderson <sean.anderson@seco.com>
Cc: qianfanguijin@163.com, Dan Carpenter <dan.carpenter@linaro.org>
In-Reply-To: <20240201181851.221701-1-sean.anderson@seco.com>
References: <20240201181851.221701-1-sean.anderson@seco.com>
Subject: Re: [PATCH] lib: sparse: Fix error checking for write_sparse_chunk_raw
Message-Id: <170722375057.23531.13289930872832696553.b4-ty@baylibre.com>
Date: Tue, 06 Feb 2024 13:49:10 +0100
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

On Thu, 01 Feb 2024 13:18:51 -0500, Sean Anderson wrote:
> The return value of write_sparse_chunk_raw is unsigned, so the existing
> check has no effect. Use IS_ERR_VALUE to detect error instead, which is
> what write_sparse_chunk_raw does itself.
> 
> 

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu)

[1/1] lib: sparse: Fix error checking for write_sparse_chunk_raw
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/09709a57d8b11fa021f54b9346c1dee1dbe282fb

--
Mattijs
