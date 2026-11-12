Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF3F606A885
	for <u-boot@archiver.kernel.org>; Thu, 12 Nov 2026 07:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=XO0iWkSK;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=ZfaD6Aa3
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A577C608E7;
	Thu, 12 Nov 2026 07:57:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FsezZJAAExxD; Thu, 12 Nov 2026 07:57:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E6482608A9
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794470221;
	b=Y2kJ3FHYK05u9L6IrGRq/4IATE4cK0szsQx78vv3jvCF97i32x0W/hzsmqYhUlYJFGQJ
	 6sktLMIc9r7YCRFtKDkE+NtVAdSRCq+XnxioNSB6zxmePdBhyGfhd2RRt6wv5IUVYOwHu
	 FFkYHx9ZoGdbNGrWzshwFqm1szDrhduqvKfg8bpbisBFYm3Oz0VqtnGKF+elIEr8RhHOR
	 WHS7PIw6K1gbbpl0t1/IdEfLFLVUy7aMopA12x0WFINFza1jRHn5mK4w/JluCuQyWoHNH
	 mtXCXV80ECFmvlKyi9MfSRQ7QPyHUpg1qmqyS94218Gg5ifCIS4T24MriHeziHHMQ4g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794470221;
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
	bh=kmfJIcTNc7RibR03LPzp4mHCxn8qonvL3tYOHYPeQSQ=;
	b=cq7S3nbEr2eTYIUUxj88AjCPK7x3UffUAHxLx908b+HEwJLxFYfxCyLK1pi9hqtonO2x
	 TT2qORRO8I38FpYCPRoAHec7ibgLkoIdFHKFy7RKv4bPbK52O7hPJTdCQVhSmBcT+yzrY
	 iW/+SPmmcEcozedrcMSUb5a2v+f6IfyGcWBQdrzonPhofctUQG9fZ9Go8HqgRORrQE7MN
	 0YftYd9fM1YQe/B6RK/Q0fe8nZIYxS040/D/hNAQRVs10YNSroKmsbjc5BpHiKviG76ZE
	 QcvNVqJDsNuBoAp790x2g3/jyArQ1J4KpUJ0tYcWzKaNL9vTxhX0VYc6Ee8iAAXE/1w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=ZfaD6Aa3;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794470221;
	bh=kmfJIcTNc7RibR03LPzp4mHCxn8qonvL3tYOHYPeQSQ=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XO0iWkSKV5byKUJvmIW6qrGXAANL9lIVEwaxSGY6IcLX8pGSCOtTZ63QQ0Yn4/dlv
	 ApeH5gMdAlIm5v3vMSbyR3RdxcN9XqC8QKpXAXYkKenO0ob8Dzz5w/8YCx374jso5R
	 i6qpbwzBgLGgdlU4dez/dewNyOXPxFNO//bVtTM/GfQYrmrq6C2HqPPXuOR+jiGqbf
	 EQq0uxJh/b+Qb0h10vzDrudJlD9jOZ2gPwIvu7+4W2U8gwCux5lybXpW3Nl5EuyGv3
	 xRhJeWDSVrZWs7SHkUdGJsZ8b8yT44WKohcmn8CibbefA9wvHKb2I4TtSkQsD9fubH
	 4xz4PGTuiAtww==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E6482608A9;
	Thu, 12 Nov 2026 07:57:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 97B8AE09
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 07:56:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7DDBB608A9
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 07:56:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k1PjxkTnYuhR for <u-boot@lists.u-boot-project.org>;
 Thu, 12 Nov 2026 07:56:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4636A60887
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c207::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=patrice.chotard@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=ZfaD6Aa3
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4636A60887
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 07:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kmfJIcTNc7RibR03LPzp4mHCxn8qonvL3tYOHYPeQSQ=;
 b=ZfaD6Aa3RZ4RHerIFcob6UOaNDeaCGS5v1wZiPujIYveOS7I34VC3s4fQJkkzoPH8WwiUyDF3oUXKNecmF1oPlKyQ3g6kEB7ZVPLtN/1NICFMt7hDfSn+FVwOVFwFfie3P4FiWhpnWyD1u19/hN/+1LbvBL2wGtFssFYdN1NNdegt+id99nkc+4auyeQMGbz/hqXIIKeW/VZLL4L7lNE77CaeYNt14sBSzT40bBK48+G9uoKw1RJs9DfFfTqXiTD8WEL+U5nVA6bvVKOph0H8ifB/+dm/6t3V0eDWkQ+fRkMnvLQI20ZfDBO0+fgKgo5nxmBDcGUuS3wkN5P77JXqQ==
