Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8729BC46CD4
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 06:23:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD36487786;
	Tue, 26 Dec 2023 07:23:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YclijP+a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B903187861; Tue, 26 Dec 2023 07:23:54 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F7B48773F
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 07:23:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a2340c803c6so471617866b.0
 for <u-boot@lists.denx.de>; Mon, 25 Dec 2023 22:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703571832; x=1704176632; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=F5T7UcbBCAVfyah2dG+Srd+zC2aHhxT0k47oBlBhkwI=;
 b=YclijP+aGqKEl9x/uHKXSz81+o4BAMHgQcOvecsg2aNCv8tsEwrpppeA51lBqI3f87
 d7DWt1GBuSNBh4tG0D0vqWRIPGwu6nCFo5xUU06lFdyaMHiwWD61znKe4OOsIE3mdOX4
 zwAAnBh7wNWv4XjoCMjclUtPWUTbCFPzFVOUWiD/JarffYcZocNIqftHgtg7RGxtn0M6
 6n2D/l4YhvWIQayXX5ACgtnfZBikdQyBk29qTQmSJBFc0QQf6Qp6+NFnlQyoUO6/rWkT
 zI8G4mn5nnwhKeFYUIbKUbwe62nrm/wRd0BcW2W27uRSDco9Q/J3TxS6LStvzMEDz7qi
 wMuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703571832; x=1704176632;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=F5T7UcbBCAVfyah2dG+Srd+zC2aHhxT0k47oBlBhkwI=;
 b=hUIWHxLVc2b+3YW/yE6Nil/7fMCRFh4wb/JFmsDTBBWt6noq666Cldhgq8ehiBO50v
 rx7jCgGvuah/KvzmKak27p4Qk08fk/eVIE4cSumqMaOAJhaOp4g8aotRm+MHseF+V5vh
 4jYuDjtg3a4kJC61LVLVIlEoIuyMwMUswsOiFP0sr3pyzOS9NXAdOtEOvj/7MdkCUZl0
 zGzdPA3si7LyJPZF0ODnEZItAGCI822A6LXBsIorcrb1StSv3JXHKWdNr/97OYLHi0nY
 jgkWronVuQHLEHtL3vyxvC8qno+CMCWvS8NBrO8C1/pGVC7dl4w0+4FZIc/g3fUkmmZX
 +GOw==
X-Gm-Message-State: AOJu0YynqUSUpo+aH7AYMK1oE43molwLjJqiffzepY1NnstYnGi1goeF
 43Ppoeo++x/lPMP62R1MyVlxKWs9sP9g0PohHgVEvdfkz5Mahw==
X-Google-Smtp-Source: AGHT+IE3ihNIPpkjNgNsRoQQPZuDfrYnOvHOieSSCaCyuy55/W4kDMMrO2HByf4cJTfVNXYWJfNeEwmjvVH2ceKKbz4=
X-Received: by 2002:a17:906:7497:b0:a26:b45d:7f0a with SMTP id
 e23-20020a170906749700b00a26b45d7f0amr2976814ejl.2.1703571831942; Mon, 25 Dec
 2023 22:23:51 -0800 (PST)
MIME-Version: 1.0
References: <20231220084133.435240-1-masahisa.kojima@linaro.org>
 <b8724e86-0ed0-4786-90d3-78e5923bc3d4@gmx.de>
In-Reply-To: <b8724e86-0ed0-4786-90d3-78e5923bc3d4@gmx.de>
From: Masahisa Kojima <masahisa.kojima@linaro.org>
Date: Tue, 26 Dec 2023 15:23:40 +0900
Message-ID: <CADQ0-X8=s1_t3hb0VheQTfCw1LJR1_D3nXAwOgiQsGZWemWe5A@mail.gmail.com>
Subject: Re: [PATCH 0/2] fix auto-generated boot options
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
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

On Tue, 26 Dec 2023 at 02:14, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 12/20/23 09:41, Masahisa Kojima wrote:
> > This series aims to get aligned to the EDK II reference
> > implementation for auto-generated boot options, and tries
> > to address the following issue.
> > https://source.denx.de/u-boot/custodians/u-boot-efi/-/issues/13
> >
> > This series is based on the efi-next-20231217 tag.
> >
> > Masahisa Kojima (2):
> >    efi_loader: auto-generate boot option for each blkio device
> >    efi_loader: auto-generate removable media boot option first
> >
> >   lib/efi_loader/efi_bootmgr.c | 123 +++++++++++++++++++++++++++--------
> >   1 file changed, 96 insertions(+), 27 deletions(-)
> >
>
> Hello Masahisa,
>
> please, have a look at the test failures in
> https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/19089

I fixed the error, v2 will be sent shortly.

Thanks,
Masahis Kojima

>
> Best regards
>
> Heinrich
