Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73051C982D0
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 08:58:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C5E684079D;
	Thu, 17 Sep 2026 08:58:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oHiBVjpSlH0R; Thu, 17 Sep 2026 08:58:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org EA0C640750
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789635533;
	b=CwV5My8oezw3bW28q9c3+ip5EKHHWep/mwysxvmS/p7dnx2i1fjQULTKdiAvHTeBSMwl
	 0yitxermiCkzN2Kb5dV/5e8HYgygF2nlD67/mhlM+HuCWuj6ubrdsuQO25B7COVTfdZbd
	 S/JBiPrM+iUfCwn6KaylSOJdW54d1ahP/nLgDPpauReE/u+uToRmlyDn/IjJzSfCUiUt4
	 BiEYMbXiRGcP/YqBIWZxEqJkoIeHc0sIgVbMpw8A9P5VJyUT0Oa+Y+lx/hg2ZbiugjOmJ
	 /zdmPLL8PgvSIKg2yh++FyFGSZfBxeMbEjaG32EuR15Qrawmb7rWMC90vLSfH4mzQng==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789635533;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:
	 X-B4-Tracking:X-Change-ID:To:CC:X-Mailer:X-Originating-IP:
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
	bh=XUE0Ar98tGqaJ1eebnvvV+wTO7YXQ5r7eNhrPFERlMo=;
	b=XvEcHpOMAU9dEhyO+9o7mpSMc+d8Hs2NKHf6NH0mUH5AdT/hqVuBOb9KvlRLUT9D0CzE
	 yKkKkI6FERb3Qbhp5/scTH61PVzVYU++Tcbmjs716IAe9fnZaWkXNcwWofCtFJUO7fuhG
	 f3wKNqK6nJzlITdsPYydroT9TQdp775d1ms50gr8Yr4pmvNApUPPg/SrKW6IuGXaJ3dbL
	 J95edVLzamUXyAqc3NERjGgTnh7m69xbkljsWAZpc5gZjPZ2Z6bv5VhTOQjI66sw0AsRb
	 3f2M9ukIhKpZNhv/O7UHPOd4ufCIJ5/hyV2wJuJpwU2zhM5Ah7DyngFyzls09Jo3cbw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789635533;
	bh=XUE0Ar98tGqaJ1eebnvvV+wTO7YXQ5r7eNhrPFERlMo=;
	h=From:Date:Subject:To:CC:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=cJHWRsZAFTuWXUnNq0rteD2Z/jxec8BkXv5GAmr2oN0q1U51bh89HJiQbUns1voJv
	 Zs2He57EiArG2RzqWF6ejwevF4vB7qu10Y4wrgblDiaQPXM+wHN0cBY0FzNXz0/99O
	 Bm2Z5+DvUQzHpXod8n4LxMX6ufThbbhCYHDsDIekVe8/KAAR8dTwMKaIF1ScEfN30t
	 LQdhLepyqeFBgJuEOjfaFRzTsRsKps9Lxennt0jTNtt1dbMrfp7bGTyOW5PFSZXr4t
	 Oc9T2mU0jB0SEZWxQ+Hb2R4xGV20KPCbZBrMjXbF1dlDw+TCGVl3brOvVV6YKgPTE2
	 oT4/MLyPbIhoQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EA0C640750;
	Thu, 17 Sep 2026 08:58:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id B7538224
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 08:58:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9D30E60822
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 08:58:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kg957rXf-VdX for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 08:58:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 18C4F607CE
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::5"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789635530;
 b=hFYtqlFeNThYLB0IYl5+a2loaazLGJtmd3NK/VADOZ0QGD/PrmjpHML+MtId0gu7y5Wx
 xNOz4g/RIwqqClB2lwXYEEv20Nlpdyp5L1xCKT6XHfCnx11ZNrFh5rblNncMwcM98KQ0r
 IXDrz78piig4AMqLtRi92v6s/tuqzBsR1bwZNH6Pcug3zK/AMqR7MAym5FkQi/nb4cfcD
 W6CKcktvwcyJVMvcP0miIwk+85LMZNW//ufeg6HACfNmmHJ4oMe4BUbUe5Qlhqg2Z288+
 WcnWivUtGlkzPqipaq8dZJI9MrdoD/jDer6QZfTi6f5/Wr3Y7R/H9J8PJ44f1UmvLzg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789635530;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 Received:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-ID:X-B4-Tracking:X-Change-ID:To:CC:
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
 bh=XUE0Ar98tGqaJ1eebnvvV+wTO7YXQ5r7eNhrPFERlMo=;
 b=YHcOVEpRYvwHTdl1IATfP0v4tNWD0XWbav9oG35fGBYauJDZK7eI1g/GMciGc1+DsB1n
 8fg6enkg6dRHjRtsde4h0B2Og4yQz86vd7FxkJn8qG5Ir0gV2IS5p2wJZ1R5lvIMlZwF6
 KfrfwjCdrXpnSPpLQ3ju/SjzXUinbr8Z7d4H6+Wgt4C4Mkw5Xk1+P/oCHXlKBuxg9M0fF
 FrqD2P32N7dtCXqZd5LtcC+dxZ5JIWb6TFeH+pyrPpFytHWrnsklE+zdTeW5fZV9gWDgP
 5Z9TJaNsGbNV/YgXPC1uLz/Tr7GtypHJimYWcVMeUjRBIMTxMeMlgg8+Devq/QxV8oQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=foss.st.com; 
 dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=ggm2HL1j; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c200::5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::5;
 helo=duzpr83cu001.outbound.protection.outlook.com;
 envelope-from=patrice.chotard@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=ggm2HL1j
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 18C4F607CE
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 08:58:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QtUjBiTw91SC9jz5MQOwFtYmULLjT2Ws9BCGnEsJvc5brM+IVXTTWOHVsrUh6Ni7Zk5AO4e73Cmo58R5LGufXoV/RM8TL2q3upHHFmC/g4L4SzgHDom95YNeTXS8K2aoXOf6ahORHHqdsiVMUwEEmeQK0k9UTncBjDzuj0iDDZ5+X+ZQ6onbXAJerWGGTEQxtQMAAYePKb18icN/xTyzAEf2CJIjpQuu5LkHNs0/DWKbBiZX7lIJGQAqWM4XHEnTWZO4mntZDyZNBVLoqMW5Bva2JqI+iF4QR4CxY11JSF8q7NfKOf/3Rz0Mj4POLNGneZZCrUeEy0NIM86UjE1lNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XUE0Ar98tGqaJ1eebnvvV+wTO7YXQ5r7eNhrPFERlMo=;
 b=JlqxpABeN4bNRLzPhQkQKsZuu1C+6qR3cT0K6S+PDginaDFxCJ/7GPuQgdZS6riOD3sF2/JtnSFzeJNvubzHVZ1g4Vs9RNFEJSExKwLxJ1gORBK0W+cfarKagJu4nq2PFrX3GIt5Xv/1bNzyfmI3TmzRAtRTaNoZHb9U5IURy2wFmjsNT2J9hcYpmnRpEkYo0L/CXRt8mh+Da2kNkwweyLV/Ozc3W70wj0KvpUpVFWZGEzlPFpwlgD61tSNpmQme4dmuehX7XMwItiP8fvzm85SXbtx/4navQ3Loev0nUcPqxg4OZI59OSA+oiwLZ5JLMbrPleA//oAde04+R/WNAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=mailbox.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XUE0Ar98tGqaJ1eebnvvV+wTO7YXQ5r7eNhrPFERlMo=;
 b=ggm2HL1jIvZza3k8wI0NhKnnY20R3JXBqEm9fUt8Bv08vvJ5Ezk1VzFuZ9YO1iRTF6J6mr6wG3hdcuF9JVMbZGvrDNIPT2Kinq655C3oXEGBXEo51lT+mi/0SY+6/A7Q2UlWR0rUO5Ty95HzfAldKgDemQFPr6cnn5qmOHEWLqI+rU72nifOPQPmkdH+kszhLD2VctPI+1qlGOsY5jXk+MP+vbHqlp57Saje/qqejBQC32z6Z17O6U90LPcmIZu2e9Y+On+9/xsCzrfanSU03mtjxJU1Vuph+rLiLQlTHGD36OA2gkzSRAXvjt2jYHxnSPH8UYN277qAm6j9nhzpYg==
