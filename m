Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C39F606A31C
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 09:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ImC7aS7A;
	dkim=pass (2048-bit key, unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-softathome1-onmicrosoft-com header.b=upCW9Ddc
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 32B2960AC6;
	Fri, 30 Oct 2026 09:48:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TNwnKU0KErrZ; Fri, 30 Oct 2026 09:48:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6084E60633
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793353724;
	b=bsXubKGGxGx0fyfcbGtbaewu2oRL/X0bzkY+OxIvkDQwkGsNj+im1K6Sil6qAavsr6CJ
	 TLHXBJ1EUnfW1gGq/FtcreJN99d4iPhVmosy95D228cAoCsiz9x6vRmon0Vyr49xuNspb
	 cBBbdtPvF52AF74VEKqZ4AQRdiozYC3j/WDh/F6KgQlv9vwANGnbDrtaRBLAzAFaohfwl
	 cgghvTr//7h/LE1hMm4yk1ro0dQiaAMzbcckJbu/JIMYmrOBiFz91odZXCFR4qMXEsk+S
	 SVy3umSyjZualuRgp5hglI7qpE3qeLDZkzT4t81ztdLhaym/gmoiXlm1htuqyuT7XEQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793353724;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=tITnNWal9YLmUtvLbMoC9/y6vft6SQ25HX++ITlPXSE=;
	b=FwheYOQtFC7YD1artYzZcbLGX8nl4RYXswBpiajB18tcACIS5rvXm/rGV70730INBR3a
	 scYlJHrQa28tGkXHsxZnmTfzixkL2afQcOyqM7W94FKHxarlBymCH/6sLXW9GotpSq4yQ
	 Ieyw/JsTV29qyP8lZpdidy0SBG+b/4uN7bTiUiqZiAosO6F1fqbDfcGLuxJ+7v1817MIg
	 o/KwGBW5TXo9FbPCoquC6DBuCONuTSOM3AVDzCjTMMOkPV8UpoF8pF5sE4fLUWuelWWZ9
	 YEXi/eTJu0yokOzqC14peGowuociFYrEL+X4gNmTi0kxqLBsicX+zeU39M6/8ubbvBQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793353724;
	bh=tITnNWal9YLmUtvLbMoC9/y6vft6SQ25HX++ITlPXSE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ImC7aS7ATb8ITVGsrVAYhHXwhw8gW5XKrjZhCW3q8oO1QEl75T7CpJr6yKTEEfs+q
	 mEfdyksvbBKBCpKWwtdlq2I7JLhumPdLAj4QPT/+rw9IAYhSxsryH+3HQK3VfP+iqE
	 amw8Ia3CMplTXNuu3goQdcCvFeLCbd4bDPkie2fYhGLIfcWwimwVyvVQ+YQ1WDfk7M
	 jNxCxBxC+Eo8yyx5VeC9vZIgkUdIp8tUZfikRI1yc4wLLshIHzCUsDFqztLdOH01Gp
	 9nMUjyDnfewh3lpaw7RPeMPpWG6Nepn/2A8n2LIvHBpUJOzxuRRu7xIAIHrTSfZ8/b
	 mTBUmDQX5zKuA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6084E60633;
	Fri, 30 Oct 2026 09:48:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 09B454BC
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 09:48:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E360B404EF
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 09:48:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pVn4oLO4thJm for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 09:48:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2442A403A7
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20a::4"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793353721;
 b=Ofl43rusHaId+vvVuhq2gENPgg10fIK63XAZRU5qXmYR4DUf94B62bok5cxFGgFChXMf
 Tlfbp/UQnHvWgU1ioHshOMPKsfUNxklaHeIfZNtBBpH+sXXzW5iZebz6Dua/gbSJ+Bfiv
 w4V3nRiVk4kHXDtqRpTLB3pbTPn8UrEyYnIu04sQB3Tjd3lzEhJEAbpgO4f2cMkAE2k7r
 NXj5fDiUDanMvVYFPsXjWiBJtmNe0l46IK0ZvUgdBC6lOIG5uuz7jaDolSXjSqKRh6F3e
 axMAwu8WJ3wsNpPX7LTVAGvC6Jn7Mfr/k+xgOzPeagpnZKYizAwx1/bH644dkw9LEHA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793353721;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding:X-EOPAttributedMessage:
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
 bh=tITnNWal9YLmUtvLbMoC9/y6vft6SQ25HX++ITlPXSE=;
 b=AaQYrOdiWKqNiqwGmwAiG8eS4/hBdeReBoNbGYz1BNLYSFN2MzTzPOLNl+btdvBS+nQE
 QDPNcnkEUxYSSqjalOgMiWNzM0DzLrPiIB7+9AQuk5MSlS+NkmzcoqEwKsM12FxigVAPd
 I0unQ9c1SV1+GLZ7qdV/STAoJ6j09vHJy/HOFasJTRWS7X1EupqQWfUThjpRzPLm3mMyF
 dxv2646Qwnr6zWVWUXdqCWIU7dl+Few7BGk9xHU0ds7uP2pNhKijO2dSv/nk2zERduuAh
 HBMXg2DtpE/UntnEs9FmJ16XFMJUMrjsRo9SaKHaIlt0gV82y9qdUZ9l2jCK6ex59hA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=none header.from=softathome.com;
 dkim=pass header.d=softathome1.onmicrosoft.com
 header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-softathome1-onmicrosoft-com header.b=upCW9Ddc; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c20a::4"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::4;
 helo=pr0p264cu014.outbound.protection.outlook.com;
 envelope-from=yan.wang@softathome.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=softathome1.onmicrosoft.com
 header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-softathome1-onmicrosoft-com header.b=upCW9Ddc
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp170120004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::4])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2442A403A7
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 09:48:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RVHSmkYzsCidtGwilGFsQr7ex0YT08vR/bZm3d2cviQReQ6Xk0qvJ8qsFLMhnXSjiM9rNixt4D0UbgBOFnZ0/mn49qDL4YvTK+2M2kKBJJQUxUdfwq4mqr9wzrwRvZPhi/ObU4qtuLhGf8KdSfEZGY19DMUFVFdaZKWV9A5O1LHJy6GI1d4+WNW4y0WKbLZPfNbPXJtX0FuehuOAqP9mLfhI26Oec/MPZxl9+9GW4S84IzCBKLtQbpc8W2p2U7dB/yRBVzVWVeP9da03pZ9ROV2Lepnjn7O/AlvJ/ZRZKZICAhTYmsRtm60vHJ19S05pBsOZ/5kJMEgo5eGm9RDAFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tITnNWal9YLmUtvLbMoC9/y6vft6SQ25HX++ITlPXSE=;
 b=qBgGMSTtEE/JmW1khia8B9ASQe4G7haSJKnHIN2trjYIen71jTbnR7grgQSGbq9xlutTqusdPW5r2YdAwyQVuiA/q6Yd2jvSqkUA8TAMpS/3xPNCbRtFeywHVt6E7v2+la2AiOTM7KY0iPCdgJFzNOrsMng3gLFDKLG7LPaI8qSSp3h2320HF+5vKnWbeQW2K8ZOKpdPrUSgLSHDNRvwn5vM5RaWwM7BXSH4Yk13mPsT+pKup8nBQgv086nGb0ZydXXHcfZf8VSBtOYPp6XM6fVVOeSQhOvkDnCd0nUkd0x6tb9qu9o2kdaG7AP+KbISpJfaAJc6zAZWEOMuqTvmvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tITnNWal9YLmUtvLbMoC9/y6vft6SQ25HX++ITlPXSE=;
 b=upCW9Ddcq+0rco4aCaDgkWz75QMeuEm+3mltXhjb36kaBV/1unbaNWXa70jjq/z6J3Tjrk6Vr5+gjp0Wu4ttxkvXmQoaUvSAL3sDwnTNx/ynqnH5L+8WMS05l7DsNsp6Cvr5ziEGBKnGi87YuSK32o9TJpnJmwfRhwyjo6Od7L1aISuJSJxR+GwnWIJMpx6inxHq2LafJEjOuEivvqaIubzpIHHe+lJUjkhvnNgvoPwABbAtE3b7Ds7bryvjvMhPmNosBg5n+zCtkoq1R6PnNOUMoNzDfUGYsWvAjf7D1SMqGrmNExmQA571H5FJOGk9mgOiqIfabsabGSj/5RyHSA==
