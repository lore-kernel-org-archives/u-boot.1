Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFD07C982D6
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 15:24:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9CC3C60B18;
	Thu, 17 Sep 2026 15:24:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7KFrDeMDIKz1; Thu, 17 Sep 2026 15:24:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org CE6F460874
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789658651;
	b=G69IBnn95QYr3WJ1UuJvh25h//sN8hj5HbR5IlUFesN80VcXUWxGiLNgGL1WNRfIC7fJ
	 Yfl5qjPHregenVvmTun/6H2r5XTG8pUugNzaTUl3vdx52Iz6k41MJ3IMMsEHgN+sLhxDC
	 FYzXTYD3zz82/0tQQExCiub2gVCrx/2R/Y6jeagPJzQgrNWp4wqeHpo4PWAoQFYvTVDK5
	 gK2Xq0SSrj/ZECJxAnfAhp9iEkiAdWa871but6QiHW8o3tH8c5AxF3PA2w4n9ojSEgVlR
	 6u/shXpyVPwWGvH6iWOPGYBkO9UjtA8bTwQ9rcq4ZbXnLYsybFGZcfAnWtmjhc1Plbg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789658651;
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
	bh=2PmxJ6WnrlMj6EBjkhYPh4HUD/i3E8Sv+GHJNDezMqg=;
	b=G9UfHBd381Yxf1Sa7NgFvuYUM+m/xFf7gWeMgMiuK+pbbndsI4MWhknRbZwQ4hdAPPdK
	 2Q2Y3knsDmWD9xzbDaoRk1tNG5W2um4dcQZsOKSGNcT+HUHyKxARnxPccmFKhagX0PHLf
	 VUP3CbO042n5Ss5NnmeNc81KUN3ogOFUUKv4OAWjQuX/OnvyiNJ8+5wB9TbYT8drItq/g
	 mowTg2zZuC6Cxd38i42Blmmqpj5gmc9FjCtFs+42d+1n0KOEI/HFMaRPT2g6v7O10KP4j
	 zbbFFVr8ahHsopIyo2XJQngYbIOOj4jTrxLO1mLpxTdxebIheQy6y7taZAsHX1fPSmA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789658650;
	bh=2PmxJ6WnrlMj6EBjkhYPh4HUD/i3E8Sv+GHJNDezMqg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SCQlZjGZDG7YnBvtPLznCdbJ/+xjROG69BVXxDnwvPEwqBoYPGuwEjpqWl3kmBKuN
	 EzL4HBZGGoi48GbfxgnDlPY6PT1FicnZ1m1VsWdY3snLV9I5SuaMh3/VAdCRNw4S53
	 2/I3wlVTOvJHw41R7Z5HDnLdqQM+sJdksopjqYVjBC2siv+cVHT/Tn/iJH855Tu02d
	 2lesf4xPi6MghJKMPj80UE/2FD7BLWiaWwNZRvjBQkpzJIxrlSt3UFrLh1nyVI37DV
	 D8kTM4jhAN9ySO62Z1Z9+Ytgy9VeqcQ7YTthqnpjZaGEnlF2yJUcve+lMWt2iQiCIN
	 yo2JdMX/lI3iQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CE6F460874;
	Thu, 17 Sep 2026 15:24:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2AEF337A
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 15:24:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 11225407F8
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 15:24:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KbIfX28PW3nQ for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 15:24:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 650C7407F3
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789658648;
 b=miMOfx+KgjsheWpNmPvLUc0CgNqBflrC45OsdS/M5yb/l+9uZJiKRVTdM8v2PdMe56qi
 1vjNBIhT1JwcmO5lZrQ5DU3zxK/RIFTKGdG7TciEJTJEgriPlDibIH5QC29x4xv9LhsXt
 wY3D1x196izuoDP8ez7uJqvtigh/OqbfTOFiGvhV6cc04QXwkS388T5+bmJMD1a+tqkYQ
 QUwdrk5/IoYZYxuSxHUpZXFnRMWdHzSumGdUnp5RLw00GJf8OxGyxIojMVS/D5GQaat6O
 XRBBraeJxAxR2OsSbsPAzKZG9SKRrgCe2iEaIxgOuAJLvXHTmdDaj3U+LSx/+qXnq5w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789658648;
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
 bh=2PmxJ6WnrlMj6EBjkhYPh4HUD/i3E8Sv+GHJNDezMqg=;
 b=ArqV3UxgdMUnGwRmtYAxbLwfaVng2/Rglcr1W7w0/dSvY93vlLjPC5SibRNrE5rPZXD2
 17KIGw+9qBZrtdYnEvEFvIjA4Z/9oQRwoZqMT99DSbf9NBKwJ9ZQ4YaY3M+O9c5F20nxK
 bsaZvI9yzTZ5mScdLeAbo8V6jRbWfYhQD01pT7EpRxHZAM1dssFp2hXLxn77XA3rjQXtj
 o6DCDqQ6v+hluNpvDwLztZj7WDY6KFir9u3Gv7DXV/ZVS2/CGA5DwpfGpUBAKXYepHl9w
 nZAtnxoqy+DNYYnX/t/YCbg4i97jv4kZ+EgkCdr2eJO+FXady+1OC92hUbfB5Cx65Sw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=siemens.com; 
 dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256
 header.s=selector2 header.b="JuUnUv/N"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c200::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::3;
 helo=du2pr03cu002.outbound.protection.outlook.com;
 envelope-from=jan.kiszka@siemens.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256
 header.s=selector2 header.b=JuUnUv/N
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 650C7407F3
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 15:24:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rrhV3HS5hW6MIN533ub0Csuo85s8GnEKjgz6dW4BC9Y1Vz/tJFFfZPnoJ/aFzJwhJObpbRXhFF44UrMtHdTUABx/NT03RxQ54zsmFMVfVoQsJBcAX1B3Hg4js8YrKe9U3zf82G+AJCZsvEjiBu1wM+sXngJTX8kNq2ztoP2RkPUbjETHEl6Nnvhw9vQR3eKqIccv1sbdJ4wv7GrWT4rfRjBk2fGU1EYgcMq7srFp+hDDky5OQossTYlnWIw1XsWrGT3L/yq3fPwb/XgCfrvwTXRnvYITNT+DT5m8v3QC1quQ0BgdZ1VqxV0NwChCKpYUJP0PhV70Zn8JuUdZgt+Zkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2PmxJ6WnrlMj6EBjkhYPh4HUD/i3E8Sv+GHJNDezMqg=;
 b=VWUtU0mpkd9D25CM88cXac3ycHJ6/U4oCyke8AF0JCMMGyrblKBmcjUx9RAYRV3sm7y/vK/xcbEwJq6LdClkTgA8v1EhWms2Pz0lmyqWKjXE5ONACmMqLZvO9DbeUBhYM1uv7hSRBdZ0ZW68DiHNCyLkbK9q6xqYpjob15hHqpacObBeI3K14DLUUVA6CzKrIS0Zm9lb/o1OldOjreeYRzejNH9L3filcz8ILq5u0BARvyzNb1a9FIOTbg6Hsy8A3fZ54R/QpAGGzuFS9hi+NZGP5joJL0RyYQcQiZB7NnQZAxtEOouJnHNFFIELvk4wXTBVbU5+PChz1y4PAFnkkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2PmxJ6WnrlMj6EBjkhYPh4HUD/i3E8Sv+GHJNDezMqg=;
 b=JuUnUv/Nb0Istb7oLqWHXnLPePIFL+QYD9Od/UzbMFnPTvJciJuUq3Wo4ATy5c95hHti93EeAcB+oNczeK5WrIrktVxvzudu11VWH1tfXqPpccAMzQmnj5EY9vGAFCs+cltJOSiQsRIeZEiu6X1ynJVATQ9YRNlkk00r9UXZslR3O+3dB4L6FdVif+bbiZZKE4hqu1PUvR28bbaozv7ukYmirV2oL2GfxyVBJf89PWdu3RvagrTGTlvuVA32QEMl503UykWK21D1kUgb1iFGmO/YzJGqHKMuQu95HysfDJX28uRrLKAzqC5FVcLyox52jVNfOlXQ9jlwxsNvDYxWZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB5PR10MB9763.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:650::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Thu, 17 Sep
 2026 15:24:02 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0428.008; Thu, 17 Sep 2026
 15:24:02 +0000
