Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03A7FFEE4ED
	for <u-boot@archiver.kernel.org>; Sat, 28 Feb 2026 15:59:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E39183EEF;
	Sat, 28 Feb 2026 16:59:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="t9qZ4VRW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69E9883DBF; Sat, 28 Feb 2026 12:26:50 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FB21801BE
 for <u-boot@lists.denx.de>; Sat, 28 Feb 2026 12:26:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k0DIRseZfg8HVq+tgvNgNoA6fj22cDs2M7z7GShGSletmiA9cfeZ7LebdYfpa5wckuExTy5UrltwJmiTrEy2N8rhNlWdnE5AZE4Ym7rgM1I1lECTt1rPCcNWgWL1N7tfolP/R2QcE1fWNu1/5lz1NF/ZbFXwWQtAumKhH4QLXbRiFzWOvpNBmD8Tjq6QwgwNggCULEkoVKbFFdTvmzRViWB75FV9IIZT6qru37ZTVFiU7iivz2L7Tr5lEVYlovl6+X75vLJoi2Jo92IkwOqeu00MLQ/Nkj5ZfOhU9RgmJY+LRxxqkKCpTuLSXK0uFTBnx7vGsjWnu28qc80n0BJNSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nzXNR9RP4lB6R9BO0NuLt1JZ1hjaTMi1zvP5wtxgi2k=;
 b=MAyPY4IRDAzz0ea7gP0uTQMZBqsmE3Iit20SCaz/IPWMz95oOr8C6Jh0NtLCKUw4fGzix6d2DIs3QTZ+XrPEXD/aXBE1cgtR2qgEqpcdnM3XOmP3YyLYeE6jqCbC2n2Ck+hnrRRmJH11tH9QVRDWi0DYcYjhnTTuxQ3Gm0CDTPvAb8h4tVWIZ2QJumz5x1lRqzhpU3x5AZZNlLxr7B9qF8JksX4lNeGnE2zj++rpO7j7/6cIochu7jnpA/ri1O9D1KFU/hd+EkUGUcf8Qjh3AYny9UEc9E0ozZKZBo+liBWYxW7Q6LRZEkKx+mm05yfPrvdz9CAl2mpGgSwB+ONATg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nzXNR9RP4lB6R9BO0NuLt1JZ1hjaTMi1zvP5wtxgi2k=;
 b=t9qZ4VRWPT0g+l/ubwtklxWA/ZBNQBmlxwGH6gnvSxwlb7u3Z/twghrPFq6IiEib0hgV/dNa5YyU46ISa3jHrnhcqEfqaSxMdsOCkRYFPHdf81JPkHqrMdzaHN2hLdd4RG5Wt/gL8i8USDdUw8j0Rhv+/5DyjQq1TF8uraXKUJrZ+tQfiRnXZwQMa8QEC0mQeimeMHLFepjSkMGv91K2nAqWm8TlLwPUOOVVCvxEKP2eVuqa6mBb4hM7fxc2tldah9YxVqaXl8r1ORACgCpccMsiTSktV99+pWa6qChoJ6oIHP4AjwKLKQrk+Lz1rRzcECuk/x4teyFFNL5gXJVIhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM9PR04MB8067.eurprd04.prod.outlook.com (2603:10a6:20b:3e5::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Sat, 28 Feb
 2026 11:26:45 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%7]) with mapi id 15.20.9632.017; Sat, 28 Feb 2026
 11:26:45 +0000
Date: Sat, 28 Feb 2026 19:28:33 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: alice.guo@oss.nxp.com
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>,
 Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>,
 Frank Li <Frank.Li@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jacky Bai <ping.bai@nxp.com>, Rasmus Villemoes <ravi@prevas.dk>,
 =?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Valentin Caron <valentin.caron@foss.st.com>,
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Jindong Yue <jindong.yue@nxp.com>, Ji Luo <ji.luo@nxp.com>,
 Niko Mauno <niko.mauno@vaisala.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Adam Ford <aford173@gmail.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 David Zang <davidzangcs@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Marek Vasut <marex@nabladev.com>, Joseph Guo <qijian.guo@nxp.com>,
 Simon Glass <sjg@chromium.org>, Alice Guo <alice.guo@nxp.com>
Subject: Re: [PATCH v2 01/13] imx9: scmi: Get DDR size through SM SCMI API
Message-ID: <aaLRYQcI1HRzT8Jp@shlinux89>
References: <20260228-imx952-v1-0-0a360e7e8cb7@nxp.com>
 <20260228-imx952-v1-1-0a360e7e8cb7@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260228-imx952-v1-1-0a360e7e8cb7@nxp.com>
