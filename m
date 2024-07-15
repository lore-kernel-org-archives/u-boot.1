Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A559C3DA4B
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 14:12:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F96088874;
	Mon, 15 Jul 2024 16:12:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="QJuuS7wC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CECD8887A; Mon, 15 Jul 2024 16:12:56 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DA5087B84
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 16:12:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UVL9fcHcw84WbwqNwEpUVD+J3QCbPAOIn1KpY2Q6G3ORwhfEUwo2MexF154Mp3JrO9RA/oBeqbg+1CEGxtBvolj+m9OHTXmCF0IkTxcQGmZkCPODtXgFdixxA+PLi62fuTH/wg0xAOfDO7sJdQsPmWs35Sq4zcHwqOUghmmafctn6jfHO7Kw5GIPakTHeHBNaaksrcL0WdO3+30EobGvh6l6zXlqQ0lil0ZtItMwhiGbnYqHchEkLGVxFm/mU+k+wVTTaMQfUJzSm6MzR8ZDX8xYZmJmwDRlN8zFtA7A1+SaPrmjR7+rh74GA7JAa2KNA7wCcxotgCd43auteC6LnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KKQaXa1cdpTstMxwAmkFrSPRRMXceaSGwvdEx4EojVI=;
 b=YLLu3P/s6q7uO70rSzRZbW4G7353NnEE4799ahxNELMu/Vn+N7An5IkV0oSIaKbtqIGRiK39M00pvAD83tdGho+26Vu6hwX1O0/t/58b5880mfmsJPf4ji7pggq/VGbFqIgcAGtA2WmuEr5nf3Po7qB766HWLnIctaAOzcd9SAqjNQvuXoczSAgj0X6SSyc5Fvj7BtoQ8Hxq/XZ2K6NZb6Rmk4+Pinqanxfflr+fDjVoAmhV5uYtD1zJPbF+YNw6Ot/EIO0NiZC5wC7YtL3FC5sloi85YaREpnxe+cYzkWwCJAsufK9UzBjUvSfkhj0XVDrUcVUKdImR8/gWPOsYgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KKQaXa1cdpTstMxwAmkFrSPRRMXceaSGwvdEx4EojVI=;
 b=QJuuS7wCEC1f+SnlXB7Pomnk+MZOnJLq9Csw0GDFIp2LWsRILnD/Lc+mJosZfR3vkOsOEE58lgmd53NWYYMwMJiUl5KVVZFOTRxwm8PGP5pvUS06HL0T7GJkpHHAuXmF+0KZZJtSSy6p1IXyUdknMl4Oen1RqxMC1F5qt/f8uSs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DU4PR04MB10885.eurprd04.prod.outlook.com (2603:10a6:10:587::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Mon, 15 Jul
 2024 14:12:53 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%4]) with mapi id 15.20.7762.020; Mon, 15 Jul 2024
 14:12:53 +0000
Message-ID: <3aad0741-d5c2-4cdf-ab0e-35e364ee292f@cherry.de>
Date: Mon, 15 Jul 2024 16:12:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/13] doc: Add a description for bootmeth_extlinux
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Nam Cao <namcao@linutronix.de>
References: <20240715101354.97895-1-sjg@chromium.org>
 <20240715101354.97895-4-sjg@chromium.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240715101354.97895-4-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0116.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::14) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DU4PR04MB10885:EE_
