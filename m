Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD57F606A32E
	for <u-boot@archiver.kernel.org>; Thu, 12 Nov 2026 08:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=KPYNi2jl;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=wSTVmiXV
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8B6E281463;
	Thu, 12 Nov 2026 08:37:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6-HoFNDe2jzp; Thu, 12 Nov 2026 08:37:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D93938146E
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794472657;
	b=g40cDL9P2o3Doji0k+XJFjvJFPemphRlfJPh2eBArMxTeLU4JO2/jmXyR8jHFcR3kpW0
	 dBWBFXD7UBJfDltKODYXVevp2OLhPCccnEc+kSBFjdKL+jKntkv3RztlM+QqC3VWFTYcg
	 rZwrWuTYsvS+GyR6bC+A6HMqzzXblMtHGN+BQbx4WXSEqhNkDiNur1bjlE52pfW89POue
	 SOuZqnP21+vcB5CEfSDX0LjvmdUA9fZAT9F3gS9T9eF6tazyL864Te6sTCGV22MrFBigm
	 dzsphC741GprV+hnjk0BoQ0xyOr4CBAMAUKm0IwUpliTBaf42AKqdQH7jWXxFNAgIvg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794472657;
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
	bh=EnRooXUULtfjvhVt9ECDh3vIAPv7wmzzilLv50BIvHU=;
	b=fqVonHpl4v+EpCZwxrUPMG7Nz1KnN6kfEX1PBgR/lRS7TfPsjvqVRqE9uwZZM6y+JKMZ
	 hDypl8/nccmHzMiG9tRbPwFZLHAS0Lm1QogQNlt8UXgBHjkkek04Rh35WcGf3HMgBAc/b
	 +SuIDeQd5xBBzfHPi8tbfJ54hvzVnkTPESHqZYn0vPbliD0o7D+qvc+kqPmdZdgx4c93t
	 iUSGFp4dbDKUcCq18O1062TElmnezfIT9n2fm3/unJ6TlUuhoqwhdvw+F6JVcIXk1Z7Ot
	 zRG2qaLDCZJysR8JvZk4rvlWrVr7u7N9E6NaPH2Jz7AiX3KeKyBT1S09Qlm5wrhcoxA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=altera.com;
	dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=wSTVmiXV;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794472657;
	bh=EnRooXUULtfjvhVt9ECDh3vIAPv7wmzzilLv50BIvHU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KPYNi2jlg5nxI/T0EB/byXbWMmLBeMz1DHvajJrRsyOjH3NMy/9vo54QcBwbq7RzL
	 fzNRZbS9scC4Oi2DA+WTBF+6cSJozoGwmXIYF+1ljMXtg24IQfDbiaKLChOPYoniQU
	 7nUv1KmdB6bxo6KhphNr4MEPG4+XKAH+PLQgcG86mG5t+Xl0sst746T8qcp5TTw/V7
	 kLugSFS6oVjagYDHa8n46Iz1Sn14mUAK/olhX9Es6/yfxkJptZtZLUzay0X/fvtyaD
	 xtcGAOm+a4O+Rf3v3cAU61jlcV73OPzgGaIXaVIO//QuvyPKRPuTKnq5qB86sFpLF3
	 ANPvfavFntDug==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D93938146E;
	Thu, 12 Nov 2026 08:37:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 23057335
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 08:37:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 14BB581585
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 08:37:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AphhuPeJfIvn for <u-boot@lists.u-boot-project.org>;
 Thu, 12 Nov 2026 08:37:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 47A468146E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c101::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c101::7;
 helo=bl0pr03cu003.outbound.protection.outlook.com;
 envelope-from=tanmay.kathpalia@altera.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=wSTVmiXV
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 47A468146E
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 08:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EnRooXUULtfjvhVt9ECDh3vIAPv7wmzzilLv50BIvHU=;
 b=wSTVmiXVje3TQHY59TTLJcbkJRxjc1QRfdSCtbshfA/mMd9dr1izbz7jVR1RdTA+XLCP9K+b7HhfozIXq3WkTBYZoT95gkawBqh42h3eL7qOgwRY/l0JyzKkNe4wCp3k2C/BvnXv1XfR9XrVR2NHWYWUTuYeEZsx+772HIGaivtnUUAwMIKYAML5TnvK1eYpuCcgG56cLasGCYE8VK3ajoir8UkCFyTCwx3sEyxHsFzRoPn12eaI4tNTrSwtKKwVV1fmnIDlfuYKVDm7IiVRvn6b+9vWQI8nyuhKTXiBx/RjZqrVWQwV5oBTlYAIJAA24BEEQjzg/Ej8NxxjksZr5g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by CO1PR03MB5874.namprd03.prod.outlook.com (2603:10b6:303:9c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Thu, 12 Nov
 2026 08:37:30 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0615.009; Thu, 12 Nov 2026
 08:37:30 +0000
Message-ID: <23b1960e-040e-4779-bc8b-1b92a9e9e2b8@altera.com>
Date: Thu, 12 Nov 2026 14:07:21 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] mmc: export mmc_set_capacity()
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 u-boot@lists.u-boot-project.org
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>, Markus Niebel
 <Markus.Niebel@ew.tq-group.com>, =?UTF-8?Q?Marek_Beh=C3=BAn?=
 <kabel@kernel.org>, Torsten Rupp <torsten.rupp@8tronix.de>,
 Eric Chung <eric.chung@riscstar.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
