Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23D5606A339
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 18:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=tL/z+DCk;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=K3zBew5a
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9A60D40766;
	Mon, 16 Nov 2026 18:39:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SqCk20TRll5q; Mon, 16 Nov 2026 18:39:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9DF7840653
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794854386;
	b=PxZypuS8FqFZO9O1DqJWkpBJp8Uw4S6ogP3xFJ8tSCNDGsFK+LowFcj0h/T5wsnXXUKM
	 FN7U1eGB3n3gHpd3pXw1kmNxYeP6JUaIjKmvT3lH3WC1LeBrsbiqi3S1xjQ8VoGY5Je9J
	 ZFHq8i0dE6FLXsnUyMBu553V1ejrIJ29BgghgwP5jeV/3rcqYLggB9AnGWbKcuB+V9nsD
	 4yCOzCtGu3OH9YuArq0CLL4toeo3tNxmxujEvFDq45TRK7lvT7O7LjWslcwyEVyft9N9l
	 8iBhKpFKNZS/T56AXWHtOF+trAzvR+JdGvwBk9AoR+gFFiJ9fFJeXB7S/K6ZtyZThlw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794854386;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Sender:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=Dm0zR9X7ZNh/gOVIeALKlYHxWHV9b/uNGRfc090u/Qc=;
	b=TUeLf229Zq5oguY/gq33UdC8j2TNUtBgr9AY1PRFy85avvpxdwTYKo7y7A+mqt1ozv98
	 UYf+VLynOpAVe0QJ8KZP0Qwn8yFZw8lWkO6FMJyTH1lvMPm04dhom/wDEb/YfCKNDPX1k
	 sGCXTq5tojkxo+h2/4r5QdXaKF8x8jQVanhEfN5JHp7jgzAmHugGKZDZJUn8+lQIIgi6x
	 Inih0nkVhKkvXcVCPIwI5hitoPZPEAene44IQc7dYDuMTChooZGduf+WQjgG2+7G8Uxrm
	 Jhwq4ozVcerbvAZTPUE7AUDPP7zy5Uy1ZAmHNqCrLV1Fe2pBLSBz0xEbkb+4MOgEhWQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794854386;
	bh=Dm0zR9X7ZNh/gOVIeALKlYHxWHV9b/uNGRfc090u/Qc=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=tL/z+DCk2hliqV89VsOiQ2HGU7/9FoMZI/Gv7NSwONSV8Kxxyg92XXSVWS9wJSno1
	 pHK2HcftiR8VWnathaV9MIQeRXf0cMCC+uuJPXjzeK8ZJ1TiOg5h0T6KXHwW8b7ITG
	 GVxaHdNkYMZKZEQnyYWCp7GsyGXyAjWwBFP91q/VhR4DjX0/sF+jxu/qteYENN6kpL
	 lmfZbq17BaD1rDzK2985/lhzV2Wd6BWiBCKi3adkaFnLxRN17U4f9/c/5qqhgqPrbC
	 qnORB2Pwp5U5zGz2wFt6G3Owu3m5VHup0z9TDZY8n/aCXVEnzOP/nDlb5UCFnHMfXB
	 Qd5LPDZYsP9Kg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9DF7840653;
	Mon, 16 Nov 2026 18:39:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 69BD428C
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 18:39:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5BC844007E
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 18:39:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V3XplGBqjklA for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 18:39:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 17AC44007B
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::430"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::430; helo=mail-wr1-x430.google.com;
 envelope-from=massimo.pegorer+oss@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=K3zBew5a
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 17AC44007B
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 18:39:41 +0000 (UTC)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-48e20ed3b9dso4112266f8f.2
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794854379; x=1795459179;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Dm0zR9X7ZNh/gOVIeALKlYHxWHV9b/uNGRfc090u/Qc=;
 b=K3zBew5aYWCPo+l6EQQ3MJUg+4SaY9BpdEB0+XyiPcrYHkjidxueq7/22+JwWREIhb
 lwfjpNgMnHWf6EBBM8y153ptLd4XbYjy7waTL50kXoC08uT2aKvE6/yVnAr3GnDcf0C7
 1v3V0potOLi7CstqssuCKhjHtwaE9RwDE3/D9XdYyxl6Zq35QlXAd9RWjM/pZ3PX4MAM
 VRa98aLPhMnsfqtBz2DlOauDHm5zeLnvdGgTD3YfW2xOCsBEj8YWPw2QW7vzItkwACCc
 EKwRbF2K8I2UES7ClMkxYwK1pg0RkqfelAt7vdWxfPn+7lYSYoJDVArI7XeB9D6a8H6t
 6tQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794854379; x=1795459179;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:sender:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Dm0zR9X7ZNh/gOVIeALKlYHxWHV9b/uNGRfc090u/Qc=;
 b=l3OLuf8Yj2cFo5tsfOZYUahlsd1scvT1He4ew8Kvkdj8GFB//xRVsZDspfZh88c8a2
 dbhPQkiCR4rlUzSSTS4CXLiRNgO9GzlH/xd5Z7S/+2wA+F+7DUwnl007GPDjUzel254x
 zLezRfAR3AlhzlPZ57lO63YIGCyMmJiK2s6Bdj33VgItkbKL9VwnyWM3dLFfZClOYZ0+
 72I5t6HM3wZZ4F3msD0IxF+KH0eBf/1trmktHBgwiyzXoFSeJsW63Sll5eyyav03BHWl
 rfynzGP+YdysGK9Cuikbs9t3UCMi9LRIArGJ2M4t8Vg5TcysBeoDHPjZEGWX54JPZQ24
 yeCA==
