Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A489CFC5E2
	for <u-boot@archiver.kernel.org>; Thu, 10 Oct 2024 17:10:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD804891D8;
	Thu, 10 Oct 2024 19:10:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jrortMEj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA9E489025; Thu, 10 Oct 2024 19:10:03 +0200 (CEST)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65F4C891B9
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 19:10:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-7afc592ca19so67390385a.1
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 10:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728580200; x=1729185000; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ft/LGc/+4lzPnCZ72cwXrzE2egBE2u0pkYsV14gYUyU=;
 b=jrortMEjcL2vcnXSvJsEOvn/Bkl1+e0V+EPnBS03iF6UdwK4ERd51ERptV9OyceWqD
 tQ+WUMpLRLm68nxuhDxhA66KBlKxISnz/1e0iUwJVyDT10V6exvEiT3zAmSWQQ4aU/DO
 6sXz2Q3oEhVN0B+ROWpqNX0ohBDCaSJR74Iko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728580200; x=1729185000;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ft/LGc/+4lzPnCZ72cwXrzE2egBE2u0pkYsV14gYUyU=;
 b=qGwGj8dtoOqwZiaxLLzMv/aKClAkO0SQUWvKV7VpnTGmllczP4/sE9KpquLKWpUjoY
 lSZFwpeRNfpBW8JYaSiMrkebpgmU+Ozk+Tu+h+8BrmwZ+jOXJkt8aX7nJOTSPyK4Tt2O
 41c8dMLmvnlyswD+F8zG3gtPhsYDCVdrYuHrvMHakO+pECZ9vncAufLlurXAriN/IUWo
 64qfSZ7YzWCVtH2J0br8gE9wLRPcZURGjxj/VAiWG/ZmKwne0We2Xf8EC9rD8q2oDCaN
 S8oma3S9i80eqTffjVIt1qlJJ4uheZ7UGopAJ7spSxHc//h1szAzt0EB3cjXTjo3DcWw
 SC8Q==
X-Gm-Message-State: AOJu0YzyblrrcSY/C2dAsGsR8AC6rBblLYRmWQnuDYJSLeaczHYfA1ix
 39yXimWwyC9fX3xmhuEeNOyGd1kc1HpX8Stl5A/pZ/Gk9dP+/XCtZwWf1+GSp1s=
X-Google-Smtp-Source: AGHT+IENgzXFOXjxoHbb6N+XDzBZhaVNOzWxVchItyNkqBEyrbfBPI+LhZ1oLDBfapTbSx2PCTpKJw==
X-Received: by 2002:a05:620a:29c4:b0:79f:104a:ba4e with SMTP id
 af79cd13be357-7b11a0c44b6mr4615285a.13.1728580200184; 
 Thu, 10 Oct 2024 10:10:00 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b114956069sm60577185a.74.2024.10.10.10.09.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Oct 2024 10:09:59 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, tkuw584924@gmail.com
Cc: jagan@amarulasolutions.com, vigneshr@ti.com, tudor.ambarus@linaro.org, 
 pratyush@kernel.org, Bacem.Daassi@infineon.com, 
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
In-Reply-To: <cover.1727399216.git.Takahiro.Kuwano@infineon.com>
References: <cover.1727399216.git.Takahiro.Kuwano@infineon.com>
Subject: Re: [2nd RESEND PATCH v2 0/3] mtd: spi-nor: Add support for
 S25FS-S family
Message-Id: <172858019890.3696879.4150514430258700595.b4-ty@konsulko.com>
Date: Thu, 10 Oct 2024 11:09:58 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Fri, 27 Sep 2024 10:11:16 +0900, tkuw584924@gmail.com wrote:

> From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
> 
> The S25FS064S, S25FS128S, and S25FS256S are the same family of SPI NOR
> Flash devices with S25FS512S.
> 
> Datasheets:
> https://www.infineon.com/dgdl/Infineon-S25FS064S_64_Mb_8_MB_FS-S_Flash_SPI_Multi-I_O_1-DataSheet-v10_00-EN.pdf?fileId=8ac78c8c7d0d8da4017d0ed526b25412
> https://www.infineon.com/dgdl/Infineon-S25FS128S_S25FS256S_1.8_V_Serial_Peripheral_Interface_with_Multi-I_O_MirrorBit(R)_Non-Volatile_Flash-DataSheet-v15_00-EN.pdf?fileId=8ac78c8c7d0d8da4017d0ed6b5ab5758
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


