Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D0BED2F7E1
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 03:14:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D969D88DE1;
	Thu, 17 Oct 2024 05:14:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="g4sSYr+Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A2F788E1B; Thu, 17 Oct 2024 05:14:53 +0200 (CEST)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20613.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::613])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F12588D40
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 05:14:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mlu8joI7PjfmtnlGd2gFYX5ns9dpGWZL3CJGVvW6eFg1jSi4yBSOx6CYaUiaXrVwlfT6rP49jMuDhtoQrNb3xpaFMX335EISI2NHfzjN/EdtxIBMlX8IlSaNHFsKCIPerTQ3WByWd6IStFagjPwIKN06hFnran3juZltR4oh1BmcH9n2nw0qiiXy3NlIeyEV6MURPQ6qeOvIUGP+UHZRycaYcCmzJvZ98kvF5fjP3adDtFt4zX58GK8E8Jmd7NtOuzbC+DsCvZP+UG3b9hh07DmwXfAh7j70fdBam8SBJAbxSK7QinBRA+0gmiQqt5HRajHrgeWLjas4TI/yIYRE1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oBYJdnpURgKc2HIu1sPoKsLEyK2hk5w3PTDhSX1p/OE=;
 b=LGQwPldgDO7M2VxoVggJaKZsTpztyIt0iKrgcQgheRroWODLEx4HAK6ryZtKg1gdb5xJsWrVr8hipa2ewSmXP9gJCwKXWhvsy0hhi96WbwGJCizBPyqPIwKSpYW14TchKRE4RiwrFRWbfhrVwCvhw3q2WN0RVSllMZ1+bDtWXcpDcY3TQmEj47sjzAqkTFljWV8ae7mQGrlrsgrXTdK90NyOFKNYdgPqOxMiCAgnZLjETu2uiUdhpAMbU8Cm1RIqRBC8mnwCCJM1vDcYtCV6hdaGIVDKpvBabQkPDrFpafpave/MVXQiPTm5QFraW6VohfHSBqg0XQVT+ImzLqJzEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oBYJdnpURgKc2HIu1sPoKsLEyK2hk5w3PTDhSX1p/OE=;
 b=g4sSYr+QpD1V7Bx0cKrbfqnT9m6peiS1BD9lgyfZzFT6Bi2uH3gI4xjrs6pNkjM5FOf/8c/MN9XDJWjpwy7h4ow/SpMJaVLCwSnNpAIgPMHc0r9WL7VH6Qaz+jSnOEYKGLdYxkiXMRXTTttX5MhPqRACm/akni5c8ykcqWIaedkIi/xXxonsgjNNwdDGAdjQp8RHCEd/TUIK1ilqBtL3gPSlCN0zGrWO5pHPe73Ph4wQGYYpZNuov0lr+5dwNt1F0/wKGS2Hzwqo2W+IAWUMEwvhhPOQ9wK4FgQgL4gCRkM6E81EvkfNgCZvwqwYaAyN0ji6M9Sd+yAgFF/xzoiNbQ==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA4PR04MB9591.eurprd04.prod.outlook.com (2603:10a6:102:270::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 03:14:46 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 03:14:46 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Tom Rini <trini@konsulko.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC: "festevam@gmail.com" <festevam@gmail.com>, "sbabic@denx.de"
 <sbabic@denx.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>, dl-uboot-imx
 <uboot-imx@nxp.com>, Gilles Talis <gilles.talis@nxp.com>
Subject: RE: [PATCH] cpu: imx8_cpu: Avoid revision to corrupt device tree
Thread-Topic: [PATCH] cpu: imx8_cpu: Avoid revision to corrupt device tree
Thread-Index: AQHbG8OV2ytJDPNYZkWDYfI8Ze6VULKKTOIAgAAAv3A=
Date: Thu, 17 Oct 2024 03:14:46 +0000
Message-ID: <PAXPR04MB845984549FD1762C0A3AC90888472@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20241011105827.7729-1-peng.fan@oss.nxp.com>
 <20241017031106.GA55137@bill-the-cat>
In-Reply-To: <20241017031106.GA55137@bill-the-cat>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|PA4PR04MB9591:EE_
x-ms-office365-filtering-correlation-id: c30f687f-4a1c-4964-8c52-08dcee59daa6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MG9GNjR4eHJNbzJOUzE0OHRqb1VSSzlmL29rN2V4eDNlSWJGZWgwR3NPWEVK?=
 =?utf-8?B?a3cyTEY3TXZuaytKQjBCcnFLSUduSXdiRGp3NEI3ZHE3c1hDZC9ZRzNxc1Nk?=
 =?utf-8?B?YVNMZktOd2lSS1YxVmtzTXVHd3g2VE9OSERDR3ZwTWs5U2RJVlZjTTZzb085?=
 =?utf-8?B?enJiQUZFTjRNSUF5ZFlqUm9RR2x2REZ3SnFxRHQzSm1ycU1taWQ3ajZRTUlu?=
 =?utf-8?B?Zi96Tk1Bd3dYdnFnUUl5RC9vdW5jR1pxQko3OTlkam9iWENJSEN6aFkzbmV4?=
 =?utf-8?B?dUZvdkZJZ1VNU2lXQ2lSQlNrWkdkTDJuTmN3SXlYR29rQUNvTUJCUnVMUWE3?=
 =?utf-8?B?S0xlOC9PamViUldNMGJ2K0Y0MEI1VWZISnFUb0I5SVorQUczd0tpa20rdUxX?=
 =?utf-8?B?RjJkdlFLQjVqL1VqeVRPaHVydmlYLy9Nd0NYTXdEbGovbWpiU2RRbTl1VFpn?=
 =?utf-8?B?TGtWMHh1UVlnZXVXTTF6Qld3cFpPeDAzMWxFWG51dW82R0RQYU9WbGtReUsv?=
 =?utf-8?B?TEdwZzVhYTRsaGZzbDBWYjJKS1FnNTU2MlhHR0xSTnYrd05aOFZIbFFlNTFp?=
 =?utf-8?B?RkE1QzdhdUtpVkE3MEhiU1VFdlNtd0E5ZEt5a1JOWkdUQTNoWm50czhJbFgx?=
 =?utf-8?B?UWhsRmhCOE9lbHBUWkZsOXRDb3ZFQTJ6YUYwK2Y3VWs1cTZsK2xHVmNQZitV?=
 =?utf-8?B?OUMzUDl0V1lmZTNBQ1lndklySDR3R1h6dW4zVE5RcGhVR3dZU0x0NnhkQm9Z?=
 =?utf-8?B?SGFsekhXM1dvN0RLejNnbnd4elQ0cWl4d0MxaXdRUnNoZllpT1E5Z0xmK0o5?=
 =?utf-8?B?RnVXTzdlWnJVWUU1S2xFZGRkZ053RVpSM3c4eUpzcEZ4elg3VWM4L3lCanZo?=
 =?utf-8?B?SzhhTFZSQ2NlUFc5T3VneVdGRjVrS3NTckxnSVNlcUxiU0pPM2RYZy9MajVY?=
 =?utf-8?B?TmZZaTA4VjhVb243ME1EMzRDUWxET3dlcDdDVVRySHg2eU9OYzJsQmRsRUNn?=
 =?utf-8?B?OVBZay9CMnF1V0FlU25lemZZSUNXYitKcGhTM0hCenR2UkFXK3pVbnVQamtm?=
 =?utf-8?B?MnhUZEJFVFZ1OEpDZHQwNUs1QXJXR3FJNDlDS2U1cEU4ZE1iVkFJalRLVWdn?=
 =?utf-8?B?UTc4N2Eva2R0b2VPajl3akZ4ZWJQc3AranIyZUZ6NER3cXZnODExdVJETzBy?=
 =?utf-8?B?UDhIZmhWc2cya2UrZllpRkJPcElzNWdXR1RsRHczb0RuTitRd0xoT2pTQ09O?=
 =?utf-8?B?Um9Ra1lJb2JML2xCRlczZi96cllRTmtYWVVUWndnVWs4bTFUODM1MjBxTVkz?=
 =?utf-8?B?MjNkc1A3RU9ZbEtNZmxxSkNrQVZ0UnFyTk5va1NFemJpUWxhVnRwY3YxaUNv?=
 =?utf-8?B?VFcxQjArNHdncjlDZ2YyYXJ0dGM1ODBPREQzUHBrOVBlUjYrbzlrZkh2NDBC?=
 =?utf-8?B?cTUwcWc0eDJzV3p4VHlNMXdrZUU4a0ZPc0tYOVg0eW5sNFlPN1JpbWZmYzJK?=
 =?utf-8?B?QUo3MjMyQk9tZ0VFOU5MajZLWXlqbEc4OHVkb2FqMVdrVWJHRldNNnVGQVgx?=
 =?utf-8?B?UTBoSWpmQlExK2dsUy83VTExRnBpMTBCc3NqU1E0Qy9WYnhMZkRuMjFGVk90?=
 =?utf-8?B?QW9pbUFPbWZ1alQ4QmNsVm5NbExqMXU2ZkVjckxFcTVjbGNaZUNRV1NnRG9K?=
 =?utf-8?B?dVE5bDFVeTFUUkpWTGFreXJXemJKb05DLzJseFJTRXJTT3VlN0trRGFIUFhw?=
 =?utf-8?B?QXJyWGdYekVwdDhIc2RqN0VJNjZyT0szSkNTQmpUR1g1NEJZeEhNbTVkQVZT?=
 =?utf-8?Q?gOHTQgKev/pCDm3HAW7JsvRtLJ7grmYMjMeIM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Qjg5UStPVjl0RWp0R1NjY00yK1g4SzZjNkh2WFRLVzdxR1VXdDZSa0lDZ3g0?=
 =?utf-8?B?MmJpOUFld0tvb2dLajR0bGtxaEVtdVBzTnhFNklPaEEwU011T0k0U0YxMTRu?=
 =?utf-8?B?c3RRbzBEWURvb2pTR0Z0QldtSUM2Q3VES2J2QXNCa2VvR1FlbHpTcFRrUy9h?=
 =?utf-8?B?K1Q1ajN0RnZvOWtWQ2xiUTRxQ2k0cUpwTzJxUzJrT3Y0bjE1a0lESS93TFpT?=
 =?utf-8?B?UHFxNFhBUGxXcEg0cG5heWJwUzV0YzNtYTFkUXh3VmtaSVdjKzVmNUp4WVV1?=
 =?utf-8?B?VGZiVUYyVDRsMklBenF2TWdhM3QrUExqWHM2SmxUaFE3NWJGdHdDbDM0YUgz?=
 =?utf-8?B?OUwwNU5ac2pCRXNxSnA4OU8yTndBUmF5ZlRuNWh2cEhLUm1rdnhMQUVKR0FL?=
 =?utf-8?B?YzJrdjkrZW5rb2dGaWhkU0pSalRiVnFRWHpmSG1Da0MrUm5sa1M1OFJPVGxs?=
 =?utf-8?B?MHpMcUYrVlA3aXliM09jQXduVU1oSDFYYmswczY2b2JiMlBwREJBeWlrQ2ox?=
 =?utf-8?B?UnlCVU5SOTZ3dTBlam5GTnloZHMvR2VVWkNKd01Id0x4eVJVTmZWUmlnUG5i?=
 =?utf-8?B?UndmdmxjVDZnWTBMaEZ1TFBiTVRNbG5FaTY0ZTlyQWNHMUxlMU04b1R1bVdP?=
 =?utf-8?B?TzJkRktSNnVNM0NUY1F5TWhNV3FmdGlLWnNIWVF1NkVGRE41UGJUSThrek5F?=
 =?utf-8?B?WTQvSkpJMVpiY0dYcnhhZ3puL05GdmlUcFZLYUc3ZkI1VlFkckJHQStpTVhj?=
 =?utf-8?B?bE1jTUVNSXBHZW9RL3dsdHBNSlJCeTNQSXd0dzVnb1lyNWpQdjhpeW5vUkNV?=
 =?utf-8?B?QkY3TnlqQ2tHQ2NtTk9SalRVbmh2b1l1bmpXNkEyK3ZRMjUwZWZBMElTTU91?=
 =?utf-8?B?RmdsbVFDUlZjcjBic2dBeC9pVlJXa3lTV3dYa21pSlRwZHpOdVJCQXQ4S1Vm?=
 =?utf-8?B?NlFseC9UdUsrY1JTaDZYaDE2dTlwQkI4dXl1OWxSdXhIQWhTbjh0VWpsSVNn?=
 =?utf-8?B?U2FBbE9wZDNoLzNIbk1IQUwrOXA2d1Z3akhYT0pFek10YU5pWEFRNytzL1Mr?=
 =?utf-8?B?aEpTUjA3dEhZTGZpbkRDa0tBZVM2UXlhbUtqWWpQakF3dmw1S2hkUngxNkph?=
 =?utf-8?B?VVY1OXFON1JiL1YrV0QwQWlDVnF3Z0R1ZWdRWGJjRUtnVkpIdU5haUMrNnNW?=
 =?utf-8?B?VGl2cHpicEFhYXV3Z3JKdnhIc3k5c1c2WEtMRWVtcFRXcTcwVkJOSDY3cmsy?=
 =?utf-8?B?VFNabGpxUngzaktLY3hnNlZBY0N2dktDdW9ISXdod3dJeVUyL0drdWJMQW5a?=
 =?utf-8?B?cUlaYXFVbXQ3WjMwU1NxZEZZZU13S09idklNTUlLeG5tMFl1K3dIUDNmOXRS?=
 =?utf-8?B?TTBFc053WTRyRXBJSGRMZFNZMTVXMUhINlAxRXZzcmYrRmlPVXhobk1SeTNx?=
 =?utf-8?B?d04waFlMSU5yVldMUGVZd1VWdXo1TnlsVEExRnhQejNZY0xQK21RRWlLdFpn?=
 =?utf-8?B?V3FSblkyVDVQeERUaXlxR0s1cm96UWppb05LZTY3ZFFNZnl3bzk4dFRzT3JO?=
 =?utf-8?B?ajk1U3dDaDJmVnVFdnZDQXZUZzlVUjRPVzc2ZnE1VWJTYUJsMExnaFp1blgy?=
 =?utf-8?B?SWozYW92SFNXUWN5dXlwaHZKWjZRUWNoOTRmTzJKQnlTcWVuOVowNG5YMlRY?=
 =?utf-8?B?VmpFR2JsWFByb2NxT0JieS9TOG1kaE83WjRsTU9PdVg0RDI4TU15VzhFSFV5?=
 =?utf-8?B?UXZJMjF3ZlQwc0NpczEyTDBmWDJTRTRHNnA3cFZRUG1yWm5wNjhEVCt0SzU0?=
 =?utf-8?B?ZmZuQmZ4M2FzMzFxbGJHNXg5dCt2cHo5TlpBekJaV21HNzl6WVFaZ2xXVUxV?=
 =?utf-8?B?a3gzT29oSUVGUngwWUlYTjI0R2FnemxGQUg3OFN3eXB1N0hTS3BzaFlUU3Bp?=
 =?utf-8?B?blhnVGw5eWFPSHZ6OXpRdFdIWGxNcVZqL00vNVovVmRqOEZWMGtrdTZsMmNv?=
 =?utf-8?B?Y3NtOStzMFlDZEdJeisvZ2hGK2prM2k1YXBEekVrMEI4TEwyWkZpWmR4MjZ1?=
 =?utf-8?B?U0ZWdFM0TjlGNWhBUmJ5YVVWbVk2VkRtZWU4S1ZVbUg4MXdyUnFKRzB3Q2dP?=
 =?utf-8?Q?hYYE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c30f687f-4a1c-4964-8c52-08dcee59daa6
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2024 03:14:46.7096 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QyiVc7WvZE8vzlecxFOZGxXGKQOoMW06ENcK7OhyASUWAz/0JwSLyxB7sJyZ0Fym9sb6NbTcjDR9vcqC9E1RQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9591
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

PiBTdWJqZWN0OiBSZTogW1BBVENIXSBjcHU6IGlteDhfY3B1OiBBdm9pZCByZXZpc2lvbiB0byBj
b3JydXB0IGRldmljZQ0KPiB0cmVlDQo+IA0KPiBPbiBGcmksIE9jdCAxMSwgMjAyNCBhdCAwNjo1
ODoyN1BNICswODAwLCBQZW5nIEZhbiAoT1NTKSB3cm90ZToNCj4gDQo+ID4gRnJvbTogUGVuZyBG
YW4gPHBlbmcuZmFuQG54cC5jb20+DQo+ID4NCj4gPiBVLUJvb3QgZGV2aWNlIHRyZWUgaXMgcGFk
ZGVkIGp1c3QgYWZ0ZXIgVS1Cb290IHByb3Blci4gQWZ0ZXIgdGhlDQo+IHdob2xlDQo+ID4gc3R1
ZmYgbG9hZGVkIHRvIERSQU0gc3BhY2UsIHRoZSBkZXZpY2UgdHJlZSBhcmVhIGlzIGNvbmZsaWN0
IHdpdGggQlNTDQo+ID4gcmVnaW9uIGJlZm9yZSBVLUJvb3QgcmVsb2NhdGlvbi4gU28gYW55IHdy
aXRlIHRvIEJTUyBhcmVhIGJlZm9yZQ0KPiA+IHJlbG9jX2ZkdCB3aWxsIGNvcnJ1cHQgdGhlIGRl
dmljZSB0cmVlLiBXaXRob3V0IHRoZSBmaXgsIHRoZXJlIGlzDQo+ID4gaXNzdWUgdGhhdCDigJxi
aW5tYW5faW5pdCBmYWlsZWQ6LTLigJ0gb24gaS5NWDhNUC1FVksgYm9hcmQuDQo+ID4NCj4gPiBN
b3ZlIHRoZSB2YXJpYWJsZSB0byBkYXRhIHNlY3Rpb24gdG8gZml4IHRoZSBpc3N1ZQ0KPiA+DQo+
ID4gU2lnbmVkLW9mZi1ieTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQo+ID4gLS0tDQo+
ID4gIGRyaXZlcnMvY3B1L2lteDhfY3B1LmMgfCAyICstDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvY3B1L2lteDhfY3B1LmMgYi9kcml2ZXJzL2NwdS9pbXg4X2NwdS5jIGluZGV4DQo+ID4gNmMw
YThjMGNiZTQuLjE5YzY1YzdjZTQ3IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvY3B1L2lteDhf
Y3B1LmMNCj4gPiArKysgYi9kcml2ZXJzL2NwdS9pbXg4X2NwdS5jDQo+ID4gQEAgLTcxLDcgKzcx
LDcgQEAgc3RhdGljIGNvbnN0IGNoYXIgKmdldF9pbXhfdHlwZV9zdHIodTMyDQo+IGlteHR5cGUp
DQo+ID4NCj4gPiAgc3RhdGljIGNvbnN0IGNoYXIgKmdldF9pbXhfcmV2X3N0cih1MzIgcmV2KSAg
ew0KPiA+IC0Jc3RhdGljIGNoYXIgcmV2aXNpb25bNF07DQo+ID4gKwlzdGF0aWMgY2hhciByZXZp
c2lvbls0XSBfX3NlY3Rpb24oIi5kYXRhIik7DQo+IA0KPiBBZnRlciBteSBsYXN0IG1haWwsIEkg
cHVsbGVkIHVwIHRoZSBwYXRjaCBpdHNlbGYgYW5kIHN0YXJ0ZWQgbG9va2luZyBhdCB0aGUNCj4g
ZHJpdmVyLiBXaHkgaXMgInJldmlzaW9uIiBiZWluZyBkb25lIGxpa2UgdGhpcz8gVGhpcyBpcyBu
b3QgYSBnb29kDQo+IGNvbW1vbiBwcmFjdGljZS4NCg0KU2luY2UgdGhlIGZ1bmN0aW9uIHJldHVy
bnMgYSBwb2ludGVyIHRvIGEgc3RyaW5nLCBzbyAuLi4NCldlIGNvdWxkIG1vdmUgaXQgdG8gbWFs
bG9jIGFyZWEuDQoNClJlZ2FyZHMsDQpQZW5nLg0KDQo+IA0KPiAtLQ0KPiBUb20NCg==
