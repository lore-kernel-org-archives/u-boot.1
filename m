Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 604C1CD343F
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 13:42:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABBB584A7D;
	Thu,  7 May 2026 15:42:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="hDDuPsRP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AEBF184A9E; Thu,  7 May 2026 15:42:22 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 514C284A78
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 15:42:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ByccB9Q6HKIpsFeME8Cqg3EQvA3kmMN5+DXknI+vrc4WBBrY9sP9uVw9EKPdJFWiApm/P+iN0IUuPftinBvdm4nrjznLUzw8aA69+f/sMg1TLxgvZYap6thyhOmWyHySfJc4mft7LKAVLlbBPsW4e0B2724xy+WJ65ijRfpwWKmgTIXkKrtPBi9kKptgwWYQ1+X7BQS7PmwTLi3TrZ0igqDwmOiO2ovYyLSJu9faUbKWfM9fFVHeb7Lw+RqsogEGesO8Ln8FMMaYh8TJHi5sIZUiAWfB1CoykEXJXPOjgmQiaBWHgXzLWsH/k53fPZ6t2L4c2R7yYD+xmZrDcSc7iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OVLSI+7V1U2EQurCA5oBvw+DaHO7A6CO8CZSttUBcK8=;
 b=S5yudItYPNCwjTNee3b7GtGiOaoyZ1FOn752rLR8S4ua6o1o7nYBAbRNgs+QrL6WRd9dxE1wZeeadkuirKtzHJ0ca62xi8aLf9oAMm8YEYVCosFb9rgzmHfgBFu6sSTKqJ4PFeo7HeTO+r38SfDroOxaAgjIrAeP0KYwCckrAVCeeRon9EZsRL6Gs++ncN70B+TFQVHDG5OORw0sFnM890fIzLG9G5/szdMWZosO19Daf9xAztetC7hi4wcR4+dJGNm07SNKvP/H913tgDHVyc5KawCYFG5vB/O9glS2i9hzdUkhcYDA9XF2VNW+VC9E3RIloPNiE5XURS3lopkfBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OVLSI+7V1U2EQurCA5oBvw+DaHO7A6CO8CZSttUBcK8=;
 b=hDDuPsRP3W5AAhDD6oLomsb/EjRxqc5TufgoXTK6hxwhRzN266PPK2B8S/y7HoWMOh0nAS7k+Cs1oxKUxiwNhm/N8qA/lRakLoB+jidBj++zGUhtCFGKuFPbMuKVCbFp8MMqlRpWUqe5u7+0T8qcSFoYy1EgvExqAu1VjQ1jzSM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by AM7PR04MB7189.eurprd04.prod.outlook.com (2603:10a6:20b:116::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 13:42:17 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%3]) with mapi id 15.20.9891.008; Thu, 7 May 2026
 13:42:16 +0000
Message-ID: <a5c42652-7346-4775-a13e-e9d74c393ee6@cherry.de>
Date: Thu, 7 May 2026 15:42:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/8] disk: Add partition lookup by type GUID
 functionality
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Rasmus Villemoes <ravi@prevas.dk>, Simon Glass <sjg@chromium.org>,
 Javier Tia <floss@jetm.me>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, David Lechner <dlechner@baylibre.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Michael Walle <mwalle@kernel.org>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
References: <20260428-type-v4-0-b7051dc45a88@oss.qualcomm.com>
 <20260428-type-v4-1-b7051dc45a88@oss.qualcomm.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260428-type-v4-1-b7051dc45a88@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0079.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::19) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|AM7PR04MB7189:EE_