Received: from AS9PR04CA0038.eurprd04.prod.outlook.com (2603:10a6:20b:46a::20)
 by AS4PR10MB5498.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4fc::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.4; Thu, 12 Nov
 2026 07:56:50 +0000
Received: from AM2PEPF00070CF4.eurprd02.prod.outlook.com
 (2603:10a6:20b:46a:cafe::5) by AS9PR04CA0038.outlook.office365.com
 (2603:10a6:20b:46a::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Thu, 12
 Nov 2026 07:56:50 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AM2PEPF00070CF4.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 12 Nov 2026 07:56:50 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 12 Nov
 2026 08:56:48 +0100
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 12 Nov
 2026 08:56:06 +0100
Message-ID: <e1f51778-02c9-4704-8444-b11bfaafeb76@foss.st.com>
Date: Thu, 12 Nov 2026 08:56:05 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] mmc: export mmc_set_capacity()
To: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>,
 <u-boot@lists.u-boot-project.org>
CC: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, "Tom
 Rini" <trini@konsulko.com>, Markus Niebel <Markus.Niebel@ew.tq-group.com>, 
 =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>, Torsten Rupp
 <torsten.rupp@8tronix.de>, Eric Chung <eric.chung@riscstar.com>, "Patrick
 Delaunay" <patrick.delaunay@foss.st.com>
References: <20261105-upstream_partconf_fixes-v1-0-6abda284aacf@foss.st.com>
 <20261105-upstream_partconf_fixes-v1-2-6abda284aacf@foss.st.com>
 <825179ce-4c25-41ee-bebf-db90bba27a5f@altera.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <825179ce-4c25-41ee-bebf-db90bba27a5f@altera.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF00070CF4:EE_|AS4PR10MB5498:EE_
