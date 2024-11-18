Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2BE2D60CF8
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 00:23:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B328F894B4;
	Tue, 19 Nov 2024 01:22:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=phytec.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.com header.i=@phytec.com header.b="EUNIccmn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A7C780245; Mon, 18 Nov 2024 23:28:44 +0100 (CET)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2071d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::71d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53E37891EB
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 23:28:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=phytec.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ggiordano@phytec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EP5Xn7mt5QMVPLrY9qboxXK6t68xngnupTmAZnc8PmhOJFSmvrpjc20ZJRzfcNqOe6a4Uo9vc05pEJ6Kg7bjDTETFZjwWtHoWgIksF0EPBj00lXNdc+yJbPzEQoklqtDDvpnTbXAu2shEcoymKv6mM6B4upZqJlXLo6P0X4uXxiQhRFV1k18fgktsPdxZOZcyJzZu6FQGOY24BlTA5fapzO1JA2WDlUcsM7RR+/MqjYru32iekudaYXdrSrClCsfQY9if26FeWC6nbwh6saleTPxKBd5U2Ss+LEnbuVWBOCkNz7upcZiInULGa/okhplOqCRYJMAa0I9+/EGDi2w5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gsAp8vVcKWiRPH+hCbHh/olI8vWszFQfbysxKB7GEo8=;
 b=wNUSDJZWQ0ArMVsOYeNmXmLZ6FxRTgaD63Ux/yV3aNlpZoYo29/+2LsoAXsN3zDYxWWOhIH8pnryuw37nayA7F5IUruU5PeXq/kjWJRR9cjfsb3XBXrd0V+0OPdOyHQMfFa6EFNWWhzj1J2yuacriCHukH+kNA9oWVATSOSlvdBppXVY71c1sa95ERa2VXscMc+jRZ6TykCN4PM5xXthL2f+23VFZYPvw9QSirhac4ceMsrcgAcw2a4INcF4DeYqEVs/eMYKwGhBR675H1HpQtp/rzD6ZHNaHiEB1VbSM3MQH+pzZFSfKbDF2Bz/L9z5CbtrRmcmXpPD3hsU9vjiNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.com; dmarc=pass action=none header.from=phytec.com;
 dkim=pass header.d=phytec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gsAp8vVcKWiRPH+hCbHh/olI8vWszFQfbysxKB7GEo8=;
 b=EUNIccmnA2xO22PqqmlYU56sM4LKBRSBCbMZwVVp00DdlvkuKHYmL/rbFj4bT8R4C9N0JSOne+vNGAbzsUGk9K437cEOlEGa/wmKUNststnUXhrp1ekme2StiYSyfNuXPFtX3ACSNR3ztyu6Br4VBGQwm8skGnxO0guU0rQ34MU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.com;
Received: from SJ2PR22MB4354.namprd22.prod.outlook.com (2603:10b6:a03:537::8)
 by CO6PR22MB2900.namprd22.prod.outlook.com (2603:10b6:303:14f::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Mon, 18 Nov
 2024 22:28:37 +0000
Received: from SJ2PR22MB4354.namprd22.prod.outlook.com
 ([fe80::789c:e41e:1367:383d]) by SJ2PR22MB4354.namprd22.prod.outlook.com
 ([fe80::789c:e41e:1367:383d%5]) with mapi id 15.20.8158.019; Mon, 18 Nov 2024
 22:28:36 +0000
Message-ID: <4cd2a4fb-bffe-451f-8cd0-9d311eeaa9e9@phytec.com>
Date: Mon, 18 Nov 2024 14:28:33 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] board: phytec: am62a7: Add PHYTEC phyCORE-AM62A7 SoM
To: Bryan Brattlof <bb@ti.com>
Cc: trini@konsulko.com, w.egorov@phytec.de, t.remmet@phytec.de,
 sumit.garg@linaro.org, kever.yang@rock-chips.com, marex@denx.de,
 festevam@denx.de, jonas@kwiboo.se, Oliver.Gaskell@analog.com,
 aford173@gmail.com, prasad.kummari@amd.com, neil.armstrong@linaro.org,
 mibodhi@gmail.com, n-francis@ti.com, d-gole@ti.com, afd@ti.com,
 sjg@chromium.org, nm@ti.com, d.schultz@phytec.de, nmorrisson@phytec.com,
 francesco.dolcini@toradex.com, vishalm@ti.com, vigneshr@ti.com,
 y.moog@phytec.de, othacehe@gnu.org, m-chawdhry@ti.com, j-humphreys@ti.com,
 j-choudhary@ti.com, u-boot@lists.denx.de, upstream@lists.phytec.de
