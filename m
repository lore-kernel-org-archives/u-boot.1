Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08B29CA9EC5
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 12:29:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 670FD4056B;
	Mon, 12 Oct 2026 12:29:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qXSJf-l4Pb2P; Mon, 12 Oct 2026 12:29:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6E4894056C
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791808155;
	b=NQ5i4i6ty9M3bVOMjofuDAnGTKoBKKx314dRFbp7opWhQVeo9Rk0NRc6o6tjNFL5vFui
	 9qK0SjhfwNZSCvgW4KuFWQQ47kyaa7zyEr8C0r7C41cJzm33G/e8cYLNfObOK6tT6WN4b
	 ipJ4sG2U3rmBmOYFptpYRATr08RPCvwJJvqN3BnPbomf1Urw10nYrx86KNXwKb+sXpjaR
	 sScVl8BYVvVVbAlgfdipQ7nSTxmTFPV1eWwzMmw8hyx5+3rHhQfoFHgJ8KY/+jfiIzXHj
	 /4AuewCLYiTlVXwqzNkxl684W+UU2aUkZb+q5Ivu9M8Ms6CW5f1nDFPGzho8MqVWcvw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791808155;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
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
	bh=rQ0GNfHLj1FEsceW24o3vohh5Op5keNHNNoFUVWZ3hA=;
	b=L5IXU0sxmI4+fOPlZ6kv/9pFTwIz5r7XhwaJ7xaBsQboBRIqcmiQbO9ibwp76zl7iPY5
	 vZtGOp4C0UiBD/gdnlILILMJzIkn4DVKoB9l1uJARxOIXsLSqIE1xnEZZrAFxInKmEVzg
	 MH/kRLo+ThlGrp9e/kZt1LcfUFk6EE/xVbpdLSbKw65Rw6LmjnGun3jsT5B+OUYfcDXEZ
	 8PhN1DECXg5AmAKtD9RUFvlhAGJN+hwMiw09cvCigHfcT+aSqJZSw43qNKbGSsROrtyQc
	 A9CQTiG7dUEiqf2rCDn7llWbm8yEzub3XupZlQTD0gmDy+vINmy/LwGE9Tw9ywaO4qQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791808155;
	bh=rQ0GNfHLj1FEsceW24o3vohh5Op5keNHNNoFUVWZ3hA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=U8To9r0MaOfEoR+O0zOCR9qunWm0cbjUlvmlkOpOJIxG1ivJ62cy47XWPKUDwuEJu
	 EffjkjmaHbv/IdHFWueLLtAV/UuUN7+n9wEYyvB1O3ORqyhRUgbWrCeyFaA/r/+EJ4
	 EbxR3fcp3wMM3Uvm0Q4h6Y1m2Nwc60la9bnLgITh90srwBYXVcBaPAU0EPGAJxJViv
	 wDg6WmiQY3ryG1nt6LvyFFIjcOR/esdYnHPFh0f5fmClD0mvTJJlHi2Z3YTBJ7CmmY
	 BsakFN4y962lmJiV635iHcCZDuzo9NSZmKl/XYzaxlV9K7N29SFVPMAhb8PkSXjgrZ
	 /xBDPMvnPOGrg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6E4894056C;
	Mon, 12 Oct 2026 12:29:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4F746105
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 12:29:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 34E1D80D5B
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 12:29:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U-QxWmB3Cf-T for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 12:29:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2172980CA4
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::5"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791808153;
 b=r9cz607XxX7sFbV1B1l/XNfk5nBClgSoLifh1MPo4N2axLZ+AwNlwgR4+j42R1at2wXu
 vk/hH9+7Lqrdf4M+q4lbQHsHtRBB432kQtTGaoEP+ltagz4npGpBfdN2DSbBSkhPTfI1u
 3jTL+w6QUgFA6CMPHed+VIZaHfXv1OUEl5Kwke0wYCa6sVtmW5FveP6fx+BUw5mIkleix
 eDMWZBNsHILHRAE7STqDtTSaphkK+UKRbc5xN4Gmzh1UD3H0OuWex+wjE3PCDdPhxwYjG
 f8/TLYZ+FXd0XUnXMkcVmr8IjBPtKpkhWDPaSG9lBKqJEPASfYWakbCiwJ/b45kvkYA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791808153;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:
 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=rQ0GNfHLj1FEsceW24o3vohh5Op5keNHNNoFUVWZ3hA=;
 b=in9Dh69y9HJGomEVPzQ5qvRqqzn6+nwDeI3SOe4CFZspUIW1pkGXdmto4gJuNnqu7ZJL
 AftbSoZXihBiqDXahSfFXY9OdErxtfvHUzy0+GMTZCCTVxmqllKpeuargLI5IlfT5L4aP
 K+DyYQzt8ANy6QuK9af1DcfLdZWXy2cl75+W8W5hNR9SRzfXM+phPqx+YPL32TJXK2+M7
 agcfqFHKiA4psByWGyYn5wHai2asMA/rmHTqjB4AlWiGmMmCp/NmzambEKIMYoC2UOlyc
 t6u20nafvFnc0jThXb7oCh6q4WFx1W3pFGbJ+rBttY2CZfjQq0kDgCb5uYqGXJtH+dg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=siemens.com;
 dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256
 header.s=selector2 header.b=A82BXPgz; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c200::5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::5;
 helo=duzpr83cu001.outbound.protection.outlook.com;
 envelope-from=ludwig.nussel@siemens.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256
 header.s=selector2 header.b=A82BXPgz
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2172980CA4
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 12:29:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SLHXkHF4YKkY/84DPZ7qYCZP2FnAz5idRhtJ45DQ/ZhPNIo7/U/8KtkajB1meRjRaB9jCuaEHJSiltSgUEnSTi/3i0PsVmWNYOER/HuhvQVvhJhwL4iEBNJsvD6bI4IIX30UvtqgKKnmrv3b+Bxq7L9QUUYUqAC+ULDQytBJfeaaHL2aiVTNURFMWlD5qfcf7493h//xRf8nxCmsPd6qbeY2vYE5z5ey6F/gaZa49Tvjmwx0beFOiI4YpdVIlyy62dG8DfKL6aw8WOdXrx7A2HJOHRBb3Guf5CAqI/Om933jvK9OL5ezSj4KAW7fSXM9/03jHx4O+Q6U/4jsQcC90A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rQ0GNfHLj1FEsceW24o3vohh5Op5keNHNNoFUVWZ3hA=;
 b=iIaYmzGuyVr6Z7SdyHvV/oKP+W0c0pI4wUQr9kQY96ctV2jitwq5vexn3JZPNHtaMwZeTbDFu2bISJUMcvMXeEfMwA4ivlF0R9GSw2Y/NtYgkP9mv7Ibv1CHlOHHgJC1TQybg2qoAOoYJI5LPr9ChpwI+Yv5sguxmvO+1K2oJQ7j2ngyAeWLtLlKDoxzV3Qr2/ETKh53KP8oQwVYaSgqsC7EvmAIAnshvT0nvTqauyesK2Ihirdu9LCLOM0hRBWdzgn8fnbScQCnQ5ZzmyIFGwC3/W2ICGxy5u35JkyKYdLn2c7D6ahhkZ0P6wjm1ZVxEBF03Vv5arizJ94wQzsu0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rQ0GNfHLj1FEsceW24o3vohh5Op5keNHNNoFUVWZ3hA=;
 b=A82BXPgzlY5TFdyF8Vf50PKmOzm98/9WITQVUuEmBEQrjx6rLVHLkOmFwkv0/luzG5UouDeUzO1/Ye/JgkYgJwUxdzTYBsePhi9FFGwMzYirndmaq7xeFAxhpQk/Poq7aacbUkGcm5rearbz2NVOFbJe1BO0klZFmNwDMfwRVGBBV9xYPMCyEka4keGR5KzNHcq9Oqge60eiidVC4rYK1u9LXr9ut2PtQp2aN4vGG1nLko4sPoo/tQHV9lbICHy2S7ZMHZvPWAj1Gv/e5rJ0yzhZDDzmu//2LG8Wtf5SOaBs2mlkRAOm1Vn4gNFBbCUxiodz6WoP2OiZLrGEshB2Ww==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2cc::12)
 by GV2PR10MB6065.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:a9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Mon, 12 Oct
 2026 12:29:06 +0000
