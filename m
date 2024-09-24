Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B38FBCF9C6B
	for <u-boot@archiver.kernel.org>; Tue, 24 Sep 2024 10:24:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1396880D8;
	Tue, 24 Sep 2024 12:24:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="A2xYgmjj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0B1E88770; Tue, 24 Sep 2024 12:24:25 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74E5886E61
 for <u-boot@lists.denx.de>; Tue, 24 Sep 2024 12:24:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yAZpgj8JCSU7ldF1XIMnaf2GKj5HxJbcaE+aFYQuyVK7W2+60IM/58qnZWgOFTVUCRSXJsXSzmcdGqVr1zgelcG24tzuK6Kthkf3Ex21c5ALUs2b1JtF3XGn5cQUz+hwYMsa77V8ut00nLtRNJyAHkpnZOuTpkCNBHxziHpk4VwJayMieuGU+4TNbYIEYo08TOqc3FFjx/J5vOQ+wNU2RMOgSz9kPzWOfeYd81xs81hSTm++nYaAsYmc6trKwX9eq4h/PuTKM00aTp+muNyvzcv7M6fcle7X1ytZjthCpC/KZ1E+Mwbcu9Yvh3yZlZ+6M8LdEsaAcvRyjr8k8PXQaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EsY8y4CWAKTExgkQ8A3K01XU71BuAJWX+3t17GjT36g=;
 b=jWeQBTR1NGs1cViz775Fm9Jap+YW4B/olJ8me8NPucibMWe6OnnJe74b/0YuOk0m3nGRy3WM3uCvRIUqjV+rm3x4bzosVRRsKnYHVG8PVKwbSLChWlm28+kscY6njVjVWb5ZnjewEjiVM9No6eRAKt8XkWZXgZ0APLWf2pE7nShxf4w4+4hxmz5cc4b6oqvXPDJpabmQMnvElghoG7uZU6fkHpkj4p7WlqQgwYephkqEhZ1wUpjPVzkAhPxsc5E7VPChIDropbWOh7DiFVL/8gX58MQh7cnZDrpjXIfgfnYrTSpwUDvOhSG6L7QssHlf/QBuCWU6AT5gwS0uhpVSNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EsY8y4CWAKTExgkQ8A3K01XU71BuAJWX+3t17GjT36g=;
 b=A2xYgmjjTD7KchA6yWONE4B2ybvaFJPPKRxZCYDo0+5YdG4ixt/xOCnpeFVSB+jNH1yKCqa2i4mMg6GUDqmv8H0r0R26i6iWVVOAQw1S9JxPiDPFOJ/sDyFEN1Nv06BukgzTV0xTirtEI8yB97Sy/hJ/bOYj/8Ik0EqYrD/01ys=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9)
 by DB9PR04MB9751.eurprd04.prod.outlook.com (2603:10a6:10:4ce::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Tue, 24 Sep
 2024 10:24:17 +0000
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea]) by AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea%2]) with mapi id 15.20.7918.024; Tue, 24 Sep 2024
 10:24:17 +0000
Message-ID: <3b41755b-bc5b-4729-9f6d-5229634e8a70@cherry.de>
Date: Tue, 24 Sep 2024 12:24:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/4] board: rockchip: Add vdd_cpu reg fixup for RGXX3
 Series
To: Chris Morgan <macromorgan@hotmail.com>
Cc: Chris Morgan <macroalpha82@gmail.com>, u-boot@lists.denx.de,
 jonas@kwiboo.se, trini@konsulko.com, kever.yang@rock-chips.com,
 philipp.tomsich@vrull.eu, sjg@chromium.org, dsimic@manjaro.org
