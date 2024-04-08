Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDDADC67861
	for <u-boot@archiver.kernel.org>; Mon,  8 Apr 2024 20:22:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1664B87D40;
	Mon,  8 Apr 2024 22:22:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=loftorbital.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=loftorbital.com header.i=@loftorbital.com header.b="l0RLGmVX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D01588151; Mon,  8 Apr 2024 22:13:26 +0200 (CEST)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BCD28813A
 for <u-boot@lists.denx.de>; Mon,  8 Apr 2024 22:13:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=loftorbital.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=charlie.johnston@loftorbital.com
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1e2232e30f4so43037165ad.2
 for <u-boot@lists.denx.de>; Mon, 08 Apr 2024 13:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=loftorbital.com; s=google; t=1712607202; x=1713212002; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Q1RMSr985VpFadqOaNVpdyBCHDcfpUdWmWGn3+QSEnU=;
 b=l0RLGmVXouVCXmncpDBN/FTY3iW7imWvx6D+R0HqnONSUkPFxHMcrDmD2l9KKz0KAh
 s+NfEr/UHpSela+gs59m1vuGaSohRd9erC0Nar8cn+tXvRmqP9j3laXeSB2HUNxhArUm
 81BBFkq+CM8oCVIhPv6ekipTXBhs0+D5K5564Z3xmsb24/5NtbjzTlkkh7hYs+j9/nl5
 GqiZwzYa1XJAWZdgLJkNh26bn3QY9Nx4Olqhhzy5Sg9MHjyrbpvrheIpH+Kit+qzM+7u
 CNDGDqf91C7FenYkwvObO87lcfqBMaIYUULfXaw+oPCjTItDhdR94bUmRYL8XpAPaiXM
 KmAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712607202; x=1713212002;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q1RMSr985VpFadqOaNVpdyBCHDcfpUdWmWGn3+QSEnU=;
 b=kpmzDb8DQEJNpZYygfzsEkgejRMUyNoKGatBZ+7ti+D85VCiShI/uy0YuE6TZ6DxDe
 ihrYUzkb8H8NAu7TtmtcBvg+A6mBdIV4zyg7AZg7sXnPH9v1yJSrpZY70gMLCWlj2VlG
 0TDn9sIpxKnva/Xb0nmHZ2EFvH1/OR2dfZbrLm5Lt2NcAUavQDpyjtIYUrtkMtHdWeYz
 9/j14L8VhECy3VHF0RNvZ+ktmxm5f4fIB6cCKWUW2nRiOEmBZaoyLUBHD9Cz6tPVp+ZM
 c2p3kpbdM5N1uQNymKsGayM1k3lhlW+F7BChRjT9ZdOwteO5kL4VyxDQWof2PvaxSJZW
 eP+w==
X-Gm-Message-State: AOJu0YwI4sEjDLXDLQv3cuqyRmze6tkO9yfgofxpvDP92K4H6r91togO
 q0rJeP2qJJrDObzJ/xzLp1jzWU43I8M1SIuEGDQgzP8gCkvlGCMjiXCeOhMsNws/Jgo+loRURQ/
 ooQ0=
X-Google-Smtp-Source: AGHT+IEhCS1WqVDcc9LEf94hPGKYPNlA1gXW2mg7PaEIdzj/KnmiWdkLm4+ekwrsvy/akLX9Gwiswg==
X-Received: by 2002:a17:902:c3c6:b0:1e2:6b5d:5b18 with SMTP id
 j6-20020a170902c3c600b001e26b5d5b18mr9073308plj.51.1712607202519; 
 Mon, 08 Apr 2024 13:13:22 -0700 (PDT)
Received: from cjohnsto-vivado-vm.. ([12.172.216.189])
 by smtp.gmail.com with ESMTPSA id
 y9-20020a17090264c900b001e3dff1cb4bsm5150982pli.19.2024.04.08.13.13.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 13:13:22 -0700 (PDT)
From: Charlie Johnston <charlie.johnston@loftorbital.com>
To: u-boot@lists.denx.de
Cc: michal.simek@amd.com
Subject: [PATCH 0/2] arch: zynqmp: Make zynqmp command more accessible.
Date: Mon,  8 Apr 2024 13:13:11 -0700
Message-Id: <20240408201313.10183-1-charlie.johnston@loftorbital.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 08 Apr 2024 22:22:35 +0200
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

While working on a third-party board using a ZynqMP, I was unable to use
the zynqmp command even with the proper config definitions. While that
command appears tied to the architecture, it was being included based on
the board selection instead.

This patch series moves the command to be accessible to any ZynqMP arch
based board.


