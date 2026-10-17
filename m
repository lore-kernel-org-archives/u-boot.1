Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3953DCCA46C
	for <u-boot@archiver.kernel.org>; Sat, 17 Oct 2026 02:40:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9B9F1409C9;
	Sat, 17 Oct 2026 02:40:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T_ksG0-RyWQZ; Sat, 17 Oct 2026 02:40:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A69174096C
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792204848;
	b=DFBRURpQDE4n1LoCNH+NwILB+l1NIwFEdOOdXMTCUvbLIMeIjb4YfRp7RHniKq7RnYo+
	 f8IXHYcOXdyy8WkhBlvMecsptDz3PiBy8TwGVw+kvue8rJPIj35Y5BIrJXgeVKfv6YMIl
	 Br+7YTHFOnc+udr6t+9h4eI3QurpFHkefhoRs61sDrnpWIlVHA5oacohVf21AvwPC0j2m
	 8MSJ74SyC/SH2JJPjV21tBFkIS0PoIInaCVsDCpkUBmwwo8aJ30Nqd9QGQSSDOAhXiMBK
	 OnxPWJqCoOwzr4yF43tU+1RedSR73gRaO7hE4yhXj95x7LLY7vjW7nH5203dvDqABqQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792204848;
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
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=dH5PTjX994X2INeobAIvACfSxyp5Z4Vntmn58cz9Ivo=;
	b=sGVsUzZeVot88IA/OnRV6z6Frp4Zan4+Eb5vxu0yGpYebZcNh3YlXInXUVDU0nXB42FA
	 my2yEeuPW3qSYyy5hg+COEdLOGj1a8KjJpL/xlZD/SHD0OQ9/r23i1T2BF1aWvII9zEmc
	 s1JlVIgT1jJu4jOspO97Bk/37GGkLECpGex0hwRVYO5mzsjZDe9sYwN9ljmls9XFbep4J
	 c/PH4Nl7DZvM+SBYY2Q8I30Q2/hOJ9nXj6cj7zM393Xbumy/VORdOFoO0uLhbtua4xhQd
	 u9PyVDKWFIgd9HayNfgqB+8mdVCBOAM9JpJdzR5VLhr+lhOAQNEEyxnMMlg3gDiBBhA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	dmarc=pass header.from=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=fXruLjLi;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=Ctt+YHfh;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792204848;
	bh=dH5PTjX994X2INeobAIvACfSxyp5Z4Vntmn58cz9Ivo=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wA2cF5lXjh+L3yHOo84RXGXMEl4ElmxWLeexxCVRQt90SsnuoAdBYdXgUAsewkaP0
	 McEm6K25F9a3PfLi2t26oLgQU1eRndU7xtUF/GwUQXRgaq1NN5yBb7oBWxFEiGnrWb
	 ulW+NoxHasF25b53ZaXAQL91EMqR1QhB1vZfvLe/t4I62/iSyFrlnJP6CUbJpIcXOS
	 XSwcMxFQSlLmhwX6KWuGoMP4tLe/Bg1yCr3PEEM+MFbtKRkCYw0vjVvvDIv6+zcLkW
	 7+IYqOJhB/wSdP7CPBW529WuzmSnJmf764xnAMvIq2Fk5HX26Vi5KCk+Q5jvWhi+tx
	 q8XfRPjLN097w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A69174096C;
	Sat, 17 Oct 2026 02:40:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id A129D362
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 02:40:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9267B4096C
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 02:40:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7JroByTdSFW4 for <u-boot@lists.u-boot-project.org>;
 Sat, 17 Oct 2026 02:40:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CDE2340967
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792204846;
 b=Ep4jie2A1KzxSOffeHSX8g4rB6/532w8miXmCU3MNopRpqCBK6j1Hz0mEhadSC6zCuey
 kDIJrDl645wMWYciL+24iWKbnNPLhREG7EBHp6Ns26Y+2hg5E67Eet7K7N9awX1yNZGqO
 dUAl5gOI0qRDkkTMcN2V6jmxrWhvVzX7xi3prKnfyGoNVWHsYcxkzb5c3Xw5SEHgjHaal
 DprpLYVPsQ88Qf6QChjsxx+ZGuVsRNlZNF1uxi+CL32c7PDPjXC0uTPuO1lxpKiizM4Am
 xCc2JSfLMaQdL7IKk1iTcQujI+jMAu1rJ1KZV3VmfYziqkyLD9+92uWYdIAcpLzRlrw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792204846;
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
 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=dH5PTjX994X2INeobAIvACfSxyp5Z4Vntmn58cz9Ivo=;
 b=U/UfA0yBvb3X0yrNBFWDHcxb/We1HAffUGAs238ofEYSy3Uhdf+EJwd1dHFNtj851Wyb
 hPNfxtwmdjUE8K9JXu9rqNp6Hfkcsrhs3W7yOOwkEg8JWRF5zYKxDfu36KEzHgRGFpgOx
 mgblDSoNGxT4dvm9aqi373E6yOu46mKCMUbK9WC+pXINaYRllwmRp0aqNPnezTmNRrpcR
 ZlxTZ1w6uXceGXFLhpB3B0rTCqSw7Y01wJou8zU7Qf0A598N6bahfqqlh0HhAlHf9PUYe
 fGly62WsuMP+ec0EfeMcnG24AxjeQA1UAGSedNbo4KXOZZySqbAl/Mw5/b7dw/rPjgA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=ti.com;
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=fXruLjLi; 
 dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com
 header.b=Ctt+YHfh; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=u-kumar1@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=fXruLjLi; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ticloud.onmicrosoft.com
 header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-ticloud-onmicrosoft-com header.b=Ctt+YHfh
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CDE2340967
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 02:40:45 +0000 (UTC)
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GNEx2x2034109; Fri, 16 Oct 2026 21:40:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=dH5PTjX994X2INeobAIvACfSxyp5Z4Vntmn58cz9I
 vo=; b=fXruLjLitHEi4ZoiWRfD/6sohUBj5aW9PJOKcS2prqyzlRsJO6rbn51aT
 KA7Fn/LPczosxCdjhqz5ZoPWOeOpn3Hnpcs04znSznVUP/epQi+xuzwDpEKjkQfw
 Gww4rFp0Oa2xHWYfDmpKYcWZSs66arLkEFbI9bqdLF6xs2CM5SJVv5knUkgGybm/
 vxyg5HHhR3lf5zd4YtoQq4CgqRtPTK5YFgEjXANK1FSyMvHjRo6gjJfW+CxsV/Tt
 q4r2oGpJOX3jktXH6EY72UsLAXuUzKTLl8iJ3tG9CG3JpNCFeF1Kr+KnbdEXlEPL
 s1kEi+iJhvX0CHyXMtTb2JC440KIg==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11010009.outbound.protection.outlook.com [52.101.85.9])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4hbum7h0gy-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 16 Oct 2026 21:40:31 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qOYtIV3tHzdFDoQ7njcNKINN1cWuQP5ObI4mGE4EIiTqXC4Hbnb5VHWoPqz/J3DE/7rGm3IsJZWwtODIS4jehIlI/szbBDwp8dN4tskfyjV1nyAuZ81YdspkqkiNLxjOv2Q7VPrBZ92AxDoLyoZUA5KmNfzRhu791R9ic0ZtukgNORsSH5TU6X4B0p1lP0YYMJkUKU5AviDvP75tFuEWpoaOOE8AO4dG2F5xo3smItOnBAAe23rx8X027r6vvJ5WRwOPhmY0oTFSlpCUT9664LubaoGES/btYwhb1ehJ84Y3aESjq2N0vz0MYpS3esoClXyG7A4PDBXI+5gm4TNAyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dH5PTjX994X2INeobAIvACfSxyp5Z4Vntmn58cz9Ivo=;
 b=h6O0wK7hv76GXkNZH02nFFG1ITqIHvZiS8WPOJ+cYGvZurZwx+bV8US68/ccAoCrrWM2r930l1SJfwtbP6OILnvqp6S6k34Sns+J151L9CQh30Kwf+Nx4UABg44JX2kR31wizNB/rjQlV5AiTfX0I6KWL6rvkXU8EenY2VsY1+GaXEsbtlne7bp2LU+kx4q3vObakYtWVs/LlE4llcqDc9cvgmR+75Zk2Fz6TYzbMlndohY5g9ssbKo6RQZ4aLMp944zgVIb+EIc7ZtbL8uANr7QlPwyjpi7b6IJbqFzB9TPfUp7MU9OR/a68C9iLgeZnNMKH5jehrAP+PvsdKXCuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=canonical.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dH5PTjX994X2INeobAIvACfSxyp5Z4Vntmn58cz9Ivo=;
 b=Ctt+YHfhRRvZVmtxsSpagE5V1N3TLRJz7WABxloaNs/Ts3wevmT5ynzGDglGkXasDAmegc7LV739bb2WV4k09rENs8QS/i4VqLxnh2SnddOEIJBhkGBxjk4zZUkw8B58sWg6q+LLqG2flruP1VpX7w9P0QaSTlRdN18hXrjCK5M=
