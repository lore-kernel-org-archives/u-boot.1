Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C6BCE7717D
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 18:54:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F87180303;
	Wed, 11 Dec 2024 19:54:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="FcdhYBQg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C74F6801CE; Wed, 11 Dec 2024 14:53:41 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9377A80209
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 14:53:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=nbelin@baylibre.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-432d86a3085so44887115e9.2
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 05:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733925219; x=1734530019;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=itw0Qpk1pMfyJE6QVyCJEqsatwQrWsvt8zIUE2Qg3LI=;
 b=FcdhYBQg5EucC0v/1/UUCFWl0yvMEdVc61nCHCPs0JHgOwEVUTov45wbdeAEk4/cdt
 ah8+W2MpuLIZmsm7i30rtQEoQeoiO+lt5b6IHPU8tk1A1AawPR/ZYLyGZ9w4LXPfKXe2
 RifG1NSNSr17cLJhpkZaI0w6rgwfvmCwg2lBrufQKNpKmlkqXYvH6RISsQ7K1IgIWryL
 /S4EiOYB0aOB5QHiUOpkLas1T9BmDdxFSX+3irxlMy8mxxhOq0y4alR2n5twPrTQPwkW
 Aa8mQtnOwjdKJYD9gFMwYnPXCaheBzMKADVspvtjRyKpG+YqZ7FcjH+qgPAOV/ZyKl+8
 gP5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733925219; x=1734530019;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=itw0Qpk1pMfyJE6QVyCJEqsatwQrWsvt8zIUE2Qg3LI=;
 b=wV9lO28Z9FRvLDDVa28m5XuHl+yjcX7MQShBr57w6yqT62OuMqnv+e9taJfd8q15TC
 Xu3c1pp6xv3HQWJRM9W6sBqykrxRVLN7VaGudeUUEDm7Mx0oMXQor804ZsLfqkvc15PZ
 64zb5Oo/nrdhZkCu8dCCZ6CJdntNZYtYSdEZprXai+Ecaes9DoPbNM1OsdsfCO5wUShm
 rZs6i/o+EDU3DyArvJj8WOOmA9NzpybE545ZZMNqvPlKNdSaBSQWBLnPPx9QZiM/dfWN
 PDB+6igWAap3srBBjEViGpNvEBSDLd3Fh3tDrOaZJ3e9xAuRCV6vp3j0/odMX9OFctKH
 VEGQ==
X-Gm-Message-State: AOJu0YyOTneiAyo09eJ+qY3s19MX0xHBYfJ7r8WaX42gpfroAZoZTvLr
 4dHI8KkZAmwkuuezSg+XosOmkWy1/A+ocSidAllbPECktEQ77FW1bRjuJ63yGOg=
X-Gm-Gg: ASbGncs+7MESYUY6xCLR9MSRe601mJv/o0wO+jDpSpSp1Agi8jNBEYdPARQxidoRsqW
 EDdf1f81znUvH9Vi09MrKkF3hds2ALDzIPcnDf3RQ3KvMbhWQX9FcRrWjzG330BODrMHr7KoTUD
 WA3FNR8mN04EposN6BJi0vQDc2OPlgJ8ybS94ZxI/7I7rJ4vH2kiGnE1ULdVjBg8/WgbwXsgPQF
 6ENFGHaNLoJBy+UW/uE5iL+bmiFkUzsuuJv4mOVedUqX6Mjc1n+WmQ=
X-Google-Smtp-Source: AGHT+IHWYhWiRJ+qLbfB1kpqMrjb4cF7S7gsI6tvWjfmwlxOgDvfK8z3rMsVoWRJZLi7k32dXEeYAQ==
X-Received: by 2002:a05:6000:2b03:b0:385:e3b8:f345 with SMTP id
 ffacd0b85a97d-3864ce5dc32mr1559201f8f.30.1733925218995; 
 Wed, 11 Dec 2024 05:53:38 -0800 (PST)
Received: from [127.0.1.1] ([2001:861:d40:6fb0:1b92:49fd:8154:d517])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38782521845sm1316013f8f.106.2024.12.11.05.53.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 05:53:38 -0800 (PST)
From: Nicolas Belin <nbelin@baylibre.com>
Subject: [PATCH 0/4] boot: android: rework the bootargs concatenation
Date: Wed, 11 Dec 2024 14:53:23 +0100
Message-Id: <20241211-fix-bootargs-concatenation-v1-0-c6752bcb9dde@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFOZWWcC/x2MQQqAMAzAviI9W7BThvgV8bDNqr1ssg0RxL9bP
 AaSPFA4CxeYmgcyX1IkRQVqGwiHizujrMpgOjOQIcJNbvQpVZf3giHF4CpHVzXD0Vuygajztgc
 dnJnV/ufz8r4fYppcs2wAAAA=
X-Change-ID: 20241211-fix-bootargs-concatenation-8b616c110b63
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Safae Ouajih <souajih@baylibre.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Ahmad Draidi <ar2000jp@gmail.com>
Cc: u-boot@lists.denx.de, Nicolas Belin <nbelin@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733925217; l=976;
 i=nbelin@baylibre.com; s=20241211; h=from:subject:message-id;
 bh=KyFPJ9ai+mN/5HpN74yJMTmah3xHlNUBTGxAQItKL2Q=;
 b=Vl3ZzLwvb0wfEYDI8IA5wUkEpHVvpLxIxcGupfNul1woJDHhIoZ/VsBZojS/XEGmSylN+alXB
 8k+OJBLABGMCqErxBBV24XZZ/2qTky+lT+cnI2mdzOkH6JeQWZnwflg
X-Developer-Key: i=nbelin@baylibre.com; a=ed25519;
 pk=w8SrWXgXuIaN/RB7JHkKa2EKDC5nVxqVHI8XawK2M7I=
X-Mailman-Approved-At: Wed, 11 Dec 2024 19:54:12 +0100
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

Rework the bootargs concatenation logic to make the logic clearer
and address several issues such as:
- checking the value at the address kcmdline_extra instead of
checking the address value itself
- freeing the string that was malloced for the concatenation
- making sure to malloc the right amount of bytes for the concatenated
string, not forgetting the byte for the NULL termination 

Signed-off-by: Nicolas Belin <nbelin@baylibre.com>
---
Nicolas Belin (4):
      boot: android: fix extra command line support
      boot: android: free newbootargs when done
      boot: android: rework bootargs concatenation
      boot: android: reorder the length calculation order

 boot/image-android.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)
---
base-commit: b841e559cd26ffcb20f22e8ee75debed9616c002
change-id: 20241211-fix-bootargs-concatenation-8b616c110b63

Best regards,
-- 
Nicolas Belin <nbelin@baylibre.com>

