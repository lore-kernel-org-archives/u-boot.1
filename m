Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0647C5DF7D
	for <u-boot@archiver.kernel.org>; Fri, 21 Aug 2026 05:56:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5E46C60896;
	Fri, 21 Aug 2026 05:56:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 87NjzSZVwZ_g; Fri, 21 Aug 2026 05:56:51 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787291811;
	bh=5wvnHJzDaGZ8imVtpoQ6hFBs6WqjFXhKW8jtAiwaN9Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uCRKvXvX5yVY/SGElHnm0HA6f8gy3k1RQa/OQcMptZaUeiNmOs/XEvxgnB2mdOdnq
	 pPVDCQvATe89MsP3l1cjYjabRG92fMVXvAkAZmZ6o7FAD7ant1X2b13JOBdsIoS0Mg
	 spzNJ1r6gc+8wIubar338yXzOS7l+HXX573+gnSHqPkGoPTIji6CgLiRbctfpfrnim
	 gNIUu01kmUOX9+IuUhaMDYse6IStYf4ZNQZvvK8uvxZSnSE6miMFMZPE47sDvSKe5Y
	 HZEsxODHB9qCrsuvsdF17UxNukx4XkeiyYjm/kQTfRBNXncMjPmZGzS95hgtV8Ga35
	 OLiZmC/7i3tmQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DD667607FB;
	Fri, 21 Aug 2026 05:56:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 76F61336
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 05:56:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6045E400B8
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 05:56:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4p6Rxn1WbB0W for <u-boot@lists.u-boot-project.org>;
 Fri, 21 Aug 2026 05:56:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::631; helo=mail-ej1-x631.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=Me/NTtrn
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 73A81400AD
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 05:56:47 +0000 (UTC)
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-c214321dc32so125121766b.0
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 22:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787291805; x=1787896605;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5wvnHJzDaGZ8imVtpoQ6hFBs6WqjFXhKW8jtAiwaN9Q=;
 b=Me/NTtrn9CEdiF9N6BdM9Ang1icwseGBRwRJ3DkCtxW+xwefsle4ks7QjZpEd72dOa
 kdCHLpYCZ2kty61TejK6DCtiw1/X2hzKle1pgYl/hMj9cQeXloUx1a8zVi/fL0v4/GpF
 Qb4yjQpYob9q2xjAUTuTJYYzQGNuEEIMxGUtpmBatSqXdGlSNN1YZR6hRdesDRHk+Ho0
 J1sY3eH2RvhAhEBrQCGwUGLopFK449tWV8ZyUQzXvly4adrN5HjDULd80a8ny8AdmH8Z
 NPoIF0qN1mFzoqX47ZMW70JPcb+4YYkFRb9BomFb4usH7WZOIIWIbeiatBt1F2WxIvJt
 gSHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787291805; x=1787896605;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5wvnHJzDaGZ8imVtpoQ6hFBs6WqjFXhKW8jtAiwaN9Q=;
 b=m/wJyYmLxySsExt1mOOFP2OzSn/+lhmA8esNAStcvS9dShpkO22sxKJmYIxAlIq4ZC
 U93TRGiAFJhyqEERuF1ycvOOkRnvS1lgUuIShNVZH4HmM7SLy6+9CtyJ/Ie+rIoVaqle
 JWeqyQlRMZYEhEscvwDG8gTMawQwfrJDZofhCi1BOo++o8nYCdJJ5tIRTkcAuwUExR3D
 x9ji2BjWynJ18O9qjvfvVFyylrDJ0Ia/2zP0EB5VPNeJxuGKeQJ7XM9wWiSfAdNMDWEc
 ftQmBVHhXelsYoLiyCJB726GpnSrrh0iZR31m/KM1Ukzf3B1XyOLcL1B0wGw74YDv2Tm
 9dfw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqe8D5FI3eYmt6FPK/eHsYFO0ePJegRSVnnRavGlyXWh1bellPnphLhFWkheHZ7F2tRepXkG7E=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YyW4rxn8ArQvdgUVMDjFka8BlziO4kF3b/zaJn9mD3iXUDpUvPW
 8qOmxPTLCyPiwk1+MJ60jds2nF8I1Ki7c0Efs/6cAc7R2agPLvLhAZ3M
