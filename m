Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A948C43458
	for <u-boot@archiver.kernel.org>; Fri,  3 Jul 2026 02:33:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50E4E848BF;
	Fri,  3 Jul 2026 04:33:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="MuiUV9px";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA39084994; Fri,  3 Jul 2026 04:33:26 +0200 (CEST)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B490984857
 for <u-boot@lists.denx.de>; Fri,  3 Jul 2026 04:33:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WDOfdaEH7oVDUkQxWNWsYPhQgVPCVAgKG1sgR5dMuzMcPuengQ0x6LkxXv5vG/1uYlunCQRbZnW+qNnSDbu7na8YAY3dytemVZr0n1srSIfypZrdxYWPbWq6vdVTa83J2OQr5tXx5WoXoVxodpynhZRtAnULkMue3DTXXZNTyM52Po7uv4JV0gJPrV46o4ie/EXnVA+iqPzYA+k/qe9U4hx0IsTJRt84p5r5bzqyDpUZyf1SyX8m/3Vi0bmp2vZS8917SPe7gCAC6JpICbY7Z0t9sqVxFaRGKzwwAPblO97Sd8fcDV3pmnPxaDhoEJPjWQ3CHi+5riO8bdPTBLyKjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZlbmKdc8W4pZz4NMV3MO3XEFwKd8XWIPqcsqJhb2CZo=;
 b=dcfe9/BSTh77PxmrTPfyuFWOGOmxbEnvQUwt4WDJ9sDgBbx8+VfuBx1G2RQJO3ojEXsr49KlZpw2B1b9iURlpk2UB6yewOvhmUjvK67ddIEWgaQKFSVs1ZD5WA2Tnbz/hjU4x/m1Ve8I4XYKo/NbVl4Fqe02/xLYknkEvC8j4OAJsk1EzR1kgG4X+gILNTQlIOErkl6shkJxsDPQVg5NO1Y9tHwTqLN0vpd/2UH2jgzOJ6meyHEkuEkQQlC/Y4LXiSxOypF2FplLXJu/FCEhMbsT6rPwujHPIkw1nK3xoWvX86fjQnDMITzclU5r7t2ToSDAf3tpX/bEJiJCMEea0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZlbmKdc8W4pZz4NMV3MO3XEFwKd8XWIPqcsqJhb2CZo=;
 b=MuiUV9pxFudubZM+ZdjZtVLIg+AmE0xjKnYNQiHJ52i43IiZQ8NIhysiqTGcYSsYvtqE90iBdR4j6IaLWukjNz9o1viLiwjUsnEX+rD1MpzIEnwdh4F85Bn01osxs/Npu/HA32U82KWX+RvLk6HT55Aqil4AHs0IBWeeP+8noYjp2JZSJuYAt0m9+GNKziX2l0/vlohtYbxY2RXS6fUp6qaj4/whwwheTXzXEFG9dK5B3NDS16CmNT3jDP4/Nq7Jwr2b5R4LM/anFurvjZiVntMbjyRTw361bfX9vfQr600h4BxG56TJQFXBa70dJ7kC+CtLDzNWNC5RazQzaHdOCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by SA2PR03MB5851.namprd03.prod.outlook.com (2603:10b6:806:11b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.14; Fri, 3 Jul
 2026 02:33:21 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a%6]) with mapi id 15.21.0181.009; Fri, 3 Jul 2026
 02:33:20 +0000
Message-ID: <e3b9b218-1ef9-424f-abae-5ede71fcb8ad@altera.com>
Date: Fri, 3 Jul 2026 10:33:11 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] i3c: dw: make resets optional in probe
To: Pranav Tilak <pranav.vinaytilak@amd.com>, u-boot@lists.denx.de,
 michal.simek@amd.com
Cc: git@amd.com, padmarao.begari@amd.com, Tom Rini <trini@konsulko.com>
References: <20260701102754.345049-1-pranav.vinaytilak@amd.com>
 <20260701102754.345049-2-pranav.vinaytilak@amd.com>
