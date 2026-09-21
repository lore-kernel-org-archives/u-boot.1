Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31AF7C982E1
	for <u-boot@archiver.kernel.org>; Mon, 21 Sep 2026 11:26:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D08DB606F8;
	Mon, 21 Sep 2026 11:26:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TSpsyKIQ9Rlr; Mon, 21 Sep 2026 11:26:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 193B7606F2
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789989989;
	b=LlxHklayG6+HCRdb/2v67U0YX1i3/wq8h6eMttZFe2AOYdv9VANWg4gw+Lo+xxl8dW9l
	 zxuFMCRXYSK3mBR8DyTfIshmRgpD8PcSUh4n5akwKnfcsbE3D+JXnHiEBXoKV4/85l/Wv
	 4PyhylB7j4nueM4rbSVBAJ47GJeeZ7r06Xa6wvlwdgJh6MqPPq840b3Ew7mIvs1ZcPGb4
	 lrF00enq/iqApaYv22oW5gMrRYoeeZQp70W/qXsJuS4Wa1KFF01yr+wPlumUdMwSZnTlV
	 qSDyLkdQDHaHkFMgnC4fsin7jX44tTH99v8slI+gZyYm6+6TtWCO0TuokdnrRk6ENCg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789989989;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
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
	bh=pHOYGVZ4TcSrafpCA7nGexbHa9DeDRSlI77mxyzA4Ng=;
	b=l9Zb//VDs/ynyh3JzK2tNXXEmoiFyePqPclaaevux3k/ZWS3HiYG37P/Ma6Jrl0A9sIL
	 RRGYfBTQVpYT2mpnK1rhggDOuPwNWgJBm/GR9Hm8F/rtyVcruDcwPrVEl0ohpaBVZOu4D
	 JINi3aDuAUV6Dkl6GlWEDbx0z0zOSeT0sC953fVql0MM3EU8wZDpHjpBeY+zWUTkAB0bk
	 UTaPivLTYfg3riJlH2Is5RGn8/3IasqiACIps2sk91mE2SDwa9I7GnRXFjF6y19Iw1LSp
	 z4ps4hlzVkj/RxTvEafaMIHwnShGCUlrCuI5okPNt9/ccFK78YTTB7DBeRD3PWMQl4g==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789989989;
	bh=pHOYGVZ4TcSrafpCA7nGexbHa9DeDRSlI77mxyzA4Ng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=leY4OCybGJbVugVciT1z7IoJ42hIaAj0zaR4Jl+s3nqoAxPD57UtBrSZ+8WvTrtCK
	 kt/UO0lGKTwWD2W1FCOdw85L4f6vmuZN1GRqZsckC3IfE6s9WRoUa3VGNgxd7TpMga
	 V7v4zmu1CQeun5emgO/0LwrNBCKW9w1UPbY2Xt7T7mldadGUQ94xh4YuC+eLIl+LTD
	 7bo6E85Sd0DvuwhtgUWzjV9I5u7WfszmTTvGMmpMhJdNXWUbLEYJNvxpzld3+uqDGE
	 QGQcOpzwlNy5ITB7OQIEqMsX55mp19jZUbV4h6D8T/WmViHYP39qhIaSXDno2KsE0o
	 1KxuKShN2a40w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 193B7606F2;
	Mon, 21 Sep 2026 11:26:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5176B12C
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 11:26:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 37FFE40CB4
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 11:26:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HzNTQS1yxezC for <u-boot@lists.u-boot-project.org>;
 Mon, 21 Sep 2026 11:26:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 47C3840A24
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::5"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789989984;
 b=gl0Gw1bvXeGkFdOKmL5yy+ZFELeS+3cFBe6T9UkomF9UHx7+FivzktEfaQVBiP0t9pPh
 QxizxTX8nsLGdtm//CNmf9B/NQarGEYLEdjU3vk6A98xu0gEGH63z8gPIjcj8/yfD+tbV
 tgFMJVWBbVqX+gLBT8hgw9Y63hGWFPtzC0cjH4lJinYfRJL69KBBnW9prkxgDHI1K6cmQ
 fm5GaFBW+I/EsfLDhQkKBzS9tZDY3o7MXqoCTd9Qg4NmldQi6CLwzxLFDJ/YkSQzklGrG
 vdMjXTHnDlogepySlAWWt+Wlc5aqZb14rW+0NvzP3d9lJJa+2Hpa7FlzEuM+dWvWwqw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789989984;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:
 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
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
 bh=pHOYGVZ4TcSrafpCA7nGexbHa9DeDRSlI77mxyzA4Ng=;
 b=gQqQLUgvOe285h/2u4t0I9yVc+adHcnsVeRIg8bOIaY341R3cQREBP93ai8f91LQgGet
 Ho7f6d/5f5SKrNNDotWzL5ZlP2lrlNl6VRGbvPYb9TBvQmgXeMFwJcp9yO7V65xlHnagO
 uDfaJdxG2RSCy2ihih6w3gNP6JPn6oY/LKDBTyZ7yAsqysCgNUiQRHAa2Z2Pmx6Dlfkpk
 kwv8HeF+J7O/oNbAJ5Zfif+yfsU9Vb2CmKe58lFzCFuTXuFQg1ZW2jGt9SrWWgxyE1ddA
 Mu1FBmCRCWYAfHNn1KmJe59SelgT5MeOcO/1fFQWxv25gGzE266xLTrL4RFI9d6++gg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=prevas.dk; 
 dkim=pass header.d=prevas.dk header.i=@prevas.dk header.a=rsa-sha256
 header.s=selector1 header.b=eFXoS+xB; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c200::5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::5;
 helo=duzpr83cu001.outbound.protection.outlook.com;
 envelope-from=rasmus.villemoes@prevas.dk; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=prevas.dk header.i=@prevas.dk header.a=rsa-sha256
 header.s=selector1 header.b=eFXoS+xB
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 47C3840A24
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 11:26:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FyhTzNH6FC8gKyXx14f8YTwcENJRRn4cJsAvFIsrN8U5vh27ppdzyEBMBRGigvV3WaCTVLgi8zzdInKgV1ESEGxhbIRmfUeOBgjZv2LRh2iByeOco/Qmynyg8oYVtaC0RynQQ//I6intDlbYWMYE3flRZJQGhmvNcz/8ovgzgRTjpfjUFk8iQ+vO5VThU+YrrM+BA9rrEgBIBM2lVHY9hx2MV9wZk7llJwJlCvCWOj/KV9bV8lUDcM8GhzFR1SgWsTEsCwX8Se1FWxRXAqlV25D9uksl41oFPtqDGolNmhiAjB7YdpSPtUarclG4wE58Mhi/CxxSf+IGFX6auj4unQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pHOYGVZ4TcSrafpCA7nGexbHa9DeDRSlI77mxyzA4Ng=;
 b=wwMku8KhLgc7FlfsqztxuA+Ekd8YCr0xd9r9QGyrG1pHBjjBOxhSP1fqLwOwNFHIZeWI1gK/vCmvZFhp7qkgRo8hY/WZm2TviJFycY2vwGC+/ClUNL0HK7Rg0n8nf9y8LvI/U/jHfrdZWi6zEgtBtOye1BEKeUfi6Oek+A1RNqZ7TPl7c+SB4Hal2e/fG9pC2pNyl2GwgmlcB0v6PMJh/S+RSFzJG/+n20Tn8RDVK5Rr03+qJu7oEAXprL+fuAReqAO6e6DStZISOlF1xvwIV3eS+IYckSGpawsEkyUH2R4bwx0QL+B3PutTEcbluIJ+XLLviA7eglLKGDYKjIY6vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pHOYGVZ4TcSrafpCA7nGexbHa9DeDRSlI77mxyzA4Ng=;
 b=eFXoS+xB5KxIg82xnzUlnJE4YRuZ1jVMDMTdDA1tVPOUpPVLw1EjypKbNrg5Junzkz2MAheNZ/RZqnZ/3Mi0O5crwbqqIus6YF0JoylCv04y7Tzv3MmF/JbJZPezTF9at8UZXQ5QD0Y2gPiPSae+QdEY0ZjWMwU5ZYbXKae1fXo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by PAVPR10MB6863.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:323::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 11:26:14 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%5]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 11:26:14 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.u-boot-project.org
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH v3 2/5] optee_ta_avb.h: add TA_AVB_CMD_READ_PERSIST_VALUE2
 define
