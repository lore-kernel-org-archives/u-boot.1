Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE842C4332F
	for <u-boot@archiver.kernel.org>; Tue, 14 Nov 2023 06:26:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE2E0870E1;
	Tue, 14 Nov 2023 07:26:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 866E5870B5; Tue, 14 Nov 2023 07:26:47 +0100 (CET)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DC0D867F6
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 07:26:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=randolph@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 3AE6QZM8089172;
 Tue, 14 Nov 2023 14:26:35 +0800 (+08)
 (envelope-from randolph@andestech.com)
Received: from atctrx (10.0.15.173) by ATCPCS16.andestech.com (10.0.1.222)
 with Microsoft SMTP Server id 14.3.498.0; Tue, 14 Nov 2023 14:26:35 +0800
Date: Tue, 14 Nov 2023 14:26:20 +0800
From: Randolph Lin <randolph@andestech.com>
To: Simon Glass <sjg@chromium.org>
CC: U-Boot Mailing List <u-boot@lists.denx.de>, <randolph.sklin@gmail.com>,
 <dylan@andestech.com>, <tim609@andestech.com>, Yu Chien Peter Lin
 <peterlin@andestech.com>
Subject: Re: [PATCH] riscv: binman: fix the load field format
Message-ID: <ZVMTDF9vGNm_cRGk@atctrx>
References: <20231109031448.138723-1-randolph@andestech.com>
 <CAPnjgZ2_JUdLXvUM7DdhjyqEOA4o+pSPKnSnYMQ6m3Ca=N35YA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ2_JUdLXvUM7DdhjyqEOA4o+pSPKnSnYMQ6m3Ca=N35YA@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Originating-IP: [10.0.15.173]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 3AE6QZM8089172
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
Thanks a lot.
On Fri, Nov 10, 2023 at 04:50:24AM -0700, Simon Glass wrote:
> Hi Randolph,
> 
> On Wed, Nov 8, 2023, 20:15 Randolph <randolph@andestech.com> wrote:
> >
> > The #address-cells is now equal to 2. The format of the load field for
> > the Linux kernel doesn't match.
> >
> > Signed-off-by: Randolph <randolph@andestech.com>
> > ---
> >  arch/riscv/dts/binman.dtsi | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/riscv/dts/binman.dtsi b/arch/riscv/dts/binman.dtsi
> > index 6b4eb8dc7b..5117d7c8c9 100644
> > --- a/arch/riscv/dts/binman.dtsi
> > +++ b/arch/riscv/dts/binman.dtsi
> > @@ -50,7 +50,8 @@
> >                                         os = "Linux";
> >                                         arch = "riscv";
> >                                         compression = "none";
> > -                                       load = <CONFIG_TEXT_BASE>;
> > +                                       load = <U64_TO_U32_H(CONFIG_TEXT_BASE)
> > +                                               U64_TO_U32_L(CONFIG_TEXT_BASE)>;
> 
I just see the #address-cells changed from 1 to 2 in commit id: 5a348ccf0257.
In my last commit for binman.dtsi (commit id: d311df8b3169), it is based on
the value of #address-cells being 1. That's the reason for my patch submission.
> Does this work?
> 
> load = /bits 64/ <CONFIG_TEXT_BASE>
>
Yes, it works. We use this way for the DDR memory start address above 4G 
platform. We find the example for 64bit address in the document 
tools/binman/binman.rst and use it.
What is the method that we should continue to use in the binman.dtsi?
1. #address-cells = 2
2. append /bits/64 
> >
> >                                         linux_blob: blob-ext {
> >                                                 filename = "Image";
> > --
> > 2.34.1
> >
> 
> Regards,
> Simon
