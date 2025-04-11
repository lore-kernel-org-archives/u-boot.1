Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DBACC369A9
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 12:29:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D41C83FDA;
	Fri, 11 Apr 2025 14:29:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="NTrl/0Ta";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68D7583FE5; Fri, 11 Apr 2025 14:29:07 +0200 (CEST)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on2060c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::60c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C9B883FDA
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 14:29:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=horia.geanta@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xkyV6ironYrbH/nTJAEzckAGY8s17nLv7PyUZo8IJcuh2IBZYysIDQDiwG7m1/x50t4Tg8cCB1ldZIsz4JFFEv6dW6i1k24cLuMWvA0ruJo0+xbIPjqCtcEAQgwIKzmnZFHDqHlGRdN5oxnrH6HIbwilA0sHScyBKkzfo4vyM7CbaHbl8Lfi+CUtoeNnCOFwIxWBki+Qq6uCjsJVEsyFjtQGxTJF0oj9Uecs4TdESx56j9ipvkJxlxh7+jY4tEh6i0oE1cevbmpchkIHGTXPLfrEHDibjFy5gkqxMICL/8oxbm7I6KOUVVhntSVErYG1X8pRmw1DPKvZYpiH/CVv0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qx5EDm6539R/UsEJNRkV3Z5w6XvmOWnPb4fg+ot6KUI=;
 b=lFgidQSO5e0mWYux//cfg8P1ZGGY+6ANLdgP00cJIpLG8oytovLLadp7TlXSRwa0ln+gxIikhn/A8/QpWKD5IZIguhm0Fc8ZwsltPYdRKL+t+fVF6kcz/UzwpqaEMxSoiy/VLbL9vq7xQgOGRfbqmOUUhzwbgEmlBmO9AQQk8o4OoBtMy0poPPJvKpF0IwZmQ6ZUcbyxp68CGgz2Bc8D/pJlU1Cl8rTMTM2pU6HDPe+/H1Le1iSU9/oVK/Y/r7G+11X8qgGgy+xGj8cxFw+Lx2l1W6V7cpFntGxnq6u2fmZ4GEzIG7W3pPxzVuJyc5odpRmWHqWEAziDEw+kn3zO1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qx5EDm6539R/UsEJNRkV3Z5w6XvmOWnPb4fg+ot6KUI=;
 b=NTrl/0TaGqwDnxVxrM9JCBmyJ5ptY7qUacj2xbXyl75cBoYWheYwMP5enVP3RipbzlE87pSAlf9Gu+r/cU/3DHLGK3IVhv1XhOePCc3ltH2gscx2m7l/y6lkEzc3xBsaxxy/FAs8OtyxWbCyyKiw0F4aRQ2ZL1gYxgMUq6B4kvg2k/BDyvI8Jx70QgfPUHKaCEre0jxnHcB5T7Gnjr5X1co9ybEb5WyrrbkXrvwdnhUhdgomXIVQ+l9HvbWuuqxLTp6fCACnMFyf1MmMsdVkqCGWg/lYmHJGOt+IbCVw6FnY5kPeCHfeFP2Sr/H+hfT80q51kJBp6+sRczIPAlCqgQ==
