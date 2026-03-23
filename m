Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32DE9D58CD3
	for <u-boot@archiver.kernel.org>; Mon, 23 Mar 2026 05:14:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80ABB83FEC;
	Mon, 23 Mar 2026 06:13:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="cTAXfwmF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB45C83DB6; Mon, 23 Mar 2026 06:13:58 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4E38840AE
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 06:13:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JBPcD8Kha2YfMqCP6+dUp0SwgxZ4o0+0XosjCRwSRMI4Z75Cu/eGxcw5kXW9IPJuacUOSfcVeuEMB7QuqlqO55bdzpHWk1xbUuk/jMJ9sUPjyfExMC3VbEGCH4A/eYKa/F8AQhdXnpUkupobcCZ8V/JlVk2tP28jng6ecVEjOJtwRKtY5HKIMWrjxW2smYCuRgK2GJipB0VYIjcGD7kgy0tXwo07MGR39rlO3vn6PekaPZvLGbezWDhp43aYMkxO55mUsCC/eD2oHkhD8hbcm0+xhNvJ7MyiWQqKHYprWfmP0MASbb2RkKnh5lQU3ZHdCHrHYfSngya0cf6zpaPyNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1JtelLuPNWL7AhPKKk9heUr9Z1uDjL2MmdMKZtLwoSo=;
 b=A6aCH9pNXMGR1j1KxlscrhLzsi3VkONuMsMezMnQNYbS+AOhOYC8iX20JVr8XV0q/zK5xe4vLCwbiKGMoPWhkhSD1pZJV3kVLKjEgxekdHttnB9sXsOdqisXspLncdj3T5MIMeICxC1t1gdI8hugpe6g97JPLzqSBvsH9nOnXveH8f4R+V/Aye7/yNR8T/NF8Oa6mRf3wwhP3kiSFweO5nyY1xFimPpbqkunnEMFfWUilNNVpiU43Ostp2NN0f00AI9tGV1sLW6PoC3252gGSWCUx24+CkWjY+1RH+jWYQn89uJKW1ycVlQxKQ3NmkIBXML/81d8lLrjGvh2fXQ9UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1JtelLuPNWL7AhPKKk9heUr9Z1uDjL2MmdMKZtLwoSo=;
 b=cTAXfwmFWUYZAh4TPJj65ymDV2XA4s8+yyRRP7EntSIamWoc93A0Iz/A8FYanHdNyUFH7PPM9sbh47p+k2DoSS2mHW/eePR+ZvB++Ka93w6YxARo1IFs99HGgBlI4ijOylsqeZ45Z4oyD/eMxV0MWnkP/vi4rRJSAndRhZW7EZy0RvYg0WLYqnsoD4cWTYeEhtM5RQhO9btn1NYyBLn7dlFSOIObXSUQibZ/oY4WEI/W/ZkNXdCdWInUrJa3+KN+rTHPIa0NAjpaGTfxiS0U3kjiV/v2ffTcO5XBDk69BcSSEm6cmZvnSRqcipW7QAhw++H7i/+FVx6s9NE936FGHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI0PR04MB10317.eurprd04.prod.outlook.com (2603:10a6:800:216::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.25; Mon, 23 Mar
 2026 05:13:38 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%3]) with mapi id 15.20.9723.022; Mon, 23 Mar 2026
 05:13:35 +0000
Date: Mon, 23 Mar 2026 14:29:42 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Michael Walle <mwalle@kernel.org>
Cc: Vladimir Oltean <olteanv@gmail.com>, Tom Rini <trini@konsulko.com>,
 Ashish Kumar <Ashish.kumar@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Kuldeep Singh <kuldeep.singh@nxp.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 0/3] arm: Give the LS1021ATSN board some love
Message-ID: <acDd1gtGZNz84htp@nxa18884-linux.ap.freescale.net>
References: <20260318142949.2479033-1-mwalle@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318142949.2479033-1-mwalle@kernel.org>
X-ClientProxiedBy: SG2PR06CA0232.apcprd06.prod.outlook.com
 (2603:1096:4:ac::16) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI0PR04MB10317:EE_
