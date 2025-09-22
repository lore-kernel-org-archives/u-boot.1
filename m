Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DA21CAC592
	for <u-boot@archiver.kernel.org>; Mon, 22 Sep 2025 06:48:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3BE182B07;
	Mon, 22 Sep 2025 08:48:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="V9cbpsBY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8820983280; Mon, 22 Sep 2025 08:48:28 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 415D68004F
 for <u-boot@lists.denx.de>; Mon, 22 Sep 2025 08:48:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ye.li@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CY+Licml0U7T/7iSfeX6cyfuoLkXSTBCxwVrMGXwA3kX6/1n1Oki3TbNC8suJolEiO+jt/FeKhzYEMV6c9XjXcAiBSXukV7wgvDY5VURuC1asGNR0s5yVJlfclCQpv0OjMNJeO/fhm7ThcJiCKUDKZ6ceubridoxCa6lgSL4KSuKlgTimA9lNXr2BDOwYKfxHZ75I9+Pz7yz9H68ZYUPwI5J3nPWF8vjOnCTQwMxNwQYE8EN8gzFtWRz8h0eCT0YJF1GQlXL+xhV3t3bBzkuZ9xCu8uwn4XfGRoh1TeTipsajhZlNpkSSH69+S5XJnQ1vRzsb275XF3whdi0a1Z+6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WHot+trYrizPcTu3VjFF9RJYBNbhKPqAdq6S0UX42T8=;
 b=IoaGOnX1Z7eMJhFj8MWFoBuJyeL1dqncHI1PHeEHwGryD1bzo4fpNN6mqOhu4XePdt3byaSEFPu/1LLj+Gwly3+GmxeZmIYn6wYRuqaPGDIsQS5JXIsK6QJgZxMDqoJczqHvSG5e/bLnYtMmwmTNyS/EdVxiTE3iZXHSAzl/BHow7/Z7sNVIebtNU8r0v/5f7ibKcsq0U1GMY/UYdjipYBEteqFv8NnSzpDMOLJCJS/OgzEyWuIS2q0jkwbh5xnE3EvhD5v/1mT56ZSSETKpjl6BYO0VcMu8VDj9BdythBEUZQZx1Mujoonx0mKOuM+KTPDtV6NNLtyrB2yf/8naFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WHot+trYrizPcTu3VjFF9RJYBNbhKPqAdq6S0UX42T8=;
 b=V9cbpsBYjUHuQJTls8iATvhGPaD+Nip5BJq+ecq9glvVLzBfGdo3+OWj3PG6xMr7kLy2Ok2hVXQo+mY+2HB2cx2uiZzJl5L2YycNfjpbATrmmk8XZUN7mx96fvxdZ5ghRfMIJnGbGI5Bssm98Psukpfnwn1Ytas5Or8alI/MMOXNbpv+pxpadqPa+zqGRic+MabXRFYasH8Bph76pL9hJYB/XVMQmVHqjq0v9XDTWppRMTZLcyO4+NqVyvTqCZSDTpds73oXthyNma35SptA3EnvLmTIWKg2aIEV7jkPKjJK9kKuyQoP8XbLrg1l0voAnPygzqAKORz0eGhzsxP6uQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::5)
 by DU2PR04MB8885.eurprd04.prod.outlook.com (2603:10a6:10:2e0::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Mon, 22 Sep
 2025 06:48:23 +0000
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90]) by AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90%7]) with mapi id 15.20.9160.008; Mon, 22 Sep 2025
 06:48:23 +0000
Message-ID: <00c8213e-9b2e-4d3a-a265-a92fa956a999@oss.nxp.com>
Date: Mon, 22 Sep 2025 14:48:16 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cmd: sf: align erase and write on erase block boundary
To: Marek Vasut <marek.vasut@mailbox.org>, Ye Li <ye.li@nxp.com>,
 u-boot@lists.denx.de, jagan@amarulasolutions.com
Cc: peng.fan@nxp.com, uboot-imx@nxp.com, alice.guo@nxp.com
References: <20250919070156.1497268-1-ye.li@nxp.com>
 <0528b2bd-09ef-45d4-9003-f8c1baab372b@mailbox.org>
 <220c3246-781a-4349-8d16-6eb1dfdc79e0@oss.nxp.com>
 <c019ab11-3f3c-4e3b-9049-5ed31be9c145@mailbox.org>
Content-Language: en-US
From: Ye Li <ye.li@oss.nxp.com>
In-Reply-To: <c019ab11-3f3c-4e3b-9049-5ed31be9c145@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR03CA0086.apcprd03.prod.outlook.com
 (2603:1096:4:7c::14) To AS4PR04MB9436.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ec::5)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9436:EE_|DU2PR04MB8885:EE_
