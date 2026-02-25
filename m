Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 279CEF55425
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 00:14:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9D7883E62;
	Wed, 25 Feb 2026 01:14:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="XtdJIr2T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8301B83E83; Wed, 25 Feb 2026 01:14:30 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D6E883DEB
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 01:14:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N3NovoY3sPwEipZfmxyFfQM+lF1QTvPu6Bpv6e6vnklFbfFpMwlBsDhi9b8nHkZ5dGuvzUAZQDEhjnlrXEV+0w0OklfpzPJ1oJSf2iFZsFNN0GJn0S+i6vt4w9zUcVTFK1gLWGLdRahA9Dh66kBsJzg3E5lQx0ulzDKyukcJ7Ntf8jxbBMClI8G2VzB62kEBFO5eTgGHvVTICAIshx5c9MACkM5ChC/nO8LsExeWlV9D7GnQfn6C+DgrE9K9x90kr41Vh0iCVh9IxO20S4exkmZoY4iIpUNvHQqd+6KbQNHRMb91UNT1a8zRcc7uPSJuCMVb5XQ2VJ0Gu2ucmyWoVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=00hsBdmyV5e4jKxh+0NXSL8zOr+I/EUMBkKohHgmObY=;
 b=ewLY9LjoQG/0Is5jC3oaCkqPFS+qpXvmWFTVtAy9+tF8soCWCs2vWHZNwsBHjVu2/d4ZV3ZBUtUYWhq2xTxNMhfro7mLPBhA1ekPtrjZg3XlNDUwrOQ8f8UAAwxNkRhUJ21RILfc1g6ylLYfae+dO91VWUsTzGaR0mwMHlv+ya+Xf54nqGj/c/GtVGSV6tuqQWNFbFcuLs0/GR9zwbdrMY5v5rC29IC406PNgo/Vpv6B+fAcvW3oGCgo666YzIMm8gEBPaKv1pgH1UG5478crCZgnGerR7b6hY06KtfxwiJkbSncFvDqh2oW76hsbLYgwu6M7uUtW0hK9RGexnO7Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=00hsBdmyV5e4jKxh+0NXSL8zOr+I/EUMBkKohHgmObY=;
 b=XtdJIr2TPV5HpocakJb590JWgoMECLGGMDt3cyHl/ZU8xDIT0juMFfOSN7Qj/rRqfE2BYP10015QNmB1E15gE/fC7agfa8raXbLf5TJiqTsFB7lOP3qncWgYe5S56PLglsYdMwMTkixEzRQx164mNMtHetjQ8URqsEox0xPz5LWvl2UHM0qsTNZ8TIxohYoGh3np+3WI7ewAKSRwxMHBfaTlwLiIci9UnhcePt+oI1h/e/q93XrGesHnQZnSWk9ZCLmQBV+euyTJortXejizMNo8wBrn7s8G4hsw6mMwPPNS1vRAgyAoIx4lGma82e3kTTnPSOBKuyLquP+fvIGgSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VE1PR04MB7342.eurprd04.prod.outlook.com (2603:10a6:800:1a0::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Wed, 25 Feb
 2026 00:14:26 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%7]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 00:14:25 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Wed, 25 Feb 2026 09:29:29 +0800
