Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49299D29DE4
	for <u-boot@archiver.kernel.org>; Tue, 13 Jan 2026 08:06:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94C73808AF;
	Tue, 13 Jan 2026 09:06:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=tandemg.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=tandemg.com header.i=@tandemg.com header.b="tcONxLZ0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F31E82C7F; Tue, 13 Jan 2026 09:06:38 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5130803F5
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 09:06:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=tandemg.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yanir.levin@tandemg.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G3ZBO9LwypL/EVbUBbBlmRnyIHKlpGXmERhYua9wZ2zBk3QXw7X0riJ4D/EKmhS8mLJGhBFwdPEp0ZZfN+cR0UmpxkpfC66DOaKrHovoE+sGuyd4YavW9dR7Fa+fhMX34cfp0/vDDh/+XGvo7Q9BwuER6B4iqP3telDTMRtPB/FjqnXCY3QJydHi2GcBocececQRN7t5c5XUEWDjI3DwrBX71ZXZMxcC+dNqeetrFtz1bFdhkH9JXE3tyG/n4S3nNqhHwljKYH/aFAqIJnI+4VB2bPSXRerAhhrZPHS3WPu4BGPZArYlFLIa91DAoqiVy4Mh4CqAca9A7OX2WHXFRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ylJZEA75T6nacEXGMvhSyYwWMIXh2GzPTgmbRsMIXVY=;
 b=tCVFuoGZNMxbd7K/cEskGFGdOYf9mNgyn3Tytwu5ZXJY4ng5OeLXtZ1shMJw6GFUu2JC1f+m64pBP7LZaRU4HFSt2SNSaXdKFQ8jbLdM3GGTt2Ns2lBLGSnrc9sgrf0Ign0l8aE3GYQl0Cc05UKWsFFfv9tBeeYwrUEMCm1nYf7STerO17c9wCG0sF8Cat22lpKfMA87hjA8y0Lv9mx7i236DsIfEhAqZU5Wpcdz1SF8hsepl2qZGzNbi6gOh974nn0Vw2jDCW3aPqGSiku6OgN+Ip++O98hCaXnLatY9NWdG6f8MBiwW+UbTxMEgvUTqtXQOxoJkkdCJ/RQl8mXJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tandemg.com; dmarc=pass action=none header.from=tandemg.com;
 dkim=pass header.d=tandemg.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tandemg.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ylJZEA75T6nacEXGMvhSyYwWMIXh2GzPTgmbRsMIXVY=;
 b=tcONxLZ0/o6JFIqs/FYPH8ovWxJJipUVWOktz1Gc2wympwq8nMcHcH6XWwr6yzclgKmS5FUmWZPZ0nGpxbcdlpZi5AaTtH/fQxF0U1a2Cw/T57wMD1eqtDzsmGtUFG6NHkt1Zk5mAR01BsOrx3ga4hiKlIpZNhumRmn6TudAtE2/aexGVvqG6phBhmfa5bRicHkiRaMTFeOa9+GG22AK79dal2maANVWdOIe7VL2rFN69W0ODhFXR453R0fskb6GtrAK/ZYKKjqcxW6y7EaRRUydFIzALuZGvAMbjjU13+2bY1R7QhadZkdnglaGUKhAj4o4DKjW8tYyFDqBNdz9uw==
