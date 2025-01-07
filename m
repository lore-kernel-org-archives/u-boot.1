Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13365E77197
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 08:00:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 992E2805E1;
	Tue,  7 Jan 2025 09:00:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="JnUIdYD+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B61AE801C3; Tue,  7 Jan 2025 09:00:08 +0100 (CET)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on2061c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::61c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FC13805F7
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 09:00:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mh9hy2AAS5nJ3BQ3vTKtS0qMgUPTwSDOswzI3gMLJSH5JyC+GtLCUDL0FEIpuApahH0NoDHKJX2FBUrX9ERJNE8RO0a92S3UC9fhqo+Jf1tFukFANY6VCWpW2hxVQ7HpNitzF257FTGnElOLVrcvriDx+JHnYUe9KL6nYhzCzF7kX1TmovKsSjlMIbttFr8J101y9Lt7eNyKoa+IIoimZFS+krq65FiLXLmIz7qVOmC2qffmCO9QtRotw+rarrNjM62hkHHKsXQlOOQrHcN1e7E9HYYeGlkAkdzKktXvZRhm5IP45OQnEdJAtBibfonelqcDIRmKo9UHoRNvPJrDTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=18oq7+M8SzQEgzdF2s+v3xlXsalhzCem/vgy3q0SMzQ=;
 b=t3PQJ50Pwq477d/hFo4CgpGcAArFFuNbdC1FKDyWoE3bKpUkEOmDoY7pLof5W3zXtL/zC9bW2A4hpOQgUgZrNVSPyEM+Xnmn73tsKd94eNT6ZRWAu/hRtvWFb0EKA0pUnywh+657eTkhBKb6xXWSxeD19ZmyERoyNQmBLxOTVA9JbID+4O3HGUdd1GVEHr6u7xhXczlhX6awaWp1Wuc5fpqtF0WCkFjBYYUg4pJSTo0Vo/p6RqiILgy8q5Ju9XsDsYLNR91HubONfCpKPnN5AvAQkPnH6gFl6xj0TDHcOSLyzryi+HLZeZGg/Ykfh48H2P6+goguHeVz65BYsZeMEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=18oq7+M8SzQEgzdF2s+v3xlXsalhzCem/vgy3q0SMzQ=;
 b=JnUIdYD+coqwioy1CXq0BbwEwFHp1+ukepQ+SFx1W7nMx6zx4Adbux09euRKAIqggJK+ts6AjMX5j1lu4UJp7HucJWI0vMUZP+gg1U3hS8MnR8UCYogVscMnFA0QvvGJ1ZeCt7mRtTDzX+0kvjdSChqZjMyJDKjP9n/MSCxJPpKyfHQDMCTp+WYgsT/FytFjRYNrNz8LVxrMVYe+8f8eHKYkSxCTrN00vOaLbpHD6UpeogoAiPGxnnd0GDy1JyOXMCr+MhV7ih6RFlns1ajwUzSXRa9H9KmZfXBqJZZx0HtxUpfAB9NEvR/kGpNMKuCM1SzGMxuC2pJEqPn6uG2rmg==
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DB9PR04MB8202.eurprd04.prod.outlook.com (2603:10a6:10:24f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Tue, 7 Jan
 2025 08:00:02 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8314.015; Tue, 7 Jan 2025
 08:00:01 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: Marek Vasut <marex@denx.de>, "Alice Guo (OSS)" <alice.guo@oss.nxp.com>,
 Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, Fabio Estevam
 <festevam@gmail.com>, dl-uboot-imx <uboot-imx@nxp.com>, Lukasz Majewski
 <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Simon Glass
 <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo
 <alice.guo@nxp.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "tharvey@gateworks.com"
 <tharvey@gateworks.com>, Ye Li <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>
Subject: =?utf-8?B?5Zue5aSNOiBbRVhUXSBSZTogW1BBVENIIHYzIDA3LzE3XSBjbGs6IHNjbWk6?=
 =?utf-8?B?IGNoZWNrIHRoZSBjbG9jayBzdGF0ZS9wYXJlbnQvcmF0ZSBjb250cm9sIHBl?=
 =?utf-8?Q?rmissions?=
Thread-Topic: [EXT] Re: [PATCH v3 07/17] clk: scmi: check the clock
 state/parent/rate control permissions
Thread-Index: AQHbXaswJuEajopxvEqU+wWKdelPi7MIsGKAgAJEHOA=
Date: Tue, 7 Jan 2025 08:00:01 +0000
Message-ID: <PAXPR04MB96440B011EEC2F444897AF44E2112@PAXPR04MB9644.eurprd04.prod.outlook.com>
References: <20250103-imx95-v1-0-6744df5dc020@oss.nxp.com>
 <20250103-imx95-v1-7-6744df5dc020@oss.nxp.com>
 <0898a19f-e6f1-4fa0-ae0b-6f696ffbc837@denx.de>
In-Reply-To: <0898a19f-e6f1-4fa0-ae0b-6f696ffbc837@denx.de>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9644:EE_|DB9PR04MB8202:EE_
x-ms-office365-filtering-correlation-id: 9dc9a624-325f-45ef-2b77-08dd2ef149e4
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|7416014|366016|921020|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?Mys3dGVCOUlpczdEaTR2VmhZVzJhM1dDSnNDMzFweTNob1M0OEQ4Z0dDQVFk?=
 =?utf-8?B?TlppdlJlcWRiMFVBblVjaWk1RnF1aXVtNE5HRnI4UlZMak5pZ0liZUg0OXVH?=
 =?utf-8?B?TXVpY0dXcDJCYjdkS2R2MlU2d0VJZ0d5L05kTjFFR1g4VXRMQWRXREFsWWx6?=
 =?utf-8?B?S3hidXNONDRBVnVhWVkwYkJkd0d3V2hmZGhjN3YrUnpBWS9LUlNZR1lRY205?=
 =?utf-8?B?Qncrb2YrSElyWDlodTIycENpU0o1eFZ4UTJtK2RldUVYUWduVlJ2QWh1OXZh?=
 =?utf-8?B?ZWtyMDM0aVBSUTYvL3g0aHM3LzR6ekt0NGdRcWtOeXZ0ajVYUlJ5SFNiaHFo?=
 =?utf-8?B?aVhXVUhrY1A4Y1k0Y1VoanV0SDJiOWxxRFRycUZreVJSNjVsT0tpQUdZMGFx?=
 =?utf-8?B?UVlJMnJiY0pGdEdGNjFXVU15bFFrdmVFdjBtWHlvYXUrUnowbi9zaG5LbEh5?=
 =?utf-8?B?WnRnb3NEWExObFpyTGE1TDlyeDdvVzYwbmNhcmtzTEZTc2t2OEVDdE8wdXZn?=
 =?utf-8?B?VnEzMysxNHdyOWRHNmIxZEh6NzlyVjRTNzJPaklzSjBVN2lFTHB6cGowcldj?=
 =?utf-8?B?Z1B4L2NiTHQ1MkpzVnMxL0NLcmxDaGdCNWUrSGd0cmdXOWNNQ3VxdXBOTnJz?=
 =?utf-8?B?dUp0YjRJL0VHM0Zsd2hXeGp6bHhVZUFaQitaamNnNi9KZC9EelBwZitUUDcw?=
 =?utf-8?B?bDZMaFVBM3gveDlyNHhOeU5kOWU2V1A5MC9KdmgwQjErazFQTkYyWGU4Tzhl?=
 =?utf-8?B?SWtKSmxRZngydXkySnJLVVlXY0RBT09RNDkvSkd2Sm5XQkpBL1ZmNTdibXFU?=
 =?utf-8?B?QnA1T0J3ay9sNkJ2NHM4ejcxZ29BME9EWmsvbSt6NlN0MlNrbG1UN0ZKTWFy?=
 =?utf-8?B?amJ0WTYxYUltWU1DWGY3UXM4QVZzMVJxV1o1eEY3TXZwYWFyemQvOWo3VHNh?=
 =?utf-8?B?ZUtyTUpSaXgxMm1LVVc4MEJaT2p2VDV3aUNmNCtaR1hzQ3JmRUNCU0Z3WXdr?=
 =?utf-8?B?SC9Ma0VOeHdmaGM1T2tCRUlZOVh5T2ZONXYxR2Nyc3ZNZXVOejExTm5OLzZP?=
 =?utf-8?B?VHhxR0FNSUpFRlRwcXJZRnJiVmNtWkt4Y1lBTTJCYUJhLzhRUGE3TVZvaER4?=
 =?utf-8?B?M0xSclc1ZUZObG5abEs0R1VoZ1VPcTN2TG1zMk1aMDR6L2E1eUErNlVDbFh5?=
 =?utf-8?B?bWZoVE9YZ2N2VTBWOTBObTRVNENZNkFncS9veHZyUVZ2Q3RTdVNtV2hIaXdq?=
 =?utf-8?B?TURkUUNiUWNzc1I0bndFcVNLbnZ3WEUwa2dIMlNjMzVPYkhKWGd2S3FVUnhi?=
 =?utf-8?B?Q1BpWEduaGtEZWRtdG1nRTJSOHo1dDRxS1lqYWV1YW04bXRUK2VTYmZkcHN6?=
 =?utf-8?B?VllhdEdVMndEQlRHNmV0eGhmZ2NEK2ZvQkd2c21KOFhsYWgwb2FJNUxTbHVl?=
 =?utf-8?B?ZmZ3emgvUHhMWHZLa0p3V2c4azg1SEZJOEhSQkZHMU52VjR5REJIbVZJREM0?=
 =?utf-8?B?dks0RDF2aEt2emlEdTJrbkMvbWhEK2g0YjVaN1hrVkNwbU5oODAxakV3Rnhw?=
 =?utf-8?B?SG40Tk1oaXcxR2hWaURrQWtmSGNLTHFJeXlLMGZkdmJibUQvR0V5bWZxRjlG?=
 =?utf-8?B?WklGT2dxa3VaM3lIVnJTeFZmem9rQTFMalkzV1EzbHhCelM5dXJ0dDVJak40?=
 =?utf-8?B?ZDAwN2J6NGMyLzRIcllGVDBwSnpvN1haR1lBa09pK3MvZzErTjNCNXUxV0Jj?=
 =?utf-8?B?VmZJUnV2aHlrTTlCQzVtamREcS9KN3YzY05zcWl4a00zU3lKVlg0UHFVYWVW?=
 =?utf-8?B?RDJHYWlxdnBQbU5rUHVKSFRMOFQzUUlPZmlPcGxTZkhUcksyUC9vYUx4VFA5?=
 =?utf-8?B?WGp3V3J2dDRLalByUmpkWThUMTlpc0djd3pkbmxZaVhGOWwxZjkybWpjdUtH?=
 =?utf-8?B?cWlaZkg4d1lFNHhVcU9SMjdYdjA4WWtMSFJEaHVINWJHS0ZzbzJzaEwxSWFK?=
 =?utf-8?B?SXBRTm5EMmpBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(366016)(921020)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UVp6RzVOV0JLY1YxTGljb2pZcG1zZzlVWFMyblZmbGV2dUxGbGt2MDU2T0Vv?=
 =?utf-8?B?bTdBajgxN3oxQ2x0SXlmL2I3bm83eFp5WDRYT1dLOFQ0dGdTSjMyMHdwWmlD?=
 =?utf-8?B?MU5CM296NXYvTmRKS0R1OHdxdFF0OHM3VUJyUmh3WTFzZHhuUVo2REJrSEcz?=
 =?utf-8?B?RTBHSjRzNk1iZlZjSXZwWXVhd2ZvSllrOVVqZUxST3FBUHhsbDJnOVpMNjBw?=
 =?utf-8?B?elhjeHVIUXNkMEorRjBHdHRlM0FWd2xPek9oM3dzV0NtOGszVW9ndDRWL3Zp?=
 =?utf-8?B?N0dsMnFvOFdGYStkZ2puMHNhS3JlSUo3emMwSmg2OWJ2Um5McU1hUWRrS1dJ?=
 =?utf-8?B?dXo4c0ovTEl4WG9qd0ZGRHdHM1Bvb2o4N2RHZkIwS0pGa2VjQmZKM0U4Y3pN?=
 =?utf-8?B?UjZleEh4VnF3b2VlUVl6cjdBejN3eDM3bThKNlR6V2U2TzYzbVVWWVFWSXVQ?=
 =?utf-8?B?bWttempsMHQ4T0ZndW1STTA1bE5XbUkrSFpCQXN3OWpUMTRhcklZMlY0ekhY?=
 =?utf-8?B?dDVCa3NlaWEySGl0S2tMKytDUEdBNXl0ZUdwbWx4cUFIV3lJMGl5VTVZb2hF?=
 =?utf-8?B?OC9LWkRPVU1Db0N4QXMwSGhZS3pqUUhBOXFpRWpBSVRXSmFwUHFmMzZvK1lr?=
 =?utf-8?B?dGpmZDhNbTJWdk9HUjk1eWtFaHB0bXJ0NFhwVUd6MGRBMEc4aVE5WXFzanR1?=
 =?utf-8?B?clVBLytmaXJ1OUY3aXkxclhlcDNUWlpheEtidkxUN1kxYmZ1VTRmTXFIdEJ5?=
 =?utf-8?B?VllleGovRnNYN05HbU5vRjNQNWJQUzVIQytDUGNwYVZBSmgyOHdnNVZ1QnE0?=
 =?utf-8?B?LytZUjZqRTZHSWR6RUhUcCt0bHhJSWcwWjVFQ2VuYVRCMmM0SVhHVno1b1hy?=
 =?utf-8?B?K1J3NUpFbUFJbS9qUG5FM0orUDZvT2FQN3ZPdlcvMmZHbHRuOEZEMDhadzdR?=
 =?utf-8?B?T0R1dHZJNFc5V05COTJLNHFyTGYwWnVKTVA1ODFLZDJkcEtZMVJqNElPUEgr?=
 =?utf-8?B?bHo2SUkrQ0hUNHorWTNYVzZDdnQ5N1RZakMwa1g2eVZmSmdMZlM1N1ArTjVt?=
 =?utf-8?B?T0xUZGFwR0ZRTHY0MFFTZE9FbWt4dENWRVJ0WFJzVHUxNG9nRHJOZ1pQV3VC?=
 =?utf-8?B?RDRQdlBmK0tqYmtXOFlBZE5taHFLQkRhb3NsVlBUV09XT2liTVJIK3B0MVJ4?=
 =?utf-8?B?bmdWRXNMeCtBTHJUWTMwTjFsWGxHS00ycEhKWmlnSEoyUEpoWUdYMGNucHpt?=
 =?utf-8?B?N0RPKzQ0RDd5UlpuTDAyUlNaRjJPNFFuWEVRQVNoanFDdW8rS00wRFdubXl6?=
 =?utf-8?B?SlBSMitPZVIyS3BxMUpTN3pOMmlpTlhrYkgwYU9PYmg3RDdyY1E0NDFxZ0tm?=
 =?utf-8?B?bFZXbGlZOG1jS0M1cXNOMVZyS3Rva2lnb3RGOFMxbW8yWjAzcnZNK1ZoK1Iv?=
 =?utf-8?B?Zk1vNzhGK1ZmbmpYQ09VSTI0MnRiRzVJZjdTd3BxZU9abUVyS09WV1hXSGZW?=
 =?utf-8?B?VXVzVmlSMjA3WVdJVVV6R0N2Q3dwSFZhdXBJaVFEbGRkRjhwdHB5d2dHMzVB?=
 =?utf-8?B?a01KaDZxOTg0M0pDOEdSdTVEZ1NLZWl0RUVVODRvTVpENnVHOGorQXBVckJX?=
 =?utf-8?B?Q3RkWVBvVzB5OUNaWFU0dDVkMEE4ekRDUDhITUNtenB1Vm1zTkxZSzRrbGdH?=
 =?utf-8?B?YnhzZUdiKzZzTWFFWWNQYVlBRDAvNnQ5c1dpVExzVlgzTlJTOXhabmI5d3A0?=
 =?utf-8?B?V2FMRlZ6VnBBQ00zSmNGSGROb0h5M0twVy85UVc4REFRRXdYU25SUW9iMFBT?=
 =?utf-8?B?bWtEVEhwTHVZbSsydmNrVlgrWG9rcWF5aTFxdE16U0tjUDViNGlLVWNmdVZs?=
 =?utf-8?B?cGZyRHdJUS9PZ2JIRUlQQk56OFBGNUhvK3hEbUZwQ1NmeFVLZWFVaFI4MENE?=
 =?utf-8?B?Ti9DUTJuMUZyOGhBMlNLakxuYW9sNFhzN25OSlJndG95eWh5dzkraUwyeU9F?=
 =?utf-8?B?S0xWeFAzSmNFSE8xSzZhNDJFak9EcVMrd0QxNEZjU2NPK0gwUW1uTVpUZXFq?=
 =?utf-8?B?T0VQQWhsTHM0cjZnSDJrTHViYVpyMHp2YXFBV0FLQTd3MkhiVFI5dXRJejVD?=
 =?utf-8?Q?6Jsowb3pSXE1urECniLbybSG6?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dc9a624-325f-45ef-2b77-08dd2ef149e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2025 08:00:01.8095 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eExtpd7A8gCuNfiQDxFV0qIoe/6sFqjmGJzgsLZSOJ2M0Abe3C+rWVvpoyhdoG9Spf55ZN3ppN+7X6E9zn2uNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8202
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

PiA+IFNDTUkgY2xvY2sgbWFuYWdlbWVudCBwcm90b2NvbCBkcml2ZXIgaW4gTGludXggY2hlY2tz
IGNsb2NrIHN0YXRlLA0KPiA+IHBhcmVudCBhbmQgcmF0ZSBjb250cm9sIHBlcm1pc3Npb25zLiBU
byBiZSBjb25zaXN0ZW50IHdpdGggdGhlIGtlcm5lbA0KPiA+IGRyaXZlciwgYWRkIHRoaXMgY2hl
Y2sgaGVyZS4NCj4gPg0KPiA+IFdoZW4gdXNpbmcgY29tbW9uIGNsb2NrIGZyYW1ld29yayAoQ0NG
KSwgdXNlIHRoZSBjbG9jayBzaWduYWwgSUQgdG8NCj4gPiBnZXQgdGhlIGNsb2NrIHJlZ2lzdGVy
ZWQgYnkgY2xrX3JlZ2lzdGVyKCkgaW4gc2NtaV9jbGtfcHJvYmUoKSwgYW5kDQo+ID4gdGhlbiBv
YmF0aW4gdGhlIHN0cnVjdCBjbGtfc2NtaSB2YXJpYWJsZSB3aXRoIGNvbnRhaW5lcl9vZigpLg0K
PiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQWxpY2UgR3VvIDxhbGljZS5ndW9AbnhwLmNvbT4NCj4g
PiBTaWduZWQtb2ZmLWJ5OiBZZSBMaSA8eWUubGlAbnhwLmNvbT4NCj4gPiBSZXZpZXdlZC1ieTog
UGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQo+ID4gLS0tDQo+ID4gICBhcmNoL3NhbmRib3gv
aW5jbHVkZS9hc20vc2NtaV90ZXN0LmggICAgICAgfCAgIDIgKw0KPiA+ICAgZHJpdmVycy9jbGsv
Y2xrX3NjbWkuYyAgICAgICAgICAgICAgICAgICAgIHwgMTczDQo+ICsrKysrKysrKysrKysrKysr
KysrKysrKysrKy0tDQo+ID4gICBkcml2ZXJzL2Zpcm13YXJlL3NjbWkvc2FuZGJveC1zY21pX2Fn
ZW50LmMgfCAgNTYgKysrKysrKysrLQ0KPiA+ICAgaW5jbHVkZS9zY21pX3Byb3RvY29scy5oICAg
ICAgICAgICAgICAgICAgIHwgIDI2ICsrKystDQo+IFBsZWFzZSBzcGxpdCBjb21tb24vaW14L3Nh
bmRib3ggY2hhbmdlcyBpbnRvIHNlcGFyYXRlIHBhdGNoZXMgLg0KDQpTcGxpdGluZyBjb21tb24v
aW14L3NhbmRib3ggY2hhbmdlcyBpbnRvIHNlcGFyYXRlIHBhdGNoZXMgd2lsbCBjYXVzZSBiaXNl
Y3QgaXNzdWUuDQo=
