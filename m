Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1176FE7717F
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 19:50:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77DB18034E;
	Tue, 17 Dec 2024 20:48:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dMX7wbM9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF39B803C6; Tue, 17 Dec 2024 20:48:40 +0100 (CET)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2CF780391
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 20:48:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-725f3594965so4535532b3a.3
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 11:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734464917; x=1735069717; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6Mxe7tlycV3KOz5XISPmVbDJ4uV80r8oPdUT5kUCXYo=;
 b=dMX7wbM9oFRVYucpIlPCEmEOhr3MvBXJgsURA+HLVaT94nheWc6ZTlwwDW+/ZYlhUa
 JzNRUm36Yh3r3guRRdwjIe9kdx3H9nKGDMXL8qNLN2hWsZOZH+WhcWieZBrJ5JjKtTzy
 BogbiNXvfyTS1BXtq52EE6qxs5aKvOSG2i4Rg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734464917; x=1735069717;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6Mxe7tlycV3KOz5XISPmVbDJ4uV80r8oPdUT5kUCXYo=;
 b=ZYe0TK44kEyfzdFKVUL4PTmYMfKKCNdb90noHcYay0PAxWafQeLrpomtJ+UAdPPrOO
 dJjlmEHhyZp+91QP4dDLM5BtbR1w1C/tF3F0Erf/ezzuwHb7buMaQYVY9trvEQ7Lgij6
 URb4vEYehHvnX+kF3y5mK1zBJQVXW4c7prKJd+hJsLHQXs51B7LsxJib/AJOCt9tm629
 3bYq7BymgjfBMdVC971/9eaTphm1uJ7aksdgwaYt76auT3yl+4tP/8anY0mMouVWSNFA
 4tQKW7zhvdXLUlLi/n757oioLN3Mj/7ja2equh46x6+Yxrun43+NnDYsE1ztRvlNgr9b
 o4eQ==
X-Gm-Message-State: AOJu0YxygVvZGakRHYN61RFGYknPNFCThwxod5BxTDxgXq/q1sncjB3r
 Be8d+X5AzaMTBSofZO1DYgVU9GBu9FdTCW9hhCPgUiYkHjcoSPZ/a43Jco/qkXADNyIIrehXFOb
 QZkiV85iX6O9PeggYxdevGjnjihJuQr7y0uIU
X-Gm-Gg: ASbGncsNWQfzhPvpciWFrum4KIEA8V6HDxUzWdZU3owCfgU7mxm10tEMxRwR6BJCgKd
 UVMSfGxUHR7WdoK28v8dH93+wOJTofBcR5dQPkkk=
X-Google-Smtp-Source: AGHT+IE8bnJxoMUgisJk5/qVAC4hR4ncEOTVa4kLhDcj/B9iqXBXyvkt3oz0YZS274eFbN344t6m0gbd/NwT09BmzPE=
X-Received: by 2002:a05:6a00:4391:b0:724:5815:62c1 with SMTP id
 d2e1a72fcca58-72a8d2bca40mr278153b3a.19.1734464917217; Tue, 17 Dec 2024
 11:48:37 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 17 Dec 2024 11:48:28 -0800
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAFLszTj2-Bse1wgzBX__5wH0FOdgC=N11faSHBKg8-T5+G2-ZQ@mail.gmail.com>
References: <CAFLszTj2-Bse1wgzBX__5wH0FOdgC=N11faSHBKg8-T5+G2-ZQ@mail.gmail.com>
 <20241211135418.563803-1-sjg@chromium.org>
 <20241211135418.563803-2-sjg@chromium.org>
 <CAC_iWjLhpi5Wmd8569vgRP3O=CSoQUgLAaOYg7LyY_iOHG+U5A@mail.gmail.com>
Date: Tue, 17 Dec 2024 11:48:28 -0800
X-Google-Sender-Auth: G5Znrn-kSvcMOgBBRJ6gp0Y8EJ4
Message-ID: <CAFLszThc3dj57cLBDtO-wrKeCJpzfoaV=bkcZx0bDczWcsfPSg@mail.gmail.com>
Subject: Re: [PATCH v5 01/23] efi: Define fields in struct efi_mem_desc
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Matthew Garrett <mgarrett@aurora.tech>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

Hi Ilias,

On Wed, 11 Dec 2024 at 07:45, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Simon,
>
> [...]
>
> >         u32 reserved;
Applied to sjg/master, thanks!
