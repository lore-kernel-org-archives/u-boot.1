Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6BCED1F9DD
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 12:56:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2079840EE;
	Thu,  4 Dec 2025 13:52:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=hotmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=hotmail.com header.i=@hotmail.com header.b="i/t1Z7rw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14B5284033; Thu,  4 Dec 2025 13:26:51 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazolkn19010006.outbound.protection.outlook.com [52.103.33.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 225F883B4F
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 13:26:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jackson.hener@hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C/jo8oOo9LMiTIIUkRmIDlSMQEB2I91icpttPJOn0Gw6jkXPel7DnmhXTyro36moDdz+vtRVyykwgAj02MZFWNW5EQJoU4B60Y70u1cuhLxaGaqnto+z28rBwZcWBl8X8241xkoEDiCXDmxNB0BfnAMpSH10m1VxuJn4Widby6EPwUZ0bL7iQBmFk0UiPaL13tcI12VPDs6NewZYRf+s8pkRlBraVUFPQSeHAs5et42tZQsC/L8qm/rQw1d+UfPwmSPGVMO5qpRRIvwPpX27FshDT3BX6pmcOGMwxN2fnRzzuQnS4ImKmccEwZCIQVB2D5fDvi1G2qwDcy6pX8LpbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aqcnC/xvt2LLja1hY2QoGczJd74KRGeXiFiIaVsZBMI=;
 b=Yu7ZrfpGnwIustLHyOYUNQ3E4bS+5VMyVBj1zzlyJIKIyzI0ErACi0W/J3V8JriWzzJJB7FtarYYDO3jRikJiGY2luLg9V35YRE6gyBIsDOHRy/3gWBxrkgB8cajGEpsrbMFoddnZDh9DB9YmmnRy/Gh92QH3R2pbA8baFi0qLIaOdDZEqxZfTjGfjXYqVwAG0UzlGuzfgBITCealV4B+ROr0robYxEKaNzVdzRD+zqVSLEXhdtwVWnY6Z1Tjfks8zczcCSkVBdeJPOfQpScX7ClDBSR3vHL3pSzohmXRfdibcQcmjrlIBBubPap1C5AAp7CU3HjoVFgR6/7NocZCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aqcnC/xvt2LLja1hY2QoGczJd74KRGeXiFiIaVsZBMI=;
 b=i/t1Z7rwcKZbm0qe3emb4o9B0eUC/BEdAyZHcwpL9yV1rwGQUgIDSXfGTBWW9NWv2gh5N3CkMhUHArdlhvldf1YMcrmXZgC7FjVZ67frMsGPOo6GNXZWrisBz5CjkxAKC7qL6809UISfzhyQG5uDb6ceS8gGQhJccB8HZwbEAo5tEQZGIpxcqlTl1B4t7ezMvrCqcnN+/23LOotwEZZR7SsYQ8iOk89OQfeqdJ2i+1ga1qTW4LMjpPQFVoJwUCuowOEoAnKLt6o+mKmNbt88C3QNGz9rQpTETFoSttrDEHKs0IUqjgGIJ7Z7dTiQBalCY4CttGPZz3jB0Kfg7Yrkbg==
