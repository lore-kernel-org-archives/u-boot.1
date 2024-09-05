Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D978ECD4F5B
	for <u-boot@archiver.kernel.org>; Thu,  5 Sep 2024 07:39:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35ACE88C09;
	Thu,  5 Sep 2024 09:39:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tsqJxZlQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C93E88C1B; Thu,  5 Sep 2024 09:39:38 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20630.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::630])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAAC488C05
 for <u-boot@lists.denx.de>; Thu,  5 Sep 2024 09:39:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ohpvb0gUCVF6HsVmCvR4ILp9GlQJ5gP1RQM2bBgYk7uc96jqeYGx4Tv/2r6+5Dzt/0c0HSH24L7o3yRquFcmXYVZGfTVthCejIIcAwsdmttzGtrHSZtK8iiuA+rvy1+AhGb8DRDOSyGkTsOXg1om6Yn/+QfVAY6DGysg5IFZHsCn9OIhw9+G7eVun7Ok9D86gGpRGGIkzwAqusDQOFz9tM+Hf/MG6Q9aMEHsC1bFIolmaO7/R0ndoCXn1rnbYA0Pi1YaKgUy3Mp5qoI2rb28WFVoanTVQNqR0goGkMMwpMu0BA6jI4EFvxk6Yv3qCMYBBZmOX1N2JsKYa7kp1f609A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lZK5DTx1g8C+iuz5QQ/qcg5rkHt8uSDbNURHwv27l6w=;
 b=o4Qg/VzIzpW7j6J8b68RJEzB7W70iIPKQzbc+rKJ9nb9YfON00q0+IGQiayDnuC2Y4IbbgFUr5GAsFHkApB4SWp4WuJEQ6ozlWMNI1g8JfsAQKgsg5h9phUGE+BwucYlUcLV6p6vmcLWan3lCXhYEDWVsjrOu+Oa7IjkdhPKh+7VbY3+bWGN1FM0RFqgiPBMv/dJI6AQXTI+aXWClAcISR4UKmP0ccjg+rlH36BoIIh5yRY3r+r5FdA7Kjq+xPcjb48eIE1s30XTtMDi+BT497hRBfIfLwHMuQPFOnAgSUS75YRYtP2S67kCV/mCdI0zMduI2fqEY5+fZLjD/U5aSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lZK5DTx1g8C+iuz5QQ/qcg5rkHt8uSDbNURHwv27l6w=;
 b=tsqJxZlQnQbPmhHeRR8sAysK73xgKuZx0nnFl4cwU4OeBFI+AI6d1CpYI0QZX0g1kw7txO9BirYVbb8X9jzwxOyzDU8+WOWaoRxAWq7TlK70yOxPOplF6l6hLbfagxvmF1cUrinBpNriJQtwhiMdUftGVXJIuCCh7HLytJhL/XY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DM6PR12MB4433.namprd12.prod.outlook.com (2603:10b6:5:2a1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Thu, 5 Sep
 2024 07:39:32 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 07:39:32 +0000
Message-ID: <17fdf962-20b7-4bb9-93ba-bdb7335c4762@amd.com>
Date: Thu, 5 Sep 2024 09:39:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] Miscellaneous FWU fixes
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
References: <20240830114057.891069-1-sughosh.ganu@linaro.org>
 <dc2c0bd1-3aa7-4347-a4d6-5754a40e5b7e@amd.com>
 <CADg8p95OdP5DE39VO+2uu28q_MeYFD1qqUZOvoAXQwUztBGZmA@mail.gmail.com>
 <6f1e9198-e9ef-46e3-afae-62b3f84d97c6@amd.com>
 <CADg8p97A+CJjmEtiVVU3S4GLvEie2FFNi6nN2Ho4ZtAceddJ=g@mail.gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <CADg8p97A+CJjmEtiVVU3S4GLvEie2FFNi6nN2Ho4ZtAceddJ=g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0169.eurprd09.prod.outlook.com
 (2603:10a6:800:120::23) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DM6PR12MB4433:EE_
