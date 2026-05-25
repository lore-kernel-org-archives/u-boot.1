Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D02BDCD5BC9
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 21:59:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28A24848FB;
	Mon, 25 May 2026 23:59:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=OUTLOOK.FR header.i=@OUTLOOK.FR header.b="GU/rfYdz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEA758489C; Mon, 25 May 2026 22:46:39 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazolkn190110001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CAA56846E1
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 22:46:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fberder@outlook.fr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QCSj+zvgTd9bEQ3tGgQ1p0NjTa6IuK9uUYEPdkl0RjgKHflJmEUNn2JK+XOGuhUoMTTtQvDFs3YYY+RD+SOMKutb0x1cl0v+wGEqgj9ukOwcgaZTvgGE4WKWODA6rLbEgyn5rdekI6RMX9UD2tRYmZCxHzLobIOYO0QSgzTVJSrXpdwd1SI+JgCxYYF4jVBuCORpYlXCfoHUwPy90BoaL3evgtjdudo12CRfRkI9xvN1vKjW0aiyv2TtG/OVeAxvP0ZzruHQjosRCz5WjG8uUgHjp7b3oK72eJrsUGhU0eCTw5GvzYzdMypxRFaqKBGrexX3mMiRWBUgGbVOAc1yRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sW0l64C0r/jo3F9t5kBoMpgvX/LNiulL5cd5oPA+Gw4=;
 b=dAx1osKmj78x3Oed8KLgv0zsRlgcFZkluKCI4XEXKEssJJkPmcV0J/GLGvI/JCIpcveB+qLusGJAvaEQAPnjcsA7ZHwAJOIrNctcPgvnFNvgsRIb5CMOgJnaWv39nNEvA8gZF3rGmy1ZAingt5NaNucPqKy3FR5lferZvCDKzFV4k/ixtaNFbIdM0I8e/22rKF4of4Q3lR4feLfznFMnkHIa98R4LLSS+5J5OR361uu3XQBe7xxkEcT5YTzCuPAy4oEh+U3smeQuVRMRD0Z/KMlq5ptRTBXB5JiNE6CyCD8iLim2qaLuAXOPyBC6mhjnFp2t2qrR9XML+BdQ2G+mrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.FR;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sW0l64C0r/jo3F9t5kBoMpgvX/LNiulL5cd5oPA+Gw4=;
 b=GU/rfYdzh0v0oInA33BivrL7Na/w4DfoHtmj7+ExADgvDn+VVz0Ywdi1jNukNuXpZojfvCIH/sgaF1Nw6mq/S7LR+XM4YHfeJJWuJQrIOqVSR19QkTu6s1U0IhsO2yvvid5Xj+XqeePkSdipqpcMi4OK76a7T/Q9/YlPhMKxVN6i+CwobVBpbyZAxm3pHUWXLpGTEblRnafNOdvYJUG562R3R70rGCQjkFun+ALK6OxgtQibskio2TD/Eoitf+mRPjvH+QXz/yk5c5QJwykV5rEl4+WMWYK8PcKWVuxbCAkN4EDV/LJQt1h2z5yGtXAa/RFla/3THlj8XtG21SN4sQ==
