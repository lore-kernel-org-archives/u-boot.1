Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2075AC55160
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 13:33:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D2E1A40A68;
	Thu, 30 Jul 2026 13:33:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 514kpw9WlGdN; Thu, 30 Jul 2026 13:33:36 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 73AB340A60
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785418416;
	bh=iV7C1PHOA1eUgQOIB8fkWfjUgYMhnuaVBvVbcTClvAY=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hUcWj4TitiXcWLQXOtIFwTviv7QzoPzT/5PEgDqHxuu5JL2cPjDzqjYukC2T3naiV
	 ArEiXmNt91ytJKw5Ta1IolTyvdRjogsS6/okn5ILPOF4E9CBkUNIP0b5nXLBx91uYF
	 xSihrAg44CHQ3WxDkY3c+3qZvjUA1ZAvNt1LgAdaDA6eKbQ1XQSaZpQgeab+TtJuKU
	 m4Mm1dZhr/OS15DfLtAJeiB+ClVc89LxOU2SOxwxK9Ua2ROZaWbCdVw4cI+moMUdQk
	 t57XmPcecK7REPfVWWxksNuARBxWQVtbadvaymbYR2PVMoyGQraDTGhcflRLP1wPSe
	 BJp/aETXAv9TA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 73AB340A60;
	Thu, 30 Jul 2026 13:33:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id D4B9569
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 13:33:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BB0C5401A3
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 13:33:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1A_ZIP5q4M-6 for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 13:33:34 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::635; helo=mail-ej1-x635.google.com;
 envelope-from=jbx6244@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org F21624008C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F21624008C
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F21624008C
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 13:33:33 +0000 (UTC)
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-c15b51ba80dso20013066b.2
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 06:33:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785418412; x=1786023212;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iV7C1PHOA1eUgQOIB8fkWfjUgYMhnuaVBvVbcTClvAY=;
 b=eVGyNbAaANTRSsp3VLMA1uWnswjXybvsMG5ECxHL4MaaVk0vtBOSdjOxl/mA1dAdz9
 7A7FTgrtcpWN+aNAzZV4b227/P4FxZ5IK0Fk94x7ZprjsBTcu/NA2+Piygb76Gxf+78k
 h7QdnMegA1/BRbFE4OsWj8SuX1Pkny1afEKyHS/+r1RJ8QWlOEdzcVpHjFNrO73/083j
 cBjF0SOE5V7zdw6MOXWLz45WcHcivpwMsM+8XC7MmOy74OSiLXx9HgmMNSZOa5MawZ+B
 WPl1rNYohHDekBizRLr/U/o+8/qMEC2XfqDhoeLS5jB96z8mj0BuBQD4mAzvF3DB4P2z
 ZusQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RodOPlDkRU8C0nDPoQNSan8Tgijo4MkrJ4Q/sXx2+YwPcCD4vu/euYlVLWARERmQKu4ta98KMg=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YyfIZoqGy2rKUWB1PGHSrWRcwVbckl1yRW29arriyrsi0V5uHpc
 1zpFGtj1Pk01Ny96FvbU/pXCcwpL/rDye/ND7RdGGfEYbPGI3HQPCI7Q
X-Gm-Gg: AR+sD13auIgU9tWj2kXzdePIgvbWQeOe5r4KahARG8slnqYvj7a15csLI0EnUl7MIqQ
 ptr6H+JJATYuta4tlsxQqQY6/MOU5s0Rxvam7KbSBHU/hbamHaTD/EPuzjbwCNXcuubGboTt53r
 zCHPAx9doOXZjNA/rX4yQRy/cVmrPGjUFDVtZ1hm86KdSH3gvWoRMToK7Fqp9iBIbXOEIoNnJC2
 Q94TM5H92S5SMSvxMSr9Wo+rXvZruLFvbZ8aZuudF4l0MQh9wXRKSJKD4FO/XpAtDMoNlqjKfQ9
 SnselHIdKzyhefGhW8HT61cg45wvTsWy14dddNbNbaB6CwRYEOlJV6+583lfK6pltItgpm1AjSr
 LSmiFUhUe7mqjHvqx5bfkdnE9LCDDc3glkXCon1gBb5UgqcumJqcnas4XrJtUGkaW18gHQquIJw
 DUecrs72P3O9MQSv7j3jGm2a55XvTN2/8Hkju+TA1nLf1JhvoT8NHNqW/4Trv+GT8OrovKU+kKp
 JTQq1tRCG81RdtIzfOF6yeeCK4=
X-Received: by 2002:a17:906:f581:b0:c15:9f0c:8d31 with SMTP id
 a640c23a62f3a-c1fbccb81d3mr35071766b.2.1785418411916; 
 Thu, 30 Jul 2026 06:33:31 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1fa851b6adsm68323666b.11.2026.07.30.06.33.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jul 2026 06:33:31 -0700 (PDT)
Message-ID: <88612ac4-7c1d-4e4b-b297-a2f96ab17a3f@gmail.com>
Date: Thu, 30 Jul 2026 15:33:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v3 03/12] rockchip: doc: add BootROM mode text
To: u-boot@0leil.net
Cc: kever.yang@rock-chips.com, sjg@chromium.org, trini@konsulko.com,
 u-boot@lists.u-boot-project.org, eddie.cai.linux@gmail.com
References: <5aed2a27-bd7d-4b71-a6c1-0b46b41f3462@gmail.com>
Content-Language: en-US, ar-EG
In-Reply-To: <5aed2a27-bd7d-4b71-a6c1-0b46b41f3462@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785418412; x=1786023212;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=iV7C1PHOA1eUgQOIB8fkWfjUgYMhnuaVBvVbcTClvAY=;
 b=pyp5IXbWf06VkNrc2fbbiTLeEeAJj/GgGEp0wdGY1taoF0LmTz/bu+Z3ZoQnFS/A85
 JmFiAqN/StZJROyziEthydgDByVpLGPMTxmn287SNKr+SJqSJ04yiO2GYw5SXlkSO9Lo
 KarBZpk1igFo+WGhMXk0+mJ0T6zyiO3ydack4+8KH8jJmSqaefPmnpx/Zk1V38iB1MJI
 3+BqqVGzeyE88FNBjSf4lClKT6bfAHQyb7FW3tAkxTSXLvFlXMjE+v8IKYN2VHdySo+q
 AjApVayGCNlcMTb25Fn07zBlZfXlhGWQwtbCH4pr6C7C7CDQKqLkHHvfTklEufULeqOX
 1olg==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=pyp5IXbW
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Add text that explains how to get into BootROM mode.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---

Changed V3:
remove MaskROM
reword connect
use eMMC
wrap
---
 doc/board/rockchip/rockchip.rst | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index 5144cbccef78..fab1af73b22a 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -325,6 +325,22 @@ To build rk3588 boards:
         make evb-rk3588_defconfig
         make CROSS_COMPILE=aarch64-linux-gnu-

+BootROM mode
+------------
+
+Options to get your board into BootROM mode:
+
+* Holding the recovery button when you boot the board.
+* Remove the SD card.
+* Erase the NAND, eMMC or SPI chip part where the BootROM blocks are located.
+
+Methods of last resort (USE AT YOUR OWN RISK):
+
+* NAND: connect pin 8 and 9 of the NAND flash with a needle while
+  reconnecting to the USB OTG port to a PC.
+* eMMC: connect the clock line to ground while
+  reconnecting to the USB OTG port to a PC.
+
 Flashing
 --------

--
2.39.5

