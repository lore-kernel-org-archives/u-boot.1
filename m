Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CB32C531CF
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 13:23:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C835D60A3A;
	Thu, 23 Jul 2026 13:23:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BuIKOtXUf2va; Thu, 23 Jul 2026 13:23:04 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9384660A4D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784812984;
	bh=2TrAZghoqCFpCfMye3N1LHoOxi4DLaIDgp3ERy8a02E=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=0uixbqjgqsSVeSsgnmUIQK4/ObLbJxWSrg8yqtH77AAz6vTpkGi3U57WwYuaEf/9Y
	 2K3IavFGJ/N1UJvPWVT2pOBD3mfIzuYPCVDKF+196AVRX9pKk0Jf+chmCPoNgRV/RB
	 vmXuCk3E6nLir5bgKq+duBS6+5JB5f4rZCY97dGeWlW7zbQ2Ku6scocT1iGWwq2Ssd
	 FvvTN3A1VKHt/E9HoPEQdg89u1ck155F7Nc2M0W04IDCLn9raZ7QQlnU48qfzQ+vFl
	 QW0Otu1PrNBlFlUAxGLY/XUoJE+3kNlFk+q7ml0ujvIEOMwEVzXYTC9uPsIDFbFKpF
	 FLjeHz08Xz6TQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9384660A4D;
	Thu, 23 Jul 2026 13:23:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id EA42036E
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 10:31:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CFEBE608C8
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 10:31:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GGc7S1HRQjGq for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 10:31:08 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=william.bright@imd-tec.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 58FCE60816
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 58FCE60816
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 58FCE60816
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 10:31:08 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5228803F6; Thu, 23 Jul 2026 12:31:06 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7035683E76
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 12:31:04 +0200 (CEST)
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-47de008b020so283396f8f.1
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 03:31:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784802664; x=1785407464;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=2TrAZghoqCFpCfMye3N1LHoOxi4DLaIDgp3ERy8a02E=;
 b=U/6P+GNsprGHUFYF7RNWHOXTKyrj1UK1OXBL0r/GFkfgPK/y8faZIwidEtavPVtZCY
 AfnYw4RFTKTK00mYwVNsZQ05DdOkmho5Zj6nb+hayhtreSsfIahqqwgzfGAnQmCzwIp3
 MMsGtyZRp/71di0TukDtqb8PZBaJu7EmVuM3v7MVInbdaPGc5DJmS8cKQVHwd2gtkiRv
 99lLW+JYMWzjyzircvA3etwbofuPYgAeTs77fh5VRDgFKgnbMpyt4U/WSPTA9rC0nKwy
 e0ko6//xAAAfINZhQ5+TQmxqONmL4Qq4FwKwNGhEUHNbigAMzWKi+xNgtGjZ0G5jj0nr
 tzsg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq0NkSlpTr1NIMOW+Sd6Py/iyE/ykHYJQXX1b/gcpw04efdgRRY9MyAhmkkZqOZGxoue8AYdZ4=@lists.denx.de
X-Gm-Message-State: AOJu0YwNiZw+LgTfocUAQFVglEPHYKk0mjXozkQrVP3CvsgfPqawaWti
 E/6pR39W0XmR5jSxtwwPvVrSn0KEVU7tcgohNdkudJAO9wwWgGZsWBi1QabDRs4A3rs=
X-Gm-Gg: AR+sD13IK7BHbLy/PbBw6fqmjnO/jr4TvI7nO14fxk8JOZb7hmaNIKhr7Ir31hAvq1c
 RAf1Yly/VjwLvL4pNdDLGaAPiisnGrMdBC/yH+r2MnfyjrzYkT2yRah7rWwn3WUty+DcRruDITg
 0aLzTMRWXUbsdoK2060r86xhxKvJb5E05vMUDmcvNdAvWypwZwWAac1TSqOyV6zUil2Ulpy7hAi
 G51PgaY+Zg9icl+uPGwbQPd37dNiDuVRWwpItBJ27LIt1IpeYtRUA9+Nv1F/NqFIWXDsZiqsdBO
 ZNv2h6j+2r3Qv/fllOvbmhf6+yhapj/dXG5wldUBYbpWMB04yaO9O8CtXsYHYPSTrdowzdEEAul
 togO5iGvxHOFadNunTSfhZXOHIaGaSpuK/QgyaIv+YjyqYkZlKR9DEwCaVPsVyJ9pdPYPF0txT1
 AOhxwtZeUdsLNm4mFkrXfrr8y/DfU2PFrzu91ISBREGGN3T6XCk2oqKbdTm7o+cTroBFxVAx/HW
 GjYUmIG/dO0WzExpCmxzWnoANE63RwZqbp7/ib/eBveyxM/DwrbPQ==
X-Received: by 2002:a05:6000:2606:b0:47f:9158:5924 with SMTP id
 ffacd0b85a97d-47f91586a18mr2071368f8f.9.1784802662988; 
 Thu, 23 Jul 2026 03:31:02 -0700 (PDT)
