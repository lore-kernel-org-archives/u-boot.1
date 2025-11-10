Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7357CCFA13
	for <u-boot@archiver.kernel.org>; Mon, 10 Nov 2025 19:14:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3364983A98;
	Mon, 10 Nov 2025 20:14:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="IDOHR69h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4754983A9F; Mon, 10 Nov 2025 20:14:43 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 535FA83A8F
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 20:14:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukma@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D55A0108488; Mon, 10 Nov 2025 20:14:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1762802080;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=l//vtPU4eMXBLYADGoT70CbShQ3tJspuMQX0QhLN9WE=;
 b=IDOHR69h3K9xTTKoWyHGAbISw5s5rqxfTx5iiwTkXCqOdc+W7Z2SgRfs4ul7GDqQtcFwl4
 BDerI1VcwSdal3gePGLBZVfQags1r1gkWmfAF2WpEgpa+bxvCRcZhQ5y16RjjjOBtP4chd
 p2uB7EygREE3nhnLAk2ZAUOaWVBxVlEA3pzhlZZl29cbNr171CErHEsjZzqO+3Q71Gz0Jd
 5nAvCzxQzWMLWL2IY5+EWy41JmmcLDBhZ4XPr7BwiROjjb5jAQe6DgHrv/1jJzHcAu4NvF
 QfyAXCnNNgFxjO7xlaqX3TxUxx2zwQ58QiuXeYL8ylDTEuqe+0JZlztfo5kPGw==
Date: Mon, 10 Nov 2025 20:14:35 +0100
From: =?UTF-8?B?xYF1a2Fzeg==?= Majewski <lukma@nabladev.com>
To: Tom Rini <trini@konsulko.com>
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 uboot-imx@nxp.com, u-boot@lists.denx.de, John Ripple
 <john.ripple@keysight.com>, Peng Fan <peng.fan@nxp.com>, Ji Luo
 <ji.luo@nxp.com>
Subject: Re: [PATCH] arm: imx: Add command to get offset of first image in
 AHAB OS container
Message-ID: <20251110201435.476d7b13@wsk>
In-Reply-To: <20251110145350.GK6688@bill-the-cat>
References: <20251110124100.4193259-1-lukma@nabladev.com>
 <20251110145350.GK6688@bill-the-cat>
Organization: Nabla
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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

Hi Tom,

> On Mon, Nov 10, 2025 at 01:41:00PM +0100, Lukasz Majewski wrote:
> 
> > With current mainline it is possible to check with AHAB if system
> > OS image can be trusted (with 'auth_cntr' command).
> > However, after the validation one needs to use the image (fitImage
> > in this case) itself. Such operation requires getting the offset in
> > the image eligible for AHAB validation to start execution of the
> > fitImage.
> > 
> > Command in this patch allows it, so with:
> > auth_cntr_offset ${addr} auth_cntr_os_offset;
> > setexpr addr ${kernel_addr_r} + ${auth_cntr_os_offset};
> > 
> > it is possible to boot the fitImage after AHAB IP block vaidation.
> > 
> > Signed-off-by: Lukasz Majewski <lukma@nabladev.com>
> > ---
> >  arch/arm/mach-imx/imx8/ahab.c | 50
> > +++++++++++++++++++++++++++++++++++ 1 file changed, 50
> > insertions(+)  
> 
> Can we please split the commands here out and put it under
> cmd/imx/imxh-ahab.c or something? Thanks.
> 

If the community is OK, with such solution (especially Peng and Ji),
then no problem - I can first exclude commands from ahab.c file and
then add the auth_cntr_offset command to the newely created
cmd/imx/imx8-ahab.c file.

-- 
Best regards,

Lukasz Majewski

--
Nabla Software Engineering GmbH
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Managing Director : Stefano Babic
