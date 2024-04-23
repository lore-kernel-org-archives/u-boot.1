Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5685C10F15
	for <u-boot@archiver.kernel.org>; Tue, 23 Apr 2024 11:18:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39CBA88A71;
	Tue, 23 Apr 2024 13:18:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="VVG2MZC5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7FF488A9C; Tue, 23 Apr 2024 13:18:38 +0200 (CEST)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2611::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84169885AA
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 13:18:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ehalbcT6uX5GtSoGvP0LLNHcdkz5iTxliIB4dor6SIUDm3W/ZpdI4IKzX5YZ8PkcnuA5jwBXRSAFA6yaYzkrpP4ojpX+CM2wMHprVZXwRt5ExjRMJ/zRZfA3pYdZZFbHy62HgxS8uU8i8m8uyeAatSgmur8mVC77nv8TfO8/lNqwNAdcOuLZQf4hE+aZL4EyoIapLPIT19+6HcJarYn2n1oMTaFuRGpS2kOxdFlZPQbdB4K37hXHAAtVE6iu2le/YXk8ER02KL67Zggca+UNln7dX+efjA3RJO1z/voKsGz2S2EjL43qSk2Z3PsS5rKsPkI0YA9aLPpfLxCGZbJMRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=on6HurcX57WlPKfywNvuY3baJrOc9RYpb7sNUjg9tBk=;
 b=UkeQvJDoyKDgIOsnvlgjXDz7lkNAddBU69XK3Jca/JvtOFgf0x9dX1XF58E4ZOhrPz+BBlDpC6ih0I3F+g2sSNLvvdbZxjYyovhcmSk1FsjqBH1skRhJsXuvRb3WI65aVERO3xsWwK/c3Rzq28eh1Cp72uAmErlmz3O3JfKVw8FZEzeLlSwaFBeUoOstHUuNLxlhYBnJ8nCFqkeH27pU+dflnXWDuZFdzAxkA/jHcYGgog51cWJVleEF8AMyNwImEZEb8xgjJ6Fh9V9D/51XCu3z8EUTjZbP8Xl41WGpCXUnQVMo0jvQLsaW7f8NmZ5A9K7FQMqhIiGLuaW3lZF6Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=on6HurcX57WlPKfywNvuY3baJrOc9RYpb7sNUjg9tBk=;
 b=VVG2MZC5GQhXP7z1hWRsEd7X6/ge91oyzQ6rw4RnUQ9aG1hFAqnd1H+X1XWW3fH3QfUdGErOjWwb1wF0HZEfQ2Kd2Kx2VnKZLNFzE97g38CFGjCQybZ9a982+/Xa+UIoYYrXQbN0hbNCgC6Fx2E/Vc2vHXw8aCJ20VnY8nkiKPE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8120.eurprd04.prod.outlook.com (2603:10a6:20b:3f1::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 11:18:35 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 11:18:35 +0000
Date: Tue, 23 Apr 2024 20:18:50 +0800
From: Peng Fan <peng.fan@nxp.com>
To: Michael Walle <michael@walle.cc>
Cc: Priyanka Jain <priyanka.jain@nxp.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH] board: sl28: move to OF_UPSTREAM
Message-ID: <20240423121850.GA5164@localhost.localdomain>
References: <20240306161911.1598529-1-michael@walle.cc>
 <D0KJOU4QE6JZ.3CBVKKJQT71U4@walle.cc>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D0KJOU4QE6JZ.3CBVKKJQT71U4@walle.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SGAP274CA0019.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::31)
 To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB8120:EE_