X-MS-Office365-Filtering-Correlation-Id: 35302860-5e69-41fc-a864-08ddf9a40645
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|42112799006|19092799006; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y0Y2dlZYTG4wZWVHS1k1VUhtcVN4SlFwT2RBMDVQbzI2OWQyYkhjNUppdE5n?=
 =?utf-8?B?YllaRGFvOW5rd0dwK1BqNS9UWmtDNFV0TjY2V0MySXFOeFh4Tm5HZ3BlZ2h6?=
 =?utf-8?B?NFN2TG9iMWFxZkRMcUxvbm5UcUNSSElMeTc5RjQ4MDFoQys1REVlT3R4bzJm?=
 =?utf-8?B?SHNrWmFtTEpPWHRIT3liQStydUg3dnliSzRWSEF6Q3phVmhBOFdLVk1Id1g3?=
 =?utf-8?B?bENabFFuTVVjbEo1M1VMZC9lMnQ4TCtVT3FsLzk5aHhJOGo0eVlGZDYreHBT?=
 =?utf-8?B?Vys3L2RnREpGc3Z5T1ZtTG1USEZuNC9rd3huOW05eE04dTBteHVoUGs4ZDln?=
 =?utf-8?B?QUd0VmVqVVlXUFBjWnJCS01zTUo3QURSRWJ1dGpmbWFsaHpRZ2lEZ2ZUQjFX?=
 =?utf-8?B?VlRjdm8wT29rUlJyZTZWRThQYmxyaXJjRXlJRFpwSWhxOTZ2NEhLKzUvWWZH?=
 =?utf-8?B?ODZsM3RHT1dxcXJ6c0lTbjhpU1FCUDBIaUNpRk1RSkhUMkNvMWZNQlZVaFcx?=
 =?utf-8?B?MThCQTRORDFpNmZpVzZLWlZ6VVdSUjd2QVZ6L2RwZStqTVZ1cWl2ek14Z0tP?=
 =?utf-8?B?MjFNUjgwQXhZalNlMWwzUmxGaGNOaitUQmlERTQ1eGxUUTdiVDRScWZjaWFR?=
 =?utf-8?B?YkJoR09hQk0wNXdZb3ZHUXY2SFNadjVaNlJySkF5ckxBWHc2S3huMGFseTd5?=
 =?utf-8?B?L2VlR3lFcDZtdzlla0NaeVhVM3JQUmdzelBqektaOFRQZHFSMmpQTkpHeHFP?=
 =?utf-8?B?TXNRajZxSXAzakd4cGdVKzd1MHFndGNjY0lSZVFqVTFneDZlNExQSW1QcU0v?=
 =?utf-8?B?Q0JBNmRTa3FreGZqVnRCS013TkxFVFhKZDBrTlFsMm5wZlY5RitxT296SWFL?=
 =?utf-8?B?cFNrKzlweTJRTWpqbnFSdENRRzlnRU84SEt6U1VhUjUrUFBZWUx0ZHpFNzhK?=
 =?utf-8?B?MThUbFE5TjVCR0J5TUVGN00rM0RRc0Z5WXM2ZXNNMnBpRmJwZDE3dTR1emZG?=
 =?utf-8?B?ais5WWJHSlh2blY5bXRxcHhOT3QremxjSkFXc2tIR1hxMWJwSERQeDRkSVQ0?=
 =?utf-8?B?ZU90T0pPdmRqSDkzWFZkY25kTE5uYVI1MDBmYnFnanFRKzBFN241Mkk1V1d1?=
 =?utf-8?B?VzJxTVJleWpQOW5YYzd4Rnh1K25xaDY3ZEdtKzVXL0hZMUg4SGQyYnV5RXJP?=
 =?utf-8?B?QWRwaDhmVnVwL1p5cFZ1YWVyaXg0M2Z5Zy9KbSt5WUczbDVMQlNUdGtGcHE3?=
 =?utf-8?B?bGNlMGcrd0dZSEpDdlhCUlVuenladmp6OVllN29NZXQzL2ErVnErZ3VYUk5q?=
 =?utf-8?B?NVdFVHdIVStBN3ZlWmRlMUlEdkNSQllRQ1F2YnduMndVc0dXc1AwNldMcGxK?=
 =?utf-8?B?MlFRYjRRSzVSQ0MwM21VRVdLK2F6ejZyU1NrbS9oVnM1MmF6N1dpZ1Z5NFlT?=
 =?utf-8?B?emdqdmZKVG9rSUhCTDJQRUlDdnVyczkxMDFYVEtwSGtST2kwMXBWVVhaRVZB?=
 =?utf-8?B?U0RkNHpVcFBxbElIY3prVk1CaUxDTEthcHhqdU8yWFVTdGROc1pHbFpuL0pm?=
 =?utf-8?B?emZPUC8vS1ZjaUhCOGp6ODd6NCsyMitpNHVaMnZ1aDlsQWpwZFlBcTNQTTNx?=
 =?utf-8?B?UnBRZWo5OVZZWVAyeHM0a2ZtY25PQk1Jd3FKaXVsMzFuREZrWWlSWlhMbk5i?=
 =?utf-8?B?Y1IrTUlqaTFLcHNBdlZjVTI1WGl5TGxnaWcvLzVQejA2UVg1UUlRRW5KRUVI?=
 =?utf-8?B?bVYzcXlhNG4vVHZqZXZyTktBeTNjT3hGWnpoa0lGYm90Y1ZxcEpjYndNRUYy?=
 =?utf-8?B?ajM5eEh4VnQyM3pTQTRFSWdkTjhFa3gvUG5neWhqUDR1eGpkQWliV0I3YjRK?=
 =?utf-8?B?QzFnd2RwdjUvRWlqR001UkJUVUlLNzRIWTJ2WHRjQ3JPRHJJSDNnQ1lRQTF6?=
 =?utf-8?Q?eZCywyEZWHU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR04MB9436.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(42112799006)(19092799006); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTlMOTJLenBzR012d1l0SEdzYUNuRlJPY2x2Y2d1cDV2czdGcTAvM2RNZVRS?=
 =?utf-8?B?YjcwM09mRGh5eGdTd3V2eEcrTlQ5dU55b001ZnVVTHJJUkJiZ2JqZ3B6MkY1?=
 =?utf-8?B?M0FzanNkVFJWMWZtTTRxenljaFZqTVNTUEttQVlITFkwMElMaFNFcU5Id2tU?=
 =?utf-8?B?WFIvTWNJblN1T2RzaUljSm1wOCt4aktmQnBqeU95aTkyVHZ6VXJIZERWSkNW?=
 =?utf-8?B?cVBTTG4zUkJ5VHpxYnh3OTBuQXJSbnVQamoxejF1c3RvWklRVWZ3V1RDUHlk?=
 =?utf-8?B?cExiUnFzTnp1a2lmbTdZaDQ0N3UyR2hSWU5KOWMrN2JveG9seVZtNlVwM0RB?=
 =?utf-8?B?eWdzVjZCdlF0TWxGcVJyWmU2QkVIczhVQlZtbTlSaGlzak5sSnRWVFF5TTZj?=
 =?utf-8?B?OXhFeVBEeXlYd2RxYS9rc0VmanBUV0UzdnFXMlBTQnBvRGRCcStTcHprWFdP?=
 =?utf-8?B?YzJyMmdCZUY0ZkR3dG9oMmIraFRFTERlTTRveDkwQ3ZDOEhXaDBoZEU5Mmlo?=
 =?utf-8?B?ZzFsVWNnWGF1RWZyT08wR2pDeVNMS0VCTktkSGE0V1plQkE4Q2JhVDNvQjJo?=
 =?utf-8?B?MEpLdXUxemR0bUkycFhza1dvWnBSa3phMW9TRmp1WTE3VEh5MmNFSDMrbi9F?=
 =?utf-8?B?eHBUSGtnTUZReUxtY1Zvc3Bad2ZCSDFORVg1MzRYUElTNXZnVEYrb3JzOVU4?=
 =?utf-8?B?bzRuVXdhQjd3TzBSMjBJU2dsUzJhd081cFJtQjhZUzRtWmtkN1JEYzkvdDlO?=
 =?utf-8?B?eHZxNFd5YTB0Y2pTWVpNbHpXa0kxTUhmTWVrYTBCZlVCQUZkNnhTVENUeWN4?=
 =?utf-8?B?SjIwbXpOaFk0Zkl2SnpsNDJ3NjRkK0h2UDF2WmtxRWdsTVYvdSsyRElLWitC?=
 =?utf-8?B?cEl4c2phZlNFSjFMWGY3akZVc2VaVWl2U1hzd1o0aHU1R1lJbFRVZEtQc2dZ?=
 =?utf-8?B?YW9vSWlzNVI0R2ZkNGJqNkQwVDZxSWtORjJ1Wk0xQUlETkNxTjJnWUdYcmxo?=
 =?utf-8?B?SEQ1M0tWU1BoYW45VWJnNTIzQkt3ajQ1OUM4Y0UvbE10MWtselMyUzlhWU1P?=
 =?utf-8?B?T29ubC9OSC9Zcnl4L3AwZUJPMlM2WU5VemtLT1BGMFJJZnlBbWlyYzl2UjNP?=
 =?utf-8?B?Y0lLSFh2RC93YnVIK25ZbC83VHdldFhwOGZjOUtOZ3BWUnJwdDdzWFVGNnFk?=
 =?utf-8?B?eXRRa3JYWnduSlJyb1BzTURNWkRrUEc2TmJ6eHp3UEJxMjJseDVWOWFTYjVD?=
 =?utf-8?B?cUR5WGZ0RFljYVEvemVOeWtlYUo2aHhqZEZiQlRBeEd3c1FrdjJneHY4ekQ2?=
 =?utf-8?B?endodW9LdGFDNXVVdjNmb0lPbWJMTVk3cnJmdVRVc2lGY2NoTGh2UWw0NTkw?=
 =?utf-8?B?SXRjYWc3UHdhKzE4YmpBS0tHQXM1RWR0cEhEQlNDbnVGTGdFZXhOQ1pLeVpm?=
 =?utf-8?B?YU9rWXJQeW11VWRZWk9oKzdJUlJBbUl6NVpEUHFkaDVITlptY1kyL0gweVhB?=
 =?utf-8?B?Z3JrcVoxdE1aVXhhRThNdGdWMWVCTWFndDJSOUJvK05uVGZvL2JkVEFtMTlJ?=
 =?utf-8?B?UXJVYmJQejJObVZEZXJBL2MrMjNpQnZ5bTg1c0lsOHpvTHRPYWZjTEs0R3BW?=
 =?utf-8?B?VDJHN2JENE1NSEpGcU9OQ21BbGRSL3gydXZBb09sYzVBcE5Pd1pzNFM2Z25I?=
 =?utf-8?B?MHVpbUUyaDZVUVJqUG1zUnpWRkVUVjltUjJBTm1EZFFHQ2puM0Z5Y054bWZ1?=
 =?utf-8?B?dVN3MnI2bHNPRGpQSXpVUmJuRkdpRytFNEtFOWZPTElMc0owakdlZFlLNDdv?=
 =?utf-8?B?NjJ6QTBCY081bTBTVUZORmdsTDJYbm9DTGJvS1A2SjU4OE9kZmFVODBEVlR4?=
 =?utf-8?B?T09STlkwQUhpcmZ4YmJKbHVkTjZPakw4eWZCcU8zWE1NNXlKUHNRTlU1ZnBV?=
 =?utf-8?B?NmFYbU1IWkN3QWtKTDFNNmpkYmJUSzJqWlVoRTYrZmJCV2QwQkVEOUdVNjFS?=
 =?utf-8?B?VVhWVnJ0MVc3SWw5dDFJSFNzVlFGeVN1V3cxVmVnMUJ3VVNyZ3VsUkFwNUhq?=
 =?utf-8?B?bEFTV3JyTm9SK1NkSlY0UFIxMTBuZ1Bvam9paUoreVRIL2ROaTFFUmhkb1Jp?=
 =?utf-8?Q?zwyOMqFIkzNFfk5jfSn5ZNfme?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35302860-5e69-41fc-a864-08ddf9a40645
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9436.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 06:48:23.5447 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WJLooqQL472D/IQvLKmhuTXBn4zV/5viS1RnbE/kuy1zWruSVHgYrpTQQOrZStME
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8885
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



