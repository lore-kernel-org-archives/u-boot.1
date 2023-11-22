Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDA09C61D97
	for <u-boot@archiver.kernel.org>; Wed, 22 Nov 2023 15:16:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC08E87253;
	Wed, 22 Nov 2023 16:16:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="fNwrZKsd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4925686FB5; Wed, 22 Nov 2023 16:16:14 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0021887608
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 16:16:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AMFFwmq087743;
 Wed, 22 Nov 2023 09:15:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1700666158;
 bh=PD0HfNRTOIC0jTUzwEjIFyX3jUEovJbEsNhaNCINVnc=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=fNwrZKsdtw7B9QJajnjzoYzsN8MUnEpr4IjnpP6YcOY3C6IUotYMT8HCgBdi/z3pt
 Mg6goASzeV2YWDO7019mNIeBXJdZk5UeeKZW74zTH2oSLyqnxWcqUrrdqvOgtkuzvc
 DRphfAUZd8ISZRP0Da+/OK1VB+/EPuuljkQ2Kqew=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AMFFwvp067689
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 22 Nov 2023 09:15:58 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 22
 Nov 2023 09:15:57 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 22 Nov 2023 09:15:57 -0600
Received: from [10.250.36.5] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AMFFuSd060622;
 Wed, 22 Nov 2023 09:15:56 -0600
Message-ID: <6dd26c33-1ac9-455c-adfd-a2fdd9e2bf71@ti.com>
Date: Wed, 22 Nov 2023 09:15:56 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/16] arm: mach-k3: Add basic support for J784S4 SoC
 definition
Content-Language: en-US
To: Nishanth Menon <nm@ti.com>, Apurva Nandan <a-nandan@ti.com>
CC: Hari Nagalla <hnagalla@ti.com>, Lukasz Majewski <lukma@denx.de>, Sean
 Anderson <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, Neha
 Malcom Francis <n-francis@ti.com>, Simon Glass <sjg@chromium.org>, Kamlesh
 Gurudasani <kamlesh@ti.com>, Dasnavis Sabiya <sabiya.d@ti.com>, Manorit
 Chawdhry <m-chawdhry@ti.com>, Aradhya Bhatia <a-bhatia1@ti.com>, Bryan
 Brattlof <bb@ti.com>, Christian Gmeiner <christian.gmeiner@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marcel Ziswiler
 <marcel.ziswiler@toradex.com>, Roger Quadros <rogerq@kernel.org>, Jayesh
 Choudhary <j-choudhary@ti.com>, Ralph Siemsen <ralph.siemsen@linaro.org>,
 Yanhong Wang <yanhong.wang@starfivetech.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>, <u-boot@lists.denx.de>, Sinthu Raja M
 <sinthu.raja@mistralsolutions.com>, Udit Kumar <u-kumar1@ti.com>
References: <20231001165545.494212-1-a-nandan@ti.com>
 <20231001165545.494212-3-a-nandan@ti.com>
 <20231002160156.pacy7j53bbtx766e@reboot>
 <b5c48875-cca0-c62f-1254-ef50307553ec@ti.com>
 <20231004180655.gqe5gcnistjv2wlt@spiritual>
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20231004180655.gqe5gcnistjv2wlt@spiritual>
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

On 10/4/23 1:06 PM, Nishanth Menon wrote:
> On 23:22-20231004, Apurva Nandan wrote:
> [...]
> 
>>>> +		.virt = 0x500000000UL,
>>>> +		.phys = 0x500000000UL,
>>>> +		.size = 0x400000000UL,
>>>> +		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
>>>> +			 PTE_BLOCK_NON_SHARE |
>>>> +			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
>>>> +	}, {
>>>> +		/* List terminator */
>>>> +		0,
>>>> +	}
>>>> +};
>>> Why not reuse CONFIG_SOC_K3_J721S2 or adopt it?
>> The mem_map regions are different for J784S4 from J721S2,
>> and on the hardware side also, i.e. J784S4 has 4x8G DDR slots,
>> so how can we bring it in same CONFIG as J721S2?
> 
> Is'nt that what device tree is for? what harm do we run into if
> we define the common super set in the common file?

Been wanting to fix that for a while now, posted RFC for it here:

https://lore.kernel.org/u-boot/20231122151411.11268-1-afd@ti.com/
