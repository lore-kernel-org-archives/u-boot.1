Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED4CDC6FD1F
	for <u-boot@archiver.kernel.org>; Tue, 26 Mar 2024 10:22:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0DCB8803F;
	Tue, 26 Mar 2024 11:21:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="lMU1Wlof";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AE8487F5D; Tue, 26 Mar 2024 04:30:23 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71781871C7
 for <u-boot@lists.denx.de>; Tue, 26 Mar 2024 04:30:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=joy.zou@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IzA3IcAmFxuxpDu6aIW1PNHw2lR5RHK1WxrgxSsW0WagFmq8ycmB+gGhdrk9OFoDql9PBjKwWX/lxbZ88uRID+biGuJF2UozVGIJi+1TgPxxRn01Os8TIp17E6vwqSWJXDqcoggIAuHckVyi0QCYNoF8umW8h2FH5kpOXe3sjuV8A5fzeHv986PJJcPRejXzwXlRMrYzRRaUAuYzgdeaNNkwFANqZaZSTFXkJSBLxpqTjU0jdDyn2fwmH9Jtc0JoR0ryitWfGTcgPTmnPlWPrDNTbbKnPXZcCtYV4k6sCYwFTcs20QBX58mHrdc8Dbz+75lpMUb4APg4UBhnCB2eJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WT28vDbRxdsftaL5+DVaKkkqhgg9YZoX0znSI5+kfiQ=;
 b=B3Dm98EJ9wnT1jIKArnbuQbh54O5l6rr37pvYWyNu4oukY8v1DCJLfOLcj/EK9kTHbIUrU8gkYbQ5RI6Q3+NfKuoPsWNn2smAcwzzPqEkqqsxTV9RvI1gxIf0CZS//9XiShnqFf7xJ+Yhibp3kVSHyKnEWCGPRKsAi/3Xc3wBRUsvHDRSpXO4lVO+UKDf1VoyCAs4jx1HuXHfj5rc65QAWICVoaTrG4+BE+SKRhV95atdDTHiV4Jj/v6hPihZhomkGlfBh36YcR4XqZcaM+LukMKtIckX4fcm/3SqWEr2A3scksiDnPNNtf3u8YCfMJjSLfg1Kmm4px0gWU/PHMd9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WT28vDbRxdsftaL5+DVaKkkqhgg9YZoX0znSI5+kfiQ=;
 b=lMU1WlofbTRAlloIOd1BpQHWV4kSGkkVxcRoqV8+NnpIuzNzEgvABGM0FCLpIyrSTrjChe1zy4slqXmSNqE9FDhx566ajCBEIp5lcq336LebJx2SZn5a0MSSf+lKijDfZC+WPt6IJqHAa/PZ46Z35eMM+hxyT9c1/nCMxUOG5v4=
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by AS8PR04MB7863.eurprd04.prod.outlook.com (2603:10a6:20b:2a8::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Tue, 26 Mar
 2024 03:30:20 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::4f24:3f44:d5b1:70ba]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::4f24:3f44:d5b1:70ba%7]) with mapi id 15.20.7409.028; Tue, 26 Mar 2024
 03:30:20 +0000
From: Joy Zou <joy.zou@nxp.com>
To: peng.fan@nxp.com, ye.li@nxp.com, ping.bai@nxp.com, sbabic@denx.de,
 festevam@gmail.com, sjg@chromium.org, saproj@gmail.com,
 judge.packham@gmail.com
Cc: uboot-imx@nxp.com,
	u-boot@lists.denx.de
