Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0F88CFB43F
	for <u-boot@archiver.kernel.org>; Mon,  7 Oct 2024 12:16:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A79B488D3A;
	Mon,  7 Oct 2024 14:15:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1728303351;
	bh=uHDAgthmv4Zs7BGXOIPJLErRqJwpM8VztKcbf3hWI1I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YXGxlc4D3x3h13XjRoV9d6wnHKwnHl0FrsZ96Sv810n3m4nXHBATHZOLjsM2hYZ3o
	 gAj8XetcDQqrOSLmyrDeqDhdaaC24E21oF3AlDisTBf97E8NnabAiOSouUdkJlAVsT
	 tPVWTItryagMw5aFxuNjdepGJGlRbi3IJgIhXIRmkzC/cSat9pYL4hFXob+f/zbYlE
	 +2HkGaf+mhCBGfcEr5dJYNEP5TKSwAAoPRVpPX4Y5/x4j7n3hvG3bdf+FPLE26ruhw
	 WneTWW95Pgz4hT0eKVfqglG8So19OOnjjIR57Fyi5adV+aXA/fXQzamMrf8XHXqfRS
	 2OFfKoeJn0VVQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 2CF1588B11;
 Mon,  7 Oct 2024 14:15:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1728303349;
 bh=uHDAgthmv4Zs7BGXOIPJLErRqJwpM8VztKcbf3hWI1I=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ofOncqWS5b1BgzXIju0cA12zG3eBU0ucUilUovkP8wj5ZJ5fI1NWwqFbc4BMiHF9C
 jIg3OaPKay6h6wEHcoObJfQQ+VjmTCbWZtvpWIe3LbVm1vEFnDbD4SLIUsUsKOfwUu
 vgVjDUSEcFWkLUe5SRch0wJxEzfTqdbfVXkcesPbcIXWC1jaPJQgN3IXfogiy/sYEX
 glbtlrT0Ty9vJlxOCuv9l2q/eEyoZ6m1dTMfpsLRYQsmIworwQD/xowQQa4imYW5UM
 FjIQy3H/ULshysXgd9hs1P65sqKlqcv/aoRz/c1eOFD5KHf3ZHQQn76sX2H5yC5bSE
 auLi1j9/+Cslw==
Message-ID: <306e2498-8b20-4189-bfb4-14dcbc020bce@denx.de>
Date: Mon, 7 Oct 2024 14:09:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/7] usb: onboard-hub: add support for Microchip USB5744
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: michal.simek@amd.com, fabrice.gasnier@foss.st.com, git@amd.com
References: <20241007044547.23896-1-venkatesh.abbarapu@amd.com>
 <20241007044547.23896-4-venkatesh.abbarapu@amd.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20241007044547.23896-4-venkatesh.abbarapu@amd.com>
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

On 10/7/24 6:45 AM, Venkatesh Yadav Abbarapu wrote:
> Add support for the Microchip USB5744 USB3.0 and USB2.0 Hub.
> The usb5744 driver trigger hub reset signal after soft reset.
> The usb5744 hub need to reset after the phy initialization,
> which toggles the gpio.
> 
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Reviewed-by: Marek Vasut <marex@denx.de>
