Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48CDCCD494D
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 05:14:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9ABB786D04;
	Thu, 21 Sep 2023 07:14:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="DZ9VphjJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6ECA86D01; Thu, 21 Sep 2023 07:14:27 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0579D86D01
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 07:14:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38L5EL5p003808;
 Thu, 21 Sep 2023 00:14:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1695273261;
 bh=QAX23GN3g7nrPL9htyouCsqUIi5dkZqLRD/PzfFSIYQ=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=DZ9VphjJCRx1tnzBpNvErbckZsE9En0xFvGr+lYUT0wZ4OZbTbQaay3/y7eMTNjgw
 0COGJkwZttKbc7P3pXdEZzxcAMjKoE3QxxiMDK0LyJS2/Ed9cMiEW6Sdtl+wUSWB4M
 VB8WRkiFnNjVRKh/fOJcr3ag6o2SS8OZD34un9DI=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38L5ELTc002332
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 21 Sep 2023 00:14:21 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 21
 Sep 2023 00:14:20 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 21 Sep 2023 00:14:20 -0500
Received: from [10.249.141.75] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38L5EFch046256;
 Thu, 21 Sep 2023 00:14:17 -0500
Message-ID: <cf5e4159-3841-eb10-9a19-c01a19908193@ti.com>
Date: Thu, 21 Sep 2023 10:44:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3] clk: ti: Notify AVS driver upon setting clock rate
To: Nishanth Menon <nm@ti.com>
CC: <vigneshr@ti.com>, <seanga2@gmail.com>, <u-boot@lists.denx.de>,
 <lukma@denx.de>, <bb@ti.com>, Keerthy <j-keerthy@ti.com>, <u-kumar1@ti.com>
References: <20230920120256.2901860-1-u-kumar1@ti.com>
 <20230920122025.nr2dsnf663ox76p7@outdoors>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20230920122025.nr2dsnf663ox76p7@outdoors>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
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

Thanks Nishanth

On 9/20/2023 5:50 PM, Nishanth Menon wrote:
> On 17:32-20230920, Udit Kumar wrote:
>> AVS is enabled at R5 SPL stage, on few platforms like J721E
>> and J7200 clk-k3 is used instead if clk-sci driver.
>> [...]
>> I think it is better to put IS_ENABLED() as the first check.
>> See other usage:
>> $ git grep IS_ENABLED . |grep if|grep '&&'

  will address in next version

>>
>> [..]
> First look - it looks fine, but note: these are two different patches.
> the clk-sci.c is a fix for an existing implementation and clk-k3.c is a
> new feature addition. please don't mix the two.

Sure, Let me send two patches then,

One for new implementation clk-k3.c version v4.

and another for clk-sci.c with Fixes tag.

