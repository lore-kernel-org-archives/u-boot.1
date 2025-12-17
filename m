Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1B8FD65C66
	for <u-boot@archiver.kernel.org>; Wed, 17 Dec 2025 15:31:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30E6C83B49;
	Wed, 17 Dec 2025 16:31:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="BN0AYEgY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C640383B55; Wed, 17 Dec 2025 16:31:55 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B80B083B32
 for <u-boot@lists.denx.de>; Wed, 17 Dec 2025 16:31:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hA9WPQ82AiOtsSuPrkQldLWxou7xh95Q3AsNWDmo87BslQH+xgZk1U2ESBt5cE3KA09gHIkJE+U5xNr2P8+UKF/GKirS6VhUPg6rCTq4oP5OuIi20+T6van+EzwPDXelCV1gz5HgY+aSDeLaNZpPlffSLfVI2ahE61gm2Gm8VJGIXRJfxrbeV8hDoS1vhj/HwpgL32ztnFn/mA8LxD9LFfwg9G42tHtL+eIqvxxdNOeS9ZhKzkLtiOjoN4gA9kfvkHdYaLL+KrclOWBZAAc+RSg4wP2cI2OB5frXlJefWp6NvdJaa63gxkdzT7U3TeXQGF8E8Zr5wrmBYnvx6wwKbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TYk93epgK3XcQ4YHwx9+t1xyDustXIos2xeH/ItfT7Q=;
 b=swG6uyo2L3fvj2+A/IbOAkCshxU+pXtgBgvlLyelrsxfKyMT2zG3R4fCPIZlGhsKLwdLspWxx0o6wq3ZAp4515BoiGblZGpPNpPhFZz6x3J11TY90tSRmCKxs7jQt+gTKQZT0aiC7jDewNbkxEYcnxPZ+YaVEznqFb1bm5kFnRzhXH9Fkj8Z2K7EhMsCo4wKyPckP2mBPYBY0kQ0piYh90wRZ9RdbmKM2un4X/uf5a8X9CMs+MU0q2vMxeYxBxLs/tXbtTRVJGE+prpIZXtMX5jp54dXVl+UMNlHrYpPBY2YI22ffkai1xPAEZU+TM4ehh8q7KAK0mjaVWNp7lB+ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TYk93epgK3XcQ4YHwx9+t1xyDustXIos2xeH/ItfT7Q=;
 b=BN0AYEgY3VuZ5Cijy6b3EyM1Y1xi6dUVt1SPf8tI7Im54Z2v2kf5GhGLTqqZYh9llMuPsnojS+p1IvGdygqAgrg77npNEvLQJBHt89SeM74VpUbDe7kcFatrcRvBg4eSeZvrXmYBmQv4wqfkuAAGmkyfWWdopzozAvNLCFm2wKs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by VI2PR04MB10548.eurprd04.prod.outlook.com (2603:10a6:800:27d::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 15:31:50 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad%4]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 15:31:49 +0000
Message-ID: <1b86b695-aa04-476c-9d3e-a24d0040c65f@cherry.de>
Date: Wed, 17 Dec 2025 16:31:46 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cmd: bdinfo: fix incorrect Kconfig options check for
 print_eth()
To: Michal Simek <michal.simek@amd.com>, Quentin Schulz
 <foss+uboot@0leil.net>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
References: <20251217-bdinfo-lwip-v1-1-849cf060bf12@cherry.de>
 <393f39fd-0504-4f3e-8b2f-083433c894f3@amd.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <393f39fd-0504-4f3e-8b2f-083433c894f3@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0046.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::20) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|VI2PR04MB10548:EE_
