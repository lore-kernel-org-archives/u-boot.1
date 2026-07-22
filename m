Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20098C4453A
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 17:56:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 21CB540904;
	Wed, 22 Jul 2026 17:56:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ShahMCsJ6an0; Wed, 22 Jul 2026 17:56:17 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 31CB640589
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784742977;
	bh=l/gTwHpECBsKxqsTSKtJZ4CPLul3RB5NDdXdWUoDH6o=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=VcxRnE5wf7gEFhWt2FfEPtxO8RDf6B/ARI24UovoB3iJp84xZTCCHZmmDJnPM0oT3
	 vo8cKq/xQzyGFNCfOjZmjtnedaRLRbN4Pb99T9Ff+sAxidu178A5jF3PwnGA/7wySb
	 OGMizlwGVIQXe2lqQ/SfbD54NZbYD3RJlUckA7rjdCthXfbMSAXhwKg1n5TBJx+gxr
	 anYFEMMOrEbjCzJ0QMsCWaXeff1hmQe9SxnKxvKFvd35S5EmWvILmWwOgbAja1K7uZ
	 fQKnxZwE9emILL8AvjTZApwjja4zc9YGG+O1tRH5o7ju7oDaW9N9TXq6nZU+oWXxBX
	 P8lFSmRoWtPLA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 31CB640589;
	Wed, 22 Jul 2026 17:56:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id EF499313
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 17:56:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D523D605D9
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 17:56:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 19Y_eS72w2yc for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 17:56:15 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=quentin.schulz@cherry.de;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org ECDE3605D1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org ECDE3605D1
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp3.osuosl.org (Postfix) with ESMTPS id ECDE3605D1
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 17:56:14 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4554846A4; Wed, 22 Jul 2026 19:56:12 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07EAC83E76
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 19:56:11 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c0WbaY3+jEkU/+xLVdyRpzA10pZi2jEUBRvIE0FY/etK7du9mARjzwYXxJ9KeVwkwP0tRL6MwrzinffYGMHVT+/K4YPRs+mTr5JbD2pkxlHyQukeY8gZs8tYQupftKyGQ4X8O1e5s3K405ptva96v6J0aYutbKLnei/gESWK8/PnUMq7wio+mfgaED13dvjrGXPZYVkpLEH7Ca+pYwbIBiOTfc52BtOz7/x4+0z2XQP2utEyTlMY1rL9VzR295Rm/dBj0uvAwJjpR6FIP5VTpHhOdJqkqrB/GLdums59nWQvKZh+sSUMJkXYdhvoHonLxi68BYDrHqXWj9ga+nhiiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l/gTwHpECBsKxqsTSKtJZ4CPLul3RB5NDdXdWUoDH6o=;
 b=vp9sf63p9fvC6/MKGPITSD3e6fEkNAqIWXF3KzlwxbcaK95EQI115zMEEBMlfUaw55HyTTeuiOPzuJSQ3cvrbxqGBM0jY8QhD3/6fCCmpnO2hrmiYmcmWIBsoq13WFKXnoGRvvnYR57eHE2lfBPZaUt2CH82qYO6FMua7gD6zn4SQ/of180WP6W6CuHBNtQA3M8j2OySiCquC8iiRLEqwCNiQ+NxVKLhxAqUrokVAhKB0KlZgLzwWJq2QayW1m42tex27ivX+/wqFeOBw1RsXG5TNRrvoiv5RbV6niWPb5WUjdl7lPZyTIvTDS9dUEb9MJB5Z6YP+zcdgxG6t1n9sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by AS8PR04MB8021.eurprd04.prod.outlook.com (2603:10a6:20b:2a7::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 17:56:09 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0223.017; Wed, 22 Jul 2026
 17:56:09 +0000
Message-ID: <74c8c4dc-74a3-42db-b275-ded5d4d6ac27@cherry.de>
Date: Wed, 22 Jul 2026 19:56:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] rockchip: pinctrl: replace RK_GPIOn defines
To: Johan Jonker <jbx6244@gmail.com>, kever.yang@rock-chips.com
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, trini@konsulko.com,
 u-boot@lists.denx.de
References: <d5752c9d-eca6-4ee4-a0bd-52ffc8103976@gmail.com>
 <6bcf3192-82dc-464e-92f6-b9758f6c8422@gmail.com>
Content-Language: en-US
In-Reply-To: <6bcf3192-82dc-464e-92f6-b9758f6c8422@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0176.eurprd09.prod.outlook.com
 (2603:10a6:800:120::30) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|AS8PR04MB8021:EE_
