Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 175EDC44508
	for <u-boot@archiver.kernel.org>; Tue, 14 Jul 2026 14:01:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E28B284D1E;
	Tue, 14 Jul 2026 16:01:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="m6JR+uKm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20AA884D1F; Tue, 14 Jul 2026 16:01:04 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1AE2684CEB
 for <u-boot@lists.denx.de>; Tue, 14 Jul 2026 16:01:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DOIYT/75Clky7/z/tK1MJBpsLXXqxu48tOKEH+ax3trX4Zszn0o3/nNWWeQIETafHV2YXeHtkZ7hgMX8FPhU3S19GGqeqrl7paaz1sXsXQCtkVcp4PGqcYH9JQwg0TX0B1HUlENi5sUBt1pnwKbDVoKZ9WtnVg2iL/9rmjws7O7uLFpKwgcqkwW8AtLxYyDMbPV2dpHYCahp0TxGbsp6okN9nbRWGJTMeGrA3Jvwb/aGc24bNjt6AkO5SS7NeNzrjkxjFGQEhxqpD/WxLD+3Z5VpTmjg3/Oaw+JkW57BQ/2aRPsEI+nJakXHFy1UAaVZVQkUaWr6WfaqxxY0FyCBnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3/9NLdoDOAzJsFUCKEzY3BZAQ4/QgTJUUmDbe9VlX/w=;
 b=J047pUq3jKG8JN+pkzrCGXnqT/3bF57/OL4qRJjdOKKNEd/nrmBeWItLx/VyfQE53hbRy7kLIe4BlPQUqqax0RNwClH05K+zSI/1Uz4Yn1PWCUq9WLgXzTNF50VHRO4beIZpxBZDs3n8WiljPfsWZQYSwauEG17QIo+ya4U31BGlUMsuxx29Nj7rW2rNpRtnYPP3GpZQ2j/L2kZ06nbF0FRX4OKOHEteodXxKWobwp306aGRLYU69zWrmE90OeeEeb6dNaHwmyR78g02Ggj3XRxIzX2pvfQs8DswtXao75wuS8Nt0ylLv+wDdRFxfhVchyDI/m8lX/KKe3rsksVd+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3/9NLdoDOAzJsFUCKEzY3BZAQ4/QgTJUUmDbe9VlX/w=;
 b=m6JR+uKmnnu/bRtmpSVvoP8LdFrQMepcP9PzSpx1s7y/JPsqeDWrR6eSGvN6TflD1aoA2/c3IJRV6FO46ZMGvjnhh3mk6ZjIKEUy4ONpXGme1aFUtF7vG41LqegFfWR59u1uizPoRYr2d6eqIBeUfgvuxeoQEucK1hYVgI3FUJofTfQu/hr/B6uKh3be1YWuhuEpRSivcMdT6a7MrdRtBlW48E9KJTPcLA9sKIPq52rfOkn4nXVRoRsigUbTQ+BkXekNZqq+ve1nXeQvLFFeFXlL2lbQEauZuulApeKFlXStHfrpiQ2EyFvAGWRnPdBJrXCOCfoNavPYJdOlDF4Atw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by VE1PR04MB7245.eurprd04.prod.outlook.com (2603:10a6:800:1b1::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 14:00:58 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%3]) with mapi id 15.21.0202.018; Tue, 14 Jul 2026
 14:00:58 +0000
Date: Tue, 14 Jul 2026 22:04:32 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Fabio Estevam <festevam@gmail.com>,
 Wang Jie <dave.wang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Yao Zi <me@ziyao.cc>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Casey Connolly <casey.connolly@linaro.org>, Ye Li <ye.li@nxp.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Stefano Babic <sbabic@nabladev.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Alice Guo <alice.guo@nxp.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v2 07/10] usb: dwc3: generic: add board_usb_init/cleanup
 hooks
Message-ID: <alZB8CUrzBs1mTs8@shlinux89>
References: <20260621-tcpci-dwc3-v2-0-990ecacc111c@nxp.com>
 <20260621-tcpci-dwc3-v2-7-990ecacc111c@nxp.com>
 <74b9d259-b180-4ca7-9cf6-1c93e175e1f4@mailbox.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74b9d259-b180-4ca7-9cf6-1c93e175e1f4@mailbox.org>
X-ClientProxiedBy: SG2PR04CA0204.apcprd04.prod.outlook.com
 (2603:1096:4:187::16) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|VE1PR04MB7245:EE_
