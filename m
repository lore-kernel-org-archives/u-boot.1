Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1A57C61DC2
	for <u-boot@archiver.kernel.org>; Thu, 27 Aug 2026 14:24:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5ECE180E14;
	Thu, 27 Aug 2026 14:24:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id e9aTr9BgFLNN; Thu, 27 Aug 2026 14:24:23 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787840663;
	bh=qfjRT9qOGRHM/VtgPdgi5K9XeaAl7gVAlbtK94AVBkE=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Sk6j8SiTqwDdwZerXZ6DEpr0TZV1yhf4qAHpezDzq0HYkgRVA+cGm41F0ew4zFdAf
	 1yGpfc12utRacmMVtf2KSlFW4XHngAbjpxBD9T6RLpdoC2Fr3yRWFEcKTULkl6Mm9P
	 yiHcVjQEX26/jcAyFi1WR2dBfz2G2ql9d2y4mkDx5lMMu1jvsB5Z/r5Sot+BsB6+Qz
	 GncVrKhwHBZL+3+oO/mlPkcc34/nYBAQGdsMG5BML2zdwdv3VJYtQu/1x3zYSkm3LG
	 WoMvWWyXl0ZiMHKbcSAd7K1pjVN08q/ZCdljO5I6rX8iO/VRTEeSYyKtqB66n+HYgq
	 gkRZ4rk4nbavw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 16CEF80E1B;
	Thu, 27 Aug 2026 14:24:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7FF053A4
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 14:24:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 71B5B607A2
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 14:24:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m_02LR1_NK3a for <u-boot@lists.u-boot-project.org>;
 Thu, 27 Aug 2026 14:24:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32c; helo=mail-wm1-x32c.google.com;
 envelope-from=msp@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=LhQp/3ZG
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 129DC60781
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 14:24:19 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-490cf322ed0so20387165e9.1
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 07:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1787840657; x=1788445457;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=qfjRT9qOGRHM/VtgPdgi5K9XeaAl7gVAlbtK94AVBkE=;
 b=LhQp/3ZG4EK4lV3El5xjrcz/gSccHAV/i42cE9c+bwCOtT0hRulgYGShIKjfcxMQnQ
 xUha+kBn9BDXno5RuNaLFEdv2vsiAa2YU7vONQ8GkYFjP9zXrsqijL5A4M9e0S7dncvE
 XISrEJs8CReVSGFBTFE3M4Z62RGhH3DDhDSt1kQaEc+wWkmxLF3CllmNomIu0Nip5Lam
 DmPRhCJ5lxPxP6MTxhkqHL2fwY7Msc39gA/GqHp5E1zpa0qEvhvIUXtzWSoEnYvvpLG+
 LQZ8fL0L7nREiwJewVAt21Tsjyzq2lZ6OihxPUa23niXq4RxNvxTvcQgbZviidbo6Khi
 V/aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787840657; x=1788445457;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=qfjRT9qOGRHM/VtgPdgi5K9XeaAl7gVAlbtK94AVBkE=;
 b=Nk/kKtm0yI4fZ2pI9xEir/YreLnWhkm17pbVhFKtR3aXhDBv/lPsGbObvxfi6toqns
 /rmFQ2rTmTB0+R2EIQkj4+eI/kwYr7bw12C+ZdbywcQO+x+lDW75YhePFHLJuyUZpkFz
 TDOJUz6/SpHTk5xEp2OpaVmO3d7NAiBZYk6hfDR3YD9gGrR/c0z2HsfXV4XKbzDD8JTE
 74WvYUOoeMD8iNS3qH3zpu2hAlx4ETYo+1vocPjVa16J73nFcHWxbfVLO6lpIxzs/keG
 tUA3ZgMbmT6ySYW1hX1ZH74/IFI2I5rZJ+k2ItD90meBVUzJwJCEe+JFl4B5USUNrX8D
 k8Ow==
X-Gm-Message-State: AFuF++kWrROW8B0eF0Wte6KkM6mIyAvgynklJDjZoHt+BQI7plIHygas
 joIFlFGgtIw3ulpVeBwHyIyb3ZT8BN8S+UhQ5o6YO2BtIZpMga5z6AuYk0JRv28QhSQ=
