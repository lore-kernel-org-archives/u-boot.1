Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17523C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 10 Jan 2024 09:11:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE84E87A9E;
	Wed, 10 Jan 2024 10:10:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="GcmiocAh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B73F87AB3; Wed, 10 Jan 2024 10:10:53 +0100 (CET)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe16::629])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82DCB8797B
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 10:10:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Lukas.Funke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k10PBt95bgrpeLY7RKUqGlQqS9hYTe2CxRoBXdYtUdPnXqWV6Fq54TsiSPWkyB6BblGoXkSv5RJ3BibZ2wsd4m2jt67CioRXwpKWofQOF+LfxPdt/GS0NcsJXp9udLlzCsD7NanxbNLzPlVSEx2TWUnC4eQj30BQ48YX83tHal9ziihr6iOFxyFetp/B2dvCNTem6Dlaoda4fq0D1b4VgBaQ6OwWm8b/PvbbQg1U3aGEzHTw8XwVZtCt2Gqq3V3Ohou3qhlJhfXftRgCAaYE9PdQ2I9GIbmEUheFlG9ziCukYBnr/EYcNpiVJ/zbBTw3zqny0nywOZfvhb+YJoHECg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O5+hUd0kJ/55WDNWk/vjw7685stc9LtUunN+q9hAR5w=;
 b=kbZYrETfO09ma/JKzTp/3rZ1Es+JushksTHMosZ4OoZ5f84snq99lH/2WC1VmoYcScVwPJKHatys/hz9ePaXRBm75vski7r7E6I6zERAaDJDJZXfdhY+2ZxN6pGIyZl9q4iEdAxCwujSCYH3fiYU/tubtsTqVJO2XX96kBNQ5EbLWYqQiuh/YB6IbkmJ946TWhZsIAcuNc//526vYCk0o1KgH9WB9WSWvCmhvgCtrwiil9TgBa96XFa/HQVRZVhzegL7Eo62/98G0zZH2W2wyEKNKAGEFRZyQ4sCloJ+vVveQycW7TpCSzTntClH0FoIYrRZyXtGEF75tXavRJ1Mgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O5+hUd0kJ/55WDNWk/vjw7685stc9LtUunN+q9hAR5w=;
 b=GcmiocAhPCYc0rU4m0JnqRd87V5hv7YwyKT5eyaxDDXntOTv9uv/LBvzMorJqWmdJQFJ25uYU1YWJmkMKlg6A0c7VDkx+pn1faCDUMjY3Y+Wz8PjaQCFXyeNRy/9OHYjNmbKDyV4Snlty5G52rhy9IERVFK4/Pbi/CZ7h7Yow3c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com (2603:10a6:20b:55a::18)
 by GV1PR08MB8641.eurprd08.prod.outlook.com (2603:10a6:150:82::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Wed, 10 Jan
 2024 09:10:49 +0000
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::daa3:b3af:ec52:4278]) by AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::daa3:b3af:ec52:4278%3]) with mapi id 15.20.7159.020; Wed, 10 Jan 2024
 09:10:49 +0000
