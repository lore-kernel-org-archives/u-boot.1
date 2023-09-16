Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 750C4C2BA12
	for <u-boot@archiver.kernel.org>; Sat, 16 Sep 2023 19:37:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA9F68585E;
	Sat, 16 Sep 2023 21:37:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.b="lNAHDoDp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6D40833DE; Sat, 16 Sep 2023 21:37:06 +0200 (CEST)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com
 (mail-tycjpn01acsn20808.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:7010::808])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB7928477A
 for <u-boot@lists.denx.de>; Sat, 16 Sep 2023 21:37:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=wiagn233@outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ot/XCF4DWFKzhUK/jjPITtIq8VlH6cQ1qYpBLrhDLmo1FTt9yubxYetVjiqYw94/qvDi8kVUUQsUKzU8fVjiynbB4dlSod3M+HIGUViqKt7UqAcctQsG+aTbRLA5fm4DHRjjNbpiheVwloTNHYlU4P8VZ3GOWJp+RXQ9ANZTGtSD72VuBiBJcP8Ivx49Qek+FWm/gIhf4eNEqOPhFHA4cHqHT3fenQcYpSlpvKQXWgeUlsKc0rVDy9K9meOyC5h4+9eVamQbluVNxxeiJ9gQDWEmr+pjCkhFy+JWZjWphqb7dZcj9VkEUoMOssl9UmCkMCG17zmXDfug5h9dvXWbRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D+Wa78yGFiYASvSMKp4fAQ9e+p2jC/5zTHX9CWTbyxA=;
 b=Lpp3n0ybAyQf5pV9o4JmPEXcKJoQl67qeTjPz/wFti1YSpTEzLWoD0xqgikXvyy4+lEFYenuZwVFxfdaBmOLYoL1y5EpJDeoDN1Hx8F9E2a8/kJS8Og8VBch6jpAOuGy1RRjKleuHvYSLiRuFPw/IfjAfDgIFBg7aQJelQGugE74kopeq6cvzVsjEMybT7UADpBcGn0zqPSLcZ+yh2porRKvVJVhoZB2TapneqQnyVU/+E6b8XCGKBzGqFHQ/vNV6GdWky2EOj03FoOeRt/tL+EQr1gQAl6tmQZN9cV/0MtcAlRC9TDOTPjTu98t6QhaVuokucxhlA8okUXcKWR+JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D+Wa78yGFiYASvSMKp4fAQ9e+p2jC/5zTHX9CWTbyxA=;
 b=lNAHDoDprlvaLMYGpBa3m2kNat6Ihpw+L9dHFwlkcR/e2o9LqqQUYZNWLRdKhzEiTa3RdwdYRoxA6fsa+NIp7jA4rt2aPOd8/EcoYKIEOtj/t/MIgV7bYl7YWMCZ9kEWDhXm8l4HBcL5LhOf9Srlqus7SOY1VVwQRiBMLGuA8xbFwO9gTmB0EDL6ZHAJDHMclLZhpS+56H8a2JLCa9hkrC7nbyRGL5Ly1yAvoN/Picw+gPCdbfbAgshw/RYVfKdPOJ2NPOTrwIgIQrOa3ig1+h9Y/eUwwDnyEfBUfKBfqohpJYiL8TRmSmOqj6Llsj5vK/HHXme5OllRmGEACY296Q==
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:23e::10)
 by TYCP286MB3132.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:293::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.13; Sat, 16 Sep
 2023 19:37:00 +0000
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::bfaf:cb8:24b7:f67b]) by TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::bfaf:cb8:24b7:f67b%7]) with mapi id 15.20.6813.013; Sat, 16 Sep 2023
 19:37:00 +0000
From: Shengyu Qu <wiagn233@outlook.com>
To: rick@andestech.com, ycliang@andestech.com, yanhong.wang@starfivetech.com,
 u-boot@lists.denx.de, jamipkettunen@gmail.com
Cc: mps@arvanta.net,
	Shengyu Qu <wiagn233@outlook.com>
Subject: [PATCH v1 1/2] configs: visionfive2: Enable CONFIG_OF_BOARD_SETUP
Date: Sun, 17 Sep 2023 03:36:32 +0800
Message-ID: <TY3P286MB26118386C9AFBADE39E736B298F5A@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230916193633.3928-1-wiagn233@outlook.com>
References: <20230916193633.3928-1-wiagn233@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TMN: [xsbgDv51nGbQwT5DF1f37AS/59zw/dc0]
X-ClientProxiedBy: PS2PR02CA0007.apcprd02.prod.outlook.com
 (2603:1096:300:41::19) To TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:23e::10)
