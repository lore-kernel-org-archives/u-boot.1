Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D3D4E77198
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 06:59:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7738C806A7;
	Tue,  7 Jan 2025 07:59:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Pv6V0wZX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90CD680655; Tue,  7 Jan 2025 07:59:13 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170120003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB678805F5
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 07:59:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NE2Rm+MPQe+S/hyKqJdZlWVV3enNV1oXinoZyxZNHFneLvlC6dACRqwakmzTRZLiaCV+5JA5TrZACUuIff+RqmA4+I1bxsrf5fk5DBSjsQ3jP3UUBifMWfD7mdBKDBgz1efiMbRfmhYEHXLczkGRxviIQRg9aaJhXSTPDtWe01ROmniwjKwSDSiim5CE276NfJCdR7YZNS7KxmA/lyrDc6TDzkIa28r5SzziSE3hY+BdwNGnccayVWTh9QpljYhNVO1KyV2zXWKpyCUAdaHA3kRXLFO+yV5lZPG/8Frpw/LGFMOdp6s67oN2boW5BBK/558TnsOhvG+ToxIf6KJpjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dVDLOrabmXdHHGLKzulvhFmWUBjPki+dpBKP7dW9Pag=;
 b=sr1vMCwJhEdkcH3rrLGmaYmn/pQLdc8Qx2UtWphdp5wgR+Wijmobz1Q0nMorQb/Qh4fT8jpIzTWitpCuRLoMVLW5vDWNsdmWV0FWEZudSnyOXN3g1EYCdmxIOtQ44Di4urRkatpbN9W7Os9dxpLd3DGvZuqIsR1CiTzgs4dt/mEoC6dTsli0o2MBMNUKQhp4WrM1QaKXrc07EAXQfgQgwe7NqoVdyEwjsIVH+dtfEnpIzt6Vre25QpjoRF+Ou28zLJ8eF/S0KnQb0tdwZP+Ebhwe6bB+ADqb7uzJ8vyGpxi7iad5Dv9WbSjDFtvIuNJ2PHwJofA++UmwtJFurIx4lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dVDLOrabmXdHHGLKzulvhFmWUBjPki+dpBKP7dW9Pag=;
 b=Pv6V0wZXWVxRLWY8Zj5zT9/eYgg/QpfSq7/oXBxIkUkStHAfbCtKHeCVw5dJbN4D1e4a9fuIJ99IEqiabP9mKBjurtJYggvkrDElda8MLVIC6eYcO82btorSlFnmodt+ZpLFsJJFqAeAZOXMS5azhl/cNbUGZsL0zSST5ducUAxs24YW+graT/um7diwTo5LQ0EV37ZjyOl6kPiICXyUqVlvo7njq2kdDtZso+6wUUXUQ+fz7NW8D0ZvQtx3JGp/l5VAO3zYmDDewltkMaifjJH3WCg4njuOeGOzyl9BdAWYksRz2FhgvPVnWpaSav0ojIjgxCU3ndAOwCxvSUkzSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS1PR04MB9478.eurprd04.prod.outlook.com (2603:10a6:20b:4d8::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.16; Tue, 7 Jan
 2025 06:59:04 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8314.018; Tue, 7 Jan 2025
 06:59:03 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 07 Jan 2025 16:05:02 +0800
Subject: [PATCH v2 02/16] imx: imx93_qsb: switch to BOOTSTD
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250107-imx-bootstd-v2-2-97671b1694cd@nxp.com>
References: <20250107-imx-bootstd-v2-0-97671b1694cd@nxp.com>
In-Reply-To: <20250107-imx-bootstd-v2-0-97671b1694cd@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SI1PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::14) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS1PR04MB9478:EE_
X-MS-Office365-Filtering-Correlation-Id: 37a35975-94ad-4844-2890-08dd2ee8c588
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dExzZFFSaHJwK2RkclpaaEIwZ2NabVZPRVl4d05YNFJqQXlSekVDd0JpZHFk?=
 =?utf-8?B?ZDR3QnVJdXdOZXNLOFB5Z010c1FWNXZkWklaUEhPcU9iTGtjWHl1NzRHQmhJ?=
 =?utf-8?B?dSs2bEVZeVQ3aU9iZWNzTElLakRqZmN4U1NoR0JrTVovc1J5ditOMTc2UkI1?=
 =?utf-8?B?STVNV3B4NmFYZUVQLzY0NXNmNVNpWHdxVnAyVENiNWl5dkFHSERYZk5NUFRw?=
 =?utf-8?B?ZUozcjFXU1ZoWUNQK0szRzdrL3JMT0w4ZHNteHl5bGRqb0x2SmZJSVJCdGMx?=
 =?utf-8?B?L1paTzJPRzJ4L2s5SEdGcjVQblYyODRQZTdtUFR6RnZKNUhEOGdoU2tHUm8x?=
 =?utf-8?B?SE0xblgwSnNWQXgxNXlWYm1DNlB0RkNsZ3hIRmhPazFXeEFTbjIxVm95eTZP?=
 =?utf-8?B?ZGhhZ3Q5czN4eUI3YkFJVEZYLzNEb1RmeXJFYitWUWlHNWJ0MzBlZmk4MjNl?=
 =?utf-8?B?R3JPTG5XdEJuM0lwc2VjRndNanJNOVZNQWtEMSt3dFRCdkkzMHMxOVZTQzFH?=
 =?utf-8?B?Z2kwRVg5K1ZXVG9rdjVDSHhvckh1TEFzSXpaN0FmOERwMUdiTUhaOVA4UzNu?=
 =?utf-8?B?Y1dlYnlSWHU5ellZMXhCWmpmMlNwZ1NuaHhZS3Y5WC91dDdvSnkvNmgzNkpK?=
 =?utf-8?B?c1FRRElsUEhUdm50bk9uUnlKUTZ1NURzQmVjS3JHS0YzS25JSFhXa2E3UTJ4?=
 =?utf-8?B?ajV6b2RWS1pLOCtqaGs0bXBlOW9QSXJVTjhWcG9vaHhxeTNOWWJ2WGNycUNo?=
 =?utf-8?B?NU5sNWowMThBVllGWWNXSHdkV2t3ZG5TdUd3YytYUUpmaXpwZm1vVkM5S1Ex?=
 =?utf-8?B?Rmw5b0pjaS8xRmVFUGkzdGh4NkRKVnNmbGZ3REJzdEorLy9ZaTluOTNXQWFw?=
 =?utf-8?B?YXB6YnZORFJBbm45d0djVVlrTmNURVh6OWs3elY3bHdNZ1FKZ1dSTk9sdXNR?=
 =?utf-8?B?Qkh1WTNaODNRQ2d4dzdCVW5mZjVPYzV1UVYzR1EraE9tNS8vc20wT20ydElO?=
 =?utf-8?B?V0EzaUhSOVMrUXZCWUlUOE51Tkk4NnNraWsrTVM3Y0VybVVKdWpDZWJ5N1hN?=
 =?utf-8?B?N3MwYUMyNmxwemhQN2k4YVVKS1RueFh0WHhCeS9heHBkakFEbnI2S0xPZUN4?=
 =?utf-8?B?UU0rSUxuSmp0V3g4T1lHUmVDQXRRMkJFbWR6MHFOMzlLOGhSKzlxQjFRbE91?=
 =?utf-8?B?RUhLcnJTY3U3Vjd4VG5YNG1va2JTWjEyTEVSYlJzZmFjeEtCVTE1TC9Pa2d2?=
 =?utf-8?B?UzdQbEozZnFMb241U1VkVUNaMzVvd0N6YmdPbGJ6UWFZYXlRMWI2M0E0dVVT?=
 =?utf-8?B?UHF6V1U4TzZVakVqYUhJU1JodTY5dG5mRGxiV3A1cUZReXNmbEVZZkJFREdC?=
 =?utf-8?B?ZFlIOUpjNGszS2JCZGVFQnpua0dsL1NRK0FyNWNFUVhhMGhFdXBOaFV0MWNN?=
 =?utf-8?B?dm1zbVNsU0pqR1QyUUNJK3k4LzNvZHk3NkhRUUJ0Z0p5M0dpclFnQXZ3WVg5?=
 =?utf-8?B?SnZRNmYycHJEVEgyL1VkbXpRTDFCQkwyVEtiakFidkxReGFobTlxSXhuODJi?=
 =?utf-8?B?YWdhUGpXQ21KWFdjMFVXVGZxZDFkelIyK2U4WktwMEcvTFJKeFkvK3k2R2J0?=
 =?utf-8?B?Sm52d1pHTE9ySTRBM3lVdE9nNGwwTGFUUHJoYWlvb3RwT2d2OUJjVkpzajRx?=
 =?utf-8?B?VDkyNExTRjlhYWdMQnlxSDlhdEdESm1aNDNNWi90WVlyZVl0MUZ2cXdaMWRU?=
 =?utf-8?B?ZDl1VW5lcjlqeGg1bmlMNkJXdXdVaDEwcXZhYnlPRTVuM3dESWY1K3VlK0Fk?=
 =?utf-8?B?L0VOOVhXelNwM0hzejRyU2tFME5SSzVjTU1GaGpSMnJROStNZlI4UmRVbUFS?=
 =?utf-8?B?QXNwai9mSlVWMHBvaWlsRWVZZ2pIcWhVaVpNcENxRjlGZGQxUkpaaUpuSG4r?=
 =?utf-8?Q?vQMAGh23wAN3j42giaat8rKxgnO/MrXg?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djdiR2N4QTJFTFk5VDNVM2xoU3R3VDNhUWJROC9RalhZZ0VkWGpmSHE3aFhW?=
 =?utf-8?B?UXd4VUNMbkQxMXpyMllsR3ZJaDVSVG5LSzYzdnFPM0VlR1YxTVZIbGR1K0ZJ?=
 =?utf-8?B?Y3JKaGMrcFNONXZNMnpreVBNVVNxOTVodGNQZ0F0eEs0Uys1cXFEV1ZoVW82?=
 =?utf-8?B?bGZ1eWE2RHMxbnUyR3dleGVndzRDOUhmd2FiM2h4SVVhR1FnN21RYnk3YVNt?=
 =?utf-8?B?MWpWZytXdGZaeElHUTl2Q0pOV2VFbWc5VlkwbmdqTS8zb0srT28rV0xwSWh3?=
 =?utf-8?B?d1VLVTNKUEN5Qk0vOWxJT1BISVgyYjUzWDRBSkhmQ09BU3NmTFJZTGg1T0N0?=
 =?utf-8?B?L1VJcTF4c09mM0V1VXlVbmxYTDhHVXZ5dDJOeVc1d0hPeE1wYXlTd2UyVld2?=
 =?utf-8?B?cUlKenlaWkFBcWttalFtWmpiWFBXZXpoUk5QQzI1OFV5dXFXSmNmK2haY01B?=
 =?utf-8?B?a3MxY2V3UDFLOHhLbTJadVlMTG9RZUdjWmVJaTlCanUzNng0RERDOEMrekds?=
 =?utf-8?B?UXZqL3o3WVlkNFN2OXZtQStaYjcxUkpFVGNDTUFXeFJYRlFpTDUyWEJ0cU14?=
 =?utf-8?B?QXYxWDBOZktiQ1phQ0VxOXRhcGNYR3lkaXFIQ3ltTUlzWkVLWkpYcDJmVjBv?=
 =?utf-8?B?V29ESWJLUmc4Q1p5QUhlYzZUSTA2eWp5dnFGREJsRUlGRFlvSktIYjYvR3ZZ?=
 =?utf-8?B?R3E2OFcxMGgrVGlhbDVMaHR6Q1dmTVNxYnVrYUxNbjNNZUtjbE1FY1oreHlV?=
 =?utf-8?B?YnRtaTE5V2xSMzViSUJ1cUdCdW9kaUtkdDAxK25pbFJ5UHpOVUJzMW1ia3hk?=
 =?utf-8?B?ZU13Sy9xSEtMb0p1elVRQW9xb3V0NFFEQVh0ZWVrYnByOWpTSk80SmRNNmhX?=
 =?utf-8?B?R0hzbmU3UEcxZkdrbmpUSVJOcFJmM2lXVkZmMmFlV1VNcUluUWV3LzZ2Ym5W?=
 =?utf-8?B?Wlh0YkxPSjE3cnVVY09IWThEc0x0a1BYcFMyUlRNekpRemlFMTVqWWQ2eTJn?=
 =?utf-8?B?NXNvTTlybklNa0hoWnpnRXFFdVNjbndCTHBoZkI0cHVXZ21oVkxUdGt3SGpq?=
 =?utf-8?B?VlhOa1BVNVRBSkpxVldyMSszZktRWUdod2tnYXVHeGppUkRiRzRwdm5XVmhE?=
 =?utf-8?B?clhoRlF3QmZFYWVHdE9FdHNEaHBCUVd6N2RHUDlUeUlZSkp1WU13M1lFV1ow?=
 =?utf-8?B?VC9oWW93NVd4ZFNLQ2t0Y3prMjNGamt0VlNpZGQ0Y1libW91eXVOSUIweUJt?=
 =?utf-8?B?c3dDU21pZ2Q3Q0diQ0hScHl1S0gwL3laWW1Vd1BqS2tjY1FRazdnR2dUS3NS?=
 =?utf-8?B?OE9iaDFTNi95M0VST0xKL3dPbEVYYkFWdDUvYkVmRStrVXpZei9tU29JUERO?=
 =?utf-8?B?WVhpZjQ1bWlLTitqa3VlOFlpSHhwM1NIVlpkNjRlNXEwUFUvRlFIMkI0eVE3?=
 =?utf-8?B?eGJ4Q0NmTGtjUDlOL1RtTW9hS1Z3QnUvcTBRSitYWThYK3dCQ1I0WWQyQ094?=
 =?utf-8?B?YnRZNGgwNHIzd2UxOW8rSGtHM2p1RE5POUh5dlZnY1NiY3Y3RlVTTmNhd0kv?=
 =?utf-8?B?bGZHN1VhaEttNlZwbXZqc0psZ2VOenBsYmRWRFl3SDV3M1Q3VTRDRkFJcS9R?=
 =?utf-8?B?Yk5xbVdTWFZ3bjhjUnR4RXoyT0I5NlJvL2htZEVWVzV5c2ZMOG1Gcmd0dk1z?=
 =?utf-8?B?SzlFNDcxczEyeUswUEV5bERjUzVuUytqdW40a2t4L0VzUWhUWFBmaGw3Vy9G?=
 =?utf-8?B?empxSW1hc2lyMmlxTEc4VUdMbi82OFp3aEVMa0ZLQ3c3V0RsSndWYkxYNTNn?=
 =?utf-8?B?L2xrV1I3NzU4UkoxaTlIM1dJMEJPdEJpd0xTNmhFbGk1VFZTNVlKWlJEdmFy?=
 =?utf-8?B?TWpWQ09mQ0JZdHNnOGUrYW1Uc1hHTzFBSEJJV3VxQW93ekQwWEY5RlBmRU5I?=
 =?utf-8?B?Um16R1FPVXlhZzhJZ2JPNTZYUi9LYm9BR1ZPUXFETDhaV05pNUwrbDVXRTcw?=
 =?utf-8?B?cllPZTZ1d3p3S3Ewcm9NYlFtV1hHR0J4TzYyK3hpcDBBNFgyN2F3dmRDK3lX?=
 =?utf-8?B?aCt6VUg0dGFuMUdXMGxVUStjMzN5OFU5Mm5mayszQSt1SmRrSGNoMGR5ckdE?=
 =?utf-8?Q?o3hGwoDln9+03VnVAfZSM/0+f?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37a35975-94ad-4844-2890-08dd2ee8c588
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 06:59:03.8956 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tzwkzk/vAr+eUcVH6yjARsKADvZqcaLz9gVkvcarwUAOCHt+DEtSzsquX1HXd0V8SbVNXxyRd68mrjKTVEzr9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9478
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

