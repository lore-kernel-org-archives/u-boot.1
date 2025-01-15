Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C924C02183
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 13:29:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA97880702;
	Wed, 15 Jan 2025 14:29:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="xybpyubt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 068C380703; Wed, 15 Jan 2025 14:29:21 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20609.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::609])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09C7080726
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 14:29:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z2CL1oA1Cpl1Drtrq8j1mFI91lIbt/K4N7xsl+OARRyKuex0wrsvdowrtnQgFIfjT6cuwXIGWPkHnpGRdQHaArIWtheayfnk/PBwPseWPLR82fyFCgwa3FbDa1D0p9KfaxXyttBfBVoRJd9iXG9I84FEVNWkRBWfOo2Gv8rgV4EizS1B5Ng9OMeTlaNYEFpj//O1thHMHiVjX24uv4vRAXvXunLacmKgFEImoBaP8znxn+6zxesO+OCMEMhxXiNt1H3kZKG+4H1kx6TP4KcuN7ANT+irULU4rBDqAZvtl0GBGvg0yqRY5P9sVDcOV10e1ixXyp1iNJ6NikYBSMHLZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=einoH49zfsP0F0LiKBoLFQ+RDDLycvSEK7uPrhYGS3E=;
 b=cswqJ0oPxeVTb+OlBbsxJoRHjWnj37qnc78QzPvaKooB68SgNt4tRZNJp+8HMn08sxKzK81nfUVq4qFUJM9Yn0JJeB9CZI+sE9BRdcpF9gt6s2uAcScuaUrO1RXm5BojsmO1hnB6XuhGgjII62wVnW0xOKij2OAV1MIl8/scyX1baSkpbp1xX5u4YR3XX95KGxAj5+O9ypu2XOR7hSD99N+G0zs9e/+jcn+hzIKa0RL7u8pZQt5Se1L83/67NAii5uIZOpo8R6DpuRD0qZTMsPyMKauYsT9dpxQvo563CdI19gvfnDWVQOR0F8KjZIoAIdcZZ7P0GF5uS0iBn8Qbqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=einoH49zfsP0F0LiKBoLFQ+RDDLycvSEK7uPrhYGS3E=;
 b=xybpyubtBVB/soa9UIFW7N+2XHiiqokxiSY6JPKuIU6Qk/rBsBK7y2bHQDtCFAwwvTHe0LbleBqvfNFCtVHRa9AkoNgVqK9ZwWCGJebPNJta9DJ8ACgg+qQVhsvGjy9FB8oym6Y2RLvlZxnuOKOcsDBUwMBM5A16Tj1ItWO6M3hKBWnWUn/g0esgLoVeVAVBMzvLftMPyreaiFzkIxSzTNceLXEBmOvdZQNvGIBZR0baOId4uBmi8o7GdpJNzAVdvrSJzf8virb5w44CvXC4RE7doVsgmhYfumjEa5BDOkJb4Jo6Qfc82WPWLRmEsGkceqZO+ThCsGVNoxqM1/QAnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AM8PR04MB7764.eurprd04.prod.outlook.com (2603:10a6:20b:244::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Wed, 15 Jan
 2025 13:29:16 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8335.017; Wed, 15 Jan 2025
 13:29:16 +0000
From: Alice Guo <alice.guo@oss.nxp.com>
Date: Wed, 15 Jan 2025 21:28:49 +0800
Subject: [PATCH v4 02/20] firmware: scmi: smt: Interrupt communication enable
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250115-imx95-v1-2-93b28a514dea@oss.nxp.com>
References: <20250115-imx95-v1-0-93b28a514dea@oss.nxp.com>
In-Reply-To: <20250115-imx95-v1-0-93b28a514dea@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, marex@denx.de
Cc: u-boot@lists.denx.de, tharvey@gateworks.com, 
 Alice Guo <alice.guo@nxp.com>, Viorel Suman <viorel.suman@nxp.com>, 
 Ye Li <ye.li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736947742; l=2608;
 i=alice.guo@oss.nxp.com; s=20250115; h=from:subject:message-id;
 bh=zph5sJFBD4svf/IBh/qgXTCkh3jabyvwDUrb9iyFYMo=;
 b=AMYKS0nsky8Lr8/vqCMM1bAC/YNt//8Lk1EZn7doe13I6H8b1MlH3xuK0fEosbSWHwIZt42mY
 MhFb92hRvx7Cyqz5xoI3df3GHBAR6IMFmy9ysgir8jpyuhhXZhUXPH+
X-Developer-Key: i=alice.guo@oss.nxp.com; a=ed25519;
 pk=MQFotjdbgvdbpnpHmN/PUzfJXX0wchusR4L7yfs2VZQ=
X-ClientProxiedBy: SG3P274CA0022.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::34)
 To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AM8PR04MB7764:EE_
