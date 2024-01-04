Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A5BAC47074
	for <u-boot@archiver.kernel.org>; Thu,  4 Jan 2024 08:51:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 747D58771B;
	Thu,  4 Jan 2024 09:51:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bX3VIyTf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FFC98793E; Thu,  4 Jan 2024 09:51:33 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8066876B2
 for <u-boot@lists.denx.de>; Thu,  4 Jan 2024 09:51:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fDqYNTIewfCSWYS/XqhLwl1FOKV5Y3aP1lrEPHH4HGNXIV3HclG0onu/f0L1eShtWDrJwnAH/v2HqsmoF8sBagkRrJnodDi31uDNwIM9dQnKak82wOS3QqLDElrdtOr9MZd7BvXiN4g2sUrsPnqIAxLGEZWdsVJ3nurqHjNVznRIoozPPK/ryG+vHiLKOuDv0A5bdaQC/Dxte99NBHEuVPRhZxV0hT+oZ6v8JyEhk83+Wf8IwKahgh5tXKMZM9O9k8qc8lT7eeOJPIL3X/ZeVuoeFHkW8s3JdJMDwVZyGuVD65SsyI0W6S3HtCFqC7PdljkWaUoGdQ7uAa8swa9mZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bXsPHMZnY5g9eaw1tkrp7T5Z+1gpX7uGkY5nfxduDHU=;
 b=aSBlIHCKZrPM2Xv8xt48b6egc2W8EoK0e8ENRcPNWB7KbEaUsdio8KJJyKJKkG8J5A/+MzVSHgM69AxbxfLd5AEWHmGFfFkBrnabk86s5s2sohZTo2ZGR+KhbOfIzbF/KcEIhtf43aCyduCyVEY98ntMKcF6qBCmQTqAb0JZGYfdjM6HUsHCeAFulOMWAVSd2ozwVdxLSGhNZVf0GWV0lB2cVoAxzxSWQTe4rSFo7tx+ULyd0OtXbJ0rQqS+aw3d3WL0BIPo6QcXnnSB/yGZZRppa+S9TKjRUlxUlBmXqYkxPYp7cevtgVFSKb4qIckh9dmOpufQLj5Xo36EQCya/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bXsPHMZnY5g9eaw1tkrp7T5Z+1gpX7uGkY5nfxduDHU=;
 b=bX3VIyTfQVD0CfdVUm81qe7LLvJWrsvJvZioBYb6HaQWUejbGLA/sx7sQXH+piPsjPiMTPaulzsHlDM9nFFoQMn6vFdW+IA4ddFrIX3k+9d+x356ZnHW6w5QKqXU57EmUNxpu02e26Boe1aFCfvysR7jyk4lfbLVrWMASTZjQNo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by BN9PR12MB5367.namprd12.prod.outlook.com (2603:10b6:408:104::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Thu, 4 Jan
 2024 08:51:27 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::2b19:2045:59c7:cde2]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::2b19:2045:59c7:cde2%7]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 08:51:26 +0000
