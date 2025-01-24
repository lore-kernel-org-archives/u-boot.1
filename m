Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 388AAC02181
	for <u-boot@archiver.kernel.org>; Fri, 24 Jan 2025 15:27:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4977680CF4;
	Fri, 24 Jan 2025 16:26:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1737732391;
	bh=ai+MHojJv4tcV3iMQsJBC0d2wva2lhu/lVWtGnuKgjc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=j/c8SjZiD+SEYXG7MtqGdlzN+KF8KKWuNOQ63fINSSFgMqmZWdHQM2dhTp+oNto5b
	 PVvOCoyxRhFupFeSmvsrdOQcri0YmPhjoi6kwxvXufgYQHx98XKOwTR8PG0J9U4JKO
	 7MHQuptj60cJf8oAKuMTPu9Uwl+Me9/Wf23pjMHKLUsZkj14QDPHdxtOTOCaxnzP/5
	 EvCFm9JVGk38JrbJf8WflyC7oTAsRZGsGxCe49NeJZhhoFy7ZWuU83jGS9E2IV1C34
	 VITqkNQoZeTsu4Ho0DwvyZMlFmIl6FDmopLpF2F1uIBq5y5Q7XPp4jXnUPL4R8XNdK
	 f8HcVsW/QylzA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8C8E80C75; Fri, 24 Jan 2025 16:26:27 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00743809D2
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 16:26:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="WAKx/apv"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 9FE47108860C0; Fri, 24 Jan 2025 16:26:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1737732385;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ai+MHojJv4tcV3iMQsJBC0d2wva2lhu/lVWtGnuKgjc=;
 b=WAKx/apvA47v3xu/l/sS3hOYGQxiWgZ0YqJoYyTtzTElFbdBmqv4gYgsAii+J/UixAWFxU
 gyFmv2D17+tXkGxHmNoOp/+UxhgfbZsBMbUuRD9WGVXpUpF1q+f1Uq6JcgBELFhZOcMOuB
 H+U8xuboQA6Iyn+4HJmQFftU5bi+ahwUxSo8CpRmreUAMt/hqpk0D851GCndiLccDY1ttL
 fEI7x1QEfeigIMl+aI+P6o+sMRtNHbJ6iH/fBazb1oXYhghBCJnYLMP8WrIjns9xp0Tazj
 dCL0qjV6Hd24++MiIqT8Ffppxvqm8R93xZwFxlLZ2LvJ/okpTBVHlyGa0oRRIA==
Message-ID: <87a3b8aa-d97b-41c1-9a12-2c876244b81d@denx.de>
Date: Fri, 24 Jan 2025 15:42:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 13/20] spl: imx: use trampoline buffer to load images
 to secure region
To: Alice Guo <alice.guo@oss.nxp.com>, Tom Rini <trini@konsulko.com>,
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: u-boot@lists.denx.de, tharvey@gateworks.com, Alice Guo
 <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>
References: <20250115-imx95-v1-0-93b28a514dea@oss.nxp.com>
 <20250115-imx95-v1-13-93b28a514dea@oss.nxp.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20250115-imx95-v1-13-93b28a514dea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 1/15/25 2:29 PM, Alice Guo wrote:
> From: Ye Li <ye.li@nxp.com>
> 
> When SPL loading image to secure region, for example, ATF and tee to
> DDR secure region. Because the USDHC controller is non-secure master,
> it can't access this region and will cause loading issue.
> 
> So use a trampoline buffer in non-secure region, then use CPU to copy the
> image from trampoline buffer to destination secure region.
There is already common/bouncebuf.c , can you instead implement 
something similar, which would behave as a generic bounce buffer, except 
for the secure/nonsecure regions ?

The region configuration could come from DT or maybe from firmware ?
