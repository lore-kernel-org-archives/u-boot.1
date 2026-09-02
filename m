Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C705C61DD6
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 13:15:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C2F9A60874;
	Wed,  2 Sep 2026 13:15:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nSJCwvc-e9X5; Wed,  2 Sep 2026 13:15:55 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788354955;
	bh=DU31gNF9vQYHEXaEP1Yq6vfOCDijbl6+1U3hrsSZfto=;
	h=Date:From:Subject:To:CC:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=OhpHsS2vPf8dFbxL5KNq/Y0JOWE/TCOv6tpXA/Dai4PQlzXxTcNF5O7yO1dh0J0Df
	 p9IHgmHC1ptND4USKT8wJMgtvSRZAQtsdJp3rnphtwO8NmMNWkDA4vRfCSpi1xZ10v
	 EInHbCYAeAT4rnxrp0QMFUr0yGteLRPLjYBkenHX2BTP96wweUJchaIJ3s0OaI8ab8
	 C/y2IlqByPWfQ6LBfqy2VlTz4II678yO6kiS28/hZnhdverHpP342HYuxyqeqHKzW8
	 2EYva3pK6fwVSZg2RifSLCp8Xs6U/w5pJpCti4UaghZEz5Lbh2P3zJ5iIQA+cc0fIG
	 BrCWDxamWmCAA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BD215606F1;
	Wed,  2 Sep 2026 13:15:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 16A1B2FE
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 13:15:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 13FFD80F60
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 13:15:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GAOsAlMf2Q4H for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 13:15:52 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::6;
 helo=am0pr02cu008.outbound.protection.outlook.com;
 envelope-from=patrice.chotard@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=kaDqXJwu
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C9E5B80F5A
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 13:15:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F7iCwxEO0sN7X4T8zRqbQnDK96GRwPo20Y7ViYfQLeFJAhiM5Zy/++a0dlJ2F9L7fewfjXXnLSHpt3SziMvcydIr7a7p8CBPCUxNNs/tttj1NjAkyJTIo0m7gkmSXVuuxp3b2sZ0fXZa+tbA0+HpW/3mae0jc+zH8W4+cJN8ZComzaQ73zlMcACK/ZJFo6egRp1COuiYAv3f8/q2YwUmKcC65hwxjgq1wv2ad0kePop6nOjUKEWk9kaaxc+N0ZR2l1LMUK9TjVaeExlQEmHatgRsulAHaPpJFjMD5rE5dsAGY5IutVRsylyMoodn8BfodOtZY/Z7/BVRWitHQaWOxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DU31gNF9vQYHEXaEP1Yq6vfOCDijbl6+1U3hrsSZfto=;
 b=QzPIA+T541tDjcICj5U9J9/d6kT4QaYjfODqdUCrUMRnNzzjI5hJQCwrU+5Jl05s96lAs22iIYcjafw52iydAw9B4O2VC/tBYN5LuUgBSDKVJzwmfY08PeszMMOqQ+jP5buOTN+uICyVX/fjUaPThNz/LVtr7autIqDuoTYXfmEP3BocD8yM5LKeu8REdidXQ26jvlwjtGs/1pmqd/eFN4OQoeVEquowl1llmZu04PtNxUED206tBJ1iLpHYoBHKlksmxjtHTAbFDRnHOF9JVzC2gTzL4e1ou9zEqfSk2RREGdtlMm4xP/4v7YOULoj5dd/mW8ZgWOAm5wqr9iXrcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.88) smtp.rcpttodomain=konsulko.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DU31gNF9vQYHEXaEP1Yq6vfOCDijbl6+1U3hrsSZfto=;
 b=kaDqXJwu8EtsFY2/mI+4hZTEFGyiN6f8k+WboS/z7TX3yR2Fu9YYcfKIbXXfIHaS50luaHuuQnkZjV+iyqoSl14L6YrDW89CrCA/VETts1acqoaQaJSwh7xrWWFCXL6CDq/kxxV+hUK0yJVWkTXnDma1+9vF84X0sRCSOrO0GTQYt2hswo2X+Vokpe7BIq4h0ABXcu56HhtJglqj57nnhRn9iO8N60H+EgxIVZ7SZqzizd7M0uA1fzGJpoOt09RqaXU22jXj8jtZzq22JLoVqo2+QxVycy5nE3rz0QlNH5RYPTnVCEdMBMyH/ww/w/08OrNHPwVaItcPOdGh+Qoalg==
Received: from DUZP191CA0061.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4fa::16)
 by DU4PR10MB8611.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:55c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 13:15:46 +0000
