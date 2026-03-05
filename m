Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6C15F30931
	for <u-boot@archiver.kernel.org>; Thu,  5 Mar 2026 10:39:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1639283FA5;
	Thu,  5 Mar 2026 11:39:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="R0UuEgQu";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="IdkX+zys";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FFC383FC5; Thu,  5 Mar 2026 11:38:59 +0100 (CET)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E916B83F9D
 for <u-boot@lists.denx.de>; Thu,  5 Mar 2026 11:38:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macpaul.lin@mediatek.com
X-UUID: 805f17e2187f11f1bcd7499a721e883d-20260305
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=OPGslUnMKzDnhbq+nsdgradQ9av18/GNqi8umuHHHKw=; 
 b=R0UuEgQuSIqH6EV9JNamuY7CcexQDWydj7yhoJoMRYaEaIj65/s7S6usMGv4WdL7lW4eNU0MGCc9iJcNcTYCkDzcfFawn7Q8HrxrpvtN8ejFT/AWTCDOi86CDOwOv3atIKPLM8zkF++5+9HB4O8sey46s/h3QvtUlHGOMDsJ3fE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11, REQID:94b99f67-76e7-47dd-bd1e-f8771557c594, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:89c9d04, CLOUDID:f14f47ea-ef90-4382-9c6f-55f2a0689a6b,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
 TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BE
 C:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 805f17e2187f11f1bcd7499a721e883d-20260305
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by
 mailgw01.mediatek.com (envelope-from <macpaul.lin@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1262690139; Thu, 05 Mar 2026 18:38:51 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 5 Mar 2026 18:38:50 +0800
Received: from SG2PR04CU009.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 5 Mar 2026 18:38:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=thVw1+JvGEScq6Ak0gJ+xZuHWCBux+MmFiRzq13SLrD9mBhPwVwigknjVcT/NHTErlbkD7FlXfTMAu97JcFcREKZRKSjScCRzcyOt9JYWMVv1Q/AsCE1Vg4vXXnZfAUrCHd7mqjQsLn4W86FvW8B97sJltuLh/yzVtim3DLIOtrUitEpjNOYjOPOPady41y/rVXXfnTtQQBjSi84IwTDJmil0oIyCXHaoNkzKMIL33K9np/MzW7ulOeYOaq25jdPJPX2d8dDzEzdoZd1/Hyakm/m0XPEzxvrm5TchKq2wqzKsxKz186aYY90pt+PF8TnmEzyafHRDdJVVP+2uiQ/sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OPGslUnMKzDnhbq+nsdgradQ9av18/GNqi8umuHHHKw=;
 b=GN1KiH4q3QFoDi9anFVX1pyPcuuWy88bcGb09mn/4gjLQnXWC2DPN7lojpqp0Gvd1wgsgcmAWMuFMTzJZZMzztFRHth7kzTEcyMGjqm3G6S8evLSB6JVnMTYhSshEysyhNGVmBg7iYRjnySk16a2fDBgPP2VfWy170Ewql9qJ9ykBiYiqsPKMko1LYF95tAt1NtaNRFOtassPBq6Rt10rbr0xB/iQplmRJXj8VQtyOS9BbZgH0XgdSrvV3/nitVU7iV80AFjGWLW4RnTxWnQQiZHYsQQ/UUZFtFO6RN5Wc7FiYwilTTglIzNwBonqAGubztm4bfYN0bsoLclr1jTYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OPGslUnMKzDnhbq+nsdgradQ9av18/GNqi8umuHHHKw=;
 b=IdkX+zysmZOWZ7E4BXsxORFR6JlOT3tiMWr1wLroxvcqrbqmJW4izsiy6sK51u2iFowAloSAWtKVrceJaCv5tIh/WfgdimlrOwhHdd9UUvQpa2QjyRqm4dTVadFO0MAsNuA/nEThrMnqRxsSlwA56QJIZOrUx86Jec1bWawIUd8=
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com (2603:1096:101:184::13)
 by OSQPR03MB8644.apcprd03.prod.outlook.com (2603:1096:604:297::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Thu, 5 Mar
 2026 10:38:41 +0000
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8]) by SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8%4]) with mapi id 15.20.9678.017; Thu, 5 Mar 2026
 10:38:40 +0000
