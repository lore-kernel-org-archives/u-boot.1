Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D601FC4332F
	for <u-boot@archiver.kernel.org>; Sun, 29 Oct 2023 15:11:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B540187C8D;
	Sun, 29 Oct 2023 16:09:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1698592192;
	bh=CVVrIe/PWy9/xGDpT+cZGpfXFwLHJqXn9ScZ/uxq3jA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yuBXvBlhytqXpFwGtdm0bQXojiNFxmCOjys8uZNodAukaq7FzPhNXw5dpb/wxzk/w
	 JW16LhYEeqTn1BXJlQvxhmbOocSLw7Pr36T50WBGoz2i1o1ekP6LYnqL9kwkQYZ97z
	 oKNR/8Fm3EE2UsIkaYgey6dDwuPX1u5yvYLB4DqsUPISJpmykdJ3ypiZLCP+zAHrjq
	 U/vkvZgSvnWrQ0QJT9TcqcE268pMInamf9SiwLtxW/NUND3EPTK/BrZlb42Aaf5J+7
	 mFbn+ckEokHpuzGXZlrL1Vuz9PKFfDPZgysZOmzQLlC3z8yQosQvluVAQXtaj/jhoQ
	 Tt9qza0KB7V2Q==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 934B287949;
 Sun, 29 Oct 2023 16:09:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1698592185;
 bh=CVVrIe/PWy9/xGDpT+cZGpfXFwLHJqXn9ScZ/uxq3jA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=jP5cqF6F3hr7IFlhdM2B45j/g4aeMa7yu8ZgRwQihWsvhmGKKZ2ca5pq9D5XtLAKv
 cX12237p++4OeopqWatQeoakjRObHZdE03yFfa99+ceU2++rH4EgGP3m/B2/NjONsW
 4XjLo/VD4EByOaWd0qh+QKAxRKAFrmCA+3YOmck7B7+KshI/yWk/iIYwjar8p/Xcb1
 raL8sk+Duwm/gtxZND+kh0ITrQnoMQ3nwFr3I3vIyg57H5LYpSRXdwRg7t6MyU6gOB
 66qzjwG/wBZiFAcC0mtOhp4fMRUwOJH7N072qN0+hE9xppRM5zbNCTIZXx19chW2/K
 S0KEiJe+pT9tw==
Message-ID: <cd81b46a-7d47-4e51-a92b-ad44b889137e@denx.de>
Date: Sun, 29 Oct 2023 15:33:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] usb: xhci: Better error handling in abort_td()
Content-Language: en-US
To: Hector Martin <marcan@marcan.st>, Bin Meng <bmeng.cn@gmail.com>
Cc: Mark Kettenis <kettenis@openbsd.org>, Neal Gompa <neal@gompa.dev>,
 u-boot@lists.denx.de, asahi@lists.linux.dev
References: <20231029-usb-fixes-1-v2-0-623533f6316e@marcan.st>
 <20231029-usb-fixes-1-v2-2-623533f6316e@marcan.st>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20231029-usb-fixes-1-v2-2-623533f6316e@marcan.st>
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

On 10/29/23 07:37, Hector Martin wrote:
> If the xHC has a problem with our STOP ENDPOINT command, it is likely to
> return a completion directly instead of first a transfer event for the
> in-progress transfer. Handle that more gracefully.
> 
> We still BUG() on the error code, but at least we don't end up timing
> out on the event and ending up with unexpected event errors.
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>

Reviewed-by: Marek Vasut <marex@denx.de>
