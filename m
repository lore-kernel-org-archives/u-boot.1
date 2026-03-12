Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED261105A594
	for <u-boot@archiver.kernel.org>; Thu, 12 Mar 2026 12:48:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32FD484242;
	Thu, 12 Mar 2026 13:47:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="mWI/JM5G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E65D84148; Thu, 12 Mar 2026 10:52:45 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3D0883F14
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 10:52:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KEEYFyBIXLb4Sc42vGcdgMPa/jKeq3+woh0TcABx1DqBim8stxSMUVimgZZKJTbIGU2AVtT8IlTY8JdtdpXB5ID25wI9fC4hXNFrUr3j5vLzzo9xI7SRuPIkHARjPzgU4YpRtYQSS39AS6EckSlJ7JlfDKAmlVbgRAchsTfL3W+g6Ev0KFSaFvkRer5SCV8jyfbmO0lPyRd7Hbom8EZTaKXWT+7+p23UK6YyWNL8KM0DVCa8YvvxH8JLR4Qivx2YDgSaDiFrMe4DdAWCYBMwr4zZx8fc1s0+gn9zDDyCr6sWSm2UlLGlxfRFr12XuouPwfWq8aRD+sXieV+oHo2w+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Lo486fgq5eywBNhvIm3Qf7k69XTZ4z8PIhb6vnD2yw=;
 b=Nd/yRfemN9Ee0rdu9fSCPBbAvOq5UNXAjSRcTC2mZShMSqC+3jR4bdhIrHRocw5v+V3oJ5Xev2FOkJL+uA7jWNQH6hnLTJnpJOjokHPyhBN9UE1ngP4gdgQWL9tT8rvOwWjEp8rwIgNrGmLqwI0sqKvNeNB++o3h1aH1rl36cAsy4kcN8aFfIpgF6WFAVFKl3UmyLIcB/aehH3jSbcxeIXs4BIOOeg1SkS3mIMjEL81lFSefK3tgJrxXbzcnKQxxqgDliG3fkpt4SCEjRGmEqvI388rAssBdwgs/dG82Hw/IVOLSvWsKg+AgkZpZgWy0TYw8TQTwNicfqXjUYXIghQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Lo486fgq5eywBNhvIm3Qf7k69XTZ4z8PIhb6vnD2yw=;
 b=mWI/JM5GwYK+eU+eJz9T8uk+NT6dYAF6VZiSI0fO+HkSgGHXQl6+cQG/+ju71XYcORp2w2nSdkpuKNtUMD2aE715yLhnpJqqOx2FAVhiWtAbT1CkuER2m6mSddAYUZdtkQIpP611O8ePSRDJxSHuD5q/GhSCJF9bZzkA1oSo8/0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by AS1PR10MB5579.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:477::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.15; Thu, 12 Mar
 2026 09:52:37 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%5]) with mapi id 15.20.9700.013; Thu, 12 Mar 2026
 09:52:35 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: <alice.guo@oss.nxp.com>,  NXP i.MX U-Boot Team <uboot-imx@nxp.com>,
 <u-boot@lists.denx.de>,  Christoph Stoidner <c.stoidner@phytec.de>,
 <upstream@lists.phytec.de>,  Joseph Guo <qijian.guo@nxp.com>,  Stefano
 Babic <sbabic@nabladev.com>,  Fabio Estevam <festevam@gmail.com>,  Tom
 Rini <trini@konsulko.com>,  Peng Fan <peng.fan@nxp.com>,  Ye Li
 <ye.li@nxp.com>,  Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>,  Ji
 Luo <ji.luo@nxp.com>,  Marek Vasut <marex@nabladev.com>,  Jacky Bai
 <ping.bai@nxp.com>,  Stefan Roese <stefan.roese@mailbox.org>,  Marek Vasut
 <marek.vasut+renesas@mailbox.org>,  David Zang <davidzangcs@gmail.com>,
 Simon Glass <sjg@chromium.org>,  =?utf-8?Q?Jo=C3=A3o?= Paulo =?utf-8?Q?G?=
 =?utf-8?Q?on=C3=A7alves?=
 <joao.goncalves@toradex.com>,  Primoz Fiser <primoz.fiser@norik.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,  =?utf-8?Q?J=C3=A9r?=
 =?utf-8?Q?=C3=A9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>,  Mathieu Othacehe
 <m.othacehe@gmail.com>,  Francesco Dolcini
 <francesco.dolcini@toradex.com>,  Jindong Yue <jindong.yue@nxp.com>,
 Frank Li <Frank.Li@nxp.com>,  Max Krummenacher
 <max.krummenacher@toradex.com>,  Ernest Van Hoecke
 <ernest.vanhoecke@toradex.com>,  Emanuele Ghidoli
 <emanuele.ghidoli@toradex.com>,  Alice Guo <alice.guo@nxp.com>
Subject: Re: [PATCH v1 01/10] imx: Add helper to get watchdog base address
 from DT alias
