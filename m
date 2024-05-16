Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FD78C25B79
	for <u-boot@archiver.kernel.org>; Thu, 16 May 2024 09:46:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 698F688011;
	Thu, 16 May 2024 11:46:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=foundries.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=foundries.io header.i=@foundries.io header.b="BRD6z1Ia";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E38E288193; Thu, 16 May 2024 11:46:23 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4ACD87F52
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 11:46:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=foundries.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jorge@foundries.io
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-41fd5dc0480so49799755e9.1
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 02:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=foundries.io; s=google; t=1715852781; x=1716457581; darn=lists.denx.de;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:date:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=BcsON7LXBsgj7WqDSEBnQQt8C4IXiVLnq+FpsM4uf80=;
 b=BRD6z1IaNd2EwNX1HQWAEPz0qaTLR/IgU8p/wftZCISQ/kvyb95X5LmCxZvMBC9m2e
 I67gOAIko+AZzgperAHPaqSkbF+2+1vuFz1Jqjtpdgl53ELPo0SUzzgSZW2A4bSA9yGO
 g+VBS8GnAaj5RDjA+RRLd2Gme5iewFK+FajuX5b+RNWEY91bUtwGTMlcWJcyw5CMnLGZ
 UtWE5zhNE4x6l24MGS3CQEBlGTJ6/hXRtciCyZgd2uDN4jBUnoRzOdFg/mRKS2hAHvdF
 yMfdRG1brxYRqYXebo6mXHwWftcQad1wli5rH+CGo307tZ50261AnOx45TFUEQP0elzv
 y56g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715852781; x=1716457581;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:date:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BcsON7LXBsgj7WqDSEBnQQt8C4IXiVLnq+FpsM4uf80=;
 b=aIGbkWlTC4+9NzMyRfpuM5KrXmrtoUuTXsNuayHRi3Z6ROJb22swY4dd7rZZPfh9jJ
 TjM1lV+kgovJMFSjO2umn2TVOL9LE6xbrncN9hHJ25XUTLInOIMno7d0XMnfgrbS5rop
 83lAILlOEIl7LM2Qn7gSh7UaSvMbXaucbG1wm0v/7YRo7sSO4prXS9uXcDunBQjzWIki
 jNYEl+zNXASq+DfopU3Zi92rAD1DzWfwkrvlrfnBWsSuq9fgF4Wa1fSGdp1bNrXNdXmo
 1KPjAapYTXgDgjHnmjLnBWUa5H45/+nwa49dylaqtjJQ15UsI9jX0QTl9aLfnnfZp9ea
 XaLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTRgqNL/97nvc93Y/6R5G01qb887AzL8Imz2ink6pzkfVna5nE+bTne1kgz34SZ+2x7s2ScGMMJdY/vZywy9w1SuGg+A==
X-Gm-Message-State: AOJu0YwEkMjMU+9wsviJ1pdcnLoLTm5WUQ+V9G/fWRsvVz2S81XZFH0Z
 UNQnsclwfHZV1mySk/BbNUP3Apbm+kW5qo+wpOibOxOo6ChnM4o7B6PHpJAvFqs=
X-Google-Smtp-Source: AGHT+IFuUfDMpYkcUt1CQP4YnRNf3H9gfUyE7piY7OfEDJnszsMpZSo6nlwaToPs6HQ/LigT4WO6zQ==
X-Received: by 2002:a05:600c:1f90:b0:41c:190:2b94 with SMTP id
 5b1f17b1804b1-41feaa2f450mr146095915e9.6.1715852780955; 
 Thu, 16 May 2024 02:46:20 -0700 (PDT)
Received: from trex (113.red-79-144-189.dynamicip.rima-tde.net.
 [79.144.189.113]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502b8a78e8sm18735561f8f.61.2024.05.16.02.46.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 May 2024 02:46:20 -0700 (PDT)
From: "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>
X-Google-Original-From: "Jorge Ramirez-Ortiz, Foundries" <JorgeRamirez-Ortiz>
Date: Thu, 16 May 2024 11:46:19 +0200
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>,
 Tim Harvey <tharvey@gateworks.com>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Adam Ford <aford173@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: Re: [PATCH v3] tpm: display warning if using gpio reset with TPM
Message-ID: <ZkXV6wBiN/oRfUH+@trex>
References: <20240515232138.3065987-1-tharvey@gateworks.com>
 <20240516090950.373d304c@xps-13> <ZkXNN4I/gFgjD3oP@trex>
 <20240516113414.49fe3b9f@xps-13>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240516113414.49fe3b9f@xps-13>
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

On 16/05/24 11:34:14, Miquel Raynal wrote:
> Hi Jorge,
> 
> ...
> 
> > > >  - board with no reset gpio
> > > > u-boot=> tpm init && tpm info
> > > > tpm@1 v2.0: VendorID 0x1114, DeviceID 0x3205, RevisionID 0x01 [open]
> > > >  - board with a reset gpio
> > > > u-boot=> tpm init && tpm info
> > > > tpm@1: TPM gpio reset should not be used on secure production devices
> > > > tpm@1 v2.0: VendorID 0x1114, DeviceID 0x3205, RevisionID 0x01 [open]
> > > > 
> > > > [1] https://trustedcomputinggroup.org/wp-content/uploads/TCG_PCClientTPMInterfaceSpecification_TIS__1-3_27_03212013.pdf
> > > > 
> > > > Signed-off-by: Tim Harvey <tharvey@gateworks.com>  
> > > 
> > > Looks way cleaner, thanks.
> > > 
> > > Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > > 
> > > Miquèl  
> > 
> > nice. if needed
> > 
> > Signed-off-by: Jorge Ramirez-Ortiz <jorge@foundries.io>
> 
> You cannot send your SoB like this. SoB means you are carrying some
> code which complies with the license, etc.
> 
> Either you were part of the original writing and want to be credited
> for that (you can be the author and first SoB, or suggest Tim to use
> Co-developed-by). Or you reviewed the change (Reviewed-by), you tested
> the change (Tested-by), or you are maintainer/responsible for some part
> that is touched and you agree with the change (Acked-by).

right, however there is some lenience in the process: some projects accept
the signed off, some others add the acked or reviewed and so on...

but I agree with you and I certainly do not need/want/expect to be
credited for this work. it is all good on my end :)

> 
> Thanks,
> Miquèl

btw you could have simply ignored my note btw : notice the "if needed"
part in my response. for reference, I noticed my name in CC, checked the
change, thought it was a good idea and tried to move it a long - just
chose the wrong tag for sure...



