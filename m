Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DC20C35FFA
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 23:54:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3522809D4;
	Thu, 20 Mar 2025 00:54:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1742428464;
	bh=93sMyiAvVgyR4bOiTyP1BtMl5FUiOCnullrCf9M6Eqo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xhL0bFHSHZYNvkPluhdovUopTnjUh/NnWkbCKEuB3PRHM63Fn719AAX0FsfbWDmMp
	 Yz0hdIGxP9iVjrgFeucmyBjkqMs7L6Lqtqkdb9SGHwZRz9PeeL25tQhjyrIGp8bInS
	 WI1br9Wy0cExO3GAQdoyG3O1gLppuEDSneXRh6vjxRwfCZOHoEozHxrOcAf0irJXCj
	 mBp2R9IaXjLRbPQYAE4g5SmSsJZ6Z1QeBCeiuvWgm55VUZEPH/0KaQH8BOZssjGxK0
	 p3SFwkEAQWr5Npjc5PUkptbBqVZ8jZte+yO99eZl2pqCiehDUaWc8YQ9eVeaE2CXVT
	 a/qDhgi851jzQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A63C809D4; Thu, 20 Mar 2025 00:54:22 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 647788083E
 for <u-boot@lists.denx.de>; Thu, 20 Mar 2025 00:54:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="BY882u2o"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 4CB18101E91CA; Thu, 20 Mar 2025 00:54:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1742428458; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=93sMyiAvVgyR4bOiTyP1BtMl5FUiOCnullrCf9M6Eqo=;
 b=BY882u2oKqZqHphyA9GSPwUSF3Ka6Fec5Mq00/cSM20jDdyWydQkKqj/RD5OX/7rKJxEe/
 7sohMFdtWa4yISQCfvbo92EVUSKcE5ol4zLoPTo8QKZaPOgG/QxdtQ8d81cgp+RPENvluC
 sPMttyGbkMw7kYWW2FAXL+N9PYXWg274feK/NVAA759IMjsvbFWhCGHvJ79po5DwMxJA5P
 UrdGbJE7XWDcZNlfXbyBYmR7kqWUh6bX4rZNFwFrnrnw3H9pDPm8sUYqlGIxZl02CNC0gE
 kwXn+g8QCcH3iUQAhNdpTI3YUbNpRulyOSLHcZiWL5/7YYpEGbCo/IV5wnUr3Q==
Message-ID: <f71762e5-ba15-43ec-91a3-dbdc8f8e1437@denx.de>
Date: Thu, 20 Mar 2025 00:54:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] binman: Fill in most of the imx8mimage and imx8mcst tests
To: Fabio Estevam <festevam@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List
 <u-boot@lists.denx.de>, Brian Ruley <brian.ruley@gehealthcare.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Rasmus Villemoes <ravi@prevas.dk>, Tim Harvey <tharvey@gateworks.com>
References: <20250105203714.158480-1-marex@denx.de>
 <1b77dd3f-e0f3-492b-981f-1dc9962f1732@denx.de>
 <CAFLszTha01kuuPwz0PnbuwvVqv40UDd8mrEsZBeL=z=6k0=ZDA@mail.gmail.com>
 <d9a39908-b614-438c-bfc8-34027a27db72@denx.de>
 <CAFLszTi0BQwyxOaMFCbgRAzFyBtcY__bXjAHkqZECLRJNW4-ng@mail.gmail.com>
 <ff692c58-76fd-432d-a73c-191e6e753d9a@denx.de>
 <CAFLszTgHHtNzPONVhz4ZrsZqUb2Cz+CeaaNpggYpUx93=TwdRQ@mail.gmail.com>
 <cc2896cd-eb08-4c26-b86c-a4f37ccf70b5@denx.de>
 <CAFLszTh6f8efphOYgv7wMU=z6zt0E=uiG6RK5O8hE=q1WtEhhQ@mail.gmail.com>
 <dc010565-03b3-48f6-85e8-1b79e17be14d@denx.de>
 <CAFLszTjcdFKn2ayTrLx930b+P5ebBfX_EE8-aS8sOJTBsqQKHQ@mail.gmail.com>
 <8647abd3-9378-42cf-a1fa-302c7891d439@denx.de>
 <CAFLszTiw01KB4ipwqi1b64A4MP3SyU=zFRymV4moiJ_nBtnHRw@mail.gmail.com>
 <a05cf63b-820d-4b27-8f66-37a6e6c7b372@denx.de>
 <CAFLszTgF+g2OXz=L=r7rOQcNkk19GfdCrwixG8ZAsR=1rh9Fqw@mail.gmail.com>
 <f1e4014e-658b-4a47-af8d-72ef76c1b134@denx.de>
 <CAOMZO5B7cxEftN0TeTF--pKXqOmbmaFLc9mEPO4=8odrLBeypQ@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAOMZO5B7cxEftN0TeTF--pKXqOmbmaFLc9mEPO4=8odrLBeypQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 3/12/25 1:41 AM, Fabio Estevam wrote:
> Hi Marek,
> 
> On Fri, Mar 7, 2025 at 2:42 AM Marek Vasut <marex@denx.de> wrote:
> 
>> So what should we do about this particular patch ?
>>
>> Should this be applied ? Rebased ? Updated somehow ?
> 
> This patch causes a CI error:
> 
> https://source.denx.de/u-boot/custodians/u-boot-imx/-/jobs/1057151

I think this might be what Simon was pointing out, but I never got any 
suggestion how to solve that.
