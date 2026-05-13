Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D240CD4851
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 07:58:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6AE32836AC;
	Wed, 13 May 2026 09:58:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="FxaQkQVO";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="FxaQkQVO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 158D3838BB; Wed, 13 May 2026 09:58:14 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4F568056B
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 09:58:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jerome.Forissier@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=D8M96hmYirnfNgXNM2d1f58ij131ZpkOmSmMu9jYgYKM9yE6PXSSv1znqSEfpUeutBQCoBYSGEOTsKU0YIGgZrYQ/Wy252t4x7mog5Moj5cUmJL90VpT4y3IolNwrcVmegc3MwVO/qjkxntvVPN1m2gtmr68eArjrLXe3eQktCaTfnyFSFqLCphUzUg+ynTJozutcTj/zU41iixfKDnC0OLDTvyqfw9xZFMI4zMv06xLdxNLpO6tlZkT2E1to/eRcfL1uJHvYgpbAa/M14wrh2z+rIXTo/LZ9f/DrfpLVVKObwU1Vl0cLKsZLm6BC8VSdptiqbbo76yDbhbP8puxGA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=87EegO5snZgVg026+EOePZoW7IwFiCAec3cu6He5qCk=;
 b=GNe3634D+Zvs8GPAy8ZXYrWPajaoPZz4iiEklHW0O/ybLecjtIxX4YkHt6qq+eHRR0Y6jIIPQq3CPA4BNFpCYr/uKJmQDIt8RhDIUOWEuzOu1L4yC7s4pxJIhIdbxBoHqFzQ55qIRS3IVBU0n97f/HlnIlZfv7UtNc+SBVV79i/LzZnCZGoNOrXJ/qlkcQu2tie0NOnkteJyaqPSAkuFTCcr2sfDY1vCahcCW0FjqmBSPSBnmyKxIFuRCAXGhShq7l++b8msruoF70zPsuibrHLaW7Fb4//ZOht8ixFQEOQQw1kYoNidjusyMCCM7m0x5Zx+g/yC6FIowNjFtX581Q==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=baylibre.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=87EegO5snZgVg026+EOePZoW7IwFiCAec3cu6He5qCk=;
 b=FxaQkQVOZ2Rm+QiGRfhRkxrWb0E0Sg/mEpXjbR7xzAZdyUi1MgYTlHx7aWDdsknFMWue9tR7oAlwUCoMGD4oiX1JsFwvD/xdBAVgJe2zkaGTj9ET2mTfpQqLagGKoLKJAIUyyZWWuth1UBA1PbTGhXp5h/EGYh+EQz08P5tK0qI=