Received: from PA4PR04MB9709.eurprd04.prod.outlook.com (2603:10a6:102:26b::10)
 by AS8PR04MB7864.eurprd04.prod.outlook.com (2603:10a6:20b:2a4::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Fri, 11 Apr
 2025 12:29:02 +0000
Received: from PA4PR04MB9709.eurprd04.prod.outlook.com
 ([fe80::1009:ebb:d7ae:4628]) by PA4PR04MB9709.eurprd04.prod.outlook.com
 ([fe80::1009:ebb:d7ae:4628%4]) with mapi id 15.20.8606.033; Fri, 11 Apr 2025
 12:29:02 +0000
From: Horia Geanta <horia.geanta@nxp.com>
To: Gaurav Jain <gaurav.jain@nxp.com>, =?utf-8?B?UGF3ZcWCIEtvY2hhbm93c2tp?=
 <pkochanowski@sii.pl>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Priyanka Jain <priyanka.jain@nxp.com>, Gabriel Nesteruk
 <gnesteruk@sii.pl>, Pankaj Gupta <pankaj.gupta@nxp.com>, Varun Sethi
 <V.Sethi@nxp.com>
Subject: Re: [EXT] [PATCH] crypto: fsl - Fix RNG generation for lengths
 greater than 16 bytes
Thread-Topic: [EXT] [PATCH] crypto: fsl - Fix RNG generation for lengths
 greater than 16 bytes
Thread-Index: AQHbp7vfoLteovRn9keVz5MD6qtO3LOZjPCAgAAOeACAAUOuAIAAr1iAgALctoA=
Date: Fri, 11 Apr 2025 12:29:02 +0000
Message-ID: <de8bf254-577d-4ef4-8e82-f29a4be2b896@nxp.com>
References: <20250407124714.177059-1-pkochanowski@sii.pl>
 <DB9PR04MB8409F4CF8E38ED3ADAAB1E80E7B52@DB9PR04MB8409.eurprd04.prod.outlook.com>
 <AM8P191MB1394DE8E57990BF74131AA4CA2B52@AM8P191MB1394.EURP191.PROD.OUTLOOK.COM>
 <DB9PR04MB8409F684D29E823DB780545FE7B42@DB9PR04MB8409.eurprd04.prod.outlook.com>
 <2509286b-a408-4ed4-9923-465eb87376fc@nxp.com>
In-Reply-To: <2509286b-a408-4ed4-9923-465eb87376fc@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9709:EE_|AS8PR04MB7864:EE_
x-ms-office365-filtering-correlation-id: 230bc49e-b4b4-4cb6-06dd-08dd78f4715a
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UFpUSEZGdkpIR1N5MDVENWovRzRtYlZNcEdVcUx5SStKempUaCs2dVdPOTd4?=
 =?utf-8?B?OTZHN2R4M1JJeVFZSXlFN3RYY2VMVVc5WXlkaVh4VVVJVDlSMHVKTzJKSHNF?=
 =?utf-8?B?VWhtb0xCenNGUHVWaE9LQXBGdEZucCtLZ0ZzZlFXcHR2aGVrdmJ0N0JOaVp3?=
 =?utf-8?B?N0FMdEJqamhHd1ZkS2dhS0w1MnhxZUJSRGxOQmoyVUN1OFBpa2tKVEt2eDc2?=
 =?utf-8?B?cWRkdWJxM1FMQzdRMW1YT2ZxNTNkL1UwSGlXSkQrandUYlNmZlc5YThMb2cw?=
 =?utf-8?B?UDNmTXZvZzAwNC9tYU1rV3gzUEE1U1VXZWNLUkxSV1NsSVpPdUoyWEpXSzBa?=
 =?utf-8?B?Q1VFcFZ3d2hlWGlqby9UeUV3d3ptZDc4NjJucVZGT2tVSjhSN1A0VFl2V0h3?=
 =?utf-8?B?Sk9ERGFjckFLRVQwOVRrUzl6amtRTlpvUkpkWnJPeDNERlI3c09NUEhHdzYz?=
 =?utf-8?B?dXVqekFVWm1XNkRiektSb01Ia21JVWU1TVVwMnZoSUhPcVJxTG9xVGhhbDQz?=
 =?utf-8?B?TzZxSllJZ1V6bHp4ME9Ca05rMTd6d2R0MGNwL083Z0dCeXFaZTFJcVdFUEE5?=
 =?utf-8?B?WDFqcTd5aFNWeGROZXJ0eG9PVTd2MHl4dGRYWnpVbEVFdFFMb244R1k2emxX?=
 =?utf-8?B?dTY5RCtmZW1uNkkrMko1OVdDWThKUmpjZDV2U3FDYjJiVDBQVjlNalV2Q2p5?=
 =?utf-8?B?SVhXY2oyeFRPYkR6UzlvYnlTMVBZR1RPSkd2TVZ2c29TUnFwdnZwa3l6Q0Nr?=
 =?utf-8?B?aWtlVjlVUGg0QXFRZ0JTNi9manRIRW5Xd2pqelNmM3QyeWtPRlhYOVB6eVNs?=
 =?utf-8?B?Q1pLTFc4YmhJK1dWNWp6dXNGdTZ5UFE5QUZuU1V2SDZjRnh5MmVJL0pzVC9p?=
 =?utf-8?B?SENKMjREWTdwUkFRUHdSODlGbnhOb1F2bU85QTF0bW9ieDE1T1hGbHJlbzdZ?=
 =?utf-8?B?SXhKR1NSRElXaSttcE1WZTJFZGNLTWhtNUdsd2l0UDM2QzdMYlZneXI4ZWNO?=
 =?utf-8?B?SUhBdEZZc3lBUU5JQnZyZi8vdWhJR1NiaWhDc0NYeC91WU9VZ212eFZYSTNS?=
 =?utf-8?B?SXR0cGtUUUhDc1diYWFWeVR5M0h3bnZrdVU1UW42RFJNQ1dTbitNS1JlWjVW?=
 =?utf-8?B?K3M0MWs3cVpkSzNRL29wRVhXYTB1Z0NyWHVBdE1XczZVYm9jaE0yWG14aTZS?=
 =?utf-8?B?VktYcklHUng3NTBjSUZPNzJsU1prL3JFYmR2T3J1S2VYZWdBVGFBQmFhRkFS?=
 =?utf-8?B?RVFRWTYvVVJZRjJGTjFlQnRaa0RNeHAyekRNVFllblBMbHdzT0tmM0pHcjYr?=
 =?utf-8?B?TWRWNmJLcjgzd3AyLzNIbGdKZDBubk93eGoycCtpWGt4VnkwYks5UlBTU2JD?=
 =?utf-8?B?bWNKU0JVQ3VqUURHQ3dhMUhPZXZYaDVraklxcmRkcUtmbjVic3M0blJjd1Zr?=
 =?utf-8?B?SzBNVGR5cGcwL1hoOFhNR1IyekVaWFhLTkp5RmhoZkQrNHVLTnA4OThkOFJE?=
 =?utf-8?B?OHNYK0FTNmtIUitnUFZxWFpuaGtxV3VJZTNjOHBFYitlUDV1VkFya3ZwZHVi?=
 =?utf-8?B?MlBNMW02RVJlS2o5czB1eG9KVWh3V2RFMFFTVkt1TlJ2Z0xVYUZ3ejRnSkFw?=
 =?utf-8?B?ZWFyMXdRS0xvOFRPd1hqaXVpdkh3YWgzc2NsTFRiVXJzVmNEQVVVZ0VTL29W?=
 =?utf-8?B?YkRoR1EzcWlocGNLT21Cck9yWjd3YkZnRjhEdFlvZVlLNVZ4amRMTS9Tb3FD?=
 =?utf-8?B?UC9PRmxiUnBUa0l3TS9kd2tJWEVPUEJnbUxDMEpQbUJCNkZ2Unk0WFl4Vk5v?=
 =?utf-8?B?dDlaWXdoUTl5ZUIrbGpHZlVJWjVKd3ZEMEo0YWNzN1NHTnFXdDllZUpGcEQ0?=
 =?utf-8?B?SWxRb0liNXZ4eDA3Si9wcmJmdHBRVmdMcVpBblVsNm11U2R5SldzNWlLcHIx?=
 =?utf-8?B?dzNsYkNjRVNYZVR6cm1EdE9LNWtQK2RzWVh1V0haUGc1RHVCN2dTbTJaREJx?=
 =?utf-8?Q?hJDFbj67KMCtS397DuFaVDcuPY4E+I=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB9709.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WXZGNHFyOWhsZ1I1NTlXZmtPZzcrcjJBd1NKS3JodFNRd3NUN1owVmo5TXVR?=
 =?utf-8?B?Mzd5QzkyUlJ6cXpFSWt6Y1d4VXhlUnp6eW90dlpXeDhQL00vSkhhOXczSjR0?=
 =?utf-8?B?NlpRWDRVS29yV0JjdC9MV2tpRDJaSGh1UllrbGtXUm1UU1Y4clRTT2c4SCtN?=
 =?utf-8?B?Vk5zcG5BMk1rZXo1UWo4VVg4eVNaYzJwQzNOeFRaZnE2RzBHSXZDNWdZNzVY?=
 =?utf-8?B?Q253bGpkK3hZcGo4MWpiOS90NVZ5Q2VqcHhmdWU5eVdjV3crRGppRVRmUksx?=
 =?utf-8?B?bVlxdFh1cm12YUQ3YWIyU0FrYU02L1lBcXZjK2hOR1BOZlViajh3SmFsbDZP?=
 =?utf-8?B?azdTRS8xOXJ1K3RTSnhzK3MzcjQ1U2ZGTXhFSG9YWSsydVcrRW01TFVaK0V2?=
 =?utf-8?B?NE0zRDVHaVlhVmg1WjBiSmFIL1dTMkNhY2Y3RndJV1ROeVhzTHJRRjNWSUQ3?=
 =?utf-8?B?WGh0QUNZUDNQeG1hQ0ZuV01MbkFabVd1QnJXem5UeW1jL1FaUkVWQkpvd1J4?=
 =?utf-8?B?bTk0SnBtaU1RUy9KanNaZFNJNDh1VkVFVHBtOWE4RGJQeDkvaDZGaThSYmlP?=
 =?utf-8?B?ZnVIdXRaRS9LK0tFWk9zdkEvWGx2TUErTEZEZWNra3U2VnhwdlpFUTQ3S285?=
 =?utf-8?B?TVk3TzFkcmVIUjd5RjVLVXhSeC8xTk5HWWNpUDdWOUw2SmR2QlFoUEdWUFpR?=
 =?utf-8?B?UEhVeDhBNHNNZEVTUW9Ja0hoemdHQ2JiVDZZMzBJcW1ZWHFNOTNqOWprcFBQ?=
 =?utf-8?B?NXRmSTNicWJRMHgzbVBDTWxoaXY3eUFQQnBmVUFHSkFaQTF4S2lZeU1mWCs4?=
 =?utf-8?B?amx4TG93ZWFQUmFXNWxxRFhlSGZZcFgwZTI5eWoxcUhtejRtcEoreFpJVHI1?=
 =?utf-8?B?U2N1QUxEY2VUK3JXSFJiU0JqVHVUT29QU1FGeUZBa2d6QzdJZDV3N3NvT1F0?=
 =?utf-8?B?eFZ5Z2JiM1NjTVZ5VEIvTldmS2hoL3pFL3NMVjhMSWx4K2RmLytkQjA0T2ly?=
 =?utf-8?B?Rkp5cG5NTkluRVpQcWpWS3JvZjJ0bW04TUphOVhGOVNqazRrdFhWblhGK2lr?=
 =?utf-8?B?VjFzRmxjbVFxQ1diZitobG5hQUl0T1RYcyt3R3BlVkFQM2ZrQnA4NnY3ZGhS?=
 =?utf-8?B?NmpqTVZXR2RVSUViK3U4QkR3WkF1V3hHTTkzOHRZZXRPL3lIU2F3SHJZaHht?=
 =?utf-8?B?UHN2K09ub21Fblc5U2Ira1FmajgxVUdGKzBoZExGZzdZRlFPTzN3aEtZcGhv?=
 =?utf-8?B?QzNTSVdja0VYT2M4dVQvbmxtWTBHYXFyZ25VTGtPTEk1SHRRNTlEbHpWSW9r?=
 =?utf-8?B?bER4MEU3bGVrYkJUYXdqM0p5cTJnVEwzckpMNHl2YWVLK0pHRmMzZnltcVBG?=
 =?utf-8?B?K1dPdlVsQWF5TXRCTVI1VkJqZUhySnlhQmY3WW42aldUdkxqNGpCWHFteHlH?=
 =?utf-8?B?SWh0QTJPUzlBM1dGa0xaWndacnd1T28wYUs1UVNvSDlncUk4UDVtbkhTaE5D?=
 =?utf-8?B?a1BNVmNORGZZcnY4VzBGSWFrd3dVaTVlM0lZOWFvZDlrcWRuaDc5V1cyWllm?=
 =?utf-8?B?TUlSMm5kNEpPaFJ5WUtrWTBMV29nYnRBclUrWVpwbWVQSTVqNG12L2F5a2Rs?=
 =?utf-8?B?WkV2UHZZM2ppUDJhZXpzdnVNcnd3R3I5UFhQTUZoZktCeFIyZWJTMVBCVmVo?=
 =?utf-8?B?aDViT0FJU0hGOUtWUkpjL3BXOTJqaE9Sb1U0Tm1LOWJ1RERnaC9JUnB4QXg1?=
 =?utf-8?B?OGZaUWdTWkJha2lubkVIMUxtcXVTcE96TFFlb1F3dy9Jd21sZElac3NFemhs?=
 =?utf-8?B?NzQ0S1RUTlhPQTBwQnQ1Zll0alNWVE16bSs1ajRSaWd0QVFCQTZqZWxDeHRm?=
 =?utf-8?B?ZEZLdEdHNGdXSEZmeHV6NW8vYUU4M3lwcUJrdHlRRyt2V1UwaW4vekVndUVa?=
 =?utf-8?B?d05RNVg4Y0Z3S1FMUm5ZUTNoWUZnYW5KeTZVQXh1eHFhb0xsd2FkbkwxNHJG?=
 =?utf-8?B?bk1MaWdjMmFKVmZ4Z09rNHJJd1ZqdDNJRXRuVnFEcmJhcmFSQndSTDh0N1hR?=
 =?utf-8?B?d2p0bjA4N0lqbllUai9iTWxYaG9VV05IRFBCdDczbWN0eHE4cDZFS3JqRmdx?=
 =?utf-8?B?dUlXQ0M0cC96b1BvOWZRSE1jNDM3N2dqaU1LTE4wZVlvdzNOWmtKZHhtVGE0?=
 =?utf-8?B?b2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6A42807BAD7C834AB7D179D52635AFD0@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9709.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 230bc49e-b4b4-4cb6-06dd-08dd78f4715a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2025 12:29:02.5499 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uXt4rw/i5QFpGDqZsgRUMu1CB/vf+OPmGCX+QxrrDdCWtJirf/vcswmpL5TjATFQJYIMkRiFDfclLNpDAlq9Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7864
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

T24gNC85LzIwMjUgNzo0NiBQTSwgSG9yaWEgR2VhbnRhIHdyb3RlOg0KPiBPbiA0LzkvMjAyNSA5
OjE5IEFNLCBHYXVyYXYgSmFpbiB3cm90ZToNCj4+IEhpIFBhd2VsDQo+Pg0KPj4+IEZyb206IFBh
d2XFgiBLb2NoYW5vd3NraSA8cGtvY2hhbm93c2tpQHNpaS5wbD4NCj4+Pg0KPj4gNS4gVGhlIGxv
b3AgaW4NCj4+PiBjYWFtX3JuZ19yZWFkIGlzIGNhbGxlZCBzZWNvbmQgdGltZSwgdGhpcyB0aW1l
IHRoZSBgcHJpdi0+ZGVzY2AgY29udGFpbiBzd2FwcGVkDQo+Pj4gZGF0YS4NCj4+Pg0KPj4+IElu
dGVyZXN0aW5nIHRoaW5nIGlzIHRoYXQgdGhlIGpvYiBzdGlsbCBzdWNjZWVkcyBhbmQgdGhhdCBz
b21lIGRhdGEgYXJlIHByZXNlbnQgaW4NCj4+PiB0aGUgYnVmZmVycywgYnV0IG1heWJlIHN3YXBw
ZWQgZGVzY3JpcHRvciBjYW4gYWxzbyBiZSBhIHZhbGlkIG9uZT8NCj4+IEkgYWdyZWUgdGhhdCB0
aGUgZGVzY3JpcHRvciBzaG91bGQgYmUgcmVpbml0aWFsaXplZCBmb3IgZWFjaCBSTkcgam9iLg0K
PiBJIHdvdWxkIGFkdmlzZSBhZ2FpbnN0IHRoaXMsIGNvbnNpZGVyaW5nIHdoYXQgSSBzYWlkIGFi
b3ZlLg0KPiBIYW5kbGluZyBlbmRpYW5uZXNzIHNob3VsZCBiZSBkb25lIG9ubHkgb25jZS4NCj4g
DQpCdHcsIGxvb2tzIGxpa2UgdGhlcmUncyBhbm90aGVyIGlzc3VlLg0KDQpqcl9lbnF1ZXVlKCkg
KGRyaXZlcnMvY3J5cHRvL2ZzbC9qci5jKSBpcyB0b3VjaGluZyB0aGUgZGVzY3JpcHRvcjoNCg0K
ICAgICAgICBmb3IgKGkgPSAwOyBpIDwgbGVuZ3RoOyBpKyspIHsNCiAgICAgICAgICAgICAgICBk
ZXNjX3dvcmQgPSBkZXNjX2FkZHJbaV07DQogICAgICAgICAgICAgICAgc2VjX291dDMyKCh1aW50
MzJfdCAqKSZkZXNjX2FkZHJbaV0sIGRlc2Nfd29yZCk7DQogICAgICAgIH0NCg0KaG93ZXZlciB0
aGVyZSdzIG5vIGNhY2hlIGZsdXNoIGFmdGVyIHRoYXQuDQoNClRoaXMgd291bGQgYWZmZWN0IHBs
YXRmb3JtcyB3aGVyZSBDQUFNIGlzIG5vdCBIVy1jb2hlcmVudC4NCkxTMTA0NkEgaGFzIGEgY29o
ZXJlbnQgQ0FBTSwgc28gd2UncmUgbm90IGhpdHRpbmcgdGhlIGJ1ZyBpbiB0aGlzIGNhc2UuDQoN
ClJlZ2FyZHMsDQpIb3JpYQ0KDQo=