Subject: [PATCH 03/10] pinctrl: nxp: imx8mn: Support print pin muxing
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260225-imx-pinctrl-v1-3-7a149ab8feba@nxp.com>
References: <20260225-imx-pinctrl-v1-0-7a149ab8feba@nxp.com>
In-Reply-To: <20260225-imx-pinctrl-v1-0-7a149ab8feba@nxp.com>
To: u-boot@lists.denx.de, Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>
Cc: Alice Guo <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SI2PR02CA0035.apcprd02.prod.outlook.com
 (2603:1096:4:195::22) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VE1PR04MB7342:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bc6f926-1e89-46d2-3918-08de7402d53f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|366016|19092799006|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WjN5elIwa1lpOVpFcXFZMnJ5THVFWW8vNGx6R3ZpcGJEdGxYV0gvUXFWakFv?=
 =?utf-8?B?QVRnUXVZRHpTWFJndTNNaTdHSENEejZJZnBvOGgySHo1TlBEUjZ6aWFmRUpT?=
 =?utf-8?B?U1Y0MzdMbWt0cDYxNjFqZ0MzK3plSXVMYmduUVowNTdTRk81UkxpVDROWWVy?=
 =?utf-8?B?MTJXeWN2Ty9BOXY1ME5ZL1h0alh1Q0RlUG9nM28rbGdUSkRKaDdONGhPTVpQ?=
 =?utf-8?B?RkxJcnZIRE5TYVVNTlM5ZDhQQzVqaWM4bSs3dFN6TS9DN1ZKcXUyVHJvNFVk?=
 =?utf-8?B?Y04xdGthN3VvVFBEWVdUWTRic2ZmMzFNUyswTFVaQ1Y1aG9YZ1V4bzEwOWFl?=
 =?utf-8?B?bGx6U3JOYVZneEl1YWhtVzduK1Y0N3ZDeUNoN0txMGk1d1FmTXN4cXd6Z3pE?=
 =?utf-8?B?eEVqMnNIT0ZZSVNESUZlSU1YY1FGZGQ2ZEJuVjZUWDFjYlRybC9yMDg0NE9B?=
 =?utf-8?B?MUV4ZER5b0kyNjZ5cnNKMzkyejhlWUczMUtwekZMRFZIWkxHaS9lZElSb1pZ?=
 =?utf-8?B?VFV2eCtuN0VOQ0F1YVRMaG1oa0prOFJKdXU4RlJ5c3NnbWJ1aWYvYlBIazhE?=
 =?utf-8?B?WFp6SmxLVnpYVURjTkdSWUlGZGRydkpuSk5XTnNWYXl3bHplZUdKbTV0YTBN?=
 =?utf-8?B?Q2d3Mmt2MmdhQXZwd2c5cEp6WHduMVptMTJvbmdSY3REeXRWY0RJdFV6T1l3?=
 =?utf-8?B?R011cjhDbzRBcmo2V2g1TU5kUVhnRHcwcDk0WE10TnZ1dVczTzEvazFFWG5w?=
 =?utf-8?B?Y09CNlZBbGtIMWVOWGRjdUZFYlFEWiszdDBWdU8rOXBtRnNISURSSlVDKzl5?=
 =?utf-8?B?azRhaG5QZCt5ei9hdXk3MUVBcmZHMUNkZEFyQUYzYlZIdDNuL1BQWjk5angr?=
 =?utf-8?B?Wm5JQ0NjWGFqL0UrRDNsaWtVaGpKRmplS0dYQWlTbWRVaUhXaUMxUHU0RDA1?=
 =?utf-8?B?bTVwYWs3aTIvTDlMUWpiRHVMZjBkUHhjNTdrVVpWUG5JbVNRcXlQdWdObUQy?=
 =?utf-8?B?QlkyK2xsdzZkTktRSTJwY0FRNGRzM3RsWU05YlJnaGw0ZzFmRlpxMDhqZFhG?=
 =?utf-8?B?aTNsdWJRNElMdHlYRllvT3J4OHF3SGd2YzNiTnRpbll1RzB4UStJb3dZUnJD?=
 =?utf-8?B?c24rZDEyMkcwSkhKTVIzVm1JTmI0VGhqNWYyT1ZQcnlBN01Kc3Q5RHJiREtG?=
 =?utf-8?B?VFEzOFp4dXpNWC9ReHRzR3ZFOTFzTkx2aFptS0U4em9Xa3dlWExjU3lraGsr?=
 =?utf-8?B?dFlBN0h2ZGRvWmE5cXBIM21mWHQxS0VSY2wvbTFvMGYrYXhKZGpKd214K0ZK?=
 =?utf-8?B?Qm4wMmVVUkJ0YjNCSDhHNExwek84bzk3QnhpVWlFd0ZNa3FYQm5UcHVETWxH?=
 =?utf-8?B?WVVLemhIWFl6K2RhcEc4a0g0YkRVT3dxRzlQZTNyRTNqbmxHbUovclB5OG1P?=
 =?utf-8?B?WFBsZWlPRngxcG1FWVhvOWlacHdCR2kyMWZ5ZGhZUjd4UllrU0RFN3Fjc1g4?=
 =?utf-8?B?d3AranJnNHR3c3daNHJSaHp4RkowWDZtWlJ0aDE2T3VlUThGWSswUUVWWEFk?=
 =?utf-8?B?aVIxWnJZKzdDbnNWOXZqRUJoRjJyNDIyMlVBSWowV1IvT3N3Ui9kSU5JRVE5?=
 =?utf-8?B?VUtTOWxSR0UrZHdsSUtHWG9yb1FjVXg5WmtxYUtLSXh1K2dkY0tXd3AyUDRl?=
 =?utf-8?B?L3hvMlovOG10NjZjWVFQK3lJLzhLOTFQUE9LUFRDUWI0SG8zb0ZsKzdSeG5P?=
 =?utf-8?B?VnU0bmlyTjQ2dXZwckRNTUlkSXBtb2c1VmFudmFINjVUQWJLcEV5L2QrTWMy?=
 =?utf-8?B?WFVwZk95UTdCTk5wd0c4TVQrSjMwYkNrKzhkNCtDSi9sdlR0V2VoTGJKNzB0?=
 =?utf-8?B?OW9GbVVrc0ZreWQyK2tGU2pDcWY0TGQ2ZmZGeHRZWFVUVng3cXZPdFZJOXNy?=
 =?utf-8?B?NVFyWkk3RHRZa0hpK0k1QXIrK3dTUVFmMU1mTXZjZFJQdkNva092cGlEK2Fw?=
 =?utf-8?B?cFM0bXhuaDd6c2lpdU44dzJla2RVNEZXQWZuN3IwOFVWRTYwMnNvUWhyaFRH?=
 =?utf-8?B?Ynlwd0ZyTXJtaGY0ajY2UEtwcXppNTI5WW9sRWZUMWNmQ0RaUjFKWjFyOCtW?=
 =?utf-8?B?V3hPNzFYTnNXV3JlNFdlWE5MVG1QNlI4K0tmMWprUFdacFA4ZVZnSU9XYjZF?=
 =?utf-8?Q?Xy55IJB+sTsFf5Y7yrIj6yw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(366016)(19092799006)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzhIWFF4MHVXVFZWdlY4M1VONDE0V2lKSlg5NGpmZDc1YjcyUUhmWDhNZEl4?=
 =?utf-8?B?K25HTDVOV2U5dTlUL1l5WHErb05MYVllUmc4c3J2NU5CQUZxUDY0bzVDdU1t?=
 =?utf-8?B?djBlRkFyQ0pUTHhtYlRidE1CNHBoOXVia0VkcVljdFFxVEoxNVFzaHNxL05D?=
 =?utf-8?B?UG1XTFRpUDEra1NVNEY3T0IzVHZkSlU1WjZpRVBiUmJkQTFZMER6N0g0enlM?=
 =?utf-8?B?cjh1SnFUckF6N29ISERWRlZmMG5SWEFFQU9hYVJwOVV3WURvQVRMSDU0eWR0?=
 =?utf-8?B?c2pZQjZqSTdmS0hlQWxUaDJhdU1kVXRUZGw0Y2JFSlZqTEVrTm14Y0oyb1kw?=
 =?utf-8?B?bldIVmpDK200QmZSWGVnTmpreU9ZemFJOEpXVExjeUx3NWxzbjczQyt0RUEz?=
 =?utf-8?B?VUtrZmFHeFNFRXAyOWJ2aDZrSXorQTFQSUppdDJuS096VFBCZWRmSXZRS3ZU?=
 =?utf-8?B?dVRLbjZJSkNESm5SYUhmT21VaERtcUIxT2ZEd2xwTEoxaklpZUkzaWNHTkJm?=
 =?utf-8?B?WE9hdGtOU2ZjQVIwUXFVSmsyMUZwKzFWWWVGcTNsS0llcEJiWllXVlFzbUJH?=
 =?utf-8?B?R0w2S3NzYjJ6b3JLOGFHZE5MWHdaRmJkMVV6RGE3MnZjQkpaN0hiLzR6NkZO?=
 =?utf-8?B?dHFIR0dJVXBJSHU0b0oyVEd1c2lUNHBzUDBPUGhTZWlTZEwzQXdQT3IyYm4w?=
 =?utf-8?B?U3FpcnBKbXUrSUQrSVBMcEs1RWppSjlJOVNDUWJ2OHZIREhDaU5KY3RTQm1N?=
 =?utf-8?B?dXgyRFRsMU0yd2VicjJZeXI0YitURlZ2Z3JBQWE5aE01RnMySmdXV0t2VlJi?=
 =?utf-8?B?S1Y4cUs2UGFLc05vNFA1Vno5aGNuVnY0U0IybjJKc1lJRGpxcnRSdGtEWmV4?=
 =?utf-8?B?Tkk3UnhLbDQ2b3lXaVo5dHhpVzBpWWQ3cUROV2NaVmgwKzFWZ2h2M2d6Q3kz?=
 =?utf-8?B?MnhLYXZZL3VvTVI4eXF1YVlRMHRoUkUvSy9sNjI1OHdnbVpoejhzSktmMW5w?=
 =?utf-8?B?MlZ5ZXpkWDRkbWJPN3FuS2RqUDlHK1d2TGRNdlV6Q2luYjVXSWpjeEgrZXlO?=
 =?utf-8?B?WjRoeEpXS1BvUFB2VjVkeHlQZ2cvT0YyVVZZWmk3ZkZCbGpOK1RSbFE0RXd1?=
 =?utf-8?B?MDJSaUUvQTBSN0g1UzZEZFB3WGNoRXVWM3pXNEhLMGx0Y2ZIK283RC9XcUJP?=
 =?utf-8?B?MWcrN0ZFdm03aExmN1FEYzEzL3FLNHgzci9oeGdmUTVSRlRPaVRQd0NnMW44?=
 =?utf-8?B?V0RHWHprWnRoaUhmc2oranB0Q3ZwdjJNemhEQTZqNllWTnF4a1d5TkJBT0g5?=
 =?utf-8?B?OXhPbG5MMVJUVlFMU3M1RUJod0s3dzB5a3NyOW1UMldnczc1RnJwbExQMnN2?=
 =?utf-8?B?Z0Z2WmhTOTNUQTNqS3RUMGhEMmJhaGZXRDRwVWR2M1dJNnFQUXY0eGNCc1d2?=
 =?utf-8?B?ZDRJbXdRU0EwWml3NHFMb0djRm5uVUwxZ3h6cXRIVWt2WXVWN2tmYW5jWll0?=
 =?utf-8?B?b085dUZXRkJpczFjMzZ2YU9oMDZmUUsvTEhaeFBJS0RIeW1TSTE5WHRhRXdX?=
 =?utf-8?B?VmxkZGJSTDFwSS82QnpUWFUrZTd1UkFybURBUWFrVHpJeTVKZ2t5VDQzaFUz?=
 =?utf-8?B?UXEweXl6bm0xTWpRTTFPY3o0WGl6VExtQlB1eDBxRkhNcmhpREQ3SHlPUFNr?=
 =?utf-8?B?VWU2OVlFUmNxbThIc1FBZmR4NHQzVEVpV3lIdzR2RVNrNkJZTVZoWjlDSmY5?=
 =?utf-8?B?WGc5ZkZXUXBTeHhnRW5DVHlxY1pKKzdlTGx3SUxJeTJ3UTBqWlpmN2J1UWV2?=
 =?utf-8?B?cmhub1Q4Q2kzdmFjMHNIbldRb09OQ2F2VVFkdTNwbkpJZ2JRYWhPcW55WEZm?=
 =?utf-8?B?dm44UWk0bWxjQzJWeVFLeXM3bElCMGZKOWlKTWJQNWd1a0ZkQ3lwQU1wU04x?=
 =?utf-8?B?QmUxbW1rYTZEbFFvaGJrbm1wTkxWc0VOWW5sUU53cEE1aDNBcm1KRTFWZWFO?=
 =?utf-8?B?bWVoOFJleTVJZHUwYWQ2QmtKL0NWUi9VU0Mzd3NPZ2lFSXJZeEZRZk15NWRs?=
 =?utf-8?B?WkI3cFduc3NLbnA0dW4zUEJmZmtwV3dUQVpsSTdTMHRCaG1qRWFRWWlWR1JQ?=
 =?utf-8?B?QjBTYnN6a1h3ZzFQTHpvTWIvNld1T1laRVBFNjVxeC9WaXdPRlRYVytsaFdB?=
 =?utf-8?B?WHJ5aEhFTGR6akVOejVEWEF4Vmd0Q3Q1Sk84eVZ3OWtRRnh2RGlGNkRXVkxu?=
 =?utf-8?B?V1VWcW9RTmVoVHUwM0ZyU2Q3UWtYVFB4ejBGRm1IME51WDFyeDdCQ1dJeVh3?=
 =?utf-8?B?TUx6Y2FJdHorY0k2djJOL1ZlMXVmSTY3WFVhM1ZqUFpCRzVLdGVZZz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bc6f926-1e89-46d2-3918-08de7402d53f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 00:14:25.1320 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QyuRfJuNeg3H4C/TQ/qXsSdbNthwEKcAaYW6k/h/oHiIvrhhjfCBtIcsW/WVbhEJXg5qF/chFNr4NAjgLN7yTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7342
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

