Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF09D606A320
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 09:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=tPrP8EiC;
	dkim=pass (2048-bit key, unprotected) header.d=nokia.com header.i=@nokia.com header.a=rsa-sha256 header.s=selector1 header.b=XyxZPcFn
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 84AE780F34;
	Wed, 28 Oct 2026 09:03:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U9zQ27gOrD7o; Wed, 28 Oct 2026 09:03:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C873580F2B
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793178204;
	b=lOoabD22rtpyD2PxqBjVeaMlg6939ghQwe3pOBpuAYAQerhTzWHLWRFsGeXrWJS9CMOg
	 vGcKN7OyR0sN7SRWLZ5i8GuKi+5oaqX+8MAL0n0TI5JbF8WsvKS0CCly5G8Ml/H0qSMou
	 5kojr0AtxSY1bfijlu9grUL1/BUKVs+QWcQZjSbsq65Y7PYmwgEmbh4E0FwaDGMOqxX1J
	 lhijfkgFB91bsqdTFVkvueo2CntBKUTAY6cz6InGFXWo2GHb0tDaGgffgVtcGhjm0zskm
	 SRdrfiS0pYIda1575rvKd3FHnFwHy/BWieWG+WY/MbmxgAY/C52gJSLRzyL8aALgaog==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793178204;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:From:To:Cc:Subject:Date:Message-Id:
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
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=HJjv2UIBpbxK8P5bd3DqQTSmVxkqZ8sMVczxxL48E98=;
	b=K5inrUpo5NBZqE7nVEacCKcVBRAFQd96X7b/658+0zrTTiCnGna3rWGbNA2TCHvsXGrz
	 QHgm7FGixRc+WODTmxTRNuNEixFopuiFjIXBDuk+vy9+DrSM7dFuIkXCxSGSV0hMMVXF1
	 gVC+v8SaeCxpwP0uHHPzagFyU6s/thdSgmEWc4jcCMebhQ/MER4N7f+wH8ejYdHcg7Dot
	 uVunFZrNcd/c2XYshwjd18/H6vPSyESsbcN89VWfyD6gffl2I4f1UutFEb9WkzC6ZHhBF
	 6ZRB+35XHg3HhyDbrBmBY5Mx/WHtdjjMcu409m8lv1eWG8xqrINeoLoIdBsDMbb74Ng==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793178204;
	bh=HJjv2UIBpbxK8P5bd3DqQTSmVxkqZ8sMVczxxL48E98=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tPrP8EiCpuAMOwGEB+X53DSsPglx03to5/vmCN0YTGMEe4TF8ylcGS4087pd8r9SE
	 7zSlKCvOfGwVqRTK62J2wPdP2OdLiCdfS+iP7fCdmcY2rOBE6sPPJXOYcpUjwzc1Uv
	 B45bbeXy+OE1j7BFRfpsnStYDz6DFUChI5dt4px7tnikDtkMIrlHE7fR7zeMYVNgF/
	 v1PEVThD7QJIejMCmljNfxym6t3OlSV/jgfEOlwwB1cFADCsoGpa5B5+7LxtGs9UR8
	 xR++4ga826UforDVpwcxDV1y3L79aQ8wpKefoOB6IpC+rmFnUQUSx4rCMLEWm2Ilq4
	 bMaGHj+TXBAPw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C873580F2B;
	Wed, 28 Oct 2026 09:03:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8B5DA529
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 09:03:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7CD7660658
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 09:03:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id quAmaYsUkqHT for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 09:03:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 692AB60600
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::5"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793178202;
 b=HEwFK5yu29aReM061w0JYahmMQJAZGD+3zB6Vt3Ncjx4LjjHlQpsGHX/6/0BUWqtvrWv
 vS/jyb7UXKE0pQki0VCZ6GxU7yttMi4Chkl/W2rediQLeDWo8SrPWaoXO9PiJVemEDmAg
 63pDXEkU8Eo/zZx1apSO3PBoowzf3FonT766d3ER7wY29eO9AakcU4EXqUL1Nta3NoKld
 BGUPB7Mhg0peTdkhnasvC5KbxQrSA9bFsXnbDM0AwHUepCwqHRGoKrUYh/PQbtjS1sJgX
 0Emsh6xzrqKMArdg4S9zkc5sTNwtwAMyZzxdfZjtZLwByhicW7P2XY5YbBkSlROcd2g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793178202;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
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
 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=HJjv2UIBpbxK8P5bd3DqQTSmVxkqZ8sMVczxxL48E98=;
 b=RuTiSqxeS4ophM7WC8Z23zLx2TIoAYOYskD2lIcu/g+s7uH/pvhRX3IaLNJpk2Hi0oMJ
 SjtZnQRpW0xw056L8eJtXGQ2+OLNbViWA8kZuBD+ULONo46E2cWZ/UnO2pxpGYWIq0DaF
 ir4SXBVciK4sqiwSK3/KGHZRM2HQLyTk2D6Mx/A72sVM7XHSxNNVYnBrWABSvJ0yDuxOx
 OhxtGWjvqIhUYbOFPI8RBcAokyNfgIa+l2In+n0u+VL9JQzUcJiJq+sKGBXXO3jQ7MzBF
 l+22hTcP2/prT6FmJDopfoAqlfSz8UfHpaS4lBFnu/bIlicU5TWng6lFTgEQj1bXaig==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=nokia.com;
 dkim=pass header.d=nokia.com header.i=@nokia.com header.a=rsa-sha256
 header.s=selector1 header.b=XyxZPcFn; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c200::5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::5;
 helo=duzpr83cu001.outbound.protection.outlook.com;
 envelope-from=juuso.rinta@nokia.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nokia.com header.i=@nokia.com header.a=rsa-sha256
 header.s=selector1 header.b=XyxZPcFn
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 692AB60600
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 09:03:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O+1IjNPOAmoXnkGvzRjpyievd4BL3B30oVyG2vlneFDihX3HsabzoqNRXWtvflKPtA9sXKId6Zi7w3VTSYfvigsnILCyoDecpwTkSOsaX0YGMqlir5tWRTfkJteaLclAqBLlsum1yL4YMO1s01NiBVGpQ2uhwSTG1/xVJINErUmKWysxKUHHCHIzQq8+3cIRvszIHl8oyvmvocmj64CVsVmLSRRjayNZbk1iiNKnpQvAi03OGSSo/N0xC1bGOwDMMryXmiqs32tF6cvtwnckgWPF2aQW7mnsgvOjqo0zADVIJfYB+MveG0+LmtkaeqB6yTwcwPsNCB1Nprx3/ucZsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HJjv2UIBpbxK8P5bd3DqQTSmVxkqZ8sMVczxxL48E98=;
 b=sh8ZgmcUHB8rv0c0vyeZi2FmoRG3Vf9mnCK3S+qTRz9MWaOEV24lARC8ImLcVMzyEygNh7BNiqAQx0Bix99iJJ3CovDU4DZ6Q36ILNvKDgk6Xvhn889b5yLSP2l7YQ6zZ6Vb/Z27pbgbr5wKbNjJmmF5SenbAGPvvEri2DZjjU6svpR5AVxWwIR3aN2So7FnaFoGogVqYA8UMPgjYo3xah3+jTCnzh95kTdaBBQex720vqIn+hiP1fxijRrgtHn1+O6ROHBjFEbRMxeMks6pT/8KyTV/86ONC5Mp2uQ3is4Z31EpRTGbT3ww5Y4Jbd/7BHGrO8MU2IjNkoNeMOJabQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.30) smtp.rcpttodomain=chromium.org smtp.mailfrom=nokia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nokia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HJjv2UIBpbxK8P5bd3DqQTSmVxkqZ8sMVczxxL48E98=;
 b=XyxZPcFnBJsSRIuxJmNfFEt9Q5KRw6M6ANaFvLicmUEbP/82rmYPN8iXCNBvMDVXUrCBnLqmmAhK/Tr4elcDnqWVuLzz5jd+kStbbtE139DkI47A4+aJhnPbWkel5Btu/1qRBSg7MPaxaVpY3BLjGV+HlZ2rXvQi+/9rERvby5hV6xdzokbnfaJxHkNYCv4aBOTNY1H8O9UjFGmXb7RTXqeeQP+f4uEwZQrXm880WrnwInDYyD3nE+a/1t/FCwKtp93VNJ+lYcBDkYQVOCZVhJ2kNwhVdYmg4Z/ss+SGxeDsUXTAO5x1WvR0qGlvD9Z+ISsp0q+T0/VV8Fzr8mFZHw==