Message-ID: <71b11f79-045d-40e5-a627-b508d5c7215b@amd.com>
Date: Thu, 4 Jan 2024 09:51:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: zynqmp: Describe ethernet phy on kd240
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
References: <61f89dc055f191fd4138b80bb7e3217d814502f5.1702904236.git.michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <61f89dc055f191fd4138b80bb7e3217d814502f5.1702904236.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P195CA0078.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::31) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|BN9PR12MB5367:EE_
X-MS-Office365-Filtering-Correlation-Id: a27b262e-505d-437e-74b0-08dc0d025638
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J27PnQKYXFDnx1qP3W3QqAArFZfe8thZFxYt3FjhEVZ0Rp6voNkEU1dOVW1u4RuLTOpYCHX3BfI1hXaf/wW5MdpgFAq+3vlVyafOQHxJmq3vEzV5DnhONAai8WY719is9rrRBgaKmWxTAmQep1HTt63iVusd7sMELp5lSQr6EgNIjtQ1RwEN8qBsGBv32SPvcI8mOcwzoFI3kLfepb+WNne2w+5hRWyp1yUqutYoZzxzreZGrhWebz9QJL5OF8e8KxL8Lb7qHfyflz+72lAAFCHNQ9T9IdSD3v1+2xDos92b+EjXGbyZDa/tjgC2QuGnpH6lbaXBKCRk9nogoeZyY0/+i8UJclJQgqhW2+G9MFNSqrohc9YcNItNxndki01SXMQcdxIIUqCyUxhFz7pUx7fTT39EfCI/TcPOGoVFq5dvHIhmOvQfNkGcvNBqhbtxSG7M+HZmxxitCu5+Td36z/lkZ5ag0EiXvEeqsQdwOreL/SyvuNnEdobbCk2gM2BaXz01SXJII/tdepdsK5H489W7H9WTiMmIjDMAUQRQgkORemmhT6VnhZbynl+l8I3p4angiapxpsfDplKkRq/AInqcNeyOrjXmOGMdEcVi+dE8OCBQnkwLCUvuqRcur/wXTlJo9M9uy44tot5iN2ocKQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYXPR12MB9337.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39860400002)(346002)(136003)(366004)(396003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(86362001)(31696002)(36756003)(6486002)(478600001)(6666004)(6506007)(53546011)(66476007)(66556008)(31686004)(66946007)(6512007)(26005)(2616005)(44832011)(2906002)(5660300002)(4744005)(8676002)(8936002)(316002)(38100700002)(41300700001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0NGRFFIRCtxTE1NZ0Z5d0MxWW8vWnlKZlRvOVV5djh6ZkVJblg1cW5MY1RB?=
 =?utf-8?B?RVNMUnoxVEdwYlF4TlhydklnZ25OcG9kbDEwNnpPNXZsUXpFS2ZheTVBelNz?=
 =?utf-8?B?TVQza043RFBSYjliM0lhOHRUZUhXeWpDQjdTVWF4bUxZc1Vueit5ZWxEbUpn?=
 =?utf-8?B?UTlUYkVKSFRCUFoxTVNCOEJZKzQxb0pYNDRuRTk5cWZyQVdEdUhWKzgxUnNn?=
 =?utf-8?B?aDFPcGo3ckk0RERSTDlKdTlad2J0bFIxbThNV09rbS9Nb1VNekdYRDVqNnl2?=
 =?utf-8?B?YmpFQ0RuMUUyWmM3RDJyUWpnbHo2V2ZzMklGNGJubVhaSDAwLzgvNG5yL3I5?=
 =?utf-8?B?aU9yR0lnNVhyazBHSFM5RW0zZGpBUUprZk1LajRSZHpNV3hweEZGYnFISXZM?=
 =?utf-8?B?V01rd3pySjJ0YW9aY25HTXVUMzFuVWNUenFDWlp3ZldTeVlHQmJYTjh0djBi?=
 =?utf-8?B?b3htOXNtbDhTa2J3Rk9CMDJtMnp5TCtjeENKS2pPQW9tNkZNeUkxNzA5dzlu?=
 =?utf-8?B?b2RoU1YxV0QyM3gxd2o4L3FaVW5maXhxSVI2bEdKanZvOUQxalNqbTR4ekJo?=
 =?utf-8?B?V0RES28zbkpBbDc0Z0lHOHpxYzArNVc0dGRmMllNY2tORmE1N2JZbitWMGth?=
 =?utf-8?B?MDczV25UQjdhVXhSMUpVak1ZbWZ5VHNDaW1UaDhMd0M1QUE2bFBHclpIY3NP?=
 =?utf-8?B?S21DRmEwQkNVQ3RTTFU2dFF6enZUZU5jeVpWeEN6MUxoM1R0MHk1cTlRWDY1?=
 =?utf-8?B?dnFNZE1WbGpiLzFlYmFQY1BSSDlMWEVoMnVhS2U0cEgzcFZSeXAyTFNOYWJ2?=
 =?utf-8?B?R2tPNTNnQ3FFOXN3Y1RxQVNLWkhjTmZnTDc3dkh0MjA1bCs4bzdwckIzN29n?=
 =?utf-8?B?RktNdXo2SzBrbHVlRFRYY29nWXBrWUorTEJBdmdUZmlUUG1SdTR1Y0ZxVTNC?=
 =?utf-8?B?WlZENW5sMWtxd25tQ3pmSWJyZVBkc1NzODVsNUxhTU5pbC9nRGlrMnNMKzVi?=
 =?utf-8?B?U0J2SXdOK0RFWXpYbk84UkRJejJLcjdYZTB4YUY2OVRvc3JEVFNWMTBFVGZT?=
 =?utf-8?B?T0lBeFY4bHFDeC8wQmdrOERaWE04bFJiQlZrOUFUM2pQR1ZxQlBqRmdyNzFU?=
 =?utf-8?B?Wm05MUhtRnFwMWtLSnppVVJFUmtQNkVuOTJJZWJ5QW1FODBqcmppbmZZU3RP?=
 =?utf-8?B?MzZDYXp3MnZ3eFJkczRzUDA1RlEwSEpZQklYdjkwQ3pGeGt5SW84SHZvL0lk?=
 =?utf-8?B?MWptNmd0WEhEMjFidWlHRzBHSEEra00vZDNNdFpDSzVRQ25HbE1TOHRyVWl2?=
 =?utf-8?B?YU80ZGk0YVUyNlROcEpGd0dScXhPQUZqem5QbURaL1FZN0hqM2U2bkVpNDBX?=
 =?utf-8?B?TExweUtGYUV1VlN4Y0FtSFF6Tk1xc2VSNWhhdlBDVENnaFVIUUcwU0w2TUhi?=
 =?utf-8?B?Nm1PWGlvRUNoUEZxVTg2aklDZXFHR3J3NFlNb2E3OGxrRHQ5UGNTeHExVEFP?=
 =?utf-8?B?blNuOThtU3BuZG9rUXNPL2VmT3FrcDVDK0FYQ1NFamh1UEZFb1A0TUVEeVZi?=
 =?utf-8?B?WnNaWEtHcDZTMzc2L3owcGFYVUdUM05VUXRxeDZHN3VmajNkOE9Ta1dUWUFK?=
 =?utf-8?B?bThIZUdoa3FzcUF3SGY3cVE5OGtkaUpwWkpIb0hmUUFTUzB3dE5JZVlaaFUz?=
 =?utf-8?B?bFRreUd5VDB6aUg1aUltWGRwM1VqbUwrYURzcFBOc096dDdPdm5IeUx2bGJN?=
 =?utf-8?B?emN3RTQwRlZBODNNTW1FUHZic054SXhhaHRtRFVJMElZWjZnOE05QVBnVDB2?=
 =?utf-8?B?cUM1T1JBbTJLRG16SWwxYWd5QlhKNFNWbVN5OUZwNjZNTDNQcFdja1dzdGxl?=
 =?utf-8?B?d0J4ZmZjcmR5K2NSUElIeWJMVXhUbDFQQWEzUExFWnp2cjJTcjFZOVNSWlUw?=
 =?utf-8?B?dzA3L1BlaU50NWZOTjhKeGZNd241aXVQSS9MbVRoUXFCbGZTK08zcmRtMUJN?=
 =?utf-8?B?VSt6eXBSbnJlbnhDNTNxTXU2RFg3RnZFbTRxdVRMOXVoK3JPSi9lYnBaN2pZ?=
 =?utf-8?B?ZTRUSzh6WFh1U3VqVk9VS1RuaFlqaXJHRldMTm1lb002a2Q4L2lDb2ZZcDd2?=
 =?utf-8?Q?UKoRm9c/R84ucmJFJi1S1mCMy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a27b262e-505d-437e-74b0-08dc0d025638
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 08:51:26.9494 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o1bs21jDW+OQAGjrGTIkkO3zDZZrsQhcHMI4eMmoj8i/9uDc2qYISnmz2HhZqVVC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5367
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



On 12/18/23 13:57, Michal Simek wrote:
> Describe ADIN phy present on KD240 via ethernet-phy-id compatible string.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   arch/arm/dts/zynqmp-sck-kd-g-revA.dtso | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/dts/zynqmp-sck-kd-g-revA.dtso b/arch/arm/dts/zynqmp-sck-kd-g-revA.dtso
> index 8d0ddecdc14c..298e80265e2a 100644
> --- a/arch/arm/dts/zynqmp-sck-kd-g-revA.dtso
> +++ b/arch/arm/dts/zynqmp-sck-kd-g-revA.dtso
> @@ -120,6 +120,8 @@
>   		#address-cells = <1>;
>   		#size-cells = <0>;
>   		phy0: ethernet-phy@8 { /* Adin u31 */
> +			#phy-cells = <1>;
> +			compatible = "ethernet-phy-id0283.bc30";
>   			reg = <8>;
>   			adi,rx-internal-delay-ps = <2000>;
>   			adi,tx-internal-delay-ps = <2000>;

Applied.
M
