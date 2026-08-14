Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8757CC5B572
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 07:39:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1F63F80E41;
	Fri, 14 Aug 2026 07:39:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tnhRahOz3ret; Fri, 14 Aug 2026 07:39:17 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 10F8C80E42
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786693157;
	bh=TuyRVt51TzLsBz3mqFGl27MKw/VKmROqoEjVP+kWryM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cghsF52g2itsBuBL6eNFxCZDl6HcgZ8NCbL2cr7idhaUw8cxQM3oB1OxMoQkFNIe+
	 wIT7rUf75CgmtY1iUCiQEBKo4uzTnxqIVE9H8JbTONzJ7G6XBeJkDnxkgRv+Izuq9v
	 CU41JkYUr/RyymS0L3dP6/CIR903JEtnR2p0XRGlpEBX5DhjSF3fpKvjbFlfplMVrV
	 KEU0th3h2ngrVAxYfvKIof6vdY9bFU3JdWo7ULfJ/FN08EmM8Cfm6F9cGHyiBVoCMH
	 QP/oPS2Fy9LyNcFaOaeT8/eevQX6pYgrVZFTu50CNELe4PZiPKAqRMEB57ORLnsQJf
	 vuHP6dnZ7vJZA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 10F8C80E42;
	Fri, 14 Aug 2026 07:39:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id B6540139A
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 07:39:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A7E8F400AC
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 07:39:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jFK_xMOu-QDE for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 07:39:14 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::1;
 helo=db3pr0202cu003.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 04E5B40084
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 04E5B40084
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=QO+NR0ge; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=QO+NR0ge
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 04E5B40084
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 07:39:12 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=y143s+s3Yxdk16WE17RSAR3S7YyGcotCv/37gcTiGDUFgcDBH6A7nSuiyb/r0agtBSMbCodTJSPHY7/lY571wHYF68HqiNqEHE/agHu4elZfKsmPTppRcnfD+HLKfjLGXrWVhX0+BWTHxPnpt5rAcaGxhB3Mu7NMGToptoCI7JyMGBAm7Q8RTFrq5E9bCj2jAqAIxjFXxEzLAGRPI91MGq6XXmTGhOno/Fg3c5u45zO6+hHdKoKFNFApOlOIaH3UUDFct8QDLRythtDvn2jiDEkWQvtbaYK7c7HQ8nvhR9nEjz3bCLQJoXHbg7FA7lQSQHfHpPbkvGxDre9EDxWgrw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TuyRVt51TzLsBz3mqFGl27MKw/VKmROqoEjVP+kWryM=;
 b=TBnjLX/6VGAu/+a5Hh+DiaaRzNEbQPRx82R9xD4qSzYPhrne6Lj9sPayNyVJkXXhB5CY7IhAOSdIDy3ngyBi1vz9ktl41zxZDERVEiac2NA3qBNVzq3XxzGTTwa2u8Ze8WXmQLybY7PHgHPwwvxFdA7Qp8F01k2shxC86NlrfaMTYy+nTMD70yO9SrgLTnZzo7Xlw7YY+moFPPIJ7j8VrmkWL0z1rThEav2qOYUH8YN6SfsHUpp8tgkl0coyVjtXa/rHt7nVCb05Indu9u22mF45kZ0EcJly7OmAzEEyoZhHXfR6XZk31uGCpzs+CbS7QclD9hrZTwppv4Xq20qoxg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=byteray.co.uk smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TuyRVt51TzLsBz3mqFGl27MKw/VKmROqoEjVP+kWryM=;
 b=QO+NR0geCrTbMCUHXZdysRNPoXT9J64PBLI9LbIAHm8c1K71mg8KWIMGMWb+A3eptwWOckAuxBOpOqcCgFHh+9aHYzLMpKA8umoIAl091qO5IxXePM7+eNm2u40HBWy0mq5MqxtNm2F2qYbAg+vnSgwmhWcCJfeuSpXrj2WEZpw=