From: =?utf-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>
To: David Lechner <dlechner@baylibre.com>,
 =?utf-8?B?QmVhciBXYW5nICjokKnljp/mg5/lvrcp?= <bear.wang@mediatek.com>,
 =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= <Chunfeng.Yun@mediatek.com>,
 "lukma@denx.de" <lukma@denx.de>, "trini@konsulko.com" <trini@konsulko.com>,
 "igor.belwon@mentallysanemainliners.org"
 <igor.belwon@mentallysanemainliners.org>, Ryder Lee <Ryder.Lee@mediatek.com>, 
 =?utf-8?B?V2VpamllIEdhbyAo6auY5oOf5p2wKQ==?= <Weijie.Gao@mediatek.com>,
 =?utf-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?= <pablo.sun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 =?utf-8?B?Q2hyaXMtcWogQ2hlbiAo6Zmz5aWH6YCyKQ==?= <Chris-qj.Chen@mediatek.com>
CC: Julien Stephan <jstephan@baylibre.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
Subject: Re: [PATCH 01/14] clk: mediatek: move common PARENT macros to header
Thread-Topic: [PATCH 01/14] clk: mediatek: move common PARENT macros to header
Thread-Index: AQHcqqGDtLg4BLiaxU+KnjDfa8/HxbWfwzGA
Date: Thu, 5 Mar 2026 10:38:40 +0000
Message-ID: <b0a6f9c9a106ca14924acbdfed079ae9a38433e8.camel@mediatek.com>
References: <20260302-clk-mtk-unify-mux-parents-v1-0-32f45085f4d0@baylibre.com>
 <20260302-clk-mtk-unify-mux-parents-v1-1-32f45085f4d0@baylibre.com>
