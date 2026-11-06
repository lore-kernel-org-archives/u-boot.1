Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DD8606A326
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 18:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=q+Ia7xiV;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=g+4efF7y;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=g+4efF7y
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 84D30806BA;
	Fri,  6 Nov 2026 18:07:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sEHW3GVqr-VZ; Fri,  6 Nov 2026 18:07:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A188881359
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793988432;
	b=SKlBoGYzDxHeFzWruqX4dgBiYLEaHDpiAm0/E7LjvthPrmqSezQTDHgUuayWOvcS2uOZ
	 zpyLYATx8bgnQY/ux4/JrY8vCGFVNnBNQsR2vwRaYMVzIWqKARD+EFuHuINpVeYL+YVQ4
	 FUw1CtGHrDVNhtcUW9k0YlUiD/JLkVE5Ke45cwXSWixXqDIcr0oWZ9Xj69ihSHlQn41fx
	 reDg+buXksj7fcBD26WetFSM4rCqKgmAX9AzVFjfEC0L7Ad9A4N+Lb1ucRDoqP2BZ7qOq
	 i5ehXE9qbGieLPnc3NZNgALG67XEQ2tARPDm/RsSr7sv0WFbt31FYpoIbf5cUN65tBw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793988432;
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
	bh=IorsO8tG+Fkj9gLzBEehrtNPfbvy7a40WImX0ozmol0=;
	b=e2la/LgOIm2H28g84rT3tFWuJhcuKx/utslz6ZAWjhFSjqzS5TygmQR5Ik2ilozNghAD
	 cRB55RQQMkyKDkA17K6kVRBSBnvmKT3B3YpaDLGr8dH2CQezmOHrMIuFt6tkogVDD0UEE
	 BQd0kQFu5MxnG/0EDx+RatPakm3/Fe/rgeFSaKUCTrE1HGHxc2z1TOQcmNFPYkcRYK1hl
	 XU++ExiyWsSEKvyDbPTefLsNlxs7714dNuDo51o1WbvoxF+kfSn5zLiiN3qLLf4JSNGEz
	 ktwehRmYLmBnoyX0db4r61BWLdyU2Yu4toOjrEIF3fn0gq8vtW0X2lxjEFj5mts7+dA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793988432;
	bh=IorsO8tG+Fkj9gLzBEehrtNPfbvy7a40WImX0ozmol0=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=q+Ia7xiVKQszvxKHslTQSn2YAFm0QmljnkigRqiPBm/tw5m31dyD1z0aq2FgORQYi
	 K+JiXE25t3EOo2NsTbzoIqOdjc6qcDLYJCgcXzIdPb2fS33fUOTY6X2gpYnMV+xWxn
	 7GMXmJH9e3kKbUql1iEFeswaw9wW6FFYee0FQ01CZDMa25fm8q7hwfTryebdU+NW+c
	 N6+hqufeUy6DdL/MGbAMfoLVT5Gma5lOWFXtEzVmptc6JkNqcT/LZH+leph7spktkk
	 6hwtSuKb4nLKFr0FFjxSyMOvSRP7B5/QYgA81eKHeW8YoRWFbEuksvI8Ocsmz02sDo
	 1SdOuXPp3gBIg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A188881359;
	Fri,  6 Nov 2026 18:07:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id A12822AC
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 18:07:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9251F40947
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 18:07:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Q4MgH-YZdvmI for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 18:07:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7F89E4092A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip="2a01:111:f403:c20f::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20f::7;
 helo=osppr02cu001.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=g+4efF7y; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=g+4efF7y
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7F89E4092A
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 18:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IorsO8tG+Fkj9gLzBEehrtNPfbvy7a40WImX0ozmol0=;
 b=g+4efF7yfmjUnQVU7xEPGVXyUcnSog17mZUm5Fgu72CxyytEJC96wkInNcJ1dqJzM2uz0al9qe6pl+LQ8xPSrEl5zY2emwiqhE61siszBbYLmMrdR/iOVXDxpAmdwMhI5MgedQU2HfPYmwR4xOcR7FG63NVn+Ajzog1xFf0LroA=