Date: Mon, 21 Sep 2026 13:26:04 +0200
Message-ID: <20260921112607.1562189-3-ravi@prevas.dk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921112607.1562189-1-ravi@prevas.dk>
References: <20260921112607.1562189-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0037.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::27) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|PAVPR10MB6863:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dd570fa-0845-4c15-2872-08df17d32525
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|22082099003|18002099003|56012099006|11063799006|10067099003|3023799007;
X-Microsoft-Antispam-Message-Info: c7ADQBoVt3uXEwOcRcKCk2EGBCplXDUA+EkvW4zFhlCO5J2HhcvHLOjQwOCj50jXwM6ynC4AmIrYSl2TKjoJdKsydRW9+zgPt1SrCN9sQ4l5INE4bPAAEhSzWbWhoNPNq8UDJXbUu8nDnXpHN9tTMEIUXReG77zRPsWdGrvNw6xKlHK/iMFjXkuzZzrCPmvU9jFM840zwF7VmwEoSOtvyrqe0ffYNPieJH20QfuJunnC1LGyNwNFMi13giTxFHVUNwYVNX9VKWVaqMLaRIaRdn+doDt9jyODArSiArvWRPPXHB5IytDP1MdYP4vabNxYjiRlTSKX9tjWMfKWOtosevCUZ2bFeqg+f6Xx79KL/C6lX6cJM1dM+bg78HaLbJmwAmkn2M4igSFbYo0SaZcg/LtmgEnWZ29gaabMJ9JS2wF/kkPSlNJcHUS7G0fNNMKaf/JdjfVaGgdrCqPnUeqSGuraRe0MtApWkMNeEYg60fVxYfUWVQYgLRrBXr2NFnwW0ug/ss5KRruAnh97wD4aPprDZaIJdqpK8U1hIER1BUw5gv+spBoLGv/6k1dw3EZ4llAZkSzMgkha4/OT7plM+YV9hqmm4aHFnKNx473MJ1cWaRMNFPVT5tFHMei5fXJbW1a/AJWxvxcHMcgPRZvfURfOyjgLc7XVwb3FBsGYwPY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VSNqDzSCrAgAGjQc5unUTaWSqwhQzO+DlzzC+jignVFhVKTvKnr9jgf8UbF+?=
 =?us-ascii?Q?La8JOkVGIGlCEncHzrVjM+8k/fOv1cKaeNiFUWqlTYuqGZC32Uwb8zWkTcqx?=
 =?us-ascii?Q?W6U6KEj7fGUSp2z+a7r3c1D5c4G2kt784Ubgt3D3O0miUvdu5oVi02C0dX91?=
 =?us-ascii?Q?5rEXmi74P3Uk+pRFKZ2TnjkxRoVg8RPJKHPK9cxD4AWuVPUMnMAdAU+fK5wA?=
 =?us-ascii?Q?6hfM2AvihFe+IBel8OuMwlqBEBSSLr3uuH2uWm8kzfVvvUVSJeZ+Bq+3DQlR?=
 =?us-ascii?Q?A2yo/46VHfSF/1ntLKMvjTd0dabd9LteZZIaanylo704vxD+eB2cZL3F6jQl?=
 =?us-ascii?Q?qbL5VTgtvsDId6CR9OalaNweKOimVRlKwpt2Shja7wweQ3dnmGkWfpNypOSD?=
 =?us-ascii?Q?03Y8oTYRSBlZiSjO9CK1cde5C/S7mqy5JAVgyhm9tBJ3kZ17lOZnXfdo4NMa?=
 =?us-ascii?Q?bjhhJbtr2fwXxTiFQGg803fyznZQa226c7UfBj7mwKlg+5q7QLxjNlRVaPLa?=
 =?us-ascii?Q?iQ9xYSpyk2IkN4QSLIvbU+iCdSbAj5vQeN3v3cFwX2fPpjPl78JoMD91roIz?=
 =?us-ascii?Q?AE3qbBG7jNHDy26vlHf192T+SGw6VpXYpozGeqquvpu1IzmyVGXSeyRU7DcV?=
 =?us-ascii?Q?hgrPbpznOLfU0GeStIx3MmpyIY8I+OzDwxfKSfh71N5ZOsv9YIxYC/+plIZ2?=
 =?us-ascii?Q?M6bJIGJwg1lmlq8jIGW9iLjAzWQYhSXLnigSM03MT/RRyoyEoB+T1ypTvkHP?=
 =?us-ascii?Q?28kQB1Erz7PB4O1MxbmqvY0z26n9klCux+DSNjv1N9lSgnPILAMBFQ2PiDlJ?=
 =?us-ascii?Q?aDPtKihjDGoYmRjQ99RvhlsJV2ofDjCAftOqBDIc/5d9EhpN1IhC1iQBdbP4?=
 =?us-ascii?Q?dg5/nd3ulE6WAGwOc7dvcX7BJb0EENQ35krN6ZTilNLDMD1vF5hHg5ou02ov?=
 =?us-ascii?Q?xaGQ9eZqTJBJgBAZ6YR4ypNragUwZerriIWfbkB8oWCXRHO6yYLZJgkTWi7w?=
 =?us-ascii?Q?h1oz+gA6jmzLnlXWczK881ayJw3MSV36yA5G0AtBnQUCtNSmIbNpI1OZDo4e?=
 =?us-ascii?Q?KMBs74rLWX7ZD1UmrnvyShJ1r1rEnlfm6UiDHAJoWNdsLl0RU9VIUa/yEb67?=
 =?us-ascii?Q?c5lm4jEUTZ6ZxcpP8K1PIDiATCWvrfaPLMf70kgh7/jyG47dsa3a9CIlIJVh?=
 =?us-ascii?Q?ZntzoGhXybL3docA98vJBDMoEhreFgxyZR3/0VOHkugknmreEX667mchmqo/?=
 =?us-ascii?Q?LCJ+bIaHTcE6wUnLzvm6zHLwHmO/zDbrPZ79aRzQvne4UUs+TDw/xn24q2mp?=
 =?us-ascii?Q?0o+GU28vtNY3aXlLyiEJtxXvwbRfloEG3cLCoa0gkX0YPKi8gqGEOoad3ZlT?=
 =?us-ascii?Q?z1pSKlpEOUvGJH7k4/RAHeCl4zaHi3KPa9ESPMfwoU0oLlGWgMHyhVtKr+OX?=
 =?us-ascii?Q?MwyfTO/7bDWPj3fsX13H4FRlw6/lwBl1hbJQ9kgStKBggb5rOd1CBY6tv6mD?=
 =?us-ascii?Q?8pxdElfyf33eU1yBzisCQGWy34AsaFSMHoFPa0FxbZju/ewpf4wukGvJObfM?=
 =?us-ascii?Q?RcbY6NUFO1T+YmTE1ftGfZqSd6GQKCQ1bxnCocGnCvOJEYzHpGXa2nUr5xyF?=
 =?us-ascii?Q?iBF+ODYFrFyTtQtca2fFGJYdP58WUTGSYKgzQd4F0LgHiZwUBSBrU7pnmKTG?=
 =?us-ascii?Q?yO/CXa3M06yMe9yz8sRWhpB3PCwcoO8P9uRilZCGa9G1x3cD53qoAbh0iRQt?=
 =?us-ascii?Q?hpRHrV98MJx3dRaK1vr6NSaB9GPmHgI=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dd570fa-0845-4c15-2872-08df17d32525
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 11:26:14.0110 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vERybEEH70iyWIjCms7GEHGW794SPydekBqWqaEr5UCny4EvwjKew4G8seoiTpdR3/hg9jaJ9DeajUsAqqGZUTr7GRL17fnHnSHxZx7XYlQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB6863
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

