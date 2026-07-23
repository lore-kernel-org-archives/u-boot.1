Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDAE3C44536
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 01:14:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9C2BF409AC;
	Thu, 23 Jul 2026 01:14:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UpOE6LReibyz; Thu, 23 Jul 2026 01:14:46 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BA748406EC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784769286;
	bh=+PaP2S+F2iYOvlB+yrqBWz5Hn4gZ3/1fy7/qqLerHG0=;
	h=To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=JWEm+pAssg1N6dMzrUOf9rUfpX3ISEHkhQ91ktmmpNKFH/+WnRI/y+HP2IrEs95L/
	 oLFYXFKABEbkdt93wX6hoJ9oxnXTVFZoQfND/5Y6we5/xcjl35tz98QdqhMQYI82Rt
	 eAR95DcBBSLD1nDACQh7hrscO//L0Dl+xcWmlKmfmt5e/eIUnfVMTRYKhofQoGi65F
	 IFjAcfGJdKFj84g5jn3PbvZ0PsWMVNeoxzi+iCqq24TGba8IklTVvpLbfDHPN4+TY3
	 /7FBNap/d+MppEbzda1cs3pGI7bNX5/YhMPeiLYbaqM5OemXxErUgknZ6xX3SOh0FE
	 mIh9VgWEKsOwQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BA748406EC;
	Thu, 23 Jul 2026 01:14:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id DD5D82E5
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 01:14:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CEEFF4018D
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 01:14:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z7ZL9F6hMBkP for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 01:14:44 +0000 (UTC)
X-Greylist: delayed 1343 seconds by postgrey-1.37 at util1.osuosl.org;
 Thu, 23 Jul 2026 01:14:43 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org CF93E40167
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CF93E40167
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.146.23;
 helo=mx0a-00498f03.pphosted.com; envelope-from=dmukhin@ford.com;
 receiver=<UNKNOWN> 
Received: from mx0a-00498f03.pphosted.com (mx0a-00498f03.pphosted.com
 [148.163.146.23])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CF93E40167
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 01:14:43 +0000 (UTC)
Received: from pps.filterd (m0367124.ppops.net [127.0.0.1])
 by mx0a-00498f03.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66N0Y6CT3680662
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 00:52:20 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11011035.outbound.protection.outlook.com
 [40.93.194.35])
 by mx0a-00498f03.pphosted.com (PPS) with ESMTPS id 4fk3rs2e3t-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 00:52:19 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aIOW+0W+dSUa2MYdEdl53R68CfQ18nRW5uIyME76GVYOtMMTroh0xIE0XDiNJNat0S1KsV5unyGVWZaK7xgegJ/O0De8K+akr12FWuZN3TeJF1UIZZYhrbIvgZV8brpuNZpQMBqrMCvrGHt/PQb3sgLz/gAgZ5eSd6bUm1UeB57ja7QBdA5nAeyrw/vYxZJsjohN0cvRMkU60Ii/nvyL9JMB5S52eWX824Ef0hrrYbuHyaR9S/yce1vI9ZiNWTpg43+phl9bJzV5/Vom4SP5jZd70e1OkgUf+0BRbZWlQt8k0ib2aEH2/hOUSpUnNCT/IUGCksdBjeoYkoi6DNJOTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+PaP2S+F2iYOvlB+yrqBWz5Hn4gZ3/1fy7/qqLerHG0=;
 b=vkAMg0TUmchcdIDkpx89X395wzxX5w8GMZwwZdqotbvSMpVqHCT9tbdK5EA8+t3qZGBJXNMlN4kZtd6Ifz0PtO7dtNBHayzt72iNPwKugKbRs0MNPCwpTMC2BGLB4ZKFoRm7D6QTJlymhe7AhyGL7oBuCiA+a7Qy+uzTwzSKqLrxEnwaBjWidkCUHmAV+XZCbMxG+OORx+dtyk4TyouqbExfI9oJGeU2vnZAfYGgSrJOyy19OvbzuYMh1a5mi2WvI/AslefabMOMiyPX/zkpZ9MjtLveWLdFsUDffq2hiIYEwEmUzBKiLg/jQy1JWmuyTDOJh+Ond8748j9eqBYepw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 148.163.138.245) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ford.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=ford.com; dkim=pass (signature was verified)
 header.d=saarlouis.ford.com; dkim=pass (signature was verified)
 header.d=ford.com; arc=none (0)
