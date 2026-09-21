Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39910C982ED
	for <u-boot@archiver.kernel.org>; Mon, 21 Sep 2026 22:51:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2C2F080DD7;
	Mon, 21 Sep 2026 22:51:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fuWj5fYRU1Ph; Mon, 21 Sep 2026 22:51:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 4CDE380DBD
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790031104;
	b=Xq0Is4HkI7kbuC/ZULi/L5QhE4Jyo86SZHtn7h6PrFACArgeq1FzIMfo5gQCKBtH9MCu
	 iHN70CKY+M/UkKTqYByNxmyUykxMqVLoiwgtfX8pxGmLDVvXOaEKf8nxrELhafdJNz6Gn
	 IxiF0TjRBXIdQjCzeWCLQnMF96ZdTUO4zCkwFQt3HiyWTNJQnY/YqeQs5OrH9tC5BMH31
	 y8F8lIYSHwKbHy5EvlT90zKzU6UDrNCsTlX47WZvRW8m93anzym+iYU50ZdCIs0FPs63n
	 KnhVrla9HfWhWqkvitmc/BQrWjPn017XkalGbCG4b4wuk9N8NUSasGDKwvF5diLVXsQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790031104;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=2IWbVTCXxmfXLv3YUOCIo4vnvSuDxiq4nwSEoU+zIgA=;
	b=G3JOHZQbLbd9FZfLZS0nmMLLrOMxHlafwzE3Hc+crpV9YWR+8d5weT9+xl2X8eQgAFDd
	 MtVdClr6n2DonQjYXeICzW8SBrNQYfkZkpSVmAwVwkDZLCG2xFPCCYbppoxCKRLmcDmiO
	 SpwjpqsJHtyPzCn8mzKspkHcaMfSXQMf9KZADS3VYTeCj/jnEU+Qpjwm+IcIHW86AVLpk
	 wMRmJbMUEHPUdAZxVPUT8HjAIkoqybAg91XRmQePae2bLW1hDtuXmZLyCBCpa/xOxHiXg
	 KT60gfktVPgZoCRyf/htrXoP6PBZlm7kEKkNJf6jWTLSqMpT3ZSyNHyVbtrPL5SojYg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790031104;
	bh=2IWbVTCXxmfXLv3YUOCIo4vnvSuDxiq4nwSEoU+zIgA=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=MStqzrQ+0bwoYImRp6CPTIHNLbdJGhX1tlmVclF7ZHZp7gtnu4uf8g35+bo6CZDrI
	 BHZADVdFDkEwAjtW6Mm8rNYTnZHMAycF/efuqkIQv5dzQCWVY048Vn/XbRiNAkH7uG
	 Y/1oYtqF1yf7AmJH4PVrpgGvOzVXgVE2W6nH5Qlk2yucZDfwD+mDbtvheYKPHKoUN7
	 gctt0LHNbTjOlr4abeDsBv7K1uES3MnDnU/1eHY9zq+j73PQEpqLQ8o+s+a4yohos8
	 qr+8XVZzf2d1EtWfImxH0HCeOTzC12Nq3+YV7OVD1jWZULv7y9jj432URw1S0U0Jsp
	 YGmuFsWP4VPyg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4CDE380DBD;
	Mon, 21 Sep 2026 22:51:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id F138C27C
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 22:51:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EE66B606B8
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 22:51:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h3dg3mgpFTUd for <u-boot@lists.u-boot-project.org>;
 Mon, 21 Sep 2026 22:51:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org AEFD46066E
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:30::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790031102;
 b=LaXUgRf971wy+In6K3lYx7XA0l6Q/udGjgjBLUtuhf0jLtdhciG9XpBKCDt36vZUitT6
 GYXMs3/MwzXb96hIZgXePiC75SU7TdtGHLq7cNTf1xFw56v143RF8EXbbNxOoUlRH+Bt6
 n8RyTXp4mKmCtKFp5dxihG8x08K2gqrSsVZFM5PsRv8V7EoJYeygCBlt66f+y5/ZoRUCk
 MXkyesHm/4W6x1vtwbn2OeYfoCydI/XxMfq48+BcQb8P5+De8BeUkk0PIFtP+Ox2xOos+
 Rz2KtfwTIGIXbO75bbuFZ1GlvZhRKufWfixtthzHMTNYfdHJxpMan/2gutzTDREyKhQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790031102;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=2IWbVTCXxmfXLv3YUOCIo4vnvSuDxiq4nwSEoU+zIgA=;
 b=VAW07iqSG0hh4aEa6vDio0sAwvj6qKLNt1ifuCzfWTdGdBFOIyPou+L4YobwSt6S4UAK
 PVB6/HQ1G25Mvsd4Sq2udEgBRbPpU4XLJL7RFGy+pfEROgmiuORP6z+icugzYyySU1N1f
 rKSqI3Yek8c0uDK5suA/QsAOwleLdkTjCImYkYXmsGQbnz67KKDGKGNZbNk6rH1ig3C6L
 INYPP+MnGTFFm69o3UNX2oxdOF5wa8n6ozccxDWhgWQsugSCSNJRgKwrUStaGI1VOyyBx
 6lXYSQhF2TsQOlDZZLzE9huVOjMXFTu3hTydTejp5kaBjycvK98murSDD/eAb8JqL/Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=QCCMS3jl; 
 arc=none smtp.remote-ip="2607:f8b0:4864:30::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:30::10; helo=mail-oa2-x10.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=QCCMS3jl
