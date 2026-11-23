Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E5B606A31D
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 01:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=dE7pEnT6;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=s4oHVM8n
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2BBF5405F4;
	Mon, 23 Nov 2026 01:41:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hU_5EFcv6PeF; Mon, 23 Nov 2026 01:41:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D2995405DE
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795398060;
	b=opJ24P2JtSHkT0W23A4vZbbL6JnRC4oF2euVokxwBL/yXv7b2VJpLEUVkP3vk1MSrqxD
	 wKIsbMdET2TXlxKeDwK4y2YfGUshZlB9WfoKy5u+XZqvRxIWyX8nUPUjw23210Co8e826
	 Md6ShY+d7Q5ap5hug/GzbWDb9HHSBNutbKri2zpPOGGFvPXivQ2qKqtLS/7iLn+hXsir1
	 nfr7HHJD1IHDWNZYN8Gqs+6brMiehsJab3g5Td+v706udtSPcnIG4yjwkNhZ5bnoymiAr
	 6OIf+w2hY/IggebeYCNgZUF/3+njO/3HJ6RlH4F8khIqFZ9yY4/iS6RvMsotvb5NLMw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795398060;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=hE5TM3aATQqO3cgkiwDveY601kRIqo+hFAATAVA3c74=;
	b=q9ZRZtYE1boj+DTdmmsURQgnmDopsVUhrlgvA8PP+Jvoj9FPEgBk5OkQCj645dyde1hR
	 vZ4p7JtGSXKdH2WRhxb/bfiC6B1u9YqD95ygYABaZpN5D/NrfZGuyoA/+tZZJbGmBx4G5
	 NnYWVlo/Y6+2P36hYlG8IY/Rdn/gljlTrUVlmXd8/KR0rr0xKR+gK5D345QPJDAuksMRz
	 8/m7+X0bQBVyLesDkdrNf1hFmbm0pCPFatlKgMME7FqQ7B/IHKgp2Xe1/m93TYkON46+U
	 3oQSrNokRyuPLTFLCzavbeBC5dSfyTVKk+qWeBOh8I6gxgRYih0M0F5n1bP2ah4SA9g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795398060;
	bh=hE5TM3aATQqO3cgkiwDveY601kRIqo+hFAATAVA3c74=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=dE7pEnT6WyeXiOegEbd0AcvddKPupv9JPIjUDida1TeJqIQUHpyiJqqubq9HWZAiv
	 tYEZWVn7dops+1KjB79xcVjARLW6mLXhEuWYRYI6nZ22EGvQstlwlKvDUkwiPSjcR4
	 Q6jsF12Eb7h3y+j+/9+dO495W6btBY82Ju1yUVqLdBBGtqXfvr5igkYN42sfNvnWld
	 P2UKoo2KlZBISKglXzqhDmKtuS5VbFSWiLqYaR57JCs65/jDgUqpJmkUA1X91MX1d1
	 ES5TgvEwMaTzWhGnektNYgcDnypuOlWOXJNbjSdmP8ifotbcQMkscs+WY2bgq7iIZ/
	 snAAG5dFn7LAQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D2995405DE;
	Mon, 23 Nov 2026 01:40:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id AF82F392
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 01:40:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9F9AC60606
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 01:40:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1jNh7dKLIMkZ for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 01:40:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7071160602
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c005::5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c005::5;
 helo=co1pr03cu002.outbound.protection.outlook.com;
 envelope-from=alif.zakuan.yuslaimi@altera.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=s4oHVM8n
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7071160602
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 01:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hE5TM3aATQqO3cgkiwDveY601kRIqo+hFAATAVA3c74=;
 b=s4oHVM8nNirLdkKMYRwK3CjDXp8dKPIegZXMBGU2MphXxgEvYYc2h38vYxUstMbDj7Jj0tYz/D28HJQONMiAOlSQvmZ8TBWuHfaUjEpaaSLYx+4T+FkGAPk1MHl0+0byW3qhHvCNdwHM/Yqej1IymlVTIt0GUF+YkXk7uTM6q2nH1PIsfQ3EE95rjibC/fMO3yqw/+t1KY4Q27SfcAuqh+F+HxqLxpiGB5VGyyHsT4rKcRhkgylpuNhpItJ5h0xgOmKPTAGjF4qAhCrBRQfMY+7T0t68E4Dpb78j8FgWcsMjPLMHo3VXn0emKFVsUMiBcuyWAry1bL7fUrl+X0pERQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by SA6PR03MB8012.namprd03.prod.outlook.com (2603:10b6:806:437::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 01:40:53 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21%4]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 01:40:53 +0000
