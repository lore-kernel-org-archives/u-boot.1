Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EFD6081CD6
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 15:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=a+7Vr2Fd;
	dkim=temperror header.d=kontron.de header.i=@kontron.de header.a=rsa-sha256 header.s=selector1 header.b=PCDcRXa3
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B3A008107E;
	Mon,  2 Nov 2026 15:02:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sQ3UmPxVOIfz; Mon,  2 Nov 2026 15:02:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org AF14180FA0
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793631743;
	b=sj8IKjTcyTQ/Q2j7hBbciZ54LLFy/10f48ptg8eStQ0x02r3qcMgLx3ibOrLAJcr18+7
	 mj7U9bzXVrIQVkLqARvoY77CbrW8yp5D7TsTwK6TOZasA4xs8tDcbYpVnXykOqZGyiaRC
	 EKxABNvxubZKwA9QX5Rlpi99fZ6afJgArMrQHV9LqclokU7XwpmnUySCfpfiEK3qkLb3I
	 YbeDpcuPPesd86TgfB/8DTIuLBtZk32h+51hZdZLU6ZJHXuBC73QnCH5AFiBTDaMLgTnW
	 Dt1P/eSg6LKUvbtBnjHaz4yyrIrYNeRpqAEiGWpiH2UURE+17RKntn+thNzQtolSByQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793631743;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=dnWgMQo8JUXQ3VAq/FhwdajnFMTVSrhnjnGd8VgC9mw=;
	b=LgUZS90zEeigpJE/oEbRQWVSJ6Z22jG0Un1Ed5QQYUqgcwer3JtLVj8sRMaSSLuMs+Iz
	 UFgwUcqq9tE4NFmDv4k5YQzQBYEcByFgZEH9UVsYyg+2k2KxWYDa43ecGM9Pn6xrRN0xB
	 6QZbBG2OJDEE6sqWRtVBgMh9S357BDVjfzrAwfUnjf5JD5944LZIHA72gc9kOzYhaI4nL
	 Xp4/PI5EPZ8KrA4jvLkWIzvcEimoSz0joKjc4K0rIlyEVB1j6oDlM+ec+rrmifVhjoeVD
	 VTgmi4LWMG0pi0GOtoobzu/2OO3rz5ZvAJAXuSQq1Wq2X0+5ZF/WcGRigNpRGYlBPwA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793631743;
	bh=dnWgMQo8JUXQ3VAq/FhwdajnFMTVSrhnjnGd8VgC9mw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=a+7Vr2FdBll3HHsaukrD4vyFr9fquI7xOOJ8CyOctHBmDPivgiJJ/3F8z295rWntl
	 UiPFX/ypVM8eYcWrznnk7SF0JWkpVbYElI9aCjiqJhFp8aJMkUFp7lfqkrS7R0P9v+
	 u0WC2uqLUiWJy9U6Pho/E+foC86+jGR0LClhHOCWPAUiGvenf2h7dsgPZIOA8DtE2I
	 GPHs+/9xjseky50msh0LpS2EQLv90qm+a55N5hrRigoCk4GY5bQIAeku+MN/6/SnHv
	 8dbr/x89tzHT0gc8xqVFdg3+JjTxVNhYrUG42/l+UB+FkRtSz3QGQHNthZhUXBXbds
	 w0xoJtsS9k1eQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AF14180FA0;
	Mon,  2 Nov 2026 15:02:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9DF34D3A
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 15:02:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9B9CE607AE
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 15:02:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JMlpLv1nB_6h for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 15:02:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7DBFE60776
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::6"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793631740;
 b=UAhjRFmWD04riub29DXG8n9IeBcjFp/vtyR14fu6n5CooNWsDlESnNulDc0BFBOXYAjK
 CUMlll1U1AbQF5INfTYewEFaAq3v0998sUlQWqpzGFi9JfuZvBWy7k+8+wn2vAR4exCjC
 LLorqZ+mwAUTPaI9Py8a+EnFohNQfUgaa64En09ArXz20bE+X7Zn93UBtJ716t5dTT7jM
 DHXpV5spTbG/fIHTF/wxHmBCd7TDf9y2Q3yva+wD48j9yGRyxUwEkZlddXCMOXTpn12L+
 6ke8FVgEiA3VDshPfhJ31B1rYE1Nmbdsf3U/FfX74xJTbX5EG6r+z1RPivowNCwY8TA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793631740;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=dnWgMQo8JUXQ3VAq/FhwdajnFMTVSrhnjnGd8VgC9mw=;
 b=OnMzZ5jVLZwXeVZTZO338UDAHL2cWBM7KZKvlcfApcbXF3sxbe6yVZLkVxr4iLULM0ni
 mGz1Ar8S8r+FqFBXxrUaky7xkP+s1OKzdvomdH5eU6jz/thEU2VaUUgOO8FQeu7cjrKMj
 YfJEAWds9OMG0MaZ1aQGg7WiZI70CVSlqADTphwIIjZt9+SGMzs9fkvwyCSAyWoo9qU3g
 8udl0GsrYS4zLzYyn+d6HBOrcW8gIju07NKUDeYVAcLEvkGJJVJ5dFQWz8iRKJdeI28RA
 4nqVt9VpMBJwJ9j9MpbXLVINPZ3P6mdPF1FuQsiIzrhz39oIjtIosnkQvZdr1nSrMpQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=none header.from=kontron.de;
 dkim=pass header.d=kontron.de header.i=@kontron.de header.a=rsa-sha256
 header.s=selector1 header.b=PCDcRXa3; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c201::6"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::6;
 helo=am0pr02cu008.outbound.protection.outlook.com;
 envelope-from=frieder.schrempf@kontron.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kontron.de header.i=@kontron.de header.a=rsa-sha256
 header.s=selector1 header.b=PCDcRXa3
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7DBFE60776
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 15:02:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lt1+dXLap26Ox396fd4+8UJ1mknEnA5QRNQFXOhETW9r7n9qC6MQnEt2DOTNJczQbh4iEsuHPErxFqQToala9za2Yd2w+k51YdYqgmG5QdcgFy0QN8tm/yphWV2G+XSDkq6kaub+To1sk+mgoEw9cCarJuXTDRG5yWFSCShsq/C+6lgrU1UfyVNOuVwxEcgUcAwzrkSCncNY+qAsIP6QWq2xeX7qSQH8rg8RcYZ9/Cej/gWmVom0UriLR4EFJE+Kvb7OiJBaXN5CzLc3XA/ONaYfHTV7H6WHG2Fszt/r3b3nNVqiPK31hFOdC8McNsyZLF463FWGmHpHimH0xbQhww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dnWgMQo8JUXQ3VAq/FhwdajnFMTVSrhnjnGd8VgC9mw=;
 b=spxDUpfw9fWReiy6eV+dove/qDN9A7lMgzcn1LSc/XRCznJuZyy6f9U6+h4RerbxzknISw6ZqF4x2swMi3qUR0Z1YaxAZVf6hc9LGLnhXcJ+q8LP3laOcdkDCDf1cvodB2/WQrRgHoGwkP0l+M8/0b+tEb6xTRp+xQ7vxsrbE9VmHteXp0OUbD+5T82jXk7nn8ArobxDikpHszJRsesSZhdjBPuMIHmmyQDBsAakX6o+zvHLsZJsSPtctUCg39ge2yqiPpms7DyJLETnKgjxdTk6UFCeoEX/LIF4i0EsE7AgT04xwuSGZt4/HWvqkSOVv1eXk/dl+Lq+NW3yh1xs3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dnWgMQo8JUXQ3VAq/FhwdajnFMTVSrhnjnGd8VgC9mw=;
 b=PCDcRXa3Ejn1f8+jbqjW6j7gIJKx0UzLQDtJwq8G+OvUAza2zYP9tMieHWngPyQw0ZHix5lR0O4YqgHi9furRdaW+gxrMbbCCtwyYVuASI+hC0AWeP4iKygPavRe/MjMzfmM9aSLU7LvferSAh+B8T0DmKXiFFp9aQCuygmIZ2lBgzqx+sjcXGz47XmAa+0+dWelx+pl2/Gh78RDZYW4vQ6pCY0y0CdRCqg7MxsqPPwA4MGeO6Kf7PYJ+WmjBbQ4U0+ElnndA9pufUzlQcPpaAI6a2JBvK0VF9TJMDVy2IwDXGL5vOr1DaInrxmtHJKgxqia1XDEHQ8bS3SDbuvAZA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1fb::23)
 by CPHPR10MB383388.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:380:10e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Mon, 2 Nov 2026
 15:02:13 +0000