Received: from PR1P264CA0041.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:2cb::6)
 by DU4PR10MB8878.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:569::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.11; Thu, 17 Sep
 2026 08:58:42 +0000
Received: from MAD0EPF000008C2.eurprd05.prod.outlook.com
 (2603:10a6:102:2cb:cafe::32) by PR1P264CA0041.outlook.office365.com
 (2603:10a6:102:2cb::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.12 via Frontend Transport; Thu,
 17 Sep 2026 08:58:42 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 MAD0EPF000008C2.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 17 Sep 2026 08:58:41 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Thu, 17 Sep
 2026 11:04:13 +0200
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Thu, 17 Sep
 2026 10:58:41 +0200
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Thu, 17 Sep 2026 10:58:38 +0200
Subject: [PATCH] usb: gadget: f_mass_storage: Optimize CTRL-C
 responsiveness
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260917-ums_increase_ctrl-c_responsiveness-v1-1-95305f044ec2@foss.st.com>
X-B4-Tracking: v=1; b=H4sIAL2rq2oC/yXNQQ6CMBBG4auQWdukVCLqVQxpaPnRMVrIDBATw
 t2puvw2762kEIbStVhJsLDykDLKQ0Hx0aY7DHfZ5Kw72UtZm/mtnlMUtAofJ3mZ6AU6Dkl5QYK
 qsWdXhf6IDnWgHBoFPX9+k1vzt87hiTh9y7RtO+0qjdmGAAAA
X-Change-ID: 20260917-ums_increase_ctrl-c_responsiveness-0824bf3ede7b
To: <u-boot@lists.u-boot-project.org>
CC: Lukasz Majewski <lukma@denx.de>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Marek Vasut <marek.vasut+usb@mailbox.org>, "Tom
 Rini" <trini@konsulko.com>, Patrice Chotard <patrice.chotard@foss.st.com>
X-Mailer: b4 0.16.0
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAD0EPF000008C2:EE_|DU4PR10MB8878:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c7d414c-667a-4333-57d9-08df1499df67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|376014|1800799024|10067099003|56012099006|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: eBOmVVQbsa7DQy44VW0l2gjCMECp/8HOgBRw5LW40hvGWABpWPXqAD8mQymr9R6Fh6h9DgrpynJh6LULYbobly1KTXEmoAoSPDWJBAsp1ZVjgA1gHAxSMl54qRaX0tIL4Xo5ziC4svUpPEFTxfZPqSsxaLuf8egH6Htu+NRT34O+toeUhCAmrkDTuvL5w2ziM+I4ugqmVIGqnFHOc5uZIX+Od/JPjPiFgAhMKVG+RXrmP6oGU1/EFxOOCgZMgmNIyPVtCosysuHqE914P7/f05XaPtAnba/nbbPpz0QjAsPB+dzgVvfVya+iQxkaP9/IWhm5B/FOtC9xTjjTxmCk9jJwPsKqO58T51McJ0M7yDR3+RsPM0p4vlgrk810Gr/KoWtkwlEauuMR98Dn+ZZV8BshrePB2cfocydauoSVGvR76ikdan1x7uf6yUcRhy2cptmn7pUXGGfBNTTYueP0aiW4VEaPYg8STGP8vTsR3/mwLmA8TCQCbqrkZSTOCvhn0zp3kJ8wwfEj1AFMJi3CMNrZdiyktHdISw5v1dGnE9MBxzT7hNcvTj/66+MgslSJYZ1HvsMUiNaglcbKSX9O3NAx0B82Ituv+eplQ3fs7JvRbg6H4AGSpcBP+BaMgqhTk2hRW+EiwPNfsjT4Ak64kVLlaQdWo/0ZvO7sESAwWfSex/xxsHbzT/qjjdSodz7ml1e3sz+JEnOtqdHJwrwdmg==
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(376014)(1800799024)(10067099003)(56012099006)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: U8LQT/guW6dyL7z3b4Knx20f8rjWVTuWOgLEGoMlRvw/toM0rAZ8xl4sj0tr5cmZJHwQR253x0Y1cK0WZKOBZSDPU6EW8t8B1TXft4KUhjYs11FmhqwUU6PZjugLosEjZfbI3kt/lHC1d7Uhk7Y7BMETZCdDnZ8IWkhUlaV5W/M3MRQ6kLD/ivLFIR3TY7qmyIccP1rbAyLpRfW29a5ZVwK0Nrpln2EjRsSf0c/c61Dd0axDy8kQcBTAk6CBpZya+zOxewwI1x8GQ/+QNWqCq1WKDckxtZrupMxtDXur5gyO/CEu2xNWUdTUxUkE5Jk2NrkLyEJvWTljFnDYv6KSMU/9HFXNEA7hQ6svgQvIAdFwd/1nPGKLK0BGjOy6aI5HqLSf3s0OTk4AX7Sqj1E6F/dRMnxOYLyXx6LZhrO1exkiA5HRfsHamICIntVsTutN
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 08:58:41.9346 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c7d414c-667a-4333-57d9-08df1499df67
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: MAD0EPF000008C2.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8878
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

On STM32MP157C-DK2, when aborting the command "ums" using CTRL-C
it may take a while to get the control back on the console,
sometimes around 1 second.

By removing the if (k == 10) test, it increases the CTRL+C responsiveness.

Tested on STM32MP157C-DK board.

Signed-off-by: Marek Vasut <marek.vasut+usb@mailbox.org>
Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 drivers/usb/gadget/f_mass_storage.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/usb/gadget/f_mass_storage.c b/drivers/usb/gadget/f_mass_storage.c
index 7eb667c130d..e567fd03046 100644
--- a/drivers/usb/gadget/f_mass_storage.c
+++ b/drivers/usb/gadget/f_mass_storage.c
@@ -651,7 +651,7 @@ static void busy_indicator(void)
 static int sleep_thread(struct fsg_common *common)
 {
 	int	rc = 0;
-	int i = 0, k = 0;
+	int i = 0;
 
 	/* Wait until a signal arrives or we are woken up */
 	for (;;) {
@@ -661,24 +661,19 @@ static int sleep_thread(struct fsg_common *common)
 		if (++i == 20000) {
 			busy_indicator();
 			i = 0;
-			k++;
 		}
 
-		if (k == 10) {
-			/* Handle START-STOP UNIT */
-			if (common->eject)
-				return -EPIPE;
+		/* Handle START-STOP UNIT */
+		if (common->eject)
+			return -EPIPE;
 
-			/* Handle CTRL+C */
-			if (ctrlc())
-				return -EPIPE;
+		/* Handle CTRL+C */
+		if (ctrlc())
+			return -EPIPE;
 
-			/* Check cable connection */
-			if (!g_dnl_board_usb_cable_connected())
-				return -EIO;
-
-			k = 0;
-		}
+		/* Check cable connection */
+		if (!g_dnl_board_usb_cable_connected())
+			return -EIO;
 
 		schedule();
 		dm_usb_gadget_handle_interrupts(udcdev);

---
base-commit: b4ac71db13a33c4e6532c60a781ddf34b7f4375a
change-id: 20260917-ums_increase_ctrl-c_responsiveness-0824bf3ede7b

Best regards,
--  
Patrice Chotard <patrice.chotard@foss.st.com>

