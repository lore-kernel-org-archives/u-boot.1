Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CAA910F92E0
	for <u-boot@archiver.kernel.org>; Tue, 31 Mar 2026 16:29:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7EA9383E7A;
	Tue, 31 Mar 2026 18:28:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="ZVf0fJ+r";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ZVf0fJ+r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DF6384010; Tue, 31 Mar 2026 18:28:57 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE77083DA6
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 18:28:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jerome.Forissier@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=iXik8tE5tLQ8+v7m7GPTQ3odI4QIYs57qikV+B+wz5ys6Hld/Luy35pbw1hyDYY+cEcsRDDlrxDnWgCB/OdawvnE6mizuAkJK2awhHk0gXB4lawCHLdrIX38bSr7It7dHs/EYSRX4iiMP6NXqLips1BLRfuCpbFEMdkRyS3+El9oYYiRv+C5z4uqzcCd+ONQM870jXYCYF7PGdi4JPGQx3G446xa3nvgBZiRJ2ibDYjgGszObtiRadGA7/vcmfiz/NziUKXoA/11xj5nyjWIgmKDGHmqBeqVM5CmKjh3L+GumlHuk/Df2xD/rgTFk5c5Yz0ih7l/3HMPhMoZAJaAQg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7LHOBANZ57XeWaMhvFORGtejpQq2GVLFZFX93rJ70u4=;
 b=M0vU9wviFjjdZdvftOcf2x+OSQtglRl5G1fMy+E9zC3gUi8bWfIBTQcMt04hyK32bPemF/Ayg+P6ir94WWuuBRXjmwdrZ5T/MCSbKBAN4lQzEUriJBXmq15LCahhKLg0tqprS7UeLG0N3L9TARcX5K0pMkITHFMm8KCjbJxcRGTpdnrX3Az3KlBBhxInWS7y6/vaG2n+089Sd5XExxgjkOUDF69gZAfZJyFxU9ilVlEjBaEfO+WUqrxFmJHLlkLcHEANt/YOp+CHHSHpE6ZOKt1dH30vpYCOgGdXhvHS0KhU1h4Cnh4jZEJBWtLI24obaOdnCcBtHCEVViy96iJQfA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=konsulko.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7LHOBANZ57XeWaMhvFORGtejpQq2GVLFZFX93rJ70u4=;
 b=ZVf0fJ+ry8SRPS2av8tCBKa6eVB5NOnSTpY8uW9+4QxFUlHblqvl556beJlLbLLdUG4sjylg0OVUdZAbDOKhPpC3GQj6B8T1xfdHZsKAF58Y2kRgzLT9LjqMVJW9VJt4zy0uXhMIslmp/iJFLwzXThTyUszIjMF+wu2rJiikh2c=
