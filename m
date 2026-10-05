Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5596CA5FF5
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 13:31:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 60F1B40715;
	Mon,  5 Oct 2026 13:31:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LHPOcHmrjiwS; Mon,  5 Oct 2026 13:31:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 72423406C3
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=4; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791207089;
	b=SY8ERzUKaZCYINFhu5iIanOhGqaeq0DzPZLYlsKgQ7UBlfE6EIIVR6tsEq44QLnBhYdY
	 JtjkjaznDrRmhAatFVozBgGozjXVUFBS7BvlNA5OFV/5wJqz7x4LxOKgG6FN5K4ipd4Ge
	 HtI/XP1CXUMZCNDsA8KpEXXRb7UJcc2sT7oEueuGreRTRO5+HmXcC2qMCKhjJ0amwWVef
	 fwa0Xbx3P1duonQh9FjMOwydRdcDddW4iZq7L/DOatSWBxDIgEUTEk0uIl3FOh4p9k96b
	 +jZe8rqTiw/FtX3PzbHHdmCRHOpzLSl1Er9NwAb1skn3WYIiiqJCAw5WrfTLabfzxnw==
ARC-Message-Signature: i=4; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791207089;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:DKIM-Signature:Authentication-Results-Original:
	 Received:Received:Message-ID:Date:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=6JD8rKNcSLWxoizFHaTq36CTF23yfpTz3p708NSZZZ8=;
	b=DG3e/8nw1HbfYQAFRS4pEq+/hd8BCcVwoM9fB8NTIeM3ObWSHE7RVdWzBV/+Dw8Zs1JP
	 Ed4BIrMFSW/1x2yyjWL7pFGwUp1XadBrA8Cr4aq8isJnwl65FXOAG8cQf/vVpjcUnvjAl
	 pveGvSQ3llm1XkU/J8GxO5HZzmEMawMNYMxghIrqi/sTakqlvNDBRVOtrkiLLQW4ACDpU
	 Gy8DPsL5UcPEVZYiwM8tQCMFVRkgVDxYfQCirMktHRejRRX6+KTl95jutn+mRiYxhTqX7
	 6mDvB24gS50jsh3GumFfolxWjoQgTCHtRf6goDQwFr90CirPsCxsWCc8gDnKAcEcOcA==
