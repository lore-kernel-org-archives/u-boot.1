Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49A32C5AC80
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 01:50:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 164B440929;
	Fri,  7 Aug 2026 01:50:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 152PyNjCZH6V; Fri,  7 Aug 2026 01:50:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1955A40925
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786067434;
	bh=UEVeJYUs1lOQuh9SxRfLlztWN9Xru0i6ho6Dc8bDh6o=;
	h=Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=kf2kieBazEvvqHIAzO7m26FPKUHRf82HKFrCULWWekclYk/kArR+aXw8P4mDgt12y
	 FpHkbuqYP6kU9TzfxSQjUXbIyf6h4djeJM5aEbhk2gQEbVPzyalPzz8aaBmoXAOD1D
	 oAFIm/RFUoHJA3Ux9xnTjtlQ96jZs+z6vOoudz5KtjkUrd726L851aLN8s144OqnDw
	 sB3CFPrCOB+SA3kD8eNBiMFcg0YrzgY/JPn2kqoULcdQzG2xuoXKe/Rn5CAbr8jemP
	 b+hqP5AznzXDmIubW6Thio5lRUVT2E7LNtO3XQ/3lhW0bb0q0ydHCGIxyxZ9FUGwHU
	 Tl5ILq64nVJuA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1955A40925;
	Fri,  7 Aug 2026 01:50:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 26955218
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 21:29:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1862D60849
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 21:29:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zhnXAMAbCarB for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 21:29:40 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::835; helo=mail-qt1-x835.google.com;
 envelope-from=anton@binarly.io; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org E33A460848
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E33A460848
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com
 [IPv6:2607:f8b0:4864:20::835])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E33A460848
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 21:29:39 +0000 (UTC)
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-517dc520840so19376441cf.3
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 14:29:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786051778; x=1786656578;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=UEVeJYUs1lOQuh9SxRfLlztWN9Xru0i6ho6Dc8bDh6o=;
 b=rvh2hlAuwwXaqJ4HYYxvWs3e4fCYQBZVM2/TTV6DW3DyFaqmTxJYUOeUrSW2flGFah
 n2/waFI35c2xdumV2h8JAMyQcIXLShwJQOUSBx+awkkdlSyHvN71cqM+D5bksU9RLst8
 di83IE1BcdBSqubGYiPz1eoU/xIxVLbSSFn/NkYSSWMoE5x5HfuRJl6nwAn5es+STJrm
 MhAWPbHbce0WOFIqBHKMKVFHOI/ZH40ztMTLmOONjxwd9vukkkoqkzz10vE3/wMxcqqQ
 Kr0JvZOtXMMbP4FgW42N1e072hE8sx5uDx3kqxJqaMM5gaE0qGt0EeAZiXC57IVApu5v
 a6ng==
X-Gm-Message-State: AOJu0Yzx0lF6rT8tMUK83JL4Um0ChXil0V5gzBaksBDOhv0MshBi01i3
 abodgCe1Vt1TJq3HdXl03wU8qojW0pVB5xD8Ly/LEsPoNGd+wtAFWqjO3LhrduwcWrM=
X-Gm-Gg: AR+sD10CBKr8MbYUf6D+EGT9IfHvI/dCA09ZC3cqNL2rFvjsvB41TIWaLAOEkrBpNaz
 AbiMBLWBG4wRgbA7EshR+U+9HO1Xl+M+t/6W6vXw0/XGrlW0wmgyAwMW3mKnPqAXFxeYdCSNPeI
 TL9F86/EG1IQ+u/aE41Iy1/W7kFQoJyQ+EHOXUm20kgNzg2xbz7axrjtilV6KQ0vLURG9blC8e2
 3W21auG6AVRI2wHkNQfjcvlZ0Sx3OPJqpXE2QLLwlz0BzE9gy5EezcbOT+ZFps1HH4hlZ9HAUmc
 YaQ80m1NTms+eI5myyBr9rdvZXiDOBg5sXOXnmjiLAyd5B1j6DuxB6ukQQNcUZIDGorGXCSzIhN
 Mn2CRyBGiGINiufOlKdn3pO1Uoa18HhBRiONFJXTTBlpI8Iz3/HSU/1bsdNuix0hqvS4PAe3PKU
 82zjm5YvfmnDuomG7x/OmB64gZE8070H7zXwt12qJNJ0FKTmEnmmW1vlWaSgZ8cmYvsxRTsPzCS
 kfViTeHujBrz4bD
X-Received: by 2002:a05:622a:4d98:b0:51c:1006:a024 with SMTP id
 d75a77b69052e-52ce62017f7mr219260751cf.43.1786051777997; 
 Thu, 06 Aug 2026 14:29:37 -0700 (PDT)
Received: from Ivanovs-MacBook-Pro.local ([93.174.85.138])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c207b4fffcdsm2071466b.46.2026.08.06.14.29.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 14:29:36 -0700 (PDT)
Subject: [PATCH v2 0/4] fit: Harden handling of external-data properties
Date: Thu, 06 Aug 2026 22:29:18 +0100
Message-Id: <20260806-b4-fit-ext-data-hardening-v2-0-b181cac15c29@binarly.io>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42NTQ6CMBBGr0K6dkx/gAZX3sOwmMIAY0wxbSUQw
 t0FvIDLl7zvfauIFJiiuGWrCDRx5NHvoC+ZaAb0PQG3OwstdSmtkeBy6DgBzQlaTAgDhpY8+x6
 UNTlWWhpbGLHv34E6ns/2o/5x/LgnNekIHsbAMY1hOc8ndXj//EwKJORYukqRsa5Qd8cew2u58
 ijqbdu+UTBiVNUAAAA=
