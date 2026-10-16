Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7661CCA462
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 07:27:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 81E2E813B0;
	Fri, 16 Oct 2026 07:27:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qU9DHhJkBe8E; Fri, 16 Oct 2026 07:27:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C4812813BD
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792135659;
	b=azyJ6Ito0JMGI6K63gPGpd/BM6jSJNmW25/KhAD0B+aMXnbmBdhhXapP0B/ozAvTGg7d
	 ZoKUWKLqlY5geT6xqFd1slSv0wUpBjZcJ1V8IvpQ6jWtRvFglenfRfzb7Zd4Y97ypdVhh
	 2JZYw0Zr/d9LBfraQC8IQg4hbzFviEw2ARW1vPAcv/mG2IyX49VWEUGvdTPq6ezpttJVl
	 Qj+XKpvyOJI7/09ycmQi/FANwMxS1JmlmbP0yuaKJlkIiUGyMCunC237rSzjbfNgZq+Qv
	 xLXoUWXfCBHdOK8ZVgchSAYJEsT8LKOJok8R7zxLub/NYHFVy+655hE5VZl8DN9fQMw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792135659;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=TVx/TMKRhL8LZYUj+4uw0ZgAJCgoGraFDVa1cF6fxoQ=;
	b=CjChlnF/oxFDl+tpPEihNvczKUjpNmN4qPG2r19ao8IB33/W6LIJi/22ZpTbVhd4p2wZ
	 kE+zd28+Wt9PmRxD5GqFVEg+JE9FspF+Gs2J/USl5U6eXNp+HBLH7e3zI7qhp5rHfHGSm
	 TTtZgY0MlsKdmjP2vZdGPXoFp5qRRTYKWQs7BhhV3MxYDGNHqDBMjSicEYEVDiHRztjtu
	 Il1DlA0FCNGMDwRrxDI4T7rJUQ9bLym79yTlpMZMQiPEzMBlqekbDoD/3r4N4CbJppYXu
	 ZOGG8+18kRXB4D5vm0BxfPDgKkLVhshRhH2MxyibpmGWbtok2xiXGW/ei7yhY7i/H7Q==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792135658;
	bh=TVx/TMKRhL8LZYUj+4uw0ZgAJCgoGraFDVa1cF6fxoQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RrGxbAs8NUPRtlWj/AbYoKBkAHD+vKFrkXOQLWnf4+OClXToAjJ9L3U1ptmW4HiUZ
	 p2neIyUPI/JMa92JvoFRoEwdmw7tgMj9mUbS6Ktiz1BHsZ+dpOT5H1vQsruQQGjrGS
	 MCDe8JDxZPtX+GNbopYFCQGMWU1jhI6t4m3xsWvxWEXDVCCljJnN5K3tIsj41NpYP0
	 0fmM0UJedo88MNgNVI4AqsCTu8RD0C0MCebxzH9Mdn1gWCclICRt5/4Gnymji++MT0
	 no5QVPbYddRrzGywCGlNnH9pDYS0+b2yZYsg0vQqqnjECaeafm19aOJytfqHAZ1rzp
	 +7fIt2ewgW/9Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C4812813BD;
	Fri, 16 Oct 2026 07:27:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5B259105
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 07:27:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 40C394022A
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 07:27:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id egr8zVDMQ26W for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 07:27:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 67E8340050
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::6"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792135651;
 b=Uc2GXDPLS1n7U5Cvddtvm+q1LCIuFVkkszU8k+BuIwymJcmDYeFEM7baue2btt9J6Nv8
 dG1xoQDKXad4eRo4K8SOQCUP4MI0uvgrDvvKw/CimtCI8IpkiA30h/HHG1cmD69eOOkBA
 4/gVpKP14I+SYgOiXs7OLrHUhqG0fBRon7HUkkQCjjwoLSigaaAfwkLDuY3LJjvayIcXv
 6JXb+ciEMrPmVmkFsERExPMntLcicDR4nquH99GRI5dL6JcxtjsDcdt7IdTHrS69zgLPT
 Vxua9SKbZklwK4lL5coHOPmXo26rXYE8CPYeocZnXadQhbfukhHjYlMHHMmT0vRlEdw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792135651;
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
 bh=TVx/TMKRhL8LZYUj+4uw0ZgAJCgoGraFDVa1cF6fxoQ=;
 b=CwkIC9cb6m7DUlUXC2lmypK9dBH6wXSAISdlsHKVR38ExlA3NCqWkxuRbTFqi/l+1rXr
 QYpTwt3yT7HKDUhLFFAr4Ocb514di90Uk1enaAsqFuqy+wZrqL9TcXFJQgK+F35GzS2C9
 j4WDxLQB8zDWoFL2RZafSz0QA7S+HZXDJDKSAVNPuo94/DlEOpr0Z1MrlRco9H5JMjHGn
 3ge3H1oPCaLmtNK1yg9JJNFy3tlE2L0jjXpQGo6fD41I0/v95MMsPm1+W199717huFTil
 tznWSBliFLJHyE/ZwfPq791bhYlLX1/CUIQ9iIqlq8wLgQYnwIPps8WA5YEfy91i+bQ==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=emteria.com;
 dkim=pass header.d=emteria.com header.i=@emteria.com header.a=rsa-sha256
 header.s=selector1 header.b=JhYMAAv7; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c201::6"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::6;
 helo=am0pr02cu008.outbound.protection.outlook.com;
 envelope-from=jan.kehren@emteria.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=emteria.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=emteria.com header.i=@emteria.com header.a=rsa-sha256
 header.s=selector1 header.b=JhYMAAv7
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 67E8340050
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 07:27:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=To1QfiaQ93c5GyOG/HB5Q59NvARLhPlfLFOCD6U1s9a0lTW0WWmXGAgoJGJxV8VW1CgDrKa7wGOMjzgWDk7vD+vzeF87mUp2n5F7E27AVSLG+8Nx9gy3v93RJzxJHHbpHGS6OZFY1Dk591bY70DFDu4xT/aEKr9mUnzNQfIO8be/Gqit5CW8vwdQH1YGS/rUvhpVK0endn9jVr8DuVxdWdCfJnjsbU15g3n3OKOF+yoTklLp2R4auviBPVw7hcOFOjrla0M4DsujHFewZAbZhXC8bghzIynIXanEhyKdWzbTGSKnSAkKzaVIXcf6ekMmW/FQB9hwRQ+j2YtqScJ6tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TVx/TMKRhL8LZYUj+4uw0ZgAJCgoGraFDVa1cF6fxoQ=;
 b=igz6hccwCOiECszTzedB3NdZ+n2IwByLc8xPiBJJieBWkhRAMqzzCy1bsp/cfOkkJFv+abiubVrObTTH4ZTwVAzFeYcyrTkzM2zJpT8dOaQ1hSzAUUf4XYuQCdd/M1j5ZWomOH8ZFzMQtNAc0Ce/Ge+lxllrloB2q/E95kug9Q9mK/iAKzuQrMz06YCeUgo1+VnwC2hJ2s80FkcOHu2Ad6U0PSK3GMuZ4el6JGjJSXaSavBHp8yNmk9d8pVGX7+YHBPmNV9o9KIHS4lE8hlogQOgeHcoaQHD9Wv01wGRGSQwFProdjRXEYU/hMqPGOI6uCFHyqULU9PdgT6HAI2ZkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=emteria.com; dmarc=pass action=none header.from=emteria.com;
 dkim=pass header.d=emteria.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emteria.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TVx/TMKRhL8LZYUj+4uw0ZgAJCgoGraFDVa1cF6fxoQ=;
 b=JhYMAAv72/nTJ8Fgsp87bnGWbOW8mFrOTn6YqO9VrzlBH5NfekjnR99KGZlGbQdJN7Ouy7IL4Odsb5U2SlxZ+BMaLBFoMfzvhZ+DEmD/TM+b7BRd+MXjjlVmZCgN2pyjf+gUhSmG3VvhAaba5vMMtJg1gr2w+bs+J3hKzDhFYmY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=emteria.com;
