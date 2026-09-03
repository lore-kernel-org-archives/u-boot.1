Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEC6AC624D4
	for <u-boot@archiver.kernel.org>; Thu,  3 Sep 2026 08:17:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 555BA80F8B;
	Thu,  3 Sep 2026 08:17:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 22ZuzdqRqQ4L; Thu,  3 Sep 2026 08:17:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 65B208083B
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788423446;
	b=di6cSZRkDxRCJ4TLU9E7sbuK6qivjswFsftxGR6P9gpxOC6bY0Y5LL/LVd5Lyx6/g1yX
	 ztlHGceFIknGx0el6JsI/QFQZPWcUh05gLDona/y4OY7ZaADBnrpvoONZ/Kd+AiWuMoJj
	 gdlm2OAO9QsXLwPiMJuKYiqTEgjtKFHItQU6+QPsew2q/LOt28XpL6FPCUnS9aRpJpSsr
	 5Np3Xpn1ghIHZddWh5zHkc46OBanoOt/Vas2MmScJaSf6HSoUSbVv162FvFAXS10KPBY3
	 gsEQ0ZmEh1m1B6d+BF0UVq7/bq2UWqGRBDmkPPhBg819FZkHeQeRMKRtbbMwRFBGzdw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788423446;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:Content-Type:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
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
	bh=SW6k/quQtuILT4c8d0+4iv/vfpUzb43USUBlgtwX91U=;
	b=jyVF2lSnlOuGZjukrfjb9n4M5JxKU6pPU2jdmD6d2mOh6EB/Ooq2bUgKMGSRciYzinhV
	 /+puGebAazvjxZ5Qbk/QMsgQvN7pA/WRQNuA7cnUt+jqD+F+9UtE3yAQPLcus14FUcgb+
	 X7mVHEQq0UKuf5yS0tDPXCXkxg+Wn19k8puE3xBPBaBHnjYC5/q0/J24GplcUXkcTJPsc
	 DS8dDS7S0flRXfPeh7WR/ZyMb336M6Sd/tyAXnZAgm19lL0m4uYw2shJsEcO5kSw0k5O/
	 VLxRyHmEIAPab03DPewbGonxDNrMMnmiPEknH0t2erVQwmSmwWpkJjDQ4r9uemcMYhA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788423446;
	bh=SW6k/quQtuILT4c8d0+4iv/vfpUzb43USUBlgtwX91U=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=gk8lhz1yyPVDoqO77wP6JTaljKTZKC7IilBYULbjuBhuoR9qASJSyRgjxWOznKu1b
	 XXVD28ukuSnOk6V6AxDgJKA2QwCm49Enp0jdRGtmSe5w8DZiL7JbBUGGU5CYvNLzNa
	 axboIulR0lKM6dfWJl9hhzyzLuAesJM/2TSSaUBQtl4AN6pH1U4LZZdy9T3MqOzGtD
	 8HS6+uwEm6PP5Jq+bv+aaHa1sM+ID0xMd3MVcl2ZVU6D5xXDwZ4KcHdW3uRk2K5gGf
	 G3TwNoK7Z8ybbcEKWlR9PUq/ru738a/ow1TkCQmz6Y/gV3JJSVbhtJ0x5Gq21KSwf4
	 O8MUh82PP80Kg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 65B208083B;
	Thu,  3 Sep 2026 08:17:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id B931520F5
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 08:17:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9EEE040A98
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 08:17:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tVLkSQyr9iXp for <u-boot@lists.u-boot-project.org>;
 Thu,  3 Sep 2026 08:17:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 45632406E6
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20a::4"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788423441;
 b=lCG7G8D1eyCMhcAU7J4cuo85t9mHTorlObZGuaVj0gTVBY44AXX222HDyUTvZoDvS0st
 LqQVmLKj+U8+UCefZ7f7aNqmkIuh3RXVrOj/M1DnsBfgQ/2rrdcVxqjmEEfNjfj9GvFlx
 SxNgkiGF6hBCh87rwk4sdQc2cm+Qti5WxfcWaF9ehMFmzK+wM2SYtZ7vqoHC6k2BmzhSr
 zJaR0kRaJ/ACsJY8JJnuO/5J9TgzTUL3UvZ1VcU0i9odtJZfAvj6vg5gIacX4OMbZOIla
 7IaCkNN4GM7z4EtGJzINL5M67gyQ6adkiAftRj5K/V0bcP0APknbkPLoMLgsW4Kut4w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788423441;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding:X-EOPAttributedMessage:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:Content-Type:
 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-Id:
 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=SW6k/quQtuILT4c8d0+4iv/vfpUzb43USUBlgtwX91U=;
 b=j/okp91G9kvJS1eEYsQDhwQmED2S8jNIJzeKkIWlNeacx/dXgyBnVfGH/WJRnN2eN353
 cI/oEaUNhIW8G0u1pO0CYOmDeLD2uBJGw1k5OLL5cwBcheKWQPIa640DH2pFRbNGVgiv8
 QxeBE5ga9GSg/dgJ7ZDOi6vAbZ7yj37kM8Yh83Wj6PqhefqsW8ET9ML6G0b4+eDAUkBS9
 SJUBW52ptXLHjK/1vneKJ5GhgsVZcTQkhccqE8twBx+Fdqb51xDHzLUrYpQZfXuxFq5lu
 b89QeygUWUX5rQ9MdvR/I0WokRm3wL4bAUdb8DEYLd1TVOBuK/pIGCqwSelDgIs7veA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=none header.from=softathome.com; 
 dkim=pass header.d=softathome1.onmicrosoft.com
 header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-softathome1-onmicrosoft-com header.b=uD+H237E; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c20a::4"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::4;
 helo=pr0p264cu014.outbound.protection.outlook.com;
 envelope-from=philippe.reynes@softathome.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=softathome1.onmicrosoft.com
 header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-softathome1-onmicrosoft-com header.b=uD+H237E
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp170120004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::4])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 45632406E6
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 08:17:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nfhtXc/Ahvhhy9979boymmlf5JAEihPzd7GXf5veCqNuFQmEhsqnF2FbXR7WapSqU+wBTdSATHGMjXCdLa4cZATJhtZZC/J6Qt6OvFGwPuzI9Z8NpCbGXA3PV/7ynH7O7y1bXomYl+XAlQq994rXxCSBA3ZglvFkmKKVG3j2KNbnqxEUofjgZ6CBRhgR8+ozIvzAdWCoKxDxCNQ5wh6cAcQwao0UFTKw6Mj25U/D0Q75qTEXLSz6wiPvHXiO7gmQp30e9L6kGKeZ4Gw/qTi+8t/gEJnUNA6+unT+1tFyDwrO2KXJ76jLbuhcNZKG11dFREQCbecR3N3ITALQad6m2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SW6k/quQtuILT4c8d0+4iv/vfpUzb43USUBlgtwX91U=;
 b=VNEYrqtTLNw2rY0MqqmzH2rjrOvMeZV5tuYJ4Osp8xVnsE00RUgMTZNpct6sefqJsctFEacMgJZFVoOux9rRnEXtK0aVAcvjuqt0v2qbbcSfeZBImC8RdOktqTy11x1lUgOPSp42HyZB2l/xnpYgDMzAc107LxjeoP7DP49E5iJm3ARUIQea2yl6mNSNi5rWASjarW6JL8V9FIANf9kDrSkU9khbypMYYlwJ3syQA7J74IIs7DeXoajn44Bc+QcdnNvpWoz0Z57l6vpfrlLbZCef7cFLn5HFRoCwh5LCYbjbnqHvhCYXz6Zdhh5z/Dgz8LYYnfTJU22lZDvKsC+jUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=canonical.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SW6k/quQtuILT4c8d0+4iv/vfpUzb43USUBlgtwX91U=;
 b=uD+H237EwPN/ZHmcCTRQfWbUSu0dEicM/afnIeVuR+uZqFQBQzleV8SRMG7GQhwty0BVmBhLnoOHJIjz/znGqWvCMiu+7A1SVUXWH+BjSbVu0UYQfH2b2uzg5uDkPQoFsocZSExVf87U0Vf+aqf49n9TPQWx930vo+ccs1YVhrGdQ3eysh/nQr3rHzA0V+L2oj1iFGey/Qw3nMmJRzS+xxB2E3GPYAlgS07+IN6yAPHB4M88rU8x3OX1c4AzBuPEH26q3B2peF3C2GJa/yJV8Uf/3DGp5NLBGqI9Oijon5TcgY2YSQ6niRyqXke5pdWwo+PksfJxkw+86NC3A7HHdA==
