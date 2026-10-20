Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CC6606A320
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 14:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=OQqApnBH;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=y88HPiPE
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C500C6084F;
	Tue, 20 Oct 2026 14:09:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wCpKlDUjV0yg; Tue, 20 Oct 2026 14:09:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org F1325607ED
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792505398;
	b=IyX4Xr1eiYeVdObacry+8ZlEEhfGR0uBMhoPSfQnaXQWewsmk/V72nYqhpnBQoO4TFbd
	 9/yc0X584r4p3mmvWLpsGspFIHmhXnl6V1E9C35SnXUYKuuBXjbcd+R8/uAL+P29UOZwP
	 JMSllxcj3fEopaNY+7F4y5xPDoCXIrEtkVzdYeBudH6XKZxnTBbLQ7P7ocKnIeE1Ddwvz
	 FDp/6vAaNtU7Qcx8EVqn9YMOg8it22CH0q5BXhKKCh3pho5TW1bmkKb2CEVzf2Ti1kmQH
	 r1R7LcVqzxaeZoLdHPULm1ZO2eupWilFcmlJqPioTXtNuzlA+wVtNCVCDhjK7wndDXA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792505398;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Type:X-Developer-Signature:
	 X-Developer-Key:Content-Transfer-Encoding:X-EOPAttributedMessage:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=k+nH6qgLgWt6WYvPar42BIObUchnltoKBTlyGxfUW8E=;
	b=lZGv2iGZ8rNgU/gwIeG4icD/1su33t0oYwNvlKW3Jp2FugUSLcnE8I3nRVlenVBWl3Yp
	 w1Bw6Dkx8xFcdOZYHIXFo5rFLma8GsGkrxPxyO2rBVwHpv5bwZzwY5Zl1OmOCanPmcLBf
	 fTz8AgCMSR0uvUPQrciIZiVzcQqgF9loUzzl6BXqChPwaVgTQlyquF+kafVRLOvxfZSKF
	 51mi6niVOq2YY7r6Xbt+uxa7JYfUn/B8R4fL35Hla+VISNf7wrOjnkvz5oad9uwdE0T7J
	 OY4sXzGxEu4vtDeAAqnSH745CvGLXv2BPCS+NV+eeM6o/49wLN3lslV1u+LwrWHL1Pw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792505398;
	bh=k+nH6qgLgWt6WYvPar42BIObUchnltoKBTlyGxfUW8E=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=OQqApnBHbthV2OQImtuxf5jU5Lo5v5CwLcjuUSKKRKYgoFeLzn6u9nSNYuoaNFo6C
	 wpDy8itjXy7JZTM5J4F5hQA/XlxQXHaP8TfSskyqQYKAYWssIZ9EfXBdLTv5+iQiIN
	 Phuu+i9uLjPjNpZ/9UE5cY/A4bP1tbVDgVe3cgL/lHO7mFtp5zRENkm9GsJSr2WYzc
	 xw7X6wflw5OE5+kvO4MG0PdbjXjAQoYboIxUdX5R+l81+i/pbyI5J5D+pRMvHhkJoW
	 2eIWn+q5Fj+z8WfA1v7DVz/PqW71b/EbS1T7SDq/9LriFexFehF5M8ywJMi+Q9lQK+
	 jcqkfeDaATL6w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id F1325607ED;
	Tue, 20 Oct 2026 14:09:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 73FC11E9
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 14:09:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6584C80DDE
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 14:09:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mRv7kVsB27Fj for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 14:09:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7FC8280D84
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c10d::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792505395;
 b=q/b9tnriW6P06K1JUUvclG60RgSd4uPEN1wEV9yTvmdXdKx/vIcNEcjcDhg61sogXKWj
 0Wd1uxA92LSzgJFZQfxoffrVVVJ2hDpS2j0Q++QLEdawJTim2CaMnFoXvBT5muRwYXfgl
 +CDYAPhvshVIyirJWIeXOhvesjW/V1XOkysq3Aor2O4pXjj1M4eNdF+konMcoiLBsn19m
 hTAcp9IFPecuf2wvo8OkPRyvaCqkcpWOGMtN7P2UwqHhIcAH1BrAcr4h22TMXpMItRVjS
 EkqN9yBtWHjbyHrhhAUr4G3m8yC6iS1c0zB009SlylDHiVs0Bk2+WBY/V1tvHxm4duw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792505395;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Type:X-Developer-Signature:X-Developer-Key:
 Content-Transfer-Encoding:X-EOPAttributedMessage:
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
 bh=k+nH6qgLgWt6WYvPar42BIObUchnltoKBTlyGxfUW8E=;
 b=RWgMXXcjRZtoiwSHCYXA2GpwHzYJRaOxhrZyWZnGB8dvkI/zEa6v3FuJtrqTWudmCeQw
 Kx/9Hk57Q3ev+gzwhYWoXCmP1tymrv+jnl4cT5RhwOS8PNJXVoiQ7S2bML2Ju0G7tHNWp
 LhiBZCRmMaPpIkM7oX7k5K1vQwrjYfFxBB3PqUTjtD7ADe+wv9lXZUU2mfdQLX7BuzzzT
 yFkwU6cpbMXrgzvZi6Zy9KCzN3pkZhc96p2tBMJNxYafRz8eJBcKnVTbeh1afS8onhQ0g
 ZOAskHZxsMyv1tmDESgsPc2BJzsLDwNT9Be+mjuH5s6riMDpTA2XaBuRD+9cqhb6WeA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=y88HPiPE; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c10d::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c10d::3;
 helo=sn4pr0501cu005.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=y88HPiPE
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7FC8280D84
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 14:09:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rQW76mJT9Lnr1lvSXqiXAN8PtM724yLxH1KmRHQB4u5LzV8fvdcf1FZ3U7iEDwxt2eVMj+Eq2Aq6iln4Ryymr3hpTrvBRAtMA4v8j22OLeLzR1AQQ4iJI1QCkyfTVLk/3UuveW+vPeTa/8FeK/qq+QlhdJnInJcqh/9yC39fs7sgvUpI9B3neT5URev1IeJy5cS9vOBVRXRu5/48QwJh6yKjlxWCtLFHcS5+e94VQkrDCIQ+QWkR6Is1Aj3My5EcVLlp2nf6zbJ5s4v5APUG1QqowgZiDl8VtEHpuGUWBzwGPP2Os0a8otXQOOwVCYplS3i5fPJWtU0wvlaTg2u/pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k+nH6qgLgWt6WYvPar42BIObUchnltoKBTlyGxfUW8E=;
 b=DZdojPYcti4nhKJSmipsoD7qAb50Qgs3r/VNOiqTjQiPcs4AvgRYERcJtll/OBhUFxaERTNQvpMmiY2Cy/owLcyiSNKv2n46oVbN9xvXCDh2w840/zhav3SQNeFXnosGkQlxLn4e+Lq2kv0ky149yLCg/1+3GbYQ+SCfVkY0vOPikqwaQ3JkNOpbrrkcH1s85Lilq90t+1kE8NozZVv5wnqAnAmyBbhgoemUvHP9t1soN1cf81xnV9lrHAhQlIvzQkRJlmreM7oALnZ0+tBVl8v+B6r5p49x7T/Fxh7YdnShq9rK01St9ZnHjm60v6356GPyjWir7bGcGyPPUQJGlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k+nH6qgLgWt6WYvPar42BIObUchnltoKBTlyGxfUW8E=;
 b=y88HPiPEwv0aVMjmH2RszlutwhNayAV75ziexd7AzcsZdtBfF7+2hMj8+t1blQlThM598Uk1BKaDeCT4AsZoE0ChRJFDKoz2BZkCxpytKSIsUiah9ePs5Gjftz4RIoXGZZ8rZ6UYC07DEJkUpYEZT5rXAwI/s30LKGlMl1DI+8k=
