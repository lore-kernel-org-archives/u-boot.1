Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289A0606A31A
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 02:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=nHUm2PHB;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=LsAp5Y2J
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9D1CC80E09;
	Fri, 30 Oct 2026 02:34:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m63V8xoSkNTj; Fri, 30 Oct 2026 02:34:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B007A80DD2
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793327640;
	b=aLzdJV+id4xGf1qELU0tMSfy+ln4K8KpWQ9E4SmfuqWvs8QCVu9qQ7IlZ5ewJGbbWQG/
	 Rlp4Rxuy6d5IxWGkN2CaGN3qSuFyk43HvCmCGCPaJ4DtH+nNzfkquNEwTqh0D/UeC4F8f
	 DS55cZIBNbnCqhcZUX/sirsqYKh0mYRxoJphbCx5jROQRUbldSUlRy/VTGsoGJmFSfBh+
	 N3II4SjNvgw7GUYVzUNiWO49/5I4iuMkiKmu3pMEXshZjKBVWugQPvhpoCxygdboeMWrs
	 0XNZCX73G7iwoCwjbmodQu25TTGMwlTsU3QQqHxFEgS6alXMmYjNS1HMSyT0XA6cv3g==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793327640;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
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
	bh=t0qEVz9bTrKFMk2KcwiQ9f6wzKhkZxUNJrUFC8d1bdg=;
	b=ZjXGi9tdZjotWqmFN8sJLE6c81EoStJuAzjiw5gsuoFBvXVm87OFiftmRqONots/GY1F
	 uCLPLdRR6D+1NGMeqrrgYcbw43hW3tshJW+q1OIDw8ySTJizP0YqZWNMQToAa6KSc/VSw
	 kjk6BEnfvXDaR6YMIJdHJ/fDPnTyZClyS+E9ifZhG58kV43zdo56N2TgbUf4mZOylyVe1
	 wYc5TydLxNg1N7NyfoVFlHc9IYsNkS+CXpRdo/4OkSsbElM/E8wpNyq7Ew+0PR50MqyEn
	 L9SqhvJ8m7HGmGsOXxMpYAS/pFmH8BluV49YspPRFYI5ZYGwU6X1prh5S4qN6dtWmsQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793327640;
	bh=t0qEVz9bTrKFMk2KcwiQ9f6wzKhkZxUNJrUFC8d1bdg=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=nHUm2PHBfo0r7T3f8UMMlAAUhsdx2w3DWdTMr1xp/q/r2J9Dr91wX8hdGq7jVLyvJ
	 WAwFoQ68FGz3cCOwl2M/HIsDAOGSdAdNIAY1ZhVV2cqYNLN3Uw+aqhmjNXb1vcG0B3
	 4tYOcL/WsfVNQ4EeTFL7XtOOxqZZj0oJoj85vS1DRF1A2KsJTIVhCsOxciIOV4g9XB
	 E9Jnx4by0DXn1gRfkBAN92gjBZ8FE+NNT+VF1Fq3Tfncuyi0PV8swk+ZPf/ncddx52
	 l1fOte58ZHFxA9rOS+yqlMYIY7OxkUa/POU1G6d2JfdjqzhsOyQLeCoVquHwCIPbc7
	 S8SsaBgF8/t8w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B007A80DD2;
	Fri, 30 Oct 2026 02:34:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 68B9D1DE
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 02:33:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4B83F60A78
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 02:33:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GTVnwss_6AsL for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 02:33:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 89E7D60667
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:238:438b:c500:173d:9f52:ddab:ee01"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793327638;
 b=MvxPCVvvO8c/5ubiYEGWMdfpQjN3RWBcV4oV0qWADfRPzxr9ivzbptilHbB7R3CEi0tV
 11YGgYl5MA5cQTsqiFQ9eG2bpKPaktzSbFzQ78vafIgLfEizLMC9iKrqezX5S1CtuXCjz
 UJf+xskIDtfGERj39eyKwZuTLQb4OrKYGsSf4N5rpWfy5noPqYgHCZWaY/ff2E+HCPCcu
 yvLjhRHbpJwLpMbjKupn4pSkFnfDR7jUyLCO2YXdA/F0fVaMk7Er52D1kl8AQC7hNSKQ4
 JovXOBky4ewbOq6xaBJNllUD9aX9+mxOhrXX5A3XjwxYWOuGfqwej4hZonjTx0vxSTA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793327638;
 h=X-Comment:Received:X-Spam-Checker-Version:X-Spam-Level:X-Spam-Status:
 Received:DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
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
 bh=t0qEVz9bTrKFMk2KcwiQ9f6wzKhkZxUNJrUFC8d1bdg=;
 b=mBrfn5wL/6+kC2MfyR1rDR2ePJqlZtZn7M9e+5jIed1B511O+aSUoaQwrynOYRDOtUx5
 8nnZhoO7dhM2xprlPC+lptn10eNK0YE4+/+lAhgxxwto5KCp4zVZYS63CjhbaxCYJNuZe
 tQZtcSIGZsrFjX7kJAtjmGiR6x1NXCpmgD0E5Wwem7EV2uGChzhDlfVE9dq0/BfQPidGA
 jiZJ3kJm7l2aZ+wuGw+70hYOan02kX4naBjkTVxa/J150/CKVklK/v4eY1KGdL/I7HXrK
 Qq6ig5fDEK3BIgViw12bI+/ptLjHSMizY7C0hMMymP3KBiqqXd8WaoUB7UG/o7jpSjw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=altera.com;
 spf=fail smtp.mailfrom=altera.com;
 dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=LsAp5Y2J; 
 arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:238:438b:c500:173d:9f52:ddab:ee01"
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=alif.zakuan.yuslaimi@altera.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp3.osuosl.org; spf=fail smtp.mailfrom=altera.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=LsAp5Y2J
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 89E7D60667
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 02:33:54 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73F51849AA; Fri, 30 Oct 2026 03:33:52 +0100 (CET)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5AAD4847EC
 for <u-boot@lists.denx.de>; Fri, 30 Oct 2026 03:33:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TRJ/nYMmPL0J8QnQQSJUiwSwtVOU5qkd4YwkuwRfN270IbaMH9Gw88JWVTJ4lFIE43dK40t/aLvpN9obM96iFTYJapjRNsx39olTL4fTSbaN6W6X7Tyvqeg9fdVOQmt8PVsS2hH9zdc04mYr/LwDtDpxpGYduSAliqlnJDkKvCJVCzcOGIYVpjLcu8L6oGmTePYD7MZCRiBjODnr1XoxBx22TU4CPz0dRc3h+gcW/pMzNjwLogv6XCHR1pFBr8/EwzfvtH6l/WYeuHt2EMj5OmMj4k7SF+3b23bhyg2/rB29xYnxLGmArcxptOKITB2EofJa2CH7fW2dwEhVP0qzag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t0qEVz9bTrKFMk2KcwiQ9f6wzKhkZxUNJrUFC8d1bdg=;
 b=pfA+taXQdNAfCMv5IALmqghp7gLWQ1qNxjbOkMCPztXP73PAUXFCMk8YxP3wUXal6XvPQhznmgqFv08kKwyQMT3Ih7MVBav5IoioVvunz3mwu8ZnVg7/bpsIwOtPFdsEsIaiJhGHra8Tt7lnwtm6u+S6rl8iBkjXUcIPw18jOySwUgNYt26znfPGahR80TkEBtP6Ti/NgaENZbQ9sqgULwlkgjMms1E/7LZ2dzV4k3nQabRUX6MaQ0oa2Mzb3oYlK0O27S1iAR1gkmcDRvfMRLgnK3QvlHULaS9Hs3fQIviEi/dS3tvz4We73ZDK1SuktjV2P3AW8W8HIjU1cfjmVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t0qEVz9bTrKFMk2KcwiQ9f6wzKhkZxUNJrUFC8d1bdg=;
 b=LsAp5Y2JrVSteS7plDzj8i0c2dr5nKPQPEoo0SCjXzbGabgow6L9WRzAw2MqbbqPYyVQ6eEnZ1lrQ7DhxSKjv+Np8olG80nDSzKmWlDSdBEtMcgLSdBS6xvoKMwt2igBkncghfVbAIdPL1+YNvC91N9qyHwTLZeAjHFo1WDmlMekFYbLpd7Go7/vANO9jk5frvgkSFykHJJ2f2CrLIjIukDFEr/emlYBU2xlvyEhJe/12iKiY2Az7NoMnEDUDbbikhWKppMO1DxKbdadcIYYcSRZ0YC05SQJudXPSRIMhm/PaWeTkE+9lalvrhcuPAQsaKNVdvm5pRruDlEKR4MklQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ2PR03MB7072.namprd03.prod.outlook.com (2603:10b6:a03:500::15)
 by DS0PR03MB7203.namprd03.prod.outlook.com (2603:10b6:8:117::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Fri, 30 Oct
 2026 02:33:42 +0000
Received: from SJ2PR03MB7072.namprd03.prod.outlook.com
 ([fe80::7d1c:7fcb:cd62:6cd8]) by SJ2PR03MB7072.namprd03.prod.outlook.com
 ([fe80::7d1c:7fcb:cd62:6cd8%4]) with mapi id 15.21.0569.007; Fri, 30 Oct 2026
 02:33:41 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+socfpga@mailbox.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Dinh Nguyen <dinguyen@kernel.org>, Tze Yee Ng <tze.yee.ng@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH] arm: dts: socfpga: stratix10: Add eMMC device tree source file
