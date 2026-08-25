Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBCC0C61DB9
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 13:30:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 117EC606B4;
	Tue, 25 Aug 2026 13:30:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MpGDarM24zyr; Tue, 25 Aug 2026 13:30:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787664601;
	bh=3ZsODAWbJTbkoguM77n4dZNCtUQLPZUouR80b00NXd8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Y4xax9zoVx+cI5WQ2s2hSqMN5ZlJHjrLrhGwH2HpaOObLOG3FPcpMJk5oUAFKjXKw
	 S9O3udZFoVVkpLkpeoj2W7uv4rj+Y/OCmGiLK1nSZ7Yipdkdniy9eLJqPNWgrZX8L0
	 6mb8fmL82tRbpaM6aCpZpTCWkCnHPK3h5EtZYzvN3psjkYQUG8i14abLXwe9GlTR91
	 Sue4nDAiUSnQ/4+0uF6sQtWuYOGfhZBKjkpJwRhVCycjslVq8+hgKvSPQSvHmXb++E
	 nDQTL1aEpx6ogahKCf2bEtzVoniExVeyHiS6dlLk/56itOkN2cga6uh3CimlkkC9tY
	 K6z+IGYL6wE7g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CB75F606B3;
	Tue, 25 Aug 2026 13:30:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id C0FC8230
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 13:29:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B283640248
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 13:29:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Iie1OulgaXQU for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 13:29:58 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=Dhi+qBwW; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=Dhi+qBwW
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 438A740208
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 13:29:56 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=wTWuxW/689eGds4euGNvlXp42G9/p+mVhy4wHc8NQkEBhZTOsdNAB2+QSsycn9lBGDqHY522rQKlsC14G9xbAvHyplT2+WNYPulZBnqrO/VK12ZWRcRQPck5Y959HcAjGqClvrvBw2AY5A3xNi+pw569slyGnpaY6yNOR0FnfxDi4Np987N6piV0bCwpR5NWBHmQ2zjj+1py5Sqm81bivU7An5Jdth06xvXsCCf+N3gvuBO2qaJiQXHCnC+FVuRKyg+uP01gZ91pAD34UZik6ijrQribmUD19/zZgGN4SUU6qtspeNMBDm9bYVuhseHlKwdy4HgatTFvw6yc35+drQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ZsODAWbJTbkoguM77n4dZNCtUQLPZUouR80b00NXd8=;
 b=lN4j22PX+NnXViN5CTkvxQfryUmusyLccmQc/bqG0UPOJEcdxrB0/ukJPWsI5OpKxlnVbc7Cxt1+KzW2PQeuOVXmNlaKqpmD0uqor7mIEJyS9LVyBpYro5JpVvCIG27Q0K5A96u3KjKw81CEeQyuIq5zPpgNsORFW47/B+E2EsFjpcIjBud7Cp4cJizjHESgAfevwbDu2IzutPlyQIoUnj9uck1zayvddclg4LsTJxu/A3KQ27T+0BRitQhHBRrJUjJ0vGZiuqLRmMjUofVCWQFnJhfV2a3jHogklafy/7DWQN5bNOkS5AX6KQqvTJybB7HFwgAmUNLIE7IE486UiQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=byteray.co.uk smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ZsODAWbJTbkoguM77n4dZNCtUQLPZUouR80b00NXd8=;
 b=Dhi+qBwWoCyzzaE2Z4zr7AY1FrypR0exXFYDuFsG09tjsDL7cJyvpoYYkG7eLNxfcsBOBfQEjeLEKpezaAQ+au1mNY9CSgO9iBwpFHV2tY9T3OQ3TOz3f89vg8cIPvXo5/btmqk4B3NHRJjOUj9LgWH5cL5yadCyGIdbZzj//gs=
