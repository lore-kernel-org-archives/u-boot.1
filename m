Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB295C9830E
	for <u-boot@archiver.kernel.org>; Thu, 24 Sep 2026 17:50:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 737BD8111D;
	Thu, 24 Sep 2026 17:50:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rzpwGviCXXom; Thu, 24 Sep 2026 17:50:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org ECDC18111F
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790272226;
	b=hbBgb3GiwSdPIZt2+egHThDBl6pviuFWiOVJubZvHK3Nv5cL8VyoZdXQ1nnPaCa4rlBF
	 UDOGNGwRk+1Zot7njevGWcPf5RxayMwvBmF4092psycJiEGiiSw4jIrTR+mZw/31btHiO
	 q3GkehXmIftax/OESngF9Uea/Cdh9wYkQ4PIVQgqq8GeSlUGKuH6yEYfqRyGGpHnuUd+s
	 rO2NaSVMRwbbIoFIRMbpwC0V2B2uL/vsc2YHLsZN1xr5KF9Wx0PvRgMoKJ5Ta2HhkLR+n
	 qXjIipyX2mfqVU17zPu8jkOQr32GI9PaHqkscAVGAooS7WMFlZcisxoEmm+zKZQOKmQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790272226;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:X-UUID:
	 DKIM-Signature:X-CID-P-RULE:X-CID-O-INFO:X-CID-META:X-CID-BVR:
	 X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:Received:Received:Received:
	 DKIM-Signature:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:msip_labels:
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
	bh=cgmflvggfrQOKNy2s8k+8JaROwfJ80keSPArl7kpfr4=;
	b=iSmjxvXGcRVFCG9eeWDXiiGWc3xz74ClH7RVXbAQoggmUWx8zegjD4gu1N4Bt3YAuWWX
	 DN46sDTGs894fRRrmVPHyia2wv7p8mxJTliNol01Y4WV+hg8KOqlqb749eTtF5yh/aoqK
	 ioY2z2OZBZqe5GVSrbuG3kk810YzN4HbXkDBPUk356/LXns5xIcVWmsTXXB48rKd0sY9H
	 pB47V43kjaAYxiuNg2T/5BUfgYAHBnckn3ehebDMGLXoHwKhLsCBSO+bK9GpCVKI4nqsU
	 IP05Q+Wv4bxx1ACPBlo3ycOuI+eCV4IM152zAjVfuSWeAGg5AO6t9WM+KuHe931JN1Q==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790272226;
	bh=cgmflvggfrQOKNy2s8k+8JaROwfJ80keSPArl7kpfr4=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=J9klLImbTv9HMX8Qckm24kaN3LcyJLGWp12KQamT9O+lwFPbyavpBTt5+g1dnqBoW
	 spvfZPQUlXqHogyQJtur4gZKlrt+XB5i/8TweWVo30aik5mpjvxy7FlIQ19ax0Sprj
	 twJdijMcr7k807v7hDJyOSt4uSghS0dzjm4OMb496YrZXxvYwAaKiV5WpBRsVtS5oj
	 mS/E9dRdve+64BYx6WcvmwzlwuSnhlOX3WJqjGmEfs2K2sQBrc7ICKHAWwVaR+zZZ7
	 ex3+KE0DKkCOGriRFqVmkf7SDbEUTdh4uCHiGLFH0KXdGh/8bedRyawRmrKCe8VB1I
	 Ha4IXRVSSppew==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id ECDC18111F;
	Thu, 24 Sep 2026 17:50:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 55ED032A
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 17:50:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 31A1040A21
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 17:50:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZaQ1zaXPV-Lp for <u-boot@lists.u-boot-project.org>;
 Thu, 24 Sep 2026 17:50:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org C9F2F40A1D
Authentication-Results: smtp4.osuosl.org;
 arc=fail smtp.remote-ip=60.244.123.138
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790272221;
 b=fmigeUlxP+6R35YKJpB+GiTtw+g54vlI+6YzEnccrs8Lk7wSDLfUV/Fm9wOTApbhYP+p
 tXXZcvnlb/W+TwOCQNe8jvsUSTibxbt/o8Vge3Bz36MQ7Iu7en9Kzxn/UiI7bQufe+VF5
 X9KMhWvo2HPHO74wl9Kx8rlIAHwE6Iz7C3hmbcqPktHYAGpQbDu4DY6wL+t9U7CSLo65o
 ZtIIXbYyZBSHD3f6cakelQ+Pxds5CYKZA4oU4CZ40LOtW3uGTOOioNfLH90BkysIbDLvu
 rLhdlqeF6ed2GuTaCoCKHR/ugsid0vyQaroxH7SIbM/hoijZamiLkYA+EllB5TVq71w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790272221;
 h=Received-SPF:X-UUID:DKIM-Signature:X-CID-P-RULE:X-CID-O-INFO:
 X-CID-META:X-CID-BVR:X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:Received:
 Received:Received:DKIM-Signature:Received:Received:From:To:CC:Subject:
 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
 msip_labels:x-ms-publictraffictype:x-ms-traffictypediagnostic:
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
 bh=cgmflvggfrQOKNy2s8k+8JaROwfJ80keSPArl7kpfr4=;
 b=RZ78Qllh0lMF0x+dfJSba95M6xgMESiZljob639+QCVRoPvRftsVIK0+u0qesNS/nHea
 c2DRNcI89XJ/1ZEHEarDPu+33Wsgs5APXNeBkd5ePHpGS+lSY7cIieFf7Tr2pEgpfmTIJ
 95BNAhZR9QfSCyiU+TjoHOvpwJh/wIVwnOTI1wUMYrilNyqEpwQekrfENdwfVFArYTLO9
 ulrlqapOd3ohyq9S7+DFNrCA1iTaa6Hf/ssI1T0F1tEBHdRjMd1X39TMpLng8CP9jSIgO
 4dqXWodtVG4uTTUu+G7kBYLchnh8mGoWOKaQX/3BqISWfnoPBxGQFcqjTjLftr0mIrA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=mediatek.com; 
 dkim=pass header.d=mediatek.com header.i=@mediatek.com header.a=rsa-sha256
 header.s=dk header.b="pFw/BLna"; 
 dkim=fail reason="signature verification failed"
 header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector2-mediateko365-onmicrosoft-com
 header.b=pyMShI16; 
 arc=fail smtp.remote-ip=60.244.123.138
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=60.244.123.138;
 helo=mailgw01.mediatek.com; envelope-from=macpaul.lin@mediatek.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=mediatek.com
 header.i=@mediatek.com header.a=rsa-sha256 header.s=dk header.b=pFw/BLna; 
 dkim=fail reason="signature verification failed" (1024-bit key,
 unprotected) header.d=mediateko365.onmicrosoft.com
 header.i=@mediateko365.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-mediateko365-onmicrosoft-com header.b=pyMShI16
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C9F2F40A1D
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 17:50:15 +0000 (UTC)
X-UUID: 61e4dd40b84011f1b1788b6acf885367-20260925
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:Content-Transfer-Encoding:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=cgmflvggfrQOKNy2s8k+8JaROwfJ80keSPArl7kpfr4=; 
 b=pFw/BLnaGQsgtFny4BwYkgk5NLH11Qq92sUKdnNcyR3z/XsdJIeO+BbKW9NOQRQbOD42Ymi7n0/Du2rKdYGcRbctS+ATgv0faPf1gaXlrbs/yzMvuLWy/QaYGxBaqM99wjIPJ3jmhikZ4QZRYbKSHUOxPUwrphu6KUV4Swtk7/0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19, REQID:7dc6e993-c2e9-4f2e-b32f-38d1b8a00cb2, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:7db8b62, CLOUDID:6384f108-d10d-41b3-a8f1-bc707284d0ce,
 B
 ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|836|865|888|898,TC:-5,
 Content:0|15|50|99,EDM:-3,IP:nil,URL:99|80|1,File:130,RT:0,Bulk:nil,QS:nil
 ,BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 61e4dd40b84011f1b1788b6acf885367-20260925
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by
 mailgw01.mediatek.com (envelope-from <macpaul.lin@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1448706371; Fri, 25 Sep 2026 01:50:08 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 25 Sep 2026 01:50:07 +0800
Received: from SG2PR04CU009.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Fri, 25 Sep 2026 01:50:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vTodIx6niCgX4f72E24VyJ5vctge3EECq9+N7whRl22IMDvZoFREm8wDrsMG8jJ99LvXjNSE/4esg9H3HAsRbaxpExjQPBSHhA7Yb8BCzGWfKIxS8ytYw+gqSatHLe0WHFwDGk9xThi0BNuRcUTLpRCGAp3VCXZYEGkNVeDTyZvhNSUtS4s4NDK/4Gk8HQgX4a7X4BGtEknZ/XmVEpceafjKp1s5DalZdry/cYuNWyrAPtL2CaOBR8N3exU9n3mEVBWkHjpPxvMe0W1zun+2Z075139PlEi1rVHLlOzOtddgSdO7KGEGwAdGxaHd2DDVWI4n3gzz54DF4sxMLUnMvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nVOGSB2u+ExX4M6qWcfsi8PtSujaLpizX4UgtNFXEEo=;
 b=slSpKF9eJm0v4rZOJ300c02KNPX/i/xlG/ndJviay1yE/ZxS/LVE2zm0pVzDrrbo2wQ7kXojtuPViUWqi805ZeJV76Xr9UwpnzdtYdWEKZzSnYzzdmTIVMgcWtH8fYUZmAgRM0bndFOcQak0uuz1FyzhYQFX7rbz1i/sLvIn488Cwm9OcBQAjIJjwbmk7zA7vQfMii12qFhfSicsoyQMR7/Scd76ea/4pVRLAY+JYPHMBAaLKyJCAX9pCAIQfSwtNkKwoVVfNCAjPgTQP0LwIGqKvSxGfw9S6ddGBT3QV+TZFm+IY5ewD+eM/SWA3WtYdSWqM5v5nFZR4/vs53paCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nVOGSB2u+ExX4M6qWcfsi8PtSujaLpizX4UgtNFXEEo=;
 b=pyMShI16aXdO166yifSJwaBFQmyG82E3q0s9ipwCWqI0780WVlirfkephd1KJVL/qtAPVJ0N858IQW7TnoN6swr/f3M45/1TgZFkAsGXIiD0EKaKo4Kulk6iB/iewLdX2DGSOGgD+YPpEatkwvgDLRQJnfrpvJwBdsZldeP7Yak=
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com (2603:1096:101:184::13)
 by SEYPR03MB7461.apcprd03.prod.outlook.com (2603:1096:101:147::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 17:50:02 +0000
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8]) by SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8%6]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 17:50:02 +0000
From: =?utf-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>
To: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>, Tom Rini
 <trini@konsulko.com>, David Lechner <dlechner@baylibre.com>, Carlo Caione
 <ccaione@baylibre.com>, Julien Stephan <jstephan@baylibre.com>, "Ilias
 Apalodimas" <ilias.apalodimas@linaro.org>, "stanleyjhu@google.com"
 <stanleyjhu@google.com>, "Beanhuo@micron.com" <Beanhuo@micron.com>, "Zhaoxuan
 Zhai" <zhai.zhaoxuan@canonical.com>, Ethan Hsieh <ethan.hsieh@canonical.com>, 
 Jian Hui Lee <jianhui.lee@canonical.com>
CC: "jens.wiklander@linaro.org" <jens.wiklander@linaro.org>,
 "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>,
 "peng.fan@nxp.com" <peng.fan@nxp.com>, "jh80.chung@samsung.com"
 <jh80.chung@samsung.com>, "tanmay.kathpalia@altera.com"
 <tanmay.kathpalia@altera.com>, "neil.armstrong@linaro.org"
 <neil.armstrong@linaro.org>, "bhupesh.linux@gmail.com"
 <bhupesh.linux@gmail.com>, "n-francis@ti.com" <n-francis@ti.com>,
 "xypron.glpk@gmx.de" <xypron.glpk@gmx.de>, "s-vadapalli@ti.com"
 <s-vadapalli@ti.com>, "michal.simek@amd.com" <michal.simek@amd.com>,
 "jbx6244@gmail.com" <jbx6244@gmail.com>,
 =?utf-8?B?QmVhciBXYW5nICjokKnljp/mg5/lvrcp?= <bear.wang@mediatek.com>,
 =?utf-8?B?SHQgTGluICjmnpfngJrlrpcp?= <Ht.Lin@mediatek.com>,
 =?utf-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?= <pablo.sun@mediatek.com>,
 "marek.vasut+renesas@mailbox.org" <marek.vasut+renesas@mailbox.org>,
 "sumit.garg@oss.qualcomm.com" <sumit.garg@oss.qualcomm.com>,
 "jens.wiklander@oss.qualcomm.com" <jens.wiklander@oss.qualcomm.com>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>
Subject: Re: [PATCH v5 0/6] ufs: rpmb: route OP-TEE RPMB secure storage over
 UFS
Thread-Topic: [PATCH v5 0/6] ufs: rpmb: route OP-TEE RPMB secure storage over
 UFS
Thread-Index: AQHdR6lecpJAIPRN1Uqy8oAtLoSMVrbUxYgAgAk9Ra4=
Date: Thu, 24 Sep 2026 17:50:02 +0000
Message-ID: <SEZPR03MB78102F7A1B91EBAA72743B2189812@SEZPR03MB7810.apcprd03.prod.outlook.com>
References: <20260918200641.2286077-1-jorge.ramirez@oss.qualcomm.com>
 <aq2b2AspOcySKRvl@trex>
