Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FF66CA5FA1
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 08:37:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D5C52405BA;
	Tue, 29 Sep 2026 08:37:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PxYaNQhYEAp5; Tue, 29 Sep 2026 08:37:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org D962E405A7
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790671039;
	b=C2hn/+K8qfH3xzura/TSnEbiaxaOyRp7DGHiYXoHWRie3EXr1MnxuS0BZZakvQ9fTk2I
	 X1HDvsPovkczpsqhC2/xLuu3QSF9TTA8kB5iJKkJa6tTQuBG0YbLVguiLIlOlFRvRfg92
	 c7iLVxaizekNAH+hgtpCqcFD0AlfdxeQQVq1+TJsvbrHT1gh9fpjx7wdfUEyIBOGxMtjq
	 4OG6HasxKo7dhxDdQkeuW2hBUgnqDbXjzptItCp24GSYbiBrcpFtCIn8Va4y8XB3ngzDz
	 3ox3v9HO+qPKg4ND3MtRLmVZPypgZx98cMDemuyLkCq7IoQRNHbIWxItZ7HMknOMvzQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790671039;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:X-UUID:
	 DKIM-Signature:X-CID-CACHE:X-CID-P-RULE:X-CID-O-INFO:X-CID-META:
	 X-CID-BVR:X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:Received:Received:
	 Received:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ld-processed:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Transfer-Encoding:
	 MIME-Version:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:Content-Type:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=hsSjSubkJshH0DvLuNjUtict9uueGi/25FtjK8Y/rzo=;
	b=Mj1N/jHsL/KfV6u3iGsStBXX0HZYw9qULO3OauwkDLtXh2L5GhA6htNvhk9hyeaLe3fv
	 UfcpMadmO2bHXxXQKRG5kZV5dxvLR8gQt6BSRqMmqeRO/+CF9Au3UmYWHpKqOv7O2I0r6
	 3TqMVIYYtpqxLRQOZdFzeOr4pRilrtBi5+LUSlpdcCG2ASp2a8HTnX36YulFGKu+jkB9L
	 Ew3fYmL2nSZWK9wXCL5TDSMTiEeUu1hGzs+/ZF8xURSstRTa3qixS/4GSRvgN2SwSdDiO
	 4mD8N0QpcMuIEfwmRzSyZksXfg7ieS5Tw3MH/Z/C/eeyc0AKPHV12TBEnh5mztYz7CA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790671039;
	bh=hsSjSubkJshH0DvLuNjUtict9uueGi/25FtjK8Y/rzo=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=aq894wZmKQaS2sq2EF8pPx8TLS+maXv3pbYgqZBtolEIKHKU5ozS4bDQpDx/C2SV1
	 K+45cNQUZxXj5l4fNyr2M+WGsaYMpV5W6OukwfhBLM1mzQg6pG/aHT/OJx2on80OMM
	 gpDYOv7N1nhwCfoV+tdlVsehse0BQwoFr56JEfAX+TCsnO8y+iwxXyIQP6r64goHPb
	 xkzLe58zS/I+CdzMSn1BXK5o/n0YOaVXkeFAk+xiaAsYIXWHPK3gOlhb+GJYiAxZPP
	 L4yPNQjJePCpnza0ulZ8jTd8RT0N1NcJyPEMTf6OgOYIOW9VA8lBMHHqpeVqQcTMIl
	 PQZofHBV+QT8g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D962E405A7;
	Tue, 29 Sep 2026 08:37:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 62CD8335
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 08:37:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 484F18085A
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 08:37:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RrvCejx6tQcg for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 08:37:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 8EF78807F7
Authentication-Results: smtp1.osuosl.org;
 arc=fail smtp.remote-ip=60.244.123.138
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790671036;
 b=AKWy4IBwqYCtUH+/VZUGsCQT3FDmbJbQi5A0/+6nd3/dfPviFcrwwcli9iTi99pnfqVI
 JHfMxAMGynHFVM6CB6JjFlTITfEBGghim5cko6XQbQ3Mj70Ooj3BjfApvw/gqUOncNRLU
 BFxqm8G5Of3lBpYwO23Q+cyNPDbMJ2D04ZlL5JJghNZZvqWxuks21jKlLhBksMIFdauX3
 hjjOn6HdmOzsx4uoCjJ4SGv5hvrGKaBx53lDkA20ziDmUC3EW2o+iCBZEyEioXyu+R3hK
 Wgfjdn9AsMf8w6Z6jePajlQ32GrjWQ12Rlb7oq+nurzpKE5Rfk8l2P7RBsbB1LUIWcw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790671036;
 h=Received-SPF:X-UUID:DKIM-Signature:X-CID-CACHE:X-CID-P-RULE:
 X-CID-O-INFO:X-CID-META:X-CID-BVR:X-CID-BAS:X-CID-FACTOR:X-CID-RHF:
 X-UUID:Received:Received:Received:DKIM-Signature:Received:Received:
 From:To:CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:
 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
 x-ms-publictraffictype:x-ms-traffictypediagnostic:
 x-ms-office365-filtering-correlation-id:x-ld-processed:
 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
 x-microsoft-antispam:x-microsoft-antispam-message-info:
 x-forefront-antispam-report:
 x-ms-exchange-antispam-messagedata-chunkcount:
 x-ms-exchange-antispam-messagedata-0:Content-Transfer-Encoding:
 MIME-Version:X-Exchange-RoutingPolicyChecked:
 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-originalarrivaltime:
 X-MS-Exchange-CrossTenant-fromentityheader:
 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
 X-MS-Exchange-CrossTenant-userprincipalname:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:Content-Type;
 bh=hsSjSubkJshH0DvLuNjUtict9uueGi/25FtjK8Y/rzo=;
 b=KwmAE6a/SUuoxEeNdhJwhrwNNWpGiDgsLWqO5MTUIPRpOD8mGXSMoJyO/V7rWkjre9Hm
 eaxqJUsvfguoc8DdOfI4doOXUIOpEY5DHrly4mrLiescnSqIAhoHncVJFIQs6i3zI5F6y
 avg7kKevIEwIiKT6EUPSLhF+pLHjmx1StT2jsG6PuSmQ72j9wX3clNJRJsvlAtOZ+0kab
 2XyYLNdCc3e/0nXsakOhck5lTshXr70hnBro9u8/KmXYybeNNla/zt5klHUU8Zew8Ovw3
 qAhxY9XkT6BnwYieQRuXHYjnxQ/qs3PUki4vIjkFDPo3aNrREMyLWdapbQAs9xEcYvA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=mediatek.com; 
 dkim=pass header.d=mediatek.com header.i=@mediatek.com header.a=rsa-sha256
 header.s=dk header.b="mM5hR/GA"; 
 dkim=fail reason="signature verification failed"
 header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector2-mediateko365-onmicrosoft-com
 header.b=b0e8eeVR; 
 arc=fail smtp.remote-ip=60.244.123.138
