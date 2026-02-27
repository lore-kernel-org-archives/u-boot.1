Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 346E8FD532D
	for <u-boot@archiver.kernel.org>; Fri, 27 Feb 2026 10:04:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03D7983AA9;
	Fri, 27 Feb 2026 11:04:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="okDuxzZA";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="okDuxzZA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9121A83BB1; Fri, 27 Feb 2026 11:04:43 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E02083642
 for <u-boot@lists.denx.de>; Fri, 27 Feb 2026 11:04:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jerome.Forissier@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=crgE0znspp2LGwH0QlOdIuMZSuNhucE7L7yZkVMaz8Pr5bxqZToAzp5jwsmq/tI72Xlk8kTvu/82mJPf239NOmUxbe3v1cOY5LFEcmwptACwsW/C070yyZMFAPnJ6L8kiFwM2R7JViuLfBJuMaBMTawFu7LV4lIDhu/7Zk+r+kRSMRtyBA7E5+JKqC0yNVYMAkB61C3wBi31AROqJ/hpGsno8D/p8coRdvUMtMZVEVWyU0wJzVJGlktp751asPvbWg1c32V7UwjyeWKbC/gLxL6iKc6kULHRehqTrrTtJFfFlBroX/oIx19GdCN1XkPFe7SUZ2aHd/dVIK5imF+bvg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cXyhGAZNEEfQlEaQEVO3ChQRe3WnTs2Gm9Py8RsimX4=;
 b=wyYvN8V2l5OReRxXmxqms8EIgmxQgZrEZDbdbEbZ3tZ/BSxjQW0kIuk5Nq2sl9kW0bHFF53Vm9w1X5JIQkCkfBGn/NhvzbTllS2kXROnbFjoNUxLOHh16oamn/gZxvcK+9pssmc2ov3TAV/rVB7cpAXKBXr/XWw4Ab+NJFT2zHPWVlRSyK3x5cyvs5KsjsqiZRR0qwTepLpRA6B983Vx1rZ3E8lHKS2u/4fd1rJWIuxtK2DYJKPCyxFmbjAiVA+ygX1Mxc+Gnxmy/P0d+D7pyIj9oaLraO/Z6O21mRT3P5Kb27hzWIIY+d3tIhbyivOpasZcYR0/udpd0WuyjLGt1w==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=canonical.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cXyhGAZNEEfQlEaQEVO3ChQRe3WnTs2Gm9Py8RsimX4=;
 b=okDuxzZAeWzGZmFZt+1BkdDNNPDTmtg0ErDbK+ZkQUDKv/8+9tTtfeGiAwASdIjvQkLh7XgUI25889VyZiLX6OWCCwhLBO17YXtj/KbblhvSAuqlAUxrt88pgLRLpeZ1dbP9XH1AlWxVckfqeoGyeiafB/H+JaSt/lJnhSq3TkU=
