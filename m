Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6A5609A730
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 15:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=zE0DUPg3;
	dkim=pass (2048-bit key, unprotected) header.d=kontron.de header.i=@kontron.de header.a=rsa-sha256 header.s=selector1 header.b=PXVyT6mR
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A3F4F607C0;
	Mon,  2 Nov 2026 15:26:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YPCY0PXAIeFt; Mon,  2 Nov 2026 15:26:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D06BE60669
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793633171;
	b=VhAQDGvpYUYo1fATTJrY20CItegCjESbtdHtp3nM5A58/0kJQYmiYwKhd2YhOXFbXkBK
	 Y4Isv1foPqumycRKnOn9A3rdMPzzbGPLPu/QcdcuHpaJweNUNCtlg9vGAT0wiCwWEPDyb
	 uWVcsE5lC6HwWAl9Y0JeGNPjtWqnxoDiWihnAYupnxl9yh7muohk1+menGzf+8Z4iDUKI
	 ZlTpv91NV/szejCG0tPgspEHAlCZLQxiN4jZrcBtvHR43AT055SCR7ZkoFpSjkRCfbVRL
	 A2WS0Vby4RigqmsXBB6vVu0MpAx9PGCiIXjSEIrCJ8xwj+MQrzMyijQEXOHw/00awVw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793633171;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
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
	bh=qhVeL6MOtDUg5jnBN/Epp0WofuZDCjB47N4eVEIOWP8=;
	b=l5N0AL7P8QI8zVjpJq5uaKgZqn2YJLaSXrb309nCVoYGbzoaxWx16q5hOej4wFRnXxIT
	 yHeg/BQIp2fQN05irrn0OSAfa+UJZfep2VWXkW3skKN0qRdfn00CcobXdIR8d3B7zHNVB
	 Hk5fN5lc4h3Uue0AF29jZyF4qQH/3ARoinT3o/VpupBAIIkLf5ocByOkhnlSy53F+A95e
	 ptQfyNk4vjoLloopC8Jemr6dWC1sYr35KPfF4q/V+OItudUvNNnn5u8RXetDctAGUfYQl
	 m14/Pv7k6ZvQatpVZyH/ncZ5M7DzJ89Z8jfqoG9Eso2Tjhg8bAZXXULAGivq6SbtBTA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793633170;
	bh=qhVeL6MOtDUg5jnBN/Epp0WofuZDCjB47N4eVEIOWP8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zE0DUPg3n7igZCJ7sHQ2sD3GV8WN3lOAdVMzRiIshbb78g2T6jg6K+wow80ASGtB5
	 /zbq83Uo86RtkrEQCrD7wnUZc3jEqa5P+bxbd88tZY2Rl4zsKWtDxSK3DDFYoWzh8x
	 JOhEFr3PUi0tiJfShI4TKzizFZDvXxgxKHn3CpXa3yDmQ7E3Ijq01RXk3Tq9oHA3xt
	 dv+QNf8fvrUWrmUpfDOMQso5MyKPB3uaWhdVRs8gW9IfwuWHt20nZQIvgdtasAMCMa
	 glF+fUmQ0EtNcTnjn8dbkA8ICCTqE39PIsoa6+X+Fd0MDLmRRPWWWJ6dM4Ju1RAuF5
	 na/xejj3H5SZQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D06BE60669;
	Mon,  2 Nov 2026 15:26:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7574F2A8
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 15:26:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 66DAD81080
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 15:26:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hfPnkwuYL9d6 for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 15:26:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1ED5180F92
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c207::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793633168;
 b=hf9BTWpPb2Wk0XdON3eTm9p2PvGN6zWciJ8FTBSIxnz7j5BvkwaxM4re3RQSpoGyVPIK
 Wd9qq7FiKfAX2cXTl8FGw2W9PSvK4yIfG+UQopLozHNWCes/6PIFQhIlH2TPu2MYnXTAa
 pHN+KIy0cOYiiLGHKAgl+X/l9agslHnRjHl/QKtrwb1gXEK8a4I9xjQp02sV4dX6I72Xl
 Cp5yg+hSi00ikIVPClCQFv3X8LWmysfGe0K9XC9mRU49dyRH01Zpa6od3meyWfSq00LsC
 i9HihP8c+m7eFJU8qSHyCozUo7Okb6g+GhBCw7k3EzO4vP5nNfaC+wzm5f5hpehTt/Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793633168;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=qhVeL6MOtDUg5jnBN/Epp0WofuZDCjB47N4eVEIOWP8=;
 b=HUuxs2BbXjAWV80Q2qReZqGOtslz4p0LkLrKLVm1l2hPdWA5m3rWqVnGJ7/Or+8kdKz4
 JSQ0wgKdvOZ7vcmDVukUlqcAiOa4XS/NRDvJA3dkb3qkr2PmuwFp2RhaNIKRR6nCjK5H1
 ERameefCvnyGD84pFKRPj9z89OwaAUypiQLWn9PufLF4fie2ivQFj8sNntpDL9TXYYFe3
 7yW/P56Jjd2lp1IjJOihjpEZen3Y7XxyMO4wY1WPulCmp3wsUAFY00ezM9UP8a0o7JDUt
 2kVsWnnyMFkBJAFv6jwGcNG7rzzYn3i49lf2jP4fFZmPjjU93+UdClx69iO71363BRA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=none header.from=kontron.de;
 dkim=pass header.d=kontron.de header.i=@kontron.de header.a=rsa-sha256
 header.s=selector1 header.b=PXVyT6mR; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c207::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=frieder.schrempf@kontron.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kontron.de header.i=@kontron.de header.a=rsa-sha256
 header.s=selector1 header.b=PXVyT6mR
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1ED5180F92
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 15:26:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LbWuqw9E7NXo4h9yyCqmDMuRVA0oBaIBQMANdZAEQzRqfSFNPJGeHabIgN8HC03sQxOQpO5ONBE9bZp6EjMRX+NF47fhembBFFULU+aLgUG+Wv3p8njfBjfC5xYO8b1C63GW3V9fKhQDYoK5gquTbXLo0lArjhnpewhg5rGv1KDETDht3D/m8fQ02eBV6YZB87qcuiCKr+d3L8Wq7ABmuwkb2pLm6pNdS9TgpiGud+tMt5L986xkmPBon0gNyr5if/VBWQ36kSRGJN+9Xh+bjVwCl7gCAWcIEaqxos0T0cZ92u2WjvM9ZgDeOuIvxTWpPy4R7hOPKZSMzUZIfmfmcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qhVeL6MOtDUg5jnBN/Epp0WofuZDCjB47N4eVEIOWP8=;
 b=n8vT19UAVeft4efBTPFu7xOTA/LMlBivCG+ZSnZI0Cf9KDNvkAcFVNNYhYW+gPPKTh4D9GmcflunZOfyzdhFQzPefnvD8Qi1KP3hr7TC4rnnb85+kdyDH1bTjCLfsM4MvEOl13qi+XRWf77fCxk8NmXgr45m/Lpe9eHrgqMvGI0xMoaMkWPF8ZJ3gY9H8Cmy6A9EYMnfq4mW6aqYxvggEXnz3oXRf3/9PvS8kbjcp5GtSbMm8tx5zmQsJJ7vb0hy+Var5+L7m2j9dmmO0KkHGG0zPJa/sDyRZ5VhCqk5n72mos7InhH98+Y/2jAVadIdDxMsnHXRVazmVacgNjcIzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qhVeL6MOtDUg5jnBN/Epp0WofuZDCjB47N4eVEIOWP8=;
 b=PXVyT6mR7EQchL7s9f5XyFxL+HGUm5y7XbJoTuGsdxLC+UUgz4MYpYEw4nEOiviKw9Z5MHV4NkhcDf0PlCbxNVluiXP4Yx3fWPvAh4sK+j/DmZuJRRT2pf4YsFwc+oNLvETBLnNvDWwabbvKR/HrW1z9ebXg86xbBJ22nzryzPG8FKS7MP8mGnzvNdloJH7RvMyf1RfwgP4fFG72kbk77wzTLgm3YSmpzU7akAFONO+XQOv/Gvm7qyNMRkntGQht3GSuDTYl6hXg+7iXpsqTnXiRF+fFCgKGeDgB6Lw7dUsjRyBycwDvugr/N6ANpHw4XN0N02jgwUU+eRUQGa15uw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1fb::23)
 by DB8PR10MB3546.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:13f::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Mon, 2 Nov 2026
 15:26:01 +0000
