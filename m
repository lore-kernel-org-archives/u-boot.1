Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D8C9D609A2
	for <u-boot@archiver.kernel.org>; Tue, 16 Dec 2025 15:09:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12C4583A6A;
	Tue, 16 Dec 2025 16:09:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mt.com header.i=@mt.com header.b="wVxQyOHq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1AB4483A8E; Tue, 16 Dec 2025 16:09:08 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 546FD839D7
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 16:09:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Wojciech.Dubowik@mt.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KlPBLhfOCxTaCtHF64ahd2xtR5yl2l3PiGrz8tYkNlTebD4zWkVFIaUI5hqViNPSqLbQYZaZiG2x5K3LDiXd93kQ+sZzAk9BNYzZUuZpquMes98QVrkOCJFQxWTo9RAXjoH9gf5IsC9dUdtalRLxZKVwR4Qef7wvynSeap91HS6G4piNNGnZYAAfBE0KetoaNmNieanBj7Kx6ODIUcJtrsDlKjzDpYYBujsO8nAoqcK/e58mg2KPHWDy441RdJGV3AABBnK0hhtI8IcWdknmFrF1/FR7kVDBzPQgZiJYy2ZC+b4qzdi3cEx4THyqR3ggPzaIdy4EL5j2pKKDdo8pRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8AY/fOfL6GME+8H8n4tj86T+0QhFPVis3cGv0Rbr8kI=;
 b=XhMvxDL+pF2/+AtHhZq3qjh2eQkwxdh0TkXJ04ZIoFcoEDL/TR9U8eLwcfGnkNDQo4wUXy66u20M3DzNEmt3zTsg9pSq8B6dqq62kBR7XGg7D0d9UQok9lPBfoOh18TT6q994hwuIUFiJ8BPdJWZ0um5tDNwII2/DEwi9mDnQypkMMx0m178xm2z82UddxpT4Ee0o8kTyYvWF6P7D0LNZ0vjuO4H0dmp4P7BoonNdo5as7nHuYHGxiKv7WeyKErg27MF9rsZKq7SFmhVVXmPIjcCUJsk6AzB0NLQFif8ozLkmlKiNvjZ8lXsFcR/Pntjntc9GUKP3vfTAgtA3TJqLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8AY/fOfL6GME+8H8n4tj86T+0QhFPVis3cGv0Rbr8kI=;
 b=wVxQyOHqeBFzHEwvj0ZnsmadaiB+3YSt8pEn16nH6SqywpPvJeociOucMrV6Yz3N0EtuvwFvqaL5WYmU3V43QZFy8VZJnrWDN0ThDfQ1vOIPGHp7xDDBKBsGiFBQ3EwaLauAsugLfEVDCdk1tp4GbyFlIZZouNVSHbF8AOy78Cgc1oXcYfhykBvZH6L/QdPoTyBtdPp9Lf2NE2KWDXmPbbUsqQouHf05TqeniaW5I5aoyoB8+mv4ho3R9XkdjTXQTPVRvMaVqQb6N3xeLUQJ4DmRVJUqwPaKvxy6FMNdG8/jNu86WbfS9VDwsnfX62IE67WM1m+oUpPGKHtkMhkOpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com (2603:10a6:10:22d::13)
 by AS8PR03MB7414.eurprd03.prod.outlook.com (2603:10a6:20b:2ed::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Tue, 16 Dec
 2025 15:09:00 +0000
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::2e7d:3185:676e:2466]) by DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::2e7d:3185:676e:2466%2]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 15:09:00 +0000
From: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Wojciech Dubowik <Wojciech.Dubowik@mt.com>,
	trini@konsulko.com
