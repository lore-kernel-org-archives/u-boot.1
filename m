Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2A8BC282EC
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 13:45:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07EFA81A0E;
	Fri, 14 Mar 2025 14:45:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="HHkwV2Wl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 410F581B5B; Fri, 14 Mar 2025 14:45:49 +0100 (CET)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34A2580F9C
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 14:45:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=h-vm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52EDjiVu1651898
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 14 Mar 2025 08:45:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1741959944;
 bh=T1W7GxRgE+ir5WLGFsDpj2EieOlQVt35Y8/Ssm6bMUs=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=HHkwV2WlrBCwWqCGZcDSB5qvrm1tbU6FAMY9tl45mnarOKDgMj+pQv7oxXAGpHAAd
 /cW8/s7Zx1sHyeDKjKfTDpV01uz3+7bb5+GMd/PdeAfzFXi2Z1N8n2YxBHcI6L2SPc
 p1RuIr7P30S1gTUkpVVkfQa20oSViWQqRtcgQTWA=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52EDjiFM109096;
 Fri, 14 Mar 2025 08:45:44 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 14
 Mar 2025 08:45:43 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 14 Mar 2025 08:45:44 -0500
Received: from [10.24.69.179] ([10.24.69.179])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52EDjfO5036903;
 Fri, 14 Mar 2025 08:45:42 -0500
Message-ID: <df29c7e3-c1fe-d572-48b5-6d4117873d12@ti.com>
Date: Fri, 14 Mar 2025 19:15:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [EXTERNAL] Re: [RFC PATCH 2/4] cmd: fuse: Add fuse writebuff
 sub-system command
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <vigneshr@ti.com>, <k-malarvizhi@ti.com>,
 <kamlesh@ti.com>
References: <20250313115517.1181829-1-h-vm@ti.com>
 <20250313115517.1181829-3-h-vm@ti.com>
 <20250313161807.GF2640854@bill-the-cat>
From: Harsha Vardhan V M <h-vm@ti.com>
In-Reply-To: <20250313161807.GF2640854@bill-the-cat>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
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



On 13/03/25 21:48, Tom Rini wrote:
> On Thu, Mar 13, 2025 at 05:25:15PM +0530, Harsha Vardhan V M wrote:
> 
>> Add CMD_FUSE_WRITEBUFF config option to add and enable fuse writebuff
>> sub-system command. Add fuse_writebuff function to be invoked on
>> writebuff command.
>>
>> Signed-off-by: Harsha Vardhan V M <h-vm@ti.com>
> 
> Pending updates for what I asked in part one,
> 
> Reviewed-by: Tom Rini <trini@konsulko.com>
> 

I assume that by ‘part one,’ you are referring to the question about why 
we don’t use simple_strtoul inline. I’ve addressed that in the other 
thread. Let me know if further clarification is needed.
Thanks.
