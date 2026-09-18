Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64C87C982DA
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 11:44:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 688FB40B79;
	Fri, 18 Sep 2026 11:44:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M8bfqJ78jsM3; Fri, 18 Sep 2026 11:44:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 7EEE440B70
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789731882;
	b=hXRs5n8nJjCPuVhXMpMo/fiUCXkO+ltSflgf3wNRAE8SEBovbyK5NgoZ6AdQjtqxky65
	 TOr2NWXf9wAoRrOf6GN11vUiNzONXsk9Zf726NMsk8CIzvfpcWVrQWuo1rGb087zNrS68
	 NXlXHsE2UqIMBGR+RNIeJwT5MdzUJ7n3+EQpurk0L1+qlZ+BO+WcVL9r7nV0+5ogypzKZ
	 ZiuX0Vv1xS5Wd+BMlna7kp400vONVBqtEYzwe8Afdpa+bIbMYetgDd2CvJPjegJnoxKBp
	 sqJpM2f+EVwtVMDkT4d+ir7Cbh96ZQbTe0tUdmZeO/A25PRHjJbZ2CHxbk2oGbfUFsA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789731882;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=U60N5uGq7cfvt6HgFu2FXLUJSf0HfxNw8DpqNJXioh0=;
	b=GVFwmRhMHK17lxssY5Tvoxt2Is1Ti5qob8CAztGx/fsiO+KePNB9GFJpV9S4k3wMf0MJ
	 YqZtICofp0+igdJ/u2rrD4eLV1HnOAK8XHXiv1adHPZusn0AlaJdIluVFHAPBzB4Txi1R
	 r944lOgTObYMFa1NE7Kfsx/FxU5iTbUJpTbZZew/EKYIWzqJ3tg2F+ZzWjGrrJHk36Hbr
	 TaH4zxTx93IjDkMTwQX4xGgra36fv/SSxpau3T3ckG6QwphPrlS+5CvVG/h9EfOgRaijL
	 OXVL8JOtMnAIA4Ag1StnNsKKsYU/2VkfgkyC8m6EyiA3XAPkverBb1uCIYt56kjYv+w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789731882;
	bh=U60N5uGq7cfvt6HgFu2FXLUJSf0HfxNw8DpqNJXioh0=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=htrQTGsU4v6eun1zwBFxYpjs60RWh0hF8U6FlnERQI927pgFsY3/ZYd9RDTXoL9x7
	 N4KdUBWYEkLiVh67vcLIORjeOQRee/OUqwauHhDJyktor0LzHEEg1axHO/3LVHxBOp
	 4cTVjZosTBPfzPiv3GYTBsbvl7vdTsXyNW7iNxusITmn+wXrFUoaVjLjNaXKyTy8iZ
	 4vpbmpvgTR9UIS7fj8XWv6XddW4SW6QSbi2Ai+2H03ZH8aqkSahCV8IjOOmOW0Rll3
	 WifFMyXBLxiunWhCNJX/krKQVegPJrXSKjOca9eFyICeTAaf22F9evdifiOEzx+DNI
	 rCTPB3Ye8uMQA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7EEE440B70;
	Fri, 18 Sep 2026 11:44:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2B40B23F
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 11:44:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1CC608127A
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 11:44:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m5tqwz4lNdUK for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 11:44:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org EA1018125A
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789731880;
 b=TKmJY4fcZu5xkKk2iZQfAae+ftUWoaaoPLi6f0ytEhB5lEwVj1AlBtCbSPqhJPjvasdl
 N/TEz2tONwhMddHJ3iK6V8VqNgw4Ags7ttUtxmCj6B8mbjg56ihISYjyBFq6SZTHeG5Mw
 C/qEdbnOODCCAKNyM2juXwaAXHvEWFFmaRJz04O0sUMkMZojfUq95MS0W5S+s0sjgSQ3B
 rgImgIpIyyu36jyvwU9XHW6+uMHfQypWcMbUVNAaWy/Ae8UUtdpOZg9FqQXi64h+PoTzR
 EMPg2FSs+5viDEhiHdJNAfZDlH2kSvdvfXbXTBZfVDo64IpnFP0pZ0HhGA8fbnHzkbg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789731880;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=U60N5uGq7cfvt6HgFu2FXLUJSf0HfxNw8DpqNJXioh0=;
 b=SIzv7jgFOjvUfJpDdPSuXd+R63AYgQbbdGxY6BG7SUKxM/TdVVOpvroKfKw1q/saAL/N
 COLhntIGT7nFzduqx8IzgGknwARCb35C8z0MikhA8opYR3w6Uj1q4GJCPajatcUtDXV0x
 pM8jWgMBjHaZshoieun3Zqs7lzl9SiRNImoMMA5VFPJsROj1GmJeeGexclnL3pUgDSyer
 70ldCqnOaAekD2RDjIDnnp7sjbfc6DB5H1y5f0Hld9XD+kVkrK1A7Ap+LuREYxQNG3t3P
 V4g0osabZgHiwuCWbtda9PQaLsfLgDKHTWK9nD3WIqIebWDSCBDXW+zhCWkS/IYtvTg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=flipper.net; 
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=picjwrN4; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=picjwrN4
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EA1018125A
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 11:44:39 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49cd38e0f79so4119035e9.3
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 04:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1789731877; x=1790336677;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=U60N5uGq7cfvt6HgFu2FXLUJSf0HfxNw8DpqNJXioh0=;
 b=picjwrN4zjWfnCgKqnVgYYUnvOzK1RZazKVz2arOEpyOGJYtAUP0hM37UklPsJ3H0B
 zi6gLEZvWzmfg1FoOdVxMN6W+zeEgmbfL6gKd+3vGg+YkTCkWuAfShMlv5nQ7oGJ/Ld1
 v55JY4viMYw3cln9XtzxS6RIRVsg9U/JfJh1nUt3HaD/uOo9lWEJ+S/ELH0aAOlmNDgR
 WgH3K0QkeDdxwKdUib70UrqZTN6DZXsQGzfnmLFZzkuLBwFe3pF0pZBblMIqFmzie7Ok
 8vjcZLl+yCD4RfYbhKQmr9bwieaR8zdvObeMe+9DL5nRYet/j51EBxuKsm/qYsZYflxb
 0zzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789731877; x=1790336677;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=U60N5uGq7cfvt6HgFu2FXLUJSf0HfxNw8DpqNJXioh0=;
 b=rsuZxXTrUW5KR2qYvlDJUMgosFPBBRY7cJe2/34wSqYCbR2drZE2xM7+1e0EjKdziU
 1Tfwsnjue0ZD6zCS/wpK6u+ed9eSt44O3Xx1l4G350raLym+wJqqvIbJskNM5yESWshZ
 2a2YVrq4M2tHME3dqohzweW/5h51feBTRCDsgYIJMqz4kRpP7odBBb6aA0wKN9wL3qTR
 uxr9D/UopbisSX0XuaUmHJhh1JDFxNbF2PV17yOPa9OKP1sW1GbQYY7wXXbFOpPRCzJ9
 NhFM6Wl1Lvar/yN6b72vMFMCgkX1jlv34RLkGt7AFDRM4NkjLqyAMb7go4drTGlykAi6
 cjkQ==
