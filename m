Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4243C606A31C
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 10:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Fg+wSEXJ;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=jXB//EOR;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=jXB//EOR
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B4380606D6;
	Mon,  9 Nov 2026 10:59:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FsQNdn1Ug3sH; Mon,  9 Nov 2026 10:59:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7CF8A605E3
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794221943;
	b=FAB3DdfKISONIpbNlVQkF0tFSJBsqHNZ9OiYBZT6O4yVg3c6MAi4bRwIuk9cPrYISYIM
	 kM51mWIJiMUCAhP1gtsyQ/KtyV1TleDMTEOnbS4pIEIwtzZr8IdBE9s/D/mIEi006Std/
	 top0XpSta/vweuU0ij1n1wq8chgtZPaDT5VdE6Z8I8gArYCvrx4jeP9492xXRE0egvJXm
	 nWZN/ZKy7x59c45VHLOBAW7bARV50HpSJIhip1jE2WEMB4KpKl3Lnj1/6DjUnywPEEAZb
	 1f8xBJ18+Qb2yyhRIaB7YvAIGA5FS+qwh0POPpeGg7c6JyubV8WapkGpidktKhZ+9Mw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794221943;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:DKIM-Signature:Authentication-Results-Original:
	 Received:Received:Message-ID:Date:User-Agent:From:Subject:To:Cc:
	 Content-Language:Content-Type:Content-Transfer-Encoding:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=aeUb33WNbHfQq/836ssWydbg3xPZSk5q3zqmk33xRWw=;
	b=lT6agltZpjnJap7USc0OXXJRHWckoefNLniNAxHbsvkO7zU1YNeA60CiZ5l2dOwPJyCE
	 1tXaSAxIeTXnCmtI9hGgyWLYT8qOwyMsG+nVc+Pn+KAlap3fPnmnitNGGdgXp5Bhw0+XN
	 wzL29+Dn2eR0DMduOCFQxs18boC+yTeQ0OgD00CrnGurXTWVwGS+0kv9pxtYo9HfqCdev
	 KNcCrPQInb3KxW0bQOmn2LbsLnxCJUaDABz2X33d9xnRpXj2ZRCktBr2womt+/BwL64t+
	 ySZE/h11vep74KiiRbFroJ5bzMd+Q6tjB/WeFO20ki0BVnR+MBbfz+Hk4lZKpmXa61w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794221943;
	bh=aeUb33WNbHfQq/836ssWydbg3xPZSk5q3zqmk33xRWw=;
	h=Date:From:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Fg+wSEXJ7y16t1Ek4nvUG0vsCVbOF36/Iy6/WbXRZPP1rPi7Lw1PffPNsE0mnyDeR
	 1b3wHuDefhDX9oYGsCx/ptInwF/DSEsTOW4gZ/rT3qNfQj3kBJBx7SlBW57GUfxpFB
	 3fbCbKMBlQ3TfwaqWTi2NQIPQd0DaXqh0NipksqAkhSUWwIKNpihbXrWRZBQkxtexe
	 mwzE57zqPT9nQoczoKxY578zCRylW0fZta30L30ITBqtaN5s4ofGDmxn6cFcsYh7wu
	 GqopJMW5KL52+/2cjJ5OQa42kLxb9xKM222dXAa+cTw7jXzrXT2zKwmAdrl+TQx+pt
	 IJxIlQJbjZHuQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7CF8A605E3;
	Mon,  9 Nov 2026 10:59:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 10C68361
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 10:59:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 01A58405F3
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 10:59:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fifJF4s3SeKK for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 10:59:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3360C405B3
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip="2a01:111:f403:c201::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::3;
 helo=as8pr04cu009.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=jXB//EOR; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=jXB//EOR
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3360C405B3
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 10:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aeUb33WNbHfQq/836ssWydbg3xPZSk5q3zqmk33xRWw=;
 b=jXB//EOR/IUdeeX8hYqWDnktWaFpJwQnJrYGxHl6EAB7NS2Bo7DlqbgG2J0IVeKoqIy6S1t3gT6suy29Zi74pFtME0nmS2yCYym6a5IBrmJKXFzuzKaY4CxN/bdXZcUatU/SS9pMrLKjoWXr8btC/vvbVTyU4brWyxv6dsVn1oQ=
