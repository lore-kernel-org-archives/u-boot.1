Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DF46C43602
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 07:15:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B58B784118;
	Wed,  8 Jul 2026 09:14:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="ab2ttrLM";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ab2ttrLM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCA1E8497A; Wed,  8 Jul 2026 09:14:56 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02D2C838D7
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 09:14:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jerome.Forissier@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=q6BkkZ0S4B9GXORwDz7sxKDWwMSG8N+VSf/UBZk2K0CsAjQyOKp7VW4SIlmIwpfXP2Uj8t5pYSqS5F9ES/MoVqX+eQD7w1oTMsn4+Mf93iIa2ZLdut5g+V7P54MP5S96MbyJIXfyAfL+nVYm5AvfrLtDvLbpfUgmP0LdGDZo7SM7iUwYqAZgQ2XIwmYQO4gRuat1LBSCqQp7uwcQ0ot9qh2TWIa6xKu71L3ot3qqA3mera1TJ8BQCDh+hwmoY7Cq/yRfRHMICSeqAvqwFRlXikx3HMxMGEZ8ASHtvnchNgyPrSs8HIk4eGpngA5oPBWVEIcqWSYEaS1zqkJkzJP/vA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RbVR427i1awizH0C+9cHOa77gagYVacrnU537saLdvM=;
 b=uk6aMxekBCcvTEIdO10DgkDR9Mu32duGNIOmbZFrqObQyx6AyicDjPcbMBOJtb8CkurANRJ4gqXE6UX4YIDPf8alprlut8BdmuBqt5MNe3UncLaEbC056FAIsBcIA1zz/oy/SvGxCP2d1pFrAYaeHtNSRhroARfe9aG+r6lEDdxVNv/VCyqT2xu1i0Uc8BnwTYhXG7G/2xjOL4SpU478yi/1dkw+P/ZwOf66l7XAqnIEj+bhJ09YB8h3H7YICMryGaK2BlCG3b8Pohp2PlNEa211H9YRLhvDP+Prgcf6DTydMfUPOul1FxzgHqY5biJEuH0BNJ67aF6yjPVWtobldA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=gmail.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RbVR427i1awizH0C+9cHOa77gagYVacrnU537saLdvM=;
 b=ab2ttrLMawjg9a0kf87QW2HXCf0TnDcBO4IK8QQlVhpU2f3RsHZ5lxjEUrWqCf5M0//dxa7K1R4o0hvetgZo8xQvR19nbFk3vbEt3gF52ySaip7ly8HR/x+TRuV6JoiChDqNis8ip8YVSNlvjVehoo3/xwt6bO4LBSDbM04H97E=
Received: from AS4P251CA0026.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:5d3::15)
 by DB9PR08MB9755.eurprd08.prod.outlook.com (2603:10a6:10:460::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 8 Jul 2026
 07:14:47 +0000
Received: from AMS0EPF000001B5.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d3:cafe::2b) by AS4P251CA0026.outlook.office365.com
 (2603:10a6:20b:5d3::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.10 via Frontend Transport; Wed, 8
 Jul 2026 07:14:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF000001B5.mail.protection.outlook.com (10.167.16.169) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Wed, 8 Jul 2026 07:14:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bxtx59fRuSYYwAMjflhXlZzxchwhNPoW9cIQHjDze1BYsPkuIwCUxc8ehMdmWQh9G2L4q6WghRQ0f3vE8hbPJ/J4OKPeqZyrYxZrKTzvyppeYOQra7h5Yejj2mw/he0AR5aServFCcLRP4PpbwdPweK37up5Aaf+0l75pvSlcHcLL91QYSuSjC3mwDJho7dVCBoJVoN9jmWEFX78RdZcdSiF7v7GkTprYVKeNzCrxSUZfnSzemnEy6ATXaCODnV4usA9OoQWcGv9tVq0kv163u6P34bK2nvzqmObjeqgDErJ8PXKiXHTDUNdr0xD7ajFkzZri9zWEWnHvrwrlv15Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RbVR427i1awizH0C+9cHOa77gagYVacrnU537saLdvM=;
 b=qhoO9MTEk50HRZnjl1Uczl3uZkLFpT0K3zP/qeEJ387iF5PxbzySxiACuHD3toGYV6j1ZUSbJzG3ljWaul5UbPn6hExTnZredSDYkUvuRYc+td1kmxdGd4BGC9b06ZZetIQFt6siPxOXxTmy5VH0rbeseDB13BZ8Za42z21+3SWwryyT9zVm427T2a8NWora4z7tIRDtWEh8P7XYZ6O7g18eDx/rSA6ymnu6KtwyonOMUR2fVrhtnWdhu1T25oEHSp6A/MTTfMFoKazh+OElD0luxYkzAwOz5y5RrOeKpSG/aTqp8kpQNi8Y/psUGcjKm7NQKX1ZYhCChBj9tYgLdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RbVR427i1awizH0C+9cHOa77gagYVacrnU537saLdvM=;
 b=ab2ttrLMawjg9a0kf87QW2HXCf0TnDcBO4IK8QQlVhpU2f3RsHZ5lxjEUrWqCf5M0//dxa7K1R4o0hvetgZo8xQvR19nbFk3vbEt3gF52ySaip7ly8HR/x+TRuV6JoiChDqNis8ip8YVSNlvjVehoo3/xwt6bO4LBSDbM04H97E=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.14; Wed, 8 Jul
 2026 07:13:42 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%3]) with mapi id 15.21.0181.009; Wed, 8 Jul 2026
 07:13:42 +0000