X-MS-Office365-Filtering-Correlation-Id: 2291858d-75ca-4887-d580-08dca4d83783
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RnpMdHJ5QW9UNHlTTmhFTmxXUlYwZGFKZWpwaXErMmh3Q3pNKzlpcVFqbkp6?=
 =?utf-8?B?Mk1SYmNuN1V6dTFoZ29SamhTNkdpWG1xNnVoU1I3eWMyZHpSVTBVYUVGTCtM?=
 =?utf-8?B?MVBhMzYvNEVqWEc4N1dLblpUMDJmc0MyQ3RHdW5WM1lPTVlyNEZyMTVUTHds?=
 =?utf-8?B?NWpydHF0YmY1ZWVtaFFGeHNRQmNkaEZLUnVEMmFmQjI0WHJ1bGhqdWoyTk5B?=
 =?utf-8?B?ZmZ4UEtGYlFiYTZJTktwKzNjOHRiZnNpd0FDdndzaTVmM1hkbGcxWFpZVGJW?=
 =?utf-8?B?NCs3RDZINVlRK0dZMEtGbkpBalJCY1EwcmZTTzBIYzFNMWZvcFYrMytrYi9S?=
 =?utf-8?B?dDNScnl0VXZWZWZscWRpQkJBM2dNZ2IxNG53eFBsZUNWQTQwenR2cU56cDZo?=
 =?utf-8?B?Zit2OUJkbFg4T1lVMjZGZkNkYXJjWlRhTXB0aTUwUkZoOVM2Q2FBenRDSUFr?=
 =?utf-8?B?YzhYUVVIa01ST2lSaFZmVEdwUWw5T1lFNGQ5Tzhsd2Yva09Gb3lnYjVzc3dL?=
 =?utf-8?B?SWVwSEM5cWNzNm1VL0l4ZmVCVVJPR3VqQ09zdFNPTW53ZU1Eby9oMWRzdklx?=
 =?utf-8?B?YjBMVWIwQ09QeFJkN2dQMDNiUm9ib1I3enFIWktGcmtlOHJMYlJ0SVpqbFRM?=
 =?utf-8?B?TXNYbG95NUpWajdNblh0b21mUWt4eDFkNXRpQ052V2VCY3FIQUFBQUFSZDZL?=
 =?utf-8?B?SzNWWjJXM3IwcytlbWtOV2VWYWJjbnlGdDlIYjVQclhvdHl3TWpObXBTamZJ?=
 =?utf-8?B?U3ZBYXBDdW1tM1NUTXdyVkt5TVI0am9VcnZNWE4wajErS0c1WENHNk02SnFo?=
 =?utf-8?B?RkVsSmVWbk1zUlUyR3F2bGgxNUM2U0hzNWxNQUhmcGd5N09QaWFBajlGVE9z?=
 =?utf-8?B?SEtnQUpxc0dMditRZ1I2VnByQUNFcTJqdlA1dkpTTXFBbm04S2lWNVozQzF0?=
 =?utf-8?B?enlTWHpSc2srbTZlYnJxK3h5ZHE4dm5SWmZIWEk5dHBaY2cyekdQRHRZNFpE?=
 =?utf-8?B?QnlrZHgzS1lNSUltWEFJOTVCSTlOZEt6Qi8zNGh3OHBpUU5sZHdZOUZ6RG1I?=
 =?utf-8?B?eitjNTZLNnBObmpoNFhWZ2d5VHpZaGF1UHlubjNRd3QzYXZCY0o5ZHFNR1RN?=
 =?utf-8?B?NnNVQmNLUHFlRFUyYWtvalpMWm13V1JZRzB4aXY1Wmxkd0dUSjU3MTBhVHph?=
 =?utf-8?B?M2Z2VXRmQ0FTdWxzRk82RFd2VStWQ3NpN0VUK1NqemZrazNsZlJpSHRnT3dZ?=
 =?utf-8?B?QWlHZ3hwZXJFVkVWbTVpL2dGc1ZJSVVQRW5zeUZtMWRaZzhBTFhidTh6NC9o?=
 =?utf-8?B?NG93bmpqaXI0Vm1IQWowZzdNSFcrWCtwYVlrQ08rZHdoZy93TlVlMTVuT0dG?=
 =?utf-8?B?WFpYT0dXZzdmRW44MVptY1dGaU1UeHFuT1g5QlVLNzZPY1dreW10eDZNbm96?=
 =?utf-8?B?YjArdkRkK3BvY3pQS0IxSUdlNnVjd2tLVmE3eDQrWG9aOTQ4SDA0QmI2QUs0?=
 =?utf-8?B?cE0zM28vVjN5eXZEOFEvTThtQnlyTDJ1L2tQQnNVeW5MRy9XcEszTUZ5TG9v?=
 =?utf-8?B?WGhHK2lSdU1PK3dRWW9lbXpyWHM0UWR2WWQwSkJLU3B3dkVnV2VzNEUvcngw?=
 =?utf-8?B?eTFUWDBFWDJqMW1zNzBORm5ZRmh4eWwrT0VqTC80WmlHOHdEaE1kQVhncGJP?=
 =?utf-8?B?Ykc1QnprOUpQdDMvYlBlOWhQVUV0WlNraU9QZnFHZFdsZ1h4OUZtdnJwYTFv?=
 =?utf-8?B?eUZ6N2lXSFRpK0R5cWNQS2RlbUl0V2ZTbGZ2WTVDV2trdVJtMnR3UklxSDUr?=
 =?utf-8?B?Wm04ek9QcnU3LythQmhVZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WmFGTVFwMzdYVkNZaW9hWnZRSjRZMUlIK3p5M2wvSDdDN21vYUp1a25MQ21N?=
 =?utf-8?B?UEh0ZTNQWnNpTmxWU0FwUDRNV3ZhVDJpNGJUeGJqeCtsTm9EaWZlVjU4S0VC?=
 =?utf-8?B?OHhYNDFtS3JDaGFEY0VpekxoTXI3UWZiNFEwK1Z2bmF6bWxnSWFLTERPOTBB?=
 =?utf-8?B?c3pvNlJsQzU0RjRaMEpsZEszMTI1Y1hWa21CQzhKdHdDYytpQVlNcUwySkZ0?=
 =?utf-8?B?Rzg5ZktyWXNvZnBmQXhVd2RoZG4zVm1tV3Axb3VDbGlxbXJ1YkZJUmUvNVFj?=
 =?utf-8?B?NElZbGQyd2NpNlFqb2tBUUhrcU8wMzJOU0dXUEdVTXJUN1hCSllZM2xuSk0v?=
 =?utf-8?B?OGwyWWcyMnh3STlyRjBrcDc4SGdOSjNoWWVsN1F0WXZGVXlSMzhETXNnZ3Nr?=
 =?utf-8?B?NXMySnpmS00xdXpYWlNuZTVBTlVzMmZzNkJCVkN6Y2FzclBnb1F0U1k4S3Vi?=
 =?utf-8?B?SUc1OU9KcERocndxUzlaOVVuYmliU0p3Y3RjWEdXeXR1NUFwWlp3NTN4T3JR?=
 =?utf-8?B?ZlgvY3RqWGdPcVZDWDZkenJ2NGRuY25RYWEweW1zV3RUdi9uM0hKOVpENVQ0?=
 =?utf-8?B?eVcvQUhFanlDSnpnYVRnVGZoSkxQN25BZnJtUkc1ZTMvNUpHcTdmNndqeDBS?=
 =?utf-8?B?K0JPWmNpQ0dXRkpIRkpsZlFjZFdXWkt3dHU3dVF2ak1jR0c1c3dTUmNFeU9k?=
 =?utf-8?B?Q3hkU05GUXJGVHFCTjUybzBTRzUrZS8zby9kZXh4Ymc5SW8rZmlQK0lreXB5?=
 =?utf-8?B?d3loQWEyVHZQdjdTVFhqaDJ4SU8xTTBnZlQrOUs3L09GOGp4QXBrbmRicy90?=
 =?utf-8?B?UmJvYjY5NnpXQitEZFJkQzU0b3E4c0t6cFl4bTVxNDlwVWl1TjFFT3hqVHNX?=
 =?utf-8?B?M3FOSnFWVEo1clBCZ2RTQmNOL3hLLythN1Nkc3NkR1puL0F5aWd2TTY4eVVJ?=
 =?utf-8?B?cEl3QVo2dGpZUDIzZkc1bEhlYk9kc0d4THoyRjZEWkYvKzdhTkJ1TFhPYU9J?=
 =?utf-8?B?R2piSWs3cG90SmZOdDBuSG5iS2dnanVvZjhKVG9JcjFhdGxGZStBd29zc2Nm?=
 =?utf-8?B?SFgwWjdiZURoRllQcDRabGo3eFVvaC9NS3RObTVkeEN4VERHekJXNFArQ1Ur?=
 =?utf-8?B?aGR2cVd2bCs3enZVcExVbEVnajFqVzZzQWJSNHlMS2ZIek45MVVrWWRWQWs3?=
 =?utf-8?B?TUM1TUZCS1pFYlpqSG5sWE9LM0IrVjJSR2szeFh1R1hsWStKbkdIQVBmMUxk?=
 =?utf-8?B?a1hxaWZYL09XS0puUnVkUmVhUVpVa0hObDBEZUlERjNkS0t5TEw3N3JtbFov?=
 =?utf-8?B?SHdUNzAxenpVUEM4ZFBRaGdoWm5QcTVFWUI1cGJxZEpHbXl6TFVsMW5Wbmt1?=
 =?utf-8?B?SmxvSHIxa1V3U3RiM1Y0L0JBTjVZc3dsRXEzQ3F6R3k0WEh3Vmt2OWpQdzJY?=
 =?utf-8?B?dzdaU0VuMGRBMTBBZjdNWUxydE1waTN3Q3E3NzRvU3hCMDR2WFhyS0JqazRz?=
 =?utf-8?B?SVA4MEhtYWNicHIxSFZaQ2k3d0cwTHhETVF6amV3c2JIRGF3bVEzb2l3MjZn?=
 =?utf-8?B?VTVuRzBrdCtlYUJKRFI4UGV0cEQ3UHVPbTBuN3dJczBOOTUvbndNTjBLdnRj?=
 =?utf-8?B?b2JNSmNBU3dkVDVpNGFPc3pTcEZCYUFud0ttbHZKVVJoR2hwVC9SellIRmRJ?=
 =?utf-8?B?UlN5b2h3OGdWK3FLRGFCK1VFVVRmeENta3ZkbXlXNklLQ0JnK3BLc1FIaTU2?=
 =?utf-8?B?ME9DY1lhU2x2SDRjQTk5aW40a1lTWkZibVlGaDV0eUI2L2gzNjdrVTJ6akth?=
 =?utf-8?B?MDh0ZmFGVlQ1a01NODUxSFRpU0xScCtjeW5DUkdiZDFMVkJtOVRUNHhCZGY1?=
 =?utf-8?B?T214RDJpK0l0a05wZFVoWCtTSnlCdGgzUjdSbnIybWlDYnQ5Z3p2R1E4M3J5?=
 =?utf-8?B?bFNLWVc1NlhpUS9ta0lUaWphOG9FbFBEUERMclk0bUJvZW9TRjhVN3REbEFs?=
 =?utf-8?B?elhEZzNCZklOaGhDR1dBMDArVytpdVY5bXZOeHhIZ0FocEZNK2dsMHhvS3VW?=
 =?utf-8?B?STZvNGxRWjhUeG9heU1tZ1YwdzJHM01ST09laW9iaEdSNmZ6bkxkandvV0I3?=
 =?utf-8?B?RkQyKzRrR2o3emRxSUhQMjQvTWd4TS8wUFNPYlVpNUpwaHhGcldYZXVwNFhS?=
 =?utf-8?B?U3c9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 2291858d-75ca-4887-d580-08dca4d83783
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 14:12:53.2635 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J5Ah2V4dxog4mBAzFEHYK3QgXWB8rBCP+P41qXf33iklkDg4z68jhTZDxU0muT2Jk1C4zOGE6YnH6Zd0EUQf2QzuqR7wDzjUmm5uU2R50ck=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10885
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

Hi Simon,

On 7/15/24 12:13 PM, Simon Glass wrote:
> Add documentation for the extlinux bootmeth.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