Received: from BESP194MB2805.EURP194.PROD.OUTLOOK.COM (2603:10a6:b10:e8::5) by
 AS2P194MB2069.EURP194.PROD.OUTLOOK.COM (2603:10a6:20b:5f2::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.20; Mon, 25 May 2026 20:46:36 +0000
Received: from BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 ([fe80::5ae3:1158:9ce8:90]) by BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 ([fe80::5ae3:1158:9ce8:90%3]) with mapi id 15.21.0048.019; Mon, 25 May 2026
 20:46:36 +0000
Message-ID: <BESP194MB28058363D3E3AD5E44EB31EBDA0A2@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Date: Mon, 25 May 2026 22:46:32 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>
From: Francois Berder <fberder@outlook.fr>
Subject: [PATCH] clk: qcom: Fix invalid usage of dev_read_addr
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR1P264CA0038.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2cb::10) To BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:b10:e8::5)
X-Microsoft-Original-Message-ID: <dfa7ad2e-2a7b-4901-92fb-e74695c734d1@outlook.fr>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BESP194MB2805:EE_|AS2P194MB2069:EE_
X-MS-Office365-Filtering-Correlation-Id: bee25d74-0e5a-402f-e2c3-08deba9eb68c
X-MS-Exchange-SLBlob-MailProps: Cq7lScuPrnpOzn+FyY7u0ciAUhyJrQwV5p+1yYZjeWCAzKGYpbMtfWNm4Uo5vZotKxpyXrocuIncDMi6gS4NvKezYSPvioygrHyppkQR7Bi94cMBFiz8L3YmTz/2C5OfiQDFBEtmMgHnYFym4MHucnpfTQnW2RaUu7yrNMBlTiiKA4FRIIEWIMu58ptGQkhb2cuhxuG6VQx7NXBDetXJVB5hP2Lx5Knp73TDG788dvNX+3d7Fi7aao5yG0cUWEE0RNhySDfep3K204On4X8KnzlH2LR20lxIO4l7ulU8kxJ8zKQfMb8pk3VUYWj+sw/JgKHOOkCD1sfxVYwE7IPVOVnLsshaln+6NR8GvgoZwjqcI9auoSx4iKRyxL9VB2Xame+LgvmAyje8w5BV1qBYvT/x5gkZnkm1b285NURuvCQgfaL+HGEksC+25iz/0AqxIxYY1L2cnv0/xT96ys1z5DKgH7dYCvzYPLNeGRxOtWmowr2s39r1xHOhcgnM8loT+DS50i2r6wRMJcji66uC+vb/NA1JhtCFu6LLNhu7s7uwhNgPSnPdJc1lFlrcV8o6CIKj+Vt1kV2C0qecuuAEw/OSHNHc2VJ8GYvs3pBK1mS4HtnwoC3xVITN/RJjz/0iuyn/PdnQhP6Cg4yhuBXmm1S7K7rrxXdwwKfmloXsTP56FVixffwuzPvgPy3ff+YjgiCvBzKUMTrxKEn0sSbFC95oaDtVNsUdn3EnvrRqd4DOLcemvKIwZfCczXqFycVUSmA1mwzfjYs=
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|37011999003|55001999006|19110799012|24021099003|8060799015|41001999006|5072599009|6090799003|5062599005|15080799012|12121999013|23021999003|52005399003|40105399003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OFc0TXNhcHkxbWpqRzdaaWlKbVRIdkdEb0V5cDFrUTR6blkyWWhGdFNlZk52?=
 =?utf-8?B?NUx4dXFoQTJiM05QOWxxWUpiREdnbUNrMm1zeUdwYjJDNmM3NVYyNkdaMXJK?=
 =?utf-8?B?T3hOSzRtcU5BYytmNEE5ZEFReG1kSjVZTkdkelorRFBFYnJZTWZzbFVhdFh5?=
 =?utf-8?B?Umd2c3hQd3dDamNOVDNmL0FKQ2YwRnJaYXl3NkVMeGZ0OThnMkVmMDlwSjBW?=
 =?utf-8?B?a1JobGdENFo2VkFMaGFudTNBRWhmbS9RbUJrVGJkaGtlMElyYVdUR2g2ZlJw?=
 =?utf-8?B?QkF0QW1vMzdwejJIQlRyV0hTdUZVMndlM3loM3cwVzd4TEFCUisySHdrdSti?=
 =?utf-8?B?dGJjMW1lMUZmM0hFbkhTaEN3YzRjd3VNdGluKzhNZkFxWGtpdHB6dWlCSmFL?=
 =?utf-8?B?enNuWDJFY0ZxL1h2Z25wbDhIU2hzT3hYTThkMmxNT0lBdDRiWEkzdFRFVS9Q?=
 =?utf-8?B?YmdqUzdnMVpoRi8ydS8vYXNYdCtPMkJ1aE5FTUsyTFVCTUlKa1Y0d1R5S2JI?=
 =?utf-8?B?Z1I5NHN1ZjFOM2RJejQ2NmxnRWFjVVMrUWx6Vzh6Tkc2dzNqbUJEVG9iSTFp?=
 =?utf-8?B?MTFyc0lENjBMM1BWVkNVTktrRFVaVXM5VUxwOGVSUVJVek9aNTZONGJMblkx?=
 =?utf-8?B?N2N1ZXlPSFh2TFlKem5zNnUrWUtrMEcyMXptYk14d3dGNkZTbnhEbTg5VjhQ?=
 =?utf-8?B?bnkrWnRYRGJDU2cvb1lGcUNqKzB3QTlsd1pwb2g0c21ZdlVlLzVHWHhDRm9K?=
 =?utf-8?B?eVVYWHdJR0xPOUJFQVZDaWtCTms5UHdycVF4cVFUL2hISTNFRnIzRDVvQ0tT?=
 =?utf-8?B?UTZTZGlVb0Nmb3k3Z3RGY3ZzMU5aajFvT0JMcUZzUTNtUE1NaHBvbkhtRkN3?=
 =?utf-8?B?d25aU2xhbG16K2czcXppU0d3TmNlTk9TWnBISnp0d1ZMakxsNmFscVBOY2dK?=
 =?utf-8?B?QVVtYXQyT1NONElSRnJFdEFWcFU1djZFZ0xyWmVvYWEveDYxOFdZbnVpUTM3?=
 =?utf-8?B?aWxmQlVCUmRsS2FlN0M5OWNGdTUweWEycEsyN2ZwKzI0K1JtQm95WlBPZU1K?=
 =?utf-8?B?eHZrMU9rL1dEMlBKcmJlMkNDYmFuZWt1dmpJV0I1VCtFVlN4RTVwN3N3Witw?=
 =?utf-8?B?c1NKZ2M2UFgwS1d6QUNvYlV2RGRtcmpTclhEQ1plOHhGMkNYNFBLM1l0V3pw?=
 =?utf-8?B?U3gxVjEydks4MXpxUW9KZDA4MTVuejZydkJXY2VYUHY0YmFIL05tbDB2MkV4?=
 =?utf-8?B?cGxpRXVxRDlpRUdYM1ZhUE42ZGNQSEgwYjdSVktJWklWK0t6aHoxcHI2eXhq?=
 =?utf-8?B?ZUJTbyt5UE15Q3VYYVQzYWNvWUNlNWdnaFpySFI0ZFh6c3ZQYzZwMzVXTWJC?=
 =?utf-8?B?UUJMNEVPa2wzcWI2d3JuditzWkxMSldWZUd4Zk5NNyttOEZpY2N5T0cvWldx?=
 =?utf-8?B?U0RueHowRTJsc0xoTXc4aFFDU2Y2Tjh6MHNNU1hxQkZXTnhBWFFibDdvaFVY?=
 =?utf-8?Q?9HjYX47rq91v0Tw0+546k3g5atm?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVJuVVpwSGg3M29yeGE4SjBhUE5PNmY0bHNEblJNMTgxU1AzMCtnNEJzdzJL?=
 =?utf-8?B?OGE1S01pZ3lNMkpRSHZIYXNKVktVZmp0OGx5ZVFTUG9rb25wMXphdnBKZlpI?=
 =?utf-8?B?cmJpKzQ1N3E1YStqQnhkTksrVGVBeHgwM2hoZWJYVFBUMGRuWFQrT0U0Qmto?=
 =?utf-8?B?TkJRQ0hBQlRNY1ZTaWs2Nkk4eElnYjBObE5wL3VtZWZON2FXb3hNYzZBa0o0?=
 =?utf-8?B?REwvcjdkd0FNUDQ3NHBSNXUzeFRobzI2ekNtaTdFZTZZS2QzVFZyUWxUWnh4?=
 =?utf-8?B?KzdSWXZQdVZtdHNwNUIwb2pQRHBUTlZ1L3NKMDc2SnFKVG1tcGM2Q2pzVmZ5?=
 =?utf-8?B?KzRKRDBYTTl3cCtJL3BCUElvdGI3SzEzc1FiUVNrQ3hVVStMU1lLYWdnYitm?=
 =?utf-8?B?SThUV0xvTjBwRS83T2EvV0JscmJYQU16c1ZPWDdxWmh5aEZ0cUR1TTNOKzJE?=
 =?utf-8?B?REtETFlvdWYwWExzOEh3TEpMTkVvNGRUNHFNeUR4KzkzSHA3TTVrMTR5c0d5?=
 =?utf-8?B?VFpxWVpoeC9yQUc0L09pU1VuaFNNd2RSRXVWWWJweWNHR0gvNWdoZU16ZGNL?=
 =?utf-8?B?MmpHT0pIVVlNRSs2UG1JRUdNSjQwS1V1a1pBdDRJMWxJSnpqbTNGNUdWZlJu?=
 =?utf-8?B?L0NhU3FscEdGVFB2N1AvakNYZVRaeU00TW4vRmY1TVBwN2hBQWpZS3U4cklt?=
 =?utf-8?B?TG1uUTBSVG1jWWpacWVRNDBlbUU0VjFtVFJKeldwYUdTVG0vNkpSV2dwdmtS?=
 =?utf-8?B?clV3S1BWTWZVMG80ZU9uSWthMi9HTVhCWlFNYnFmVkhHc00vc3hJMjBNYlhM?=
 =?utf-8?B?eENFSWRVNWxwbHdKRDFoZGN1c3MySXUzcWRLYWhVR2J1T1ZOMDRpNitlWHB2?=
 =?utf-8?B?MU1pcEsvRThrYkM4eGhnUkt1NHg5c3IwdEF2R1NEYWhwUXV3NWtUTE9PVHJh?=
 =?utf-8?B?UjNGVnNSUjRUcHg4YmxqeUlmQS81WWdheDNJRFRERkdUbXAvVmFRUCsrTkpI?=
 =?utf-8?B?dVFraEh3N01peWE2NUV1eFk1RVlpRWk0OHc4V01ZU1JHZ3J0UVhBYVlSMmcv?=
 =?utf-8?B?cHJlaUVhSkd3WjdsVHlQbldiUTRrYWxSQzRENHZwWDhKMEpSS3krYkhTbGw3?=
 =?utf-8?B?a1VUY1diSEdReFRsNUxpZ2JsbGU1ZitxbnY1YTI0NVllaEdBOVk1Z21JNURO?=
 =?utf-8?B?R2FmYUowemNkSk1PRmZxOW9hcFFDM21ldE5oakdTdytLY0Y5aVFRekNuNzJl?=
 =?utf-8?B?eWNTaVFNcjdZSlV5WDVPa2JVVlhibHhaWjY4UzY2Q2ovU3JGWmFGbTk1bEIw?=
 =?utf-8?B?M1FsbUJkUnMyUEdpMUl3SVgxc09zZHduU2c3TzRsRnlHZlY5am9hVXoxVWhI?=
 =?utf-8?B?Z082ZFFQMTNYaGJPclVXc1h2M21Od291RzNySDVGSFNNbG9XNGtMd3cralc5?=
 =?utf-8?B?MHZHcHJzRHI5elo4WHBVc0ZOSTB5Z25rSHRvODVGalJTdUdnbG5GRHRDbHFp?=
 =?utf-8?B?RlpFUDVUdWpncVd1TXhDd2xxbmorT1RDK3dBVWkyRkJZUUZuaWhWZFZqdnhM?=
 =?utf-8?B?V1BVNWs4d21aZHd3VjVhV0ZHVklESyt3NDIwV2lJVWMxVVNObVhPeUtJUzAx?=
 =?utf-8?B?b0k2QkhUTURzUnduVGkzbmtCc1hxcE9rNzU1cVZJS3gwT3NaQUY4M09jcFI0?=
 =?utf-8?B?WUpmYlFnQWlVSzVWRjZ0UkFPTWdFREVwQ3JCRlFwUXZSTWg2UEYzRVV0WVpq?=
 =?utf-8?B?QktzUnNxdFFrZWM3VXhsWUtsYXhaNHlZeC9NVEJ0aC95b2VpK2U2UWE4Uzlk?=
 =?utf-8?B?c2h1YU16bmRPR215aDg5emRtVlRJR1h3d3VoVE5rNUozTSt3TEowdmdobDVx?=
 =?utf-8?Q?QHXyeTbZHTwao?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-3927c.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: bee25d74-0e5a-402f-e2c3-08deba9eb68c