X-MS-Office365-Filtering-Correlation-Id: d35269d0-432d-46d4-a17e-08dee1b05485
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|376014|366016|23010399003|19092799006|6133799003|18002099003|22082099003|5023799004|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: 6EDspIaM74pkUuCg0ti+jn79yAuTibdurFLPLz+LjeiEyTAbi98rsO5ep/RunstLLG/JH71lPiiL+5qZiugdqtxz0behs0lcUqCndthZ2V5VrEVEfftfzesRXA5G1Dh4eWlxoiIS3QXGpcmAU2rMRKxPvBHbt1hzAjL589VzPxYzXcdtazCnbXOrRSKadMtFUTIoUe49E1Y1srWjhD/GYOTH4KY7UyYQT4+v4Dea4y7w1iV+3zwP2VEiBJyoR3bD3arTIGRpUPBxAWxV2WGbgBbzFXN29tlPcbQaTc+wQXzJ/XrI7DXksAyOJar9CG6MTsVmSp8de9HiCfj8ll43t2bqLxdw7acxdd4GsXAIHZMXt8YEyo6b6jbIFrhKVQ0EoqAkK5Q+fKFdLBCtpmVO2m/hxJ1f/BanVR37Q0Fg59h6zVMrBsHZAdfBKiioKyrTkStZtoMLNTWni5O7HqOwF+wn7t+q5pZnjHh/iuK39YH2BZSFyIZ8xSh+1/0SBo1kg/n0R9IEpDXV8+YCquQ7ffM9SqYcnWuyoeu/pJmBEP7hOmmza5v9iBvt6vO3ITRUywYZn58eMWdZKi31Dt2ImD+moTw1yVKyGqqCfjN0W0kehT3Ue6faMFhPoPc+lXTV2FmyKEpf0BmzOAt8ZDVuXfttoXuzUynO4A/h2kYju98=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(376014)(366016)(23010399003)(19092799006)(6133799003)(18002099003)(22082099003)(5023799004)(56012099006)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?afvUh8ifP/JXbBt3U66tjX9uxVIuOj7MSEQ5XGussCkAJR6nmUfu222/YG6P?=
 =?us-ascii?Q?xva+Z348cVKKLjsGfjLvdr9fDKvEYBz9B7Km+xfUzSposcjDgeykSxLIK5xX?=
 =?us-ascii?Q?1Rsf7vj48KZIGRr19Gr3RFARoLJcM4hMhoNlk/Ytg47Zj94M+231ysVwf8XM?=
 =?us-ascii?Q?H2yxmEFMlJ1DjszRsVSGu7zuGWSLHbmcO8nyCirepFzMMzVwi7e+ovdu4HFi?=
 =?us-ascii?Q?RwfuT84WmwJTK09n0q3J27xw9NqEgpl95OREM7DVF1xqRUaKcbtLrICabXbR?=
 =?us-ascii?Q?DvjXrHjF6XB3tZbWS0KJc8NYh5xEj6UvKRAAEoavO+p4u//6PtZlGMtq3+79?=
 =?us-ascii?Q?fMwPfPsv7S0RditEZtqwPLAgT4pU6ihWX/rlCJ+fejV6T4mdBVg/KSqNSB+g?=
 =?us-ascii?Q?aKq0ZQ7JQkvms6MbuelVANX/AW9LmjYjcIW/l5d7vLTJUULSmpMghEYU2KMv?=
 =?us-ascii?Q?/oH4cLfa3KYoKjCFU7/Mm81G5VygBi7rvKMj9/a358FcbXQNsqQkgLZyuy/v?=
 =?us-ascii?Q?GR+h+u1QVmC9ST2+tVmTZmdtvHRB94G55+HM11DZPkRR+U0tuvUbghSQETSI?=
 =?us-ascii?Q?2M8cvzOvQ9OSgZUk20LScHRiO4/YZWwoKz6VHTBjvCtXduiTa/OwpPf555Y1?=
 =?us-ascii?Q?nvieCUvr14+seWkGruvJwf1fMfVCmIDxhVzddOnkZmXdOreJjk4WvVxmlKDS?=
 =?us-ascii?Q?UJ2yHEqahEZebo3FlsFwWW/Qdoc5xYom04S3k0zeb1/E4SbO/l2mCKkpGVum?=
 =?us-ascii?Q?vvsQo06wupLIGZBPt52SZraeK+qlSzDrJx7MQmAb+BA7m7T7dCr4CkzbK0L7?=
 =?us-ascii?Q?MSq3Z9leuYf3s1aIDE2Rn75++zXmuNqPIK3ZgGQWMSoonbNdus/rL+QdIwvO?=
 =?us-ascii?Q?wyjqXgI5Qr0IOuIofIgNytfiYvQGKIEPkAZF0wBpUIHk9G+9LS6mIhKY0OYN?=
 =?us-ascii?Q?fo5JlbDG5evj/5F58L4GuOIc+rnMc5FQ1Baqy3YdNiEPyPi+TO3quYVZzAy0?=
 =?us-ascii?Q?b4aVDyLx59HMNnzdfZ778QRK7fRg0HJ08qHWw8xDVFlErpKf47fWMCft+q1A?=
 =?us-ascii?Q?4rCIQq71ojgP5wX6aDAjR25QeoYrhcOoAqU5M3meq/w11byvfCXErqhM1+dX?=
 =?us-ascii?Q?agNXIWew2VtNgfk9Kz+P5TErLabuRiIAY/g4EFU2FaE6oy+B2AhoC1PdjRMI?=
 =?us-ascii?Q?aEbw+99sNt9vSYmwJw80pENMq4wNw26MGCpH2pwvg2ChZhrZZuNfw/tZniWU?=
 =?us-ascii?Q?0wHo6uOaNIQWcdhob1HBveeleNlopGVf1L755w0jBDvTCgnIzPlfNRK2GQqc?=
 =?us-ascii?Q?TqH+TT4iX5vpHG8HkRtlPnfRsUOOW1XUawE1W8JdSI+tM6WBAEdMZy4OUMz6?=
 =?us-ascii?Q?5OY3e1r6xD6VSjRfWmKSK5Qk6HphulM07rhyZ0/tKPsGr54vBlb6mpsXPwNL?=
 =?us-ascii?Q?A729rZ3N/dIGw5DVgTMC0s3XLc6dQTXbiZJBZp2ex4CMHCz0rbF7H5dTZkIw?=
 =?us-ascii?Q?5C9QiZwe2XPBhfu0QdgfEymc6uWDsFWd+zyznxfeZ7c7tAceGoa3fQEWy0wC?=
 =?us-ascii?Q?tz2HYJENPK6JVUT5r3LfW87dlZX2ZLH+y0zgodaeRLE27UWnHLG27Vp9sh73?=
 =?us-ascii?Q?vE6S7hzZmabcTPgezr0GJSB8E30BChKbml+CJwtXSxMB9sNx//RWwrLKbZfV?=
 =?us-ascii?Q?y3IjYikrllr/ksDnNDQhkdsRqtclWtmIX5f4Ys8Xkb8pDW09IiVO7xvZ9tF9?=
 =?us-ascii?Q?95re+q6P3khQ2RiWr5envul2Rbii0Kzh2aOOxFUmT6hAYr1oHd+E?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d35269d0-432d-46d4-a17e-08dee1b05485
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 14:00:58.5376 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bz8avz5X1qCk41waDsuYaeS5sSDygM/dZv6Fs5Ien6s5EudH9VDwyVRCkFpMz/CFxmzUFjuP52UFSqODCgyrIxqg6K9F+KnWwhNbP9mcmA9j0YcF0kDIsUvscpPVNyRE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7245
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

