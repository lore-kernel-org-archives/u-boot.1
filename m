Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7DC5F8DFCB
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 21:30:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A6ED8405A;
	Thu, 16 Apr 2026 23:30:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Wrf/owD1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0BE5841C8; Thu, 16 Apr 2026 23:30:30 +0200 (CEST)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1A6783FC0
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 23:30:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QKs5EAws2zwyjbGKih3EEJomRJSpwsDDQdTAn7T30nu6uKhpMjOrerVXGEazicG3niEoOY0VH4fLGoXmXYYrGDfVAfn+4jGCJFOnwbinM6p3v30vNgiwr1ghzozsuturgYa0tjHjlM+2LW44oRuKMawURpDVrJ8OKdHveDNcaCcJwO6LOQCsoZwAgk0TK5mrdKstNkwIzgYA1ktvFpiECJckd8yKK/adkcOJr2pDiDANSL2CIRHlknV2mULC6mfcuFJhvUYQpvF9OaqlkTcpfi70j37mfs7KIcBWn2IhUAg8O0HLwLNwWsqGQU7pP6w5qW5FcrExfYEuIFP7ymFKmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8Rin4L9x+nG31rbcdNtWJ8N2ccQsFr93P9FWrhT80c=;
 b=K93MzIKxyTaIQhNiRvXYuYVWSwNLcLLPeN0gCMYyQvgv8tCiOMqW9GZqzMPwBuT0ZKuF4glKtFuM8IA6VGZuflCfWAZSWXWl1tJ2VcxhDgwVlKnwYBOQ24YSzRLf8sdMhkgUcmSNgVGtCrIACVbkLaFBjAS9Lx7x2n43Q69+nQzo/SY4WT62pfpCjovpbYM+9+iPzaxSun6kD1eV9XJJ9OmPhN4gk16TTjEb6HBnX30EyvqIzEdxyP2SFAhR7ZrmQDur6eNqGE3N9bLQLxBYIHexkw0w8Hvda6yYJxJgERBky2AHPaKCm0SAygIE+oIy2Rx8da6St8QMfvLZVhR+xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8Rin4L9x+nG31rbcdNtWJ8N2ccQsFr93P9FWrhT80c=;
 b=Wrf/owD1hXHz5ApqDlTeZ16tjuzjqhi7wQ5cCkr/snSjYi0sVUVYMhO0bCLJf+AilkKzS78CI8nz9RmLtJn6cOaRlwQeBj9563wOQwZ1PCI4gtQfSFQ6ReI1tfe9vY7ItQgvT5/iTRfA/f9tug+CY/iF0PNlz0mw/Ju2rBoOv5w=
Received: from SJ0PR05CA0147.namprd05.prod.outlook.com (2603:10b6:a03:33d::32)
 by PH3PPF2A078470E.namprd10.prod.outlook.com (2603:10b6:518:1::791)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Thu, 16 Apr
 2026 21:30:24 +0000
