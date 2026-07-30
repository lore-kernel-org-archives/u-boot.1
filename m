Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52C7DC55164
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 15:31:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0506B810F9;
	Thu, 30 Jul 2026 15:31:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nzU9bOwJFvjo; Thu, 30 Jul 2026 15:31:19 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B2A31810D3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785425479;
	bh=sV249xyIdpZ0XPAZgxg7CXqMeSUgOGn0XIUVHXjKZUw=;
	h=Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=MbjHYeK7Et6VaPkZHPhqz0xATG4/r2rRN4XBUJljD+pRslzQpepIcH90YLA/nAoHP
	 tDOQIYm9NT5vIoJ8fqFJsSKSba8V6BQREjhhsHcJGy/fmEF8w5hsdMzIgnDWEdqLjO
	 UvUOLkCZJfN+kApzX+qWF6+PQYz26YbGMBFzNahy8t5RQAeZb04b4dIT2Q5aS60w4u
	 koGVA/E+Nd4yawr5PXx2wWGiXjmYoC/Vwl4x/5dCtgeTx19qp5Q0WZLbFkHh+JJULd
	 lK/iuqgZEy9D04ayqPkiOCIQpWx7gKFQGz1oYt9+lKaUzyMbnp3OFIQWpZuCyfqQGX
	 FJjBEAltGXARQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B2A31810D3;
	Thu, 30 Jul 2026 15:31:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id B822F27C
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 15:04:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B5279608AC
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 15:04:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6yq-5QVRjqaP for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 15:04:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::232; helo=mail-oi1-x232.google.com;
 envelope-from=anton@binarly.io; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 97251608AA
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 97251608AA
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 97251608AA
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 15:04:10 +0000 (UTC)
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-4ab8cb2a6e4so1341580b6e.0
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 08:04:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785423850; x=1786028650;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=sV249xyIdpZ0XPAZgxg7CXqMeSUgOGn0XIUVHXjKZUw=;
 b=IrgCWt8eHbnboBOFyk1HM0py5ZX++Iao/890shYVVG2RR0vSAB3zl7+eaN6Wvz3p4V
 avzBpi2AhiyUBmw2riw5Gm55iJ/ZrLVygZNyCDTWtTnn/r+doJHpnU+PmhOiMUFe4Nrm
 +r+0qDFUzmXQp80ReDfL72o4evzwYVw/ZVzehmIn63DHTNew4vvS+F2yEe+17saAMGHm
 K8ZzR6Ofy3gjwLuFW0q01cdUlj6htk3wPPKrhUoIoF2/lrGiCQppEB3svt8mKklL+hti
 l+y2zrjDZzvO37MmyKvqH38T+j0YzfMeuoPqII5zNcyWGJULyz0dWJYXVzo0oXgrDCg1
 1QeQ==
X-Gm-Message-State: AOJu0Yxv+084vJ0EsT8fm1KCsbgtFxFivM5GUO3+FPFa6NnVQezFdJXo
 hMKz844hXbFkX6TS5jWn158VTgDyndXtSXy0JBJWG+rrRHBwe9wrmq6P7LSY9gzhXXQ=
X-Gm-Gg: AR+sD1011epbRN1byR2jplGFNWot4opIUCP4nEJecd0ew6m/zh9kA3HREdydkgwod9e
 zOH/dfSi7p6hJsjQpC+g9R2WJs82rIkctMRtGCj0ppEsqbmSp8+hF4LAz+KviKQ0SU+lJdTkoRN
 i/4Dl9fyZyNkGAgdJVhmroIp2robrxWFoxBIjzC5VwLHykMW2/Qdc6L2zkqdqFMqdw9mXv3UYvt
 glEgwo1+OQh23g3oLl1xFyJPCEK/yhBqSMtkuCoGxN8V14ZrDN755Jc6WIbadU1vokCJjG1fUZK
 rjaXYP8a4i/BvHtDlnL21gscZhwu8+oRwmWd65Z6oJJLq3uUcaEFUQdQmDS2eIwN+zmzSIEjqWJ
 SiaXEFe6EQPl52P7rofap5Hppytjk4ZNLRXL4fXebj01JGfTY+RUjnKMjVwSgxOMtgOoimcrDE8
 u5RAofEIGYBrLS3WeL762Ke/MMOFd3GseEEJkcNVInhdL2SUpazWTjMFRZx9FRDlTLnThfuTErN
 gAQ6jyTQDMHafBd
