Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2445FF8873
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 14:07:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDE8984862;
	Wed, 29 Apr 2026 16:07:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="FAw0Tb1Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 210E18485D; Wed, 29 Apr 2026 16:07:10 +0200 (CEST)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0CC684869
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 16:07:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-6966f99716fso229027eaf.0
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 07:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777471626; x=1778076426;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1XggxRpyEX2Nfkb5on+I6csiJx9fhasBIJtR4naCYZY=;
 b=FAw0Tb1ZgMDj5JK6JVBVhGMlD/71oTRhMdwkaDrhMvzp//bgEaVdFidzPKd3cGrDiu
 hXYYrc88mikUeb6i2El9YGC0wO09HaqmGE6keqAYeQQUeKxV/8RESbz8VvsKve6U54B+
 qsvZ1glEZmc7b/FPStF7Z4c782X/MTI85x9Ae5B9AP7BIUspbgbHgIsjqCwOqKT32KWM
 NwdFqCYUghvw/BUVo31Bdxo1Ry6iKvYVR5fT75i948j7hBxWdVoVJZXj1NOSANIifZMK
 2wVoScgKYFqizNWxBrN2u/9l2zQ2bFoD/gqseLdVqtH7Gtei6wX1C36UiTjqOYKoG9RM
 iz+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777471626; x=1778076426;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1XggxRpyEX2Nfkb5on+I6csiJx9fhasBIJtR4naCYZY=;
 b=G6conrXwsoTguXvbdr4dhY6cUxdWCjeljwFPYv/XQU4Yet4ponpn+ryg5e+fQ3+/IG
 0aS3WHJQTsjyNfZb5Fx/2dQ4xMe9zWHx3qKbOVr/qAofe55HVkvYzpOcfDKGDeYAqYc2
 kGfzTSaQY4KLsyq3kNq/0+Ppxnh3ipDzoay5iPKNX9Y4FYHpWOBralXBemOPhcuWgeg3
 KRMixWmYJN1AAdKNe9R7R7CEYkYV7Acoe17hpYlbAZqgp1xuNsFvx4F/8S2sQx4Iimeo
 +Tx/EiiahoVKgt2Z5MK5kTKbdkkjSUaOED8wYMGXxgucjUJswAH3GOPwVRDY2RoueuZv
 oxNw==
X-Gm-Message-State: AOJu0YyIF4sAvTspJusCt8xwLQB14QCSzi/32b7OJdwvE2mpRQhqaNqW
 9P0tqX0JrIDUQWvFA/WJ0K7jit5+IPRRUQwlukWdgrXI8dYlT/r+EB2o0cn2f9XMDWE=
X-Gm-Gg: AeBDieu/OJRv/M/j/LtCjMrVdWlAJgbEb3ELg1YYQakpQIno72DqYDB8uG4ec22AMnh
 qUDDj1EvEbmBAgJyyAbNBePx+2Gh49QhemBlv9vmXmYftl8j0BwHFxv67UdlUweBgXkNxpXHHfi
 SvKiebtZM6c1tOAcNKZL2Xk4BZ1QEadZEDz3h2aXttJ44V49KKyfLulJxTc5AgxOVzdAAiCqneA
 W7tMf/0aCmTJYdJwbqfeO9YdAx1miO/EakaKMF1GvIucMJt4wPhkAvLLKc6DF1OAz7NOfvRGLgs
 lOUa2ObFrd4ZGTHOsnQZdBzpcIHm1qhU/iLfqDwLhIsnTAmtaWhc6wAlRPIwNlhFLQrZAGRtaso
 Hd8C8ieGqco/UdcLePofveXK/0j3jz/Z/uSosYnek/WmReexVoiNPQn1xlmwRcEYsJKTq1YZGpS
 k6yVUJq5G/lsD3au3+L0X2YJu8giBc86mbNdzTWE4=
X-Received: by 2002:a05:6820:2220:b0:694:a23f:cb17 with SMTP id
 006d021491bc7-6965cba2a07mr4053671eaf.52.1777471626595; 
 Wed, 29 Apr 2026 07:07:06 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:1770:76c1:cfc7:3a0c])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6966be65f1asm1226668eaf.14.2026.04.29.07.07.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 07:07:06 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: u-boot@lists.denx.de, Weijie Gao <weijie.gao@mediatek.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Julien Stephan <jstephan@baylibre.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Julien Masson <jmasson@baylibre.com>
In-Reply-To: <20260428033625.109032-1-weijie.gao@mediatek.com>
References: <20260428033625.109032-1-weijie.gao@mediatek.com>
Subject: Re: [PATCH v2] configs: mt7622: remove empty header file
Message-Id: <177747161367.2560708.10206850310150157218.b4-ty@b4>
Date: Wed, 29 Apr 2026 09:06:53 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=311; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=wZQI3V3yMevvukqIJRtOgsIDTgE/XTFwx2O0XdoBBrk=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBp8hCAREB8mpQ2QiLQA8NhPNh614ZOuG2Kpn3Q8
 Mc1m6e2G1eJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCafIQgBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AM/0H/RcBiP30dorbNr2mqHLPucBADAY6ymVrEb+E5nL
 CCBxyw5D0UCb6qCZr9hmnydwmJTNnc4O8dN7BvWcWazBpCuolDEVHOgy305kWV/gEDRwxOSpvxy
 uL3xmpBPZr6sdgqoKPFL1691XedY4xQRQqDUSuCETnnmc3dp1qsszBi/C5ou3iwnytzvSUfsiHP
 TjuboCIL8D8Fo1D3EAwm3K8k9jQEmtzUHYG8147wvIeQN0nt/US+ClfhdV54Uiu2r0up5zqvz8L
 7/PYIcQv1iVnHI/ebKnZZv2f63Pmet9YuaFJjH1spabfLS0erkjhd2orSqlf0SOv+E+iIYXgEVQ
 HjoU=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

On Tue, 28 Apr 2026 11:36:25 +0800, Weijie Gao wrote:
> configs: mt7622: remove empty header file

Applied to mediatek-for-master, thanks!

[1/1] configs: mt7622: remove empty header file
      commit: 3c14cd8388dad4c93c24fac53a7b6d21bc81765c

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