X-Gm-Message-State: AFuF++n2vbTNq4ubLLxoiTTsI6qGijb9KEKhvNOfP5N60/1fYlqodHGt
 l9i/ArmYA8o0jgwZVtaihqGluC3csQd0FXn4YoPpWpSsW4wD5gW82dxgoyfh+AgYOh4=
X-Gm-Gg: AYBFou0I77kEiAhsMYEDDhbTzpZ+aZB/t/63NsAFNdJopRJIYyh1OKzIYRPX+p1Dp7n
 U6a8CgcsCiayw9HBhaBUi4/8YJOgW/Fj2sXxNxnIMRSKWaU35ENJy3meN1u0B+H3PWD0CA0UfmU
 pIQBgBVEs8r4KlYbZIhg7INVTrDhiDQGXoawWCVKCezbsaRsCmDPlzjdmiur6zFIHCcoINo92iw
 en02V+0CzPFJ0yNEtV8EJwHi1BfqY1YPKeivc3zSvmX4b3uYa3HnnE7ss/hn1qmNFxPNWbpo+LO
 zHSmmVreEnfNieDX9SRepyiJkzlP720u/4TQuVj7UnYdGiKcJdFHaH2G6sCVFio6nkB/dXpfcmA
 kzMfUm8fUg8x+tj20KMvxC8QC3OwSevlsHKdoBrnFlnE4H6Jrtd8O46SSViUwDJfpgsovRBCyE7
 lfxEgH1j9aWexR9mH8WAnnB8Sv1xeXFHdtupVabyZ/kJtR2i0VmMlYu1ld3NpHSlnnw+Cjtfdeh
 9cMzsb8pKNyhF7KfdkzyYt77izguhtTv1pF9hbQydQXJegKuEwD
