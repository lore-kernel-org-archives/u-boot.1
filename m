Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86A98C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 12:14:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7038487509;
	Wed, 20 Dec 2023 13:13:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ARbPabiM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4C56807D9; Wed, 20 Dec 2023 05:48:01 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A13768753C
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 05:47:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=danishanwar@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BK4lncL108398;
 Tue, 19 Dec 2023 22:47:50 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1703047670;
 bh=IAQAiNZUj1aAyj6FV/3QSicAFgKAwst6ZOirlu7nf+E=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=ARbPabiMJ/i1wtlL5QKgpius3i2rpGKZeuN8vT/aocTS6x45QwKWecdhKbXajvpRc
 NT02k3kDxf/IUxQtNFn9iw5ikL/IlWw0GLcOhKX/L0GZmAYTRCQ2CwI+PPBfCcXnY4
 xqdZ2i1OYEZqsKkGSaK5Gl/KWnY3JqTxOK3UuIuQ=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BK4lnK5114229
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 19 Dec 2023 22:47:49 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 19
 Dec 2023 22:47:49 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 19 Dec 2023 22:47:49 -0600
Received: from [10.24.69.31] (dhcp-10-24-69-31.dhcp.ti.com [10.24.69.31])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BK4liAm076871;
 Tue, 19 Dec 2023 22:47:44 -0600
Message-ID: <8a4fe530-370d-469c-a518-f52b3e65658d@ti.com>
Date: Wed, 20 Dec 2023 10:17:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 10/16] arm: dts: k3-am65-main: Add ICSSG IEP nodes
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
CC: Maxime Ripard <mripard@kernel.org>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>, Nishanth Menon
 <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Matthias Schiffer
 <matthias.schiffer@ew.tq-group.com>, Kamlesh Gurudasani <kamlesh@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>,
 Ramon Fried <rfried.dev@gmail.com>, Joe
 Hershberger <joe.hershberger@ni.com>,
 Simon Glass <sjg@chromium.org>, <u-boot@lists.denx.de>, <srk@ti.com>,
 <r-gunasekaran@ti.com>
References: <20231219103418.3445886-1-danishanwar@ti.com>
 <20231219103418.3445886-11-danishanwar@ti.com>
 <20231219174601.GA2513409@bill-the-cat>
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <20231219174601.GA2513409@bill-the-cat>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Wed, 20 Dec 2023 13:13:44 +0100
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

Hi Tom,

On 19/12/23 11:16 pm, Tom Rini wrote:
> On Tue, Dec 19, 2023 at 04:04:12PM +0530, MD Danish Anwar wrote:
> 
>> The ICSSG IP on AM65x SoCs have two Industrial Ethernet Peripherals (IEPs)
>> to manage/generate Industrial Ethernet functions such as time stamping.
>> Each IEP sub-module is sourced from an internal clock mux that can be
>> sourced from either of the IP instance's ICSSG_IEP_GCLK or ICSSG_ICLK.
>> Add the IEP nodes for all the ICSSG instances.
>>
>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>> ---
>>  arch/arm/dts/k3-am65-main.dtsi | 36 ++++++++++++++++++++++++++++++++++
>>  1 file changed, 36 insertions(+)
> 
> What's the status of all of the DT side of this, upstream?
> 

All of the DT patches are already part of upstream linux kernel except
for patch 08/16. This patch is currently in linux-next and will be in
linux in 6.8-rc1.

-- 
Thanks and Regards,
Danish
