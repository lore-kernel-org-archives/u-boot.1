Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86ED1C369AB
	for <u-boot@archiver.kernel.org>; Fri, 18 Apr 2025 04:10:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CAE28312E;
	Fri, 18 Apr 2025 06:10:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="Hzz2w+MJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A62483156; Fri, 18 Apr 2025 06:10:31 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 481B883121
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 06:10:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id F2AE22021B;
 Fri, 18 Apr 2025 06:10:28 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wGbLqxsepQLY; Fri, 18 Apr 2025 06:10:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1744949428; bh=edb+B++W/QaLVN7c93fgJvlAS/KFVd/0PI7RaInzmHg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Hzz2w+MJ4wePYQU+tvguzXXQzrIqFfVu65I2blbEfnnXOQSVc3152ED+vyjEL3DJb
 Oj5A8uef+RTrAbR/uZ29op3p/u+kxrXk62N43pQFhSvgUzBYeQjvJi6GFOTb13pD5y
 5IameD1aFevgSYRqZqr962IUfL3/TD5HyXr/FpufqZFQoXJjgk0Q1l9Fmf9XETIPzb
 mbzkjWhAB48Oz5QAVvSyXMPkobS+RlHe4+AWairirQ5RvTEQVwqOylsr0uHqBaYA9a
 5tFswj1SSqdv8NNbLjYdyg9LxjrP+5YnWVDweDAkuqIAibvGxIkpLhx7Q0JAL6Z8oK
 799z3h36Lyhhw==
Date: Fri, 18 Apr 2025 04:10:15 +0000
From: Yao Zi <ziyao@disroot.org>
To: Simon Glass <sjg@chromium.org>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, E Shattow <e@freeshell.de>,
 Yu-Chien Peter Lin <peter.lin@sifive.com>,
 Sumit Garg <sumit.garg@kernel.org>, Bin Meng <bmeng.cn@gmail.com>,
 u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: Re: [PATCH v2 1/3] riscv: dts: binman.dtsi: Switch to u-boot-nodtb
 entry for proper U-Boot
Message-ID: <aAHQp1w0BjaPdbT3@pie.lan>
References: <20250416162533.1396-1-ziyao@disroot.org>
 <20250416162533.1396-2-ziyao@disroot.org>
 <CAFLszTjiRKMLny_RcRB4sUV75c8_QLFkw4u_x6qfs3k1q=KsDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLszTjiRKMLny_RcRB4sUV75c8_QLFkw4u_x6qfs3k1q=KsDg@mail.gmail.com>
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

On Thu, Apr 17, 2025 at 03:35:50PM -0600, Simon Glass wrote:
> Hi Yao,
> 
> On Wed, 16 Apr 2025 at 10:25, Yao Zi <ziyao@disroot.org> wrote:
> >
> > Switch to u-boot-nodtb entry which precisely represents a proper U-Boot
> > and could be matched with u_boot_any. This allows RISC-V ports that make
> > use of binman to be built without disabling SPL_BINMAN_UBOOT_SYMBOLS
> > explicitly, which is set to y by default.
> >
> > Fixes: 0784510f741 ("riscv: sifive: unleashed: Switch to use binman to generate u-boot.itb")
> > Suggested-by: Jonas Karlman <jonas@kwiboo.se>
> > Signed-off-by: Yao Zi <ziyao@disroot.org>
> > ---
> >  arch/riscv/dts/binman.dtsi | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>
> 
> > diff --git a/arch/riscv/dts/binman.dtsi b/arch/riscv/dts/binman.dtsi
> > index 0405faca574..b7656423b69 100644
> > --- a/arch/riscv/dts/binman.dtsi
> > +++ b/arch/riscv/dts/binman.dtsi
> > @@ -35,7 +35,7 @@
> >                                         compression = "none";
> >                                         load = /bits/ 64 <CONFIG_TEXT_BASE>;
> >
> > -                                       uboot_blob: blob-ext {
> > +                                       uboot_blob: u-boot-nodtb {
> >                                                 filename = "u-boot-nodtb.bin";
> 
> Also you can see the default filename for that entry type in
> tools/binman/etype/u_boot_nodtb.py:
> 
>     def GetDefaultFilename(self):
>         return 'u-boot-nodtb.bin'
> 
> so you can drop this filename.

Okay, thanks for the hint.

> >                                         };
> >                                 };
> > --
> > 2.49.0
> >
> 
> Regards,
> Simon

Best regards,
Yao Zi
