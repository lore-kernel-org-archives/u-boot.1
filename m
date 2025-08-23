Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB10BCA0EE4
	for <u-boot@archiver.kernel.org>; Sat, 23 Aug 2025 11:30:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1A7F82E37;
	Sat, 23 Aug 2025 13:29:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="wwF1TPLR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CEAE82E67; Sat, 23 Aug 2025 13:29:57 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51BAC82BA7
 for <u-boot@lists.denx.de>; Sat, 23 Aug 2025 13:29:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pCZK1JCcLFnt1eeAndbbt4FzzT8bdxOfhBSec+Zt/awLpcVBCVpmJPhFABXrrhaxuk+wrDbrETAmXnXwxwiwb5K97g3viH5rhI5bqVnaUNpM9Osxk8GXx38moHNQq3Y1HaFoYLVPgV2hdAG4CQ8IYbUhqpo+Hp2ArD3jxstzU/woOyyvZnXhQ2/BUXPHYskbY6ZUvCGytuax44nAd6w3kWjaHD5e0GVB6Tyf1GzXmtcpSwnJR83ZPMWo57WP91sfBgZfxPTqb7x9oRXdC1xzjgaAejdeVdRAVI4z3yLo++vj8Xn+rRd43evArmCDFrDQJKhq/FXzGxvvCa+Z7mX3WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OjsT1l9PdlwI6TYzemSEEDOGpUCM1Vccu7QA/Ay+5N4=;
 b=Ua6M6+06Pg6tR6+J48Z7I/6xzz6WwvZBlIoCChyyC0xArvw6mcG1Hg4/ulVblsvyN8DvxouJJ8dIuZFDiE04JsqNrSyq/jwzmJrtlInx7/2ZBWOCh70b4jiMLl8HhxwoQVb7EB44pOkSbP4Zh2E+cZGhzqcjDvn/1V0Be3gXYCPkvQT7ffvhe8uXDptB13rA6NY1dmZ4rU8/6P6uQQ3SJJgFdMbfxaq5aL9kxR25kQ7OcEISwS61rL3KjeWvIci9ezx4Itn+/D2moWdTcUUqvmSfyLQBMFJIIxjfJY7gM8wEc+pNL3X32SSkc9m3P3B03QDwD/lzdBA9qM/LPVvLPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OjsT1l9PdlwI6TYzemSEEDOGpUCM1Vccu7QA/Ay+5N4=;
 b=wwF1TPLRBmQDnckeXnkSOPck5oWF0uqYzKKZscH1DTiH1nrTPNzH2Q+Fm1S5r59pZu14a1VkpMHxt1sWT3k1Evqt0fB8LBc+9G7O6pnUcWuGm28J3e69CsrLm85TjaVJlFXwjpzcqAdpgsLtjM/NjtEpr0jRGCyasw4V0bgVmtBo2VjX+1tFVuvyff7V8qxzrFUFKxSBv0Z4OyGNTyInwyd5TbTcfqNecS8iq/D4hyskhcCMQRUci6f7Xrp/Z/twdvyFQPx/vzWcRfYBbPLz6ftoHwGCIAV3PhUoHEyJmyC4ef0ZPAefSRENjZYYQTAY+0lxU+4YfSIy8hCOD+AvVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB5815.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:6b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Sat, 23 Aug
 2025 11:29:51 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9052.017; Sat, 23 Aug 2025
 11:29:51 +0000
