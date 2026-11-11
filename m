Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864F2606A31C
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 13:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ix8Ca5yC;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=vX1db6Go
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2DAFE6089E;
	Wed, 11 Nov 2026 13:14:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ab2qZdzxbjQb; Wed, 11 Nov 2026 13:14:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 27731606E0
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794402851;
	b=qP9uIvXDSNSkawRm24y9miLh6t9vUjmhqHukhgSABSix7+gS6uzPhknpvh2qbAzU0jmH
	 tQUIyWz4JHtkNLMbmR00scfVVrFtT2OFhW9Vd8b7PCAXF2Af9Y5WBJkkUTMnj0X9Cxqa+
	 930FETYgXyK0KmqBIvGilqtkAK04DV+FT2Fjfh9Ap3ALvVyz2r/zvXt9i+50Bl1OXdNdp
	 H3Ae+RoCnu9tO8KtXwOfYfC+7EM4P4o4zAkSDQUFZs9CRqgzSxzbvXnFiXJSS93tHk07m
	 lR7tOhJ0ja2xkHmqTcrkvNu/dxXuBHuQwqWmwzFL5ea2kdSy/atcz6yjBUx0BrHJAnw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794402851;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=6ntcTgvj/I9vOzQvIvZmNTlW4BrwaH2c8ni5ZagFHvI=;
	b=RTCeRI9iYd3VLfEdASDofVC5+Ml2FqZ7AaLU4VznvSba6m5qpc+1RtoYaXZUzIvaGtyx
	 z1LqiywJIwVjJSuSejJ+bjpjKSY5CaCW0OYENfoi+iCPJHHABMYiASRP9fi5IVu3vcBoM
	 1a5fJD4Bvpdqzt61tb0SxyQxHnkP1B5GLNFflbBwMzub9XolRjz4OPSb++jpJ8FcTHkyc
	 TpGkMy5tzwrDKMqS9X7Nz1wJ+PyUNIIMedzyEdAIFUxYKZi36V3ZuhSiiaYuWxjiVNGRH
	 DDNaOCBGp8k8fwCde1fF1Os8BfgYKVu8A8k+JtsiOo3Bd03yiAivw3V/0ZgqWp48KeA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794402851;
	bh=6ntcTgvj/I9vOzQvIvZmNTlW4BrwaH2c8ni5ZagFHvI=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ix8Ca5yCAwzOX5J/t6fyFnuGDCwLnBkFMkHLCbv1Wt7AmWX6EnxIVV0QN5Lxqul5Y
	 uoPcogXi10k+qFkRYmsPEf9lujaW083cz7KMkzk+yEP80kmKTYAeDvZgKjZWnP7WJz
	 9MeQYo8qfDolp6dsOzhUQJt1bGHqrpUGQsE0SJ+yNafdi6zwHErAZeCuMWlrz5+1mq
	 sCYMvg8qF9oaIkj7Fh4Sa8YrtaxELNK7zJ5J04OlEzwrfeQk71EKc5Zs5YHkUdSfv0
	 BzaBRGt4aeynjYLfzo6yxSyMH65ORkKuVCgU0o0JiI3gBuICtl9D7Yr2uigeT0knWd
	 oTvcHvO6U2xag==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 27731606E0;
	Wed, 11 Nov 2026 13:14:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id CCD6DDB4
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 08:51:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C1CE340318
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 08:51:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UW4ETOt2FSnI for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 08:51:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 4DF5C40363
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c107::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c107::3;
 helo=ph0pr06cu001.outbound.protection.outlook.com;
 envelope-from=tze.yee.ng@altera.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=vX1db6Go
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4DF5C40363
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 08:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ntcTgvj/I9vOzQvIvZmNTlW4BrwaH2c8ni5ZagFHvI=;
 b=vX1db6GooB+9ZlqPqjLtwjXqYxF9CxMIGfrRu+emJRFyvsHIJcyDcsnegH+OdV2ODLrO3Fk/2mOxLblTwi8MRcQcsQzXhCQOKyt3+Lms0hh77Iwk32vXY5/JexEAZOkF2uUr3EY2KfkRXMP6jWou6f7KvlJ8lznrGJCONik3RcMwXzUzv2+J/hajApb4q5MdUQZTkopA/xq3o3UtY2oymh/4Ses3KOBcFCLLkX5omPwrL2hwBA8IsEnWwjv5q+sZ/GXJyVb9opYM+0y1RDUdcXIoe95jx+QoIHQlQRonYG4oGrQ42UdrvAlkqVBKHA/+3PcQbrEk72+5NNe3Z96eCQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com (2603:10b6:a03:2d3::20)
 by PH7PR03MB6862.namprd03.prod.outlook.com (2603:10b6:510:15f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 08:51:02 +0000
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01]) by SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01%3]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 08:51:02 +0000
From: tze.yee.ng@altera.com
To: u-boot@lists.denx.de
Cc: Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+socfpga@mailbox.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 u-boot@lists.u-boot-project.org, chen.huei.lok@altera.com,
 alif.zakuan.yuslaimi@altera.com, boon.khai.ng@altera.com,
 kok.kiang.hea@altera.com