Received-SPF: Temperror (mailfrom) identity=mailfrom; client-ip=60.244.123.138;
 helo=mailgw01.mediatek.com; envelope-from=macpaul.lin@mediatek.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=mediatek.com
 header.i=@mediatek.com header.a=rsa-sha256 header.s=dk header.b=mM5hR/GA; 
 dkim=fail reason="signature verification failed" (1024-bit key,
 unprotected) header.d=mediateko365.onmicrosoft.com
 header.i=@mediateko365.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-mediateko365-onmicrosoft-com header.b=b0e8eeVR
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8EF78807F7
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 08:36:13 +0000 (UTC)
X-UUID: cf3ac3cabbe011f1b1788b6acf885367-20260929
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:Content-Transfer-Encoding:Message-ID:Date:Subject:CC:To:From;
 bh=hsSjSubkJshH0DvLuNjUtict9uueGi/25FtjK8Y/rzo=; 
 b=mM5hR/GAGtFN7tYIiODdS0Eg3HWz0UmRheRFpbcA5ExVc7sONYL/Cj3202uFMdPxmPhNa7kuXP5EVqJr5zc2JJ1ubzp3+YICj34Oxcps5jW1mg7rbue+IzTFcCo3ozi5XCb25fqCXBm2bsmZYj3DK6PHIm3fvzz/8rIaWWitKSc=;
X-CID-CACHE: Type:Local,Time:202609291636+08,HitQuantity:2
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.20, REQID:db4c7e72-9ee9-4fd1-9164-274903ebc055, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:291e20b, CLOUDID:04cddb48-31d8-4c85-9764-41d7a8db1b47,
 B
 ulkID:nil,BulkQuantity:0,SF:80|83|102|110|111|836|865|888|898,TC:-5,Conten
 t:0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:
 0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: cf3ac3cabbe011f1b1788b6acf885367-20260929
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by
 mailgw01.mediatek.com (envelope-from <macpaul.lin@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 2130736695; Tue, 29 Sep 2026 16:36:04 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 29 Sep 2026 16:36:03 +0800
Received: from SG2PR04CU010.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Tue, 29 Sep 2026 16:36:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UHVFJki4Os0bE7DpVRPHRJU33ta7EjaNiMGu4Xh7QZ513uTgdV6YcGnGqo+/AvFZp8rwgkZzxU/kBU3wpWHqnvlHOGgd06GH1xyLmp3GerdldJNDMW6Hb+L/xlHSZEVFMAAl2UxvQAXgZxuWHlxiIup/Uu9m932N/Ua+ru9wH6swB4HSHrsvwDKrjZys5l8yiNi+CqGHCD+gNRNDg41Ah1KfikWHNHQDkrcrszlJfkUGYR8NVuBC7IBb0RtwEPQM7FZFkZiW+sjAi0+G82OR1JozN0Undtbs35bhBoe24U7s5ruxdcg3hGTv10q4Tx+UJc1B61SC9cLVXKhezzi5lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8uk/EF6EMONvNGV0t2Js6P0ZjLT+zf6E7EI/PYOhYZ4=;
 b=tLNtW8GXCiRXrAZHzonL5eS7NQASbvF9WN8kHS2l3OZao+JF9un4GCswnQXeyIEPqcQ5XuUlEgv3yuH0IF/zkU+qQMMgYe6IPxXZYD+y11l8VgAbnO0u+TPj5HyLsk5E24Ogu/1HkGLbW5YFHo+Q211Wvh5MY30tWXYBzRLDCSJ9y6EbZEqlXMAk5wM1LL8wC1rB/Z2uLsO2jVX/wVw0XOmyBC7emm3SgpNrd8tkARf6orK18EkzxNvAO3ckb/HLvaQWsdUetyP5hCCpr3S66gYmg5YKNt/bim2HK1yykzbfHAUooUQ35+lFIULtZmh67T83f5FiEgyupvxmVZkUWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8uk/EF6EMONvNGV0t2Js6P0ZjLT+zf6E7EI/PYOhYZ4=;
 b=b0e8eeVR7YaPE3nb4aO1sbFFWWiznNnq0mcClOSoFEAuaVjGPXAyJFu2JTvprQgBwf3UaWc3du4KcqdoRiPItHb7P08W9jys3jzccFtQF8PkL0KTlBYlQot0b6D/SqMrDh2LUxDyvkxQiZCv6WduYz3tF8mDqekdwoViFd3b1Bs=
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com (2603:1096:101:184::13)
 by SEZPR03MB6572.apcprd03.prod.outlook.com (2603:1096:101:77::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 08:35:55 +0000
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8]) by SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8%6]) with mapi id 15.21.0451.022; Tue, 29 Sep 2026
 08:35:55 +0000
From: =?utf-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, Jorge Ramirez
 <jorge.ramirez@oss.qualcomm.com>
