Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9AD6C71136
	for <u-boot@archiver.kernel.org>; Tue, 17 Jun 2025 08:06:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4515281E18;
	Tue, 17 Jun 2025 10:06:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="ia4vwCDX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB96982B20; Tue, 17 Jun 2025 10:06:55 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E21118070C
 for <u-boot@lists.denx.de>; Tue, 17 Jun 2025 10:06:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fmartine@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750147612;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=was8181DE9xfmXLyVBd7Iq1haWRqlHTrdJ655ADXygE=;
 b=ia4vwCDXyUaRGjQJ+5rpSlxFjKhuEe8Jlq93AjQxf33CxT0tmzznR27wFibrk0ZsRVEpIe
 ws4NakU4onTSCHsJZ6NiNCnx7xJLbhLDG6LNoLT++JllrKshL+cClPt+2IZ4SmE7MzCxQ7
 P5TCWD70jfQgVYh7q6ReRvm9XY0+Lag=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-CQ_YaR4wMwCQEcgnQNiBtg-1; Tue, 17 Jun 2025 04:06:49 -0400
X-MC-Unique: CQ_YaR4wMwCQEcgnQNiBtg-1
X-Mimecast-MFC-AGG-ID: CQ_YaR4wMwCQEcgnQNiBtg_1750147608
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a5780e8137so1333645f8f.1
 for <u-boot@lists.denx.de>; Tue, 17 Jun 2025 01:06:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750147608; x=1750752408;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=was8181DE9xfmXLyVBd7Iq1haWRqlHTrdJ655ADXygE=;
 b=SDq3j4aD+7E8tapm+7ebub1ExCU9ELSKZWAIafVmJ4PteaUGqCSG5OsnTOmGuKokGS
 XCc91Y5MCrGIhA2kPrPiND9cwRTCz9dZutdYKruQpggPbIOzGJaGtq9QnLI1oNFhs1Aj
 kRh5tKg/yMGEeLZYHY3AQStk10ErBpagqBUmMIpgf2VVoefcgKWWifWWjQJXX8QgdnIj
 VNbkpE+W9FdniYEDBh9D57BgpnRT84m7RCTRzNg6sZY2rapUpoKkx/d+xYrf/QL18+Nd
 74nb1locGF014N2/ngkA0ILYmbV+0U7ecZ+YbHp6ZjS2G4SX7UvDD+Uzx6ge+X0pGOhm
 Yc/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkX2gSIAfjwo3dxTEVjRSE8fzC7TL5rMEIJhW2boq9XRtOuF5TdYISqgt7KcRmi1Ib233N9qY=@lists.denx.de
X-Gm-Message-State: AOJu0Yxo5kw2p2yHvpAh+YPlAm5AmSP/EKwLs+LGAaaQILtL+2qrbkW9
 DyXaVuTGUySutGAh/pR5t2kLkcFHq3d5qpmrqqwLBNoJbNvkPp2h+PZtcs555XXyvqBrUz5eShr
 dt+uSoXgr9qTjdKMwefGzmvUqfbReEtxhg65/xxRDfA4nBIm4xWy54oU=
X-Gm-Gg: ASbGncsE6f6pxEjpTHE7NBryz7SsxNiLnjD6SFCB6zaz3mTptvzwdb7/bMIkBrLvyLc
 DnfykxANkbY9F4Rqod75sVxlLU8mwE4wDGgXKCdFyoRBGeIKCDpBSOCy7z5PxU+s4WlQppfb362
 8Bg/wbNIGJCIxM0LP8encGk6DUzG7jgPoX7+gmX2+KhhlM4PTUm6bVLuTyVeGVcD1Ksx/w8HPpT
 cJyAmOxUWhNqjOdSRFeSndR47xxgJL4UjuSV40IBfGz5u6jBbH1Zjc8rOatAnGbch+rd49A9xNq
 D7d90EGpnyrTmIPTvjRAGZLrzT2WTncMJV+UrCRbXWiF1Bj/zB8p0MnrckUvfPOF1TvEodK8Z6C
 CdFdH
X-Received: by 2002:a05:6000:652:b0:3a5:8601:613b with SMTP id
 ffacd0b85a97d-3a586016217mr2413805f8f.20.1750147607829; 
 Tue, 17 Jun 2025 01:06:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXcwHyQBuyYSvrAVze5edcLv1MU1VdMIiWqHUsPVR5UpRclot2bM30YrYWr91B5brDEVcR3g==
X-Received: by 2002:a05:6000:652:b0:3a5:8601:613b with SMTP id
 ffacd0b85a97d-3a586016217mr2413769f8f.20.1750147607490; 
 Tue, 17 Jun 2025 01:06:47 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a568a53f79sm13042933f8f.4.2025.06.17.01.06.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Jun 2025 01:06:47 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Jerome Forissier
 <jerome.forissier@linaro.org>, Dan Carpenter <dan.carpenter@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Andrew Goodbody
 <andrew.goodbody@linaro.org>, Yu-Chien Peter Lin <peter.lin@sifive.com>,
 u-boot@lists.denx.de, Heinrich Schuchardt
 <heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH v2 2/2] sandbox: enable CONFIG_CMD_BOOTEFI_SELFTEST by
 default
In-Reply-To: <20250617061945.9266-3-heinrich.schuchardt@canonical.com>
References: <20250617061945.9266-1-heinrich.schuchardt@canonical.com>
 <20250617061945.9266-3-heinrich.schuchardt@canonical.com>
Date: Tue, 17 Jun 2025 10:06:46 +0200
Message-ID: <87ikkudc6h.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ahbduEt_oyDEFPmlOWm7utZYFY80xBwyA53bLUa6Hes_1750147608
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
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

Heinrich Schuchardt <heinrich.schuchardt@canonical.com> writes:

> The sandbox is used for a lot of generic development, we should run the
> UEFI tests there, too.
>
> Reported-by: Javier Martinez Canillas <javierm@redhat.com>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