X-MS-Office365-Filtering-Correlation-Id: 829e46a3-a029-420a-dc62-08dd35689bab
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|7416014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T1ExUUQ1bmFlVlJCZmhaR1NEaEhPb3cvc0hQdjZmT1d3ajVPTmRlZjZRZTBL?=
 =?utf-8?B?TUZ1c0MyeVdUVVZNSlVwYmdhQ3R1RmNYNzBWVGphRHlCeDl0YW45T3Vldm5W?=
 =?utf-8?B?Z0JzZnZFQXlIRFdSNVN0RFVPZVA1SytFc1F5QnNkMEFDV3FMb1NpdUs5VDBB?=
 =?utf-8?B?eFE0WVZBR3hLWlVFVmdrN0o5T29ITFMySGkxendKKzZabEJPeUZIQjRDU25t?=
 =?utf-8?B?aDEyU0lka0MvN04zL1MwbS9aK3dEb0x5eFdRMU1WMjRmYUp0ak14RDFnbnFt?=
 =?utf-8?B?NmhTazh6YUNST1FtVnFHRDQ3ajRHbmVGN1c3b2ZpQThDTStOQ0tta0FlSnRz?=
 =?utf-8?B?RS9aM3cxaUtHTUpCZDlFRXFYT1lwSnlONmlWN0ZYUUVYT3pDbWtZcTNrRGV0?=
 =?utf-8?B?Wk1QMWdpS0JkNUF5MnQ1VjJYMGw0MkNPdm5wanMxQ1BDRnVQK3R4eitRclhC?=
 =?utf-8?B?ZGt6MU13OWV5YTRtTlg4cXN5ZG9icnd3ajk5Y00wWXlib1llM201dXMxTUdQ?=
 =?utf-8?B?bmVEbm1WWTh1blVuaXV3NkFwTW5mWnB4WHFLdnp4bk1nL1YwTytQNnRselc0?=
 =?utf-8?B?UHBxbTFMOXJLaUJNQmFPZjFuVjRKOVkvMnJ6VXdhU2JsdnVxTGxMQ2xJVXJN?=
 =?utf-8?B?ZTRRbzJObHUzTWhyMGdNdk9lMXZYbXBXTjZLZlpxNDVCZHBnYjllR3FyNk9T?=
 =?utf-8?B?SERTdUp1emlhWmRFNFgyOVBDUldKSHEvWnVKSXVFQ0NYbWJua0o2RTJLT3dw?=
 =?utf-8?B?TGo5em1oNjBXWStiLzJMT2dROGVyR0llZU1HNGxGWmRZUVA5Y3ZZcUhwZUhL?=
 =?utf-8?B?aUlwNXdUTXJ4SVIyL2RyZVB1VjBPUlM1ZEdmVEFhRmxoYnp2S2xMaTlhak5K?=
 =?utf-8?B?NnlCTUZCbXgzcDBZMzZqeGtxRDVsbTl0WTRMclYzZ09mcmUweVZVM0ptUzdQ?=
 =?utf-8?B?TUs3S3I5QnRHdTRUK0JGOWgrRUs1NHc5aFRpTDR4ZVIrUnZYeGpITmdybEND?=
 =?utf-8?B?QmJ6VGZGeW55N1d6ZHVlRUt2TXY0UHJvSUg0elBwQVg0YUthTHlsLzNiT2hl?=
 =?utf-8?B?QWw0ejdlQko3K0NKNlhOZWsxbVJtR3czNkRNRmJ5ZEdWdXJtaTNuaU9TZXhO?=
 =?utf-8?B?WklKTEhNZ2JCZDJmZndOMFk2cmYveStDbDFrUGlKd1RGc1M5YVNjNGhEcVlh?=
 =?utf-8?B?TTE0NncveVJObTFFeTRZUU5WejcwR0NVTmJUbDh4TCtGUVE0b2ZqdDRMY3Zn?=
 =?utf-8?B?YWxsK3llNU0rUkIyNjBYbWNCVk8wa2RMczFNd01JNWdFeVVkRnJRQjFUNXNZ?=
 =?utf-8?B?eXNJaVBwVmFzVnMwdmRqc0lnei80WHphOWdmLzQwRzBLbmNuZ0UrMWtDck9P?=
 =?utf-8?B?enM5QVdYdTJYZFZ6NlhrazZpS0ZZbkkyaCtEcmV4NmNuZ2tSak1HWHFXRU9G?=
 =?utf-8?B?NUkxMzVCcVA1ckdBdTEwZEp0N2gzd0RYRlNxZXFQSmZXVUh6SnlONU9aQkNa?=
 =?utf-8?B?SEh4SVY0R3V4R2pkSjREZys0N3dleVdYTDNKZXY3REx5b3NGQVN2cWdmRmI4?=
 =?utf-8?B?WVZmZUxNakNIMFRRYUR0ZlNnTUkxOFJsNGVYRE4wWjd4enJZWWFnVUM5NURC?=
 =?utf-8?B?cGtFVzZUQ1VDbXdtcmNQOHd2UjVDL3ArUi84VHNMUUUzcjF1VW1HMnZ6a3A0?=
 =?utf-8?B?RlJQNVVoRS9tYzlXUk53Y1NPMXc1aFZHaGdZN2dod0RjQUYraVlHT0lRY3Iw?=
 =?utf-8?B?MnhmeXZpSUdWQVQyK0Vya0dhQTcvemZsNTVRYXNEa2ZwSldaUU1UM0tjLzFM?=
 =?utf-8?B?dnkrUC9DTEVtZGd4TjBBWENzTEwySFpIVWZMTCtndlFCZXlUb1YzU1BpVUpj?=
 =?utf-8?B?K1h1Qk9DbUdqaFJpL2tZc0JHUlBaSlVhVkdJOFJYOG5ObEFTdGF2N0RXOWZ0?=
 =?utf-8?Q?yQS5tDsSL1jDJ2w1tHT20VZaCvF9yHdC?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUs0ZndiMU4wMXZaVzB3SkZDRTdEdXppZHl6MVVNR1RmcW9KRjlpMGt1d2I3?=
 =?utf-8?B?S1J4emdOY1d1UFB4RUs2dHM2bFRwbnJ1MndiWlM3ZG9leis2M3lMdmVkNWZ1?=
 =?utf-8?B?MmI4RWVXZk5WbW9hUGM1dUVyN01UTkRPN1EzK3orWGNXd3JKOXdoRHRUNjUy?=
 =?utf-8?B?UDE0VlloZm1WYjdYUXo1MUpsRXN1QU9WV2pXanVYWm9HclpvbUdRSmQrVlBn?=
 =?utf-8?B?QTBvVjYzdmxoVXZkV0ZHU1MwNU5SbnJoYTB6eVF1Y3NTNk9tR3p1VGt5OUdi?=
 =?utf-8?B?SVZobmpRcEhQZnduMFdGeVFRb3ZrbjA0QXZ0Y3VYQ1pvbFNQNzlOMHlIYnhj?=
 =?utf-8?B?Ti9UK1ZXbFJTOHRDMnI3M2paSjh1RnJGTUhvUzRRUzMyQ2ZpSXdGdzMxTnFS?=
 =?utf-8?B?WmZlc202WVVzRmFQbXZVc2VQSVppanlNVTlSWTFOVWkyU0hjNlNkK0ZDZnBq?=
 =?utf-8?B?eUtyNEFRQ0EzT0NoamFVeUx6TG50SGc0V3hWV2lOSTZTTHdFTVdMQUsvbDZj?=
 =?utf-8?B?Um1Sc1U1cnhqNWU1THhIK2pLTmxCbEl5SU83SU8rZmM3dlhDRXF6azUxNGg1?=
 =?utf-8?B?NjdTa2hRclRjbFVlYjVqdG9OcDJ6VmxXU1RzL1k0SkE1QzZYUzhmdjNNaDB0?=
 =?utf-8?B?QVRqMEVKbXJQRVh6ZUJRVjJDWTZmK3paSmhuVVZIcW0ybjRVMU1nYXkzSVFL?=
 =?utf-8?B?ZlF5eTEwT2ovakpkT3dMS214eUV5MEJDYzkrRTlKaERPTkE5bnRSTk8rUW9l?=
 =?utf-8?B?S2hLVVNOS3JnQzhubzhGVzJid1pQVG9TalYvdzcxU3hRRHZOTlIwdUpMUkRR?=
 =?utf-8?B?blJUK2JIdnVZT3NWNnBtSFRSS0llWVRmMlVxakpSUEpuc3VNSURLbS9iWjFP?=
 =?utf-8?B?WWVhcy9nOTJHTjRwc0pYV21aeHBZWWFobGNCTUYxQk0rSXhRRHA5d2hMSVBS?=
 =?utf-8?B?VmhiaFNYTkNUQ216SmowY0dteEpDajZnVmlibGlZV1Y1NitHVHpocjU1SDdQ?=
 =?utf-8?B?RGNXcm1DYUFQeW54NUtUUzlReEJMSk1jQUlrdUNpQVoyLzdCbUdZc0duV2xn?=
 =?utf-8?B?amUzdmRoaVlWUGx0b29GVU1IWGN1QjM1bjhqUkVjTzlXYm1aWHdNRUJEQmY4?=
 =?utf-8?B?MlhBUUJOci9pMlM4aURvaXpBNW02KzdXQ2R6OVdjUEs1MnBLZzUvUlk1OXFj?=
 =?utf-8?B?V1lPNlBDOVZmYlVHSkdpSVVURis0MEdJYnpvMDRuclp5NDVlS3orTHhPcW55?=
 =?utf-8?B?S2ZwSUJ6NHJVL1Q2emJmbmhoZlBPeEpHMzNKck9tbGVYeGxaSi95ZEpNaDla?=
 =?utf-8?B?SCtpbis0VTFrdE9wUGVZSWRYL0JHSUkxS3hRVUhMS1hNV0lKV1loaG5sV2tD?=
 =?utf-8?B?U1FpRUVhMHNOdGJUbmJkN2ZPamdMd3NMZDVGT0JlbGgydEtNMFY5bzhWbUlZ?=
 =?utf-8?B?aG8xN0toUlE5WGIwaG11dXp4cGQ0UnF3Vkdkam5mUHBVVEtQM2prTGI3TUxI?=
 =?utf-8?B?UWtWOWFzREJaYjZCMDRta0haZHkySU5SZWI3dWlydUgvMDVUQW9NMHNQWVpF?=
 =?utf-8?B?YlJWck9tbWZTNnhQRjlQcTY0NjNHVDF2ckJ0SjdIdThabFNsZkMzVXBUMVp0?=
 =?utf-8?B?d2RHZjhtZDVnUkdvTHRwbGRpbFYrVTFRTnJaK3o5amV3WkkyVmxMcGFFclFm?=
 =?utf-8?B?NzN0RHZvQWhhdEE3MjhlWGlreWVPVmtwSllYUVdKRXZuWW5vMTJ1MnJlSDZN?=
 =?utf-8?B?eEV5UlM3QUhyc09zbStyQU5VYnlTeXdUVktjMU43RGVkbWZ0ZS9TUThjM1Vp?=
 =?utf-8?B?am9kdlUxVFdISXBteFllL1I4am5LcWEvWFB3dVhTcHpZZzcxRjNXUTMyU2JV?=
 =?utf-8?B?d1VRZUdiSXllaitiUWE5ZlJjOTZOQVcvMEJaUllOSVJFVTVyQ21jS2s3UzRN?=
 =?utf-8?B?ekcwNEVoV3czaTd2NXNhY0M0azhWRUVKMGVUaU1qYmJtTVREQzg2K2JaUDVY?=
 =?utf-8?B?VTJzUGtzRlN4K2VweWJuRnIvZzhVaUlnUWxCWkhnZk1VLzJzRnFIa0NRQXFs?=
 =?utf-8?B?MmZuZXkwVW85YzNQbU00UHltVC9jbGpqc21IaXUwU1NYZDlFTDgrZmQ2anNw?=
 =?utf-8?Q?WUik02hIcFcNTf1xwr6hSyabd?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 829e46a3-a029-420a-dc62-08dd35689bab
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 13:29:16.2435 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bfEYHIUk/mt6pmL0R2AZxq7WB4qzaopkdkUrroWG8kE4AmuBCrJGr5a1yVmZdhQ0pYYb4+MrcwXGzfgOr21WGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7764
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

