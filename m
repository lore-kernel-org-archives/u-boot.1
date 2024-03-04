Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1371C48BF6
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 11:34:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1581987F7D;
	Mon,  4 Mar 2024 12:34:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="ipJcNKbE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D601287F7E; Mon,  4 Mar 2024 12:34:24 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7AA1587E92
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 12:34:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aNT7ABvPHkFrgO8HNxJWNl22RUUZwXXYES4SpSjZFqUZg8ipE+BTmk9J9qMKCTQ19UxmNpwmrEZ/ykEMqCrSERn9ycOOkz6Z3XkMSKTq2McC3JI6UuiXdc3YG7svJ+IZWj8GVrlYGmThrUugUyugaaXVzxBMhApp+zaYREyJIVTZKAcW/hbztw0rdcQiCNAhRdQ1F5jZoYZ7hDU3ugz/cQbB3i4SJeS2ibEWZ80ZXBPlMC5pf8U4xIqNdU4TyOqdM4iNQ1e9NbEbeCtle6zr7Qp16vr84UKAt35vEanmUBTPGVMjG6znNaTU4jTckuGe60onRA7QvIKjM8jnA8f7Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mrXIjhYGupD/SqkhiVSYvxAKeoNDJeubg3wLBL4v2oY=;
 b=SzgvZJV1cJPUgr3URcIrukWp0Dxx0E5PuXqJCrOs75y9f1ImBHu9G/NRG+U8fvJF1QIOl/Ogen4smM3hMLnzKqbuah825jVnoDE9tqP3xnhHeaR/KCwGfXUGSTMti7YlFJhvIF4mxyVS+OYaZZNHrpAhbE+A4UTk9fCpIsoV/kStibJzSjL+M5alHMFyduM+XM9GGG4hmvwDXpvy5MpKFun3/qOPxx1KLGjIx+ngWkuPCZElmxBMvsCttMx7xAS2l+y/OAXNBfBMd9C+OKQPwcmbrr6ZTeY/aeqtO9hS4a5NIBnMz/BvkV7IyJfIaMwwUDweTBiDXg9i9D+1njhmJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mrXIjhYGupD/SqkhiVSYvxAKeoNDJeubg3wLBL4v2oY=;
 b=ipJcNKbEHDRpRWVvC+2sHwR++IY+DocXdohQLGp7cO+5MrM7ftirKTCDAzIEMYbo6lA2cnE0p9C1gQBOH0VkyIK5C45PsVIzgUJEPgpMjSkBXQn9mepSdSV9g93FC8FJKkM9oQRf0Jwsu4vvH0sRB7pTgAASbwbO43t71bAZcsXri7Q5I34O1cenlzkBeSq0GZ2ypT6rOUUul9Y0NxFK0afPAETgYg2b0jutBq3fWbTwk/I7TKkSr3fxcjCakqEAbXrcp98AfZ0EUVQH1tltBv0HOgqWt8qwtp8J1v6hTLRWyODfQqFbhrId8OqdQmhvJtdRWIxfBK6o6CHeRCuRHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by AM8PR04MB7220.eurprd04.prod.outlook.com (2603:10a6:20b:1d7::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Mon, 4 Mar
 2024 11:34:20 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::23:4118:ae4a:8dda]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::23:4118:ae4a:8dda%5]) with mapi id 15.20.7339.033; Mon, 4 Mar 2024
 11:34:20 +0000