Received: from WA2P291CA0046.POLP291.PROD.OUTLOOK.COM (2603:10a6:1d0:1f::15)
 by GV1PR07MB8997.eurprd07.prod.outlook.com (2603:10a6:150:a2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 09:03:13 +0000
Received: from WA1PEPF00009B3D.eurprd05.prod.outlook.com
 (2603:10a6:1d0:1f:cafe::3c) by WA2P291CA0046.outlook.office365.com
 (2603:10a6:1d0:1f::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Wed,
 28 Oct 2026 09:03:13 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 131.228.2.30) smtp.mailfrom=nokia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.2.30 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.30; helo=fihe01smtplvp01.emea.nsn-net.net; pr=C
Received: from fihe01smtplvp01.emea.nsn-net.net (131.228.2.30) by
 WA1PEPF00009B3D.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.4
 via Frontend Transport; Wed, 28 Oct 2026 09:03:12 +0000
Received: from updev-hifix-1-5g.devops-fwk.dynamic.nsn-net.net
 (10-175-3-186.he-pi-os-dhn-100.nesc.nokia.net [10.175.3.186])
 by fihe01smtplvp01.emea.nsn-net.net (Postfix) with ESMTP id 4AF6D80000A0;
 Wed, 28 Oct 2026 11:03:12 +0200 (EET)
From: Juuso Rinta <juuso.rinta@nokia.com>
To: sjg@chromium.org
Cc: jonas@kwiboo.se, jonathan@joggee.fr, juuso.rinta@nokia.com,
 stefan.roese@mailbox.org, trini@konsulko.com,
 u-boot@lists.u-boot-project.org, yuriz@vodafonemail.de
Subject: Re: [PATCH 7/7] test: wdt: add tests for wdt_get_timeout(),
 wdt gettimeout and warning print
Date: Wed, 28 Oct 2026 11:03:11 +0200
Message-Id: <20261028090311.2509067-1-juuso.rinta@nokia.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <CAFLszTgi50TT2pFmGHNUpN7qsBdD2PKWEj=wR_DCFNX4-z7p0g@mail.gmail.com>
References: <CAFLszTgi50TT2pFmGHNUpN7qsBdD2PKWEj=wR_DCFNX4-z7p0g@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: WA1PEPF00009B3D:EE_|GV1PR07MB8997:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 57b8a65f-8298-4ba1-69dc-08df34d24bc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|23010399003|261021121427099003|261021123027099003|261022105027099003|10067099003|261026140227099003|6133799003|18002099003|56012099006|22082099003|261026121527099003|11063799006;
X-Microsoft-Antispam-Message-Info: wQ2B+qnZ3fzmuxOnxKuKM9TcYZubFFrFcHcjDpK+PbbWeF6Hb81hwGXY/pPcLXwRrytCcDoPr2lMmjzj6ETbdEqrMQ+YbKsQY2rej+MYGBkwF9nCaSe1gIwaZ/EXkzGfWOA8HDQUn/svHgRqaS+XBKTcnTqicpEJkHLIBx1B0RTmUtusewEM+mV/0lJB93NpivSyIUdgorZlk2LYUClp63S5EDmlvTSyms0O/ohATPpkCSZ0nEJnfRejIT8ibo4vmvZMEe4oKzyAWg8dxIlbnPLMv1a9c+BPiGT5yOlOUU3Pt5JBNO+9NfbHEN88+WAVpdUjWdv+PlMoX5ATc/WYhAdKPQ5ei7ksu6ZRkmX+CHP4mhAqUqIMlu3G17fSvISswKi2HZlztSlsJrLcPntO52K7WEKvCYA+/1MPl4RfqmS04ol78Nad9JQuZ0qaAVzirsRAsBHLALxg4yscZDT492r6AWPdwJxwbePZ2zHaok4ijNsCb2ozlon+qpxXT9tkA+YCDnWNUJH5zCT0AkM5iSqS89qgIsJj0ZSWDVku51I6Pk8wf7j3RLu6VG06p7qz0L9aXvJvBZLw9KCSU4ozHAHCQ6smWyFtuSWwf8pIED0V0e9eJs9qVfFBVNlqSzMfHhJ0YHkDSJRRszH/JzOzEiUshV4yLM7Fp0Gr6W485jJyT4NwUu4JUyeqXNbjhwOk
X-Forefront-Antispam-Report: CIP:131.228.2.30; CTRY:FI; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:fihe01smtplvp01.emea.nsn-net.net;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(23010399003)(261021121427099003)(261021123027099003)(261022105027099003)(10067099003)(261026140227099003)(6133799003)(18002099003)(56012099006)(22082099003)(261026121527099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bvi4ZmxMXMuG6EAFgvvglrZtjHM3Fmdo0oTuxDUQoifFX7+zRTQoD93Jo1B+LILgN3JWKZpwdjOBMmWYuYi6cig5/rhAo6r9aAD2vqAn7qTU13/BxFiOHHVpIGwV7LlRgV1IxLLVxW+Q4Ik8vVb/szcPtOU1GiaC+4cfHmlARLzuX+Cs3BKY4cwe52k9aWg/ImOTmUYi0AXwvkk8EvHCIhOEHzf/9yxAtomPDi53TJBET2IRabS9i2H0GUBYEsYz5gFk/M2/k05sKzfAHpl7Tqz5/FwtCTMx4dGyhFIjw9EVuaD7C3bFSF7Sl8vwQ9PpX8uRwYiJCZovkFgirJX2nz834K9gLXRevl8iqAoYnJ6gAOnd125FPjHbQJrlbHzK9tW3q0NiHLNI6qzyVLNQnbg8L8vTel2z8NDXgstwEYiuYAQagucryoBpBM+BT+xQ
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 09:03:12.7892 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57b8a65f-8298-4ba1-69dc-08df34d24bc6
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0; Ip=[131.228.2.30];
 Helo=[fihe01smtplvp01.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-WA1PEPF00009B3D.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR07MB8997
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> dm_test_wdt_base() is getting long. It would be worth putting the
> get_timeout checks in their own test, e.g. dm_test_wdt_get_timeout(),
> and the 'wdt gettimeout' command checks in another, so a failure
> points straight at what broke. What do you think?

Will do.

> Just to check: cmd/wdt.c keeps the device in a static 'currdev'
> pointer. After this test the driver model tree is torn down, so that
> pointer refers to a freed device, and a later 'wdt' command without
> 'wdt dev' (in another test, or at the prompt after 'ut dm') would use
> freed memory. The command already has this problem..., but these are
> the first tests to set 'currdev', so they expose it.
>
> One work-around would be to clear the pointer at the end of the test.

What do you think would be the way to go here? Since currdev is static in
cmd/wdt.c, clearing it from the test would need a small helper in cmd/wdt.c.
Alternatively I could also replace the static pointer with a static char
currdev_name[64] and resolve the device by name in each subcommand, rejecting
names that don't fit. That would fix the stale pointer in the command itself.
It touches more of cmd/wdt.c, but I could add it as a separate patch before the
tests in v2. What do you think?

Regards,
Juuso
