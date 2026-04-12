Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEBB5E93802
	for <u-boot@archiver.kernel.org>; Sun, 12 Apr 2026 20:00:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84FA783B99;
	Sun, 12 Apr 2026 22:00:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="Sz5gADdj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 595758352B; Sun, 12 Apr 2026 22:00:00 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CA028352B
 for <u-boot@lists.denx.de>; Sun, 12 Apr 2026 21:59:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KfT9nCD+63iSYEcAdBCmztzXB3u/Dar+PQnSvkqB5DskOnTP5uYiSwVT+li5J8ZDOrlhsyJX3gSab6GM4QS9fz4ylFvQa/mRnQK3/FC7vxW//CO8/nS8SYn3eZuZ3kIuNff3S9IeWaY/qvyQ4UyGGi+RdkfDUpCQ+omqPkHzWAfg+iNQCU8+v1FvynUKxeaHh+bnkHzhjTom4NhcGMfz1Ifxmh4c5/dSq7EKnbgeS8siOMax8FsmpfiKRsw4a9W1sy/AUdZGCxJxKi9lEKtwQXRFkEePhJJ1dezZo5x3tGbiTKeNlXO39VPItkVr8fM1RpZhld8O5thY2AHOgM/nAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wRIxXG1SlqZgwkSxjR4ooKM0EXIuhP3AGbGLZfob4ss=;
 b=r82dBC+h6JeI/Bcl7zwQYXvxQuVyoBmCLcy2U40blLss5QPezL0r/6eTt6/Ej5+D00sFom5q1KECY44INT34LUAAJGfem0m7wE56d9rpHXVT3G4+8zc2qRCMGniVwLr4t1Oq0ZUCT++cYRfFEIEajDSzVpO6H2h9wDqJEfdnhs8Ei9V5XQRmnw8dV0jdxE3UEKrI3k7BURLJ3tUJUUfp9XvKEfrgHZQDmPwnhbQiiUJslX1NEL3z2nuABfaO04dGF59YYRXx7QKgr4D9ggYISZ2sNdbFyml49CFeZJxB7UNrd8ivj2AE52cpIrMpPfR6zIQYbE/V3Ute8xYlEo4CBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wRIxXG1SlqZgwkSxjR4ooKM0EXIuhP3AGbGLZfob4ss=;
 b=Sz5gADdjKhhSvZsRi+fZ8684Xxf0BpFPO2V+duoY6dfADKSY7cIxfELtnUaMeLGUeC6RTD2ECBFiZcFilTh1nLPXltN2GePZTTa+moRM+eu8kWWJaSfUbNov+Oa7L0S8vMLhDFiHStp4u0Mu7PycK8XkHcgAXJSWiZitVJ29ufc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by GV2PR10MB9930.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:341::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Sun, 12 Apr
 2026 19:59:56 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%5]) with mapi id 15.20.9769.046; Sun, 12 Apr 2026
 19:59:56 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 2/8] stdio: drop stdio_clone
Date: Sun, 12 Apr 2026 21:59:41 +0200
Message-ID: <20260412195947.1982729-3-ravi@prevas.dk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260412195947.1982729-1-ravi@prevas.dk>
References: <20260412195947.1982729-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CPBP307CA0015.DNKP307.PROD.OUTLOOK.COM (2603:10a6:380:2::9)
 To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|GV2PR10MB9930:EE_
