Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83B60C4345F
	for <u-boot@archiver.kernel.org>; Tue, 23 Apr 2024 13:29:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1170E885BA;
	Tue, 23 Apr 2024 15:29:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1713878955;
	bh=rhQ15saQZ2KvdBGeuJv0e9SU/UnJ3onWAVeGUOWPxrE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MAPfS1lBUv+B03LX93HCxOhdr8kMnG7DeElV7nZ1yKAsteAouFGs4wBZ26f5BvgIU
	 /f5nzq9jWIjLJx4lsi5ZolCimIU0wRm9aPNDUfQ9dZxxOmPnt3LiptpMCeSxHH0FXM
	 oMAqdKAhnQr2OKmlgfn1IRAT111cmMFCk5bKX+d1PNp+RFPCDgpYtV1XSTRsJPdy2p
	 lnq91BemBrSX+Gj7C2Chef1f/h57/Whgm2Y+3Lx8xgtBcDM0GycjL8lW39WcGCDymR
	 v6JCc5VE71oHfKwKwOU5jGjqHYelEyycEob8Dc0lzbLvxFZAkRquJZr+2bv+JVQK8/
	 cbVhT/GRkXrzQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id E23448854A;
 Tue, 23 Apr 2024 15:29:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1713878953;
 bh=rhQ15saQZ2KvdBGeuJv0e9SU/UnJ3onWAVeGUOWPxrE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Zivw3+j1JyIi3qpHn74MU+UhqlFDQic4Ea7qvb8pCSeSE6rL4xu+Bk5y6IQsYp/3T
 woBpzl3ghakCMhQtxW8OT3rOJNgj0UezPgAVe/TQi01/FFcWW55x72tXCLqX7LDDAD
 Wpx/J1zu+DO3RjSLfbQLJEjJyVf7HBRkmSbqCXFHHe4fTrJokfOlPiiHFzyQxgn2fx
 7mYiuzH42bjiGmnVVhx4BRDGVYJG/ueA+C9AdM/WQG6hyJkFYtJGYv2g9s5+hAVpWn
 uJvZREgQi1Snq6ZEomdqM1k2w7wL7RDaL446pgfkaqrlfkEgWJ9YNrOxgVJZ6af1tD
 YECDR2iorfm9A==
Message-ID: <8ba2dfe6-ea6c-4474-a574-3b29b9e377af@denx.de>
Date: Tue, 23 Apr 2024 14:53:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: cdns3: gadget.c: Set fast access bit
To: Ravi Gunasekaran <r-gunasekaran@ti.com>, trini@konsulko.com
Cc: rogerq@kernel.org, u-boot@lists.denx.de, pawell@cadence.com,
 peter.chen@kernel.org, srk@ti.com
References: <20240423082420.32336-1-r-gunasekaran@ti.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240423082420.32336-1-r-gunasekaran@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 4/23/24 10:24 AM, Ravi Gunasekaran wrote:
> From: Aswath Govindraju <a-govindraju@ti.com>
> 
> When the device port is in a low power state [U3/L2/Not Connected],
> accesses to usb device registers may take a long time. This could lead to
> potential core hang when the controller registers are accessed after the
> port is disabled by setting DEVDS field. Setting the fast register access
> bit ensures that the PHY clock is keeping up in active state.
> 
> Therefore, set fast access bit to ensure the accesses to device registers
> are quick even in low power states.
> 
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
> Reviewed-by: Roger Quadros <rogerq@kernel.org>
> ---
> v1 was posted and was reviewed as well. But it did not get merged.
> This change is present in upstream linux kernel as well.
> Upstream Linux kernel commit: b5148d946f45 ("usb: cdns3: gadget: set fast access bit")

This commit ^ should be mentioned in the commit message.

With that fixed:

Reviewed-by: Marek Vasut <marex@denx.de>

Thanks !