Received: from CWLP123CA0080.GBRP123.PROD.OUTLOOK.COM (2603:10a6:401:5b::20)
 by AM9PR08MB6226.eurprd08.prod.outlook.com (2603:10a6:20b:2d8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 07:58:07 +0000
Received: from AM3PEPF00009BA0.eurprd04.prod.outlook.com
 (2603:10a6:401:5b:cafe::a2) by CWLP123CA0080.outlook.office365.com
 (2603:10a6:401:5b::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.18 via Frontend Transport; Wed, 13
 May 2026 07:58:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM3PEPF00009BA0.mail.protection.outlook.com (10.167.16.25) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.13
 via Frontend Transport; Wed, 13 May 2026 07:58:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ggbWij+kv4W5ZC28S2ujdC5bqFqMApB4AHUwL/HYn8PV7DoDzyKfWxVJNQU40Ek6Ts0iWbp+3ZjOVLLkMYEfli8Zhm5byQsACTn4+JCYdZnnbXLjSvgVvh9pUS65ahQwgR+rKCVcFXTXmoXII4NVRsaYEPr9LTe7tSdoqqwaxRpgfC5qynBRmLZBvnZFMCExQZ7CffKkU4TqT8lqux3v0gMZxtxGUPqIkan2qdddeV324us/yy99opbk+Ygb7QYWFM/Reh6M3PsjDVu0I/hiCrBUbK2eaA600jvZiGiW7mFuiw7SfFQMYi6lxXd0qwOH+qsZQkk12b1A+ME92NX/xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=87EegO5snZgVg026+EOePZoW7IwFiCAec3cu6He5qCk=;
 b=wByoKbFFpRw/sWrPoCM5oWzzXQ4qFKHZB/9lr2pA8XyyiRxKTqaJR9/TfykvSGwU6UnOPzK0yWMn6k9fWFR7yHmNE19Jx8Mw1ybUSNoir46yM5eA8UEv1oMaPbDyKknzsHNWhUO3H8CZMmIqVUBkBDn8AqQpyxrNPxlTqzsKU+o+A76RSwQfhBP2lf+C9GXTuG34KpDLBwkLaK5uOexPYBv85YkTkeqwZMlA67c6lCz0f40XX/3S9s8mewOv3o+SoFHv2+u8UNIN1kQW/M/1V0XJcS5Uy/mxABxvvYzwoWG1etn+AujNTz58c1QqBEhKlRxj4f/IKZM2nZyG2lApHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=87EegO5snZgVg026+EOePZoW7IwFiCAec3cu6He5qCk=;
 b=FxaQkQVOZ2Rm+QiGRfhRkxrWb0E0Sg/mEpXjbR7xzAZdyUi1MgYTlHx7aWDdsknFMWue9tR7oAlwUCoMGD4oiX1JsFwvD/xdBAVgJe2zkaGTj9ET2mTfpQqLagGKoLKJAIUyyZWWuth1UBA1PbTGhXp5h/EGYh+EQz08P5tK0qI=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by PR3PR08MB5625.eurprd08.prod.outlook.com
 (2603:10a6:102:89::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Wed, 13 May
 2026 07:57:03 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%3]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 07:57:02 +0000
Message-ID: <3260fdac-8c9f-4eed-a23d-b70865e54381@arm.com>
Date: Wed, 13 May 2026 09:57:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] net: lwip: introduce net_lwip_eth_stop() function
To: David Lechner <dlechner@baylibre.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, nd@arm.com
References: <20260512-net-lwip-add-stop-function-v2-0-85146da317dd@baylibre.com>
 <20260512-net-lwip-add-stop-function-v2-3-85146da317dd@baylibre.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20260512-net-lwip-add-stop-function-v2-3-85146da317dd@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0411.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:39b::6) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|PR3PR08MB5625:EE_|AM3PEPF00009BA0:EE_|AM9PR08MB6226:EE_