Content-Language: en-US
From: "Maniyam, Dinesh" <dinesh.maniyam@altera.com>
In-Reply-To: <20260701102754.345049-2-pranav.vinaytilak@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0012.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::15) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|SA2PR03MB5851:EE_
X-MS-Office365-Filtering-Correlation-Id: 91a4a76d-fa9f-474a-2247-08ded8ab724a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|18002099003|56012099006|55112099003|11063799006|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info: zWUNE9vbQpLcrFXkpZGhJrnDOdhswsS863N6zTPi82f/zBszgrZM/IdxOZAWZgps56E3wndimR4L/cnWhE87BXjKuaEeRouiWbY18qJU612E/iVkqO9BIYU7XVL+u/sDTiekmYHh3SKSGSLo7+nmp20XPEIw0K7IfQafcw90FaK+u8m7WxvbLK+5sfk4pmDIw0nhJdLheSNSVFJG3rACbOJ8X+KWvKGyCz7A+fRV3z8pDekMhDKxvHIt9itqV1DIy9DqUo8RRMxGzWoJHepRI2h9C7wvqlVZiM36U5ZxEdGWiyW8tMNzwojHXlR+NB/MPi8bdtt6EGoB4vRJRpwdeu09FfjLF5m4HGmBeF0d/nZ1l1cU6rXOduuB+fXuUfvOSCqPgEloCt5uQWXNNWA3jOxusO+FvPJVjsk9p/QitXZqhk/asngFQa1d2zLlIz8ysK9xatr1x4QKQEFuJzWfJ5pjCETzcSE43pTRg11zMfBLPgT9/WFi9hl4B6Pl/6j3akvJCo4QKNA2yuSiUGniEtGh66ejPu3LkVsgIysJNcT9m6907okcmJL6269uUFOv+tCyJ6d4FHMAGLVJwg3RbtMe59Tvhi2Lb6kkiZHsA+ZKfZnaLaxR+4FiKuQd+kJL58I6BfgBfBPXWrhjbl8ToowTBK64UaUY3BMakj30gOw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(18002099003)(56012099006)(55112099003)(11063799006)(22082099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c29wWUZWR0p0NzNhUjdvN1B1elplN2c1U0VMZ2pKWjlBZVhpSG5QS1VvUjFq?=
 =?utf-8?B?elpnalBnVXlZRXJPME81dGZvNFBCU29LY2RuamdLdW9Valh1NkY3ekJDbnZZ?=
 =?utf-8?B?SGFLYWo3U0RkTkk0K1V5K3Zpb2VQcnNpbGRWTVlpOTFlcjU3UHhiUTRaQ2Fs?=
 =?utf-8?B?dVBwL0UrYXVUTjVSQmx3azI0UzE4TURNajdGWWcvajgyRVRQb1kvVURINXpy?=
 =?utf-8?B?WVJKZFdoLzFreXZKb3RoVTBFcFBjblhsN0h6OEM2YW5CTzJVMVgzRDZaaW9N?=
 =?utf-8?B?dVRWdy9qOWpwWkp5bHZ4MG4rdFN5WGozeGUrcjRCZ1VzK3pYbUJCLzBiYTFB?=
 =?utf-8?B?OFVYYnBTZ0c5YUl0Y0xDMFZZbFl6T3A0bzdUUUNLSGN4a0VSTWdzblhWVXlF?=
 =?utf-8?B?bWU1dURIckUwR1IxT1NMSG5NNzFYQ3hiTDUwdzNCNmZrM2svZ1FhWGxZSGxI?=
 =?utf-8?B?cmlKYk5rYmhLdFp4N254Y3dUZ2tsMktGeDJvN3AyMzM4aU05cHgxZ3ZqazlC?=
 =?utf-8?B?bEhSeGdESWtwaE93QS9BSE5sMFFXc3lGREZSbkpjZ0FFZW1ZV1VnWURYSnZx?=
 =?utf-8?B?QlB0OFBtbkxTWURVaHZvbFlNcEZodE1QWXJuUGMvZ0JnWGFiSTBOMklIZk45?=
 =?utf-8?B?TG0zaGVjSkpGQVNRSXFYaFNMU2xGRGdiMDRRRVhKZ0s1NXlobmY5Z1ZyVTQz?=
 =?utf-8?B?ei92V2FuYldmQnlsc3ZOSTVWVlM5a2FmZWlOMWhzdGg5UWFQbytSNXZ0eFFW?=
 =?utf-8?B?a00xUXlRN1cxSU1JS0drTkhleWJwZnV6b3ZWeStlcGtWUlR6dXp3VUJnQnFl?=
 =?utf-8?B?VG5zbVdPQWFlWVFYQTdzRC9YN3MzUzdqK0kwSHlKUmJTSUQzWjN0NndkTVFz?=
 =?utf-8?B?RTJOV2tSUmxMOU9mak5wWnFZSE02alQyL3dzbWVRSGJ2N3NwbmtTaWVLaWNG?=
 =?utf-8?B?S2pwKzZhR2EvUmZNZVJ3MjMwS3lHSVVtNmtYNkR0V0g1clJYUHhzVTg3ZllM?=
 =?utf-8?B?Y293NlZSd2Fock9wNnp6Yk9ybHFqVXRLQlRIaTVVdlg0SEdDam54MloyZ3Jr?=
 =?utf-8?B?TlR2SmJ1cjJkTUhDczdOZTZmT2V1WHVyenkvR0FyRWtDbm5lSjl6U3diQ0dz?=
 =?utf-8?B?M3BGN2RzWE02OEtaTU9pS3lJV1UreEVrRUF1WTBNZXIzRG45MDhtTXJUKy83?=
 =?utf-8?B?Y1RaNUpKZHJxSjJzai9PblFGVldMSUtpNWVqTXk5bHE2MmI0cWZiY2M4eCsv?=
 =?utf-8?B?bndCTkJkSzFhTXUzZUJSUFZLbnA0OGNhUllUbTJWUEZqYWIvdFJ3ek5GTkdE?=
 =?utf-8?B?b2JSbFlwZzVjT1NZcHMxSVVRSVBlQlRyajFxSW82WE9ReGRtb3Jnd0lKMmY2?=
 =?utf-8?B?MXlkMWs5LzRhZ3oxV0JhOWNFMTBuTmtBbjdQLzc3RHRUNmZZNnFxRWJrbjU5?=
 =?utf-8?B?Ym82K3VoenVWSEg1c1cvQWIwY2k5TnVuY0xSNFpONGMwMjY3OVl4clY0WU43?=
 =?utf-8?B?RmEzdmVjUDNkbmExM2VHaHI2cDhJUkNpdW9Ua3R5c0J0bG1uYzA1NkhnZm1o?=
 =?utf-8?B?dXNtOWg5c1B1dVJqSS9QZ1BjTXNSb0dQY1lhMEZUWTFZY04rR040eXdVd08v?=
 =?utf-8?B?RXNHTEs0NU10QTlGQ0lOSGlhTUlmNnNCbTJWMFJKVTRRQVB1MVl0bVBOUUtM?=
 =?utf-8?B?a2lnMVE2cFB2TUdHbUR2OXgxYTlyZFNsUlJzWTRTcjRkc1ZxeElNL0NSc3gv?=
 =?utf-8?B?TXgxU1FRYUdnMmRrVDd1dG1PRGxVR1ljbnhMU09waXFObytyZE0zUlZpaDVJ?=
 =?utf-8?B?THRmQ1BBTUw1NTRSY1NKUTlXenkxa29zRFZ0YzQxYXo5VlZTZ085eGZabnpv?=
 =?utf-8?B?TnA1NWx0QUwxWCt6Q2VPS1VwR0hnaCt4Tjg5bmNiZVVlMDJXSmJtR3UydUdT?=
 =?utf-8?B?TEtkaU9aVGM3bWpkU2d4TC8ya21OQlp1dTlQanJ5TzcxY0VoSEwzeDBRMG5o?=
 =?utf-8?B?NThJaDRqdnAycTRDLzBvQmFaeUpCWkpidG1jSFdDd29OYmNYZzUvMmxKQzVm?=
 =?utf-8?B?Ly8rMDJmdHBpWWxmRmszNWxNK21jdFJodVdzMm5PYStuN2Nxa2Z2M3liUlNw?=
 =?utf-8?B?cHkzUUk2RlE3d2FId1p4VXNxWk9DUmxBM3ZQWEhpYS9YOWZwN1NubmJHS2JB?=
 =?utf-8?B?NTYrdzVKQjN1S29sZEJTbGhQTzljdXdvVzJiSFQyVHJlbnY3bHZhejh4Z1Va?=
 =?utf-8?B?Zyt1WFcrV3lkVFR5SmdKeVBBY2VIOU11a0RBM1hGL1pVREdTenh6NTRYdWxu?=
 =?utf-8?B?N0psNGNNdU5KSHI0YUlwOHA5UmlFQlBPVUgxcmtPaFQrMVVZMW1sdk03cmdL?=
 =?utf-8?Q?DEKDeraBa3UkB6+Q=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91a4a76d-fa9f-474a-2247-08ded8ab724a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 02:33:20.6536 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TJkl96JM/5Ef1UNNhzN6D/JKVCFaEP+vx9FL7wDRGjYw7WJrgYD/zwvJ4iPL3JdNQ/01y65Xo/S376YEYAR5CJGTrsOWTlAJ0Qai1tp+Mlo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR03MB5851
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

Hi Tilak,


On 1/7/2026 6:27 pm, Pranav Tilak wrote:
> [CAUTION: This email is from outside your organization. Unless you trust the sender, do not click on links or open attachments as it may be a fraudulent email attempting to steal your information and/or compromise your computer.]
> 
> Treat -ENOENT and -EOPNOTSUPP from reset_get_bulk() as non-fatal to
> support platforms where no resets are defined in the DTS. The resets
> property is not yet documented in the DT binding.
> 
> Fixes: 1009c96f1590 ("drivers: i3c: Add driver for MIPI DWI3C")
> Signed-off-by: Pranav Tilak <pranav.vinaytilak@amd.com>
> ---
>  drivers/i3c/master/dw-i3c-master.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
> index 0c4af7e528a..384fd27b750 100644
> --- a/drivers/i3c/master/dw-i3c-master.c
> +++ b/drivers/i3c/master/dw-i3c-master.c
> @@ -972,7 +972,7 @@ static int dw_i3c_probe(struct udevice *dev)
>         }
> 
>         ret = reset_get_bulk(dev, &master->resets);
> -       if (ret) {
> +       if (ret && ret != -EOPNOTSUPP && ret != -ENOENT) {
>                 dev_err(dev, "Can't get reset: %d\n", ret);
>                 return ret;
>         }
> --
> 2.43.0
> 

-EOPNOTSUPP is the wrong error code here. When CONFIG_DM_RESET is disabled, the reset_get_bulk() stub in include/reset.h returns -ENOTSUPP, not -EOPNOTSUPP, so this check won't cover that case and probe will still fail.

The established idiom across the tree is to ignore -ENOTSUPP and -ENOENT (see drivers/i2c/designware_i2c.c, drivers/net/zynq_gem.c, drivers/usb/host/xhci-dwc3.c, drivers/mmc/zynq_sdhci.c, etc.).

Please use:
if (ret && ret != -ENOTSUPP && ret != -ENOENT) {

Regards
Dinesh