Received: from DU2PR04CA0089.eurprd04.prod.outlook.com (2603:10a6:10:232::34)
 by PAWPR08MB11456.eurprd08.prod.outlook.com (2603:10a6:102:50c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 13:29:51 +0000
Received: from DU2PEPF00028D03.eurprd03.prod.outlook.com
 (2603:10a6:10:232:cafe::3d) by DU2PR04CA0089.outlook.office365.com
 (2603:10a6:10:232::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Tue,
 25 Aug 2026 13:29:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF00028D03.mail.protection.outlook.com (10.167.242.187) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.3
 via Frontend Transport; Tue, 25 Aug 2026 13:29:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xUfqT0tfrAlpugCydJksgm2Qr5KD/5Kz7APVTYrwzcivc0WUMtC0jt5ErqtckCaZIlt6cN8R6miU0A0hOEGwokZ+ISQqOkeXFV8THAh42M5ICzY11ohCMXFdZcGiIAw3pj+H9PV7Q+z3vxbRRwJJkqOau+Filjb8OzprIUSWLTMAixUWRYUKVFte3HA4Bhb+rQA+aYSaYnwDL/hvgTn8mtkpxpbT9q/VZuH39GNZaATci2GHNIBj0wHXD514elU7oH1tjYLTRXWr/jTphVvF8Qq7UoIsdNnKk21CKwrY6AttPQ1V8uyqoRG1DSjOYxYaBWwu5Qzo3QI1n42O4DpPrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ZsODAWbJTbkoguM77n4dZNCtUQLPZUouR80b00NXd8=;
 b=Qiv1QyP0hWwkPjmeikI5ZsQkUu8t32FLZFwgRl7HmGT0m/fsx7xw8SwoELI0EbifkOREAqeTTFmkJ9D1hQnaTV1MKKEpMtYFa640svRGRs2Ilfs6LrDqbMAt76IJ9Kye8I/D+fif26sHcGvZwcl926nP4Bt3mjn2MH2ozgNtEJXZFIj8za42isZ7UY9IG9AdOkNB1KeJgIDGZT9lvx5Qn+DRHHDxhqhKQuxWLjYiJOdpNynLfUNw89AgWL73tZC5j4Ha1GPLdYzqqpIJB8wMUXM1asZd7H7GKlX0/NoW+q9EvgxM6xAuzdDJgqH2LzyqQ+B27fgwae0KdKjbQXs1MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ZsODAWbJTbkoguM77n4dZNCtUQLPZUouR80b00NXd8=;
 b=Dhi+qBwWoCyzzaE2Z4zr7AY1FrypR0exXFYDuFsG09tjsDL7cJyvpoYYkG7eLNxfcsBOBfQEjeLEKpezaAQ+au1mNY9CSgO9iBwpFHV2tY9T3OQ3TOz3f89vg8cIPvXo5/btmqk4B3NHRJjOUj9LgWH5cL5yadCyGIdbZzj//gs=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by DB4PR08MB9141.eurprd08.prod.outlook.com
 (2603:10a6:10:3ff::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Tue, 25 Aug
 2026 13:29:14 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%3]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 13:29:14 +0000
Message-ID: <ce317b2a-712d-44ba-87ec-596d79bf96d1@arm.com>
Date: Tue, 25 Aug 2026 15:29:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] net: nfs: bound server-supplied lengths in READ
 and READLINK replies
To: Shahriyar Jalayeri <shahriyar@byteray.co.uk>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Sebastian Josue Alba Vives <sebasjosue84@gmail.com>,
 Argus <argus@byteray.co.uk>, nd <nd@arm.com>
References: <20260819-nfs-oob-fix-v3-0-7f8158088b80@byteray.co.uk>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20260819-nfs-oob-fix-v3-0-7f8158088b80@byteray.co.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0470.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::7) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|DB4PR08MB9141:EE_|DU2PEPF00028D03:EE_|PAWPR08MB11456:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dbc2260-904f-4cd2-dc79-08df02acf09b
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|22082099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info-Original: NZd/t1/bStWA7h2+QnOr1Rj33yTCcmaFrF83UnCD/dfghz9vQgk60msk+ugHOjulneP3pPg+gUnDYFL8vt7+2zZ2gsugEVqO/cG1bHOwxVPEGEhkjmAyhA6XhjeMh50kaPhFT1cZ8D6y6xMREQ1y32pvnBu9o7FRuUwWez0VLamfNIbVJL8eZh48Hy1ICbELkprf4Y5WUc2OAOFm1ztE4SvfLaZ3P+R2Vlui5siu/wDSr9B4XPNBtQOPa2cGSLhMysJq6QlTXxBr5yxEh1ifb6OBXhikFIqAilm9dHiProy+1ZvXlyZjzqDk0ONCoWAuN5HvkKja4L45mf7xAaVuJbSF3RMAS79k3NDOhjnoagtKuJdCG34ucaAkBee1MOpuij/x0UfD9txVrkcZiI+NsMqc7KxGrl3YS7V/ARHu3y26lF+IkpfxlpRmCTL+uhe43BTSLyjRT/SjSdfwgm/FH2RplJakVVlePPbGgl/ra6raRpT5P/KYDwMg90HXcY3E5yltbQvdQiSkJPZKt14cPLYCfjz923IqICEMS2MY9WgL1nwz//a0VH6GW0KeTm7hfhRd4y7c2SIOGn8Czon0NNhTqhIi4BuTXDkjYLoZ1oiuTrAfPsNe+SJolMc2K6GqWBsXWRT/yH5eaUPdOuxGUaQxCw+YrDYSrqn850APnRo=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: zI4NNBniePrdH967kIH5sr7xXjmxUnA8daHB1c7QR/DMg0ALQmgx8NTBI3sKyRWZUgf5fWBNAY7qyQT5ICwUza3M5vRHJ2Gz5v9y54zmlJzpPKIy6Nu/ay3QRiuGDpbzuRmYb3hAyX5QoSWlzmiJfLeVxWy1rJzSEVe8I2qrQNgh4mn3UVmrBv91S6xL8hdRoRBB0grcCyAtKVBQdUMvvWEmE1ANcaIIyiesr2SMuVv6LU08mCKQCsSuvbleVUJK87tvYCuJRQ0juFqty3Tp4fAuDEx9lTZiBJm/FbVhDYJr9InxHNpTwajeby/kir/Y+ORdrfJk/oK+iE0L9k/9Ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB9141
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU2PEPF00028D03.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: c8226876-ca77-4a3f-8868-08df02acdb34
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|23010399003|1800799024|14060799003|35042699022|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: HxzOsQbvnhN1+XT7f8WTANTn4eHGy04CTGHKOiWsOBqSoeUIR/MoHprZgtmS3OB9bM0rtkBym6jSQeFEkpxZX4wAI4XIZlkIEL68BDKdiagXK0gk1M6D/M0u2fCTX0WDmMgvKOIy2cijbd0cj1128rLTDWzOa8Tt7s3T2dNp39a9ZyiL0QvGeQEBaT86+Fue7jTfYwqBDJmV/OmRX4Ytshs3072a40uV27iEi+lTINFRdmatHn34R6rsBmXOx/dx/KeJDzz8+sppFZJo7UCdt5rb/KXNiajdlpHIirJcHnyNP8g0JmdbucqnarM5CZQ3CJgt/JN7jroaT90mjYNYGtKvSWmLkdGaLh2cIl7srqVox8bkLB5PDEvLJydaISLE/hsvzEsff8yoT9P2eezzFr//dkw3X7MjP+YHUeU3ctrrhDe3JnN5w1w/zo+cf2syx3tlyQy8qrXsUBejTgOV6HkgMLNcBcJo6/r+TfTeQeW5hW+zGbTSjgoFS95GH7Siw3ILtXNuPNdsrLGTdetO3rUC4qs/ypMiDnubnC1wRmiDPavRbG/OGk9keNGsm9e7em6jwzVMRhJxlGegmSYylfNWtUoqj784W4F6SPMzb+qi6+LFFXGvmjKTi/IbJD0Omfk32NbzxdRV7ReoxDtizWgrgaB5S8F/DIyKC4UDCOzdsKGsbSjiQlGJWDBkIZTW9DuuGe9oYtcvOXiELGlYfw==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(23010399003)(1800799024)(14060799003)(35042699022)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: D3BtL9J5/paLuIq43gTGmNUgg9LfaxYVuCkSKKTG5sGfOcFoqag8rWqfBfVwua+uPMscMElNt+TC2Nc70uVCYc1jB83qsjqiunINx/uUxdrkxkh0a5lOZoAtTzWVWG8Lnmgh3p7jmvynCSYGsW6yyevbQKYd+fZeuqlPzePDtOj058Fh/SIQ2VsWGYyIDd9GIkzsVfSArC8gvxRq9UU1Q9zLHzWCuJGYuVesdUAIBVX9q1ZNaZiVuB0WrIr1zofDQGCKhtadiN7EgIVB9eQqJ343n4m1nf92n1lfUqVr28TGjOT0/RYhnQV9CIZWkliIh+leyT+Urm9cRRCFyCnRHZs5FbZcQkxwRCG+PnJ/taprXuuFgjzIbey+G+wYmOxRJ1tdWSqRu63hF5sLx3EX0xfN+0G0AtpDySn+RRsmXAavQpSqHNr1cCb84y1wzq+g
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 13:29:50.3254 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dbc2260-904f-4cd2-dc79-08df02acf09b
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D03.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB11456
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

