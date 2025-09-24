Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1495CAC5B2
	for <u-boot@archiver.kernel.org>; Wed, 24 Sep 2025 07:50:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21D7B80107;
	Wed, 24 Sep 2025 09:50:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="RKdZHqxh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D82C800D7; Wed, 24 Sep 2025 09:50:12 +0200 (CEST)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9EE5C800D7
 for <u-boot@lists.denx.de>; Wed, 24 Sep 2025 09:50:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LSKV00imGAVj+bBYFW5/nYcBIorTrlcqe61fO3D1XJ2YmdsFEB8M1+rXSI+o4QRssmHcYOAvvp6IGFyko+76OQAfPfEf0npFr80XwiT0upHvvgCMxzhh6loaDf2jF8LH5VUehEIm5Q2XT9Bx78Hs/74YYM8jRsVkK0Rt85+4Z5gVa4RyJQwnyS3u/zAtSTghfMJr0APmhLVetndPO26+nVFTkb52WYK2VUgcWzUWhoVFNVQm/vCALjsMzWt0L1X/gBF8sGQJ4uVZNPy3OTX2PhSGBs2IMf7c6qb0PQJtpns4mn/SabOfkd2U1OK0ZXNbn0UYDv7H93tBNz+qWvUgtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BSH9RHpRjuR2ndJtV6y1+iMI1XA+HJjANaoebskzf1U=;
 b=xSkkQ8kFN9nkjhdNewD1U3oEi5e4/mKiwoTpui6CUwRdcoW7mPyckzFX2A0BwglxKL26VwWQRntY/UBf2/e3J8gGRNSMqp3q+SkzWbw3cLTSgusvWXC1CvkMbHP5sb35cX/HkolPE4I9LVHea0IQnJsdjAaUpJ6+x8kxEFL7QXEQxV4dgL4AlEp7G9VHEwCfVd+lChS0SPIzO088se2zuvCABPiUAurdEKRZf9srLeVxhCJsIK8twdr5Vk2coeV4jePDfaX3FOW7vVrufNhQvEFbVZmHykLcIMbAj8cR222QX55FLwrmFQIHpmCNDFk3hROBrnQ1JWImVnQ0iAhjDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BSH9RHpRjuR2ndJtV6y1+iMI1XA+HJjANaoebskzf1U=;
 b=RKdZHqxhscj2JBxTwh6FyuIUIOCG4jgWB8fzEmazgcCNRqi6B+3Zme2mLszxZSrSI+0EBmrgofSw3K3lsLPpYq/arRF7Mlg2JNeVdV8GWdEiZmGWS6rF/FOVuWiAUa3lmPfLnnbChy9o490h9hFRieb5n6c8heEC5imPocP3n8FNGfeGkgVYA7l00DBH+ec1lDfycwyipZv5rcN9r0Y3tYi99ShlmdqhfX28ziMiXOjE6hKVsD3Pcy7nbL6HAwaNqBslAohV4M+NN6F3GO2MX4slG2PfAPTuwl3I/lXf31jF24WtaNE78JehM5m15D0nzulSVh6CNXY8tuzHM2k60A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DS7PR03MB5542.namprd03.prod.outlook.com (2603:10b6:5:2c5::16)
 by PH0PR03MB5847.namprd03.prod.outlook.com (2603:10b6:510:35::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Wed, 24 Sep
 2025 07:50:04 +0000
Received: from DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::4e88:c0c9:a27b:8f13]) by DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::4e88:c0c9:a27b:8f13%5]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 07:50:02 +0000
From: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
To: u-boot@lists.denx.de
Cc: Tien Fong Chee <tien.fong.chee@altera.com>,
 Marek Vasut <marek.vasut@mailbox.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
