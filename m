Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AEDCCD4851
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 09:23:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54D6F8465A;
	Tue, 19 May 2026 11:23:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="a3sbzwsh";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="a3sbzwsh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F6F58467A; Tue, 19 May 2026 11:23:55 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD2D7843B6
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 11:23:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jerome.Forissier@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=nJNz5urn5Oaz2gtn84VID/RabkxZ/cFL16fjSOXTWGdi/2dkxee8AleiHRA8IU33CMfnDWA2w8PpeG8JGmCjwUMGrWl4J9gXo2Mie/qgIyX6kGB/5SO2BF9aKiUp3ypFhQnkz+tZ3K4ieF5qioX03Nv7AgLSTI3Sa7per5WUiPd6uXOUe9Qg1mpjW4mluFYhJJrmc08BffWa+alS3yqhjE7aBqOKdKBJ0SuB8+VYFpkJuyM/KU9cttcM5UEdaqykRpegn5pokE8iqz7C2D6UHjBIBRuwHHS5Yf8tzaTtaVswsHO0qp3rCbIL+rLE6tjEifMReRh5Vk/ySuMEF9IfEQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+NUXuAxJoE5vWKxgGk0Ylc5NTxvqk0FUlqANArbx3P4=;
 b=fMJYFH0VYQ1u5nKWduVha2uGxv0Bv1K8S6Dm0qQr2loQQgWq33VVqtQITJ5zWcno1ao0srZAv9lifIDVKRBSITszU7EYrzFYjT/lz3Ii3DMs4FjUDt2vWTt4aY4+YAx5uizy1XlywO7y7LvtpHX0j3gsPxYA+JykFRpK8AWmoM1ILaHIG8Wr36slYbEf1pH6Sp1/fxV42tY+Oo7pbOSxEWCWR/6DYDf104DBbBmRUdqUxGN5E+DvtX3jVsBWcKS7tmhvT6LJTZA7VLoyz3n34gmnXa6TFMUH9ZEFOSK47D7rF1SDGLeyqNPqL8O5MkTELWEzv9t2Ki/PBf/LN3Vpzg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=0leil.net smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+NUXuAxJoE5vWKxgGk0Ylc5NTxvqk0FUlqANArbx3P4=;
 b=a3sbzwshOG1wSUUkosG8U9aY+krTRkCDfMTEfSmFRlsJlmhF0nWvhw3UriRZmu5ng+3UPdiYTWYo5Qv2NrYV7Ac9Q6jg8CSlCChey2UF/aNBI+KQP4Mvv4aXKBUaWxbSDmM40+qxb9VwOVodWM4RwOLwmIFHqAwZZmB9kOhRCUQ=
Received: from DUZPR01CA0056.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::7) by DBBPR08MB6172.eurprd08.prod.outlook.com
 (2603:10a6:10:1f4::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 09:23:47 +0000
Received: from DB1PEPF000509F0.eurprd03.prod.outlook.com
 (2603:10a6:10:469:cafe::a3) by DUZPR01CA0056.outlook.office365.com
 (2603:10a6:10:469::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via Frontend Transport; Tue, 19
 May 2026 09:23:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509F0.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.13
 via Frontend Transport; Tue, 19 May 2026 09:23:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q6AbUM5DLIRioslY4QT4y2o6aDU+1E4n6bqWXMpEpbiMZVQs1hzmrIqDweabajeTlzWO8RxExpPxz7ZH+yd+352sepKFDVGpiGbgZHCcWSccII2pFX3IKH/ZnYMcgnDATAxhFU0uFUS6e+c97jR4T5lCnXmjEpDZSpmSnnJb/xlM2ZQmJz4yehx/0SwZAo4Jrsj55LcrOoLOqeCQDCUKByfXelqN4+lFIgsOMQQeh0kk+h4otFnCkGHQtGcnkqIrJAWrjw5cQdDYPBDHy8LOBBeOqeugmAZcvcOT+ofRkZU9Uv9QJwrwGCrmajo2FuAWvMZKGaTUa72Ft2VIIbb+GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+NUXuAxJoE5vWKxgGk0Ylc5NTxvqk0FUlqANArbx3P4=;
 b=e34Rj5c4H6yTV3plXe2W80N66GwedrDBXg5loZQ4LHW5KYaMY5Q7N2Iv7qskPuvHu5AFTUkbbrepTjR3qXNAU/ibHpUFvySLYf81EYWMPVoZNDtS2Eu2hbEGWGjURTUX33p+VwQWsirt/UwPpuxIAaU4lkSeO9bGZGbcePqhjMsUyeBqGmEtk4uVyWMSY6FFlNoZBEr9rNAUAOGR4Vo7PP3G5Vd6qzS/mWC9McUj77J+tjbiyCxQ5rSZseL920FFzENcjWi+FOJrKwbj0alHoW6DN9cClO9IGLdncjUN3ZV8KQ94J7d3mmZ6DRwuTtqeA1LFkb/5R/9l21hqqq4w7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+NUXuAxJoE5vWKxgGk0Ylc5NTxvqk0FUlqANArbx3P4=;
 b=a3sbzwshOG1wSUUkosG8U9aY+krTRkCDfMTEfSmFRlsJlmhF0nWvhw3UriRZmu5ng+3UPdiYTWYo5Qv2NrYV7Ac9Q6jg8CSlCChey2UF/aNBI+KQP4Mvv4aXKBUaWxbSDmM40+qxb9VwOVodWM4RwOLwmIFHqAwZZmB9kOhRCUQ=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by AS2PR08MB9894.eurprd08.prod.outlook.com
 (2603:10a6:20b:5fc::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 09:22:43 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%3]) with mapi id 15.21.0025.020; Tue, 19 May 2026
 09:22:43 +0000
Message-ID: <2ae23910-e4a4-4b73-8475-01193e632dfa@arm.com>
Date: Tue, 19 May 2026 11:22:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC next v2 0/5] net: guard SYS_RX_ETH_BUFFER with NET +
 required changes (ls1028a!) to make this happen
