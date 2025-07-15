Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D4E7C83F17
	for <u-boot@archiver.kernel.org>; Tue, 15 Jul 2025 02:51:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEBD582AC4;
	Tue, 15 Jul 2025 04:51:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Bbk0fuH6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C24E882B07; Tue, 15 Jul 2025 04:51:41 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D73448277D
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 04:51:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WxAngmKyjCXLqspNR3+MB3JZzP9/P9W6cpJ5KxntpRcsut4XAaIrOO5y2ziQYBJK70uPq6wODKgHGdxEHT5UGGspDHaCMlFl5J6TKHHsPh866sg8eBSUN0INTbP8WitRZuhserCd49r4PfBO1d0xN5AE0gdirQz337l1h4TyAps/ft1xylQZZ1JzUokoG4McA1WCzom7vAoJIadgMF6fIQChQwLcSzLC6/LX0YnAsSvzVtTMNNqyYBh2m/MWBfgbhqw7tREWRZLrN0olWY4cRYYDz+1ClJkQprjHVAiR+XV/ebr3V+PwVQrCR1zux+R8ZDz18qQY82AU9LDcyX7kmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O1Tl/58h3hPyL4GtXH5SVzjWR+WSiehOHiqPI5M6CsA=;
 b=ek3oXi3AVAC2SL28C6YnHx41xkNqO+OeyHijcyhYiMXEKGTdztcnvqKDovqBAv+TRgixPYNPt0illsZU5P3cD/IGIHxuHTLkYY/PYLDMnw7PR8hFiaeIr/9L2ldngxFfaAUF2EnZnxnld6n7XurwQcrZp6NiGqxZdOygxmezaoOpVj8UXEAY2BVH/QhfYcUhvgxic0nkfLJLHNPomKenC6MmQkOY39SPt/NoguyAerdib3gKeg7ji9RGvsOK18JUAwLv9LlKhh42E9iFn8VbhWGzigRXptqXl5OGPWX9BM8Zq3K/q9SYlCkzOZAQktGnT74sKKX2lsq0kgm3DPSk8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O1Tl/58h3hPyL4GtXH5SVzjWR+WSiehOHiqPI5M6CsA=;
 b=Bbk0fuH6JSHAjTGx2UfI6xo3TtBLtV51JH5sHZ8fUEHVCV9gbjZmlAyDJoaBcm0PevQsC4Gmy4CnzWP17uVNtUyXA9vbiO7DZnM0ZsaJOGfHCtBngmU57Fgm1+lUbKYac36aIt1Mu3EP/ouAWad0P9fkMROQ51YHy5q40/D9BYOEdBLBu7XPdSATnyMZRNVqLXm16x8cg3MnRPGTpK/U7/4JAAUjL4nekHkvkxrva2wuBVQ0JtpFg+LVXKznRf/EgTLt66YDUdzu5N01+ZXeY6T42B6By2QaBaC/q3XZDrEgj4s67knZnMbaMPV0w21e6UrPy1DTC3obCahLoEx3Gw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DB9PR04MB8364.eurprd04.prod.outlook.com (2603:10a6:10:24c::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Tue, 15 Jul
 2025 02:51:37 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 02:51:37 +0000
Date: Tue, 15 Jul 2025 12:02:02 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Cc: lukma@denx.de, trini@konsulko.com, patrice.chotard@foss.st.com,
 patrick.delaunay@foss.st.com, peng.fan@nxp.com, ye.li@nxp.com,
 valentin.caron@foss.st.com, festevam@gmail.com, u-boot@lists.denx.de
Subject: Re: [PATCH] clk: scmi: Fix clock identifier passed to struct
 scmi_clk_parent_set_in
Message-ID: <20250715040202.GB632@nxa18884-linux>
References: <20250707002741.353230-1-alice.guo@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707002741.353230-1-alice.guo@oss.nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: MA1PR01CA0144.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::14) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DB9PR04MB8364:EE_
X-MS-Office365-Filtering-Correlation-Id: b12b680b-6aa6-484e-efcb-08ddc34a844f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|376014|1800799024|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?C5joDs7bHKgBwX3+UQ5ALKhetjK8TNsGQSadEv0Oy1NGpJ9UoQ6ZhzCv/hBt?=
 =?us-ascii?Q?S55mwHA+BdoPl/fb2C0DhQ/SFCvPV1aD9z8dqYIZ4dXxORqRcd2EIh93mIhf?=
 =?us-ascii?Q?oku3JlsiiRDjZs2PK3yPN+FoWveYwc1WDyhCHRqE0CGR1zyOXACIfIWDokt3?=
 =?us-ascii?Q?D1hgAwH3fePkyyDlrm51TFXjUms50BqBTxzHiWffsTmwJCUby4RH7cMMr7EG?=
 =?us-ascii?Q?3WjWNIsh7Nk4cZsrnRYe/8Z3ce0cKCTj01i/5vwAmJhaga+cmhauu8k7lLJu?=
 =?us-ascii?Q?XCI7pYLzBm446WuOCo6MFTmkj8HfDdkZxkE78cdGr9szZF/kD+zonngkXE4W?=
 =?us-ascii?Q?YhyKv9XE+emPogeU8e+IIsI1ZzDtXrifMvSfLf7WM76pA8qGg2fcUDiO5CzP?=
 =?us-ascii?Q?BSBwm9+kqooZvM0cqpEog3O9p/7BqV6Jh5Z7EMvEx6QL1r6X6wLWeZJfne5s?=
 =?us-ascii?Q?jK0X2rPjQEplioy6dRLtlmG725HIAMjLWzgAliVbGCycS/FOllULlYS408Cp?=
 =?us-ascii?Q?rWoPW4JUUn38wS/cWKbYwxzLj/TfCaHUhJ+rFPrZ6hPUT2n62fSmMm6wOjxB?=
 =?us-ascii?Q?3DtMtdTtOewVP1KM9mspeJw7rlE8qfIl1bwX/0//+PTq1kf7fio5k/pt/qXH?=
 =?us-ascii?Q?IGQEOHlja0KTcoxyCHWql4YCee5xz/jcoCrY9vVuwvivRM0IfHnIBOUygk89?=
 =?us-ascii?Q?mxjtyhPbQ7Ck8uSPqRRUgRlNkwH8u96zZUCGb3m47J7R5meLx9W6BtryJ+Ut?=
 =?us-ascii?Q?+cLkyWklZbhdRJiQp3J+qd9qN936pUL/mi0/2q1UUxC87kNhlXOQkkWNCo4u?=
 =?us-ascii?Q?4JfOFH2vRTvu7otaVwbgC1e4rl3iRSEQUBaVU5UqJh0JBb9zJJfl8R9mAmAq?=
 =?us-ascii?Q?ZVM97ub1Nu5KWIB377izKZp9IU73k7Smv2bciO3sQVxJTFZ6cs62Sjxyz5ZI?=
 =?us-ascii?Q?1zaUadfTbF4ih9CrKuD/nT/Wmq6wGbh12Tgw+7iCAeMJJVGsFmpwMoMUm8P1?=
 =?us-ascii?Q?wp2mO8JUuZnTpdqD2ZSwZnRN6US8YyFr7NcOW83gETD0ihy/JYiUuuuvsnsD?=
 =?us-ascii?Q?8hVPOm1ZsGorTvQ19DRBoz1qTC9fO19QFWsMfeJjncFanguimCmgUFGZ0x6r?=
 =?us-ascii?Q?bsusuux8kPrkNirs4p1wkYjIRsMc94SJ4P2vGZStVbhUDlBCxsy5vVjxq1gt?=
 =?us-ascii?Q?YIpI4ERmoPc/aaL5c0C5VoyRuJldmXFqyQOAsmhA1o/scDVMSCbfTzKxEHcm?=
 =?us-ascii?Q?wTNSfr2kKxlTls6Nip1WYtzN3ch5LdhVR6Fnxrfnnxk5xC7XzEUWmwE4pAMr?=
 =?us-ascii?Q?VxWbiFxTK2jfgADcb0unsDFcU0gTYJPX82WGSYkPtdfK2IEuYBhYzE0YX+KE?=
 =?us-ascii?Q?OFzK0fHrylx8z8SPUcuaDHQanZ6FUTdC0DEFToABa9GLC4rkpppfg5IhCT3v?=
 =?us-ascii?Q?2vI/MLHHua8lsjRVcrkkBddq7Rzc04OWMznMvABKY9pPAOkLZiDUgA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(376014)(1800799024)(52116014)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rrFkxmaLPdD497CiuJSTy4LejJEaDGZ1UCEaopmTXjZocV2sQb89SWzthjDq?=
 =?us-ascii?Q?fh+4PV4QR1PdTTcDRb2okLSCiRotqWQ81xo0KNj6WVvLto7tkO65YCxC1CG8?=
 =?us-ascii?Q?dYfzDEYAPhGujamRGpzlUpfhdJT+5yjDhS4qNFb9Gm3hPKNB03gkQqxkvTyn?=
 =?us-ascii?Q?P97VG74TuocFmI2aIRFzQUK3yZUJgxCV/kkw5bK+TPTNh1hyEGv5bGlfm1O+?=
 =?us-ascii?Q?ABcRWrZ5LrbN8T3pUkQ8lJ+heEVrHwsJNRratO2kavqFWj9/HFMQRzOpvA/J?=
 =?us-ascii?Q?9V/P+9LKa4dI6s3wMZnrVtIbzrxmyxb2xLOiUHJyRXVjOqvveNAwiHOruyIS?=
 =?us-ascii?Q?VBxxYR5BwmYJDpjMB1LVNeZHl8wS6cXXgJTRybs8CzCEbWDV5tcqQo3KHkSt?=
 =?us-ascii?Q?dl1MzhrBN1PG4yEVUCW5uY+FVp7TkTEVxaPIpmQMkZkqDaVh163GHvIyvekg?=
 =?us-ascii?Q?7tMKX8q2vy2pCh/D3c9A3gA/5apNxFEp6vyh5lex3DUg8ABXhpOQQbkfOuu6?=
 =?us-ascii?Q?I3Sn9zFQgHvqekENbe1nSlYWMYpPzQ3tRJJd8XGNjvScxJAblMriZCf4t/Ph?=
 =?us-ascii?Q?P3j9WUn0La69GQAyw3P/VXIG4oLRh8ovoE43u+Lca79zC8yCnAT2u25xBRU7?=
 =?us-ascii?Q?Db/ZYHnPORhkwPMQkybywatAlg8lROfn5boGw/J4TEsSp/hC5+4UGgVo6eui?=
 =?us-ascii?Q?he+guxn7lZ56EDGS44YEj+sjnhe1bm86V7+ndOwNdj4RpdzR4coRCYeRFaXc?=
 =?us-ascii?Q?d1S/45FFbFYx3q9+sDGBsMPgG/7eK7VD+7HUrRu40GWesDIqW4GHuEOyylZY?=
 =?us-ascii?Q?l/99OeLpW+OagMvHBHP1Nirn6ExxjHMFlf9mglslgp/78lwKrNtCgFfu7c0F?=
 =?us-ascii?Q?Uz4J/uH4PVn0Y0fcLxPtCN62pDccL51w3kwovyGI7JIgTfb7bokj4WaX7yFb?=
 =?us-ascii?Q?VW+/inMDws0c3JXEtzt0IjCPw1WROWF6VeCrNa0lulfzrTwwiDRneu7WyNTP?=
 =?us-ascii?Q?V9aLa2mk5wSBT/ww4D4BTP2/xfqqQPe/D1Rg9RgIoNFAu2zKU0t4P+wHu1UA?=
 =?us-ascii?Q?IP5+Wimqdl2jxls/FLKpykkXxCsL7CwVYvoYXLOCgwDWHFfFpHKGtuahh9M1?=
 =?us-ascii?Q?eQvGV1kNrNWab4cm2SEqSD1gV1C+M24T8yeNNk8LHBHnXzptVgpEmbMC35fK?=
 =?us-ascii?Q?CK6cmRfwQMJw63keBd83cHtKPWtTR2gUYH4GTqUDA2YIuaU3Isne1qwsBdJI?=
 =?us-ascii?Q?d3LTGFB+ladGmZ2l0YloLoQ4OswC98bEPz+LUexNQBup3Yfrlbhtvhmbgs6r?=
 =?us-ascii?Q?MGNHimo98i1boXhpWiUB8X/Gmh5nBpE0g+CXatEVRmNcv/MaBxYWLGRDZ93Q?=
 =?us-ascii?Q?NWSF3sC/WO8kwomPheGzXrUzTshfc/CJUbl8IXadWPeNzy/burqyp3YsKV8f?=
 =?us-ascii?Q?2z/Eo9FE7m9wy4uFVp/xWzgJxsi/MQydWo9y90SZPYZz8Dko+W/0ctF9JOxQ?=
 =?us-ascii?Q?O/rAKAYL9oE/cAfOjUmGfA3RJbv8CAnv8tW9ES59yF8n6/9XyfwGcO8Oqsb3?=
 =?us-ascii?Q?U2pDGMGuy74ZcHAalpnckjjtdWfA2gIWtqqtLDmP?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b12b680b-6aa6-484e-efcb-08ddc34a844f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 02:51:37.6315 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 61OgQekJCAQVdiO2Di9nLFOs1VpV9rw6Q/fjpiNWVnhVRfJUXa13VOwdXwSuwJI1t+yyjzo7uvexOasr7LNL6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8364
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

On Mon, Jul 07, 2025 at 08:27:41AM +0800, Alice Guo (OSS) wrote:
>From: Alice Guo <alice.guo@nxp.com>
>
>Clock identifier passed to struct scmi_clk_parent_set_in should also use
>clk_get_id() to obtain.
>
>Fixes: aa7bdc1af505 ("clk: scmi: manage properly the clk identifier with
>CCF")
>
>Signed-off-by: Alice Guo <alice.guo@nxp.com>

It would be better to make commit clear:
Commit aa7bdc1af505 ("clk: scmi: manage properly the clk identifier with CCF")
enables CONFIG_CLK_AUTO_ID, so need to use clk_get_id to get the real
SCMI CLK ID, otherwise wrong ID is used when set clk parent.

Reviewed-by: Peng Fan <peng.fan@nxp.com>
