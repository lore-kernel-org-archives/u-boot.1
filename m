Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F91F606A31C
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 06:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=epW1e5pj;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=M43+CQuG
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8D9334075D;
	Tue, 17 Nov 2026 06:59:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fN72DOvhdCA3; Tue, 17 Nov 2026 06:59:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D505D4071D
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794898753;
	b=PhpE+qmeGUpp17wQBL7QoMCu/7tuMGGdORV5EiH3vee0gc4k6u8QZzU59zlTo/Bvh2Yg
	 Ifr8Xg7FtiOJYId/29vsUy/o/5FO0Rh5+oYMRXSqeptUg7ev89COjT/oVozEB7PFrQqPU
	 fkx1yolutrhSBB5gegHoxRoLJmop1O/P3/OAt5oPbMejxEbVhzM0+x5aAYTD/ra2rRAMM
	 Xkc7954mkfbofm80QpO4aEaGwEGi7Zj0zJXRkbFIYpajH2IleGB+Ws/PFa1qanuihDEPF
	 JMOKdHCgSOLfvaKUdNLaBlArPcIxzfddmSHBND1EC516F68VoExjQf0Cuu6R7TrCYvA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794898753;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:CC:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
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
	bh=+wmlHLY0hAyJ9+/915pO2x7MSjzAFWbw/kjma1KU3a4=;
	b=jEX1WP9jGio4Yw7EdnCoWpcEgaUl7hN9/HrUs1a3bWP9O6JZO/dKcYzT5rwaF4Lu4v+A
	 QtlwbfLX/sRxJ4cIxiP/V+LIEn7755mCLFDIltmhrGR/l5N8suIhCsLIZ8NZ0tsTBt1F7
	 KE/XOYyiC1GECWkq0WphNGNbiPYiGxb+dZ5fP6kTWiNGtfb5W0kTlphtVLG2PU5fGz5bH
	 XKVk2A03ktRkgMsdmOZ687WBwIvC/jj9uR/bChdT+FPwLvrt8GD6QZZMOB+nlk6+uZnwC
	 30HRuchgKQxYMrndy650NIoYYX626sXbqc9qHNh0pvSAahhl35jjKN+sYfQhMGUEADg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794898753;
	bh=+wmlHLY0hAyJ9+/915pO2x7MSjzAFWbw/kjma1KU3a4=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=epW1e5pjwyf67yf8IWR1dNMqnet+uleYTsYVFJQOHxnaenoMSdKt9fxnJWlq7RLYD
	 cbRTpyfPy+6Zmcqo9XwxvIQG7AgfWTnXZirsUZOe5o8lcx4NOUKPHoov0NKppIJHRj
	 Sx4hbUunrMya327SWmZQWs69RLYUSkFYNyWVtC88SHfHDYV8AvxO4U0MlxeliyWFOo
	 Y3pSdUHxCeSmjlprMgZAaLpaFaiI3AQPZbyJX2uV5qma0/03tquVCLyWXthwJnEyu0
	 7gPl4+Ibx1BNMz6GjsW6cI6JtsQ1/DWm6nUkiOjW/LK9N6nCmbPje/NMXTzvHNaWs2
	 cF4wiKJSwBfzQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D505D4071D;
	Tue, 17 Nov 2026 06:59:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 99D9CA0E
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 06:59:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8BE694017B
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 06:59:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mbNbiuhVSNMk for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 06:59:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 9C69540048
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::3;
 helo=du2pr03cu002.outbound.protection.outlook.com;
 envelope-from=patrice.chotard@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=M43+CQuG
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9C69540048
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 06:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+wmlHLY0hAyJ9+/915pO2x7MSjzAFWbw/kjma1KU3a4=;
 b=M43+CQuGJIY4QkRRWRqf9UBQ1RPhNHl02Lg8/3LufWv+/70VzxNZxyUjg+VzSIWofJ1nipnMQCRZ2uOUcG/1a7jdnuC7AfhpYT936S5qi8Je9hgT/dKj+JvGeYP2Ia6B37g+lfOidzxH4qANzVVeJ0ECcoSHeSuO3X0O89nZNTNJMqklMENb099j8uh5CB+3GcLgTMeCETUjeVKRQtiHxbT+efGk7efv5w9vQ+AT553LIES3GFSP1XMB3trOM8HSuE7eHQWxd3qExOp63UUeHDbofrtccHDSJT/IsLVomg78IFfsLUeKnMCpm4y6KUiTTH7b5/beXLIr/Mc+8ykB2g==
Received: from PA7P264CA0258.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:375::7)
 by VI1PR10MB3246.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:139::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.8; Tue, 17 Nov
 2026 06:58:57 +0000
