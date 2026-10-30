Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5A2606A31A
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 14:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=UzIkY9rS;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=WeKd1sd+
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EE059817A2;
	Fri, 30 Oct 2026 14:29:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dRsnQNj1hCJY; Fri, 30 Oct 2026 14:29:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A9DCF8177E
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793370548;
	b=EsoyeJS8kk2WIGfTyYN1MDzRi6UItwiHwF9un6EwFjctadyG3aVfiu+CT1QGZFbZriGO
	 TYe8YtpNYGB5i6EJERVyrhvY3rKHKbDb+w5z6H9jMDzAa+cPtiaqna/gXk+zpsR7xN3gF
	 0fY7S2H5j6d96vcczwiggCXhf/3oJXmp+DuVkIu/LZ6Tr3kMcs7jrrfYp4ptr5K9TjAD8
	 hXh7lJHh9wjDM4dGGy2Fb+HBjsWyggs0i8OTnMWelwHqSnaXwvdowHrX/BOHi9qCntU+O
	 AjaJb7V1R+eGA2C4ielZ8ctSV+1i88Mf+fPRo2ijBGCw8WyUAhSkDYknGbNoI87IB6A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793370548;
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
	bh=vH4ui4ZDy0pqT1AESrv+JJ+DyBzMjLEa+24yXpsiRj0=;
	b=rkwHSmHYSFOXqN77Nv38w9BbBOPZzr8pkGslJqWl43BYn532Z0onYG4JbD/uhP6NpmfQ
	 EGTGLVqixo4LRIQ5ON0jCF0aZR40R9tNk2DmpaU2/T4UOJXRKkBAunYL64FzOCTcY8Zm1
	 rvf3NX35QpX+hVVzKA9b6WKJgE3egi/pbTySYZ0YPRC0kEYe7J9dCDU2i7PkRPJI9WDAY
	 sXIysJdl//PfMBojHthZ2GUtBBD3c819KNKs+xZAr3Usuy6Tcq5xscvjCj2Vaz/mJeiMo
	 JIP6NEDT2uiATEt/WrZkDiMiXX0OLCcz5rSYwUuxhCtHQcwNmdi67AZS018X9NfCNhw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=cherry.de;
	dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=WeKd1sd+;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793370548;
	bh=vH4ui4ZDy0pqT1AESrv+JJ+DyBzMjLEa+24yXpsiRj0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UzIkY9rSlxvJERfQFoei+zInrtwdtWKq09BssJBu0Y19TsdS8p/Ay1gPro3fjoyAO
	 I+SmzxkbC4VXioWZ34RWpgbvsmxBawdallGgnsVe+SVSi62TFXUSOhkif/1n1jL/WN
	 9kKaRvHBR4YZuaeSvvFqyQ0QSvCxrPwGnTHd05h7WoOLWyfw+iZXPoLp1+61wGacSC
	 UOUGoW2hlYw1GK1/s9VIQ7riEG3mQcMM3vID0XbHRVTVA8ZfKLuj41EiYecqtqWJFI
	 Nbo52UY8WoaZESCmnkErE8gqMrI/1Uwd7270BEDT7LnVYtxd3iChPhlXrIYqPiLe4B
	 9pNMmPAD9m+bA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A9DCF8177E;
	Fri, 30 Oct 2026 14:29:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6DCB52AC
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 14:29:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4E52181768
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 14:29:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ggvh-hBsGioK for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 14:29:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7139481778
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c202::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793370546;
 b=LamZ/RBapxe9ghuDHGY+GvvRK+znCUqHCP+GQPRnfSDl1SGQl6rpUrbT7oAaev41h9zM
 Y39pE1qxYUYgh+Kx3wIGOqs16FQZgRrR9Btz7rhXtA37bS/LRr9O2eAEcdk6GRcS4rgiY
 0W1pjOSoxL33T3EHr67XEZmEMJbYMvNCEGaAlneGN4hcL/jx3Q3tULlNMUXNmjXHXpQVZ
 b/kcs3VtAqfoku8git4vpJjeu0HbUzMvnQE2eJXTGBoVBOnfFgxfZR6eymIM2/pQbSsik
 y0K+4YFZD3JKcv0nopaaewbOQbMr6npiwKCwGPqrGsgBEkFSlI1DKOJpxBKJ2HJM2jA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793370546;
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
 bh=vH4ui4ZDy0pqT1AESrv+JJ+DyBzMjLEa+24yXpsiRj0=;
 b=Nn1cUrh6bZOOId20josSUH74WH+icyeIlG+hNo85GtntTPTYvVHP7ksPpTbn/AFvIjAJ
 3qqixcSXXsN+SmynKGOYNRizxPMrvl71oLDWHLzbbZwDTS1Qra6L8WVouIBMrc5h6vpUE
 d9RxIFSYBr5OsYICMIi0gpBNtxWU9yV/A0SA4q4QNHqDMchy+lHT2EkwX9DYZiK2UZs06
 okEKUfgQ7xa0NKnMZkKeuGzzZnyP2XsSNu/ysyUkSpn/xYiySN91WoKBrQLmJcOAmm7Dx
 tmNorE8fH4R99YJO9v01zU6FwzTB12BXlL5GpenscyV7Hh62AwCs7nNo00xpCoV7yzA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=cherry.de;
 dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=WeKd1sd+; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c202::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=WeKd1sd+
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7139481778
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 14:29:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZO/GU4lx9bfQCnpX+XsxUi3GD9RzQ3GxVcS1bDZwoRxNTPlEw//vkXqz4IjYeiwBaejhlTanX8F6XhpMdIKunytRQbCZAByE4QEQOgmxCkUBXJNh7Zw5UTcqBUKiRvbQdWWJ69idKwM5bPlfqgO98+fTZ2/GSJK1/NN8KTU1UPMKPQx7heSGbu73JvBPbR0umP3jQAst6ww+/r0a9tI4ozokpkQaA3PILTYeUfobsxeaH/ndn4GcHUXq9xwYao2OlUO9jMU4HLVwlmwkatQXZMyp1+TJSerbBlVXwIYEP71QE+IsGBHJGME0OIaFDoSwqCbdF7p4lvjLpsqdXWqDEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vH4ui4ZDy0pqT1AESrv+JJ+DyBzMjLEa+24yXpsiRj0=;
 b=g27UrJWkBPiJy9/PWRngsWyMbU35oc2B9HUxbao4BqXrAucGIJiJ8QYzg6SOXwt6wYh/yKczA5NbR97vf0z4gCUixPUeXv8CgTyR2MdS12Te4KNd2v9GD5LKDwUlp/C7wQL+NgByyqzpP4stxELgeUTbmfnTJJHVoffxrXYreoRZlJn4aZhcy5kzBhWcPqbzm9Fc4KMVh4/lgkXCIFSevL4WOHrL+xi6K+C0fyus49dXPv63QIcNwPx9zXbLr4+Rmz53p+a2AKj2Cf3HrV1pTkOCyl4CMiy9ws3b3520s1S0mvFcQSZN3h/JSyBtIbQRWZx+6ssVXZvzpexUwWKCTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vH4ui4ZDy0pqT1AESrv+JJ+DyBzMjLEa+24yXpsiRj0=;
 b=WeKd1sd+FE9fOVWbAflj5SrO9aKD6d8eEBrj4gOTke6NRbC/QVF+EdvKkNGGYU9JCGqKRrLBApJ/Qt4/YzrZVf4IxG2rWX4T8xLNU8gOaTdq8bcDDH8dumCy7A+uQYaHmtAmq8hfwrbQP4YbFwhW+cfAUFvPg8QFgCW4xT6GsqA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by PAXPR04MB8458.eurprd04.prod.outlook.com (2603:10a6:102:1d9::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 14:28:57 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0569.008; Fri, 30 Oct 2026
 14:28:57 +0000
Message-ID: <b464c545-c1f4-461f-8f17-48854bd70825@cherry.de>
Date: Fri, 30 Oct 2026 15:28:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 00/30] usb: dwc3: part 2, make the resynced code work
To: Anders Roxell <anders.roxell@linaro.org>, u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org, 
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org,
 love.kumar@amd.com, s-vadapalli@ti.com
