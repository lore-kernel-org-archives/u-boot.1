Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6220A606A31B
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 08:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=YHB+JbVR;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=VfLkxgtB
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3C8C680DE2;
	Mon, 26 Oct 2026 08:14:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y6gpR6fZHLe3; Mon, 26 Oct 2026 08:14:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7D1F280D47
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793002464;
	b=gtiPy3jPMgDSiL7PQy+qJ07nMYZldJX7KMRcnrj/oxpFCSCK9aHhBhBmZMQSbbt1Xb/Z
	 fCQFLF+8WOhmFqSfnkvqsfXlfQ8OAZmfRTKSv4mJSavDZWJfFHg53PKeZFK0YvcJPbMno
	 Ce1YqL3wglqOjUuWzAxDl+WSwe/dOmMV0LEthdXHoNg0GE+P+CGAHoJAaZ8NoNdu0JXu5
	 uZHvOyOTrDhzWk+IeZXmctBXhDz5+UV4yS/MdOCYTUHoOGRoKpBpPFMBJ+O2RCb7+Mklj
	 bcQFLFHF5RJl+Za5tNEEx0uKyVOZPWHJcA0SHiIyPA5ZraVCMifP2ECKG6V9hlqyzOQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793002464;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding:
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
	bh=iOP9583Hakd4DyYRauTFiZAzQj31vDYhqBh4MYcrBAM=;
	b=FPVeEf/PTGS9am2F3LpXv0L1FQIBwYtz9WWNuEDKZn9hnYbKHi7lDWfKblCTJGkGy0U0
	 CslM5ofrZ53o5WhxwsHv+e4rND7ra9oSAdEzldkUJ5AV7QhnbI18yIFTxlIxoLf/sFi+d
	 hK8b1trhxYqtAtw1Toyho6T9B10vgqIgsx6uwGydBmhTK6g6TrV4cx2RoqkxK4Hv2cSJV
	 JxGB8NfsgtZbi4vP6bLX0WJiOnC7C+xprAyOrLqj+oXDM8yM7Is+dphYovez711Zn2IDh
	 xuL3iklMH9y9jOQ0rut/5966cHgCCjGi4qpdXFj1otDzuzG8FXN+eQl8Kakp1oEeNYA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=VfLkxgtB;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793002464;
	bh=iOP9583Hakd4DyYRauTFiZAzQj31vDYhqBh4MYcrBAM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YHB+JbVRhYfiOPgwOokZ5hlqYG1ONDT/n+x5q89zRkbEvZ14xeG7aWxME8uAhcn9h
	 2zqI1zhVM8L8DWnytaeX8X3B4BpPdffpTauZoCp5P3ncnMJoxHkgXJgDShnSc6ccTY
	 I2W0/FBhN1iCB9kVZ/0eKtfzsc8gV3EG28MYulKarmN9TdfYztkb3lRkyGoACBp+rU
	 lt+xxjSkJt4t52iWPuPVzTmpEwC4O3jW2j/zgkYw8YwkoPrVQ0IQzBru/pFF+O8FUa
	 +GimABTYHKC46Wrgskn7lkyvaD1Dd0zhGxPV++Fjg8uIBv+SmD79oc9T7q4VCJIhDI
	 KvAspVn6Mna8w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7D1F280D47;
	Mon, 26 Oct 2026 08:14:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id A9BE0235
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 08:14:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9030580DDD
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 08:14:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pjt0VC-DaN4x for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 08:14:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CA8D780D47
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c101::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793002463;
 b=okC3jZFM1xihEm0TEdiBQ19z02ZYWRLQta1DJi+QDtwW/zlxdtmz/QqIps0MRI7JXGta
 3MQ45T8K89jUuf0v8b5tg7F9PiQegkqhVhr4Ivuki/rjcU+CbZmJXuK3a4rl7DOs2yLF4
 YRCF1g8eDh8nPOsRe/FKqo+5P3/DIA71UC+i5sXea4skinCLMXK7bJ10WL26gS5+zD3KT
 eyQendU1wCpjwbTqZHoLUEKy0e9sl7qskqsP0GSng0EVfTBpAR6dFZlhjrytR04t9TzmV
 cBGZE3dYpIt/j1yhvYDQIyMQI6OUxjUQ1ntGjfjZ9qpoSsP4ODQ+nNXdDb/hZj+IJrw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793002463;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
 References:MIME-Version:X-Developer-Signature:X-Developer-Key:
 Content-Transfer-Encoding:Content-Type:X-EOPAttributedMessage:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
 bh=iOP9583Hakd4DyYRauTFiZAzQj31vDYhqBh4MYcrBAM=;
 b=C1LkFU7QzCRQDPLA9wM2KqoJZWpUqMirv7wMoI16q+KM+jMPzT1yDOv31OXil4ugbP5F
 78Kxp7MOONoqJgH5H+cPRC9qPQOMxoQTFP98IYXZ3iHzODn3BKQ9CvpegW2d5vJP6C9xd
 rvyiyqZjeAd4Wgm0egSHUITQ3rgDQkl5N7co4xECqUjyl1Zo8CaxpfwGWB3nx0RRJVnqs
 jmBEpEqE5tQjv0CKihuUI0+Lgbxy+Z28LARwvQYituuwXBST5WAanUiJ4Mc0nJF8Bj9Sw
 OzsZkhW8iMbfdBV7/4VaUfRP5briW2gZfeM2wNIRji1Kuf9op5x5ExapW6YewnC4CMA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=VfLkxgtB; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c101::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c101::7;
 helo=bl0pr03cu003.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=VfLkxgtB
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CA8D780D47
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 08:14:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xy67vFkEQtaI+9peii9X8hJIOxxtXuiXu00qHxNSRTr/lf0hZnbuhsEbBVCtcl3cHowRRfKgBtoihpgPw7nE5Cv3SenZt0OMoVFdHw3WAGwI2RO7fhx9oCGex+6U2wX/quqz2XwCSDK3teWXtwNzRbo5tAUYPaK5uCzxFc/OOKapQrYsYOeq8R/X+lzrAgJC+GPoUA0WfxifN+aYC6Hf91JrZbrrjKWo5m7fpp4CTOAX8+ftUzxBqFwouf5X0mdJpQ8y2YetHHPQB1o0s+RrNzwtFUaLSfReyPchl5t81ALGDb153wiQJboe4TSjUGZi1MQUtSmGktmIa0YH5wDclg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iOP9583Hakd4DyYRauTFiZAzQj31vDYhqBh4MYcrBAM=;
 b=CEX9eKWAcdFbn8UaKKQsBXW88NSoXp4QX9jptlVJUQWb1U6CsBPF3DxEDYtA/3sq8/TfOLpYS/AA2yGVEpCgBugXCV/xjPMpYZO3X9q7AF+/dOCTq3LX7v8SUkFoTL4N73nDfMSuqVgldrbnrK4uSS+q4QksMkDGsa2VZMqhHiAK7EUdj4bJ5sRiEgF8Il6F8JTXnTqmzErOUxuQ1ZzIoo2C77QytlGzBsuybb9YHb0/MsvAfjGQtrFGV/EfeLmhQU6Z+x9ZznAQay2Fc6bF1CMPxnwGCp7ngoH+pwGmXhF418LNs7Ah+uWZ7vwYHyoq+i/YDEdF4+fk0H46ike4Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iOP9583Hakd4DyYRauTFiZAzQj31vDYhqBh4MYcrBAM=;
 b=VfLkxgtBlHTGQQPDkyQVJCDWxmNw+nyDYXKeh8suDsN6E0jZ+b4sKfmXtt7MjevmS+N1rGHkV/oQ2V/Hw7qIGWU5TC9iD1kIAIH9oMoAcJlHwt8tPJb3K4ioz9oUSK96GQMqcuuM4tJp9EJQopdPN14kqNGdWpn6XNeMneGcpVk=