Received: from MR1P264CA0212.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:56::20)
 by PAZP264MB3630.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:121::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 08:17:16 +0000
Received: from MR1PEPF00000D59.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:56:cafe::30) by MR1P264CA0212.outlook.office365.com
 (2603:10a6:501:56::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.12 via Frontend Transport; Thu, 3
 Sep 2026 08:17:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 MR1PEPF00000D59.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8
 via Frontend Transport; Thu, 3 Sep 2026 08:17:16 +0000
Received: from sah1lpt726.softathome.com (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id 1BDED2002B;
 Thu,  3 Sep 2026 10:17:16 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com, simon.glass@canonical.com
Cc: u-boot@lists.u-boot-project.org,
 Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v9 00/15] add software ecdsa support
Date: Thu,  3 Sep 2026 10:16:50 +0200
Message-ID: <20260903081705.12894-1-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MR1PEPF00000D59:EE_|PAZP264MB3630:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 639a3dbb-ac7b-4b54-4f81-08df0993c41a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|23010399003|36860700016|6133799003|18002099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: 7rRfy+i5wuiRRIJdYQtxmyb2XeD+yGyPUn3DB+izC/AWtoHMHfoRxSfpz8Yd8f2ZXNu5m4Ywn2tkk0+7Gf61qLaUzsT5j08PEsk3BCopvG6cfPbGpFYXu3t+6N1HW66TF6DKzQWfOMjtCx6KjbCXercO1mXzlzHvGpV7d61ZDP6YR3yqhipQVQPY39PUrJ7LUhKiuEvYzr7Rba9PCU+D/EQ5VAGxyuLtBi8JzYG5aSu1ojN4RwSlPc9KMzkT1uZd0jjqjlaS0r676kEvNWFLcKBy5WxrnNFfrPqTP9EP6xFTw+hrQXS4NWAGOdrs11VdLgGg59t/ISeKQFPETBWfjgAx0xgLmKe/9oyvUHcAhQRHaM9I8tGTQ5yoxW7Y1Dwyjo1xBg8vqbv3IoO+uWBK6sWQNwjrWtBQKfPcu9e9b3eDVWtEOH4qSTKaieFPoBiKH/p7s1/UKx1dz/gODxUpK6I0Dts1S5eWvAWBz85QtwRPyxq6huX/d89TiTZCBL2hXRY+yCOiMryfBldKm6lbBrWA7KY2KNKeaWDFIbzw7lH7f36LKZaI4GzNQRCVtkMegz5ZfRzPRZfGwY8IyUmPFXsfLXbPio/oDeT349H3x7BpkMxOmzLSPJ7fQc/NKM22PYFboUXz01dcE2U6NDEcVoArTnIw8MLxwXO8W9/q/XsSo+pEuNyCIaXQD0fQ9K8akgEOLvzOf0zPuUuWbkK73g==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(23010399003)(36860700016)(6133799003)(18002099003)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: T1kMYzxO28oQIQu/pC7J5FUQPUBvpfQgWuzdlcWS094nMSozgimwsgA7ZEMVQDGoKM07lzhHhGCBxvK+JbcfwXyyfHhDus7OrQVlUJUU0f56YPsv9yd1PwhRvFuNbx/g7YD/VxL7sijh5Mj96tDYLXTiQU4dDR9inr6HtuSc8XW4xkgNPXqv/UygB0aESkgPqsjkMBN2ls+idxxUAxPdl1IujV+UMBgj2xns8bL4wYbUv/4DHpI+XrrNMjPiqIFCD8L8R8RYIjE/pkQ746r7vF/alrn78+vtpt8/kHgTUcgKWFuYDVHhkWdigpHG43odopTsQlUp0lijDAkDSkei0dT4EdHvIloANZvKF0xdHJKiW+X1549+ahxcXZyzz8fAF40iLaqaF3CkxVILDi2YzBsGn0/3eiRBpyJ+xRBrXUTcexfPBtFdOGo4HZzynXxm
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 08:17:16.4115 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 639a3dbb-ac7b-4b54-4f81-08df0993c41a
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: MR1PEPF00000D59.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAZP264MB3630
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

This series adds the support of ecdsa with software
using mbedtls. So boards without ecdsa hardware may
also use signature with ecdsa.

To achieve this goal, several changes are done:
- fix the support of secp521r1
- enable support of ecdsa in mbedtls
- add software ecdsa signature check using mbedtls
- add support of ecdsa for internal fit signature
- add test for ecdsa for internal fit signature in vboot
- add support of ecdsa for pre-load signature
- add test for ecdsa for pre-load signature in vboot
- enable software ecdsa signature check in sandbox


To test this new feature, just follow those steps:

0) build u-boot using sandbox_defconfig and adding those options:

