Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3917C369A8
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 13:07:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4414B84042;
	Fri, 11 Apr 2025 15:07:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="lvHWYBXg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6ABF284049; Fri, 11 Apr 2025 15:07:36 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20616.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::616])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D89388403D
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 15:07:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dhp5ZHq9S94HH7vxFU8dIJJc7KN5EmwGBZ3D9Sboxzx0F0vCfsfPARHX4rkeXiidF4f2vy1vr/HJkjVpeGJPAfyDrPmmahcO+9cyFr73q3m/y2EMfLJlfJMCUt1QwevTZlqa8PUzft5SAMphal5s77co+zgcnqsNufKZpEB0HzSzwsnLz2DSz/xXSarMGK6hexwkOxkiuqDmO8MT16mGgBhRfiNDlMd/pKMuhM5XzAn4BFPpg1sjm24fkHNxjgf+Okei8pp6al70RgPu+GRCctruA3+UgEmZKjl77EimXnmQQiYCTgAWaNOumqAxxkbOHQOtbZH+8X4eub3hz9YFFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O/8EJaBo3eYS7fYYum2q7XxFmh1xLL85xEtDGmJfZZM=;
 b=ut6UigSE9Mwuq4+3VSQ8qeiBX4rmS9QQkgeRv1pYOkfAeODtkkE9s0azPvcjLrGH9brSYDPbKqR4BsCFZ+jWoRLSiU+GEgTvOoDm/KlNjj/HmXr0uab/nQ13xBxW047hcTs+9GbXw87nRCL5X0cGUcPEogrgAh3EFIs1yvmUoGhsJdexQenZEWYaPWX/zGL9vFRGpaN8gEFLc1YeWyLPPFCNDDa3ogG4GsZMDhcirsbR3STK6oleg6AbqBE27d+wqeD5roqWG/+eZVhZ93c9IEyk8QONmPSz/GpC9R9JuNyfr/F/gtJiydqf+vQtX2Xx+AkkpeEdd31pK6SE+bYMhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O/8EJaBo3eYS7fYYum2q7XxFmh1xLL85xEtDGmJfZZM=;
 b=lvHWYBXgRuww/JtwlIvIrxx4a3Qo0Ug3B3GbAVnSLNc0CCDqIubtZupKSde5LHloCNjYaTI20skVwO/XhvFAQXRv18GZCy6M5yQtaQtCAtckL/+3gpvICb7akdjHHAnRfL1gecQurI36Z7QAq4cbDtI7K8Ih+D7lAR8lwbylBqdCOucmL0xU6Xdc+jRa1mWs4nyutccUiT8EWLnV1BkdAFSqvDkxDDLGDcecm8khOjb7BtKlPSCkWNxXqzHYSmi1MLM2UF1U6Bm9thTsECQHK2aACXNfbNuboL0rWWQbN43ZXb/ZiQbYuK8D9KTPvjzQrtfEQDwNs9QNG5+MkNr3gA==
