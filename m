Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B185FEB48F3
	for <u-boot@archiver.kernel.org>; Thu, 12 Feb 2026 10:26:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E32983CB5;
	Thu, 12 Feb 2026 11:26:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="IeYDvzNG";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="VgzPM0dL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7126F83C4B; Thu, 12 Feb 2026 11:26:51 +0100 (CET)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20BC183CE3
 for <u-boot@lists.denx.de>; Thu, 12 Feb 2026 11:26:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macpaul.lin@mediatek.com
X-UUID: 537f5f6c07fd11f185319dbc3099e8fb-20260212
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=EavOBKlc+eeFbqMv225GHzAnXSCZVpXAh3ehv7doXDM=; 
 b=IeYDvzNGngQMl/9pO4dgdI075ZKosgNDlOEbvzphz28oPIXFjGMmYNKVdy+j5ebDguEhv4WExr13uRc/kpXK5UQJ37hPVcr7HPoWmunZt/s/vvdr6RQtaJ066WYJmhTy6PNYodPAJUgy0aDEx1RpKETteU0pHa9JWU/4hJbbVUc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11, REQID:73494d3a-43cb-4839-beb0-c00abc45211d, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:89c9d04, CLOUDID:7c5a395b-a957-4259-bcca-d3af718d7034,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
 TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BE
 C:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 537f5f6c07fd11f185319dbc3099e8fb-20260212
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by
 mailgw01.mediatek.com (envelope-from <macpaul.lin@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 42464677; Thu, 12 Feb 2026 18:26:43 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 12 Feb 2026 18:26:42 +0800
Received: from SG2PR04CU009.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 12 Feb 2026 18:26:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=St1ziGDROTcq7IFlTqzrN2XDu77xyJT9PNzheXzFgR2OX2BWRCxPUs3GLzJ0/DFI1blbRhU4uDOAnODPiCckaPVamspopCGMccXE/vNLjHbFcyEgeJdMmPltA4NnkjRHnHWQncMQSie9YP4l03UAquPUe3Wvl0WfIHk0wvp++ECPxbhJK0IcC+HBWzzWHQFyyyAnhxoKtNzItGM5S7jCmSudxFhamsth7jts/spUqfgEsRqpSqnX+TyvIZxlcmrGAbRu04ZQu5Lsj1uOfMy1BORLHtC7XM7QYwyLTNR/VZ+YX1AOgtj0Eumk32mea772k0WMBYebScDLhifqyZ23Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EavOBKlc+eeFbqMv225GHzAnXSCZVpXAh3ehv7doXDM=;
 b=gy1kcyPhVRTN4zFu5yBN53DfjF1punfepu5RT+aYB9ZrG6K8hLPI9PEluTHXOysTHRi/4zJFMaWyElKPzPvkwdzSI0Bwls0OalJStecYayQ7C1tmMwTSagC/mXdhfuxsh5vJvV8NFME5Un2atdiF8nct0SYRZQOTTg9vy7ircK74CCDJO9UvErWQLg7sgt27UI0oWlKRg2x9E7GBXHYYm9llutIBVAFOaqvUrPTuGeZgNL3q6RBttYcAQ/EcvuWXDh0sDfyx/78klxbyrsaMAPSXIp8cjZTxaFwUlXyELV0xANH/1p3shaAJHytcdqCx8/M2reKfDc+lO9SEDjyiAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EavOBKlc+eeFbqMv225GHzAnXSCZVpXAh3ehv7doXDM=;
 b=VgzPM0dLgNxLYUSoJ0qUNpqaFkHBJwabVf5TyAg0U43m6oStHL90fiRKjkativDLwElHvP/ffPn+hS0IejCqBDJUz1a6Nj49bWhMW3AktOQkGtD08gjXkbqo7MjQpLfzuLlqpjphDWl88KzxnTapvVcYUI21mACkyreeslHwfv4=
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com (2603:1096:101:184::13)
 by KL1PR03MB7406.apcprd03.prod.outlook.com (2603:1096:820:ec::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.17; Thu, 12 Feb
 2026 10:26:39 +0000
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8]) by SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8%4]) with mapi id 15.20.9611.008; Thu, 12 Feb 2026
 10:26:38 +0000