Date: Fri, 30 Oct 2026 10:33:28 +0800
Message-ID: <20261030023328.29910-1-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0229.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::24) To SJ2PR03MB7072.namprd03.prod.outlook.com
 (2603:10b6:a03:500::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR03MB7072:EE_|DS0PR03MB7203:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f1784bb-88e0-41cd-7d07-08df362e3586
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|18002099003|55112099003|261026121527099003|261021123027099003|10067099003|261022105027099003|56012099006|261022113327099003|261022115727099003|261021121427099003|261022075727099003|261009223027099003|11063799006|261028144727099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: +Gq9Lnk+4bPS/vFDb22ztUOAT70lu9dRY54nSFRWbeRT51F78thY9yWtZtq9atW1Xf50MvnVTdX3f8C5KnND8LYTDxoua/JjRExhBgix1rX5EwHwHw8rSWpBuzYCfMrGBNwWfPIxc6kfK0hFGJ+Jkjb9Uwznjhl1emQzxX5mxnzY7WhFYjf5YE+MdNv9cB05fM5/XO3J333XcXY/rNe5uMQQ+M4T2AzjuNabl+F3tzKX7vDPckKZU7yFhdmKiBAq/EaQtmSow9upr6g/WGbwmTjNVc3bLBhN2x/y0IYv164Fqm0LX+9JUTZcDgR/bcgCLKT4ZOvbeC2epeh598gMQJ0eUk0+JaAasZtG195Y7RT1+U8o55FUh30iQrUYVZeOCyiv4+SjPuEMfESmmGQ48dMUgynh8ispLHhfk/Ihk/kM0mgDssOkVBwDuo6y4yDbjLWwYT2lXwDvzIIcXR1DA0Kxo6dsGqbL7OuBSlKZ7o65HZZsExBENx/64njviH0G0vmZsXgfYoWbuErXDkYQBIsu5FiUyBkyhP6W0W7YgGIVVx7EZIHnx5toT1kAHoh3rXb7ay8A0NeDnYvsf5ojA48iNfy0hIEBn80+n30pvzB+UfNRgD2FFBbGn7lDM93Nd+4bxK0XTxbxZ6UPN3D69wyWiZjGV0/8cvzOnLUScpo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR03MB7072.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(18002099003)(55112099003)(261026121527099003)(261021123027099003)(10067099003)(261022105027099003)(56012099006)(261022113327099003)(261022115727099003)(261021121427099003)(261022075727099003)(261009223027099003)(11063799006)(261028144727099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Kc8dTjrvhaUWL3Zt7ePQ5eya5ERgSrE2cgYXPu7Ak+noiAl/AsX9VLklBdvc?=
 =?us-ascii?Q?9sgIK3eZ+e2PbGm5j+zty/ZY+RsTMB/gTVlQ5aTR4lz9ylRdc6+e2QsZdzXf?=
 =?us-ascii?Q?Qg9BYiQOh6f3eMLRYA33Efh8eOzY1yBkdXtWneYi6Mu+XedcvS/RyOnv1oAM?=
 =?us-ascii?Q?s6enfASndj5H3oT0ovSCEJEsLXgQSM/e0zifWFLO+HlyazotjOZyqo43bLuX?=
 =?us-ascii?Q?AIWa+dDCEh9UNgIZ7cZA4ReQwuUXQaoAvLSIBYf/VCGz4VJ7bpdvvMZun9DM?=
 =?us-ascii?Q?V+zMCaYlwkBLoCrKZ6nnbL0pgwRz+GpHW0Gf65dgR0pO5L0d7jxPSZ8TwaXF?=
 =?us-ascii?Q?WzljKVj9u3qfsTB199XN2ta0k4/kG8RYTMaBbA2NG221xPvm5wF/YSpoK8R2?=
 =?us-ascii?Q?VhdMqsWdjK8wu3gX5f9sQDnW0V77ijRsrWjFm+Tv8lxw7m2dVRqCMwRsWeH7?=
 =?us-ascii?Q?eGnzAbo3pHC8M8nbVKh/CnycOlCcJiZ4zXdZOAdM2s4VYurS5A2gi7oF7t4R?=
 =?us-ascii?Q?2aacmsInyGueKgN6OzEtq98ZhHF+u4bUV+MC1ErMWSPCaOiygM6uCWDy3kqA?=
 =?us-ascii?Q?oeyNtL48J08rZIz4DrS+N52hHY53qD6jgn9yDHGElORzu17Qu86wbO06d1dy?=
 =?us-ascii?Q?K+1tydcnEB6yu0ZpZz8dcqzHfhMq7SjuKvjj9TiQRc1oZA5A0q1jFVwbA82b?=
 =?us-ascii?Q?4rE2HlygYfzg95QVontu2lfg9RDTM+0Gu71XdGVyQi8lz0kYcgbodvbYNXlL?=
 =?us-ascii?Q?geR1ui3S32jKDKM1CMUy6PFsHhnoVjCY1b+yJv16KVCDRnh6DTKbQu50+ziS?=
 =?us-ascii?Q?lCoeLBVvIT4KeDuEz3207GWF5nE9j8BFlOaEf3EAkxeBSRbTsScH6zIZzkPS?=
 =?us-ascii?Q?tmvc9dHsCzVD1g1dFCW/CETn9VCbm0pYI4GN2yue1bKxbbujEkjVUB4+CaHg?=
 =?us-ascii?Q?M54Ohzmg/nO0XaYGELghMh2nGlhc5gbh4gs/tCKBCqFE7kuidqsd6pF3FsDL?=
 =?us-ascii?Q?LITEwuwpof+DSQ2Q8gk621pjWOzB6rnfo45r9+vtI5I6qlYwt7+Sgfows75O?=
 =?us-ascii?Q?Kl334KWCHAPH/24+9HPC1bquNMFCfqeJ66xADCqZKqlUUQI8R+Fv5zQNJ1e3?=
 =?us-ascii?Q?j2VGD5xHsyHqmQnqamLngr2fj3D9hpsijR77v1kQ4aJbm3Chz4wMTJIc0FqJ?=
 =?us-ascii?Q?ZioBCsKSsYnw9f1YTOgwOsTsIupmzBLZchov+mcKih8jY4kNE2pmCVeYtW44?=
 =?us-ascii?Q?H20JB4P54chAbs0U7HmzWF0bByKQCoRX1DfPZ873J98yMJ9WAB4RuKrGB3Ao?=
 =?us-ascii?Q?eYJtohpZPXHzjXtgYxCznElwp+pD2TEFXTx2tLhGVCVZdLYVmoNQ+xGrq0eZ?=
 =?us-ascii?Q?+TG5os+hcwRUhwKV5I7Y2pNH3TgbG1Kf+79ssl6j5q9HYDMUDy3zb859Bf+C?=
 =?us-ascii?Q?eyJEzjmTrFzgG6ybZ1a2khad03n1kD6UNMGn5O3cXNYa0nta1R2nO8rCgFc3?=
 =?us-ascii?Q?cPwDsGRpvZg0UC7HfFtQDDuf5W1vJLoNIiL8bTYumCkX5kcjjfUtlCM/OH5Z?=
 =?us-ascii?Q?yWu596PqdlhaLvsSo3/dxy+4jj/oRlXrsCn3lv+3yWIlmrI1DOKmTxYye9Nc?=
 =?us-ascii?Q?oRE4+FjaM62TCEFUv5r6Xxyc4jk9etNbGFQgQ+9ya/rYaZ9k+2SAmnhYUrxS?=
 =?us-ascii?Q?u4KQrlw7vsLXnhGEqVOe+XTyn45BLkBLG66OA3ryARW1muVB32B7iblHRKWa?=
 =?us-ascii?Q?ll5cpG3iMYh5lFOuUXIW7QdaKT+NqYg=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f1784bb-88e0-41cd-7d07-08df362e3586
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR03MB7072.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 02:33:41.1988 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oBiRsQ1P0tvArQgWCwsD9EoTP0/aW3EGVb8goW/4r0GdiRPLhQ2kTMDwBP2O5YiWs/pnp64wUM5J/5e1frqYeQTpsBtCcsHIrL16sB6hlmU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR03MB7203
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>

The Stratix10 devkit supports a separate NAND/eMMC daughter card.

The NAND/eMMC daughter card replaces the SDMMC slot that is on the default
daughter card and thus requires a separate board dts file.

Disable gmac0 and enable gmac2 so the PHY on the NAND/eMMC daughter card is
used.

Utilize the upstream kernel eMMC dts when the board ID in the handoff data
is designated as 2.

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Signed-off-by: Tze Yee Ng <tze.yee.ng@altera.com>
---
 .../dts/socfpga_stratix10_socdk-u-boot.dtsi   | 24 +++++++++++++++++++
 .../socfpga_stratix10_socdk_emmc-u-boot.dtsi  | 14 +++++++++++
 configs/socfpga_stratix10_defconfig           |  2 +-
 3 files changed, 39 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/dts/socfpga_stratix10_socdk_emmc-u-boot.dtsi

diff --git a/arch/arm/dts/socfpga_stratix10_socdk-u-boot.dtsi b/arch/arm/dts/socfpga_stratix10_socdk-u-boot.dtsi
index bd585d96bd2..da19943ec3b 100644
--- a/arch/arm/dts/socfpga_stratix10_socdk-u-boot.dtsi
+++ b/arch/arm/dts/socfpga_stratix10_socdk-u-boot.dtsi
@@ -103,6 +103,18 @@
 			algo = "crc32";
 		};
 	};