Subject: [PATCH v3 0/3] Add pcf2131 rtc support
Date: Tue, 26 Mar 2024 11:37:58 +0800
Message-Id: <20240326033801.228419-1-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0192.apcprd04.prod.outlook.com
 (2603:1096:4:14::30) To AS4PR04MB9386.eurprd04.prod.outlook.com
 (2603:10a6:20b:4e9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9386:EE_|AS8PR04MB7863:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UyHZiJ1rZ4GjSMT8ZQsUyMpAsXM6nSZ40P6ZBCKqbddFOs7phSW7ZSWIGheAs54qbifzrIedPQOSF3d71FOhNGxIj58pJIO4UoBNSTKj/w2vEhIcK5PnStWEt0cUMklMiZ+q8DrpO48p0+Lwg5AqoOt+As743p0xjuzIgZFP/7FsoJoIMuNcOuiY6ARjCc48TIJ9Q/nMKQeFWZvx38OGSEq+cIwHrVTzG4653OJpsIzs5M6p1Zl4GXiEMmAIonCo5kNNmNWQp0LDVeAWQahvdku4pVpysYHURGlmVt0GkNfmQsAXlIcwIyh60a2CuNoRDkVmjuPUL5N73CQpdFBnmGVRDAJ2p8ITO/yPxLs0XRwMrkxCmFkulSYNyPjXdJOCTb69HlfXrJn8l9uP2Dri622GfiY0FcDSKt8jjL72qP/9xUQ68PCpvLV0kvDpUTAahzl4ZCH0eh2QEbXrKtK0V2jTT7FmzbDj0hdnMdAsIwj93hwfik6ovNkfSwNxeW66EqSIVaMkyhA8n2fWfP2bx+ugzY50KkZHbgCuUxmh8EEqKunfoUDVYd88yspfqlu/a2ylyd1rHatAtSbixhJErhmcNRbfYz0ymGq5Vdo0mqMQb3XpjP++tmw/7rx2H8guK1V0+kJyUJapgk+PYibW5yS4gCs7zmmh8OJ0Ku5t5kCjTAnisszt5jRUwzN0Jb8iTBKvhtgk6StsreFEX5P1N6cxNNQFZKNs1S8mKzT6Oj0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR04MB9386.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(52116005)(376005)(366007)(38350700005); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IKHeFvabPQkgYfaZo0iKPAl4JiNHipu87V+JjZaRg0DevRvWChTAFB/jL+eh?=
 =?us-ascii?Q?t/sFXKmpYgdUzfMkT590cqTCm4CmMMvk6+rOpag/TfmA/LA+ZXJ7rpVy/fNh?=
 =?us-ascii?Q?H68rhgSzVlWn2XPyC8KaTNIXh84R1jNaJPMOOk09823pwcHH2veaqGA35raL?=
 =?us-ascii?Q?lnPSgJB6U/RM5KhmHcsi9nWR/iOtA/cPZLdjpDpO5zSmQGvjIvTHXuF8zpYs?=
 =?us-ascii?Q?HzTH/iV4FuFAiMp6fwzbJ/QvqKTecyev067tZFIJmUNAbpmm8gI2E2J7TZch?=
 =?us-ascii?Q?xTferUKOLnTQUjLtbjnjL6zaUS3sCL+5D1NHhiHol8RrDDiODk5T5Z2gzWQi?=
 =?us-ascii?Q?Bn9S707nTP+R3623UFCYBN/McBN3SD9VFxCIXvG+YSJ16IxbyUmTQZXtVvhQ?=
 =?us-ascii?Q?MNMXfKjZf15r6sURD03ZWFZVIqS9qVNsdobi+96bESk7hgM+UjjuSG7/UVDU?=
 =?us-ascii?Q?CBs55JW1pp/DdNDTzIslZueup3HiFQq1iizVGWXpYVwksNmmpdD0dRv8Z+hV?=
 =?us-ascii?Q?GKisCZHKo+csGJf9cGH8KPdX6LeckjfIQ5vLq+G2aZM1t6oqvlPmY31/EFTT?=
 =?us-ascii?Q?Wr4TKPHmrqZVVOBIRBMzXRKHom6MpaQYM3vD4CldHofTIfFan7KjgD68oJZO?=
 =?us-ascii?Q?gAX469W5WphsRZ1CSDZI1ic6Rzk1cySkbj4v7oC5yFBs76KCTCHR5qF9YzDb?=
 =?us-ascii?Q?u5smct9QHnhakPbMUQCJW6n6odUTqk5pukGfLD35LLGgAcmkhLXzN+GncQbt?=
 =?us-ascii?Q?Cjo/ndQXDDzPMTOQ5JzQ6soTfJvAXcir4k06PL49JVnMlZbN5cZyroDgJdqP?=
 =?us-ascii?Q?7V1g3GRlULeP2YIN+EsrEnxerN62HaLHJRBDWdriqAStnNMwmDFBs9UKt/oF?=
 =?us-ascii?Q?EggttdBAW/2ALZqojF9qXJJsbqgxNOaOAyYmoGJDKXYZN8T523xc44jLj0bB?=
 =?us-ascii?Q?e3sLUPZJHosa4Mi9My4n45ZmNoduQB26Pvdw2gm9JgJ+0aYtMuCi+tCGUJwf?=
 =?us-ascii?Q?g004Kd5EsH/RdoRw38MURHZtI1q+2ySKH8/FtA/z/OWNNHByOiCdbsnvKgUb?=
 =?us-ascii?Q?zBNYt20aM+8VjszzuhEjR8YTSbXi5PqFe6XJJRi9DXhlpsWJnePArNbWXYTh?=
 =?us-ascii?Q?8xY9wYNbTkJNJxv14AYJqWDz5rmgoNEVZzNLDtxSgQopLHc/NwCDHallu4TO?=
 =?us-ascii?Q?3mI14v8t4ehHW6B960jx/YkfIojWBAa+1VTnkvgmhkqK8RtlsfpqsQi5UeHA?=
 =?us-ascii?Q?yuFRv99nsFXz3GkOvVkIDWyeyVmN3i1K5bIbSbNDk1wg1V2oyaJ4Eh/2lb0H?=
 =?us-ascii?Q?bvcOyP8pjo9kQII8208lVYlYdSozkifY0g4wL8SbBAEFtkJDyIH39K7Npyfe?=
 =?us-ascii?Q?5HKbvUGJRuj2btAPDnt6T9H0gIqA/WAeNkJLHcMPyI3cAKB4OQP/M9ITFQ2k?=
 =?us-ascii?Q?8QhXRO7hTmTtfU6+GYOCOdbvRIHFkn/+LaHMXmu2Z1DuBS1GV7mL4hgrJ8ce?=
 =?us-ascii?Q?psDII/8jKw7kHavvl8dY9nrKxUJLgVM+JUGekN5lVsjFtA1DpVFKc2oILflP?=
 =?us-ascii?Q?oZf5pLbAZ9buq3WvysprwVTrpf5gTk/kvBFJTvNG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9ca8fbb-86ce-4e53-6082-08dc4d45103c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 03:30:20.3231 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t59MfCks0QEJqmCkmqMFVlL2BfuK8cwyGPuqCjHyJDT43lowJR+3YDVh4UTENPbl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7863
X-Mailman-Approved-At: Tue, 26 Mar 2024 11:21:12 +0100
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

The patchset supports pcf2131 rtc.
For the details, please check the patch commit log.

Joy Zou (3):
  drivers: rtc: add pcf2131 rtc driver
  imx: imx93_evk: add rtc pcf2131
  configs: Enable RTC pcf2131 support

 arch/arm/dts/imx93-11x11-evk-u-boot.dtsi |   8 ++
 arch/arm/dts/imx93-11x11-evk.dts         |  25 ++++
 configs/imx93_11x11_evk_defconfig        |   1 +
 drivers/rtc/pcf2127.c                    | 144 +++++++++++++++++++++--
 4 files changed, 165 insertions(+), 13 deletions(-)

-- 
2.37.1

