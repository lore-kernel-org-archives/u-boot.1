Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2211FFF885A
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 16:03:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 974A284374;
	Mon,  4 May 2026 18:03:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="JuFWunhj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBA49845E3; Mon,  4 May 2026 18:03:54 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D448D80F0E
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 18:03:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uGLxTxZe34UrfnY5nI43IxNIucU59jF7vAtEpeS9eAhDM2ikXJ0fyLNZhUM5VAHLBqbCkLmbrejfZ/yAp14MsNsUPxweOfvlr3+DrU0EAfpEprXCSif3OAmLvBja59ZGGQlGd0/OzRFM5gPcMHm8OEAGNG6QuUAcZpciywX2Vsdqe4GVb/qsun1XMk92926lVLei1HmD8HbwG1Hcu/g9d4x9zvbX5tY0PkPbJpyFL24OW6ZKHoTT3b0IQmL+XgI+LA7/EKS0Qo2U4Wuuv8ecyanoR4BgAlRkYTFigM+EDvfLs9ixk3KyBcgfLGi25N1PUm5CX7RcRSpUp/Z2SKV1nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YMPx2C5HD20wSqEKG6TGrQzhQtA8gLeFQcUYl9cY4iY=;
 b=j7dU/faJ4nl4ehLhiJZP3SURmNwSaQaWDmYvxbxlL3wglCodrehDpqRpmnM/84TpPdN1ya9fDm9HSwLmxAhLJmmRXdRXP9RFUSwgjwGNKh2gJSx+TpGQ8x/82wi/PD8qFxJBpw2kJglX3TqPJt2/gGmZQam58wZvx0VKjduDtcMqipsgaxeK9GnSilCP9OQVS8eCPqHmgNPjDe1YL4F+HmdxgvJ1t2K9IxxzfzJnGwUth5kMMUI2W+GdM+RYCDJIOTpfZkbEyDsqBwc1YgZD0995isRqDpSaXB5CYIRjnEMOEmuPtJB+JRCDQKK7Q3uAyxn5eGqbZIGYmW+amnGV+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YMPx2C5HD20wSqEKG6TGrQzhQtA8gLeFQcUYl9cY4iY=;
 b=JuFWunhjHz3Nthk4fil+srBkqeQb4fxVFLV612bwYk2lv73E2OVeXsK5WwECD/swE81aav7cf1RiQClafIyhubUeY1YlmWiOW339aSe1/gQK2S28FZSgLCHDtIzs1u7qS7yeh5WkyWgtTlyAvHycR2lgNYadtYv7G1W60WjaPyQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by VI0PR04MB11784.eurprd04.prod.outlook.com (2603:10a6:800:2ea::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 16:03:49 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%3]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 16:03:49 +0000
Message-ID: <745d7c15-cd9f-4914-b81e-6e90b0f11d01@cherry.de>
Date: Mon, 4 May 2026 18:03:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: clk: clk_rk3576: Add support for RK3576 GMAC
 25MHz clock output
To: Alexey Charkov <alchark@flipper.net>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Heiko Stuebner
 <heiko@sntech.de>, Kever Yang <kever.yang@rock-chips.com>,
 Lukasz Majewski <lukma@denx.de>, Yao Zi <me@ziyao.cc>,
 Jonas Karlman <jonas@kwiboo.se>, Peng Fan <peng.fan@nxp.com>
