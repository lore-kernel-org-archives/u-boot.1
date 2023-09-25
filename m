Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 070A0CE7A81
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 08:10:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4AE4486BAD;
	Mon, 25 Sep 2023 10:10:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="eJF+a1KQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D48A086BFA; Mon, 25 Sep 2023 10:10:11 +0200 (CEST)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on070e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1f::70e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2088E86BA1
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 10:10:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kIYnYlD6ph6ZqOOgdx5VboRUW9ibu4oebqThx3Ezu3FgX80YlIDbEq//slCi9OaoJjDoc0tuO103QQCqi2c/LaadYe6asWVgJAKgZv7hzKlI7eDf7o/Xk0PkqaO+aOSOCD7aKMS27uXHGhtQeLim4l1kZW8YhNlS+VnazVPwalYyFsO6JUQiZZ94L0Go8E7AxA21JA184LGgqTp8E25BI0WM9nCpNcWkarc9xkiGvI2bwzxM3xTzNkerkuMxpa+iGUwPMQouxprqlEXZeNqiir+HsEWp9rtFO4ftBKP5qNjFV/fxrnYbPcFp11vvjv0kgL1IiaRPA8wJwSJKHdOCkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8scoBFv7CJOD6i1ACGmWNTwScRA1iP+oQeOpU+ZsnK4=;
 b=Dpy3mMXX1Fh4m9RN/3o2lWCPW87Y8t3fuRViJLi2g+lfmhKv2zOMB6U8R3FD2LymQRuGHr+iSBwXd+QHVMcCyKBYpFdk8pEk+NJQDcnGkeLdHQOyOLNN8VKopieQc/t0ckKoDaVWLmOUjluo0GeCR7jJV36719gogeimoQYE8q37yHvcoBVEd3PJKeA9l+AADU6/mbRB2ouuca4SW42WzvsFo7brmONndB+Nm5QemuGXlDatWghofJh+KZty6j+tZIewYssPWkvqXerP+MgmLSW/Pl1WxGWBd3sH+f4capDV+TnUXSGcfuYurIdZGb9LQ6q1KfZQ6BQ60bO5HpwQGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8scoBFv7CJOD6i1ACGmWNTwScRA1iP+oQeOpU+ZsnK4=;
 b=eJF+a1KQPwpPeq9jwsrF4P2Fkvj3o+2xeBxgr6hKcffk25GhPrR4VkGo4FhhpgvJ2ey+BK0IOeUxr/s8ldad6BHVFsraBqgY64XBFaHVRl9r1gx+Op8wH8IfzOAxx25W5188JXCY9AU1NiARlk3Lk1bCXTXJa8E9uCZRGAyJtfc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by AS8PR10MB7399.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:614::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 08:10:06 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5%7]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 08:10:06 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@denx.de>, uboot-imx@nxp.com,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jan Kiszka <jan.kiszka@siemens.com>, Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH 1/5] arm: dts: imx8mm-cl-iot-gate: rename overlay sources to
 .dtso
Date: Mon, 25 Sep 2023 10:09:05 +0200
Message-Id: <20230925080909.365098-2-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230925080909.365098-1-rasmus.villemoes@prevas.dk>
References: <20230925080909.365098-1-rasmus.villemoes@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR04CA0007.eurprd04.prod.outlook.com
 (2603:10a6:208:122::20) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|AS8PR10MB7399:EE_