CC: Jens Wiklander <jens.wiklander@oss.qualcomm.com>, Tom Rini
 <trini@konsulko.com>, David Lechner <dlechner@baylibre.com>, Carlo Caione
 <ccaione@baylibre.com>, Julien Stephan <jstephan@baylibre.com>,
 "stanleyjhu@google.com" <stanleyjhu@google.com>, "Beanhuo@micron.com"
 <Beanhuo@micron.com>, Zhaoxuan Zhai <zhai.zhaoxuan@canonical.com>, "Ethan
 Hsieh" <ethan.hsieh@canonical.com>, Jian Hui Lee <jianhui.lee@canonical.com>, 
 "jens.wiklander@linaro.org" <jens.wiklander@linaro.org>, "peng.fan@nxp.com"
 <peng.fan@nxp.com>, "jh80.chung@samsung.com" <jh80.chung@samsung.com>,
 "tanmay.kathpalia@altera.com" <tanmay.kathpalia@altera.com>,
 "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
 "bhupesh.linux@gmail.com" <bhupesh.linux@gmail.com>, "n-francis@ti.com"
 <n-francis@ti.com>, "xypron.glpk@gmx.de" <xypron.glpk@gmx.de>,
 "s-vadapalli@ti.com" <s-vadapalli@ti.com>, "michal.simek@amd.com"
 <michal.simek@amd.com>, "jbx6244@gmail.com" <jbx6244@gmail.com>,
 =?utf-8?B?QmVhciBXYW5nICjokKnljp/mg5/lvrcp?= <bear.wang@mediatek.com>,
 =?utf-8?B?SHQgTGluICjmnpfngJrlrpcp?= <Ht.Lin@mediatek.com>,
 =?utf-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?= <pablo.sun@mediatek.com>,
 "marek.vasut+renesas@mailbox.org" <marek.vasut+renesas@mailbox.org>,
 "sumit.garg@oss.qualcomm.com" <sumit.garg@oss.qualcomm.com>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>
Subject: Re: [PATCH v5 0/6] ufs: rpmb: route OP-TEE RPMB secure storage over
 UFS
Thread-Topic: [PATCH v5 0/6] ufs: rpmb: route OP-TEE RPMB secure storage over
 UFS