Received: from DB8P190MB0778.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:125::23)
 by VI0P190MB2210.EURP190.PROD.OUTLOOK.COM (2603:10a6:800:250::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Thu, 4 Dec
 2025 12:26:47 +0000
Received: from DB8P190MB0778.EURP190.PROD.OUTLOOK.COM
 ([fe80::1f83:e865:8570:a788]) by DB8P190MB0778.EURP190.PROD.OUTLOOK.COM
 ([fe80::1f83:e865:8570:a788%4]) with mapi id 15.20.9388.003; Thu, 4 Dec 2025
 12:26:47 +0000
From: Jackson Hener <jackson.hener@hotmail.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: SuperSpeed on STM32MP257 - Comobphy
Thread-Topic: SuperSpeed on STM32MP257 - Comobphy
Thread-Index: AQHcZRky18c60ZF5IU+oaExHkuO8XQ==
Date: Thu, 4 Dec 2025 12:26:47 +0000
Message-ID: <DB8P190MB0778B0445D811B2A713A66BFE4A6A@DB8P190MB0778.EURP190.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8P190MB0778:EE_|VI0P190MB2210:EE_
x-ms-office365-filtering-correlation-id: 16e78d34-82bd-49e6-3b9b-08de3330647f
x-ms-exchange-slblob-mailprops: XL7il9rKhFf7RSshtRyX3dBCcSd3T3vTcRciOlCqDCwSyMH+CyeMkpCX071MkFQkx/YadN+evXkozXSzrm9rdmnA/3TqDVT2H5Fw9P3oMmNtuQYjA/NcPwHwhjkBz+zT2EEm8IbwYKXyhR2jGIxWpCmKBEZpmBtgYaqsfFmWO8yTN2sWTl/ywmUYeErF8gD+yT2tmP9rJ7wEK2NfCcZ2H+DLuoO4faztZtDAd1JayrdbpMMp394hDR6jal+vtZP/24rtjoIEiT0O2+v8qTtXtJZ3y9TH+M0EUtey7PYEpWpTHq0e9ESnKgrka2seYifF/TBfh4LP9GHVSEgeBy4F2xiYMz+dnLyaIh8UTmEpx52vRVvIExnjdpf+DIqBljulHAmA9DSfgmuWrnvU0U7z/N/4okfMbP+hpf/vAL0woCqcuT4jNpMmA209VfyeV8c/UPfL8ZffYIWLiYFxBlTbo3PFa2SjEgMNcgZLh1F3ts7TodCmRXoOaGi7xLKiMhSCpmaVbLtzThi1ie4zH7VXoUqwS3bH9r4KjFtPmow53/WFHq110Y4G7+YoWA7Z/LYyiPNwHmVe1AnaXv+q1zWQjhn0SV+TCd55uk9cFaL0r6yvLloKEHBdVgcPS871j5g1CBooaZCJFZ9l+6XkuFDCqg==
x-microsoft-antispam: BCL:0;
 ARA:14566002|19110799012|8060799015|8040799003|461199028|9112599006|15030799006|31061999003|39105399006|8062599012|3420499032|3430499032|40105399003|3412199025|440099028|102099032;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?vJH2qJI55lqDfbwtk1mn5inAaheXM/O6gFBICpx6FbikwZcPX6RezDa1VE?=
 =?iso-8859-1?Q?vV1U10ls0z6XzjiDGvpsaZzI/Lre86ZENloJG7epz6X7C2ps1vgtjoEu6G?=
 =?iso-8859-1?Q?dUIW4cS7YLFjlEIl0bho32jOOs+BNU4ioiDNsD7Z/xnSV84lV1eSE0rOI1?=
 =?iso-8859-1?Q?F+zO7xw10t+UbosC+ysadusCjswauIiSAsGWKW57mNk1fcy+U3AEwsum/M?=
 =?iso-8859-1?Q?bZ4F9tD8g50N8MJ9k+FPwC5s5BfqP3Qlx1nIrnaBKV3i13rCIW41XaNAfL?=
 =?iso-8859-1?Q?3ZVxH/c2VRkmOOOVF4klsqHXjEtoU6t/fvgFZguu5ORudk4euqtfR1dKIz?=
 =?iso-8859-1?Q?dwxHcE8zGT/xkPgwpUcqdRdaRoHeQcBpK+7rcnkGhtPWGeOCOG2DGoPIZZ?=
 =?iso-8859-1?Q?lfP/sec8crupgfAoq7AhzIsYSMcoiAtd6pHB1D9HyMrXrpz9GE84GsKaAI?=
 =?iso-8859-1?Q?PONQOv6jpYL2uKjhyiYJcL3pWYhgXkGBktr2X+KmQesb50IsysqPZPQcVF?=
 =?iso-8859-1?Q?9suz+dXP79ipgDItnFJjQvZULiDCEdXcCJRQqcNIn3xTlwtLNTEskPxAwW?=
 =?iso-8859-1?Q?2ipajnq1BhEaWUEUOMKh7/DvXxdN4QkwWVBQC/gLDJYlAP2o+PAp5vOtD7?=
 =?iso-8859-1?Q?YHEO5NFtlTjCVF761w0uValiAPcNIczNbGs5cWxLvgVjAbokNSETxsela1?=
 =?iso-8859-1?Q?YSqmuB6QS1xACtsrHGMrBceRcchuZJuL7xvD+ky/R35VCinF5hs8Ap2na6?=
 =?iso-8859-1?Q?Bb0LuWWe7sChVMNtUCfppNj38ucZVP7PqxN+geKvFCluHO7c8YHs3qGRyN?=
 =?iso-8859-1?Q?BS5BNZusSDLv9tgI5GGEfKdlMYZpybcKe2hDHP8gwyqzcKTJO/jlMj9LkI?=
 =?iso-8859-1?Q?+KCfPHe8RnXuiTZISXpEhN6XjCRkre0xBaantkf/VTbuqXC0Tn9QypIsV7?=
 =?iso-8859-1?Q?3CB9tJy5IydR7Ot0kg4oz4XI6mlUCImyp2QHYFcfU0pbZ19yR7vRdqs6nt?=
 =?iso-8859-1?Q?qNe4mA+PycSYCW+rpMxb4Ocl3xJHEwdxlWxQosRDn7Z0ELpyg2tlBeG05w?=
 =?iso-8859-1?Q?EGzobHlCGbAwPsCW6+ttVCBmOqdDZVGX9nKwEB000CQK1fraLM0edJ00fL?=
 =?iso-8859-1?Q?saj6NFXK5BlbfQg0rpisvo+BEuiHtPCZfB3n1tZR0GlYJXlrfucfdwXwDR?=
 =?iso-8859-1?Q?KaUDQ6S3OvzTQbZ9QtUSyjKZOvXYo94M+4id7MMpG+0JvXNjjiVLXKvQ7j?=
 =?iso-8859-1?Q?9xHSO0F89YuwFWkSsEzO4D3Re2C9FcLwVFSUSwIDI=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?bPwXAL18uOEl6fzPcrOryPUn4CLI+EjWavK5+hXLu4Y7ZyrpHWnNCB0vM8?=
 =?iso-8859-1?Q?71UMEaELP9phLd/vUbFgg6ljtEN9kKEJP2+uO2fUAonfMBlRR5+T6sB5Z9?=
 =?iso-8859-1?Q?b1TJ91HkGVb+tFy/C7VAV5yWD15WrR0VsPtYB/YseN4SN9JfuHHcL294Mf?=
 =?iso-8859-1?Q?/5jOSqY/M3DKw9gVns5i/1N0tjQ+W/nKa8y9LrEAvSDSpJFPm7rl0OpXtx?=
 =?iso-8859-1?Q?hT6IIJNhItgMxbz7mCZoUBU/ezU8sxTNAUat5RVAdHAC+H/5eLdstx9RIh?=
 =?iso-8859-1?Q?uSTF/lgKqX42Qt+OVEqXTjJRI/ho2orF2wY6SVy7465LZ94/q8rvmgU6KP?=
 =?iso-8859-1?Q?EvHQDWirCFVhwqW9H99AnTQA6OB0IBeRzQqjof2F5/tzw3dU2r2WqaZ9WC?=
 =?iso-8859-1?Q?Jp4Ff1dJeLGOjRKuEHPT0t/9oLEOqq/BiTaGJV9OCk67TUs++kicAUwYco?=
 =?iso-8859-1?Q?MKcK8+wryDCn1deUrIqJiBzFv6VvPRFZmpuTz/TUvSDev2D3O3qfzrkYtr?=
 =?iso-8859-1?Q?RzZeRAqpl15eq+Z9jqJHj/TqOHZ5vZ5VbPyCKhEbOzMLuN6w9v1/hi5yh7?=
 =?iso-8859-1?Q?tNBx4JNHqGlvU/x+k9s1ZJqGhP+6C4PjeIUc4tVdxCiyt3ncsQYaTYBdDa?=
 =?iso-8859-1?Q?bz6b24AJ9RK9EzCJFbFG6KTFrKIp0meNmvIVmBIW0Efu5oP03Tvll7sqA2?=
 =?iso-8859-1?Q?dumaLAxcR1tg258/9MAfXnYB9pVJotyhKU/RyeyAtqaha9ToAqzt/SogRB?=
 =?iso-8859-1?Q?OL2TN6I/x5BWNfper+fbLXq0Gbes1ZtAsVvBnIboVfQNkSU3WN6WFyoFWM?=
 =?iso-8859-1?Q?HFX8q/STqpnHsQQX47dsfvfb84a2W5d5RG8Lze5POe1QHjo8WaiFc6Cj0y?=
 =?iso-8859-1?Q?ZJFeY1YFyp/b3uRJW9KrsVuTV+kVtU6pFxv9fRAQhxFMrjv7n4qkd8npP+?=
 =?iso-8859-1?Q?WLMc644RMYXNVWa2T6yGhHTbc/ECBTjtFtJ8S9jWD+cQDYWmd3txzQdDrZ?=
 =?iso-8859-1?Q?jAU/vrgE1CCgOv4kH9j+6qiIzoEIfcYr8LwIgl72MLW+hCvQcAHxbgwrW+?=
 =?iso-8859-1?Q?m3G+zQKn+fkIN8LhXbHnfHic7pvNyO8oqRVy6Fw7F64M7FZqDHZODKHFRn?=
 =?iso-8859-1?Q?mgsTeOhEh1Tgw8R0H0laYiNZJRdxBgi1Hdlf+kViRgGwrbVD9DCJrw+LxB?=
 =?iso-8859-1?Q?5YjAkIQbtZmOx52kX5x7HEiSbDFy+WJAy+7dq9vjXYUxiKCbhabuSyHS0x?=
 =?iso-8859-1?Q?57k0c/L3rz0sh/dlMEZRs1arAuk1UO+sdRUXtZi5E=3D?=
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-8534-20-msonline-outlook-e6540.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8P190MB0778.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 16e78d34-82bd-49e6-3b9b-08de3330647f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2025 12:26:47.0636 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0P190MB2210
X-Mailman-Approved-At: Thu, 04 Dec 2025 13:52:18 +0100
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi guys!

SuperSpeed on STM32MP257 doesn't work. Can you make a patch for it?

Thanks
