Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E3F606A31C
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 06:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=wtnjFz6Q;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=ermsLPo0
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 151A86083E;
	Tue, 17 Nov 2026 06:59:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8vAsau0miWQY; Tue, 17 Nov 2026 06:59:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 944E66081F
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794898789;
	b=A0Yc81HPBtCHWUhws85ooxT2uvM+ech1Rqlyv/HtAIqblvnY1+y8WAoZoKlGs/0F3bNL
	 +SfjDhJiOBvL9BK+X0g+p/FY89+jDtATOxKBrZgxThYOxJnjMnJdI978pwHweCFg9vUN5
	 b02cYNUe1mXBfica9w7b+7GA+SrLCu7jFfY4jsV7gbhyN6HO08FShrgMvIM+FXet9bQyc
	 ysm6Y0Z7qAhuUOE86FmoRABaMt+fF3SXqi5lRPrjpBNkVO8IFryrbDjab/mbeaXx4vOUd
	 kfOkJ9YpyC3WLphXxDWZOIwdEtbIhybnyGcRzxDf1bHPRmQiVBFRtRY0EYVZ7vOyVxw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794898789;
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
	bh=pO346vfwVHm/SUkPGR82OPXvOvqloRw9lZe0WLbCrys=;
	b=FojIg007s20ujieWvdwAzFARKCCfrmYtjseWET4X67kJvFTeyA5t5A1h37TtkhszHsNk
	 VtqM7LdEFS50rgct5eIXWBRUX0TQjf/JzfiKnP0JM0OgjDvAEQ+yAizu6aXlElZTBdTdn
	 VR39YxHx3P1x5PKwaz+Lpz6UKjSv7suBhXR6tSH1N/HE1mSIhEDzLeZasmtLrRAXpEBJx
	 otXHQJiQmy6UiGq+7VhEXGPL32t1Aet5fE4OhE7KANRvKkrZdPgGS1iSvoFcwRTTKysK9
	 grj8E4Pt6TEbbfqKdrKK5UvR0m41C5cryopOcklJNNjSHLFNRXIp3XNQQczo3uclRIg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=ermsLPo0;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794898789;
	bh=pO346vfwVHm/SUkPGR82OPXvOvqloRw9lZe0WLbCrys=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wtnjFz6QnhafFwQjdfp3LP2ohPqCg8DPEQ+6GwizPJZP8hSAsbz1K1MBvuxmqE/IJ
	 F/Zb/OIJRVF9g+H/k5SclQVKaylDNjD0dU3PWaexNhFpPf4OHAVsK+YS3wYHJA+jfS
	 ycik5P3m37U3QVFTASI/aTc5KY7BZ5bjOcoXxHSHiV24dEenkEaFUUi87WsEyOeZFd
	 me3T8b6fnA+PYTjCAKykyM6c0lGH+hLS5EvnbLNi2VZN/htzpS0dXQIZI/Urq2H2+x
	 FXag1MVT5lqqJ6eUVglH+VlqhrmIdE4q/zocp0sUU3L38DRvdcKPjH1YuvgR3MKYJu
	 Yl54+t7+1SN4A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 944E66081F;
	Tue, 17 Nov 2026 06:59:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5DE1C13C
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 06:59:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4F56C6081F
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 06:59:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 02jdwiN4CnVr for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 06:59:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5BCCE605F3
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::3;
 helo=du2pr03cu002.outbound.protection.outlook.com;
 envelope-from=patrice.chotard@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=ermsLPo0
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5BCCE605F3
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 06:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pO346vfwVHm/SUkPGR82OPXvOvqloRw9lZe0WLbCrys=;
 b=ermsLPo0IdkoDkIC09bffQyP8kGPf9Rhvbe+dTJ5cx0zXTtAKpw0zbBSf6+4bScAES1owN3Ay/2XerKqOQ6QSwzSIpV98xqLHtj8XHxofB6Ig5BwyeFrjiIVbULWzIc0nl/uhJARYbgNuZ3nE5W7vjxfBdjnsovOegb+Y7hIlGLy5T4plmE0claVItTO1IIhf+YoV2MHfamnU7WbQZYTKo0msRhQ0UBbeGx1RNSt5oplau1gt5Bsjt0nGikDu7GFdX3zuTyeMw5ITwyMri4fk1gsPDle0Tl/P8lNh0bjcSO601v2YOQURcvy8ZYGRLu5ERIdXldZc+wVMy7Cl2h2Cg==
