Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4990CD11DD
	for <u-boot@archiver.kernel.org>; Mon, 25 Mar 2024 14:17:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65FC187EF6;
	Mon, 25 Mar 2024 15:17:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QUMhQM88";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B27AE87F07; Mon, 25 Mar 2024 15:17:28 +0100 (CET)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::61a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 932CC8718A
 for <u-boot@lists.denx.de>; Mon, 25 Mar 2024 15:17:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nMvXIabd2hTN2S/WE9uW6oRtg4lEnMrwq8xVgVZd+tHp0fsLrpk4eZsRMrypMUY9KMmqw7oQzFtnMkaLLw8MLbk2gdXBPdBBmH0yYDSEusoJmftkF8OGu4tHx352OVBRPV27Q3/8JSs0cZhSSOy3zUmqmZmyA/vx55t3TzBLZOolTvpcn7v7+R0GpujNHZdyC+YksjzpXDwkKQskbVSBwBBbIlMrPeC15n+m0mBOc4UraEGbpUHFl66UfrXrBYCzCKgvussZncVIM9n9KQDmMTrXmlWHlc88cH4HSmeFF4ZRmf7hkwGwKKX/gIRVVNe/YUxM9uIo/df8RG7lTtkTBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4fo2FM+t9sHHGItHjZgJ2gDcmleykJygm6VoUKkiRzA=;
 b=kCL0wRx1JW5hSrllPUJnVDQqQVY/X3ho4sPIjhGM3L2YeckNLP0yhXTTXsz9ViyqRtsCgDwg7YoK0VLlPJmNEv1xaeWlv1ADzD1zRqFCYXmhsyXYSBUjbO4mHbV40FceA5pAcpc/k/U2ljFafeAhTSawZaynmcL+FWfMyhdEp2Aw4tcw594iuOytgp6p5BMHUxlTeuKPzpOJJakXHYlVW1HBoHV9xHPg0W9cVX2OAUvBwOd+eaw8i8M1mJJ1l3wGCZxpjywf8YrrobR4TH2mWl0OP+KmeQK5dXStkxSHcOQYYxPbRzNdGsz/NDhqLsgDH2LL8xgM/YYNxvoMMQiOaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4fo2FM+t9sHHGItHjZgJ2gDcmleykJygm6VoUKkiRzA=;
 b=QUMhQM88MwbhwYQ1S0xPoSfSojWrmzYj/UDS3O+iZfG21ug615w91XHWJHHrnifnKadwh1vwvG+x7St6APM0TFsRZtBOE4qrm7wrg6FtwiezgxNm0Z7GZ2KaOfV6TgLb6vw/06jvb7cYuLMq4NhJskQn5Ed9tdj0pd/fB48MOA4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by LV8PR12MB9153.namprd12.prod.outlook.com (2603:10b6:408:185::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 14:17:23 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907%2]) with mapi id 15.20.7409.028; Mon, 25 Mar 2024
 14:17:23 +0000
Message-ID: <1adf226b-b633-418e-853d-e24450f733c5@amd.com>
Date: Mon, 25 Mar 2024 15:17:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: zynqmp: Disable Tri-state for SDIO
To: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>, u-boot@lists.denx.de
Cc: trini@konsulko.com, venkatesh.abbarapu@amd.com, git@amd.com
References: <20240321085220.2920792-1-tejas.arvind.bhumkar@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240321085220.2920792-1-tejas.arvind.bhumkar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0219.eurprd06.prod.outlook.com
 (2603:10a6:802:2c::40) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|LV8PR12MB9153:EE_
