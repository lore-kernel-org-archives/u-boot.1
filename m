Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA6F0C07C79
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 13:16:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 250298834C;
	Mon, 22 Apr 2024 15:16:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="gaG/eaSc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5BF08879C; Mon, 22 Apr 2024 15:16:28 +0200 (CEST)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01on070d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1e::70d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 927C188415
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 15:16:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Lukas.Funke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fY33PU0y0ZsfSWQGrbQKr/P6JF3JTzY/NNlouLDaChNki8q5vlgh7DUK02eMbXhUBd00N7pw5ZQAtdYmXMJpuIQc2vRWjmUW7yPB7kLbOVhJUgOznjXT0DGTClhB78+x1KWFWBp04nKpFsobmXWwk75mSCOab8EoZ/Z3y5bA1Xc7++dQiGRjC8thsnt5Aa5jRBtfaW/ca28fsALKK7uWe6/BX7Kb3PuwD0QsxYO6No2RtzarI69cKkZkZSXCS961/WJ42AgG4LvEbop5OD3mSKYyUTBJNDewem7Vahw2KLN12StgLXoMNUpdZt84Ea5qm1WvQT35W2dy3+6wanBliQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZJ+UO3DRV+vVzMleCHgOnoq5JeQ+2vh1VbgeUoTRb3w=;
 b=lWc5mkJwheW54YR/zizHnbcRoRKPmC0+COETJ9mVDHPLIwR7blQqpWIwdKXJaoK/mI3FsV/3S9D12frpHv8brdeVAkVc4kYB4xqYXASy1ymac3TovbZibi1RSsP8fKAWmycNfnS3q4cp6KyWc/JRWmJZJwiUIR75q8R4uWqoPY6wFTp2HkjfCR3Qk4fRTpJ+9KDAmj1McAxg0Wdk4hdXpo/pmoDMjk6kj5JygrjdMkubjYPDRRj1N5otYfG2GQWL2WpJ9LV3QrF1VEaVB5wKP7u///Mf4DKBBby5PcygglW7J6thBR6g2GJVUknlugENbT15wep0nN10pLmLqFzOCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZJ+UO3DRV+vVzMleCHgOnoq5JeQ+2vh1VbgeUoTRb3w=;
 b=gaG/eaScWD4ALL5iXyh+7dgZNp/iorNWVpDCixNwBhBJ/pP1A+/4dT7RTPGiurAkYMEGG/oW4YnvpTey50tPK12ppZQeRnzw8FyKgSzhsqrIlWbkloEUu49B/8gAFC8vQSxCCePj2LC5ssei4rIQaSeIAWtIgZ3aVV404NaDhBw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com (2603:10a6:20b:55a::18)
 by AM8PR08MB5620.eurprd08.prod.outlook.com (2603:10a6:20b:1c6::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 13:16:24 +0000
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::7f1e:4f98:9784:5e11]) by AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::7f1e:4f98:9784:5e11%7]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 13:16:24 +0000
From: lukas.funke-oss@weidmueller.com
To: u-boot@lists.denx.de
Cc: Lukas Funke <lukas.funke@weidmueller.com>,
 Chanho Park <chanho61.park@samsung.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Lukasz Tekieli <tekieli.lukasz@gmail.com>,
 Minda Chen <minda.chen@starfivetech.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Yanhong Wang <yanhong.wang@starfivetech.com>
Subject: [PATCH v1 3/3] board: starfive: Call spl_dram_init() for DRAM
 initialization
