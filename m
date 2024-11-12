Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F053FD42B88
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 14:24:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 826D888D5C;
	Tue, 12 Nov 2024 15:24:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mt.com header.i=@mt.com header.b="ohWxSLl6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7650688EDD; Tue, 12 Nov 2024 15:24:02 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98DA88855C
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 15:24:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Manuel.Traut@mt.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nIya0ybQSnjpf5t/ugUJFx1jc34mk13TjhWYbXLLd6eHubTLH7NbdmPFtJi996bN0VUpedipYXILauKbTPgB9M04VawY0aCj2LvaVrrgLjaHi40Um1UW79wK2ZKF6oeg4vUhYamolqHv0jrDoCsxLJRpoDGpMU2DBtaPlsjB1a3+XTTDp8R52FqtdtUv6CI/+hmrM8QYnA9Zqf9Z63kDeNCBONkeSjc61xCzTffQzU8yktfyfyq0VHZnwqM6Z4DxUNebea8MMYet+yD8UVs41nIPGP9m0TsjVLWXXL4tw1PM1f13IXu5wN8RXWLkwcEG8LTgRjq+6UDBpCBqzDGqDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dyxu7pK/ibccollNFarWcEbl9LRX/v7CsR59xJ8aRKA=;
 b=qeJsAhhcaGrziD62PowB4qkw2ynRyhehjtM57nzGyzT96ycnXsCZQzgYHYPKqNemhNs/l2X/mVvm/nr7cGFQ59DC95M4WFlGPi1k+Hl+0waenZqyHrCBRbQNOwGM6fEqvlmJzh05x88kgBdzcXuEv+P25Bo5Yj1gEiB6nAirIxQLp3f2O3x0ho+FA5sEtCLrIcOF23bx7yDMEvmjhxPPf7DoR5hGGqvbCY5VuhCbHBXRd9avnFpb4SQZ8DS1jLxDnN40EQ39UbNg1H7Ebk8GAtwkZH+oXycs0P0G7hF6Y5kBPHGGszEgb7NJb6GVWqGlNS1ODN6hVcLbofKdxeSYnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dyxu7pK/ibccollNFarWcEbl9LRX/v7CsR59xJ8aRKA=;
 b=ohWxSLl69Lnym/21JL0tJDEqqjgNT2n8G1RS5u0TzD9Tdmtdn0KOXnC1qTHFrZLSa1i2WfnXaGwnwajrCtdSqeuNI3gNliHUm9iOQ2JjlZ2rvjMZM/ucqaEggWjh+7HxVh5fdYiLLI/bugO5qTeW67D9b9esIguksxlN9m5IC/dR+igAKlsBWflZrd4/k+phb8hDhfD5Fc/6+COq8LI625WYGafFUrWbwODZQqfuR/w1mW65UFEandTLscZrDTkBFFKqFu/wkS28BItw1KzK5d7rK6Ftqps7WlrI2V2cch8fFSIScj3N1QFOfa7JHS1zqFvXiNuDdSTfdNUJVj6ZvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from PA4PR03MB6784.eurprd03.prod.outlook.com (2603:10a6:102:f0::8)
 by AS8PR03MB8395.eurprd03.prod.outlook.com (2603:10a6:20b:527::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.27; Tue, 12 Nov
 2024 14:23:59 +0000
Received: from PA4PR03MB6784.eurprd03.prod.outlook.com
 ([fe80::c014:9ad7:3215:fd7b]) by PA4PR03MB6784.eurprd03.prod.outlook.com
 ([fe80::c014:9ad7:3215:fd7b%3]) with mapi id 15.20.8158.013; Tue, 12 Nov 2024
 14:23:59 +0000
Date: Tue, 12 Nov 2024 15:23:57 +0100
From: Traut Manuel LCPF-CH <Manuel.Traut@mt.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Venzin Daniel LCPF-CH <Daniel.Venzin@mt.com>,
 Gujan Armin LCPF-CH <Armin.Gujan@mt.com>,
 Manuel Traut <manut@mecka.net>, Burak Gerz <burak@gerz.io>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: EFI File renaming
Message-ID: <ZzNk_WHxWdDscSWw@mt.com>
References: <PA4PR03MB67848E8118A8AF7AC8AF3C1BFA592@PA4PR03MB6784.eurprd03.prod.outlook.com>
 <CAC_iWj+2rBgsfNCjmW_Z8s9Zwu2NjzQFLUNAzehOgBszSYmCrQ@mail.gmail.com>
 <c2fb549b-df19-438d-8b35-a0de604c253f@gmx.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2fb549b-df19-438d-8b35-a0de604c253f@gmx.de>
X-ClientProxiedBy: ZR2P278CA0064.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:52::18) To PA4PR03MB6784.eurprd03.prod.outlook.com
 (2603:10a6:102:f0::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR03MB6784:EE_|AS8PR03MB8395:EE_
X-MS-Office365-Filtering-Correlation-Id: 764dd87f-17cb-4d43-f502-08dd0325a61b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dToPaxbJOde8DyXRh4jvziGjoPiZsgTx51M/o+zmdc5iqmlC90BqkhL5sNoP?=
 =?us-ascii?Q?ZEgnwAoP5d4Cbrfk9oJ+hgXuDWvaCdsROrbQ9uxOLuZKUCwn+5DuvN1fIqfX?=
 =?us-ascii?Q?8wePB0+T3Pf5AfEB7+VSSOmcMXnRZN2AfdAn9iPv1DstBz1gsND6Q8mz36Qv?=
 =?us-ascii?Q?gr7hNIN3p2HdtvSxEndptF4msLywqDSf1mhfSH6zGGYeVz6Y+YQXoaEr8ASv?=
 =?us-ascii?Q?hsYc0wG3R2VzCsXL3P5383aJlRsZPY8XGtDQnuYf2TT2D6QcXyq0XXDhcNPu?=
 =?us-ascii?Q?kyp+i6aW+ClRwB70re5NxAgmwnXFRSHFk78Fs9nSK9Z+Iq45SejWTw6gla+b?=
 =?us-ascii?Q?8JACzI2XWVbMaCX3on3Uzv43Ue+iKwwKCI2pv54T5GXjmVltcrXAxDDxyTYq?=
 =?us-ascii?Q?5Lc8sOfewAmb7XuYYbW+UplZAshX5/SYwUdA7WPDOVdjBm+PtVZiHDKy/6aC?=
 =?us-ascii?Q?SoUSF/ZzDvO72PplQItaIJ0kDIIvZtCNDyaTnOT9Ia1WqZvmPvEDF0coKTna?=
 =?us-ascii?Q?+MoRMmkYtAqUsmZJ/2imfWv1hSNJx3Vpr8KNyR60uUZj6ba0h7+oAPfJKzsL?=
 =?us-ascii?Q?AqYNqJpqvwnkCVMDATvcBs1q+UgjmEMFTR7tXI6WlKP5e3HCWffAN8hODGaK?=
 =?us-ascii?Q?srLX6VyTM4b0MCLLMDDm5xcM4sVRgtR59goh7lMp6pQMoRhtDSolqyHqY2nD?=
 =?us-ascii?Q?qvkPwqoDUSecPkpjDsmklpXoR/ILVZ7sL6buLxA3jHnYzGWPSzQG8d+ix2Uz?=
 =?us-ascii?Q?ON/kdRrDrt4Hzejr8IBsinYdOAzUxmQH5FHBUZaDTgDKF1qtFWdBOONgDmC9?=
 =?us-ascii?Q?lbcdmR9xqAr15hV4RMWGNihmr3jNlUBSumBa7jT/PGNHtNa1a9Ry7XwnVGTj?=
 =?us-ascii?Q?3wHKEISxc6vcX86VJMrJmxHY7sT9ntSOoxIB/+o4hyWMaZFWBqCTh7ewfee+?=
 =?us-ascii?Q?+XI4SbUaIW2EecByxVnqj/lUNcYwViVJLeux/9YhKf7D28wfUjt6JKZmwPqt?=
 =?us-ascii?Q?X4+ABLtLZ8JWHlAL1BqDS53PvpN3PQzKkjjfB/Nk8maPDDivId4VemBfggP9?=
 =?us-ascii?Q?gs4FxQq7ftVFn9nWa5+b+AJRRm+EfOUVugOiRGYjSqOKyfw/kNx/EEoO9B6N?=
 =?us-ascii?Q?jcdvUpQmYMoQkaPHkkVKOnNAnylhFCmMvT0ixoFLZXymKDkJd8YA7uylxe9l?=
 =?us-ascii?Q?/dvrw/JWNHzZ4NutH5qYkOvZUFMmioKYcySpENDUVhIugwFZ7enBfAdIjrZB?=
 =?us-ascii?Q?a49hHfHE/0AFabaVS1q9bHvycwQHUhmweMs8cTrXhggUiLgizZw4Q/rhIBi6?=
 =?us-ascii?Q?hpDjv4E0sBIKGkhzjsGQdTgWyCF7p5DWbK6DPTxEKELyIEDZ1225JPhsvRxw?=
 =?us-ascii?Q?xDWPnS0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR03MB6784.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a0UxA9km4+bNzLDd4P5BS10raVqChOUdH4NRMmYGGpkVHX3sglxDG16uhjhs?=
 =?us-ascii?Q?niFOmkC/ZQ8z3plB+55AZBIt0U3LoRmCEk6qo9PQQai7+SaWa+o5eFKJN1s+?=
 =?us-ascii?Q?2PsgQlQTQvXXSnYrERxQ7WMid7qaE8jjwGctzG1LQK3Cin206uRuaXghHz5e?=
 =?us-ascii?Q?zbPkk/Ppq/UyR5FijC+x0jg5D2exDUGF2x20D1Zy/HgcoL12w5eaGCEtxAT8?=
 =?us-ascii?Q?fiQ+e0Gr0f99OadWEnpSrwNVuIZ+BYZtH3YK6MFmn/5tgENcFP1Lj7RjW3Xi?=
 =?us-ascii?Q?K0wnNGWh6fILDLrLzCMJpMsOwKisLj7MfTIWYETCNh9L0qKCPKzhbGz/9fbQ?=
 =?us-ascii?Q?92Kmf3YdV326+XoxahhoEz9oWzpcGhAs2Q6DlUbbEtsnuN0WMj1Jeak5Ltih?=
 =?us-ascii?Q?rwXyIMroN4RwOCP+60Yr4A5J1q2ZLcD0ajZHtXPflT0QFP7znp8WE4FRLEWZ?=
 =?us-ascii?Q?zz9zyrGf9hnsBK1o+Kcj/1R1fFOoi78HSHh1OUkabYNADpEl7U+9egVBVRGm?=
 =?us-ascii?Q?kTXXkIPW+IoZj4r6zwdY2oU0ef6xg3MQQ8G9qoNQ6g0xEFlLM0hRXq7qEFTJ?=
 =?us-ascii?Q?p2STW0BOwDCVi6W+E46Nac+95qV/3hMzlr5eBXnPl0FF8Ho5BHqPHXFkTwWs?=
 =?us-ascii?Q?VDmBIRcc96A/ExOviK4DtZbIlE+LU3hGnumRaKB2ejOrcNnBsk3jZOE+V1NV?=
 =?us-ascii?Q?d34pk2sbpv7osXl6i2JxNUrJLr+kl4Qy0WPVoLiJ0PCO0nGbCYrD+Mbx5WHA?=
 =?us-ascii?Q?BbiKPn12/V4oNoXPkYObRBQ23VXiLHbEl3AEaWZ5lfPjsZsS5yB8xwH4b3Rs?=
 =?us-ascii?Q?SuDQnTJTlOICI8txwqw7wZ1H1NQZZOhWGJqzaYVP5iYGzmfHJSN8OzkGSrY6?=
 =?us-ascii?Q?NDAlm8BW8fF6FQQmQcpJ6MGOgPXhw0kVZuxviT4pUmcvVe+oe4erKDkphRi8?=
 =?us-ascii?Q?AxFw2hyXp7pa8br2l8SAGNRnG29qnV9CLjLtrLujlDTKUNmxnkWAFmMuSAm0?=
 =?us-ascii?Q?sKjdkxRAnkSCFv97w/xCL8WsNJdRew0Be7sgyN4ynwiRklZV0Np6V53V//5c?=
 =?us-ascii?Q?DebkTJRvnf4IxJZU3AbYOLF7klZjgPvYaFZkXcme9Pjr7pYCFltHBcQmFXs0?=
 =?us-ascii?Q?3+rnN6fHIJ1ZvwviZCeXDYd1CX9/5gWr7BPxB4ALM1luj3W4TRHjeTply8Sy?=
 =?us-ascii?Q?vdsnalAzwLlW3pcBxbClx6ioRaIMXI8QrKcl6YtjNpYjaz/53HUgiWETYuKu?=
 =?us-ascii?Q?JXDW60q3tT6N9B1e6QV6NexamWIVMOwf/EEQuy74JVgIK2eVS9kKEmVM/KtS?=
 =?us-ascii?Q?DBQMot0Bxp0KIk2hrorL98/tf+44A1gXUsmZ6iFZJsZX0LZWGw5r0mUzpKkj?=
 =?us-ascii?Q?Pfgs0n2xvgzbhsK0l8ztXVgdxn3TWZoINSWmCWunASwjC0qlXw6Csf8egr0j?=
 =?us-ascii?Q?brreP/0fAYoQBOCVA3dPc9wb2rxHQ3GH5+MZ6mN4ckI8rs0yAnL5WiplMvp2?=
 =?us-ascii?Q?CAqca2b7AdkenMmQNsaslb/+Ejm7wQeOTrfFanr2LEseYnCUqj29Q6dY4OUz?=
 =?us-ascii?Q?RfefIOorzfYOWwWgdh7dd/D59T5k3USYkdR6OxIL?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 764dd87f-17cb-4d43-f502-08dd0325a61b
X-MS-Exchange-CrossTenant-AuthSource: PA4PR03MB6784.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 14:23:59.2832 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mMRwVqb4AFgptoqXtcp2XyZ3Hsgo9g/c+7dRxhvNhwfRNjveizcwGQbvT8OCN2/IK6fGs8Z3rEV/5msLYZ/4eA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB8395
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

Hello Heinrich,

> The file system layer in fs/fat/fat_write.c does not support renaming, yet.
> 
> You would have to start your contributions there.

thanks - so the rough roadmap in my head seems to be fine.

Manuel
