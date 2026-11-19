Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC385606A320
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 13:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=XLerqd1Q;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=NQxclNvz
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B6FD660D7E;
	Thu, 19 Nov 2026 13:12:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wQHsxqDjz_fm; Thu, 19 Nov 2026 13:12:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1491F60D72
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795093935;
	b=qkIdjvndvpCQoTBRATuAWE1L9TIxjTFVwlSbmYpMIFto1q2FPdrzbVm3p/RPbvwcC/Su
	 jdjuXIZLI2zkfwIuj5gajp0Lo4h5KpeHKWWHm6di/MrJAYRAac7DVSZCCm4RUfcyC07vL
	 +GAJQw85vqU4pu7Z8o4NeDm+8+tmpfdpnh6zBy0gDaGyHAtG3LcheVXQWIucvxZoPO+t/
	 rLIQEtZGPOPVqmkIA785iqXniTCoTPAGiNakA8rJC58EmLt7w+5zQhL3E+fs7VhpZ1F7v
	 DXqf/hxp6qal6g7UxFq5sptD2DvpQxXlBZtEoqWpG+KDqoZEllesq0fFDOfB2olvK1w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795093935;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=cESHehzZu+2jGsB1kAyg8rG3X+i5+HA/rpol6hguwYw=;
	b=CKfgyiIubz2J/MMsnkTbzKZUjbuiKmWhaQKH+jAPRh+l3VEqxj+3+ElultiNQV9mhSud
	 mil32uv5hMm8O1sFHeMUFDvLaGG2/u7omdGb9+q/5nTahEbjta2H2mvvsSlf7XGZA8CVv
	 6B8LwxMars7pDwx/px1DvqfEvprE11T2yW0iVNZ1pn651vF6OHMoIYoPM+CrV7B+muHlO
	 ZtMzWiT4yHZ2A+Ds18q2hl0YpIoqpGXkP2cNthBwcpndRTfLEqhu8sTCgr6zUc0DzKkBu
	 QjcRf8itHXrX4zUnCOZkMB+gRM19OkvUblg6fdvyLUvFAMUysaWo7Fp1W6HkaEyU+4w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=NQxclNvz;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795093935;
	bh=cESHehzZu+2jGsB1kAyg8rG3X+i5+HA/rpol6hguwYw=;
	h=From:Subject:Date:To:CC:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=XLerqd1Qa2+6vSD24CQdsmlsuEUuToGJJkfqzCAUHceeVfVTYHwvjI0ClY/9vs7W5
	 cG3wnyeAnuRw9OBjDsgoGY/8rt1WJtTfuntPqCPSmGZg9cX2VvISJ27OykGNWA11b9
	 kJGonp8zOGUuJoiQnVRjUR57t8/onALb+8YlsbdtHm/2pgT2I1od9Ze0SyD5VnHzEb
	 HW0/kSge/Rj5aAga4oGE6Kc9kV05ozJhOvZwpsE0WnRPY0bH8nYmd/YAzTOHm8mdn/
	 k3unVb6DRny3DKyZnj3/XnJ756LDneauZTUM3qZD1v4Q9fYg6GpshfMa6BXxwSceEC
	 HQAK4yW6ypejA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1491F60D72;
	Thu, 19 Nov 2026 13:12:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1BDFD70B
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 10:59:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0D55F60D52
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 10:59:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WEv2WAyuTJZ4 for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 10:59:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org AC9CF60658
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c202::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=fabrice.gasnier@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=NQxclNvz
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AC9CF60658
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 10:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cESHehzZu+2jGsB1kAyg8rG3X+i5+HA/rpol6hguwYw=;
 b=NQxclNvzQwznSNy4TL+A7OdVrbSNnbBq2p1xWpmgwLBexMjDX+hqGmjxx0BOgoZescDXSxHEcIs88frry0zQb+BuJVomCBIvnJiFV5HqnXelSxiVE2XaN7i5OMbIwJ/70qeO/Akv/tfbA1dhwdprxWTNacwcLK7gs/qoP7JGL22Yc8vplJjwmU+BGNSF8tAtBKvTRssCt5jyb8CS4xZO/7aJiB6b+ibAIWemz+yFvqONwkwZtBLp/PrIoNUKqAsXDZf/H1i+XvCbZilITlV5hQhNhdsWsD5Dzz1LGMiukTiTDasE1f6PTyo7wvvegM5VQuRynbL9IBKDiAPWrVLSGw==
Received: from GV2PEPF00046829.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::336) by MMZPR10MB095924.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:190:34::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.1; Thu, 19 Nov
 2026 10:59:29 +0000
Received: from CPH1EPF00000523.eurprd05.prod.outlook.com (2603:10a6:388::1e6)
 by GV2PEPF00046829.outlook.office365.com (2603:10a6:158:400::336)
 with
 Microsoft SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id
 15.21.639.10 via Frontend Transport; Thu, 19 Nov 2026 10:59:29 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 CPH1EPF00000523.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 10:59:28 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 19 Nov
 2026 12:00:07 +0100
Received: from localhost (10.48.86.251) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 19 Nov
 2026 11:59:05 +0100
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Subject: [PATCH 0/2] usb: onboard-hub: update supported hubs on stm32
 boards