CONFIG_ECDSA_MBEDTLS=y
CONFIG_ECDSA_VERIFY_MBEDTLS=y
CONFIG_ECDSA=y
CONFIG_ECDSA_VERIFY=y

1) add a signature node to an its file
	signature-256 {
		algo = "sha256,ecdsa256";
		key-name-hint = "private-key-256";
	};

2) generate an ecdsa key
openssl ecparam -name prime256v1 -genkey -noout -out private-key-256.pem

3) create the itb file
./tools/mkimage -f <file.its> -k . -K arch/sandbox/dts/test.dtb <file.itb>

4) launch sandbox u-boot

./u-boot -d arch/sandbox/dts/test.dtb

5) on sandbox u-boot prompt, load the itb and launch bootm on it

=> host load hostfs - 1000000 uboot-ecdsa.itb
4628674 bytes read in 1 ms (4.3 GiB/s)
=> bootm 1000000
...
...
   Verifying Hash Integrity ... sha256,ecdsa256:private-key-256+ OK





Changes in v2:
- move ECDSA_MBEDTLS to MBEDTLS_LIB_X509
- rename lib/mbedtls/sw_ecdsa.c to lib/mbedtls/ecdsa.c
- enhance dependencies for ECDSA_MBEDTLS
- fix support of ecdsa521/secp521r1
- add vboot test using ecdsa