Received: from [127.0.1.1] (host86-157-235-39.range86-157.btcentralplus.com.
 [86.157.235.39]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85bdac28sm13439289f8f.16.2026.07.23.03.31.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 03:31:02 -0700 (PDT)
From: William Bright <william.bright@imd-tec.com>
Subject: [PATCH v2 0/2] Add support for SM8550/QCS8550 SoC based platform
Date: Thu, 23 Jul 2026 11:30:50 +0100
Message-Id: <20260723-sm8550-hdk-v2-0-78f0ce2adb3c@imd-tec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFrtYWoC/22NQQ6CMBBFr0Jm7ZihBYquvIdhAe0gowFMi0RDu
 LsFty5f8v77CwT2wgHOyQKeZwkyDhHUIQHb1cONUVxkUKQKMoow9GWeE3bugSfWRqdN7YpMQxw
 8Pbfy3mPX6sfh1dzZTlthMzoJ0+g/+9ucbt7f8JwiYZm1ZMwpXpC+SO9wYnu0Yw/Vuq5fu5J9r
 LgAAAA=
X-Change-ID: 20260720-sm8550-hdk-9e3731bad643
To: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 William Bright <william.bright@imd-tec.com>
X-Mailer: b4 0.15.2
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Thu, 23 Jul 2026 13:22:52 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=imd-tec.com; s=google; t=1784802664; x=1785407464; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=2TrAZghoqCFpCfMye3N1LHoOxi4DLaIDgp3ERy8a02E=;
 b=LeJ9N4Il36wZiew/1jYJByHiWhLTEzYGl+3GMkDkD6EpZVzYBCbl4KCudodc+Pr8uN
 YqO8CDyJQvf+9u2xZg67R0ZvVfoGZKdx2MX1y1KlO1jf/7xH8cjkiQAGQSdTw1eVsylZ
 SlxXsIs+yx0fuDR7uC//8esJ6EFf/zE2FvCAUKEnTzgVMH2HwAn1HqJl6JNriIwopl99
 J3z0R1aBf96qyc7GDPXIqRmxvjayQvD35SSNv45kYd0x9o63LCxx+9XeXl9euVpopCfV
 Sibn3LSFXFrZVtRCfmXgZnos37q4F/290Xkp97oo06lKf9ZkN+aoT0upAS4R7YzoKwYB
 rwqQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=imd-tec.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=imd-tec.com header.i=@imd-tec.com header.a=rsa-sha256
 header.s=google header.b=LeJ9N4Il
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=imd-tec.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=william.bright@imd-tec.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=imd-tec.com header.i=@imd-tec.com header.b="LeJ9N4Il"; 
 dkim-atps=neutral
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

These patches add support for the SM8550 (Snapdragon 8 Gen 2) and
QCS8550 (DragonWing Q8). Both of these share SoCs share the same
codename of kalama and the QCS8550 is a variant of the SM8550 with the
modem removed.

Please see [1] for details about the SM8550 and [2] for details
regarding the QCS8550. The upstream kernel patch that added support for
the QCS8550 can be found at [3].

1 - https://www.qualcomm.com/content/dam/qcomm-martech/dm-assets/documents/Snapdragon-8-Gen-2-Product-Brief.pdf
2 - https://docs.qualcomm.com/doc/87-61717-1/87-61717-1_REV_D_Qualcomm_Dragonwing_QCS8550_QCM8550_Processors_Product_Brief.pdf
3 - https://lore.kernel.org/all/20240618072202.2516025-3-quic_tengfan@quicinc.com/

Signed-off-by: William Bright <william.bright@imd-tec.com>
---
Changes in v2:
- Rebased onto u-boot-snapdragon/qcom-next
- Dropped patch 2 since the recent SMEM changes populate the memory node
- Moved patch 1 documentation changes into dragonwing.rst
- Replaced CONFIG_REMAKE_ELF with CONFIG_QCOM_GENERATE_MBN
- Link to v1: https://patch.msgid.link/20260720-sm8550-hdk-v1-0-84f077937303@imd-tec.com

To: Sumit Garg <sumit.garg@kernel.org>
To: u-boot-qcom@groups.io
To: u-boot@lists.denx.de
Cc: Casey Connolly <casey.connolly@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: William Bright <william.bright@imd-tec.com>

---
William Bright (2):
      doc: board: qualcomm: document SM8550/QCS8550 building/flashing
      configs: add sm8550_defconfig

 configs/qcom_sm8550_defconfig     | 20 ++++++++++++++++++++
 doc/board/qualcomm/dragonwing.rst | 13 ++++++++-----
 2 files changed, 28 insertions(+), 5 deletions(-)
---
base-commit: 8a905a58e3b4832c4cd7dc0e8a596a6d7ce19562
change-id: 20260720-sm8550-hdk-9e3731bad643

Best regards,
--  
William Bright <william.bright@imd-tec.com>

