Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0122EE49BD
	for <u-boot@archiver.kernel.org>; Wed, 31 Dec 2025 03:01:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 465D083FD3;
	Wed, 31 Dec 2025 04:01:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ziyao.cc header.i=@ziyao.cc header.b="dTU33aoy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 799F383FF5; Wed, 31 Dec 2025 04:01:55 +0100 (CET)
Received: from mail105.out.titan.email (mail105.out.titan.email
 [107.23.70.138])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E74083FC6
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 04:01:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@ziyao.cc
Received: from localhost (localhost [127.0.0.1])
 by smtp-out.flockmail.com (Postfix) with ESMTP id 4dgvr00jGFz9rwV;
 Wed, 31 Dec 2025 03:01:52 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=1RA1aE1NCCLG3KUjp8sxTEbeY+owqm66pnBImkp8ymY=; 
 c=relaxed/relaxed; d=ziyao.cc;
 h=date:references:to:cc:message-id:mime-version:from:subject:in-reply-to:from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
 q=dns/txt; s=titan1; t=1767150112; v=1;
 b=dTU33aoy2YCs7La4SOf1+RFgO3V23qzDv1GZ9RHi7SYJ3gYGGlSlovTLr8YFALsMlbxJaf3f
 LEsEFSSUSqGRFJGmIFnywN8jAzZpHB9KdWhJXXKn5ytpDVwN5rm/kj+32ZgDOu72KHZa9o5BqIo
 B2SV8t2z4HEMwXum14E/GVVo=
Received: from pie (unknown [117.171.66.56])
 by smtp-out.flockmail.com (Postfix) with ESMTPA id 4dgvqw603yz9rwY;
 Wed, 31 Dec 2025 03:01:48 +0000 (UTC)
Date: Wed, 31 Dec 2025 03:01:30 +0000
Feedback-ID: :me@ziyao.cc:ziyao.cc:flockmailId
From: Yao Zi <me@ziyao.cc>
To: Kuan-Wei Chiu <visitorckw@gmail.com>, alison.wang@nxp.com,
 angelo@kernel-space.org, trini@konsulko.com
Cc: daniel@0x0f.com, jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com,
 u-boot@lists.denx.de
Subject: Re: [PATCH v3 1/6] serial: Add Goldfish TTY driver
Message-ID: <aVSSCnF_YO3IaGR8@pie>
References: <20251230160112.3045527-1-visitorckw@gmail.com>
 <20251230160112.3045527-2-visitorckw@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251230160112.3045527-2-visitorckw@gmail.com>
X-F-Verdict: SPFVALID
X-Titan-Src-Out: 1767150111939022267.21635.6975193352072016962@prod-use1-smtp-out1003.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=a8/K9VSF c=1 sm=1 tr=0 ts=6954921f
 a=ILiXPvH1yGBXwyP4YTaA5g==:117 a=ILiXPvH1yGBXwyP4YTaA5g==:17
 a=kj9zAlcOel0A:10 a=MKtGQD3n3ToA:10 a=CEWIc4RMnpUA:10 a=pGLkceISAAAA:8
 a=xiJ4NyQIv8H1C1NOg1YA:9 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10
 a=3z85VNIBY5UIEeAh_hcH:22 a=NWVoK91CQySWRX1oVYDe:22
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

On Tue, Dec 30, 2025 at 04:01:07PM +0000, Kuan-Wei Chiu wrote:
> Add support for the Google Goldfish TTY serial device. This virtual
> device is commonly used in QEMU virtual machines (such as the m68k
> virt machine) and Android emulators.
> 
> The driver implements basic console output and input polling using the
> Goldfish MMIO interface.
> 
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> ---
> Changes in v3:
> - Remove unnecessary type casts for MMIO register access.
> 
>  MAINTAINERS                      |   6 ++
>  drivers/serial/Kconfig           |   8 +++
>  drivers/serial/Makefile          |   1 +
>  drivers/serial/serial_goldfish.c | 102 +++++++++++++++++++++++++++++++
>  include/goldfish_tty.h           |  18 ++++++
>  5 files changed, 135 insertions(+)
>  create mode 100644 drivers/serial/serial_goldfish.c
>  create mode 100644 include/goldfish_tty.h

This version looks good to me,

Reviewed-by: Yao Zi <me@ziyao.cc>
