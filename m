Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0791CD8C92
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 12:52:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4EC5484881;
	Tue,  9 Jun 2026 14:52:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="o3drWlAB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F134848A9; Tue,  9 Jun 2026 14:52:50 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 258D1846D3
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 14:52:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-490cf322ed0so18786155e9.1
 for <u-boot@lists.denx.de>; Tue, 09 Jun 2026 05:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781009562; x=1781614362; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dI/tvPTc/pJN+EEUPvsfTUwB2soUpTR/KYE6chae7hU=;
 b=o3drWlABrPIV2NREmnBnqIIPlkMUTbqzAbozcXJcEOG2kppQx51pyyvR6AnRrwmWCS
 OVykGiYstmGQvGLYDateQaojak6JJrhixWqImZMLAtEA4joqg3RNUzGxorbWUGnPWXop
 X1OB+RRBFtLs3+StREWGngWRibqlnXSErucS2TKlmZqY2tji93gKZ2AGOmJ+MEyigl9G
 TToEmARK+Zbe3Xm9H5euLj9ze142OcjdCsCpWkB1qw8hTvTeNTthr6nPL5FIVjsMCq1W
 GPv6LJ8GbOa6Di4tCcuBZ4XU2qTZNfUUN4J6w0KP6MvDUqv5azMkoCPUn7nL5f16q3zl
 mrVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781009562; x=1781614362;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dI/tvPTc/pJN+EEUPvsfTUwB2soUpTR/KYE6chae7hU=;
 b=msTKt8ZJJ+w1KHp943xiMzxfSysEewxOigL7N6xKlPb3janXvnBvxTf4u7HX7E1DS8
 QG21V4n/xH2/GfG4QWscbhyfZCLeprcM4XOp3ZCOCSWk9qVBNpNBu5ESWQQ3V1Ds76T0
 v85hFDsg5hynZwhgpmOGAJIr6RH0GXI879kvbymgErV89jkbe1YpqkWTlmsPj0pucYkt
 GGpja7LOdvrvfnS+2vLRRZP5vS3J7XKGXD+T2NeZx64ZXr3TCcF/fztgxCFMayvryO0a
 yV4oRymO9ELm6Jc25Ky+gSGH8jSbRq84jTL1HSdgm4nZsVcoW/rvG+dqbLMcWCkj1dY+
 a8sw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8ELNUfNA24qwxntE+m1YI/3VzV/uTDHWkanhCfQkiM1zZRte3Ewgbj6hirHs5fZqFAnCNTtpQ=@lists.denx.de
X-Gm-Message-State: AOJu0YzbJnFxHo/D1UluHOLBR/t5cnymD5hTAxkJrkrDg0hwF+cuRaCY
 8jC3TxI7MgKUnjTD95pX90izZT6UF2VkLCvLyj7nM87Y+qOBp+CjcNAWUQc4lq0cjzI=
X-Gm-Gg: Acq92OH6rvzn0KFWdTc8IptfzeRBTVsAojvFc/nX15J+f3t/tA/gOyehBJhYT0vToyz
 a4CvdsFGOpQVAmRpLcR22dD+FMKU713vQJteDgiC8anwgomdiWGt4cQx23IDUy4bU0/TyGXqa58
 kgpo0Da6t6zaSgccSF6EsfR6QjCevECphtndIvBDkMLy+IvtTyqT9a7NIpdCbOvs85rMc95O2y+
 gUUHhHy7gWVNU7DCLIGpvZp8Zn8J4KvTlCv1Vjxke3XPrr2j5Hv7gWBmTT07p0xU8icUJK5i6xU
 MgI6fNcH//EAlJB2GFayDDuIWmOqPV0Wntjh9KMFF62kY0HDkP2jJbnfdN80p0D+WJ3fmNMZITA
 EL5TNUT2g13mhPojPsi4klErp6kOzkrnPa/jN4ooPpk9zL3L/0XTOuuIBCq97u+S4eVNqk6NKLw
 murPQUF/7VbeQmZ/lN290egYg/uo1qv4+pB3vBSp3+NSf7cSJUzl/MC2s=
X-Received: by 2002:a05:600c:19d0:b0:490:a964:14f8 with SMTP id
 5b1f17b1804b1-490c25ab04fmr319032015e9.8.1781009562324; 
 Tue, 09 Jun 2026 05:52:42 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2f2710sm48720129f8f.14.2026.06.09.05.52.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 05:52:41 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de, Federico Amedeo Izzo <federico@izzo.pro>
Cc: Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Casey Connolly <casey.connolly@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>
In-Reply-To: <20260523-qcom-ufs-regulator-support-v4-0-45639533b06d@izzo.pro>
References: <20260523-qcom-ufs-regulator-support-v4-0-45639533b06d@izzo.pro>
Subject: Re: [PATCH v4 0/2] Add regulator support to qcom-ufs driver
Message-Id: <178100956144.2045983.11109608424395038949.b4-ty@b4>
Date: Tue, 09 Jun 2026 14:52:41 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.1
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

On Sat, 23 May 2026 15:04:23 +0200, Federico Amedeo Izzo wrote:
> This series enables UFS support on SC7280 devices with UFS3.1.
> SC7280 devices with UFS2.2 were already working.
> 
> The root cause was ABL leaving vcc-supply regulator disabled on UFS3.1
> devices, and enabled on UFS2.2 devices that worked fine without
> regulator support.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-ufs (u-boot-ufs-next)

[1/2] regulator: qcom-rpmh-regulator: fix regulator mode mismatch
      (no commit info)
[2/2] ufs: qcom: add ufs host regulator support
      https://source.denx.de/u-boot/custodians/u-boot-ufs/-/commit/8591f01705b513ab51d6762bbabeaa0417033a95

-- 
Neil

