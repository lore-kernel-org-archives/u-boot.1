Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2C62CA0FFE
	for <u-boot@archiver.kernel.org>; Tue,  2 Sep 2025 16:06:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D93DF832EB;
	Tue,  2 Sep 2025 18:06:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Yv+z7ttv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DCD383323; Tue,  2 Sep 2025 18:06:33 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B29448329B
 for <u-boot@lists.denx.de>; Tue,  2 Sep 2025 18:06:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 582G6SC23022052;
 Tue, 2 Sep 2025 11:06:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1756829188;
 bh=YqAI2F3lyLkQAfVAPXxu71Q0IkdHBbKJRM9vSGYp1hA=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=Yv+z7ttvQiDGZFcB+2S59sW8CB7MicZr5kv7zdEwBrWiSBtg3q/7ne69nkWYDo/EH
 0peAkh82N1b7GLIPkIf/QA/NdvV21qjoVn1vPxqh+Fxq74TO9wxWJbp2Ebs3dWgejU
 eotvsmEZZATkXq7aHLfkJeEcdWzPvbiHhjVj5acI=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 582G6Sq03599910
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Tue, 2 Sep 2025 11:06:28 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 2
 Sep 2025 11:06:28 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 2 Sep 2025 11:06:28 -0500
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 582G6QxF148963;
 Tue, 2 Sep 2025 11:06:26 -0500
Message-ID: <5fec7216-9e0a-4d97-af23-60953cc1ef75@ti.com>
Date: Tue, 2 Sep 2025 21:36:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] configs: j721e_evm_r5: Enable HBMC and MUX_MMIO at
 SPL
To: Tom Rini <trini@konsulko.com>, Anurag Dutta <a-dutta@ti.com>
CC: <n-francis@ti.com>, <u-boot@lists.denx.de>, <u-kumar1@ti.com>
References: <20250902102000.1388848-1-a-dutta@ti.com>
 <20250902102000.1388848-3-a-dutta@ti.com>
 <20250902154656.GE124814@bill-the-cat>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20250902154656.GE124814@bill-the-cat>
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

Hi Tom

On 9/2/2025 9:16 PM, Tom Rini wrote:
> On Tue, Sep 02, 2025 at 03:49:59PM +0530, Anurag Dutta wrote:
>
>> Commit 0e198ff1a911 ("configs: Resync with savedefconfig") removed
>> the necessary configs required to boot HyperFlash successfully, due to
>> missing Kconfig dependencies. Now that the Kconfig dependencies have
>> been added, re-enable the HBMC and MUX_MMIO configs in the SPL stage.
>>
>> Fixes: 0e198ff1a911 ("configs: Resync with savedefconfig")
>> Signed-off-by: Anurag Dutta <a-dutta@ti.com>
> Please note that this means it never worked to start with.
> "savedefconfig" does the equivalent of "make foo_defconfig" and then


It was working before but due to some boot issues , due to DT sync

we disabled HBMC with commit id 5b2671594b80af116e259313d48bcd580d71f462 .


Instead of saying Fixes: 0e198ff1a91,

This patch is fixing sha id 5b2671594b80af116e259313d48bcd580d71f462 by 
kind of revert.

my bad to give R/B , overlooked on sha id of fixes tag.


> uses the output. So those symbols were missing in the output normally.
> We can keep the fixes tag, and I'll apply this for v2025.10 soon, but I
> want to clarify the problem.


