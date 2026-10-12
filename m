Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E070CA9ED1
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 09:14:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 852E080CBA;
	Mon, 12 Oct 2026 09:14:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 37AVdT49lGVw; Mon, 12 Oct 2026 09:14:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7DBC980CBC
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791796458;
	b=MRZxGovG/5ajEqeVGWxG/yDqJNxZXyIrJu7BKjlhsSMohgMiCqYNy66eqYMmDKV4OR6A
	 1Vw/HrZ22A8TK2Fus5cjwPojL/V1gSZofcFRuBp6VkFMA50hNlHvnabNBwbcUEDnZf9Gb
	 +eoPVIrg1MbwUS4MmKwxyGUpnYsNOm9dutxS7F6FYuXrQBOH5SWdcZK81vBs3QeaXlx6a
	 n1tLlVPr6/PAi5hIPkFH0um/uY83GVOsu9zMCPP88ajDf9rR2/dlkFysG0HplcnJVHPbd
	 SQgyJBTkZuATmIY/27/+cH6ul0APNu7dY8etfpjKY4N6mUZ8RQH8ot2xBTa42X+tpZA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791796458;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=dIHRapDMMZZeeekcMx27hNLuk77dl+pSToNPlH/Su+8=;
	b=cqjkY9XHhI+H6EB7Stb6F2+41XAJUHld2qYsLGGnkrDnMIV1wjGkuODfDXRTtPAQXye+
	 LuXJqCzpZ/PsXL+sRA/PHuF/MYCP7Cww+r2aioYK+dY2bjvLF8xeRqNJV6xsj1V4ndnVE
	 47qxRNrEHGS/nSYFnJrGcEOsyJU3D36wGp0xSwxsZxDF1Gh66/zFmm9xHD0Y2nPYtcE8Y
	 GmVfEO+K1AJg5A+uXex2cGZx/fNeTdbw3FdpjJYwmlebWYD+hCngGhn1hhKl9p7FpJlv9
	 oBoJmZ/2+aLgYeQ/LSxa7y0Cut9YaMRnHMopqtVezs1vi3T4A7RNrtzVWmgAXrwxcAw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791796458;
	bh=dIHRapDMMZZeeekcMx27hNLuk77dl+pSToNPlH/Su+8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EkqO4omcjW4O7XUY4W4FajG97lwslp9bc2mtJTtWpLxmk0+B4855h/ckZsBI52rCf
	 +JKObYXu2GDz35b6eMbe8WjrSFBRxEbcu5RwCU+qGBT63imtmQdZieP0pRhC7at+dq
	 1y2w4dGCGU3pKUvBJ3h9SywOinXVZOVKn645KClJFe+qtq0i8a+/gToxBVbvF768/X
	 gLoEuFL8LrEIrBUFjuXqHzbGQJYCOtcov3DVI3qWy4xOrTHcBczSH+Y2wp2LvNE1da
	 VegG+nrwy7uyK0vgxksVgX6pZL6aj8pN8KuXuAxuUpoUM5+zyOKnon8V11IHeRG0af
	 rhojmMXYh2WPw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7DBC980CBC;
	Mon, 12 Oct 2026 09:14:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id B44FD179
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 09:14:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9A0AC4008A
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 09:14:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bGIeGvHzkPGj for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 09:14:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 385FF40024
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791796455;
 b=M+TaGszB8OoYUUUoaNvdeJUZ5ASGbk7xhoVhLUplU1mPwST2sh4A/QNXrvbuiT2qGE12
 8FlZNwbHkO8zIGusvv+HjGBabwGFbuPoo4oJpD+2cTSPNCk5AbkzWOyGiCQZrtH8XZDg+
 0Y5tRw2T3eXEP+T1VG9bt9q1OO36dybceqJeNxcHnI5i1/uzU8CMXgXIOQzbn0fDttx3S
 46yEMzLmkX1BGzyqW/9szCmEb/dSd6mBg70DSGrPQrRP2WUkp1VPyloeYFQZl205alvVP
 XJkQsUcdT4d9LLjqwEMOlC3yT+PGzwTY1eAF9QcfGJgKGuGT46lXqdP6jje6EwjM3mw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791796455;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:Cc:References:From:Content-Language:Autocrypt:
 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
 bh=dIHRapDMMZZeeekcMx27hNLuk77dl+pSToNPlH/Su+8=;
 b=eTwoPVDdogKsuK0T/evX0HScwAyH8UDgTQ9qIi7Px4uqKXG5BRk+cOvieStua+s/pKXR
 B51bJMNCTf0rZk+cmVMGO6K+/eDQmShxOfuRA7R97fkVvAXkA/g5tc8i2v6OeNz3jz1Pb
 7yoXRgLi4yiiAItsC2gTuyPSjZN/OZ9MHQQteiQK00ANWD6qJ1DoChvUdBIHzfTHKftly
 EbVRofSD+ob1VElSZhi+Z/+z0xRdu2mgJ4rVgEd3PFd9vnoauz9HOKetOZA0wIQXDTQo1
 4F2wgWMjj5FB75BVQWs/BkCNLdDnxmCyZJrVgZomzedY3QBoNIH8Nut6BL5QiiC09ig==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=siemens.com;
 dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256
 header.s=selector2 header.b="lJS/tRkQ"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c200::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::3;
 helo=du2pr03cu002.outbound.protection.outlook.com;
 envelope-from=jan.kiszka@siemens.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256
 header.s=selector2 header.b=lJS/tRkQ
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 385FF40024
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 09:14:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HA/npvODCOlit3X5wAC+ZtWnaLBA/Sbhk65qaj7GO7Smzl3AEhHQbcYvW7Vl4xTMtbpqedVEwFgnxJD+FHMoqJVFqZ+46NSLkgi891c3WfVrY+VjJBxKXz+W0RKH5g13ezBDHjvoYyoDFy5BQ6JQQSlo3uJDFsULIdtN6B1nOvEnnepzdJXnKOaZVXT3A4g+LmuKpnbL5OslZjnKVxojlUrZtvcJGn954/SUb0+KVXGK+3TbRdAvYSnT5qtYv+BL+V63oNFM0zOynkCZSTgXCu8H5mzf97knnmDDnDhAY7a+jgMHOoSTH6kIkIz9U1bQ/4WwSJ5GejAhTZzZ0qUSlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dIHRapDMMZZeeekcMx27hNLuk77dl+pSToNPlH/Su+8=;
 b=PnfulESnhl6MkI04w0ZsFoUyR2iX8qkmbvQOx1HLgsZqrMsGk9eYyZv8XaDw/7aO8UzBLjG3NMRVKXNrw7+GJfVAw9Va0k3aFmVbBwq7hCi82G73eRMGZx4GjiT5RpqZPfdPa8yuTzg6r0WtnzhICgZXgbxRHizqaPDUZ9JixfpGYmr6E7ACa9R+iiFTszNbAjQWxBsOW+QZhAzMpA/rtGTBpwLsCFC0QSv16ioy+hIaw9hm/rbhH8EBlH5n1DDPICKRZ2QK38WJquMcRyt3TYSbkgWvObqNzeZ65f/hDDm8FaAEt8guusHs7TpNzJ/DXL7zRWTH8+ODLVa2aStEDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dIHRapDMMZZeeekcMx27hNLuk77dl+pSToNPlH/Su+8=;
 b=lJS/tRkQHLOzzEWEBax/0iUIDedZzBgRB4vX1GnEQc/6c/S3F79TwnTfoapo16u5U7Bn2+qSVI23apuG6b1V16QlEgKhGZUcfepqSFMF7w3nUrR0dv8Ye5RnuMXKWbtGNgPpReA6tGoYOZMrjLCWu1EnVWAyrtCOiiTZhbZOPkBAGzOp6D8swr/SqaaVWxWUq3iW/Q3ZW5YfOlAsFliSOj6yDDutj7sPYozzN5uonv/hzko3ZtQja3/GYZH8OGeFuYQmNCX5MJ7Uz1A9QjVO/5YBneXtKVpS1Ty+LiYWf99+aLsFsPf24I2D6TBnm5ihsVGb8IQY1nNFmKGWrrymVA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by PAWPR10MB159781.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:3ba::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Mon, 12 Oct
 2026 09:14:07 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0496.020; Mon, 12 Oct 2026
 09:14:07 +0000