X-ClientProxiedBy: SI1PR02CA0060.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::17) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM9PR04MB8067:EE_
X-MS-Office365-Filtering-Correlation-Id: 66c3e125-4e8f-414a-96f0-08de76bc4106
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|376014|52116014|366016|7416014|38350700014;
X-Microsoft-Antispam-Message-Info: f4xPaDGf/YOn+RaSITjFVfWrWFSPcFiHEyqd32Am8AsK6rJvhDFHxdbtp9gqIGHGsTm9CENGIYtTI4zOgbLl+o5ooFUIANEQPBCMM90Sj8XnAVqSvRFWXcXx9kG/MM13t7JWWpFisVcak5xRVAsscO6HtUj1yrrhdTFjWdHjUuJCsTMcbdY90W6thpyN6AsT19ARTnBa7bbxmQbrMtxo0ryTfDAvdCfpZg6KR/+qhTg2QTmGoGBvdccNMm+5kU0+yMBsdeOZ6l3wBFCFc0gD+WITpy74FL1+Zbdga/RiSXYexfJgC0voGtPGIJMUB5l5xxJwVP2Dnmet/VOMnVwmtjEXEOYHfIVS8Ha1hz96RRRenb4mAFI6c7232u3k8NA42h/5Mu29uYyd/fD3lFPvHD/IzVsUj41zR3LRYVjiu3iwmHN3mv8yoTMm2SOn4xrALwjaYncrHaIKHvePnKZBBnLnIKy8IjFPB78RFxma0sY4c/oOWQgaEDLZR3iU4SB/z4F1cBniFYxRH5wvhYQDHZK5D9q1+yR9+kkMU5xdyoBZ0O84ExIhZuBQg2Dw6aLmEHebgSaNjOMoEEvgwLV3VqBbT0AeSMJoBj0OsmqUMyZBm8eDdm7PyaCnU9pca43h/Vf7hnh49FG2qobLPsYebMBn/Jyra/T5YZIc+rR51+nDy71+Cx7PgCgzvHY8rN0oyK5xKp9IbKY90eRvt9mtU0U1Gjv9cpqJklgGkvyYE+uSICwhD6rSLp6aUNeM17YE/vo+d1/3cipqnIkyMEtrH4cfPw0JedLkdhUontnP5xQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(376014)(52116014)(366016)(7416014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6B9gB37WoEsdeK1JOHPmNod6K3XKYdYKm0IEl0VKVFPKteP/PgFHWiLZc66+?=
 =?us-ascii?Q?aG887wJculOK3NQbZwdijpT0NSh1iMiFbRfl2FxlryjwsCIO39z2ARgI1WOs?=
 =?us-ascii?Q?sanx/1RT6SGUwKHsLR1NORqIJl888nonuqcR4bbclQ96Yn/Fe+mXqvuQV24D?=
 =?us-ascii?Q?qtjex99JNqy7etki5whUjDbZDXFUZJ1mi4pFQ/bJJ3NUeMQhHKKMOCzu+wU3?=
 =?us-ascii?Q?bfjqjPtptGiMvjez+NpF4jfe/tyar+ygmStbZK97MBuP9J/yQhFSHN8sEv09?=
 =?us-ascii?Q?Gtlo5tfaGwHwbLKTierf3jDdfdGs2jQqNNrBWtya63YbNflSZaDvdmHZgSVQ?=
 =?us-ascii?Q?twzAGh1yt7F8eJ9Hc/RNvoR7ABmszurKPsX3DWc8MkFOmW3014Cft2vFFGFf?=
 =?us-ascii?Q?tsfdaZkDZXJVjSJvVErrE1WT568HH5RYHAOAmNC7EjAsVSZSQ+ESWd3i5sLf?=
 =?us-ascii?Q?VB91VSwZIqKoEIK6gLi6Jc46YXuyXCmbGgOYqi7235CqmnWHZIjKRt85SLdo?=
 =?us-ascii?Q?FYWzbJI8FGCtbNAkbdspVHQ6F6/29HUCZxT9iOAKXOArSs0rTYSFqtxfyH2U?=
 =?us-ascii?Q?+5Q+mpTAtrdG3zTj5ki7ROgaQQsynRYr1yiElR7ej7QMCNxtqWtsPNsVplhv?=
 =?us-ascii?Q?pPL+4Fum/WQo6ZJds1jeVxWLKp73Iu8PRMp8Zs9rtrzZ5XrMF+SFIgf3OwKO?=
 =?us-ascii?Q?22JZ6CE1b9hfTZcxD1WUZ44Fn/dQZhKPWxRlZcVzsfYAjTmcpQmx6eXchyiG?=
 =?us-ascii?Q?u8yxpv/jFE9iKIICu1z8PYDcFEe4Q4lLuo0t+5k+/fq7t/t9aidziaGYxHd3?=
 =?us-ascii?Q?ipty8WAhNJDElzrUevpUAg+IA1/fEuAyUDhEKTPCmwOsbeTNRsoW2qlqe2FQ?=
 =?us-ascii?Q?vwRMUv9vHUbVV953HIxlgMpufiSo8ZQEL3/wTMEbEHsl890xGqacMHIv8Spq?=
 =?us-ascii?Q?xy5xfVbrgCUX1qZSceFexeTkDWb41eCJQNad3tYS2wZrMEj3ragmgACRbVZ5?=
 =?us-ascii?Q?RRjCVebU9jBck1oSUpo+0Z5Au8xj03qMm8foY/KyVATlg4dJn+3Nbm5xDRxm?=
 =?us-ascii?Q?UsQIGBY3nvsmN5b578UH0zWAqcr5eEXkEEH1DLTgyhXJUVexzu7NBTtM49Fj?=
 =?us-ascii?Q?79wJQcHpRewBAq9Qd9OVD5Z4KLok5uRr1IjvVIbaZnvuGayBDoaAhZQC1wjQ?=
 =?us-ascii?Q?kau+DKFG/puckAfsj1/Dfnf7zQxxW6sRo+1lSpW+kqbzgM948Dkio5vMQBJp?=
 =?us-ascii?Q?/ksFQDXzpuf3mechJ8jeVMp+AhzMV8gHSUA2DtelckaxJ/MG2VGUiPG9ycnE?=
 =?us-ascii?Q?tqytT5GIpXTD14KrXXk36Ocg2tkKM2pqRp/VGySlbMEJWJZ1BuKdpAz4lv4A?=
 =?us-ascii?Q?wBhSoKFN1VHrIiFQHs8300i3RKhk4lC8NMp+9Y3IaJMebD8IEqGnrVxc7/Tw?=
 =?us-ascii?Q?4+i1XdhxjRwaXQfFweBYrJGf5KgNSpDkDN1tO+Yd2ske+KhUsJ8XRGn5w+4G?=
 =?us-ascii?Q?gb0/XtjUhGZxRIspLI71jBEdvxc7F6d5etQYA65iZufHTPIlg640MlcZYXyX?=
 =?us-ascii?Q?/0P4z91oiyzxe2vyWCcYlRtNXcTDUl+/4z/exKoSR3akvoqYy4al1b6pmmDT?=
 =?us-ascii?Q?ulSm2hduqsDLJ8gcebGQ20gNW4LDhRqluC9z/aHkZfN9Lv/zRpGhnioJMREX?=
 =?us-ascii?Q?+Mm8dTAOBDgO628hhaTNqiJZO8IqKQUARsbE6uxaLn/Yl7mxKtF4aYT1kGWK?=
 =?us-ascii?Q?nShJTl452g=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66c3e125-4e8f-414a-96f0-08de76bc4106
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2026 11:26:45.3322 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: soaWyH75/fgCDiZgUdb5PLBDyQ12jAQqwTk+eN9/Ud0I/7wwfbIee9Zu73/9Lu1+fg03ZliEmDnE6IYUz4GEJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8067
X-Mailman-Approved-At: Sat, 28 Feb 2026 16:59:36 +0100
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

On Sat, Feb 28, 2026 at 08:22:19AM +0800, alice.guo@oss.nxp.com wrote:
>From: Ye Li <ye.li@nxp.com>
>
>System Manager(SM) has implemented the MISC protocol to retrieve DDR
>information. Using this API, U-Boot can obtain the DDR size dynamically
>instead of relying on static configuration macros.
>
>This change addresses the DDR ECC enabled case, where 1/8 of the total
>DDR size is reserved for ECC data. The scmi_misc_ddrinfo() returns the
>DDR size with EEC overhead already deducted.
>
>Implementation details:
>- Query the DDR size via scmi_misc_ddrinfo()
>- Replace direct REG_DDR_CS[0,1]_BNDS register reads with SCMI call
>- Switch from PHYS_SDRAM[x]_SIZE macros to runtime detection
>- Secure memory size is set to 2GB (0x80000000)

Nit:
I misunderstood in V1, it is 256MB. Drop this line.

>- For backward compatibility with older SM firmware, fall back to
>  static PHYS_SDRAM[x]_SIZE configuration if the SCMI call fails
>
>Signed-off-by: Ye Li <ye.li@nxp.com>
>Signed-off-by: Alice Guo <alice.guo@nxp.com>

Otherwise:

Reviewed-by: Peng Fan <peng.fan@nxp.com>