From: alif.zakuan.yuslaimi@altera.com
To: U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: Tom Rini <trini@konsulko.com>, Jerome Forissier <jerome.forissier@arm.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Romain Gantois <romain.gantois@bootlin.com>, kongchen <3305708832@qq.com>,
 Johan Jonker <jbx6244@gmail.com>, Anshul Dalal <anshuld@ti.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH] net: phy: add MaxLinear MXL86110/MXL86111 driver
Date: Mon, 23 Nov 2026 09:40:37 +0800
Message-ID: <20261123014037.29613-1-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2PR07CA0014.namprd07.prod.outlook.com
 (2603:10b6:a03:505::7) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|SA6PR03MB8012:EE_
X-MS-Office365-Filtering-Correlation-Id: fa85c872-098c-4133-7f9b-08df4902cf3e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|261028144727099003|261026121527099003|261026140227099003|261021121427099003|261022113327099003|261022075727099003|261021123027099003|261022105027099003|261102123227099003|11063799006|56012099006|10067099003|18002099003|261009223027099003|6133799003|55112099003|3023799007;
X-Microsoft-Antispam-Message-Info: vvAS1RLycfgo8bJEDgg8sbE7AK4GC2KmSTpSxh8I3amDIA/5MMKHz6b88GtRJzlq8BdGgELih5pkArV4Ea27dtGKHK8L6v0oZX8d5YId91VC1uoL6xF/wjHm+86VBCy3AZzPwKo/QMxzJW6UCw2y/smwVlJbvBs9hX36vDfV1Fp6JG7uUDt8/ftS45b0okL012UYB0rUdizTkDteFiibHiAevBHBMK/ByItLq1WuGgUQxNNWBeb1HHbKhrgA2wbBkzTH1ySHXmwaFU5MsJusuFFnWCHSfZ3aGzzx+A7wrez2v9Pxsusi1wN8xoyOBw8F7T25F4kxxSjiS+wJ/kHOzgiyNUrlbsQwcH9+qb3o7es0LcgseH9+7thBjJWDHZieFyh8mlCnxaoNLr8fzkJIr8MjrNs7W7oOyMCy2PrWF6A84yvBFZoscDBRxWCTlEdA1Yve8RH0mfmIi7JLK+n050pIHYGMU5VT0CPyewH1272bdl3HIa87Lwgfi+LecAV8RtT/vuqcfcAMFqbfKobgr3gYip+WL2hVWoJetjBGbdE+CQVzb66tkZG0eIkftdbFpHQtD7fPb33qRPzErI2+HWvTrbHansSdcRUuSeWu8so=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(261028144727099003)(261026121527099003)(261026140227099003)(261021121427099003)(261022113327099003)(261022075727099003)(261021123027099003)(261022105027099003)(261102123227099003)(11063799006)(56012099006)(10067099003)(18002099003)(261009223027099003)(6133799003)(55112099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s1uxThNzU0HYBl0GXykBArLDA/rxYZAwmsiMJ471NTxPIKonEWWmU9fSq/I2?=
 =?us-ascii?Q?ClVxfYHlG+3e6WJDHkNsPuyuDk2YSM2oNzFu95Apyev68pkQ+2wH/7dGkOCY?=
 =?us-ascii?Q?pceubn9CvHDHrFn4ffb0r0+tB4kspCMc673hIET1HxdT0bLQcqaINLaT93NH?=
 =?us-ascii?Q?USTOy71bMyWQRBVvY4NBX9MOQK/3zhmioN7BF8OXuTNo10zhXpHHIMOkGNZM?=
 =?us-ascii?Q?BwqxRTtFhrk5vlMRuBoYocUOfvTPZ5uRdCdy15zqT1SFghmcshnHujj8GbYl?=
 =?us-ascii?Q?2Ao2Wm/n6akmuGzS1KYqpRn2Kjk/sVJHP3HxeqtOuyyph8HWXD/Uuy5PEVMR?=
 =?us-ascii?Q?deRI5aSJ1IvHB+Bzs594tAasaXgvU5hGg7p4Fwv6MRU57g78rKSOKUmGCoin?=
 =?us-ascii?Q?mFqNBZENckGh/q1LepxXFAn4uOjGhYvdoCV01CLdieeUKZ4tJ1dxuDKjIrbf?=
 =?us-ascii?Q?XNVEcGD+Cp3zAnnPN5vsAbt5oxdFME5JDXiXWmNo9Gt0b521q7oLM6q5JzUf?=
 =?us-ascii?Q?6eE9MO2sMa7NTYkKWQ4qi7SDAG2k9qzFxFdbML2J8Q3B+7H4XnGR+b06oEMa?=
 =?us-ascii?Q?TOEeKdEMpybsXjGeoosH8ydOe/o1pVAxyc5Pg7vLIQeSjI5mMhVvuqLX/x2g?=
 =?us-ascii?Q?xV3MO/RLBKBw6Q0T0p+fcPvHr6CnOAQ4tRbKn+ecv+loxq46KYdHYe7ZctEE?=
 =?us-ascii?Q?/Y1zst0+H3vUTkKTfcsTrQrY+EssbnN5oKHa/t/hyTZp/1HzJUQB0O2/bI5i?=
 =?us-ascii?Q?x0Kh7qyg/MqARz3cAA2L/2Lh/7/Ebt3TCJAR7YWDUpsROUee34II85nim3FW?=
 =?us-ascii?Q?zAM4VloKrIxBQgc71CUH+Kd3CLx7Tq5vXChRIEDZZrLgnx+uBo56K4gPXWng?=
 =?us-ascii?Q?PyZ11zXYcVL0Rkt6IiJBN6HR+rs72G1ymrRAD881cGbinzhTcsS/R8hH0PhF?=
 =?us-ascii?Q?wGWuxGlEif8aZcqdZPbrvtVsNeHehwz7UUOqDFQ1/d4vEaU8zkXa39SK02Zx?=
 =?us-ascii?Q?b+qBozNjiKBcB5wKrE1AeBB3pcln5uN1ykbA4fArt2RxpslPbcTGWkCKT9La?=
 =?us-ascii?Q?2kQ8zh28fYWTbgRy9nI5qy+vZdz/FOTNihJ+6aeJIGvCAKMzIAv7GRTmiKvR?=
 =?us-ascii?Q?KHkLwbH83aH2bW8FLmjCWmI1lhueE/v9yIgc8ZfkXvwE8bYKquJ43tKf7Hh4?=
 =?us-ascii?Q?axI5UAnja05fUCVdHqp5XW5PJh1Z15auTeRtpNJjEEQnmnArtVDIgdNMhcm1?=
 =?us-ascii?Q?bY15ec/ekW/obmQGvES4JRHd49xyofjGQnHk9DwfCo3+AEzJujpE1YIPEMQU?=
 =?us-ascii?Q?HNLugizep0RCAlb1JtcdapVouj0dCLmefGJqpKq30Cl3ElQYctEDH2xORtjM?=
 =?us-ascii?Q?/kO5mi6pS/+4Oix2lXqLJ8DzRFzBD66w39FDNF3pZwzl1LQ8qegTCcQpBbI7?=
 =?us-ascii?Q?NO3tMbhW2Bm4gwA0exAsGqACiQzj0Pzdb5H1jRhalJsvkaPdGcWtYgqFdfB0?=
 =?us-ascii?Q?+cqyu35iRfZ2Ak9lhNMpl6PT7PZEp+brgU4349TQIBYPna2G9p6yBGJPnle0?=
 =?us-ascii?Q?103C261oLeYsIYUexEHzMLZKJLHg/E0D8AOEL6GSgqiN/W3QPxVjl9ym1fMc?=
 =?us-ascii?Q?vz/fBcTLx+AZdI7vfdEy3XAuAJ4FdnKD8eOluVbnJegu8C7DKqMlQGDcp+L6?=
 =?us-ascii?Q?+DHh44TIJ1m/ltNVrcEJyyr1OhsmcWJeYfjYa+2pFfZcokk9bTRCUFuPM5QF?=
 =?us-ascii?Q?Oqgc8oDdKExWRr3M5ns1ssaUACDnFgY=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa85c872-098c-4133-7f9b-08df4902cf3e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 01:40:52.9191 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gNVVbW3TWI2/ZwBTc/cLn+5LOOBFjXw1G2f1I9CL8eu8cTD5aR4uznPasQf/T1lLxiEtnTW0YzgN+plmi+3s92KMuRxnnUNIBNEdmMQTbCQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR03MB8012
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>

Port the Linux mxl-86110 PHY driver to U-Boot with RGMII delay,
SyncE clock, LED activity blink, and MDIO broadcast disable.

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 drivers/net/MAINTAINERS    |   5 +
 drivers/net/phy/Kconfig    |   6 +
 drivers/net/phy/Makefile   |   1 +
 drivers/net/phy/mxl86110.c | 382 +++++++++++++++++++++++++++++++++++++
 4 files changed, 394 insertions(+)
 create mode 100644 drivers/net/phy/mxl86110.c

diff --git a/drivers/net/MAINTAINERS b/drivers/net/MAINTAINERS
index fd002295d0c..fb377e15da9 100644
--- a/drivers/net/MAINTAINERS
+++ b/drivers/net/MAINTAINERS
@@ -4,3 +4,8 @@ S:	Supported
 F:	drivers/net/dwc_eth_xgmac.c
 F:	drivers/net/dwc_eth_xgmac.h
 F:	drivers/net/dwc_eth_xgmac_socfpga.c
+
+NETWORK PHY MAXLINEAR
+M:	Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
+S:	Supported
+F:	drivers/net/phy/mxl86110.c
diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 02aeb1db977..958484ba504 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -250,6 +250,12 @@ config PHY_MSCC
 	depends on !COMPILE_TEST
 	bool "Microsemi Corp Ethernet PHYs support"
 
+config PHY_MXL86110
+	bool "MaxLinear MXL86110/MXL86111 Ethernet PHYs"
+	help
+	  Enable support for MaxLinear MXL86110 and MXL86111 Gigabit
+	  Ethernet PHYs.
+
 config PHY_NATSEMI
 	bool "National Semiconductor Ethernet PHYs support"
 
diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index bd57fa005b1..541d5111490 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -28,6 +28,7 @@ obj-$(CONFIG_PHY_MICREL_KSZ8XXX) += micrel_ksz8xxx.o
 obj-$(CONFIG_PHY_MICREL_KSZ90X1) += micrel_ksz90x1.o
 obj-$(CONFIG_PHY_MESON_GXL) += meson-gxl.o
 obj-$(CONFIG_PHY_MOTORCOMM) += motorcomm.o
+obj-$(CONFIG_PHY_MXL86110) += mxl86110.o
 obj-$(CONFIG_PHY_NATSEMI) += natsemi.o
 obj-$(CONFIG_PHY_NXP_C45_TJA11XX) += nxp-c45-tja11xx.o
 obj-$(CONFIG_PHY_NXP_TJA11XX) += nxp-tja11xx.o
diff --git a/drivers/net/phy/mxl86110.c b/drivers/net/phy/mxl86110.c
new file mode 100644
index 00000000000..37fcd2fe4ae
--- /dev/null
+++ b/drivers/net/phy/mxl86110.c
@@ -0,0 +1,382 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Altera Corporation <www.altera.com>
+ *
+ * PHY driver for MaxLinear MXL86110 / MXL86111. Ported from Linux
+ * drivers/net/phy/mxl-86110.c
+ *
+ */
+
+#include <log.h>
+#include <phy.h>
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/errno.h>
+
+/* PHY IDs */
+#define PHY_ID_MXL86110				0xc1335580
+#define PHY_ID_MXL86111				0xc1335588
+#define PHY_ID_MXL_MASK				0xfffffff0
+
+/* Extended register access window (same style as Motorcomm YT* PHYs) */
+#define MXL86110_EXTD_REG_ADDR_OFFSET		0x1E
+#define MXL86110_EXTD_REG_ADDR_DATA		0x1F
+
+/* SyncE Configuration Register - COM_EXT_SYNCE_CFG */
+#define MXL86110_EXT_SYNCE_CFG_REG		0xA012
+#define MXL86110_EXT_SYNCE_CFG_CLK_FRE_SEL	BIT(4)
+#define MXL86110_EXT_SYNCE_CFG_EN_SYNC_E	BIT(6)
+#define MXL86110_EXT_SYNCE_CFG_CLK_SRC_SEL_MASK	GENMASK(3, 1)
+#define MXL86110_EXT_SYNCE_CFG_CLK_SRC_SEL_25M	4
+
+/* Chip Configuration Register - COM_EXT_CHIP_CFG */
+#define MXL86110_EXT_CHIP_CFG_REG		0xA001
+#define MXL86110_EXT_CHIP_CFG_RXDLY_ENABLE	BIT(8)
+
+/* RGMII Config1 */
+#define MXL86110_EXT_RGMII_CFG1_REG		0xA003
+/* delay can be adjusted in steps of about 150ps */
+#define MXL86110_EXT_RGMII_CFG1_RX_NO_DELAY	(0x0 << 10)
+/* Closest value to 2000 ps */
+#define MXL86110_EXT_RGMII_CFG1_RX_DELAY_1950PS	(0xD << 10)
+#define MXL86110_EXT_RGMII_CFG1_RX_DELAY_MASK	GENMASK(13, 10)
+#define MXL86110_EXT_RGMII_CFG1_TX_1G_DELAY_1950PS	(0xD << 0)
+#define MXL86110_EXT_RGMII_CFG1_TX_1G_DELAY_MASK	GENMASK(3, 0)
+#define MXL86110_EXT_RGMII_CFG1_TX_10MB_100MB_DELAY_1950PS	(0xD << 4)
+#define MXL86110_EXT_RGMII_CFG1_TX_10MB_100MB_DELAY_MASK	GENMASK(7, 4)
+#define MXL86110_EXT_RGMII_CFG1_FULL_MASK \
+	(MXL86110_EXT_RGMII_CFG1_RX_DELAY_MASK | \
+	 MXL86110_EXT_RGMII_CFG1_TX_1G_DELAY_MASK | \
+	 MXL86110_EXT_RGMII_CFG1_TX_10MB_100MB_DELAY_MASK)
+
+/* RGMII MDIO / broadcast */
+#define MXL86110_EXT_RGMII_MDIO_CFG		0xA005
+#define MXL86110_RGMII_MDIO_CFG_EPA0_MASK	BIT(6)
+
+/* LED (optional activity blink) */
+#define MXL86110_MAX_LEDS			3
+#define MXL86110_LED0_CFG_REG			0xA00C
+#define MXL86110_LEDX_CFG_BLINK			BIT(13)
+
+/* PHY specific status (used by several Alaska-class PHYs) */
+#define MXL86110_PHY_STAT_REG			0x11
+#define MXL86110_PHY_STAT_SPEED_MASK		GENMASK(15, 14)
+#define MXL86110_PHY_STAT_SPEED_10M		0x0
+#define MXL86110_PHY_STAT_SPEED_100M		0x1
+#define MXL86110_PHY_STAT_SPEED_1000M		0x2
+#define MXL86110_PHY_STAT_DPX			BIT(13)
+#define MXL86110_PHY_STAT_LINK			BIT(10)
+
+/*
+ * Digital RGMII delay codes: field value i selects ~150 ps * i, so the table
+ * maps a picosecond request from the device tree onto the nearest code.
+ */
+static const int mxl86110_rgmii_delays[] = {
+	0, 150, 300, 450, 600, 750, 900, 1050,
+	1200, 1350, 1500, 1650, 1800, 1950, 2100, 2250,
+};
+
+static int mxl86110_write_extended_reg(struct phy_device *phydev, u16 regnum,
+				       u16 val)
+{
+	int ret;
+
+	ret = phy_write(phydev, MDIO_DEVAD_NONE, MXL86110_EXTD_REG_ADDR_OFFSET,
+			regnum);
+	if (ret < 0)
+		return ret;
+
+	return phy_write(phydev, MDIO_DEVAD_NONE, MXL86110_EXTD_REG_ADDR_DATA,
+			 val);
+}
+
+static int mxl86110_read_extended_reg(struct phy_device *phydev, u16 regnum)
+{
+	int ret;
+
+	ret = phy_write(phydev, MDIO_DEVAD_NONE, MXL86110_EXTD_REG_ADDR_OFFSET,
+			regnum);
+	if (ret < 0)
+		return ret;
+
+	return phy_read(phydev, MDIO_DEVAD_NONE, MXL86110_EXTD_REG_ADDR_DATA);
+}
+
+static int mxl86110_modify_extended_reg(struct phy_device *phydev, u16 regnum,
+					u16 mask, u16 set)
+{
+	int val;
+
+	val = mxl86110_read_extended_reg(phydev, regnum);
+	if (val < 0)
+		return val;
+
+	val = (val & ~mask) | set;
+
+	return mxl86110_write_extended_reg(phydev, regnum, val);
+}
+
+static int mxl86110_synce_clk_cfg(struct phy_device *phydev)
+{
+	u16 mask, val;
+
+	/*
+	 * Default SyncE / clk output per Linux driver datasheet defaults:
+	 * enable SyncE and select 25 MHz clock source.
+	 */
+	val = MXL86110_EXT_SYNCE_CFG_EN_SYNC_E |
+	      FIELD_PREP(MXL86110_EXT_SYNCE_CFG_CLK_SRC_SEL_MASK,
+			 MXL86110_EXT_SYNCE_CFG_CLK_SRC_SEL_25M);
+	mask = MXL86110_EXT_SYNCE_CFG_EN_SYNC_E |
+	       MXL86110_EXT_SYNCE_CFG_CLK_SRC_SEL_MASK |
+	       MXL86110_EXT_SYNCE_CFG_CLK_FRE_SEL;
+
+	return mxl86110_modify_extended_reg(phydev, MXL86110_EXT_SYNCE_CFG_REG,
+					    mask, val);
+}
+
+static int mxl86110_broadcast_cfg(struct phy_device *phydev)
+{
+	/* Disable MDIO broadcast (clear EPA0) */
+	return mxl86110_modify_extended_reg(phydev, MXL86110_EXT_RGMII_MDIO_CFG,
+					    MXL86110_RGMII_MDIO_CFG_EPA0_MASK,
+					    0);
+}
+
+static int mxl86110_enable_led_activity_blink(struct phy_device *phydev)
+{
+	int i, ret = 0;
+
+	for (i = 0; i < MXL86110_MAX_LEDS; i++) {
+		ret = mxl86110_modify_extended_reg(phydev,
+						   MXL86110_LED0_CFG_REG + i,
+						   0, MXL86110_LEDX_CFG_BLINK);
+		if (ret < 0)
+			break;
+	}
+
+	return ret;
+}
+
+/**
+ * mxl86110_get_internal_delay() - map DT *-internal-delay-ps to delay index
+ * @phydev: PHY device
+ * @is_rx: true for rx-internal-delay-ps, false for tx-internal-delay-ps
+ *
+ * U-Boot stand-in for Linux phy_get_internal_delay(). Returns the index into
+ * mxl86110_rgmii_delays, or a negative errno if the property is absent/invalid.
+ */
+static int mxl86110_get_internal_delay(struct phy_device *phydev, bool is_rx)
+{
+	ofnode node = phy_get_ofnode(phydev);
+	const char *prop = is_rx ? "rx-internal-delay-ps" :
+				   "tx-internal-delay-ps";
+	u32 delay;
+	int i, ret;
+
+	if (!ofnode_valid(node))
+		return -ENODEV;
+
+	ret = ofnode_read_u32(node, prop, &delay);
+	if (ret)
+		return ret;
+
+	if (delay < mxl86110_rgmii_delays[0] ||
+	    delay > mxl86110_rgmii_delays[ARRAY_SIZE(mxl86110_rgmii_delays) - 1]) {
+		pr_err("%s: %s %u out of range\n", phydev->drv->name, prop,
+		       delay);
+		return -EINVAL;
+	}
+
+	if (delay == mxl86110_rgmii_delays[0])
+		return 0;
+
+	for (i = 1; i < ARRAY_SIZE(mxl86110_rgmii_delays); i++) {
+		if (delay == mxl86110_rgmii_delays[i])
+			return i;
+
+		if (delay > mxl86110_rgmii_delays[i - 1] &&
+		    delay < mxl86110_rgmii_delays[i]) {
+			if (delay - mxl86110_rgmii_delays[i - 1] <
+			    mxl86110_rgmii_delays[i] - delay)
+				return i - 1;
+			return i;
+		}
+	}
+
+	pr_err("%s: error finding internal delay index for %u\n",
+	       phydev->drv->name, delay);
+	return -EINVAL;
+}
+
+/**
+ * mxl86110_config_rgmii_delay() - program digital RGMII TX/RX delays
+ *
+ * phy-mode sets the default digital delays, then optional
+ * rx/tx-internal-delay-ps overrides the field codes. When
+ * rx-internal-delay-ps is present, clear CHIP_CFG RXDLY_ENABLE so
+ * only the programmed digital RX delay is used.
+ */
+static int mxl86110_config_rgmii_delay(struct phy_device *phydev)
+{
+	int rx_delay;
+	int tx_delay;
+	u16 val;
+	int ret;
+
+	/* Digital delay codes implied by the phy-mode. */
+	switch (phydev->interface) {
+	case PHY_INTERFACE_MODE_RGMII:
+		val = 0;
+		break;
+	case PHY_INTERFACE_MODE_RGMII_RXID:
+		val = MXL86110_EXT_RGMII_CFG1_RX_DELAY_1950PS;
+		break;
+	case PHY_INTERFACE_MODE_RGMII_TXID:
+		val = MXL86110_EXT_RGMII_CFG1_TX_1G_DELAY_1950PS |
+		      MXL86110_EXT_RGMII_CFG1_TX_10MB_100MB_DELAY_1950PS;
+		break;
+	case PHY_INTERFACE_MODE_RGMII_ID:
+		val = MXL86110_EXT_RGMII_CFG1_TX_1G_DELAY_1950PS |
+		      MXL86110_EXT_RGMII_CFG1_TX_10MB_100MB_DELAY_1950PS |
+		      MXL86110_EXT_RGMII_CFG1_RX_DELAY_1950PS;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/*
+	 * Explicit rx/tx-internal-delay-ps bindings, when present, override the
+	 * phy-mode defaults so a board can pin the exact digital delay code.
+	 */
+	rx_delay = mxl86110_get_internal_delay(phydev, true);
+	if (rx_delay >= 0) {
+		val &= ~MXL86110_EXT_RGMII_CFG1_RX_DELAY_MASK;
+		val |= FIELD_PREP(MXL86110_EXT_RGMII_CFG1_RX_DELAY_MASK,
+				  rx_delay);
+	}
+
+	tx_delay = mxl86110_get_internal_delay(phydev, false);
+	if (tx_delay >= 0) {
+		val &= ~(MXL86110_EXT_RGMII_CFG1_TX_1G_DELAY_MASK |
+			 MXL86110_EXT_RGMII_CFG1_TX_10MB_100MB_DELAY_MASK);
+		val |= FIELD_PREP(MXL86110_EXT_RGMII_CFG1_TX_1G_DELAY_MASK,
+				  tx_delay) |
+		       FIELD_PREP(MXL86110_EXT_RGMII_CFG1_TX_10MB_100MB_DELAY_MASK,
+				  tx_delay);
+	}
+
+	ret = mxl86110_modify_extended_reg(phydev, MXL86110_EXT_RGMII_CFG1_REG,
+					   MXL86110_EXT_RGMII_CFG1_FULL_MASK,
+					   val);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * RXDLY_ENABLE (CHIP_CFG) adds a fixed ~2 ns to RX_CLK on top of the
+	 * digital delay above. When rx-internal-delay-ps is set we drive RX
+	 * delay digitally, so clear it; otherwise leave it as strapped.
+	 */
+	if (rx_delay >= 0)
+		return mxl86110_modify_extended_reg(phydev,
+						    MXL86110_EXT_CHIP_CFG_REG,
+						    MXL86110_EXT_CHIP_CFG_RXDLY_ENABLE,
+						    0);
+
+	return 0;
+}
+
+static int mxl86110_config(struct phy_device *phydev)
+{
+	int ret;
+
+	ret = mxl86110_synce_clk_cfg(phydev);
+	if (ret < 0)
+		return ret;
+
+	if (phy_interface_is_rgmii(phydev)) {
+		ret = mxl86110_config_rgmii_delay(phydev);
+		if (ret < 0)
+			return ret;
+	}
+
+	ret = mxl86110_enable_led_activity_blink(phydev);
+	if (ret < 0)
+		return ret;
+
+	ret = mxl86110_broadcast_cfg(phydev);
+	if (ret < 0)
+		return ret;
+
+	ret = phy_reset(phydev);
+	if (ret < 0)
+		return ret;
+
+	return genphy_config_aneg(phydev);
+}
+
+static int mxl86110_parse_status(struct phy_device *phydev)
+{
+	int val;
+	u16 speed;
+
+	val = phy_read(phydev, MDIO_DEVAD_NONE, MXL86110_PHY_STAT_REG);
+	if (val < 0)
+		return val;
+
+	if (val & MXL86110_PHY_STAT_LINK)
+		phydev->link = 1;
+	else
+		phydev->link = 0;
+
+	if (val & MXL86110_PHY_STAT_DPX)
+		phydev->duplex = DUPLEX_FULL;
+	else
+		phydev->duplex = DUPLEX_HALF;
+
+	speed = FIELD_GET(MXL86110_PHY_STAT_SPEED_MASK, val);
+	switch (speed) {
+	case MXL86110_PHY_STAT_SPEED_1000M:
+		phydev->speed = SPEED_1000;
+		break;
+	case MXL86110_PHY_STAT_SPEED_100M:
+		phydev->speed = SPEED_100;
+		break;
+	default:
+		phydev->speed = SPEED_10;
+		break;
+	}
+
+	return 0;
+}
+
+static int mxl86110_startup(struct phy_device *phydev)
+{
+	int ret;
+
+	ret = genphy_update_link(phydev);
+	if (ret)
+		return ret;
+
+	return mxl86110_parse_status(phydev);
+}
+
+U_BOOT_PHY_DRIVER(mxl86110) = {
+	.name = "MXL86110 Gigabit Ethernet",
+	.uid = PHY_ID_MXL86110,
+	.mask = PHY_ID_MXL_MASK,
+	.features = PHY_GBIT_FEATURES,
+	.config = &mxl86110_config,
+	.startup = &mxl86110_startup,
+	.shutdown = &genphy_shutdown,
+};
+
+U_BOOT_PHY_DRIVER(mxl86111) = {
+	.name = "MXL86111 Gigabit Ethernet",
+	.uid = PHY_ID_MXL86111,
+	.mask = PHY_ID_MXL_MASK,
+	.features = PHY_GBIT_FEATURES,
+	.config = &mxl86110_config,
+	.startup = &mxl86110_startup,
+	.shutdown = &genphy_shutdown,
+};
-- 
2.43.7

