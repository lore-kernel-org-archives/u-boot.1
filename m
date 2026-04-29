Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15DD3FF8867
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 08:48:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9845D84705;
	Wed, 29 Apr 2026 10:48:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="I/UVbaaQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E181784705; Wed, 29 Apr 2026 10:48:16 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B21DA8470B
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 10:48:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-43cfd1f9fd1so7646119f8f.3
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 01:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777452493; x=1778057293; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=g14GHr81cVl1vhIKqrojuU0bEN/znWCuDQBpM6OwZ6k=;
 b=I/UVbaaQzRLX84n6P2A/m+aFLbIdMOLbSSVzdL2obO5e777DH8iY6uBSQXd5LXMRRZ
 s69OT2TJGC4iGoyOkNBzUs3vsq6TyRa2QfBbB9l2CIQltF73PwseFIpWy1hx9cOXLSl6
 vRHPwfRz/vPARJ7TkYExwwFjpMCB6Up+SSdXBGJyFDCfOT4C6DGNS6a6qqiTbejgbzXN
 9Mygb2RkYD37CHyMyHkWVFtkioVqwui7Gu9Wb9UOX9TVc4eru8PujnCc5wzI/SO4WmIx
 hqMp6K/ElQzP8AEMV0Po+dptiNxn9hYskm8QfQrLc5mjTroiYJsQOP9UIiG7SlKdx9Za
 ruKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777452493; x=1778057293;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=g14GHr81cVl1vhIKqrojuU0bEN/znWCuDQBpM6OwZ6k=;
 b=X2EWXd7qGfIuPYJIPVXBiOnSFlkZIJS1Fm8NgKHhGFLO//N8+995yjmfeWuDUMIZO4
 LLgqZukIRdSvdWF1Cms3fSJRUhABrEw2mNFaX3EA71we/AF1PEke6vTxDxRoMGU6o6iH
 nYy1MXv0k7kaWIfEAVtWxLLp4XmLBDpPz2IKf3DEn1spquatTJxcjXRk9vm6H3YsT2Xz
 jykGXCiKReQ9NIcpAgp8jaBTK+zIy+FuYt6Su51DkeRJZmj4WLZWzXA3g+/bqEHXvI5R
 i2iS7KUBE+VlHr/Ox7ZCxpl6R1OoNDoOfEs+PZJ3IixjDMB9S2ftOMo28SGGWdfKEnI0
 RCgA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8617967rd4H6XF5eC8Skiy5gcPTBT728P1x4B48e0scj/3t3GDsm7+49gksoehZ7fCI15M0Lg=@lists.denx.de
X-Gm-Message-State: AOJu0YzEYplKfg2eD1cLlcO6dAiHFil9wTMsU8Lxi/5GPtQ/XD1kyI3q
 zxzsOq4qR9bZpISJcHSrrPaHkCTx64+YS57gV9Hst6oLg2fc+6quqLtlGw1mYBltYIXTZ43S+le
 NFeqi
X-Gm-Gg: AeBDietFPkHMe4uzQ7s/88PI6EKy39KJXvehuU0uX7Etb9SlkT2SsACf9m498ruRdmJ
 YIqttDFGAyoMdzkhl8DkEnQQ5xuGMpgXOxWEnVElWXhWNgyYVy23FrfQkT7MxhtWABiG6vDbT/Z
 TP6Y+/VKYPpcbr5ELslHcbKn/bV6AAZEIpir2Nw+SlQaHPC4mLJYbYUzSxfRnCePGIwKlYpkCxZ
 2/KQhaHT46UL2RXIhOCnRbhFb/qN8MRRJ/XpNy6G2/OyGMA9W+LVS9GsHNDutj3tIo4AYsfn2Ey
 Sc29E6kCyxp05WWwdHJTK4MY+kkyfhDvnNpKoB+6D6cTcsJa0bQ4CnvCrX6f1uZLGh5L5xM0VFR
 K9l7HWlI5+Q2yuNSrJj08EnDDd8XZ/XqW+DAymiSOYytNPjZ0hqP+lX+NpufYobZd316Fst0MQX
 ARmkb3ZYIp+Dwmv4QoSjmm3aVRe7EQFu1PFKPhHwEbYN5wnrOsqJ2CjDw3GWeHx17r370afKpMk
 Ib3SuU=
X-Received: by 2002:a5d:5d11:0:b0:439:ca9b:1f61 with SMTP id
 ffacd0b85a97d-446493f4ad3mr11724348f8f.17.1777452492601; 
 Wed, 29 Apr 2026 01:48:12 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd86.dip0.t-ipconnect.de.
 [79.195.221.134]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-447b7ca664csm4614622f8f.35.2026.04.29.01.48.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 01:48:12 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: neil.armstrong@linaro.org, sumit.garg@kernel.org, trini@konsulko.com, 
 luca.weiss@fairphone.com, u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>
In-Reply-To: <20251112165459.1560966-1-aswin.murugan@oss.qualcomm.com>
References: <20251112165459.1560966-1-aswin.murugan@oss.qualcomm.com>
Subject: Re: [PATCH v1] pinctrl: qcom: Add pingroup definitions for SC7280
Message-Id: <177745248386.126665.14249750331075734634.b4-ty@b4>
Date: Wed, 29 Apr 2026 10:48:03 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=546;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=qX2SVomy4b/LGVAPq8ZON4FupBwIk5JFIAbR/St6jSU=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhsyPR08HBcnNW6SbtPTir/lGq46WnXSQ6n/CV1QfaNUxL
 3FG2uIzHaUsDIIcDLJiiiziJ5ZZNq29bK+xfcEFmDmsTCBDGLg4BWAiufcZ/odb6NpnGlYzv9uk
 mXNgrwijzfUvflP3xa7vPX7n1CSdZbsZ/tlX2nzxi5HKmaWcLns99lCUTgmzQeSW6dMvL2LdelL
 4zhUA
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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


On Wed, 12 Nov 2025 22:24:59 +0530, Aswin Murugan wrote:
> pinctrl: qcom: Add pingroup definitions for SC7280

Applied, thanks!

First and last time I use b4 review, the commit shas are wrong but you can find the patches in https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commits/casey/qcom-main-13Apr2026?ref_type=heads

Apologies


[1/1] pinctrl: qcom: Add pingroup definitions for SC7280
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/3459a1e2179a

Best regards,
-- 
// Casey (she/they)