X-Gm-Message-State: APuU4Z9R20Do0sKv6w+cheCnYXEOB/8arFkLuTVh07cb2A+YJl1chLn7
 IL55Rod2YsgeCj/t6PEXdu+dcPgZRxmY4fEnkybtoWlZXZnRZwJ38Re2
X-Gm-Gg: AZFdTZdcK6PmAl0NQKVs3hKkHAljKO7ecr6qIFnA4ez5qF+s1ci5RI//YVCICAD/Nty
 5Lo7accpnvkSIvHCujCvgDRUrE0b4D7ix0B0XoClGP2IesNn28HEK2vh52uYdXJljcZVsQQTWqI
 JHXnOnfCDI2DDWZH01sTzabSjEFO8LKU9G0rxxWMVyCoXXCxZRz0urKkyb8kV/7yPKzlr3a3acS
 EhMiwKq+8ZspqU7qm9hRk+62fNgvNgmg4w+9Vdr4jcRRNrG6p8TtGTFt9U4XduX368UMtlQDvA6
 Ldu6I9Gf6XkWavKmSoIGNFYO8yQFlWV+YLMW4RTjvJn2RFe48sjHNNS+ZfLsG6MVW2S0csb2NmL
 hNt/l1bYZ0qGh2h2asKX1NwpRj4wEKVFizWChvb1v5gU0+p11dvoUrP9kvgdB4YYhkaCY0nPvtN
 HcSlxT8Y3cwWlbRLSnT1GDiZ6RIecMEaEM1TcjB09wKCvEXQviRRkvhM5ZgkWy1c4WWH8NEBvL6
 yw8orTGAT10vX4uakUMRHpXgguMEtWv4F4GJ84RfgrG4CTtT2fEdxWuvn8h8Is83OPk4EU/eAdK
 qCOAZTZPNSagyS47Au0Zs+eCUD/C/ADaMROKdAhsokxFTMw=
X-Received: by 2002:a5d:5f08:0:b0:492:20e0:f666 with SMTP id
 ffacd0b85a97d-49c6a645f16mr22959411f8f.0.1794854378990; 
 Mon, 16 Nov 2026 10:39:38 -0800 (PST)