X-MS-Office365-Filtering-Correlation-Id: d875ff57-f9c5-415f-486e-08dc63871d82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HEaXr7qCaYVUAO9Kz4DF1wjWegDEt2eNv5Lahe4ms+EO71rFaflzgiBggcBc?=
 =?us-ascii?Q?ZNv1P+HlKt2aDSXutprnF5qrJPHv6TWNzpFHd3vdcZJMHO9ruSxoMAJvYAlM?=
 =?us-ascii?Q?Fwjanp0072sPWPFlSbkoV4JtUR/oLlRsryM6LerZaSzRuyYrmfRFkShyilyc?=
 =?us-ascii?Q?g4GNMGRvlVVGZAE86zyrF0JSglaghb1gfW1h9fI35VZ2yvGs+wVH8j5thx4I?=
 =?us-ascii?Q?T8xIhTTw5q4iqZM+B0u1/4X2+t2JJcDFmnEgeR/Zr518r5nzbUn3zsKog6UD?=
 =?us-ascii?Q?4G5+BB+l0cJClwtg+miUHUAf0JPofNUw7EmM+wMYh9hYOLknMT9k8jtdajoG?=
 =?us-ascii?Q?PiBBJ8dU7cpgOyi2yfqPEH0+7uHiyN08zmV4lpOAZCI7BYKzr1745MPqdYqn?=
 =?us-ascii?Q?pgAdRzfTrt3uoOXunYd2LmgbS10mxKsHkpYrhXuwTd+WYbLHoiR7N1v15vnx?=
 =?us-ascii?Q?sMwYpMMZOrE8aZjzfXD7PAO6gpWNoZVcDcvtbG1gfxVkn9qbDfBKcEvDh0sm?=
 =?us-ascii?Q?qHVdMVBc1dAYyR4k7ynBzu1+ONEbEPxj51Qjduy0lyQ8Zesl/w/9iNBqBGpY?=
 =?us-ascii?Q?6XN1hYL5cDPmDAlX+oVgXlRUzPjgaolHeWeCMgQ4LyBMSic6utqEwl+4T/zC?=
 =?us-ascii?Q?f/UlhhlrZeqqDUIRzj0Jx/TZLANtUxO0u8sAt1/yA3jdwJpJacVDh+B65fNQ?=
 =?us-ascii?Q?AJaN7EBOwIDimGmpgcxrhASw12+OsPHGTLNgfeqyUAG6aNT3t69NuRZkpLJS?=
 =?us-ascii?Q?SuUVbxaC5/FOvYK0/6DyR6bQ6tUfu587KDMpF/nkcWras2Mwr7rXIUjvZ1Pn?=
 =?us-ascii?Q?sfnK56+j6/xmguokeJ46uy08ytqPRp3gUjq9PHA84B6kWEybkqJn52/UtD+c?=
 =?us-ascii?Q?1ghIgpKkpo+CMpFuNZ5u5OWptv3Dznym3UPXuEzRmWZ4v09T0JB1tKAT3jen?=
 =?us-ascii?Q?CXoGrk7Nv3LGoVq6et0jCEjjq4SG1+6v5iSUFxvCPDc8KTVn8iOF1qGpQi5S?=
 =?us-ascii?Q?NUnyXLKan03F5icsISj/wJ2UuCsFbsV7X0/P0tR/o+zMYLIU4LHxgeKD4l6p?=
 =?us-ascii?Q?os9uU/zTjGvBR5ovARsSdDCVwo92Pdguo5rcoDNP5m+FuVwXIub3FRuwlxn6?=
 =?us-ascii?Q?ziNjkhp0/BWaUED42PaivHdi0xERyalH62gamZTFpiqykw54pQMSxYv2kVDj?=
 =?us-ascii?Q?+SHSOZ+hs2fbqFGmeJ8mPf4UeUx8L8UoKeanS+FYQWSWMafYeBEXTgWdkZ87?=
 =?us-ascii?Q?Wit7HLeyO6kCtZcGgcvC0LhMqIsf9dew7RtSVLt2H3/+eO6Q+9wFZUPuY4GE?=
 =?us-ascii?Q?gjCelRmq0TF2bDmoA4Wc5cWIpTvNQ4uHEGDgqCKB4iw9Cg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR04MB9417.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(52116005)(38350700005); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?67kUoYPBly4Faj/iMiXK+WeBiTaT83TAe5//1GXR0L6gP9eCseKIa90qabMi?=
 =?us-ascii?Q?OtwArrVFZBrcjNkJKHalSji4P+L+d+rR5xM8XXc9Z2JtByRMk2kph7y1jPHS?=
 =?us-ascii?Q?SNWVQ3sKD7l0oZ/P9g2961Br0TKp1tZKkDjusBHg605av2XjXMpIEXBzFCwt?=
 =?us-ascii?Q?Pby/xLtraokW87BBYBZJG/lJN145rR8oov9fhG21JGHgKYrdOSCLKf6h/ZWW?=
 =?us-ascii?Q?7TuQtTsZWlooEjZ3YmCG9dBFQ2Q9ta5JzKYC6sKm+ZZOpdQyggA/Q0XwS9dx?=
 =?us-ascii?Q?1tr4nduioYy4U1/c6Z3rbvpl8wlcmR1tSjHXAbVUszFkaelfx/xKvsR9wR+/?=
 =?us-ascii?Q?UuddY50ZcBlXL/Ajp6y/1LRskDsYRovIKezRCFkoAcCamt/Mb8OG+Ofctas2?=
 =?us-ascii?Q?k/JROiS/TI2n6n3NuS2Mt5Ej4utaLMwpU68TZbcyfuA5ba6DbP8UMWwS/GwA?=
 =?us-ascii?Q?NFwNKsaq9wwhiU3NQPPBfxieJhWKCkw5VrD8OlKl79azhjRLyvfiu42R+RaN?=
 =?us-ascii?Q?qiSRv++NuZAcrMQNlDa0jV71znK5alip90XWP3ywRd4wQmARMXZauwVYmCho?=
 =?us-ascii?Q?YgBtpFTtZPkdn5Ok5Sc6h4RzmDWs7LPdB3ClT6ysjFfq7qeAiAfKj3rQB3G0?=
 =?us-ascii?Q?FZ3vtZXLfXzmKgK0aOkyho4bygbfda7jOHxol+V5QVUembqIcL5qrV0ZX5ui?=
 =?us-ascii?Q?mmNllz4IKHA5U9fbeTq3Ug877UIpuWXoaqAeFcZ7NldngWkO7io2etdIauhu?=
 =?us-ascii?Q?vVaXR1zf8kMeuVHROjVQv80xPMwMuqFjZWbxDSt6haw9hj7R35d+7Md9chvU?=
 =?us-ascii?Q?WGjXc1cFhU/aaCm9Kw0FAZCZaBB5nCEC5zUlGBaP8gCP6sPEYbflw+77pPuw?=
 =?us-ascii?Q?HP60Q/e0scgF4zciri5/M/m/qJGp1O6eAQ5tv0/6YkP538hqaXgAD4My3/Q9?=
 =?us-ascii?Q?PxdHMgsUSpaaljXkGDMBNICfxTd15GTe59cRURDgFo5LMLIG2FzU894778dt?=
 =?us-ascii?Q?CkCSRbAe7z8i0bJUh7nbqRDA8mC0IWSAb9PBoI3Wgiodvnd5izyZWEPnuH8n?=
 =?us-ascii?Q?Ab7TupTQ3fb9+2x3LP3s9zsSWtUN8gjUIO8lJchqCs0szq2gI4X4GVcupEQo?=
 =?us-ascii?Q?9C0ANgByqDsBpVVyCi8q8ofSioiXILZkzj+9q5K2r+MQSMPKDINxthj46BtH?=
 =?us-ascii?Q?i1hXOlwzwfKCh0O4lEuToDqkYLD1x7XpDBwAUke/HeTCoaP8yBMy97o17vke?=
 =?us-ascii?Q?QycWvu6HgJlhHYIu2pq4m9IyvhAiVlluc5ak50UnYrMkSU+nuhTMAg6kmyqK?=
 =?us-ascii?Q?FVctaXIOT6MJgRqaLt/ts5Ym2vVHl1x7boVOWDpWVXVXUf78qP9nxS84S3cv?=
 =?us-ascii?Q?g50P/HdD0Hq21bPvLanhYiagBJ1enR4U5sDL08UN9z5K3RI8TBJLeMbSJMhE?=
 =?us-ascii?Q?wnT+DGD40XobRhsbtcdnI33ohKrn1G5Rf47dtEyKMZvVMlsXOyAagppNBtok?=
 =?us-ascii?Q?Yckv6j8rd+kZY66G4Qq2CQ+kpoCl1BunqrkEbmGTB1LGKDJUv4RZiz3vLX/n?=
 =?us-ascii?Q?XHwn0igYY/WYUcMqBzarZSmlfjLGrfpzhEchPN7E?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d875ff57-f9c5-415f-486e-08dc63871d82
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 11:18:34.9160 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hbh2DPKR4QWD1Y/2vtkDY5r0tfq9xoz2ScsaLSKnElp6UKgjxd819yguEIPXGV6l2T6ge6rb8WcFdyFZ5F0+yA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8120
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

On Mon, Apr 15, 2024 at 10:14:56AM +0200, Michael Walle wrote:
>On Wed Mar 6, 2024 at 5:19 PM CET, Michael Walle wrote:
>> Use the new device devicetree files in dts/upstream/ and delete the old
>> ones. Still keep the -u-boot.dtsi with all u-boot specifics around.
>>
>> There is one catch and that is fsl-ls1028a-kontron-sl28-var3.dts which
>> is not available upstream (yet!). For now, the base dts is used for this
>> variant as this only differ in the compatible and the (human readable)
>> model name.
>>
>> Signed-off-by: Michael Walle <michael@walle.cc>
>
>Ping. Any news here?

Applied.

Thanks,
Peng.

>
>-michael



-- 