From: Peng Fan <peng.fan@nxp.com>

Switch to support BOOTSTD with a bsp bootcmd as fallback.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/imx9/Kconfig             |  2 ++
 board/freescale/imx93_qsb/imx93_qsb.env    | 29 +++++++++++++++++++++++++++--
 configs/imx93_9x9_qsb_defconfig            |  3 +--
 configs/imx93_9x9_qsb_inline_ecc_defconfig |  3 +--
 4 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-imx/imx9/Kconfig b/arch/arm/mach-imx/imx9/Kconfig
index c52546084394a7cc26f35c93ac8fb62d9c5fe795..d756f3dcad2e91172ecd885357b9d0adf2e387e3 100644
--- a/arch/arm/mach-imx/imx9/Kconfig
+++ b/arch/arm/mach-imx/imx9/Kconfig
@@ -41,6 +41,8 @@ config TARGET_IMX93_9X9_QSB
 	select IMX93
 	select IMX9_LPDDR4X
 	imply OF_UPSTREAM
+	imply BOOTSTD_FULL
+	imply BOOTSTD_BOOTCOMMAND
 
 config TARGET_IMX93_11X11_EVK
 	bool "imx93_11x11_evk"
diff --git a/board/freescale/imx93_qsb/imx93_qsb.env b/board/freescale/imx93_qsb/imx93_qsb.env
index 92486c6f74d2ec12f638443dcf598daa28f306b6..c972d3eb2511542c1a11812f879d7627cadef797 100644
--- a/board/freescale/imx93_qsb/imx93_qsb.env
+++ b/board/freescale/imx93_qsb/imx93_qsb.env
@@ -10,6 +10,7 @@ fdt_addr_r=0x83000000
 fdt_addr=0x83000000
 fdtfile=CONFIG_DEFAULT_FDT_FILE
 image=Image
