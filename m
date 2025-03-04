Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 284BAC282D3
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 07:11:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE4FA8128D;
	Tue,  4 Mar 2025 08:10:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Jmrrm9sJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08E7D8129F; Tue,  4 Mar 2025 08:10:58 +0100 (CET)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::618])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ECE8B80FB6
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 08:10:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LjU9e62aLc34D/Nzz0P/SgZdEdyL/eKMTUBOfhW8agS3GcKUzK6iF+bzY0ZYkqTLzzEKYROjCjutQS6waZSuq1mYAzKdTNFrKRpoEEjFeKo9bcV22SbjiamVZP8Teg5g25VSH1kbmQyKL/DOc8IjLRmYmvyluomLHqh/r9cge8SofHKKxSpQEwZnqo1HwNYaGWUaJ7joKONxn1dyJO9PojL/OnqVPOTxHRDFgpt6gIHJjGVpuJlMNIfHSGheeDmPVdK/03wna4n5Tx8RGTJc0yrlB0IKWZWHhxq6MYrjerafzBomb8vuEN/IAmT6fpEQmjmy9NqpioBkFj6lyZYz/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GfMSwQYd9COT6smNoBGb0wub3QK59DRzb9aiTtnoSFE=;
 b=Ls2P5zIt0W3Zq57MtzTr7BR0ndwXd4NNZhqONGpydZrdYch0w+WvQIz9udi7iuDxWdbkhJiMKVbWreJBv4fBVMlbVDOiZCslRUQk0dveLIvhtsPF3lt/D7SxZ6oRqIOidSVsjcVO7ahY64dwdWrH47Ymmyanl9F6F1XfurYUV1cT5PfubrQmEjmRb17cnMYLq3LFrE0VyX2mIyiQkk8FafvZXGI4sueWxkjA9NGuVGjI8XJJTf9IpEVCl/frciCPuNh+cRlxYZOmshNImNg6/kWBjBGe75w/nnGHynNxGyaGj5dopimzdyx2CKxpXaaeOe7VoY29y5jvkkMgwJr3lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GfMSwQYd9COT6smNoBGb0wub3QK59DRzb9aiTtnoSFE=;
 b=Jmrrm9sJft99J4Jn5GIELBTdxaCRqgckHsbkTE+rRuQmPJ3tZ1e8XfMe1BkaEGKShSPfBk9ORWM8HW2aJjR+ZQfvuN+uwXuKDt/L3Rllx8I/pOt2LqeIGHCNTPPMOlmKeHe2dpmcZ1Zj5odFYnFq1Uan3M3Tv6pf6MLKcy9N4JSMK0Rg0PoqOPPENQqh8BRkgAmq2fOkUaQpNHOpwh43K91czY3rQzWZ3HWNsfB4/BL1eVpocJc9hzF/33aeTTSyeEbH1CVJWK4DUa/eArkYp1uSUT5TqaFvR7sI4HuixdgVhm3jxSFpL1C5X3C1ZSjmhCG45WtqDPg+PQIrGRknBA==
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DU4PR04MB10912.eurprd04.prod.outlook.com (2603:10a6:10:58a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Tue, 4 Mar
 2025 07:10:52 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8466.024; Tue, 4 Mar 2025
 07:10:52 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: Marek Vasut <marex@denx.de>, "Alice Guo (OSS)" <alice.guo@oss.nxp.com>,
 Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, Fabio Estevam
 <festevam@gmail.com>, dl-uboot-imx <uboot-imx@nxp.com>, Lukasz Majewski
 <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Simon Glass
 <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo
 <alice.guo@nxp.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Viorel Suman
 <viorel.suman@nxp.com>, Ye Li <ye.li@nxp.com>
Subject: =?utf-8?B?5Zue5aSNOiDlm57lpI06IFtQQVRDSCB2NiAwMi8yMF0gZmlybXdhcmU6IHNj?=
 =?utf-8?Q?mi:_smt:_Interrupt_communication_enable?=
Thread-Topic: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjYgMDIvMjBdIGZpcm13YXJlOiBzY21pOiBzbXQ6?=
 =?utf-8?Q?_Interrupt_communication_enable?=
Thread-Index: AQHbic8q/+1lMxMIlEagzT2KZQiGLLNdFbQAgAOlHYCAATFlAIAAprBg
Date: Tue, 4 Mar 2025 07:10:52 +0000
Message-ID: <PAXPR04MB9644C745B5281AA3B94D83C1E2C82@PAXPR04MB9644.eurprd04.prod.outlook.com>
References: <20250228-imx95-v1-0-09594e93cc9b@oss.nxp.com>
 <20250228-imx95-v1-2-09594e93cc9b@oss.nxp.com>
 <9f02e9b3-a238-4a68-93f7-550bd63dceb2@denx.de>
 <PAXPR04MB964420C8F69517BDE8E406D6E2C92@PAXPR04MB9644.eurprd04.prod.outlook.com>
 <e7dd64a4-2c85-46d7-802f-f55fff445455@denx.de>
In-Reply-To: <e7dd64a4-2c85-46d7-802f-f55fff445455@denx.de>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9644:EE_|DU4PR04MB10912:EE_
x-ms-office365-filtering-correlation-id: dce6ffde-37d4-4306-adee-08dd5aebb30d
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|921020|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?bmIyRERpV1ZJYlU2WDNlelY0Ym9KZEtDaW1xcXdUS2Mvd09JSzdzQVhEMStT?=
 =?utf-8?B?OUN0NUcwOFBuN09IOHcwWjE3ZkFTL2c2UjlGbVlFOU1VL0NxUkc2Q01idzRo?=
 =?utf-8?B?b3ZNRFNRVE1GTmhQcS9Pd3pxZnFJNDVhMlEwb0cveHF5dTJWZlhnTU5QZmg1?=
 =?utf-8?B?L2d1TmVzVnVQd2grVklQZDBDQTJEQkE2Yzl1ODNtR2VNVHZHR0FDSFYzdUpX?=
 =?utf-8?B?Ylc5L3NSQWhlemhjUE0rdGFxMDhIa1o0NlZ0cWp0c1h5bS81T1hkV1FEQjFt?=
 =?utf-8?B?U0FuUkhoOUt4Vi8xUkI5ZnBSTUN5c2ZxSURLeWx3M2Q5ZUtnTDMzVnRkTVh4?=
 =?utf-8?B?TE93MWdlS0Z6dlB4SmJnZlVnb0FIWGdaSjdoQTM1SEZXVXBXelVSSDE4bFpI?=
 =?utf-8?B?cUFPSzJyUDc4cXEvbmVQNVIvQjI0Zy9xWDBJQy9HcHNuNGgySjh1bjdiaDNK?=
 =?utf-8?B?cFYwVlMyVVJ0UExZeXBJRTZDSkltdFdMWk4yaE1BcXZNVnJtUnMvc3ltK2pt?=
 =?utf-8?B?bFVZOFBMV1VEQUlZRWU0THRadFJzSE5GSnlKeWRvZzJpbE9nbzBNNWlkVC9y?=
 =?utf-8?B?ZnZKZmdaczBzQy9tZGhWbFY3dm1RMC9wRXJyeTUwL1duL0p3dzhUbGJST2J4?=
 =?utf-8?B?OU55SGo3NHI3SEwyL3Y3MU9UMWl1TDZ6bFViQzFWWUlTVFNUcTBTNUY1MlA1?=
 =?utf-8?B?a24rZlZROXNPdjF2K014Q3VJdjVKYmFuaXA3YTRxUHFUZGE0dEh6eTA5SXRx?=
 =?utf-8?B?ckhkZ3ZQWlVhcGxCVkZlQzQ3Y0thVnV2MEVRNHFoMVNESG9STVdiVXB5MVox?=
 =?utf-8?B?WCtsZUlJQzl2bnVEbUEySUNFeTRUNFNZaGJHZmRneTBhTUc0QlU4NzJHQ1ov?=
 =?utf-8?B?cnhlL0hYbkk3dWhjVjRTK3k0WTErVEJSUlJ3QzlrTnpYWGNCV1hyeVRXSWIx?=
 =?utf-8?B?VmY3RU55aXk0NUtlYlRsMVQvS0F4WmwwWjZyZ01QWEtMNkdodk5SaFpPVUFX?=
 =?utf-8?B?MUcyYllGT2ljd2E5Mmw0Ti9ZV2U5bUhId2VtVUZWcWZDdHluMjNiNThmNGZW?=
 =?utf-8?B?RURHQUdhaG5aQnJGaU9FSFZNY0ZSSngrYll6cjNxbU13ZHVQcVB4L3BkdGJs?=
 =?utf-8?B?dXJhQmp2dlBCR1dFTlczdTVtNGprZ1lISXp1TkF2RGI0Q0pjWHhwWXhQNGcr?=
 =?utf-8?B?bWYxN0J4cWYzb1BZaWkrYUhpUGprdXQ3aklGaXVwa01ZMHhLZmFhNWRha2wr?=
 =?utf-8?B?NXd4Q3l5RWZsVGl4cCtuTGtsanRVcGRGTjRJdzdEMkZHL09XUDNBL3oxVVdt?=
 =?utf-8?B?NlVYZlBXaW9jRGFGRmU3TXkvc3hWL2p2bzdPWGpXSGFTcWxzVkp5aXNMaTZa?=
 =?utf-8?B?c1dQRWhZZ0NIck56dW9TWmNkTXN3WlZ5Sk9KYkZjSlM4ZXE5d2pFaWZuVlIw?=
 =?utf-8?B?dFF5ajF1WTdtOWZhdkVSYzRQRGtVY2libDVYLzVPZEZpbUYwZWFEd3locDVy?=
 =?utf-8?B?bVk5a3ozdW9aeWFsNmp3ditSeFdEM3BFZmEzWG5BbEJYaFY1Q2FUWGVibFBG?=
 =?utf-8?B?SzZ3UWxpZVEzejkrT1FDVVAzZ0JpVDVPeVphdjg4bm94Nzh4Y0h2QjhHc0VJ?=
 =?utf-8?B?SzNyeXZGVDQ0SGZjSzA1R1RTU3BMM1NmdGczZ05rL0ZjQ0sySHhGR2U5aHBu?=
 =?utf-8?B?MHg1L01la0dLK1l2dFNHamcva1o0TTdURGl0N29mWGJqV1FXcG4zYXZCNncz?=
 =?utf-8?B?REs5WVUybmttc2w0blZSV1Z5SWhkMFBIU242Q250Y0ZTZHV6NlNCYjMrRDRD?=
 =?utf-8?B?SFI2bzlHZXBxSjhkK3VPd0RUK1ZqUXM1OVgveGQ1VElCa0lCTnQrazRUMlV4?=
 =?utf-8?B?Z2IrTlRjdmI3WUhtV1Q3cHZGRVBGQ2FSdFJoemwxYktYeWRmWnVEaDNXTGZL?=
 =?utf-8?B?ak1hL0RVQXlXNk4rcXNjbzVhT21FNHhlUW5pdjJ6MU1VRm8rYUJEb3dYSzlB?=
 =?utf-8?B?SGdXakJDQTN3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(366016)(376014)(921020)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dmdvQm1FdTFGK2xCVXQ2UzJiRFBRMkoxRDh5SGpxYUttd0JmTDBhbTdNOFBo?=
 =?utf-8?B?dGMxMkVHek1sQ1p5ZDc2WVg2WnhqL0FTc1VvRzhGbnRlNE54eGw3eXl6bkZj?=
 =?utf-8?B?NzJwYlhLM21aUjRRSTJ4bVBRMlRiM3ZxY1hYZGhDQ3B0U01hVDBncWloVVpr?=
 =?utf-8?B?Z3lvbDVsOU9ZRkl5RVJEY1psSDQwMDg4eTNCcHFhTnBiaXBiTlgzZ3Y5TFZN?=
 =?utf-8?B?NFpkSjE4b0NQS2VhZXhBNXdJUnNGQVo3MEhuem5MNmd3WWpHdHUwem9zam9r?=
 =?utf-8?B?dzhnSVJYYktDdHpRdUVwRlJaLzdGMmpCVkZzWmFmdlNQcjd4OEM1dVBXbkhx?=
 =?utf-8?B?R0pNa2dKWFNuSXh4dGF4QjhpVlZyVVR3MW5hUFgvbmRDbXoyVWtsV2I2WEtN?=
 =?utf-8?B?YVJrdFBMaklBNXdkbDNkMkdISld5U1hud0ZmTTlWaW5ySUpDQ3R1KzNrd3RK?=
 =?utf-8?B?bEduWUR4eXBsU0hxNG1xeERYd1VleGpIRFpXYUM5KzltbFVhc1lxTDUxU3Nv?=
 =?utf-8?B?eTFjcDFYQWJja3Y4eThtczBtWlh1OFRuSXpXbTdCd3ljSW5DV2Z4NzZMU0Zp?=
 =?utf-8?B?cm5ZMVlybjJib0pHaHhhQnhZWTNhOGQ4WEY1TVg1MkJsSDhybEhUeGViTk5p?=
 =?utf-8?B?YzVUcGJ5Ry9yVlFTMCtlWFBuMVpnUWtOcDVUMGhlTDRGWjR3OFNBMWxPU0Uw?=
 =?utf-8?B?TWpyNEREcnZ6U2FMOG9ScWNOY1J2cTlIcit4cUxSc3VJVUxkWnBZeE5lM0V2?=
 =?utf-8?B?a2RsRHFNTWNnclJwSjllU2prQ0tZUmZQTUd5VlNYRlZneEZMd21wc1BMY0o0?=
 =?utf-8?B?VWliSHhnQll4YmZPYlJVRWlEQjJOM3FiY3FaZEJlY2FtQWpZRXNYalh1MXBV?=
 =?utf-8?B?aEU5M0tLeFdRV0JuNGROTnhnTElQcDE0ZnFEZWNqSGZMRzhwckVSOGl0RWRV?=
 =?utf-8?B?Q2hyU2JnblVlZjdUR05hZHk3OXRLV0hOY0NSWWdnb2ZKYUJQTzRBWmtnL1hm?=
 =?utf-8?B?WDNHZkdSS2NBOHhkWWU3bDRDTk0rcExJamlUeUlBajNUNzkya0daU29WL2JB?=
 =?utf-8?B?OTdZQ0hVVWZtTFM5MHcxbGw2MDB1M3Jyc05PeTNoc014V2JVT2ppOXhJeTha?=
 =?utf-8?B?blBmRVBRa3FIWWorUElpM1ZJZTlYTkxrY1V6bzB0dCtEcEtLSlhrOEYyWHRl?=
 =?utf-8?B?TXdzUU12YmRheGxFSXBUdDJldEdVMXIwTE1HQytoMnB0TGpNbC9wVS83RGZq?=
 =?utf-8?B?bVVwUmordGV2VEJJMytLUzZPem9Ra1ZRbmVyMkJFQUs1Qk5uaEExcHpKMTBL?=
 =?utf-8?B?bFoyc3p0Y1hncVRFcVJ2aE11VStNVE9GcGZEaWlDZTkvbzV0U1lraVVFaU1y?=
 =?utf-8?B?Z0d5bTlYM0lTK0wxTWJjdmhkcUsrVTlZZTlWdk9GaEl2RVR1YXZTdzRnbGJR?=
 =?utf-8?B?VitRc2R3UFl3b0xXL0pzSldNbGxBekRCOEltcGlBU2FzKzZQQlNleFJBcUNn?=
 =?utf-8?B?ZUFmMktEVDMwZHlHS25hY1BmaWxlRjR6aWJiRDFWRm5FZkVaTWxzVTQvQi9q?=
 =?utf-8?B?R0h1S3JVMlh6K2tsU2xTTU1CVktoak8yQURueDVMOGI4cFBJQ2MzaC9UTHFN?=
 =?utf-8?B?VTBwNmwzZWpBeTFabm5qQ2JlT2gxcHZLa3ZFdU5oMDRwdmhoNGFDSmhYMWVD?=
 =?utf-8?B?WEREQ2tEMCtzemdpOS9WU0MwVDdhTTZpWS9ralZJcFdMNWpsOFF2aEc4Qi9P?=
 =?utf-8?B?MmV0NlFXNXVlNHlUK1g4T280czF2K0U4eWt2UTNKdWNEU2FCTjBLYnFlVlhN?=
 =?utf-8?B?eS9Yc2tOOGtXMWhmcEo1M3hkeDVqbjVkazRQSVYraE50cVVsWkhjSnh1dmZp?=
 =?utf-8?B?eXRFd1dxemxSRVFuV0M0TFJQTnRFK0NReE9TYldNNDBQaEg4MWtHUEQ3bUlV?=
 =?utf-8?B?R1FaOXdFaS83U2hES05nWFRtNXVYanQwVEhFRU5yR0VWdTR0aGtUSXE3UU1w?=
 =?utf-8?B?dU52WXVXb1U1RnRqV0s1Yk9ieGM5ZUMyZ3RkY3E4eVorZDBTUGhKdnBiR2Qz?=
 =?utf-8?B?b0YxR1l3Qko0ZXZEQVJFOHhNL0NZa1RPZXlVV0lZbi9BOXhNRXpZTTFNUHNB?=
 =?utf-8?Q?Q11tQgLbrGy74cjncKnawOC0A?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dce6ffde-37d4-4306-adee-08dd5aebb30d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2025 07:10:52.3965 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SBM2I/MJp7Te5dofDt64p1fk/leaRVymc+hi4Jtkpw1P8Z0QBC/KNXiTyAMe504FD38budzHGYDcf9ewGXK6OQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10912
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
QGRlbnguZGU+DQo+IOWPkemAgeaXtumXtDogMjAyNeW5tDPmnIg05pelIDU6MDUNCj4g5pS25Lu2
5Lq6OiBBbGljZSBHdW8gKE9TUykgPGFsaWNlLmd1b0Bvc3MubnhwLmNvbT47IFRvbSBSaW5pDQo+
IDx0cmluaUBrb25zdWxrby5jb20+OyBTdGVmYW5vIEJhYmljIDxzYmFiaWNAZGVueC5kZT47IEZh
YmlvIEVzdGV2YW0NCj4gPGZlc3RldmFtQGdtYWlsLmNvbT47IGRsLXVib290LWlteCA8dWJvb3Qt
aW14QG54cC5jb20+OyBMdWthc3oNCj4gTWFqZXdza2kgPGx1a21hQGRlbnguZGU+OyBTZWFuIEFu
ZGVyc29uIDxzZWFuZ2EyQGdtYWlsLmNvbT47IFNpbW9uDQo+IEdsYXNzIDxzamdAY2hyb21pdW0u
b3JnPjsgQWxwZXIgTmViaSBZYXNhayA8YWxwZXJuZWJpeWFzYWtAZ21haWwuY29tPjsNCj4gQWxp
Y2UgR3VvIDxhbGljZS5ndW9AbnhwLmNvbT4NCj4g5oqE6YCBOiB1LWJvb3RAbGlzdHMuZGVueC5k
ZTsgVmlvcmVsIFN1bWFuIDx2aW9yZWwuc3VtYW5AbnhwLmNvbT47IFllIExpDQo+IDx5ZS5saUBu
eHAuY29tPg0KPiDkuLvpopg6IFJlOiDlm57lpI06IFtQQVRDSCB2NiAwMi8yMF0gZmlybXdhcmU6
IHNjbWk6IHNtdDogSW50ZXJydXB0DQo+IGNvbW11bmljYXRpb24gZW5hYmxlDQo+IA0KPiBPbiAz
LzMvMjUgMzo1MSBBTSwgQWxpY2UgR3VvIChPU1MpIHdyb3RlOg0KPiANCj4gSGksDQo+IA0KPiA+
Pj4gQEAgLTQ4LDYgKzU4LDkgQEAgaW50IHNjbWlfZHRfZ2V0X3NtdF9idWZmZXIoc3RydWN0IHVk
ZXZpY2UgKmRldiwNCj4gPj4+IHN0cnVjdA0KPiA+PiBzY21pX3NtdCAqc210KQ0KPiA+Pj4gICAg
CWlmICghc210LT5idWYpDQo+ID4+PiAgICAJCXJldHVybiAtRU5PTUVNOw0KPiA+Pj4NCj4gPj4+
ICsJaWYgKElTX0VOQUJMRUQoQ09ORklHX1NDTUlfVFJBTlNQT1JUX1NNVF9JTlRSKSkNCj4gPj4+
ICsJCXNjbWlfc210X2VuYWJsZV9pbnRyKHNtdCwgdHJ1ZSk7DQo+ID4+IFdvdWxkIGl0IGJlIHBv
c3NpYmxlIHRvIGNoZWNrIERUIC9maXJtd2FyZS9zY21pIG5vZGUgZm9yIGNvbXBhdGlibGUNCj4g
Pj4gPT0gImFybSxzY21pIiBhbmQgcHJlc2VuY2Ugb2YgIm1ib3hlcyIgcHJvcGVydHkgLCBhbmQg
YmFzZWQgb24gdGhhdCAsDQo+ID4+IGRldGVybWluZSB0aGF0IHRoaXMgaXMgbWFpbGJveCBiYXNl
ZCBTQ01JID8NCj4gPg0KPiA+IEhpIE1hcmVrLA0KPiA+DQo+ID4gRG8geW91IG1lYW4gdGhhdCBy
ZXBsYWNlDQo+IElTX0VOQUJMRUQoQ09ORklHX1NDTUlfVFJBTlNQT1JUX1NNVF9JTlRSKSBieSBj
aGVja2luZyAiYXJtLHNjbWkiDQo+IGFuZCAibWJveGVzIiBpbiBkZXZpY2UgdHJlZT8NCj4gSWYg
dGhhdCBpcyBwb3NzaWJsZSwgeWVzLg0KDQpJIGRvIG5vdCB0aGluayB0aGF0IEJpdFswXSBvZiBj
aGFubmVsIGZsYWdzIHNob3VsZCBiZSBzZXQgdG8gMSBvbmx5IHdoZW4gdGhlIFNDTUkgbm9kZSBo
YXMgdGhlIGNvbXBhdGlibGUgImFybSxzY21pIiBhbmQgdGhlIHByb3BlcnR5ICJtYm94ZXMiLiBX
aGV0aGVyIHRvIHNldCBpdCBkZXBlbmRzIG9uIHRoZSBpbXBsZW1lbnRhdGlvbiBvZiB0aGUgU0NN
SSBjYWxsZWUtc2lkZS4NCg==
