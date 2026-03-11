Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAEC3106286D
	for <u-boot@archiver.kernel.org>; Wed, 11 Mar 2026 12:09:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C822483F9B;
	Wed, 11 Mar 2026 13:09:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="Eb1OPIqN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42F5A83FD3; Wed, 11 Mar 2026 13:09:21 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31CF783F2E
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 13:09:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fqEnb/AqRO2MmYFJh3ZzmxpI9d5GOoA0zAHPAhpwXlnn7TL6BJmDTfAGo3HJaSxLApCkIWJIPuJIVDS9ghaws1iQqh2sPKhdQB6Bly41J+VNn/ITCTzv8BH4NswmEo6Q0DoOVFBdEC4nnsjWjGWFwCtaGRMwjSJDrvnGZS4ram4yTzucG2+dnD59LjD/fSC9j4Ej8w94zdjmStJiTpfua42l6ebVSUgSbk3keqyRbiTP4z0+iM94vzNkLRrEGxAOB6TT8PsbY3PSDMSpy0NBi/5BayKFyfbOMPTWxzLlvojsnXsg433MYBa4zjyHj60MXoXbSWHbAU2/nueRrBd9Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rGgDjNP25CE34DeO1aeH78YlpYPpuu7RLtGLQN0T8hM=;
 b=uEs3t3iLOHkU8r0Y7dRfXGM67Onh/2NqsPF0URN0euyZsChIcrSeLE4Pb4gzaZKL2w1Q8cFmKhsPl7jx9i9yqn4z8zil1WeiIJHWYyp7UPJ/BTWyW9kFYqreBarLO/dphs7kahqE8pi319jPSxJiofq1FDAUnur51PZD+iJk2LIgb0jCNy28t2qeGacFpCRfFm/pE9aIqzIgQ2/p4rlBEYAcozVzgNrF3alUaoTHfgWqwlxztYxu6XgtqwM2q1sVloqx+FLqY/GZvrI0OCdH+AFjh8Mu+r+0D7W8HG72UylixaaL8UajDkwhYN3sk/zBo/lF+2HDB9CBUBn3T4kJyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rGgDjNP25CE34DeO1aeH78YlpYPpuu7RLtGLQN0T8hM=;
 b=Eb1OPIqN4YSrE0zfZoXuPv5QoY6Z9+X8TZGXZKQP1tDeeNgcWHPRaL4qLutym5AsHTOqUAl/aUJL/KDFtz3yyjcuGgybQ7TlRadPNj3O96i5FKGd5/Rmhg9Q5I8zuHCuVrRf9qx02ksrqeo09yeL6i6lwLf9LQpf5QnwwfC/1aA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by AMBPR10MB9706.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:769::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Wed, 11 Mar
 2026 12:09:17 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%5]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 12:09:17 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 0/3] add [ as alias for test, fix 0/1 argument handling
Date: Wed, 11 Mar 2026 13:09:07 +0100
Message-ID: <20260311120910.3934114-1-ravi@prevas.dk>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CPAP307CA0011.DNKP307.PROD.OUTLOOK.COM (2603:10a6:380:3::8)
 To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|AMBPR10MB9706:EE_
X-MS-Office365-Filtering-Correlation-Id: f5294f18-bdab-4ab9-1ff3-08de7f6704a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|38350700014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: j3nW3NbYlFNdolVcUb0MyqLYzkn5Rc5wdi4aRkm6KPwjZ4yyiiPVDtvX29Qly3s9C2cxSdJqQ7dDVC+KtneOCaZGYjfptGADTGrItwR7w4zMlz8VzluVEuz/UIiVW1DAV65jv0tRIv6lNC69rdfv0mu/uoncY4SoPTvZBWXJDf3IqiFWewsA3agTW0+qoXuStjzeSXzJfSB8QkkZhQt8S+H/+NWdgDdpViDUbcNfvCo/P1MFp8/hXLccJVbkIy6LlIyQdiMBRVeMUEysDgUrmd5dx/hTfnu+L0Q++jd+xqSFopiUh/3m8qWxVz5DvpbDlgQNsL8r9cNiihm+ct6r614XsvV9wEInEMCbustikonnR7vY4gvysOR8wFMm00RbkuQ66ViB185dMnQLx0ccKAjoF2R5z3KWMrjXTT0zxvEQi179jtq3afZ2Vhwn2A9AakIQzawrQAZvVcYYP1XYkBBdezeXkwMhGbFd0277dmswajiiWHlXsjqBSJQHgyPItBVqeCbY61pSvhaIvu40a0HxpH8JLo9n4CENHX5pdq65hpkZ+nxRvwk7AsJkW0uAEd98EVv75PovnIhmAZUg71JLBsTlg39ltOV+9xhNbEm9I6i1ChbcSmLNzD8MD6IKuj/ecJIH0rMH6D/QVSJ87mnt73fdZ6+RAWfUC3xe3gyY3TstJKhMt8iW1uRWe3QVsMVcg4G8AqZgXcEkSs97urjW2UF0Qm8HK/5d3AiOB4DlLYqcJdxEaAYGtRP1T9rjEfaFUasDZ+eqomBX8g2TXuKL5DVy8/oqsnqFEBwvoWI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CztZhuRDmq8ovkmuYGpp80CLG8us1zMRK36YsXHTS5np5G+KxkIe7rubfRp2?=
 =?us-ascii?Q?WSlfFinNQflBMfioJewlDRwb8zx79I5SQ8Lrvfxf1zGMtug/+X82CGlH00JC?=
 =?us-ascii?Q?orhQwMGAPnrLRY1Td5LTiji5ND2VEzNEDkqMfTtZCxT5gwB9ifMsR67SkwM9?=
 =?us-ascii?Q?yvN83NuC3vKdiOw5y5eB29EFeJDRpX2kHSzO3fkU3Nhlejih2ln8pxq+DXyj?=
 =?us-ascii?Q?/WYY5hg1V3Fhq/UVVtkim2KLvdNm3F+7LrkLr8LmbyjPsMAcMw3oKNWyfbYZ?=
 =?us-ascii?Q?XJA6iGpMctQHOkQ8k0eHLOWNUZbVZeNj2oLAGXfC03pVyZQDusLgHo2pytVp?=
 =?us-ascii?Q?OwWZDAmF9bwC6bjkjwg8V4vUN4WRfE9bW2PjMln4XofSv0gbGtHE52qdlubN?=
 =?us-ascii?Q?Klhp3FQBYMPPPy9J+rDpdXayqoBahEcBkWxqCNJCU97X8UbXSdRCa1VCwr+U?=
 =?us-ascii?Q?w7B3WO73zm4zh60gPkfzFaaWdQg1SsHjqMPFzwZ0V0zQb7wJB9qU6Ksb41xx?=
 =?us-ascii?Q?38Dgo0hHsAJDxTuJFPO8FmgOlhp+uRWzM+iXmbr43EnRU66ExbNMRfPqAxQ1?=
 =?us-ascii?Q?8iWROxEu+9+qENwnSGuzYTq4yFqD226diO/80vJYKfrqW2vZZiAhuw/KvYI3?=
 =?us-ascii?Q?4X5ya5DsV2f/kYbA2OjybVaaqkdGU/PFH0NgccinciUa90uuDk9vftpbCysJ?=
 =?us-ascii?Q?7+xMsTzND9x8DirE5KdBXADKDMCRDtWswcsduuSltV38r9UA7SycA6fvYTVI?=
 =?us-ascii?Q?l0PqfJ3UbJHqU78V5k019Isqdwft2Y7dz8O52MnJ21JBRjGB593dDxHWIi7f?=
 =?us-ascii?Q?h5MeK5kg6mRdtj8jYh8kgJV5dYrLS8L2wFAX1QQREcdixix0REzb/3sJyb/0?=
 =?us-ascii?Q?zpiwO/YBfYe6cGTc6YjBtEBs5Y7BY9F68cQnRGzvvfp6RIvVwg2HYWUluzzi?=
 =?us-ascii?Q?LwAhfxUBxcxxcslh0HsqNii+OwdHa5MKVnuotuhv+4bFpDfVbtHC7hlJjuK5?=
 =?us-ascii?Q?//L0HqQFxQao1eBqLcqQ+NHTqMQwKiLRnu/qP3xvj7n0haobbr1qEbeQhZUf?=
 =?us-ascii?Q?5vYpj04/Zg9tCr8wOC+q3assalkB1SgDHnC2aqibG9sP/S0r45OXLnvNYbrE?=
 =?us-ascii?Q?Py4WjEKQwpoOxi38++6sqp1I7WQqiHmrGx9nf8wwZ1PmrwHtGx56SqGfkkx8?=
 =?us-ascii?Q?otd2YFE7dOfA93nR3RNPOl0DoKNv4x+NmDH3vVIoID/FMJoQ3JumTJljbzCI?=
 =?us-ascii?Q?GNgeD/DQcMjXo9XIuHXYGA2Vthh6eqKw2BZY6nKTJbsKL37diQ5wXq9rhH01?=
 =?us-ascii?Q?E0wkJKmyTbBTWGUtAvevZwUyOJAk+Dc4Anb9nKHzp6q5vJOB/obhi7f2N/Fi?=
 =?us-ascii?Q?28Wl0o38CtzyrUomGoReKmeCEg0JSoYk6IN+Ywt1wAaQFW41pxmGpJn0Yj/6?=
 =?us-ascii?Q?FTK0MF6q4GIZHv92QwxSGxcorpRSA9lVheeQTVD1P9c2nUF/mw/41pXxzMIs?=
 =?us-ascii?Q?EeKxJGPY3MtNUqz/2lfumOY2nb2Fo8Ccn4lGzqx8m7b/0sp4tmiJwNSIqA3J?=
 =?us-ascii?Q?1mKz1/+nG/rEgl7cltjBPwM3/zoFFk+E/SZYh1SddOadPZQhTJeubST1rB0Y?=
 =?us-ascii?Q?G3F23leumjz1uOpmn0YUJ5ekXIuHkLYgmEWHZeDEiDzymABAx8KJQMUDks2V?=
 =?us-ascii?Q?TXs3wT+nTPUh+QQe0+/g0/uwEQvl1XPHLWZlIb8Cqu51eC4OffpzaNBwe4QL?=
 =?us-ascii?Q?IBaL19HboyG+REAuSwGEHH0wC0cFluc=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: f5294f18-bdab-4ab9-1ff3-08de7f6704a3
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 12:09:17.0909 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aeaBt3rS95XBQt6pndTDGb1TJgRoaWgZFCo6ZEIUOSy+VIGQwGOdvL0oiX8ODzu7QfIis/DA/nvYo4vQ50UdjWIsAqW7jEzGQ7iQ+fqU6Js=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR10MB9706
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

Make 'test' behave a little more like its cousins in other shells, by
allowing the [ ... ] spelling, and while here, fix up the handling of
a single, non-empty argument to comply with POSIX.

Rasmus Villemoes (3):
  cmd: test: allow using [ as alias for test
  test: add tests for left-bracket alias for 'test' command
  cmd: test: fix handling of single-argument form of test

 cmd/test.c     | 30 +++++++++++++++++++++++--
 test/hush/if.c | 61 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 89 insertions(+), 2 deletions(-)

-- 
2.53.0

