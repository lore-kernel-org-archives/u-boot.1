Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13687CD4851
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 14:44:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AB37836AC;
	Tue, 12 May 2026 16:44:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="b9sNrKRs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E371883C2B; Tue, 12 May 2026 16:44:50 +0200 (CEST)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C478A803C6
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 16:44:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=nathbappai@gmail.com
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-83ef1d17904so605491b3a.1
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 07:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778597087; x=1779201887; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+w8Jclbqqc9EaM0AaqnYImDsufhP0b4qd6BKYIyciTo=;
 b=b9sNrKRsrsINNdoxRUwRXT5BExaCy9z1sfLl6Q3kxnNVF4z70Y6BpEJQFYv/dEj+BU
 OuQlDJkH9iqPUzSmbAq/+V/CmKvvFSiyEfrZGoDL5fFSpfnfGi2VoRivioH3KlIDyfU3
 pPmoH0WY8YY+GezD/M0if2JA+lc1Z2KeHL6N7cX6+umeca9Atkvq6GbS516sCWFWX50G
 eumRd882JLwqzHdW9/e/MImXLjMa5HU5gMY0A/NF9OPZ+QuDjKDzEE4SiGB0WXi4kl6o
 u75mDemvcXUyxYYqJNh90miRdQPq/UerYMopQ785p9QrdVBgfFLL9ldnqmAoHFBF1W1l
 Klkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778597087; x=1779201887;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+w8Jclbqqc9EaM0AaqnYImDsufhP0b4qd6BKYIyciTo=;
 b=dnKfuLMcOZYLnYS7phmOlIq11u6W99kyl5UZE4GxxEmys8exk5HF4tkCpB41oifGHN
 pL51+HMBI8UxuqAAnm+BQJUSEo1bo/VfZp692giBB5lDTGCwt3RBoMFiAvUEM7YxxPdF
 uoHUNNFfEz1GTyLDX3rU30oF8Cyt3Lyqmq8xj+HvwDAadIknbE/VSxTjs25D02V32qao
 ewT+WPhFmi3wwEdAy6pCZHsGwuJ+3BE/dLRNunGQcC5AKYidbae5qXcNNN22AMOWyvYk
 1kEpEmhc1C05adbrOoMw6UipiI9MKr8U2oAqt8qkCsvQ5anpvBjLHYPgDylgFVkS4qO0
 2U1A==
X-Forwarded-Encrypted: i=1;
 AFNElJ+enD+2U3cAKmseErFjyU6l9uQreVtRZYB7ggL+fC7uMCfp6sk8tAsH8pvJCRiQTBdzczARF9M=@lists.denx.de
X-Gm-Message-State: AOJu0YxSX4Q8YrrvVsGA2TDRLzeOgaROEYn/XQrjC+fVp5bJn9HSFg42
 XF/Czrw+Vc6NQenuMn1/HjWcUkfpI6/tQQdx4qd8REsfStFTl3AqqSo4
X-Gm-Gg: Acq92OG1jzqw+KoyYAo61pcuDGUAaMcnBnULf9aYdVkABDYpQ/RkBQVWGAEh5z6bDdR
 A3isBPZYNjQgG8rwYJE+uZLAIo6a/bFAOMBAEK03kW7OsF8/Q/9tMtRoGNva08ti9nkidNUWJOq
 VVeUg19CYMOIfMreFkVrzYZbH/IaAnITnIkHAtYE5UgPup4uxPr8FHTmzHoErre2lxmUeWH+1Yq
 Une9LAhrvY+DYWGayI1wiT3txG/grpREUR0HuERwGrJR7RsA+vFb/Ecc17ptPhSLfpS64lO3kBq
 Wk2hJZaPn4pU4ZeCiaMGt4nA61ZlyAZEi3ZNSK8yQC667pd9+HNpSBhiRnYofuBWUXJmWTLCS8f
 bSEPqHp36g2Zeyw2bBKjUuJGe/+4uv45KqQiyroJZ+/dco2wcGEVaep2hPw917+9f6ce//z4Fxt
 RyTfekXFf0orQbz4MNwGmUMSyqx1wy
X-Received: by 2002:a05:6a00:2a08:b0:83e:b47f:8994 with SMTP id
 d2e1a72fcca58-83eb47f9233mr12740258b3a.6.1778597087309; 
 Tue, 12 May 2026 07:44:47 -0700 (PDT)
Received: from [192.168.0.102] ([43.251.89.154])
 by smtp.googlemail.com with ESMTPSA id
 d2e1a72fcca58-8396594645csm24703145b3a.14.2026.05.12.07.44.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 07:44:47 -0700 (PDT)
From: Biswapriyo Nath <nathbappai@gmail.com>
Subject: [PATCH 0/3] Add SM6125 UFS support, Fix QCM2290 clock, Add
 poweroff command
Date: Tue, 12 May 2026 14:44:38 +0000
Message-Id: <20260512-ufs-sm61x5-v1-0-c022cf988e89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQqAIBBA4avErBNU0KKrRIussSboB6cikO6e1
 fJbvBeBMRAyVFmEgCcxrUuCyjPoxnYZUFCfDFpqK43S4vAseLbqMgJb612hnCkNQgq2gJ6ub1Y
 3v/lwE3b7e4D7fgAD3ClVbgAAAA==
X-Change-ID: 20260512-ufs-sm61x5-ea6fb71b585e
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de, Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Danila Tikhonov <danila@jiaxyga.com>, Lukasz Majewski <lukma@denx.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 ~postmarketos/upstreaming@lists.sr.ht, 
 Biswapriyo Nath <nathbappai@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778597082; l=798;
 i=nathbappai@gmail.com; s=20260118; h=from:subject:message-id;
 bh=OxhedujGhtZ1g2pOsvT/Jr2p445r1H0zLNXONoeN6Ik=;
 b=NFeOxmtIJa/bSzj/zpXObwOkAEzfferS79e1ajSsJwox4N1llPl9c+6Vh3aXeqgFczVNd8ly2
 90xZ6abnQIYDr5FcZzwr90hQDM4zLkPJNwS0DLN4Xv/+HOYIywTrS08
X-Developer-Key: i=nathbappai@gmail.com; a=ed25519;
 pk=slmb/9yXbet+KTiT3EYLCp0p0MEOYa3EdjUXP+HXfjg=
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

Changes:
- Add poweroff command in qcom-phone config
- Fix vote_bit of gpll6 clock in qcm2290
- Add SM6115 and SM6125 to QMP UFS PHY driver

Signed-off-by: Biswapriyo Nath <nathbappai@gmail.com>
---
Biswapriyo Nath (3):
      phy: qcom: Add SM6115 and SM6125 to QMP UFS PHY driver
      clk/qcom: qcm2290: Fix vote_bit of gpll6 clock
      board/qualcomm: qcom-phone: Add poweroff command

 board/qualcomm/qcom-phone.config    | 1 +
 board/qualcomm/qcom-phone.env       | 1 +
 drivers/clk/qcom/clock-qcm2290.c    | 2 +-
 drivers/phy/qcom/phy-qcom-qmp-ufs.c | 2 ++
 4 files changed, 5 insertions(+), 1 deletion(-)
---
base-commit: 5732bd0f457b4c671e46574d64d4acb099c0f0a5
change-id: 20260512-ufs-sm61x5-ea6fb71b585e

Best regards,
--  
Biswapriyo Nath <nathbappai@gmail.com>