Received: from mail-oa2-x10.google.com (mail-oa2-x10.google.com
 [IPv6:2607:f8b0:4864:30::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AEFD46066E
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 22:51:41 +0000 (UTC)
Received: by mail-oa2-x10.google.com with SMTP id
 586e51a60fabf-466cc9ab667so4226060fac.0
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 15:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790031100; x=1790635900;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=2IWbVTCXxmfXLv3YUOCIo4vnvSuDxiq4nwSEoU+zIgA=;
 b=QCCMS3jlTnXKK0EyfCmP7Qk93S8Kxf0AfVrgRb9GX3gaQWk0QaQvcgLk/hlrSZTKgd
 Ikl/soZyE7vZ+jAeOEeP5NrpZSTceajvuUTaeb92C3NXWSaLopCem4PurmAghkerGb+X
 udK8+1wlSpOhYm9XaJuXRnRNRXPZbOfBL446OHTBWvkSEYmv0UdnvINQpyfWEE0SyW/k
 T0fOaUqUaInm6fwqJQptAYungR8CEx7m/iOSppOj3lmqMK0NUIph9PtZcRMQihLs4Xdb
 Su5b0wRwadgWZ8w2tRdypa/4VjBylHEUGXRpBzGbS8v0p9aDmLu+3tKYo/G/bFVwJUcO
 ldwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790031100; x=1790635900;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=2IWbVTCXxmfXLv3YUOCIo4vnvSuDxiq4nwSEoU+zIgA=;
 b=z297kErJmR6DXNwk7AvpnwwieZJYkSYFnEK4boPMrMzyo6POXC6i3uvCVriEenAIni
 UG8AqJqfqkbTmEJMMRaOfc2LOzakVLJL7Lyuop5xmXFAHwP4aQSzDA3hK5iP1aqk0pxc
 hUDgg+2sBLCm1oe3c9NJ5bF9nEj/gZXq2E7Ko9vSKlrBVm9NOHTTxDv1D8Ed6qfuNF45
 wxBPxz5jiZqARa5itI7q7A99VoHEs1DwnmW4ZA0HAaqbLQba87x5rR0FEcvNo8Q28x9o
 +5flIHfNnqZtQqWIaU6/w1eGQ1sRIelm7xucMmAyRpMGZhKm2XL1UsSPP6gTlYw5DSBQ
 olUw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzPqUjfihlBP4vkLQwu/lTFlFJ2XjTBLUZk3iul+WKuJPQNoLP8OyN1KpG9jA3N/UiKKjSdy3I=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lCCYs4yaqQ8/CQzOhRJwzEUipnfI10UXqeqIA2+P3+Ap3cj8jb
 9ReXSOqxPKVfoj8o4UdzZ0ThM4XtSmXJYXLDDW6vgcB/uHccT/X9QJ0hgB3A/yMrj1A=
X-Gm-Gg: AYBFou3rd2LJhdEEOcqgJDJjkoBfBwLYoClR5XxVyblxc7LjvwqH4KVZC3me3eESBt/
 AU8MIn+mb4yUKTt/VL/oInzgC8ItLmaJPQgus1k92rwv+cIVIqvel7J6SuG7zUEnxXyb/6wsus4
 U5SAkOBC+MJi13sdpCs3pvTcXw/+w6SOH9uc9agP3XbdWYYS4gXeeRRejELrbuJHdgudZAzRzOy
 R/4bOCOJG/Ry6O4LFHh87l6iVw4GvxCtVw7t9uR/hdxPYo8j3uv2A14nrGpTUzJiMvCLNoQpLoR
 u99rRIg6YPxaugN7YXkGpt9+STfYkhJHeD8CXF1f/DRWz2AcCQB2smLyzFAffPBbYtTiSqLRdvO
 lrZgB+pUQgXgLXJoVffwvwoSAbfmlkOfvc5w2M1MWbmk2z0AjIwGxOuWQKQebmVLlDQUGO2ZLuF
 nXYYZwSOQKJ1geUIF4Eau708Qwbvj/X6iKSl4Rw8C1/MsrzUhpE0maNfBuajuOl5NW8+yxmuAnU
 ZJWfeSFul4Ufw==
X-Received: by 2002:a05:6871:7a6:b0:475:a153:2dbe with SMTP id
 586e51a60fabf-486e6de2467mr11561474fac.20.1790031100282; 
 Mon, 21 Sep 2026 15:51:40 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:bbcf:6512:c1f9:5b9e])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-48f71e90570sm481468fac.4.2026.09.21.15.51.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 15:51:38 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH 0/2] power: domain: mediatek: power up the SRAM-isolated
 MT8189 domains