Received: from MAD0EPF000008C7.eurprd05.prod.outlook.com
 (2603:10a6:102:375:cafe::95) by PA7P264CA0258.outlook.office365.com
 (2603:10a6:102:375::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Tue,
 17 Nov 2026 06:58:57 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 MAD0EPF000008C7.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 06:58:57 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 17 Nov
 2026 07:59:57 +0100
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 17 Nov
 2026 07:58:55 +0100
Message-ID: <457ab4e7-144b-4bd3-ad9a-81838bba0c6c@foss.st.com>
Date: Tue, 17 Nov 2026 07:58:55 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] power: pmic: Constify driver ops
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 <u-boot@lists.u-boot-project.org>
CC: Casey Connolly <casey.connolly@linaro.org>, Chunfeng Yun
 <chunfeng.yun@mediatek.com>, David Lechner <dlechner@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Igor Belwon
 <igor.belwon@mentallysanemainliners.org>, Jaehoon Chung
 <jh80.chung@samsung.com>, Julien Stephan <jstephan@baylibre.com>, "Kumara
 Bhimeswararao Matsa" <bhimesh.matsa@gmail.com>, Linus Walleij
 <linusw@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, "Patrick
 Delaunay" <patrick.delaunay@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 "Quentin Schulz" <u-boot@0leil.net>, Ryder Lee <ryder.lee@mediatek.com>,
 "Stephan Gerhold" <stephan@gerhold.net>, Sumit Garg <sumit.garg@kernel.org>,
 Tom Rini <trini@konsulko.com>, Weijie Gao <weijie.gao@mediatek.com>,
 <u-boot-qcom@groups.io>, <uboot-stm32@st-md-mailman.stormreply.com>
