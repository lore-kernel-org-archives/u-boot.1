Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CEF5F357DA
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 10:29:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C11383DEA;
	Wed, 25 Feb 2026 11:29:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="LePesb4R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1898A83E36; Wed, 25 Feb 2026 11:29:48 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2911D83DCB
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 11:29:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gke56msi6I8ifKCUveskyAg76vF6TCzlK3ymklK4J78ko0QeI9qKykQI2MB3LBsBDJjQu9bW6shxlcublYsnojU0w5sI1NyMs4j6wBKwY14bi0vkp9tzJVxk5ulN8/jtbdv0ybKikRMbqUgbKcqNM3VjEPuB0LqixCqAmnb8U1TJbQVyIPmlbioKlzaCT5t+VbJPhQ2Wl0o0J67hDsdBb17ee1hoQyoGO25YK8L1BfygekxEiZwN5Tcv/xXFaBNh9DTeDT+qetUchQHGXr53/uqBUTt0Gc3TzaQqxA5hdD6vBlqiLRO3tqMfsSjl4V6q65AOus/hWjN2P5Czm2oWaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mikXYoVyvRdPCLi8+vlyerwOLPKFmST9ft5b3IkU5SI=;
 b=rQleBVGeCLfTKQ6SGaXxj3XcqxSijGhiksxLwE8pED0RlIHhruzq2FHdtmKzTmv+p7HJ1XlFDweOS5dSthpqVxS1YySxdDlkEy5nrj3HQF9aMJugV7wHrb0Ni2s18EmCp6KZo0pyw2OZdJ3kyNsKFXffVAfmaDoACrQRLyuqbcOUxUV0qMdSXhfGIKgX3CduClNBRABaETE3K6QoPjQoILbtW7FtTudKwhP6tSfd+SHiSLEMPGLQhS+kBCAey1brNoVUbJbnlLHK72sRhD38IR0d8KI5YJxALa5onc2BeWFMlYbxhLYQkkf+4K3optO9ui2JPyiopsWkphA6xVvXxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mikXYoVyvRdPCLi8+vlyerwOLPKFmST9ft5b3IkU5SI=;
 b=LePesb4RXOwmOraLpJRSKQgEJTrPd3ubFQtfP2F0hS/58gTacH/ZRamOzyULBbSeUIKSf11vKVb1/B7clOsqAjIEvZAxV5I+BNCuqJW7xQMaH3TsrgcENwSPz7lDOfDtTMutqVZDo/vcdhaTWe+K50fzYlY9dcK608qqqH5JlL5GqphXOTN8OLBpcRymJ6MEcQ+XMBEzr2LFnrCIofKB2EBsCiaJ3Ca4w0ylxx4hQofKzurwjv2a3KYWHy1sT9eQyp29vlkrd52S4lAmFH3BUDgxQeOhbWTNGBsdD5ByRMXEf6vvQ3k2G0NHZUAA4nLnfFm3/i2g0k6Kf0L77ptjVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI0PR04MB10291.eurprd04.prod.outlook.com (2603:10a6:800:245::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 10:29:43 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%7]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 10:29:43 +0000
Date: Wed, 25 Feb 2026 19:44:55 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Alice Guo <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>, u-boot@lists.denx.de,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Khaled Ali Ahmed <Khaled.AliAhmed@arm.com>,
 Michal Simek <michal.simek@amd.com>, arm-scmi@vger.kernel.org,
 Linus Walleij <linusw@kernel.org>
Subject: Re: [PATCH 2/4] scmi: update comments for scmi_pinctrl_config_set_in()
Message-ID: <aZ7gt4_o-pkQevNT@nxa18884-linux.ap.freescale.net>
References: <cover.1771856828.git.dan.carpenter@linaro.org>
 <4ef79218f3f6d6530350f4ed228fc4ebd7d2801f.1771856828.git.dan.carpenter@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ef79218f3f6d6530350f4ed228fc4ebd7d2801f.1771856828.git.dan.carpenter@linaro.org>
