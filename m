Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43C46CCFA04
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 10:57:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC3E7838BB;
	Fri, 31 Oct 2025 11:57:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="fAewa6j6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B70C083885; Fri, 31 Oct 2025 04:38:47 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB1368331F
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 04:38:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AH3SFVzFyFyYVppZ6Ja8ywmI460tm02NeLV9U736bt/ttjC6Cxj+e5thVkpuSlw8zXXpdxDoQrfVf8n7SgJoTK40qbB2/9qZ1zj83x7SI9nsqBKeEW38/6cU4Or0aPx8uL94Aq+gra6VnrFuYTLfiAsgsEsOmfKBnQPfVyuabxnne94XWoYOPixxlQkMdbGSUgIxC2Sk6BEEO4Cs9RNuO7+dpi0kBRKULjf9+QKG2gzgT543QGqbrkI4/lVl3iD4XIIc75oA1sPKSe5nikTl9DDClsPFJw27J/wp28JN5kSQTUqeU6XyjZwmCdiSSDUS9qGlm/rArXRVP/RIeCwejA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O0SYrc9sQvonNhmj1zZQ4rkJu4W2zzS3oOagvr30MAU=;
 b=BzELiWn9c0QFJ7c7TMDXLDrq2LY+LBF8MCfXllkojdR7uYyIezrPXKvD/7n9OZskAE09h6bUlCZZrpz3g5qt9OR92BN08P0vfjLYyP79n/eGftf/uTE5yKVmj9ytyRSnp8CP67s212e+31/YzEHZ1bxAbdPhi/noukch4rZ1mn18dlYKss6E9RCh7e08rEwnkPgZj2Ce1Tn3+Qv3IkMp0d5X0LSjvQg5CeTl531RQezd/oWzC/+T58CLjlJDFO9/AHDpcYeKdy/YQo4ZRLxsrM8RgkyCN7hDxU0WCK0KCpREIQwcYETXm3YB2VZeaP9vcGMpd+YcGZlB8v4GVJBc/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O0SYrc9sQvonNhmj1zZQ4rkJu4W2zzS3oOagvr30MAU=;
 b=fAewa6j6e9JN+Fq9ibhz5A142ewWazs8IbbhiiValX0FHM10ETB2Ske58W3Xk+xNv+U/nt30H64ro4/RlBhGnCH/eNPQuOhxVwO8OovIdwNefL77X+rimnbz2khqw/BQbFhY0myrg3QyQVzyO1IbAK5C8cwYmkEsAl3Z6svtqSjkUcLdbHJjkjrCsFxdB1fBGxaYCoKLzF3p5dAJfmgJ24bkUb3lwky2LjKO0yr68VA3Fbkf9mUMAk6IULF1H3Hsn/CB86OfY8q9KmaglNsAGlSaaKIMYn3oAP40lm//f6K0iYPksiJWLiYVFZ9CEgWdlZFiD1aypnmmKYBkRNsz9Q==
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DB9PR04MB8219.eurprd04.prod.outlook.com (2603:10a6:10:24d::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 31 Oct
 2025 03:38:43 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 03:38:41 +0000
From: Alice Guo <alice.guo@nxp.com>
To: Marek Vasut <marek.vasut@mailbox.org>, "Alice Guo (OSS)"
 <alice.guo@oss.nxp.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Etienne Carriere <etienne.carriere@linaro.org>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Peng Fan <peng.fan@nxp.com>, Tom Rini
 <trini@konsulko.com>, Vinh Nguyen <vinh.nguyen.xz@renesas.com>, Viorel Suman
 <viorel.suman@nxp.com>, Ye Li <ye.li@nxp.com>
Subject: =?gb2312?B?s7e72DogW0VYVF0gUmU6ILvYuLQ6ILvYuLQ6IFtQQVRDSF0gZmlybXdhcmU6?=
 =?gb2312?B?IHNjbWk6IERyb3AgbW11X3NldF9yZWdpb25fZGNhY2hlX2JlaGF2aW91cigp?=
 =?gb2312?Q?_misuse?=
Thread-Topic: =?gb2312?B?W0VYVF0gUmU6ILvYuLQ6ILvYuLQ6IFtQQVRDSF0gZmlybXdhcmU6IHNjbWk6?=
 =?gb2312?B?IERyb3AgbW11X3NldF9yZWdpb25fZGNhY2hlX2JlaGF2aW91cigpIG1pc3Vz?=
 =?gb2312?Q?e?=
Thread-Index: AQHcShfZPUErz8unhk6IH1zrJO/2OQ==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 1
X-FaxNumberOfPages: 0
Date: Fri, 31 Oct 2025 03:38:41 +0000
Message-ID: <PAXPR04MB9644DEF9BD3C55CA60E7AB6AE2F8A@PAXPR04MB9644.eurprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-traffictypediagnostic: PAXPR04MB9644:EE_|DB9PR04MB8219:EE_LegacyOutlookRecall
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c1ce2283-616d-4010-8cf6-08de182efc5f
x-ms-exchange-recallreportgenerated: true
x-ms-exchange-recallreportcfmgenerated: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|19092799006|1800799024|366016|38070700021; 
x-microsoft-antispam-message-info: =?gb2312?B?emVyZkUvaDU1U1Q1bzFjOTA4d01Dc2t3R1lKQXhiM2hzZzVkUlg0SVNBKzVx?=
 =?gb2312?B?RDd5eEQvZW1YVnZra1ZMSFlCampTOUlYSU8yS1lPVGZpcS9iVVdlVEZ2V1Vx?=
 =?gb2312?B?NjJXSG51d0p2NUZ2Mjk0cEVzTzhEdVloallVa0xiRVpKZ2Fadk1vdGowdGNy?=
 =?gb2312?B?NURFY2ErdWhxbDd0Qy9pOEw4R1ZaZ2RIdHM2R3FYNVJKOEg0V3RmcnNaVDg1?=
 =?gb2312?B?dENLLzE1VlA4Y1pIMnB2UUhPNTBnUXhSQThyYXFZSHR0L1Z0QXN3dWxtMkJr?=
 =?gb2312?B?TzFISWpQb1g4akhxUXFZUVpZc1dVeDJkT1p1TjRmRW12Um15VUlDclFBNU1Z?=
 =?gb2312?B?SEZEZGJiZmVRV2FtOUlvL1VOSUFUY3RBeGQ3VDZSOE9qUndTcUtRa3FEQm1z?=
 =?gb2312?B?MTJhazVvdnVYUEZDU0RTQUN4UnI5Qml6aVdVeXFQVmxvUlh2RUtCK1IzWW53?=
 =?gb2312?B?VExST1lCT1ZNcjJFVms3NjhUclRtR0FLeW9lN1lOUmRPSzZpMHd6M3FDN3A0?=
 =?gb2312?B?SkYzRys3dmhaTEpuRkFCd1J2N0VVT1lNVGVtUWhoajhZR3BIK2tBR3ZHeElZ?=
 =?gb2312?B?U0l1SCtXU3psaG5UWDFaMzFuWHFrLyttN1llME9jWitmMVJNNFRpcjBVdmhj?=
 =?gb2312?B?SndBSlJ1MS82c0dwcUR4MkNtSVNvTnl6aDZVTzk5dGoybDAydWpQOXVaV2V0?=
 =?gb2312?B?Y0p0a0dXWnFiVnZxQnNsemZGMnZEcWlmVkZ4bjRoRGQ3MFJ5R1VIdDBIcXBM?=
 =?gb2312?B?Zjk0azNpRkUySnJKdWR0R2VJbHBGczI2VEpGbVE2bjN6aGxmRGU0dGY3UVhV?=
 =?gb2312?B?dmtzdW5vT2oxNUptNWNXd1lrNDhGaGRvekJmNGJvcldEcHVLQ29WMkRHc0xy?=
 =?gb2312?B?SGptR0pTS25ncHhKMFVQbVNKTG1aTGFUd0dUSTdoQmRHbVFZNXFmMlE3Rllr?=
 =?gb2312?B?WUpFdHJCeGkvYTduamw4ZzljeERtZWVoY0EvS2NQeUpxcmJXVURYVDFkSTY1?=
 =?gb2312?B?dzZnZ3FDTktPQ0NIYXRqSGJCNEs5OVd3WU5nZnZycjhhUzVnazh5R2ZaNVhE?=
 =?gb2312?B?QmdGWUhuOS9vMzZ4QS9jV2M3eVRTN0dzS2VJdnFpS3NXL2tPOWZienc4Z1ow?=
 =?gb2312?B?V2s0Mis3RzNvaW9lem0xVUFPcUhwRDBlc3hIaFUzNGZjd2hCWnhhaVdlWUwv?=
 =?gb2312?B?clJEeHVuR0FncHcxTjNndEp0OVoxWVdvb3RYWkJaSU9qdFF2OWNzK0JldWZh?=
 =?gb2312?B?VTJQeVJ5VlRQaXZkRndjeDN0UGhUdDZHR2YxSkp5cDNBQ1Y0TnBXVFpJQzdH?=
 =?gb2312?B?b1NSNGdxQyt3RnVNMmluOC9SeTUyVDR1NERRU2FzMVI0YVNRYXU4eTlIVmR5?=
 =?gb2312?B?TSs4NEJtK1Nxb0Rpb1Y1Y01pVEpoY3pwOUk3MmxSNm1xL1o2V0FRb3Z6ZmdB?=
 =?gb2312?B?NXcwUkYwVERad1JJcENzZGpiNzVpUFNsajdBbHh4WStQVzRacG54QUtNWjhH?=
 =?gb2312?B?OW9Bek91cGR4SFp5UStteWVsTlJFY1hoUjBpZ20xS2J3cHpNK0FZL1QyNWpr?=
 =?gb2312?B?VE1hYlNrZEFFUWExc01yT1MwaUhuU1BPYlUvZnRBRjlCeXAvQWxrVmtXWi9z?=
 =?gb2312?B?UTRuWG1xUThnRHc1WXAxamtUTDNXdXpHZldQaldUQzdKNlV6UEkxVVlMYlh3?=
 =?gb2312?B?MFMzY2R6cWFodDVkOGRLdk8yamM4TWI0d2dsbktaT25obmZ3WWtVeTdEY05n?=
 =?gb2312?B?U0RWZ2lPQ3FzVWRIdmpxSXRrOWR4TFdnelpzdEl0VlVEZnIzYWFWbndVV0lu?=
 =?gb2312?B?cnRoOVBZdjJYa1Z0eFJMYnArdnZvR05ab0x5a1FSekJuZzlBWm90TXJ5elJ4?=
 =?gb2312?B?REsreDcrb3dWd2t4ZUN0RkhTaDk0QnMvR1FGejZrQVRmYWhwbmVaa08yc09S?=
 =?gb2312?B?dDlDOU54ZVVoRmpsM0tQRHpjSWMya2VWZUtHT2k1YWh2Mk5yVE05Z0F4Z2NL?=
 =?gb2312?B?MzBvejNINURCajdFMnkrS205dUtVMGRHUnQ4dlM0Q2oyUElnc3JXbVlncmRW?=
 =?gb2312?Q?QmZBGF?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(19092799006)(1800799024)(366016)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?RUVaWjVUbGxtUGhrRTIwYXFSZDBzRzk4cUhoemU2T1pDR2ViNUphc0JobDlG?=
 =?gb2312?B?M0UydTEzZGJuMitJRmg5QUx6UldUME05Z1RQQS9yV01uMW9TZlJvRmdkam9r?=
 =?gb2312?B?VjE5eDhGNmxkWGNEbFB2Z054ZzVZQktkb2gvN1ZGWmFKYld2bjJyaG54K2VZ?=
 =?gb2312?B?ZDV2QVpuaFJzWkhEWGJRUkZBNnNHbGhxNjdRdW5PTFhXUlJ4bEhHYXFDNzdM?=
 =?gb2312?B?dUhtMWN0d3dUbjh5Zk91enhtbngzK1krVEx2cm5KMU9PUjh2OTV6Wm5zZ1FZ?=
 =?gb2312?B?N1FVc3pSWm42a2JDRlZ1OUlCeG03bG8zMUpNZFVPaTExTFFSWEErWS96RzF6?=
 =?gb2312?B?RmJjOVNyVENBUWdkbGE3OEhWdDJUaURzR0YwMTY0R1pWOERtMmV2ZVZSUnBI?=
 =?gb2312?B?YUt5Y3dZdVVUOE1ibWpNK1djTnJjRXExK2s5ZU5aS2hyMWNQanBwcnNkVTRV?=
 =?gb2312?B?V3ZwUmwrdzlRWGFXWmx6T3VlTFQvUDlBdFoyRlFjZktXS0h6a1VMcmRhVERH?=
 =?gb2312?B?bmJuQ3pBaEZjRlhSd2xjNm9yVXVvNzI1R0VVa29rTkdWd0RtdWdpWkRJSms1?=
 =?gb2312?B?YVQ2VjBkczM1VHoxU2had1dUY2lIQ3hlR2grTEpBOERDREx1WEtVTWV3QUVm?=
 =?gb2312?B?YzJUYmo3K2JsS01QVG5ZbG05citlZ0JPODdFWVVTSngvdFpiSlBVUTY4S3Va?=
 =?gb2312?B?aVFsUFhVOXJqc0RDa3F0Vi8vZ0JJWlBibFhLUDJZUElvRFVkRU9tVkRTdlly?=
 =?gb2312?B?SWdQcDFScWw0dFVKTHoyTmRKREtHeXNJc2lUUzRLcEM2b01ONUFuYVZvaVJq?=
 =?gb2312?B?QVJQeHgrcXpJSXBJVkdBSmZXc3JtRFhPY2djWFFjUkJZWU1iMyt0N1VSTEhj?=
 =?gb2312?B?MCs3bk4vWms4SFltRnY1aVI0TSsvWWliQU1KS0R6dkFqYWc4a08wVlZKYXFG?=
 =?gb2312?B?WEwrVnE5RUNnVkFBVWZQZWtuOHFnbkRYTUkzc0lIa1dlYkt5eXFDNDU3Sm9L?=
 =?gb2312?B?TW5ZbEk0Y2tyK2x6dUNMZDdlL2RZdzFFMzF3eWpzTmdYbGQzNnNxN2NxeEFI?=
 =?gb2312?B?V3M2WEluOHNETWswK1ZHS3RYem90b0RXYW5zSDFycEp5bXJVSnZ2cDRjZDBV?=
 =?gb2312?B?R1RhdzR4aEFWTHJOWjNxSWpYUTRUbTZza0phSXY2K1l5YnZZU2hKUUs5OE1i?=
 =?gb2312?B?TFNneU8wSE1aa1R6UjdxWFFIZzdiVC9YdGVXcjIzemwyZ3hrcXdXYWswanha?=
 =?gb2312?B?RTJ3Q2Y5WDZQTEdlTlBmdWVUalc5YmU2elN0S3R3a0orSkw4TGM1V2h2RDNn?=
 =?gb2312?B?N2ovOTBmbi8rOVUra0wvQ2g4OCtpYlBmSExDazVpYytYWlFRNFRWM3RrNWxL?=
 =?gb2312?B?cHU4M2pmcFY4WVBZUDRTTy9Mc25Ib2M2MDF4WjJ1ZVM4aFFVeEQ2WHRMa2My?=
 =?gb2312?B?MmhiY28ydGVpNDIxN25UblRDbmxHME91K09pcEsxcldIaC9DNGlaaWtuV1FU?=
 =?gb2312?B?UkpjZnFUK1FMVnEzUG9iU3lnTTRpQjhvREoyMG9WZEVtc0VXRld0bHVzY0JV?=
 =?gb2312?B?Mm1iQzR5eVdUdzFRL2dEVVBpSWZkNzRadzlhakZNY3c3eitjWlVDdjVSMFBK?=
 =?gb2312?B?c2VRdVl3ckJyZWhqSEdnbnJoQ1d3OU9JRVJjTHY2Z2FyenYwNFdTVmkzVmZO?=
 =?gb2312?B?UFNWY2ZERklyczZFa0lUbEE3WGdkVkxzTHZXSjBHRllMdnU3V280RFhFcFFG?=
 =?gb2312?B?UjZSNEE1eXJSVFZ0bkh2MGhyZVFmUTVyaVRDN1Via1JQMGJnazErUHo0YU9X?=
 =?gb2312?B?V1JmT2VQNENEQnRMUVlUbFJ5ellmN09wLzNoQnd6OGJoSkUzblFNUzBRZmpF?=
 =?gb2312?B?ZmluUUE0ZVNyUEtZaUpVU1IrZ1I3YmdmWFlBOHVDck9GSTNqYUdrb1Y1Tk1N?=
 =?gb2312?B?L0MzNzRGQ1ROckZVek9wclo0MTB1ZDhzbGZob0FmRVYyWTFyVlo1Mm5taUhP?=
 =?gb2312?B?TGFUd1VhcWduVGx2TEh5dnIwM0MyS2tsS1lscHNObUZJMFQvbjZXVkNlM0sv?=
 =?gb2312?B?VFFPRS9LQ2lkSHpObWhaQVRyVVhiY1JFdmlGUGdSeTk3aDVITERVR202aEw1?=
 =?gb2312?Q?N4XM=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1ce2283-616d-4010-8cf6-08de182efc5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2025 03:38:41.4656 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VcS9d6oURFHQV3qekkMjat5MI6ziKNsJsZsHcdMJ68PXY+kRNx8cwidfuP9ki1iryYXHUS305LgEM94MqI5DEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8219
X-Mailman-Approved-At: Fri, 31 Oct 2025 11:57:12 +0100
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

QWxpY2UgR3VvIL2rs7e72NPKvP6hsFtFWFRdIFJlOiC72Li0OiC72Li0OiBbUEFUQ0hdIGZpcm13
YXJlOiBzY21pOiBEcm9wIG1tdV9zZXRfcmVnaW9uX2RjYWNoZV9iZWhhdmlvdXIoKSBtaXN1c2Wh
saGj
