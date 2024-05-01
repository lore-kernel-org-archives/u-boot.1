Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04F0FC4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 07:31:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37C7788AE9;
	Wed,  1 May 2024 09:31:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b="MbyWtJMa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3887E88ADB; Wed,  1 May 2024 09:31:36 +0200 (CEST)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB62D88AF2
 for <U-Boot@lists.denx.de>; Wed,  1 May 2024 09:31:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=greg.malysa@timesys.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-61bec16c6e3so16122287b3.3
 for <U-Boot@lists.denx.de>; Wed, 01 May 2024 00:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=timesys-com.20230601.gappssmtp.com; s=20230601; t=1714548692; x=1715153492;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uIqaiN2727rOpox1SG2y3BXcm6limk6DsZmHMrf2fc4=;
 b=MbyWtJMaBP7dFHe76zlFj/ccfO+aXi7RSy48rSjr5XteCtb1o7CcImvJmz1XFCLdav
 b3d5uCgHHhaJ0VfnDfhvz39SKdmLwD4qgYiRVaImA6Y7068l0C+B7nQG7kPNAhoUSkz+
 YXWZtZgFBMmBbFzoi4l/+euDSU+GeTSfxNK4JA7RLMVjo/00pTPHwysgoQDTljIPMoPv
 WEpUu2sp3G/s/gf2p0iPr3e6uTdFP1BLJKDGiQtfRAoV4r3xVtF+gbgNFnsSKASasCsd
 zxcl+4tjKRKNtaFgR9pzO4R80EKeGBTHJE4FHIgqBlUuluuwNAWffU6rtFZFtlreW52K
 CUMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714548692; x=1715153492;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uIqaiN2727rOpox1SG2y3BXcm6limk6DsZmHMrf2fc4=;
 b=wVnidNtGmwMzPDbNKMEqI4kDXdtbG5vJIdRINnjX83V55MJu8tWZSs7bWAt2A/93Ne
 /KqfZIhVCmgpZtVNbs9AbywKZlnIZR4Vmu8HSftH/YEwGxf7LMgz2T8Jtdtj894areLA
 Oedn+j+COWoH2dF24U2uRK+Unf5X8FWcDjDyP/g35pzADO0hwfIUxpHkdqAW3XMZcyCA
 hxV70XENUMYSwYX76sbZi20Eq8zeqFRHl7+AyWOBnuX9eUuHWGH28Hy9r6PTvKAefhSD
 QT46GWbecBCOGjYS30oI0ZqOE8oDf7Bq5NX3KLizeKd/LiqXC8L7MwVKnx5EMPTX7Oga
 K7AA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjfrRdo4uUwovQWGiqBrvAxEcylutTWJbIlbORIhmMl6Ddtqa6N9182hTq6dcLiggprLoqb/Fb/mtFrLnxrzilzw3fXw==
X-Gm-Message-State: AOJu0Yx50D51Q9/Fv/RhJKM0ietbCzHJJ2JZGTjmK2tL2bnOuvEh0bsr
 DVpFbmecaZMScz+J9f9trnxGn099jXZRrmC1wFzU+y35fUAofdcaI8h4zWBK+dzpqVGDSN+xud+
 s6IgsvvUC4CGF7k7PjV5vpGh5AX+Qf+UDCt5t
X-Google-Smtp-Source: AGHT+IEsmvEkORy8HvWhVu282R/bm6ZrhIp4kPtNaowl60W8oHv+FgE49+pW/IaBRmUHL3zPElehuuNsEl3fgDN97os=
X-Received: by 2002:a05:690c:3:b0:618:80d7:1604 with SMTP id
 bc3-20020a05690c000300b0061880d71604mr1886253ywb.27.1714548692407; Wed, 01
 May 2024 00:31:32 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20240426103830epcas1p3720a09dd50c8ef3d16de0a6ff2ff514b@epcas1p3.samsung.com>
 <e6c74bd0-de66-42ef-a6af-0d5c058b12a0@samsung.com>
 <20240426155154.GK1054907@bill-the-cat>
 <33db14f4-f3f0-4e5f-a256-2ce9b5c505fd@ti.com>
 <20240430074221.GA10438@francesco-nb>
In-Reply-To: <20240430074221.GA10438@francesco-nb>
From: Greg Malysa <greg.malysa@timesys.com>
Date: Wed, 1 May 2024 03:30:57 -0400
Message-ID: <CAAjXUapsr9GjHt3HU+XvW0-Y0SCJ82eLbBOekT-Y6L3_cer7Jg@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull u-boot-mmc master
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Judith Mendez <jm@ti.com>, Jae hoon Chung <jh80.chung@gmail.com>, 
 Ian Roberts <ian.roberts@timesys.com>, Tom Rini <trini@konsulko.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>,
 U-Boot Mailing List <U-Boot@lists.denx.de>, 
 maximilian.brune@9elements.com, curtis.machida@intel.com, 
 Jonas Karlman <jonas@kwiboo.se>,
 "ian.roberts@timesys.com Peng Fan" <peng.fan@nxp.com>, sheng.tan@9elements.com
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

I am also looking into it since it's our change that is causing the
issue. The functions modified don't return status codes so that must
mean that it is causing the transaction to be configured incorrectly.
However I don't have hardware to test these platforms locally, but I
might be able to get a coworker who has an am62 platform to help me
test (not sure which one though).

Some things I would like to look at first:
1) host->ops->adma_write_desc is expected to be NULL on this platform.
If it weren't it'd probably crash instead but it seems like a decent
starting point. I believe this corresponds to j721e_4bit_sdhci_ops in
this case?
2) Could we compare the contents of the descriptors that are written
in sdhci_adma_write_desc between working and broken builds?
3) sdhci_adma_init is only called if the descriptor table is null; is
there any chance it has a random value instead of NULL to start off,
so it isn't called and adma_addr is not populated correctly?

Thanks,
Greg

--
Greg Malysa
Timesys Corporation
