Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2EB606A326
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 09:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=A91p0iyF;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=XF+I+nqB
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 67E7840581;
	Tue, 24 Nov 2026 09:10:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MePZWC7HuLsY; Tue, 24 Nov 2026 09:10:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8D7374058B
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795511454;
	b=TzTIbfUnsWBjQMTCuUOPKHZK2qtQbyzElLQLECjHnx1SmFPqMQBh+pxn7RtcbqnYihCZ
	 4xsXAsXClRNnmlwU+SQAL1mDjzia3Cvrdt4JZMDw4A86Jx/RpriaqBhuUaQtktsCCh4Yi
	 x+jmTL1tjnjNYHDxwNHa13n7rZjQtJcM7dUoR6UZy/JczWqr+yDsNWnR2qy5h9mHNcCIO
	 FLC3AgmI0wpBttl7Dm0Zc8FpPBXLO7xASMf9F1lQJOCYZHFTqVSav8Vk9DcIikz64THRW
	 +oIDEEc68m1x8BMZbbj7ercb67vnjSpy1Ovk48BytFnW5rKwNKbWIEa6JL5ohJvBfoQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795511454;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:From:Subject:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:CC:X-Mailer:X-Originating-IP:X-ClientProxiedBy:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=daNFAoUEaeT1EW8HssWJN1DUIvWK9IEDtHs4Gnb5RAA=;
	b=bUnYb8Ksqm4uPq41XlQ5+RpQd3xjfnN1r/jm+qacrv4HMeubo0fLT8Zxy+jV5JSYFTsY
	 dBX4IYD/dsGH6XK0v7lo++kEp0214+nIxiGTXhb5eN5kKOFa2DqYKXSkptquVXyfFNiLe
	 t+7iEAPm6GDBa6vA6FkI/9iqS3O7HmXZn08ILxT9wQinEszU4Ovh6GgGfZcevie5iBFT4
	 9k3rdxMILBbemcr9SnDj63DGVJotyYc98uf0wDkV6ARvyzfkQXC018k8ZpC0lHOqCR5MR
	 /zz5eMCQxoaofXxLqRMLDrtWlG2MdJx/wRTzN2Eryl06WXsG5/nb+rMb3So9r5dXbRQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795511454;
	bh=daNFAoUEaeT1EW8HssWJN1DUIvWK9IEDtHs4Gnb5RAA=;
	h=From:Subject:Date:To:CC:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=A91p0iyFOTcki9IA5wahM1ZnP+bb1MPoWT9rGp8TAp9TewijXQFzjGiXYOvR/7JE9
	 usy/M85hP3D+W1k0Kej4i3HWccnxE8HENmV099+8ibqC9Ibk2mC+25ayYJ9puA/g1q
	 IFlq6rPm6DjYmNKBfaOU4bIdPX6Mc3gOk0YIkZRoYA4mZQsBRbhGZi7e9qZQRBCdUQ
	 xvarM8kSHPty8ZOTahKzKH7zP3iGQFp2q22kMRH2sL1FMchTdIPnoTtY2aj/TzBY3A
	 +5ff62KEoqzZzBP51P84ji/z25aGgcPKOXkandtIgGVYXuyusQeTyAlRIFFY/mmP/o
	 sSpl5ntp2VWlA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8D7374058B;
	Tue, 24 Nov 2026 09:10:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 70A2A3C4
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 09:10:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5684F400AE
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 09:10:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 24uuBaizKsWb for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 09:10:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org D189C40068
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::1;
 helo=db3pr0202cu003.outbound.protection.outlook.com;
 envelope-from=fabrice.gasnier@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=XF+I+nqB
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D189C40068
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 09:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=daNFAoUEaeT1EW8HssWJN1DUIvWK9IEDtHs4Gnb5RAA=;
 b=XF+I+nqBr4YE/Qyhvf0rN3O2vSpBDiwqLQiI7A9lmpln7RA9d20R7cDxBgKlX+pOsvaL43zWzRKZUUwqw+kPQlZd0q2gK+n1cIKLQ2dnHR8fhpwmmDBC+NYattWdszbLNk2JhUYeAp9K548KYSJqM3dqS2lq/VSQclfz2SBFH1fgSZusf2DsONavx4CrxuXqo67aMDMiofimtN7tVPLVKNr/1zR+it3fhBGUcoin+w9px7cRaZk67NW/jmvpeqe9lA4Vx3jV5cbBT8iYExxyJD2qZ/1FTgcRAvUEmdWcNc/8gMcTXY02cZCxAZBaYMRApNr85aLPnAKBMdy4Xxl4SQ==
Received: from AM9P192CA0016.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:21d::21)
 by PRAPR10MB5347.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:299::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.3; Tue, 24 Nov
 2026 09:10:42 +0000
