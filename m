Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32978C3DA7F
	for <u-boot@archiver.kernel.org>; Mon,  5 Aug 2024 07:04:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D9378885D;
	Mon,  5 Aug 2024 09:04:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="TOx+ye6b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FC2588677; Mon,  5 Aug 2024 09:04:40 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170110001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66C49880E6
 for <u-boot@lists.denx.de>; Mon,  5 Aug 2024 09:04:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oJw6shC3J9aGl90n20rdgHRqdONEfKmJbeZu0x+Xq9IZPy743iXxKs3RVqQB+044ypij5tHsvZosn4n+hKcpC1vFuZsizFjX6d6BpIcAUpG2K0cH7GSFL1o5JE0elYnsF2rskeIkEJ5nIiFzr+IKO+n5/dPKs3v3NL7ScNqqbViuXBuiqvBArFge0V2NEh/ZdoHcRXKcJ3zx1sP6yUdgd594ksW5/SR9xBVUt//ZHuNMdftUVeYCIXzd4WYME9PS+ukpDrxShBPWihlOFzsX/MI6E8G0wOr7fdETJu1K320aVCKf8V+d/4Wy8ZPOBiUGCdRQzmA76X3hvC3gwEIPgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ZpeyW13pTZe2ANlBmAVhrdY3AqBYIbrtwPFWvzJjoI=;
 b=WxxEDHQQAVRVKQ0JS2x5DU25+N73fJhJ89n013PKZZj5l0jpULPB89iZFcaooyjM8++9MF+DTd1FA4yJJv7BlY8SJ2jm1Wbt+yB578hoG321iMVaLSe8s+El4ri7OuworEKd6JXhCTLoizyoPwOgRh2NYMFv6da3EITssGwLgIL7ab2lZZzomQH6UrM/Mj7l6ClXRADlHlJf5qw/WqQaQN1EOW4C0jLUTQU5hSHZRVVCNz2BDk/PckJWvIqJSt7ytHYoaWvXgdxd2EyluHTFXIFtHcv5ofpTem8QzhM5Y4zy0krxyBFlE+BenWsSSmbT0MT/xNCgJNPw/UvEXtQwQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ZpeyW13pTZe2ANlBmAVhrdY3AqBYIbrtwPFWvzJjoI=;
 b=TOx+ye6bFJby35y5CTRsyK1d8Qmt3qCLc1DozGy3TSchRIZYsSLYtWamJkp9jnx4C4plKmrYFREqaR/Hd7WxgqIbuPv1amt2io8igo6CJJZAGQO6kmH5qn5Reumo8EYoY7gKA8ZWqD3+8e9pNzM+Eq399z8+cjf8Joe9zCfA5OQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DBBPR04MB7820.eurprd04.prod.outlook.com (2603:10a6:10:1ec::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Mon, 5 Aug
 2024 07:04:36 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%5]) with mapi id 15.20.7784.020; Mon, 5 Aug 2024
 07:04:36 +0000