X-MS-Office365-Filtering-Correlation-Id: b983e1f4-275a-4884-1370-08dccd7de1dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R2RhelJEWmlMakRSa0Z2cmNCVXVJMm5qMkVKajFhV016enlkZGZMOEQySWEz?=
 =?utf-8?B?SzVhK3B1L3lRS25TcnAybG9VZzB4SWZ2d29pdzJXclJNZ3NPYUxKREp3T1Nl?=
 =?utf-8?B?Q2J1OWI2a2djRFhWWGNJNlZXQUdDWXBNTUNWRmozb3F6Ym9OaVZCbER0TGph?=
 =?utf-8?B?a3prQm1WbkxsSWJuRmRjQUZKUjdUbTQwdEpJWUZIQ3VOMUtKK1JveGFGOVdO?=
 =?utf-8?B?eDVvQ1VvSFVCbXJoMVdjSzEyaHlMd3Z0NnNnN1ZGSDlqbzlzSUp1Zm1yOEFm?=
 =?utf-8?B?RHcyQXlYVDBWcjM4azd5TCtXcjJ3ckdyRGVYd053bkZ2L1JXS1lHZjA5cHdJ?=
 =?utf-8?B?Nmh4cmhYN1A3M3dwb24wM3c2VmZaUFJhS2NtUFpaQ1FBU2EwMm82N2tVR2lI?=
 =?utf-8?B?WUxNSzZQVTdTaUUyQmNBUzJHaFE4L0pjMjV3eGt6ZklQUWNwTWhQZitMNTg4?=
 =?utf-8?B?T25Mb0lsWUhZTTl0NHBYMzNRT2RoNUpPMmdYMXJVcjVtSkJVT2ZNVTYyVjgz?=
 =?utf-8?B?M041R2taWmtoTE40M1BRaWt2Y2FtMmN3OU13M3hqME9Fd09KM1YvczNBejdJ?=
 =?utf-8?B?VVEvRy90VitmMVpWdjRQTTBFUFNXYll0bGZUTS8vcUVGamtVOEFXUURpdzE4?=
 =?utf-8?B?YzVsMVUzTnpCUXc3TkFLOFYrUExXWTFkV0NhRTRRWGhWUVhxQitWT0hNMVht?=
 =?utf-8?B?Q1ZTTVc1c2JUcWI3WkxKbG1VS1dVYXJCekNHSWV2TERhcWJVZ0tiR1M4TU9D?=
 =?utf-8?B?cWVVeDhwWmQ1K2UrWFlGNXZoOWxLREM2UWRQRlJucXBkclhQeGJxUG5zc0or?=
 =?utf-8?B?UjRhUm9Tbjlhd1htMGREQUNCNlBpSFk2YWVQeEVCVDFNN3JFc3VoaXFTSmRG?=
 =?utf-8?B?aTNRWkJtY2h6RGRvQU9hK3pwcXpiRm5RM2dSSGJQVWlmeUZCYmlobC8wUTls?=
 =?utf-8?B?a0xXbVVPN3JxcTRHT3FMUlgwWEZvMm9WL1pKNVRISnFBU0p6UUlpRktLNm5p?=
 =?utf-8?B?U2NoblFXeC92MmlEbnZheURmU2RrcG82eFFMeW5KeWlBMDh1ZnArK3VoTytE?=
 =?utf-8?B?b2d2NlZQdm5HWSt4VVM1bDJPL21oUzlqblduaFhaSGxYZWVZcU9MOWVtWTFu?=
 =?utf-8?B?OVU1VE9oZWhlQlJSS1JiWTZWZ2dQZUV2aGM1ZmMxVFIvZzVDRjMyNmRQeW4v?=
 =?utf-8?B?VGtJb2xrTVg3MVNVWGpxR1ZZMUtyWE9EWWR3SERITEpmQ2VaM0hLcU5uZHFP?=
 =?utf-8?B?VXRMMFRyL1FHaGREMU4ycktGUmM2NHpRRE1tc09IV21rNi9jWTE2ZEhDYWRa?=
 =?utf-8?B?SENjbTJtMUkzenRBQVRPeFN0V1pqaFVxbTlGL2s2Mkh6eHZqbkRrSlhabU5B?=
 =?utf-8?B?N1MyVUFneWlvaWFSYkErRWdiVlZuSE1HUnc5cWt3am9IMnlpOW9ST2dZSm5Q?=
 =?utf-8?B?a2NFYkcrQUpYNDNydllMRFpSdGViZkxKcFpvSWozK3ZBZVB2YjdLMzcrazFL?=
 =?utf-8?B?WWpDcVlBS055TjhEb3Btblhzd0lGT280d1Z4N0pqdmo0RTY5cUM5SFBXbEEy?=
 =?utf-8?B?RHM5bk82bHRWZHJUNEpCck9wMFdmTWxiYmtoa2Q0UkNVRXZCT3FVWFFsODBP?=
 =?utf-8?B?MiswaGhmVnloL1d0VUVvaGpKcmFaUU44bTFvTVJ3ZWxKUjZGa21YNi9IOCth?=
 =?utf-8?B?d1A3NElMb2xpUXZTTEZDZXdQVWFvcklYanR5VkNkYTJzOVgzQkdLNFI0b1hG?=
 =?utf-8?B?ckJXemduTzRUYWNJM0RrZjlKUHNodDU2K0V0NER1NytqMWdkaGNuQjFSQkFR?=
 =?utf-8?B?cGp3QkVlY01pUzVrWHM1Zz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkhzQTdSRTBXZ20xRGJ4ckhjMklwcmlsbVZnYXRjZmVWSzYyaXlKTExKTTdk?=
 =?utf-8?B?TVlIVUpudm5BMUVPTlRiN2gwNmFHbyt4RmxiT083MWRPTGZ6eU01WjdaeXE3?=
 =?utf-8?B?K09USDdXMkNDQlNhSFVTSHdJRnA5Rmkyamx1dTBNRTBEUVdGNHBTMm1VbjlP?=
 =?utf-8?B?MjFrTDlqTXF2b3p1TWEzeDJlU0tFdHpUbG1pSXQ3RG9KTUdvMkI0VzE2eVJX?=
 =?utf-8?B?WmZWYVJFcXFJYUs0SDRBTUo3aEJFeFhLbFBuR1AzanlBdThwcURBT2lUdExD?=
 =?utf-8?B?cEVST0dUU0xSWlg1V09Va2RFYnNRM04rWTlQTXlXbDd2WHBISlIzbEIzblho?=
 =?utf-8?B?TDZUMmppTUR6NThmYWZ0U2xKMTNPVzRhemMxdnNHWmRmY1RjbnJ1Nk12N1FN?=
 =?utf-8?B?VC9HZ1dxdzE2WlFKSVo1NmdXb293ak5nKzFVSXdmeTdnYmRmQUFMSzNCWm0y?=
 =?utf-8?B?RkJsSlZ6KzRzd0tKYi9IL3dOb0phNXE1cWZKNGdxL1RMOGY2RmQ5czVBMW1Z?=
 =?utf-8?B?WDVDNTB2SFBDaWora3JJb3Exd2UxZzlPUXRGNUtrbnVwY1Y1Qy92b0VBNDJ1?=
 =?utf-8?B?QXozYzJPeWlpbnBweG1JYzh3akswTDBzaXVkZ3JVNnljNnlwTTJGU0IxNzdN?=
 =?utf-8?B?VVc2NjkxREluLzJ0Z1ZhSkdoLzdRaEdNM3NjQ01YclJ0bzE0REs4eURHWXIz?=
 =?utf-8?B?ODBtSXNJMExWc0duVGtvQXBuQjZKWDYvbUduUFYrWXBPMlNlMld1WDRpcTBV?=
 =?utf-8?B?bW5RY1VFdGFNSWQ2MHhZMTc0dTlPdzRxQnhrL3p3eVpIbmIzMDZPclIwUXJh?=
 =?utf-8?B?L2txcC81eTRVZnMyNGZLd0FsY056NXZSU2xZNGQrUzJoM1ZmS2h2YjNGcEtT?=
 =?utf-8?B?MU5lb2kxRnhoVTAvb3MreG1jcGlVNEZETk85THFuZmh4dEdwMlptb0VRd1hL?=
 =?utf-8?B?SkpjNCt6ZFpmSWpUdnBOYkpVSmVhend4ekVmcTlIQm16N0pQKzZJWlhlc3Yv?=
 =?utf-8?B?SU5zbkRybGVIcmlVWTZiWFJXWXc0STJ1WC9yeVZnSGFGdHBMN1BsNlNaMDVn?=
 =?utf-8?B?b1hQZDRJWFR2RFowZzVtUXVZR0IyZ0p3ekoxOEVlSCtEYzhJbHZEZkUyV093?=
 =?utf-8?B?bmpPUGZ4bXhPM0lFWDJ6M0xCVTZ2dk9vK2FlSHY3UXI4VCtXTTI0QzBxNVo1?=
 =?utf-8?B?Qjl1blEvZnhkTGIrMnMybExJamlrN0V3RU5sNE5BYmphRmxuQlVqL2F4MUtM?=
 =?utf-8?B?ajdIUlhWZlhyTnBFTGNubVhaSlBvYnl0NXVDaytCOHlPTlJVb0V3SWlCNS9C?=
 =?utf-8?B?V0I4emV1bEZHb1dicnVJbHBISVdWMnl2T2ptUlJDZWNJREZtNGt0UGhXSHRV?=
 =?utf-8?B?NTIrdGNLVzRLWDJUYzJnSEZIQk5RS1RsL2NRazhSRVZONDh0c2Vsd3RBL29p?=
 =?utf-8?B?TkJqOXZzVDRRRzJkRkJUcHJqUHE0djgyUzhGczlvdUM1aWtjSWpQUlhFTHJW?=
 =?utf-8?B?ai9hbWY5V0VQZ2pZRi9vVDRsT0gybUJBS0dacXAzYVhJR2plYW9XcW5xR3Yr?=
 =?utf-8?B?ZkZBbm9Hckd4RnBTRmR3RERXTWxlNUFlbkZCOVVINDJZVENleXdaSDZNblRw?=
 =?utf-8?B?VDltYXVLS2Y1WjNLd0sydDVmNkJhcXdCenJ3T1VDNXBwRHRyNkpLeUhYK2Vo?=
 =?utf-8?B?UEFlOUxIbk43QlBnWlhNMTJEWjVkbzVYNHpIT0VjQTQvQ3dZd0YydWdmSEdU?=
 =?utf-8?B?bHZvV253b1FBaEpJY09nN2FrMHdYK21CQ1hPQ0xhTU1UN1Z1QkRIcjdJK2p1?=
 =?utf-8?B?UkZZUmFQVU1LZmt4aElzUlpPaUE4bk9TR1NWVEtlbUZvbzZlc3ptZHNwU2sz?=
 =?utf-8?B?aHZUNyt2OUhZU2ZGUzRYNUhVb05rTnQvZnN0WWFZemtlMk53UXZ1emIyZ1Aw?=
 =?utf-8?B?K1V5eUxtSEF1RXhQUFFGYnBOSlczelZSeEhTazd0UHh3V1drMHVBUWdEb3gv?=
 =?utf-8?B?RkUyVytHUUlNUXpWYWlsb0pUejlNdkNrcU5YUUU5Nm5nL0hXRzNMaWFWT1R1?=
 =?utf-8?B?N1FkbjNyQ2xWMDdKTHdOb3JSaWJJa0x3M004alFWYW14MExadnlQaW9HcnBy?=
 =?utf-8?Q?IiTZxrU2o/cPIEgC0LQpztDzO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b983e1f4-275a-4884-1370-08dccd7de1dc
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 07:39:32.5948 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JK86oAXvcrBDsRYdqfjE1nGwgQcTQUnE8ve11k8wiWJR1wNkwiwwEW5tw6PX2F2M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4433
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



