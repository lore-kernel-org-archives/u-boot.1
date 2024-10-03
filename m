Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4773CF34C8
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 21:28:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9C3588CEC;
	Thu,  3 Oct 2024 23:28:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="PpDAg0R/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21A5D88F62; Thu,  3 Oct 2024 23:28:19 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2062c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::62c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1825E88D94
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 23:28:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TNWI8vrE6b0V8yDQJJlriOqP45kW0B11XPyxn6KUTEmMspzZeD6VNoB7bmba6e/SJrM7+axF7eRy5MZ0dDBlV8rak4/ZxEldmcVcC7mgPqGJN+vnrrSswWrBFiSUqCWhZ0I6MYl/Lq17joKDrldgWP+iPdF2itYsS0+QTVncOgu1TVHjilW3xhdfmeVlUAYKaT2SqHkfKfLiDMQ7hhAZ5oJjYFiOZWFyafCVr9YrWN8vu8V3cp8JJXEc4DA/2DTFIZ6j1FDXe1M5s6D6aOeoxeQhoYSiXQf+/ptku34d47OT2fsaddIGjbXRrESh2jzr66RFemAHScx7eLJMLHKGsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p1n92XRMOvlGsTylyKhlKH6gnmjnGn+tRP3Lw2v1tLw=;
 b=veXh4d3WIdh+M2RYf8APzSF04Tixq6aB0qqEgBcm1h0vloEwTXVv85wTQT6M7aRo/CJ5xX6GabOVbBnZpdmcSdcxTa/EMR2TDQuVb6xtdrfzKDiAIu3/Y2JCVd3rSFCT/vjtcGnBHUAH+UXRUY9geB2B/Cy5JFOE0EbKjldgrKQiLrgAjTweH1/aEwyBF5mfMtb9By6tqAEl89gD3jI8Qhc+3Un0ubl9QIohNmnpYHA0TSbDSW/Jm6JeaeksPfzjGGt78ZEqof6IuFjW+QJWRwExBDkJy4ojQYVTRBHgzbF5bBOqWHo6SXi6O9TbJICFvadyw1sXIpxVWR9zLEt7DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p1n92XRMOvlGsTylyKhlKH6gnmjnGn+tRP3Lw2v1tLw=;
 b=PpDAg0R/OPS/ZOf4VUDhklP2pfg8nOqnvx07tvaBImExl5uNyRrpXfuTo/4IHTCdBRn/mWAZD1PgCIF4WRS4aEGTvlOUR4YYM+P52uK0CcVoNmI5ue9p9j3bzXtwGYIUHGFsh2xQ+wG5DM1LDl7v6OGCubU6VvNeryMR274EO2M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by DB9PR10MB8118.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4c5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.9; Thu, 3 Oct
 2024 21:28:16 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%3]) with mapi id 15.20.8048.007; Thu, 3 Oct 2024
 21:28:16 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 04/13] m68k: asm/ptrace.h: include linux/types.h
