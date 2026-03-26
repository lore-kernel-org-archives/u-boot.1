Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A71B010A88FF
	for <u-boot@archiver.kernel.org>; Thu, 26 Mar 2026 18:31:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 603F883F00;
	Thu, 26 Mar 2026 19:31:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="i2OaidJ0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC21480517; Thu, 26 Mar 2026 19:31:18 +0100 (CET)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92247838BB
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 19:31:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-464ba2bb3aeso730365b6e.1
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 11:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774549875; x=1775154675; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yLdiTw0FDVz79BVaD2VOzKIz0UgcdPJH7bW4vfmxLXk=;
 b=i2OaidJ0TJjx/EHAmGYJrBHmqR1sDNiXR3B8VIa4toAQOJ7YxBJIYEqFJisRcDv2zW
 nhWt0OaKf2cc1ENxsF4e6YCBoqMQ+xGv9HP0IBIkPtOPFxM8RLy9d3E8MbePlVQ+j+4a
 PJCK/2xE1GO/rdLIRap4Z1+y2p3zGO0pRe0O8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774549875; x=1775154675;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yLdiTw0FDVz79BVaD2VOzKIz0UgcdPJH7bW4vfmxLXk=;
 b=j0mXORpIndhdw5BJvV3dSMJ1IHI5A3frkti3038THkrS9pECjtmhwlYAs7qxQxF+0G
 8UuklW4FPGiCQC4XjAerX0HL1S/m4CUZ2y0YrFTMAREGy2kk5KNzmGFpHb9GVhlvw7vD
 Ust0I/nIcAdYpuRCSxG2u1Vq/ebrtht1HuiyA4nBghgIDOSFrMOO5FQswKXE8vOlnd50
 XDmFgBzMHMU5BFpu3wplDcCug/t9iqADVoZ+vUBQsecv/o7bU6PooWZ7atpzTSTDFj5J
 Wh7q3VDDyJbIqyGJmsJZ+1hW+5Gxzl/M3Khhy9ASU+DvBIuYWSZqToVSCQcX+hAvbulS
 wLMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyI6kK46U5Pf23et0y82vBnSeSIBbT1UumTIlo0WxL5MhpKVJ5NuDV4zDLsgs3VKMNEP5w6vU=@lists.denx.de
X-Gm-Message-State: AOJu0YxXJLh+C3tDGHwOpCSCcPk7e+uvrTFv3Nc5toe5rTcr/5lDyPPz
 H8MlChsPc6Mus7PdslqO1AJSL4387kaF6Yt9zsaBrJS1iGtd27KI3f5Am94IhFhru/0=
X-Gm-Gg: ATEYQzyidRm4G3PGJZ2N/GWTzpXDeZUwFfmeCHnAnD5QoYOR7AYsog8FKWaED01X2Ks
 vpPtJlezbzvnUcZVzdvO1Kz9TCYSRko7aNvmUllZ/+49OPsTmihmcB5ZT5kSxkd4BimtNKqC7PY
 NxnZceF7uv45KoLIPdvadfpbYUX7yuJGYgY6H6PTvz1AKlZMlksCC72Q9quCM78C4onzxoS1fm5
 F5ISy+drI4MiBL4hZeD6SiNRRZtmWORRI1nNDcut/qDrmEs/iEIdJgyA5Wu/NfatrElnryP27Lt
 StucjJCtv6pwaoVi/Qxk/0+FGhCePNZONm69wWm3BdE79dTM0aJaKSb7SJRlwnpH6tj7v1yQFyE
 eYBgnjAw/aOc2kPetgnyjytH9Ry5ESfZxAO4pVu84AzSkxJpHJOEU4/IetobIkWfTGHgsAhZNR/
 wyFiHv6pMTN82+RcVOQVVB7FxuRpsDPO4eZbU1ymaMp6OsdWEfeQx/jsrDU3Pf2Hy6v2WV4pYmM
 9jFekTJ5dOV2l3cKZG7utLTtGGTff8W1HE6YxwEO1ivfCQ=
X-Received: by 2002:a05:6808:4f2c:b0:467:ff23:dc98 with SMTP id
 5614622812f47-46a7aa54690mr1002146b6e.33.1774549875253; 
 Thu, 26 Mar 2026 11:31:15 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41cc7ad6c42sm2685784fac.10.2026.03.26.11.31.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 11:31:14 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Joao Marcos Costa <joaomarcos.costa@bootlin.com>, 
 Richard Genoud <richard.genoud@bootlin.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, u-boot@lists.denx.de
In-Reply-To: <20260313104229.1555236-1-richard.genoud@bootlin.com>
References: <20260313104229.1555236-1-richard.genoud@bootlin.com>
Subject: Re: [PATCH 0/7] Introduce SQUASHFS support in SPL
Message-Id: <177454987437.3767000.7729696697242811161.b4-ty@konsulko.com>
Date: Thu, 26 Mar 2026 12:31:14 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.3
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

On Fri, 13 Mar 2026 11:42:22 +0100, Richard Genoud wrote:

> SquashFS has support in U-Boot, but not in SPL.
> 
> This series adds the possibility for the SPL to load files from SquashFS
> partitions.
> This is useful, for instance, when there's a SquashFS rootfs containing
> U-Boot binary.
> 
> [...]

Applied to u-boot/next, thanks!

[1/7] fs/squashfs: fix sqfs_decompressor.c build in SPL
      commit: f0b4f502bdd5f17da58aca9ebf86e16e96e0d347
[2/7] fs/squashfs: sqfs_decompressor: simplify code
      commit: 0fe2801730edb99e24b601b043ec5595af319274
[3/7] fs/squashfs: squashfs.h: include file should be self dependent
      commit: 5e23f7f9f3b3c8fe78ed3aadeed9b187ba8930da
[4/7] spl: add squashfs support
      commit: 6494e823b46ced400764b6203d7480c9e3badc20
[5/7] spl: mmc: support squashfs
      commit: fb0df3552892ff150edaf7579989fd4750ee85ee
[6/7] MAINTAINERS: SQUASHFS: update João Marcos Costa email
      commit: eed18b1e25051123804d26525d600c9d2cd76e2c
[7/7] MAINTAINERS: SQUASHFS: Add myself as co-maintainer
      commit: 868233099d873cc8e2f8b99f609bdbaed421eab7
-- 
Tom