Received: from PH7P220CA0172.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:33b::33)
 by PH7PR16MB5213.namprd16.prod.outlook.com (2603:10b6:510:2a6::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 00:52:16 +0000
Received: from SN1PEPF000397B3.namprd05.prod.outlook.com
 (2603:10b6:510:33b:cafe::8d) by PH7P220CA0172.outlook.office365.com
 (2603:10b6:510:33b::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Thu,
 23 Jul 2026 00:52:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 148.163.138.245)
 smtp.mailfrom=ford.com;
 dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 148.163.138.245 as permitted sender) receiver=protection.outlook.com;
 client-ip=148.163.138.245; helo=mx0b-00498f04.pphosted.com; pr=C
Received: from mx0b-00498f04.pphosted.com (148.163.138.245) by
 SN1PEPF000397B3.mail.protection.outlook.com (10.167.248.57) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.5
 via Frontend Transport; Thu, 23 Jul 2026 00:52:15 +0000
Received: from pps.filterd (m0426315.ppops.net [127.0.0.1])
 by mx0b-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66N0XHah2849536
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 20:52:14 -0400
Received: from smtp-us.ser.proofpoint.com (pmta-usw.ser.proofpoint.com
 [34.209.42.160])
 by mx0b-00498f04.pphosted.com (PPS) with ESMTPS id 4fgucpmr2r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 20:52:14 -0400 (EDT)
Received: from localhost ([19.12.76.222]) by cmsmtp with ESMTPSA
 id mhfXwDSDtRF75mhfYwcqyk; Thu, 23 Jul 2026 00:52:13 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: mhfXwDSDtRF75mhfYwcqyk
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
To: u-boot@lists.u-boot-project.org
Cc: sjg@chromium.org, trini@konsulko.com, dmukhin@ford.com
Subject: [PATCH v2] x86: add support for CONFIG_REMAKE_ELF
Date: Wed, 22 Jul 2026 17:52:03 -0700
Message-ID: <20260723005203.36715-1-dmukhin@ford.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
PSER-M365-App: SER-APP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_01,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 adultscore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607230005
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B3:EE_|PH7PR16MB5213:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 2bd21636-113a-448c-108b-08dee854a3b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|23010399003|1800799024|13003099007|6133799003|18002099003|56012099006|11063799006|5023799004|3023799007|10067099003;
X-Microsoft-Antispam-Message-Info: 3YN923wFS0WPWE4x+/3qA13IxtS19SjZ9iJd+x+oAZOAH6KRS0Mj8ZXcQo7BndPioex3CvT90ttpDIyO2y1xSdkQv+7uXGRiCyM6YtCu+a2YQWU7hxKS1NLKYX3Q0M5kdd9VW3PAD+MpKp2GFKLHYRavCjJ/Zvhub2zeq6b1h3vXpelMn41rIWw+P1yaQiGtXc+/Qkh0J1IW0IFNgK1wHlyRWzRREoTxn5vEtEdv6SvQyyOmDFDkZUaUB1ytl4hZTbI3eCs/QYQb7x68WpSlvnYn1M5+vg+g4DH7Quay+ZwpyshRRu9rVHCAwcqUV8VofTORxrsE3XSoDKg5h6+RXjLzIVfYR6QzziiZp6IPeltzfO8GdhCdvBmsNy6b/uVWC4JJG96YUeWW+VXKdNGD7nthVbty+ucgIX7FIjyoxElaA/hJ1PavZG0VMwgBfww4ddx/lZQLQuYLkaOWaBi3E/cv3ZfdXCYhbI96NgnV88GUHeJF/e8jPk7s+r5n3rrCQhY4Tero8pKRXTrdy2X9Wx5kiw9gWLLwez8IWLSoq7xpXajPPFWyg9tTzkqopMLCuiUKtfN7SlRrqHBYa+NtQIa35yuYKzuxaXy/qioB5JP9egeEG357jT58/sH9lh6cauMa4NmjCjPEYX/13AZKA248S6ynqTkLqrj4z96trxolKXKBt1Z8Gm/v4EBRp1OEZaUQeRyv8UtU1imEFmrv4Q==
X-Forefront-Antispam-Report: CIP:148.163.138.245; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0b-00498f04.pphosted.com;
 PTR:mx0b-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(23010399003)(1800799024)(13003099007)(6133799003)(18002099003)(56012099006)(11063799006)(5023799004)(3023799007)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1yjUYlW0U2LKqvONvnAisgtyfbrqIdwHoibjzeiKd6ex7pI55QxAhDJlk+2NocqZSSnTgSkPSe5Vtbpvc2TWXm9Exd1YIl1ycgJQNnSCMbtEWuAJnWrXbOdFsgVqqoCnuLNQKOqhEj2M4VikzZUUePfjB92X5tIV0mjOGSkbZlF6QdcZvruIArgF42llmfePbtcMaZqWNO3ZVm8NRCP3Q/Gsk3UrQhi+T1wTcP5LebNH90P5otFPUOdKu+yx3rvdCQHx+nJYkmIMYQB0oeACu0ANH0hlwkG/WqPADMYUH/550FGMomfDmMVP9WxKTkVmZIowLgymUgTEnwkLvX1HRYephY94wWlKK8GXqRIw+5/rs0hpV/SzlZoC5HCLDmzK6WzA7S6Bm00Dzdw//T1+6Rv4DTQl8ISWZ0+BJ/uPwXj5xf5XR12j+RC5wF88J8OO
