Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D8E8CCD1BF
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 16:57:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFEA783893;
	Tue, 28 Oct 2025 17:57:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xJlA5CAD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2AC38838E7; Tue, 28 Oct 2025 17:57:34 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A56DB80422
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 17:57:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4770c34ca8eso25196985e9.0
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 09:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761670651; x=1762275451; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lRd5JJ44P6mLbhxRB0uZqGUnK9WtuNDoegNIzlRUeZo=;
 b=xJlA5CAD36gwDboFFzpmRYqMjj64jtAGwpck/8xeLIV/qS2xxXhL4E1IZyjziJX7sK
 gweqIeO/enCy+b0kThwfuQuKy+zBJgFn044Lemvl24zdCqpYDMCtCETk8KJtLVlWLilM
 EEdjQ4DreZKqV/dVS7bTEe6qu4bZbGXDNuNbJsHmBsMVo8yBBzV/yqJaBb+/vxc0ccLP
 oHSoKyy7uPpRXa8WU8GIdKAz06zpkDtEPTnhOcaxdPiRr1sb5FPukdpjQ6bRMYXShVB1
 VbklObT1Zp3i2achdVtBJ+Mr8JMgiOUOL4F0P4HWFI32w4WQqhHdqswJB2CBeOJKbI/4
 Wtsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761670651; x=1762275451;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lRd5JJ44P6mLbhxRB0uZqGUnK9WtuNDoegNIzlRUeZo=;
 b=SsEuLDhPzhCnf214MEfFgS2jTRsbR1Z2Qs+DoRu+Xu1zI1cnBBUbX31PkjtzvGHMU5
 8TPsqpS1DWFpptSEsNjYDdKdzfOBnSgVPJWErb5aKvAFoYiBLoOBXWZns54fjyeaUTI3
 5qCnRILauhbKNMkLw9T3FESi4G1zi+lpm1kKDNantw6oEenLtpt55v/wWuS2RCcyBARj
 1bDIDvsGsnVLFeCqorGkllEyJQ128V5uvw6zTf0vSKsKaXt2/zo7uPDEpSfXdUPguHA5
 5SKn82Bo438nXeTqYJ5iAcAmSZTCl82YbK4/4YGzLdnqTRlv36eowWaMxZsu+SjJSnPs
 wV3A==
X-Gm-Message-State: AOJu0Yy3wJZtZMI0w7Yh72kwKg8CSh2/7h9qabnK2t4gJkVhho0MJz3V
 9DUwbAiWbk0OFPvLJ2Wq9YLgo1YS2S0i4NHmYHn13foa9ZLzMJbs8ylRTaDF6p4dUws=
X-Gm-Gg: ASbGnctc985bgNAd/5Qg3sNIwNtG86C9k/q8rRZfhbFgjjWRmL/hv6LI02eZV4Rsr5I
 +hU+Sv9z+3yjqy24CBpQmFGPRNdtWnOrewVo/wbWExlBAWrISm98FZBwJOmWcFB2UUu1qLHjv+0
 WMzve/SaCZE8AVwREwIQo9ALFOmJ+0+kS149mkYajxF/F4h6RyMdj3cE5Q1kI9cAq7t7xl9ax2z
 Hdp6D0nCTIIQx1CD6t3t750x7xbFApfEKHEEqBREsgZZJcTIJ1BcLNnhBxwNjp6VhyAVZ+bWzf0
 pXh5cCW4Mv+zkxB+tlVoSoN8ObkXRjoSM7tyDj4VKRwClU9j2p3BHhifZSkjwn+KcMOfPhf3dg6
 PzBhpvXHYfpjR0/rSQ5h+NMgCXkY0e1ltHMauM9ED2Wc0GFCijWFctlbn4dcqNmX7Az1lG/02DV
 2WlWr9UpzKL+Yz817kiBOe
X-Google-Smtp-Source: AGHT+IGFBd6jvikbH+9aHRX2I6qTUfzatjHU5tmGo7jXUqgfcEpXdoBxU8MJSLMKf8XC00L2nM03IQ==
X-Received: by 2002:a05:600c:6818:b0:46f:b42e:e3a0 with SMTP id
 5b1f17b1804b1-4771e3df22fmr528285e9.41.1761670650950; 
 Tue, 28 Oct 2025 09:57:30 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4771e222ca5sm1971495e9.15.2025.10.28.09.57.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 09:57:30 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Michal Simek <michal.simek@amd.com>, Neha Malcom Francis <n-francis@ti.com>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>, 
 Tuyen Dang <tuyen.dang.xa@renesas.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, u-boot-qcom@groups.io
In-Reply-To: <20251028142335.18125-1-marek.vasut+renesas@mailbox.org>
References: <20251028142335.18125-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH v2 1/7] ufs: core: Keep Makefile and Kconfig list
 sorted
Message-Id: <176167065011.4104072.12154709648586611964.b4-ty@linaro.org>
Date: Tue, 28 Oct 2025 17:57:30 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

Hi,

On Tue, 28 Oct 2025 15:22:21 +0100, Marek Vasut wrote:
> Sort the Makefile and Kconfig lists alphabetically. No functional change.
> 
> 

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-ufs (master)

[1/7] ufs: core: Keep Makefile and Kconfig list sorted
      https://source.denx.de/u-boot/custodians/u-boot-ufs/-/commit/9b37b6001759c2727568255de1169c942b9aa185
[2/7] ufs: core: Fold ufs-uclass into ufs
      https://source.denx.de/u-boot/custodians/u-boot-ufs/-/commit/ea97b856179338a51cb6fd3fef07680e5e2c662a
[3/7] ufs: core: Rename ufs.c to ufs-uclass.c
      https://source.denx.de/u-boot/custodians/u-boot-ufs/-/commit/1de63f1be48b6af0d2e90cdadfa9c0d3b9abf3b7
[4/7] ufs: amd-versal2: Fix indent
      https://source.denx.de/u-boot/custodians/u-boot-ufs/-/commit/6104ae290ef159fbe2be1025f86b0584ad6beb5d
[5/7] ufs: Call ufs_scsi_bind() from uclass .post_bind
      https://source.denx.de/u-boot/custodians/u-boot-ufs/-/commit/067c1b03328267961816c76ff474c7312917409c
[6/7] ufs: renesas: Update Kconfig entry help text
      https://source.denx.de/u-boot/custodians/u-boot-ufs/-/commit/4ced7e726490911de9a632ea13a55b6776c2e210
[7/7] ufs: Add UFS driver for Renesas R-Car X5H
      https://source.denx.de/u-boot/custodians/u-boot-ufs/-/commit/3351fe7ecc1ac717c23e9ad2c16e1fe4a7b84fd2

-- 
Neil

