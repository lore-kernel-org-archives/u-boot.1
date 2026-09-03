Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF3BFC624A4
	for <u-boot@archiver.kernel.org>; Thu,  3 Sep 2026 08:53:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0FBFA80F77;
	Thu,  3 Sep 2026 08:53:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id g2Tt5QV8-E-1; Thu,  3 Sep 2026 08:53:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 7CFAF80F72
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=4; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788425615;
	b=oWGJyhLjXfr0w1WpiQ7MAwURHzgxCP9gdnSOxSxzRHGps6E76YVUaTMvpUZvPIrsLfGv
	 BqLn8je3bZNTSg/t8+2jrY+8fUO9iJD4xAZ1h8JMYA5MAJsgtetmdgxpV3K9CqCrNXzar
	 X2K9r0N+LwHmrw+cI2o+p9/tvpLwIrsHHPG33fIjHULGPOG+fbhHRohkV0aAmPvUDxfhT
	 n42x7ZTMLuDCXo/bxHXxYUTnRr9An9hZ7sm1JcvFFPnPqcpi87JtAB8+jA8Ugvx+SpgOv
	 albYJYdRokMbakqO+wS0xKARawNBPID2PJlZfZwEgp7UgYrp1f7pRnL85fpEBW5LVFQ==
ARC-Message-Signature: i=4; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788425615;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=0NLC3q9FMTIYF1ChymfljkJaTHg3PWr2WVB9R0Nrucw=;
	b=M8mdY/ia4XIetJDiTUbMdE/i+t1VYonlWoPYW4pEVSOw4EY1IOl+wDv73NkB5H1ulqhG
	 lYdvd7F/kOiPfeXMFng8a8yMfcpJ0dO9ExEB4OIey1v5i2QeWSd8yjTqq3oCfP/PMI7cL
	 zSjiDMSPHWc9bw15mZHgysJOnR11EsH3g06Cb6p9CweCzQGgRU/7wRwklzlbVXDq1+8b3
	 F73PPPt6wgUQg7zvDXeHkoCwVq+GDZCUjLo4rVmnj7bf39pW89xhnwo8nSO45T1aMrtMt
	 pve/xw+6DULQS/ROtgpP5aCIjv7cxn3gE7jb+yGD3yODk6XwOo1YPYxByckILmBst3A==
ARC-Authentication-Results: i=4; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788425615;
	bh=0NLC3q9FMTIYF1ChymfljkJaTHg3PWr2WVB9R0Nrucw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=H2ciyJ7rm3Lo2fx3AfdKDxMaOsghphjZKGH4psoBuZBiCzo/tVPup+zWn8DyjbEfE
	 6utKoQcmizrAVe0Jt0tjbO95HBWo5npTmnETH+ifS53ylBCixkKC5byy3o6wQLM6kW
	 1VyQAncq2vhghxwsknc0LEf7e1bGhpULjFM5cLg3VwaYWhNjoIvfBMYGUAnevnFlQ8
	 kDg/zaEH8fYhWVjOE6U90PWL/LXJa3XnbvHzCkGVOMuE1GEdmL9Rc5YrO9iSog3Im5
	 jynM4+qJA4QYoIYgo2L9QQczleCB750iMZFw5h7+xKb11oo5om2r7lOhP1ZSWOi7rp
	 U6NTtBavs4M2w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7CFAF80F72;
	Thu,  3 Sep 2026 08:53:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4E568118
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 08:53:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3FDE0608B9
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 08:53:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SfzHgaAisz3d for <u-boot@lists.u-boot-project.org>;
 Thu,  3 Sep 2026 08:53:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 443F3605D7
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip="2a01:111:f403:c202::7"
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788425613;
 b=ESxWybdXZoo11aNGII/FK2WaUfzKDK7arYTumPEn0Fpz/ocf3/4ryYTjV06Rv5H2pD65
 skWjA1IFy7avzn9xTHWOIQtjl8skAMAO/D/AL6nDK2/FUnaH3SCfOunCMxtwiYvOdqAoj
 QKZgFZKvV3Urzi43CcrZUw9Qx5Me/JUv2kTjQQbixuUfBwwQbwlV5WZTzH3TDja6Fi+z0
 SDdD1b8ibxLAzLtffNWVQl4OunbQbXk1KQXa5W5m3wBhSRXHg8eDTw3S/scS0/wUYSzcb
 JTnZeNGPQGQ+ihHOz3pCOhKAr7oHuCOB4aK1O95pme8gvNjkjZWTSRhAFg3rOP6y2QQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788425613;
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
 bh=0NLC3q9FMTIYF1ChymfljkJaTHg3PWr2WVB9R0Nrucw=;
 b=nI6UMITQiWdRTjCY/A1ny0i4ICcIjp7f5hh5sU22AgzzAHE+f7iftSaUI8pSgTUjqA2+
 9uifJ4OXNI+Qd7NToiydzGejF5m7zOtNYV5k6UsvMhF0Aku+J3ihZHZKJaGAy7DcEnaqN
 fr7vF4juD3P5HcYFuKunl85QsI9wd1fNOz7WWPh2QG48YvO/3sVOSDOt3cQRcA/EnLsqK
 QuvdMbt86t6+zdACVrFJUF7jQXSPfe7HvvRePc8QkIxaitjWgRB9fFhI1JTEzCGHYeWSJ
 3MQz/8hVBv6gns8GjAIGV0SCypwGVG9SWQvKTuCP6z44WiHxTS6JUkc2tI+kFCExA3A==