Date: Mon, 22 Apr 2024 15:16:13 +0200
Message-Id: <20240422131613.84304-4-lukas.funke-oss@weidmueller.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240422131613.84304-1-lukas.funke-oss@weidmueller.com>
References: <20240422131613.84304-1-lukas.funke-oss@weidmueller.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0087.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::11) To AS2PR08MB8431.eurprd08.prod.outlook.com
 (2603:10a6:20b:55a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB8431:EE_|AM8PR08MB5620:EE_
X-MS-Office365-Filtering-Correlation-Id: 16716ab0-c349-4d93-3fcb-08dc62ce6911
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/cydhldcl0deacJWJqsSJVgaqq76ugiDGgjPiiY7dpH+rRRbxqWeW6t2+k13?=
 =?us-ascii?Q?ogtD+7YxBAYAE1AX9dd9u2S6xEonoGBRZApHtLG190dxJ3I3a2ClKISSlWWP?=
 =?us-ascii?Q?r6OmhmoJPe8ovTePp3ufPKfVHZknex2c/nYA/pxe3+J7VGsXTM1XnokVP5dg?=
 =?us-ascii?Q?ie7iCGV/E2mgqYNxDyNINgccw0R5WWe8SdWP2+XASg1nu0cmpa+PCOZhb503?=
 =?us-ascii?Q?P8tTI4ALMs5CCoO60Q+a35r8Bazajgse8OVmeRb149AESMma+yYBlX4Qlj6P?=
 =?us-ascii?Q?EcMRjioQBrHRHMSCrBLujk7kFLGcLrP1/RQCy2Pd5XesC2GPrlD5cOCM7oxB?=
 =?us-ascii?Q?fIKQw1b1uKfH34s2fftNwtUkFEkXtw4gskkwdJg8Sf3kQAKWxQqTFG9FrU9k?=
 =?us-ascii?Q?dZKENkagKMSiV44PNn2D7S/6gM3gg7iT52FVoMiR4w9dHC3wJyxuaIHNy4Np?=
 =?us-ascii?Q?OQV/LdnjS2BpTf7RZcbkkJoHBJncYn1N/7SGvZlrWIqxPDH8iSAtUN9A9k8g?=
 =?us-ascii?Q?6fe7tiyEPm7I7wCL/1LBQ5J4ko12MYEaNs/YtFkS1UYJLZU7Thdz1AdxGFmJ?=
 =?us-ascii?Q?6EN/raP4fZFIOauH9qzZPI6UmNvagEYiUDriiPcDDOaIkonB4XvGWMvXCwCD?=
 =?us-ascii?Q?ZYUsaSdEIsLbSu7LxLtaZjhsbAstHv/cVQS6Jh7mUH3U8KRPevGTkVkOb96p?=
 =?us-ascii?Q?9bEiBEu/wxLs0qwD5u3G3XkDVxr5pRiirp8YG2dO1aNIkRY5JjlWchD71gLg?=
 =?us-ascii?Q?Sadug41ZwMsEBJwM66K6Ulg3wKjjaz1SEYqeun74TENK8zJEYh6OhT0Huvnx?=
 =?us-ascii?Q?ZFhirYI9prKmnlPcZNTEX6ohcxnqebi5n8CgQsKIylZmPgslrXu+kTpkDXgR?=
 =?us-ascii?Q?KTHSx3hV3m9lqmNHudJyDtZUXnZMi1C04JxWHJPO5Hmfg80GBSkTa0U5d5Fl?=
 =?us-ascii?Q?tTqhoAlJvX6vPTJK68Jmadc1P8kEPQS9FcIBt9fLs9HJTqGCVWQkMLVEuh0k?=
 =?us-ascii?Q?N4EVoaTjfWfN4NQOql9MeYgX56Q52Ye5nmDSlUO+qGWahSHa5mAIU6n8OOmF?=
 =?us-ascii?Q?Q33sNhq7j+mML1ZAdmNqm7lMZgX3/CtteuUnbJiUYnJ9adDDetp5/EZ9Y9xe?=
 =?us-ascii?Q?7zuDsFifw4mwwOo0f4t0AYe/bBlKo5L9V71xqf3jNN2Raz5Y+0L2rVfXVo9H?=
 =?us-ascii?Q?leeYQZE8aZqFGPgA8pTDNBtdNGBgFcKer6/tyZlmIXUTVzLHkxGfa43bpXMi?=
 =?us-ascii?Q?AtVJ6KW7ObZdPjAhCu9/ZsYnkUxr773PKMYJK+zAsGPLd1uU4ZrE7PVJALle?=
 =?us-ascii?Q?I3X2Y85ks/gru7TUTEZmFj8mOkTs2icIAFD/KJh2nc75Zw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR08MB8431.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(52116005)(376005)(1800799015)(38350700005); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5D+luX7q1pOw042UHbzr7qqAo32AviAUV1mpfEiX3+xh03w8C6WDPop0hJOv?=
 =?us-ascii?Q?0ztPomIc9EQ3hMJpRi8HDcPG/e53rN7/qP5mvtR/vD1xP1wElvPWSSWkpVPd?=
 =?us-ascii?Q?H/pvAXGIB2CvAma6TC8VGdVezrqukc5lvMAp0u2mnMr+v64/GT5RgRTpdIZh?=
 =?us-ascii?Q?gVPlIKMBL8EGAmyb2pIdGOAKhhB/5nHb/gyhVPUK/OPvqtWiO0HslHvbEyPD?=
 =?us-ascii?Q?r1rLVQ7AH2Nn/NSEeU3dB0iynE/DC00oUf0GvVNj3CSSrgss0H3uQ+qtxkcq?=
 =?us-ascii?Q?3eAQpwSqQEk0htKFre5huf1icdzcOEz6iBwVUTalzuv3JFxohp/QPdh8QGYr?=
 =?us-ascii?Q?W1dbH+luk+qiwHH7MqCle02JBQSs/mn+nPodHj+Wn4JPwCRwzj1rzFoaePt9?=
 =?us-ascii?Q?/o0zJDvUHoCHrCQgWVX6yfKWJDdJq9h8cHZDIah8XvqvLiO0NXcpR/9k8lOu?=
 =?us-ascii?Q?CesSUI9/r9jwrQOd4OChtWA9LAoR9lkEiTdeG6QbMYapFt+pCmCOSssYC8TL?=
 =?us-ascii?Q?MXyJ8qaZvsiHz/m248oCLHWSM/3jdAJocVI2Y2X/3UCj289fO+ZbMiFw2QtE?=
 =?us-ascii?Q?4uxxYZCM8HDwJM9dkvAUPVMCBvw6zy6Pw7YQc4rkOgc20Ig2eMkC9iYLcP4J?=
 =?us-ascii?Q?HHTPpl78yG0d6uYQOPP9NlsavQz7pi5mUW6UMBL/EzXzPOq0cpl3vdqZHM2h?=
 =?us-ascii?Q?QIz3XAg+2DY0fKekM7e7znZBi5ymiznrIeeffr3dmCW3azWyFRD3XikaMqVB?=
 =?us-ascii?Q?6c4kSHDzJ9hPoxSB7w+pMVfTLGfC7nAzXjpPpI1gx3R9SZPOJfAjLe19ETGV?=
 =?us-ascii?Q?/30M5JJameADD3jBF/TUyWKk7w7Gt4AsvYRfd9V79SuaKejfjeoTYMj/R8en?=
 =?us-ascii?Q?wOvlk6x+vNGRrMqp4eQ2/cUOtpIdHTD5sTzfO88Z3qUL65AKNV5302e4opzY?=
 =?us-ascii?Q?FIdG0skOJcunzne9M0cEoRmdFkDxm+o8Y49vh9Mz2ozNp5paAYvjvpOk3smK?=
 =?us-ascii?Q?IHAia4j0mWY9LvPIxRznZOnt0tUPcdTdrKphvr1j8daW8f630047M3Wj84tx?=
 =?us-ascii?Q?uLwom1uYoUSkqTDdr/LYvmuE6XsbXfxRxnNzODNr0id0apR6aHi5vosjrZ34?=
 =?us-ascii?Q?HyzXeisCQWFCBLunxqZLZNsmdzo4pO0sNoZs+KPeV/JnIjMiZgVZVN5efFVZ?=
 =?us-ascii?Q?J5TOemx7j2mRZLFa2rche5ZmiarFrzR0nJmxGsM5hWaAHchI4aHvGMyhh51+?=
 =?us-ascii?Q?BXzFvCm48fwWDzJoeiaL6TfeaRgtpVWhCf+8tfDvRsM6Wmz9AUEepqiEdZm2?=
 =?us-ascii?Q?WyhI9Vbxn64K4HYJ6BbodwErf9BTjwa6FlVAdVebgnj0i0D1SJqhvOfhZhvB?=
 =?us-ascii?Q?JCQKqbIdoJuBNCjW/hGkNaNGe0vJe1jdSREed6AVoeFVGarW0gVrEYPaeP++?=
 =?us-ascii?Q?sfYTjAQpI934sISzNj78pHjhFewjyumpk0Ya0mhrqOJOFjMCWFu1HneDyJlE?=
 =?us-ascii?Q?NIxDCBJxiF1V1YhZH8L0HtJGTyvDGsHqpDzxzNa+yMIgjVHIZmGuCEpssmag?=
 =?us-ascii?Q?Ihf/AcRflBjEmxQW8flTi6wJN7VmdVLnGi5BTm7en59q+iK1M3d2W8dpgIX5?=
 =?us-ascii?Q?uA=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16716ab0-c349-4d93-3fcb-08dc62ce6911
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 13:16:24.6466 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VPWyAdCbx2pJmtVDakTkoOELnpYK+/7aL4M63OnHG92mhWdYHHhYfORK/jB7P2f+UCzqNiXH206xBG5mbdiT/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5620
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

From: Lukas Funke <lukas.funke@weidmueller.com>

Call spl_dram_init() since this is commonly used for dram initialization
in u-boot.

Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
---

 board/starfive/visionfive2/spl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/board/starfive/visionfive2/spl.c b/board/starfive/visionfive2/spl.c
index 45848db6d8..d1db7ee87b 100644
--- a/board/starfive/visionfive2/spl.c
+++ b/board/starfive/visionfive2/spl.c
@@ -285,9 +285,9 @@ int spl_board_init_f(void)
 
 	jh7110_jtag_init();
 
-	ret = spl_soc_init();
+	ret = spl_dram_init();
 	if (ret) {
-		debug("JH7110 SPL init failed: %d\n", ret);
+		debug("JH7110 dram init failed: %d\n", ret);
 		return ret;
 	}
 
-- 
2.30.2