Received: from AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a276:4ad7:962:da22]) by AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a276:4ad7:962:da22%3]) with mapi id 15.21.0592.007; Mon, 2 Nov 2026
 15:02:13 +0000
Message-ID: <c99454af-d3db-4953-9bc6-c9a26884504f@kontron.de>
Date: Mon, 2 Nov 2026 16:02:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] bootstd: rauc: Optionally check the partition names
To: Simon Glass <sjg@chromium.org>, frieder@fris.de
Cc: Martin Schwan <m.schwan@phytec.de>, u-boot@lists.u-boot-project.org,
 Tom Rini <trini@konsulko.com>, Aristo Chen <aristo.chen@canonical.com>,
 Alexey Charkov <alchark@flipper.net>, Daniel Golle <daniel@makrotopia.org>,
 Johan Jonker <jbx6244@gmail.com>, Francesco Valla <francesco@valla.it>,
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
References: <20261029-main-v1-0-b5a878627107@kontron.de>
 <20261029-main-v1-6-b5a878627107@kontron.de>
 <CAFLszThRj-uY=BVBgoVfceRTHw51FW_VS58cmR1SimMS78jKHQ@mail.gmail.com>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <CAFLszThRj-uY=BVBgoVfceRTHw51FW_VS58cmR1SimMS78jKHQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0388.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::17) To AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1fb::23)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4277:EE_|CPHPR10MB383388:EE_
