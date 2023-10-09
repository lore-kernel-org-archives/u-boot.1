Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 467D7E95A91
	for <u-boot@archiver.kernel.org>; Mon,  9 Oct 2023 10:14:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C086D86B1B;
	Mon,  9 Oct 2023 12:14:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZvKL7TwP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B42AD8638B; Mon,  9 Oct 2023 12:14:32 +0200 (CEST)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::626])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B38DA86C1E
 for <u-boot@lists.denx.de>; Mon,  9 Oct 2023 12:14:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iNYUhqtapZSNx/FiPix5MmNrKdVg0kWZC0yMDOITHUj/ZAr50tgdPkOyLrVMUQ4J2krUo6i5AA3wF8LkrlPsEt03QFDH0sUK62kprHHTuWWv/Ga6XH+1ll3MhOlAEoSmfOcAaNt/k3lHl6b22Xf1ny2kkyQy26/DQVbHsrLM5io8pc/+TtVIt99ZwGVKk3RDkfMQwoxfUf3ivZpKtqbkpARd+qOxV/z1NrE4NntFO9TNdPBFZvE6CnCR+8HwR+eopB/5ffvtMV8i7Zf70nXmV0Ay7EcpmMhArmSfVMw3GHSB0DbnhIqsYSrpGIpFbQHzwL6ZKUhCFhj23WCMjRoK7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YkIOSStxMrTAmzUxamY6hj7bGRpWs6tIrOkTNGZ1wWg=;
 b=laVS9fsx9tjba0Ct7c66DK40scA9NhfS4a++i6yTlT9usRXtnNYnD8mIsylcbbie5nCEGVElWL8SB8NUctAMITrSHsgB6ckbZX7NVTbJJupNRlbXZEKnQRkXfPmWOYB728CV3cXR2OTh5wzi7L5jsxeP1yZlNpLYUAkYQZKHH2bRMHBIqorqEHp4zV/XhL9sBZzVSXYHXF5eQN/cpTFBhknS/1QeYFmQ3VAmlROWtpWchX5y+YDcgv9w6rrAJlnCC6IU+U6pz8DfzEUyI9aLug/eXpb1QoXCkv0T0VjsDEJh7kyBkfYOwYHMF/WMjqPHWdKyXs4uCgNDNBBavDEmRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YkIOSStxMrTAmzUxamY6hj7bGRpWs6tIrOkTNGZ1wWg=;
 b=ZvKL7TwPyG43IujmFD6A5iWVED6fZZYVv1t2/suW0uQ9wE4QDym7cdkm7rCjdYy+3hoCyp5RiAFBK+n/MBm/0Qxte1TGSrrbwHVhgoOy6SneQjxvqG3NA08WLVqh62AeXGvSsEUy9rFOVDSvrTrWzHxCFD5r5nkqMI0A5p/APks=
Received: from CY5P221CA0011.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:b::15) by
 DM4PR12MB6494.namprd12.prod.outlook.com (2603:10b6:8:ba::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.38; Mon, 9 Oct 2023 10:14:26 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:930:b:cafe::7d) by CY5P221CA0011.outlook.office365.com
 (2603:10b6:930:b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37 via Frontend
 Transport; Mon, 9 Oct 2023 10:14:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.208) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Mon, 9 Oct 2023 10:14:25 +0000
Received: from [192.168.137.2] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 9 Oct
 2023 05:14:23 -0500