X-MS-Office365-Filtering-Correlation-Id: f7f550df-a788-477a-877a-08df40928211
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|1800799024|376014|82310400026|261021121427099003|261009223027099003|261026121527099003|11063799006|56012099006|261021123027099003|261102130727099003|261102123227099003|261022075727099003|4143699003|10067099003|18002099003|6133799003|22082099003;
X-Microsoft-Antispam-Message-Info: hUZLBlSJhm736D3WWCYl//CnjXJYznXfHzBTShHVxJofcJ6krcPi1aokd19zPr/+mUMLJ+GH+pXkTWVfRV3D5lxh/pIqeBPIZDeuLpajTdzdR2rkl2BCjreSKirktj0YzIzdybac4alJyxTcMmNN4AFW86Hu3PHPfPDRo9HwhYLozXG/TltJ6xGHWEOp1+WJU8QuHDRI1hfzif3gZxJl0N70GPP+Ql0dwd3lDG3YuEnmtD0fU+miv9+nATuipbAOTN/WqWKsKq+k3r0kyt4aasfS4cXpWxJ1uhnx6K46OC37FhfvFjmm3OcnUjJamDbryuq3Qn4mTLB/UW52nCr0chUSuw8PwOPpJ0KByTmoU4ZJ9WdmVh28vL0k+dBZhY4VTFIihtsYdrM8i5nBwtsTdMEEYvRzyZS/jGkA7LP5k+K0puXEDveAhCZeefJio9gPajkx/T76QCW4vC+qNI8XDw9EoouDEVaeuaS+qGx3Necxj57umQxZHRAWXWhZjFjsNSHJNU1tELbK6GoilvW9nbw+xbJ8zcvZcR72AvhB/6RwfWBwh7OfsQCWbH8x75KOBJHzJ5CByvmMFtLdslE3ZHhLkNHOmZbX9HrGW1NkiXGQ1G+nM++vwXLOhCWympw7o2OdAFSYLMSqQeZTxzZmMwrhL6AUBa3N3zZsaVNmQ5sRaHBw3mNKUoTRNG0OWCzMQglpDm0oKzVw6XzVYqQmOg==
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(1800799024)(376014)(82310400026)(261021121427099003)(261009223027099003)(261026121527099003)(11063799006)(56012099006)(261021123027099003)(261102130727099003)(261102123227099003)(261022075727099003)(4143699003)(10067099003)(18002099003)(6133799003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bwykKuqxKwjH96zQaizlcUUMKND8Pb2ozukNyBlyoJ7E6Rwj1jE455BsjC6GFses/bj2eOUtwl08BvxkVymGJGJ3Oj6RUlT+f6eztvAqfDoNeeEqsgBy5GJrpVQT35RFFaJKU9UTWm0ORloHM3sirYqjwIuwUlqwsH1XdJJI3YZso6ZYDEJ2T/wDM89auB78Xtjoyva5bYCZfa45vr+3BglZmMT8zKmNYTiUNXajR6PFOWWCCkED6AiFIrhJdN3oEqPBmUQ4JXo4/g+LryLKwfrHzE8Hqz8m/1bsV3N4z8vDH4krf78T1vdRrUpXde6GMdrqaQJnaVA4jb2Ptn0L6vT8VB21cNLwkC86RITnekOPFbp2gbnYnBKIb7xwuqdzLTqbxntFEs0/CSZnZEmMERVCNF9DPEp2lZ/wdY+kIEP226m6Ai84TXvUhLadtzcU
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 07:56:50.0714 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7f550df-a788-477a-877a-08df40928211
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AM2PEPF00070CF4.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5498
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/9/26 13:18, Kathpalia, Tanmay wrote:
> 
> On 05-11-2026 14:33, Patrice Chotard wrote:
>> From: Patrick Delaunay <patrick.delaunay@foss.st.com>
>>
>> Export the function mmc_set_capacity to be used after change of
>> hardware partition manually requested by 'mmc partconf'.
>>
>> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> ---
>>   drivers/mmc/mmc.c         | 2 +-
>>   drivers/mmc/mmc_private.h | 9 +++++++++
>>   2 files changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
>> index 4835ce0c64b..f9110c365fb 100644
>> --- a/drivers/mmc/mmc.c
>> +++ b/drivers/mmc/mmc.c
>> @@ -1096,7 +1096,7 @@ static int mmc_get_capabilities(struct mmc *mmc)
>>   }
>>   #endif
>>   -static int mmc_set_capacity(struct mmc *mmc, int part_num)
>> +int mmc_set_capacity(struct mmc *mmc, int part_num)
>>   {
>>       switch (part_num) {
>>       case 0:
>> diff --git a/drivers/mmc/mmc_private.h b/drivers/mmc/mmc_private.h
>> index 24e68ceb5e6..a0d4dab9af9 100644
>> --- a/drivers/mmc/mmc_private.h
>> +++ b/drivers/mmc/mmc_private.h
>> @@ -116,6 +116,15 @@ void mmc_list_init(void);
>>    */
>>   void mmc_list_add(struct mmc *mmc);
>>   +/**
>> + * mmc_set_capacity() - Update capacity for a new MMC hardware partition
>> + *
>> + * @mmc:    MMC device
>> + * @part_num:    Hardware partition number
>> + * @return 0 if OK, -ve on error
> 
> The neighbouring entries in the same header use Return:, refer
> mmc_switch. The @return line is rendered as part of the @part_num
> description and no Return section is produced.

Hi Tanmay

Will be fixed

Thanks
Patrice

> 
>> + */
>> +int mmc_set_capacity(struct mmc *mmc, int part_num);
>> +
>>   /**
>>    * mmc_switch_part() - Switch to a new MMC hardware partition
>>    *
>>