X-MS-Office365-Filtering-Correlation-Id: 875ef404-ebc7-4860-1029-08deac3e7381
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|366016|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: xXjez0wP/u5Yf0X/lesJ3hJOCTThXbBju9psGfUUO7iCj3RGyNv4mreuZoy0UWhaInVZr7BOjAMfPsAn2CtUxhtWaTjSuvobAyIU0Mtp0W1LqyfEXLNqw8VwVi0dPvPidX+e7v4ZItuYTxYvZURQyPskg8qy1l24CDtZxwcP/fTLcX624zaG3HjeplboGy+2uJiJx0vuMy4XBws9OH3e9LOOqICjRDKEyB0fb06NeycPVIfp3Kn6OgKPM7MZHsQ0DhfDEnrvnfJkwLV4B8JuIs2tbDuqwlYvPIu4xBWtUoN7L9JrRb+IXhnqVJViKmZ3uWd3v8PIhtPjAKDirr71YFaP6ZiIrneQDoFTxgEd/tF7qxCZTvGlgD3MxDIo6cpmaeTmanZybLQX+TDoKjcTg4Yem5MiSi/467sg297R3Z7RzNDmXkPm01Ufri2ig5BnRZxSAurbV1Jrhi+gQan2Lw0Mx0ME8X1pw2I8bCar03o9D9IPGNAgqpshIUzSAahQMSfNxFgpGle5P3+IdeTLK4FzGzL8NfyHF6/JjpnR0cTC8UqJIhxvI4IDbVvhO6jCmLhgrb/aCvwPnvgu9z8sCS/WhRfsiXkno/w30g/laoMqS+pWJFANe9dMq3sJKLO8joMjdgZJiyWJ9J86tL8fyPLHsQf4LvPI3n+geMK4dk4utzz+xpBF/tskLjWw4soQ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(366016)(376014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0FCWHdZSEJrNnc3VWZPYWdmUm01UDNOQmdjcmtQWWwvTHVhMlIxUTVtUHBk?=
 =?utf-8?B?a05mVVh3WDRvR09MVFA1ZElxQUE1bHNhVFdmZm5HNnlPMEdMckdkK0orMFBK?=
 =?utf-8?B?WUZGcmtwV1hvZ3ZrR01FSUp4VkVJczdwczhGUys4MjkzaHVjS3VKWEV0WTM4?=
 =?utf-8?B?bmZLNW52aXNrZzJTTk15OGtLencyYkhwMU1xb2Z0WktEM3FkOGd4QzVpOUxs?=
 =?utf-8?B?STJldzBRTXhVZE10STFxOE1QV3EyTnVMWUZxc2NaRWwvbGR1MlhOUDV3d082?=
 =?utf-8?B?ci9pc2UrVzg5WjFKbVpHQ2kyNUJsbFZoMEREaDEvaC9zYlg4aDNoV21DbURv?=
 =?utf-8?B?ZGhoNGxNMjF5RXJtTDJDVG5Rak1LR3JCZjFGV0ZBOUVhNGhkMk9CTUpwa2l6?=
 =?utf-8?B?ZXhJcWpZMEVMenBOcHhiMUVoOGpFcFRDWUZZcE0rNWRZU0xxR0JKeHR5ZGhM?=
 =?utf-8?B?TFkxa0k3R3NoeGdiVkw0aXo3MkoxWTBGZDVlMmhKcnlsekVZUUtFa1lTUzM1?=
 =?utf-8?B?VUw1OU1KcDFDbyswTFZ3b2VvdjNuSVJzWkwzeWlNblgzNFZUQXBzOExxZG1w?=
 =?utf-8?B?OUpXQzk1MEEreGMwVmswRjB2STAyY29KSEMvSHdMVXBmMG5GS3pnclRuOGtF?=
 =?utf-8?B?Zld1VTFkZDh6QjNUbUoyWGR4TzJROHNtQjJOSDd1Vk9RdXZMNS91cHMyRFgr?=
 =?utf-8?B?YjZCblZOajBWYmp6MWZhc29GYVVkYzkwU25MdTFadTBYWHdjVGpBNm05bEtU?=
 =?utf-8?B?M21KVjJRanZWcDFkWWJtRU9qMFNPQkwrM0RXUzJ2Nm5LRzl5MTJpTS94NDM3?=
 =?utf-8?B?ZFVNVWNkekhaV1Jocmk1RmNESmNGUGZyclZoVHZkcm1zNmFVWkQvS1dVWXFz?=
 =?utf-8?B?d1hoc2Z4SDNmSk9FMXk3RnZZak1oSjd1clA2aXltNXFsQ1J3UngxYUdNRDF3?=
 =?utf-8?B?QmxBY3dZMnloUzc5VFBJbU5HUHpBNHYvdFNhamJBM0pESmc4Y0ZsaUhQSFdW?=
 =?utf-8?B?K0FETUtIWE9OcjVydEIzalcxb2FPWDVCYm50dnBzd2VsdXVRNGZVdENkQnJT?=
 =?utf-8?B?Vmh5VVZhcjcrdVZXeVJGcEpBUElGNUpRRTBzSUdxcnQ3OUorTlBxWkdVTnFQ?=
 =?utf-8?B?elVzakxYT1cvTndJTGROc1dpTDhTdzdoWFJtT0VHSGlyNFNldlRzcndxazJC?=
 =?utf-8?B?SE0zYnp4NTRobWpaQzE2bkFGY0QxNS9qMXAzTVVwVzBickFGVTRDNTVvd0tR?=
 =?utf-8?B?M0swaCtGN0pLcVFwOHBOQ1NiOGpPMEN6QVhha2NzaVNEQXJWek5aMVFOMTdi?=
 =?utf-8?B?c1RkYW1GTGRDTDdqeVFPR1RPL29WNk0zbk4xeHBFQnduaERldHZjbThDVENm?=
 =?utf-8?B?T29rUVZvL3NwVXFqeTVNTVJVQXFqc1JyWTQ0M1NkTVVpeXlXbjJVc3B1VlJY?=
 =?utf-8?B?cmlOME1sQWF4OWU1bmd6czR3MFUzaHFGN08vQStqNnpkc1JjUVFFVzhoYWdv?=
 =?utf-8?B?R0VabUUwVlZta3lPcGg3VE53NkhlS2lMV2xGR3J1bXNYRUxFcVhQREw4dUJm?=
 =?utf-8?B?aFZxbnV5enlOZFFKdDlxb284eHBBL0JoVTByckVVc3FUKzE2aEgwOE45WWV2?=
 =?utf-8?B?Qy8vWWtiVERFSkVkcHozSnlmQVNwcEFHSkZMTDN5Ykw1L01OVHA1TTM1dFFV?=
 =?utf-8?B?K09IMzVNK1BXYjlZdkpSWTFSWDNVS0ZSUmJxRVBTaFBHVjJ3akphOTVsTGYx?=
 =?utf-8?B?Z3BFanZqSmx1QjBVRmM1cWMyOEFxOUJvUURIbGxUUXAwWnloR05YaStiRE52?=
 =?utf-8?B?b25OYS94OFBvYXM1UFdzVDQyUlJUWEVnQXVOZHZPLzJYWnZPZTJCNmxtdlZU?=
 =?utf-8?B?RWkzUmRCbTVwQ2Jwams0TUJIRVcrWHpZbEh2UkxnOGZhRmVhM0t6TVhYdHdM?=
 =?utf-8?B?Nm1WNHlPNFl0Y3lxQmVnRXZNa1dldEVoaVUraEFHekpIU0ZNTm1idG5XTXNE?=
 =?utf-8?B?UlZyczRzMzBkYnd0R0pQVVR6bGxENnhqc2Jab2pUOXV4WDR4MTV6b2RoYjZj?=
 =?utf-8?B?NG5LNHljUXhkeFlmd1FKQ1pxUnFwdWZrTldzanBORVpwRVArQ2kzRk4rNWNw?=
 =?utf-8?B?QTBpblJmVzdHRlRRWjl4NjdNUDBqQU50RjdPYzd5M3E0Y010YzFRMjh5QlVQ?=
 =?utf-8?B?TkVCdWNUcWRSdTBic0xkQmw5WkZ2eDNIUGlxYTcyMDB2V1c2MWRqczdJQ0c5?=
 =?utf-8?B?TTNKWWlheTdwaThicDNGTS91YXpqN3JwaWhSaEUyd2Q2a2RqU2hHeHdnOUdL?=
 =?utf-8?B?Z1BOeVlzY2xlcC9NSCtmeUNWUlhQa2JqRy9xaGVoOGNOeldpNjVUQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 875ef404-ebc7-4860-1029-08deac3e7381
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 13:42:16.0064 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pe80K2TDSuvjfHGkt2HKkHD/0b9AvLAxR3dpUpVr3YPpodm8aHiu7/b7q28ZpBxT+Z4dgfUb5wqEALj7AysZ91iMdZR9U2iKEK3KeuJb0UM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7189
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

Hi Balaji,

On 4/28/26 9:31 AM, Balaji Selvanathan wrote:
> Introduce part_get_info_by_type_guid() function to enable partition
> lookup using partition type GUID. This complements the existing UUID
> lookup functionality and provides more flexible partition discovery
> mechanisms.
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
> Changes in v4:
> - No changes
> 
> Changes in v3:
> - Addressed minor corrections in part_get_info_by_type_guid function
> 
> Changes in v2:
> - No changes
> ---
> ---
>   disk/part.c    | 37 +++++++++++++++++++++++++++++++++++++
>   include/part.h | 21 +++++++++++++++++++++
>   2 files changed, 58 insertions(+)
> 
> diff --git a/disk/part.c b/disk/part.c
> index 4923dc44593..4cb3204ac6e 100644
> --- a/disk/part.c
> +++ b/disk/part.c
> @@ -731,6 +731,43 @@ int part_get_info_by_uuid(struct blk_desc *desc, const char *uuid,
>   	return -ENOENT;
>   }
>   
> +int part_get_info_by_type_guid(struct blk_desc *desc, const char *type_guid,
> +			       struct disk_partition *info)
> +{
> +	struct part_driver *part_drv;
> +	int ret;
> +	int i;
> +
> +	if (!CONFIG_IS_ENABLED(PARTITION_TYPE_GUID))

We don't have an xPL symbols for PARTITION_TYPE_GUID so you need to use 
IS_ENABLED(CONFIG_...) here otherwise it won't work in xPL stages.

Or you need to add an xPL symbol for that (see PARTITION_UUIDS and 
SPL_PARTITION_UUIDS).

Cheers,
Quentin