From: =?utf-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>
To: David Lechner <dlechner@baylibre.com>,
 =?utf-8?B?QmVhciBXYW5nICjokKnljp/mg5/lvrcp?= <bear.wang@mediatek.com>,
 =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= <Chunfeng.Yun@mediatek.com>,
 "trini@konsulko.com" <trini@konsulko.com>, Ryder Lee
 <Ryder.Lee@mediatek.com>, "igor.belwon@mentallysanemainliners.org"
 <igor.belwon@mentallysanemainliners.org>,
 =?utf-8?B?V2VpamllIEdhbyAo6auY5oOf5p2wKQ==?= <Weijie.Gao@mediatek.com>,
 =?utf-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?= <pablo.sun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
CC: Julien Stephan <jstephan@baylibre.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
Subject: Re: [PATCH 2/3] pinctl: mediatek: increase max number of base
 addresses
Thread-Topic: [PATCH 2/3] pinctl: mediatek: increase max number of base
 addresses
Thread-Index: AQHcmh4YvjCadr4DlEiHc4AeH3pJz7V+3+cA
Date: Thu, 12 Feb 2026 10:26:38 +0000
Message-ID: <f517099b1f4fcfb974d106316dd31c4826872b42.camel@mediatek.com>
References: <20260209-mtk-pinctl-mt8189-v1-0-a7a3069eda6c@baylibre.com>
 <20260209-mtk-pinctl-mt8189-v1-2-a7a3069eda6c@baylibre.com>