X-Received: by 2002:a05:6820:4d04:b0:6a1:fd87:5344 with SMTP id
 006d021491bc7-6acbc10bc14mr1891088eaf.61.1785423849680; 
 Thu, 30 Jul 2026 08:04:09 -0700 (PDT)
Received: from Ivanovs-MacBook-Pro.local ([93.174.85.138])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1fa8bbc755sm78846966b.54.2026.07.30.08.04.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 08:04:08 -0700 (PDT)
Subject: [PATCH 0/4] fit: Harden handling of external-data properties
Date: Thu, 30 Jul 2026 16:03:40 +0100
Message-Id: <20260730-b4-fit-ext-data-hardening-v1-0-4a6b91e37b51@binarly.io>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMMQ6DMAxA0asgz7UUEiCCq1QdDDFghoCSFCEh7
 k5oxzf8f0LkIByhK04IvEuU1WeUrwKGmfzEKC4btNKNskZhX+EoCflI6CgRzhQce/ETltZU1Gp
 lbG0g91vgUY7f+/35O377hYf0DOG6bnTZd9l9AAAA
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1785423847; l=1835;
 i=anton@binarly.io; s=default; h=from:subject:message-id;
 bh=Bq5a0xy3NC1AidyYvaw+vBnMLz5UZgh7sORJaS6UM4I=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgLlci93RPwSlisH3PzSX3+CiC/xruz
 nbNSGHIKfmW2YQAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QFFyoBVVmsI4OaupOwWykxbRQ29P/3FAl7m+T1CMxw2skYYch1xosHaUm0ALDh3WENMBPt6vMxF
 oq/MINv8K8A0=
X-Developer-Key: i=anton@binarly.io; a=openssh;
 fpr=SHA256:OWnvXkgcqeWMXacIaCJR2oikuTmVTaSodreIHEJTWEc
X-Mailman-Approved-At: Thu, 30 Jul 2026 15:31:18 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=binarly.io; s=google; t=1785423850; x=1786028650;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=sV249xyIdpZ0XPAZgxg7CXqMeSUgOGn0XIUVHXjKZUw=;
 b=LXomkHXC6U9r9A4MZTNtfHAkEtiaVI01Zr8yJNqescfpKTkntb707mvIis61uSKL+P
 B+Q11EIJqd61DQL/uxg2Q8UPPdStomBUtoZqnYM140uu37dhdHi8BC50zA8nx1IMwrAd
 IjN9w9vn7CN8uczvABCzYBaxrqjbt19qLDY1HZR+qMbQbRQfDM5xAGsed/fQyw6fvQtM
 6iOxqeRlrl8XL5+DvjU97xCbfUpRfrILPvfQcQWjP9yDmWgpspg8qWtacxvgie9gE43x
 +T7nEQqD8037g5TKyb0F4nxipkzqlH2WzPpS4KzH/8WK9LMpVuool+d7/0uwHtoQsztN
 THLA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=binarly.io
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=binarly.io header.i=@binarly.io header.a=rsa-sha256
 header.s=google header.b=LXomkHXC
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
 test/py/tests/test_vboot.py    |   6 +-
 7 files changed, 206 insertions(+), 90 deletions(-)
---
base-commit: 94b349bd902d9e38e1846c157fadd9054c34680a
change-id: 20260730-b4-fit-ext-data-hardening-1734a9203753

Best regards,
--  
Anton Ivanov <anton@binarly.io>

