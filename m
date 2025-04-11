Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E2A4C36010
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 12:47:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF3A283FDF;
	Fri, 11 Apr 2025 14:47:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Cs1fLi3o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20C6583FE1; Fri, 11 Apr 2025 14:47:53 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6B4C82B72
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 14:47:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43d04dc73b7so20639025e9.3
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 05:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744375670; x=1744980470; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8WUSI5LGKm7182HQtuKf2NaITSjk/4x9sRsIfA59MT8=;
 b=Cs1fLi3oTXLsoAp9AJnDi9ufctqkJVqK2fdedp+AAQW4IxxiV4/1AVPpXdsAzN3oUC
 smfPHeZiuQKOIq3Gjo9w2caNwBUQsxCfVm9QXuSEWE1tCtIA7GpsWoyeYgw0Pzbk8YNz
 pyVjNh5RCGarhoRkKkSB3DPxt9QkepWmG3GTjGMrcJrtwVh5vhnsci+nHUQVKrj/ANwe
 wA1Ubnd+oQzMoEtn3FOTI4o5jmi/KaW92CXF6VeCgdD6VE7+IM70xnkTXNnkWQtJhZo5
 QKSrtcnwcDCGLf8HrTUVXswGEU/t+KhyTOuuBmPLsbcr1OXUcNLSg1svJjLHTF2SQkC6
 AhcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744375670; x=1744980470;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8WUSI5LGKm7182HQtuKf2NaITSjk/4x9sRsIfA59MT8=;
 b=pYOuL17SLOo2T+N1RNuBtn8+iGFd8ElkiXZZIW25/lG/ok9tQdGelTeT4K7dPuFS+b
 P9VTj1mKrJ6GYOf/9TNF65Y03QIHqok10v1MyL+GGmUgC0hyCpMayLNJIYrYqQ9e5nqP
 QUA5VJt8U2d7UP9iLoe911EEtReL01lUJUoqjDJ4/M6k1doUhY/eZeBqFnytrJviIqae
 LHdTLiubgnC49gNfBsNtHPWsDB7i/LOhhIDnWhlFV6LoxwHCUvBylUmLh5qYY4VPInhf
 l/Qap21PQBMjKQe7sMwLK2/OsQfBHNCsr1ArtSRZZo/xS51chbU0UG3TM++iyQYlYk0g
 GviA==
X-Gm-Message-State: AOJu0Yx9wiZ8UKG7SKNUvfImmW++E7fMo16LRG7J0hDaei+ei/DIUIg7
 SCjsPJdPQAUVeX8nM05hBXsc0nREKx8cnf841nuNHQ3hBmKx6ax0tWPZ4LMk77E=
X-Gm-Gg: ASbGnctVrYbrvyWhti1YPcR3AeVW/LkaJkWoimIM94Lkqr7sawg5jk3TFzX6n7rSieM
 LHl/iangrVGb62vlQvdVH/SBSDxJTSci6kkmeo6wZ32pabz4hqRkIaWtid3opnF2UVgBd84g23g
 WkuNy3sukdXzU1kW1yPFtlrR9vrCXzz3z4WVP44jhh01z0jrQFCzfo9rXoNqQxwT6y5REZaubQq
 2gZRK7gFjpvM9OJyknFgzZcdQxr02CmFRnfousiOb0OCPgq4Qd60w2O14NT5UA/mJrwa7N1FVPh
 aI/LJL035MpxJOAGUmbPJ+GUv3zmM7AW5NlzgMEclHGOk8+QLcMooak5eChXfefNqEsQulu5got
 IAN12WWLryvRvd6uXcvKrp5gkCyV3
X-Google-Smtp-Source: AGHT+IGjqdPYED66RG84FdTw8ksrudo5fKaHgW+cXQNkFzvEkrUqF9ChsBOrjnu6PVoaXE+13tFWqg==
X-Received: by 2002:a05:600c:348a:b0:43d:aed:f7d0 with SMTP id
 5b1f17b1804b1-43f3a9be478mr20142585e9.28.1744375670105; 
 Fri, 11 Apr 2025 05:47:50 -0700 (PDT)
Received: from toyger.tail248178.ts.net (35-60-142-46.pool.kielnet.net.
 [46.142.60.35]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f206264a1sm88299695e9.9.2025.04.11.05.47.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Apr 2025 05:47:49 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH v2 0/8] Qualcomm: cleanup OF_LIVE fixup and fix RB1/2
Date: Fri, 11 Apr 2025 14:47:37 +0200
Message-Id: <20250411-livetree-fixup-v2-0-1236823377bb@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGkP+WcC/3WMQQ6CMBBFr0Jmbc20gCgr72FYVJjCJKQlU2w0h
 Ltb2bt8/+e9DSIJU4S22EAoceTgM5hTAf1k/UiKh8xg0NRY4U3NnGgVIuX4/VoUDk1V674vrSs
 hS4tQPo7go8s8cVyDfI5+0r/1bypphaq5DI7sFZ/YuPvM3ko4Bxmh2/f9C0MejmytAAAA