Changes in v3:
- do not use _MBEDTLS in mbedtls_def_config.h
- check returns and remove mem leak in lib/mbedtls/ecdsa.c
- remove useless field  *k in struct ecdsa_test_vector_s
- check returns in test/lib/ecdsa.c
- fix third parameter when calling sha*_csum_wd()
- add support of ecdsa in pre-load header

Changes in v4:
- change some dependencies to enable ecc
- use ECDSA_MBEDTLS to build the ecdsa driver
- support ecdsa521 and secp521r1
- add a test calling ecdsa_verify for the ecdsa class
- merge patch 10 and 11 (support ecdsa pre-load for binman and tests)
- several code cleanup

Change in v5:
- fix ecdsa 521 in the first patch (instead of the 5th patch)
- mbedtls: ecdsa is only compiled when ECDSA_MBEDTLS is enabled
- fit_image_setup_sig: required_keynode is initiazed to -1 instead of 0
- avoid hardcoded value for ecdsa sig and point size
- check pointer before using them
- free ecdsa keys when key are not found/used

Change in v6:
- fix dependencies for ecdsa
- ecdsa is no more mandatory for tls
- remove include u-boot/ecdsa.h in ecdsa-sw.c
- do not use fdt_stderror with -1
- 

Change in v7:
- change uint8_t to u8 in test/dm/ecdsa.c
- change info->required_keynode >= 0 in lib/ecdsa/ecdsa-verify.c
- set required_keynode to -1 in test/dm/ecdsa.c

Change in v8:
- check exact size of data read in dtb in function fdt_get_key
- enhance commit message to explain patch 2 (enable ecc)
- no longer use macro CHECK with goto inside macro
- some code cleanup

Change in v9:
- rebase on next
- update cover letter


