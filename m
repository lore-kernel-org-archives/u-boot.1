Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B743CA5FD4
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 10:05:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C7B6C81205;
	Fri,  2 Oct 2026 10:05:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d0Uka5cXwAqS; Fri,  2 Oct 2026 10:05:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 9E75380DC2
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790935502;
	b=ikMg/Xn/fn6XpvKYUh1wV9Egb6E50tXRaXusQ6AP3lxF9EAj4qw/76uOoIpI69PM6LsK
	 gQM0/KVjB4BuB+9k2egKMaInQ3uVJCmV82bVNsKt2+vbMnw3qy+RUJy+Zr7aFAOkpphIh
	 VCoRZHybrJUGJUFyXbYMSHEMuHHDKYaXdr0ZK3NTN3T4LcAl1NZVpRqMktwu1pfUle8mA
	 F3Xu3qKfsVXQPXDEIyUcVWbT2AumlgheabMZQNKJN1nxUbOTLVyFxdSImyhRvAB3gCUa0
	 ixVTSo7kSggXUTO92oTRTNowT/xZvMnaQAHjmAf8ofYbx7L0XINwbEwBbn6x0r0F80w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790935502;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=cUbePSj1ozg1KhGCVKGgIdcasd20SVrlLKTgc4iHBT8=;
	b=nDZh7R9GzOztRDfNUG6EwR2BSl6aQVDCtnpgP4MmtcWyRWYLlSkRbUmS1XhUPnl4rL4T
	 Qv/ztfma1u9ZMqJC6IEPB9iNmJEH9BEsr4CqBt+86u3C+lAjMmvJ3uy85vrlz1wClYvCW
	 i7Lrz1bCKb3uTIX3wYYDMr6seWURFlOvVz7j0FRwFQrtiESYADJY+bhDhZuglLCX5UWEe
	 WozQKrg5PeE6DCXSKNSV4y2VPWdQIRRbWttzwFX4UETr0Cn2Bg2tbIJuHYAX/hurTvltB
	 C/B50D9n/2v8rfbV/gZWWpMWzFZKqwoYly9cAwhQE117nG69VdSKUnffPwqDcvXuDzA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790935502;
	bh=cUbePSj1ozg1KhGCVKGgIdcasd20SVrlLKTgc4iHBT8=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=hch7idx31MXlBt2C0F7gxUoB7IBS6EtZQsW+ClnuTIlLWMsya2aID+F6xKsdRWM7y
	 hMoxXIUJlvxsDYHeR9GLvhfsqdKouokWV2S6yuYP3pkbxhQ4bZaCV4Yb0FljUYSKxs
	 VWXE6dMIEEwWc2GAOaNwygtftX5SgUK4BTQYegdN1p5HW3vU5C26yEeKXh4PyKiuX2
	 FdUSjUuZO39cna2KcOFsAp0m/ARnH3ciexqlAqO5NaJzhIedi6nD8Pweg0SBzSeCTH
	 RotpzDLpJYJc8x0dos/IUik1vwrtMQ2GXwEE5SMZM63WnByashAKHM6KkngNq6ofDq
	 wmp0B+CKnxlqg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9E75380DC2;
	Fri,  2 Oct 2026 10:05:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id E53F5282
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 10:05:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D758D40BA0
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 10:05:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3dSLPgucm76L for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 10:05:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 8D49A40ABA
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790935501;
 b=IBjnrvJ/fdlIQ3FYteXtSoXadjrSKINtl00LEAmE7cCH6FxXU9roOs1DsjstAHgfIcSt
 oPIDs5fKWPuIeYaJOqIucKlyfm40xWHBMZcHAsRrQBeyAlFlRUyyF+vesUhu0w/Xpcq6P
 d8Vc8TvcESOe0swfD1qcRczKAVk/hkpFGbs+pGGJW9jLgHRM6kzEeg9jcETGLkk5tb9S2
 GJ+gIoyxRAQWOvkIfm/05PMG+7/E93vXEfZ1Ptv1gaIHZ1kQbYtCwIXkatENq/aFnCE4M
 mWSf2dKFUsqCbykAv5ySiJps+9wMjZhtWHZLHm78VUnsgItMHXZm2JXDl+Ko7rp1mvQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790935501;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=cUbePSj1ozg1KhGCVKGgIdcasd20SVrlLKTgc4iHBT8=;
 b=QgOmLKU8/3lIgTeRloTpZg9aaaVtNuSxU4gKa359THJhKz5PsfvkI8JfEmn96Soj5zQz
 AWbZbvN+SKs930wt7GgEaUbAwmqDMMWlb9BGHYCu+eMqsbyrIF6dQJXLFN9cKeqDPR//a
 QJPdMCHLnb1H2Em4JB/oQbilQWLWpCeLQUaToB5pQ52ZFx6LD8+YFNEEjp+qTMekoSUnT
 y9EdVQ7VxbvUtgBiDZr3WQentxhSGJ+Q47tPWlx16qVftBqah2xQMdt4wIIOcFXUGWsRl
 8YzbQjMwLz79iGtBAwPNczTdUZoU1d7a+59mWLNq3PLdojHA6S44ItZk9xQduQk4qRA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=flipper.net; 
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=wQqEOJN1; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=wQqEOJN1
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8D49A40ABA
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 10:04:59 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b912d391aso56919975e9.2
 for <u-boot@lists.u-boot-project.org>; Fri, 02 Oct 2026 03:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1790935498; x=1791540298;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=cUbePSj1ozg1KhGCVKGgIdcasd20SVrlLKTgc4iHBT8=;
 b=wQqEOJN1GH1Q4S5uxOh3qxFsxEZRYivmCa78raCQd2OyngMrwtnGrToCm+nRE6FStw
 AeLVeQMtgeXGF5phiiuRQ8lo0fAgt9RF8qO3XFyQLfIjybOPAOQwfOaW2KhDFQMq44fu
 BlGkpQTgTWdYJHoj0wGpDqa6NQjC31ELDeBgqp3Gz0vAkCq0tVNpw5QbpSM51Ali2L6w
 2NjW+A0w/tTKqOxbOvwdwzRHLzSeCsL+IAukD6/hj09wAtaKaAjCgzFIPV8+JTut8cIH
 2zjFJdPE3HxNwUR2eNJo0O+fVcBANwSbxf9snnmnZs3ueBQH4S/ilVm5t76mN4UP8gLG
 /2YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790935498; x=1791540298;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=cUbePSj1ozg1KhGCVKGgIdcasd20SVrlLKTgc4iHBT8=;
 b=Vk1J5sfusy4jvzUOsN3+1RvodjtpQn8gw8aPoAT7kQqjcIXAnmkXMTGPKlk+9UwdAs
 u26c+Jx7phTnLwk/dMaTkrqfBXrY8XksUwwByvkKPOqY3Z+XiRMRIVpcNwi85ojGVe/v
 SsYnDqRgGO6L/97fPO7a2ZubEtEZKrify8KP32FVmv0uGXUBT5nfk1kd0UcBidvF17dz
 Onat6Ev3rBpCFSAyZzu1LryolUMmWnM/rHqfb8W8EfasHGAAmmY+cjK/xL9AYAjICapS
 J+Un3UGT62PBJaotPCvYq6BvY6HZcRuePyZKtWjH9pw8CEd37MTAr+rzhtI87cA5Nirh
 y3og==