Received: from DU7P191CA0029.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:54e::24)
 by DU4PR08MB11720.eurprd08.prod.outlook.com (2603:10a6:10:63e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.15; Fri, 27 Feb
 2026 10:04:37 +0000
Received: from DU2PEPF00028D0F.eurprd03.prod.outlook.com
 (2603:10a6:10:54e:cafe::3) by DU7P191CA0029.outlook.office365.com
 (2603:10a6:10:54e::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.26 via Frontend Transport; Fri,
 27 Feb 2026 10:04:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF00028D0F.mail.protection.outlook.com (10.167.242.23) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.12
 via Frontend Transport; Fri, 27 Feb 2026 10:04:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RnPgUWtaClGnViAinOIasU2cea6tMWD33im7G0TE34wNjSNBsyg/fFMsrN/DpNwzXeN0tbCVlXmNt+45oxPb1FOT1YTGOzBtH7cE7rYPjaaN8ndfNKSK2o43onNWWLWcLf7XEQMR5LPsxLORFdO8kqQqkpg9lhFZrhsyW75WxtwSQQXw6IQqWyGuTRd11+v/E22vQ80p3brgP5LHBKfenYH+1OO4Ghxeufl2T1FrFi5XPqpwuOI7HghnvcVC6jlD0lXJ5wup9ZRnBbG6vCtPesxgEsRi3nz++mQq8ArgeU7UUn2aNiNspwns3VoTwb9NiXrgTZdvQ1FE7IKfa184JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cXyhGAZNEEfQlEaQEVO3ChQRe3WnTs2Gm9Py8RsimX4=;
 b=IEfk9LDAV+o6F4buWShpDNp2ThJC1ZfVOz1bnXN4jLrhOooorDa5DoRIwpWKBHvq1NoS2HuBy2D8bgaFAwhSw5C32Y8+zVUAjAnCt9wFpMxJuVct6BG44pQgFApOVMlmjAb4ikb3GRzaJa2DIVc72bj1bejZcjTptU55muM+1CGgO6XSZXj4rX6nR8bIyFtl/50eyytmrzGD/dLvIUPiA/q7H6hxW9bRrUzvpSyDltZNJwn7u824gwz0f+MinmiCrPfAYEwVSrl/bX3zvD8OcPE6QQVqoGaWPuBn1h8qgDJvR1AAuOHIsjz6gbWubTC45oUGROtoEyI3U3nbu2HAGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cXyhGAZNEEfQlEaQEVO3ChQRe3WnTs2Gm9Py8RsimX4=;
 b=okDuxzZAeWzGZmFZt+1BkdDNNPDTmtg0ErDbK+ZkQUDKv/8+9tTtfeGiAwASdIjvQkLh7XgUI25889VyZiLX6OWCCwhLBO17YXtj/KbblhvSAuqlAUxrt88pgLRLpeZ1dbP9XH1AlWxVckfqeoGyeiafB/H+JaSt/lJnhSq3TkU=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by AS8PR08MB5958.eurprd08.prod.outlook.com
 (2603:10a6:20b:299::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Fri, 27 Feb
 2026 10:03:35 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%5]) with mapi id 15.20.9654.013; Fri, 27 Feb 2026
 10:03:35 +0000
Message-ID: <45e3b935-6e0a-471f-b87f-6c03edd4f237@arm.com>
Date: Fri, 27 Feb 2026 11:03:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] net: do not use non-existent CONFIG_DM_CLK
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, nd@arm.com
References: <20260225061426.45981-1-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20260225061426.45981-1-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0198.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:36d::14) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|AS8PR08MB5958:EE_|DU2PEPF00028D0F:EE_|DU4PR08MB11720:EE_
X-MS-Office365-Filtering-Correlation-Id: dd5d8771-8dd4-4128-2430-08de75e79d49
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info-Original: YjZp/AjT1yhrd4uHYg1jXmo+pogTYKceqldeJ5kKo0DUzUbAtZ/zoemoch64EHeEnFyZZg1dMpgOM2RBgbVC7V7z7WETfIWBPGsYyU6BE0Mw/wG4Jgyqbag39xhNX05tKbAjUnZ9wxG8Bwa2hzJFTJ3MqSVjeW43RlVU6l5Owtu3NJmylHIH4WwuvkpWHLb1nc/bcnUgymivIdIDpp1Ktzf9+ZwCiULRji8VJ+dCbTFb1m6ylo0M4qaIkFi4DFiwqO9VpemEeSangyyaWmU+SYMsbvWjuKFDqpC2DCTlTtu3GZyuDoOGvWlfuyZ0dRvb7K7FwiSwX8GrUwx3IaAE5nZD4z5X/QjMUDebDJrZEhW+Viid9oV2eS0YOA/4Wx10AZU13heJyvr/ssYEMCDN68kRLIRZTFy5hkjw5d4fMzRsjLCq/8oBxWtymGpCojJ0LVjqIhsKk5hD0yTQBd++xYd9iK6u1yQDpp0gFjL7jhY3eadcw68LVN5tBJwZcXJi/RzorGApR9D9+/nUnAjM6ssCRLV9tclU3ne+qweZnDlyZRZkwfXpBE3ReoRAPt6dlf30cWA1ZReg1v58M6QSx2lvjVQ67jnXKT4wdWbDNxq0vXd6nilijgHFqf9thKYkVLLT6aDE8gChKZ5JMJLPzCoRukf3brRxzFQpv0FFBzKwx0WibSaGfvR1H5bp0b9+Du4p0QE0JfCrnJp2JwCOqbR3TayxjiZZEm1/uTHZga0=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(366016)(376014)(1800799024)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB5958
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU2PEPF00028D0F.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: d344f789-6e63-45f8-a25d-08de75e7786f
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|35042699022|14060799003|1800799024|36860700013|376014|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info: WbyMSvPLXXY9rwiV895tTvUf2Q+WP0qBV+AasMY4+UJ13+6Ua+nONGkaol85H2QD5cJ+BiwT0meoA0RWkY6+vZDc0YN2kGocAtFYUlC+MQZrwE0trBSTr60T/MuWY2WWpxa3c689YuzAPoO6pBbrcigYFzxS5hgaFt5/jsngrW2Ts8psgt2L81yn7Oy8t9D9nutC31Men04HMRvepKtP6CKSPIsqbLVJC9z4JAxendbA/DNjnpvgCEs6tA986xEoYrXjhC8JFzJyuqnJ9snd3Yxg10UB/azh25eP8YAbAVHjXpQhn3OtX2OnGpQawAyFr7VjPz+VvoT2ACeWVR2ok1BpkHYG6jP7ayIAN8KqE5oiDpXj/L5d39tXkUOhOsSFD8VTCU7+2qK8UJtbQjAGGrb1NIOVVyLINq6eGnJoilPVa1WI9Q46o6r+fUTxV4GDqfSUEvMH3tRhNNqiCA3MebcAL2rHe/rK/SoyqPINRf+UjfY0Qkop0DeM0jVMsJt4SMoMhrfWOPFrvQ9egue8N+VwcDDIWSLK8Hss8gIOsFY77MLwh4RO8/IoKHJNPO9neUssM1dV1pbsRDAXtOtRPRnAHhkHmpCKgIUFv14E7fG7TDZVVZZnumBxFWfWeGfNUojTbgtsOTDOnbOFLgrcpN41ONLdgK0ZlJ3zN7Mf2R9imgZSbqOJBe93qPhpEXBAoHsIJjwdG2THJuR823HY+h0G5idgpijX0w4sH2FWt/qb8SzMEUO6+Ra87bm9VXaIHS6j2xOx60DMWDbx57kTu81/8dMiTskyIuj4L+w+PMSuqOREwCr1tkdAU68riFXzp6v81CXDULRaqGi2b19RFA==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(35042699022)(14060799003)(1800799024)(36860700013)(376014)(82310400026)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TxBMyUczOO8m0826jBWHZL21gBA+Mjp8MEIv3rDMrUM+dyGpAsiG/W6+m0FPzBR5mjt6RAOItW6Uc3HeXs/F59nrvIX0dIgIAEkB+n/LKOKstjNaIsaAfwGoZbDTHEmacH1YXsx1faNWetzZ7aUYRVSb4CFYWD3n9kFoKOBmbeYkt3fXlg9HnTVxkMAogAS0iQ9rNkVNyzo3JRw4qBkOoB5fyBMMEdQccJlE3SNGfa12Oswst3lcCuU41STSF9Z/c4jjfmo93TKcVuxE5Pl5gOfpBeUQL/UP/c/N35TiZ8THnYPqAVLfk+Z5tpDnKgTWv466bRwaxzH5CwSizqW0QodhHzWn31hbxlVxX5g70oFVnZ4A8IcmdRsITAVF83ZV7zwSC/N39+Sim8Od24NCuLqqrsQRpsL2aptIxxLSUs3TgoH/+1h+tcyRLtfnug5R
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 10:04:36.8936 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd5d8771-8dd4-4128-2430-08de75e79d49
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D0F.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR08MB11720
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

