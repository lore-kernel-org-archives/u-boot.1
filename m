Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0AD3C02194
	for <u-boot@archiver.kernel.org>; Thu,  6 Feb 2025 13:18:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B37380ADE;
	Thu,  6 Feb 2025 14:18:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="B2oCjQMq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EEEC880AE1; Thu,  6 Feb 2025 14:18:56 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170110001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E45FC809A5
 for <u-boot@lists.denx.de>; Thu,  6 Feb 2025 14:18:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KmzzF5KFc75Gu0RnLoY/fh3jEoI1ZrzhWvnQE57vTW+N8Jyi05LpBNEqk5jsGt6snMJzqqoVJgTYM620T9CbNQrH+BuObPk1yLKGdb+8vfLmPCaUhf12q4pr6ugee0MaxMI+wn+uICZ9l+4kNtZf7m2rXv2drfA7hNMDE1lq+jBjhSdhXidpd8pJlUAD42KSL2vqpt9PstQ8HjCC4932hT40C8hsGdTCeVgkJ1jZiUI4+Uy/SPVawujAJtpSu6HfPbG9Ls31cxYkFQzK8dZQWMF/eTMuKyvEgrVmmZQ3Lz226351n3JK8EcR2PGv2l468Qjuu91CRl0TEFQkAy1wjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AzPebTUrvrIiFGLZKlP5OU5rV7DzMmJts5ruqciiXoA=;
 b=TalIgNrsvwCuOeqKcxVGhmw40vYJ48KXKX5lVhr7iEhNVbfm3PREwVIneepQWHIxypdVzEwWvml2wFZj7KtOGo6ozqUKZBppgz5wgrivnXyi6niOIyralu5RKDStgqDvogwRtPx7iF8sdW40Xg8AfCfCo1ZuzMmNz1gQqG4EJ7IbOewCl/xONs6yPi6OdUM8a9BsF/b7Vhl5N/cNDxSw46zf40wOANOGrGrd74XH6LT9Pgo/SemG8KzCB8zpEfAicMgKJpJ+FwEWmEvkB/MkUDRTtYKRPgF5XL7GDNsmWsdhyHKh3VC5gJFOKHgU3WTXWIZtaVZK6okuz6zBusZDZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AzPebTUrvrIiFGLZKlP5OU5rV7DzMmJts5ruqciiXoA=;
 b=B2oCjQMq5KdIczg1aBA4pdb6SuWYVwdUNCvV/tWbodEraUJvo+/A+zDKrfJsJ9eAwPbUXPnit1i2DNvfjmT/JU4/0deUy38y9GWb38CfWt0HNAVR0Uxw9DhMvgBmlnb3E/8mj9dyUqEmr5ickbNnaVJ4huNQgOb9zTPqaKXOIkI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by GV1PR04MB9515.eurprd04.prod.outlook.com (2603:10a6:150:24::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Thu, 6 Feb
 2025 13:18:51 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%3]) with mapi id 15.20.8398.021; Thu, 6 Feb 2025
 13:18:51 +0000
Message-ID: <031dd02e-5222-45c5-b478-9e65d27ef73f@cherry.de>
Date: Thu, 6 Feb 2025 14:18:49 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] rockchip: io-domain: Add
 CONFIG_SPL_ROCKCHIP_IODOMAIN
To: Justin Klaassen <justin@tidylabs.net>, u-boot@lists.denx.de
Cc: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
 Raymond Mao <raymond.mao@linaro.org>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, Tien Fong Chee <tien.fong.chee@intel.com>,
 Tom Rini <trini@konsulko.com>, Wan Yee Lau <wan.yee.lau@intel.com>
References: <20250205171634.826560-1-justin@tidylabs.net>
 <20250205171634.826560-3-justin@tidylabs.net>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250205171634.826560-3-justin@tidylabs.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0123.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::21) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|GV1PR04MB9515:EE_