ARC-Authentication-Results: i=3; smtp3.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=GpS3NcGa; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=GpS3NcGa; 
 arc=pass header.oldest-pass=2 smtp.remote-ip="2a01:111:f403:c202::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=GpS3NcGa; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=GpS3NcGa
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 443F3605D7
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 08:53:32 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=M1J/hVeBiPHHvkzjlAc0FxZcHsQjEDUXbdXtyHdK5R08rJK/F6BgAqACnn0gfQRXbvPGS9Qhy27SEUATCVnVrK9gkf6sj8XaaXy442Gs0DMR+xdoK1LuyFKvmMu+WbRyxb/yNe3fFp165TNJb7+tYkawx2qep+9R3tyzaliOKeOQZrbsouaZdHtveAbN/N00UPB5Uy9KO7fsyG+5lW6SQl3iutzuOtevU5gGgN8LLCOQ71NG1TeHA9XDLIugew+Fe8HP9CQbDfrH9xntSiPNZk0fpiIkz2ep6OLEgEksYqOkA0eLWkFcMsZQhRgo2KeC0uOUJDN5QPfySlLjAzmLdg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0NLC3q9FMTIYF1ChymfljkJaTHg3PWr2WVB9R0Nrucw=;
 b=P5kgZgFjZWOSdv9/6W8yMKy2zmik9eH6sJ6IlBlLQKWgB0kVGjrnf6JbOWV0hB8UF+9VvJfVg4yKoOpXNmCPHagcAaEvFV3tXFuRYl+9ccI5An/dDYJUc219VRxtm7cjejwqVs0okPF38fj++sRDaSWYGf/2919JoKn76zbK/H3oQKbdikwwBNsdlqRlUMXLNXT1QoJkJGXo+uO6AwQvI49gsoV9OregnfYJkb3PuOsRqAtePOPx32oyTzTQFaCIzaVbtAifrSf4JfeTx3XZGWRTJYJAklw7AanYJ7F6OM3HQ/uiW58QNl7EQqVOoKXGHcMILC7q2e7nPBwYmPcrvg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=gmail.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0NLC3q9FMTIYF1ChymfljkJaTHg3PWr2WVB9R0Nrucw=;
 b=GpS3NcGaKMMyUIjcnnZ27R+X9OagiR+mLMpuAZ67B9eMc5s6RbnBU9W6ACvi6cxM7M/w4pu/+O+eyKndFA8MCua9L3R8AP7oMGb0ZmTTnml3z33wQysdJ9bRFVtWK9EBOl4AhlxBnDwpnesFkVruCclmMGBndhDBDjZzmz/UcKU=