Hi Heinrich,

On 25/02/2026 07:14, Heinrich Schuchardt wrote:
> For enabling the clock driver we use symbol CONFIG_CLK.
> Select this symbol for the HiSilicon Fast Ethernet Controller driver.
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> @Jerome
> 
> I could not find any usage of the drivers.
> Should they be removed?

You mean no defconfig enables them? It could be that some project
downstream depends on them though. But do we care if we don't build them
upstream? Tom, what do you think?

Thanks,
-- 
Jerome

> ---
>  drivers/net/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
> index d3ef050d1a1..17ceb7be57a 100644
> --- a/drivers/net/Kconfig
> +++ b/drivers/net/Kconfig
> @@ -979,7 +979,7 @@ source "drivers/net/mtk_eth/Kconfig"
>  
>  config HIFEMAC_ETH
>  	bool "HiSilicon Fast Ethernet Controller"
> -	select DM_CLK
> +	select CLK
>  	select DM_RESET
>  	select PHYLIB
>  	help
> @@ -989,7 +989,7 @@ config HIFEMAC_ETH
>  config HIFEMAC_MDIO
>  	bool "HiSilicon Fast Ethernet Controller MDIO interface"
>  	depends on DM_MDIO
> -	select DM_CLK
> +	select CLK
>  	help
>  	  This driver supports the internal MDIO interface of HIFEMAC
>  	  Ethernet controller.

