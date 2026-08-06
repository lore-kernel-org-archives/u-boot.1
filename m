Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F843C55ABF
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 11:11:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 070B080A54;
	Thu,  6 Aug 2026 11:11:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FGITOdYLqeWh; Thu,  6 Aug 2026 11:11:00 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0878E809F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786014660;
	bh=XIqdcXK8EBBx0k/+jsztjBD5zMCI3lqgQrKtd5QJTps=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=g5i9H6gwnLoSHDQDB4rLFYbk8+l16xq1taIP6zYm81K5Ilf58LTtT5I6dneh7y3LP
	 Ke0PX51byaozWIxd58/rfYKaq+PEs6Y6qHFHZYn9uXRPf+pCTYLgJPR93DsWYAk7Ui
	 gvL1WfC524MGAY0H/t45obzL1EbThowTFKnsYfuGI4DhLpYqXUFsFjvmSF80KE0cQh
	 YVvhO5Eb8/7tG4ygP3PgJOsdduk+i/IK48PvUlR+cgsbtnIxmREEYtPsDLcqYKdezi
	 NF61scs+y8HlE7SAQPSDh9H2nVORyJ6aG4ugUKUw5XULANSTArtnuATj/dunweMkAo
	 ediY5oPIHIiLQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0878E809F8;
	Thu,  6 Aug 2026 11:11:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id DB86710E
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 11:10:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CDBA5809F6
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 11:10:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tPOlZRiqTvvD for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 11:10:58 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52d; helo=mail-ed1-x52d.google.com;
 envelope-from=jbx6244@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org E0CF3808C9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E0CF3808C9
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E0CF3808C9
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 11:10:57 +0000 (UTC)
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-69a33fb0031so321068a12.1
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 04:10:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786014656; x=1786619456;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XIqdcXK8EBBx0k/+jsztjBD5zMCI3lqgQrKtd5QJTps=;
 b=LckX+gawu62EIVdsxoDt2bixPg4gv3bRg6n5jXxqs3Rxr17/xy7icrO9t0DLt58an5
 kPo/Z6qxHecA9LHa0PPZ/mnBsosrnQyiptInKTkWDLEdP2t8b/LN2mWsJ2j3lux/aqjY
 qpy+/hXID69QlrJSja6+0b0oIXyjQEDPQCV5USenK0NPpmBhgTe1d7FgE4814J/H7DNI
 bIY67eEdZQW+wW0wdT0T13qPwBVBQ/Y/eLNhwBRcKzkuzLgtu1oQAh1wzFarL0b+Ph8t
 Av0yJglcSsbKOxN9yy5mNZcihzIdQyYbl+ltgtGTWauzZ6Dla9WwPL+OWcRAG1EH5XDI
 /nBQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpvvHNlo7Nphy4FvpyrQ3JoQShmz+Jjej5wOOPiGihbuBypvv/0AmijL1hxarzkCml1s+TmrMQ=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yz1Sn8noPMNF8SmznioIiFFKRAsKxZpb0O4QbgyAonB0lbKgZY8
 4VK8wTkqoXtvzZ8B7+930yO+qKrCWsjOKRTWtqWPrKtcY/ORdImX6p5+
X-Gm-Gg: AR+sD135WXUgxwisMKaYfG4+LvjA40BrF1fkFy0eTyUiMc0FDe013iwb0vNBl4r6xH/
 WxNmmHjzrgWjVRCoVwkTLlaHuEiq9B+5sMINFmxYS2bvetJmZJjgpsKN2GF0xx+DzZDSU6M7hbt
 SyHDn0okeWl3oqB4GU78W4qlnu8gYMH9YukHgIkdB21Sqf/rFe8Iwk+aAQzWLqEFt01HOw4koKP
 WiGDzahdeHP9h6EahX0vBrFsoImTQhA8dyojDzFWkocfvck5ISEHvYSwTOjNAkuhuyo3C395Kcl
 8uSQ4YQe9+NYvQ8fBCMLuQkUEroKGSS1Mwqwh9g/ls9xQvt+/9xrjIoim5Hwd5OQ/uiDOfr5tNA
 TiXO+JZEfXi69oEgWHmiIx5rUafwRS1s6Xtr6oveHPK+W2mpt7mi4VI2HWuNm8CDK6NxPbRHQ0C
 1Kki4cgOpXqerfLH2uoDVLP3TkUwm5b8ujkUdDPIofQ0Wsx7NFhv+oE47CZOL/Z1NiAk0MYN6a0
 2EUDiphqsJFfAEy71PnhQ4dcKs=
