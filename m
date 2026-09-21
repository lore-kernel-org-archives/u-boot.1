Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1B18C982ED
	for <u-boot@archiver.kernel.org>; Mon, 21 Sep 2026 12:54:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5A45D40782;
	Mon, 21 Sep 2026 12:54:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XhfOTBWl_TQe; Mon, 21 Sep 2026 12:54:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org B3A4D407C0
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789995255;
	b=a3KWGK4a7a9DV/xdY2bGyGIz/FQ0hoS3+hRef9F+aApGaqz07wtte9qO+HlWBjt+IOvy
	 UKBWSF1+dbvs+B975tuhHiktpkgwlXc4Dq+qPuCPZfGVjmjdYywe6JhWnxPyukUWYPraN
	 P+xKuCFGtQArLJ/hPYIIlgY5i54L3bqE2kgECtEt9BcYf4PwELRpx+r9Yj4GQxuDG+aHT
	 5X2yswsGmmSP36Y6mA+4AfMweAscFfBRLvOgVrz1oR/+VvrDK3eJIkh3cbmls8Ig38F83
	 jEiwFtbgdO5RUWOywMinWXcJCShD8xzBYR+IGIpj6gHxvGexEDvSLIkSxDSys/nc+Yg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789995255;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Wk0NBCEx7ZjuzwOyOvDZvBX9f7sIjzQ4VJnhykM4StE=;
	b=lQeJNcp5SDHpxN/NzPIkHEh+sMjPgmpGiSx7iEoJOWe1Vv7KOBgP3p1sRAopeTdMTQbI
	 qv30IBYniTF7HAK6I2OtmCp+sE6+8WUXRSoH307UZLueniH1Oy9HBd+VaBONa2gyVTz4i
	 liryOL7WAN78ZgSRf3qFn5pSTL/fJSWiWGVRMzXO7rJvAO+y6uuK0Fu1hMh2h9rfhWbwO
	 HGNax8isTzqJ4GJ43WwXUqm9KK0ZcuTmtJm6+5PUMZfVqqqOOy5B4A1C66D6nL83HSC3i
	 7ULvYzYgnJUdLGiIPKz7hey9ukOMhx0DnQ6HtONHOJx1Xg2FsVxRuIreLp6Gq0BKsAw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789995255;
	bh=Wk0NBCEx7ZjuzwOyOvDZvBX9f7sIjzQ4VJnhykM4StE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bdEutFuZ9nEf3gUc1JBSCWZsOh4QIh/zuo8UM+t9HMEO+cTAd+b6rYuvNUStAoLX1
	 cmbVI7KRjgZvnzU78+ey83DtWYgj3sPkAyV1SIg3ybEGpkaNNdBsAbklYSYFBr0kl3
	 S4DsCPH6T3ViQBLi3wd3l8g8egy0wnqACuOjqgH9xEeDQTu0eeGeF/1stoj0IBnln1
	 MMaGdQ/3HleHhjU5wVNRS1mUj1vynTTqncQQL8HhMKjqZtMzO6oHEWMHTDBM5+2gKm
	 duo3lcHUDVCoqOzDpo2wvUQGkx21y8LEEUKncrP+jYgacqRkacCQAvZPShlHf1hNJm
	 L0nm3NzCrjQQg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B3A4D407C0;
	Mon, 21 Sep 2026 12:54:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id C6429380
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 03:39:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B877740099
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 03:39:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v-_eZvfABa-5 for <u-boot@lists.u-boot-project.org>;
 Mon, 21 Sep 2026 03:39:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 1926040080
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c001::2"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789961970;
 b=Okx8HEx9ERQvIvMsGqBzqRhjwwk6Zbq2A3tUjD2nDoFV/3rJ2pM7i6qiLk20NO8QnXTz
 s8O5D8AUoJF0OjfaKKs/HgNWpNUPNlxwAJkGJujZf/ZX5OfCS71BAt5i0X9MpHyQAlCIg
 kmNllDYeYIEz9JQnfmSKQv9tKDFtRX+HjaAoqlNBA7F4tZcrteyUmE7jueJHrJJSKx4WO
 /mPQUpU/zZUwpLxkUbk8prC+P20x/vSDyeN63I/N6ApP5lnUGWzb5fJLgLLXP/EZ9BI3F
 RsPnsEZ/F6RtKIu/HHaon5FfxTnGzXtne6k0Vnf7fnWkQ4Gm5/hAmOAVBN+HYpp1ZAA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789961970;
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
 bh=Wk0NBCEx7ZjuzwOyOvDZvBX9f7sIjzQ4VJnhykM4StE=;
 b=mrBc3/sJmQt7f/if1hX5AynT5Elmslj25Kgo6zDqMtS0iAN1q6FaGqGCyezm6XF63LWh
 bZTO9h+1ePLlRh1NPc8IATSRIflAWZfZee3vicUeZEujjyiwP/J46nAe/IIhycACow6Qk
 Klfo5rVIZw7PC4J8nArRihgz1Vg84DwGwxM2K1x7KGqIU+HA2bL/MhOZIsPx1XERsmf0K
 CDEeWcusrW3UcMNcDUrFqGh6vyNBHop/vZto6uCxv2/2+uF9WCyYWlaxR1+PaYiDBJ4Sf
 QbEpmI4V9Oy+K7PCytWFt0xapHpP0/T00fQvjImYfF6p5mgPclShVqcSpL8OmpXldEA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=altera.com; 
 dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=uZbhDyJt; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c001::2"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c001::2;
 helo=sj2pr03cu001.outbound.protection.outlook.com;
 envelope-from=tze.yee.ng@altera.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=uZbhDyJt
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1926040080
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 03:39:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FAerw7MgSET67biQ7fyLJIGojM3C+bIv+aoX5GpGmZWelqKZoaZfuSFhNSwBe+JqN0V4WfCy2Uv+g3Ly3hBGvpknG64aWg+yXCNvlvGMgvCERPKUMz6qJE0KSEl9ZYb54uUnamHS6R0iKnSX6I8uFd5Jxst8crUaOdY8sPRDRjc+FYzfaB7Dr0iK9y07P4h+Us3KHtY0A5iuAcTwsOiyX/RS10YdwTnUlfJXVTL+Hbdch+51SD9sNUj5s+L9rOpONW2NIidjFSFmKP/0XnxKcJbH91JLz9y08lqrjHDL5Bjz+f9dwlnEFtcM6VLA4plXmKwP5+gNd8n/tIixKli4pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wk0NBCEx7ZjuzwOyOvDZvBX9f7sIjzQ4VJnhykM4StE=;
 b=jc1pOuigmLjUxcp/zU5JOwozj8KHWyd1Jy8Ou+adrEuNKQyJVnSX1BhmPOdcOop2wdxK/WMBGbWJF4KcIX3hUVkVd2mIV7Qk8JPubmYWFqTKKQ7nY1LDcrywyVwmRTeuqS+dHLxTavlpvfNQtCiHGLl8qi2e61H4mQef2mFJREVB8OdX4ySLqbWgqrR41G2til3QWxiTe4ILIRZTDfAaqjboBJUjhliQeCnjxBUS+XngLQCsrpw1bXJM71YYiE3D8DV6wiwPGElU0BXgBc/j7PBQzJ7V3wJTZsR2U51U3gDK38Axg1+Jo2NOYDMUYXD5ca0/VjdlkVZoyEoNlmar8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wk0NBCEx7ZjuzwOyOvDZvBX9f7sIjzQ4VJnhykM4StE=;
 b=uZbhDyJtAyaNuiE6Wq337xcizu6bEtkc1R8nqu6ipUCgFhnpMitoqQA4W/fD7URg/h2vMHCW9wihQNwaG6cN5WaYFEAzE4XXTZoWdVlPfyq1fdAxbLuWp6W4CDzaiL0xcdGmqz11RJOuM+giowxX1QAabspLuws/pBg9tMICkT0+Ux69xaAc4pe1ibHAQUWBl2v8Um9hu9lamwvUCDkM0B+s5+HDAAdGK3EVZ6HxnDkyecYZBnYnw7653zMtCkP/VOvPClVtDKZRvt5rE7ZC6KPnysgT+NHZInEaDFkdkpZD+T5EDeUqHFAR1W0VgsBi+4KVPZzW5/sYXv/K9FyIxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com (2603:10b6:a03:2d3::20)
 by LV4PR03MB8260.namprd03.prod.outlook.com (2603:10b6:408:2da::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 03:39:26 +0000
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01]) by SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01%5]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 03:39:26 +0000
Message-ID: <00b30cf7-0d27-47e1-a8ef-3414ada0aee4@altera.com>
Date: Mon, 21 Sep 2026 11:39:17 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] mmc: sdhci-cadence6: use const PHY config tables with
 per-call overrides
