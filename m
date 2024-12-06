Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 299C5E77179
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 12:27:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50ECC895F7;
	Fri,  6 Dec 2024 13:27:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eVBq35fp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38FA389082; Fri,  6 Dec 2024 13:27:34 +0100 (CET)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07FC189082
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 13:27:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-723f37dd76cso1809137b3a.0
 for <u-boot@lists.denx.de>; Fri, 06 Dec 2024 04:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733488050; x=1734092850; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EcvsigjZ9GhUgjWltEWsFOSIhBpy8xme7jhF2lgL+Ec=;
 b=eVBq35fpg6xIsCdG8KDgOy1u9fc70GtdrqQnjbQmnEqzAKNWjUpGOBJGW2oeItEC+f
 ls8SKRsHp+71myaC9QJZ0yNw5uqND6pDjWfND34b3XmBpy30AR2+5fl4EaaW4ongWvoH
 ZjIv5bQn8pvhMLp4siymvAD6VkPXN30OyEiea3F+QzxoLZYSmhf1fNoHY6W5Fj9GsMhW
 lYx76+1ioGtBRuTOwadTmqrz8bG8e4ewxoZ+tGiR8j0nN4s+QhoMeb2R8gCE8OWncIyB
 nM1W/SvQKuZN3VG9tap4rVSVRcZ+XqmCIEv4awbNkOe4va4nPxGgLGrVck1zalF/vtPj
 nYyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733488050; x=1734092850;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EcvsigjZ9GhUgjWltEWsFOSIhBpy8xme7jhF2lgL+Ec=;
 b=nigjfAfCG6Husbk0mmS4fI87wHzQTQdecWZNq6TsPSCut2roBXNr+TxaoLFJ0/8qkR
 hVeO0mHQD+CgriJUsU0cDjclHFKZrAs3/vNrLAoqROZjaq9aINFjbfy3aUc7Rf6FKBxm
 BxbGT5JN3iEljIbgmvlcQjJ7k4xcbth0joqzBYiSeBcTHzC0C/zTpjwi98QtK9pB6UIJ
 DzDaoELnsCYugPoUKDWRWZEYiNPcgy9HZs0D7xXBKVF1y7U3js4T4mNOyUAa5BI6xhLB
 yEou45FJseVvvqUJEVbcA9pE0eit0drVtyfFLWgPNLlO+EIPlrAxrsIyQjmM5gX3quwD
 t2QQ==
X-Gm-Message-State: AOJu0YxWkmIJ6O5mVtzlNjXyZbAw2bzTShdZ19JBbn9E2Ymn/dnACXMK
 17KoZmJSzTQgGMfgfyqWO16Se9DD8E9c9J3Bv/bApST1jlQUqoX4TI06aXfTmtI=
X-Gm-Gg: ASbGncudW3fcOve6k64mdv8EjADEmfLWxdptFAsSosuyFPUgnTwhJGCxDUBY2ZYp0BR
 FuNtGWGTGv+ATlbQlFzUBXz5rhyO5pBWxUTmTkx2QIadknRe+veZgBQ1ZuU59TE8Q5X3BovRAHg
 yBjGP3qTHqOl+jL43QROjk4iuGlsx4dpEvdHHy0zzcf8GxE2tbYnOX8oTxBdrlKoQG9vbDiySSk
 W+PTB/edZtftPAhFseu9b+DjuowWv+KYc9A3H41P+B3nX9TcBC2SL5SMA==
X-Google-Smtp-Source: AGHT+IEsUma+SnItJV4qBqiosLaMnC8pUIAYJ2+TnQi2xMkglol8WP6kPipzcQ5EzqDPwXN3AnYspA==
X-Received: by 2002:a05:6a00:1890:b0:725:9d2f:3c04 with SMTP id
 d2e1a72fcca58-725b80e4a6emr4897075b3a.2.1733488050413; 
 Fri, 06 Dec 2024 04:27:30 -0800 (PST)
Received: from adriano.. ([191.119.55.5]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-725a2ca6725sm2821011b3a.151.2024.12.06.04.27.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 04:27:29 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, trini@konsulko.com,
 Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH 0/2] efi_loader: efi_net: Fix net_dp handling
Date: Fri,  6 Dec 2024 09:27:12 -0300
Message-ID: <20241206122714.2365114-1-adriano.cordova@canonical.com>
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

Fixes commit e55a4acb54e8 ("efi_loader: net: set EFI bootdevice device path to HTTP
when loaded from wget") which generates an use after free, but first it is necessary
to expose efi_reinstall_protocol_interfaces in efi_loader.h, which is done in a
separated patch.

Adriano Cordova (2):
  efi_loader: Expose efi_reinstall_protocol_interface in efi_loader.h
  efi_loader: efi_net: let efi_net_set_dp properly update the device
    path

 include/efi_loader.h          |  5 ++++
 lib/efi_loader/efi_boottime.c |  2 +-
 lib/efi_loader/efi_net.c      | 53 +++++++++++++++++++++++++++++++----
 3 files changed, 53 insertions(+), 7 deletions(-)

-- 
2.43.0