In-Reply-To: <aq2b2AspOcySKRvl@trex>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7810:EE_|SEYPR03MB7461:EE_
x-ms-office365-filtering-correlation-id: e9b99952-745b-4d08-4aac-08df1a644253
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|7416014|5023799004|56012099006|11063799006|3023799007|4133799003|38070700021|4143699003|18002099003|22082099003|10067099003|6133799003|921020;
x-microsoft-antispam-message-info: ZR08DOT4jkI8FQezSgTL12EV56IjoKb3uLP7QYaJVVNaWMSbuXc1ukvvcl04cMWGndV4UR+dlF49ds67aeKtCtHKG/Cd88HVfaNDBWcYzIV1XpZr9cOhBc2sAYguehPkDuxB7t9VuNF0hkNMCmu5kJYb0l5wuQV7POdQ5/V90iO1vTV0K/FBI7TeGC1f8HY0uzUA5WXmhzWb/EMmADRru0UDBfVd3glPDGEPKB1EhZ5nQQ6BIIVpz1gSDFWAlftrXepIWUbhzE+GCWRrIwuZmhWF37CZv4S3FN4/70Ls3SbWVCJPrGLrrEyIO5XKWXHWBEWlQeipewEOoINEb+E5WrG+kr+1a+fSCJWk2xUSMiVlAXCZs1BUi/sL7awqrn3nErmahP4iQSq393EBb9mCnax9Aa6Waqn4xsxjUmOMeRzc0coLre4toxCJqhwxqBExoYNJRWRQXPOV79kdZQEnV+gs+u0HYq2JTSk1zS9JnqykGeCPLO0F6qtfQg6adhbQdeaES0766Q+ILFAeV4EpQ5fgH3rtE88M4R+o0pf/Tl0wGon8Eq6kZPLI/mjJ3cACU+NiwYHLz47spqoLnKoKrYe7SeH52HMcwcHxOFA6R0nWIhkP4JsMKaxuBFMcRVwgD0cZtK6LyHLuPQwHNsHvxNjjeI6uB019a92+GeGrkxnFHc9YyyHQqL/tP2fGHV+n
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SEZPR03MB7810.apcprd03.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(5023799004)(56012099006)(11063799006)(3023799007)(4133799003)(38070700021)(4143699003)(18002099003)(22082099003)(10067099003)(6133799003)(921020);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?clBGbDlsN0tUQkQ3SnFPQjhqTCtacXFqNnhPNytFUDFGYXlxUXdBM1FhZzBL?=
 =?utf-8?B?VmNpd3FmYVhGYzF0YTZIQm4rUDVtbVNRVFgvMjNzOHdkckJVb0RUVmZIRVAr?=
 =?utf-8?B?MlUzL21IK1Y5elBrZEt0RVRjSG5DWnVSUHZWRWxiUFpzc3hOZ2ZYTlVGbFE0?=
 =?utf-8?B?QzBUUDQ1eVJEZWo1eC9rVHVKaVkweW92ZzBhRklxT1o3Q3FKU2JmRmxneUNQ?=
 =?utf-8?B?MEdYSkpyTmNyUlJ6SnFBSXAwaTNyNnYzZjlMWWFrdlU1K3JhU2JGN0ppdXYr?=
 =?utf-8?B?d2cycWxhZ2t2ZytaZndEbWlKVkVxRWZZYmtMRGdkSjhHRDBGTjJSbXFFYSt2?=
 =?utf-8?B?RCtKMXdmWjVhZHRWTmYxRXJVMWxwYURJd2JjdWY0cTV4ZGUyUEFNd3BVSHFv?=
 =?utf-8?B?Tm0yTWUzQlRET0pYeThWakxrK2pZR0N5R3d6aHBrVFlHM1Q5dzgwSDcydlZ3?=
 =?utf-8?B?YUJPZHpiKzlPeFRhYXd2Vm1xcG5maHFEWHowTGJZdzNabUJEbm5ycVpGMFp0?=
 =?utf-8?B?YVhSY0NpWGw3VU5WRVZkdjg3ZXhYQittWWZ3bUUyNW9uVDRjV0hRZ2Vackl1?=
 =?utf-8?B?aUtmYW1vSnNweUx1OVJFYXl0dWNuVjE3WHVHNEVGc0dyN00xQUVoWnc1UEhL?=
 =?utf-8?B?ckh5NW01UnNQeFAxOVJOakN5M1AvemxQRnFEckduL1llZmpXcWV2Qng0NnM2?=
 =?utf-8?B?V3NYZlRlQU1wTlpaMkVqdkpWWldPc2haU0EzaFV1NWVqWnZ6MnBUa3RxM2xp?=
 =?utf-8?B?NVVPdlBPZ2xtTWgrdEUwRWNOR25yMWZlcHFQdXArUzRpdEVwYWJIOFJLQm1v?=
 =?utf-8?B?akNyZW4zZ29ITWxLSlE3QW9VRDFBdTJCa21BNENUektZTHFYbW5jcVJHNGVW?=
 =?utf-8?B?Ry9RN1htYWZvUUFkeEtFaGczWk1sY0hxN3lsby9ZUDFPRkpCTU14dG5SVWdm?=
 =?utf-8?B?TzFRV25rRnRNN2NuWkpXVHlFRVlwMTI2c2xHaGdIanRZZkg5VVQ5Y2VrUWgz?=
 =?utf-8?B?QmtVbWVaUkhZYVlwb01rMm9BSGtmUER5d3ArcEVGeXhYMGV0ZnNYRC9mU2p3?=
 =?utf-8?B?K3hTcS81YUErWG1UM1lOT1FZY1gwRGJ4ZFNCdzQyejNDcXVPZGMrVGZpVUMw?=
 =?utf-8?B?enNSbGllMys3aWd0M3RqT1lFa2loZHRkOGpPYVJDY0NoS3lJQ0xyNHJHTi9G?=
 =?utf-8?B?OWxpOGpjNnZHZEExcHFORkZZU1U4V2pYTFQzM0tTMTFhNktaYUtKRVVJWXpP?=
 =?utf-8?B?RVBoczNoWmZYZHRyTFh6TEpkSk9KZUs5NGRyakhBWjJ6S2ZzR0tzQXRnWFVU?=
 =?utf-8?B?YWdSMFdxUTZqSVpIUk1hYVloTXVuVnNhVmE0OWtKdGdCWkpwUk1RN2x5S2xF?=
 =?utf-8?B?UjdLTjJxbGUxYVJkbmtUNXNaVEIvWFZjTXpSa3BOcm5ZM21HUlFrYUlnYm1z?=
 =?utf-8?B?MUo0cWNkZmc1a3h1bGlwdHhXcm5DWExXbWs5SnU5QUM0S3ZNRmNJOFJyVU8v?=
 =?utf-8?B?WHN5YjVFYnRrY2IzN0FGN1Z6TDVpTHdNSVVWQUgwbExia3A0bGJvdzdnd1Qw?=
 =?utf-8?B?ZHFPKzB5SUVMT0VKeUZQMlZnN21hN1Azck9RUGo5RUhqbUlyOHZMbzVmU3Yr?=
 =?utf-8?B?cTZGNUtYMDJ3RFVWUjZtUi85aWxNTmZKVldpaUVNajIwNm5KbjQ5VExIaVZ3?=
 =?utf-8?B?ZzNMUkdSSXRnekhuUDVEVGFDTHBiNXdWaXhNNUJlNEh4YnJveVZ2S1dnRTlu?=
 =?utf-8?B?ZXBNbDdSOTk3RTF4MUFCS2RtOEVZQmhQaXB0ckRHZnRBUC9ORjN4Mkwwb0Rt?=
 =?utf-8?B?bDNsSFVCUVo0b1VudUx1NENNWjgzUm9GditaZ2lTaWtWa1Y5bFdSb2F6TkYv?=
 =?utf-8?B?Q1BrVk1jYjVzeWVGbHdmcGdnYnVVY2c3RkNyQkJpN3hjOFdsTW9FNG1CWmlS?=
 =?utf-8?B?RFV1bWFHem5CS2syRGVjRVFuWk11Qk1FVVNoczR2UU0xOXQ1TXYzT0F5dkVq?=
 =?utf-8?B?dHRScThjZVFJY0lhUzExN2ExbXF0RzlUNnAvVE5tandCbEwxUVZIWmdsT1NR?=
 =?utf-8?B?akRnM1ZOYmE0ckVBNlljSTh6bFlHMDQzN1J4WFlnWExoemF0eDhVS3YxWG5h?=
 =?utf-8?B?RmFWaE9jMzNLMGZ2dmdKYU1aUCtuL0NZMm4rOHljSDdBTW8zQmdFS2t1L1VH?=
 =?utf-8?B?RmFDM3ROS296b0tKaWIyemxkOXpJTGtjSmtncnQ2c3BTMHVGQVhoQXZVQXlL?=
 =?utf-8?B?ZzhWbHZIdGh5MklpSlZ3dkxBTzFSTGFCZzdwbm1wQ0llVXdjeXFDNFdBL1d2?=
 =?utf-8?B?ZkRMYmlCTUxZZi9RREl4RXFrRHJjaFprZFEyTUpxQWdUQ21oaC8zZz09?=
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: O8ezbeAf0V+PjY6ZHKUkTURxG3krirAD2gD/JNLfbK4hNZHonWJxMZj/BJxy51k/klM5Ej0Hj0DP3T6HGiezb472hvaA/VCgJvJjEluHyYJovJRmyFMTIfh7ifO0Q9jpsc6i8Ot0AR1S+XHdWR8ieO4PRm5zht2xbRW+PZKKfWjYWRNOfl2ob3+ugJeOqyE8a6AOOpXDCzvrrIRT8oIe2d5Kaj45fVC2uuaJ/nNVLiXAfxR9LtSat4123mGzzmc2GLgUS0+BONDagQo9F96cgOWVTW/0fFS3adXtsdolIh8akhF97RzuDrPFbchhEbw/KbCpoJptGXs4gg8spz6zVQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7810.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9b99952-745b-4d08-4aac-08df1a644253
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2026 17:50:02.1520 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d/31s6TP4K28JbQN7a1CfePDRfAuVFcyahYlTZBXKUP+lKtmtTtEFoyRdKWcH4y6QdcFTskjXFvH2NmwnmqaWPEMAo4E/P7lLj1y6z8qlTM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7461
Content-Type: multipart/alternative;
 boundary="__=_Part_Boundary_003_840162234.1339068595"
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

--__=_Part_Boundary_003_840162234.1339068595
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64

