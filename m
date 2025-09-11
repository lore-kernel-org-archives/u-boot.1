Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D482CAC583
	for <u-boot@archiver.kernel.org>; Thu, 11 Sep 2025 05:12:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDBFF8331F;
	Thu, 11 Sep 2025 07:12:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="FJsWvuK9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2781C832BC; Thu, 11 Sep 2025 07:12:35 +0200 (CEST)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45F5B83236
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 07:12:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FwyyCJ5x74SxVwAjfIR52AItZ7PCCZgS3Gqc+uPdjVGomsGQNn4N7gh2FenWviU7dyCghNbl5MSOEdOmOH5VwqstStilOFPLK7IudXJ2Su0SZ+SafGpkcurqN34tHcdTRaQ7teV2/h1sBt3i0plqUb6CWtUf07SEGHQKSKt7bRfcmyQ4TNn6cruOkv2n04ZHPGMy4jKSNCc7AxZD1mS22KWQ2M7zqLFswR67II2jiOQlC4dV+AZ7Aiu3vJb0s+n1i5Ce55fy88ENQi8L+Jp0r7gRcBg0BMPL5Csqp3jCMNXeqFbk8ndq64QMtfAXok0U4rasEDI4Y9eLdnJa9Ef2lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9y0Hpyh3ZeK/nL91Rjm75f1WBznjhmpbh/8Lz5mbYz0=;
 b=m+A9Oz624kv0jjpzDPr+q4gY3szOKc93l3lvfizU2s6Y2AogKBfg5LCNWAZN0NVHlklozmYyAgklDNrncRnBW6aQWc6E4fX66+cEAvoiEJZVAlr+EFE2ByTqcowgjiSK3wns3hkSzVQvcvozqMqbR9v3soTJSZ++r7ucpunypJOaURDu7/gRW0vRPb/1lv6Zd/HzT456wQWx2Yd7N4qcORod1gGjrW5ki/Z3+0CNwsj5B7LLSx+MKNroCRl5eTMwjQbbSnqPeYotZEsn8xPYVYPEbdq4F8KR1Q/fhvLQzSBCaf7xtwpfm9CeIKNZPMcZ3dV58dNOeHwzQmbLurHj/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9y0Hpyh3ZeK/nL91Rjm75f1WBznjhmpbh/8Lz5mbYz0=;
 b=FJsWvuK9vcEnJf5OB2hi+NAVzxXyMrK8FM49YTp8l31CrZ1eY3yOfqV8b6UNlTb9nKu+HF72Ww6iVizn5R+iMyHBMV5bGffBiV5aM2vIFGNHGjNfxdc2V02aJK9Qjfqb85WGFdWYhuw6xbSs1lcatt9ozYk0MWxZEYYknbRCa6ExNQRy9wbGckQKqBFqMfVvU+r3L1XS0Wop75n0xFnqb4Sd/nZsuqq+neYKDQxEjBOLk4i1LatXzFvwtTcigmMGGfFZAUkr7zqQm7O4xGodkpAJ3WBhwmlmKNR5CJRB1nQFwP0BYFxYafVRaPeWoCG/8YzzuiYK3Caa/lpAw8xaQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DS7PR03MB5542.namprd03.prod.outlook.com (2603:10b6:5:2c5::16)
 by DM6PR03MB5050.namprd03.prod.outlook.com (2603:10b6:5:1e8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.16; Thu, 11 Sep
 2025 05:12:30 +0000
Received: from DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::4e88:c0c9:a27b:8f13]) by DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::4e88:c0c9:a27b:8f13%4]) with mapi id 15.20.9115.010; Thu, 11 Sep 2025
 05:12:30 +0000
