Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AC1BEB365B
	for <u-boot@archiver.kernel.org>; Tue,  3 Mar 2026 03:27:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFFD583F64;
	Tue,  3 Mar 2026 04:27:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Bji0abKp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B086683F2D; Tue,  3 Mar 2026 04:27:42 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BC9983F2D
 for <u-boot@lists.denx.de>; Tue,  3 Mar 2026 04:27:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=spjgAXu4+pibb2e2bi1yTI/9Gpgoa+8jC76lzsGGYFX2aXhpTckosmp/eSHr/xPaFz5baUKhLYibR2dnyBXBN8YtrLza65G90UnvLbU8Ec3fG0BVN1U+lHmuse9n9XxHhbCuLAyOWfu4FrwRk3uHZVgBLQRuZ+cGQRDkKzu/VmBsNmqNY2Zi309RXR6V3NFGUF7oueuAqeO96bXJdkECwd5ZCuraBlspR9dDhHrpmjDkHkrkhCrWJzLO9qrCRCBhf2q5aKcv5IG0Adh6fiytfNQFi3XXYBUSw4BEqFhWdzeCAnZSYRA7pkYkdZChhWa19HXGQbeFLnN8ZChXrdHmlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3nhqO1muQV/3apfRrtVclCRqBjMn/xtgB7ITKlB+N9c=;
 b=wXJ6NEwL5/DEdrGwB/s56dyAJsAp42c2QNdjZbHykWFmc9juEbk1JuJtGCWpnCnV5UOlOoX/d3hQHe1GhP47s9INskEz0xYnWHx4TEmhHceXuAs3YgFcOnzAdF+hSPWOTctEKnDgpEcfdE0qYi7ADiNPBb03vPWBafgrJ38BwI8bzhMwqqMj8dsYWnXU9MFZ+xatOFQu1db5ezPGzIjjw6Vw8uwcgkDVVE8YcnPrYhuLQIurSA5WHhtCb8WPpfaX7sqpKObV5XY0K6lWZiN44HadulhHsaWnHocsrg39qi6sTvMEWkcyIurSjBvuRvD3+MxBQ6HkjiTfVticcL7vKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3nhqO1muQV/3apfRrtVclCRqBjMn/xtgB7ITKlB+N9c=;
 b=Bji0abKplM87mUEgOLu/3oEpKge4IgqZFmcIJMGR9vnT1yBpD9H8C8u+5ykMf42ABFfD48E/i3XadRLcCvyZcQOVuvgVKqc0hVh1A81xoPP+waxYGlE90nFW+ChTSfQ0jTA82y/MzjS5QzsiG24JoLzS8W+F/8Zt+lqFB/ZkmaND0SIjrHV/unCuMwnDnPECAx9u3DPZsDDvB/1XgwBsb40NOTA6M/XeR/B8OnQa7X3/h2MSi3eEcaQVv5E/Kzk6tJOJRyqHFJqkMjcq/wvCASowNZ3QjvgXkK2lT52ITy6+oCqQgDe/c8YY03rXRJRFkwzAuoqItV8r3d3KBuBc3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DB9PR04MB9498.eurprd04.prod.outlook.com (2603:10a6:10:360::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Tue, 3 Mar
 2026 03:27:36 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%7]) with mapi id 15.20.9632.017; Tue, 3 Mar 2026
 03:27:36 +0000
Date: Tue, 3 Mar 2026 11:29:31 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: alice.guo@oss.nxp.com
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, Greg Malysa <malysagreg@gmail.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Peng Fan <peng.fan@nxp.com>, Raymond Mao <raymond.mao@riscstar.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
 Ralph Siemsen <ralph.siemsen@linaro.org>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Ian Roberts <ian.roberts@timesys.com>, Ye Li <ye.li@nxp.com>,
 Jacky Bai <ping.bai@nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sam Protsenko <semen.protsenko@linaro.org>, Alice Guo <alice.guo@nxp.com>
Subject: Re: [PATCH v3 2/4] misc: ele_api: Add support for XSPI SET GMID
 command
Message-ID: <aaZVm03WW1iRuxLX@shlinux89>
References: <20260303-xspi-v1-0-8383ba6fdda8@nxp.com>
 <20260303-xspi-v1-2-8383ba6fdda8@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303-xspi-v1-2-8383ba6fdda8@nxp.com>