X-MS-Office365-Filtering-Correlation-Id: 1591cf66-84f0-4fed-2803-08dc4cd64a1d
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BVJ21pFLbQ+dwfaE+hXo3oFB/KJ5zMOGmsOhKzgkbBaYXZnZrM2X2T+0+K0RhKmeEULN86Xo+PYmEJWfthn+znjJ1yimlCP67/WOiPiAhIuAoGvqRDVpjKvv09XvPMEhUBd2iJ4ln1muJCobWA537CUFVt6CyaAPyncwHcbTtFdAVx3AwxQCtMTtNMDzezcqbRVzjLKmwKERwGD9V5rfk6BI6hS/S/qSoZqKAcEUD/xp10Ue4dwMLyupMSgT8thWOdlzyracIizlvfyOKtyCoF5q92qGEtrkCM3IbwADuwuD1F6z+KAlDkYXdlB3bIOd9gAgbu/9RMNyyP5FJWWc8MJCJQJr1KK3XI7JKMRqgsEGMTjOSB3s5plxMAWC+B1E15SkohGlgdUQhIBW4vnOXYvYybuvXDVuw+8gi2Uw4uOWS2FIU72fnrU1GmjXEZhw0+UxjaJyjjeUzScGuzZzJ55IiG/DuYTd54X7TAj8z6Np8JmoX2xjqHRi0rDquy2ZgyGdaC3wp9qCLNBKXIzsbpl4IAnpimEsbEUL68s5JPr538LJwy1dv13RDyGFzTesM7ZThRUgOptMx1+d3jtq2VkrvH4oKAOKDeTEvrI/XvIbBnemgpT3J0L0lxEAi9uCdYe7UW5srtHjPOLI8RakSX7/ZGqSow/tEjPC0j3nrZU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YytVdXp1SEwzSmU5bzNaUm5YbU8wV0tYN2FkOFEwczFvQkVJYitLM1p0dUhO?=
 =?utf-8?B?YXJVYXo1cGFZS1FJKytvUUVsSHNkdEdzWVVjZVU1NFUwU3d6UU1JZFloWG9u?=
 =?utf-8?B?VzYyOTFUbStNbFpteE9uK2VlKzlPWGlEZDR1Z1RjVVJqUG1EZDJpR1ZrYUhT?=
 =?utf-8?B?WlZUM05oNEVJQ0UydC9xTHd1bnB6aTdwT29MeFRUQ3N1U3R0RzBKaXEvVWhQ?=
 =?utf-8?B?V3FRTXhGZmd4NFlHMk1lUEc4K0xYc3NoNnJsYnFNNXoxZ3p5YVZOUnNkYktq?=
 =?utf-8?B?eTFNSHduMWpURHhNbEtOL3B2THB6NmJ1R01idDh4SVFuRGxCcWg2Q05ZcUZ0?=
 =?utf-8?B?ajUwWEtURVFEcFFaTndNUUxKdGl0U2NZYmRETzFldkhBWUF6V3JMYThCa1lZ?=
 =?utf-8?B?YUszbnFLWUlxZ1g4NzYzaVJWcGNKT1dTN3hiRnJNUHE4VUZJT0pXcGYwODBO?=
 =?utf-8?B?SG1Rc1c5MGVoTk1sVTdiQjF5Nk5hczBqekphNjJUbld6WWFyTUZCbGRBVU5R?=
 =?utf-8?B?VjdSSGxqa05URThueFdUeVVCdGpoVllGdjQxbVBVY28vRFBSVExWMGhrSXBR?=
 =?utf-8?B?T3M2WVVGUXpqam1JQlRDY0FmekM1QzRTbHlTS3JrODJacU55MVczWlJzYXFX?=
 =?utf-8?B?RkV3N1FhK0Y3cVhWSjFIaXdlRUFVU0oyMzlDaHJOSFplaExVM3l1dW1Cb0tB?=
 =?utf-8?B?NFJ5WkJ1NXFJTXpUUVVFS0lJYmJnYzdiRTk3STRha0tOT1J6MlFRdk1KaGoz?=
 =?utf-8?B?Y3ZJQ3IyYWc3OWxrOUV3a1BzRzR3RkpnTkloQjFTWkN2MjVDdGZJUElaWGZK?=
 =?utf-8?B?TUF1bUF3Rk1aVE5VUTRsaGlVRGdjSFVrY0gvV2UvY3FxTzFpYm5Cd2N6d2Zo?=
 =?utf-8?B?NjlSWkx5bUJNcUkzdmw5Ulh6Mkd2RFJqZWFvTVk3SlJ6M29FcXk4TVEzZjlR?=
 =?utf-8?B?blNvMmVUb3RZbmJkckVwb0RtekpROXlpcmxrdE9mZGdlTVFvVlhvYW05Sld3?=
 =?utf-8?B?WHVIK01CU3J6czJsd2FjWmVuNTJ3UFlCMGtseGYxRVdWV3ZndnBQZWNHK0pQ?=
 =?utf-8?B?c0tua2ViSjREenJWbkdQRnMvZnBVTTFUVmI2Q0U5V1lmV04zdTVia0Y2Q0tH?=
 =?utf-8?B?UmcyUm5Ka0xiNVlERFhIUDdYYlpyOFM1SjV2Qi9NK21xTWMxWndEcjNvUnlI?=
 =?utf-8?B?RU9vNFliSU00cysrQ1c5RmNxZ1F3U3FpZWdZdVVRWTUxdHF1UnN6ZkdtT3VV?=
 =?utf-8?B?YzROM0ZzT21iZDIvYmN4RmhKM0FWaG9GQXhMNjZ1NGtPMStjamZHbjBRdWE5?=
 =?utf-8?B?ck9OcUJMRXoyM0lJWWtyZWVlNjhBbExYbWdBaDBsdWVwQ1VrbGJLbWNXdFho?=
 =?utf-8?B?VkswREpNM3VSVVc4YVpCTmRBU3pqMWNERmZyUU9lL3RJTEgweFN3S25UUUQv?=
 =?utf-8?B?a3hFR090NGtUenVjZzNSdVRFN0h0ZGtNRUd3ZlhJSFNZWDF6ZGhKQUxOUytR?=
 =?utf-8?B?Q0JRU3FNQjZkdjJNSmR3RW1EV3l2dnMrajM3SnNONlJCZ2dUK1FVaEVybXEw?=
 =?utf-8?B?YnM4S1pZSllEV1dMQkdLaXBVbG1BNmNNNWF4MjhtZm9zNzU5ejFmWkt0andE?=
 =?utf-8?B?VXR4S0NpMUFYYnhLeWZDWTFCOGI5NTZRK3ZzY1doL1hSZGtXMysxMW9IcmJP?=
 =?utf-8?B?N20zb2pnT1NPNmVBcDdWNnk2bkpWeUIvOFBFaHk2STNMY1d1ckViT3YvMnNk?=
 =?utf-8?B?TXl2U1NkNmN2NnJjS3JwNDNDUGZCWTB4YnN6R1V5b1dmMExXZldDbXRNckt5?=
 =?utf-8?B?bmpPS2NTWUlRZjRHTEl3WUFuS0tHSGZ4RDJQWmNPNTFwYTlnWVFaM2lMMU5s?=
 =?utf-8?B?TklSaExrK2J5ZTExZk5OMnR6ZForc0NIdURkWnA0NE5BdGpDQ3JiYnlXV3Ju?=
 =?utf-8?B?WmF4Y09IVzhDZnFseVZXb0w4R1VCZWQ0UHQvQnk4UFpJV0FpYkJFVFJmQ0RH?=
 =?utf-8?B?QU0wV3ZvRmF6djZZczVFbG5RWW51OVVlREZiOXJDcHB3dHZQcXJsVG5YWU9L?=
 =?utf-8?B?RE84b1hlcGIrTFFQdTd2ZW1XdDlCRTZLeDN4ZlpQa09Yc2FkalI3ZmErSlhR?=
 =?utf-8?Q?Mt4lea4K+amBAQkVF52qh+ftC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1591cf66-84f0-4fed-2803-08dc4cd64a1d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 14:17:23.2826 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OpoBBxmb6uW9YjIyo00E6+nK7lq6ln88bxBBEt3ONqqBvcUh4yLNwbsrajuz9NI6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9153
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