Hi Shahriyar,

On 19/08/2026 18:40, Shahriyar Jalayeri wrote:
> A malicious NFS server can return replies whose 32-bit lengths are crafted
> to defeat the client's bounds checks.
> 
> nfs_read_reply() keeps the READ length in a signed int. On LP64 a value
> with the top bit set is negative, the bounds check passes, and
> store_block() then hands a ~2 GB length to memcpy(), which reads past the
> 1152-byte reply buffer on the stack and writes past image_load_addr.
> 
> nfs_readlink_reply() has the same signed-length flaw. A length of -1 slips
> past the destination bound as pathlen - 1 and drives a memcpy() off
> nfs_path_buff. The bound is also measured from the reply header rather than
> from the symlink data, so a large positive length reads a few bytes past
> the received reply. A server reaches this handler by answering the READ
> with an ISDIR status, which moves the client into the readlink state.
> 
> Both handlers are shared by the classic and lwIP NFS clients through
> nfs_pkt_recv().
> 
> Patch 1 makes the READ length unsigned and bounds it against the received
> packet and NFS_READ_SIZE. Patch 2 does the same for the readlink length
> and its destination bound. Patch 3 enables CONFIG_CMD_NFS in the sandbox
> config and adds DM regression tests that drive nfs_pkt_recv() with crafted
> replies.
> 
> A reproducer is available on request.
> 
> Signed-off-by: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
> ---
> Changes in v3, all following Jerome Forissier's review:
> - nfs_read_reply() and nfs_readlink_reply(): keep the server-supplied
>   length in an unsigned int and bound it against the received packet with
>   the subtraction ordered so it cannot wrap, dropping the explicit
>   negative check.
> - nfs_read_reply(): take the NFSv3 length from the opaque data_size field
>   that prefixes the returned bytes.
> - test: also set the data length field that nfs_read_reply() now reads.
> 
> Changes in v2:
> - Add a fix for the same signed-length flaw in nfs_readlink_reply(),
>   rejecting a negative length and measuring the bound from the symlink
>   data.
> - Enable CONFIG_CMD_NFS in sandbox_defconfig so the regression tests are
>   built and run under sandbox; the v1 test was skipped in CI.
> - Add a readlink regression test alongside the read one.
> 
> ---
> Shahriyar Jalayeri (3):
>       net: nfs: bound the length of an NFS read reply
>       net: nfs: bound the length of an NFS readlink reply
>       test: dm: nfs: add regression tests for the NFS reply-length checks
> 
>  configs/sandbox_defconfig |  1 +
>  net/nfs-common.c          | 32 ++++++++++-------
>  test/dm/Makefile          |  1 +
>  test/dm/nfs.c             | 91 +++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 113 insertions(+), 12 deletions(-)
> ---
> base-commit: baa64b2f892890f00a377eac4a3e685472bb56b5
> change-id: 20260811-nfs-oob-fix-31c433a22c91
> 
> Best regards,
> --  
> Shahriyar Jalayeri <shahriyar@byteray.co.uk>

Thanks for the update. This looks good. For the series:

Reviewed-by: Jerome Forissier <jerome.forissier@arm.com>

Regards,
-- 
Jerome
