Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8BF6D29DE8
	for <u-boot@archiver.kernel.org>; Tue, 13 Jan 2026 08:42:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DECBC83935;
	Tue, 13 Jan 2026 09:42:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="s8Un/3Pf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4783183885; Tue, 13 Jan 2026 08:54:42 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E47A083015
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 08:54:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yEcEMf0GDZr33H8TFMl16yRF1dtMNVPxMy1SfTGPa6Lzj8R4yp1f1phcuOpHaTW43h6cPO2nUjcoRdfYqKsqZueYa07omOhil3CP3WfEG66YWb7NXfVxwGSAvnLIEao4N1Pn4GMt0KOZlYndtCUITob/WTICRPPtjo0ME+rQpTOdRp+eVesDPCG2evYLc29fLp+ACUxiOrm5+JRJPjUmdadYIK0OIveIfcZViWFF3VlJ/di+3FNdguiZhJwMZ+sB7hgPMZszbfDJsq5oJq+7Jt32p6xlQvGdqjUEEdnkdAILdCxTz+q2LyWKfJRXFv7dfTTI5qT9SiJPnPYzPh16YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fx3izqdqzbeL/4bIFKamqCblyALTXzKcyrTb4GMnkKU=;
 b=JkBnkGtrwGCxd6jRK6hrcvbRZXlZAiaY/GCJthxpKLmv4XJ3l6te34fxy6UpPJymoBSonibNJRWntSORE1QQjfsMPHIrs/0gIXnhHPw7iBf3gyWjFLOI+PVwPr7sFxVIvYxgMXDHcEt0qSXNsnBApYh0sOuxDstaDS1sUOpwGgIVtSbY+p7imNBM6Ah2sA5qFzLIhEGhUsR/i0h2kn+1iM0FEZ0daeTWwK6NrYS8RyUEJIJEWlCeHXujUd+6JsHextbFF6Y2KMqTnqbbs/rmJv9KHIYfVW7G2+SqxU9BZHGvHIZVBcxHwA5ad9PWLZaTOKz323w1tRlFUnrgyWBVpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fx3izqdqzbeL/4bIFKamqCblyALTXzKcyrTb4GMnkKU=;
 b=s8Un/3PfS6iuB+W8wFKTsH6hUp0Oqe/XO7sHNuZUZb3IZyrvJdgPjwwAodG1ivENp3dwhLGliplAkqwPrNR8mWasq+fHfnblXhYmxWzXPS2jdyDo636LiabmCOTFbgZWqFoIMit9Rv8l6cCuTULBRWrcIJNsxy7nM7ORmpyGc+zeog/jHrrDN5wACrNTK1nVAD3D8gP4JxZ8BI6ZA8oyQZzeKd5l5M4OTakHK602KPLA7FGpcy9on23s/puL9M7Xx//SSv2sg49Q0I3u9sp37QBae7sVCUIZZ+nHlcz9Oka99e1SqsPeocDXDi6+AOktoicqAOO7KMcCAyqzRlhnVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by DB9PR04MB8186.eurprd04.prod.outlook.com (2603:10a6:10:25f::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 07:54:37 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%4]) with mapi id 15.20.9499.005; Tue, 13 Jan 2026
 07:54:37 +0000
Date: Tue, 13 Jan 2026 17:08:53 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Hal Feng <hal.feng@starfivetech.com>
Cc: Tom Rini <trini@konsulko.com>, Leo <ycliang@andestech.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 oliver Fendt <ofendt@googlemail.com>,
 Kuan Lim Lee <kuanlim.lee@starfivetech.com>,
 Wei Liang Lim <weiliang.lim@starfivetech.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v1] mmc: sdhci-cadence6: Fix the license to GPL-2.0+
