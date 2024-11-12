Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45125D42B91
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 15:10:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C07DE88B9E;
	Tue, 12 Nov 2024 16:10:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ebKbH5qk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D8AF88B9F; Tue, 12 Nov 2024 16:10:06 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83C2788965
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 16:10:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a9ef275b980so759592666b.0
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 07:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731424203; x=1732029003; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZOY0lph07beS5MWaoMURahw5d3ssUbJYusqezl2WLbo=;
 b=ebKbH5qkdEQC1COPAIcgFwR/Mmz71vKfMQEj68Srd+TtwdkKnLVhncOjjfBZ/RK17F
 bzMQkc4Vbs5RD1gWz2P3K/7u/WW5L8lND8aeK1CYhgdvJbloHy7sGzDDxL917ZjqoauN
 3p8+3oEfDFd9E/gITl48b1iEav2LQuBxihxUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731424203; x=1732029003;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZOY0lph07beS5MWaoMURahw5d3ssUbJYusqezl2WLbo=;
 b=Zuh7FckQzGhbF+fXMIVtLpqshr0MB+Joew4TA3F09XuX7U6meiCp9JqullosFHfegF
 txYNXLQScuchRfcRsGbDM+ZQzlBw2NORcUtkbD4lgI+9AZGt0FFAJqDMROiZoJx3dGAQ
 qVIRmrIovcK7h8CJ0eJ6JDTKTXIXT+UcNeZTSbFC66TWFf1n+2AmYiCFZrQryVwT4N4+
 5kn32xOy8abHOgGzmPVUaNGfS0bTDzNuc6a+Z++kwM1wi87MEGHsTAetcT66DFe8/PDm
 X5cQsXHDFXdFxy0oES8DphJd5SnfoaXDWM9M6+QW01mGqmW0mxso4+ShFs9iTEjgPEc4
 7qYg==
X-Gm-Message-State: AOJu0Yz0rpkVFHnSv6CLPdaklv6PP2Ehu+ki4vrRaPaNhGmyaQjC1D7d
 eZzBFbHutBN0swuXoFr5UBPQMbkLQ3WTN+cCqTaYqCuTHT6CGy2d4vam4LhFieTNJ+gabqhSlr6
 Fw22X/rmnzm99J8A2/uoPLDEtdRYJv8/uET92
X-Google-Smtp-Source: AGHT+IGWQRyPEmq8cBVGKLrgaeO2r2/AXoenVGjgW6CFfSQbF16+//y4UUUb3tKVWdqwdKwInq1xwveSp9wFme5sk6Y=
X-Received: by 2002:a17:907:9815:b0:a9e:e1be:159 with SMTP id
 a640c23a62f3a-a9eeff3785emr1550122966b.26.1731424202823; Tue, 12 Nov 2024
 07:10:02 -0800 (PST)
MIME-Version: 1.0
References: <20241112141105.640189-1-sjg@chromium.org>
 <20241112141105.640189-2-sjg@chromium.org>
 <c18f70de-9fc4-4a35-be17-bd3144664c1b@gmx.de>
In-Reply-To: <c18f70de-9fc4-4a35-be17-bd3144664c1b@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 12 Nov 2024 08:09:50 -0700
Message-ID: <CAFLszTjvH0CA+fwVhb-UGM-Kww6SVC3YDAQJL5ZW0gsYCD0QuA@mail.gmail.com>
Subject: Re: [PATCH v3 1/9] sandbox: efi_loader: Correct use of addresses as
 pointers
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
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

Hi Heinrich,

On Tue, 12 Nov 2024 at 07:28, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 12.11.24 15:10, Simon Glass wrote:
> > The cache-flush function is incorrect which causes a crash in the
> > remoteproc tests with arm64.
>
> We should throw out all these sandbox virtual addresses where they are
> not needed.
>
> Just add the missing conversion to drivers/remoteproc/rproc-elf-loader.c.
>
> And change flush_cache() on all architectures to use void *.

No, that is not the right approach. U-Boot uses addresses throughout
(ulong), except when a pointer is strictly needed.

Regards,
Simon