References: <20261028141554.3073545-1-anders.roxell@linaro.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261028141554.3073545-1-anders.roxell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0282.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::7) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|PAXPR04MB8458:EE_
X-MS-Office365-Filtering-Correlation-Id: 40c3bd2c-777f-474b-5d20-08df369221ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|7416014|11063799006|5023799004|56012099006|261009223027099003|261028144727099003|261021121427099003|261022105027099003|261026140227099003|261026121527099003|261022075727099003|261021135927099003|10067099003|18002099003|22082099003|3023799007|6133799003;
X-Microsoft-Antispam-Message-Info: 0MLkxLI2LcSk7M+QYT3H99CTEy0Aeo9B62lGY0r+lYQ0r4ShOoSuFZl5GpjdZJxSNQYA6kJZfwrbvrSwsJ9fLqt9BldmbNaTFcwvZPmfK5CPgRWI7DOFDwgnBrorWt7mbzIQ3lt+A8IcSVHW9ovLxqyzQzkw6gTqsAcvkgmvj2M7R/S7joCnDTztMXqVN/lz2Oty5t8vqA1K1q9CtBw6hgV4v+PYYqzs25O9H3ZLpmy3wb5cB4ARd15DJ/fUTJa1o1aOB94wEFumiQlug2ApIxPQaXoVPUjnBsAvdUFo/XXCThZWSMkRLx6zc5Es4dy2JYA7SOcOe+wBe4P7mA0CCZ5SCd5gw0gMU07ypKy2cUWbvfmAy+5ncPQqvqkz940/uJTns/f8oXnHZU/k3AQvfdAs3xM8r6FHR0I4tVr5uGiijT6D29umaFxQqHGlhP+VmA6Q9kOF+bvYaU0hgu5Yhm5CyCkY2dYKeoN12DqdWfyvovf8AeYpmsdGl1b3EplH1FFJenJUvOkuxy9uEyhMO1YnEVMszk7PbJKv6Mxp/SnL/Sa5TS0g9HVRz5lDLONRHBU5geUSb36eOHewr8qwRyfcYf8OPogwUKuIgMQCbve1xtsUnv8VwzAS5Mj93c9Z
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(11063799006)(5023799004)(56012099006)(261009223027099003)(261028144727099003)(261021121427099003)(261022105027099003)(261026140227099003)(261026121527099003)(261022075727099003)(261021135927099003)(10067099003)(18002099003)(22082099003)(3023799007)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejZCeE5Nd2VlbmMwbVJvMWdoZjhiSUZvcXdSRklJejFvanAveUkxMndvbjkw?=
 =?utf-8?B?QnE4eWlsSDV6d282aW4zSk1Ga3pwVUVtbWh6ZWZ0akhvNDAxaDhjRWMwSGFK?=
 =?utf-8?B?ZVlTSjE5YmwzemFjN1pzZkxXdjlhODB2QUNzSTJsbHZ2bGMyNDk2VmZwbG5R?=
 =?utf-8?B?YldmYnRuQkxUd1NaOVk1bmFYVzVmRVk3RU1lcEdJV1JYRjhKblBPYStvT3NT?=
 =?utf-8?B?RGhRVjhOMVNZWVpjUnBqSmRLY2xUbzNjSVVaRjdYRTh4Ti9LNXBnbE1NUHFK?=
 =?utf-8?B?SUlsaTByTTBidHVKSHV6Y2ZpdzhVdGxadG1XZVhEMkxZM1FXblE4alZ6eUFR?=
 =?utf-8?B?OUpyeFpiREV2R1BzWTZPUGtqOGExVEV2T3ZPTVIrTmZySXBIMWUrcGlqTG5R?=
 =?utf-8?B?dS9NRU5ocVZKVEJISkJsUFF4ZVJ3L3FCS2JBUWZUVjhxMmdqUTlrcU4xb3lh?=
 =?utf-8?B?Z2N1VnFxemU3RGc2WGJrLzMzWWJWSHRvQnZSMDVLNjVPanI5UVNxTFlZQ0Vq?=
 =?utf-8?B?SEt0RnpaZFBQNXYzdXBDQ0VleHQrQXp2NnQzdVJ1NHU3SjZsbjNMYzNTSFpU?=
 =?utf-8?B?d0IwSEw2ZUluVW5CWUg1YW5JcmJrNlpLbzBJVkZmOTZtUzZIbWVobEVnKzYw?=
 =?utf-8?B?akQrV3J4T2N6Unc2ZG5vc3dUMWs2MlhWLzZzdlRsSmgrcWlQbUN3d1p6eC9K?=
 =?utf-8?B?elRTdUZFUm9pYndLV1R0d3h1N1FHMFloVzNpSGlUR0NiTU0ycGYyUG5KMUpz?=
 =?utf-8?B?K0FRbXhNTzNSYkJnMGpSdnR3SjBUMTNEZC9ZQ3ZQQ1BzakJQbS85TFFYL2Vj?=
 =?utf-8?B?d0ZoVEpvbkhFWVhrVmFUcVhib0xySnFQUlN1Q3V4dnpBc0lKUEhnU0s4WUoy?=
 =?utf-8?B?VnY1T01ZVW9Hc090Z05SeHMrYmswNFBMNlo2YW9ETU9ZUDVDa0RKNEVQbTVY?=
 =?utf-8?B?cm1ua00zZGpVVGNGOXJRTUxuZlR0dTJvM3I0M1VBeXlkSHJvbnFtVDBicmtO?=
 =?utf-8?B?QVg2Y0NvK2RYVzNaTGozUTdCZm1aVFl0OWNBcG9EaHJ6Qy9jdzMwQUMyKzIy?=
 =?utf-8?B?UnM4QmlvNjBFamZMQWJ2UktzNnY5VXpVdHc3OGdnc3I5NGoveGw3RGtabTh5?=
 =?utf-8?B?d1BSYlU1NWdXVUpZSkh1NkU4VkJNOGJxSzRtWWJxa3lzRDJGRjRIaEJIck5B?=
 =?utf-8?B?WHhiZHd5VEVSYXNoUm5hSmM3WUY4NURMV29GYTdSbUgwc3pycXFDb3F1SFU1?=
 =?utf-8?B?OHhieWk0YTdGNVJFNGxMQURQM0owZC84SWFzQ2R0NU9MYlM2U2N6Qk5Pa0R5?=
 =?utf-8?B?ZFF4U08wUHRjZDFETVMrWWtJeExLQ1ZJaUNidmNZcTU0MjU5SVNUMVNoYVBP?=
 =?utf-8?B?aDdCZENWOEd0d2UyME5zYmxUY3NaWCtHd2FHWmFOWTk3bUh4dnh1U0Qva3pS?=
 =?utf-8?B?MGhmUVZZMVJhVUt3enl4RjUvYUVaVEsvTEgydVBCZi9wSURxWGN1RHlrdFY3?=
 =?utf-8?B?UnU5R3prSlIxUTBWRTM5Ulh5UVE0L2RCMVhoTGFEQWlhU2tPYXRNbUlIUElU?=
 =?utf-8?B?bDNKTnVFVjVySHM1ZEV5TTh4aklSbUdaaE5pYW9nOXRtWW91WVRhTU9sRUtw?=
 =?utf-8?B?ZFloQXlyWnBKWjFWeFNZQkVOS2g2QnM5VTlwZVNsdmpVK3FrNE1WSWJMVHhF?=
 =?utf-8?B?blArbWpsMkdmOFdNM2djZ0RnWVBaNVd2cWk5c3lLcUlQSHhpMDJPeU5qUFRM?=
 =?utf-8?B?M2s0dEowM3pwU2lWWkhWYXpWcC9rdVh1YS9CWUswL2JLUnpwb21KZk5XWEh5?=
 =?utf-8?B?aG9RRmZDTEJXeXRGRXpBRkZjaWZSRW9pV2lEVzB6aGtkazArRmRITW5TRENN?=
 =?utf-8?B?VmYyOHFWbWRIbkJCbUNVU0ovaXhDVWxrZnMvanVkZ2p1Q216VFdicTJEc0VK?=
 =?utf-8?B?d2FlbzVPNDZBZFJvQUNQNFZ3MUMyRVFTeVFaeGo3bUk2eXJxSzFtT2NlUXdK?=
 =?utf-8?B?eGhFV2RFL09pVEtrcEtiZDNzS3BjSnlmRWtVM0dEN3JHbDloVW5GcS9LdGVa?=
 =?utf-8?B?eVB1T3lseW1OMDZYbFk4ZXNhSmh4YTRjZHIyZXBvNXVhbjVRQi90UDlZWWdp?=
 =?utf-8?B?SFdUQXRQNlRrZUFFU0t5SE5pNHBXV1NEV2twRnUzbnRscnhLZ1ZzQ2dvaGRm?=
 =?utf-8?B?cytzOEhHWExTNDUySEJCelowMUNjdStkMi9ueUNoMkRCSFZxQlIvYTRIZml2?=
 =?utf-8?B?eEgvYnAxcmFyWllVdHpyWEl6Sm9mQmFWMndlNkNiTzFPMlVteXd6YmdjSWo0?=
 =?utf-8?B?Q000RUpnQmNjaXk0alRMaGwzN2FGTXRxU29sek9kaFFZc2dROFQ3UT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 40c3bd2c-777f-474b-5d20-08df369221ca
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 14:28:57.0881 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kR6rOc8lKXbQ4/OWnoAINvHDFsPKoeK+98ISNy5n1Lw78m4mt4XjMZfES3ZJpO3U19XoL8kOawElW5Y2G4dNJKpcNdmAL+IQRxtvDt5THkI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8458
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Andrew,