References: <20240919140022.511067-1-macroalpha82@gmail.com>
 <20240919140022.511067-3-macroalpha82@gmail.com>
 <2a207719-e37c-4289-9470-2324928e24bc@cherry.de>
 <MN2PR16MB2941DA215E7CDBFD7E3AF730A56F2@MN2PR16MB2941.namprd16.prod.outlook.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <MN2PR16MB2941DA215E7CDBFD7E3AF730A56F2@MN2PR16MB2941.namprd16.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0354.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::11) To AM9PR04MB8906.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8906:EE_|DB9PR04MB9751:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b66cdfa-0609-42f5-8bf9-08dcdc830b6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L1RFeGxqejJIQlNKdzJFK3RLZVdtSGREY1dMZDBQQ05jSkpLTVJ0OGsvb1p4?=
 =?utf-8?B?eis4cXorcHFjbGN6cWgzRElwMmZvMGZuQytZVlo3aXhqK3FoblpKVitHMVRz?=
 =?utf-8?B?LzZrdWNuUzBub0h4V1lUY0ttVEJuT0dRYWlFUWF0Rm9NUHAySWxlK3gxVkRs?=
 =?utf-8?B?WVJuYTgybG1nMWlrRmp6QXJxTnZiSUdYS3VTNGZIZFdDdDVIZlg0SGR4WmNs?=
 =?utf-8?B?TmJZcmh2RjZsTGtRamxxV0lBYU5jQzBMWU96VUFqZGJxTlA0QzJRZERPMGg0?=
 =?utf-8?B?aXNnWmNTVkxCdWlaUUdBMDZaNW42S0VDdUMwd2tVWDZTOWJMcGNVUUh1ZzFL?=
 =?utf-8?B?ZVV5S2F5bkcyaER0UDlFTWJBcWxmVjZSWHlDaEF4QmYxeEFmS1pVR1liZTVv?=
 =?utf-8?B?YUpybVFNKzZLclhVTzJZUWkybGVDSE5GbkNzMVVaWnVhVmE3NEd6aU05VXdG?=
 =?utf-8?B?Qkc1cFJXb3Iyd0w0Q29IWDhUWmZaNVNObXFmTEQrT0Qra2Y4YTRqVEV4Z2Ex?=
 =?utf-8?B?R2lNM2V3L0F4ZSt0MkhDUEo4VXNLaThDUUJTVjljSDFKOW5jL25JMzhheW10?=
 =?utf-8?B?RWlBMnluc3lHWS9PYUE4a3RTMUhvemlJNHZOajhqQ0tWa1N0YXRJVUlKMENw?=
 =?utf-8?B?VUpKaDRnK0xuTlkxNHhkSUVBOVh0NkJLTUJrcCthdE45VWNQd0RiSnptUytj?=
 =?utf-8?B?TGFXR0JJOE1uRHU0OC8rRzEybW1Ja3I2SzliQnNjWmgwY1d2V3dIMk1IdGFo?=
 =?utf-8?B?enZ1Tm5kM1lSNFBzeDBDZm45djFtTG9ZeFdIbWkrMTcrYmJZZ3Z0OERDUENW?=
 =?utf-8?B?Q2hLZDZlSnNYaFM5UzhZdDREbk9zR2JUNFBTVXNUakxvRGpESEo4MkwvRDlZ?=
 =?utf-8?B?QlFYOFVwQ1ZXWlFja2dhWnNYbm9sYW84WjJXNEl2akV4Vkg5SW5uMUZ3S1dT?=
 =?utf-8?B?N0VZQTc5WHdhU0xtdXUzdERnYUJXM2JlcXllQXBvWFBDVTRmQVZud2ZnSXM0?=
 =?utf-8?B?M0M0TGNxS0NQN1RoS3REZUs1U3BXdUdiRzQwTy9GejVRa1I0STR3NzFSNXla?=
 =?utf-8?B?MTV1ZmhmNEY0cXZDME8xNFBtTlhyOTliTlpYK3AwMmM1MGNCU2V1dVhOZVhm?=
 =?utf-8?B?SHJPVFdMMVFlOC9nNDVpR3FLVWpVUDRUbnNaaWUrNVhzTEJPc2Jjdks0U0t3?=
 =?utf-8?B?cFkvVnBLRFhENWlDTE83Z3htZjF5ajgzd3Q0dEVySE1lSWpIWCs1V0pQLzVG?=
 =?utf-8?B?emFLV09NTWVkMXVyVFZzVmtDdDg2RE1FSzllckY2QnQzdHlrWkM3ZmlYLzV1?=
 =?utf-8?B?RnBJU3FRL29sMDB0NzlFeHFmNE0xK0FaYjhsWWxCTFVjRi9ac0Yvbi9ZOGdF?=
 =?utf-8?B?S2hPZ2s1a3lhTW1RYUcyZ2o5Sk1hbHhHQ21QdG90NVU0VENJemxVNXNqR2ZJ?=
 =?utf-8?B?QUY3RGpGR2RhaHUzT01OUTN5ZHk2TUw5QThNZVBDWHpxRVhGeDk3WnhJS1pH?=
 =?utf-8?B?ZXhIRGxjN2ZrQXR4UlZUTy9FVXNHVGZRMXNXZFpmclRzK2p1WkloRGk4UnJ1?=
 =?utf-8?B?YjJqbXhKZnZiOEI0L0VIb0d3YWRLcnAwNGxLODAxcWowWlRSd1ZnZVF6REFQ?=
 =?utf-8?B?cmpENExnUEV2Sm1Hak1JVjFUTmFhTk5nbGZPNkd2d05YRUtQT1pkUEROZTdI?=
 =?utf-8?B?akFHMUtreUt5VHRndHRSYVZrTnJkSkl2Q1BSZ0dHL3FFZytVOVNSK1NRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8906.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3NrOUdRcklWOTdmcDBzOTh0VXcxYlpwanVRZWZ2eENxSEErcCt5N3pwb2hh?=
 =?utf-8?B?REI3RVJzKzFpSzNKb1lla3h5MEI5NmdxMHJTRUxtOFg1TUdKSzF0MnB2ZjB6?=
 =?utf-8?B?aDBTV1g0WkJVdmFjcXdtcnhwSFg0eU5WZEZrZkU0bzVUREYrTHdzNDNnazBK?=
 =?utf-8?B?RkIwcDg4cnl0dEF1MjVoaXFzL3lteDZwM3IxdkF6dzBUdVpGeHVrMnI4bEZo?=
 =?utf-8?B?cUV4ZzR0MU5DTzVFNkJEb3pZRUh4VEVsa0RYaHF4N3N6U21IN0xPMUFEQzJE?=
 =?utf-8?B?V241QWo5cTZOODd0ekZVdENUdmJlMUdHcHdTS001aU9VYVFkamsyZ2YxQUtJ?=
 =?utf-8?B?RzYvbGk2cTc0ck9TTkxzRVhoRDR1cGpYcUkyVVV1bzN2cWxENUFJY21HZExU?=
 =?utf-8?B?VElPUkZkQm8xNFg1a1VpYmxXY1JQbjZFSW9yOGRJeElSSitTOTVINEVzanQz?=
 =?utf-8?B?Q1JFQTV4aFNiMFhQV095UVQzZkdMM1NpSGxlbWo5MXRwYXpOMm9rUC9RdXE1?=
 =?utf-8?B?aThuazVuR3NaUmlVNDRCSXFBNktEcnZnYi9GUldOYll4cWxkbjc0YmpXYlBB?=
 =?utf-8?B?QU5sc0RvOGwxdVdGM1hqTk1jUEtON2xwRUMrak51M0EwbjNwakFhM1VlUWo2?=
 =?utf-8?B?ejNKZkNZL01ZZHBYbHQ5UVlsYUNTbllKdG1QNG5YcGgza1lEd3VCME93Nkll?=
 =?utf-8?B?QTk2RzIyQkdLWStRdzkxMkVWYlBkODlHV2UyaE8waUxwcEI1TlZoWC9sZWNP?=
 =?utf-8?B?Vm0yNFpwNEEwZnBNZlZSVzZLcDc3SWI1d0w3K0NKTVdxaGJ5L3ZUVnNiTk9o?=
 =?utf-8?B?L01IZ2NHNjZINHArbmtUQk9qaGRRbzhiV1gzTGRDTWZWV2s1SWQ3ZGlkM0RK?=
 =?utf-8?B?TC92ZWliaHNrZldzN2d6Y1BXeXJEY2MwRms0QW9nV3EzK3R5Qk1OeU9ua05S?=
 =?utf-8?B?ei9mTkxYS1lXRkNKVjJrOXRkekt1TkFSRklXL29MM1pVU3lYbVVtMTB5elpS?=
 =?utf-8?B?YTN4N0RqSGJmLzVoa21JdGpsbjBnQkRQRGdvdGhjVnEwMlVEeUJCazBmVE9N?=
 =?utf-8?B?UzFiQlhiMStiSUthUzMxVC9iS0JCazJXQ25EcEFqVzJ4YSs1QWtqVjZJSXBh?=
 =?utf-8?B?YkJSZUQ2NzQ0NnRyNVN4LytjLzJnWGM1aWgxaUsvUmFBQkxyd0NyYkorTEVk?=
 =?utf-8?B?N1loOVQ1OTl2Qk1PNFlIVXFBUUhBaTdBVUlOVzQ2K2RiZEFlYWFaN29aVzZq?=
 =?utf-8?B?aEYxYkd1YnE0ZzQzUEprN3pKN3FqSHgyR2xuZ3dTL1ZNSjZ0YmFEUHptRGFh?=
 =?utf-8?B?L3YzcTNyeFFlcm5vRlJGbmVpcjBKeXM0cnU0eDVHSlZVU2Rvd2lKM3dLSW9X?=
 =?utf-8?B?cXBBZ0o4ODFEYnBSOUd5OExLVFd3YTJ3R3ltcjFqekxkS2dERlkrL1RPdFdZ?=
 =?utf-8?B?bHZFeHEzRDBDcXAvRDVBdTFzeTZwSnVEcU5mQmRERzF4cEJsTlM5aHZXbE1y?=
 =?utf-8?B?L0hEWDZqbE5zQWZNak94QWlmd0lYbjY3aTdhdGlDSmEzNzlvaHRIVGdqUmhQ?=
 =?utf-8?B?Vzl6azYwM1FTc0pnRE9CYlpTbnBEQisvN0I0VXRVZ0pyOWZURGdwTWo0L2F0?=
 =?utf-8?B?ZldjWjkwWGx6SHZqNEcyOUVyNzE2aVh0ODVyZVdRTmtDWVNvdWIyUmIvekll?=
 =?utf-8?B?T2VOa3FlMlVuWWVWQnpoVWJhd0IrYjRVdk9OVUdCS2xMaCtjYll3S3pTNWp5?=
 =?utf-8?B?TEY1WnFaOHA3eEdjWDYzamdYUGJrMWpmQVQ0dmJ1d1BvL2ZtTFBYVDlud2hk?=
 =?utf-8?B?VmFreEFMWHZHcFpsY0txSzZwMjB1aXBQby9adE5VODMvVEpBTEg4WkNDbTlM?=
 =?utf-8?B?L3AzNDhETDk3dUsxZjJic2F6OUFiMW1vWC9KYWFSSTJSYkRQVCswUTJSTHV2?=
 =?utf-8?B?Mm8wQ0lrTXVVOUNoMkxMV2YwUUExczNkd3ZsWCtOQlYwS2lFd0ZoeVRwN0Jr?=
 =?utf-8?B?Uy9ZK2FCWEFDYTdibnVsczgzbk9GLzJxUVdSTkRmaVFpL0dvNEx1aXdDczNH?=
 =?utf-8?B?Q3hDa0FDWU01TnJlaC9EdzR4aDA5cEdsc1kyM0hmRkRQL3AxM202c3BMdll6?=
 =?utf-8?B?ZjJQelhUdzA3aUo2SEhYa0NJa3FCajVqMmhYcy9MVDFEaS9mM0QxL1B0KzNm?=
 =?utf-8?B?ZVE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b66cdfa-0609-42f5-8bf9-08dcdc830b6c
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8906.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 10:24:17.1612 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Sa7wF5OGFnT/0tPrrA9XcdOntke6q7WqUSlHSbGAGtc8LJvh+Pg5Xg8PofLgmrd5C45dVH6tFq9aPF2ovy24zdg0/JolxU7jgsgGMm9SmI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9751
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