Message-ID: <abb5973b-b417-4ab0-92e3-d3117ef68bf7@siemens.com>
Date: Thu, 17 Sep 2026 17:23:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/6] tee: optee: Add support for enumerating services
 that only need RPMB
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
 U-Boot Mailing List <u-boot@lists.u-boot-project.org>,
 Sai Sree Kartheek Adivi <s-adivi@ti.com>,
 Alexander Heinisch <alexander.heinisch@siemens.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>
References: <cover.1789023381.git.jan.kiszka@siemens.com>
 <1a6e9dffe86b43d3c62ba185859d30a376fb61cf.1789023381.git.jan.kiszka@siemens.com>
 <CAC_iWjJ7b=Dh+8k49Mq7W5=-b1dZV=L7Z_E6epeOCoej65unyA@mail.gmail.com>
 <5d4aff06-f1a6-4634-b7e3-4e054d5117d3@siemens.com>
 <CAC_iWjKnBrDYErLbDkQyv5tp545-_pfFJA6z1kmGcXvCPt3JBg@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 xsFNBGZY+hkBEACkdtFD81AUVtTVX+UEiUFs7ZQPQsdFpzVmr6R3D059f+lzr4Mlg6KKAcNZ
 uNUqthIkgLGWzKugodvkcCK8Wbyw+1vxcl4Lw56WezLsOTfu7oi7Z0vp1XkrLcM0tofTbClW
 xMA964mgUlBT2m/J/ybZd945D0wU57k/smGzDAxkpJgHBrYE/iJWcu46jkGZaLjK4xcMoBWB
 I6hW9Njxx3Ek0fpLO3876bszc8KjcHOulKreK+ezyJ01Hvbx85s68XWN6N2ulLGtk7E/sXlb
 79hylHy5QuU9mZdsRjjRGJb0H9Buzfuz0XrcwOTMJq7e7fbN0QakjivAXsmXim+s5dlKlZjr
 L3ILWte4ah7cGgqc06nFb5jOhnGnZwnKJlpuod3pc/BFaFGtVHvyoRgxJ9tmDZnjzMfu8YrA
 +MVv6muwbHnEAeh/f8e9O+oeouqTBzgcaWTq81IyS56/UD6U5GHet9Pz1MB15nnzVcyZXIoC
 roIhgCUkcl+5m2Z9G56bkiUcFq0IcACzjcRPWvwA09ZbRHXAK/ao/+vPAIMnU6OTx3ejsbHn
 oh6VpHD3tucIt+xA4/l3LlkZMt5FZjFdkZUuAVU6kBAwElNBCYcrrLYZBRkSGPGDGYZmXAW/
 VkNUVTJkRg6MGIeqZmpeoaV2xaIGHBSTDX8+b0c0hT/Bgzjv8QARAQABzSNKYW4gS2lzemth
 IDxqYW4ua2lzemthQHNpZW1lbnMuY29tPsLBlAQTAQoAPhYhBABMZH11cs99cr20+2mdhQqf
 QXvYBQJmWPvXAhsDBQkFo5qABQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEGmdhQqfQXvY
 zPAP/jGiVJ2VgPcRWt2P8FbByfrJJAPCsos+SZpncRi7tl9yTEpS+t57h7myEKPdB3L+kxzg
 K3dt1UhYp4FeIHA3jpJYaFvD7kNZJZ1cU55QXrJI3xu/xfB6VhCs+VAUlt7XhOsOmTQqCpH7
 pRcZ5juxZCOxXG2fTQTQo0gfF5+PQwQYUp0NdTbVox5PTx5RK3KfPqmAJsBKdwEaIkuY9FbM
 9lGg8XBNzD2R/13cCd4hRrZDtyegrtocpBAruVqOZhsMb/h7Wd0TGoJ/zJr3w3WnDM08c+RA
 5LHMbiA29MXq1KxlnsYDfWB8ts3HIJ3ROBvagA20mbOm26ddeFjLdGcBTrzbHbzCReEtN++s
 gZneKsYiueFDTxXjUOJgp8JDdVPM+++axSMo2js8TwVefTfCYt0oWMEqlQqSqgQwIuzpRO6I
 ik7HAFq8fssy2cY8Imofbj77uKz0BNZC/1nGG1OI9cU2jHrqsn1i95KaS6fPu4EN6XP/Gi/O
 0DxND+HEyzVqhUJkvXUhTsOzgzWAvW9BlkKRiVizKM6PLsVm/XmeapGs4ir/U8OzKI+SM3R8
 VMW8eovWgXNUQ9F2vS1dHO8eRn2UqDKBZSo+qCRWLRtsqNzmU4N0zuGqZSaDCvkMwF6kIRkD
 ZkDjjYQtoftPGchLBTUzeUa2gfOr1T4xSQUHhPL8zsFNBGZY+hkBEADb5quW4M0eaWPIjqY6
 aC/vHCmpELmS/HMa5zlA0dWlxCPEjkchN8W4PB+NMOXFEJuKLLFs6+s5/KlNok/kGKg4fITf
 Vcd+BQd/YRks3qFifckU+kxoXpTc2bksTtLuiPkcyFmjBph/BGms35mvOA0OaEO6fQbauiHa
 QnYrgUQM+YD4uFoQOLnWTPmBjccoPuiJDafzLxwj4r+JH4fA/4zzDa5OFbfVq3ieYGqiBrtj
 tBFv5epVvGK1zoQ+Rc+h5+dCWPwC2i3cXTUVf0woepF8mUXFcNhY+Eh8vvh1lxfD35z2CJeY
 txMcA44Lp06kArpWDjGJddd+OTmUkFWeYtAdaCpj/GItuJcQZkaaTeiHqPPrbvXM361rtvaw
 XFUzUlvoW1Sb7/SeE/BtWoxkeZOgsqouXPTjlFLapvLu5g9MPNimjkYqukASq/+e8MMKP+EE
 v3BAFVFGvNE3UlNRh+ppBqBUZiqkzg4q2hfeTjnivgChzXlvfTx9M6BJmuDnYAho4BA6vRh4
 Dr7LYTLIwGjguIuuQcP2ENN+l32nidy154zCEp5/Rv4K8SYdVegrQ7rWiULgDz9VQWo2zAjo
 TgFKg3AE3ujDy4V2VndtkMRYpwwuilCDQ+Bpb5ixfbFyZ4oVGs6F3jhtWN5Uu43FhHSCqUv8
 FCzl44AyGulVYU7hTQARAQABwsF8BBgBCgAmFiEEAExkfXVyz31yvbT7aZ2FCp9Be9gFAmZY
 +hkCGwwFCQWjmoAACgkQaZ2FCp9Be9hN3g/8CdNqlOfBZGCFNZ8Kf4tpRpeN3TGmekGRpohU
 bBMvHYiWW8SvmCgEuBokS+Lx3pyPJQCYZDXLCq47gsLdnhVcQ2ZKNCrr9yhrj6kHxe1Sqv1S
 MhxD8dBqW6CFe/mbiK9wEMDIqys7L0Xy/lgCFxZswlBW3eU2Zacdo0fDzLiJm9I0C9iPZzkJ
 gITjoqsiIi/5c3eCY2s2OENL9VPXiH1GPQfHZ23ouiMf+ojVZ7kycLjz+nFr5A14w/B7uHjz
 uL6tnA+AtGCredDne66LSK3HD0vC7569sZ/j8kGKjlUtC+zm0j03iPI6gi8YeCn9b4F8sLpB
 lBdlqo9BB+uqoM6F8zMfIfDsqjB0r/q7WeJaI8NKfFwNOGPuo93N+WUyBi2yYCXMOgBUifm0
 T6Hbf3SHQpbA56wcKPWJqAC2iFaxNDowcJij9LtEqOlToCMtDBekDwchRvqrWN1mDXLg+av8
 qH4kDzsqKX8zzTzfAWFxrkXA/kFpR3JsMzNmvextkN2kOLCCHkym0zz5Y3vxaYtbXG2wTrqJ
 8WpkWIE8STUhQa9AkezgucXN7r6uSrzW8IQXxBInZwFIyBgM0f/fzyNqzThFT15QMrYUqhhW
 ZffO4PeNJOUYfXdH13A6rbU0y6xE7Okuoa01EqNi9yqyLA8gPgg/DhOpGtK8KokCsdYsTbk=