On 9/20/2025 12:36 AM, Marek Vasut wrote:
> On 9/19/25 5:46 PM, Ye Li wrote:
>>
>>
>> 在 2025/9/19 20:20, Marek Vasut 写道:
>>> On 9/19/25 9:01 AM, Ye Li wrote:
>>>> From: Viorel Suman <viorel.suman@nxp.com>
>>>>
>>>> Align erase and write on erase block boundary in line
>>>> with how read was aligned in commit 622b5d35613.
>>> What is the issue that is being fixed here ?
>>>
>> Previous commit 622b5d35613 tried to fix issue that offset is not 
>> sector size aligned. But it only use the aligned offset read_offset 
>> for flash read, not use it for erase and write. So still unaligned 
>> offset send to spi_flash_erase and spi_flash_write.> What is the 
>> reproducer ?
>>>
>> If the address is neither page or sector aligned, we meet issue with 
>> flash update
> What exact command do I run to trigger the problem, what is the failing 
> result without this patch, what is the passing result with this patch ?
You can use "sf update" command to reproduce the issue.
Without the patch:
u-boot=> sf update 0x94000000 0x10 0x20
device 0 offset 0x10, size 0x20
SPI flash failed in erase step

With the patch:
u-boot=> sf update 0x94000000 0x10 0x20
device 0 offset 0x10, size 0x20
32 bytes written, 0 bytes skipped in 0.20s, speed 1424 B/s

Best regards,
Ye Li