Date: Thu, 19 Nov 2026 11:58:58 +0100
Message-ID: <20261119-usb-onboard-hub-v1-0-22aa6ef1d9c8@foss.st.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHLW/moC/zWOyw6CMBBFf4V0q0PaYoCw8j8Mi7aMWrVUZyghI
 f679bU8ybmPVTCSRxZdsQrC2bOPYwa1LYQ7m/GE4IfMQktdK6VaSGwhjjYaGuCcLAzOtUNbSSd
 3KHLqTnj0y6fx0H+Zk72gm941P4PwkfLU9NWENYzgYgh+6oo5TzWlVEBOv/WAzObzoyv+L2Sjq
 0qXtW5UXYGCYAiv5Ww4TRvCEdnwPhh/s3EpI51E/3y+AIWw5pHqAAAA
X-Change-ID: 20261118-usb-onboard-hub-dcc8d830c04e
To: <u-boot@lists.u-boot-project.org>
CC: Marek Vasut <marek.vasut+usb@mailbox.org>, Tom Rini <trini@konsulko.com>, 
 Alexey Charkov <alchark@flipper.net>, Fabrice Gasnier
 <fabrice.gasnier@foss.st.com>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CPH1EPF00000523:EE_|MMZPR10MB095924:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e0c3166-e233-43fb-20f2-08df462c2ee4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|23010399003|10067099003|56012099006|11063799006|261021121427099003|261021123027099003|261009223027099003|261102123227099003|261022105027099003|261026140227099003|261028144727099003|18002099003;
X-Microsoft-Antispam-Message-Info: 4CgS87drAUeijBDtksRQ+W2Xy+i50ureKLT0o34g7fdq7j7tfqrn3PqYG/DjzQfmU35/qflUvg9wuzStvFYDPdGhbLciK4Is6GrAvNaIomk6pcBP14oTWj4mIEIk5DqD6MEBArfA8BEebR2a4WhJYIaQtWTjlJBfXpzsyWodKGziGdWJa2LfDIF0RXDaXSEedx+Xj1QmmYzRSLl5dcCUiwVjFkz3EHByMUk1UIKtxnZ76Cy7CC6s8dLY94n+kQBjVv1kT8XfbO1vYiY+L5pn+jD1262Mwbwd2gHbam1TCqXp0Jz+6DzEk3Ta9JvY8QBmKLFV4nP4ZWQ8Y37F8XKPgoaQ7sQpQ8Hr5lX1WWexs+oPpgFNx/f06MIUAWJHJcXpK8V9LiRy621yCw++xSMbWju5nY2hU1zCgLbDuDLKpiF10PhY31SKED9/lYgeJr0IxpPVc+hSu9jmM5S4CuFx/ERkBu5O4vXGTDtcQ3asi3hn/C6IMx0ogLLRtzMs8iP++vatt48BbWRTHHEwO4zltMiPKbip5FrCH0liw6zcEK8Sa0jEzxXUigFxb/4DKQ9s0skbWVZA1E58M3oRErcuKi9PFNlriFbtJtORQc+BZ7CXJFFobrcXmh9e4Y3/GY+BpZh2LVrkmXWbzJoFYbt8V21c1VOfY+iBAF7QznRtjYXMFJRYDvm2pRIpQd81rN2u2XFSLR3KYEtTqV/8q4LaQA==
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(23010399003)(10067099003)(56012099006)(11063799006)(261021121427099003)(261021123027099003)(261009223027099003)(261102123227099003)(261022105027099003)(261026140227099003)(261028144727099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EYMw9vm1PiljAVyforXkV8UwnH527/NR5qa3X0LwjeAIUrsKMJk4nKTMOdyCuyPeQ9WXPC2IH4EDUNH+dq71norMETd6NwSHZdrrGHL2w6OJtUWZaNaHX6lYX+/I+zMzatdOSCUUVBHwgvrI6EIp2dYyZmzu3BdlDk3thtQwdDamHqgGL5p7QwoUSQkctpKhU/LzFRQweTyxYn6kDw4+7i/UxYWfWHM0YzFz8mHPF2isO88bOzph4z+PGxaYQsdfjGD8mOPMhD/abUE+ZxZhJtWnkcd7mnvFhg6dSlMLakRqk5m3Z5hjQuhHLxYanCywCklLqycCg5O9FjQ+Y2DSsu0EFHiek1Ix8MMi/oEA5VT3idbAANWmG9Rh3TKfT3Yu8kTppmmQka/fd4lxp1L3b/uWuty6P05BLVyM33PWby48RGcED1fXC1wsHlii5+8q
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 10:59:28.8091 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e0c3166-e233-43fb-20f2-08df462c2ee4
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: CPH1EPF00000523.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MMZPR10MB095924
X-Mailman-Approved-At: Thu, 19 Nov 2026 13:12:11 +0000
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
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

STM32MP1/STM32MP2 boards use Microchip USB2514 HUB or USB2422 HUB.
The USB2514 HUB can take two supplies. The USB2422 isn't yet supported,
so add support for it.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
Fabrice Gasnier (2):
      usb: onboard-hub: add support for Microchip USB2422
      usb: onboard-hub: add vdda support for Microchip USB2514

 drivers/usb/common/usb_onboard_hub.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)
---
base-commit: 96ca834b18b1607f80ff80f521d338b4044e01c2
change-id: 20261118-usb-onboard-hub-dcc8d830c04e
prerequisite-message-id: 20261118072332.627163-1-marek.vasut+renesas@mailbox.org
prerequisite-patch-id: 1c01cbe62acfdf9454b73129f26f883353efea53

Best regards,
--  
Fabrice Gasnier <fabrice.gasnier@foss.st.com>