X-MS-Office365-Filtering-Correlation-Id: 173e5bbe-9aad-4697-d4f2-08deb0c55dfa
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|376014|1800799024|22082099003|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info-Original: QfhY8h9rhO8m5jhjIi7ZXH/9j20YrKXNEK1XatIrb5bQ7j74lVBSWQ0+us/pBtiQ2Uyhu19VKsq6ZXuT3EsqJlrFnMiD7vtQgb4M0HWSOMyg/3Qjyb6oubhqxc+iG7FZBXcmda4RbEkcsuHJ9Eo96RvuSn3BU2C4QpSo3cV/wy01/e1UJq7hTq/ZHf1yvVvRL6T7S7S2A/QVk+fiQGkJotXiu2kUpXFz+bm5daz+tM2dvdIIyYziSo+J8Doy+wbtrYOvxsbFBB6l034fDPIyFN0+MCAruEhV8YMgTZLPauYkgNO7Jdwv3m8+avha4qL47zaMu+LFQRN8ENwud5I4L3m9Dvx+IKZWL0q83UA3fnp+NZ9Es6Kvo0Fp2uBcHiu2sjAiiIr/OiZBZbf0Ja7ioZe2idx4/e1dDr+i3ocetlz2FsI/ETHZYWvhfACLxE+u/6PKbL1h7qN8X4Qjjy90McyBP1DzCCyOXS/kdI9MmrD4Urs4ANhqTM4wa0bav66fhzs6h3unSTmZQog/MXLqoW9D1lWj+u3i6gytV1w/aHGECemvt2B5mx7F9xRQAVRXfpT5hs2VShc1ahMTDFxhzYR+Bd/k/If3Z0kduCh/bkpbgNBonBIH8A1ikl8zRueDAoV+xuUKueoG9x/Eo+6vdJBPiuPpPgAbwFrp/ZEw4XbEkbIIYa0i8CsV3VS94GuG
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(56012099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: sI030coy8FKNTYrBJ+ZrkVoRKrVkd+aae8N+MZs3VnLjgXSdLrjhGsBvkmU2YsvMsODTkwW83uqtU80WsMcHoKGpcunApsFt276OAn6nJD3eA7XBVNP+WOVC6yenph0VsknQ7HcHZhj2JO1DbeTeRI82QPack0c3+/kp60KL7XjaEsydWFRq/uT/DMKR91kDylT++oBmej/vYb0VhUxlFYuI1vAXg/1eQi8Re9maoSmTjtknkcf29ivBlnCESgTNuXHqGXY9WY/ItVu9Xnmt3HdhzTV7S4ziPXnaYKAqhiEbgvyml5SyRuZDlF6514UcH8HOfdfohIjr6G9fMjLmyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR08MB5625
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM3PEPF00009BA0.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 59c84c63-efd1-490a-8f87-08deb0c537e9
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|35042699022|376014|14060799003|36860700016|56012099003|22082099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info: pkavcs7nyQFOU7l9LPHRLG5aqlABVUEMhxIc/sV1AxxVw4JQ3aPyKIyq6ME2VCJWKGkH/yGM4fq4IozvRpFAqqFMeJYbhS3M0UY0jFaeCBjHpTeivLwh6AYTanledZTZUkZY5aZqozwBmE3LoEYudDucVQgy4rUS8Uk427JVASarUj42VYYqLN4c/EBqTV9jML3Pvd9ofUXpxZiF4rjZM4rfXgj0LbV6V6g1aoEBgrI6CsyJIi0pfhDB1eUw/QKhdUEwP8Yay+g1V0eimChI1edLPMalev1YZ53IXySW4OTNEOXp30dk1GpiJav22TXS06B5Ibsi59ZQDdHoP/Tb+vZUp86F5kW1CFrZrbowL+39/2eIQdgUFGs1jIqy+f876mhqsPLt9xobI0JZz1hyPhd3OO9VFcIpQJDIoaszJSoUzfdHAKizydP9tn93CEifO+D5CqmHgnZYaxKxinzap2JaDZ6IbaTU/z3isPFBY6qm8S1mklfaFwL1DMAHrPjXS7qR6JUS1vWvMjmuiHYkdXOMRl5ziAQ/DHjJtER1VXw26fZeyGtqw82YKKtkQCEC6/xh5novdwgcyQI82Tr6BNcZxcFCzuw5Qfu8qjsB1qJXcSzGXVXSxO08WaY6epMwqorrx1ykSvaft1wCbXwCT7TmVce1vw0SFepwOB8dkeYNlt7DmybOuFNfwDh9W0u0Y3vIPNFioHOO2Egkb6WZmHXagjTymoTPbdJOf9J6JnA=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(35042699022)(376014)(14060799003)(36860700016)(56012099003)(22082099003)(18002099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ks0CW4oNNLh3lKGYNPylUYb6qMKETyIg3AssGlIEJkHSJ+ewkTUxidIHtCV2Ejn0ivDnFP5ei48uAnnsjYufyISHWccGKWI+XsL9AscU/76G/hnui+3Rc55Dv2H7GrLCx4b0ypyJ2L9YAIMLVvd7enpnHxYcvM7zaFt6gwy8mtKwCvURDMoKoea4A4T28OP1F+cqfHULHlUkuTUL+3YYtJyFwAUlWNwW84SXi4Of3F2gU2a3KOEbqUqIh/3PBd7tMEdlPxEyyAPwvdNiIkpTFGEjMyXUgyCYmvJ3NHThUNGfnkhTmyGyL71XwxpCjUbB6orkx1SFrPmMEobjpa7ZBTBVC07Nci8qrfZKqsCylFbwc3qVLFSK1yJmv5bu4WaPCIn9tHcF4VPDV8VvlrYZtC3nz7vRT02fkr2UKG9TiDeqLwin4q9CEh4glihj9P+8
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 07:58:06.3898 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 173e5bbe-9aad-4697-d4f2-08deb0c55dfa
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF00009BA0.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6226
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean



On 12/05/2026 23:48, David Lechner wrote:
> Add a introduce net_lwip_eth_stop() function and use that to stop the
> network interface after each command that uses the network.
> 
> This makes the behavior the same as the legacy net code and avoids
> potential issues with the network interface being left in an active
> state after a command finishes.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  cmd/lwip/ping.c     | 10 ++++++++--
>  cmd/lwip/sntp.c     | 10 ++++++++--
>  include/net-lwip.h  |  1 +
>  net/lwip/dhcp.c     | 15 +++++++++++----
>  net/lwip/dns.c      |  7 ++++++-
>  net/lwip/net-lwip.c |  5 +++++
>  net/lwip/nfs.c      |  4 ++++
>  net/lwip/tftp.c     |  4 ++++
>  net/lwip/wget.c     |  5 ++++-
>  9 files changed, 51 insertions(+), 10 deletions(-)
> 
> diff --git a/cmd/lwip/ping.c b/cmd/lwip/ping.c
> index fc4cf7bde5f..836d1d8287f 100644
> --- a/cmd/lwip/ping.c
> +++ b/cmd/lwip/ping.c
> @@ -163,6 +163,7 @@ static int ping_loop(struct udevice *udev, const ip_addr_t *addr)
>  int do_ping(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>  {
>  	ip_addr_t addr;
> +	int ret = CMD_RET_FAILURE;
>  
>  	if (argc < 2)
>  		return CMD_RET_USAGE;
> @@ -176,8 +177,13 @@ restart:
>  		if (net_start_again() == 0)
>  			goto restart;
>  		else
> -			return CMD_RET_FAILURE;
> +			goto out;
>  	}
>  
> -	return CMD_RET_SUCCESS;
> +	ret = CMD_RET_SUCCESS;
> +
> +out:
> +	net_lwip_eth_stop();
> +
> +	return ret;
>  }
> diff --git a/cmd/lwip/sntp.c b/cmd/lwip/sntp.c
> index 608345c873b..5fa400b104a 100644
> --- a/cmd/lwip/sntp.c
> +++ b/cmd/lwip/sntp.c
> @@ -101,6 +101,7 @@ int do_sntp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>  	ip_addr_t *srvip;
>  	char *server;
>  	ip_addr_t ipaddr;
> +	int ret = CMD_RET_FAILURE;
>  
>  	switch (argc) {
>  	case 1:
> @@ -127,7 +128,12 @@ int do_sntp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>  		return CMD_RET_FAILURE;
>  
>  	if (sntp_loop(eth_get_dev(), srvip) < 0)
> -		return CMD_RET_FAILURE;
> +		goto out;
> +
> +	ret = CMD_RET_SUCCESS;
> +
> +out:
> +	net_lwip_eth_stop();
>  
> -	return CMD_RET_SUCCESS;
> +	return ret;
>  }
> diff --git a/include/net-lwip.h b/include/net-lwip.h
> index 20cb0992cce..5d0627eb271 100644
> --- a/include/net-lwip.h
> +++ b/include/net-lwip.h
> @@ -35,6 +35,7 @@ int eth_init_state_only(void); /* Set active state */
>  
>  int net_lwip_dns_init(void);
>  int net_lwip_eth_start(void);
> +void net_lwip_eth_stop(void);
>  struct netif *net_lwip_new_netif(struct udevice *udev);
>  struct netif *net_lwip_new_netif_noip(struct udevice *udev);
>  void net_lwip_remove_netif(struct netif *netif);
> diff --git a/net/lwip/dhcp.c b/net/lwip/dhcp.c
> index acdf601d7eb..18dc36ae7ca 100644
> --- a/net/lwip/dhcp.c
> +++ b/net/lwip/dhcp.c
> @@ -138,18 +138,25 @@ int do_dhcp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>  	dev = eth_get_dev();
>  	if (!dev) {
>  		log_err("No network device\n");
> -		return CMD_RET_FAILURE;
> +		ret = CMD_RET_FAILURE;
> +		goto out;
>  	}
>  
>  	ret = dhcp_loop(dev);
>  	if (ret)
> -		return ret;
> +		goto out;
>  
>  	if (argc > 1) {
>  		struct cmd_tbl cmdtp = {};
>  
> -		return do_tftpb(&cmdtp, 0, argc, argv);
> +		ret = do_tftpb(&cmdtp, 0, argc, argv);
> +		goto out;

do_tftpb() already takes care of net_lwip_eth_stop() so this should
probably be:

+		return do_tftpb(&cmdtp, 0, argc, argv);

But this also raises the qestion of the double call to
net_lwip_eth_start():

do_dhcp()
	net_lwip_eth_start()
 	do_tftpb()
		net_lwip_eth_start()

How about adding a static counter to better deal with the nested case?

static int net_lwip_eth_started;

int net_lwip_eth_start(void)
{
	int ret;

	if (net_lwip_eth_started++ > 0)
		return 0;

	ret = eth_init();
	if (ret) {
		net_lwip_eth_started--;
		return ret;
	}

	return 0;
}

void net_lwip_eth_stop(void)
{
	if (!net_lwip_eth_started)
		return;

	if (--net_lwip_eth_started)
		return;

	eth_halt();
}

Thanks,
-- 
Jerome

>  	}
>  
> -	return CMD_RET_SUCCESS;
> +	ret = CMD_RET_SUCCESS;
> +
> +out:
> +	net_lwip_eth_stop();
> +
> +	return ret;
>  }
> diff --git a/net/lwip/dns.c b/net/lwip/dns.c
> index 8b7b3b7f970..b620b0611d6 100644
> --- a/net/lwip/dns.c
> +++ b/net/lwip/dns.c
> @@ -91,6 +91,7 @@ int do_dns(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>  {
>  	char *name;
>  	char *var = NULL;
> +	int ret;
>  
>  	if (argc == 1 || argc > 3)
>  		return CMD_RET_USAGE;
> @@ -103,5 +104,9 @@ int do_dns(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>  	if (net_lwip_eth_start() < 0)
>  		return CMD_RET_FAILURE;
>  
> -	return dns_loop(eth_get_dev(), name, var);
> +	ret = dns_loop(eth_get_dev(), name, var);
> +
> +	net_lwip_eth_stop();
> +
> +	return ret;
>  }
> diff --git a/net/lwip/net-lwip.c b/net/lwip/net-lwip.c
> index 0c83c004cab..be63531c2a2 100644
> --- a/net/lwip/net-lwip.c
> +++ b/net/lwip/net-lwip.c
> @@ -192,6 +192,11 @@ int net_lwip_eth_start(void)
>  	return 0;
>  }
>  
> +void net_lwip_eth_stop(void)
> +{
> +	eth_halt();
> +}
> +
>  static struct netif *new_netif(struct udevice *udev, bool with_ip)
>  {
>  	unsigned char enetaddr[ARP_HLEN];
> diff --git a/net/lwip/nfs.c b/net/lwip/nfs.c
> index 9e6b801e465..4cc36373fdd 100644
> --- a/net/lwip/nfs.c
> +++ b/net/lwip/nfs.c
> @@ -187,6 +187,7 @@ static int nfs_loop(struct udevice *udev, ulong addr, char *fname,
>  int do_nfs(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>  {
>  	int ret = CMD_RET_SUCCESS;
> +	bool started = false;
>  	char *arg = NULL;
>  	char *words[2] = { };
>  	char *fname = NULL;
> @@ -281,10 +282,13 @@ int do_nfs(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>  		ret = CMD_RET_FAILURE;
>  		goto out;
>  	}
> +	started = true;
>  
>  	if (nfs_loop(eth_get_dev(), laddr, fname, srvip) < 0)
>  		ret = CMD_RET_FAILURE;
>  out:
> +	if (started)
> +		net_lwip_eth_stop();
>  	if (arg != net_boot_file_name)
>  		free(arg);
>  	return ret;
> diff --git a/net/lwip/tftp.c b/net/lwip/tftp.c
> index 7f3b28b8507..571c38172f9 100644
> --- a/net/lwip/tftp.c
> +++ b/net/lwip/tftp.c
> @@ -261,6 +261,7 @@ static int tftp_loop(struct udevice *udev, ulong addr, char *fname,
>  int do_tftpb(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>  {
>  	int ret = CMD_RET_SUCCESS;
> +	bool started = false;
>  	char *arg = NULL;
>  	char *words[3] = { };
>  	char *fname = NULL;
> @@ -365,12 +366,15 @@ int do_tftpb(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>  		ret = CMD_RET_FAILURE;
>  		goto out;
>  	}
> +	started = true;
>  
>  	if (tftp_loop(eth_get_dev(), laddr, fname, srvip, port) < 0)
>  		ret = CMD_RET_FAILURE;
>  	else
>  		image_load_addr = laddr;
>  out:
> +	if (started)
> +		net_lwip_eth_stop();
>  	if (arg != net_boot_file_name)
>  		free(arg);
>  	return ret;
> diff --git a/net/lwip/wget.c b/net/lwip/wget.c
> index 3a0b0dca145..247ece18e2b 100644
> --- a/net/lwip/wget.c
> +++ b/net/lwip/wget.c
> @@ -416,12 +416,15 @@ int wget_do_request(ulong dst_addr, char *uri)
>  	udev = eth_get_dev();
>  
>  	netif = net_lwip_new_netif(udev);
> -	if (!netif)
> +	if (!netif) {
> +		net_lwip_eth_stop();
>  		return -ENODEV;
> +	}
>  
>  	ret = wget_handle_request(&ctx, is_https, udev, netif);
>  
>  	net_lwip_remove_netif(netif);
> +	net_lwip_eth_stop();
>  
>  	return ret;
>  }
> 

