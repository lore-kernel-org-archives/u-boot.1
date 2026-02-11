Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3EFAE9E30B
	for <u-boot@archiver.kernel.org>; Wed, 11 Feb 2026 13:54:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40C6383DE0;
	Wed, 11 Feb 2026 14:53:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="vdchqYRw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7624783D6C; Wed, 11 Feb 2026 08:54:02 +0100 (CET)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 986008367F
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 08:53:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r4Rmtzl+o56lMirSbeVR97yEDIzKsSdUequ3Pe5NVAo5OT0I5dokvEFD/kv2CMbxTHWoC3j9V9Xi39DrtEhidHQcXcIph8fakpcnV78vqqdxoDTvlbGmmb2zxow68YkHZPMo23WkznbXUUFLHwYw9DDfNKtC4t9r5gjtKb3coKjswL4ez359CgweIL8skFB8ZoTvM56T9qj9LDMCW9FIyzLCIaZJSKN9G4PJHSjJX7NeBt99nLAh8q2LCBidsyN0Tx9vKS7TFHWI3kNG821Kac7QQP7YDqRnxhOd9uBMGyeXOTU1IHgy9ciVbiUotCps5nH6NIPuDUZHHs5Jp0lnTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ET1NGTD20Zz4lZuQa4QeepjdDjfh7c5zAOz+TToTPFU=;
 b=NS3OFuxRsHO3V8xnM7ilN3ec1a2o7c0TPU4oCYxr+u4h7rE3lVMwpRDz8cySD82eipZ+0lRe0jnY2FYfnMgG0FnRhHCelXmiqTJcBrX98dTrk4rQMB1jcfdclLisC2hyWv7jc+Bg89vVQ/E2ktpKP7vszuPXMsFqa0xTLhsiatx4MDYPq5SxQ9q0p1RB6owHcqXug8WeoNEI5WpE6KlReVvwQ1wUZ98ajs8E/I5q6NBlMQw8g5GkO9gNxNq+MkG7bJix1b4VgghR10PpIdXTjMxR3q6nbbCxMWO0IkYUQFjpQvCwNgT9VMfzefSYO9T2sbuhhVGUUG5zMpVx+DGtJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ET1NGTD20Zz4lZuQa4QeepjdDjfh7c5zAOz+TToTPFU=;
 b=vdchqYRwpBM2cNo/fPAQCDg0xFkSmNkPE5SSqet598Y26V5mPgaT7lAjDjOm24Bks5edUUFPqV3NGKn9z8FxyD9oasAGxGVovDHfVORVwLhTr0hIqeRrw11uQNEOIABhvD9SHo3yyhmkvZ4RjZ9GDVG236oVP37nxLXPYsDqNFAy/BxXcd8zvNXR1rs98hKjiCZKj6yZQBjrp8D+3C38LkubsLt6KkbZMWwfWIK9jH12Ay9WJvnz1K8l7k2JQpRDl7eiLZOB9uWZin5QbpBa/zfoIAaEYbdfPr/dXZuj0yadNLK9083gq5GVInjdRpg8kTSEZSIWF78tZG6BaLu0bg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by PH7PR03MB7437.namprd03.prod.outlook.com (2603:10b6:510:2e8::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 11 Feb
 2026 07:53:55 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a%3]) with mapi id 15.20.9611.008; Wed, 11 Feb 2026
 07:53:55 +0000
Message-ID: <904d6def-bce1-4ff7-a50d-c4aacd9602c1@altera.com>
Date: Wed, 11 Feb 2026 15:53:47 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] mtd: nand: introduce SPL_NAND_FRAMEWORK_CAPABLE
 Kconfig option
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>, Jan Kiszka <jan.kiszka@siemens.com>,
 Tien Fong <tien.fong.chee@altera.com>, Kok Kiang <kok.kiang.hea@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>, Alif <alif.zakuan.yuslaimi@altera.com>