Received: from CY8P220CA0043.NAMP220.PROD.OUTLOOK.COM (2603:10b6:930:47::14)
 by SJ0PR12MB6808.namprd12.prod.outlook.com (2603:10b6:a03:47a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 14:09:46 +0000
Received: from DS1PEPF00053450.namprd04.prod.outlook.com
 (2603:10b6:930:47:cafe::16) by CY8P220CA0043.outlook.office365.com
 (2603:10b6:930:47::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Tue,
 20 Oct 2026 14:09:46 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS1PEPF00053450.mail.protection.outlook.com (10.167.23.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 20 Oct 2026 14:09:46 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 20 Oct
 2026 09:09:40 -0500
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53 via Frontend
 Transport; Tue, 20 Oct 2026 09:09:40 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.u-boot-project.org>, <git@amd.com>
CC: Leo Liang <leo.liang@sifive.com>, Padmarao Begari
 <padmarao.begari@amd.com>, Sandeep Gundlupet Raju
 <sandeep.gundlupet-raju@amd.com>, Tim Ouyang <tim609@andestech.com>, Tom Rini
 <trini@konsulko.com>, Yao Zi <me@ziyao.cc>
Subject: [PATCH 00/11] xilinx: mbv: Various updates
Date: Tue, 20 Oct 2026 16:09:22 +0200
Message-ID: <cover.1792505359.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1219; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=YaO3DPyo3+xUUj4bwKEKh5fq6sUQ8bwCrhxl2Zwuqi0=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRdL5PcsiBRrm/VLLaOty1uwr96jyacKinmrWUKedTvm
 bVoIueXjlIWBjEOBlkxRZbpTDoOa75dWyq2PDIfZg4rE8gQBi5OAZjIxlMM/4wW5FTbLHxTmH2y
 pCx276x/DwN0V+459UHux4JXa3ue/rVk+KdSnSfNdiJtSdjB1uAjLyfMfHp6rmmp718duxlnJrX
 kdvACAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00053450:EE_|SJ0PR12MB6808:EE_
X-MS-Office365-Filtering-Correlation-Id: 83711d27-2ef4-476f-0e50-08df2eb3cbec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|376014|82310400026|1800799024|18002099003|11063799006|261009223027099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: uW5aHFrAMyOKEZiv1ynT0THeFyW0A2IgLDf5kV+rIdpnDxRvfe2R+u5ap6iDyZSDL28N0ufo4HUphy4TgmNjv48zkNO7G6nIJjyc/DTcMkt0DrwfiES6q7xYnh4/E/OPO17oZyX0FFe5xERqJzDTw6or6qxvoL6FTnFmOhfilV9ezz9zMqADM1BkEbUlN61nThaPLFcP0mo8DrYHDG2tbJMGxdYuX1kMoLIDbrsCRy2zsHB6PW2sARWXsrmH114q2Q1uLJP+n+b5npJ3hf7RfwHgUjMhVEl3BLQaeX/e4LZpdvcwJFrbyzfXPdKdzXnt7LWhHpgYbRbIii5NOQ+PJxIibzVq78FQlnLjrg19mOX+6xVudkFNgPc5F/kcendVje/XHCh85ZM0dIfOGgiX/KjOPRVCZ2zQVu4ZJzwX4M+HVriHko9DFVRpT3jdLCXNqASOLCr4FQxePyVpijDYJvjIpHNa6PETgeuk8sdRFNQ28fCdoxDZAxTdEBYOsA2IWIA3KcSZiyWAAYvcI/49zt4e92mWz/9pwsMVNqXtpLwodrwfevnz9XiZNzmd3QhSDfxWADrE4LRsBEPBFQwXW7KA4wNIWoGFFiVUrUMGCX6xB1NVA6I649p4AT4KRsTnaiFhzNfmgKg3xcHi+MZTjyivBiLE6SAh2FqQnhlppHK1VJa5qOUf4LhItnfa6l8fmsd9efNhNmjtM7gEX872fw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(376014)(82310400026)(1800799024)(18002099003)(11063799006)(261009223027099003)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: W/3qJ5pMyenlfBJ57WcnSCKrfStI/aUTvluAX5eDQ5FdQx80ZBLHfCANAXQ5ZZVhOonlb6wY8Uv7HasQ114egR/IXU/RPP7+dd8gCRaZkvPz8UFCQ+jYxvnxEOqkJsYPRdWChTyrJwMbVhIUcrmLO21w7TInv7CWTJrXLUuVI7MsyKDuiPrJzzQAImSV2LcIO48kJrPMzBYYU/+6WPIHBSIqEu2GdUlqD9+aOg+7SpAb6CQ64W2hmuuNqLzsKmIf323jDFMO7NdZ1Kl+X6dkH+6STxU5i2YkvUcsUkofW6Zyy4+B1quiJDQeg6ALT/ERS008FmkJMRdQffgrCKkQtq5gjKbBEz/iYKUfMqApDungjWrSI3aG8MeZBHwyhuMvV82Iixv/OQFZUoiloJupJP+fO7gZv1dj7YM+VnO5RV6dk3l+vgva4elgYAvsmL8S
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 14:09:46.4377 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83711d27-2ef4-476f-0e50-08df2eb3cbec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00053450.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6808
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

I am sending various changes which lands in downstream repository
based on tests which were done against the latest RTL.

Thanks,
Michal


Michal Simek (5):
  riscv: dts: mbv: Update bootph-all in xilinx-mbv64 DT
  xilinx: mbv: Enable GPIO driver and command
  xilinx: mbv: Enable CMD_EXCEPTION
  xilinx: mbv: Add support for using bigger boot images via bootm
  xilinx: mbv: Enable MTD command by default

Padmarao Begari (4):
  xilinx: mbv: Enable Timer, Ethernet support
  xilinx: mbv: Update stack, heap, and OpenSBI memory
  xilinx: mbv: Disable SPL raw image support
  xilinx: mbv: Add SPI-related board config

Sandeep Gundlupet Raju (2):
  riscv: dts: mbv: Update mem size to 2GB
  xilinx: mbv: Add sys prompt for mbv32 and mbv64

 arch/riscv/dts/xilinx-mbv64.dts      |  8 +++++---
 configs/xilinx_mbv32_defconfig       | 26 +++++++++++++++++++++-----
 configs/xilinx_mbv32_smode_defconfig |  2 +-
 configs/xilinx_mbv64_defconfig       |  1 +
 configs/xilinx_mbv64_smode_defconfig |  2 +-
 configs/xilinx_mbv_spi.config        | 14 ++++++++++++++
 6 files changed, 43 insertions(+), 10 deletions(-)
 create mode 100644 configs/xilinx_mbv_spi.config

---

-- 
2.43.0