X-MS-Office365-Filtering-Correlation-Id: d02209b9-5e3f-4eb6-2515-08dee81a82ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|22082099003|18002099003|56012099006|10067099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: CRUZNc2UIfGQ68UiJ15ubmfOGuGrkxJaw7ngAkzgPvh2K1HscsCa/9mJmRE7WypYxMSjqn9Uar3b60+Na5Uk6K7icHfVtwbSRFOvXa9jNuAaaLqOOGdiFVBr2SOVvpxAg/dTmmrVL39bryh81gJfvB4HzxeFx/TIJM7Zy4BwIdShlqRB/WY0HPaprOZ+5aUPq9CvTxgsBBvsAWMsVaHQsSki72gILC3muzkba42g+Ooe7j3YxMT2ejH5eql936+WcRgJYhAQ01MYvMQNGOVyBf/ENSlEvU5xM+k0GAwu2vmbLvW/Cj7WmJwucVVSsEGVaeZyr4IUTj4k4xGU/v3pJfooUMC4NSRYhEeTvP613Iw89kUI/Y/0j+TJF06eSLTogdHkoa5+I7ZaKXafAbQxOUSEWyint1L6eLFGxxVgN0OlrYkvX2G0l5YX97Ktqa2f50XndhCIeFoHz22eJ2s1e4klrZfiH8StZdfMje34mfKWso5sZhzUl4umE4Mi5JgfpbcQJhxQ2LgzOJnGaGcDiYJX5hpej1j7wKEuGfgia3AyBy+bC7mT1iywH7M7wWUNqVZ1AtEyg8dgg94XBjhuT+GP0oq/i29orzBrlXWupOmek0lGtnF2xbTRZaZmEIzPUdDJU9oWyiKD3yCvuyEn2V00tcMsMKudJBrji1Oi9BQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(22082099003)(18002099003)(56012099006)(10067099003)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aEM5V1ZZcGlXNEFwTklWeUtjOWRWWHcyakViQmpBTE1GelFTalBuOHlIMFZS?=
 =?utf-8?B?bW5KTGh1QTZabnA3d1lBWkZIeGN6RGQ0VlVYakdZZWRpOWVpRzgyRjRhMGVi?=
 =?utf-8?B?V1lDRG1tbHVvbERKcTVHVlFOb0k1TDZvNE1rY0FFUHNKUEtNVWhJR0lvRStn?=
 =?utf-8?B?QnFleVhlT3BobngxNldOWkJXajRXYnpFYXYxTGptTm82dE5LV05DWFc5STdT?=
 =?utf-8?B?Z2liOCtaSTgycE5MUXFmSUVaeXlCNGdVc2FObnQ3dFdwZTNVbDlNNlUwU2lP?=
 =?utf-8?B?SllwTXlmNGEza3R6aXhiZnp4Qm9OWlZxREVNYzFvNm9zTTFhL0RKd1MyVTk4?=
 =?utf-8?B?LzdobW4veHp0V1I4UFB2L0VVQllnanNTK3NDeVFGbGptMkZaN2JuK3Jlak9r?=
 =?utf-8?B?eU4weXgyQkNXdVZ6RGZmY3NRRmF0MzliUUZrYnBvdWVJUTEyN1BEOEc3YUJq?=
 =?utf-8?B?TVJTTkZQWTI1OTdhMlhsSFNzcVNZREVielNpVCtLZlJudVplelVEU2o3aStq?=
 =?utf-8?B?TDJyVjdKVTU3cW5YZUphS3pIOHBqbVF6VFdtTnh4dnJuSHNEVjl0cVpwQndo?=
 =?utf-8?B?cEJDRDAzZElBbUpwQnY1OWwvWmVBYUNjaXhYZ3R1aHVPTE1CSU1rd2NDa3I4?=
 =?utf-8?B?cjljOENRdkJJeDJMdVNudnhyN0lZdkpXWEVRelFGMXMvZVI3N2FIRXZrb1hF?=
 =?utf-8?B?Q1pWeEFSQkZ5S1ptL2ZYaXVrK0F3ZGs3TnFlSU5FbG4vUTZtRVBrN3F0b3Z2?=
 =?utf-8?B?Z0Vab0R0TjRLTVN0NjF4WVJiaU4zLzJQR3d5RUQvZXJOelF4enhvcmpaZUpL?=
 =?utf-8?B?dEh5bUpsZnVOVkpON0UzeS9ucTQrSXAyS3psQTJQVkk0RjZ0bkcyRHpJaWs3?=
 =?utf-8?B?QUVCYkdZOEVqd3NINDQwVHVZNkxyV25DTzMzN3RlWFVqVldKeUZ4bElrVHhh?=
 =?utf-8?B?RXB1dHEvRXY3MjM0b2JaV3ZCWXBRTnNsVGI3WTVFNUpSbHJWNG9IWW1MaDdr?=
 =?utf-8?B?QUZVN1lOdDdoeEFiR213WGs2aFRWeGRMeUhzU2xOdlJDTFVaNkE2SGpCN2lC?=
 =?utf-8?B?SFJteFA5c05nSzdHbkpucC8ydmRXWUt0dlJhN3RXN0FwWHVGc1Uxb29zaVk1?=
 =?utf-8?B?aHNaN25BZnU1eG9NSVFqd0xtWXF1c0pVUFd0dC9wMFhiU1M5UklMNkJtdk1q?=
 =?utf-8?B?S0hrck9CdkFZVUpOMzJTamNQWEQyRVNqOVFXblRGaU5tYWRTQWc3WVp2MnV5?=
 =?utf-8?B?aDdjVkxNTE11Qm5UVTVBdmZsMlp6UjV1RlBqTDAra0tuMHFyUVovQ0lSNWtF?=
 =?utf-8?B?YnhIMitNU2FrVWFFSkoyN2dsS3E4WnArTFFDYUhaQ2lxS0VUMkdqcjhQZzhl?=
 =?utf-8?B?NEFlQXQwMkJ6OUFmVGdRTkdFSnZOckRUMEU3dHlJSDhSQUFLVGdpOWpneXRv?=
 =?utf-8?B?TmJRZGR0OTc5L0IrNFZsd2xJejFoQ3IydlVVTVViQTRZaGVXYlVyeTE1aTZW?=
 =?utf-8?B?M1NWUVNRUjR5SmF1RmFNMmVkK2VOSkk2cXFaWHdwTW9kTDU1SjFoZU4zRS9s?=
 =?utf-8?B?eXg4cVZzL2kzK3dZTG91WWsreG14Y1N3SXlId1MrSjEvNWhwWVRheUgwQi9w?=
 =?utf-8?B?RWxTeDl2enBIakoyV0svQVVQK0ptc2JuMUo1M2xHUXlxdXhnRUNkZ2c4ZDNj?=
 =?utf-8?B?N2RYWlNzTU84Y2RsRGl4clhZWFRETTVWVDJsbHpHQmxmdGJjVnJDTzd5SzRK?=
 =?utf-8?B?ZkpvZ0RWSEJoTC9FdllKdWFoTlJCQ3RyL1c0dFlmRmYrQS9YMnJqeTlZek5L?=
 =?utf-8?B?VldnZGRqKzRkL2FtNHRNUXhDdDZxbUZRbnBtT0xoTDlFOGpuOSthNklSOWE3?=
 =?utf-8?B?VXorbUl2NE53d1laeUhITmVNajhSdmNCV2prZXFEWWxJQlFxUzVnV2k0RW15?=
 =?utf-8?B?cFBWZ1FNeldYYnpDRUhmV3VYTHZoV3FuL2ZzUzBKbDJyZEh3c1N3Q0tld0R2?=
 =?utf-8?B?cStBVXFROGNId1hId3QzL3VSTFJMV2RwalAwUkkvR2tDQUphU3BETG5ldTFE?=
 =?utf-8?B?Ym0yN29USTUybGg0ZDk3VmkwaUd0RWVOVDJQZTBKL2FTTVpJdWJYL2FTMDFW?=
 =?utf-8?B?SnJwVWgyU1YrQTNQVEVlUG8wVmE0UFc4cWVNWUN1R0tiajYraUdTcEQwR2Y4?=
 =?utf-8?B?L0ZDeE5pYmViYTMyWEVSZ3A4YnZ2SmVGaU5HeW5jeE5QZ2hZMUxobkt2dmxC?=
 =?utf-8?B?bGpSK2tDZGljb1NIUG94OHM0cWJRckI2M2JNVE5tYTc4U0V6RnlNOFc1RW5t?=
 =?utf-8?B?RWxnYUpsVHdHY2tHZXFhODNjUzNmaDIwN0tzSCtGYURLeFhBMUFWZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: d02209b9-5e3f-4eb6-2515-08dee81a82ab
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 17:56:09.4149 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QS6jS73M73oRuFwdTbe8gTgdSCS0bjp8rG/Mpf9GVvq2T5yzodDh2lK3ItVGxIhBLGpsf7yEySx2J2tVc6pfrmZkXJyXOafsPJbys+gdMo8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8021
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l/gTwHpECBsKxqsTSKtJZ4CPLul3RB5NDdXdWUoDH6o=;
 b=jpMhTUBRuqV0iElm0FbauTb+1VG8O+IWY1hfl5sv5L/Mq5p1LieEViJYmsNybwjtyHcgZvADNqM5NcLPS1dfbXBTX/yRUWoAu5kuGTjSAddEC7xpIDIp9wBaTJCsa6A4ShwEFyoKvWExQtRP5rhO3saEqcq5Z+K33UL+M5nD91Y=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=jpMhTUBR
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@cherry.de
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=cherry.de header.i=@cherry.de header.b="jpMhTUBR"; 
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
> The use of RK_GPIOn defines is deprecated in the upstream
> rockchip.h file. Replace all them by the gpio number.
> 

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
