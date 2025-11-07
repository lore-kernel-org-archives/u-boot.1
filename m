Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8AC3CCFA05
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 04:41:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6350383CBD;
	Fri,  7 Nov 2025 05:40:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="iLeMYasy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABC1883C60; Fri,  7 Nov 2025 03:15:09 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B610B83C40
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 03:15:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=enLdOTrhJEg/qkCIZTak5/TQz/jrIUPeDPzJf+Iu8tcYlUE+vnlHJ8GgdBPHhgy7Kfi1MQcbnjwa0fD2PwHXTAjnXSp9Ebyy6bxbhTijAlM/PGuwE/s6+OqClUVrjuB89NRr1BEfDh36ZdrNuaqxBAh63iRsEvMpQnLCSl203kEjtEsQh8Zk5qA0tHd0sqqC431j/4O/o85uw4uvR+fbfm/7LMagVs1X5fWU2Bh7RQepID0nJ0WFEWCFLWE6OpJBfv+jmN4udhm3VQNcc5xodvscM2cfUVfVG04rFbXdWJO4GnEMiLLOpmN9iqsyg11cSELIn3wN5Snn+QePHUGbeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AXGfnkJvSZ4LkDb/ZgxXjpoEt5sSi8WVKwLsp3ZqnpI=;
 b=j8PXXjNuulPL5NBpZW1dtYw+KM92QsUSjjbt+W+FG55Zo9ktG1iX4WuJcOjPQIzFqCNOAhXPcsq8+LfNMsl8wZfhKc4Z9KKzhmupZ+r4/xNfFAAW9DTGzswLKaodD7unuHv1DszzpjQmvkUDv5y6lhBWC1VJZGvYAdQ76dI9TJT5Xtoz3I1Jp28cRLQDTQmA65JGLQMBnsS+FzNc8a+FkxYiGbsU37yevm3qoOEcKgWZlG61weDaHXMW0aAReFM99Yn0lrm9HSB5aO0fzQOgpKPrq2nW/wu+hiLkes5KUu0ijrtgz6pc1y51vYwCNpjl7MAcqGWnogt4AbBbhtiHBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AXGfnkJvSZ4LkDb/ZgxXjpoEt5sSi8WVKwLsp3ZqnpI=;
 b=iLeMYasyFniU1ebW4pxso8hy1wsoDOawAsik+U00VOJxF3MHJIuMHqPTf0mF796l4FtmqR/0XTWoeDcJKsmUgo/rMG4A1Az3fbmyz3tlYApSWKM8CLwrvptaMW1y/OmfRENgTpuiGjUHxFwCoiAI1rfCx2RPUM8MhKsFlepSfPeObVnTwnXiOYCMyWg9AMqiKtwsW+hcTJA8kWl3gmnZC21HB1vVvj8Ifd2+WLTquL2OMwWxHt9O+BPOvXuLvpwDLRQEir8g5aXOfkW/XG6rkL7h/14JAGh48I+qMs8XAHkBYGsiljMP8G8kVYvpe1gFYjC0kiqOAaDnQ7kmQ1+hvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU4PR04MB10484.eurprd04.prod.outlook.com (2603:10a6:10:564::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 02:15:05 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 02:15:05 +0000
Date: Fri, 7 Nov 2025 11:27:35 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Alice Guo <alice.guo@nxp.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sean Anderson <seanga2@gmail.com>,
 Valentin Caron <valentin.caron@foss.st.com>,
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>
Subject: Re: [PATCH 1/4] clk: scmi: Bulk allocate all sub-driver instance data
Message-ID: <aQ1nJ_HYBcxtqzPB@nxa18884-linux>
References: <20251028034225.260469-1-marek.vasut+renesas@mailbox.org>
 <PAXPR04MB84590D1D084E14A5D6B6BA7188C4A@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <20251104160631.GY6688@bill-the-cat>
 <PAXPR04MB8459585528148DC8B365867B88C5A@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <b475b895-38b6-483f-b498-5cb4247251c2@mailbox.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b475b895-38b6-483f-b498-5cb4247251c2@mailbox.org>
X-ClientProxiedBy: SI2PR01CA0022.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::14) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DU4PR04MB10484:EE_
X-MS-Office365-Filtering-Correlation-Id: ffe1a078-da17-4299-7a31-08de1da37794
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|52116014|376014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?D+HNsVjC5PoO/PZD9o3KsWDtC4UTTSnN8FdyJdJrwG+8n4mCxpJCNAMH9duU?=
 =?us-ascii?Q?CYQyIZKN0akU2HQj57kmKY3l2yKC3NOU68Wtdm9KJq2kQPRp5dlsiY5iWB8V?=
 =?us-ascii?Q?hSutZR56HlK1zGDJotMoo/MhOq8+8akedS4NajRgk5Sj9Srz6xbXdF5uJJU7?=
 =?us-ascii?Q?vaTQl4Q72Lu4vdfJqjB1I4hTAZ0xDeSO0lat965TG47pmuhcifgzrjjqQNRi?=
 =?us-ascii?Q?bbXkH9x5N3FU2baTL1tGr6YyeCLUPvEenwcuDidJyqMP9JnHk/wnjgUsyBLw?=
 =?us-ascii?Q?9rYBSsqFbUqIODCHHPBqrUmRczLvvoUVsSvIsskFMq453vy5wMMQ4DyEyPDH?=
 =?us-ascii?Q?+/WOO5KxD4/2G0rOt5yFQ5pi0uxP26DAeTtLfdTnchmDqPFiiN3qAAPY1IqV?=
 =?us-ascii?Q?soSJoj0BdSUSXSuVMAM5Clcc/3CokNUE1Qmx5MziRRkIhlHuIebVERkvTL3S?=
 =?us-ascii?Q?KwUh5Xq92FQ0+69HeSzxlFkBrIeV9GCErO/M/D4NNl9I1ryPdQbB1PL1xC05?=
 =?us-ascii?Q?UTtAgpDTMsUzqlrCVWitoeW6c7zArXYIrYZaLdhCxke2hd2O2rr4zscFi0P/?=
 =?us-ascii?Q?tXQ614vtVhJPKhjewBHJGQqFia8q6Uri3g6BdsC9+Ff3pYLAjmxHlOoYVpDq?=
 =?us-ascii?Q?C9O4zJcLYj/JfVN5wyAWVj+u2t7ovL331A/JO6o/nr2Uy2HLx1HQT2YdWmJJ?=
 =?us-ascii?Q?1nv6kq8StX7JRc55OXBTuKlUMHJjbTz6WbCbu8cfIB8lupeFdpryDoci20g/?=
 =?us-ascii?Q?mDfx2gPfX/2TrECx4989/X5bEQCOpFCg+3BiW+R21YkysAmXqUN+oHI1lWZh?=
 =?us-ascii?Q?vww5CDWMwiLEZhkqEYnZsg+A5Bb2quJWk8rIXoVx2j5bdiaa9udh1+fqeQ60?=
 =?us-ascii?Q?n8K4TpaeaBUHUmF4fOMSnMgGNcgH7ZeoNcbyjuT6NavQDLYhrooGCvswatz7?=
 =?us-ascii?Q?8MipdYRbWNurs0KWsVADaCa45CZ24QVPuUow05KMSAB+njzsXbCmJjp5HQBo?=
 =?us-ascii?Q?Q3wCwNU0WRBlTpTt5pFghBKApaD4owL91xi3ESws4MKIBjjvQv5OR7B/8b5Y?=
 =?us-ascii?Q?I1CUTTmbgr3wqv3PMQet1WRvODLGYQGNifoedQSX01ik82SBnhrIh/wctgbV?=
 =?us-ascii?Q?5eNqqr+FU0vW5U5PI6g+YKbTV+R05rbaLo9r/4x4q9k9+C/NjhLqochSyHz/?=
 =?us-ascii?Q?OBC4a4l0tKI3n0FRdonPUcEa5JtWl5vu4/jDXExc/Dvc2zl96Wu+BlXo2EP2?=
 =?us-ascii?Q?qy5pVFQ/0mFTikAnHOzAs2faU+MZPPLm52QmFEWtnScheVeUr/WWbTubJmQh?=
 =?us-ascii?Q?ITFeYbSF/8W0Thtg1sL6Hnfq65CwrT+lCgvEOJeJPXyvG10Xvg4FA36q3Mb9?=
 =?us-ascii?Q?1vYgS+kn4iAqsmJwv7iEVkVIfm5IWtUT40brNfAXBdiqsQunDSl4TkF9Mvw7?=
 =?us-ascii?Q?LQR87hhAGAT6geHD81IQeU4myTLa5QYktY1s95NhVhz1Jw4yjZKFJyJTKH83?=
 =?us-ascii?Q?5px+3bTxvtqnmnqpV/V2htnd8e91XsYf0+Iz?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(52116014)(376014)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D+sh4vTDzhS1IYaPHRway0s/90WxXL3Wz1OxLkVuLl1TWlfaCw5iP3iOcOX6?=
 =?us-ascii?Q?0Tl7rVQwulAlcTibR/tQ5cKhnQK7sQIUdTRQCHdRBIGGY35SKAxQwQl/jVWY?=
 =?us-ascii?Q?AUeMzDuy7wnbSzEVaL2lJRSVvDbS1NGvAyYq0boXGTTp9FqK2dEekzlidYCq?=
 =?us-ascii?Q?Mk1aeFq1caKxbdWKTL7zoGgLqhbLCmbhJjbKPbovf3/17tWKXld4rsCbk64A?=
 =?us-ascii?Q?VLYiOeT/PEaeINLLz0rfErLP0AHOG0Lb6sCtGl+DOhEk2lCdm62F+l040T7o?=
 =?us-ascii?Q?5/znS8Ilipi2VqAX7pr+ckHY0Dhc25+7i7XfsF3a7z/r1hVshzEZgcStEWIQ?=
 =?us-ascii?Q?Tuxz1xFBaK3jtIOvaL1v3LOAR/TgAVL3eZvW7WhV/9xqrKl9LSQuorTuuzyQ?=
 =?us-ascii?Q?SeWGseKx4iqF2Iiyjkri62IvNb/+bMf+v1Ebnhfjv8UI7ETRJJw6dth1uBGO?=
 =?us-ascii?Q?xmRQdTxSRTbuwzr7j6gBLXdeGLtgzSShNh04jVBpnYdaSmS5QFFY4omraZxU?=
 =?us-ascii?Q?oNH8EC8v6GEknCZDeg+NL9vTgzhi0PpM5CKYmV/jcynpP+sxUwamSh3kEk9Q?=
 =?us-ascii?Q?hUTk7vdYgvltlXHbNCuOaZHTkQ03O9JDRelbZSxGn10sCC4+i0xjsZ1+Ofmg?=
 =?us-ascii?Q?poShlvjVR2dao5Q9NGImk2iXLk9tqqDqfeAgjZv9trADGqQxxhW9dRv09MQI?=
 =?us-ascii?Q?8LXNsPaf5Nbx0OI3FXHTmk+R4rdBE+RqmcHvTt2X/5Rlk2rwJrUp60tBIWX4?=
 =?us-ascii?Q?wuW+QHi5KIaIDthwntxcDpLLDBkQDac5lzv5F0Ez01vbz4NZxgiEsBTkCrb8?=
 =?us-ascii?Q?2pV/52uzq0Y5rGc98cVMXHmyv+1IkS80nTvRR7ul7IRWHqr9uPuS/pNnIfox?=
 =?us-ascii?Q?OcgcHxZKY+7uR6l9YOJaWELqC1xH+Hei+NMRBWGSobbUSdKuYBrvNqlIW61O?=
 =?us-ascii?Q?Ob2qMwVSGvO0bTuwtwHRADV7+vFXDkTCz2aXNbBy38Us/srIuL1s1N2ZsZ6X?=
 =?us-ascii?Q?r8otIMR+nJ6JQ7ZZkQt1Pjd0ATajapuxX5IEKuJ6NKzDUNSjVLrst4kY9gWd?=
 =?us-ascii?Q?fnYPb2tlzF//32jv8b9errkCdyatMeh2n2ZvTxzM4cFFIyC7s2b9iuu39isC?=
 =?us-ascii?Q?QS2wU/tedmgeteY41rLzdQWRgBSl5rL4iDY4pZZcbXAACatuio6AK0j7cCeg?=
 =?us-ascii?Q?sWLTV4t/FrWvQqTNskG/9ubmU7Zg55ekZDKiFT2NM7ruSLqfMRUp++nMtC8m?=
 =?us-ascii?Q?qL+LW168u5tzFJbWFiNj/64DqAMeqD/xpIMzTd3+6fYMY9d78vuM2mq9qtSl?=
 =?us-ascii?Q?qEjljuPzLTxJK23qU29ZmhjXKKE0wUD5rW1Kj07C0a9zam0p4NHVgPN1G6Fy?=
 =?us-ascii?Q?1n43/UBomKpLTXv2oRpF0sxhPuXHQAvdZ+LnQhKSr6o4QLK9eFZCx/sVIC/h?=
 =?us-ascii?Q?qX1IGd9oJZhKyqg7hbiq9JGBQqVvlPb+eS9VROGm9q/AxUXRLCR28Fe26gtB?=
 =?us-ascii?Q?seTNoHOd+4MNVPckMhjOlnleY1l03z+EKKHGjge/4hKxCIhxxmbFm0KrLHB/?=
 =?us-ascii?Q?q6TXESLTNheypr51uws4QFb1vWPmUzcMDxPu78Ni?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffe1a078-da17-4299-7a31-08de1da37794
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 02:15:05.8638 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IXLFKkiju+Fc/Czl2SNCrVuTKVEYRudHbIWPVlggsGqOLtEJ5CbO0YSiJNqrlBEcWR7yCz4GpOqRaYUPJwwOOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10484
X-Mailman-Approved-At: Fri, 07 Nov 2025 05:40:31 +0100
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

On Thu, Nov 06, 2025 at 07:45:00PM +0100, Marek Vasut wrote:
>On 11/5/25 1:49 AM, Peng Fan wrote:
>
>Hello Peng,
>
>> > On Tue, Nov 04, 2025 at 08:05:53AM +0000, Peng Fan wrote:
>> > > Hi Marek, Tom,
>> > > 
>> > > > Subject: [PATCH 1/4] clk: scmi: Bulk allocate all sub-driver
>> > > > instance data
>> > > 
>> > > I just see this patchset was delegated to me in patchwork. But there
>> > > is no scmi repo, could I use the u-boot-fsl-qoriq.git repo for
>> > > managing the scmi patches?
>> > 
>> > It's a question for you as well. I'm fine with a PR from that repository,
>> > but if you want I can make a u-boot-scmi repository fairly easily and
>> > add you to that.
>> 
>> No need a new a repo. I could use u-boot-fsl-qoriq.git for scmi
>> patches.
>
>Do you plan to pick any of the patches for 2026.01 still ?

I not want to manage multiple repos.. If possible, I would
prefer use one repo to handle all patches and just different
branches.

Thanks,
Peng
>
>-- 
>Best regards,
>Marek Vasut