Date: Thu,  3 Oct 2024 23:27:53 +0200
Message-ID: <20241003212802.3810-5-ravi@prevas.dk>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241003212802.3810-1-ravi@prevas.dk>
References: <20241003212802.3810-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0112.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::20) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|DB9PR10MB8118:EE_
X-MS-Office365-Filtering-Correlation-Id: b65c4ba1-2651-4f54-98c3-08dce3f24aec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?A4BlFut2p5xgRwn4AFi3kqZPqLOM2NL3ZtIeH+ov9nZoX9J2wAhMixNRAIVZ?=
 =?us-ascii?Q?Mp+3qojPanWVrr9Dk4XgUMP2I9jquBY8iD2dtvPdkYNIYgsh4XDPfJtEvxE3?=
 =?us-ascii?Q?qD+IsbBDvvo/q5R+CeQtaP3xiE92BXpHKWjjnL7c+r/A+G+CxGS0gcAj37Os?=
 =?us-ascii?Q?rEs0U0qb6jkML/dwBC6xzin83HcAsL5HGLVg0sJ4b0J6piXkxUii87WliaCH?=
 =?us-ascii?Q?OwQpLyIpFiAab/CDBNsQ0iTNeQ+ELryYVGB2WWL6+dxKipoP1kFD5x4UqckL?=
 =?us-ascii?Q?Am9oug45q+ooWImCZk8wD6bZOYjfhO0KYiPQarAwuAP42/tLrEqyTDMPU3mV?=
 =?us-ascii?Q?YM/Iza3sMy2d+VjDAnQ0ZRLfOgtI85IQki8j6aDXIWE8N+ih3Jt4sT7gxEwQ?=
 =?us-ascii?Q?7FdxeuzJ2MXpnoDlEmpMKYIRw2MlmcIl7BEGpxZjabf7nQeZOTPO/62XoM8m?=
 =?us-ascii?Q?BDuMVY1KhgfDjufrnvbYE7sb5oFBEABRURKAOPqtC8F2FYTkDd4BllbxwtCg?=
 =?us-ascii?Q?DDeX7ONcaKQJdm675rr1qcBOKFrIn5ojji9Suq8lyi38nAitpt017Y5dR+k9?=
 =?us-ascii?Q?fjJaxQQLzr/bzXqQlljZASKZMZrfg7MYU4WvaM5/yNv7JI1iDzXzluUHSfUX?=
 =?us-ascii?Q?iAZhLaAcqmT9/EP8tVokNSEilx8UQfOu6OqF1EF00HJjmC+edn4obcUO3y0J?=
 =?us-ascii?Q?7iNKO/sTFPK2U7F9mbTc7hD1ydqiC11rXBVfUAaXvrmT52wg0kcZW/srtHrp?=
 =?us-ascii?Q?t997XoV36pFQyWKtS3lRdzNHBzILRcnvxyyFhxt/CeHg5mEBn6BRjBWS3wTE?=
 =?us-ascii?Q?dvysW5kxU4eqRfzaglPjfMHS4xRDUN2LwRbHk0r0LxRSzv64dlCIKY7Vyas7?=
 =?us-ascii?Q?3tXvSXbK6yg29sERGFW1eEm8LmsuBQRjdudE+SliH4B4gDlO8B4nE+r1I+CC?=
 =?us-ascii?Q?oOuqkyIYXJll0kZBrtyoEBpIDmNkpd0Pmk4wLN5YgZStjf6lz3fYgDUMsLUL?=
 =?us-ascii?Q?D2To1U1rAJTmRn6WYgUnYjgQl7jgY2k4L+nTqE4knBQg7yHYkLpUL95o4Uky?=
 =?us-ascii?Q?kVjziHws7j3x9YheV10NrMuJbti+Zzu3ka5F8JWdzPPYXoRXxR28+D5pRKRO?=
 =?us-ascii?Q?eaYDtSdTZeLCKRtV+K9cAO7v+Y2jSyndnNcKyDNGUHGEOUDpZWJsaGEAjAxK?=
 =?us-ascii?Q?hUByCL7cAc8dkVftTzqfIi9oFDYUM+Lhs5Q0ZLW0/3xHWw3Pi7n9aKcLyuvb?=
 =?us-ascii?Q?7a0u72sFNfDNszuXpCY3u1YRH+FxwXw9TamHUMt7oU7hnOxSPJrlb3vAllMY?=
 =?us-ascii?Q?II91OR8ogpOVzmtjzcdhkNLk?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?enMCRZp1OKf9+WE/y2KcsG3EzVoVK5IQtFBmrCwLDct8pHzxuaOf+BqtHJb7?=
 =?us-ascii?Q?pw6iW9HeEnWJgqPtZkOA1OSE2YGW3dAoT1mycU4mHCo5jhYAhawC/KoUIjjX?=
 =?us-ascii?Q?IC8Zxe+ihYNfbEQn4CdS4gTKRFMEo0AvijV8cFq/1vL8ikWjPWqavAsQRL7e?=
 =?us-ascii?Q?XgM98JYRecH8KJauAnY3Yna6lX/8ZE3hIck2Lbr/lBKmbQZ+wAa62Z1Ie1iS?=
 =?us-ascii?Q?KbmEtInlAl6CLpYae8vCkAV6tmjdbIZRCd1hjixSvU1i2UulMi/zTNGNw+0I?=
 =?us-ascii?Q?0UWcODt/kXPDmTyujWS4IxlSiCCp4I0qR8RsyHD8rQ6uMWR2OQtAvPaoZXpH?=
 =?us-ascii?Q?ACybLkci9s/0CNUZ2NbaUZU1UdIveNYfqAslT582j6bCPZKfq5iM4Enu+m6D?=
 =?us-ascii?Q?1flEkE+2Sk9LW+JbVR+emCghIS2rQxg+78R2/VSkR65infabFd201OHiJV6O?=
 =?us-ascii?Q?NA0iKlXplprVSNMa3FEvMn/jLj3r7W1g43cmN/DDbK0Ym+JZdTZFoTvRC5zp?=
 =?us-ascii?Q?rnua5JEcqA1y5uC863cy5LAc2pb34N6jdMMxp3xQ4nbjkCN+BTzzW/hpxgLQ?=
 =?us-ascii?Q?H1/4PiJaWSUkcRWzO0H5JcbVpz0XPyK5m+YPhEi0SSdbL4Rgn+lh5wbQONjp?=
 =?us-ascii?Q?ziBdAUV17/qaHUz2iAzDXDy1qMk6GjEWho/7xGptlvifYCzEgoYd04v7flxD?=
 =?us-ascii?Q?e4kmOjDY1ImcmHZBKSEn6VLGcR34iKYRpSTmtL1DzbqIUrN7gB4yDip0GzKi?=
 =?us-ascii?Q?faeI0ahB1WJv0OLZt7LjBjB/jLbrVG4ATALR1crX5F5OEIojA/tJBbosRhwg?=
 =?us-ascii?Q?dSeyCfJp5fBwpKI6/yKCBqiDbvj+hYIxn5OCi8GLxDOgzq/0Mmc4KN6XLJ5h?=
 =?us-ascii?Q?2dc/3N7ctHjvJjNKGWALrI88OF6CWfDlqGFKSBPs3YMgGPOgFc2uYUecst4t?=
 =?us-ascii?Q?ixdesUvoCdLvb64voQNl+OTnRvkpQltbDfrHmkSxcGOff6uGOc2vtDelRqhy?=
 =?us-ascii?Q?/718vXmC9dcNpnQBv6kM+z/S0UOyJWYRqRRkdtthxljquXd9ge9Ei0ZAfkQv?=
 =?us-ascii?Q?DZtFYALpoXgU5+j2VYK2YXpCIIJiHIS4/1NFSiAEpFj/Qn58eHAEMupNnoOC?=
 =?us-ascii?Q?GR91N3HUF/JEbpfsLRlfHXZVAUnhB6EMXrHMq5HiAVtLkDr7U0SkYT04SmSo?=
 =?us-ascii?Q?MvU/BwQooGB2xYUaWhnLnURRHtKqeWnl5QrXkMszh6l4B3szPptNaD/9fr/1?=
 =?us-ascii?Q?eKg3tgFwtKbLu0qXZzadRM/BjJv3Hi7qdmUBvP+S1+nMZ5qCHa6KgIXmVEFg?=
 =?us-ascii?Q?tWOgNvBiyZ/MejkZN20ZneqRulprBlB4ZY+nqefXS4Lg5VAi3UV1oY9ojzwp?=
 =?us-ascii?Q?YtpUhZATOXb49mEDuPjVyIleb9I9iTiOayh1diGJGFGr1STgHMJBOwYpED1+?=
 =?us-ascii?Q?40KbU2Kln2gEQQt4wHuxrax3Uqac0qluI0NyipvVrj0wObl5U3yK/tEyDkfA?=
 =?us-ascii?Q?ce491ID6AFekjEVUe9WL4mVfklfXVKZZ/kOfRIQx5yNFaYVoo/cW/8GLyvgi?=
 =?us-ascii?Q?wK78rcJwF2tirIJ318oNv+ojWhDmpjuscvVKRMc67ksdct6IwOqq+Ggl02Jq?=
 =?us-ascii?Q?vw=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: b65c4ba1-2651-4f54-98c3-08dce3f24aec
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 21:28:15.9114 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DHRcjrFx6lE4177MDfXVi/PrcUYEvv4BSedT3g89I4JGMJjgAFjOHVEZOeDGiXhtZwZaJY+zk1jTISE9+DtKTW5P9QzN830+Ps8hPuCOIAk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB8118
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

Modifying a generic header like watchdog.h, removing not directly used
#includes, can apparently break the build of m68k, because the
asm/ptrace.h header relies on whoever includes it to already have
included something that defines the type ulong.

Make the asm/ptrace.h header self-contained by including the proper
header.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 arch/m68k/include/asm/ptrace.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/m68k/include/asm/ptrace.h b/arch/m68k/include/asm/ptrace.h
index d419824806c..5decf73a1d1 100644
--- a/arch/m68k/include/asm/ptrace.h
+++ b/arch/m68k/include/asm/ptrace.h
@@ -9,6 +9,8 @@
  */
 #ifndef __ASSEMBLY__
 
+#include <linux/types.h>
+
 struct pt_regs {
 	ulong d0;
 	ulong d1;
-- 
2.46.2