X-Gm-Message-State: AFuF++m8lQWsIRsnk1ifZcvW0RqSRpEak98mN5pRi7esimN1ngZHvOlO
 o/8Cun1x7HPYdR+DxQw9qbtBWph9k8Yq6LEV8H6KcqpuoVuOQ2ulJVb+qco13hcSSKI=
X-Gm-Gg: AYBFou3CLk42CaGVp8JK1f1BEi23fCSN9ptUanjrvySER+oUq6xMn6qG2si8khqHn/g
 yPv0360Mf91i5F0qaLTFfbUSRGTFoPb5mnSBdEc3dcTruUZN25oLJiErFQHy53oBHJI1odtM09X
 kM8HgKT9YQk2hAlcOihkbZTSWmcKZHhSNY+kQqMl7mqjK8wCExc1f3QlQtD02RycD3XYbb8q0lc
 uZ/+fO18v/8zWrn4NaUqG/qpCnWmGe0Pa127D25+EvaYOQIx1a3SkxkMMjmUBpuzLTEWKBE5FGy
 stZjUvlTpVttGi786n5U8EfvYAO/S509gMNn19kQ+LMmpMh5aDYXBU7xaT7Ux9HrozOSSQWkkKz
 N+RctdJNbbhFR4sSticl/AUZAJsLK9MsD3ykirMJ5KqVJZSvvBWsPQ5QO2iPT1VLsQPg5D+9OO0
 aTNhm1yJEHiFxVnaO0y6KGPBDixoQfdGKzIU0/Qqp9QvXmyho6s/2YVeTRv5JwunsfGEQSgbbqQ
 BxcD6A4hhyiS5289yYscS4hjTR6