+
+	fdt-2 {
+		description = "socfpga_socdk_emmc";
+		type = "flat_dt";
+		compression = "none";
+		fdt_2_blob: blob-ext {
+			filename = "dts/upstream/src/arm64/altera/socfpga_stratix10_socdk_emmc.dtb";
+		};
+		hash {
+			algo = "crc32";
+		};
+	};
 };
 
 &board_config {
@@ -118,6 +130,18 @@
 		};
 	};
 
+	board-2 {
+		description = "board_2";
+		firmware = "atf";
+		loadables = "uboot";
+		fdt = "fdt-2";
+		signature {
+			algo = "crc32";
+			key-name-hint = "dev";
+			sign-images = "atf", "uboot", "fdt-2";
+		};
+	};
+
 	board-4 {
 		description = "board_4";
 		firmware = "atf";
diff --git a/arch/arm/dts/socfpga_stratix10_socdk_emmc-u-boot.dtsi b/arch/arm/dts/socfpga_stratix10_socdk_emmc-u-boot.dtsi
new file mode 100644
index 00000000000..c63ca3fb9d3
--- /dev/null
+++ b/arch/arm/dts/socfpga_stratix10_socdk_emmc-u-boot.dtsi
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright Altera Corporation (C) 2026. All rights reserved.
+ */
+
+#include "socfpga_stratix10_socdk-u-boot.dtsi"
+
+&gmac0 {
+	status = "disabled";
+};
+
+&gmac2 {
+	status = "okay";
+};
diff --git a/configs/socfpga_stratix10_defconfig b/configs/socfpga_stratix10_defconfig
index 55050705bd4..1864bebea30 100644
--- a/configs/socfpga_stratix10_defconfig
+++ b/configs/socfpga_stratix10_defconfig
@@ -57,7 +57,7 @@ CONFIG_CMD_UBI=y
 # CONFIG_ISO_PARTITION is not set
 # CONFIG_EFI_PARTITION is not set
 CONFIG_OF_UPSTREAM=y
-CONFIG_OF_LIST=""
+CONFIG_OF_LIST="altera/socfpga_stratix10_socdk_emmc"
 CONFIG_ENV_IS_IN_FAT=y
 CONFIG_ENV_IS_IN_UBI=y
 CONFIG_ENV_FAT_DEVICE_AND_PART="0:1"
-- 
2.43.7