Received: from DUZPR01CA0023.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::17) by DBAPR08MB5735.eurprd08.prod.outlook.com
 (2603:10a6:10:1a1::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Fri, 14 Aug
 2026 07:39:06 +0000
Received: from DU2PEPF0001E9C0.eurprd03.prod.outlook.com
 (2603:10a6:10:46b:cafe::7a) by DUZPR01CA0023.outlook.office365.com
 (2603:10a6:10:46b::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.15 via Frontend Transport; Fri,
 14 Aug 2026 07:39:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF0001E9C0.mail.protection.outlook.com (10.167.8.69) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.3 via
 Frontend Transport; Fri, 14 Aug 2026 07:39:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZwzjhnCtkIlyke4icSrQ0KIsRbvyc45dDPUJrBIld7Qyf+7JlNq+fxIUt/m6GcuxiH2jFbYtLJeH5bWICmW1fXk6LXxdDXtsf4tXGEZTmP7zxR3GwTC1U0C1DA2xWx1ArIAnl3hdL2D6CQrZ3pQL3vU3bqrLAG5l5WY/bqBW+Fvm+sSxRUBavbLg5a4qkwYfEhLBU5Sj4UYljXV1Jb+cxw2GWNeDcjAXr+JwVc10SYCsdXaj/exCKbOdyW4X0NCe6pQpjiQr7NxLfh2SngYAqoFutbxi7jf03peZQpqznA+B+lg4NPXqNMV5f6z+lyCB8vmA9KZlgdBHYRwtNEDVag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TuyRVt51TzLsBz3mqFGl27MKw/VKmROqoEjVP+kWryM=;
 b=pXH6ErKtanmiRjM9CQ/QE9tZcxIxFoV8+640TE+78NR+2MmvtGAtXCCoRaNHz9TlqVAAQ/ygyA7akjMWl7InGq+TpWADGooFM6TSaLwPXbQtR0qNeEhZnDHOcIVnNmX6ixKvpn0gDyOPH8V47TgbQ0E4LaTR4RylIEMpuT92oKIc30Guk91yJN9pEG5bYq4hvCbA6qWblpN7hBG8NSVNTmf6VaQICrAGVF8H8mEFHJRtkemv+v8YUnQZa+IiWzdiwRo7Hjp2XCSvffevPPBzYqLyK7vNbo6r3oWtk1hrAfY0Qm38eb5lsk54f3taayAtzXtIvnhg4CHey1T5ES0dYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TuyRVt51TzLsBz3mqFGl27MKw/VKmROqoEjVP+kWryM=;
 b=QO+NR0geCrTbMCUHXZdysRNPoXT9J64PBLI9LbIAHm8c1K71mg8KWIMGMWb+A3eptwWOckAuxBOpOqcCgFHh+9aHYzLMpKA8umoIAl091qO5IxXePM7+eNm2u40HBWy0mq5MqxtNm2F2qYbAg+vnSgwmhWcCJfeuSpXrj2WEZpw=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by VI1PR08MB10243.eurprd08.prod.outlook.com
 (2603:10a6:800:1bf::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Fri, 14 Aug
 2026 07:38:23 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%3]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 07:38:23 +0000
Message-ID: <17ab236d-17e0-497b-9be3-0d512d236172@arm.com>
Date: Fri, 14 Aug 2026 09:38:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] test: dm: nfs: add a regression test for an oversized
 NFS read length
To: shj <shahriyar@byteray.co.uk>, Quentin Schulz <quentin.schulz@cherry.de>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Sebastian Josue Alba Vives <sebasjosue84@gmail.com>,
 Argus <argus@byteray.co.uk>, nd <nd@arm.com>
References: <20260811-nfs-oob-fix-v1-0-5444d86d28d7@byteray.co.uk>
 <20260811-nfs-oob-fix-v1-2-5444d86d28d7@byteray.co.uk>
 <ce8b5c8e-d62e-4e28-bab8-dab2d26a70aa@arm.com>
 <f70400e0-9444-4ee4-b7ff-dea8f32d6c86@byteray.co.uk>
 <bed7313e-fd9d-40ca-8f27-72733b65ba2b@cherry.de>
 <395519c3-fd57-4329-9a61-0a9df524cf75@byteray.co.uk>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <395519c3-fd57-4329-9a61-0a9df524cf75@byteray.co.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0503.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1ab::22) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|VI1PR08MB10243:EE_|DU2PEPF0001E9C0:EE_|DBAPR08MB5735:EE_