X-Received: by 2002:a05:600c:8709:b0:49d:870:7a69 with SMTP id
 5b1f17b1804b1-49fc573514bmr56298615e9.12.1789731877184; 
 Fri, 18 Sep 2026 04:44:37 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-2-51-220-108.alshamil.net.ae.
 [2.51.220.108]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fc7d46399sm63549565e9.12.2026.09.18.04.44.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 04:44:36 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Subject: [PATCH 0/2] lib: Allow unaligned memory access from decompressors
 selectively
Date: Fri, 18 Sep 2026 15:44:33 +0400
Message-Id: <20260918-unaligned-decomp-v1-0-59909db61470@flipper.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ6DIBRF0a2QP5YEDG1tt2IcKDz1GwsGSmNi3
 HtpOzyDew9KiIxED3FQxJsTB1+gK0F27v0Eya6YalVf1V03Mvt+5cnDSQcbnptUGAFtNG4XQyX
 bIkbef8u2+zvlYYF9fT90nh/AW+iDdAAAAA==
X-Change-ID: 20260918-unaligned-decomp-0efee141e754
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Michael Srba <Michael.Srba@seznam.cz>, Vincent Jardin <vjardin@free.fr>, 
 Cole Munz <Munzzyy1@proton.me>, Quentin Schulz <u-boot@0leil.net>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1794; i=alchark@flipper.net;
 h=from:subject:message-id; bh=k17FrSCDJfRqr6nAdOZEI3WVHpRZmuHWOynZKroleaQ=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWStVVENYYspVs74t0Z054NJactNV9s4PgxROLMuqc1UV
 f+h7OW6joksDGJcDJZiiixzvy2xnWrEN2uXh8dXmDmsTCBDpEUaGICAhYEvNzGv1EjHSM9U21DP
 0EjHWMeIgYtTAKb6y3xGho9saxpd5Wda1kyoYDO8nfPKbXaGmSkr89Sw+p2LtnM1djH84dpxZML
 H2VZ+zk8Cm/9FOTk0FrT3etw/ssk+xPX7PS4zPgA=
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Some decompressors rely on wide unaligned loads, which get very expensive
on strict alignment architectures such as ARM due to the need for the
compiler to reassemble each wide load byte at a time.

On the other hand, some ARM platforms such as Rockchip enable the MMU and
d-cache early, making plain unaligned loads work too.

Current Makefiles force the compiler to work around the unaligned loads
unconditionally, which in case of e.g. Zstd in SPL on Rockchip degrades
its performance by a factor of 4+ compared to native unaligned loads.

Add an option for arches to opt out of the strict alignment flags for
decompressors, when they can guarantee that wide unaligned loads are safe.

This improves the decompression performance and reduces the SPL size due
to fewer instructions generated per each unaligned load.

CI for this series: https://git.u-boot-project.org/u-boot/contributors/alchark/u-boot/-/pipelines/1322

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
Alexey Charkov (2):
      lib: Let the decompressors use unaligned loads where they are safe
      rockchip: Declare unaligned access safe in the ARM64 SPL

 arch/Kconfig                   | 27 +++++++++++++++++++++++++++
 arch/arm/cpu/armv7/config.mk   |  3 +++
 arch/arm/cpu/armv8/config.mk   |  3 +++
 arch/arm/mach-rockchip/Kconfig |  5 +++++
 lib/Makefile                   |  3 +++
 lib/lzma/Makefile              |  8 ++++++++
 lib/lzo/Makefile               |  8 ++++++++
 lib/zlib/Makefile              |  8 ++++++++
 lib/zstd/Makefile              |  8 ++++++++
 9 files changed, 73 insertions(+)
---
base-commit: b8e0086b585791a771416ce51b58ce0097bc0b28
change-id: 20260918-unaligned-decomp-0efee141e754

Best regards,
--  
Alexey Charkov <alchark@flipper.net>