Received: from DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::97ce:ff62:c0b8:4ed1]) by DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::97ce:ff62:c0b8:4ed1%6]) with mapi id 15.21.0472.015; Mon, 12 Oct 2026
 12:29:06 +0000
Message-ID: <6c21147d-8ab7-46dd-b2c4-d13e7cd3d3ea@siemens.com>
Date: Mon, 12 Oct 2026 14:29:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 0/7] Improve FIT signature handling
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Alexey Charkov <alchark@flipper.net>,
 Anton Ivanov <anton@binarly.io>, Aristo Chen <aristo.chen@canonical.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 James Hilliard <james.hilliard1@gmail.com>, Johan Jonker
 <jbx6244@gmail.com>, Mehmet Fide <mehmet.fide@screeningeagle.com>,
 Raymond Mao <raymondmaoca@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
References: <20260923114940.349985-1-ludwig.nussel@siemens.com>
 <20261007010348.GA2100789@bill-the-cat>
Content-Language: en-US
From: Ludwig Nussel <ludwig.nussel@siemens.com>
In-Reply-To: <20261007010348.GA2100789@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0197.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::7) To DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:2cc::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB5019:EE_|GV2PR10MB6065:EE_
X-MS-Office365-Filtering-Correlation-Id: dcd9f77c-fc49-438b-b1c3-08df285c6864
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|7416014|6133799003|18002099003|55112099003|10067099003|22082099003|4143699003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: 7I2StFT4uzQlbeWJsrQxTX4x5+MHmXnyVqrtJKrYW/fKepAlmnaRQeD1M2vY28Wli4xHSw5ZNALUJxnc18/dUAp5JNa9LYoDfIo4aseHeHwjExIvHt5hf5PWXoEbDpr5ADHQFJDugNg399fDiOH4tBnd/rHJ3Kji6bdKLY7vEeL91XXQ3VoSXiMpXNmvOIPB2os6hlbPag9WLQCcpm0GBgFCapKCOdVgq28dvtwJK7XrTywnvKuFcdXw85FKkmIZm0l5RhuNsU2XmBlzjroufVAHcPu+1NKFm/mqWqLsjREf+2CtDfc9H+/QSYKV6iidDxs44GYOBmMQ4y0mUeyjKHEPrcCVh2+XNK/+7oA0pw5WGaAqg9HU24Rq4oiIBHpcrxe8P3KxigzRLvJp3lcdYWkKZqKSyb4j++a4bhN0rd5vFsWe3SdfitBTjCvfd7PBjIUOfnsbCMuQGTJwnw4TAPXg4UDZD9HjC0UZNTuX5DiEj47pWo3IcIe/2nnRkrohvg1T4D8S+YW0HOJ65+rBos5GmKGW0/vYBF5HGnL3biyGaQaSIbb/pSC5RTwh5HcyRm3nYdzkQQLJboGYy421I+cAqeEXZFo+lm7FUi8aPEs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(7416014)(6133799003)(18002099003)(55112099003)(10067099003)(22082099003)(4143699003)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3R1dWlENW53ekpSei9JM3pXZHJvQkVjRjROTTFHK1RIdG5UbEdwVk5qQ2cv?=
 =?utf-8?B?alY4N0tGWml4eUo2dmliazJEblIzQTNacC9kNU5hN1JSc1ZLNSt6aWsvUE9l?=
 =?utf-8?B?NzQ0RnFkcllMNW9WamlsTU9xNDlIWDJoR0w4RDdPWWxPQmJhTk5GV0wvUTFl?=
 =?utf-8?B?bDRTMWpMTjRpTzhCKzFOdW9Cak1EQ2lKWUtDYWQ2UDFWQ25ITEVZQUNYOGpl?=
 =?utf-8?B?bDhzdUhjTVhGQlNYSFFSajh4WDl2MlQ0OHNHNG1tZDU2VlIwOGkweUNQUEF6?=
 =?utf-8?B?emUzWFZkUUg0WGlXcElUK1NORUhqR05kKzFVTUdtTzNEZ0pXbUNuaVpJbnRY?=
 =?utf-8?B?dCt4ZEpPKzJ5L2RnWHBFNXkxRzJkQXkxTENIcjdmMjdOWnBhYmZuOCtjQ2Vs?=
 =?utf-8?B?MDlISlJYamNSaFZzYkVuN2gzRlJ6RExsL1A2QjltSXYxN01hdHJ1N1NKOFhO?=
 =?utf-8?B?UkxVNkp0RkRzMk44TWNJci9LNWZPb2J2aU5yWmw5M1E4RXNSTTlnN2tIb2NQ?=
 =?utf-8?B?MW5lZGhVZDRNZDlHdmVaUkQ4S0hRTWJ0ekUrNEdKV2J1MVVjUDhKbXdUWGtS?=
 =?utf-8?B?WmVoaFB5bVRhSjNrNW5iajNGSlJuZ1NjQnRoOXhaWUlISUNBN0FSbisraXJJ?=
 =?utf-8?B?R3RkU2NTci9ZSG1FWWYzMlpIUmZmR2xpa0V2c2oxeFg0am5VSGEvbnk1Uld2?=
 =?utf-8?B?bUhHT1J3KzVGdHBIMDdtbGxmcHh2ak1TdFFvRGpvZityMVFNTy9CbHhCdUNM?=
 =?utf-8?B?aXBZZW15SnA0ZVQrdXhrMHZNczcxV25PSUNINS91Qks0d0FQSkNSb2pTekwx?=
 =?utf-8?B?Y3hxMFZYZjRlWGJONCswbFdjN1NYRzhwZXpDdHVmTk50VklOWXU0eEFsWmNj?=
 =?utf-8?B?TkI3bWdSODh0WFZCOUNWOVZtYm5aV05ZVXVndXlrMktPNVRrb2FYN3dOUVgz?=
 =?utf-8?B?OFZSSDM5VmRsK0lRalVGMEZENmMrTS9FbThWWXNIV3NSWlNaaFBFZVhzNUNC?=
 =?utf-8?B?WnFLUVc4Vzd5MTl6MXJPV0RURjRJRTRMRStJamJRRE5ZZXR1M1FFdGZ6MFdn?=
 =?utf-8?B?RzJtVTRNNDJxNWtxL1puanRhcFYrUUc0NGsrMEw1WGwxOEMvVVU4ZWRDZnVn?=
 =?utf-8?B?ekc0VnNadVRCNGZvbVVsRXNnYUJMNXhJWmJZQzhQS3hjNTZoOHlhSmRLM0ZO?=
 =?utf-8?B?aW5jQXM0QVNZNnVVY2QwYWhveFRBaXZNTmlXbHdDbHpyY3pOWlV6WjJuMTgw?=
 =?utf-8?B?aXdYbXRwL0d1QmVwcnR1N0FOb241UXNOS1NyMERuN1VyWlo4N0tnMXJJVE9w?=
 =?utf-8?B?S3lqR0hhVElDK2hxbzdkKzkxRXJXc0xQV09YcVE5ZDhlam1IYXpaSnE2cXpI?=
 =?utf-8?B?Qm9TQ3I3OFd5c2xZWk5MR0xSOUR0Rmk3UXFMWlVBVjEvTGc3Qyt4S3IxUzZ6?=
 =?utf-8?B?ZndVSHNmTy9aMVR1dEhlWDdmbUNVck1Ud0tvb1NNaU9CWEdwNmF1cGozRGdD?=
 =?utf-8?B?NzBsemJ2WENSU0IveFViczhzU2lHaERNS1dTQWdVeUd2UjVqTHg0RHJDZG1L?=
 =?utf-8?B?dUFhVDU5MW9qa2d6Q1pYU2hyaFM2RUM0bmpGNnBlWmZtMzZaWERpc2JPbEd1?=
 =?utf-8?B?cFdTU2ZJWkZ0VUpVS1VUMGhLbmtMS3ViN0VZMUxHZFJwYXZEcmJiSG9MaUpu?=
 =?utf-8?B?aGtLUXNLWjY5Y25LNkJDL2tpWllrRm5XUmhqNWsrNC9WNnpPNVRnSk8ybFpz?=
 =?utf-8?B?M0s4dnRGOHZ3eTJ2Sk1YUEFWTmx2MHlXSEo4K1BaaDdXMnlIZVFkM3hXeTRz?=
 =?utf-8?B?cy96RmxLR3RvU0Rtak8xck5XenZUUkNiWjRnTjdiTGZlMExqck9YYWJLU0sx?=
 =?utf-8?B?OXU4SXF6Mmc3Y1p4U0hzd3lESTFzdm0vZmRzZjNKWEVWNmh0TVY0RmJUUlFx?=
 =?utf-8?B?SjQ0OTR4Ym1oN01QYnk3ZVo3UldFSHltVFo4TjJsOSs4YjM5ZHZxaVpBdFBz?=
 =?utf-8?B?NTBnYXBqd05yK1Y3NVN3NlJ6MVFqcmczdXJUWjgwTmIzaUhBclE3Nlpwbmlt?=
 =?utf-8?B?MHNmcm0xOFpnci96a0FiVlJBQUI2a2RQc2cxWkQwQTVUKzdhaElaY0x3NGQz?=
 =?utf-8?B?eERRTHZnVE9Uc3dYaG0rVlhoQmFoOGpYcVVGNmtHcXJLb1RkL1B0NVJhTmNp?=
 =?utf-8?B?WWdDcWtnTWl4WDRXenR5R2ZEc3k1MEJBcGRrcXcyOEhQWGd1VTlxRThIa01T?=
 =?utf-8?B?dXJ4THQzWWJMSDJyWGdJdko4RWcyOU5FZVN0U3Jxd3NSZ01pYy9IdUxCdVVr?=
 =?utf-8?B?TUFxbm9hRWM3U0ZOL3YrNERYdnlRckpBTHZ3T0RBUWt4Z3VCSndDaFNjelo2?=
 =?utf-8?Q?oGEzA5vTaIaO0CrE=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcd9f77c-fc49-438b-b1c3-08df285c6864
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 12:29:06.4495 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2eKLfn7J1OkRrh9DICQxAL97O1+MXDlYgcJZICgAqjsApphc77xLi+K/zcv0Tks2LpeyicdQerLQUaRlnzA4gPDoyrHLVrRR67ucCuD+Ciw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6065
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

