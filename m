Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADED7FF8855
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 14:56:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F40F084968;
	Tue,  5 May 2026 16:56:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="pmiCwEWK";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="pmiCwEWK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 411A18496D; Tue,  5 May 2026 16:56:40 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3004B848FC
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 16:56:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jerome.Forissier@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=NI1VDO5VtxTOpLKUiXVmj648haa2ZUOg6HiAeBa4VO1qQ6TfM7q410V4Pv66kdwTdaEVWvMcCbRte4javqpNOnx1bEkitSq0nt3MeVa26IlfLUrNG8i4WS+ZIlPCx1qnWTUi2AfSr/e+VSwFLvN3e8W8RbuNZ+b1L2IwzETXZLpKdCneRkyx5jCot9BCZte3TgEPI4hTegb6WdVrqoKbIGKxtnPFSiy61ZdJGfjcCDuEkroCzy7BgaS/o7gFfDj3HPCajWoCpLUvWhPODSpgr8bN77XVtCm96quOHNVnNYG48y3T68j1ricSsl1CA2a8NwPaSoQ3HGDExA3fB+KXcQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yZelD2986DhZWBnrHcWzDk2VjvIO/2HTJuK3xA1whIo=;
 b=mtOIvG2PeJfsVwkQOEIL78DsLjhJECUeV3g7KbzZouZif/KvqEjeUYuIWOGi8HTuZ+LQKkH1YNUYJrobovvB6lf9FDlOOaiiFG40w2uqNaPbecPwGXW9z3/aVxyG+4+arpZ4i+32dsMZhUbinNzYG7WQqM4y5Ui+79mgEEq4N3XqVwMCPS6td9vVBhsEsdttnVOZqgSFFYhfCQ2MciO4vQcMc7sExJwOTBQ+LfywPaV0rgaIqgBm+y1gnume+BNYxDy3G1VhIMUxSiNSuxNFL6O2X08rVO0LIHkDz/q6PzkelLhvy5Qu7Kjsec6hFm8lMcNCZAp+nD5Hk0kKKbmJjQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=baylibre.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yZelD2986DhZWBnrHcWzDk2VjvIO/2HTJuK3xA1whIo=;
 b=pmiCwEWKPZddeFxc8rObYBWzImdgOrXG7qg3sMCGKEk4eW3j7hjLodo9RYj78oiM47HQUJ/dYO35DIQ9nOeRmNSr6RRfQhqyNed3Od/D/O47/q668uPRPSkuOgcHuq58eZFgQDNvJnKvHGIHAeecyGKPg6tivc73P4d8A37k2Mw=
