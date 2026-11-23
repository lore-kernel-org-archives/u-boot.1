Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C723F606A31A
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 13:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=DmwFJJ+O;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=lFEx+f9E;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=lFEx+f9E
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9B09B60673;
	Mon, 23 Nov 2026 13:23:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XCjQkCHPbGlW; Mon, 23 Nov 2026 13:23:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org BB6B16073D
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795440226;
	b=oCAYw+WEMgtFKU4LXsvnxlSrNeelDjCguuN/ehwY0zKTWisyk9Fgzr6MN6939VZx2LzU
	 pREoJ6n3W4xXe5KMOIvY3FGmqEmaWm62oQSDSOjjyDSQgFYmnns15Fo/uWeZr/cf/66na
	 b3/7vusJzqAgZdzS8PvvYJ0DLycqBefU0layHDB3Nm0kl8i+N5Ik0x2yr62Xnp7IoQmwF
	 JdPhwSY8k9miYMpII3o9BtB4dbb41xpFwuFHkOg0tl3NGO7h3EkqQOtXi7mh23BsqWOpO
	 j+uSmdKNJDMAqRYgmgCC6yWJfrURiLGEmI8ogDEf16UMlKKoS8pkEJ7ALX0my+FNHmg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795440226;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:DKIM-Signature:Authentication-Results-Original:
	 Received:Received:Message-ID:Date:User-Agent:From:Subject:To:Cc:
	 References:Content-Language:In-Reply-To:Content-Type:
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
	bh=jvMuika3EX/NmouPLQGRIp7vCXtfmzoL0fPeaZkVycY=;
	b=GwBJEpBqxjvws8fOCmoniqcxs65nUnMPi67sr2zzb7judI61udbKYrWn/lyfUc9lZIb5
	 uHhtjnNvb/3oDtgIUcdlSr4h1qsDl4yyprwl6VP9Xb1EpwNPUA+4VEqQWZTno3c0eASaM
	 NypzTnMqBizSa14gviHbzZy/fbOEDssZ34H7m/idkIuPzbiVH7mifeCmAz1ChodjAp6ES
	 dtMpwcVmwf8ksr1hKRb3sbt4E8OuzXxAtKnwQYLrXZohjNkqXCuAhmZ/CAfrqT8ZsS3QE
	 z3HIo3F5y5zIHJ5J6hvPR0nUO7/wT/KlABTstiH9r0/l+qNuaLRpGV29Xx1FLzUIXHQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795440226;
	bh=jvMuika3EX/NmouPLQGRIp7vCXtfmzoL0fPeaZkVycY=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DmwFJJ+O1VOFO/KT7HuORudQLHVKxoaAX+1HXvhhe5JsRwr9WEM9ruinDXJfa9HO0
	 X8JySRCSHMgj95zJDuqJrJoDp9cN2N9iWvTMhVCZN9p44ntsn7QglDc8Y8sH/7h4Vy
	 jmorwwiEoFYodfPQjEWfeflpfBU0ILMvQwK1298vDqzuPEtqZ2nYd9gaa3hvGSFLtW
	 1ng1RN8RvPhM9Zi2id1br1edJaL5Uw8heqRjpN5lZIjrNk0yP93b8OH2v+DBq58sE6
	 ekhE1Vt8E4oRTaRHhYl/HFgpPJDjNF4T7aTVsIFfvNwUi0bpbqqyAnmf9rAWlKKlpQ
	 R2TTlGDAzVSIA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BB6B16073D;
	Mon, 23 Nov 2026 13:23:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0F6A01AB
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 13:23:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0CFB880D52
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 13:23:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AJeDar2WMQmx for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 13:23:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5FA4780D48
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip="2a01:111:f403:c20a::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::7;
 helo=pa4pr04cu001.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=lFEx+f9E; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=lFEx+f9E
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5FA4780D48
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 13:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jvMuika3EX/NmouPLQGRIp7vCXtfmzoL0fPeaZkVycY=;
 b=lFEx+f9Eqm9ZmtlPi4nUxUkCvJ0WiIGmkfxRslfpXGfelH+OSN7fhIJL419xUl2HLdzkRQFEcvT+rIqzNfzdcR4waZh5fRm4/FUoKXbKFDBiKWUW34xqnSWgTN135Xwep7mLxIM2POjfClekYDG68s3RJ6/yqEJY5lqng1SVWn4=