Subject: [PATCH 2/2] binman: Accept pkcs11 URI tokens for capsule updates
Date: Tue, 16 Dec 2025 16:08:29 +0100
Message-ID: <20251216150841.331408-3-Wojciech.Dubowik@mt.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251216150841.331408-1-Wojciech.Dubowik@mt.com>
References: <20251216150841.331408-1-Wojciech.Dubowik@mt.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0149.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::11) To DB9PR03MB7180.eurprd03.prod.outlook.com
 (2603:10a6:10:22d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB7180:EE_|AS8PR03MB7414:EE_
X-MS-Office365-Filtering-Correlation-Id: 4501817b-31b6-406a-d12c-08de3cb50af4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|19092799006|52116014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WVsYjbpnltf2L+XS4FGQsLANZn5dYhk6jCAgnjiIaH+T5GGFzCaxup8xiqpT?=
 =?us-ascii?Q?fwCj9hIAcXg/il3z2k4A5tJ1t4XXBFPbOyqi8g7RKD8j2h3RMQB6rYXvl94z?=
 =?us-ascii?Q?X14/h5nIo23QL4CA282TFP3MHewoNB/QrIHKvF1B1t9N2hC103/e6QVeUXhp?=
 =?us-ascii?Q?icOf26ps+1onswIuD0Wekfb4ldNm+eSJt7cXUXoYWNV2WvC9uP/x+4jrYdEP?=
 =?us-ascii?Q?0EIqQwXRkesrmVuHMS78dnsHcD6X5qvSp9YiSawHNtYqIRmDQ/Z2dsgvN6R5?=
 =?us-ascii?Q?W3rUYaR0r2Jtv7svEvIcsVd3YFUfG/6aKKTLzE269Hz2MZn8GhDOa4XltReK?=
 =?us-ascii?Q?uHDj/76QNFD00ihvtxPRhbHu61F+VeyldLN5zvPrAPEU0xN68zPuTycPyodj?=
 =?us-ascii?Q?NtUXQ2UaSIfviEjJzJYPHTxMP47+B1axZYQa7ypWIl7UtFPBuUtDdvE7UgAa?=
 =?us-ascii?Q?c7+sywwvoaIvV1FF7xlSDOtLINIWvCEUwuIUeEU+GYPzLJeanHjpBxPnL3l7?=
 =?us-ascii?Q?H5/znyPd3a+fcMNr7HNL0+C5GBaVPD5ezX5liF0H5P4kSXUgWR0aFyLUSH+K?=
 =?us-ascii?Q?OpDdN7ecZWOp3zygbJfkyz3s73gYngamUQDlifRYrsvUn/ZnSyatP3S7BgsR?=
 =?us-ascii?Q?aN3h0RSFE74/71mYwZjdSD2R1O2xA99/OmwaYWshAYyOUGdahVowmeeQRFHK?=
 =?us-ascii?Q?75kSFwv5BEqcSdPPxkWfT1AmteHoTz9yP2Jmf87M+1yNxuugU5HLHAulKRRK?=
 =?us-ascii?Q?hs+jTNaX9EwIZ2WxsvuTWe8a9k+oTOEJ7mQT52RxufIbQc8NI30G3PVFiRaN?=
 =?us-ascii?Q?biVRb/bMSLG/HP2CAHd51EzvVB6Cg4vEEYHTeYD2nCU2+qAjhClGj1c9EgjW?=
 =?us-ascii?Q?7cHcYkayLBCCuR7MWrXnzjd7VLTeIVXDJFee/lWQTSNrWMFIvMoevjAoI9P2?=
 =?us-ascii?Q?N6yPIrEH9W8K9+hUThsjRvT4JbScw9goDNh9T7WP/cgibopfHf2Vxe7OWTza?=
 =?us-ascii?Q?tFZK4lcfz0S7BMo8sJFw7JaAyIAJ5j75lEHbn6GYZqiJkJyiPRYMekx9SMBe?=
 =?us-ascii?Q?4zbjQT3EbaBKqfxL6fC3S3B78J5Q0jW3RCNewIjt519Qa5e5O/pL34AA1Xkr?=
 =?us-ascii?Q?couEpY7L1Yc9duoyh6s4wk0twhmtdgN59v4WRepspmBWhn3OWMALPz6R6zFf?=
 =?us-ascii?Q?smRR2xJ2OrEEBvVGIrGm7hMbn8kWSfYBbKwAmYr743DRXSIjnDAjOUVscuXr?=
 =?us-ascii?Q?gnCkTORsuStDriUpzPHtblmSx48tQo6rFuskGb0Q2NvLjhBDfGIWNYovcWfG?=
 =?us-ascii?Q?PATuhAcacoHphNoq3m3JSj9u4ZDjtzHiZ7FlB9unM+RKC3PLDnLqNJ0uXmgu?=
 =?us-ascii?Q?iJ3OswuN+EJbtsmSXA9d0hKC5GNxzjGmDvdejeyY+gwW2GbfHHyvSou90MOr?=
 =?us-ascii?Q?/fZ/vAeFdJNv8o1RYBmnAxFDAQ0vkKN9CPRsXa5gA3a20RoLxliwmjvPGghe?=
 =?us-ascii?Q?iJ6c2uLtQ08oyqifWq1qTlVDwX1s4DVwr2T3?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR03MB7180.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(19092799006)(52116014)(366016)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KtOufKZ1nONIFZ3UT26AinCARq4D0vz1IxkPHjMC6/hjDbyvspDUephQ67O3?=
 =?us-ascii?Q?1YFmOikxOpmq+1UwMbHwBFWXnODycFrclTWMu7h9XPz0OkIOo8Vq51IZ4PX4?=
 =?us-ascii?Q?M/qcQPnwg8uhhcH70TvZcskx4M8LLqY+TSSjI/LF71+Z3Q+dTQvXd4enbrEl?=
 =?us-ascii?Q?IUypIBcJNPD8zDtlP1/OR3PBeNw6327Sgry2CMrWFPz7vHmvHMBrh2hPpdH8?=
 =?us-ascii?Q?wUNSylQEeakJyN7a25294syBBelb2ApVsq8jz6mtcO2Hj5GkzUdZa1m0qH3i?=
 =?us-ascii?Q?WoAUVSnr1G8XqfNHbY3iO6GWKmcaCclAeYohgtEyxvBWX7MBzcfyv71140JZ?=
 =?us-ascii?Q?IBQuDUeCKQbKIDeprk6x7aMlgaglrVWd2arofztcvHWf3icAEQyLGUyz6meh?=
 =?us-ascii?Q?rGzUneeLIUDZA/2U5M3RgVRzE8Qa+HOT5FTnjA4W+FhXTriZoqR8Y8Wiz85g?=
 =?us-ascii?Q?PGSpBBVbRTvpZqFVPl8bR6Z0ES7f3yfoPhRYRKvMaV599Atew1VKd+TF98XS?=
 =?us-ascii?Q?o5+RCHL6JcMqiq20dGwO59oIIFrnoZY22/0F7RL51g4Be0w84bwF3k75hdEl?=
 =?us-ascii?Q?s4sh3+uoKCwtje5APtfZcErqPajSy52GzkgVwD+oBm7z6vKQG3HX+Fyz80AG?=
 =?us-ascii?Q?ux18b+Hidvhi95/PjL12BcuAFge5eB+gRPM+6X2zSbv1tu2Wtd0pYusCzxqr?=
 =?us-ascii?Q?sO0A1zUSWFnqje9fb0DSydq/S1AVLd/GQLQsfDKFlsyRspxiUGFUFDtMxGWS?=
 =?us-ascii?Q?G/Dyh+YsthJV7Xf3u3DQpsE8h8XdT/cEApuJMCPSDGWeZ/4m86IlkZmEIB7G?=
 =?us-ascii?Q?uzSR8sp30rVzHWaND4lvkHhRJ07kMPKYAf8fYn8PWQzA6bR95YxnyGwufrx/?=
 =?us-ascii?Q?C5DN8zzga84PX5NzPiW7xm+k/+A0IgNaSNTI+BepQDGpCEXJfDNmj18NW+Lt?=
 =?us-ascii?Q?OXXu67iKtzxU4VCYUdQIZ2ROjyznTA0tWJmd2qo7Tpb+NtmGUKkD/hTozZ1Q?=
 =?us-ascii?Q?ZAJbwR6HK68tQHRYuqD2HA/D+7Xbza1X5Vw+pzdnfgT+F3cVs6ENWjgSN9j7?=
 =?us-ascii?Q?XEofH+HRw8t3jyj1u6+uozkHJAE9gjaSRluuggUq9b+rw978G9D2NcnMRXyn?=
 =?us-ascii?Q?gH9TEg0vMQ5fOWQV0sw7z/N/cEdn/wZpRa1FtyTERd6phx/jJYlbzRix9sF2?=
 =?us-ascii?Q?K8zKnonyjy7hpXr4B4X6LyhD69iaKwk7Ary8N5/1uxTysC0K3n/nkTtqM7cR?=
 =?us-ascii?Q?XLi1Q26+kWCQimzGKE94afQCtt3xpQHydo8xJ4Vm//xxuQG3hoxmme7zvJ4H?=
 =?us-ascii?Q?6t07GOE8ryZcH4FanNkuWa3kVxEHMoOIVJZDK+co9sYQ+qXLER7PHgy2vnFz?=
 =?us-ascii?Q?8EtIlL4c81Xatensp7Uxg1+HedTIDO0cZMO86O93rr5iLk1Qa0rDxU778q+9?=
 =?us-ascii?Q?+T1PaqYenupbRgZwYfX6L75iS9hdifG0DDFLzqSq8zd4LYjhitKakJM9ov3S?=
 =?us-ascii?Q?WCibF08ZrD89dM2gwyzhPBxaPm8K6HA2cQZJ6r0mhs+rKv+5qP8knZ9K4/R4?=
 =?us-ascii?Q?87hSVXrtE5j8eE4yqGZG89db3KKAPyV2eyLwpa4oprnWBQHHb9TpZMRaWxr/?=
 =?us-ascii?Q?Aw=3D=3D?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4501817b-31b6-406a-d12c-08de3cb50af4
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7180.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 15:09:00.4710 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qfRr6IiG4PFUqAMpJpsSmlhuYGdTcXC2L3S638NkChU4/qZJmd/UkIa7aTCT1C0hkyFaobDwkodyb1H4HUb+CQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB7414
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

With pkcs11 support in mkeficapsule we can now accept URI
tokens and not only files.

Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
---
 tools/binman/etype/efi_capsule.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/binman/etype/efi_capsule.py b/tools/binman/etype/efi_capsule.py
index 9f06cc88e6e5..8ab022915d9d 100644
--- a/tools/binman/etype/efi_capsule.py
+++ b/tools/binman/etype/efi_capsule.py
@@ -125,9 +125,9 @@ class Entry_efi_capsule(Entry_section):
         private_key = ''
         public_key_cert = ''
         if self.auth:
-            if not os.path.isabs(self.private_key):
+            if not os.path.isabs(self.private_key) and not 'pkcs11:' in self.private_key:
                 private_key =  tools.get_input_filename(self.private_key)
-            if not os.path.isabs(self.public_key_cert):
+            if not os.path.isabs(self.public_key_cert) and not 'pkcs11:' in self.public_key_cert:
                 public_key_cert = tools.get_input_filename(self.public_key_cert)
         data, payload, uniq = self.collect_contents_to_file(
             self._entries.values(), 'capsule_in')
-- 
2.47.3

