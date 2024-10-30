Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 530E5D74961
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 04:51:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE194891D6;
	Wed, 30 Oct 2024 05:51:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fBvKwIbA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B752E891E2; Wed, 30 Oct 2024 05:51:38 +0100 (CET)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20625.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::625])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9576D8918E
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 05:51:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=love.kumar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jbf1Z7h7bKmlyn6hviwqvxUkjccMUOn0DvYQohPkcg1JsnJPCO/5macoVV2ZsQc6T2fjcGm+CefqhRfeRu4zG7/3Evm6enuL1ZeZgA+RqQwCRAAYekKj2YbIhraJ1Y34l4kc/RYNavjM3KIkgnACcdc/JXMZ8sT/LCd9Rk9v5TUS/CYxFtr3XbplgsezNmb28sCRzAwQe7V2MpKtIkgUlPJ9NVkWNHrhhfuTRjlqyUOIrFVzdHvitm6Fe51JgFJfzJULnReN6/AXo0ariX9336ablWGE1j7dIhV/jVU3VqLlxNHyuCOVI+zjv5ICqHEkMSx1b0EZlPAO7gvra96gpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UdDuYqgd3x8Ujq496Vn+velE7WkwuROtjD0C2B5IFhg=;
 b=lHQOFZfgHiG9662AsDn1PC4v5rujHy+/9+ObPaOcT3jvUfOEgQ9RRRc+wwhFPGTQAYuXYjIws+03UW4aJZPAOenzuanMCAsBuKDaA2H1xeLfhBx5XLwdL8Xo6ja2aOcxKZKDHLileBPdu4xIaM5MzXdr26Y4bj3RyttsTAciGsC1wyXV0eZk17J6NkNEoTJqt/HILemgMu06tzAzbj1hR8k5kSNI/xo68bhezv8TkU3qGoYd0yvvdeBV5KY8QHm/gH/jeXCi1q+ey9bUB5fKHWTQxBJTdk2CdJZFO71CDWx7SkewAeDcW8LdEYnvKuUZa4NTZJbjCo5KPadR8+Coow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UdDuYqgd3x8Ujq496Vn+velE7WkwuROtjD0C2B5IFhg=;
 b=fBvKwIbAP8/wBBfSERjcWZ0U4FV9jZ5zxOo2Ct0ZsBIKX/tMEfavSGCk0U0NDkN+vO3bp+/YxhNbwFCYuDZTUR8EDKlgBCXiM3JGPv3HwymXCSEu1UyyicFJBN+bkv2avEvO4ZGF28eeKLhUWtTb/HCKL+4ZJZNYIR1O/NtC5pw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6538.namprd12.prod.outlook.com (2603:10b6:510:1f1::11)
 by PH7PR12MB6835.namprd12.prod.outlook.com (2603:10b6:510:1b5::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Wed, 30 Oct
 2024 04:51:27 +0000
Received: from PH7PR12MB6538.namprd12.prod.outlook.com
 ([fe80::f0e4:5de5:39b7:ea7f]) by PH7PR12MB6538.namprd12.prod.outlook.com
 ([fe80::f0e4:5de5:39b7:ea7f%4]) with mapi id 15.20.8093.027; Wed, 30 Oct 2024
 04:51:27 +0000
Message-ID: <134bd09d-3f2c-4790-857e-606e3191f3ad@amd.com>
Date: Wed, 30 Oct 2024 10:21:19 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] test/py: spi: prevent overwriting relocation memory
To: Padmarao Begari <padmarao.begari@amd.com>, u-boot@lists.denx.de
Cc: git@amd.com, michal.simek@amd.com
References: <20241029114709.3983243-1-padmarao.begari@amd.com>
Content-Language: en-US
From: Love Kumar <love.kumar@amd.com>
In-Reply-To: <20241029114709.3983243-1-padmarao.begari@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0023.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4e::18) To PH7PR12MB6538.namprd12.prod.outlook.com
 (2603:10b6:510:1f1::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6538:EE_|PH7PR12MB6835:EE_
X-MS-Office365-Filtering-Correlation-Id: 21f302dd-2076-4613-376c-08dcf89e8319
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SER3aVM5MTM2RTFxRnkrcGtNdG1BckdEQkZ1V0RKbkovZVVoaEhCUHdTNjcx?=
 =?utf-8?B?ZVZlSXk5SlBtTlQ1a29uMW41SnBFdUNyNkNGQkxIcUMxcXZ4Uk5tV0cwcGZO?=
 =?utf-8?B?RXc3MlFSVHFLNEdmcnEyUm1IWEcvbkhYWDVCS2pYZ2dua0k5T2FhSm5RYUcw?=
 =?utf-8?B?VEhGQXNEVUNZZm5DdEhIdGZDK0dVRjZQTVVQTmVLbmhxa2pwK0E4QnRjakI5?=
 =?utf-8?B?Zm9TZHNVQUlteGQrQWFMcUJKWFRKOUZzSXZDT0I1bUxISGpnd1N4MkZrTDF0?=
 =?utf-8?B?bEJjUVRzdlA1UEVUcWgzWkJlc08rNkw5YlFSZlJsS3FERGNQRkdhSXRvYlk5?=
 =?utf-8?B?S0Y1cGhoTFkxNkhWSk5LeURWaXVkQWNyTmUzNVFzTDZHMmFYaGNONEVsdHE3?=
 =?utf-8?B?V3Faem5QOGRqYWF0Y1VkNnE0ZTMyekR4M0FVQzBKV3A4M0Y0c2FDcFJVdzZD?=
 =?utf-8?B?VytZVmR5L25OUTkrcFpHaDA3eHRFdzd0ejBWbWF3Yy9BbWljRjJaOU43L29I?=
 =?utf-8?B?U0JzeEJ3YWY1UzYzUk5vZXNBRlk3QUNKbXVOMFBOeHo1RmRqL0VSK3AyQVU0?=
 =?utf-8?B?WFRIZTY1SXFvQUk0STg5MWpmREdwMG92R1UyRXNoNHNORG5pWE5mNEtySkNz?=
 =?utf-8?B?dUE5cDcwdXZ6cE1McEJ4UE9nK1l4Qk5LZGxaOGRJNXRodUF3SnFsQzhHYm9k?=
 =?utf-8?B?RW4zbm41S0NrMkZlcmtyMmNmd0h3NnNpTDZUYmhuRWV6Sk9GcHA4N1NtRWh1?=
 =?utf-8?B?eWdlZEpEbFJuanNxb214S2tFamZiZU1BNVJ6WUJCN2lqT3VSK3JBdTN4ckJ0?=
 =?utf-8?B?eTVxL1YvTE1tN20vbVRHOGpkWDNYTlY4NkthdE1NUzNIalVWcng4cktuTE8v?=
 =?utf-8?B?aW91d1RqazFKMklCNXYyZmlEWDZJeGNhYXBadVNncWY5MFR6aUZQY1RLRXZs?=
 =?utf-8?B?eVNIbktBN3hyZEpsYUVydzdJczM0OU1QTlNVVUdheGZxUFk0WmY1WXMwdDNZ?=
 =?utf-8?B?SEErS29vZERYMnBKQTh0WERWbUI3SmdQQnNYRDI5TW1iSWhVRUFjKytQNzhO?=
 =?utf-8?B?cE9Oc3dzS2ZtejFnc01TVDRodms5RjFhc1dJYnBrcnlMRDJPQmh4NXcrWkxL?=
 =?utf-8?B?ZUlScCt1Q294eU5nZTNqdEZJV0FhUFh1UEptRXNrUEcvRThTY2tQenRqaTBX?=
 =?utf-8?B?ZUh2TENVSEY1RWVKTFoyWUV3aWRaeTVOL2xXQmhib2xsUE4wNm1vRU5MM1U5?=
 =?utf-8?B?TWxndFBmdDlaMGZQRFJhMzBYNVlPL1dtaEVJK3JTbVp3aFYxQjNUcDR1MmlU?=
 =?utf-8?B?NXJhZ3YxSjhQeGRBWDNBSFMyOTlDUVJuV2cwNHoycmR6dys5dU96Z253YWcz?=
 =?utf-8?B?OEZUWVh1a01kNmxkZjFXaHBtL1Q5MDYzTzB3SlFBby9rcUFWc2JuR3czTG54?=
 =?utf-8?B?MTJpRVRwZlBMeUtxL1pjQVFxOEMzbzZLV295RWNPcm11SllRZG5KeXU4QWo2?=
 =?utf-8?B?aFcvSFg0T0lOZ3dJcGZpeDdCeGtKVnFjcXM1Wis4R0EwK0ZkcENZQU5tNWs1?=
 =?utf-8?B?Nll2UTVtcHNvc1hhbnZJeGgzdVhOeEt6NHNqVjNHRkh6K1pYOGxlSmNmeFpr?=
 =?utf-8?B?b2U3dXE5Z3hUTE5pSm1WbUsza201eEJmNUxRdGMvLzcvU3RlRUN3VEpabWUv?=
 =?utf-8?B?YVl0S0dqbWtpRDd5K1pSMWU2dElMYXUwcnl6a0dTMTVXMzRMYkNUQ0FJR3lE?=
 =?utf-8?Q?VYC96MQz1YyVzfSM1VWhW56BAsqREXHuPmvwdNz?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6538.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eThkL2MwRy94bjc0VnowaktsaDFjaGp5RXJLWWk3bGVrSE0vWjk1SFJ0T1Jv?=
 =?utf-8?B?SlRjR2sxZlliTmhza1YxaFhiaXIxL01CdUI1bjhBV212dW9oank0d1ZLb3dH?=
 =?utf-8?B?Ri9QNDhLZUFISUVmZU1xb3k3bVhwN3FKVS8zYlh6SVBHTXBadnRjQWZaeTZp?=
 =?utf-8?B?U2Q3c29LQW51SXF4YUFhWTkvUE5ueGxvY1krZGE0ZVR1WWYyb0pWMXRjckFW?=
 =?utf-8?B?aEN5S254SnVMb2dObjlUNm5yK1VYQitBUGxSTk4zTlN2TGJ4dFU3UUdrcDhz?=
 =?utf-8?B?aTZJK2I2TkttNldSekkxUDdFSG81TjFRbTl5ckZQbWY2ZGIwVGNNclgyL3pT?=
 =?utf-8?B?VmZVN1Q4YjBXUkppTUQzODJ6QTVkWVZlbVl6aUVKNENmM2ZpVTZYMmgwVWVw?=
 =?utf-8?B?VWU1eWllWm50K3drK2c1cUxBTGRWc0RKQkVQZTN2ckFjYjJOVC9aMzEzM0hC?=
 =?utf-8?B?NmswMkZkTlI2Q0pUdG95OHkxNlNPRzVFejU4L1JNRmJGL1g4QU5VTkluZ0NP?=
 =?utf-8?B?RVF3MVlyL1FqaWUyVXg1Zm50QWlnbHdRQ0FtYkloYWQxVzR5aHovMnh5SmpU?=
 =?utf-8?B?MHJGRy9yck1pZmJwUlJtblkrajViYTR5L0hNc2FmYmozUU1KZUhNSjhOK0du?=
 =?utf-8?B?U1puTWZUSzZ0WW5RM09EQzFzczk3cnVpN0dHRUtOaDUyN2UzdGxyRk55aHEr?=
 =?utf-8?B?NnFjZkxYbFJOelF5TndFYUFaNHYzeG52ck8rckR5U3JBckVtSXZueFdiTW9K?=
 =?utf-8?B?cm5CR0FKWDE3YlJseEJUamtzYlZveWxZSFZOWnVwK05RTi9BVzdwa1F4Rnc2?=
 =?utf-8?B?aXpoQVorMFdKSThOVWF5ay83T2UwSjdYV0FoTmZncE5HQjhNdGZJVEE5a0t1?=
 =?utf-8?B?SUVkQ2gvR0RKcnRhcStCcU9EUC9yRFRmOXFJVVlQWE1zVVYvd0EreDFCb3Vz?=
 =?utf-8?B?QkpZaUFnbWpJRWpyalBrK2hSWVZVYVRXaWI2cWFxSTV4RWQzRXAyS1F6cVh2?=
 =?utf-8?B?aFRkd1NxaGFZS0hyWEVDWFAzajNMTXJ6bm90N2lieCtOeUpIaVZPb1ZJb3R4?=
 =?utf-8?B?R2VGV1JDTXFZdDR1dmM4cWxwcWNDbWFDOUMwcENJYkVIQjlFNzVUM3RqL01n?=
 =?utf-8?B?YkdMcEdWdGUzS0xkUTRkU0pLc09za2ZDZnVhR2FUQ2RYeWJqUXZHNkdPK2cy?=
 =?utf-8?B?T1RIeVNjaTU3bnBkWEhtMTRqdUp4Z3NGZDRseEFoVDJHbkMydkM3ZTQzR1J4?=
 =?utf-8?B?eUpWQy9qYTJXYXNGTmtwS0MwUVBqRkZoVldBODVkeGVKSVZ2UXkwMEN0VytD?=
 =?utf-8?B?MTJlcGRJek1DdW1xMHZ2MzFHOXRVVmRWRVNEa3BhTEh6UXRFN1QxYTF2QnVw?=
 =?utf-8?B?OVpsd0NlSWFzZndGMFpiZE1DWERrT1lKa2lkcmdsaFRsU29VeFlIb2pFeThV?=
 =?utf-8?B?c2sxU3N6M1BTcDJMYlhjOGdxZlZkY2dBODdiZDl6NVFBZ09RdlNKNHhnM1dT?=
 =?utf-8?B?aFplRjJQQ1ovTDBBNFkwZGNkYXkrZFRvalVZUERnNERQSXl2TEI2K1pDMllC?=
 =?utf-8?B?a0Vva0huRHBzc0N2cWFwdnYyR3lUTnJNeXRtVjBlbzE1V3UxNitjK3pzWS9s?=
 =?utf-8?B?UFRxQ0ZML1Z0OTNHNHF6cm1weU9JYjJYTjN4REUwWjVkbFVyMW44WkhIU0Vy?=
 =?utf-8?B?bHYrN3YzUmxLZUFoY1U3eVRBa3lZV3ZZbngzOGp0ZG5JU3R4T1IzTmxQbjRJ?=
 =?utf-8?B?ei9sVUJQbGlMQTJrTVBja2FWSEM4Smt2U1NOS2d2MkdoRWx5U3JzMk9lTTBX?=
 =?utf-8?B?Q2NxazlMbjhWNjI5eUpOdURjUDN2ektXeGZwcnhPTkJDUEFId2kwRnFCUkxY?=
 =?utf-8?B?STBFMGFJZGNqTGNtWGtKRnFtZnlIODhoOFVhc0pmUXVNdE05L0lRMktoQURj?=
 =?utf-8?B?VVVRYWZsMVp3QXZIT0xGWUl1QjlUaXdHUjdHZWF6aEZSNkVMMlg4OFA3VkF3?=
 =?utf-8?B?YjExT09CSXJRR05iYzR1aEhLY1NoSFlMb282MFZ0TUp3RWpaOFR4ZTExSGFM?=
 =?utf-8?B?QXpKLytkQWI0T2pTK21SRUZDczVWZzdRdm1JWklNS3lUVFFyN1BCZE1rNExq?=
 =?utf-8?Q?3YJY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21f302dd-2076-4613-376c-08dcf89e8319
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6538.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 04:51:27.1167 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pWDRCegQqe2WPxl0epAAzaV0ZE+f2XhbeCNm62YYPIr+psjfASpSrT4XWCMIUyFs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6835
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



On 29/10/24 5:17 pm, Padmarao Begari wrote:
> Update spi negative test case to prevent SF command
> from overwriting relocation memory area.
> 
> Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
> ---
>   test/py/tests/test_spi.py | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/test/py/tests/test_spi.py b/test/py/tests/test_spi.py
> index 3160d58540..caca930327 100644
> --- a/test/py/tests/test_spi.py
> +++ b/test/py/tests/test_spi.py
> @@ -693,4 +693,16 @@ def test_spi_negative(u_boot_console):
>               u_boot_console, 'read', offset, size, addr, 1, error_msg, EXPECTED_READ
>           )
>   
> +        # Read to relocation address
> +        output = u_boot_console.run_command('bdinfo')
> +        m = re.search('relocaddr\s*= (.+)', output)
> +        res_area = int(m.group(1), 16)
> +
> +        start = 0
> +        size = 0x2000
> +        error_msg = 'ERROR: trying to overwrite reserved memory'
> +        flash_ops(
> +            u_boot_console, 'read', start, size, res_area, 1, error_msg, EXPECTED_READ
> +        )
> +
>           i = i + 1

Reviewed-by: Love Kumar <love.kumar@amd.com>
