Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B906C54FB3
	for <u-boot@archiver.kernel.org>; Thu, 29 May 2025 11:37:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E7378304A;
	Thu, 29 May 2025 13:37:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dWA5z+tK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BA848301F; Thu, 29 May 2025 13:37:56 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 985B783091
 for <u-boot@lists.denx.de>; Thu, 29 May 2025 13:37:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-604bf67b515so1424012a12.0
 for <u-boot@lists.denx.de>; Thu, 29 May 2025 04:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748518673; x=1749123473; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qDlvZXBKvv97F8vSUBEqUy0LhfkMR2ePklN99UTWit4=;
 b=dWA5z+tK1tIGlWtLsqL94TgFYkPpDjNhWI7OBelGR1c4Qm1SuR9/3WwSlDgISTphaM
 xUAGJbuBm3Uoz+u1Jqesp7Fl+Gw3IrZAzPlJQoFBUZneeve7iG2x1pmcUFv20ViOo+iP
 fmo/A11JNpNrUW8GKnxMYKBclNpptEPDfOxY1iOo8mXBKREYuGBCIxMPvLEyia4oX6MG
 TOwbxl/YHidA6egRPf/VBgSCLbuTVLdSplxESDUVc/cMdd5QM+qUdeNPpAnavf80tEBl
 3c2Iag4pgWUT1rG1G1MqUg2hPyHuyXzhd7ZUF7UBXiw5qxbNUCp6hF83hse4Z4dGPk0F
 0f1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748518673; x=1749123473;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qDlvZXBKvv97F8vSUBEqUy0LhfkMR2ePklN99UTWit4=;
 b=qVt+0K2Eb6gDcJlU3J7HbdzLV0Gc1tmdw38Ezx7SxjUIr+WjP5zfBZwKujBjUTGh5v
 o75WB/MqqyzlPblW1MIi+6SRQLWLbexmLqKfVKC4CE4Ja1g1iNAkqBVOQdyzoO3y0FNi
 6WpF2fCFzv/5LFy15rHRDbGDwHv2vleeqQ6SpPR71j6YzvL+HH6WUljkhuhlalG6oiXz
 OfpVEYjB7dzN66eV6B2ViRwpPvbmWYmb02ryRsCI4ZbQLigoO+QAO0LuVZ+uZWnRXuB9
 PCmNVmLbpTkTlv2wCv7jhQP7VrpDYCJSF1dJg/zTlpo9rllEli/SsTO90mA1mU9GslGv
 VUUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDUH9nirKssgZgEru6a/aMiTyLqvtI2nDLSdgFNfFLjG+rmrmk/fX1EJkzPgrqWkUhY+NsU1E=@lists.denx.de
X-Gm-Message-State: AOJu0YxITx0ZmqQLgospyMaN0m8RZn7k6KYRkqrJlqFeM25YlhMGUcGI
 7EG9u+5DQvj+QC1m86SWRyLOr4jXD1X2BdKdylOU4dyzpsbNVeC2NMP4+lJb1pL0R24QiVuK5T6
 skwCtg2kNg318BFRAUnF+lkAbtqNJWBhb4b+oRKo=
X-Gm-Gg: ASbGncuAq6nnc6NIIdKYjNdOIf9gfsS3RnALMjRy2+mHtFdMGDWifk+uIyAq/JmM/5C
 EIeagjsrcIn2V/13SYyQQOK+dDPzboI44AtgmRmGvyquSffdCNz1NLRS6MGA2H9U8w/DFpdlKAG
 m/iL051WlyLXmURIQxdAMDLi5xwn5eFL3g83EAmc3rSWOuYxW8IwyFNjnDGe+zA5gRew==
X-Google-Smtp-Source: AGHT+IGleoUZ1d7A+GWZs6/ntrrKnMp2o24LCdvuXHwb7ldfkLihDX2+BtGRy4wd7gXQc68eiM0d7tC5gSzxGayaDY8=
X-Received: by 2002:a05:6402:278d:b0:602:3cf1:44c8 with SMTP id
 4fb4d7f45d1cf-602d9af6b6amr15892825a12.8.1748518672862; Thu, 29 May 2025
 04:37:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ+vNU3H1vjbvyZTycBQhufii5SqyTnk4AaMRk_ztGY10g9joQ@mail.gmail.com>
 <6e667ef9-9fa0-441b-8520-46e7bdbc344a@linaro.org>
 <CAJ+vNU0kY=iNR6Q3PR6+x=wqv2932=1E+Ci0CwvURCPh6JD5-A@mail.gmail.com>
 <ebb48519-a02b-4b06-a801-f9c05fccd428@linaro.org>
 <CAJ+vNU2rOgp77+ML7LYuVu5hYFOwkbRytG8q2+NeXm7OgSL0vg@mail.gmail.com>
 <CALeDE9Odhr5OOrcGj+3-fyj4XrxAN+QMnrHW_sjSjicD1HrB2w@mail.gmail.com>
 <CAJ+vNU2yBvT49XkZDoHPQM2nd3qfe3WhSK8azFa9ZR2pSmaXPg@mail.gmail.com>
