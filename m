Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E3B606A31F
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 15:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ZHzpSNc+;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=zyPLsnm3
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9FB5A607C6;
	Tue, 27 Oct 2026 15:21:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y_SzGkO5Cs5Q; Tue, 27 Oct 2026 15:21:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9D87E607C1
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793114464;
	b=ebCWepkZCUVBFp/+nuj5jAiootW2uvR7C1tJ+VF9donXXtCafFE+b1N7q/h8zr29Ud0k
	 C2BoS0LjZg/0aK73zvY22cFe4bjAmhMqD/YaJJj4cfbLYuxolEvhNdhg15cRpXI/YEuWW
	 gmdMCV8LqhJuFOdJOwk0j9qvNy5wjsa7BlA8VeI58DRlbx/GYlVbQdmhiK9Id5KoDzqO3
	 XMg2JJNo8jGkosOHBi3a1HZBUn4AWea/u1hkfa2Y0p+Q9AUcyWaBBXVjxfr+J3jMyYrIO
	 cknD6CunSV3NkUxAMUgSU/tCtG1hMnUfDQk8lmFBcmNYz7XyJxAjUaR0HuHgp4t0ydg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793114464;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=F0royw1BsH8p0gZM/VdEOx9tnp7+H5FUaC18kUpbbwQ=;
	b=eMMLBTyJ1h7S3z+DAn715WRirgP28vcCgUUiRnkANr9o0WB6giVtU71LDSic+kptAs+w
	 NuEtiIPy29KKc+hl/ID6mEI6pFWTuURJMoS9XHSLd34VLAVxLcu4EAksmAdzC8uFX1gcn
	 ThXoFKfXh925I49qse4WsAbgoQOnPud1wYbO6YGoaz3r8Zfmyhzh737+U4SoFHx3QdLCS
	 lMVlcaBl5oqpzvR5x4kyIV9QUX73OXyuDtGlH/La4qqydInxB0CRi6AB9Zk6tNPwwmxGr
	 gBvw45JLJONhIfTi2tcGw9SMA9mlXriTow5Oeauvhw6B7hjdQ9/LMPZOS0vowidMF9Q==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=zyPLsnm3;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793114464;
	bh=F0royw1BsH8p0gZM/VdEOx9tnp7+H5FUaC18kUpbbwQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZHzpSNc+J84dWfxwuTqG/eISXZAR10pwe5vmd2uBWnYNNktC7TuFAMvBUQGOIk9eF
	 7Mt7ePUFHuRV9+Yzn3O4+4M2azRiLI21boCroVxaAg3QW/0w2tFCjzrrMi/fPu1l3l
	 8+7RiK7Dn7cnjxoBmF0JfEiKzq0W8oYXpBxMAHgZoaydotqR9H7eZEXTuH0jr3tigc
	 eIjiRA9J6R+/jTSSy+H/nc+4gUnww0xAGNnddyZ+0VghnutsFkeRko3i4vptJtyuxY
	 z2sJvyvvZ11tmSsJr67o5CtD8p9PLmj7AEd00KByskDWwzeG+RowqC3UeffokIYE+v
	 h6vvdEpBAh5Yw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9D87E607C1;
	Tue, 27 Oct 2026 15:21:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 47146279
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 15:21:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 385F8607C1
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 15:21:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PmwAjCj6LylJ for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 15:21:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7845F607C0
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c105::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793114462;
 b=RCYqyhyNHgHqHFjbFLjX5RMEPu7O3Mcu+PmVNAybl88oTovvFnk7JDTbIaUxkHLZN5wU
 yDMOeY1GQ1T0oIDG4GSuRm4ubTZI9hPlCIKzPGoTcV2aOgJ55FlMI2YpPOV9iUt+/ZrS2
 6DikoKqD+XdTNuED9GkIMxUSpyxz/z2ukvV9B9KEYuqTsjpFVC3Ub79MaFShPvUzNXvQi
 SoH5+ghlpAthGxA3d7r+PevE7vkzktxaBzGeTSMNJYMEYqjPbYSFLnzsKO7/HbZnAkegt
 9+0fdHu3Gr0XALhw1GI6XyZO68iVrNabBM3SoxnAe2SVI33D8ZFwBlSqXa1yEyLEmAg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793114462;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
 bh=F0royw1BsH8p0gZM/VdEOx9tnp7+H5FUaC18kUpbbwQ=;
 b=ixZkpgh5VeZdHbRI8P/jwWi/FZrBkbXL0f8Zxu7GbmUBDu+wpxE3Ne07iWMGztP9N3Jy
 nSHbs7Fin1ZwDkiZBHpDeo6gdID/i1SDgi6hpX1nZczM4YNYxY6x9qje0eTiKCeu66bmI
 ILp3LvBBIuEde9zlbOPFXVhRin6HGdPhJDTnTSG4Kml2D1yf+Kv+F+KHOAVLaMAy28Hhv
 HuFWan9JM9FNnlNrCdetNytq6ED7YQ07oCSFLVGh7YlCs93vePhWL0K0ETK0C2X1vNuPG
 qajcFTFi8eMIz44sP4ROQOPRVNGLnPGPF4uR7TbQF70ZZUbhoDP/FFu2ES2o+bTDhgA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=zyPLsnm3; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c105::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c105::1;
 helo=ch1pr05cu001.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=zyPLsnm3
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7845F607C0
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 15:21:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u5DyyoIw1ekKIiqQfWG8Oiuy9X0SW3fAtxaug+QuGF9aGbQP8KjEMIe18svnJlwJkocc+3G1pnwY/8TqyFIL/C3KCc/trJ5lPHLnt3ffEiGWk6U7Akr7du7eQa1cj07C+RDZcPI6OQIBZoDhFJGJYSWl5n95eyZPSp6NwydjD/EkH7hbV1x15UKL04GuSII10ywqSEbNxwv+lP7ih6FAN/hHMZo3YiJe0PvlUYiYsmxjc0ijZ2AUlqDgYHtAapD3XsASTDmLtXnz8gnEoqFk5NM32LZd4zwwTRycdM0ZtWtZZkKXWwSSA79QL9C5ehQ/tAu0Oca4HBCGyIJAfdiH6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F0royw1BsH8p0gZM/VdEOx9tnp7+H5FUaC18kUpbbwQ=;
 b=XAMVEtj9IDNimXqYYSTZmmXnxmnxVJRCKEDZCjWUbz0AkDWpFf3wEm95xvKxRPcAGQetOTEN8Dq3hwYB052w5I4ZpzD+kup3J9pip4BUiHCY4k/snZUXos3maMhrpPfscOY5khcFUVyr3IIFWkNBvc0vdFGAmnG31uPGVj1uZCJDm8cnF6GPzvaluBVLR5l0C8JoyAKE0eeNlkJwhDo1UH0uMlHjJP8KEhGgvjwwOhKwnmWjUAZ0I06ci+E7l6jP6XRCznlYYkk6MpXELoDn9XDiJVPJoUxiXJVCtg1o7Sppt/VEgFQLE5nUXkH2Ic2M2yKKaNqLhyZ+l01yUEH3Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F0royw1BsH8p0gZM/VdEOx9tnp7+H5FUaC18kUpbbwQ=;
 b=zyPLsnm3mlh31sqp2c5JAYtfuniC34i1c1Wzpy8J2XLX1ytGOxa1dNgKjbyhvWnPCmEXJk1tmuJoxl421PfneXLUA9/u1rG1lVUQYmETSHfY2+2IGoOJz00MzaMzu85jonWDRKJi7h9MDDzRCH8N+JV/ovvDDd3qzd7p5QtamQo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by SJ1PR12MB6146.namprd12.prod.outlook.com (2603:10b6:a03:45b::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 15:20:53 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%5]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 15:20:53 +0000