Received: from DU0PR04MB9636.eurprd04.prod.outlook.com (2603:10a6:10:320::21)
 by PA4PR04MB7742.eurprd04.prod.outlook.com (2603:10a6:102:b9::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Fri, 11 Apr
 2025 13:07:31 +0000
Received: from DU0PR04MB9636.eurprd04.prod.outlook.com
 ([fe80::8be1:62a3:dca7:efa3]) by DU0PR04MB9636.eurprd04.prod.outlook.com
 ([fe80::8be1:62a3:dca7:efa3%4]) with mapi id 15.20.8606.033; Fri, 11 Apr 2025
 13:07:31 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: Fabio Estevam <festevam@gmail.com>, "Alice Guo (OSS)"
 <alice.guo@oss.nxp.com>
CC: "marex@denx.de" <marex@denx.de>, "trini@konsulko.com"
 <trini@konsulko.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggUkVTRU5EXSBmaXJtd2FyZTogc2NtaTogc3VwcG9y?=
 =?utf-8?B?dCB0byBtYW5hZ2UgU0NNSSBwcm90b2NvbCBkcml2ZXJzIHdpdGggYSBsaW5r?=
 =?utf-8?Q?er-genetated_array?=
Thread-Topic: [PATCH RESEND] firmware: scmi: support to manage SCMI protocol
 drivers with a linker-genetated array
Thread-Index: AQHbqSSptIJ+uzxN5k2QQjAfqkTII7OebQSAgAADsICAAADvAIAAAI/g
Date: Fri, 11 Apr 2025 13:07:31 +0000
Message-ID: <DU0PR04MB9636D066026DE5BCF98678B1E2B62@DU0PR04MB9636.eurprd04.prod.outlook.com>
References: <20250409075352.535194-1-alice.guo@oss.nxp.com>
 <CAOMZO5BodWZDVcrZnzy+Qjb9nYks64v6_CFPvxotv1=dWR5MGQ@mail.gmail.com>
 <DU0PR04MB963656129C2D75D1AD90FFA8E2B62@DU0PR04MB9636.eurprd04.prod.outlook.com>
 <CAOMZO5AxnJ8fmKWvA5-Ku-Bdh=CpP6imEqrR7p-QuZnwqsTwEA@mail.gmail.com>
In-Reply-To: <CAOMZO5AxnJ8fmKWvA5-Ku-Bdh=CpP6imEqrR7p-QuZnwqsTwEA@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9636:EE_|PA4PR04MB7742:EE_
x-ms-office365-filtering-correlation-id: a6db8077-f51d-4ae9-bea6-08dd78f9d172
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZjhSZ0NxNHhJSndhSkhCekhRMjlkRlN4SEFXKzhUWHF1NVZIc2htOFdXaG1D?=
 =?utf-8?B?UjJ5OEtDNHVlOTNXV3VZUVBpWVd0TlMxc29mai93SVRRbmRrMXYxY1hLdm1x?=
 =?utf-8?B?aEhxaGZpdkNuYnQ1R1F1N0RZbFBxN0ppWVpvTUVSVW9vaGFhSkswM1VUUWlE?=
 =?utf-8?B?NlpMRkdkay96SUN6b1E0TmZKcWg5MDViUTkra254RDFtS1h4TzZwTTJ1Qm1V?=
 =?utf-8?B?b0dqWUlDUi9GTWI4TUZBMWlVVytwZk1qWmhjUTk2NHB1QlBWQVFNbmtjZzBh?=
 =?utf-8?B?Um5SS2tXVUVPbUYyVVlUazZGVEZENVgyeS9Wc3JTTWRVSDNkMWN1T3RQbzJu?=
 =?utf-8?B?Rkg1RkdXUUV5elB5aTdmWTE3K3MwQmhydjBRSUlDSk0rWUhSaENYd0lIb3JM?=
 =?utf-8?B?ZXNVRll5c25abmxLUWJ4c3JZejFFMmlSa2ZBT09henM0QldIRVYyTGg0Umtj?=
 =?utf-8?B?QUlLRXh3ZlFPZFp1QXUwbmFyU0ZqRkZrSzd0WjdmOGVUT1U5RG1nZE1VVSt5?=
 =?utf-8?B?RGVsTmV1T3Bjc0MzV3N4ZzJpZndiT3VNYm9pS29yTS9qQUpXd1Izak1mZHB5?=
 =?utf-8?B?Qi90VG9oWmx3UEEzMjFYOEYxUFJTK2JFd3VZTFlZaW9PMHBTZCswVjZHaEhV?=
 =?utf-8?B?Vmcrd1E1SW9aZ3hkVWczV2d6eXAwRk5wV21XT0p6ZlRwYUtmc2p4dml0VEFC?=
 =?utf-8?B?UFpuUWs1OThvN2JteFlZRnRSS1Y0NUVpNVZVbG9jajFzSXpkbHVFQTFYb2h0?=
 =?utf-8?B?V1I2TmJwTFA4Y1FiOWhHVXFKd3U3YXpYYkRLaVJDanYxYk55bHBtbEtNWE1B?=
 =?utf-8?B?MjNxVVlVVUlPY3ZnSlQwQ2dQeVYxV3B2bytJOXhublZqVUFnTEF3MG90dEx0?=
 =?utf-8?B?amFCZnpiK0lpbTExNVUwdlNYQldGcklYZHMzTGNVTmRGRjJXcmRFaDl3SHRy?=
 =?utf-8?B?QTVsaVJEU1ppa1c3eHF2ejBpM2t3Z3VLdEorS2hicHBtWHFKOTBwckdJeTVT?=
 =?utf-8?B?K05qSmRzbUFmMll1U3FWcUNnZlI3ellNQ3lTYyt0ZEZ5WFFzbm9RY2lJRmlz?=
 =?utf-8?B?cHkxY3lKemVkNUFhWkx4Y1FYVGl1MTdFVlRKOXlzTHFKR1hkcXZLTjNkbXJD?=
 =?utf-8?B?dDY3STJwMXJkNy9kYlBMZTREbitocTFFYUdDRVNVSDJySzVGU0k3M0pKWEQz?=
 =?utf-8?B?MWs4cFA2RUxLUC9ZUEEvYWZxdDlPNkhtQ2M5V1R4SG5ZM0VCeDg1aUtsZW1u?=
 =?utf-8?B?NUltbHN6UitKbXlUUFp6WXYyYmRWUVZIb1NFWEZvcThjSmQxT0FjQnd4RS9Q?=
 =?utf-8?B?MHorTG1VaFRoZjB6blF6amk4Vmx5RkpxTklqQWFIY3hNdlRvUHNFK3RrREdw?=
 =?utf-8?B?NEl4U0lJcVUvR0pBOHFjOURwN1BZaW4wOEpwNzEyeERzdDJkajlROTZPWVJL?=
 =?utf-8?B?d2pHMnIwVmkyelZpTkxySEFEMEtMMG5OanJEYzBTYlJsVHc4ZVJETVFiOTZL?=
 =?utf-8?B?UHkrZThmS0lmclFwT0JaQmpwVmE1emxlSG9qTDd5NHR0dWtMRFhBb25hK3J0?=
 =?utf-8?B?KzZXZGxubjFBOFJtMUZ5dHQvVWlCNER0c3gzTlFUN2VnTTAzRjFmc2g3bnVq?=
 =?utf-8?B?WDNheENHZWpud3Rvb29rbTY5dU82YUd2alZoRU1XYi9KOGxpbmc2RFJtNUxx?=
 =?utf-8?B?YWZmeTkxV3Q0Uk9MTUROMmxQczU3SWFOSFBRUnRiTG1LNTZZYlZLcGhHSnFG?=
 =?utf-8?B?cnVROHhMZjdEai9DTXd2MEdlMnRSNVRmRDhOUHBNTDA3OGlhbHU5VEpUWE1H?=
 =?utf-8?B?aXNiZXZreFczVGtITzFZU1pKNmlaTURMbzJFcUlPNUNncWlkZ0djTXZ6VU9p?=
 =?utf-8?B?dkFoT3FaZE5ZUW54ZDdRZzRyTUpKUVRZS3pMbHlXbW1OWHZ0Tk9raFlhOGtr?=
 =?utf-8?B?L05rQlUrT2pqZ0hvdFE1bzk5aUhJNXAvYnI0YWVPdXd3c25yeXhQMjcyWWsy?=
 =?utf-8?Q?FqA838SPWdOmekr6fh3rsRA70qDnn4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:DU0PR04MB9636.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q3FUc1pXYVdvUUJDVVR0V2NXTm9tczRLY3ZLd2FtMzNnYnFDbDNYU21SeDcv?=
 =?utf-8?B?T0JyWnZtY3FVampPb0ZBNktwYjFIZGZYV3RNdlN5M3ZYcHhUMzA2WFU0TEZ0?=
 =?utf-8?B?RHFOUjA5MXdySndwOWJCekZvOUdVNDdsSEE2bS9qYzNKd0FtL0lvVzg3NDhI?=
 =?utf-8?B?R3BPVEVzSXZvOHJIb3c1YkpBNUZDZ093M0ZqclI2QVNwcCtvM0U5dE5rdHVX?=
 =?utf-8?B?dHRGelN0T2ZjM3FjVzBsUGIyQU8zYVN6VjFyQldON25Sd3RNVUFERFQ0OFFB?=
 =?utf-8?B?ZjlKdVo3OGhvQWVDY3IrTEM3ZWxpOWMwL0tPaEd5N2lWTkRBMDQ3ZFY5ekls?=
 =?utf-8?B?M1owOGRQNzNXS1F1ZFlKV3hjdEUrd1pqYTlsbEVqZktaU2VTUjkvZkgwcXo0?=
 =?utf-8?B?OENCc1orU01ERkRVK2FlOElEU25DNGtWUW5WbThLQTR6dXd1ZU1IZFdHTTdP?=
 =?utf-8?B?U3FEbG1MN0dNS2NFU2lla3NhM2JPSk9lK051NG5GblQ3NUxDbWd4OUhJRUpH?=
 =?utf-8?B?NUw2T1N4YnJhUFBOdjNVQTJjeUVUakF6SWJKVnJzQkFXSVVGeDNvTmdHUGY4?=
 =?utf-8?B?TFV4REF0N2ZRRW95TGdtU0p2SEQ1VjFZeTlQYUxRWjNvbGVkQXRIRTV5SG1N?=
 =?utf-8?B?MXZTeGZaeVJ2QTlsL3A5WHRhRW5TUG93UlhYVEdrdlkrTWhkKzhSRS9QVUgy?=
 =?utf-8?B?RzIrVEw3SDFYcWxud2dVM1pKeHhMUGk1dWg0OFdEeGhLanhZSHM1Tlkzb21V?=
 =?utf-8?B?cHFidzBXTVdNVHg0eGFtMlYrNG9WekZKTHc4UDllcnY1Zy9tOVZzeGlUK0xW?=
 =?utf-8?B?elNTV3cyMk1oK21RS05qYUw5SkQxeW1KNnAvTktVOTZGMkgvWEo4T3AySWVK?=
 =?utf-8?B?TDhOTFVxRmFpZnc0R0FqWDJoSkdjWXFMNUZoY0pWTDRmd0c1UlBnVm1WKzdv?=
 =?utf-8?B?eDB2RFRPOFlBR2kxek4wcHEya1BmbUlnR1ExRXQwVk9SQnpoaCtiSDJ2aXBF?=
 =?utf-8?B?eGZzNk9zUWxUdVRYVVZYeDNxaTJHdzdGaFA0SGpRbDRjOS9LLzFPTXN0Q3lU?=
 =?utf-8?B?VDE3elBRUzJxOVVjUHEvcTRHZjV2UW1lcGY1YmExTUxYREsrTVZzaUZweUJH?=
 =?utf-8?B?QnR0RkFiVEdJb3dTUEs5d3ZzeFNDT3RnSGtOTzdOMHhaV0h4aUo4RzEwN2c4?=
 =?utf-8?B?ekY1dkFyKzZKLzlvd1pVbmR1UWQ5M1JwY2RrUkp6a291c2VtSUt3MmZBVzdY?=
 =?utf-8?B?ZXBEVm1mVURTeGo1ZE9VZVkxT2k1NjhUVHJYeU13alk4cUZnM3o5YWMwbEhq?=
 =?utf-8?B?dFQwY2V1bWJJbys5SFRsNmZQVDFkcnhSa1BpQiswdTFmYkhJTmF2MzZSSkN2?=
 =?utf-8?B?dk05RVU5RXlFcHNuTnpEeittcGJKMm5jSmZMbkt1RzRPZC8vWU9Oc0NrSHdS?=
 =?utf-8?B?KzB5ZDJoQVRiY3ZmT2Z6WHhEb2wvNmxmdUttU09uNWE2RmwxVnV3OGRZS2FI?=
 =?utf-8?B?Y21GT3BJU2ErN2djQTdVclRDanRmajFxTWZ0ZDFpQ0VCOFptdEpaUStYQmVu?=
 =?utf-8?B?c2ZQYlR0STUxODZialh4OXdPNE5vY3VncWZWc01kbjFXLzl0N3U0b0pBQ1N4?=
 =?utf-8?B?WmJhR0V4UXdRMUZLbUwxc2tCbXRwdTh3K1hnUUtuSEdRaXhNdkFmbXlXR2VV?=
 =?utf-8?B?cUhJZ0Njd0E1SUp6K1lqclJHTmtTZW1wRWlMY1pFZU1jOEk5K2I4L2dGZ09O?=
 =?utf-8?B?OTYrd3JkUFhQVXAyQlduclliUklYZW9PbzkxUWp2NkR3SitDSmdndmNVMWxi?=
 =?utf-8?B?VnFTTXBuM254dEJ4Rk4rQS9Yb1N1bjhDTld0OUd4YVZBa0VmVDZQYWNmMTc5?=
 =?utf-8?B?T1paRDM2ZEM2dGNDQlFvcTcwU3MybytnVDZhdjhJdXhpRWJYcVRsay9GSytU?=
 =?utf-8?B?Vk00TnNsRGRsSTBIWGI4MnErdzF5RnZKdC9IUnlxUC9obGJNQ3d4c0FNYzd2?=
 =?utf-8?B?eFFUQUhJK2JmbkFHMEVQbWpLUHNHb0ZhM3I0MEdZdTdRZGpRMkpyQy9Rc1Uz?=
 =?utf-8?B?Y2RRMkZtR3RwY21IMzU5eTJlUS9xNWF2M0lWU214U3JYSzA3YUVEUzNtbVBM?=
 =?utf-8?Q?B0+zmwIy1xlAJCyuIBob7TLxP?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9636.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6db8077-f51d-4ae9-bea6-08dd78f9d172
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2025 13:07:31.2123 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qxi9mGrEm4JpwfS7awhMy/w+gROvQ03ZU9DrPQdY9JGQCaUliIS+47FgEU6Gju+52lBSKrqrAVgdJXmjFGej4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7742
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

PiAtLS0tLemCruS7tuWOn+S7ti0tLS0tDQo+IOWPkeS7tuS6ujogRmFiaW8gRXN0ZXZhbSA8ZmVz
dGV2YW1AZ21haWwuY29tPg0KPiDlj5HpgIHml7bpl7Q6IDIwMjXlubQ05pyIMTHml6UgMjE6MDIN
Cj4g5pS25Lu25Lq6OiBBbGljZSBHdW8gKE9TUykgPGFsaWNlLmd1b0Bvc3MubnhwLmNvbT4NCj4g
5oqE6YCBOiBtYXJleEBkZW54LmRlOyB0cmluaUBrb25zdWxrby5jb207IHUtYm9vdEBsaXN0cy5k
ZW54LmRlDQo+IOS4u+mimDogUmU6IFtQQVRDSCBSRVNFTkRdIGZpcm13YXJlOiBzY21pOiBzdXBw
b3J0IHRvIG1hbmFnZSBTQ01JIHByb3RvY29sDQo+IGRyaXZlcnMgd2l0aCBhIGxpbmtlci1nZW5l
dGF0ZWQgYXJyYXkNCj4gDQo+IE9uIEZyaSwgQXByIDExLCAyMDI1IGF0IDk6NTnigK9BTSBBbGlj
ZSBHdW8gKE9TUykgPGFsaWNlLmd1b0Bvc3MubnhwLmNvbT4NCj4gd3JvdGU6DQo+IA0KPiA+IEhp
IEZhYmlvLA0KPiA+DQo+ID4gQWN0dWFsIHVzYWdlIGlzIGluIHRoaXMgcGF0Y2guDQo+ID4NCj4g
aHR0cHM6Ly9wYXRjaHdvcmsub3psYWJzLm9yZy9wcm9qZWN0L3Vib290L3BhdGNoLzIwMjUwNDEx
MDgwNzA3LjYwMjM3MS0NCj4gMi1hbGljZS5ndW9Ab3NzLm54cC5jb20vDQo+IA0KPiBQbGVhc2Ug
bWFrZSBpdCBwYXJ0IG9mIHRoZSBzZXJpZXMsIHRoZW4uDQoNCkl0IHdpbGwgYmUgYWRkZWQgdG8g
dGhlIHNlcmllcyBpbiB0aGUgbmV4dCB2ZXJzaW9uLg0KDQpCZXN0IFJlZ2FyZHMsDQpBbGljZSBH
dW8NCg==
