Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D214C369DC
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 01:38:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B30D8059D;
	Fri,  2 May 2025 03:38:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PEHlFvOp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE3CD8070C; Fri,  2 May 2025 03:38:54 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A419803CC
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 03:38:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5edc07c777eso2189751a12.3
 for <u-boot@lists.denx.de>; Thu, 01 May 2025 18:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746149932; x=1746754732; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QF0c8j7gfEpvkoX5NeNkibNCiWRSPOkvPN6FFAp85lQ=;
 b=PEHlFvOpFtCoxFQBLBhpKcZOI8ZNcU1hUPSKMctapjASLoDPflf4aoqUcD5wc3UxKn
 LoOUCVgiFUJlEpiK83AAMQl5pPgwvbDtLaS4zNS6OiZkAw66FRMirMoN5janAE0R4XU9
 gVZKxFcVCCVm90cDT9yGLxOa9CgiaDrQXrNK4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746149932; x=1746754732;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QF0c8j7gfEpvkoX5NeNkibNCiWRSPOkvPN6FFAp85lQ=;
 b=I1e8xuqCFt0hlm/TjZAXGKBsRzSxe02HbHBmH78CztRbSC3Q+xxFx9uvDYUBQviel0
 kDlY83fwENujGQECRlB1i017O3+FaJFlNcccvB4/8RpnGVJXkmxgRctGW9RJjuYord4s
 KQIIcuSjlDrDTkLCZ9ZCL4KCPo1ym9CQnFGJuPOZuy9BORHtyKLjW5ratQY6eDGsmWpo
 yx1lVDzeA1/V25BR/PO/OG6vsb1QIJO2hzLAKn1ltKd4qIc8+gDFFzvCmwYQA7s3NIP5
 WscwrYFJDIv463JzwoF7w6ppPTAg/tUdF6D391foTkfDtZj2dQGekwxo/V2UCj1+cM+2
 1eFA==
X-Gm-Message-State: AOJu0YzzHtJ7RWBfsa1h0JWJ1t0ECw8BRCL9o64ynvrPUnxFlkNNJdDV
 Oc9MsMHoF5MxF1vAx5SNiEywJWKLAXFkW02cVYa6ClsrO59/LVUdjz1kfA8GZZz/NZb59mo5PSm
 a8Sa+CGmHc95P6bHSihKNTlzWHwd4b1d7Gqib
X-Gm-Gg: ASbGncuUiLfcRNzzp+6GvWTsDQiQIf3SyghlwT7FbQDhpBsj0YDvIZGC2AMielzUDyc
 HblXZrgKpApX9pd/5jHJSyxswb6FTilYtDO2kAowXv0q+YAvo4jsNZmzkHQcrz5C9fOyjRITkme
 fVwsobpbZYTM8k8JF6ZN0wPBT/O6AXHtSjpw==
X-Google-Smtp-Source: AGHT+IGAgqqKN0vgE51P2N5dAUuliMOL7QDT1KnaH1eC2pJRApV/WFfEu3Rx8vxndGmSd9Qp65/5QVea4jgJMiLfVxM=
X-Received: by 2002:a05:6402:5209:b0:5ee:486:9d4b with SMTP id
 4fb4d7f45d1cf-5fa78916644mr716202a12.34.1746149931857; Thu, 01 May 2025
 18:38:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAFLszTgi8FxpM=uCe5vZ4rWR81W9fnc77KxjrQ4-+yijXb5a=w@mail.gmail.com>
 <ZQ2PR01MB13077BEB7F27422FA9AF07A6E619A@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
In-Reply-To: <ZQ2PR01MB13077BEB7F27422FA9AF07A6E619A@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 1 May 2025 19:38:36 -0600
X-Gm-Features: ATxdqUE2_a-Rqdrz45UQfnBEJ3y-eUDVsgjTmDDzbkEYnxTNDvqXIz7JsDGVgaA
Message-ID: <CAFLszTg6sdcvB-qfbBJ23JORsxvjTgL9ozvcu_oKFkJrfL=9hQ@mail.gmail.com>
Subject: Re: Lab failure on JH7110 (StarFive VisionFive 2)
To: Hal Feng <hal.feng@starfivetech.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Minda Chen <minda.chen@starfivetech.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
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

Hi,

On Tue, 14 Jan 2025 at 23:56, Hal Feng <hal.feng@starfivetech.com> wrote:
>
> > On 09.01.25 20:37, Simon Glass wrote:
> > Hi,
> >
> > I am seeing a lab failure on this board with the test_dm_compat test[1]:
> >
> > =================================== FAILURES
> > ===================================
> > 559________________________________ test_dm_compat
> > ________________________________
> > 560test/py/tests/test_dm.py:20: in test_dm_compat
> > 561 assert not bad_drivers
> > 562E AssertionError: assert not {'starfive_gpio'}
> >
> > Would you have time to take a look, please? A patch to fix a similar problem
> > on another board is [2].
> >
> > Regards,
> > Simon
> >
> > [1] https://ci.u-boot.org/u-boot/u-boot/-/jobs/14394
> > [2]
> > https://patchwork.ozlabs.org/project/uboot/patch/20240611200156.224552
> > 5-19-sjg@chromium.org/
>
> I will take a look. Thanks.

I just wanted to check if you sent a patch and if so, if you have a
link to it please?

Regards,
SImon
