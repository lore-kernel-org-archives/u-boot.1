Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56AD3CDD563
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 00:15:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B7F98905F;
	Thu, 19 Sep 2024 02:14:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="C23THVX4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84B1D88FD4; Thu, 19 Sep 2024 02:14:56 +0200 (CEST)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::62f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A9D689042
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 02:14:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aGQVzQw17K2+HjuLs2jGOmJHieSs6xDZ/fg0GMinb/Jry48NBlCvmJyW1KX9J8j8FdA7atJpERGiAhXiW1M2hM/eYFly5nuEdznLQt3lnUG7GXNSJIfOLp3NpoYjpqNCRJgZH6FmH2/NAp+wDK8O6eXtwXgRqU5EGIbEIZt7PA6JO0abSOGSMNtplt5BBvyfpRSJyFVyKAtjPX4T17WJMdwKn2R0CociF2oPmPJXe9SkzZ5yFR4H471D7jXAMdiNqB2TuO1I/GHjg0mDCSJ+y+YSch+ik9I7UgnlETVOXz80PQ+IYdf+v/DfvN0N3/IqsJbEZxuEOBrwt7u83nZvEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hHHdFoqrFTQ8SidgdeVfUk7rLwLFSVoDgg+MOv29gWU=;
 b=HK9+99azVKche+iMqXBR50zlRUN5hQwxSfprlYkL2/KOc0D0U97o7qyoic4wLlf4yh1l3BxeGVgWeRc0rkvNa8Kzqfep9wOehUeUO/Ru2pwQuAXq9eeInofdmXL6mRiy43T40MJVJhHsD/bVeca0WERpn1A5ABBxVVY8i/KRwaf4TXBHpC1TrAsEphDcRbWNJ5EZrJHe/tFmjkQtAjYMiT/KeSqsEImJWpEfXN3mR8Ms0UPs61tuZ25LOwIeNGp5liIQt0LrZHqwpu+7+UuuphuwRYfsOSpkcAp+L41EmLFsj6aw5y12psvyjGx18IVYiPZUoino+DKDXI8ieaDmFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hHHdFoqrFTQ8SidgdeVfUk7rLwLFSVoDgg+MOv29gWU=;
 b=C23THVX4dJw8zB3qGjM0T9kV2cfOAlM+nncyXkApQ4HdyoSNPKKPltQCLSWBMJhq4sepXi1q+kiwu+tRuK1ahw+3nEvkt2TvNnDooCVy4H8rbL9vD0OaEgfetAEzn1Ei+yRFHdhUqn/OF5P+ieSOmDbdxpeSn93jhgvE4GJERvGEuMkZ8m2bXsXpLm0NdmKrdLmitqZyne8mYQq7gpT5hszImQXaSjv4H1SF5D1D0lGoyU8OWH1+1ODu/DvxRUTdwuEe8PvypaJvYXqguxr9i4smfXni6Rfsy1wIL44myXHJX6MhIz/4Ouzx0FqXBag0BenfLq/bqcJr0YcuCFFioQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU2PR04MB9066.eurprd04.prod.outlook.com (2603:10a6:10:2f1::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Thu, 19 Sep
 2024 00:14:52 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7982.018; Thu, 19 Sep 2024
 00:14:52 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 19 Sep 2024 09:18:04 +0800
Subject: [PATCH v2 05/21] imx9: soc: Change FSB directly access to fuse API
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240919-imx9-update-v2-5-0d798d9e08ad@nxp.com>
References: <20240919-imx9-update-v2-0-0d798d9e08ad@nxp.com>
In-Reply-To: <20240919-imx9-update-v2-0-0d798d9e08ad@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.1
X-ClientProxiedBy: SG2PR03CA0130.apcprd03.prod.outlook.com
 (2603:1096:4:91::34) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DU2PR04MB9066:EE_
X-MS-Office365-Filtering-Correlation-Id: ec31b6d8-3283-4f8c-f012-08dcd840153b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TENNanFlUGczT2dweVZBeVBTOHRGMjhJVXJUWWJiSzBLUVI4dUNaWWMwK0kx?=
 =?utf-8?B?T1MvTzZGUkJyL2NMYXVsWjhXZE9IdVkyME9SUGpTNFpXVGJkWUJ5N1JrUUVP?=
 =?utf-8?B?UVpCcFJPTEI0TUROVmNLdUx1ZFpHV2tORnBVODZ3eWgwWUtaUGpZQ096UWl5?=
 =?utf-8?B?RDRTYnIyNGJEM0ZtYUdxYVVrV0VvV25PeVkxdkcxMVdEdDBiQURZdzY1bitR?=
 =?utf-8?B?UkNUeE9iRVg0amJQbXNUV05ZV1cwM3FyWFJDRmlUcTFGQjgwUVFvVFd6djd4?=
 =?utf-8?B?T1VWTVJCT0FIRmt0eG5mTFVZNkZFR3pkVjhlYnRwR2gzYmNmdEExM295Zk5S?=
 =?utf-8?B?Z0tsREtTTFJFL29IejBFd2kwZVJITDEyL0NmWE5tNTRnY1p5U3RkenFrdG5V?=
 =?utf-8?B?VU85bFdnd1BaanhtcjdyRGhJTWFUTzNXZ3hCV3hJQ3o1RWRRSlZyb3dFQlNW?=
 =?utf-8?B?bnB1WVdIRE1BazlBMXlyNDRtb3RCT1BNd01abHpNZXNNR2Q0NE5NSjNOZFg4?=
 =?utf-8?B?VmlTZ3E0dFQ1UDV5bXF6cDU4QUI1eS9yYTl0UHc4c3FtU0dMSEdjT0ljMWxz?=
 =?utf-8?B?SzcvdWVEUXVPL2FVRCtOSTBpMEs3eHJLUXYxU3REWStTTmRxemdELytvZytM?=
 =?utf-8?B?R3B4T2VWdGNEZXgzUkdMWFhBUXBxb3BDaTdRd0I1V2VYdGY1WGt4QktNUU91?=
 =?utf-8?B?T3JlS0VmSlhIdUl4d2J1TVA2WnpPRmpRUkFtYU96L254cTFUMExEc1FOOXdK?=
 =?utf-8?B?cG9FVUwvVmtDeTE1UnlsZWJZL2F5Z0dva0lrTUFGZTlZbFNHbmZQNnNoSHdU?=
 =?utf-8?B?MUZWTE55bzZaZG8rYm11a3gySHFrUmlQakNDZE1yenJHUHM4TE81aWkxRndn?=
 =?utf-8?B?dkN0QVVaK0grYmhSYzlXSk1OL1FoalAzUis4MUNqQU9TbmNvM2pLMFVBR3J3?=
 =?utf-8?B?SHNZZHpIM0JaaW1zSnR0UFIxMWg2TUFKZ2RzeVhjd2tsV0V5aTZHdk5vclBy?=
 =?utf-8?B?RlNFZ0Z0dVVSZmlLT0V0aE0xWC8rQW1YTUI2eHhhbExnYTYvaXcyNHd2MkF0?=
 =?utf-8?B?UUUvNDhkTDhVOU1FK3RJTnBudGlnUmxSZGxoOFZsYUxseEZsZnlDbzh2bDhL?=
 =?utf-8?B?ZmdVTmFrNFRiL21SdzBwRm5WS0ZISjZXTDlFbVhIa2Fpc2NnRWlucE16NXBB?=
 =?utf-8?B?MWdjRkNOTTlGekQyV1VlY2FiTnhlNjBYZ2JDcU5oSDJ5ZHhObkEzMUFIUE5Y?=
 =?utf-8?B?ZzhFQ1lzMC9lM2VMUmtaOHByZzliTWNSMmZmUjZqYTBscVVGOTU3a2tsekFi?=
 =?utf-8?B?UVlzZnA5QTZLemZQUDlDWlc4dkZUUGllQ0lObzdCb3BLVEFLK3pQMDFFTmw2?=
 =?utf-8?B?dDJiYVE5M1lQMWcyYjJuRDh5T09UUTJDbFh0cjV0ZlVJZm02MTJhdzJXTXNa?=
 =?utf-8?B?dEZreW52ekQ2Unhkdk9OTGNOdVl3SHN4SVk2SUpmT3V5b25hSUl3blM1S3Vj?=
 =?utf-8?B?S0NnczJHVGs4dXRsY01ob1krZmdBVjdnelRnL25hSHZaY2QzSllFbnc5bG1M?=
 =?utf-8?B?Qmt1bWZkVStmSWhCRExJU3U0aWdmZzNneEpUd2hZa2U2cXRxWFdXNmxsNGFy?=
 =?utf-8?B?OEhYT2pkcGRtc2hIM2NJUk9vcjJuTmRpRzQ5MHYyZVpNNVNhTzk3WEpaRmsr?=
 =?utf-8?B?aENyYXJaMmVNSWloOGpEUlZZVHFEN1N0cHdtMzYvbTI3TzB0Njc2ZzZIQXJu?=
 =?utf-8?B?YXhiWHBwdWU4QkxtTTdWWjF4N0JrbGFicG1RTWpCcmVXbVhzU1JScW43SCs5?=
 =?utf-8?B?ZUppN0ZPZ01GbFE3T29USjRtNTB1QmkxekQyZWp2Y25GQTNSZGl5UlBVazhy?=
 =?utf-8?B?M2NoTjNBaVluN0NTa1R5eERvZzdmUkNMei9KVE1SaEkzaHc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXZtdVhYL2JpMitFL002cW5XYU5IbXRHMzVwQ0wrMlBTai9ZelF0UUc0T2xs?=
 =?utf-8?B?QVNyMkRGc0FIenNYUll4SzV3akp0bEdPMDFtOHRTVG9JQTlMYTkxMGU4OUlk?=
 =?utf-8?B?OUVEeGFCNXFuU3A5blVzVDZLNG93NjB4ZUk0dlB2QjNDalg3ajJKS0p4VG1l?=
 =?utf-8?B?M2RHSzFhUFk4YTNSWmJvNmUxVGJzSmMyVWhOVjcweHVCV2UyamkrUlYwc3hj?=
 =?utf-8?B?c2JZeFM3NVdGVVZneVNVOFdFWGJrT3lSUEhzSmFoNjBPZUZEUkVSb0psa1Vl?=
 =?utf-8?B?Sjc3SmdsWDJ4b3crTGJqNHNiRG83SHpZUmtoVG9RaWhEMHBhSmhRWnVsMzJC?=
 =?utf-8?B?c3NtcHBOaU5mN1lJYmptMExMbkRGRlkyLzBIR2pzOExlSENQeDF1REplSFFw?=
 =?utf-8?B?VFJmekp2RlFlcU9OaFlmZGppME12SDNTTVp2OEpJbjdZbDhpMDZ5Y0ZBZ3I0?=
 =?utf-8?B?Zm9iTDVuT3o5OW5MUHpibEFocXpJSHo0M2xOV2FwdjBHTlF6UDFTMnVQcjN1?=
 =?utf-8?B?SmRveGNicHNRYTl4bzlqdit2VW1LZFQwa0VjeXNqTGNMeS9uZFZGQWp1VWVW?=
 =?utf-8?B?NnZzNk5EZm5TSzdIWHIwbjFHSEFmcW0veWxCV0xoQksxZ2kwUE1wY2lNVmJs?=
 =?utf-8?B?Y0pKaXMvTE1RMVJFb0hQZ1R2ZHU2bFM5NjJYakxROVhQT1NQTFByc0FCK1VF?=
 =?utf-8?B?ODBGMjNUM0ZGZUNDa3U1dnBQengwaG4zMTBKb2tyaTIxWXdOTi95Qkp6bWdj?=
 =?utf-8?B?cStMWU82ZXNWSktIb01jRllXRzQrUmZaL2w2dFJXTzRnRWlKNXNWU3NYODdT?=
 =?utf-8?B?VWpyOTl3NGtEK3pkUXJyS1lKZXZhV2R1Y013TWFqdEpwK3JpNzd6MlVRbDhU?=
 =?utf-8?B?SDU4bDI2QzdkS0p0dVBVaUlUY3lFWSsxZlIzU0VySHd4b05vMkhzdDFlZ1ht?=
 =?utf-8?B?RUU1UzkvUm1TYVhqaExwTUdUT2JkWHJuU2RTRUg3OHZVK2Q4U2drZThZQTRL?=
 =?utf-8?B?bUROYTRoM2FxbVJFbEIzWkRkdUxYNDgwdTA3bnpoYkYrQ0laalBYVUhZZjds?=
 =?utf-8?B?WGNqN0NyUkdLc1VaTXdieTJkM2laekxzSk9GQVp2WldGcERldnNKYTlrTlUw?=
 =?utf-8?B?b1hUV1hFVmFkcmhNajJ1V0JKc1B3VlR6bHBvMlBBWmYzL2lpL2ZtWkVxUEZB?=
 =?utf-8?B?L01qZW9yWktscWIrL3hBbytGT3NCL2RHNE1GMWIwS2JDUy9tRWdqeXlkOXM2?=
 =?utf-8?B?V0I1Mm1Qc2RDclBwNVVFRkp5c2RJekhCZVdwaldBMHNPNGMxelBWRDdqMnRk?=
 =?utf-8?B?WVUwRlRQd0oybG93VjdCYStrOGM3NXVxT0FVYWxyM2JoY0lpUFVvRWxlSWNq?=
 =?utf-8?B?SVZoZnlhZml0TjZ4WGVDNis0N2NIckhycXlIc3VuNjE1ai93WnNEVm1vQ05s?=
 =?utf-8?B?STlBa2k2Z1I5N0NMeDNrM3RtYTlPZldHdndhMzZ4cU4vOUFOa2NOc0hEQmFW?=
 =?utf-8?B?UHJ0aDEzdUpiOXU1bVl6Z05aWVErb0RGSkpFOVlLTTFZWk5FZ0FkeHNDUGps?=
 =?utf-8?B?aUdQa1l0SzZ0aGNLTnRZTXRRYXNwZXlmUXhEemc5blE5cnRjODFnVnZ1NHg2?=
 =?utf-8?B?R1dNNUZQWTNPaXovaWZKT3hWWkgrakRwUDFhandrT29WZFpMK1lXMDRTYnBh?=
 =?utf-8?B?eXF4YzFTamo2TGJGUk9aZHBhcURER0tPS2cwQWJlbVFYY09sOGsrSTluaG9v?=
 =?utf-8?B?VEFJcXhxS2NaandRa3RCcy9UR0cvNkJYRnU4dkNyTGM2ZkVkYUx6SGlFeHRP?=
 =?utf-8?B?cTMrRzRjblNEdU1XY1ZRWnk4SElZejlnTjJRc0VtRnVwY2toN2JPZlFhbXN2?=
 =?utf-8?B?TUhKSlR1VXh2OWZHUjIzWWpGV21qQ0k2TFh1ekxZcXZwVHpGYnJLRXJoVEFW?=
 =?utf-8?B?R1hyMkQ5Y3NxMHlXZ3JrNjQwbnJpaHpIendDUFZSdkJJbGV2ZXVPMno2dUtS?=
 =?utf-8?B?R2g1K3k5Qk9Wb2RNUWNXNnlhREtXQmU0aEhaNWJtZks5dnpFakNDSWNQekZw?=
 =?utf-8?B?dC9FM0VSWGlpaHpmWVY1N2lhNEs2VG1LdTFCNUlIYVVEd0ZZcC9FWURQNkV1?=
 =?utf-8?Q?2Yu4iycrEAqJF+Awy1M4NIJmf?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec31b6d8-3283-4f8c-f012-08dcd840153b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 00:14:52.6534 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dDXcPsgAQq5HCcBosHoXrwNp9uElxCSMX/OBMumck3v8h3xkZJW3qQ5FCbtD6Unb60J5kRk/3uoYL5T6F5Q2ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9066
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

From: Peng Fan <peng.fan@nxp.com>

To support OSCCA enabled part which has disabled FSB access from SOC,
change directly read from FSB to use fuse_read API.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/include/asm/arch-imx9/imx-regs.h |  3 +++
 arch/arm/mach-imx/imx9/soc.c              | 38 +++++++++++++++++++++++++------
 2 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/arch/arm/include/asm/arch-imx9/imx-regs.h b/arch/arm/include/asm/arch-imx9/imx-regs.h
index fb6de533d12..cb6b8a59cad 100644
--- a/arch/arm/include/asm/arch-imx9/imx-regs.h
+++ b/arch/arm/include/asm/arch-imx9/imx-regs.h
@@ -52,6 +52,9 @@
 
 #define MARKETING_GRADING_MASK	GENMASK(5, 4)
 #define SPEED_GRADING_MASK	GENMASK(11, 6)
+#define NUM_WORDS_PER_BANK	8
+#define HW_CFG1			19
+#define HW_CFG2			20
 
 #if !(defined(__KERNEL_STRICT_NAMES) || defined(__ASSEMBLY__))
 #include <asm/types.h>
diff --git a/arch/arm/mach-imx/imx9/soc.c b/arch/arm/mach-imx/imx9/soc.c
index 7df3c686350..f3d6c7f84cb 100644
--- a/arch/arm/mach-imx/imx9/soc.c
+++ b/arch/arm/mach-imx/imx9/soc.c
@@ -96,10 +96,16 @@ int mmc_get_env_dev(void)
  */
 u32 get_cpu_speed_grade_hz(void)
 {
-	u32 speed, max_speed;
+	int ret;
+	u32 bank, word, speed, max_speed;
 	u32 val;
 
-	fuse_read(2, 3, &val);
+	bank = HW_CFG1 / NUM_WORDS_PER_BANK;
+	word = HW_CFG1 % NUM_WORDS_PER_BANK;
+	ret = fuse_read(bank, word, &val);
+	if (ret)
+		val = 0; /* If read fuse failed, return as blank fuse */
+
 	val = FIELD_GET(SPEED_GRADING_MASK, val) & 0xF;
 
 	speed = MHZ(2300) - val * MHZ(100);
@@ -122,9 +128,15 @@ u32 get_cpu_speed_grade_hz(void)
  */
 u32 get_cpu_temp_grade(int *minc, int *maxc)
 {
-	u32 val;
+	int ret;
+	u32 bank, word, val;
+
+	bank = HW_CFG1 / NUM_WORDS_PER_BANK;
+	word = HW_CFG1 % NUM_WORDS_PER_BANK;
+	ret = fuse_read(bank, word, &val);
+	if (ret)
+		val = 0; /* If read fuse failed, return as blank fuse */
 
-	fuse_read(2, 3, &val);
 	val = FIELD_GET(MARKETING_GRADING_MASK, val);
 
 	if (minc && maxc) {
@@ -160,9 +172,21 @@ static void set_cpu_info(struct ele_get_info_data *info)
 
 static u32 get_cpu_variant_type(u32 type)
 {
-	/* word 19 */
-	u32 val = readl((ulong)FSB_BASE_ADDR + 0x8000 + (19 << 2));
-	u32 val2 = readl((ulong)FSB_BASE_ADDR + 0x8000 + (20 << 2));
+	u32 bank, word, val, val2;
+	int ret;
+
+	bank = HW_CFG1 / NUM_WORDS_PER_BANK;
+	word = HW_CFG1 % NUM_WORDS_PER_BANK;
+	ret = fuse_read(bank, word, &val);
+	if (ret)
+		val = 0; /* If read fuse failed, return as blank fuse */
+
+	bank = HW_CFG2 / NUM_WORDS_PER_BANK;
+	word = HW_CFG2 % NUM_WORDS_PER_BANK;
+	ret = fuse_read(bank, word, &val2);
+	if (ret)
+		val2 = 0; /* If read fuse failed, return as blank fuse */
+
 	bool npu_disable = !!(val & BIT(13));
 	bool core1_disable = !!(val & BIT(15));
 	u32 pack_9x9_fused = BIT(4) | BIT(17) | BIT(19) | BIT(24);

-- 
2.35.3