Message-ID: <60feed8a-6c44-47da-80cd-03b5179c11ea@amd.com>
Date: Tue, 27 Oct 2026 16:20:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 00/26] usb: dwc3: part 2, make the resynced code work
To: Marek Vasut <marek.vasut@mailbox.org>,
 Anders Roxell <anders.roxell@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.u-boot-project.org, trini@konsulko.com,
 ilias.apalodimas@linaro.org, alchark@flipper.net, jerome.forissier@arm.com,
 dlechner@baylibre.com, anshuld@ti.com, sjg@chromium.org,
 Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org, love.kumar@amd.com,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, Nishanth Menon
 <nm@ti.com>, Patrice CHOTARD <patrice.chotard@foss.st.com>,
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 Casey Connolly <casey.connolly@linaro.org>, Jonas Karlman <jonas@kwiboo.se>,
 Peng Fan <peng.fan@nxp.com>, Mark Kettenis <kettenis@openbsd.org>,
 Janne Grunau <j@jannau.net>, Chin-Liang See <clsee@altera.com>,
 "Chee, Tien Fong" <tien.fong.chee@intel.com>,
 "dinguyen@kernel.org" <dinguyen@kernel.org>
References: <20260916123826.517181-1-anders.roxell@linaro.org>
 <80e9e892-24de-4cba-b84a-35bdcb6a903c@cherry.de> <as4r8p_70JTOl068@monster>
 <50db221f-8e06-4519-a44f-5ee36b8f3df3@mailbox.org>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <50db221f-8e06-4519-a44f-5ee36b8f3df3@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY1P220CA0050.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59e::12) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|SJ1PR12MB6146:EE_