X-MS-Office365-Filtering-Correlation-Id: c1ceb906-d26f-4579-8bac-08dbbd9ed3e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NzDmj39B04uWY7FrxwwdZ7bND6gBu9btjPH3YbAP87P5MQ7xPfzEETnDI+jbxN4+/eHWr9mqlGFOzdSMwAZfioVsxjzyCsT4VN0b3x6s2KCc+poj6VtR9xWiDRGlOQRLx/j6/OLPORJevXJdhEMJAd1ANgBMfDqKCMRdMDogmaN/VkVXVi+1JsuledFU6Gs9geat0MojZqseYx8aIj3XZYbHfy9PKMofYMd6BcFLb0347v7emXXJkC2EH9p2jSOl9NOfPX4Xc0n8VjUXc6b7dpFqNA8xGBzfrofU0zOHOT2NxIzyrorPJe3IWRl8nrMNk3komfVsPdLkMSPOLcw8lO24FOlD0Nyanxf0bgR6MJDOjvX/J1LP2qEq+Y7Br8l8lZ7GSHr7U2769gdMmBjyliD5EAmF+fqETroeiOvLtbiDQrNGoZk6qebLL1mBp0HzxEea/4Fi8sBYn3rGFmlfY26PML2HcjCaC7mFPQegQfXnhJKG4k7tceCl/w/zULIvHi7OrFTCdrQ3ntQM2HtTh9+wKNob4bZ+28dnN2u6I3JHf3PrdBrEHhA9mBNapbdiOlMIBztuknzSzX2UQ5jAWVL+ZBQy8jAeSF39Zrg6DMpqDWqWf24h95zCGWR/s5moveyXTzffdQz1P9dJ8EPwPjXLu9vqFRcjTmJTPO8RC9o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(39850400004)(396003)(366004)(136003)(230922051799003)(451199024)(186009)(1800799009)(86362001)(36756003)(6486002)(6506007)(26005)(5660300002)(52116002)(6512007)(54906003)(66476007)(66556008)(66946007)(2616005)(316002)(6916009)(41300700001)(44832011)(1076003)(107886003)(478600001)(4326008)(8676002)(8936002)(8976002)(2906002)(38350700002)(38100700002)(83380400001)(142923001)(32563001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ui+kpNtQo9QcqeEgQhaRgPaA8cbvhzt3a/fPNtyGMLHe4B8xVxcrR4Oj7wCG?=
 =?us-ascii?Q?fv07bEz18TKkuYkFiF7isWt0Zv6Xy9yGIaIL8iwCsgScuj2MKK7HPiRVgFmF?=
 =?us-ascii?Q?arvq4tOQPKrmBEHSCDHYchFzoc9Bpm7A3HzWeONVbyPCPu9KzedKac7YhCB+?=
 =?us-ascii?Q?0r3DZjQhpwAaKAsEBrPhsQOLptCpYTtodgD0Lq1BlpBdc9X69vtc0KNEWdki?=
 =?us-ascii?Q?J67MwDUT5/PjKT8Xn/hWA8CuOp0p/+hHNEySGXIRC3RuO2ClYTt8OcMQGkhx?=
 =?us-ascii?Q?q7iKxqZ4a4iBs0rj2ZT9WqJdPtFXlu5cLbM5JnyNk0qFNqpLV2HkqhhaOK7w?=
 =?us-ascii?Q?SiW/5XTmWTUOLECLIzjY7CWjI8sMs6/2Wc0SRheUTk/FYz5Uj4+yVWtfLo1D?=
 =?us-ascii?Q?e7sq5BfmqIClVR6z1bP3J3IJxkNuk8TnLu/K+flF1mquvDBPI+5WPnvAFYi4?=
 =?us-ascii?Q?Dbn6N2pNUFu3pKJLaD4oINAxnGc1ZKbw2wH1w651fw3cg637Wui88O6WaRNz?=
 =?us-ascii?Q?/MDyb+fwB0lVgYi4P4bBDA9P41JQq9i9x9wUiURVXvNdb6Vo7RvPz2zrgNz1?=
 =?us-ascii?Q?AFFdmKlyLFd+L1JR3+AHxLC7icZxUuF/hrc7rBSQG27dMs/J8cJJHVLfqzqa?=
 =?us-ascii?Q?sH5bnd7qtMKyBXwnO8id3CMOQoh1luo3Rgmb25y9f6nMQc8lsmEU0W6McmTN?=
 =?us-ascii?Q?33MP3COKWEkxmzpN9KDTjsGqdjm6Uw7GX1WfTWFO1l/bmbAkaCQRhX7z++Dj?=
 =?us-ascii?Q?5g0uAwp2vhtwcMrAfZW9QqRqmgOe0Av0uIfxgelMqM93uc1/l2HO5nq707KT?=
 =?us-ascii?Q?WywC0Fnz56cPut9hmf2s5bWu+pJboHhEerPc2uGEZxK1ovyWC0GJx3Y8jWWx?=
 =?us-ascii?Q?Yjt/FA22+WKcP/a59MucH63Z06YXHXiVYGda5gj0CyKRZdYNmulKovDgfvTn?=
 =?us-ascii?Q?6rqhA4zqQE2mv37cw2Qj9GZAJiVaYdhIwLbTNkohTBE+soO/EXhu0uRzGRXq?=
 =?us-ascii?Q?2D0rFAXt4E4Xo1xgDQbwOdM2+JfM3yD15S8mv6ckYtpNtHZclgA1R4WuIobj?=
 =?us-ascii?Q?SfkttEZiE95+Fvp1OtVmOdB7Izy4FO9AaJhtKLMzxuzcr+8rgBVU5GUUNVuK?=
 =?us-ascii?Q?F/JV/1gnOA4zTa91wJlsaTCm+B53yYcqWh/5jCouD/xCoPinTC7ivTVY9wxU?=
 =?us-ascii?Q?3IK0Zs+2LLLWxglOABa2I15oTmyLlXvQtZmk89DqcFRs1mqtWGEZlG8eGK1d?=
 =?us-ascii?Q?B8EEN02Te2LSok6KET0uHRa1PikYpGOEuqzq68/v7dRc/1WX0iAlpOZ/Xm0N?=
 =?us-ascii?Q?LJqcbUMBguNJqbkTFwOidXp7pIOfeYJ1kjZwZ79ba6hpCRxqIdRTzPsAo1Vi?=
 =?us-ascii?Q?7nNdv0kGseqz2StMSXw0qzImSVyqLLMgMdSo2wluUwEuBwAD+DHFRg4c+mqv?=
 =?us-ascii?Q?R1IySbZ+n/Wf59hT4NO9QF1Uyy65/U+evWY4Eu9Niy3xlIFbC8wO5+SxL/a0?=
 =?us-ascii?Q?Va2cP6YPjWplN4K0Uy0ugnX9WOdDTdC3B+CUdei8hVaVquEL7oZN/WaZhhld?=
 =?us-ascii?Q?r064UXQFvXvxoRoJBgfB7SsHVEhr63IJdvIjbVZp8K2TKREG0cEEjNDVJxzQ?=
 =?us-ascii?Q?rA=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: c1ceb906-d26f-4579-8bac-08dbbd9ed3e5
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 08:10:06.1784 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aw0EOJ+ZKFwQKcLT8d/PowlHB3SzCeNNI43CoRs8dKk9xUX5MEDDL5DMpi9/MT81WNGCjZ0LJwpiFZ+sw2wso6VwQKVVXdLfcwm4M6IQ520=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7399
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

Distinguish more clearly between source files meant for producing .dtb
from those meant for producing .dtbo. No functional change, as we
currently have rules for producing a foo.dtbo from either foo.dts or
foo.dtso.

Note that in the linux tree, all device tree overlay sources have been
renamed to .dtso, and the .dts->.dtbo rule is gone since v6.5 (commit
81d362732bac). So this is also a step towards staying closer to linux
with respect to both Kbuild and device tree sources.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 ...-cl-iot-gate-ied-adc0.dts => imx8mm-cl-iot-gate-ied-adc0.dtso} | 0
 ...-cl-iot-gate-ied-adc1.dts => imx8mm-cl-iot-gate-ied-adc1.dtso} | 0
 ...-cl-iot-gate-ied-can0.dts => imx8mm-cl-iot-gate-ied-can0.dtso} | 0
 ...-cl-iot-gate-ied-can1.dts => imx8mm-cl-iot-gate-ied-can1.dtso} | 0
 ...-cl-iot-gate-ied-tpm0.dts => imx8mm-cl-iot-gate-ied-tpm0.dtso} | 0
 ...-cl-iot-gate-ied-tpm1.dts => imx8mm-cl-iot-gate-ied-tpm1.dtso} | 0
 .../{imx8mm-cl-iot-gate-ied.dts => imx8mm-cl-iot-gate-ied.dtso}   | 0
 7 files changed, 0 insertions(+), 0 deletions(-)
 rename arch/arm/dts/{imx8mm-cl-iot-gate-ied-adc0.dts => imx8mm-cl-iot-gate-ied-adc0.dtso} (100%)
 rename arch/arm/dts/{imx8mm-cl-iot-gate-ied-adc1.dts => imx8mm-cl-iot-gate-ied-adc1.dtso} (100%)
 rename arch/arm/dts/{imx8mm-cl-iot-gate-ied-can0.dts => imx8mm-cl-iot-gate-ied-can0.dtso} (100%)
 rename arch/arm/dts/{imx8mm-cl-iot-gate-ied-can1.dts => imx8mm-cl-iot-gate-ied-can1.dtso} (100%)
 rename arch/arm/dts/{imx8mm-cl-iot-gate-ied-tpm0.dts => imx8mm-cl-iot-gate-ied-tpm0.dtso} (100%)
 rename arch/arm/dts/{imx8mm-cl-iot-gate-ied-tpm1.dts => imx8mm-cl-iot-gate-ied-tpm1.dtso} (100%)
 rename arch/arm/dts/{imx8mm-cl-iot-gate-ied.dts => imx8mm-cl-iot-gate-ied.dtso} (100%)

