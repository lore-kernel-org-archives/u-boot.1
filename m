Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3641AC282EC
	for <u-boot@archiver.kernel.org>; Mon, 17 Mar 2025 09:04:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A36DC8058A;
	Mon, 17 Mar 2025 10:04:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="im7lT/oL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 263F580F4C; Mon, 17 Mar 2025 10:04:10 +0100 (CET)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15C7C80107
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 10:04:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=h-vm@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52H944N52233299
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Mar 2025 04:04:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1742202245;
 bh=QgzXDYJ6i0Hh8eyebbYw6O1ORU18mXyApo/OjLjoNXQ=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=im7lT/oLday/wz9uwxwGX75pETo6561bvkNgkMXQDYvqAvWAbfSO1Siq3CSIGABoZ
 KN7eyqXsPMl9r5+fnCKCEFAsnqy2zeexEPZySrdeooMeLe9tk8z5Cj+RWwAgNGaatC
 mvNjhMWNmaTZRy41PtPTEElmhb21HMZ5WmPHiaWU=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 52H944Kg019287
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 17 Mar 2025 04:04:04 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 17
 Mar 2025 04:04:03 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 17 Mar 2025 04:04:03 -0500
Received: from [10.24.69.179] ([10.24.69.179])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52H941N4105305;
 Mon, 17 Mar 2025 04:04:02 -0500
Message-ID: <b2f25001-2a43-0c4b-9658-377ecc156375@ti.com>
Date: Mon, 17 Mar 2025 14:34:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC PATCH v2 2/5] doc: cmd: add documentation for fuse command
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <vigneshr@ti.com>, <k-malarvizhi@ti.com>,
 <kamlesh@ti.com>
References: <20250314135706.184807-1-h-vm@ti.com>
 <20250314135706.184807-3-h-vm@ti.com> <20250314163840.GW2640854@bill-the-cat>
From: Harsha Vardhan V M <h-vm@ti.com>
In-Reply-To: <20250314163840.GW2640854@bill-the-cat>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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



On 14/03/25 22:08, Tom Rini wrote:
> On Fri, Mar 14, 2025 at 07:27:03PM +0530, Harsha Vardhan V M wrote:
> 
>> Add documentation for the 'fuse' sub-system commands.
>>
>> Signed-off-by: Harsha Vardhan V M <h-vm@ti.com>
>> ---
>>   doc/usage/cmd/fuse.rst | 156 +++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 156 insertions(+)
>>   create mode 100644 doc/usage/cmd/fuse.rst
> 
> This should delete the old doc/ file as well. Also please run:
> make htmldocs KDOC_WERROR=1
> 
> As this will fail due to not including this in the index at a minimum.
> Thanks.
> 

Thanks, Will remove the doc/README.fuse file and add the fuse index in 
doc/usage/index.rst