In-Reply-To: <CAC_iWjKnBrDYErLbDkQyv5tp545-_pfFJA6z1kmGcXvCPt3JBg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0079.namprd03.prod.outlook.com
 (2603:10b6:208:329::24) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB5PR10MB9763:EE_
X-MS-Office365-Filtering-Correlation-Id: 63f3b674-b63e-4472-d325-08df14cfb3c8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|6133799003|10067099003|4143699003|56012099006|11063799006|18002099003|55112099003|22082099003;
X-Microsoft-Antispam-Message-Info: PZqSDAnXW16J60i8RH0kBxjAi1b/zT2CNwHMk3cmviqqaQFOIrT0kDmunx+gFtjNU1qZGFwzawZ/nmx9AUcCeu54KnhoVITWlFCffeW2qQaCBvs0NVx2UJEBawTV4KcSR9hnZoKD/8Xcxam6KXiTeJqHzMqZtarPpZ6hqIxehZD7OdSzLsn1DlhGNFKQ3bhDWyIHbQA6Kc5FSfdERTWg1Od1oMYvGdp63m4w1RdqtPlSxUTzXkiFSqyG4b2zQfJzOU4jefIFSa1iCh2eJw1p80sckX2rBiKSoZpPeiItd9/Oe41wJ9R4ABS2yCvVb6h8R9++9wRLwVSkxiogKNDyPxt4hj2kNO0hPIj1wnW66H3AEw3eJCzHfKeL5TNQioHZNiceZuFM2rFZGzidkq0G8X9Q7lRU6k2nSD9WuGoTztiHdrSRmbEFByKjWtedZQzKhvC4wPw7serb2itg/VZzdD197GX3Q7D6oh1Gya3nEGxaV/o+QE2yrn0gfYjYHC3r8+x9gaVHReN4XbHlg5rGnxm7QQ8/5Y0gzu4d6vlWKuGDz6W7+/g4naoqTl9rjjwc5SS33LhbLzM7clAeOJScQT0LSuVfiqBbvhfutBV/3iKhIGEDzEFO8FzEwBLwNseQXM2cgpEgQbbGu+UHLgyUtJkRe/o40NqSV/9xvOjZaAY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(10067099003)(4143699003)(56012099006)(11063799006)(18002099003)(55112099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?em85ck9lYVZxcExyUTN3M24vVk13RDNWUkJZZEFFYlEweDgrb0QvN2ZvK2pD?=
 =?utf-8?B?MzBpbFRPK3ZGaEhvalZBaXVVM1U0ZFEzbmprRWpRTDc4dHF1dlRUUmhwK2RD?=
 =?utf-8?B?TmJmdS9tWG9QSDl4SkNsQTdBajFYZWNXMHVvMUxMT2NKMXJpdXdtM2djdkdQ?=
 =?utf-8?B?QVVWRTZrSnpjWHpYdUtST25qZ1YwbHYrbzdvR0RhczZsaWEzdWZFaVlBK0JU?=
 =?utf-8?B?QlVrb0h5ODJNQVhvOXY0bitDZ29MSEpoMklzQVp1Y0dhaEJ4cnRkVklFT3Qy?=
 =?utf-8?B?Y3I1K0JWK29qT1BvK3lOdVlCdHNTSlN2ODh6YWhSdVp1bnlRekxPbDkvZE1Z?=
 =?utf-8?B?S3FwamM3S2JXSW1xdHkyR0ErbE13cXQvelVRUmYxSFN3QVlCT2VDQTVVbUUx?=
 =?utf-8?B?Z2NqVElEcStXT2lqb3NTelprZEhWSGQ5alJ3cG8zeDJ1MDVhS1ZGYit3R3BT?=
 =?utf-8?B?Nk43OCtPK0Jyby90Z1VJU1huSTNhTVhoMUs2Q0lLWlA3ZVNVckdiSExUTm1r?=
 =?utf-8?B?RXR2c29PNjYxSVlVQ1VqamFyZ3hGVDdwTzRBVEJ4Tmgxb2Z6cUl6cDhhVVhU?=
 =?utf-8?B?eklWR2wrdHpkTVNQSFo4ZFdEWjJLV0dPRXZ1c05kbTlQSWRTaGdOWlE1R0xr?=
 =?utf-8?B?TVg3U0V0Z2h3QWExYVBKQ2t6TkhpRXU4MkJyUHRmb1BScFhPNldIaStTZ1RN?=
 =?utf-8?B?N210bVQ3V3FkWUN5b052WFVDTFk5YjlKRzNiYXZCeEdHMUE4dFljNTZXQzBP?=
 =?utf-8?B?ZjEzU21Jb1kzdFlkZEozKy9ZL20veW5oR015SGtOaGNlaWcrYmVZblpwZlB0?=
 =?utf-8?B?enpRaFZTUkRMUlRpK3JHZ1graUFja0MwZERCVXNSL3grdnB1d3pGZ0I4U1Vn?=
 =?utf-8?B?SmU1NE5yRmNrRFFKVGhCY3lsRDRnU3U4TnUrKzdXV3cwaW9UNzY4RVN5Q2FM?=
 =?utf-8?B?THd4N2JWOW13WHBpR1E1VnNsUk1HcGE2OTR1eUFKY0xySm1UK2x0V1F6aGhI?=
 =?utf-8?B?K20wVmdFNS83ZUFzaVJhdHlBNkFOMHZHekRmc3kvR0VseisrT0NNRVBZLzVQ?=
 =?utf-8?B?YzBjTFU2UE5wekJnVEZCcmFUcE1VY0FqZ2FFQ1RrUzc5S0RsekkvZElHQ1pB?=
 =?utf-8?B?Q1RLbHQ1bWZVRnVKMnVxUU5Uc2J6d054ZU51UGdvRVFVdCtsTWpIZDdBUTRJ?=
 =?utf-8?B?WDI4VkNEU3p1Q0RWNjgwb0JyTnliWkQ0RXRZWkZWQzFmOElqM04rRkFLZkNT?=
 =?utf-8?B?NUJZRU5lWlpIdElsUWljOGNHaVRKcmZMc1FPbkZ4SFo0MmVSQm5SUVB0SW9o?=
 =?utf-8?B?eUNFLzBDWlJiNHcxSTllaUx1VEoyakJmZUFUT21ZcXlsamlGbWpyZzhUR0w3?=
 =?utf-8?B?Ymt3dWd6Z3djSWt4bkNYOVBkWVlMSlFzbTFzVTVlT1Z0WmNCellvU0RmT3l5?=
 =?utf-8?B?RHFHR1NlNEtMb3VrdVFNdUtwdjNNak9jdE1aemkyd1c0UVVWWHBOUGdxQk1r?=
 =?utf-8?B?NlJ5K2hzK3R6dzYwZUtvZWovRVU3M1dXbGsyVFphZVhBSEt4K1FabEx2bXY5?=
 =?utf-8?B?TVFrMUtyMFhIaWVVSlFYcTRYMGc1aXRLWmowVGQrclEvcG01bkpXL2s2SDVV?=
 =?utf-8?B?aEYxckVRRGcrbndZUk10TS9qTlBWSjEvc0NoUmNiY2RHWXdVdEg0UlVHTkNt?=
 =?utf-8?B?MC9KeWRCUlFDVEtYUWJvclIrM0ZoL0x1a0k3OGI5SFlqeHF1WmZpd1JYa1VS?=
 =?utf-8?B?eCtYQjZRSXFEa25wM3RwazZBbE5Uc0hGQnhBUThIcGFNd3JPVThHQkswUGdH?=
 =?utf-8?B?UWZWNGE2bEtlcjBVdWtBY1NjcGdteDZRdmgzaUtJWkdxK1Yxc1grcGZoM0J6?=
 =?utf-8?B?M0ZOOXArN0NXYW5oYkhaVWFRL2tmc21UZ1ZXWmNwUE81Qy9IN25jbHBSdFUy?=
 =?utf-8?B?ZXkvS0NLYU43bjMxSEkwZUJaT3lxNnAxQTZxRGlPUDdrd2dVK216MXRQeXFW?=
 =?utf-8?B?bkl0VjBYMElBdFh2TXVkbGVvZWJxVVRQalRMT3k2VWJjUzErSlAwakU1NjFt?=
 =?utf-8?B?Vys2K3p2TGw4U1VRdzU2aVo4aG1lSW13a084emdMaVVIZ1pvT1E2VE1vZ2s2?=
 =?utf-8?B?dVgwK3ZGOUhhdzBZVjM4RFYvUlJoUFFUNHZ1TFlJVkYvNkEySGFiNmNFWkUz?=
 =?utf-8?B?bTJ6ekRROE84SW1pRXNVNktrQVRWYVNnWnl6d1NhM212T2VDc1pwYUZHbEg4?=
 =?utf-8?B?bHVvUXd1MGRlV2tUQmZxSnR3UWhqRW1wSlNLN0FrUEY4Zm5HMlNmTXVGU1R5?=
 =?utf-8?B?TXpEUkNlbmo0bU9TTGdNZDlUaFdTdDE2c1grb2JINi9URHhVN2E5UT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63f3b674-b63e-4472-d325-08df14cfb3c8
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 15:24:01.9491 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7NVro2OE2GanbAHPZSOKIvKhnTk7WFS24GdIIhrsEEMPOSSSvFimCjhgjDs1OpPQLl/eUepLCQKNBY6/Iqh+Eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR10MB9763
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

On 17.09.26 16:57, Ilias Apalodimas wrote:
> On Thu, Sep 17, 2026, 15:04 Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>
>> On 17.09.26 15:01, Ilias Apalodimas wrote:
>>> Hi Jan
>>>
>>> I pinged Jens for some help with the OP-TEE path.
>>>
>>> [...]
>>>
>>>> --- a/drivers/tee/optee/rpmb.c
>>>> +++ b/drivers/tee/optee/rpmb.c
>>>> @@ -191,3 +191,23 @@ void optee_suppl_rpmb_release(struct udevice *dev)
>>>>  {
>>>>         release_mmc(dev_get_priv(dev));
>>>>  }
>>>> +
>>>> +void optee_rpmb_available(void)
>>>> +{
>>>> +       struct udevice *dev;
>>>> +       struct uclass *uc;
>>>> +       u32 tee_sess;
>>>> +
>>>> +       uclass_id_foreach_dev(UCLASS_TEE, dev, uc) {
>>>> +               if (strcmp(dev->driver->name, "optee") != 0 ||
>>>> +                   !device_active(dev))
>>>> +                       continue;
>>>> +
>>>> +               if (optee_open_enum_session(dev, &tee_sess) != 0)
>>>> +                       continue;
>>>> +
>>>> +               optee_bind_services(dev, tee_sess, PTA_CMD_GET_DEVICES_RPMB);
>>>
>>> so both optee_probe() and this function will now call
>>> optee_bind_services(dev, tee_sess, PTA_CMD_GET_DEVICES_RPMB);.
>>> In OP-TEE that ends up holding a mutex in tee_rpmb_reinit(), but I
>>> don't know OP-TEE that well to figure out if this can deadlock.
>>>
>>
>> I was developing this under the assumption that probing and init paths
>> are single-threaded in U-Boot - aren't they?
> 
> 
> They are but iirc the responses from OP-TEE are RPC calls in the RPMB
> case, they aren't guaranteed to run to completion.
> 

Maybe it would help (at least me) if you can sketch a control flow you
are concerned about.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