Received: from DUZPR01CA0046.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::14) by PAWPR08MB9736.eurprd08.prod.outlook.com
 (2603:10a6:102:2ea::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Tue, 31 Mar
 2026 16:28:48 +0000
Received: from DU6PEPF0000A7DD.eurprd02.prod.outlook.com
 (2603:10a6:10:469:cafe::93) by DUZPR01CA0046.outlook.office365.com
 (2603:10a6:10:469::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Tue,
 31 Mar 2026 16:28:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU6PEPF0000A7DD.mail.protection.outlook.com (10.167.8.37) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.21 via
 Frontend Transport; Tue, 31 Mar 2026 16:28:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hT06Azz+jFdki9DpTwSoyIsAxq7mXNMa8JGAS+/z1mZU1ZqObpqioN2/qPOB7sRTLBL41UxKUGbwpd3amsEBV3d/PbIXwCyBYWUVM5eMmFNQh4+Z2kKcfp27aQnDDxB5gNWqM1fqhba0BylG+wMN6xiFKhlLlWKxJKWdrW8ZhcqIwjWI7M3sMUMOwtxhO071Q/todFgi0+oh3pjwVAflUFdOx19ZR9EDGmfZpIZlGus0nxA59uXHPY0zaPZvrjEC5bNvGYxe6LIj+BLX6Aa+aBbJumLE85ElvYCO32TY6T/SYg8wznRsxKc3zZ/8ZAgik4+U8N10+JiTQlVI46yUEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7LHOBANZ57XeWaMhvFORGtejpQq2GVLFZFX93rJ70u4=;
 b=UrSLf7ldV/yF3DFq84yqvIzzMNsi1C00rASbz8d5X0f1LpXa1fVni1hTDar+Sp/kiKOn4c8+LSFaOTxx6bYJVXA1QYmpYTMp5VOhpy4kznwjqjlG64Ear30mdbmRffCnBeQ0qoboYN7ASc6mBgMntnTXCsgyLfsvo5GvPRFfB1b4iX0hLUJNVsG0wmow9OW1nKVcE/jrDQwS0RgPvaS6Md1lI3De5FE+vvwVbdBFQbO8d0ZmkUXLLbRtsZp2z8rwD8c/st5Zzqp4QKJ+pJges7gGm5GIMIkoit2VhExr/HxhTAS/Q5mV6NiiVUBMxedQDB2IulwUNpAhwuv2ZvLX3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7LHOBANZ57XeWaMhvFORGtejpQq2GVLFZFX93rJ70u4=;
 b=ZVf0fJ+ry8SRPS2av8tCBKa6eVB5NOnSTpY8uW9+4QxFUlHblqvl556beJlLbLLdUG4sjylg0OVUdZAbDOKhPpC3GQj6B8T1xfdHZsKAF58Y2kRgzLT9LjqMVJW9VJt4zy0uXhMIslmp/iJFLwzXThTyUszIjMF+wu2rJiikh2c=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by GV2PR08MB11608.eurprd08.prod.outlook.com
 (2603:10a6:150:2cd::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Tue, 31 Mar
 2026 16:27:42 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%6]) with mapi id 15.20.9745.027; Tue, 31 Mar 2026
 16:27:42 +0000
Message-ID: <f3e46b87-6c9e-4145-9ddc-cac3e317d593@arm.com>
Date: Tue, 31 Mar 2026 18:27:41 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
Cc: nd@arm.com, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
From: Jerome Forissier <jerome.forissier@arm.com>
Subject: Please pull net-20260331
To: Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0440.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:37d::7) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|GV2PR08MB11608:EE_|DU6PEPF0000A7DD:EE_|PAWPR08MB9736:EE_
X-MS-Office365-Filtering-Correlation-Id: ed5998c3-f429-403b-a38c-08de8f429418
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info-Original: S1aYAZFbBhokZ6/WVl+2Tu9BNCPDMI3yXtTjxp4dw9AOtcg9/7l9Ws6QPJ87sGNqwI+e7T410VtB5VZyMY+lTknSkRfuv8S6g2Dx6IVVDLYX+MEfqUP7Wi6biQxRvQ8oBYT9UwSWC6OTBRvCrgKBymK3Dpfo74I/Q1Uu3Cp61YuqJIDRXAxSr3FhKMVa7oA5zySW0cyGgjwiluAaKWa5r9dT4QoTfLxoOjD6GAp+bUhlR4RrpZZyOVKtcGwzZ0APsoxXI5otx89UUmEgR7MtVeK5gvUC4asILrhAgsan/DnfXOW0M06Oae3/oUm64CiPJnHGDf29KEgAeg9q7HX4vQix3IMSw82iVCXIgVAH5K+o82eULDpUWzUapB1v+RKM8n2ensrBRYKk/gkFuhixEo8yL/33JfW0sz8qqcnocq8HDzA1ADgzmJUyusRLtMzeexGLctZcI7bVl9h+B3KKMFmCQv2bWs2c0XxoN9R9mw0pFfuOwJBQ3rMG1TMLtyPnnExLemyHX46JPjyuLtK9hKWY6OG0RlslWVALOosA/DQ1iRrnIu/DYRBNzpL0XvEe+N4/IGtcr73PBaKzjOEjYo/glkYMWVNBGcLWXJXwBbvJZ3xWTJpYh0JHCRQ5WkytwgrIp/SpU2V6XrMNI5JeeGAWA/VZ2E9JJ5imDlbU+2WcLeNt3dKWUKW63xYn/bwO
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(56012099003); DIR:OUT;
 SFP:1101; 