X-Change-ID: 20260730-b4-fit-ext-data-hardening-1734a9203753
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>, 
 Simon Glass <sjg@chromium.org>, Anton Ivanov <anton@binarly.io>, 
 Daniel Golle <daniel@makrotopia.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Francesco Valla <francesco@valla.it>, Anshul Dalal <anshuld@ti.com>, 
 Randolph Sapp <rs@ti.com>, Binarly Research <vr@binarly.io>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1786051774; l=2287;
 i=anton@binarly.io; s=default; h=from:subject:message-id;
 bh=heDQ1s0HCG4CJ/sGjfCfmqRsBmRErJ88aTw7FiLh5MI=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgLlci93RPwSlisH3PzSX3+CiC/xruz
 nbNSGHIKfmW2YQAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QNIaE2NFUh6klNaummbN6caibVewVbhjjHu88MCssw6cpHtWkl4JGbA3co9VRR8ZBWDFbalU3Cj
 pVOiyAQ35ywk=
X-Developer-Key: i=anton@binarly.io; a=openssh;
 fpr=SHA256:OWnvXkgcqeWMXacIaCJR2oikuTmVTaSodreIHEJTWEc
X-Mailman-Approved-At: Fri, 07 Aug 2026 01:50:23 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=binarly.io; s=google; t=1786051778; x=1786656578;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=UEVeJYUs1lOQuh9SxRfLlztWN9Xru0i6ho6Dc8bDh6o=;
 b=Qv3vQ4KAuegKa8kMGvxD/N6+AknUnCQSt7JZ445ddbq8iBuy9Lw8eh0InepPHnDNV7
 PcNX1CM9tjE2HNGDot2/5wRGAz6jFhmebhxPwkDPJp8KbIcAdMoV+PJ1vKPXWXY9N5od
 VKZtCeMd76T2fFTNw6WZgcVyW8TiiJ2H6j1iWavY98U3WNtgrnMRjahK630ZSweP0+Dx
 dwbeDvSZhWDjjRVCoeKEY2f7EgkmOZ1Bu3is1oxaVbzaP5FKXVLfJHtEOy0i47cuv9D7
 mpHCgwZE1p75OYbt03nqYJB1nfCkSmr9uz4HI9d/R9HOOK5PG9Y6vNnGOU4k+CHy1Nh7
 3NCg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=binarly.io
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=binarly.io header.i=@binarly.io header.a=rsa-sha256
 header.s=google header.b=Qv3vQ4KA
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
From: Anton Ivanov via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Anton Ivanov <anton@binarly.io>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

The data-offset, data-position and data-size FIT properties are 32-bit
unsigned values, but were read through signed int. Also, they are
excluded from the configuration signature, so they are attacker
controlled.

Patch 1 switches the accessors and their callers to u32, removing
the ad-hoc handling of "negative" values in U-Boot proper. This
transition was discussed and agreed on in [1].

The SPL loader has its own copy of this logic with the same problems
and fewer checks. Patch 2 factors out a test helper, patch 3 makes the
SPL offset/size arithmetic overflow-safe, and patch 4 adds the
addressable-range and FIT_SIGNATURE_MAX_SIZE bounds check that U-Boot
proper already performs in fit_image_get_data().

Patches 3 and 4 build on each other and on patch 1, so they are not
intended to be cherry-picked individually.

[1] https://lore.kernel.org/u-boot/CAPWaX55XWFLcMGRuaUuXXn__MX_UG4J8QTd6rvXZmJ4WSOCy9w@mail.gmail.com/

---
Changes in v2:
- Patch 1: keep the 0xffffffff data-position and data-size test cases
  instead of dropping them; they are renamed and repointed at the
  "FIT external data is out of bounds" message they now hit.
- Patches 3 and 4: no code changes, added SPL code-size figures
- Link to v1: https://lore.kernel.org/all/20260730-b4-fit-ext-data-hardening-v1-0-4a6b91e37b51@binarly.io/

Patches 1, 2 and 4 carry Reviewed-by: Simon Glass.

---
Anton Ivanov (4):
      image-fit: Use unsigned types for external data properties
      test: spl: Factor out external-data FIT property checks
      spl: fit: Harden external-data offset and size arithmetic
      spl: fit: Bound external data like U-Boot proper

 boot/image-fit.c               |  29 ++++------
 common/spl/spl_fit.c           | 122 +++++++++++++++++++++++++--------------
 common/splash_source.c         |   2 +-
 drivers/fpga/socfpga_arria10.c |   3 +-
 include/image.h                |   6 +-
 test/image/spl_load.c          | 128 +++++++++++++++++++++++++++++++++++------
 test/py/tests/test_vboot.py    |  10 ++--
 7 files changed, 210 insertions(+), 90 deletions(-)
---
base-commit: 94b349bd902d9e38e1846c157fadd9054c34680a
change-id: 20260730-b4-fit-ext-data-hardening-1734a9203753

Best regards,
--  
Anton Ivanov <anton@binarly.io>