X-Gm-Gg: AR+sD12XYGj7A/AeVElFbsCnTuwsms0/DdAURFLReHEVQQ7tF2Uhu2acaArIrixFCvk
 zKzCRqC/F7KQITIaaFYFnjbodN1pWM+JfWSsdYafKv0z+r+9dahWlIsecxP7sUG8yYOvVN5hznR
 DJXXKUKDO+PcMrEhFRzpmg7Bkf61Bu9Z2dzrHc/fkqpgAJt+hF8SWfA57ay5I3S2LE0e8dccdqf
 UAgkGAfXmZFR5XcMQdTsLnul16Mk6sjKNxNbbdPucMH0YzPUfN7NY1mYOwmZQ8Vmd+iMPOyUVkf
 HO7WO2cqU0sAKHz624tsMiicsj33GZ+L9z+ievUcNEkT5BUccfLpxTl2hkNr3gKI5ikdn0U2ORA
 GQFfVuLw4C8rRhTOadClg+2GKLh7BVLxrKyVcljBZ88HRpiWoyJ3iT20K6rsUorw7jgsu3acpfl
 bMh8Xwwr7LgPoxBhX5sI/G+rHyJW/mETqF9bCS9ia3j6TSOpQELUQ7Snxu0Q==
X-Received: by 2002:a05:600c:8a17:20b0:49a:a101:4157 with SMTP id
 5b1f17b1804b1-49aa1014439mr116090095e9.7.1787840657587; 
 Thu, 27 Aug 2026 07:24:17 -0700 (PDT)
Received: from localhost ([2001:4090:a244:80d4:4373:6c2f:4372:b8ac])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499dd56826bsm71394535e9.4.2026.08.27.07.24.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 07:24:17 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Subject: [PATCH 0/3] bus: ti-sysc: Prepare for use with am43 and
 OF_UPSTREAM
Date: Thu, 27 Aug 2026 16:23:26 +0200
Message-Id: <20260827-v2026-10-next-topic-am45-ofupstream-ti-sysc-v1-0-e2c43cecc71e@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAF9IkGoC/yXNQQ7CIBCF4as0s3YSSlQar2JcUBh0TAqEoU1N0
 7tLdfe+zfs3ECpMArdug0ILC6fY0J86cC8bn4Tsm0ErfVWDNrgcC3uFkdaKNWV2aKfzBVOYs9R
 CdsLKKB9xaDx50kNwzhpoj7lQ4PVXuz/+lnl8k6tHAvb9C/RTt9mPAAAA
X-Change-ID: 20260827-v2026-10-next-topic-am45-ofupstream-ti-sysc-7dede28fcca7
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=726; i=msp@baylibre.com;
 h=from:subject:message-id; bh=glXw2u5r6XlmUBx14BBWw1BaPLUGrfqFeCPON4FxppE=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhqwJHsUrr31Qe7xI4/uRwpunLCe97/PnN2KVCsze8O/aF
 IeDV/Knd5SyMIhxMciKKbJ0Joam/ZffeSx50bLNMHNYmUCGMHBxCsBE/HwZ/rvMllj5TXO37297
 TxkN7dIH+tdX3MlaUXHpKbedyvym3AeMDI2dswoK/OVWTOaM9pQ9E8z0hUU3dlGWT23pkqAd3t7
 NbAA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
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

Hi,

this series prepares ti-sysc to support am43 upstream devicetrees. In
particular CLK dependency has to be removed for SPL.

Best,
Markus

Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
---
Markus Schneider-Pargmann (TI) (3):
      bus: ti-sysc: Tolerate disabled CLK
      bus: ti-sysc: Simplify with clk_get_by_name_optional
      bus: ti-sysc: Add omap2/4-timer compatibles

 drivers/bus/ti-sysc.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)
---
base-commit: d3e8597e46b635ec556a057bc42f0b0859654bdf
change-id: 20260827-v2026-10-next-topic-am45-ofupstream-ti-sysc-7dede28fcca7

Best regards,
--  
Markus Schneider-Pargmann (TI) <msp@baylibre.com>

