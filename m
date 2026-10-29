Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DE8606A31C
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 18:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=m6tIy28S;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=d7mNUG0J;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=eqyXsvuY
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2E8348105B;
	Thu, 29 Oct 2026 18:07:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wC7WBLMgJTJJ; Thu, 29 Oct 2026 18:07:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 09E6780FD8
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793297278;
	b=jaKmd+wX2EW3jj8k8SRjP8PIoGHsdhpfjOwW1JTQk0EbRPkvXHzjWzAMgEVEeuVu5ykj
	 IiYPUhu29uPOsPnEPBpcPpVIAWOTaFp9wbtz5ZIG56btdIn8iDKwhEw5axIkVJ8h0Vhzn
	 XthshcynYdL9NckBBrXzb8hwXCOawH6LOxN3gN9ABcKivYzITYETCcEP9S1g9/29Y+rd6
	 BXhMWHsmW1QAjUOdNrGWGU79gX2Nxpz7v9NjNu2HpYTARAPa5A6EFWG+ggTFoS1/h+KFT
	 rnAERGciQ0KbEl4TCuuV7fu9Ny5Enqu6ry+gpCfoq7rEHUpBZCGJvOFN4xRma6XMqKQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793297278;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:CC:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=2z6i4GNP+8CAA5UGXfvvsfjjlRDb9usNY2hYa/GGhs8=;
	b=Fhc1TUoTgo8TCLQptF8pCOEPVxZZsNCPkyv1Svte8gdCYGrFU3DBUaNA0tAC0/nMmCjj
	 ddeN12O6oywenICTf2ogUkDu45aLInlDoAGAi7RFooPf2F0tDgw74rhMiVvqZ3y+gsluw
	 fJQNfM14dgwprMMUW7zKBh97PF8bOsQRTEiBv5t5F5tqn8bS2oCjN1ai5cslOhjbltRM6
	 ChRz1+x0O2Lj5hiAF2/MUo7zXkBT1aB7Ql21NmRufoBOX/pa05HsZENtbmgl5WCb1bUHk
	 6+qrVs7QVsWmh6faPDf8Il3luuDg0Domd0G08eMJgA139WbsMKJUeDtZiXOUywi3ZbA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=d7mNUG0J;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=eqyXsvuY;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793297278;
	bh=2z6i4GNP+8CAA5UGXfvvsfjjlRDb9usNY2hYa/GGhs8=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=m6tIy28S/chsy1YSfjxsM/FB5yyIPaxMGpR20HkzNF9aoMzHUDCYoq2LkyMyR8ULs
	 009+48dLKhyFYWmF/WlYXZGAtmKAVBH2P+OR5ccmjIcOzzOVEyxGWyhDDSlyJsMjfq
	 hRb/cLRuhlDMCviBoTI5VnY3EDwEhu2ldW2Uap66etS860cwipRAcWnwurZdZdW3aT
	 9h8NRYpW22IyEyRzQLhDWXUaM34J10P6eeX8xPo+LA7EbKfKdJH5kzUGS1a0cI8pN/
	 lEiFYzd7vHsIWA9ltETLAKxZLWa4azFtAKPL+SDQA65I3sfXiV5rD2xHdp0F7GFBIf
	 NDikgDj/1JFnA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 09E6780FD8;
	Thu, 29 Oct 2026 18:07:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9A23F1DE
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 18:07:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 803F280FD8
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 18:07:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zyoxp6zZXHQ4 for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 18:07:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 33AF680FC6
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793297275;
 b=d9dPevFu+sTzZttp1m181zqHKRlKFw/3apq9zePg7QFq533LnJ4z8RsYrnlDv4Pdw6u1
 3pinpZ3NTakpvtnl+TMKPkPDVIEpqAMdzKRGpwLXLrzSn5hHE18tGlW4yhDRBMp69e6A4
 0SdF5+2R9QM5Y6+Bg2sw2qEnLNXbgx4cRDCPuIxMZzlfnpHlgp4j+tZwjfcIFKJwDtGoD
 SE+vhTaZt4ozdVH1ytjQTUFUiyvz/qP79FYF/ftrZ2cQvwQn3TmdFJsDLkx3CAs3k2WCN
 eqmKhwaMZ7m9lRx1ZwwlavuE9XfXLnzjg5jURpmZEcDLDtmidMEwg8QEfBGECdg0AgQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793297275;
 h=Received-SPF:Received:DKIM-Signature:Received:DKIM-Signature:
 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
 Received:Received:Received:Received:Received:Message-ID:Date:
 MIME-Version:User-Agent:Subject:To:CC:References:Content-Language:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 X-EOPAttributedMessage:X-MS-PublicTrafficType:
 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
 X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-Id:
 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=2z6i4GNP+8CAA5UGXfvvsfjjlRDb9usNY2hYa/GGhs8=;
 b=PGFYeKJkurd47BUibAxPax54peHhGMYsqOZ97Dr4U/GKHFcEv1vpAe/BDFpG/SzK/Z7Y
 HugFtCZvbdbzQeFh0MoaJByt+RqNeL4tITeF/Jws+oLdHgE+Q7TueWmcZXv7IIpYe6XvP
 vr24vYuC5mmVWZvyY/ylGfsajlz07FCQRxhn/QiDN+FEo+GhlYfkTgaXstvuoDL+GNwNc
 7ARAt8OxvOqesei+5vv5CnOiqxqOltaV/70P6prC4scTXcEXBhXysirEbhPkACmjlwisa
 P8Hkw9o5+J/VyfuU/JSiGK4pMeQYf80iN5VSSZPBu7VHEYUq9LLezVavsKeZUL/uOtw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=ti.com;
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=d7mNUG0J; 
 dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com
 header.b=eqyXsvuY; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=afd@ti.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=d7mNUG0J; 
 dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com
 header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-ticloud-onmicrosoft-com header.b=eqyXsvuY
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 33AF680FC6
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 18:07:54 +0000 (UTC)
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TGDJuA3224511; Thu, 29 Oct 2026 13:07:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=2z6i4GNP+8CAA5UGXfvvsfjjlRDb9usNY2hYa/GGh
 s8=; b=d7mNUG0JxIRNTeWKCzDPvQvaYKfwH/oejS98HuZ0MWzzzrWu1do+MV1Qo
 VjD6d/0JgAG823fxwH702QSeLNJaH+cWUgSPAyP98D3eSZcFS2kfIGqRKFJkkxGP
 lB7aasqfGjUiLMdXikdr4/VUmoTm5ONKEQA2C6D324/N1UoDAbGMKEnEE4tNY4H3
 8E6nwXyabAo3Ge6Y91Q6EEbwwh+3oHMGNDMMM85IE9er68KDWWr0oiTMluLIlmJ9
 U1oyqo5yV+KvSbNqL5rVe+Pl0Qh5yzVn6zeX2ezflPzllEXVmsJr+uUsEjPOukRB
 bu7m4OXHk+riuIouHvGyJTOvO6VuQ==
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazon11013015.outbound.protection.outlook.com
 [40.107.201.15])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4hm3h7khxn-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 29 Oct 2026 13:07:53 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gDvWyh9N2e/9G6l7uF7KXaMxZz8Su1O8dzzLgHdQ6g63j0bfSIW90Mr/7yo9Wu0RpycyexkjzMjmx6yp9LViXSmylViKU+uEaFIPXQzrrl8dC2M/ar1E1xxWf6LcAskTmuPPnQ8n5+qunbDcBd6Tt9uYNQvCU7kfh4yevPNS0X+93+ZLguS8q8GLnyFSL3WdWIz5NVhL3rpLT06cSkcI4BXkhElkc8glFq/UraoXqHywY9yEIE51zIUUTbyk3xe3PVVSCOsc2ApA1VF+pbwZNjO7Av6pMl5JCdcw4plGmuIBUPoe6HD+LZgj6E3fu/gyqnfBETahh1x0KgA3DU35UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2z6i4GNP+8CAA5UGXfvvsfjjlRDb9usNY2hYa/GGhs8=;
 b=ru3JzbGePVAUIC9IWCcTy/i2pje8TL0ttul1QFGFCrWT5JLOkkIys3ZO3+C0YcieNUzhMNuReC999ui6Xess0J7oWotIRZ5QNeYNLAw8okXcvayC2FC2oEfvFawqZ/LyqUGX+FEAv2eu5fuqKzoBNK3srkSjAAFy/0aqtwXjsFnzQ+iyNkBw5KixISv4A7lrOimpwRdpACe0Dhv7/oqTZ7GOtdlk82HLBmx3YZ+8U1sjiKFrX/XRtpF7hdreOT+OqR9eg/n1NOJNWSUTXyXCg4OQHN1dzDT5hSvUXAbRsWbjybc6thE1qc1BlsRWjp6MmYe3d3NuckxnMaqWDtau6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2z6i4GNP+8CAA5UGXfvvsfjjlRDb9usNY2hYa/GGhs8=;
 b=eqyXsvuYaOJekOOHfqaFNxWBKyPxIExfKlT0P6UjbuoGHjn5YQpbAcSCclMa5uqCBpgx03/d4830LO4w31mK/6SEBdxbOr54gkWnI5k67cw3UB08rNmLcS8nMo0gt1OvVrW/dEUBiyuoMWeYMN6oqOeMk6rZGR6ill7XMMkDL74=