X-Change-ID: 20250409-livetree-fixup-0d7451cc3af3
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2258;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=bg0dLvbYtuuM43+BYi+mqGbURlWAsn68MGeFoEki91A=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBn+Q9z7a6uw9f8CKvHTuiarkoieVg6CyejbT4rn
 rSmhntluW6JAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZ/kPcwAKCRAFgzErGV9k
 tvTZD/99xa5hhtdLpMrIMMbyW71XjJVK6hmypPrMWw2Dg2H+kZk/8pBdMvTV+OSzdL5ARym+Jmy
 Xq5A04H1lMgebhyDOE6CK3QlA21ZgDzx5Q7xX+6Zknbc/jHUx839HYh0fKkPrjBNfDRqvCANKxY
 FiF/jaFDlu3Ede1puSZZ6wwmRl9WEtghnlXqDh7oziC6iNk9HfXalEFHRoosZcqS/V0mIcgDOps
 4DP6fR86j5BUdIkvPLJOfaDkNjMb4p/SvqWvjdqXrsTy25y5e6zcYxZJQwiFia+gld3OMdkeyXm
 B5sxXugz0PKU9c1h8gahWLQnYoA1gYd+P0lba5+0UnsdBg5RPshgiRbriIqQ8xu1DOqsWVeuVGc
 INk9rzL83kA8iOKEsBq8ZQJsopf8IECWGIsKiPkRVtEupm5DiLoRnq9AtTAZngsZGvU5drcnX7E
 SQZe6Eix3GjVOPgQZLOtdNsgdzcR/3bNWLQ9Hd/vTC8cgyMTqG6sRSpAyeEPK7OcypbO6CI2u8j
 cLhehBdHDcU/FBDu5VThVxC0Ld5uSn4KEn+D4Pp6LcZ0pogLZ3QHQTNhpE32Mf52x5VRJyni0+j
 0eKLobzX1zFrZb+FH0X5ps6O44hqrwcBZsAK7mm7WTu2RsnNt6kicZqZTUM7RlG7u9rHcIE4a5L
 h1rP/mOhwEBx9kQ==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
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

Introduce a new event to signal that the live tree has been built,
allowing boards to perform fixups on the tree before devices are bound.
Crucially this allows for devices to be enabled or disabled, but also
allows for properties that are parsed during the bind stage to be
modified (such as dr_mode for dwc3).

With this in place, mach-snapdragon is switched over to use the event
and some hacky U-Boot specific DT overrides (which had to be undone
prior to booting an image) are removed in favour of fixing up the
livetree (which is not passed on to further boot stages).

Finally, some minor fixes are made for the QCM2290 RB1 board, the sdcard
is enabled and it now uses USB host mode in U-Boot like it's bigger
sibling the RB2.

---
Changes in v2:
- Rename EVT_OF_LIVE_INIT to EVT_OF_LIVE_BUILT
- Pass the root node through as event data in EVT_OF_LIVE_BUILT
- Handle errors from event_notify()
- Additional minor fixes to mach-snapdragon/of_fixup.c
- Link to v1: https://lore.kernel.org/r/20250409-livetree-fixup-v1-0-76dfea80b07f@linaro.org

---
Caleb Connolly (8):
      event: signal when livetree has been built
      mach-snapdragon: use EVT_OF_LIVE_INIT to apply DT fixups
      mach-snapdragon: of_fixup: skip disabled USB nodes
      mach-snapdragon: of_fixup: remove confusing log message
      mach-snapdragon: of_fixup: update comment
      mach-snapdragon: of_fixup: set dr_mode for RB1/2 boards
      clk/qcom: qcm2290: show clock name in set_rate()
      pinctrl: qcom: qcm2290: fix off by 1 in pin_count

 arch/arm/dts/qrb4210-rb2-u-boot.dtsi   |  6 ---
 arch/arm/mach-snapdragon/board.c       |  1 -
 arch/arm/mach-snapdragon/of_fixup.c    | 71 +++++++++++++++++++---------------
 arch/arm/mach-snapdragon/qcom-priv.h   | 14 -------
 common/event.c                         |  3 ++
 drivers/clk/qcom/clock-qcm2290.c       |  2 +-
 drivers/pinctrl/qcom/pinctrl-qcm2290.c |  2 +-
 include/event.h                        | 18 +++++++++
 lib/of_live.c                          | 11 ++++++
 9 files changed, 74 insertions(+), 54 deletions(-)
---
base-commit: 45acd9d2d4ec84775d09c73aab75a4fd989beb41
change-id: 20250409-livetree-fixup-0d7451cc3af3

Caleb Connolly <caleb.connolly@linaro.org>

