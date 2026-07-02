Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06E8BC43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 17:23:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DFAB84975;
	Thu,  2 Jul 2026 19:22:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=OUTLOOK.FR header.i=@OUTLOOK.FR header.b="Ba6gNxBC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CB2284A04; Thu,  2 Jul 2026 15:54:58 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazolkn190100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d200::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60D018469D
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 15:54:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fberder@outlook.fr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fdMPDfrAJ5kUi6Tv9KHs75CDwsghBor40p8yf/x3JM3zrJa3g4Uto4hIyi7OX7A/v30GYs7WeXZGPl/s0BM+JFAvxZpewT7YK+JzAsKz+Svuxj9w118sAXV2D2AiP+bkxotujsVpE6LqjYkgAeF9ZFbwrmhXlP70XNvf5IyiJQypDrjL0ZGFJJimseHkkR90Go+MHd9U437NmiAxfZZlNvitqN35R+wTlp4HSfecEI1XXA2OEwcPO6gE/actRMge29+IpnwaWKW7WQvZFnLuVQvnEEXcPoQSJqSpTjigI0WWBfiAbNCymfVnlheq6T6uSqamXuv9E3KBGENYuF+Mkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oe2ewPUAxRZ7q7nd4wBQvxA3QV26lc1HueTnOntVsPo=;
 b=OO39dvO9eGP+fBNb9zdQ7EyIyX6umQVcLWUYzTsf80GKWd+Zw5PYJUFQT6oQ1S5jjOxz0VIhU2dpO7qHrmOI5p0Tr9mWyumM+Gmp+Fc3RRQY1sjXebZP8lHFNhY1jFHYGrwmssx5NrllQcnutsp3pl64LQNpaaM0PJ0K8evS/vhKIwh2w0VNCS3L1OpibaPTo5wNjsGnjqzzFYDrQWlHdKUwV6Zm5kqSTynF//LaBjz1fujXwkjipoFGYHnmC+Lmwh/qdPo+5TS9ZB+VwO8wy3EJ7LO9WFxUkQa6GugrhtqPIHhr/ZuDQdZkhLbIRxdWjLXki9Ikflf9tXlD4D3/Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.FR;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oe2ewPUAxRZ7q7nd4wBQvxA3QV26lc1HueTnOntVsPo=;
 b=Ba6gNxBCgscyJzHfb4ft2sOc9XhyI7dRMM59LfzBxq3eCmIsn6HJ31l+hfaw8MuIh3i1WORoMl74t9ix+7gJvunVvYwaoSel+2ebNA9qY/XBF6WUOMyIl68BbGPL0fIYIUwrgEPqurLLKxs6X7MDQlfQnLFsBoKOaGmsTOlucAqgyNPh3ASMHEDTtugseJSfQkC5z5teJpv4UOzjUhYwYOx68VnM12bB6Z40FXK4pO+4+ajo/iglMZTOq30q5ytI0eKG6qYF33Mbz455TWFoBi5XZ6UtJIurUd3OvNuPlzYKnCd1ljILjsGjZgox3QLChsckaNhB23P9U3u2ml1WZA==
