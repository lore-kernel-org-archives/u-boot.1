Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FB0ACA5FC1
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 03:42:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1158060BC4;
	Thu,  1 Oct 2026 03:42:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2DOvRYeUz656; Thu,  1 Oct 2026 03:42:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 26A4960A41
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790826151;
	b=YPog07Cq2TpsKZxw0yDAZEtlQTaF6UN5wavtAB0ikNKc0BpZkOE97SznWOtqIm+r/Uwa
	 jefR+pUcEnMwEAX/ousw+YmJ1B0p5DoAEJAlWNZbwicKdcDFRLFn/VLQfHc8k4hZ6WkeM
	 C9K1mxuL0EwaNLMFNnQ9W7NVXfhgzpsHPN9fEzwTk72W2iZuZ8PbQmTJrdJHh+xCyUVcy
	 Ja4GbQ0j/BDXd0lommx2WzwBf16JSU8I8TD08OcBRDpYJQ9sXG+BP83yz9Aj1wE1Xq7jH
	 emvG2tv9XGqRd+WeXRYjZMQhQpxEc08jzEX2/3tZE2bGtoxBoIhYpQGUV+5ii7u5YHg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790826151;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:Received:From:To:CC:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
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
	bh=6aqfCP/Xo9QKRgUpd/34fh3uaB2/SPwLmVez8CMQzyI=;
	b=kCXxbtgikm/denz87lSe7LzdyFJdy0xnb++6C5AUFgjPmzjkCgyxBJLfupLCzbJ3BS8K
	 kukOfzMDqTade8uSnAPRv80dBwzr/VnI7jIqELbEh4s20PU3qQMx3PvQ+X93jLd/kkd30
	 7vq1zcl/bbkGX/ESbV9q4yRvkZ7CD3DE1Oa13CJ8RVUMlaiAfZ9fm9cy8eyPlp4TlxWO4
	 dqLx/UAwly8yv2fsiJzyo3Vr3HZtUkxqy+2vMWhVi5qVqHCi/7aE6QS0HpewBngnGYS3Q
	 xZ4OKqTe5C7/sDV6T13nxTUlnSXgEuQsXRy+wX/oUIAduUX2vj/MWGbVV4QVVlvPMFQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790826151;
	bh=6aqfCP/Xo9QKRgUpd/34fh3uaB2/SPwLmVez8CMQzyI=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=m42cEwgmdfrtcKVg/Fh/QO57c9jGorM02oan/0sUatWcfRHI670XZCr8IFOckZ/x4
	 GkG9qQhGADI9/995oaQtIpy9RRZIoxCKRjyVHeajRkVYmVQxLGJJXWDrYuBIK5ZbxN
	 +uAyRJpDHr9mmliaJwTyuscMWubB51/li1XfuWDMv4HUzyHaQO/sUfIzhtd75aRLEK
	 HhBgK1karoa7LOtNmrXVkFoiFP1NsL77ZhS47W3B7qseAwMOvVakpbVJMyEN/W/tfI
	 JHwg07n9sggK2VH9XwMHrchqKhG5vqHfsHATgS6hJ5w3c55ExXJPa8nJFqQYBKXj/5
	 1MTpLmHxTTpog==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 26A4960A41;
	Thu,  1 Oct 2026 03:42:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id C007F33B
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 03:42:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0E651405DD
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 03:42:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u7qmEvYlCCTL for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 03:42:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 99B85405AD
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c105::5"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790826146;
 b=U0apmiStYEpRmIIY8xGd8HSmI1PHJO71Z62N0PB3VrzZ4wMfaiSlXTZq2GUrKJExdJHX
 cIRRc6reLcFzrTA974Gz0+XDA8E23dkF7V4U9Nb/0kEIPJhpGxXfjM28NADhe3aU4oRqz
 7LsF0XIJ3Knkgud3LblmDlfVj+wWiTo+mQCuMJVHLpirXDfdaqJ9pm928JbiFv1f+SnBr
 OVNzEYvM8z2xH9Y9oGQTS5BRJnuAQmXeqtyLFcmXCpfCEiT++ZkIbwOc4e3yMV4yjDkOm
 GlJIC/HhyDaF4jrzxl3EGK/moEtaDrqdTfwTrbe8eU4mMAjZ5x9CYw3Kflhr2OTX7JA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790826146;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 MIME-Version:Content-Transfer-Encoding:Content-Type:
 X-EOPAttributedMessage:X-MS-PublicTrafficType:
 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
 X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-Id:
 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=6aqfCP/Xo9QKRgUpd/34fh3uaB2/SPwLmVez8CMQzyI=;
 b=TDQvrcfrF+Szi7FXeQInDmIJNhbjuQSlF2oK9blTzOvdRTcamBu4lj98ZA00LEQADDw3
 0aDNghrLT/A8kXB1vdWbC93k1vS97ifIXG1mYZHc28qy8W0fqSxvcCLHQXYbNfOQRNQMA
 zCW2NtJwZFtnrhDN8zLGMlN753Nc479betPu84L+pRJ3OjUiPRO7/m2PdBV73UasPcltN
 YWroEf7M09VszfAWzOAmgQRVJOYwmbDFHcVK7xQUIZJtMhc0iZIFRdIBsEYSPZ748jqGZ
 spPWPs17l9BnKOHIHtZykFGmQ07UtJQnXzzAqoWtjsi3KT/Hoxlur9cKJ4DAA8/fZ7g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=amd.com; 
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=H6CezL1t; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c105::5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c105::5;
 helo=ch5pr02cu005.outbound.protection.outlook.com;
 envelope-from=suraj.hanumantkakade@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=H6CezL1t
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 99B85405AD
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 03:42:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P1AiVtQL2iFF3a9x8jyHg/472o/Quso6oju7dhtsbDefOKym7IDXO77JU09noiBaD1p9Oc4TkSORK5XGWAHsl6ss5qc9DrAE7ZBgBdpLsq2AUZCYU0rv/ikMw1NZaZec55O0253GC2Xcke3RQcd1PN8P5tSeCgmAZTAOPUAAyujFz4QWjPLsLeNtub733HA+d862ppJCUdGL5frX+qBM50bTAODTCTJwfXW2c6go+Wvsa7MD9Qd8hAC5pOODlu4nJdRexkfJ+Wt6e5zVoTUDnAoKY9OHxo8NqILW9NUjuE7+8DGcJqRjoL/y8shIbKMwzF21zJzftXitmeK0Y86vuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6aqfCP/Xo9QKRgUpd/34fh3uaB2/SPwLmVez8CMQzyI=;
 b=FFGstfBqMTDF0bUy25SxUEcdvfKDC170FLXA3J5RhM9GzjFPhHyhLYnO6hfNezDa7OIi1SDWkiE6SJCcmlJOP5YQ2lhclnNLoCQIkMcDCYqkGjsBNXVDUPlkxX+VRdpTARjLmL2STUd/p0VC3lgfF7ff1n27SstTg4pZD1pActqpIeRqmH3UJGJvx5bQx0eD+p/BL5Z83OOfJbMQQWPQLvhFztZh/7Xpv7a/mMutEeRCDMEVcc950ZC9DVJMLw4sxTUv07T938iw080YKrs/lFCs0iI9FkqoNA3EkwWjDss+meK33w4ekLT3uwzG6teO3ccHqkxyWuAMjchzrAOq9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6aqfCP/Xo9QKRgUpd/34fh3uaB2/SPwLmVez8CMQzyI=;
 b=H6CezL1tlDCVa30hVRIu8WICJn7mdiAJ0UCGzWeancBykWoT3sycEIjNouCXXMo23GeEhZDE094BcoRfTPfFP/aLOiNKuwXM7Vt8FRvM8qDKr/2DNsgTleI+MrUnxzZ5vVIsc46t+dkvK8gBtIckb/Bm7u0jwFotfo0xR3iLEHA=