In-Reply-To: <abJol9LRGVDhfAnO@shlinux89> (Peng Fan's message of "Thu, 12 Mar
 2026 15:17:43 +0800")
References: <20260310-wdog-v1-0-2ee21e890634@nxp.com>
 <20260310-wdog-v1-1-2ee21e890634@nxp.com> <abJol9LRGVDhfAnO@shlinux89>
Date: Thu, 12 Mar 2026 10:52:27 +0100
Message-ID: <87y0jxpe78.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: CPAP307CA0011.DNKP307.PROD.OUTLOOK.COM (2603:10a6:380:3::8)
 To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|AS1PR10MB5579:EE_
X-MS-Office365-Filtering-Correlation-Id: c87b9286-df0b-45ef-c389-08de801d15c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|376014|1800799024|366016|38350700014|7053199007|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: AlEuxfyTX2LZeD3LcVttz/8W2debvWnHpXnhl1tCkU6e9NnyO4ATPrZoZDfSOSgAGmOhD4TAcDOfqZtg5s1TGSgWElnNddInf8pb42quPiaJtARLqbfDb0PSxVUn5DyeE2SMTFqNgUmW8ICerNivdaJWgH2+S5tI/HpzHcRgZbkyFWY2aYBkQ6QxapasTtbyy6UDNS20+BKuM9UerIp7cAnTqfitYYwJfQygcLt32BpRUQhEhEWqDnDeEgSS7kI2Hh7IMdjBY2mU4cZT7ENbN78X/23tdgt46qZm4+9ddx7u5+Sj4nMlEd2rQqqTgFjE+w2YZV7Vyd3ufxNhapqOBgTdX0cPnMMV6XLq1qeRYwt6j0O4qqyfcrTYZdWUjIkt2rXotRnjA9FgjILzWMNNI52xhIH3oMs5uyKJBRb3FsH4tAWVt/0N8EV2Jn+/piZzzWRFp3D+YRxrUIauEJxO/v4s+miWtr7c49q3zP/Zrayspool1hyicL0JKa0SsYCsclB1Qs4JPr1fQhXIwORb1CaVF5RgW348xbP7OyNKILJCsJpKqJt6Mx7dIZ4aw2uZfY0uwrfpnSG+lCK383Nl8LBm0R0cfmgQTesHQYJ89Qg4iR32z6qW7bKrU31JRDvlKl11qsmfxOgU+Z5ySjeV4Ls6ulsIgL69kLFoW5r8qORQT/r+jNYbMVoNvITGqJ/6L1y6IU4xjrhjWrZ6ZASVP5O8l3GoBlyL9aVmS3EH78g/KjCkLOnzVgw05JaqtA/l8qr+ct7RVUkiMgAB01LmGFstnwX7Wx2p1XmSkBLkBfo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(366016)(38350700014)(7053199007)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?naTbs6dhwW0OlQlCg8s50sXUX9O8jbDoXsCxKPFg2QtOiqh8JVxBndMVAiom?=
 =?us-ascii?Q?QaXrMwgyj2+zy6lGVDmmzeX3+2zXqSm6l9jcdHroS86MSKYlCNmjKwhlHuDg?=
 =?us-ascii?Q?UqU9eXFy+0gXS/b5Y04Oev9LrYBl9mn/ZPI0N3KCD0TcnlTKI8Lm5jIMFcLm?=
 =?us-ascii?Q?nWRQqMf8OgGfPA+BW6jV99JT3Vy6yJbTbPHv0HdOkWerwJd2yHd/GyLJFr6F?=
 =?us-ascii?Q?SshWAIn9FjExr597iES6tPJGZ72KLrs0U8Ai1qXTSao2YMa3UDRbjyGMNi9d?=
 =?us-ascii?Q?y/ZJ+Ftk9umzHg38vX12c0U2XDmdPyZyQqpCKiyhFpJ+j6CYk6KI0suHtSRa?=
 =?us-ascii?Q?WGrELsiEgyIiCE7lCl8hOXOfkxAUD3KSFrSyh18QQnLwGCW4setC+uZKI5qo?=
 =?us-ascii?Q?74itTg9S/Hw/PhXKF1nS/2cbpMYEXFOv8aRDP/3NSNZXlfzHPZThrVNtwLOK?=
 =?us-ascii?Q?kAUmqMmjHk6jYoPBEkzJJard6OTQY27wNyrg1o0P1lKTnnpvhxrU+K+6RpBm?=
 =?us-ascii?Q?ZgQGiVF04DcAZ0w7YBvQQH+oMIk/uoUWIfmbg2T9LjIJShjfdXh7BFmWMeH5?=
 =?us-ascii?Q?/L1NTgogtFS9jq8gAIyqjmzWOLw0lPD3cxir5MmZSV3KamJsQUoyiWF9+ybm?=
 =?us-ascii?Q?CJi9pYq1OGqyK1la+LDpKdPlH0KdAr4hoo485rou2McaeinWyi+vCP9Ti3jH?=
 =?us-ascii?Q?0tq5Vx1+w10PQYv2gyuiXSCYemd5oJdYAcNr2EZhE3sq2n9uBeIU7mHraelj?=
 =?us-ascii?Q?NIuCN3fy9RgDYPB/ioumT8ygcV7fosyDY+g+L8CwIpEy8RbI1VAzdJNQwD4L?=
 =?us-ascii?Q?o5p8I3NXhDgKw6s3sL9hVJdrzsD3b88j2l5xm0xL/iUGfImbMuzXDRDx02m5?=
 =?us-ascii?Q?xxpAxY3uZKuNmiOC1ZoQCVyEuulvy6CKhwKhcvQItdzxchkxvgItySg6rBIa?=
 =?us-ascii?Q?mjXlUOBs4LKbBIueQIsV6ftYzTX7okRQSC+jMS124RmwvFeDD5yKCoZ1Awx9?=
 =?us-ascii?Q?SfJYOGpqB9isG/rnBF81W2dTaPlVwOe2xEwPnSDabUOj4bAkN5vrMLLemHnu?=
 =?us-ascii?Q?tbfnnnmmn8d+vohgCC6W2/0HT/x2Zo60pV4aB4lQVnMwKGFxxfvqdZWvCAbt?=
 =?us-ascii?Q?Jfa3X0d+8z57YCvYtbbFWqIrPykOO1+1T7qTZj74pDbURJb9yAqPk5jjtZdy?=
 =?us-ascii?Q?vpIzHRONbRWvGsz9E+35I2aQpfwwUB3gFSsnE97M/EDr1kdi/Hwn/v1Z50gb?=
 =?us-ascii?Q?AwjY4jKH1B7u1s4XYP9Bb7LntBiXV9FwX6xDQwIzgTVjpXpoddOhki7JyhtX?=
 =?us-ascii?Q?eghiXwrAM4LB/N3C0A2JgJfXA0FezEqdqnWv1OAfk0kDTBdqSqS9/Xb+lHZL?=
 =?us-ascii?Q?hRNWhzv0OoF//r1e/M1zRtB9LbB76g4TUgmhTAU8Cth2bPlrExPfMlAhnZEO?=
 =?us-ascii?Q?e8VFHtUH6D+ymiP2cvywp9Zv7dpcPcGdXH9qKFC2PW0LMhuPA7x1qt3L7Y1y?=
 =?us-ascii?Q?QHjqnfRfzcON0K5WvQlyL3+hiqnzQcfGJc+0pghYd34oCjAODlIDlqmoH0EV?=
 =?us-ascii?Q?Wer6jd7gZE3F+8VoKrmBgrU/LrgT6bl8YzmDLYhz0tNfdNCGD8ZSzGpII7yL?=
 =?us-ascii?Q?fMEk53Pcg4AHTd0LyZNt1CGXcVW0f6a9iCBl05KqnR8QHhAAIo7/ySE1cxZA?=
 =?us-ascii?Q?iHumIJ6zEJf70sRevedQtAoGrio+3dh8ZSYwrMRnt8KeVIl2KOJqKloQOlES?=
 =?us-ascii?Q?Ww0k4YMNNHtVb83dowLqdH8IuJLd2Fc=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: c87b9286-df0b-45ef-c389-08de801d15c0
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 09:52:34.8947 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3yELt5JXgS6Lqf/TrsYIyF5+MbiWEECCFmyBnVxYrjNdO4WABVyLHcwQmWV/JSFrg24h4yZueqh4z3myurq28rI82I3S8ypZC42NvaL/1so=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5579
X-Mailman-Approved-At: Thu, 12 Mar 2026 13:47:43 +0100
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

On Thu, Mar 12 2026, Peng Fan <peng.fan@oss.nxp.com> wrote:

> On Tue, Mar 10, 2026 at 03:53:35PM +0800, alice.guo@oss.nxp.com wrote:
>>From: Alice Guo <alice.guo@nxp.com>
>>
>>Add imx_wdog_alias_to_addr() to get watchdog register base address from
>>device tree aliases. This function is used by mx7ulp, imx8ulp and imx9
>>SoCs to locate watchdog hardware.
>>
>>The function supports:
>>- Matching specific alias (e.g., "wdog0") or any "wdog*" if name is
>>  NULL.
>>- Optional device tree status check via check_status parameter.
>
> I not see wdog alias is used by anyone.

Indeed, don't use the stem 'wdog'. Use the stem 'watchdog', as e.g. the
linux watchdog framework does enumerate watchdog devices based on their
DT alias, but using 'watchdog' as the stem:

drivers/watchdog/watchdog_core.c-       /* Use alias for watchdog id if possible */
drivers/watchdog/watchdog_core.c-       if (wdd->parent) {
drivers/watchdog/watchdog_core.c:               ret = of_alias_get_id(wdd->parent->of_node, "watchdog");
drivers/watchdog/watchdog_core.c-               if (ret >= 0)
drivers/watchdog/watchdog_core.c-                       id = ida_alloc_range(&watchdog_ida, ret, ret,
drivers/watchdog/watchdog_core.c-                                            GFP_KERNEL);
drivers/watchdog/watchdog_core.c-       }

Rasmus
