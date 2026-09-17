Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 929EDC88E72
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 12:44:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3AA12407F2;
	Thu, 17 Sep 2026 12:44:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aKe_BjsucudB; Thu, 17 Sep 2026 12:44:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 78B32407CC
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789649072;
	b=fgyQa8Dj6neP991GbM/GUdLYR8BfFSQdAV47uvMnfsFyg5GcdTXVgrTACulKf4DtQeJu
	 hdMlWWWSPGxVrHazT++c0qqGQCbvAEFDL+EQm8l6bOjKB0E9iAOfn2ROkl0fmz/A806I+
	 C/mlVACwbBfDkTu7+B4dash8AEZ8Qqa7dRJUwOvlwCzvUpsvsE9YsWZnc4a5UZ5hppB2P
	 aiK3/4wVA881tNYaz2Pd6J0GTy60r5fnqqOulPQ6eHQ6w+LOkfLhp94CzFUFG8SOAmQjg
	 0h962ml4atODk5QkSgZpsfEe0awvNQMfTkbYv31oY0kYK+STreIL51IMZS/hQjH6Lbw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789649072;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Received:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:CC:In-Reply-To:References:
	 Date:Message-ID:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=qWOq3uUgELtYc4nGbCVL+PmBqzeq5RUnDZbH094bst8=;
	b=iZl4y12ZyLuzB5uEbZY3AMFoUN0t90KEsHRFJwGNmnl+Goh09ydIMWWJsqRdzyboITOo
	 Z0doX4LuN3byql6QUQS1vAiLtj5+VJnbsbROzF9Q92jUKE4Y91wMSlehecxMvnt3nYDja
	 ogxCr9E/IiPo1jh6NTLcxFgZmj4UoEkPGirMI7kmom0oY96V8r9uDe7Ct26ZUoCygEhsh
	 ISmh11+27g2Cx/Thlbywb9kNDcqXktMRzVDIuwC5MWvW/IJY3eZvG8Fm31DZrHK5y3vsj
	 ukc2JLEBk+mlBX7nzSZNUdH2jzilTyTWfjMXP6X8aJiKtjp5WfZlFfe4oOZAGAPrV9w==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789649072;
	bh=qWOq3uUgELtYc4nGbCVL+PmBqzeq5RUnDZbH094bst8=;
	h=Subject:From:To:CC:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WEz8/8pqO/Hkn0W0q6zlp7Ca6PVeJScPlUAKTUUGEoeGzW2ZZm5yh5fRKVHJFEYtQ
	 4KAITEPNIdpHFk+WTQUzs4sS4Rc9JAl7wJ8U+RjGLXXPvPQC5k55LzNLwiG3XguPAN
	 ZpXI/xNpzUqEW8AOk9D63pgE4C3KjskauxTKJC8+UqLIDPR/iXj4PlzCGSRkTYDSX/
	 7YjIq6W6PiN7G6Tks7JclMD+OQAEuR4zThXJEO+hm4Bpvp3bmHepszIyTW94VbTIm+
	 eqjywVASHuKZ/QIEPUwWW+KPu4oWXi5nfnmRiDb1z/Rezu5dxsV/EjcVybp2OV/tfY
	 2xXrfbPvF0J7A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 78B32407CC;
	Thu, 17 Sep 2026 12:44:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 44DB829B
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 12:44:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2A3CA80FA7
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 12:44:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cafbHxmD6uwP for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 12:44:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 21DF580FA3
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789649070;
 b=pA/oSeEsp9ekmbeFAlIsbTKVD4PcW0OBmqmUZuPfUHHy1asqUHscbYzzjHETSI/bt3Z9
 0FSoemW+PkibO5eLKg/ed2VNfcHSiqgsq0NNX5bjDatWMbt7piFHKEnuZ/m+mN88DPIgw
 PhIpHJizfCaq4smeldr8BgGFtBgUCnpiFbfiDZIYtM+Ijy4YZYq+XczpGB8bjWmslsnpY
 PhxMZYF77tRFG7IjHQLoIkBB/Ehhp8lkiAB4LbSBYtUwXWqshNQ0pisQudvVysJJjNrzD
 43HVlBbLPwzfYtqzBRTIVEiqA2zACreGAlxnOdCo6b4iEysfw66tGS8BWFwpSB0p85w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789649070;
 h=Received-SPF:Received:DKIM-Signature:Received:DKIM-Signature:
 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
 Received:Received:Received:Received:Received:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Subject:From:To:CC:In-Reply-To:
 References:Date:Message-ID:X-Mailer:X-Developer-Signature:
 X-Developer-Key:X-EOPAttributedMessage:X-MS-PublicTrafficType:
 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
 X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-Id:
 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=qWOq3uUgELtYc4nGbCVL+PmBqzeq5RUnDZbH094bst8=;
 b=Y+pg5wf+9tsP/ClWLmATSjAes3IneOQNNECSRsfO6i5O7jufJT0s5bA8jJLEcXpRsUp3
 OmHtMhm4iY2fAbywRFt+8fGDtDyvKf9X0Ks2gvA5igamMshPhWbnX1lMDoYl/V/F3+4zn
 yeQvGNNFZ44zZF3qstSYwofUjga0WfVZ89kGiRiUNPUTPkWfhFyL+RIkcdMHA6tYeFKV1
 aVVi3fcsK7jiw8KgXQx/gz/YReMpCy8+bBUXft2cskum7kUlFje9fAHvIF+26jXoR5hV4
 kAeg7iqYpZBL47r8fEVSeCuE8BYFTCOWDn9HXgQMvr/W5l5LcDaDmpFPmGHQL+JTnrA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=ti.com; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=OLSyD51x; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=eAWu5Cl3; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=anshuld@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=OLSyD51x; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=eAWu5Cl3
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 21DF580FA3
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 12:44:29 +0000 (UTC)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 68H9aYVa2703413;
 Thu, 17 Sep 2026 07:44:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=qWOq3uUgELtYc4nGbCVL+PmBqzeq5RUnDZbH094bs
 t8=; b=OLSyD51xka4n2UlvOLC2ZpQi0R2NV/pLMhq0NZLzCaLty+02+X4xlPXMp
 dB8FO66lYi+L+izaLXlpxELqwJCjLvkVrMLMiGop+Di1FlKxPcO05mCt1ZADAOOR
 FQrTWjT3Y+gRciCJetcX9lMyjCL+ufdTxzvVATKRfn8YIztfKfaXnWfMHQiKeTJJ
 ncaVD6cBGPZgMhawUJfXsXgzV4GKdJr1arB8MM43P63Bd/N6KCTfGp1iI59FX+BI
 jNjU4wIDoWOpmkclFS9QbW+wM/3kblCu9lxyfD0kemdOMATQrTQ9GJ6iW4cBxwJI
 1IElo9IBqdw5fdHXJXzBXoQsHhBnA==
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azon11010004.outbound.protection.outlook.com [52.101.56.4])
 by m0384305.ppops.net (PPS) with ESMTPS id 4gqxfpf07n-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 17 Sep 2026 07:44:12 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MLaaJalXfA1kjlsYNaW1iQLesmWtImIMy50X17NAVMUOyCN8SEoWmDPKaP9c0voBOpz8J56CQ32j51wKyw54kNy4TieEKp2EQki0IhsHHLZX7Atn4EUcQrRQ/irG6V1a7QYQBeuxVAosGKCS+k+vPOscqu+bpLzn+bY7lBaqPlb1z7MWp3hvBGkg8SIIahCEod7/VJyJb+3VdAhYv8c3AWsyrdQQVywyoZYhS3MHEds//r9X/wLsbIcHWoIRpYwH3hmaxC7WlTzIBF7ng2xvEhFSAHmkHbLQQQ9yyzjU7H0jxgUh+K99tiMH99DVziSGl+0HLn7NgEYRnCbAN6+6PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qWOq3uUgELtYc4nGbCVL+PmBqzeq5RUnDZbH094bst8=;
 b=rESQ7FbOJYRv4DuzUc3VcENi0CgN/Wq7r48SOmjy85FUKf57pSk4wzzzTAx1FVrFTT7HVPQ5eUdwuPb+rccoKVYBBb1EdfqyUQ2aCUHzrSg4fSEhHmrMxCIOESI/V1A4RtP0rJqd9lI3jG5baRTZ+MAA3t/Ez0rr5Gmqe36KqXYox9X0XOBfZ4v8Et/InHeHcdVJxObcBhLuL6bdV3L7/H35C+/3C6hMAbrdsQ16We06lKtg47RFg/Se30b3zwCxVr+3+qXV+dkh3r9aukogFn3yAWsz2CTjuXGTRCZ6yFifRzlNBGApzsHmKerZ8XuccBfXuubPZYNMBKd8p25fNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=linaro.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qWOq3uUgELtYc4nGbCVL+PmBqzeq5RUnDZbH094bst8=;
 b=eAWu5Cl3pPrWb22ToEFQUv0s6jSFInVaw/cSBupQHNCGD1UIlGx35nxavOlJ+VJaIPH2MtjI1Biu+GEVaa+0PYFJtzITKlfQS4KSMMeU/7UNIuij1Tvh42ZP9BaHjF63L26BsLnQiwBH10FKSCK3r1q4HgzzzfAIn8eflXaZfpM=
