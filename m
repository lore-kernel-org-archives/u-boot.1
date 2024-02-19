Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E889C48260
	for <u-boot@archiver.kernel.org>; Mon, 19 Feb 2024 04:04:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7464787DB1;
	Mon, 19 Feb 2024 05:04:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="KGORmm8h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7896F87EAB; Mon, 19 Feb 2024 05:04:19 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64F1F87EAD
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 05:04:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41J43wnk010308;
 Sun, 18 Feb 2024 22:03:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1708315438;
 bh=QkkkjYB2Q8bVWKpndJMPyGsgIPnmHnCjK+lPwHVo2So=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=KGORmm8hOkJ1u3RdfoQnC++luLUVULTbQV4fO7CpmXSASB8toseV1fSyehZjFf7DI
 OGbjxi2V+Y9gVg066R+UxW0oN4mzm1/x+eW10Agnux0CGy37Mh2cFHNjbROa9DVbFq
 Rdj1Vo9PN+KzTggnLlDv6MBZx3s0FZSzW+42hy/U=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41J43w3R029946
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sun, 18 Feb 2024 22:03:58 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 18
 Feb 2024 22:03:58 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 18 Feb 2024 22:03:58 -0600
Received: from [172.24.227.36]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41J43pcR105712;
 Sun, 18 Feb 2024 22:03:52 -0600
Message-ID: <946b3c48-e9e3-4a9d-b5e3-31bf954cc45f@ti.com>
Date: Mon, 19 Feb 2024 09:33:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 12/16] arm: dts: Introduce j784s4 u-boot dts files
To: Nishanth Menon <nm@ti.com>
CC: Apurva Nandan <a-nandan@ti.com>, Hari Nagalla <hnagalla@ti.com>, Lukasz
 Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>, Andrew Davis
 <afd@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>, Dasnavis Sabiya
 <sabiya.d@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Aradhya Bhatia
 <a-bhatia1@ti.com>, Bryan Brattlof <bb@ti.com>, Christian Gmeiner
 <christian.gmeiner@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Roger Quadros
 <rogerq@kernel.org>, Jayesh Choudhary <j-choudhary@ti.com>, Ralph Siemsen
 <ralph.siemsen@linaro.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, <u-boot@lists.denx.de>,
 Sinthu Raja M <sinthu.raja@mistralsolutions.com>,
 Udit Kumar <u-kumar1@ti.com>
References: <20240119175043.3904751-1-a-nandan@ti.com>
 <20240119175043.3904751-13-a-nandan@ti.com>
 <20240119191743.xtxtuhnmhw7eq662@bonus>
 <f7cd5cbe-7c14-429e-b5c1-9f994f3ea4f7@ti.com>
 <20240123205255.i7eynu6vdpoxwybf@irregular>
 <d7298f55-c565-457b-a9b5-52980ae63f1e@ti.com>
 <20240216155838.nccgrnojkzxkdacq@riverbank>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20240216155838.nccgrnojkzxkdacq@riverbank>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Hi Nishanth

On 16/02/24 21:28, Nishanth Menon wrote:
> On 14:33-20240215, Neha Malcom Francis wrote:
> [...]
> 
>>> if the templates are abstract enough, the additional code will be so
>>> minimal that we wont need a board-binman.dtsi - just u-boot.dtsi and
>>> r5.dtsi can include the relevant templates.
>>>
>>> Hope this helps.
>>
>>
>> So I took a stab at working on this for couple of days, a fix was needed
>> within the tool to allow binman to handle multiple consecutive templates
>> which is needed here etc. which is why it did not work as is; but the built
>> binaries are still not stable for boot. I think this will need some
>> additional work and debugging. As of now, templating is not widely used, so
>> I'm guessing some more minor fixes would be needed to get it building as we
>> intend.
>>
>> If you are okay, I think we can take this series as is for now, I will take
>> action to start off a series cleaning up and using templating for all the
>> devices.
> 
> Sure, as long you can do this by the next window.
> 

Will do, thanks!

-- 
Thanking You
Neha Malcom Francis