From: Viorel Suman <viorel.suman@nxp.com>

i.MX95 System Manager uses interrupt driven communication which requires
the caller to set Bit[0] of channel flags to 1. When transmission
completes and the previous general purpose interrupt has been processed
by the other core, i.MX95 System Manager will set General Purpose
Interrupt Control Register (GCR). U-Boot polls General-purpose Status
(GSR) to check if the operation is finished.

Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
---
 drivers/firmware/scmi/Kconfig |  6 ++++++
 drivers/firmware/scmi/smt.c   |  3 +++
 drivers/firmware/scmi/smt.h   | 10 ++++++++++
 3 files changed, 19 insertions(+)

diff --git a/drivers/firmware/scmi/Kconfig b/drivers/firmware/scmi/Kconfig
index 8cf85f0d7a12c9e58dc249539727081ec25dd7b3..eb62b88615b5cd95635571556e79ba40d1a387e9 100644
--- a/drivers/firmware/scmi/Kconfig
+++ b/drivers/firmware/scmi/Kconfig
@@ -41,3 +41,9 @@ config SCMI_AGENT_OPTEE
 	help
 	  Enable the SCMI communication channel based on OP-TEE transport
 	  for compatible "linaro,scmi-optee".
+
+config SCMI_TRANSPORT_SMT_INTR
+	bool
+	depends on SCMI_FIRMWARE
+	help
+	  Enable interrupt communication of shared memory based transport.
diff --git a/drivers/firmware/scmi/smt.c b/drivers/firmware/scmi/smt.c
index 67d2f45002490ab64a6bc997eda93a8f4681d99b..ee7ae5d50b226b92a3961c181de83c730a621401 100644
--- a/drivers/firmware/scmi/smt.c
+++ b/drivers/firmware/scmi/smt.c
@@ -48,6 +48,9 @@ int scmi_dt_get_smt_buffer(struct udevice *dev, struct scmi_smt *smt)
 	if (!smt->buf)
 		return -ENOMEM;
 