In-Reply-To: <20260209-mtk-pinctl-mt8189-v1-2-a7a3069eda6c@baylibre.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7810:EE_|KL1PR03MB7406:EE_
x-ms-office365-filtering-correlation-id: 0db8f434-8da0-4055-e746-08de6a2134fb
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?Ty8rOXpQeHgybDRsNWlVZzFFVWt3NXZuWjllKzVVbm8xekk1aWpNNlVNUUlT?=
 =?utf-8?B?bnVoSzcyanROY2Q1YVUrSndoSk9pYkpEdkhxcXkxNnh5OUtwN1F1STV5aG1v?=
 =?utf-8?B?N29PRFdzWkV3eXg3em9OWEI2WHFKVy9wd0NrR2VHeXNkUW5mZDdTTEx3cHox?=
 =?utf-8?B?bWFFeE0vaDl6T2FHQmhjQkpyVGJSMUY2Q2tQUW02c1dtL1dId21kWTNoeUoy?=
 =?utf-8?B?QittL3BUS3dNNGpHMXhGTFU2TkVrMHM3Z1lZQis4bEFBWHFPMWxwbUJQcHZM?=
 =?utf-8?B?Tmpka0h0YnlPRTZVN3hNR2o4dGpFUE5QMzdjak9KWlF2M1BHUHBkOUZNTGxn?=
 =?utf-8?B?NVNmK1JvUTJMZU5ldG0xemFrVjZaSnIwc1F0WW4xYWg1MUJsT1lsZFpkVlNM?=
 =?utf-8?B?UStwc05FM1lkTFJXbmZHTUFqOXVVd0tQeTlQSGRYZ2puaFNDVjRTT3ZrMWRz?=
 =?utf-8?B?azNxckVxM1lObkNzUlg2ZGJiTmZPUjhSaDFtZlBhZ0l4ajNNNkhiUlhKTFZy?=
 =?utf-8?B?REJZNTR4V1o4VElpMDllbmNvdTNURGg2L1oyQkQ2clk3SmQxVW1ybGJHYWx6?=
 =?utf-8?B?K05NN2cvRzhKTXRyRkpLS3JNRE5ZK2U1K0hleWlyTkNrSFNhdmpLTS92c3NI?=
 =?utf-8?B?SitXTjNuNWdDYXRHamd6M1ByZUVuYzZycVI1cnpTRzNTdmNTRTQrcy9SQ0F1?=
 =?utf-8?B?LzFWL28wUGdGcmdZWS9nYkJrelFTOGZjNkFCK0NWcGM1bGkxcGw4SVJSYklF?=
 =?utf-8?B?WXFIL0JvcFU4b0N2SzdJQVdURjdUZDUzd1liSktRZ2MwVG5VUlJmWlNQYXVq?=
 =?utf-8?B?THlDajdnV2FSVk94VEF1WFVncDYyeC9Ja2JJcmhCNU16MHBXQjdGMW9nZk1v?=
 =?utf-8?B?Qm14TTF6RTNpMURJMDNEeldkN1ZjVzVwVDBMU2E4OWJySGhZaXUwM01ScG12?=
 =?utf-8?B?bGdabVk4LzRJUVJWcFluSkJYbFdPK3N3M3RwRjRmcHA4Tk80KzVYSHdJM0xz?=
 =?utf-8?B?T3dJZVpQU254ZUdwcFRkRk5HUGFqemFiaUdkTXJ6M0RqSXlNUkpvcTJLQnFD?=
 =?utf-8?B?RzNWejBVQTFxaEFYTlZuTHRMQVZON3hjYnVWUUE0U3N4eHF3ZlMwWTBEVkxn?=
 =?utf-8?B?dHMwOVducDcwSjVQVEdPQ092RGN5WDlrK3E5VG92MGFWNFloS2Fyem1ZdWF2?=
 =?utf-8?B?VTBqM3BScEhHelBiVWVqN3JMYzFBc2x4eUV5QmNLaWpmQmIwM0NFd2ZPN202?=
 =?utf-8?B?d3RyVGhHdlp0SHhsZzIxL2hzbkVrYzRxQXJDbzdNVThrN0Z2SDNpSGtQQmEz?=
 =?utf-8?B?WEhCM05RMVU4ZHZSd0ZVcm5vWHBtQnVvZkFEcm9xSFZrN0dzSFI4WERJVlMr?=
 =?utf-8?B?V1BPaXFNYnV1czJNakQ3dU1hUzk4cStkSG9CUkpoemlTMnBxL1EzQ20weDFL?=
 =?utf-8?B?bFN0M29qR2N1S3k1elduaGRvV00yanFFY2kzY2l3bE03a2V4djZwcngybk84?=
 =?utf-8?B?ME5jUE02OWFiMEV1M0JFWmE4NTJaWXRZM2pHSmVQbjNKUE9XanFYRzlxSFR2?=
 =?utf-8?B?ZWJDcWd1Q0F5N3J0dHFLUUJnVWw2SjFXNFE3UVpWeGNJNDNaRlVTM3lQY2ox?=
 =?utf-8?B?VEMySFFYVjZsSElFQ2daOUVlMDJnZzhqdWM5dVpTZjhjdERZdEJsZWd1TXc2?=
 =?utf-8?B?c2NhQ0YrOW14NHdRWjBBNmp1azZNaXVjeHVJdkJGMHhISWo2ejUrcm1DODBL?=
 =?utf-8?B?WUM4ZEFYQ1ppVlNKWlZ5RkVqanU5THFJVUpWWUY0aVdUWklVQWp3cHJ1UmpP?=
 =?utf-8?B?NXlMazEzdlBRNDBZOVBzUTdnTFBMYlYzVjlUbVJQWVNselcwZ1pIQU55QjZN?=
 =?utf-8?B?QTFMRkt4SEdiUDVVS0ppa3ZWSlhielE3azJKMDRXODUxT2pVL1lNVUlMNW9B?=
 =?utf-8?B?Qi94QXZHcGJWZHFneldMQWh2R1E3QmFsSk41OWYwajZzUldXbGY0NUI3ZVRm?=
 =?utf-8?B?aG9NWjFjSitwWmVkSGFrN3prSXVENWhIdVJZWEZ4ZlhqRUxxS0ZQc0tFSVZI?=
 =?utf-8?B?YVE0a0wyNUN2eEl3UXVmRkVGV1NtdS9NR2xpL05KTFR4bHNuK0N2M0RITG1H?=
 =?utf-8?B?S3pmQzc2MkNzVGdYWFdGUXkzNXRBSkdPa2hqSG9xbXpVd0F6TWxJUVJhWnZa?=
 =?utf-8?Q?o8hilaqb782UFit6YnjyKlg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR03MB7810.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MHMrRG4wdnFoSW9RZXdvM1BMa2RldjdQenJZWmFJamVxUTNnOUdNeGdNWlFu?=
 =?utf-8?B?VFVaQ3ZHZXhiakEwR0xubURISXBNOVpkYmtEMkpXcFkzQkw4Y1haL0U3cG1S?=
 =?utf-8?B?QzhEWWJ4RVluTUY3VmxpZ3drSG1YVFRlNjVzbk13WDdhOHFDK3ROUVNsSDJP?=
 =?utf-8?B?OGhnQ0dhWk9NQm9XVWlpMTlyRTRQaGUrTEZ2bW80U0N5UWZvMFlob3NpMDl4?=
 =?utf-8?B?N3FZbnlHaUV5ajZVOWZTSStieG9WVnhsOGc0Wm44OTNYRUJxS1djTDJoTnVq?=
 =?utf-8?B?bkNCaWMzeFhWajYrb0t3c25hdzNYdW9JbjAvTkNOSjBFSkdtVEl1aVVOaWF2?=
 =?utf-8?B?c0YwN281VElUMU5FRTZwZ3dEcWRVU2g2c0lVQ2dTWUlIYWpsOUUySDNsQ3FY?=
 =?utf-8?B?c3RZamd5eTlTUFdhYkFwcnVId3JqVWllQVlMcGNyVDdGbk9JbHBWcVJhYlc0?=
 =?utf-8?B?M2tBVVIzc1BNV2h4M0ZGMENYU1VjVFB5cWZsMjNxdTRVUjlZSTVEYzczMnlO?=
 =?utf-8?B?TjRIamFsQ0xaWnFscm1FNXN1SEFCWktkOEZHeUU0Z2NLeVZhTGw3NmVha2E4?=
 =?utf-8?B?d1hTdU5JWk4yOXU0UWtpQmJMZGVtMGRzNTR3WFMyUnZrNVgvclF5ODhOOG90?=
 =?utf-8?B?WnhqYnc4T05QVVNwWDZqVGxKTXNSMDU3ZWZaNTgzU3E2T01IMXI0emkxb01P?=
 =?utf-8?B?Nk9hVkh6eFRRVGFjNHBpTlZ5N0dXclFJdGh3Q0R6WUV6bkRGTnM5NEFvN21j?=
 =?utf-8?B?cUNqazVWbnRjSW5VQWxYdjREUW5ZaWlSV0V1ZkJzeTFjMC9WUWFmM2J2RjBs?=
 =?utf-8?B?WVprU2hnVzRWVnFVanZhYWlseUpPZVE2eWEzdmM1Q01aaUdNRXpnV25wV2kr?=
 =?utf-8?B?enl3VXdoakRTZXBuQ3pCYlJFVU0vTE5UMTZIazNsSHM5eFNoYkRUTUhtMDdw?=
 =?utf-8?B?Qm1oTkJDMlM1aldYTStYbkFvUmZrUFBEN0VqbS9WQVVVR2tGN2ZaUU5UL295?=
 =?utf-8?B?alBDcnVaR3g0YkFEcHJNcitmM1RwaWJESklKU2xXeC9UY0k2ay92MEFZZUtJ?=
 =?utf-8?B?Y3F5MEt3NXpkTFVZcm1XWDZRd2ZDVW1xN2ltZitJVFE4bHV4UXQycGxSUjlC?=
 =?utf-8?B?M05xbWtjQkhNazFnMTBzY1NNVU1GU3RCM2lIMXAvdG04b2ErVXBITlg0eElD?=
 =?utf-8?B?WjJDS2JZRFJZUjdESmdZbFRvbnNkdHV6dzNURnhmMHJvNWFVTGtwY0crOTEx?=
 =?utf-8?B?U3BsWHJodFdZY281V1FoVXFRYXBLbm9uVll0QWlpVXprclp5NkZMOVBaeWhC?=
 =?utf-8?B?MG55eVllYnYvR0RGanBsYWllZ1d3cjE5UkdNeVFMMDF2d2Z4U1E5UzU4RDRJ?=
 =?utf-8?B?clF2bU9IM1R6c084Y1NCS0RpVXlReEVWdEZDajNSNGd6U09XTGl2dXBYYUV1?=
 =?utf-8?B?Z0N6RjZuVk9ucXNZK0FENDlaS3lIUDZhSnh5TFhTUUVpSDkxWWxTNU5seFgz?=
 =?utf-8?B?WXEzSmxCcEtQTy84RFRvMVV0ZTVuWUlWaGxwOVdVU2V0OTVLVHJJTFQ4YWUz?=
 =?utf-8?B?SUp2T0tIbE9rTmdqbUNXODNGNWVHaUVtQ081N3BjUExKVzdINUh0NXhybDNX?=
 =?utf-8?B?UCtoS0ZpVHBYTWkvR0VhOFVwbWMzejZnZ092c3ZKWWdVQlVvWVUrQXZ2N3Q0?=
 =?utf-8?B?QWtvVFQxbFVwQ29SL3lVNkxBY3I1ZXBEYTEzN0pyVjYvNDZnK2lKTUg5VitP?=
 =?utf-8?B?R2dqV1huZUlER3h2OVg5b01vOVpYcHVuRGhXT2NxRG92UHUvdjBDaHpPbGZ3?=
 =?utf-8?B?K3F5YlI4ak5kUk5qa3Z6NFBCanN5WUk2Rkd5WVJEbUUrRmhxNXd2aVFibVVK?=
 =?utf-8?B?QTdhUFNHVHV6RThjc2tYSndScTljclRJb1U1VFNpUUp5OEt3ZktPQjVhZ2JG?=
 =?utf-8?B?eUhjWHArV2Y3WmFkR1FnMlV3WHhleTYxU2JlTzNqYlo0K25NTmxlQUVEZ3JJ?=
 =?utf-8?B?YTJZM0xzbTV5UCtjZEFqVzZacmo4eTFNTm03N0lKQjk0M1ZIMjZwa3MwanJO?=
 =?utf-8?B?TndtZk5MSDN6bkhKeUNBek9vakZ6ek9pUFN4ak5zZTN3UjhDbnV0MlQ0WVg4?=
 =?utf-8?B?WThlQUdKVDVvRWs1eHlmRmUrUGluc0loc0tldW5rdEZORm1FUjhybGova1Ax?=
 =?utf-8?B?d21PM2tHWHFoTnUxeGZEblFKSjNOVFVNK0dSenZHMnM1azZaM2RkRmM4QmRC?=
 =?utf-8?B?WURCMmlHWnpYVmsvdDBPb3NWWnZYTXZIMkp1U3VIejEvNkNEZmZVbld2UzZ6?=
 =?utf-8?B?QTNVNEFRSER4T0Z5dGJqbDV4aXRDYWpkV1l0ZE5XRFFZemRFWXhCdDhXM0FV?=
 =?utf-8?Q?OJzLpaSe+rh1CidU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3B7F703DD0057F4480FB3E198822B2A6@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7810.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0db8f434-8da0-4055-e746-08de6a2134fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2026 10:26:38.8348 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xq9HVNkwTjALEGpNsh9YmWP52hVam9lNrcu89zZaLr6f2BK/VtfWECBTIY/YPk7ET/ZHXzk9Ng/0ncnvWJTieSsC9UItPAs4aFCpGVv25xQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7406
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