Received: from MWH0EPF000C6194.namprd02.prod.outlook.com
 (2603:10b6:a03:33d:cafe::35) by SJ0PR05CA0147.outlook.office365.com
 (2603:10b6:a03:33d::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.51 via Frontend Transport; Thu,
 16 Apr 2026 21:30:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 MWH0EPF000C6194.mail.protection.outlook.com (10.167.249.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 16 Apr 2026 21:30:23 +0000
Received: from DLEE210.ent.ti.com (157.170.170.112) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 16 Apr
 2026 16:30:23 -0500
Received: from DLEE211.ent.ti.com (157.170.170.113) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 16 Apr
 2026 16:30:22 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 16 Apr 2026 16:30:22 -0500
Received: from localhost (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 63GLUMF1732520;
 Thu, 16 Apr 2026 16:30:22 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 16 Apr 2026 16:30:22 -0500
Message-ID: <DHUWE3NAISJ7.CID3Q8TRSIGX@ti.com>
To: Simon Glass <sjg@chromium.org>, Randolph Sapp <rs@ti.com>
CC: <robertcnelson@gmail.com>, <ayush@beagleboard.org>,
 <Erik.Welsh@octavosystems.com>, <anshuld@ti.com>, <bb@ti.com>,
 <trini@konsulko.com>, <afd@ti.com>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>, <u-boot@lists.denx.de>
Subject: Re: [PATCHv3 2/6] lmb: add LMB_FDT for fdt reserved regions
From: Randolph Sapp <rs@ti.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260413203555.1990337-1-rs@ti.com>
 <20260413203555.1990337-3-rs@ti.com>
 <CAFLszTiUDtH14YTn8tPifA4cjOV=2h5MEkOGiGm6x6sQuJ-AZA@mail.gmail.com>
 <DHUW0ASRTCZR.8TB6FRJ580PY@ti.com>
 <CAFLszTjXh+uEEMFQYOAS7sApqYBkfb3VhgiRrTDmzEzj9P+M5w@mail.gmail.com>
In-Reply-To: <CAFLszTjXh+uEEMFQYOAS7sApqYBkfb3VhgiRrTDmzEzj9P+M5w@mail.gmail.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6194:EE_|PH3PPF2A078470E:EE_
X-MS-Office365-Filtering-Correlation-Id: d32dc414-3533-4014-25a2-08de9bff5e70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Rk9ZN5TludWdlKBD05oQmLIbHYq5bwqrYw8kuR5VPUVGw2RGFJeLOxOgP+PmX56fO1slvk3qoKsvTSmoxkauao8SFtGFsxD8DY7Y90qq+AKkHvkwSOtWL9deUvTgNxo34iPA747nirZhT42zHxncBo4O5JIOAShzZUeJuaS/yvuy5N9B+4yfsljXKcsK3LVyYp8l4/KJshQzOB2oNL6aJ7UQqwoPdSoxqgg/ibX6D1uHoZqtbFxdYerwXOXldnjkFLdeWpMWKuzH8mYyofQUGLUsEX4uJF8S8djyA2qpDoj6mYqo0ZHbedW/UlK7RouNDUuDWtuXKE5oun/HvQmYb4bcRw1Irvz6wFdwX8NC19JMVwHWhOKUjmbsgnZd6jXyUPyXmDmJW7tk7q5/zKM3BZwY6E69/LkVYgkxp56rsnOnwZkPHMazA8JSPR3ST6kFAv2wX3HyLOxxmx6F/W4tCddtEQ/wnDfoXuIXkncUTymyc1ZLNWht1IiQasrlhIy6hn9tN2FrvdNag9oV11Ch9ckoBc26tB33i4nqXr8mqIIVDV6EZZD39d5dOL79jULxzBe34REjTNNrr5lKfxptW9jyzO8GniFselIWhoajhazlqgTVyJRLKumc1VeRJcqWS7UYEvakFZQmJbsaYn+P/0l2Yy8BeMSlbMTXLMII1mL7JSk6MPprfdSAMCkBK1kvV93/0CXnyqwHeqL13zqMp1IcGof19eBX0nwbFKhbb0mTyVVAliWqHuzvgo+EovdmaQDP4TqP6czlRrOWU6PzuQ==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: aQ2UNqHGK+3CIfqFi+C2SzXHMQIYx1RmlFNw9YcKzjd3gFcbmuFbq5zklzRhspNiq6exOKr8M+KFFI21mXMNTOR3Y/uZj3a4aNvA/KwdcIMdm7ZYuyiQZX1QzqaSQIhC5oVG3BITdetZ80QxqTylMfOWJ38hrx4GZTVKlXjBzadRi2ui5U9ohIpR+dA33MbL84LVb33oPjuDZP9tY7IeilXnZjB3Ly7MiX6OHUYPoeOd6mJiAYb1utlGCTamDSaVBn8ZyY4/5/BCLIKD5c4sqRaJeICEsNav/rSwBD93GB4a33kiPKCticzJ61fGXfmQQWQJpslMDTYmUUKe4Jccls7kr5l2aYBIHHEZB9QuY+l/S19i/J6grS5l5akFxR12443CwbqwDVLXhClEJfMTgWJcD0psjszKUhz2hLLQ6TGdYfJcosIP5VQTTPTiXvNT
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 21:30:23.5151 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d32dc414-3533-4014-25a2-08de9bff5e70
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6194.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF2A078470E
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

On Thu Apr 16, 2026 at 4:20 PM CDT, Simon Glass wrote:
> Hi Randolph,
>
> On Fri, 17 Apr 2026 at 09:12, Randolph Sapp <rs@ti.com> wrote:
>>
>> On Thu Apr 16, 2026 at 4:02 PM CDT, Simon Glass wrote:
>> > Hi Randolph,
>> >
>> > On Tue, 14 Apr 2026 at 08:36, <rs@ti.com> wrote:
>> >>
>> >> From: Randolph Sapp <rs@ti.com>
>> >>
>> >> Add an LMB_FDT bit for fdt reserved regions, so we can reclaim them w=
hen
>> >> parsing a new device tree and properly warn people when a reservation
>> >> overlaps with an existing allocation.
>> >>
>> >> If we don't at least warn the user of these reservation failures,
>> >> there's a chance that this region could be freed and reallocated for
>> >> something important later.
>> >>
>> >> This useful warning mechanism was broken in:
>> >> 5a6aa7d5913 ("boot: fdt: Handle already reserved memory in boot_fdt_r=
eserve_region()")
>> >>
>> >> Signed-off-by: Randolph Sapp <rs@ti.com>
>> >> ---
>> >>  boot/image-fdt.c |  5 ++++-
>> >>  include/lmb.h    | 14 ++++++++++++++
>> >>  lib/lmb.c        | 33 +++++++++++++++++++++++++++++----
>> >>  3 files changed, 47 insertions(+), 5 deletions(-)
>> >>
>> >
>> > With bootstd we maintain a list of images attached to each bootflow,
>> > including the address when loaded. Could that provide a solution here?
>> >
>> > Regards,
>> > Simon
>>
>> Hey Simon, you may have to elaborate on that a little more. Are you sugg=
esting
>> we treat FDT reserved regions as dummy bootstd binary entries? That migh=
t work
>> if it counts as an LMB reservation and we can dynamically update it if t=
he FDT
>> is reloaded/changed. I haven't looked into that too much yet.
>
> Not so much dummies, I mean real bootflows. I am not sure if you are
> using bootstd, though?
>
> Basically, once you have a bootflow there is a list of images attached
> - see struct bootflow_img
>
> Each image has a type so you can see if it is an FDT.
>
> This is just an idea though...I'm not sure if you are even using bootstd.
>
> Regards,
> Simon

Oh, the issue isn't in the region reserved to load the FDT itself, it's the
regions the FDT reserves for other components. Specifically the
"reserved-memory" nodes and other things like that.
