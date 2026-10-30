Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F817606A31A
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 17:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=mfwZ0jvI;
	dkim=pass (2048-bit key, unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=NZPqZhAa
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6E4C18165A;
	Fri, 30 Oct 2026 17:24:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7AAni1Njd0Xk; Fri, 30 Oct 2026 17:24:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4CA2C813F4
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793381076;
	b=L5gU00UHHBPfSmCpKYy7txXiM+tFC8j2iAMzav9vQ+OJNNfkSt/g72lFfsKmNGss5siD
	 C4DS753vaHPWa6ZTJuNBjMSY+BnfMKxY/+VQKTnGQwSNe3Zrm3U0Ae0vAxKId4PyJbJ9H
	 SHXNkRpMIphf3AGUODMjqbLAyfqInvwDeAtWPbHxkW2zbFMR3STOjlwY3mp5lwZ7dttOy
	 nhO8Jyd16GXIr6B+XUuBegCwoTxPY2eU7jRnEoCFc3WmdQTBUN/GhuleTtXLLWrjKCDhj
	 exYXWXpW5pXrAat5VtDITyMnnuVerksS1ezjfmkgCKuKcXWjOqbYyCZW4tU+9FccOVw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793381076;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Infomaniak-Routing:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=piC/ReNa7oi/79wa1g6euog2Ng4eEe2CWylgSfeTv8k=;
	b=rUG0cqsDlDA7oVeaeXp6NRqUZXkrduxjjRr55y0wcSjVAMiTRki5qaNSc3UeKMoy5XEv
	 +At9Vde4ieg1gnzqeDpRm8e8GQQFBHM7gKyFA6x5U3nby9ZeCBkT9EHNjnpGWKyuYGZd2
	 nbB5HO2BOFjkXNYHNvrSCZRxIS3nj4tRcy+J8rGtcpsrk2QPt6I72swiEZN6rIf6Zxw0d
	 JhLhgiF3PmzaDq59RqFLPUHcWFKlejCzNTqeV4uZ1f2w6rMhOyMo1e0v6gpQRUMwzzkqE
	 GCKZ/AfTCbbph/muxkAk9FywxV8xW/wi1S54g4aVRgPJampS7yfJA09vGlxceODjdQg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793381076;
	bh=piC/ReNa7oi/79wa1g6euog2Ng4eEe2CWylgSfeTv8k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mfwZ0jvIya5qMQZX58QxNsYL2wac97Ji/ntEdVdbb5gsprl6qutDgNl7JzLD4XBuf
	 6BGSOH2X6TqlCbeRzOSwrzQJ4FrhttghGPpcAc+29+VpBHX9iphNgKZNMLbnoNn2/X
	 LrX33j/5PZAAuSEBADnFxVR+pL95N+HSm3+p7rlt+X3Pxwc21n5NuFtRg07YCqmal0
	 jNDAQ029H0pftlXQMXUfIT8v3cjGXJBLd4iEQzt6+3WWhLTY+nECEfwWfp6/u4kEVF
	 RnrAO+XvZxdQNHCLTY4LTpmrQGScxYFacOpIb4TQmAviKltnm4qlTH4QDDzzWMShoq
	 0cX3N0lHaNiBQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4CA2C813F4;
	Fri, 30 Oct 2026 17:24:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 008A7411
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 17:24:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E676E40ACF
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 17:24:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bYkUZ7HCZjZC for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 17:24:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E5DFF40677
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=185.125.25.11
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793381074;
 b=hahFZVn5reL26fBnHFD0GLjzITTMhi8YfGxvnYIZOD2nMrvusz4k/l+HXHb+5cbAE7nl
 V7OyP/vX77mxBdfFetKeUl5nEjEGpa2IKJD9l/oaUQx1z+Fg/5YCVWgLMvCOm4euL0gcA
 b6Ap9V0q+GpTRenxnOM8AcZzPNvBmB1FDTckPZMliAXCviT8JGKiidOwSjLkovZ7JgCtA
 qBMLZEYRbaNrvbChRNIDpTYUp+a1UafqdACEEN8H60bxY5TJ2yaUSykx8pJI+PLAtacSh
 qHvRufqZZcUUd7TgvltsSvgkwdTrISJZcdsNnQR7m1L6jk9EbfK4lTaT7maBrCL/Cjg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793381074;
 h=Received-SPF:Received:DKIM-Signature:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer:X-Infomaniak-Routing;
 bh=piC/ReNa7oi/79wa1g6euog2Ng4eEe2CWylgSfeTv8k=;
 b=rteHc4v171oL6I6glnEGX7osZWs4HwUBrDdlKmXQaA7Q2N/o6HX/WitoFXvWdUJm/of7
 bl/TqU6tgXEI1AJN9eSGkpYnwPJxGnqa0Dx0JUWgOOK7EbLRccpRr5vB5RkfRuW8KvPfk
 aSATeZvwjMu5tXZo89Gd9LTQ3KJURdBTuq3L0x6lZaiYNMCzWV2sZ7wW5zzgHbSklUtkA
 i/3CjywUi53o/+l8WPtVOjuok6QEFEiu9ysdRmjjJEAPCyIoTDfcw+t2gCYovrLTbbz+Y
 vS58YYD6N/D4bpNFn9WOJFYj0XObIkMe6G4hh7+UgREaxjBp82M8l1l6DdPouMZiqgA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=0leil.net;
 dkim=pass header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=NZPqZhAa; 
 arc=none smtp.remote-ip=185.125.25.11
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.25.11;
 helo=smtp-190b.mail.infomaniak.ch; envelope-from=u-boot@0leil.net;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=NZPqZhAa
Received: from smtp-190b.mail.infomaniak.ch (smtp-190b.mail.infomaniak.ch
 [185.125.25.11])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E5DFF40677
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 17:24:33 +0000 (UTC)
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jGSV11CT5zBmX;
 Fri, 30 Oct 2026 18:18:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1793380680;
 bh=piC/ReNa7oi/79wa1g6euog2Ng4eEe2CWylgSfeTv8k=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=NZPqZhAaXb2MtaR09tMhsPzH8DGxHOJQBSrrKghQSOphthhF6UXylim0TXkyawMj5
 RgyKs+2BoadHeIWr5NdW4riKGvN+qZNHCRPD5xlomkSPqmgKfQ7A1roJaMQOcffHXZ
 3mlLdILCSSUaTLeKhkaHaeOjOm2lSzfJA2SHf+BYlffb5su7Diqow1+FjSjzIP6IEX
 nu30BSDz8Bx2H9p2uhfU2MpgkmR7uKnO5aAjSIJYqmeQrcHCnckkgZ8aVjdw0NFWSF
 Qh/cDB8N6OOSznI1yxuU3GafEtdAWFMOZAsdok1gXB5oIqRMLcxxMwNRAmbVx+AyWM
 bFYouiMwRYqEw==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4jGSV00Ly3zYwr; Fri, 30 Oct 2026 18:18:00 +0100 (CET)
From: Quentin Schulz <u-boot@0leil.net>
To: Kever Yang <kever.yang@rock-chips.com>, 
 Quentin Schulz <u-boot@0leil.net>, Joseph Chen <chenjh@rock-chips.com>, 
 Coia Prant <coiaprant@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Liangbin Lian <jjm2473@gmail.com>, Johan Jonker <jbx6244@gmail.com>, 
 u-boot@lists.u-boot-project.org
In-Reply-To: <20261023135614.2376931-1-coiaprant@gmail.com>
References: <20261023135614.2376931-1-coiaprant@gmail.com>
Subject: Re: [PATCH] board: rockchip: Add support for Graperain G3568 v2
Message-Id: <179338068001.786412.8083283870404673945.b4-ty@b4>
Date: Fri, 30 Oct 2026 18:18:00 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.17-dev
X-Infomaniak-Routing: alpha
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 23 Oct 2026 21:56:14 +0800, Coia Prant wrote:
> The Graperain G3568 v2 is an RK3568-based development board, just like the RK3568-EVB.
> It always uses soldered connections between the GR3568CV2 core board and the
> RK3568BV2/GR3568BV2 I/O board.
> 
> The G3568 board has multiple hardware revisions, and we currently support v2 (I/O board).
> 
> Specification:
> - SoC: RockChip RK3568 ARM64 (4 cores)
> - eMMC: 16-128 GB
> - RAM: 2-16 GB
> - Power: DC 12V 2A
> - Ethernet: 2x RTL8211F RGMII (10/100/1000 Mbps)
> - Wireless radio: 802.11b/g/n/ac dual-band
> - LED:
>   Power: AlwaysOn
>   User: GPIO
> - Button:
>   ESC: SARADC/0 <1100k µV>
>   MENU: SARADC/0 <1400k µV>
>   VOL-: SARADC/0 <430k µV>
>   VOL+: SARADC/0 <50k µV>
>   Power/Reset: PMIC RK809
> - CAN
>   CAN/1: 4-pin (PH 2.0)
> - PWM
>   PWM/4: Backlight
>   PWM/5: Backlight
>   PWM/7: IR Receiver
> - UART:
>   UART/2: Debug TTL - 1500000 8N1 (1.25mm)
>   UART/3: TTL (PH 2.0)
>   UART/4: TTL (PH 2.0)
>   UART/8: AP6356S Bluetooth
>   UART/9: TTL (PH 2.0)
> - I2C:
>   I2C/0: PMIC RK809
>   I2C/1: Touchscreen
>   I2C/4: Camera
>   I2C/5: RTC@51 PCF8563
> - I2S:
>   I2S/0: HDMI Sound
>   I2S/1: RK809 Audio Codec
>   I2S/3: AP6356S Bluetooth Sound
> - SDMMC:
>   SDMMC/0: microSD (TF) slot
>   SDMMC/2: AP6356S SDIO WiFi card
> - Camera: 1x CSI
> - Video: HDMI / DSI0 (MIPI/LVDS) / DSI1 (MIPI/EDP)
> - Audio: HDMI / MIC / Speaker / SPDIF / 3.5mm Headphones / AP6356S Bluetooth
> - USB:
>   USB 2.0 HOST x2
>   USB 2.0 OTG x1 (shared with USB 3.0 OTG/HOST)
>   USB 3.0 HOST x1
>   USB 3.0 OTG/HOST x1
> - SATA: 1x SATA 3.0 with Power/4-pin
> - PCIe: 1x PCIe 3.0 x2 (x4 connector)
> 
> [...]

Applied to https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip (u-boot-rockchip-2027.01), thanks!

[1/1] board: rockchip: Add support for Graperain G3568 v2
      https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/32570931295195c700bd52f0b252af46107e65a2

Best regards,
-- 
Quentin Schulz <u-boot@0leil.net>