X-MS-Office365-Filtering-Correlation-Id: f2209ed8-c80c-4b45-addd-08de889aef16
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|19092799006|366016|1800799024|38350700014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: +3CUxKRd97hXbphl35SslMKQPf8YelT/XS6CgiO02Z1YpgMTdyumekzXkyKiGHyUFHpIKhx+FN+7faITbdlSXWrp95zYvcKoFjEismAtWB/I3Q6Jid6U05MPPQCfLfP7WvTf6m0/o+8ysQZc1q5vvXT45zvxHGn68Bcuc5ihQAdNU8czAYrcsZIg6sYJ5jjWyXYPMmGjBbl/eAHHsP/VtwCqJK1zPBVSQdp53D4mCRlmsygYugBxUsM/zWwPSJkUxYfmoHsrWK42eLD7M7wDNYGqD6nUu6jx+d2FUCqFLMO/I70YbW2Jm/9YkRJwU1fXJdx+i8heWKSRqO35+dz/alH00GDAPfTkGvvExJGCZ0kF6d3whpGfvm9lJDgAGX6MMtWhyIROmHBlZc7MTAABXWffsXSVK1/p4DKmhjEePQUhAL/6zFb+xv32KU0X7NuiwdqeF3gZagUfYUHT06zVk6PX3R/nT0pYQczvj1FLgEEmjqTiL8XW8KhHWjCtdZ/54e1JXSJ26avg18grIpG+u8k4YcriY5C4hCDq1QFeTudt+Pban8jW4UMrxHapA9fh0BoO8uJXx7yIparXzgtkf1FJU7kVTuLURccZWm7QxcMUDQc92mRUJzdAWce0w3NOe/unfSaDMZiZYS06sdofSZWFTTFrbHHfzgr5Zy9sD3ybN4wti9LYshV5mciDZFSlWqzQu7d72689jVmEhWYtv3ZJzwwcIkXyS/VQZXl7+3pQM4ua4g6znpYaIh7yKDoCXpY4FQO2JK4CwmC4zgJgun4b3ftDj+K229D0ecslLvI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(19092799006)(366016)(1800799024)(38350700014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yTT2s2WgNnDHbPdJ9WQ7AybY4CDCtbbIHEXejwM3HUX9DWsOXnSNpSBbc5wk?=
 =?us-ascii?Q?mC97YNIBOkF1V70ItxFb4Xr1rbI9MwC/pWjwV9p1/EkN6ZMSLIT8mbCehQz+?=
 =?us-ascii?Q?jQxozu/gzF3fa3C5w0xKiK4DQ7jvQTLQdZX6ixmUXJzJ/+fnt1YkSQlQFzls?=
 =?us-ascii?Q?/uq3dRdCdYpC8Yry0uFJBldft0XGI9ro68mM6LujnrxVnVGuIJK8ChfolgMk?=
 =?us-ascii?Q?EJfJ00rxCrdGxIfKIAJV8sRc5s7ppmVOc2uDnKQu5nrN3q/hvv00FQ4RCcHx?=
 =?us-ascii?Q?W8hweX6jtvLxAEA7bQV60qctiem6ofFBrFGkpakZTEgyD5DAOtFPJaj/asYt?=
 =?us-ascii?Q?1amvjZe2zk1NEEnYCd0J1z2YwROsl1SYo8s9sFIy2oDEB6o0NqQjfciVpXbr?=
 =?us-ascii?Q?GpXbln68fZLe0DNe7cL5vQwGYu2OQm2NIV5/x2qO4OojNzMwWtI7e+hUM+9Z?=
 =?us-ascii?Q?+KsYK+FoMn3V7vfO39BlAzJWrW1WCBpCWjjCGdiURWyXqc0guUqjSFtHwjnc?=
 =?us-ascii?Q?4y/iYH75hHh1IOvl7vFZulyxfVbx4PHO/1SFu+HlbTZjdv4r3UtqCKVjivEK?=
 =?us-ascii?Q?zw6PSvmbJlMQJXVMlWqm3z179tkOKUZrUnVuIVc094mvvRuTpBtHVFQkYHah?=
 =?us-ascii?Q?cqpnNXgTMKDRbOzKf2pkOzOn44apAtXgSAuh5O2mCtv2nvkcSEQfihiY/tem?=
 =?us-ascii?Q?HC0dBYx5cboRaRB+iuIBES6fgt8vLJHz7OiXr629T6fEma8uKPvLFESRLHzN?=
 =?us-ascii?Q?r9RCozCmzd+0IAUOB6k2r/YMG0yR7lrzdBRbAtNGH30yV4p7gez9VRvJQpcS?=
 =?us-ascii?Q?+d+onrYu9WS6Fy0+ZsT8b66PhtOiFK+rc4kEWA9zk8VuzKGAN0LRL/Ka0Kmh?=
 =?us-ascii?Q?59egzh1F3ORXInqTk8+Q8f8grxnA4JPT0tc8/ZzHHzYODkBeE55FHFUTgSzw?=
 =?us-ascii?Q?Fe8kSTZZxWZHAEeW3n6p9CrO4Mj1UUJFllWV+eVr3aQayTz4iOpP2ENoLYH5?=
 =?us-ascii?Q?CMOdUdaAWof8detMF7n+0bD4w6X3Ihd8MAf7jJ/CGCXTNlL+5i5Uri8A800B?=
 =?us-ascii?Q?Ul5N+zJqpJHYrvdpHt52KABytPADCiGWjdExfrF9aMG5a307EyYtfTQZuMgd?=
 =?us-ascii?Q?EC1BpoEEwYE2zjYd9NuS7nzAS37eh0yn51IKE092+HlmYFGcAPwLQSiFj37c?=
 =?us-ascii?Q?AoJAisCzzTo6lu6Bausp43fzw8Kre2Gb/MjY3cmX5k2rBOdHbSEYCOWq2hGl?=
 =?us-ascii?Q?4PE4y4cXuX5tOsOGwf6SiAHAXb+RLySZIJ8YGLJR1+4YFTO0IFk/uusMd82f?=
 =?us-ascii?Q?0rLukZ/7gzKk6xEFRz0FXoWIf4cU8l5HxloKlIuyQsV+ArYvLaTqKQDKqIzH?=
 =?us-ascii?Q?1ERKRQRlaSXhdhHtMPkkaAtTdtFh6GqhXFZyV4sN4ANy98btEPAoSdCpYQX3?=
 =?us-ascii?Q?ZB1FkUKJJR4p8vtSeiSD7e54ZKJca88zp3vTYEULljIbow+mggPaMoKkjUhu?=
 =?us-ascii?Q?AosfCHAOLBxWXbDg/1nQW3p3xxvxh3yk8x2hQL3euI2YBlVXS+9EPOxIP/p4?=
 =?us-ascii?Q?RGxzS25SJErl3vtiYsR6PFk78RxiOegK+DPIJb10yjT93e+k2UPT2Pu+CT+F?=
 =?us-ascii?Q?h9wQVvtrVGkrU7vlJWLqF1kJ++uPMBBvJ+VE1UL96DGAX32g1CN+seYLfM3h?=
 =?us-ascii?Q?8CwEG2tnuYdudifmfK6DIDno0wGQZSAhFkp4vyi/wNbDIKMsncVjqGwU2iXR?=
 =?us-ascii?Q?sZtL3UJnPw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2209ed8-c80c-4b45-addd-08de889aef16
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 05:13:35.6495 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gh55j5i3m4z3W1LB9th9A+hJYiMIsyLEP1rdrD6Vx0n58V/OixFrYdOtcBV1nYu1NWAjaYnQEbORZpxdnBTAtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10317
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

On Wed, Mar 18, 2026 at 03:29:14PM +0100, Michael Walle wrote:
>It seems that (QSPI-boot variant of) the LS1021ATSN board has been
>broken for some years now. First, the SPI clock was far too fast
>which prevented booting from it, then the serial output was broken.
>In fact while debugging the issue, I've noticed that over the
>releases more and more stuff got broken. SPI flash isn't working in
>u-boot proper and the attached ethernet switch doesn't work either.
>
>
>Michael Walle (3):
>  arm: dts: ls1021a-tsn: add default serial output
>  configs: ls1021atsn: enable serial driver
>  armv7: ls102xa: fix SPI flash clock
>

Applied.

Thanks,
Peng