Add support for printing pin names and current mux configuration on i.MX8MN
when CMD_PINMUX is enabled by adding full pin descriptor table for i.MX8MN
pads.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/pinctrl/nxp/pinctrl-imx8m.c  |   2 +
 drivers/pinctrl/nxp/pinctrl-imx8mn.c | 310 +++++++++++++++++++++++++++++++++++
 2 files changed, 312 insertions(+)

diff --git a/drivers/pinctrl/nxp/pinctrl-imx8m.c b/drivers/pinctrl/nxp/pinctrl-imx8m.c
index 2835fe3b176..eb11edf3948 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx8m.c
+++ b/drivers/pinctrl/nxp/pinctrl-imx8m.c
@@ -26,6 +26,8 @@ static const struct udevice_id imx8m_pinctrl_match[] = {
 
 #if IS_ENABLED(CONFIG_IMX8MP)
 #include "pinctrl-imx8mp.c"
+#elif IS_ENABLED(CONFIG_IMX8MN)
+#include "pinctrl-imx8mn.c"
 #endif
 
 static int imx8m_get_pins_count(struct udevice *dev)
diff --git a/drivers/pinctrl/nxp/pinctrl-imx8mn.c b/drivers/pinctrl/nxp/pinctrl-imx8mn.c
new file mode 100644
index 00000000000..a3e22cf72ee
--- /dev/null
+++ b/drivers/pinctrl/nxp/pinctrl-imx8mn.c
@@ -0,0 +1,310 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2026 NXP
+ */
+
+#include "pinctrl-imx.h"
+
+enum imx8mn_pads {
+	RESERVE0 = 0,
+	RESERVE1 = 1,
+	RESERVE2 = 2,
+	RESERVE3 = 3,
+	RESERVE4 = 4,
+	RESERVE5 = 5,
+	RESERVE6 = 6,
+	RESERVE7 = 7,
+	BOOT_MODE2 = 8,
+	BOOT_MODE3 = 9,
+	GPIO1_IO00 = 10,
+	GPIO1_IO01 = 11,
+	GPIO1_IO02 = 12,
+	GPIO1_IO03 = 13,
+	GPIO1_IO04 = 14,
+	GPIO1_IO05 = 15,
+	GPIO1_IO06 = 16,
+	GPIO1_IO07 = 17,
+	GPIO1_IO08 = 18,
+	GPIO1_IO09 = 19,
+	GPIO1_IO10 = 20,
+	GPIO1_IO11 = 21,
+	GPIO1_IO12 = 22,
+	GPIO1_IO13 = 23,
+	GPIO1_IO14 = 24,
+	GPIO1_IO15 = 25,
+	ENET_MDC = 26,
+	ENET_MDIO = 27,
+	ENET_TD3 = 28,
+	ENET_TD2 = 29,
+	ENET_TD1 = 30,
+	ENET_TD0 = 31,
+	ENET_TX_CTL = 32,
+	ENET_TXC = 33,
+	ENET_RX_CTL = 34,
+	ENET_RXC = 35,
+	ENET_RD0 = 36,
+	ENET_RD1 = 37,
+	ENET_RD2 = 38,
+	ENET_RD3 = 39,
+	SD1_CLK = 40,
+	SD1_CMD = 41,
+	SD1_DATA0 = 42,
+	SD1_DATA1 = 43,
+	SD1_DATA2 = 44,
+	SD1_DATA3 = 45,
+	SD1_DATA4 = 46,
+	SD1_DATA5 = 47,
+	SD1_DATA6 = 48,
+	SD1_DATA7 = 49,
+	SD1_RESET_B = 50,
+	SD1_STROBE = 51,
+	SD2_CD_B = 52,
+	SD2_CLK = 53,
+	SD2_CMD = 54,
+	SD2_DATA0 = 55,
+	SD2_DATA1 = 56,
+	SD2_DATA2 = 57,
+	SD2_DATA3 = 58,
+	SD2_RESET_B = 59,
+	SD2_WP = 60,
+	NAND_ALE = 61,
+	NAND_CE0 = 62,
+	NAND_CE1 = 63,
+	NAND_CE2 = 64,
+	NAND_CE3 = 65,
+	NAND_CLE = 66,
+	NAND_DATA00 = 67,
+	NAND_DATA01 = 68,
+	NAND_DATA02 = 69,
+	NAND_DATA03 = 70,
+	NAND_DATA04 = 71,
+	NAND_DATA05 = 72,
+	NAND_DATA06 = 73,
+	NAND_DATA07 = 74,
+	NAND_DQS = 75,
+	NAND_RE_B = 76,
+	NAND_READY_B = 77,
+	NAND_WE_B = 78,
+	NAND_WP_B = 79,
+	SAI5_RXFS = 80,
+	SAI5_RXC = 81,
+	SAI5_RXD0 = 82,
+	SAI5_RXD1 = 83,
+	SAI5_RXD2 = 84,
+	SAI5_RXD3 = 85,
+	SAI5_MCLK = 86,
+	SAI1_RXFS = 87,
+	SAI1_RXC = 88,
+	SAI1_RXD0 = 89,
+	SAI1_RXD1 = 90,
+	SAI1_RXD2 = 91,
+	SAI1_RXD3 = 92,
+	SAI1_RXD4 = 93,
+	SAI1_RXD5 = 94,
+	SAI1_RXD6 = 95,
+	SAI1_RXD7 = 96,
+	SAI1_TXFS = 97,
+	SAI1_TXC = 98,
+	SAI1_TXD0 = 99,
+	SAI1_TXD1 = 100,
+	SAI1_TXD2 = 101,
+	SAI1_TXD3 = 102,
+	SAI1_TXD4 = 103,
+	SAI1_TXD5 = 104,
+	SAI1_TXD6 = 105,
+	SAI1_TXD7 = 106,
+	SAI1_MCLK = 107,
+	SAI2_RXFS = 108,
+	SAI2_RXC = 109,
+	SAI2_RXD0 = 110,
+	SAI2_TXFS = 111,
+	SAI2_TXC = 112,
+	SAI2_TXD0 = 113,
+	SAI2_MCLK = 114,
+	SAI3_RXFS = 115,
+	SAI3_RXC = 116,
+	SAI3_RXD = 117,
+	SAI3_TXFS = 118,
+	SAI3_TXC = 119,
+	SAI3_TXD = 120,
+	SAI3_MCLK = 121,
+	SPDIF_TX = 122,
+	SPDIF_RX = 123,
+	SPDIF_EXT_CLK = 124,
+	ECSPI1_SCLK = 125,
+	ECSPI1_MOSI = 126,
+	ECSPI1_MISO = 127,
+	ECSPI1_SS0 = 128,
+	ECSPI2_SCLK = 129,
+	ECSPI2_MOSI = 130,
+	ECSPI2_MISO = 131,
+	ECSPI2_SS0 = 132,
+	I2C1_SCL = 133,
+	I2C1_SDA = 134,
+	I2C2_SCL = 135,
+	I2C2_SDA = 136,
+	I2C3_SCL = 137,
+	I2C3_SDA = 138,
+	I2C4_SCL = 139,
+	I2C4_SDA = 140,
+	UART1_RXD = 141,
+	UART1_TXD = 142,
+	UART2_RXD = 143,
+	UART2_TXD = 144,
+	UART3_RXD = 145,
+	UART3_TXD = 146,
+	UART4_RXD = 147,
+	UART4_TXD = 148,
+};
+
+static const struct imx_pinctrl_pin_desc imx8m_pinctrl_pads[] = {
+	IMX_PINCTRL_PIN(RESERVE0),
+	IMX_PINCTRL_PIN(RESERVE1),
+	IMX_PINCTRL_PIN(RESERVE2),
+	IMX_PINCTRL_PIN(RESERVE3),
+	IMX_PINCTRL_PIN(RESERVE4),
+	IMX_PINCTRL_PIN(RESERVE5),
+	IMX_PINCTRL_PIN(RESERVE6),
+	IMX_PINCTRL_PIN(RESERVE7),
+	IMX_PINCTRL_PIN(BOOT_MODE2),
+	IMX_PINCTRL_PIN(BOOT_MODE3),
+	IMX_PINCTRL_PIN(GPIO1_IO00),
+	IMX_PINCTRL_PIN(GPIO1_IO01),
+	IMX_PINCTRL_PIN(GPIO1_IO02),
+	IMX_PINCTRL_PIN(GPIO1_IO03),
+	IMX_PINCTRL_PIN(GPIO1_IO04),
+	IMX_PINCTRL_PIN(GPIO1_IO05),
+	IMX_PINCTRL_PIN(GPIO1_IO06),
+	IMX_PINCTRL_PIN(GPIO1_IO07),
+	IMX_PINCTRL_PIN(GPIO1_IO08),
+	IMX_PINCTRL_PIN(GPIO1_IO09),
+	IMX_PINCTRL_PIN(GPIO1_IO10),
+	IMX_PINCTRL_PIN(GPIO1_IO11),
+	IMX_PINCTRL_PIN(GPIO1_IO12),
+	IMX_PINCTRL_PIN(GPIO1_IO13),
+	IMX_PINCTRL_PIN(GPIO1_IO14),
+	IMX_PINCTRL_PIN(GPIO1_IO15),
+	IMX_PINCTRL_PIN(ENET_MDC),
+	IMX_PINCTRL_PIN(ENET_MDIO),
+	IMX_PINCTRL_PIN(ENET_TD3),
+	IMX_PINCTRL_PIN(ENET_TD2),
+	IMX_PINCTRL_PIN(ENET_TD1),
+	IMX_PINCTRL_PIN(ENET_TD0),
+	IMX_PINCTRL_PIN(ENET_TX_CTL),
+	IMX_PINCTRL_PIN(ENET_TXC),
+	IMX_PINCTRL_PIN(ENET_RX_CTL),
+	IMX_PINCTRL_PIN(ENET_RXC),
+	IMX_PINCTRL_PIN(ENET_RD0),
+	IMX_PINCTRL_PIN(ENET_RD1),
+	IMX_PINCTRL_PIN(ENET_RD2),
+	IMX_PINCTRL_PIN(ENET_RD3),
+	IMX_PINCTRL_PIN(SD1_CLK),
+	IMX_PINCTRL_PIN(SD1_CMD),
+	IMX_PINCTRL_PIN(SD1_DATA0),
+	IMX_PINCTRL_PIN(SD1_DATA1),
+	IMX_PINCTRL_PIN(SD1_DATA2),
+	IMX_PINCTRL_PIN(SD1_DATA3),
+	IMX_PINCTRL_PIN(SD1_DATA4),
+	IMX_PINCTRL_PIN(SD1_DATA5),
+	IMX_PINCTRL_PIN(SD1_DATA6),
+	IMX_PINCTRL_PIN(SD1_DATA7),
+	IMX_PINCTRL_PIN(SD1_RESET_B),
+	IMX_PINCTRL_PIN(SD1_STROBE),
+	IMX_PINCTRL_PIN(SD2_CD_B),
+	IMX_PINCTRL_PIN(SD2_CLK),
+	IMX_PINCTRL_PIN(SD2_CMD),
+	IMX_PINCTRL_PIN(SD2_DATA0),
+	IMX_PINCTRL_PIN(SD2_DATA1),
+	IMX_PINCTRL_PIN(SD2_DATA2),
+	IMX_PINCTRL_PIN(SD2_DATA3),
+	IMX_PINCTRL_PIN(SD2_RESET_B),
+	IMX_PINCTRL_PIN(SD2_WP),
+	IMX_PINCTRL_PIN(NAND_ALE),
+	IMX_PINCTRL_PIN(NAND_CE0),
+	IMX_PINCTRL_PIN(NAND_CE1),
+	IMX_PINCTRL_PIN(NAND_CE2),
+	IMX_PINCTRL_PIN(NAND_CE3),
+	IMX_PINCTRL_PIN(NAND_CLE),
+	IMX_PINCTRL_PIN(NAND_DATA00),
+	IMX_PINCTRL_PIN(NAND_DATA01),
+	IMX_PINCTRL_PIN(NAND_DATA02),
+	IMX_PINCTRL_PIN(NAND_DATA03),
+	IMX_PINCTRL_PIN(NAND_DATA04),
+	IMX_PINCTRL_PIN(NAND_DATA05),
+	IMX_PINCTRL_PIN(NAND_DATA06),
+	IMX_PINCTRL_PIN(NAND_DATA07),
+	IMX_PINCTRL_PIN(NAND_DQS),
+	IMX_PINCTRL_PIN(NAND_RE_B),
+	IMX_PINCTRL_PIN(NAND_READY_B),
+	IMX_PINCTRL_PIN(NAND_WE_B),
+	IMX_PINCTRL_PIN(NAND_WP_B),
+	IMX_PINCTRL_PIN(SAI5_RXFS),
+	IMX_PINCTRL_PIN(SAI5_RXC),
+	IMX_PINCTRL_PIN(SAI5_RXD0),
+	IMX_PINCTRL_PIN(SAI5_RXD1),
+	IMX_PINCTRL_PIN(SAI5_RXD2),
+	IMX_PINCTRL_PIN(SAI5_RXD3),
+	IMX_PINCTRL_PIN(SAI5_MCLK),
+	IMX_PINCTRL_PIN(SAI1_RXFS),
+	IMX_PINCTRL_PIN(SAI1_RXC),
+	IMX_PINCTRL_PIN(SAI1_RXD0),
+	IMX_PINCTRL_PIN(SAI1_RXD1),
+	IMX_PINCTRL_PIN(SAI1_RXD2),
+	IMX_PINCTRL_PIN(SAI1_RXD3),
+	IMX_PINCTRL_PIN(SAI1_RXD4),
+	IMX_PINCTRL_PIN(SAI1_RXD5),
+	IMX_PINCTRL_PIN(SAI1_RXD6),
+	IMX_PINCTRL_PIN(SAI1_RXD7),
+	IMX_PINCTRL_PIN(SAI1_TXFS),
+	IMX_PINCTRL_PIN(SAI1_TXC),
+	IMX_PINCTRL_PIN(SAI1_TXD0),
+	IMX_PINCTRL_PIN(SAI1_TXD1),
+	IMX_PINCTRL_PIN(SAI1_TXD2),
+	IMX_PINCTRL_PIN(SAI1_TXD3),
+	IMX_PINCTRL_PIN(SAI1_TXD4),
+	IMX_PINCTRL_PIN(SAI1_TXD5),
+	IMX_PINCTRL_PIN(SAI1_TXD6),
+	IMX_PINCTRL_PIN(SAI1_TXD7),
+	IMX_PINCTRL_PIN(SAI1_MCLK),
+	IMX_PINCTRL_PIN(SAI2_RXFS),
+	IMX_PINCTRL_PIN(SAI2_RXC),
+	IMX_PINCTRL_PIN(SAI2_RXD0),
+	IMX_PINCTRL_PIN(SAI2_TXFS),
+	IMX_PINCTRL_PIN(SAI2_TXC),
+	IMX_PINCTRL_PIN(SAI2_TXD0),
+	IMX_PINCTRL_PIN(SAI2_MCLK),
+	IMX_PINCTRL_PIN(SAI3_RXFS),
+	IMX_PINCTRL_PIN(SAI3_RXC),
+	IMX_PINCTRL_PIN(SAI3_RXD),
+	IMX_PINCTRL_PIN(SAI3_TXFS),
+	IMX_PINCTRL_PIN(SAI3_TXC),
+	IMX_PINCTRL_PIN(SAI3_TXD),
+	IMX_PINCTRL_PIN(SAI3_MCLK),
+	IMX_PINCTRL_PIN(SPDIF_TX),
+	IMX_PINCTRL_PIN(SPDIF_RX),
+	IMX_PINCTRL_PIN(SPDIF_EXT_CLK),
+	IMX_PINCTRL_PIN(ECSPI1_SCLK),
+	IMX_PINCTRL_PIN(ECSPI1_MOSI),
+	IMX_PINCTRL_PIN(ECSPI1_MISO),
+	IMX_PINCTRL_PIN(ECSPI1_SS0),
+	IMX_PINCTRL_PIN(ECSPI2_SCLK),
+	IMX_PINCTRL_PIN(ECSPI2_MOSI),
+	IMX_PINCTRL_PIN(ECSPI2_MISO),
+	IMX_PINCTRL_PIN(ECSPI2_SS0),
+	IMX_PINCTRL_PIN(I2C1_SCL),
+	IMX_PINCTRL_PIN(I2C1_SDA),
+	IMX_PINCTRL_PIN(I2C2_SCL),
+	IMX_PINCTRL_PIN(I2C2_SDA),
+	IMX_PINCTRL_PIN(I2C3_SCL),
+	IMX_PINCTRL_PIN(I2C3_SDA),
+	IMX_PINCTRL_PIN(I2C4_SCL),
+	IMX_PINCTRL_PIN(I2C4_SDA),
+	IMX_PINCTRL_PIN(UART1_RXD),
+	IMX_PINCTRL_PIN(UART1_TXD),
+	IMX_PINCTRL_PIN(UART2_RXD),
+	IMX_PINCTRL_PIN(UART2_TXD),
+	IMX_PINCTRL_PIN(UART3_RXD),
+	IMX_PINCTRL_PIN(UART3_TXD),
+	IMX_PINCTRL_PIN(UART4_RXD),
+	IMX_PINCTRL_PIN(UART4_TXD),
+};

-- 
2.51.0

