Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B1D606A329
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 09:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=fpU32VPp;
	dkim=pass (2048-bit key, unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-softathome1-onmicrosoft-com header.b=qouoNzLb
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A115B8083E;
	Fri, 30 Oct 2026 09:48:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MF1WmjhKsFBQ; Fri, 30 Oct 2026 09:48:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BD7ED80530
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793353712;
	b=oDATVf1X94+LiVWl4OCAPHV9Ygq1EF0ZlhPExw74RjB3VIRM8tjnU/znvc1UuLX/dlBS
	 B/CzuBZjoYpkGAsqa5QAZPC5L2OBVZh/ZkNDQFbQNlEcGXSANg61cQ9KjYI58OskcPkAP
	 MfAQ5M/5uFeC2Ur7WyANSUQOUUgullQKf6hKwf2/QjevmwcwG+3l5rB5PlVwFZomtL0oF
	 560esYecqCyRwxGkxPS/WKtJ8FrT1rWB4lmrCADKMtiRwFAyQ73rUnTHZS3Nb3e8ty8Yo
	 og4Q8AvuuBXMHm1H+V1dAhb9mk8okmvfR1Nq1J4VqdsrHYoUzjEDtn6DnGTs10XuDCw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793353712;
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
	bh=Ymlp3uL+6cTcIY8YSGiAggCpVRa2gW89+9+Mg7mvrds=;
	b=KBkTwKA/3qr55Hwvew/v1+bm4zIR5CoFwGXQXjbQCtrPEuPKv49ynFncFibIYQzjGvud
	 +sPRszJYM7KKgdnQrFTb8fZq0AlFRdqLZtZ5FeZweLif0v/MCHL+q8sHv6tlvxXxbREY5
	 c+8XjTnImybPXT2BT5/y6avYaEY8CD+cVL6gwBrW4RlOfj/VK4bSbqSopRfXeT/xvvz89
	 IOSS+fOY51n3opuh/qFkiw4OJk9BjMAcR7GUkOhSk8/ZjKRF4/bhWQx8UTpunBosdKRxW
	 ebTLRDJsj2lFfBjYqxDz9q8TTdYM9yKiYYcAvMBaBoTKOeTK0GgEW8TQ/C3q71rpwcA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793353712;
	bh=Ymlp3uL+6cTcIY8YSGiAggCpVRa2gW89+9+Mg7mvrds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fpU32VPp1Fk9syvZYA+TJaVPYLVbyKf5lFLU+Oncxqvp3QJUnQX4JTPHktvV3bBoO
	 9oF4DIgHipeQQXZR09ow7vWcHEa8odLOBHKZjaCvnLk862RUO/4BJu6IXk4q6MC3xt
	 LWEwQkoN933QoyvtvJbKCyBQBDuceDn3Y2meBS8PkRSYv4aF7Iwqtoobc3+G72XjCq
	 GNYEYuEdeRppMmUxNyL0VPF1PEHGac1Jx+V8kh71Cxa1lI2+YNUhdaYMGCP4N3yB4+
	 dTo5evLZpVSluHDUrSP91Til03hKToXtVMBU6nYlS2HVYOuvEhp7if8oFci2m4LNoF
	 DH4rR/e5CTC6g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BD7ED80530;
	Fri, 30 Oct 2026 09:48:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7619D2C7
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 09:48:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5C110400AF
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 09:48:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UIJkGOWRkssr for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 09:48:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 8009F4009F
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20a::2"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793353705;
 b=nmDXMAWKzbCUm5afGqNcr7yMrkLm+HfP5obu0lerV8WcaqUYJtgHIJ5omNAgu3yzOLIs
 6ixlzpc+fyImPQxlYQbLkknl7TYPTLhDNF9JUq/u74B8SeIhG+NFT++CmO4cVC24Rp6oX
 cZV9LEcYOHXOGkETznZAxWNUsJyCCDj+FvsUIQBmoscEICA1iuy3Yrdvd0T7z7KNAx1gY
 +2wIhFAc2URnUlg00rK5lC16lSF3J+STxFxebjUo5e53zv/RjPIWI7uc05KmAcS9DUmkj
 p8FUXDSxqUl+JfgwXue583W3CH2JCifuM9cW6M/hGGaENP0wsRNfbgTwOdHLMvbmceg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793353705;
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
 bh=Ymlp3uL+6cTcIY8YSGiAggCpVRa2gW89+9+Mg7mvrds=;
 b=qEc3ps9WaLe6xUDWJYanijepOn8aO2NlME1PvJxzaOV+5naMvld5RmOXceuXAzSbgNsv
 gk9esCRl0HGEN5gx0rBPzn64AGXXbPBa675F3q9mKp3L+Xbj/q1vXQUUtx69pKzfiDp5L
 q7E+3WBF3ePMvHBfH0PMMJB34ru0EKfqoe555fwfekd5nX9wqgNthi+/KXHarx7gkbJNi
 6vzrbZ2I6MhShSNB5uox3g+b7n4IKQ4xh0HF0mVmx30BWzO59HhrGm71bMgMXFFKnCTOn
 +c2KJDLoKjmhDhcgXw6+9sasmZ3/cjvcWL+Ap1WSLDhZAn0HsZBrE/rpySBHr5XpMMw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=none header.from=softathome.com;
 dkim=pass header.d=softathome1.onmicrosoft.com
 header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-softathome1-onmicrosoft-com header.b=qouoNzLb; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c20a::2"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::2;
 helo=paup264cu001.outbound.protection.outlook.com;
 envelope-from=yan.wang@softathome.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=softathome1.onmicrosoft.com
 header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-softathome1-onmicrosoft-com header.b=qouoNzLb
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::2])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8009F4009F
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 09:48:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WIgjfsifpsYgFoSfKRsqgVffGsoyvaZXOUHUa+7EY8FPqKLzvj9w4kA78k3Tj/UmTGsOYc6efAXYsvpuNM2SQPCXuhyimh4MZyG2s8N7KnAric/B+HGjw/Whq/CtZYS5WNpmIIecikQ13FBEpFCuG9F2825joInUs7m0843RO6GO4N53yRPV2ydzqsRH8D4wNvyR/GxNiBE7CVwRFnl7aCBkiwsm0I37QZ/fsjsqpK828uGMS7o5L0jeo31xuXCZbLLgOalr3U9d/Gwwn7T6WRFxIEP+wVk/1kuVLASXkaISfSsO+f61cZnwOhymi4p//vgcRn+kSWOy3vI+T/W2dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ymlp3uL+6cTcIY8YSGiAggCpVRa2gW89+9+Mg7mvrds=;
 b=c+Z3GzSab7aVaVBr4Q65vxdramLY24jr/1jWiF2MLY3yqpKehvsKM+ufHc0A74uyYvSqFczPAEbgfHOyz2afS9ZgysODSU8A6Dadh4YvNxRig94XoJclFmlFE3QOZUUUNJGLuQ4NOTa2D4lMkEB6RNCctAMm0LZWdvYgMA1XrLASQBb9s6sKGttzZytG91X2Jj0c8ynDzAp849WuoZ++QlTvwIkJE/Jr8yUgvFSEKSDvtKd67I0e5zy4k4yrmeS0qPnPQ4Y+YmWPVGuvbf0EbX7htb+hdVXglC0EiAkJZHkDBzj4ATvaSvkQfD8SH9HG3H/7Wli224fv8hXvE+qDlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ymlp3uL+6cTcIY8YSGiAggCpVRa2gW89+9+Mg7mvrds=;
 b=qouoNzLba1tWv0fcK/rcxbfhH34sxNnmCCOhz6hbhUCgnaH5lEljVFacuN2gOamqnCop75zOCBbeta65k5c1TU6h85jhIpLvXTjyMkeZFpPtPoc4HmXRhoRIXpTCbIj+Xx8KNZV3WDflUsxWDd6lPI7Maxzq9GMBJBZGOEoz3edk/JUIg16Qxt6pV/31xmx2q5aC3qupg5A/9Zx8mW0xOPSUcJ1q+2bXJBEJ8n7VE6e5eU/qDdgofBVJi+Kv90rDiqeGKARhfljyR3hEm3FLKpxA0rZfiB4RmWbbEo0h7jyl46RvehMUojwyk05Yt+yN+Hd4jUH7nODSBnQ7BRlYAA==
