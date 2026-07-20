Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F24C6C4452A
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 13:10:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4DE784659;
	Mon, 20 Jul 2026 15:10:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yGw4Y8NF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FE73847AF; Mon, 20 Jul 2026 15:10:21 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 391F3844F6
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 15:10:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4954aff6088so18886195e9.3
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 06:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784553019; x=1785157819; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0ovD9gI47fkHaVM+1HFBhx0h6nLwbNF/wLl+j2AOmtU=;
 b=yGw4Y8NFTGd8BH0cDl1nfDtBMAdPXlEUZ2isougYH/cd47SdIsqzGAOnQKnC3FBeWg
 a0PCwi4jUUx17t9P7xQGlFyLGehU3WZEQLHpH4MSLKv59wSeD3srr5TrzkXAD8xjedG/
 m/5Qd7Ti6trC8iJGsQjMcMBxvn8hHcXL/Vm/zoycUnGcYNIykzOM/RNWiRNdhep7wE+o
 63QJQlAgNHJA0F5hm5LgEDfyvK2zulsrsD7s+BRBoEoIaAv/BjDTqN5ETL+P29j87b4D
 05XIF8CjnoulRkqEVr5M5ydaY99PLmssq0anSIhDTQBS2R6KV9BaUxSP6Tm8fVCoevh5
 5Qlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784553019; x=1785157819;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0ovD9gI47fkHaVM+1HFBhx0h6nLwbNF/wLl+j2AOmtU=;
 b=XmJY24TqPLPeZe1AuAhwjPn60dNrSDeiqYTKcqH+LQ7QXj3OrqRkrTtw5aGH/L8cLa
 mxlmhk4NtmcslHUy1DKDwyInPvKMLiCXdqWL6YjZtpk/ylzQpVlRNwTdagH7oGYv9E4o
 ObiQzVqiuGftXE+o/j4woNR6RoeOA5+wQ0FfK/4HHYb40pieJWxGN2TER/OFK2E3l+D9
 bvaTgtNLSufr9S+cN9tzoBri01zzDzmtamDvOB9shH1jiFYdKKeLr5EM8c8PbelND01y
 adchqSSVF/w8PmOlK8NKY60f5Ja4RV2pxSvHnutNCUJWieC01bqiWE3s85xW1Mzpjel6
 OqnA==
X-Gm-Message-State: AOJu0Ywm1GTzX/vYwrZAKzxogwQzJl00B+xy8Wlr0mx+Eo+3CYKWIcj/
 a9xa6NXxWRBlDZJrgAhuAJqO2KMFimskgl4RHidvTMAI2iP/1imyWpthVh+xKUvXZ6Q=
X-Gm-Gg: AfdE7ckCglOaNmj4HhCmStnw7PL48Tt1mryQIOYALjgLRwKdI5guZpRVAAwqPqCCKxM
 itr+SPHk5xAQRDA1NKjLcm3fJ/ENaCzgzo2xsVkUwSpjssRfBowav4hNuWQu5QpN4VHG33/7a3W
 1oiJ9CpKAszgp8etiVEpl+kxDfJkfj5wOch23tMmgSWzTHJV4r+mvNAfgFpXoqQqmyr6q932nSv
 56eQ9QCr1mOVBi4IB7pq1/laAF52vuoxKhU5t0hga1TqIcONG7YZS02wa2twpLPWQZ3ESBms03j
 mf1+4M/wfiEmwdj1aTl+nlqt/iHdRNkgcRg1qGm+f8UKKsAXa8N818m6B9pAbaIj0stqweRRUUv
 iLBmxVSnW4i/VeyienTnmH+NTQxXdi7Q+m1WWTbqLszqWT5wmNobCe7+GgYskV1PHlibMiy1Bdi
 HHH2TDNKJdarUhzs1BvWQM2IUl2QeGYLvx1OTZjLHIB25a
X-Received: by 2002:a05:600c:6a08:b0:493:bcba:46a4 with SMTP id
 5b1f17b1804b1-4954a404528mr101789905e9.20.1784553018123; 
 Mon, 20 Jul 2026 06:10:18 -0700 (PDT)
Received: from lion.localdomain (p549d460b.dip0.t-ipconnect.de. [84.157.70.11])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4955fc42db7sm61531435e9.3.2026.07.20.06.10.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 06:10:17 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>, 
 u-boot-qcom@groups.io, Casey Connolly <casey.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Michal Simek <michal.simek@amd.com>, David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260511-b4-qcom-tooling-improvements-v7-0-0c06346e79a9@linaro.org>
References: <20260511-b4-qcom-tooling-improvements-v7-0-0c06346e79a9@linaro.org>
Subject: Re: [PATCH v7 0/6] Qualcomm: teach the build system to emit signed
 ELF images
Message-Id: <178455301657.1001378.15383299067683274944.b4-ty@b4>
Date: Mon, 20 Jul 2026 15:10:16 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
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


On Mon, 11 May 2026 15:57:42 +0200, Casey Connolly wrote:
> Currently the build process for flashing U-Boot as the first-stage
> bootloader on Qualcomm platforms requires a manual step of test-signing
> the emitted ELF binary with the appropriate settings for it to be
> properly accepted by the pre-loader.
> 
> To address this, let's introduce a new tool "mkmbn.py", this is based
> on the existing qtestsign[1] tool but introduces lookup table that maps
> from a boards DT compatible property to the load address it needs.
> 
> [...]

Applied, thanks!

[1/6] config.mk: support vendor generic includes
      (no commit info)
[2/6] tools: qcom: introduce mkmbn library
      (no commit info)
[3/6] tools: qcom: add mkmbn.py
      (no commit info)
[4/6] doc: board/qualcomm: update docs for new u-boot.mbn target
      (no commit info)
[5/6] mach-snapdragon: add kconfig infra for building MBN files
      (no commit info)
[6/6] configs: qcom: use mkmbn and stop building ELF files
      (no commit info)

Best regards,
-- 
// Casey (she/they)