Received: from ZR0P278CA0095.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:23::10)
 by AS4PR08MB7655.eurprd08.prod.outlook.com (2603:10a6:20b:4f1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Thu, 3 Sep
 2026 08:53:27 +0000
Received: from MI3PEPF00008556.eurprd05.prod.outlook.com
 (2603:10a6:910:23:cafe::29) by ZR0P278CA0095.outlook.office365.com
 (2603:10a6:910:23::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.12 via Frontend Transport; Thu, 3
 Sep 2026 08:53:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MI3PEPF00008556.mail.protection.outlook.com (10.167.240.10) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8
 via Frontend Transport; Thu, 3 Sep 2026 08:53:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=USbD0IRM6WWyctQ2htv4jJ3eqjaoUTBLOeNGu3C6UoKxIBpwHJTyg7WtueKtfuiQelBZJ2IJLIsCSIYpRQUdcGv5r4VPqoU/a6Z5pPeu9Kb+tz24+d2WjsIGZ7ewYWbhsU44wWrAILtHa1ai9XavvhS0krL63GxADsBwuv7OVQoXPAcXwRYGjnhft+pg0Gp7tknwh+v/Dqz4FVfFeIvFRzKwKDJ2/H17d11vQt34U7UI/AQSvPALD6MwhwWX7fUNw5pwuS0r+gcnmQtayAFHHXqpXq4rTtEjny2OEfeAy5gbwyoQH+aqvvl1jhevUnLcYTHT286yu4g/Iv7UMxaO9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0NLC3q9FMTIYF1ChymfljkJaTHg3PWr2WVB9R0Nrucw=;
 b=YSNpa4Ey2E7tKGgN3qRGvDURmEHus02sya9TIFcUL5Kor6Fca87yAsLnlT7ihApRBb4SjZgpRQ0IOEk8mvZ6uBKY0gJDcOKMC7MaFtwTE+60NwYt56QcDcL0DnHLl3YPDKmtKm67mHb/nE6Zeqz3OByDPy3t6di0wTLWe/s4BTevle1fYYBIf/4++g3y9xRRja1B3jmjHQhSF+kz3HDv4aZBoRjFsY1z439rh8JF18pKJOti7+66BPibxvLIdBV2zDSC38rig6KqxQz4mjENkSxcxlIG9Bd/Wk7rOnykd/AJbcUNqUS5hZDCWkA3Ow0JLRbBtTUbrMSc/6ylM5P/rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0NLC3q9FMTIYF1ChymfljkJaTHg3PWr2WVB9R0Nrucw=;
 b=GpS3NcGaKMMyUIjcnnZ27R+X9OagiR+mLMpuAZ67B9eMc5s6RbnBU9W6ACvi6cxM7M/w4pu/+O+eyKndFA8MCua9L3R8AP7oMGb0ZmTTnml3z33wQysdJ9bRFVtWK9EBOl4AhlxBnDwpnesFkVruCclmMGBndhDBDjZzmz/UcKU=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by DU4PR08MB11005.eurprd08.prod.outlook.com
 (2603:10a6:10:576::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Thu, 3 Sep
 2026 08:52:53 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%3]) with mapi id 15.21.0382.007; Thu, 3 Sep 2026
 08:52:53 +0000
Message-ID: <1443eb9b-3f39-4465-ac98-f1b6f1e9f696@arm.com>
Date: Thu, 3 Sep 2026 10:52:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cmd: ethsw: support lwIP
To: James Hilliard <james.hilliard1@gmail.com>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Johan Jonker <jbx6244@gmail.com>
References: <20260825-submit-lwip-ethsw-v1-v1-1-fbe6142e5d92@gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20260825-submit-lwip-ethsw-v1-v1-1-fbe6142e5d92@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO6P123CA0044.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2fe::20) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|DU4PR08MB11005:EE_|MI3PEPF00008556:EE_|AS4PR08MB7655:EE_
X-MS-Office365-Filtering-Correlation-Id: 4acb845c-8a81-4d1d-eeb0-08df0998d19c
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|10067099003|6133799003|3023799007|22082099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info-Original: ZCRgwfMJq5gVCyzS9jszC75AT74QYVz8SEoa9LgR1leZNTNzvSRE/eOnz1OfFDYdtXS9IyJ2DTau10KhRjIeb7gaxIZ8VoQQQs2TT3M0R8hRsjc4/9FKOlkOPFv+vLXeDXOXB6GS4NiUysZdxsQNcLnWB2aIz/hSlknpPGs1z2Jzsb/rLcIXbO9HfA+kY4zHJVI/2x/srOU5UdAnT6Od6VlwXA5JToZr5e8NLnQkd2nCwsxRPvCl3KZjN9SiRE2NKNHRW6c0Zj4SbG8/DIb9B8D4VN+zMH4xK3qniqxCM72TRXqGKKAF3ZcwjeJgFhG3Q7RcRUN0fD+lKCUNnGjZ4sRpl+I0t8d5d+ecgdzoHrrOo3YsHBW+p/1ZwR1pMqrnWTgoeeVuZ7lkQ2DNQnpoMGF/5wcVXxa1vTQe+0PUmkDYTmaBNEQekGGdDMPWPSiyxn6IOl7UUA0AlfVFfa5kczVMQ7kr2ZfDDHSd5Cuv/naAX8BkprrhWgA8Fytlu4lvDi2FrIAOdL1NrpbCmMLcrtK9UlSOcBJata65UYjG/eL81ktikvWFPQ1rCiKHQPrTlzR1WdgOyZdlx0bmKB0+aFy+ompD6F+cU8hcnhZtUcVcK+K5suFYLJ/sSEEz9G89uSud38yF8LuMXdRa5D9Uao0//u77TG1ytfXJkygUEeY=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(10067099003)(6133799003)(3023799007)(22082099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: KM0z6GxW3PDnNGTVFla1D6u4C47o52Fam2Vv4Z0dkva6ys5tKdIM96wzrASxeUUGlvPq2i9JhFZIKMDFbvQfeaJcgBJf/yl+q0g0MRh5fTvnLM+Y6y54FcA8Bdx9wIDaA5Gnwgm8UqUAhMs5NmnRgsAE4iMRvA7cEr3ahj0m+ASu+mCK3XRg9SYtmwpAFw1PTVSJmupDBxxdJE8KpP3dPe5NJkpD26oyGNsVD1yQYZHb+POziC8S5NNyztJws9i2QNYJCb8JnuNN2/Jn+tXted+kVov4zq9a37C7JUpzHnThLFvPb99o711Z7n25OYLlbXPFPe2IiFS+E7Jop4o+kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR08MB11005
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: MI3PEPF00008556.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: f4a9b865-5606-4cc9-63b2-08df0998bd91
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|35042699022|1800799024|14060799003|376014|23010399003|36860700016|6133799003|3023799007|10067099003|56012099006|18002099003|11063799006|22082099003;
X-Microsoft-Antispam-Message-Info: zZxaHc5/HPAKOF9xVx0hTSXQpSDkEZ5erh2R799w/abpHzdkytfsqEgST/ZYkx7eOpL8flX6GSj8OwRuZ+8EtS3zl7eM6bU6or6Jk4DDyexQ3GK6j06ZtdJ3u9rG/f50phiqAi369IK4Fj7fc+GcDbXm7tGPjOomrufYQilW6hkwZBVkQgtGf8L9hgpsuhwHkPICrY47Tem6I/VzEwdeu8NTsGqrJJo3ZvJuUqbM6H9syu00rYFXt/ehY5m75H2z71xQgBZgazQTFf5NQ0gfOpjlHYBWF2TH3BnFS6HEhnTjulrThrOD1LI7p8Q16KuptuNoo3VbPJF+2lzagazu/nbnkLSmmRPxmeSKygzuW7tXOEs1Rjc2MONGoZU+zrWcdXhp1N5P8sH6uoapaFR5NqtcKtdFLRWkeBmkqkfj6Fe05TOCBKrfKdSK5qMIidL68CMlXP82dkwzAdaz1owD/v/sO814ZVfjLd3CllnYEoGOt0lt8DlEndAhjifHHTZl5eHIB10Y4lt4hjz0mAQEhQzzH2BfTvQJqWn9mdMnEqf8v9F83YIF7nvIm9CF4OTmYUFWxXQ91Zmz9VZbcDUmDcDFbSN6do+GtHBB0pvhGrUcUkBi5wmnwbtO5Fh39XhuBz1zFVjEDdO1efQyYmm2wfxoH9B5SKvzQmz2ZIViNVo=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(35042699022)(1800799024)(14060799003)(376014)(23010399003)(36860700016)(6133799003)(3023799007)(10067099003)(56012099006)(18002099003)(11063799006)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Des7zAlHwG4t/bV4cq4tGEwEJFPPQGtnM78Gi2Fw5O8kgtQBc9/EvldaZvoViV1QOWr4Gmh1Va8/KrB1Pnc+4CN5lQ8FyCMXwIt91C2uTRkuIvxrR20EG+w9mxdYxiVY+3Hs7uFlPPvrRx6YT+g5bB/SMThSEOoXjeNzNI6//3XHzBKbjJ6632lbig3KA1WLoDE46scRRujqSGffb1IuDdhJDJCpKuFDQxj1JW7BSb+GPutqeeX4vrDryljpZf2t2vZhfLILoxQdI9jQjN0kKG3ShDyhgIb6u+tk9rvjaQi+/NxMxrvL+Qmf7aUVmpPbkY0m9jKdONM1JP8RxP9QOXYDZ9W//I5GsDRbuH8X0I7Bw0lR5gCETtL15+Qd8+tpRH0YfNVopYtF+IdAC5spb8WmHHyxC1kUnR1d/l56YZrV0A7S2+ibxsmDnOBlc0Tr
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 08:53:26.4682 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4acb845c-8a81-4d1d-eeb0-08df0998d19c
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: MI3PEPF00008556.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB7655
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