Message-ID: <cf976b9c-fdba-4e29-9987-da1577e3db66@cherry.de>
Date: Mon, 5 Aug 2024 09:04:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: rk3568-nanopi-r5: Disable SPL_DM_WARN Kconfig
 option
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tianling Shen <cnsztl@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20240802234846.2654274-1-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240802234846.2654274-1-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0079.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:78::18) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DBBPR04MB7820:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e36cfb2-9a2c-4532-0784-08dcb51cddbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cFg0TXJscVh1M3VNV0ZMWVBNVmpEUjRCMGdwLytxWGhlMnRnVTIzVjRJbHdX?=
 =?utf-8?B?YWZpZWJ3aUNvSWVqMGwvOEEvZTZpMllkZ1JQSEp0b0c4WnFZdmRnZlg1dWNm?=
 =?utf-8?B?UkFYdElrOWFFZlk4TGR0WnhPZGxJUVhuTWZ4VWVkRFFCU2VXTFRVTGFSeEUr?=
 =?utf-8?B?eklLK2xzUC9ZeEZ2bTlvY2NBZ2UvQ2UwZy9NVmM3MTN5NU9PTVVkUHhReXlS?=
 =?utf-8?B?UWk1eTN3OHhlTEYzeTBXMkNLSlRIL0RlTWYyQzNuMnVlcTNueXFvQlBYb2E0?=
 =?utf-8?B?Tkd1NTNFRk1FbFlZR2h6WTh4MzNwelM3Mlpnb0dESDg3NDdDVXRsN2p6eUhW?=
 =?utf-8?B?RENLZjh4a1ZqY3BhSWJEMkpzM2R4N3pRUjJROXJUTWtwUHdGYWhiSkdrQmt6?=
 =?utf-8?B?RW9XaWlrYjQ5UjlSQ0xJNko2Q25KblNSdityUHNrUWxjTVNKNG5XSDNpNHpV?=
 =?utf-8?B?dEtDbHQ1WDB4cHVoRzkwNWdTL2N4cmRNcU5uY2plT1hMMExQZjU1V2lJRGVQ?=
 =?utf-8?B?cndxcmkzYkVDbzAycmdsanVCTkU0WS9JSmIwaUFxeS9adDJlQ01ybERZYTBk?=
 =?utf-8?B?eDFLWDRXZWJnaSswMENIa1ErS3ZPeUlVOHBac0hsRnVhc2IySjZFajR4OUdZ?=
 =?utf-8?B?NFJOMjJySC9vSmdETUphYkl4QzZQN21kNC9kaXFqeGJpeXNVSWlUU1RCVElV?=
 =?utf-8?B?dlliV0lRUVZuQkNIVGVUYkszT0FvaXRpaW45VGRxUmpMYjk4akhCaEozUzMz?=
 =?utf-8?B?dzZoQWFzc2xRREpuMVlOeHF5OHcydWs3cVhLVzZRWWpWTEpTVHRSa1M5bUhH?=
 =?utf-8?B?b0Y0eGgvVlBhL2VyUkJOL3dPa0ZIZzFhK1lFTHVxVmlZb1ZGRVQxNFZMZ29K?=
 =?utf-8?B?ZHdBd0FjZ0RrQ1FBUlV2MFpXTXVzbllteDBaYnRQNmlpZ0RhYnFPOWJpcVlE?=
 =?utf-8?B?S1l4NEt6bjZObW1Jbk13Lzg5b1dGZXFHWUpXOFlQbjlBSFZuOU14eVMzVEgw?=
 =?utf-8?B?eTFiMlpzMzdJTDBHb0NjOEJpbStyYU1hK1V6TjRyZFAzU2lEU2hYN1pHWlo0?=
 =?utf-8?B?bHJPZDhlOXpxazh1cXhyUUwzdFRZODZNODRSZ1QvVEtGYkZjNDlsVHN1YmtC?=
 =?utf-8?B?OVF5Uy9MdnpkWDJtQXNxc1h3RXRVczJldXo4STY0TU1WcFAwZGdKWEphTjZt?=
 =?utf-8?B?dWJlSy9CRTBwTTl4VjBLaWhtUWtmczdxV0s3ZG9LSEcyOHdPNnB3c2VwL1VB?=
 =?utf-8?B?bjN6ZS8xQ25oR0Z5MzR4SmlZYjVlT21nSTRPQTZ1clRNb1R5bUphRlRKeFRu?=
 =?utf-8?B?MnhUT3Y5dGU4a3FDb2lmNHhmUmIwQzN1WC9QUkJjTGI2Q2xNNldKRjhVMy9v?=
 =?utf-8?B?UEJBRE1FcXliMXFoYVZ5R0NrckdPMzFoQVI1b21sUDJ0OFo4bXpmY1E3SlRz?=
 =?utf-8?B?NVNzSThVUHZKN09Ga283b09vTVZmelFOTERNUjBJY1Foa2wzWVhCdHF3Rjc4?=
 =?utf-8?B?UE13cXJiTDFnSWc0eUoxZkE4Y2FXZktFekdTMUtSdERBUXBGK0tYcHJOTFdm?=
 =?utf-8?B?a255elhXTG1Td1VBckd5QjhrN2ZtMXV2WVVhVC9mY055ZTQ1WmlJKzVydW5X?=
 =?utf-8?B?MUEzQkxiMklNYytSTkpiSEF3WWw3a2RraVJKK3IvTGpDck1YbkROZWZUVHFC?=
 =?utf-8?B?NmxZM3NoOTFOSXQ1WDhCdVB6MWpOMFJiQjZkY2VCenFlMWdLUk8xSVNoUGJC?=
 =?utf-8?B?ZUdrcXRUbEhNN0NyRXp3SDdCN2dhM281YVRWbVpoUHd1b21BR1FSeWpRVkcw?=
 =?utf-8?B?c2dVdWpZT2VnV3BOTkR5QT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGxjdkMzaTh2NTVYRE56bHhPN2kwc2t6eW9kUGpjR3Z3Um5uK3VFZHZ6OUd4?=
 =?utf-8?B?RlFUTlBLOGxFTHl6RHNlTjRkY3RTL2pLK2pHYTVnZWxWRFNkb3gzMG9YUldT?=
 =?utf-8?B?cGtjMnlQRFhTRHdHMmFiM2xRMUFGajBQNUx6Vm9ubytTQ3BkZDNxSVdEcjdN?=
 =?utf-8?B?ZUlET3czc2J5UDU1RjhGb3YzMDR1SkFKQWRSMnV4TlBXODlXWnJRVTJVRWYr?=
 =?utf-8?B?L2hkWmQzSWdZZFJLSzNZbFNWVGdjd2NpcWR6R2J5eVc5dzdJZWttNTkvNlVX?=
 =?utf-8?B?RFRuMjVuSXlxL2RtNUZRTExaK3lKcHdYekpSNTJnengwcVRabWtENlBwZkFi?=
 =?utf-8?B?L0dvYURyV0s1ZFU5Ty8rZmlPK0NXenNoS2Nua1pTUGhhc0dYYnV3a2JWMFlv?=
 =?utf-8?B?Z3c0RG9JRHcxRU9OSFdwZzNOWjd0UUY0VjB1RHZadXB5eDdLUHlybit5bkxh?=
 =?utf-8?B?QXdydEhNajhoZ09VanhlV2FUZjBUbXVzdFNXbEU5dUdIVkdFdXpITG1FaFky?=
 =?utf-8?B?dFZwMEdoVm9la3pRanA2TExBMm1YdHg3cjhid2tvOStxZEpaUUVGUVk1elJj?=
 =?utf-8?B?UGFIMXpza2IrazRCbFVXTTZ1MXlKckRDOGZaaXl4T0FvVytYdC9HRUtUT0F1?=
 =?utf-8?B?R2NFS0lUL2tDbGpmdHQybjE2UFR0TklHZzBiSmRWV3VscGhtQ3VxaWtnTmpt?=
 =?utf-8?B?TmdWS0wxd2hOMEE1QjBuWkhpc0kvSTRZaC9MejJUcEVtTXNGZkhVV0JrVmE4?=
 =?utf-8?B?eEFNTVl0TzM0bjhidzBSa0NUZ1NBU25CZUZWV09NaDhheXlGREs1Q01rN0R6?=
 =?utf-8?B?UEtvQ3ZiUloySFc3dTZZNER2VVpnc3NVVlAxQ0t1ZWs0Q3ZIRWd6SDFwM2c2?=
 =?utf-8?B?Q05sWDRmRmVwa1ExQ1k5OGtYZDd4ZklhRFNBYk1jK1dIblJDZ3ozdDJzWllY?=
 =?utf-8?B?QmlpemVEK2ZMWHF5T3VFREU0enlueE42UGNOdEt3K3Nyc25POTVqQms3blJU?=
 =?utf-8?B?cVRlZjh5M0ZPSzdlbXh1YjFIbFFjMURjMnhsa2wrU1o3N2hGblUvQlZaejMw?=
 =?utf-8?B?VWMrWXkzSWRiYnRsNnkwY0FJcU5TVWJpNzl4QnJnTEdoemM1OEpqcjBZSTFB?=
 =?utf-8?B?emZwcy9Bem82OGhFcFZwT0JVa1I3RUVaRG0xTkhad0Q2TWdDZko1M29aRWls?=
 =?utf-8?B?d3daczZvQW5CNUVHWnZrTVNJaTlDOURBdzRPWlM0dmQ2SXUxZlJDeDBRYXBi?=
 =?utf-8?B?cXhwVnZPK21nSU8rclpCRkNvUERyTVA2V01xYXo2TS9NNlpzRjJLR2hUZXN2?=
 =?utf-8?B?M0N5Y0M4RDJXYWNWa2pOai9CK2IycGFqMWJJYVlNZmhTNE81d0l4bmN2UHRn?=
 =?utf-8?B?eExTV05SZG9uV0Z6N2xhVEx6K1QyRVU2elFOTWZQa1dGK1VXQkZxUzlhSm1m?=
 =?utf-8?B?K01tdHlIaXIxUkhnWjFiU3VybzB4eHVIUTlQVjZLOXdUbGgwcXZaWkFQcjRR?=
 =?utf-8?B?cmE2L1ZTVGRrYUpNNlJHbjU2UE9tdy9HNUwxTThsUjRHQjRNMzhTakVFN3Nj?=
 =?utf-8?B?M3FXbFZJNWo4alAzNHc1NnFiOEo0bFpSSDJERkU1ZFIzQjhPa2wwTDg0cDNG?=
 =?utf-8?B?c0xGSjJ6am5zZjB3RjBTeGdnL0JiYmcycSt0bG1DTjlyYUREZ01jUG5GdjE5?=
 =?utf-8?B?SHdyaE1tKzNxT3lJZmVoZXhCYlNVdmV0VnBnVFhmV251SnRSZ1VNTmJvZi8x?=
 =?utf-8?B?QU1kMXdYSFNPTVEwNElFZW9XbTlpSTZVck9sd0k2YU1HMDFNSjJrWHprdU14?=
 =?utf-8?B?RzhkcHE0V00zNVVZTy8vK0dSOGhRWUVUbFJOOFZ0L3UyNVB2d2JtSkNYaUFZ?=
 =?utf-8?B?d2ZvQjhiclRhQXNGbXl3dm9DdVJteGthRVpQMDZDaUxvNjZqSHA3UVFjNm5m?=
 =?utf-8?B?amQzaHNxelUyTUhwQVhXOGlHSXBOcGM0R3RocWdvZi9vVUgzd3kzMkFBNEtQ?=
 =?utf-8?B?TWt5RmNHaWU1OWVXQlRldjNMYytZT2FaNUhJSENFNUEybjNKR0c0ZEJQTXYx?=
 =?utf-8?B?VEtJWFNYa0hYVFNIV09GOFdpMjh4cFh3UklOVU1DQjJEak5wLzJKdmRHcytT?=
 =?utf-8?B?V1pkb2pZTzFSMW1KYUNxN3NBL05yNlZRL1h5c0gwQVozS29jdWJSbjY1RFBv?=
 =?utf-8?B?a3c9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e36cfb2-9a2c-4532-0784-08dcb51cddbc
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 07:04:36.5821 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +wxuCKqVgsK4dOHpypQGwWRpDD5wz5TNwhZ1MMIQQUJjwuNFAnfqQ1nqZbSgarQ4TWp3tVbk/fzYPg/M0C0pi1z7UnB9KpeqxeJ7pGCOaE8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7820
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

Hi Jonas,

On 8/3/24 1:48 AM, Jonas Karlman wrote:
> With the commit 6afdb1585112 ("dm: core: migrate debug() messages to use
> dm_warn") use of DM_WARN/SPL_DM_WARN print a lot of debug messages.
> 
> Disable the SPL_DM_WARN Kconfig option to remove verbose logging and
> restore normal serial console output during boot.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