Subject: [PATCH v2 0/4] mmc: sdhci-cadence6: harden PHY config tables and
 enable Agilex5 UHS modes
Date: Wed, 11 Nov 2026 16:50:52 +0800
Message-Id: <20261111085056.15418-1-tze.yee.ng@altera.com>
X-Mailer: git-send-email 2.19.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0080.namprd05.prod.outlook.com
 (2603:10b6:a03:332::25) To SJ0PR03MB5950.namprd03.prod.outlook.com
 (2603:10b6:a03:2d3::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5950:EE_|PH7PR03MB6862:EE_
X-MS-Office365-Filtering-Correlation-Id: a93ba610-8409-4a28-cfe5-08df3fd0e9ba
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|6133799003|261009223027099003|10067099003|3023799007|261026121527099003|261022075727099003|261021123027099003|261021121427099003|261102123227099003|11063799006|56012099006|260925022911599003|260925021311599003|260925021911599003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info: E0n7I04IfS4+VXhjzozyu7R26Pbo2Xo0Z/6Ox3bQCGN72M0NEIw5BdKhrXTV27FrND1P4uxLkG298aMXk2GlCVoWKtH6PjIsxlE+Wl+4wM/DhG7fEQDlXtDVb1ojyXp6ly4rsgzjH4J2IJTY4eDH/d/MmK58sht/ay0xM5mT8m+a/jN2vKpiAt4q7174xaka70Xa93t++10TmSPfuEoO3/9hqJwORzCA/QIVdJ51skJAITmrJJiwJj2UzIRR5e/hsdRt3I7/EkAEyfjxAc3GuncLm1hB07QSF79fyrd0Cq9aYTb/ul+2GACg7j1WoyNz/mG+MHl1Y3SL0hFx0DxRAioJaLRWPSI6Z6kVPfnY9MTReAdZUjzAzpSuft6syEpZ+lk+ld7+CN49OYjPanLeKmd/6sOJmsy1N3mW6X6JBpQDMD4S6qRFyzuf/vZjCX695os6Hh78rQRF96SMvueeToU97UsDnFUVz0SNXk5en0hEnNw3ib6edWRym6jaDgiXF823UooQuFq9eN74vEb/v9pfJke0AR9sL/wf40YaGj0oIujxUQgIKxVzHYGc1Fti+Qi+LJYihNH6PNrQLqsUti3upTaDaLeSV6XeGRQBg2ccT3xOpd5QXOSIzPsWiSBK
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR03MB5950.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(6133799003)(261009223027099003)(10067099003)(3023799007)(261026121527099003)(261022075727099003)(261021123027099003)(261021121427099003)(261102123227099003)(11063799006)(56012099006)(260925022911599003)(260925021311599003)(260925021911599003)(18002099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U2LNVvcwHV6pWRVENs0y91auPdziaqjA5mKV4XsLDuHS7MAun8NVBVHYayf+?=
 =?us-ascii?Q?NmSkxAz4uhvVW+/gIh2KV1Wa7VcO0thU9oBMRoH6WlSLiQlRma0A23Uy5hG1?=
 =?us-ascii?Q?Mc2b1MwbQH7RcQCvymD+giKexjh8BhwooFxNxpHlYAzW8NNJyuk9w1rVekQw?=
 =?us-ascii?Q?oQaoHGHuNL2egcOzKCBXLL93OcoGaimTAu2jev8cSXozuHMduBGBItrvUJmU?=
 =?us-ascii?Q?OtAVlwpuzwNtb5deJtU/KMcGnlj68MkuG2X2iX9zmerlfDOh6ns+6YtB+eO6?=
 =?us-ascii?Q?oNXpTjbqLCKS6CDWsmyKMWHA6XdDUBWcejGLa/2iqudEio3lsqpZ7t54NrLQ?=
 =?us-ascii?Q?Wdd0evzgrslNPO2kinB0mTdaje4Cl4q1ujQV44UMCvHGkdpzxOmwCzLcU8Zl?=
 =?us-ascii?Q?5h3sPzNCqXnPR+xmr8Xhs0Sl+Z2Qli1MTg/WrR5R/LQ+ouH6T/7fPdZmJkcI?=
 =?us-ascii?Q?0R4OicByzMcV084aNf7sdI/A+zBOkOE5vhlW6KonhqPNNvL5IwjMSNFef+fF?=
 =?us-ascii?Q?4TdDoihs3aPHmw7ySMt/8vo+9u4D4LjnNioGVMFutvlOQXoyDMRCBxY6JAV5?=
 =?us-ascii?Q?BA7ts9DoTNJalxmi3OWou7+xw+daT+nCIVuWJCFa7theMzwTkN7SbX1TRCE5?=
 =?us-ascii?Q?oacUzgE6aSUlEZof6H/Oa02HcUpr5EwQ/bxZhk7OH7aPyATvyOH160HVkhQJ?=
 =?us-ascii?Q?HAgk1O26s6YMIY9+tnr2r0mz47r3pypPi4KRN8JEts7HvkWRTtK9uQbyVagG?=
 =?us-ascii?Q?XNgX7+p9IMPI2x4HnloU/Xk/ap4molXAWdsyv18tqIjLR7Lj469p0rpHyXBa?=
 =?us-ascii?Q?U1RSIW8k1bTgnBivMOZIr2lSnfkPJxyxAP5+qK81KeF1+mU2tbcmYsJbbnIq?=
 =?us-ascii?Q?7HyZKcgICGYZElBe9Q3nw9hyl2iTV+GY9XSNjcT8ATrqdYutNRjMsRDZWjUj?=
 =?us-ascii?Q?ndtIT6WhBmm1L3y+neBBSyTyw3hjP7Wu0QYoPX7ZCkAvdESZgFs1lB6Tyhs9?=
 =?us-ascii?Q?82vjC6mIWot5Tvopl5rPyShFUdoySJrBOOolfUa/6TPZ7yzeXEwr8cGv1mWe?=
 =?us-ascii?Q?dnpVWonWWa75fEzmE6b7VMFy6GcUqJuZ2+FDuUVUyJANIVbfTJ4m6LcL9QZO?=
 =?us-ascii?Q?nRhNS6676+Pbmsq0sAMrPgoRm37TFBDOZMDwqz8N6pixoBZz9AFlK85Ypf2K?=
 =?us-ascii?Q?CvwbWpR9L4qFNR5gJWn7zhG8f9rEGkIlap/g4OhrRrSM9ZS9uidcNfiKWsso?=
 =?us-ascii?Q?St98h82RD3Shvgr5nGAp3In5zMn3LH1oPp3V+Sewby41dvv6G8e10Uc67gmo?=
 =?us-ascii?Q?brKexJGCodAPGY+numYnXZ3vlQdARH51mPWfhWVKGNf4kkDj1BsWkjP5F4l1?=
 =?us-ascii?Q?r3xOHEl0HuebU+k21zZha95v4iV3t+Wr+paayQy3h6PIyIMjokA/Eq/kTLAm?=
 =?us-ascii?Q?J7ac1mWS3C+cR/LYjn19FXaiJgEe/gzxAgyudTdlon74Fu/0K5Apn4IzKH+V?=
 =?us-ascii?Q?NLjseRm3MqcO0GHNvVmKL3/l6Am4kxWQv959xfJXzC7x+1EE5xZ0YldtZ7FY?=
 =?us-ascii?Q?W+BwWQSPkoHZzJR3O3ruAlaEpkghlHVCuytXxmKhw/rucujnaXs5lisrdFYw?=
 =?us-ascii?Q?F9uuf8TH6VtF9+UqONd4c7+phuNmRCftY6ZbeKAMOWw2fS71y33QVooxAuj/?=
 =?us-ascii?Q?1aMPxISSoZDmfOAv4knyNeaQ5Oub89Y5ujItuP1HWDOxre5MuL9AiwBTnGqU?=
 =?us-ascii?Q?dkDjoykFbA=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a93ba610-8409-4a28-cfe5-08df3fd0e9ba
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5950.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 08:51:02.0397 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ACGvrBCHjUAoPdLwYCK9uAqxPqsVTad+3G13xJhf17AD8XFY+skC88U+DdpYTa++URMEOpsJlFP1hjVohxltww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR03MB6862
X-Mailman-Approved-At: Wed, 11 Nov 2026 13:14:06 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Tze Yee Ng <tze.yee.ng@altera.com>

This series hardens the per-mode PHY/controller configuration handling in
the Cadence SD6HC (v6) driver and then enables the UHS-I higher-speed
modes (SDR104 and DDR50, plus eMMC DDR52) on the Agilex5 SoCDK and its
013B and modular variants:

  - const config tables + per-call copies, so device-tree overrides can
    no longer mutate the shared defaults and leak between controllers;
  - named enum slots for the PHY/HRS config tables, so reordering or
    inserting an entry cannot silently reprogram the wrong register
    (no functional change);
  - program the PHY control register (0x2080) on every speed-mode update,
    keeping the documented reset bits and deriving its phony_dqs_timing
    field from the per-mode extended-read setting instead of carrying a
    fixed default, with an optional DDR read-path device-tree override
    (cdns,ddr-phony-dqs-timing);
  - add the SDR104 (emmc-hs200) and DDR50 (emmc-ddr) PHY timing for the
    Agilex5 SoCDK, 013B and modular boards and advertise the matching
    sd-uhs-* / mmc-ddr-1_8v capabilities.
---
Changes in v2:
  - Patch 1 unchanged.
  - Drop a double blank line from patch 2.
  - Patch 3 derive phony_dqs_timing from the extended-read setting instead
    of a fixed per-mode default, and the override moved from raw 
    cdns,phy-ctrl-* to cdns,ddr-phony-dqs-timing, plus the expanded commit
    message.
  - Patch 4 drops the now-redundant per-mode PHY control overrides and
    express the modular board's DDR read-path value via
    cdns,ddr-phony-dqs-timing.

v1: https://patchwork.ozlabs.org/project/uboot/cover/cover.1787710268.git.tze.yee.ng@altera.com/

Dependencies
------------
The device-tree patch (4) additionally depends on two Agilex5 board
patches still under review, as it extends the .dts/.dtsi files they add:

  "arm: dts: socfpga: Add MDK support with external GPIO expander"
      - Tanmay Kathpalia (series=530199)
  "arm: dts: socfpga: Add Agilex5 E-Series 013B SoCDK variant"
      - Dinesh Maniyam (series=522479)
---
Tze Yee Ng (4):
  mmc: sdhci-cadence6: use const PHY config tables with per-call
    overrides
  mmc: sdhci-cadence6: name PHY and controller config table slots
  mmc: sdhci-cadence6: configure PHY control register per speed mode
  arm: dts: socfpga: agilex5: add SD/eMMC UHS PHY timing

 .../arm/dts/socfpga_agilex5_socdk-u-boot.dtsi |  12 ++
 .../socfpga_agilex5_socdk_013b-u-boot.dtsi    |  23 ++-
 arch/arm/dts/socfpga_agilex5_socdk_013b.dts   |   4 +-
 arch/arm/dts/socfpga_agilex5_socdk_emmc.dts   |  12 ++
 .../arm/dts/socfpga_agilex5_socdk_modular.dts |  19 +++
 drivers/mmc/sdhci-cadence6.c                  | 158 +++++++++++++-----
 6 files changed, 184 insertions(+), 44 deletions(-)

-- 
2.43.7

