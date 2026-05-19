Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7AD8CD4F5B
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 09:35:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C08E84693;
	Tue, 19 May 2026 11:35:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="jyrsh1TI";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="jyrsh1TI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5001D846A5; Tue, 19 May 2026 11:35:25 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 160348056B
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 11:35:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jerome.Forissier@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=JTByugputGSdWhfx/X+R/R9gy4HMTwJR9JRiFIgdvvwjsSrG9qsMsNF+gnRDCZoIrQ03r4fGYLJ6tTkGks7+cWdHLFy7HigzN08K5Fn0VxnmLmnNsJ/bAm2R5reDlsU0cMW4avp/uhufzOSOqL1XITZ9/e8ekOJSnKqRc5agqx/QSn27keuDmO/buaO12dvq82GMqjv5xh0VSEKbOYvgyaN5SZu3+xW1T4iAJnmwfIIYmbG6AbEUIERvp53Gj1WLaPx7qT16vjpc7uwiuhO2/r6RHboAi++MN+WHS9cwjtO4PL5nwYaLZ06joBnxY4eyzxz0xdgbGIN6ogywqIGGLg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D8Vhk07R8Nya7s34VG5ln1LR1rCdHiPzDKTPFgoGO40=;
 b=eTWVyYXPTUHiupBTWbmOzqQ21qsU4e7inm5T96j6XRW7vbU8LS/xeiBiSiNRwIQ4wKaIe0OiyfclPO7OVh87eEXLd6XhtRkaBMcBxq0gH/lol0NA2Ifvxc/jVyEAj0Dd0bgV4PPr7I7N++HAmbuHuVLf4hXvCIsktlSPAiUvQrZUjpjF1Gg0Y4IX1ESKxYwUTXOvLRStqZamywSBF5LGCIRctOQeGARwuBwcYMUJPNheZBCsAu77sRahuOQKDQvtzl69upD/a5xXY1BmmT+bblTM4yrDLsHz9zxfEPbrJ93P5j4/E03c5OL0RPQ2UlYvxn4nNHvg6VYwccq1nKpe7g==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=baylibre.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D8Vhk07R8Nya7s34VG5ln1LR1rCdHiPzDKTPFgoGO40=;
 b=jyrsh1TIzTMKdCAKMyK8rvGAbTdq2L4K2lu1EX2K8ANhfjX2LmoCiRvWjV+dSzRey7ksobJzF5LKoH5GFe6TUupBs1zb0QnuKh34PMYLue4WC67kPFPSjr6DSuzDv45oURKpy0ytj3kP3RqDBruJ5aRcmowwDMVG+ZCb3d4Q2lE=
