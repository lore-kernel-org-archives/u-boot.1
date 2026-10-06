Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D3B6CA5FF0
	for <u-boot@archiver.kernel.org>; Tue,  6 Oct 2026 13:00:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D10F2607C0;
	Tue,  6 Oct 2026 13:00:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uzaeKou4p-ib; Tue,  6 Oct 2026 13:00:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 0AB7D606D9
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791291627;
	b=MYSbG5f5/79y9VfNJN93+Zlsoqxj3UahPjbCanoU2JopRpR1tBtwjxhR51+WY3449eUx
	 mTf2e6O7qpe8ddhfKJCHRXVYdpTwzzdCJP7PCEFBVbZT5k7I8XKsWcAOQ9ZR8x3WQjGfz
	 /s+vDGMcCXBpuvF1Un4xIY8RxiNRylAq1MEkj47ave7Dk2D5O/FECRHnezny9F8kNmXwO
	 MUjgbdZMSmhSONgz5njtjkwhbVTtdLh57jGoybYJGTgzYjXoZNYBtJE/H7FbIZbTz+BX/
	 36PSpOpMHzG8croU303O3hVRrdANBefkLYu/dDkawVaxAPEiFiv+wzLN+8CN9RsGN5w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791291627;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
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
	bh=O8ETpjIeRPTwKFRhTdLT0zJXXwuHHXz2MTMS+yIxhuI=;
	b=kK13oCNbLGx/+fsENob1boDT/6cjb6FOqqMmMm+L3THDqtUBSf7ZGiv494McMdEbWhVU
	 rCyE1PJes8Jd9EsP5pexaMVDUeLzK5ZN9wSTiHXFOt8p2hgwR4ZTfoPsPPxV2+SHFIXUF
	 Ec7XmdKGqAAl8C3j+nLqa8GFDP3jKJ2BB4hnvWaqDQzBg1EipJWJFii4ujzo+E0NRaWo2
	 r6BA38Hqbw3szTqj8gtRcykRVP9OygG3N9KuXSdQ+yhSDPzv1LOo4kXp9zLOGDTlltrpG
	 s5PHjiMKmQJj4VzYPyd0LKxB41FXzPYp92/ENlFnnULXWByGrT5GyK7fkrlKyzdjP8A==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791291627;
	bh=O8ETpjIeRPTwKFRhTdLT0zJXXwuHHXz2MTMS+yIxhuI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OzJNmyWBhVUpwyKUv30H+jBfif8USFT3R0QoqTViF5E0a8GCy7aGKkcgRg4QggDHR
	 8wLu2veSVIKvtPSVjSflnqmJ0gACZv7YSJxBq/weLBHjGAz1baDg2sPhzAHWDDSxb3
	 utzMzOb/RIzN3/Z3fZalandKVOddgF0zgqAL3c3csRAXWIGaJ+A04zWsWFNmTkxnBI
	 8Op+P1+aZcMjei6B0nQ3gK+HJy1Inn8cT7YTL42BOtynEQJn8RBUcCc9x3sX5X5z3/
	 W1UqN72a2qjeNIfS7IANgDtjVor8y6NtKFoRvPHrauosftO5NeA/PEH9NH1SUTI8ln
	 hpbplOE1aYD4Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0AB7D606D9;
	Tue,  6 Oct 2026 13:00:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id B5E4C282
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 09:28:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9AD8940563
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 09:28:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uHwEqPaE4JEw for <u-boot@lists.u-boot-project.org>;
 Tue,  6 Oct 2026 09:28:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 2B7E54053D
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c207::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791278932;
 b=ZweIIh6HvPNn5YZuUk4Wod7yFM1ua2Bm6Y97JYdDJaElp7BCRFQNPktNB/KnpwDCHA6d
 AKqPtUS72S+iX6o6z8NMuXKe5PsxBbKa49Uml6F8ZfRLTo/ftXSqAidH6JYXpDPjFzBtL
 /9WDTkxq0W3qKYpyk6ICCQSVvbV8i8PklEiJKzmZADEyX+sbA6SJbmKGkETUGFJ3hO7br
 0mQWRHiWSVJ7aYOVH8Prc+0kTMLIqjfQzSdDbsbOfcNqjqQ8OZ5+p/npPyhzmb3imBn8a
 CUjlJrdKhepFNd4IFau7/VBZFFrh/XcSSVq1yfIHL/SoC92PA+olHUVwYAKro86NgrQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791278932;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:
 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:
 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=O8ETpjIeRPTwKFRhTdLT0zJXXwuHHXz2MTMS+yIxhuI=;
 b=KcSwd+cbz8D7ABeDfddseiH1Xi3CSqiEdlSnojZ2e78WxkKa/VkYgXgMYTFgobBSIuTz
 hsq832unBsjqxQj/HePhyJLttkwvIpZ31djM0kGAovwm/mwwQsy1xsaaz7W9fSGYveFMl
 gyQRchHfLlgxilzLo6gaNDnh+XDtb6l4YemTatVUJl+BM3ozcl9exA6NT1/lBmOI/7gPu
 9hW0x8zx5QNLt0kxp/wUWoP4nuXrkxl5rZZr5Q4x2EYL8EPok+kkZJbrrKOu4d9/D51hg
 NlERtRwAbwH1gZbRpfGfS9+a5ndzJ4Ng+u/HTCI0S9u6jQQ/rzaMdLbloeqsK75x+DA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=emteria.com; 
 dkim=pass header.d=emteria.com header.i=@emteria.com header.a=rsa-sha256
 header.s=selector1 header.b=l9UJqPaA; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c207::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=jan.kehren@emteria.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=emteria.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=emteria.com header.i=@emteria.com header.a=rsa-sha256
 header.s=selector1 header.b=l9UJqPaA
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2B7E54053D
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 09:28:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s+p6L0O94ttVMxW2QiLBZBwj6gPdDlWRBbamkOvYEDlXRpdpPPtp1O4BbklCD2j9ITedcEbLcjNYIw4WyggVBqF4Q/QJ9y4eZzTzxNBJd65kZDmEHwa9Hs6u4cMtZWZz5g6tHQ4mNYM60dYXq7Yk6MVADJyB+6I91vqsW9lUFLuXtfiClB+FJIkaWp4R/kmIHfGm8Ba4mjjAuN+6HhholMXfO/VRBUOVJE029WPfdaD6yihbZ0fMNC4V7MD+BNzI8zNfQKyU0CmwyehEpskAbop5ZkDgsiuw153/LtSmw2aONUFQB16nfr5RvCQhAPTGBYdRRL5cQmeRUNDZNd/z7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O8ETpjIeRPTwKFRhTdLT0zJXXwuHHXz2MTMS+yIxhuI=;
 b=uXBnIEgqA5gKbmIYGQyDqNGK3eFIbRrj56XcoxAU2/Ao4LG96chBp/MNHMPCK8NayqZrzFFmap1Uf1NvOfnLl7jUVskeo12SDoeOWMYg8tjlvn/eMFgYxfBTiL0DepQT14Z9eph6aIcXiVOpRN50Q8h4tclZpPQJaix2CYWY8w3VSbCinxdhZKZ/8FowAAPO84SHS1T46qcrnOZbghUMv+BZHX7KO2taKdaw/qknq9lQuXv+S/O2wDDx5h1DwKy2AZRru/devbcHgFgpdpcM0agZwUzL64BK+w4pmc2Ww0Pb91fYxcGYJ/gJAA2PuHAoYOAp5c/bWb4QFz/6FSfVIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=emteria.com; dmarc=pass action=none header.from=emteria.com;
 dkim=pass header.d=emteria.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emteria.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O8ETpjIeRPTwKFRhTdLT0zJXXwuHHXz2MTMS+yIxhuI=;
 b=l9UJqPaAPcCW++2oCrOeYCqs0s3u862beiB62BAIMpf2cS8RsLEqAXexQx78KCeGY6FvQxMbk332cfVQIPHz+fM25zRYOwl+ensUw5o84LJ2DbeLHxl22gNPvlt/jaF0csCzuLH6xUg6WCViHJqR39cdZm8klc+89mWGUpUh0/I=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=emteria.com;