Received: from CH0PR04CA0118.namprd04.prod.outlook.com (2603:10b6:610:75::33)
 by LV3PR10MB7961.namprd10.prod.outlook.com (2603:10b6:408:21d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.12; Sat, 17 Oct
 2026 02:40:28 +0000
Received: from CH2PEPF000166BE.namprd04.prod.outlook.com
 (2603:10b6:610:75:cafe::7e) by CH0PR04CA0118.outlook.office365.com
 (2603:10b6:610:75::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.17 via Frontend Transport; Sat,
 17 Oct 2026 02:40:28 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.194) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CH2PEPF000166BE.mail.protection.outlook.com (10.167.252.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Sat, 17 Oct 2026 02:40:28 +0000
Received: from DLEE202.ent.ti.com (157.170.170.77) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 16 Oct
 2026 21:40:27 -0500
Received: from DLEE211.ent.ti.com (157.170.170.113) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 16 Oct
 2026 21:40:27 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Fri, 16 Oct 2026 21:40:27 -0500
Received: from [10.249.135.178] ([10.249.135.178])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 69H2eNBQ3631295;
 Fri, 16 Oct 2026 21:40:24 -0500
Message-ID: <be2d29d7-0ae4-4110-aadc-b418e4a7f96a@ti.com>
Date: Sat, 17 Oct 2026 08:10:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] arm: mach-k3: j722s: Wait for TIFS initialization
To: Markus Schneider-Pargmann <msp@baylibre.com>,
 <u-boot@lists.u-boot-project.org>
CC: Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Daniel Schultz <d.schultz@phytec.de>,
 "Richard Genoud" <richard.genoud@bootlin.com>,
 Anshul Dalal <anshuld@ti.com>, "Aristo
 Chen" <aristo.chen@canonical.com>, <u-kumar1@ti.com>
References: <20261016-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v2-0-c7ab53f79b34@baylibre.com>
 <20261016-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v2-5-c7ab53f79b34@baylibre.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20261016-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v2-5-c7ab53f79b34@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF000166BE:EE_|LV3PR10MB7961:EE_
X-MS-Office365-Filtering-Correlation-Id: 3046f206-6468-49ff-de88-08df2bf80128
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|56012099006|4143699003|261009223027099003|10067099003|18002099003|22082099003|6133799003|13003099007;
X-Microsoft-Antispam-Message-Info: oN7uc8w/wsp1N+g/QuhNr+S5abaP5v2EN9cBP0opbvQSCP4dx8XRYgnBybxorz6YjsFt178AFRU5Gwzk0IhJFk1T0IJ8W94Lyy32P3LHx59Qe3mbnvQOjpH+ElMZE5VAumdMqPFac6gN4bxX1DFy/Pwf3VqLozI7uyGwQpoZpIGccYHCUJpCzJF32WXj5nBznHnsRAz7x8VVLFdwgS/85FVELt58Rfvitso0fwaQL0YpFia3OqenC1Gg9oq++bsjL6kgWcWnMuBRgXA4PMYai0KhM7l4LrPVj4S64tl5AHAImdLe6pei9xXtNTertrFk0w93qzWiPV30mBUladDkZOjbEydOIsX9j6cbS/nTTe68QmJKJpQ+lA24+kAIGBvsLr20wOaJpOjEq0UEZmvyMmrWjF9vTjsCriQqHn28B+rZKJP3t1hal2+PusbSUzNOz5RcqCy8eL9OSgeojmcLcmqGIEbeTR+OHaSXzUGVHo0f0TjMOgPTdbEJplL3H/aGmYQ8K1wIvPVgpzOK1fQeOiAGNToIwjVMw0A57rPQXSWBP+uv6dXmISGfBXx/E7IQZC/lEewBgMaNvVWc56umz27l3sbV1t+htpoELh+LA0XHPe3mOpQ6TpX38PsOB6gWQEfWVzSRb7PNWQRQwL7yFA==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(56012099006)(4143699003)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: h/DGizjMnCHfg2xcg6/LbWwLeNZS+dxOnmilzfHFaKQp2YmFhA85z0ygaCCS16s0KZ1pfbc6tkc/zM4v8vhDsDAjBGmid7+L9acbdYzE37Mnb+VS7WGDBd2MM5EWN8flM/BEa0kTX5UXm77hPWBr+/Xj3poY6mxY4uFdxpgo8q5cOpLZA6nKn4WT8ldop+cGkIGMeEMnlVFqg16XXw7656Fsgfx6W9JdvOaIgVEWy97yJ1+JKiuxYBMXCUZ4x1SZZ5QySOlVBo4o+FcdW9OS47FNgOt5fI+PeBk99Wv95UI8FgPtSUKnvEXy2R88ngDFNuelh8OABL2uNMQSXOLLvvO6IU2393gGuO6BbD6lVK/rDBZBDpY3cUO8JFCC7hhm+UOYhUtdjR7dzp9XahgxjzeSGLrvBmofxG2O9ZSN9m2k9pa1ryomY4N2j/m9E5eO
X-Exchange-RoutingPolicyChecked: cqWcvEwCI6LYIkzxneMT9ygn3U1wNDWLqw/nvcb5xwnTZKweka2D6MyA7XwrzkW9AQRtbCNNx5JQ/COrfm+7Q5IpFHCD7uVMB2ePP2rkUeZUJz6xO94ekrRlWDfNNDp/O3Pj0cwSVIoYw35dJYPlthsn5FNf9rnptiQRiU2Pyi/7d6cSjRYDv8Mfi1HkiEkUiET93dJ4lWOA4LCsc3mfqRjd8zs2vfm6DjKJTA/ilfXOztxHSe4ZdLwoclAWtWFNkjY1D/D7pPEpJvVygjP1AnR6PV1JJhvs2IpuL4h4K5kB5cKh9HrssTePxMA2WDTFDMsIagRkGYxluAvi+4vSkg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2026 02:40:28.0169 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3046f206-6468-49ff-de88-08df2bf80128
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF000166BE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7961
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE3MDAxMCBTYWx0ZWRfX88dTmRBufSan
 S7p5Dw2dxzC1+PETlOI6CgXY5c25iuhC2az8vkC1f/QtSI7USiYlSScVCbxTCm2+vaG5uA+5oGr
 0Lq1oLHEnfmwA6k07p66r0iBx8H2kQM=
X-Proofpoint-ORIG-GUID: ZvrzW_-D2KVD4C0Keg4e1GuVZd4SLxmS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE3MDAxMCBTYWx0ZWRfX+Wcyfn1h4oDU
 Go/1+7Buv3jV+7/16NSDzA5OwHnVe5b/xwsyNKt/j07r17YC+CnR1MGvg6zl0ygwbJpwWSdDX5E
 r2P54jqshbyRPVea5MS4qS5s+HjBFsBsAm2cTFYM1athkvNEcf2Ij/QiDljCMFZ/UsSXGhssqDW
 QzRvHkiia5YsNuR33He0bWZsUOsopbRPSa/Nj+IOzbRtKDwebKqp9Zk6/8+p/dIIrvxd3eMWVrl
 RMZsh/pKMCHmaZHnXcIh4Pru623xOQSwtq9p2XcIq1m31vL00oGwWyUT1pYrZR7e0KwO5uFajHB
 4cStdBLlteBC4CQiBBTr5doT9GWjJsR+n0BL/hoU2YR/xkK1fsJ7I09ozCy3oZ5dGYI/ZTvd3yZ
 mEQmjKMFe/ksW/oPGz8XrNmamCOHGaRQ9J0LfAwmdPZCzRKdVqwOu6sxmuOmpkLZTIYSeCihH5Y
 IwaKhuPu0D8mBkpkGKg==
X-Proofpoint-GUID: ZvrzW_-D2KVD4C0Keg4e1GuVZd4SLxmS
X-Authority-Analysis: v=2.4 cv=F8/C5ahN c=1 sm=1 tr=0 ts=6ad2e01f cx=c_pps
 a=A+iiJIZ7q7LOtbDGyL1ITQ==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s63m1ICgrNkA:10 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22 a=VwQbUJbxAAAA:8
 a=sozttTNsAAAA:8 a=IpJZQVW2AAAA:8 a=-DW6mhNxQbdyjOWq6oYA:9 a=QEXdDO2ut3YA:10
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_04,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 adultscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610170010
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



On 10/16/2026 2:35 PM, Markus Schneider-Pargmann wrote:
> On HS-SE platforms TIFS takes longer to initialize. TIFS only removes
> the firewall on the registers at the end of initialization. On HS-SE the
> U-Boot ctrl_mmr_unlock() can happen before TIFS removed the firewall
> leading to a race condition. This leads to a broken watchdog since the
> signal configuration doesn't succeed because the write doesn't take
> effect.
> 
> Wait for TIFS to be initialized using k3_sysfw_wait_ready() before doing
> ctrl_mmr_unlock(). Note that spl_early_init() needs to be done first to
> setup DM.
> 
> Link: https://lore.kernel.org/u-boot/20250815160240.3575140-1-d.schultz@phytec.de/
> Link: https://lore.kernel.org/u-boot/20260225051559.416445-1-u-kumar1@ti.com/
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> ---

I have tested on J722S hs-fs and hs-se devices,
Post this patch wdt reset got functional on hs-se device.

So for this patch

Tested-by: Udit Kumar <u-kumar1@ti.com>

>  arch/arm/mach-k3/j722s/j722s_init.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-k3/j722s/j722s_init.c b/arch/arm/mach-k3/j722s/j722s_init.c
> index 1180c75f551d..c15b3b2682d9 100644
> --- a/arch/arm/mach-k3/j722s/j722s_init.c
> +++ b/arch/arm/mach-k3/j722s/j722s_init.c
> @@ -84,13 +84,14 @@ static void k3_spl_init(void)
>  	 */
>  	store_boot_info_from_rom();
>  
> -	ctrl_mmr_unlock();
> -
>  	/* Init DM early */
>  	ret = spl_early_init();
>  	if (ret)
>  		panic("spl_early_init() failed: %d\n", ret);
>  
> +	k3_sysfw_wait_ready();
> +	ctrl_mmr_unlock();
> +
>  	/*
>  	 * Process pinctrl for the serial0 a.k.a. WKUP_UART0 module and continue
>  	 * regardless of the result of pinctrl. Do this without probing the
> 

