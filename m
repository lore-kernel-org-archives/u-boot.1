Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62DE4C83F1A
	for <u-boot@archiver.kernel.org>; Mon, 21 Jul 2025 08:23:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD27380194;
	Mon, 21 Jul 2025 10:23:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="WQp0+vUm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECA4E82BA7; Mon, 21 Jul 2025 10:23:46 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94C168003E
 for <u-boot@lists.denx.de>; Mon, 21 Jul 2025 10:23:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g8khvq5IF7OBBFqVNTy2Hs3V2UxI9WprtcI4rs/z9USv+gA33HcQWdv0Mmpk1frVoFtxbqKOY0ULjcBIeu0aaSMp8+f9rCzTSyHNDL4Aip+V+u0hRpYCaX9GWlJcSSk129dwxJRzOpfYfN0bx1czif5Q590muvOIp3jIhTeWQCSzy3py+WcmnkJy/5yIo0b2WeYMWaN4MpPF+VuorihPwha1ndjbFqO4gV1fKvxZ0WbilK3mS1s7orMAmP7auuZBLVNEdJPDiH4EfcLVR8tKxvRe6OW8XqtgcHqVvH6gdupqGAoDJJt6fLtuQq0mB60khVqCDTyiG7ZOo+YJtOxnpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v4RH1cc1QCYHvDCRPGaEP2EIO1BYgoQf6oH9EIZGEew=;
 b=VGPosOEFMOOeSklTLUlMPoVlAWj3ndUj1j/8lw3D/CxvJdbkjyYawGrwq4d/8RHAxLVmZ4vJU5VfvJnLTY2QDQfhewgzXZidbFgpPAIw8i6uMXDV/pMEleUDkR+32R4XRfRsKHq7HrvO7BTmjiPj1Z/12JC7s6lEVxOjTyz0uE2nnPQcDdtaVYCJDr+/ku0OWgfs/5uMprhWWDqDNszmH4rHYK/+SxvnEKxTe0wN5LsLVVjP4ef1swZcZoLD26D00FkP6LLQffRIWPmyi0FvMzKjfjXUHt82cOUVviLyy7On0gsaep/V7YypWTgs/DfTpzTkZIBppQ5GrZxRsV6Nrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v4RH1cc1QCYHvDCRPGaEP2EIO1BYgoQf6oH9EIZGEew=;
 b=WQp0+vUmhaMyfo1jMaKa5BJZx3/EXrKNIHQiaB3yIqDIBLiJFxejaWWhrumI4aaDAYDBM43FwwOXednDqmIH8vHvahihqd7YXlMKb7KjLwaACUdZTn7VyjFA0beXMOd5sUc+da5RacjDY+oB3n3ftDfigdxJHFvsNbemHRQszq6jqlpmA/x17LRngT5zWXMdiA0kX7A7TfLqgjCooAetiwtF5xxEYyGcTxt76z8SUewSACHXaa8jSC4MKiSXbP18AiH1UBK+3/AWAjU7p4SZxW3tbTmRH9Bbf9C73gC/CxZvqIcaYzrbczJpApSM1DWCTPa6W8Acwu/Bsw9D2CEcPw==
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DU6PR04MB11157.eurprd04.prod.outlook.com (2603:10a6:10:5c2::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 21 Jul
 2025 08:23:42 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.8943.029; Mon, 21 Jul 2025
 08:23:41 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: "tharvey@gateworks.com" <tharvey@gateworks.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Marek Vasut <marex@denx.de>, Fabio Estevam <festevam@denx.de>, "Alice Guo
 (OSS)" <alice.guo@oss.nxp.com>, dl-uboot-imx <uboot-imx@nxp.com>, Peng Fan
 <peng.fan@nxp.com>, Stefano Babic <sbabic@nabladev.com>, Ye Li
 <ye.li@nxp.com>, Tom Rini <trini@konsulko.com>, "tharvey@gateworks.com"
 <tharvey@gateworks.com>
Subject: =?gb2312?B?u9i4tDogW1JFU0VORCBQQVRDSF0gdXNiOiBlaGNpLW14NjogQWRkIGkuTVg5?=
 =?gb2312?Q?5_OTG_support?=
Thread-Topic: [RESEND PATCH] usb: ehci-mx6: Add i.MX95 OTG support
Thread-Index: AQHb8OVec5Jhm4lJgkevNG5vGhoXHLQ8SuJA
Date: Mon, 21 Jul 2025 08:23:41 +0000
Message-ID: <PAXPR04MB9644ABB7A5EFF3C216348F30E25DA@PAXPR04MB9644.eurprd04.prod.outlook.com>
References: <20250709152255.3037615-1-tharvey@gateworks.com>
In-Reply-To: <20250709152255.3037615-1-tharvey@gateworks.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9644:EE_|DU6PR04MB11157:EE_
x-ms-office365-filtering-correlation-id: ed0e1335-98cc-4969-9af8-08ddc82fe6ca
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|19092799006|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?gb2312?B?dENQa0Y3NXlYd0dCcFNFTE5meVAxNDRvYzdOTFhnT2s5RE5JZFluTXd5SlRr?=
 =?gb2312?B?ZjNlTExRRVBxaDIyOXV6bjZkdXFxZjJ6aG04ZHY3dGpXL3JGOHUrOUszTnZV?=
 =?gb2312?B?OWQ4QUwzTWtQYktwZm5BRkYrby8yc0ZFM000NkFVMHBoT1VOZFlNemhCZENV?=
 =?gb2312?B?dTlrUitHK29hVnhYdGZZNU1LdllzRlA0ODZyVEpaOFN2TCtoWENZcTM3dXl5?=
 =?gb2312?B?YTZQaGppWmFHTXBRMFJFSEd5c25UT3IvN1kyVWxqQ3hVNGwwMVMwZlVPVXE2?=
 =?gb2312?B?OVdBMXpZYlBNVmxxM2lSRE9RVDJEUXViNERDcStsaklNZmNjTG5KVXhueUVj?=
 =?gb2312?B?NStrN2taY1JOZWdLTjQzZmZnYkNQUUJNcWNNQlF6RnFzOVZVc3JUeWhIMjJI?=
 =?gb2312?B?ZjQ5Mmo4ZmdKWlV0NHZxc0FQalRkUGFLcEFIR090N1lyU3RNanFUZzZIa0k4?=
 =?gb2312?B?ZENhWGg0TmVsQ05TRlRSVEFXK1lNNEZRdVgvKzFoakt4WGxva2I3OHFrNEcx?=
 =?gb2312?B?L0xXZjllY0dVaVVqZHhEaGhvMGIzVjhGQTJ2YjYwUkxhZ3BKZXdUT3hTWjY1?=
 =?gb2312?B?VDBNWmowZDM5UjlpZ0FhQXAvYTV3Rkh1SFRZaiszN1RkKzhhT3NuUEFWZUtC?=
 =?gb2312?B?SWYxalR6d3BSdG1yYlgxV29NVWw2Y1lWVE5HMlNyV0w2M1hrd050aG9XNjNG?=
 =?gb2312?B?elZaQkozU01jVjhYR213TTR6SnE3allZWGQ1THdmQWQ0OTNDV216UjdxME1t?=
 =?gb2312?B?RllmOWwrV1lYcG85akpiZXQ1ZXFJSDNVVmNxQ2N4RTJKR0lXYmh0VWNpYjQr?=
 =?gb2312?B?NGJUZ25qTlFkOEtlM2V4UWZkZlBDTGlkQ0liR2UzeHlKZGpjekE3WlhpdTQv?=
 =?gb2312?B?b2FwdkhyV01pOGx5cXJhdHpyL0ZVMEtzY1ZBdlFvcEkyQWFFdTBWUlk3MG5E?=
 =?gb2312?B?cUREVFpnZk1kdGY3QmU1RW5EUStQRzE4RlB0RnloR1EvWitrQnVNaVZ1T1pT?=
 =?gb2312?B?Q0JhNk1MM2FsTDI3NHNLWTNZcVJzZG1maWpKWldMYnF3aVlhdmZlS2F4WXBo?=
 =?gb2312?B?M1Y0RlhSZW5zVEFJc3FHN1krMVo2RFJCQzRWeVgxcHIwK0tWVnJQQmxaQWx3?=
 =?gb2312?B?aXdLS0xIZHFuQUNUb2lFNnB5K1FmNXZSaU1aZmV4SGx6OVNvVld2M1o0VDVn?=
 =?gb2312?B?aWswSUZ0Z1A5RmhtaEdJSHhPcVU2eHljd1lHZzJVSG4xekJwOHZMb05lRHhp?=
 =?gb2312?B?QnN2aTArT3NFWkQ1K1RyeUExT0lUS0hOWlpEc09VMFZlVUVOWU8vSzFDL2VU?=
 =?gb2312?B?Vyt4UkVRRXhuTW9hdnpQK2ZjRmZLVGZ3VTFWOUV3NHRCWE4vN2hhRE5YWDI5?=
 =?gb2312?B?SDJ3ckJVSkpPd3N5b1BsWVlOUmxzaXZudGFOVkh0YlErV3RZMWhPSmJobUph?=
 =?gb2312?B?OFhrR0FuOVY3dVZWYXhqUjVMQzlUOEZaOStVN1NMTHhJcWZ3VnJpZVFQYWhL?=
 =?gb2312?B?M0tPUmlSZkVScEhCeEYraENiVi8veFB3c2t2LzBmZlhiQW9MK2pXbGdUWW5p?=
 =?gb2312?B?dTkvNFNZeUFxRGQ3NGNoQVlaVWdwYjlFMEhxTWUzLzdwQmlMTEo5NmhwUzZD?=
 =?gb2312?B?MnZHdjdtWWtJSm1mQ3JOTDduK3ZaMXJuWVVOa3dqSlY3QWtYcTVMUWtaY3lp?=
 =?gb2312?B?dW1yNk9pcDhzRURjQ0hBUng4dDlreGI2bzhYOGl2aXpON2UzWFpwZmc1M01j?=
 =?gb2312?B?TW9HV1JvNTRmaUtYbml2VTl5dis4VVcvRTFkd3l3eFZUdXM4Vis5UXdLZlZG?=
 =?gb2312?B?elJibGNiRmVVL2d6MENpUGlmSEtuaEZpVVBnUUVNSk4wdWl5bHBOMjBGZ1FF?=
 =?gb2312?B?M0RMQkxLRmJSZUx1Y3FOcHo2UktDTU5DQm14Sk0wWkM0V1ZMZHoyZXNjOEZ3?=
 =?gb2312?B?Zm0vckxLOGJ1Ulg0S1JQZ05nVnM5bTZjZWdPazY0cUhUQm1FUklKSEJwRW5w?=
 =?gb2312?B?NzU5djBlZXpBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(19092799006)(7053199007)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?UGw2L1kzU0hzaG5oc0t3TG8xSTloTTd4dmxYYWpTOVgxQVlkeUhxQ3JGbDFt?=
 =?gb2312?B?aEF5d2tSd3JsaFFaYVdKMHBGMVEvOXZ3bno3d2JvVkZGZ1g3aG9nNGpXTnYz?=
 =?gb2312?B?UnBhYitVZjd0QUN0Q1cxdjVwVHU1anFsUS85TlFwcVk4VHA5ZFpJQkxTYURP?=
 =?gb2312?B?V0FBQzhVM081SWdWRUpNTnU5NHhEWENzSU9KN3FBbHhJTTJnK0dkNHcxajhG?=
 =?gb2312?B?L2hkVzBJejBWSnprY3FmNTFobHZVWkhpSnphSmJpQmtpVFdMVzJjWmZyamVE?=
 =?gb2312?B?M1MvK2lwNUxlT0VxdFd2dE8yeCt5dnVwR29UMFo1MklDY0F0UUZNc1p3bFF0?=
 =?gb2312?B?cnpsbTI0ZVNBdkZ6dDd5RDErZ3hnNS95LzNRT0tuU3VvS2FKWmpPUWwxVWY5?=
 =?gb2312?B?WWExejBBVC8yVW44WTE0Rkdqd2t3UDJXWEpsb2VBTitVelp2TnJmN0w3ZEl3?=
 =?gb2312?B?OWtBNGZNMmhqNUlGVExjM1cxZ0tJYW9MVTNLdmdVZVlaT1cwSU9QYzJtUkhm?=
 =?gb2312?B?Y2cvcnBkR25OT2Q1VDNPeGswOHVqUExLN05VaVFVcDZnNVUvSnhHOE9zS3di?=
 =?gb2312?B?dFZPWG8vSW1zc1lFbGgzYXpwRHR1czlENUxScktBczBIeU1jM1pJb3AwenQr?=
 =?gb2312?B?UkUrTlJDZWxyTWprVjdIT08vMDBOQXVqS0tTVWRPU3NUd3RlaUpFNWxSajhZ?=
 =?gb2312?B?d1lBRlFIRjR4dG5JYUxTT3luakg4MnZpMFE4M0h6aTI0TWpVSk5Cc2RRczBt?=
 =?gb2312?B?ZTZIYzhxVVh6Nk1BOExiZHh2azJoMEtsNkFMb0UzVitLVFRWUjE0NmxVb3cy?=
 =?gb2312?B?UEF5K0FuRWdlNzVvZnlZZGFvU2hRaEcxRERWUjk0ZncvV2V2TTJwcVJvRlY4?=
 =?gb2312?B?ZGxNWXJxWUlPbmxQYmUzMTgxZEJJcm1MZitzandXU0gwcnJLSUkycnkyNitW?=
 =?gb2312?B?Z0ZidnBwM3dURW5pL0x1QncyeWxvNVZhempIT2dVYWM0bVptdzI5c1pTMWhQ?=
 =?gb2312?B?VWlWVDFDbzVBUW92RlQyNUYwbkE0S3BYVnhKd2QrY2ZhRDB2bVJSUVVrRkZG?=
 =?gb2312?B?OXJ1ZTZrc3NweklaeERSajFybGFleDZnRlpIMkJXeDdocFgvVmx5WU9kQlFE?=
 =?gb2312?B?Rzd2dVpIekdkcDJjbzRxZkRnSytEN0YwaWo1bDAzbkxZRDM4Y1NRZjhyYkw5?=
 =?gb2312?B?eTgzbUhIQyt3QVBiRlRTQ3kwcThoUlNBR0JzaXdvaFM5aHRTOHI2NGRGM3dX?=
 =?gb2312?B?aHlFZkl5MDloTVREcXVCUjh5eTVRZjhsb05iaXpPblpPdXU2Z09aWmJ0azdu?=
 =?gb2312?B?SFdTRnM0YjUySmFOYjN6UGhnR1V4WWFiVlQzYlkzcXFnSDhCcWNzajhwVUpS?=
 =?gb2312?B?SytIa0paM3hZcnBEZnd6OHVnQXNNYTJzQkQveGZFdjFCemJvUzN5KzdNblhn?=
 =?gb2312?B?TTJqMUZnb0hGYXZPRWNtUDR2VVgzc1BhZHN6T1pMbTFqSnNab0RvNWtDQm5s?=
 =?gb2312?B?RlIxRlA2TWo4TEdJS05SNys0ZnZRaTNadUtPWE55b1ZmUUxDamJNVFlGMUk5?=
 =?gb2312?B?c21TM0JmTVlOM1hrTGJ6aU43VkRhOUN6L2d5cU55cjNQbmo3cHcrcmR2U2Y1?=
 =?gb2312?B?aWZteVB5SkZWeW4wb1Njek8rdTNrVVZSQU50S2pMSWNKYXNGMDFDOU9EWFRG?=
 =?gb2312?B?QWtYQXMzdytuRHErYndwNWZHandKcVBYR1pocHIwQ1ZJekduTzJrdEMra2xO?=
 =?gb2312?B?Q0NqbENVdFEvOVA0YTh6R051OGlrcHJSMmYxTmF4NE95NHdGQnhzTFVCc0pp?=
 =?gb2312?B?Z0R1dXNxYzlEajdLUXNsUHRuRWdUMlZheEtDMjdoMytobkd5VWxOYUZvNW50?=
 =?gb2312?B?NjZIdjY0cDRaRm1wdUJtQTdDMkk1VjZzdWl0N1pJajAyZUdJcHVlQTVhZkly?=
 =?gb2312?B?aEVFRGtQa2FMRGo4K2dVRWFyMVYxZS9VSnNONmZuMGlyNXJ1RWx1T0l5OGlm?=
 =?gb2312?B?M1NGbnh5bHdFRElDSGZYd3RvZG5ZbUdOSVFXcUFQRHp0MUhwaFB1aXJpYkpF?=
 =?gb2312?B?aERYVG8rdEhrUnFOVmRrdy9lL1FwcUl5ekxFRkxJTFc3WjlWL3hiMlNDbUhT?=
 =?gb2312?Q?JTzJMwZRsvM5ZP0UJZgK8rXhn?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed0e1335-98cc-4969-9af8-08ddc82fe6ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2025 08:23:41.7263 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bleEstjqONBLbdIPAFJOG6lnJEmjkhN/kocu+HhR7tq/Zo2MRcEozX0Hs0bsvBVzK7JT1VB6GgS/zmcEzK9IaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU6PR04MB11157
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

SGkgVGltLA0KDQpJIHRlbmQgdG8gcmVwbGFjZSBpc19pbXg5MygpIHx8IGlzX2lteDk1KCkgd2l0
aCBpc19pbXg5KCkgYmVjYXVzZSB0aGlzIGRyaXZlciB3b3JrcyBmb3IgaU1YOTEsIGlNWDkzIGFu
ZCBpTVg5NS4NCg0KQmVzdCBSZWdhcmRzLA0KQWxpY2UgR3VvDQoNCj4gLS0tLS3Tyrz+1K28/i0t
LS0tDQo+ILeivP7IyzogVGltIEhhcnZleSA8dGhhcnZleUBnYXRld29ya3MuY29tPg0KPiC3osvN
yrG85DogMjAyNcTqN9TCOcjVIDIzOjIzDQo+IMrVvP7IyzogdS1ib290QGxpc3RzLmRlbnguZGUN
Cj4gs63LzTogTWFyZWsgVmFzdXQgPG1hcmV4QGRlbnguZGU+OyBGYWJpbyBFc3RldmFtIDxmZXN0
ZXZhbUBkZW54LmRlPjsNCj4gQWxpY2UgR3VvIChPU1MpIDxhbGljZS5ndW9Ab3NzLm54cC5jb20+
OyBkbC11Ym9vdC1pbXgNCj4gPHVib290LWlteEBueHAuY29tPjsgUGVuZyBGYW4gPHBlbmcuZmFu
QG54cC5jb20+OyBTdGVmYW5vIEJhYmljDQo+IDxzYmFiaWNAbmFibGFkZXYuY29tPjsgWWUgTGkg
PHllLmxpQG54cC5jb20+OyBUb20gUmluaQ0KPiA8dHJpbmlAa29uc3Vsa28uY29tPjsgdGhhcnZl
eUBnYXRld29ya3MuY29tDQo+INb3zOI6IFtSRVNFTkQgUEFUQ0hdIHVzYjogZWhjaS1teDY6IEFk
ZCBpLk1YOTUgT1RHIHN1cHBvcnQNCj4gDQo+IFdoZW4gdGhlIHVzYiBub2RlIGlzIGRlZmluZWQg
ZHJfbW9kZT0ib3RnIiBlaGNpX3VzYl9waHlfbW9kZSgpIGlzIGNhbGxlZCB0bw0KPiBkZXRlcm1p
bmUgdGhlIG1vZGUgZnJvbSBzdGF0dXMgcmVnaXN0ZXJzLg0KPiANCj4gVGhlIElNWDk1Uk0gZG9l
cyBub3QgY3VycmVudGx5IGRlZmluZSB0aGUgVVNCTkMgU1RBVFVTIHJlZ2lzdGVyIGJ1dCBpdCBp
cw0KPiBhc3N1bWVkIHRvIGJlIGFuIG9taXNzaW9uIGFzIHRoZSBmaXJzdCB0aHJlZSByZWdpc3Rl
cnMgYXJlIGRlZmluZWQuDQo+IEl0IGhhcyBiZWVuIGV4cGlyaW1lbnRhbGx5IHZlcmlmaWVkIHRo
YXQgdGhlIFVTQk5DX1BIWV9TVEFUVVMgcmVnaXN0ZXIgYXQgb2Zmc2V0DQo+IDB4MjNDIGJpdDQg
KFVTQk5DX1BIWVNUQVRVU19JRF9ESUcpIHJlYWRzIDAgd2hlbiBVU0JfSUQgaXMgR05EIGFuZCAx
DQo+IHdoZW4gZmxvYXRpbmcuDQo+IA0KPiBBZGQgaW14OTUgdG8gdGhlIGxpc3Qgb2YgU29DJ3Mg
dGhhdCBkZXRlcm1pbmUgcm9sZSBiYXNlZCBvbiB0aGUNCj4gVVNCTkNfUEhZX1NUQVRVUyByZWdp
c3Rlci4NCj4gDQo+IEZpeGVzOiA4MDFiNWZhZmQzNWQgIih1c2I6IGVoY2ktbXg2OiBBZGQgaS5N
WDk1IHN1cHBvcnQiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBUaW0gSGFydmV5IDx0aGFydmV5QGdhdGV3
b3Jrcy5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy91c2IvaG9zdC9laGNpLW14Ni5jIHwgMiArLQ0K
PiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvaG9zdC9laGNpLW14Ni5jIGIvZHJpdmVycy91c2IvaG9z
dC9laGNpLW14Ni5jIGluZGV4DQo+IGE4NzQ4Y2VmN2FkMi4uZjk3OWZmOGRkZTFlIDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL3VzYi9ob3N0L2VoY2ktbXg2LmMNCj4gKysrIGIvZHJpdmVycy91c2Iv
aG9zdC9laGNpLW14Ni5jDQo+IEBAIC01MzcsNyArNTM3LDcgQEAgc3RhdGljIGludCBlaGNpX3Vz
Yl9waHlfbW9kZShzdHJ1Y3QgdWRldmljZSAqZGV2KQ0KPiAgCQkJcGxhdC0+aW5pdF90eXBlID0g
VVNCX0lOSVRfREVWSUNFOw0KPiAgCQllbHNlDQo+ICAJCQlwbGF0LT5pbml0X3R5cGUgPSBVU0Jf
SU5JVF9IT1NUOw0KPiAtCX0gZWxzZSBpZiAoaXNfbXg3KCkgfHwgaXNfaW14OG1tKCkgfHwgaXNf
aW14OG1uKCkgfHwgaXNfaW14OTMoKSkgew0KPiArCX0gZWxzZSBpZiAoaXNfbXg3KCkgfHwgaXNf
aW14OG1tKCkgfHwgaXNfaW14OG1uKCkgfHwgaXNfaW14OTMoKSB8fA0KPiAraXNfaW14OTUoKSkg
ew0KPiAgCQlwaHlfc3RhdHVzID0gKHZvaWQgX19pb21lbSAqKShhZGRyICsNCj4gIAkJCQkJICAg
ICAgVVNCTkNfUEhZX1NUQVRVU19PRkZTRVQpOw0KPiAgCQl2YWwgPSByZWFkbChwaHlfc3RhdHVz
KTsNCj4gLS0NCj4gMi4yNS4xDQoNCg==