X-Received: by 2002:a17:906:9c84:b0:c1c:4ae9:b935 with SMTP id
 a640c23a62f3a-c2039d0eb79mr392316866b.3.1786014655472; 
 Thu, 06 Aug 2026 04:10:55 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c203624e6bcsm241429866b.14.2026.08.06.04.10.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Aug 2026 04:10:54 -0700 (PDT)
Message-ID: <dfe95538-0b08-4378-ad46-bbe0ef554cab@gmail.com>
Date: Thu, 6 Aug 2026 13:10:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v5 2/9] rockchip: doc: add mask ROM mode text
To: u-boot@0leil.net
Cc: kever.yang@rock-chips.com, sjg@chromium.org, trini@konsulko.com,
 u-boot@lists.u-boot-project.org, eddie.cai.linux@gmail.com
References: <0ce61246-3191-4ce2-a7ea-8ab3c02cfe80@gmail.com>
Content-Language: en-US, ar-EG
In-Reply-To: <0ce61246-3191-4ce2-a7ea-8ab3c02cfe80@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786014656; x=1786619456;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=XIqdcXK8EBBx0k/+jsztjBD5zMCI3lqgQrKtd5QJTps=;
 b=f6IdjMt6CEwG6pALDEfxzjeHpQ4qqt5xdy8Pud95DV5QpaHxXEJ13SA++zf43+0O9p
 jp7McO7/ZqtIHjm6LIcLY0KDtAhUFvvZtyFnfKj1kYKWrfbVQyrvd2DdOvTq8k7kKTQP
 ohdWJqMA/0mE8LU4aWcFvZrc/CIjJQLlBIwoROH1XuENAU+grCsidm9urEf9/WuPdgd2
 CoCpKZLZ6SqG7HiuG5rdzbjz8XRZOOYaz0dUJdTJUaGZDcN/xAq/njhcql+FvK6GoaB6
 erYUyvQVf44xQ2FbaACkiDfo+jloM6TPpM4BL+26lQ6Gf8MjmWQQJVT9KWLB+dFuQiwA
 nRpQ==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=f6IdjMt6
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

Add text that explains how to get into mask ROM mode.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---

Changed V5:
reword
---
 doc/board/rockchip/rockchip.rst | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index de2df3046e28..af6c08c46636 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -325,6 +325,27 @@ To build rk3588 boards:
         make evb-rk3588_defconfig
         make CROSS_COMPILE=aarch64-linux-gnu-
 
+Mask ROM mode
+-------------
+
+Mask ROM mode is the fallback mode of the boot ROM,
+in which it listens for USB commands 0x471/0x472.
+
+Options to get your board into Mask ROM mode:
+
+* Hold the recovery button, depending on firmware support or wiring,
+  while booting the board.
+* Remove any SD cards, removable eMMC or removable UFS modules.
+* Erase any storage media containing boot firmware.
+
+Methods of last resort (USE AT YOUR OWN RISK):
+
+Short the following pins briefly while powering the board, so the boot ROM
+cannot locate any boot firmware and falls back into Mask ROM mode:
+
+* NAND: connect pin 8 and 9 of the NAND flash with a needle.
+* eMMC: connect the clock line to ground.
+
 Flashing
 --------
 
@@ -485,9 +506,9 @@ To write a U-Boot image to the SD card (assumed to be /dev/sda):
 NAND
 """"
 
-Bring device in BootROM mode:
+Bring device in Mask ROM mode:
 
-If bricked and no BootROM mode shows up then connect pin 8 and 9 of the NAND flash
+If bricked and no Mask ROM mode shows up then connect pin 8 and 9 of the NAND flash
 with a needle while reconnecting to the USB OTG port to a PC.
 
 Show connected devices with:
-- 
2.39.5

