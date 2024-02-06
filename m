Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99CEBC48297
	for <u-boot@archiver.kernel.org>; Tue,  6 Feb 2024 11:32:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E426787C45;
	Tue,  6 Feb 2024 12:32:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RdZrLZeh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C73E387C45; Tue,  6 Feb 2024 12:32:48 +0100 (CET)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2060a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::60a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B983E87968
 for <u-boot@lists.denx.de>; Tue,  6 Feb 2024 12:32:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T/Xr/r2dI5gxILq2Zkwk7nbfKEZihYQbHiuRuKD2nwdFKIt6Yc4FDUq76uleg6QIkatub8a8C3Ae8z1Tx5Bq2wzRBq1hC8jfg6y4IkiUXp2LCyCgUL81QjnXiOVMJFJfITCrR1XoWDWajGdHXsXZ4N1jimq82OPfmRUBK8B9jLamwoL8Y79NykSBNxbngIBCij9O0rZfuHHNepbelk8REZiqvGOQV2Dapfk4unfVAXpCl6i7dXR4eg4SxpUzCYLNK6py+4CIbXlYbZS4xEPO19naocAzA9QC0UVnrtMvQ4JRso8anscQLYpbqTbKqn8iU3xToAjiahDHrxk3PoPNaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9wEYjkv4WUcRiUKLvYARoHFGxk4NzfzePjTm0DWIpts=;
 b=IgyTZqojB7DAGnrGU2ArHDE6ZZn2NDNaE2D7S8Cf4VAVWPkTMR5qzJdUwR4yckUsrXQG21wIp7+dt8upmPlwFaomXBBAvKEl0CHuuKmdV4Fuu07BaRUpQQWFsratHzV28IfbxSeaJrG+BB1GkqDw3/Og1nXPdUKoQoBZVp3x+svnyYwZoxoX6hVDqrxsESmrqsBiShY2NsfHqzrELXttzMCEgtr8BpXivXVZq098ecElAC7eBwvmHenf0RVPMhTlcBxP9+Mo+QtAiHWgzqdx4sheW2zJ7oeqDQk7J09sNXgkme32jaKGoIOENFwATp7iQQjQycf17uX4RRA64XcfRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9wEYjkv4WUcRiUKLvYARoHFGxk4NzfzePjTm0DWIpts=;
 b=RdZrLZeh13cMGe6fg69echz5ZCZHI1rPK9Sa32RcJQ+o5yD1eFAbtCihUNeLMRyGQd9SfHu5hGZKnODYeqTqh4CaaGOibGiLC1d9WUj0Pd54un/Cq2g61sS5y9E7kC2ES95/grKaIgeEqLsuvL8loyJf9POm3X/q7AjMrnEEWbU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by SJ0PR12MB6781.namprd12.prod.outlook.com (2603:10b6:a03:44b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Tue, 6 Feb
 2024 11:32:44 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45%7]) with mapi id 15.20.7270.016; Tue, 6 Feb 2024
 11:32:43 +0000
Message-ID: <6e0dcacb-ff8f-4a54-9a76-ba5122bec252@amd.com>
Date: Tue, 6 Feb 2024 12:32:37 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: zynqmp: Sync clock labels with kr260 revB
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Sagar Karmarkar <sagar.karmarkar@amd.com>,
 Harini Katakam <harini.katakam@amd.com>,
 Manikanta Guntupalli <manikanta.guntupalli@amd.com>,
 Neal Frager <neal.frager@amd.com>,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Tom Rini <trini@konsulko.com>
References: <abac6069e6029ed4076ec7b9d6b33604b6072aa3.1706253871.git.michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <abac6069e6029ed4076ec7b9d6b33604b6072aa3.1706253871.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR08CA0018.eurprd08.prod.outlook.com
 (2603:10a6:803:104::31) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|SJ0PR12MB6781:EE_
