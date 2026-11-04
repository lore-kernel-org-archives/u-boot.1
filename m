Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B566E606A31B
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 02:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=oLYDBrUf;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=aQeljmmq
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7711C8096F;
	Wed,  4 Nov 2026 02:05:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y2NqGKDIy1UI; Wed,  4 Nov 2026 02:05:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A3A13809B7
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793757926;
	b=QWz1V3fA0T8CY3PWGhut5JE4y9lFQ1LPWLYkAL64VUVpu7AepIvs2kdIE4UGh+jIADUr
	 3jft0vFeLQj3Y+3EiWoMbm7rR4MtF9qpq5cKsv2Quh47YtO6oGnx3dO5yLJ8dyhe0Cdrv
	 nyhKPFX5KhIWpANJ4ieHJJzks/5v+u72CLj1DB1xqImTzbczBYbs9oL6zeRUNktmGV8RH
	 iGNWhJnhwRFmfB9FbZ97GlQJ9kLfJvxGL5gGfYfe6gmH950n7W18rKDdGBulWL8TghqXQ
	 pmOBRNScce4i9+JRkHkLTI4y71VOZepQQeX4Jyif7Bdcsmt3Ms9Lg8Hr1yk0RfxtXgw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793757926;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Virus-Scanned:
	 X-Virus-Status:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=kZxeCrfdNcU/piDlB3iEKXWZC8AMPKH4numGtw6rFu0=;
	b=tHiYlPOUNZn0EI0r2GHCq8pxHEQ6ULi4Zw3Ti+Cbnir4u3ZegRdIaIlj+7C3IRx6BKT8
	 wwW9HPyuZxpF0aA/jQch/w5Zfe/LxJyMSl2n+7QCX6IvnO1hNg6IouJwcMwahan5EWzMt
	 dzFgURoAArR0Ytf9XLxHo0FKjOsBqG01vPOC/rXCbQ5ntAqKTPyXjh7AwJKvO+Nu9ntPh
	 +NGwXw9AepVYdiokOcmQfxAboc6EUupl1LlNTgeyTnAlgzK1OQzNeeYM/Vw66S0xkJIf0
	 7t3CtgeVxi2OgeMqd6kc04hJ8aBKWJaZ2+ICOMNCQREcD3OVmgFFkEtC2uiYabEHCLg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793757926;
	bh=kZxeCrfdNcU/piDlB3iEKXWZC8AMPKH4numGtw6rFu0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oLYDBrUfAxblJlyqBVJJi4GkcWu8TN5bxOCNvOlYByb3aGSExA1KmZyXf6GxkrDR6
	 zYM/BzM6g0si3LQyKq+qC+ADqgSPdPLkdjKhnSgf49w4CydOO7k37Nja23RUfD+9KM
	 LWzsI0hBQwQPeHTJjAhVdAANyU6JOVXdCTXxdldDId1T1jOv4TC+td1E8+4WcutkS5
	 WHqQq5OciHBjJ2Z0NNMtHSq5waac+iSrvNQAmf5hC8DUTH60o+cFD760aHNOQAzlcl
	 5EmAjDKObETOL3dOg5I3XcfqR/3KuyzRdClpictzSkRQ1jsocRNYqrOYGwuG4EmXh4
	 73aGUplxgSphQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A3A13809B7;
	Wed,  4 Nov 2026 02:05:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id C245E2AC
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 02:05:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A4C096069A
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 02:05:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nell9L9LWjOl for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 02:05:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E114B60686
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:238:438b:c500:173d:9f52:ddab:ee01"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793757924;
 b=WwvO2eXpI3pXC2WWd8wKwrAOxM8Kxjr6bdMDH5k3akg+MCwmjVorVLxXyZH06uc9fhDa
 I2v63ImzL3zLDUqUbi2Dd3/Vge/DI1esUJGoLxWbx4+5KJBp63tKJcCl2BqnCZZFTdY6k
 8dKxqulbAsOqQWg3icXnMrC3kzHjqivxR0esIrCxYQjxadGtKB4z1jFIfgI9yKYNCHTYY
 ZLgnLc/djVacq3+xRD/PAe8tkT73IAj22OmuF0FoJNA+OHZzsedI5H+nUNLXA4P8pG4mP
 L55fCh0p45qz6oebHvHXLVfIIrboAgO6o7GDUuqrf74od8AoQCx7iMTmCpa7UExJzcQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793757924;
 h=X-Comment:Received:X-Spam-Checker-Version:X-Spam-Level:X-Spam-Status:
 Received:DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:
 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:
 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Virus-Scanned:
 X-Virus-Status;
 bh=kZxeCrfdNcU/piDlB3iEKXWZC8AMPKH4numGtw6rFu0=;
 b=s+I2EIAb5pvc3y8qSVwgba+5UBGh43/ABFsM++IF1u/G5ZfYZApfOwXMVYA65HEHJ/bi
 v1MO5bseu6rI7o0ML+gr7kXDvfPtULK+S5UhSbRaaYmsfEOeT5veOjNzY94do+fwxtACn
 OPxm/D8fjNjjzBq/10o8pyBheAnPG6mAIhHoUS3QBWCRP07b1b0skl9jl89ToVQ8gGAcH
 Kczw9gHjIV8RGHi8d1VwesU3DmYQ8C1Av0eDdTWhIQTROPTGFWIMwtolylahrvb+gxPX9
 RUVXnYaijX2L+pqmrXroiwGusMPgJnFgS9DvnlUrUqarqdrHjiFtjQjdVhmcqND7KPg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=altera.com;
 spf=fail smtp.mailfrom=altera.com;
 dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=aQeljmmq; 
 arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:238:438b:c500:173d:9f52:ddab:ee01"
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=tien.fong.chee@altera.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp3.osuosl.org; spf=fail smtp.mailfrom=altera.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=aQeljmmq
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E114B60686
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 02:05:20 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDA5B84823; Wed,  4 Nov 2026 03:05:18 +0100 (CET)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4CC483E76
 for <u-boot@lists.denx.de>; Wed,  4 Nov 2026 03:05:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XcM1+CooC8S6U6utY7A8ZWXNRH8vKxD/059UsGWQtHr1RbXleMRt6hENMC29kNTa8dVArrlWxduWcCq8+q6OppKWyRXu+v6Im6JuQOy9mBTqkQMFQ+sxcOxS6A0DVKYaEIaTIh4Hqdz4nzVuLu3pCsGefCGBuOTq5aP/u3gyWhZ2SOLuZ/NCsD1l++4WtH5fSgkxmzxwFUFzHRsWVxdCCuQVsyLC8K97OEs9cfKcuE5124TL+SfkHjauN3N4g2tyro2eUvNXOH4v3Pc/WCvmM8M58wTq4g+2Ix5UkOqdHEFLwgfR4m50InaWBff74fa/3LdBlnnhTJKWlHztmt02iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kZxeCrfdNcU/piDlB3iEKXWZC8AMPKH4numGtw6rFu0=;
 b=Fm3yDPW+JcDt2WyLMqJzdi4lIilEqJMGFEW8P3fAy8elXlJPC7U69P9E0U8U7on/+HSyg5rl2WrljXgYecGbKPCAIC1iCtug9QzRBLD44Hm3UoxR6THMbKGpaQb/UFu2gO5fR4OhgMiLW4dv4A+Na/LXkgmUA/gHkxihO5/t7nbf2ECg1Z4f3Wk7JY/FDjo0RjZVhVrLINC1KDRCjnh/x+hp6IaGabf8YcwVq3VGYS41Ip2iwfpzELy2flugOy72STnZtsjQ6EyvPiI/oaO1ehd6HFYukpFfJno3MyF/nhk1VPAq1PLmouQVD7A8Y3xukpsvcRAiraknvmWzXN9u/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kZxeCrfdNcU/piDlB3iEKXWZC8AMPKH4numGtw6rFu0=;
 b=aQeljmmquI94BAE85tBYJNZtl/P1Ez5hTd/qaLuMEuUPjL8N/I9FyOptFqGqP8+5VOsXMHR23NfDyQRUGfCAc4vhiwwsQfuGtDhJ4xkin+NkpD14a6FeyNhRoHcjd+YGWAxroXJ2WZwH0c69NTg69EUVVM7n45oZT6E41kn6w6HfagPPqi2/aQ2pTHQNeREDv+Qx/vZ3OgBBJvU1+vO9cnuZbyKL12M/28wMhLpBG7EWdi5js56MV9ILANUvY61sZz0whxzCf0clY/G8UvSiZak3khmIkC/wgTF/k+mN9DfD8EdEcT/79Kj+R3Z53rckPhjUjjegzjz5QZrDBu1yHQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from CHBPR03MB959535.namprd03.prod.outlook.com
 (2603:10b6:610:40d::14) by DM6PR03MB5147.namprd03.prod.outlook.com
 (2603:10b6:5:1e6::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 02:05:07 +0000
Received: from CHBPR03MB959535.namprd03.prod.outlook.com
 ([fe80::26cf:5066:9d0f:c79d]) by CHBPR03MB959535.namprd03.prod.outlook.com
 ([fe80::26cf:5066:9d0f:c79d%4]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 02:05:03 +0000
Message-ID: <e6e6de9f-0708-4288-b582-edcb8ce5b2e3@altera.com>
Date: Wed, 4 Nov 2026 10:04:55 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] arm: socfpga: agilex3: Add Agilex3 SoCFPGA support
To: alif.zakuan.yuslaimi@altera.com, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+socfpga@mailbox.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Markus Schneider-Pargmann <msp@baylibre.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>, Johan Jonker <jbx6244@gmail.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>
References: <20261021071258.5095-1-alif.zakuan.yuslaimi@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
In-Reply-To: <20261021071258.5095-1-alif.zakuan.yuslaimi@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0222.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::17) To CHBPR03MB959535.namprd03.prod.outlook.com
 (2603:10b6:610:40d::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR03MB959535:EE_|DM6PR03MB5147:EE_
X-MS-Office365-Filtering-Correlation-Id: a36157e3-41b7-4b84-8830-08df3a1809c0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|55112099003|11063799006|56012099006|261021121427099003|261009223027099003|261102123227099003|261022105027099003|261028144727099003|261026140227099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 95pB4sZ6wfJyceIWNcDHr451Kp0FueDckOiTtVow+MQNadG6UP/ZJaD2bU3kPnvuzjCAckStHlXNn1XZQY9+kOpUZccMEISkgOIuuxUZkaSTeSPHjkA3k6BrdcdNp6c6ep8pKxK8cqNn9eaywuOYFK+Infl8oZtZ2ub7lep+gAYgch8keVfHIRoFFjZutEi0lIAzDOv6k3Q1V10POxTpFxOvQST2uHF4BoJj9H7uSXo0GWyMRAO+dd7iHHdY4GpTgxJ8tN0FPokurcWJMSKWMwT5e7t7PZpKXy32SpdJFz3ngd2bg4Yh54FrRH5pK5118rKz99PBL/iJZJLGM1WOriQjAxBcO+6YLOGY1YGK7SM7/gWla5WjVDai6NwXvMum77rLUtDDsLrHz1ypUD+htwaSZdVfdfGzydOaEsFEdycC33OiaoDM+KRg7nUUtt89x+9Zwq9/5S4AwMmkz7wKkw6xZ0uhsdlf9e6lYuZzfal6u42LKloVol+0YFHe1cBu7BQU2yOs+vSBgPC5Wlxu6oUXXlu8QfMthK8PPoEIlgHFCnWLqyY+rpDULEU7MWggU/1P/NUghHn/OVpX5NBAzAwdUuPSCm3SGrhmb1HlYZbPo1tfP/76zulHSy9R7tVL68T59SDFGfU1CZMUvWYOvUkQtxYHG1hZdRZmuR7Qp18=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CHBPR03MB959535.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(55112099003)(11063799006)(56012099006)(261021121427099003)(261009223027099003)(261102123227099003)(261022105027099003)(261028144727099003)(261026140227099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVFnaU1FU1d5K200a2h0bEc1Z2JnaUJLZUd3N1ZyTzNtc1p3VUIvbWpBU0Fn?=
 =?utf-8?B?NjVvUTh5RXZvcEIxUEJBdFV3ZU5jd243VEVtMGlBOWpOdTVPZVRUeVY3N2V6?=
 =?utf-8?B?MTBqcVVvMUFyZHd4aVQxZXJkU21iUGVMODZQdkgwVVJXL2kwdGR2ZUUwUXFP?=
 =?utf-8?B?ZjdMZ0ZFNHN4eDNTaGFJTkJ2aWhnUzU4QlpyYkJxdEt2amxlYlNqL3QwN2pz?=
 =?utf-8?B?RVZRalpOUnBHcEJ1eFkzbmdPemd3RERIRjUvMDNnZEtSTmM2eHQrYzhpc0J5?=
 =?utf-8?B?eWtJM0kybk9ZU2dDdmhKMEM4VUhidDdmM2JGMHN4NDNRQkMxcTV6WEhLQnEr?=
 =?utf-8?B?TFRYZmtTSmFkcGtkaE9yRlM3S1dYSnNtQ0FFOVkxbktpbWZLakhESEtwYTlS?=
 =?utf-8?B?SlJSZDVYdWpUMUxpT1hwa1h5UzEzaklFbkN2U3JHNVVwbUNVM3hMU3ByVUts?=
 =?utf-8?B?Z1NXSWZCMkFsVWRnd1BKK2FiTDAzWm9CSUJOMXBUc0JaK1FlRFpZNDBGU2xZ?=
 =?utf-8?B?ckhzZk1DWExyNTB2VEZhMjV4b0tXbkp4NjZtclZlbE9nUGlLQzR3anpPbzEy?=
 =?utf-8?B?NHBnKzdqcCtSZnVZbDZhV0JMRE9CamgxbWZWakdGc202OTY3SC9Bamx1cXlU?=
 =?utf-8?B?aGZXNlRwRTRrOERtS0NGbTdwaExMV2FObkJZZUx1Nk9OMTBVdk9aM29NZk5S?=
 =?utf-8?B?TEd0V2RIY1k0anpsdWFERzlrd2tYZmpnSndvRktLdUVrdThyR1F4VzV4K0Va?=
 =?utf-8?B?Y0RzeUZ3S01CYjl3RWJyU2JPc3VudjQ3bGZUZ00wVTY4SDAxN3RGOVVRTW1Q?=
 =?utf-8?B?NjF3Ujd3YWJhL3VTKzBLMmpPOEl3anNQTHBMTFdRVXp0bnFJRWtTaERkL3Zt?=
 =?utf-8?B?SXN0SGxHK1pwSS9hcEt0ZFJwR1dDdlhwcmp6eVQwL3RyZHJOSnFYQTQwdEJK?=
 =?utf-8?B?Y3cxSlZyL29mN2VmbkhJZnU1ZHhXanczdTUvZkVkczRqcG1zWStOWnVsYjVo?=
 =?utf-8?B?SUNPekRkKzZzT3loWW14TVB0YzhUMktDTkRmKzRtQzI0cm0yMFJwNHlibktV?=
 =?utf-8?B?VHZ6MDgzQUlQdmtibWJob2dRVjRwMU1HcUFReWt5b0JJSjQ4SzM4cnpxdy9N?=
 =?utf-8?B?cnBjUVRiTnFTMXNlam5iUkd0ZkxycVpPTUhqOHNBSGR2RmtWSWRPYXJQckhD?=
 =?utf-8?B?K3d2M2dMS1NSVzUzcEFDR1RwQzBQNTQxenFhT05HdktxcUg2dnc2Q3FWWU1r?=
 =?utf-8?B?dmlLSVFEYlE4OXRFb3QyTXhBM0Uwb2RubVpSb0hLYkFySXRYVldhbTJaTEFN?=
 =?utf-8?B?L0l1anMzemZZTE1hd1p3eFNFdFMzRW9Ub2tIdy82SlVIS1kwUEQ5S3RIdDlD?=
 =?utf-8?B?dnNlUWEwNzNzTTFhazVUQVA4RnFIRDd0bmpwTHBlTkRqeEJPR1hMUzZkbXoy?=
 =?utf-8?B?REkrbGw0VjFLUzllekphS25FVHVjb2tPRWR6U3lHWUtlcTVYUWJmQk95TFZT?=
 =?utf-8?B?M3gwcUVIdk1vR1lTdi9oZ21jVlhUOVdJWEhCc3RyZFJvTnZnbGE2Ym1TQ25q?=
 =?utf-8?B?NEMzZEdNSmpKa0pIMy9lZ2RaZk44R3FYTzZaeXFmbHk2UkZqYTF0Yi9hak80?=
 =?utf-8?B?QTIvSnNaSkM5ZjB2bFpkbHp2UVFIUW9GNGNtQUhVdXBGUWxZb2lKM0VvdXBG?=
 =?utf-8?B?MmhMdTBFbXU1citaNHhFVnorNzdyRGVqSk1KRy85eXE2VkdCWmMycXphMGdW?=
 =?utf-8?B?SUdvQ1RiTkZoUkFMYVF6WXpVSGluVzl2Ui9WY2hPMUVlaUs3aDhkbXRRelZE?=
 =?utf-8?B?RjdpanpMUGxPT3RRZHlGN0lNWlhkcXQ5RWtBZk9wYWZPKzRHaWFVMVprMjZ5?=
 =?utf-8?B?WDR1c3BBWnNzRCtvVHZjYTFuUDFFVDJKUU1rY1RiVWdIUkR2TDNXWTBpWXNz?=
 =?utf-8?B?VDdJVE5WVGU2RnRjdllPYVNrRDBVU1VNQk9kSUVNTmpKVXg2Z3FGcWhXdkU3?=
 =?utf-8?B?dzlFZnd1NkwzVUYvdGZ4UVh0SFh5UHlWNHFSUitlYXlCbDAvcWhWUW9kcjRM?=
 =?utf-8?B?UDVpSjFRZzR0TUhYNUZyT0NRaGE2bXlCZHY4SmlzOWNqUFN6b3BJZkpDeis1?=
 =?utf-8?B?b3Bwc01kb1NVblk3YkRETGpEMGEwL0c3azhySTVVNTBiUWpUODJweEpJWjc2?=
 =?utf-8?B?Z0JMN1dOUS9kZnlXbEkwcitEZStYc2Mxak5FUzlRZW1HOW9IZEc0ZlBpQ2R6?=
 =?utf-8?B?bWxDVmMycS9ydGlpeEVVMVJkdE90SEFWL1pxdWxrNnJPdHpaNEdOYUhPajEr?=
 =?utf-8?B?UEhtKzVuYjlRcm1wNysrVVN0SWJiUEVzdTR5a0hldjlMVXkweEtMVVpXZUVX?=
 =?utf-8?Q?Z4UT9vXbKINpm3yk=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a36157e3-41b7-4b84-8830-08df3a1809c0
X-MS-Exchange-CrossTenant-AuthSource: CHBPR03MB959535.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 02:05:02.9830 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 88YpfjnaIBpqneJcLmphtzVVEobKrGHtCLhBA7E1/kkuDwmJ98X6GJLjK6GqBeJFEevVe4ltKHgb9HK9hcleVzR10ggg0TyxGzp+eRojRdc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5147
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 21/10/2026 3:12 pm, alif.zakuan.yuslaimi@altera.com wrote:

> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>
> Add initial Agilex3 SoCDK board support based on the Agilex5 platform.
> Agilex3 reuses the Agilex5 SoC DTSI, U-Boot DTSI, and defconfig, with
> these board-level differences:
>
> - Ethernet uses GMAC2 only with a Micrel KSZ90X1 PHY. Agilex5 enables
>    GMAC0 and GMAC2 with a Marvell PHY
> - QSPI map is 12 MiB u-boot + 52 MiB root with U-Boot offset 0xa00000.
>    Agilex5 uses 66 MiB + 190 MiB and offset 0x4000000
> - TARGET_SOCFPGA_AGILEX3_SOCDK is added with an Agilex3-only config
>    header that uses the 12m/52m QSPI layout
> - MMC enables SDR104 (sdhci-caps-mask) in the board DT
>
> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> ---
>
> Changes in v3:
> - Move Series-version / Series-changes / Series-links out of the commit
>    body; place history as Changes in vN below --- so git am discards it
>
> Changes in v2:
> - Move Agilex3 QSPI bootcmd to board config; restore shared SoC64
>    BOOTENV_DEV_QSPI 66m/190m path
> - Add TARGET_SOCFPGA_AGILEX3_SOCDK with an Agilex3-only config header
>    that uses the 12m/52m QSPI layout
> - Use rgmii-id instead of rgmii
> - Restore LPDDR Inline ECC memory examples
>
>   arch/arm/dts/Makefile                         |   1 +
>   .../arm/dts/socfpga_agilex3_socdk-u-boot.dtsi | 185 +++++++++++++++
>   arch/arm/dts/socfpga_agilex3_socdk.dts        | 222 ++++++++++++++++++
>   arch/arm/mach-socfpga/Kconfig                 |  11 +
>   configs/socfpga_agilex3_defconfig             |  10 +
>   include/configs/socfpga_agilex3_socdk.h       |  33 +++
>   include/configs/socfpga_soc64_common.h        |   2 +
>   7 files changed, 464 insertions(+)
>   create mode 100644 arch/arm/dts/socfpga_agilex3_socdk-u-boot.dtsi
>   create mode 100644 arch/arm/dts/socfpga_agilex3_socdk.dts
>   create mode 100644 configs/socfpga_agilex3_defconfig
>   create mode 100644 include/configs/socfpga_agilex3_socdk.h

[...]


Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