Message-ID: <ae9c0d66-01ee-4d58-adc4-66ea36e62cc3@siemens.com>
Date: Sat, 23 Aug 2025 13:29:49 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] tools: Drop meaningless comment from Makefile
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heiko Schocher <hs@nabladev.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0008.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB5815:EE_
X-MS-Office365-Filtering-Correlation-Id: ea02813c-5f99-4aec-24f3-08dde2385f4d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZVpJREUxVEowWnRaa1Y1dk9vaXNERGR4S3AzMkxzYVZ6dnk1bXlVazAwcWJu?=
 =?utf-8?B?NUhnNG9RSTJlZHRPakd6bUlHYjlLeWZWUUFYckh0cUhpc2hOTHloRFhKdnFN?=
 =?utf-8?B?NlpXNHB3RjNoUUJSYkJra01idTN0ZzNobnVEbWdKN0o1c1pZeDc1aDJ4alJo?=
 =?utf-8?B?T2UvazZPVTJueTRuNWFLVHFIMjcycnZlSU44V2ZsdHQ5OXc4OGZXdEF3RW5S?=
 =?utf-8?B?WUlZYVkycUtzYUt3b1lzdGdhYmlvTGMxT3FmMHorNW53dlU4VndBQVFUZ2d0?=
 =?utf-8?B?djNiQVFEVVE0WnBydEQ2VmJMUUFUcVdoUmd5Zy85UEh2cllhaHAydkNPbHEv?=
 =?utf-8?B?OXgvZlBiL01qTXpmUGE1Nm5tUnExZEdQZGd0b1d5enBFRVBuZW8zd0Nxd1FR?=
 =?utf-8?B?VW9FallVaG1xdG96WENZYkRTUlh2TXZsZkJ2di9hcGxBNTJ2Q0ljYmdmWm1G?=
 =?utf-8?B?UDdIOTgvY0dTTzJ6b2RmK200cjdhZHVPU3RVOVFrQzBLT2RsaTh0anJxK0Fp?=
 =?utf-8?B?R1BOVFlMeWp2S2JOUTI4SUVpL1g5Y0hVNTBUM1RhY2trVzR1MmtBcEc1Rkc3?=
 =?utf-8?B?UG1JR0V0YjNYenFPOWFEbVN0WTIzN0dIZ1RhY0xEM014cHAyVll5Q2lJSTlv?=
 =?utf-8?B?SG9NeFNibkV1eEVSYkV0Wjh3MGFWTk1rc09SQ2JYdmR3cVY2YkpNR090SnZp?=
 =?utf-8?B?eUxrd0M1WTR5eXJpL2RRWnpqYklVOFZXQkFiWUxJQTdZS3FUKzlMZUwzR01E?=
 =?utf-8?B?MW5NdHAvYmNZN05tZzV6Wko0UWhwTDl4aTVuOTdqK2xEalJzVXdNNzE3TlZ3?=
 =?utf-8?B?RlJvRlA4TzhVSWU4UmhnTjJ6TU00YjNJOWtnWGc0eHVGSU9KR3BoRG9BeVIv?=
 =?utf-8?B?bEZZeWZVUEJPOE5DbmVmZm1vektKR0xLbWhNeENVd1NMQjY2VFNZYjIwTEx3?=
 =?utf-8?B?VUlWOURZa1VTblc3RHhwOWE2SHA3VTBwaTRkSEU3WkU1SG1tTnZSRXJjL29t?=
 =?utf-8?B?M2MreXM4c0paV2hHbHBlNHlqUTBQMjNTSTBFVlZ2UVFBQlFVamlKdlB1SHRi?=
 =?utf-8?B?YWhpbDUwSUVmQ3RHaDJ3UVR6SUlnNGQ3anhaYW5yNVZXNldwV21YV2tpaDZ2?=
 =?utf-8?B?aERQMkpiNWFNaTNpVGlzVmM0bExFdVpDZitON3JFZEtwWmdzUFZhS2thUjFq?=
 =?utf-8?B?NnJHYlVTSU82SHBYekVSL3dQeFVscm9uTVVLbmdHek9aRFRYMERwSnJ4Szla?=
 =?utf-8?B?YS9STlFEYlZLSk4vd1V0TEVwY3Mzem44ZElhVW81M3cyajIxdC96aWlRWkhK?=
 =?utf-8?B?STNkN1pZcEE3NUNrdmU0eG1maUxtT05XWlFCeFV0R0ZmNDBYelVoN2h0ekpi?=
 =?utf-8?B?amQrSExVOXJQV1lhb1hzUTNId3gybklFTkdDTnFmby82MmV4aWJkSUZ3U1JT?=
 =?utf-8?B?UVEwZXJnS2lWUXR3blpoMG9PVjhoelFTVnFqcGlna0txbFlOTFFxdkZzRHVU?=
 =?utf-8?B?WVFCd2hOZHZpbnFaSW5EZUR5M0x5eEpWUG9Sajd5VDBnWVk2QjJ6dkw4Zldz?=
 =?utf-8?B?Q3M3VGVpeEExTG9pdld6WTFmQ1F4RmduNFBTOXNJZlJaTlg4dk5qcTlZZjlq?=
 =?utf-8?B?bXlWRlJIZEcxNGc5a2o1Ujcyc01xLzVaaWdTWlU5Wk55YlJhUGdING42aXlP?=
 =?utf-8?B?ZGlUblYvVTVTa2R4eExTKzBOV3VaRmZxM0lHc3pDdHduQk51MVlKMEErakdV?=
 =?utf-8?B?WFFYK3Nwdmo2S2cxQUMyMTNVbmxOSUMySEIxVy9BSy8zSHB2bXFkdCt4RkJu?=
 =?utf-8?B?a2xoMUJLVkdIdkxoZVFRUXc4YnlhcU94UHB1SzdaL2xsdmQ0S2pJSldDQ0ZD?=
 =?utf-8?B?cnBKV0lCYW9LdFBoYWJ0RFZRU1pOeVh6MlhmYlJCUldmRHFmcVBVTlJxVjk1?=
 =?utf-8?Q?tvHuA3CpDXM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTZiU2dBTC9SVHpJemYxc2UyU2xvL0FrRU1aSjltY0M4RnBnaXRpMVk0VWJw?=
 =?utf-8?B?cU5LTkdRQTd1SVlyaE9aQ2pLbGhCcjRLZWFiQy9pVGFMNzM1bk96ZHEzdit3?=
 =?utf-8?B?RDhtdXoxNndQRlBBZkdiL2orZnVZbDMzWUI1OVA2TXR0MUZJKzZKN3c3bW1J?=
 =?utf-8?B?T3BMUTB4NU5WczJPN2JiUk1OTWJGeURCNjdJZ0FPTVNSdEwrVVlEQjBMb1Ur?=
 =?utf-8?B?b3N0cmVHN2lNTEVxU2dVb0p0SWRYMWJuSVM4cEs2Y0tIMURhVTN6aXExZGJz?=
 =?utf-8?B?L3pKRk91RzJRL0RwYmRJSitGUWhhME9WUXhoQUJhTjZqZU5RL2MyU3NqUW9I?=
 =?utf-8?B?Q0VnSUU5VGlVck1pUndRdDlCM1Q5S015UU5sTy9JOUFkdDM4cXBNdDJGbEUw?=
 =?utf-8?B?bEpha09HTGFOdVlCOWlnb2JtTTVoU1hoSnh6YUdIa1J4akFDTUQza05SQXZK?=
 =?utf-8?B?Q3pNZzI0K0orUXQrcG5LMmZ2K0c0YytnK1lZU09hU05ueFpkUXdMQk1laDc2?=
 =?utf-8?B?SjJ2eWJ5OG40TGhUQUhFZzhTS2IyUGd0UFlOelE2ZHBrd3RYOWRNV3d4RE84?=
 =?utf-8?B?cXVsVUV3MW0yMmxIMnArUWMwUGZhZG9JSzk5Zy8wQ3U4NlhMVnNxM0ZML05j?=
 =?utf-8?B?bXZkNzhHVDlDVW1DTzlMbjB3cHhORVdMRGxmRnIwMHhmczg1WUFyNWtMM2VI?=
 =?utf-8?B?U213L242ZVpMc2JNMnlRcXdMRTBMa1lpMHNJRm5sR0tHb1hwRDNzT3p3UWJH?=
 =?utf-8?B?SFhQUVkvWFM5Wm1tUXBIMS9EU3pvQkJ2RWlZbUFBYk5sRzVJYVRyeFJyYkYr?=
 =?utf-8?B?cm53OXY0MkpjWjRtTitHR3dOdXJIelJkcXNJUDF5YkdkcjVwakVkakpmZDZE?=
 =?utf-8?B?eFkxQ3dxZUJCYXRNWldSTFQ3WDdPZmUzTldqNEZuUVMvNEo5ZjBtOXFFWlk4?=
 =?utf-8?B?azdJSTRwVU9lUWJLWVdDTUVUM0RiOGtZeW5OQzZTRXA5MnNUbC9BUXVRU20y?=
 =?utf-8?B?S0w5Qnd2YndRRFhYbUMybG9KQnpINXVncEdXd2FMU0c0ZGJuYmF2dVRkZytj?=
 =?utf-8?B?NGFXckFmVlBQMDlyYlloeXdLYW9GM3pOVDRpOUhzK2Q3MWg1bkJINUNUeWZX?=
 =?utf-8?B?ZDh1TnFMNllKSXVKY0k3SmFHMTBMZUhDM1RranVMcFVMUDZQcXJkUVJUNktX?=
 =?utf-8?B?ZDdzMmVUVFlnMXRna2UzVDZZR2FsZG0vUFFRWkdKUkYyZEZuNDJFc0NPaWly?=
 =?utf-8?B?TTRGVGRidnA1ZVZMc1dhS0JIK0s1OE1wT1BVRU5FSUNwUFNGNUFZNTcxTzNh?=
 =?utf-8?B?WE5PK3JBUTdZelljbFAyUk83N3V3RTBTb3FlS2ZhS3M2empKTzNGQXpiVytL?=
 =?utf-8?B?K3VVeTRjb28yZzVXbVIwbFBodnltOXh4cWdWU1Rxekp5ODJocmdkYWRZOVg1?=
 =?utf-8?B?ZnhRZ2U3Z1drSE5iRmZMbFpFaElnT0ZPZ3Q3TkNNMlFGMy94TGt1RDZXc0Nq?=
 =?utf-8?B?Q0xzNmJDNUtJaUhGcWZ4emE2SWhjV3pacW40aXhQd0tNbVR1SXh0K3p2UjRP?=
 =?utf-8?B?djFJZGZsR3ZJSFlBdUh2SGZMdkxsMS9QdStkSTNxRDBIMmZDOWVDZnFEekt2?=
 =?utf-8?B?WFlKdEZaZUl6NkVReUQrSEZyeVVaMWdtbVJzUDVFdi95RTBTYXhhV2V3S0d4?=
 =?utf-8?B?ci9Vc0FKSlFydko1WktQKzdVSkpjU1F5YjBCa1ExUHUvTWpTN0IxRlJ5MndU?=
 =?utf-8?B?MTMxUnJVYXQwSW1XR2NqSzNTOUlKMEhodVNOWFBXNWI4MFpVMU1MNjY3UGVh?=
 =?utf-8?B?eXViM3VBZmlHMlRmOHprVGhXeS9BbkNYNkhKencyQUNPd3I5L1NYY1pLZFRZ?=
 =?utf-8?B?OGttOUYyNWFHZGxjVkxKR3pkVDNRSUlPTkVVMnA1Y1o5Q0RMei9valpMWnp6?=
 =?utf-8?B?dmhsdENtZjlFYWwwQ212bzJkSUhDMUtvdlhtaER3OHZmUy9RTEN6UlFJKy9o?=
 =?utf-8?B?MXZnbmF0YWVsNWNXZ1M2bWVkc3hOK05FNlZmSlZQWnMxUW1ONk9YUXVySjFJ?=
 =?utf-8?B?ejZ4SDRTQ0taaVBheHJ0R1F0WDhJNHpNd0l3bGhMWnFHZFRSejFQeWg1TkMx?=
 =?utf-8?Q?vfLv9n1fGBiQfRB3po38QztKP?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea02813c-5f99-4aec-24f3-08dde2385f4d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2025 11:29:50.9352 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T9vVptSLHF4hreZZ26KFNoazln5Yly2r+c3lqX6ewlpoOLhhUjuO7ezvCJjGI++5AwjuBYpy2DvhP8wmpqKRew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB5815
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

From: Jan Kiszka <jan.kiszka@siemens.com>

Introduced by 245b1029e1af, probably a debug left-over.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 tools/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/Makefile b/tools/Makefile
index 9b8a89e66e6..546ebe323ae 100644
--- a/tools/Makefile
+++ b/tools/Makefile
@@ -344,7 +344,6 @@ $(LOGO_DATA_H):	$(obj)/bmp_logo $(LOGO_BMP)
 else
 $(LOGO_DATA_H):	$(obj)/bmp_logo $(LOGO_BMP)
 	$(obj)/bmp_logo --gen-data $(LOGO_BMP) > $@
-#endif
 endif
 
 # Let clean descend into subdirs
-- 
2.43.0