To: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>, u-boot@lists.denx.de
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>, Marek Vasut
 <marek.vasut+socfpga@mailbox.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org, Chen Huei Lok <chen.huei.lok@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
References: <cover.1787710268.git.tze.yee.ng@altera.com>
 <7431866da9cda49057125df1b28986f04d63e168.1787710268.git.tze.yee.ng@altera.com>
 <36b56284-0b29-4830-9eaf-9b594cedf8d8@altera.com>
Content-Language: en-US
From: "NG, TZE YEE" <tze.yee.ng@altera.com>
In-Reply-To: <36b56284-0b29-4830-9eaf-9b594cedf8d8@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI3PR03CA0010.apcprd03.prod.outlook.com
 (2603:1096:4:297::7) To SJ0PR03MB5950.namprd03.prod.outlook.com
 (2603:10b6:a03:2d3::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5950:EE_|LV4PR03MB8260:EE_
X-MS-Office365-Filtering-Correlation-Id: abf75dad-744f-4e9a-acaf-08df1791ee76
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|10067099003|56012099006|3023799007|6133799003|55112099003|22082099003|18002099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: osYLtiw6vZ2llw/tJ/ISYYQAfG1pJpe87gpLQrC8MnV9TrnA7IggdixrcahQf16eDABCdgtmDunl+GUtr3jzKBTsGMm1tZKxu3Tp3Zcio23T+ESG8UGsMSAnGaBhZFBKNMPU57Rz6M6wW3qp0o88pW8wJYWK2CNwQImhB+1X9gemcJobJ69rA4nqlu3ek/ICSLNMJHNXp6Esd6+27ziR9v9JCPzkjGbkV9tmqd7bN9KuIloWTq9zYPV9XSvZzx8E6SegGQGklt7FDXUZjBP05R5uH0zOrNeAPV+eq4SouYsdcsi+s8nZCwH9MPyK4oyEVM/tOTxU3C0Cpy6nWS8n0xgBT6xhyUIovAZLuhHlrLBkfWrZrFrDtiz3yFn0OOB1jz9JvQx1TvoI82RYvGZcNN6w9CSeMLxVxghnnOvxMvBzwDK9yJG4fzTY5loIJVbVApafHSh3ND9fKHfgIvBwUhZ1/UBNBbC199lUqV+m8QHcIeXGnNoXxtaVIuyImdt9meWrorROatbF/6RAwqktVZa6HOLgaz2rB4zKTcZ4Nr2A5CWqRm/Jtmq91IE+AA2MJHm4sfhdRSBJPw9H7iv/M8UxOQuXmdW76UlEHpbrIRg617zEYyMAoFtXjn+pzFNQ/REHs5aMIaeySwJ2I34R8g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR03MB5950.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(56012099006)(3023799007)(6133799003)(55112099003)(22082099003)(18002099003)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2V0NmNNejl4TTdyZzBvSXgrS0hkdGZKZDhMUWxTOUFVOTRyT0ZzUFNSS1lW?=
 =?utf-8?B?Z1ZGZi9BNGRXUS9Ma1dBa1hialRBSDg0N3FWM1dYdHpzdWhkZGcvenh3VnhM?=
 =?utf-8?B?cEptMVA5ZE9wN1p3SDQ4MHU5dU9MYnh4QnBQSVhiT2lTY0VPVTRPMDAzWlBI?=
 =?utf-8?B?eWpvdkw0azRKK2FNdG4xQ2xnRlQ5Z0RmN3hzM3hZRWJOdVpDMk1ucGRpS21o?=
 =?utf-8?B?b3NhWkpvMUpRMHZCMkd3SFNrdUtTQVdMbk1HR1gxRmlkNkdXeG9NZ0tGTDBo?=
 =?utf-8?B?UTRBdEpqQ2U0amFSenNqWmZjVGhMRjZ6Q3NiaTk3SElUTTloenV2QjM2Q3da?=
 =?utf-8?B?Rzl0ZkpydnJjaGd6dkhVOTQyQUoyTHFYeWIyUmFmQ2VXcFIrREtTRDNwUlg3?=
 =?utf-8?B?bDFpZmZKZEU2ejlGeUppeUM1V1VUVlV2Y0UzVWkyVUZyWVFKL1k2Mnkzd3Ro?=
 =?utf-8?B?ekdaTGppVnhSL0MyQlp6NFJBL3JPK0VlSjBJamduM056N1NHMnJHWDZKOWs4?=
 =?utf-8?B?MW9GU3UxSStHZ0Y2VTl0RDBlVXFtSGdBRlNiSWxMdlRsK3lFTmtKVnFITHNj?=
 =?utf-8?B?dnF4SjFsTzdMT3dyMXM5Y2EyTDVib0F3Y1RyTVI0Lzh3Tmw0NTBXMEhMUzc5?=
 =?utf-8?B?RHhBdGZycnpZa3hpN0xxTHhvY3M3M1BuSFZzSkRCNmt0Wkx5enRvRnJNWVJF?=
 =?utf-8?B?aEpnLzAvWVRBZkVYeDZZNWlSYy9Mc3dWWkF6QnhDVVZGK3QwZ01IMWpDQmRk?=
 =?utf-8?B?MSt6Y1NwTlpuQkVxRU9XSWhEeXR2eGlEalI0S29nWnZjeXZoaFphazM2Z2ZQ?=
 =?utf-8?B?VGlScVVjTkEwQlVOazFQOVhFOVhJR0RGdkdjTzE4UW1kMEF3NkhzaFhMRGVv?=
 =?utf-8?B?SytNdHpZenRObk1zSU5nRU5MT1g2eVNpSllNWDFiWE92YmpOYjZaNUFNWW5O?=
 =?utf-8?B?T0hBY2hWdnNwNFN1S3RYRlBvNUJEc3MrckdUb2JFdnlPcHJ3amJHczlRTDJj?=
 =?utf-8?B?d1NNNGw0czJ2Y3N6UnhENVpOMnU5Vk5LSE1nblpONngwaFRWS2xmMVRUckpR?=
 =?utf-8?B?elp5VEtVdlhaSVlKQXoySkxxSERzcXFuZW9FUDJkV3RPUlFFMTRua0NMUk9s?=
 =?utf-8?B?SHV3NlZHMllmUytnRnRCMHI2Y1psWVc5S2wrNDhtNEZkUWpmVWNQeGdObnpm?=
 =?utf-8?B?TndFREI4OWgzRm15TzJwYzlyN2hjeC9QUFpIL1VoM3RYYWNMSExaSVVva2d1?=
 =?utf-8?B?YVZQMnJjVEhiaWRCSFl2MHJSbXBJamFCQXlBdEpPV3A3TFNRK2g0cy9NSXY0?=
 =?utf-8?B?SDkrOENtaUFMVTAvZDRnb1gwdFBWZWF0bWZnUW1wb2Fnd3g5Z1c4bkN1ZFRk?=
 =?utf-8?B?THBnSGdPU0RaazVtcEpRWkRkajNUTWs2WUJZL3BkOEl0Rk1neHN1OGVJQ0ho?=
 =?utf-8?B?d3VHVkszV25WelZ2TDV2RVBTTWMxWkpQaFlma2JDTXR3dU5OK3VMclRqSmNk?=
 =?utf-8?B?OWVreHFBeVl1R1dKVG5NcmMwOFN2RWVJV2IvdnB1VzcvK1dTOUppdi9CRVFp?=
 =?utf-8?B?eDJaQ09ISjFBWjRraWZBL0hsYlRyL1YzRVVuUHdqQVo4OVp3M0RzTEJNVEkw?=
 =?utf-8?B?aDhLWGxhc1ZPL254VVZqWXNOWjZ2WWVEVWs2K1VnRWFhTkljYUlqd0ErTTV4?=
 =?utf-8?B?bkhIUVE0QzdIQ3h5bjJURlRTbXJWOVdVanhVQUFqVXFZZ09wVHdGbG5WbjRz?=
 =?utf-8?B?Njl4NjVwdHkzMlExWU9YbkExcjhncGJDR1V6Z0VybmUvazA3TXFsSys5U0ND?=
 =?utf-8?B?N01RZEw0UlVDRnRUWGxGb214bXFDeHQ2RFlYRG9uYnE5QjF2eEtJUmEwYzZi?=
 =?utf-8?B?UHdoc0RzK1dudzFVOWJTeVVTMkNxZVpOOTJiMFRNWi9nR1FlaUtMclQxdnNx?=
 =?utf-8?B?aVAyeUFPQitudzcyV3pGdkYvR0E2YXNsMVdPRUNVUHoranJLMXhpZWpXaisr?=
 =?utf-8?B?UHNDR0ttQ2M0OTRka3AxZk13L25GT3hVeHNpOHY2V2xzYUZUMmxtMXU2QlZt?=
 =?utf-8?B?SUVNSldFWm9Id04yRUZaczZEMXZFcmJJL2dNN1p5eFJ2K1NEQ3RaT0VkTkM4?=
 =?utf-8?B?N3BNY2F6RjdvNnU4bGxsVDFRUWM1UDI2ajhTaFg0NHY4YkVzT2tRU2dXNHFU?=
 =?utf-8?B?QXZWWUVML0l1bDRZM0hxMXdHTVlQbFl3d1pBMndTdFdIaU14SHZCcmRXRDli?=
 =?utf-8?B?eHUrSzEzd3RJaDUrVi84dXJxUkY2OGpPR1BWbWQyRUxjZU9qTHMxcmJpeGZE?=
 =?utf-8?B?WDVIamZPVFMzNUpGMEtSMk41WFVJQ1NLTlRjZHBHd1lnZ05HOWJuUT09?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abf75dad-744f-4e9a-acaf-08df1791ee76
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5950.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 03:39:25.9771 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oDvwK4aRAlusse/mYCbVpn4cReMieQE1ZZGxjvvXJvAh+6BHxzyS0SvmLsf5TGBaszh0aZHujzrMDXltN9GaNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV4PR03MB8260
X-Mailman-Approved-At: Mon, 21 Sep 2026 12:54:14 +0000
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



On 13/9/2026 4:26 am, Kathpalia, Tanmay wrote:
> 
> On 26-08-2026 08:23, tze.yee.ng@altera.com wrote:
>> From: Tze Yee Ng <tze.yee.ng@altera.com>
>>
>> The per-mode PHY and controller configuration arrays are static globals
>> shared across all SD6HC instances. sdhci_cdns6_phy_adj() read device
>> tree overrides directly into these tables, so DT-derived values could
>> leak between controllers, and a missing DT property on one controller
>> would silently reuse a value programmed for another.
>>
>> Mark the configuration tables const and copy the selected defaults into
>> per-call local storage before applying any device tree overrides, so the
>> shared defaults are never mutated
>>
>> Signed-off-by: Tze Yee Ng <tze.yee.ng@altera.com>
> This patch does not apply on current main. Please rebase and resend.

Hi Tanmay,

Thanks for review. I will rebase on current main and submit as v2.