On 3/21/24 09:52, Tejas Bhumkar wrote:
> Since the zynqmp pinctrl driver now includes support for the
> tri-state registers, ensure that the pins needing output-enable
> are correctly configured for SOMs.
> 
> Currently, there is an issue with the detection of the MMC for
> the SOM kv260, resulting in the following error:
> ZynqMP> mmc dev 1
> Card did not respond to voltage select! : -110
> 
> To address this problem, configure the SDIO pins for output-enable
> to enable MMC detection.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
> ---
>   arch/arm/dts/zynqmp-sck-kv-g-revA.dtso | 1 +
>   arch/arm/dts/zynqmp-sck-kv-g-revB.dtso | 1 +
>   2 files changed, 2 insertions(+)
> 
> diff --git a/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso b/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
> index 6d0d5c487d..561b546e37 100644
> --- a/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
> +++ b/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
> @@ -342,6 +342,7 @@
>   			slew-rate = <SLEW_RATE_SLOW>;
>   			power-source = <IO_STANDARD_LVCMOS18>;
>   			bias-disable;
> +			output-enable;
>   		};
>   
>   		conf-cd {
> diff --git a/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso b/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
> index a4b4465d20..13876fb47d 100644
> --- a/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
> +++ b/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
> @@ -329,6 +329,7 @@
>   			slew-rate = <SLEW_RATE_SLOW>;
>   			power-source = <IO_STANDARD_LVCMOS18>;
>   			bias-disable;
> +			output-enable;
>   		};
>   
>   		conf-cd {

Applied.
M