Received: from CH0P221CA0006.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::29)
 by PH0PR10MB997618.namprd10.prod.outlook.com (2603:10b6:510:37e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Thu, 29 Oct
 2026 18:07:50 +0000
Received: from CH2PEPF000166BA.namprd04.prod.outlook.com
 (2603:10b6:610:11c:cafe::1) by CH0P221CA0006.outlook.office365.com
 (2603:10b6:610:11c::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Thu,
 29 Oct 2026 18:07:49 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.195) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CH2PEPF000166BA.mail.protection.outlook.com (10.167.252.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Thu, 29 Oct 2026 18:07:47 +0000
Received: from DFLE202.ent.ti.com (10.64.6.60) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 29 Oct
 2026 13:07:09 -0500
Received: from DFLE215.ent.ti.com (10.64.6.73) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 29 Oct
 2026 13:07:08 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 29 Oct 2026 13:07:08 -0500
Received: from [10.249.36.221] ([10.249.36.221])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 69TI78aa2429497;
 Thu, 29 Oct 2026 13:07:08 -0500
Message-ID: <9d74a34f-f720-45e8-9b64-76291f3fb842@ti.com>
Date: Thu, 29 Oct 2026 13:07:08 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm: omap: Hardcode control_status register for
 OMAP54xx
To: Tom Rini <trini@konsulko.com>, Beleswar Padhi <b-padhi@ti.com>
CC: <ilias.apalodimas@linaro.org>, <u-kumar1@ti.com>,
 <u-boot@lists.u-boot-project.org>
References: <20261029173914.3771786-1-b-padhi@ti.com>
 <20261029174912.GE3011578@bill-the-cat>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20261029174912.GE3011578@bill-the-cat>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF000166BA:EE_|PH0PR10MB997618:EE_
X-MS-Office365-Filtering-Correlation-Id: 98815d56-1fc4-4e52-04de-08df35e78a08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|4143699003|56012099006|261009223027099003|261026140227099003|261026121527099003|261028144727099003|10067099003|261022115727099003|261022105027099003|261022075727099003|261021121427099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Yzp7konj70n7kE2NWwAQvRIl41En2mUYTxZ0UtzeSQuWqjzaNuwdRF6g2AEzWTXLrNtfiPChs/mqZsDMyrTRajsmBI2fuMzq7HbVG7bq66llVeL09eDCnXCsYJ7z8akmgmb9ZvfsAehrgAHaVPpAtZgPOH/uFob2hYrzBY3Iy6u0evjK7+UNxRUko1ZTdyws/jMCbaryB+b6XKIYOdLmhobOysOwtlGMNgFsNcNFNdpH7f8CC9+sbBgKIfVu7OBgawD6frejQs4OcS836xAUKNrWNL8fXacQDgY4qtwnsbLh9BWt/rhQcm0E4f0BjtX55Gwz3K3plhVXr/Q6dax4N/fnaJQ3skF0Wr8U1PIEoOK7IdNRf/HcsEqZUNDbb9hfNyFzmxCoRKzfIkFIZa/55tddxvozfCx0pKtsoxgNNDv3VQzHm8A6R268rbTxdf8hKr1kmYbo1E6zPWinqgtcIR3Ybo6Ks9ZJNXBOv7Ic0hAzLJs9sE3NUZJO25aTHa5SFpnK2xqWK5w3c06aOCU1dXtsoPd8nElTgtjjbJ3Si8orCiMcGyC6XH+KGAGu+BzfAe29ME0PIqsULjtpLV7XEDi/TEjx7nJ1Wvzj7G4D5nxn7DFo/nZpfN8uj10GFD7httacTSIFquTAJBB9prPnUixzZ4g9yU7BGNiJgvJjMoI=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(4143699003)(56012099006)(261009223027099003)(261026140227099003)(261026121527099003)(261028144727099003)(10067099003)(261022115727099003)(261022105027099003)(261022075727099003)(261021121427099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 61Z2hqMQYx8gGQKxbjRVODK1sVVXYxYsv6F8/Ae1usdlOzXMRti2zYIIRgPkB+g6l4g+7/RucHP8j8E8+QUJdqxxZ6rOKXhwk0NJXQDNfXutT8RQKnAfc9He1bSzZfsj1FuuP4q3UmBgGUKNtcgz8ONFnu/0v9GpYuYfjpa5OAMCJF9yzBMqs3JF97q3Ir3F+POsinRe7Npw12J6Xg57Je9mh94h2PT3lPBsgxyMPwKKv9rq+b7Bs39eXarz3ORZ9z/cpoAQlmFKhq19POSFHUb6TLsa6bAeQ+IEQYHYeRR8WXg67yE5zbdv5sfH7QSMxU6WrKQGC++2VFFW9v1UwiVkoRtOD3LYqqG0Mzcg81sjdiCF1G2imuVVc5hl8QfmBLSKpIgCuv/CSXj4RA5GveCrmTTzjg+0WLxzgapXKIaQ14Xcjsyd9D45YiisC+DG
X-Exchange-RoutingPolicyChecked: pC6/YILIedlhtJmz6uCkc4FHMEtw2OKtZvbwHOlL0NqLMfEFuyqx9uLWpOPcjnRpjEGqi8962BbGhexASKCS1+zQmJpPKkFpHpepo6Ew5LjgJH9cg8ZI/h0cvlaSBamnZlT5mgvWKBSWKaQhKgvSswOcvzlSZ1ufp4oPvKOX13PLhn6GCib//pJl0Lp0hYP9Yk2jsSDvbZIB/l+G7IKOoFpfce6lfJ/ExzPpnR111YcPyEwNaUOi7R08vUnKv2B9YFlqzzMR328qi376vbakHYzUKbV8DXsJO11bx3IKfzz0X6XkRjsCsjbugGTVO4Skrkx60OZ2VzbbDtcj1hZ4pg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 18:07:47.8442 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98815d56-1fc4-4e52-04de-08df35e78a08
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF000166BA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB997618
X-Authority-Analysis: v=2.4 cv=fv1J914f c=1 sm=1 tr=0 ts=6ae38b79 cx=c_pps
 a=ar5COM9M0msGq9wDbiNjNQ==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=1VxDqnHFAAAA:8 a=l5EvAJeu5r9kWjRwJBQA:9
 a=QEXdDO2ut3YA:10 a=aZ5uHUMKh6B-zo3GvD48:22
X-Proofpoint-ORIG-GUID: dR7AB5wC9FkDBHHbPGSomQXpzA30g95L
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA3MSBTYWx0ZWRfX4OJwT+u27bTJ
 TkF7c/+umqm0xTVY4NINF07XunjYfu8hGcEiENm0J4/T+FoYfLG5praP7MGaSK8mLSM9k0L0HEM
 Vdnclb39qIJ0ECx3PI30rbxqUW8wny8FsbM6xnPAnuTEuFzqu4f0/dECuzZjy//jdNSVmRclb1i
 ycGeYLNPuYz4+ZR2ReVFFYsgFNkGyMMUb4nnxvn+H5t5JDt+zAThdAqjsP0mvD4N39VprTvJ0qo
 HUmPrVwbpb30K72V3mmi7FSGDD8u18A4xCFvHKzy4+J1KqqVoZ9vJ/2+70IIq3Xt/mFktiViBQR
 sBDBp7HgEnLqnfeZPA1y9KkSdeiC8DOoIA0q5Q2RbO8CD5fGxnPXHPvQlOdm+3hI4vlEcoVWLQh
 yEyiv1vlXPwRYd8uGv/sLsCUqxlihQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA3MSBTYWx0ZWRfXzpg0/j/Uej9B
 jy1kOZdv+2Tp3z6jROMmP+Gm47+XbmzIPHr6qdPgu0F0WmEi+pKls6q1ogb0ZzZUkZoYYs0JP8p
 p9wcOPii85OjDS0TKOwy85T1jC2NhcM=
X-Proofpoint-GUID: dR7AB5wC9FkDBHHbPGSomQXpzA30g95L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 suspectscore=0 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610290071
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,KHOP_DYNAMIC,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/29/26 12:49 PM, Tom Rini wrote:
> On Thu, Oct 29, 2026 at 11:09:14PM +0530, Beleswar Padhi wrote:
> 
>> Currently, the control status register address is obtained from the
>> ctrl global pointer. ctrl points to a fixed SRAM scratch slot
>> (OMAP_SRAM_SCRATCH_SYS_CTRL), which holds (*ctrl) pointing to the
>> omap5_ctrl/dra7xx_ctrl struct at DDR address 0x8086XXXX in the
>> pre-relocation U-Boot image.
>>
>> Since the SRAM slot is outside the U-Boot image, (*ctrl) is not updated
>> during relocation and becomes stale. The kernel section from the
>> fitImage is loaded to address 0x80008000. So, a larger kernel image
>> (~8.4 MB) overwrites the value at the address (0x8086XXXX) pointed by
>> the (*ctrl) pointer. This corrupts the (*ctrl)->control_status value
>> and CPU goes into a data abort when it tries to access the data at
>> addr=(*ctrl)->control_status
>>
>> Before relocation:
>>    +-------------+     +--------------+     +--------------------+
>>    | ctrl        | --> | *ctrl        | --> | **ctrl             |
>>    | .data       |     | SRAM scratch |     | .rodata            |
>>    | 0x8088XXXX  |     | 0x4037BC20   |     | 0x8086XXXX         |
>>    +-------------+     +--------------+     +--------------------+
>>
>> After relocation:
>>    +-------------+     +--------------+     +--------------------+
>>    | ctrl        | --> | *ctrl        | --> | **ctrl             |
>>    | .data       |     | SRAM scratch |     | old .rodata        |
>>    | relocated   |     | 0x4037BC20   |     | 0x8086XXXX (stale) |
>>    |             |     | (unchanged)  |     |                    |
>>    +-------------+     +--------------+     +--------------------+
> 
> So this brings up a similar question as v1. It's never going to be safe
> for SRAM to be pointing at some pre-relocation address in DDR. That's a
> problem, full stop. Going to the patch:
> 
> [snip]
>> diff --git a/arch/arm/mach-omap2/sysinfo-common.c b/arch/arm/mach-omap2/sysinfo-common.c
>> index 49bc3a634fb..1b7bca3ee37 100644
>> --- a/arch/arm/mach-omap2/sysinfo-common.c
>> +++ b/arch/arm/mach-omap2/sysinfo-common.c
>> @@ -22,6 +22,9 @@ u32 get_device_type(void)
>>   	 */
>>   	return (readl(OMAP34XX_CTRL_BASE + 0x2f0) & DEVICE_TYPE_MASK) >>
>>   		DEVICE_TYPE_SHIFT;
>> +#elif defined(CONFIG_OMAP54XX)
>> +	return (readl(OMAP54XX_CTRL_BASE + 0x134) & DEVICE_TYPE_MASK) >>
>> +		DEVICE_TYPE_SHIFT;
>>   #else
>>   	return (readl((*ctrl)->control_status) & DEVICE_TYPE_MASK) >>
>>   		DEVICE_TYPE_SHIFT;
> 
> There's not enough context to see what chips are in that final "else"
> clause, but they're all likely in a fragile and breakable state, and
> that needs to be fixed. Is there still a reason we're shadowing that
> information anymore, rather than always reading it? And, while we're in
> here, what other fragile things do we have SRAM pointing to
> pre-relocation-DRAM in? Thanks!
> 

I had tried to root cause this sometime previously, it starts here[0]
where we have different ctrl register layouts based on the device/revision
and we call hw_data_init() early to setup these pointers to the right
layout early. This part is probably fine and saves doing the lookup
every time we do a register access.

The issue is then that we use this double pointer with one layer
being stored in an SRAM scrachpad area. My best guess (this is
code from ~2013 so I don't have full history) is that this was
done so the pointers would survive SPL->U-Boot and not need looked
up again. That part is the issue, the sane thing to do would be to
just re-fetch these tables, which AM43xx does do[2] which seems to
be why it doesn't seem to need this work around. And the commit
that adds that for AM43xx[2] seems to confirm it was done for this
reason.

Best solution IMHO would be to get rid of the odd double pointers
and just make sure the now single pointer ctrl tables are initialized
at the start of both boot stages.

Andrew

[0] https://git.u-boot-project.org/u-boot/u-boot/-/blob/main/arch/arm/mach-omap2/omap5/hw_data.c
[1] https://git.u-boot-project.org/u-boot/u-boot/-/blob/main/arch/arm/mach-omap2/omap5/hw_data.c#L794
[2] https://git.u-boot-project.org/u-boot/u-boot/-/commit/a93feb2edc60b9db76ec794bff5ad0fcb10ce3eb