Received: from BESP194MB2805.EURP194.PROD.OUTLOOK.COM (2603:10a6:b10:e8::5) by
 GV1P194MB2210.EURP194.PROD.OUTLOOK.COM (2603:10a6:150:1af::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.8; Thu, 2 Jul 2026 13:54:54 +0000
Received: from BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 ([fe80::5ae3:1158:9ce8:90]) by BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 ([fe80::5ae3:1158:9ce8:90%3]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 13:54:53 +0000
Message-ID: <BESP194MB280518E35381D7CF2CB50C60DAF52@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Date: Thu, 2 Jul 2026 15:54:52 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: u-boot@lists.denx.de
From: Francois Berder <fberder@outlook.fr>
Cc: Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2] xilinx: versal: Fix snprintf invalid size argument
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3P192CA0028.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:102:56::33) To BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:b10:e8::5)
X-Microsoft-Original-Message-ID: <c8d12e43-6a69-4e77-9240-db07c5eea9df@outlook.fr>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BESP194MB2805:EE_|GV1P194MB2210:EE_
X-MS-Office365-Filtering-Correlation-Id: e2e51750-75db-41ec-0c55-08ded8417e54
X-MS-Exchange-SLBlob-MailProps: WaIXnCbdHrO+2YmbT5jW+WUSUt4IT5vRII2vDmyySRIH4gSSwzmUEw8+PSOnnSWzm7fYXP7iuTtt3LpisSp2a5gaz+loijlWa5YK0AL7Ei5njT6RSCXwTgkesoBA+L6EBLB70TPV66QfqeJZ8toDwbne+BVNHi4dGpsKmIjBi/vefIobaHHX1Wj6zkg6U9EmB4CRFBVOcrhMslQ9d6+fSGPkV8Vm/+26u7OabzuCvV0B8Z50jCTbwencYqhrYQJGUB2+YB/YAJExYDHQYRCqQ9WbfH5hbj17juzaWuR2vg4T5D0GFLiTO1eI9UylmpYnCZVEde1Sfr0Nm1TJeaXaD29QpfUAziIrSmNAxQLjrmzShFHwvq9BdYZSQOboyPVP0PAPeZRRX67cc515iY1i28aHTW1ee9Ff7oYYretQKeF7x8wPjf3O0fkrJs1QZ6mL+4J9OiIxE4dvKQgYpph1blC5C22SHgruWpURfqqHJ9nV6waPSVfx5tvwF8D2u1UfyG+0R9sFNP6Bly9bXz/tseTDU48wHsFCCP3sqFP3LY3JvYmtM557+5iYoDGwWH5/xT9O5CjApbzW4SlgjsAlQUf6HTifEsy/kVzULZKxayeETyX+6hQIiKBgeF1rPlW4Ovr0JjmZ6UrbUlwvWNgf8JFW/u+Bo1vq0PLSK169UF1zlC92UsP6cvS7clI2vgyeCvYwG3dfnD6ud/R+hOL5Xsi33uQq2xFagFzIVlNfG7gENf2QuHrD32lyPEB8vX7kTWCTdPV/Oj4=
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|19110799012|8060799015|6090799003|51005399006|55001999006|24021099003|5062599005|37011999003|23021999003|15080799012|5072599009|25010399006|40105399003|30101999006|3412199025|440099028;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TG01TW43bjJtMDNEUmJET0FjUWRlenRaSStLY0lHcjkrdTBWeVpFUW1nSE9O?=
 =?utf-8?B?TUJrdWVCY1B3MGNPM0U0RStya0NVdVBnQ0p4NDNtcE5adWZkeFB2YnV3M1Zq?=
 =?utf-8?B?ZmZTaVp3eGZsWWpGdXBSd1o4NEp3U0JnT1V1RitxQTltekV5M1V0UDRjcWZH?=
 =?utf-8?B?NzhoTVhHS0pieHF4QXBEY2wyMW9pb2lRekIxdko4bFNoWGdqMit3dXlNd29a?=
 =?utf-8?B?eTVsZElybnhyaTVuSlF0K2FCZExMQithaUMwL1JRUE16b0w2NTFWUEhTdXJp?=
 =?utf-8?B?Tm1CMnYxUmZWUzMvaUtoQ2xlcWptR3k0cmVWaCtNRzBhYVA0d2gyY1V4ODRY?=
 =?utf-8?B?anY3VTZ6cU1tcHg3L2pBZklGa1EvMC8yZFhDQnNHb2w2OFhETnphYlR3eENZ?=
 =?utf-8?B?TE0yZTVXQUtZTlJmMG1YY2lEeUlZOHRkc0IrelZKWFhZVWVlODZkY0h4VTVL?=
 =?utf-8?B?MktNSFRCTVh3dy9BbXJHZzhZM2tUa0k2b3A2VGhvekdvYytlWG51MXI4NFRQ?=
 =?utf-8?B?RkNHTnY4TmJqU1VGbTNwaGY4SFBBQ3h4d1owSVphbHJDckNVam9Id0kxelcw?=
 =?utf-8?B?Ym9sTkhCZFpNUlBDTzNpdExWUno0cWhUWnl5NlcycWMzNXBGR3pwTmtGM1FB?=
 =?utf-8?B?WGVOQW9CRzFCWHZrNkM0OWlpdldUaUQ5RmoxMmcrZ3RXUDQxNkdPeS8zejht?=
 =?utf-8?B?a1BTTGEwRzRabHhScVlEVG50OXJLeGxaWXQ0OE1hSnIwVktVNTlvSzB1V1Js?=
 =?utf-8?B?Tm5aM1BoclZVRGJ6cWhTMnhMOHNFVWoyWkZZWkVuSUJCUDFXdTllMFJvTG5p?=
 =?utf-8?B?RUt6cTg3eG4xakFsNXpGaHpVeWxxWWh3Mk1peWRaaHVoWnFQcll2cXdXR29n?=
 =?utf-8?B?eUhaYWI5UUhPdndsTTBNdGtlQVlOdDZ1NjR2UXpidThWYTNoTXlpRlhvRUhi?=
 =?utf-8?B?NzBBRmlDS2toaktFbE5lUkkydkliWkZvZDAwSVRURjNOYjhaWlp0ZEhnUjhN?=
 =?utf-8?B?NUtyL0V5WDl5MDNNaDlYUDVxQUh3SUNnUkJVN2dWVkZ6STZRenRidnFrYXNF?=
 =?utf-8?B?V1hvMEJScHArK1RIRi9RN2pxSk12N2tPWHhqYmsrS0VnY1NVVGtoS0ZXVmhp?=
 =?utf-8?B?L3AzeFJKVUhTT2YvcnFXenhrVllwUTdPM3lJSWFVNDlJczJhTlB5Y0VNZFkv?=
 =?utf-8?B?MFNYNUJqeEZKRmhtNzN6SklRQlovNzhGRTZ6VG9qa0tSM2FOcm9vM1J4ZmN4?=
 =?utf-8?B?R2dhK2FSNnFETTI3SVpHRmtnbU5GMjl4OG1vRDc1eGtYdEtjYTluSGNPOFJT?=
 =?utf-8?B?WDU0Skdnb3VRbjljM1V1VStIckd4OVRxemwwMkt1dFZIek5KL0hkWm5sM2JV?=
 =?utf-8?B?K0syaDUyVGFQTTRDK1JYRXJLQVM1Qi9IWWVBM0QzOWVGWU9YbjVadE9sZDdl?=
 =?utf-8?B?UloyQ3JycU15L0Z2T1FYdG1LV0lDbUxMVlltS1NnPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0Rsdk5IbkZSWlpHSTRSQXR0UzVkbFpyM3hnZ1NhWEgzenpMZlVjNlFCbG1n?=
 =?utf-8?B?R1BZVUxuT3NjdDlMaEF5ZGQvdlViZ2k0MTFJOXJzcmVKVlduelkxZ25rcDFS?=
 =?utf-8?B?QVJtVzlSZkRsd3pocCtxYnVXSTNtY1RkclFxWlhWQ1lFUUZINEhGMlhlYkNP?=
 =?utf-8?B?Qm8rNEkvcTNDRXEzRlg1OXlsRDVnV0RkbGtQRHE1eWY1Y1N0R0o1Z3g2R2Rr?=
 =?utf-8?B?Vno3b3RKSEtuSkhBQjRmQVdSaUJmOHJkSm5Gc2EyYVA5ZUo4ZWRpVGU1dkRX?=
 =?utf-8?B?ZUU1elY0UXU0ZzFFYUl3eVdyS2NTblhHQ1NXSEJsczVWRGFEYnZNVnRRRTU0?=
 =?utf-8?B?TWxhM0l0V0RzTkUxb1dzcVQybEtSd3FEaWxCNkpSNmVkWlJsdjZUQ1luY0E2?=
 =?utf-8?B?a0ZIOWxnN3c2WXA3ekhDaXpsYmNIQmNMZForU29Cc3V0SldOZUxJU094bXJT?=
 =?utf-8?B?Y1h6ditCQmJWN0RHNXFyQ0sxaHFhSWxrSExPWlBrU1NHdHRCK0lqMDdkZ0Fq?=
 =?utf-8?B?V2JDTkpsN3NKV0FqY3lPT2tFZFBiYVVubFd4RnF3Q1FyOXBxbGdXK05EWFZo?=
 =?utf-8?B?N0MxSmZRdUcxdGFaaUlZQ1kxWVZkeVhkZk5LUkp3MHA4aFlJTEgxNzFGVEdx?=
 =?utf-8?B?YXVkR3lwc1MwU1hBVTVndjl4RXlUb1R1WlU2SmJTSVgxbFVCT09sTklRc1JU?=
 =?utf-8?B?K2VadkMrUDU1UVZzaDhoejd2eUVnekQ3dDFGR25jbTljanRZM1NIanpQZ3Aw?=
 =?utf-8?B?bW10OS9Jd0V5UkhNMyt4L1Nzb3ZyV0wveklTc25ucUx6WFExbG54RWVvWjQw?=
 =?utf-8?B?VEd1VDlYazA2WkJxVlVYUDVwanpPZFpCYW1GdExsOXpUTFU4VkZYVmswVnRa?=
 =?utf-8?B?VG95UHp4N0VCYWMwc1BZSEpNUFl1SGhtWGZKQ21uNXVEV21LdUlDTlhpcmVR?=
 =?utf-8?B?RTRTR1o3Y2FCbW5VazdMdnU2anE1Tm1BcE9Vc2lRMnNBOEp6L1FibkdpUVB0?=
 =?utf-8?B?Y3AwcXR6TSsrM2pZVndrYWcrN0RNZ0VrQWZQSHpXZ1QzMUtUOEVZc0oxbHFZ?=
 =?utf-8?B?ZmZFVitzbTVncWlza0t4TXA0WkpjV3dyalEzbktIU09laklHMmt4UDFTRC9u?=
 =?utf-8?B?TC9VVUlldi9NejFmcFRtaHFPZUNJR3FRZXUzcnBiWUYwKzFZc0RNWmZ3Vlhs?=
 =?utf-8?B?Kzgwck5RZ0t6SEg0bG9COCtTOWtaN21yc1lScUVGRjZ1YUsrZFBMYnJFK2dM?=
 =?utf-8?B?eEMyeWUwNXd4QUExdjF4QXVIWjNSOWtRNVduWkhkc2ZEYks5YktJTGZzMDZP?=
 =?utf-8?B?dHJFeFlnSkJKNWdMMWVRWU4wc3lCMlZlK2Qydm83TTdpd1dWeGpYN2VYYW1t?=
 =?utf-8?B?QVdST0t1SENTam4zVXhBTk0vUTNJb0VjRDd0aUh6K1dNUWNwZnBUbTdOSm1X?=
 =?utf-8?B?UFFhZGc5SlZvSGl2cE9FZnJmM2FnY3lTOWVjYXRVczg0aEQvZ21XSXYzbjl6?=
 =?utf-8?B?R0NqVEpSNm5VQm44RXFNYUMxQ3pRVVVOdHlMRmVKMFVJMTRqeEhtdHdKRXVW?=
 =?utf-8?B?anJxTDVaZVpHUklzSzJ5ZDByd2dJcVFkdWFGMlkvRGFBa2Y0VXhEMzFnZ0VC?=
 =?utf-8?B?VzhWb3JoalErdFFQclg3VUhkRE9Ra05qcFU5ejlOaGF3M3pZZE9XamUvMWJX?=
 =?utf-8?B?K1oySGYxWU5aTkFtSUR6VHN0NVgxc3VhWXBIdjg0dnVxYzNjNUxLUmJBNkVD?=
 =?utf-8?B?c003VVZIdHdCMitXYThoRmJJZXI1eUlyNWU2b0pLbjkwZEEzVEF5NmI0WFE2?=
 =?utf-8?B?UHBNNTlQMzR1ei8xQlU3bzUxM2IxRVY0V3JLWi9SV1hrZ2xaWDBxTXdLa21a?=
 =?utf-8?B?NVB4cUQ0UVpBRkF4SEJNaTlSeklEbWJCL0FENmlISFVsY3dpMEFrNjRqaGdF?=
 =?utf-8?Q?1wYrQzVljRWizn1GMvaLlMOrrG7jZTdi?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-3927c.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: e2e51750-75db-41ec-0c55-08ded8417e54