Philippe Reynes (15):
  ecdsa: fix support of secp521r1
  mbedtls: enable support of ecc
  ecdsa: initial support of ecdsa using mbedtls
  test: lib: ecdsa: add initial test
  drivers: crypto: add software ecdsa support
  test: dm: ecdsa.c: clean this test as software ecdsa is now
    implemented
  test: py: vboot: prepare integration test for ecdsa
  test: vboot: add test for ecdsa
  tools: fit_image_setup_sig: set required_keynode to -1
  tools: mkimage: pre-load: add support of ecdsa
  tools: binman: pre-load: add support of ecdsa
  boot: pre-load: add support of ecdsa
  tools: preload_check_sign: add support of ecdsa
  test: py: vboot: prepare test for global signature with ecdsa
  test: py: vboot: add test for global signature with ecdsa

 boot/image-pre-load.c                         |  53 +-
 configs/sandbox_defconfig                     |   2 +
 drivers/crypto/Makefile                       |   1 +
 drivers/crypto/ecdsa/Makefile                 |   6 +
 drivers/crypto/ecdsa/ecdsa-sw.c               |  32 ++
 include/crypto/ecdsa-uclass.h                 |  15 +-
 include/crypto/internal/ecdsa.h               |  39 ++
 lib/ecdsa/Kconfig                             |   1 +
 lib/ecdsa/ecdsa-libcrypto.c                   | 104 +++-
 lib/ecdsa/ecdsa-verify.c                      |  73 ++-
 lib/fdt-libcrypto.c                           |   2 +-
 lib/mbedtls/Kconfig                           |  24 +
 lib/mbedtls/Makefile                          |  20 +-
 lib/mbedtls/ecdsa.c                           | 152 ++++++
 lib/mbedtls/mbedtls_def_config.h              |  41 +-
 test/dm/ecdsa.c                               | 107 +++-
 test/lib/Makefile                             |   1 +
 test/lib/ecdsa.c                              | 456 ++++++++++++++++++
 test/py/tests/test_fit_ecdsa.py               |   2 +-
 test/py/tests/test_vboot.py                   | 148 +++---
 .../tests/vboot/sandbox-binman-ecdsa256.dts   |  24 +
 .../tests/vboot/sandbox-binman-ecdsa384.dts   |  24 +
 .../tests/vboot/sandbox-binman-ecdsa521.dts   |  24 +
 ...pss.dts => sandbox-binman-rsa2048-pss.dts} |   0
 ...-binman.dts => sandbox-binman-rsa2048.dts} |   0
 .../vboot/sandbox-u-boot-global-ecdsa256.dts  |  27 ++
 .../vboot/sandbox-u-boot-global-ecdsa384.dts  |  27 ++
 .../vboot/sandbox-u-boot-global-ecdsa521.dts  |  27 ++
 ... => sandbox-u-boot-global-rsa2048-pss.dts} |   0
 ....dts => sandbox-u-boot-global-rsa2048.dts} |   0
 ....its => sign-configs-sha1-rsa2048-pss.its} |   0
 ...sha1.its => sign-configs-sha1-rsa2048.its} |   0
 .../vboot/sign-configs-sha256-ecdsa256.its    |  44 ++
 .../vboot/sign-configs-sha256-ecdsa384.its    |  44 ++
 .../vboot/sign-configs-sha256-ecdsa521.its    |  44 ++
 ... sign-configs-sha256-rsa2048-pss-prod.its} |   0
 ...ts => sign-configs-sha256-rsa2048-pss.its} |   0
 ...56.its => sign-configs-sha256-rsa2048.its} |   0
 ...84.its => sign-configs-sha384-rsa3072.its} |   0
 ...s.its => sign-images-sha1-rsa2048-pss.its} |   0
 ...-sha1.its => sign-images-sha1-rsa2048.its} |   0
 .../vboot/sign-images-sha256-ecdsa256.its     |  42 ++
 .../vboot/sign-images-sha256-ecdsa384.its     |  42 ++
 .../vboot/sign-images-sha256-ecdsa521.its     |  42 ++
 ...its => sign-images-sha256-rsa2048-pss.its} |   0
 ...256.its => sign-images-sha256-rsa2048.its} |   0
 ...384.its => sign-images-sha384-rsa3072.its} |   0
 tools/binman/etype/pre_load.py                |  78 ++-
 tools/binman/ftest.py                         |  50 ++
 tools/binman/test/ecdsa521.pem                |   7 +
 tools/binman/test/security/pre_load_ecdsa.dts |  22 +
 .../security/pre_load_ecdsa_invalid_algo.dts  |  22 +
 .../security/pre_load_ecdsa_invalid_key.dts   |  22 +
 .../security/pre_load_ecdsa_invalid_sha.dts   |  22 +
 tools/image-host.c                            |  93 +++-
 tools/image-sig-host.c                        |   7 +
 tools/preload_check_sign.c                    |  30 ++
 57 files changed, 1893 insertions(+), 150 deletions(-)
 create mode 100644 drivers/crypto/ecdsa/Makefile
 create mode 100644 drivers/crypto/ecdsa/ecdsa-sw.c
 create mode 100644 include/crypto/internal/ecdsa.h
 create mode 100644 lib/mbedtls/ecdsa.c
 create mode 100644 test/lib/ecdsa.c
 create mode 100644 test/py/tests/vboot/sandbox-binman-ecdsa256.dts
 create mode 100644 test/py/tests/vboot/sandbox-binman-ecdsa384.dts
 create mode 100644 test/py/tests/vboot/sandbox-binman-ecdsa521.dts
 rename test/py/tests/vboot/{sandbox-binman-pss.dts => sandbox-binman-rsa2048-pss.dts} (100%)
 rename test/py/tests/vboot/{sandbox-binman.dts => sandbox-binman-rsa2048.dts} (100%)
 create mode 100644 test/py/tests/vboot/sandbox-u-boot-global-ecdsa256.dts
 create mode 100644 test/py/tests/vboot/sandbox-u-boot-global-ecdsa384.dts
 create mode 100644 test/py/tests/vboot/sandbox-u-boot-global-ecdsa521.dts
 rename test/py/tests/vboot/{sandbox-u-boot-global-pss.dts => sandbox-u-boot-global-rsa2048-pss.dts} (100%)
 rename test/py/tests/vboot/{sandbox-u-boot-global.dts => sandbox-u-boot-global-rsa2048.dts} (100%)
 rename test/py/tests/vboot/{sign-configs-sha1-pss.its => sign-configs-sha1-rsa2048-pss.its} (100%)
 rename test/py/tests/vboot/{sign-configs-sha1.its => sign-configs-sha1-rsa2048.its} (100%)
 create mode 100644 test/py/tests/vboot/sign-configs-sha256-ecdsa256.its
 create mode 100644 test/py/tests/vboot/sign-configs-sha256-ecdsa384.its
 create mode 100644 test/py/tests/vboot/sign-configs-sha256-ecdsa521.its
 rename test/py/tests/vboot/{sign-configs-sha256-pss-prod.its => sign-configs-sha256-rsa2048-pss-prod.its} (100%)
 rename test/py/tests/vboot/{sign-configs-sha256-pss.its => sign-configs-sha256-rsa2048-pss.its} (100%)
 rename test/py/tests/vboot/{sign-configs-sha256.its => sign-configs-sha256-rsa2048.its} (100%)
 rename test/py/tests/vboot/{sign-configs-sha384.its => sign-configs-sha384-rsa3072.its} (100%)
 rename test/py/tests/vboot/{sign-images-sha1-pss.its => sign-images-sha1-rsa2048-pss.its} (100%)
 rename test/py/tests/vboot/{sign-images-sha1.its => sign-images-sha1-rsa2048.its} (100%)
 create mode 100644 test/py/tests/vboot/sign-images-sha256-ecdsa256.its
 create mode 100644 test/py/tests/vboot/sign-images-sha256-ecdsa384.its
 create mode 100644 test/py/tests/vboot/sign-images-sha256-ecdsa521.its
 rename test/py/tests/vboot/{sign-images-sha256-pss.its => sign-images-sha256-rsa2048-pss.its} (100%)
 rename test/py/tests/vboot/{sign-images-sha256.its => sign-images-sha256-rsa2048.its} (100%)
 rename test/py/tests/vboot/{sign-images-sha384.its => sign-images-sha384-rsa3072.its} (100%)
 create mode 100644 tools/binman/test/ecdsa521.pem
 create mode 100644 tools/binman/test/security/pre_load_ecdsa.dts
 create mode 100644 tools/binman/test/security/pre_load_ecdsa_invalid_algo.dts
 create mode 100644 tools/binman/test/security/pre_load_ecdsa_invalid_key.dts
 create mode 100644 tools/binman/test/security/pre_load_ecdsa_invalid_sha.dts

-- 
2.43.0