Received: from FR8PR06MB10550.eurprd06.prod.outlook.com (2603:10a6:d10:1b7::5)
 by AM0PR06MB10522.eurprd06.prod.outlook.com (2603:10a6:20b:6f8::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 08:06:34 +0000
Received: from FR8PR06MB10550.eurprd06.prod.outlook.com
 ([fe80::e2b9:dc4e:b8b6:864c]) by FR8PR06MB10550.eurprd06.prod.outlook.com
 ([fe80::e2b9:dc4e:b8b6:864c%6]) with mapi id 15.20.9499.005; Tue, 13 Jan 2026
 08:06:33 +0000
From: Yanir Levin <yanir.levin@tandemg.com>
To: Peng Fan <peng.fan@oss.nxp.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "peng.fan@nxp.com"
 <peng.fan@nxp.com>, "jh80.chung@samsung.com" <jh80.chung@samsung.com>, Eran
 Moshe <emoshe@gsitechnology.com>
Subject: Re: [PATCH] mmc: Fix retry logic in sd_get_capabilities
Thread-Topic: [PATCH] mmc: Fix retry logic in sd_get_capabilities
Thread-Index: AQHcgtFZGJeSqEeDI0y6txNE6OKhA7VPviYA///4U2Q=
Date: Tue, 13 Jan 2026 08:06:33 +0000
Message-ID: <FR8PR06MB10550B9A121F6D24A93700CDDFE8EA@FR8PR06MB10550.eurprd06.prod.outlook.com>
References: <FR8PR06MB1055045DDF7D84047F34D2D6DFE80A@FR8PR06MB10550.eurprd06.prod.outlook.com>
 <aWX6Sjrdr-u3OA83@nxa18884-linux.ap.freescale.net>
In-Reply-To: <aWX6Sjrdr-u3OA83@nxa18884-linux.ap.freescale.net>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=tandemg.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR8PR06MB10550:EE_|AM0PR06MB10522:EE_
x-ms-office365-filtering-correlation-id: da636fd8-2a78-4187-62d2-08de527aaacb
x-ld-processed: cd9e0716-88a7-42c4-a82b-7a64f204926d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|7053199007|8096899003; 
x-microsoft-antispam-message-info: =?us-ascii?Q?OwcJ2jx8FXyYACyc4W+oPPgkZmpKAolBaasjWJZvXGCHKqsFQMXd1ZSWtIaR?=
 =?us-ascii?Q?lur5bee4vaklibo6zONToZITnY+3vENr0gIAbZLiFBf/3nKS1gWcPpc0X2Zk?=
 =?us-ascii?Q?/u6XAyscVOs4bOpGDf/YTjl8r13u1onJq6pQzSnGWYP0FfKSHdru8+B2QEkA?=
 =?us-ascii?Q?XJ3d9PtGZUMA0+se/GePRcQxxi8067WMw1qlcSUsXSdaBceNkqvVag/9lC8m?=
 =?us-ascii?Q?6L7KvzLXWrLu18Z2BhtR2rD4skN/BVnCgVsDpqgYiNvaQ9HHp8iYgc4c6ItT?=
 =?us-ascii?Q?uaIBnZQZ6MNqL01+tYdIfU2hH56/eQu8XuRgfTnhHW+5+fwH10gfG8EW1Y+u?=
 =?us-ascii?Q?acbHCw7zV1AFxK2EHKgUEzi9KWpz/vf0VjPWpPC1yjfR+iNhVjVCJOY6Kz2I?=
 =?us-ascii?Q?MYKy5CYtwvh6MWE88ZG+EJ2NJ0VgMWBPYjTIdDbn7sKVa8WN2wfwWeDxVrcr?=
 =?us-ascii?Q?/MtSwK9YAUwctq96eICyBYp1J6j3bImYvHhp2KgfosUHbXpz/RXb7iGL6ssX?=
 =?us-ascii?Q?f75bMmxPW+pPT6O5WLKiy3OQTyB6x14sKghrOjMJRZ6TqMo7NN+91pSOZ8CQ?=
 =?us-ascii?Q?Uu8HHKl06QkSirFqzBS4BduuDO9NdnbfOvPO5asG3KXC2+ShzxHFT7IcF3j8?=
 =?us-ascii?Q?IVsj4e3hyUnf5cT137WrZ4Geflo+bbWOrrdCpPIR4E3nGl0HKwzUok5fIs2i?=
 =?us-ascii?Q?33H1XTkA/b0OHp7+/X2l850y0Rg6K/uXU1NUVuLyXNfpjjZ+mMpV5hiBnEXR?=
 =?us-ascii?Q?8hRMYGLn9jbcoFnDnp8bOuQViRmm0WtqgDov3LfxKHx73QAl2IhEG0YJRizB?=
 =?us-ascii?Q?lmPDcuah43SuIcxm3X/v0vtPZH0JDnmCfuNYqh0WN4heQF9YHQ+xiKzab56o?=
 =?us-ascii?Q?l/b5ixKyBzUkzhFKmCQSD7BH8EZd5TsoTq3wAERS7gL6l+56O5Z1TPeLdWjP?=
 =?us-ascii?Q?jF2aUB+p05E793JIMPgfQ6U3mTawyivA5enUBvDURegruCbwzQuiBmvM3JSV?=
 =?us-ascii?Q?gvs7OLEgs3qOtVqk2s6DIcpw7EthEKDLLSB649O2pccj5uLLG6T8FWY3ANKO?=
 =?us-ascii?Q?AItl/Qhz4n9nI33tu5JZzOQgPnLVtuqkpY2/vWX7+Npp6VJUa7LOswUs01qV?=
 =?us-ascii?Q?Bca2LgqZ5auWWR/S+86FjdyvCLezAQ7vaMwv6UfqJdTu4WWE9rEUu6+At2J3?=
 =?us-ascii?Q?e/xIiruCy5+r+seL8q9mkz82FGilGFqiu5WN9VrL13KfgwjKQIBFkrCe12WX?=
 =?us-ascii?Q?sRAmlENBZXzwz6wTPfOp9xgASYjaXnuVkAItpTxv6p7Xo6QQ5wmb+hfBPCij?=
 =?us-ascii?Q?MyTqRwl2vH0EhhPVJRthceSAYbPzcItXBAuFo08b3yhkz8wpS7YkGYEvtnle?=
 =?us-ascii?Q?3lUxoDCXYDs/7ZmbANtwTL3Q/OZKShkY6eNFEzHxpf4wcJ+H2Eu48PqzcXkl?=
 =?us-ascii?Q?/X5keTzwOUOHtpzpvtK/z22FauUuWd7+ZMs0m4ujAIhxbH+TlwB8yhpTtk5+?=
 =?us-ascii?Q?Tfw5NA2PSaExvUaJjz6AiAorAKrRCUGx9w9U?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:FR8PR06MB10550.eurprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(7053199007)(8096899003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0EIh36uE4cRX2HGwwkFGGpMcPI2BUUTA5F9PAXh0q0cv9Z0IbsYlXlJdlUUq?=
 =?us-ascii?Q?qRg8pZ+HtD8VhDg9acub/pxyL8VoRJHKpwkP89Pd2t1dYWnnitbkg2FiYdTX?=
 =?us-ascii?Q?ELef4wJtOVLtRjCVXSkxI9fTMGuvhjHg0UZoWppIsZRNvicdQ0kpZdkHSXv8?=
 =?us-ascii?Q?5khEUKpEW98xTk5ydGRVqiiSN6eVqhjpeQzxPhk2hdWId39ULXb2qo97ZJsk?=
 =?us-ascii?Q?XoHvtDz3AH6v34fLGtya4xIPSY/d4rMQ1u5nL+PauJrzlwENCkFGzDHB6HGM?=
 =?us-ascii?Q?4Rsr0tO7B9d3ZVzxZZJamUnXudkt0rnbecnPT4+pT2FDZ2q8fWBrvuJEqPUt?=
 =?us-ascii?Q?aU+qxZRGKG5VvmJgUCinZ7S1QSHC6GBihUf8xdmm2xt2yRiaFua20dd7GTCk?=
 =?us-ascii?Q?IAI6EGusLRm+JrfBRZY4ma6V795vqbRdJzJTYV36ZmF5TlYoG9VtdrjNrh/R?=
 =?us-ascii?Q?69eXHmwbXay/3huEtdE50ryfw2gq96D4SqKWWXc87Q16PE52pAxyx38cu8y/?=
 =?us-ascii?Q?lxxkqOH3lbj66zKVVg33iIIeg7nSEJ40HoUMVy/pHjrj04ru2QrpRtU2v19j?=
 =?us-ascii?Q?PM8K3hhXNNfIt3WTZAttfw+A5VnIzGrBbdEES/EVL7PmzMxF6WoJPuoOOaGJ?=
 =?us-ascii?Q?fF328Ib5dpUIIR5Sx2HMGpZn89q5YPjxmN+SQE3D9py+ADrU7tkqYDixtzdm?=
 =?us-ascii?Q?jf8i7fbDyjkDLxWMjyKmaJxPohq7dwW8WyipHedZQSmDgdRtcZNZGuJfDVVh?=
 =?us-ascii?Q?iL2oH4SKVcgGUuCa7tstRNoJrM2Riqz4ZiAvHwDPwrfEl7LRcf3tYXqZNatN?=
 =?us-ascii?Q?V3yrKC5FFY4frzTYaNe4asDBE1MQSaVTMOK84y8SAg/yNzw/z14Y+VCdtJih?=
 =?us-ascii?Q?5iJwEAPrrfJDdbLMAN2Ykyc36P9Gi2EVm6r2ZoQMUYunqP4B2IU12nBUPVi+?=
 =?us-ascii?Q?0YyqcphByqH8n852W8K+zno8wa1yh1k3JomuPSM0FsqOfUmKxPTW1IVSIBqX?=
 =?us-ascii?Q?18zJ2oOSDVye81QcGBeRPJorETWzbr2FCAvTfjl8pBQoCbuv5zQhnWsUpPO5?=
 =?us-ascii?Q?mCVju291paI22RrbFE+lPF/X5AEgMziRExqX5RxG7Z/TATM5GnuPqV2CO7kS?=
 =?us-ascii?Q?LDbmPAm/SN8sAerhZh2PYMWyAptIvS9u7+OAYy7KV80aarzVeYpDfeoVpzDt?=
 =?us-ascii?Q?5viEQo3aWLGw6bY4pvCmrNmGe3Jp7wT5ES6mgKExwUVA+LCbgaXl+Q/vj6q1?=
 =?us-ascii?Q?N/q+WvlLK59mAcBI8tHbWSrFtRC676tb68+35k3N19E1H00ds78y7gV2p5T2?=
 =?us-ascii?Q?VZ7ZDEQaQn36fzkJbGYwUcVmVBvmXMfjbc6C9Hw/A7tsSFQl53Y/PECbDOBX?=
 =?us-ascii?Q?FeNrd7cj7zk31iNqRCDatK13PNE66C2kPCs0mvN8OSG1Ap1faIYR+b+4hiI1?=
 =?us-ascii?Q?4EnspQU8MoJxylmYxTA/C6L3jTo7LaO0PC2ErRLtEtSKM+Cx9B2d1xRbElPK?=
 =?us-ascii?Q?i/312rz6vbITSxUqLpO0x76pFMApJdEWGtP7IIh2re5e+r5cLQBZLG/9YREk?=
 =?us-ascii?Q?2kOQljWcBaUFmtfUhPL/7NEFsMD9Mw5FW99DhRcRwR0YDEfAZ/bFTv5mZzyz?=
 =?us-ascii?Q?pgt7ENQr82PxaZkv8u4KYH1GL0P/s45PpsPWhikQ0wE6UyQdoN4Q9siGNHoN?=
 =?us-ascii?Q?zvgHPbrCde2FV7VmJKUEH19S7/pvdr7Mmpo4tPB1tJ6XaNHVKCVu0+rgzLsx?=
 =?us-ascii?Q?i8QhatCZnQ=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: tandemg.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR8PR06MB10550.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da636fd8-2a78-4187-62d2-08de527aaacb
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2026 08:06:33.7520 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: cd9e0716-88a7-42c4-a82b-7a64f204926d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YTKiJPcfiR0ZOwbcPRaGzHf8Q2N1mmnT8gFPnW7D7SmnKItx9pmpZqFzuk3RD09Ry8WB2UeoDO++pqQ0KBwvlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR06MB10522
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Peng,
I did meet an issue with specific HW.
With this specific HW, we had SDHCI for interfacing with MMC.
On initialization, the first SD_CMD_APP_SEND_SCR command failed with a CRC =
error, indicated by SDHCI, probably related to HW issue or HW initializatio=
n issue.
After the first CRC error, no errors occurred anymore and everything worked=
 fine.

The fix in this patch is for the retry mechanism, which is relevant only if=
 an error occurs in the first place, not for the initial CRC error.

The issue with the retry mechanism for SD_CMD_APP_SEND_SCR is that it didn'=
t take into account that both {MMC_CMD_APP_CMD, SD_CMD_APP_SEND_SCR} have t=
o be sent in sequence on retry attempts.
So with the existing implementation the MMC didn't interpret SD_CMD_APP_SEN=
D_SCR as application specific command in the retry attempts.

Thanks,
Yanir Levin
________________________________
From: Peng Fan <peng.fan@oss.nxp.com>
Sent: 13 January 2026 09:54
To: Yanir Levin <yanir.levin@tandemg.com>
Cc: u-boot@lists.denx.de <u-boot@lists.denx.de>; peng.fan@nxp.com <peng.fan=
@nxp.com>; jh80.chung@samsung.com <jh80.chung@samsung.com>; Eran Moshe <emo=
she@gsitechnology.com>
Subject: Re: [PATCH] mmc: Fix retry logic in sd_get_capabilities

Hi Yanir,

On Sun, Jan 11, 2026 at 08:21:13AM +0000, Yanir Levin wrote:
>In sd_get_capabilities an ACMD is sent (SD_CMD_APP_SEND_SCR),
>which requires sending APP_CMD (MMC_CMD_APP_CMD) before.
>
>Currently, the ACMD is retried on error, however APP_CMD isn't.
>In this case, when the ACMD fails and it is tried again,
>the retry attempts will not be handled as ACMD, which is wrong.
>
>The fix performs the retry attempts on the sequence of
>APP_CMD and the ACMD together.

Did you meet any issues, or is this just code inspection?

Thanks,
Peng

>
>Signed-off-by: Yanir Levin <yanir.levin@tandemg.com>
>Reviewed-by: Eran Moshe <emoshe@gsitechnology.com>
>---
> drivers/mmc/mmc.c | 41 ++++++++++++++++++++++-------------------
> 1 file changed, 22 insertions(+), 19 deletions(-)
>
>diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
>index bf82c515600..c1146ab3648 100644
>--- a/drivers/mmc/mmc.c
>+++ b/drivers/mmc/mmc.c
>@@ -1389,25 +1389,28 @@ static int sd_get_capabilities(struct mmc *mmc)
>                return 0;
>
>        /* Read the SCR to find out if this card supports higher speeds */
>-       cmd.cmdidx =3D MMC_CMD_APP_CMD;
>-       cmd.resp_type =3D MMC_RSP_R1;
>-       cmd.cmdarg =3D mmc->rca << 16;
>-
>-       err =3D mmc_send_cmd(mmc, &cmd, NULL);
>-
>-       if (err)
>-               return err;
>-
>-       cmd.cmdidx =3D SD_CMD_APP_SEND_SCR;
>-       cmd.resp_type =3D MMC_RSP_R1;
>-       cmd.cmdarg =3D 0;
>-
>-       data.dest =3D (char *)scr;
>-       data.blocksize =3D 8;
>-       data.blocks =3D 1;
>-       data.flags =3D MMC_DATA_READ;
>-
>-       err =3D mmc_send_cmd_retry(mmc, &cmd, &data, 3);
>+       uint retries =3D 3;
>+       do {
>+               cmd.cmdidx =3D MMC_CMD_APP_CMD;
>+               cmd.resp_type =3D MMC_RSP_R1;
>+               cmd.cmdarg =3D mmc->rca << 16;
>+
>+               err =3D mmc_send_cmd(mmc, &cmd, NULL);
>+
>+               if (err)
>+                       continue;
>+
>+               cmd.cmdidx =3D SD_CMD_APP_SEND_SCR;
>+               cmd.resp_type =3D MMC_RSP_R1;
>+               cmd.cmdarg =3D 0;
>+
>+               data.dest =3D (char *)scr;
>+               data.blocksize =3D 8;
>+               data.blocks =3D 1;
>+               data.flags =3D MMC_DATA_READ;
>+
>+               err =3D mmc_send_cmd(mmc, &cmd, &data);
>+       } while (err && retries--);
>
>        if (err)
>                return err;
>--
>2.43.0
>
>