Message-ID: <aWYLpaTf57RGiJQS@nxa18884-linux.ap.freescale.net>
References: <20260112023948.46008-1-hal.feng@starfivetech.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260112023948.46008-1-hal.feng@starfivetech.com>
X-ClientProxiedBy: SI2PR06CA0016.apcprd06.prod.outlook.com
 (2603:1096:4:186::22) To DB9PR04MB8461.eurprd04.prod.outlook.com
 (2603:10a6:10:2cf::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8461:EE_|DB9PR04MB8186:EE_
X-MS-Office365-Filtering-Correlation-Id: bd34957a-c3c1-43c9-8d00-08de5278ff50
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|19092799006|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9265Qqokisld48RItheGxxPAJandzOYhTmBkw84ivzt4zj4n61R8pzOVRWDz?=
 =?us-ascii?Q?A8qUcNNq92gsE09mBbmYwWRrnQ+P0pvMnO2NvscPyoL+c1BTrlWwgHlIVUIV?=
 =?us-ascii?Q?qIFUieQEBkHuab2VOCENfuRbBrzG/WqaKnFTXEKe4NHwHhK7ovoxrBWoKW2O?=
 =?us-ascii?Q?3U9//wxJ4fgYQNyOntr0Rof2+x5qi4MvVPC9senmhA9Ex1koID8h12QimnRt?=
 =?us-ascii?Q?8tbjjW3tUo2Hy4sw97SeGWjQGiEBxOfjfVNVsoYXCZmeNNhtn4c31r9JEKvx?=
 =?us-ascii?Q?MlD8H/zvP8haBBrCKmpqHxvXqPqydLT5Nm5Qz1JayboEFP6ilI54e4W+Ecwu?=
 =?us-ascii?Q?30Ug+hrOvPSZFWz9BhF6Ati1S3G3dFA7hVGVlvuRt+VSXzwdz5VZ7vWWOVGW?=
 =?us-ascii?Q?TiFJj68n/xvT1X45S6XAT+sDxOIPDKgKi0dvvLWyfX7o1FVVhtdYanxURkeW?=
 =?us-ascii?Q?cr3h/FCy4fP85wOYUL80nVPL1E7KemQE26Ry6giS94rMNNDakyhXKYfSMsgz?=
 =?us-ascii?Q?qDpWUddSxRszQ3JoVb4sLNv4GGJ3SpdQagr/DOal55hvz5K/Lh4ybNF8ZGJI?=
 =?us-ascii?Q?UaNypU1YJmfuizsQDntJoodOW0cVOlAjrWIBs0kon/ggfbjTq+trAO3RMv06?=
 =?us-ascii?Q?JxZ5/WJy+XMoe59xGtbBuvpafSuub4U1faLMfHBCzC3VpCDVYfkaFB3TUjxR?=
 =?us-ascii?Q?tztN7V+8BDiE7d/OveOihf9RIZEp3F0bEW/iunHJrImTfGkuE5grOB+NpUU2?=
 =?us-ascii?Q?f7uMPhh0raQEidTrfC0Nt6FJ2MFG37yTzYx5cuOrRs4U2iufCJy0dBiwJm9C?=
 =?us-ascii?Q?CyjDwQedVnVAk48K28EkSQUdsu09HRoTaF98eGdl28fvllY9+ZQ0TdjFToy7?=
 =?us-ascii?Q?VrXX1Nzx+aNrVGoOS14EsmNSFuj/03n8AkgqSUMrcEkotH5K6UUvCd7NE54U?=
 =?us-ascii?Q?xmxTLYWBm9Nor3kl2A5FlMHMG0VKySpJhIPhqk8UhrW5PzFxD0WCoX796G9l?=
 =?us-ascii?Q?TQLkHx1d3sc6EQDL8JLU21WMYzhsMzb96cw1ge+2slMRn8ReEai44xRrF79Y?=
 =?us-ascii?Q?frSV+uustm/V+Nocx64kKMwil5wXGS5BtAZfg2wV6+hnwsz9+0nJeeeJh5Vm?=
 =?us-ascii?Q?3eGkUD8D8mmVWP88TmrFDdG3hKX78bcOmRSHX7ddtfgdgo6jSTsYT0NegSfr?=
 =?us-ascii?Q?ipfHdop5oNyvaUT80ZdUY/VULz6JhfH8BG0bGRKeq7Os549CfULSIbvMibP8?=
 =?us-ascii?Q?cLLYpAJr+7DgvLT/bral+XUidk1s+eov7X4s/0SK1/VxXyo8MLEEF/xCQoNf?=
 =?us-ascii?Q?ElC1JVFLZQYj3i4hrdNaB5RHlSTSwxlaNWFCbz1ydNZLBRFo0E519zZgktwF?=
 =?us-ascii?Q?QsBS99UWwb/wkBFJv+OwLyhMZt5OzEDOOi7i6qW2lligOXpKyk8tJWHT+RFn?=
 =?us-ascii?Q?Bfayg3DXnnkrbgGqkOlf0xKSMqBMYbClDdPEBk1revIbvryb9BI8kyAT/Aqm?=
 =?us-ascii?Q?41hmshSlYqLPG3gqLmsYFa+Y90aOdjFvvNA+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8461.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(19092799006)(1800799024)(7053199007)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o8QWoS8ZZcBWuUA8zjgraV5/NxoO2Iw/NUktQsEnOyZu8X+EWAVnpvbkdNWy?=
 =?us-ascii?Q?vBJ7bFO+2BjmpFZ2NNOT0y8AQ9NkXlc850d9fWlDyolvZzYF/+F0lmth3Mxi?=
 =?us-ascii?Q?N993eujyQgVg9RB/+aGBoltLOEcfWj1h9OvI8S2ZgXfJ1URj5KQeLS6NnHBO?=
 =?us-ascii?Q?4fNS3HDolrll3bi2N+YCMufO8M5bWkXeM6Dr00NW05QcfX7cTuVzdYjVYTvt?=
 =?us-ascii?Q?h2unPQdUWmyR04lEqDnCtN3w1tqWAXC9gCSz8Rfwz7rKXTgDCdAVXCRR9OPj?=
 =?us-ascii?Q?XWpaWzV2w6kcdH+oIDNtbBms4DWQM5w3KZguHh1dJo5TGMBBqtLFYso/VMdI?=
 =?us-ascii?Q?wPeEjUtvBPEc0JfLqaX3NkWFY5+3adcpS7sMcFcX/JQBN9eAg7VMPAT7ghZJ?=
 =?us-ascii?Q?+wO2OgGXWhho9s4jO+PzypSGCtmE8HZlPBs1lGpIdKPNlFg60718462FF3FO?=
 =?us-ascii?Q?rkiAfW+QLfOnihddO8q2y+IkLxkEX5WIBCQOhrENVooofbN6EMAxb55Vq5mF?=
 =?us-ascii?Q?KsqmPSdMGe0rBIpfysSEoSZso65nCiJuLzQCORcpEKuue4PStbSC8JBq8wL2?=
 =?us-ascii?Q?mrtSnl0wqZaQrWclvV6NrZjSY4/pr1hW5gy7WnWSlhKHr1Op7gJGqfiQSOdJ?=
 =?us-ascii?Q?AKbiwzdG4R1HxO02YdMSXkYjDQaaJTlOooti2Qwj9s4A+sC8ZgDXOAICK0dp?=
 =?us-ascii?Q?skjMzdoWZz1b5ex6Wp8XgoJLpEiSwIq370xD66RqHI5pN4qGpHZSQg8y3e+D?=
 =?us-ascii?Q?HL52DshEQ9b0eMUiR140DibULXYL9pngnWuoP1O9JV6+6RSsSvyq/9dTyKME?=
 =?us-ascii?Q?WpCkT+AWIybRjwpt/uyCXCLtZGNhbdwun91nkTpyLEMp3mItKhBtoEd5aXDv?=
 =?us-ascii?Q?Ddkb4RkqAoi/OkPoihd6bkc7R8BvwqRTeUYXvT+TrWW9Q8GkVnMZVn/naKyJ?=
 =?us-ascii?Q?HZoTX6Kv5f21oLn6U+61Aflv1e94Eo1lrEgvmYDfBPur21ZP3AAEDGSm07Y1?=
 =?us-ascii?Q?ceLpmSnet+m95LNJ6teBzJYbmb8JOh6Xz5SZd1qH7it2EZtrmyz2iyiiuBm0?=
 =?us-ascii?Q?esv/b7b6Hh/oLWVqBvZ2cH0xn59J5P68T7c8GxwUtJP6cEmMPzq21HsHFUSg?=
 =?us-ascii?Q?l6LPVt1fpF1Ylrq4lIylXQk+ZJxv3TBUR0NzcDnmWO++47WbyrGQtrQsOZZQ?=
 =?us-ascii?Q?G8IOz1t9oi/7uk1edDuK6qlTlevxKtSRSX/h1gYvVk9CX8UAMi3ywbb20Egb?=
 =?us-ascii?Q?Qj+gyDeXSqnQXBKnBTQqJ91+ygyrwb/OB+JyI6ILVDlCJSJl7utgnRi//2zm?=
 =?us-ascii?Q?6gCKKT1eoFMYKEU5YN6ejsdDy5aL1x4aLi6b98a8cosoaMs3QTRrUTxUPkEy?=
 =?us-ascii?Q?SoAN6d1WrEXRV+nR9kBzJ3GMnWqsPPjAks7jirqo3eQAqK1ymykXutuaZh+F?=
 =?us-ascii?Q?7/5ZqF0RklO/oVpgzX33Jbue45JEleBl4dgDRXslpfzSpUznzJVrGvzvrhih?=
 =?us-ascii?Q?Ib466JICdONM8h81I4trA0U6V8fsqz3jOYVaRAujchm8XytvnfPQ3r73Eexy?=
 =?us-ascii?Q?VObMiwdoArdmzVfRJPfipSBb2k1VXaNIeshMaNSLLjIGvUBkEsXnti9HH0/v?=
 =?us-ascii?Q?SohsMVWZMLbAxlAT2IpnBz3p1G1slEoWkSu3g/BaEbn9AFikDDywg85t8oU2?=
 =?us-ascii?Q?OvyZIGM+01DT4tELM6uq4FsTJa4mYjgXTIVJfz8raPF/kTIdB/qfYMG/lmcV?=
 =?us-ascii?Q?nvewlzKyug=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd34957a-c3c1-43c9-8d00-08de5278ff50
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 07:54:37.2694 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8VFZFrNRgvhNV97c7D8wW5J7G8wVRxymMkTr9jIYa0boJxLUZO5T8iZ2Jx+R10jeRw8lCl9xJBp1NgObWtpC7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8186
X-Mailman-Approved-At: Tue, 13 Jan 2026 09:42:06 +0100
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

On Mon, Jan 12, 2026 at 10:39:47AM +0800, Hal Feng wrote:
>The license of the file is not valid. Fix it to GPL-2.0+.
>
>Fixes: fe11aa0b8ca3 ("mmc: sdhci-cadence: Add support for Cadence sdmmc v6")
>Reported-by: Quentin Schulz <quentin.schulz@cherry.de>
>Reported-by: oliver Fendt <ofendt@googlemail.com>
>Closes: https://lore.kernel.org/all/CAFoF8fC4foffYJgYm9CkViET83gDu05noVRxLxgs+KWXN_-LBQ@mail.gmail.com/
>Signed-off-by: Hal Feng <hal.feng@starfivetech.com>

Acked-by: Peng Fan <peng.fan@nxp.com>