X-ClientProxiedBy: MA5P287CA0132.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d2::15) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DB9PR04MB9498:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c1fcce0-aea6-444e-9d02-08de78d4d0b6
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|376014|19092799006|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 3w1W9Hhfst9Z48/uZ8w/KdhWAOuE+1eu6FYJdd1HZBY+rkG2ZdMd5NLlPL8FBDupSPl7/gtxZOhYZ0+dTeQRYiOh12D4RaDHl9Ylvd9F356vTgofB69uB9FaS6yb0idcPuaRMobhNwBDvWA+rLWP0d/SZppT00fhrFzcaShsFdr3wkD6XYGJhMSyiTtVnLniKYdhfA/obHKeqUfljhunbpf2CqhxeOSlyRKGTl94UOd46eLR/1I3qtFbn1CSTyMMw+DZj9dN1iSlaqVmP2bxrt7UesFN1ZUrl9dxX/REekb9OwxHpjVVFo6tgXHfYmt3Kdq5U8FNMyAHlJIpHG/NEfkPptZTG9HTPsaitm7lmpsAwNKZh1HjRINWEamneBcdrl/OUan7+dRK+cwWOwRKeJUOaTAXpDFPJCoYd1aP046t02SmK1I36xoKWgAVeoLBWeFjTBkHtavMgVg+aFb1/hcxQZm8LbyznmJT0tSakUnZzKDV9Cw4jfK2ZbKU/5C1kwXHgyAb96u067gM8Zn6FHhbv6oSIxQyHdij8C7q2Qqm/5IOI+I0BKHUSZrScAQyUnaU+agDqOHXP92vrZvjAVsUDfRG1uzbJP+zvb22RQtTIoAQTO31vHFSakYFN5Tt7tETJpBYNJHVxDs4x76ZR7WVYy7NSBQDgeobQdy0dKI+9JJZohPuSancWXURPE6w3P+uXROHcIik3pWKaELv2eBYRGK93nwz4/f1uT9mXzDe0vfP/qqIScL3o/cpNXF3Y21pU70/6aZ748TcCurXvaAA77tpBFQZJ24/j6jrc4U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(376014)(19092799006)(1800799024)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4SqSk/RbxfC58hBPQZPEHrmaDD0qJLL4oibSh4W+egYfZvz5xokFyRYEuqXx?=
 =?us-ascii?Q?UzCz8K7r0T6qfqmf1f5mFB9pAYHwKjhUZc7DDrJMEQ8zc0Uq6G70t67h6Vik?=
 =?us-ascii?Q?MlBzN3cGSUgR5YGG0m3Bcq//yRLTtKHjnWr9Z8uEa6W9wyVcvkBov/TkDBmS?=
 =?us-ascii?Q?yM3dqn1cnVdZb8e8Jv7YqgaRxYgowMzNt3m9+U7TMy28jyIg3HozhQhbIXub?=
 =?us-ascii?Q?mkKldboNkXu9VofcalPiOjqJBV+gEOASq+zPHdUMgLps84NYmM/JaeVCRGE4?=
 =?us-ascii?Q?IPDVuKAcL8N9K/OslV/hA3mHri0iX1Om0XA5lAL7MmYpjbP/3M6pu46MFVA5?=
 =?us-ascii?Q?4UNVmm0g8oqUdeWs1Kw8hcS1pH4SL6hX36fyVYzaAlNT2dIXEO5SsVtgnH0a?=
 =?us-ascii?Q?+w42JWGHxMVCL8FbJQEPMpNZjRHbGzhiEKQzE/T9/UXt05W4x8j8KXeatbKo?=
 =?us-ascii?Q?iwfhmzotuVSrqOLygYBJUVaJB+bWlLlOWCq5rDCspa1bV6WkK36AVSUCx+aN?=
 =?us-ascii?Q?Mw+QfjJLzMELRvw79pDQN0lNAm2n3RHfIEmXGOUTgBpqVWqN50DKZib4kUfo?=
 =?us-ascii?Q?ztOvVhtVYEJ88TYMBHDu39Gl6XlmkEmzvOyN6c5lO3iIASXbnFxdvgnDkomj?=
 =?us-ascii?Q?vBc+C/37zMGxPkFcpcBK9T5LQxBJadiXorfm96lhoslxMA9hTPLjy5zz1i8s?=
 =?us-ascii?Q?j7L+UMi/rfFN3ebMBP0J+Sjr1HegkjroNH0tf0bNnkbwpMW8WA7OgaHvts4K?=
 =?us-ascii?Q?brQIer9UaAafwUmaWFDUKNy+vdgZT4Q0s/pjA7kotfoCE1dUOfgaM3ydYB3r?=
 =?us-ascii?Q?/QU8GaDPozV3j4x+HKETU9FDUqWCYrVeSvN2qJpUc1X2AjavnIHJHH/4LZFW?=
 =?us-ascii?Q?t6OSgOhG8Yih/ZYEwVNSQdxU+jj0JfIlvavmT8rbFMCkOrxcVO3Uh4Eg3Jkd?=
 =?us-ascii?Q?Mag8Ex/a7T8pXrjAMDPItIV7Dlqs9K2D64IO8SAda0TxOCrgjWLAAzQeh3YD?=
 =?us-ascii?Q?GvVD1AgJoP+A+mV8EbxA3fbh9brDy3kVTM9iT3PfHHkccgC7DTsdiQDB++WC?=
 =?us-ascii?Q?lPZKHei5e8RVBcYpuwS78pW8K1WUptacMgJZ7ToMXBD05IeFm6nSOekZF2GQ?=
 =?us-ascii?Q?kFrn6397XQgqeoN74IOZ0neFT0JQqzjUqVw8nSClo+h4Kf8P70C/8qlCrKNy?=
 =?us-ascii?Q?r3JL5IRRixsd8TPT+YvX00iuBS4zVqPkflWFJcrBdpoxcvuzbN3zJHYX+mKQ?=
 =?us-ascii?Q?I1H++VKXd2PuQFYez41a6OuKUf401eA9cj6qXjC3CVklKRQPMmTXlbPeJlY+?=
 =?us-ascii?Q?iMaXubGtm+01XEYhWmAIa+clmGhX6ipdNSajgLmALxa0jg6hPmJ/hODGM96Z?=
 =?us-ascii?Q?jQC3JnIzZdICMGD/ItUeosjI64J7l77Qtt+NPcN5zoqcltTklOzWEskxZJG8?=
 =?us-ascii?Q?W2f3tngrsBRYPISwGcLTpmgflwAZKtI3eOri4q6Q/1m6btPRjdgeKHYos5mR?=
 =?us-ascii?Q?Cl1CsBrWxDNiQizn6DXXbIxtXXb9PPC7R+wktPGNeMyNNXLODTgMGTak1ghh?=
 =?us-ascii?Q?gYGumNDRyVWn+xbZOXS6pY1bnftZ827IG1oPtTYSX806COKrNEVy9MBVorZK?=
 =?us-ascii?Q?Wda0z3QITTxY91XO11A0chbLndMt1ZplEvqZC2hVoYCgx0rlOnLBCHm5FCbs?=
 =?us-ascii?Q?xZmKYHid03Rda2cWZzWbdRaLnhMlf/1BbYQCdKoP4GqAZd4roNvWD/uONm2Z?=
 =?us-ascii?Q?3R9qp0WQLw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c1fcce0-aea6-444e-9d02-08de78d4d0b6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 03:27:36.6873 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xIYN+TI/1rgFA+oHZg3bUGdJbR1pSFEu7ZQ7qkvB8trcUJwKQwE1fNwY3uvn8WOcLqCLRgIIKSk58CzwnfCmoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9498
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

