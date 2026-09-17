Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9792C982D1
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 13:04:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 757F880FB0;
	Thu, 17 Sep 2026 13:04:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X6MeuVqStb8M; Thu, 17 Sep 2026 13:04:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org B9CFD80FAC
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789650282;
	b=YGJSi2gqC7Wj+uo82ipYjYU/useTRqtBJZ6PBkWiUBnkSSgntbdQPx9UuawUbM6gxPOS
	 FdEjtyVIh0FT5CJbqaI26fv7TAo6J2kN2FDkCk4z6TXGN7EqYMQfQthcH/9msf+KX0bP5
	 hyoXO30DxKzQAHRY5AEU1vsBcL2Mh+1SE6azV28+FY1g8QzJM05psC/hrrNhcTKe1ytJx
	 UQNXqxcaGIb/c/EyFi630MrT7msq0f4M/eHjmOaIOqBItQkm5VWkHhZFRrmNeUCjl4zRG
	 2YHlRKepG5SODVYLsKpiLIYA2bUbpXLElGgtrBaKaEUcmskVdgFj2sD2Y/JZ8mVLQKg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789650282;
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
	bh=fi7+yFfNWVsDtrgc/EkRRRC4HziOrqCPGUP6h44NmFI=;
	b=HIiBIHnWcMZWDejimBE36n3nuaOWuSIP/hhgWrZaZbJCFYaAvQCV0EglGVpgVyj3cJdK
	 y84YFVF2rxYW0QN+TwWzFOjNlF+uZCLQs3g0USfXo2VXZ/AZGuKYfYm4Sv0WQDrJ2XOdx
	 14qIUjFOXVUhCXBiLi8Pxzvfi/pcRzSaRa5kWMbIUPqRDP+32cDSeVs7cNjVY1iNE6ZCJ
	 oYH9uB9QtbchKdg+gu5eejOIhhrpUP59RSC8CG5PqjnNxeG6rJoaoBD+jP8gsDa/HLdSq
	 s4kiqiESNrT0TFIiKjDrZ4RIW9/dUIEDScdB6TqcDeF+EPeFgjJMA8Dys1RacfPKtrg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789650282;
	bh=fi7+yFfNWVsDtrgc/EkRRRC4HziOrqCPGUP6h44NmFI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Io5ZXPzv0P6hz1H+PRiGtGPqRSKM6Be0fl/Ww6DRuSAr9G8vLRxV++TU9zqxrH4L/
	 f2mm4u+B0uPsb1buK5UPVg8d90fLIPyF9oRwlI0wa2PR3acJ26NsnY9fq2Yxfdfkrd
	 LkTIsWWavJWvpQnrqxS3jEGNFLhM6wRVKTe05CSB1umBf/Y89sHmhpq4jD+nYyZ9RC
	 RhCNLAvEZ4zGz9BD/+MN3NO+NPFE4YXPiD/DNc/L0GSl7mjlHIc7r+ViF5l3GGN7ue
	 LCoMwqyzhAJ3G6NLm7gD8Zwj+lpOP9qriEp3swmsopMKNaLGVGQj5CB5jbJFA1MXXq
	 +x3B1iAMAGYmw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B9CFD80FAC;
	Thu, 17 Sep 2026 13:04:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3578237A
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 13:04:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B4E0E4080A
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 13:04:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sldClE3VKfZW for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 13:04:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org C516D407FB
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c207::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789650280;
 b=KiGnP1RMpwEwq/WNoe/XegfBakMcap0oKg2XtVkqzFgLiGQMk684KyYzKHP94dlLC5ub
 tLqwE7imSdJ8ds5kLlrMIL/92ZgS1V+lNcPZR15jpws9gWZy9XghgnBAAeTnBjh5xx4W9
 NPmDoVs0uImKonVqTSlV38qT5GHojmR63QlMXLA4qpaWjY54M1sHv+eZ9Q1MmUgah69ZF
 D6QLg6XU9WeIu1+eGm0jhmghO7oN6dQaMMwLQ13u2PY1dqXrM+WwbcMAqkg6k2xT6Xc1h
 I5xO8U+znrkDMUFqpyNUu3TraFk3nKv9uEqyoqlD19oLZz1+Animt3M/WtjFzsL27zg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789650280;
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
 bh=fi7+yFfNWVsDtrgc/EkRRRC4HziOrqCPGUP6h44NmFI=;
 b=P1EtveQ+TD3fqDCv5/GGSTmNRD4vLag9GF8NZ0zSXcTtXMmBVO1R6tApErkCD12rzydL
 eZJS0C75JwZBoLecb0hHjVe3owiZsogvmBX3TX3WvCPL1S/X6c10QWgmIzPM3EpQQecKT
 Qq8GqY3BdgRde+5Nk1sNmdx3Ypb1I9gB/QJXKTtxGGZGqQiBj/p9pGekcMO3vKyvkn232
 qWytP4AOPTE7r7gW8oss5VKmJ1R3UVfS7ydgzYbrGGg4dLGHNXSuj0eg7GzKEvoXB7I6P
 WzJFKHVMZLelKE5F4cQdh+rlXrA4WAOc/WHoTFJuPikgxjhQ7d3lje7whm4jcJMYMpQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=siemens.com; 
 dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256
 header.s=selector2 header.b=HacfLmXq; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c207::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=jan.kiszka@siemens.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256
 header.s=selector2 header.b=HacfLmXq
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C516D407FB
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 13:04:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xR8t/5ZYa53rw1Ezmj84arH4VNN1fyV1n2uB8e+JrV7fMbSvN+LuMtek7p6lcYiKE8kVJCwX3xAW1DjW4C8MORAZ6ar8C2tHornihg35YQaP/1yaaYfhiiJ8DXCZCkYQKnxYTFJdQfPQUUsnbjm69WCg+bLzFnn/llksrOdR0L5l26zC3CG9Xwt9y1FRxvci32/R2LrWY0+xOjpdiHyqSlEN+Uk9eEoZVw6iC0t/pC8djCcKsw5xza1JXVhhVyY1vyXUt3Uf4w5O882cydgG0FO9f7NpPJj50HYW+q6ccKNi/Y7hr/1aoHKIhlWuZRRVg5Ir9K3WyBto9B8KQZtYcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fi7+yFfNWVsDtrgc/EkRRRC4HziOrqCPGUP6h44NmFI=;
 b=yLPUUIGa4rLd4Sw/LYF2i5nmrd5ToWTmHoGgX+ptjZ+atdcqtHhLtZ0npvM0O1x/INvmvN1agMczyJ9XR1VLohRj16SaHiIRzxLmiUvHwInO0+Eg0aEnwTmJfXqTR1j3BFR1jKqH9c5teeBi0dv1ZTB7V/V6cnUKsmN6xpQTggREmX9bU5aAnC8du+WB2MpGcn07DU4VpkafuS2dWa4j+bJRfkd8lE6TRXC4F6RjJRWntHN5HbPmGGN6wmiLSBsEJv7x6T+/xV6brFlM+tweVvl+qFDFhveDJ2/9ZywHjuEVsSf9IdoKFySwIEwpLXJi51rjlYRiNXUUOLxJqtklrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fi7+yFfNWVsDtrgc/EkRRRC4HziOrqCPGUP6h44NmFI=;
 b=HacfLmXqAy3uOVVp7gNoqraXwU/fynpwUkD0waDwrY/qLlQDdu066gCcGF1UA9X8bnYYHXy70Sg6dWF+Zbdws49C5St0YFpQ0ZpNyZIIJdTj2JbrQBUUebKpXsS4h3pbVnpPZ+5t40t2RhK3yMRVJEGY0uBT9Marq+JoX+Vv/aW8U9T+Zl0hxWlrKcSzsJ1OLQb44wj1zN1EBwe7LLQhWUO+dc4D/0VQQUlGnblP7/VgR4v91NwDQ8emFR/LXTKjGWHCCqdEUhEImONmv2Wc9EwItnGnOsP3QQcmsL5m9nVPGsQQ+roGhMlClXAMV8vTXv7lmLC3vTpXXNrqPSbZwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB3PR10MB6858.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:43a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Thu, 17 Sep
 2026 13:04:33 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0428.008; Thu, 17 Sep 2026
 13:04:32 +0000
