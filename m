Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5342DCD4F3D
	for <u-boot@archiver.kernel.org>; Thu, 21 May 2026 06:26:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A3E28056B;
	Thu, 21 May 2026 08:26:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="yY/iFRNM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8DC5805D7; Thu, 21 May 2026 08:26:19 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BEC5080433
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 08:26:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch [83.173.201.248])
 by mail11.truemail.it (Postfix) with ESMTPA id B5C831F94C;
 Thu, 21 May 2026 08:26:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1779344777;
 bh=gWhMty/40jTTxzpd5SouCvBUbR/9XDkQDql618R4i4s=; h=From:To:Subject;
 b=yY/iFRNMaNp54qM/WOXlqItyu5IoyQ3XByY15hDaCgvvumaZAZcsDVSmyu3DUVe8c
 Wrzy3UFQUnhzzGpTvOmX5oMsEtquczUWu587j90Vio/2HWuTiUr3fEdpQrTHbuG0Dr
 yU+wmWzl+mSsjYqp8qAMbEDOoK+MDZTPX8cYBZkaYjDbWd4TU+cdijY2c0KSufewWZ
 ZAmwa5egNmP6t+rFzuYDMoId0iwXzEmI8OH2f9Az0M9wYkG+G5qRlii+EPPd00RgvF
 A3ROmqgJsqJUrFOjfJpfSndowRP3DX5Rp49CKf0bPXbFUdUgrMWGW7mw90icACjuTB
 T4yOn1xeoD48Q==
Date: Thu, 21 May 2026 08:26:15 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: "Scholz, Kevin" <k-scholz@ti.com>, Neha Malcom Francis <n-francis@ti.com>
Cc: Francesco Dolcini <francesco@dolcini.it>,
 Franz Schnyder <fra.schnyder@gmail.com>,
 "trini@konsulko.com" <trini@konsulko.com>,
 "K, Santhosh Kumar" <s-k6@ti.com>, "Brattlof, Bryan" <bb@ti.com>,
 "Chawdhry, Manorit" <m-chawdhry@ti.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "Kumar, Udit" <u-kumar1@ti.com>,
 "Gujulan Elango, Hari Prasath" <gehariprasath@ti.com>
Subject: Re: [EXTERNAL] Re: [PATCH v2 5/7] arm: dts: k3-am69: ddr: Update to
 v0.12.0 of DDR config tool
Message-ID: <20260521062615.GB11963@francesco-nb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177934243083.132247.2472290729341549059.b4-reply@b4>
 <8d4936cd5b16494e9447d5f64d7b8e11@ti.com>
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

On Wed, May 20, 2026 at 09:52:09PM +0000, Scholz, Kevin wrote:
> Francesco,
> 
> My understanding is that the Aquila board was previously having
> intermittent boot failures, hence the comparison of the TI EVM
> register values vs. the Aquila board register values. My understanding
> is that since then, two unrelated issues were identified resulting in
> the observed behavior, and both have been resolved.

My question has nothing to do with Aquila, I think I was not clear.

> However in general, more than one IO setting can be adequate for a
> given design, and it is also acceptable to have different IO settings
> for different board designs and/or for different DDRSS on the same
> board. 

Again, nothing on my question relates to this. My question was

> > specific configuration for AM69A SK board in which only dram3 has ODT
> > enabled, and dram, dram1 and dram2 not. Is the layout/schematics of
> > DRAM3 different from the others? Why?

Why do dram3 is different from dram, dram1 and dram2 on AM69-SK ? Such a
difference implies that the layout is different, or something else. I am
interested in understand what's the reason.

The question is because I want to understand better the TI design.

On Thu, May 21, 2026 at 11:17:10AM +0530, Neha Malcom Francis wrote:
> On 2026-05-20 21:52:09+00:00, Scholz, Kevin wrote:
> Francesco, hope this justification on the IO settings are satisfactory.

There is no answer to my question.

> Tom, could we pick up this series in that case?

From my point of view you can merge the series. It was like that even
before, I just abused this thread to gather more understanding on the
topic. I see no reason to hold this patch because of this.


Francesco

