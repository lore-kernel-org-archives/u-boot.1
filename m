Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A7F608362D
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 18:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=RKlctmlz;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=Uyi+8uR0;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=Uyi+8uR0
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F14A5813C6;
	Fri,  6 Nov 2026 18:08:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Qw18C44nPAEP; Fri,  6 Nov 2026 18:08:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A01AF80BE9
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793988486;
	b=MvowsFxKn0Rue6eIl5U6FQMDTHCJRQtg5v9LV8yK2DT+vUe36rL3DQL40ahlmQ+li1ln
	 zNedCrpJN+CJ7ZTkXBJVY+w0qDJqdTjF+6lV8mg5dr0ivmH3qwYCukBilwUms/sptAs+g
	 tE8Ad4noNQiXMZ6w4xIM7JbWXDVlOhtpWWleI7QUDcfUAR1+f3aUKaWmtPPpQby+6aULq
	 2Jjmjqfn5r88BmZEZwt3wEJrLA9n0l2q3BNWKkoJqGLzRjAvGayCNTn6fG2YYZmJswJk8
	 GdszirCMB4eX7XtVVlfQF4u+s5s/0UVi8/qGIa/Fmw7Sqd3rny3nlF421rVL7tUFrkg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793988486;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:DKIM-Signature:Authentication-Results-Original:
	 Received:Received:Message-ID:Date:User-Agent:From:Subject:To:Cc:
	 References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 x-checkrecipientrouted:NoDisclaimer:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam-Untrusted:
	 X-Microsoft-Antispam-Message-Info-Original:
	 X-Forefront-Antispam-Report-Untrusted:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-EOPAttributedMessage:
	 X-MS-Exchange-Transport-CrossTenantHeadersStripped:
	 X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id-Prvs:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=r7jH24QUA7zEaj3nsRhzhFexl2hENVRPWXJnrAdran8=;
	b=KZ0taji2BU0ZapM1RIGhyhyFu0lWz/V+ZVnjpRRb2aPSrUAjOC6nLAJA+YV3PSlMDnB0
	 XQWoly7kObTfYB85jKJaWw+QJz4oikosSDvZJbIalNSSomnDmPklXOGAsuSGKMfiiBGti
	 0T5ITbqWmnx5LDSseCAQdWfAWKSIL9wZoU899PmOxh7fxZkmSUabPPXzmJ+ad1XGuEiL7
	 OQlJ7at22LtLla2wp4rzHSU5zYnspdlAl99frwuQbQ6F7tPLOt8xIzGQlOC8AOE2l6bya
	 t3Mhnp3Gq3EncUgc2pu5pPgw6pD1GjPpT0xuds7EfxmJBNDdzuI4wE0uR0GrISP4Cng==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793988486;
	bh=r7jH24QUA7zEaj3nsRhzhFexl2hENVRPWXJnrAdran8=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RKlctmlz6DRT8d2uin9HskphYKj85t7kq+3Mas/NFYUb/9Zu+liUjN8grYGCQsn7+
	 xwtqY6/GIewGGHtEJ3wDfplN8cms31mrzziWXvVNwdSynTuGLnsaiXFYnOrjvE+b/E
	 3Ugl21q5JvUgo654jcIT7IWVAzMweVpAuE9wGIlsUcwB2JwOvxwOcHeWYC1e8ljEna
	 TDlt+aSc5e3u3Z6iGbqOz85NMDheTKhaw3MGzUBu7L9uoQfe47Lh55NA436iB3iK/O
	 PO7nYELxd/pnawLSVKIppA7GAUAKZwrwoDlm0Hfk5D7jXGOw/KY9RA5M7Kw2v+jI2/
	 ZMC0xDLJwRwhg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A01AF80BE9;
	Fri,  6 Nov 2026 18:08:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0778334D
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 18:08:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id ED0A8408EE
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 18:08:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7du3A0kPy443 for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 18:08:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6ADE04091C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip="2a01:111:f403:c20a::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::7;
 helo=pa4pr04cu001.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=Uyi+8uR0; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=Uyi+8uR0
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6ADE04091C
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 18:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r7jH24QUA7zEaj3nsRhzhFexl2hENVRPWXJnrAdran8=;
 b=Uyi+8uR0W4DIYDj2ATz23Tyq9MSL37SwZQpaGH1gvBfi/KjC7kW+FgGcTjkOvvx148ffEiLlC28YA2scYIJ+VkAzJJpU5M3uYxxK0NnrMXrB3PNFXWDJWtMyebWx2OuXjFQLEdtQijXpLcEGpiDC7ktfzCC3HWRd7jD4UXedYNQ=