Received: from DS7PR03CA0178.namprd03.prod.outlook.com (2603:10b6:5:3b2::33)
 by DM4PR12MB5963.namprd12.prod.outlook.com (2603:10b6:8:6a::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.22; Mon, 26 Oct 2026 08:14:18 +0000
Received: from DS4PEPF000001C5.namprd21.prod.outlook.com
 (2603:10b6:5:3b2:cafe::a6) by DS7PR03CA0178.outlook.office365.com
 (2603:10b6:5:3b2::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Mon,
 26 Oct 2026 08:14:18 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS4PEPF000001C5.mail.protection.outlook.com (10.167.23.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.0 via Frontend Transport; Mon, 26 Oct 2026 08:14:18 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 26 Oct
 2026 03:14:17 -0500
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53 via Frontend
 Transport; Mon, 26 Oct 2026 03:14:16 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.u-boot-project.org>, <git@amd.com>
CC: Padmarao Begari <padmarao.begari@amd.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 04/11] xilinx: mbv: Enable GPIO driver and command
Date: Mon, 26 Oct 2026 09:13:45 +0100
Message-ID: <23b163c0c8213d9374f66fbe9423179d2eb80157.1793002418.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793002418.git.michal.simek@amd.com>
References: <cover.1793002418.git.michal.simek@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1179; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=7386FoKRchcdBt++xvNY2PicBkE2i5WIsvVhRuaQ/YY=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWTd5z5wZY6Se775YandbHONGxT1rbLuszyb8VnBd7aD4
 gU3j/eXO0pZGMQ4GGTFFFmmM+k4rPl2banY8sh8mDmsTCBDGLg4BWAiyp6MDAuVHrt633e1epqZ
 FuuhqnB5X+Uzu5eTRV/LBwiVTb9wZTkjw9WtV27Nsz5cUZ/Z5e4i1ua1wOzsa0vTGe8qdd2Xxzs
 VMwAA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PEPF000001C5:EE_|DM4PR12MB5963:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c960390-30dc-4c67-27d4-08df333921e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|82310400026|36860700016|56012099006|11063799006|261009223027099003|261021121427099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Dj3fKZHmWifaj8dLZlMNKVgxnqMbTIitY1wMo0yKeXCH2E4b9p3chCfwmhV13BZ4o1pF3xoCMnoyBBP6UBQSlRBwk+Oyx/giFaXIXmXHDI8/VTLMZLaOj6NdVz7UMekjiP2dfueIF+DAHLG25E5Tg2tjHyos3kMNF2LLXQLYxqy9XL9PdZ/ut7ydk05fsIfvW3cLH9BdMplmKCD2matcD3LJauV+YrYSnROIpyJMibfEKoqgEmYnR+YyI5io794E+hQqQYxCxlN9nW9yve1MIXDnUZDzBojI5XaonXQcSYbLpCwhui+YmHKFpqe6e0OjyZ5SoJhS/QG9+hflHuCCzPU90iqSYgW2lKmVviD3uRzUtX2o/uKtKb7kzGa9TbOkW8UEb2dm57OYbT+1vGvzs0cnzhPd1jinTkUY0FwzdLnlGB56jwuQ5k3O7ZOue9rksMnDYV8ewHEOhCpMpa13ZvL1A8RbFgwenN+T0UM8+jlC2ktqkwYQ9YBmmm576Kn9omVX2fEfeOfKB7ipU1cdI23wmPytOpPLB7X151izSXla+laeWc4ECZAiXGkR4kQvWw3raJFKnUextbrajejCAADAEfW4xUXIhq0ojo6JMoms3ap0UDPzDynmv+x6yizrdY8fcxnLX0MRa7Z6D/d6MEQLiRJbMc9YpldUBXvVfRd9tgGmYipYi2IFiNTn+RgPqxOddmp3phGnbzgJQo9dqg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(82310400026)(36860700016)(56012099006)(11063799006)(261009223027099003)(261021121427099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: AXoabyjq0lekKvW4lLm+QomWYEgQ+3MQyHIqMSKQWAmJPJ3CmiNj0RWuTylT4ooXaB54ljiM8wKSCNKE3gsFh/jqvzeBeuaLUFdj7a4aRdqTitrcpWFDk1FYoSWm6Vsg2b7bpjzqgrIaKacC2tWzycEaQdqJqYr3VE1dg7mdJ45NbZCaygtz0qRYtd5rhoW4TPNhDkAqLYkUd6kaL9weFCX7wYtNXobkDPw0/hAGn8hsH1KK/YCM/drk4x7nMz6vy95cjfbIP7gYxlq5kZwxYhvCCIoOvEiN8wFF0/ii4TMRZaosVLOX8L3ZHyo2yRtvTGwkAoziTs2/8ZK96t7K2d1hO1R/BHvv1F0yygzjlTHWod/w/mKpa7YA1h+dVQEkv1RvImEsq1XfWHY1gzmKJLZpzSP7PF3Litz7R+Kzx2X+j5XWwXpBEBBsYG7nTUbo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 08:14:18.4202 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c960390-30dc-4c67-27d4-08df333921e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS4PEPF000001C5.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5963
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Enable GPIO command and Xilinx GPIO driver.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

(no changes since v1)

 configs/xilinx_mbv32_defconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/configs/xilinx_mbv32_defconfig b/configs/xilinx_mbv32_defconfig
index 07ed096ab480..a1a2e3b0feed 100644
--- a/configs/xilinx_mbv32_defconfig
+++ b/configs/xilinx_mbv32_defconfig
@@ -7,6 +7,7 @@ CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x81200000
 CONFIG_ENV_SIZE=0x20000
+CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="xilinx-mbv32"
 CONFIG_SPL_STACK=0x80200000
 CONFIG_SPL_TEXT_BASE=0x0
@@ -43,12 +44,17 @@ CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x80000000
 CONFIG_SPL_SYS_MALLOC_SIZE=0x200000
 # CONFIG_SPL_CPU is not set
 CONFIG_SPL_REMAKE_ELF=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPIO_READ=y
 CONFIG_CMD_SNTP=y
 CONFIG_CMD_TIMER=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_LWIP=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
+CONFIG_GPIO_HOG=y
+CONFIG_DM_GPIO_LOOKUP_LABEL=y
+CONFIG_XILINX_GPIO=y
 CONFIG_DM_MTD=y
 CONFIG_DM_MDIO=y
 CONFIG_DM_ETH_PHY=y
-- 
2.43.0

