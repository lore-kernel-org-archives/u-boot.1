Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65007CCD1BE
	for <u-boot@archiver.kernel.org>; Wed, 22 Oct 2025 07:22:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 897B983623;
	Wed, 22 Oct 2025 09:21:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="p4vizB9l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02AEF8323A; Wed, 22 Oct 2025 04:04:44 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B34082B20
 for <u-boot@lists.denx.de>; Wed, 22 Oct 2025 04:04:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tO5G7XTydOBa23z6hSLepb9rJG1x8jfiXO/8xPDmvDTWqD8JZzpbJIn521FMNUiwuFNGIOBnBjH9eth7UC/Ag5BDVoGkRD7Nq2wY+wGdiDamBsygrvzF/qbpNcy9gJTPCrefGpQFEBpehyLgFCVZQlQSJQ4fr025RiYvKE3WY4YGRSBCVrp3QJMIDLEiZqv652mzw1EMWLJ8lJ73mm1UQUCUtH4q1gzrWgO9pHX3o8OmPto5rQfjQGHngdshKu52j4cUJGwRoZQvtMwrQre/49pr11rJpAY9U6lFphJ1L6u/aobR1XBZ2InaoR1crL9FStKopNBDhPYl+m05PceFRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4oqGmzb+C79X92AUUPddOasizZgE0L+OnQVhFZNZceY=;
 b=WtlTkA7auxeY7xCDnChl/7JMV9p60Ywc9OwqQXW+O3JX/nHm5Wyk/9kkAJER/SVDbfw2ZhkW6FqFVt5y24K7alVrTtUfWMh8vQWYkyzVpEmhjorCXlVw+Wb0rBQuZ8RI0Gfj8aWh6sPw1gdKzMHSFRXiGcNcynI2u3LmOwf9lC7Lk5Y1yyP+WcqHKcjqihD7oLaEfdFXIP1HcTvULpN5fU42KJl9+uCDjP/LYm6GM44coPX/xUxr7lkB2GjV66k33aQEMTUONwp9Evl0/bvvwzyUn6kpRbMfFmgE3FJ2QBiIhUO7fWMY9LYbXWBKEGOoNEyAa6dsdoSf0Ipg9I+Vcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4oqGmzb+C79X92AUUPddOasizZgE0L+OnQVhFZNZceY=;
 b=p4vizB9ldZuvJsd9ev68sgyqu3zlWBC3cy0pz6edLXc4R5EHACSVbhYFYY67n/UtQMaHEPFXM7wrmkN30PtdizclRsFAQZDFrCmdjqrp4FGqo7V7v7I/Y2I/0cn00ubpqZZ15rwxtO5NK6KOIR/3qWsQ+VrvL6anyqIMKV4aq7C67hsXSpImVRg6pI+E49MXCNchKV6U60Yap+ZJbp6344ne45d636L5ye5+fI/j1bBcB/IJoczpBo8XWwG6r1DBeGaMesgX24Ihd2O3FYe21Mg2y3UwT7SCAcHMUVv6FURTo+8l+EdmyQ4AuUHKKKTUnW1wMbrzaL8uy3Nemstnew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by DU4PR04MB11435.eurprd04.prod.outlook.com (2603:10a6:10:5ee::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Wed, 22 Oct
 2025 02:04:37 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%4]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 02:04:36 +0000
Date: Wed, 22 Oct 2025 11:16:49 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, marex@denx.de,
 tien.fong.chee@altera.com
Subject: Re: [PATCH] sdhci: Reorder interrupt flags in SDHCI_INT_DATA_MASK
 definition