Message-ID: <5d4aff06-f1a6-4634-b7e3-4e054d5117d3@siemens.com>
Date: Thu, 17 Sep 2026 15:04:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/6] tee: optee: Add support for enumerating services
 that only need RPMB
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jens Wiklander <jens.wiklander@oss.qualcomm.com>
Cc: U-Boot Mailing List <u-boot@lists.u-boot-project.org>,
 Sai Sree Kartheek Adivi <s-adivi@ti.com>,
 Alexander Heinisch <alexander.heinisch@siemens.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>
References: <cover.1789023381.git.jan.kiszka@siemens.com>
 <1a6e9dffe86b43d3c62ba185859d30a376fb61cf.1789023381.git.jan.kiszka@siemens.com>
 <CAC_iWjJ7b=Dh+8k49Mq7W5=-b1dZV=L7Z_E6epeOCoej65unyA@mail.gmail.com>
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
In-Reply-To: <CAC_iWjJ7b=Dh+8k49Mq7W5=-b1dZV=L7Z_E6epeOCoej65unyA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0391.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18f::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB3PR10MB6858:EE_
X-MS-Office365-Filtering-Correlation-Id: a1eb1c7e-8ac6-484b-6723-08df14bc3722
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|4143699003|6133799003|11063799006|56012099006|10067099003|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info: vGBfRVudRuPMHHxudPs/juQxP8GJxw30HXgF0+41gF12VI17/4Ez1/TOl4y3S1LFLazQoJuw409tNr/7uctoojo/Uj+vpojLoHS3aU4D/23fLap7+N5qUzhzs4YbJxtNXvp072WR2RxFFMS+dRuwB8DkhcH2Ws6Y0G0uB+EmZCLJfz1Lh+SxJ8jLbxVSUXRFOLzU89e6gnYi7QrOEXr6LgglkfSNynzwXlgMRhoyYklpTEQMemY0OTioLTDo8qwyAW83cxcJgOKH7qrreYIt5dgnNyhdffSD77VXgGMCIUM/aUDdODLRN0qDMpYukPYyWPBHE0DPB7X69Via02y6I401TbM1HH0bfEf3OQTZfY/naFhjEzeuH2NfOP1YiO4bdUihhVI5GW32FSjwoG1GHBvrEK8HlX4VvSEDfrHfRV2B4b6Qba2nXTpPYX/rAgctc3VhN7YIj2cYbbub9elgUHwC3YhZ6GgVJsZpAPvntP7Ui6zbT/AHKyUMcHNhaOyUCtmJT5+6nm+BUcqdgxrz9kuZ5DO3gAQfvELYZ/B/Hh9iDP+/3TGEJfc3BY6Ut0wi24GE+DJXk3Jc0dMbewNSqLKa6Sg72hIy2NjAcNoam73+B4yyKE+PRNZuLRObWtuOp13pwDH4kCfqCA8IHyJE/bNnYpZbZvnVDPNps1Eb1o0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(4143699003)(6133799003)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3M0bEhqSmNkUExENnl5TXd3RWQ3UkROZWZrbXJlVnkyeWVmQ2UrVFdLTWpS?=
 =?utf-8?B?eFBOOGdzTVFXT2FwOFdtMXl2RmFyKzh1UG8rQVZTSCtvRk14SW5rSmVtdk1x?=
 =?utf-8?B?QmoyNVRsWW1WM2JFMHNuZ0VVQTFaajBxUmozeDBlNXpjUms1dU9mTXNrRms0?=
 =?utf-8?B?RGs2ZVJycnVpNHExMkF0cmxsNFdYdkxaWDJmVWU5eWFWRzd5d1NHNkl1SERE?=
 =?utf-8?B?eUZ1TjczZXB3RVFkUU5PaFNVbmcxdFh0a25oVkVzOUp2MGFJdWVKS2ZDRVNv?=
 =?utf-8?B?Y2pqRTIvSDNSdlllNnY3K2tNb3hmWjJCcmx3cmhZdHVzRlJlNmlORFFsSTlU?=
 =?utf-8?B?bVlmV0tTV1RXVTRQaXMwVVd4Q3NsaVhsWXZ3VVhQV0VubjU0ZVlETVlwSVlX?=
 =?utf-8?B?SkYycnJtWWFtMldkbUlRbTJ2S0Q4UXloOERtZFJZTWlrWlg5VlRLZU5YNkZT?=
 =?utf-8?B?eEt4STd1UG11WVI1RG0rTkxLQVdYWnV6dm9OSW1jaGlVMEhuN2NkRHNUQytQ?=
 =?utf-8?B?ZXg1RmJ6V3QwUUdYcVN2UVFTNDl0a2FZcUkrUGNTMUZpbDFzY2JuWk1lV2gw?=
 =?utf-8?B?RWtVcW5Sc1lpbi9reUNmWGYwRGU5Mnh5akJzdG9COVN5UnBiWFVudTI5Vmgr?=
 =?utf-8?B?ZVhaaDJiSGJiMmMwT0tsNzNla3QvZ29pYzAzQ09wWVM1VkY4djRvY1pLSFRs?=
 =?utf-8?B?SkFOTHA2OGFLclJvYTVMVWVLMTJMdEliS0YvUFl2WnZXcEthbUUvaHhoRFV2?=
 =?utf-8?B?YjVjaFVSVS9DQ0VBakthZzVUM0hBZFBZR2xlT1Z4cHpmL054WUlOVjNreTNm?=
 =?utf-8?B?U0V2N2ZONUVoZ0JIZFhjZmJUc3crc3ZSeGxNd21iSTBLRGZZYVpWQWlkM3RC?=
 =?utf-8?B?WXJmREoyaUpKTjdKQVVIZkhiQ2F6WGhDdy95OHowTFNxclJTSWgxbzQvaTRM?=
 =?utf-8?B?bTBnSWhUaTBoalRsZnZCSmRTekdUa21yajJjRWRLWXhwdFphb0ZhTHpRd2tU?=
 =?utf-8?B?S3BXV0MrUkVNVHVkaERyOWNWa2UxOUM3UWRPenJZL3hHNkU1N3dHTkxVdHNZ?=
 =?utf-8?B?b2FJYVFTZEUzbWN3bmhSQ0ZsdHdWY0hjL2dNcXg3NkF3SExzdmlTNVpPWXE5?=
 =?utf-8?B?SHM1WnJDc0g3ODd5RkJJTkMycDFtZ3Rqa1c0VFhVbEpLbCt4ZlVza3BIK1JC?=
 =?utf-8?B?U3pQNmxqemxRL011V2hCd3ptS3owQXRVUC9aSExiWE9oVk10NlF2YmJlVzdh?=
 =?utf-8?B?bTBFRnlZU0lmMjdwM0VYQ3FBUUFBRkUwZjNRb1pvWkxQSlFreG00b2lnNGsv?=
 =?utf-8?B?ZForUy9lS1RCQURGUXZsN1pGbjdmTG0zcHVVWmRldHU2WXhzMkNwY2QxZ3JP?=
 =?utf-8?B?bE5ENC95ODNjM1hia3ROWXJTa3RLS2tsV0QwM1Z2S2xvZ3NGeXlRREgyVUU5?=
 =?utf-8?B?Y1Q0UUJOendsU3lqU1o0dGVrNWhjRitxRjBFUGlkdWdiL1dnWm5LMFdoMFI5?=
 =?utf-8?B?L3B0VzVybmVIOGx4eWw5Zm9JeG9KZ0xkbzNPQkRCSElGL3JDQU12L1ZYODRv?=
 =?utf-8?B?eG1pTjFZajJrd1U1eXo5YWNPUmJ2R1oxQlFHZk9PeE1WNm9UbU9jSm1zbkRJ?=
 =?utf-8?B?dE5mY2lXUUU2dmJTWm14Rjh6L1lXMXlWV05UeXVKUkxnUFE0SDkvd0ZXZjdD?=
 =?utf-8?B?ZlJkUDlaazN2RXl6dHkrTTQrYVZ2ZmMvTDcrdldNUGgyb3lBNHptclRnZTYr?=
 =?utf-8?B?YlY0aTFTcEdtWlJrTm53S282SXFTMUd5YTVPRWxjNkVGazQ0NHRmNmpXSThp?=
 =?utf-8?B?dTM4eWllU2kzaUVZQzlsM3J1MGlTejcxZ0VxZ0IzTTNnTFNYalA5K2pWQmlW?=
 =?utf-8?B?RytNTnFqMmpYZWh1L3A3NW91aXVjRFU4djM0U0l1SDdycXJFUVRsUUFhMld0?=
 =?utf-8?B?UnFPb292Kys2WTRVZ3FIUE1GNkhteXN2d2lIUUV6R3VJa0xCbHMyUFNpWm10?=
 =?utf-8?B?ZGpaT1BTbG43UkI2Ynphc2g1cTJNNjB3OStDaUhjN25zR3Z5MEgveDU1NFpa?=
 =?utf-8?B?TE5xUzFUUFlPb0ZGM0pzcDAzVWNsVWxUVHJ6Uy9BNFgyRmxMLy8zL2doQmZr?=
 =?utf-8?B?bjBaaXQ0bTk1ZHpCV01nRE9VaytFWjcvRGpJeUFhYmlFQzdxT1RCeElBQXd4?=
 =?utf-8?B?a3VYaFZ3MERhL0hEWGxyM0x6bVNTQVB4QU1oeHd6MDlpYnZLd0gyZGYvSDNm?=
 =?utf-8?B?WGZ1MEl0MzlmQ2hocDd6THFWTzNlc1R3a2RPbWNHUk11alYzU0l2MlkvWExz?=
 =?utf-8?B?UXpqaFkzSE9nNTB1VFpTZFA3NVpnd0p0V0xSR3V5Y0xXYTRIcStqSXA2cHZq?=
 =?utf-8?Q?azNGLNxW/6Pd4UFE=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1eb1c7e-8ac6-484b-6723-08df14bc3722
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 13:04:32.2320 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: njzFQEebJ2E2ju4RXVxdK1PU4g4TzEOc26YGnvpsBmD70BvHcKkZQ5R3DbpA1XeuqtHimsEWmoD268LuUZt9Lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR10MB6858
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