Received: from BN8PR04CA0057.namprd04.prod.outlook.com (2603:10b6:408:d4::31)
 by SJ1PR12MB6243.namprd12.prod.outlook.com (2603:10b6:a03:456::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.27; Thu, 1 Oct
 2026 03:42:15 +0000
Received: from BN2PEPF000044AC.namprd04.prod.outlook.com
 (2603:10b6:408:d4:cafe::3d) by BN8PR04CA0057.outlook.office365.com
 (2603:10b6:408:d4::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.16 via Frontend Transport; Thu, 1
 Oct 2026 03:42:15 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000044AC.mail.protection.outlook.com (10.167.243.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Thu, 1 Oct 2026 03:42:14 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 22:42:09 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 22:42:08 -0500
Received: from xhdsuhanuma50x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 30 Sep 2026 22:42:05 -0500
From: Suraj Kakade <suraj.hanumantkakade@amd.com>
To: <u-boot@lists.u-boot-project.org>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, Suraj Kakade
 <suraj.hanumantkakade@amd.com>, Tom Rini <trini@konsulko.com>, "Francois
 Berder" <fberder@outlook.fr>, Rob Herring <rob.herring@calxeda.com>
Subject: [PATCH] boot: pxe_utils: Fix NULL strchr when parsing append initrd=
Date: Thu, 1 Oct 2026 09:11:38 +0530
Message-ID: <20261001034142.3487023-1-suraj.hanumantkakade@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AC:EE_|SJ1PR12MB6243:EE_
X-MS-Office365-Filtering-Correlation-Id: a67445d5-7ec3-40a5-465f-08df1f6dfbab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|82310400026|32650700020|1800799024|18002099003|3023799007|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: vCkP9wDNG3FNRBscIj8/WUthb9Lb1fDTscFNkOPundm6Jv+OBZ5gZo+nxHhz476fg//SvqxJ7ZbefEKcd6+NrSTReWtPB5rfva3u4xpqWLWw1hYExBYlgJkp4iRBgWst1dc9OgBp3zGlToJw1EEvaJTGvqq6ANs9Ie5NZV3SphEcW/5bD/SDriC9woSslvuee4hZF1WSrPQq0PbVFe83zDemzl58KsiB/Rkr556l6TzBakq9cU97rIILjl8f/nVnBvHBiRzSNsjjNo8RqmxlX6bFSx0xteFST/chiSVhP+GpgPKvOVIDec0mXqEg14qXCPus9AilIF5YA4gRxJW/7SpZu6kjOG9WHjtmOvBfyt+ihPxO1tbIc6qYDVddd++L1fE57qw92JZ/9Jd508ApG8fA0/yqnCgnlz/HXiIOYoOb8ceRBcuNb0IQcgHHOm3MysTaTzgimMIQEAykShGR5FQfe+d98iiXkVyz+MQCn+I2RvE7Vi9x0R9FqE/5JuKtGT8KVBeO+bcyqQ5WVtsF9z8BACxli7+NsCHIZMPApP1xWgZAR3qt5kY/yvlwhjT7UL/CxwKj4oWSIoIfJ/ddRGLpmsg/jfaFYsh8r77c7UrqaTvka0jfRbEopwticjJ4laTY4TAJe+Kcm0DqlcAJaKM1bFpUrmp2d5nZ7UnF4zvUIpsrDmcoav4DDrOLs64WdtSg12SqRD0JW0pANUhFlw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(32650700020)(1800799024)(18002099003)(3023799007)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: L1tPksNa5UDG5tUiZHtj0QFHp4nLjHv/PPjjl/63vOF5RLp4cqJ0RvtkoCLTzxO3kMHAfMO/V3HWDD++J/nqAfywa/8uEPLnXqp2W4tg4Llhac+6Lo5sO5t6B26Ewe4xgiUVW55UONx+WagfKQOVsC/VLwVfwJX1AzCLaxmEumbp/uBcyRaOgUMB6g9woUqg1KgK7JMBwPlR30x/Qw4psCVGqOZV8GH0Yf9B651VOC2axyQ7Zotz2XDx/V3Jfvvz/Ckf6g4MznY1PHs1wlpf/y4FL1bYJjUi0yia17Joiry8N/tJ0ffxGoyL7MukyfFCrgkL4bD3NOuKi3kBVbOE/dwHzxb0tMfdwfVJeF6WIJQnHPrRh8RZPw+PQqoFDJxFP6Cc0ePObC0h8eAtYn3E8WwMOo49W/tIxuSLDiyp0n4lxpfE23g8OGk8KgtU1yIB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 03:42:14.3665 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a67445d5-7ec3-40a5-465f-08df1f6dfbab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6243
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

parse_label() takes an initrd= filename embedded in an append line
and computes its length as strchr(s, ' ') - s. When initrd= is the
last token, the append line ends at newline, so there is no blank
after the filename. strchr() returns NULL, the pointer subtraction
is not a length, and malloc() and strncpy() use an invalid size.

If strchr() finds no space, use strlen(s) as the length.

Fixes: 34bd23e42f3b ("pxe: parse initrd file from append string")
Signed-off-by: Suraj Kakade <suraj.hanumantkakade@amd.com>
---
 boot/pxe_utils.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
index 8c1310dabeb..d4c57ff11f9 100644
--- a/boot/pxe_utils.c
+++ b/boot/pxe_utils.c
@@ -1285,6 +1285,7 @@ static int parse_label_kernel(char **c, struct pxe_label *label)
 static int parse_label(char **c, struct pxe_menu *cfg)
 {
 	struct token t;
+	char *end;
 	int len;
 	char *s = *c;
 	struct pxe_label *label;
@@ -1326,7 +1327,8 @@ static int parse_label(char **c, struct pxe_menu *cfg)
 			if (!s)
 				break;
 			s += 7;
-			len = (int)(strchr(s, ' ') - s);
+			end = strchr(s, ' ');
+			len = end ? (int)(end - s) : (int)strlen(s);
 			label->initrd = malloc(len + 1);
 			strncpy(label->initrd, s, len);
 			label->initrd[len] = '\0';
-- 
2.43.7