X-MS-Office365-Filtering-Correlation-Id: b91cb163-4ed7-4b3d-1d24-08def9d71eb2
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|3023799007|4133799003|56012099006|10067099003|5023799004|4143699003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info-Original: jjy9pIbBbBWiQQQYnZmaYwktsyCDLJzaQ9B1hV8r28ZPM2Lcvjz3kjuBnp/L47S85MVstAthHulmLFPC0kH3dMkxvAN/D3UVaeLqSxd5h00crOO3DrdwxBYNXuBUCh+dDyoC+Wv1FQnrZRqnquaxG8El+FRPiM9JA3lfUkfG+WR9puqfAZ668Q9TRlPU4HNsbplPSlSk+9tVFJpCqWhHW/LPeZCE55weelrkqiXKzI1G6ifvN7aGE8VBDYwC/TnzY+xpgg3FD99QMKhSYTZ7840cJGsgamrNdpunJaCkfGdzOtJgwtOGTi67zb8rQXXsMG5Zc+BG+nsAK+oP4ZLMnkqbm8maegTHLvzQS0LMxs+RY5wIpOwlL55Mjqe2IHNmWqzIaynt1OzXBUZFhsiIHImbLF3BGzylc6C1qaioqOQrUj7UPhL4RHdKA1jes11zOidt+VDC1QsznQ6eT4oSQY3OBZ+DNxTXNkq4KrNJ2viKQ8hl85av6a8+wT9k+jPLTtXWiSnUyPYPdxE9Q4zJ2Q5GOe4IBJbfkNZDih8xJizh0/gIKG1KK8e+tDpFlsQSyxHh9IFXSy0c8DV40EUVJ/Yce8R695ZbifmKfwC+9rY=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(3023799007)(4133799003)(56012099006)(10067099003)(5023799004)(4143699003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: SebCp+6mkkvZnZUBhmA7EZP3OJhVRHDOIqg/R5Vx3zwA3nm72waW2JY/Zis+ZaSp9N0EFzWuKpi69sb0K1TW92FVX3FPZMDFHgHR2aBUbtKgJ7pYB+ljcBwf2XvP/v9zDr5I4WYZav8qdFu1PdDKdwW0XTjV+7a+euaHAk6Xt5ol9wHV6sK3Q+HhzCKt61Jeqv9adh1vYkCwHhMhyKgtaCqjKt6rYNwKAnsyCB/3Lhr6j2hk2LElO5w7tBei+Mul8HYYMCaZG3MbTNQXW1oLqVX5KbdLHeql3piuiYRMobrGVGuys+6+ulmYtn3++1XeF8hI+glWSHIejYjAGOSB4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB10243
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU2PEPF0001E9C0.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: b049f16b-c4a5-43d3-d3e5-08def9d704f2
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|14060799003|35042699022|1800799024|82310400026|10067099003|4143699003|5023799004|11063799006|56012099006|18002099003|22082099003|4133799003|3023799007;
X-Microsoft-Antispam-Message-Info: PjAtiNPUfElKxcq1RHD4NMRm+d214RtU6g4tEDXNxBTbfXFg0i5RWwWSRc6uGpa2iyDCbTWDVVwTNoY65TYJ+ghsASVtVSHMxOW82mGfpEErgmReowW61yyJAbjK8GVQUkpdatsSIDbzkZAQGzj0Ntd6HCaNMAYF0Q489RqNItf+KT3Cl5GNh5AAX4oSwKUnMggli7lpwafW6ZdiQgidMr2IIezcAGfU8Mv5KySpGIVNCqzVum23zutyJ6pYA+U7ELMNEDk+cxQA6SNq6W6B1eTg0ELFaXBt+OTybkrMtBCWruDWVoOCn8mAIJF4fC42t76RiQXyu5/4nSDcBK2K+li+FouwdhEagYrOAw6nUWL9U0k0Z3PWdMw2vy0rEBBiDzxec4zSUYCYKOkQpQqQDZs/LFJuEEh2MJoL2Z2uUQwRxNa2jsFmSa+YhHHT5079iwo7FA+dRBwdfY8qJ96lxDWrdPtUu7HIX1xVdp+vvA3Ti7x+sSyvaDyEKUeWeSNW03bDnDOlvC4InffXjsp9g5zuL2R+lOzpiym/PWdsuHalMDlx2MeOCIQ3ctoG3kC9WLQe5inc4tT7X8/L5IFPaVFljlfiWoRQOy10fweqWiis1aiwkQ3fcqiYstzAiJOoIl5abJtzPUpb6Wj0qaRb7Q==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(14060799003)(35042699022)(1800799024)(82310400026)(10067099003)(4143699003)(5023799004)(11063799006)(56012099006)(18002099003)(22082099003)(4133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2BBoq3Nzc2sZ7ydleWnl7DxXfD/tgah1pd4pwYfRI6HE6f4F9bGqtu3FPu5B9XwwPckL9WqZShxByHsJH5G7zahsn7PChwrYs+HrjMjW0mlgLh7q7R9lSJz7sXI1DP1Qztr8VA+7O9jX/8qwMO3GPmncxvz+XcAT29ppJ9Qxein701p438OCcyoN2mgsT40iFIds89sMGaG2clncCu+h+kjhyIINiWiEmP3G2Y/crJZCTDXVHlLhUYEw3zsQM4rK2MhPByxlQiKX4GqA+YQmw8xF6TzIvuXzXv+SU5bZTiREIykesgj6MQsEJm6hQE4SILmMiagCA+YO2udumI5Hgu79C1F8qMW6YJmLZTJF+HD2PWzJIbV9KvK/w+xRoTF6UcAyS84ZM3uKCd4j6NP7sPjso6UWaPTMajIcpETXblNKjBGTiFlOCGt9INmTpdkv
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 07:39:06.0485 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b91cb163-4ed7-4b3d-1d24-08def9d71eb2
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF0001E9C0.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5735
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Shah, Quentin,

On 13/08/2026 18:41, shj wrote:
> Hi Quentin, Jerome,
> 
> On 13.08.26 18:11, Quentin Schulz wrote:
>>
>>
>> On 8/13/26 5:42 PM, shj wrote:
>>> Hi Jerome,
>>>
>>> On 12.08.26 17:06, Jerome Forissier wrote:
>>>>> With the series applied to for-main I got a CI error, see:
>>>>> https://eur02.safelinks.protection.outlook.com/? url=https%3A%2F%2Fgit.u-boot-project.org%2Fu-boot%2Fcustodians%2Fu- boot-net%2F- %2Fjobs%2F68484&data=05%7C02%7Cquentin.schulz%40cherry.de%7Cfcf4355cfe314a023a7e08def9538abe%7C5e0e1b5221b54e7b83bb514ec460677e%7C0%7C0%7C639222334948504305%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C80000%7C%7C%7C&sdata=nNfbYn4Y0KW9fswuFVBAVh5ceKMSMFfACtCcOHpIdgw%3D&reserved=0
>>>
>>> I applied both NFS patches on top of current for-main and ran the sandbox tests (I forgot to enable CONFIG_CMD_NFS in the sandbox config in the previous nfs patch, and the nfs test is skipped, exactly as in your job, sending v2). But overall I can't reproduce a failure, the failing test in that job, dm_test_dhcp6_serverid_reject, isn't on for- main. I applied the serverid series (fix + test) verbatim on current for-main (b752e441790) and t_dm_dm_test_dhcp6_serverid_reject passed.
>>>
>>> Could you tell me which tree/commit you saw this on (the job checked out for-main at 37f4c339, which I can't find on for-main now), or point me at your merged test/dm/eth.c? I'll reproduce against exactly that.
>>>
>>
>> https://git.u-boot-project.org/u-boot/custodians/u-boot-net/-/commits/37f4c339a4b20e8b60370d6b0f73560c04feef7c
>>
>>> Thanks,
>>> Shah
>>>
>>
> Thanks for the commit. I reproduced test failing on 37f4c339. On that tree the test "test: dm: eth: add DHCPv6 oversized option regression tests" is applied, but "net: dhcp6: bound received DUID option lengths" is not, so the assert trips. Cherry-picking that fix onto 37f4c339 should makes the test pass

My bad. I recently changed my workflow from git pw to b4 and I obviously
applied only one patch when my intent was to apply the series :-/

I will apply both patches to for-main for the next -rc. Sorry for the
inconvenience.

-- 
Jerome

> 
> Thanks,
> Shah
> 