Thread-Index: AQHdT+2LuvqhzlAKCUmsnEN0vYkS8w==
Date: Tue, 29 Sep 2026 08:35:55 +0000
Message-ID: 9d31babd32fe8fb3f0ca01dfa870bf6407326b89.camel@mediatek.com
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7810:EE_|SEZPR03MB6572:EE_
x-ms-office365-filtering-correlation-id: 93e7feee-6fdc-487a-ee1c-08df1e04adda
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|7416014|366016|23010399003|38070700021|56012099006|6133799003|10067099003|5023799004|11063799006|18002099003;
x-microsoft-antispam-message-info: Z14ChIgnkAn8uUjQxY1hAYD49rSSjYQAp40ea6155HSw2wQrG7ZLLUAyfJXdvqwfzu/xtbTNnFehDJ9s+OMI2mJ2kOT4YOMFF2QViNrgpr0uZEAnHWgjCVqT5vfNNugIlUkj0xHmfT2qoDBU9mqrDd5VNeejHGNZTv/AwjaIMHg7p6jlhPYVgd3Wjr68Qpw0lPvV3bJqcCkVkv40EXtcO4DoHKo1ZLhlMsrVaIuMvjaxzwF5FAeRsW7fpFO6/txGitK1S8RD3xxNWyKk7jWaIuFgO3K+DGk58B1ufhPStT1YrxeXpv2q2H0P88+iEotUJM7U8eEXVOvABUY8xziCqqF+SyBBLPl3VkvDmzvUpvjO4f5L0zLYQ/QpXARQvaKQdEHegK1vPcpTT8IsnoGPTyvDOnoCWIzuqPpBxcZsx1eLpdq4ESVt2BBA2+mgbfZ3xn6qaIPcu3U+gziMdmIHUtnyZsSN6pvRF+jMBdmzcFda+/n3KetvuqhuzDOrOiIZuiW58Y2fCONTr8IHpm32n5Rz/sNYiNOsjR/pyIDdM5HEbK+KSsR1n570VBBlVra5iwkNOWZAiWLhu+iVjRCWMdBWuU/80cwFULRuUhXmRA0/YHrPu5FWml4swJdvrfawtSFToGT5Igqi1iL2qmlwSY1N2Y7QE5hHSNAKH1/2UuOsP6djN+YK14zbjtoh0j9JWIh91JzmC9Ti0w4QGHSiPrH8IeTTa65KJ5j0VYukrhs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR03MB7810.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(366016)(23010399003)(38070700021)(56012099006)(6133799003)(10067099003)(5023799004)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S3BramtyWjc1ZkI0NXM1RnIxMko0RDJkbWRxM0p4QThFY1hUczV3YWx5QWYv?=
 =?utf-8?B?ME1xemhJZHFraGZVT1BwNDdkS2ZpZmhSSWJ6bDZKVWI4dThSRHN6eFFnUmFp?=
 =?utf-8?B?UTNRWisrc2ROZFh3dldmdjZuU2hqYVBNcko2NzBoZkNQYm40OXQyRnF2dU13?=
 =?utf-8?B?NGlYcU8wUXgyV0tGZVgvUDVrVU5TSCtIazNMQkRPVVpQNk1mcHY1S1BFcEJD?=
 =?utf-8?B?V3ViY2kxenlpb1ZNaHFlUEFNYWtPb0k0QWJBUVIwU3IvRm91VnpXcjR6c3hD?=
 =?utf-8?B?Wlh4dTZKeTVxZVhwU0YySW9NSHpFVFhRNGlVb2hHR0tHUkpBU3hJaWdpNTVy?=
 =?utf-8?B?NEFOQi9VVnpUS1hNVmM2WGhDODdKMU1DQzV4SnUwbThuSXFvaFpjc3BadERi?=
 =?utf-8?B?TktRNXVTQUNITVRGYWhKSWhFWnMvbHAzQ2lUSmFlcnROeTBKODVuU1h3UUVG?=
 =?utf-8?B?bUc0NUdaZjI2b1RNbFdGSGRSZzY3QzE5T2VyK3VkTFJ0ajYwV0lFWjc0dity?=
 =?utf-8?B?blhIQU91aEhSNmlWOS9SU3ZpbkpTUE42NXpHbUpJelhoTmZKQVU3c1VHTU44?=
 =?utf-8?B?bmdZaFBNKy8rSkx0R1hlVnozSXhiK1A0TmhqUHNySUFhckh2Zy9haWphYStD?=
 =?utf-8?B?RktwbElSOVA2aDZUcDkxeVMrZnl3a3Q1Rm9yRzV0SDUwNmdYWHNvREs1TWFW?=
 =?utf-8?B?eFgxZVJQUGhZWVBtMEZVeVA4VGU5SHZqT0R6SUtkK21EMTRQTk5hQkkyN0pN?=
 =?utf-8?B?cnlMdDRUVjRna1cxR0FVY2ZKcEo1SWtNOVF4VlYvT2JsZm9rM3ZtRHVUTStt?=
 =?utf-8?B?OUplMXNIWGNQakpKdUFhNUNjS1kwZkVPdW51aERESnhkaHFGNFU5bFNPKzRQ?=
 =?utf-8?B?S3FOMituaTJkLzdxOHQ4UU5menJpSk94RE9yWE5IYUE1aCtScDU0V3Q3T3ow?=
 =?utf-8?B?Z0FPMXFiSCtxTHV1SzJickkxTkpkRW9LZ2xMNkJScm9MUjFrQTV5b0E4dkd0?=
 =?utf-8?B?blFDSmJDbGNwUjNNYnB5WnVQMk16ek5nL21rcklGc2c1OUFkeHM4UGFPN1dC?=
 =?utf-8?B?VHdQbmIyMVFOZU9FRnp1cDVVSTBEbGIwZ29EeFpmNmVVL2h3ZHdmS0ZxSEJu?=
 =?utf-8?B?cEJibmFtRkphLzVoU3FUSFNUZjNSeWM1ZHR5TmdkTTFsVUNFUEROVEZpRTBo?=
 =?utf-8?B?bnVzZDdPV3d2S2s4RmJwbnVyNGMvRlNUQ0hoUG96RXNHNk9ia3FPY1NsK2p5?=
 =?utf-8?B?VUU1MEZkKytiNkZTNTdwVWk2aWZGVjdLRkxCQ1FCRTdPZXowQjhWbmJSdDJ6?=
 =?utf-8?B?YXpVWVJYa2JrSUNVaDlIS0VFRHhWT2Qrb3cvcHhHQkFZYlFOcTIzNWowS2l6?=
 =?utf-8?B?OTNrcyt3Rk9FZ1dwWWJmbnU5SVZBelNsNWxlSmlpSytvaEZzWFpxMkVaNVNM?=
 =?utf-8?B?L0tFUWE3ZUlqOG1Eam85dlpzUVdiY25FY3ZleVpGanFzVzhwTmRYZmJxckU0?=
 =?utf-8?B?cFZpRjEvVUtVNFd1YjBRSHRXQzVnbVdnSm81NXRzQi9ieDRzTWR6V2tLUnJn?=
 =?utf-8?B?OUZGL2RYQWFMVW5hTDQxTmtrS1JDdHFneTNKQzRSdE5RZGhFQlk3NnpmSTYy?=
 =?utf-8?B?bDd2SzB5TVFUSUptYWVWbVV6d25OWXRNTEFsaG9ucnZvMkpRaTd4bjRPV1lS?=
 =?utf-8?B?RStKU2UxUWZsalR3V1RpUzlqd25vNmx1VS9pdXZOY0NOcjdnKzIzVGkzeW1y?=
 =?utf-8?B?NjRrcHRBd0tVVkpSZStBeXB1Wm9sL2FjK2dJT0w4SklqSzJuMlhQcEMwRWRZ?=
 =?utf-8?B?Y1ljVmI4bi9xWjF5YUpIRkorNk1ZYW5qNUJUdzhwRjV2eFRKTjNmM1FMUnJj?=
 =?utf-8?B?R2M4a01ZZ2QrMGpjQ3NvVXFNZW4zbmIyL2lTak4rWEUwTk03eVd4aXVLVkVo?=
 =?utf-8?B?U1E0TnFaMy9qUlJZTHFWcWN0eEQ5RG1DRHY3SXRRSEU1eVpYUHRNQW9RU1Uw?=
 =?utf-8?B?alNTSFhKTTZwNko5eGFROWxhZFpFREk4Umd6TEhvVlNSK1FWWGIyOElVR0N2?=
 =?utf-8?B?OEU0QzI4enpFd1Z4dWdLQjBRNWk4RzNNVmtaYWZHZHBOTUdwTVZmT0VKRGwv?=
 =?utf-8?B?TVpWZ0Zrd2NaMnVEUldub04xUW1ZMGU4YlNRVDY4KzFhWW95MVFHOXNMeWFC?=
 =?utf-8?B?c2tycWVtZmFmSllHT2pScXRsdllJY3lwUUFYaUFLeWhCUFgwUXNKaEowZXR3?=
 =?utf-8?B?UTZnbW52QW9Jb0pOSGE2Szd4cDNObFVZK0c0ZmdXblVUTGUwTEJtRHg2Y3Y0?=
 =?utf-8?B?dGtodVZqNDl5eElUSDVIdWZWL3ZnM2toZnF5ZmU3cm9Bay9iT2NIUT09?=
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: sFmGqFdHR8NoCpvIJhcS016UcXVlQ0zNIXffJEha1WssvcCsBszPFHJs+6pus6ny8jJNtE8OICcsytEWYSQQnX5T2yH3TCg1g1XSawjNeRhnX5FGeZFKBODdQjxDSGFLyIpBgey2vdDwiUsVquX98Dn3YJdpSPRyva9PdeKld9RwzkHUIDIvYUFnm/Xnoe4dfaBaYW02lqZcobh/OT0Bl2V8JoQMKrSwuFF2+U0l5C/AZ8I/FtVRRRkH4DJ7tMMAieeDN7ggaJ6A+NqfqubfrQ1LLRiwMQNROy7JPEepfseQPOfndlh9bqdDdFZLVyGSxvpNp5+sqQ+gbgnUgRERhA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7810.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93e7feee-6fdc-487a-ee1c-08df1e04adda
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2026 08:35:55.5030 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BQrXaYoVG29NfeIl+El9+Ib9KMMODB8VDQbkRuaR6w48WQJiYiB6ijbrOfY4cRkuHge9n4Q3fxISWYCMWv3RUSQjyJC1yKkKAswRB//kBWw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB6572
Content-Type: multipart/alternative;
 boundary="__=_Part_Boundary_009_142517021.1564286452"
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

--__=_Part_Boundary_009_142517021.1564286452
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64

