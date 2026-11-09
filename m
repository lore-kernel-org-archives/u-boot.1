Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B43606A321
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 10:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=of/jj5a2;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=b0DYFQj3
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 00F8D40676;
	Mon,  9 Nov 2026 10:45:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GGclRcq4kvQb; Mon,  9 Nov 2026 10:45:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4B9A040648
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794221154;
	b=CXFL7UYOGXrPD4y/cobSWtV3e4BZBFz0iN28/jisfv23KXWbS9MqFSxznqZnDQvDyFlp
	 36beTZPzFI2Vxdi6eQksZ+WpcTB0At1JYHlxTcPXeJJXf3dPOcSt7Re8XZH6wOFptOZC1
	 QSWWC9s7XUQXxMbllNcUZfXelsf7IhCvIO7qtclSyzX+/qJxiS+ew09Nt8Qztrd+DURB/
	 pVp6yX9m8fNZnmg0QiBYYdvAaP9H9EWNQFQ3Lg/DRTXhs4oHCnxdvYWUnU/Tn8SSAAEd7
	 wX7YAFlSRC2GnMst3DtbHJrLzRufKigHzKiXtRoSgJJeQz2B2f1VsVH3h2rTErGr6IQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794221154;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:CC:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
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
	bh=0S+UE9c3DSELyoiwfXSWPC1uGQ/XOlR6DvzbM5YQn/8=;
	b=UCXPpmj4lnLV8RJ/fzt0G6rYmO4/N7391H6cF7gyvDIAkdxmhVT6CEntfxqRhE0oVA60
	 zwfE2D2VtpusSIRxTD5KhLoVnj08yyQfK/VtfVWzRhQa8ikpuHLEpqq1dRpwrLfcXdVJ4
	 RzBxs0HwHoaC4iwAWTZ0Xvm80Q4CriXIx6JR9jzO6MiZM72wC6FNfDJGc7sT3zaOF7DmK
	 mNVQWcxTG9ltUVllZaoUZpOvBlAU5SsGm2fMAtJgolnxjKvlOxpdQPacccmTeJLkTtdWp
	 rMrtm9FfCopbDrRb2ErXRxWDgXcYk2HN73pK2dEWe+VRSlCS8CYqERIU02QVQz3l9fw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794221154;
	bh=0S+UE9c3DSELyoiwfXSWPC1uGQ/XOlR6DvzbM5YQn/8=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=of/jj5a27QqZipPbbw60qIFf2/Vl5KyLaVu9tEk7n+ihmJftYU62p2WG1RV4PUvGw
	 /oPEujC/Dh5SqYI1XGOzs2vGCiDODJO+Y8jQAziq/pQkK7PjJeqT5SK9R3jTLAP7Za
	 CqzK0XXpndKv9k07SsapSiy8vNmTFnOnsPn/1/dFDiBRjrNihW0Ylm7BpQ/31I0r1Y
	 PJIEYJ/feHdnEogqljsPF7qkwldhex1iHliYHkH6FAc3W3rBbT89QmiM2yzVI2uZTo
	 mhjbtupFwYohD4P2v1T9Dulc4vN9pHrbsxGZrjmn6emOxjBZojWpc/Rk12Hb5ZwvNR
	 loSJKmpMrMB4w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4B9A040648;
	Mon,  9 Nov 2026 10:45:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id DE77C361
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 10:45:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C10C9401FD
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 10:45:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mZf-rvLA46Q2 for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 10:45:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 96036400CC
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c207::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=patrick.delaunay@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=b0DYFQj3
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 96036400CC
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 10:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0S+UE9c3DSELyoiwfXSWPC1uGQ/XOlR6DvzbM5YQn/8=;
 b=b0DYFQj3gysfWG1nIy+awK3v+kYy8jqDmADQmJdrew1X0n++8pP3uw/1PIWKdre1K3FZyyXmvSBLOg9a4Dg8zCB9UtWj0p0mc4c1cuEklhJAfUxUqF25a8SnFTJSbufmWEwrPEV/0iZV+sfAkLTsRJ7h1svoZd3WffI3GX8z3PtnSNy/Gn71vQOsczw/w4rAKs3MMpV+MehRlvWG3YzjpiYEvl60/q1Zc41cdz9g9DchY4hf/YWC0Odzcj1Ddo2d880/k7h7r+ZyPxwgNZ7s2crdxJQ7dN9FrLl72zWBwEoUfeHyV8YtSYQ33Zc/ucErGGJ860l3BLFO6HNOIezVtw==
Received: from OS6P279CA0022.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:33::17)
 by DB4PR10MB7424.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3cf::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.7; Mon, 9 Nov 2026
 10:45:40 +0000
