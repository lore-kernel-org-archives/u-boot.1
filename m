Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EB62CD3439
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 14:54:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBC0A84ADD;
	Thu,  7 May 2026 16:54:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="POQVh7yZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91ED484A7D; Thu,  7 May 2026 16:54:44 +0200 (CEST)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6EC184A78
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 16:54:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-691de293326so541255eaf.3
 for <u-boot@lists.denx.de>; Thu, 07 May 2026 07:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778165680; x=1778770480;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=GWs0d7AZcsKHRjsCczJRpR0Y3VD3wFKgR666C5KAh9k=;
 b=POQVh7yZYkyeCbcpLq2cutFTLro9zke31aOfZlrEUUM36FfINRdV2GGnA3vmgRM50a
 JWghVJSnLceRB9Z8UfeJqCetoxGdhIK7OgfuSjOzRpMtry428NQucCDJk4AmN1uS74CF
 /y5BdGly1wL0shJATkhImkVPWFgbUHgxmvvHEzOtbkrnPjtdAADU5JwV466Gx/uZHd4i
 pjQfaCIy8Tv4bRy0NsvQKO5yUBLbYN7UCc8EHirFWSae74avkKgTlSzFFFrEgwmZ8H8H
 Nj/Vsyth2PbYZR8iYvwM6/s12V8K3genmKZER6tKLoZFjr8+2JunLxs4DffII+iTKf2X
 ShPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778165680; x=1778770480;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GWs0d7AZcsKHRjsCczJRpR0Y3VD3wFKgR666C5KAh9k=;
 b=EcsVfGXIiUxdeg4AN0OS/p8BbS+92FoH1eVVOr+4cC/pxCLa7SSLJEvVYRgXJMI3mG
 p/K3QadkUa7G7jgqSN4WgPlVY6WyLFENS+qEdzbc8Tr4lZJFyFsfwNs3UQhKya/9bk/R
 lru4qggy6KS6XNpL5B4/ughDvmhH9qDh4bfw3qa7kBVoj7+FZwa5mz2dPck22yaA27Kl
 C3MptIw1wZxsVZwO6XwN/x/rid5p2mrTaZzaNL7Jwj/UrqTB+nOsyRLgR3+c7Y04HTUr
 6rROJtYx667jXYfbcIT0898oC25VkE6YA/NoqAPWCwN10PL6yshhSAGtImHA0z4O91ga
 1/UA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8jaV28i9X1FXYHOJmo419fkFrPmaJCp2cghdT00p6CTX09Fmq3XxZFp7uSjyK+F6fdZRVyFyM=@lists.denx.de
X-Gm-Message-State: AOJu0YxoNyNIA1LXyYvghHECJLONQbodqekTj8lVS04dwBduGbzM6sk6
 GoqCC6RXti3r3w3OGOpvy+znsQrMBQ5Suuw6Hy/D5HdMg4iF93EPJspVpNb3m/Pe+S4EV+MxQsv
 471Wi
X-Gm-Gg: AeBDietKPOTA3UKhLrk44IPe6OmWKm8bTaUc6HJ+KIW1cqwItAQJwQhoVgTLhD5krQY
 FIeyS9pqK7WZaGwouLtR4AupCqMZmddbI+DqtvmsWffkOMDVu5jtamp7saGUkZxxUOl8x7AiFX2
 /pcsjTFpj5IQ9hhiwwBf8pZReYDoJQGlVhaf9+nDl0yGRZQyFyiLDYRwoaSBb5KoAGguwiqy3ON
 t5Z6z24nJFwCwcDbEQeWr8VuMAli0L5fdUwSQAWOh4jV8iDx9bUcX4S/gMpz+ex7p3fJ1B1WyXw
 QMOOYCtwKxqNgslYFGQ7nPx0QmyaGUWMCf6W0ePEe73pZAOvp84dwcBI3ZHyVoMrjwxYZJ1dHO/
 ZZlVN4YKHiDx9py66Ewlyy6k4raYSHD8zAMkLoyNAPQjZlI/il95shHUwY9LtLP7UWE8IWKy6KL
 CIIY9NqKiWdau3T3emyXYrPLMoyPVkyasKHIn9sQ0=
X-Received: by 2002:a05:6820:c2d0:10b0:699:a28b:18ed with SMTP id
 006d021491bc7-699a28b1f15mr2474955eaf.48.1778165680381; 
 Thu, 07 May 2026 07:54:40 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7374:f02e:e8be:88a5])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69689266bacsm12151275eaf.0.2026.05.07.07.54.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 07:54:39 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH 0/2] configs: mediatek: genio: enable common options
Date: Thu, 07 May 2026 09:54:01 -0500
Message-Id: <20260507-mtk-genio-defconfig-v1-0-5ca5d5c956cb@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQ6DIBBA4auYWTsJ0PgTr2JcIAx02ggGtDEx3
 l3aLr/FeydkSkwZhuqERB/OHEOBrCswTx08IdtiUEK1ohEdLtsbPQWOaMmZGBx77GbZNrZ/6F4
 qKOWayPHxu47T33mfX2S27wqu6wbCfi++dwAAAA==
X-Change-ID: 20260507-mtk-genio-defconfig-7b165d83a812
To: Macpaul Lin <Macpaul.Lin@mediatek.com>, Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=747; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=aq97pqyRlNpZT+EW4we23x9c2RlwoWOnRS4tS8BLJhI=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBp/KeaSs1NcNqcFdcaSLKgIgqOZdswZpovr1V5H
 ih35dtKGXmJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCafynmhYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AQxEIAKHy9U1Hu4OzFCUN5fzBeucCqoi8CN69siIDi9b
 IcvqtihiUm6IlelHXTccRE1dgTM5RtrFhF7EMcmWDHCp6ZLOiaVbBMTk/+GzVjyztr659con8Uh
 gM2QhRLCBd/VmVoUp41e2qpV1sDWeFjzYDgczRk4RfkP3vQEeeYN+B2kQCVRG1Fxq09FfsxT6oX
 fM2t0nsN+eATEPjTMNiF2rtqi++iL19+o37RXpLAJBdlb5jw2FELQvJUze+7JM2G8bCqG9DXMHF
 EECHanZCXwEcGSnDKp+/oST8aJdLVll0TNAKkWU7bSKle2PNcVfO+sjg5LuK+tkT0O8gOfUSSDr
 1NaM=
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

This enables some common options used by the default board support
package for the MediaTek Genio EVK boards. These options are already
enabled in mt8189.config for Genio 520/720 EVK boards. The patches in
this series make the other recently added boards match that.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
David Lechner (2):
      configs/mt8188: enable bootstd, FIT and DT overlays
      configs/mt8195: enable bootstd, FIT and DT overlays

 configs/mt8188.config | 3 +++
 configs/mt8195.config | 3 +++
 2 files changed, 6 insertions(+)
---
base-commit: a7c68a086a3806a99fea0e8f728c5e45e3bd5f01
change-id: 20260507-mtk-genio-defconfig-7b165d83a812

Best regards,
--  
David Lechner <dlechner@baylibre.com>