Hi Chris,

On 9/23/24 7:36 PM, Chris Morgan wrote:
> On Mon, Sep 23, 2024 at 01:21:01PM +0200, Quentin Schulz wrote:
>> Hi Chris,
>>
>> On 9/19/24 4:00 PM, Chris Morgan wrote:
>>> From: Chris Morgan <macromorgan@hotmail.com>
>>>
>>> Some of the Powkiddy devices switched to using a different vendor for
>>> the vdd_cpu regulator. Unfortunately the device does not have a new
>>> revision to denote this, so users have no way of knowing in advance.
>>>
>>> Add code to detect if a device is present at addresses 0x1c or 0x40 on
>>> the i2c0 bus and update the devicetree if needed.
>>>
>>> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
>>> ---
>>>    board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c | 147 +++++++++++++++++++++
>>>    1 file changed, 147 insertions(+)
>>>
>>> diff --git a/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c b/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
>>> index 224019f9ba3..c1d1826fd14 100644
>>> --- a/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
>>> +++ b/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
>>> @@ -43,6 +43,7 @@ struct rg3xx_model {
>>>    	const char *board_name;
>>>    	const char *fdtfile;
>>>    	const bool detect_panel;
>>> +	const bool detect_regulator;
>>>    	const bool uart_con;
>>>    };
>>> @@ -69,6 +70,7 @@ static const struct rg3xx_model rg3xx_model_details[] = {
>>>    		/* Device is identical to RG353P. */
>>>    		.fdtfile = DTB_DIR "rk3566-anbernic-rg353p.dtb",
>>>    		.detect_panel = 1,
>>> +		.detect_regulator = 0,
>>>    		.uart_con = 1,
>>>    	},
>>>    	[RG353P] = {
>>> @@ -77,6 +79,7 @@ static const struct rg3xx_model rg3xx_model_details[] = {
>>>    		.board_name = "Anbernic RG353P",
>>>    		.fdtfile = DTB_DIR "rk3566-anbernic-rg353p.dtb",
>>>    		.detect_panel = 1,
>>> +		.detect_regulator = 0,
>>>    		.uart_con = 1,
>>>    	},
>>>    	[RG353V] = {
>>> @@ -85,6 +88,7 @@ static const struct rg3xx_model rg3xx_model_details[] = {
>>>    		.board_name = "Anbernic RG353V",
>>>    		.fdtfile = DTB_DIR "rk3566-anbernic-rg353v.dtb",
>>>    		.detect_panel = 1,
>>> +		.detect_regulator = 0,
>>>    		.uart_con = 1,
>>>    	},
>>>    	[RG503] = {
>>> @@ -93,6 +97,7 @@ static const struct rg3xx_model rg3xx_model_details[] = {
>>>    		.board_name = "Anbernic RG503",
>>>    		.fdtfile = DTB_DIR "rk3566-anbernic-rg503.dtb",
>>>    		.detect_panel = 0,
>>> +		.detect_regulator = 0,
>>>    		.uart_con = 1,
>>>    	},
>>>    	[RGB30] = {
>>> @@ -101,6 +106,7 @@ static const struct rg3xx_model rg3xx_model_details[] = {
>>>    		.board_name = "Powkiddy RGB30",
>>>    		.fdtfile = DTB_DIR "rk3566-powkiddy-rgb30.dtb",
>>>    		.detect_panel = 0,
>>> +		.detect_regulator = 1,
>>>    		.uart_con = 0,
>>>    	},
>>>    	[RK2023] = {
>>> @@ -109,6 +115,7 @@ static const struct rg3xx_model rg3xx_model_details[] = {
>>>    		.board_name = "Powkiddy RK2023",
>>>    		.fdtfile = DTB_DIR "rk3566-powkiddy-rk2023.dtb",
>>>    		.detect_panel = 0,
>>> +		.detect_regulator = 1,
>>>    		.uart_con = 0,
>>>    	},
>>>    	[RGARCD] = {
>>> @@ -117,6 +124,7 @@ static const struct rg3xx_model rg3xx_model_details[] = {
>>>    		.board_name = "Anbernic RG ARC-D",
>>>    		.fdtfile = DTB_DIR "rk3566-anbernic-rg-arc-d.dtb",
>>>    		.detect_panel = 0,
>>> +		.detect_regulator = 0,
>>>    		.uart_con = 1,
>>>    	},
>>>    	[RGB10MAX3] = {
>>> @@ -125,6 +133,7 @@ static const struct rg3xx_model rg3xx_model_details[] = {
>>>    		.board_name = "Powkiddy RGB10MAX3",
>>>    		.fdtfile = DTB_DIR "rk3566-powkiddy-rgb10max3.dtb",
>>>    		.detect_panel = 0,
>>> +		.detect_regulator = 1,
>>>    		.uart_con = 0,
>>>    	},
>>>    	/* Devices with duplicate ADC value */
>>> @@ -134,6 +143,7 @@ static const struct rg3xx_model rg3xx_model_details[] = {
>>>    		.board_name = "Anbernic RG353PS",
>>>    		.fdtfile = DTB_DIR "rk3566-anbernic-rg353ps.dtb",
>>>    		.detect_panel = 1,
>>> +		.detect_regulator = 0,
>>>    		.uart_con = 1,
>>>    	},
>>>    	[RG353VS] = {
>>> @@ -142,6 +152,7 @@ static const struct rg3xx_model rg3xx_model_details[] = {
>>>    		.board_name = "Anbernic RG353VS",
>>>    		.fdtfile = DTB_DIR "rk3566-anbernic-rg353vs.dtb",
>>>    		.detect_panel = 1,
>>> +		.detect_regulator = 0,
>>>    		.uart_con = 1,
>>>    	},
>>>    	[RGARCS] = {
>>> @@ -150,6 +161,7 @@ static const struct rg3xx_model rg3xx_model_details[] = {
>>>    		.board_name = "Anbernic RG ARC-S",
>>>    		.fdtfile = DTB_DIR "rk3566-anbernic-rg-arc-s.dtb",
>>>    		.detect_panel = 0,
>>> +		.detect_regulator = 0,
>>>    		.uart_con = 1,
>>>    	},
>>>    };
>>> @@ -172,6 +184,22 @@ static const struct rg353_panel rg353_panel_details[] = {
>>>    	},
>>>    };
>>> +struct powkiddy_regulators {
>>> +	const u8 addr;
>>> +	const char *regulator_compat;
>>> +};
>>> +
>>> +static const struct powkiddy_regulators regulator_details[] = {
>>> +	{
>>> +		.addr = 0x1c,
>>> +		.regulator_compat = "tcs,tcs4525",
>>> +	},
>>> +	{
>>> +		.addr = 0x40,
>>> +		.regulator_compat = "fcs,fan53555",
>>> +	},
>>> +};
>>> +
>>>    /*
>>>     * Start LED very early so user knows device is on. Set color
>>>     * to red.
>>> @@ -361,6 +389,44 @@ int rgxx3_detect_display(void)
>>>    	return 0;
>>>    }
>>> +/*
>>> + * Some of the Powkiddy devices switched the CPU regulator, but users
>>> + * are not able to determine this by looking at their hardware.
>>> + * Attempt to auto-detect this situation and fixup the device-tree.
>>> + */
>>> +int rgxx3_detect_regulator(void)
>>> +{
>>> +	struct udevice *bus;
>>> +	struct udevice *chip;
>>> +	u8 val;
>>> +	int ret;
>>> +
>>> +	/* Get the correct i2c bus (i2c0). */
>>> +	ret = uclass_get_device_by_name(UCLASS_I2C,
>>> +					"i2c@fdd40000", &bus);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	/*
>>> +	 * Check for all vdd_cpu regulators and read an arbitrary
>>> +	 * register to confirm it's present.
>>> +	 */
>>> +	for (int i = 0; i < ARRAY_SIZE(regulator_details); i++) {
>>> +		ret = i2c_get_chip(bus, regulator_details[i].addr,
>>> +				   1, &chip);
>>> +		if (ret)
>>> +			return ret;
>>> +
>>> +		ret = dm_i2c_read(chip, 0, &val, 1);
>>> +		if (!ret) {
>>> +			env_set("vdd_cpu", regulator_details[i].regulator_compat);
>>> +			break;
>>> +		}
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>> +
>>>    int rgxx3_read_board_id(void)
>>>    {
>>>    	u32 adc_info;
>>> @@ -485,6 +551,16 @@ int rk_board_late_init(void)
>>>    			printf("Failed to detect panel type\n");
>>>    	}
>>> +	/*
>>> +	 * Skip vdd_cpu regulator detection if not needed. Warn but
>>> +	 * don't fail for errors in auto-detection of regulator.
>>> +	 */
>>> +	if (rg3xx_model_details[gd->board_type].detect_regulator) {
>>> +		ret = rgxx3_detect_regulator();
>>> +		if (ret)
>>> +			printf("Unable to detect vdd_cpu regulator\n");
>>> +	}
>>> +
>>>    end:
>>>    	/* Turn off red LED and turn on orange LED. */
>>>    	writel(GPIO_WRITEMASK(GPIO_C7 | GPIO_C6 | GPIO_C5) | GPIO_C6,
>>> @@ -547,6 +623,71 @@ int rgxx3_panel_fixup(void *blob)
>>>    	return 0;
>>>    }
>>> +int rgxx3_regulator_fixup(void *blob)
>>> +{
>>> +	const struct powkiddy_regulators *vdd_cpu = NULL;
>>> +	int node, ret, i;
>>> +	char path[] = "/i2c@fdd40000/regulator@00";
>>> +	char name[] = "regulator@00";
>>> +	char *env;
>>> +
>>> +	env = env_get("vdd_cpu");
>>> +	if (!env) {
>>> +		printf("Can't get vdd_cpu env\n");
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	/*
>>> +	 * Find the device we have in our tree, which may or may not
>>> +	 * be present.
>>> +	 */
>>> +	for (i = 0; i < ARRAY_SIZE(regulator_details); i++) {
>>> +		sprintf(path, "/i2c@fdd40000/regulator@%02x",
>>> +			regulator_details[i].addr);
>>> +		node = fdt_path_offset(blob, path);
>>> +		if (node > 0)
>>> +			break;
>>> +
>>> +		printf("Unable to find vdd_cpu\n");
>>> +		return -ENODEV;
>>> +	}
>>> +
>>> +	node = fdt_path_offset(blob, path);
>>> +	if (!(node > 0)) {
>>> +		printf("Can't find the vdd_cpu node\n");
>>> +		return -ENODEV;
>>> +	}
>>> +
>>> +	ret = fdt_node_check_compatible(blob, node, env);
>>> +	if (ret < 0)
>>> +		return -ENODEV;
>>> +
>>> +	/* vdd_cpu regulators match, return 0. */
>>> +	if (!ret)
>>> +		return 0;
>>> +
>>> +	/* Regulators don't match, search by first compatible value. */
>>> +	for (i = 0; i < ARRAY_SIZE(regulator_details); i++) {
>>> +		if (!strcmp(env, regulator_details[i].regulator_compat)) {
>>> +			vdd_cpu = &regulator_details[i];
>>> +			break;
>>> +		}
>>> +	}
>>> +
>>> +	if (!vdd_cpu) {
>>> +		printf("Unable to identify vdd_cpu by compat string\n");
>>> +		return -ENODEV;
>>> +	}
>>> +
>>> +	/* Set the compatible and reg with the auto-detected values */
>>> +	fdt_setprop_string(blob, node, "compatible", vdd_cpu->regulator_compat);
>>> +	fdt_setprop_u32(blob, node, "reg", vdd_cpu->addr);
>>> +	sprintf(name, "regulator@%02x", vdd_cpu->addr);
>>> +	fdt_set_name(blob, node, name);
>>> +
>>
>> I'm not sure this is viable in the long run... This relies on the properties
>> for the two devices to be identical. Are we sure it is absolutely the case?
> 
> Yes, for the moment at least the devices are entirely identical except
> for the CPU regulator. Unfortunately the identical ADC IDs is why I
> cannot simply have an additional entry for a new hardware revision.
> 
>>
>> An option could be to have a DTSO for the "new" regulator that removes the
>> old regulator entirely and we would simply be applying that DTSO at runtime
>> before the kernel starts. I assume you probably want this for SPL or U-Boot
>> proper as well so applying the DTSO there would be required as well, not
>> sure how to do this though.
> 
> In truth I really don't need the regulator this way for U-Boot at all.
> Near as I can tell it defaults to being on and the right voltage. I can
> do a DTSO, I just figured a simple fixup would be easier (plus we're
> already doing a fixup for a similar situation with panel revisions).
> 

The benefit of using DTSO is that 1) it drastically lower the complexity 
of the C code (or I would very much hope so). 2) you can have this 
upstream in the kernel and it being very explicit something fishy is 
going on with the HW so people are aware of those things (which also 
means if someone has the idea of supporting another bootloader, e.g. 
Barebox, LittleKernel, ..., they would know about the different variants 
to support and similar "hacks" to implement).

You're the maintainer of those boards and this doesn't impact any other 
product, so I would say this is up to you :)

>>
>> Can you please tell the HW vendor to have some way of detecting some
>> variants of the HW instead of letting us just guess stuff? How do they even
>> support this in their downstream kernel/bootloader????
>> Have they already ran out of channels on SARADC?
>>
> 
> I have told both Powkiddy and Anbernic this. Whether they will listen
> is a different matter. They haven't run out of channels on the SARADC
> (except for the Powkiddy X55, which is its own board and has no
> detection logic). In theory if we allow for a ~10% variance in the
> resistor values for a resistor on ADC channel 1, and the range is
> between 0 and 1024 (20 and 1004), that gives us about 49 total devices
> we could "detect" at one time, assuming no one collides.
> 

The channel 1 is commonly used for the recovery button IIRC on recent 
Rockchip SoCs-based products, so another channel probably makes more sense.

I assume one of the possible issue is that they didn't foresee such a 
change would be required and forgot about those ADC channels AND the new 
regulator is pin-to-pin compatible with the same footprint, meaning they 
didn't need to redo a new PCB. That's the only "excuse" i can give them :)

> I have no idea how Powkiddy fixes up the CPU regulator, but I know
> Anbernic does panel fixup with some hacky code in U-Boot and Linux
> proper that detects for the panel like I do. In their case it's built
> into the probe function of Rockchip's own "display-simple-dsi" driver.
> In our case we detect the panel ID in U-Boot and then fixup the device
> tree for Linux with the correct compatible.
> 

I definitely never had to do that myself. Never! I don't know what 
you're talking about ;) Oh look, a squirrel.

Cheers,
Quentin