On Tue, Mar 03, 2026 at 09:10:27AM +0800, alice.guo@oss.nxp.com wrote:
>From: Ye Li <ye.li@nxp.com>
>
>The XSPI SET GMID command is used to assign GMID ownership to the
>requester, allowing access to protected XSPI control registers. This API
>must be called in SPL if XSPI GMID-protected settings need to be
>modified. Otherwise, XSPI configuration depends on the previous GMID
>owner to provide the correct settings.
>
>Signed-off-by: Ye Li <ye.li@nxp.com>
>Signed-off-by: Alice Guo <alice.guo@nxp.com>
>---
> arch/arm/include/asm/mach-imx/ele_api.h |  2 ++
> drivers/misc/imx_ele/ele_api.c          | 28 ++++++++++++++++++++++++++++
> 2 files changed, 30 insertions(+)
>
>diff --git a/arch/arm/include/asm/mach-imx/ele_api.h b/arch/arm/include/asm/mach-imx/ele_api.h
>index 4e1afc42bd8..04e7f20a2a6 100644
>--- a/arch/arm/include/asm/mach-imx/ele_api.h
>+++ b/arch/arm/include/asm/mach-imx/ele_api.h
>@@ -49,6 +49,7 @@
> #define ELE_ATTEST_REQ (0xDB)
> #define ELE_RELEASE_PATCH_REQ (0xDC)
> #define ELE_OTP_SEQ_SWITH_REQ (0xDD)
>+#define ELE_SET_GMID_REQ (0xE4)
> #define ELE_WRITE_SHADOW_REQ (0xF2)
> #define ELE_READ_SHADOW_REQ (0xF3)

We should drop (), but to keep code consistent, it is fine here.

> 
>@@ -162,6 +163,7 @@ int ele_return_lifecycle_update(ulong signed_msg_blk, u32 *response);
> int ele_start_rng(void);
[...]
>+		printf("Error: %s: ret %d, response 0x%x\n",
>+		       __func__, ret, msg.data[0]);
>+
>+	if (response)
>+		*response = msg.data[0];
>+
>+	return ret;
>+}


Reviewed-by: Peng Fan <peng.fan@nxp.com>

>
>-- 
>2.43.0
>
