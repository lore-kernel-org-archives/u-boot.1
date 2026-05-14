Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE2FFCD4F39
	for <u-boot@archiver.kernel.org>; Thu, 14 May 2026 17:55:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBE208465A;
	Thu, 14 May 2026 19:55:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Nxl7ltVh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E860846A5; Thu, 14 May 2026 19:55:07 +0200 (CEST)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F0838464D
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 19:55:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-479d5ff103aso4068178b6e.0
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 10:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1778781303; x=1779386103; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=geUrBFs9IH8rbWgnIIz60MUFeaYU68oeGdIIUToyQl4=;
 b=Nxl7ltVh/Op7N/OsvwnvYizNDvnyCAnQI9LV/0N6BswntiieTUjm0wGYUPrpoyzP+B
 hCBQa94RQfIqaR0TYtk/m2f8skDc76rL5K0DBktnhPYKLArbiTtTAQD+CBpm9grPaf7O
 lYZ4Ky+73oQ8BRMD2tZKOLsyQtywp+NzIYxfw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778781303; x=1779386103;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=geUrBFs9IH8rbWgnIIz60MUFeaYU68oeGdIIUToyQl4=;
 b=FtPxaCEkkaIQHeVLJyq9e9dmnuoafjyXOxxOLpvbOUCpJrdsgLFIechv2CzjG367LX
 jWR/mL/0CnDQ+Jp86a1ezc9AwpSvz+DyKPmkeNOBIVA0A0hYICypWEQ3vaqBuo5mz0jD
 zlr2xL1O4sAVxI1ywNL+9A8EXzuZI7Vf471rIu0LfO81ZY3EdAGxgdv6JAzzxwv/UpW3
 0b46FJDG+L6VCzDqpy5aFPNrPwYDYxFMwRso771CME0guCuyF/nmKxpHMPAS+bi1COT+
 Ro1ZhzeU0HVXjlYAFHgRFcFDA94CJc8aHzYtT4PG4n4f4I+HmQ3oOEGkVwnRhYJfAOGN
 mMNw==
X-Gm-Message-State: AOJu0YxXX9ugdr71+1fSNp4RaO7GymKO+ofdcm2iGOUFD4lfsGcy62/G
 161XvaG7/GhwMqzScr26W+qdN0ZV9Hn0T0krSI5o/esSS8Ed9xMjpE/QPP/Rkolw7GuAK2suUJD
 5y8H8apxbl741
X-Gm-Gg: Acq92OGzayq97+9OClQIJbf8i299QHUYyOLlTKLsfqCrOn+B6ePPh2V1fsbkaYL0kKY
 ezYjcbZmFENdr28zpSFue3j/6cwsvHjbUnORlI+xkki8akrl2pQbmOQjT6mbWv6C6Y7eMzbNVOR
 FbIDsJr5q/YtCfpVx2NX0dZDihgPRExFlb0VUIbQAsHlH3Ux/O3dK4O0aKpoNKEnPrm2yej6Zmf
 Z7cdXG9A/VOaBz7xrHn8iGcGjwe2FHJ0/klGI5Ct+ZaZAGltrzEhguy7zNPZ2PQ78scQ7FUQHPn
 JTTH/cKu3Jy3C9qGrZl3FhZqUPM+igxMe0+Ul/R10VOXuf85eeCM2DIwrTee9I+OPwrTruWWx6/
 gG3F2QVNCFPIlLUiuoSbVGztvcV5OixOt/Do4ruDGaXGWW7DQWVrMJy699ArO90GnSL0Wkh3dxp
 j5w0NM0YkelAkpfuOUF8AVu0ptIYWB+zk7kvtViilCdqswf2l4kluajaISIj1Zn/3R+Gu68uolK
 C35jnIecXBy5EOHUpkmontZLxb2niGb13jHEg4b8qRLSeJiyCZu/TT2oK9oOOkUndcrZzADHEo=
X-Received: by 2002:a05:6808:120d:b0:450:bcc7:18d7 with SMTP id
 5614622812f47-482e55afe2bmr333484b6e.2.1778781302866; 
 Thu, 14 May 2026 10:55:02 -0700 (PDT)
Received: from bill-the-cat.tailc58245.ts.net
 (fixed-189-203-106-235.totalplay.net. [189.203.106.235])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-482d379f062sm1758710b6e.6.2026.05.14.10.55.02
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 10:55:02 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 0/3] Clean up bloblist initialization
Date: Thu, 14 May 2026 11:42:26 -0600
Message-ID: <20260514175457.4047707-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

Hey all,

I've been sitting on this series for a bit (as the patch dates imply),
and I'm ready to move forward now with it.

This series does a few small but important cleanups to how we check for,
and initialize a bloblist. The first thing is that the way things are
done today, our HANDOFF code can only work with a fixed bloblist
location, so express that requirement in Kconfig. Next, we demote the
scary message about "Bloblist at ... not found" to a debug because we
most often see that because the bloblist doesn't (and can't) exist yet.
Finally, we remove bloblist_maybe_init and split this in to an exists
and a real init. This results in practically no growth (between 8 bytes
growth to 12 bytes saved, with some outliers saving much more thanks to
knowing it's impossible to have been passed a bloblist yet). This also
cleans up some of the code around checking for / knowing about a
bloblist existing.

-- 
Tom