X-MS-Exchange-CrossTenant-AuthSource: BESP194MB2805.EURP194.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 13:54:53.9348 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P194MB2210
X-Mailman-Approved-At: Thu, 02 Jul 2026 19:22:54 +0200
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

buf is an array of size DFU_ALT_BUF_LEN bytes.
It is gradually filled with data using snprintf but the
size argument to snprintf is kept at DFU_ALT_BUF_LEN,
making it possible to overflow the buffer.
Fix this bug using the correct buffer size:
DFU_ALT_BUF_LEN - len.
Also, replace snprintf by scnprintf, otherwise len
variable is incremented incorrectly. It is now
incremented by the actual character count written
in buf.
    
v2: Replace snprintf by scnprintf

Signed-off-by: Francois Berder <fberder@outlook.fr>
---
 board/xilinx/versal/board.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/board/xilinx/versal/board.c b/board/xilinx/versal/board.c
index 9371c30ea27..88bcd692401 100644
--- a/board/xilinx/versal/board.c
+++ b/board/xilinx/versal/board.c
@@ -418,15 +418,15 @@ void configure_capsule_updates(void)
 	case SD_MODE1:
 		bootseq = mmc_get_env_dev();
 
-		len += snprintf(buf + len, DFU_ALT_BUF_LEN, "mmc %d=boot",
-			       bootseq);
+		len += scnprintf(buf + len, DFU_ALT_BUF_LEN - len, "mmc %d=boot",
+				 bootseq);
 
 		if (multiboot)
-			len += snprintf(buf + len, DFU_ALT_BUF_LEN,
-					"%04d", multiboot);
+			len += scnprintf(buf + len, DFU_ALT_BUF_LEN - len,
+					 "%04d", multiboot);
 
-		len += snprintf(buf + len, DFU_ALT_BUF_LEN, ".bin fat %d 1",
-			       bootseq);
+		len += scnprintf(buf + len, DFU_ALT_BUF_LEN - len, ".bin fat %d 1",
+				 bootseq);
 		break;
 	case QSPI_MODE_24BIT:
 	case QSPI_MODE_32BIT:
@@ -438,9 +438,9 @@ void configure_capsule_updates(void)
 
 			mtd_found_part(&base, &limit);
 
-			len += snprintf(buf + len, DFU_ALT_BUF_LEN,
-					"sf 0:0=boot.bin raw 0x%x 0x%x",
-					base, limit);
+			len += scnprintf(buf + len, DFU_ALT_BUF_LEN - len,
+					 "sf 0:0=boot.bin raw 0x%x 0x%x",
+					 base, limit);
 		}
 		break;
 	default:
-- 
2.43.0
