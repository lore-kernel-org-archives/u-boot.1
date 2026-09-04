Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E75E9C624DE
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 08:38:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 853A360C30;
	Fri,  4 Sep 2026 08:38:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u6bZJab9XMTk; Fri,  4 Sep 2026 08:38:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 7042460BD2
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788511079;
	b=BcN1DKseaPvoQSeH9DewOYwOXQJc+4KAmSMTmOOcVObgctmTL0dCZSGxcnm74rEQ3qcF
	 i4C5ZAd8jPP2OL24SIJuv54uBB9cPmQ1q/o+2jAwo1BSbkEcwcsqPXQwRTWfZNsauCEZ6
	 xPfSZREVozHHbU6hXZE6kz3USlcqEoCjhZk3sEW/tVza8kdm9wUeXow4wD5YMAx1ZTh6g
	 v+YpWbrPoXLzW7v+Ae1vhF0pwX3J5xSCiQRpEpIEuTL9gH0RfqeOtWtq1dwIrfn5M6PCi
	 9Bh/B/GhoL8JesydTFtbRKVN1iDd09bxPrZi2jkt0f7TCNyLTzPMj+H2+aKwxq7nhwQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788511079;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:Content-Type:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=U5zbIpuCYBCx4PxeV/rf8DrIkvk5xwrZ07NXTKeHGjQ=;
	b=JqjTzmZwVpwzqAt8K4Q6JeRaotEJ79RtgR+cCGBTGhutiOxd+vNTeklacbt/ySCcAuSJ
	 GV9Noj5xVmJihwFTQJcNMfCk4Sdli9v/pj33dZ35sZXCw8KNSCgEyu2uxxjkicWjnKJmt
	 NZ946yY2SQGwdSMuMeZSrvfap0kfBe/RX3PDeU2nno7b2oox3xF6uYAk3hoqhGm3PimYC
	 Nw4hT2ngbGUJMUTqEzLnUwbjJnJ4rRA7xBQP9c3qO+Py0CmBVJOyZMecIDLTKIr3RITXn
	 239Zwv1kQia9rz4cpiFKGFXyyFnbG4D2ua0KxwvuxT4vQpChHo5/1v5fKzb12QEEJgA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; dmarc=none header.from=softathome.com;
	dkim=pass header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-softathome1-onmicrosoft-com header.b=CaIJv0Lp;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788511079;
	bh=U5zbIpuCYBCx4PxeV/rf8DrIkvk5xwrZ07NXTKeHGjQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cdYsX/1pepBJ9OTfr+w59ayqA5z7wQ/L/RVMC4hJpAShKyPlsSw0cDtdNnY6KlyNh
	 P7xZLoumYpZKunWLFPf/PSAEvq15zUvP6H1Y2rq2JNcRP6GxHKKxMYjBXbSlVx3cxz
	 /7BmrwEWto/PZ0/vi9zCpXTQ4RE/Hzp9MCjHMLxeZGb/UchcDL9f0qovn5n7DLv61K
	 WJFQGoM6CXuZQSxP0pp2SOsVBxiKV8r9QLJG9LyE/4pW19i9VTu+dZy7ZjoybDaTKz
	 PcRkcYSzzglWhq51etW7WAFHjcLVhN66GIEICJKB4cBj40QJDuUZtpmFcM0Ax8Lt2z
	 lh0D+m+nxGieA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7042460BD2;
	Fri,  4 Sep 2026 08:37:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5413F2FC
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 08:37:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2B7CE60BD1
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 08:37:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tAlHnpvMiVbj for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 08:37:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 7151D6079F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20a::"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788511050;
 b=mLrbN+RsOUUrSniC4z50Lis2oxHbodd8E1/jDbk5PftdNdmgIO8/1wc7txO5BV6j3+iq
 iY4hATHST47IXCMGirIY5Ih/6qhnf+vxFlROK+yDTlt6Dln7gfg+vmd7SiqC01n3rAhD8
 e9ZYG7VW6kOD0Rr3Mv9g4d+VMa7Md5PuIzV/joodgeGGpiTZt3iolHN8CojnO3DXsAJjl
 i7KO3YGGe6T4lWSeEK+yOBqEX83RYt2MO6s1RRe8LuaqrLzLNnfAc+xSDqBcPKi4mMcet
 7vW5zP5sqRwYBu3xXwHDz+PCXb7CPUnPZSnwyZC7TBG45IHgGu88xOlRhizfFu5Vj3w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788511050;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding:X-EOPAttributedMessage:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:Content-Type:
 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-Id:
 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=U5zbIpuCYBCx4PxeV/rf8DrIkvk5xwrZ07NXTKeHGjQ=;
 b=HC3poYqsagYURVJRjRwfnYN3eXk/zBUoHrBHjWE4cszjJzhyEYCCfYqRiBNABszTOWZa
 F/BDD5zJ4vh3VFwn6jBBfNryCHpZtw6J1PLzWCwpZqMyeRS85Z7ZcI4nHM/NOvpu8SBeW
 vmX2fx12LY5We7NlrSMpSNzPiFGCTE8coZQ/eIFVG9tHATrmgbP30PnqPI64IQ2/0MI9m
 3zv4u8AJU+yZgEYMwmLQ+eXNUBwn1BhrwkrlUGgt+3q8cDsHcwsuH1sjlpVR2RvBW45B9
 4DCXHBdQKkm9L3jcfeoy4+4VAv/HGzHsawL3TWL9F7UatWp86TEKiDLoKpaIDLxMfMA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=none header.from=softathome.com; 
 dkim=pass header.d=softathome1.onmicrosoft.com
 header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-softathome1-onmicrosoft-com header.b=CaIJv0Lp; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c20a::"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:111:f403:c20a::;
 helo=pa5p264cu001.outbound.protection.outlook.com;
 envelope-from=philippe.reynes@softathome.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=softathome1.onmicrosoft.com
 header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-softathome1-onmicrosoft-com header.b=CaIJv0Lp
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7151D6079F
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 08:37:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CUhfxzivf03DpYSgMrmpuItRN/afS2RGyh381SULowarau3RIaTm15K2UfB9sau7MKl5hCvOm88RzXDP/y0T3Lh6lcdsxlJUCwOjpmcVKCtfdOkmVSxsOFA+M0fH0JP9EYHOkzxvxyK7+LXb2OotXjVfsguS8Ggp+n6y1NlICEEQScx7sLhdwJGsFzwdrmCJsID1z9kKM5rPiQR11GwbEEw1hhOl05c6gl/WMZQrSAcIKq45mKfVZ30+D5pMltkaYasqfh1IYy+yoUUxIVh+/qEVYDWnjNXFMw7ZW/yyhRisA3yus1pdOjGh/6w+VaqTsF9VGxml7VntercnQgj9uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U5zbIpuCYBCx4PxeV/rf8DrIkvk5xwrZ07NXTKeHGjQ=;
 b=pZmQ8V0dG+xU21a4JYzU6S1uC/19IzocCW6MXXRX0doNJu4I8D97hcv4hfMqpT5kBjMrjKFB51oWZ1RkhRDC+MumfQ8EPvZjhg2aU6TqFJ1dHtuViAhlRoT6+wPnXb2qOEgzwbivGzkKx3H3KxUNBPndwQHDpZ8fBebUMdvZJc+V62x7lssFZ85hGR0jv/kQMgtF8FGx7/ZBFjkhY7CuA6lELmM7OsKgj0/IawCIxyzzvVdrFHSqhIq87pr6/fs1HyCMLnXQrIPDTxKN1AOCyWu46UbmCYaKJRHyQcDxhzIzLqMldmQvim/e5gB2EjQQaCltJacALea/6m02m/E1LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=canonical.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U5zbIpuCYBCx4PxeV/rf8DrIkvk5xwrZ07NXTKeHGjQ=;
 b=CaIJv0LpjhdmUt/2YOdbTJTRxto4MXQ3h9osHSOZiSnwwDKQv15FSGXtEDzSHtUsvvxTyx6RYWg1scB+k53Ii+kP8QunWUmrD0w7yNWIzwBJsA1kcfxQpU5dQ/9nFCN0YLo5HAnlMf4tO0/rKsiJCc9Pudp8fnTRVppvkU8sNmCaoHdh7fJT84Q4J+01m/P8klnciAtqOVPXap9kW7jWNEKmlBx5xiDfcYVxV45h1m2DTsmduuLZ6v2XMoUA2yOQzs3s3U1mE4z/4gh2A++BVOoElEyO7ww8IhCmb5A7kmazLULiSRuEV2lx6VdStzlqPLqTQA3E9JKVzXlbCzUnDQ==