Message-ID: <f2517f37-7f2e-4d3d-9b40-249f1318cb77@arm.com>
Date: Wed, 8 Jul 2026 09:13:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] net: lwip: add tftpsrv command
To: James Hilliard <james.hilliard1@gmail.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen
 <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Johan Jonker <jbx6244@gmail.com>, Heiko Schocher <hs@nabladev.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Benjamin Hahn <B.Hahn@phytec.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>,
 Tim Harvey <tharvey@gateworks.com>, Jonas Karlman <jonas@kwiboo.se>,
 Pranav Sanwal <pranav.sanwal@amd.com>, Peter Robinson
 <pbrobinson@gmail.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 nd@arm.com
References: <20260707164721.706800-1-james.hilliard1@gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20260707164721.706800-1-james.hilliard1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0672.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:351::10) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|AM9PR08MB5892:EE_|AMS0EPF000001B5:EE_|DB9PR08MB9755:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d94e794-03b2-42ab-56cf-08dedcc0979b
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|7416014|376014|23010399003|366016|1800799024|56012099006|11063799006|6133799003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info-Original: XvwkslYEBfTPe4vKPKmZSpP/TM2wxrqerVbIfOGeI0W0cjVpIrD6eG5wPHsoneTfSrQdmmvtQAn+l1nCUJkc+Ra5ycj1Tiiu0O8EfcHUf+h6y2RpnA5QGufNFRh+pHXTSHtMoxctz0AHTHn1cRsRU9jXFDnPCZeKXU5mtCwtTskHAS2vsps6tcsmnAJPee6mMMFQ2q8BQeQoyA3iDyx/aVgWp2i7rbEXnmFLXMEAt+UQZ6i+KVPf5cdiuGAnbT6Il+RRuJQDGNmD10SK44nggEIEsF9BbQRTICaJ4TSUIsAlc3rVzfKLza9bE7jTOLPbHL3x33bqlFJmReuormQQNvXcv3NM87SRJxY6ZM/6TXfNYG8YOmRDOXrYbOZyUgdsMxUw7C6LR/cp/nn7wp/Pe6scRgQ2U6FfFvKhGwsDO2XpFMzNQc/dyl5yt380iOwt8oZssWzPK85clOE8kVyXNnva7xaffoNIdxsuwLNj3BtF5aZCRO2NPX9NZDbiPAgBDUUWpjT+pZnc6av8UppQVD5Jh53UlpzP1v1v6ohBessIvBFgvw0Oe7vLH09HtB4ifhljIF8GBMsULql6sACz10CJKxxzVEo1hip04MBLRv0/zEelvkktuoLXD9FjQPp+
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: lYYdURRZJ2TRTnt162oZDrHfBMsp0+r6gXD2JqPCnPHBP9T2gW9CzITjDtFDcrWSDfGI/fIoyfAPluR1PDLeVBKi7iCX+xw5/fYjmnHGjdxPgNEtekFsmxm+l8chkCltWbe0wLXC7QZruEZfJ7RKP5wr0nFT13WAQAAn1I381gBqKshU+/wsbjKewJZlXJS/LyzfMUyJZdVdNcAu01P8QQzPExE16vmmIAe2KipKQ0gkZj7j56d+7uwdBR6hAh4vp1fbdDZQHtnXQzOYSCemJCZ0O1Lbxf4rcJWllJp5tdNebczCr1/4sNT1ZxRKabkZw6oEsirWUDKjRR+70AUoVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB5892
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS0EPF000001B5.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: f83fa82b-cd6a-4833-03a4-08dedcc07101
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|14060799003|36860700016|1800799024|23010399003|35042699022|82310400026|376014|6133799003|18002099003|22082099003|3023799007|13003099007|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 3KOfckCulMy4CmGks2lCKZy8rbvPcGcFy/1aKAnYAcYT/qgsZl+viTjzoiLbkHew8s9O5k54HjqrOSo9hu8dWIn1Ey4IpXcDe9Erfc49LWMWqA9xIP8hnNpD/NORCtajYuceZl6kUxVvKPYClx4ls2lkpXxK9DMushJtpUNQfdM0+qG7MWyKrIaA3UwH0rhTjKS6HFwACAuhUaAfTM1uOgdSz/WekO6EYI4DWeLbU5Zufe7ImvQga4xcpnVUnO4UMFA9OOBhhvKx2R8LJ9xdLIVq0nRIPveYzp9FW1B/li7mrbGf2UolsasLN2Az8f1TFBk/Vyckn6CtU60INSjRYdhlh/m7ArqVAZi2hcRjzALkFujoW8bpaQKAgomwQLvpnsvCk+qmrYDeG0viXvKBi6CDbnFG51oLS86ZVdAyKUu8ZoyMo2kdfX/6eJqhULVhAOhFfk6RD0SJtrp7BzV+rXRudyC0F7IBQLs+IlaWspt8huy3N3Wbso8afJMrPftjb4vQ8Wizp+IAfqb/8rKKiOfD09jSkejUyxcLb/ex0w25Clh+sGLpdMNDv2MYVdquo0N2/TasqwSS4STeRDtpDqQaUQmL8AOdyBolIu0z4AAJ3sJZuvygrMEuB7K4yeknJNGPlBDgmRq3zVzLcDVenc28XypdBCJk7tYdAMH9xEk=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(7416014)(14060799003)(36860700016)(1800799024)(23010399003)(35042699022)(82310400026)(376014)(6133799003)(18002099003)(22082099003)(3023799007)(13003099007)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XYBaWyR7JldGLjQi2YWTTmaFldzBPMD1orxjZeOlD3cSQ964ruQZNpMg9QC+3zqUERgiUnV6l2+Y4SpkQ9nS188cE1VfWtreq7J1F6BoeQmqJdtuUb15lelMwmoGWMR1ZdGIn76vchDKljexjR4b57FgMf8siXwPjqq2T8mdOfF16L2l7gkCYmRADXYZ2+YGkhY6nj7UHs4odPbvWS9W46bOXWq+jtPIdZ+DTZ76QC+yMT8fPxprqzpbacAdMGdfofq1YpgWz53g+WkO0grn197Iz5HdD6rkPS2SskMTkwzSOj2ir4ZVsP0WTU85PGhoGr338nxma+hrsCHvW4whqid5/SBqgBNefdSDSsXDsPXpkVBaeC660+7aZJ90vbnomXZSjT1mnREuamBX+8n4xvBiLR5cu4I5wU0NLpHpdNbTlMu6hP4cen5QFvyYbcJe
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 07:14:46.7526 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d94e794-03b2-42ab-56cf-08dedcc0979b
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001B5.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB9755
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