Message-ID: <41365552-6c51-4cd3-8899-0bb5c2907aeb@siemens.com>
Date: Mon, 12 Oct 2026 11:14:05 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] optee: do not announce RPMB from within a supplicant
 RPC
To: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Cc: u-boot@lists.u-boot-project.org, Jens Wiklander <jenswi@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20261011-upstream-optee_rpmb_b4-v1-0-7c63edca4b92@oss.qualcomm.com>
 <20261011-upstream-optee_rpmb_b4-v1-2-7c63edca4b92@oss.qualcomm.com>
 <77d8fc9b-ab0c-429d-a1e3-05e558188f45@siemens.com>
 <CAPzfCAbc6JQBz+VR0O72Zd7csNBSC-QSHtbnrHLL=E4g=ZKEAg@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <CAPzfCAbc6JQBz+VR0O72Zd7csNBSC-QSHtbnrHLL=E4g=ZKEAg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0155.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::15) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|PAWPR10MB159781:EE_
X-MS-Office365-Filtering-Correlation-Id: e8ea3e2e-0a3f-4e14-98fc-08df28412af9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|55112099003|6133799003|18002099003|22082099003|10067099003|3023799007|5023799004|11063799006|4143699003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: Lv41fx+4ZuNA1a5lhivAjCTEot6qTPp3p9vXnpGYrLplGH9T9riFQTXudFUggqhE6XMNWxiJoSduLLPbRJ8R0Emp9EmVw/HgqnK5sdp5i2GppUU4p+oCRmOu6rfeKkUjOhN4WvaQfxoQ/cnkXeZE8ZZGWY0syCLtqA4SSrmJbqWgJYbDWK7TKVjT9i+VXO8oyLn8rOzHB01+bxncKqI+aGON4FiafPoHZPBHbmUx3rGpk4Os4Ms2p3qsU5xrJtSG3AO92ds/3mycjjKd9iAczM7qnRxk4BwXFAsY5pZW85nmh/M9hlxnB33VmwZLhRf7EdBDGNwOufWd2QRC4uzb3rs+voewPPj8Q/Rauq/Uk4OctRqo+u3h2yb/cqn/XgvFB4XQsN+2ryrQ+l0UhmLplW+y4E3fYYyExvhjb/qgat4n/vF9UFwM0d1xINLTgkfuM5FZ5+D8K6+Ae5VT60+cE+Xy3X87M3vsA3AceN2gfdeLuiGha+Hx0l7xKnKP+VQzYho8hKvbccljAjTk+yCwXA/wmuq3JdRF3M9pDE1VMAF1KVawH0GM5TDFDxL2QZPiAZFRVWkJMsSQzHNq6OMfs+pHvCf6Gi9urnkZGOvhYuHTNpQbdxfJvhdt60Zd6iBkE+kfIsLudFme3MDKG6yWkoQDGwsq031WOtL9XXfB3oA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(55112099003)(6133799003)(18002099003)(22082099003)(10067099003)(3023799007)(5023799004)(11063799006)(4143699003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azZGYVN5VVBzN2g4VFhwY2UvZE5SeWJ3ekZCRkJzQVQrdFRCbDJPdmU0OWlo?=
 =?utf-8?B?QkFWRnIzZGx1dFFucFM2M3YwY0loRlAxUVNFYVJaZ1B6aTd2UDZ3cTlaMlJD?=
 =?utf-8?B?bGRsdlRFaVhDS3Q3cnlvbHpMbE4xRDM0eElxNGdaU2J6eHlpWUNqN2pHSW8v?=
 =?utf-8?B?OWx0VVFDUDBzSjRDbkJYMUNBZjFaVDEwQm9mNGhGd2Y3OTEyZlFNUzNxYXdU?=
 =?utf-8?B?cTV6TitodGJ2c255NHRSK3JwRlJLWjNjb2hyQmFCQUowOXRvT2pEWll5WVNs?=
 =?utf-8?B?VjA0ZEtVdDFFR3BTNkhQNGpKSHdMcE5Qa1FHdGJOV1NFeFVCRFJYSmRCRGpy?=
 =?utf-8?B?clZ6VDFUZUZ6OElLbnVmMk1qQ1pFZFhIM2laOWkrZFhiS0Y3L3lVdFFyMkwx?=
 =?utf-8?B?UXBFK1VFWEhOVGZaUlR0T0l0ZFFoUzV1TWNTSzk0cEs0dVZWMHhVUm43THdq?=
 =?utf-8?B?RGZuMVlFSEpySFNxaUtFdXdEOThjV25scG0rYWppbDJWMmlCOFhReWlnVk84?=
 =?utf-8?B?MnZjMlV2RU9OTUJXMjNDc0JldE56ZEVYeTVNaHYvMlppZDB6ZWFRQ01kZGlN?=
 =?utf-8?B?YUVHYmplZTIrUjU2c0Z4dzdSQzlzTW1idEZ4a01Vc1FwUVF4ak5WNXhWMGVy?=
 =?utf-8?B?Wlk1T2lRSjlHYVZmQjNCZGVpU1lZN0J1UnZicHdNM2hGNTU5b0dmc3luTkZY?=
 =?utf-8?B?R3pjb0VwQ1NRWEJ6SUVCQmNTYnBDUnUvODdOSnRRUmNKUmxvWmErRVdJK2pp?=
 =?utf-8?B?ZGkzVDh2WFRqcUxpeFpGMERJWWpyaXBpZFdja0daWEI3MXpzS0lBaEhrOXg1?=
 =?utf-8?B?Zy95cVkzZnRKdDZ6R1RBSEJ5TkRRK2VhdGJzcXdWbklkc3dORytDODRiajdz?=
 =?utf-8?B?dDNmVjlVYVF4N3gxZmZkZjBYN3lvNmFlV0dyckgwcmpoczg3RGYwbTg3WVMz?=
 =?utf-8?B?ZkZRc2VBUXYzWFN3WnQ3YTRoeERmaDZOWTBqQVA1NVMza245ZFIyVXpxSDc3?=
 =?utf-8?B?MmRlWXdXVkx6OXVJTjVYYVNuMHVOeTF5ZG82Wit3c0p1WGVLT2Y1S2NjQm13?=
 =?utf-8?B?RkdyelFHMmFIaHQ1NUhiQ3A3aEN2QklXUS9sL0VzamxrcGxRd1NjakVMQkZ2?=
 =?utf-8?B?Tlpkc0M4akEvZjdveHl3SWd1UDEyNktMNDVmRjNZTlVEVU90WC9hR2hLUGpu?=
 =?utf-8?B?eGxjNlhXUFRSYTYvTzhOS0lvMUNVeHZaeEFPV2xEMERHUC9Yc2tPS01oOW0z?=
 =?utf-8?B?Sk5ubzc3VkZ4VlRZQytRZWZtbmlpNWROOG5iODRDamxiaUNTUW9UZjVMeE5t?=
 =?utf-8?B?M0lrS2ZwcXg5UFVka3RpWDFEcFV3QURYN3NvS3NlQUJPQlZjdzV3eTgydVN4?=
 =?utf-8?B?Rit2VE9RdVEvT1lGck4yUUNtbjM4bHZ2RTBEVS8rUURIaFlBZ0FFSDRnMzdY?=
 =?utf-8?B?ZkpGSkF5aXd4NmMzdWZvYjZJT29EUGVEYmJEWEdLa20vSjRXa1hPSE1zcWZr?=
 =?utf-8?B?d2dQMDB6ZGRVU2d4dnlyNTc3eDlHV1RRL1hQTGhvenpucFF1MExDNjZrc1lx?=
 =?utf-8?B?MTltTWlqbVFpVHlMenNDU1huMjY4MHYvNGpROUFTaE95UGVtVjB4ZlJ4MFA5?=
 =?utf-8?B?T1V1U1hTNFk5QURzOU9iaG5CZ1k2ZnNmYm9LeFdIa0VzSkV2VU1mWkZlSjNY?=
 =?utf-8?B?ckpabTNIU3RhMlU4N3JTalRtUEJIM3p4OTAzSGpDTHJ1bDVkYXMyK0ZSUzdR?=
 =?utf-8?B?eHhnSllTSjkxT2xXV0tsUVMyU0pUTmZ2ZnZjSDNxWUhENFNXaGtBVVRNTFd5?=
 =?utf-8?B?OHM1a0doYThNQVVmSzJvUVVYWFg1dVVkR1JzY1hGRWZYbllGR05UeDZna1Jr?=
 =?utf-8?B?VFhCaExtSFZSUzB0N1dFUVV2aUVmR2k2NUYzeWZ5a2taMms4dzA1VUNseSsz?=
 =?utf-8?B?WFViSHIxejZ2Q002TlFITW5JVERZNzZlTi90WTdGcWFiTzNYNXl2SDRMOFJY?=
 =?utf-8?B?YVRjdGxNcms3OEFWTmpFWDdjQkdzTkpYQ0JKU01uMTJ2cFRqVWFTZDlveTBz?=
 =?utf-8?B?MEpETjJ4cUNyM2xINVhlSHpTbng2ZmJWU2dtRXVzbzdUV2o1RzNXSGVrWlJO?=
 =?utf-8?B?Wng4enpqRDY2aXdzeU1GMXVSRTJGTkd4eHAvWitEYW55YnRaTGIzT2Y4NHJ4?=
 =?utf-8?B?UWd1TlNCa1ZPdFVDNTY1Zkp4UmhMVllxbG54QThHY1JIN3cwemw5a0puSVhP?=
 =?utf-8?B?emM1REVOa0ZaUTZ2OUcxcUUveGhWNW9DWmcxY1N4ekh3OVdjZGJkZ2VlTHZx?=
 =?utf-8?B?dHpiaXpkM2dZS0ZPOG5Td0xPTkdCYUJQMVFmTTRpSDlERS9TWFpEQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8ea3e2e-0a3f-4e14-98fc-08df28412af9
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 09:14:06.9665 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A2oMW5tro4rUnmsMPAr9KsibyjPtyEtfRc3BbJaIeMtd6A5EIu6r2IYc8DtjCvaqs8jpjrE9ETPWjjp6gt4F5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB159781
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

On 12.10.26 10:10, Igor Opaniuk wrote:
> Hi Jan,
> 
> On Mon, Oct 12, 2026 at 7:42 AM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>
>> On 11.10.26 15:07, Igor Opaniuk wrote:
>>> mmc_init() calls optee_rpmb_available() once the card has been set up.
>>> When the first initialisation of the eMMC is triggered by the RPMB
>>> supplicant, that is while OP-TEE is blocked in an RPC and holds its RPMB
>>> mutex, the announcement opens a nested session and OP-TEE's second thread
>>> spins forever waiting for the mutex (U-Boot has no notification support
>>> to put it to sleep). This happens whenever a TA touches its RPMB secure
>>> storage before anything else in U-Boot has initialised the eMMC, for
>>> example a TA call issued from the shell right after reset.
>>>
>>
>> How do I trigger this exactly? I tried via StMM (env print -e), but that
>> didn't cause issues in my setup.
> 
> The first mmc_init() of the eMMC has to happen from inside the RPMB RPC,
> i.e. nothing in U-Boot may have initialised the card before a TA touches
> its RPMB storage. On QEMU virt (eMMC on sdhci-pci with an RPMB partition,
> OP-TEE 4.11.0-rc1, environment in pflash, no "mmc" command, no bootstd or
> EFI block device enumeration before) it is just:
> 
>   => optee_rpmb read_pvalue test
> 

Seems my setup lacks the AVB TA.

> right after reset, with CONFIG_CMD_OPTEE_RPMB (any TA that uses RPMB does
> it, this one talks to the AVB TA). With patch 1 alone U-Boot never comes
> back; with this patch it does. The OP-TEE log (with CFG_TEE_CORE_LOG_LEVEL=3)
> shows the sequence:
> 
>   D/TC:? 0 tee_ta_init_pseudo_ta_session:303 Lookup pseudo TA 023f8f1a-...
>   D/TC:? 0 legacy_rpmb_init:1219 Trying legacy RPMB init
>   D/TC:? 1 tee_ta_init_session_with_context:578 Re-open trusted
> service 7011a688-ddde-4053-a5a9-7b3c4ddf13b8
>   D/TC:? 1 do_notif:34 sleep thread 1 0xe9b3d570
>   D/TC:? 1 do_notif:42 sleep thread 1 res 0xffff0009
>   D/TC:? 1 do_notif:34 sleep thread 1 0xe9b3d570
>   D/TC:? 1 do_notif:42 sleep thread 1 res 0xffff0009
>   ...
> 
> Thread 0 opens the TA, tee_rpmb_fs takes rpmb_mutex for the RPMB init and
> issues the RPMB RPC. U-Boot's supplicant runs get_mmc() -> mmc_init(), and
> mmc_init() calls optee_rpmb_available(), which opens a session to
> device.pta (PTA_CMD_GET_DEVICES_RPMB) on OP-TEE's thread 1. device.pta
> runs tee_rpmb_reinit() and blocks on rpmb_mutex, held by thread 0, which
> is itself waiting for the RPC to return. Thread 1 then tries to sleep via
> the notification interface, U-Boot answers TEE_ERROR_NOT_IMPLEMENTED, and
> it spins (about a million iterations in the three minutes I let it run).
> 
> Your StMM test does not hit it because the eMMC is already initialised by
> the time StMM uses RPMB: the EFI subsystem probes the block devices before
> the variable store comes up, and an environment on MMC or any earlier
> "mmc" command has the same effect. The announcement then runs from a
> normal context, and the later RPC finds an initialised card.
> 
>>
>>> Track whether a supplicant RPC is being serviced and skip the
>>> announcement in that case: OP-TEE is using the RPMB already.
>>>
>>> Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
>>> ---
>>>  drivers/tee/optee/core.c          | 3 +++
>>>  drivers/tee/optee/optee_private.h | 2 ++
>>>  drivers/tee/optee/rpmb.c          | 9 +++++++++
>>>  3 files changed, 14 insertions(+)
>>>
>>> diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
>>> index a47c76811cd..b61f907a3ff 100644
>>> --- a/drivers/tee/optee/core.c
>>> +++ b/drivers/tee/optee/core.c
>>> @@ -424,6 +424,7 @@ static int from_msg_param(struct tee_param *params, uint num_params,
>>>  static void handle_rpc(struct udevice *dev, struct rpc_param *param,
>>>                      void *page_list)
>>>  {
>>> +     struct optee_private *priv = dev_get_priv(dev);
>>>       struct tee_shm *shm;
>>>
>>>       switch (OPTEE_SMC_RETURN_GET_RPC_FUNC(param->a0)) {
>>> @@ -450,7 +451,9 @@ static void handle_rpc(struct udevice *dev, struct rpc_param *param,
>>>               break;
>>>       case OPTEE_SMC_RPC_FUNC_CMD:
>>>               shm = reg_pair_to_ptr(param->a1, param->a2);
>>> +             priv->in_supplicant++;
>>>               optee_suppl_cmd(dev, shm, page_list);
>>> +             priv->in_supplicant--;
>>
>> Wouldn't it be enough to track this from rpmb_process_request? The
>> nesting issue is limited to RPMB requests, isn't it?
> 
> The deadlock is, yes: only the RPMB request is issued with rpmb_mutex
> held. I put the counter around the whole supplicant command because
> announcing RPMB from inside any RPC is pointless (OP-TEE is already
> running and will probe the device when it needs it), and because a nested
> session from an RPC occupies a second OP-TEE thread, which fails outright
> on a build with CFG_NUM_THREADS=1. A request that is not RPMB can also end
> up in mmc_init(): a LOAD_TA request served from a filesystem on the eMMC
> does exactly that, which I have in a follow-up. But I have no strong
> opinion; if you prefer the narrower scope I will move it into
> optee_suppl_cmd_rpmb() for v2.
> 

If not only RPMB requests could actually trigger this, then having it
over all commands is fine. I was just wondering where to place it best,
here or in some of the invoked functions.

But looking at optee_suppl_cmd(), though, I guess optee_suppl_cmd_rpmb()
is really the only one, no? At least it would look a bit nicer to do the
state tracing inside optee_suppl_cmd.

But if you have more requests on the list, I wonder how that will fit
into the picture. Maybe you can share the full set of changes to get the
full picture as well?

And what does the Linux kernel do to prevent such deadlocks?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