X-MS-Office365-Filtering-Correlation-Id: 84055b82-9ef7-4949-0b69-08de3d81658a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z3VqMzRvWWIwTUhqZHFjWk4xYTV0VUFJWm9oRlR1djBNZ0grN3EydVpwK2VM?=
 =?utf-8?B?KzlkQlRZOHVvdllGSTQ2ZmJ2TEp3MHo2QldmRjBZNng5SmVGMm8wakNyWGNV?=
 =?utf-8?B?a3k3VzAxNFRLRGljNzBjamw4TXRldG5QWGdoRTJSNVdteVMvQXZHMlFBOXFo?=
 =?utf-8?B?SUtWdXNkVzhjSDM4MUx0MUsrbTN4cWFVWmZBL3NpbisxZ0xqUDBqUlhOa0dP?=
 =?utf-8?B?bEhGaDZBRzBYbjZkWDJDemZjd1p3Q2drSnJuRXpuSS9YaDB3U0Z6T0tUazdp?=
 =?utf-8?B?bTJwb1V0YUJmTGlWS21MNGowc0lxdEsrU1J2cS9FUk5LbTdSczgzSnVlUGl3?=
 =?utf-8?B?QmFJdGtOWTd3S25vOWdKRDZTTkhEN1YvcWF4ckUxVkxpUkl3VW9WeUg5c0Ra?=
 =?utf-8?B?Nm03ZjZaQ3k5LysrVzBqRlIrYlZXL0Z6SnpOMUFlT3lyYjZvQTVvdGgwSzIv?=
 =?utf-8?B?NzQwMGVJcnhsaTN3U3hHWFB5dHZnTVpjRmFjK0QrSlFXMGtWZEU0aW41YnlF?=
 =?utf-8?B?K3c1akN1NGliTk85RG50TzlvS204ZXZKOXl1ZlpMaGRBUG9DUnQrYmppWWVD?=
 =?utf-8?B?azMxcVdQNUtEYjB4OXR0WkVSR3hrRTQ4WEtOZ1VCaiswTi85SlFoQVV0Y2t5?=
 =?utf-8?B?V2FmL1lyajg1UWpkemJtZDR6UUZEUnIwN3FSbXcrVjhkQzh6ZkdOaStySUlI?=
 =?utf-8?B?cFdnd3liMHZnL2d4K2NTMjJ1dFF0U3h5eXhzbnQzZDRCMUFkNE9BN1Z1WW1v?=
 =?utf-8?B?bjNyc1VnbzFJWkpQb3NTbUplWDk0by9QMWxkeHNzZmE2blJtandiRHVTMnZa?=
 =?utf-8?B?M0hCU1g3RW11czFNV3FVdzBHd3kxamxORmRHL05hWEVBdlJ2UUdtejJ2YXBU?=
 =?utf-8?B?Yit3eG1sK0NISmlXL0kzSDdtM3B6MzhUZTdEV1J0cDhqUHhDVTI3WWxYS1Ex?=
 =?utf-8?B?T3NvODdlNUd5Znk4WEVNdDdEZVlUYUtiajlRL1dmaldaNDRkdzkwS002ZzQy?=
 =?utf-8?B?NVVWMFJMUVJjR1M5MnRCdXVKSkgzMDcxWE5LQ1BsZmlFaEMyNWxxMit5VXVH?=
 =?utf-8?B?SXZ4emdkcFZiZlRKMXJ3Q3U3SGRkclFUQTBPcm56QWZsakdqY1BnRTg5YzNM?=
 =?utf-8?B?U3RKVUJZdDE4ZFVLczFjN0treldQQ1lvWHZuczBUdWNJK3VqeklVWWRXa1ZS?=
 =?utf-8?B?S2w1a3NWeG0wSTB3TUJlUiszT3RSY05vem95eEVYQnQvS0FWZWpURXJyYjQ2?=
 =?utf-8?B?VlowODBxY0QrQmZYeGQxTlJvTm5BK0Q4azd4MW5vaDJjVUhRcFJ4c1pOY1NB?=
 =?utf-8?B?MkZaRFFqZTZ1ZDZYYnN0LzJON016NHBaTG1QTWhBYkovVGxCb09YQzNob3NP?=
 =?utf-8?B?amxCVmN5cjFBZ1FQSGZWYjJzRmxaMnBCMDF2bERpcjRoTzhRNXQ4VUtoamVv?=
 =?utf-8?B?R1NWNlhsakFNd2Q0RWd1YS9tMEYzb29FRi9tMWNLQUQ2cTBOamFacUpKd0Vq?=
 =?utf-8?B?TTVhMVd6Y1JpeGFET0FCekxpdE9HaFhEYXh4WjFNNVRLd1lLc0c2enF0Nldx?=
 =?utf-8?B?c0ZnQjVjU2RSVTAwT29veWQrWVZFTFBYQzUvVUNYQ2VxQ01iV1ZROXQ4NDZI?=
 =?utf-8?B?RlEvc3lpRkt6c0luMnRzN0IxWnAyd1lBOG9IRWg4M2ZCaDN4bWlhVTJxZ3Rn?=
 =?utf-8?B?SlBPYXFmMEhGSndENFhneThMQkp4VnJMZkRZV1NBOWtheEZ4L1o4QmJjVFg3?=
 =?utf-8?B?ZjV2ek5GSlFBeFlIeGlYVmRjWnJxN0c5b2w2VEloNXZ6R1RVeTcyV1F6Vm4v?=
 =?utf-8?B?ZUdwOWYyWlBUOVdIOVVqbTlWOXpYZ0dnNWEwM2ZucjJVMFdycXBFZTZ4WW9x?=
 =?utf-8?B?aFFzUDlWQVMrb01ycUZHd1c5cE1LZFNUaDIxNE1rYnp6ZlhEUzBseWpmdXB5?=
 =?utf-8?Q?HEKE2Dc5PHfSFjbda6iUyzr+PF26+x4+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0pWL1ZORVlPWjR1aDNUS0ZPeENFbU9CNFFiQ2tjM29hVVFHdjh1dkRkUlFw?=
 =?utf-8?B?WTAyZHIrcHp3bUNPOGp5Y1BBUkV4YS9OZUFITjFGT1dvUVBNYVVoQjZWQUky?=
 =?utf-8?B?Rkw0UXRPYUZjejgvUEFHR25reXdGUTZ4V0dVSDdzc1dnWEl3THB4TU15U0lE?=
 =?utf-8?B?TkpkWk93YndCYlR4OE9sdDhGaFRDeTR0c1Zpc2NwZjdFalBUeHhvQTRLUThq?=
 =?utf-8?B?OGR3N0NRbkN1QVNVUTE4TnQ1MStlNE5YTUtWZzdFNzlNbXhqMWtuWjNrQ01s?=
 =?utf-8?B?UGsvYUFPdVF5TkpEVXROS1RvR1Nab0hTdDJNODhqdURWR1k5S3YyNExuaFly?=
 =?utf-8?B?bXFoTmIwSXNCcXlLRnY5N1ZqejBVTTVObURNNWx0U25KQnZQSnlqZ2pkNlF4?=
 =?utf-8?B?eHgzaExJV0hiclBHaVhUQVdyNjNVTERZUjRKWGs4anBxNmNPeFlTcW5VZ2kw?=
 =?utf-8?B?QjdFVks3ZjdjUDdaZ2RjZG1MbVhFSXJQS1dJQlpWUTNrekRXbWc3azRrNHpY?=
 =?utf-8?B?ZGk5NGt1SGl2WURUZTM2VjBKZlE1bzQwSnF1NEZFSHoxSzlCRzBxUUg2L09l?=
 =?utf-8?B?alkzTWIyS0MzRXZTZXRjcWlYTU1mYUFsTjlOcEdWenJBZDlURi9vYi9JaDMz?=
 =?utf-8?B?OTRkUmVlRGgvNzZmNTk3Y0VhT3RibWdaZ0Z5Q3BDT0FySEFTYUVPR1hrZkRD?=
 =?utf-8?B?bnBnbWdkL2ZtdUtIUHAwTzFpelU1em1vVzJxZ2dYa1JOeUVWK29ZeUt0OFNh?=
 =?utf-8?B?VUFab0RKalJlbTJQMzE3S1F0V2Q3NzFFcmVwZ1p4QUI0dE9MUGpIWVhoWW9X?=
 =?utf-8?B?bWtXQklwVHJlTFE3RlUxaFR0am1zM0hQY3E5ZXhmWVRISkZEeUxlMUFMSFl2?=
 =?utf-8?B?dzI3SmptcWs3TFlGZnNWSnVyRDRyc0lYL1JFV1RNYUwveGZSVFFYS3U3MjU2?=
 =?utf-8?B?S1piWUQ5K3lZZ0N2SG82Z042NUZ1VmtjR0xtNVllQmdGZjd2YzdXMXIzMVAx?=
 =?utf-8?B?Nm44eDI0dkZuR2xOYUYwdjdXT3prUEl6TWVMdkF4czBrcG9GN0h1eW9aZUoz?=
 =?utf-8?B?dXk0L3NPNEZTUjZIMG5LZ3hoYnZQNXMzMFFnS09IbmVKU1ZOUVJraVowYW9s?=
 =?utf-8?B?czh1M1BRS2ZLSGRwblR4cWhEM3dFdUV1TzE0bTR1dXJDQlBEL0tDS2hsVGJu?=
 =?utf-8?B?bXNId3BTc3locTVGejZaMjc4YkpUMEhzMS9KeU9FbmsveTV4RVBYNDFndGcr?=
 =?utf-8?B?eWhOZzkzWjZKb241UGUyMjBnQks4YnNwajdMTTN4NWMwK240SnpiZ2R3YWlx?=
 =?utf-8?B?dFRieHJqRmtodFhHWnI2bGRPbnkrT2hIRS8vVWw2bjJ4WlliM0cyVHJGTEpC?=
 =?utf-8?B?d3A3aW4wRXlUd3l2S0d6RFFrZzJaZTVpaUFjRVJuQjhzZ2hCa01kajlPcEE1?=
 =?utf-8?B?WjJmck8xV2JFMjZHZzFtV0cxd1pBTEU0YnU5QkJKVlk5WHdHWmhpVktOTEFa?=
 =?utf-8?B?cDhMWnpNV25IekIrb2pMekNyY2xITEpwSUt2WVFOY0VCR2ZpeG96NExVaVBK?=
 =?utf-8?B?MkJuWTNnZ1Q0TlFpTVJNcjVrbzd4bWN2K1dNMXdtUHRZWnFrT0xQRktuTFV5?=
 =?utf-8?B?N0pJN2N2anhnOUwzZ29jMjdCMXpqMkhRUEplVGFPeWREYy9RWmIvVWNFeUNH?=
 =?utf-8?B?VDQ0ak1HSnIzWWRKZk9pSTBHVHpnYURPMll5VnQwWU02dzRBVXJTbkgvdDFr?=
 =?utf-8?B?bXRLUXp6OGZaVDZoWkRFMC9GaDdNRUR4RUNwb3BTMjZ6dEtXbUtURVY4WnEr?=
 =?utf-8?B?eHpmVFljSG5Qa2pzTDdXTnZpdjRpa0szaU1paHpZelhROGowSUpxNkd5dk5L?=
 =?utf-8?B?MmtyQ3c2UjZScFE2RXgvVkRiRUN0Tks5R2JBdU1ZaG1wcDYvUmdjT3UxZHc2?=
 =?utf-8?B?ZEJCU21LNGE5QVNZRUtJM2JBL3ZaZ1dlWU5nQW1YUXV0UkkyQmZyb2YyMUVk?=
 =?utf-8?B?TnlaZzM5MmlQVC9LWUpKL1EzZGoyQWxJQSsyRExaTStiYUg4ZTVDa1huZWlM?=
 =?utf-8?B?N0tOb25NRTc2VWhtSEhZL0tUZkpIWkY1dDRtYjYrdytjVGp3QVlnTThOWEVN?=
 =?utf-8?B?dHJSL0xiSDhMV0hYVy9FK3czdWVFWVZDRXlzVjUwOXp2NzZyOExhTXJRUFNz?=
 =?utf-8?B?bEE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 84055b82-9ef7-4949-0b69-08de3d81658a
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 15:31:49.7824 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: COw+OZ5dKDO/DZ322WxVgNhIpTHcY3e6taSNOfYgPwiM38l8d3puRVOt7eTLJQh/snsHeGtnZ5dr2tT+lOMpykoLEk2Uv5CknbGrQG6UUNE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10548
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