X-Received: by 2002:a05:600c:8b4b:b0:49e:799a:8969 with SMTP id
 5b1f17b1804b1-4a0276b9c4cmr38597175e9.30.1790935497613; 
 Fri, 02 Oct 2026 03:04:57 -0700 (PDT)
Received: from alchark-surface.localdomain ([5.194.93.183])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0280ceaf0sm72887985e9.12.2026.10.02.03.04.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 03:04:56 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Subject: [PATCH v2 0/2] lib: Allow unaligned memory access from
 decompressors selectively
Date: Fri, 02 Oct 2026 14:04:47 +0400
Message-Id: <20261002-unaligned-decomp-v2-0-675466ced78a@flipper.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32Nyw6CMBQFf4XctTUt4WFd8R+GBdADXIOlaYFoC
 P8u4N7lJHPmrBTgGYHu0UoeCwce7Q7xJaKmr2wHwWZnimWcSa1uYrbVwJ2FEQbN+HJCogVUopC
 nCe0z59Hy+0w+yh+HuX6imY7OYfQcptF/zs9FHd6f/KKEFKnWUps6U0kui3Zg5+CvFhOV27Z9A
 e7vN5bEAAAA
X-Change-ID: 20260918-unaligned-decomp-0efee141e754
To: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Alexey Charkov <alchark@flipper.net>, Johan Jonker <jbx6244@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Vincent Jardin <vjardin@free.fr>, Michael Srba <Michael.Srba@seznam.cz>, 
 Cole Munz <Munzzyy1@proton.me>, Quentin Schulz <u-boot@0leil.net>, 
 Kever Yang <kever.yang@rock-chips.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2438; i=alchark@flipper.net;
 h=from:subject:message-id; bh=SlCM1R6zQ06kAfxANBea6oFnlVFYWdgGXCNtCfFv9cQ=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWTtbzzRymdcbOcR91i7Rjfx7Ou2juNLdL7ZN7wRNXLZr
 LvddM3djoksDGJcDJZiiixzvy2xnWrEN2uXh8dXmDmsTCBDpEUaGICAhYEvNzGv1EjHSM9U21DP
 0EjHWMeIgYtTAKZaxpWRYUG5I1tN4zJ3oZur/857yfYja+qS9by7rZg/nHyy+mTv/NkM/8sVQk4
 fE7n7e9M9I44Up6VLX9ul1TG+8ZueonVpgpa5CDsA
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

CI for this series: https://git.u-boot-project.org/u-boot/contributors/alchark/u-boot/-/pipelines/1431

---
Changes in v2:
- More caution-forward messaging in the symbol name and help texts (thanks Tom)
- Link to v1: https://patch.msgid.link/20260918-unaligned-decomp-v1-0-59909db61470@flipper.net

To: u-boot@lists.u-boot-project.org
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Alexey Charkov <alchark@flipper.net>
Cc: Johan Jonker <jbx6244@gmail.com>
Cc: Casey Connolly <casey.connolly@linaro.org>
Cc: Vincent Jardin <vjardin@free.fr>
Cc: Michael Srba <Michael.Srba@seznam.cz>
Cc: Cole Munz <Munzzyy1@proton.me>
Cc: Quentin Schulz <u-boot@0leil.net>
Cc: Kever Yang <kever.yang@rock-chips.com>

---
Alexey Charkov (2):
      lib: Let the decompressors use unaligned loads if platform allows
      rockchip: Declare unaligned access safe in the ARM64 SPL

 arch/Kconfig                   | 35 +++++++++++++++++++++++++++++++++++
 arch/arm/cpu/armv7/config.mk   |  3 +++
 arch/arm/cpu/armv8/config.mk   |  3 +++
 arch/arm/mach-rockchip/Kconfig |  5 +++++
 lib/Makefile                   |  3 +++
 lib/lzma/Makefile              |  8 ++++++++
 lib/lzo/Makefile               |  8 ++++++++
 lib/zlib/Makefile              |  8 ++++++++
 lib/zstd/Makefile              |  8 ++++++++
 9 files changed, 81 insertions(+)
---
base-commit: ed28577c31d895fa766ffb71ec1c35c4b39db2a7
change-id: 20260918-unaligned-decomp-0efee141e754

Best regards,
--  
Alexey Charkov <alchark@flipper.net>