On 9/5/24 09:38, Sughosh Ganu wrote:
> On Thu, 5 Sept 2024 at 13:03, Michal Simek <michal.simek@amd.com> wrote:
>>
>>
>>
>> On 9/5/24 08:24, Sughosh Ganu wrote:
>>> On Wed, 4 Sept 2024 at 17:30, Michal Simek <michal.simek@amd.com> wrote:
>>>>
>>>>
>>>>
>>>> On 8/30/24 13:40, Sughosh Ganu wrote:
>>>>>
>>>>> The following set of patches are miscellaneous fixes and some
>>>>> hardening of the FWU update logic.
>>>>>
>>>>> Sughosh Ganu (6):
>>>>>      fwu: v2: perform some checks before reading metadata
>>>>>      fwu: v2: try reading both copies of metadata
>>>>>      fwu: v1: do a version check for the metadata
>>>>>      fwu: check all images for transitioning out of Trial State
>>>>>      fwu: add dependency checks for selecting FWU metadata version
>>>>>      fwu: do not allow capsule processing on exceeding Trial Counter
>>>>>        threshold
>>>>>
>>>>>     include/fwu.h            | 11 ++++++
>>>>>     lib/fwu_updates/Kconfig  |  1 +
>>>>>     lib/fwu_updates/fwu.c    | 31 +++++++++++++++-
>>>>>     lib/fwu_updates/fwu_v1.c | 18 +++++++--
>>>>>     lib/fwu_updates/fwu_v2.c | 80 ++++++++++++++++++++++------------------
>>>>>     5 files changed, 99 insertions(+), 42 deletions(-)
>>>>>
>>>>
>>>> I found one more thing.
>>>>
>>>> I did this change
>>>>
>>>> diff --git a/tools/mkfwumdata.c b/tools/mkfwumdata.c
>>>> index fbc2067bc12d..dab9530e499c 100644
>>>> --- a/tools/mkfwumdata.c
>>>> +++ b/tools/mkfwumdata.c
>>>> @@ -293,7 +293,7 @@ static void fwu_fill_version_specific_mdata(struct
>>>> fwu_mdata_object *mobj)
>>>>            struct fwu_mdata *mdata = mobj->mdata;
>>>>
>>>>            mdata->metadata_size = mobj->size;
>>>> -       mdata->desc_offset = sizeof(struct fwu_mdata);
>>>> +       mdata->desc_offset = 0x21; sizeof(struct fwu_mdata);
>>>>
>>>>            for (i = 0; i < MAX_BANKS_V2; i++)
>>>>                    mdata->bank_state[i] = i < mobj->banks ?
>>>>
>>>>
>>>> to break desc_offset location. I generated mdata structure and write it to
>>>> primary mdata partition.
>>>>
>>>> This has been spotted by (my debug) which is the reason why I did it.
>>>>
>>>>           if (g_mdata.desc_offset != FWU_IMG_DESC_OFFSET) {
>>>>                   printf("mdata offset is not 0x20\n");
>>>>                   return false;
>>>>           }
>>>>
>>>> But I got one more message below which
>>>>
>>>> mdata offset is not 0x20
>>>> Both FWU metadata copies are valid but do not match. Restoring the secondary
>>>> partition from the primary
>>>
>>> The reason why this logic is in place is to handle the scenario
>>> whereby, during the metadata update, the primary copy gets updated
>>> correctly, but due to some reason (like a power cut), the secondary
>>> copy does not -- this is because the primary copy gets updated first.
>>> In such a scenario, the secondary copy of metadata can be then
>>> restored from the primary copy. In the scenario where the primary copy
>>> is corrupted, it will show up in the crc check, and will get restored
>>> from the secondary copy.
>>
>> But in this case - CRC of primary is correct but data inside is wrong because
>> offset is at 0x21 not at 0x20.
> 
> How will this event play out ? Am I missing something ? When the
> metadata is getting updated, the offset will be written as 0x20, and
> not 0x21. And in case the metadata gets corrupted, the CRC check would
> fail and the primary partition would get restored from the secondary
> (assuming that the secondary copy is correct).

It is not after update. It is initial state with incorrect mdata structure.

M