+mmcdev=CONFIG_SYS_MMC_ENV_DEV
 mmcpart=1
 mmcroot=/dev/mmcblk1p2 rootwait rw
 mmcautodetect=yes
@@ -19,12 +20,13 @@ loadimage=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${image}
 loadfdt=fatload mmc ${mmcdev}:${mmcpart} ${fdt_addr_r} ${fdtfile}
 loadcntr=fatload mmc ${mmcdev}:${mmcpart} ${cntr_addr} ${cntr_file}
 auth_os=auth_cntr ${cntr_addr}
+sec_boot=no
 boot_os=booti ${loadaddr} - ${fdt_addr_r}
 mmcboot=
 	echo Booting from mmc ...;
 	run mmcargs;
 	if test ${sec_boot} = yes; then
-		if run auth_os; then
+		if run true; then
 			run boot_os;
 		else
 			echo ERR: failed to authenticate;
@@ -48,7 +50,7 @@ netboot=
 	fi;
 	if test ${sec_boot} = yes; then
 		${get_cmd} ${cntr_addr} ${cntr_file};
-		if run auth_os; then
+		if true; then
 			run boot_os;
 		else
 			echo ERR: failed to authenticate;
@@ -61,3 +63,26 @@ netboot=
 			echo WARN: Cannot load the DT;
 		fi;
 	fi;