On 10/28/26 3:15 PM, Anders Roxell wrote:
> Hi,
> 
> This is part two of two. It applies on top of part one [1], which resets
> the DWC3 driver and imports it up to Linux v6.16. Part one alone breaks
> the build for every board that enables DWC3. This part adds back the
> U-Boot glue, the XHCI and UDC updates and the build fixes, so the tree
> builds and the gadget works again. It builds on Jerome's work [2].
> 
> The two parts have to go in together. Part one changed too this time, so
> I resend both as v10.
> 
> The resynced epautoconf matches endpoints on their caps field instead of
> on their name. Five UDC drivers never filled that in, so each one gets a
> patch next to its other fixup: at91_udc, atmel_usba_udc, ci_udc, musb-new
> and mtu3. With those and dwc2, every UDC driver in the tree sets caps.
> 
> Build tested one board per driver: every DWC3 glue layer in the tree,
> dwc3 on riscv (spacemit_k1), dwc2 with and without DM_USB_GADGET,
> at91_udc, atmel_usba_udc, ci_udc, musb-new, mtu3 and am335x_evm. 19
> boards, no warnings.
> 
> Tested on hardware, per vendor:
> 
> - AMD/Xilinx: Love tested and sent a Tested-by.
> - TI: DFU and ums on BeagleBoard-X15 (me), and on AM62p and BeaglePlay
>    (Anshul).
> - NXP: ci_udc with ums on an i.MX93 board (me).
> - Amlogic: gadget and host on Khadas VIM3 (Mattijs).
> - Rockchip: host on RK3588 Tiger and RK3399 Puma (Quentin).
> 
> The rest is build tested only.
> 
> Two things are still open.
> 
> Anshul sees a single "unknown endpoint event 0" line on AM62p during
> enumeration. Siddharth ran mainline with a debug print and did not see
> it there. I asked for the raw event value with this series. No answer
> yet.
> 
> On RK3588 Tiger, Quentin got "WARN endpoint is halted" and a failed usb
> write on one port. The resynced core clears SUSPHY when it puts a DRD
> controller in host mode, and nothing sets it again. The last patch fixes
> that. It is not tested on that board, so I do not know yet if this
> was the cause.
> 
> The branch has both parts [3].
> 
> [1] part one, subject: [PATCH v10 00/63] usb: dwc3: part 1, reset and
>      import from Linux v6.16
> [2] Jerome's adaptation work: https://lore.kernel.org/all/20251121153812.2076440-1-jerome.forissier@linaro.org/
> [3] https://github.com/roxell/u-boot/tree/usb_dwc3_sync_v10
> [4] v9 part two: https://lore.kernel.org/u-boot/20260916123826.517181-1-anders.roxell@linaro.org/
> 