Received: from DU7P195CA0001.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:54d::15)
 by GVXPR08MB11096.eurprd08.prod.outlook.com (2603:10a6:150:1ff::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 13:23:28 +0000
Received: from DU2PEPF00028CFC.eurprd03.prod.outlook.com
 (2603:10a6:10:54d:cafe::2) by DU7P195CA0001.outlook.office365.com
 (2603:10a6:10:54d::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.14 via Frontend Transport; Mon,
 23 Nov 2026 13:23:28 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF00028CFC.mail.protection.outlook.com (10.167.242.180) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.5
 via Frontend Transport; Mon, 23 Nov 2026 13:23:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jvMuika3EX/NmouPLQGRIp7vCXtfmzoL0fPeaZkVycY=;
 b=lFEx+f9Eqm9ZmtlPi4nUxUkCvJ0WiIGmkfxRslfpXGfelH+OSN7fhIJL419xUl2HLdzkRQFEcvT+rIqzNfzdcR4waZh5fRm4/FUoKXbKFDBiKWUW34xqnSWgTN135Xwep7mLxIM2POjfClekYDG68s3RJ6/yqEJY5lqng1SVWn4=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by DBBPR08MB10461.eurprd08.prod.outlook.com
 (2603:10a6:10:535::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 13:22:55 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%6]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 13:22:55 +0000
Message-ID: <673b71a2-2dbc-4386-92c2-91a84ec4d552@arm.com>
Date: Mon, 23 Nov 2026 14:22:54 +0100
User-Agent: Mozilla Thunderbird
From: Jerome Forissier <jerome.forissier@arm.com>
Subject: Re: [PATCH] net: ksz9477: Constify driver ops
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, nd@arm.com
References: <20261116173936.3488088-1-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
In-Reply-To: <20261116173936.3488088-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0128.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::7) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|DBBPR08MB10461:EE_|DU2PEPF00028CFC:EE_|GVXPR08MB11096:EE_
X-MS-Office365-Filtering-Correlation-Id: cb9efdaa-5e18-4733-4643-08df4964f606
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|261009223027099003|22082099003|18002099003|261021123027099003|261021121427099003|261022105027099003|261026140227099003|261028144727099003|56012099006|10067099003|261102123227099003|11063799006;
X-Microsoft-Antispam-Message-Info-Original: c9fakVdzUQODo2Cn9QbA3+R98vH8NbywlNhSvukSKlq6VrmGap/CgGa2aLJ13etIPvYrq3UJQWH84lWLGUpuOKCeCs7AxE85/GOXEh7p0AouVLfSbCj876UNlQE9xvYJrZXGbcKrZLEkzE4PKSTU1quNnxNvZWvTgEXQDvM2MWICocCllsVXqKPfVCJqqmEhBwrw+ikZEkeX0hN2Bsn+d5BJqDvFOJpqYzqgJjOFPDi2J4N9QOGrNrbk7V837iTyazXPVuKo5y95SoujVx0TBexx+2bxPtmncXZ9jgPodbeDe2pKYNk/D0ZyPgFHBI25EpQ+KhYouWjDNcZFSBP+RCp22PKn6kmLpt+RB+qGtwPr2lKHM3HJqgzEwEYhWwAkdQQ+PqpEXIEuDPk1Xj4kShqHhXWVQsi1PEe3p0yaMieyFgUx65kgARQ6bfcdV85J78LmacHXg4j441Bnt5FlvcdglF8d8+3dBeY+w4YDR0Dt45ZuGtGups6QHsvdVuMd/n3L00JY/9EXhHUMglpUk1h+iET7ryNOiVpHBiwqrBo4H2uph15ou9FhSHkeq2t+j0xPnog7/S7M9meo81uBYubtRowFh3kafNv2cCPUHaU+RSJY6CIM8FwaoFAZv9Vs
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(261009223027099003)(22082099003)(18002099003)(261021123027099003)(261021121427099003)(261022105027099003)(261026140227099003)(261028144727099003)(56012099006)(10067099003)(261102123227099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: Zsw3mQvRWS2ND9MF/AaP1BSDAfVoIxY0fm3EO8pKsITWamXf805IfgUOMZqYAro4jj7jPD/5uiMUeYugZR7PbCPfkCbWxTfp/qz3QBHwqvm6x73PJ7nabxzBYcIX+EZHhSJj9Q7X6atMa3HAUP8Mg+PcqXnTwxTL9m4HWOMelALtjJGYXMjzCsz2P4qLKkzH3V7++l4TbD6QhXB5N8LZMwWM16RieLVzj0SeXxMtNZQ1aQj4M7upMzzULfTCEr9ow8NuwuElRX35bgaFLsYl7hv6M23unE66JvCMzf0WX2H7s+/IvuYUerOTvGUJwfSSxknBD/IJqfZN0NK1rrTNDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB10461
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU2PEPF00028CFC.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 67483282-273b-48fc-8b8f-08df4964e270
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|14060799003|23010399003|82310400026|36860700016|1800799024|35042699022|376014|22082099003|18002099003|261009223027099003|10067099003|11063799006|56012099006|261102123227099003|261028144727099003|261026140227099003|261022105027099003|261021123027099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: xYclHC5K9vdbJcVIPoN0biLZ4k/aDDiWdZpsPeguqWL1Io/CVHD9xTB6OWZPlByOI6HILf3apyfSf+XpTmL38KXpdmlZ7F6L1m2Jkmc43Hr5EMjKHXWj5KlK8AjDeMMEui2uAOb/yHUpXztWsCfLuyXSiEWQFfqhIlvc9eg4u0bBEePhsQIhdnPtTkO4gRvadrJaZlrQeU5y6nLB/ij2mZEl0UnoCMd+4WTty9HFznNmA44qP24/6r+ITXO5/0UuSPYRw4u9yicmjfSs5VEXt2f0McjXSXohzx2V88mNlYav0kWN+3yrdCiFj7szvtlFhRf/QM8m24dRYOUIb2zYiJKPI2Goubxgw/tq9SUx3kZJ75nkh4A++EldfXdGnaSVtLnhZIwxjwsgetcrT7HiSsfd2JTLeIotny1hLXCbCurrTHhkfbJZ52Xo/nRKpOuPkvG1U4AVS/VmUFNNNVza2yWv5rPuuRc5bq5gVtlNwytEQPOWuxqK58z30ir9DMZaPsJO8nXry2JnoucKie1WrEI4/I4Sp4zQIF6DEFRU2CJBgM99oxYdzVgSD2Ur+v9T0I8U7cZQhGsVPkLuu1/fwoMqxLuGSYqMagArE3+DvVbfHwJTJKDNtOCxGYzpa5mBx8ksW83o9YCJ6O1Er4u4+yz85WEJVqyJUh0ZiMmRdC0=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(14060799003)(23010399003)(82310400026)(36860700016)(1800799024)(35042699022)(376014)(22082099003)(18002099003)(261009223027099003)(10067099003)(11063799006)(56012099006)(261102123227099003)(261028144727099003)(261026140227099003)(261022105027099003)(261021123027099003)(261021121427099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RDL90ac1yClTu+Cvokh1TDM4FJLRXNgqUaNbTgFgwiBEvTQIwMqNtk0oZpurGSXA+J9dcujsaiuhA5ptl9TFosO4bzl5Or3BJsDs6qQi9Htc4OtX2djOIWUXADJic5IWE11Oyj/AbSJc2t6/JPvJzgYrWF6cHSclzpTI6aQFEFDrwxYxiY3r/iHW2Zp8ke4EPiujqQa3tqVhuOPDUwFVNoJRcPpQIHJYC89phjqT3v8zPxge9gB2ROiv6lsyJP8RdDGb/dJNlqjAJOiw31un1DwjK55lx5NP1v1XO9g45C07lV5Uq5hgI5jsVsWAX2mbPNKLrmjV3tk3f85vu6ggcFwxdUfHD8d+4TAW0o0yOZ1r2RGrh6KVObgWjWKy5L6cQT10opJ5HhYMt+NaCBzU3QocBo9u1EQp7ROxt0n2jWsf5tSDvqIN+iNZUb6gQ+tU
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 13:23:28.2002 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb9efdaa-5e18-4733-4643-08df4964f606
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028CFC.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB11096
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> Set the ops structure as static const. The structure is not accessible
> from outside of this driver and is not going to be modified at runtime.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Jerome Forissier <jerome.forissier@arm.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.u-boot-project.org
> ---
>  drivers/net/ksz9477.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)

Applied to u-boot-net branch for-next [1], thanks!

[1] https://git.u-boot-project.org/u-boot/custodians/u-boot-net/-/commits/for-next

[1/1] net: ksz9477: Constify driver ops
      commit: 30a43090341dcc6b42bb9c08d4e3d51f3721992a

Best regards,
-- 
Jerome Forissier <jerome.forissier@arm.com>