Add the new TA_AVB_CMD_READ_PERSIST_VALUE2 definition, and synchronize
the comment for the existing TA_AVB_CMD_READ_PERSIST_VALUE with
optee-os' ta/avb/include/ta_avb.h.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 include/tee/optee_ta_avb.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/tee/optee_ta_avb.h b/include/tee/optee_ta_avb.h
index 949875a64cb..d8db6d257bc 100644
--- a/include/tee/optee_ta_avb.h
+++ b/include/tee/optee_ta_avb.h
@@ -47,6 +47,7 @@
 
 /*
  * Reads a persistent value corresponding to the given name.
+ * Only reads as much of the value as will fit in the provided buffer.
  *
  * in	params[0].u.memref:	persistent value name
  * out	params[1].u.memref:	read persistent value buffer
@@ -61,4 +62,15 @@
  */
 #define TA_AVB_CMD_WRITE_PERSIST_VALUE	5
 
+/*
+ * Reads a persistent value corresponding to the given name.
+ * If the provided buffer is smaller than the value, returns
+ * TEE_ERROR_SHORT_BUFFER and sets the output buffer size to the true
+ * size of the value.
+ *
+ * in	params[0].memref:	persistent value name
+ * out	params[1].memref:	read persistent value buffer
+ */
+#define TA_AVB_CMD_READ_PERSIST_VALUE2	6
+
 #endif /* __TA_AVB_H */
-- 
2.55.0

