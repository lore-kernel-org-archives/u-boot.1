Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6581DEB270B
	for <u-boot@archiver.kernel.org>; Tue, 10 Feb 2026 19:55:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FB1F83A47;
	Tue, 10 Feb 2026 20:55:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="xbkz6DDs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EAD783A5A; Tue, 10 Feb 2026 20:55:01 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98FB18388D
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 20:54:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 9A7D91F83E;
 Tue, 10 Feb 2026 20:54:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1770753292;
 bh=V1lgnhVq8L5qxmYJ4EI8QnUaoEFr1y2pDxSNWayPSBc=; h=From:To:Subject;
 b=xbkz6DDsKC149aRvrvIbriqb8Lerznyhk7QZ8ksWGiss8Q7UVKkS8QAcDswhGiARz
 Whj2NncmWUnTD1nfde3mC5gNsZ2eRkpQ7xNYw8ONgFtYq6OwhCJmf3DUejh6UGZtHM
 jP2u+qyDtop+cIiRrnEPoldnrf9TiNZkGUlwGEiDuQqweBUB7bEC+8MNZKO/Uka5gh
 OvQU0tB8E3LHLuf1uIe7isRoWUzg4zZ+gJVFdO2kqygoD8Olg1XOzswdlpAtbbb7Y3
 kgd0KDsLrwXMsJgaSS5TpT2Cj0rwPuEnaGWp6cdptuD5VTsvHTvgC5AW8P5V9k9OTo
 aViNftNf3Bbgg==
Date: Tue, 10 Feb 2026 20:54:48 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Santhosh Kumar K <s-k6@ti.com>
Cc: Tom Rini <trini@konsulko.com>, vigneshr@ti.com, bb@ti.com,
 u-boot@lists.denx.de, n-francis@ti.com
Subject: Re: [PATCH 0/5] Update DDR Configurations
Message-ID: <20260210195448.GA18714@francesco-nb>
References: <20260203063529.1551907-1-s-k6@ti.com>
 <141c6627-6ceb-4bd7-871c-d2828887e28c@ti.com>
 <20260210180814.GB2728096@bill-the-cat>
 <20a153b5-3691-4517-bd81-b8f1968310e1@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20a153b5-3691-4517-bd81-b8f1968310e1@ti.com>
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

On Tue, Feb 10, 2026 at 11:42:34PM +0530, Santhosh Kumar K wrote:
> 
> 
> On 10/02/26 23:38, Tom Rini wrote:
> > On Tue, Feb 10, 2026 at 11:35:02PM +0530, Santhosh Kumar K wrote:
> > > Hello Tom,
> > > 
> > > On 03/02/26 12:05, Santhosh Kumar K wrote:
> > > > This series updates the DDR Configurations according to the SysConfig DDR
> > > > Configuration tool v0.10.32 for the following devices [1]
> > > >    - AM64x EVM
> > > >    - AM62x SK
> > > >    - AM62x LP SK
> > > >    - AM62Ax SK
> > > >    - AM62Px SK
> > > > 
> > > > Testing:
> > > > memtester - 50% of memory for 10 loops - PASSED
> > > > 
> > > > [1] https://dev.ti.com/tirex/content/Processor_DDR_Config_0.10.32.0000/docs/REVISION_HISTORY.html
> > > 
> > > Gentle Ping!
> > 
> > Is this required for v2026.04 or is v2026.07 fine? Thanks.
> 
> It'll be good if they go in v2026.04 as these are some critical DDR
> fixes.

Would you mind sharing what are the critical fixes? I have seen the tool
changelog, but it would be important to have more details on the actual
impact of those changes. It is solving instabilities of memory errors?
If yes, in which situation? And why?

Francesco