T24gMTgvMDkvMjYgMjI6MDY6MzIsIEpvcmdlIFJhbWlyZXotT3J0aXogd3JvdGU6Cj4gT1AtVEVF
IHNlY3VyZSBzdG9yYWdlIChDRkdfUlBNQl9GUykgcmVsaWVzIG9uIGFuIFJQTUIgcGFydGl0aW9u
LCBidXQKPiBVLUJvb3QncyBPUC1URUUgUlBNQiBzdXBwbGljYW50IG9ubHkgc3BlYWtzIHRoZSBs
ZWdhY3kgc2luZ2xlLWNvbW1hbmQKPiBpbnRlcmZhY2UsIHdoaWNoIGlzIGJvdW5kIHRvIGVNTUMu
IFNvQ3MgdGhhdCBhcmUgVUZTLW9ubHkgYW5kIGhhdmUgbm8KPiBlTU1DIChmb3IgZXhhbXBsZSB0
aGUgUXVhbGNvbW0gU0E4Nzc1UCkgdGhlcmVmb3JlIGNhbm5vdCBiYWNrIE9QLVRFRQo+IHNlY3Vy
ZSBzdG9yYWdlIGZyb20gVS1Cb290IHRvZGF5LiBUaGlzIHNlcmllcyBhZGRzIHRoYXQgc3VwcG9y
dC4KPgo+IEl0IGludHJvZHVjZXMgdGhlIHRyYW5zcG9ydC1hZ25vc3RpYyBPUC1URUUgUlBNQiAi
c3Vic3lzdGVtIiBpbnRlcmZhY2UKPiAoUFJPQkVfUkVTRVQgLyBQUk9CRV9ORVhUIC8gRlJBTUVT
KSwgd2hlcmUgdGhlIG5vcm1hbCB3b3JsZCBlbnVtZXJhdGVzCj4gdGhlIFJQTUIgZGV2aWNlIGFu
ZCByZXBvcnRzIGl0cyBraW5kLCBzaXplIGFuZCBDSUQsIHRoZW4gY2FycmllcyB0aGUKPiBzaWdu
ZWQgZnJhbWVzLiBUaGUgbGVnYWN5IGVNTUMgc3VwcGxpY2FudCBpcyBwcmVzZXJ2ZWQgdW5jaGFu
Z2VkLCBvbmx5Cj4gcmVuYW1lZCB0byBycG1iX2VtbWMuYywgd2l0aCB0aGUgbmV3IFVGUyBiYWNr
ZW5kIGFkZGVkIGFzIGEgc2VwYXJhdGUKPiBycG1iX3Vmcy5jOyB0aGUgdHdvIGFyZSBtdXR1YWxs
eSBleGNsdXNpdmUgdmlhIEtjb25maWcgKFNVUFBPUlRfVUZTX1JQTUIKPiBkZXBlbmRzIG9uICFT
VVBQT1JUX0VNTUNfUlBNQikgYmVjYXVzZSB0aGUgT1AtVEVFIHN1cHBsaWNhbnQgaGFuZGxlcyBh
Cj4gc2luZ2xlIFJQTUIgdHJhbnNwb3J0LiBUaGUgc3Vic3lzdGVtIGludGVyZmFjZSBpcyBVRlMt
b25seSBmb3Igbm93OyBlTU1DCj4gY2FuIGJlIG1pZ3JhdGVkIG9udG8gaXQgbGF0ZXIgYXMgdGhl
IGxlZ2FjeSBwYXRoIGlzIHJldGlyZWQuCj4KPiBPbiB0b3Agb2YgdGhhdCBpdCBhZGRzIGEgVUZT
IFJQTUIgdHJhbnNwb3J0IHRoYXQgbW92ZXMgSkVERUMgUlBNQiBmcmFtZXMKPiB0byBhbmQgZnJv
bSB0aGUgUlBNQiBXZWxsLUtub3duIExVTiB1c2luZyBTQ1NJIFNFQ1VSSVRZIFBST1RPQ09MIElO
L09VVC4KPiBUaGUgcGVyLXJlZ2lvbiAxNi1ieXRlIENJRCBpcyBkZXJpdmVkIGJ5IEJMQUtFMmIt
aGFzaGluZyB0aGUgZXhhY3QKPiBkZXZpY2UtaWQgc3RyaW5nIHRoZSBMaW51eCBrZXJuZWwgYnVp
bGRzICh1ZnNoY2RfY3JlYXRlX2RldmljZV9pZCgpCj4gcGx1cyBhICItUjxyZWdpb24+IiBzdWZm
aXgpLCBzbyBPUC1URUUgZGVyaXZlcyBhbiBSUE1CIGtleSB0aGF0IG1hdGNoZXMKPiB0aGUgb25l
IExpbnV4IHdvdWxkIHVzZS4KPgo+IFRoZSBmaXJzdCBwYXRjaCBpcyBhIHN0YW5kYWxvbmUgVUZT
IGRlc2NyaXB0b3IgZml4IHRoZSBSUE1CIHBhdGggZGVwZW5kcwo+IG9uIChVVEYtMTZCRSBzdHJp
bmcgZGVjb2RpbmcpLiBBIHNtYWxsIHByZXBhcmF0b3J5IHBhdGNoIHN1cmZhY2VzIHRoZQo+IFJF
U1BPTlNFIFVQSVUgc2Vuc2UgZGF0YSBmcm9tIHVmc19zY3NpX2V4ZWMoKSBzbyB0aGUgdHJhbnNw
b3J0IGNhbiByZXRyeQo+IG9ubHkgb24gYSBwb3dlci1vbiBVTklUIEFUVEVOVElPTjsgdGhlIHRy
YW5zcG9ydCBwYXRjaCBhbHNvIGJvdW5jZXMKPiB1bmFsaWduZWQgZnJhbWVzIHRocm91Z2ggYSBE
TUEtYWxpZ25lZCBidWZmZXIgZm9yIHRoZSBSUE1CIFdMVU4uCj4KPiBOb3RlOiByZWFkaW5nIFVG
UyBkZXNjcmlwdG9ycyByZWxpYWJseSBhbHNvIHJlcXVpcmVzIHRoZSBkZXNjcmlwdG9yCj4gZGF0
YS1zZWdtZW50IGNhY2hlLWludmFsaWRhdGlvbiBmaXgsIHdoaWNoIGhhcyBhbHJlYWR5IGJlZW4g
cG9zdGVkIGFuZAo+IG1lcmdlZCBzZXBhcmF0ZWx5LCBzbyB0aGlzIHNlcmllcyBpcyBiYXNlZCBv
biB0b3Agb2YgaXQuCj4KPiBUZXN0ZWQgb24gdGhlIFF1YWxjb21tIElRLTkwNzUtRVZLIChTQTg3
NzVQKTogT1AtVEVFIHdpdGggQ0ZHX1JQTUJfRlMKPiBwcm9ncmFtcyB0aGUgUlBNQiBrZXkgdGhy
b3VnaCBVLUJvb3QgYW5kIHJlYWRzL3dyaXRlcyBzZWN1cmUtc3RvcmFnZQo+IG9iamVjdHMsIHdp
dGggdGhlIGRlcml2ZWQgQ0lEIG1hdGNoaW5nIHRoZSBMaW51eCBVRlMgZGV2aWNlX2lkIEFCSS4K
Pgo+IERlcGVuZGVuY2llczoKPiBMaW51eCBrZXJuZWw6Cj4gwqBodHRwczovL2xvcmUua2VybmVs
Lm9yZy9saW51eC1zY3NpLzIwMjYwNzE2MDgzNzI4LjIyMjY0MjItMS1qb3JnZS5yYW1pcmV6QG9z
cy5xdWFsY29tbS5jb20vCmFjY2VwdGVkIGluIHY0IC0tPiBodHRwczovL2xrbWwub3JnL2xrbWwv
MjAyNi84LzI3LzM2OQoKPiBPcC10ZWUKPiDCoGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19o
dHRwczovL2dpdGh1Yi5jb20vT1AtVEVFL29wdGVlX29zL3B1bGwvNzg4MV9fOyEhQ1RSTktBOXdN
ZzBBUmJ3IWxRNUQ5SVVFMUQ1ZXJxYmFYQ2tsRnVhNkppaWpaWUI2WE4wcTVMREZaWnBpYUdtckhf
azEwckxrY2pVMW5TemhzUkRYLS1KNDlHdDIyRThVNzNseDdFczU2N1RVQXh3WCQKYW5kIGFsc28g
Zm9sbG93aW5nIElsaWFzIHJldmlldyBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6
Ly9naXRodWIuY29tL09QLVRFRS9vcHRlZV9vcy9wdWxsLzgwMDdfXzshIUNUUk5LQTl3TWcwQVJi
dyFsUTVEOUlVRTFENWVycWJhWENrbEZ1YTZKaWlqWllCNlhOMHE1TERGWlpwaWFHbXJIX2sxMHJM
a2NqVTFuU3poc1JEWC0tSjQ5R3QyMkU4VTczbHg3RXM1NjVKRVRHZFEkIMKgKGJvdGggbWVyZ2Vk
KQoKPiBGb3IgcmVmZXJlbmNlLCBhdCB0aGlzIHBvaW50IExpbnV4IGNhbiBhY2Nlc3MgUlBNQiBh
bmQganVzdCB1LWJvb3QgcGVuZGluZyBvbiB0aGlzIHNldC4KSSdkIGxpa2UgdG8gaGF2ZSBzb21l
IGRpc2N1c3Npb24gaW4gbW9yZSBkZXRhaWwgYXMgYmVsb3csIGl0IHdpbGwgYmUgcXVpdGUgbG9u
Zy4gSG93ZXZlciwgbXkgY29tcGFueSdzCmVtYWlsIHNlcnZlciBhbmQgbWFpbCBjbGllbnRzIGJv
dGggaGF2ZSBwcm9ibGVtIGFnYWluIGFzIHVzdWFsLiBJJ20gbm90IHN1cmUgaWYgdGhpcyByZXBs
eSBjb3VsZCBiZSBzZW5kCm91dCBjb3JyZWN0bHkgYW5kIGluIGNvcnJlY3QgZm9ybWF0LiBMZXQn
cyBzZWUuIApNb3Jlb3ZlciwgSSd2ZSBpbnZpdGVkIEtlcm5lbCdzIG1haW50YWluZXJzIFN0YW5s
ZXkgSmh1IGFuZCBCZWFuIEh1byB0byB0aGlzIG1haWwgdGhyZWFkIHRvIHNlZSBpZiB0aGUgb3Bp
bmlvbiBpbmNyZWFzZXMgbW9yZSBjb21wYXRpYmlsaXR5LiAKQnV0LCBJJ20gbm90IHN1cmUgaG93
IHRvIGludml0ZSBPUFRFRSdzIG1haW50YWluZXJzLCBJJ2xsIHRyeSB0byBmb3J3YXJkIHRoZSBm
b2xsb3dpbmcgZGVzY3JpcHRpb24gdG8gT1BURUUgbGF0ZXIuCgpTby4uIGxldCdzIHN0YXJ0IGZy
b20gcGF0Y2ggNC82IGFuZCB0aGVuIHJldmlldyB0aGUgd2hvbGUgc3RvcnkuCjQvNiDigJQgdWZz
OiBkZXJpdmUgdGhlIHBlci1yZWdpb24gUlBNQiBDSUQgYW5kIHNpemUgZm9yIE9QLVRFRQoKUGF0
Y2ggNC82IGhhcmQtY29kZXMgYm90aCB0aGUgaGFzaCBhbGdvcml0aG0gKEJMQUtFMmIpIGFuZCB0
aGUgb3V0cHV0Cmxlbmd0aCAoVUZTX1JQTUJfQ0lEX1NJWkUgPSAxNikgdXNlZCB0byBkZXJpdmUg
dGhlIFJQTUIgQ0lEIGZvciBVRlMKZGV2aWNlcy4gTmVpdGhlciBjaG9pY2UgaXMgbWFuZGF0ZWQg
YnkgYW55IHNwZWNpZmljYXRpb24gdGhlIHNlcmllcwpidWlsZHMgb24gKFVGUy9KRVNEMjIwLCBS
UE1CLCBvciB0aGUgT1AtVEVFL1RFRSBDbGllbnQgQVBJKSwgYW5kCmhhcmQtY29kaW5nIHRoZW0g
Y3JlYXRlcyBhIHJlYWwgY29tcGF0aWJpbGl0eSByaXNrIGZvciBwcm9kdWN0cyB0aGF0CmhhdmUg
YWxyZWFkeSBzaGlwcGVkIHdpdGggYSBkaWZmZXJlbnQsIHZlbmRvci1zcGVjaWZpYyBkZXJpdmF0
aW9uLiBUaGUKQ0lEIGRlcml2YXRpb24gc2hvdWxkIGJlIGZhY3RvcmVkIG91dCBhcyBhIHZlbmRv
ci1zcGVjaWZpYywgYnVpbGQtdGltZQpzZWxlY3RhYmxlIGNvbXBvbmVudCByYXRoZXIgdGhhbiBh
IHNpbmdsZSBmaXhlZCBhbGdvcml0aG0gYmFrZWQgaW50bwpjb21tb24gVUZTIGNvcmUgY29kZS4K
CjEuIE5laXRoZXIgdGhlIFVGUywgUlBNQiwgbm9yIFRFRSBzcGVjaWZpY2F0aW9ucyBtYW5kYXRl
IGEgaGFzaAogICBhbGdvcml0aG0gZm9yIENJRCBkZXJpdmF0aW9uCi0gVGhlIFVGUyBzcGVjaWZp
Y2F0aW9uIChKRVNEMjIwKSBkZWZpbmVzIHRoZSBEZXZpY2UvVW5pdC9HZW9tZXRyeQogIGRlc2Ny
aXB0b3JzIHRoYXQgcGF0Y2ggNC82IHJlYWRzIChtYW51ZmFjdHVyZXIgSUQsIHNwZWMgdmVyc2lv
biwKICBtb2RlbCBzdHJpbmcsIHNlcmlhbCBudW1iZXIsIGRldmljZSB2ZXJzaW9uLCBtYW51ZmFj
dHVyZSBkYXRlLAogIHJlZ2lvbiBzaXplcykg4oCUIGl0IHNheXMgbm90aGluZyBhYm91dCBjb21i
aW5pbmcgdGhlbSBpbnRvIGEgIkNJRCIsCiAgYW5kIGNlcnRhaW5seSBub3RoaW5nIGFib3V0IHdo
aWNoIGhhc2ggZnVuY3Rpb24gdG8gdXNlLgotIFRoZSBSUE1CIGZyYW1lIHByb3RvY29sIGl0c2Vs
ZiAoc3RydWN0IHJwbWJfZnJhbWUgaW4KICBpbmNsdWRlL2xpbnV4L3JwbWIuaCwgYW5kIHRoZSBl
cXVpdmFsZW50IEpFREVDIFJQTUIgZnJhbWUgbGF5b3V0KQogIGhhcyBubyBDSUQgZmllbGQgYXQg
YWxsIOKAlCBDSUQgaXMgcHVyZWx5IGEgaG9zdC1zaWRlL3NlY3VyZS13b3JsZAogIGtleSBtYW5h
Z2VtZW50IGNvbnZlbnRpb24sIG5vdCBwYXJ0IG9mIHRoZSB3aXJlIHByb3RvY29sLgotIFRoZSBH
bG9iYWxQbGF0Zm9ybSBURUUgQ2xpZW50IEFQSSAvIE9QLVRFRSdzIG93biBSUE1CIHN1YnN5c3Rl
bSBSUEMKICBjb250cmFjdCBvbmx5IGRlZmluZXMgdGhhdCBhIGZpeGVkLXNpemUgb3BhcXVlIGJ5
dGUgYnVmZmVyIGlzIHBhc3NlZAogIGFzIHRoZSBkZXZpY2UgaWRlbnRpZmllciDigJQgaXQgZG9l
cyBub3Qgc3BlY2lmeSBob3cgdGhhdCBidWZmZXIncwogIGNvbnRlbnRzIGFyZSBkZXJpdmVkIGZy
b20gdGhlIHVuZGVybHlpbmcgc3RvcmFnZSBkZXZpY2UuCi0gQmVjYXVzZSBubyBzcGVjaWZpY2F0
aW9uIHByZXNjcmliZXMgdGhlIGFsZ29yaXRobSwgdGhpcyBpcwogIGxlZ2l0aW1hdGVseSB2ZW5k
b3Itc3BlY2lmaWMgdGVycml0b3J5LCBhbmQgZGlmZmVyZW50IHZlbmRvcnMg4oCUIG9yCiAgZXZl
biB0aGUgc2FtZSB2ZW5kb3IgYWNyb3NzIHByb2R1Y3QgZ2VuZXJhdGlvbnMg4oCUIG1heSByZWFz
b25hYmx5CiAgY2hvb3NlIGRpZmZlcmVudCBLREZzL2hhc2ggZnVuY3Rpb25zIChCTEFLRTJiLCBT
SEEtMjU2LCBhCiAgdmVuZG9yLXByb3ByaWV0YXJ5IGhhc2gsIG9yIGEgcmF3IG5vbi1oYXNoZWQg
ZW5jb2RpbmcsIGFzIHNlZW4gaW4KICBvdGhlciByZWFsLXdvcmxkIGltcGxlbWVudGF0aW9ucyBv
ZiB0aGlzIHNhbWUgZmVhdHVyZSkuIFRoZSBwYXRjaAogIHNldCBzaG91bGQgbm90IGZvcmNlIG9u
ZSBzcGVjaWZpYyB2ZW5kb3IncyBjaG9pY2UgaW50byBjb21tb24gVUZTCiAgY29yZSBjb2RlIGFz
IHRoZSBvbmx5IG9wdGlvbi4KCjIuIFVGUyBSUE1CIGRvZXMgbm90IG1hbmRhdGUgYSAxNi1ieXRl
IENJRDsgdGhlIHNpemUgc2hvdWxkIGJlIHZhcmlhYmxlCgotIFRoZSAxNi1ieXRlIGxlbmd0aCBp
cyBub3QgZGVyaXZlZCBmcm9tIGFueSBVRlMgb3IgUlBNQiByZXF1aXJlbWVudC4KICBJdCBjb21l
cyBmcm9tIHRoZSBlTU1DIENJRCByZWdpc3RlciAoSkVERUMgSkVTRDg0IENhcmQvRGV2aWNlCiAg
SWRlbnRpZmljYXRpb24gUmVnaXN0ZXIpLCB3aGljaCBpcyBhIGZpeGVkIDEyOC1iaXQgaGFyZHdh
cmUKICByZWdpc3RlciDigJQgYSBwdXJlbHkgZU1NQy1zcGVjaWZpYyBoYXJkd2FyZSBmYWN0Lgot
IExpbnV4IGtlcm5lbCdzIG93biBnZW5lcmljIFJQTUIgYWJzdHJhY3Rpb24gKHN0cnVjdCBycG1i
X2Rlc2NyIGluCiAgaW5jbHVkZS9saW51eC9ycG1iLmgpIGFscmVhZHkgbW9kZWxzIHRoaXMgY29y
cmVjdGx5IGFuZCB0cmVhdHMgdGhlCiAgZGV2aWNlIGlkZW50aWZpZXIgYXMgdmFyaWFibGUtbGVu
Z3RoIGJ5IGRlc2lnbjoKCiAgc3RydWN0IHJwbWJfZGVzY3IgewogICAgICAgICAgZW51bSBycG1i
X3R5cGUgdHlwZTsKICAgICAgICAgIGludCAoKnJvdXRlX2ZyYW1lcykoc3RydWN0IGRldmljZSAq
ZGV2LCB1OCAqcmVxLCB1bnNpZ25lZCBpbnQgcmVxX2xlbiwKICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgdTggKnJlc3AsIHVuc2lnbmVkIGludCByZXNwX2xlbik7CiAgICAgICAgICB1OCAq
ZGV2X2lkOwogICAgICAgICAgc2l6ZV90IGRldl9pZF9sZW47ICAgLyogdmFyaWFibGUsIG5vdCBm
aXhlZCBhdCAxNiAqLwogICAgICAgICAgdTE2IHJlbGlhYmxlX3dyX2NvdW50OwogICAgICAgICAg
dTE2IGNhcGFjaXR5OwogIH07CgogIExpa2V3aXNlLCB0aGUgVUZTLXNwZWNpZmljIGRldmljZSBp
ZGVudGlmaWVyIHRoZSBMaW51eCBrZXJuZWwgYnVpbGRzCiAgaW4gdWZzaGNkX2NyZWF0ZV9kZXZp
Y2VfaWQoKSBpcyBhIHZhcmlhYmxlLWxlbmd0aCBBU0NJSSBzdHJpbmcKICAoIiUwNFgtJTA0WC0l
cy0lcy0lMDRYLSUwNFgiKSwgbm90IGEgZml4ZWQgMTYtYnl0ZSB2YWx1ZS4KLSBQYXRjaCA0LzYg
c2hvdWxkIGZvbGxvdyB0aGUgc2FtZSBwYXR0ZXJuOiBVRlNfUlBNQl9DSURfU0laRSBzaG91bGQK
ICBub3QgYmUgYSBoYXJkICNkZWZpbmUgMTYgYmFrZWQgaW50byBpbmNsdWRlL3Vmcy5oOyB0aGUg
Q0lEIGJ1ZmZlcgogIHNpemUgc2hvdWxkIGJlIGEgcHJvcGVydHkgb2YgdGhlIHNlbGVjdGVkIHZl
bmRvciBiYWNrZW5kIChlLmcuCiAgcmV0dXJuZWQgYWxvbmdzaWRlIHRoZSBkZXJpdmVkIENJRCwg
b3IgZGVjbGFyZWQgcGVyLWJhY2tlbmQpLCBzbwogIHRoYXQgYSAxNi1ieXRlIG91dHB1dCBpcyBv
bmUgdmFsaWQgY2hvaWNlIGFtb25nIG90aGVycyByYXRoZXIgdGhhbgogIGFuIGFzc3VtZWQgdW5p
dmVyc2FsIGNvbnN0YW50LgoKMy4gVGhlIHZlbmRvci1zcGVjaWZpYyBwYXJ0IHNob3VsZCBiZSBm
YWN0b3JlZCBvdXQ7IDE2IGJ5dGVzIGlzIG9ubHkKICAgdGhlcmUgZm9yIGVNTUMgY29tcGF0aWJp
bGl0eSwgYW5kIFVGUyBoYXMgbm8gc3VjaCBoYXJkd2FyZSBDSUQgYXQgYWxsCgotIFRvIHJlc3Rh
dGUgdGhlIGNvcmUgcHJvYmxlbSBwbGFpbmx5OiBVRlMgaGFzIG5vIENJRCByZWdpc3Rlci4KICBU
aGVyZSBpcyBubyBwaWVjZSBvZiBVRlMgaGFyZHdhcmUgdGhhdCBwYXRjaCA0LzYncwogIHVmc19y
cG1iX2J1aWxkX2NpZCgpIGlzICJyZWFkaW5nIiDigJQgaXQgaXMgZW50aXJlbHkgYSBzb2Z0d2Fy
ZQogIGNvbnN0cnVjdGlvbi4gVGhlIG9ubHkgcmVhc29uIHRoZSByZXN1bHQgaXMgc3F1ZWV6ZWQg
aW50byAxNiBieXRlcwogIGlzIHRvIGZpdCB0aGUgcHJlLWV4aXN0aW5nIE9QLVRFRSBSUEMgYnVm
ZmVyIHNpemUgdGhhdCB3YXMKICBvcmlnaW5hbGx5IGRlc2lnbmVkIGFyb3VuZCBlTU1DJ3MgcmVh
bCwgaGFyZHdhcmUtZGVmaW5lZCAxNi1ieXRlIENJRAogIHJlZ2lzdGVyLgotIENvbmZsYXRpbmcg
InRoZSBVRlMtc3BlY2lmaWMgZGVzY3JpcHRvci1yZWFkaW5nL3N0cmluZy1idWlsZGluZwogIGxv
Z2ljIiB3aXRoICJ0aGUgc3BlY2lmaWMgaGFzaCBmdW5jdGlvbiBhbmQgb3V0cHV0IGxlbmd0aCBj
aG9pY2UiCiAgaW4gYSBzaW5nbGUgbm9uLWNvbmZpZ3VyYWJsZSBmdW5jdGlvbiBtZWFucyBldmVy
eSBkb3duc3RyZWFtIHVzZXIgb2YKICB0aGlzIHNlcmllcyBpbmhlcml0cyBvbmUgdmVuZG9yJ3Mg
YWxnb3JpdGhtIGNob2ljZSB3aXRoIG5vIHdheSB0bwogIG9wdCBvdXQsIGV2ZW4gdGhvdWdoIHRo
ZSB0d28gY29uY2VybnMgYXJlIGxvZ2ljYWxseSBzZXBhcmFibGU6CiAgLSBSZWFkaW5nIFVGUyBk
ZXNjcmlwdG9ycyBhbmQgYnVpbGRpbmcgdGhlIGlucHV0IGlkZW50aWZpZXIgc3RyaW5nCiAgICBp
cyBjb21tb24sIHNwZWMtZHJpdmVuIGxvZ2ljIHRoYXQgY2FuIHN0YXkgaW4gc2hhcmVkIFVGUyBj
b3JlCiAgICBjb2RlLgogIC0gVHVybmluZyB0aGF0IHN0cmluZyBpbnRvIHRoZSBhY3R1YWwgQ0lE
IGJ5dGVzIGhhbmRlZCB0byBPUC1URUUgaXMKICAgIHRoZSB2ZW5kb3Itc3BlY2lmaWMgcGFydCBh
bmQgc2hvdWxkIGJlIHBsdWdnYWJsZS4KLSBTdWdnZXN0ZWQgcmVzdHJ1Y3R1cmluZzoga2VlcCB1
ZnNoY2Qtc2lkZSBkZXNjcmlwdG9yIHJlYWRzIGFuZAogIHN0cmluZy1idWlsZGluZyBpbiBjb21t
b24gY29kZSwgYnV0IGV4cG9zZSB0aGUgZmluYWwKICBzdHJpbmctdG8tQ0lEIHN0ZXAgYXMgYSBy
ZXBsYWNlYWJsZSBob29rL3dlYWsgZnVuY3Rpb24gKG9yIGEgc21hbGwKICB2ZW5kb3Igb3BzIHRh
YmxlKSwgc28gdGhlIEJMQUtFMmIgaW1wbGVtZW50YXRpb24gaW4gdGhpcyBzZXJpZXMKICBiZWNv
bWVzIHRoZSBkZWZhdWx0IGJhY2tlbmQgcmF0aGVyIHRoYW4gdGhlIG9ubHkgYmFja2VuZC4KCjQu
IEhhcmQtY29kaW5nIG9uZSBhbGdvcml0aG0gY3JlYXRlcyByZWFsIGZpcm13YXJlLXVwZ3JhZGUg
YW5kCiAgIGtleS1jb21wYXRpYmlsaXR5IHJpc2sgZm9yIGFscmVhZHktc2hpcHBpbmcgcHJvZHVj
dHMsIHNvIHRoZQogICBkZXJpdmF0aW9uIG11c3QgYmUgdmVuZG9yLXNlbGVjdGFibGUgYXQgYnVp
bGQgdGltZSAodmlhIGRlZmNvbmZpZykKCjUuIFNpbmNlIG5laXRoZXIgdGhlIGFsZ29yaXRobSAo
cG9pbnQgMSkgbm9yIHRoZSBvdXRwdXQgbGVuZ3RoIChwb2ludCAyKQogIGlzIHNwZWNpZmllZCBi
eSBhbnkgc3RhbmRhcmQsIGFuZCBDSUQgaXMgcHVyZWx5IGEgc29mdHdhcmUKICBjb252ZW50aW9u
IGludmVudGVkIHRvIHJldXNlIGFuIGVNTUMtc2hhcGVkIE9QLVRFRSBBQkkgKHBvaW50IDMpLAog
IGRpZmZlcmVudCBpbXBsZW1lbnRhdGlvbnMgdGhhdCBhbHJlYWR5IGV4aXN0IHRvZGF5IGhhdmUg
bWFkZQogIGRpZmZlcmVudCwgaW5jb21wYXRpYmxlIGNob2ljZXMgZm9yIHRoZSBzYW1lIHByb2Js
ZW06CiAgLSBUaGlzIHNlcmllcyAodXBzdHJlYW0gdjUsIHBhdGNoIDQvNik6IGJ1aWxkcyBhbiBp
ZGVudGlmaWVyIHN0cmluZwogICAgZnJvbSBEZXZpY2UgRGVzY3JpcHRvciBmaWVsZHMgKG1hbnVm
YWN0dXJlciBJRCwgc3BlYyB2ZXJzaW9uLAogICAgbW9kZWwsIHNlcmlhbCwgZGV2aWNlIHZlcnNp
b24sIG1hbnVmYWN0dXJlIGRhdGUpIGFuZCBoYXNoZXMgaXQKICAgIHdpdGggQkxBS0UyYiB0byBh
IGZpeGVkIDE2LWJ5dGUgb3V0cHV0LgogIC0gQXQgbGVhc3Qgb25lIG90aGVyIHJlYWwsIHNoaXBw
aW5nIGRvd25zdHJlYW0gaW1wbGVtZW50YXRpb24gKGEKICAgIHZlbmRvcidzIHByb2R1Y3Rpb24g
VS1Cb290IGJyYW5jaCBhbmFseXplZCBhbG9uZ3NpZGUgdGhpcyBzZXJpZXMpCiAgICBkZXJpdmVz
IHRoZSBDSUQgYnkgZGlyZWN0bHkgZGVjb2RpbmcvcG9ydGluZyB0aGUgZGV2aWNlJ3MKICAgIHRl
ZS1zdXBwbGljYW50LXNpZGUgcmVhZF9jaWQoKS1zdHlsZSBsb2dpYyDigJQgaS5lLiBubyBoYXNo
IGF0IGFsbCwKICAgIGp1c3QgYSBkaXJlY3QgYnl0ZSBlbmNvZGluZyBvZiB0aGUgc2VyaWFsLW51
bWJlciBzdHJpbmcKICAgIGRlc2NyaXB0b3IuCiAgLSBCb3RoIGFwcHJvYWNoZXMgYXJlIGVxdWFs
bHkgInZhbGlkIiBpbiB0aGUgc2Vuc2UgdGhhdCBuZWl0aGVyCiAgICB2aW9sYXRlcyBhbnkgc3Bl
Y2lmaWNhdGlvbiwgYmVjYXVzZSBub25lIGV4aXN0cyB0byB2aW9sYXRlIOKAlCBidXQKICAgIHRo
ZXkgYXJlIG11dHVhbGx5IGluY29tcGF0aWJsZTogdGhlIHNhbWUgcGh5c2ljYWwgVUZTIGRldmlj
ZSB3aWxsCiAgICBwcm9kdWNlIGEgZGlmZmVyZW50IDE2LWJ5dGUgdmFsdWUgdW5kZXIgZWFjaCBz
Y2hlbWUsIGFuZAogICAgdGhlcmVmb3JlIE9QLVRFRSB3aWxsIGRlcml2ZSBhIGRpZmZlcmVudCBm
aW5hbCBSUE1CIGF1dGhlbnRpY2F0aW9uCiAgICBrZXkgdW5kZXIgZWFjaCBzY2hlbWUuCi0gVGhl
IHByYWN0aWNhbCBjb25zZXF1ZW5jZTogYW55IHByb2R1Y3QgdGhhdCBoYXMgYWxyZWFkeSBzaGlw
cGVkIGluCiAgdGhlIGZpZWxkIHdpdGggb25lIENJRC1kZXJpdmF0aW9uIHNjaGVtZSAod2hldGhl
ciB0aGF0IGlzIHRoaXMKICBzZXJpZXMncyBCTEFLRTJiIGFwcHJvYWNoIG9yIGEgdmVuZG9yJ3Mg
b3duIHByZS1leGlzdGluZyBzY2hlbWUpIGhhcwogIGVmZmVjdGl2ZWx5IGJ1cm5lZCB0aGF0IHNj
aGVtZSBpbnRvIGl0cyBwcm92aXNpb25lZCBSUE1CIGtleQogIG1hdGVyaWFsLiBJZiBhIGZpcm13
YXJlIHVwZGF0ZSBsYXRlciByZXBsYWNlcyB0aGUgYm9vdGxvYWRlci9PUC1URUUKICBSUE1CIGds
dWUgd2l0aCBhIGJ1aWxkIHRoYXQgaGFyZC1jb2RlcyBhIGRpZmZlcmVudCBDSUQgZGVyaXZhdGlv
bgogIChmb3IgZXhhbXBsZSwgYWRvcHRpbmcgdGhpcyBwYXRjaCBzZXQncyBCTEFLRTJiIGltcGxl
bWVudGF0aW9uCiAgdW5jb25kaXRpb25hbGx5IG9uIHRvcCBvZiBhIHByb2R1Y3QgdGhhdCBzaGlw
cGVkIHdpdGggYSBkaWZmZXJlbnQKICB2ZW5kb3Igc2NoZW1lKSwgdGhlIG5ld2x5LWRlcml2ZWQg
Q0lEIHdpbGwgbm90IG1hdGNoIHRoZSBDSUQgdXNlZAogIHdoZW4gdGhlIGRldmljZSdzIFJQTUIg
a2V5IG1hdGVyaWFsIHdhcyBvcmlnaW5hbGx5IHByb3Zpc2lvbmVkLiBUaGUKICBkZXZpY2Ugd2ls
bCB0aGVuIGVpdGhlcjoKICAtIGZhaWwgdG8gYXV0aGVudGljYXRlIGFnYWluc3QgaXRzIG93biBS
UE1CIHBhcnRpdGlvbiAoT1AtVEVFCiAgICBkZXJpdmVzIGEga2V5IHRoYXQgZG9lc24ndCBtYXRj
aCB3aGF0IHdhcyBwcm92aXNpb25lZCksIG9yCiAgLSBzaWxlbnRseSBiZWdpbiBkZXJpdmluZyBh
IGRpZmZlcmVudCBrZXkgdGhhbiBiZWZvcmUsIHdoaWNoIGlzCiAgICBqdXN0IGFzIGJhZCBpZiBh
bnkgc2VjdXJlLXN0b3JhZ2UgZGF0YSB3YXMgcHJvdmlzaW9uZWQgdW5kZXIgdGhlCiAgICBvbGQg
a2V5IGFuZCBtdXN0IHJlbWFpbiByZWFkYWJsZSBhZnRlciB0aGUgdXBncmFkZS4KCiAgQmVjYXVz
ZSBDSUQgZGVyaXZhdGlvbiBoYXBwZW5zIGRlZXAgaW5zaWRlIGZpcm13YXJlL3NlY3VyZS13b3Js
ZAogIGJvb3QgY29kZSB3aXRoIG5vIHVzZXItdmlzaWJsZSBlcnJvciBzdXJmYWNlIHVudGlsIHRo
ZSBSUE1CIEhNQUMKICBjaGVjayBhY3R1YWxseSBmYWlscywgdGhpcyBjbGFzcyBvZiBidWcgaXMg
ZXNzZW50aWFsbHkgdW5kZXRlY3RhYmxlCiAgaW4gbm9ybWFsIHRlc3RpbmcgYW5kIG9ubHkgc3Vy
ZmFjZXMgYXMgZmllbGQgZmFpbHVyZXMgYWZ0ZXIgYW4KICB1cGdyYWRlIOKAlCBleGFjdGx5IHRo
ZSAic2lsZW50LCB1bmRldGVjdGFibGUgdW50aWwgaXQgZmFpbHMiIGZhaWx1cmUKICBtb2RlIGFs
cmVhZHkgY2FsbGVkIG91dCBpbiB0aGUgQ0lEIGFwcGVuZGl4LgotIFRoZXJlZm9yZSwgdGhlIGZp
eCBpcyBub3QgbWVyZWx5IGEgZG9jdW1lbnRhdGlvbi9jb21tZW50IGNoYW5nZToKICB0aGUgcGF0
Y2ggc2V0IHNob3VsZCBzaGlwIHRoaXMgY29uY2VybiBhcyBhIGJ1aWxkLXRpbWUgKEtjb25maWcg
LwogIGRlZmNvbmZpZykgc2VsZWN0YWJsZSBvcHRpb24sIGUuZy46CgogIGNvbmZpZyBVRlNfUlBN
Ql9DSURfQUxHT19CTEFLRTJCCiAgICAgICAgICBzdHJpbmcgIlVGUyBSUE1CIENJRCBkZXJpdmF0
aW9uIGFsZ29yaXRobSIKICAgICAgICAgIGRlcGVuZHMgb24gU1VQUE9SVF9VRlNfUlBNQgogICAg
ICAgICAgZGVmYXVsdCAiYmxha2UyYiIKICAgICAgICAgIGhlbHAKICAgICAgICAgICAgU2VsZWN0
cyB3aGljaCBhbGdvcml0aG0gZGVyaXZlcyB0aGUgcGVyLXJlZ2lvbiBSUE1CIENJRAogICAgICAg
ICAgICBmcm9tIFVGUyBkZXZpY2UgZGVzY3JpcHRvcnMuIFRoaXMgdmFsdWUgaXMgYSBzb2Z0d2Fy
ZQogICAgICAgICAgICBjb252ZW50aW9uIHdpdGggbm8gYmFzaXMgaW4gdGhlIFVGUyBvciBSUE1C
IHNwZWNpZmljYXRpb24KICAgICAgICAgICAgKFVGUyBoYXMgbm8gaGFyZHdhcmUgQ0lEIHJlZ2lz
dGVyKTsgaXQgZXhpc3RzIG9ubHkgdG8KICAgICAgICAgICAgcG9wdWxhdGUgdGhlIGZpeGVkLXNp
emUgQ0lEIGZpZWxkIGluaGVyaXRlZCBmcm9tIHRoZQogICAgICAgICAgICBlTU1DLW9yaWVudGVk
IE9QLVRFRSBSUE1CIEFCSS4gUHJvZHVjdHMgdGhhdCBoYXZlIGFscmVhZHkKICAgICAgICAgICAg
c2hpcHBlZCB3aXRoIGEgc3BlY2lmaWMgQ0lEIGRlcml2YXRpb24gTVVTVCBrZWVwIHVzaW5nCiAg
ICAgICAgICAgIHRoYXQgc2FtZSBkZXJpdmF0aW9uIGFjcm9zcyBmaXJtd2FyZSB1cGRhdGVzLCBv
ciB0aGUKICAgICAgICAgICAgZGVyaXZlZCBSUE1CIGF1dGhlbnRpY2F0aW9uIGtleSB3aWxsIGNo
YW5nZSBhbmQgZXhpc3RpbmcKICAgICAgICAgICAgUlBNQi1iYWNrZWQgc2VjdXJlIHN0b3JhZ2Ug
d2lsbCBiZWNvbWUgdW5yZWFkYWJsZS4KCiAgd2l0aCB0aGUgQkxBS0UyYiBpbXBsZW1lbnRhdGlv
biBpbiB0aGlzIHNlcmllcyB3aXJlZCBpbiBhcyBvbmUKICBzZWxlY3RhYmxlIGJhY2tlbmQgKENP
TkZJR19VRlNfUlBNQl9DSURfQUxHT19CTEFLRTJCKSwgc28gdGhhdCBhCiAgdmVuZG9yIGFscmVh
ZHkgc2hpcHBpbmcgYSBkaWZmZXJlbnQgc2NoZW1lIGNhbiBzZWxlY3QgdGhlaXIgb3duCiAgYmFj
a2VuZCBhdCBkZWZjb25maWcgdGltZSBpbnN0ZWFkIG9mIGJlaW5nIGZvcmNlZCBvbnRvIHRoaXMK
ICBzZXJpZXMncyBkZWZhdWx0IGFuZCBicmVha2luZyBhbHJlYWR5LXByb3Zpc2lvbmVkIGRldmlj
ZXMgb24KICB1cGdyYWRlLgoKRWFjaCB2ZW5kb3Igc2hvdWxkIGJlIGFibGUgdG8gdXBzdHJlYW0g
dGhlaXIgb3duIGFsZ28gYW5kIG1vcmUuCkFuZCB0aGVzZSBhbGdvIHNob3VsZCBiZSBjb25maWd1
cmFibGUgYnkgdGhlIHVzZXJzIG9yIGJ5IGJvYXJkIG1ha2Vycy4KRm9yIGV4YW1wbGUsIE1lZGlh
VGVrIGFuZCBVYnVudHUgYXJlIHVzaW5nIGRpZmZlcmVudCBhbGdvIGFuZCBDSUQgbGVuZ3RoIGZv
cgpVRlMgUlBNQi4KCkhlcmUgd2Ugc3VnZ2VzdCB0byBtYWtlIHNvbWUgY2hhbmdlIHRvIGluY3Jl
YXNlIHRoZSBjb21wYXRpYmlsaXR5LgoKMS4gU3BsaXQgdWZzX3JwbWJfYnVpbGRfY2lkKCkgaW50
byAoYSkgYSBjb21tb24gaGVscGVyIHRoYXQgcmVhZHMgdGhlCiAgIFVGUyBkZXNjcmlwdG9ycyBh
bmQgYnVpbGRzIHRoZSBpZGVudGlmaWVyIHN0cmluZywgYW5kIChiKSBhCiAgIHBsdWdnYWJsZSBz
dHJpbmctdG8tQ0lEIGJhY2tlbmQsIHdpdGggQkxBS0UyYiBhcyB0aGUgZGVmYXVsdAogICBiYWNr
ZW5kIHJhdGhlciB0aGFuIHRoZSBvbmx5IG9uZS4KMi4gTWFrZSB0aGUgQ0lEIGJ1ZmZlciBzaXpl
IGEgdmFyaWFibGUgc2l6ZSwgb3IgYXQgbGVhc3QgcHJvcGVydHkgcmV0dXJuZWQgYnkgdGhlIHNl
bGVjdGVkCiAgIGJhY2tlbmQgcmF0aGVyIHRoYW4gYSBmaXhlZCBVRlNfUlBNQl9DSURfU0laRSA9
IDE2IGNvbnN0YW50IGluCiAgIGNvbW1vbiBjb2RlLgozLiBBZGQgYSBLY29uZmlnIGNob2ljZSAo
ZS5nLiBVRlNfUlBNQl9DSURfQUxHT19CTEFLRTIpIHNvIHZlbmRvcnMgY2FuCiAgIHNlbGVjdCB0
aGVpciBleGlzdGluZy9sZWdhY3kgQ0lEIGRlcml2YXRpb24gYXQgZGVmY29uZmlnIHRpbWUuCjQu
IERvY3VtZW50IGV4cGxpY2l0bHksIGluIGNvZGUgY29tbWVudHMgYW5kIEtjb25maWcgaGVscCB0
ZXh0LCB0aGF0CiAgIHRoaXMgdmFsdWUgaXMgYSBzb2Z0d2FyZSBBQkkgY29udmVudGlvbiB3aXRo
IG5vIGJhc2lzIGluIHRoZSBVRlMKICAgb3IgUlBNQiBzcGVjaWZpY2F0aW9uLCBhbmQgdGhhdCBj
aGFuZ2luZyBpdCBvbiBhbiBhbHJlYWR5LXNoaXBwZWQKICAgcHJvZHVjdCBpcyBhIGJyZWFraW5n
IGNoYW5nZSB0byB0aGF0IHByb2R1Y3QncyBSUE1CIGtleSBtYXRlcmlhbC4KClRoYW5rcwpNYWNw
YXVsIExpbg==