Message-ID: <0e2fba0a-3bb4-4aa2-aaa7-33b15a6dff6e@theobroma-systems.com>
Date: Mon, 4 Mar 2024 12:34:18 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] pinctrl: Check pinconfig nodes pre-reloc status
 recursively
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Cc: Massimo Pegorer <massimo.pegorer+oss@gmail.com>, u-boot@lists.denx.de
References: <20240217120842.2381465-1-jonas@kwiboo.se>
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20240217120842.2381465-1-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0165.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:45::18) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|AM8PR04MB7220:EE_
X-MS-Office365-Filtering-Correlation-Id: 41f05251-da81-40f7-6a9f-08dc3c3f0861
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OCac0iBS8129prAU3nJIqFq7bHnuoHuGjYxyUBeEQC6aOzaBKkHh7trN4VUjj+kOi0qri3alXxbhRBlJxUCnxhs9CJxPdVF1BfBICQWv3X8X4c6i0hnIzGKC+Je8Eh2Ppyt0+vRicaJRI2CZio+4bZv0SfTTYejG4A3ojNFgYly678UQRYb+7nSdJZdgi9IB58KOOJa5YkbmjJIVMT6k72sOrKo87c/IBODd+JO9ZWmawuLEZdmtOItasd3n976Q/Qr+4fikP72qMGqUpjrSqKaUdRz8rGhqPdX+zJuZd5zF6NsCb3MgMSSh98l6/1kJJ17Umv+H6lIkE9FKRJ1KEtZTZ+t+QzwMTuQPNTX2FS3YNpTcNgmlt8HnkAUXzMMR2ABzCBZFeuUcjLtfeNziwFRYwVnop1+cdflsOTFIlD4tgx+c9+pTix9rSa4GU2Vtyz6r0Xosgi4gse5fDF+TrbtJNBJaRyfCmiMabM+1Loh6MlyANbLE4abZUE72BDQFl7kF3VMaRIyTzLyb4LwsDKvZ4PfAcFWfKpCXkv1nbqZFp64Be2fWJL5tXWQN63V3gUMpX/qRgTvlE3g+cpaI6deSzyoUekdNopFHirB9jcs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8536.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFc0bmlYakpsOG5NR1BXU0hBTnBNNXZJYW1ob21HU3lncEJXMGh6NjZLN0pI?=
 =?utf-8?B?cEdrb3JiaUNKV1BCZ1k1bThpNVFkNE5WbkpqQkhMeW54UlRwUzZVUUNvNXkr?=
 =?utf-8?B?K1ZUSlVjb3NtVUQ2NnRUUU5aT1RsOGM3Tzljd1dxWkpldFlTalRJUFM2aGd5?=
 =?utf-8?B?WHZNV3psYWJhc2wyQ09TZEpqRGdrdUlHd1d0MHFmWmppRTVxTTV0RnJaSUpj?=
 =?utf-8?B?L0ZzdnhCTFVoSjNsSjloQU4veVluYUlud2RXT0I2T2p3U3ZnQ2NrVnIvZGxS?=
 =?utf-8?B?ZVNwbG1rWitDdi9pcHFReDdRN2V5Yy80N090MWVmaWxJVjN6Q3FhdDExNXdU?=
 =?utf-8?B?N25VM20zVEFmWlN1SUk1Unk5RDRxVmhFUW1ZMWxPSXNLa0hYVXJIUGpWM0li?=
 =?utf-8?B?QUNxSFFNWDVPTElobWlUVjkwRURmbXJLV1BISkd2THZEQW80Wlh6WTlOSzNz?=
 =?utf-8?B?Rkh6dE1wNDJPZWwwRjJwQVJORHV1ZGU2cHJpUDh2U3ZrbTVNajJjaXdZZUpY?=
 =?utf-8?B?dUNyUXFwWnFrY29mWDUrTVo3TG9IMFEybndaeFJUcy9XbDkvK0Z3dFAwaW96?=
 =?utf-8?B?UXdISWVVcHQ4Zml2elhJZW00U1BxT3BscHcwTU9iUUdtNWxxL3h1OU91bExn?=
 =?utf-8?B?ZnU5RnJIbmFOREVQMWo2WTlIYklVc0tURVZWVkZ5K3Jqa1ArTXpveEhJRzE2?=
 =?utf-8?B?TzhnREpXQVozUWI5Y1A0UW5WRWVEZGl0bmdzbEs3SldmUmlUaXI3R0VIL2ZH?=
 =?utf-8?B?TnRxbFE2UWVLSDZ4N1V2Y0xPb2NaTC80Q25kWDF2VjFHOWVkcGp2L1NaNjV4?=
 =?utf-8?B?MXpEbjlXdE1BYUZPM243VWZRcFZyOEdMZWZCdEF6b2o0MmhrWUZSN3R6a1ZM?=
 =?utf-8?B?VlZQWElNQmNlVDY1Tm9DdGtRbjZPMWlvdmlRbzRZRU9vRnJjSXFVZlBBY0dl?=
 =?utf-8?B?MTVvOHBYM1JYMGNYdCsvWGxrR3JoYVYySkJnMWkvMUNXbkpaZFFNb0NCQ0Zq?=
 =?utf-8?B?QnFwelYwM0FKODRUNDJqSkRpbHpoV3dXZlJlKy9IMURoaUZlRkJIdmxseFdi?=
 =?utf-8?B?WmhENjl1SjhMK1pWaFZSeEpMS0NpSC9JU0xkMEVERzhuVllzUGtLSmhQbmFM?=
 =?utf-8?B?SXU2ODZINURMV21kK1J2U2cyQkhENEd6cTQzRnA5RE9vNVU5Y3ZBNGZ2ZDJz?=
 =?utf-8?B?RWx4cjZXOTRmNDUrRzgvL1YwaThEeUtSQjRnUFhXaFMwY2pvc2hjQ1pEK0tZ?=
 =?utf-8?B?M05abDlwSmlQUDRRRnhMMTFSL0xIVFNFSDJzNlVIVGx5UW9rRWw5Sk5hSzkr?=
 =?utf-8?B?ZHZJbG43VGwvYzdJZ2lJTWQrdGJkZkp2QXFtRFBiRitkUmFwMElHbGZCREVU?=
 =?utf-8?B?a1N5bXo1VU9uVU4xR0k2UXVCSi9WZ0ZTTnJkS1FrUU5QTUpzVkUyQjRyMzhl?=
 =?utf-8?B?K1kzUHVrY1REZHFrU3phbFNkR2VTUmROMUVLMlJsanhyQ2crK1FzMU94Z3lE?=
 =?utf-8?B?UXdMNFgxdkVFUmlLRWh6bmE1UUxoYWVBcGF4ZE12UVpNM2ZCVWttWDE2TGRm?=
 =?utf-8?B?MFMzTUtyZnhlRUx3R2E3U1N4SDdiQURmdVNmU29TOVlVMzZQU3R6R290cnJn?=
 =?utf-8?B?NWQxSEx4d2ExVmpiSEJIaXdYdS80M3dUbzcyRktMZTRRczZJRTBQdGtlZG4w?=
 =?utf-8?B?R0ZEbG1ORVhzdFVXa1FVaFFXeHBjRlYzL1cyWnpSeGh0dE4xTGJPd2FYek9s?=
 =?utf-8?B?TkV3VzFURHhsb2ZCNng2M1gra0lIanBKMVFmNFNKZDUxZ3BreGlTdytwc2dD?=
 =?utf-8?B?RjI1c1RGMGoxVlFkTElmc3VYdzFTWVM5bEhvVGI1N241WUNqaXBwL0RoRlJN?=
 =?utf-8?B?VUZzT2JhaEl4VjJNd0ZjQnc2OXF4TU1UamNYSllRQnNjbXFyRWN6MTRsWTdH?=
 =?utf-8?B?S3ZRM0tXNk4vNHBscnp2d3g2Qm9MWmVobDdVNnRwL1dYRis4Unk0eGdGN0ZO?=
 =?utf-8?B?dnJmS3R1SGsxU2hkQzZ1RllPUzBFVnRrTjRzazcwY1VrY09ycHJyWXlRTnF4?=
 =?utf-8?B?cHB2T3JIZWk5SlN5M2FZR3JoZGJNZ0JPUXhIOG8xSHhKZ0Zwb3grSVFDYi9Z?=
 =?utf-8?B?SHFQVSsrZU9rRWpjUE85ajh4dktMVTMwNXlvTVpNU1NPM1RMK2JXREtnZW4w?=
 =?utf-8?Q?qwAYgZooeZTDW2FVvOPfNJQ=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41f05251-da81-40f7-6a9f-08dc3c3f0861
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 11:34:20.3436 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0U+Cib6IG4EuZggcEZ/wS1ObMK2nAKVOH2t0tYZnyLv9joHwA7eX4Px4rVMps2EN7BpEcZ4mfrpFDKigkDk6tZ0z/XOcQE0HIGTQ2j6l/O66i/CrqaenuYM9fzfhZ9LG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7220
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

