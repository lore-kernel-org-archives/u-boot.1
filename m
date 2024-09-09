Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 162D4ECE588
	for <u-boot@archiver.kernel.org>; Mon,  9 Sep 2024 19:39:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9676388E14;
	Mon,  9 Sep 2024 21:39:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1725910759;
	bh=bb4c55rGQIJCIpTpnINhsMaD0QNBm6Tz3OqaWAStoB8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xMO4gDtz8FNxhpGfJHw8HKXOO1odppAYAid0xAGv+IHFm4C1juoS0vDhvBAc7R4+O
	 qC+/Fn3DdSXg6EJlLgUhe4LxGd2dsMOCEkL0ftvFuT4q2zdvEG7EhgYTONkrONqVxt
	 O2mtMujLRxqD6vYeJIZ0X4KPIXADlLQyWqRmNgTZ8SWI3U3Wg1Uczpv0WdrFruf0PJ
	 lNEqJf1KFcpBg7JhPtGiab9Ux9EpqiprmPSSjin1fgDwdxUaIubyHYYjBCrhbouMsY
	 avxlw/5XcSk8rolrQt3Ibn6tBjuUcaD963pRUMyk9iaCkFwBAc4HBaIsn0Igm2tfb6
	 JoKuK6umEYknQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 651A588AE8;
 Mon,  9 Sep 2024 21:39:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1725910758;
 bh=bb4c55rGQIJCIpTpnINhsMaD0QNBm6Tz3OqaWAStoB8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=MjPq30C3Y/JNtiQV6SGBvgOEIJZiZWyqW/yRLy9xPGqTJmB6hbygN3yx8mOhQzIx3
 V8Diw50bDYQGqzZGWNCyS2hI1xL22xJnwd476SwIys/E9muhlaj12t/XbL8KT2M8kG
 hSIrqkjWmeVErrV1DjWRJkV70IyVAtMbwn5v277SlxsVJT2poMHpYQRXGQyolo4pIG
 udZxGOjU+QEol7WD9BljXeqI/TRHbUfhGOedyMYPluugvw4otAp3sKrcx1V/KCOMXC
 9P0bur9lFootZ9dAssskhbjlvhC74veGtl7nzu2Gpks0eRW87Em3Gc0/d2WHmM5ouD
 lCU7fbUklL6iQ==
Message-ID: <6646e398-269d-4619-afc0-c75c078c793c@denx.de>
Date: Mon, 9 Sep 2024 21:39:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: imx8mq_evk: Boot regression
To: Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Ye Li <ye.li@nxp.com>
Cc: U-Boot-Denx <u-boot@lists.denx.de>,
 Otavio Salvador <otavio@ossystems.com.br>
References: <CAOMZO5DT5-dtAF1cDbga3vjtk1UakQin1XboPyjmG=-h3-808g@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAOMZO5DT5-dtAF1cDbga3vjtk1UakQin1XboPyjmG=-h3-808g@mail.gmail.com>
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

On 9/9/24 9:11 PM, Fabio Estevam wrote:
> Hi,

Hi,

> imx8mq-evk fails to boot with top of tree U-Boot:
Could it be the HDMI blob handling ?