ARC-Authentication-Results: i=4; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791207089;
	bh=6JD8rKNcSLWxoizFHaTq36CTF23yfpTz3p708NSZZZ8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=B5X8eWS+6gjJsvHoS5kTTcyqrALUVJn7276cMNT51/UPm8tDs047ypJqu8o+pleZn
	 UWxWR23XI0Pht+SsRTm65eefuiw3gXGFM5xceQeC1zmcVFpqnHrLEaTtppUxn9CoG0
	 j0BdoMT//RzxJruwW2YQbhWNnob9y2garRvbZScAzsIOihU0ujlYw+UEF34cYZRJCR
	 ctU5xpQKDvkRWB4ZDbmendCT0UVsBJi8CpyP5ONAx2KbbQgPM+Acfv3DtbfZatM9CW
	 L19mypSYRZbbKTbxr/O/HS/s/TU2Rq4peDNI5RY/00aeDUMRaL9n7K6b96GAeZRjmG
	 nvgd5i+RGJjAA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 72423406C3;
	Mon,  5 Oct 2026 13:31:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id EA3AE2E0
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 11:13:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CF96360611
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 11:13:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vuHqxbEab59h for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 11:13:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org E1A7560606
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip="2a01:111:f403:c202::7"
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791198799;
 b=Gvi7zWNsnxWRa8QcdrP1e2zkNzHz1vtaXxo9EIkWCN8aDcJvLkWGXPsjbjyQES+OxyrA
 T1VkcpfBdweMItfTH0TIlchQ0TvCem5B6vYMnIUfRDSwpXwlFRn29oriLYtg1C86vwMK6
 CkSvd+81JcocKZ2PID5TNXzakIJ3pPPSJpuDtgqqOWk/RZZTAYNoifTUtGVqYkeOOIo78
 Hoj88JmxqyTQNE+GNP0GOd67vhwZcobcakD+XvdbB2gGIPRQY8HLDtsPpiRj+5BXJwkbN
 1Cd4L/LXFWkwIPaV7H2dJ/3sS48jf6TAVkvxTiZqWESLxlo7dlU/dNT3v0p7mQ9qRjw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791198799;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:
 DKIM-Signature:Authentication-Results-Original:Received:Received:
 Message-ID:Date:User-Agent:Subject:To:Cc:References:Content-Language:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 X-ClientProxiedBy:MIME-Version:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:x-checkrecipientrouted:
 NoDisclaimer:X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
 X-Microsoft-Antispam-Untrusted:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=6JD8rKNcSLWxoizFHaTq36CTF23yfpTz3p708NSZZZ8=;
 b=myeXm+rv0FKtQ4VqRITIA0CL8B//x4fqQtOr+NHX03aH5ne9Blhid39QP4Gd/X2hWvdl
 wmSvvk1LCZx0INUPGf/oMCIb+cg29KfRd9yAZ0XjYLGQcePXP1NL4UsX+HSoomW9AVCg2
 WzOKyy6WJuO//dDLYOvtmXyjvcANfrbKG4yEjbBtjiBfMzJ6FMoZPt2eqhlqc1vvAunmk
 XIWOWQDeOEAQCj1uvYQQj5QZyGipmYE/3Sx5AWKaBFhcRCu2yl6+cgiJ6KHRF7WQGgl0D
 p+Y/LQ9jeNUI4/5UevH+Iq9HDMhYlish0YBTD8fpeE1ZaAneheMP9KtxUTU4Ongqciw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=oJSWb9Gs; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=oJSWb9Gs; 
 arc=pass header.oldest-pass=2 smtp.remote-ip="2a01:111:f403:c202::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=harsimransingh.tungal@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=oJSWb9Gs; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=oJSWb9Gs
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E1A7560606
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 11:13:17 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=Z27RSxCktSu3a3a7eBcH3Jc3WB4F32apQ7m6D0V+OYTC1X4G54OOAAcDZmqBpJsMTlI2witFTjN9ePdaqZrOK5fe9fQElOqnRJT2M3g+eHm+OwT5wKIBRjO8Q3lT/cOPEfCGF0igsCC3B2UAKciVIGXz0bhPaiEpJkIZoccBF445lCpaUHsUkCCStHWihmlFMXFfH8HmjHfo6M6ROUt/Bwk7Qp74evoEk0/QsOIOlC3PvfdQMXqojMFGKIXaFWj2NXsAyR5GIrstKBr7VkbyjAif6P42IDgG5F+4Y9H6szMOl3kYquujY4TzfikdnOUi+CAjzdatSSo8ryyvxulr6g==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6JD8rKNcSLWxoizFHaTq36CTF23yfpTz3p708NSZZZ8=;
 b=LgaaeAu9VGoEvmboC7peYu9XEy6IKLdPynLJsVmaE95jCECwwhPpGOuBEB+UszKpufWavGgrXGSiaTvfScRN/cObKs+aBX0OTfIUfpKX2ky2cLlGiy5C7bvSyQIgirqsYdQCIaJtlyuKmPiYjJvXzzEfrojgqrBGCZbfIzqQMU6kcPppJNlDK0Sjqnt08eCsJoR2sYz4eeBl7bZTiYVjmd/T23NtOB2cvUiASCF7l55DstWVA6fpaTLpo7DpdmYo7H0fk+htgI6zrc9KQqRdGX6gAH5PsS1GpUQ7tQojthB27uqvoZmAPzK6pY4EMWOaFNyfZl1xZXiDlPmrQWHxPg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linaro.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6JD8rKNcSLWxoizFHaTq36CTF23yfpTz3p708NSZZZ8=;
 b=oJSWb9GsGuTdtEPYPsLCPh9xEPvt4vQtclnJDSsJDq3NhDse290ic0ugc5mF/IRx5/jH4xD+IMcSRfxZogE9O7OWsbR5YrLZhTQl5wGaZQFpludqRv8JbTjGYTnF/+mYHI17Br3jW2mccFzVSC2ALRgO/8QkNo0VB1tkRkda204=
