Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE43BCA600D
	for <u-boot@archiver.kernel.org>; Thu,  8 Oct 2026 15:54:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9F3E2812E0;
	Thu,  8 Oct 2026 15:54:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YX9XIYayI2tL; Thu,  8 Oct 2026 15:54:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org E101D812E1
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791474864;
	b=sSAc0x2oX5ExVxr2+LgS94ai0LxDY/NCL2CPWsHUtPeSzj6PymM2FU0EMxEtSu6f2a3X
	 qo1FQ0UjOswY5iBVjcfpK6R0vv53mnTJm54AYKjRNvn2a/rd4yeh8pgsnxfjZ2rg0G/SW
	 s7uCPcbPl/JvXXrkbXWVJGtIZmm54UYDeHxy80ckeGZhSwow4TkcIKwknl5wvzFsi9EoL
	 Izwi2h88mB1eEPBp0N0murIAp3/xrFSg0/2a4zSX1U7U1jmf7cGJ10QYXQznQrRIledH9
	 pHb9CKJebBRtktcTjFID2/Ir8Fiem8+Gb2qhKer6Gn8Lxq0YoR/UGwmi8uWsyEj/0bQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791474864;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:
	 References:In-Reply-To:To:CC:X-Mailer:X-Originating-IP:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ta6JD1ugU6VDxRK2EO4oQe+5teR+NsWZ1q4WO6N2tpo=;
	b=lcfqlAt99a0/ogWSczJxQ36RTjZMLZQCrvPRykNU/yuMA5APtBalHpTLo+MfwfVbZfq0
	 gkVOR8FkPY+Y8uC+eAxjOaUzdQQnj6PSF757dZXVWrfu6cTAT+sXmMU4TxFCNc2YH86fV
	 HniG+QcECO28/X0i9HEQKD3y1ncikiVJEjixv17l26SEMmLqfjDXP/dw/s4lRi35LsbIl
	 2GiKoHs0bfKR2Im5ge1LSmlJbcARUxPGUia3WcI08iy/Js+d3cf99xMYF/FmlvbXW8Urp
	 p5/IlloKn3CSSr6jebtuH0zoJFueOPM6w93+v1MhRQ9jJM5okBOw0S7+vqgGJj1ZPiw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791474864;
	bh=ta6JD1ugU6VDxRK2EO4oQe+5teR+NsWZ1q4WO6N2tpo=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cIpDEFhbU/OzYAsBZq/tI5sHAwge6kKmHEWQqLQVMtbWEX4AZyCHmogorijyod+NH
	 /yFHlG+Kf9gkqdORRHYTrR1iXlwSzs1tAerGKCWhrAmVxV+SDt1gI1UpwzNIRErH/9
	 CHClbBnHL3c/cbZ9KKUrTj0Thg5sH28aOYBBUhJ549Gi8aDvUrDaA3lSHWhwFUiY8S
	 vSFE8Jl+rT42wWGPW10CK0vaxhLqhI4bPwtNl7I12Y6lq5+Fiu6iYnS1dMgmc2/4YB
	 QCF1UFVqTwj3oA7wCILCdUrPWmBoEHi1xC8pqULhsBQCHb06VtHsDq7IZm1lW/hpbl
	 Gmg/KHEnjFv1w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E101D812E1;
	Thu,  8 Oct 2026 15:54:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 75D112E0
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 15:37:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 674FD60BC4
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 15:37:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Pbvq9kJLsonA for <u-boot@lists.u-boot-project.org>;
 Thu,  8 Oct 2026 15:37:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org E1698605B0
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c202::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791473856;
 b=sZhu7N12/kd8qlSqZ5Xh8BJRLZh93cWfZwan+E4MqnAtk2ouDFC3zy9dMNmrr2OKrw0F
 zdmV0V191bEC2c7Y4kWf9f+D00wSG+IuB4YO/9rgW1gEnKLL9TOyVjDDvaF/pKsnZ4A7q
 9L6RcW2cb1AmTmZqY27anLOR5ToO0XR8ayD0IRz3Db1II9jtAKQcybm6bmY66AOoW/wRx
 rFFhKCy1gIj7gMMByTvp2Tg07bo9YpQQcQhu1VSLWrVS2/asZVThFgp1Y2/PkWVOiEKLD
 OwS2QEbhXGFBTaZOgDzByDyDKwcKuVn/fnwJPxjXOXH7ZYtzwUdsmjL3KBqn6T7g6ww==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791473856;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 Received:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-ID:References:In-Reply-To:To:CC:
 X-Mailer:X-Originating-IP:X-ClientProxiedBy:X-EOPAttributedMessage:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
 bh=ta6JD1ugU6VDxRK2EO4oQe+5teR+NsWZ1q4WO6N2tpo=;
 b=jFEx1N6gZUAP4RUT20AL1AXsM+K9UXmeL7OkbqUvYOYX4z75qlwdOYpimb0K0weXUBEI
 APrHcK6RMoG0vdSZYwyOx8U7Bso056Lwe/rsoXQbO9rv+wizDAh2FErStTNsQ5ICHLK+f
 D0X4CMPymoCCSYUo+xeU3Q7RksHYtVUg+fzGhlLxEN28BrYazEfJCr0CbATXuerAx8zmC
 8zIpmIYqW8oustEOTto2p+nZpKUa+K/n+be+beBiIrVmk/W4T+wHhufCczkjqAoYkB3Ar
 yUNm7jtWJ2/zmIQNVaZ46uDXOBgyyLjOX1PF90JcdOThfUq72TzDjqfsg6ZrsQ6j55Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=foss.st.com; 
 dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=ZPEpH7cT; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c202::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=fabrice.gasnier@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=ZPEpH7cT
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E1698605B0
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 15:37:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YdqKv7q1gUGmvOGXm0qyE9LZH4TLgNb2c6B7GjxMDWlI+aLWmbl6rFHm1gbJDLWMsrRNQJi9Lw7L66XIcM5Ht3S+3noIzbf+xlxaqEIkTbmGtBFEVr/cNyydVHVOkWm2OG82DPhLmQBIlHwn7V/i7owGh4sNZImyvJXRIqzA/u0tzPpdWUzPfL4nypPisDnwrjHvqOP8EISnxgOyCdEC7DXJZh9J+YsCkC/ifFst/KaPl62nIcCilJVKOl4mp1knE9iiyKTZDxZLKZQZYGYvuh1wkcNMTWag9IbkfI0C6qmaD/j0tBw1Cwuh28StG2sArn59Kr/JrHvav0sLvd2epg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ta6JD1ugU6VDxRK2EO4oQe+5teR+NsWZ1q4WO6N2tpo=;
 b=M8KMZN13B6hULkUT6xECmTg/f4/wX9OKmLN5y1tjtdEmz3dWQo43yU/xE6B0WbmaC9QPU/YVWM8sZycqbuz0j3jawd276cCDd5f3OJmoQDFbT+Togxe6SIQBcTtjqcYyKogBofiFs1oX4AUu71Y2KWZg3O16Rl+3EhM1EErN0JTieo+yJ9lfFaNz/fWXftjbcIRGGEniyVioXuyR2MMhz9p7MEba359lOd1PPlE4i4eHt2sIafzAEBvMVAW/rIksa2L/XVcnq/IaawldbYde6SWPfPeP/m4REpzY7jTF5ohvXggl4c/AdeXmqi/eOdTSHNcs4sTsLxkzFHmNmv46JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=gmail.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ta6JD1ugU6VDxRK2EO4oQe+5teR+NsWZ1q4WO6N2tpo=;
 b=ZPEpH7cT3NmF+OwE6BCUn63SvL9OlSofNYAb91fCx2aqsAleZtLHusdl+chy/cg0fcNhjxoOFsr9lYgqtGc/CXDgz8tz6Bk5BpyJ+HjZTgqyfrvdmhGQjoOVbFGBC9qAC4QTTwNFCCeCR6fWxO2QHK42Gg46Pb/w4/q5RFKpgrHag+73KVULvy+ZQSaKXBVpJJ+RcGHbDq/Brz8r21xuXOolwWwkV0thk9P7nOK+XMxmesa48rn2dOCH+s1NKe0nKOBmH40SB2Ri1pEr8wam4RunG1KMaCn6jQll80Vxp87eCUxQMDIzdlqVgJdIXKPfhTdJofVT6HsMA/CCCg0gyg==