T24gTW9uLCAyMDI2LTA5LTI4IGF0IDEzOjAyICswMzAwLCBJbGlhcyBBcGFsb2RpbWFzIHdyb3Rl
Ogo+IEhpIEpvcmdlLAo+IAo+IAo+IE9uIFN1biwgMjcgU2VwdCAyMDI2IGF0IDAwOjA5LCBKb3Jn
ZSBSYW1pcmV6Cj4gPGpvcmdlLnJhbWlyZXpAb3NzLnF1YWxjb21tLmNvbT4gd3JvdGU6Cj4gPiAK
PiA+IE9uIDI2LzA5LzI2IDIyOjQxOjAwLCBKb3JnZSBSYW1pcmV6IHdyb3RlOgo+ID4gPiBPbiAy
NS8wOS8yNiAxMjo1OToyOCwgSWxpYXMgQXBhbG9kaW1hcyB3cm90ZToKPiA+ID4gPiBUaGFua3Mg
Zm9yIHRoZSBkZXRhaWxlZCBhbmFseXNpcy4KPiA+ID4gPiAKPiA+ID4gPiBJIGFtIHB1bGxpbmcg
aW4gSmVucyBmb3IgT1AtVEVFIGFuZCBJJ2xsIGhhdmUgYSBjbG9zZXIgbG9vawo+ID4gPiA+IG5l
eHQgd2VlayBhcyB3ZWxsLgo+ID4gPiAKPiA+ID4gdGhlIGNvbmNlcm50IEkgcmVhZCAtIHBsZWFz
ZSBjb3JyZWN0IG1lIGlmIEkgYW0gd3JvbmcgLSBpcyB0aGF0Cj4gPiA+IHRoaXMgY29kZSBhZmZl
Y3RzCj4gPiA+IGRvd25zdHJlYW0gcHJvamVjdHMuCj4gPiA+IAo+ID4gPiBUaGlzIGlzIGp1c3Qg
bm90IGFjY2VwdGFibGUgdG8gbWUgLSBkb3duc3RyZWFtIGltcGxlbWVudGF0aW9ucwo+ID4gPiBz
aG91bGQgaGF2ZSBiZWVuCj4gPiA+IHBvc3RlZCB0byBwcmV2ZW50IGV4YWN0bHkgdGhlc2Uga2lu
ZCBpc3N1ZXMuCj4gPiA+IAo+ID4gPiBXZSBzcGVudMKgIHRpbWUgYW5kIGVmZm9ydCBkb2luZyBh
biBpbXBsZW1lbnRhdGlvbiBhbmQgc2hhcmluZyBpdAo+ID4gPiB3aXRoIHRoZQo+ID4gPiBjb21t
dW5pdHkgLSBpdCB3b3VsZG50IGJlIGZhaXIgdG8gdXMgdG8gYmxvY2sgdGhpcyBtZXJnZSBvbiB0
aGUKPiA+ID4gYmFzaXMgb2YKPiA+ID4gZG93bnN0cmVhbSBwcm9qZWN0cyBiZWluZyBpbXBhY3Rl
ZC4KPiA+ID4gCj4gPiA+IAo+ID4gCj4gPiBpbiBzdW1tYXJ5IGFuZCB0byBiZSB2ZXJ5IGNsZWFy
Cj4gPiAKPiA+IDEtIHRoZSB1cHN0cmVhbSBDSUQgZGVyaXZhdGlvbiBpcyB0aGUgdS1ib290L29w
LXRlZSBjb250cmFjdCB0aGF0Cj4gPiBtYXRjaGVzIG1haW5saW5lIGxpbnV4J3MgdWZzaGNkX2Ny
ZWF0ZV9kZXZpY2VfaWQoKS4gVGhlIGNvbnRyYWN0IGlzCj4gPiBhbgo+ID4gT1AtVEVFLWRlZmlu
ZWQgQUJJLCBub3QgYSBHbG9iYWwgUGxhdGZvcm0gc3BlYy4KPiA+IAo+ID4gMi4gTW9yZW92ZXIg
Q0lELWtleSBpcyBPUC1URUUncyBvd24gSFVLLWJhc2VkIGRlcml2YXRpb24sIG5vdCBHUCwKPiA+
IG5vdCBKRURFQy4KPiA+IAo+ID4gMy0gTm90aGluZyBoZXJlIGJsb2NrcyBhbnlvbmUgZnJvbSBv
dmVycmlkaW5nIHRoZSBzdGF0aWMKPiA+IHVmc19ycG1iX2J1aWxkX2NpZCgpCj4gPiBkb3duc3Ry
ZWFtLgo+ID4gCj4gPiAzLSBpZiBkb3duc3RyZWFtIHNjaGVtZSBkaWZmZXJzLCB0aGF0J3MgdGhl
IGNvc3Qgb2YgaGF2aW5nIGtlcHQgaXQKPiA+IG91dCBvZiB0cmVlLAo+ID4gbm90IGEgcmVhc29u
IHRvIGhvbGQgdGhpcyBzZXJpZXMgZm9yIHNwZWN1bGF0aXZlIHBsdWctaW4KPiA+IGluZnJhc3Ry
dWN0dXJlIHdpdGggYQo+ID4gc2luZ2xlIGJhY2tlbmQuCj4gCj4gKzEuIE1hY3BhdWwgaXMgdGhl
cmUgYW55dGhpbmcgZWxzZSB5b3UgY2FuIHJldmlldyBhcGFydCBmcm9tIHRoZQo+IGRvd25zdHJl
YW0gYnJlYWthZ2UuIFRCSCBzaW5jZSB5b3UgZGlkbjt0IGJvdGhlciB1cHN0cmVhbWluZyB0aGF0
LAo+IG9iamVjdGluZyB0byBjb2RlIHRoYXQgYWRkcyByZWFsIHN1cHBvcnQgZG9lc24ndCByZWFs
bHkgc3RhbmQgYXMgYW4KPiBhcmd1ZW1lbnQuCj4gCj4gSm9yZ2UsIEkgZGlkIGEgcXVpY2sgcGFz
cyBhbmQgSSBkb24ndCBzZWUgYW55IGJpZyBpc3N1ZXMgd2l0aCB0aGUKPiBzZXJpZXMuIEknbGwg
ZG8gYW5vdGhlciBwYXNzIGxhdGVyIHRoaXMgd2VlayBhbmQgc2VuZCBhIFBSIGlmIHRoZSBDSQo+
IGFncmVlcy4KPiAKPiBDaGVlcnMKPiAvSWxpYXMKCkdvdCBpdC4gVGhhdCdzIHF1aXRlIHJlYXNv
bmFibGUgZm9yIHRha2luZyB0aGUgY3VycmVudCBpbXBsZW1lbnRhdGlvbi4KTWVkaWFUZWsgd2ls
bCB0cnkgdG8gcHJvcG9zZSB0aGUgdmVuZG9yIHNwZWNpZmljIGhlbHBlciBmdW5jdGlvbnMKYW5k
wqBhbmQgdXBzdHJlYW0gb3RoZXIgYmFja2VuZHMgZm9yIHNvbWUgZG93bnN0cmVhbQppbXBsZW1l
bnRhdGlvbi4gSG9wZSB0aGlzIGNvdWxkIGJlIGhhcHBlbmVkIHNvb24uIFRoYW5rcyBmb3IgdGFr
aW5nCnRpbWUgdG8gcmVhZCB0aGUgcHJldmlvdXMgcmVwbHkuCgpCZXN0IHJlZ2FyZHMsCk1hY3Bh
dWwgTGluCgo=