References: <20260203074721.25520-1-dinesh.maniyam@altera.com>
 <20260203074721.25520-2-dinesh.maniyam@altera.com>
 <20260203145742.GH2603314@bill-the-cat>
 <074a310c-5ba3-4304-ab37-2c85d8cd58da@altera.com>
 <CAOf5uwkE_hfjLkxbOn-O2o3sYSGqAV0TVdZ7yg6eZqJgWGjDCg@mail.gmail.com>
Content-Language: en-US
From: "Maniyam, Dinesh" <dinesh.maniyam@altera.com>
In-Reply-To: <CAOf5uwkE_hfjLkxbOn-O2o3sYSGqAV0TVdZ7yg6eZqJgWGjDCg@mail.gmail.com>
X-ClientProxiedBy: SG3P274CA0023.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::35)
 To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|PH7PR03MB7437:EE_
X-MS-Office365-Filtering-Correlation-Id: 27707ec2-509e-4dcc-1477-08de6942b491
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|13003099007|8096899003; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?akpmMFJwK3AveklYSVMrRk53TVhuZ21wbUF2dlNodUpMSXVRWEN3OGxCc2hh?=
 =?utf-8?B?TG1laVJJYW5KTDFvRDZBSDFDc2l2bHUvQWxrUjZkOHdBdjUvMHVNeTNIT29D?=
 =?utf-8?B?bm5YMS9nTVZLRWVPWkNpa3N5R3dJL2o1YTByVGdyd3FDclMxZ3VhcGMyaW1x?=
 =?utf-8?B?NzdOK1U0RUEzWEZQQjFwS2Q2NkdJdXRJYjBPeUdzRjhoNFlkczc5dmM3d2VL?=
 =?utf-8?B?NWFkaUpNQkgrV3ZxMk1pR1EwYk5RSzRUc2JPRFM4YThyTm02anlLaHBKVTRJ?=
 =?utf-8?B?OXk2em16ankxcGt6ekpiZXRYMDYyTUJ4LytFZHdpNGVXMTdPQTBIMUtFeGk0?=
 =?utf-8?B?NElBQjYzRkFzWjRFMmhDZzZudFVveVpuOU93T1BOWml4ckhPMHJTcVNUQ0Vr?=
 =?utf-8?B?WHhwanZFRk55Q00yMml1SEs3UDFEQ2FlQm45bHRjQ1dBR0R3SjFYMlVBeUFk?=
 =?utf-8?B?YnhheXFNcnY3L1hvMXEzRWtOb1QrYmU0eGVOUjRnRWVCYnhGdUZzODU4ZnZF?=
 =?utf-8?B?VU5vUWg2UTkrQXFXWlJvRndrMFkxTDltcXcvdFlwaDZGNHRsYmFzaURoRlpo?=
 =?utf-8?B?dTF3dUlPRGtjRnNidHd2YWorcjJoWk4xYmtUSEdibHp4Vyt1T015VVI2cnR6?=
 =?utf-8?B?b2hvVEw3VCsvODJWelRtUjdoVmFpRk0wSDRJeVBXdldKajhNcHdRQWNXbXN6?=
 =?utf-8?B?WmR0dUtQdXdYTGJ5RmJabFB0bTNjU1ZhcGJ3ZUp5WEhTYXVacGpZNVVmUVcw?=
 =?utf-8?B?T1hJK1lxSlgxVDl3U2hiSm9rTWZObk5waWduYUE2UTF1YWwwMFJER0Y4eGNX?=
 =?utf-8?B?ak1zbUliVFRLajRpUUhWbVMvRDlrVDk5NEY1TjBLdmx0bUVsaFl0M3QrTldL?=
 =?utf-8?B?SXgxMjFXcmZIQlBkS3FFRWtGRldTZGdyNVJ1MVBTbjl0OGZrc01ZZVo5dnVT?=
 =?utf-8?B?NGJBVE02V0JRM0FSWHJhd3NFaC9pdHJ4a01JY01JSXFxZ2FvTG5XZStJVS9J?=
 =?utf-8?B?R0VnVldKVVZrMlp0OEJTUmcvemZiT2ROeVEzbWRLNnlVRFhpM0crSXg1OGow?=
 =?utf-8?B?OTZZNklia3g3bEpSQ0lsWG9YaE1qS0NPcEtwN3NrbkxPMExROWRhdXpaVlZU?=
 =?utf-8?B?RG10K2RsbTV3U2xaSzFRMkNlZGk5MDFIV0RaQi9nU21CakkrenJzZE9KTHQ1?=
 =?utf-8?B?VzVLcXlaa1N5RUdMQVdubUlUOGlMZ3Y3eW02c2VNSGZPOVpuYTA4cnRKQUNJ?=
 =?utf-8?B?RW0xWlNyNGg4Zk1zMnJtbVNmT0o2QU1OVFNPc3IwdjhmT25maDJZZTRqQkc5?=
 =?utf-8?B?c09DZ1ZtakJ4Q1RBNk8zajR1ekZ4bGhLWWYweG40cmk5ZEY0N2NtRXI3UGFY?=
 =?utf-8?B?YWFQQkJITHhZbWpqTGZxaWpXM0N4TGZMZ3p2SERwakp1UlVOV3VIYnlscVJW?=
 =?utf-8?B?eml5d09XNGs1enUzOS90RzUrcUEycGwzcWRQaW5lb1RjbFpkQVJCZnc2YjA3?=
 =?utf-8?B?VE1jQnFORXQ3eFpna1VSR1hDbmlPZGRPdzExK2hsRFlEMjlLbHViWDJPMnJF?=
 =?utf-8?B?b1ZwK0lqOEhEQXp1YzJudGY1dEk4ZmZhOERCYXp3UmF6eGRUbm1xUVdORnI2?=
 =?utf-8?B?QTF0RWo4c3Q0MjZSMnVzTncxam5JTWhHMzZLb0dZVEpxYno3cEJuYnBqYm9p?=
 =?utf-8?B?YlFLbURqT3NycFM1NjJRdzQ4MmJ4TytSQ2ZUd09TK1dVZUticE41TTJVNW1B?=
 =?utf-8?B?Ym4vRldFeXJ3T3B6aXRqbG5BeER0aURvbTc3c2k2TFpKQnZvVWw4T3Z5N3lO?=
 =?utf-8?B?Wk9OWU4wVzVXdnhqaUVFYnc5UW1DUkNMVnFhY2E3TUh6bUV5M21wYzBVZWRn?=
 =?utf-8?B?M0JPdjB0ZSszZUJMSzBidmlrSzdaMElBTXNPMXAzN2UwNlA4U0lEVFZnb0g4?=
 =?utf-8?B?TWhVRjR3dEtUZEhCRk51Z2F3ZWRMdmsyb2tnencycmI3SHE5aERvMWJ4a1B1?=
 =?utf-8?B?RVJNU1I5NWdsVllyVnpTd0RtakkyRGp5eGJMSXVwM3pQTDFCb2JidTQrNUpM?=
 =?utf-8?Q?m8CIkf?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(13003099007)(8096899003); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckt3aXVuSTdsRFlEY3hFekpBWG1DMzB2TnFoMUlRZlFTOFc0U2c3SWRDVnBJ?=
 =?utf-8?B?d0RUcmJ5eWt2eXhleEJuczg4MEphem1acEJrVHVqcHRNUS9yTkJQTFhNV3Z0?=
 =?utf-8?B?dFYrczFzNG1NWjR3QjN4OVp3MVZ1MlBQZFJDSTdlVkIveHczQys2NkFuMUJM?=
 =?utf-8?B?MnkxN0dFTUJ6djNRQnBvMDM2anc0aUcrbUhqVmhaZndRby9jNkhIc004VTI1?=
 =?utf-8?B?MkhGa1dyTnIrUHV3YklmNEl5aEhwRkhyMVk2RkN5aGVrT0pUSlg4UURXTlFo?=
 =?utf-8?B?OXFqSDUyMm4yTCtoQ2ZvMzBOalBvQjhvWWZpb1M4V2Jjd1pCSXoxT0JVZk1M?=
 =?utf-8?B?emRuSUtjL1RkK2ZKYkNvZHBnZ0VKRGY1Zmx6Rk9SbTRVN3BFQWZLdnBDZlht?=
 =?utf-8?B?SmNDMk96S0lZckJQcHZPVFE4K1Y3MmNxRjU3NkoyS0tWWHZqNVZvYitHWUJC?=
 =?utf-8?B?TzRxZ1krQWNPTEtEOG9tSGdSSXU2TVBjcW0yb0Iza1NOWU9uS2M0ODZ0cXR2?=
 =?utf-8?B?OWVMSGVneE5la0t2d1VacUhnVXlvbW50YUdzS1pvc05Xb0syQktCNnNPTm5w?=
 =?utf-8?B?UjRUeURlaVgrMlJvQ1pZbmVObmMrRWFrY2F5UjFGRkFKY2w4Z0cybmc0S1dm?=
 =?utf-8?B?eWorRVJFL3lDaDRGSGx3V3ZGRm91Q01MSkdTckFIY1VzaXhNMnhqaTR2NUdI?=
 =?utf-8?B?UkxTZmRUUFY1RUY3cVRlS041c0ZlQUJENE9EWWIrN3l3ZHUvdWJMUlhoSExW?=
 =?utf-8?B?Qnc4MWtIREZaU0FJVC80Y3UvTkpQaSsvdW1zTE1TOWhsQmlpNlc2ZmdoeEg3?=
 =?utf-8?B?Q2FXdnB6bDZXY2wrM0x3TEJQVjQzYWx0cEhnMFdSclkxVkFLdURaVm0vRmRq?=
 =?utf-8?B?eWxjR0J1N09zakdJMnVlS2Y0c2dneEp0d1NZQjZwWFIvWWZ4c2NNZWFZdXBT?=
 =?utf-8?B?SVdhUzIxQVFSWENYdUQybm5sMkxoakdmcmdjdE1TQ05ocUxNUVBwczl1U2Rp?=
 =?utf-8?B?bDczRVlXZFJsRC85L3lqL0dtbUtlVmZROHlrNjZCdkloZXJLNnJ5OHhMQ2dl?=
 =?utf-8?B?dVExdm4rQ0Y0VUdQWGE3c1ZHb3BNSTJSVlpnVzVIaTg1WlplTGhXNjl1SDV6?=
 =?utf-8?B?bmViQUFWSXpERmpobU03SmVKRjlLSmkva3NiK05vaDUwU1Bwc3BUSjF5dlZ1?=
 =?utf-8?B?V0FDNTNKSFdpdlFVMFpNQnJRYkpaZmsrbE9Tb1JqU2pKTUZBMmgvSEJVOXB3?=
 =?utf-8?B?eEJiYUlobmdVKzF4dC9qVUlXbWRBYWN4V2tlT01ZS3BFK3lTcFdBWFZaZVdy?=
 =?utf-8?B?TVlxM3pHVzZ0b1JwL3owZUNUUk9rM2MrNDFKc1FsZi9VZzBHYkFkREZxZFBn?=
 =?utf-8?B?UHg0M0h2WWZRRDZ2RU5BQjk1NXg1TC90OWZTajVKWHowSURpaW15NkY5clIv?=
 =?utf-8?B?REQxY1BjSHVlMWkvd1Y5T1pkWjFhYVdiSFVqTGkxWnBNMGU2dGh6YUNhc1Bs?=
 =?utf-8?B?anRLYndBSGQ3emVzdWFUVXFVaEozWTQ0OUpodUk2TTF5T2xrZEkyZWh4Ymd2?=
 =?utf-8?B?bU9sbEUwQk8vckZVWTllTUtQeUxBNUpFYnhCT0pieEhVWkFYYmhMZm5pQ0g3?=
 =?utf-8?B?djExTlhTM0c1WE5CUlc4SWE0T1MyTC9Xbll6d3ZXcldWZGl0NWtXdDdEQWJh?=
 =?utf-8?B?U0gzV2VDbTF5ajBWRFNUbWwydEpxVStXbVpuMDM4T2dRM2tWam10R1RQc1RV?=
 =?utf-8?B?VkZSeklyK1psakNudXZIeDF1aytwcHlabktHVWpxSkJqMVhpeUlpSE9xUGR4?=
 =?utf-8?B?bnNtMjRxbno2SzJnYm5RSWdMUVlPT3ZIeXpDU0RueU96b2Y3TkRiZ2J2VFZ3?=
 =?utf-8?B?YUwxY2VjN1FPYjMzc1NxS296UlNVS2JjVzhzSVBwRFYyTlZCeGQ2VldsUllE?=
 =?utf-8?B?a2VuK0NmenZtU0FKWnI3ZzFneEZLakN6THcxdWtBQmZ2NTkyczlFTDFDRE9n?=
 =?utf-8?B?SmgzQWhTSTNHeTh4NkxtYlY3aFpQOXI4OHVuYTZSekdFWUZ6YUZDU3hobU1O?=
 =?utf-8?B?SVJBTms0OWU4Y0hQRnpBNFlNaEU1dUdPSy9YeURSRGhMaGNlYkZIYTZwTlVy?=
 =?utf-8?B?dmlIMFBGaU1ReEc3aEY0Y0Q5MEowY3cyV1VCUk1DVFlUd1JLcW9kbGJkSlUx?=
 =?utf-8?B?c2thVEpsVm8rZHR5M2FGZEE0ZjFKLytmMURidmJ6eTJCdkptaE91cWo0VURP?=
 =?utf-8?B?OGNKSVJ0WWFJOXFMaEsyVUpkdlFXQk5hQ0RRa0RNcFloUDBOaXFoZFhEMFh4?=
 =?utf-8?B?QW9odGdwVVkwRVR1OHRrVUNMTTYwS3YxT3NUNDRLY1IvZmNJTHFJU0VJTnRH?=
 =?utf-8?Q?V4evDQBP0If+LEa8=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27707ec2-509e-4dcc-1477-08de6942b491
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 07:53:55.2724 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vQk7/0hyDKDqpAKYgTD4vTNgbOQMZXBOeB5obI4XwreoSlkyNNUBFwCkUaZeAnhaG2fX/+TwvLKuDnwG3UC5/jJ2vYPwWyrW0a+DRLuYgVQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR03MB7437
X-Mailman-Approved-At: Wed, 11 Feb 2026 14:53:33 +0100
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Michael,