Received: from DU2PR04CA0060.eurprd04.prod.outlook.com (2603:10a6:10:234::35)
 by AS2PR10MB6952.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:578::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Thu, 8 Oct
 2026 15:37:23 +0000
Received: from DU2PEPF00028D00.eurprd03.prod.outlook.com
 (2603:10a6:10:234:cafe::94) by DU2PR04CA0060.outlook.office365.com
 (2603:10a6:10:234::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Thu, 8
 Oct 2026 15:37:23 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DU2PEPF00028D00.mail.protection.outlook.com (10.167.242.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Thu, 8 Oct 2026 15:37:23 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 8 Oct
 2026 17:44:09 +0200
Received: from localhost (10.48.86.251) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 8 Oct
 2026 17:37:22 +0200
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Date: Thu, 8 Oct 2026 17:37:08 +0200
Subject: [PATCH 2/2] usb: gadget: dwc2_udc_otg: wait for mode when digital
 filter is active
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261008-dwc2-iddig-fixes-v1-2-24c302b8953f@foss.st.com>
References: <20261008-dwc2-iddig-fixes-v1-0-24c302b8953f@foss.st.com>
In-Reply-To: <20261008-dwc2-iddig-fixes-v1-0-24c302b8953f@foss.st.com>
To: Patrick Delaunay <patrick.delaunay@foss.st.com>,
 <u-boot@lists.u-boot-project.org>, Kongyang Liu <seashell11234455@gmail.com>
CC: Lukasz Majewski <lukma@nabladev.com>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Marek Vasut <marek.vasut+usb@mailbox.org>, "Tom
 Rini" <trini@konsulko.com>, Patrice CHOTARD <patrice.chotard@foss.st.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 <uboot-stm32@st-md-mailman.stormreply.com>, Fabrice Gasnier
 <fabrice.gasnier@foss.st.com>
X-Mailer: b4 0.16.0
X-Originating-IP: [10.48.86.251]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D00:EE_|AS2PR10MB6952:EE_
X-MS-Office365-Filtering-Correlation-Id: 76087954-8bba-44a8-27d6-08df25520c7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|82310400026|1800799024|10067099003|56012099006|5023799004|6133799003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 61b0P4QkjKpplVnI2zxyWDUVG22Hslw03BgsUZbawBumLp6tEjyrj2WXBSfbnKcWiT0qIk1gGHBYFW+G5cz3icQSCUs5V5/Eky1cud8t5LwHrTJSk6yGwBNUI6oNhJ1m77dqn5cjHEh8tPs4m6HOwbiek60TYE+Ce1ILXMAjmNQaDOY1d2O+azdNuX0uuisernoDv9msQm6mIDlvRbLWwL5+zuPTT7x53ciT/ZMs8FdRhAVJrD1CBvlF0wZDiUSbOZ59mNOE6q+E9OuAvr/ZzwBMhKPXosMZZT6KJRo+ZdZNAQf/05mBj1YHOQM3pZYgy2jept9hxaymWdQGb3hocuBAP3bi2X3MWJ1MUO/eYgV6F6UK0YPbVOAXbT9nwga3GfzrplJbQ3jnXslDO91rIKKKIiUEHyx0QutIujlFPW6faHUnnb4h+kC8bFpkaz+Z+Old0qxkubWmt8driHhC9xLIDATZpem3qbO0g/gouXoTyMRbXlbTUGFtwnUiSNrYkNOq5d9CjT3L+7pdC8MjfeJr+SrU4ld+63PxWDpMjhGd+XE8X8XaKHA72JidIYxjkuIbByLm7AfoEK+ecCKS329Fh3UQvQkMU8oZ+aXufQFmt5yT9h1LjZQiWldCZ+6QljaXtv15gbRNoQSUvxRapN+i1aSSccUjNNNYqZWBbJQds2h7lCMaN4spilLVeLMOiXSIqZLBJaByj2NzrkiVgw==
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(10067099003)(56012099006)(5023799004)(6133799003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: I7F52eHWVBdulcbF6r4SbAZxN7JA3W4u83Kp2Yt5POHpqSB1pfnt6jzqDkRhZPFsrk/co8XC+z70rbNPSRWnzUOnDUB8zVq3k/k2kPOC7n1+Gm/O8bYI5PLE8AmlPoKDlbEKxLPuZyol9ghKpYG/QX9LK1fgOwZXFOTE434MuyB4fnk2I0TU5HZqStIV/i2RpFRuBeI1HroysaP06FVLVE5MzaGvQVveAlbuyAZ1IuG9kTltppLln20TeHznHLecba2e2iUIhSKYQyWbpuW3d3hsOJUNOcrAblentCJTs7bki5P3iI0HT2z+apQiTUrckiInrXDetxaAlAiqIYu6yRMr2E2FhlEuQyMDCAsNHvgkcwMOT4Hew9O9In9rXsEVyv5bgxA4gsUTXh2Kb9dvLV4JYd0kx3PoVr+B0c4iAocl+bZMoHdyJfhHvclSGw6I
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 15:37:23.5672 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76087954-8bba-44a8-27d6-08df25520c7c
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D00.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6952
X-Mailman-Approved-At: Thu, 08 Oct 2026 15:54:17 +0000
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

When starting the dwc2 core, it may not be seen in the correct mode,
when the dwc2_core_reset() gets called. This is seen on stm32mp1 upon
first call to reconfig_usbd(), a warning can be seen:
- "Waiting for GINTSTS_CURMODE_HOST timeout"

When the core gets initialized, wait for the debounce filters, so the
correct mode gets read and polled later in dwc2_core_reset().

The routines are added to dwc2_core.c, and inspired by the linux dwc2
driver.

Fixes: c5d685b8993c ("usb: dwc2: Unify flush and reset logic with v4.20a support")
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
 drivers/usb/common/dwc2_core.c    | 45 +++++++++++++++++++++++++++++++++++++++
 drivers/usb/common/dwc2_core.h    |  1 +
 drivers/usb/gadget/dwc2_udc_otg.c |  3 +++
 3 files changed, 49 insertions(+)

diff --git a/drivers/usb/common/dwc2_core.c b/drivers/usb/common/dwc2_core.c
index 37007134e5b3..31ecd100f90c 100644
--- a/drivers/usb/common/dwc2_core.c
+++ b/drivers/usb/common/dwc2_core.c
@@ -129,3 +129,48 @@ int dwc2_flush_rx_fifo(struct dwc2_core_regs *regs)
 
 	return 0;
 }
+
+static unsigned int dwc2_op_mode(struct dwc2_core_regs *regs)
+{
+	return FIELD_GET(GHWCFG2_OP_MODE_MASK, readl(&regs->global_regs.ghwcfg2));
+}
+
+/* Returns true if the controller is capable of DRD. */
+static bool dwc2_hw_is_otg(struct dwc2_core_regs *regs)
+{
+	unsigned int op_mode = dwc2_op_mode(regs);
+
+	return (op_mode == GHWCFG2_OP_MODE_HNP_SRP_CAPABLE) ||
+		(op_mode == GHWCFG2_OP_MODE_SRP_ONLY_CAPABLE) ||
+		(op_mode == GHWCFG2_OP_MODE_NO_HNP_SRP_CAPABLE);
+}
+
+/*
+ * dwc2_iddig_filter_enabled() - Returns true if the IDDIG debounce
+ * filter is enabled.
+ */
+bool dwc2_iddig_filter_enabled(struct dwc2_core_regs *regs)
+{
+	u32 snpsid;
+
+	if (!dwc2_hw_is_otg(regs))
+		return false;
+
+	/* Check if core configuration includes the IDDIG filter. */
+	if (!FIELD_GET(GHWCFG4_IDDIG_FILT_EN, readl(&regs->global_regs.ghwcfg4)))
+		return false;
+
+	/*
+	 * Check if the IDDIG debounce filter is bypassed. Available
+	 * in core version >= 3.10a.
+	 */
+	snpsid = readl(&regs->global_regs.gsnpsid);
+	if (FIELD_GET(GSNPSID_VER_MASK, snpsid) >= 0x310a) {
+		u32 gotgctl = readl(&regs->global_regs.gotgctl);
+
+		if (gotgctl & GOTGCTL_DBNCE_FLTR_BYPASS)
+			return false;
+	}
+
+	return true;
+}
diff --git a/drivers/usb/common/dwc2_core.h b/drivers/usb/common/dwc2_core.h
index 1897ad7cb540..7c26b7f7fc19 100644
--- a/drivers/usb/common/dwc2_core.h
+++ b/drivers/usb/common/dwc2_core.h
@@ -128,6 +128,7 @@ struct dwc2_core_regs {
 int dwc2_core_reset(struct dwc2_core_regs *regs);
 int dwc2_flush_tx_fifo(struct dwc2_core_regs *regs, const int num);
 int dwc2_flush_rx_fifo(struct dwc2_core_regs *regs);
+bool dwc2_iddig_filter_enabled(struct dwc2_core_regs *regs);
 
 /* Core Global Register */
 #define GOTGCTL_CHIRPEN				BIT(27)
diff --git a/drivers/usb/gadget/dwc2_udc_otg.c b/drivers/usb/gadget/dwc2_udc_otg.c
index 2129bfa1edb6..4dc049d64b14 100644
--- a/drivers/usb/gadget/dwc2_udc_otg.c
+++ b/drivers/usb/gadget/dwc2_udc_otg.c
@@ -1150,6 +1150,9 @@ static int dwc2_udc_otg_probe(struct udevice *dev)
 		}
 	}
 
+	if (dwc2_iddig_filter_enabled(usbotg_reg))
+		mdelay(100);
+
 	ret = dwc2_udc_probe(plat);
 	if (ret)
 		return ret;

-- 
2.43.0