X-Exchange-RoutingPolicyChecked: HPyX0oyOsLdWGShyyZMUq8UDI+1hO29kyIuJLZ0KlPPPIdBONv8a8Dt4gyg2DCzkRxLdbOmCkMYAyw8TMw2pxAjkE6qnwvPOQMQTloCJBo7T1bxuFsRs+zU9BLTTw//L4vZmbSdRgqgZ24udhyaW0Ms/wjUReIsdjFs4P41I+SdkzZn8gQlJQuCiUE1wIJRfksABQApcqKQ+/4qmBwkHCtJ1iF/nF+bbpQ8dZkG36i3Io3rtcCf8peBAha1foQ3Dv/DwSkOHTY/QynjGTCrGCqZkS8k3YKWIcUyxH9d7Wd+ISsXCct0/D2EOpSbU10WIGzDIwqlWyMYl+78CNYkTfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB11608
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU6PEPF0000A7DD.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: b447a416-ceed-46f5-b1ae-08de8f426ea4
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|14060799003|35042699022|13003099007|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: ONp4bFk5plu23e6iyLWE32sU6Or8PsDHa3VwYHi4rwOYb2n9CL0kMxI71J70gqD6YGlD7vhEohwwDEWfX2xcuchXckLzAEtW9e67Uc3Q9t3w2p0oADNzn1Q0Y5p7O/540NsBB14vNHpGD41g7B/f7a9NbIj9cFA7+j9IfS1Q9nrhCjfz+qB6dk6i2tfxh5pDCrifbLstD1L3tbteJGZmIRMifICDq6p98y8jFa+g9pY+WANU3ME1D/Uz2oRfjGUYFNJFKceImiUxdzu1D85i+fuAKB82U1vQVV07Du1nQVEj4F9XaFBRx28say0WFgnKgJOmOa8MOZWxoCzbmfKRD6L+cCIWNObghT+dDjRITt0fz9z3NdUzFtELtVCTgwH2m3XxzG2TPxl9VLwY4DkkWCKUnQwNAFAneDqyl5NeY2zSc1iXjynxhv5UuRnL6XgnuQJtOBM1B8KLrBlgnt3HRXv92GrgRHQr9l7f7LJcb7q/xWygslZqx4UHK6RiUNfEe06axyHagWsVhR9PtoaFZoHWU1KXB7fEUHu01YSvNWQE/ocFxSNAmnjjo6zd7218Jj75L4RW78G+fZRW1mDE9/2dJGYgVuF0Jmb9NUHGKF6NAHY5yIt4LUsMoU3KkQn1RC0b1vuzkAFtiUEqNpsZkNiHWhSS5zpZcxdXrjmH1Puil9/gtKgRK7YI41yozq1HMZ7AeBKyWpupxoiXNx2clGQCHDJsBFyPTHczVje/RvU=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(14060799003)(35042699022)(13003099007)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yYXJ5b2dUgcCQK7ltsQd+4oAVbf4LFKsSSR2gGjeSC0Q1DOPvYyLsUE4mq8zNTNLJPaKdf4eMlKG3E5HPeTiRJSttQqlZQdvTAtRRenkvO0CLT3eQ0YtWqR+DZPbQ7+V62AxzWJUp8ioGDnF4S827orl7p/4h4f0Mr6ct1ltXY56rjTMYu+8nBGP2RTjjT+DausePaD2xcNMTtRj9OqUTb9AiHN8SW48VrxsnQ73zgCS4ah/uiWIw0zsW6juK8LoiCvJClOWWOOYnp7fj/hVMAeBCiz/6uIXLQPY/ubK3Q/UImF1djRLdpLkitWyFwurq9hTyf83Jjwz4tGQzFgmS4QdEZDQB1uJCGVED87GmgXlm0yiuwBoIM90oOkWHK+DFeVISEjWTQk+9ot7rdDx/iV8CJ+0Zu+ssrIw0knwUHccu4H2e6O1LggZozkycOyE
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 16:28:44.7986 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed5998c3-f429-403b-a38c-08de8f429418
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000A7DD.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9736
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

