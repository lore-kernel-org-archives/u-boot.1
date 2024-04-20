Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 986BAC4345F
	for <u-boot@archiver.kernel.org>; Sat, 20 Apr 2024 23:10:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCA6A88210;
	Sun, 21 Apr 2024 01:10:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1713654615;
	bh=p2P881eGySLYh/tHfheAipkjQyn0N7NbSSy0nh2JAMk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jLZsPyW1bOe7TGmhIa3A+xsaMQlVRImBrCdchaiXe0wXHeIRQkFnCROYdtwFNUS2j
	 XX0+2FLYQRnsXeBHcKjhrVtlu+vXPUdWiN9EZHJGDNE+DDe1FyfGxvexd9OGD+CBGF
	 avTYvJtbGkriy36nwMUzMpJgCbf+zGEpeGTO/xEgI084BkcZhxKPfrOKs/04fy00Y7
	 RQwFzNXIukDPzyIx9KALHuf4eULUudeizq3LighnK8INHbBEwevNfvIdSy6jr4A+qz
	 ZLW55OOIwLnpHhy1eU4/Vkj/lH7nYGkssO+AZrgAMRePlWwLJDMCIb4eXrJ9AdO9mw
	 /yhobRmU1o3yw==
Received: from crub (p508b6ab0.dip0.t-ipconnect.de [80.139.106.176])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: agust@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 2DBD688003;
 Sun, 21 Apr 2024 01:10:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1713654614;
 bh=p2P881eGySLYh/tHfheAipkjQyn0N7NbSSy0nh2JAMk=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=fky3d+MAkZxurJ+uZsewiAcQtwN+x18TtaH7NBPSyKh8HWLitohvCxYURXTMnVc0U
 /0UT62rxQ5yrtcpVvlX55qUb5FhYBAWdzfqwUNqhz8AZoFZEB0HNfHebp3cSZsBUtj
 UdkaV14SEZtO0jZmay5TxmzXM81MWQvtpDMf51ey8tpnioMZ50GLECJqKUA2m6r0Gx
 urqnNxTtOm7cdFroz3HUEuWGNpFyKcIAcZUR25yyxq32Pr/6RAH8HQJsn4uAsWsjCl
 Wims/+ySoJKtXGz0VLNOQLNrSDlyxJifP8uq76SOse+lrEQOs4FkY1vdQJIi9dGlzH
 noYPCDc82bkbw==
Date: Sun, 21 Apr 2024 01:09:53 +0200
From: Anatolij Gustschin <agust@denx.de>
To: Devarsh Thakkar <devarsht@ti.com>
Cc: <u-boot@lists.denx.de>, <sjg@chromium.org>, <trini@konsulko.com>,
 <bmeng@tinylab.org>, <xypron.glpk@gmx.de>, <patrick.delaunay@foss.st.com>,
 <patrice.chotard@foss.st.com>, <hvilleneuve@dimonoff.com>,
 <michal.simek@amd.com>, <troykiskyboundary@gmail.com>,
 <j-humphreys@ti.com>, <afd@ti.com>, <praneeth@ti.com>, <nm@ti.com>,
 <vigneshr@ti.com>, <a-bhatia1@ti.com>, <j-luthra@ti.com>, <nsekhar@ti.com>,
 <n-jain1@ti.com>
Subject: Re: [PATCH 0/4] Simplefb and fb reservation related updates
Message-ID: <20240421010953.37384c64@crub>
In-Reply-To: <83db0246-18a6-05ab-3e76-472ad0cc688b@ti.com>
References: <20240222130811.3878567-1-devarsht@ti.com>
 <83db0246-18a6-05ab-3e76-472ad0cc688b@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Fri, 8 Mar 2024 16:38:28 +0530
Devarsh Thakkar devarsht@ti.com wrote:

> Hi Tom, Anatolij, Simon,
> 
> On 22/02/24 18:38, Devarsh Thakkar wrote:
> > This adds support for simple-framebuffer reservation using video handoff
> > when splash is enabled at SPL stage.
> > 
> > Also adds helper function to only enable framebuffer reservation without
> > enabling simple-framebuffer in case user want to continue display
> > bootloader splash without displaying anything else in between until
> > kernel boots up.
> > 
> > Lastly, it enables above support on AM62x.
> >   
> 
> I saw a RB on first 3 patches so just wanted to check if it looks good to you
> too then is it possible to pull in the first 3 patches if no further comments ?

patches 1 to 3 applied to u-boot-video. Fixed build errors with patch 3.

--
Anatolij