On 25/08/2026 20:11, James Hilliard wrote:
> The ethsw command controls Ethernet switch drivers through the switch
> API and does not use the network protocol stack. Its Kconfig entry is
> inside the NET_LEGACY block, preventing the command from being enabled
> with lwIP.
>
> Move CMD_ETHSW outside the legacy-only block.
>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
>  cmd/Kconfig | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index ff90a87024c..2867e65f605 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -2195,14 +2195,6 @@ config IPV6_ROUTER_DISCOVERY
>         Will automatically perform router solicitation on first IPv6
>         network operation
>
> -config CMD_ETHSW
> -     bool "ethsw"
> -     help
> -       Allow control of L2 Ethernet switch commands. These are supported
> -       by the vsc9953 Ethernet driver at present. Sub-commands allow
> -       operations such as enabling / disabling a port and
> -       viewing/maintaining the filtering database (FDB)
> -
>  config CMD_WOL
>       bool "wol"
>       help
> @@ -2223,6 +2215,14 @@ config CMD_DNS
>       help
>         Lookup the IP of a hostname
>
> +config CMD_ETHSW
> +     bool "ethsw"
> +     help
> +       Allow control of L2 Ethernet switch commands. These are supported
> +       by the vsc9953 Ethernet driver at present. Sub-commands allow
> +       operations such as enabling / disabling a port and
> +       viewing/maintaining the filtering database (FDB)
> +
>  config CMD_MII
>       bool "mii"
>       imply CMD_MDIO
>
> ---
> base-commit: 964ad5b5c91b7be56e443e899d7f873e6aa8c9fc
> change-id: 20260825-submit-lwip-ethsw-v1-b79022823e94
>
> Best regards,
> --
> James Hilliard <james.hilliard1@gmail.com>

Reviewed-by: Jerome Forissier <jerome.forissier@arm.com>

Thanks,
--
Jerome
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
