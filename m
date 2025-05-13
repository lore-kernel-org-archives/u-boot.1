Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0BF0C3ABC9
	for <u-boot@archiver.kernel.org>; Tue, 13 May 2025 08:01:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C594E8091A;
	Tue, 13 May 2025 10:01:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="aw2teVOn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C3B180C83; Tue, 13 May 2025 10:01:52 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B5C5800C1
 for <u-boot@lists.denx.de>; Tue, 13 May 2025 10:01:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=igLYZip/+gfzU1xu6WS+pQmyMMlJgja5kDhvYcgS5we9Hi02N3qMqP2F2NsE1J71l2nFv/+DF2guOAbKaIybx4ZJrIAtwpbpo+PCK4qR8A5QfCP+XoUOICWV0c0MhGXieAUOWJOIHdhjDcWh5nd1F0S2mhr2blhgcxU+xPahem3powQusNVLrrY+4USEB9v3PHI7q1H75xqKURKClq+hQyXN4yQqkFhCCwzBe89BTqE2tr9NeGE6gOH6kvXmGnZXEt/RLQ3ZpqKL16h29wwWkJ/lPOrOXNCGJO6Wxrqay0uRcbmq/pRG0qnrv4FlqPIwVIpU8h2m2/tXunVf6PQsQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/kT8yc1OidrtUuaxMdUvtE2dcSdp51gj2/UIKqLfvuc=;
 b=FEkLwV+5OYto/kpBOUKortDJw9gAUf/6o/9qJzM4fsZWKOfNVXGjiP2nfW0FXDXhYV8XXLc+O06Bnp0Ultnlus9FwUyU2jLWmdgzpDZ5YCbMo7PirEKs6MokLdCNdmEwyGZvphMBF0KwToe/EgMK8hTlY9HLDHNRP8j8gIZpLOSg5UGyByLp4fIvnfwSTE3cqDOJpyKRkIrU5vaurcT3B1DFNCWJmsnvSt/k9Fub9vdecpkFtQCA/uhBidbzl1ToWiSga19V34vrAloyJle8vwsogHz/k1/9lnmOvDw5/9dMqGk7yencEQSi9pzWy4DHbLh2I65cTHBjnaq2Kt1MLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/kT8yc1OidrtUuaxMdUvtE2dcSdp51gj2/UIKqLfvuc=;
 b=aw2teVOn/zsN6ZIim/Ui9Iz3UPB8erc+TrYMp/DCdQhYUIVOIQJsQKY7dEmKEI2Xzx47z6WzU+z8faBAmeb6MUSxVhfVRnG5Rs0GAUDP9ilkhhqvW7q6dTOTuLCFuD9wFzjZs6gG5J1z9o5/E9V5+WLEW/tIYoaDE/BwCw0/T9M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by GV1PR04MB10426.eurprd04.prod.outlook.com (2603:10a6:150:1cc::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Tue, 13 May
 2025 08:01:45 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%4]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 08:01:45 +0000