Received: from MR1P264CA0118.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:50::25)
 by MRZP264MB2891.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:18::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 09:48:35 +0000
Received: from MR1PEPF00000D5A.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:50:cafe::38) by MR1P264CA0118.outlook.office365.com
 (2603:10a6:501:50::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.7 via Frontend Transport; Fri, 30
 Oct 2026 09:48:34 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not
 signed) header.d=none;dmarc=bestguesspass action=none
 header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 MR1PEPF00000D5A.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.4
 via Frontend Transport; Fri, 30 Oct 2026 09:48:34 +0000
Received: from localhost.localdomain (unknown [192.168.72.182])
 by proxy.softathome.com (Postfix) with ESMTPSA id 7AFB92009E;
 Fri, 30 Oct 2026 10:48:34 +0100 (CET)
From: yan wang <yan.wang@softathome.com>
To: sjg@chromium.org, alpernebiyasak@gmail.com, trini@konsulko.com,
 alchark@flipper.net, paul.henrys_ext@softathome.com,
 philippe.reynes@softathome.com, marex@nabladev.com, raymondmaoca@gmail.com
Cc: u-boot@lists.u-boot-project.org,
	yan wang <yan.wang@softathome.com>
Subject: [PATCH v3 4/4] binman: Add functional test for pre-load HSM signing
Date: Fri, 30 Oct 2026 10:48:27 +0100
Message-ID: <20261030094827.82226-1-yan.wang@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAFLszThEJ7PY3PHadsqH3kRJxrz-jr4GH8bF6VCgo0j5QVFZrQ@mail.gmail.com>
References: <CAFLszThEJ7PY3PHadsqH3kRJxrz-jr4GH8bF6VCgo0j5QVFZrQ@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MR1PEPF00000D5A:EE_|MRZP264MB2891:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 4e34fa3b-8771-4f95-a0b2-08df366af709
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|82310400026|36860700016|1800799024|17002099007|18002099003|22082099003|3023799007|10067099003|5023799004|56012099006|261021121427099003|261021123027099003|261021130227099003|261021133027099003|261021135927099003|261022115727099003|261022105027099003|261022113327099003|261022075727099003|261026121527099003|261026135527099003|261026140227099003|261026130827099003|261028144727099003|6133799003|261009220027099003|261009223327099003|261009221727099003|261009223027099003|261009221227099003;
X-Microsoft-Antispam-Message-Info: NRqt9yMSes/4IfAwHGzRSli6JETVwOrwa27gFEHZIrXuFzNtrtgcUyr7G0g4ZxRFWBaikoe6bAuVzyjxhLGHm3es9SZVjGKsE/JtDNHA00dOK9SmWkEVnHqAqP2+xyQF/vTgZCOcp09IxkrceCreaG8WYBtSUv5NW/0rotrIGExVQJsSefym30wuI7lBYJehYuT0E7gH0YxQHY/UVEwdxr6L6rKlX46KVkTvwijbxdCU6zpJFvYUVa1DEXOvR/uEROgYDZ7nUpyJhQ8RBvvFF3pAhlrMdaqqbXzGRvn8E9WQYJe12UdmYu436fBQuilKUIwTQgvVCkbZG44bJDXwYyNBos930Y5nPClQJGHehPyblZExxkzY5O+VKHtEOq0dCjNKc+UcJiD2GchkEBOD/pP3b2rny43lb8DpFs31+VkggDHe2VqS/E7qRjZcN8iS4bR8aUWtdWqphb3Mp2BivLOyPOaOMxRiqCKutdbLvDcqTFYy3NiK0RopUaQpSczIqbavUk9S1YXEsXqUp6hv6wuQY0AzA7rOEUJlyXtiP9O1dplJ+EflPM9edfbYS0IellKf48fSgOK6LHl1YBDAfPXsZrC8kNp70IWmD4Gp8/GK4XwLIVGaDGkAtZHmxe3X18UvMfm2O0WRDhRS1tKr+wIWiDJ8bYFLbuMpwOJm9OBJxNmFI8BCgaA4usNsOCfb2mJKnRkeJeKjnOROzHZEoQ==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(82310400026)(36860700016)(1800799024)(17002099007)(18002099003)(22082099003)(3023799007)(10067099003)(5023799004)(56012099006)(261021121427099003)(261021123027099003)(261021130227099003)(261021133027099003)(261021135927099003)(261022115727099003)(261022105027099003)(261022113327099003)(261022075727099003)(261026121527099003)(261026135527099003)(261026140227099003)(261026130827099003)(261028144727099003)(6133799003)(261009220027099003)(261009223327099003)(261009221727099003)(261009223027099003)(261009221227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EmEhXyPja/xVH/Q6yVSm1Vl4Tyo3O3Jx7haRHzlhIQ2znbvcVMBQIsBJX+inEczXI3fx2B88Ih/dzLvchnpLzelh/CFzsr7mwwysPG9eGEl7xuB2tY5Uo+Gtqur4XK2Pj7tOurEXfIE5AntdQ7ZB5auQWgqbiX9VP6Dhy7LNjswguNQa97GuHe0VPoL9iRswA2Cv5AO95zbrgC3grO5EVCGDgVjU+d2RyPhnsEng8jZYPc+QqMzjRXUta/+YeyBm1bI8Fy/Anfu7sF+gabEa5N7JX53VFoc/klCGmThl8ym1s5m5LwzN7X+JQH+AVvf0WDBOPrt0iJfo3l7FlFfbCMpWRv2bLp1vmAbCiy+3z0ARfAOakxH3G3OOF5LlbPtteDCaGOM/SIpC2M/wy5etF8nXraJFiX0fmCkA8/As8UqBWjpYzggsEBC0HdGlrMB3
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 09:48:34.8134 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e34fa3b-8771-4f95-a0b2-08df366af709
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: MR1PEPF00000D5A.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB2891
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add end-to-end functional test for HSM-based signing of pre-load
headers. The test verifies that binman can use PKCS#11 libraries
to sign data via hardware security modules and can generate pre-load
headers with HSM signatures.

The tests create a SoftHSM v2 token, generate RSA and ECDSA key pairs
on it with pkcs11-tool, and verify the resulting pre-load header
signatures. RSA signatures are checked with preload_check_sign; ECDSA
signatures are checked with Cryptodome because preload_check_sign needs
the private key.

- Add _MakePreLoadHsmToken() to set up the SoftHSM configuration from
  fit/softhsm2.conf, locate the library through p11-kit, initialise the
  token, generate a key pair and export the public key in DER format.
- Add testPreLoadHsmSign, which generates an RSA-2048 key pair and checks
  the header, for both pkcs-1.5 and PSS padding, with preload_check_sign
  using the public key exported from the token
- Add testPreLoadHsmEcdsaSign, which generates an ECDSA key pair and
  verifies the signatures with Cryptodome, since preload_check_sign needs
  the private key for ECDSA, which an HSM never exposes
- Add testPreLoadHsmModulePath to check that module-path= in the URI sets
  the library.
- Add _GetPreLoadHsmPins() to collect the PIN passed to each sign() call.
- Add PIN tests that check the PIN source order: the pin entry arg, the
  environment variable, the entry arg taking precedence over the
  environment variable, no PIN at all, and a PIN in the device tree
  being ignored.
- Add testPreLoadHsmBadSignatureLength to check that a signature of the
  wrong length is rejected.

Error-path tests, which do not need SoftHSM, cover an invalid padding
scheme, an unsupported hash, an unsupported signature algorithm, an
invalid PKCS#11 URI, a missing pkcs11-tool and a signing failure
reported by pkcs11-tool.

Signed-off-by: yan wang <yan.wang@softathome.com>
---
Changes in v3:
- Extract _MakePreLoadHsmToken() helper (SoftHSM setup, key generation and
  public-key export) from testPreLoadHsmSign and testPreLoadHsmEcdsaSign,
  removing the duplicated token-setup code
- testPreLoadHsmSign now uses pre_load_hsm.dts (the shared DTS that was
  also used by the error-path tests) instead of a dedicated
  pre_load_hsm_sign.dts; drop pre_load_hsm_sign.dts
- Move the SOFTHSM2_CONF environment mock to wrap only the signing part of
  testPreLoadHsmSign, not the token setup, which already patches the env
  inside _MakePreLoadHsmToken()
- Add _GetPreLoadHsmPins() helper: patches is_present() and sign() and
  returns the list of PIN values received across both sign() calls
- Add five PIN-source tests:
  - testPreLoadHsmPinEntryArg: pre-load-hsm-pin entry arg reaches sign()
  - testPreLoadHsmPinEnvVar: PKCS11_SIGN_PIN is used when there is no arg
  - testPreLoadHsmPinEntryArgWins: entry arg overrides PKCS11_SIGN_PIN
  - testPreLoadHsmNoPin: None is passed when no PIN is configured
  - testPreLoadHsmPinInDtIgnored: a 'pre-load-hsm-pin' DT property is
    never read; the entry arg and env variable still take effect
- Add pre_load_hsm_dt_pin.dts for testPreLoadHsmPinInDtIgnored
- Drop testPreLoadHsmSignDataChecks: _SignHsmData() no longer re-validates
  the algorithm and padding scheme; that validation was moved to ReadNode()
  in the previous patch, so the test would need to bypass ReadNode() to
  reach the error paths and is no longer meaningful
- Drop testPreLoadHsmHeaderSignMissing: the dummy-header path when the
  tool disappears between the two sign() calls is now handled by
  _BuildHeader() returning None, which _CreateHeader() maps to the
  dummy bytes; the case is implicitly covered by testPreLoadHsmMissingTool

 tools/binman/ftest.py                         | 257 ++++++++++++++++++
 tools/binman/test/security/pre_load_hsm.dts   |  21 ++
 .../test/security/pre_load_hsm_dt_pin.dts     |  22 ++
 .../test/security/pre_load_hsm_ecdsa.dts      |  21 ++
 .../security/pre_load_hsm_invalid_algo.dts    |  21 ++
 .../security/pre_load_hsm_invalid_padding.dts |  22 ++
 .../security/pre_load_hsm_invalid_sha.dts     |  21 ++
 .../security/pre_load_hsm_invalid_uri.dts     |  21 ++
 .../security/pre_load_hsm_module_path.dts     |  21 ++
 .../test/security/pre_load_hsm_sign_pss.dts   |  22 ++
 10 files changed, 449 insertions(+)
 create mode 100644 tools/binman/test/security/pre_load_hsm.dts
 create mode 100644 tools/binman/test/security/pre_load_hsm_dt_pin.dts
 create mode 100644 tools/binman/test/security/pre_load_hsm_ecdsa.dts
 create mode 100644 tools/binman/test/security/pre_load_hsm_invalid_algo.dts
 create mode 100644 tools/binman/test/security/pre_load_hsm_invalid_padding.dts
 create mode 100644 tools/binman/test/security/pre_load_hsm_invalid_sha.dts
 create mode 100644 tools/binman/test/security/pre_load_hsm_invalid_uri.dts
 create mode 100644 tools/binman/test/security/pre_load_hsm_module_path.dts
 create mode 100644 tools/binman/test/security/pre_load_hsm_sign_pss.dts

diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index d4522e905e0..0ddc282ac30 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -22,10 +22,15 @@ import unittest
 import unittest.mock
 import urllib.error
 
+from Cryptodome.Hash import SHA256
+from Cryptodome.PublicKey import ECC
+from Cryptodome.Signature import DSS
+
 from binman import bintool
 from binman import cbfs_util
 from binman import cmdline
 from binman import control
+from binman.btool import pkcs11_tool as pkcs11_tool_btool
 from binman import elf
 from binman import elf_test
 from binman import fip_util
@@ -5992,6 +5997,258 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         self.assertIn('key-name is required for file-based signing',
                       str(exc.exception))
 
+    def _MakePreLoadHsmToken(self, prefix, key_type, label):
+        """Create a SoftHSM token holding a new key pair
+
+        Args:
+            prefix (str): Prefix for the files created in the input directory
+            key_type (str): Key type for pkcs11-tool, e.g. 'rsa:2048'
+            label (str): Label of the key pair on the token
+
+        Returns:
+            tuple:
+                str: SOFTHSM2_CONF file to set while using the token
+                str: Path to the SoftHSM2 shared library
+                str: Path to the public key, in DER format
+        """
+        softhsm2_util = bintool.Bintool.create('softhsm2_util')
+        self._CheckBintool(softhsm2_util)
+
+        pkcs11_tool = bintool.Bintool.create('pkcs11-tool')
+        self._CheckBintool(pkcs11_tool)
+
+        p11_kit = bintool.Bintool.create('p11-kit')
+        self._CheckBintool(p11_kit)
+
+        # Configure SoftHSMv2
+        softhsm2_data = tools.read_file(self.TestFile('fit/softhsm2.conf'))
+        softhsm2_conf = self._MakeInputFile(f'{prefix}softhsm2.conf',
+                                            softhsm2_data)
+        softhsm2_tokens_dir = self._MakeInputDir(f'{prefix}softhsm2.tokens')
+        with open(softhsm2_conf, 'a') as f:
+            f.write(f'directories.tokendir = {softhsm2_tokens_dir}\n')
+
+        # Locate the SoftHSM2 shared library via p11-kit
+        p11_kit_config = configparser.ConfigParser()
+        p11_kit_config.read_string(p11_kit.run_cmd('print-config'))
+        softhsm2_lib = p11_kit_config.get('softhsm2', 'module', fallback=None)
+        self.assertIsNotNone(softhsm2_lib,
+                             'softhsm2 module not found in p11-kit config')
+
+        pubkey_der = os.path.join(self._indir, f'{prefix}pubkey.der')
+        with unittest.mock.patch.dict('os.environ',
+                                      {'SOFTHSM2_CONF': softhsm2_conf}):
+            softhsm2_util.run_cmd('--init-token', '--free', '--label',
+                                  'uboot-hsm', '--pin', '1234',
+                                  '--so-pin', '1234')
+            pkcs11_tool.run_cmd('--module', softhsm2_lib,
+                                '--keypairgen', '--key-type', key_type,
+                                '--label', label, '--login', '--pin', '1234')
+            pkcs11_tool.run_cmd('--module', softhsm2_lib,
+                                '--read-object', '--type', 'pubkey',
+                                '--label', label, '--login',
+                                '--pin', '1234', '--output-file', pubkey_der)
+        return softhsm2_conf, softhsm2_lib, pubkey_der
+
+    def testPreLoadHsmSign(self):
+        """Test pre-load header signed by SoftHSM via PKCS#11 (pkcs-1.5 and PSS)
+
+        Sets up a SoftHSM v2 token, generates an RSA-2048 key pair on it, and
+        builds two pre-load images (one with pkcs-1.5, one with PSS). Both are
+        verified with preload_check_sign using the public key extracted from the
+        token.
+        """
+        openssl = bintool.Bintool.create('openssl')
+        self._CheckBintool(openssl)
+
+        softhsm2_conf, softhsm2_lib, pubkey_der = self._MakePreLoadHsmToken(
+            'testPreLoadHsmSign.', 'rsa:2048', 'uboot-key')
+        pubkey_pem = os.path.join(self._indir, 'pubkey.pem')
+        openssl.run_cmd_result('rsa', '-pubin', '-inform', 'DER',
+                               '-in', pubkey_der, '-out', pubkey_pem)
+
+        with unittest.mock.patch.dict('os.environ',
+                                      {'SOFTHSM2_CONF': softhsm2_conf}):
+            entry_args = {
+                'pre-load-hsm-library': softhsm2_lib,
+                'pre-load-hsm-pin': '1234',
+            }
+
+            # pkcs-1.5 (default padding)
+            data = self._DoReadFileDtb('security/pre_load_hsm.dts',
+                                       entry_args=entry_args)[0]
+            image_fname = tools.get_output_filename('image.bin')
+            self.assertEqual(PRE_LOAD_MAGIC, data[:len(PRE_LOAD_MAGIC)])
+            self.assertEqual(PRE_LOAD_VERSION, data[4:4 + len(PRE_LOAD_VERSION)])
+            self.assertEqual(PRE_LOAD_HDR_SIZE,
+                             data[8:8 + len(PRE_LOAD_HDR_SIZE)])
+            self.assertTrue(self._CheckPreload(image_fname, pubkey_pem))
+
+            # PSS padding
+            data = self._DoReadFileDtb('security/pre_load_hsm_sign_pss.dts',
+                                       entry_args=entry_args)[0]
+            image_fname = tools.get_output_filename('image.bin')
+            self.assertEqual(PRE_LOAD_MAGIC, data[:len(PRE_LOAD_MAGIC)])
+            self.assertTrue(
+                self._CheckPreload(image_fname, pubkey_pem, padding='pss'))
+
+    def testPreLoadHsmEcdsaSign(self):
+        """Test pre-load header signed by SoftHSM with ECDSA."""
+        softhsm2_conf, softhsm2_lib, pubkey_der = self._MakePreLoadHsmToken(
+            'testPreLoadHsmEcdsaSign.', 'EC:prime256v1', 'uboot-ecdsa')
+
+        with unittest.mock.patch.dict('os.environ',
+                                      {'SOFTHSM2_CONF': softhsm2_conf}):
+            args = {'pre-load-hsm-library': softhsm2_lib,
+                    'pre-load-hsm-pin': '1234'}
+            data = self._DoReadFileDtb('security/pre_load_hsm_ecdsa.dts',
+                                       entry_args=args)[0]
+        self.assertEqual(PRE_LOAD_MAGIC, data[:len(PRE_LOAD_MAGIC)])
+
+        # preload_check_sign needs the private key for ECDSA, which an HSM
+        # never exports, so verify with the public key read from the token.
+        # Layout: header (64 bytes), header signature (64 bytes), image
+        # signature (64 bytes), then padding up to the 4096-byte header.
+        pub = ECC.import_key(tools.read_file(pubkey_der))
+        first_header = data[:64]
+        hdr_sig = data[64:128]
+        img_sig = data[128:192]
+        image = data[4096:]
+        self.assertEqual(SHA256.new(img_sig).digest(), first_header[32:64])
+        DSS.new(pub, 'fips-186-3').verify(SHA256.new(image), img_sig)
+        DSS.new(pub, 'fips-186-3').verify(SHA256.new(first_header), hdr_sig)
+
+    def testPreLoadHsmInvalidPadding(self):
+        """Test HSM signing with invalid padding-name (validated before tool check)"""
+        with self.assertRaises(ValueError) as exc:
+            self._DoReadFile('security/pre_load_hsm_invalid_padding.dts')
+        self.assertIn('Unsupported padding scheme', str(exc.exception))
+
+    def testPreLoadHsmMissingTool(self):
+        """Test that binman still produces an image if pkcs11-tool is missing"""
+        with terminal.capture() as (_, stderr):
+            self._DoTestFile('security/pre_load_hsm.dts',
+                             force_missing_bintools='pkcs11-tool')
+        err = stderr.getvalue()
+        self.assertRegex(err, "Image 'image'.*missing bintools.*: pkcs11-tool")
+
+    def testPreLoadHsmSignError(self):
+        """Test HSM signing when sign() raises ValueError or RuntimeError"""
+        Btool = pkcs11_tool_btool.Bintoolpkcs11_tool
+        for exc_type in (ValueError, RuntimeError):
+            with unittest.mock.patch.object(Btool, 'is_present',
+                                            return_value=True), \
+                 unittest.mock.patch.object(Btool, 'sign',
+                                            side_effect=exc_type('Mock HSM error')):
+                with self.assertRaises(ValueError) as exc:
+                    self._DoReadFile('security/pre_load_hsm.dts')
+                self.assertIn('HSM signing failed', str(exc.exception))
+
+    def testPreLoadHsmInvalidUri(self):
+        """Test HSM signing with a hsm-key that is not a PKCS#11 URI"""
+        with self.assertRaises(ValueError) as exc:
+            self._DoReadFile('security/pre_load_hsm_invalid_uri.dts')
+        self.assertIn('Not a PKCS#11 URI', str(exc.exception))
+
+    def testPreLoadHsmInvalidSha(self):
+        """Test HSM signing with an unsupported hash algorithm"""
+        with self.assertRaises(ValueError) as exc:
+            self._DoReadFile('security/pre_load_hsm_invalid_sha.dts')
+        self.assertIn('sha1 is not supported', str(exc.exception))
+
+    def testPreLoadHsmInvalidAlgo(self):
+        """Test HSM signing with an unsupported signing algorithm"""
+        with self.assertRaises(ValueError) as exc:
+            self._DoReadFile('security/pre_load_hsm_invalid_algo.dts')
+        self.assertIn('rsa1234 is not supported', str(exc.exception))
+
+    def testPreLoadHsmModulePath(self):
+        """Test that module-path in the hsm-key URI sets the HSM library"""
+        self._DoTestFile('security/pre_load_hsm_module_path.dts',
+                         force_missing_bintools='pkcs11-tool')
+        entry = control.images['image'].GetEntries()['pre-load']
+        self.assertEqual('/no/lib.so', entry.hsm_library)
+
+    def _GetPreLoadHsmPins(self, entry_args, env,
+                           dts='security/pre_load_hsm.dts'):
+        """Run the pre-load HSM test file and collect the PINs given to sign()
+
+        Args:
+            entry_args (dict or None): Entry args to pass to binman
+            env (dict): Environment to use (PKCS11_SIGN_PIN is cleared first)
+            dts (str): Devicetree file to use
+
+        Returns:
+            list of str: 'pin' argument of each sign() call
+        """
+        Btool = pkcs11_tool_btool.Bintoolpkcs11_tool
+        pins = []
+
+        def fake_sign(_self, *args, **kwargs):
+            pins.append(kwargs.get('pin'))
+            return bytes(256)
+
+        clean = {k: v for k, v in os.environ.items()
+                 if k != 'PKCS11_SIGN_PIN'}
+        clean.update(env)
+        with unittest.mock.patch.dict(os.environ, clean, clear=True), \
+             unittest.mock.patch.object(Btool, 'is_present',
+                                        return_value=True), \
+             unittest.mock.patch.object(Btool, 'sign', autospec=True,
+                                        side_effect=fake_sign):
+            self._DoReadFileDtb(dts, entry_args=entry_args)
+        return pins
+
+    def testPreLoadHsmPinEntryArg(self):
+        """Test that pre-load-hsm-pin reaches sign() for both signatures"""
+        pins = self._GetPreLoadHsmPins({'pre-load-hsm-pin': '1234'}, {})
+        self.assertTrue(pins, 'sign() was never called')
+        self.assertEqual(['1234'] * len(pins), pins)
+
+    def testPreLoadHsmPinEnvVar(self):
+        """Test that PKCS11_SIGN_PIN is used when there is no entry arg"""
+        pins = self._GetPreLoadHsmPins(None, {'PKCS11_SIGN_PIN': 'envpin'})
+        self.assertTrue(pins, 'sign() was never called')
+        self.assertEqual(['envpin'] * len(pins), pins)
+
+    def testPreLoadHsmPinEntryArgWins(self):
+        """Test that pre-load-hsm-pin takes priority over PKCS11_SIGN_PIN"""
+        pins = self._GetPreLoadHsmPins({'pre-load-hsm-pin': '1234'},
+                                       {'PKCS11_SIGN_PIN': 'envpin'})
+        self.assertTrue(pins, 'sign() was never called')
+        self.assertEqual(['1234'] * len(pins), pins)
+
+    def testPreLoadHsmNoPin(self):
+        """Test that no PIN is passed to sign() when none is configured"""
+        pins = self._GetPreLoadHsmPins(None, {})
+        self.assertTrue(pins, 'sign() was never called')
+        self.assertEqual([None] * len(pins), pins)
+
+    def testPreLoadHsmPinInDtIgnored(self):
+        """Test that a pre-load-hsm-pin property in the DT is never used"""
+        dts = 'security/pre_load_hsm_dt_pin.dts'
+        pins = self._GetPreLoadHsmPins(None, {}, dts)
+        self.assertTrue(pins, 'sign() was never called')
+        self.assertEqual([None] * len(pins), pins)
+
+        # The entry arg and environment variable still take effect
+        pins = self._GetPreLoadHsmPins({'pre-load-hsm-pin': '1234'}, {}, dts)
+        self.assertEqual(['1234'] * len(pins), pins)
+        pins = self._GetPreLoadHsmPins(None, {'PKCS11_SIGN_PIN': 'envpin'},
+                                       dts)
+        self.assertEqual(['envpin'] * len(pins), pins)
+
+    def testPreLoadHsmBadSignatureLength(self):
+        """Test HSM signing when the returned signature has the wrong size"""
+        Btool = pkcs11_tool_btool.Bintoolpkcs11_tool
+        with unittest.mock.patch.object(Btool, 'is_present',
+                                        return_value=True), \
+             unittest.mock.patch.object(Btool, 'sign',
+                                        return_value=b'short'):
+            with self.assertRaises(ValueError) as exc:
+                self._DoReadFile('security/pre_load_hsm.dts')
+        self.assertIn('HSM returned 5-byte signature', str(exc.exception))
+
     def _CheckSafeUniqueNames(self, *images):
         """Check all entries of given images for unsafe unique names"""
         for image in images:
diff --git a/tools/binman/test/security/pre_load_hsm.dts b/tools/binman/test/security/pre_load_hsm.dts
new file mode 100644
index 00000000000..5671559c838
--- /dev/null
+++ b/tools/binman/test/security/pre_load_hsm.dts
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		pre-load {
+			content = <&image>;
+			algo-name = "sha256,rsa2048";
+			header-size = <4096>;
+			version = <0x11223344>;
+			hsm-key = "pkcs11:token=uboot-hsm;object=uboot-key";
+		};
+
+		image: blob-ext {
+			filename = "refcode.bin";
+		};
+	};
+};
diff --git a/tools/binman/test/security/pre_load_hsm_dt_pin.dts b/tools/binman/test/security/pre_load_hsm_dt_pin.dts
new file mode 100644
index 00000000000..84cdf4291a1
--- /dev/null
+++ b/tools/binman/test/security/pre_load_hsm_dt_pin.dts
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		pre-load {
+			content = <&image>;
+			algo-name = "sha256,rsa2048";
+			header-size = <4096>;
+			version = <0x11223344>;
+			hsm-key = "pkcs11:token=uboot-hsm;object=uboot-key";
+			pre-load-hsm-pin = "dtpin";
+		};
+
+		image: blob-ext {
+			filename = "refcode.bin";
+		};
+	};
+};
diff --git a/tools/binman/test/security/pre_load_hsm_ecdsa.dts b/tools/binman/test/security/pre_load_hsm_ecdsa.dts
new file mode 100644
index 00000000000..5b00ed8d69d
--- /dev/null
+++ b/tools/binman/test/security/pre_load_hsm_ecdsa.dts
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		pre-load {
+			content = <&image>;
+			algo-name = "sha256,ecdsa256";
+			header-size = <4096>;
+			version = <0x11223344>;
+			hsm-key = "pkcs11:token=uboot-hsm;object=uboot-ecdsa";
+		};
+
+		image: blob-ext {
+			filename = "refcode.bin";
+		};
+	};
+};
diff --git a/tools/binman/test/security/pre_load_hsm_invalid_algo.dts b/tools/binman/test/security/pre_load_hsm_invalid_algo.dts
new file mode 100644
index 00000000000..49d1c18f478
--- /dev/null
+++ b/tools/binman/test/security/pre_load_hsm_invalid_algo.dts
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		pre-load {
+			content = <&image>;
+			algo-name = "sha256,rsa1234";
+			header-size = <4096>;
+			version = <0x11223344>;
+			hsm-key = "pkcs11:token=uboot-hsm;object=uboot-key";
+		};
+
+		image: blob-ext {
+			filename = "refcode.bin";
+		};
+	};
+};
diff --git a/tools/binman/test/security/pre_load_hsm_invalid_padding.dts b/tools/binman/test/security/pre_load_hsm_invalid_padding.dts
new file mode 100644
index 00000000000..6ef11a59bb1
--- /dev/null
+++ b/tools/binman/test/security/pre_load_hsm_invalid_padding.dts
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		pre-load {
+			content = <&image>;
+			algo-name = "sha256,rsa2048";
+			padding-name = "invalid";
+			header-size = <4096>;
+			version = <0x11223344>;
+			hsm-key = "pkcs11:token=uboot-hsm;object=uboot-key";
+		};
+
+		image: blob-ext {
+			filename = "refcode.bin";
+		};
+	};
+};
diff --git a/tools/binman/test/security/pre_load_hsm_invalid_sha.dts b/tools/binman/test/security/pre_load_hsm_invalid_sha.dts
new file mode 100644
index 00000000000..e6c693e4954
--- /dev/null
+++ b/tools/binman/test/security/pre_load_hsm_invalid_sha.dts
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		pre-load {
+			content = <&image>;
+			algo-name = "sha1,rsa2048";
+			header-size = <4096>;
+			version = <0x11223344>;
+			hsm-key = "pkcs11:token=uboot-hsm;object=uboot-key";
+		};
+
+		image: blob-ext {
+			filename = "refcode.bin";
+		};
+	};
+};
diff --git a/tools/binman/test/security/pre_load_hsm_invalid_uri.dts b/tools/binman/test/security/pre_load_hsm_invalid_uri.dts
new file mode 100644
index 00000000000..17838935f61
--- /dev/null
+++ b/tools/binman/test/security/pre_load_hsm_invalid_uri.dts
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		pre-load {
+			content = <&image>;
+			algo-name = "sha256,rsa2048";
+			header-size = <4096>;
+			version = <0x11223344>;
+			hsm-key = "http://not-a-pkcs11-uri";
+		};
+
+		image: blob-ext {
+			filename = "refcode.bin";
+		};
+	};
+};
diff --git a/tools/binman/test/security/pre_load_hsm_module_path.dts b/tools/binman/test/security/pre_load_hsm_module_path.dts
new file mode 100644
index 00000000000..ae25d63b53d
--- /dev/null
+++ b/tools/binman/test/security/pre_load_hsm_module_path.dts
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		pre-load {
+			content = <&image>;
+			algo-name = "sha256,rsa2048";
+			header-size = <4096>;
+			version = <0x11223344>;
+			hsm-key = "pkcs11:token=uboot-hsm;object=uboot-key?module-path=/no/lib.so";
+		};
+
+		image: blob-ext {
+			filename = "refcode.bin";
+		};
+	};
+};
diff --git a/tools/binman/test/security/pre_load_hsm_sign_pss.dts b/tools/binman/test/security/pre_load_hsm_sign_pss.dts
new file mode 100644
index 00000000000..452f9f6d8a6
--- /dev/null
+++ b/tools/binman/test/security/pre_load_hsm_sign_pss.dts
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		pre-load {
+			content = <&image>;
+			algo-name = "sha256,rsa2048";
+			padding-name = "pss";
+			header-size = <4096>;
+			version = <0x11223344>;
+			hsm-key = "pkcs11:token=uboot-hsm;object=uboot-key";
+		};
+
+		image: blob-ext {
+			filename = "refcode.bin";
+		};
+	};
+};
-- 
2.43.0

