Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6D9606A329
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 07:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=QKSXDE9F;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=osAAzP4M
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 69BA760705;
	Tue,  3 Nov 2026 07:01:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ewdd9IJHSoOQ; Tue,  3 Nov 2026 07:01:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B60606060A
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793689274;
	b=phTU+ix71ug7H25qI3dBBkWBT0BLlkY51yNniIT5tJap0OwAyo5aEzeOFY/imqnKxgaX
	 GMeGpUXMbDPCQqE7OWAc+gLyo5AzSncklH25ch88JJnslTNRvL26ZKfyy5p1mK1fjAyLy
	 UghEAeAUU0QPyQYBusEQa6IZ2fPsumoz++TMJr12lbGlY1wqXxpAMlUyKZkJiumoG2hfV
	 XqAfhhbYdlnfSZAIK/qIQvTVz8xzpX64jsQLR0JpR+LSIlBnjPZdSJYf9NDT7Db+/Xpza
	 tBJcsKDQPx1xs+jytfhv/Vqzf0ntWcfHdYHFBZabjf3HZK7laiW1wt9ZKjva8yg+XIA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793689274;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 From:To:Cc:References:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=qyY8EAIZQKvkoEm1DokOaPgarkfMQMpqSdOyTfsKC4U=;
	b=q1Kh5p3gKmr1IBb28IWKk+qrDgzD/PgZxoa1IyqItGCABtyJTGW3oL1OWnzQ2PZPNoMX
	 gp68fp112eUnn7hBA8/j7DJRVbmnzNIafYVvQEEqku31zb/E0twdho+rJlZbhXGlJ4Hvd
	 o6ENe6RGggeHC+YA4NDHonC9KpdGyOND8tOjF44oAyE2G7vnXYGGB1sntjKGwBkgeFHAt
	 FJAZlkaE358U06j9c6YRNVPlsDpWlR1jPKOKKfidSjsGumlBHMyjagtrKIJ5/1azuxh5W
	 c/AgP0wp2FT5H5mdJGFWIecyn3/VoP7fUInzs0C54TCRTdErAZea/xrPopPGKG1x9Sw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793689274;
	bh=qyY8EAIZQKvkoEm1DokOaPgarkfMQMpqSdOyTfsKC4U=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QKSXDE9FCOcUtI2VkbmT8NAK0g2Ki5CJUuIcaUp/lvhFnevajG8jww3VuQPDm7PzC
	 LQo2oPr8GogoS/56/QE/d4QSQ0Y3dmbu23sdKJxA4YKrAg3Ivv3AMmidcuk+YpNM0H
	 3gnQr7ADr0HwCok47SDrhpmwPtO+vD1lve8TMpU4dv0jHrMsikOiyHdBARvf5q6H0h
	 /eQHC0gzCZbHGQEBrSN3lRE/G5Rf7++4uclg/CuncjIXXe/4lCwzuzAGEAcKvSrCrY
	 es/TD6zW9VV9adr4iHY13EjOyrg+M+5sM3+axmj30FRppmrpQiwj1SLvim0ZrKLA1n
	 N9b8O/33dSFtA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B60606060A;
	Tue,  3 Nov 2026 07:01:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 36045235
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 07:01:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 185F9400BE
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 07:01:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FG9dheAaGfQi for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 07:01:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 9EB644009D
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c112::5"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793689272;
 b=dtbclpu5HpXy4aL3/OWKB4vbNBRBdAPfN30aom89rVnkCb66TXZv0kkK3w6rXaRssBT0
 fMq4T6OwNOVNQ178WvkVApgBO/etEPbEJod6S5wsJrlzGlptjR6gGueujFIzJlkjCRBeW
 N2ClM6D0LWGgw2ruw4qaUtPhg/+eHWJ6+oyuoVNvqZjvNDAlNX5zg2cG1fvIz+VR6ELdM
 1r0TdmL0KqboaOfM6On89M6TxmlB+x/TRcFVjEQHqpglOzrazU+o6hYdpcgo4e222sZGK
 va1Pvtx7wR5YV0Die0cOYJdf+nBQqycC2RMm1CilSa8D+KJd99524hcr9BDgN9S3RZQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793689272;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:From:To:Cc:References:Content-Language:Autocrypt:
 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
 X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=qyY8EAIZQKvkoEm1DokOaPgarkfMQMpqSdOyTfsKC4U=;
 b=CdGMd1xVG/HhmPVf9JKrE4fSf4jDtcfL/IxH9bQnjzHrGYBrczzpYqeIuG+CGkoSJg1l
 bPO69xwJ4/cwopART2cwxX/g2v2V8VhYFpSq4IzTmyXMRHQ13TxWvbFcPYi6YD85SQAYG
 i9X7Uvf6sA3eOGZIx/Ju2Wg1Hsqlrj/OhExIBwg30idTlzHronQyKAYlTgKel2YSQicup
 t7o0fJiGB8Ju7t72+2l3Y2kaDCGjZKa1E0a8O59uKXOR65tX+PqMCWV1Hcy2livysFIxf
 9LsthLBSssii5lBB4bW/0A/pXwTfYnVxIiOHQ/M0l90vkNOjm9reMEDzU3+WQMFaCPw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=osAAzP4M; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c112::5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c112::5;
 helo=cy7pr03cu001.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=osAAzP4M
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9EB644009D
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 07:01:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aUuOeedlF2yeY2Xs3rHCmznFb+ciHkWc7d1jWGtI4l0gmBeQ3yAm52Pnrf+dgok2EnJc2iVngNQ6Fmgbi5a45M3Uq0FGNEMZSq99/GmliZx35w5GbTGCvXQAh79Tzj0VBmhKAQ0IHKF9UbAEnX2ReOKOFoMGU32beXeb+rIzK4/KFibbxxzOmgDt/LbQDbufbqZYQYEIZp4y1J1bUJapk7xQZIVFhY6UxtXmbCmk/M9BRz3o+nUtv4IMFGTlmRfoni5V4zWn1kvPi9JdTrNXptZC9vrEw82+02eSzyvCfMAPGFkefdOrXnstR+XZ6clAUZyh58SAqAJ9FojA3pUJIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qyY8EAIZQKvkoEm1DokOaPgarkfMQMpqSdOyTfsKC4U=;
 b=O7z3bPZAeXH9z+DtiWKohOxS0y9htX/KGwvG5SfeDdj42I0UUnVW7fWjukyBuwN9QnWcwGbx/A5io8kBZpCNBK6EPsxo3xBx1EmBHUddEcZ0gQbZTaehIzrh2kX15TpQDb9xB1MkipZ1C8dcRqbOSaE4vxJBHwBbMgkoYb3J95hzdH5ut4fd5mcy2P7FGja4Dii++2H8x5aPimMSq9svR8Re/Lm5blu2rfMW6jFj3kC9Ki1CDYzJ4czMnsiWYwdQ3aW/wpgKBV4oaokW2kUf7ujIOM4pjbiB4OmWV/IqhrmLku3TvVGfqDSXEK8AdBLWH1zopkRPMgMN47utAtXgeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qyY8EAIZQKvkoEm1DokOaPgarkfMQMpqSdOyTfsKC4U=;
 b=osAAzP4M8Npl62CGEYusND0w4Yi1r6ySsmW4Js5yPab6dTjlekQOM4zFRMA5AfvTYsL300cUnrFoZrWbOqQHNXUN4Kq3hC4soCzNjhVjIkegAtZ7GRRBiITRicprrLVktmxfqAQ8RvRrPthoseLrGj8Q8FD7zdnuu35OO+yUQ7E=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by CH3PR12MB347562.namprd12.prod.outlook.com (2603:10b6:610:367::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 07:01:07 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%5]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 07:01:06 +0000