X-MS-Office365-Filtering-Correlation-Id: e4444156-c7f0-46f9-e803-08df343de433
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|23010399003|376014|18002099003|22082099003|261026121527099003|10067099003|261022105027099003|56012099006|4143699003|11063799006|261009223027099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: B2ZuubFzbJTYl/B4ogKXEgF+Yp12YHTqn+XWzFKLJybigALT8z/HeZigQfWLr0TLwTLadrOn6ASx1MLL9F/tksXwWdFGPldkeN/tNo2nRIK449kx4U6YBsq+aLzxFQcwtg7+nePTyk+YXS293T3vIoDh7U0tgeynser6NpT7Oa5gPgGE/wd0shRQos4MVTK0gHRKMT7wlEZQPg9Nyl2ZPBY3PLA9PMqfhiGN/UKYBX/HkKbWd43DUKGuyXp1OheM/SXddFvlbyNFj9UozQNOkbnrU7lcn+RrG6t1RojeI5dR2naz7wM5iGKanJwh/86ik28S6Kukyjm9wR17krrFkn5OO2QYV5u4MdvOQMHvooYR8AVqcOadfVYyjFymFYvrvlRRWU7g2JPayHfU6LhY416XmZVn3IgTYipFM64AAc2sPe+OkMz+/pbxcFIj1z7BJa/IuO3XI+LTsEUWWUPq2mZz5K64Z2FiMH0dY6OFmXQAeOtevA2KIpJxhmKZjzG1SOMlxMYgt1triqbyaU5QK44VurnDMa1A2PoWEfEOx/vupQORsyPFvyJIkkzJsAcWAw5mSwHeKOCW+HhVhWY/XDk7q8YWMUowDs2mH2lWK4w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(23010399003)(376014)(18002099003)(22082099003)(261026121527099003)(10067099003)(261022105027099003)(56012099006)(4143699003)(11063799006)(261009223027099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SW9QSkZFSkJCcjdUcEZRSm9pSU9mMUZoelErS2FzdTk3S01TMitNbXRvZkEw?=
 =?utf-8?B?U2xTR041NGJZb3QzQk92NlU1ci9rTXZVVU80NGdKN2FGYlBPRVVJdUVUR1lD?=
 =?utf-8?B?S2tmK2lJdWJKVmcvaWo3NVZ5bUpnVkxWWHl6ckYzTzJZcTFnV2NiMHN0M1dh?=
 =?utf-8?B?cHBVaW56Q05SdzIxMHpjakc3TkI3VEdGK0VsQ0hjbUdycGNKZmx6OUdoUHMv?=
 =?utf-8?B?Q3Q5VFFXN1ZWTGcwaUY0NFIxUXdRVGVTZ1NxcEtUcUM5S1JWRnVNRzB3Mng1?=
 =?utf-8?B?ZTZWcU9KUFJVblk3dEFVaFl4ZjIrRmdsZVNKRS9XYkllRTAxNW1uazBHMURs?=
 =?utf-8?B?MFZUdXY4VXg0VmFKNXVGV2J3VGVOMCsxVEh5SytuNFlUenRadTNDc1lWbWlZ?=
 =?utf-8?B?a0t4Ym4vSy9Md2RlcGszUEZyRXBFc3JkZnVOZk80WjJadCs3dk80bWFmbUlC?=
 =?utf-8?B?ZmhkV0wzaUhEb3FzckwrLzhSRjBXamdlRmQ1OXR6TXYwTmZCNUp0QWNuUG00?=
 =?utf-8?B?bTE0dm5XZ3lZOTlhRWZ6cElNT2pGOVNHQkgvTVNsNmRQUkYyZWtCM0R3aEtS?=
 =?utf-8?B?T2tLMzVGSTRJMzU2cmhJZ3ZHZHV0UkEzK2E1dWNVaHFoQXowL0lNbktRMG5u?=
 =?utf-8?B?KzJmaGczS1hWNDZoTFFSWlIrbVA4dmFrYnZpdEdtMzVKaVVvaHJSaitDSW81?=
 =?utf-8?B?MjNmcHhobFFDbGhVR0RaU2w3SkpFY1JyRVR3c2craEZncVNVbWg3SUxaL2Qy?=
 =?utf-8?B?YXpmWHA4TnJneTNRaGpCNmZQWEF3c25PbEc4OVNDN05XYnpnMitDRnZTNXlh?=
 =?utf-8?B?em16V0lZcTcwbDQxQUs1bE44WHJpRVRhL0YrUXVlMjBmZmJvRFI3ZVk2L2pa?=
 =?utf-8?B?VU5SZnRDdUY5MWNxMXFXR2xMRFdod3pZN1owWERDWXJ3Yi9pdmlNdHpzMDlq?=
 =?utf-8?B?WnlRUjZrV3pxM3BIdWhNZ0JUME5kYjA0aGE3REFaQWpJV1ArY1dodkxuRFNS?=
 =?utf-8?B?SkgzdndOVUU2RFZCSlM1dndDekdlL2JjdkVhemxCRms3aEFlN0JiQndsRys4?=
 =?utf-8?B?cEhnVTBkMDdQRjlJeFd0QjBMYlVkZnd5dDlHUkUyUmQxOWc0eG00OEtLNkx2?=
 =?utf-8?B?d1dSa1JWWWZRYzdvUEFUU0gzSEZvMzVFejRlQ1NVeUV4eVFkcW9GWVc0QjFk?=
 =?utf-8?B?cXpQY3F1clJOTWE0MUw3aU5GNEFVNGVYbUZ5UC9UZUJ4TXYyNFdyRFdzUkJC?=
 =?utf-8?B?WHpjUnVkSmtJZWNlWlQ4S1hPMVUzSXJMMUZyOUYybWVEdUVwYSt2N0VPdExM?=
 =?utf-8?B?SUlvUGo1T3VoMzhaVGt6NUFBWm02YWhjYnI5OWRkcDQ1eE1Nb3ZwOHFydjdo?=
 =?utf-8?B?eVRNZ1lkZ1N1dklGV0xZM3dTYUFKZGU5aGJpVUVzRnU2b1lIMVlJNWhrZjFC?=
 =?utf-8?B?bjhIclJRa3FDTnJidTJXVkJseW5IazNIYWlxNmkzQ29Hdi9ZS3U1SEhHY1lU?=
 =?utf-8?B?UHI3QnRFK1JZWk5HcFpUTUpVRkVmelpyV0R0b2NDRGxnVEVtaUNTUVdCdllS?=
 =?utf-8?B?S3BhRkNaUWdGdmk5aWpGekwxVzhXT1hxcnRNSEFhZ0ZRUDR0UW4yb3NzdXUw?=
 =?utf-8?B?VGVIeFBXSFZEZmFFVFI4cXZGR0p0RXJCRWJrMk85NEJoK3htS012eGN1ajZ2?=
 =?utf-8?B?RWRNcmQ2aHV5ekxpTUpVdlZWMkVVK2VZeUFlV1hCeFIxZ1NSdU9tZ3BIU0pR?=
 =?utf-8?B?L2NTbmJ3MFJpOVBybHpXZTVHTnFjTlhmQk1HbnlxV1pudkkzNlh2T1ZvRkJa?=
 =?utf-8?B?YndnakF3WlByWDFKR0wwUTZTWEdGUEN2Mjk4K28rZXNvWm8yMy9vQVpnenQ4?=
 =?utf-8?B?S3FGNnBMWVdob242SG9GUFFTN2FHOVhIckR6Vk8zb2tiSTJ6QUoxWjBHajY3?=
 =?utf-8?B?RmljcXM3bE5qL0NZWW81eGZtbjRLajZqZzlpdlpUbDVhOEFUSmpUSDlvT0lV?=
 =?utf-8?B?UHNNa29oMjRNL1JpK3AwaVlZVG94dEZWUnJxa21hQ005T29rMlNUNmJEdGli?=
 =?utf-8?B?MnVIOVRqS3J1elpuRXp3cVh4dkZpcHJUbk5RS3pWWVgvb2ZEY3JMQjhsZVdY?=
 =?utf-8?B?QUdoMjhNRTNtL1BFRE5CWWU3M25mRkluZGI1VEI2RVNMQmIydmxlWXBBVk1S?=
 =?utf-8?B?dW1uQ1hTRHYzSmNzWHN2MHQ5d2ptbFZuV3hzdFZkQjV6cEpFSGF0WHJRSVBG?=
 =?utf-8?B?dzd6STZ6dnpENE8ycS9nVGRkSitFUjNyeDFvUVlmSHhxTUt0YnIxWFV5c3ZS?=
 =?utf-8?B?cGs5UjJCMnNZWk9KamFpMlZ0VjlnZHVKSTQ2ekpqNUFSTWFQRHdEZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4444156-c7f0-46f9-e803-08df343de433
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 15:20:53.7500 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 36nXjiZulHjepmdOrAMoF7JJ8uQ50fsA70BnValXnP7zUJhLDVk0BHZ/RC6k8bAq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6146
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Marek,

On 10/17/26 16:29, Marek Vasut wrote:
> On 10/13/26 3:02 PM, Anders Roxell wrote:
> 
> Hello everyone,
> 
> [...]
> 
>>> Total of 4096 double word(s) were the same
>>>
>>> I also have two SanDisk Corp. Ultra Flair that are USB3 but they are
>>> consistently detected as USB2 in U-Boot for some reason.
>>
>> Same without my patches?
>>
>> No rush, I know you are away for a month.
> 
> I would like to move this series forward, so let me get input on the status. 
> Below are the vendors which use DWC3 core that I could find in tree, can I get a 
> go/no-go on this series from each of you ? I hope the CC is complete, if not, 
> please add the missing people.
> 
> allwinner
> altera
> amlogic
> apple
> broadcom
> exynos
> freescale
> microchip
> qcom
> rockchip
> socionext
> st
> ti
> xilinx

No issue from AMD/Xilinx side. Would be good to get it to 2027.01 version.

Here are Tested-by tags from Love.
https://lore.kernel.org/r/9fa15c90-b725-4ac2-b4c5-f388d5319fd8@amd.com
https://lore.kernel.org/r/140c9bb9-756a-4000-acd8-a1893cb98801@amd.com

Thanks,
Michal