References: <20261116174138.3488177-1-marek.vasut+renesas@mailbox.org>
 <20261116174138.3488177-3-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20261116174138.3488177-3-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAD0EPF000008C7:EE_|VI1PR10MB3246:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b7c8844-38c8-42a7-8ca8-08df44784034
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|7416014|22082099003|18002099003|261009223027099003|11063799006|260925022911599003|260925021911599003|260925021311599003|56012099006|10067099003|4143699003|261102123227099003|261028144727099003|261026121527099003|261026140227099003|261021121427099003|261021123027099003|261022105027099003;
X-Microsoft-Antispam-Message-Info: LBtyjw7NaxY04cBuKhc1gLBP2N4IeojTbYTMgVV0mOcg7WvgiuMNUHqdQU0j3HeVjf1br+P1sjMztX3v2EM6S9A6KDigu5IBVjUSEw7G98np2C1+q5bz4tkswfIiHzcpxlg5/hoBgqc7Eme8oOcGZtzxOxYZdneeMCNeJacI3HuSu2WLojCcguDQDwhXwntmFMcixVaRAKV2YT/FBvDCgKeEgLlQdQ4PXqlJ6qS95OZX9b/ho2irD4o+ZHCBiiKvYeT4B+Sp9Yic0FP+39uBCi0fciWYJnnSiqvx+04I1bqRZ3x+7TJA84UlWulenrz8tVJxZjDAiiDPYLdcYtZx6QpM+SFWVq1CQi95EgB0yI70yJArm/Xi/72kTx/sLV/KxVIE+d1psQsR1iJTKuUXFMTkeQX53DZq3cQHnzG07WEWLS74Vms5JA4Yxp+SFI0c+jPcOZn6pKS6BlKj9HbrmJ4UOmPGunMj+ioObn7weuV2Mm0V2OBX70zHS/2Y7kURMhU5sLnqQ6nK24pTdkuSMT3WxvpRAmzbNQh9ERJe+NrmK4o9e6Vh2LtfLejlcuiSx0+j9z+2kzy94gh8WX/dOOtxSt12CYOniXxfZmU5katgNCv6NN5nxvozOELtsEbcpbxPK83Yv+/3a9+15Mkf1zSYWCLHRf/Y5GUHlCZsf177qMpvr6yyJxQ1HPE/HDdA4EAXDZqMw5+6R3aU8Ow8vA==
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(7416014)(22082099003)(18002099003)(261009223027099003)(11063799006)(260925022911599003)(260925021911599003)(260925021311599003)(56012099006)(10067099003)(4143699003)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021121427099003)(261021123027099003)(261022105027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RcSeFSwPg0QzaYIcMrwY5Y0/vgllypIKeo+7ZTuj5JLpgLGKorcZseBAA1tZzs6aAzlu9mHQTkjxzzauI35lBzag65+WJGxWYF8n6p3VDnX3dQwpAUk4YZxf13jn2rB47yjRYROIR/1KC8Aw9jmpV+Ah8Gsw4txBqzoIjo7HAXMfJtvJHYM6q+MNO6l/OxAd7wcGHKWovEJH3Yu3riEUzg6rgvZ1ZdPWJ1CnVLlv9GoD1ne1foNfdsyHo5+OsaSC2+S0RX3E34wsxPFH+GRVlaFQZR18OuanlKVn7lyy6yg2CsaS7Pj1AxNg19MkA9MzFxqssDjGO+SYQEMOJkyYapwAm2j1Y8CQ1na/jprCcoWwzo9fLalCb5QoxioA+0TBfxT78x4Lfa17GnIyUhnsWDfTCxvcJs6sJ/uapkx3q6Juta+jGQRivSFqNsJBgS0U
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 06:58:57.2710 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b7c8844-38c8-42a7-8ca8-08df44784034
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: MAD0EPF000008C7.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3246
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/16/26 18:41, Marek Vasut wrote:
> Set the ops structure as static const. The structure is not accessible
> from outside of this driver and is not going to be modified at runtime.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Casey Connolly <casey.connolly@linaro.org>
> Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
> Cc: David Lechner <dlechner@baylibre.com>
> Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
> Cc: Igor Belwon <igor.belwon@mentallysanemainliners.org>
> Cc: Jaehoon Chung <jh80.chung@samsung.com>
> Cc: Julien Stephan <jstephan@baylibre.com>
> Cc: Kumara Bhimeswararao Matsa <bhimesh.matsa@gmail.com>
> Cc: Linus Walleij <linusw@kernel.org>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: Quentin Schulz <u-boot@0leil.net>
> Cc: Ryder Lee <ryder.lee@mediatek.com>
> Cc: Stephan Gerhold <stephan@gerhold.net>
> Cc: Sumit Garg <sumit.garg@kernel.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Weijie Gao <weijie.gao@mediatek.com>
> Cc: u-boot-qcom@groups.io
> Cc: u-boot@lists.u-boot-project.org
> Cc: uboot-stm32@st-md-mailman.stormreply.com
> ---
>  drivers/power/pmic/ab8500.c           | 2 +-
>  drivers/power/pmic/act8846.c          | 2 +-
>  drivers/power/pmic/as3722.c           | 2 +-
>  drivers/power/pmic/axp.c              | 4 ++--
>  drivers/power/pmic/bd71837.c          | 2 +-
>  drivers/power/pmic/cpcap.c            | 2 +-
>  drivers/power/pmic/da9063.c           | 2 +-
>  drivers/power/pmic/fan53555.c         | 2 +-
>  drivers/power/pmic/lp873x.c           | 2 +-
>  drivers/power/pmic/lp87565.c          | 2 +-
>  drivers/power/pmic/max77663.c         | 2 +-
>  drivers/power/pmic/max77686.c         | 2 +-
>  drivers/power/pmic/max8907.c          | 2 +-
>  drivers/power/pmic/max8997.c          | 2 +-
>  drivers/power/pmic/max8998.c          | 2 +-
>  drivers/power/pmic/mc34708.c          | 2 +-
>  drivers/power/pmic/mp5416.c           | 2 +-
>  drivers/power/pmic/mtk-pwrap.c        | 2 +-
>  drivers/power/pmic/palmas.c           | 2 +-
>  drivers/power/pmic/pca9450.c          | 4 ++--
>  drivers/power/pmic/pfuze100.c         | 2 +-
>  drivers/power/pmic/pmic_qcom.c        | 2 +-
>  drivers/power/pmic/pmic_tps65217.c    | 2 +-
>  drivers/power/pmic/pmic_tps65910_dm.c | 2 +-
>  drivers/power/pmic/raa215300.c        | 2 +-
>  drivers/power/pmic/rk8xx.c            | 4 ++--
>  drivers/power/pmic/rn5t567.c          | 2 +-
>  drivers/power/pmic/s2mps11.c          | 2 +-
>  drivers/power/pmic/s5m8767.c          | 2 +-
>  drivers/power/pmic/sandbox.c          | 2 +-
>  drivers/power/pmic/stpmic1.c          | 4 ++--
>  drivers/power/pmic/tps65090.c         | 2 +-
>  drivers/power/pmic/tps65219.c         | 2 +-
>  drivers/power/pmic/tps65941.c         | 2 +-
>  drivers/power/pmic/tps80031.c         | 2 +-
>  35 files changed, 39 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/power/pmic/ab8500.c b/drivers/power/pmic/ab8500.c
> index b9fae7000b7..2c93a8031df 100644
> --- a/drivers/power/pmic/ab8500.c
> +++ b/drivers/power/pmic/ab8500.c
> @@ -215,7 +215,7 @@ static int ab8500_write(struct udevice *dev, uint reg, const uint8_t *buf, int l
>  	return 0;
>  }
>  
> -static struct dm_pmic_ops ab8500_ops = {
> +static const struct dm_pmic_ops ab8500_ops = {
>  	.reg_count = ab8500_reg_count,
>  	.read = ab8500_read,
>  	.write = ab8500_write,
> diff --git a/drivers/power/pmic/act8846.c b/drivers/power/pmic/act8846.c
> index 3058ef0f893..61f49fa76af 100644
> --- a/drivers/power/pmic/act8846.c
> +++ b/drivers/power/pmic/act8846.c
> @@ -65,7 +65,7 @@ static int act8846_bind(struct udevice *dev)
>  	return 0;
>  }
>  
> -static struct dm_pmic_ops act8846_ops = {
> +static const struct dm_pmic_ops act8846_ops = {
>  	.reg_count = act8846_reg_count,
>  	.read = act8846_read,
>  	.write = act8846_write,
> diff --git a/drivers/power/pmic/as3722.c b/drivers/power/pmic/as3722.c
> index 9b0f4fb9736..febe0a72852 100644
> --- a/drivers/power/pmic/as3722.c
> +++ b/drivers/power/pmic/as3722.c
> @@ -155,7 +155,7 @@ static int as3722_reg_count(struct udevice *dev)
>  	return AS3722_NUM_OF_REGS;
>  }
>  
> -static struct dm_pmic_ops as3722_ops = {
> +static const struct dm_pmic_ops as3722_ops = {
>  	.reg_count = as3722_reg_count,
>  	.read = as3722_read,
>  	.write = as3722_write,
> diff --git a/drivers/power/pmic/axp.c b/drivers/power/pmic/axp.c
> index 7d8348b0769..f6a9396ae43 100644
> --- a/drivers/power/pmic/axp.c
> +++ b/drivers/power/pmic/axp.c
> @@ -22,7 +22,7 @@ static int axp_sysreset_request(struct udevice *dev, enum sysreset_t type)
>  	return -EINPROGRESS;
>  }
>  
> -static struct sysreset_ops axp_sysreset_ops = {
> +static const struct sysreset_ops axp_sysreset_ops = {
>  	.request	= axp_sysreset_request,
>  };
>  
> @@ -39,7 +39,7 @@ static int axp_pmic_reg_count(struct udevice *dev)
>  	return 0x100;
>  }
>  
> -static struct dm_pmic_ops axp_pmic_ops = {
> +static const struct dm_pmic_ops axp_pmic_ops = {
>  	.reg_count	= axp_pmic_reg_count,
>  	.read		= dm_i2c_read,
>  	.write		= dm_i2c_write,
> diff --git a/drivers/power/pmic/bd71837.c b/drivers/power/pmic/bd71837.c
> index 13642794765..9c9eba6343a 100644
> --- a/drivers/power/pmic/bd71837.c
> +++ b/drivers/power/pmic/bd71837.c
> @@ -87,7 +87,7 @@ static int bd718x7_probe(struct udevice *dev)
>  	return 0;
>  }
>  
> -static struct dm_pmic_ops bd71837_ops = {
> +static const struct dm_pmic_ops bd71837_ops = {
>  	.reg_count = bd71837_reg_count,
>  	.read = bd71837_read,
>  	.write = bd71837_write,
> diff --git a/drivers/power/pmic/cpcap.c b/drivers/power/pmic/cpcap.c
> index b9d783773ed..b3889f6bcf4 100644
> --- a/drivers/power/pmic/cpcap.c
> +++ b/drivers/power/pmic/cpcap.c
> @@ -106,7 +106,7 @@ static int cpcap_probe(struct udevice *dev)
>  	return 0;
>  }
>  
> -static struct dm_pmic_ops cpcap_ops = {
> +static const struct dm_pmic_ops cpcap_ops = {
>  	.read = cpcap_read,
>  	.write = cpcap_write,
>  };
> diff --git a/drivers/power/pmic/da9063.c b/drivers/power/pmic/da9063.c
> index 59c65702863..a6177ecb92c 100644
> --- a/drivers/power/pmic/da9063.c
> +++ b/drivers/power/pmic/da9063.c
> @@ -118,7 +118,7 @@ static int da9063_probe(struct udevice *dev)
>  	return i2c_set_chip_addr_offset_mask(dev, 0x1);
>  }
>  
> -static struct dm_pmic_ops da9063_ops = {
> +static const struct dm_pmic_ops da9063_ops = {
>  	.reg_count = da9063_reg_count,
>  	.read = da9063_read,
>  	.write = da9063_write,
> diff --git a/drivers/power/pmic/fan53555.c b/drivers/power/pmic/fan53555.c
> index 95bf600cbc3..7cf4d0b9d73 100644
> --- a/drivers/power/pmic/fan53555.c
> +++ b/drivers/power/pmic/fan53555.c
> @@ -65,7 +65,7 @@ static int pmic_fan53555_bind(struct udevice *dev)
>  					    dev_ofnode(dev), &child);
>  };
>  
> -static struct dm_pmic_ops pmic_fan53555_ops = {
> +static const struct dm_pmic_ops pmic_fan53555_ops = {
>  	.reg_count = pmic_fan53555_reg_count,
>  	.read = pmic_fan53555_read,
>  	.write = pmic_fan53555_write,
> diff --git a/drivers/power/pmic/lp873x.c b/drivers/power/pmic/lp873x.c
> index 2c8fa4ea312..f8c6736f437 100644
> --- a/drivers/power/pmic/lp873x.c
> +++ b/drivers/power/pmic/lp873x.c
> @@ -62,7 +62,7 @@ static int lp873x_bind(struct udevice *dev)
>  	return 0;
>  }
>  
> -static struct dm_pmic_ops lp873x_ops = {
> +static const struct dm_pmic_ops lp873x_ops = {
>  	.read = lp873x_read,
>  	.write = lp873x_write,
>  };
> diff --git a/drivers/power/pmic/lp87565.c b/drivers/power/pmic/lp87565.c
> index c2ff75bbcdc..b77feaf57da 100644
> --- a/drivers/power/pmic/lp87565.c
> +++ b/drivers/power/pmic/lp87565.c
> @@ -65,7 +65,7 @@ static int lp87565_bind(struct udevice *dev)
>  	return 0;
>  }
>  
> -static struct dm_pmic_ops lp87565_ops = {
> +static const struct dm_pmic_ops lp87565_ops = {
>  	.read = lp87565_read,
>  	.write = lp87565_write,
>  };
> diff --git a/drivers/power/pmic/max77663.c b/drivers/power/pmic/max77663.c
> index a06042e2918..10f692e894c 100644
> --- a/drivers/power/pmic/max77663.c
> +++ b/drivers/power/pmic/max77663.c
> @@ -83,7 +83,7 @@ static int max77663_bind(struct udevice *dev)
>  	return 0;
>  }
>  
> -static struct dm_pmic_ops max77663_ops = {
> +static const struct dm_pmic_ops max77663_ops = {
>  	.read = max77663_read,
>  	.write = max77663_write,
>  };
> diff --git a/drivers/power/pmic/max77686.c b/drivers/power/pmic/max77686.c
> index bfe57b386d3..900a33a2219 100644
> --- a/drivers/power/pmic/max77686.c
> +++ b/drivers/power/pmic/max77686.c
> @@ -68,7 +68,7 @@ static int max77686_bind(struct udevice *dev)
>  	return 0;
>  }
>  
> -static struct dm_pmic_ops max77686_ops = {
> +static const struct dm_pmic_ops max77686_ops = {
>  	.reg_count = max77686_reg_count,
>  	.read = max77686_read,
>  	.write = max77686_write,
> diff --git a/drivers/power/pmic/max8907.c b/drivers/power/pmic/max8907.c
> index 34bef0c8cd6..cb0d0feceb1 100644
> --- a/drivers/power/pmic/max8907.c
> +++ b/drivers/power/pmic/max8907.c
> @@ -76,7 +76,7 @@ static int max8907_bind(struct udevice *dev)
>  	return 0;
>  }
>  
> -static struct dm_pmic_ops max8907_ops = {
> +static const struct dm_pmic_ops max8907_ops = {
>  	.read = max8907_read,
>  	.write = max8907_write,
>  };
> diff --git a/drivers/power/pmic/max8997.c b/drivers/power/pmic/max8997.c
> index fb65a3ca730..d80257d0e6a 100644
> --- a/drivers/power/pmic/max8997.c
> +++ b/drivers/power/pmic/max8997.c
> @@ -39,7 +39,7 @@ static int max8997_read(struct udevice *dev, uint reg, uint8_t *buff, int len)
>  	return ret;
>  }
>  
> -static struct dm_pmic_ops max8997_ops = {
> +static const struct dm_pmic_ops max8997_ops = {
>  	.reg_count = max8997_reg_count,
>  	.read	= max8997_read,
>  	.write	= max8997_write,
> diff --git a/drivers/power/pmic/max8998.c b/drivers/power/pmic/max8998.c
> index 05669023753..e59e79e6248 100644
> --- a/drivers/power/pmic/max8998.c
> +++ b/drivers/power/pmic/max8998.c
> @@ -39,7 +39,7 @@ static int max8998_read(struct udevice *dev, uint reg, uint8_t *buff, int len)
>  	return ret;
>  }
>  
> -static struct dm_pmic_ops max8998_ops = {
> +static const struct dm_pmic_ops max8998_ops = {
>  	.reg_count = max8998_reg_count,
>  	.read	= max8998_read,
>  	.write	= max8998_write,
> diff --git a/drivers/power/pmic/mc34708.c b/drivers/power/pmic/mc34708.c
> index 0ec52e25a9e..0bd1ea72b39 100644
> --- a/drivers/power/pmic/mc34708.c
> +++ b/drivers/power/pmic/mc34708.c
> @@ -82,7 +82,7 @@ static int mc34708_probe(struct udevice *dev)
>  	return 0;
>  }
>  
> -static struct dm_pmic_ops mc34708_ops = {
> +static const struct dm_pmic_ops mc34708_ops = {
>  	.reg_count = mc34708_reg_count,
>  	.read	= mc34708_read,
>  	.write	= mc34708_write,
> diff --git a/drivers/power/pmic/mp5416.c b/drivers/power/pmic/mp5416.c
> index 899c2beeb37..382b93415a8 100644
> --- a/drivers/power/pmic/mp5416.c
> +++ b/drivers/power/pmic/mp5416.c
> @@ -74,7 +74,7 @@ static int mp5416_probe(struct udevice *dev)
>  	return 0;
>  }
>  
> -static struct dm_pmic_ops mp5416_ops = {
> +static const struct dm_pmic_ops mp5416_ops = {
>  	.reg_count = mp5416_reg_count,
>  	.read = mp5416_read,
>  	.write = mp5416_write,
> diff --git a/drivers/power/pmic/mtk-pwrap.c b/drivers/power/pmic/mtk-pwrap.c
> index 468af1fba04..4e350cc97c6 100644
> --- a/drivers/power/pmic/mtk-pwrap.c
> +++ b/drivers/power/pmic/mtk-pwrap.c
> @@ -862,7 +862,7 @@ static int mtk_pwrap_write(struct udevice *dev, uint reg, const uint8_t *buf, in
>  	return pwrap_write(wrp, reg, *(u32 *)buf);
>  }
>  
> -static struct dm_pmic_ops mtk_pwrap_ops = {
> +static const struct dm_pmic_ops mtk_pwrap_ops = {
>  	.reg_count = mtk_pwrap_reg_count,
>  	.read = mtk_pwrap_read,
>  	.write = mtk_pwrap_write,
> diff --git a/drivers/power/pmic/palmas.c b/drivers/power/pmic/palmas.c
> index e5b497dfc39..efc455ac6a7 100644
> --- a/drivers/power/pmic/palmas.c
> +++ b/drivers/power/pmic/palmas.c
> @@ -118,7 +118,7 @@ static int palmas_probe(struct udevice *dev)
>  	return 0;
>  }
>  
> -static struct dm_pmic_ops palmas_ops = {
> +static const struct dm_pmic_ops palmas_ops = {
>  	.read = palmas_read,
>  	.write = palmas_write,
>  };
> diff --git a/drivers/power/pmic/pca9450.c b/drivers/power/pmic/pca9450.c
> index cbe8cd05be7..7278b6407e9 100644
> --- a/drivers/power/pmic/pca9450.c
> +++ b/drivers/power/pmic/pca9450.c
> @@ -99,7 +99,7 @@ static int pca9450_probe(struct udevice *dev)
>  			       PCA9450_PMIC_RESET_WDOG_B_CFG_MASK, reset_ctrl);
>  }
>  
> -static struct dm_pmic_ops pca9450_ops = {
> +static const struct dm_pmic_ops pca9450_ops = {
>  	.reg_count = pca9450_reg_count,
>  	.read = pca9450_read,
>  	.write = pca9450_write,
> @@ -180,7 +180,7 @@ int pca9450_sysreset_get_status(struct udevice *dev, char *buf, int size)
>  	return 0;
>  }
>  
> -static struct sysreset_ops pca9450_sysreset_ops = {
> +static const struct sysreset_ops pca9450_sysreset_ops = {
>  	.request	= pca9450_sysreset_request,
>  	.get_status	= pca9450_sysreset_get_status,
>  };
> diff --git a/drivers/power/pmic/pfuze100.c b/drivers/power/pmic/pfuze100.c
> index 9e09805d251..dedd149a3f6 100644
> --- a/drivers/power/pmic/pfuze100.c
> +++ b/drivers/power/pmic/pfuze100.c
> @@ -71,7 +71,7 @@ static int pfuze100_bind(struct udevice *dev)
>  	return 0;
>  }
>  
> -static struct dm_pmic_ops pfuze100_ops = {
> +static const struct dm_pmic_ops pfuze100_ops = {
>  	.reg_count = pfuze100_reg_count,
>  	.read = pfuze100_read,
>  	.write = pfuze100_write,
> diff --git a/drivers/power/pmic/pmic_qcom.c b/drivers/power/pmic/pmic_qcom.c
> index 4b8dcc6104c..8dfac183a48 100644
> --- a/drivers/power/pmic/pmic_qcom.c
> +++ b/drivers/power/pmic/pmic_qcom.c
> @@ -51,7 +51,7 @@ static int pmic_qcom_read(struct udevice *dev, uint reg, uint8_t *buff, int len)
>  	return 0;
>  }
>  
> -static struct dm_pmic_ops pmic_qcom_ops = {
> +static const struct dm_pmic_ops pmic_qcom_ops = {
>  	.reg_count = pmic_qcom_reg_count,
>  	.read = pmic_qcom_read,
>  	.write = pmic_qcom_write,
> diff --git a/drivers/power/pmic/pmic_tps65217.c b/drivers/power/pmic/pmic_tps65217.c
> index bd44e0d9ae0..eb3c5cf926e 100644
> --- a/drivers/power/pmic/pmic_tps65217.c
> +++ b/drivers/power/pmic/pmic_tps65217.c
> @@ -210,7 +210,7 @@ static int tps65217_bind(struct udevice *dev)
>  	return 0;
>  }
>  
> -static struct dm_pmic_ops tps65217_ops = {
> +static const struct dm_pmic_ops tps65217_ops = {
>  	.reg_count = tps65217_reg_count,
>  	.read = tps65217_read,
>  	.write = tps65217_write,
> diff --git a/drivers/power/pmic/pmic_tps65910_dm.c b/drivers/power/pmic/pmic_tps65910_dm.c
> index bce35603275..9811b75f1df 100644
> --- a/drivers/power/pmic/pmic_tps65910_dm.c
> +++ b/drivers/power/pmic/pmic_tps65910_dm.c
> @@ -95,7 +95,7 @@ static int pmic_tps65910_probe(struct udevice *dev)
>  			       TPS65910_I2C_SEL_MASK);
>  }
>  
> -static struct dm_pmic_ops pmic_tps65910_ops = {
> +static const struct dm_pmic_ops pmic_tps65910_ops = {
>  	.reg_count = pmic_tps65910_reg_count,
>  	.read = pmic_tps65910_read,
>  	.write = pmic_tps65910_write,
> diff --git a/drivers/power/pmic/raa215300.c b/drivers/power/pmic/raa215300.c
> index a581a1f6dc1..cb90bb2d09d 100644
> --- a/drivers/power/pmic/raa215300.c
> +++ b/drivers/power/pmic/raa215300.c
> @@ -16,7 +16,7 @@ static int raa215300_reg_count(struct udevice *dev)
>  	return RAA215300_REG_COUNT;
>  }
>  
> -static struct dm_pmic_ops raa215300_ops = {
> +static const struct dm_pmic_ops raa215300_ops = {
>  	.reg_count = raa215300_reg_count,
>  	.read = dm_i2c_read,
>  	.write = dm_i2c_write,
> diff --git a/drivers/power/pmic/rk8xx.c b/drivers/power/pmic/rk8xx.c
> index 95b71d2fe49..8c51d86bb0e 100644
> --- a/drivers/power/pmic/rk8xx.c
> +++ b/drivers/power/pmic/rk8xx.c
> @@ -47,7 +47,7 @@ static int rk8xx_sysreset_request(struct udevice *dev, enum sysreset_t type)
>  	return -EINPROGRESS;
>  }
>  
> -static struct sysreset_ops rk8xx_sysreset_ops = {
> +static const struct sysreset_ops rk8xx_sysreset_ops = {
>  	.request	= rk8xx_sysreset_request,
>  };
>  
> @@ -351,7 +351,7 @@ static int rk8xx_probe(struct udevice *dev)
>  	return 0;
>  }
>  
> -static struct dm_pmic_ops rk8xx_ops = {
> +static const struct dm_pmic_ops rk8xx_ops = {
>  	.reg_count = rk8xx_reg_count,
>  	.read = rk8xx_read,
>  	.write = rk8xx_write,
> diff --git a/drivers/power/pmic/rn5t567.c b/drivers/power/pmic/rn5t567.c
> index 0124d84a729..aba04a1b659 100644
> --- a/drivers/power/pmic/rn5t567.c
> +++ b/drivers/power/pmic/rn5t567.c
> @@ -44,7 +44,7 @@ static int rn5t567_read(struct udevice *dev, uint reg, uint8_t *buff, int len)
>  	return 0;
>  }
>  
> -static struct dm_pmic_ops rn5t567_ops = {
> +static const struct dm_pmic_ops rn5t567_ops = {
>  	.reg_count = rn5t567_reg_count,
>  	.read = rn5t567_read,
>  	.write = rn5t567_write,
> diff --git a/drivers/power/pmic/s2mps11.c b/drivers/power/pmic/s2mps11.c
> index 5cf9d34ffaf..8c19d2a1e53 100644
> --- a/drivers/power/pmic/s2mps11.c
> +++ b/drivers/power/pmic/s2mps11.c
> @@ -94,7 +94,7 @@ static int s2mps11_bind(struct udevice *dev)
>  	return 0;
>  }
>  
> -static struct dm_pmic_ops s2mps11_ops = {
> +static const struct dm_pmic_ops s2mps11_ops = {
>  	.reg_count = s2mps11_reg_count,
>  	.read = s2mps11_read,
>  	.write = s2mps11_write,
> diff --git a/drivers/power/pmic/s5m8767.c b/drivers/power/pmic/s5m8767.c
> index 799d0012540..7bdd9760a82 100644
> --- a/drivers/power/pmic/s5m8767.c
> +++ b/drivers/power/pmic/s5m8767.c
> @@ -72,7 +72,7 @@ static int s5m8767_bind(struct udevice *dev)
>  	return 0;
>  }
>  
> -static struct dm_pmic_ops s5m8767_ops = {
> +static const struct dm_pmic_ops s5m8767_ops = {
>  	.reg_count = s5m8767_reg_count,
>  	.read = s5m8767_read,
>  	.write = s5m8767_write,
> diff --git a/drivers/power/pmic/sandbox.c b/drivers/power/pmic/sandbox.c
> index ddc11d6df86..59385be47dc 100644
> --- a/drivers/power/pmic/sandbox.c
> +++ b/drivers/power/pmic/sandbox.c
> @@ -58,7 +58,7 @@ static int sandbox_pmic_bind(struct udevice *dev)
>  	return 0;
>  }
>  
> -static struct dm_pmic_ops sandbox_pmic_ops = {
> +static const struct dm_pmic_ops sandbox_pmic_ops = {
>  	.reg_count = sandbox_pmic_reg_count,
>  	.read = sandbox_pmic_read,
>  	.write = sandbox_pmic_write,
> diff --git a/drivers/power/pmic/stpmic1.c b/drivers/power/pmic/stpmic1.c
> index f0415fbd172..86d73e52c3b 100644
> --- a/drivers/power/pmic/stpmic1.c
> +++ b/drivers/power/pmic/stpmic1.c
> @@ -105,7 +105,7 @@ static int stpmic1_bind(struct udevice *dev)
>  	return 0;
>  }
>  
> -static struct dm_pmic_ops stpmic1_ops = {
> +static const struct dm_pmic_ops stpmic1_ops = {
>  	.reg_count = stpmic1_reg_count,
>  	.read = stpmic1_read,
>  	.write = stpmic1_write,
> @@ -258,7 +258,7 @@ static int stpmic1_sysreset_request(struct udevice *dev, enum sysreset_t type)
>  	return -EINPROGRESS;
>  }
>  
> -static struct sysreset_ops stpmic1_sysreset_ops = {
> +static const struct sysreset_ops stpmic1_sysreset_ops = {
>  	.request = stpmic1_sysreset_request,
>  };
>  
> diff --git a/drivers/power/pmic/tps65090.c b/drivers/power/pmic/tps65090.c
> index ad2ab34719e..ff9e854cf03 100644
> --- a/drivers/power/pmic/tps65090.c
> +++ b/drivers/power/pmic/tps65090.c
> @@ -70,7 +70,7 @@ static int tps65090_bind(struct udevice *dev)
>  	return 0;
>  }
>  
> -static struct dm_pmic_ops tps65090_ops = {
> +static const struct dm_pmic_ops tps65090_ops = {
>  	.reg_count = tps65090_reg_count,
>  	.read = tps65090_read,
>  	.write = tps65090_write,
> diff --git a/drivers/power/pmic/tps65219.c b/drivers/power/pmic/tps65219.c
> index 1fecde84795..35108509377 100644
> --- a/drivers/power/pmic/tps65219.c
> +++ b/drivers/power/pmic/tps65219.c
> @@ -68,7 +68,7 @@ static int tps65219_bind(struct udevice *dev)
>  	return dm_scan_fdt_dev(dev);
>  }
>  
> -static struct dm_pmic_ops tps65219_ops = {
> +static const struct dm_pmic_ops tps65219_ops = {
>  	.reg_count = tps65219_reg_count,
>  	.read = tps65219_read,
>  	.write = tps65219_write,
> diff --git a/drivers/power/pmic/tps65941.c b/drivers/power/pmic/tps65941.c
> index 57d470521fc..0b6c25ee7a1 100644
> --- a/drivers/power/pmic/tps65941.c
> +++ b/drivers/power/pmic/tps65941.c
> @@ -64,7 +64,7 @@ static int tps65941_bind(struct udevice *dev)
>  	return dm_scan_fdt_dev(dev);
>  }
>  
> -static struct dm_pmic_ops tps65941_ops = {
> +static const struct dm_pmic_ops tps65941_ops = {
>  	.read = tps65941_read,
>  	.write = tps65941_write,
>  };
> diff --git a/drivers/power/pmic/tps80031.c b/drivers/power/pmic/tps80031.c
> index 6004a14cd6c..318ebc5ca23 100644
> --- a/drivers/power/pmic/tps80031.c
> +++ b/drivers/power/pmic/tps80031.c
> @@ -73,7 +73,7 @@ static int tps80031_bind(struct udevice *dev)
>  	return 0;
>  }
>  
> -static struct dm_pmic_ops tps80031_ops = {
> +static const struct dm_pmic_ops tps80031_ops = {
>  	.read = tps80031_read,
>  	.write = tps80031_write,
>  };
Hi Marek

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
