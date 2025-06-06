Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FCDCC5AD49
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 05:15:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8526E807B1;
	Fri,  6 Jun 2025 07:15:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="EToTAsza";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B85CB81E25; Fri,  6 Jun 2025 07:14:59 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3598800C1
 for <u-boot@lists.denx.de>; Fri,  6 Jun 2025 07:14:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-padhi@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5565EsHr1306427;
 Fri, 6 Jun 2025 00:14:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1749186895;
 bh=7ZdfqeWA6Q34gNmnmnoCxvWd+RgJMO5DQSm+jh7bQEo=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=EToTAszai8Q52iE1l3UoqjACQplw4QB9N82It34xgrQ/iP3mBSRYNiIg7XIK1x6Ku
 20VfTco5LYPNPuXOLCi3IK/wiXSIw3KF7dGq3L1fRnL0J9scZpK5MOAJ+jmPMpaVZN
 jQTeAPgpSwlYvCQw4miOgWpXnh5u2p9WdOWzP4PU=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5565EsKM1719442
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Fri, 6 Jun 2025 00:14:54 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 6
 Jun 2025 00:14:54 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 6 Jun 2025 00:14:54 -0500
Received: from [172.24.227.151] (uda0510294.dhcp.ti.com [172.24.227.151])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5565EonV461562;
 Fri, 6 Jun 2025 00:14:51 -0500
Message-ID: <6d2bfdad-c52f-47ee-80ee-3e91ce1304f3@ti.com>
Date: Fri, 6 Jun 2025 10:44:50 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] arch: mach-k3: common: Add support to shutdown MCU
 R5 Core 1
To: Hari Nagalla <hnagalla@ti.com>, <trini@konsulko.com>
CC: <afd@ti.com>, <nm@ti.com>, <n-francis@ti.com>, <jm@ti.com>,
 <u-kumar1@ti.com>, <m-shah@ti.com>, <u-boot@lists.denx.de>
References: <20250602145015.1274726-1-b-padhi@ti.com>
 <20250602145015.1274726-3-b-padhi@ti.com>
 <da4550aa-6b39-2505-8492-7acb2c2f6d51@ti.com>
Content-Language: en-US
From: Beleswar Prasad Padhi <b-padhi@ti.com>
In-Reply-To: <da4550aa-6b39-2505-8492-7acb2c2f6d51@ti.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Hari,

On 05/06/25 16:54, Hari Nagalla wrote:
> On 6/2/25 09:50, Beleswar Padhi wrote:
>> +int __maybe_unused shutdown_mcu_r5_core1(void)
>> +{
>> +    struct ti_sci_handle *ti_sci = get_ti_sci_handle();
>> +    struct ti_sci_dev_ops *dev_ops = &ti_sci->ops.dev_ops;
>> +    struct ti_sci_proc_ops *proc_ops = &ti_sci->ops.proc_ops;
>> +    u32 dev_id_mcu_r5_core1 = put_core_ids[0];
>> +    u64 boot_vector;
>> +    u32 cfg, ctrl, sts;
>> +    int cluster_mode_lockstep, ret;
>> +
>> +    ret = proc_ops->proc_request(ti_sci, PROC_ID_MCU_R5FSS0_CORE1);
>> +    if (ret) {
>> +        printf("Unable to request processor control for core %d\n",
>> +               PROC_ID_MCU_R5FSS0_CORE1);
>> +        return ret;
>> +    }
>> +
>> +    ret = proc_ops->get_proc_boot_status(ti_sci, PROC_ID_MCU_R5FSS0_CORE1,
>> +                         &boot_vector, &cfg, &ctrl, &sts);
>> +    if (ret) {
>> +        printf("Unable to get Processor boot status for core %d\n",
>> +               PROC_ID_MCU_R5FSS0_CORE1);
>> +        goto release_proc_ctrl;
>> +    }
>> +
>> +    /* Shutdown MCU R5F Core 1 only if the cluster is booted in SplitMode */
>> +    cluster_mode_lockstep = !!(cfg & PROC_BOOT_CFG_FLAG_R5_LOCKSTEP);
>> +    if (cluster_mode_lockstep) {
>> +        ret = -EINVAL;
>> +        goto release_proc_ctrl;
>> +    }
>> +
> I suppose this code runs in A72-SPL environment right? I wonder, if you need to check the state of CORE1 (reset state and/or HALT) before proceeding to shutdown the core. Just to make any other earlier bootloader (SBL or other variants) did n't boot CORE1.


Thanks, I will include this check in the revision...

Thanks,
Beleswar

