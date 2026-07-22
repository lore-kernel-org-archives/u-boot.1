Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D60FC4453A
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 17:57:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9397D608A5;
	Wed, 22 Jul 2026 17:57:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YxGT5Wg6EqHn; Wed, 22 Jul 2026 17:57:52 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 599DE605E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784743072;
	bh=YCJU4CcctLTNdO7ek1tFat6+TVK7+n4xJgzv43UOqiU=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=pFR76PgUft4P2EKxY4kAUqbDgPVhCmCidHPeVeJyRlAfI4JQfsjsEsyyAgnGiM04o
	 LYc/EtmlfKt7g9yFzoIVqLs5D+xLG7nv55IZbqBrjENRBKhlXnopKjCu3RZmuu+1Ht
	 eNR3ObXrws9a5smXVjPU4SOEtyfSRxVnWzB2FqqbmTW5/RjMwBfgWywceryYi4gkTI
	 2bvQEDhJ29pGaPGcuL1qO0MoCn/44TI52TA6Cs1fyp+QOLkJ91shDY//xIGJH1/ROw
	 4+Vi+qiJuDdwOo5yJrP821RdXXVcWeJ2IIjrvzyinDfE43k0Dt1IP+w9Qmxy4XNll9
	 wxc9CA+E9/GxQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 599DE605E0;
	Wed, 22 Jul 2026 17:57:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 36BDE224
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 17:57:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 28BE7605E0
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 17:57:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 92s4RiO8m41v for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 17:57:50 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org EAFB7605D1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EAFB7605D1
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EAFB7605D1
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 17:57:49 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EA8D846A4; Wed, 22 Jul 2026 19:57:48 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D34083E76
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 19:57:46 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gW566glFAfsUcHOXj12SFBU/gY1pXqTlobJEpCInl73is9DCA8jJaYWxwiqNq6BjH0tOJILKPcPy5sDLKVhOxpBPXpXaEyhNlMnNa6EgSeRUfqqFTv+4WIMOiDh1btG1o9zfbSRVS8I9qPdRrv8JkR9VSWVvAopTwIgrX2ptmNrq4RAQTsD4PAxcHNlfkPsd5fLFemN6zfnWsHGiCVYz6iVTW4WffdcFRR3rbi2HcUhgIZLALXLBfLuDH9ldy/mdoSblwjEEjPNrqkRmZlzrOXPdWaKqeJ41ar/Z+fIEIcl0fmDucAS+DGj97wazScsfj/CALH/2x7syATcF7DjIhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YCJU4CcctLTNdO7ek1tFat6+TVK7+n4xJgzv43UOqiU=;
 b=jbdQilySdYuE/vXKynR8TJBRiYqIlxeK2K4XQUtYrw9dothE0e/t/wv5K4CmCK4Agkfd4Px6gqPfc6XNJyUYGYV4Of1/ekjFTgVvUuOamMm798zR4bRGw9tzctHbH6mAULqIHhmifw6KMLXAaB8TMuEdVt2pY+1DXguiloP4BQ1Uqxos8B7aNZmM/n6QdBpSDUrjJ5kKEvMWomlN3GJZHvg1MxyAdQwAfHOo78B0Um1pbZ3nnzex6NZxX1ol6sLz0JLx0rgiELNv3Mx9JzHwzlQzbIDKeBu0Jc2hAZQyxlkZ8ctWYUcB7JQv5hScOvaFx6ilAx+R+9bc+tBTkF4SgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by AS8PR04MB8021.eurprd04.prod.outlook.com (2603:10a6:20b:2a7::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 17:57:45 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0223.017; Wed, 22 Jul 2026
 17:57:45 +0000
Message-ID: <2f190d03-da70-44d4-8821-23e5779be310@cherry.de>
Date: Wed, 22 Jul 2026 19:57:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] rockchip: pinctrl: use include from dts/upstream
To: Johan Jonker <jbx6244@gmail.com>, kever.yang@rock-chips.com
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, trini@konsulko.com,
 u-boot@lists.denx.de
References: <d5752c9d-eca6-4ee4-a0bd-52ffc8103976@gmail.com>
 <5c0bc31f-047b-4b51-999f-7f6cebd8378b@gmail.com>