Received: from AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a276:4ad7:962:da22]) by AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a276:4ad7:962:da22%3]) with mapi id 15.21.0592.007; Mon, 2 Nov 2026
 15:26:01 +0000
Message-ID: <a9d7495f-cb30-43a4-8aae-e6eadfe7bfeb@kontron.de>
Date: Mon, 2 Nov 2026 16:26:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] bootstd: rauc: Optionally check the partition names
To: Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Frieder Schrempf <frieder@fris.de>, Martin Schwan <m.schwan@phytec.de>,
 u-boot@lists.u-boot-project.org
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Aristo Chen <aristo.chen@canonical.com>, Alexey Charkov
 <alchark@flipper.net>, Daniel Golle <daniel@makrotopia.org>,
 Johan Jonker <jbx6244@gmail.com>, Francesco Valla <francesco@valla.it>,
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
References: <20261029-main-v1-0-b5a878627107@kontron.de>
 <20261029-main-v1-6-b5a878627107@kontron.de>
 <db177de8-a6ec-4600-badc-840629e1d6f6@bootlin.com>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <db177de8-a6ec-4600-badc-840629e1d6f6@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0079.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::19) To AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1fb::23)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4277:EE_|DB8PR10MB3546:EE_
X-MS-Office365-Filtering-Correlation-Id: 97fab967-514d-406e-48bb-08df38f59a1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|7416014|376014|261021121427099003|261021123027099003|4143699003|11063799006|56012099006|261009223027099003|261028144727099003|261026121527099003|261022105027099003|261022075727099003|261026140227099003|261022115727099003|10067099003|22082099003|18002099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: uvSjli1XtIdMeOiGyrqr3hMnTHnvqvkglzfqXFT/gpxt5JmApxsyplNvLEkOjQOMNxuOXUVTsDKkmnQqV+H6Fu0zI68wmZykwICkFOz0lHKbL48LMtGuNcV+PtywGUdpnacCXGd+uehYMibQrwYYUx+p6W4HaV9sEJfnlX5HWsL9qId1dNi7DGYIKV+U101zdaIg7cyKb8eUXOl3YHxpztGyKoaI0Z9ceBsTXAO4LrmtQsZ/E17Ue40PpKffTo5ZboIXXZ26GfOZY4wq7wYGXRg7sVEwko2zPyAKMkYsjzgRASJLDwSa+bPeDLihAiYovkTQxm7rkI+uFq8pWInexgvPmeffwAbzDrluP7dQa6w44mmGk+PMU0K/VUSA3mKRTSC2sJMLLa4uAACJ8gnxyuuPViRRKMr7ilQrHaDyD+HDQYiyBie1GSgYG7qrIhcncUGfHOrRn52O1VWCXOrsiQpogwFb+5pYWn8O9kMVM5g76rZOy/Ul5fLPVDmWHK8li4g6A30Lm56/wiZvG9CQJLdOZE85d/9c9/3ACcnWZ9TqYGykrgkeeRwyOIMyvb9HYXlF+Yogq723SP8we9SPkY6anNfPskRif+kZK0pnMhYTYGFtP6hCKsfg6EIH6ZDiTsWweVb5b6gLMjabuEouqCPtUmYaExVviXSdS5MyCEE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(261021121427099003)(261021123027099003)(4143699003)(11063799006)(56012099006)(261009223027099003)(261028144727099003)(261026121527099003)(261022105027099003)(261022075727099003)(261026140227099003)(261022115727099003)(10067099003)(22082099003)(18002099003)(261102123227099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3QxR0VNQS80VDkyRGlBby83cmhFL1ZlRzFIZ01LQ1lmdXRmeUNMMVl6djZ5?=
 =?utf-8?B?VE1WT0lzbURPUWpvd3Y5cndVeThrQXU1ZGpJSEc1QjYxYzJMbUJ0eElRdEth?=
 =?utf-8?B?eHpEK0Y2WkF4VFpKZ08vZUNVRzB0d1Zjc29wSFkxaXBxUVhiL1JhSEttS2J5?=
 =?utf-8?B?Tmc3NWoyajNiWmtZcFQ3QnRydkRrbmM0ajBoa1FnREJuMW45VndkTHRTL1NI?=
 =?utf-8?B?RWhaUVZ6SVNrYUM0Tlk3SnFoait3aXl1c2pHTlR4NC9Kb05YZFlxcEREeWNT?=
 =?utf-8?B?OEZjQ01jWGFRVGVnMmphdUlQQUhDMTVQczMvYzUrQjQxNFdsb3k5YjNBbFdZ?=
 =?utf-8?B?bW5QOGg2MTBnT01FNExrcHFrTXEveVYrcHI3eCtxeUZZTzYzTkVHajdacmFP?=
 =?utf-8?B?VGxkcHJrOWs1QWFRaGZKcVR2dGZMTm02bmxZQ3A4Tm1WSExhZ2FRNUx4K0Jz?=
 =?utf-8?B?SjV4bmtmcCt0VFFpUmlNM0ZmQUJBdm5wWGxPUVZlMExGa3ZLbDlaNy9oeFBm?=
 =?utf-8?B?OUNLWnZCZGJwNmMxQVFYYlJMb3BjY1pIenlpam5hZUdUb09WcmgxTzRJVTNE?=
 =?utf-8?B?UEhvU01QNVRnb1EwMjZWWDdsd2ZzbUJCWVA3MGh0WWVtbkpPaFBkOTJDcnE4?=
 =?utf-8?B?L2k5Yk1WeWtZVkxxNUhFRlRwTnlWN3dvYXdMN2RvWk5Uem9xam9XRUZ4WUNY?=
 =?utf-8?B?K3VNOUlmMHRtQUpoNXozSzNlTisxZWJhT2NCUFVCZkozYWtJNUlsdUEyZDVE?=
 =?utf-8?B?RXNFb1QwOUJxV3VwZCtlRGRZaFM3Nk1LVFR2NU4rcjlNY21HRlVGK2FkRXlV?=
 =?utf-8?B?KzJqdHlMeFg1eVlkQzBTbmY3Rk93dlBoUGcrOHNlSldhZWV6eHk0VjVtcjVC?=
 =?utf-8?B?MTdRNFhGRlljUUExUkpzVENiNXcwTVJ1OGVUU1BQUDNTajFEKy9TWnZ0cUx0?=
 =?utf-8?B?SWNhN1hSQ2RWV2Y4TG9yNEFlZm9jRjlMRVIya0krUWN5Wm9jN0JSUmt5OFlm?=
 =?utf-8?B?QVJFUTBrcDh4V0lvSGlJQUJWTW9Cb0FYYkhiSng3Ym96aVZwL1dwcE83NjF0?=
 =?utf-8?B?R3hWK2FhV0p2NXRsNmdxS3c1cE9lSC9HcytuTnJlVkswWlRvcUUzNFdpNkVL?=
 =?utf-8?B?V2JaT0creDhGeHZiN1VQN1dROVpFU25EME9yRHJ1VUpXMEx5MlhPRVlPQ0pM?=
 =?utf-8?B?NkF0blUvSE9OVHhrUjZ5QVRRZTNxWkVNTFViOVYwWHFycFpseGxVSUtRNEtD?=
 =?utf-8?B?Sm5HZ0M2YzR6T3F5NDdUUENkZGllN2NKdGptRjFDeWU5SDl3QWZMVFNMRFhZ?=
 =?utf-8?B?NVVlUEtROFNPWlZmTW5Va0ZXbVkrMlR2THdVRzlEemE2cjdKQUdVUXFxZ0pP?=
 =?utf-8?B?c2sza0N6RWkrYjlmUXFGYXdVajBaTlliejY2OWFFaUE3NFNYNUlxWUx5MEJW?=
 =?utf-8?B?SEFEelhSSEhlUklDR0xrSUx1dStidDgyaVFLYXBEZHhvTlRiUzlhRFRndmRH?=
 =?utf-8?B?TEdYaE1lWGFZYW51YVR4bXpJdU9jTFNiQyt5U2pUbnZaM2NYUE9DUnhUZW1a?=
 =?utf-8?B?RXNBUWlnUHkwelFrYUtuZVZJZXdONXRIMlBiVjBJYklRbXV4dW1qb1lyMmgx?=
 =?utf-8?B?UlJ3SmpQOWRLdnpvaXdJaGp2MFZxRzdPUmh1SXlTaXY1cEdWRE1VSHNCUHBN?=
 =?utf-8?B?ZHcrQVpSVFZTY1ZHTUFkakxzM1diNEJlNGdZWHRaMU1OT0xyQXhtQWZPS1gz?=
 =?utf-8?B?a3krbE9JNTRQb0MrbkQycmJlQk5tWSsyb0QvZnJXQm8yczh4YlZPQ0V4bWpW?=
 =?utf-8?B?VTdiVVVCSjhGaXNZeTJqWFFCWVNIaEMxaEl2VlNia1dlRkJiTUFUUTJwS3N2?=
 =?utf-8?B?ZVJWS1hQajN1N2ppRi9LcXBuYndUdFc2UGdLVCt4dnh5cXU2K3NsUFlxdmda?=
 =?utf-8?B?WXpLbmUrd2VLRHlzTXJFZ1dyQ0FQeHF3QkNvWkY5YmZtNk9PZVhyYkx5VWFE?=
 =?utf-8?B?R1VVbHkzK1ROcDNsMVZLSU1oSmJaS1ZqMlJtY1hIWHJEY0FyYndKeFFuczUr?=
 =?utf-8?B?eWl2cnppQTBkcmFtcWNyYXdrYjFxWmZuOWpXU0xVekdqZkV3ZW4rbVdGMjU3?=
 =?utf-8?B?MG1UbmcvNTg2b1RXUDAzTWhoRXRNVzFIa2wyTGt0TUExd2VCWlcxUnpFcDFJ?=
 =?utf-8?B?UDZJaktSeGxoclJtRDRRSVFQWENMKzF6eXRwTG1yTEpmcXQ1OFE2WFhHdndF?=
 =?utf-8?B?M0RINlZhMk1YWi9zNlR3QS93NUZ2NDg5VHBBVSsyNVBrQURwK0Q2VHZoNlpo?=
 =?utf-8?B?OWNUZFA1SWxidTl4ZFRwZE1Qam5WSk9ZSHpZcE5aMHJOVnVTM0tUeXp0LytE?=
 =?utf-8?Q?M9hzCVcRa9v7Iv9E=3D?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 97fab967-514d-406e-48bb-08df38f59a1a
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 15:26:01.4460 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qCQbTyvsnft0hMc7R+RGUdCgcaUx0ArJVfotUOzoZ1QiyQcOvWxp5rsG8PHGoFTzlyYaIb9zgHjTPQg/zWw5V+6EAJUiAjD3M2Gm4ZCEDg8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3546
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Bastien,

On 02.11.26 11:03, Bastien Curutchet wrote:
> Hi Frieder,
> 
> On 10/29/26 5:23 PM, Frieder Schrempf wrote:
>> From: Frieder Schrempf <frieder.schrempf@kontron.de>
>>
>> The RAUC bootmeth uses any MMC device on which the boot partition of a
>> slot holds a filesystem and the root partition exists. This also matches
>> devices with a different layout, for example a single-system image or a
>> standard distro installed to eMMC. The bootmeth then claims such a
>> device and creates and saves its BOOT_ORDER and BOOT_x_LEFT variables in
>> the environment, which makes it difficult to run BOOTMETH_RAUC alongside
>> other bootmeths.
>>
>> Add CONFIG_BOOTMETH_RAUC_PART_NAMES to set the expected names of the
>> boot and root partitions of each slot, in the same format as
>> CONFIG_BOOTMETH_RAUC_PARTITIONS. If set, a slot only counts if its
>> partitions carry these names. As only GPT provides partition names,
>> this also rejects MBR devices. The option is empty by default, which
>> keeps the current behaviour.
>>
>> Assisted-by: LLM
>> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
>> ---
>>   boot/Kconfig                 | 13 +++++++++
>>   boot/bootmeth_rauc.c         | 68 ++++++++++++++++++++++++++++++++++
>> ++++++----
>>   doc/develop/bootstd/rauc.rst |  7 +++++
>>   3 files changed, 82 insertions(+), 6 deletions(-)
>>
>> diff --git a/boot/Kconfig b/boot/Kconfig
>> index 8fcdc36c931..5f89c9d86fa 100644
>> --- a/boot/Kconfig
>> +++ b/boot/Kconfig
>> @@ -968,6 +968,19 @@ config BOOTMETH_RAUC_PARTITIONS
>>         The first value in pair is for the boot partition and second
>> for the
>>         root partition.
>>   +config BOOTMETH_RAUC_PART_NAMES
>> +    string "RAUC boot and root partition names"
>> +    default ""
>> +    help
>> +      Sets the expected names of the boot and root partitions of each
>> slot,
>> +      for example "boot_a,root_a boot_b,root_b". The format is the
>> same as
>> +      for BOOTMETH_RAUC_PARTITIONS, with names instead of indexes,
>> and each
>> +      pair belongs to the slot at the same position.
>> +
>> +      A device is only used if at least one slot's partitions carry
>> these
>> +      names. Partition names are only available on GPT, so this rejects
>> +      MBR devices. Leave this empty to not check the names.
>> +
> 
> This feels a bit redundant to me. CONFIG_BOOTMETH_RAUC_PARTITIONS is
> already a string, I think we could directly use it:
> - If it contains numbers, we go with the default flow
> - If it contains strings, we treat them as partition names
> 
> This would require some changes in distro_rauc_scan_parts() to iterate
> over the partitions until we find the relevant partition names, but IMHO
> the result would be more 'user friendly'.
Thanks for the feedback. I already thought about this and now that I
look at it again, it seems not as complicated as I thought it would be.

The only downside I can think of is, that we can't handle partition
names that only consist of digits. But I think this is acceptable.

I will try to implement this in v2.

Thanks
Frieder