--__=_Part_Boundary_009_142517021.1564286452
Content-Type: text/html;
	charset="utf-8"
Content-Transfer-Encoding: base64

PGh0bWw+PGJvZHk+PHA+DQo8cHJlPg0KT24mIzMyO01vbiwmIzMyOzIwMjYtMDktMjgmIzMyO2F0
JiMzMjsxMzowMiYjMzI7KzAzMDAsJiMzMjtJbGlhcyYjMzI7QXBhbG9kaW1hcyYjMzI7d3JvdGU6
CiZndDsmIzMyO0hpJiMzMjtKb3JnZSwKJmd0OyYjMzI7CiZndDsmIzMyOwomZ3Q7JiMzMjtPbiYj
MzI7U3VuLCYjMzI7MjcmIzMyO1NlcHQmIzMyOzIwMjYmIzMyO2F0JiMzMjswMDowOSwmIzMyO0pv
cmdlJiMzMjtSYW1pcmV6CiZndDsmIzMyOyZsdDtqb3JnZS5yYW1pcmV6QG9zcy5xdWFsY29tbS5j
b20mZ3Q7JiMzMjt3cm90ZToKJmd0OyYjMzI7Jmd0OyYjMzI7CiZndDsmIzMyOyZndDsmIzMyO09u
JiMzMjsyNi8wOS8yNiYjMzI7MjI6NDE6MDAsJiMzMjtKb3JnZSYjMzI7UmFtaXJleiYjMzI7d3Jv
dGU6CiZndDsmIzMyOyZndDsmIzMyOyZndDsmIzMyO09uJiMzMjsyNS8wOS8yNiYjMzI7MTI6NTk6
MjgsJiMzMjtJbGlhcyYjMzI7QXBhbG9kaW1hcyYjMzI7d3JvdGU6CiZndDsmIzMyOyZndDsmIzMy
OyZndDsmIzMyOyZndDsmIzMyO1RoYW5rcyYjMzI7Zm9yJiMzMjt0aGUmIzMyO2RldGFpbGVkJiMz
MjthbmFseXNpcy4KJmd0OyYjMzI7Jmd0OyYjMzI7Jmd0OyYjMzI7Jmd0OyYjMzI7CiZndDsmIzMy
OyZndDsmIzMyOyZndDsmIzMyOyZndDsmIzMyO0kmIzMyO2FtJiMzMjtwdWxsaW5nJiMzMjtpbiYj
MzI7SmVucyYjMzI7Zm9yJiMzMjtPUC1URUUmIzMyO2FuZCYjMzI7SSYjMzk7bGwmIzMyO2hhdmUm
IzMyO2EmIzMyO2Nsb3NlciYjMzI7bG9vawomZ3Q7JiMzMjsmZ3Q7JiMzMjsmZ3Q7JiMzMjsmZ3Q7
JiMzMjtuZXh0JiMzMjt3ZWVrJiMzMjthcyYjMzI7d2VsbC4KJmd0OyYjMzI7Jmd0OyYjMzI7Jmd0
OyYjMzI7CiZndDsmIzMyOyZndDsmIzMyOyZndDsmIzMyO3RoZSYjMzI7Y29uY2VybnQmIzMyO0km
IzMyO3JlYWQmIzMyOy0mIzMyO3BsZWFzZSYjMzI7Y29ycmVjdCYjMzI7bWUmIzMyO2lmJiMzMjtJ
JiMzMjthbSYjMzI7d3JvbmcmIzMyOy0mIzMyO2lzJiMzMjt0aGF0CiZndDsmIzMyOyZndDsmIzMy
OyZndDsmIzMyO3RoaXMmIzMyO2NvZGUmIzMyO2FmZmVjdHMKJmd0OyYjMzI7Jmd0OyYjMzI7Jmd0
OyYjMzI7ZG93bnN0cmVhbSYjMzI7cHJvamVjdHMuCiZndDsmIzMyOyZndDsmIzMyOyZndDsmIzMy
OwomZ3Q7JiMzMjsmZ3Q7JiMzMjsmZ3Q7JiMzMjtUaGlzJiMzMjtpcyYjMzI7anVzdCYjMzI7bm90
JiMzMjthY2NlcHRhYmxlJiMzMjt0byYjMzI7bWUmIzMyOy0mIzMyO2Rvd25zdHJlYW0mIzMyO2lt
cGxlbWVudGF0aW9ucwomZ3Q7JiMzMjsmZ3Q7JiMzMjsmZ3Q7JiMzMjtzaG91bGQmIzMyO2hhdmUm
IzMyO2JlZW4KJmd0OyYjMzI7Jmd0OyYjMzI7Jmd0OyYjMzI7cG9zdGVkJiMzMjt0byYjMzI7cHJl
dmVudCYjMzI7ZXhhY3RseSYjMzI7dGhlc2UmIzMyO2tpbmQmIzMyO2lzc3Vlcy4KJmd0OyYjMzI7
Jmd0OyYjMzI7Jmd0OyYjMzI7CiZndDsmIzMyOyZndDsmIzMyOyZndDsmIzMyO1dlJiMzMjtzcGVu
dCYjMTYwOyYjMzI7dGltZSYjMzI7YW5kJiMzMjtlZmZvcnQmIzMyO2RvaW5nJiMzMjthbiYjMzI7
aW1wbGVtZW50YXRpb24mIzMyO2FuZCYjMzI7c2hhcmluZyYjMzI7aXQKJmd0OyYjMzI7Jmd0OyYj
MzI7Jmd0OyYjMzI7d2l0aCYjMzI7dGhlCiZndDsmIzMyOyZndDsmIzMyOyZndDsmIzMyO2NvbW11
bml0eSYjMzI7LSYjMzI7aXQmIzMyO3dvdWxkbnQmIzMyO2JlJiMzMjtmYWlyJiMzMjt0byYjMzI7
dXMmIzMyO3RvJiMzMjtibG9jayYjMzI7dGhpcyYjMzI7bWVyZ2UmIzMyO29uJiMzMjt0aGUKJmd0
OyYjMzI7Jmd0OyYjMzI7Jmd0OyYjMzI7YmFzaXMmIzMyO29mCiZndDsmIzMyOyZndDsmIzMyOyZn
dDsmIzMyO2Rvd25zdHJlYW0mIzMyO3Byb2plY3RzJiMzMjtiZWluZyYjMzI7aW1wYWN0ZWQuCiZn
dDsmIzMyOyZndDsmIzMyOyZndDsmIzMyOwomZ3Q7JiMzMjsmZ3Q7JiMzMjsmZ3Q7JiMzMjsKJmd0
OyYjMzI7Jmd0OyYjMzI7CiZndDsmIzMyOyZndDsmIzMyO2luJiMzMjtzdW1tYXJ5JiMzMjthbmQm
IzMyO3RvJiMzMjtiZSYjMzI7dmVyeSYjMzI7Y2xlYXIKJmd0OyYjMzI7Jmd0OyYjMzI7CiZndDsm
IzMyOyZndDsmIzMyOzEtJiMzMjt0aGUmIzMyO3Vwc3RyZWFtJiMzMjtDSUQmIzMyO2Rlcml2YXRp
b24mIzMyO2lzJiMzMjt0aGUmIzMyO3UtYm9vdC9vcC10ZWUmIzMyO2NvbnRyYWN0JiMzMjt0aGF0
CiZndDsmIzMyOyZndDsmIzMyO21hdGNoZXMmIzMyO21haW5saW5lJiMzMjtsaW51eCYjMzk7cyYj
MzI7dWZzaGNkX2NyZWF0ZV9kZXZpY2VfaWQoKS4mIzMyO1RoZSYjMzI7Y29udHJhY3QmIzMyO2lz
CiZndDsmIzMyOyZndDsmIzMyO2FuCiZndDsmIzMyOyZndDsmIzMyO09QLVRFRS1kZWZpbmVkJiMz
MjtBQkksJiMzMjtub3QmIzMyO2EmIzMyO0dsb2JhbCYjMzI7UGxhdGZvcm0mIzMyO3NwZWMuCiZn
dDsmIzMyOyZndDsmIzMyOwomZ3Q7JiMzMjsmZ3Q7JiMzMjsyLiYjMzI7TW9yZW92ZXImIzMyO0NJ
RC1rZXkmIzMyO2lzJiMzMjtPUC1URUUmIzM5O3MmIzMyO293biYjMzI7SFVLLWJhc2VkJiMzMjtk
ZXJpdmF0aW9uLCYjMzI7bm90JiMzMjtHUCwKJmd0OyYjMzI7Jmd0OyYjMzI7bm90JiMzMjtKRURF
Qy4KJmd0OyYjMzI7Jmd0OyYjMzI7CiZndDsmIzMyOyZndDsmIzMyOzMtJiMzMjtOb3RoaW5nJiMz
MjtoZXJlJiMzMjtibG9ja3MmIzMyO2FueW9uZSYjMzI7ZnJvbSYjMzI7b3ZlcnJpZGluZyYjMzI7
dGhlJiMzMjtzdGF0aWMKJmd0OyYjMzI7Jmd0OyYjMzI7dWZzX3JwbWJfYnVpbGRfY2lkKCkKJmd0
OyYjMzI7Jmd0OyYjMzI7ZG93bnN0cmVhbS4KJmd0OyYjMzI7Jmd0OyYjMzI7CiZndDsmIzMyOyZn
dDsmIzMyOzMtJiMzMjtpZiYjMzI7ZG93bnN0cmVhbSYjMzI7c2NoZW1lJiMzMjtkaWZmZXJzLCYj
MzI7dGhhdCYjMzk7cyYjMzI7dGhlJiMzMjtjb3N0JiMzMjtvZiYjMzI7aGF2aW5nJiMzMjtrZXB0
JiMzMjtpdAomZ3Q7JiMzMjsmZ3Q7JiMzMjtvdXQmIzMyO29mJiMzMjt0cmVlLAomZ3Q7JiMzMjsm
Z3Q7JiMzMjtub3QmIzMyO2EmIzMyO3JlYXNvbiYjMzI7dG8mIzMyO2hvbGQmIzMyO3RoaXMmIzMy
O3NlcmllcyYjMzI7Zm9yJiMzMjtzcGVjdWxhdGl2ZSYjMzI7cGx1Zy1pbgomZ3Q7JiMzMjsmZ3Q7
JiMzMjtpbmZyYXN0cnVjdHVyZSYjMzI7d2l0aCYjMzI7YQomZ3Q7JiMzMjsmZ3Q7JiMzMjtzaW5n
bGUmIzMyO2JhY2tlbmQuCiZndDsmIzMyOwomZ3Q7JiMzMjsrMS4mIzMyO01hY3BhdWwmIzMyO2lz
JiMzMjt0aGVyZSYjMzI7YW55dGhpbmcmIzMyO2Vsc2UmIzMyO3lvdSYjMzI7Y2FuJiMzMjtyZXZp
ZXcmIzMyO2FwYXJ0JiMzMjtmcm9tJiMzMjt0aGUKJmd0OyYjMzI7ZG93bnN0cmVhbSYjMzI7YnJl
YWthZ2UuJiMzMjtUQkgmIzMyO3NpbmNlJiMzMjt5b3UmIzMyO2RpZG47dCYjMzI7Ym90aGVyJiMz
Mjt1cHN0cmVhbWluZyYjMzI7dGhhdCwKJmd0OyYjMzI7b2JqZWN0aW5nJiMzMjt0byYjMzI7Y29k
ZSYjMzI7dGhhdCYjMzI7YWRkcyYjMzI7cmVhbCYjMzI7c3VwcG9ydCYjMzI7ZG9lc24mIzM5O3Qm
IzMyO3JlYWxseSYjMzI7c3RhbmQmIzMyO2FzJiMzMjthbgomZ3Q7JiMzMjthcmd1ZW1lbnQuCiZn
dDsmIzMyOwomZ3Q7JiMzMjtKb3JnZSwmIzMyO0kmIzMyO2RpZCYjMzI7YSYjMzI7cXVpY2smIzMy
O3Bhc3MmIzMyO2FuZCYjMzI7SSYjMzI7ZG9uJiMzOTt0JiMzMjtzZWUmIzMyO2FueSYjMzI7Ymln
JiMzMjtpc3N1ZXMmIzMyO3dpdGgmIzMyO3RoZQomZ3Q7JiMzMjtzZXJpZXMuJiMzMjtJJiMzOTts
bCYjMzI7ZG8mIzMyO2Fub3RoZXImIzMyO3Bhc3MmIzMyO2xhdGVyJiMzMjt0aGlzJiMzMjt3ZWVr
JiMzMjthbmQmIzMyO3NlbmQmIzMyO2EmIzMyO1BSJiMzMjtpZiYjMzI7dGhlJiMzMjtDSQomZ3Q7
JiMzMjthZ3JlZXMuCiZndDsmIzMyOwomZ3Q7JiMzMjtDaGVlcnMKJmd0OyYjMzI7L0lsaWFzCgpH
b3QmIzMyO2l0LiYjMzI7VGhhdCYjMzk7cyYjMzI7cXVpdGUmIzMyO3JlYXNvbmFibGUmIzMyO2Zv
ciYjMzI7dGFraW5nJiMzMjt0aGUmIzMyO2N1cnJlbnQmIzMyO2ltcGxlbWVudGF0aW9uLgpNZWRp
YVRlayYjMzI7d2lsbCYjMzI7dHJ5JiMzMjt0byYjMzI7cHJvcG9zZSYjMzI7dGhlJiMzMjt2ZW5k
b3ImIzMyO3NwZWNpZmljJiMzMjtoZWxwZXImIzMyO2Z1bmN0aW9ucwphbmQmIzE2MDthbmQmIzMy
O3Vwc3RyZWFtJiMzMjtvdGhlciYjMzI7YmFja2VuZHMmIzMyO2ZvciYjMzI7c29tZSYjMzI7ZG93
bnN0cmVhbQppbXBsZW1lbnRhdGlvbi4mIzMyO0hvcGUmIzMyO3RoaXMmIzMyO2NvdWxkJiMzMjti
ZSYjMzI7aGFwcGVuZWQmIzMyO3Nvb24uJiMzMjtUaGFua3MmIzMyO2ZvciYjMzI7dGFraW5nCnRp
bWUmIzMyO3RvJiMzMjtyZWFkJiMzMjt0aGUmIzMyO3ByZXZpb3VzJiMzMjtyZXBseS4KCkJlc3Qm
IzMyO3JlZ2FyZHMsCk1hY3BhdWwmIzMyO0xpbgoKDQo8L3ByZT4NCjwvcD48L2JvZHk+PC9odG1s
PjwhLS10eXBlOnRleHQtLT48IS0tey0tPjxwcmU+KioqKioqKioqKioqKiBNRURJQVRFSyBDb25m
aWRlbnRpYWxpdHkgTm90aWNlICoqKioqKioqKioqKioqKioqKioqDQpUaGUgaW5mb3JtYXRpb24g
Y29udGFpbmVkIGluIHRoaXMgZS1tYWlsIG1lc3NhZ2UgKGluY2x1ZGluZyBhbnkgDQphdHRhY2ht
ZW50cykgbWF5IGJlIGNvbmZpZGVudGlhbCwgcHJvcHJpZXRhcnksIHByaXZpbGVnZWQsIG9yIG90
aGVyd2lzZQ0KZXhlbXB0IGZyb20gZGlzY2xvc3VyZSB1bmRlciBhcHBsaWNhYmxlIGxhd3MuIEl0
IGlzIGludGVuZGVkIHRvIGJlIA0KY29udmV5ZWQgb25seSB0byB0aGUgZGVzaWduYXRlZCByZWNp
cGllbnQocykuIEFueSB1c2UsIGRpc3NlbWluYXRpb24sIA0KZGlzdHJpYnV0aW9uLCBwcmludGlu
ZywgcmV0YWluaW5nIG9yIGNvcHlpbmcgb2YgdGhpcyBlLW1haWwgKGluY2x1ZGluZyBpdHMgDQph
dHRhY2htZW50cykgYnkgdW5pbnRlbmRlZCByZWNpcGllbnQocykgaXMgc3RyaWN0bHkgcHJvaGli
aXRlZCBhbmQgbWF5IA0KYmUgdW5sYXdmdWwuIElmIHlvdSBhcmUgbm90IGFuIGludGVuZGVkIHJl
Y2lwaWVudCBvZiB0aGlzIGUtbWFpbCwgb3IgYmVsaWV2ZSANCnRoYXQgeW91IGhhdmUgcmVjZWl2
ZWQgdGhpcyBlLW1haWwgaW4gZXJyb3IsIHBsZWFzZSBub3RpZnkgdGhlIHNlbmRlciANCmltbWVk
aWF0ZWx5IChieSByZXBseWluZyB0byB0aGlzIGUtbWFpbCksIGRlbGV0ZSBhbnkgYW5kIGFsbCBj
b3BpZXMgb2YgDQp0aGlzIGUtbWFpbCAoaW5jbHVkaW5nIGFueSBhdHRhY2htZW50cykgZnJvbSB5
b3VyIHN5c3RlbSwgYW5kIGRvIG5vdA0KZGlzY2xvc2UgdGhlIGNvbnRlbnQgb2YgdGhpcyBlLW1h
aWwgdG8gYW55IG90aGVyIHBlcnNvbi4gVGhhbmsgeW91IQ0KPC9wcmU+PCEtLX0tLT4=

--__=_Part_Boundary_009_142517021.1564286452--