Subject: [PATCH v4 0/4] Enable USB3.1 for Agilex5
Date: Wed, 24 Sep 2025 00:49:07 -0700
Message-Id: <20250924074911.15538-1-nareshkumar.ravulapalli@altera.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0P220CA0017.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::27) To DS7PR03MB5542.namprd03.prod.outlook.com
 (2603:10b6:5:2c5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR03MB5542:EE_|PH0PR03MB5847:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fbe235a-b792-45f9-0d06-08ddfb3ef76a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2M69wpMqJ03C0RbcATvDrm0xIBGwR0OoUgetsytktbqJc4thxlFP4cT+O4PX?=
 =?us-ascii?Q?uJh5T/izRy4e3kulcQpAimn/g75asSiewg6TDEtSVb0mpX7ECSxEaPSbCmbd?=
 =?us-ascii?Q?FzTsZZuZFAo+i4dnlEu9JYTKKK9A9JnirfhN1GVHA3POVykLHGnY7meftSWT?=
 =?us-ascii?Q?IOhC2XhhIJWh3ur1jaerTDGPoVhdaSmCoHQ2ZB1U+ga+z0r3bx9KopAIK0Hm?=
 =?us-ascii?Q?WBLq1PBL2KH+MDmFvtoI5gHk0zumxqXmuiXYpe9xkID4asr3r6Qseux7Wjly?=
 =?us-ascii?Q?ItDiclE9mJJ6Nyxai9hC3PZ1l2gTfpnE/9kFrMvvtPDoNZDTavzkUjjXKZsi?=
 =?us-ascii?Q?M9BhrMyts53L6RI1RMSPJ0ZxFwEb1CPJ7XZ5rCgXiyEbGJDK3yi7VJrBCfCG?=
 =?us-ascii?Q?Oac3Q2sqCujDg5zQU+o+8NIabt2UDTjeTHFBbwz4kVmL6oasgNSdGCgG0kIa?=
 =?us-ascii?Q?EOeDG8b35c6hFGBe3cyCUZoC0j9oSIxvUdyhXbymtLsayCqqbt5up1wdG9dZ?=
 =?us-ascii?Q?+9oygzuPt/4hLcl9nNl3HXmGHTk0Jr+xsTx+5xHFrq/ItSTO2Ehr6yBIseLM?=
 =?us-ascii?Q?A7uiNuKaHIuFEvacsDsykdeRENUFGg4mAMa6XkLiQSWwfip96smK96UcTWDA?=
 =?us-ascii?Q?Poj/KBcX/FJ5BaT44BQ3ji+6PxwCUJlFyZDM61cXdHmyiB8jB9kZ83UVC7+K?=
 =?us-ascii?Q?WzFM4CxUkE6+NkN7LBop/6xIKix2KpkqM4uEC0gWfHeSuCXSyzeIFVVMOujo?=
 =?us-ascii?Q?oqJ+BHEKTy7cOysT3MOdgUmAmcrMub5ohMqL2vHjrDHxIU0gHXH52sG1qhcE?=
 =?us-ascii?Q?/49yZwwn8qm2Zec8BeTUe4ohsrXT30NvFxxCLrKWeU+/ByDH2CtgJ/hMAdc4?=
 =?us-ascii?Q?pSFIplVKl0tyvnZQXfKS6DTJI8DL/w504eCbj3Eotx7i7RtRRBAmjtxnKprU?=
 =?us-ascii?Q?pjvkYS+SQkjljw0yeovg17c9p/0r9Yqn67kzE32mlXZApJcr0IuqvfPKyxZ7?=
 =?us-ascii?Q?w5tA8GgmFSvgTvLgQojTjUfsxp6TN8skfBcSX5Mkr08ERSlgSUeTOGlAagZL?=
 =?us-ascii?Q?enSLKjfdvjwHe8jAGebxtxAygSeRzfpAtb2wFNZiM48up3tS/7djsCIaW3WD?=
 =?us-ascii?Q?40mSLNbNSfSybkb+/tS3eAPfFrKevwe8NQOf0gmsIvAKKOfe9aBn8OhFkWDU?=
 =?us-ascii?Q?8VqCrbjrJgaJQVQ55zXJrk0Jeh9dl7bFse2A8DKnyLLEkU8Uf7JkHs127ZjK?=
 =?us-ascii?Q?SVtBS3D1x1+3+QMtyG/8n/8YQi2l+553cnFviMiVp/9rpstzOqmw6FleVc2t?=
 =?us-ascii?Q?d4lEyJtJSAovf8nyTo4tqr7wP6zAfUEQ2CC4Gh5fo6H1uBO19HI0dhNIu8Br?=
 =?us-ascii?Q?WcOPMyjN884Dym2E3R4HZiDhnIZVWCpfDUKkAzKZeq4QFG0DwQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR03MB5542.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fQwLLYU1+nGLLRXcn8SvfAG7jDZU6eRX8rKM1CUkyW+KOByH0tNf1qU7LC9Z?=
 =?us-ascii?Q?SfLXciqeneA7+Anc9v2Cr6AiIl4D7VsIjbtPSFdSa5kYKqRSNy0AMWn/DksL?=
 =?us-ascii?Q?BoR7bkNlGJTS7t25KzmumQ9KeA7hksyo5huiXVBEW1EVRoahmCTi3N8fOvoR?=
 =?us-ascii?Q?dHOBkGWa7F0kKBJSCT3aWfqjbZN+tAkb1wXyU6SOATz9oix6jQ1Ce9AMuEnr?=
 =?us-ascii?Q?gyIP6AOMjfjyplQaDWzQwohx+YEeUhqFZD/pTaZ1Gi/sGSUBRYfUW43ABWtM?=
 =?us-ascii?Q?NIXFN8y3Qkrhf1KgpHYCUrgbWmzw+F8r6ur/AThjLus6kYAdNZDbBRprxGRs?=
 =?us-ascii?Q?48RVBqLljBTw8+6gpf/W95k6Z4K1h86DQxa2U/gT16iCczGJthLaEO9sNUpi?=
 =?us-ascii?Q?K3EQqGIlzvVomZMbA3+CfC321CQKTRU5+R56X6hkodgrQpbqPHRC5ekp/Ex6?=
 =?us-ascii?Q?k8gNN2VCkPpa/FAISgLSdjPixvuHn03s/lnpelU4ZrfKg7OQjHDDNYehKeWj?=
 =?us-ascii?Q?+50N3UuObpQWOfRi5/4+9HxIp5wO5c+vA5Df29VSJy5nKe2OauWY9lSUBqMg?=
 =?us-ascii?Q?bVMGHtzIXKSHFAZIC/oJTeU8MJi5E3EQjDWdB/cqdWS4/6SCluaH5FsEC7bS?=
 =?us-ascii?Q?kNbZCNHh1fYciP2TC4QI+wBGL4yv5mAcmQxwa0WlM5it32I7r3bXAonFYR1B?=
 =?us-ascii?Q?l7tpYcHLxOmZfHz9MaQi7PWrvKeVkyaxskjvt5K08Bsx9pG+bFWwzfdiLrKh?=
 =?us-ascii?Q?wNSUWNjnD9APWC1m5cBCzWq54XS4BMsZ76oE+oaBvrmO98XV/J9bTVB/BYnV?=
 =?us-ascii?Q?m3anroVth7Z07/64guz0hgIGm4353CVuwYpLbIuAYNaayydmZGAImF+CuM8Y?=
 =?us-ascii?Q?/74Wn+ljmfQCZBCYQkoJTHGUxrv+ca9mbUmZXX+0zgc0jvJbvfb43kyMT1wH?=
 =?us-ascii?Q?AeQ0AVs7eN15bW5dLrHxmLX4Dq1mOyQ0/a8WFwFKUBYkm2USImAc9xYCLk8K?=
 =?us-ascii?Q?2RI8H3EZhZyJgPxVjNZmxYs005e6t04YkJE9QGGKTGGQObeppsL0KFLKVX5c?=
 =?us-ascii?Q?/DSZPccEvjHgrtecAYIuCEzepnzZmy50H0GXUnXgjq+tZTPKXqWo3wXkW9CX?=
 =?us-ascii?Q?/vw0GdQqBpEA6iUAA4s+prJuz5QkDt6/4DO2fIjv9ek4M2vmJKYDeFyoxTuF?=
 =?us-ascii?Q?kWwGaVktSboqVNB6CaRXeuQ7TaPlcAhKWelexExfLNcHx397lI8kz8Pk9x2d?=
 =?us-ascii?Q?PqUxM1oRWwjiZGVd0wOIKbv3QyIb21ABoilFnyW/13w7XV97npyUcOxmUDe8?=
 =?us-ascii?Q?kkOM3K2FoOFwSdQ/MYK0HaS/wC4afouKTNXMgx8xDHb6nO1K1INn/fvy/lx0?=
 =?us-ascii?Q?PGI6s0K1IF8T9lSBJyHJbpYLUP/jeoG0cp4dbjSX6ld1LFVqS49ajqzcYTGL?=
 =?us-ascii?Q?4Ztuj5PqXevo4NXTMBbF1JHkTrJ+0RPhkU2wefJ5EaIUDPmSGEHOha94R/97?=
 =?us-ascii?Q?Uudh2vyxGoG74nLrQD7GeIkq3eWjIe8cFZv1BfqkSi7MMQFVrYz43ed7SOok?=
 =?us-ascii?Q?BwlkT72qaj9pPAmK/DqByEM61IfyHXiBPRBKmbG6SO6jPtdSSm+tONS1DA3V?=
 =?us-ascii?Q?wrQzUsDp69azki7XFx3CGo4=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fbe235a-b792-45f9-0d06-08ddfb3ef76a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR03MB5542.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 07:50:02.1771 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vCH8NAkx+ZlMq+BfGZIzJtt09ePClX3ocgPZsx9xOAWbML/UHFp14fMn4vKRLz75H8Fqh8SZNVhXqNC/RphjtPYWbuGpL9NxcIeqBm3EIWcKfHhJj0tGFzJ57a9ohey6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB5847
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

Required configurations for USB 3.1 are enabled for Agilex5
boards. Testing has been successfully carried out on Agilex5
devkits.

Changes in v4:
- Handle license issue

Naresh Kumar Ravulapalli (4):
  arch: arm: dts: Enable USB3.1 for Agilex5
  configs: Enable USB DWC3 host drivers for Agilex5
  configs: Increase USB Hub debounce timeout in Agilex5
  arch: arm: socfpga: Configure USB3 System Manager registers

 arch/arm/dts/socfpga_agilex5_socdk.dts        |  4 +++
 .../include/mach/system_manager_soc64.h       | 12 +++++++++
 arch/arm/mach-socfpga/system_manager_soc64.c  | 26 ++++++++++++++++++-
 configs/socfpga_agilex5_defconfig             |  3 +++
 4 files changed, 44 insertions(+), 1 deletion(-)

-- 
2.35.3

