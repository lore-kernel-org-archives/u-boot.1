Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6303606A31A
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 05:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=zQydgG7P;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=LVIduXqG
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 75E87606A6;
	Tue, 27 Oct 2026 05:18:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3KBW8c5N6Dm6; Tue, 27 Oct 2026 05:18:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A09EB6065A
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793078289;
	b=kBvm0fMxv6+/TmDKcMxC92u8AxFfAWxt5PgPepuWjRbTt6vDuvc+QbzLq0o2I6Xha976
	 436HywBFbSNWrTXE4dlzRsvPr3HpqyBOLEILY4meUB7twkqgUN4uebU0h9ID7bWvhhbsk
	 PD8O+0XMhLP4G8hV1CR8eL4FI648at7xEMIagJfgZFyIXnioHSeupdIP/AiHxf2KiEvj2
	 2DEYQmQeAzVA64rrbMZmISrIdQf5EGSW/oXtHJVStF6agKXD37szkzuFsvqFUwTjTZscr
	 IXl5hNpHHcpZ0Id3nRX8Xi5QCTtlrfoQ0yvzcgccXxiRq/5xpzp6XSS2cAB80jLA1EQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793078289;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:msip_labels:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ld-processed:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=tYV5iEW1IReEHzWqLn3mUY0DgWx5J8dJSkidIiWfRXo=;
	b=ZdkFlCldHNKC/JFykKfLoCM5YlTphnt6nQ7LZ3GkHmOf1WFsMFmepiJfptM/x7UBn/3I
	 9+PgICEBT4vnVeKhRi+b+ZMaz9iFT9hegSB1ynP1GlcxX6FnFlx0gHFnHwvJBieXAMkCv
	 it7Jd8bvYSshET040pBFu1CNHwhl2ugEQ1HnsJBLpTByZ8EKL9nZD7B9WqbZkv06+4W1A
	 UlOJ+sGaoZQFPuRRQ6GJbosPUzVMl8FbSxp7XXo1FGwbGxs2jEez/0btvtCyWHJM3KnQ2
	 NpORspmkb27FFp11LKqO6pvCEQ7Ely8E9Tt2OE/yZWW2BGx/SDiWlLdSlJzMNwEftZQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793078289;
	bh=tYV5iEW1IReEHzWqLn3mUY0DgWx5J8dJSkidIiWfRXo=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zQydgG7PmHDZZv8ugJrMkIUBerFZBMuoPeh6tSThnitBZ6+pf0aicxaA04n2REOpV
	 nxrtffDFlSyxa84KY7LtnpACktWVJroPEnreRe+VJpoZVQgEPh72r2PKPMUONzjEzM
	 i1//fiE7CbWZAZXnws1P/0+SVja4+5nCHgMgTUSh75n9U8j7T0tCz6p9yz7cW8ltP9
	 DgshURHwT2QZSsogAma8L4cxEMp46CzisnXTVBGgxD86G4MlXsJgwbRGWWZFis+/Nd
	 VVxCDjryBt3MGV2S5+JAbNmbzraQcE5NpKMYcyDqp9mOSsJI4M6DHt6eQ9+rg80Gp0
	 SDYTzOMSJZ3SQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A09EB6065A;
	Tue, 27 Oct 2026 05:18:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7F34E4BC
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 05:18:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 70B9E40580
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 05:18:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id deE2takpk26S for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 05:18:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3018A4055F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c107::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793078287;
 b=CKLRgqFT5L4kQ4PXwibfve8DKxO2ONQcaaSw7S6A89Bs0Ox6S1vCfZ4WKKqMJxVZSe8m
 coOukMB8ARPXrP/fDKYS0nKF/woT5RiS1vJVcdsiNxvVDNqQNtWP/aJNn7DVm3gR37RgO
 cvE3L7A7e/iQCptzBbxmsVYLkI8m23QMqmqlVcw9jnuwDZDXlA1ojaXH/iCBRHtH9gxAk
 EO5R41yfhsm3ic69mn5ZxvlyzwN/a7/ZT0ymUkkR7uadwtMZ0v2USOeKMmRO9xZxX1TVl
 XfWvOJXaFqZuVPIP6fee0njiMkZa7JeWEd5i1KH1L5nyOZr7PMMBCloVYfwcDjeZlLA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793078287;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:CC:Subject:
 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
 msip_labels:x-ms-publictraffictype:x-ms-traffictypediagnostic:
 x-ms-office365-filtering-correlation-id:x-ld-processed:
 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
 x-microsoft-antispam:x-microsoft-antispam-message-info:
 x-forefront-antispam-report:
 x-ms-exchange-antispam-messagedata-chunkcount:
 x-ms-exchange-antispam-messagedata-0:Content-Type:
 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-originalarrivaltime:
 X-MS-Exchange-CrossTenant-fromentityheader:
 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
 X-MS-Exchange-CrossTenant-userprincipalname:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=tYV5iEW1IReEHzWqLn3mUY0DgWx5J8dJSkidIiWfRXo=;
 b=kai27NbZ3shygad2ru/MPdZAuOjmmj/40QT5egIBZvftXo5Q6gXcHjr0p/gqyc/tEPVw
 BxgHaJp0C0KZ4jaEwtckRnw+2/skBAO3Xrdq79L22mWV6Q8lxOD51Rr78bW+EbF0cAxWK
 xavFSI5lieQePaEw1vhXYsCwqIgg4MOLrEn2Ug8ONo1SngsfeOU23dvWUKWO6a1rAV5vB
 PX8lSDB9cOLynSY0CPbaLptR8wDSfKzKndnMhMSOUu2z2Aw9WNJE7lcuZAMV2JykFp1HE
 +2iwSIAwEHx/L0RCQZ+KNCtcbp1F01/lEYVv3MV5izUwldf2+mSOBheUfvgsRotXRYg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=LVIduXqG; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c107::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c107::1;
 helo=ph8pr06cu001.outbound.protection.outlook.com;
 envelope-from=suraj.hanumantkakade@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=LVIduXqG
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3018A4055F
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 05:18:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DEjhzvrAFln7DScCbWEMKHSsBg6lbwwoZD0TmjS/11uSBxxxEaFm0NSkuYA6wjTfoJjzZ/JXcsn/kp9w5fZKeYi0Jpb5ZBxnX3JWPtHNt0tu+2Rm8YcdfSf75fmURfo2M3HEU2h/+B/+JARkluSp4Zjxl5uRu7ZdlfkRz6RMUX09cbtx8u+hn1Q39cxLuAKtloqmZiqrbXrfu1FEuCTBwzx52ibk0TXWV8ByN8Ajz1b2Vf9CTIQxr7OWKPaGEJrkeduDGTrxb1GvTK2SJZjEMPM52MAuQlbwM/SxagCFhK1pTe64wvZph5CjNl4lhECjNjSNyCTofCykSrS/MobFbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tYV5iEW1IReEHzWqLn3mUY0DgWx5J8dJSkidIiWfRXo=;
 b=KzGaRA0pcNOKAi1jocngUboK6LuGqLjwESjSs8ThcNSW7dihfci4wSzc/jI1WEcb18kowW7px0dBpbew3355Yuf9VSxMOSQWe+A/QgbyqBg10vBBBCh/Nu0FKShseA32A3rNz2myUg7IbzAQERhdv+DlNHz/0M+TWQlTy/L0TB2zeE9Hu8NMR/Dj7oOGpva17usYLSL25PtysthkcfgLWYAz4fBHKG+uZJWD3Kva8sG2vWh91I3Nh74CpyYF4a+FxRO2CZzITowRYJehlp38+G5BEuI90s+P9YO2CGJQTLR09jWs4Elqc1FuEngF9Tg6GbLjqa42ek9OKUV9WtDL8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tYV5iEW1IReEHzWqLn3mUY0DgWx5J8dJSkidIiWfRXo=;
 b=LVIduXqGWr0DG4bormRDknmkaw8Tz2L+9kxrKCUwdjQ3vFn4wHpBr3s5L7AwP/jbUVWBZmKXQQ74VFcoaLdyl2W9dGX3BbAynhOtceASBZ6YTym9CBbDEmSl6r2p6j3Vr5U00NlATVqiPAf9ltmAChs5DXU4eHkLb2gA6c/mytY=