X-Microsoft-Original-Message-ID: <20230916193633.3928-2-wiagn233@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2611:EE_|TYCP286MB3132:EE_
X-MS-Office365-Filtering-Correlation-Id: 4501b82d-5592-4dbb-52c3-08dbb6ec4bdd
X-MS-Exchange-SLBlob-MailProps: ZILSnhm0P3nGuO75oxpEOTfZ3D200KVorA+0vWii7F50eRUoTW1zVg4wAVEbvntH8ob0C6H+V4nBXA8cW0et0ptyklrKOpmMM1ni0vevJfmh11Ya6js9DXGVeLm4GA6eyCwpKDoFDsDmexPGmg06i8ZvWTb4Aw+LscQGZspqScghpCzC3of6DtXScmDwFZuPKshSLa8dAFAS5gbheCnVB10/uLsgApDhl9f/F0yQBwPaI4g3HDLCydMiXBDfWvcrOK8GSJONjMmOD3JYKxwf613KLeM0uNuFEtdIeQCNwV80YHujO6ajbOzzb9aPgjWJKiQCUxfWuVYv/eTOKiMan98S1rmjOXzGT3s6P/6Z3MoIKzAAMtbOaYanm7SOZ+DanGhoKlICZau+drrEEP1q1UjGREShCqomTWh7KViQW2RA3F47yY8jDlY50TIwyeufYcOLPoQLi16Otg2PreZaEeKt4ciDxQjXl9JexQ47ZAxFcF90Dg6LYT3RtOiesQ3MwrKl/AJTwLVEd4Lsdpk4SoxAPS0FUnQdac6gaPKHHja6cMSyo9WvMaoQcNE1+/MkW7QUZ7Xc1zzTMfy4Mbu4LI3lcih0yZR+W5g//sPX4XXsmqQoTRaW2h9O3vX04AHzLYWIbAFlxbUAs3bjnUoSRwcqPdZcmei74qCESJZsxIwz6fWy3CXgpC/JBH3jYoQvoRo7FHSihRRbKVYLdDOChe7fy1HRpWJJP7HevdlwjoszCF3YOpMMNilB40nMQEPxKIM5OeBy6E9IyMxarXv39DmTft3QCVGI
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pnv0xTyk3tAEeXnOnJcgmFBXiIdMg+zt38E9fHwY1k4UxRPrl+2hf8WjXGS/Z+1vG5lys71WNteCQdU1OAY1e3WVnw3BVzVUHVyEGZ5g4f2KEvlCaCBcNYiycCiOsv0pbtAyFUuBJ57OoM5FON7hLKRxiLdrpVmHBlPOAtkhM5m/sFdfzDWPadTzu5Mx0dRjWW5oElczbplQn/7csiTeDodWivSAsZc1j6NUZ7xrgAsTEZa1EnOBKoPN/TUoKHUbfw6lNg6GZqPNqAFOdef21AcJMtaXE8CfP+XfWHZ1Uti0iU7RFYXpP/GRZy1pAbk8iOzZ+LVgvDuNPIafe3hor2R8u01nZRmFfUy4SpQz9HdZuszBVQShDQj0ksn+dhlQ9zB/iAOfDQ61evvZ/EK2DmmG6CXuq1GDZTwnM1pAepbsEQueVNGulCUiMQqMS3ZAFMcvr/47lIWVhEQ62hp39g4EBBWDPF2CEIdfR8kMQ17sQNL5vvPgdpzTwH9+6KQ6uCZj+uyqbK8EG7V/rTdKps+Km3MwARQxSZNrq6uCvU54TxQ1/nSREjx4BsHmimjMbKP5r0BxnzAHbZrmNZVEbJt68ODl+kAZ1WwN4PLDzbyIXKuwBS3VqUcvMCzMXdRU
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QzBRMXFzaTJkWHFNQ0hXbWEyemU3czNVcDRrTG5MWW1NOWIwM0hKeTVTTStq?=
 =?utf-8?B?UWYrd0g3QWo2enNBSC8yTVNoRStHRituYlZGK295OURxOGpSd1FzNE5oNjho?=
 =?utf-8?B?MkU1eVRKVjhabjdXTmY2NTJucDIwSTV4UVpxblhtdUMxWlo3VWVXWDEzRi9z?=
 =?utf-8?B?aG5mU1BPK2IraXJTaFhOYUMzZ0RSUDVlY2pBOUY5S3NqTFA2Sy9yczAyOUlL?=
 =?utf-8?B?ZWo0aGt6a2xRUFRrUTVWaUE3TUdZbVlpTm9Nd3lwQWJIdno3VWxoL0hsR2tY?=
 =?utf-8?B?Q2FWQ0NnK29kSUJISEJZUm9UT3JOb2hPUW42YXJTekdmeFhialF4Uzl6WThC?=
 =?utf-8?B?VS9oYy9hYXY5aFBJYnhGZEsxaFkvbWNiN3NPQjM4SHg5REdVTUlPaTNRMGsw?=
 =?utf-8?B?M2Q0WlZiZHY0dkhyY0hxclN6cFdLMlB1YkZGc3NzUi9lWXdQM0l6SlgxeWcr?=
 =?utf-8?B?U085NHNmZTB5ZUVpZGRBUVV3cFZVWnQvMzhGVDNSeFFNNzk3RFpvQmhJeWgw?=
 =?utf-8?B?bUF5ZzI2VCs2ZkRrc2RVUXQ4aENlSjcvb0RiRk1Bd1k4YU14c0hvd0lHcEtn?=
 =?utf-8?B?cUV1OSt1S0ZNSUZiZ05LT1ZXM0t5NFJzQmEyZnJMLzRjdlhnVXVBb0tpZXNV?=
 =?utf-8?B?ZXQwcXYvelFGb3pnQlJma0dnSnBMVjI2eEhlNDFmM2JQU0V6OXp3MStkN3J0?=
 =?utf-8?B?TkV4WXpHbitmcjhhb09obFYwLzlEbC91RUs4R0NhaGhOZTRNVVlvNXdHUVJk?=
 =?utf-8?B?Y05pdit5aytPQUFaQ3lsZFlscHhnazd1UG9qbUNzNUp6eGVhb1cxbDNLeVBG?=
 =?utf-8?B?UnNFY29HWXJMdWkzTWJsdndURlQ5VXF6ckNBVFZIQmZRWmNRMzMzQWo2a2xV?=
 =?utf-8?B?UkRyYTNLYXk2WFBBY3dpV2dKYXpGMEd1Vytmd0RUdnRsOVJFU0xCcDhWQ0RJ?=
 =?utf-8?B?aTRURFRGRFZlenZQSHkxU2dLN0t4RlhRM3dxeDBjZWp0YnZyaE10Sk9rVXRC?=
 =?utf-8?B?Ui9nVGxzTjZDR3FsVll2YVg2YUU3UzFiNXhrTlhKMmtsSkQ2MG5yQnN5c2Ru?=
 =?utf-8?B?UzBOSXBtZVVtTVdJcmlsQUxGemU2TkZWcUg0OUJCMVF0VWlBZW9CRTBHOWxh?=
 =?utf-8?B?M2VmOElzemtVcW1qY1ZGMGtTcVZndDczYU1UeTNZRmRxWVp1cWx5Z3dqdWtB?=
 =?utf-8?B?RDBtZ2ZIZVA4RWVkdXNwSGRSNS8wR2pkTWtQclBkTm1GZ1NZUkE0NTJYeGdG?=
 =?utf-8?B?MWQwd3JOQmlXM0VCTXZ2RjFYamlIMlFQSmFJRDVEUFpDTkF0YmR6V0t1Z1pH?=
 =?utf-8?B?Wm1HZzhvNTl4OTBxbURhdE1oSGhSQkZhdnNiTElhMWFQN0hsWFhiOVo5VUFq?=
 =?utf-8?B?UjhoNXhEK09aZVNuTmtidzJKZ1dLSktkMnBFQStQdXZqZjJGT1Q4b0ZYVDNZ?=
 =?utf-8?B?c1Z1Rm4vckpYWWVrbGtrUDkzSkFHckxRWGtpVjlUQXpMcGFCUTJBazRzcHhu?=
 =?utf-8?B?MzUxdEhMZW5oREYvWmFnLzhJMGErOVFjRUxPNFJqVmRmeTNtSTl1ZHY3NCsw?=
 =?utf-8?B?Nms3MytiZEJ1SUUzcWFhUHRGcW0xQVRqc0ZMZmw4bDJWNHU4STAzZldpbWtO?=
 =?utf-8?B?bnh0U0xBMStZOHBteENWMS9UeWZyN0E9PQ==?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4501b82d-5592-4dbb-52c3-08dbb6ec4bdd
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2023 19:37:00.7479 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB3132
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

Enable CONFIG_OF_BOARD_SETUP, so we could use ft_board_setup() to fixup
memory size passed to kernel.

Signed-off-by: Shengyu Qu <wiagn233@outlook.com>
Tested-by: Milan P. Stanić <mps@arvanta.net>
---
 configs/starfive_visionfive2_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/starfive_visionfive2_defconfig b/configs/starfive_visionfive2_defconfig
index 2376dad538..4d1459a3c2 100644
--- a/configs/starfive_visionfive2_defconfig
+++ b/configs/starfive_visionfive2_defconfig
@@ -36,6 +36,7 @@ CONFIG_SPL_OPENSBI_LOAD_ADDR=0x40000000
 CONFIG_ARCH_RV64I=y
 CONFIG_CMODEL_MEDANY=y
 CONFIG_RISCV_SMODE=y
+CONFIG_OF_BOARD_SETUP=y
 # CONFIG_OF_BOARD_FIXUP is not set
 CONFIG_FIT=y
 CONFIG_DISTRO_DEFAULTS=y
-- 
2.42.0