diff --git a/arch/arm/dts/imx8mm-cl-iot-gate-ied-adc0.dts b/arch/arm/dts/imx8mm-cl-iot-gate-ied-adc0.dtso
similarity index 100%
rename from arch/arm/dts/imx8mm-cl-iot-gate-ied-adc0.dts
rename to arch/arm/dts/imx8mm-cl-iot-gate-ied-adc0.dtso
diff --git a/arch/arm/dts/imx8mm-cl-iot-gate-ied-adc1.dts b/arch/arm/dts/imx8mm-cl-iot-gate-ied-adc1.dtso
similarity index 100%
rename from arch/arm/dts/imx8mm-cl-iot-gate-ied-adc1.dts
rename to arch/arm/dts/imx8mm-cl-iot-gate-ied-adc1.dtso
diff --git a/arch/arm/dts/imx8mm-cl-iot-gate-ied-can0.dts b/arch/arm/dts/imx8mm-cl-iot-gate-ied-can0.dtso
similarity index 100%
rename from arch/arm/dts/imx8mm-cl-iot-gate-ied-can0.dts
rename to arch/arm/dts/imx8mm-cl-iot-gate-ied-can0.dtso
diff --git a/arch/arm/dts/imx8mm-cl-iot-gate-ied-can1.dts b/arch/arm/dts/imx8mm-cl-iot-gate-ied-can1.dtso
similarity index 100%
rename from arch/arm/dts/imx8mm-cl-iot-gate-ied-can1.dts
rename to arch/arm/dts/imx8mm-cl-iot-gate-ied-can1.dtso
diff --git a/arch/arm/dts/imx8mm-cl-iot-gate-ied-tpm0.dts b/arch/arm/dts/imx8mm-cl-iot-gate-ied-tpm0.dtso
similarity index 100%
rename from arch/arm/dts/imx8mm-cl-iot-gate-ied-tpm0.dts
rename to arch/arm/dts/imx8mm-cl-iot-gate-ied-tpm0.dtso
diff --git a/arch/arm/dts/imx8mm-cl-iot-gate-ied-tpm1.dts b/arch/arm/dts/imx8mm-cl-iot-gate-ied-tpm1.dtso
similarity index 100%
rename from arch/arm/dts/imx8mm-cl-iot-gate-ied-tpm1.dts
rename to arch/arm/dts/imx8mm-cl-iot-gate-ied-tpm1.dtso
diff --git a/arch/arm/dts/imx8mm-cl-iot-gate-ied.dts b/arch/arm/dts/imx8mm-cl-iot-gate-ied.dtso
similarity index 100%
rename from arch/arm/dts/imx8mm-cl-iot-gate-ied.dts
rename to arch/arm/dts/imx8mm-cl-iot-gate-ied.dtso
-- 
2.37.2