In-Reply-To: <20260302-clk-mtk-unify-mux-parents-v1-1-32f45085f4d0@baylibre.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7810:EE_|OSQPR03MB8644:EE_
x-ms-office365-filtering-correlation-id: cf29224c-bf3d-40e7-969d-08de7aa35dd4
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|921020|38070700021; 
x-microsoft-antispam-message-info: /SmUnNGoU4tZlO4OUfdp+zbXUntfx6kYS55FMy9q+n/jSUbuQkDjX2XGXwvuAI8mOMTcYc+sgNDyvhLHR3h9Yu2rRp8R9OT0aoNhjcwjZ16f65vtkYiS4YmxB5zfJFHOk55flawXLT7Q2NrwCOtdk/CGxs5tBg3sOEik7ZwAmoOfW7dZCxwstW24n133qb22bhLfINJfX6dhuTlPw/bNiarXE9UUa/Udk4HmBPOPcQWdqivU0+VK6jbVM92EmlTObceBekqCZGAkfCU+XFXp6SN0Y7+sAm7CtfZLf9nj/U4S1Vm3vzErjSGR4gb+57iSFWmXfXNqrMlriSMvPFecU0Jvrm+uZtuO7mmm66gK06hTuBB7qNUvv74g+5D2fwpZdqSB1blm/hHykfwzM/FOQxtsOPk6t7ehjbIPLvhGbxpPJfmUqpCR0QqLe5BMR2tQyhapWhwbQxJltu3t44ZaKTqTQwWo4pFsJ/Zlxlnsad45qwZBkc04oAaOJPd7JhYid/VPSGPGI5Zb5AEld+u741YYOzzZv0NkbfQJLpSnCEAaC9R7lebQmLmV7uJfYg7dTtAAGuZSMlUbc8jx2oYmG0N/mgs0/wWF5dUi/aH17wHu/GMBbj0n00OIt03GPjnCQ3tu579SbeKmetaO8ZcRNmWp7UuPlNPTPp7p71JzYbZvYabYX9mOTZHszdZLNLQ58IY4LeSxsagv5iaaXWALiXpherFLfgsGY8QSh8NGTkurei8nLRf5rUm7ZrX0Bi7rMrQeVMHhdCNqt7zX9wIhPc1DXkO9O5tUldrFWV62UUqAfg6hQrYcqKCZAD6Qwp2F
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR03MB7810.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(921020)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YlltNStSRUxhTTF4b2NsZ00xeWw5TTBQZnZ3Q3hnTm1vREQvUW1IdFg4RWgv?=
 =?utf-8?B?USt3b1kzN2FCUWhpZ2NxdHd1UWhxQWVBTlFOdXpzR2dkL0ZZZlpIL1ppQ3RH?=
 =?utf-8?B?MVkxUVBUR05YUitTbmR5ZFBRRTk2OGRBdVhHUzhweDhVZjNTS3Z2akxTNkJh?=
 =?utf-8?B?a1BjZzY2UmZsSkVvSDBLckViSGlsOG9oTDJ6ZStNV0RBc3d0S0kwc2M2S2kv?=
 =?utf-8?B?L3ZHNVVoZ2cyUDkzWjFzTlZBVDdTVTIxNVVEVDMzemlGT0xOU2FpU0h4T1A4?=
 =?utf-8?B?cG9QRVZYZHg1UGFoYzRmb0EwY094Q0VadHRNTUJLdXVsQ2t2V2Vpb1FMZEk3?=
 =?utf-8?B?ZGtmcmk0SHd2Z25GNkc1cG9BRG1BTTF5TUEyWkhHS2FDeTJoMDhTTW9DUi9C?=
 =?utf-8?B?RnpSa2hqbDY1dmJPUzVwQ3gxYnczYjJYdDVWZkoyU2lwNXhIUkFBQTYwM3hj?=
 =?utf-8?B?Q1RyWXNzc2IxZlljSGJUdkFEY3NJTndndGhjNUJ4NGZnV0hDNTBRLzBybkN4?=
 =?utf-8?B?K1NLZUdBS0tRVmRhVTJXYi9XWHRBL1VLcUpXTVdlOXpCMHNDUFp4cGowd01E?=
 =?utf-8?B?VXhNUHpaYXRnUEZURU50RzZTcmxFdXN6MFpvbG1GNkYwUlo2UU1hajZ4NUFL?=
 =?utf-8?B?amNyTk9oMTcrVTRqWG9qN0pJRlVObWpYM1hNSFdLdUZFT2p1Q25oRGErWHYr?=
 =?utf-8?B?LzFJRks1bjR6VUdUTFdFbEJFQ2x6Vm5rK0hyamQwQ2dGTjFjc0J2cVpaMy9I?=
 =?utf-8?B?TE94YVI5TlYrdXNUNE5GNGlHTkJ3U29GMEVsZWIzbEx1ZTVpa1JlMW90SWVI?=
 =?utf-8?B?OHVVL081VGJQU28rQVFrQ1F0elFmU2pWVFdMNDlOTjRHSHZsMUVZS3I1bmQr?=
 =?utf-8?B?T1R2akM1ZEc3c2pxZitVUWJnMzdUakZ2d2Q4b0NoU0F3cThXL0E4K3d2YTRQ?=
 =?utf-8?B?TUpKeWIydU05MzZtYXlPWWJEQ1FiZ255OWZlS3hOQU1DSU95bTloc09aa0lh?=
 =?utf-8?B?SWp6R0VXaXZsVHlqS1gyS2JiZHBZMDZrdWhBTktoNkZSS0lISGpyTldmOHV1?=
 =?utf-8?B?MFMwbHd2NFdnUHBDb2ZscG10bDEwY24zOUFCRXg1d1hUcHNSK1YrQ2xVU3pK?=
 =?utf-8?B?WWQvU05mNWEyOFZxNytmaTkvWkg0L1VzaVlZRE1wa0lPUWk3ZzU2dXp1SzJP?=
 =?utf-8?B?SkxYMXdDcVZSMUxqaDE4U1lnYjdaZzVRQ1B6NXZjdXg2enc5OHNteUhTd1Nq?=
 =?utf-8?B?VjEwdWZEWklRZitsTGxDbGVJVUJwZkVKSXRwSk51eEgxdDFqNzFETHpaa0kz?=
 =?utf-8?B?OWdXaHcxTlNZRTU2MVNlZ1Y2L282WUZDU2pINXFCRWFvZGZzSHc5UzV0b21Y?=
 =?utf-8?B?SEFGb2duckhabnd3Vml5L2VsSVErSmo4bTVVaHd0bWNlQVBSV01LTy9lT1Zq?=
 =?utf-8?B?TWdSMTJKeFVFbkNXU2txaU5KWHJrVVp3R0F4MVJKbTJ3UkI4NzZPcDFWekZm?=
 =?utf-8?B?U0E3dHlhMmtpcTFuM2gzYVBoYUR3azJLU0VSbTM2MTd6dHZyWVNPamp2VXRT?=
 =?utf-8?B?SVFvUnJxM1VtS1poN2o0dm1sMlUrN3NqbHJRRVc4SzJCWUNpL2s3MTBORVNO?=
 =?utf-8?B?V1c3OGdKcytXcDEvRmFPeDFmeUJVcW14Mnd0OStBUnFZdk9mbTViL2tPTlBi?=
 =?utf-8?B?SDUrMmtsUjdmSkVubWdDRS9RUDJKSXlLRDU2dVJ1QWcvOXM2TmVUVVlDQVZi?=
 =?utf-8?B?VkZSOG1QVkdsT2I4VWZKZi9LcUxZWXQyYWZVbzYxZVNONU5aWGRZNTBRRjUv?=
 =?utf-8?B?OHRFZGw1bnoxL1lESklTMWpNc29vTG90bXdRZDFNUVRLRnh4ZzlCa3BrOUMw?=
 =?utf-8?B?M0k5OUxTSDlMeVI3blU5aXIxT3ZaWXdLd3ZhY05oWFZ0YmRnVncwTWhnYW5l?=
 =?utf-8?B?bWdDNWpkUWg5eDRhR0ZvSkk5L0M5M290NGlKV0NYS01IZW1XR2Z3QTFrd2Ni?=
 =?utf-8?B?c0tUQzQ3VStrbXNTRmRxWkdxY2FQUUY1SmNPUy9BeDN0L2NDWFF5WkRwbVVu?=
 =?utf-8?B?T0FYS3B5VG1UQXhlVjRHcmJ0bU1ZZ3RDcDAyb0kyOVhRMVh6OWt0OXYxbmxN?=
 =?utf-8?B?Uy82M0VJT0JrRExEZVJ5ZkozQmhtaisyZDRVVnArUjlackxpU1V5NzIyUTE5?=
 =?utf-8?B?MXo3M1cwTXhqczRmZkdpYk9QZ0pLdW1LWnFCTFdqdXJnS0E2NUFqb1FJb0hW?=
 =?utf-8?B?Y0pIVisxMSs5VGpaMnVYR1Y3Lzdqa1RnY3F3Q2NJRFdIQzhJcGxpVHdXK096?=
 =?utf-8?B?aWN1TFUyRDkzRWo0WWNFdk1rWkQ2V2NqTWV3cHlnUjQvUDZQZUdZQzYrUjFK?=
 =?utf-8?Q?oJmkZ2oVcWmMsDQU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4ED2FA3F2D0ACC4DAEE959C1A164D0C0@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: vWr4svSXNdNTiiuh/JD5aPi8p+jyv8tWHJW7ECCEvw65fCGfZqHvEPq23Adz4C5pKiobawy6kZ/BAeC212cW8BY+8tUlZyrwtybqopFvDQEXNalA7NC2EanLFIOsag6rAIAirYuhbTcAj2o8jv45kVan0HYhHDKvPI6QaOaUJUgZ5QXVnUI5qHuSgAvtwOQJZuAI3yyn0E9pfjB0KPv3oWRWwQx1w9MlmlOAbuXTtIjXdFHsFx8jH7wiwj26xDgJ3C9k8M6HXMbhLMnslDRbffSD1svctZ2jV7ElcbMgHyOcJ3o/q705Y1kDoT5VauKWt6YvnIjPadOqqDT83TyOew==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7810.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf29224c-bf3d-40e7-969d-08de7aa35dd4
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2026 10:38:40.5054 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zhcA+m2erLDIqM0dGDGb1uLpV3iFLtnKjND1L+XDW38BVXtjKLUnEFekfuwdQ67DYcONvJIObOAI+JbTdpQbShtTlaIP/HYAF9Yi9gD8rS0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR03MB8644
X-MTK: N
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