Received: from DU6PEPF00009524.eurprd02.prod.outlook.com
 (2603:10a6:10:4fa:cafe::5) by DUZP191CA0061.outlook.office365.com
 (2603:10a6:10:4fa::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Wed, 2
 Sep 2026 13:15:46 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.88)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.88 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.88; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.88) by
 DU6PEPF00009524.mail.protection.outlook.com (10.167.8.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 13:15:46 +0000
Received: from ENXDAG1NODE3.st.com (10.75.129.196) by smtpo365.st.com
 (10.250.44.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 2 Sep
 2026 15:13:04 +0200
Received: from [10.48.87.93] (10.48.87.93) by ENXDAG1NODE3.st.com
 (10.75.129.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 2 Sep
 2026 15:15:45 +0200
Message-ID: <e6962ed9-c56c-4305-8f72-05c1da14b8a1@foss.st.com>
Date: Wed, 2 Sep 2026 15:15:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
Subject: [PULL] Pull request for u-boot master / v2026.10 =
 u-boot-stm32_20260902
To: Tom Rini <trini@konsulko.com>, "u-boot@lists.u-boot-project.org"
 <u-boot@lists.u-boot-project.org>
CC: Patrice Chotard <patrice.chotard@foss.st.com>, Patrick DELAUNAY
 <patrick.delaunay@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To ENXDAG1NODE3.st.com
 (10.75.129.196)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF00009524:EE_|DU4PR10MB8611:EE_
X-MS-Office365-Filtering-Correlation-Id: a1ef86d5-6d83-4ebd-f0ce-08df08f44ce4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|23010399003|376014|1800799024|18002099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: +BZofXj5KssWARQzXQxz2pyz6Z81HLFOtpOrWIdDZNsznHu1Skt134fKCyMzzDhQpzqLD08AE7mLrRGcXVX/CBY1K6IqrIsv8ahueILttG7YDGQnWdUOvsiiKyvcOAZIKZiBerO1kV7/JOZefTRflUfe/NEpRifUoyAo2+lQspVg4JOvzQNNCKdg6yuPHpABIdkNC7v9wt5+CA3ZgFu7Tz6p2DZlZNASyeHz+0SboZfbRxUC1/ciG9nJg17eP4WoLyY0PsV9/uWFx/FcYj/ABg8yF8Yx4VbKq3QJrvu0UoObDRWijnPWopz4EJz7zzeTvhSxQKgtLIxlxMZbYBtHBdgB4zf5rw0MdlwoT24brHfofWaE8h1gr1hKZwRxhEHN98CwCRRtxsjIUxHt09VSeSYbodsaZ1iKG8tw7Up/Gx4qxYofCN4ZPCCv2wShabBqIKILflDK+SaPENYrS49Ui2oxRhq8IbfjxYymXILuygVhsokwn/PTQ7OHVkUrdPGA5YYhxtiWJcJeypTdqYBiPJ3g9Oie4P1Q3Wf9m3VdZvjk1w+XYK6TvcoWvVKDynq1qi8MCbBazE3mzpuBDFXq5vG//ALhA8hxMtmGPFBX50OhDSxqUVWZXh35xJdb4Zz8+3C6TqjJIpEiYS7IMAOm/w==
X-Forefront-Antispam-Report: CIP:164.130.1.88; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(23010399003)(376014)(1800799024)(18002099003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: X9ukVib7ELSbnTqKAXaMom9Z5LKWlpXvgeGIF9IQWxpBOEr56lNdg1B3Nlf3vuSGyYtKVYPRUN8vZ1mFfArucWhTdkW+qmaz5qanF6Tj2h9Jipwp7IOpc3r9qQzwGvU5j+fNUkdp26rWCQvCVEHHeZsf+m1Gxnw4bKhsx8h0oWvWtm7B3uB9JQqIL13vaZL8jRjlHeI8mvoed2J89Ff111Cd+0NKAmxE2ImKSvBTd46uTo089zqVoejA0FmwSfzbmDOvdPhPEGJAywh7Q2T6c8XUkXb3X3UyGYZG+dk7WY5qdRaeC0nEey/QWl8d07daaQGyRgiJS6UA+39+p9ehDMZT6zwBMfJ8NT6uerKVu22gro4zIiBF9aslDHacgpjcK8V89fZI8R84DjM92IoLa2IDfOABk8dooIfgDIOdybz5C2WCuGoFhxm3C5y6E+rJ
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 13:15:46.3907 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1ef86d5-6d83-4ebd-f0ce-08df08f44ce4
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.88];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF00009524.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8611
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

Hi Tom

Please pull the STM32 related fixes for u-boot/master, v2026.10: u-boot-stm32_20260902

CI status: https://git.u-boot-project.org/u-boot/custodians/u-boot-stm/-/pipelines/1162

Thanks

The following changes since commit cc8c034e78eba6b2a3845783889b80753bb1af1e:

  Merge tag 'u-boot-stm32-20260831' of https://git.u-boot-project.org/u-boot/custodians/u-boot-stm (2026-09-01 08:14:37 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-stm.git tags/u-boot-stm32-20260902

for you to fetch changes up to 036aca606c77908290913ebf57cafc42d8524f67:

  board: st: Fix compilation issue (2026-09-02 13:48:57 +0200)

----------------------------------------------------------------
STM32MP:
  - Fix compilation when CONFIG_FWU_MULTI_BANK_UPDATE flag is enabled

----------------------------------------------------------------
Patrice Chotard (1):
      board: st: Fix compilation issue

 board/st/common/stm32mp_fwu.c | 2 ++
 1 file changed, 2 insertions(+)