+	if (IS_ENABLED(CONFIG_SCMI_TRANSPORT_SMT_INTR))
+		scmi_smt_enable_intr(smt, true);
+
 #ifdef CONFIG_ARM
 	if (dcache_status())
 		mmu_set_region_dcache_behaviour(ALIGN_DOWN((uintptr_t)smt->buf, MMU_SECTION_SIZE),
diff --git a/drivers/firmware/scmi/smt.h b/drivers/firmware/scmi/smt.h
index 9d669a6c922666c48e7dce4c0affd7b47cb137e4..768b0f4c8a8d1cc7966530e724d278d72c2a167b 100644
--- a/drivers/firmware/scmi/smt.h
+++ b/drivers/firmware/scmi/smt.h
@@ -84,6 +84,16 @@ static inline void scmi_smt_put_channel(struct scmi_smt *smt)
 	hdr->channel_status &= ~SCMI_SHMEM_CHAN_STAT_CHANNEL_ERROR;
 }
 
+static inline void scmi_smt_enable_intr(struct scmi_smt *smt, bool enable)
+{
+	struct scmi_smt_header *hdr = (void *)smt->buf;
+
+	if (enable)
+		hdr->flags |= SCMI_SHMEM_FLAG_INTR_ENABLED;
+	else
+		hdr->flags &= ~SCMI_SHMEM_FLAG_INTR_ENABLED;
+}
+
 int scmi_dt_get_smt_buffer(struct udevice *dev, struct scmi_smt *smt);
 
 /*

-- 
2.34.1