Received: from CPH1EPF0000051B.eurprd04.prod.outlook.com
 (2603:10a6:e10:33:cafe::8c) by OS6P279CA0022.outlook.office365.com
 (2603:10a6:e10:33::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.13 via Frontend Transport; Mon, 9
 Nov 2026 10:45:40 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 CPH1EPF0000051B.mail.protection.outlook.com (10.167.241.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 9 Nov 2026 10:45:40 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 9 Nov
 2026 11:46:19 +0100
Received: from [10.48.87.100] (10.48.87.100) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 9 Nov
 2026 11:45:39 +0100
Message-ID: <86c4a66b-43d3-4c16-8d9d-39c38a4e0e3a@foss.st.com>
Date: Mon, 9 Nov 2026 11:45:38 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] ARM: dts: stm32: disable iwdg2 in
 stm32mp157c-ed1-u-boot
To: Antonio Borneo <antonio.borneo@foss.st.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Tom Rini <trini@konsulko.com>, "Ilias
 Apalodimas" <ilias.apalodimas@linaro.org>, Lukasz Majewski
 <lukma@nabladev.com>
CC: Thomas Bourgoin <thomas.bourgoin@foss.st.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>, <u-boot@lists.u-boot-project.org>
References: <20261105165253.587809-1-antonio.borneo@foss.st.com>
 <20261105165253.587809-3-antonio.borneo@foss.st.com>
Content-Language: en-US
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <20261105165253.587809-3-antonio.borneo@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CPH1EPF0000051B:EE_|DB4PR10MB7424:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a3cae6a-9c49-4a4d-644a-08df3e4e98d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|261009223027099003|11063799006|4143699003|56012099006|261021121427099003|261026121527099003|261102123227099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: hrhV7Gwsppdiy7yhSOYs8gqV6y0jmXt1EOLxKrCQapMq5rHTtb3l6Cz0d9ukIxqfmduVuUGj70+i/ZlR38kcO7gOKlcyiujsCojugMwkzfnu6T5q0LpGjTrTYPwmlnVoBeA1LlI5jbsKYWvynce2apA/5WaScV4klANKiBS8Um4VtMCy0YDN+f4N2otY0M/M+qhqiiWZr+xTicvi8N5zY3QvFJY7D2m3av79oaF6wiR7q3yNcmw71doyFVJQwuUE+mq5ES9ZqFkT9GsJWmwDvW5Kl6WnZfhuSArDpP3N88lmV+YapSE+wbZru4AREuNCRHpQWgrGTnrkmFDiy07FFeoRxCBDUBe5/tt9kLkm5ei8ujd7Fj0Bddzz/DdtNOc1wGoxAGDbtnA13+RraAAbgk9w9j1jdWaOeA9Ea31Ozu7cS/ZE5RUVcTVxFhQS757HypNV6jwkTqESB0LyQMrUC6zTBnn12igX87y/d/UgDKpM0WWLCx/hNR6Gvd7f3fcsJ3DUg6B0Ujqc5lA1A/SjdunzaGYg9bdaxk/7GBVInx4p9C7mIoNttke6yKt/wwDTI+YhRnKXHt4nmxg/8l5EE/iXa6B8rhPzuL3Y0+f7siXhwEfjD/YfbPDsTZ6O1+mWz3ByBlrm1+dMfNCO6cvj8HsUrPzfOQSnU/oMjpsiJQWJJHcbpUqp2x9UJKHgVrCNxpFVXNBF7wV8c02EJG318g==
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(261009223027099003)(11063799006)(4143699003)(56012099006)(261021121427099003)(261026121527099003)(261102123227099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: akn8kSmygw3lnR200h6WmINqjYOZkKBu6dvluO1qk06TIAvIx6VUTs8SORyMdywQ2RLBtXMQzBWpjW7g7Ns3z5ICtH5pMj+HaAqTF0vlCuAhYX+/O9MAGdmJAdbjm+WG5oNF2cIkZ+zP3ZcqcfDwhSY7L5yPKZnYKm9ZmA+vRcx3sKShOuQJbzL1qGsR3X57PXqbn9BUQcGCu5sNtV70zxgxjgvAmV1clbKiuomOe2LBiB/x5temrIBWf+myG3aLOIkFNRNeH/os/FJCxB1lkOiKPFBiQBS+CxNitFi3/YXjzDKYNgQsA6BZLh6nBE5YWPuaGaPTJfVKEYsB44+QPqvonCniAqAm/2eGWtiGVFth7CH8+5y9x6lKuDejn1NM3YCMkj0tDbNYG40uzzZKJ67C6lBYSWRSDCESBeIlwkbPg/m4D/n+P6SvbhL4DUaV
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 10:45:40.1528 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a3cae6a-9c49-4a4d-644a-08df3e4e98d6
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: CPH1EPF0000051B.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB7424
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On 11/5/26 17:52, Antonio Borneo wrote:
> IWDG2 is not used by U-Boot, but its node is enabled in the device
> tree inherited from the upstream Linux kernel.
>
> Disable the node to prevent U-Boot from starting the watchdog when
> 	CONFIG_WATCHDOG_AUTOSTART=y
> as in stm32mp15_basic_defconfig.
>
> Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
> ---
>   arch/arm/dts/stm32mp157c-ed1-u-boot.dtsi | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm/dts/stm32mp157c-ed1-u-boot.dtsi b/arch/arm/dts/stm32mp157c-ed1-u-boot.dtsi
> index ef97a1184a9..cc986ccf50b 100644
> --- a/arch/arm/dts/stm32mp157c-ed1-u-boot.dtsi
> +++ b/arch/arm/dts/stm32mp157c-ed1-u-boot.dtsi
> @@ -72,6 +72,10 @@
>   	};
>   };
>   
> +&iwdg2 {
> +	status = "disabled";
> +};
> +
>   &pmic {
>   	bootph-all;
>   };


So I propose to change:

+&iwdg2 {
+	u-boot,noautostart;
+};
+


regards

Patrick


