Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36964E8FDA7
	for <u-boot@archiver.kernel.org>; Fri, 26 Dec 2025 14:29:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D468E839B7;
	Fri, 26 Dec 2025 15:29:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="uOktxBQP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A1358392C; Fri, 26 Dec 2025 15:29:14 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09456839D5
 for <u-boot@lists.denx.de>; Fri, 26 Dec 2025 15:29:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YWouiMn3tvg+sSuh0fpMGS/BNp/YnBeKAvCRDNabalkSDC+M2e140qM+RMZd0FDnkDCHfppuv/wQpMDXw8/PSszMI/H89F+ezHFkU/mPgeVB+JtsCmC4J2zSEXsxHUyWyX9Or37tkRoRxjb468J+oeSmGB075dCuUiI5mSF/qt8sNHYhfDZekEvjk66tO5KEu2IbcdEiPynjGPHXZqmdW+N0W8LtqMb3UpcpUhXO/LKxgbH+PGNM7hOADSp15H5VI/PPH/5xzCJV+9V28CK90yG37FV6YWGhnkxjEpM0touHJhiv6gZ3TSKzSOryAvyl5QgTdQDdDEudLnnhGxjoSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mGjvMGIpsnT64pMMVOmxwwXziXspEBOq1KJ7sdgTe5w=;
 b=ND35DVQ6ueo4DanJaE7c6vy3j4laytZsjG4cGndZDOdFClL9YUiSW+uniyrGsku6+5k1FrbnpnwamIrHXKF2ZpueKMoh2mrvOOFKwNwuSfbCoEiY924w7Er3Cep/fsC9Ji+WcpA7rSnPDv40SToBtVNQZZxTiOAV0Fj6QWJsHpf1uKADJK26nAaK3bhhlzULINyIBRID5SKy5N4J69AXFWix0us82N/6O5gzTtwABfAW6RdwwKx8upxzF6BzXweT3R03Sma6lftsy5viVbQuBUqPJBwsFAgn9mf4Q0mn7IxXGUcO8d1YJzprTSjCvGVNQ5geY2ZtZsF1MractAPbsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mGjvMGIpsnT64pMMVOmxwwXziXspEBOq1KJ7sdgTe5w=;
 b=uOktxBQPmSH34QhrjtusQawHqgsM+QazRW57ys7DIqtzu9u/oDwJ8a100/6DqRvxPiCLo7TVWdzoztQQ3Ge646YgWtca/2xp7i4FwTYvF62gBjPEwZFWTTbxMtPk6srVcOWW8wKlfe/gMiGJ4sk6+lcFMAlxJGXgtf6X86Nb71E4P0v5H+u/rvwWVr0fywK+EdZzm8/t4DJ805gVaKwaPWuErC4XewBSuLz5oaMQyphNn+Xr979EJrXeFfwRPDVDZxMjBF5VDj70awtVMiYELLec3/DoAcRmna1V2ImcMEVieUXjlmB/uJfAxhpFQ1iHA20v8f7YGS8wCKqTzoue/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DB8PR04MB7033.eurprd04.prod.outlook.com (2603:10a6:10:125::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Fri, 26 Dec
 2025 14:29:10 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9456.008; Fri, 26 Dec 2025
 14:29:10 +0000
From: alice.guo@oss.nxp.com
Date: Fri, 26 Dec 2025 22:27:42 +0800
Subject: [PATCH v2 3/4] imx94_evk: Get ownership of XSPI control registers
 protected by GMID in SPL
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251226-xspi-v1-3-4bb116750dba@nxp.com>
References: <20251226-xspi-v1-0-4bb116750dba@nxp.com>
In-Reply-To: <20251226-xspi-v1-0-4bb116750dba@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Greg Malysa <malysagreg@gmail.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Peng Fan <peng.fan@nxp.com>, Yao Zi <me@ziyao.cc>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Simon Glass <sjg@chromium.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Heiko Schocher <hs@nabladev.com>, 
 Alexander Dahl <ada@thorsis.com>, 
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Ian Roberts <ian.roberts@timesys.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Boon Khai Ng <boon.khai.ng@altera.com>, Ye Li <ye.li@nxp.com>, 
 Jacky Bai <ping.bai@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Tim Harvey <tharvey@gateworks.com>, Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR04CA0002.apcprd04.prod.outlook.com
 (2603:1096:4:197::17) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DB8PR04MB7033:EE_
X-MS-Office365-Filtering-Correlation-Id: 496a0f22-b83d-4c11-db85-08de448b2254
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|7416014|1800799024|19092799006|366016|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q1BDdEpVWmZVN01PdWkxRkxjN05OTjlUbWtJbDJlZEdwYWtjSGFnZE5XSXA1?=
 =?utf-8?B?REdGTnAxdkg0cFYrU0hkN2ZXWHorTjFvcWJQcVNZMWRhWGsrWDNkWFQzZUJI?=
 =?utf-8?B?aXBBSGVLSzk0d2JUZ01UN1JpY3BSR2lQUlRaUEE3RHJoYmFCUTdNTUpvcDhV?=
 =?utf-8?B?cXRQemZDVzNHdEczY3pUYnZDRVlUblJ1WlRTK2YyRWpyTnNzTEthcnVtN3lt?=
 =?utf-8?B?eTVDOFNsUXpieWVNTWxHTk1VVitRSityUjgybDFOWlQ1UGR6U2Q2WnBzWHNM?=
 =?utf-8?B?OXFnZjRSRmUxYTAvSXhjMTRKbGxnb2szbm0wMGNubW5ocmhDSGxlSXNqKzE0?=
 =?utf-8?B?NFAwSWlJYjFtVU54RWRwOXB3M1JMb2VZOUc0QU9sK0k5VnlGZTFvYW50ZDd3?=
 =?utf-8?B?VzJabGQ5b0tFSlR3RW9DT3NXaHBOR0hQZmVpSm9IbUVSekZHM1dJMDcreXJP?=
 =?utf-8?B?MUJIYjU3UGJGTEY0MlIrQ1VBVUlGc1h3VjRydzJKaWxFMjFMUHZBbnZsaW1k?=
 =?utf-8?B?c1NtWHVPclFMRTcyVVBzS04zQWtBbklxSmdkL1BrVklYd2ZWYnBNQkpHMkxJ?=
 =?utf-8?B?dFIzbnlERE1vSkF5QkJHUDRVRmorUFVWbHZNelhHMHdJdHRIQk9DTnFxTzJr?=
 =?utf-8?B?NUFaRHFlT3kvNDVmRGRRcUR4QUJaaWJqdjlCZWM5WmRoZnNuY2MvNWplRit5?=
 =?utf-8?B?UTFPL0xHM0ZBTCtqNkdiRzBPcFNBZWYyRVBNbUV4Wjl0dHl3YSt6bnFEYi9G?=
 =?utf-8?B?eUFKNG5WZFQ5aXRUZzRZa0MvRVdkdFBJTjh6TEhFK1oxUGZKUTNiLzYyL2cy?=
 =?utf-8?B?SXo5ZGhPZjFXbHhiY2FQZFI1cTh4L3N0RldaMWRwVGlRNmlubUZTeXE2cnNH?=
 =?utf-8?B?ZHFRUzZZWkxvNzlpNUdYQnliclNaNnB1QVdyUytnSnYvTW9NdUFKRS9iSHJw?=
 =?utf-8?B?eVJsMDQ0aVpKcitiK1lESTBWSmx6dGFKRFlaM2lLS3FvQ1VPRVcvNHhyNzZ5?=
 =?utf-8?B?Yi94L3lzdWE2Zmt4RUtKaW8rNkZacXpsY2QzZWVQczYzNy82alRhUWx0RFJ2?=
 =?utf-8?B?aUVzRmZ6aGxxRGV3RnljdnhZR0lDTUx5TXBCSzQzc1NNMkNIUGVId3ZPZ3Ew?=
 =?utf-8?B?MElEOVRIV1Y0TzhNaUROZ0FQOVkzeHNtTUprdFBJUytuRkVtVjlBVHUxR2ZK?=
 =?utf-8?B?clF0QmRtTjF3VDZ1TGtqNlBpTWdYNHZXNHp3bi9FWDZONU1MdmY2MTl0cTI2?=
 =?utf-8?B?NHNNK2FyNFhnUVNMbENhempWdUJmd3cxcTAvNnBGdlhGN2NrZGtIaVBIaUZX?=
 =?utf-8?B?U2VOa0RTbHhaWU5KZ1B3Q2grOW5MdUNibEYydVZLRm1UZmpGZFJGZms2ZVNI?=
 =?utf-8?B?YTJrR2tadUZkU0RzT29mVmFTYmtTS0RiNG5INHpUNituTW9kbmRnZFk3Nk9x?=
 =?utf-8?B?TlVpTjhpYkp5WUJhbituQkE5ZGN1NmFpWFpBbi9SNmlmQUtFbnRoRDJ1S1Vw?=
 =?utf-8?B?U05GT0x0THM4QkNIOUEwd2RuTlcvWUhPZHNpTWVnRm51MGhCcCtFajA0RTZL?=
 =?utf-8?B?c1h5S3pkcEVUcXdvYVhNR0c1bTY0UU54dDBXclJ0NmlmNVZ6QW5XVytoTW9l?=
 =?utf-8?B?bStEK3JqQlZ3dVNnZzQ3bEluL1NjZDZxMVRESEVmdjVSOWhWbEJIVUM2Q3ho?=
 =?utf-8?B?U3J5T1BjdFZXQndGYlk0djNUV1h0Nlk3RWdEK2lUMk5nMzFmMy95YU5ybU8v?=
 =?utf-8?B?V0ZCczdTaGlXbEdBQVhXYkZpQ0xJZ1dHUXVJR1FPdWtqZmpYNnFQejMySVlY?=
 =?utf-8?B?RXNMZDhWNHRERnJQK0lWNFozYXdyZ2gvUEFxYzF1dEVlRXdLTDFWeFlIZHZX?=
 =?utf-8?B?YXhkcy9JbnJCS24raEc0VmtWTnZIMWZjYXJTUnBwYjdjRWR1YzQzcHFBYVJo?=
 =?utf-8?B?U3F4amswdCtaSVRTbWdUaVVPcDhrNy81cFlNTGhTNUxFN0pmNjhjKy83MWY1?=
 =?utf-8?B?Q0tXbFlSODlvM0pnVHE0L2VZNHF0R1hxY2R5enU0SldOMEl0aWdBZTY1dElo?=
 =?utf-8?Q?96k3MZ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(7416014)(1800799024)(19092799006)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWNoM0xVdCt5dGx4S0phdkkyT2hYYmJ0RWpYbElDODVWcVloRG4zZy95NkYv?=
 =?utf-8?B?TkIxWDZuQmJYNnZFTkV1Tk1PQ0NvY2R1U25TU1poL2Noc1YyNEVjUWNBa1h2?=
 =?utf-8?B?M1UvWW5hVnZNZ0NYSlBJcVpYK1l4dnMzNTlTZm5BS3BwekRGYXh1KzdTSzBv?=
 =?utf-8?B?aFdiQzZqUmF3U2RtSWhvWktETzZNTlBTZ3FkMzNjUjhHUWpqUDRHQXN5TGha?=
 =?utf-8?B?ZWs5S2NyNS85THovNzBjTWNuNjI1MjBQbmU0TXlnS21GL29LSmxjWVcrSElG?=
 =?utf-8?B?QUJLU2c2MDkxM0xjUGdwcXRvbmM1OEtkeFVPNzlsVWhNbHIyVUNNU1F5aWJV?=
 =?utf-8?B?WVpNYkVyWFFVbWNwSlZWSDZsdm45UnVJRHdjZHN0bmJ1VC9iMDFvTWM4MmhQ?=
 =?utf-8?B?a29jZmcxd1RlaFVtMWZpKzhhdWErNnJYWVJWSVp4eHVtTHg0Sk1sNElBdTIx?=
 =?utf-8?B?RGpYeEd6Y1UrcmxZaWNFVlc1U1lqUmJkMlloNnhVSUFnWk5xckNoOEFtNEt3?=
 =?utf-8?B?d1Q1cGZtQ2pub1VzNmxpbFAzSldUUm9kTXh6S291TW1UZGpjREh6Vkt1ZXVJ?=
 =?utf-8?B?d2NIcE9aN0xLOXFnc2xwUGxhRFFIUGNRYjAyMDNXcDRqc2hYZVNPdVZHYVZ1?=
 =?utf-8?B?V1NTUVRJeCsrd2hSYmJVYW9BS0Z4S1d5K1dtTlBJYWRYa1VZeVQ3RVhsLzNV?=
 =?utf-8?B?eC9tMWlJMDM5b2tlcEdNV3BIZ3VJOHVsLzM2MnNrSlp6SktSYTJ6c21Fa05G?=
 =?utf-8?B?TkNwRngzSGhhRXpJd2NIMDhLZHVFOXBaMTNtaW9HUDBVSU93KzJSSnFkV0Nt?=
 =?utf-8?B?NkpLV25uOG5yVWZuVk1pQ2kxUWowVDZxVjFXRTdzdFhrVXNDUmZTT2VETmlS?=
 =?utf-8?B?QXpPVURKMUNyeGh2UGp6TWgzb2Q3bzBoYkpvTUpuL0NSREI2L0VHa29ZNEZC?=
 =?utf-8?B?eU5Cc09mNWNaR3hyWUprd3NBaWNnY0FqWGJZRmQ3bkRqNndSdFk5U0NVVlQx?=
 =?utf-8?B?cHAxcUJ5d0M1VFdtdXZVRTNvbHMreUpDSTRlNEZTUDVpWm94UXdHeVVpTDQv?=
 =?utf-8?B?azN2Rk81VWh4dTZjTlQySjBXUWtrZW1YRG1SZWxVS0ZZOEdKR1lEaVdYV3cz?=
 =?utf-8?B?Wlp1dWdtb2xOamNIUy9RaGc0ZWdGVjFVN3VHRFZzRTdtTzZYMjhwcUMyaWU2?=
 =?utf-8?B?d2FPMG15T3d3WVJYL05qbXNmQTg0MGxqaTZOaDlwNDJjbzNGZ1hVZUM1ckZ2?=
 =?utf-8?B?c3RmbG9SVHRWZmx5ZDcvckRDSXV0SUY1NFpBdk5TdmRRNjIzQ1M3dlpBS0V2?=
 =?utf-8?B?THdmckoxUjNDeE9EVnpXK2FScXU2QkFZZEduOWV4MlJLL3lpcnR1TG9raXJC?=
 =?utf-8?B?c2QrV2xYdzdrYzEvbHN1azFZdlR6MjFwMG5ESld0dCtUc1dmdlF0THJONUh3?=
 =?utf-8?B?cWZmWHZLS1pzQjFaUExSZGQwMHI3VUdjTVBhREt2aS9wYTROSlp4Z1VHeFht?=
 =?utf-8?B?Y2FnQXFzU09oWU5udWN4STM5YW56cDdENXFBQ0FpTUZFemlwMk5JVFhjUEw0?=
 =?utf-8?B?aWcrVlVUK1QvVENyVHRFM1JsbmlkMVJ4RzZLbnBmWFVBazNzejdoVHdpNWIw?=
 =?utf-8?B?bWdKK0d0ejhISXRzNlFXNFMwNktYek93MnRGYS9BenRhODhDYmtxa01UTmpX?=
 =?utf-8?B?T2ZKNnpuODBpeXVYd0p1L05OR2lYcDBlM0ZmVVpCYlJXeTlNRlVXQVJURXZy?=
 =?utf-8?B?MW9DRkRNRVlESlk0MmplSUt6UmNIT2ZCMUtZNE14SGR3VGxkNU1ycXFRNjk5?=
 =?utf-8?B?WmxSOG13N2c1Z1pmSENVb2kzSGRQV2drMTFaRnpQSmo5RVF5MHpFSmtnVjZy?=
 =?utf-8?B?bC8zL2l1V1BtYTQ0T254Yy9WQ3ZVVEdGQUlYaHlhdkJmOVptQUV1QmR5dS9M?=
 =?utf-8?B?NjVLRzdYL1Z1YnVneXIvbW9wTnUvM2hJNG9qdUtDZUExc3R2SFdLa21ETXVB?=
 =?utf-8?B?VElBSTJ5TjEvb3NMdVMwS1UyRmhLWllIMDBCOGlwaTZad0xtaHU4RFRzUEM0?=
 =?utf-8?B?QWVkTUt3dTRSRHhpZXk2OExPRkRRZE5aeGNVa2tyYjlBWkx2MllvTzB6b2JZ?=
 =?utf-8?B?S0hxSjd4YWJkMlBUdTNvV3h3ZkNwTmkvTmR5akdkU0pLS1lHTTVwL2o5d3Vj?=
 =?utf-8?B?TVE3NmxWNkFNYlYraE9TaVN6WTQzeGgzSUJJWnVJLzRiQUIrOG9nUEpPNHQ0?=
 =?utf-8?B?WUNzU01ZSWxGVlNZQWVXNTlQV21ZendSNmNEaVhKeWkrd0UwcitOVC9QQmpn?=
 =?utf-8?B?NVhLcFN1WnNOK1hBcVpDUkVkd1J2VXJzdUhHVGhLK2w5RGJ2L3hVQT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 496a0f22-b83d-4c11-db85-08de448b2254
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Dec 2025 14:29:10.1576 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HgMrCKUXrTIDPfSC85VUpuJLZuujSeDqfnZbgwVdnx2vdUamEIRjRxdM58QHCsMDO7ZrajZEoqhHBw+VUOd/sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7033
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

From: Ye Li <ye.li@nxp.com>

To gain access to certain registers that are protected by GMID, the SPL
must release XSPI ownership to the current core.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 board/freescale/imx94_evk/spl.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/board/freescale/imx94_evk/spl.c b/board/freescale/imx94_evk/spl.c
index 341b165b3c8..f4529fb5fb2 100644
--- a/board/freescale/imx94_evk/spl.c
+++ b/board/freescale/imx94_evk/spl.c
@@ -45,6 +45,16 @@ void spl_board_init(void)
 		printf("Fail to start RNG: %d\n", ret);
 }
 
+static void xspi_nor_reset(void)
+{
+	int ret;
+	u32 resp = 0;
+
+	ret = ele_set_gmid(&resp);
+	if (ret)
+		printf("Fail to set GMID: %d, resp 0x%x\n", ret, resp);
+}
+
 /* SCMI support by default */
 void board_init_f(ulong dummy)
 {
@@ -77,5 +87,7 @@ void board_init_f(ulong dummy)
 
 	get_reset_reason(true, false);
 
+	xspi_nor_reset();
+
 	board_init_r(NULL, 0);
 }

-- 
2.43.0