T24gTW9uLCAyMDI2LTAyLTA5IGF0IDE3OjM0IC0wNjAwLCBEYXZpZCBMZWNobmVyIHdyb3RlOg0K
PiBJbmNyZWFzZSB0aGUgbWF4aW11bSBudW1iZXIgb2YgYmFzZSBhZGRyZXNzZXMgdGhhdCBjYW4g
YmUgaGFuZGxlZCBieQ0KPiB0aGUNCj4gbWVkaWF0ZWsgcGluY3RybCBkcml2ZXIgZnJvbSAxMCB0
byAxNS4gVGhpcyBpcyBuZWVkZWQgZm9yIHRoZSBNVDgxODkNCj4gd2hpY2ggaGFzIDE1IGJhc2Ug
YWRkcmVzc2VzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogRGF2aWQgTGVjaG5lciA8ZGxlY2huZXJA
YmF5bGlicmUuY29tPg0KPiAtLS0NCj4gwqBkcml2ZXJzL3BpbmN0cmwvbWVkaWF0ZWsvcGluY3Ry
bC1tdGstY29tbW9uLmggfCAyICstDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
LCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9waW5jdHJsL21lZGlh
dGVrL3BpbmN0cmwtbXRrLWNvbW1vbi5oDQo+IGIvZHJpdmVycy9waW5jdHJsL21lZGlhdGVrL3Bp
bmN0cmwtbXRrLWNvbW1vbi5oDQo+IGluZGV4IDE1YWIzYzFiZjA3Li41OGYxMzYxMzYzMyAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy9waW5jdHJsL21lZGlhdGVrL3BpbmN0cmwtbXRrLWNvbW1vbi5o
DQo+ICsrKyBiL2RyaXZlcnMvcGluY3RybC9tZWRpYXRlay9waW5jdHJsLW10ay1jb21tb24uaA0K
PiBAQCAtOSw3ICs5LDcgQEANCj4gwqAjZGVmaW5lIE1US19QSU5DVFJMX1YwIDB4MA0KPiDCoCNk
ZWZpbmUgTVRLX1BJTkNUUkxfVjEgMHgxDQo+IMKgI2RlZmluZSBCQVNFX0NBTENfTk9ORSAwDQo+
IC0jZGVmaW5lIE1BWF9CQVNFX0NBTEMgMTANCj4gKyNkZWZpbmUgTUFYX0JBU0VfQ0FMQyAxNQ0K
PiDCoA0KPiDCoCNkZWZpbmUgTVRLX1JBTkdFKF9hKQkJeyAucmFuZ2UgPSAoX2EpLCAubnJhbmdl
cyA9DQo+IEFSUkFZX1NJWkUoX2EpLCB9DQo+IMKgDQo+IA0KDQpSZXZpZXdlZC1ieTogTWFjcGF1
bCBMaW4gPG1hY3BhdWwubGluQG1lZGlhdGVrLmNvbT4NCg0KSG93ZXZlciwgc2hvdWxkbid0IHRo
aXMgcGF0Y2ggYmUgcmUtb3JkZXJlZCBiZWZvcmUgIA0KW1BBVENIIDEvM10gb2YgdGhpcyBwYXRj
aCBzZXQgZm9yIGF2b2lkaW5nIGJ1aWxkIGVycm9yPyANCihIb3dldmVyLCBpdCBzZWVtcyBub3Qg
bXVjaCBpc3N1ZXMgYmV0d2VlbiB0aGVzZSAyIHBhdGNoZXMpLg0KDQpUaGFua3MhDQpNYWNwYXVs
IExpbg0K