On Sat, Jul 11, 2026 at 10:00:52PM +0200, Marek Vasut wrote:
>On 6/21/26 4:06 AM, Peng Fan (OSS) wrote:
>> From: Ye Li <ye.li@nxp.com>
>> 
>> Call board_usb_init() during dwc3_generic_probe() and
>> board_usb_cleanup() during dwc3_generic_remove() to allow
>> board-level USB configuration (e.g. Type-C CC role, SS mux,
>> VBUS control) before DWC3 core initialization.
>> 
>> Signed-off-by: Ye Li <ye.li@nxp.com>
>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
...
>>   	dwc3_shutdown_phy(dev, &priv->phys);
>>   	unmap_physmem(dwc3->regs, MAP_NOCACHE);
>> +	if (mode == USB_DR_MODE_HOST)
>> +		board_usb_cleanup(dev_seq(dev), USB_INIT_HOST);
>> +	else if (mode == USB_DR_MODE_PERIPHERAL)
>> +		board_usb_cleanup(dev_seq(dev), USB_INIT_DEVICE);
>> +
>This is supposed to be generic DT based glue code, can we avoid the
>board-specific callbacks entirely ?

We need to invoke TCPM configuration code, dropping board callbacks means
we need put some #ifdef in dwc3 drivers:

#if CONFIG_IS_ENABLED(TYPEC_TCPM)
static int dwc3_typec_setup(struct udevice *dev, struct dwc3_generic_priv *priv,
                           enum usb_dr_mode mode)
{
	/* Handling tcpm */	
}
#else
static int dwc3_typec_setup(struct udevice *dev, struct dwc3_generic_priv *priv,
                           enum usb_dr_mode mode)
{
	return 0;
}
#endif

I could use above in V3.

Thanks,
Peng
