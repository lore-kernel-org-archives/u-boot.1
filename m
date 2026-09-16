Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BDA6C88E5C
	for <u-boot@archiver.kernel.org>; Wed, 16 Sep 2026 04:16:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6C6BD60792;
	Wed, 16 Sep 2026 04:16:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1lwg8w7lZA3W; Wed, 16 Sep 2026 04:16:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 66021607B7
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789532195;
	b=YcsqOsC/bNAozQz98pQuuRPpMDd/ZmtZaVbyHj1ibujVtKqImduTfVs8qMeEWWoJMkMo
	 DtZjLigaC1WnDoG4IHXltOWOeaEe1tvseG+Fw29gJGfG1ZTDiLuNRH3kcpkLCD+MnCiE6
	 7gq1/wcm8H/h8DaGKkr1C/pEpuqYibjG85fVUQ4lrEkzhV5yv5GJzormekVQ3B3O0A61I
	 RF2duFXa/XA8PphFQANj3Ua4sLgnFLLTm/+PNUgTUA4mReMHoRQLjIvD32Pa3iSXiuTFb
	 m3QFX/Ix6oMJN9ZjHoXtpZTUvLQzrtriuz2xdJFow0AS8jWmSm7RNKlSCXtsePAruHQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789532195;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=XZt2dokCoQ0l3tYpnd3qjK7U0g5ieC9KzsNv9cSO/ag=;
	b=bRPGshwvHruNTgNHUQTqov7IoFTj1smh5P+98dnNB28SXmXe+urY/f0ccpTu7TmJq3wL
	 enlp9vSmtsRrAVElPCPvpZjaEsYhQWBJFFtulnM4XMEe95I9GqVWCDQUeNgs91C2H5x0V
	 grjCcitmHVqaQrkXGmXxC6D0zcglIu79oX0DFuaRycBdeTdxB2UHYJl4fWMb2qqiUa9Dv
	 VjFkYkuV81StrDyZFmmATsVAAZ2s7ThDvb6FRZnGBE64QNV1VMfs3FQLoLm30vTReVV3Y
	 ZCZNJl58IR53xfelBmlAsZ4qCX+sV3IgjQjDk32Xlr13W0RODBf3m+TUmhwvtdDaZDw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789532195;
	bh=XZt2dokCoQ0l3tYpnd3qjK7U0g5ieC9KzsNv9cSO/ag=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=iG0uhRizj74AuQhfaPe0HRiny0e92+LqfR8I2eiQivgEIWI9GP+EIcC5DUZ07eW+x
	 90uLZ9L/0/4y+cItfs7TgbgDuO3MURHp+fMAqQaeub3Ga372FKSEi3v2r4RbXRxkhO
	 bUMwerC6ED12bd4TI3DEdzA0dMRv//b8AjaupFt/NEEEMfCx39NMqwtmt1Rdkp9OS7
	 1YaITJDuDZI6ZeuvvKh4qxBSmH+MVgirf48QJvf7FZ/c6Fpy18Kv/2dLPzWnrgYB8A
	 Y50yNYmXVBDnKEwv2vq3Uyi5kDj8ZDR5L0mcagn5A9R4uZiFXPhuZ2itOKqSqFG9GZ
	 5dyANVVyCEAXA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 66021607B7;
	Wed, 16 Sep 2026 04:16:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1E5203AF
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 04:16:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 04856400E6
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 04:16:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id s5qH1xn9JHQt for <u-boot@lists.u-boot-project.org>;
 Wed, 16 Sep 2026 04:16:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 2C13540076
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:39::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789532193;
 b=bF7lb9yabH+Rly2QQY86sae42lCtj2gX3hVgGgwz9UElEDEo+9YX8htrOLiNhjg0z/vI
 RrYLlIkViimL5i7PySMecaXwcmKPAbO/2ueppQnn9dWtekSUv+fMJ8Ss/uZgSNdwzTJAm
 69wk73ilCfbcHfMLAuJmDurhsVkDBFXUI/SP31vmuoQC1jFMQWbOUn4Yt0QtNmXW8nzTA
 gk5IdgW+5CG0S4Y9k3++pYSvsMG690T/HCFhoe+p9kZgS5jGaxseJOrVfohD5Ym38sDpJ
 ZnYEj70MuUS6sCCwaYJhOzDlMAJn+c1k5g2ksZfMI3kqJ/83LmP4fmlWUqqxk1PgjHw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789532193;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
 bh=XZt2dokCoQ0l3tYpnd3qjK7U0g5ieC9KzsNv9cSO/ag=;
 b=OjjfrDehsvH2PSmlq+I7u2EajL+SmqFrL/+94KsmZqxeKGb4N/bNhLXeUvH86pYVhPys
 DPoUeEd8BIUOxvdI+wt1ej8F+Kz5tBrZneKBos/Z5JHNEZcwKKpPldd/JcmZhguyFOJZX
 TzX7CIbLdP3dJqmuCneGjdHRdXQAChxfU6BEw5EQnv7eRf+2p6a2Nvf2Q3KGbx+lbzdun
 m0L2q1B958PC04LPK2RWxFYqhaQXe+VGakFth4zUZ1ZTN/ZLCLXddstsKmkWZ9g/yvxU5
 39cV2v8SAZ3/eea0fKK5Fk6W+CQNY/yqTRcDE/iE1WjTcUY4o+PjtYxixQzVWvnfHZA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=rGfRhgTw; 
 arc=none smtp.remote-ip="2607:f8b0:4864:39::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:39::11; helo=mail-pj2-x11.google.com;
 envelope-from=imkyufie@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=rGfRhgTw