Received: from DU7PR01CA0036.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50e::25) by AS2PR08MB9023.eurprd08.prod.outlook.com
 (2603:10a6:20b:5ff::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 09:35:14 +0000
Received: from DB5PEPF00014B8B.eurprd02.prod.outlook.com
 (2603:10a6:10:50e:cafe::b9) by DU7PR01CA0036.outlook.office365.com
 (2603:10a6:10:50e::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via Frontend Transport; Tue, 19
 May 2026 09:35:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB5PEPF00014B8B.mail.protection.outlook.com (10.167.8.199) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.11
 via Frontend Transport; Tue, 19 May 2026 09:35:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wEOBiujB554rkyIUP9iVQaoG0vLhtbPmdtkr3Yum8/fQxogWTgOfnwKjkOCyobe3YRQLUc+YIeuhKstz1RL/+QhT1fZ0+UtZB8HOZ6n5HgHhIT1vlSR9MvakGjrz3f0vzRknrklw6ae83TRQoGX2HOF0tpcq8/W9xgYD2iElaZ2qSlH2JMJJouopevXRnBbr88ciNVrumlz/5SL4TUErqGdAIiBCtz1qF2NVKrq7oEjzujQT0DlEP0bz7332HHvES05RRierhTZubnA6KnG4JUGFnScarQpP5e8+ucjt1IIFXqsXxXAcI9YqvQnmYkKfkny6ibeos/M1ru/kXNpR3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D8Vhk07R8Nya7s34VG5ln1LR1rCdHiPzDKTPFgoGO40=;
 b=UDSNZZxUYNWgpMSmee072SY+zPQrkp941KvhUGbSEluAiKjtjrgzL+LNVOU9RmPHW/m8ulZCgpVDtUY0u2LIc8YRvnsIydNlkbqnapq65+azBd+trGdarEmvDK73upUljmuhoS4SD0l3cZz3cnAtn199HUt7X9sraglfxxEXfnKcOlHfDdMhS3IaVsUi2qdgS/0dfn1GvDvTaNGSiX3o6CIqdH3u5p9UgwISR1kr2rDJwWoUcg3E6BfidhUWXecqmdGlSK/wVaXLN7LG6dojuVBvLJadW27pBk4oVZoPa6rhZW0geCqp6sMMsq1ODWu4omaUTtSCYdiD2wyXEbqLVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D8Vhk07R8Nya7s34VG5ln1LR1rCdHiPzDKTPFgoGO40=;
 b=jyrsh1TIzTMKdCAKMyK8rvGAbTdq2L4K2lu1EX2K8ANhfjX2LmoCiRvWjV+dSzRey7ksobJzF5LKoH5GFe6TUupBs1zb0QnuKh34PMYLue4WC67kPFPSjr6DSuzDv45oURKpy0ytj3kP3RqDBruJ5aRcmowwDMVG+ZCb3d4Q2lE=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by DU0PR08MB10360.eurprd08.prod.outlook.com
 (2603:10a6:10:417::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 09:34:09 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%3]) with mapi id 15.21.0025.020; Tue, 19 May 2026
 09:34:08 +0000
Message-ID: <297dfe2d-e01a-42e4-95f6-e91094dc6349@arm.com>
Date: Tue, 19 May 2026 11:34:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] phy: Kconfig: use bool instead of tristate
To: David Lechner <dlechner@baylibre.com>, Tom Rini <trini@konsulko.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Nobuhiro Iwamatsu
 <iwamatsu@nigauri.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io, nd@arm.com