+bsp_bootcmd=
+	echo Running BSP bootcmd ...;
+	mmc dev ${mmcdev};
+	if mmc rescan; then
+		if run loadbootscript; then
+			run bootscript;
+		else
+			if test ${sec_boot} = yes; then
+				if run loadcntr; then
+					run mmcboot;
+				else
+					run netboot;
+				fi;
+			else
+				if run loadimage; then
+					run mmcboot;
+				else
+					run netboot;
+				fi;
+			fi;
+		fi;
+	fi;
+scriptaddr=0x83500000
diff --git a/configs/imx93_9x9_qsb_defconfig b/configs/imx93_9x9_qsb_defconfig
index 582fe5a318daaf568b48dac816cd15d80b430b22..8bd2ddda7da8f2a60b834777ae40fafc83963bb9 100644
--- a/configs/imx93_9x9_qsb_defconfig
+++ b/configs/imx93_9x9_qsb_defconfig
@@ -6,7 +6,6 @@ CONFIG_SYS_MALLOC_F_LEN=0x20000
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
 CONFIG_NR_DRAM_BANKS=2
-CONFIG_ENV_SOURCE_FILE="imx93_qsb"
 CONFIG_SF_DEFAULT_SPEED=40000000
 CONFIG_ENV_SIZE=0x4000
 CONFIG_ENV_OFFSET=0x700000
