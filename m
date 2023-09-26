Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FBDDE7E626
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 12:02:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A162786C1D;
	Tue, 26 Sep 2023 14:02:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="r7WgvDfk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46BE686A7D; Tue, 26 Sep 2023 14:02:34 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::610])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3188C86C1D
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 14:02:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kciE1siz6f1Tg7L0Dqzqiof31U8qr1+jrsd9eJS5+7NZ4cYlj7aaj89nvIq/VrehINNQoe/EUj5KaJwrwvCmUFzA7GdOvzHp6ObztxfRCroYHi5u5H3FMrYhsBNR5gjAEzfIPFqZrZgepE97Rs1atFFutJNCFf/rtExB8mS/ItMsq/27e214L1lQgEas3SLK+kCTiv3Ri9p1BUoGM0DpuFKkPZsdnqokSrjIWoR0bIZ6Bz44/bmK34HOVwUBVP5tqfQ/rglW5+Rk05JUb4kB9yzwoyg/qKxYN8CHw95y0H74eZGEIhG98w0HT79udhDHm57lcZ7do28qxF4ytW+7qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xyA/CvMcsjTzD1bh9ZKmLzZv6UUli8ElHpIwmX5kLWI=;
 b=ZRTWnWOUJ72dnt99wxbkEu7JTFRI6DbyDPPFvYHf7aAhbOPz/K9A8xl1/ss0wVdTWgHjqLCHSyEfd0NjWRulDmfNK07zWft5dhB4hOCGCFKOcP0rJjDhdJJMEdcts6y3V0Ypk352v6+P0Lv37+TTjbcY54ax8GzNdVyCn5306ibX5Q2cYCdmKIeRZwso8jx8PFhs67GavGBHXNplO05JPChliDM5qBDBoQCh/gWWwUO+GeTztGsQnupJiQJb6AJslJtzHF0R9QJdg67Zs91OczARcmdjgnS0m7lJQbU9fIeJX8gcmutYEolvDtR42UIigN9LAqVOcuURhHCsQjPzIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=arri.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xyA/CvMcsjTzD1bh9ZKmLzZv6UUli8ElHpIwmX5kLWI=;
 b=r7WgvDfkIDLKyCwUfppiCGCzOsiL/cOZrnlwixM8gUmt6oaOvDcgfk02viJMQBWdyckWx16hPXPhySaFiLthN21qU9RpbElrQaefyLk41S8oJt3+befiqCxHn0ao8febi5uLm6FIIZIgY3dEf6FEftJodnLx7bJhh5Jhok5ciqc=
Received: from PA7P264CA0313.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:395::27)
 by IA1PR12MB8238.namprd12.prod.outlook.com (2603:10b6:208:3f9::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 12:02:27 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2603:10a6:102:395:cafe::84) by PA7P264CA0313.outlook.office365.com
 (2603:10a6:102:395::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.35 via Frontend
 Transport; Tue, 26 Sep 2023 12:02:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Tue, 26 Sep 2023 12:02:25 +0000
Received: from [192.168.137.2] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 26 Sep
 2023 07:02:21 -0500
Message-ID: <4c88642b-f8f8-4d83-9210-eb553ee24e6a@amd.com>
Date: Tue, 26 Sep 2023 14:02:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: versal: Add SelectMAP boot mode identification
Content-Language: en-US
To: "Polak, Leszek" <LPolak@arri.de>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Stefan Roese <sr@denx.de>
References: <DU0PR07MB8419D03ED9705DEA5FAAD992C8FFA@DU0PR07MB8419.eurprd07.prod.outlook.com>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <DU0PR07MB8419D03ED9705DEA5FAAD992C8FFA@DU0PR07MB8419.eurprd07.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|IA1PR12MB8238:EE_
X-MS-Office365-Filtering-Correlation-Id: 83a10f48-75ed-426d-3bf9-08dbbe8872d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h1YThIXhBjaSyog4ET5wV8Z26duvSF0SDCyZnH/bvRfIb0jGS3rCYaRH7DIUBrYbwMrHpP9G6V42OWlYNiAVmy/eIXcSgfkDUIOQHCvW1zCYDORymRD8WbTqVbi7iWaKnuJWASU0lJ9J1Yuq0rJYDZEs+8PDoPUEaf9/BKF9+CTT+R2gkWXlwgp0T6WChRdfScn3YtGOLpYNj+h62hrjEWhMDZDNgpbwtL2os3Wh6iTKv+N0PV78oMtnkOho7xZXI3mzoRd3p9zMJ7XOp754LD/733JpP18TVfDwovEKMHY9dF3Ba9fcHE4VXwlfk0xO+6836ojr4hBXPUZPT4gOSptAgo2hrCiBTBn+j37p/Wcj3tYYZx4Y+m2KBkLllL5LWwzuEtsuitlJb6QkTNA1Tq+AQFhLiVHetdolRhcf8ab8HeR/XRKnxhq1/gwg4HHydZ0+jmI/5+PFCGWM7Vo8t5LazIi1kJdLwWCd1UznOarIcgpWf275bTIWoKkCbqG5muCIukrtlDcfZR82QS9ujSa9ft24kX7+KL0DuOaS9FVFBIe14Y4afx95IWB4sl4gYaCYn6E5/WLftgpLe+N5szPvPQnGl7poq+kRUkEcWxaOKsOYAU0f7h3aC1YeZOrIQMQkVw4SrR6XjHav1s1A65skhq2pkT26EVII3440go4X3OqH/Xnc3+GjMSmFBFlypiQL63T/Kh2GnDiadZucabRFnKcluqn/mYtSNdsSRU+EYTCdpIhSOjdjsd4BSGZGj88DObY4Hi1zNdK9gjBgH7Y2bOqK2yEZPET3Cnwe8LbzFSPZ9PeeZm7mrHk2+bCh
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(376002)(136003)(396003)(230922051799003)(186009)(451199024)(1800799009)(82310400011)(36840700001)(46966006)(40470700004)(40480700001)(53546011)(40460700003)(478600001)(5660300002)(36756003)(81166007)(41300700001)(426003)(336012)(26005)(356005)(16526019)(316002)(70586007)(16576012)(70206006)(110136005)(31696002)(2616005)(86362001)(82740400003)(36860700001)(4744005)(2906002)(47076005)(8936002)(8676002)(4326008)(44832011)(31686004)(43740500002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 12:02:25.3904 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83a10f48-75ed-426d-3bf9-08dbbe8872d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8238
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



On 9/22/23 15:51, Polak, Leszek wrote:
> The SelectMAP configuration interface provides an 8-bit, 16-bit or
> 32-bit bidirectional data bus interface to the Versal FPGA
> configuration logic that can be used for both configuration and
> readback.
> 
> A connected microcontoller to the SelectMAP interface can load boot
> image with bitstream, TF-A (ARM Trusted Firmware) and U-Boot.
> 
> This commit adds the missing identification of the SelectMAP mode.
> 
> Signed-off-by: Leszek Polak <lpolak@arri.de>
> Reviewed-by: Stefan Roese <sr@denx.de>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Stefan Roese <sr@denx.de>

The patch itself looks good but your git setup is not correct.
Email address you use for sending is not matching one in SOB line.

Can you please use lower case in email and send v3?

Thanks,
Michal
