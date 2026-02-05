Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17023EA7963
	for <u-boot@archiver.kernel.org>; Thu,  5 Feb 2026 04:47:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85E1783A47;
	Thu,  5 Feb 2026 05:47:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="KXtS9O2r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 915478341A; Thu,  5 Feb 2026 03:19:06 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 363668063E
 for <u-boot@lists.denx.de>; Thu,  5 Feb 2026 03:19:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=qijian.guo@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gk+xKselNoSk5VX6E0YJ7Dp2q5tAMQSBaDxI8vMrq/c8jMLJNjcbi7nRiUZTSQ39zfLX2z0HyEpOqFWABt6rhF6pMSlmCxgNL/C9L62eFVwTgIWrDnQCY/8QnNKV/FYajf4QhtSs9Q2q87bnR2z4G+xjxsPdGY5b9V5tjMJGKdsAMxmFTNr+3WdOt6w+csc66dFoPphf7cqpEev7BpkrSI1S4/pF19AXbvuHD7T3shwhdBogaBmDAmxI+vAbzo7bGJy8YvpNEt1X4C7DnUQdJpLydyf777TpVdpTxj5yvsFkHYy/Q16aWx4rdlmSF55v4OLdzEkeD33pCxnI4Wt+4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pQxrMGWf1tvJIS13vop32Egtrc6iuf7EQ60/vas6k+I=;
 b=SICbIUG1WDd8Tgon0i9x3EyhNbCxLVjV0pBeytL5aICk3JYxLURtYaJWKFbyytyx7yS8yg3Ps49PgIm8VYt7CR/rtglHLnTGC8m/WnbwVDGQy3/EmvXmSh8er/8YWX1jFc0XmB+52o9baJhnCeGnfY23uPlYzwjNxihB8vWGGjKNOYO/WczJFTogEAmEgdhU27AqS6+DyQhSaQONckz6gKjSJ5aNYlnW+BJVBBZ0cm33/F4iOP5XGSxFJ+Qgq+6XX83iP/dsrFKZTkiqUB9niFMyvE+XICIaYayoxVH/uCX9w1lgQjcszBIp0F034rf36MrfAAzRxBHeTsIL0duXPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pQxrMGWf1tvJIS13vop32Egtrc6iuf7EQ60/vas6k+I=;
 b=KXtS9O2rScYkRXz0rqxpQW8AuYc7ZpFzQS14hAS395BVTbcM+LMU28x/Ls9TYHOu47yz10Y+l6b8LVlXAUZXv4RakMOQb+2Xn1DYz1Rts8HwWbNmU9gSEGjK6dkQ1akRTnV2d+lM3ER9W1PcWRmphCcACq//B/I/7/eULKbLMWmVPHhjg5nObN3rbwZIPGZQm3lz6VbPHyeMsgSxIjxVxjvEGyEZhOQwFBkG1DSRDM46fXkh06El9S+6BROiFKAsuw5nsz6NrKrKmV0Lg1bqjXIHAfD5ISj4BT+4WIYcbAnLB56Ietynhd4QDtXzrOfctk3EeAmOVsynR4DAy1lPqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MRWPR04MB12117.eurprd04.prod.outlook.com (2603:10a6:501:97::14)
 by AM9PR04MB8651.eurprd04.prod.outlook.com (2603:10a6:20b:43e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Thu, 5 Feb
 2026 02:19:01 +0000
Received: from MRWPR04MB12117.eurprd04.prod.outlook.com
 ([fe80::9a10:5b39:708:7f43]) by MRWPR04MB12117.eurprd04.prod.outlook.com
 ([fe80::9a10:5b39:708:7f43%6]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 02:19:01 +0000
Message-ID: <508597fc-f73f-4fbf-9a08-fad2f6c2eaed@nxp.com>
Date: Thu, 5 Feb 2026 10:18:45 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [EXT] Re: [PATCH 1/2] arm64: dts: freescale: add basic dts for
 FRDM-IMX95 in u-boot
To: Marek Vasut <marek.vasut@mailbox.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Sumit Garg <sumit.garg@kernel.org>, Lei Xu <lei.xu@nxp.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Ye Li <ye.li@nxp.com>, Alice Guo <alice.guo@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, Adam Ford <aford173@gmail.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Ji Luo <ji.luo@nxp.com>,
 Simon Glass <sjg@chromium.org>, Justin Jiang <justin.jiang@nxp.com>,
 qijian.guo@oss.nxp.com, xinyu.chen@nxp.com
References: <20260204-imx95_frdm-v1-0-85dc80e98a6d@nxp.com>
 <20260204-imx95_frdm-v1-1-85dc80e98a6d@nxp.com>
 <20260204135436.GW2603314@bill-the-cat>
 <2a4dfbbe-2f3b-44ab-8cd4-4bf7ce5d4403@mailbox.org>
Content-Language: en-US
From: Joseph Guo <qijian.guo@nxp.com>
In-Reply-To: <2a4dfbbe-2f3b-44ab-8cd4-4bf7ce5d4403@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0018.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:177::7) To MRWPR04MB12117.eurprd04.prod.outlook.com
 (2603:10a6:501:97::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12117:EE_|AM9PR04MB8651:EE_
X-MS-Office365-Filtering-Correlation-Id: 046693b0-5941-484e-25e1-08de645ced5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|19092799006|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d3ZBZWdFdTlEd0VxTll2VkEvYm5aMDd3ZjhUdndoQXRKRkc0TVNML0JNdWFK?=
 =?utf-8?B?WFFkRFRsb2c1VTUrQVBMQVpsak96YUZsdHhnMzdIU0FaTHVOS1BoTG5PaFo1?=
 =?utf-8?B?OWRBc09VTjlsLzQ3U1dpcGpJajBVNEdQQkw1cWcydEdGR2tmbDhsYkVMRHZl?=
 =?utf-8?B?Q1p0LytRQkVMOENwNktXcFhTNTJrcjRzNEREV2xCTjIzRDMrUnMvQUdnVGYz?=
 =?utf-8?B?RzR1eFR3SURncmgxVzhrYjJWa0VFTlVsOXF0UlRUejNpWFdadkhRL2dLWG4w?=
 =?utf-8?B?ei9wTy8wQXpMd3VZWmh3Zk15UjVtYzcxMWJqTVBVTlVkV2Rrd0h1UGswd1Vw?=
 =?utf-8?B?QlhwanQrK2k2RXVHSk5QNEhXanJsWnJYMXB5MDhjdnhTTE94TDFXMWpLVXhy?=
 =?utf-8?B?SFZyUmI0d24ybTdVdnY5Wkg0OFErOTJnc3VsVHZGZnU0RmJLbXhhdjFOWXdw?=
 =?utf-8?B?V2FXalJYL1BLdkdLSXNWbU43YTBFZUtGbG1JSHdYV2gzb2paM1ZJVDNqL0Ny?=
 =?utf-8?B?Tng1ZzMwUWNUN0hDZDBKUExVRVVwY3NFUStNUnhJRVVxQkVFRDZRenppd21K?=
 =?utf-8?B?MEJwNkh0THYvSHRCdHNrMTV1b2FQbUQ4Tk1VTXlrWXNZaWE3K1dacTdmMEpq?=
 =?utf-8?B?UVR5Q0V3K08rRzYvM0FDTHZRVGFtYWRTWmRwWGpRQmpWZHppemMvRVpzYk80?=
 =?utf-8?B?a3h2ZHlRNk1KVk1MMWdUbWp3Ung3SmM5amtpcUdxeWg3YytmVnBxTDBrcVUy?=
 =?utf-8?B?YzVvanJjWU1QZGxtVlpaUG50TVl0Y21oYk1tMm84L1kxWDRQNlZMSVZXUVNh?=
 =?utf-8?B?b1RxNGgvRitlTlBtUFRYaUUzQ01sM2xOL3VoQkJlR2dKVm9NNlNsbGdmdnA0?=
 =?utf-8?B?WnFVN2NnQzdBYkY1c05rdDAxcGR4NWFLR0x4VHhOMkcvcURIMDREM3ZPL0k4?=
 =?utf-8?B?U3V5WlNnNGdtMEVNTm14eXN5U0NkNDBVditjOUc1NXBmMWxtelhlVEFheVhW?=
 =?utf-8?B?UE1jSis0azBMNFEwREhiRVpJalI1L0prNHErNEtSQm54dnFDbFJNODFPOG9R?=
 =?utf-8?B?RU9sV0pUWE15M1Vsa0pueUJYMVZ5NFJ3NjFFcSs4T2xha1gxRmpyWEdOaUNq?=
 =?utf-8?B?QmlTcmJ3anBTZEk3c2xua0xTYzhQc2RYZEQ2QXZ6d3ozL0QvYzJnb3oxNEVl?=
 =?utf-8?B?alV4OG1oa0xQZGVQbXA3R0hRWjd4TkRPc0FyeWptZUpTUmRCSTNIbzBHTTlQ?=
 =?utf-8?B?dldJVGl1NHBra01JY0lwTko0Z0tWN1JZUjlYY3k3aE1saWYrWk8wK3dsN1lj?=
 =?utf-8?B?bzZEbHMwTnRnV0YxWW1xbWI2TnBoMGtBOGo2OUdDVDNiN3ZJQ0hlWjdUQWlM?=
 =?utf-8?B?U2p0TFI3cmhMNlk0eis5SmtlaEdYQ01kekFSRCt4a2s3MWJhaXIxSENyRnVC?=
 =?utf-8?B?RW5LNFI5RkZVMDJwdTRsRWRvcUZjc3NObnBrN0ZwS3Rhbk83NFVMNGpQalRx?=
 =?utf-8?B?aGFFaERCUDZnVG1jNENHMlhFK2ovS0tBeFA2UHlDSTl4cWlHalJqekt1MHNL?=
 =?utf-8?B?Z2RyTmRMczF0TDZqUjhEWXVQTUhQaW9IaTA2cENvdzJpckJncVBRYzJrUHNv?=
 =?utf-8?B?VFVibFRWNzY5SUtQd3dCMGUwelFDMlV0N1ZQb3ZDemZQc3RCNTV5eHVjamlh?=
 =?utf-8?B?ejUyaXIyU1Y2WHR3OFhiTWNLZTFGY0NicElXcTQrbFpEZFN0YUxmK09oY05r?=
 =?utf-8?B?NkRmUlRHcmltRk02blZvTTBiZ1lhWktTNXdlZ3Jab3lYVmpHS1pJNTZCblVr?=
 =?utf-8?B?SHZOeUp1QzlKZFoyN25BcHNSMjRIRXAzQXJxQmhQbnI1azA1LzkwdVdpWGZY?=
 =?utf-8?B?ZDRqVWk2bUM1dWhQL0dQZU91dllWM09xUVkrVi9vTUl6dTV0L1BidTQ3N29Z?=
 =?utf-8?B?blpvSkdvaGgzY1NwUDhsbHBuUWY0Q3QyVE02UXo2MUF1YmJpRVRPMVN4VDBR?=
 =?utf-8?B?UTIzUFMyWTZiT20zY1NRQnhCaUxRZFowclhVanorOVM0SzN0QmZqV0paTXpU?=
 =?utf-8?B?OElDbjNsVm4vMTdiN1pOMUdSc1M1STVscnRqOS9RVXlwcHR3YnhUaHNNc3Av?=
 =?utf-8?Q?3lsw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12117.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(19092799006)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TitNYTgxbnJqbDMvUjBrMUhBL1hWSDdMTDE3VlovVVNUc0EyY2ZDWG5Bai9U?=
 =?utf-8?B?TmhkQ1IxaG5pYXpQbDJ6UXNqcU0wb05YK2p0TFhlaUp0N3EzdS91THdOTHcw?=
 =?utf-8?B?RERTelkweGZEclNOanFQaWhIUUdhd2lBODhXc2ZseW9KY3h4dzNmVFdkLzd2?=
 =?utf-8?B?Z0NrTlVDRXlsWkk3MGQ1dFBzb2VxNnU1THh6V1pHRTFYcHdabUhwSEdSWEdo?=
 =?utf-8?B?YjZKY3g1OWxSVDUrS2xzalNXb1hUdE5IZzVjbWFQZzZTUFV4OC9yYXIvUW56?=
 =?utf-8?B?RzhyN016U2JSUUFIWXFjY2RjZXVzT1YxSDRSbm8rU1hvTmF2UUNod3BmS2d1?=
 =?utf-8?B?NnRVaHUySG9BUXk1ZWFQNjRQVTZOTzQzUmVqNzZ2TnMvd2ZTK21CWVA2eFpi?=
 =?utf-8?B?Q255MldId3Urc084VTcxQklHSlhvQkpKMDM5WFI5aDMrc3BtZjJGVEowZWsx?=
 =?utf-8?B?ZUpnKzdDUDJyVnZsMElJVmhESXJQeUJxWStBaERmZmhDQ1FNbEhnNWUxZ0k4?=
 =?utf-8?B?N2RxSzhLdm1MWFFxbEVtOFlMc2tkd1dDNmxBVnNMZXZremY0SDlnTmNxaHNP?=
 =?utf-8?B?TWRwYnRFclY3OStadWR2eDlGQlV1QlJPS1Z2QndrTGJOYjZ3QkQxM3RHZytZ?=
 =?utf-8?B?MHIxOEtjb3BWVzhlZVFiazZ5RVJ1MGs1QkFEMzNWd3ZxQzJiS0VoNjZKMTFl?=
 =?utf-8?B?WWdGWE1uZWxRRXcxK01PbVoxOURVNms5VE1HeDllRVN6VDhCdXdkeHc2cTgx?=
 =?utf-8?B?dlNLNlNrdVJxNXNkcHpnZG1Pa2MvT0hNbE5Md2NsN1FZNlRNV2hVVjZuWG44?=
 =?utf-8?B?OUlKMHoxOGVySGJ2MFIxWElxdUdDbXR4L0hrM3liUy8vZ2VXVWYydTd4bjln?=
 =?utf-8?B?SG5UdVpSNFZ3cmsrdThvUVQ2TXdKQWdVd3FlTmZCbHZwSWRCYW5XK1paZXFJ?=
 =?utf-8?B?djBQRlRuK1IvYXhqTmhnOWQvdVlJU3FodVBYNzE1ZDY4RU5LRFFjenkwUm9x?=
 =?utf-8?B?OU82RHhWMDBGaWVIVmpHZmNVVXduUlJIRk9ObjYrR2tVeVgrdk5xTWNFWjlU?=
 =?utf-8?B?ekFsZnpYWDFXWFlDQTl3bnU1WnpGYkpnQkRsNTJML1IvQ1FYU0F5d2Q4dk1G?=
 =?utf-8?B?MUpPTGFQM0xHMmlMRnp4aWsxY1ZwcHE2VUc3QnlRWS8wMDRZK0lhWFNHc2l3?=
 =?utf-8?B?bGNzT3Y0VW5GNm9NSFdYbmxFeENQQnd6NGp3Q2JGbkJNajBmSmJ3ZmMydEdy?=
 =?utf-8?B?YXFFYlFxQTNiM1hCYnZMOFEwNXdIWnRUaTNPUG1TMGZ0VkZ5MzQwUis1cjNr?=
 =?utf-8?B?dDQvN1c0ME1xZ203UndFUkQzV2NCbXk1OHU2Y1ROY24yMnB1Y2lXY2t1NFMx?=
 =?utf-8?B?eGc2U3JjRmM0NSs0MXlXcDczZThORVptbGJpL1dTMThzUXBkQ0tRazRtOVE4?=
 =?utf-8?B?Z0dsQ0gxQXdSSS9JWEJNcnJXZzlzMGFrUjl2bFU0RStpM1piOWZJZDYzL1A2?=
 =?utf-8?B?L0E4L1pTMEdQejExTzRFbVlzaHpwSmQzaGF3bjVFWUpiWkRPaHRNaEtJVjNC?=
 =?utf-8?B?MzAvREJ6b3Bmc0JZclkxaVRDa0dCU0l3OUJ3UTBpUHdBM2NtSHE0dXd3anBV?=
 =?utf-8?B?dkUvM1V6NXVJZzJ3eG5NWFNhaU0zYzA1c0RtdkJNWUhWRkFhOXJZcEVRVFV4?=
 =?utf-8?B?ekFXNk80MEVWVGRoSjllMlY4RXdDZk9CS0hRenNLNkNQWndPY3ZwVUp5cG1S?=
 =?utf-8?B?NEdCU0VnRCt4aDNpR1VmQVdoN1pwOXljL3E3d0RlUW1tdmNENW80enBDNHRr?=
 =?utf-8?B?dmdqQmpaQTJPUlVGUnpKZm9BSEtWeC85WjdsUUZwSTJwQTVKY1J0bnNFM0Zv?=
 =?utf-8?B?MmlXcGw1THhQUG9kSTEwTVlrZkxOclVISXhLT2lXdTZ0eXpES1FsblQ2YzZL?=
 =?utf-8?B?T2FYa3dvZDNGUFVIZTFNSVF5enV1NElrUk1NYzh6QTF0OWVsbmpFZGZhTCtF?=
 =?utf-8?B?dnpBZzF0RFVPcFpuaE5iNHk1U1R4Zkl0WnVlZjJIRlZFOTZuWkp4ZlpjTU1z?=
 =?utf-8?B?K0QzM3lMMEdOcnNSSmNrVVk5bHppNk5VMTZJRWQ0dDJReCtOcGFGNzBtbllm?=
 =?utf-8?B?aGhJU3dyMk56WTExR0krUU9xTmU5cGFYQ25OcG1lQ2hGVXNYRUJPVnFIejVE?=
 =?utf-8?B?RVJpOENBL2ZUeDA2OWRJM2xCN05Gc2RPZ1h6T1BNYStCa3RRVFAzZ20xYXJH?=
 =?utf-8?B?RzVMdE1zZkg2aXhUUnpsRXpXd2pxZzVwK2R3Y0RtdHZyMjFhQmhQREM2am1k?=
 =?utf-8?B?R0MvaUwxM0VjeUhORm1ManJVa21CQ2IvNW42TmtRdWE2cWl3c3lYQT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 046693b0-5941-484e-25e1-08de645ced5e
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12117.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 02:19:01.7524 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8OvRubwH8JgIwWADIENYCEvi7CUz+eXDW2YqwjUudW9d+1u9sxKmE2lPZgtWqBKYuOUjxgm9eWjnTH8Qpz65Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8651
X-Mailman-Approved-At: Thu, 05 Feb 2026 05:47:52 +0100
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

On 2/4/2026 10:23 PM, Marek Vasut wrote:
> Caution: This is an external email. Please take care when clicking links or opening attachments. When in doubt, report the message using the 'Report this email' button
> 
> 
> On 2/4/26 2:54 PM, Tom Rini wrote:
>> On Wed, Feb 04, 2026 at 04:47:12PM +0900, Joseph Guo wrote:
>>
>>> Add the upstream device tree files for the FRDM-IMX95 board:
>>> https://lore.kernel.org/all/20260116-127-v3-2-3dc49545a745@nxp.com/
>>>
>>> Signed-off-by: Lei Xu <lei.xu@nxp.com>
>>> Signed-off-by: Joseph Guo <qijian.guo@nxp.com>
>>> ---
>>>   .../src/arm64/freescale/imx95-15x15-frdm.dts       | 964 +++++++++++++++++++++
>>>   1 file changed, 964 insertions(+)
>>
>> NAK. Only cherry picks go in there.
> So ... move the .dts into arch/arm/dts/ until there is an upstream DT in
> Linux and thet gets synced into dts/upstream/ in some future U-Boot
> version following the Linux release which contains the DT. Once the
> later happens, remove the DT from arch/arm/dts and enable OF_UPSTREAM
> for this board.

Thank you Tom and Marek, will do that in v2.