Message-ID: <5a277fda-aa2b-40bb-a4a9-29234131a247@cherry.de>
Date: Tue, 13 May 2025 10:01:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: pytest: Use globing for test files
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
References: <20250512215424.2362166-1-trini@konsulko.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250512215424.2362166-1-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0042.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::13) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|GV1PR04MB10426:EE_
X-MS-Office365-Filtering-Correlation-Id: 49df593b-29a0-4f3a-0fb0-08dd91f46756
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T3RiWWduQndMTUhDSEtEMWtFRGhONkFYcXdDZElYLzErMDJjeHFabTZXNHRV?=
 =?utf-8?B?MUZsSlgwUEdaUlBVaTlGaTViNmQvaUVEc0g0QUhOdkFyM0cyUlAwMWhTQzVT?=
 =?utf-8?B?NjRZWDB4K3I2UHFoRXRzOGRBM1g2cFVydi8wOHNMU0pVNW1UUGVYMlhlNVJH?=
 =?utf-8?B?WTF0ZjBRWktUUGwvVXBxNE1Vb1R3KyswYlpKa0RMMWJ4Z1RVVTZRaUJPSkJP?=
 =?utf-8?B?eUZUclBjVGdMUkk5dGdSeTZLWE5ZdEM0TWJ2d2N6ZHR0Z0VMancwRVp3L3hv?=
 =?utf-8?B?cndyU3NHWHFHcnJXTUZoNGVxS3ZvMXlPaENLbkJTbUpxYU9JcWltS1BkTTlZ?=
 =?utf-8?B?eTRwcVJDWmEzMzJmMHRyU1pmZG9pR0JmWFZ0ZEprMUtYc1lJYnlsTytncmFh?=
 =?utf-8?B?cXpkT2ZUS1Y2bXhDTnJNQ2x2eGphOSsvTVVSMk5MWXZxUjY1YXNYc05TSlNV?=
 =?utf-8?B?bFlqZnpYQWJqdnFsbk5EazY1Rzg0QkdCeExSOHhYSHV3S1Q5eVdMeDMxcmsy?=
 =?utf-8?B?ajEzUG9IZGcyM2tNMUVYcXlaaHFMdXE5dUVNNXhmbG5WQnpnQzhiWVVIWHAz?=
 =?utf-8?B?VEQzT0gyNTNURU1yRXlkREZPbnB2UWRVQU03YXdoRk5aL3hGZDhKRHlOZ0p4?=
 =?utf-8?B?dCszenBqMm53aVE3VlIzcUUyRjZmdW8rOGRiT2MrdHRzdVZmWURONFVsM1Uz?=
 =?utf-8?B?M0tuemRVNyt4aktaQVE2TEZIWFpsOTc2cXZ6Szc1K1dlN3p1OVpVV3YwaTRl?=
 =?utf-8?B?dXU5KzQyK3hyRXdqSkFJY3UzWk1rZHN1aGQwdjhIeTQ1aGZOR2F2WnhkdW1v?=
 =?utf-8?B?Q1hsSFZwOTlzL1RqdnZSVlpaN2YxQU9ydDJoVmVOK1JrLzBNSWNrTHVEVE9P?=
 =?utf-8?B?Vi9FVGJLTUFXNW5TRTErc0Z2cXhzbmc3RkY1V2dKSzFxdDN5MTk2bFlEUTNS?=
 =?utf-8?B?R3k4ZFhGKzdpK0NITWdQT0NBZ09uYVNyYWw5bGsxanRCWk81Mm9ZZURSSjc0?=
 =?utf-8?B?aWRlTHNHM0RXQkNPbHhld25LVlgyaDZkQWtYRHJlcnUwbFF0ekpYQjltbDZs?=
 =?utf-8?B?ZUo0cWo4dCtMU21YcVdhU3lCK0xWZnJoZnBoYk9XYTBVZ3c4QzhIUmxQOG8r?=
 =?utf-8?B?OUZGM0R4VTRMNmN6cmNEUkh5UW9wM01YZTR6ZnFhRVNqM01XTGlTOVFZa1Fz?=
 =?utf-8?B?Snhob2M1bGN6WEhEc1hIWnYzMyszVENzTC9LLzl3eVRYL3EvNUF4aGtmZEMz?=
 =?utf-8?B?cGhYZUwwWmdSaitLK3diSW9jSHZmb0dXTFYvUEN1eGhKSitUTW1MaUFKOVJa?=
 =?utf-8?B?RmVTUTFOUGZHQTlGM1MxbGdvei9IODMwakk1UEhUQlNmZTFyM2RwM0FwN3p2?=
 =?utf-8?B?aCt5dWN1aUlOQmxxNzk4VG1SREVNQlkwS2lhaUQ1S1ZQNlFpQzNZRklxSW1i?=
 =?utf-8?B?Y0xBNVY5L01FN2dleGx5T1Q1b25rMVVuM0k4VEg4ZmRIZDBjdzAzTlhKNWtX?=
 =?utf-8?B?N2tLODhEOU1jc2FabERIVnFiRndHWGNQRHEvemNiQTR5TmVQbG9zQ05SUURI?=
 =?utf-8?B?NFljc3VaQ04zMzhxQTlFQjNKYUZGYmRqS3N2eEpOS3llL090Zlc0aXhsTnNt?=
 =?utf-8?B?aENyM0p3SWRJNFBka1ovN1JkVmdua1IyN29DMlZydkd3b3dUTUpFM2JkSDln?=
 =?utf-8?B?VE5RTCtRZTlubzdKRnA0dlhoV1dRQ1Z1dFdYK3pPTlhhcExJQmM4RThFclRm?=
 =?utf-8?B?cGtuRWR6d0hVSUlRSkxKWEhxZU5WMmIvTU1TQ2dXNXVjMC83dzhlNmEvdDdw?=
 =?utf-8?B?dDZvdW1ZVmVjcWk5d3Bjd2NnUkFHaWJ2d1NCUHJOOXJseW1iaEVRekF3TmRQ?=
 =?utf-8?B?dUxnTVJIc3pzcElDVmJ6MlN5MnAvYUd1cHBBTkRJd0JpaUFZYU95RVpOZUF2?=
 =?utf-8?Q?1ALRh1/1SiE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXdsZmU5M2FkWlYwTFVFTEtLZGJreU1wdHQ4WFpWRnRCZVR2R2k1bjM3b2dv?=
 =?utf-8?B?THhlOVRKMzVKN2RRWTNPYlBOQ1VJdDRHNG9DRit1Z0c3YzI5OWVFam5DaG9p?=
 =?utf-8?B?My9WZTJ1V1lHOTM3c0RGQ2thWGM2TW1oSklnM3NXUU95ajJNVlAxbkdpc2NX?=
 =?utf-8?B?RHA2bmVqODgzUi85aUdvdk9FV1pIRkNpRDJBV21rMGZvcjl6OVBBOUR3eHhz?=
 =?utf-8?B?eW5waUcwN0JOT3NQdTBCdjJ2amJtNjZpNS94NkVEM0JHcyt4SGVLTU5JYnUy?=
 =?utf-8?B?NHdLaCs1RUJJNjN4dEJ0UUM3dk5tblY0dG5kbHc0cktSMkFYU2FZM3pGa2lV?=
 =?utf-8?B?NE9GbjhQbTlYM3VDM0QvVEVsek5Bdk40R0VBV2pzbFRrZWRpcnB3VnpmK0s1?=
 =?utf-8?B?SjkvT0ZzRGs4bVZxVExCRy95YjZoaXlxMWZzT1VDcnBvem41cXBIWVd4RlhI?=
 =?utf-8?B?LzBTU0d3bTF1N3NGRHF6QmsxeVhHczFjaUJJMXVVMDFuYlI5UUJDVnVPZnNS?=
 =?utf-8?B?UVkzeFBtVHE2RU1acDhZMHRCNk9jaFdCd050aTR5M0pYOXRVVmxaMDcvbkkr?=
 =?utf-8?B?Y2JSVGJEOEZubkttZkljZ0Y5di94RHJHWmxtRW1iMzJ0L2ErSjhpaXNHT3g0?=
 =?utf-8?B?Z0c5YXlBalRRMGNvWjJkVXdHNHdRb0tqdWhmT3loQWJkUEoxUnhITG5qQ2Qv?=
 =?utf-8?B?dGJIeWNLM2t5ZWNMRXFCdDlUSmpvek1HNEU3cS9DUTAzaE9yOTA3UGZHMkN1?=
 =?utf-8?B?TnZHSjRKZnVsMzAyZkZ5TW5iL1BnRlJ2LzlMOUZmaEtaV3N0WnVCQ2ZUdGt4?=
 =?utf-8?B?R1R5dWZrKzZ0czQ0VWRyU1JnTXhsdklqbkNTYWJLdENqVGdyUkpkMG9sem5Y?=
 =?utf-8?B?Ny9TcGhZODhjOU0yVTNNYXNEMUptWkdQazZma2h4aE12QWFLalhOcVpGT0xJ?=
 =?utf-8?B?SThlamR3RE9aT1gxQkEzaWNkWU90WGFkNGVoTDlUVGZFNEZDd3EwK0VpVm9x?=
 =?utf-8?B?ZHVxUWFUeGRxbkRSaWdVd1ZNUUdOaUVsOG5qQkxkT21sVlpMNXo0TEpweHBk?=
 =?utf-8?B?cnA2ZmVXZ01DalpBMlBKUS9LZUdsRlNQMHBpVkowSnU4UUt6K1NmcHg2RlZX?=
 =?utf-8?B?MnhMeG1uaitRakhHNkxjWFZoNTBLZUZEeisyd1F4ZDh0TUVIaGJHVmVxRlkz?=
 =?utf-8?B?cnhJVnVsNXdXWXNTTE11VjFUc1VWY3hJZU9WU0VJSzJDa1lzeEIrR0pwZDV5?=
 =?utf-8?B?QjZ3ZkZUdW5HTi9TUGs4bm91bkk3S1N4TEw0VVk2dFBrY2hoYnFjdXFYdFZM?=
 =?utf-8?B?OGJCSElVWVRjNUtnTVdDWUJTWXhId2YxWlU0TEROMU1NNlJLbnA2YlNjd0tM?=
 =?utf-8?B?SXhjdmZRa1BIdHQ3MnNVR3ZITVllL0NNVHUvSjZmWmpkMXJneitudElvdHJI?=
 =?utf-8?B?RXU5NDVwck1PMnF6dVhIT0JpZmZMekxIZWMrTFZIRGZsNzJjTGYya1VOa2t5?=
 =?utf-8?B?cS9wNTRMWU5BYzk1eWtsVmdJNi9PYVBnaDN2V1dzZWhXZ210d0YwblZ0c2NH?=
 =?utf-8?B?NURlOVN2c2dRSC85SHA1RCtNenZIczNaMlhqc1JoZzVmUWRFS1l2OW5UMXl0?=
 =?utf-8?B?VTdZQXBYdHJQRjJzRzZMNkcxSmZYUXIvRFpqWkxHcklCNWxNc3djcVNZMzZC?=
 =?utf-8?B?ZWRwME96dGpBOHlPOXcyTzVYTi9CK1VTejNua2d6N1BDUkJiaWtkM3dJZTU2?=
 =?utf-8?B?VE5IUm5TWjFZaXVyVW82dnF0bHdIZERDekZ2Ym1NclI3enF2bGErZHpDMGZ6?=
 =?utf-8?B?Z3hsTTdOVTRzdW1KcTErcGtFL2lmME5uV3Via3drN0FpcDV1OUlnV2RnM3ZK?=
 =?utf-8?B?cHd2VFBVTzdydVlqMWNaeFdWNTNWMGJTQlUvdjcwempPRXlYZlQyTEFhYnM4?=
 =?utf-8?B?S25oS0FtUVY4Q292a1BmL0hZWlhtTXg2dHFteTJrMEJYQmlwM042cTAxc1g5?=
 =?utf-8?B?eFRIamM3WE12U0pFT3dicWtCZi9SVHpoSFhGNXFqT2dhWm1CZEpEUFZxN3gv?=
 =?utf-8?B?ZHhBRGZteU5hOFJWdlR5VmYybWZ0aW1yVjJBOW82em83T1N1ZWdYaEQvQXRa?=
 =?utf-8?B?K1RESGZYTmpkclBHb3B1YjF5bTgvY1AyVHgxZUJyTE9hTzVTall6R2NSak5a?=
 =?utf-8?B?S2c9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 49df593b-29a0-4f3a-0fb0-08dd91f46756
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 08:01:44.9824 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A+UfxHLaVefDmCoYYkGM51ZqDinxyAHZfDHs3+tz+59vxsLflCasKVV8844iUBwq/C/9mMEkaZnnmvDE85F+JLx7FTowHT0cspx2XtCEN0M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10426
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

Hi Tom,

On 5/12/25 11:54 PM, Tom Rini wrote:
> After the original series was merged, Quentin noted that we could handle
> adding additional tests more easily by using the glob feature. Do so.
> 
> Suggested-by: Quentin Schulz <quentin.schulz@cherry.de>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