Received: from [127.0.1.1] ([151.71.173.194]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c609c8a77sm23947618f8f.49.2026.11.16.10.39.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 10:39:38 -0800 (PST)
Sender: Massimo Pegorer <massimo.pegorer@gmail.com>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Subject: [PATCH v3 0/3] Improve Rockchip SDRAM types support configuration
Date: Mon, 16 Nov 2026 19:39:33 +0100
Message-Id: <20261116-ddr-multi-v3-0-fe9fb30a3169@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOVN+2oC/02Nyw6CMBQFf8V0bU25VCiu/A/joty2UMPDtNBoC
 P9ui9GwnOTMnIV47az25HJYiNPBejsOEfLjgWArh0ZTqyITYFAwAYIq5Wg/d5OlgNyoguecoyB
 x/3Ta2NfWut2/7Of6oXFKgbRorZ9G997OQpZ2v26164aMMooMS5GXUitg16aXtjvh2JPUDfA3M
 wbnvQnRrAUYU6EoWC335rquH5pz1RHuAAAA
X-Change-ID: 20260828-ddr-multi-2c4fd64344c8
To: u-boot@lists.u-boot-project.org, Quentin Schulz <u-boot@0leil.net>
Cc: Tom Rini <trini@konsulko.com>, 
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>
X-Mailer: b4 0.15.2
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series splits from [1] as preliminary to a next series related to
support of multiple SDRAM types at a time in Rockchip PX30 SoC TPL. 

The first patch improves clarity of SDRAM type support selection for
Rockchip SoCs at Kconfig level. Not all the SDRAM type config options
named in the Kconfig are supported by each of the Rockchip SoCs.

The second patch adds RAM_ROCKCHIP_DDR3 option, forcing PX30 and RV1126
configurations to select one of the RAM_ROCKCHIP_XXX options, dropping
the fallback behaviour of using DDR3 parameters set when no option is
selected, adopted by these SoCs drivers: now, if none is selected, a
compile-time error is raised, instead.

The third patch raises an error if more than one RAM_ROCKCHIP_XXX option
is selected when compiling PX30 or RV1126: these drivers support just
one type at a time. Drop previous approach of choosing one type among
the selected based on a debatable and embedded order, not evident at
configuration level.

[1] https://patch.msgid.link/20261025-ddr-multi-v2-0-b82ff9c860ba@gmail.com

Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
---
Changes in v3:
- Split 1/4 of v2 into 3 different patches as follow:
-- 1/4 only add SoC guards to Rockchip SDRAM config options.
-- 2/4 new DDR3 config option and raise error if no SDRAM type is selected.
-- 3/4 raise error if more than one SDRAM type is selected.
- Drop useless replacing of defined() with IS_ENABLED().
- Drop PX30 multi SDRAM support (2/4 of v2) for another series.
- Drop TPL size optimizations (3/4 and 4/4 of v2) for another series.
- Align cover-letter description with updated series contents.
- Link to v2: https://patch.msgid.link/20261025-ddr-multi-v2-0-b82ff9c860ba@gmail.com

Changes in v2:
- Update and reword cover letter.
- Do not duplicate config options based on SoC.
- Add SDRAM config option for DDR3 explicit selection.
- Raise compile time error if no SDRAM type is selected.
- Raise compile time error if more than one type is selected but the
  driver does not support more than one at a time.
- Change order to alphabetical one, as the most trivial option.
- Slightly optimize sdram driver debugging code.
- Add config option for size-constrained driver debugging.
- Link to v1: https://patch.msgid.link/20260829-ddr-multi-v1-0-c0c7837aed20@gmail.com

To: u-boot@lists.u-boot-project.org
To: Quentin Schulz <u-boot@0leil.net>
Cc: Tom Rini <trini@konsulko.com>
Cc: Massimo Pegorer <massimo.pegorer+oss@gmail.com>

---
Massimo Pegorer (3):
      ram: rockchip: improve sdram type configs selection
      ram: rockchip: add DDR3 sdram type config option
      ram: rockchip: raise error when configuration is unsupported

 drivers/ram/rockchip/Kconfig        | 24 ++++++++++++++++--------
 drivers/ram/rockchip/sdram_px30.c   | 11 ++++++++++-
 drivers/ram/rockchip/sdram_rv1126.c | 10 +++++++++-
 3 files changed, 35 insertions(+), 10 deletions(-)
---
base-commit: 701db9119cefeed95b77df90359cf96f78a5823f
change-id: 20260828-ddr-multi-2c4fd64344c8

Best regards,
--  
Massimo Pegorer <massimo.pegorer+oss@gmail.com>

