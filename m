Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0546CC3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 14:46:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21D6287A13;
	Thu, 28 Dec 2023 15:46:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="OmWd7Dn2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA4B287A17; Thu, 28 Dec 2023 15:46:12 +0100 (CET)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF3BD879E8
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 15:46:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: d3edf317-a58f-11ee-91e7-005056994fde
Received: from smtp.kpnmail.nl (unknown [10.31.155.6])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id d3edf317-a58f-11ee-91e7-005056994fde;
 Thu, 28 Dec 2023 15:46:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=content-type:mime-version:subject:to:from:message-id:date;
 bh=VCaRH5/4tBfUk1thcWt5ere2wiS75NRWYHyAyY3HPL4=;
 b=OmWd7Dn2QbVluGgQZukEnYtnWqysTpwmhGgX0IKFAmGvR9zeWfiz63S4OS4qn4l0c6V9CLMhpfkCJ
 L1t+rLnCmF1o50XaAZ7BL/wJxD1R47+8g1YnHsws7XjxPpcJQGrJhmkzYV63EsiaVTOhOZZ2a324LE
 nf2+xVTe5sVkbq4ufgsi2oVZ8k892QEc7MtLfXm6ltA+3ynphbJHRpRTO83GtzEne2JcjZOITprVUL
 jXZ2gWATuWt88vBmAQjfMD3SEfSmJzKt/xj4HVvkMRLzOGEZKbzeH6xvEH4NWQTOInZcxmVIX8TZK5
 M1MRb6ZJDxmjRIPs+fZTTj74z47b8PQ==
X-KPN-MID: 33|CVlDgFphuoWQiW/+RSz9OTdlnJs8vIT2RI1A9eyQK//fg4Wh1ktH9KviAIxg82X
 pK3XAtrpD5e1mgNSX17vxArl7L2S8kTDbA0mYkVb18Ao=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|l0mbTFtBajIR8vHmo89KD2iUoEyUNxBtMJ1kXnOoCP3mXQ5CmCHKg5ca0NBEl7P
 3KegZ4+HvkJtU2K66bYlswQ==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id d6a3726a-a58f-11ee-9dc8-00505699772e;
 Thu, 28 Dec 2023 15:46:10 +0100 (CET)
Date: Thu, 28 Dec 2023 15:46:09 +0100
Message-Id: <87edf6mlla.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Simon Glass <sjg@chromium.org>
Cc: ilias.apalodimas@linaro.org, u-boot@lists.denx.de,
 xypron.glpk@gmx.de, pbrobinson@gmail.com
In-Reply-To: <CAFLszTgXZ3fMZkuYRJUzSBv-VT659Q5bYLyVkEh4=-36TM3+Bw@mail.gmail.com>
 (message from Simon Glass on Thu, 28 Dec 2023 13:37:03 +0000)
Subject: Re: [PATCH v4 4/7] smbios: Use SMBIOS 3.0 to support an address above
 4GB
References: <20231227074025.2178825-1-sjg@chromium.org>
 <20231227074025.2178825-5-sjg@chromium.org>
 <CAC_iWj+yGhUVFh+vJ14C2htibdd289SrPjz0Y_r3GL4uF4Zdog@mail.gmail.com>
 <CAFLszTgXZ3fMZkuYRJUzSBv-VT659Q5bYLyVkEh4=-36TM3+Bw@mail.gmail.com>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
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

> From: Simon Glass <sjg@chromium.org>
> Date: Thu, 28 Dec 2023 13:37:03 +0000
> 
> Hi Ilias,
> 
> On Wed, Dec 27, 2023 at 11:05 AM Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi Simon,
> >
> > On Wed, 27 Dec 2023 at 09:40, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > When the SMBIOS table is written to an address above 4GB a 32-bit table
> > > address is not large enough.
> > >
> > > Use an SMBIOS3 table in that case.
> >
> > Maybe I missed this on the previous revisions, but is there a reason
> > we don't always use SMBIOS3 now?
> 
> I am not sure...there was some comment about it not being supported in
> some cases, so I have tried to accommodate that.
> 
> >  And perhaps try to install SMBIOS2 if
> > 1. we fail
> 
> due to?
> 
> > 2. and the address is < 4GB
> 
> We could, I suppose. Effectively we would drop generation of SMBIOS2.
> 
> I really don't mind. This whole SMBIOS thing is a bit ridiculous, if
> you ask me.

Linux added support for the SMBIOS 3.0 64-bit entry point in 2014.  I
doubt anyone who cares about SMBIOS cares about kernels that old.

So if it simplifies things, I'd drop support for the 32-bit SMBIOS
entry point.
