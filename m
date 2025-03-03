Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50152C282C5
	for <u-boot@archiver.kernel.org>; Mon,  3 Mar 2025 06:28:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C92E807B1;
	Mon,  3 Mar 2025 07:28:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="XWeH9tBp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D33C80F70; Mon,  3 Mar 2025 07:28:18 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::628])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EACC80786
 for <u-boot@lists.denx.de>; Mon,  3 Mar 2025 07:28:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jm+gdMDhj6UVk+Hwv+Of5SAmoj1h5LGMkApQMIvhjjfRqZdU6ZYcfsrZMRdksHn0/R2rZtSdwLdV25QDR4qpG/m9AepaqvC935nWqrcxgtWRmzABkeb8xxLH8WzgB7hNb6pJXOLvQA9RPC/lowDde+0nuQdb2i8Nr+MQ+ZVn0bLsarzOnXP2Reb5vy9DS22rVHH3h2DJXU/dsKOidBd6MjlAtvKxb3mIrDeDOteHQ2wMEv9kgGFsO9VJQp4ye3BuTH4eKh/KXTMErmnyCXJPN52Mgm7epfe/Omx/FeLz7csMFIkz2wG5XouhS0UluZS0g4QhwMU9FdGvvvyluRjeqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ALq3Guoq/zCRigPmrY4y+HnWPeMuW2IrwxDmOaLBA9M=;
 b=Mk4C8CPQ5HAWj2HQRhydH61Of7h21NjRKsyy7mVXu+y1v0Uppta6RRXe8NkNqNV6JwtsoxP5AUZZd9yH/j7Qb+6+hAzATOJ7IT4EybyWvfjKUIZ4FQTDG9Y6CLiwMTyR4djGOFFkpOhY9Ms3CwLZw5xuAVVbJ1DiHRnauKk20yljElWI/VuHpQE4q4Jpr4ddXwp5H4IDMGxFakBm1uZsovLEVRD7C8eJ9iDvJMgHUPe40pFRrXxz0TU+bOszyGI2vvmjp+lV1VF/kIxzTMYvGs+67X6T8bvn0w8tgtBpSiVG3duzQncAREut6wny3Y0s0OXuWy6bh/4Brw4JfOCGlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ALq3Guoq/zCRigPmrY4y+HnWPeMuW2IrwxDmOaLBA9M=;
 b=XWeH9tBpRLNXU6MwFLZYM+g09Dt0l6tgmd428yP+cUlENm1uqwUBNVBj5FOW4jDCgEXxezNYvuPyPYHRb9jLEtsrArJalaftEZUxp0j/y8HQKbjjgNNh4FLKXUGsVXaTim25jp6ZrZSod60yFrGEWomMRuOBOukxKtVzcZnM9/b3Wt/uw9doZpkwT8PRpscsoAlFGJRTDOmlyPB8vvIbwRwAFOlvlS7h9yLY9Y/uqEZvCyu7HTzVm2AxZzQMpCYcP5y9V8OH3Nc3DULyh9bGhVBNzSA9WyvblJDawyyCXqffMuNKkQqlKCCl8+tK9OPLYKFc8IdPoi58PuBCg5oDuw==
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AS8PR04MB7702.eurprd04.prod.outlook.com (2603:10a6:20b:23f::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Mon, 3 Mar
 2025 06:28:13 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8466.024; Mon, 3 Mar 2025
 06:28:12 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: Marek Vasut <marex@denx.de>, "Alice Guo (OSS)" <alice.guo@oss.nxp.com>,
 Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, Fabio Estevam
 <festevam@gmail.com>, dl-uboot-imx <uboot-imx@nxp.com>, Lukasz Majewski
 <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Simon Glass
 <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo
 <alice.guo@nxp.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Ranjani Vaidyanathan
 <ranjani.vaidyanathan@nxp.com>, Peng Fan <peng.fan@nxp.com>, Ye Li
 <ye.li@nxp.com>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjYgMDMvMjBdIHBpbmN0cmw6IG54cDogYWRkIGEg?=
 =?utf-8?B?cGluIGNvbnRyb2xsZXIgZHJpdmVyIGJhc2VkIG9uIFNDTUkgcGluIGNvbnRy?=
 =?utf-8?Q?ol_protocol?=
Thread-Topic: [PATCH v6 03/20] pinctrl: nxp: add a pin controller driver based
 on SCMI pin control protocol
Thread-Index: AQHbic8tMb4gJEUMhkSLsDwdXXo6UbNdFvKAgAPbw2A=
Date: Mon, 3 Mar 2025 06:28:12 +0000
Message-ID: <PAXPR04MB9644735B4D9568DEB0218133E2C92@PAXPR04MB9644.eurprd04.prod.outlook.com>
References: <20250228-imx95-v1-0-09594e93cc9b@oss.nxp.com>
 <20250228-imx95-v1-3-09594e93cc9b@oss.nxp.com>
 <5d0f1b3c-02ec-416d-b566-2cc8f44576df@denx.de>
In-Reply-To: <5d0f1b3c-02ec-416d-b566-2cc8f44576df@denx.de>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9644:EE_|AS8PR04MB7702:EE_
x-ms-office365-filtering-correlation-id: 144c23e6-f435-4d2c-08eb-08dd5a1c92f8
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700018|921020; 
x-microsoft-antispam-message-info: =?utf-8?B?ak03aG82ZmtzWFE2am9HVXdtR1QyU1JTM0J3Y0ZBVUJ0RkVRMTlNN2o3eGEy?=
 =?utf-8?B?d0tNSHk5MXZ5WXozcWcrNGFwRzRRK1FvTjJ6eXZHMmVtaU52TGU4dG96MjRr?=
 =?utf-8?B?LzNWWFFWRkdVYmE1b0dqbmVPdTlzajNZY01ub2pSeEZrNyt5NHVCSVgra3Zh?=
 =?utf-8?B?WU5xR2txanI2TUFWTm9JalNnU0FOOCtNR3B1S3FicFkzK1YwN3REWjJZSGt4?=
 =?utf-8?B?bGNrQkJWMEFDb2lpdHYrSDNFMGJSZTJrYUNWWUdwcFM4R3VFWW9DL0JJNUNr?=
 =?utf-8?B?enBGMytoMXpmZmVXcGZvcWlCb3hTcXRSZzRUR0JVMUdMZjc0dCsvQW9Zd1JR?=
 =?utf-8?B?dml1QU5xWTgvb2ozak45VTZYY3dkc1R5VkVUKzRrZERadFA0RVFCWGxKY0tt?=
 =?utf-8?B?T2svTlVBMGJNc21lVXpaRjk1bENBeWV4aHl2a2x3dkdmMEEzMHNONE9oc09V?=
 =?utf-8?B?ZklpVm1EUHNkNy9NcE02SHo2Yy9SR1VYMFRJNTFCYWUzaTAvVmt5Qy9YakFq?=
 =?utf-8?B?eGlqUVdpSTZTU2t2VEtqZnFnZVBVT1R5TUFuemMvdk5PNnlqZEtqRkdCdDNB?=
 =?utf-8?B?YlZlMmo4VTRsZHZMTkJWbHdBWnR6NDB5d0dqVDZMcTRsV1ZXTUxPTzUvY3cz?=
 =?utf-8?B?Ly83RXM3R21VUVA3c1VCOERYSjJGd1VRZm5uYnhzQTdxZUpnd1NkaWlLSC9E?=
 =?utf-8?B?KzlNZ1F1RDNjclFDa1hndTlzWW0zbDV2dm5yM2poOHl5cXhQSUxoOEwyZVhE?=
 =?utf-8?B?UnRUeUNkZXI4dTdoZTJmaWkwa3lFZHl6bkNucFNrSDNrQlhTaDZqNUZRdlJ3?=
 =?utf-8?B?Wk9XWEF3N1lNN1puQ204b2kybnd5TzhJQVBpbGlCQVlQWUoxODZ6MUVUNkEx?=
 =?utf-8?B?T1pzdjNIcnl3T2xzVkxEYTUxNWovU0pOK2Y0ZXNwMlcyUTl4ekRVa08vUWJu?=
 =?utf-8?B?bk95VW02bFNhSklKaXc0WTBVaC93aExQZU92anIrWDgvUW5JTkIrayt0eTJt?=
 =?utf-8?B?ZlhVR0s3SHUveFFsRGd0akpTRlNPVUV4SURZTi9yYU1yN0dKcFAvMWhwQmN3?=
 =?utf-8?B?aTRJS0ljWnEyYzZJdEt3QnN5bkNMZ0MrL2NQcmtpQ3poVEp4MGZ3Y0ZEUFQv?=
 =?utf-8?B?Y0pMaUNWaHFqOTQwcGozZmpYd3FXbXhzYkIxSjFtalJiYUYycjFUWFI5eTdO?=
 =?utf-8?B?cWUvb2tFejFibGdaQlpPRnhzM3pWWFphN2Vrekt0M2grbmRLMzR0VE9MeVoy?=
 =?utf-8?B?aGZ0ZVVuT09sa3lwSHRPVk1JTG5SaDY3MEZzdlJqb2hzd1FaYmhXMjJLN0ox?=
 =?utf-8?B?dzlaajdFWm5JZjlLSEc0Yk4wVzRkdFZvYWxFZlRYQ3RoYjRreXRmT2VWUTVE?=
 =?utf-8?B?ZnZHeUp3VUVuWkhGMmJYZ1JzL2FTTENrWEh3czRwTUk4dFE0S1ZZdGIzeE9S?=
 =?utf-8?B?TC9veWg5Z3l2ckoxRWMzc0ZkL0VzN1pCZlBMZXFvY1EvNWlIMUZTOGJJelFK?=
 =?utf-8?B?MjlJU04ybmhncTVrMzJQMWVZdEZuZ0pFckg2R2k2QWxwMTlzR0c3b0RzeEVC?=
 =?utf-8?B?cUVudXNHUklzaUgxMDlRSkM1RzNMenhCbXlPSFhOampjOGUwZmdRWGZWZ0Vi?=
 =?utf-8?B?YVBMeUpkNE9BMnArRkYrczAzOVNlTm1XQWhZUGdaQnZYYWJaS3NKRmd2U1Jl?=
 =?utf-8?B?RXdtekQ0UHk3ZE9HazRSVnRpaTJEeEE2Kzc3ZXBQS0d0dlB5TXFRVGtWYjNz?=
 =?utf-8?B?ZVR2U1RoMGFFM05KTzQvajVrTDdVUnd6Y3F6bTBRVkRoRUdtczM1YXpFWVBN?=
 =?utf-8?B?dTU3d3kzMldRQ1JxU3VkQTc4M1J1ZkJxbWtDdWJCTUkvdWgxSjVCRm1EZ2lB?=
 =?utf-8?B?RWgzb2VRUWwzMjhSRXMxTEZvbVRsNUgzMUNxMTZjNHZaSnNsdVBXYjg5aDlt?=
 =?utf-8?B?Vm94aStLVXpXSW85ZTlzWStma3p1bU1xMUIzWklOd0RqVllkTG83d3FXTFdT?=
 =?utf-8?B?bld3bXluUWZRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(921020);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MEIzTWlvc01vNjcvY2tYcXJTUTFEdVI2UnNDRnl2VXhyRjI2TEpwMEs3SWpt?=
 =?utf-8?B?SVpBM1p3RXUvQVRudUVpTHUvZzZzVGoxdG1EMFBlUGN2WnRVVFBCdTFkSUhM?=
 =?utf-8?B?SjFKR3VjRmJmR3htaFdtT2pGaVBGc1A3OGNrSitGYU16ekptaHlyNnIwTUV4?=
 =?utf-8?B?c29lS0UydWxLczh6TmVpM3dYdWt3RDBSUFZWTkZTdWtYVjF1MjBISUNrNDht?=
 =?utf-8?B?RFZlbFNKdk95ZHRmYkxCdDNKSmVxQlRiRERRUk5IeGhCVnordUtOSnFJN1ZC?=
 =?utf-8?B?Y1RXd1VIOTVEejQ4RGd1aWZKd0tvYnVQQlFob3dBWk01d2xFMXBuMmIzUWcw?=
 =?utf-8?B?MFFXZWhZanRtM2FQZ2ZNTFFvaC9BT2F4UlpSQnFhN054bEZHZWJJUUNMNWY5?=
 =?utf-8?B?VVkrbWN0di9tWS9sUkY5QzM2UUVROWpPVUFUNkM0aWN4MVR4NnFOOHJXL0pN?=
 =?utf-8?B?MlFtTDRYNWEzRjI2TlRLT1N1MXJlZFJReU9SZVZ4QXp4U3I1RHd0cU9pZ1Js?=
 =?utf-8?B?U1pOL2JMTTlNamRYclJoY3NCNVRtbzErcjZVU1VKR2ZPb0o0QkduUTBGaTUw?=
 =?utf-8?B?ZWk4UVJ3UHlhYjlEZmJKbWdLNG1KVXFXaGJrRHlTak9Eajg1akN5N3BIdFdC?=
 =?utf-8?B?aXhxYzFVQTdaanRiNFU4aXVISmN6dStENDl4TE0xM0NoVUNRTjFud2xrVzNG?=
 =?utf-8?B?Q0dGTU9ra2ZaYmpZZExybFg2WHFMMW84bFNVSk9CNmMyUm5iamgwUjhvN213?=
 =?utf-8?B?ck9VM3JPaXlFWkdQdy9TNVI3Ukg0NVJwbzBjaHoycDdSNXlwdzk1OU5oM05t?=
 =?utf-8?B?S0RDTVZvWExJNDFlRnF6dEhKTmd3SURHcUNnY21zR0F0cEdxKzh5WjVaK3JR?=
 =?utf-8?B?TjlYcHBscWlOYUw1bXdVRmwrS1FHV1FvekdmTHMxT0NiSWgyWVI3NGJROTB3?=
 =?utf-8?B?TC9TTlZtaTBTRTM1WXQyYVJpRmU4VWlDNDJYdFlGMDFPbFFoMnBpazdJL1pt?=
 =?utf-8?B?M0QzUWtDOWViaXVwNzl6dm9icEJKdlZxTFdJWms3SlhncWxjMGxQWE5PaUlD?=
 =?utf-8?B?VkNLUlF4Q2lQKzhha2YwL2k2SHgxNE1IbDFVT2JMOVF2Qm5sTnZIYW5KdC9a?=
 =?utf-8?B?dFNqTzB5RnFwdWNQbjBwbjg1RUJVUzAvYjlEdTZ1OUF0R3ZoajlrYlk5TWxU?=
 =?utf-8?B?R0xrWC9mVUo3SVNDMHdETVd4UU9KbkJVQ0JpOTdzQ2NiRmtnTGNtVTRScDhw?=
 =?utf-8?B?MjBOQnpFdFhGNFlHb002TUxYbVFqWjFqelYwOWZXRmRBZ2N2Vjl3TmtGTWhV?=
 =?utf-8?B?WEF5ejJYZG12OTcvakVoM0FTNEcwMlNOQ3RqdmpHMElzUlBLc3pqZFhyUENj?=
 =?utf-8?B?L3pwdTZyYk9lS3lJRlphaTc5U3dNaEcrOEwxVGcyYVV4eVBlVTJ1VWlmWEIx?=
 =?utf-8?B?OERmNkpER09IZWhFZDBYbVlPK1dDZ0JVVG1wVnRHSldiUjlPeVlPNlRncFVZ?=
 =?utf-8?B?Q2c3b1Z0V0xuTitvZEdqbFdxSkYydGdPQkRQcGZhQUhzTHVkQWJYeXloRUFH?=
 =?utf-8?B?cEpuc253ZmcrWDhSbWxkRFYydzVFNmlUOVlBUzNpWFZDRDhFTlNMQzhmME05?=
 =?utf-8?B?dE1NRUV3S2p6bC9oK3JiNmd4MEVFa0lrdnNSN3hLeVplOVJGUXBBaDhYZHkv?=
 =?utf-8?B?VThwKzd6Zk9sZXBJMGhKS25HTUkyYWw4UVpqd2FHQm4vRFBkWStpZkFNL2FD?=
 =?utf-8?B?cUd4bHpFUG04SS9nVFhubHByUFlkL3lTRkt5UmtTWndscEppQTlzSzc4NGJ4?=
 =?utf-8?B?cmViWUQ5U2lsZnhpbUZVRjFvZUdhS1N1YktVZkhwMVg0cjFHS0VHbkdUeDlz?=
 =?utf-8?B?dWpMSDQwUWpEUU9qdEJwQ3FWSEt3dG5VM0RJQ29VWDgxM2R3eWlvUjk3Ynhr?=
 =?utf-8?B?N3kvcVVrT2ZuRnk4VzR4V3B0T0phODQ5VUtnRUZGSEZPYXZ0U3dVNTNVcVR0?=
 =?utf-8?B?NGhRbFRCQ2s4eGxjV1A0cm5pd0RtTFo3WTg4SExPTHpibFIySTJrc20rRnpL?=
 =?utf-8?B?Q3dyWGZjUjJXdXIxZC9QRVl2Y3RJcGFIb3JMTUNIUXAzSFpYWUdLd0NZOTJD?=
 =?utf-8?Q?CshcJ26/Xj4bn/CdUmG1SIvs1?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 144c23e6-f435-4d2c-08eb-08dd5a1c92f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2025 06:28:12.7405 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U7pcHDyf4XLWfrXipELJbfZUzCXOFgzpd978zKXvMph0K+4htFd2askYMtSyKQfcmjY296PXDiT5u4ONIvW7Wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7702
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

PiAtLS0tLemCruS7tuWOn+S7ti0tLS0tDQo+IOWPkeS7tuS6ujogTWFyZWsgVmFzdXQgPG1hcmV4
QGRlbnguZGU+DQo+IOWPkemAgeaXtumXtDogMjAyNeW5tDPmnIgx5pelIDM6MTcNCj4g5pS25Lu2
5Lq6OiBBbGljZSBHdW8gKE9TUykgPGFsaWNlLmd1b0Bvc3MubnhwLmNvbT47IFRvbSBSaW5pDQo+
IDx0cmluaUBrb25zdWxrby5jb20+OyBTdGVmYW5vIEJhYmljIDxzYmFiaWNAZGVueC5kZT47IEZh
YmlvIEVzdGV2YW0NCj4gPGZlc3RldmFtQGdtYWlsLmNvbT47IGRsLXVib290LWlteCA8dWJvb3Qt
aW14QG54cC5jb20+OyBMdWthc3oNCj4gTWFqZXdza2kgPGx1a21hQGRlbnguZGU+OyBTZWFuIEFu
ZGVyc29uIDxzZWFuZ2EyQGdtYWlsLmNvbT47IFNpbW9uDQo+IEdsYXNzIDxzamdAY2hyb21pdW0u
b3JnPjsgQWxwZXIgTmViaSBZYXNhayA8YWxwZXJuZWJpeWFzYWtAZ21haWwuY29tPjsNCj4gQWxp
Y2UgR3VvIDxhbGljZS5ndW9AbnhwLmNvbT4NCj4g5oqE6YCBOiB1LWJvb3RAbGlzdHMuZGVueC5k
ZTsgUmFuamFuaSBWYWlkeWFuYXRoYW4NCj4gPHJhbmphbmkudmFpZHlhbmF0aGFuQG54cC5jb20+
OyBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT47IFllIExpDQo+IDx5ZS5saUBueHAuY29tPg0K
PiDkuLvpopg6IFJlOiBbUEFUQ0ggdjYgMDMvMjBdIHBpbmN0cmw6IG54cDogYWRkIGEgcGluIGNv
bnRyb2xsZXIgZHJpdmVyIGJhc2VkIG9uDQo+IFNDTUkgcGluIGNvbnRyb2wgcHJvdG9jb2wNCj4g
DQo+IE9uIDIvMjgvMjUgMTE6NTMgQU0sIEFsaWNlIEd1byAoT1NTKSB3cm90ZToNCj4gPiBGcm9t
OiBBbGljZSBHdW8gPGFsaWNlLmd1b0BueHAuY29tPg0KPiA+DQo+ID4gVGhpcyBwYXRjaCBwcm92
aWRlcyBhIHBpbmN0cmwgZHJpdmVyIGJhc2VkIG9uIFNDTUkgcGluIGNvbnRyb2wgcHJvdG9jb2wu
DQo+ID4gQ3VycmVudGx5LCBvbmx5IHRoZSBQSU5DVFJMX0NPTkZJR19TRVQgY29tbWFuZCBpcyBp
bXBsZW1lbnRlZC4NCj4gDQo+IFRoaXMgY2FuIGFsc28gYmUgYSBzZXBhcmF0ZSBwYXRjaCBhbmQg
Z28gaW4gc2VwYXJhdGVseSAsIHJpZ2h0ID8NCj4gDQo+IElmIHNvLCBzZW5kIHRoaXMgYXMgc2Vw
YXJhdGUgcGF0Y2guDQo+IA0KPiBbLi4uXQ0KPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9w
aW5jdHJsL254cC9waW5jdHJsLXNjbWkuYw0KPiA+IGIvZHJpdmVycy9waW5jdHJsL254cC9waW5j
dHJsLXNjbWkuYw0KPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4gaW5kZXggMDAwMDAwMDAw
MC4uNGE3OTFiN2U5NQ0KPiA+IC0tLSAvZGV2L251bGwNCj4gPiArKysgYi9kcml2ZXJzL3BpbmN0
cmwvbnhwL3BpbmN0cmwtc2NtaS5jDQo+ID4gQEAgLTAsMCArMSwxNDMgQEANCj4gPiArLy8gU1BE
WC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjArDQo+ID4gKy8qDQo+ID4gKyAqIENvcHlyaWdo
dCAyMDI1IE5YUA0KPiA+ICsgKi8NCj4gPiArDQo+ID4gKyNpbmNsdWRlIDxhc20vaW8uaD4NCj4g
PiArI2luY2x1ZGUgPGFzbS9tYWNoLWlteC9zeXNfcHJvdG8uaD4NCj4gPiArI2luY2x1ZGUgPGRt
Lmg+DQo+ID4gKyNpbmNsdWRlIDxkbS9kZXZpY2VfY29tcGF0Lmg+DQo+ID4gKyNpbmNsdWRlIDxk
bS9waW5jdHJsLmg+DQo+ID4gKyNpbmNsdWRlIDxzY21pX2FnZW50Lmg+DQo+ID4gKyNpbmNsdWRl
IDxzY21pX3Byb3RvY29scy5oPg0KPiA+ICsNCj4gPiArI2luY2x1ZGUgInBpbmN0cmwtaW14Lmgi
DQo+ID4gKw0KPiA+ICsjZGVmaW5lIERBSVNZX09GRlNFVF9JTVg5MwkweDM2MA0KPiA+ICsjZGVm
aW5lIERBSVNZX09GRlNFVF9JTVg5NQkweDQwOA0KPiA+ICsNCj4gPiArLyogU0NNSSBwaW4gY29u
dHJvbCB0eXBlcyAqLw0KPiA+ICsjZGVmaW5lIFBJTkNUUkxfVFlQRV9NVVggICAgICAgIDE5Mg0K
PiA+ICsjZGVmaW5lIFBJTkNUUkxfVFlQRV9DT05GSUcgICAgIDE5Mw0KPiA+ICsjZGVmaW5lIFBJ
TkNUUkxfVFlQRV9EQUlTWV9JRCAgIDE5NA0KPiA+ICsjZGVmaW5lIFBJTkNUUkxfVFlQRV9EQUlT
WV9DRkcgIDE5NQ0KPiA+ICsjZGVmaW5lIFBJTkNUUkxfTlVNX0NGR1NfU0hJRlQgIDINCj4gPiAr
DQo+ID4gK3N0cnVjdCBpbXhfc2NtaV9waW5jdHJsX3ByaXYgew0KPiA+ICsJdTE2CQlkYWlzeV9v
ZmZzZXQ7DQo+ID4gK307DQo+ID4gKw0KPiA+ICtzdGF0aWMgaW50IGlteF9waW5jb25mX3NjbWlf
c2V0KHN0cnVjdCB1ZGV2aWNlICpkZXYsIHUzMiBtdXhfb2ZzLCB1MzIgbXV4LA0KPiB1MzIgY29u
ZmlnX3ZhbCwNCj4gPiArCQkJCXUzMiBpbnB1dF9vZnMsIHUzMiBpbnB1dF92YWwpDQo+ID4gK3sN
Cj4gPiArCXN0cnVjdCBpbXhfc2NtaV9waW5jdHJsX3ByaXYgKnByaXYgPSBkZXZfZ2V0X3ByaXYo
ZGV2KTsNCj4gPiArCWludCByZXQsIG51bV9jZmdzID0gMDsNCj4gPiArCXN0cnVjdCBzY21pX21z
ZyBtc2c7DQo+ID4gKw0KPiA+ICsJLyogQ2FsbCBTQ01JIEFQSSB0byBzZXQgdGhlIHBpbiBtdXgg
YW5kIGNvbmZpZ3VyYXRpb24uICovDQo+ID4gKwlzdHJ1Y3Qgc2NtaV9waW5jdHJsX2NvbmZpZ19z
ZXRfb3V0IG91dDsNCj4gPiArCXN0cnVjdCBzY21pX3BpbmN0cmxfY29uZmlnX3NldF9pbiBpbiA9
IHsNCj4gPiArCQkuaWRlbnRpZmllciA9IG11eF9vZnMgLyA0LA0KPiA+ICsJCS5mdW5jdGlvbl9p
ZCA9IDB4RkZGRkZGRkYsDQo+ID4gKwkJLmF0dHJpYnV0ZXMgPSAwLA0KPiA+ICsJfTsNCj4gPiAr
DQo+ID4gKwlpZiAobXV4X29mcyAhPSAwKSB7DQo+IA0KPiBpZiAobXV4KSB7IC4uLiB9IGlzIGVu
b3VnaCwgdGhlICE9MCBpcyB1bm5lY2Vzc2FyeS4NCj4gDQo+ID4gKwkJaW4uY29uZmlnc1tudW1f
Y2Znc10udHlwZSA9IFBJTkNUUkxfVFlQRV9NVVg7DQo+ID4gKwkJaW4uY29uZmlnc1tudW1fY2Zn
c10udmFsID0gbXV4Ow0KPiA+ICsJCW51bV9jZmdzKys7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJ
aWYgKGNvbmZpZ192YWwgIT0gMCkgew0KPiANCj4gRFRUTw0KPiANCj4gPiArCQlpbi5jb25maWdz
W251bV9jZmdzXS50eXBlID0gUElOQ1RSTF9UWVBFX0NPTkZJRzsNCj4gPiArCQlpbi5jb25maWdz
W251bV9jZmdzXS52YWwgPSBjb25maWdfdmFsOw0KPiA+ICsJCW51bV9jZmdzKys7DQo+ID4gKwl9
DQo+ID4gKw0KPiA+ICsJaWYgKGlucHV0X29mcyAhPSAwKSB7DQo+IA0KPiBEVFRPDQo+IA0KPiA+
ICsJCWluLmNvbmZpZ3NbbnVtX2NmZ3NdLnR5cGUgPSBQSU5DVFJMX1RZUEVfREFJU1lfSUQ7DQo+
ID4gKwkJaW4uY29uZmlnc1tudW1fY2Znc10udmFsID0gKGlucHV0X29mcyAtICBwcml2LT5kYWlz
eV9vZmZzZXQpIC8gNDsNCj4gPiArCQludW1fY2ZncysrOw0KPiA+ICsJCWluLmNvbmZpZ3NbbnVt
X2NmZ3NdLnR5cGUgPSBQSU5DVFJMX1RZUEVfREFJU1lfQ0ZHOw0KPiA+ICsJCWluLmNvbmZpZ3Nb
bnVtX2NmZ3NdLnZhbCA9IGlucHV0X3ZhbDsNCj4gPiArCQludW1fY2ZncysrOw0KPiA+ICsJfQ0K
PiA+ICsNCj4gPiArCS8qIFVwZGF0ZSB0aGUgbnVtYmVyIG9mIGNvbmZpZ3Mgc2VudCBpbiB0aGlz
IGNhbGwuICovDQo+ID4gKwlpbi5hdHRyaWJ1dGVzID0gbnVtX2NmZ3MgPDwgUElOQ1RSTF9OVU1f
Q0ZHU19TSElGVDsNCj4gPiArDQo+ID4gKwltc2cgPSBTQ01JX01TR19JTihTQ01JX1BST1RPQ09M
X0lEX1BJTkNUUkwsDQo+ID4gKwkJCSAgU0NNSV9NU0dfUElOQ1RSTF9DT05GSUdfU0VULCBpbiwg
b3V0KTsNCj4gPiArDQo+ID4gKwlyZXQgPSBkZXZtX3NjbWlfcHJvY2Vzc19tc2coZGV2LCAmbXNn
KTsNCj4gPiArCWlmIChyZXQgfHwgb3V0LnN0YXR1cyAhPSAwKSB7DQo+ID4gKwkJZGV2X2Vycihk
ZXYsICJGYWlsZWQgdG8gc2V0IFBBRCA9ICVkLCBkYWlzeSA9ICVkLCBzY21pX2VyciA9ICVkLCBy
ZXQNCj4gPSAlZFxuIiwNCj4gPiArCQkJbXV4X29mcyAvIDQsIGlucHV0X29mcyAvIDQsIG91dC5z
dGF0dXMsIHJldCk7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJcmV0dXJuIHJldDsNCj4gDQo+IFsu
Li5dDQo+IA0KPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL3NjbWlfcHJvdG9jb2xzLmggYi9pbmNs
dWRlL3NjbWlfcHJvdG9jb2xzLmggaW5kZXgNCj4gPiA3YWJiMmE2ZjM2Li4yNzllYmJhZDQ0IDEw
MDY0NA0KPiA+IC0tLSBhL2luY2x1ZGUvc2NtaV9wcm90b2NvbHMuaA0KPiA+ICsrKyBiL2luY2x1
ZGUvc2NtaV9wcm90b2NvbHMuaA0KPiA+IEBAIC0yNCw2ICsyNCw3IEBAIGVudW0gc2NtaV9zdGRf
cHJvdG9jb2wgew0KPiA+ICAgCVNDTUlfUFJPVE9DT0xfSURfU0VOU09SID0gMHgxNSwNCj4gPiAg
IAlTQ01JX1BST1RPQ09MX0lEX1JFU0VUX0RPTUFJTiA9IDB4MTYsDQo+ID4gICAJU0NNSV9QUk9U
T0NPTF9JRF9WT0xUQUdFX0RPTUFJTiA9IDB4MTcsDQo+ID4gKwlTQ01JX1BST1RPQ09MX0lEX1BJ
TkNUUkwgPSAweDE5LA0KPiBUaGlzIGlzIHRoZSBjdXN0b20gaU1YIHNwZWNpZmljIHBpbmN0cmwg
cHJvdG9jb2wsIGlzbid0IGl0ID8NCg0KSGkgTWFyZWssDQoNClByb3RvY29sIGlkIDB4MTkgaXMg
bm90IGkuTVggc3BlY2lmaWMsIGFuZCBpdCBpcyBkZWZpbmVkIGluIEFybcKuIFN5c3RlbSBDb250
cm9sIGFuZCBNYW5hZ2VtZW50IEludGVyZmFjZSBQbGF0Zm9ybSBEZXNpZ24gRG9jdW1lbnQgTm9u
LUNvbmZpZGVudGlhbCBWZXJzaW9uIDMuMi4NCg0KRm9yIHBpbiBjb250cm9sIHByb3RvY29sLCBk
cml2ZXJzL3BpbmN0cmwvbnhwL3BpbmN0cmwtc2NtaS5jIGFyZSB1c2VkIG9uIGkuTVg5NS4NCg0K
QmVzdCBSZWdhcmRzLA0KQWxpY2UgR3VvDQoNCj4gQ2FuIHlvdSByZW5hbWUgaXQgdG8gc29tZSBT
Q01JX1BST1RPQ09MX0lEX05YUF9JTVg5X1BJTkNUUkwgdG8gbWFrZQ0KPiBpdCBjbGVhciB0aGlz
IGlzIGN1c3RvbSBwcm90b2NvbCA/DQo=