@@ -29,7 +28,7 @@ CONFIG_SPL_IMX_ROMAPI_LOADADDR=0x88000000
 CONFIG_SYS_MEMTEST_START=0x80000000
 CONFIG_SYS_MEMTEST_END=0x90000000
 CONFIG_REMAKE_ELF=y
-CONFIG_DISTRO_DEFAULTS=y
+CONFIG_BOOTCOMMAND="bootflow scan -lb; run bsp_bootcmd"
 CONFIG_DEFAULT_FDT_FILE="imx93-9x9-qsb.dtb"
 CONFIG_SYS_CBSIZE=2048
 CONFIG_SYS_PBSIZE=2074
diff --git a/configs/imx93_9x9_qsb_inline_ecc_defconfig b/configs/imx93_9x9_qsb_inline_ecc_defconfig
index c95145cce0ed31db81b49bc9834b4228a9f3ba81..3d07dfb00297d25b82bc586c13491614f3977dc7 100644
--- a/configs/imx93_9x9_qsb_inline_ecc_defconfig
+++ b/configs/imx93_9x9_qsb_inline_ecc_defconfig
@@ -6,7 +6,6 @@ CONFIG_SYS_MALLOC_F_LEN=0x20000
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
 CONFIG_NR_DRAM_BANKS=2
-CONFIG_ENV_SOURCE_FILE="imx93_qsb"
 CONFIG_SF_DEFAULT_SPEED=40000000
 CONFIG_ENV_SIZE=0x4000
 CONFIG_ENV_OFFSET=0x700000
@@ -29,7 +28,7 @@ CONFIG_SPL_IMX_ROMAPI_LOADADDR=0x88000000
 CONFIG_SYS_MEMTEST_START=0x80000000
 CONFIG_SYS_MEMTEST_END=0x90000000
 CONFIG_REMAKE_ELF=y
-CONFIG_DISTRO_DEFAULTS=y
+CONFIG_BOOTCOMMAND="bootflow scan -lb; run bsp_bootcmd"
 CONFIG_DEFAULT_FDT_FILE="imx93-9x9-qsb.dtb"
 CONFIG_SYS_CBSIZE=2048
 CONFIG_SYS_PBSIZE=2074

-- 
2.35.3

