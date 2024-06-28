Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49CA0C2BD09
	for <u-boot@archiver.kernel.org>; Fri, 28 Jun 2024 16:26:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B5AF88453;
	Fri, 28 Jun 2024 18:26:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=jookia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jookia.org header.i=@jookia.org header.b="u3UYXyEI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 500DC884A7; Fri, 28 Jun 2024 18:26:24 +0200 (CEST)
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com
 [95.215.58.175])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA94588453
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 18:26:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=jookia.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=contact@jookia.org
X-Envelope-To: andre.przywara@arm.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
 t=1719591980;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vIEJUtyps22L/8Fpr/01eDismdgL4mQdm7e5Jg5rPD0=;
 b=u3UYXyEIytklaoQqSnAfOlXbmqQduYbvjN8B8vxK8RlZp6yRdxD2bzaVldayovc+xJWpwx
 Hl/xSAF3uvUJyq//VXNxJx5EXVKhKGqmoLQPudY3HsoyWnBNLY/+NNDe/QVspU5Bkft4o7
 vwvnHgfYGjEZF/dwnSi26Voo+N71JFbz6aCLSBPK58K1RsGimG2vtNv2dHwIJecd+/fD1C
 DRSomrjRiCc43B4n/d7DDmZy602i9ISfbldo4Z/BQzANW+7G61OcG6LePI0i8eLs0np/fr
 Tko6Gkl7fRSx/30BmqbArN6oWHSMVFI3vhck2EGrc2H7Drpp/MoYUQrpjBmtpg==
X-Envelope-To: cfsworks@gmail.com
X-Envelope-To: u-boot@lists.denx.de
X-Envelope-To: jagan@amarulasolutions.com
X-Envelope-To: marex@denx.de
Date: Sat, 29 Jun 2024 02:22:14 +1000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: John Watts <contact@jookia.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Sam Edwards <cfsworks@gmail.com>, u-boot@lists.denx.de,
 Jagan Teki <jagan@amarulasolutions.com>, Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v2 2/2] usb: musb-new: sunxi: make compatible with UDC/DM
 gadget model
Message-ID: <Zn7jNspTDhqJtZp9@titan>
References: <20230608195631.55364-1-CFSworks@gmail.com>
 <20230608195631.55364-3-CFSworks@gmail.com>
 <20240627160639.2353fd1e@donnerap.manchester.arm.com>
 <9716fa71-d010-4444-979f-d120c558426c@gmail.com>
 <20240628161727.5a2f6333@donnerap.manchester.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240628161727.5a2f6333@donnerap.manchester.arm.com>
X-Migadu-Flow: FLOW_OUT
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

Hi,

On Fri, Jun 28, 2024 at 04:17:27PM +0100, Andre Przywara wrote:
> > I do not know if this patch is still a 
> > necessity; though if John is nudging about it, it probably is.
> 
> Yes apparently he needs it, though I am not entirely sure why.
> USB gadget has worked for ages in sunxi, without DM_USB_GADGET support,
> that's why I was a bit puzzled why this patch seems so important.
> 
> And secondly I was put off by John's initial reply that it would trigger
> many USB errors for him. He later rectified it, but I must have missed
> that message.

This patch is necessary for gadget to work on the T113 board I have.
Without it I get this error during fastboot:

Controller uninitialized
g_dnl_register: failed!, error: -6

John.