Hi Michal,

On 12/17/25 3:45 PM, Michal Simek wrote:
> 
> 
> On 12/17/25 15:01, Quentin Schulz wrote:
>> From: Quentin Schulz <quentin.schulz@cherry.de>
>>
>> CMD_NET_LWIP has never existed so it cannot be right. I'm guessing the
>> intent was to allow print_eth() to be called when NET_LWIP is defined
>> (NET means "legacy networking stack" as opposed to NET_LWIP which is the
>>   newest (and incompatible) stack). There probably was some mix-up
>> between CMD_NET and NET options.
>>
>> The dependency on CMD_NET seems unnecessary as it seems perfectly fine
>> to run bdinfo without CMD_NET (build and run tested). So let's instead
>> make the dependency on NET || NET_LWIP.
>>
>> Fixes: 95744d2527cb ("cmd: bdinfo: enable -e when CONFIG_CMD_NET_LWIP=y")
>> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>> ---
>>   cmd/bdinfo.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/cmd/bdinfo.c b/cmd/bdinfo.c
>> index 20c8c97f0cd..09fe8067642 100644
>> --- a/cmd/bdinfo.c
>> +++ b/cmd/bdinfo.c
>> @@ -152,7 +152,7 @@ static int bdinfo_print_all(struct bd_info *bd)
>>       bdinfo_print_num_l("relocaddr", gd->relocaddr);
>>       bdinfo_print_num_l("reloc off", gd->reloc_off);
>>       printf("%-12s= %u-bit\n", "Build", (uint)sizeof(void *) * 8);
>> -    if (IS_ENABLED(CONFIG_CMD_NET) || IS_ENABLED(CONFIG_CMD_NET_LWIP))
>> +    if (IS_ENABLED(CONFIG_NET) || IS_ENABLED(CONFIG_NET_LWIP))
>>           print_eth();
>>       bdinfo_print_num_l("fdt_blob", (ulong)map_to_sysmem(gd->fdt_blob));
>>       if (IS_ENABLED(CONFIG_VIDEO))
>> @@ -193,8 +193,8 @@ int do_bdinfo(struct cmd_tbl *cmdtp, int flag, int 
>> argc, char *const argv[])
>>           case 'a':
>>               return bdinfo_print_all(bd);
>>           case 'e':
>> -            if (!IS_ENABLED(CONFIG_CMD_NET) &&
>> -                !IS_ENABLED(CONFIG_CMD_NET_LWIP))
>> +            if (!IS_ENABLED(CONFIG_NET) &&
>> +                !IS_ENABLED(CONFIG_NET_LWIP))
>>                   return CMD_RET_USAGE;
>>               print_eth();
>>               return CMD_RET_SUCCESS;
>>
> 
> Would it be also possible to also update bdinfo cmd help to cover aem 
> parameters? (Separate patch should be fine).
> 

Patch ready, but it depends on this one (as I need to use the same 
checks for the Kconfig options to list only what's available in the 
usage text (and the sphinx doc as well).

Cheers,
Quentin