Received: from GV3P280CA0098.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:8::30) by
 GVXPR08MB10451.eurprd08.prod.outlook.com (2603:10a6:150:159::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.14; Mon, 5 Oct
 2026 11:13:07 +0000
Received: from CPH1EPF00000522.eurprd05.prod.outlook.com
 (2603:10a6:150:8:cafe::aa) by GV3P280CA0098.outlook.office365.com
 (2603:10a6:150:8::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Mon, 5
 Oct 2026 11:13:07 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 CPH1EPF00000522.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14
 via Frontend Transport; Mon, 5 Oct 2026 11:13:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U/OotVkrP7KGmJfncfcamBkXa3kRfj4NGF11oQpfXf5OM+fZw3LXXcnS22YzCGiHBJx9bhCGBBYv++6bX8gNyZnRdqVc8rQ0JCUWSSFkcRPi2LTNjbrhbnkgCLsqOrERcksL+eDKgqS5mFKPLawuYcnS+s4vHE0O6/c5sfno+omWHCD7Pf2oWuB4iIPWw9cQhL66xZrP0Yx5vhseX6Lg3RP2eP01K7466pNuN4WhiAY0ZfqpMIfsSs0o1mOXgYtJek5P/DWOGbzoRgSA0ITWnKJ73QGdC045Fsyq0Vyl0W4/qmg1uVIQNtR8Px2DoeQca/MXhoAlOPJa1E+5MsMzUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6JD8rKNcSLWxoizFHaTq36CTF23yfpTz3p708NSZZZ8=;
 b=l+5S6zvWOD/cfunSIcxqTeThbq1jwF98w+phBiaVx8tFLid/zVdVd4jXiXU+qwFb+Vi2JpEcZ/gTSaEyN7gpBFgP95Hu1OsTXyFSxSnJduhN8aLfrem8DVDRCa03dTpOZWSHPYbeMxve1gpgG144nLmYlkZe64xtqcIHURdpgX55xAfTgVVcmXGPyxe9kl309MNbjjqKWYeu/4HmejLGyhpbmB+/9dHvBdC7NM8uJIua/BA9OHri+2ng7bJSrJoIJRCKYUkuXG97hon4WlZjuwN9OWte7+xXRxi7NBHvP0hCbVhoaQczstBfW8mVWYyCmIBLwyW4hZHPJBQ+f4E5eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6JD8rKNcSLWxoizFHaTq36CTF23yfpTz3p708NSZZZ8=;
 b=oJSWb9GsGuTdtEPYPsLCPh9xEPvt4vQtclnJDSsJDq3NhDse290ic0ugc5mF/IRx5/jH4xD+IMcSRfxZogE9O7OWsbR5YrLZhTQl5wGaZQFpludqRv8JbTjGYTnF/+mYHI17Br3jW2mccFzVSC2ALRgO/8QkNo0VB1tkRkda204=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM8PR08MB5620.eurprd08.prod.outlook.com (2603:10a6:20b:1c6::23)
 by GV1PR08MB10853.eurprd08.prod.outlook.com (2603:10a6:150:161::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.14; Mon, 5 Oct
 2026 11:12:34 +0000
Received: from AM8PR08MB5620.eurprd08.prod.outlook.com
 ([fe80::618d:6218:6962:17ad]) by AM8PR08MB5620.eurprd08.prod.outlook.com
 ([fe80::618d:6218:6962:17ad%6]) with mapi id 15.21.0496.010; Mon, 5 Oct 2026
 11:12:33 +0000
Message-ID: <bd9d4332-f1e7-4c66-8524-2dbee628a364@arm.com>
Date: Mon, 5 Oct 2026 12:12:30 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 12/22] efi_loader: reserve FF-A shared buffer for
 runtime variables
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Devaraj Ranganna <Devaraj.Ranganna@arm.com>
References: <20260914110106.1974894-1-harsimransingh.tungal@arm.com>
 <20260914110106.1974894-13-harsimransingh.tungal@arm.com>
 <DLINN5K2BHFZ.19HZZJ3K3T9VR@linaro.org>
Content-Language: en-GB
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
In-Reply-To: <DLINN5K2BHFZ.19HZZJ3K3T9VR@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: PA7P264CA0100.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:348::18) To AM8PR08MB5620.eurprd08.prod.outlook.com
 (2603:10a6:20b:1c6::23)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM8PR08MB5620:EE_|GV1PR08MB10853:EE_|CPH1EPF00000522:EE_|GVXPR08MB10451:EE_
X-MS-Office365-Filtering-Correlation-Id: 067b5327-6bea-42b7-c9d3-08df22d1a1fa
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|5023799004|11063799006|56012099006|4143699003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info-Original: gF6hyWIaRYbDd6TIvkmLr3W7dRSE0ajbXzCHeyf9tyM0xii3iR2MpWiCBw8ix9ddNTFZuOC1xiJhH9hzlLGyyiugfnIw/n0Q2DqieeFd+5f8DWfcvTM9KoXQs4EDvGEGC+ubqRRuPQRk4k9MKopfuLIX3/2HtJS8nUbOAoozShp+ILYyM7G0WL5/RYrUELqMnUdDMMl/ovEnBjp+UAPYUlYpGzA6OxHFx2vRaoo3kUOUfGzRZrUTccBH6lOwGT536W98TaYj3jsQMqKc4dviMirc3wtXn7epNT7F1+3perKBCJ1ANCW4Jt1IQQs1nDLTLZ6sQIb45gXZNGQybqtMuvDKc8VNokKqYDuyU1virUiXoHeDEM7yrNTKnRWSi9KNAVMEPOlUl/DG1IH7v0N9PL6hLvpfMI1qwkuQc8/QLrxfBEz5vHlsBL1yTWNxukflphHjGryF79TER8d1pNYEvEr0kdaMWNSnBPA27nBB8gac+pWXzloZRMI2dThp/8bjx2rtZHkOok4esMEdIhiH6frwhdiE+HEd1jqLlOKSOpXaDKguFCtYSCclHxVS9/rI/GvgKIxme3c2/9mqi9pmW8G7BW2RfhKqkO1ewWhuxRmU667InAC3matblGOuDocnOO8A0x9Yf8DM+nLQg6mhrrMRGLek2t6XaO7h9WIBUhE=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM8PR08MB5620.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(5023799004)(11063799006)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: 4XmNIGe2FVtReiqhly/NqrVMmxn81RSWQIZxZeO5kKdX0v5RtSvR8o6tHPz3EkmWAps8zpNpF9S87vJuY7NReZ9m/XpbyuRTNm1xqCZE1MM8Dtm673LnXA4FK1lQKdusakvh3GVAkkc1mnVOYJh7vxsS+/WzNnTzleg9dcT49VqQvY6RjzcLEguD7EChb2mak5k3gdeOAMvXWMf2nvyfCEXQywPyJUP3YvG8+w9Gf0jCiwGWkGzidgrxdinIiIh2978zsZuXR2Rs5wCPME0yNW6VlBFuiFdI336HSJDwd7ZRk/bbcPZl+YKfb+6UP45TaeHwElzGpYLOAkrjz3eTVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB10853
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: CPH1EPF00000522.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 6409fb6d-cb04-45bf-406a-08df22d18e07
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|35042699022|36860700016|1800799024|14060799003|23010399003|6133799003|22082099003|18002099003|10067099003|4143699003|11063799006|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info: eiWh+ecm3rU/72Ja1QJFuxsY4k5jx/PQUB159qiYg+ArB72CrvaOetPU/ElnBzD/vwKhPomyQwf1Z/L0WqsYTnbT07FBN4PiYw+rPKQDr8BvBxKcN89rREeKwokP1g74e8tYgdyyd2hnghLzvS3Ujwpdaa5EDWvWhCeKyf/V6M9Cq/gjZusNpFWxW9tzd0IG6oQfAB3O7I2DRnAD4Blho6hzan1OOUQhPN7P20sZ5xlfvfJS39NS3hLzCi4NGRrLbnrD/EJd/n2lnZEEXVisZFv5eHyVtKhYYeJbHi5eclXC+cHXmbQz3DA3KdD1CDQiS/35Y5sb3qWoS1xUiJIdICq6vlfJztaJFie5dEnvnnTr58bewFCllJVkJ7W+AarnoWiI11rFptI6Jvj9eIgysu/ywumy9dlKNOsNKxeT83AUIrda99oFYAej6RzWrXXridQcbWyoqlMRpplDy6gYdjt4/e4eC4rKGw6Ceqa0BsXcc0js3HuCOmZjibr4z5r9i6LZZ8O0gKg8GTWx1zJxJLENpkHc0w+eRbah3uRWSD+L0f5pa2LO3edb+QzSMn8dwxTFEPlMtMhatSFsQpZXr9dJn9t0viyg3WX9KbvYTTChKlf+xPVJrx8Y/6gGSnR1ON3smxqYOnMzfm0YAnHuaTANrwug1o5KNiy8EIOJPXDlltMgQOPF5Pc+t6hB/NPXWmMMHRP6qLRgr02gLzlBiA==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(35042699022)(36860700016)(1800799024)(14060799003)(23010399003)(6133799003)(22082099003)(18002099003)(10067099003)(4143699003)(11063799006)(5023799004)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GuNIv4fE9BjOdBVs6nyF9tH3wUwy7jVfA32NTOgd39cU9iOtNjsIVR9N9E1/6QnQ92sftePxW0M+vmmgqgI/bQPljmpjW0c8izq2NCpnEx/R9/ZJa+101kKOISpsMT/8ggVQTrVKQQBgmvltX7uCFDdRHiNcnZgqRntYACGui5b14p3pV7wV5rdAv0gczwENB1l9NW04uGGFZy1jY+WoKMQisQ89rHCSNQyzqSFbsn8J67f5W5Y+3dm1W0fXIYagzNKBQB3MqTg3gd3glC3hbWIkoteLCbEkNaiVcp+WPU2x77CHgqB8ODIEP4P+4LFRMXbEx4h04PvNPzEtGGWJ8HrMidGrrDyeAJhdc27QGNnK0fxDUd9xOfAl0okMTbVM9gBwew3KlkazVBRqhuW9eIUiHgre7UcagjQlEWSzmPalgwD2m+9WGUtoRirsrByj
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 11:13:06.9368 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 067b5327-6bea-42b7-c9d3-08df22d1a1fa
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: CPH1EPF00000522.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB10451
X-Mailman-Approved-At: Mon, 05 Oct 2026 13:24:22 +0000
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



On 18/09/2026 19:30, Ilias Apalodimas wrote:
> Hi Harsimran
>
>>
>>  /**
>> - * setup_mm_hdr() - Allocate a buffer for StandAloneMM and initialize t=
he
>> - *                  header data.
>> + * get_comm_buf() - Obtain a communication buffer for MM/FF-A exchange
>> + * @payload_size: size of the payload that will be appended to the
>> + *                MM communication header
>> + *
>> + * This helper returns a buffer suitable for constructing an
>> + * EFI_MM_COMMUNICATE message. During the boot phase a new buffer is
>> + * dynamically allocated. After ExitBootServices(), dynamic
>> + * allocation is no longer permitted, and all runtime communication mus=
t
>> + * use the statically reserved FF-A shared buffer.
>> + *
>> + * The caller owns the returned buffer only during the boot phase and
>> + * must release it with free(). During the runtime phase, the returned
>> + * pointer aliases the static FF-A shared buffer and must not be freed.
>> + *
>> + * Return:
>> + *   Pointer to a valid communication buffer on success.
>> + *   NULL if no suitable communication buffer is available.
>> + */
>> +static __efi_runtime u8 *get_comm_buf(efi_uintn_t payload_size)
>> +{
>> +    efi_uintn_t comm_buf_size;
>> +    u8 *comm_buf;
>> +
>> +    comm_buf_size =3D MM_COMMUNICATE_HEADER_SIZE +
>> +                    MM_VARIABLE_COMMUNICATE_SIZE +
>> +                    payload_size;
>> +
>> +    /*
>> +     * After ExitBootServices(), dynamic allocation is no longer permit=
ted.
>> +     * Use the predefined FF-A shared buffer at runtime; otherwise allo=
cate
>> +     * a fresh buffer during the boot phase.
>> +     */
>> +    if (efi_at_runtime()) {
>> +#if CONFIG_IS_ENABLED(ARM_FFA_TRANSPORT)
>> +            if (IS_ENABLED(CONFIG_ARM_FFA_RT_MODE)) {
>> +                    if (comm_buf_size > CONFIG_FFA_SHARED_MM_BUF_SIZE)
>> +                            return NULL;
>> +                    comm_buf =3D ffa_shared_buf;
>> +                    if (!comm_buf)
>> +                            return NULL;
>> +                    efi_memset_runtime(comm_buf, 0, comm_buf_size);
>> +            } else {
>> +                    return NULL;
>
> This is problematic for the existing use case. With  the changes in the l=
ater patches
> that swap all runtime call unconditionally every call to setup_mm_hdr() w=
ill return
> EFI_OUT_OF_RESOURCES and none of the runtime services will work without F=
F-A.
> There's nothing elegant we can do about this .We either Let the fucntions=
 from efi_var_common.c
> deal with the runtime part (which I think I prefer), or we define a simil=
ar runtime
> available buffer for comm_buf.
>
Thanks Ilias.

Yes, I agree this would break the existing non-FF-A runtime path once
the later patches install the TEE runtime handlers unconditionally.

I am planning to keep the existing efi_var_common.c runtime handlers for
the non-FF-A case, and only replace the runtime service table with the
TEE/FF-A runtime handlers when CONFIG_ARM_FFA_RT_MODE is enabled. That
keeps the existing OP-TEE behaviour unchanged, while the FF-A runtime
transport continues to use the static shared buffer after
ExitBootServices().

Does that approach make sense to you?

Regards
Harsimran Singh Tungal>> +              }
>> +#else
>> +            return NULL;
>> +#endif
>> +    } else {
>> +            comm_buf =3D calloc(1, comm_buf_size);
>> +            if (!comm_buf)
>> +                    return NULL;
>> +    }
>> +    return comm_buf;
>> +}
>> +
>> +/**
>> +static __efi_runtime u8 *setup_mm_hdr(void **dptr, efi_uintn_t payload_=
size,
>> +                                  efi_uintn_t func, efi_status_t *ret)
>>  {
>> -    const efi_guid_t mm_var_guid =3D EFI_MM_VARIABLE_GUID;
>> +    static const __efi_runtime_rodata efi_guid_t mm_var_guid =3D
>> +            EFI_MM_VARIABLE_GUID;
>>      struct efi_mm_communicate_header *mm_hdr;
>>      struct smm_variable_communicate_header *var_hdr;
>>      u8 *comm_buf;
>> @@ -555,16 +615,15 @@ static u8 *setup_mm_hdr(void **dptr, efi_uintn_t p=
ayload_size,
>>              return NULL;
>>      }
>>
>> -    comm_buf =3D calloc(1, MM_COMMUNICATE_HEADER_SIZE +
>> -                      MM_VARIABLE_COMMUNICATE_SIZE +
>> -                      payload_size);
>> +    comm_buf =3D get_comm_buf(payload_size);
>>      if (!comm_buf) {
>>              *ret =3D EFI_OUT_OF_RESOURCES;
>>              return NULL;
>>      }
>>
>>      mm_hdr =3D (struct efi_mm_communicate_header *)comm_buf;
>> -    guidcpy(&mm_hdr->header_guid, &mm_var_guid);
>> +    efi_memcpy_runtime(&mm_hdr->header_guid, &mm_var_guid,
>> +                       sizeof(mm_hdr->header_guid));
>>      mm_hdr->message_len =3D MM_VARIABLE_COMMUNICATE_SIZE + payload_size=
;
>>
>>      var_hdr =3D (struct smm_variable_communicate_header *)mm_hdr->data;
>> @@ -1077,6 +1136,20 @@ void efi_variables_boot_exit_notify(void)
>>      ebs_called =3D true;
>>  }
>>
>> +/**
>> + * ffa_shared_buf_notify_virtual_address_map() - SetVirtualAddressMap c=
allback
>> + *
>> + * @event:  callback event
>> + * @context:        callback context
>> + */
>> +#if CONFIG_IS_ENABLED(ARM_FFA_TRANSPORT) && IS_ENABLED(CONFIG_ARM_FFA_R=
T_MODE)
>> +static void EFIAPI __efi_runtime
>> +ffa_shared_buf_notify_virtual_address_map(struct efi_event *event, void=
 *context)