Received: from PAYP264CA0035.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:11f::22)
 by DU4PR10MB8709.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:56c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.6; Tue, 17 Nov
 2026 06:59:31 +0000
Received: from MAD0EPF000008C3.eurprd05.prod.outlook.com
 (2603:10a6:102:11f:cafe::5) by PAYP264CA0035.outlook.office365.com
 (2603:10a6:102:11f::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Tue,
 17 Nov 2026 06:59:31 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 MAD0EPF000008C3.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Tue, 17 Nov 2026 06:59:30 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 17 Nov
 2026 08:00:15 +0100
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 17 Nov
 2026 07:59:29 +0100
Message-ID: <724e7a69-8c8b-4419-8dc3-fcf02fc7e6d5@foss.st.com>
Date: Tue, 17 Nov 2026 07:59:29 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sysreset: Constify driver ops
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 <u-boot@lists.u-boot-project.org>
CC: Bradley Morgan <bradley.morgan@linux.dev>, Daniel Palmer
 <daniel@thingy.jp>, David Lechner <dlechner@baylibre.com>, Eugen Hristev
 <ehristev@kernel.org>, GSS_MTK_Uboot_upstream
 <GSS_MTK_Uboot_upstream@mediatek.com>, Hiago De Franco
 <hfranco@baylibre.com>, Julien Stephan <jstephan@baylibre.com>, Kuan-Wei Chiu
 <visitorckw@gmail.com>, Leo Liang <leo.liang@sifive.com>, Mario Six
 <mario.six@gdsys.cc>, Max Filippov <jcmvbkbc@gmail.com>, Michal Simek
 <michal.simek@amd.com>, Sam Protsenko <semen.protsenko@linaro.org>, "Simon
 Glass" <sjg@chromium.org>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Thierry Reding <treding@nvidia.com>, Tien Fong Chee
 <tien.fong.chee@altera.com>, Tim Ouyang <tim609@andestech.com>, Tom Rini
 <trini@konsulko.com>, Weijie Gao <weijie.gao@mediatek.com>, Yao Zi
 <me@ziyao.cc>, Zhuxu Ran <zhuxu_ran@zohomail.com>
References: <20261116174340.3488324-1-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20261116174340.3488324-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAD0EPF000008C3:EE_|DU4PR10MB8709:EE_
X-MS-Office365-Filtering-Correlation-Id: b7823a25-23dc-4c99-3e32-08df4478544c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|36860700016|82310400026|23010399003|11063799006|56012099006|10067099003|261021123027099003|261021121427099003|261009223027099003|261022105027099003|261102123227099003|261026140227099003|261028144727099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 83KrQW8WZdqF0wNmoylv6hpeA6Ff7UWPhl6DI3fUg286x0XxreeD6wqphIZiyNRQ+dpES6t+bN4iR9skr2ydADRJi+fQuhqFk4OhdcXtpsn8JpCU1cgBmPwNezAX0eK2Q6KHij3c+oMb3HurQO1+a3JEca/ZnwJ3YpvVvuzUyngGVNsOUWdny0TlRJlg4XiLkonSw8iPuHiKkgCYmv61lkY7A6LRgloofgeAU/epYthpvgrhJ9oq/RKTArd/pQoKL2Lui5Wsbj2cSCazsffUQb7mvPEJvMk/520etcf7UzD7T9N4ME96wehu9t6eRTLkzvSD9PxR4xWik5WvdwY0rlyvpzVc0kei2HN92ZH3uNKb5ykHbjA8arwKOxpQ/rsqsK39FItPkXGGVED6RvNScxiI58pBETi8CXHizx/434/HM2RU1FTByW4w3JLzevRTF20M8PUEReCIn07s+4xX3tQgO7eCrGKpiKSpR/F06rF1dCq+cqITqNrLch0f4GzzR5p4Jr+TETZVNkheZgsDTIhUKd0GH6Z4V0ZzHIOk+pZ8CDfhe0wxHvz1jBc+Ug9czfAZFfSepH8TfzminyUdeTuX5dh1aq6Zt7rjM8Z8QfhNxxffUoYNl0HwN4pEdVA3fEnKwBhH9ilsTc+feTQjBtkQPcnWxhNE/5yd0OkYma7y4plMYa0nTDB8+MHTXiGMd2ztr2S/SNIV18UAKsPhgQ==
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(36860700016)(82310400026)(23010399003)(11063799006)(56012099006)(10067099003)(261021123027099003)(261021121427099003)(261009223027099003)(261022105027099003)(261102123227099003)(261026140227099003)(261028144727099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1qZj2mzbyxu7V9XV+iTOGuHX9WkPT1VABFmDrVxX7fUUbyAVwLmJ5Hf5EDoNhnbWwiq47BLpP6n9iHshjDerHA3aPc5w1OtW6dPhK+3VuUncLvMsgFtnaaDsxBOZ/4OTc4Xu8+Vp4jx9kgU5ZRIX56kMalY6Egnf/HobG5h8kZ+Gxx3JKmGG4UR0ybzwsaqryPoDPprkUjVOAxlChiG5wdqI3JXTSiK9LwSNLoNaZCr7m9iE7wofepB8KBNBhZ+0HDUVX4Qsu9d+g3QradnRURbC19i6c4ho5NUk8+FkJRi2UkGvJX3ttjyfgYiQaj9kQFU5mpX6JeeLz6YAsXw1D4aamSngvsT73xw2AZhiv3o5dm6xJr2zvEj+85pL9Tmdr7ST5rupkp/PTX2dgUlvylS7Yymi1svgafHzuCd9WqOOOg7orXjNq3Jg4A+/NKCR
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 06:59:30.9838 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7823a25-23dc-4c99-3e32-08df4478544c
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: MAD0EPF000008C3.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8709
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



On 11/16/26 18:43, Marek Vasut wrote:
> Set the ops structure as static const. The structure is not accessible
> from outside of this driver and is not going to be modified at runtime.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Bradley Morgan <bradley.morgan@linux.dev>
> Cc: Daniel Palmer <daniel@thingy.jp>
> Cc: David Lechner <dlechner@baylibre.com>
> Cc: Eugen Hristev <ehristev@kernel.org>
> Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
> Cc: Hiago De Franco <hfranco@baylibre.com>
> Cc: Julien Stephan <jstephan@baylibre.com>
> Cc: Kuan-Wei Chiu <visitorckw@gmail.com>
> Cc: Leo Liang <leo.liang@sifive.com>
> Cc: Mario Six <mario.six@gdsys.cc>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Sam Protsenko <semen.protsenko@linaro.org>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
> Cc: Svyatoslav Ryhel <clamor95@gmail.com>
> Cc: Thierry Reding <treding@nvidia.com>
> Cc: Tien Fong Chee <tien.fong.chee@altera.com>
> Cc: Tim Ouyang <tim609@andestech.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Weijie Gao <weijie.gao@mediatek.com>
> Cc: Yao Zi <me@ziyao.cc>
> Cc: Zhuxu Ran <zhuxu_ran@zohomail.com>
> Cc: u-boot@lists.u-boot-project.org
> ---
>  drivers/sysreset/poweroff_gpio.c           | 2 +-
>  drivers/sysreset/sysreset-ti-sci.c         | 2 +-
>  drivers/sysreset/sysreset_ast.c            | 2 +-
>  drivers/sysreset/sysreset_at91.c           | 2 +-
>  drivers/sysreset/sysreset_cv1800b.c        | 2 +-
>  drivers/sysreset/sysreset_gpio.c           | 2 +-
>  drivers/sysreset/sysreset_max77663.c       | 2 +-
>  drivers/sysreset/sysreset_max8907.c        | 2 +-
>  drivers/sysreset/sysreset_microblaze.c     | 2 +-
>  drivers/sysreset/sysreset_mpc83xx.c        | 2 +-
>  drivers/sysreset/sysreset_octeon.c         | 2 +-
>  drivers/sysreset/sysreset_palmas.c         | 2 +-
>  drivers/sysreset/sysreset_psci.c           | 2 +-
>  drivers/sysreset/sysreset_qemu_virt_ctrl.c | 2 +-
>  drivers/sysreset/sysreset_raa215300.c      | 2 +-
>  drivers/sysreset/sysreset_resetctl.c       | 2 +-
>  drivers/sysreset/sysreset_sandbox.c        | 4 ++--
>  drivers/sysreset/sysreset_sbi.c            | 2 +-
>  drivers/sysreset/sysreset_socfpga.c        | 2 +-
>  drivers/sysreset/sysreset_socfpga_soc64.c  | 2 +-
>  drivers/sysreset/sysreset_sti.c            | 2 +-
>  drivers/sysreset/sysreset_syscon.c         | 2 +-
>  drivers/sysreset/sysreset_tegra.c          | 2 +-
>  drivers/sysreset/sysreset_tps65910.c       | 2 +-
>  drivers/sysreset/sysreset_tps80031.c       | 2 +-
>  drivers/sysreset/sysreset_x86.c            | 2 +-
>  drivers/sysreset/sysreset_xtfpga.c         | 2 +-
>  27 files changed, 28 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/sysreset/poweroff_gpio.c b/drivers/sysreset/poweroff_gpio.c
> index d9220024f47..ca695393136 100644
> --- a/drivers/sysreset/poweroff_gpio.c
> +++ b/drivers/sysreset/poweroff_gpio.c
> @@ -72,7 +72,7 @@ static int poweroff_gpio_probe(struct udevice *dev)
>  	return gpio_request_by_name(dev, "gpios", 0, &priv->gpio, flags);
>  }
>  
> -static struct sysreset_ops poweroff_gpio_ops = {
> +static const struct sysreset_ops poweroff_gpio_ops = {
>  	.request = poweroff_gpio_request,
>  };
>  
> diff --git a/drivers/sysreset/sysreset-ti-sci.c b/drivers/sysreset/sysreset-ti-sci.c
> index 451fc5de735..2674d6f07c5 100644
> --- a/drivers/sysreset/sysreset-ti-sci.c
> +++ b/drivers/sysreset/sysreset-ti-sci.c
> @@ -55,7 +55,7 @@ static int ti_sci_sysreset_request(struct udevice *dev, enum sysreset_t type)
>  	return ret;
>  }
>  
> -static struct sysreset_ops ti_sci_sysreset_ops = {
> +static const struct sysreset_ops ti_sci_sysreset_ops = {
>  	.request = ti_sci_sysreset_request,
>  };
>  
> diff --git a/drivers/sysreset/sysreset_ast.c b/drivers/sysreset/sysreset_ast.c
> index 4e15ebd53cc..021359a86a7 100644
> --- a/drivers/sysreset/sysreset_ast.c
> +++ b/drivers/sysreset/sysreset_ast.c
> @@ -46,7 +46,7 @@ static int ast_sysreset_request(struct udevice *dev, enum sysreset_t type)
>  	return -EINPROGRESS;
>  }
>  
> -static struct sysreset_ops ast_sysreset = {
> +static const struct sysreset_ops ast_sysreset = {
>  	.request	= ast_sysreset_request,
>  };
>  
> diff --git a/drivers/sysreset/sysreset_at91.c b/drivers/sysreset/sysreset_at91.c
> index 457042c7aae..6e865e1e9e6 100644
> --- a/drivers/sysreset/sysreset_at91.c
> +++ b/drivers/sysreset/sysreset_at91.c
> @@ -51,7 +51,7 @@ static int at91_sysreset_probe(struct udevice *dev)
>  	return 0;
>  }
>  
> -static struct sysreset_ops at91_sysreset = {
> +static const struct sysreset_ops at91_sysreset = {
>  	.request = at91_sysreset_request,
>  };
>  
> diff --git a/drivers/sysreset/sysreset_cv1800b.c b/drivers/sysreset/sysreset_cv1800b.c
> index 74ba2c2bd8f..6bb4a285cf1 100644
> --- a/drivers/sysreset/sysreset_cv1800b.c
> +++ b/drivers/sysreset/sysreset_cv1800b.c
> @@ -63,7 +63,7 @@ static int cv1800b_sysreset_probe(struct udevice *dev)
>  	return 0;
>  }
>  
> -static struct sysreset_ops cv1800b_sysreset = {
> +static const struct sysreset_ops cv1800b_sysreset = {
>  	.request = cv1800b_sysreset_request,
>  };
>  
> diff --git a/drivers/sysreset/sysreset_gpio.c b/drivers/sysreset/sysreset_gpio.c
> index 47018844a51..bb9d285f5d4 100644
> --- a/drivers/sysreset/sysreset_gpio.c
> +++ b/drivers/sysreset/sysreset_gpio.c
> @@ -33,7 +33,7 @@ static int gpio_reboot_request(struct udevice *dev, enum sysreset_t type)
>  	return -EINPROGRESS;
>  }
>  
> -static struct sysreset_ops gpio_reboot_ops = {
> +static const struct sysreset_ops gpio_reboot_ops = {
>  	.request = gpio_reboot_request,
>  };
>  
> diff --git a/drivers/sysreset/sysreset_max77663.c b/drivers/sysreset/sysreset_max77663.c
> index 8febcf8de6c..a4ed763f743 100644
> --- a/drivers/sysreset/sysreset_max77663.c
> +++ b/drivers/sysreset/sysreset_max77663.c
> @@ -41,7 +41,7 @@ static int max77663_sysreset_request(struct udevice *dev,
>  	return -EINPROGRESS;
>  }
>  
> -static struct sysreset_ops max77663_sysreset = {
> +static const struct sysreset_ops max77663_sysreset = {
>  	.request = max77663_sysreset_request,
>  };
>  
> diff --git a/drivers/sysreset/sysreset_max8907.c b/drivers/sysreset/sysreset_max8907.c
> index 6f62af9bffe..ac268dc5e61 100644
> --- a/drivers/sysreset/sysreset_max8907.c
> +++ b/drivers/sysreset/sysreset_max8907.c
> @@ -26,7 +26,7 @@ static int max8907_sysreset_request(struct udevice *dev, enum sysreset_t type)
>  	return -EINPROGRESS;
>  }
>  
> -static struct sysreset_ops max8907_sysreset = {
> +static const struct sysreset_ops max8907_sysreset = {
>  	.request = max8907_sysreset_request,
>  };
>  
> diff --git a/drivers/sysreset/sysreset_microblaze.c b/drivers/sysreset/sysreset_microblaze.c
> index b81d82f046b..031b6cd72e0 100644
> --- a/drivers/sysreset/sysreset_microblaze.c
> +++ b/drivers/sysreset/sysreset_microblaze.c
> @@ -20,7 +20,7 @@ static int microblaze_sysreset_request(struct udevice *dev,
>  	return -EINPROGRESS;
>  }
>  
> -static struct sysreset_ops microblaze_sysreset = {
> +static const struct sysreset_ops microblaze_sysreset = {
>  	.request = microblaze_sysreset_request,
>  };
>  
> diff --git a/drivers/sysreset/sysreset_mpc83xx.c b/drivers/sysreset/sysreset_mpc83xx.c
> index dca49299f77..4aa1707d4fd 100644
> --- a/drivers/sysreset/sysreset_mpc83xx.c
> +++ b/drivers/sysreset/sysreset_mpc83xx.c
> @@ -203,7 +203,7 @@ static int mpc83xx_sysreset_get_status(struct udevice *dev, char *buf, int size)
>  	return 0;
>  }
>  
> -static struct sysreset_ops mpc83xx_sysreset = {
> +static const struct sysreset_ops mpc83xx_sysreset = {
>  	.request	= mpc83xx_sysreset_request,
>  	.get_status	= mpc83xx_sysreset_get_status,
>  };
> diff --git a/drivers/sysreset/sysreset_octeon.c b/drivers/sysreset/sysreset_octeon.c
> index c16223720e5..c08243e7c0b 100644
> --- a/drivers/sysreset/sysreset_octeon.c
> +++ b/drivers/sysreset/sysreset_octeon.c
> @@ -32,7 +32,7 @@ static int octeon_sysreset_probe(struct udevice *dev)
>  	return 0;
>  }
>  
> -static struct sysreset_ops octeon_sysreset = {
> +static const struct sysreset_ops octeon_sysreset = {
>  	.request = octeon_sysreset_request,
>  };
>  
> diff --git a/drivers/sysreset/sysreset_palmas.c b/drivers/sysreset/sysreset_palmas.c
> index 9e3aa403488..e80c78ca482 100644
> --- a/drivers/sysreset/sysreset_palmas.c
> +++ b/drivers/sysreset/sysreset_palmas.c
> @@ -41,7 +41,7 @@ static int palmas_sysreset_request(struct udevice *dev,
>  	return -EINPROGRESS;
>  }
>  
> -static struct sysreset_ops palmas_sysreset = {
> +static const struct sysreset_ops palmas_sysreset = {
>  	.request = palmas_sysreset_request,
>  };
>  
> diff --git a/drivers/sysreset/sysreset_psci.c b/drivers/sysreset/sysreset_psci.c
> index 89b4f2dcaec..1bf6af0821b 100644
> --- a/drivers/sysreset/sysreset_psci.c
> +++ b/drivers/sysreset/sysreset_psci.c
> @@ -30,7 +30,7 @@ static int psci_sysreset_request(struct udevice *dev, enum sysreset_t type)
>  	return -EINPROGRESS;
>  }
>  
> -static struct sysreset_ops psci_sysreset_ops = {
> +static const struct sysreset_ops psci_sysreset_ops = {
>  	.request = psci_sysreset_request,
>  	.get_status = psci_sysreset_get_status,
>  };
> diff --git a/drivers/sysreset/sysreset_qemu_virt_ctrl.c b/drivers/sysreset/sysreset_qemu_virt_ctrl.c
> index ce15e776f8f..cd693eb55e1 100644
> --- a/drivers/sysreset/sysreset_qemu_virt_ctrl.c
> +++ b/drivers/sysreset/sysreset_qemu_virt_ctrl.c
> @@ -45,7 +45,7 @@ static int qemu_virt_ctrl_request(struct udevice *dev, enum sysreset_t type)
>  	return -EINPROGRESS;
>  }
>  
> -static struct sysreset_ops qemu_virt_ctrl_ops = {
> +static const struct sysreset_ops qemu_virt_ctrl_ops = {
>  	.request = qemu_virt_ctrl_request,
>  };
>  
> diff --git a/drivers/sysreset/sysreset_raa215300.c b/drivers/sysreset/sysreset_raa215300.c
> index 32dfcb0aec8..17cb35c4e9c 100644
> --- a/drivers/sysreset/sysreset_raa215300.c
> +++ b/drivers/sysreset/sysreset_raa215300.c
> @@ -47,7 +47,7 @@ static int raa215300_sysreset_request(struct udevice *dev, enum sysreset_t type)
>  	return -EINPROGRESS;
>  }
>  
> -static struct sysreset_ops raa215300_sysreset_ops = {
> +static const struct sysreset_ops raa215300_sysreset_ops = {
>  	.request = raa215300_sysreset_request,
>  };
>  
> diff --git a/drivers/sysreset/sysreset_resetctl.c b/drivers/sysreset/sysreset_resetctl.c
> index fbe3999b960..f06382956ce 100644
> --- a/drivers/sysreset/sysreset_resetctl.c
> +++ b/drivers/sysreset/sysreset_resetctl.c
> @@ -21,7 +21,7 @@ static int resetctl_reboot_request(struct udevice *dev, enum sysreset_t type)
>  	return reset_assert_bulk(&priv->resets);
>  }
>  
> -static struct sysreset_ops resetctl_reboot_ops = {
> +static const struct sysreset_ops resetctl_reboot_ops = {
>  	.request = resetctl_reboot_request,
>  };
>  
> diff --git a/drivers/sysreset/sysreset_sandbox.c b/drivers/sysreset/sysreset_sandbox.c
> index 93179f90bbb..a9fa187945d 100644
> --- a/drivers/sysreset/sysreset_sandbox.c
> +++ b/drivers/sysreset/sysreset_sandbox.c
> @@ -95,7 +95,7 @@ int sandbox_sysreset_get_last(struct udevice *dev)
>  	return state->jumped_fname ? SYSRESET_WARM : SYSRESET_POWER;
>  }
>  
> -static struct sysreset_ops sandbox_sysreset_ops = {
> +static const struct sysreset_ops sandbox_sysreset_ops = {
>  	.request	= sandbox_sysreset_request,
>  	.get_status	= sandbox_sysreset_get_status,
>  	.get_last	= sandbox_sysreset_get_last,
> @@ -113,7 +113,7 @@ U_BOOT_DRIVER(sysreset_sandbox) = {
>  	.ops		= &sandbox_sysreset_ops,
>  };
>  
> -static struct sysreset_ops sandbox_warm_sysreset_ops = {
> +static const struct sysreset_ops sandbox_warm_sysreset_ops = {
>  	.request	= sandbox_warm_sysreset_request,
>  	.get_status	= sandbox_warm_sysreset_get_status,
>  	.get_last	= sandbox_warm_sysreset_get_last,
> diff --git a/drivers/sysreset/sysreset_sbi.c b/drivers/sysreset/sysreset_sbi.c
> index 458191206b2..c4a71363e62 100644
> --- a/drivers/sysreset/sysreset_sbi.c
> +++ b/drivers/sysreset/sysreset_sbi.c
> @@ -38,7 +38,7 @@ static int sbi_sysreset_probe(struct udevice *dev)
>  	return -ENOENT;
>  }
>  
> -static struct sysreset_ops sbi_sysreset_ops = {
> +static const struct sysreset_ops sbi_sysreset_ops = {
>  	.request = sbi_sysreset_request,
>  };
>  
> diff --git a/drivers/sysreset/sysreset_socfpga.c b/drivers/sysreset/sysreset_socfpga.c
> index a07b0f4fd55..8d979ff7333 100644
> --- a/drivers/sysreset/sysreset_socfpga.c
> +++ b/drivers/sysreset/sysreset_socfpga.c
> @@ -43,7 +43,7 @@ static int socfpga_sysreset_probe(struct udevice *dev)
>  	return 0;
>  }
>  
> -static struct sysreset_ops socfpga_sysreset = {
> +static const struct sysreset_ops socfpga_sysreset = {
>  	.request = socfpga_sysreset_request,
>  };
>  
> diff --git a/drivers/sysreset/sysreset_socfpga_soc64.c b/drivers/sysreset/sysreset_socfpga_soc64.c
> index e1267ac118a..5e4fcf95b6c 100644
> --- a/drivers/sysreset/sysreset_socfpga_soc64.c
> +++ b/drivers/sysreset/sysreset_socfpga_soc64.c
> @@ -76,7 +76,7 @@ static int socfpga_sysreset_request(struct udevice *dev,
>  	return -EINPROGRESS;
>  }
>  
> -static struct sysreset_ops socfpga_sysreset = {
> +static const struct sysreset_ops socfpga_sysreset = {
>  	.request = socfpga_sysreset_request,
>  };
>  
> diff --git a/drivers/sysreset/sysreset_sti.c b/drivers/sysreset/sysreset_sti.c
> index 110b7e23afa..862b9411392 100644
> --- a/drivers/sysreset/sysreset_sti.c
> +++ b/drivers/sysreset/sysreset_sti.c
> @@ -65,7 +65,7 @@ static int sti_sysreset_probe(struct udevice *dev)
>  	return 0;
>  }
>  
> -static struct sysreset_ops sti_sysreset = {
> +static const struct sysreset_ops sti_sysreset = {
>  	.request	= sti_sysreset_request,
>  };
>  
> diff --git a/drivers/sysreset/sysreset_syscon.c b/drivers/sysreset/sysreset_syscon.c
> index d853830d5ae..2b485963a30 100644
> --- a/drivers/sysreset/sysreset_syscon.c
> +++ b/drivers/sysreset/sysreset_syscon.c
> @@ -35,7 +35,7 @@ static int syscon_reboot_request(struct udevice *dev, enum sysreset_t type)
>  	return -EINPROGRESS;
>  }
>  
> -static struct sysreset_ops syscon_reboot_ops = {
> +static const struct sysreset_ops syscon_reboot_ops = {
>  	.request = syscon_reboot_request,
>  };
>  
> diff --git a/drivers/sysreset/sysreset_tegra.c b/drivers/sysreset/sysreset_tegra.c
> index 10bcd3a1873..d498aaea73a 100644
> --- a/drivers/sysreset/sysreset_tegra.c
> +++ b/drivers/sysreset/sysreset_tegra.c
> @@ -29,7 +29,7 @@ static int tegra_sysreset_request(struct udevice *dev,
>  	return -EINPROGRESS;
>  }
>  
> -static struct sysreset_ops tegra_sysreset = {
> +static const struct sysreset_ops tegra_sysreset = {
>  	.request = tegra_sysreset_request,
>  };
>  
> diff --git a/drivers/sysreset/sysreset_tps65910.c b/drivers/sysreset/sysreset_tps65910.c
> index 98da56661c0..957c73f04f2 100644
> --- a/drivers/sysreset/sysreset_tps65910.c
> +++ b/drivers/sysreset/sysreset_tps65910.c
> @@ -43,7 +43,7 @@ static int tps65910_sysreset_request(struct udevice *dev,
>  	return -EINPROGRESS;
>  }
>  
> -static struct sysreset_ops tps65910_sysreset = {
> +static const struct sysreset_ops tps65910_sysreset = {
>  	.request = tps65910_sysreset_request,
>  };
>  
> diff --git a/drivers/sysreset/sysreset_tps80031.c b/drivers/sysreset/sysreset_tps80031.c
> index 50024fe4e79..1a0dc2adb16 100644
> --- a/drivers/sysreset/sysreset_tps80031.c
> +++ b/drivers/sysreset/sysreset_tps80031.c
> @@ -29,7 +29,7 @@ static int tps80031_sysreset_request(struct udevice *dev,
>  	return -EINPROGRESS;
>  }
>  
> -static struct sysreset_ops tps80031_sysreset = {
> +static const struct sysreset_ops tps80031_sysreset = {
>  	.request = tps80031_sysreset_request,
>  };
>  
> diff --git a/drivers/sysreset/sysreset_x86.c b/drivers/sysreset/sysreset_x86.c
> index c2f28c65280..51eb16bc551 100644
> --- a/drivers/sysreset/sysreset_x86.c
> +++ b/drivers/sysreset/sysreset_x86.c
> @@ -144,7 +144,7 @@ static const struct udevice_id x86_sysreset_ids[] = {
>  	{ }
>  };
>  
> -static struct sysreset_ops x86_sysreset_ops = {
> +static const struct sysreset_ops x86_sysreset_ops = {
>  	.request = x86_sysreset_request,
>  	.get_last = x86_sysreset_get_last,
>  };
> diff --git a/drivers/sysreset/sysreset_xtfpga.c b/drivers/sysreset/sysreset_xtfpga.c
> index ab71ea11a0b..2165a1cfdcd 100644
> --- a/drivers/sysreset/sysreset_xtfpga.c
> +++ b/drivers/sysreset/sysreset_xtfpga.c
> @@ -25,7 +25,7 @@ static int xtfpga_reset_request(struct udevice *dev, enum sysreset_t type)
>  	return -EINPROGRESS;
>  }
>  
> -static struct sysreset_ops xtfpga_sysreset_ops = {
> +static const struct sysreset_ops xtfpga_sysreset_ops = {
>  	.request	= xtfpga_reset_request,
>  };
>  
Hi Marek

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