Received: from PA7P264CA0173.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:36f::9)
 by PAPP264MB7901.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:546::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 09:48:21 +0000
Received: from PA1PEPF000CC3FB.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:36f:cafe::a4) by PA7P264CA0173.outlook.office365.com
 (2603:10a6:102:36f::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Fri,
 30 Oct 2026 09:48:21 +0000
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
 PA1PEPF000CC3FB.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.4
 via Frontend Transport; Fri, 30 Oct 2026 09:48:21 +0000
Received: from localhost.localdomain (unknown [192.168.72.182])
 by proxy.softathome.com (Postfix) with ESMTPSA id 5B46C1FD7E;
 Fri, 30 Oct 2026 10:48:21 +0100 (CET)
From: yan wang <yan.wang@softathome.com>
To: sjg@chromium.org, alpernebiyasak@gmail.com, trini@konsulko.com,
 alchark@flipper.net, paul.henrys_ext@softathome.com,
 philippe.reynes@softathome.com, marex@nabladev.com, raymondmaoca@gmail.com
Cc: u-boot@lists.u-boot-project.org,
	yan wang <yan.wang@softathome.com>
Subject: [PATCH v3 3/4] binman: pre_load: Require key-name for file-based
 signing and fix integer division
Date: Fri, 30 Oct 2026 10:48:13 +0100
Message-ID: <20261030094813.82199-1-yan.wang@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAFLszThYLvoUzxdhBLyJgAjy4DnAFxsyMVgrmFp=7zhNP792og@mail.gmail.com>
References: <CAFLszThYLvoUzxdhBLyJgAjy4DnAFxsyMVgrmFp=7zhNP792og@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA1PEPF000CC3FB:EE_|PAPP264MB7901:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 4570826f-784c-4041-db0b-08df366aef19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|1800799024|82310400026|18002099003|22082099003|10067099003|56012099006|261021121427099003|261021123027099003|261022115727099003|261022105027099003|261022075727099003|261026121527099003|261026140227099003|261028144727099003|6133799003|261009223027099003;
X-Microsoft-Antispam-Message-Info: 3Z2BMH6RrepwpyizEuHZxC2qWwxUputmIH3pMKXLwD7PHAUbL2pXcKIBDkbclfldG0LineWz9Sc7+MpkmFbQTmlngRGLV/BpTn7Wf4JUI7oBaMWwi31bdnw9l57W9bTCNMwaK1xsR8RxwKMMxfafCFm7BwGCJZXLfLCVm7K0xGKJvBrh4osu1RHcNkr0bWr6mngqQGpF+zsmveDsUNkIXPiOJA7ZMfso6Q2Ln5vkL4p9JVoQS72NKpXCIH+NawUJ5eX9CXnuu8eZTEZjAYSUveKUqLibNccL3a4xGbjGJKVgN5lujz/OnRv7GwE6K0B/mPJAZeNxtcTmnIf1K3eKstOiGMPyg0uhyTBEiNzze8y12/IXAX6fjLd2e6dneB8i1UKvRqmSaL2GSIcEPDcABX2lJTRidDMXMSQFURXHT4ji/0RnYCfpEISfB8nZO/ZFvGhWzdOzYTpfLfI7INe+UpTvHPI3isSD4TR3oIUjbRKmCxpWc8M4ZbF1Nd90S+n3tJ9uWZ7vgiNFYwK5dcw5DShJTzIMeZQ1FLjL9izQ7FcPmz3USEo6n4aPgpjbv33/HJZby6mglXiF5Xc3AzkF0ZlQTb4eSDO6KwDkh3d12lNjdeMikHzXY1INg3vEb/wp9gD2MypeA+otrwKnUZRIxg0YDD/1MUaWi7a+sJB8LVt0p0y08E7BLD0apchQrDPFpAWxmU2x4V2MKJl9xSFALw==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(18002099003)(22082099003)(10067099003)(56012099006)(261021121427099003)(261021123027099003)(261022115727099003)(261022105027099003)(261022075727099003)(261026121527099003)(261026140227099003)(261028144727099003)(6133799003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: eOE8F8nrHr2xlKyDTwubFmccHWKBcAQDPsbT/Vl+7wruIS+Cc/pxlpKGJ0Obcuc/kXpgkQsyrh2i2odyfj6xqZaNTBGOmoAMX8hcoz1qv81DpdWq419xNHidFdK6mAFo/89kZZHou7QPT21fJbkOSZw+4o1767TZA+WAvW581aPfGB3WjtR1NJG8CwkZMkA0hSYMxG9y1eOzwALHsUKBnNjQITRMB9xoB71zFnOs/twcpAqOUubKQ35tGjAchBpHSD1LBPnmZOoflM59xuOe/Bf2C5Bul2strcRt6kpYAkATJaDWp42m5TJ2tC7Uv/YAD89fTaNlqICOgP8byqk9D9f1gi0/445ashAkeI04zGKLLUHDtWSgv6afob+eTvSAnKNMTmVel+hec9TfHt3fuj1P6UoY7Wj499oSWepqHONCMipvefUSrcbeBHWHlH5h
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 09:48:21.5285 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4570826f-784c-4041-db0b-08df366aef19
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA1PEPF000CC3FB.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAPP264MB7901
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

Without a key-name property, os.path.join() is called with None and
binman fails with a TypeError traceback rather than a useful message.
Report a clear error instead when file-based signing is used without
key-name.

Use integer division for the RSA and ECDSA signature sizes. Using //
gives an int result as semantically expected for byte-count tables.

Signed-off-by: yan wang <yan.wang@softathome.com>
---
Changes in v3:
- Move to position 3/4 (was 2/4 in v2), after the HSM signing patch
- Place the key-name check in the else branch of 'if self.hsm_key_uri:'
  in ReadNode() instead of at the top of _CreateHeader(). This is both
  earlier (validation happens at node-read time, before any signing) and
  clearer: the else branch makes explicit that the check only applies to
  the file-based path

 tools/binman/etype/pre_load.py                | 15 ++++++++------
 tools/binman/ftest.py                         | 11 ++++++++++
 .../security/pre_load_missing_key_name.dts    | 20 +++++++++++++++++++
 3 files changed, 40 insertions(+), 6 deletions(-)
 create mode 100644 tools/binman/test/security/pre_load_missing_key_name.dts

diff --git a/tools/binman/etype/pre_load.py b/tools/binman/etype/pre_load.py
index f264146d62f..32aa10bc057 100644
--- a/tools/binman/etype/pre_load.py
+++ b/tools/binman/etype/pre_load.py
@@ -54,15 +54,15 @@ def _parse_pkcs11_uri(uri):
 PRE_LOAD_MAGIC = b'UBSH'
 
 RSAS = {
-    'rsa1024': 1024 / 8,
-    'rsa2048': 2048 / 8,
-    'rsa4096': 4096 / 8
+    'rsa1024': 1024 // 8,
+    'rsa2048': 2048 // 8,
+    'rsa4096': 4096 // 8
 }
 
 ECDSAS = {
-    'ecdsa256': 256 / 8 * 2,
-    'ecdsa384': 384 / 8 * 2,
-    'ecdsa521': (521 + 7) / 8 * 2
+    'ecdsa256': 256 // 8 * 2,
+    'ecdsa384': 384 // 8 * 2,
+    'ecdsa521': (521 + 7) // 8 * 2
 }
 
 SHAS = {
@@ -239,6 +239,9 @@ class Entry_pre_load(Entry_collection):
             self.hsm_hash_name = hash_name
             self.hsm_sign_name = sign_name
             self.hsm_padding = padding
+        else:
+            if not self.key_name:
+                self.Raise('key-name is required for file-based signing')
 
     def AddBintools(self, btools):
         """Register pkcs11-tool if HSM signing is requested"""
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 8caf275d466..d4522e905e0 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -5981,6 +5981,17 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         self.assertIn("Node '/binman/pre-load': The key ecdsa521.pem doesn't have the expected size",
                       str(exc.exception))
 
+    def testPreLoadMissingKeyName(self):
+        """Test file-based signing with missing key-name property"""
+        entry_args = {
+            'pre-load-key-path': os.path.join(self._binman_dir, 'test'),
+        }
+        with self.assertRaises(ValueError) as exc:
+            self._DoReadFileDtb('security/pre_load_missing_key_name.dts',
+                                entry_args=entry_args)
+        self.assertIn('key-name is required for file-based signing',
+                      str(exc.exception))
+
     def _CheckSafeUniqueNames(self, *images):
         """Check all entries of given images for unsafe unique names"""
         for image in images:
diff --git a/tools/binman/test/security/pre_load_missing_key_name.dts b/tools/binman/test/security/pre_load_missing_key_name.dts
new file mode 100644
index 00000000000..262219fb6ab
--- /dev/null
+++ b/tools/binman/test/security/pre_load_missing_key_name.dts
@@ -0,0 +1,20 @@
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
+		};
+
+		image: blob-ext {
+			filename = "refcode.bin";
+		};
+	};
+};
-- 
2.43.0