On 11/2/2026 3:20 pm, Michael Nazzareno Trimarchi wrote:
> [CAUTION: This email is from outside your organization. Unless you trust the sender, do not click on links or open attachments as it may be a fraudulent email attempting to steal your information and/or compromise your computer.]
>
> Hi
>
> On Wed, Feb 11, 2026 at 8:14 AM Maniyam, Dinesh
> <dinesh.maniyam@altera.com> wrote:
>> Hi Tom,
>>
>> On 3/2/2026 10:57 pm, Tom Rini wrote:
>>
>> On Tue, Feb 03, 2026 at 03:47:17PM +0800,dinesh.maniyam@altera.com wrote:
>>
>> From: Dinesh Maniyam<dinesh.maniyam@altera.com>
>>
>> The SPL NAND MTD framework requires working driver model support
>> and sufficient memory resources, which are not available on all
>> platforms.
>>
>> Introduce a SPL_NAND_FRAMEWORK_CAPABLE Kconfig option to allow
>> platforms to explicitly advertise support for compiling the full
>> NAND/MTD framework into SPL.
>>
>> This avoids accidental enablement of the SPL NAND framework on
>> platforms that cannot support it and provides a clear capability
>> boundary for platform maintainers.
>>
> This what I have asked in the beginning, for now I don't like to have
> this change
> in the framework unless we have more consumer. For the patch that you sent for
> make simple spl load, I will try to start to apply on one of my board
>
> Michael
>
> Just to clarify, when you mentioned “simple SPL load”, were you referring
> to the generic MTD-based SPL NAND loader I introduced?
>
> If you meant the generic MTD-based loader, I’m preparing a newer RFC
> version that clarifies the scope and usage. It may be easier to test
> against that version, if you don’t mind waiting for it.
>
> Dinesh
>> Signed-off-by: Dinesh Maniyam<dinesh.maniyam@altera.com>
>> ---
>>   drivers/mtd/nand/raw/Kconfig | 30 ++++++++++++++++++++++++++++++
>>   1 file changed, 30 insertions(+)
>>
>> diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
>> index e0ff28cb21b..d73d8ed4404 100644
>> --- a/drivers/mtd/nand/raw/Kconfig
>> +++ b/drivers/mtd/nand/raw/Kconfig
>> @@ -809,6 +809,36 @@ config SYS_NAND_HW_ECC_OOBFIRST
>>    bool "In SPL, read the OOB first and then the data from NAND"
>>    depends on SPL_NAND_SIMPLE
>>
>> +config SPL_NAND_FRAMEWORK_CAPABLE
>> + bool
>> + depends on SPL_DM
>> + depends on SPL_HAS_BSS_LINKER_SECTION
>> + depends on SPL_MAX_SIZE >= 0x40000
>> + help
>> +  Indicates that the platform has sufficient SPL capabilities
>> +  (driver model, BSS support, and SRAM size) to support the
>> +  full NAND/MTD framework in SPL.
>> +
>> +config SPL_NAND_USE_NAND_FRAMEWORK
>> + bool "Use NAND/MTD framework in SPL"
>> + depends on SPL_NAND_SUPPORT && MTD
>> + depends on SPL_NAND_FRAMEWORK_CAPABLE
>> + depends on SPL_ENV_SUPPORT
>> + depends on ENV_IS_IN_NAND
>> + select SPL_SYS_NAND_SELF_INIT
>> + select SPL_NAND_BASE
>> + select SPL_NAND_DRIVERS
>> + select SPL_NAND_IDENT
>> + select SPL_NAND_INIT
>> + select SPL_NAND_ECC
>> + help
>> + Enable loading U-Boot from NAND in SPL using the full
>> + NAND/MTD framework instead of the minimal SPL NAND loaders.
>> + This provides bad-block aware reads and flexible offset
>> + handling via the common NAND/MTD infrastructure.
>> + Platforms enabling this option must also provide working
>> + driver model support and sufficient SPL memory resources.
>> +
>>   endif # if SPL
>>
>>   endif # if MTD_RAW_NAND
>>
>> This still gets it backwards. Whatever depends on SPL_DM needs to add
>> it. The max size is something that needs to be set for your platforms.
>> The BSS requirement is not correct (there are platforms today without
>> that set).
>>
>> Thanks for the input.
>>
>> Understood — the capability-style symbol is not the right approach
>> here. I’ll drop SPL_NAND_FRAMEWORK_CAPABLE and instead move the
>> required dependencies directly onto SPL_NAND_USE_NAND_FRAMEWORK.
>>
>> I’ll also remove the SPL_MAX_SIZE and BSS assumptions from the
>> generic Kconfig and ensure the appropriate limits and options are set
>> in the affected platform configurations instead.
>>
>> I’ll rework the patch accordingly.
>>
>> Dinesh
>
>
> --
> Michael Nazzareno Trimarchi
> Co-Founder & Chief Executive Officer
> M. +39 347 913 2170
> michael@amarulasolutions.com
> __________________________________
>
> Amarula Solutions BV
> Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
> T. +31 (0)85 111 9172
> info@amarulasolutions.com
> www.amarulasolutions.com