Received: from AM6PR04MB6662.eurprd04.prod.outlook.com (2603:10a6:20b:ff::15)
 by PAXPR04MB8559.eurprd04.prod.outlook.com (2603:10a6:102:216::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 07:27:21 +0000
Received: from AM6PR04MB6662.eurprd04.prod.outlook.com
 ([fe80::8a0e:d777:59b6:f25d]) by AM6PR04MB6662.eurprd04.prod.outlook.com
 ([fe80::8a0e:d777:59b6:f25d%3]) with mapi id 15.21.0496.021; Fri, 16 Oct 2026
 07:27:20 +0000
From: Jan Kehren <jan.kehren@emteria.com>
To: u-boot@lists.u-boot-project.org
Cc: mkorpershoek@kernel.org, igor.opaniuk@oss.qualcomm.com,
 glaroque@baylibre.com, sjg@chromium.org, trini@konsulko.com,
 Jan Kehren <jan.kehren@emteria.com>
Subject: [PATCH v3 0/3] avb: Support verified boot from non-mmc storage
Date: Fri, 16 Oct 2026 09:26:36 +0200
Message-ID: <20261016072640.772964-1-jan.kehren@emteria.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261006092732.3577974-1-jan.kehren@emteria.com>
References: <20261006092732.3577974-1-jan.kehren@emteria.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0070.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::9) To AM6PR04MB6662.eurprd04.prod.outlook.com
 (2603:10a6:20b:ff::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6662:EE_|PAXPR04MB8559:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a5795fe-28bd-404e-a639-08df2b56ea3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|10070799003|52116014|18002099003|22082099003|10067099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: jELduHZP8NC3+c/6ZU3j2qGltg3PLn5X2jm4b5LNwIKXIR1WNcBd2IU/rT4Q36FqOpY0V4iV1IDy+4bsMazoSEh7gdIGPJQIFH2Leq2HI/ucwCZJZOhSrsZLKy4lDJ54ESFmy/9RqEaCZC+TgwNItoiZsg2GJsaVMPBvHsN7/XfufAXE0vQWJDXFczbl/H6RNaSLo9Y1bip7sshdkUnRxWz4u1dB3lPLo6nsW2E4E4VheCfSNqCgn5hF9dQ3XiVUikFBAWBSYnmqZ9r/Hxfo1sbHtwpWLcZ7OV4A7tHokwCT+MgWD2JUlSLuujZHC7dizH4UHtUpRNUVcZTIsR1gkztKh4pacacoeLEjrLeSx92zB2QAaE7YOAyC7Nz45kGXNCiPEJoeB4YndUqpfd5Z9qUmd+ihtFkV1YaCppH4x3aaLPpRdfjWgY9cXFa8YCKglwvhNMoaXUSjJK9DMoCt0C4PfhwDQIFdjpoji4NGuMqa9cDlDUlqiN54EfuOsoiDBe2xC9V9xwhIcb17clHRcjXnwuH6LsLh7FhbQiOiSEY80KIdxBdPShBoLUvc19dzqrtfJ6DVGmz2+qVsX3y3Dje++W2R5Imh8RUEwL5IwBQWGhE3wJ5HPa8BalNrU2pnZayL9tVyPhwUuCO5vQ4xWuKKzc6c2ndAxgkcSfRwE64=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR04MB6662.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(10070799003)(52116014)(18002099003)(22082099003)(10067099003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2GUnKiC4wJ+9QDUwfc2E9NdkLaj7Dd7Q/A2DZGNNEay0Lncw4svFZrQ7igeg?=
 =?us-ascii?Q?rNIo8DJmAd/swaUsFT0IXGONbzOmSAw7JhHKej4zH/XMHOsmTAZyRsMNlm9o?=
 =?us-ascii?Q?r2PohqkurI/NaEdhFFQYlc6YBGDZuFZPv1gA6WG6IX1GKzF11OwoXtAl9Edx?=
 =?us-ascii?Q?u1WE27S7Tj9/f1M5ytil1U6twlhB8K24uRyeI3Vwu5Fe9Jh4wfq3K8q63klZ?=
 =?us-ascii?Q?ulvl8ZYdw9jz7AXcGepjxjEwlWN8FY9pq7wWspWnxe2Yx01ufuVKItA6FEez?=
 =?us-ascii?Q?x2k9thrEPa8sOEPiX57E9rD8nS2qC2PJrggMU3kzp5xYhorBYNXmDgqmkVUS?=
 =?us-ascii?Q?Ap0RWQHO4T+3BZ2XHRNWP33feg5hvD7Qj6VG3eSwqWPawTFKdmF8sFOMzh/h?=
 =?us-ascii?Q?nDOlZumDDckQ2Wevi8hrJX98iuuLcei0gFwhzKd9jedokomGz2cVVmf1nnW3?=
 =?us-ascii?Q?Z3/lXssgcwR4W1aIK7DawYOT70eUmXDk9997W6Dlu2AFNwCCZbV80srLRe/7?=
 =?us-ascii?Q?GjNg+PadECFX5In8PY/Js/nS8pPjZvz11SvXHgyGLUXhRR3c4xU2lKzLfoZU?=
 =?us-ascii?Q?cuzsGTGvkjvYCjAavtPMs9dkuPKW/Neto7I+/joL0iJHIXUBKXcqB+TTpzOL?=
 =?us-ascii?Q?bci0MbCmHq7lEfKIftwvlEmC95km9e8I5NmCdVkOiWsiBl4mLZQ2H/dMdnYl?=
 =?us-ascii?Q?OqNCyOVsbwSMYfxMxEQryuQTEF7ufgEvcqzQC6TxhLpVfaVofA5HrvXIi1Hc?=
 =?us-ascii?Q?XBamTyOazOqRoVKBmSvAjYGv8J5szzlnqdOLI2o45T9PCVt8D4j255ma0NQg?=
 =?us-ascii?Q?PlCpXhAAjkD7bATiq+GrXftzFv+iRCytY92JY3LJFidYnKOSPVnl1Sn9j2v1?=
 =?us-ascii?Q?1F52BVS7lH/89G1Du+GjLQo69pKBAXnuuHek7MfpYydFm2LhHRUqzF4jIziJ?=
 =?us-ascii?Q?Yy6o5Y6E0/XN0XE/MdgcnFfHEVd2erxuDvlthGhsmWWzA/5SaJF/TqaAxaQA?=
 =?us-ascii?Q?iZPjD3WSlV4q01I5q8oLqeW/UNGzbRxYjqrKz+Eli2xdBKJO95BSEM5vNTsb?=
 =?us-ascii?Q?LS0iAjTHCzXRM2mcAtnFgI0cDl2m5pbzLefgsUmeUyMHGHGK3Rc/q9D/IWGf?=
 =?us-ascii?Q?ZY2oDIRkhS1TtinRNsbg+RjVZv7SOIEHt0Xvi/5aQcsikdlA55inG8nf1HZt?=
 =?us-ascii?Q?y1F7sxFUiFpQ590F0r7NHi6ZF030a2B5deokyjqN1ACx/YufWrEQYNDhGSTu?=
 =?us-ascii?Q?bmvBEVXzWaLwmdpyiiUb27M2OIgSQUCLUlPQivxhcjcUsQxSbpNmBPHTJaqm?=
 =?us-ascii?Q?OR+DXcv2XKtsA0gImAGXdAjHXLwc+ZfsoPI0Q6Z4hbI1PI8nUHiJQOg4RqAc?=
 =?us-ascii?Q?1JpNL/FQ3y8eb9n9+5aa16Xfcg8Kx1Y8d/7D48Zeyr7Gofz1RRZrOMbRIpqp?=
 =?us-ascii?Q?Tek7gh+Qf8fBEJ52iZXrqrOwwXquRU+HcHhnDlpONBsoWVE+1f8pFI7IS+SM?=
 =?us-ascii?Q?GmtkCdEoMvAM3elRn84uqE7JiNRXuRF1LJpvotXqbnOhag6g6rcv/sBXSl9H?=
 =?us-ascii?Q?ax35JvsdOmmW/aPtVS7gwtvISJWrXf4wNM13UswFE0nUZHS4GnENXs5X0SwQ?=
 =?us-ascii?Q?m4PznI6dpuCSu8WfbaZiyyF00HPuAmxGgTEtOC4sjEfkYKF28w3xuC3BhICF?=
 =?us-ascii?Q?AFay38RGnuVkn6TF17JIXw7XDcG0lUnUhg5L4OqbWEjC5ODjeF78LoIGKvv7?=
 =?us-ascii?Q?Lnn07EpQyu3BUX9CL3VoJE4SNnGM4FAsRwk5Fnsq4PfV8AvEbPhX9qxQsZ9d?=
X-MS-Exchange-AntiSpam-MessageData-1: b0Xi2kQFISc7YA==
X-OriginatorOrg: emteria.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a5795fe-28bd-404e-a639-08df2b56ea3f
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6662.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 07:27:20.9037 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e416006-a062-4a38-99be-aba82ce308ae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mE9fQbZZlHpBRz6hy4T1y8r8CUGHqiJ7LvIMpE/0a2nSDCJKBQHA/cylRzDAJIBZxF/PkAS1Br8JLXVJWjXYhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8559
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

Thanks both for the reviews, and sorry for the CI breakage.

v3 keeps "avb init" lazy, as Igor suggested.

Patch 1 is the rename, unchanged, with the tags from v2.

Patch 2 is new:
validating an interface name without resolving a device needs a
name-to-uclass lookup and the block layer only had the reverse. Say if you
would rather not grow a block layer header for one caller, the alternative
is a static helper in cmd/avb.c.

Patch 3 is the reworked AVB change.

Based on u-boot-dfu-next, not on your test suite series. The fixup you
posted is no longer needed, since "avb init" resolves no device and the
test no longer refers to mmc_dev; it applies on top of your series with
git am -3 and passes there too.

On the total_compute motivation: that board carries only CONFIG_LIBAVB
since 867e16ae05e2 dropped AVB_VERIFY and CMD_AVB, so its
"avb init ${blk_dev} 0" fails as an unknown command, not a usage error.

test_avb.py on sandbox gives 6 passed, 2 skipped, where v2 gives 5 failed.
Also tested on Raspberry Pi 4 and 5, booting Android from SD on both and
from USB mass storage on the Pi 4.

Jan Kehren (3):
  avb: Drop the mmc naming from the block IO helpers
  blk: Add a name-to-interface-type lookup
  avb: Take a storage interface in the AVB operations

 boot/bootmeth_android.c                |   2 +-
 cmd/avb.c                              |  25 +++-
 common/Kconfig                         |   7 +-
 common/avb_verify.c                    | 167 ++++++++++++++-----------
 doc/android/avb2.rst                   |  14 ++-
 drivers/block/blk-uclass.c             |   4 +-
 drivers/block/blk_legacy.c             |   7 ++
 include/avb_verify.h                   |  38 ++++--
 include/blk.h                          |  11 ++
 test/py/tests/test_android/test_avb.py |  28 +++++
 10 files changed, 209 insertions(+), 94 deletions(-)


base-commit: 25a459fd4d2eeef909dd4ea8a577ba82b1fc5e43
-- 
2.43.0