Received: from AS4P190CA0051.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:656::25)
 by AM8PR08MB5556.eurprd08.prod.outlook.com (2603:10a6:20b:1db::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.27; Tue, 5 May
 2026 14:56:34 +0000
Received: from AM2PEPF0001C712.eurprd05.prod.outlook.com
 (2603:10a6:20b:656:cafe::ca) by AS4P190CA0051.outlook.office365.com
 (2603:10a6:20b:656::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.27 via Frontend Transport; Tue,
 5 May 2026 14:56:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM2PEPF0001C712.mail.protection.outlook.com (10.167.16.182) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.9
 via Frontend Transport; Tue, 5 May 2026 14:56:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ytqbNPbqzIBPyXbqRkOXQsYjuMEE//DkVbB+/KLUUY4v40oB0hW40W8X1zitHpyUhmW6v2TVO9LnG2gxxW96QHl63Hm/Wt9Pylmzk/Sk1p0WAfr1p1gf0JBnEvJRcQfuKQFi1bKB27JTuPgxs2OAHbOXw7oNpVIbd8CQsBxwyGotSUnSVy0W4vNeV9ObJuOagznIRrTCX1CngLPQlb7IMPfooqoD8P7qkN+stpgYsrrg5qZx97eznMpbISSkEVoqeXIirAftSWdsobk6LRaM4tu5eggiuitvHLf65p+keDt7UGZS5uv70rVFe6MeiAewBcu0/tSY2FYCkbThdtsg9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yZelD2986DhZWBnrHcWzDk2VjvIO/2HTJuK3xA1whIo=;
 b=upktpA7AbosI5hkJhoIfN2p+IqaByS9NvvYQ3GZvTh3IMHRmK/WlMs7ZP2CtDvuc9CsI1UJbyTaMiTaXJ3+PXCkQRe5U1YxrnJc7imyDQpQLscPoycC5l9/B7w7SkO3Ytf6r0lXmsrlPEkDrpoxNIyO1xzvuOLL0bB75eVp+dYOhSoQsUI+KIjA6l3Vc/fuvIHs8xMWvNeqHN+1l4eEljms791H5Y9kT/NoGbE3Aj63NK9Wgcr1Add47AgLjpGdnciA3sa/rTKbUopJ62rsw1En1PKY9PW5dz8lVhBy2AFLgHJqau59hJlJ9Jpp83HUwc+SqXCIMDkxdyHe+EN0BrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yZelD2986DhZWBnrHcWzDk2VjvIO/2HTJuK3xA1whIo=;
 b=pmiCwEWKPZddeFxc8rObYBWzImdgOrXG7qg3sMCGKEk4eW3j7hjLodo9RYj78oiM47HQUJ/dYO35DIQ9nOeRmNSr6RRfQhqyNed3Od/D/O47/q668uPRPSkuOgcHuq58eZFgQDNvJnKvHGIHAeecyGKPg6tivc73P4d8A37k2Mw=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by VI0PR08MB11709.eurprd08.prod.outlook.com
 (2603:10a6:800:310::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Tue, 5 May
 2026 14:55:32 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%3]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 14:55:32 +0000
Message-ID: <85b27ff6-22f9-47f3-ba6f-32b08dec24a2@arm.com>
Date: Tue, 5 May 2026 16:55:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] net: cpsw: Add cpsw-switch DT binding support
To: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, nd@arm.com
References: <20260410-topic-cpsw-switch-v2026-07-next-v1-0-c914724b13e4@baylibre.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20260410-topic-cpsw-switch-v2026-07-next-v1-0-c914724b13e4@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0369.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:37c::8) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|VI0PR08MB11709:EE_|AM2PEPF0001C712:EE_|AM8PR08MB5556:EE_
X-MS-Office365-Filtering-Correlation-Id: 5be2c1ae-f7de-4e3f-6e9b-08deaab67ffd
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|1800799024|376014|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info-Original: 8IyfvgIaKpPljleopSyT2Bjop1bCK4jjgbT0PTcrWWrDTBVTWZg09LdNgseXZvRvZkDrfO+5e0jj0WBtI/Q7AlJbNrp5T5EPgnAfiqOjShtnblDTxr/WZqwVhK8T2MBOZrpptUxqaNJB/0Sf7Qb2d2pSFTJRq46Al4/C/0XxKkRmbhmr74QQKK8co+CxzWwCscoIWg+W4D6ZLE5FjEa76GT5rEESzTT8WfsrmxkYYy7eC4p990asRLVR71iFx2vU8AGxDV1HXG6cwJCkY2y+yQCaxvEyZlTo0h4RITWqgleKQrH3ImzWGET/MiqF/CA7a/qv4VvtrCwRcpkOmaxxLVgAO621Lgs+T3blxBQxkussRnnHaBuojwh+z+rRZDLSs/0F64eqCQERi4xbeFkb74AyiZ015da/sYgPOtKcxypCzPOvJ3qcvpmOuM21DlJfjOZl/Ia+gT+1Uv8TKzDe4I8IQjY1/jp8d5HrwAbpRBul3Llv+1ZwS96IiJHADPqr18IJP4TefX8r9UY/Vg68i8u3T2eLJNwKDvlPWaBH3UkJdbl5OpSeJoSvhdYo1lGyykcBSCOQ3L4Y9DH1iPcVYvS6oQDZ5mWMA0J5gDXG516ujRVxgDlfPSIesX6vnyb4cQpN6K5iPg+fcN2KoppFExA1XazYOdEqLF5jm3Q3Zk8tybXlGtZQnB/FfIRTXRA8
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: uTb/p+0h+5qutOrRPpQs+xk6pGo4EeOBRZPTRmIf3THZOCcVeMWuj6k+P8TdsLI+qqcoOw7R4NaBudqgniigdv3OZQW31Ktwt1IGUi/FMacLbjwZaYMu+kNy7xIAwqDMSewcete9qwZ95CeAnKNzFBXpO/Rf9S4wOrRn6Uu4a4dI079MvH39agEFAv1A6lrAvtgwbjRgN5Ayl19j9mqGtpIc1kaNt+yLDilBI23JCGlz55TET/MnPv/7Eo2b0TA+SKvIBYEx9kUpWf2nNAP9wH7x9Z6yaJ9UJlUwmcfP3rL/SB+FGXxxrsusT13Al2IBxmanGp6berxWrHOyMOlPOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB11709
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM2PEPF0001C712.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: d147626d-9f1c-4265-8e5d-08deaab65afa
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|35042699022|1800799024|82310400026|36860700016|376014|14060799003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: TAR5Cy0SOgUyU0omxzs6j7mxHw0OZ+xCOqbx8qAT6kzLYYpZXrkrIYwGEM+ejd2dtiFF65xBhzGoTTFFQqEadXeJFIpaajoQvRiuhwwEc8sXmEvlD6n2R6oxLRhTAaFonhtXxKPMZ+XNjQ5nUbp5ePafTb8HLsvT3KM7tlWLUYNJoYwbaWBLKHbMWdI0FvvabT0tGR7ZaidpmggJds9ngr1vkGquA3bNiwMeuixnsHVMflA1BbsSa7ed5CYXGgifJ6Hmxv9Bj7DQ7CzO8eQnv4TLC6lLA51tPvBDLJoP0kMOCNenIV2pwn2rlXfLjyGLGBiBH1dLfDAjeW7mqae51uziSuOFFS+s1H7W/4+9+fND/KWEmD9P+uuGrOHr1HHNKpd9wkkfktIsLP1R5xNibHWOYYbX+qtJTeM5I1/aCL9t82nxadbwPBXPE768gsKiq+HnnB0JunayT/JRhZ/p0w5DMzdRebO3NW1RF1evK3Veinpdut9GxDH0c2KYOHN0Xp35er1lc+Yyov/eQuZk8ZOcP4oG1tH2qvoFhxn6ZLPVw/xE8n6wymSo3LHET2XSu7US1FfIrMtlQq9Qc2C0QHhslxQPjS5OYJcm9lkeXvSaiFzz8AistoWwe4ZideCxNPDBqBt1/3qaDDdKpWYUhMM4TKZfuNpcbRpzRqaPlfudC+QGhDlVqzBxBTB9JIUa9ipS2rfmysNFskS9RKqyC9qpxnmF1p9ShZo0Fm/wTsA=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(35042699022)(1800799024)(82310400026)(36860700016)(376014)(14060799003)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ubii/HWvk8ZfX+bJScnkKMWLLxOVgr89X3RvRDw6+OaoCq/crUqgpTf+n8IhXF49z3NsL0Ikbv++a89SwF7oCAsQCsBRh3nZ7e2HUbocZFKcG1vKF9RnHZRnYry8pU7RTdVfu20Nuy3dR4O1wAlJsKlJCulq2DMAgDZALnxXUGT6Hu6U4gyPmAJiYn/dA0cVPAM9HwFP6yh5IGcspUOi2f2G0WWCVrkIL9mxtWwB90suoeS+eAfJJrOCkrR1TNs2GiWnf7Sc9BMxmb9vuVHbObHQRhNp+NkUblIlpvBGnDWjmdJe19uAWVaZMvrTYwC5SdnonSeMHCbCaiyR3euaJ5VYII05j8Oiy4eEW/RQk2Dkm7k9xmbeLzHnIGy63ekeJyi/aO1PEEgr1TslR1pbLXUu+A/2m5Lb+YibMIGrBVZF5F8xaEeydyQI5rS7d+YY
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 14:56:34.0302 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5be2c1ae-f7de-4e3f-6e9b-08deaab67ffd
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AM2PEPF0001C712.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5556
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

On 10/04/2026 13:04, Markus Schneider-Pargmann (TI) wrote:
> Hi,
> 
> this series adds support for the new cpsw-switch DT bindings in the cpsw
> driver. It does not add support for advanced functions in the current
> driver.
> 
> As most upstream devicetrees are using the newer cpsw-switch DT bindings
> by default, it is necessary to be able to parse these so OF_UPSTREAM can
> be used with minimal changes to the DT in u-boot.
> 
> Best
> Markus
> 
> Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
> ---
> Markus Schneider-Pargmann (TI) (4):
>       net: cpsw: Fix error message
>       net: cpsw: Remove compat string argument
>       net: cpsw: Use driver data for phy_sel
>       net: cpsw: Support new cpsw-switch DT bindings
> 
>  drivers/net/ti/cpsw.c | 190 +++++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 143 insertions(+), 47 deletions(-)
> ---
> base-commit: 1c1bfb1cf34bbb2a5717eb6995c55093279f9341
> change-id: 20260410-topic-cpsw-switch-v2026-07-next-89e21f2d2446
> 
> Best regards,

Series added to the net queue, thanks!

-- 
Jerome
