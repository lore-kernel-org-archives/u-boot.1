Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65C4BC36008
	for <u-boot@archiver.kernel.org>; Wed, 26 Mar 2025 06:42:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 863CC808B6;
	Wed, 26 Mar 2025 07:42:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="Ht7SSMEK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 998AE809D0; Wed, 26 Mar 2025 07:42:39 +0100 (CET)
Received: from AS8PR03CU001.outbound.protection.outlook.com
 (mail-westeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E4CE8083E
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 07:42:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OCkj5g2dASa3iK6XQ3czUsVhk5eRY0ZXUE9fkHaFb+rCTjwEZ9GbW9P7VMTZE9NWQbkznnoQUoGeZU1uSadcpc9iePHmD4A8aZitic7H2Zrvz2VSj+m1o6gE88v/BJ1o+6pn7SwaUunNS6ZCUojDEmpcOtvkuPhMziDy1xFINjThoS/bg5jeiFaiMYEb4azHvYLThdwY5hxRiMyr8g2jjUhvZ4lRHaTE9qLR8QV5o7GGGECQ8QVmf/9Kp2xSl9i3k2Y+W4VfJGmUiIZp2zT76wJo4XzTvFoAGSWmlTvS0VnyrUjbijEcLgyWK3QMxjjVUc+tpg/sDvfERYhXiYGijQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vAvj7tHPd5HgavKFY7TqbxWoTZ9o55pUbsE9D1rN3ls=;
 b=rmjpFMK8Qy6uZWwTeD9WG348f+aJdr/k1ABBu/9/4Qv/h7km63bWcG1zgGJcv6uZeM5qC2SCp29Onkqjqoo6wKbT75Itz4kKSSM0G5Q9L6nlcSXoOlSXXGvQQ7lmdplDZBOFrk45lGsGQDhLZKr3rK/n8QgbwLWP7ux7rb/ppP89jCH5UFcP/GqqE5Fj9HgOxbDHJmh6R6EytoCXNUGYwDiya6pcq3AP4znbdSNsOrA9BIQAYFYLEPNgsDLVxP99DTHdFUFO6zwM01RCdBnetXarTbEia6lK8BqckOzlVXg18Eb8lRVKe+uqyFbhqF1vw1cv3BPapIMzlRxqK/faTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vAvj7tHPd5HgavKFY7TqbxWoTZ9o55pUbsE9D1rN3ls=;
 b=Ht7SSMEK9rkcIvvH6eUKpAS+Fzl6gigH6awWzc/w5pa98ebr+5XW5Gkshq6lkSShzfoBiB4+9sOUkzSiRVNP6bZAgW+IpOXUlcFnR6Jh7UTnai8tBq2ql3Pp0hTErlzamTH4g9B+ZEr3RyS1VylyRV+UfLfCv6ARaEXIs/SzmzYihJhMC3fc4bpSkLvNrvRRbnVKLOoZye0TLXvjFv+NZ8q/x6WBDbBugLIONUN6c+f762IYPy1ePpuF4CZGs4GsJyKeDF4XRTw/A6ultEAyCGV78L7DjV+DJqAkKsPAk9c1hz1RV4VKSYz8OQYd+C7t51m7GwuH7B1749RT/eI+BA==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU2PR04MB8886.eurprd04.prod.outlook.com (2603:10a6:10:2e1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Wed, 26 Mar
 2025 06:42:35 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8534.040; Wed, 26 Mar 2025
 06:42:35 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Marek Vasut <marex@denx.de>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Simon
 Glass <sjg@chromium.org>, Stefano Babic <sbabic@denx.de>, Fabio Estevam
 <festevam@gmail.com>, dl-uboot-imx <uboot-imx@nxp.com>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>,
 =?utf-8?B?TG90aGFyIFdhw59tYW5u?= <LW@karo-electronics.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Ranjani Vaidyanathan
 <ranjani.vaidyanathan@nxp.com>, Ye Li <ye.li@nxp.com>
Subject: RE: [PATCH v8 02/19] pinctrl: nxp: add a pin controller driver based
 on SCMI pin control protocol
Thread-Topic: [PATCH v8 02/19] pinctrl: nxp: add a pin controller driver based
 on SCMI pin control protocol
Thread-Index: AQHbmjEaKrmczG8t6k6faxPwia7E+7N+Uy8AgAUx/ACAASH9AIAABs+QgAAUH4CAAD2oMA==
Date: Wed, 26 Mar 2025 06:42:34 +0000
Message-ID: <PAXPR04MB8459F46041C7EFF7191F8EFD88A62@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20250321-imx95-v1-0-f2c8ba815f89@oss.nxp.com>
 <20250321-imx95-v1-2-f2c8ba815f89@oss.nxp.com>
 <a180b7e6-6978-4814-97ff-05e34223938f@denx.de>
 <20250325080614.GC27303@nxa18884-linux>
 <a84f63fb-61c2-4f0e-89ed-8046e8eeed85@denx.de>
 <PAXPR04MB8459808C7CC6C16DB43B973388A62@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <bc232085-3efb-43fb-b176-eaf43e52f1f8@denx.de>
In-Reply-To: <bc232085-3efb-43fb-b176-eaf43e52f1f8@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|DU2PR04MB8886:EE_
x-ms-office365-filtering-correlation-id: 55af4797-c149-4fa4-ea47-08dd6c316468
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?ejhFd0tJUkNKTktQZjc0L1RYZGZvTEhtWE1WUlNKVDFvK2xGR3E0UzhEQ2NH?=
 =?utf-8?B?eGZWbkJxR3BRMWpaYkdDN1Q1TEdKSU5vRGNEakJ5djBaaVZKZThXM0pRemdm?=
 =?utf-8?B?dUhUdStpby9hWE8rWnVUR3Y0MWZrSWdjSGUvOE96WmJvZUJUU2pQRVZxcGFS?=
 =?utf-8?B?eGNlTkdKWkZvZ0pRSjNVdjc2TklQaGtFS2pGRFhaUHovQlM2TzBWVDB6ZnMr?=
 =?utf-8?B?aXU0US82dFBtTGlGa25jbTJieEhIc1JXS0ZrWkxKRzU0MGFydU1qRVNrak9n?=
 =?utf-8?B?c21DcktTRHQxeElHZk44YW1hbzRhWUdaTENYUU1jVDRvNHZPZmkrVHZvNnlm?=
 =?utf-8?B?Tk9vZmRubVR0YUFoQ1k0VXFZRXcxdXR5aktBS3hYOCt5N3BJUVh6c1ZqczFO?=
 =?utf-8?B?NTBrc1pzT2JsMHFBd1g2SFVkN2JwK2UwTmdHU3NmdktHR0FpQnp3VjluQkdp?=
 =?utf-8?B?R2ovbHFsVGdnVnQvaVR3cGU2THZSUEJsWHBSQWNobHlKb3B4bFVlTWlmd2Q1?=
 =?utf-8?B?UndJOUgyVi9KQlRTbC85czhCRUt1Zkk2NFJqbGZ3UjFjYnRhY1hGeTZHVXN0?=
 =?utf-8?B?cFF2Tm9LRjRndDI2QkdMNTV5Tnc2ZmlvRC9lTzNsOGpBOVBxZVhOT0ZHVkZv?=
 =?utf-8?B?SmpNNW5rbEFIb0d5RVc0SjVKVkxZL2gybWRNNFVFbTVJandMY25HVmRPaDMx?=
 =?utf-8?B?Z3RlUEw2WmdCcXpuZUJwazJmdEZocE1UaExPRG0rRGFFaUsvck43SzN5NThr?=
 =?utf-8?B?TjQyWUgzZnhoKytVck40VkFxZGd0aGRRa2tWNkJSU2pFMHpCTW9PUXZvUG5O?=
 =?utf-8?B?WURneXY5QWs1ejlBRURtV2hvTVhEOWZHaXR4ODVKOGdyeitiajNScEc2Q21N?=
 =?utf-8?B?Z2UyVnlMdVludjBqQXBQV24vVWRTTStvK1RmUm03dVVnVnM5anc4VThSWGVF?=
 =?utf-8?B?TTl0cVFYUitmb05UY0NsWURZd3FUYXQxUmp4UVRHK0ZWcUtFSXROVkRobXR6?=
 =?utf-8?B?aFB2bENsdHo5REVFMU1IZ2dTQTcxcmlHeUU5U1dVTnM1aGpPaG1nQnY0TURF?=
 =?utf-8?B?ZzkwdSsvdHprUWlFWk16bG4zU1lHTVVPa3hKRERXVStQMWRQRFd5NlFQRWpT?=
 =?utf-8?B?TUk0L1pTMlF4dldMUmZwVWZwWEw2bGpFMnp0QzU3ZnNFeGpuLyt0SFBvdEZ6?=
 =?utf-8?B?ek91MStvZXgrMm1ZWVFWTEJNTkJsQnZpUmdOczZKa2t5Q2ZIcVRNaWt3d1Az?=
 =?utf-8?B?ZkVqQlJ5a2g2Q2luZEpvd0ZJUTgwSGMzWHBMS0JuU3kxTC9wZG1ZekZHYTA0?=
 =?utf-8?B?d283Z1RrMHVseTNmYVk2UWhZL2hTY1dqVW1XY1VLelFlYzFRR25LQm9YMmZ2?=
 =?utf-8?B?RkJCZmtiWXRQT2k3RytWeW5IS2V2eWlWeWp0WkdiWnNLN2YyNmZJWG8wNWZs?=
 =?utf-8?B?NU5VZ2FSTHRXZU1WcmVqb1pGc0dDc3NLcis3bWw0Y1RIU0xvbnJ0MWhucnFH?=
 =?utf-8?B?aXhiOW4vaGFsc1d6OHZ5SGM5NENzbWtYL1U3d0JaU3pwd3RmNlVEYXh1SkJU?=
 =?utf-8?B?aFVPWWN5YWEveDFadzl0WDBpY1hJWE4yQ3c1dm5GTlVKV3BEN3UrZmpXNVFX?=
 =?utf-8?B?QlhHWklDNGdnVWRMNDUwSnZoK2ZyOUhDZnplcnZsTHViaG9YZDNWWGF0MzhH?=
 =?utf-8?B?SEhqL0VaZGdBV2NaemdscERiOUZ1TDNFVU9YMThhdEovVHBWYWJXWnZFVWV4?=
 =?utf-8?B?TGhZTUtLUkNSLzJhQjlqaVdqOU1DK2JMMUt5c3JDZ1BqelJvTklwOXp2NjBF?=
 =?utf-8?B?VHNNc0hFMndWYXM2dUxlUHFwWnl6NVBpRkd4c0hLWmh5OTdHSUlXVElHUlFW?=
 =?utf-8?B?OGt0N3NIVk5udi91aUZBcm4wQkdHYjN3UW5FcEUzaWhhSGNZcmZHa28ya3I3?=
 =?utf-8?Q?1Gt/qHR7MRZpAf9/kacF2hbkhiL85wm4?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VjRXVFBqdTBpMWM5czQzbkFlNlMwUU40TzdwVzVNOGpyV2xVTjhRMjB6dVdM?=
 =?utf-8?B?SXl0VTRibzhqMDh6WWI4U0JjdHlTM3JENk80QXBtbXF2NkplZ3FHNEhOQ0Jz?=
 =?utf-8?B?a1VwcXM3RlUrS1pHZUtFQ0x1MHp0UkVGcmVHNk14NktZa0tBZFFMK2d3K2kz?=
 =?utf-8?B?bXRNVHlKck5iK0pHYTY2Szg4bjU3NlV2MzN5amhJUnJrcFFtOHpqTXl4cHEz?=
 =?utf-8?B?S1JPZXFTRmJEYlV2NmNoUzF6VlFuT2NyUjJLWkF0Lzgzei8rVDQzd2lnN29B?=
 =?utf-8?B?Wmt0aW82OG53YXMyQ3BIaldiWnR2dllNSStyd0Y5RGlkbytqTWFneTlaOEJZ?=
 =?utf-8?B?MGRnVU1rQ1FLZTc0SXA0aXdUeU55ZUFIRTFnbENLcFEweEl4OEN4QlBhcFpw?=
 =?utf-8?B?c0tiMmluaDBldk9VSmUyS3ZoRUZKLzQvMzdMTDJyN1NOTGtpTVdOSGdoUkRx?=
 =?utf-8?B?MWlQbE4wN1ZMMWFDLzdQZVhYMThmTURvc0NQMk1TSUtLVTFkQjhuTk5CaDk3?=
 =?utf-8?B?MWg5TVZPUHFnb3RhVUZjOUNYWjhmYVlaZGVJcloxeEw1aHQzckpBL0hrTHdv?=
 =?utf-8?B?UGhValhvT25vVVM1Yi9tZ1diK3hWTjdtbk1wem16bnB0ajhRZisyNjNpVzl4?=
 =?utf-8?B?RGNSZ2p0SEFMS0lFS2lqU2NTYzBjSlBKUWdoaWE2bEliaG5QQytqOXV5c29V?=
 =?utf-8?B?R2hpbFVjSlFONjlXcXAwZC9sK2tWdk5MbTFLSUNER3grYUEyV2RBRU9mVUN1?=
 =?utf-8?B?VEVFU3BSQUEzRFZ3cjZvSnQvcFdKWVk0Y0ZtY1NPTElNTkErMURxaXJYNmNn?=
 =?utf-8?B?VEZDUXNETzYvZlZ3VXMwNDRReDljYW4xT2MxeG0wdmUyYUxzU0FqVkczUno0?=
 =?utf-8?B?WlFwUWxUNytsczhlZUFLampLYTRkbCtSZEdaZ0hFdmVqcTRhaWxLR3BWQmJF?=
 =?utf-8?B?ZzM5ODFuSDRlNzNnRFhOOTdSOFhqeExPZjlLMDRlZVlNa0IySTMvYnM4c1dI?=
 =?utf-8?B?bmZSVXBxZG04bWhtVnlLaG9GZ1ovK1dsbk9aRXJMek43QlRqbEljYUhVTFBP?=
 =?utf-8?B?ZnJYdVJENGdTWGtWQnFSMG4xU0tjazRvWG1pNU4weVZCQzNuNmlNYVBGL3Vt?=
 =?utf-8?B?dHN3UG40WnNYby9WSG1BcG9mNm9wVVI5eUg0eTJNSXYzUVB1SlhzRHQxV0Jp?=
 =?utf-8?B?a25xSmptUThEekJTcEl1L0VLQUlpaXVna1EvUG9rdTFIaDRPZU81dDJLM2Iz?=
 =?utf-8?B?cWp0OERlQTlwOWhxS09wRHBsVmVySWJ4QVhvb0ZldFpIQXVTWXdubStQOEJT?=
 =?utf-8?B?NnVaYktVQVhzQkxXTDhZcko4T2JyYkJsU09mR0JxLzNWNzV6YUV1aEpsQkx4?=
 =?utf-8?B?VWxsOUxKa0dUd2xnQUpWd0l4MG9nMi9IUVNmT2JnODloSzhyNjNDajF3QVJI?=
 =?utf-8?B?dUlzMHZ6bGhRNzg2RkJ6OWJkTUh3NFRFVWZJTE5sZ3hsd2tXUkducHBnN3JK?=
 =?utf-8?B?Z2hkSi8xUWlhNldYOU5INkRaV1VYSklTZlVBTVhkOXJoaEtoVysrZ2lKemxT?=
 =?utf-8?B?OFk0aHlIV3V2SU95NkZoWkZ6c0k2aVpjbjduN0FzL083eGE2S0lSd01Bc0VM?=
 =?utf-8?B?WkZzK3paUlJtYzIxcHZtUWNKMVU4dk5hRjdYb09lWmducGNVQkNTVk1jejRW?=
 =?utf-8?B?RWtvSTBJaWdXT24vcGNBcXZPOWs4N0NEd1NqVkxPOTBpeThVclgrdWtuQTRI?=
 =?utf-8?B?c0tmTW9QeUxjOU53YVYvb1NCenJ6MXNxRXdpclpQYmJwOUVlU0hSc3ZnUjVS?=
 =?utf-8?B?bUNPR1pDTXkrdlFkWEZTcTlnODlVRE5XV3hlMUlUdjBqSEJBUGZ5bTM3Sm96?=
 =?utf-8?B?NTdwbTNDVTk0MUJFYnYzeklaZkpuRU1UcTZJUTNKQzMxR0E5V1YyYk5vZk9H?=
 =?utf-8?B?ZlFlRkdjaHZDK3NpOEZtOERUNlJWanlFb3dkQkpNeVdmcWFZcHZscjNaZkJH?=
 =?utf-8?B?NG5mOE5teWp0M1haUkZ1SXdFWFZrbkY5ZWhDaG5Jc0d6UjJDTW4wcGZKRmVx?=
 =?utf-8?B?MDAwa2FZMENEZHovK01DaDVGcHIvNVdXREE3aG0wek9rRzdEVCtvRkR0Y0ll?=
 =?utf-8?Q?PrrE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55af4797-c149-4fa4-ea47-08dd6c316468
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2025 06:42:35.0187 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TmxNOy5Z6dZfqb8yWq5y4mNZ1S9enMCvcm1/hsur+qPDDQcfJvhGGfLiu8xOY7zVvyBk3sglm49opsc6uXJ7gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8886
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

PiBTdWJqZWN0OiBSZTogW1BBVENIIHY4IDAyLzE5XSBwaW5jdHJsOiBueHA6IGFkZCBhIHBpbiBj
b250cm9sbGVyIGRyaXZlcg0KPiBiYXNlZCBvbiBTQ01JIHBpbiBjb250cm9sIHByb3RvY29sDQo+
IA0KPiBPbiAzLzI2LzI1IDI6NTIgQU0sIFBlbmcgRmFuIHdyb3RlOg0KPiA+PiBTdWJqZWN0OiBS
ZTogW1BBVENIIHY4IDAyLzE5XSBwaW5jdHJsOiBueHA6IGFkZCBhIHBpbiBjb250cm9sbGVyDQo+
ID4+IGRyaXZlciBiYXNlZCBvbiBTQ01JIHBpbiBjb250cm9sIHByb3RvY29sDQo+ID4+DQo+ID4+
IE9uIDMvMjUvMjUgOTowNiBBTSwgUGVuZyBGYW4gd3JvdGU6DQo+ID4+DQo+ID4+IFsuLi5dDQo+
ID4+DQo+ID4+Pj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL3NjbWlfcHJvdG9jb2xzLmggYi9pbmNs
dWRlL3NjbWlfcHJvdG9jb2xzLmgNCj4gPj4+Pj4gaW5kZXggN2FiYjJhNmYzNmIuLjI3OWViYmFk
NDQwIDEwMDY0NA0KPiA+Pj4+PiAtLS0gYS9pbmNsdWRlL3NjbWlfcHJvdG9jb2xzLmgNCj4gPj4+
Pj4gKysrIGIvaW5jbHVkZS9zY21pX3Byb3RvY29scy5oDQo+ID4+Pj4+IEBAIC0yNCw2ICsyNCw3
IEBAIGVudW0gc2NtaV9zdGRfcHJvdG9jb2wgew0KPiA+Pj4+PiAgICAgCVNDTUlfUFJPVE9DT0xf
SURfU0VOU09SID0gMHgxNSwNCj4gPj4+Pj4gICAgIAlTQ01JX1BST1RPQ09MX0lEX1JFU0VUX0RP
TUFJTiA9IDB4MTYsDQo+ID4+Pj4+ICAgICAJU0NNSV9QUk9UT0NPTF9JRF9WT0xUQUdFX0RPTUFJ
TiA9IDB4MTcsDQo+ID4+Pj4+ICsJU0NNSV9QUk9UT0NPTF9JRF9QSU5DVFJMID0gMHgxOSwNCj4g
Pj4+PiBJZiB0aGlzIGlzIHRoZSBJTVggc3BlY2lmaWMgcGluY3RybCBwcm90b2NvbCwgcGxlYXNl
IG1ha2Ugc3VyZSB0bw0KPiA+Pj4+IG5hbWUgaXQgYWNjb3JkaW5nbHkgLCBTQ01JX1BST1RPQ09M
X0lEX1BJTkNUUkxfSU1YIG9yDQo+ID4+IHNvbWV0aGluZyAuDQo+ID4+Pg0KPiA+Pj4gVGhpcyBJ
RCBpcyBnZW5lcmljIElELCBub3QgaS5NWCBzcGVjaWZpYy4NCj4gPj4+DQo+ID4+PiBpLk1YIFND
TUkgcGluY3RybCBmb2xsb3dzIEFSTSBTQ01JIHNwZWMsIGJ1dCBpLk1YIHBpbmN0cmwgYmluZGlu
Z3MNCj4gPj4gYXJlDQo+ID4+PiBkaWZmZXJlbnQgY29tcGFyZWQgd2l0aCBBUk0gU0NNSSBnZW5l
cmljIHBpbmNvbmYgYmluZGluZ3MsIHNvIHdlDQo+ID4+IG5lZWQNCj4gPj4+IGEgc2VwYXJhdGUg
ZHJpdmVyIGZvciBpLk1YLg0KPiA+PiBCdXQgdGhlbiwgd2h5IGlzIGl0IHVzaW5nIHRoZSBzYW1l
IHByb3RvY29sIElEID8NCj4gPg0KPiA+IGkuTVggU3lzdGVtIE1hbmFnZXIgRlcgcGluY3RybCBm
b2xsb3dzIEFSTSBTQ01JIHNwZWMsIHRoZSBJRA0KPiB2YWx1ZSBpcw0KPiA+IDB4MTkuDQo+ID4N
Cj4gPg0KPiA+IElmIHlvdSBsb29rIGF0IGxpbnV4IGtlcm5lbCBkcml2ZXINCj4gPg0KPiA+IGRy
aXZlcnMvcGluY3RybC9waW5jdHJsLXNjbWkuYw0KPiA+IGRyaXZlcnMvcGluY3RybC9mcmVlc2Nh
bGUvcGluY3RybC1zY21pLWlteC5jDQo+IA0KPiBJcyB0aGUgc2Vjb25kIGRyaXZlciB1cHN0cmVh
bSBhdCBhbGwgPyBJIGRvbid0IHNlZSBpdCBpbiBsaW51eC1uZXh0ID8NCg0KVHlwbzogZHJpdmVy
cy9waW5jdHJsL2ZyZWVzY2FsZS9waW5jdHJsLWlteC1zY21pLmMNCg0KPiANCj4gPiBCb3RoIHVz
ZSBzYW1lIElEIDB4MTkuDQo+ID4NCj4gPiBJdCBpcyBmaW5lIHRvIHVzZSBiZWxvdywgaWYgaXQg
aXMgZmluZSB0byB5b3UuDQo+ID4gU0NNSV9QUk9UT0NPTF9JRF9QSU5DVFJMX0lNWCA9IDB4MTku
DQo+IEhvdyBkb2VzIHRoZSBrZXJuZWwgZGlzY2VybiB3aGljaCBkcml2ZXIgaXQgc2hvdWxkIHVz
ZSB0bw0KPiBjb21tdW5pY2F0ZSB3aXRoIHRoZSBTQ01JIHByb3ZpZGVyIGlmIGJvdGggZHJpdmVy
cyBhcmUgY29tcGlsZWQgaW50bw0KPiB0aGUga2VybmVsID8NCg0KVGhlcmUgaXMgYSBjaGVjayBp
biBkcml2ZXJzIHByb2JlLiBPbmx5IG9uZSB3aWxsIHN1Y2NlZWQuDQoNCkJ1dCB0aGVyZSBpcyBh
IGNvbW1vbiBpc3N1ZSByZWdhcmRpbmcgc2NtaSBkZXZsaW5rIHRoYXQgSSBhbSB0cnlpbmcNCnRv
IHJlc29sdmUuDQoNClJlZ2FyZHMsDQpQZW5nLg0KDQo=
