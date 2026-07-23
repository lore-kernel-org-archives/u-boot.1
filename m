Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 160A9C4452B
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 11:22:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0E43780FB5;
	Thu, 23 Jul 2026 11:22:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o0ZdfCTkpbmu; Thu, 23 Jul 2026 11:22:30 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E79E780FAE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784805750;
	bh=7cPN/CJ3i2UJD1gvJqqQV7WT/Olqb4s4x1ssuc0Y9LU=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ixRLwfigLvfb2ca/r3FtcfbMAhI+2w6Sy1etcdjaI4T2l+rE07tOQjj1hvwdg10Ev
	 KVGYtQLil3V8SBHeB1Nh3b7ErIUGyJHmQZnaGP+EJCe+Y2beJiGK8ZKeIAtmyh7PoU
	 zOq4/29Gsw/4cfb3rynqQoe1DupJuN5JJGs7OtyUEPJNHz+/hZI1BBeLD3HxMdZfkv
	 SVOng+XwuyZao30GBCG3c/dVRq7Q+veVkuIMMQNNPtOLe2N6WqLUTETm3XKygLv9T5
	 z6864xsXy2o60tLeNmQ7oYKgtIjLtzLoSSh9fmWPAoowkurX6po4k4LY7pD2aJMO9v
	 nu/+aD24h58tA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E79E780FAE;
	Thu, 23 Jul 2026 11:22:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6D492707
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 11:22:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5409040944
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 11:22:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TXa_9t_Vp6LY for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 11:22:27 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=153.92.25.144;
 helo=mail-d15.seohost-mail.eu; envelope-from=krzysztof@kd-solutions.pl;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 81D504093C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 81D504093C
Received: from mail-d15.seohost-mail.eu (mail-d15.seohost-mail.eu
 [153.92.25.144])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 81D504093C
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 11:22:26 +0000 (UTC)
Received: from 83-168-76-203.static.ipv4.korbank.pl ([83.168.76.203]
 helo=[192.168.1.202])
 by h74.seohost.pl with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
 (Exim 4.99.3) (envelope-from <krzysztof@kd-solutions.pl>)
 id 1wmrVQ-0000000FdWH-2acW; Thu, 23 Jul 2026 13:22:24 +0200
Message-ID: <086d67e8-021a-4cca-83fe-281502142339@kd-solutions.pl>
Date: Thu, 23 Jul 2026 13:22:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] power: regulator: ADD PMIC PF9453 support
From: =?UTF-8?Q?Krzysztof_Drobi=C5=84ski?= <krzysztof@kd-solutions.pl>
To: Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>
Cc: u-boot@lists.u-boot-project.org
References: <20240930035531.27079-4-peng.fan@oss.nxp.com>
 <b80b20b3-1d30-4a2e-81c0-d974f91f48c7@kd-solutions.pl>
 <CAOMZO5D-8Ti+j3fUBAztkFY7wYZJsLcDQaFmcvH6cSgPXB23tQ@mail.gmail.com>
 <57257091-5b3e-4249-b7ba-b7d0a7699d51@kd-solutions.pl>
Content-Language: en-US
In-Reply-To: <57257091-5b3e-4249-b7ba-b7d0a7699d51@kd-solutions.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: krzysztof@kd-solutions.pl
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; 
 d=kd-solutions.pl; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 References:Cc:To:From:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7cPN/CJ3i2UJD1gvJqqQV7WT/Olqb4s4x1ssuc0Y9LU=; b=KvwcVHV1rlr4e2aRvDqp7mUbvj
 u3cAbBU9mM7cV2u208ms/7FWyhhGiowlA2AQj8Z4kEspzYMy69Aj8yyy5o+csTtgk+JzapLrW7Ac6
 3G4bfXNwUHTBx1wO59NudfxKfWbC7kW2+UDtH9WWYfguZjlnGwmzXKmHEW1uxElHuKwu537zyqQ6b
 i/r2sPgqRvGWs+qvsj31b8Yw91RahRUMOz8q+E9I1Ei+pCsjl3qOp7VsQ56BxB4IwmHWyCrpLUNwj
 ZbyQrzMSZ/8Pr8tZLtmKQZxsDp3IYH0O7Taln4sOqIT0xy15sC+e1KIoqGysvbMcfS3CcfX0upWxf
 L0YELI8w==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kd-solutions.pl
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kd-solutions.pl header.i=@kd-solutions.pl
 header.a=rsa-sha256 header.s=x header.b=KvwcVHV1
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

> Hi Fabio,
>
> W dniu 21.07.2026 o 13:47, Fabio Estevam pisze:
>> Hi Krzysztof,
>>
>> On Tue, Jul 21, 2026 at 7:59 AM Krzysztof Drobiński via U-Boot
>> <u-boot@lists.u-boot-project.org> wrote:
>>> [1] is required to fix PMIC access on u-boot 2026.07 then both [2] and
>>> [3] works fine for me.
>>>
>>>
>>> [1]
>>> https://github.com/kd-solutions-pl/rozalin/blob/main/meta-rozalin/recipes-bsp/u-boot/u-boot-rozalin/imx91sfrdm/0011-power-Fix-access-to-LDO-SNVS.patch 
>>>
>>>
>>> [2]
>>> https://lists.u-boot-project.org/pipermail/u-boot/2024-September/566287.html 
>>>
>>>
>>> [3]
>>> https://lists.u-boot-project.org/pipermail/u-boot/2024-September/566288.html 
>>>
>> Care to resend these patches?
>>
>> Thanks
> Sure, will do

I don't have possibility to test entire patch series which covers also 
PF5300 there. I assume, I should create new patch series covering only 
rebased and fixed PF9453 support?