Message-ID: <a0e42c5a-474f-4ec2-97a3-4cdb3dd780f0@amd.com>
Date: Mon, 9 Oct 2023 12:14:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "clk: versal: Enable clock driver for Versal NET"
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
References: <c09276022db5f1b150679cc7a9f9583363ace2fb.1695808971.git.michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <c09276022db5f1b150679cc7a9f9583363ace2fb.1695808971.git.michal.simek@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|DM4PR12MB6494:EE_
X-MS-Office365-Filtering-Correlation-Id: 79551b6c-b549-478d-95fd-08dbc8b08415
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BrFC0RM3Pmeh5Nj12MLGVuZb5SjbBakNBdGVwzvHVRxeJVT17kn9IT2++2e5VDaduttASHSW2oM4bepvIxGu4FNTV2uT2aQsXFEDcpCIxExbP9RPzx6UgzFz7jOaiFtexxUdbZQWfY180PbLcDCikiVh/a7qCltsJ0ChBmv8GGpCE2ErfejyMwLKE4EPCuBwvGB8G5ubvKCwcfgVaBmx+5wKJ1XnhOLSAF9HFWR0uKrCv0Z23TCBXkiQBPcp6lZM7auVg+vT9DtIClGhOAIQxOAkxINPS2NIIfXOtGmUHGYl+R4+4wxK2oYAPWU+TGQJ05cxsQXFOogM8uwHyDho+it+dUQowHMSZvTCFw9uehRSPEOR5QI+aP9MeIaRu8KGPAxZ5bzhCFHbPKfS52prIeXwy6zBe7/1z+2wdKk1tSsXEGyuuYwaZLnWaBFWMc7J/Ews5k0OFVBH4B7dGWp7/G+MKWzG9qE/iHFAjtLf+kud0uMUXjZrLUo2cXPpIOqxv00/CGU3V27dRoDGi0nDYKvhpWj/KD73BdEwGyj+dkmuP56v5GH9LMo2QHgfcuvxXzU5tYpneQ/ynuPEQnSromKK6riu3AAuSxuMsfEP0+h/RvMlZ3FG3OhmFdglWQLLE9qI+cyvykbbw98oAPSY5GXGPOjPdwUcouv6RBOYSr3CJ6a5Zkadutwi5E9wO7zJ3GW14GpK7mzEjzKViC5cteo0j+JLcpE+3wz/QodvtNbEtjz1CzT/pHOG5nrnwVRgpv2hZbaTCBlD8cT/ncCORol3tbSIi1R3bC7IuUJbux+FU80inooKZZ8z7R3uAnfv
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(39860400002)(376002)(136003)(230922051799003)(82310400011)(64100799003)(451199024)(1800799009)(186009)(46966006)(40470700004)(36840700001)(81166007)(31696002)(356005)(86362001)(36756003)(31686004)(40480700001)(2906002)(82740400003)(478600001)(4744005)(5660300002)(41300700001)(8936002)(4326008)(8676002)(53546011)(6666004)(44832011)(83380400001)(426003)(336012)(2616005)(40460700003)(36860700001)(110136005)(70586007)(70206006)(54906003)(16576012)(316002)(16526019)(26005)(47076005)(43740500002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 10:14:25.7769 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79551b6c-b549-478d-95fd-08dbc8b08415
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6494
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



On 9/27/23 12:02, Michal Simek wrote:
> This partially reverts commit ff33227819f579ffb963e0dac6bc6a6566b89563.
> 
> Versal NET clock node should use "xlnx,versal-net-clk", "xlnx,versal-clk"
> compatible string that's why it is not necessary to define Versal NET
> specific compatible string if there is no any other change needed. It can
> be get back if there is a need to differentiate clock support between
> Versal and Versal NET.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   drivers/clk/clk_versal.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/clk/clk_versal.c b/drivers/clk/clk_versal.c
> index 2e004beca2f9..c473643603a4 100644
> --- a/drivers/clk/clk_versal.c
> +++ b/drivers/clk/clk_versal.c
> @@ -773,7 +773,6 @@ static struct clk_ops versal_clk_ops = {
>   
>   static const struct udevice_id versal_clk_ids[] = {
>   	{ .compatible = "xlnx,versal-clk" },
> -	{ .compatible = "xlnx,versal-net-clk" },
>   	{ }
>   };
>   

Applied.
M