X-MS-Office365-Filtering-Correlation-Id: caa883fc-6050-4438-2617-08df38f246a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|7416014|261021121427099003|261021123027099003|261022075727099003|261022105027099003|261022115727099003|261009223027099003|261026121527099003|261026140227099003|261028144727099003|4143699003|11063799006|10067099003|56012099006|18002099003|261102123227099003|22082099003;
X-Microsoft-Antispam-Message-Info: ScFghDGOw8E/P3jfrk7mWr+C0dhQzD9TiJGOR8nVmW0b6HV6bolgxybKzSloe1kRKDANwr28CpCxbEku+EFGAcHILEbR87njLl7i8bYSZL4yI20PqdP2DH48ZeqmoNFMJsR1ZLrsJZT/V0YsHwt7W+hwu1nx0FsA0ExRUytclqXcKP/v868zk7dP+g+Pcl5Mbwf9L9uCehuK8aV6DbCpwLTVXUGXumR94jyjywA5e55J3SZWCP7Xj6FxQHgAeeb+dsvm77Ge0MitMOnSQ0aO5k0ObbjsCiyy5BVKJxRK7uepFAsrVoSw6UrwJClZPH7YWB+5rqE/nWcBMKPGXjBf8Yu+UcCiZZXtcKRdS5ImDqXK+HypJvN3MD07v3be5Rut6gkdINib8MYgInOOBlUYb6PKjJzysrUfQ/iv37x4LIxoN6/OAOwxuNlceIv9vjgLSmryi758YXDxo8HIV2AX06UREA8tf8ayetk/NYsCD2fqezQc0KoGVn7k7HVeZuMwRKvGz0ah07Km65k0zUnwnIjPYQUSXOJgCCMdczVKWS6vMLrY84KVThKP+ioBT7FOjH2DC0zhFzrhroruDX0Q6bjOqZS3CwFxc5+CHlGPvjcS+6/EUdfA64thP384IwjAXHQCUGueEpp42isgK6TKdXmNZovschDmSoJwEsfQkqk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(261021121427099003)(261021123027099003)(261022075727099003)(261022105027099003)(261022115727099003)(261009223027099003)(261026121527099003)(261026140227099003)(261028144727099003)(4143699003)(11063799006)(10067099003)(56012099006)(18002099003)(261102123227099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RlRCMlhDKzg5RUc1dW1nUjZCMjBVRjM0eCtiMkwwdjY2blNQUm5vaXpTMERk?=
 =?utf-8?B?eVZLaW9lZ1A1cGpKdWxCclRWQW9HQlByRTB1YzJCMUZwdGZOZTZCT0pmTXZv?=
 =?utf-8?B?eU1FamMzTHBkVGlqZW5rdDFvd3hmdWg4ZTkrTldRN3lxaENXZTJHV3B3NHpI?=
 =?utf-8?B?djdqL2dxbGl4ckhubi81UjNOSGJHRUpXQnNROWpKU0dvQkVIaE42MHlqK1hC?=
 =?utf-8?B?ZHR1RTVrc3huSnhMTXVVelN0dEpyZGc2c2xid3E0VHVkT2x6ZkZOZWxzcVM2?=
 =?utf-8?B?dmFuQ2FJREp5MjExajM2S2ROcXArR2VtRkNuSnJCSkU5MG4wSXJLRGdiR2VQ?=
 =?utf-8?B?WUhjV0VHa3Z5TVpNRnpuY0hQTW1JTXBmZHNXNzl1cXAyVGlWRWppU1lDcURh?=
 =?utf-8?B?dmh5UTNXZzZORXJSdytDdkZSRSt5ak1DMy82QTI5ODVwMVEzYTV0SUI1S3hr?=
 =?utf-8?B?dFZ0MTVURW15S2swK0V2U0xzMVlHWE9XeEJlRGJETjZUNno1ZG04Qm9jcVV4?=
 =?utf-8?B?aENOdUtxSEdzY3JJNEJSODZya0doNjArMWNHSGwxcU5YMG9vOStSWXFpeTBu?=
 =?utf-8?B?S0NraklRaGtJQ1M2ajEyYWM1Unp3bTRORkJrSlFrOHVGSkJiL2J2Z3Y0N21U?=
 =?utf-8?B?blRpZTVtTFhKY3VQeFIrTWdXNVZqK1FldFNVbFQzQU5mOG5XWng5dmJFWFRz?=
 =?utf-8?B?bFN1d2dUbTc3ZVFINHFzSkZmQkM2UmVtOTVHMEQ0a0NqRit6ci8zNTJIMTBm?=
 =?utf-8?B?ZmFxMU5pdHVqUE5rcTVOM1lvbWZZSGtZa0szNC8wQTBveU9ob2tYb3JjUmdS?=
 =?utf-8?B?aHNjYjVkcmZNUEVQT2lBYkVXVlpxbDQrSHJLeWZiWHU4anNpcmhUVDhLSkl6?=
 =?utf-8?B?dFd1bXdlSTl3THVqWUIyZUhoeDNqTExmV29PTEJyTkh5MHlCUWZWK2J1ZERy?=
 =?utf-8?B?cExPMFp0Y0w1cUxxZWMyU1AvWHRzc29SV2J0ZGk5NUczajF6cUVoUnBoSWU2?=
 =?utf-8?B?SklOMkE5TjVhc3Nia3dwaEZCRzN3Y3ZTdWRwOWVkMjNZU3ZMdzhHN2IyelFl?=
 =?utf-8?B?WTFPR2ZYVW1PQUNZbHB0dGtGUWdLY1Iva296cU9rRENQNmdkMnFQOXZtOGtV?=
 =?utf-8?B?TmV6SUpRVXM0Skk4Y2RISWJSMFBoaEVtRHp4SEdtNWx2RUhpUk9PNktMWXRF?=
 =?utf-8?B?V21ZVWJKMnhLd1EvWVltbjl2a0hwZk5WaTFLVG9IK05pYmM0c1dQU3lCbXB2?=
 =?utf-8?B?S3ZLMkcrUzh2MmFVUVFQQndvVnZhaWQ3cUJxQkpxNU43cGx3R3pNcVgrM0VK?=
 =?utf-8?B?TXZHbVhMRVdHVmtVb3pNb3NnYVhEbkpkZXA4RlZYQ0x5dlBWQ3RGUDZDVnh2?=
 =?utf-8?B?OFJNeFdtcFRvVyt3WTNocVJvM1BMcHFpQTZJNldKVDRaSUVucEduZnJOL0hF?=
 =?utf-8?B?Vm9PY1dnZlhTbnJGem9BZmhWRkNGcU5oU1JndzJ2QVNjV0g3MzdhUTRmSHVL?=
 =?utf-8?B?TjlSUUNCVkJJU05MQzhrOGh0SlBGaTl6a0FSNGZKRE9najJtNm55MFNLZ09r?=
 =?utf-8?B?Z1lGT1JkdFhrVmZoYWZkQUFMVjlnd0VacUZ5WnRVNFdLWlNxRWpSeXhEYXJt?=
 =?utf-8?B?bm9aZm8zRG1CMElSYXYwMnRISEJUR3VvSnZTekNZcVcwRmVGYlJGS1ZGSm5a?=
 =?utf-8?B?RUl0ZFVUN2VXRXZIZ2hiRTJpMklKMXl5KzZaVkFXOGsyRHRDVFBpOXZNUFJT?=
 =?utf-8?B?RDZqV08yM2Y0SHdxSXM5OHZETm52K2N2NWQ4YjdaVEJXZmZBWFh6YUZFb3Ez?=
 =?utf-8?B?WmtzbFZzeGZ2dTlyTm8wTEI2eGFzc2haSkR2WUdyUThoMFZpbGw2QWNwT09K?=
 =?utf-8?B?bUY2RXlpMDM4U1MxZUZ4YkdWTGx4UlJwWHI1MEtPUlNUMzQ4aFpBSWt6QUU2?=
 =?utf-8?B?TiszdUo4N2wzVTcydHgwZk5hSWdoeWh2eWI4WVVadmJVQ0xONC9XcUtxVVp4?=
 =?utf-8?B?WjhRQzFvZVJrRHkzUkVYMU95bThybGg0WTdiVkVEUUszWFFLbjAxUmhCNi9H?=
 =?utf-8?B?cHNFKzFjZXNwNTB5Mlg4WUlIZ1pGMHRnQ1pLZWNxRGNZVXVIWC96TUpLQUNq?=
 =?utf-8?B?OWVMWnc0M01oSWdNblo0YkZoZGVqWmErU1BnVkxBQzZoaWtVUW92eTMxZ2hw?=
 =?utf-8?B?YXhQa2ZUQy9sSzZNbGEvTFdOT1BnMFFZMXNCNXlQWDhGVjdFZm95alJDL0tO?=
 =?utf-8?B?amJ5dHQ1Q3pIQU41Vi9Jck5mcVhBbnR4T1NsNy9WLzJWK0s0aUowWFlDVFJX?=
 =?utf-8?B?ckZkUUV0Y2hQeWxQMENxVEpjZTl3dTFJYWlXVFl1ZnpSV1JybEFuSUE3U3dR?=
 =?utf-8?Q?Lse5VRO5NNvyw6j4=3D?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: caa883fc-6050-4438-2617-08df38f246a3
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 15:02:12.9282 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u/PH5K2v0Smytwk7nTvK6cy9XGvARj6nWBJTQetJkADj1abypq3WhnCNnFRU0Q5snAL3/bjQ5WHqGwSBtRrlsYlbFzztdLySu837XqXRnto=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CPHPR10MB383388
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

On 31.10.26 15:06, Simon Glass wrote:
> Hi Frieder,
> 
> On 2026-10-29T16:23:07+11:00, Frieder Schrempf <frieder@fris.de> wrote:
>> bootstd: rauc: Optionally check the partition names
>>
>> The RAUC bootmeth uses any MMC device on which the boot partition of a
>> slot holds a filesystem and the root partition exists. This also matches
>> devices with a different layout, for example a single-system image or a
>> standard distro installed to eMMC. The bootmeth then claims such a
>> device and creates and saves its BOOT_ORDER and BOOT_x_LEFT variables in
>> the environment, which makes it difficult to run BOOTMETH_RAUC alongside
>> other bootmeths.
> 
> One thing I'd like to check here. distro_rauc_read_bootflow() still
> calls env_set() for BOOT_ORDER and each BOOT_x_LEFT before any
> partition is looked at, so these variables still appear in the
> environment for every MMC device scanned, including those that fail
> the name check. This patch stops the RAUC bootmeth saving them, but if
> another bootmeth (or something else) later runs saveenv, they end up
> in the saved environment anyway. If the aim is to leave other devices
> alone, please can you move the defaulting of these variables to after
> the scan succeeds? scan_parts() would then need to use
> CONFIG_BOOTMETH_RAUC_BOOT_ORDER when BOOT_ORDER is not set.

Right, I will try to add a patch that moves changing the env to the
point where we know the device is valid.

> 
>>
>> Add CONFIG_BOOTMETH_RAUC_PART_NAMES to set the expected names of the
>> boot and root partitions of each slot, in the same format as
>> CONFIG_BOOTMETH_RAUC_PARTITIONS. If set, a slot only counts if its
>> partitions carry these names. As only GPT provides partition names,
>> this also rejects MBR devices. The option is empty by default, which
>> keeps the current behaviour.
>>
>> Assisted-by: LLM
>> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
>>
>>  boot/Kconfig                 | 13 +++++++++
>>  boot/bootmeth_rauc.c         | 68 ++++++++++++++++++++++++++++++++++++++++----
>>  doc/develop/bootstd/rauc.rst |  7 +++++
>>  3 files changed, 82 insertions(+), 6 deletions(-)
> 
>> diff --git a/boot/bootmeth_rauc.c b/boot/bootmeth_rauc.c
>> @@ -138,6 +161,11 @@ static int distro_rauc_scan_parts(struct bootflow *bflow)
>>  			ret = part_get_info(desc, slot->root_part, &fs_info);
>>  			if (ret)
>>  				continue;
>> +			if (!distro_rauc_part_name_ok(desc, slot->boot_part,
>> +						      slot->boot_part_name) ||
>> +			    !distro_rauc_part_name_ok(desc, slot->root_part,
>> +						      slot->root_part_name))
>> +				continue;
>>  			slot_found = true;
> 
> Only one slot has to match for the device to be claimed, and
> distro_rauc_boot() then picks the active slot from BOOT_ORDER without
> checking whether that slot passed. So if slot A matches and slot B's
> partitions have other names, the bootmeth still boots slot B when it
> is active. Since this option is meant to make the bootmeth safer, I
> suspect it should either require every slot to match, or record which
> slots passed and have find_active_slot() skip the others. What do you
> think?

Yes, I agree. The existing matching based on partition indices only
requires a single valid slot and this behavior needs to stay for
compatibility reasons. But for the named partitions I think I will make
it require both slots to match. Recording the slot state and then skip
the invalid ones later seems a bit too complex.

> 
> Also, part_get_info() has just filled 'fs_info' for the root
> partition, so you can compare fs_info.name directly instead of reading
> the partition a second time.
Ok.