References: <20260513-phy-kconfig-no-tristate-v1-1-c4cbee0c1831@baylibre.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20260513-phy-kconfig-no-tristate-v1-1-c4cbee0c1831@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0311.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:395::14) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|DU0PR08MB10360:EE_|DB5PEPF00014B8B:EE_|AS2PR08MB9023:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b8900ad-baae-47e8-f981-08deb589edd6
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|18002099003|22082099003|56012099003|11063799006|3023799003|921020;
X-Microsoft-Antispam-Message-Info-Original: C4BlQgGEuJ4gKqNlw5kSd5EysqRnFKzfbSRDO123DvO3upB+OY8GfbT/7qxVYag08sEqkaj4sZ0qnj/cMIy7pjQPIHJj1/icO2OoqeeKh6AWlTw0wATnvfoJZeLXJ4RQwJYEE04f2z866OJtAyJqCWKhjRGYr+dW9dWcHVTsWPZnL2E6pEcsGlIYe5hS4EmeCX+4Ca28YiXpw0u+YSqTSak99G7nfQOL/bKk1vkNqS03LPLcmJIlT45T16s2QbfIs7sD3oSZ/6G45N6EBqwdCbwVMOcdFZQKCthxNbg7l8A0NZJT00beHmPBLX45tkWdj4lBakVpoMyTmALsDGObwWR8GHTFbKQcxBHNkfLazzmxKnb5tid8JJpY/iA/3ZsuC0iU10R06X58XwapQ3Zpn08JxETxSi9qLXis3YUuXQZl6F8gwUBIq+ZLjDIP+osdtvee1LjGsC/qIusPkQfA3iW743VI3Qul7Pz650cdQAPW4Xl1RMxsjFFTwFDIeFl9sfHd0R5vI+NXC8Jmw+szrbJfkw1VhpYwQte9mhg4hRMCyF6/1sFxB7el/MUXeRAa/YPuAmF6Y8C99eDH03PiHzhlNXN+74oBGBKeyEvFdujX2lxR8IxEH7CqRVlJnWT/ztn3hmJ36EpDw1O5GWxYwp3fhtnXHD3zT4/N+ik8Zw3/6nczVfCjISDfmn0N7oXEtcjvWHLQsVo0ENfv8sZC7wdEw1Twfitw27smC2JmbaI=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(18002099003)(22082099003)(56012099003)(11063799006)(3023799003)(921020);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: SFI6/lo3v1BbppaUX7uwlYa/44aS0eIboU0UHp5ov3FH90lwy1Ti3SSOwEgkROjSIAdwUG5rgFM3nHAzx5lmHqu7ANlFl4BQhW3D7ruhpd+MXhH4nAGbUSkdNhKh0CS9CpLIngWnT8LnHQTwkVpNnl00mbrk8ED8B+EAAyyoWo++AnwW1O+ULWVqHKQkgQK8meB+3wu1Yb8h7UDpnFRfF30vOyrmIOGzwEmy/WQ6INpwivMQzT+aYzkdl2s634srZZ+YCXLki3xYJr8jrWZAyFZ+HCIfxDF4zGnRwTGkPWN1z9ydZseb+uOxB22HmpUq8xdPibVJol2DkfT7fDQSIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB10360
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5PEPF00014B8B.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 63efa458-f8e8-412d-4af1-08deb589c6e6
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|14060799003|1800799024|82310400026|36860700016|376014|35042699022|7416014|22082099003|18002099003|56012099003|11063799006|921020|3023799003;
X-Microsoft-Antispam-Message-Info: tzqYcFQG6XmtvLd7tri429IZhd/JCDYtrQVz5dnhKvm6OYE/ONie7Q6od+VjxGIxgY7+1d/U4Nsumq5o7WUNCMcRp1Ui5sGlO8mlxp12j/s4bSgP9K8if6nNuuMSyKuXSRxIH0ejdqOWCerEjnVPcy6LFFB/V9vEOwv7K4WnkXzcRRcLsF726xtzk7WaKVzyE7FhP10xTTiN9V9rm22sxqeD6v5DRhlMvleqQg9hOOkC7jYLrBIYZRa4sGpB08Fw01fQR63RsfxHG0KH3qD7Iij5xFnuCupY2Bvw5u+nVjNBthiMZmeVyVRA9EfE8xf312fSviOmmjkLvAgG3FZDNqBHGEi7/yi9Kmgew7ceGHBCbotXV0cAlNGbZ/RWW11GoKkaQO3JodKfPjzjhJVxfWd4mND1IiA3VirG8kZSdVhmc0+VVXCPjiWKipSdBkYvhGoob0+Yzgjk4xM/WW4LsFUdBfuhS8fDL8J5sjmvr0ujUwUEvAsH+YWcfbSrX36LqV+xQGVUPGa/vRcE27ys1kxaB+AjsEhXZ5NI++FKrSeVp09x3K5gLoVotIyTvHpaSB48bqV8YhT4/G0UgEKd+D5gfNliqwYbIz3zG+YgPr/YecBw6smNqpKvxGbqhnu+K9Zs1Nv+vtPGaImqTjX5lcLqaPOOPsKWs/q+XfwHZfASNtoxAI6xw2rK252b5oGnLuzGiRhLCStwZ8eF2nPtw1u7nMpvKvCB8ZSYsrqZQL+1FgEXlVk/F5bFl5qJ032NB3EDQOKz1QEvnpBeWPyGdw==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(14060799003)(1800799024)(82310400026)(36860700016)(376014)(35042699022)(7416014)(22082099003)(18002099003)(56012099003)(11063799006)(921020)(3023799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QDgMGgXjRorBpF2LbqnubORiKl7k154ioDQtDsxYknOalxqOlbJq93ZBWKxsXj8pYVoQAdSnOvzWbLNP9iq7WOdDjsr3coSeojy+grzT1KswgbpmLtShsqmLOvL9oV/pSf17j2QTqDTkCvuYGT/tnXsbNVzmLYmsFtpBU2LBPKH9JTsGL8XwEdN1R0sU0VZsE8zS1NuK/0vsO7BrbU0cKn8QjCT+AH3KoIRu1d1M4O9A82LGTvwwprhv8VU64ZWb1P5gNUdUG0XVA4cslhUPSuN7s5ssVXEAJZ+Fl0lLU5mnpRHZGKC7gHc6Lo4AU5Js4qLAmkFyBCn+mN0+LxK9+dzFpEpzawyRwhQhlKS9hMr1qimI82B0CV064lzrepA3bIaPOHo1TuKZIlowAwuME+iWJlBsSTiBDCqEr8FuoXz367Y3j2nZBID3KxR1L1FB
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 09:35:13.7515 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b8900ad-baae-47e8-f981-08deb589edd6
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B8B.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9023
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

On 13/05/2026 16:11, David Lechner wrote:
> Change all uses of tristate in the PHY Kconfigs to bool. U-Boot does
> not support modules, so tristate does not make sense here.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  drivers/phy/Kconfig          | 14 +++++++-------
>  drivers/phy/cadence/Kconfig  |  4 ++--
>  drivers/phy/qcom/Kconfig     | 16 ++++++++--------
>  drivers/phy/renesas/Kconfig  |  6 +++---
>  drivers/phy/rockchip/Kconfig |  2 +-
>  drivers/phy/ti/Kconfig       |  2 +-
>  6 files changed, 22 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
> index 5c8ec2b146f..eafa82fe494 100644
> --- a/drivers/phy/Kconfig
> +++ b/drivers/phy/Kconfig
> @@ -114,7 +114,7 @@ config BCM_SR_PCIE_PHY
>  	  If unsure, say N.
>  
>  config PHY_DA8XX_USB
> -	tristate "TI DA8xx USB PHY Driver"
> +	bool "TI DA8xx USB PHY Driver"
>  	depends on PHY && ARCH_DAVINCI
>  	help
>  	  Enable this to support the USB PHY on DA8xx SoCs.
> @@ -138,7 +138,7 @@ config SPL_PIPE3_PHY
>  	  and omap5
>  
>  config AM654_PHY
> -	tristate "TI AM654 SERDES support"
> +	bool "TI AM654 SERDES support"
>  	depends on PHY && ARCH_K3
>  	select REGMAP
>  	select SYSCON
> @@ -155,7 +155,7 @@ config STI_USB_PHY
>  	  STiH407 SoC families.
>  
>  config PHY_RCAR_GEN2
> -	tristate "Renesas R-Car Gen2 USB PHY"
> +	bool "Renesas R-Car Gen2 USB PHY"
>  	depends on PHY && RCAR_GEN2
>  	help
>  	  Support for the Renesas R-Car Gen2 USB PHY. This driver operates the
> @@ -163,7 +163,7 @@ config PHY_RCAR_GEN2
>  	  allows configuring the module multiplexing.
>  
>  config PHY_RCAR_GEN3
> -	tristate "Renesas R-Car Gen3 USB PHY"
> +	bool "Renesas R-Car Gen3 USB PHY"
>  	depends on PHY && CLK && DM_REGULATOR && (RCAR_GEN3 || RZG2L)
>  	default y if (RCAR_GEN3 || RZG2L)
>  	help
> @@ -171,7 +171,7 @@ config PHY_RCAR_GEN3
>  	  PHY connected to EHCI USB module and controls USB OTG operation.
>  
>  config PHY_STM32_USBPHYC
> -	tristate "STMicroelectronics STM32 SoC USB HS PHY driver"
> +	bool "STMicroelectronics STM32 SoC USB HS PHY driver"
>  	depends on PHY && ARCH_STM32MP
>  	help
>  	  Enable this to support the High-Speed USB transceiver that is part of
> @@ -283,7 +283,7 @@ config PHY_MTK_TPHY
>  	  so you can easily distinguish them by banks layout.
>  
>  config PHY_MTK_UFS
> -	tristate "MediaTek UFS M-PHY driver"
> +	bool "MediaTek UFS M-PHY driver"
>  	depends on ARCH_MEDIATEK
>  	depends on PHY
>  	help
> @@ -337,7 +337,7 @@ config PHY_IMX8M_PCIE
>  	  This PHY is found on i.MX8M devices supporting PCIe.
>  
>  config PHY_XILINX_ZYNQMP
> -	tristate "Xilinx ZynqMP PHY driver"
> +	bool "Xilinx ZynqMP PHY driver"
>  	depends on PHY && ARCH_ZYNQMP
>  	help
>  	  Enable this to support ZynqMP High Speed Gigabit Transceiver
> diff --git a/drivers/phy/cadence/Kconfig b/drivers/phy/cadence/Kconfig
> index 8c0ab80fbbc..f5f096889fe 100644
> --- a/drivers/phy/cadence/Kconfig
> +++ b/drivers/phy/cadence/Kconfig
> @@ -1,11 +1,11 @@
>  config PHY_CADENCE_SIERRA
> -	tristate "Cadence Sierra PHY Driver"
> +	bool "Cadence Sierra PHY Driver"
>  	depends on DM_RESET
>  	help
>  	  Enable this to support the Cadence Sierra PHY driver
>  
>  config PHY_CADENCE_TORRENT
> -	tristate "Cadence Torrent PHY Driver"
> +	bool "Cadence Torrent PHY Driver"
>  	depends on DM_RESET
>  	help
>  	  Enable this to support the Cadence Torrent PHY driver
> diff --git a/drivers/phy/qcom/Kconfig b/drivers/phy/qcom/Kconfig
> index 49f830abf01..7094903d869 100644
> --- a/drivers/phy/qcom/Kconfig
> +++ b/drivers/phy/qcom/Kconfig
> @@ -7,7 +7,7 @@ config MSM8916_USB_PHY
>  	  This PHY is found on qualcomm dragonboard410c development board.
>  
>  config PHY_QCOM_IPQ4019_USB
> -	tristate "Qualcomm IPQ4019 USB PHY driver"
> +	bool "Qualcomm IPQ4019 USB PHY driver"
>  	depends on PHY && ARCH_IPQ40XX
>  	help
>  	  Support for the USB PHY-s on Qualcomm IPQ40xx SoC-s.
> @@ -21,26 +21,26 @@ config PHY_QCOM_QMP_COMBO
>  	  PHY (USB3 + DisplayPort). Currently only USB3 mode is supported.
>  
>  config PHY_QCOM_QMP_PCIE
> -	tristate "Qualcomm QMP PCIe PHY driver"
> +	bool "Qualcomm QMP PCIe PHY driver"
>  	depends on PHY && ARCH_SNAPDRAGON
>  	help
>  	  Enable this to support the PCIe QMP PHY on various Qualcomm chipsets.
>  
>  config PHY_QCOM_QMP_UFS
> -	tristate "Qualcomm QMP UFS PHY driver"
> +	bool "Qualcomm QMP UFS PHY driver"
>  	depends on PHY && ARCH_SNAPDRAGON
>  	help
>  	  Enable this to support the UFS QMP PHY on various Qualcomm chipsets.
>  
>  config PHY_QCOM_QUSB2
> -	tristate "Qualcomm USB QUSB2 PHY driver"
> +	bool "Qualcomm USB QUSB2 PHY driver"
>  	depends on PHY && ARCH_SNAPDRAGON
>  	help
>  	  Enable this to support the Super-Speed USB transceiver on various
>  	  Qualcomm chipsets.
>  
>  config PHY_QCOM_USB_SNPS_FEMTO_V2
> -	tristate "Qualcomm SNPS FEMTO USB HS PHY v2"
> +	bool "Qualcomm SNPS FEMTO USB HS PHY v2"
>  	depends on PHY && ARCH_SNAPDRAGON
>  	help
>  	  Enable this to support the Qualcomm Synopsys DesignWare Core 7nm
> @@ -48,7 +48,7 @@ config PHY_QCOM_USB_SNPS_FEMTO_V2
>  	  is usually paired with Synopsys DWC3 USB IPs on MSM SOCs.
>  
>  config PHY_QCOM_SNPS_EUSB2
> -	tristate "Qualcomm Synopsys eUSB2 High-Speed PHY"
> +	bool "Qualcomm Synopsys eUSB2 High-Speed PHY"
>  	depends on PHY && ARCH_SNAPDRAGON
>  	help
>  	  Enable this to support the Qualcomm Synopsys DesignWare eUSB2
> @@ -56,7 +56,7 @@ config PHY_QCOM_SNPS_EUSB2
>  	  is usually paired with Synopsys DWC3 USB IPs on MSM SOCs.
>  
>  config PHY_QCOM_USB_HS_28NM
> -	tristate "Qualcomm 28nm High-Speed PHY"
> +	bool "Qualcomm 28nm High-Speed PHY"
>  	depends on PHY && ARCH_SNAPDRAGON
>  	help
>  	  Enable this to support the Qualcomm Synopsys DesignWare Core 28nm
> @@ -65,7 +65,7 @@ config PHY_QCOM_USB_HS_28NM
>  	  IPs on MSM SOCs.
>  
>  config PHY_QCOM_USB_SS
> -	tristate "Qualcomm USB Super-Speed PHY driver"
> +	bool "Qualcomm USB Super-Speed PHY driver"
>  	depends on PHY && ARCH_SNAPDRAGON
>  	help
>  	  Enable this to support the Super-Speed USB transceiver on various
> diff --git a/drivers/phy/renesas/Kconfig b/drivers/phy/renesas/Kconfig
> index affbee0500c..3358d454e59 100644
> --- a/drivers/phy/renesas/Kconfig
> +++ b/drivers/phy/renesas/Kconfig
> @@ -3,19 +3,19 @@
>  # Phy drivers for Renesas platforms
>  
>  config PHY_R8A779F0_ETHERNET_SERDES
> -	tristate "Renesas R-Car S4-8 Ethernet SERDES driver"
> +	bool "Renesas R-Car S4-8 Ethernet SERDES driver"
>  	depends on RCAR_64 && PHY
>  	help
>  	  Support for Ethernet SERDES found on Renesas R-Car S4-8 SoCs.
>  
>  config PHY_R8A78000_ETHERNET_PCS
> -	tristate "Renesas R-Car X5H Ethernet PCS driver"
> +	bool "Renesas R-Car X5H Ethernet PCS driver"
>  	depends on RCAR_64 && PHY
>  	help
>  	  Support for Ethernet PCS found on Renesas R-Car X5H SoCs.
>  
>  config PHY_R8A78000_MP_PHY
> -	tristate "Renesas R-Car X5H Multi-Protocol PHY driver"
> +	bool "Renesas R-Car X5H Multi-Protocol PHY driver"
>  	depends on RCAR_64 && PHY
>  	help
>  	  Support for Multi-Protocol PHY on Renesas R-Car X5H SoCs.
> diff --git a/drivers/phy/rockchip/Kconfig b/drivers/phy/rockchip/Kconfig
> index 80128335d52..6f3d7ebe29e 100644
> --- a/drivers/phy/rockchip/Kconfig
> +++ b/drivers/phy/rockchip/Kconfig
> @@ -49,7 +49,7 @@ config PHY_ROCKCHIP_SNPS_PCIE3
>  	  also be able splited into multiple combinations of lanes.
>  
>  config PHY_ROCKCHIP_USBDP
> -	tristate "Rockchip USBDP COMBO PHY Driver"
> +	bool "Rockchip USBDP COMBO PHY Driver"
>  	depends on ARCH_ROCKCHIP
>  	select PHY
>  	help
> diff --git a/drivers/phy/ti/Kconfig b/drivers/phy/ti/Kconfig
> index df750b26d66..fe96eb6806f 100644
> --- a/drivers/phy/ti/Kconfig
> +++ b/drivers/phy/ti/Kconfig
> @@ -1,5 +1,5 @@
>  config PHY_J721E_WIZ
> -	tristate "TI J721E WIZ (SERDES Wrapper) support"
> +	bool "TI J721E WIZ (SERDES Wrapper) support"
>  	depends on ARCH_K3
>  	help
>  	  This option enables support for WIZ module present in TI's J721E
> 
> ---
> base-commit: e3e651c480c46b332f16a7555b97c6c6fd640a40
> change-id: 20260513-phy-kconfig-no-tristate-61bc2d324149
> 
> Best regards,
> --  
> David Lechner <dlechner@baylibre.com>
> 

Added to net-next, thanks!

-- 
Jerome
