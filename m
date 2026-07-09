Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B53FC43458
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 11:07:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E8FA84B2C;
	Thu,  9 Jul 2026 13:07:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=0leil.net header.i=@0leil.net header.b="Vs5w+fFI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43CD984B32; Thu,  9 Jul 2026 13:07:54 +0200 (CEST)
Received: from smtp-8fac.mail.infomaniak.ch (smtp-8fac.mail.infomaniak.ch
 [IPv6:2001:1600:19:5550::8fac])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1302784AB8
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 13:07:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot@0leil.net
Received: from smtp-3-0001.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:4:17::246c])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gwsd34CDLzZ96;
 Thu,  9 Jul 2026 13:07:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1783595271;
 bh=ghJsfmQWIZpVHbqhLUyWfueq0tQ6NmYoKCLDfU8zCMQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Vs5w+fFITQfsiT414DQbtXkQ/OrWsyYlzfuDgZ2BHq8KeQkwU1/f9Rr9a6xmSzB0h
 brHjtgSiVSdBa+AIM06VeEw3zyG7Qs2bbUEd1ILw2dWgtiptPw3KehQHb120awQIVT
 yKz03Vuh5Mi0y4uDWYnM3HFsoT0fPPqRZXXGPsRvf8GQQJ1D7e2XSPALNHdMYP8xsR
 /Ucr44S2RBNDLiT5aEG8JaSmc9NHaVbEALvJDBiQjwRPWmgbqVS1jsNhegdpOnCIQq
 nsiuJ3RN72pZ+crPkjLo2OLaOaEXZJfJhMglHApdhvB/6GtiJAA/2LmatwPFZnOGm6
 zmhQphR5rzOIA==
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4gwsd15Gbnz96K; Thu,  9 Jul 2026 13:07:49 +0200 (CEST)
Message-ID: <41be2c90-2036-4089-9dba-bafa74e3ac9d@0leil.net>
Date: Thu, 9 Jul 2026 13:07:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/12] MAINTAINERS: add rkmux.py to ARM ROCKCHIP
To: Johan Jonker <jbx6244@yandex.com>, u-boot@lists.denx.de
Cc: Heiko Stuebner <heiko@sntech.de>, Jonas Karlman <jonas@kwiboo.se>,
 Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Raymond Mao
 <raymond.mao@riscstar.com>, Jerome Forissier <jerome.forissier@arm.com>,
 Philip Molloy <philip.molloy@analog.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>
References: <20260707-rk-custodian-v1-0-dbc9c696e613@0leil.net>
 <20260707-rk-custodian-v1-2-dbc9c696e613@0leil.net>
 <3dbb9203-47ac-4384-8993-662c4a6002c7@yandex.com>
Content-Language: en-US
From: Quentin Schulz <u-boot@0leil.net>
In-Reply-To: <3dbb9203-47ac-4384-8993-662c4a6002c7@yandex.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Infomaniak-Routing: alpha
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

Hi Johan,

On 7/9/26 12:09 AM, Johan Jonker wrote:
> [You don't often get email from jbx6244@yandex.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> On 7/7/26 18:09, Quentin Schulz wrote:
>> It is a tool to be used with Rockchip SoCs so let's add it to the
>> MAINTAINERS entry for ARM ROCKCHIP.
> 
> Hi,
> 
> This script is more of a relict from the past.(Simon ?)
> Maybe remove it together with a clean up of README.rockchip.
> 

Eventually yes, I think it's fine for now, we can always do cleanup 
later. I don't think it hurts anyone to keep it in for the moment.

Cheers,
Quentin