The following three paragraphs are copied over from v9 (and slightly 
adapted), just so you don't have to go fishing on the older version for 
context.

I applied both series on top of current main (3973f3c4d24d ("Merge 
branch 'qcom-main' of 
https://git.u-boot-project.org/u-boot/custodians/u-boot-snapdragon")) 
and tested on RK3588 Tiger (three DWC3 controllers exposed) and RK3399 
Puma (two DWC3 controllers exposed). For each board, one of the DWC3 is 
routed to a micro-USB OTG port which doesn't seem to work (before or 
after your patch). Considering it's historically finicky in Linux, I 
wouldn't read too much into this.

Tests are performed like this: I insert one stick in a port and power 
reset (turning off/on the power supply) the board and run the commands. 
Tests for different ports for the same boards are run with a power reset 
(turning off/on the power supply) in-between tries. If you want some 
other tests or a different test procedure, I can do that too. I've 
stopped pressing the Reset button and instead handled the power reset at 
the power supply directly, because tests were not stable and had a bunch 
of USB issues (when testing your series, I didn't try to see if it also 
happened on main). Reading the schematics, I believe the USB ports are 
kept powered when I press the Reset button and I guess something doesn't 
like that (either the USB sticks, the SoC, both, who knows).

Some information about the HW routing for those boards. RK3588 Tiger 
directly routes individual USB ports to separate controllers. RK3399 
Puma has a dedicated DWC3 controller for its micro-USB USB3 OTG port, 
the second DWC3 controller is routed to an onboard USB hub that provides 
two USB3 ports and two USB2 ports (one exposed on the carrierboard, the 
other one used for our onboard USB/CAN adapter).

The commands I ran are: usb reset && usb tree && random $loadaddr 0x8000 
&& mw.q $kernel_addr_r 0xffffffffffffffff 0x1000 && usb dev 0 && usb 
write $loadaddr 0 0x40 && usb read $kernel_addr_r 0 0x40 && cmp.q 
$loadaddr $kernel_addr_r 0x1000

I tested twice each scenario, both from main and with your 2 series applied:
- Q7 USB P0 (lower) with Sandisk Ultra Flair USB stick,
- Q7 USB P2 (upper) with Sandisk Ultra Flair USB stick,
- Q7 USB P0 (lower) with Kingston USB stick,
- Q7 USB P2 (upper) with Kingston USB stick,
- Q7 USB P0 (lower) with Sandisk Extreme Pro USB stick,
- Q7 USB P2 (upper) with Sandisk Extreme Pro USB stick,

RK3399 Puma behaves the same in main and with your series applied.
RK3588 Tiger has some regressions.

Q7 USB P2 (upper) doesn't detect the Sandisk Ultra Flair USB stick 
anymore. It does on main branch, but on the USB2 controller only.

Q7 USB P0 (lower) has issues handling the Kingston USB stick. 1st try:

=> run usbtest
resetting USB...
USB EHCI 1.00
USB OHCI 1.0
USB EHCI 1.00
USB OHCI 1.0
USB XHCI 1.10
USB XHCI 1.10
Bus usb@fc800000: 1 USB Device(s) found
Bus usb@fc840000: 1 USB Device(s) found
Bus usb@fc880000: 1 USB Device(s) found
Bus usb@fc8c0000: 1 USB Device(s) found
Bus usb@fcd00000: 1 USB Device(s) found
Bus usb@fc400000: 2 USB Device(s) found
        scanning usb for storage devices... 1 Storage Device(s) found
USB device tree:
   1  Hub (480 Mb/s, 0mA)
      u-boot EHCI Host Controller

   1  Hub (12 Mb/s, 0mA)
       U-Boot Root Hub

   1  Hub (480 Mb/s, 0mA)
      u-boot EHCI Host Controller

   1  Hub (12 Mb/s, 0mA)
       U-Boot Root Hub

   1  Hub (5 Gb/s, 0mA)
      U-Boot XHCI Host Controller

   1  Hub (5 Gb/s, 0mA)
   |  U-Boot XHCI Host Controller
   |
   +-2  Mass Storage (5 Gb/s, 126mA)
        Kingston DataTraveler 3.0 1C6F654E48EBB161D95D8F07

32768 bytes filled with random data

Device 0: Vendor: Kingston Rev: PMAP Prod: DataTraveler 3.0
             Type: Removable Hard Disk
             Capacity: 14784.0 MB = 14.4 GB (30277632 x 512)
... is now current device

usb write: device 0 block # 0, count 64 ... Resetting EP 3...
WARN endpoint is halted
Resetting EP 3...
WARN endpoint is halted
WARN endpoint is halted
Resetting EP 3...
WARN endpoint is halted
WARN endpoint is halted
WARN endpoint is halted
WARN endpoint is halted
0 blocks written: ERROR

2nd try:
=> run usbtest
resetting USB...
USB EHCI 1.00
USB OHCI 1.0
USB EHCI 1.00
USB OHCI 1.0
USB XHCI 1.10
USB XHCI 1.10
Bus usb@fc800000: 1 USB Device(s) found
Bus usb@fc840000: 1 USB Device(s) found
Bus usb@fc880000: 1 USB Device(s) found
Bus usb@fc8c0000: 1 USB Device(s) found
Bus usb@fcd00000: 1 USB Device(s) found
Bus usb@fc400000: 2 USB Device(s) found
        scanning usb for storage devices... 1 Storage Device(s) found
USB device tree:
   1  Hub (480 Mb/s, 0mA)
      u-boot EHCI Host Controller

   1  Hub (12 Mb/s, 0mA)
       U-Boot Root Hub

   1  Hub (480 Mb/s, 0mA)
      u-boot EHCI Host Controller

   1  Hub (12 Mb/s, 0mA)
       U-Boot Root Hub

   1  Hub (5 Gb/s, 0mA)
      U-Boot XHCI Host Controller

   1  Hub (5 Gb/s, 0mA)
   |  U-Boot XHCI Host Controller
   |
   +-2  Mass Storage (5 Gb/s, 126mA)
        Kingston DataTraveler 3.0 1C6F654E48EBB161D95D8F07

32768 bytes filled with random data

Device 0: Vendor: Kingston Rev: PMAP Prod: DataTraveler 3.0
             Type: Removable Hard Disk
             Capacity: 14784.0 MB = 14.4 GB (30277632 x 512)
... is now current device

usb write: device 0 block # 0, count 64 ... Resetting EP 3...
WARN endpoint is halted
WARN endpoint is halted
WARN endpoint is halted
WARN endpoint is halted
WARN endpoint is halted
Resetting EP 3...
WARN endpoint is halted
WARN endpoint is halted
WARN endpoint is halted
WARN endpoint is halted
WARN endpoint is halted
WARN endpoint is halted
WARN endpoint is halted
Resetting EP 3...
WARN endpoint is halted
WARN endpoint is halted
WARN endpoint is halted
WARN endpoint is halted
0 blocks written: ERROR

Cheers,
Quentin