References: <20241115195055.3023365-1-ggiordano@phytec.com>
 <20241115195055.3023365-2-ggiordano@phytec.com>
 <20241118193253.sx5yvpcyzjdidhou@bryanbrattlof.com>
Content-Language: en-US
From: Garrett Giordano <ggiordano@phytec.com>
In-Reply-To: <20241118193253.sx5yvpcyzjdidhou@bryanbrattlof.com>
X-ClientProxiedBy: MW4PR03CA0042.namprd03.prod.outlook.com
 (2603:10b6:303:8e::17) To SJ2PR22MB4354.namprd22.prod.outlook.com
 (2603:10b6:a03:537::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR22MB4354:EE_|CO6PR22MB2900:EE_
X-MS-Office365-Filtering-Correlation-Id: 319695a6-f072-43ba-1ec2-08dd08205821
X-LD-Processed: 67bcab1a-5db0-4ee8-86f4-1533d0b4b5c7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7416014|8096899003; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dHZSVWxUM0JtZzBIZGxoM2ZnaHc0Smx5LzhKcjJSV2lVLzdvVTlaZ2tES3Fi?=
 =?utf-8?B?cm52QzZPM1JHS24yVEZ5cit1d1ZkSFdSVVJKZTl1cWd3Y3h6bDJuOVJZRTh0?=
 =?utf-8?B?K2RLenNjTEJwd3FtLzJ3QjhpR1M0VWw0SUNQdUJYNXVQeEJKWXBsWDRLTCtU?=
 =?utf-8?B?YUZKVm0yUzJCd1pmVHlWempVRjJqZzdicDBiVWpMaDZabkdwNjAybDhiREFn?=
 =?utf-8?B?Z2RYeWtVZmlmT1c1L2FDbERkUHBEb1c4YlhwcjhwRHdISUxPZE1mR0g2b1VQ?=
 =?utf-8?B?bncxUE96bkdLWlBDaWx2N3pPWFJVS0VRUmxQSjJ5bm0xSlg1Y01Hcm41eUZK?=
 =?utf-8?B?ME42bGRjSXNBS3c1MnAwQUlRcnVZV2I0TWJSbS9LSlNjWjBqTHl2YWg2RWR0?=
 =?utf-8?B?OGVnNDhGN2pWVGl0aVZBdytsY2ZXSXVyQlJicGhTSlBsWUo1YTZ1UmtnZXNO?=
 =?utf-8?B?TEFNY0g5cTR2MXE4VW9HeDFqeDkzWTFtbEhERVNZZHduMGNpQUVFN1hNQ21s?=
 =?utf-8?B?ODU4WTNweEJwc0NZcGNENEg5SE8rUnQvcWFqVThCT21NLzlscGEzeFpYKzVI?=
 =?utf-8?B?TEhwdzFtVm5WcXZiSkVuS2wvOHlkVFV4ZE9XZjRBS0hUdUhDMVlHNlk2YndB?=
 =?utf-8?B?REw0TFN5aGpCb0t1NlRHWVZILy8vRTVZRk1tNWxvYVBYNms0SjlsTzRsQWwv?=
 =?utf-8?B?aEpWUXRlRnNNZmpFZ045dit6MWpnQUJEcG5KYWx5bVh2K2dVczQ4cU9WcGJ1?=
 =?utf-8?B?UUU4SmhiWldQYWxSK010ZzIzSnY1MzZ5bzNGbHpyeE1UVldkNHh2RTFtKzNx?=
 =?utf-8?B?eFVmU1BMSmVCZ3dPUkdmN24zK2xyb1dFOWdSRE1xeEZGZXEvamxFTmN1REZU?=
 =?utf-8?B?cytReEhqcVVZTk00UXQ0Vng5TXpCemxPV0xuTjRDVGE1dy9aRHZkd3hlUDJV?=
 =?utf-8?B?V3JrNmFIM2NpbDZZaVBFT1Z5RmVFUWxrVXJNNVF3TzY1bjgwNGRGU3A4Vmdk?=
 =?utf-8?B?UCsvQ2lXVUVTank3eUtad2h0VWMwNWkybmVJYklnQTNYYlRuQ2NtdWs0bHRo?=
 =?utf-8?B?elhGSHRNK042TXJIUW1SK25IeXdlWjhBNVViWkg5MUdWVWI2cW8xbm9rQWFn?=
 =?utf-8?B?bE9EeEhQZzV3YVlLWkZHa0R1eENkaWxPLzQyUUpXdU1RUkxWUE5SV0x5YTdl?=
 =?utf-8?B?VVV5VHBlMERNeVJNL2VyRFZhYlc2UkNKMGRDdEZtMXJPbGNpeGsvTklvcEhI?=
 =?utf-8?B?dVpiemRVczl5ZEN1R2J4ZGhONE9KT1lpWkpyWnZUaE1JcXlkVDhuVFU1SFBN?=
 =?utf-8?B?dDF2YU9yYWJRbzFYeENIU2pGajNmUVFhVFptZk5EN2xHL0RLaDJHQTd3TFZs?=
 =?utf-8?B?VC91a1dZU3h1dzcrOVNDRHlkTWliMHNNbm9sdmRjSjNnbjh3MnJ2bzhkdC9K?=
 =?utf-8?B?allJMVYyeEI1cEJ5RVkxYlJvbFBsU0lUTnNLdlZsSjk4QzYxOU8zZW50ZEVE?=
 =?utf-8?B?cFRDZld6MTRmSkZ6Y1Z4SkZSTDhGQ3Bjb3dlaHV1K1FzOUo0cXZtYjl6bEdL?=
 =?utf-8?B?OHBOTDBJcWNMWUtzY09ENWFicTZOKzJRWmtqc1daOGd4dlVjMUNWYTZ4YUJJ?=
 =?utf-8?B?b0VFS3I4N243MHVvdmZMeHBhMWUxcmxiTUlnVU91Vng2SEZEZHhmQnpneXYr?=
 =?utf-8?B?QUhCeEkwVlNRMjJMS1V0VnhMK1h1RUwzaGhlbVl6TDZFYjBmbGsxU2cxVS9a?=
 =?utf-8?Q?sX5aDimwSaR5aw5jWI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR22MB4354.namprd22.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7416014)(8096899003); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bURhaWVlVFFhRVRLRG1wSEw1YjVBcElPTW9MajM4L3NCRHJzOGZvQ28yOFdk?=
 =?utf-8?B?NmNtNDRTY21NNHBjcjNCVzhsZHA2NjlBYktENS9xZVpLdk5jUG95eG1NQWV2?=
 =?utf-8?B?QjU1Wm9CVjhIay9waUpwcXpra1VVN2FrMzhCSXlmTHNLT1dRUkNSUzNaSS9M?=
 =?utf-8?B?Q0ErY0EvY3hNeW9tU1FUaUVFdGFCckp3WXM3bGFCVDM1c1h3ZUFXVHZDWGta?=
 =?utf-8?B?eStzV1Z3SzlpbVZablhBNktBbFA4STY0SUtVQU1NMVdaZmVSV09WdVBwUFFS?=
 =?utf-8?B?NUg4UWNMOXdSOGhBK2RiYko3TndPZlJyN0dpVU10QjFFWjBsSEIwZHVaOVFJ?=
 =?utf-8?B?VFpZVXZmaDJPa1pNWXdCcmRtVXlHK1VhUnhlZkdNYVlwcXdaUlh5UGt2TGdz?=
 =?utf-8?B?aXJsNEZmZ1hncDk5L1RmZFo5Ym5WRSsyeWg4MDBJNWxTMEQ3TE4vaTFaNVdh?=
 =?utf-8?B?eXk1Z3BoV3dheDIvSUsvWUtTYi9XNEtxS0lJVTZYaFlRMURIenhYY2VVVUc2?=
 =?utf-8?B?K1lQZ1RCY2Y5V21nT0hPSDNMM3pEVkM2aG8zWVFIV2h1QlBLN0xsWkpHZ2hX?=
 =?utf-8?B?UVdRbW9EWVJvM3ExRC9VbDF0Z3NIblBEekRCemdyOG9zc2htQmpUNlFvSnlB?=
 =?utf-8?B?ZVZqcEpQMWdKdGxyTmxPczVFRVJROHEvMnhhbXc0K3J5UDF5aGJJK0pRekhS?=
 =?utf-8?B?RE5abk1mNFB2MlN6SE5jYnNoRDVHSk8wdlFpeHRralFwZ25pNXRFSEpUWnUx?=
 =?utf-8?B?aXNLNjBVc0RnZWw2QUFZMmNQR0kwQWNiTFJmcTFoMWszMWZPelNPMHhVWWgx?=
 =?utf-8?B?S3ordUxSRHVuakFBUzBHVlM2REUxOFk4TFA1azN0OGxPZ3pKSU5CYTN5ajJY?=
 =?utf-8?B?NlIrTmpRcUJZUEpTTUovNWd4bmxkbWRpZUVNcW8wcWNhTkFLUUlmY2MrcFNo?=
 =?utf-8?B?ZFA2NCtTOWlscElDeHdlVVZobEN0a0E2NDlkMGgxMXBxN3VQUHdvSWlEZWRx?=
 =?utf-8?B?NUk0TTFrTlVKNCtENVh1bjN5cUpwY1BYekhMcnNHMEFHRjN3ZmdqdlhUV2Vp?=
 =?utf-8?B?dXg3RnFjZW5TUUJ3dEtJckM3NXlMZFF0K3RtejdZVzRUQXgxalVUbzhHK0VJ?=
 =?utf-8?B?aVhQNkd3SHZHRityaFY2OU1lV0tnK0RieVRldW9iSDV1YjBldWVZWFBVSzZZ?=
 =?utf-8?B?d2htaTI5YkxUZFlzOFBUQjg4UDZvT05panVoMFVIdHp2S3lzOGRSVUxzWTU1?=
 =?utf-8?B?cjcxaHRXL2R5NVBQaXhxS2pKblpwMGJCZCtGUm1hU0N1M245TWE2aWxCTSsw?=
 =?utf-8?B?emZ4VCt2ZTFaUUFoYlYvbG9ON0ZxQVVqVXdISnVDMGpNSkVIYnl5aE1VYkNB?=
 =?utf-8?B?dmdpZnU3Y1ZnZnRSWVlMb3I5cnZVZTJ1a2plMHIxWnRrMUNBeFU0ZHhWNDB2?=
 =?utf-8?B?WXd0VkZsR2IyRVlwWGFmTENHVWtoWjRac0ZZdFRMaUVjNnRnOGxWTWtkKzRl?=
 =?utf-8?B?aS9VeHY5V3ZTbTgxLzM1d2tBaUozUlpzbGJDSjlvVEszazB1MWNZSStEVFYv?=
 =?utf-8?B?cFVpaTNjZnQ1eDFIemJHS1I5R1JTOFp6YUpybGoyMXZNb2FmUFNkb2daTGRj?=
 =?utf-8?B?RUNUTHVndkpuWmNVcEVScFl2b0VWK1p0ck1ZWG5DN2ZCRDh1Z3FQTUludDJ0?=
 =?utf-8?B?RTFUdzE1bm1YYXl6TW1DaFo5cStoSHV3NjFvLzBtbkFZQldBTE9Oa1hIamdz?=
 =?utf-8?B?dkttSXRrbStZOUNvbmVham1sV0VmTmdGR05SSjZlUWxkaUoxbEZ3aFRNMGw2?=
 =?utf-8?B?ZlpGR29veXZpUjFZcElTZWorR3h2SlNvN3h5aWFiUklDRktBM1I3N085U0VB?=
 =?utf-8?B?bXo4dTI3REVCeDg2SEN3NkJ3cFlydWxYVlNsUXpkVE1jQTlEbVpXUnNhcnhn?=
 =?utf-8?B?cmQwZ083RmpVTGhDMlAvKzlaL0MyMm04TnFkelBnTllycDZ5SXdtM0M0dTBJ?=
 =?utf-8?B?Tm9CZGZiRWM5UXFjc0lFTW1rT2tSMFZQVjFMTi95bVI5WGM2WG5OR1hyNHo2?=
 =?utf-8?B?djFGWkppaXRPQUNKV3lFcm1GY09TbGpLVVFDaU1hTmpuS1BWREkyREpwOTBE?=
 =?utf-8?Q?IrjIjTvKnPbhtCEmf2Cva6Z0z?=
