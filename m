Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98167C4332F
	for <u-boot@archiver.kernel.org>; Sun, 29 Oct 2023 15:11:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39C3D8755E;
	Sun, 29 Oct 2023 16:09:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1698592192;
	bh=Xkatk2Z/5gWHc/ZSNjw1IUVXxIt1J2MN5pOe1DWP8IA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=t10CfS/9Elzk4VCxZfT5a4GLIiNJNrrzEye/Sb9C8YFO70rvd1DNr20k/yoxZKJt/
	 w1PzPD8roT9UNOOutsKKQVX7211b7ufwTOtxau23Z1FUbymng7Q+LGPUQLWd68KeGs
	 7qU/5kUw5kPHEpTwHNno7NhxKvEDJlQZ6lVXjVdN5q0h4dktsezpDw8F2XfIMSEu8N
	 WSocpnMrRfDchpcHs4E7F51o4sqzSQgZIIj4elwxxIKKRRv6BphUQyZ2G4egdUaQ7/
	 v6IY7tokXKqKgTer6VF9MhvUEoFCXKZ3s4WMTnBpVzBiV6KpaUSJTZJk5/4fTM2Awe
	 i/9850ifZO57w==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 01A6287C7A;
 Sun, 29 Oct 2023 16:09:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1698592185;
 bh=Xkatk2Z/5gWHc/ZSNjw1IUVXxIt1J2MN5pOe1DWP8IA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=GiOdl9U29wjoQcSnnKG0G13xyVxPDGyrKaCwW2m8ljOOT3OzJPV+o+LLjo69nUyEm
 Xy/qIODtDsW4/xUPo/FMqcVeqTYIBmKH64vd+UsnozE+jPqsFCHNMjE4TF6gUuCrYU
 /zmynAvTjFDqcRM9LxWHKUyOMIou6/H/LZ6OHY4TTaCAHOIfGE1ZwyJ9RdnqYZtT7o
 GChnTpHtkw4wcipRWjug8admptyGRjcu1TDNmDXM+mdtS/JV9p1l+uY3e2DF43hXrd
 oRAxin2HFkEmTkB1ylhqLASB4Sp3tonkMXMykYL4v82oOO7jqOwlcCmgyj6T0xNSRW
 Kdk/vryj708BA==
Message-ID: <a597cbed-79a1-46a6-bcb1-f40498b17545@denx.de>
Date: Sun, 29 Oct 2023 15:32:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] usb: xhci: Guard all calls to xhci_wait_for_event
Content-Language: en-US
To: Hector Martin <marcan@marcan.st>, Bin Meng <bmeng.cn@gmail.com>
Cc: Mark Kettenis <kettenis@openbsd.org>, Neal Gompa <neal@gompa.dev>,
 u-boot@lists.denx.de, asahi@lists.linux.dev
References: <20231029-usb-fixes-1-v2-0-623533f6316e@marcan.st>
 <20231029-usb-fixes-1-v2-1-623533f6316e@marcan.st>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20231029-usb-fixes-1-v2-1-623533f6316e@marcan.st>
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
> xhci_wait_for_event returns NULL on timeout, so the caller always has to
> check for that. This addresses immediate explosions in this part
> of the code when timeouts happen, but not the root cause for the
> timeout.
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>

Reviewed-by: Marek Vasut <marex@denx.de>
