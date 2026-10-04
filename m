Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6281ACA5FEC
	for <u-boot@archiver.kernel.org>; Sun,  4 Oct 2026 09:15:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DC7B740766;
	Sun,  4 Oct 2026 09:15:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9cTrefnvGdxi; Sun,  4 Oct 2026 09:15:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 1822940757
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791105320;
	b=tOUfx+c1gmSYRAk2PCXM94IGwoglcpV3uo15/R6U0AvqFTjeqiZSVssfxtCIjl7fE753
	 7g7sYqsCuB6/58iVCNcG6dkfPwN2jTS6LgkzU2tq/VDsRlQ1gA64iA0F5zTEmBtbvbcSM
	 gvTyWLK1RgIdwIIhX3RfTaCsyjA58+DUu6FRwEeAlzmGmNICDMoUHiqcgT3PAEXnZ2SJH
	 8i6sclinJmEDqKY+hKJfO1tb9SShHxh4MQG1oh1FULbm99XTM1uXSiO31KaAnfrYTWdO1
	 wKCkJTGe65Hxd6A/sPHEoh0tOFZcPN4c8hQvdKdzZDl7AUS25OZVGd3TaDCQhbQtv+Q==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791105320;
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
	bh=+z7Vc1g2NLBxqWepkF3AaXNf4yFMBGF93y40NfI4vDI=;
	b=ZJjXwYL0gcHAoURQEofx6dPZjX2XphiKgLmU5hcJoWRCu70gxicGw/p4e/NmX+87c4h2
	 U/gVF0HR//Nd+01d278p7vyAIMTeWsNzrdM8klIHgrstys8mws5z27CVSZ4p93XZJa6eN
	 UzJhJ29BrFKAC+W7F7+GR2l9jfK/F/m2fFKbS7x7Lz85ABC/8h7nxq3T3WapH+q8U+jO/
	 7PuGqmnifS5JFSGUzE0NVh6ii0pfjuHPXbElcGDZGxweakv1TaGrE6aDNyqe0h7kAbfxD
	 GBRehbA0pS3SrOInEH5bkbZENUn016s+QqAH7Lf3kCKYn7PyQMwD1/fMEGKzIa981Ww==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791105320;
	bh=+z7Vc1g2NLBxqWepkF3AaXNf4yFMBGF93y40NfI4vDI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bbJA6YFheUjOgHjsQ2Flhh2lRmvM9/tXV3FVnxUok4zCiTntvC60p6jmQNPWyZ2bB
	 8vNbi7YkJ+NV6HgpTijcVCgUkhQ96PHuAvnnO7bX/WVic5kZ2pcandlEbHttA0PKmx
	 KVvqPautGzvqUtVetsFaW0WzqNI85M9nzv7IvAk3sacaV9rIR48Vj166axkH/vFS5+
	 3GnL60EFHfLP9ubjp63nhFgmJkwpWUX2cKcKMvHINi7EZI+Zq2YXPPb/ujLkg/ptI7
	 kDUSQXAy5p6jVHOSUE8gu5C2SwbTV6CKvik0QqheljTcAT/rMOvCClQHQ5+frGjkqS
	 /QkjT/Fb8Ialg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1822940757;
	Sun,  4 Oct 2026 09:15:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 23A3634D
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 09:15:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 08ED580D3E
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 09:15:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ri4dSZTb5Z9C for <u-boot@lists.u-boot-project.org>;
 Sun,  4 Oct 2026 09:15:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org CBD7380D44
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c10d::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791105317;
 b=UFf5FhIeBGl/mphpfmXGGbB+8T5AsdLX5HzcjfCPsvVOm7cdeeffpv7Mvfq9Fluu9ItJ
 k9ifg/aDIuWOJifwWIy821BjzlcfMMYS17KXOmiSL+01No89scQsVgZKVyne2PE0o+61s
 zS0gB4LBygS4bDL2j2TpxgqU47iMhdI335QtXibP/fXOXdQwAbDYR5P2cq4JIPxZw1crs
 owNVcOJ1hrHNH87u/oNg5ZGfhyJDgdBbQ+v12p6VOd546XyPtqK6te6m/89Ru8xF4qc7s
 GUCNmJjStkC02C8UBFdYx2md6wGMjbhIaLnV/h49ooPG00rT39sC2pa8++mOdk29EqQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791105317;
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
 bh=+z7Vc1g2NLBxqWepkF3AaXNf4yFMBGF93y40NfI4vDI=;
 b=ALLAss8IXjzptVjErzWx5O09r4SXRDED0MhlBLluB1uqSUf+h5JgKgq0wuYjpE+HHeyd
 Q+ijkMYUnAa21Q3BMi9WTnWiebEL2a055vyJB08Y19NixwymYFWiWu9aYL8ymTTJj98AO
 pQ7ToQvxqva2xII2Qjn/ktcaJ5xrFEe0tWCpXdlHbU+XJnMInIuHEIbCsAXgWZQQ5aLOt
 jf+2t4ThO5Hz+v2lgKBTZYIgAAhO1QxAF0UaavIh4BIuKYpKnyPE+Jm4lToLtnbbDSNZT
 5Gq+Qpwi0a7Tdqhe5iEUPow2aVJ8+8u9ygkTkSn89ne80owiAZGfOMJNRQy3m+l5vTg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=altera.com; 
 dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=e0OOQy2+; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c10d::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c10d::3;
 helo=sn4pr0501cu005.outbound.protection.outlook.com;
 envelope-from=tanmay.kathpalia@altera.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=e0OOQy2+
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CBD7380D44
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 09:15:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IWQh5BOk+4afqzVnoNQsMXXF1/qkhXo1NxqXg+Gw1VbZk00OmNrnZZs111On4qpIA4RzqFJfB7uf7ybjHaGdDlujGiTEPmmQ99B20dZAShKlQ7qh/6EhCThRbVwnIBUwOcfZWJOTLQAIV2babETQ624Fl8sdHB0WzK7MLOGLiO+S7ABdgApAoVeKG4Lt3ME1cueiWU9D1fbee2QOgjsQnBnvVQTSB/2VteHl3k/uKlhO5vGrM3/BN2jmEP87PZq85ogjjfHNR4GdZ5lJCOPDqFIfAXwJU5TACrdt8C0I+z25qQx4FbG3R7pzoaYk/0IUAwLxGOB8Tv5RSOIISo6PvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+z7Vc1g2NLBxqWepkF3AaXNf4yFMBGF93y40NfI4vDI=;
 b=e4nwr385hjtYz1DyACVz7/6A1w1TsOuZIom9B4NbRw7j2oEqK7Wl1FXfnY9fZVrvcLuhJv8oLIvVm3Ypoxp1eS7qt0aODxnJ6WxwjRgthqcIu5T1DBEwY9IgPB2+4HWIFZKDUBloGLgCXoaPEUyXR2n7B0ivvhIDUm+i6Q3tz3pbgMQEZm+0iikTcU3tpFzjKgeOh0TL5thBqSDzip9bwI9ZNy9eYyC/t4HeJhuXgrL8ps7fIWTswri29Rc8leN+expdqVxlfgoAamgFlW/Xzgegzd7njOI6mKQ9oWC5e/6kt4zaBTahpoObF7rq3etYeaFAAD01mWaZK4HRNITifA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+z7Vc1g2NLBxqWepkF3AaXNf4yFMBGF93y40NfI4vDI=;
 b=e0OOQy2+PnZ1t9X7ztopiE8iDDOyFR+EFEsUSy+0InAOl0lr1+v7Ph2asWOV2aB9Etw/FhKOV6poMzrmNJWXBFMKFQQbKrbl8NYfH5rZeUHLHr2B0l7E3XpjXkqBv0EMvQmCmY4tIfHnMon57/KTidDMrVSSsvUuI1I7zEv2QDiX4sFXMlNM+Abyh6p49gtWzRlSV0TaqOv6e+MLUX4fvk0ADPZaUjB6UPkVgnh7DZvx5AgTKKNW4K6n+JahHhvF9V/2+6MCS4oCCg+wLYAH5sG1ndyCOscG8156gAwni9vqIBIolSzf9efJ4XXH71K7S+xdxVAqXxBX52jXC6aGlQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BN9PR03MB6204.namprd03.prod.outlook.com (2603:10b6:408:101::21)
 by EAYPR03MB989302.namprd03.prod.outlook.com (2603:10b6:303:2c7::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Sun, 4 Oct
 2026 09:15:07 +0000
Received: from BN9PR03MB6204.namprd03.prod.outlook.com
 ([fe80::47fd:71fd:88fe:6fe4]) by BN9PR03MB6204.namprd03.prod.outlook.com
 ([fe80::47fd:71fd:88fe:6fe4%4]) with mapi id 15.21.0472.015; Sun, 4 Oct 2026
 09:15:07 +0000
Message-ID: <a8c26e72-1e5e-4175-b3af-b39392144195@altera.com>
Date: Sun, 4 Oct 2026 14:44:58 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] mmc: k1: handle a missing max-frequency and
 clk_set_rate()'s return value
