Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028A2606A31D
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 14:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=yKiFTXoy;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=IkgSa5V0;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=ZvqO9NCz
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D4BB140B18;
	Fri, 30 Oct 2026 14:01:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KOvz3RQgTjaJ; Fri, 30 Oct 2026 14:01:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D3BF040B1A
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793368910;
	b=srm3yHdy74zFaKvDsjmmuVtpW0xrL6DI6Q6Q+4Ny5lynr9lSbhgu8eb2RqXxXT7hxlGQ
	 UWLPkWy5PhmEEVfB9uJv5d8J6pMavWfXTXWn6Dxe8lefgW4bB1YpB0+l1O96sudM5JUH3
	 U6MCnUB5OzyHvTFWaRtxwlN6UYD3grrZ7s20qx97l7lxZ7cc0IQ/zFwubOjEtToVAI+rf
	 QFLfMp1uo8fpdcSRMQ0xeCFp1Qi8M13hpkmU+9TYrCqoROqOP6yDEZXSvi3d6RdO8HLhu
	 F7L4XKomXNrxusXL+ZDhUFesTyf9rC1RdVeLvnpJPlMvTkVpcEW3M0I7PK0xpXmwBpg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793368910;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:DKIM-Signature:Received:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=L7qDbJlkK3qQkzrnyUQ1wcl8RtM2SM8P/UokQ+geMQw=;
	b=rnlyLpiiXBoaBpar0Ks/AlIPmtsuttFmQyxmq0AMnYV2vr238HoHr2BiC4wXNyhrP1mw
	 JNXMKW5G8t2jnacdb2/JzRxe8tsF7863cPCGx7Vx/RJNnc7grkX85a+E3SgIqhhEBvXmH
	 IbNnLRz6k6KWhupUwbPRRLmZ+kTpLBs/+OEb7AgcxHBKRk+RvW+wAFEXlsRZU0hGLv+XS
	 SVh+4RikIt96BBCJZ10C6mT8mzaYVoR1oTDa6If5rQ8dN0vIst6bbm0kITwY1FZ1skN5L
	 NsIKIhbYxr5WDt+djgAZ4MbdAh6UBptZA5kffoz8xPj7es4PhtvCMf2V/X3HbnEI4sw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793368910;
	bh=L7qDbJlkK3qQkzrnyUQ1wcl8RtM2SM8P/UokQ+geMQw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yKiFTXoyecv80bw0lwFL7HMN/B9UOMoXZMVX7P2QyeL+IFOlRRU3tME0CGCtvWDo4
	 rpMdPd5TMtwoYhNEV6KITmMT+3ZAVkOS8DwynrXwHjiLzdOsQS/SvuXCaR1VlMuVTp
	 u8J0EtqIusGRqDU+Q+Flg7spzIHz3ewz14goeFfCTNk94r1ZD7blR1sEcDDi1SnoOk
	 zQYmc2LTt2feGsY+LhkRmU/y4T943ovi2jIuHsOVFc9JjnJOCRvUvREDoRLs8yAxmS
	 3tq1VrQ9t5uXBj7xcDP3NuRejZUj7fdeVMp6NseUE1axcCnTueA3gzH9VIMGJj6H7H
	 0ITLR2R48C79g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D3BF040B1A;
	Fri, 30 Oct 2026 14:01:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0FBE0712
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 14:01:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E8FEA40243
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 14:01:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wAAB1g4df31E for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 14:01:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org B7C0F400D5
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.139.77
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793368900;
 b=rOhutRc8/bhYhYku30mM7IK4kTvzhAih74wIHFof8nNK8mVQMvgavidY4BUJwYAMzdK8
 GmEHyKBUvXQQAe+DCznM4Myj2h/KkR1gulxfzYbtFcrVAMwFBfeoaQU5KGY3++i1MTOTO
 wPGp+SQ/CXnFmFoQcH/0B0hBKfGZyNZvR4uzV+L2jTSJs03218y1tZzHyMx81GsCOeXUV
 qjrZHyiBtWuTyDB32aGcUIjCkdnJD9ay9f2kWT7Fv45O33Kvxz612kXwgs4VD7xYRT7nS
 vCbGEZamdZKbpPvIG4SP5CL3Mfj0Aw0GInvWN/oOXGYOKahJHGT7TMlQh1ug5N9FADg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793368900;
 h=Received-SPF:Received:DKIM-Signature:DKIM-Signature:Received:
 Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:Content-Transfer-Encoding:Content-Type:
 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
 X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
 X-OriginatorOrg:X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=L7qDbJlkK3qQkzrnyUQ1wcl8RtM2SM8P/UokQ+geMQw=;
 b=Xb06abBA79Bs04Gvf134lwD5myEi0gkUo8qRrt6eJ68tgXGYNua6p9slm1NaBBU/MjvH
 1Q0lT/XZdlSO2KdKF9vpXA8R4fgpjj81iqTOFD+8wo1+jAu6SHwaU9AEd8mrtIa5JIgJ4
 I/x+3SEAijzTr5ZOMPUjjrRWt4foLtXgV1Ce1j4UFI0TCGO2f9Dwop/P3CE/dZ44PtQL0
 9hhz5yw1a2IwhNFZCmZ4VW4xwzRGyNNMn5/IMI9zTf6F/dZeKbGJ649NQ5PbbJIY4ykxD
 OpcRunzCMKq+f4sVyWCPseYr+fHtOWcTU+aXCCcWntfVUeYT1z2yJdlHFxKZfxZ1QcA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=analog.com;
 dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256
 header.s=DKIM header.b=IkgSa5V0; 
 dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256
 header.s=DKIM header.b=ZvqO9NCz; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.139.77;
 helo=mx0b-00128a01.pphosted.com; envelope-from=caleb.ethridge@analog.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=analog.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com
 header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=IkgSa5V0; 
 dkim=pass (2048-bit key,
 unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256
 header.s=DKIM header.b=ZvqO9NCz
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com
 [148.163.139.77])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B7C0F400D5
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 14:01:39 +0000 (UTC)
Received: from pps.filterd (m0516786.ppops.net [127.0.0.1])
 by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UBGmeU3932094; Fri, 30 Oct 2026 10:01:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
 h=cc:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 DKIM; bh=L7qDbJlkK3qQkzrnyUQ1wcl8RtM2SM8P/UokQ+geMQw=; b=IkgSa5V
 0ecMTN1tEM2hx2+huhHisWUDzB6LhcdZUex5TxtPUam9d0adW/Wy1WYRZdBriHhj
 VIvU5Y4AtbqV0Z9w9Fg8sz6SppAi7dvXpTtczabr0b22ElrWMogEjPeRYiE4+zEH
 yqU1f8bBFhQqVS3f1jx4KBpza6MX+jt/KgNUD2YPf8yaKBgK5QsDwAOIEdA4d7Rj
 UtR8aVBoAw2MOgCOSWh4QsGPqrTwNXaD69fsNivKXv8NM/SpL8XI5/rvS1DyQoP+
 vNuzxaNvnehuxCaEQTvAiW3rXGeasSwe5DLhJ1z/ecsbK8Cv6f7qiyQVd68CnAAV
 E+6UC4pKwygksWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=DKIM; bh=L7qDb
 JlkK3qQkzrnyUQ1wcl8RtM2SM8P/UokQ+geMQw=; b=ZvqO9NCz7TFK3GC6QCA6Z
 qBec7tgE6bWwoH9TBBb3zYxBet4NwXsxnF+JTnrAC5qzK6BPs/a24wEyVN6UldkW
 GmZacw6tnTcwAvX1LrOPip2Uyq+5DsSTaFO3kYCEHQdlEhYec0GBRm+Gf/Jnvhpu
 DKCvOz4hEjZJexmAbKej9ydLUZMrusRqM32qNu2ZISxbSlMQAD23sGM8TZo/68xy
 UaBipT4piGXFLe3Z9FWOXDr2JdvvtRuoHdO0/clCcRYZslTMEoXkr4eCUiYOH2OI
 bPwGiXJpbvr0FAS4ChIFB3T5TJ7pRTbjgnCKzrB4247j/q1fSHxlX0MqCGa64XMA
 w==
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11012017.outbound.protection.outlook.com
 [40.93.195.17])
 by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4hme7b4c22-2
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 30 Oct 2026 10:01:34 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hcOL5wFLM9ykIsnOLoSOpWE2PPJ7nvWZrlxyfwNvWKj5lPfkTc561l049otJdUXcZ/oMk1grWuG5EuUZddd8xIBbmUfOKGu2FrdDSuSshqN87EqEvy4e/Uqjb+OwrR6GmotagcSvoP4WKfbEr9+Gei7gQ7ml7Jlqz/TWxH4d6OkiQFhYfqQQ0o+OzrfoGVhNCgDN4ZVrUkOOiwpZNCrsEK431Vpr0l5JAOfbloLHuqhQ3VjORY9q9eC1EbPB1yDg4kMifxE9bGRCcCrUlbxgFFsmxsCluAuJ7EOuF0/8xC/xhnQO++O5CWfky1KFZb9Odx9rLVZN+/W24QtnGZUr+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L7qDbJlkK3qQkzrnyUQ1wcl8RtM2SM8P/UokQ+geMQw=;
 b=dPkjQeWbuEu2fNH+AxoBZkZRZVKJ1Mdr2O+9Hjq7ASUam4gr+VwEDhInX19wpv9GK3jvjOCGO817TlV69oOBymss8A2pPYx57lV22UVwpHglL3IRzNX5jMufEHXOI7K8r67PpQh63ZygbfQg8ubR7Kd3kRCk+CfL9/y2aWFj2OtRKgAvGwYhsNVScltl0D7UGnHX2rKCtBLAQeelUlMeRHbHbNlP9IvnMsuzxSfIGulH+B7RuuMIPz3G12C2PXE1bdT94kcOs+gZFvb5hytgda8UtbJb+vHx05EmVxTnKRGOI/FNF5CTJOwH7Rtjvh7RQ2EcZqdO5WzonsQAHqg/wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from LV2PR03MB989102.namprd03.prod.outlook.com
 (2603:10b6:408:37c::8) by PH8PR03MB989600.namprd03.prod.outlook.com
 (2603:10b6:510:408::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 14:01:32 +0000
Received: from LV2PR03MB989102.namprd03.prod.outlook.com
 ([fe80::1d72:5cc4:f10a:1e3e]) by LV2PR03MB989102.namprd03.prod.outlook.com
 ([fe80::1d72:5cc4:f10a:1e3e%6]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 14:01:32 +0000
From: Caleb Ethridge <Caleb.Ethridge@analog.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, malysagreg@gmail.com, linux@analog.com,
 philip@philipmolloy.com, Caleb Ethridge <caleb.ethridge@analog.com>
Subject: [PATCH 1/3] board: adi: Build SOMCRR common code only with a carrier
 board
Date: Fri, 30 Oct 2026 10:01:20 -0400
Message-ID: <f19d60a3c7783cf5df55cedea826d0f3633684d7.1793368074.git.caleb.ethridge@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793368074.git.caleb.ethridge@analog.com>
References: <cover.1793368074.git.caleb.ethridge@analog.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0190.namprd03.prod.outlook.com
 (2603:10b6:610:e4::15) To LV2PR03MB989102.namprd03.prod.outlook.com
 (2603:10b6:408:37c::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR03MB989102:EE_|PH8PR03MB989600:EE_
X-MS-Office365-Filtering-Correlation-Id: c2d61458-3378-4f8a-60d3-08df368e4d73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|18002099003|22082099003|56012099006|11063799006|10067099003|261021123027099003|261021121427099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: BTmZozQUCGtahKGehP7xbuvbSUy0eoI3zKsmqMq9ryYu1FnmfwwputP0bjpYVeOstzQ8q/KR8rMcV17OENaTYRuEhU+qmcs09auVxXyKkUbEV9iYqITIl3fRvz2wsSSOZQjQTu0/BX20gmGqMfvpJ+ykFEYE0bl0c2TEVSejuWmtGvW4XL7ocLvWdb+DmoDY+x4L38qEkd4PscNIDlK1XtxEkCL9sVNctjoYl3CE+0GAPpHtgZPtq6x96o6lORlFg/AzQ2xK2wCs2XNkDzgFzN1wfgBuomRuE8jvjpgSic2y7JNeQqaUtv6vLzznseXDpfGTZADVcrWsgDkQKVVwgBeEawwOh+OW8c+V+EmE4dQaksDCDevZwcBbT/QQLvZUdgbme8+NmurCSB6L8GjYMzUokKcoeI0n9rI2cPRHdJWLl9eZfLVwwdTJH5a1l5Op/aHmaohgcGUmrOCNzM7Rb0DqQyqs7Qy+PMCqrjZcsY2VcrpulmenUOYwYOCVgWNEJKdsCHhfWjmmFnFf5Z4+Wiqbquu70PCYScO821bTxlJv573vgMNoUug3zE0hC88//nzFRIqhRv0IPXhYIYBqJOnDY71lNsGFPK+biG3L6ZBKpPoPmCsWu1s6x2II4ICFONRskv4/6YlXqB649ylAL8TtG8C0VoDJ2QLfNC0SyTQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR03MB989102.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003)(261021123027099003)(261021121427099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DXENKHgZhonj16stxkwCuXoYKfnXyPq7ww3gMKfkxEsJH9keCHq3aYcDMp/d?=
 =?us-ascii?Q?ipbUGD52o24/A/uqokB0CwTv0Tq5TRNjoqL2TQbOU6Xk1TWh5JTzghwwaoqM?=
 =?us-ascii?Q?01Yzl86hYIpT2ye/EyLMzxQS7bq19klFKvYYK5vn+e03nmL95d9yd43fuDxa?=
 =?us-ascii?Q?oMavien0cl/LqnprsUA87zSGZAe+XvM69c0MEHjTR0lYdMrDaSOw31UYATiZ?=
 =?us-ascii?Q?fADI5GGOOAwZXHKYc5euJQfdU0AHMbp+OQQ/yeUYOAmc390DYpMu3+bqOcJn?=
 =?us-ascii?Q?FYH3RgfMWiAI55Z+GI/zHibhuUtMWar4BRLdq+3jR8KqQdull8inZwhrOpol?=
 =?us-ascii?Q?S5VYFogU48Z1OcHXA44jbGzz8RaUF2VE7lBmKCB3GISwNPsyRykvtS2tMgc/?=
 =?us-ascii?Q?MSyO/4wCm7XyDgIear/AsIShoFFboZAJyeMnWfjS09XTJRV9Lr9PtMDBd597?=
 =?us-ascii?Q?wvsbH6v1WQHTLNgpYUMBFPhW0ySWsihkwjHW4kv2CEaN7HwbnujI60yfwnFz?=
 =?us-ascii?Q?ZO0VwJootTrGt1blMwmrDNyQXQ4Qz00DNWTklWhIvPGVszlZfY0lF/zn0S1l?=
 =?us-ascii?Q?PXDP7X7GLwCxyVqQXFdJPP3EelfB12Mlwsm/RpA57R8njfVGha4meSf0xaDt?=
 =?us-ascii?Q?tsp5pG2ct42VRRs+fVPfrHeQlqPcHzETSpVuA7DPaH3+0dPyjasSXK3xnRJF?=
 =?us-ascii?Q?5JgqerO7sv8D/r21r80+SubzbjKJwgRc56l++7ZzKJ6mLXesapajGLT+Ej5o?=
 =?us-ascii?Q?ICm3NLHOcBZLS3ipasDjWcYqfyuewIxjrwMQg6ex8GY7xwR9P/tlwSolWf8R?=
 =?us-ascii?Q?yljsVKbouqBL56aGwZ8IX5LXHPOqC4ChMSu+WrFEsDJAAFM7UMUdp8J5c70U?=
 =?us-ascii?Q?CUCtVX9z9WyzU/CqypAxL9x2c5sAjye4Zf+u5a235yUiAAMGq8pbb+Hht1GA?=
 =?us-ascii?Q?fssRidQrEvmkABrEBMjl4jcC7+HXa3ncDYbLqtqhrCJCWGyWVWWLIkhmPey6?=
 =?us-ascii?Q?Jb5XgqWk3DjK6qn9VRdkpFPMpn+H7jX/m8YwfpUetVkXZgDmNv+1twjP+TXK?=
 =?us-ascii?Q?N5cbsCKJrj6wnlL2r8+OlIgY1zqHdLtS74cWMJHNM5MmHaVjRVROhf7hXYx/?=
 =?us-ascii?Q?ddtKJ2Cf1gVsNSMMlu1fGMH2DrfBPllH1n9BcD2x3dSe/Oek3YfZTsJMiscS?=
 =?us-ascii?Q?09QgZ6SRa/uxWdVNyNWzIjcpnttq4h0lEal0Vp6XOFAwbVicTYrUEh77cOgu?=
 =?us-ascii?Q?dXHWNMrRIiWGJHVv6hUlcmnpFPysVcCUhSU4wSx57hSPLJnAvDSm6A6rBeLF?=
 =?us-ascii?Q?x0Hz3pHn0WieT91SCQV0F2rNMtca7QXY1BxQSREEFqO66VQpfheLPxuORmJe?=
 =?us-ascii?Q?zs3vbgd5DNis85Dy44gsWrHWRbaE1i+O0Vd/udJP6ZGkRSr9BRRFLbndOaYp?=
 =?us-ascii?Q?PDODLe4OJf+6Jl2UN6LPDQVdpGaxdf1Q66QJcA1KrI+KX5zqRKaLuqYCbnPl?=
 =?us-ascii?Q?cSjeJnCW8lNfuvzPZQvAYWjtTqlAKKontdti3sKybaz+UUwCtEhJArzDlBMP?=
 =?us-ascii?Q?fSBgGYBrtc4lq3x5HJVoclxQw8ahmzc4q8xZqqJiydJ0zLepZC8zGZpwHW2A?=
 =?us-ascii?Q?8ZrpsHwa57j5a0+tyVJxk/yvKfZWjW3YKCW4RBd2Jp4jAglzm4WvaKbR+5kD?=
 =?us-ascii?Q?xIcxXKd4GvMZJiS1wv9g1M2aglg4oEed3zefn2CJOKWKpsgReiHG6AFo2npy?=
 =?us-ascii?Q?oIje+yUEbtMdtvRFq+f4TG8iajuKCzA=3D?=
X-Exchange-RoutingPolicyChecked: jGC/WkcemcHU3z6dMqg/A/o50A87Ww6qmutb+Md70QogfHII158ZNd15z8m4btCMcFlukCPuyWlyQ4ao2mj0yVDVxhbUfe2qk9HCF2idaosYO0EDVsZbz++kTwZSjPVLo9X8yAeq8gyexBmGwLfP/lHpGRMrydJlOkQo37MietDdd6omsToDaYXr3x1CJxD742syTzjRqElQQeLThsM0taejb/U5ehEHbikjzg5nmj/rq3t7b2irLOT7iT9C9TT/V4/qFC7t4LjFIHSVA6B/1TVOhRNYy1yteNB/SH9u3kPhXrD/vBF3hGpdPEkhjkaXaS1Je3DzhGBd3rd9QiZU9w==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2d61458-3378-4f8a-60d3-08df368e4d73
X-MS-Exchange-CrossTenant-AuthSource: LV2PR03MB989102.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 14:01:32.3102 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ppkwgbFLLcGr0TfC/M6S86h00Px3uj/H9PCfMb5GQvC4jgHJIdAClTF/QmHsqS4OyRTTAdD8rMfiHGSjAJrE+RkqnSibu9SFH1q+pyp2Zxo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR03MB989600
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA1NSBTYWx0ZWRfX1WLseYxXeBd/
 aVrJ3WM0vFWS9HcMfrCk2G5eQoEGMurclDcJ6PInTJYbmJpap4IC+NM/RYKQvirxmtSC0ldxOq+
 B6xpGnr5vUsEevU6lGt3Maidl2EVav/m+38JaxXN1Fmn5dbSYuHDKgc/XhU5yU5RJzFdQhofqoY
 Cpz52lPxXZ5vrcy1QCBKaskYmIMPYwO+bWWngioqvmjoeDputGJEU+7bSWUTUfkanMxQKUtDu1i
 P/bk+tvUC+rh9LLJ3P01kegzbzxs+V9jMOWTeZTS0IL+lSqo2VeiKpEW4dJf49wNx1C4tn7M8HH
 bvCoQ4ATSoq/fcN/FXtFn1XCb+id957vdc7kQeWeFmP026pCqyU8zuO2QBP7FnrTT+xRWS2k65h
 5eYni8CVW2DxJSHf73osz/abHOZ35aJbYJocgVpmqSUDkwlCHxMOyHQvCrBP7J53rPxmtLhzWT3
 KA5KV25oJGYjbwDL4Qw==
X-Authority-Analysis: v=2.4 cv=Od8NnRTY c=1 sm=1 tr=0 ts=6ae4a33e cx=c_pps
 a=mbkJAKHg+hX/fqCzz7NXWQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=ZQxX5BWu6Z8IJBb2zLX7:22 a=gAnH3GRIAAAA:8
 a=jRhWvuqUhlpXz22-T0UA:9
X-Proofpoint-ORIG-GUID: sHqSylZNGswelR1d3FtlPVJrzPLSCBSV
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA1NSBTYWx0ZWRfX93kdRDA4suOX
 CKp/dNlLLCAQ7BJmYR+QLmqKBjWUzXRjVnt5eYxmS8JScezytKj4FDrXIGB7mQMU8BY7xAY34VX
 ABgqNFk+y3Nyo6tEQIOWLHIHbYTFJtLh2BMTmHbq+DW36AOjrLQF
X-Proofpoint-GUID: sHqSylZNGswelR1d3FtlPVJrzPLSCBSV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 spamscore=0 impostorscore=0 adultscore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300055
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

From: Caleb Ethridge <caleb.ethridge@analog.com>

somcrr_common.c calls adi_somcrr_enable_ethernet() and
adi_somcrr_disable_ethernet(), which are only provided by the
carrier-specific files. It is built unconditionally, so a SOM built
without a carrier board would be left with undefined references.

Add an ADI_CARRIER_SOMCRR_COMMON symbol, selected by each carrier
board option, and only build somcrr_common.o when it is enabled.

Signed-off-by: Caleb Ethridge <caleb.ethridge@analog.com>
---
 arch/arm/mach-sc5xx/Kconfig            | 8 ++++++++
 board/adi/carriers/Makefile            | 2 +-
 board/adi/common-sc594-som/sc594-som.c | 4 +---
 board/adi/common-sc598-som/sc598-som.c | 4 +---
 4 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-sc5xx/Kconfig b/arch/arm/mach-sc5xx/Kconfig
index 0f4e63a355e..cf154c221eb 100644
--- a/arch/arm/mach-sc5xx/Kconfig
+++ b/arch/arm/mach-sc5xx/Kconfig
@@ -210,6 +210,12 @@ config ADI_BUG_EZKHW21
 	  This workaround affects the SC584 EZKIT and addresses bug EZKHW21.
 	  It disables gigabit ethernet mode and limits the board to 100 Mbps
 
+config ADI_CARRIER_SOMCRR_COMMON
+	bool
+	help
+	  Common code shared by the EV-SOMCRR carrier board support.
+	  Selected by the carrier board options.
+
 choice
 	prompt "Analog Devices SOM Carrier Board Variant"
 	depends on (SC59X || SC59X_64)
@@ -220,12 +226,14 @@ choice
 
 config ADI_CARRIER_SOMCRR_EZKIT
 	bool "Support the EV-SOMCRR-EZKIT"
+	select ADI_CARRIER_SOMCRR_COMMON
 	help
 	  Say y to include support for the EV-SOMCRR-EZKIT carrier board,
 	  which is compatible with the SC594 and SC598 SOMs.
 
 config ADI_CARRIER_SOMCRR_EZLITE
 	bool "Support the EV-SOMCRR-EZLITE"
+	select ADI_CARRIER_SOMCRR_COMMON
 	help
 	  Say y to include support for the EV-SOMCRR-EZLITE carrier board,
 	  which is compatible with the SC594 and SC598 SOMs.
diff --git a/board/adi/carriers/Makefile b/board/adi/carriers/Makefile
index cefd2cc837f..ccb44e262fe 100644
--- a/board/adi/carriers/Makefile
+++ b/board/adi/carriers/Makefile
@@ -3,6 +3,6 @@
 # (C) Copyright 2024 - Analog Devices, Inc.
 #
 
-obj-y += somcrr_common.o
+obj-$(CONFIG_ADI_CARRIER_SOMCRR_COMMON) += somcrr_common.o
 obj-$(CONFIG_ADI_CARRIER_SOMCRR_EZKIT) += somcrr_ezkit.o
 obj-$(CONFIG_ADI_CARRIER_SOMCRR_EZLITE) += somcrr_ezlite.o
diff --git a/board/adi/common-sc594-som/sc594-som.c b/board/adi/common-sc594-som/sc594-som.c
index 37817c4b062..136548b4f35 100644
--- a/board/adi/common-sc594-som/sc594-som.c
+++ b/board/adi/common-sc594-som/sc594-som.c
@@ -23,10 +23,8 @@ int board_init(void)
 {
 	sc59x_remap_ospi();
 
-	if (IS_ENABLED(CONFIG_ADI_CARRIER_SOMCRR_EZKIT) ||
-	    IS_ENABLED(CONFIG_ADI_CARRIER_SOMCRR_EZLITE)) {
+	if (IS_ENABLED(CONFIG_ADI_CARRIER_SOMCRR_COMMON))
 		adi_somcrr_init_ethernet();
-	}
 
 	sc5xx_enable_rgmii();
 
diff --git a/board/adi/common-sc598-som/sc598-som.c b/board/adi/common-sc598-som/sc598-som.c
index 0e1ee828956..51c96fd69c8 100644
--- a/board/adi/common-sc598-som/sc598-som.c
+++ b/board/adi/common-sc598-som/sc598-som.c
@@ -23,10 +23,8 @@ int board_init(void)
 {
 	sc59x_remap_ospi();
 
-	if (IS_ENABLED(CONFIG_ADI_CARRIER_SOMCRR_EZKIT) ||
-	    IS_ENABLED(CONFIG_ADI_CARRIER_SOMCRR_EZLITE)) {
+	if (IS_ENABLED(CONFIG_ADI_CARRIER_SOMCRR_COMMON))
 		adi_somcrr_init_ethernet();
-	}
 
 	sc5xx_enable_rgmii();
 
-- 
2.43.0