T24gTW9uLCAyMDI2LTAzLTAyIGF0IDE4OjAzIC0wNjAwLCBEYXZpZCBMZWNobmVyIHdyb3RlOg0K
PiBNb3ZlIHJlcGVhdGVkICpfUEFSRU5UKCkgbWFjcm9zIGZyb20gY2hpcC1zcGVjaWZpYyAuYyBm
aWxlcyB0byB0aGUNCj4gY29tbW9uIG10ay1jbGsuaCBmaWxlLg0KPiANCj4gU2lnbmVkLW9mZi1i
eTogRGF2aWQgTGVjaG5lciA8ZGxlY2huZXJAYmF5bGlicmUuY29tPg0KPiAtLS0NCj4gwqBkcml2
ZXJzL2Nsay9tZWRpYXRlay9jbGstbXQ3NjIyLmMgfCA4IC0tLS0tLS0tDQo+IMKgZHJpdmVycy9j
bGsvbWVkaWF0ZWsvY2xrLW10NzYyMy5jIHwgNiAtLS0tLS0NCj4gwqBkcml2ZXJzL2Nsay9tZWRp
YXRlay9jbGstbXQ3NjI5LmMgfCA0IC0tLS0NCj4gwqBkcml2ZXJzL2Nsay9tZWRpYXRlay9jbGst
bXQ3OTgxLmMgfCA1IC0tLS0tDQo+IMKgZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xrLW10Nzk4Ni5j
IHwgNSAtLS0tLQ0KPiDCoGRyaXZlcnMvY2xrL21lZGlhdGVrL2Nsay1tdDc5ODcuYyB8IDQgLS0t
LQ0KPiDCoGRyaXZlcnMvY2xrL21lZGlhdGVrL2Nsay1tdDc5ODguYyB8IDQgLS0tLQ0KPiDCoGRy
aXZlcnMvY2xrL21lZGlhdGVrL2Nsay1tdDgxODkuYyB8IDQgLS0tLQ0KPiDCoGRyaXZlcnMvY2xr
L21lZGlhdGVrL2Nsay1tdGsuaMKgwqDCoCB8IDcgKysrKysrKw0KPiDCoDkgZmlsZXMgY2hhbmdl
ZCwgNyBpbnNlcnRpb25zKCspLCA0MCBkZWxldGlvbnMoLSkNCj4gDQo+IA0KPiBbc25pcC4uLl0N
Cj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9tZWRpYXRlay9jbGstbXQ4MTg5LmMNCj4g
Yi9kcml2ZXJzL2Nsay9tZWRpYXRlay9jbGstbXQ4MTg5LmMNCj4gaW5kZXggNGFkZTAzZjJmNmMu
Ljc0NGU2NDRmMTM4IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2Nsay9tZWRpYXRlay9jbGstbXQ4
MTg5LmMNCj4gKysrIGIvZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xrLW10ODE4OS5jDQo+IEBAIC00
MjksMTAgKzQyOSw2IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2ZpeGVkX2ZhY3Rvcg0KPiB0
b3BfZml4ZWRfZGl2c1tdID0gew0KPiDCoAlGQUNUT1IxKENMS19UT1BfT1NDX0QyMCwgQ0xLX1BB
RF9VTFBPU0MsIDEsIDIwKSwNCj4gwqB9Ow0KPiDCoA0KPiAtI2RlZmluZSBFWFRfUEFSRU5UKGlk
KSBQQVJFTlQoaWQsIENMS19QQVJFTlRfRVhUKQ0KPiAtI2RlZmluZSBBUE1JWEVEX1BBUkVOVChp
ZCkgUEFSRU5UKGlkLCBDTEtfUEFSRU5UX0FQTUlYRUQpDQo+IC0jZGVmaW5lIFRPUF9QQVJFTlQo
aWQpIFBBUkVOVChpZCwgQ0xLX1BBUkVOVF9UT1BDS0dFTikNCj4gLQ0KPiDCoHN0YXRpYyBjb25z
dCBzdHJ1Y3QgbXRrX3BhcmVudCBheGlfcGFyZW50c1tdID0gew0KPiDCoAlFWFRfUEFSRU5UKENM
S19QQURfQ0xLMjZNKSwNCj4gwqAJVE9QX1BBUkVOVChDTEtfVE9QX01BSU5QTExfRDRfRDQpLA0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xrLW10ay5oDQo+IGIvZHJpdmVy
cy9jbGsvbWVkaWF0ZWsvY2xrLW10ay5oDQo+IGluZGV4IDgzNzRlZDVjZTc4Li41ODhjOTQwYjcx
NSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xrLW10ay5oDQo+ICsrKyBi
L2RyaXZlcnMvY2xrL21lZGlhdGVrL2Nsay1tdGsuaA0KPiBAQCAtMTIyLDYgKzEyMiwxMyBAQCBz
dHJ1Y3QgbXRrX3BhcmVudCB7DQo+IMKgCQkuZmxhZ3MgPSBfZmxhZ3MsCQkJXA0KPiDCoAl9DQo+
IMKgDQo+ICsjZGVmaW5lIEFQTUlYRURfUEFSRU5UKGlkKQlQQVJFTlQoaWQsIENMS19QQVJFTlRf
QVBNSVhFRCkNCj4gKyNkZWZpbmUgVE9QX1BBUkVOVChpZCkJCVBBUkVOVChpZCwgQ0xLX1BBUkVO
VF9UT1BDS0dFTikNCj4gKyNkZWZpbmUgSU5GUkFfUEFSRU5UKGlkKQlQQVJFTlQoaWQsIENMS19Q
QVJFTlRfSU5GUkFTWVMpDQo+ICsjZGVmaW5lIFhUQUxfUEFSRU5UKGlkKQkJUEFSRU5UKGlkLCBD
TEtfUEFSRU5UX1hUQUwpDQo+ICsjZGVmaW5lIEVYVF9QQVJFTlQoaWQpCQlQQVJFTlQoaWQsIENM
S19QQVJFTlRfRVhUKQ0KPiArI2RlZmluZSBWT0lEX1BBUkVOVAkJUEFSRU5UKC0xLCAwKQ0KPiAr
DQo+IMKgLyoqDQo+IMKgICogc3RydWN0IG10a19jb21wb3NpdGUgLSBhZ2dyZWdhdGUgY2xvY2sg
b2YgbXV4LCBkaXZpZGVyIGFuZCBnYXRlDQo+IGNsb2Nrcw0KPiDCoCAqDQo+IA0KDQpSZXZpZXdl
ZC1ieTogTWFjcGF1bCBMaW4gPG1hY3BhdWwubGluQG1lZGlhdGVrLmNvbT4NCg0KVGhhbmtzIQ0K
TWFjcGF1bCBMaW4NCg==
