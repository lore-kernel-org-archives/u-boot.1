Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 416C9CDB465
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 09:28:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB412871A1;
	Thu, 19 Oct 2023 11:28:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7666871A2; Thu, 19 Oct 2023 11:28:13 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8404F871A0
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 11:28:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 39J9Ruem090927;
 Thu, 19 Oct 2023 17:27:56 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS16.andestech.com (10.0.1.222)
 with Microsoft SMTP Server id 14.3.498.0;
 Thu, 19 Oct 2023 17:27:53 +0800
Date: Thu, 19 Oct 2023 17:24:56 +0800
From: Leo Liang <ycliang@andestech.com>
To: Tom Rini <trini@konsulko.com>
CC: Yu Chien Peter Lin <peterlin@andestech.com>, <u-boot@lists.denx.de>,
 <rick@andestech.com>, <kconsul@ventanamicro.com>, <bmeng@tinylab.org>
Subject: Re: [PATCH] riscv: Add Zbb support for building U-Boot
Message-ID: <ZTD16KzfMBw_1mvM@swlinux02>
References: <20230809104930.7462-1-peterlin@andestech.com>
 <20231017153845.GJ3119521@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231017153845.GJ3119521@bill-the-cat>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 39J9Ruem090927
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

On Tue, Oct 17, 2023 at 11:38:45AM -0400, Tom Rini wrote:
> On Wed, Aug 09, 2023 at 06:49:30PM +0800, Yu Chien Peter Lin wrote:
> 
> > This patch adds ISA string to the -march to generate zbb instructions
> > for U-Boot binaries, along with optimized string functions introduced
> > from Linux kernel.
> > 
> > Signed-off-by: Yu Chien Peter Lin <peterlin@andestech.com>
> [snip]
> > +config RISCV_ISA_ZBB
> > +	bool "Zbb extension support for bit manipulation instructions"
> > +	default n
> 
> The default is 'n' so we don't need this line.  This can be fixed
> in-line while applying if there's no other feedback, thanks.
> 

Hi Tom,

Got it! Thanks for the heads-up!

Best regards,
Leo

> --
> Tom