From: lukas.funke-oss@weidmueller.com
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Roland Gaudig <roland.gaudig@weidmueller.com>
Subject: [PATCH v3 05/11] cmd: printf: Correctly handle field width
Date: Wed, 10 Jan 2024 10:10:31 +0100
Message-Id: <20240110091037.392520-6-lukas.funke-oss@weidmueller.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240110091037.392520-1-lukas.funke-oss@weidmueller.com>
References: <20240110091037.392520-1-lukas.funke-oss@weidmueller.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0200.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::11) To AS2PR08MB8431.eurprd08.prod.outlook.com
 (2603:10a6:20b:55a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB8431:EE_|GV1PR08MB8641:EE_
X-MS-Office365-Filtering-Correlation-Id: b8602e0b-d0db-4a6a-6942-08dc11bc097e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gmyR7bzggbTQvVPmXT05U61NyvNLw859OPhpaFDHOBBHyYXiq2Svuh3GmJeN0stybU8+icsSLvUBAC7JvqZWk0xOypyp3GSMNXJcaty6zXusG2kDgmeu/+4CmEIm/Vq2opSpMwSic9/2ghS2Bpyyv0XhQ+sCXatVUwVKe/rPUbsp3D5ALAXsTSqJkOzt9uwGqfuFeowjAAa1WTflDgK0Nl0zzIR1jnAy0VGk3rhhOjkEix6fjB85a4p0/7yqG4vQO68InsBb3NgtFXHecqOKx1eWZEBzKGVn8gE9Rmdo0lwSnibTGYaUAUKr5zz0qjg2wT7S1PUUHWir8s6xEoNrAbQSwUsuXODpnaRChmSnwUK86XU4p2RUw5htLAssC/Z1H3DgehXSQitFr0beO9aPwpf5+CIS1aL/naZBTjlDuYK7j9pd7keAC8l8oliCgC1P3nNHsEoPYAbOCHYkA4Y+Hz2DhZIP+Mf4x9w6AzAPxP1y62KacP/Y+CJ1eP8Dg0DQs+EAJtuqbzjvcTwxBp/3Y8yY9uUYrVf9cRJKNwUtdmIuFdULu81+1zCu07xi56OKdxpC3IKO1rRSX60h4Y5pSHY6LyNyaolbYjLlTsushxMwPrRY0d4jqc241qNIdT+p
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR08MB8431.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(39860400002)(396003)(136003)(346002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(86362001)(107886003)(26005)(1076003)(2616005)(6666004)(478600001)(6506007)(9686003)(6512007)(52116002)(83380400001)(5660300002)(4744005)(4326008)(2906002)(41300700001)(6486002)(8676002)(8936002)(6916009)(66556008)(66946007)(66476007)(54906003)(316002)(38100700002)(38350700005)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gezCeDOGYKj8yqRVs2V5Fve3vxy6iKpPuApmipgqApinFpAECduSbnAOVRbW?=
 =?us-ascii?Q?8jHiwiz3HfjzZscMmfmlR/Drx0sR7bl7R4nLGJu8Slwr2B1Z13HlOAI8H/Y5?=
 =?us-ascii?Q?sUajVdNW9fd9iyz9qMmHYCeYhagPmpMUuqJRM0ydRcQgGUh5JHTgFSMr3KbL?=
 =?us-ascii?Q?3fz3RdQCY9BQvW+pZM7s1OEjLecjMoG8lMev8LCgGg461gX4EgXbp2ubS5v+?=
 =?us-ascii?Q?+eIIhTSjUVQviWrFX4ePYbQ0eV9oQqndz2vg09bavsGZgMUq7xMPiI7aZLMK?=
 =?us-ascii?Q?ZVjEc6ERNCbVcS5YR72WUxJy7DX0UasZYX3tOZlCimcR/nV1MFWM2D01fwzD?=
 =?us-ascii?Q?H8nrloSh57g7fPg61KPuMzdr6VH8qu3xN+t2RGwXZmpDxynP4AYdLcLxFld0?=
 =?us-ascii?Q?Nr7u08S1uesPhlgI2a1bR9bwpGYPDMWAIwkuhXfVldMBfcesBxL3e4OhvyXb?=
 =?us-ascii?Q?Tb2UpP8CY8Jafg1PMnw5t7B9mOVZx2sQfmawHUY+aiIYxCGTV7krTpuTlzoL?=
 =?us-ascii?Q?4P4Er6KZEEZUTOZMu4A8bBBeWZO1Rd/v3TLNdII5E/c/1S+6URSORtNeCKUC?=
 =?us-ascii?Q?XHkUbmKKZXZdSS8lte4UxO36kLcV2+2D0uP1BU7D0E0HZATCMbbM/bndtTFr?=
 =?us-ascii?Q?Z5HBeLjpL7io6AjoXGXI+PNYTim5G8uh1+4pgdVDlcM/CDc5VLSX06+AJEYg?=
 =?us-ascii?Q?S58hXh3uGmz2hvhm5sID9zkMEAG0ZqDPnebcOLYjCuXg4TkfzlbZuO9qhpsy?=
 =?us-ascii?Q?pech84Bako6KEMzGPxI7VgYZAfkjdXNtQoDavh1SGsAsokj61CpYHff+UDtx?=
 =?us-ascii?Q?VyqZ5OIZckvYZg7sQH+BHjMw9QC64nVVJYXAFguOiZGQsK1kAIRDCXnATqJP?=
 =?us-ascii?Q?EChtRSL0DZXAwNZET1EOrn98HiHz7GAsDNfB39C64xyr7xNEyZp10ovfzkTF?=
 =?us-ascii?Q?fWJ3L1JB6xTII4gRiMfhVWWht6nByxAhL7uQbhPqdlIg9f3D8Ic43Saf7o/Q?=
 =?us-ascii?Q?6i2XPOFAimdEAiwzVEmF5Ib4x4q9QlGuDkJfMgtb98Oiru+T8T6+i2oJUux1?=
 =?us-ascii?Q?/8Wff2xXRQBXkSv1KwdRZOQkqsrW9XFyU14blcII1uN3O9ZEPEfbKLIpf9p7?=
 =?us-ascii?Q?BOC15x6XbJi5SA5LUnhOc+rAa5KYwWwCyVKM9NnnTQWRDaArn2PFVoAkLkBH?=
 =?us-ascii?Q?sLyZ9x/bwO3u9cdBjwWJeZMCopqUCsEhVRVPxLJc9uklDi+5Xs2PLFUw3cha?=
 =?us-ascii?Q?gBBdPYI/kc28DkkgX3YJqAbB0TG8FItsnnh7uPPtikT3G3cY74/+054ZUa5o?=
 =?us-ascii?Q?wZ7xNePKY6wN6XUldb/pmrhpdXRsqjqAHlktBU6LEBSlie+wml176QR+e/nO?=
 =?us-ascii?Q?jiraYcn6F+0LnSkr+SQJb1bHl8znOdMiSJZ2Zvq+zVVKmZb9q/acCmuTRfeN?=
 =?us-ascii?Q?XELg2ys8tpYHB1J+O6n3nAE0gPIarXpBR7SpjDZaT7cRcZjaAvx1EwHy0On8?=
 =?us-ascii?Q?AitbBORLdoTazxPNcLeJPr5bNuu2drp/9qE5wUGGgKNOcPNTCVmrApSmd5xU?=
 =?us-ascii?Q?1ZP//z24GTIU+jdk1xhk2HdwU6c1lMBA6SvQ26u5yda4LWA0YtKTv0sREgmz?=
 =?us-ascii?Q?fQ=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8602e0b-d0db-4a6a-6942-08dc11bc097e
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 09:10:49.1730 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zulAfyU4Dago8AQ/WfBdOyfcHOfgHeQIl4iwnG/ics+LHMTw90x9TRUrsSmGUuAPF9IxbX6zuUu/+fWuGpaWRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8641
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

Correctly parse the field width from the format specifier. Before this
commit the field_width was simply ignored.

Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
---

(no changes since v1)

 cmd/printf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmd/printf.c b/cmd/printf.c
index 0c6887e0d6..f56543b79e 100644
--- a/cmd/printf.c
+++ b/cmd/printf.c
@@ -517,7 +517,7 @@ static char **print_formatted(struct print_inf *inf, char *f, char **argv, int *
 					field_width = get_width_prec(*argv++);
 			} else {
 				while (isdigit(*f)) {
-					++f;
+					field_width = field_width * 10 + *(f++) - '0';
 					++direc_length;
 				}
 			}
-- 
2.30.2