To: Dave Klotz <DaveWK225@protonmail.com>, u-boot@lists.u-boot-project.org
Cc: Huan Zhou <pericycle.cc@gmail.com>, Eric Chung <eric.chung@riscstar.com>, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Yixun Lan <dlan@kernel.org>, Tom Rini <trini@konsulko.com>,
 u-boot-spacemit@groups.io
References: <cover.1790975596.git.DaveWK225@protonmail.com>
 <ef56cc2cf2361bea7bdb478b253f9cf3a1cb6ea3.1790975596.git.DaveWK225@protonmail.com>
Content-Language: en-US
From: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
In-Reply-To: <ef56cc2cf2361bea7bdb478b253f9cf3a1cb6ea3.1790975596.git.DaveWK225@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4P287CA0076.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:26b::7) To BL1PR03MB6199.namprd03.prod.outlook.com
 (2603:10b6:208:315::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR03MB6204:EE_|EAYPR03MB989302:EE_
X-MS-Office365-Filtering-Correlation-Id: 1073d086-a034-4be3-3ab3-08df21f7fb47
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|11063799006|56012099006|4143699003|10067099003|22082099003|18002099003|55112099003|6133799003;
X-Microsoft-Antispam-Message-Info: 0whN6OODNfbPA+pcIqOkGEqoKVtMWIfCrjOQJVFBogPD4swAj8F20ajkzo4C2m6dNLUevqTTowELnPdV3/G1dvAW1aeRvB+H2XHcCkgichuo2m9tcUs2hvOQs4734HW8c6437Deob2ibBhogIu9MkogeuK0Z5y6R46GLZhA4TLOJVrFChEEj2bFoozBbz2Eo20+D3HHiViinBv0Vg59AoOq1ZYknbl6/W+jA0Wn4wwYIUhJOLVuWYX5WX+I+C4IZpMuiNoMY11cAjzPLLO6ITpVN/u3Q0zxAPTd5mFGBuImfYprcqjfzrRo3sQRvo5QjZQbJuyGj02Ed0+TFCXAXV2wFZlxJqVhExYkJQob+V/I5vOiprPZxfS2iAbtVgVrZfk8FT8zsGYpXd0iLpi0AvvduKmjl8KdUyoQLCekzlia0kiuoP3TD/R0ZTV9Sld/ecLJArhs3goCfVmGpcWjqDJMJxwKTK+q0ZDpGdxGegFjPCv0wI3F+Hpp6VEVwWts8gl5yDPF0p/5aWZnx6UuGiT9rQPgy6E3mOvZfAnQIOBW/RAfupR+OAFTdnIEqcwKYrYiOtQ16v2Y1ZzkmuF033SczV098OkNsmOkN3D/FjD5AeSP9OMtEhMl2SdiYFQf2h0Qe28IzZaCvoTr4mozgIP2aanDobW2+1YIehdaGN7U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR03MB6204.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(11063799006)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003)(55112099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cngxOG85MVNJd0FER3Q3YWYxRlIvaDU3cjMrL1hhVTI0aVNIejROWTN0ellz?=
 =?utf-8?B?SDZwM2p0NStjZ043WVRmUDV2U2I2MEloOFN1SC95dDRnUW9uMjNqSnlTVzlh?=
 =?utf-8?B?d2ZEd1RHQks2YUYyeUpZNFBhQnVML1Z0c2oxcXBZNWJUNUo3VlZLMTRVSUZZ?=
 =?utf-8?B?Qisvb1k5NmdPeDFhZmFYYjY1d2FmVGhrZ0ZWTittZnJBNVRkMmtqMGhEMmFD?=
 =?utf-8?B?UHh0OFdkUVpOdGF1MkprelE1eFhSMDB3bFIrU05WWi93bFNBR2FwMHBMSVJY?=
 =?utf-8?B?Y3Q2Y0pRTXNESG1TRmlRWXltcFA0WFJTUU5lVXZBYmlHQlB6MVFuczMrKzZW?=
 =?utf-8?B?SDI3TGNVNlNRZGZRMlJ3a2dUdHJ6Mi82aGlPY2RjaGdrcWpuM2RJZWlUZFRo?=
 =?utf-8?B?Qkhob1hEUExuc1B0Nmd3c2t2L1RrbE5pSWRqN2Rnd04xeUJPaFZyMUMybUJu?=
 =?utf-8?B?RWZtQ0poQVY1dUFqeGE4bVlITGJUVmwwbmgwZkFVQ29aZGtYSnkwMlo3bU9o?=
 =?utf-8?B?eUZ6cUc0S0ticmp3ZU83MmFUZHhzMXlMWVhrL1NZRmtHRzI3aUFPcExUVkto?=
 =?utf-8?B?NG5qV3RXeEQyS3p2YWlkZDVEbzk4YkV1MzZ5aTRhU2pkb1h3K21RejIrSERC?=
 =?utf-8?B?TWxWRUc3MGNESWVSZ3lnZ1dvRytGNHY0TWtOa3dBaFBIanNxeERkY0p0TjNk?=
 =?utf-8?B?aDc3OUFQQWt3WlBOQXF3cldzTndJeVVjSSt3MUo1Y2cvQzgwM25KUmxKYXNW?=
 =?utf-8?B?Z3I5WnZBclVXcjFDaW9NdjZ2MmREc2tCU3Boc3ZzbUxUQ3JUQWpabndQa3Ay?=
 =?utf-8?B?MmdVd0JuRVdPM1N2NW9OOTMyVXYwQ001NGdyUURwbGw4ZGVTSGp5bWxnbzJh?=
 =?utf-8?B?NTk1QzhFZTlCZXBEZ1Y5YmU4YTZ5VG44eEM3a01XUkp3aGtRS0RJQmF2SXVS?=
 =?utf-8?B?TWMrR1dLdUtMNEJoVEtseWszR25LQS9aUXBocnJXUEZSUGhSL3d0Q0lVaHpK?=
 =?utf-8?B?VzlybjdVZkRxbStUeXRrbUVDOGx4UnZFSkZiTWZZbnBZdEJIK2VwUEdHbVlG?=
 =?utf-8?B?NTlJeFpjTGlxak4ybEdWNk9tNVdjYmp3YlpqSlFGNWxYaWFLL24yQlNiaVlQ?=
 =?utf-8?B?S0l1Tk80WHdHYzdKSHhydmNCSlB3YzdEdE9Id0s1bm1zWEl0dFRSQ0lHVlN4?=
 =?utf-8?B?dWZ1Zkp6ZDhRaG9Ic0JWcDJWRnR6SnBoSU91TS9SMFpHR2t4SHhzd2Jac3JB?=
 =?utf-8?B?N3NGYXg5REY0VDBsa0h4ZFNweGpEeDRWNVdTRXV0VkNPcUpTcFc2WGliSW9H?=
 =?utf-8?B?bFNwaE9GOEM0dzlsanA3YVEvNkU1emtMaEs1NVdaSUJVb3dDUzYyekNNOVgx?=
 =?utf-8?B?bUVUZG51UUFsUnkzRUdPUHFPVDVhOWhWWkpldUpwdTFORWJSNmx3aGk0ZVdt?=
 =?utf-8?B?WnNwUHJvb256bG16Mmp0Q0VqOXlKbFBhMENUUU1tSEFDY3FOYkFWb1ZqMjEz?=
 =?utf-8?B?cFlBMm1ZTklUWlJiZThLVXptaXVtY1dnRUdjcE9SVkg5THFSQWlST3hNWTh2?=
 =?utf-8?B?YjVSUFZGK2Fuc2ZndmFoTHpiUWIvUlNUL3daSFZRUjBiYjVTcGIwUkFsVmdv?=
 =?utf-8?B?cnRJSEU3SjhmN1pWVjVLcDE1Yk1jS3VOaG53Nm1uM28yV1dSa0hVN0drbTh6?=
 =?utf-8?B?d0VMY004bFhVMjZkQklZMEhIYVozSFQ5aHNJcjBxYWY3VWROWExRVGttM2RJ?=
 =?utf-8?B?NXVKSXRTVWNrRWtrd09NQlByeG52ZmxCSEJxWU9oajU2Z0VrMU5xTzdLSVUy?=
 =?utf-8?B?QVQ3OEJQMWZsZDN3VHk4L01uYlRLZEM0bWVSMHJBSzdmenpCbFBIbmJBcVdm?=
 =?utf-8?B?aWdQUlYzKy8yUGtlQytJekp5bSt4V3ZoamdMclNBdDk0Y1lkeWRoQlRLMWJZ?=
 =?utf-8?B?czA0amM2d2FsR0h5b05iU1U1VlJJNld4b0VPcUphajNHeDUrRmxDR05PUkpp?=
 =?utf-8?B?NlU0ZzdhK21Vd0h0dS84bEFlTVBMUDhKWWxEUVhrMkxwRHlNSXlybDhuaUNy?=
 =?utf-8?B?bUZ0Z05zeUVKT1VPem8rbzRPWmJFWUowY1RaWlRpcFZCQ2xuZFhJd29KNS8w?=
 =?utf-8?B?MkdZWDFXVXBGcEVsSitjbUc1L1RPZVNxNnFnN1U4RnFPNzJnSGNtWXF4aE9s?=
 =?utf-8?B?RFFqclIzWFpzclJXLzc2b3YvaTFvSENqNXNEcTFGdnhyTjlRbDNLQWVXZnY1?=
 =?utf-8?B?OXl0WC91MEZNM3kyakhlZ0lkR3JKYll5a1FrVkxNbEVHV01VdTVnY3MvdTEz?=
 =?utf-8?B?dEtTbkxXRmhLQ21TMjYvZGFnNlZPMEVwRnlxQUdXQWliZWtyZEVESHlDVGo0?=
 =?utf-8?Q?Xk5gPqmVxO4woc4M=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1073d086-a034-4be3-3ab3-08df21f7fb47
X-MS-Exchange-CrossTenant-AuthSource: BL1PR03MB6199.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2026 09:15:07.1760 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JaLS9+6rjgFFeeht+cOQg73J7ohaXI1V/V6IpBC9KaOW7c+luG9mBTKyrlmy6rSdQWfs5OjfSOh3yFmJdJDP8ozFeU5kpbHNiJSlt0bm8dM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR03MB989302
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


On 03-10-2026 02:59, Dave Klotz wrote:
> The driver sets the io clock to the max-frequency the device tree gives
> and fails the probe on any non-zero return from clk_set_rate(). Two
> problems follow:
>
> - clk_set_rate() returns the new rate on success and a negative error
>    code on failure. The SpacemiT clock driver happens to return 0, but
>    any clock driver that reports the rate makes the probe fail.
> - A node without max-frequency asks for 0 Hz. On the K1 clock driver
>    that picks no divider at all and writes whatever the calculation left
>    behind into the io clock's divider field; host->max_clk is then 0,
>    the capabilities register gives no base clock either, and the probe
>    fails in sdhci_setup_cfg().
>
> Treat only a negative return as an error. Without max-frequency, leave
> the io clock as an earlier stage set it and run from its current rate.
>
> Signed-off-by: Dave Klotz <DaveWK225@protonmail.com>
> ---
>   drivers/mmc/spacemit_sdhci.c | 26 ++++++++++++++++++++++----
>   1 file changed, 22 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/spacemit_sdhci.c b/drivers/mmc/spacemit_sdhci.c
> index f5578f38bd..bbd49b76c6 100644
> --- a/drivers/mmc/spacemit_sdhci.c
> +++ b/drivers/mmc/spacemit_sdhci.c
> @@ -606,10 +606,28 @@ static int spacemit_sdhci_probe(struct udevice *dev)
>   		goto err_reset;
>   	}
>   
> -	ret = clk_set_rate(&clk, plat->cfg.f_max);
> -	if (ret) {
> -		log_err("Failed to set io clk: %d\n", ret);
> -		goto err_reset;
> +	/*
> +	 * Without max-frequency there is no rate to ask for: leave the io
> +	 * clock as an earlier stage set it and run from its current rate. The
> +	 * capabilities register gives no base clock on the K1, so it cannot
> +	 * stand in. clk_set_rate() returns the new rate on success, so only a
> +	 * negative value is an error.
> +	 */
> +	if (plat->cfg.f_max) {
> +		long rate = clk_set_rate(&clk, plat->cfg.f_max);

The clock API returns ulong; please use ulong rate with
IS_ERR_VALUE(rate) for consistency.

> +
> +		if (rate < 0) {
> +			ret = rate;
> +			log_err("Failed to set io clk: %d\n", ret);
> +			goto err_reset;
> +		}
> +	} else {
> +		plat->cfg.f_max = clk_get_rate(&clk);

clk_get_rate() returns ulong, but f_max is uint. On RV64, assigning a
negative error first truncates it, so IS_ERR_VALUE(f_max) no longer
detects the error. Please validate the ulong rate before assigning it:

     rate = clk_get_rate(&clk);
     if (IS_ERR_VALUE(rate) || !rate) {
         ret = rate ? (int)rate : -EINVAL;
         goto err_reset;
     }
     plat->cfg.f_max = rate;

