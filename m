Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 787D9EF0702
	for <u-boot@archiver.kernel.org>; Tue, 10 Feb 2026 16:22:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB3D183CBD;
	Tue, 10 Feb 2026 17:22:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="uEz7ZfNJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4AFA83D77; Tue, 10 Feb 2026 17:22:50 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F28F8367F
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 17:22:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4806dffc64cso50681425e9.1
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 08:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770740568; x=1771345368;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=t/ZhLf4H1ogwEzR0lyTVBqFGu3OUtYkm7ZQGkxC8dAI=;
 b=uEz7ZfNJ/JQo9/pC1xaHWit9WOWC16DhmU+dQTypBLJYM/LhENYO3r7+roQ8Dhsd0W
 7EBxy9JDunKtqXKM0Kkdpvpnv6aT2sr8Wl1Z23NI1jj+NLXs/b0bVh8z9BZlz9q5RBle
 rphbGfpycwsJTmM4Ndw/63f+j6vbjzbsDZCEBL/zwSn6Cf+rjNvOF4NvwtlPs8lIXzUy
 ZNKZyY+8er1udXNNsRf72UBY2lRDlXU/e9BwVY6j++wvo5Udm9NIBoMCGF+cgJDEt6A3
 WNL0zJHuIHzwbH+4gndvAocKDH6yT0P2oi2fiocSBk/eATqXYn3YFRVgESBh6vKrWaHY
 0Gxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770740568; x=1771345368;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t/ZhLf4H1ogwEzR0lyTVBqFGu3OUtYkm7ZQGkxC8dAI=;
 b=mKU1WL7Whgiih0AnvbW8luUqpIGkfpUaVZg5gVl5BC61uym8+UKnEjZK039MkYqJFQ
 3TakUDb7mn429mD0OC/lmkwyc2bdONZC3QGE8IPErilgQMUmq44dJHWfbVRN4tXJOxVm
 B49RbK14QWJgs4bxAXv2Kpy7YOITOrUPtCPgl3qg3LBrt1iYxkWtZxIZywLN4zQA6bO7
 JX48W3yh78zEJNTDcbfU8gBvQWG7G/t67h1FjsSfNXh2V+z3qR4q4N7l1KcFT+zog9GL
 z9L1MhNjCO4RmcyugxIoLy9JJ6/vGLuABy9gwzlghUkydEsre6Jgu5keUYrTvrWZHDRf
 zxDQ==
X-Gm-Message-State: AOJu0Yw/MciCyhbx62SasGGNCOFMYhmig9DNLrLKk0uFbRbS25TeP7kx
 BEZhMaAVoS/Kw4J0Z5NMfgfxxl7CsQldv0RCYezkAVsgjpodVjUMPzfqXC+6q2xENvY=
X-Gm-Gg: AZuq6aIVgitT2Zh9UArb9XKcgtcGrFrEFhDOfunJxWQyruauLJMCCpvs6uZjCY/itUX
 oLX9viT79WCLX0oU0ZHMAbIE3590hSCTyFhWrKeZW9mf+ePXJX8aqU3t+sz61MvDCTmQxxZ/DCn
 529s4KQBRNkxuShv0hf0WfjVcmuyQv5YWEV26AFWE3n3b4Ls5JrkELUr5kQgyoaqg7kMUDmNW9m
 x/A129NT13evcJQ1jvSmkKkm/eLN6pkyT1NqbjPJ84/VKOyC9rTrSVr5yYzTuxvy7FE2AHOIeyN
 jE9xqd93TlwMmdlhdrx1ltFxhDJn6S0hFiPyse0luJuMJstDUVAu0cfyqv3BhXQJqLkJbh5aNmr
 dOtzLY1SDV51p9FFhB4z1k+wzeWZyeHQl0CYDhp2nHDw5dMWZBQLPdYF/3vQjNMHV175jO6kpkL
 d5kuMng/im/W70D7NP8lY9meAkM1vIMxUMTRMh9tZcZ1FPWa/JfWX5wTfLbVmulKaQaQm5sF9PW
 4LDoxVPCojKJ5vT69G0Jw==
X-Received: by 2002:a05:600c:548e:b0:47e:e78a:c833 with SMTP id
 5b1f17b1804b1-483209bcd64mr195913275e9.32.1770740567810; 
 Tue, 10 Feb 2026 08:22:47 -0800 (PST)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-43a2-d2f0-c793-0a1b.rev.sfr.net.
 [2a02:842a:d52e:6101:43a2:d2f0:c793:a1b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-436296bd4a1sm35185402f8f.17.2026.02.10.08.22.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Feb 2026 08:22:47 -0800 (PST)
From: Julien Stephan <jstephan@baylibre.com>
Subject: [PATCH v2 0/3] drivers: ufs: ufs_hba_ops callbacks cleanup
Date: Tue, 10 Feb 2026 17:22:42 +0100
Message-Id: <20260210-ufs-ufs_hba_ops-cleanup-v2-0-dd73da21aa92@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNQQqDMBREryJ/3ZQkWotdeY8iksSf+sGakNRQE
 e/e6AW6mMUbmDcbRAyEER7FBgETRXJzBnkpwIxqfiGjITNILmsuBWeLjUf6Uave+cjMhGpePLu
 XTaVKPthbU0Ne+4CWvqf52WUeKX5cWM+jJI72vzMJxpm2QmIpBqxU02q1TqQDXo17Q7fv+w+Yu
 OdqwQAAAA==
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
Changes in v2:
- Fix interactive rebase issue: add missing "," and rename ret to err
- Link to v1: https://lore.kernel.org/r/20260210-ufs-ufs_hba_ops-cleanup-v1-0-bf12e31de4a9@baylibre.com

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