To: Quentin Schulz <foss+uboot@0leil.net>, u-boot@lists.denx.de
Cc: Tang Yuantian <andy.tang@nxp.com>, Tom Rini <trini@konsulko.com>,
 Fabio Estevam <festevam@gmail.com>, Alice Guo <alice.guo@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Benjamin Hahn <B.Hahn@phytec.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, =?UTF-8?Q?Alvin_=C5=A0iprag?=
 =?UTF-8?Q?a?= <alvin@pqrs.dk>, Quentin Schulz <quentin.schulz@cherry.de>,
 nd@arm.com
References: <20260507-sys_rx_eth_buffer-no-net-v2-0-cd7ef934bf42@cherry.de>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20260507-sys_rx_eth_buffer-no-net-v2-0-cd7ef934bf42@cherry.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR1P264CA0125.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2cd::12) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|AS2PR08MB9894:EE_|DB1PEPF000509F0:EE_|DBBPR08MB6172:EE_
X-MS-Office365-Filtering-Correlation-Id: fc71a69e-877f-487e-8e4b-08deb58854b6
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|11063799006|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info-Original: Xdg79oaLOXbzepWCVWe0cvjhXO0/GNT+n7DLtmywnLgNEZNvjoL9s0ndFjHmW7hm1TBXSbIVBT0jZlCYdl9fnAiMMl6yz0OCFdKwzaA3duEp+C1KTbI/U5pybGq9E1ON6OAbsI1n471P9mdmBU+IpFnbgQBkUZJ5K8zubAsbIL/gS1wx8b3y9KQSQGUlyY04r/4x0vRiEea1SBOgKd1soHs8+I6fTdz6At7PCVuwyM7Bgnza9L12nJD/aF/4C/v7shSoQ5Y1yKXQP7anun+O0/5Ka4o6mjVtEBdk/ez48EEA2MFD0YGJrHl7L59jUSSXUcb4WEJeE6DYczpfhJOzFwF8CbwfraQUvZLp6Q1IvNL8qNwDBQjqPsakF9vl9Apv1MMF2Bisw7AbXPMYy1GS10m2N+PU7oytynzDj3IFLGlLXR56ngha0Z1ZW7pWOErZE6y8Z3qD7Z091dAUFZRJkUKiM1k0nMszzy6YJmr2rmdUPGF8cm+QZkqAbyqRYkwoDOfsOuSVlXPaB9pj34TjD0CRJrJRr6qROIiABnT/na2kpta4K5faWX45RmlkOhmbF1kpDd+lPCcX6C5P/w0RCkm+gRbNHrp5hIcuWj8AOW+E3JUy82uGZK42xmU5uV4Q8FCZZ3NVH4RUGNf0t1Oyug==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(11063799006)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: ZbTlGU/cqKzbR4QpiT1RTjXzme2yKCpHT+0/WnqF8nfbIc2AC8vIv2WfxVIfH3n3qYQZ11aNW6z6bUnJ5iBDlWL+mT7DkHIjXB+dR4Gqrp15TvqNlhs4aZm2NYymRh94CXtOqBmV4im2yJIuhcacjvsVehGDaPoPWO+V9rA7ZlIlf6nQuLPXiC5JmoqmsPIWIF82iyzByCVPDus5Lmt4QgeprWCWkSZxkKXRHjNk/g0aN4RCzS//PpV450++dRyomp/Zi81M7dOJ6ViMhTb7pwbgv/ytLJ1p95ZXyPfIgDKh+rhp1Xxn9xRlxLPhEo2oobovvAK120Uu4JDiU3JOWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9894
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB1PEPF000509F0.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: b8fb95f0-6b7b-4a7e-6fd3-08deb5882e6d
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|35042699022|376014|36860700016|82310400026|14060799003|13003099007|22082099003|18002099003|56012099003|11063799006;
X-Microsoft-Antispam-Message-Info: HgJkcN8s7Wp+exEEwu5qUizd8CCkDOY+Pwgt69Wyz52QE7kYAuiARQokERNSwoQsx+gZJEKXWmIauy9b1FMNYGypKdFKmeM40zRKlIje7pqaLCgqcf796aZ8foGpEt4IkYOWIzCdDJZiSgu5Y740qfPLWS8LrSjDUBVLKYx5KoZTnteqahCgAJZwNCwimRsFOKnErfyEYL6zubXwIORpA07zfC5wqk6zADWQcIMQRbKSIGI89PBhk03ce4hbdbcz8PYO51O04V52NRPHVD3gZefEk0w/kFNrDq6ZMj19u7HWeg/yb4uzfCZ6DTzYjP6n0/SmRrFtUThtXnHG7sh3S+ZDySaiPAjfuys4RHFc7/7wuf66z0eoGvlhiuQUP/KhaKz14oMca0qnWaRj4V27bW1zRoKtJX8UeWd6k4sA/XZlP+WYSiJwfBme+kn/UeTTTGV1f7fiJxm5KUI6LdLpzi6+Tbad5jPqOjzdVZ8A7cFCWzCLvhffTPuCRA/KbEfgNN6kr19KrmNI5fKq+oMTslFLpuGFTGAWjoya1cNR+pOYThxC65F0N5FMhFalexo5HhtHTLFoGrOLXn2ZlneHVI7TOgYMa3DIEn7hoZGU0W7hcaqaHufkM+Eh8JH1DIOyNFqpBD/4C2Lab+VnInj7kMrGrccafegM13ruA42s7ZA0QrsVEGXSpSV1Yg9LPvbJ
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(35042699022)(376014)(36860700016)(82310400026)(14060799003)(13003099007)(22082099003)(18002099003)(56012099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7FnaHmJXxOfKOICW5RO7APXx76lBvSSmivyowgg156wcSp3qPLhGOaAJalGepB/oNf0TduZfBnkS2zQd2w2YlREYITu4btkt62KGal+9uZqpP5vn8McyzB6jnZ6j4J6+JOak7SmKWrfaw73a/OFNEW0lIds2BOQdo785Iyc9y7i0ekAX4hmg186ngaTnUsXk1vkNsBsDm6rtC6qHHEVAb5aJkCUpCL1Ggde4i8fV/5raJ8jwm6yYF5n7Pc47IU6oO1+ImyNNcDbzs3zsijuC9V4RbS1GE4XhIKyQcjmMSEA8yu70BA5JzUBvl9kA2hmrKECDIHSuASm5iABaf5LHy52IlaA3EQdJgIQwc7zM3jlcDv1W+NP1rQ0eCb4ybizPEzp+QyTquOw3mkHoPuIVMG7EepSNC/geQKfCfzAB29Qsq9G5OTMvCwUMgAQNlaeG
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 09:23:47.3550 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc71a69e-877f-487e-8e4b-08deb58854b6
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509F0.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB6172
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

On 07/05/2026 12:37, Quentin Schulz wrote:
> Adding ls1028a to the mail subject so that maybe it triggers some filter
> for maintainers/reviewers of those boards.
> 
> Follow-up to the NET->NET_LEGACY rename, where CONFIG_SYS_RX_ETH_BUFFER
> was discovered[1] to be in net/Kconfig but not guarded by NET.
> 
> Move a few things around such that we can guard this symbol by NET.
> 
> It'd be nice if someone could check patch 2 works as intended on the
> impacted platform(s), hence the RFC (and the ls1028a! in the mail
> subject).
> 
> CI passed here: https://source.denx.de/u-boot/contributors/qschulz/u-boot/-/pipelines/29934
> 
> [1] https://lore.kernel.org/u-boot/3462e9ac-e882-4145-88d2-a553cd1c3cb2@cherry.de/
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
> Changes in v2:
> - added Rb from Simon,
> - reindented SYS_RX_ETH_BUFFER to start with a tab instead of spaces,
> - added multiple-of-8 limitation for FSL_ENETC nin the help text,
> 
> - Link to v1: https://patch.msgid.link/20260429-sys_rx_eth_buffer-no-net-v1-0-396ef37ae93c@cherry.de
> 
> ---
> Quentin Schulz (5):
>       ls1028a: only include drivers/net/fsl_enetc.h when driver is compiled
>       arm: ls102xa: use platform data to check Ethernet interface is not SGMII
>       net: tsec: make tsec_private a private structure
>       net: guard SYS_RX_ETH_BUFFER with NET
>       net: SYS_RX_ETH_BUFFER defaults to 8 when CONFIG_FSL_ENETC=y
> 
>  arch/arm/cpu/armv7/ls102xa/fdt.c |  7 +++----
>  board/nxp/ls1028a/ls1028a.c      |  2 ++
>  drivers/net/tsec.c               | 17 +++++++++++++++++
>  include/net-common.h             |  4 ++++
>  include/tsec.h                   | 17 -----------------
>  net/Kconfig                      | 21 ++++++++++++---------
>  6 files changed, 38 insertions(+), 30 deletions(-)
> ---
> base-commit: 3cdd19089f1b1b7cd08530f33ff4708abcfd426c
> change-id: 20260428-sys_rx_eth_buffer-no-net-0ac1fd2004fa
> 
> Best regards,
> --  
> Quentin Schulz <quentin.schulz@cherry.de>
> 

Series added to net-next, thanks!

Regards,
-- 
Jerome
