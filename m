Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 495D1FD7F91
	for <u-boot@archiver.kernel.org>; Fri, 27 Feb 2026 10:30:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACF5683AA9;
	Fri, 27 Feb 2026 11:30:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="JQ9GRICm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8839983BB1; Fri, 27 Feb 2026 11:30:33 +0100 (CET)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazhn150130000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d911::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20BA783642
 for <u-boot@lists.denx.de>; Fri, 27 Feb 2026 11:30:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X+lnQsCyPWIKOGF5V+YGwQBahc6hmFGqGmkP8rt9sxqgFzPRYkuavnpvaq/LYjq0p0gzn0xMrTrRQgDOAv1CUcyLn0MJAn7V/FgbqxxdYgF+3wa3MN5V7B2tOt+ZFHrfV+I8WRXdEHU/TlYfOjqvKbURwgvM5dsiwBB19kr8NxZCTQ1nJyFoIlZNYSLv50VSsrjesWEqID8Ia/VdMsEmRjXsrTAJjrhKrTwMFvvofoHDj+Qy/mNXl0I+3B8oaXdu3LYYgto5ULHvpQ3KyknsJIWjRLErxeCiAZJ50djoFsC16qukBSiuSkHAUjpDlCS5ANTMltbQQFWXsIhQdWwlzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m7VOXb6sG/dSuIIjdwMfQ1HFvoY+SsYLjSp16+iPAFs=;
 b=m05qlJtFv1xqGue6BN6Mqok7zUh8UInt4xwIefl4jtzWFo1z9QCP24OUAny5HuGHYOsBi6LAbHS/LpFN+efNzS7gtzajminJ0NQKLM9e2Uonl0TQ+BamCnI1tPL5eZWEYY3HSTIL940MyjSFr7LUgEQUuFe+skzrQuuAowdM0ex2dDepaIVSLgcXmBDuMgPf7X0zCD7LYE6DF6cq9sQ0/nrlTY44bSewSV6rA8mnhgVbt6JHXtTNAaNrjDqEf1CFpVzHxcr0QRZGKBRdBXcKeHAE3HVXRKQprHERX2/yis6JMbp3Ka3tVuiENeepv02o2mu+nnYRWjzGr6LjzVSKaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m7VOXb6sG/dSuIIjdwMfQ1HFvoY+SsYLjSp16+iPAFs=;
 b=JQ9GRICmgICmqMXHJgs9mq3e114mP9h3/XjW2eIlbiQ8uzCgCy97zdGcEmv3djKYVF4X6DwJEWnrUGO6hGHTJMOT4lNKWcZYqlcS7NXmIAznpwx9gwfNY0pOA7vntrMqe5zj4N6jWTkZhKvDYpV6S4IEHa2GVXMVxd7/YNFawyo=