In-Reply-To: <CAJ+vNU2yBvT49XkZDoHPQM2nd3qfe3WhSK8azFa9ZR2pSmaXPg@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Thu, 29 May 2025 12:37:41 +0100
X-Gm-Features: AX0GCFucFhhyONQEshADFEfVBii01X_Vo26lOMgsALknxLavmt0xgCF2LKCNayQ
Message-ID: <CALeDE9PV7VtD-UomDcOo4XKbLfgceUeYNNC3KwJ8O7sD1VmTyg@mail.gmail.com>
Subject: Re: lwip tftp not working on imx8mm
To: Tim Harvey <tharvey@gateworks.com>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 u-boot <u-boot@lists.denx.de>, 
 Fabio Estevam <festevam@gmail.com>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>
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

> > > > >>> I've enabled LWIP on imx8mm_venice to see how it's doing and while
> > > > >>> dhcp/dns/ping/wget appear to work great, tftp is broken.
> > > > >>>
> > > > >>> Enabling LWIP_DEBUG shows the following:
> > > > >>> ip4_input: packet accepted on interface et
> > > > >>> IP packet dropped since it was fragmented (0x2000) (while IP_REASSEMBLY == 0).
> > > > >>
> > > > >> Hmmmmm IP_REASSEMBLY should probably default to 1.
> > > > >>>
> > > > >>> I tried enabling IP_REASSEMBLY in lwip but that seems to change the issue to:
> > > > >>> ip4_input: packet accepted on interface et
> > > > >>> ip4_input:
> > > > >>> IP header:
> > > > >>> +-------------------------------+
> > > > >>> | 4 | 5 |  0xc0 |       108     | (v, hl, tos, len)
> > > > >>> +-------------------------------+
> > > > >>> |    10568      |000|       0   | (id, flags, offset)
> > > > >>> +-------------------------------+
> > > > >>> |   64  |    1  |    0xe25b     | (ttl, proto, chksum)
> > > > >>> +-------------------------------+
> > > > >>> |  172  |   24  |    0  |    2  | (src)
> > > > >>> +-------------------------------+
> > > > >>> |  172  |   24  |   21  |  251  | (dest)
> > > > >>> +-------------------------------+
> > > > >>> ip4_input: p->len 108 p->tot_len 108
> > > > >>> Unsupported transport protocol 1
> > > > >>>
> > > > >>> Any ideas what the issue is here?
> > > > >>
> > > > >> Not really :-/ Does the transfer work with a smaller block size?
> > > > >> (CONFIG_TFTP_BLOCKSIZE, default 1468, try 500 for instance). You could
> > > > >> also enable CONFIG_LWIP_DEBUG_RXTX in order to get a full hex dump of
> > > > >> the messages going into/out of the lwIP stack.
> > > > >
> > > > > Hi Jerome,
> > > > >
> > > > > My config was with 4096, setting it to 1468 works and anything above
> > > > > that seems to cause this failure.
> > > >
> > > > Good to know.
> > > >
> > > > > Some sort of fragmentation issue?
> > > >
> > > > Quite possibly, yes. In any case it does not make much sense to use a
> > > > clock size that causes the packet to be larger than the PMTU (it would
> > > > be sub-optimal) but it should definitely work, especially since I don't
> > > > believe PMTU discovery is implemented in lwIP. I add this to my to-do
> > > > list but feel free to investigate further :)
> > > >
> > >
> > > Hi Jerome,
> > >
> > > I'll take a look at it as larger than MTU packets are definitely not
> > > suboptimal for TFTP. A 4096B block size will ack once per 4K so 4x
> > > less ACK's and in my testing the 4K blocksize gives a 3x performance
> > > boost on large files.
> >
> > Refreshing my memory on TFTP slightly, I think larger than MTU tftp
> > transfers need support for RFC 2348 [1], maybe that's something we
> > need to explicitly enable if the TFTP layer is part of LWIP (or maybe
> > LWIP doesn't support it), or if the tftp application is ours on top of
> > LWIP maybe we're missing some glue. I didn't look at the code, rather
> > this was from some of my own notes from a long time ago.
> >
> > [1] https://www.rfc-editor.org/rfc/rfc2348
>
> The issue was simply that IP_REASSEMBLY was not enabled for U-Boot
> lwIP - I thought I tried that originally but must have done it wrong
> (probably picked the wrong header vs lib/lwip/u-boot/lwipopts.h).
>
> (+cc Joe and Ramon network maintainers)
>
> I can submit a patch but it seems to me we should enable both
> IP_REASSEMBLY (reassemble incoming fragmented IP packets) as well as
> IP_FRAG (fragment outgoing IP packets if their size exceeds MTU) for
> lwIP as both are currently disabled.

I think both of those options should likely be on by default, I
suspect that they're not is likely an oversight, Jerome can you
provide more details here?

> Would you all agree with enabling both? I don't think we have anything
> that needs to sends fraemented packets via lwIP yet.

Yes, I don't think we do by default, but networks, especially outside
of the datacentre, are hard and you never know why a packet maybe
fragmented.

> Is there value in adding support for the 'tftpblocksize' env var
> supported in legacy tftp?

Maybe for consistency, but also it's a new feature and if they've not
need it to now is it likely useful?

Peter
