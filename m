Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 231C7CD128A
	for <u-boot@archiver.kernel.org>; Mon,  1 Apr 2024 20:41:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F03D8832A;
	Mon,  1 Apr 2024 22:41:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="oO4JSDBC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0598B882EC; Mon,  1 Apr 2024 12:13:55 +0200 (CEST)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1483C88011
 for <u-boot@lists.denx.de>; Mon,  1 Apr 2024 12:13:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cgmeiner@igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:Message-ID:References:
 In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=XuFDwjujsSTmvJ3nT9mfFyLqAsaaDvIP8AhtQX2QyGo=; b=oO4JSDBCEmxZiSm6EceifNxb9H
 8iisQWWMgn3+xL/q1BuiCRK7m62OIMHngthguHegVAd14kCMNYNU7a27HtU1ThTT+AJTiq5rhmb7r
 upvUeS7Q8zMoCjF7k9xBY6v71K+BdnjpyKchLdNJA6dEROiFSFHY/jLkSmxbyGIuUN3UAIyIQ4fu8
 fKieDFg8KPXNq0f8F+xY936LeUYQ2iLIqIY+8DYB6/eTGwXUXL/Qkqvw5Wa7YU6FUs7AAbRpUWKNW
 Yka2XBMCAEIo3DWDzcUzagPcjYoWkGJyoPHgsR8YT8THWyIphybM3nwgUd49iR9M5okEos6XduHCP
 juiOHbdw==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine2.igalia.com with esmtps 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1rrEfj-00HZld-JO; Mon, 01 Apr 2024 12:13:47 +0200
Received: from webmail.service.igalia.com ([192.168.21.45])
 by mail.igalia.com with esmtp (Exim)
 id 1rrEfh-008IaA-Im; Mon, 01 Apr 2024 12:13:47 +0200
Received: from localhost ([127.0.0.1] helo=webmail.igalia.com)
 by webmail.service.igalia.com with esmtp (Exim 4.96)
 (envelope-from <cgmeiner@igalia.com>) id 1rrEfh-005n3L-1E;
 Mon, 01 Apr 2024 12:13:45 +0200
MIME-Version: 1.0
Date: Mon, 01 Apr 2024 10:13:45 +0000
From: Christian Gmeiner <cgmeiner@igalia.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: baruch@tkos.co.il, trini@konsulko.com, josua@solid-run.com,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2] mx6cuboxi: Fix Ethernet after DT sync with Linux
In-Reply-To: <20240330213555.2889619-1-festevam@gmail.com>
References: <20240330213555.2889619-1-festevam@gmail.com>
Message-ID: <e2a4c7068920316b3d631f2db0880235@igalia.com>
X-Sender: cgmeiner@igalia.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 01 Apr 2024 22:41:06 +0200
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

Hi Fabio

> From: Josua Mayer <josua@solid-run.com>
> 
> The i.MX6 Cubox-i and HummingBoards can have different PHYs at varying
> addresses. U-Boot needs to auto-detect which phy is actually present,
> and at which address it is responding.
> 
> Auto-detection from multiple phy nodes specified in device-tree does not
> currently work correct. As a work-around merge all three possible phys
> into one node with the special address 0xffffffff which indicates to the
> generic phy driver to probe all addresses.
> 
> Signed-off-by: Josua Mayer <josua@solid-run.com>
> [fabio: Added the changes to imx6qdl-sr-som-u-boot.dtsi.]
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> Tested-by: Christian Gmeiner <cgmeiner@igalia.com>
> ---
> Changes since v1:
> - Disable ethernet-phy at addresses 0, 1 and 4.
> - Remove the fixup of the fake 0xffffff address before booting Linux.
> 
> Josua and Christian,
> 
> I got access to a imx6 humming board and I was able to test it.
> 
> This is the minimal fix I came up based on your suggestions.
> 
> There is no need to fixup of the fake 0xffffff address before booting Linux,
> as this fake address does not exist in Linux.
> 
> Successfully tested Ethernet in U-Boot and in the kernel.
> 
> Given that Ethernet is currently broken, I suggest we go with this
> version to restore Ethernet for 2024.04.
> 
> What do you think?
> 

I am happy with the patch and love the idea to fix Ethernet for 2024.04.

Tested-by: Christian Gmeiner <cgmeiner@igalia.com>

Thanks & Regards,
Christian