X-MS-Exchange-CrossTenant-AuthSource: BESP194MB2805.EURP194.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 20:46:36.4919 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2P194MB2069
X-Mailman-Approved-At: Mon, 25 May 2026 23:59:46 +0200
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

dev_read_addr returns a fdt_addr_t and not a pointer type.
Replace dev_read_addr by dev_read_addr_ptr.
Check that base pointer is valid.

Signed-off-by: Francois Berder <fberder@outlook.fr>
---
 drivers/clk/qcom/clock-qcom.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/clock-qcom.c b/drivers/clk/qcom/clock-qcom.c
index 6b46d9db744..e238b76d42e 100644
--- a/drivers/clk/qcom/clock-qcom.c
+++ b/drivers/clk/qcom/clock-qcom.c
@@ -489,8 +489,14 @@ static const struct reset_ops qcom_reset_ops = {
 
 static int qcom_reset_probe(struct udevice *dev)
 {
+	void *base;
+
+	base = dev_read_addr_ptr(dev);
+	if (!base)
+		return -EINVAL;
+
 	/* Set our priv pointer to the base address */
-	dev_set_priv(dev, (void *)dev_read_addr(dev));
+	dev_set_priv(dev, base);
 
 	return 0;
 }
@@ -564,8 +570,14 @@ static const struct power_domain_ops qcom_power_ops = {
 
 static int qcom_power_probe(struct udevice *dev)
 {
+	void *base;
+
+	base = dev_read_addr_ptr(dev);
+	if (!base)
+		return -EINVAL;
+
 	/* Set our priv pointer to the base address */
-	dev_set_priv(dev, (void *)dev_read_addr(dev));
+	dev_set_priv(dev, base);
 
 	return 0;
 }
-- 
2.43.0