Date: Mon, 21 Sep 2026 17:51:02 -0500
Message-Id: <20260921-mtk-power-domain-sram-iso-v1-0-52e9b365d2d1@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NQQ6CMBBFr0K6dkzbAEZX3sOwmJZBRi0lLaKE9
 O4Cunb5kv/fm0WkwBTFKZtFoJEj+24BtcuEbbG7EnC9sNBSl/KoSnDDHXr/ogC1d8gdxIAOOHr
 QZA2VaAgxF8u/D9Twe3Nfqi/Hp7mRHVbhumg5Dj5MW3xU6+7X0epPZ1QgAYvCHPKi1raRZ4PTg
 02gvfVOVCmlDyYDoenXAAAA
X-Change-ID: 20260916-mtk-power-domain-sram-iso-2ecbe6abeaa4
To: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: David Lechner <dlechner@baylibre.com>, u-boot@lists.u-boot-project.org
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2278; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=vUs2W43atyiLNYKORa8lgve9y/OJkxFUbWnWDUCUlzs=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqsbTk9fXAy0+VEfYnKWbcZ2mXxj7th8kJNWWEi
 CbgNmllrbmJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCarG05BYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AeGoIAIr9FW9N3mIt4eE6ASgT3FmbJrOh/RhIXN1qRul
 kWK5wn7+GQWOVWXQjLzZ5AE2HWCyVeS7obDLYuystAHjvc8h2Fz8W6PQW6o7mhH0QgXJCkY/q3Y
 SeCk/bF04SWf+5zpAGW8gfnZ1YsPUn1XbDNujEnf0FmQEfKdWMIRP0RsUebTbYCVvdgM8YaOc64
 bTmgUZh+mDRUDfGuGBZnzEeef6j6YW+/CeX16EF2evZh8rmkp26YOiV3hJ0oWIIG/J89lGcgP86
 fAynMbKwB+fyC6ZOKiL1EwE/ak+FD8N7sGH06fETs+R1ONjP+wTO7hhu3C1eaQJGRTRkVJPavLD
 Anwc=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Two of the MT8189 power domains, ADSP_TOP_DORMANT and EDP_TX_DORMANT, were
not implemented yet. Both need the SRAM isolation step around the
power-down bit, and both invert the meaning of that bit, neither of which
the driver describes. Powering one up clears the power-down bit instead of
setting it, so the SRAM is left off and its isolation is never released,
and since the acknowledgment is inverted as well, the poll sees what it is
waiting for and power_domain_on() returns 0 anyway. The MT8189 driver said
as much in a comment and it was ok because nothing in the U-Boot device
tree referenced either domain.

The eDP transmitter on that SoC sits in EDP_TX_DORMANT, so bringing the
eDP output up needs this first. Sending it on its own, ahead of the
display work, since it stands by itself.

Patch 1 adds the two capability flags to the core driver. Patch 2 sets
them on the two MT8189 domains that need them, and states the missing
SRAM power-down acknowledgment bits of EDP_TX_DORMANT explicitly rather
than leaving the field implicitly zero, matching Linux.

Tested on a Genio 720 EVK.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
To: Jaehoon Chung <jh80.chung@samsung.com>
To: Peng Fan <peng.fan@nxp.com>
To: Ryder Lee <ryder.lee@mediatek.com>
To: Weijie Gao <weijie.gao@mediatek.com>
To: Chunfeng Yun <chunfeng.yun@mediatek.com>
To: Igor Belwon <igor.belwon@mentallysanemainliners.org>
To: David Lechner <dlechner@baylibre.com>
To: Julien Stephan <jstephan@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org

---
David Lechner (2):
      power: domain: mediatek: support SRAM isolation and inverted power down
      power: domain: mt8189: model the SRAM handling of two domains

 drivers/power/domain/mt8189-power-domain.c | 14 ++++----
 drivers/power/domain/mtk-power-domain.c    | 51 +++++++++++++++++++++++++-----
 drivers/power/domain/mtk-power-domain.h    | 17 ++++++++++
 3 files changed, 68 insertions(+), 14 deletions(-)
---
base-commit: cc9162bd9d65870bde567b9cac72316a8487aa09
change-id: 20260916-mtk-power-domain-sram-iso-2ecbe6abeaa4

Best regards,
--  
David Lechner <dlechner@baylibre.com>

