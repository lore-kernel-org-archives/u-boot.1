Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BE10D374A2
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 14:44:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79C5788FD8;
	Thu, 17 Oct 2024 16:44:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Q4wbFouC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3816589016; Thu, 17 Oct 2024 16:44:50 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62857889EB
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 16:44:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-431195c3538so9407785e9.3
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 07:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729176286; x=1729781086; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=I/BdCb8TlU5j0IIvNDNIZ1r46vRsfFYu95kd6yKdBEY=;
 b=Q4wbFouCeFEKpDczhbI9H2WU+M/QnjKeBZR5H37mbzysw4xkHZL1tDXl6IQlBtZMAo
 rHPHTVw0SvC+3BZNndSSs9XCkUGv9ptm4fGv5QbaDb0IKLx49Pqa5q8UidozXpLbN9yX
 D7BgVbeVZKiSL4XbS9nqilQQh2ILRsDGZlUUiSyOYWLy5JrC7AQKAZU88B88nk72Eb//
 LGpOe/RnGkUTM0QnMhSaPX7DodgPGgMbkOSh3+lydAQ4wecc25dEBCWRV0i7tlRQ/M23
 bg+vMAe4dDn1FTtDQKZ6uwKps2G7aviMrQ+YAVcVGsXM7Jp4qpU/Y+ZtKa/qCa5q5DPa
 NADg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729176286; x=1729781086;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=I/BdCb8TlU5j0IIvNDNIZ1r46vRsfFYu95kd6yKdBEY=;
 b=URvRcCvHijRihjrxQxXmrReVzd+tR+1kGhajrzJ1JSg2UXyAf9ELEmCcMbA9w44zlu
 DBoOsSrArCTsBlOOwcBVAZkBfXT1sGIfq3+SI2dbtzMtHx+8tqk+fvrYXtF+b3+29Tv1
 I62T/Qfs2FNNt+gqlMjzFrigIuuGsrb6DM7NBJuOg2liP7fpshi9mTk1yBzM5+QTtqfA
 TeFyaCdxgQnuTQ42byQWF90xh6Y+wGIhgcV5QNCNeNFDjCH177/Qn/bUXEHnPDG5iADw
 vy17ElTSI1T2qft/tFMJYaDCAME7WqzI156z8appxG802e3U9LIuwyhWkjH9l3cvHoUU
 K8kg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhPb0XCQWjooM5l689WsCPt6cJ8VQvYEeUOtDxCQLl1CJ/hQtsEzwgBcLtGnZKlHs+AK/wxyE=@lists.denx.de
X-Gm-Message-State: AOJu0YyIvYIIWUD3ayg0kGnJFbQ0oKXV6W7Ccz3MCBhObKm4coG0HrRJ
 GSY1ahPcnfD6aeCjp9vd31S2wZtNLHR6KLWnRyZ8i/hk2Jgxr72q0Mnhq8BLf5I=
X-Google-Smtp-Source: AGHT+IEsh7UDTHevcZVAcEcjDsT8IPuubeAxvdubtK/w/SO8IdVotIwLkBDju3+1WVoYpQLcs3bsbQ==
X-Received: by 2002:a05:600c:1991:b0:42c:a580:71cf with SMTP id
 5b1f17b1804b1-4314a384625mr65208695e9.30.1729176285667; 
 Thu, 17 Oct 2024 07:44:45 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43158c37fbesm28923195e9.8.2024.10.17.07.44.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 07:44:45 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v2 0/3] image: android: misc fixes when using on Qualcomm
 platforms
Date: Thu, 17 Oct 2024 16:44:41 +0200
Message-Id: <20241017-topic-fastboot-fixes-mkbootimg-v2-0-c3927102d931@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANkiEWcC/43NTQ6CMBCG4auQWTumP0TEFfcwLFpaYKIwpG2Ih
 nB3Cydw+XyZvLNB9IF8hEexQfArReI5Q10K6EYzDx7JZYMSqpRC3jDxQh32JibLnLCnj484vQ7
 QNODdVdrYWjurHeTIEvx5khvPNnukmDh8z3+rPNa/06tEgXXZu1qXolLKNm+aTeArhwHafd9/Y
 KkMvc0AAAA=
X-Change-ID: 20241016-topic-fastboot-fixes-mkbootimg-8d73ab93db3d
To: Tom Rini <trini@konsulko.com>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1318;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=BWRWCqbDQ5ziaH7PkDVvD1eCQ9adtJZVZYD3WseykQY=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnESLbfwXZ2s+En+bE/0oxL1HMNVodcrdzazHGDYWb
 3XtT38WJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZxEi2wAKCRB33NvayMhJ0ZxFEA
 CpEuGFG5PLIWOmhPlxFCV2p2o9O37KrrlN6U4K8ZeD/2TDRy6R5wy4ye+bVBHYSksZ8tfw0BMwcWt/
 G3a3xuKGCSe0RDf0mny1TMCvkMx4R/b+avEWktMZvoK/I4I+blXJa3MKEmgh2gfWHBIVbMNGQjbjz2
 nqtdhTgSifu8FT1vs13Kh03amyvDWj1h5Ps0vm0+ujgrMJ9OwoecJzqQz6+wIcfXHpsQELIcwIsygA
 fH4ZHW64uG1T9q/WcBAnGZOQrqDAVxNrnYpvFiCNNXyQK4qxfd3tuRo8GYBhUSHhPuEvK9EwXjSEVS
 Gkmblm9TDGrtZrPCsYSyRaUPCQ0h0t834ixVWENF5pIF4bFWRbt67S/sOEcl/Mwx2U/wQ5fv/svwFd
 TW6X+VmF+KaFkI4Uymqu9XvGIsUzD2Lb8MZz3QKNAXm05d6G7VIccgrDrv84wcVGQjgfjP4//jPIW6
 Hui6SckF292YUlZfKN4pxafvf4vIxJcPSxT+T3oiOtAI0SSKAfHwrHqd8HFqqNB9SmGDf2b2iYyR44
 joZvMv+77NMTGwlpdKJWNgLWbxgHl+o/1FK6igLIqiN9xiIm6JHbpq+0wdpSKMjDrzCJHuXPKm/F68
 xPLzWpSArtXpfUPALNP5+MRLmCmu7CRkDm1sjaw4/VvnvVyjpSk2z9sxIsOw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

When trying to use the Android boot image with header version 2
on recent Qualcomm platforms, we get into some troubles.

First the kernel in-place address can be > 32bit, then since
we use the Android mkbootimg, it uses the default load address
which isn't big enough to uncompress the kernel.

Finally, the ramdisk also uses a default load address, and
it should be taken in account like for the kernel address.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v2:
- Fix patch 2 prefix
- Fix patch 3 commit msg
- Fix patch 3 behavior when using boot image header version > 2, use the original ramdisk_ptr
- Link to v1: https://lore.kernel.org/r/20241016-topic-fastboot-fixes-mkbootimg-v1-0-94fd9340722b@linaro.org

---
Neil Armstrong (3):
      image: android: use ulong for kernel address
      image: android: do not boot XIP when kernel is compressed
      image: android: handle ramdisk default address

 boot/image-android.c    | 62 +++++++++++++++++++++++++++++++++++++------------
 include/android_image.h |  2 +-
 2 files changed, 48 insertions(+), 16 deletions(-)
---
base-commit: d5cab0d6adc26ec1bbd45c2fed101184d04454ae
change-id: 20241016-topic-fastboot-fixes-mkbootimg-8d73ab93db3d

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