Received: from PAZP264CA0113.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1ef::7)
 by PARP264MB6078.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:4a2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 08:37:22 +0000
Received: from PA1PEPF000CC3FC.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1ef:cafe::96) by PAZP264CA0113.outlook.office365.com
 (2603:10a6:102:1ef::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.13 via Frontend Transport; Fri, 4
 Sep 2026 08:37:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA1PEPF000CC3FC.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8
 via Frontend Transport; Fri, 4 Sep 2026 08:37:21 +0000
Received: from sah1lpt726.home (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id C4BC3201AE;
 Fri,  4 Sep 2026 10:37:21 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com, simon.glass@canonical.com
Cc: u-boot@lists.u-boot-project.org,
 Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v10 01/15] ecdsa: fix support of secp521r1
Date: Fri,  4 Sep 2026 10:37:05 +0200
Message-ID: <20260904083719.53132-2-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260904083719.53132-1-philippe.reynes@softathome.com>
References: <20260904083719.53132-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA1PEPF000CC3FC:EE_|PARP264MB6078:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 997db3fb-b8ee-47ec-6408-08df0a5fbd0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|6133799003|22082099003|18002099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: TLtmZg6NvjrxMvRcQdIxX+AtGUBBYcqydW17olajmd+cPYY3ZZbmDHh06PBesCArrCbkjFJ42SBKQMfBzXxlNkZqJONdYkS3wQgN3CEP2dMqFc6DACiciQOTUJmB8bPF7B/Ph76208vqb7FRO1nMgv6yqM+c455EWyj67yx/uCARRFc3oeaiQz5/w5r31aH0XG6QTyTDM9Bx20cPj9qrWE7cHeuEBicuCt1sDtebP6bXkKxlTMWdbAwTYXlN0jVKC33YfHzx2gRPzdvyAMKOeeKd+aCdMknDERWb6C4c/tmH6Nf5ycWQAsdpKJ5rHRhQCrk5QjcoXBtkI2Jc2Kv7fWRkk7P4akSVwM42vTFFEeVYJXeeLqfZi36C78xVBRenucQ6nTgtwD5a/csNgCr2FbIQufuR2lB4kmGqP/uaePfQo3EAsJlAYpCwzM+J0zkS2zIsR2Vu6CAwdwgQaM45KMvbjai6+S35NZm42o1Z6ZjOjqj3wxRKtv6nkkdLckjcbPNZjeVjr/K61fkCqX6RYStjiSZIceUKHGNOqzciz8aZ++hT7inj86Iqn3hrkuXtW/O775j/E4UmrOho3No7p/W8CBvfw7ZSQUCrFVVUAQ8AViunvpR9B1fSdTxtXzwFZWr7i9FG/oDfX51/cAZj74NP34YPTCpo+ef83RDYbm5mRko39fOtPz1YbtE61SGIuKRMQbBWw+ddCe8bcfeRPQ==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(6133799003)(22082099003)(18002099003)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yX3GplWJ+yBWhVPZPUOpZ/W5Yq0Mdr4BUKKS/IDXdPF+lnDjPoBIrOqZyKzot5bbnO5kAQszYdUXOUU6mveU0PCvqRRFot0dTVM26glfRnVcKKo4DhUcWu/OMls76MSEfWFDR6qjhqgznXVS4hD0ospTd+l2x0qyPkdw9l+fwFbnFAK42397kMlihGSh9FU4N1G2ahzevViYYGmImy3y1n3+koxmyIt/BmXTWc4ZfCKF/3yVEJ31B63DideyNux4QnCOzuxVkEXJ/jZVgqniMy9dNZigAX4clOtv7YDbAsVPbPZW34vzW8ypee9u+vohF7GBX7X3ySh2JXIpgW2WqXI4rMHdzG6sRlUex3cJKTaVjElUmP0QOU64ASvPscivchtKuagzt7/USfvNI+ZDSBBXz2sS6Xccmb4Hu4RmvP8ficZXhYuAa3pGpZCT5CE1
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 08:37:21.9438 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 997db3fb-b8ee-47ec-6408-08df0a5fbd0e
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA1PEPF000CC3FC.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PARP264MB6078
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

Current implementation of ecdsa only supports key len aligned on
8 bits. But the curve secp521r1 uses a key of 521 bits which is not
aligned on 8 bits. In this commit, we update the keys management
for ecdsa to support keys that are not aligned on 8 bits.

Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>
Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
---
v2:
- intitial version
v3:
- fix typo in comments
v4:
- fix commit message
- clean code with DIV_ROUND_UP-
- duplicate data before shifting
- support ecdsa521 and secp521r1
- clean code
v5:
- check that x and y are not null before using them
- free keys when keys not found
-v6:
- free x and y if x and y are not null
- do not free key when an error has occured
v7:
- no change
v8:
- check the exact size read in the dtb instead of doing a simple
  test on the expected size
- change memdup api to use the same as in the header include/linux/string.h
- code cleanup
v9:
- no change
v10:
- no change

 lib/ecdsa/ecdsa-libcrypto.c | 75 ++++++++++++++++++++++++++++++++++++-
 lib/ecdsa/ecdsa-verify.c    | 71 +++++++++++++++++++++++++++++++++--
 lib/fdt-libcrypto.c         |  2 +-
 tools/image-sig-host.c      |  7 ++++
 4 files changed, 148 insertions(+), 7 deletions(-)

diff --git a/lib/ecdsa/ecdsa-libcrypto.c b/lib/ecdsa/ecdsa-libcrypto.c
index c4bfb2cec61..b3fc75fac48 100644
--- a/lib/ecdsa/ecdsa-libcrypto.c
+++ b/lib/ecdsa/ecdsa-libcrypto.c
@@ -26,6 +26,8 @@
 #include <openssl/ec.h>
 #include <openssl/bn.h>
 
+#define DIV_ROUND_UP(n, d) (((n) + (d) - 1) / (d))
+
 /* Image signing context for openssl-libcrypto */
 struct signer {
 	EVP_PKEY *evp_key;	/* Pointer to EVP_PKEY object */
@@ -41,10 +43,36 @@ struct ecdsa_public_key {
 	int size_bits;
 };
 
+/*
+ * This function returns a valid pointer so
+ * the caller must then free this pointer.
+ */
+static char *memdup(const void *src, size_t len)
+{
+	char *p;
+
+	p = malloc(len);
+	if (!p)
+		return NULL;
+
+	memcpy(p, src, len);
+
+	return p;
+}
+
+/*
+ * This function fills keys with valid pointers (x and y) so
+ * the caller must then free those pointers with fdt_free_key().
+ */
 static int fdt_get_key(struct ecdsa_public_key *key, const void *fdt, int node)
 {
+	const char *x;
+	const char *y;
 	int x_len;
 	int y_len;
+	int expected_len;
+
+	memset(key, 0, sizeof(*key));
 
 	key->curve_name = fdt_getprop(fdt, node, "ecdsa,curve", NULL);
 	if (!key->curve_name)
@@ -54,6 +82,8 @@ static int fdt_get_key(struct ecdsa_public_key *key, const void *fdt, int node)
 		key->size_bits = 256;
 	else if (!strcmp(key->curve_name, "secp384r1"))
 		key->size_bits = 384;
+	else if (!strcmp(key->curve_name, "secp521r1"))
+		key->size_bits = 521;
 	else
 		return -EINVAL;
 
@@ -63,12 +93,45 @@ static int fdt_get_key(struct ecdsa_public_key *key, const void *fdt, int node)
 	if (!key->x || !key->y)
 		return -EINVAL;
 
-	if (x_len != key->size_bits / 8 || y_len != key->size_bits / 8)
+	/*
+	 * The public key is stored as an array of u32, so if the key size is
+	 * not a multiple of 32 (for example 521), we may have extra bytes.
+	 * To avoid any issue later, we shift the x and y pointer to the first
+	 * useful byte.
+	 */
+	expected_len = DIV_ROUND_UP(key->size_bits, 8);
+
+	if (x_len < expected_len || y_len < expected_len)
 		return -EINVAL;
 
+	x = memdup(key->x + (x_len - expected_len), expected_len);
+	if (!x) {
+		fprintf(stderr, "Cannot allocate memory for point X");
+		return -ENOMEM;
+	}
+	key->x = (const uint8_t *)x;
+
+	y = memdup(key->y + (y_len - expected_len), expected_len);
+	if (!y) {
+		fprintf(stderr, "Cannot allocate memory for point Y");
+		free((char *)x);
+		return -ENOMEM;
+	}
+	key->y = (const uint8_t *)y;
+
 	return 0;
 }
 
+static void fdt_free_key(struct ecdsa_public_key *key)
+{
+	if (!key)
+		return;
+	if (key->x)
+		free((char *)key->x);
+	if (key->y)
+		free((char *)key->y);
+}
+
 static int read_key_from_fdt(struct signer *ctx, const void *fdt, int node)
 {
 	struct ecdsa_public_key pubkey;
@@ -89,8 +152,11 @@ static int read_key_from_fdt(struct signer *ctx, const void *fdt, int node)
 		nid = NID_X9_62_prime256v1;
 	} else if (!strcmp(pubkey.curve_name, "secp384r1")) {
 		nid = NID_secp384r1;
+	} else if (!strcmp(pubkey.curve_name, "secp521r1")) {
+		nid = NID_secp521r1;
 	} else {
 		fprintf(stderr, "Unsupported curve name: '%s'\n", pubkey.curve_name);
+		fdt_free_key(&pubkey);
 		return -EINVAL;
 	}
 
@@ -100,6 +166,7 @@ static int read_key_from_fdt(struct signer *ctx, const void *fdt, int node)
 	ec_key = EC_KEY_new_by_curve_name(nid);
 	if (!ec_key) {
 		fprintf(stderr, "Failed to allocate EC_KEY for curve %s\n", pubkey.curve_name);
+		fdt_free_key(&pubkey);
 		return -ENOMEM;
 	}
 
@@ -108,10 +175,11 @@ static int read_key_from_fdt(struct signer *ctx, const void *fdt, int node)
 	if (!point) {
 		fprintf(stderr, "Failed to allocate EC_POINT\n");
 		EC_KEY_free(ec_key);
+		fdt_free_key(&pubkey);
 		return -ENOMEM;
 	}
 
-	len = pubkey.size_bits / 8;
+	len = DIV_ROUND_UP(pubkey.size_bits, 8);
 
 	uint8_t buf[1 + len * 2];
 
@@ -123,6 +191,7 @@ static int read_key_from_fdt(struct signer *ctx, const void *fdt, int node)
 		fprintf(stderr, "Failed to convert (x,y) point to EC_POINT\n");
 		EC_POINT_free(point);
 		EC_KEY_free(ec_key);
+		fdt_free_key(&pubkey);
 		return -EINVAL;
 	}
 
@@ -130,11 +199,13 @@ static int read_key_from_fdt(struct signer *ctx, const void *fdt, int node)
 		fprintf(stderr, "Failed to set EC_POINT as public key\n");
 		EC_POINT_free(point);
 		EC_KEY_free(ec_key);
+		fdt_free_key(&pubkey);
 		return -EINVAL;
 	}
 
 	fprintf(stderr, "Successfully loaded ECDSA key from FDT node %d\n", node);
 	EC_POINT_free(point);