References: <20260504-rk3576-rgmii-refclk-v1-1-c6604a4b69ac@flipper.net>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260504-rk3576-rgmii-refclk-v1-1-c6604a4b69ac@flipper.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIXP296CA0012.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:2a9::6) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|VI0PR04MB11784:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ed8c039-597a-4d3f-f3c2-08dea9f6b9a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|10070799003|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: WdvGRcBx4bOD4JfqTa7HDm+T9RXzq+2dGRkbUbY24kI1BI5mQDr1astnevimbMA4IrOI0wyojmSAbYJjTvqSiN9xbr6flMfcNQPnR1ClRovGXovZgRPFDbVaqMHw8rSa9lyK17wFW9V445EvXh9NVDLwJlXmRlevataEHa5rlT98/3xTR0M27BE8VLtheFSX8kjMNimovNBY3h+yQQOct264Rs2wv9v5pRm7+qOPxuYGKZGD/YXKWfJ+wMfud5CEYIqguihJB/B7bctLnxVrut7H2SATpCiV9AnnViAM1kEQ40cjIyU3jsYxJdMSUyO93irDI3/YDDn+fkFPg8x5aB/wWp3F2xsjWybC7BOlg7HUa59w90EPiQ4yJ1La6azXXsmPmSeAzqjPJt26kZMJvnYivPt59Vn6TBpZi9aoIfr3OcuNjR4l8Nw+rZ1CDK059ahNMnsKSjNNIWSN/L8lJqqHYMHie3AIZKd0EFbjn8paCn5Fachr0a4hP4VhPVJV6Enqhg3OWVo79MEZyGs8rxjc7L7wcJVgjNlsOZlqFvtbFXOioXU2QsZoAvlijJeDCAn45o2eCPFNBm0fdImd36+Z1nFOTKOUvS3mx4r35bf2b6Q+AXdg2YYzMZO9HSQbco9LJy1yDBEwyJFZ1XWLM7c6S2fobdj0rxhQw5Dcz0NSnbR7+2DC7i4YbDyLI0Gl
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(10070799003)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWlvTVJUcHpwT2FtUmFXR2xEUUUxaFdDdm1DSGZKTWFnMU44dW5wbUVhcVBO?=
 =?utf-8?B?bmVzSTB0ZXpIenVlT1Y4c0IvekdQOVg2SGV1Mlp2RFJiY2RPWG5XMHFzQy9p?=
 =?utf-8?B?aXJkVXVTWHFVOXVZYmJENUx0aXdEQkRDLy9Eb2l3UU1FQzlnck5TRFJPNS9B?=
 =?utf-8?B?TTRpT3VhbFdsZjRhT25FRTBVR0w0bnYrOG41Tm1YRjF1aEQ2RWNrTVhOQzN4?=
 =?utf-8?B?akQydXVTWE5EV1VmL0lLVWRBZXFhQnhHV0htWWRBd1g0OFRKTzF6aDZNR25N?=
 =?utf-8?B?SFdkczY1aURVSEVpRW9kUXF4bHRGZGpGdHBOVTh4dTNKRzBPVWUvTjZLTVVh?=
 =?utf-8?B?N2w5eWV1WWNFTVY0bHgwN2VvN0ZYeWlwTWZZS3VNMFh4dW45QnpSU1ltQmw0?=
 =?utf-8?B?YnUzblF1ZUU4dTRFSXNOMXRZNFlOQVFiZWtra0FLZ1hJM1c5S0xNM3pEbkpt?=
 =?utf-8?B?QytQSGJxaWxaeUVPNWE5Sks2a0pNWHQ4aDIxMzZ0dUoxZURnQTZvMFBEUWRh?=
 =?utf-8?B?V3k5Z3J6Y1NOcDdWUTk3UG1lKzVsdFhaYTUrZ2tvdkRUenhBV3laRGo3VVJF?=
 =?utf-8?B?ZFp2aEtTRGRMZENZL0JsZGYxQTBPS2ZpL25pN2NiSGhUT2ZmTlFVM3N6K2hm?=
 =?utf-8?B?ZWFNK0JyVlZLTktSVStNL2tsL0VPTElkQ29Yek1tY1BnY2tYSzNubEhwdUR2?=
 =?utf-8?B?YTN3ZUE5RUdNS0VHbEtRYkQzYldUblFKN2FKMDJ6a1h2eHNObkxTVHRjZUZo?=
 =?utf-8?B?RTQzZTgzQktMWFBiZmlNMVlmNlZwV3NjcVZvSDJTakNhdERDMVZqb2N0ZHRl?=
 =?utf-8?B?SEhEUnppbFIvSy9nVUw2SWx5bXlRd2wwREhXNElJMUxJR2tmRjZoZ1NNMXdL?=
 =?utf-8?B?bTh2UzVpcGV6QmpSOWRZUmZkdDRiOFJPMS9pUUY0V2hnYVpCcGs2TlNxWEQz?=
 =?utf-8?B?QnBqcWxNTGhwQ3BTOGV6a2N1VXZ0MnJwdC9uRDBoZGlVYUFEK2dVaVpkNmw5?=
 =?utf-8?B?OTVlRzVvTmFSWU1wVnVwbnQyWE9mSlZMMEM1WVVnZjQyVzFuSGFWT3ExWVVU?=
 =?utf-8?B?L0JvREtoTFFLSjEyTmZpRnV5U1ZaTE5jTWdDMm9CMEd3aUdKdDdtL2ZPVXZk?=
 =?utf-8?B?N2VlS1RZQ0E1dXFXY29scTQwYlZkMTNWK3dpMUR6eHpvdldjWjYwVVoxNjYv?=
 =?utf-8?B?Qnc3N1dSdjh4dDI4Z0VXNDhjTWczc09WbFl2QngzcTRmQ1htRWsyOWltZXpC?=
 =?utf-8?B?M1hBbnpEQVZNcUtxVFpTRXJKQk5vdGtMbUFHWVgxZ1BId1ZyS0IvOWhsNXRt?=
 =?utf-8?B?UlY4MWxoU3V3cG1kSm1YNjVIL05RWGx6T0xWZ0c1L3JVVUNXLzN5UjYwcE1S?=
 =?utf-8?B?RWp0QWw1bmRGdk9oUWQ2UGlKLzdDOHhFNURGZ1BybTBOdWNTb1A2ZDBrUDBW?=
 =?utf-8?B?K2ZIamxqWjcxOEQ4K1I5amdTNm5xN3Y0c2NiY3RoSTlkMDVrMkFiTjMybWdq?=
 =?utf-8?B?YVB4Tk5vMXdBa0NCZEpQVk5xSHZJSURQSHF0eDNCejVkLzFPZE5zVEFUR1N2?=
 =?utf-8?B?Z3Rqd3pVaE0vQi9YaXdlSlcwaFp5ejFJY0hVY2ZzWGloL200WVRMb25rWE9Y?=
 =?utf-8?B?ZXc3Ym5INlJJTDVOOE4wTlpnYVFDWjRsUWJVVDBnSS94RVovakVMcHRvQzVM?=
 =?utf-8?B?M213ZU5qYyt1K3lhOHFPODVleCtZRjhmSWUxbTUrbjNqUExaUFdFOGhuWm9j?=
 =?utf-8?B?U2Y5VnJRWXNqeU5BUlN6MWk2dmhzcExYMnFsYWlubjBGWkJrdyt0bVVjNTlp?=
 =?utf-8?B?dmdJMkYrbFJuVzFtWWZsK0wyVE5lUUF1NmRrWkphazFhemlLQVg2MVdyQWZa?=
 =?utf-8?B?TloyZ2NCSDVXQnFlaGZuSmtaS1BPQWs2azdmZTl2bkhIN1ZTU1Y0dEtJUlBn?=
 =?utf-8?B?U28zdzZTVjA1bXVXQSswN3pLOWtINCtyNXVYYXl0eDBRdGJSNUNKbG9Bd1g3?=
 =?utf-8?B?dzlTS3NDbDk2cXNHc2JsYjJQYVYvT1JEK0d2aW1GTUxQU2p5VzN5cEVWeGIr?=
 =?utf-8?B?QVZUREh5ckpLVWJSME00OXAyYjhKVUdJckl3WWd2cjAwNDFyQ3oxQnhHKzgw?=
 =?utf-8?B?RzJEOHFJa2UxMStNNmpWYUlULzBCVnhoTVFsQ0tla3lRWlk3VkR4bWc1a2tv?=
 =?utf-8?B?UVYweEtXeTExQlNrVUhkd3BBNzIrNTlITjNneDMvK09tTnBLNXE5WE1xUkNL?=
 =?utf-8?B?dnVFVGJCMmZIa3BRWDBUMDJJdmlNYnlqSW0vM2Zmd0MvakY1T0VrZmcxL1hz?=
 =?utf-8?B?R3M0Y0srTUNXNllMUXdraG5xN0E4RjJUSkVnYUphNis4Q0pMayttcUt4b3pw?=
 =?utf-8?Q?egsr17QVArXstubfSq9FILE77PS4tC82ycu9bUu3uOHFW?=