Hi Tom,

The following changes since commit 0da1866a8fdd4d4bc4837ef2af281dbe010ae16b:

  core: Rework REGMAP symbols implementation (2026-03-30 16:59:35 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-net.git/ tags/net-20260331

for you to fetch changes up to d1f8719e5163c3aceef501283f29d928f19e546f:

  net: rswitch: Remap CPU to bus addresses using dev_phys_to_bus() (2026-03-31 16:54:49 +0200)

----------------------------------------------------------------
Pull request net-20260331.

net:
- airoha_eth & pcs_airoha driver fixes
- Rework some symbol dependencies
- dwc_eth_xgmac: Move DMA reset and pad calibration after PHY init
- rtl8169: add support for RTL8125d
- rswitch: Avoid NULL pointer dereference during PHY access
- rswitch: Remap CPU to bus addresses using dev_phys_to_bus()
- phy: dp83867: reset PHY on init to ensure clean state

net-lwip:
- nfs: fix buffer overflow when using symlinks
- tftp: update image_load_addr after successful transfer

----------------------------------------------------------------
Boon Khai Ng (2):
      net: dwc_eth_xgmac: Move DMA reset and pad calibration after PHY init
      phy: micrel: ksz90x1: Issue PHY soft reset during configuration

Javen Xu (1):
      rtl8169: add support for RTL8125d

Marek Vasut (4):
      cmd: dhcp: Select CMD_BOOTP
      net: bootp: Drop unused code
      net: rswitch: Avoid NULL pointer dereference during PHY access
      net: rswitch: Remap CPU to bus addresses using dev_phys_to_bus()

Mikhail Kshevetskiy (3):
      net: airoha: probe airoha switch mdio on airoha_eth probing
      net: pcs-airoha: unify code using SCU regmap helper
      net: pcs-airoha: fix allyesconfig building

Pranav Sanwal (1):
      net: lwip: tftp: update image_load_addr after successful transfer

Pranav Tilak (2):
      net: lwip: nfs: fix buffer overflow when using symlinks
      net: phy: dp83867: reset PHY on init to ensure clean state

Tom Rini (5):
      net: Rework some symbol dependencies
      net: Rework dependencies around NET/NET_LWIP and NETDEVICES
      net: lwip: nfs: Add missing dependency
      net: cmd: Correct dependencies for CMD_PXE
      net: Correct dependencies for HIFEMAC_ETH

 Kconfig                                |  4 ++--
 cmd/Kconfig                            |  4 +++-
 drivers/net/Kconfig                    | 14 +++++++++++---
 drivers/net/airoha/Kconfig             |  1 +
 drivers/net/airoha/pcs-airoha-common.c |  4 ++--
 drivers/net/airoha_eth.c               | 22 +++++-----------------
 drivers/net/bnxt/Kconfig               |  2 +-
 drivers/net/dwc_eth_xgmac.c            | 28 ++++++++++++++--------------
 drivers/net/phy/dp83867.c              | 10 +++++-----
 drivers/net/phy/micrel_ksz90x1.c       |  3 +++
 drivers/net/rswitch.c                  | 84 ++++++++++++++++++++++++++++++++++++++++++++++--------------------------------------
 drivers/net/rtl8169.c                  |  1 +
 net/bootp.c                            | 17 -----------------
 net/lwip/nfs.c                         |  6 ++++--
 net/lwip/tftp.c                        |  2 ++
 15 files changed, 100 insertions(+), 102 deletions(-)

CI link: https://source.denx.de/u-boot/custodians/u-boot-net/-/pipelines/29718

Thanks,
-- 
Jerome
