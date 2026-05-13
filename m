Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FB4DCD37B6
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 09:59:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7D9B8467B;
	Wed, 13 May 2026 11:59:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="QVgsB00N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA5328467C; Wed, 13 May 2026 11:59:01 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC10680086
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 11:58:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qBZEN53fk4PzNiTrEED40JKyxC1fZgAY2hHQsbgyKL145vsbZgWuQZjNUsZKD6e7G+c+TU7PSjA7kqZJxZeqqYPgKL662bnTsu1e6yaLk5naHOW+XYhU5kRo+UXifu2DkdV7r+br9d3ny8gVCRc8Sri2eR6TLkV8tdiYKrYYIKvS21XZFcuSjq/xClIxtYt73WMaH1gkU+lFFXVJtmnp/3dVV57t/O01mngBf/Gz7I3IKJePk1uN9PkrNooErgGbroh3lSUFIpj9LhoiFTEhEauMDk7E0rC1KLXDRuS5c4eoGQ9VG0eW+q4eiuwqY2Xx8563h5dtw1ZnOnqsJMU+EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Mw9tYfS0ZUBzZNunv7FeoFYkokutOJDpFjefjjef3k=;
 b=R7VVvZAkhVMqvxhiczj02/aFXK5RqIY6jSHxLNLl9OPKjtZ9YujM9643qtq2ytsc0bePwGa+jhGv4SHESMZxVwccc2ztNabIJRzaXqwnZ0hBjXslqQncKga6Llw7EtHqdWgrLVFSKsj9EdHlYSC1G18c59JY4IR8eegNGxjL2z1SuiRsKfy4QgF1n2Pu+/WH8UQn5U2aKbPuIekp04Y0YRC89rAnM+mH8qccjH2lDy/T/1Ts/aCEyJbxMNh6AlewaWQqtOE0z8w61B9jshvjEr5OqfwrMLyI35Bhc7wnpjHE16elOJtZ3nHVrr/XQBQsuPUPjTaMNdR3kVTcDwgj+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Mw9tYfS0ZUBzZNunv7FeoFYkokutOJDpFjefjjef3k=;
 b=QVgsB00N2/d+n+uU3I71eTWh3GagKd9tIXc4UtbyZ7GElwx+MnIilAiFab5pUPgsV2XQ7qNK+p/DpG04KpMHk8X4TVJ/p662YXndgmwuxjtwLhlYZUUTR2q3AX6XylWJ0uRDkwvFLLv6h/c9gluYv9VuL2gZQdnChHJmItXPBq0EgdGfU3GxQgUwKE9QW3BBZCm57NRUkBF/BgFBODeQ8rm0D4TavYOaO5sD2bEzQtlA7pU5EQAovMMa+N0kzSMt8cqCPf4D9CSgoe+iVOqzqS69l9sIB3CilMtGrX/fy4EWKKDNFIpMlngTfsMdr0CmqQ18IbGPrEfNp0uheLdG8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by VI2PR04MB10836.eurprd04.prod.outlook.com (2603:10a6:800:276::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 09:58:57 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 09:58:57 +0000
Date: Wed, 13 May 2026 18:01:46 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Yao Zi <me@ziyao.cc>
Subject: Re: [PATCH 05/14] power: domain: imx8m: Staticize and constify
 driver ops
Message-ID: <agRMCmDD4v4YY8e9@shlinux89>
References: <20260508122247.512862-1-marek.vasut+renesas@mailbox.org>
 <20260508122247.512862-5-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508122247.512862-5-marek.vasut+renesas@mailbox.org>
X-ClientProxiedBy: SI2PR06CA0016.apcprd06.prod.outlook.com
 (2603:1096:4:186::22) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|VI2PR04MB10836:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e90342c-9b40-4516-bf65-08deb0d63ffe
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|52116014|1800799024|376014|38350700014|56012099003|11063799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: TuSe1O+1F5Il7zfnBxaSOXeTDZRzgwbFUi56Ar4WL2YEgyT5H7S9F97HB+RV/D5Ud8FuxoqoLLTlLw/mXJ+QEXabvHTdkemdsBty6sk4J7MjnytFbFOQpf6dEA5N+cqwBk2PM7W43ETZjP+6H1IN5gvFBojAdQuCGCFv+JT6kkK3sNl6Ftj+R7byEaSGsLWWX71CqqLe9KZOMDCRXQlmncIVBt9wjMQoeRJ869DBRYbv6CL/fgJk1hiJwxga6WGACpiApuNEykJ8o3HIv8YdcxtW0eYWMh+dJDRU2cumNaEz4iyXclZ3UST//UMYZK5iZ8x3uyfyHnbTaTNGZdM+ZkA7tGoRc12JVDrDH12e7CIRugG+ntpX72BPA5nrlVPYPVDVc2bvmpbEniQQ8w2AkVahTJ63Kk2xGGOkeZUo8Hl42Sn/qxRCh4tZfRdgaXI2oStmELV9VCWXhfjZcW3ryHagfk6cWtXvpu9gKiUg4U8mPCfJ4SLOXXeQaZbz2pF6qBPEzz+VZ06mv9CUU+Bu3Kjm+nBEQxbdSUyI8uBNx9rCMrcV8oY+hPeruCjObDPzz8lq9iDYEYSCiOvnM7sis/iaVocehhqLchnbhFdTezdEx2ea5DaN9HWIlYQBTiTN/On6TrCTbSAXVqTkFk+iMqcNKIE/85rT94Hg2RTYEkYqnidDATNV/PbYruxh3PYotKVA3aQyAlwX8k+I3GGfiK+y4Oww8HdrnZsGrxoErxqGMAR2bLzBHkwvSbZ/7HVb
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(52116014)(1800799024)(376014)(38350700014)(56012099003)(11063799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uKkc3wnocvV38TFP0hMA1iKS+9/Mn0mcBB5kNRoRPvW4lkCMQ1CMiVC3SBwA?=
 =?us-ascii?Q?TEuq1eFyQKpPvDl8TR+OchJG5++rwRzUP+xroDq4kvvt2WxGDTljwdlRRTZE?=
 =?us-ascii?Q?CAOSiw/3eG3l1tIL6YJEZCXn+ZEwIIY//lfNB4mOXPHZYKuPz7bw2MlMbwTA?=
 =?us-ascii?Q?y4qHTjpWF7VZV59sipvDe9lhK0s5TI6JOKRDcnA7oGkplZrxt7i1kiM0ANf5?=
 =?us-ascii?Q?20dCGHryB7Ifk28fnoCzk6fJlVLc4F7H2C4ENBVyxFcn9JOY9agFfPsdNQIo?=
 =?us-ascii?Q?tbzf6HD+/fOHGgSizsD2Medx6yqiZVZs3MzSgUPsp9E+pwTF6pJ0WtLXT1aC?=
 =?us-ascii?Q?GUK65p8EakhoC4DcoEX7qkZgKbAX6chocdvRzS/Y7RZYuznAPGwfGOeNXyBS?=
 =?us-ascii?Q?YF9PN/XHzwhI9QI2n9clp8LI/fMMk4zMUBnLyhaK/R1MGjL+ocBzNODi3Bsx?=
 =?us-ascii?Q?7xVUq4nE4phsD4/XgzaW4f300+vXOX8whTWCjntTCN35+Z2Ta7KtLIp7Zljs?=
 =?us-ascii?Q?DCTjggUnlocW1y9uGHhZcFOJTjx/mPYdICn9iL5ixf9xS8rwLUGNNmaMq7gQ?=
 =?us-ascii?Q?8b2yR3JIOYScUkZWzF1b7FRQLCSBcxvJFiiEeOKzANpVJBRUb9Crbc9HRsmT?=
 =?us-ascii?Q?BonDumvokT52dUHAEu0W6c4btOZYdm/tuNiaOOIqqVZnJB3IEWccp9cjmkm1?=
 =?us-ascii?Q?Jv2wG815SGtjHz0fbSKV6QCn6TtXk01G6hopI1jSnQSbUJgu/2aG7eiu2a7G?=
 =?us-ascii?Q?RlZqocTvWUXdoQgnjDxtwbSqspj11Q815fk1l7QwHLEkHUXdG1SKLYUPcu5a?=
 =?us-ascii?Q?KLR5C4mltdd8vfsmyYv+flH4g/7qfD0ipUWVKdA6DIDaEx5skeChHkE0tiSx?=
 =?us-ascii?Q?M5n1+lnqsYAimTWaTohX0FeEqb41cux7i9ZKWLh8S1hHDb+p6OlH65fWtzWv?=
 =?us-ascii?Q?JRIqL2mHTh+ezTPw2WEkucOZ6QsKPNW6S/Mn1f+qexjTFg50zQiJt3LH7OAl?=
 =?us-ascii?Q?J0NkqmLICD1rn0+gyB1u6d7tixjdxzO3Mukm1yV5/Pjcc9sYZhEXOMUGuxeQ?=
 =?us-ascii?Q?V3KKNSxsmb0ssuJwsuIpVvZtK8/q0uK3vwsrnzJLQEhT2JA+RKBW7Oj4O7Ft?=
 =?us-ascii?Q?uZoiiaVWJxkvOrl0U2vaLIUXc5raIEpU+lC3oBfmd5iXKSHxjlyAhY1VGjuB?=
 =?us-ascii?Q?Eq3vf41DtM7RlTqn5UccsU9V1vEGSyA41DJl3Vp0AF9Pdy/PGb81aNE3JFiu?=
 =?us-ascii?Q?coeBYSE2s7mJtzPA3UcBkPXLnq5qrsJXNiaPUrSQwmTPk/RIaK/W7xej0ABp?=
 =?us-ascii?Q?Br+4lR9U5DfWn3yXgURNnItVxGtidIQeAqbDUCKpWU5rHDXqHgmSbaA3yvfx?=
 =?us-ascii?Q?MRJO7DnTt3NRg/0Ba79Yc/Pmtgs+JuEjHehwG72JRAk8Q1bjs+tCjlEykQ+D?=
 =?us-ascii?Q?PxCmy9S2BeCWiv4QErGN8AMqlJB/nB34iYQZRiVLYswS1UOlmd2sO6blZzLs?=
 =?us-ascii?Q?rf1jU/MFfFzqYF8AwRUv5cZN9V66AfBPFhXNaFZFx7LifvkElz0o0yojHmTs?=
 =?us-ascii?Q?zrEB3037nJ619QXvnpM4mr20nN/SuvJuHDnRDGymu02Gj9h7Yr3mWHLcZ97a?=
 =?us-ascii?Q?S4G65Qqb+DXEGcmIKBilkqNJOWFxssmxmlHsfCVfj3HJviSoOAkOPegOEBhw?=
 =?us-ascii?Q?U/dxmzoIcmz7ZTXM0TMzzzvohK+Q5CafW+yRvB7VM1P4B2gXTGnrmQCNk1qj?=
 =?us-ascii?Q?ChQADbEbXQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e90342c-9b40-4516-bf65-08deb0d63ffe
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 09:58:57.7440 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oltPF9Ghw2FsKLXybKayfKhbPbqaLRd1x/LKKuDfDs5JgggY5m8g/Cck2gTdIjRWkOwKWskFidQU5/r0FrdpXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10836
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

On Fri, May 08, 2026 at 02:22:05PM +0200, Marek Vasut wrote:
>Set the ops structure as static const. The structure is not accessible
>from outside of this driver and is not going to be modified at runtime.
>
>Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