Received: from AS4P190CA0003.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:5de::8)
 by AMCPR08MB999865.eurprd08.prod.outlook.com (2603:10a6:20b:785::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 10:58:51 +0000
Received: from AM2PEPF00070CF4.eurprd02.prod.outlook.com
 (2603:10a6:20b:5de:cafe::40) by AS4P190CA0003.outlook.office365.com
 (2603:10a6:20b:5de::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.12 via Frontend Transport; Mon, 9
 Nov 2026 10:58:51 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM2PEPF00070CF4.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Mon, 9 Nov 2026 10:58:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aeUb33WNbHfQq/836ssWydbg3xPZSk5q3zqmk33xRWw=;
 b=jXB//EOR/IUdeeX8hYqWDnktWaFpJwQnJrYGxHl6EAB7NS2Bo7DlqbgG2J0IVeKoqIy6S1t3gT6suy29Zi74pFtME0nmS2yCYym6a5IBrmJKXFzuzKaY4CxN/bdXZcUatU/SS9pMrLKjoWXr8btC/vvbVTyU4brWyxv6dsVn1oQ=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by MIWPR08MB182811.eurprd08.prod.outlook.com
 (2603:10a6:290:ed::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 10:58:17 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%6]) with mapi id 15.21.0592.009; Mon, 9 Nov 2026
 10:58:17 +0000
Message-ID: <cd59a085-803d-46c1-b05c-ba1fe003a571@arm.com>
Date: Mon, 9 Nov 2026 11:58:16 +0100
User-Agent: Mozilla Thunderbird
From: Jerome Forissier <jerome.forissier@arm.com>
Subject: Please pull net-20261109
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, nd@arm.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PAZP264CA0006.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:21::11) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|MIWPR08MB182811:EE_|AM2PEPF00070CF4:EE_|AMCPR08MB999865:EE_
X-MS-Office365-Filtering-Correlation-Id: fa638543-470d-49ad-fbbd-08df3e50700f
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|18002099003|10067099003|3023799007|11063799006|261028144727099003|261026121527099003|261102123227099003|261022105027099003|261021121427099003|261021123027099003|56012099006|261026140227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info-Original: 3KLQRYp23QzpJeZUE9vUqE4+J0MZdehKYEO7zzKpwQ0ZqBSgl6tkzLN13U5m/9OthC0jaloUQIqP846n/dhnYTx6s/9bYAMTNntTcAqqnp3GGukhcjG6PChQrCxv1pelhFo+lKNCKh0t59QM6CFEsULhUucxWd70kG4cvBDzFCO5QeCI+9urdCrWchej+kRxct09IO+eanyjYYr6njSg0tgvTD8G5JKwWlPRYD03nArLwhKDPKfQRdnCLa3oGLWf7Uok/NMgOr9sTfjwGCjVf1AIIl9EsZz1pRPkqIa6P59L9TAYiA/2tMhb+rBtbRURhbFRaBA08cLCwnSfxZwDiV1n3EXMLOD5qyGEIew7k77MLiUYy8jpyakHvgYFfuLfxbDIfIy2BXZUStgs9BINqHz05BZjMFXcwIcJrmHxb8Lk4J19nuHlhe1zOrUQvYEE1lOTpcbnpLeoaxwb5bDjc1drn8+4Y97qjkNs2PwaPGHImKl9aGDKhxyr4GMUzFsTz9OWC/9eoYqKOTB0aBbvO7YtiywY1Kqo12/HYqOz1IHPfMQnWZOUK1Yt92pCVCcSi41dpBoFpS55C2m6uDBfy5Upn6Akinf84C73Gar4Jlih//keF3DDdI519IbDvy/P
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(18002099003)(10067099003)(3023799007)(11063799006)(261028144727099003)(261026121527099003)(261102123227099003)(261022105027099003)(261021121427099003)(261021123027099003)(56012099006)(261026140227099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: VJyJ8YuLW5lpWnwu+nwRQZ6KmR+hXbi1TBSWnKcJ0/k58JmTMFE4g9IimZoZqNRYVuX3Ki2uJYEN2t0PaIX5YvUzipLpsN8yl2fyHwgrmrC//EVbOOOmEzX6VfE4oeYrX2t0EWC+TOdIzHkTdzl2fBIW847arH8W5T7GPCpDvTsERRzxTP5SZ1I0qOPMWT5SfM8/Lur0RG3K6lNGUH0y421QEKDiDw6zV1zO58sJr+eNTncGGaenDSzALzLCCGKAsrbIypX5tIwFX2thshTQ40t8UDmDd7SWz5fnlQHWAjrPbPpJOD9bo9/4x2cS6iOf6VA6lSZPsTLuHFG8gpCPTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MIWPR08MB182811
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM2PEPF00070CF4.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 3a147329-e24e-4fe7-d746-08df3e505be3
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|376014|14060799003|1800799024|35042699022|18002099003|10067099003|3023799007|13003099007|11063799006|261028144727099003|261026121527099003|261102123227099003|261022105027099003|261021123027099003|261021121427099003|56012099006|261026140227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: J+a/lE9jTfda0HVZYkAT82CuKWItOWDw6lzD5zueAWyZ6RpQgMqQsoy0stUlyNuRk0atMK0mKYkjrXS/qZyjWX4oDNJI8Wm1eT+wFcMMX6k+YS5RIbB4eI9o3vN0k2EyKzmVX9hyOA6LUsNi32cXagBCHktiPS2CEO4Ex7mxWDlvojI9wC8MtR1fjtnE2wMfQ7dsvI2sdc532g85JNLPqG7RX62NhYscgkK0b9AZ+HC6Ii/UU+BF02Px0aaInjcgmfqYiO5zMNkkj68jqcZm3ESGlBOO2IViUtQszmTJcXj7aMaMjWLPYBe8RD249gN0OeQbiSkD0qJoeysAmdBWaZs2BosGwuLgk3RkP+2+r2YLB3U55XWkQZPyzacag3e+r81MeOBXOvhbaNeh3/T1c5/I4cJLa2FGY41CJBqrZpfxijGN51wKrNTOL0UdY+b5KHpWgUcSDkJcw9nQmiogiiroFjj4bfeb56LCSW5tACQGVR8AF5SjRuM8H0SmdzSacPO0Ipy0zcgoONuCLJMew/APGFV3mS9W4FX6ktH5b1awz9tyJQBamH1KSIDIlVtXkYkfSkmK3FlbhW2AhhdKaOYBsl0CENohC3EosDsWGAQnTS90jiusM4aUBA43N7NUOO0gwRIejyN2h/t96mD+QZqw78h0SSC9epxwVNsfcx0=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(376014)(14060799003)(1800799024)(35042699022)(18002099003)(10067099003)(3023799007)(13003099007)(11063799006)(261028144727099003)(261026121527099003)(261102123227099003)(261022105027099003)(261021123027099003)(261021121427099003)(56012099006)(261026140227099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rYov+ox6YHEPkOyogCn7dmZeHsdss//M596NXb39wm94nfknwWha4naWYAjQsabWx+FnxVvoGHpjmk6yViNhj0mnkuiQQSu1UH5uX8YJp+DNDcTmrnFYtSZagPJ0tBe24xkcUP8CINQ/OuXLsONmxxZ0HL7lA5eIzYcM0oFF4JbwUt1zc43Toxz8JHF1YMVsBW6HhFBfqFyzN6dV2yJYYUifQgVddmusuR1sr1pzOL4VWIDbc5GbVIX+TNxzMMejZG9IPvUcIrt3+O9YM2pCqR47aFYPtNcckbPYCUohiFQT2bCNLlkbX4wVBmHP2WcYMXU/yhwjV0SErms0X8GIyuYWFQHMJDAYjcWuGqj3MrYYh7+Ougs61HBq1jaP7E/mhaF6fUklmz17c0jARBr6wy4vIg/kluDcBZCONh/mB+XTgDegCqaXA+jpMSfj2rqv
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 10:58:50.7792 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa638543-470d-49ad-fbbd-08df3e50700f
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AM2PEPF00070CF4.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMCPR08MB999865
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-22.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tom,

The following changes since commit 709a97a05df66e394f40d249105d0baade46f107:

  Merge tag 'efi-2027-01-rc2' of https://git.u-boot-project.org/u-boot/custodians/u-boot-efi (2026-11-05 07:58:42 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-net tags/net-20261109

for you to fetch changes up to e91aea7feee408800b4d8b8a291b5eb3f6b2fe6a:

  net: designware: Claim the reset GPIO in probe and free it on failure (2026-11-09 08:54:26 +0100)

----------------------------------------------------------------
Pull request net-20261109.

net:
- net: fm: fix the FMan firmware load offset
- net: ftgmac100: Add RGMII delay support (6 patches)
- net: preserve the driver error in eth_init()
- net: phy: SMSC: add Microchip LAN8841 support
- net: designware: Don't cache the MAC priv in the MDIO bus device
- net: designware: Release the clocks if the PHY supply fails
- boot: pxe: support booting PE/COFF EFI applications
- net: constify enetaddr in eth_env_set_enetaddr_by_index()
- net: designware: Claim the reset GPIO in probe and free it on failure

net-legacy:
- net: fastboot_tcp: act on a command that succeeded, not on one that
  failed
net-lwip:
- net: lwip: restore TFTP client and command parity (16 patches)

other:
- x86: Handle unordered runtime relocations

----------------------------------------------------------------
Alexander Stein (1):
      net: constify enetaddr in eth_env_set_enetaddr_by_index()

Aswin Murugan (1):
      boot: pxe: support booting PE/COFF EFI applications

Igor Opaniuk (1):
      net: fastboot_tcp: act on a command that succeeded, not on one that failed

Jacky Chou (6):
      net: ftgmac100: Add RGMII delay support for AST2600
      net: ftgmac100: Add RGMII delay support for AST2700
      arm: dts: ast2600: add aspeed,scu property for MAC
      arm: dts: ast2600-evb: Configure RGMII delay for MAC
      arm: dts: ast2700: add aspeed,scu property for MAC
      arm: dts: ast2700-evb: Set TI DP83867 internal delay for mac1 PHY

James Hilliard (16):
      net: lwip: tftp: fix write-request transfers
      net: lwip: tftp: fix transfer retransmissions
      net: lwip: tftp: honor transport variables
      net: lwip: tftp: add tftpput support
      net: tftp: make automatic updates stack-independent
      dfu: enable TFTP transport with lwIP
      net: lwip: preserve the net_loop download return contract
      net: lwip: tftp: support RFC 7440 receive windows
      net: keep internal TFTP and DHCP downloads from automatically booting
      net: lwip: honor autostart after TFTP download commands
      cmd: bootvx: use stack-independent TFTP downloads
      net: lwip: preserve interface state across network retries
      net: lwip: use the selected interface for TFTP addressing
      net: lwip: retry TFTP transfers using the network failure policy
      net: lwip: keep DHCP and BOOTP autoload retries with their caller
      net: lwip: retry TFTP after matching ICMP port-unreachable errors

Jerome Forissier (1):
      x86: Handle unordered runtime relocations

Michael Walle (1):
      net: fm: fix the FMan firmware load offset

Robert Marko (1):
      net: phy: SMSC: add Microchip LAN8841 support

Terry Zhou (Synaptics) (1):
      net: preserve the driver error in eth_init()

Yuho Choi (3):
      net: designware: Don't cache the MAC priv in the MDIO bus device
      net: designware: Release the clocks if the PHY supply fails
      net: designware: Claim the reset GPIO in probe and free it on failure

 arch/arm/dts/ast2600-evb.dts                      |   33 +-
 arch/arm/dts/ast2600.dtsi                         |    4 +
 arch/arm/dts/ast2700-evb.dts                      |    4 +
 arch/arm/dts/ast2700.dtsi                         |    3 +
 arch/sandbox/include/asm/eth.h                    |    6 +
 arch/x86/lib/relocate.c                           |   24 +-
 boot/bootmeth_efi.c                               |    3 +-
 boot/bootmeth_pxe.c                               |    3 +-
 boot/pxe_utils.c                                  |   20 +-
 cmd/Kconfig                                       |   40 +-
 cmd/elf.c                                         |   29 +-
 cmd/lwip/Makefile                                 |    1 +
 cmd/lwip/tftp.c                                   |    2 +-
 cmd/lwip/tftpput.c                                |    8 +
 cmd/pxe.c                                         |    2 +-
 common/Kconfig                                    |    6 +-
 common/update.c                                   |   55 +-
 doc/usage/cmd/tftpsrv.rst                         |   13 +-
 drivers/dfu/Kconfig                               |    5 +-
 drivers/net/Kconfig                               |    1 +
 drivers/net/designware.c                          |   80 +-
 drivers/net/designware.h                          |    1 +
 drivers/net/fm/fm.c                               |    4 +-
 drivers/net/ftgmac100.c                           |  239 +++-
 drivers/net/ftgmac100.h                           |   33 +
 drivers/net/phy/smsc.c                            |  182 +++
 drivers/net/sandbox.c                             |    6 +
 include/net-common.h                              |   43 +-
 include/net-legacy.h                              |    2 +-
 include/net-lwip.h                                |    2 +
 include/net/tftp.h                                |    3 -
 lib/lwip/lwip/src/apps/tftp/tftp.c                |  726 +++++++++---
 lib/lwip/lwip/src/core/ipv4/icmp.c                |   16 +-
 lib/lwip/lwip/src/include/lwip/apps/tftp_client.h |    4 +
 lib/lwip/lwip/src/include/lwip/apps/tftp_common.h |   20 +-
 lib/lwip/lwip/src/include/lwip/apps/tftp_opts.h   |    7 -
 lib/lwip/u-boot/arch/cc.h                         |    2 +-
 net/Kconfig                                       |   19 +-
 net/dsa-uclass.c                                  |    3 +-
 net/eth-uclass.c                                  |    4 +-
 net/eth_common.c                                  |    2 +-
 net/fastboot_tcp.c                                |    2 +-
 net/lwip/Makefile                                 |    2 +-
 net/lwip/dhcp.c                                   |   52 +-
 net/lwip/icmp_unreach.c                           |   44 +-
 net/lwip/net-lwip.c                               |  104 +-
 net/lwip/tftp.c                                   |  682 ++++++++---
 net/net-common.c                                  |   66 +-
 net/tftp.c                                        |   55 +-
 test/dm/Makefile                                  |    7 +
 test/dm/lwip.c                                    |  115 ++
 test/dm/lwip_bootp.c                              |   24 +
 test/dm/lwip_dhcp.c                               |   98 +-
 test/dm/lwip_dhcp_policy.c                        |   19 +
 test/dm/lwip_net_loop.c                           |  144 +++
 test/dm/lwip_tftp.c                               | 1021 ++++++++++++++++
 test/dm/tftp.c                                    | 1282 +++++++++++++++++++++
 test/py/tests/test_ut.py                          |    6 +
 58 files changed, 4756 insertions(+), 627 deletions(-)
 create mode 100644 cmd/lwip/tftpput.c
 create mode 100644 test/dm/lwip_net_loop.c
 create mode 100644 test/dm/lwip_tftp.c
 create mode 100644 test/dm/tftp.c

CI link: https://git.u-boot-project.org/u-boot/custodians/u-boot-net/-/pipelines/1930

Thanks,
-- 
Jerome