Received: from PAYP264CA0036.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:11f::23)
 by GV1PR08MB8452.eurprd08.prod.outlook.com (2603:10a6:150:84::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Fri, 6 Nov 2026
 18:07:56 +0000
Received: from MAD0EPF000008C5.eurprd05.prod.outlook.com
 (2603:10a6:102:11f:cafe::87) by PAYP264CA0036.outlook.office365.com
 (2603:10a6:102:11f::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Fri, 6
 Nov 2026 18:07:54 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MAD0EPF000008C5.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Fri, 6 Nov 2026 18:07:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r7jH24QUA7zEaj3nsRhzhFexl2hENVRPWXJnrAdran8=;
 b=Uyi+8uR0W4DIYDj2ATz23Tyq9MSL37SwZQpaGH1gvBfi/KjC7kW+FgGcTjkOvvx148ffEiLlC28YA2scYIJ+VkAzJJpU5M3uYxxK0NnrMXrB3PNFXWDJWtMyebWx2OuXjFQLEdtQijXpLcEGpiDC7ktfzCC3HWRd7jD4UXedYNQ=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by MA9PR08MB241936.eurprd08.prod.outlook.com
 (2603:10a6:250:104::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 18:07:21 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%6]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 18:07:21 +0000
Message-ID: <ad6489de-4b8b-44f2-999b-548b8f34af25@arm.com>
Date: Fri, 6 Nov 2026 19:07:20 +0100
User-Agent: Mozilla Thunderbird
From: Jerome Forissier <jerome.forissier@arm.com>
Subject: Re: [PATCH v2 00/16] net: lwip: restore TFTP client and command parity
To: James Hilliard <james.hilliard1@gmail.com>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Johan Jonker <jbx6244@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 David Lechner <dlechner@baylibre.com>, Lukasz Majewski <lukma@nabladev.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Peter Robinson <pbrobinson@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Weijie Gao <weijie.gao@mediatek.com>, Pranav Sanwal <pranav.sanwal@amd.com>,
 Alexey Charkov <alchark@flipper.net>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 Drew Kluemke <ankluemk@microsoft.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, nd@arm.com
References: <20261024-submit-lwip-tftp-combined-v1-v2-0-0f663f735ee8@gmail.com>
Content-Language: en-US
In-Reply-To: <20261024-submit-lwip-tftp-combined-v1-v2-0-0f663f735ee8@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0057.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:310::14) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|MA9PR08MB241936:EE_|MAD0EPF000008C5:EE_|GV1PR08MB8452:EE_
X-MS-Office365-Filtering-Correlation-Id: bff4ee1d-5c37-4043-8cff-08df3c30e13a
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|1800799024|7416014|23010399003|366016|11063799006|56012099006|261021121427099003|261021123027099003|261022105027099003|261022075727099003|261009223027099003|261028144727099003|261102123227099003|261026121527099003|261026140227099003|10067099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info-Original: zfJ7bbok1pOxvQy2D4SHx2fvcQrkBksUKdX8B4jf5pEvTYslgmkH/Mtid3FhN0/rXluCBz7Vxxe4dYFUk5zhP6GOuYruJqDdykBB5B+CSuFzBgHjnQWVYjigFd84OrNPiSq8HQYpMKHWP6mCyjcD67CaQZMK7Fa7qEtUtJkwhzuQ7pbGWLP/YbnKEWa0LSal6OYusI9RnbbRJZ1mcsXOcR6O1O7aM53DoRFZWwDbQXFBZfW3cc6aCNnjRZBsWJnrDU76cyMhCnhH5fBoEHr4CSafh2dPjk+ZmCf8pNMU13O5G0nJix7Kd3pfIhd1xpvXTWcqloHkqgx5eCYSVV5Jk+H0iS+xDb5Hph9bmNgG1FY/1TFpRs69lVNEF2SNPN7AowZn2rH9tKzeZ5ri28i/kfwWOQZklQl63tXF+Og5xKHTCmttlw6OIPbGzZE6FxHUDV2ikIqoL6kOGTpKh3YGXkCzFD0cXEPbyvdQ8MAC1elqaimvPHqUmhwxbxP1RU7YWxg+uB/wl9GxzajjfA4STtiFvjQ2kn3s2yMY9GJ4m/znrynlRfGTLKfRm7Vmrj7GSs9TnWLUjTKgT1pxDOv7DUUP0TskCqr7zuHIiRk2ee5mHTv8wxQk7r3eg0my0Km9
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(23010399003)(366016)(11063799006)(56012099006)(261021121427099003)(261021123027099003)(261022105027099003)(261022075727099003)(261009223027099003)(261028144727099003)(261102123227099003)(261026121527099003)(261026140227099003)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: oeaFOeEcNl/9adrJ8d/+sWxTu4Ws68R3OliAdJBnqOdbS7dSDlToZcvg2N5XnNV+ZOgNnCupda6vIi85wpiyhRtyh0xHWANtK7BamWiDI01NxBaVq2NQWMx+ot7sANPJDCXb7k/Ry0S1q02k3UUhPpT1fT1L7rEOSX51pg71YOlEmyTqs1nCII+NnyWmirKH2rH0FL98krZktcfUE+LQxqBLSX20qgOE9dCdxcGJRjX8pBDelXFsdYlQEey1fmu8CUu6dbSuNGURYs3LQl2xbguR7VL6cP7tCT3Qnzv5/v+As8KAYvYMxn28o+30Of5js9nKUUBARYyFDbKfkfzBwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA9PR08MB241936
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: MAD0EPF000008C5.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: fa3030ce-376f-4dea-20ce-08df3c30cdb9
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|14060799003|23010399003|35042699022|1800799024|7416014|376014|82310400026|36860700016|11063799006|261021121427099003|261009223027099003|56012099006|261022075727099003|261021123027099003|261026140227099003|261028144727099003|261022105027099003|261102123227099003|261026121527099003|18002099003|22082099003|6133799003|13003099007|3023799007|10067099003;
X-Microsoft-Antispam-Message-Info: E9w2CZveSdn4qMcyGmaRLT3pxp1WnOgbKKrmc0vHJcLratrzv5wIQfjOxqwSoYjIY3pf/QERMhkchlq4Q7PLD/I1+VGw5nDq2B27F5IEDqoX1/7utzeu2Q6JXNnlK5wn9aodpXRSsfxwZlKx5KRs2D7B5GqBHZnn9Q/EgGjoe9GlNcHUkA0o2rH7zZHNsGAwCX/1tL3u1dB9iuXR4EsN7sgUrkMxJEq9RY8JHePh6lvbKkUBCoFmiGKaF7MHy0FEzACNRPrJf5IV8cBnPDg4Or82rPAk+EBO/FG3WzCBNIzjuz1M+FGhq8aTVohl+Nyql5sakeD/9OfXzmi6riYw48W6WXQr0X7FVuTvl0kI0qdsS9cHA1Z3qPtgiOnSoMS4eGx8q/DHPvui6GB+289goS7d71JpasvHYbGGoLxt4wpO8RDoHMHBq7gFX01JI0rKOjVc/ipuAmESPUvMV7Mk3yo0Py9v/H189x7PBLmMnVqYOMP+ksM8pXy4tlhcTXJB9MIs4d4kf+u2lEb17TNuBeX6fTKcwlWyFdXPU2hBEBfHKgVvGigUJB2TfmH7tdcfGpGPzcp0DDUNqJR05YAJyOxllBu81sVWLTJjHyy0Lp22az8HXLeSEkp8zvv5Wjz0JKK0I2Q5VveSYbF1AANkzg==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(14060799003)(23010399003)(35042699022)(1800799024)(7416014)(376014)(82310400026)(36860700016)(11063799006)(261021121427099003)(261009223027099003)(56012099006)(261022075727099003)(261021123027099003)(261026140227099003)(261028144727099003)(261022105027099003)(261102123227099003)(261026121527099003)(18002099003)(22082099003)(6133799003)(13003099007)(3023799007)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NFuTsKLD2wCfcpXXKmyd9hPjSsnCyQSo23mUHsCt5agdj7ypR72WzYXAu/HYhgm/WzQ7a8c4RnNfBiKA6WpoZS2zsU5E9tqzKMPikQu91p0yrW3B1f+mwmwjqto3c2VEpFZSCEFxNI3KZFpu09OFJd0cEmhLmCKzF6HMFUaWtfVzRMDXJEabLjZQ7db55Ndt6homhUUgUQg3923iX5U47enR8uFk+iAKfb/qOMgRLdW7f9WN8uUReTzcoY28Q9tdOzljDBJSslTGNQir1A2KhLB4QZYAeRaPCDiY5haogUFFiqlRidwwsyB53/DRpoaEUZsQx/jj0T3P0jIdc5VMnleAjaOvSmbiM13mHrPxqCLStugIW+Aeygtgwplc0E6iEfs6gOQp+vbam81inNCAJEXimcEWXGF7joVJsEEXhtf2AmNxjX6xZt5HTFtuCN4U
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 18:07:54.2849 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bff4ee1d-5c37-4043-8cff-08df3c30e13a
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: MAD0EPF000008C5.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8452
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-22.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> Restore the legacy stack's TFTP behavior on top of the merged lwIP
> BOOTP/DHCP/PXE work in U-Boot mainline.
>
> Fix write requests, retransmissions and option validation; expose client
> transport settings and tftpput; and add RFC 7440 receive windows. Preserve
> download-only internal callers while supporting command autostart after
> successful nonempty downloads and transport cleanup. Make automatic
> updates, DFU-over-TFTP and bootvx downloads work with either stack.
>
> Keep runtime restart, interface addressing, TFTP retry policy, DHCP/BOOTP
> autoload ownership and ICMP recovery in separate patches. Preserve the
> original transfer arguments across retries, refresh DHCP boot configuration
> when reacquiring a lease, and keep other shared-runtime clients intact.
> Receive-server retries use the legacy compiled defaults; uploads and the
> receive server remain stop-and-wait transfers.
>
> Assisted-by: Codex:gpt-6-astra
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
> Changes in v2:
> - Rebase onto U-Boot mainline after the BOOTP/DHCP/PXE series was merged.
> - Preserve the legacy TFTP OACK bounds check when restoring the normal
>   transfer timeout after the initial server probe.
> - Adapt the retry tests to the upstream sandbox packet-release hook and
>   deterministic DHCP receive-batch accounting.
> - Link to v1: https://patch.msgid.link/20261010-submit-lwip-tftp-combined-v1-v1-0-cf8002c6f401@gmail.com
>
> ---
> James Hilliard (16):
>       net: lwip: tftp: fix write-request transfers
>       net: lwip: tftp: fix transfer retransmissions
>       net: lwip: tftp: honor transport variables
>       net: lwip: tftp: add tftpput support
>       net: tftp: make automatic updates stack-independent
>       dfu: enable TFTP transport with lwIP
>       net: lwip: preserve the net_loop download return contract
>       net: lwip: tftp: support RFC 7440 receive windows
>       net: keep internal TFTP and DHCP downloads from automatically booting
>       net: lwip: honor autostart after TFTP download commands
>       cmd: bootvx: use stack-independent TFTP downloads
>       net: lwip: preserve interface state across network retries
>       net: lwip: use the selected interface for TFTP addressing
>       net: lwip: retry TFTP transfers using the network failure policy
>       net: lwip: keep DHCP and BOOTP autoload retries with their caller
>       net: lwip: retry TFTP after matching ICMP port-unreachable errors
>
>  arch/sandbox/include/asm/eth.h                    |    6 +
>  boot/bootmeth_efi.c                               |    3 +-
>  boot/bootmeth_pxe.c                               |    3 +-
>  cmd/Kconfig                                       |   40 +-
>  cmd/elf.c                                         |   29 +-
>  cmd/lwip/Makefile                                 |    1 +
>  cmd/lwip/tftp.c                                   |    2 +-
>  cmd/lwip/tftpput.c                                |    8 +
>  cmd/pxe.c                                         |    2 +-
>  common/Kconfig                                    |    6 +-
>  common/update.c                                   |   55 +-
>  doc/usage/cmd/tftpsrv.rst                         |   13 +-
>  drivers/dfu/Kconfig                               |    5 +-
>  drivers/net/sandbox.c                             |    6 +
>  include/net-common.h                              |   41 +-
>  include/net-lwip.h                                |    2 +
>  include/net/tftp.h                                |    3 -
>  lib/lwip/lwip/src/apps/tftp/tftp.c                |  716 +++++++++---
>  lib/lwip/lwip/src/core/ipv4/icmp.c                |   16 +-
>  lib/lwip/lwip/src/include/lwip/apps/tftp_client.h |    4 +
>  lib/lwip/lwip/src/include/lwip/apps/tftp_common.h |   20 +-
>  lib/lwip/lwip/src/include/lwip/apps/tftp_opts.h   |    7 -
>  lib/lwip/u-boot/arch/cc.h                         |    2 +-
>  net/Kconfig                                       |   19 +-
>  net/lwip/Makefile                                 |    2 +-
>  net/lwip/dhcp.c                                   |   52 +-
>  net/lwip/icmp_unreach.c                           |   44 +-
>  net/lwip/net-lwip.c                               |  104 +-
>  net/lwip/tftp.c                                   |  658 ++++++++---
>  net/net-common.c                                  |   66 +-
>  net/tftp.c                                        |   55 +-
>  test/dm/Makefile                                  |    7 +
>  test/dm/lwip.c                                    |  115 ++
>  test/dm/lwip_bootp.c                              |   24 +
>  test/dm/lwip_dhcp.c                               |   98 +-
>  test/dm/lwip_dhcp_policy.c                        |   19 +
>  test/dm/lwip_net_loop.c                           |  144 +++
>  test/dm/lwip_tftp.c                               | 1021 ++++++++++++++++
>  test/dm/tftp.c                                    | 1282 +++++++++++++++++++++
>  39 files changed, 4175 insertions(+), 525 deletions(-)
> ---
> base-commit: 8649a54d301a4d0ac526324c7a7ad2574939ff27
> change-id: 20261009-submit-lwip-tftp-combined-v1-df537139bb01
>
> Best regards,
> --  
> James Hilliard <james.hilliard1@gmail.com>

Applied to u-boot-net branch for-main [1] with local modifications, thanks!

[1] https://git.u-boot-project.org/u-boot/custodians/u-boot-net/-/commits/for-main

[1/16] net: lwip: tftp: fix write-request transfers
      commit: 7d10111a397ba69e6e61afd242513a427d2b479e

[2/16] net: lwip: tftp: fix transfer retransmissions
      commit: d243101fa28c0b21fe2f51931a2f891ffb6be5a5

[3/16] net: lwip: tftp: honor transport variables
      commit: 655e8af0ccb56d6b137ba54ebfbe9a0a9f4ffa51

[4/16] net: lwip: tftp: add tftpput support
      commit: ce41f7fb2002e2852ebe43915ed7823287a03eb8

[5/16] net: tftp: make automatic updates stack-independent
      commit: de38a1de1815a35a3bb75fe014cefd910ef63b69

[6/16] dfu: enable TFTP transport with lwIP
      commit: 6ffb52e10071bd57d0bf8ef3461129cdbb8697c3

[7/16] net: lwip: preserve the net_loop download return contract
      commit: 16139de333b6e9e64ae68383e03c9e8cb1ad7f55
      Note: Applied with local modifications.

[8/16] net: lwip: tftp: support RFC 7440 receive windows
      commit: 0203d99c26465e06dc92065c2c8e6162f8bdf710

[9/16] net: keep internal TFTP and DHCP downloads from automatically booting
      commit: 0c8415276a554477a5fc1750bee680fbf1a64b84

[10/16] net: lwip: honor autostart after TFTP download commands
      commit: e38cfd97ee5a3b8cf75f825979039bd6ca3a5dbe
      Note: Applied with local modifications.

[11/16] cmd: bootvx: use stack-independent TFTP downloads
      commit: 51d854861dbe9164bf36859070872733e7b45357

[12/16] net: lwip: preserve interface state across network retries
      commit: 0eb37f5894edc3f2ace1980aaa31bbf237c6c34f
      Note: Applied with local modifications.

[13/16] net: lwip: use the selected interface for TFTP addressing
      commit: 62bec5f8c0a4e4fc2ec24a5a6ee596a3c3618e6e

[14/16] net: lwip: retry TFTP transfers using the network failure policy
      commit: 5ea49ff544cd5f6e9a5b7de94fcdfa931c5c5642

[15/16] net: lwip: keep DHCP and BOOTP autoload retries with their caller
      commit: ae79242adada1161e1eef127b71561174fac8530

[16/16] net: lwip: retry TFTP after matching ICMP port-unreachable errors
      commit: fc70afb403e0896b86fbc5afb154af67a82443cb

Best regards,
-- 
Jerome Forissier <jerome.forissier@arm.com>
