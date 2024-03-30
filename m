Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6851C47DD9
	for <u-boot@archiver.kernel.org>; Sat, 30 Mar 2024 05:05:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13531881AE;
	Sat, 30 Mar 2024 06:05:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OAkiW/ke";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 348B488274; Sat, 30 Mar 2024 06:05:25 +0100 (CET)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33F8287D37
 for <u-boot@lists.denx.de>; Sat, 30 Mar 2024 06:05:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macroalpha82@gmail.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-221e76cad07so2138160fac.0
 for <u-boot@lists.denx.de>; Fri, 29 Mar 2024 22:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711775121; x=1712379921; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mZ28FHT9WWOKzulKBumvt1ZGTgzAGkKIG5SPtvMX/oI=;
 b=OAkiW/kerPqwvUSjQkhg/p+z93XbuJOzA+qrk82cg8FT/GdUfuLiW5zvu8IqUTZdeo
 bp6QXxRRFhMX+2lKOOva08ejpDlVnfdLOzPrcOH0N3mEDK816PKQKKRPeM3ydpo2oala
 shqjisxAS3ekmv0X3EXWarLDqXuSNw5eQKaW4/0GhjjSI5R8EDfvBXVaOS0OuuTBOqLw
 GhRLYFklYNf2PT8w7A1yxvQdMqOvxpvkYEUVh6tkaLXrTg0T+nA3gn0abi/8I96eqpTg
 gR//6iaJsD8h16PP0/bdQlTThvBhBoxmiO9zzfsIvrpU/F584TRJyxGiz8SlDxmLsE1+
 Dwvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711775121; x=1712379921;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mZ28FHT9WWOKzulKBumvt1ZGTgzAGkKIG5SPtvMX/oI=;
 b=IhowpFLVL4ONkD+fqOfI5ujGn5SB2LxkNFbBXDLFAUlW0tmA2UgusOzcrv7X4+cgkW
 uicUM5DQRmnLMKiHZ8kbBesbfY+68eMsVpfMa6ViFwf4u8sPqqrYlubMPFb/x5UREul3
 ejMAyhs/7aa46kVvxekYpn+QxAypMuTZeyiBLTr2A5jqctx95QP5L+lTUyskppd9y7eu
 XZ40dLlVY0ud7gYax953VMaNBgCciZ4N7qmek4SS6kMapj9hA/7QJrJoNB0KrqQDnLJ/
 1NjEDm5bZSEPnOlx9bX43PiYPYvp3JF1YwYlg3L5+5VDOskJ306gHtXebywaAqHiUOrY
 hFJQ==
X-Gm-Message-State: AOJu0YxvKlU0VKacnwXSj4L/mKyQ7GQIyaBLFYymXSvxTvGxZ2YATD+N
 I2WUqWli3sVUYUtmVEIOBLwPlwS9xnhoZRSIzsVWdiyDMRAc/W45scPm+UqP
X-Google-Smtp-Source: AGHT+IFUCpZWIv44UuSgbHKEKq/h/xpEq2cHqB76qwV93ZQvj91Vwa8G7QBvWc1vGiK2din4jCZNvw==
X-Received: by 2002:a05:6871:a0c1:b0:22a:6a92:a83c with SMTP id
 vr1-20020a056871a0c100b0022a6a92a83cmr2903124oab.25.1711775121399; 
 Fri, 29 Mar 2024 22:05:21 -0700 (PDT)
Received: from localhost.localdomain ([75.28.21.198])
 by smtp.gmail.com with ESMTPSA id
 on7-20020a0568715a0700b0022a73f32f11sm1427634oac.32.2024.03.29.22.05.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Mar 2024 22:05:21 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: u-boot@lists.denx.de
Cc: eugen.hristev@collabora.com, kever.yang@rock-chips.com, xypron.glpk@gmx.de,
 cym@rock-chips.com, philipp.tomsich@vrull.eu, sjg@chromium.org,
 jonas@kwiboo.se, trini@konsulko.com, Chris Morgan <macromorgan@hotmail.com>
Subject: [RFC 0/2] Update RAM Bank Logic for RK3588
Date: Sat, 30 Mar 2024 00:05:13 -0500
Message-Id: <20240330050515.470025-1-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Chris Morgan <macromorgan@hotmail.com>

Use the ATAG info provided by the Rockchip binary TPL to identify
RAM banks on the RK3588 when using the ROCKCHIP_TPL binary.

This is needed because there are specific addresses that should not
be written to for all RK3588 based devices with >=16GB of RAM, writing
to these addresses immediately results in a crash.

I intended this to be an RFC the first time I submitted it, so I'm
correcting that mistake now. Additionally I have reduced a lot of
the ATAGS code to only focus on the few bits we need in this case.

Chris Morgan (2):
  rockchip: sdram: Allow board/soc specific RAM bank logic
  rockchip: rk3588: Add SoC specific RAM bank logic

 arch/arm/mach-rockchip/rk3588/rk3588.c | 93 ++++++++++++++++++++++++++
 arch/arm/mach-rockchip/sdram.c         |  7 ++
 2 files changed, 100 insertions(+)

-- 
2.34.1