Hi James,

On 07/07/2026 18:47, James Hilliard wrote:
> The legacy network stack supports tftpsrv, which listens for an
> incoming TFTP write request and receives the first file into memory.
> Despite the old command help wording, the command returns after
> receiving the file and does not boot it automatically.
> 
> The lwIP stack already builds the lwIP TFTP application, but only wires
> it up for client-side tftpboot. Add a lwIP tftpsrv command and
> implement the server path with tftp_init_server(). Reuse the existing
> lwIP TFTP write callback and memory copy path so LMB checks, progress
> output, filesize/fileaddr updates and EFI bootdev handling stay
> consistent with tftpboot.
> 
> Track receive timeout and write-failure state around the lwIP callbacks
> so a stalled or rejected receive is not reported as a successful close.
> 
> Move CMD_TFTPSRV out of the legacy-only Kconfig block so it can be
> enabled with either network stack. Update the command help text and add
> usage documentation for the receive-only behavior.
> 
> Add pytest coverage for tftpsrv using a generated host file and curl's
> TFTP upload support. Enable the command in qemu_arm64_lwip_defconfig so
> the test can be run with the existing lwIP QEMU build when the boardenv
> provides env__net_tftpsrv_file.
> 
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
> Changes v2 -> v3:
>   - Use an explicit TFTPSRV_LISTEN_TIMEOUT_MS value
>   - Allocate the server transfer context dynamically
>   - Halt the lwIP Ethernet device after tftpsrv exits
> 
> Changes v1 -> v2:
>   - Add tftpsrv usage documentation  (suggested by Quentin Schulz)
>   - Add tftpsrv pytest coverage  (suggested by Quentin Schulz)
>   - Enable CMD_TFTPSRV in qemu_arm64_lwip_defconfig
>   - Allow tftpsrv pytest coverage to use an explicit upload URL
>   - Keep tftpsrv pytest coverage gated by env__net_tftpsrv_file
>   - Clarify that tftpsrv returns after receiving instead of booting
>   - Update legacy and lwIP command help text for receive-only behavior
> ---
>  cmd/Kconfig                       |  14 ++-
>  cmd/lwip/Makefile                 |   1 +
>  cmd/lwip/tftpsrv.c                |  11 ++
>  cmd/net.c                         |   4 +-
>  configs/qemu_arm64_lwip_defconfig |   1 +
>  doc/usage/cmd/tftpsrv.rst         |  73 +++++++++++
>  include/net-lwip.h                |   1 +
>  net/lwip/tftp.c                   | 194 +++++++++++++++++++++++++++++-
>  test/py/tests/test_net.py         |  94 +++++++++++++++
>  9 files changed, 380 insertions(+), 13 deletions(-)
>  create mode 100644 cmd/lwip/tftpsrv.c
>  create mode 100644 doc/usage/cmd/tftpsrv.rst
> 
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index ca1039f6a03..c9a6c7c33a2 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -2134,12 +2134,6 @@ config CMD_TFTPPUT
>  	help
>  	  TFTP put command, for uploading files to a server
>  
> -config CMD_TFTPSRV
> -	bool "tftpsrv"
> -	depends on CMD_TFTPBOOT
> -	help
> -	  Act as a TFTP server and boot the first received file
> -
>  config NET_TFTP_VARS
>  	bool "Control TFTP timeout and count through environment"
>  	depends on CMD_TFTPBOOT
> @@ -2286,6 +2280,14 @@ config CMD_TFTPBOOT
>  	help
>  	  tftpboot - load file via network using TFTP protocol
>  
> +config CMD_TFTPSRV
> +	bool "tftpsrv"
> +	depends on CMD_TFTPBOOT
> +	help
> +	  Act as a TFTP server and receive the first incoming file into
> +	  memory. The command returns successfully after the transfer so
> +	  boot scripts can boot the received image from the load address.
> +
>  config CMD_WGET
>  	bool "wget"
>  	default y if SANDBOX || ARCH_QEMU
> diff --git a/cmd/lwip/Makefile b/cmd/lwip/Makefile
> index 90df1f5511c..245683a9672 100644
> --- a/cmd/lwip/Makefile
> +++ b/cmd/lwip/Makefile
> @@ -4,4 +4,5 @@ obj-$(CONFIG_CMD_NFS) += nfs.o
>  obj-$(CONFIG_CMD_PING) += ping.o
>  obj-$(CONFIG_CMD_SNTP) += sntp.o
>  obj-$(CONFIG_CMD_TFTPBOOT) += tftp.o
> +obj-$(CONFIG_CMD_TFTPSRV) += tftpsrv.o
>  obj-$(CONFIG_CMD_WGET) += wget.o
> diff --git a/cmd/lwip/tftpsrv.c b/cmd/lwip/tftpsrv.c
> new file mode 100644
> index 00000000000..6370c900489
> --- /dev/null
> +++ b/cmd/lwip/tftpsrv.c
> @@ -0,0 +1,11 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +#include <command.h>
> +#include <net.h>
> +
> +U_BOOT_CMD(tftpsrv, 2, 1, do_tftpsrv,
> +	   "act as a TFTP server and receive the first file",
> +	   "[loadAddress]\n"
> +	   "Listen for an incoming TFTP transfer and receive a file into memory.\n"
> +	   "The transfer is aborted if a transfer has not been started after\n"
> +	   "about 50 seconds or if Ctrl-C is pressed.");
> diff --git a/cmd/net.c b/cmd/net.c
> index f6f556f36ae..0f0b2386d87 100644
> --- a/cmd/net.c
> +++ b/cmd/net.c
> @@ -89,9 +89,9 @@ static int do_tftpsrv(struct cmd_tbl *cmdtp, int flag, int argc,
>  
>  U_BOOT_CMD(
>  	tftpsrv,	2,	1,	do_tftpsrv,
> -	"act as a TFTP server and boot the first received file",
> +	"act as a TFTP server and receive the first file",
>  	"[loadAddress]\n"
> -	"Listen for an incoming TFTP transfer, receive a file and boot it.\n"
> +	"Listen for an incoming TFTP transfer and receive a file into memory.\n"
>  	"The transfer is aborted if a transfer has not been started after\n"
>  	"about 50 seconds or if Ctrl-C is pressed."
>  );
> diff --git a/configs/qemu_arm64_lwip_defconfig b/configs/qemu_arm64_lwip_defconfig
> index a974970c3d3..06ed5a131db 100644
> --- a/configs/qemu_arm64_lwip_defconfig
> +++ b/configs/qemu_arm64_lwip_defconfig
> @@ -7,6 +7,7 @@ CONFIG_NET_LWIP=y
>  CONFIG_CMD_DNS=y
>  CONFIG_CMD_NFS=y
>  CONFIG_CMD_SNTP=y
> +CONFIG_CMD_TFTPSRV=y
>  CONFIG_CMD_WGET=y
>  CONFIG_EFI_HTTP_BOOT=y
>  CONFIG_WGET_HTTPS=y
> diff --git a/doc/usage/cmd/tftpsrv.rst b/doc/usage/cmd/tftpsrv.rst
> new file mode 100644
> index 00000000000..597a2f3a8bd
> --- /dev/null
> +++ b/doc/usage/cmd/tftpsrv.rst
> @@ -0,0 +1,73 @@
> +.. SPDX-License-Identifier: GPL-2.0+:
> +
> +.. index::
> +   single: tftpsrv (command)
> +
> +tftpsrv command
> +===============
> +
> +Synopsis
> +--------
> +
> +::
> +
> +    tftpsrv [loadAddress]
> +
> +Description
> +-----------
> +
> +The tftpsrv command listens for an incoming TFTP write request and receives
> +the first transferred file into memory.
> +
> +loadAddress
> +    memory address where the received file is stored. If not provided, the
> +    address is taken from the *loadaddr* environment variable or the default
> +    image load address.
> +
> +After a successful transfer, the *fileaddr* and *filesize* environment
> +variables describe the received file. The command returns successfully after
> +the transfer has completed. It does not boot the file automatically; boot
> +scripts can use commands such as bootm, booti or bootefi to boot from the
> +load address.
> +
> +The transfer is aborted if no transfer has started after about 50 seconds or
> +if Ctrl-C is pressed.
> +
> +Example
> +-------
> +
> +In the example the following steps are executed:
> +
> +* setup the board network address
> +* receive a FIT image from a host
> +* boot the received FIT image
> +
> +::
> +
> +    => setenv autoload no
> +    => dhcp
> +    BOOTP broadcast 1
> +    DHCP client bound to address 192.168.1.40 (7 ms)
> +    => tftpsrv $loadaddr
> +    Using ethernet@1c30000 device
> +    Listening for TFTP transfer on 192.168.1.40
> +    Load address: 0x42000000
> +    Loading: #################################################################
> +             6.5 MiB/s
> +    done
> +    Bytes transferred = 1048576 (100000 hex)
> +    => bootm $fileaddr
> +
> +On the host, send the file to the board while U-Boot is listening:
> +
> +::
> +
> +    $ curl --upload-file image.fit tftp://192.168.1.40/image.fit
> +
> +Configuration
> +-------------
> +
> +The command is only available if CONFIG_CMD_TFTPSRV=y.
> +
> +The command is supported by both the legacy network stack and the lwIP network
> +stack.
> diff --git a/include/net-lwip.h b/include/net-lwip.h
> index 20cb0992cce..571d8941ff0 100644
> --- a/include/net-lwip.h
> +++ b/include/net-lwip.h
> @@ -52,6 +52,7 @@ bool wget_validate_uri(char *uri);
>  
>  int do_dns(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
>  int do_nfs(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
> +int do_tftpsrv(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
>  int do_wget(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[]);
>  
>  #endif /* __NET_LWIP_H__ */
> diff --git a/net/lwip/tftp.c b/net/lwip/tftp.c
> index 7f3b28b8507..c4c5055c013 100644
> --- a/net/lwip/tftp.c
> +++ b/net/lwip/tftp.c
> @@ -11,14 +11,18 @@
>  #include <linux/delay.h>
>  #include <linux/kconfig.h>
>  #include <lwip/apps/tftp_client.h>
> +#include <lwip/apps/tftp_server.h>
>  #include <lwip/timeouts.h>
>  #include <mapmem.h>
> +#include <malloc.h>
>  #include <net.h>
>  #include <time.h>
>  
>  #define PROGRESS_PRINT_STEP_BYTES (10 * 1024)
>  /* Max time to wait for first data packet from server */
>  #define NO_RSP_TIMEOUT_MS 10000
> +/* Max time to wait for an incoming TFTP write request */
> +#define TFTPSRV_LISTEN_TIMEOUT_MS 50000
>  
>  enum done_state {
>  	NOT_DONE = 0,
> @@ -34,8 +38,31 @@ struct tftp_ctx {
>  	ulong hash_count;
>  	ulong start_time;
>  	enum done_state done;
> +	bool is_server;
> +	bool wrq_accepted;
> +	char fname[TFTP_MAX_FILENAME_LEN + 1];
>  };
>  
> +/*
> + * The lwIP TFTP server open callback has no user-data argument. Keep the
> + * currently allocated server context here so tftp_open() can return it.
> + */
> +static struct tftp_ctx *tftpsrv_active_ctx;

OK
> +
> +static void transfer_timeout(void *arg)
> +{
> +	struct tftp_ctx *ctx = (struct tftp_ctx *)arg;
> +
> +	printf("Timeout!\n");
> +	ctx->done = FAILURE;
> +}
> +
> +static void restart_transfer_timeout(struct tftp_ctx *ctx)
> +{
> +	sys_untimeout(transfer_timeout, ctx);
> +	sys_timeout(TFTP_TIMEOUT_MSECS, transfer_timeout, ctx);
> +}
> +
>  /**
>   * store_block() - copy received data
>   *
> @@ -71,7 +98,7 @@ static int store_block(struct tftp_ctx *ctx, void *src, u16_t len)
>  	ctx->size += len;
>  	ctx->block_count++;
>  
> -	tftp_tsize = tftp_client_get_tsize();
> +	tftp_tsize = ctx->is_server ? 0 : tftp_client_get_tsize();
>  	if (tftp_tsize) {
>  		pos = clamp(ctx->size, 0UL, tftp_tsize);
>  
> @@ -92,7 +119,20 @@ static int store_block(struct tftp_ctx *ctx, void *src, u16_t len)
>  
>  static void *tftp_open(const char *fname, const char *mode, u8_t is_write)
>  {
> -	return NULL;
> +	struct tftp_ctx *ctx = tftpsrv_active_ctx;
> +
> +	if (!IS_ENABLED(CONFIG_CMD_TFTPSRV) || !ctx || !is_write)
> +		return NULL;
> +
> +	ctx->wrq_accepted = true;
> +	ctx->start_time = get_timer(0);
> +	snprintf(ctx->fname, sizeof(ctx->fname), "%s", fname);
> +	restart_transfer_timeout(ctx);
> +
> +	printf("\nReceiving '%s' mode '%s'\n", fname, mode);
> +	puts("Loading: ");
> +
> +	return ctx;
>  }
>  
>  static void tftp_close(void *handle)
> @@ -101,13 +141,15 @@ static void tftp_close(void *handle)
>  	ulong tftp_tsize;
>  	ulong elapsed;
>  
> +	sys_untimeout(transfer_timeout, ctx);
> +
>  	if (ctx->done == FAILURE || ctx->done == ABORTED) {
>  		/* Closing after an error or Ctrl-C */
>  		return;
>  	}
>  	ctx->done = SUCCESS;
>  
> -	tftp_tsize = tftp_client_get_tsize();
> +	tftp_tsize = ctx->is_server ? 0 : tftp_client_get_tsize();
>  	if (tftp_tsize) {
>  		/* Print hash marks for the last packet received */
>  		while (ctx->hash_count < 49) {
> @@ -142,9 +184,14 @@ static int tftp_write(void *handle, struct pbuf *p)
>  	struct tftp_ctx *ctx = handle;
>  	struct pbuf *q;
>  
> -	for (q = p; q; q = q->next)
> -		if (store_block(ctx, q->payload, q->len) < 0)
> +	for (q = p; q; q = q->next) {
> +		if (store_block(ctx, q->payload, q->len) < 0) {
> +			ctx->done = FAILURE;
>  			return -1;
> +		}
> +	}
> +
> +	restart_transfer_timeout(ctx);
>  
>  	return 0;
>  }
> @@ -204,6 +251,9 @@ static int tftp_loop(struct udevice *udev, ulong addr, char *fname,
>  	ctx.block_count = 0;
>  	ctx.hash_count = 0;
>  	ctx.daddr = addr;
> +	ctx.is_server = false;
> +	ctx.wrq_accepted = false;
> +	ctx.fname[0] = '\0';
>  
>  	printf("Using %s device\n", udev->name);
>  	printf("TFTP from server %s; our IP address is %s\n",
> @@ -258,6 +308,140 @@ static int tftp_loop(struct udevice *udev, ulong addr, char *fname,
>  	return -1;
>  }
>  
> +static void no_request(void *arg)
> +{
> +	struct tftp_ctx *ctx = (struct tftp_ctx *)arg;
> +
> +	if (ctx->wrq_accepted)
> +		return;
> +
> +	printf("Timeout!\n");
> +	ctx->done = FAILURE;
> +}
> +
> +static int tftpsrv_loop(struct udevice *udev, ulong addr)
> +{
> +	struct netif *netif;
> +	struct tftp_ctx *ctx;
> +	const char *ipaddr;
> +	int ret = -1;
> +	err_t err;
> +
> +	if (addr == 0)
> +		return -1;
> +
> +	ipaddr = env_get("ipaddr");
> +	if (!ipaddr || !*ipaddr) {
> +		log_err("error: ipaddr has to be set\n");
> +		return -1;
> +	}
> +
> +	netif = net_lwip_new_netif(udev);
> +	if (!netif)
> +		return -1;
> +
> +	ctx = calloc(1, sizeof(*ctx));

Thinking more about it... asking for a dynamic allocation here
was not a good idea. The context can very well live on the stack
since the TFTP loop is scoped in this function. Could you please
restore the previous code? Sorry about that.

> +	if (!ctx)
> +		goto out_remove_netif;
> +
> +	ctx->done = NOT_DONE;
> +	ctx->daddr = addr;
> +	ctx->is_server = true;
> +
> +	printf("Using %s device\n", udev->name);
> +	printf("Listening for TFTP transfer on %s\n", ipaddr);
> +	printf("Load address: 0x%lx\n", ctx->daddr);
> +
> +	tftpsrv_active_ctx = ctx;
> +	err = tftp_init_server(&tftp_context);
> +	if (err != ERR_OK) {
> +		log_err("tftp_init_server err: %d\n", err);
> +		goto out_free_ctx;
> +	}
> +
> +	ctx->start_time = get_timer(0);
> +	sys_timeout(TFTPSRV_LISTEN_TIMEOUT_MS, no_request, ctx);
> +	while (!ctx->done) {
> +		net_lwip_rx(udev, netif);
> +		if (ctrlc()) {
> +			printf("\nAbort\n");
> +			ctx->done = ABORTED;
> +			break;
> +		}
> +	}
> +	sys_untimeout(no_request, ctx);
> +	sys_untimeout(transfer_timeout, ctx);
> +
> +	tftp_cleanup();
> +
> +	if (ctx->done == SUCCESS) {
> +		if (env_set_hex("fileaddr", addr)) {
> +			log_err("fileaddr not updated\n");
> +			goto out_free_ctx;
> +		}
> +		efi_set_bootdev("Net", "", ctx->fname, map_sysmem(addr, 0),
> +				ctx->size);
> +		ret = 0;
> +	}
> +
> +out_free_ctx:
> +	tftpsrv_active_ctx = NULL;
> +	free(ctx);
> +out_remove_netif:
> +	net_lwip_remove_netif(netif);
> +
> +	return ret;
> +}
> +
> +int do_tftpsrv(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
> +{
> +	int ret = CMD_RET_SUCCESS;
> +	char *end;
> +	ulong laddr;
> +	ulong addr;
> +
> +	if (!IS_ENABLED(CONFIG_CMD_TFTPSRV))
> +		return CMD_RET_FAILURE;
> +
> +	laddr = env_get_ulong("loadaddr", 16, image_load_addr);
> +
> +	switch (argc) {
> +	case 1:
> +		break;
> +	case 2:
> +		addr = hextoul(argv[1], &end);
> +		if (end == argv[1] || *end) {
> +			ret = CMD_RET_USAGE;
> +			goto out;
> +		}
> +		laddr = addr;
> +		break;
> +	default:
> +		ret = CMD_RET_USAGE;
> +		goto out;
> +	}
> +
> +	if (!laddr) {
> +		log_err("error: no load address\n");
> +		ret = CMD_RET_FAILURE;
> +		goto out;
> +	}
> +
> +	if (net_lwip_eth_start() < 0) {
> +		ret = CMD_RET_FAILURE;
> +		goto out;
> +	}
> +
> +	if (tftpsrv_loop(eth_get_dev(), laddr) < 0)
> +		ret = CMD_RET_FAILURE;
> +	else
> +		image_load_addr = laddr;
> +	eth_halt();

This should be net_lwip_eth_stop()

> +
> +out:
> +	return ret;
> +}
> +
>  int do_tftpb(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>  {
>  	int ret = CMD_RET_SUCCESS;
> diff --git a/test/py/tests/test_net.py b/test/py/tests/test_net.py
> index 27cdd73fd49..a2007c2fd3a 100644
> --- a/test/py/tests/test_net.py
> +++ b/test/py/tests/test_net.py
> @@ -59,6 +59,19 @@ For example:
>          'fnu': 'ubtest-upload.bin',
>      }
>  
> +    # Details regarding a file that may be written to U-Boot using the tftpsrv
> +    # command. This variable may be omitted or set to None if tftpsrv testing
> +    # is not possible or desired. The test uses host-side curl TFTP support to
> +    # upload a generated file to U-Boot. The optional tftpsrv_url entry may be
> +    # used when the host must use a forwarded address instead of U-Boot's
> +    # ipaddr value.
> +    env__net_tftpsrv_file = {
> +        'fn': 'ubtest-tftpsrv.bin',
> +        'addr': 0x10000000,
> +        'size': 4096,
> +        'timeout': 50000,
> +    }
> +
>      # Details regarding a file that may be read from a NFS server. This variable
>      # may be omitted or set to None if NFS testing is not possible or desired.
>      env__net_nfs_readable_file = {
> @@ -89,6 +102,8 @@ import utils
>  import uuid
>  import datetime
>  import re
> +import tempfile
> +import zlib
>  
>  net_set_up = False
>  net6_set_up = False
> @@ -460,3 +475,82 @@ def test_net_tftpput(ubman):
>  
>      output = ubman.run_command("crc32 $fileaddr $filesize")
>      assert expected_tftpb_crc in output
> +
> +
> +@pytest.mark.buildconfigspec("cmd_crc32")
> +@pytest.mark.buildconfigspec("cmd_tftpsrv")
> +@pytest.mark.requiredtool("curl")
> +def test_net_tftpsrv(ubman):
> +    """Test the tftpsrv command.
> +
> +    A file is generated on the host, uploaded to U-Boot using TFTP and then
> +    validated in U-Boot using its size and CRC32.
> +
> +    The details of the file to upload are provided by the boardenv_* file;
> +    see the comment at the beginning of this file.
> +    """
> +
> +    if not net_set_up:
> +        pytest.skip("Network not initialized")
> +
> +    f = ubman.config.env.get("env__net_tftpsrv_file", None)
> +    if not f:
> +        pytest.skip("No tftpsrv file to write")
> +
> +    curl_version = utils.run_and_log(ubman, ["curl", "--version"])
> +    if "tftp" not in curl_version.split():
> +        pytest.skip("curl does not support TFTP")
> +
> +    addr = f.get("addr", None)
> +    if not addr:
> +        addr = utils.find_ram_base(ubman)
> +
> +    timeout = f.get("timeout", ubman.p.timeout)
> +    timeout_secs = max(1, (timeout + 999) // 1000)
> +    size = f.get("size", 4096)
> +    fn = f.get("fn", "ubtest-tftpsrv.bin")
> +    url = f.get("tftpsrv_url", None)
> +    data = bytes([i % 251 for i in range(size)])
> +    crc = "%08x" % (zlib.crc32(data) & 0xffffffff)
> +
> +    ip = ubman.run_command("echo $ipaddr").strip()
> +    if not ip:
> +        pytest.skip("No U-Boot IP address")
> +    if not url:
> +        url = "tftp://%s/%s" % (ip, fn)
> +
> +    with tempfile.NamedTemporaryFile() as tmp:
> +        tmp.write(data)
> +        tmp.flush()
> +
> +        done = False
> +        with ubman.temporary_timeout(timeout):
> +            try:
> +                ubman.run_command("tftpsrv %x" % addr,
> +                                  wait_for_prompt=False)
> +                ubman.wait_for("Listening for TFTP transfer")
> +                utils.run_and_log(
> +                    ubman,
> +                    [
> +                        "curl",
> +                        "--fail",
> +                        "--max-time",
> +                        str(timeout_secs),
> +                        "--upload-file",
> +                        tmp.name,
> +                        url,
> +                    ],
> +                )
> +                ubman.wait_for("Bytes transferred = %d" % size)
> +                ubman.wait_for(ubman.prompt)
> +                done = True
> +            finally:
> +                if not done:
> +                    ubman.ctrlc()
> +                    ubman.drain_console()
> +
> +    output = ubman.run_command("echo $filesize")
> +    assert "%x" % size in output
> +
> +    output = ubman.run_command("crc32 $fileaddr $filesize")
> +    assert crc in output