Message-ID: <20251022031649.GC15054@nxa18884-linux.ap.freescale.net>
References: <20251021205410.2878-1-tanmay.kathpalia@altera.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021205410.2878-1-tanmay.kathpalia@altera.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2PR02CA0075.apcprd02.prod.outlook.com
 (2603:1096:4:90::15) To DB9PR04MB8461.eurprd04.prod.outlook.com
 (2603:10a6:10:2cf::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8461:EE_|DU4PR04MB11435:EE_
X-MS-Office365-Filtering-Correlation-Id: f80a95ab-81d7-4662-556f-08de110f59c6
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|19092799006|366016|52116014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pfwsBLt7E2UtyP2alS5IqTrP85Y8ZMSh/7TqEcvK0HlhKYsiJr5Pkx+JD54C?=
 =?us-ascii?Q?eq7j83lwf9TFVd7sLoKex4fwCYoxkzmg7VRXczCddLLEE+vqI1UcvabHZQY0?=
 =?us-ascii?Q?YfItrOMWp21qU1Zu4U/Vy77SSeo1tnbPMJjq4LBjYGc2b5Zv7LmcjAwFGoyb?=
 =?us-ascii?Q?ub+U4ZN+Fg2wvXlnTrDvPRGGtgynZFFkO8SrpSfOIKPJplGrUwj2MXokbOVL?=
 =?us-ascii?Q?SYFSyKzF9LPfr8XhKqw7gkgwq1d+gi+4ZcJnKFXwOohWcUPQkK0SRajM4/+e?=
 =?us-ascii?Q?AS46hAy9YdZeg1CxiLkj0xkfnOMDuepLkbN4CXNlD8AEFgEdBzI2MKOYKjqE?=
 =?us-ascii?Q?9eYeTD4l75yh9IlhnvbNimu7KCwg2o9yDAB0tP1OVrU2YwnRC6frTXBrnQ6e?=
 =?us-ascii?Q?pBW9pMloeZ7JHCJmR0cS998x+bMTrLe0JivLeGm7TDXR9w11BAP5IP9mTzQN?=
 =?us-ascii?Q?AqgxeCKwBCUuJhyDbJcc6YtgEhT2hOdaLCA9I7F0obtm5m1BfRTIrEHmWeW3?=
 =?us-ascii?Q?2Oi4O5BI+xFGhcQTgQWMjRinP4vQNh2TeddRKhl9uwNUOwLohYWCxvW32b+v?=
 =?us-ascii?Q?bFV2bpyjSClb45XkeWh4JxpTXcZjeN+/eqTKE4mcCtQh45RrAtgvbE8bq4DV?=
 =?us-ascii?Q?81z+2X36nni1GDFbO6QGhfXW2LOcZC0dP/YRvxTDVxDD7YxYGU6qChnN6oi4?=
 =?us-ascii?Q?yDidkwed+S4Sw0jS1wDmOLolnIch6ux2SY+Orni9EKdw412G61H7XUgD42ss?=
 =?us-ascii?Q?0QBOkIJxgpKTTfGRDLdffAaX0xSLzrGCT6hupa9cecaww3GcQaWuXPPgSbGR?=
 =?us-ascii?Q?CoyxFHEEw7UgLuS18Sw3ZkO/ax925SxNz5rauWeP00OLpG+gb7Q5DDACYn2T?=
 =?us-ascii?Q?EdI1j2nl2UsLvv+FRuFLVgILUDGTvuqWmmbrEdxmgdqVEsGUzThvXu0FuJXH?=
 =?us-ascii?Q?gnma+P77tZNnZsj84n8UUCr5t73C7aFtWeoXA52ExIJaU4ufMQQ8IsD9imK4?=
 =?us-ascii?Q?TnKNUxGIe6SgLqaTzqT82AA8yte1K/vv9iZb0M6QziEQOpIoi0KwW1wmoIBU?=
 =?us-ascii?Q?QXoh1ejsEVVnqDbGh4Zq8KJzo4gbbadBpbymNRkIbGjinyBuI9/2zfVpPEzU?=
 =?us-ascii?Q?3svlgCVv4zViUtVPwE+0h0xchp/PsfnSrpw/Auo7OejbCo8an3FhK54Zf3va?=
 =?us-ascii?Q?9r29NgXArkmDs5jbVQitMcvos6QlgOJcaOo03TWRXCuKSs62WrHSUVzsjM5n?=
 =?us-ascii?Q?CzsBMmg0UiWnydV1F9J2K1A445SLibOf5CGNqZZcIDTxO0cUzXJZyqnR4xVr?=
 =?us-ascii?Q?5aGO8PhVXGVZvSv4orGjGAs8tdZkPrUolNJUHoPNaEEYZM9E0lbKJUHUZELn?=
 =?us-ascii?Q?KXTPjnBOshoDsyIac4JPWF0nUVXWhKNFeJVKS8/Xy5npCQnrxo9j2LyZhEZX?=
 =?us-ascii?Q?htelAZK6owaQgfPvB8TYJScP7xTXMyKZwncrU6Awc7OGrdFZNIpXU4iK0857?=
 =?us-ascii?Q?38Zfv492iCSVIgd5rrImauOaiNnfPsF3tjkT?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8461.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(19092799006)(366016)(52116014)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Z7zRbQ/H3mQFXah30a7ITR5X4tVgbjOBmbDREV2shqk7BSfRRlOqSjBocPDi?=
 =?us-ascii?Q?/oMUJ/AxR8nwz9L5+Sa6kXUqKwsIiiPPr6aOkRn7iFs71bAZOdDU/CkydYA6?=
 =?us-ascii?Q?q98EOT4pU5IC0pSGirfksjk7i3ycVWb6iHToc6KFnb5tSk1t9lQ8xOKyXwFV?=
 =?us-ascii?Q?MqJuKTLtGuZsWeqIV1v6KpHzO6qu6GypDRspECSeX/76thf+a73lndWC226h?=
 =?us-ascii?Q?LXGQrx+vhqqVOo0FccyskEbADaydFtc4BVNJr6gJZdHnrcjmUq5lD657GmhU?=
 =?us-ascii?Q?pwUnk1VXr1tIcnaUv0go3DyoqVbYEKjaIOBFPBInsRIZQ8YCWDRI5rmYgW7y?=
 =?us-ascii?Q?tQtpGbPOEvfe7PUNB5K97MMbHWzHP0ZCfjOQY/8Qwaprlb+UhVTtfYomFZE9?=
 =?us-ascii?Q?Z5BmHrsxGJdYZzfzIhxtWWz1QPOjyobzlCQjpDqGSTO3tO9+hOabkwqD317W?=
 =?us-ascii?Q?fpuVbPFwbRVmMq0vopFw6K7cWIS2grHgXFSXktaPkt64u8oSMO7LG7EmEKrW?=
 =?us-ascii?Q?640T29ecgRZhGgz7n7oMh3FC3QsDkuu8aPMPfdRN6nN3YsbTDcXWdaI/80ES?=
 =?us-ascii?Q?AB99Jf50StY3R9h6Ccq6wYg81Mtg9b6fcQjEbczakLsie36/BCRRgu/VIYE8?=
 =?us-ascii?Q?6C68HVQ+vJMOAVA9J7g1LJmXdqqJssdkrNYax31h5hHZ/8fiQW2BkNF6Xk0y?=
 =?us-ascii?Q?hXu+zcszkxMZcsj1fVoBdfD1zwK6pSydTJFWD1jVRIx7YEMamlO+egelQYVB?=
 =?us-ascii?Q?TecugdoChwrsbT4U55HEyMFWSRHyZxb/274ux/6KTNBxUAX2cPc1FtaEDQbN?=
 =?us-ascii?Q?++Zv578C3YFnESXFWnzx8q088JXQ9ekTLUIoVPOcO22DWi0F9Hf13NL+8FNN?=
 =?us-ascii?Q?THpKDnFoj4h1YXuRPYV9QiO0K8xKWtPTuzEa3GHpwwyxAXxBNcNRhA5xA2B9?=
 =?us-ascii?Q?EuVeGHJ9Jq6I3p8TFWaFk+1Gilo8LtdgxUct8848nC0rALjCvPfAybt90/Hv?=
 =?us-ascii?Q?MizQfmSOGbaStsIkYL4b+uIlPWKC7KfncmgGr84zT1Zf6RJqPzieBJbuDtM2?=
 =?us-ascii?Q?/RQHt2ktpA9yWnCCKSkGppdw8OIaLqhbQTHs365J2UX0X6zjRyeo+nhuRrmv?=
 =?us-ascii?Q?JnJYKnCRUuS/9G1ITnpfN+mMu+Iydg9idIBV+fwjFGt+Sa4UzGYXv9+rHp6O?=
 =?us-ascii?Q?qru31+Ij+v66tDttIQFYkesicwISfsJhtYQ/LlUDrI1IApNC82oX9moVzvM5?=
 =?us-ascii?Q?qg/4ez7DGL3K1FIsTm4xMCm0TqcoCjhZYzJMKlpXI83TtSqIEcRcQg+OSdWm?=
 =?us-ascii?Q?2BLGgx/Anjb+89vyQmVl4YaNIMTiLEIvcJOZl0v53Sw41Y7FqhT8gPtemTdM?=
 =?us-ascii?Q?5nRZnPnyZcBbZ6T61Fr/NMtjoCei+9ymdNJ+F+F1BQTZxWfQnM+UQ3AgHIHC?=
 =?us-ascii?Q?zXS+rXvaCdkXhaUeajwhc1ZnsmXWTGEQYgEC8mBsedciJSV5hTWEtGT7o58U?=
 =?us-ascii?Q?B/qwPKOrQWQnQaBKTCBHzkR1785avHVT0dU7Hk88y43oO1Wj/kSe9UGLw1RS?=
 =?us-ascii?Q?4cSkrYtJw4Xljm8pkBFEee14n+xFzWcLKYyBiwZS?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f80a95ab-81d7-4662-556f-08de110f59c6
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 02:04:36.7034 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KmA5soOWJICRjqAywIFAzcMO+YJs/eojnd3Bs1gOSbr0uUqMfbEFRFyV5HBmyLFDOBz4JSOTM2UorRehfRds1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11435
X-Mailman-Approved-At: Wed, 22 Oct 2025 09:21:43 +0200
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

On Tue, Oct 21, 2025 at 01:54:10PM -0700, Tanmay Kathpalia wrote:
>Reorder the SDHCI_INT_SPACE_AVAIL and SDHCI_INT_DATA_AVAIL flags in the
>SDHCI_INT_DATA_MASK definition to match the bit order as defined in the
>SDHCI specification and maintain consistency with the register layout.
>
>The functional behavior remains unchanged as this only affects the
>order of OR operations in the mask definition.
>
>Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