X-MS-Office365-Filtering-Correlation-Id: 368b7515-fad4-4f1a-79af-08dc270755b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iuMM+xEkIGjmVF4NIKnq6wxa0wW6Il+araski57UTSqY/n3tPefcupAqMQX8rMQttIykyz+uWCplp57IIOSG5UORp79ydfG/m6+TocuihDtmCMN3BwUYhwEYd7nYhqcEQ/mAwlVI/fy5R2r5U17sZch/AIjNhRhCBD+2Rsw8EPyE63w+XN1srCh0/m76vuElwRRsp6xjFvc6wzZkb95LlNqNTNYQHto7wwj2bZVctuZ7qMS6XiwUyZ6fxwySM6NY6Oyz/aYn32ixLwWtmpWrdh78eGlh8/Dp/kB9SLPnwwnhE7sZtYRS4KXqagK7MDncexpo1QOA/pD95t4tkA1tZ9BWBZcp/uzPHqOfx3g8Mc3gftTRrsIfCWUFrN7HhnRfaGrhllaBeO1kL/+mQJ6TYapGB7g1xRZEuDVUs9Lfo1Zq2Lj+/Z4FX/mA/mGGAT9YJ3GD5RUX4QER9hDvp/guHuamhtPpHuesIx1lL3kS8gpwdotAVJpDw1opL8jjZODz/p2HgBTc0ZMHh+wlVr2RFeklocKBurFPO7PBnysPwAYEisPpoucbRDSJD43MXt7V1b2HgfL/e/2aZNG0RHfWP4OJN77wa9doPFIvrPk76i7AWj46GRQ+K4lZO6LeDUfjpS+ZpIf22tZLmXPnh53dLg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYXPR12MB9337.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(39860400002)(396003)(376002)(366004)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(2906002)(316002)(66946007)(66556008)(8936002)(4326008)(44832011)(8676002)(5660300002)(66476007)(54906003)(86362001)(36756003)(41300700001)(6486002)(38100700002)(6506007)(53546011)(26005)(83380400001)(6512007)(6666004)(31696002)(478600001)(2616005)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UnlNVExJelJRbTM0eE5oQzJ1NGRCVk5sSmJsTnU1V2V6dnBacGQ5WStKZWRG?=
 =?utf-8?B?Mi8zOGZuTDR5anN2eXZjNGJpTzZwMmhla09CU1FjY1VhaTcvbHU5U2tvY2t3?=
 =?utf-8?B?V0R6eCtoYnJMekNZY0J2VERndFgyMzA5YnZCZ3pIUUMxR2tFam93OTV5M3lp?=
 =?utf-8?B?TG4xcHBOeEpMTGtTOEEvdkVkOWo0eHpjOXRyK2VoWUNsL0Z2UFZLSEE0K3dw?=
 =?utf-8?B?U1crNllMNmZvdHZTY2RqL0lNSDhCc0RBNVZKSWVmSWpvQTRTTnZibzFhYWdR?=
 =?utf-8?B?aE41WklTcWJCaS9SdzR4K1dZeFYybTJDQzNjTmtDcHQwMStzSThPc1dQS2kw?=
 =?utf-8?B?bWZoWXpZQzdnazUxTXM4RExab0YwQVkvWGJsZUNzNkdqZURvQW42cEFla0VW?=
 =?utf-8?B?SXp3aHlGZ3plQWhpQ1JGYmRlRnJiSHMvQkZNU05UNnVBNWdaZnJpemFzU242?=
 =?utf-8?B?YjJ1UkFKbWNHaWt3SEFVdzlMTWt2eFJLR0orTURuck41THlZdDluS0o3TmZ0?=
 =?utf-8?B?R1EyLzU0R3dvQ2c5OS9oZG1hbmF0Wk01RHhWRmgraFlseTk4alVRWXJHVll0?=
 =?utf-8?B?Z2tqWUplOEtSNTZWeEhSTk4zb0xjUUVxbEJvTWFpRmMvMVZLck9TeUljclZP?=
 =?utf-8?B?c2IxanlBblhKR0QvbG1WemdzckwzNUtKS25PbjJKTnBJWWZ2SDJlSnZsSlFQ?=
 =?utf-8?B?aUYxYjlMNWlVdm9WQVh1Q2I5MDRDb0hLM0xuWmJQRTRrakZRR1ZwbFFzK0Vl?=
 =?utf-8?B?M3pnUXM2cWd5ZGd2S3M5bW9kZ08xa3kxb2lOUjduSUFNdUdNMDh0cGVVa1RW?=
 =?utf-8?B?SUtxL2p2UWNhY2xLbThrRkdtNW1Sb1plV25FNEJkWnR4UDJnQUwrdHdmS2ow?=
 =?utf-8?B?eXBhQUVTNEpLTjhiY1VMSG1FM2x4UGttcEdHM1NNYkhEZFNMWEJyQnhuL3hs?=
 =?utf-8?B?YW9GQ0pKNm1jbk00eUx2K1lLYTZmMGEvaUt1SnZLamZieTVTN3VnRThSN2RU?=
 =?utf-8?B?TXhYaFpNMlFTQTZnMkk0QmR1RnlPb05Rc2dRTEV5YmhHY1ZBa2VzVGxsMm5H?=
 =?utf-8?B?MVY5cmIvYUxYaXNscXJiVDk3SXFZZnd3UGdXMUF1ZVZGWHJuMUlGUUd4Q2Rl?=
 =?utf-8?B?ZjEwR2JiVjNCVFJYdUhCelVhbWN5RXdCcE81VHFuanF4dlhxMXI2QXZTQnJC?=
 =?utf-8?B?Wk9NUlpTYWsrdlkxUmJBLzdXWXgxNS82QnNjWDVVQVdWVCthSWcwVVNmeDZl?=
 =?utf-8?B?VWZnYXhkYklTMElWN3Foa0VTbE0rVVI1ejAxT3FrbWFwTTg3QjV3QTBYd1hR?=
 =?utf-8?B?cyt6SWVMS1daYnVsRlhjQmQ3UGNzSEF4dmw3K0pBMzRLcnREN2RYTWowNzEv?=
 =?utf-8?B?VnFrbG82ankvK2NMUStEcjJFVzBCaFh5RGllSlZqWVNINzNuU09mbis2Zldh?=
 =?utf-8?B?M0phT1pCL1BhZURHODJVaUgvOTlBT01wTlMwbzZ1cWh3UFdVS2hVOHN4WXFS?=
 =?utf-8?B?djJVSElsQkVTOVM1M3F2MHN2WTJUbFpSTDN5MmlndTZzU2FJNlNDdUJnTnk3?=
 =?utf-8?B?L0Rub2tLWGdmSUUxUVFOeHZKc3FhLy9GMEJQeW9jdnlnME1rSEsvY0xUdVJ1?=
 =?utf-8?B?ZEhyQmt0OWJvZVk2NnJMR0cvUnA4QkhSSzF0VkdHbkEzcWxuZmNPaWhXNlhh?=
 =?utf-8?B?L05Hb2tXK2ZHUWlHcDB6eVNUWG0vc25IVjhLZW9uSERDZzNtY2dCTG5qQkhw?=
 =?utf-8?B?bTNCVzg1STRaQlFZYWEwbTU5NUJvMkxUVTJRaDFSRERhZzkxZkpXZGs5OXE1?=
 =?utf-8?B?QnRWOHV3bXNvTEVVazFtVE4wMEZ0OVVlS2NCTVh6Z0lzM1JhR0tsL2ZQYmNx?=
 =?utf-8?B?QWwvRmUxT1JTVGh1WmhoNWYrN0dwaGhtRVpXVS9NWkZSZ3JVRUNXK290U0J6?=
 =?utf-8?B?aGs4SFBHaHN4S2RHZ09LWWlPYTI1ZFFJRzhBK2VBcjNmVHJXQTBTK0ZRNnNO?=
 =?utf-8?B?RkR6VHEwQk5yTWlxUFAyS1N4U3Yzc3UzSTdCN3oySjZKbjFxR25JUlAxay82?=
 =?utf-8?B?SHEzSi9yVVBOZk9UUTB4TEhEMlhvS3J4UVY3Q1kzSWdDY0JwZEdXK3FBT2xC?=
 =?utf-8?Q?U3j8gcMt9f4GV3X7ih5g5nVTm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 368b7515-fad4-4f1a-79af-08dc270755b9
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 11:32:43.8347 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aODbIVxZJR+j0HGi/xLVJoiYVn+D9/U5nUGn6cP99KeRRSOqvEC6ojDpAke6f9DX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6781
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