>> +{
>> +    efi_convert_pointer(0, (void **)&ffa_shared_buf);
>> +}
>> +#endif
>> +
>>  /**
>>   * efi_init_variables() - initialize variable services
>>   *
>> @@ -1085,6 +1158,9 @@ void efi_variables_boot_exit_notify(void)
>>  efi_status_t efi_init_variables(void)
>>  {
>>      efi_status_t ret;
>> +#if CONFIG_IS_ENABLED(ARM_FFA_TRANSPORT) && IS_ENABLED(CONFIG_ARM_FFA_R=
T_MODE)
>> +    struct efi_event *event;
>> +#endif
>>
>>      /* Create a cached copy of the variables that will be enabled on Ex=
itBootServices() */
>>      ret =3D efi_var_mem_init();
>> @@ -1103,5 +1179,37 @@ efi_status_t efi_init_variables(void)
>>      if (ret !=3D EFI_SUCCESS)
>>              return ret;
>>
>> +#if CONFIG_IS_ENABLED(ARM_FFA_TRANSPORT) && IS_ENABLED(CONFIG_ARM_FFA_R=
T_MODE)
>> +    if (IS_ENABLED(CONFIG_ARM_FFA_RT_MODE)) {
>> +            /*
>> +             * The FF-A shared buffer is accessed by EFI runtime servic=
es, so
>> +             * keep the resident pointer convertible across
>> +             * SetVirtualAddressMap() and mark the region as runtime me=
mory.
>> +             *
>> +             * CONFIG_FFA_SHARED_MM_BUF_ADDR is expected to be EFI-page=
 aligned.
>> +             */
>> +            BUILD_BUG_ON(CONFIG_FFA_SHARED_MM_BUF_ADDR & EFI_PAGE_MASK)=
;
>> +            ffa_shared_buf =3D (void *)CONFIG_FFA_SHARED_MM_BUF_ADDR;
>> +            ret =3D efi_create_event(EVT_SIGNAL_VIRTUAL_ADDRESS_CHANGE,
>> +                                   TPL_CALLBACK,
>> +                                   ffa_shared_buf_notify_virtual_addres=
s_map,
>> +                                   NULL, NULL, &event);
>> +            if (ret !=3D EFI_SUCCESS)
>> +                    return ret;
>> +            ret =3D efi_add_memory_map(CONFIG_FFA_SHARED_MM_BUF_ADDR,
>> +                                     CONFIG_FFA_SHARED_MM_BUF_SIZE,
>> +                                     EFI_RUNTIME_SERVICES_DATA);
>> +            if (ret !=3D EFI_SUCCESS) {
>> +                    efi_close_event(event);
>> +                    log_err("EFI: failed to add FF-A shared buffer to r=
untime map (%lu)\n",
>> +                            ret);
>> +                    return ret;
>> +            }
>> +            log_info("EFI: FF-A shared buffer runtime map: addr=3D0x%lx=
 size=3D0x%lx\n",
>> +                     (ulong)CONFIG_FFA_SHARED_MM_BUF_ADDR,
>> +                     (ulong)CONFIG_FFA_SHARED_MM_BUF_SIZE);
>> +    }
>> +#endif
>> +
>>      return EFI_SUCCESS;
>>  }
>

IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
