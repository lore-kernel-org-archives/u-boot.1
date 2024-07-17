Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53FD8C3DA42
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 04:10:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B58E5885AE;
	Wed, 17 Jul 2024 06:10:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="GHwNQhu3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86FDC885B5; Wed, 17 Jul 2024 06:10:28 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D8E28841D
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 06:10:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46H4AFnG018324;
 Tue, 16 Jul 2024 23:10:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1721189415;
 bh=AmAsOBSnylzJ6HlZpPARxtD4JR7swh0AdcThoC+pFBQ=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=GHwNQhu3hhyRka1u+gfIhgn3TtudyxP2sHezxCfE5jvY3h9DKZ+9HsMEvGqygGrLf
 +mnVzPCuRiaaTwpS8XwY8S46spPZgYOjKMXvNYlZIH8vHRpFKCy6kYNA7n9qegZ1ek
 ss65wLn/YJt/efjxo+F2HPTKwNEFnXbC0em7xSNI=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46H4AFGq017119
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 16 Jul 2024 23:10:15 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 16
 Jul 2024 23:10:15 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 16 Jul 2024 23:10:15 -0500
Received: from [172.24.29.211] (lt5cd2489kgj.dhcp.ti.com [172.24.29.211])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46H4ACZd068097;
 Tue, 16 Jul 2024 23:10:13 -0500
Message-ID: <ddef3081-76a2-4985-bc47-9a18bcd7ed93@ti.com>
Date: Wed, 17 Jul 2024 09:40:11 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configs: j784s4_evm : Increase Dynamic memory allocation
 size
To: Francesco Dolcini <francesco@dolcini.it>
CC: <trini@konsulko.com>, <nm@ti.com>, <u-boot@lists.denx.de>,
 <j-humphreys@ti.com>, <marcel.ziswiler@toradex.com>, <vigneshr@ti.com>,
 <b-padhi@ti.com>, <u-kumar1@ti.com>
References: <20240715174301.2688466-1-u-kumar1@ti.com>
 <20240716200555.GC85916@francesco-nb>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20240716200555.GC85916@francesco-nb>
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

Hi Francesco

On 7/17/2024 1:35 AM, Francesco Dolcini wrote:
> Hello,
>
> On Mon, Jul 15, 2024 at 11:13:01PM +0530, Udit Kumar wrote:
>> Increase malloc size to 32 MB to align with other J7
>> family devices.
> Is this needed for any specific reason? I am asking to understand if
> other boards using the same SOC should be updated to prevent
> $random_issue.

In our downstream version, we are seeing an issue , while using DFU to MMC

Please see

https://gist.github.com/uditkumarti/b8209f61eff3154f6eb288ba63715263#file-gistfile1-txt-L82 



Since DFU is not supported yet in mainline u-boot, so I avoided to 
mention that failure.

Also this change is generic, so i thought of pushing it now instead of 
waiting for DFU series.


> Francesco
>