On 10/7/26 03:03, Tom Rini wrote:
> On Wed, Sep 23, 2026 at 01:49:27PM +0200, Ludwig Nussel wrote:
> 
>> This patch series tries to improve dealing with FIT
>> (configuration-)signatures a bit:
>>    - make signatures work with QEMU. QEMU brings it's own device tree at
>>      a memory address. U-Boot expects public keys in it's own DT though.
>>      So merge both.
>>    - (optionally) enforce signatures so we can't accidentally boot
>>      unsigned fit images. Quite an easy oversight, esp when qemu
>>      previously didn't even use the built in DT.
>>    - make iminfo verify configuration signatures, not just image hashes
>>
>> - Note: commit 68e65953400 introduced forcing OF_OMIT_DTB which is
>>    incompatible with the intent of the qemu DT merging feature, ie merge
>>    built-in signature nodes into qemu's DT. To be sorted out at some
>>    point.
> 
> So this leads to a CI failure:
> https://git.u-boot-project.org/u-boot/u-boot/-/jobs/106655
> and I wonder if the merge of the device trees goes wrong, or does
> something unexpected, is why this test now fails?

Change in rebased code uncovered a bug in the test introduced by me. 
Working on it.

cu
Ludwig

-- 
Ludwig Nussel
Siemens AG
www.siemens.com