--__=_Part_Boundary_003_840162234.1339068595
Content-Type: text/html;
	charset="utf-8"
Content-Transfer-Encoding: base64

PGh0bWw+PGJvZHk+PHA+DQo8cHJlPg0KT24mIzMyOzE4LzA5LzI2JiMzMjsyMjowNjozMiwmIzMy
O0pvcmdlJiMzMjtSYW1pcmV6LU9ydGl6JiMzMjt3cm90ZToKJmd0OyYjMzI7T1AtVEVFJiMzMjtz
ZWN1cmUmIzMyO3N0b3JhZ2UmIzMyOyhDRkdfUlBNQl9GUykmIzMyO3JlbGllcyYjMzI7b24mIzMy
O2FuJiMzMjtSUE1CJiMzMjtwYXJ0aXRpb24sJiMzMjtidXQKJmd0OyYjMzI7VS1Cb290JiMzOTtz
JiMzMjtPUC1URUUmIzMyO1JQTUImIzMyO3N1cHBsaWNhbnQmIzMyO29ubHkmIzMyO3NwZWFrcyYj
MzI7dGhlJiMzMjtsZWdhY3kmIzMyO3NpbmdsZS1jb21tYW5kCiZndDsmIzMyO2ludGVyZmFjZSwm
IzMyO3doaWNoJiMzMjtpcyYjMzI7Ym91bmQmIzMyO3RvJiMzMjtlTU1DLiYjMzI7U29DcyYjMzI7
dGhhdCYjMzI7YXJlJiMzMjtVRlMtb25seSYjMzI7YW5kJiMzMjtoYXZlJiMzMjtubwomZ3Q7JiMz
MjtlTU1DJiMzMjsoZm9yJiMzMjtleGFtcGxlJiMzMjt0aGUmIzMyO1F1YWxjb21tJiMzMjtTQTg3
NzVQKSYjMzI7dGhlcmVmb3JlJiMzMjtjYW5ub3QmIzMyO2JhY2smIzMyO09QLVRFRQomZ3Q7JiMz
MjtzZWN1cmUmIzMyO3N0b3JhZ2UmIzMyO2Zyb20mIzMyO1UtQm9vdCYjMzI7dG9kYXkuJiMzMjtU
aGlzJiMzMjtzZXJpZXMmIzMyO2FkZHMmIzMyO3RoYXQmIzMyO3N1cHBvcnQuCiZndDsKJmd0OyYj
MzI7SXQmIzMyO2ludHJvZHVjZXMmIzMyO3RoZSYjMzI7dHJhbnNwb3J0LWFnbm9zdGljJiMzMjtP
UC1URUUmIzMyO1JQTUImIzMyOyZxdW90O3N1YnN5c3RlbSZxdW90OyYjMzI7aW50ZXJmYWNlCiZn
dDsmIzMyOyhQUk9CRV9SRVNFVCYjMzI7LyYjMzI7UFJPQkVfTkVYVCYjMzI7LyYjMzI7RlJBTUVT
KSwmIzMyO3doZXJlJiMzMjt0aGUmIzMyO25vcm1hbCYjMzI7d29ybGQmIzMyO2VudW1lcmF0ZXMK
Jmd0OyYjMzI7dGhlJiMzMjtSUE1CJiMzMjtkZXZpY2UmIzMyO2FuZCYjMzI7cmVwb3J0cyYjMzI7
aXRzJiMzMjtraW5kLCYjMzI7c2l6ZSYjMzI7YW5kJiMzMjtDSUQsJiMzMjt0aGVuJiMzMjtjYXJy
aWVzJiMzMjt0aGUKJmd0OyYjMzI7c2lnbmVkJiMzMjtmcmFtZXMuJiMzMjtUaGUmIzMyO2xlZ2Fj
eSYjMzI7ZU1NQyYjMzI7c3VwcGxpY2FudCYjMzI7aXMmIzMyO3ByZXNlcnZlZCYjMzI7dW5jaGFu
Z2VkLCYjMzI7b25seQomZ3Q7JiMzMjtyZW5hbWVkJiMzMjt0byYjMzI7cnBtYl9lbW1jLmMsJiMz
Mjt3aXRoJiMzMjt0aGUmIzMyO25ldyYjMzI7VUZTJiMzMjtiYWNrZW5kJiMzMjthZGRlZCYjMzI7
YXMmIzMyO2EmIzMyO3NlcGFyYXRlCiZndDsmIzMyO3JwbWJfdWZzLmM7JiMzMjt0aGUmIzMyO3R3
byYjMzI7YXJlJiMzMjttdXR1YWxseSYjMzI7ZXhjbHVzaXZlJiMzMjt2aWEmIzMyO0tjb25maWcm
IzMyOyhTVVBQT1JUX1VGU19SUE1CCiZndDsmIzMyO2RlcGVuZHMmIzMyO29uJiMzMjshU1VQUE9S
VF9FTU1DX1JQTUIpJiMzMjtiZWNhdXNlJiMzMjt0aGUmIzMyO09QLVRFRSYjMzI7c3VwcGxpY2Fu
dCYjMzI7aGFuZGxlcyYjMzI7YQomZ3Q7JiMzMjtzaW5nbGUmIzMyO1JQTUImIzMyO3RyYW5zcG9y
dC4mIzMyO1RoZSYjMzI7c3Vic3lzdGVtJiMzMjtpbnRlcmZhY2UmIzMyO2lzJiMzMjtVRlMtb25s
eSYjMzI7Zm9yJiMzMjtub3c7JiMzMjtlTU1DCiZndDsmIzMyO2NhbiYjMzI7YmUmIzMyO21pZ3Jh
dGVkJiMzMjtvbnRvJiMzMjtpdCYjMzI7bGF0ZXImIzMyO2FzJiMzMjt0aGUmIzMyO2xlZ2FjeSYj
MzI7cGF0aCYjMzI7aXMmIzMyO3JldGlyZWQuCiZndDsKJmd0OyYjMzI7T24mIzMyO3RvcCYjMzI7
b2YmIzMyO3RoYXQmIzMyO2l0JiMzMjthZGRzJiMzMjthJiMzMjtVRlMmIzMyO1JQTUImIzMyO3Ry
YW5zcG9ydCYjMzI7dGhhdCYjMzI7bW92ZXMmIzMyO0pFREVDJiMzMjtSUE1CJiMzMjtmcmFtZXMK
Jmd0OyYjMzI7dG8mIzMyO2FuZCYjMzI7ZnJvbSYjMzI7dGhlJiMzMjtSUE1CJiMzMjtXZWxsLUtu
b3duJiMzMjtMVU4mIzMyO3VzaW5nJiMzMjtTQ1NJJiMzMjtTRUNVUklUWSYjMzI7UFJPVE9DT0wm
IzMyO0lOL09VVC4KJmd0OyYjMzI7VGhlJiMzMjtwZXItcmVnaW9uJiMzMjsxNi1ieXRlJiMzMjtD
SUQmIzMyO2lzJiMzMjtkZXJpdmVkJiMzMjtieSYjMzI7QkxBS0UyYi1oYXNoaW5nJiMzMjt0aGUm
IzMyO2V4YWN0CiZndDsmIzMyO2RldmljZS1pZCYjMzI7c3RyaW5nJiMzMjt0aGUmIzMyO0xpbnV4
JiMzMjtrZXJuZWwmIzMyO2J1aWxkcyYjMzI7KHVmc2hjZF9jcmVhdGVfZGV2aWNlX2lkKCkKJmd0
OyYjMzI7cGx1cyYjMzI7YSYjMzI7JnF1b3Q7LVImbHQ7cmVnaW9uJmd0OyZxdW90OyYjMzI7c3Vm
Zml4KSwmIzMyO3NvJiMzMjtPUC1URUUmIzMyO2Rlcml2ZXMmIzMyO2FuJiMzMjtSUE1CJiMzMjtr
ZXkmIzMyO3RoYXQmIzMyO21hdGNoZXMKJmd0OyYjMzI7dGhlJiMzMjtvbmUmIzMyO0xpbnV4JiMz
Mjt3b3VsZCYjMzI7dXNlLgomZ3Q7CiZndDsmIzMyO1RoZSYjMzI7Zmlyc3QmIzMyO3BhdGNoJiMz
MjtpcyYjMzI7YSYjMzI7c3RhbmRhbG9uZSYjMzI7VUZTJiMzMjtkZXNjcmlwdG9yJiMzMjtmaXgm
IzMyO3RoZSYjMzI7UlBNQiYjMzI7cGF0aCYjMzI7ZGVwZW5kcwomZ3Q7JiMzMjtvbiYjMzI7KFVU
Ri0xNkJFJiMzMjtzdHJpbmcmIzMyO2RlY29kaW5nKS4mIzMyO0EmIzMyO3NtYWxsJiMzMjtwcmVw
YXJhdG9yeSYjMzI7cGF0Y2gmIzMyO3N1cmZhY2VzJiMzMjt0aGUKJmd0OyYjMzI7UkVTUE9OU0Um
IzMyO1VQSVUmIzMyO3NlbnNlJiMzMjtkYXRhJiMzMjtmcm9tJiMzMjt1ZnNfc2NzaV9leGVjKCkm
IzMyO3NvJiMzMjt0aGUmIzMyO3RyYW5zcG9ydCYjMzI7Y2FuJiMzMjtyZXRyeQomZ3Q7JiMzMjtv
bmx5JiMzMjtvbiYjMzI7YSYjMzI7cG93ZXItb24mIzMyO1VOSVQmIzMyO0FUVEVOVElPTjsmIzMy
O3RoZSYjMzI7dHJhbnNwb3J0JiMzMjtwYXRjaCYjMzI7YWxzbyYjMzI7Ym91bmNlcwomZ3Q7JiMz
Mjt1bmFsaWduZWQmIzMyO2ZyYW1lcyYjMzI7dGhyb3VnaCYjMzI7YSYjMzI7RE1BLWFsaWduZWQm
IzMyO2J1ZmZlciYjMzI7Zm9yJiMzMjt0aGUmIzMyO1JQTUImIzMyO1dMVU4uCiZndDsKJmd0OyYj
MzI7Tm90ZTomIzMyO3JlYWRpbmcmIzMyO1VGUyYjMzI7ZGVzY3JpcHRvcnMmIzMyO3JlbGlhYmx5
JiMzMjthbHNvJiMzMjtyZXF1aXJlcyYjMzI7dGhlJiMzMjtkZXNjcmlwdG9yCiZndDsmIzMyO2Rh
dGEtc2VnbWVudCYjMzI7Y2FjaGUtaW52YWxpZGF0aW9uJiMzMjtmaXgsJiMzMjt3aGljaCYjMzI7
aGFzJiMzMjthbHJlYWR5JiMzMjtiZWVuJiMzMjtwb3N0ZWQmIzMyO2FuZAomZ3Q7JiMzMjttZXJn
ZWQmIzMyO3NlcGFyYXRlbHksJiMzMjtzbyYjMzI7dGhpcyYjMzI7c2VyaWVzJiMzMjtpcyYjMzI7
YmFzZWQmIzMyO29uJiMzMjt0b3AmIzMyO29mJiMzMjtpdC4KJmd0OwomZ3Q7JiMzMjtUZXN0ZWQm
IzMyO29uJiMzMjt0aGUmIzMyO1F1YWxjb21tJiMzMjtJUS05MDc1LUVWSyYjMzI7KFNBODc3NVAp
OiYjMzI7T1AtVEVFJiMzMjt3aXRoJiMzMjtDRkdfUlBNQl9GUwomZ3Q7JiMzMjtwcm9ncmFtcyYj
MzI7dGhlJiMzMjtSUE1CJiMzMjtrZXkmIzMyO3Rocm91Z2gmIzMyO1UtQm9vdCYjMzI7YW5kJiMz
MjtyZWFkcy93cml0ZXMmIzMyO3NlY3VyZS1zdG9yYWdlCiZndDsmIzMyO29iamVjdHMsJiMzMjt3
aXRoJiMzMjt0aGUmIzMyO2Rlcml2ZWQmIzMyO0NJRCYjMzI7bWF0Y2hpbmcmIzMyO3RoZSYjMzI7
TGludXgmIzMyO1VGUyYjMzI7ZGV2aWNlX2lkJiMzMjtBQkkuCiZndDsKJmd0OyYjMzI7RGVwZW5k
ZW5jaWVzOgomZ3Q7JiMzMjtMaW51eCYjMzI7a2VybmVsOgomZ3Q7JiMzMjsmIzE2MDtodHRwczov
L2xvcmUua2VybmVsLm9yZy9saW51eC1zY3NpLzIwMjYwNzE2MDgzNzI4LjIyMjY0MjItMS1qb3Jn
ZS5yYW1pcmV6QG9zcy5xdWFsY29tbS5jb20vCmFjY2VwdGVkJiMzMjtpbiYjMzI7djQmIzMyOy0t
Jmd0OyYjMzI7aHR0cHM6Ly9sa21sLm9yZy9sa21sLzIwMjYvOC8yNy8zNjkKCiZndDsmIzMyO09w
LXRlZQomZ3Q7JiMzMjsmIzE2MDtodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9n
aXRodWIuY29tL09QLVRFRS9vcHRlZV9vcy9wdWxsLzc4ODFfXzshIUNUUk5LQTl3TWcwQVJidyFs
UTVEOUlVRTFENWVycWJhWENrbEZ1YTZKaWlqWllCNlhOMHE1TERGWlpwaWFHbXJIX2sxMHJMa2Nq
VTFuU3poc1JEWC0tSjQ5R3QyMkU4VTczbHg3RXM1NjdUVUF4d1gmIzM2OwphbmQmIzMyO2Fsc28m
IzMyO2ZvbGxvd2luZyYjMzI7SWxpYXMmIzMyO3JldmlldyYjMzI7aHR0cHM6Ly91cmxkZWZlbnNl
LmNvbS92My9fX2h0dHBzOi8vZ2l0aHViLmNvbS9PUC1URUUvb3B0ZWVfb3MvcHVsbC84MDA3X187
ISFDVFJOS0E5d01nMEFSYnchbFE1RDlJVUUxRDVlcnFiYVhDa2xGdWE2SmlpalpZQjZYTjBxNUxE
RlpacGlhR21ySF9rMTByTGtjalUxblN6aHNSRFgtLUo0OUd0MjJFOFU3M2x4N0VzNTY1SkVUR2RR
JiMzNjsmIzMyOyYjMTYwOyhib3RoJiMzMjttZXJnZWQpCgomZ3Q7JiMzMjtGb3ImIzMyO3JlZmVy
ZW5jZSwmIzMyO2F0JiMzMjt0aGlzJiMzMjtwb2ludCYjMzI7TGludXgmIzMyO2NhbiYjMzI7YWNj
ZXNzJiMzMjtSUE1CJiMzMjthbmQmIzMyO2p1c3QmIzMyO3UtYm9vdCYjMzI7cGVuZGluZyYjMzI7
b24mIzMyO3RoaXMmIzMyO3NldC4KSSYjMzk7ZCYjMzI7bGlrZSYjMzI7dG8mIzMyO2hhdmUmIzMy
O3NvbWUmIzMyO2Rpc2N1c3Npb24mIzMyO2luJiMzMjttb3JlJiMzMjtkZXRhaWwmIzMyO2FzJiMz
MjtiZWxvdywmIzMyO2l0JiMzMjt3aWxsJiMzMjtiZSYjMzI7cXVpdGUmIzMyO2xvbmcuJiMzMjtI
b3dldmVyLCYjMzI7bXkmIzMyO2NvbXBhbnkmIzM5O3MKZW1haWwmIzMyO3NlcnZlciYjMzI7YW5k
JiMzMjttYWlsJiMzMjtjbGllbnRzJiMzMjtib3RoJiMzMjtoYXZlJiMzMjtwcm9ibGVtJiMzMjth
Z2FpbiYjMzI7YXMmIzMyO3VzdWFsLiYjMzI7SSYjMzk7bSYjMzI7bm90JiMzMjtzdXJlJiMzMjtp
ZiYjMzI7dGhpcyYjMzI7cmVwbHkmIzMyO2NvdWxkJiMzMjtiZSYjMzI7c2VuZApvdXQmIzMyO2Nv
cnJlY3RseSYjMzI7YW5kJiMzMjtpbiYjMzI7Y29ycmVjdCYjMzI7Zm9ybWF0LiYjMzI7TGV0JiMz
OTtzJiMzMjtzZWUuJiMzMjsKTW9yZW92ZXIsJiMzMjtJJiMzOTt2ZSYjMzI7aW52aXRlZCYjMzI7
S2VybmVsJiMzOTtzJiMzMjttYWludGFpbmVycyYjMzI7U3RhbmxleSYjMzI7Smh1JiMzMjthbmQm
IzMyO0JlYW4mIzMyO0h1byYjMzI7dG8mIzMyO3RoaXMmIzMyO21haWwmIzMyO3RocmVhZCYjMzI7
dG8mIzMyO3NlZSYjMzI7aWYmIzMyO3RoZSYjMzI7b3BpbmlvbiYjMzI7aW5jcmVhc2VzJiMzMjtt
b3JlJiMzMjtjb21wYXRpYmlsaXR5LiYjMzI7CkJ1dCwmIzMyO0kmIzM5O20mIzMyO25vdCYjMzI7
c3VyZSYjMzI7aG93JiMzMjt0byYjMzI7aW52aXRlJiMzMjtPUFRFRSYjMzk7cyYjMzI7bWFpbnRh
aW5lcnMsJiMzMjtJJiMzOTtsbCYjMzI7dHJ5JiMzMjt0byYjMzI7Zm9yd2FyZCYjMzI7dGhlJiMz
Mjtmb2xsb3dpbmcmIzMyO2Rlc2NyaXB0aW9uJiMzMjt0byYjMzI7T1BURUUmIzMyO2xhdGVyLgoK
U28uLiYjMzI7bGV0JiMzOTtzJiMzMjtzdGFydCYjMzI7ZnJvbSYjMzI7cGF0Y2gmIzMyOzQvNiYj
MzI7YW5kJiMzMjt0aGVuJiMzMjtyZXZpZXcmIzMyO3RoZSYjMzI7d2hvbGUmIzMyO3N0b3J5Lgo0
LzYmIzMyOyYjODIxMjsmIzMyO3VmczomIzMyO2Rlcml2ZSYjMzI7dGhlJiMzMjtwZXItcmVnaW9u
JiMzMjtSUE1CJiMzMjtDSUQmIzMyO2FuZCYjMzI7c2l6ZSYjMzI7Zm9yJiMzMjtPUC1URUUKClBh
dGNoJiMzMjs0LzYmIzMyO2hhcmQtY29kZXMmIzMyO2JvdGgmIzMyO3RoZSYjMzI7aGFzaCYjMzI7
YWxnb3JpdGhtJiMzMjsoQkxBS0UyYikmIzMyO2FuZCYjMzI7dGhlJiMzMjtvdXRwdXQKbGVuZ3Ro
JiMzMjsoVUZTX1JQTUJfQ0lEX1NJWkUmIzMyOz0mIzMyOzE2KSYjMzI7dXNlZCYjMzI7dG8mIzMy
O2Rlcml2ZSYjMzI7dGhlJiMzMjtSUE1CJiMzMjtDSUQmIzMyO2ZvciYjMzI7VUZTCmRldmljZXMu
JiMzMjtOZWl0aGVyJiMzMjtjaG9pY2UmIzMyO2lzJiMzMjttYW5kYXRlZCYjMzI7YnkmIzMyO2Fu
eSYjMzI7c3BlY2lmaWNhdGlvbiYjMzI7dGhlJiMzMjtzZXJpZXMKYnVpbGRzJiMzMjtvbiYjMzI7
KFVGUy9KRVNEMjIwLCYjMzI7UlBNQiwmIzMyO29yJiMzMjt0aGUmIzMyO09QLVRFRS9URUUmIzMy
O0NsaWVudCYjMzI7QVBJKSwmIzMyO2FuZApoYXJkLWNvZGluZyYjMzI7dGhlbSYjMzI7Y3JlYXRl
cyYjMzI7YSYjMzI7cmVhbCYjMzI7Y29tcGF0aWJpbGl0eSYjMzI7cmlzayYjMzI7Zm9yJiMzMjtw
cm9kdWN0cyYjMzI7dGhhdApoYXZlJiMzMjthbHJlYWR5JiMzMjtzaGlwcGVkJiMzMjt3aXRoJiMz
MjthJiMzMjtkaWZmZXJlbnQsJiMzMjt2ZW5kb3Itc3BlY2lmaWMmIzMyO2Rlcml2YXRpb24uJiMz
MjtUaGUKQ0lEJiMzMjtkZXJpdmF0aW9uJiMzMjtzaG91bGQmIzMyO2JlJiMzMjtmYWN0b3JlZCYj
MzI7b3V0JiMzMjthcyYjMzI7YSYjMzI7dmVuZG9yLXNwZWNpZmljLCYjMzI7YnVpbGQtdGltZQpz
ZWxlY3RhYmxlJiMzMjtjb21wb25lbnQmIzMyO3JhdGhlciYjMzI7dGhhbiYjMzI7YSYjMzI7c2lu
Z2xlJiMzMjtmaXhlZCYjMzI7YWxnb3JpdGhtJiMzMjtiYWtlZCYjMzI7aW50bwpjb21tb24mIzMy
O1VGUyYjMzI7Y29yZSYjMzI7Y29kZS4KCjEuJiMzMjtOZWl0aGVyJiMzMjt0aGUmIzMyO1VGUywm
IzMyO1JQTUIsJiMzMjtub3ImIzMyO1RFRSYjMzI7c3BlY2lmaWNhdGlvbnMmIzMyO21hbmRhdGUm
IzMyO2EmIzMyO2hhc2gKJiMzMjsmIzMyOyYjMzI7YWxnb3JpdGhtJiMzMjtmb3ImIzMyO0NJRCYj
MzI7ZGVyaXZhdGlvbgotJiMzMjtUaGUmIzMyO1VGUyYjMzI7c3BlY2lmaWNhdGlvbiYjMzI7KEpF
U0QyMjApJiMzMjtkZWZpbmVzJiMzMjt0aGUmIzMyO0RldmljZS9Vbml0L0dlb21ldHJ5CiYjMzI7
JiMzMjtkZXNjcmlwdG9ycyYjMzI7dGhhdCYjMzI7cGF0Y2gmIzMyOzQvNiYjMzI7cmVhZHMmIzMy
OyhtYW51ZmFjdHVyZXImIzMyO0lELCYjMzI7c3BlYyYjMzI7dmVyc2lvbiwKJiMzMjsmIzMyO21v
ZGVsJiMzMjtzdHJpbmcsJiMzMjtzZXJpYWwmIzMyO251bWJlciwmIzMyO2RldmljZSYjMzI7dmVy
c2lvbiwmIzMyO21hbnVmYWN0dXJlJiMzMjtkYXRlLAomIzMyOyYjMzI7cmVnaW9uJiMzMjtzaXpl
cykmIzMyOyYjODIxMjsmIzMyO2l0JiMzMjtzYXlzJiMzMjtub3RoaW5nJiMzMjthYm91dCYjMzI7
Y29tYmluaW5nJiMzMjt0aGVtJiMzMjtpbnRvJiMzMjthJiMzMjsmcXVvdDtDSUQmcXVvdDssCiYj
MzI7JiMzMjthbmQmIzMyO2NlcnRhaW5seSYjMzI7bm90aGluZyYjMzI7YWJvdXQmIzMyO3doaWNo
JiMzMjtoYXNoJiMzMjtmdW5jdGlvbiYjMzI7dG8mIzMyO3VzZS4KLSYjMzI7VGhlJiMzMjtSUE1C
JiMzMjtmcmFtZSYjMzI7cHJvdG9jb2wmIzMyO2l0c2VsZiYjMzI7KHN0cnVjdCYjMzI7cnBtYl9m
cmFtZSYjMzI7aW4KJiMzMjsmIzMyO2luY2x1ZGUvbGludXgvcnBtYi5oLCYjMzI7YW5kJiMzMjt0
aGUmIzMyO2VxdWl2YWxlbnQmIzMyO0pFREVDJiMzMjtSUE1CJiMzMjtmcmFtZSYjMzI7bGF5b3V0
KQomIzMyOyYjMzI7aGFzJiMzMjtubyYjMzI7Q0lEJiMzMjtmaWVsZCYjMzI7YXQmIzMyO2FsbCYj
MzI7JiM4MjEyOyYjMzI7Q0lEJiMzMjtpcyYjMzI7cHVyZWx5JiMzMjthJiMzMjtob3N0LXNpZGUv
c2VjdXJlLXdvcmxkCiYjMzI7JiMzMjtrZXkmIzMyO21hbmFnZW1lbnQmIzMyO2NvbnZlbnRpb24s
JiMzMjtub3QmIzMyO3BhcnQmIzMyO29mJiMzMjt0aGUmIzMyO3dpcmUmIzMyO3Byb3RvY29sLgot
JiMzMjtUaGUmIzMyO0dsb2JhbFBsYXRmb3JtJiMzMjtURUUmIzMyO0NsaWVudCYjMzI7QVBJJiMz
MjsvJiMzMjtPUC1URUUmIzM5O3MmIzMyO293biYjMzI7UlBNQiYjMzI7c3Vic3lzdGVtJiMzMjtS
UEMKJiMzMjsmIzMyO2NvbnRyYWN0JiMzMjtvbmx5JiMzMjtkZWZpbmVzJiMzMjt0aGF0JiMzMjth
JiMzMjtmaXhlZC1zaXplJiMzMjtvcGFxdWUmIzMyO2J5dGUmIzMyO2J1ZmZlciYjMzI7aXMmIzMy
O3Bhc3NlZAomIzMyOyYjMzI7YXMmIzMyO3RoZSYjMzI7ZGV2aWNlJiMzMjtpZGVudGlmaWVyJiMz
MjsmIzgyMTI7JiMzMjtpdCYjMzI7ZG9lcyYjMzI7bm90JiMzMjtzcGVjaWZ5JiMzMjtob3cmIzMy
O3RoYXQmIzMyO2J1ZmZlciYjMzk7cwomIzMyOyYjMzI7Y29udGVudHMmIzMyO2FyZSYjMzI7ZGVy
aXZlZCYjMzI7ZnJvbSYjMzI7dGhlJiMzMjt1bmRlcmx5aW5nJiMzMjtzdG9yYWdlJiMzMjtkZXZp
Y2UuCi0mIzMyO0JlY2F1c2UmIzMyO25vJiMzMjtzcGVjaWZpY2F0aW9uJiMzMjtwcmVzY3JpYmVz
JiMzMjt0aGUmIzMyO2FsZ29yaXRobSwmIzMyO3RoaXMmIzMyO2lzCiYjMzI7JiMzMjtsZWdpdGlt
YXRlbHkmIzMyO3ZlbmRvci1zcGVjaWZpYyYjMzI7dGVycml0b3J5LCYjMzI7YW5kJiMzMjtkaWZm
ZXJlbnQmIzMyO3ZlbmRvcnMmIzMyOyYjODIxMjsmIzMyO29yCiYjMzI7JiMzMjtldmVuJiMzMjt0
aGUmIzMyO3NhbWUmIzMyO3ZlbmRvciYjMzI7YWNyb3NzJiMzMjtwcm9kdWN0JiMzMjtnZW5lcmF0
aW9ucyYjMzI7JiM4MjEyOyYjMzI7bWF5JiMzMjtyZWFzb25hYmx5CiYjMzI7JiMzMjtjaG9vc2Um
IzMyO2RpZmZlcmVudCYjMzI7S0RGcy9oYXNoJiMzMjtmdW5jdGlvbnMmIzMyOyhCTEFLRTJiLCYj
MzI7U0hBLTI1NiwmIzMyO2EKJiMzMjsmIzMyO3ZlbmRvci1wcm9wcmlldGFyeSYjMzI7aGFzaCwm
IzMyO29yJiMzMjthJiMzMjtyYXcmIzMyO25vbi1oYXNoZWQmIzMyO2VuY29kaW5nLCYjMzI7YXMm
IzMyO3NlZW4mIzMyO2luCiYjMzI7JiMzMjtvdGhlciYjMzI7cmVhbC13b3JsZCYjMzI7aW1wbGVt
ZW50YXRpb25zJiMzMjtvZiYjMzI7dGhpcyYjMzI7c2FtZSYjMzI7ZmVhdHVyZSkuJiMzMjtUaGUm
IzMyO3BhdGNoCiYjMzI7JiMzMjtzZXQmIzMyO3Nob3VsZCYjMzI7bm90JiMzMjtmb3JjZSYjMzI7
b25lJiMzMjtzcGVjaWZpYyYjMzI7dmVuZG9yJiMzOTtzJiMzMjtjaG9pY2UmIzMyO2ludG8mIzMy
O2NvbW1vbiYjMzI7VUZTCiYjMzI7JiMzMjtjb3JlJiMzMjtjb2RlJiMzMjthcyYjMzI7dGhlJiMz
Mjtvbmx5JiMzMjtvcHRpb24uCgoyLiYjMzI7VUZTJiMzMjtSUE1CJiMzMjtkb2VzJiMzMjtub3Qm
IzMyO21hbmRhdGUmIzMyO2EmIzMyOzE2LWJ5dGUmIzMyO0NJRDsmIzMyO3RoZSYjMzI7c2l6ZSYj
MzI7c2hvdWxkJiMzMjtiZSYjMzI7dmFyaWFibGUKCi0mIzMyO1RoZSYjMzI7MTYtYnl0ZSYjMzI7
bGVuZ3RoJiMzMjtpcyYjMzI7bm90JiMzMjtkZXJpdmVkJiMzMjtmcm9tJiMzMjthbnkmIzMyO1VG
UyYjMzI7b3ImIzMyO1JQTUImIzMyO3JlcXVpcmVtZW50LgomIzMyOyYjMzI7SXQmIzMyO2NvbWVz
JiMzMjtmcm9tJiMzMjt0aGUmIzMyO2VNTUMmIzMyO0NJRCYjMzI7cmVnaXN0ZXImIzMyOyhKRURF
QyYjMzI7SkVTRDg0JiMzMjtDYXJkL0RldmljZQomIzMyOyYjMzI7SWRlbnRpZmljYXRpb24mIzMy
O1JlZ2lzdGVyKSwmIzMyO3doaWNoJiMzMjtpcyYjMzI7YSYjMzI7Zml4ZWQmIzMyOzEyOC1iaXQm
IzMyO2hhcmR3YXJlCiYjMzI7JiMzMjtyZWdpc3RlciYjMzI7JiM4MjEyOyYjMzI7YSYjMzI7cHVy
ZWx5JiMzMjtlTU1DLXNwZWNpZmljJiMzMjtoYXJkd2FyZSYjMzI7ZmFjdC4KLSYjMzI7TGludXgm
IzMyO2tlcm5lbCYjMzk7cyYjMzI7b3duJiMzMjtnZW5lcmljJiMzMjtSUE1CJiMzMjthYnN0cmFj
dGlvbiYjMzI7KHN0cnVjdCYjMzI7cnBtYl9kZXNjciYjMzI7aW4KJiMzMjsmIzMyO2luY2x1ZGUv
bGludXgvcnBtYi5oKSYjMzI7YWxyZWFkeSYjMzI7bW9kZWxzJiMzMjt0aGlzJiMzMjtjb3JyZWN0
bHkmIzMyO2FuZCYjMzI7dHJlYXRzJiMzMjt0aGUKJiMzMjsmIzMyO2RldmljZSYjMzI7aWRlbnRp
ZmllciYjMzI7YXMmIzMyO3ZhcmlhYmxlLWxlbmd0aCYjMzI7YnkmIzMyO2Rlc2lnbjoKCiYjMzI7
JiMzMjtzdHJ1Y3QmIzMyO3JwbWJfZGVzY3ImIzMyO3sKJiMzMjsmIzMyOyYjMzI7JiMzMjsmIzMy
OyYjMzI7JiMzMjsmIzMyOyYjMzI7JiMzMjtlbnVtJiMzMjtycG1iX3R5cGUmIzMyO3R5cGU7CiYj
MzI7JiMzMjsmIzMyOyYjMzI7JiMzMjsmIzMyOyYjMzI7JiMzMjsmIzMyOyYjMzI7aW50JiMzMjso
KnJvdXRlX2ZyYW1lcykoc3RydWN0JiMzMjtkZXZpY2UmIzMyOypkZXYsJiMzMjt1OCYjMzI7KnJl
cSwmIzMyO3Vuc2lnbmVkJiMzMjtpbnQmIzMyO3JlcV9sZW4sCiYjMzI7JiMzMjsmIzMyOyYjMzI7
JiMzMjsmIzMyOyYjMzI7JiMzMjsmIzMyOyYjMzI7JiMzMjsmIzMyOyYjMzI7JiMzMjsmIzMyOyYj
MzI7JiMzMjsmIzMyOyYjMzI7JiMzMjsmIzMyOyYjMzI7JiMzMjsmIzMyOyYjMzI7JiMzMjsmIzMy
OyYjMzI7JiMzMjsmIzMyO3U4JiMzMjsqcmVzcCwmIzMyO3Vuc2lnbmVkJiMzMjtpbnQmIzMyO3Jl
c3BfbGVuKTsKJiMzMjsmIzMyOyYjMzI7JiMzMjsmIzMyOyYjMzI7JiMzMjsmIzMyOyYjMzI7JiMz
Mjt1OCYjMzI7KmRldl9pZDsKJiMzMjsmIzMyOyYjMzI7JiMzMjsmIzMyOyYjMzI7JiMzMjsmIzMy
OyYjMzI7JiMzMjtzaXplX3QmIzMyO2Rldl9pZF9sZW47JiMzMjsmIzMyOyYjMzI7LyomIzMyO3Zh
cmlhYmxlLCYjMzI7bm90JiMzMjtmaXhlZCYjMzI7YXQmIzMyOzE2JiMzMjsqLwomIzMyOyYjMzI7
JiMzMjsmIzMyOyYjMzI7JiMzMjsmIzMyOyYjMzI7JiMzMjsmIzMyO3UxNiYjMzI7cmVsaWFibGVf
d3JfY291bnQ7CiYjMzI7JiMzMjsmIzMyOyYjMzI7JiMzMjsmIzMyOyYjMzI7JiMzMjsmIzMyOyYj
MzI7dTE2JiMzMjtjYXBhY2l0eTsKJiMzMjsmIzMyO307CgomIzMyOyYjMzI7TGlrZXdpc2UsJiMz
Mjt0aGUmIzMyO1VGUy1zcGVjaWZpYyYjMzI7ZGV2aWNlJiMzMjtpZGVudGlmaWVyJiMzMjt0aGUm
IzMyO0xpbnV4JiMzMjtrZXJuZWwmIzMyO2J1aWxkcwomIzMyOyYjMzI7aW4mIzMyO3Vmc2hjZF9j
cmVhdGVfZGV2aWNlX2lkKCkmIzMyO2lzJiMzMjthJiMzMjt2YXJpYWJsZS1sZW5ndGgmIzMyO0FT
Q0lJJiMzMjtzdHJpbmcKJiMzMjsmIzMyOygmcXVvdDslMDRYLSUwNFgtJXMtJXMtJTA0WC0lMDRY
JnF1b3Q7KSwmIzMyO25vdCYjMzI7YSYjMzI7Zml4ZWQmIzMyOzE2LWJ5dGUmIzMyO3ZhbHVlLgot
JiMzMjtQYXRjaCYjMzI7NC82JiMzMjtzaG91bGQmIzMyO2ZvbGxvdyYjMzI7dGhlJiMzMjtzYW1l
JiMzMjtwYXR0ZXJuOiYjMzI7VUZTX1JQTUJfQ0lEX1NJWkUmIzMyO3Nob3VsZAomIzMyOyYjMzI7
bm90JiMzMjtiZSYjMzI7YSYjMzI7aGFyZCYjMzI7I2RlZmluZSYjMzI7MTYmIzMyO2Jha2VkJiMz
MjtpbnRvJiMzMjtpbmNsdWRlL3Vmcy5oOyYjMzI7dGhlJiMzMjtDSUQmIzMyO2J1ZmZlcgomIzMy
OyYjMzI7c2l6ZSYjMzI7c2hvdWxkJiMzMjtiZSYjMzI7YSYjMzI7cHJvcGVydHkmIzMyO29mJiMz
Mjt0aGUmIzMyO3NlbGVjdGVkJiMzMjt2ZW5kb3ImIzMyO2JhY2tlbmQmIzMyOyhlLmcuCiYjMzI7
JiMzMjtyZXR1cm5lZCYjMzI7YWxvbmdzaWRlJiMzMjt0aGUmIzMyO2Rlcml2ZWQmIzMyO0NJRCwm
IzMyO29yJiMzMjtkZWNsYXJlZCYjMzI7cGVyLWJhY2tlbmQpLCYjMzI7c28KJiMzMjsmIzMyO3Ro
YXQmIzMyO2EmIzMyOzE2LWJ5dGUmIzMyO291dHB1dCYjMzI7aXMmIzMyO29uZSYjMzI7dmFsaWQm
IzMyO2Nob2ljZSYjMzI7YW1vbmcmIzMyO290aGVycyYjMzI7cmF0aGVyJiMzMjt0aGFuCiYjMzI7
JiMzMjthbiYjMzI7YXNzdW1lZCYjMzI7dW5pdmVyc2FsJiMzMjtjb25zdGFudC4KCjMuJiMzMjtU
aGUmIzMyO3ZlbmRvci1zcGVjaWZpYyYjMzI7cGFydCYjMzI7c2hvdWxkJiMzMjtiZSYjMzI7ZmFj
dG9yZWQmIzMyO291dDsmIzMyOzE2JiMzMjtieXRlcyYjMzI7aXMmIzMyO29ubHkKJiMzMjsmIzMy
OyYjMzI7dGhlcmUmIzMyO2ZvciYjMzI7ZU1NQyYjMzI7Y29tcGF0aWJpbGl0eSwmIzMyO2FuZCYj
MzI7VUZTJiMzMjtoYXMmIzMyO25vJiMzMjtzdWNoJiMzMjtoYXJkd2FyZSYjMzI7Q0lEJiMzMjth
dCYjMzI7YWxsCgotJiMzMjtUbyYjMzI7cmVzdGF0ZSYjMzI7dGhlJiMzMjtjb3JlJiMzMjtwcm9i
bGVtJiMzMjtwbGFpbmx5OiYjMzI7VUZTJiMzMjtoYXMmIzMyO25vJiMzMjtDSUQmIzMyO3JlZ2lz
dGVyLgomIzMyOyYjMzI7VGhlcmUmIzMyO2lzJiMzMjtubyYjMzI7cGllY2UmIzMyO29mJiMzMjtV
RlMmIzMyO2hhcmR3YXJlJiMzMjt0aGF0JiMzMjtwYXRjaCYjMzI7NC82JiMzOTtzCiYjMzI7JiMz
Mjt1ZnNfcnBtYl9idWlsZF9jaWQoKSYjMzI7aXMmIzMyOyZxdW90O3JlYWRpbmcmcXVvdDsmIzMy
OyYjODIxMjsmIzMyO2l0JiMzMjtpcyYjMzI7ZW50aXJlbHkmIzMyO2EmIzMyO3NvZnR3YXJlCiYj
MzI7JiMzMjtjb25zdHJ1Y3Rpb24uJiMzMjtUaGUmIzMyO29ubHkmIzMyO3JlYXNvbiYjMzI7dGhl
JiMzMjtyZXN1bHQmIzMyO2lzJiMzMjtzcXVlZXplZCYjMzI7aW50byYjMzI7MTYmIzMyO2J5dGVz
CiYjMzI7JiMzMjtpcyYjMzI7dG8mIzMyO2ZpdCYjMzI7dGhlJiMzMjtwcmUtZXhpc3RpbmcmIzMy
O09QLVRFRSYjMzI7UlBDJiMzMjtidWZmZXImIzMyO3NpemUmIzMyO3RoYXQmIzMyO3dhcwomIzMy
OyYjMzI7b3JpZ2luYWxseSYjMzI7ZGVzaWduZWQmIzMyO2Fyb3VuZCYjMzI7ZU1NQyYjMzk7cyYj
MzI7cmVhbCwmIzMyO2hhcmR3YXJlLWRlZmluZWQmIzMyOzE2LWJ5dGUmIzMyO0NJRAomIzMyOyYj
MzI7cmVnaXN0ZXIuCi0mIzMyO0NvbmZsYXRpbmcmIzMyOyZxdW90O3RoZSYjMzI7VUZTLXNwZWNp
ZmljJiMzMjtkZXNjcmlwdG9yLXJlYWRpbmcvc3RyaW5nLWJ1aWxkaW5nCiYjMzI7JiMzMjtsb2dp
YyZxdW90OyYjMzI7d2l0aCYjMzI7JnF1b3Q7dGhlJiMzMjtzcGVjaWZpYyYjMzI7aGFzaCYjMzI7
ZnVuY3Rpb24mIzMyO2FuZCYjMzI7b3V0cHV0JiMzMjtsZW5ndGgmIzMyO2Nob2ljZSZxdW90Owom
IzMyOyYjMzI7aW4mIzMyO2EmIzMyO3NpbmdsZSYjMzI7bm9uLWNvbmZpZ3VyYWJsZSYjMzI7ZnVu
Y3Rpb24mIzMyO21lYW5zJiMzMjtldmVyeSYjMzI7ZG93bnN0cmVhbSYjMzI7dXNlciYjMzI7b2YK
JiMzMjsmIzMyO3RoaXMmIzMyO3NlcmllcyYjMzI7aW5oZXJpdHMmIzMyO29uZSYjMzI7dmVuZG9y
JiMzOTtzJiMzMjthbGdvcml0aG0mIzMyO2Nob2ljZSYjMzI7d2l0aCYjMzI7bm8mIzMyO3dheSYj
MzI7dG8KJiMzMjsmIzMyO29wdCYjMzI7b3V0LCYjMzI7ZXZlbiYjMzI7dGhvdWdoJiMzMjt0aGUm
IzMyO3R3byYjMzI7Y29uY2VybnMmIzMyO2FyZSYjMzI7bG9naWNhbGx5JiMzMjtzZXBhcmFibGU6
CiYjMzI7JiMzMjstJiMzMjtSZWFkaW5nJiMzMjtVRlMmIzMyO2Rlc2NyaXB0b3JzJiMzMjthbmQm
IzMyO2J1aWxkaW5nJiMzMjt0aGUmIzMyO2lucHV0JiMzMjtpZGVudGlmaWVyJiMzMjtzdHJpbmcK
JiMzMjsmIzMyOyYjMzI7JiMzMjtpcyYjMzI7Y29tbW9uLCYjMzI7c3BlYy1kcml2ZW4mIzMyO2xv
Z2ljJiMzMjt0aGF0JiMzMjtjYW4mIzMyO3N0YXkmIzMyO2luJiMzMjtzaGFyZWQmIzMyO1VGUyYj
MzI7Y29yZQomIzMyOyYjMzI7JiMzMjsmIzMyO2NvZGUuCiYjMzI7JiMzMjstJiMzMjtUdXJuaW5n
JiMzMjt0aGF0JiMzMjtzdHJpbmcmIzMyO2ludG8mIzMyO3RoZSYjMzI7YWN0dWFsJiMzMjtDSUQm
IzMyO2J5dGVzJiMzMjtoYW5kZWQmIzMyO3RvJiMzMjtPUC1URUUmIzMyO2lzCiYjMzI7JiMzMjsm
IzMyOyYjMzI7dGhlJiMzMjt2ZW5kb3Itc3BlY2lmaWMmIzMyO3BhcnQmIzMyO2FuZCYjMzI7c2hv
dWxkJiMzMjtiZSYjMzI7cGx1Z2dhYmxlLgotJiMzMjtTdWdnZXN0ZWQmIzMyO3Jlc3RydWN0dXJp
bmc6JiMzMjtrZWVwJiMzMjt1ZnNoY2Qtc2lkZSYjMzI7ZGVzY3JpcHRvciYjMzI7cmVhZHMmIzMy
O2FuZAomIzMyOyYjMzI7c3RyaW5nLWJ1aWxkaW5nJiMzMjtpbiYjMzI7Y29tbW9uJiMzMjtjb2Rl
LCYjMzI7YnV0JiMzMjtleHBvc2UmIzMyO3RoZSYjMzI7ZmluYWwKJiMzMjsmIzMyO3N0cmluZy10
by1DSUQmIzMyO3N0ZXAmIzMyO2FzJiMzMjthJiMzMjtyZXBsYWNlYWJsZSYjMzI7aG9vay93ZWFr
JiMzMjtmdW5jdGlvbiYjMzI7KG9yJiMzMjthJiMzMjtzbWFsbAomIzMyOyYjMzI7dmVuZG9yJiMz
MjtvcHMmIzMyO3RhYmxlKSwmIzMyO3NvJiMzMjt0aGUmIzMyO0JMQUtFMmImIzMyO2ltcGxlbWVu
dGF0aW9uJiMzMjtpbiYjMzI7dGhpcyYjMzI7c2VyaWVzCiYjMzI7JiMzMjtiZWNvbWVzJiMzMjt0
aGUmIzMyO2RlZmF1bHQmIzMyO2JhY2tlbmQmIzMyO3JhdGhlciYjMzI7dGhhbiYjMzI7dGhlJiMz
Mjtvbmx5JiMzMjtiYWNrZW5kLgoKNC4mIzMyO0hhcmQtY29kaW5nJiMzMjtvbmUmIzMyO2FsZ29y
aXRobSYjMzI7Y3JlYXRlcyYjMzI7cmVhbCYjMzI7ZmlybXdhcmUtdXBncmFkZSYjMzI7YW5kCiYj
MzI7JiMzMjsmIzMyO2tleS1jb21wYXRpYmlsaXR5JiMzMjtyaXNrJiMzMjtmb3ImIzMyO2FscmVh
ZHktc2hpcHBpbmcmIzMyO3Byb2R1Y3RzLCYjMzI7c28mIzMyO3RoZQomIzMyOyYjMzI7JiMzMjtk
ZXJpdmF0aW9uJiMzMjttdXN0JiMzMjtiZSYjMzI7dmVuZG9yLXNlbGVjdGFibGUmIzMyO2F0JiMz
MjtidWlsZCYjMzI7dGltZSYjMzI7KHZpYSYjMzI7ZGVmY29uZmlnKQoKNS4mIzMyO1NpbmNlJiMz
MjtuZWl0aGVyJiMzMjt0aGUmIzMyO2FsZ29yaXRobSYjMzI7KHBvaW50JiMzMjsxKSYjMzI7bm9y
JiMzMjt0aGUmIzMyO291dHB1dCYjMzI7bGVuZ3RoJiMzMjsocG9pbnQmIzMyOzIpCiYjMzI7JiMz
MjtpcyYjMzI7c3BlY2lmaWVkJiMzMjtieSYjMzI7YW55JiMzMjtzdGFuZGFyZCwmIzMyO2FuZCYj
MzI7Q0lEJiMzMjtpcyYjMzI7cHVyZWx5JiMzMjthJiMzMjtzb2Z0d2FyZQomIzMyOyYjMzI7Y29u
dmVudGlvbiYjMzI7aW52ZW50ZWQmIzMyO3RvJiMzMjtyZXVzZSYjMzI7YW4mIzMyO2VNTUMtc2hh
cGVkJiMzMjtPUC1URUUmIzMyO0FCSSYjMzI7KHBvaW50JiMzMjszKSwKJiMzMjsmIzMyO2RpZmZl
cmVudCYjMzI7aW1wbGVtZW50YXRpb25zJiMzMjt0aGF0JiMzMjthbHJlYWR5JiMzMjtleGlzdCYj
MzI7dG9kYXkmIzMyO2hhdmUmIzMyO21hZGUKJiMzMjsmIzMyO2RpZmZlcmVudCwmIzMyO2luY29t
cGF0aWJsZSYjMzI7Y2hvaWNlcyYjMzI7Zm9yJiMzMjt0aGUmIzMyO3NhbWUmIzMyO3Byb2JsZW06
CiYjMzI7JiMzMjstJiMzMjtUaGlzJiMzMjtzZXJpZXMmIzMyOyh1cHN0cmVhbSYjMzI7djUsJiMz
MjtwYXRjaCYjMzI7NC82KTomIzMyO2J1aWxkcyYjMzI7YW4mIzMyO2lkZW50aWZpZXImIzMyO3N0
cmluZwomIzMyOyYjMzI7JiMzMjsmIzMyO2Zyb20mIzMyO0RldmljZSYjMzI7RGVzY3JpcHRvciYj
MzI7ZmllbGRzJiMzMjsobWFudWZhY3R1cmVyJiMzMjtJRCwmIzMyO3NwZWMmIzMyO3ZlcnNpb24s
CiYjMzI7JiMzMjsmIzMyOyYjMzI7bW9kZWwsJiMzMjtzZXJpYWwsJiMzMjtkZXZpY2UmIzMyO3Zl
cnNpb24sJiMzMjttYW51ZmFjdHVyZSYjMzI7ZGF0ZSkmIzMyO2FuZCYjMzI7aGFzaGVzJiMzMjtp
dAomIzMyOyYjMzI7JiMzMjsmIzMyO3dpdGgmIzMyO0JMQUtFMmImIzMyO3RvJiMzMjthJiMzMjtm
aXhlZCYjMzI7MTYtYnl0ZSYjMzI7b3V0cHV0LgomIzMyOyYjMzI7LSYjMzI7QXQmIzMyO2xlYXN0
JiMzMjtvbmUmIzMyO290aGVyJiMzMjtyZWFsLCYjMzI7c2hpcHBpbmcmIzMyO2Rvd25zdHJlYW0m
IzMyO2ltcGxlbWVudGF0aW9uJiMzMjsoYQomIzMyOyYjMzI7JiMzMjsmIzMyO3ZlbmRvciYjMzk7
cyYjMzI7cHJvZHVjdGlvbiYjMzI7VS1Cb290JiMzMjticmFuY2gmIzMyO2FuYWx5emVkJiMzMjth
bG9uZ3NpZGUmIzMyO3RoaXMmIzMyO3NlcmllcykKJiMzMjsmIzMyOyYjMzI7JiMzMjtkZXJpdmVz
JiMzMjt0aGUmIzMyO0NJRCYjMzI7YnkmIzMyO2RpcmVjdGx5JiMzMjtkZWNvZGluZy9wb3J0aW5n
JiMzMjt0aGUmIzMyO2RldmljZSYjMzk7cwomIzMyOyYjMzI7JiMzMjsmIzMyO3RlZS1zdXBwbGlj
YW50LXNpZGUmIzMyO3JlYWRfY2lkKCktc3R5bGUmIzMyO2xvZ2ljJiMzMjsmIzgyMTI7JiMzMjtp
LmUuJiMzMjtubyYjMzI7aGFzaCYjMzI7YXQmIzMyO2FsbCwKJiMzMjsmIzMyOyYjMzI7JiMzMjtq
dXN0JiMzMjthJiMzMjtkaXJlY3QmIzMyO2J5dGUmIzMyO2VuY29kaW5nJiMzMjtvZiYjMzI7dGhl
JiMzMjtzZXJpYWwtbnVtYmVyJiMzMjtzdHJpbmcKJiMzMjsmIzMyOyYjMzI7JiMzMjtkZXNjcmlw
dG9yLgomIzMyOyYjMzI7LSYjMzI7Qm90aCYjMzI7YXBwcm9hY2hlcyYjMzI7YXJlJiMzMjtlcXVh
bGx5JiMzMjsmcXVvdDt2YWxpZCZxdW90OyYjMzI7aW4mIzMyO3RoZSYjMzI7c2Vuc2UmIzMyO3Ro
YXQmIzMyO25laXRoZXIKJiMzMjsmIzMyOyYjMzI7JiMzMjt2aW9sYXRlcyYjMzI7YW55JiMzMjtz
cGVjaWZpY2F0aW9uLCYjMzI7YmVjYXVzZSYjMzI7bm9uZSYjMzI7ZXhpc3RzJiMzMjt0byYjMzI7
dmlvbGF0ZSYjMzI7JiM4MjEyOyYjMzI7YnV0CiYjMzI7JiMzMjsmIzMyOyYjMzI7dGhleSYjMzI7
YXJlJiMzMjttdXR1YWxseSYjMzI7aW5jb21wYXRpYmxlOiYjMzI7dGhlJiMzMjtzYW1lJiMzMjtw
aHlzaWNhbCYjMzI7VUZTJiMzMjtkZXZpY2UmIzMyO3dpbGwKJiMzMjsmIzMyOyYjMzI7JiMzMjtw
cm9kdWNlJiMzMjthJiMzMjtkaWZmZXJlbnQmIzMyOzE2LWJ5dGUmIzMyO3ZhbHVlJiMzMjt1bmRl
ciYjMzI7ZWFjaCYjMzI7c2NoZW1lLCYjMzI7YW5kCiYjMzI7JiMzMjsmIzMyOyYjMzI7dGhlcmVm
b3JlJiMzMjtPUC1URUUmIzMyO3dpbGwmIzMyO2Rlcml2ZSYjMzI7YSYjMzI7ZGlmZmVyZW50JiMz
MjtmaW5hbCYjMzI7UlBNQiYjMzI7YXV0aGVudGljYXRpb24KJiMzMjsmIzMyOyYjMzI7JiMzMjtr
ZXkmIzMyO3VuZGVyJiMzMjtlYWNoJiMzMjtzY2hlbWUuCi0mIzMyO1RoZSYjMzI7cHJhY3RpY2Fs
JiMzMjtjb25zZXF1ZW5jZTomIzMyO2FueSYjMzI7cHJvZHVjdCYjMzI7dGhhdCYjMzI7aGFzJiMz
MjthbHJlYWR5JiMzMjtzaGlwcGVkJiMzMjtpbgomIzMyOyYjMzI7dGhlJiMzMjtmaWVsZCYjMzI7
d2l0aCYjMzI7b25lJiMzMjtDSUQtZGVyaXZhdGlvbiYjMzI7c2NoZW1lJiMzMjsod2hldGhlciYj
MzI7dGhhdCYjMzI7aXMmIzMyO3RoaXMKJiMzMjsmIzMyO3NlcmllcyYjMzk7cyYjMzI7QkxBS0Uy
YiYjMzI7YXBwcm9hY2gmIzMyO29yJiMzMjthJiMzMjt2ZW5kb3ImIzM5O3MmIzMyO293biYjMzI7
cHJlLWV4aXN0aW5nJiMzMjtzY2hlbWUpJiMzMjtoYXMKJiMzMjsmIzMyO2VmZmVjdGl2ZWx5JiMz
MjtidXJuZWQmIzMyO3RoYXQmIzMyO3NjaGVtZSYjMzI7aW50byYjMzI7aXRzJiMzMjtwcm92aXNp
b25lZCYjMzI7UlBNQiYjMzI7a2V5CiYjMzI7JiMzMjttYXRlcmlhbC4mIzMyO0lmJiMzMjthJiMz
MjtmaXJtd2FyZSYjMzI7dXBkYXRlJiMzMjtsYXRlciYjMzI7cmVwbGFjZXMmIzMyO3RoZSYjMzI7
Ym9vdGxvYWRlci9PUC1URUUKJiMzMjsmIzMyO1JQTUImIzMyO2dsdWUmIzMyO3dpdGgmIzMyO2Em
IzMyO2J1aWxkJiMzMjt0aGF0JiMzMjtoYXJkLWNvZGVzJiMzMjthJiMzMjtkaWZmZXJlbnQmIzMy
O0NJRCYjMzI7ZGVyaXZhdGlvbgomIzMyOyYjMzI7KGZvciYjMzI7ZXhhbXBsZSwmIzMyO2Fkb3B0
aW5nJiMzMjt0aGlzJiMzMjtwYXRjaCYjMzI7c2V0JiMzOTtzJiMzMjtCTEFLRTJiJiMzMjtpbXBs
ZW1lbnRhdGlvbgomIzMyOyYjMzI7dW5jb25kaXRpb25hbGx5JiMzMjtvbiYjMzI7dG9wJiMzMjtv
ZiYjMzI7YSYjMzI7cHJvZHVjdCYjMzI7dGhhdCYjMzI7c2hpcHBlZCYjMzI7d2l0aCYjMzI7YSYj
MzI7ZGlmZmVyZW50CiYjMzI7JiMzMjt2ZW5kb3ImIzMyO3NjaGVtZSksJiMzMjt0aGUmIzMyO25l
d2x5LWRlcml2ZWQmIzMyO0NJRCYjMzI7d2lsbCYjMzI7bm90JiMzMjttYXRjaCYjMzI7dGhlJiMz
MjtDSUQmIzMyO3VzZWQKJiMzMjsmIzMyO3doZW4mIzMyO3RoZSYjMzI7ZGV2aWNlJiMzOTtzJiMz
MjtSUE1CJiMzMjtrZXkmIzMyO21hdGVyaWFsJiMzMjt3YXMmIzMyO29yaWdpbmFsbHkmIzMyO3By
b3Zpc2lvbmVkLiYjMzI7VGhlCiYjMzI7JiMzMjtkZXZpY2UmIzMyO3dpbGwmIzMyO3RoZW4mIzMy
O2VpdGhlcjoKJiMzMjsmIzMyOy0mIzMyO2ZhaWwmIzMyO3RvJiMzMjthdXRoZW50aWNhdGUmIzMy
O2FnYWluc3QmIzMyO2l0cyYjMzI7b3duJiMzMjtSUE1CJiMzMjtwYXJ0aXRpb24mIzMyOyhPUC1U
RUUKJiMzMjsmIzMyOyYjMzI7JiMzMjtkZXJpdmVzJiMzMjthJiMzMjtrZXkmIzMyO3RoYXQmIzMy
O2RvZXNuJiMzOTt0JiMzMjttYXRjaCYjMzI7d2hhdCYjMzI7d2FzJiMzMjtwcm92aXNpb25lZCks
JiMzMjtvcgomIzMyOyYjMzI7LSYjMzI7c2lsZW50bHkmIzMyO2JlZ2luJiMzMjtkZXJpdmluZyYj
MzI7YSYjMzI7ZGlmZmVyZW50JiMzMjtrZXkmIzMyO3RoYW4mIzMyO2JlZm9yZSwmIzMyO3doaWNo
JiMzMjtpcwomIzMyOyYjMzI7JiMzMjsmIzMyO2p1c3QmIzMyO2FzJiMzMjtiYWQmIzMyO2lmJiMz
MjthbnkmIzMyO3NlY3VyZS1zdG9yYWdlJiMzMjtkYXRhJiMzMjt3YXMmIzMyO3Byb3Zpc2lvbmVk
JiMzMjt1bmRlciYjMzI7dGhlCiYjMzI7JiMzMjsmIzMyOyYjMzI7b2xkJiMzMjtrZXkmIzMyO2Fu
ZCYjMzI7bXVzdCYjMzI7cmVtYWluJiMzMjtyZWFkYWJsZSYjMzI7YWZ0ZXImIzMyO3RoZSYjMzI7
dXBncmFkZS4KCiYjMzI7JiMzMjtCZWNhdXNlJiMzMjtDSUQmIzMyO2Rlcml2YXRpb24mIzMyO2hh
cHBlbnMmIzMyO2RlZXAmIzMyO2luc2lkZSYjMzI7ZmlybXdhcmUvc2VjdXJlLXdvcmxkCiYjMzI7
JiMzMjtib290JiMzMjtjb2RlJiMzMjt3aXRoJiMzMjtubyYjMzI7dXNlci12aXNpYmxlJiMzMjtl
cnJvciYjMzI7c3VyZmFjZSYjMzI7dW50aWwmIzMyO3RoZSYjMzI7UlBNQiYjMzI7SE1BQwomIzMy
OyYjMzI7Y2hlY2smIzMyO2FjdHVhbGx5JiMzMjtmYWlscywmIzMyO3RoaXMmIzMyO2NsYXNzJiMz
MjtvZiYjMzI7YnVnJiMzMjtpcyYjMzI7ZXNzZW50aWFsbHkmIzMyO3VuZGV0ZWN0YWJsZQomIzMy
OyYjMzI7aW4mIzMyO25vcm1hbCYjMzI7dGVzdGluZyYjMzI7YW5kJiMzMjtvbmx5JiMzMjtzdXJm
YWNlcyYjMzI7YXMmIzMyO2ZpZWxkJiMzMjtmYWlsdXJlcyYjMzI7YWZ0ZXImIzMyO2FuCiYjMzI7
JiMzMjt1cGdyYWRlJiMzMjsmIzgyMTI7JiMzMjtleGFjdGx5JiMzMjt0aGUmIzMyOyZxdW90O3Np
bGVudCwmIzMyO3VuZGV0ZWN0YWJsZSYjMzI7dW50aWwmIzMyO2l0JiMzMjtmYWlscyZxdW90OyYj
MzI7ZmFpbHVyZQomIzMyOyYjMzI7bW9kZSYjMzI7YWxyZWFkeSYjMzI7Y2FsbGVkJiMzMjtvdXQm
IzMyO2luJiMzMjt0aGUmIzMyO0NJRCYjMzI7YXBwZW5kaXguCi0mIzMyO1RoZXJlZm9yZSwmIzMy
O3RoZSYjMzI7Zml4JiMzMjtpcyYjMzI7bm90JiMzMjttZXJlbHkmIzMyO2EmIzMyO2RvY3VtZW50
YXRpb24vY29tbWVudCYjMzI7Y2hhbmdlOgomIzMyOyYjMzI7dGhlJiMzMjtwYXRjaCYjMzI7c2V0
JiMzMjtzaG91bGQmIzMyO3NoaXAmIzMyO3RoaXMmIzMyO2NvbmNlcm4mIzMyO2FzJiMzMjthJiMz
MjtidWlsZC10aW1lJiMzMjsoS2NvbmZpZyYjMzI7LwomIzMyOyYjMzI7ZGVmY29uZmlnKSYjMzI7
c2VsZWN0YWJsZSYjMzI7b3B0aW9uLCYjMzI7ZS5nLjoKCiYjMzI7JiMzMjtjb25maWcmIzMyO1VG
U19SUE1CX0NJRF9BTEdPX0JMQUtFMkIKJiMzMjsmIzMyOyYjMzI7JiMzMjsmIzMyOyYjMzI7JiMz
MjsmIzMyOyYjMzI7JiMzMjtzdHJpbmcmIzMyOyZxdW90O1VGUyYjMzI7UlBNQiYjMzI7Q0lEJiMz
MjtkZXJpdmF0aW9uJiMzMjthbGdvcml0aG0mcXVvdDsKJiMzMjsmIzMyOyYjMzI7JiMzMjsmIzMy
OyYjMzI7JiMzMjsmIzMyOyYjMzI7JiMzMjtkZXBlbmRzJiMzMjtvbiYjMzI7U1VQUE9SVF9VRlNf
UlBNQgomIzMyOyYjMzI7JiMzMjsmIzMyOyYjMzI7JiMzMjsmIzMyOyYjMzI7JiMzMjsmIzMyO2Rl
ZmF1bHQmIzMyOyZxdW90O2JsYWtlMmImcXVvdDsKJiMzMjsmIzMyOyYjMzI7JiMzMjsmIzMyOyYj
MzI7JiMzMjsmIzMyOyYjMzI7JiMzMjtoZWxwCiYjMzI7JiMzMjsmIzMyOyYjMzI7JiMzMjsmIzMy
OyYjMzI7JiMzMjsmIzMyOyYjMzI7JiMzMjsmIzMyO1NlbGVjdHMmIzMyO3doaWNoJiMzMjthbGdv
cml0aG0mIzMyO2Rlcml2ZXMmIzMyO3RoZSYjMzI7cGVyLXJlZ2lvbiYjMzI7UlBNQiYjMzI7Q0lE
CiYjMzI7JiMzMjsmIzMyOyYjMzI7JiMzMjsmIzMyOyYjMzI7JiMzMjsmIzMyOyYjMzI7JiMzMjsm
IzMyO2Zyb20mIzMyO1VGUyYjMzI7ZGV2aWNlJiMzMjtkZXNjcmlwdG9ycy4mIzMyO1RoaXMmIzMy
O3ZhbHVlJiMzMjtpcyYjMzI7YSYjMzI7c29mdHdhcmUKJiMzMjsmIzMyOyYjMzI7JiMzMjsmIzMy
OyYjMzI7JiMzMjsmIzMyOyYjMzI7JiMzMjsmIzMyOyYjMzI7Y29udmVudGlvbiYjMzI7d2l0aCYj
MzI7bm8mIzMyO2Jhc2lzJiMzMjtpbiYjMzI7dGhlJiMzMjtVRlMmIzMyO29yJiMzMjtSUE1CJiMz
MjtzcGVjaWZpY2F0aW9uCiYjMzI7JiMzMjsmIzMyOyYjMzI7JiMzMjsmIzMyOyYjMzI7JiMzMjsm
IzMyOyYjMzI7JiMzMjsmIzMyOyhVRlMmIzMyO2hhcyYjMzI7bm8mIzMyO2hhcmR3YXJlJiMzMjtD
SUQmIzMyO3JlZ2lzdGVyKTsmIzMyO2l0JiMzMjtleGlzdHMmIzMyO29ubHkmIzMyO3RvCiYjMzI7
JiMzMjsmIzMyOyYjMzI7JiMzMjsmIzMyOyYjMzI7JiMzMjsmIzMyOyYjMzI7JiMzMjsmIzMyO3Bv
cHVsYXRlJiMzMjt0aGUmIzMyO2ZpeGVkLXNpemUmIzMyO0NJRCYjMzI7ZmllbGQmIzMyO2luaGVy
aXRlZCYjMzI7ZnJvbSYjMzI7dGhlCiYjMzI7JiMzMjsmIzMyOyYjMzI7JiMzMjsmIzMyOyYjMzI7
JiMzMjsmIzMyOyYjMzI7JiMzMjsmIzMyO2VNTUMtb3JpZW50ZWQmIzMyO09QLVRFRSYjMzI7UlBN
QiYjMzI7QUJJLiYjMzI7UHJvZHVjdHMmIzMyO3RoYXQmIzMyO2hhdmUmIzMyO2FscmVhZHkKJiMz
MjsmIzMyOyYjMzI7JiMzMjsmIzMyOyYjMzI7JiMzMjsmIzMyOyYjMzI7JiMzMjsmIzMyOyYjMzI7
c2hpcHBlZCYjMzI7d2l0aCYjMzI7YSYjMzI7c3BlY2lmaWMmIzMyO0NJRCYjMzI7ZGVyaXZhdGlv
biYjMzI7TVVTVCYjMzI7a2VlcCYjMzI7dXNpbmcKJiMzMjsmIzMyOyYjMzI7JiMzMjsmIzMyOyYj
MzI7JiMzMjsmIzMyOyYjMzI7JiMzMjsmIzMyOyYjMzI7dGhhdCYjMzI7c2FtZSYjMzI7ZGVyaXZh
dGlvbiYjMzI7YWNyb3NzJiMzMjtmaXJtd2FyZSYjMzI7dXBkYXRlcywmIzMyO29yJiMzMjt0aGUK
JiMzMjsmIzMyOyYjMzI7JiMzMjsmIzMyOyYjMzI7JiMzMjsmIzMyOyYjMzI7JiMzMjsmIzMyOyYj
MzI7ZGVyaXZlZCYjMzI7UlBNQiYjMzI7YXV0aGVudGljYXRpb24mIzMyO2tleSYjMzI7d2lsbCYj
MzI7Y2hhbmdlJiMzMjthbmQmIzMyO2V4aXN0aW5nCiYjMzI7JiMzMjsmIzMyOyYjMzI7JiMzMjsm
IzMyOyYjMzI7JiMzMjsmIzMyOyYjMzI7JiMzMjsmIzMyO1JQTUItYmFja2VkJiMzMjtzZWN1cmUm
IzMyO3N0b3JhZ2UmIzMyO3dpbGwmIzMyO2JlY29tZSYjMzI7dW5yZWFkYWJsZS4KCiYjMzI7JiMz
Mjt3aXRoJiMzMjt0aGUmIzMyO0JMQUtFMmImIzMyO2ltcGxlbWVudGF0aW9uJiMzMjtpbiYjMzI7
dGhpcyYjMzI7c2VyaWVzJiMzMjt3aXJlZCYjMzI7aW4mIzMyO2FzJiMzMjtvbmUKJiMzMjsmIzMy
O3NlbGVjdGFibGUmIzMyO2JhY2tlbmQmIzMyOyhDT05GSUdfVUZTX1JQTUJfQ0lEX0FMR09fQkxB
S0UyQiksJiMzMjtzbyYjMzI7dGhhdCYjMzI7YQomIzMyOyYjMzI7dmVuZG9yJiMzMjthbHJlYWR5
JiMzMjtzaGlwcGluZyYjMzI7YSYjMzI7ZGlmZmVyZW50JiMzMjtzY2hlbWUmIzMyO2NhbiYjMzI7
c2VsZWN0JiMzMjt0aGVpciYjMzI7b3duCiYjMzI7JiMzMjtiYWNrZW5kJiMzMjthdCYjMzI7ZGVm
Y29uZmlnJiMzMjt0aW1lJiMzMjtpbnN0ZWFkJiMzMjtvZiYjMzI7YmVpbmcmIzMyO2ZvcmNlZCYj
MzI7b250byYjMzI7dGhpcwomIzMyOyYjMzI7c2VyaWVzJiMzOTtzJiMzMjtkZWZhdWx0JiMzMjth
bmQmIzMyO2JyZWFraW5nJiMzMjthbHJlYWR5LXByb3Zpc2lvbmVkJiMzMjtkZXZpY2VzJiMzMjtv
bgomIzMyOyYjMzI7dXBncmFkZS4KCkVhY2gmIzMyO3ZlbmRvciYjMzI7c2hvdWxkJiMzMjtiZSYj
MzI7YWJsZSYjMzI7dG8mIzMyO3Vwc3RyZWFtJiMzMjt0aGVpciYjMzI7b3duJiMzMjthbGdvJiMz
MjthbmQmIzMyO21vcmUuCkFuZCYjMzI7dGhlc2UmIzMyO2FsZ28mIzMyO3Nob3VsZCYjMzI7YmUm
IzMyO2NvbmZpZ3VyYWJsZSYjMzI7YnkmIzMyO3RoZSYjMzI7dXNlcnMmIzMyO29yJiMzMjtieSYj
MzI7Ym9hcmQmIzMyO21ha2Vycy4KRm9yJiMzMjtleGFtcGxlLCYjMzI7TWVkaWFUZWsmIzMyO2Fu
ZCYjMzI7VWJ1bnR1JiMzMjthcmUmIzMyO3VzaW5nJiMzMjtkaWZmZXJlbnQmIzMyO2FsZ28mIzMy
O2FuZCYjMzI7Q0lEJiMzMjtsZW5ndGgmIzMyO2ZvcgpVRlMmIzMyO1JQTUIuCgpIZXJlJiMzMjt3
ZSYjMzI7c3VnZ2VzdCYjMzI7dG8mIzMyO21ha2UmIzMyO3NvbWUmIzMyO2NoYW5nZSYjMzI7dG8m
IzMyO2luY3JlYXNlJiMzMjt0aGUmIzMyO2NvbXBhdGliaWxpdHkuCgoxLiYjMzI7U3BsaXQmIzMy
O3Vmc19ycG1iX2J1aWxkX2NpZCgpJiMzMjtpbnRvJiMzMjsoYSkmIzMyO2EmIzMyO2NvbW1vbiYj
MzI7aGVscGVyJiMzMjt0aGF0JiMzMjtyZWFkcyYjMzI7dGhlCiYjMzI7JiMzMjsmIzMyO1VGUyYj
MzI7ZGVzY3JpcHRvcnMmIzMyO2FuZCYjMzI7YnVpbGRzJiMzMjt0aGUmIzMyO2lkZW50aWZpZXIm
IzMyO3N0cmluZywmIzMyO2FuZCYjMzI7KGIpJiMzMjthCiYjMzI7JiMzMjsmIzMyO3BsdWdnYWJs
ZSYjMzI7c3RyaW5nLXRvLUNJRCYjMzI7YmFja2VuZCwmIzMyO3dpdGgmIzMyO0JMQUtFMmImIzMy
O2FzJiMzMjt0aGUmIzMyO2RlZmF1bHQKJiMzMjsmIzMyOyYjMzI7YmFja2VuZCYjMzI7cmF0aGVy
JiMzMjt0aGFuJiMzMjt0aGUmIzMyO29ubHkmIzMyO29uZS4KMi4mIzMyO01ha2UmIzMyO3RoZSYj
MzI7Q0lEJiMzMjtidWZmZXImIzMyO3NpemUmIzMyO2EmIzMyO3ZhcmlhYmxlJiMzMjtzaXplLCYj
MzI7b3ImIzMyO2F0JiMzMjtsZWFzdCYjMzI7cHJvcGVydHkmIzMyO3JldHVybmVkJiMzMjtieSYj
MzI7dGhlJiMzMjtzZWxlY3RlZAomIzMyOyYjMzI7JiMzMjtiYWNrZW5kJiMzMjtyYXRoZXImIzMy
O3RoYW4mIzMyO2EmIzMyO2ZpeGVkJiMzMjtVRlNfUlBNQl9DSURfU0laRSYjMzI7PSYjMzI7MTYm
IzMyO2NvbnN0YW50JiMzMjtpbgomIzMyOyYjMzI7JiMzMjtjb21tb24mIzMyO2NvZGUuCjMuJiMz
MjtBZGQmIzMyO2EmIzMyO0tjb25maWcmIzMyO2Nob2ljZSYjMzI7KGUuZy4mIzMyO1VGU19SUE1C
X0NJRF9BTEdPX0JMQUtFMikmIzMyO3NvJiMzMjt2ZW5kb3JzJiMzMjtjYW4KJiMzMjsmIzMyOyYj
MzI7c2VsZWN0JiMzMjt0aGVpciYjMzI7ZXhpc3RpbmcvbGVnYWN5JiMzMjtDSUQmIzMyO2Rlcml2
YXRpb24mIzMyO2F0JiMzMjtkZWZjb25maWcmIzMyO3RpbWUuCjQuJiMzMjtEb2N1bWVudCYjMzI7
ZXhwbGljaXRseSwmIzMyO2luJiMzMjtjb2RlJiMzMjtjb21tZW50cyYjMzI7YW5kJiMzMjtLY29u
ZmlnJiMzMjtoZWxwJiMzMjt0ZXh0LCYjMzI7dGhhdAomIzMyOyYjMzI7JiMzMjt0aGlzJiMzMjt2
YWx1ZSYjMzI7aXMmIzMyO2EmIzMyO3NvZnR3YXJlJiMzMjtBQkkmIzMyO2NvbnZlbnRpb24mIzMy
O3dpdGgmIzMyO25vJiMzMjtiYXNpcyYjMzI7aW4mIzMyO3RoZSYjMzI7VUZTCiYjMzI7JiMzMjsm
IzMyO29yJiMzMjtSUE1CJiMzMjtzcGVjaWZpY2F0aW9uLCYjMzI7YW5kJiMzMjt0aGF0JiMzMjtj
aGFuZ2luZyYjMzI7aXQmIzMyO29uJiMzMjthbiYjMzI7YWxyZWFkeS1zaGlwcGVkCiYjMzI7JiMz
MjsmIzMyO3Byb2R1Y3QmIzMyO2lzJiMzMjthJiMzMjticmVha2luZyYjMzI7Y2hhbmdlJiMzMjt0
byYjMzI7dGhhdCYjMzI7cHJvZHVjdCYjMzk7cyYjMzI7UlBNQiYjMzI7a2V5JiMzMjttYXRlcmlh
bC4KClRoYW5rcwpNYWNwYXVsJiMzMjtMaW4NCjwvcHJlPg0KPC9wPjwvYm9keT48L2h0bWw+PCEt
LXR5cGU6dGV4dC0tPjwhLS17LS0+PHByZT4qKioqKioqKioqKioqIE1FRElBVEVLIENvbmZpZGVu
dGlhbGl0eSBOb3RpY2UgKioqKioqKioqKioqKioqKioqKioNClRoZSBpbmZvcm1hdGlvbiBjb250
YWluZWQgaW4gdGhpcyBlLW1haWwgbWVzc2FnZSAoaW5jbHVkaW5nIGFueSANCmF0dGFjaG1lbnRz
KSBtYXkgYmUgY29uZmlkZW50aWFsLCBwcm9wcmlldGFyeSwgcHJpdmlsZWdlZCwgb3Igb3RoZXJ3
aXNlDQpleGVtcHQgZnJvbSBkaXNjbG9zdXJlIHVuZGVyIGFwcGxpY2FibGUgbGF3cy4gSXQgaXMg
aW50ZW5kZWQgdG8gYmUgDQpjb252ZXllZCBvbmx5IHRvIHRoZSBkZXNpZ25hdGVkIHJlY2lwaWVu
dChzKS4gQW55IHVzZSwgZGlzc2VtaW5hdGlvbiwgDQpkaXN0cmlidXRpb24sIHByaW50aW5nLCBy
ZXRhaW5pbmcgb3IgY29weWluZyBvZiB0aGlzIGUtbWFpbCAoaW5jbHVkaW5nIGl0cyANCmF0dGFj
aG1lbnRzKSBieSB1bmludGVuZGVkIHJlY2lwaWVudChzKSBpcyBzdHJpY3RseSBwcm9oaWJpdGVk
IGFuZCBtYXkgDQpiZSB1bmxhd2Z1bC4gSWYgeW91IGFyZSBub3QgYW4gaW50ZW5kZWQgcmVjaXBp
ZW50IG9mIHRoaXMgZS1tYWlsLCBvciBiZWxpZXZlIA0KdGhhdCB5b3UgaGF2ZSByZWNlaXZlZCB0
aGlzIGUtbWFpbCBpbiBlcnJvciwgcGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVyIA0KaW1tZWRpYXRl
bHkgKGJ5IHJlcGx5aW5nIHRvIHRoaXMgZS1tYWlsKSwgZGVsZXRlIGFueSBhbmQgYWxsIGNvcGll
cyBvZiANCnRoaXMgZS1tYWlsIChpbmNsdWRpbmcgYW55IGF0dGFjaG1lbnRzKSBmcm9tIHlvdXIg
c3lzdGVtLCBhbmQgZG8gbm90DQpkaXNjbG9zZSB0aGUgY29udGVudCBvZiB0aGlzIGUtbWFpbCB0
byBhbnkgb3RoZXIgcGVyc29uLiBUaGFuayB5b3UhDQo8L3ByZT48IS0tfS0tPg==

--__=_Part_Boundary_003_840162234.1339068595--

