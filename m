Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57243D185C6
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 11:42:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD52983B8A;
	Thu,  8 Jan 2026 12:42:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="BNUOr44u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71EAD840CC; Thu,  8 Jan 2026 12:42:40 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BB9E83B87
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 12:42:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tanmay.kathpalia@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rTuF5KcVgspxjL66rz552lD7QHiOljQC7f+1+zeqFst29yWOVWSYPsocjAedy8pgj4xWWXUb070SUkuw5O03SCi+jZwKxQOn6W9cwZgw3hzGxKyeNMDwSBz8ryO7MF4tQ/uW+ptRCV8KN9UrOdHMFd8cRUbUMJoztUU0zbqGc07OOYaamemll+9Xi4ox8FMN62sf2ZbYhOQxTwqg3JRTB/RRnognIgoieDKSOYRGk+ISzJtsGss0idAyLWr6KKxEwLXfaZ/dp65aCjttLJr3FVda+cM4lSVbGblN/C+7Pnxqbede+0t6YVpS5w6LNCvCo0fLkkYrYkfxr0IdRfJmcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Brga6EzrGLz9WM1Sz+qG7IekebrcF3j1D4sTCAcpLnk=;
 b=qUVn3R3QuoYQLi11dfSJP1dIJddenj3Zcjd9AawimGRtW4H5kws5GwbnVy9pUkGXtJrcPQH0aNTCppM57UZ6TRUy0A6eSkWm0YtLLLkHomxQ20QpuBVsku8LMF7spu6e+Nkq8gZ+a6vitsob5qUjTXh0AXyAR1soNLcwdRysZHTgjS2/iedxIgyuXPt3Vq2Jfjb+5KVMCnnqYkWTthuDStv1aoHQW7B0Uf0hDtroVwTBmqwyKslOBwfoA/a3u5vUQxsIBoTkPS2FAo4GQzz8DW5jc8CI4YBc1vQIIuvB03ilG9kDxuN87H8XnuiTFDsbPhMsrnJVDT+cP1OAIcRKXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Brga6EzrGLz9WM1Sz+qG7IekebrcF3j1D4sTCAcpLnk=;
 b=BNUOr44uza92SEhk8eVG80xFzF8roeRoaPbOq0SUcNltxZR4h7BMQ9lNOzw14JTUR0e97SGbND3ZwJM62MdyxqTOZ/vlgoZDkDAah8G1EdHBm6pmn0FfyWTDc/PC2PPHR9zodEQvpXwMGvaB6bdAVPPreS/8oYxfxrA+hqp/gCu92nOMnrg/q2Is9ZSAQff8HkaRvYRXXwjeNOAS25x68iau8g9W5XWhev3/xxax1w7FiPrEyNhOSv+l2JatPwEQvZZA4y8UdM+Mdb7pFmozxK07kzuxGzxoEX5JHARcSZm680HtO/ihDvHasTm+7PfpWDKw+myVgUqTT8ScVFmjoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BN9PR03MB6204.namprd03.prod.outlook.com (2603:10b6:408:101::21)
 by LV3PR03MB7729.namprd03.prod.outlook.com (2603:10b6:408:287::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Thu, 8 Jan
 2026 11:42:35 +0000
Received: from BN9PR03MB6204.namprd03.prod.outlook.com
 ([fe80::6b00:aa6:cd64:2526]) by BN9PR03MB6204.namprd03.prod.outlook.com
 ([fe80::6b00:aa6:cd64:2526%6]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 11:42:35 +0000
Message-ID: <d28fac9d-4d61-430b-a574-a58bcce8655d@altera.com>
Date: Thu, 8 Jan 2026 17:12:26 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] mmc: "unable to select a mode: -5" on i.MX8M/AM62
 platforms
To: Fabio Estevam <festevam@gmail.com>
Cc: Max Merchel <max.merchel@ew.tq-group.com>, Vitor Soares
 <ivitro@gmail.com>, u-boot@lists.denx.de, vitor.soares@toradex.com,
 peng.fan@nxp.com, jh80.chung@samsung.com, trini@konsulko.com, marex@denx.de,
 tien.fong.chee@altera.com, balsundar.ponnusamy@altera.com
References: <95beb49733a28c7695dd0bf026b4ffe8c3fc73e3.camel@gmail.com>
 <d9978b24-65d5-4f8f-8ef9-e551c5baf9b9@ew.tq-group.com>
 <6e24770b-ea18-4678-90ef-6338bd40b147@altera.com>
 <CAOMZO5DSf=ViRb-3Z8RWKFiN+P37sk2Wds0Evd9_Gt0nbekc3A@mail.gmail.com>
 <c0809c43-5efa-4150-ad29-497b3b0c8fcc@altera.com>
 <CAOMZO5DuyO_vTJig9w1WaLhYe81oq_1z9VzabpqRNZnGMmAGPQ@mail.gmail.com>
Content-Language: en-US
From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
In-Reply-To: <CAOMZO5DuyO_vTJig9w1WaLhYe81oq_1z9VzabpqRNZnGMmAGPQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0021.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:177::13) To BN9PR03MB6204.namprd03.prod.outlook.com
 (2603:10b6:408:101::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR03MB6204:EE_|LV3PR03MB7729:EE_
X-MS-Office365-Filtering-Correlation-Id: 898d8b61-77a8-4b17-a3a5-08de4eab0479
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K3Uvdi9hUUo5L1RXSG9WZ1ZndUl2dE5ESkFYVEszYVcxeWtDQ2dmZGRnRjVn?=
 =?utf-8?B?UVJoU05RZzZlM1lXTzlLVTBSRjQxRlY0YS9leUZrNjlCNjZldUNySXk3OGNa?=
 =?utf-8?B?RTk1Nm40Zm9VSGRSWGgxalpFWGM3cFkvanoxMUV0VTNYUjdEMkZ1UXd4dnVM?=
 =?utf-8?B?V3hHazRNWkhqSHF6a0hrSUp2VjhYU3BtUTVQUHdXQTVML2lOQjVEc1Q5WklV?=
 =?utf-8?B?Snd1c1M5emdrSEcyR2Nmb1NBbEdIRW9ncFdTTDZSTlVYUkg0dndRVnRnaG5O?=
 =?utf-8?B?NHNxOFp3WFpLRzBxVHpjVllBaFUyNUw0Wlk0QUxCT25JZEEvZkxGOWMwRDY2?=
 =?utf-8?B?akk0UjcrOUlla1Nmci9rbklJZVdqRlZHTjZJUGlUWWpVODRsY3g5TS8weSth?=
 =?utf-8?B?TWpkc1kzcWZiVFRCRDZzY3FDL3hzWFVBZVVkR2NsSHgwZTFOVEhsL29CQ1Yx?=
 =?utf-8?B?WmU4SGFVZWR1alhVSmtEY3FqZnJTMEVXWm9aNnA0MG02cFJGcldOQ1lhNFg5?=
 =?utf-8?B?SDk3bmpMWFhnWEFlNFd2ZHhhMlJJM3VybTc2b3JRTVl0UXV6a1IyaXNLZmVv?=
 =?utf-8?B?UWlqQkhEZzFKRW0rd1hXYWs5Tkp1eTdpRDBrb1F5aTA4RUt4enBJMllMQ1VM?=
 =?utf-8?B?dXZzQy8zcjRTc0lRQ1cxblNoUHAyZEFUSThUd01naWVkNDJXWjIwc2VCL1pW?=
 =?utf-8?B?OW5zcUJWM3pCSzVJb1haMEJQeFBFcEZobTNkTnY5aEJQNktzRmVLbno3RzR2?=
 =?utf-8?B?MDFUZU1yd0hhU2Y5c3ZZZXVadU5lb2JSQzF1UGc4dzU1YmtTWVpxZlk5VXFQ?=
 =?utf-8?B?ZUtkcStqL1M1czhRZDNtbHU1OUxHbFE4UHFYaHdWNUxpZy85UHU3UGhaLzl4?=
 =?utf-8?B?dHlkT0RoeDN0SldtaXhFUTFxQ3UyZlNLclN0UHEzQzJWaVpuR2VSUkNNY1hu?=
 =?utf-8?B?QlNVOFNWSFAzcFpoenhrOTkxSkVaMVFKNjlWUDJjZ2gwaGZRY0pBbHBnYjJo?=
 =?utf-8?B?ckpmdm9NN244bjB3TFE1UlFXYmwxV1FySk5hS3pvZGRXUnY1L2pMK1lmOWdn?=
 =?utf-8?B?MnNLTkovd3lTbUF5MUtCbW9aOGlWbTR0d1ZpY1B0MUliUFllNStFSDFyc3BF?=
 =?utf-8?B?eU1obDJuQlNmT0NsdzU5MDZQeEVDWHZVYksyOHlKQWtYMTVia21xV3RIZTg0?=
 =?utf-8?B?UWZlMTdoUVdRalRGZEtUSURqV3pka001R0E4V2lzZjVLL1VmdUl0Q0lIN1k3?=
 =?utf-8?B?WFFHM3FHQndWcjdqOWg1WGpOOENSODZzWXF0UlZ3M1JtWmtJdjZqenFXTlZW?=
 =?utf-8?B?Z0NvdlpIZ2wrSkVMT3l0OHBiT1BLczRxd0NRMDFVTnZKRUhraGRVcVRLbi9U?=
 =?utf-8?B?L1R2UkswU2huUld6TkxzQzJiTnRGOEo1clFOdUhhRjVzTVkyM2JrUnplZnFT?=
 =?utf-8?B?QSs4TzIwMytSZGpFcitjUjlnNTZSYVNwOEJhK3Y2a3hwcm1LT0t4WkduRXY5?=
 =?utf-8?B?ekl6ZUJocjlsUVpCdWlEeG1qZnBFS1RLZ1d1elJKTnYxclpMU0NBUGxLNTMz?=
 =?utf-8?B?THh4c0tmdTRaMmFOdi9aYk02bi94bWhWR3ArYTdPTjlSMFArRStodVJsR2lM?=
 =?utf-8?B?NjNRS3VNRUlDSFFJaERTQXRqM1VORnRXZkY0eE15Y0lJWFZMdUcrRXdXRGRJ?=
 =?utf-8?B?eUQzdTNnSDVPTnA5WFEvZm9MZnFETXFpem5ZSloyUWZNRjNjUDZzUGRDa2Jo?=
 =?utf-8?B?cXg2WE5CYzdVVnNiZTZkT2JlRHJKWXZhQmQvYVdZTFNsQWxQcE4zMzRZTlR3?=
 =?utf-8?B?REFjajBsQnUvNUJEQ0VtOHBvamJtR081UEJVaEdkQ2tmN0lPQmNKMkRSSkN3?=
 =?utf-8?B?b3hrWWRmdC9JenlYZUJQR2QwbElkYnZmbzN0TmdFbmdHcW1JdkkxRzh5Y2Rm?=
 =?utf-8?B?WDhVRGpJeFczSEY1UTd5bzZXQWlNc1pBWlcxOURaNktmakVYN1F3cG5nQUQx?=
 =?utf-8?B?SS91TkM2UHZBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR03MB6204.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ai9JZXpIaU9aR3NDV21zTHVSUkk3ZWROdjZEOUV1cEx4cnVUdWhWT295Qm1K?=
 =?utf-8?B?cU9MaVhubVBxZFJDQnJzenBsb2NBSEt5RWxOV29TZmRVNVByNGR1ZnpnU0k5?=
 =?utf-8?B?d21vZ3Fhbm81RDFtMU56bHZnMVJRUlk3UGtreUV3WGNnRlpKMUxWa096TE81?=
 =?utf-8?B?YmJyL2VpTzUyUC9OR0IyS2oySHV0cnBuTmgyVkloMEtNN05WZmp2Ny9paDRV?=
 =?utf-8?B?dmFPTHlvdUlKVmhiaFNwaEp1RWV5QWp5UHRuaWxWZEZ3Y2xzblJSV01MT2E2?=
 =?utf-8?B?bEtUUmpYcmdFMU5vaUorRUZWSkpmVTBVZ3AwNXJVNno4ZWdaaDZVWGt0YWRO?=
 =?utf-8?B?VGp3TGtQK1daSU9SS1B6TU95Y20xZE1WYis0MDlsbCtkb2xKck9leXJndC9a?=
 =?utf-8?B?bU9udmtpc3A1Qzk5T0xMZGhwUnVEUll6dm04QTRuMkRERFNGVGNBK0p5aGZr?=
 =?utf-8?B?RnlodnRkaUs3T01NeHBTY05tMGpQQW14ZE9oMUFFcVNhK2JEUGE5eE1nSU1m?=
 =?utf-8?B?ZXR4Q2x4SXVTQXFhUkZWc24vWXMxWGc1anlrNUUrUXB4VW9TOTBuR2RaRW16?=
 =?utf-8?B?ZDZteU11ZkNQT1I4UHcyUTRDcnQ5RGtydGpYeWpvTzFmZHF3eGFZclYyRi90?=
 =?utf-8?B?bWszamQyelBpbTQ4anRkK2p5aGRMbkNvYSsyb3NXTnhSOVU4anNzNWFGY2Rz?=
 =?utf-8?B?L3ZZNWkxcE0yMWhxTHpuT0tPM2RiNGJBNWkwZEpvN1RaaEpuY0IyMjJWWU5z?=
 =?utf-8?B?RTEramJuUGlvR1VzRDFZRU1OL2oxSzAxWkhiOWJiYzBNeSs2MWkzRVo5TCtP?=
 =?utf-8?B?S0gzQTJObis5bVpiMTVzcHprN3RMZ3hramMwRzR0UnA5NldlMlJ3V1dWYlZj?=
 =?utf-8?B?T2FTaHZYS3NNRW5URzJVU0VFZDJGcUt3TXBWUGNjSm9vYXNkTUlIS2FXMUM4?=
 =?utf-8?B?U1U5a1Z4WHRoRVF6QWU2bkxqU201K1p2TktLek0zWEtPSXphU2xIV3FKclJl?=
 =?utf-8?B?MGcxV1dEVEM4WnE1ci9LTzlET0tMVUl0azB4OFBNYU93UjBBcHJnQWpIbXE1?=
 =?utf-8?B?VlVvZ3FKT3kydnZ3MzhHMHdmSkJrLzVyRDBnaEhHM1k4MFpIbjZDZkxuZFN6?=
 =?utf-8?B?ak0zWGVPaGRRZnJIZXd5b2NXM1JwcVZmZVNzOXNHQUtUVkxtdVhrUVo3SlZO?=
 =?utf-8?B?Yzc2blUwMlUwbGNFbXVDZ2FaZVJVOWxwdGFMRGRFck80TUQrR1JmNk9GQXlE?=
 =?utf-8?B?ZVU0VEIwUWdEeDVObXJndldxSURuRmk0YzZTejF0WExYOERNWVgydU11VjRN?=
 =?utf-8?B?WHdWcVB5dDk4Ny9UZDVoRjZtVHdSeUJiaVRKVWxtOElackhQd1pQTEVvdHF5?=
 =?utf-8?B?Q1VsYXhFbVNvU21naExFM2VlaFN1VGZIZkNoWmNHcEdUQmVYbWJtZUdQeC9T?=
 =?utf-8?B?bHVGWjBSOG5ycUUxY2lWKytJa1p1SU1BRndFc1BmSlRrUy92aWNDVFg1VElN?=
 =?utf-8?B?aWc3M0NHb01Sb0U3a0V1Q1RMRk5jZ0d0NlZMckJndnh2Y1dHSUYzS2VJTGI2?=
 =?utf-8?B?M2ZYQWlGNUZYb2RFSVRlQXFkTHJTOEp2MGFQb2x1Z0FreVR1eHZJRkdrNG5I?=
 =?utf-8?B?WXJleVdjRS9WcllKRVF2eUpPNnQxSVBYNWlpdS8wQzUwUnEySm5NcXBYVUlI?=
 =?utf-8?B?dFZBVmNZVTJBWE1jdjhxaXZCUzMyUVRrbmhUZ3FPZ1FsMkJOMFV4UFNxOWh4?=
 =?utf-8?B?UEFmNDg5WjZET2U4a2xvbjdOQmZJYmkrNWpjNFAxTloyYnlFdW84TEpsa2Vn?=
 =?utf-8?B?NDBMcU1WOTlhaFZMQUxqaDg1dnRNMFNlZGpRSEg3Zlh4aGE0bHNWd1dMRzFa?=
 =?utf-8?B?dVQ4WXJFcmtQaFhtN3dzYm5wWUEvODQ3NjJ5dml2NUR0ditTNFdMRHRXRi9v?=
 =?utf-8?B?UDNsZkVYVXYxT0l3UC9JeWRsMUpGeDMxTmVPSGJ1cVZrQjlseTAwZzluK295?=
 =?utf-8?B?ak1qak1yVDNLNUJJdG9Ub2VLdzdKU0R6SnJycEEvendjcWNhaWNMRkZGUUpI?=
 =?utf-8?B?Ync3NjIyVkF5SWFrdFNGYWsvTGZ0d0RGOCtLVnBGTjFKcVZHRkxzTjc2cHNC?=
 =?utf-8?B?Rml4UnQrb09INTVnb25NT3JEcHB0Q0Z6czR4Ylk5Y2lvVGtRS0Z5clJVejBw?=
 =?utf-8?B?RnNoUlY4RTYyZzIrVDlYYW53SHBaT2N4dktFMVhsZFpyL1hicm4wajJLOVhH?=
 =?utf-8?B?M3hxWFVwV3N0TjlRREQ5c1laNUpFb1ltekE3Nlp5aWc4ai94a0tXM2dqczFG?=
 =?utf-8?B?QjZyWTR2eS9sc0RoeWM0TDFueWhNY0doRGJjdWdaejZMRTBzQy9YYlg3aHgw?=
 =?utf-8?Q?7rE9NFd7mVWXxV0w=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 898d8b61-77a8-4b17-a3a5-08de4eab0479
X-MS-Exchange-CrossTenant-AuthSource: BN9PR03MB6204.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 11:42:35.7838 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e1owWgyZ4fOPggl5UbmK45G5NFXN7ZN4vYvIhq1+ABGnIH1QZx6JXeKJ1Mex3Y0/SHVd1bg+nZm+v4XT9qetcKEGrdXpr1qSQandRoBpsY8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR03MB7729
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi Fabio,

On 1/8/2026 4:51 PM, Fabio Estevam wrote:
> Hi Tanmay,
> 
> On Thu, Jan 8, 2026 at 8:12 AM Tanmay Kathpalia
> <tanmay.kathpalia@altera.com> wrote:
>>
>> Hi Fabio,
>>
>>
>> On 1/8/2026 4:38 PM, Fabio Estevam wrote:
>>> Could you please send a revert?
>>
>> Here is the revert patch for commit aebb523a2381 ("mmc: mmc-uclass: Use
>> max-frequency from device tree with default handling"):
> 
> I meant a formal revert patch sent to the U-Boot mailing list.
> 
> Thanks

As requested, I have sent a revert patch to the U-Boot mailing list.
Link: 
https://patchwork.ozlabs.org/project/uboot/patch/20260108114002.1612-1-tanmay.kathpalia@altera.com/

Thanks