X-MS-Office365-Filtering-Correlation-Id: cadfaa13-c0eb-4021-71ce-08dd46b0cc27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|10070799003|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RFZSbVhLa1BXYXVUek1JcUg5cFk4L3lEMitqV0d6RGI0U1JhS3ZjNG1OMWlK?=
 =?utf-8?B?bGgxRTRqZm9LV3JkaVJ4UnFURG15bmF6WFMwWmhLQkhUQm5hVlA5bC8xY2V5?=
 =?utf-8?B?RW9JY2dkY3hLcUw3cDRYZnlmWEhtSVdWbjE1N3NnSDhXVjhreVFjcWJMa2FF?=
 =?utf-8?B?OExZQXE2bDMzaVBsTEJCOG5jZXFDQks4aGJhVitvQXhJSWpPWC9YdUF1R3ln?=
 =?utf-8?B?QmR6WWtxa0JMUEEvMFV3a050SlUwLzkyL0QrV0RUTEpIdENjK3FkTFhxcmpW?=
 =?utf-8?B?aVdDQVozQkZidDhEUlBwblBwVTB2dFJ1VnRYY1Y1YWhNUksxeGEzOS94cTVt?=
 =?utf-8?B?WlpEYUx4aU8vUjQ4SnM0b1pWdnpmdW5ONDBHMHQxWUhXc2pkUmFBbm1vb2Rr?=
 =?utf-8?B?bldVYVhpblpiOGRjNmZuM2JlRDRxSFlqSDlnMi9GMVE5ZTBpemgwRll3YVZX?=
 =?utf-8?B?YWg2ZSt0N1NsY21EUGp4cER5QjVyRWVZalJRWEt6T3lFMk9LTFFCT0MraFc5?=
 =?utf-8?B?U214WlA5MmRkT3RnSDFsdFVhT2N3Yjg3YXErQVJQNS90ZHJMRUNNaTkwQVBl?=
 =?utf-8?B?cjZaRUYzZXVVWk92Y2NUQkg4b1RFa2FLWlZZRS9QdDlzSHFTR1lpa2pVbndq?=
 =?utf-8?B?SklweVJVMHlSdHdJanFvUTFaMUZDOFVrK0JUeDMxTHpCYyttZGVHeXhnL0U2?=
 =?utf-8?B?c29ET1ZHTXVOWFVpMXpNZjYxV3lWSkhCV0IzUjdNVzZGU3dDTDBRVklLQUpL?=
 =?utf-8?B?d2kvNW1jTDBkUWlMNERCSmpidDVkM1Q5NFpYU3Fic0hWRTJWOGFVaEZPQXJy?=
 =?utf-8?B?TWRteFNTUHBtMUthUUlNSXRhOHJIaHF4NXFIYlVhbGRuZ3VNOVQ4OXNpamhi?=
 =?utf-8?B?ekphdy9EVStER3ZkQjhKV29sWEtrZTUra1pwZmFxRFhtQjRLZkZoL2xXbUhM?=
 =?utf-8?B?ZEJaeDJPMkRVMkFYbDg2T0xvL2dTVmVkQm5NVFlYRjhyaC9BeE54eDJuL25s?=
 =?utf-8?B?K1hnZ3AvenFIL0dhbDRUNlRwWWlCaHVJNDNpMFVTNkc0MjVGRVFwbUU5Ymk2?=
 =?utf-8?B?R1R4eUNrdEhnOEJ0U2tYU280akdlcEY0SkpqR2VUYzNnQ0pXM05YSkVUMFFC?=
 =?utf-8?B?WGFlRUhvdktCdlhQNE93c24vVGh3cGJFUGZtM2RDaW50NzcxMVNvelk5bGlP?=
 =?utf-8?B?RWFYQ29mY3JWNEpoRlR3YmhXM0NkWm5jL1F3dWhNMlJ5Y3U1ZGx1T0RZWklS?=
 =?utf-8?B?NE9JeHhNVytHVlZtZUhUSTMvSEk5NW5ZbXl3RUNuYVBvWEU0VThPRWorRllJ?=
 =?utf-8?B?ajk0TStiK1ZXbXErZk5hc3lyaFB5TWNYc3NIVllGbE1zb0lVelNjeTBZRUhW?=
 =?utf-8?B?OUxYZkhQMGMxOWdmL25pampiM3dmVUJjUXdQWTQrazNhS1NFRXBKRUdDYXpt?=
 =?utf-8?B?QzdEbjdiZVVuVkIxdEFNZDF3d0NWM1owSlFESGJlMFMwbFQ4WUZ5UHFHamhZ?=
 =?utf-8?B?bE9JSW5vclprZERWeGxYUFFjOWZBZWRZektXYTdobkwzcmNYTENnTU5RT3dq?=
 =?utf-8?B?blJxSWpvTTNyeWRhZHJJTURjWHpCZFFhWDNMdys5a01aL0xTeS8yQkpZTEVQ?=
 =?utf-8?B?T2hza29rYmZqU1FKaFp0TXpRSTFDQThkTWtrNTVqYkVEMDE5U3I4WGlwN1VZ?=
 =?utf-8?B?WWN3Yk1JSWRUaFVDRVVZb2hyby85ZytrQzdRUFNuSEZ2ZTU5RWVXSS9GN2Nl?=
 =?utf-8?B?QUZzK01PZ1Z3ZlBLaGI3S0pkR3NWMGwvZXJvZ3l0UWZ3eGkzSHIwME5Genp2?=
 =?utf-8?B?Wks1Rm41Y0Nzc0ZNT2FkcHNZRCtlZCtDcFNGS2NUZzY5YXUyUHNqMTUxZkND?=
 =?utf-8?Q?LS+0AQo0oYqIi?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(10070799003)(1800799024)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amVqV0RtYWpsV29vL1o3YkdLNk1nZXU0Z1VLT0N5QzlXci9LU0lONHJqaFdk?=
 =?utf-8?B?aHQrV1NlMWVNVEZuRjhSbyt0cVhWYmFkcnFQbVJwWXNQSjNkMHFQT3NRSFlu?=
 =?utf-8?B?Wk5hSGJ1Q29FOUxBUlpIWjAwRWFDdWYrRDl4SnpzVUl0bXNmTW9memIySkFl?=
 =?utf-8?B?WlFjdjFiZnNaWjI5Y2tnYnRTV01TR2lVMjRtaFhUWU5qRTk2ODZzSUlLTGJ2?=
 =?utf-8?B?TnBXSTBQaHkydytvdnp4QTJna2ZOMEI4QTIraVhRVHo1aHNxVjFzU0lWbTVi?=
 =?utf-8?B?N2NyT1dQYTR0NmIxQ3lSOXVXaXRaUzJUQjBQK2Zib1NNU2MyclNvSC9LV1g1?=
 =?utf-8?B?VVJBL2tva0w3WDRDQmUxYSs3YTljTU5UN05pK3E2WjBqbzNDdU5sN3NJaEFK?=
 =?utf-8?B?ZVR5d2h6WW43Y1Y0UUFNTm1pWHN4cTVrYWh4Zm5BMklaQlRZSDQwbStWNHRC?=
 =?utf-8?B?UDJDckxXR25iUktZa0lIS0VuK0FsYktpd2NETGFaWitLUWJ1TS9kcVZ2YnFK?=
 =?utf-8?B?VDEwakdNUmlGSWw5dUU4eFRnTS85TzNVRTYrY0ZmL05MNnJYYmxIWHpaUFda?=
 =?utf-8?B?M2hGQWRpcHpDSmg3d2REczhvLzJGS0FGbEM1Sy8vSm9vTU10T2duTjhrZW9Z?=
 =?utf-8?B?YnV6YTMwaEQ3STVsTndIcDE4alJWU2RuQ2dFc1NOWUs2NkpPWktuUGk2eVk5?=
 =?utf-8?B?cnJtRk93bDZlRDV1NzZYc1cvMUU4a256QUtRUUFLczRHa1FxWDVIMmpqeVh1?=
 =?utf-8?B?WTZEQVJsYUR3TkdRRWdTM25rZzFmMlpkQTBBTXRRYy8rYXRLdEdVNlVxenBE?=
 =?utf-8?B?dVVtZGxoNGh1Z21GNjA2dG5tYlRpVDhUQThVM0F4R212SFRDUEliVUFxQVJm?=
 =?utf-8?B?VGhuUGkzTUhYSGhTZFdrQ0lybklpakZ1K2pyS3BYNHprZmdnMDExZVk3aXU4?=
 =?utf-8?B?NWR4K0U5QWt5RXlDOXB0Zk5lNmRNSit6elNTcGVza2Zkbm8wUGkwMmZ3OGsx?=
 =?utf-8?B?bDA4cHZ6b05PUkprT3FMTTRRdlNKVmM2MlNSWi9sYi9NL3VxK2tvbHpqSk8v?=
 =?utf-8?B?UVR2NWQyaWo2Zk0vdmRsV3pFOGEvcGRGK2NDQzFSQ0o5a3N6b1RpaHFwcm9U?=
 =?utf-8?B?MCt2VW9odGlKUm9tODh0eHVNSzErOFhPcVBrcFZsNHQzenM2RTY3d0FLMmVj?=
 =?utf-8?B?TktRb2c4WklUYlBtYnduTDlCeWVtTVJ4dUg4SEhER2ptOThZWnpvVDQ5N0RY?=
 =?utf-8?B?aTBuRkhZeWt3a2tpZU5pN1FMZFJaVzQrei9xUGhGU2Z6Q0dEdEptSjl5NXVC?=
 =?utf-8?B?dUUwRzV0U21LRkQrWm40MzVTa09vWjQza1M5Q3o0NVFFbXNSazBEbWtqaU1R?=
 =?utf-8?B?VlIzNjFJNmFUUlh3dVJucG0weWtNYzFXYUxoMDRXRm42UEY3TFkvOTFwVUF0?=
 =?utf-8?B?MkZRUXFuc3lWQnBMbGZycmc5MVlhYStqYmNOY2JhZzZBSUhVckJtZXdFWmpy?=
 =?utf-8?B?TDNIV0tjRkZ1N1c0NnJUMHNlaENSRU1OaHpkdkJkZUFlRThxdTRnbWdMZVNy?=
 =?utf-8?B?SFR3alFoVEJ3K2RvTGphVHVNMkNwSnFpUnBhNmFhd0dVT1lQVmJWN1JDUmpq?=
 =?utf-8?B?NUhpQk5DeUVRQ0c1a0kxU0dqWFJuZFVueGxsZGUwUDd5c3dYNWdCU3NNcFVx?=
 =?utf-8?B?a3htYzJqTWxFZUtkR2RYd3JTejQ5WlJVeWk1TG1nWVNKZ2xOdUM2V2xCdkdq?=
 =?utf-8?B?NVpvQ2Yyd2dsSXVTUnVlT1pXQ1plWFVjMk1UMHc5bEVZeDdjMkNpODREUGhw?=
 =?utf-8?B?dDBBYTQ0VENCSHI3VmovUG00MkpVaWJNRXRxUlBGMDE5VTdCcStlYVp0dUNB?=
 =?utf-8?B?K211Y1A0b0wrdy9hWEk3M21PREtManFlY1gwNld0Zzh6ZHdFNGk3bjJWb0Fi?=
 =?utf-8?B?dE9MdWpJdzNQaElJQ2xPcmtQRktRbmUwWWkraDVlMkFEWnpCczB1UXVKMmxX?=
 =?utf-8?B?QVM0anBMTEFzRFlib2N5L01veU1DS2RQZHhMRThoZXhWSnRScStFdlRNamJO?=
 =?utf-8?B?enFTa2E3RzlJcXo0YzV4ZXIvbFF2eE0rb2tYV2JLSmVSejdPemFiMnpUYWdn?=
 =?utf-8?B?NmZrem9oYWpPZ2JvK1cySmJzVTJVZ2U5L01mSWc1Nkxwc0tKV0J6KzZnRitP?=
 =?utf-8?Q?Oyv0bz5n80gtjyFQxsEra/Q=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: cadfaa13-c0eb-4021-71ce-08dd46b0cc27
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 13:18:51.2115 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cafeutZW3an8bxGWNvgs6vCnaSQnLKI9mwzxbQ1numirEEHM9v0bk698W1SJXFLG1bWfVtIBMh3c0OHj+/kk2awlpVKfClRBgPgCEgFe2AY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9515
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

Hi Justin,

On 2/5/25 6:16 PM, Justin Klaassen wrote:
> Allows use of the Rockchip IO-domain driver in SPL to configure
> the GPIO to match the voltage supplied by specific regulators
> (e.g. "vcc_sdio").
> 
> Signed-off-by: Justin Klaassen <justin@tidylabs.net>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