X-MS-Office365-Filtering-Correlation-Id: bdb9c9c2-7b3f-47fd-19dc-08de98ce11c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|38350700014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 55fst0JbUNzp73CLY8gaW5USQAzC4S9wVWnVQ+ZfeDTm2pzfocL/LYBIpZQxMHL80ggPjLJtWn8864ZjQouzwZeO2hRxsoDQdkaVLaOkUjSX80i2RqUlm5PSjP2zDHbNyNk7NMDagHa1Krd95b0AUGCTa+N7my5YOM1I/Z2gAyp4dju1stUWdP4ZvXenwCKeuGcya4Uq+8mKUFnZ7krjv+l59WcWhqRZzgLDpdkmcVAd07c/Un1E2mX5UXv2FduFxXckzVXXbR+8kNQg4b3pn3QBPIegJdAxmIwpMYqD1pPe7BuSuUkSzW3IGFg2DqvMCmPpatgFbDoDHUKKX6/0g7SOblQ32sb8GRjz8pk4ba/XSrTJAJqaJ5YZk0w6wvMa7v7yvAaOLiPRIhqoQtqz6ONaShOvdJfSzNfLmETfPruEpSQkFjRkp1szwoz3GoAHJ2oz1tYFS8riTtzs84kPxY7vQbzUv1LlDeat2d5uvo1xanhEbBeFHhecmcGCJyWHvtv+h3OeJhXF76Nt4iG6H7BBvo02jkTsiCM3IXuO7aZidywoviSO6/kd/JiaNrjIdWq85webB7GRkq8pNkFALbX2VgG6+6UFQ47YvPUExFelsBNf1US4k3/1hGrF9SWqqrfx/egJFC4aPD2Kg5gEW0m6P+KGUdYfxClgvCJAyhRYvQakcFZGBQkRc6pME/H75Hy5Zh+OWqvxFeKb/ABVjqO8dUrSvTmgcSMy3JvUxJT9y8PT8H1MuLrtGh3S7P761I4ZCQ/+L2sm3P8iJm6Cv9V1iWUYIQJuVSe7etCZRt0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aLWGYEbjQHd0zOWLBJ56fZ7ZJd0KFXQkNfElTc3tFRn/KzdX7JTmTS01QoXM?=
 =?us-ascii?Q?eqvJVFdeli9Z7vaoQivDXpjpVcjPqHQAI8Xo/nizRjXuPnvaAU5qWmZoh7gc?=
 =?us-ascii?Q?DmSH9VqwXY+0NTe5IA0O52Wf3TWy36VED226HKLsV5r8ItvlJBqBqnMiz09f?=
 =?us-ascii?Q?/k6k/fqIFTtvRLIgrxQh90Xq+tVFOnFXgWzk4p8hCilXLX8P3JzckOu/AWEH?=
 =?us-ascii?Q?IWVgifLdVUav/iJdA7RZBdfohMwnevDCa8Tn7LfbYZN3b0T2Yd1CqTcBXSVM?=
 =?us-ascii?Q?xU9naNxrsQD/4aFZ8ImIdWFabDzGq47+ntp4xYEn9N5yF7nIDWcp6X0iT/fL?=
 =?us-ascii?Q?J/lrkLwG0skiQ2PhAHVCoXUwafgl7ggtx0mWyRxAD+6qcFP9b+DYQxBlldQy?=
 =?us-ascii?Q?5Hk1HSNk+QLqaccIxc/Ttn9Jv2AazUTq5Ov1gAGumtafw040Fw5xbG74A2O/?=
 =?us-ascii?Q?bhYGVTlABQlCN9ta5W6wEu+FmEs7UTXlzgiizR1UpU4nFiCy2gKxwUBWJ27d?=
 =?us-ascii?Q?FofUb5urWaWvzuIA6Wkp63Vm+a1l0a4OgsGF1JVHLwx8790jqfkC+XAiP7I0?=
 =?us-ascii?Q?vCsMnT/ZFQPf8SyrmyST6N4LHlG1gryAB6fKGE8KCJVbT4QFPJRQLOxzYzB0?=
 =?us-ascii?Q?OKPdODrwIosSRCexSkcUz0PJyNYw/3YN6QN1rzn0ZutO8AUlIo125/L6XCKG?=
 =?us-ascii?Q?1f6NeZhvPx+sD2zaaxk/iZuUdNP8FVx2Go69Dgx8uIovePW4MEgTvIaDMYy7?=
 =?us-ascii?Q?tTqbhQYCAGcI5AqcjNFrkbgQ/N28NUn/qS1YJtc77rY7wdMB/iP7El44XIHG?=
 =?us-ascii?Q?rdFHT/QXQfeN9QwGehB0+CYiHg/BM1hVKeiwqIDsZychUOoRqHmBJqexfkAy?=
 =?us-ascii?Q?hdvak87sUMBRi19uUiibY3EdsU44mi7OkqgN73DCN3FkeqETsDke7QDCVBOS?=
 =?us-ascii?Q?hQ00n3MxZfuZ4Zpd4ArJnJOWQk1caCVWxyXPvjtp3IZR/EAI1Qj+r6fg2gaS?=
 =?us-ascii?Q?WEIHCSSzmjPLpCK+4dh+mOib//f/mODKQjCEDm7vKK1ZtEHN2yp1GrSIHKPD?=
 =?us-ascii?Q?y/iIuqzM5gSDxD4oeCvHTVblmU/2GcEvRYmdl2dyEWb7wqGbye6ZuI/RRCw2?=
 =?us-ascii?Q?RH2sC4jRD2diYhtFErgVJ9grWn2xn1OL8rxD6yWGs8UxZBMn+fK++uOth08L?=
 =?us-ascii?Q?Veqg53IYZlkzbsQGUfIUJvqcvxm1kYvnFITMGKSFSF7avNSB5HhFNyeI66x0?=
 =?us-ascii?Q?cti9PZ9PMZiXnA/oLX9w2oTJQCL7BYsAOwvQI1TDeYv01NbC6sGMMEUATrNh?=
 =?us-ascii?Q?0X0AnINX6Lpwn75QS6u5VN2RlX5SAGH4kW10SimFrNMVQysJpjxMXwX8+Ck3?=
 =?us-ascii?Q?hQc6EpG8hOYMxrK4HqfSrXwanGxgKP5kkT4S1qzNrlK9vGke6FzoRv/cboNa?=
 =?us-ascii?Q?p4aboFMeC9uwHUJALo2Uvmcffp7HWJxVjMjyQU23l86Hk04Ye1xpmgnIATkY?=
 =?us-ascii?Q?xbndGCOUtIJ9y4bVwl+EtnjBSwoSXiwdigTpwIL5efkhyHV8LJlpJ0mYWdis?=
 =?us-ascii?Q?9PpxFhQzl6JR5OkHeV6O4YjIJPD0wGXl9heKwp08VlBoRaFTb+mzznn1Cj0c?=
 =?us-ascii?Q?MHUvPVLCmko+8+iNsNVld5qGO2PMXoViTcinQg116uXpBs/odhAlqEP+cGM1?=
 =?us-ascii?Q?nsUrQ0SK02eik7Qf0xuYYLsGZnhsY5s67QMhgBlZkjPwmkLjLUfLjLUqWhSC?=
 =?us-ascii?Q?IpuHQGASQdR8TIto1L51boxFqmUnnX8=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: bdb9c9c2-7b3f-47fd-19dc-08de98ce11c9
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2026 19:59:56.3105 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HiUC5ek4sbdaHzAwPzldZ8ywkP8potG6o9TgjAZdPx8KVji+B2bwJvjzTr8DdkuoBOF1t2ggmBpXqnS3kbak2Z5HPFaQWKG/f0dEbpTtUc4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB9930
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