X-ClientProxiedBy: SG2PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:3:17::26) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI0PR04MB10291:EE_
X-MS-Office365-Filtering-Correlation-Id: 614044f9-505a-4873-d00e-08de7458ca2b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|7416014|1800799024|19092799006|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info: lAqpiGYuACcrGzYrf2Vr78e0RzjXxCxD0hDThd4ZqwuHHi3jK2D67sgAn2LK4crkdF1J8zx9dMAATl59hl+MxzQn/fsKG+fz/sCNmuMYY/rUWCYF1BixNgdcX4e4nuowzcJaFlgX3ggXTvZpp9nmrTdJ5BfoSB/2gWSytdkOg6qsBFGogtfY5t45X+HtPT90RWxbGYkp3q2ehAVp0Gb1oOiyXY940hCNhcG5HHIJvY7wPSJQ+14Z10MjfbiZaQQqC0I1Nodn3GXBOxqKAfkoNke4eLFMylJxNyyACzYlciR5+SB6fT6TM4NCfceBLS6C4Vr0ZP6lsw8TGN1ATcA5ZGBmdelqrN/L6Dq+7waYbeNJDacoULC/HXK0XMV2g8sgrmZaJksYxfa3ZE6Pc8X50oNKO7VvUkM3iAEVK71iUuO9xDpwXqR/ayZUInJQqaHC7T/8G7cABt1+oG66xlKurfczskGwt5WoABfsse7dCPcka8/o9QN4zgEZUoOpL+tWFysmp7jbelozX4H1dthqDo374PIdrCxzh7seHsDwcfDyj5xePHO1ypBYgwtDdsr4EHHbbpcOFWSH0dR1nEzFl6Ev2Rtwckyy2Q5QtZqyznJagQ3pF84QHNj39Z/43PZCG6OqpKtjjKzfku9zIx1w5HWEWFYAS28ITTMbrio/W8kR6s1hC8/5oA438PDgPPbSKxUxfujUEFC4Gzc98WRZI8pZTEIqDn4iymomy+zX9bAxROhwH9UffcmgTlUfGKxhrpCuQkZomZxOSFkXxY84znu67IQBWfnw7uhsy9NH9yw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(7416014)(1800799024)(19092799006)(7053199007)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jlHo2n7pzxzQguA1UeH2aR62OKJyM//nPdRvC2BpXXo/ehM8EJRgZyaquYMY?=
 =?us-ascii?Q?xygLBCdKDw8K2TasIWbt+cl2yVucLBf8HM+4YxQkeq1lx44iNYRZsRXwWGDn?=
 =?us-ascii?Q?KWDEv55geEOJmRjUeby2bFAxmZoCNjdHxnhia6RKmksMvm8r7nRfXHPILZ2K?=
 =?us-ascii?Q?vZ09ub/Lj5woSdMd6K0jqV+/7OuXhZSHPStIi746LOl9YwZyhtRF59/GLfpC?=
 =?us-ascii?Q?6XoRVp3KAJmCqMfsqNgRg/8kBX2f0VQpJa/hCmYSHPhSrOpi/UGt52TQG7Cg?=
 =?us-ascii?Q?myU1lgw4fc3MFQ302ImorQ1vKIsNx3FB9efTmXKnfGLW+lHDnoX/FhaBZM7V?=
 =?us-ascii?Q?NMMFL3KQJXY1nPxxf75PfNf4k7gOgaKllszsfYL1GtjWSwWIK12EP9tA/Ymt?=
 =?us-ascii?Q?n3+VM43OD4keI5Nj5dAE1kKeKs6nSyws9uI8yqUDcOfF8xVIvsY7YpZQxfYk?=
 =?us-ascii?Q?9WpSl3T7txVKhONZ1BYoFsO+OYkstp2TlZEtupkzpcqO9kWTETTQjUqdjvjK?=
 =?us-ascii?Q?kpj7oACo7QXjxjQ/vdmUx8Z5xQjWcosCWLFFMc9Ehgxevxsrne+GTAAm2Kjf?=
 =?us-ascii?Q?y8TYnAPeZUGROJohWm/RBcCi3XlsFkSVIsg82JbO/EPIIaHcFY8PomVi724m?=
 =?us-ascii?Q?IGRGRx/zGx8Nkj6LSlQKGjrA7cFvGi4qjfAHypvhs3RDCL7QL3r21/K3wbR7?=
 =?us-ascii?Q?89WyPkJWITRdRZsfogNVxc45RvcwFML8tJX35Vu4w7kjnAjqllCGYFwlTNig?=
 =?us-ascii?Q?bCWWov1l5TdymlVwEBRy24T0iP6uZopxyJ0LmtB+tr453ftdkXH7pjYsUIwd?=
 =?us-ascii?Q?MOJmb+yetw2n/RrtiEVV3dW0R9m9e0r3uW4jxVV9sPotDjEbluy3XNj1h6O2?=
 =?us-ascii?Q?q3K5cSZgsapAhciWfWxBFdi4A6NIN/vpEZnUN/XQIcO4orw3Ll8T5hmoOs6c?=
 =?us-ascii?Q?6xvQHjXFKqIxzCDXHeHuxjAp/brL9KJsj/FW1Q+GrSjSEe9hIxSKvmxnbyZf?=
 =?us-ascii?Q?vf7eVs4psg0kqYz9t8XoIu9/SkBXDkK6C7t5AewZ+V0QmxmqZrU5I8QUHkeg?=
 =?us-ascii?Q?QUm1TJSe8EyED/5foL4WtcRMszHVGPmTcFLrW6R4BEkZ86nzey3fdfMJY2/e?=
 =?us-ascii?Q?EVOnew+OWMdS+33QcIxWwHo9RU2PKNMr/XidAFZ0140mqsbzKE5x38EGE+gd?=
 =?us-ascii?Q?FI6y8eIJ6GZHBkum/75mrk7Jm5B+v9pPWDhtyZKIcH/N8nurc6w8RGTakAi2?=
 =?us-ascii?Q?BaDyOwzz65EuURbyO3Cnmz2JpQlsxvQP4tXo0ZO/i/PnsBIQfShuN7yxFttP?=
 =?us-ascii?Q?7bpWdOHleJ4b2iNT0CP8cqFLXPScAeRIRatCAgGNjZNJ2Ew8FMol5PFsG6DK?=
 =?us-ascii?Q?IHrjtcvax1tW95Mdy/VXMxqPCKQENOr+Y9zphvffwxb7fiPREw1iVvCEKQir?=
 =?us-ascii?Q?uCCRuaEbfFN8+q/AE1jfhJNZUUT11KGx13t4w0+1eQldCq9aucLBYM2I6ung?=
 =?us-ascii?Q?rD3zeybH2vo4HZFwtFeyLP5t04GZsYwhJ4VTy7W5KnIONB8bTxhp6ZrUvwzk?=
 =?us-ascii?Q?qFuoYHbV1v+WOxp9fr3Nhe0DOBhV6kiYCcfTEf0l82XAiIxfZLD2Cf4NsR3P?=
 =?us-ascii?Q?vCcJBLKq8enoXTMsiI1r9bS0ZflkT1PRs9Fwiu4mwDPH0JZp8VfT2GSZpT5H?=
 =?us-ascii?Q?HP53QnA5LL/o9PoCI5ICgX0CTqwoQZHy0WwwEBLgHyqPBco43+nrEzCAgiBr?=
 =?us-ascii?Q?O4hF5TR18w=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 614044f9-505a-4873-d00e-08de7458ca2b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 10:29:43.2909 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0rUKSCgOwtHfnSALxbaU1e0GuZFVwXTQ6vPhxioXczQtRKOCzj7tXf4ogB9JI2RlIhkBm6NjDLbwo/gX45N8jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10291
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

On Mon, Feb 23, 2026 at 05:33:30PM +0300, Dan Carpenter wrote:
>Delete some extra space characters to make checkpatch.pl happy:
>
>WARNING: please, no space before tabs
>
>Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Acked-by: Peng Fan <peng.fan@nxp.com>
