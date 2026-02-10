Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F8FEEA8130
	for <u-boot@archiver.kernel.org>; Tue, 10 Feb 2026 16:11:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C374383CE3;
	Tue, 10 Feb 2026 17:11:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="a8EtJjuw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28A4083CEA; Tue, 10 Feb 2026 17:11:26 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A74A83CB5
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 17:11:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-47edd6111b4so84992915e9.1
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 08:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770739883; x=1771344683;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zBsPK9T/Wq90/fdP/myL1fdR+eCDn3CuwAWVsjFKw6I=;
 b=a8EtJjuwp+StO81lllk/qh6YB/uyT1CuI393Neegi74au9PTTBAuz8pZMDP5uGphhx
 qcCGDvvWrmFyfhJfmIfe2D6tRgdqtNfQ6FT6HIvvzPIv/TS5wgzTYkLJVMgpYPCjNpEA
 cyp4Z8iuEyS2xvhWTgmOEHy7BAikUXEBgpIS33PCigYeI1q87Q0Kuv5Sv3hyzPz0fYJ+
 onzxtnmebEpDKBNkw4cOjm2uBdyplhN31DQf4dDe+RfOwiZlF7mZ8OITic4VrhSi3Be+
 yUWN7x+uINtx+FmsKVAwtwIwSSCifATaRYRHsrc6kt2ZW3gdDqmFbflyfx6jgS82o38O
 PhnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770739883; x=1771344683;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zBsPK9T/Wq90/fdP/myL1fdR+eCDn3CuwAWVsjFKw6I=;
 b=xUOUVt27h+J2/80uGslXbufy85ZIXcIcvor+QyqHnnHeKyctmtPaTTeKCuZPwBMn+P
 oYdYdRoNxclYt3CUuf1O8NbEgF7XY6s9g/lsFjnYgXe/TeBtjyJUxH54MG5c8H3rgguL
 uPWveQKlPVLN1t2mMkGOFQO5Bp+0gM5o+DhxSUQlAwloDJgCl8BPeXd3e1sMMIx/ptg3
 ru33VpuFagvnaytfNhGc4Yls2AWp9aegjNa5s5/A8y/U50CJYtLFk+gu5tNI5pBYwCqT
 oQmsKb3/H57ki0BRMRxx8a2gTPkZJ+iHmqjCCYQpEK+wVWovN88YEgjycxrBBiZ9hv7z
 P9DA==
X-Gm-Message-State: AOJu0Yxsp5UcJGCxtn3tzWDXYLjxC10noYKz7Ib0EFNscKg4lJJXgg8G
 d4N23j9MfUXMUGFbaClKfK5wiG9lGVF1DAKN+9RkSBnb1HBM7CzwrsmsipGehhfoolg=
X-Gm-Gg: AZuq6aJ1Owwt/A3WcAZ+xC7WDZQgYrizHkGQe2Pamhy+aDnsC49EqFb3TbZRLNzMseC
 CcADLLYZGFZI4xSC8sH9UA3/DOCBldoicOGBHnm5+CW69o0Bm7t9Gg03CNKjKn9z9IMMeTrSBpe
 GYz/InZbqgUYkQTVPOnOuc3lOWb4gCCl6OsxOvwMIxhtImD/DcW+msUhTkE7IaMJO0hiIXTEgwE
 PsHHDNa8w5Xkg3BXmYvms42qOc+cEEPlcKO3WJVgf7pMC4sPpxzLzWoLqhgk5OCmTJzjiCcF5zF
 UJUu9YQMZfV/9PbqZwWcijtMPA03YBUEVyn63cL+bTMsUVg1yzRiS70PZRPDw3J2wiQqhB6IiQv
 u3jne1Zal05RNVX3d272w9yKxrYiwHOFOS+/vr8NcdZ5o6IVTvBB5V0pRD9K9bXIWOO/+H4Wime
 k/8wH/Cl86a65xQ7LTyf5QYOlRcvutSEu/az7LBFpgE9K65h/Yf0HhYWh7EE8zf9IQrGXwLw1R7
 PKLYY7vXg9L6dM0yVFy7g==
X-Received: by 2002:a05:600c:c16b:b0:480:20f1:7abd with SMTP id
 5b1f17b1804b1-4835082d1a3mr40383695e9.31.1770739882676; 
 Tue, 10 Feb 2026 08:11:22 -0800 (PST)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-43a2-d2f0-c793-0a1b.rev.sfr.net.
 [2a02:842a:d52e:6101:43a2:d2f0:c793:a1b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d7e50casm62994595e9.8.2026.02.10.08.11.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Feb 2026 08:11:22 -0800 (PST)
From: Julien Stephan <jstephan@baylibre.com>
Subject: [PATCH 0/3] drivers: ufs: ufs_hba_ops callbacks cleanup
Date: Tue, 10 Feb 2026 17:11:16 +0100
Message-Id: <20260210-ufs-ufs_hba_ops-cleanup-v1-0-bf12e31de4a9@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MywqAIBAAfyX2nGD2on4lIszWWggTlyII/z3rM
 Ic5zDzAGAgZ+uyBgBcxHS5JkWdgNu1WFLQkByVVI1UhxWn5Y9pmPR2ehdlRu9OLtuwqXcrF1l0
 DqfYBLd3/eRhjfAGI+79BaQAAAA==
X-Change-ID: 20260210-ufs-ufs_hba_ops-cleanup-7394a30df596
To: u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Shawn Lin <shawn.lin@rock-chips.com>, Bryan Brattlof <bb@ti.com>, 
 Udit Kumar <u-kumar1@ti.com>, Jared McArthur <j-mcarthur@ti.com>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, 
 Michal Simek <michal.simek@amd.com>, dlechner@baylibre.com, 
 Julien Stephan <jstephan@baylibre.com>
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

Hi all,

I am currently writing a ufs driver for MT8195 and I noticed that return
values on ufs_hba_ops callbacks are ignored. Fix this.

While at it, I also removed a useless wrapper around
ufshcd_device_reset(), added a wrapper around
ufshcd_ops_phy_initialization and fixed a typo.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
Julien Stephan (3):
      drivers: ufs: handle return values of ufs_hba_ops callbacks
      drivers: ufs: add helper for phy_initialization callback
      drivers: ufs: fix typo in struct ufs_dev_cmd kernel-doc

 drivers/ufs/ufs-rockchip.c | 10 ++++------
 drivers/ufs/ufs-uclass.c   | 36 ++++++++++++++++++++++++++----------
 drivers/ufs/ufs.h          | 10 +++++++++-
 3 files changed, 39 insertions(+), 17 deletions(-)
---
base-commit: b99da05e1538b8fa153322da82917af2aa27e1d6
change-id: 20260210-ufs-ufs_hba_ops-cleanup-7394a30df596

Best regards,
-- 
Julien Stephan <jstephan@baylibre.com>