The helper stdio_clone only has a single caller, so it certainly
doesn't need to be public. But in fact, it is merely an open-coded
memdup() - which for some reason uses calloc() even if the whole
allocation is obviously immediately overwritten.

Drop it and just use memdup() directly.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 common/stdio.c      | 18 +-----------------
 include/stdio_dev.h |  1 -
 2 files changed, 1 insertion(+), 18 deletions(-)

diff --git a/common/stdio.c b/common/stdio.c
index fc965944209..038e576147b 100644
--- a/common/stdio.c
+++ b/common/stdio.c
@@ -217,27 +217,11 @@ struct stdio_dev *stdio_get_by_name(const char *name)
 	return NULL;
 }
 
-struct stdio_dev *stdio_clone(struct stdio_dev *dev)
-{
-	struct stdio_dev *_dev;
-
-	if (!dev)
-		return NULL;
-
-	_dev = calloc(1, sizeof(struct stdio_dev));
-	if (!_dev)
-		return NULL;
-
-	memcpy(_dev, dev, sizeof(struct stdio_dev));
-
-	return _dev;
-}
-
 int stdio_register_dev(struct stdio_dev *dev, struct stdio_dev **devp)
 {
 	struct stdio_dev *_dev;
 
-	_dev = stdio_clone(dev);
+	_dev = memdup(dev, sizeof(*dev));
 	if (!_dev)
 		return -ENODEV;
 	list_add_tail(&_dev->list, &devs.list);
diff --git a/include/stdio_dev.h b/include/stdio_dev.h
index f7f9c10199e..d93604331ff 100644
--- a/include/stdio_dev.h
+++ b/include/stdio_dev.h
@@ -96,7 +96,6 @@ int stdio_add_devices(void);
 int stdio_deregister_dev(struct stdio_dev *dev, int force);
 struct list_head *stdio_get_list(void);
 struct stdio_dev *stdio_get_by_name(const char *name);
-struct stdio_dev *stdio_clone(struct stdio_dev *dev);
 
 int drv_lcd_init(void);
 int drv_video_init(void);
-- 
2.53.0

