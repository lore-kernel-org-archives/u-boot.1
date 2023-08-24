Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CAD4C3DA6F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 13:11:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E72986435;
	Thu, 24 Aug 2023 15:11:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1692882669;
	bh=NYh5iM+9tU9Q/n6e5tucDct/ve/cBN8lgVl5zDmdG5I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IyQVQr5aXxaPEjYU48XnWAYwCnZplXQXRcRx4IZy2tR7qxZzMGFdMx2JiSPn9W1ap
	 sOg8I6KXLFRI5EVTEfeE0SwO1dyXiijErAOyFzaBivzHhqSonPBbffT9WaSAioehok
	 FeOgxSxnXWFd1EQiEB2w0+oeK189BrU5b8hkJbvOQ2Ma2Jh3c5VMTqzqQNmECWRLeA
	 u7sZsNjr+6sNZIBVJMZzNJPKlCqjolndy8N8Dfb5trT4tfeiWDPO0pnbwe1j4CsHVx
	 Xzjpux/bRxh8PntOb3EcHmYhmh5Zogl7Z//0Aq33tOKod+ubq7EmJLCZdzGLAfHgpU
	 tNHUZjqCdhqtw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id A4C618609B;
 Thu, 24 Aug 2023 15:11:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1692882668;
 bh=NYh5iM+9tU9Q/n6e5tucDct/ve/cBN8lgVl5zDmdG5I=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=RSv+uRLZRvcdLEBDw5UFMd/UViHgDYZi1EFlAax7unRU/XZhXpYyBOaLCHTkvCCBO
 5oBByDMQes2RswDO1w+DYFJREQu5nNdTuiCum6aqrQ6WrYqz8/++s2EcVR+YpqQN2x
 9rVOEv1AtUgrLZwlOMOCifBKMAK9wCXqAqB42rsrQgILqXDJDNtXgP/XA3nMDlLBfz
 FkBkIrxjNVTJ10U/5SO89BeiXysWiO53BagOuRjehQispB+R4/zy+d3rHRcw5TwR3E
 qBcWowziNEun5jdt115aJczKLMxRv4XS9FEvtMQk8C/ph9s1oivEPiOh6XNkaoudaz
 kRlFbr2HmYUBQ==
Message-ID: <d966ce20-61d3-384d-8d66-aa8bb58a5d7c@denx.de>
Date: Thu, 24 Aug 2023 15:11:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] tools: ensure zeroed padding in external FIT images
Content-Language: en-US
To: Roman Azarenko <roman.azarenko@iopsys.eu>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: "sjg@chromium.org" <sjg@chromium.org>,
 "massimo.pegorer@vimar.com" <massimo.pegorer@vimar.com>,
 "trini@konsulko.com" <trini@konsulko.com>
References: <20230823121417.270511-1-roman.azarenko@iopsys.eu>
 <40263db2-e42a-4997-ddcc-7a1ea7d44d31@denx.de>
 <603b051b057bb632fc9213cb0abc7d2887bf2b67.camel@iopsys.eu>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <603b051b057bb632fc9213cb0abc7d2887bf2b67.camel@iopsys.eu>
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

On 8/24/23 12:17, Roman Azarenko wrote:
> Hello Marek,
> 
> On Wed, 2023-08-23 at 20:06 +0200, Marek Vasut wrote:
>> Can we use memset and zero out the trailing part of the buffer instead
>> ?
> 
> That is what I started with, but at the time the ftruncate() approach
> seemed simpler.
> 
> Now that you suggested memset yourself, I took a stab at it again. I
> think I got to the point where I'm happy with the logic, and will submit
> v2 tomorrow to give some more time if anyone else has more comments on
> v1.

Nice, thanks!
