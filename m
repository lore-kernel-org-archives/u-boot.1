Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CC80C27C53
	for <u-boot@archiver.kernel.org>; Wed, 19 Jun 2024 12:09:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DCF98841E;
	Wed, 19 Jun 2024 14:09:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="eK2+wYat";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8950F88428; Wed, 19 Jun 2024 14:09:39 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B06088415
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 14:09:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hnagalla@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45JC9WI2019052;
 Wed, 19 Jun 2024 07:09:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1718798972;
 bh=bXO7pZwETXn4McFwVIH8+WnCwT2FZYSZk5u5Cl129JI=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=eK2+wYatqY0HLLHI92CrWHIMWqcb/THiKbp/BtIsUJXlDTlUSKHtqMPAjWi54T6+N
 OGvc1YTbr4VvVEAcn0Ib+2sYgk/jzipLUi6DwZkFG1piHNWzu71RNJZHVNKxrdhveF
 S9K2nGYqdxLu2CCffDeoNkCV9siCk7tXXa5SCOLQ=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45JC9WUN012647
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 19 Jun 2024 07:09:32 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 19
 Jun 2024 07:09:32 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 19 Jun 2024 07:09:32 -0500
Received: from [10.249.48.175] ([10.249.48.175])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45JC9VlM036488;
 Wed, 19 Jun 2024 07:09:32 -0500
Message-ID: <c8d3538b-0fd6-9b94-f443-624b1d903cc1@ti.com>
Date: Wed, 19 Jun 2024 07:09:31 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 0/3] Add M4 remoteproc driver for TI K3 SoCs
Content-Language: en-US
To: Nishanth Menon <nm@ti.com>
CC: <trini@konsulko.com>, <devarsht@ti.com>, <afd@ti.com>, <b-padhi@ti.com>,
 <u-boot@lists.denx.de>, <u-kumar1@ti.com>, <praneeth@ti.com>
References: <20240618184636.30642-1-hnagalla@ti.com>
 <20240618185417.cjzqmtzrqf5adwul@drapery>
From: Hari Nagalla <hnagalla@ti.com>
In-Reply-To: <20240618185417.cjzqmtzrqf5adwul@drapery>
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

On 6/18/24 13:54, Nishanth Menon wrote:
> On 13:46-20240618, Hari Nagalla wrote:
>> This series adds support for M4 remoteproc driver for K3 devices.
>>
>> Logs:https://paste.sr.ht/~hnagalla/62811c4003c27ada83bc1c94500f7714ab30092a
> Obviously - this cannot work with out an M4F node in dts, correct? you
> should have mentioned that in your email.
> 
Yes, that is correct. It needs M4F node in dts. I should have mentioned 
it in the email, that the kernel to u-boot device tree sync is needed 
for it to work.