X-Exchange-RoutingPolicyChecked: JVcnFGBG6dC7MFo5LxfGDX3B+LMHyPvTp1J0biRnQWnd6GoPR0D4RHRFFyA9+7Bk9PuqV4qSLNcLfc08YQjz5O5tNryfMgQJvQ1MK/cUDts/i+18o/3OyUA3i0wvbC0b+8mWEHgLllDIA20QeYVMyQBsjxSVCjXXNE579JobCB8+ey0A7SfVXK62iMu+NzbMbJxvbi41+3E/rFjopzF1TWw8/2iVBrx77Pi9Vamc88jZo0vvYnu8oTIottc/UloBDPfsr+5+sbutEZroQUb8YEOiUxkviCCPQ+REmEO1vaEXMLl03vpYUK0y4w9AKNIoTww03DFJ5CDb56kepg/+lA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: uBEV5ioS08iqWpmVb4wYBxg6ApEHS952Q8d3ccz3oo1ncMZsYqcmFk9ywckcLARLQo8WrRE42Qy3ZtiAjEq23ZcqTNSznriNlllPS0Ysy3duDoRV3tz6UhsyMxfQTFpClGeMr7Oyha2FV3SviLltvyD78LfdSi3aWPq9gIvTSJdwh7j737AHXGJE7WbyAtgAxPTg1LbJnVcv+Qe7gm1nV7uhYC2szhRDEt/MqThTgP+JZvyE/2APJ3/BfcG7K8O17REsEIpx27ftb5q2i4v38ZeQYo/Hxe+JcJv3IpA8oLWJ5xvjeBJ3YMACdHdd+wIx0YLwX/kujZ+kZUyWwVPKCk65X2FXXoTf0gnFAGY1nwmna973jqU8g3gUMC4XKjcpJehcZyRFT1DvsL2Oqy1UpwHtaOKBErfGoPW9SwV97DJ49WVfrzYahdqG6D5zu7KYEXXVInnHp7XGo2fXF5JcJ10b3Dt54UlKorY3FuAdwYddRLX44mFZWXMJL28tNT25Kzp66BIlnj77E4sMOXhihTVYix0rvPW/xjg4eJ38kZL5QXW66NKsacDRXrWHrflY4lgdK/Ab8eh92T2HdXgReRYtDaBemODLg2wzfEUlXp5GDnMQeUtBmP3lAYRgwk5ZA+pfeO7V7UyJiDhRu8sphg==
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 00:52:15.3395 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bd21636-113a-448c-108b-08dee854a3b4
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[148.163.138.245];
 Helo=[mx0b-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR16MB5213
X-Proofpoint-GUID: XRNxTZYyQxfZJ2CNXROVAymCZjkBp3Ur
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDAwNSBTYWx0ZWRfX9dear/iCZM4V
 R0ymuL0e6in9fSApVcCahBW6tcQnshmLkIqLNbQ7ROq7WjxhP5knDSIE3Z99WTw5olN6oa1xf0Z
 vCJ1hstO8M07B6YzjQiQ5/svG98oaXU5VmpQSCLe24Cu+6mYlI2h
X-Authority-Analysis: v=2.4 cv=bLsm5v+Z c=1 sm=1 tr=0 ts=6a6165c4 cx=c_pps
 a=ALJIVG5iHo/ZE5SKMfQyZg==:117 a=b7IhknPlfT0FN1EembXvig==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=3PXLN80vpJUA:10
 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=P_n1zlmtWsCQbjROFjcg:22 a=YJXg7OVxOWrJwj3yZo-i:22 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=cbNQJ9GKAAAA:8 a=f9DVwT8e75DptqcLdvUA:9
 a=P0bj-C3X3jJDpopQwM1U:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDAwNSBTYWx0ZWRfX5hn8W0xSTr6f
 YL3I6di/psPyZFDKnarZr7ORLq+4YgBqiFFen516na0QAEP8jZSoU2hK0gkUCQkVpnPBS9ioWYp
 LZG+uRI7+2tbgFSOVOOInJczdqAaXorOpaAfPPxIyUgha/VnAJ+csVfxhzTQtIQHdNpwyP1JqZj
 bPh4yEt5+A+/XeEgBNftPlj39cr0jmqn5HGeCV5sIm9hA7nWMZcrWw40ebwfmEJn/1LoChBpbHO
 u0xZQRm6TsoTydn3/qY8d/k4BNhYsupnLhWhm+eXYogV3atRdk5v7Q6ch4nCU7+cQzi3pWfePVh
 UpWN3QgFZ12mcll35GZaUSd6iNE+yaMSotXdyU2x26f9xruhNFtqqstvZY2n+FgiYPicNyl8aR5
 pvn2mzi6/ZaLWTwFZ/wELd0c/Qj3vjcKYEmBXUqA75ECoYhkB8sbRGsIGmDnKjDo3Ne9sAdoPM6
 gHrit9ZxAVzKN7rsieQ==
X-Proofpoint-ORIG-GUID: XRNxTZYyQxfZJ2CNXROVAymCZjkBp3Ur
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_01,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 spamscore=0 adultscore=0 impostorscore=0
 clxscore=1011 priorityscore=1501
 malwarescore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230005
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ford.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=ppford; bh=+PaP2S+F2iYOvlB+yrqBWz5Hn
 4gZ3/1fy7/qqLerHG0=; b=KYb3imAYabtLPavJa2d0HSDiV0QpPeRHpSIYJgVNh
 YqBeD3FA7sPf1zVM5kyyjKp+Sb0Ss6O+8CEN20zqN0c1QCN2L39UeTYqL/gerMQY
 iJoZeRDMarIRYuTVtYk2aDNATimUQ/MekqGKRbvpQdhLzL1JSUeIz7+ftBgyW/Tm
 El+7M1PyjoTqmnjXizaBtDe257c5bf1YMX5gr7H5zEDPZ/NgjUgD38KdgbusLX1N
 xC84O/ybQ8ERoW2BJeLZJZZdI6zeC3n1ZPvJi+s8Zo5Ib+TWOksnBkZfX2F2dFWc
 uRunXNlo3F5Ytv+V5iGOhfkDT+ZgHPztKgOS30cJ9yIqw==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+PaP2S+F2iYOvlB+yrqBWz5Hn4gZ3/1fy7/qqLerHG0=;
 b=fhdp6gmwwc9JwOhtcWU1BCSPco3sOy+Hrrud1rQzhK/+TVyUASjP5Pyq70ha0K7Vwm6N4T6rFMfqXnQGBBnLqoa2hmKEfL1DgYLI9bPkZcZN2YYSi+wfbD1d9IHPFpXdpWBMzcVq8PqxggBRHsE4GO4jOnGl6TAo0VP5I9g7ckc=
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to; s=ppserprodsaar; bh=+PaP2S+
 F2iYOvlB+yrqBWz5Hn4gZ3/1fy7/qqLerHG0=; b=K3g0Su3OWVL7qPymOEOT01R
 PuHvmbB7mIu78TymVfqNqp9UsdBpAdEDbG3LGc+jjSgP0d5VIDbIDYVh4Ffz08Vp
 t6SpYYmikXUThC1zaBfZa1CTC6VW1ZusvQ7zD44k7+3uR+uBuZHZwwgEhYjl+DU4
 osiLu9nJhAavo4HKiVBOKOUDUStv2IAUxP1zMYhfzXM7QjcF8uvdlwVUhVjURMLe
 jznuGfWouf/dSYEJg6LU5UqFWasxFAmKGZdzrvgr1H1j64u8dwAEEZS4m+jbOhAP
 8MihWRvS8x3F2PwXDxJE4K6ttHh77B3/V7x8GgNtYRds5AikPN7ivnSvC7u1Ekg=
 =
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ford.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=ppfserpocford; bh=+PaP2S+F2iYOvlB+yrqBWz5Hn4gZ3/1
 fy7/qqLerHG0=; b=a+5uaZQjYNK/ejIYKhgH1sb2X7D4ZJQMwCfK8LMoUXwaQyE
 rsFM72IjmbgmYEo+jUwqmiwJFwlkvE6Bca8CZdUfTUBfb2FK1xFPtF4PhtdkHAOM
 +sPMkRSWq1C0y0+Pt8Mj3nwpnboJIzIsZYdJcSKcEEMhxQyHCo8lFJoXpoYL0CUZ
 9hqCG6ZmE9zo9qtTciEGyjTT5ocOOlJf5HKf2SMKEJ3RBKPyiBoGbkJ0vcAKqpxJ
 UeoUyvNmIXnbdQlPKgwqf+CURxvyib1qv4ic68Ek+bPzbbNPUPqX8Yf7MFRtXBvA
 EDqtAxro2mbqD3++6E+c1pd2ikM8RP9IZyxL7xw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=ford.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ford.com header.i=@ford.com
 header.a=rsa-sha256 header.s=ppford header.b=KYb3imAY; 
 dkim=pass (1024-bit key, unprotected) header.d=azureford.onmicrosoft.com
 header.i=@azureford.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-azureford-onmicrosoft-com header.b=fhdp6gmw; 
 dkim=pass (2048-bit key, unprotected) header.d=saarlouis.ford.com
 header.i=@saarlouis.ford.com header.a=rsa-sha256 header.s=ppserprodsaar
 header.b=K3g0Su3O; 
 dkim=neutral header.d=ford.com header.i=@ford.com header.a=rsa-sha256
 header.s=ppfserpocford header.b=a+5uaZQj
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
From: Denis Mukhin via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: dmukhin@ford.com
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

From: Denis Mukhin <dmukhin@ford.com> 

x86 builds with CONFIG_REMAKE_ELF fail as the following:
...
u-boot-elf.o: file not recognized: file format not recognized
...

Fix objcopy/ld parameters for x86 to enable CONFIG_REMAKE_ELF
configurations in both SPL and U-Boot proper builds.

Add a new 'PLATFORM_ELFLDFLAGS' make variable for injecting
proper linker arguments when u-boot.elf is requested.

Signed-off-by: Denis Mukhin <dmukhin@ford.com>
---
Changes since v1:
- added SPL build
- fixed commit message
- CI: https://github.com/u-boot/u-boot/pull/1016
- v1: https://lore.kernel.org/u-boot/20260716205213.340109-2-dmukhin@ford.com/
---
 Makefile           | 2 ++
 arch/x86/config.mk | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/Makefile b/Makefile
index 56f59c24cf89..ab2121c87007 100644
--- a/Makefile
+++ b/Makefile
@@ -2003,6 +2003,7 @@ u-boot-with-spl-pbl.bin: spl/u-boot-spl.pbl $(UBOOT_BINLOAD) FORCE
 quiet_cmd_u-boot-elf ?= LD      $@
 	cmd_u-boot-elf ?= $(LD) u-boot-elf.o -o $@ \
 	$(if $(CONFIG_SYS_BIG_ENDIAN),-EB,-EL) \
+	$(PLATFORM_ELFLDFLAGS) \
 	-T u-boot-elf.lds --defsym=$(CONFIG_PLATFORM_ELFENTRY)=$(CONFIG_TEXT_BASE) \
 	-Ttext=$(CONFIG_TEXT_BASE)
 u-boot.elf: u-boot.bin u-boot-elf.lds FORCE
@@ -2012,6 +2013,7 @@ u-boot.elf: u-boot.bin u-boot-elf.lds FORCE
 quiet_cmd_u-boot-spl-elf ?= LD      $@
 	cmd_u-boot-spl-elf ?= $(LD) spl/u-boot-spl-elf.o -o $@ \
 	$(if $(CONFIG_SYS_BIG_ENDIAN),-EB,-EL) \
+	$(PLATFORM_ELFLDFLAGS) \
 	-T u-boot-elf.lds --defsym=$(CONFIG_PLATFORM_ELFENTRY)=$(CONFIG_SPL_TEXT_BASE) \
 	-Ttext=$(CONFIG_SPL_TEXT_BASE)
 spl/u-boot-spl.elf: spl/u-boot-spl.bin u-boot-elf.lds
diff --git a/arch/x86/config.mk b/arch/x86/config.mk
index c2bb5549b7c8..a62015e1a64c 100644
--- a/arch/x86/config.mk
+++ b/arch/x86/config.mk
@@ -25,8 +25,10 @@ endif
 
 ifeq ($(IS_32BIT),y)
 PLATFORM_CPPFLAGS += -march=i386 -m32
+PLATFORM_ELFFLAGS += -O elf32-i386 -B i386
 else
 PLATFORM_CPPFLAGS += $(if $(CONFIG_XPL_BUILD),,-fpic) -fno-common -march=core2 -m64
+PLATFORM_ELFFLAGS += -O elf64-x86-64 -B i386:x86-64
 
 ifndef CONFIG_X86_HARDFP
 PLATFORM_CPPFLAGS += -mno-mmx -mno-sse
@@ -38,6 +40,7 @@ PLATFORM_RELFLAGS += -fdata-sections -ffunction-sections -fvisibility=hidden
 
 KBUILD_LDFLAGS += -Bsymbolic -Bsymbolic-functions
 KBUILD_LDFLAGS += -m $(if $(IS_32BIT),elf_i386,elf_x86_64)
+PLATFORM_ELFLDFLAGS += -m $(if $(IS_32BIT),elf_i386,elf_x86_64)
 
 # This is used in the top-level Makefile which does not include
 # KBUILD_LDFLAGS
-- 
2.54.0