Content-Language: en-US
In-Reply-To: <5c0bc31f-047b-4b51-999f-7f6cebd8378b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0244.eurprd07.prod.outlook.com
 (2603:10a6:802:58::47) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|AS8PR04MB8021:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bc047eb-3ed5-481a-7a7b-08dee81abbaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|22082099003|18002099003|56012099006|10067099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: cWcU1O5omUD3QXrXAeuQkuU0LpaBcFrawcqHi7tzp9KO4H5mseta9I4M6K4lkDaotUXdA6IdW7kHqySN8xfYuHNcZi63gOz0lq9gPzQ6xkM6/XBBvRQa8K5eF6rVIPGZKodVlV6R3kzCPJSmk1BEzcAIrtiTywBNJRRnMsD5AStvUb5aJ8T43Mxkaw5FTyweW1UWW6M0HuFgqETVNDm4SRKB0yx2VIzNhyHfbOIE6K9/xUonjE7VNvsberP79tmeOU3/IlCpGOA0WUkb+kS3m+JEQLErb2TESoZ4EQqJKOofAax1/l/AtKpJloLaeFf/y1SHmmgFtvwsdAgQzb5vzzc84Hhtz/1ool/TPIJfVY/5C5tDvGY0L94Z9H7aHQjSfyhbId+imgtn+/T4+80PB4zZQnpz80ryuVL9fovDsBpdpzcn9YcAPlaiOhQ3dJhBW9V1YIkDIW/b+dHYNS79dlwEPyN/iSF6k8dpBWqIXkZ6O3x9Aw0MeFk/XeetwXhI9RV0eL6jewJSwcYZONWcJvXkNwfGmSe0TCWq5XhvNIjIuYC3VIj5BH84jl9c8hrVAOWLvTKesBzfV5hGkQkCJu2i7MPyGDmxwvYiwFHyJFsuURPLR6OJYWD0AROAA8gZuXijRN+TL+BvopjTNJabWnbKoO/m8GPT48hmsaiIEIQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(22082099003)(18002099003)(56012099006)(10067099003)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dC95emEyd0JYYSt2V0NrTnluZ0IrVmNQNENJZmF1aTJvUzlwQUliMFpLUkt4?=
 =?utf-8?B?UnkyQnk2TU9vUGd4RitOaEswM1dPM1hFUGRaNGo0Z1BPUnBQcmIrQzNKZlBk?=
 =?utf-8?B?VzhBN1RBR3hmamdyOE15NHhFUDdSVGdDWGFKcUc5R1d1aCtFOCtySDAyZ2g0?=
 =?utf-8?B?WVpla1NXa1dKeWdpSWt0OUVQOENLUDBVTDBHNWlzZ0NCM3BCalFpbU1hYTJs?=
 =?utf-8?B?YzVhZW9aV2tpektmY0hVM1d0Z3YySmRsNis4SFhJY3huYjRNMi9lRGJ1NUZK?=
 =?utf-8?B?T1AwQk5Jc2NnNCswZHV6QUxtQUw5enFBajJqWGZqWmJPZFNBODBnRSszNGla?=
 =?utf-8?B?L3ZMTEZLVXRaZFhtY2psellRUEpudXZ2eEorREljZDNFV2N0ZXZsbFRiM3d6?=
 =?utf-8?B?OHZZZ2pheDNva25PTTNiTW1MNXloSjBXU2E2dUtyMjdwR2UyWWR3RWxyZTQ0?=
 =?utf-8?B?cDRUdHJQVXZXeG5JUFU2eWtPSlNUSlh3OGlkdDU0a1Q2YkFOWXhRd2RrMEk2?=
 =?utf-8?B?Vm1hdWhjTkFHMkxhRWJackZ4QVJqTEg5R1pqQTFxVnI1L2RFVDkvOWY5dGpW?=
 =?utf-8?B?dU1aZHFJRlduQnRsd3k4c2R2SjRueCtnZXBjSjVYZlVLS000WlBZMG01bzhv?=
 =?utf-8?B?RTRUQzJDNjduNmpDQnlSdk5GcWJpbkR6ZFJaKzdudTlRWXdtMDkwbzcvRnFp?=
 =?utf-8?B?SVNUbHR2Qk1NTHRMOXIrNmFKTHp1dDVNMXBrTTlwU0QxcWx1YnNDTGtZOGlj?=
 =?utf-8?B?ekFHM29KUEZGQlhrUnlKSUpmYUVFYitKRFRhdVRWdHRCemhTcUd0UEZIY0VB?=
 =?utf-8?B?YzhMWFYwTlR6MngwdXpwR3JSV0FQNnd3WmZmK1NYVVVtTVFlVkpoL3FuS2dr?=
 =?utf-8?B?YTZGTCt5R2JweXVEb0FuRWNXS1kwRU5INXUrZW5uZndId1hrdzZrM3ZXbDIw?=
 =?utf-8?B?Ty9zMmhINHNLdGpLUk5uSVpONmlKRi9BMG9tRFdObElheUZBNXdXOTBLVkY5?=
 =?utf-8?B?bjd1ZWxlTTlvNStjSk1xTG1aTkhlQVloR0ZoWXFseWZZc1ZGSDM4SHN1STNy?=
 =?utf-8?B?SWFNTjczNTVXRkhCVng1TUVaRjFtWHkwaDlEQVlUV2x0WkNURGNCbU9ZQUtM?=
 =?utf-8?B?MEdZMTg1a0NoUzF3MTBXL0ZQdXlKdUdmamdPU1g2N3RHbXdkTkRQTXZyUXcz?=
 =?utf-8?B?RnE3MjltcXlnd1FJaXkrb1V0YmN2RzlJWmVmME5FeHozakhXL0NYOStQOVRG?=
 =?utf-8?B?LzFQTkl5QmNjY2tHeGJ6d1hoc040R09Wcm96dnd0azdwKzFRQ2RFUjZDSHhC?=
 =?utf-8?B?YjY0TjVSSnk5UzNBcEE1SGcyZzFqQ3lLdStBb1BDOVJyTXZpOWZjd01kdU9X?=
 =?utf-8?B?ZjJnWlFzelBDWTF4cnZ1SE85TWRLTVpveGkvbGcrL3orK25BMStYVmVUWXlU?=
 =?utf-8?B?Nm05YlR6bDJkUHNxb3I1L1NGVVVzWHl3Um5HdmhYaGFwK0F5Rm5VbDZKeVQr?=
 =?utf-8?B?cTcxbmZlWGdMWGJ2MGxuU3h0WDJRSHdpTlMvN2JRajNiVGJMUW1IZDV2YjF1?=
 =?utf-8?B?ZU9PWVQvLzRzWSt2NlBYZ0VRdm5YZ0F2YS9VWWpBb0VXSEFDdWNyWVJPM0Rm?=
 =?utf-8?B?Mm5aZVVJSXhqelkzQ2hibXVaWllGMHZYN0JiRWlxaEdNMHFqUitjK3VNczlC?=
 =?utf-8?B?d2V5cXBQQ04vdnpWaTZReEZ6NEhjZmRFVlloQ1MwVUlyckRFZjRrSVlMTHdi?=
 =?utf-8?B?NEJKNXVhcUo4MDJjendSWU9hNUpZcGFDMkMrYUNhcmJrUy9HZG9nUERiUmth?=
 =?utf-8?B?MXk5LzhKaUo1Z1QxNUVoYUFZNGNONll3Q2xacHcvNEtYN2VMSzhnVFJaYlVG?=
 =?utf-8?B?UDNjYmw4YWk3ZVBLU0M2OHFPSmRvcVUxVDgxdXJwaC9INUw3cTRqZkswT28v?=
 =?utf-8?B?V3pUUlI2SUtla29LVStmOTFxVTFNdG85ODJta0FWcDE4alRRamtESytHK2Za?=
 =?utf-8?B?STVBZSt1bzNPOTN0cVpISWRNUGZROG1HNlRXdUZLd0NmN1NTbEI4MHhySmsz?=
 =?utf-8?B?dUZieHRuR0hHdnVENFZhenBMRE1MSFgwMFo1Ri82TVVxckI3NXRwRnNGVmN1?=
 =?utf-8?B?ZnlTYmI5NDJwYVI3Z2thd3dxYURaTElXL1FVRXJnZDdpQ29xN3ZkQkRrVC9q?=
 =?utf-8?B?TEx2Sm1iekxCZVl2M3RMTUhPVnZPQU1NRUNwQUhIRDJlVHFab09yeTRzeUFT?=
 =?utf-8?B?V1N5M3ZBSXZ2Zml1K241YVE0QjhFRGhOK0N4UUsxaWRvc2sxc3Y1eHdMcXlz?=
 =?utf-8?B?UEpyQ3RNZzJ3TnJ4RDJUcXFmcFR2eUpRWXVub0M1MHFIR0M4K0ZnZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bc047eb-3ed5-481a-7a7b-08dee81abbaf
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 17:57:45.0679 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JWS3HlPhgdvsPa+RCRvnvtA2P5lleDx36TdOPl0KwUTeTg5c4K1ZnDKZSoSlVuf83XnRp/pQl/b13fX3uq4n6ma5h+PMfb6ZOEU8pMg2rMo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8021
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YCJU4CcctLTNdO7ek1tFat6+TVK7+n4xJgzv43UOqiU=;
 b=YxYfLRonfMYMVhV/iJaRrQsBBsQyUuD5HerUIcvC3cq7F8+Z+3q+S1gojTV8l4WR84eAa608u4j7iQNRg7DQVSPOrOgzZXcwlBMgdmOl0tP7SwEaSt4zpIC8ejZLRBO7TOG365r9d6RSURHcDNGIeIHIb5g05gsDfFpx++gDqns=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=YxYfLRon
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@cherry.de
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=cherry.de header.i=@cherry.de header.b="YxYfLRon"; 
 dkim-atps=neutral
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Quentin Schulz via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Quentin Schulz <quentin.schulz@cherry.de>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Johan,

On 6/9/26 10:23 PM, Johan Jonker wrote:
> Use Rockchip pinctrl include from dts/upstream and remove what
> is now redundant.
> 

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks for the cleanup!
Quentin
