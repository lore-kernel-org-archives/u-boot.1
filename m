Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C45ABE936ED
	for <u-boot@archiver.kernel.org>; Thu,  5 Oct 2023 04:37:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 277F286E4B;
	Thu,  5 Oct 2023 06:37:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="nlfaI1mY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C159186E57; Thu,  5 Oct 2023 06:37:28 +0200 (CEST)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20622.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1a::622])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF66F86DED
 for <u-boot@lists.denx.de>; Thu,  5 Oct 2023 06:37:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G+orISVbxTkpHC4Co9AU67Gxzx5lOg3du8g0IgPCg0KnCJ/btBjkWG13XbFPWDDImkcLNYwHgmqcYTUw8f4Sy6lyrNWBdw6Z1N+vUHQQK1+NHGKebCaxv/N++F4VB/Psd40JiPr0m80Y+GcHxK7HJEN1FDyu+WKqUT2p2qCf6tkgiv/BWTbWpZEkNZIIu24P8Wmpc8jI6Pulfib/9oHYYSC9DqQbHOzFBMsDLaO8FOWyNCITgUx4OZxKYdi0DLAb9XgWPcbVqZhrtVfs2KbaPL7wlL02d9iu7cUsRDg4YSuZjr2RoHHdqchmH6S5dwCWvwLv5nyxToq+2ylitqfu5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BvW+V82KBXTylmoLDvEaplstHvuc67Clhu0P8iSjveA=;
 b=B/vGJhfeBoFL6MNfpeiKZyOy6QFBDv1iLY6FiN2rkpfb9xLrfKOpdKigRXQXRyJdxUrPMNtj2mOGQJBb49QYsQqFmQXkwzUHECO6WBUNBR06vu2js/dhaIi2DquE2WZfihjJDyemUAkeSI6e2lbzteQfqELeevnKX8lnfBc8Nx+45VagiLOA0FqlSJrWXEfFA9SfyQuzO+0UhuFMyHNiFHgGvIp0qQoi/4epFldzoQq02IeMITiogCiizrsfxj9zkgQZIzybSRFdRa5JYhJmQjBWUguEw92eCjastcaqQiyFmZBYVJkdgrZ9vfwBzRw/ySHdkcaxhxYNZaUJ0iA0Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BvW+V82KBXTylmoLDvEaplstHvuc67Clhu0P8iSjveA=;
 b=nlfaI1mYA3qb6sY9Kz8yGOPdKipHM034Ib66V1yGSJqKiy51F3W8X2+oyUowLQokxbfAJ8kMd5kGOIFDFgQ+FTb1SAYX1ZDaG50wPJvz5cHs0HTI7iPHbWMvLhXtuCafnhg3x/+XZKSNiiGhx7eEjZ/Mg0oK1HZv9sdFb4XDCj2Rl67+HW+FlSp1a0MNcqLdQ8eEKiZCZvsN83MaINhNd4HER5BYxS3NEFOJv43K+/f6iDM+3DPfmwxGg3MvWFRsmprpKusTpDMOYW/rEd0vFGR3kOtVxlxg906zUhl+hDvtpYjARTR7GbElZAvh68lKXkK0dfEky7rkh/huFyKxuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAXPR10MB5614.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:244::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26; Thu, 5 Oct
 2023 04:37:25 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 04:37:25 +0000