From: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut@mailbox.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
Subject: [PATCH v3 2/4] configs: Enable USB DWC3 host drivers for Agilex5
Date: Wed, 10 Sep 2025 22:12:05 -0700
Message-Id: <20250911051207.10479-3-nareshkumar.ravulapalli@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250911051207.10479-1-nareshkumar.ravulapalli@altera.com>
References: <20250911051207.10479-1-nareshkumar.ravulapalli@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0015.prod.exchangelabs.com (2603:10b6:a02:80::28)
 To DS7PR03MB5542.namprd03.prod.outlook.com
 (2603:10b6:5:2c5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR03MB5542:EE_|DM6PR03MB5050:EE_
X-MS-Office365-Filtering-Correlation-Id: 186a6429-e86a-4e9e-13e5-08ddf0f1ceb0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?F75CWKrpJIohqEUKUsCsLh1kV6KF7PQY37UH7xKohwSGvA5OKsWhdwZ4lZRN?=
 =?us-ascii?Q?mZJ8l+kqZMkV6g0njY5c19ZuYEmlRlZL17k+3WTJfli5vDzGF8FhX3t/25T+?=
 =?us-ascii?Q?zOHX3vkFUZkoxQ8GF7tgqzy1qQu+HtjFOm5CKD/wjU5hHvXECDFufmjRnBeI?=
 =?us-ascii?Q?Mi07htIN+BK3lPuCi8f8gZd7NA2TV7wPYJQBMhfxAhjKY4698/WatT2ExtxJ?=
 =?us-ascii?Q?QCWvP0/NGncJyRIIN+idOqyjmSjpciaCTt+IFQQ2eWTXdG31E5nbXCXc7jEE?=
 =?us-ascii?Q?Ey02bqZmrDu01tQ23Pzi0IuzElC455CK5QTT1mfgzU752WFkLw3NFzCSAUHj?=
 =?us-ascii?Q?fx103Rn0SsdVLXsBCJMlObYol46vmO39IfwQAhgtO9WzC7FSQzv95UR/EZwb?=
 =?us-ascii?Q?WQUZmsKGw7y5Fi4LwFiT2rIcphacIIFW6kw27a+Tbro0R9k1SeVp7plmq97Q?=
 =?us-ascii?Q?pJ4B0gAf71aVAPDUN+YY8QqI/iQd2TNuvhIU4l6KzJJeT3q07rXwmOUxwvj+?=
 =?us-ascii?Q?cD89B1moknvr1t+fIlZLa0vzO8EbV2/4MIyf6LWuQBlHVZg0du+DmWt/E/ni?=
 =?us-ascii?Q?YbdIrSm+slAzvArSiJD0oKOz7Q67acKUqj9mImykXU3uSY3EA4opHlLNTQ/a?=
 =?us-ascii?Q?HPtpbOMNUZv6rsrVNq/5Lk18oGdX06XizJpqrf+Ca+u5BF9/xu9M0VzzWi0p?=
 =?us-ascii?Q?rUv3Cv1TnFc9NGCRGubg6ySdd9cwlYHGPMoPzFgfNK9L7l8DkDwWuC9ZUqjd?=
 =?us-ascii?Q?JQbR8eR5fp0P41UTJBUsmH6KQWDXUC5GFkDKJyey8E6Ou+nvdqvBKMvR35Gf?=
 =?us-ascii?Q?YMnNeqaDKb/gpx3UWzWub4/mChlXjz6snibxGI1cY44xtlF4iZOz24rImKVv?=
 =?us-ascii?Q?/XcQW4jJfI3dfV5yVYP+72G+U/k0jYKO7fqXQIhuwe42JVmt+OvFjzGQJLeV?=
 =?us-ascii?Q?OaqUJgwQB1N3IxTgNF41lE0iFPVyJ7gTu3RxwY5YKONztBwP8UbwEmvuFkJu?=
 =?us-ascii?Q?P4yTWJNaz74669OAKzQRq2gcs2a3que6eNppN90b9u2Fm/oAaWLEow9CuoEd?=
 =?us-ascii?Q?XXxm4g8BiCCF/GZrvfjLPE/SDcYUhRZZLeUT82sNrCy0gENkk2UqYBfZoLD6?=
 =?us-ascii?Q?HabaipU7sPl98soXc4wsoFhaWzYQImDLtmYo1SjAdP5kmww5NAbWPYo/SoRR?=
 =?us-ascii?Q?h7tBIxayamm1N7T0t+h1+6zHIm3v97UcX6YTKr6QLaglcYKsZp1NpFehLA8m?=
 =?us-ascii?Q?zkgeOYY1JXV9mR13q0j6qfjlbqw+C+cV6anBeJmVsMf9eg2MJ9y/um0+LWAc?=
 =?us-ascii?Q?vGMu1AN6ERM2Us3PULeQdOHyRue+3G0VjfETwfqEnxc2quTQUGquXUjwuvMd?=
 =?us-ascii?Q?3RBupGVBDyJWG6KhakmzCnp6mQTI4Zo7jPgvo9Vv3VUsePihFJQkSGz1Qkwu?=
 =?us-ascii?Q?Gucg21tWYl8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR03MB5542.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?isdx/4SoKXxOoulwjE4F+4IrCCD/Y/NPJzC0PdWq0ro8xyuAHqZD4dwa8Taj?=
 =?us-ascii?Q?lKfJrQIqBJxL67BJ+HXiBFoBYUsFCIHQ71jD2ijg/4vZCDkJr7xGR86/wzFK?=
 =?us-ascii?Q?4lqw8MS4n+NyIsX5IefaE+HKErpvhuMWRPOasjHEt+CiWb+9RmMHcVG6oheh?=
 =?us-ascii?Q?QgmaiI3hOegsw0NJej8h1QBqhvQrUn2JPNrtQpw/DT6yW8jq+TSq0b8f8fFg?=
 =?us-ascii?Q?gZyYE4oVdNFcCJWoTni2U6d67YqUpUkNzZ9rvd1EQf8sbj5DltCQAVgEXWX6?=
 =?us-ascii?Q?fgDIEDXo0GSc/QwiQNSjsRACbQZvOzFZWvSxTLGUzXUkwOAPWMh+ty1jteXR?=
 =?us-ascii?Q?q99dLHK9i8U/95UyJcQ3A9slfHBGgBV+5fzcwUeCXHNMZuiJfDRi7vk9dehO?=
 =?us-ascii?Q?coGqu7kKFeESywacsdGjzbjwKW67c0ycVUy1HPkd7m8eVWeYQddimKvlnvF9?=
 =?us-ascii?Q?NTOspcqRNg1uabnv6iBbAydwfElOhy6PPkYhBsg3VrRyN0zOHlDhtulne2As?=
 =?us-ascii?Q?pwbQIpsMHuiVpZmibDBTUo5ix4kUY6jYpcm3Mh/lYXUZ/fJ2nP75djs2NVRm?=
 =?us-ascii?Q?YTOlVO+OoqcER+Tqo/QjUWHOMZP1Sql/PjN2xVb4aEzS/9C70zEn53a3NDtW?=
 =?us-ascii?Q?gtBe3BhCPVWMsqBEsSN/9VRfbjBC7eN1RngFx6vsyNbrEB1WpZCOS9/dQp1l?=
 =?us-ascii?Q?yofoDO6iuPAhxSakCWPFqDN5kgGVSgsrMZu8Bg3cRu2ypqeudbwL8R/Pboq6?=
 =?us-ascii?Q?WPuHLt/sUM0G9dzsOoUTOcWsOulxuIoXLvAtfydCJRD9IPNK3a3CqTQ+cQMi?=
 =?us-ascii?Q?LxtWmK+Mm6LGTEoerpbMh6OdyjEGZgXCu7s1HB1XzVxOltE9A7stUNtbOZTQ?=
 =?us-ascii?Q?sGAg1HGiwDMNWptOMWopmqrPQ8sVNfbrkIlmYZ+EsEozsB7su3dq46GubLMh?=
 =?us-ascii?Q?rcnwF7IfmvUy1aUEt6DAVPE1pcQp9Xde6cHd4/sjVCy0lLIRB+F5gvvKksry?=
 =?us-ascii?Q?aINhKROXyXc//yXD0EsVbYYl1eusKpHNJXdXqbiJlyr7hDym/dVl760JYJpm?=
 =?us-ascii?Q?8AvAy0kaHZjU9CNgKED+c4nooZIyPyAc+w67CEQwbw1yY7d90zQO0qH7wjlp?=
 =?us-ascii?Q?Gs091UiE/cgsB5cdtQsRJVKBq+tIPEdH5xabL9pbsIsWmm0ORKGj7hOqrXmy?=
 =?us-ascii?Q?/mSMilporri1wWllqFBw1m377q/WK11ipdNMsh2v3dJuc+msop32Tptohaqj?=
 =?us-ascii?Q?HvrLDKLrAWbZ+0ynZ3hDKv16DZl8w7zRX7jj8zROGzkdHGZ8V6DgDFOFTIAO?=
 =?us-ascii?Q?Ijf7krZz861Axa8KXf9BwtN5g9ox3G3uBmS6c/n+WIwTBoCiFIkksXM9uE6N?=
 =?us-ascii?Q?uxVJR4AOXoSy7Vp2wmY+ziME1d2n/vlFi/c5fJTXcAVY4KzPdmZreRuSJ1w7?=
 =?us-ascii?Q?pd719SHPGSA3bGrTarR0uMW9xZXQRDPQv88Xz1uAy7DURiJ0E1bwyfMP7jyb?=
 =?us-ascii?Q?kc0GdPxB5yYDcWiblUcBlm/866eUiybzKg078AAvJ3LhGZtrBUGCy5ZyPe1t?=
 =?us-ascii?Q?6yTifosv/zkomoRAqqibNiJ6vA6L/WO73wPmpfW9tjjd3JWS+Mmjc+NCNoOY?=
 =?us-ascii?Q?2+eqqIWp7m1RQH8foEdApNg=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 186a6429-e86a-4e9e-13e5-08ddf0f1ceb0
X-MS-Exchange-CrossTenant-AuthSource: DS7PR03MB5542.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 05:12:30.3655 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iNfuJwCf1AvX61RJOUs5MlukyP0Tg7RpvelI6BKJb0ji+q1EY0lKq18Al1w07powqxXrqqwkYpMf+GkXnxDsEnqQNf0nyTSgaXB4Rb1sTXHXfbtUdaezKBugiWhrEuZB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5050
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

Required USB DWC3 host driver configurations are enabled
for Agilex5.

Signed-off-by: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
---
 configs/socfpga_agilex5_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/socfpga_agilex5_defconfig b/configs/socfpga_agilex5_defconfig
index b373201dbaa..7cd2fcbf4ac 100644
--- a/configs/socfpga_agilex5_defconfig
+++ b/configs/socfpga_agilex5_defconfig
@@ -101,7 +101,9 @@ CONFIG_TIMER=y
 CONFIG_DESIGNWARE_APB_TIMER=y
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_DWC2=y
+CONFIG_USB_DWC3=y
 CONFIG_DESIGNWARE_WATCHDOG=y
 CONFIG_WDT=y
 # CONFIG_SPL_USE_TINY_PRINTF is not set
-- 
2.35.3