Received: from PH7PR17CA0006.namprd17.prod.outlook.com (2603:10b6:510:324::28)
 by EAYPR10MB997806.namprd10.prod.outlook.com (2603:10b6:303:2c2::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.13; Fri, 27 Feb
 2026 10:30:28 +0000
Received: from SN1PEPF000397B5.namprd05.prod.outlook.com
 (2603:10b6:510:324:cafe::9c) by PH7PR17CA0006.outlook.office365.com
 (2603:10b6:510:324::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.26 via Frontend Transport; Fri,
 27 Feb 2026 10:30:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SN1PEPF000397B5.mail.protection.outlook.com (10.167.248.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Fri, 27 Feb 2026 10:30:26 +0000
Received: from DFLE211.ent.ti.com (10.64.6.69) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 27 Feb
 2026 04:30:25 -0600
Received: from DFLE215.ent.ti.com (10.64.6.73) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 27 Feb
 2026 04:30:25 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 27 Feb 2026 04:30:25 -0600
Received: from [172.24.18.150] (ltpw0g6znt.dhcp.ti.com [172.24.18.150])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61RAUN5Y3583889;
 Fri, 27 Feb 2026 04:30:24 -0600
Message-ID: <dfd8356a-2e93-47e3-883b-9605173a1db0@ti.com>
Date: Fri, 27 Feb 2026 16:00:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FIT Verification
To: Nagabhushan D <nagabhushand34@gmail.com>, Simon Glass <sjg@chromium.org>
CC: <u-boot@lists.denx.de>, Manorit Chawdhry <m-chawdhry@ti.com>
References: <CAA-ybFQ=DbZzcGq_=HLFx_Gp_D1YKj=oKYXtD0HKPuVYcQyyoQ@mail.gmail.com>
 <CAFLszTisAAQJb53Z9bifbMd9fQL-1iXnmbsyZMRDovAYYF87oQ@mail.gmail.com>
Content-Language: en-US
From: "Francis, Neha" <n-francis@ti.com>
In-Reply-To: <CAFLszTisAAQJb53Z9bifbMd9fQL-1iXnmbsyZMRDovAYYF87oQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B5:EE_|EAYPR10MB997806:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cf832f0-07ee-4835-c8b0-08de75eb38cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|34020700016|1800799024|12100799066;
X-Microsoft-Antispam-Message-Info: R00ook1jw5sxNR6AbVUTuiPk0DDNhm7iYKiUrFQcGT0/lKkQ8/RGlVbbeGH8/irh8NG4UuDNdIATXxIbnPGJo9wwot/KG0JUaxFfJBhuI1c2JFBATsCLcEXcshrzTWkaDiUKlJTjIY1+eg/Uc6WDxdcFLb09Db8TIo8sXYUYTreaNLMPxXhGuNt7/+22euczPlK6dDNn0rBLHSi4MDuGXJ5lgVKKmkbT4EaARVaHKJd4WL8jjCp5FG4ObVvYRHbUtt8n/DifOeFpd+QDQ00eEcJp64VGZmpl6grhvsuyrWgUREC5LGd+OKIJrDWjbPpKGlPS7PvdWwnWcnJsbAqMyK/XkQuRGoN7HfCSxgTCOZSPNngLWdlxEM/HMVsUismiYK4Lq6lhE+MidPDv5/6On6FTKFwkE3GqNAr+2ODkcFF3GP77+HMUExktntm2SIjco+IDRQnUUpQsoeuiaFQWEUBRer2hUMJAxIFgo2XBaWFzldma0E1RlRd1PUrDJf0WNQqUoh+61VTkp1dCizCzIOouxBg1jKz5pXIpBBF/64+ZlTfOW/2pHcxKoeGq5RzArwaLsI4uHMObvBs7ClLxIDgA8EuUZu4KTgyW5WgD0/IV71Ww13yLeKXhakbFbOzNEcpnW5z0g+eyrzL9jUZn6ST1nPjMXJyktbp1+Mzp720z/a93PqNVW4IBlJWhNC5tIfAOD5PaikeF1fdzlip8A52yBJaw8Jfq3K0THJDL6yy2szPTpIiMO7RFWeTLmyRXyYH+h6uQO1jUJVqRFpVsRw==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(34020700016)(1800799024)(12100799066);
 DIR:OUT; SFP:1501; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8UKE7DV0EUpIaS7GvkoGrWWFLhXrI8Zh4D9QyjHTOY/Zh3ihE5SnWtJ2a5vNYVSGcX9u4vUl6JaW/f+7FyZpXvYtRcY2bWI84jxJMq8tWMJSUvmXNNYyKL72XpzhvcapfovrDXyXEj4c1oCYneB4aTuvXuytU6DE46I8zYJ+e6h+wFBdZcJXKT7rZNFeSoyNTqn3yEA8okh2iu3YoH0qUvpebPHTMTRccpq2g4A4Wb54h+2Y+nXFGO89aPj+JxJ+P7F/1Cilop85fxoWsVRFje2l1X9BEbJo0fh0z/r8VH1VbEEtUHBfRXH2B0EK9N7pSxMPJ3k23X0ML5DSNULxjw7XwjZTAbCVUSnV2iocGxeJVK3bs3OdvBEmiqc10ZXewVortewap4uOif2R2GA9cvrO1ExIKndFi5EclqRrtqM7OU1TrXnHZ65viPzUVzRi
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 10:30:26.3412 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cf832f0-07ee-4835-c8b0-08de75eb38cf
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR10MB997806
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

Hi Nagabhushan

+ Manorit do correct me if I'm wrong

On 2/27/2026 5:14 AM, Simon Glass wrote:
> +Neha Malcom Francis
> 
> Hi,
> 
> On Wed, 25 Feb 2026 at 01:54, Nagabhushan D <nagabhushand34@gmail.com> wrote:
>>
>> Hi Team,
>> I am a recent graduate working in Embedded stream. Currently exploring secure booting on TI boards. I went through some of the writings on github - https://github.com/ARM-software/u-boot/blob/master/doc/uImage.FIT/signature.txt and other sources by TI. I would like to get few confusions cleared by this mail and thanks for take some time for this.

I'm linking a couple of links [0] and [1] that should clear up everything if you
haven't stumbled upon them already.

>>
>> 1. Can I try out only fitImage verification with hs fs boards only?
> 
> Neha may know about that one.

No, both GP/HS can enforce fitImage auth (check FIT_SIGNATURE_ENFORCE)

> 
>> 2. Can I try it with ti dummy keys or any other way to know if the flow/fit signing is correct?
> 
> There are tests which check signature verification using sandbox,
> which might be the easiest way to try it out. See test_fit.py

Yes sandbox testing would work, as well as building with the TI dummy key.

> 
> Regards,
> Simon

[0]
https://software-dl.ti.com/processor-sdk-linux/esd/AM62AX/latest/exports/docs/linux/Foundational_Components_Kernel_Users_Guide.html#creating-the-kernel-fitimage-for-high-security-device-gp-devices
(this is our SDK doc, just in case you need more help to follow along, more or
less the same as what the upstream docs talk about)

[1] https://docs.u-boot.org/en/latest/board/ti/k3.html#fit-signature-signing

-- 
Thanking You
Neha Malcom Francis