Received: from IA1PR12MB9529.namprd12.prod.outlook.com (2603:10b6:208:592::17)
 by DM4PR12MB7597.namprd12.prod.outlook.com (2603:10b6:8:10b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.21; Tue, 27 Oct
 2026 05:17:58 +0000
Received: from IA1PR12MB9529.namprd12.prod.outlook.com
 ([fe80::40f6:c7e:1854:4e03]) by IA1PR12MB9529.namprd12.prod.outlook.com
 ([fe80::40f6:c7e:1854:4e03%6]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 05:17:58 +0000
From: "Hanumant Kakade, Suraj" <Suraj.HanumantKakade@amd.com>
To: Tom Rini <trini@konsulko.com>
CC: "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>,
 "Simek, Michal" <michal.simek@amd.com>, "git (AMD-Xilinx)" <git@amd.com>,
 "Begari, Padmarao" <Padmarao.Begari@amd.com>, Simon Glass <sjg@chromium.org>, 
 Rasmus Villemoes <rv@rasmusvillemoes.dk>, Sumit Garg <sumit.garg@kernel.org>
Subject: RE: [PATCH v3 2/2] scripts: pass dtc cpp flags via a GCC response file
Thread-Topic: [PATCH v3 2/2] scripts: pass dtc cpp flags via a GCC response
 file
Thread-Index: AQHdXGCjR8ZmxmN270muJ808fAmuPbcIWdmAgAiOp9A=
Date: Tue, 27 Oct 2026 05:17:58 +0000
Message-ID: <IA1PR12MB952911E4FEC654FDA3B52AA089602@IA1PR12MB9529.namprd12.prod.outlook.com>
References: <20261015044923.206217-1-suraj.hanumantkakade@amd.com>
 <20261015044923.206217-3-suraj.hanumantkakade@amd.com>
 <20261021182343.GA3287961@bill-the-cat>
In-Reply-To: <20261021182343.GA3287961@bill-the-cat>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-27T05:04:21.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB9529:EE_|DM4PR12MB7597:EE_
x-ms-office365-filtering-correlation-id: f2c213cc-c575-46d4-14a3-08df33e9aa00
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|261009223027099003|261021121427099003|261022105027099003|10067099003|56012099006|261026121527099003|3023799007|18002099003|22082099003|4143699003|5023799004|38070700021|11063799006|261026140227099003;
x-microsoft-antispam-message-info: 4KCG9YHhY0mBvb8ls+UDOGqWKC4Nb6wStt25GQSFcuO5qJE0L3yb1T9h+CrdH09aFrTau5hh4p5Bu5Znsl3bnn88clwwi/VoyykHFve8lehO317z52WhBT/ORgwOHqm9jMwSXjJyoxIHS9uTQWHSrwQUdoY9zSSGtkO3uNELOCGKVeZn0sA+YOFTM7DUtbjvzKxsCY+GLMiuSKkIO+uqLR6n3HwYF6z9OrJHAB63x4cCoJqjQe7kK6+DZCwQRVRbSOdMlmAbKfuXUg5nDbM79LwRIUA7VTjz0l9UCSo5GeXf1ArOVma9qYDo2YqCwc3D7MueJzRlSEgh7fagFDlXT2MXdnD5aaOjLUMY4ksDppqDG5xlMFYTLZOU+qVE/o4kSHXUO95m2wOFE/M7NEF7aO/m9L8+1t19d++WIDPsnML66iX6tmYJaVfmjIN8Syw4/+1CilLQwHTNXJpw3H3WbWok7ctxNcYuin7D3oZNLLOQ7BStn86Wn7Ia9XG65VVrqO0wfKU1XaRw4Ba/Ba+GZzFT2ceFDwgIBjeBrQIrVwnZ4gYOO1He4ZZYMgUyXQnzUvMS2jrT9l+ldrTpB9KWfhurLe4TJAd3w9Bd30BtJALFcoYv5g6P2kERa+2+SaUVIDoYB/Lpap5pIW1waQC1fx9IBX3l1L4A/mhe4LCnXz6+wglSGbnU/ty7JPQWd9I35hNELd4SYFFnMbBoV9ey2X8XVkdICtrIAQoOCnTkd7k=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB9529.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(261009223027099003)(261021121427099003)(261022105027099003)(10067099003)(56012099006)(261026121527099003)(3023799007)(18002099003)(22082099003)(4143699003)(5023799004)(38070700021)(11063799006)(261026140227099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lx7U0OMd6Q0IPQRPI4E0a+UdU4GIvhNdSSmGmsMYgtGSJxqNYzsO609FxiZA?=
 =?us-ascii?Q?EvNmRXCFkq8zNOYz8va+b5LcfClfDU1wHM9CchQU4RjwQvLIIZxev78xIKwE?=
 =?us-ascii?Q?EY3T3mMVC+9+JxqvDzjg9SuvzyeLLqn/E1KUiWbg5+8PQH1L1tDRLuYoLsjr?=
 =?us-ascii?Q?g4txkjWX4bwWDvZhJiz+uL8NKk5LprRUvHEdssgb5T1uZORHOGArc7l2EPwA?=
 =?us-ascii?Q?K9yZ7+481ZKGcrSojpfDAm1jPpJ95LvZY3QyVQzsPb3BV0WhTVckfhYqCcVU?=
 =?us-ascii?Q?YtF8Zeg1Zo2scvm9g+p9n6oOThvhmegLT1a8qWgpmnO1R+ekZItaPdAMPcaR?=
 =?us-ascii?Q?myWUmQ00mUTkSrKvOxJyCGg83cP97/e3S+btlugVB69AalN2wl1zZJz+vpPc?=
 =?us-ascii?Q?3LlqqijEUU1IF8R+rBit9cIXG/ZE98jOniRTJrK4JIOEteYaqHQLQCjUOk0e?=
 =?us-ascii?Q?VMCg8w6vRJwNC/A01h17EMupaBRymncSpXRV5o2nbUCHBlV05KjOZw2SnRIk?=
 =?us-ascii?Q?1Pj+Jm3CbN3w0StPGWViOAWWnaXvc8Dw5Gu3PPv6ssXHkMuFzk2Yk1WdbbZB?=
 =?us-ascii?Q?ZKiodw8i9WBCNvuMAhtLiXCiXTDJlaXyJLTgu9toTl4R0NVrwBQtwzUhFfTG?=
 =?us-ascii?Q?dEMNML4XNBW+h/6RI22uHnDDgjcKrYPSJyclNwBGbmOvLtzRUGPAGlZv3Nnz?=
 =?us-ascii?Q?GsiJaQzJAzCQix3aM/rYbYwEHtsW9NiSb8gwqaqEh8mz00Gkekwa7kiR7pfm?=
 =?us-ascii?Q?CCSoVdKU2ExAEHDxG1QEUlkPNmL831JFqRT+uyLY17T6hmkMJEAWKQN2Nbj9?=
 =?us-ascii?Q?BFcDA52w9TcEH7M8tT0OYnIpxztKERnsX+L8L5ZZjJs0NevdeO+DZ0EGu5lr?=
 =?us-ascii?Q?X976TcWBE0zlNehlpd4nvSGrSz6aBfrdOH2uQxc72Vzt7WZ1/mPR0h8X6mTY?=
 =?us-ascii?Q?1lsu8APV6RPISIjjbJVNRsCMCEf9aK7cF6EAO4FeVXyj9WtBY7iYQQRf/HRg?=
 =?us-ascii?Q?AJGN9nLmc3k6bNiAPiE99zs6jW/2Ci0W0TrpYEZi0rAzKrVzNM8lW+PRfMn+?=
 =?us-ascii?Q?cqpamc6oCpE1Mki1lMcH5Fn4Q1qp0E29VddTZS2ywoLJOjHdB8UOw6pwjIOB?=
 =?us-ascii?Q?HX9Zb1R3ecvXWHef+FOdKANt+jjQMelU4BMdvJinGKBNcgzdcRql/AGp/0Ou?=
 =?us-ascii?Q?IYqSW8F4TSawIAsdNzYsZMHq5t+HXQpjuuCOZ1W666AYu3OtGEIvWnaRXnv0?=
 =?us-ascii?Q?XuQ3/XtwuLiMU253olDfq+uqcLi7oin02dc3QZ4RTgGb1p1ibIF5YtMuw/fM?=
 =?us-ascii?Q?5WuhpJHGQacgQMcI0n5cIANiCFdKfZZGxvfoFIlkUK5Zo2ZHr9OcxDFIrFjQ?=
 =?us-ascii?Q?yA4ny0VCjQev30ecG8xGVlO/lDBWUGEGYrNTyowOzTvwuPUAxuEDxrGRrqBj?=
 =?us-ascii?Q?K3VPWHEebck/e473SYmM4GD7OSUA4oK9Oif7iegXXH8dksc35NllX5N7ssqk?=
 =?us-ascii?Q?Pgf+IuBygPuC78mmzhgUMvwn2CK0J0lUT6FfkBroy3ZTWEfhuKOkYMRP6Hty?=
 =?us-ascii?Q?nwVL7MXxiNO79s0cfdjEi9+gKjp8OdWi4/8Hzb0EpBwTifJ7KvfvjjdGUZ/s?=
 =?us-ascii?Q?tL6PBMZ+o9xuQ/ZTLpdUsHzjs6J032Pm0EkbPht4fOto3ZWXTu1RgsXPlAHn?=
 =?us-ascii?Q?jmb0KKjmgGs4YYl1BRRFCsjWSzXq7y3qfEwuDi+3wrNkMxMA?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9529.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2c213cc-c575-46d4-14a3-08df33e9aa00
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2026 05:17:58.2155 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xcqRHjKoZgd1F1xYwKO33Kv97fja4yylycxw4LaSJ2IqC7scpA+1hYipH4Prf+Fs7Z41iq2C8K8vH4OVcjMZCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7597
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

AMD General

Hi Tom,

Regards,
Suraj Kakade
> -----Original Message-----
> From: Tom Rini <trini@konsulko.com>
> Sent: Wednesday, October 21, 2026 11:54 PM
> To: Hanumant Kakade, Suraj <Suraj.HanumantKakade@amd.com>
> Cc: u-boot@lists.u-boot-project.org; Simek, Michal
> <michal.simek@amd.com>; git (AMD-Xilinx) <git@amd.com>; Begari,
> Padmarao <Padmarao.Begari@amd.com>; Simon Glass
> <sjg@chromium.org>; Rasmus Villemoes <rv@rasmusvillemoes.dk>; Sumit
> Garg <sumit.garg@kernel.org>
> Subject: Re: [PATCH v3 2/2] scripts: pass dtc cpp flags via a GCC respons=
e file
>
> On Thu, Oct 15, 2026 at 10:19:08AM +0530, Suraj Kakade wrote:
>
> > cmd_dtc inlines dtc_cpp_flags (including every upstream dtsi -I
> > path) in the HOSTCC command. With a long $(srctree) that command is
> > too large for /bin/sh -c and Make fails with "Argument list too long"
> > while building a .dtb.
> >
> > Write the flags to a per-target .dtc.flags.tmp file and pass @file to
> > HOSTCC/CPP for dtb and dtbo generation and the DEVICE_TREE_DEBUG diff,
> > so the shell command stays short. The flags are still compared and
> > saved with the command, so a change to them rebuilds the output, and
> > the file is only written when a rebuild is needed.
> > dts/upstream/Makefile uses short relative include paths and is left
> > unchanged.
> >
> > GNU Make 4.0 is now the enforced minimum, so using $(file ...) is safe.
> >
> > Fixes: 3a4e5944c96c ("Makefile: Allow upstream DT subtree to provide
> > DT includes")
> > Signed-off-by: Suraj Kakade <suraj.hanumantkakade@amd.com>
>
> This seem similar to, but not exactly, what's in the linux kernel current=
ly. Is
> this based on a change there, and if so please update the commit message
> similar to part 1. Thanks.

No, this is not based on a Linux change. I compared the Kbuild.include and =
dtc rule changes with current Linux and found nothing equivalent.

The Kbuild.include lines this patch touches (cmd-check, cmd_and_savecmd, cm=
d_and_fixdep) are U-Boot's older copies of the Linux kbuild macros, so the =
hunk looks similar to Linux, but the cmd_extra handling that this patch add=
s does not exist there. Linux's dtc rule also passes a single -I (scripts/d=
tc/include-prefixes) inline and does not use a response file, so it does no=
t hit the limit.

Thanks,
Suraj