Received: from BN9PR03CA0260.namprd03.prod.outlook.com (2603:10b6:408:ff::25)
 by SJ0PR10MB6432.namprd10.prod.outlook.com (2603:10b6:a03:486::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Thu, 17 Sep
 2026 12:44:07 +0000
Received: from BN2PEPF000055DC.namprd21.prod.outlook.com
 (2603:10b6:408:ff:cafe::29) by BN9PR03CA0260.outlook.office365.com
 (2603:10b6:408:ff::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.9 via Frontend Transport; Thu, 17
 Sep 2026 12:44:06 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.195) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN2PEPF000055DC.mail.protection.outlook.com (10.167.245.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.0 via Frontend Transport; Thu, 17 Sep 2026 12:44:04 +0000
Received: from DFLE214.ent.ti.com (10.64.6.72) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 17 Sep
 2026 07:43:12 -0500
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 17 Sep
 2026 07:43:12 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 17 Sep 2026 07:43:12 -0500
Received: from localhost (ada0543016.dhcp.ti.com [10.24.50.146])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68HChB1i3002794;
 Thu, 17 Sep 2026 07:43:11 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v9 00/26] usb: dwc3: part 2, make the resynced code
 work
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.u-boot-project.org>
CC: <marek.vasut@mailbox.org>, <trini@konsulko.com>,
 <ilias.apalodimas@linaro.org>, <michal.simek@amd.com>, <lukma@denx.de>,
 <alchark@flipper.net>, <jerome.forissier@arm.com>,
 <dlechner@baylibre.com>, <anshuld@ti.com>, <sjg@chromium.org>,
 <Thinh.Nguyen@synopsys.com>, <mkorpershoek@kernel.org>,
 <love.kumar@amd.com>, Anders Roxell <anders.roxell@linaro.org>,
 <c-vankar@ti.com>, <s-vadapalli@ti.com>
In-Reply-To: <20260916123826.517181-1-anders.roxell@linaro.org>
References: <20260916123826.517181-1-anders.roxell@linaro.org>
Date: Thu, 17 Sep 2026 18:13:08 +0530
Message-ID: <178964898806.1279633.17593305863869822172.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789648990; l=603;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=uGJUnyzKHiRRU0PT1OYpxhnBBeZX04QFTPZWYWIXytM=;
 b=UMqjrVA1AQBdMMAZGsAPImhrI2tPt1DIAIhSd8bItd2wgyPIKE1cPJmbKzONCqI0EwpGUJ7Y+
 N78NS/yAxx8B8VHsU4bKByg5jtTogUVJciTIIsWDrMTpxQlHV2JhKUR
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DC:EE_|SJ0PR10MB6432:EE_
X-MS-Office365-Filtering-Correlation-Id: f7c0a1af-2515-4425-3748-08df14b95ba0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|7416014|1800799024|376014|36860700016|23010399003|22082099003|18002099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: 3+sR64CTatdrf5M2kfwqhywt6JgGimkP3cP9Q/UTZ9KPH00GCL8UPeTfiSx3vGpvkw9KzIQuTb6CPhQkM7gqEl2G3/kVc8rfzp08Wi3hhwCpS5Kw7h1aV8DuFAfvfJhSHe+eewwjBe7ql8Hqr1/82EvDoOThwN6r9Rdu3bRp8hYCAj2q/3y0cq8tk98fRb7v4yUz4gPk3IQqHUV7or0FFVtoGMeTW+vGC/NNIzus4KcDOnocSeZo9M3+5igK+z2REK9J5g2aX5jGM3LwJixMO7qcWpvmA3NI/JNKimBQCHyeelLcTH+l3+FoWEH2fs/N0mpGgzVswto+imWpLtaT7Eh7Rb4Udt50QB8hm5LOJ5XsbaQiXJiF72ZZoWKMY7JuYZRR7u7SRnh2DDGBcaNU0U01hpaQQXjlpAK1h/7WSD58dzEMzZEfrB2K5+ReACGuQ1Bo4FQsJ7DGK6WXK3kPli9/W44oUtcgjX0Vy6ikwK2y1ydSyqx+zihRZNfrMhM8YpTtpzssHUOQLkQpCUk0l3Po3MBq+ll/CR8VQIPYea2iy7n8anTGVNREvg6zNOskMuCV84OPQHUWZqnGTobLLkv+AmeweR8j6CBaai29/yd7KbxgFdiaS4QJdrDskvnmhcBaJ0GzD39pSCd3zDeC5Ml6EtRmceREA7ghZ7d5QnNcEchdAsKzD0A5436gWjIG+LOiE1QoMi8/FmwlyOeVpg==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(7416014)(1800799024)(376014)(36860700016)(23010399003)(22082099003)(18002099003)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: H97bCshvSAL9As6BIgv/U/5O24Sv/wUyhMeQhKfLtE1PFaGapuje6d6R2xNG0rTIdxn0JpIDRCq1uM1WeVhFrgNtcfF0LHkmMe/ENjZ6x44vqvJapD/zpjR03pAiHGWCzELVcS7nfAif31LH6b9iCREm/Yck9SEhkJd7zgas+IqMR4+3zWBr1CUHjaoVrYYbLKsplkVmpngA9FyE6LTV7QdvVZJW6jMIvV1214jOv+Oqh73bMkyRf/4/jp0B8JMMk41r1AHnyBkyVPlrt3kQPCvV2znc/T0i7hT9nqy3LcR7lLeE2kLDoIwZiM7FwCubYlw2tAcSdGu6VBEq1WpxpWe+cBHC8MhA66/W3vdUYdlqrZ/MOVwwfVAMCatVFqH5hE3zslflIVPc//vd43emSGXnh70KpKM+eswLtre7KOzZu8f0aCcY0XSJPeYd/v50
X-Exchange-RoutingPolicyChecked: 0P8It4YkNrjpgcJYrxRkLIl2qiwAeQ2QCYifemNA6zL+9uqDpm4qEXmQimGNKagN2PoniihFvIFtpNegSFcMEGgGGtzZBxNO3uMfBu0PmVDnfItD4tCzzJDj448lZ0C+stCoNW5b7NX2+o4ejZWipeZuyxyiKi7KHjUf5PGTDr81DOyCXVOfRAqTDusa3NhCEeevO/UhiAA1xLp4AqZ4bedd7aP+GsOxW622lh+3OrXZHKtKIGLhMzVJiJqfOlVvKIvfbwg2EQ+EGDfo8pLEfXK2GSryA23EHrUBX1h5Qiufo1ifof/pVExACtR/LGhiVoTf9MCY759E//m8Cz1l/A==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 12:44:04.7504 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7c0a1af-2515-4425-3748-08df14b95ba0
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6432
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDE3OCBTYWx0ZWRfX+25jYzE6/58r
 SwejYkX2NkRi5t4jua2OSEWKZx9xnkMLHg9e3qfUWb0ui4kki+5wmdadSRRaG4qrEc3FcAYw+1A
 qXfgIJJErW5TNs/tkTomrgDDbryHHJc=
X-Authority-Analysis: v=2.4 cv=HaWB3SE8 c=1 sm=1 tr=0 ts=6aabe09c cx=c_pps
 a=5+b0Cb5m1vs/r/JsbObUdA==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=KKAkSRfTAAAA:8 a=sozttTNsAAAA:8
 a=3gN6ikvcdlQXSCgI0I8A:9 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 8okLSeb9nmTl2QZpLY3yAgLp2RgW_vmA
X-Proofpoint-ORIG-GUID: 8okLSeb9nmTl2QZpLY3yAgLp2RgW_vmA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDE3OCBTYWx0ZWRfXx8sAhY0lLEdQ
 2UM3mCp9mQRcCuOOFlZzxxLXredPSj/IIlWXnadGOB2HPjsR9d1Dz++8mCDPnF0GGs+0I1CQoyp
 Mi10zEyvgUME1ixFXL57qsWxehaWRM5E1S3+vWMTrQtCooO/CableTepXEaAMt0dC5EFTFPwLbZ
 2yb4cg3pHPSSwgV/1fMaZ/bVMeSZXFykppdxkxcvvgsGzmEjHhUW6Q2LYrmzGPv9xq2Z655sFKG
 XQrKnX0nR+Nil4XIfHSfJyHZz/AZKBtFZdzuS8o6+zuFpUx937nQfmaMcPgQw6672sH3sPP7kpL
 amQMpSoitV2mVV7AuND69jX6pjiS+IRIs5lqeqU+ag+nCEdjvULBPvBJtc/28XkTgt8XbF4/8Jz
 hWpk8vXYHAmWy/f9rcRE8tzfOrlVzTet/WecbZWcW+oO5Bl1fYdBmTmB473vtaKUAluA3TwHpeA
 WA7yvLY6S29+zQMtKWA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 clxscore=1011 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609170178
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

On Wed, 16 Sep 2026 14:38:00 +0200, Anders Roxell <anders.roxell@linaro.org> wrote:
> [...]
> ums. Love tested v7 on AMD/Xilinx boards. The rest is build tested only.
> 
> One thing is still open. Anshul sees a single "unknown endpoint event 0"
> line on AM62p during enumeration. It is there with and without the cache
> patch, and the transfers work anyway. I do not see it on X15, and we do
> not know yet if it is older than this series.

The transfers work regardless, if it helps the issue seems to be in the ep0.c
file.

CC + Chintan, Siddharth

-- 
Anshul Dalal <anshuld@ti.com>