Received: from AM6PR04MB6662.eurprd04.prod.outlook.com (2603:10a6:20b:ff::15)
 by VI0PR04MB12007.eurprd04.prod.outlook.com (2603:10a6:800:314::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.22; Tue, 6 Oct
 2026 09:28:44 +0000
Received: from AM6PR04MB6662.eurprd04.prod.outlook.com
 ([fe80::8a0e:d777:59b6:f25d]) by AM6PR04MB6662.eurprd04.prod.outlook.com
 ([fe80::8a0e:d777:59b6:f25d%3]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 09:28:44 +0000
From: Jan Kehren <jan.kehren@emteria.com>
To: u-boot@lists.u-boot-project.org
Cc: mkorpershoek@kernel.org, igor.opaniuk@gmail.com, sjg@chromium.org,
 trini@konsulko.com, Jan Kehren <jan.kehren@emteria.com>
Subject: [PATCH v2 0/2] avb: Support verified boot from non-mmc storage
Date: Tue,  6 Oct 2026 11:27:29 +0200
Message-ID: <20261006092732.3577974-1-jan.kehren@emteria.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915145629.995499-1-jan.kehren@emteria.com>
References: <20260915145629.995499-1-jan.kehren@emteria.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0312.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::19) To AM6PR04MB6662.eurprd04.prod.outlook.com
 (2603:10a6:20b:ff::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6662:EE_|VI0PR04MB12007:EE_
X-MS-Office365-Filtering-Correlation-Id: bba99bae-1280-468b-8301-08df238c3764
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|10070799003|52116014|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: YD+foe9MtzP1H+ggO9Cqzl94+sVUKgJt/ydDFffr0Z5pY0gCK8Gn2k6J08YSMOQKDovXxdbBpZRtIexy18GHydnmC1lqkV0ClsWH7SDbUUy2xOyWZYOFe07EAjOpD7YO273yHtR27uL2VNkgvdcbyYKxymMlfKXy5c7eqwfKORkvG0iiXEDF8jMOJXCU00Si5/2wShlEvk0FJK19yBYJh9uzyVC3wiSYFutg9vTwIahg/auKxOLr8RE+JGQta5nqQ/zbVBZ6aCKB7r3anBpEc0KDFmOt/NEZfZYaVqN5Xi2qpxcMyb6EqlG50Q/PU9/r9w7qZVb5hsqcy4xTYsTYYlDvIKBeR1/F3rok+QmqIdHKVQOu6FqAjvof1DfpohmbM8EzTU49X4kFKQGFZgiZWdovUP+zuSIq7DlPDlPg2AOWC6blju3chRmXFIxa9lbyJhovMZLyzZDQgvChcbydyR7U84FjstsJ+H48o34l633ea267GQKknNto3V2TcmdamVOtfv5nDnGOt2viUUFcgLpSm+qiCASFo+471DfSafT+BvCZcZP3AqlUQdKOGnGgXgvaPifyy0xlgcxaC8fxshKJsIg5AlVc6b5w+6Jq2wMgZa+83TGcqwm2GjDZIK2rq280raXtXSE+lGyWBdobtwv6CQeDpxulI4U1mk7aMeQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR04MB6662.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(10070799003)(52116014)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R3R4lJhJoJeV99N+/u6MaAP6LwEcwwYjt1+m0SOAGnN5FEq0AQeBr+2CT34h?=
 =?us-ascii?Q?JdZaVQdocp6ccVRaM6A1Uk18AhVcfmZl7ia6X+ft5v524Fkauq70EBbtChc2?=
 =?us-ascii?Q?yhY2yezefNdU1rMqzHziNDMal3qCUtjLO5A8QzuPuCfT1UScirvyJFEvpumJ?=
 =?us-ascii?Q?zHa3bh1ZEh2lefU7/+MLSD0Df5g6Hys1qNiVhiXwcg8dWKF8HgCAumkJo8eW?=
 =?us-ascii?Q?W03XgbuIgNQcNHJBiZymUVcXxAdgzOfznBIfoCpaoCyPEd40yWX7hbDOctkk?=
 =?us-ascii?Q?NCn2AfalWIZjR0SabTVBE2IEGwXzLKnMYz1gfTv11i0Ewc6QL9/JqerBEFKh?=
 =?us-ascii?Q?ulm1Uh96dISgendV6Qfwxcqn/l8BRVgFSvdz0NWqgFTvOEibdmtzJrmFhhrt?=
 =?us-ascii?Q?aK6ZHO7BPrIz2RBosAqd84dyKDVXGTzqs/JM/babJlOgf2kSdzLObLVow4BX?=
 =?us-ascii?Q?Etfjv0dqOOmnuZld0w0RKwkrPNnmgzxws9WsynfXhjFGxmn6jTd6vQsExYe9?=
 =?us-ascii?Q?YCvkw6sZtls+vJnuY0KosFCfRf9/X3sEZ55W+VG/rvCj/jkYJAqwW0RfqIdN?=
 =?us-ascii?Q?PhHmHXXxZuIYZ1R/DrlY77TjiIwJUEiqR0hMwSPYDO6E4byEneaM6PzcFScG?=
 =?us-ascii?Q?1uGiP2bpwB8AUyq/zrvLMBvHqFG/1yV6JoZq4JNi9S9ezs7NgnOgsCsa4TcP?=
 =?us-ascii?Q?Ln9+dMLbb1noEBSg+QNjqv6O5juYSSRTRU/27uFzMzLeYGtRahC8ddX2ClnZ?=
 =?us-ascii?Q?P9CI7R+WPLwDoWIjMJ6kB7Ir87jlF+sID5Tgu6LlV1Klu7R4k9hAd7BSjEB6?=
 =?us-ascii?Q?DQEr9EeQkKU26XqcZca3ToOiwr+ncW8fj8v/1ylv/p+yVUPifldBQJO127Lw?=
 =?us-ascii?Q?AMV2hYxrhgaaF6jxe6esEh09wpT1x7EhrfysMP8gt+GhkqXqPucpPDp4Lrr/?=
 =?us-ascii?Q?ko7bA0R4fCsfEQkLUG81R6n1kcA7S0F+TZzu1iLN9bL0H8psNt7vkIbYPz59?=
 =?us-ascii?Q?8/edDS4MafXKE9GA6SvOgVyO8BZ1Zhhu7g3GfY8a6uXqtptcT71pnUZXrdqT?=
 =?us-ascii?Q?9JRLnHRGoq14s9Bz81LB8cQ2Vpw+/77zNWMF9UM5OrJBFUwwxQlure4ELmex?=
 =?us-ascii?Q?cbkF7fv6vcb+EWfmtxjlIKh+ZgA4CLGAu54q1MSoaIcNZhy33eLad1dpzQ80?=
 =?us-ascii?Q?eK31qp16luzVmzNXriF7SzqsP4OzNw+y6fx0bodf7to1HPke+hYAY0xAtYCW?=
 =?us-ascii?Q?CN8n7vGPO339kewgVaddex0HrlEtjweP8ru2OJwywA3+ziH+XZTjEZfV503B?=
 =?us-ascii?Q?edfewAvqCtGqn25EzDAm6UORzTi2jg9eAwS5OVt8L4UtQd7GKLoDp3ISTu9t?=
 =?us-ascii?Q?1WwSOEVeqMo5GdcDqpBp3NJAOlWc4IRMaRwO/eWplBX4US8os4cd7jCtEcd8?=
 =?us-ascii?Q?ckffg/3ZyE7T7CUfxdARnbPB4Y/rab2lXkC/bIu9ugrU658YRDvuiGdF+sJy?=
 =?us-ascii?Q?o5+andvK7l9L5XV88JkGeZLh3rhgi4xN9nfI67d9A7yFszHq/j5ac6VcEBwb?=
 =?us-ascii?Q?gHxH4ExCRFTMzPIZIWci8I/wnc52TsCBZvrl0iK2rKljx8WxdeCfZ1+4YaGT?=
 =?us-ascii?Q?8KtlGA+GSDiPHrOD6jRdEbEDbuzgxSu14y6nANbj+3Ymb+g6gTUbX5TPM3hj?=
 =?us-ascii?Q?TDdBgEX7N4P7Lra/7YuigwAi7sXmr3P/WH9+HnJ7lgel1tBTo7oqdsNgp1Sc?=
 =?us-ascii?Q?Jb4r+PmBns/oH2Zs8B5kyOZxZI+Is32cLDQFHJHO7xNY8hgKq8RkmB6i84UB?=
X-MS-Exchange-AntiSpam-MessageData-1: AaU+eIMpgRl+Mg==
X-OriginatorOrg: emteria.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bba99bae-1280-468b-8301-08df238c3764
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6662.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 09:28:44.4892 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e416006-a062-4a38-99be-aba82ce308ae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bg1qy4PUV+dLtX/EY+wWSozq19BLhvURuOlUO6g2CPsxnpa50Y0op0ksj6vJZZXrUz7WryLIWg70H/KozTmjfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12007
X-Mailman-Approved-At: Tue, 06 Oct 2026 13:00:03 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Thanks for the review, and no worries at all about the delay.

AVB in U-Boot assumes its partitions are on mmc. bootmeth_android accepts
any bootdev but passes only the device number to avb_ops_alloc(), dropping
the uclass, so an Android bootflow found on nvme 0 or usb 0 is verified
against mmc 0.

Patch 1 is the rename, split out as you asked, with no functional change.
Patch 2 adds the uclass and the optional "avb init <interface> <dev>" form.

On your bootmeth_android point: it has other mmc-specific logic such as
bootflow_iter_check_mmc(), so booting Android from another medium through
bootstd needs more than this series. The avb_ops_alloc() hunk here stops
the verification being aimed at the wrong device; the rest is left for a
follow-up.

Tested on Raspberry Pi 4 and Raspberry Pi 5, verifying and booting Android
from SD on both and from USB mass storage on the Pi 4. Those boards boot
through a downstream command rather than bootstd, so the bootmeth_android
hunk is build tested only. On the Pi 4 "avb init usb 0" then "avb verify
_a" passes, "avb init 0" still resolves to mmc, and an unknown interface or
an out-of-range index on either bus is rejected without disturbing ops that
were already initialised.

Build tested with khadas-vim3_android_defconfig and
khadas-vim3l_android_ab_defconfig; each patch also builds on its own.

Jan Kehren (2):
  avb: Drop the mmc naming from the block IO helpers
  avb: Take a storage interface in the AVB operations

 boot/bootmeth_android.c                |   2 +-
 cmd/avb.c                              |  24 +++-
 common/Kconfig                         |   7 +-
 common/avb_verify.c                    | 167 ++++++++++++++-----------
 doc/android/avb2.rst                   |   7 +-
 include/avb_verify.h                   |  38 ++++--
 test/py/tests/test_android/test_avb.py |  28 +++++
 7 files changed, 181 insertions(+), 92 deletions(-)


base-commit: 25a459fd4d2eeef909dd4ea8a577ba82b1fc5e43
-- 
2.43.0