Received: from DU6P191CA0066.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53e::6) by
 DU0PR08MB10328.eurprd08.prod.outlook.com (2603:10a6:10:476::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 18:07:01 +0000
Received: from DB1PEPF000509ED.eurprd03.prod.outlook.com
 (2603:10a6:10:53e:cafe::6c) by DU6P191CA0066.outlook.office365.com
 (2603:10a6:10:53e::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 18:07:01 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509ED.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Fri, 6 Nov 2026 18:07:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IorsO8tG+Fkj9gLzBEehrtNPfbvy7a40WImX0ozmol0=;
 b=g+4efF7yfmjUnQVU7xEPGVXyUcnSog17mZUm5Fgu72CxyytEJC96wkInNcJ1dqJzM2uz0al9qe6pl+LQ8xPSrEl5zY2emwiqhE61siszBbYLmMrdR/iOVXDxpAmdwMhI5MgedQU2HfPYmwR4xOcR7FG63NVn+Ajzog1xFf0LroA=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by GV2PR08MB532009.eurprd08.prod.outlook.com
 (2603:10a6:150:37e::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 18:06:25 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%6]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 18:06:25 +0000
Message-ID: <d732494d-2a4c-49db-94a0-20253db20357@arm.com>
Date: Fri, 6 Nov 2026 19:06:24 +0100
User-Agent: Mozilla Thunderbird
From: Jerome Forissier <jerome.forissier@arm.com>
Subject: Re: [PATCH 1/1] net: constify enetaddr in
 eth_env_set_enetaddr_by_index()
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org, nd@arm.com
References: <20261105135807.2812078-1-alexander.stein@ew.tq-group.com>
Content-Language: en-US
In-Reply-To: <20261105135807.2812078-1-alexander.stein@ew.tq-group.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0053.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:310::18) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|GV2PR08MB532009:EE_|DB1PEPF000509ED:EE_|DU0PR08MB10328:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ba51423-84d1-498e-99b0-08df3c30c0ee
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|22082099003|18002099003|10067099003|56012099006|11063799006|261028144727099003|261022105027099003|261021123027099003|261026140227099003|261009223027099003|261021121427099003|261102123227099003;
X-Microsoft-Antispam-Message-Info-Original: BQItdTitl0WeqhBP6dOlK8KcXmrSpCXbs82DjtgPHn7DPMSAC/87r9ACKE6ynkmBSN7D5K2Bs32fVcl1g4BHxl1Iz48edM63w+8zwza5Zm2qhJ1u6McUv2yPeCnOkmHR30dAanO8Iq18coSHpnDRGk68+oOt8XJP63Exnc4Lel/27R2ojB8JMBru6kNha8McwQRdXhdYKlJ0dHnxk9iJICaWzFS3IexBp/P149aTM4qhH3AXTmk6y/n+q6jz1MVdqo7y/dBm3pcAv5BVjH6LQ7b45fVYKfXPbF07jp5MCN7iEUshedUAbjnjvb9XwkrQLWy23cfk8/EZIkajXZkDL0PLjsrbLK3XtoCALKXtCarATyHliCK7VoH95UD/nvAmuNB9Kh+vlSJg61fKU6TlHmVN9jO+1A4HCEFPg9IDCYuJiimOn6qvYROtHdxbQU2cJAFELBlKfuoRabQLxK0BPG47wAg2TgFdK//R9GREHEXrAaX+pQQTmLxYlvdSPbJ7xw+nRCG/g9LSWRPgNb6hLJAc9RLhJTMMew6cF/3IXQY9MkKEfBjx4NwKqE5tuHsdRv541c12Bef4mcJUE55v4cv+U8F814daqCXGQjlXenkozlKulxoQ9vfZnVeRk8ng
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006)(261028144727099003)(261022105027099003)(261021123027099003)(261026140227099003)(261009223027099003)(261021121427099003)(261102123227099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: fnpc2+ZvAPyVKTZe9JS14J0HO9ymlO2uRMFT4j7pWVHiArrBYBTjpMUUTmME8CKdbDsvm9aplyIdflMNBuAuUG8TIqlOO/ER8SJPNXq7FdHENxVb/np2ITGGBTxGEuQY8cHTCUWyQ2/7oa6/qLAGT0Bf8xMUn1OZu9PrbCmX4Rlqu55oEfegB4NaMAh41pV9wCYZF5aBv+CkrerEt/h/BIuYx57r8+APt/9npkHwlxtA1nm2tZiqoXJ00B2WbAU3/cZWIUoeH+SajkZ+9HUojSA47Rqwg94BbHvM3LW6kLCXoTthhZBdaGYkG9X9MNfgbHjmWLFp67cZTOvNUtnowA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB532009
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB1PEPF000509ED.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 742ec1a6-d9bd-4ac1-2ff7-08df3c30abde
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|14060799003|35042699022|82310400026|36860700016|1800799024|11063799006|56012099006|261021121427099003|261021123027099003|261009223027099003|261102123227099003|261022105027099003|261026140227099003|261028144727099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: yGDwgEE8K+btd7drCHm/xcxHXiIlrUmaleeWvMZejHTbOzPdKsLYC+Ak5apFenUGCi2IPYK4Rdi4oCww+6IrtzXio+QMgSpF0xwuq9m93cdA5bLO3oVLaLgtiQrkUw+CAzL7gNcHCPzgORJk5IFdhXccolObwTaT+5RCloKGDwbm9BPeOWUVQDXmPB8aROmX/OOy5O96dhBLXvXxEFdw+mcaSzwzTt42UFsS8nxJMpR/Y1XAwBxoL/g/fissw8pDI6cnrje2g6vHhMoZ85i++KG9I9ikvq35bqzxPZ9bPu+2LiMcZNve5NVQEsON/n4KfYQQmuDMPX+qmwMjriU9HySnxRU0A/49aV2eQBSVBjCFyZEe3J4kRykEoWlvGv62u1+rrz7O4gV4C7UAcwm3TkaC4negzey2frkO8TL5JUuDagiAggQO2iXrT9YupXw7L+NCJgDGX29tpziaq5Dp7iCilCBtB/lOhbq/Ksr6HxkFFeq/VtRC4w8tEpSN18jbQo/dFH8cbI3IbXYnz6borrOwD/C11dp16NM7ITBQFtakaZOpQUjKoKJ1RYb8XbkLZyc5RlO3RQNr+Ws5m00Gl6hly1I83WlEDUDsQDrq6aM+i3N2G/81Lj11m++ajVV2zH1ivLmDJjAFzWkovgKaTQ==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(14060799003)(35042699022)(82310400026)(36860700016)(1800799024)(11063799006)(56012099006)(261021121427099003)(261021123027099003)(261009223027099003)(261102123227099003)(261022105027099003)(261026140227099003)(261028144727099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MD9fJ+9W6hiwCEyibXbDwfaXsmCv262+s6NZqaD65Cyc1FBLO7dg5zYLZVezXf8IpXhu/SqZgV3ZA8V6QjUQb2wRGuN0cBP989dVVozc4pH2BdiLxb2S0IE/D5mlyeK4W6cb4BfxIe9rytuHjPuz8EwE+peR1ocAcmrL5ZYxiRzPO5TNCoW6XhA8fnRA2wAc+e6GbPy8AlXggeXyHgnNoJuNCq5BXZyM5BRjKUEzqslcjJgIg4I9z3SarP4MMtbnL6fhHz5lp+q9RAoskiltUO8bR7QdXsjhittMH7ceaPblZu0V/bd3McXAMopad6oijlQfCtYIa+l6R4fYEHJsJvDjIqkS8VNBK8BKP/BtCjsEMfONnaf+jKP3s5bhK5Dpkod4qVz2vbbh1AwOfKS7h1CRtMrZOHYGsPUCV5tW1eU4Hu3rZQjY/8gaw9cN1e5L
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 18:07:00.1868 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ba51423-84d1-498e-99b0-08df3c30c0ee
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509ED.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB10328
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
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> There is no need to require a modifiable source pointer. Make it const
>
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
>  include/net-common.h | 2 +-
>  include/net-legacy.h | 2 +-
>  net/eth_common.c     | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)

Applied to u-boot-net branch for-main [1], thanks!

[1] https://git.u-boot-project.org/u-boot/custodians/u-boot-net/-/commits/for-main

[1/1] net: constify enetaddr in eth_env_set_enetaddr_by_index()
      commit: 1ed1749575f28b406c241218eb6a200574574a25

Best regards,
-- 
Jerome Forissier <jerome.forissier@arm.com>