Message-ID: <aa0e6927-e35c-48b7-b3fb-785059f48910@siemens.com>
Date: Thu, 5 Oct 2023 06:37:25 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] board: siemens: iot2050: Fix logical bug in PG1/PG2 detection
Content-Language: en-US
To: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
Cc: "Su, Bao Cheng (RC-CN DF FA R&D)" <baocheng.su@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0109.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAXPR10MB5614:EE_
X-MS-Office365-Filtering-Correlation-Id: 08ebfa69-b353-4fa1-ac8c-08dbc55cc62b
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QyrsUnfEZ5f6izP9zPp/YIFUUf8iXO1/ri4GKIP7uuDaEJQDbST9XSNrw2ueI6dj4qlevvpsBHCbhGiir/Q3rW+ueoV6CjZ9bd+eQ01zCdBiyLeiYjx7KJChDXXgrufpsufHK9+nNOjcZGPOAFw70HONXx/OqUiqC1IGXXhTSn9i5jsubQMbQJxsgkEt3hUoBNmIzuOF19ZRYKpeeBFWwkym9/YdPJ2oM/o8ffDP/s5PY9PovD2aAtwRIyDUZYNNPmiiansR38H/qPheBiMHk9nUI7bhWd1fOOo8sdhaRING0XuOH07pETCuze9Xn0E7DS8Nkk46I/8n8Y9juisXEEQL6Qu0yfa3SJLh/h+WiXbqJNoclJGQ1vVuABg/QdrRPhtiBB7UqGHorjsOnbuaogboCKgm2I/27yIFsm0TyL+E9PYmrLWAZ8d3dph8aQU8P4i8mfXIbJqQLkFB2TuEdF7tgRKQxipaJ7q0l2oM/cE2nWU2M/MOW5aVRuT+zBmVcYY4di4hVAINccdXK7KFzxy6hIDyNpTbgiDjW0gOJ4uzIflKCyElg0oWbkOU/sJX5SkG6wRVF68gj2HnCCEsJAGEupGU8w33z1WdrNf/wM9dycV7Nib33POz5Lb5y1r+MQeK9XxzBAfXmeD10eKt+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(376002)(136003)(346002)(396003)(39860400002)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(31686004)(44832011)(5660300002)(8676002)(2906002)(4744005)(4326008)(8936002)(41300700001)(2616005)(316002)(66946007)(66556008)(66476007)(110136005)(26005)(6506007)(36756003)(107886003)(6512007)(82960400001)(38100700002)(83380400001)(31696002)(86362001)(478600001)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDVYNjlTZXRndUZacUowbFlETEtKemlNUlc1YWZ4NUt2RnpvUmRFbzVkbHQx?=
 =?utf-8?B?enhyanpTY1Y0eFZVL045bldyUHNuV1U5THNrOHI3cjd2VXF2K1dJd3BnSVd2?=
 =?utf-8?B?bmF1TitYRWxEY00xR1JoUmxRYzJnRE5YS2w4Q0Zrb0dDamdnSVVZVGpSNjgr?=
 =?utf-8?B?MnNZWkkzNWdjeWk2S3d5MjFRRytSZktsYmZOMlg5Y25oSVY0NWJiN0sydVZn?=
 =?utf-8?B?ZC92Y0dvM2F6SFA1QmRFOG1neTA1NmlxVjl3bmVUcFNLYVR6MjZwWDFjYjdT?=
 =?utf-8?B?ZWUwVVNiSFBta2JPN2ZrVkw3SjNSOWxlVTVKbktwS2cvQlBEUzR1bXFQRVJ4?=
 =?utf-8?B?T3VrRTJIVGo4Z2REV2FzcjExcHRoeGJRc0gwbHBHUy8rTXlsN1FqNU9tYTRn?=
 =?utf-8?B?RVBzWVl4RTBONlJHNnozTWVGbm1OVDBiY09FYk1nNXNjSmFnRGxwTTd2UHJX?=
 =?utf-8?B?dGtZMVNQblA4bldyV1A2eWQxSXNMbmkwVTQ1SXhRZnFqWHJVV2RNZHJqU3lX?=
 =?utf-8?B?bDloVFlBRG5ldlFKd2lZMzBFek50SlNYWlYrQ0J1QXcwNmNOSGxKUDJUNS9O?=
 =?utf-8?B?WmZXeEszVCtEU3NzcjY0aUtSeG1OWmN3dzh6WEEvVDZDYXhUMlVxQUhNR1Jq?=
 =?utf-8?B?YnZGM21UL212NEx6bGN3M1V6QzVBVm5mNVIzcFZ2VGRxbFRPL0xaVVBDd1RQ?=
 =?utf-8?B?UGZnb0dOdkZKWEM4OFR5a0FBZDZoTmNDSmViVlRLelNDNHpwbGRzYlBiTHZR?=
 =?utf-8?B?RFBxbXZPZGVIOTY0N3FBcGlxdVJ6dVhqM2gyd29za0pjWU9SZU56SUFudHhX?=
 =?utf-8?B?Sm1Dc092dXM2VlhPK1ArSVFudytLbTNEZERMK08yYVBXZjZ4MFQzT2pnTWZ6?=
 =?utf-8?B?azZKSzJLY21XbVdRZmt4WDhobk9SREx5NnVwbGJKaG1HRUVQaTRiNzIvQTR4?=
 =?utf-8?B?eXhmdWN3cTNHN2pqZERiN1o3YmdZSDd5REZxSGt2Yy9PYmNzWXpOS3IvUExS?=
 =?utf-8?B?M0hWVEZNOEd1Rkl3M3BLZjYrZzlydmo4c1l6cjhFT0VUem5jb0hCUVVKTU04?=
 =?utf-8?B?amVtVGtQWWpGT2NDU3RCQ0ZTVWpSd2luSngzUHJ4SFRVZERzdFVHM2VSVUtw?=
 =?utf-8?B?OW1Sd3RaT3ZmQ3ArNEJabTJlbnpZdVJFNmVmYk9xWUhLWlpueklIbHVTVGtm?=
 =?utf-8?B?OUpyd1FXd3VSdXVoM1liU1d4ZncrM2FsZmRQdmY1SnJ2ckU5YXVzVGFLVEJ4?=
 =?utf-8?B?dENRa3Y3Z2ZONmlYVzY1dmVLRFNuRmNlQjNMQ28wUEllaS9VUGxvVHY3SU5H?=
 =?utf-8?B?RUFNQlVJdXBWVkVwUTFnOVFlTHpIeVpBbzZtRUFieklOeEVOeXkzWTdWYkhC?=
 =?utf-8?B?R0RCcHl4dW42dklnNUd1RnlGaFZUQzdJcFpscjZWNm9oLzdCL25JVkw5SlBB?=
 =?utf-8?B?eEtYM3g2UGo2NEliT1FWbUFKS2VCd1A0cmx5VXl1U2J6dnpTaWQzL3B2cm5J?=
 =?utf-8?B?QjJhQldtV2dYY0tQTHA3dVFsdUYyTzNzZERCaGk0eVFWcEQ3RTNwbzRucGNq?=
 =?utf-8?B?Y1E2b1VDa2FtbjJ0VjZqTWJBbmoycm9UbU5yR2x0eUxmbFlLQXlzRDY3UFNJ?=
 =?utf-8?B?bC9ZWEx1SWtFUEFqaGVYM3VJajAyWXJaeThFbDhWeUdxRzZ3SnEvdXJhZThq?=
 =?utf-8?B?cGdZVDM0L0dlV3F5MVBhVVlqODlxeS8xSWRwaEdJV3Q1bTAwK3RZRS9Lb2dT?=
 =?utf-8?B?d21nUTFpY2VnVXQzYTFFeU0wcGdXb3B0T0hKNTlDTjVIVXg0Syt2cXZBbWZ4?=
 =?utf-8?B?ellEQWVqcStleUV0REhVRnovU3FlZmFFdDVsUnZhSmlnL29YRm52dzVoWHAz?=
 =?utf-8?B?bTFvVGxaNVBXUjkzTGQ5TDZZODlvaFl5TkJabjJ2aWQzNjFKUDEvL0hIRHI0?=
 =?utf-8?B?UjZBYUE3SkN6djFiVnFzaEwxdHhIcnBCMmwxUm9TempOSzhDQ25lQ0dndysy?=
 =?utf-8?B?aVFDdTFUWFpzUTJhSHhrUW95eS9SZWowK1hMR05WVEZaaGI0MTQyKzk0MUVS?=
 =?utf-8?B?aUZyS3dnY2FoM1R1UUQrbkxNc0ZEQjVTeSs1S2Q2ZmZDWjRiZFdhdDNGb1p0?=
 =?utf-8?B?Nk9BSmJPY1lUOEx0dGRNVXA2R0dCaitXUWtGVnE2TTIwZ2lzakE1TE1tS0x0?=
 =?utf-8?B?emc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08ebfa69-b353-4fa1-ac8c-08dbc55cc62b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 04:37:25.6540 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bZ74J7JgFV9AOZya+fvV1W5sWtlsVk+jJvzLKlmy+YVvG6CI1HO07P+DanfOqpEx0Ng+Kkpfl/g79Cb9FUu2hQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5614
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

From: Jan Kiszka <jan.kiszka@siemens.com>

This caused the wrong fdtfile to be set and was failing to apply M.2
settings.

Fixes: badaa1f6a7a9 ("boards: siemens: iot2050: Unify PG1 and PG2/M.2 configurations again")
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 board/siemens/iot2050/board.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/siemens/iot2050/board.c b/board/siemens/iot2050/board.c
index 15f5310c7bf..e35e55fb5de 100644
--- a/board/siemens/iot2050/board.c
+++ b/board/siemens/iot2050/board.c
@@ -160,7 +160,7 @@ static bool board_is_sr1(void)
 	struct iot2050_info *info = IOT2050_INFO_DATA;
 
 	return info->magic == IOT2050_INFO_MAGIC &&
-		strstr((char *)info->name, "-PG2") != NULL;
+		strstr((char *)info->name, "-PG2") == NULL;
 }
 
 static bool board_is_m2(void)
-- 
2.35.3
