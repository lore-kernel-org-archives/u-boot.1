Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE205C072A2
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 15:23:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D366587088;
	Wed, 15 Nov 2023 16:23:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="hNFIunKe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D510687209; Wed, 15 Nov 2023 16:23:14 +0100 (CET)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C02A86FEF
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 16:23:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-53e2308198eso10596960a12.1
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 07:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1700061791; x=1700666591;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hQT1f3Rl43XpqsoTDFDSAuKym5QiYMCS6vQN1mMcLcU=;
 b=hNFIunKeoNq2vXRfug2rVPD3ShHUMB/OWPafX3+K+GXHGxGADn285XE+xUkClTcqh0
 dgyCd3AFwn7hu0mhBjp+KGTBnmdOloYNWBWcjZd2etXIGfmIEaUhnFzAlNgdFV2x/tl/
 kSDWDVHS2Mmb3RnG4/H+G2bghcNFfWT2dVT2ol0oUU6GdRaW7BG30o2U2S89163wkdHu
 kY9kFPsbdTtuo72UvPMcHpYM3kLWy8AGYaSEaCK1MeWoh3KLEIg2p6HgC3MpO74iY638
 iR9LoWcUZoKmlsE9Ql7u0T14DOfihnd08QwJh3eisyLMaxX+sGOLPBIRlrprQcv4FgAd
 NVxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700061791; x=1700666591;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hQT1f3Rl43XpqsoTDFDSAuKym5QiYMCS6vQN1mMcLcU=;
 b=Bt9qR6JWAmZwJNS+pjNuSN4yNwbPrREEGhsYbA+ecnzGRppWHlInCv1KuKwFvxsRv1
 V8PXzxIfMohwhWdUkUyMXPO/mdbJ3bs83EONzYyg7xn//OHKquLPrOsY18m+JOnHfIlX
 kHuETnXdLZfo6mFrPnWx9pOROY9q2Hs+t4LtdVrMr+cv9jXu5XTd9rbZvh60yF7Wlqgr
 Usy9skMMqS9a77zxCD6vq+Wkn5XqE95t74QdL1PxXOthJKUtfKiuLRQtT8mZovYfRoqp
 +WNJSr7QqT+wFAM2AMAOHy/J/9OAP7RwH4HE56hFO7KJuhYsghueMtQAT91gW6/j/3NC
 hQAQ==
X-Gm-Message-State: AOJu0YwN/TMe/1aylXzsFQhRXjtVyrXw5o/Hh9xTATtO2FdUdbbGgWuv
 b7O53CV5v4wqOK0V45RiaywYqxpODe3cSNGqtaCp6eo2
X-Google-Smtp-Source: AGHT+IFsoxdRQR4//HO4RsGj5CKcj/jsgQqB7BV2w4j1yV8xiftCJLtaXeZkVL4HC3dy3lOnRL34sw==
X-Received: by 2002:a17:906:f8cd:b0:9bf:889e:32a4 with SMTP id
 lh13-20020a170906f8cd00b009bf889e32a4mr9671094ejb.54.1700061791508; 
 Wed, 15 Nov 2023 07:23:11 -0800 (PST)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com.
 [209.85.208.49]) by smtp.gmail.com with ESMTPSA id
 g9-20020a1709063b0900b009cc1e8ed7c5sm7206781ejf.133.2023.11.15.07.23.10
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Nov 2023 07:23:11 -0800 (PST)
Received: by mail-ed1-f49.google.com with SMTP id
 4fb4d7f45d1cf-53e3b8f906fso10575017a12.2
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 07:23:10 -0800 (PST)
X-Received: by 2002:aa7:d29a:0:b0:53e:34c5:fc14 with SMTP id
 w26-20020aa7d29a000000b0053e34c5fc14mr10070735edq.23.1700061790598; Wed, 15
 Nov 2023 07:23:10 -0800 (PST)
MIME-Version: 1.0
References: <CAHc5_t2hrverfcsEEahUcRkcjrnF3jr0oyds2yo0RBVMB7E01g@mail.gmail.com>
 <CAPnjgZ1-_ohZaVwMGtTDt4-W--2q0AM2KPtX9RLgAbMEhMRugw@mail.gmail.com>
 <CAHc5_t1icj6d82GH+FK8qGg3MvDkpwEicH964ULcN971_=aSKg@mail.gmail.com>
 <CAHc5_t2vLU9gHufMS_Fjv6j5+E8ksgCCLzKQ7NxTHzJsdcmsNQ@mail.gmail.com>
 <CAPnjgZ3VY_M+zd2na+N9WCxj-L2F+KKhLgykQ21FTA7GPVrKNQ@mail.gmail.com>
In-Reply-To: <CAPnjgZ3VY_M+zd2na+N9WCxj-L2F+KKhLgykQ21FTA7GPVrKNQ@mail.gmail.com>
From: Shantur Rathore <i@shantur.com>
Date: Wed, 15 Nov 2023 15:22:59 +0000
X-Gmail-Original-Message-ID: <CAHc5_t1fBzzpJaQed9kcKF92ProStsutmOBW-1jmi5vWFvLM8g@mail.gmail.com>
Message-ID: <CAHc5_t1fBzzpJaQed9kcKF92ProStsutmOBW-1jmi5vWFvLM8g@mail.gmail.com>
Subject: Re: bug - bootflow: grub efi crashes when bootflow selected explicitly
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>
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

Hi Simon,

>
> Is this the blue port on top of the USB-C connector?
>
Yes, that's correct.
For my drive I needed -
https://patchwork.ozlabs.org/project/uboot/patch/20231110141311.512334-1-i@shantur.com/

>
> Which version of Armbian / download link?
>
https://redirect.armbian.com/rockpro64/Bookworm_current

> Yes it is scanning first, before reading the efi app, etc.
>
> I have the same hardware so may be able to dig into this.

Sorry, I meant to ask if anything specific to USB.
I see it loads efi from the network or disk and calls bootefi with the
loaded address.
I don't know deep boot / efi stuff, just trying to compare how it's
loading efi differently than fatload in this case.

Kind regards,
Shantur