X-MS-Exchange-AntiSpam-MessageData-1: m+WtHI/3SJtLSsxIYCy3o95HaB53il+kybU=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ed8c039-597a-4d3f-f3c2-08dea9f6b9a1
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 16:03:49.3128 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zx8Th9SCGCiXUCTyjunJe7GYwimJGNf9Sp53riVuF9q+ehqFNl+LA38ep+mwRviH7h0rMcX3UI1Fw9dh0v/7CtwgWXG5+Wcn/2T5Dkvul4o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11784
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

Hi Alexey,

On 5/4/26 3:45 PM, Alexey Charkov wrote:
> Rockchip RK3576 SoC has two built-in GMACs which connect to external PHYs
> via RGMII interface. The RGMII link can be clocked by either the PHY or
> the SoC. When the SoC is the master, as is the case on the RK3576 EVB1,
> the output clock needs to be configured in the CRU.
> 
> Add the respective logic for getting and setting the RGMII reference clock
> output for both GMAC0 and GMAC1.
> 
> Signed-off-by: Alexey Charkov <alchark@flipper.net>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

We should think about migrating to FIELD_PREP, FIELD_GET and similar 
macros to make this a bit more readable and less error-prone though. 
Some job for future us, not a blocker for sure :)

Thanks!
Quentin