On 17.09.26 15:01, Ilias Apalodimas wrote:
> Hi Jan
> 
> I pinged Jens for some help with the OP-TEE path.
> 
> [...]
> 
>> --- a/drivers/tee/optee/rpmb.c
>> +++ b/drivers/tee/optee/rpmb.c
>> @@ -191,3 +191,23 @@ void optee_suppl_rpmb_release(struct udevice *dev)
>>  {
>>         release_mmc(dev_get_priv(dev));
>>  }
>> +
>> +void optee_rpmb_available(void)
>> +{
>> +       struct udevice *dev;
>> +       struct uclass *uc;
>> +       u32 tee_sess;
>> +
>> +       uclass_id_foreach_dev(UCLASS_TEE, dev, uc) {
>> +               if (strcmp(dev->driver->name, "optee") != 0 ||
>> +                   !device_active(dev))
>> +                       continue;
>> +
>> +               if (optee_open_enum_session(dev, &tee_sess) != 0)
>> +                       continue;
>> +
>> +               optee_bind_services(dev, tee_sess, PTA_CMD_GET_DEVICES_RPMB);
> 
> so both optee_probe() and this function will now call
> optee_bind_services(dev, tee_sess, PTA_CMD_GET_DEVICES_RPMB);.
> In OP-TEE that ends up holding a mutex in tee_rpmb_reinit(), but I
> don't know OP-TEE that well to figure out if this can deadlock.
> 

I was developing this under the assumption that probing and init paths
are single-threaded in U-Boot - aren't they?

Jan

> Jens?
> 
> Cheers
> /Ilias
>> +
>> +               tee_close_session(dev, tee_sess);
>> +       }
>> +}
>> diff --git a/include/tee/optee.h b/include/tee/optee.h
>> index d1194493780..755533b2c0b 100644
>> --- a/include/tee/optee.h
>> +++ b/include/tee/optee.h
>> @@ -74,4 +74,10 @@ static inline bool is_optee_smc_api(void)
>>  }
>>  #endif
>>
>> +#if defined(CONFIG_OPTEE) && defined(CONFIG_SUPPORT_EMMC_RPMB)
>> +void optee_rpmb_available(void);
>> +#else
>> +static inline void optee_rpmb_available(void) {}
>> +#endif
>> +
>>  #endif /* _OPTEE_H */
>> --
>> 2.47.3
>>

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