Message-ID: <e2a36667-dad7-4313-9d2f-2c6b3b58c728@amd.com>
Date: Tue, 3 Nov 2026 08:01:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] amd: versal2: Switch to SCMI
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.u-boot-project.org, git@amd.com
Cc: Padmarao Begari <padmarao.begari@amd.com>,
 Pranav Sanwal <pranav.sanwal@amd.com>,
 Prasad Kummari <prasad.kummari@amd.com>, Tom Rini <trini@konsulko.com>
References: <cover.1792504756.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <cover.1792504756.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR04CA0006.namprd04.prod.outlook.com
 (2603:10b6:a03:217::11) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|CH3PR12MB347562:EE_
X-MS-Office365-Filtering-Correlation-Id: ace58096-66dc-4b48-5d62-08df39783b8b
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|261102123227099003|11063799006|261009223027099003|261028144727099003|261026140227099003|261021123027099003|56012099006|261021121427099003|261026121527099003|261022105027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 72kLCQ9SAJnwHycdZNwn36ejl+0Sa1SAeXY/LDqeQDfBkw3JLqzRchuKquJ1hOkE89mmsrQr1Aclr3hOeAoQlmIMVohits2lNCq9kvVh9YdN+iWIbbdXndCbrORa/rNJz+ugle1D4rSyRTGLF0kBDcrI7zjTOVzpNI15ws9Czs2Zj+0Ndu36k6aEmhFEHbp+TiTPebng/MNHd0wCiZI2uzbZkhtfb0vSJDaSvjgKCAQkJ2GBgVNZt0kl/lXQpCMhXtm+89wmkDtdX1QC+fZAusPoEpXV/5zSMVeSlHRuWyeStEMBahht213+tKm1wzjOoJsMsyPyX5MAl7Xj18gUzvjEh39QNN9RThoSaSeMQ6JiXrR/3wSuyl6jrPpHBAw5Pc8UbYOQH5tC/arlfQsYB19t7aYHxLpZCwxcYVtolx8beecSU9pdJkngfrYinE1ZFN7zVVkDhxptZSiXsxoqZNoYbclhvfu5kV7Nher2ft2sJKs4sHdN9RZjKkui84/tEg7UxbNWJ6ml1PFC97oJn8cJzcTBNqWqwsf4yiz5vqj+/KXwLb478h2Chqey0Pl6BnbJDdUP2+GUxn4loKXzB0Gx8IfMDwolvG23rRKlJyhotBs0QogQ5LawETkJNT3CgpPhsNPxuzf38La/Rotcbs25ifPk4xVXCytijtqXXks=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(261102123227099003)(11063799006)(261009223027099003)(261028144727099003)(261026140227099003)(261021123027099003)(56012099006)(261021121427099003)(261026121527099003)(261022105027099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXBRV2hiT3pWWVRGTUpFcFAwYUVRcnV1QWNwM1JZNUJEZ0Juam0ydHdYV25M?=
 =?utf-8?B?dU81dXNUSyt4YktmWjVQYmszaDEzaWJHSk14TC9UMjRNSldmamRYYkRWOVBH?=
 =?utf-8?B?cEdYUEdnUUtnZ1d2eHF1VHB1UUd5Q3IrakRRUC9oUU9QaWRaaUxUL3ppS3hS?=
 =?utf-8?B?N21QRXJieVZIZ2dtQWFZMVVqcGptdVdubUZaT3M1VUFUSUZVbGc3cDByS1FC?=
 =?utf-8?B?cXFCaS9oVDljaVE2SDhDZGwvbTZGZDgzWXZ4TEY5NG1PRFhIMVdrWVpyTEFo?=
 =?utf-8?B?OWFpTFUxd3FGY1RYajlUY3NLYnRNYnhJQnVRcTVOQlRhU05QQlFWRFpsSDVM?=
 =?utf-8?B?WFFBZ1pzVGlBcWdnRG9HU1RhSmdoeHNVTlh6TEhGTVpwSW1sdlo0b3Mrek1l?=
 =?utf-8?B?VmxyeUpsMjZ1MlZFc2pYNWd3YVRRR1FqOXR0VENnc0xZSTBJbjNiK0d6NUdp?=
 =?utf-8?B?TE40bHRqVkxvZlhqTHZqMklFaXpZUzZYS0kxRHZVZmo0RXUxSGE4MUFaMkpW?=
 =?utf-8?B?VjdhcGpPNFZKZVpIMENIdWx5Sld5UTAyL3M5OUM4dC9TYWV2UFJVRmFkbFpo?=
 =?utf-8?B?U1R1OU1SVWlSdjBoQktUS2pTVy9BSUdoQ1luZEE4YUxzdmdiOGMxbmYzdkk5?=
 =?utf-8?B?SVc2MCswTGJzR2I4SUZLdHgyNGJMdFFNMXh6OC9kcHlNTVFoa0R5aTdYd2k0?=
 =?utf-8?B?TE02WjR0czZYNTErYS8xam16MWs2K1lTZ29iWE5paHUxS29Da2NrbkxWYXQz?=
 =?utf-8?B?RE03WjZQYUVhWWhMVnR2eExLcmt0QnB1bS9GT0pFTlBrN3Rqc0RDYmpJNFJ1?=
 =?utf-8?B?VzltL010QXpSN1JkUy84cDh6eTBySTJMWEdxZytlVkZGblM3UHFjY2hCTDM0?=
 =?utf-8?B?ZXpVY1NpaUNnZVpHWHNYbnpKQWpacWZjcWJFSVV6azVuNHRmOW94ZmVpdTIx?=
 =?utf-8?B?MG9aQlpvK3dScGYxclRtdlJCYVIzUFhEbC9KVjRqcW9jTGZPcGNiTC96QlBW?=
 =?utf-8?B?TnZtRzU5cE1yNGhtbUdYbkhsZjJobjFhTXNGTy9HM1R4MEhOZTdCcFpIbHRW?=
 =?utf-8?B?Z3pUSTBTWmwrbHlBYXNQZm5FdnBPS2ErOHMzNmg5T3dOd2FrMmQ0R0dLUi9a?=
 =?utf-8?B?NUw2VG4ySVhhelo1akxTM1JzSHhFQ3dZbHBaUUFMbnFLdlRxQTZ6UnFlRFBR?=
 =?utf-8?B?RGpWbkFYeGpuOW9mT3R0c05jN05nY3B5L2wraFVlb21GL0puZnlaTFJ1RVpI?=
 =?utf-8?B?eWw5MVFYbEpvV3g1dE0reDY5eFl1VkVEaTdDZjhscnpvd09hOHNIR29aWVlL?=
 =?utf-8?B?SW83cjVRTzcrblBPZmxsdEtVVWRNYWJxaEFkNmhLejNaNVhyNTdNeVhwbEZz?=
 =?utf-8?B?b0Y1aWNaT2J2UThZUDRSdVpTS2wxSU90UndVaGh5eWVmcUhlYkhmZ1dyNzlV?=
 =?utf-8?B?TjhwYlZES1ZJS2hYM2llcWc3R2c3NFE3VTh3cEs4Q0Eya2Fldm1EOTR3ZzBs?=
 =?utf-8?B?NlI3aVZzZnI2UUpMRE5mc2NjdG1YZmZhM2xWVGlmZ05WdHhKbVFlVll5Y0Ju?=
 =?utf-8?B?KzBVOU5yczVHZU1iMFZ0U0JHUU93YjhDczdBRDdDUGZrbkI0U2V2MFcrMHQ2?=
 =?utf-8?B?dHNqMG9Lb2JEbkhPdXNBdmlrbDZOVmt3UHRpa2p4end4aGI5MVpSQTF0SkNo?=
 =?utf-8?B?RVNVeWcrZndLU0lmMXdrcHBUZkt3NlE3bTFwUEpkUXRUZWZCcUdhVjB0SllW?=
 =?utf-8?B?R2FDZTZBZzQraHVqd0hQdEJXUm96VkF2bnM1SWFXTjRESkl1RFhwckJEWVBS?=
 =?utf-8?B?SDlTS08vVzV3UDZqTEQ1ZkVaMUVQUmd3cnNHNHVZZ21ncmc0SmpnMzdvK3pR?=
 =?utf-8?B?YVhnenlRTDRLM0pXdVdpcXljQ1NBTW56NDdIR2U1RWdoNmR0RGkvdk41aUI0?=
 =?utf-8?B?Z2FjemhLUy9hYU4rUmo5L0hzV2ZPUHVNSnY4R1drZ3VPMEVUTjZzcEhqK2lt?=
 =?utf-8?B?MWR5NTk3SCsyR1Z2SEdINlo1TWpCU252N200OHdtMEtGZTZSUmlVUjhqQ01Q?=
 =?utf-8?B?SWY2aGpLVERZYlZVV3VtNnhGK3RCZVlsT0lrRnlZTi9OTmdYZEdGUHY2WW81?=
 =?utf-8?B?OENRSEFGdSsydE1jRVFUMTR3dU91VDM1UzhvUlhVU0pTSkdoNktRSlpJNjcw?=
 =?utf-8?B?Z3pSNnFuai9sWVpNR3JCRS9ja2pnNGxUa2l0dVlwTEExTlJlSEdqY1F0L1ZL?=
 =?utf-8?B?aWNKcmM4eGE0aVJKSHdtWXNJYTlWQnc2VEZPTFNCZXM2cTRVTGErWVZYOGlq?=
 =?utf-8?B?dU5ZbjJJU3ZaR2Y5VndwME4zOU5pOWpMWEJ2ZUlLQkYxbmU0MmZTZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ace58096-66dc-4b48-5d62-08df39783b8b
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 07:01:06.9055 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MWgrj048q7bVnCeQ6tPtfyGlVoHg9RfCIURH5IjDHcPJol2cSwiO/7Qp+h1rm55j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB347562
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/20/26 15:59, Michal Simek wrote:
> Hi,
> 
> Versal Gen 2 is starting to use reset, clock and power domain via SCMI
> that's why enable missing SCMI config and disable firmware based interface.
> 
> Thanks,
> Michal
> 
> 
> Prasad Kummari (1):
>    amd: versal2: Disable EEMI clk reset power and switch to SCMI
> 
> Senthil Nathan Thangaraj (1):
>    amd: versal2: Enable SCMI power domain support
> 
>   configs/amd_versal2_virt_defconfig | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> ---
> 

Applied.
M