On 2/17/24 13:08, Jonas Karlman wrote:
> Pinconfig nodes normally bind recursively with PINCTRL_FULL and
> PINCONF_RECURSIVE enabled. However, during U-Boot proper pre-relocation
> any node marked with e.g. bootph-all will not bind unless its parent is
> also marked for pre-reloc.
> 
>    group1 {
>        pinconf1 {
>            bootph-all;
>        };
>    };
> 
> This cause the following warning message to be shown during U-Boot
> proper pre-reloc stage on Rockchip devices, e.g on RK3568:
> 
>    ns16550_serial serial@fe660000: pinctrl_select_state_full: uclass_get_device_by_phandle_id: err=-19
> 
> and on RK3328:
> 
>    ns16550_serial serial@ff130000: pinctrl_select_state_full: uclass_get_device_by_phandle_id: err=-19
> 
> Check pinconfig nodes pre-reloc status recursively to fix this and to
> make pinconfig_post_bind work same at both U-Boot proper pre-reloc and
> at TPL/SPL stage.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
> v2:
> - No change
> 
> A recent change to fdtgrep was believed to solve this however, fdtgrep
> is only applied to control fdt for xPL so this issue still exist at
> U-Boot proper pre-reloc stage.
> 
> Link to v1: https://patchwork.ozlabs.org/patch/1817296/
> ---
>   drivers/pinctrl/pinctrl-uclass.c | 18 +++++++++++++++++-
>   1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/pinctrl-uclass.c b/drivers/pinctrl/pinctrl-uclass.c
> index 73dd7b1038bb..fe2ba5021a78 100644
> --- a/drivers/pinctrl/pinctrl-uclass.c
> +++ b/drivers/pinctrl/pinctrl-uclass.c
> @@ -100,6 +100,22 @@ static int pinctrl_select_state_full(struct udevice *dev, const char *statename)
>   	return 0;
>   }
>   
> +static bool ofnode_pre_reloc_recursive(ofnode parent)
> +{
> +	ofnode child;
> +
> +	if (ofnode_pre_reloc(parent))
> +		return true;
> +
> +	if (CONFIG_IS_ENABLED(PINCONF_RECURSIVE)) {

You could move the ofnode child declaration here for limiting the scope.

I also got confused by "parent" name, as it isn't actually the parent 
we're looking at right now, but the node itself, so it was a bit 
misleading. I would have kept "node" and the "child" one is explicit enough.

In any case,

Reviewed-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>

Thanks,
Quentin