Received: from AM1PEPF000C1AD5.eurprd02.prod.outlook.com
 (2603:10a6:20b:21d:cafe::3) by AM9P192CA0016.outlook.office365.com
 (2603:10a6:20b:21d::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.5 via Frontend Transport; Tue, 24
 Nov 2026 09:10:40 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AM1PEPF000C1AD5.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Tue, 24 Nov 2026 09:10:39 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 24 Nov
 2026 10:11:43 +0100
Received: from localhost (10.48.86.251) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 24 Nov
 2026 10:10:38 +0100
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Subject: [PATCH v2 0/2] usb: onboard-hub: update supported hubs on stm32 boards
Date: Tue, 24 Nov 2026 10:10:14 +0100
Message-ID: <20261124-usb-onboard-hub-v2-0-ec527e27994a@foss.st.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHZUBWsC/2WOywrCMBBFf0VmbUoSpaSu/A/pIo+pjWCjmaQop
 f9uWhUXLs9w7z0zAWH0SHDYTBBx9OTDUEBuN2B7PZyReVcYJJe1EEKxTIaFwQQdHeuzYc5a5dS
 OW75HKK1bxM4/1sVT+2bK5oI2LTOfRMR7Lqr0i/WeUojP9Y9RLNevsvlTjoJxJqXWNXbCNVYdu
 0BUUapsuEI7z/ML3XFWs9cAAAA=
X-Change-ID: 20261118-usb-onboard-hub-dcc8d830c04e
To: <u-boot@lists.u-boot-project.org>
CC: Marek Vasut <marek.vasut+usb@mailbox.org>, Tom Rini <trini@konsulko.com>, 
 Alexey Charkov <alchark@flipper.net>, Michal Simek <michal.simek@amd.com>, 
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM1PEPF000C1AD5:EE_|PRAPR10MB5347:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b6435e1-8d92-4771-bd8e-08df4a0acf24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|23010399003|18002099003|56012099006|11063799006|261021123027099003|261028144727099003|261021121427099003|261022105027099003|261009223027099003|261026140227099003|261102123227099003|10067099003;
X-Microsoft-Antispam-Message-Info: rEK20UFSkyGwnEsp9y3I8gmTyeVQZ0OajJXlEPqpuGRltBWhhQ2qgpQToKy1ONvnX2RWNF3S3CzsC08GzvpE0+gq9wy335gmJmh9BVV2naKd/oxffWUFU8ZARedcpBR8elYVtJiWveRL5cFS3KyVR7hYku2tImR5vOceY9kQLjtd7LwsU1D311OqsaBuQO210L7LWqSvkoHJh7b1+SN54VN47VIGwndBqLP0jhiWRyu4CqiSwn6YWwVRoXlype+c+2dio9x3J2GO5QgRL9K1CnduNsCnaIBzNKPsIULJ+tA1SiM8X9/i+MDU9LLKgynYck9OTwhaC3LHT3Q32MD28/olZBQopm8vTft+gvwRzkJhiKmChVDb3o6Aluq+PU+4Uhe1K8UNOkaAY7Q7hkfWrc6brBQf8dWdBhIAAD6i9Oav7LfxYW+lR3uzk5MrXOlfd+RBxQqpBBvjRXgGbE8uWMVQBOPZKI5Fchus19cMk4ZrWVwXY1F3udoi4abUTU3ABL+/VwH04eYVFkh4DPLZTWmcYG4FS5qbSjhtec5NU5XPoJb6h7iEiKwiPNRsXvisjfZ2fl0t+hHMtyOJmc7SCZ0wHrgZTXAmTE/UZdpxJGO8YBvZu28BUAoLKmm5wqNuo8+bvYoX1BOHdokRYlmaPQ==
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(23010399003)(18002099003)(56012099006)(11063799006)(261021123027099003)(261028144727099003)(261021121427099003)(261022105027099003)(261009223027099003)(261026140227099003)(261102123227099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QGUX/3F2OJj+K5s72U7CTs41q9FzWxEfpcsbjGI56P+gFsGF2R4zOj2EKBHun5L4LWIds/FNYFkHRnjNljIFaO+eeuKsO3WPXaIT2npHzXNK5p7vxIRjBbfspUIIM40p7kDTSn9XmTTR6Jk6R4pSi7gxA6GKsUJ1wzRvL13a0GYBGYC87Y5gq6X3R0duvF9OTEil8+C8Kx1MKKGOBeh4GYlyTVZNg/4etLzoaiXEYVlFNGV3FepWABRFfosjErPqLbcitCYPncRs6+lhBVJ3+L3n3ruoapkA4mu62dNfGsvnsJoSPZ/Tjqs8fFWRdh13xJox+jfGqXxzbK62wgcsXn963foryUS3m5zqm1/yJKpz/7+qL9lstFXR4oQA0dWnw2qoUDxAyFppPF1+2dpjTgzbRgNNkHqXttF01uH31Ih+0nEriFBoYDp/+GeaBrIA
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 09:10:39.4410 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b6435e1-8d92-4771-bd8e-08df4a0acf24
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AM1PEPF000C1AD5.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAPR10MB5347
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

STM32MP1/STM32MP2 boards use Microchip USB2514 HUB or USB2422 HUB.
The USB2514 HUB can take two supplies. The USB2422 isn't yet supported,
so add support for it.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
Changes in v2:
- Rebased on usb/main.
- Updated commit message on the 2nd patch.
- Link to v1: https://patch.msgid.link/20261119-usb-onboard-hub-v1-0-22aa6ef1d9c8@foss.st.com

---
Fabrice Gasnier (2):
      usb: onboard-hub: add support for Microchip USB2422
      usb: onboard-hub: add vdda support for Microchip USB2514

 common/usb_onboard_hub.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)
---
base-commit: 357ffe9ded8988c8a31e95e5305bb766b2625236
change-id: 20261118-usb-onboard-hub-dcc8d830c04e

Best regards,
--  
Fabrice Gasnier <fabrice.gasnier@foss.st.com>