On 1/26/24 08:24, Michal Simek wrote:
> Board description describes the hard part of chip (PS) but programmable
> logic (PL) part is not described in this file. But clocks on the board are
> not only connected to PS but also wired to PL. And because two revisions
> are available where revA is using one si5332 and revB multiple clock chips
> using the same clock labels helping with keeping only one device tree
> overlay which targets PL. That's why synchronize clock labels and use
> labels from revB which are more generic.
> Unfortunately if there is driver for si5332 chip split could happen again
> but it is still worth to do it now and solve this issue when occurs.
> 
> Reported-by: Sagar Karmarkar <sagar.karmarkar@amd.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   arch/arm/dts/zynqmp-sck-kr-g-revA.dtso | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso b/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso
> index 7717abf7bd8a..39ca98a9d47f 100644
> --- a/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso
> +++ b/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso
> @@ -25,37 +25,37 @@
>   		io-channels = <&u14 0>, <&u14 1>, <&u14 2>;
>   	};
>   
> -	si5332_0: si5332-0 { /* u17 - GEM0/1 */
> +	clk_125: si5332-0 { /* u17 - GEM0/1 */
>   		compatible = "fixed-clock";
>   		#clock-cells = <0>;
>   		clock-frequency = <125000000>;
>   	};
>   
> -	si5332_1: si5332-1 { /* u17 - DP */
> +	clk_27: si5332-1 { /* u17 - DP */
>   		compatible = "fixed-clock";
>   		#clock-cells = <0>;
>   		clock-frequency = <27000000>;
>   	};
>   
> -	si5332_2: si5332-2 { /* u17 - USB */
> +	clk_26: si5332-2 { /* u17 - USB */
>   		compatible = "fixed-clock";
>   		#clock-cells = <0>;
>   		clock-frequency = <26000000>;
>   	};
>   
> -	si5332_3: si5332-3 { /* u17 - SFP+ */
> +	clk_156: si5332-3 { /* u17 - SFP+ */
>   		compatible = "fixed-clock";
>   		#clock-cells = <0>;
>   		clock-frequency = <156250000>;
>   	};
>   
> -	si5332_4: si5332-4 { /* u17 - GEM2 */
> +	clk_25_0: si5332-4 { /* u17 - GEM2 */
>   		compatible = "fixed-clock";
>   		#clock-cells = <0>;
>   		clock-frequency = <25000000>;
>   	};
>   
> -	si5332_5: si5332-5 { /* u17 - GEM3 */
> +	clk_25_1: si5332-5 { /* u17 - GEM3 */
>   		compatible = "fixed-clock";
>   		#clock-cells = <0>;
>   		clock-frequency = <25000000>;
> @@ -115,7 +115,7 @@
>   &psgtr {
>   	status = "okay";
>   	/* gem0/1, dp, usb */
> -	clocks = <&si5332_0>, <&si5332_1>, <&si5332_2>;
> +	clocks = <&clk_125>, <&clk_27>, <&clk_26>;
>   	clock-names = "ref0", "ref1", "ref2";
>   };
>   

Applied.
M