Received: from mail-pj2-x11.google.com (mail-pj2-x11.google.com
 [IPv6:2607:f8b0:4864:39::11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2C13540076
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 04:16:32 +0000 (UTC)
Received: by mail-pj2-x11.google.com with SMTP id
 98e67ed59e1d1-396cccbba92so391182a91.0
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 21:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789532192; x=1790136992;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=XZt2dokCoQ0l3tYpnd3qjK7U0g5ieC9KzsNv9cSO/ag=;
 b=rGfRhgTwE0GX+Vheu0itfFmsS6euEGbHM6QzC+N3fkySLnP/xRK+Fjat4R7rkq5151
 +ci+VNkf0QKAc09doQO0/bkVyVshSlERwKZaiItiGbZZ7/UxvT2CdDp3bQXzSq2FWZtZ
 zOy91ILgKXQ4uSh4Iiyyh7dr7CSNx6MFUnCYhF2NdYcUA2KVvOQgFGoQHkgf4WFJNvx9
 BDfyyubu8TxcaMpSRoH03eb8fbYxszI48GNX/WsR1CqjadKeCcXevbXdGBUirkL3OD9h
 zFxMJ9OwcUu3Ig7zByCBRKIxTTGk7sHs6VYZ5wczLg2SoHckvZtRJDhhHDfM0PoT8p5B
 TKMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789532192; x=1790136992;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=XZt2dokCoQ0l3tYpnd3qjK7U0g5ieC9KzsNv9cSO/ag=;
 b=XqDa2/PRnoBOmpig7p7fuPREmjTXPu7PXJ39Q+KDM051wenTHwImUWvatMf25t+xwU
 Ro5bdUXQHToXPeqdLw0qI/Q8lz3+1mpyDL91GCKazahQPBqHOp5PBb2yzS+aoKg6O2AY
 yqQldOQZC1VAckgnNgPGGWGG8Lpw3A1b4f8Yce0sRiH4P7EzIf9QaiO5esvUO7hkbIBS
 x37gagqyvMs3Okv5ZUWQAqkUVJvkZcSmnqKQkeGIVmsJILx2Ihg+/MfZtKGAF4raE2KV
 qE6nWUvE6PrvYlsY92dMV5QMaOSrsVFsgkRXcByVEVQ0IPFHzhx0nOsO5ZN2rYT/ssYZ
 Co8A==
X-Forwarded-Encrypted: i=1;
 AKwUvBych7evJyDOrl+8GjeC2kDvusTeCQY29o+c686EWUp9u0C5NphBjA7DnqSNx9QtCezEjm76tyg=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nlm6iMCLFKhiZXOvbgvJod+G3TiR3Mpf+tJt/+XhWNbOiveA3p
 0ZFDWUaegC8pqKzlu8bIRlJRn446MVoTtvzAUzBWbHibUujAFCi9O9Cu4ktXhw==
X-Gm-Gg: AYBFou2QaBjVwqZWryeAmYsnvN9GjR3Wusgoh5XbxLEGCtjtXXl2LGckJeszQQdf4Rw
 OCG7poEShz5im+yDL8IV8+dTGJj9uSPVIYGyIeLJYBwGvf77qnXkqiRwzevN+atze431q9q/HBp
 mwpXkahh3yTxuwYEg5Na0chriS+zx4vDe06fWR0DL0TMTLENUdFiZKlyA9WFhRPUTcgssGPLRld
 WK71zgD0GGT2NJdkVpL9xUGK2hu1C6H6NDsInpfLqa9m62vbO7i2Tgeo855mfiHYAUJV6vplHEe
 CrqcfqumDZOOMqk9YQ+u2rIg988gcQItSOOYL4wp+cG8AyT8qeJuiOwFOEoMfGwiI2IU8nLka5h
 W4NXNpJgOWNQ3dglB+NpCyY3lMxUZNW/DBa8V7CAIQjU7lBC9Xp0wN4pLBvROZMRLcgcW5OUX1m
 E5Fb8gLyXRxKmeXGLaEunx2Swx+09ILbbvOsGeU6GvOtWMBMg+Ub0a6Ih4JIIHk02/s7kjLCoG
X-Received: by 2002:a17:90b:2645:b0:398:9be9:ab92 with SMTP id
 98e67ed59e1d1-39e1e5777famr2761277a91.23.1789532191760; 
 Tue, 15 Sep 2026 21:16:31 -0700 (PDT)
Received: from [127.0.0.2] ([2001:448a:40a4:1818:e1b0:e8af:138:39e6])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e1bb234c3sm2051689a91.6.2026.09.15.21.16.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 21:16:30 -0700 (PDT)
From: Reza Kurniawan <imkyufie@gmail.com>
Subject: [PATCH v3 0/3] Add preliminary support for MSM8917
Date: Wed, 16 Sep 2026 04:16:01 +0000
Message-Id: <20260916-msm8917-support-v3-0-35103cb4e01e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/y2NQW7DIBBFr2KxLhFgE4xVRb1HlcUAg0NVbIexo
 0pR7l7iZPmk/9+7M8KSkNjQ3FnBW6I0TxXaj4b5C0wj8hQqMyXUUVipeabcW2k4bcsyl5WjPkY
 RlOx76Vh9LQVj+tuN3+cX0+Z+0K9PzXtR8LrV1PqasYxEsKeG5nMvmVoaA3kef2EkflNccGWM6
 DojQHX+K0Iqy2We8ODnfHpqHRDyCjmtQxOU8dYqj85Z7YIVbRA2tkEG0Fq0CgzITgdg58fjH06
 V5DMEAQAA
X-Change-ID: 20260915-msm8917-support-e56f0d21881b
To: u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
Cc: Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Lukasz Majewski <lukma@denx.de>, Alexey Minnekhanov <alexeymin@minlexx.ru>, 
 Luca Weiss <luca.weiss@fairphone.com>, Reza Kurniawan <imkyufie@gmail.com>
X-Mailer: b4 0.15.2
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

This patch series adds preliminary support for booting Qualcomm MSM8917.

Specifically, it includes carving out reserved memory regions (no-map) at
early init to avoid security violations, A Global Clock Controller (GCC)
driver providing essential clocks, resets, and GDSCs needed for U-Boot and
a pinctrl driver to configure pin parameters and manage GPIOs.

This patch series depends on the GDSC flags series by Luca Weiss and
Alexey Minnekhanov [1], specifically patch 4/4 ("clk/qcom: Treat different
GDSCs differently") [2]. On MSM8917, MDSS_GDSC does not have POLL_CFG_GDSCR
and requires polling the GDSCR register directly instead of CFG_GDSCR,
which is addressed by [2].

Changes in v3:
- Drop "clk: qcom: Add an option to poll for GDSCR GDSC_POWER_ON bit"
  in favor of Alexey Minnekhanov's series [1] / [2].
- Update MDSS_GDSC in clock-msm8917 to comply with the new 'flags'
  member in struct qcom_power_map introduced by [2].

Changes in v2:
- Change license to GPL-2.0-only
- Mention the source of the ported code
- Add error check for out-of-range pin selector
- Use macros for RCGR address constants

v2: https://lore.kernel.org/u-boot/20260912072619.244101-2-imkyufie@gmail.com
v1: https://lore.kernel.org/u-boot/20260910095339.110427-1-imkyufie@gmail.com

1: https://lore.kernel.org/u-boot/20260715-gdsc-flags-v2-0-27704470a24c@fairphone.com
2: https://lore.kernel.org/u-boot/20260715-gdsc-flags-v2-4-27704470a24c@fairphone.com

---
Reza Kurniawan (3):
      mach-snapdragon: Carve out reserved memory at init for MSM8917
      clk: qcom: Add Global Clock Controller (GCC) driver for MSM8917
      pinctrl: qcom: Add pinctrl driver for MSM8917

 arch/arm/mach-snapdragon/mem_map.c     |   3 +-
 configs/qcom_defconfig                 |   1 +
 drivers/clk/qcom/Kconfig               |   8 +
 drivers/clk/qcom/Makefile              |   1 +
 drivers/clk/qcom/clock-msm8917.c       | 210 +++++++++++
 drivers/pinctrl/qcom/Kconfig           |   8 +
 drivers/pinctrl/qcom/Makefile          |   1 +
 drivers/pinctrl/qcom/pinctrl-msm8917.c | 645 +++++++++++++++++++++++++++++++++
 8 files changed, 876 insertions(+), 1 deletion(-)
---
base-commit: d27c992cebb95bd903d09f3d1da55032a7a145da
change-id: 20260915-msm8917-support-e56f0d21881b
prerequisite-message-id: <20260715-gdsc-flags-v2-0-27704470a24c@fairphone.com>
prerequisite-patch-id: a1b270485786a326cb40fda882935fcc0fbf3bba
prerequisite-patch-id: 1d4a1450016d914394cf6a7e24ec9e5bc12fe80a
prerequisite-patch-id: 568826d73bd992c6ff16681ad33e6891e25af5f5
prerequisite-patch-id: bad5df259c02085a5aa51d130459ae1eecd0f638

Best regards,
--  
Reza Kurniawan <imkyufie@gmail.com>