+	fdt_free_key(&pubkey);
 	ctx->ecdsa_key = ec_key;
 
 	return 0;
diff --git a/lib/ecdsa/ecdsa-verify.c b/lib/ecdsa/ecdsa-verify.c
index 629b662cf6c..494b60b4ab0 100644
--- a/lib/ecdsa/ecdsa-verify.c
+++ b/lib/ecdsa/ecdsa-verify.c
@@ -10,6 +10,7 @@
 
 #include <crypto/ecdsa-uclass.h>
 #include <dm/uclass.h>
+#include <malloc.h>
 #include <u-boot/ecdsa.h>
 
 /*
@@ -24,13 +25,23 @@ static int ecdsa_key_size(const char *curve_name)
 		return 256;
 	else if (!strcmp(curve_name, "secp384r1"))
 		return 384;
+	else if (!strcmp(curve_name, "secp521r1"))
+		return 521;
 
 	return 0;
 }
 
+/*
+ * This function fills keys with valid pointers (x and y) so
+ * the caller must then free those pointers with fdt_free_key().
+ */
 static int fdt_get_key(struct ecdsa_public_key *key, const void *fdt, int node)
 {
-	int x_len, y_len;
+	int expected_read, expected_len, x_len, y_len;
+	const char *x;
+	const char *y;
+
+	memset(key, 0, sizeof(*key));
 
 	key->curve_name = fdt_getprop(fdt, node, "ecdsa,curve", NULL);
 	if (!key->curve_name) {
@@ -50,15 +61,50 @@ static int fdt_get_key(struct ecdsa_public_key *key, const void *fdt, int node)
 	if (!key->x || !key->y)
 		return -EINVAL;
 
-	if (x_len != (key->size_bits / 8) || y_len != (key->size_bits / 8)) {
+	expected_read = DIV_ROUND_UP(key->size_bits, 32) * 4;
+	if (x_len != expected_read || y_len != expected_read) {
 		printf("%s: node=%d, curve@%p x@%p+%i y@%p+%i\n", __func__,
 		       node, key->curve_name, key->x, x_len, key->y, y_len);
 		return -EINVAL;
 	}
 
+	/*
+	 * The public key is stored as an array of u32, so if the key size is
+	 * not a multiple of 32 (for example 521), we may have extra bytes.
+	 * To avoid any issue later, we shift the x and y pointer to the first
+	 * useful byte.
+	 */
+	expected_len = DIV_ROUND_UP(key->size_bits, 8);
+
+	x = memdup(key->x + (x_len - expected_len), expected_len);
+	if (!x) {
+		debug("Cannot allocate memory for point X\n");
+		return -ENOMEM;
+	}
+	key->x = (const uint8_t *)x;
+
+	y = memdup(key->y + (y_len - expected_len), expected_len);
+	if (!y) {
+		debug("Cannot allocate memory for point Y\n");
+		free((char *)x);
+		key->x = NULL;
+		return -ENOMEM;
+	}
+	key->y = (const uint8_t *)y;
+
 	return 0;
 }
 
+static void fdt_free_key(struct ecdsa_public_key *key)
+{
+	if (!key)
+		return;
+	if (key->x)
+		free((char *)key->x);
+	if (key->y)
+		free((char *)key->y);
+}
+
 static int ecdsa_verify_hash(struct udevice *dev,
 			     const struct image_sign_info *info,
 			     const void *hash, const void *sig, uint sig_len)
@@ -76,8 +122,11 @@ static int ecdsa_verify_hash(struct udevice *dev,
 		if (ret < 0)
 			return ret;
 
-		return ops->verify(dev, &key, hash, algo->checksum_len,
-				   sig, sig_len);
+		ret = ops->verify(dev, &key, hash, algo->checksum_len,
+				  sig, sig_len);
+		fdt_free_key(&key);
+
+		return ret;
 	}
 
 	sig_node = fdt_subnode_offset(info->fdt_blob, 0, FIT_SIG_NODENAME);
@@ -93,6 +142,8 @@ static int ecdsa_verify_hash(struct udevice *dev,
 		ret = ops->verify(dev, &key, hash, algo->checksum_len,
 				  sig, sig_len);
 
+		fdt_free_key(&key);
+
 		/* On success, don't worry about remaining keys */
 		if (!ret)
 			return 0;
@@ -135,6 +186,18 @@ U_BOOT_CRYPTO_ALGO(ecdsa384) = {
 	.verify = ecdsa_verify,
 };
 
+U_BOOT_CRYPTO_ALGO(ecdsa521) = {
+	.name = "ecdsa521",
+	.key_len = ECDSA521_BYTES,
+	.verify = ecdsa_verify,
+};
+
+U_BOOT_CRYPTO_ALGO(secp521r1) = {
+	.name = "secp521r1",
+	.key_len = ECDSA521_BYTES,
+	.verify = ecdsa_verify,
+};
+
 /*
  * uclass definition for ECDSA API
  *
diff --git a/lib/fdt-libcrypto.c b/lib/fdt-libcrypto.c
index ecb0344c8f6..090246b44e9 100644
--- a/lib/fdt-libcrypto.c
+++ b/lib/fdt-libcrypto.c
@@ -10,7 +10,7 @@
 int fdt_add_bignum(void *blob, int noffset, const char *prop_name,
 		   BIGNUM *num, int num_bits)
 {
-	int nwords = num_bits / 32;
+	int nwords = (num_bits + 31) / 32;
 	int size;
 	uint32_t *buf, *ptr;
 	BIGNUM *tmp, *big2, *big32, *big2_32;
diff --git a/tools/image-sig-host.c b/tools/image-sig-host.c
index 5285263c616..285547994ca 100644
--- a/tools/image-sig-host.c
+++ b/tools/image-sig-host.c
@@ -83,6 +83,13 @@ struct crypto_algo crypto_algos[] = {
 		.add_verify_data = ecdsa_add_verify_data,
 		.verify = ecdsa_verify,
 	},
+	{
+		.name = "ecdsa521",
+		.key_len = ECDSA521_BYTES,
+		.sign = ecdsa_sign,
+		.add_verify_data = ecdsa_add_verify_data,
+		.verify = ecdsa_verify,
+	},
 	{
 		.name = "secp521r1",
 		.key_len = ECDSA521_BYTES,
-- 
2.43.0