X-Gm-Gg: AR+sD13QsgfdthPKD2HFiAvRcogyoJcDUPDIKt0R2cVX7s+F3xFvCfzEPcqQd5vpRS3
 RcUGSvgUh1A7AMr4RRDTA172Jk/WDotv0cou3bIgJnqdYRm78r/NoHJhFWY50CADsQlHibfuF3Z
 VJauVfVSPFwPIKNFdmjjjX60aMmGjlEKai4D6KiLen0KvQrYbeJiSCL57nnmFBAjJ8LBj13HNwy
 LGFtnAco0KrTfavY9B3bQ9xSrjgp109+qJ3Nmv25vVCBGhx62hYHAzV6aMfGR3e+xNUO/ZzzTgC
 RiIxcQVkV5a91RlCdyj2q+n+lnkIKrhegzmMqGvOBzg0UydamSyunEIUNeO4CFSP2IY/FwPQToA
 b06S+/29Ob4UafEaOCPXiY8HJcQUqAUsYGlUaN7nxSiQTE2NJZVCAWVAVaEJXat2N6MLG6MsAws
 Z8sWHtPwrnQo3vBkvW1eiMQt3EgVVoMOaYY1JdEfxWPMiKtPzEswqq8HBbJVcTJ/CgBg==
X-Received: by 2002:a17:906:4fd6:b0:c21:3fa7:5a6f with SMTP id
 a640c23a62f3a-c246a72cb16mr378309266b.24.1787291804738; 
 Thu, 20 Aug 2026 22:56:44 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c24589d98b0sm299848866b.6.2026.08.20.22.56.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 22:56:43 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Mehmet Fide <mehmet.fide@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v2 0/4] usb: ehci-vf: take the register bases from the
 device tree
Date: Fri, 21 Aug 2026 07:56:42 +0200
Message-ID: <20260821055642.1176044-1-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <2cb90777-c31d-43f7-aa6a-b11b7dea9f4f@mailbox.org>
References: <20260820071511.1036506-1-mehmet.fide@gmail.com>
 <2cb90777-c31d-43f7-aa6a-b11b7dea9f4f@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hello Marek,

Please forgive my eagerness. Your reviews made valid points, and my way
of answering them was to fold the answers into the cover letter and
post fixed patches right away. From now on I will proceed the way you
describe: reply in the thread first and let the review settle before a
new version goes out, with per-patch changelogs below the --- line
rather than in the cover letter.

To put the answers where they belong:

- SPL without DM_USB (v1 1/3): no build of this driver can take that
  path. drivers/Makefile builds usb/host/ for SPL only when
  SPL_USB_HOST is set, and none of the five boards selecting
  ARCH_VF610 sets it, or CONFIG_SPL at all. The removed branch also
  does not compile, which is how it went unnoticed.

- The two Fixes tags (v1 2/3): both added in v2 2/4, thank you.

- fdtdec (v1 3/3): v2 4/4 uses the livetree calls throughout and the
  driver no longer includes fdtdec.h. The alias of a phandle-referenced
  node had no livetree accessor, so v2 3/4 moves the body of
  dev_read_alias_seq() down to the ofnode level; if you would rather
  see a different shape for that helper, I am happy to adjust.

- -ENOMEM from the regulator lookup (v2 2/2): v3 2/2 tolerates only
  -ENOENT (no vbus-supply) and -ENOSYS (no DM_REGULATOR, which is the
  case for four of the five vf610 boards) and fails the probe on
  anything else.

On applying the feedback throughout: I checked every return value the
series handles. The five DT parse failures all fail the probe, and the
enable path fails it on anything but -ENOSYS. The one place a return
value is ignored is the regulator disable in ehci_usb_remove(), left
best-effort on teardown as in ehci-mx6 - say the word if you would
rather have it logged.

Best regards,
Mehmet
