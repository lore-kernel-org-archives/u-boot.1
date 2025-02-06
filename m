Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16465C02194
	for <u-boot@archiver.kernel.org>; Thu,  6 Feb 2025 13:07:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD9FD80AE3;
	Thu,  6 Feb 2025 14:07:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qp7yadx7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7EE880A37; Thu,  6 Feb 2025 13:33:26 +0100 (CET)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com
 [IPv6:2607:f8b0:4864:20::b30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5B6B807FB
 for <u-boot@lists.denx.de>; Thu,  6 Feb 2025 13:33:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-e3978c00a5aso594608276.1
 for <u-boot@lists.denx.de>; Thu, 06 Feb 2025 04:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738845203; x=1739450003; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6s5qvYmshg7/8KRWEjGyuv44nd0YjZY+gAeUzza8Fcc=;
 b=qp7yadx7ua0RmVooKLxSsxVVHUgBU9htbUeHZwQsTg0KjmeGcJ69himIipKsA/qgwA
 iTU/djN4UAizFVCpegAC196XGhPxmLSWJaUUV8eeuIjpojSkqSTEM00LZc6yLvQC1yPx
 Iy6BqzltY+E2xVlWdFAx1oqjtT9Y0i6UOs9briPGpsTxv4ok+HYmwgKHYQ3pkmsxEFNa
 eACicw04dY4orEF80GX3RgQWDYxCH+uBbFY3lhLbtm2RYIQTfg08XsUS5zFO609cMxrz
 Qm+vul4Z9Nut1c4Yu7zjtc/PIxT0aUlN5YfklHGoiyaTW5QT68dEftAqioOh8NX2ytM2
 oofw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738845203; x=1739450003;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6s5qvYmshg7/8KRWEjGyuv44nd0YjZY+gAeUzza8Fcc=;
 b=eZWZlfAsPJUVQbvPwIajkWKIUYZ0KAIFYh0hOyDEA1FMJhduZk3rWoKlTGesLypu7p
 vIuf50z//JRmmpAWAEMwLf71ZCgkbruDO4VTxGjwwWJhdjes+2N/QRopVpgVB8hXS7mx
 gBvB09cSR/57pfMpe1AEsbJWfMSaXKoBFIZzijXCnYGoZq1ZrxqrAzNMueQGtbytQ5qa
 YABiDZeWR5yF839Olv7PL1ZwGuFdydtNJIWPtvJT18ohj1B3yE4sfHiXRt7hANeVP1JT
 4kH5Pu3MYsicxnXWZVQWoY+hYCKoZPyXC6CA6/FlMcVTHnszoNaW8CrNwr2KuigNYw4/
 8ECw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6ZC1RdOJHt0eMrXiN2CioMN8YI1o2nuW4Mgg/Mru/PhLIF5h4OhXLvVQuLrZu1bOstB8M0RI=@lists.denx.de
X-Gm-Message-State: AOJu0YyBURk6B72mTPXaD0LwtzBaHTq43oB6yrXo7dHnee4CYUP8whYN
 Sg1nCvOoXNfhQqSWJ1SH69FWXxJdGuADfLeecTodat88Jqz6TXM2gvGKICAtUGfWEKSDkapnGBc
 21WLt8WHibEpzrAIZDN0JlhZBUDka0AfLvxuMXw==
X-Gm-Gg: ASbGncufi5Tx4yAKoNUqWVTu3dEOIg14CZBt0Qp0XUJPIYw0vWuF5UKI+myiw/Jp4MG
 l6J5kimh5II8SbzSdH2ZEnljr5lvxeH+8qNxGhl642fg50Hc0bzVdsl0wWbiXNYdz4URLToD4RQ
 ==
X-Google-Smtp-Source: AGHT+IEymd4DU29h/I3om9b+73BFbhTM8OM1UcOR+u2/k3kUibOK8an+f+jw1cSqV5rfOpDHUVDuv508AASp5VBddOk=
X-Received: by 2002:a05:6902:2089:b0:e5b:2352:7875 with SMTP id
 3f1490d57ef6-e5b259cf0abmr5304131276.8.1738845203573; Thu, 06 Feb 2025
 04:33:23 -0800 (PST)
MIME-Version: 1.0
References: <20250205071714.635518-1-ilias.apalodimas@linaro.org>
 <20250205071714.635518-3-ilias.apalodimas@linaro.org>
 <CAFLszTg3rKQHGMawKTE1RGdqbdFnkkXW26Y99WpNRDOusp6yxg@mail.gmail.com>
In-Reply-To: <CAFLszTg3rKQHGMawKTE1RGdqbdFnkkXW26Y99WpNRDOusp6yxg@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 6 Feb 2025 14:32:47 +0200
X-Gm-Features: AWEUYZm4F1prSTg_yjZLd6G9TaN-a7iEveMopKvzqL9VBWAD-PmBWMUw5_bOdC0
Message-ID: <CAC_iWjKDsYpgPekATsprDtf4SSj0qteU-q1VGNF6f463h8k8dA@mail.gmail.com>
Subject: Re: [PATCH v1 2/6] doc: update meminfo with arch specific information
To: Simon Glass <sjg@chromium.org>
Cc: xypron.glpk@gmx.de, trini@konsulko.com, 
 Alexey Brodkin <alexey.brodkin@synopsys.com>, 
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 Huan Wang <alison.wang@nxp.com>, Angelo Dureghello <angelo@kernel-space.org>, 
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, 
 Marek Vasut <marex@denx.de>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Max Filippov <jcmvbkbc@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Sam Edwards <CFSworks@gmail.com>, 
 Andre Przywara <andre.przywara@arm.com>, Peter Hoyes <Peter.Hoyes@arm.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, Sam Day <me@samcday.com>, 
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Stefan Roese <sr@denx.de>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Alex Shumsky <alexthreed@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>, 
 Joshua Watt <jpewhacker@gmail.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Michal Simek <michal.simek@amd.com>, Jonas Jelonek <jelonek.jonas@gmail.com>, 
 uboot-snps-arc@synopsys.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 06 Feb 2025 14:07:31 +0100
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

Hi Simon

On Thu, 6 Feb 2025 at 14:31, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Ilias,
>
> On Wed, 5 Feb 2025 at 00:17, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Since we added support in meminfo to dump live page tables, describe
> > the only working architecture for now (aarch64) and add links to public
> > documentation for further reading.
> >
> > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > ---
> >  doc/usage/cmd/meminfo.rst | 71 +++++++++++++++++++++++++++++----------
> >  1 file changed, 53 insertions(+), 18 deletions(-)
>
> This is useless information for most people. I would rather have it
> behind a flag.
>

Ok I can move the call a few lines below CONFIG_CMD_MEMINFO_MAP

Thanks
/Ilias
> Regards,
> Simon