References: <20261112-upstream_partconf_fixes-v2-0-5eba1cf22b1a@foss.st.com>
 <20261112-upstream_partconf_fixes-v2-2-5eba1cf22b1a@foss.st.com>
Content-Language: en-US
From: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
In-Reply-To: <20261112-upstream_partconf_fixes-v2-2-5eba1cf22b1a@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0102.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d1::12) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|CO1PR03MB5874:EE_
X-MS-Office365-Filtering-Correlation-Id: 481e6d04-2cfa-4076-46df-08df4098306c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|366016|1800799024|10067099003|11063799006|4143699003|56012099006|261026121527099003|261021123027099003|261102130727099003|55112099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: JGQTllDQFhxwqicx8q6/hju4Oxr853GiqnoQ4WfoNYZmxi3YtDk4SDHI8RVcTF1V/t7RZv8anRSgHDIE8QgstLcH6gFRnKEkI9e9ZyGUtbm48TyAN56Byf/fuflVhTcptb034WL63K9RurilCbK763J6iMNP0zuzh7ILffI4Vm1Dw5iFA0nqpH0w3Ape9MylTFz4k+nRkqkfuEh8uDe1PKZttM2czsoXKeePNm75YM9GlIKYqUgqU7SH+4D0p2s0ronTuPnRuTRmpU/zHXMAKtr24hOgSN9qey7pJj+bUc1HaTcRCgWJUfOYuONpWoJQKKGa605I1/b0tB2Z0qeySUfcen1eeoyBpwy+pD8P2pMi0lHy2L56+NiL26mFCpBcwku7/K3di2q92Sz4gyxKmLdVAoAIiAkoYpKYiUJvWprKA3zG7jY0bTHW6iEVbe6q/zHarBF8n6iN1mybMbuVv7x+VMurVGQ9h/2+i5c5L7L7pgWC0Cynuk61jhkWG/M4Y8iNsqhnBFCcGNTwtdR0kO+f6fUjf9BkfOW3FzfdD8bjqwheQiQeWaP95n400TlIjV/3NQ7mTapBpDg27tN8rgSGmFj0ejx5yS9cZZeg02HZSm/EcVkdB7W3bZwbHL8h5KwnVsIMZyQQYnhV1CfGSA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(10067099003)(11063799006)(4143699003)(56012099006)(261026121527099003)(261021123027099003)(261102130727099003)(55112099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L09QeUI0OStBc3JWVGNzTEx4TllYMjN6RG9PUHlNZnkreGRMOElWaW52L2VH?=
 =?utf-8?B?VzlVSUR0TW9zWk5CcThuVVZlYU1rMUo2RVpEeURBRW5QN2t5REZMYkJ4bGd6?=
 =?utf-8?B?T3ljdWFpazErV0l5MjRSVHI4WERHQUc5UzRpODVocElZQVRLKzVVSXR6cUhH?=
 =?utf-8?B?TzF4WnJaTVBnN0ZUM3pvaTJ2OGZXdmNqM1VndmFmZzBTSURSM3NrTnhYckN6?=
 =?utf-8?B?K2lBL2x0bnhYR1V3aHUwWEd4MVFtMUxZdTNmWXVDSzFXaVZEa2E2ZmZFOFlx?=
 =?utf-8?B?RitJRnREWENXNnpUOWIrWG0wWTBFeEZVREJmTGpSelhEUkEweE9PMVd5ZlVh?=
 =?utf-8?B?K1k2M0lycWtyQ3FOSW5rZHRLUDlSazI5Um9LVFN3WXh1Q0VwZnRuSlJNN3lk?=
 =?utf-8?B?RitmQy9sSUVqWk9lWm9xcjNMYXdaWGRBOEorOWJGZ3pkU1hrVUMxZmdJQVVo?=
 =?utf-8?B?bi9XbENIczh3eVA3V2twOEx6M1VqSDZmNzhiQlliK3M0OTlCOXlzd1M5ZFlG?=
 =?utf-8?B?NkIyK3Zwdm8wekQ5TkpDeklOMDZ3M0RoV0d3SzJxMjFjSHhsdkdMRWdYa0FX?=
 =?utf-8?B?RGdsYnUvVlJ3c1JGdk9LeHRZUXUwMk9sRURsOGl3ZlNPWmNWb0k1RHFwNlJK?=
 =?utf-8?B?ZHVSaXRiK2NzNXI0VTVWUzBVK0JnSlZ6WEZVdDRwTFdLMDY0TkpBR2RVWUts?=
 =?utf-8?B?eEhmK3AzWjdmMTJYUzJQOW9HWGZvSlZHRmVJaUxwSGloamZFNGNPN3FDSUtQ?=
 =?utf-8?B?OWRmblJHNzllS2V2MStpeG5NSnN2ZHJ2NEtPYWJ5WU9aZHV5cUNVOXd6K2py?=
 =?utf-8?B?WGpZbTlORElsWFpKUlA5eEhNMlp3OEpUTVJNVTFFcXFPVE5neWNHa3FjemJi?=
 =?utf-8?B?M0puUW1qT3c0bUc2YWsrNW9lcnVFN3U2R25CWTNXVnNJTnF3RjB2dlNUY1pn?=
 =?utf-8?B?ODIwM08vVTNhSkZQS3ZHVTRuMmhRaFBGOW9yMTdNUlExS3JFMmJma0ZNZEFJ?=
 =?utf-8?B?OVpoaFlPM1c2QmVVeTl6a0JwYVVwY0xlaUhWNVNzNWZ1QUdQRUVGOE5EdWtD?=
 =?utf-8?B?eHkxeFpzcEFFaTdBelc5U2NCQkNsQmVrNlpndXlnR2k2NmV1UGJ2V0c1Nmxo?=
 =?utf-8?B?akpNM1RIb2xsVWFESGlHTGk1SHRJSlJQUVV4YXhhRms5K2xBb1FQNE90Y01O?=
 =?utf-8?B?MGxubm9PcTRaZ2ZOb1JSVDlucmF4ZFAvU3NuSHRrZUVkNjRoMWc2ei85YjRO?=
 =?utf-8?B?aDJ2VjFCQ0ZYVU42RmtwR0o0RllKa3MrdDU1K0VieCtsV256MzlRQ3pwcGN4?=
 =?utf-8?B?WDJPUmVVeWErODBVYnYzelpoMlVlVCtxOTloUElzTWVNVTJKb0ZjT1NLMVhP?=
 =?utf-8?B?RmdDY2lKbXl1UUFocEJDS2FVNmRFRGEzZXE0aExPWnhpVnJFMkFuL0dZL0lW?=
 =?utf-8?B?bk1GR3l4TnJNUG1kZG81cTFoQkpaTlJGQ0I5SHNlbmNBdEhqVWFObTBhZlFo?=
 =?utf-8?B?azdKYUQyeVU5ZnVlTG0wb1hKRzg1M3JIbWdhdGx0QWFlbm9ybWx6Z0NaL1Yw?=
 =?utf-8?B?MDMzTjVkb0MrdHlCb0dUdDZBSE9TN1pRcHNGUDdLZzdlNGNkaFBYZk95WkE1?=
 =?utf-8?B?UWhxWk9UMWFSRzV0VWExQ3ZvVDV0SW9kR0VUTG5HRW5zREVOakJZaTJyek1i?=
 =?utf-8?B?dW1uRjVQZ0RYRnlua1B4RkpOZnZreElIRnorUytNeUpGV3RlWC9EQ1Voay9q?=
 =?utf-8?B?VW5BVzl0YU14a3AvWGM5WlBJbW1zd25pT25JZUJPY0g0SVgveWNRTmJtdUJt?=
 =?utf-8?B?RDR2TXVTQjlZc3VqUjlxbDV3WEZFTzFwM0FjU0UwQkpmMEVvdlNaZXVqM1NI?=
 =?utf-8?B?dFAyOEo0dGQ2cXR6QXdEdG82NG1kZERQS0pyWHB3NDBUYWYvQkNmMUdEMFNG?=
 =?utf-8?B?bzNQWmVhei9VUWlxUjNMdUZ6QUhjQUFubURvZVRGaE0yQnc2WlZzekZRelNR?=
 =?utf-8?B?aWR6UXp5UVlUSEYvL3U5cTdjYzNqS2pZaWVYQ3lhZnZJNGhnNklKS2tZQW9z?=
 =?utf-8?B?UGZKcnpxZXIvUVFNTkZ3dVVGMVg4dmJFY2FGNzhvbENuajdOWStlTHp1YXA1?=
 =?utf-8?B?dTIxdVF0UnhBRncyQVFNb3R4KzcvRUFzazJjTXBsbHhtU2dtYVNSSGpmUFVH?=
 =?utf-8?B?RzZibDhGR0lPclRIUUQyeEl1eDFLYVNZSERZQTZPOTVZeFEySHNkWHViSmlD?=
 =?utf-8?B?ZjFDbXU3RngwQmFJZjFvdWhlNHZTbXdMb012L3FZQnJLYnB6dnVNYVphUDB4?=
 =?utf-8?B?d0pxZXVOWWxtMGp4WXZvajZBdnh4VGUyNmR1OFlIZWNOUnJTeGVnalZTYnJp?=
 =?utf-8?Q?ibWrOAioiEklwP5c=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 481e6d04-2cfa-4076-46df-08df4098306c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 08:37:30.2484 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wnsxzUvRPuUqKEm/JkPOotMOg1hnFhkjLUBzZj3H7bFBp/tJrsg+2Tj7o/Zc2PhAmdKTLxyp0yI2Tg/TEz5XPh0OP+2gmQJSi5aetOgzlaA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR03MB5874
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 12-11-2026 13:56, Patrice Chotard wrote:
> From: Patrick Delaunay <patrick.delaunay@foss.st.com>
>
> Export the function mmc_set_capacity to be used after change of
> hardware partition manually requested by 'mmc partconf'.
>
> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>

Reviewed-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>

