Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 796A6C36008
	for <u-boot@archiver.kernel.org>; Tue, 25 Mar 2025 06:58:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B32BB80F70;
	Tue, 25 Mar 2025 07:58:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="w7ltmluv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD761810E8; Tue, 25 Mar 2025 07:58:16 +0100 (CET)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on2061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::61a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8D9380EEF
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 07:58:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YCvq3ceGTIsua/Vahybo64RDKK6jhiM2c4IeHEQjqGwqZGNnYkubmTH3X9uMSsYqEIJCEF9CAJf0yFx6wOaW6IpEImXm27BkRkxgYzaXNAGLkfmqYHvRcW7no8bCX9jc7tgkTS66WvlFfi0aUje7PylCJGOUuRPZogpdOUKo2cRIEdRrNkC6loQOhmE2zJmc7S2CYp80SpsV411CUQZjYmZzjwLAn+YzETKHq4eIBO6nvYeEnN92KxVAlgd88+lTVT2gkHvhPU2e39F43oB9AvPo/Ytiqg3argIcUYrDE/GJM2YlUQRwyXyciwX1h7QI5ZFQ7fuBWEm2+VVhW4jOpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o8D0UNe9D4uplu7l5h/Ykz+dAN/5wHFhH6XgrdSmta4=;
 b=PiNjyXmtx/GYa1IpTsS+1aBU/+XSSIa5cn6Pd/suCBIrQIwadVd+xvip2m4zMJT0dRQqFeLPdBEszdFZFoOhrWpaJo/kYvksefXwkDNgQit/b7G307dvjnvWUHANUtQt/PrQrfQgj27/rwuRdLVn5R02SFis6ENNDA9A52lrZaNRSAWhCPO5gHpinhEt0ahUdtQfcvIxZDbxAs183Kcv73SEXnyeQYf/WCa5F0T5jJi4vCY0BwPpM4yk4a/r3fOXgOtNpS7mO2LNtrJojG5AHSVzJ1cSBI3nG47MlXl/g4SIkApwD8V9kwMZEakgPCibLv0FI/Jbsy/3n7oI/EJQpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o8D0UNe9D4uplu7l5h/Ykz+dAN/5wHFhH6XgrdSmta4=;
 b=w7ltmluvSXge3EGRGM6cH93/zHMjJc/eVlrnGJqXn2A2dcQDNsm49YGIec28ut6R/AaGh33OZqwZKtsr4x4qSYE3nJo2y4MSOwDA6TxOU3zzwJh8iP8IYyLZeZt5d/gEyi7SIv454Ft53u0UnbRzPtAjjpLqNVWMCvtQq04XmX6T4YlzVE9D9+039qGDN0Rb9tiW7PFw4P3lUXY59RRIujJ2YLIYdgi3XeiQzp6kEDXBfhVjRwV9ZTqnRinuTe9bWtOIYYaQwxVw/6wGdURtPKDP+Vu2xl1mBP0XvI1U9nLEtqpg75Ywp18ZCHSSohOxhfNB9oFrYQCCjjrK51WDGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA4PR04MB7791.eurprd04.prod.outlook.com (2603:10a6:102:cf::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 06:58:13 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 06:58:13 +0000
Date: Tue, 25 Mar 2025 16:06:14 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Marek Vasut <marex@denx.de>
Cc: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>,
 Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@karo-electronics.de>,
 u-boot@lists.denx.de, Ranjani Vaidyanathan <Ranjani.Vaidyanathan@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>
Subject: Re: [PATCH v8 02/19] pinctrl: nxp: add a pin controller driver based
 on SCMI pin control protocol
Message-ID: <20250325080614.GC27303@nxa18884-linux>
References: <20250321-imx95-v1-0-f2c8ba815f89@oss.nxp.com>
 <20250321-imx95-v1-2-f2c8ba815f89@oss.nxp.com>
 <a180b7e6-6978-4814-97ff-05e34223938f@denx.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a180b7e6-6978-4814-97ff-05e34223938f@denx.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2PR04CA0214.apcprd04.prod.outlook.com
 (2603:1096:4:187::17) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA4PR04MB7791:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cc84773-3f70-4a8b-ccf6-08dd6b6a68f7
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|7416014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ITqrm/Mdrl1QwTKRTVLTbRF+4IAdgOHP59fkqWj3U3j9gYmHEQplD5AdlWQo?=
 =?us-ascii?Q?oFxfmelLkg8CciIC7pEzXmlOfoGP7atGf7NDJq6jfpDY7TM/uFelUtoaBEdU?=
 =?us-ascii?Q?vky8EPomUR6Obf1JJPEJSUx/gY0m31BFl/T0A7JRIzRaqg9aJE3RAx8HWfhK?=
 =?us-ascii?Q?1EsV7tTG93TWmhrzaleOYln3ABiIn6wVSJXsCKfBDcMN0Q3nenGLvhcjjKT4?=
 =?us-ascii?Q?hDHLO92wBjb3pt+jNRXchusOOOMtYo8d+YdRweQCoujZdGLZOpiW/J1gB5Yb?=
 =?us-ascii?Q?lMa0OPoZK892UW5jOsmLxXjW2PLHpOpSxVj+QRdLe3BdUBslxVNJq8drl2W9?=
 =?us-ascii?Q?LRxIviNg86+L2REgtgQTvB5t6qhu/1Gvua7Jnp1qwAnE4Oclr5PInARj+qo1?=
 =?us-ascii?Q?aLuiR5l0iX6eP+yhwSshy1PU2PZlJBzGaBUrpRM9f0whnpIXmhhbyzytx8PM?=
 =?us-ascii?Q?9OQwVKKDmaTnnQMo4OLF6+K0lnhYGJg1RKOy0FPsDDl+Xc3FS5v34BtFAr0A?=
 =?us-ascii?Q?hu/vwTWGP4KSeqjQudGYdXSGN7NXpzSEQfNSzbteG5neQ+NhahFkbRwKHo/z?=
 =?us-ascii?Q?ybsYWG8uyjBTs2mebXaNU9qE03cCw5n0Xlh7AoXB0lK8cxULoy93vUrJcq2G?=
 =?us-ascii?Q?hmNoJ4pRO5cVYAF870Vla0olQNrjJveiHR+v2a692sNtvQxlKO/+xvuOoNLV?=
 =?us-ascii?Q?dgFW8IYONlVNR1rBBWpyMP8HuK+DL17XaSQFsY/h7zg6x0gzHHBEbfQmoj0/?=
 =?us-ascii?Q?3fhzXIm8NAaTk86kFs2VYNY1K3lmrOPjLSBCPVZV1pKDTyNtEaF/rCZuHceL?=
 =?us-ascii?Q?9R2gVeBFu2yhdsebdhcKMK60xGdt3x6ij5iZVyHB9PrFAWdQNw4Dw08YTvgM?=
 =?us-ascii?Q?vmTVFmf4W0Mge8eFxjN2JjNpr4gD998NX+6fKbq+Bz9DnWNm+BWwgungLytf?=
 =?us-ascii?Q?aPburt3dlxDaenSm9F20QppntGi4IQ5rNkSgMr4zePj/900Qi1unZMCeCTVf?=
 =?us-ascii?Q?K7qV7X1o8vM2CdxDeyp1NAy4TvQppZX5L5Nmy2R6Uqc6tvQkxw/68rdZcvOY?=
 =?us-ascii?Q?SrofswL3XextRI4ZwltkiMlJXHpL+0YBT4axtTLFqWjs8VYewnlE6BW9Q/hz?=
 =?us-ascii?Q?Ge7urSUVTWv22yBxOZ4WRsWn8rF2g2ycvQdqpAteqUgCC8sgpJDx4PIuiCRU?=
 =?us-ascii?Q?YEC7xLVAwHIW5OtAzngD5S2j0jTqxFCqTvMVF9D+Zd0mvl9izIbBTsXgJRvB?=
 =?us-ascii?Q?HzSd59DMs1Dau+xY7H5ClAEgZEcic4wl4GEeoKgkwNfo6iQbnCR+/VdzhweP?=
 =?us-ascii?Q?hK0tos4PjCQurNJjU+BuHCaDWiuHAVQ1/EF4Ic7uP0k8uR65+HaXeOrqRyQS?=
 =?us-ascii?Q?+e/CwRYMgLy8+50lyavB7jiMWR6PArzXinLPEcx43X27vP3f9jO/2na1+R8A?=
 =?us-ascii?Q?X1eeIr/uUuRroRWo02CR/Uj1e/0bnp7X?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wG0wAX+tHws86Vckx0qKiQDaC+5BvlZiLwWvHKt2DLHPVsBPG0NvYBGg9XRe?=
 =?us-ascii?Q?41FWUHVW++wfmpBLUD2/twN0ewvHuXPnCaKWM/tK13YeC22GVT8gw3EowSHB?=
 =?us-ascii?Q?VkgxS+vvvcNMq+driKHuEPU8V0o6FndpASPdBMAWlbjQ4NXTnb6pl1cL+ni9?=
 =?us-ascii?Q?TQjaVO5UlUGGaAL4PToKbDp1jXTD+E5VmiTdTXpd+qH6dm8r/n/c2jXUoytv?=
 =?us-ascii?Q?ArYYzCHgF97VqaUfGI2klvEHDoTDoFzpg9j1ECBU37wtv3iHYOjqWgIZ9/De?=
 =?us-ascii?Q?FQpVoElLZQOorjZs1DUnh7K1SkhPnEd1va3iMenjMa0tTP5M61M9LL1WUqbU?=
 =?us-ascii?Q?pGFb8RVS0e90pxIoA5/dAmKOhegC28uNT2nnj771ZFKPg6OGim8NzNtHZi4r?=
 =?us-ascii?Q?f1MdGrhPwu0780xR8ttnSAM9EDrAPfWri/e6Z9qQZ6Bb9JwTQ/B69VtaaYqy?=
 =?us-ascii?Q?OJBBbNCz+4VQGIX8e3J4IhY37JiCj7sy5+NTtTDnnHxCNnj6hfHPbA/JQWsA?=
 =?us-ascii?Q?kPQgQMEn+i7mhIoad89DGamaLqStUZ6lVH0nm77yqbKKjzKpSjyKaiicP3xT?=
 =?us-ascii?Q?r+tno0yOHDvCMGb+fj0BIdCK7F9jeBVDpLUVsibiB3MFeMGE45WoGqNVB6op?=
 =?us-ascii?Q?Dly3xvaAdvdlBFa9AtdSoTa3X17wS3ILDCNEX74hHYaXuqe2kEPJdIAeJxP1?=
 =?us-ascii?Q?78Aavuw57t1j7F9VVmL/XPg+CuVOHWl8hRfWpr90y7hyi+LyyxSZCWhGy7GO?=
 =?us-ascii?Q?bV5V6IPO01U9xF7M7kJEXRqA87uVnuzMcx+ED4bOWRWNtEIsk8HtnFXzTr4X?=
 =?us-ascii?Q?EXm8VpfGUVE1tQOmCNelUVC09f0Dtn9DFygIGW1C9GyWrG6paS9u3VCx48o5?=
 =?us-ascii?Q?vSr7si4eK4Nb2PSrzifLXirTNMVQ0zQVr/N/3c5DlkiDXccz1oXtkRiFidUr?=
 =?us-ascii?Q?AaXBdflnzUQMRAnCvXX/4q0AODTWNpsPh0kn/RBfoa+1x/nEzIz+9fyLLTsQ?=
 =?us-ascii?Q?9T3oe2u26PhaLk0DxZk0FH6pz6O09ONAyM+sRO78IJ0S2SXcqyK9Sr17dNB8?=
 =?us-ascii?Q?IsyLF3LCawvnIfUPlVs96m8YrBqeQhNFibqF62qJ8Me+JOihrkMVA42fUj1W?=
 =?us-ascii?Q?gkcHOmXifCxtXi5uW5wHM1DF4Nw4rjaZTTU153Hb2R53YtsvNvUQWVbSJU+S?=
 =?us-ascii?Q?9JdrkUECO46eh6TO02W2mVN8gT/+6WVHdV/sxULpIyfE6ipPFnZ+hEje8jJ1?=
 =?us-ascii?Q?m+OQM99572GRSNubD54Oqq2gxX6UvHc9cneI5HDI4xFGEFu9J4QjlRAarDhk?=
 =?us-ascii?Q?eI7TLwBDBwVlrNY+1onc1AwdmHDwzz2zwC71XqPgAuVgLXk1qf6Yploo+DDZ?=
 =?us-ascii?Q?qC/AXvlDFEvpojUafc0FcMwKb/vn0MXWOXTxWod8tncpmeas3DSPNHEfCHt3?=
 =?us-ascii?Q?u3k5jt81p2oRq6RXLGQrNsJEm7cqD4Q+QcpI2jjh+xv7jCfO7AgQbPMiEuQx?=
 =?us-ascii?Q?9eMJLxOs0MzGCxLHRY5gt/HY7wEjYae46XjquYRIpwSg/zZWFWt6F9SLOEBA?=
 =?us-ascii?Q?jWPdUewZW+J7l4T1e8AQLHGHM0+Vl6uUrX5Qrxrk?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cc84773-3f70-4a8b-ccf6-08dd6b6a68f7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 06:58:13.0040 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /G18BL2oDT+pMwT4vtD+Z/sXHKwmsxkQqspEoDANPqIsdmFD/9DvE8h3yJHLlQG8iVhaWqU01hk8w+9J2vjjTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7791
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

On Sat, Mar 22, 2025 at 01:46:02AM +0100, Marek Vasut wrote:
>On 3/21/25 8:15 AM, Alice Guo (OSS) wrote:
>
>[...]
>
>> +static int imx_scmi_pinctrl_probe(struct udevice *dev)
>> +{
>> +	struct imx_scmi_pinctrl_priv *priv = dev_get_priv(dev);
>> +
>> +	priv->daisy_offset = is_imx93() ? DAISY_OFFSET_IMX93 : DAISY_OFFSET_IMX95;
>> +
>> +	return devm_scmi_of_get_channel(dev);
>> +}
>> +
>> +static int imx_scmi_pinctrl_bind(struct udevice *dev)
>> +{
>> +	if (IS_ENABLED(CONFIG_IMX95))
>> +		return 0;
>
>Why does this driver support iMX93 , but it is explicitly not going to bind
>on iMX93 ?
>
>In case the MX93 support is going to be added, you probably need something
>like:
>
>if (IS_ENABLED(CONFIG_IMX95) && is_imx95())
>  return 0;
>
>Because IS_ENABLED(CONFIG_IMX95) does not automatically imply that this code
>is started on MX95 , that is when is_imx95() comes into play and does runtime
>check for MX95 .
>
>> +	return -ENODEV;
>> +}
>> +
>> +U_BOOT_DRIVER(scmi_pinctrl_imx) = {
>> +	.name = "scmi_pinctrl_imx",
>> +	.id = UCLASS_PINCTRL,
>> +	.bind = imx_scmi_pinctrl_bind,
>> +	.probe = imx_scmi_pinctrl_probe,
>> +	.priv_auto = sizeof(struct imx_scmi_pinctrl_priv),
>> +	.ops = &imx_scmi_pinctrl_ops,
>> +	.flags = DM_FLAG_PRE_RELOC,
>> +};
>> diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
>> index 7abb2a6f36b..279ebbad440 100644
>> --- a/include/scmi_protocols.h
>> +++ b/include/scmi_protocols.h
>> @@ -24,6 +24,7 @@ enum scmi_std_protocol {
>>   	SCMI_PROTOCOL_ID_SENSOR = 0x15,
>>   	SCMI_PROTOCOL_ID_RESET_DOMAIN = 0x16,
>>   	SCMI_PROTOCOL_ID_VOLTAGE_DOMAIN = 0x17,
>> +	SCMI_PROTOCOL_ID_PINCTRL = 0x19,
>If this is the IMX specific pinctrl protocol, please make sure to name it
>accordingly , SCMI_PROTOCOL_ID_PINCTRL_IMX or something .

This ID is generic ID, not i.MX specific.

i.MX SCMI pinctrl follows ARM SCMI spec, but i.MX pinctrl bindings
are different compared with ARM SCMI generic pinconf bindings, so we
need a separate driver for i.MX.

Regards,
Peng