X-OriginatorOrg: phytec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 319695a6-f072-43ba-1ec2-08dd08205821
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR22MB4354.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 22:28:36.8660 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bcab1a-5db0-4ee8-86f4-1533d0b4b5c7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zxLBVGwCyJOCKOTKjO+dwiY8uTj7gYVaReqnkGjQttGlEGRBapz96bNQB+UtxHn57kxV3Pp03oGTyDWrxi5ckg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR22MB2900
X-Mailman-Approved-At: Tue, 19 Nov 2024 01:22:52 +0100
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hey Bryan,

On 11/18/24 11:32, Bryan Brattlof wrote:

> On November 15, 2024 thus sayeth Garrett Giordano:
>> Add support for PHYTEC phyCORE-AM62A7 SoM.
>>
>> Supported features:
>>    - 2GB LPDDR4 RAM
>>    - eMMC
>>    - External SD
>>    - Ethernet
>>    - debug UART
>>
>> Signed-off-by: Garrett Giordano<ggiordano@phytec.com>
> Looks Good!
>
> Reviewed-by: Bryan Brattlof<bb@ti.com>
>
> ...
>
>> diff --git a/arch/arm/dts/k3-am62a-phycore-som-ddr4-2gb.dtsi
>> b/arch/arm/dts/k3-am62a-phycore-som-ddr4-2gb.dtsi
>> new file mode 100644
>> index 00000000000..00330b43fed
>> --- /dev/null
>> +++ b/arch/arm/dts/k3-am62a-phycore-som-ddr4-2gb.dtsi
>> @@ -0,0 +1,2798 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
>> +/*
>> + * This file was generated with the
>> + * AM62Ax SysConfig DDR Subsystem Register Configuration Tool v0.09.08
>> + * Fri Mar 24 2024 11:56:13 GMT-0700 (Pacific Daylight Time)
>> + * DDR Type: LPDDR4
>> + * F0 = 50MHz    F1 = NA     F2 = 1866MHz
>> + * Density (per channel): 8Gb
>> + * Number of Ranks: 1
>> + */
> You may want to regenerate this config if you guys see any stability
> issues. We've had some improvements in our chip select timings which are
> included in the v0.10.2 EMIF tool's output.
>
> ~Bryan

Thanks for the info!

We can start testing the new timings in our climate chamber. For now we
will stick with these timings, as they have been tested and verified to be
working.

I will pick up your Reviewed-by in my v2.

Regards,
Garrett
