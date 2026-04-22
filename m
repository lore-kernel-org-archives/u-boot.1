Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D9D9F94CDF
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 08:10:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A6D0840CB;
	Wed, 22 Apr 2026 10:10:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="d0rjBgjJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E29068352B; Wed, 22 Apr 2026 10:10:07 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C91E583936
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 10:10:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-48984d29fe3so41154355e9.0
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 01:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776845404; x=1777450204; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cTNd1u1hprCUZMJL2yb2q3hUIxgPirYwrESwBNPSHR0=;
 b=d0rjBgjJUtSCBaGRCk1WFO7VQNrGX8tucC5j+jQOSO/SIK8bqiAbf9Mdf2lP03FA5j
 lfE9OGijqiyUExqzIt4EdNnAAaw3ZNvCLF3bEQViSZYFt4Gxk+VVpaHeS683HJKXX40e
 RzC+BQBYSvpbcdE0X8ADWT3CegEJmAkwbsM7/ecQKYq6Q/6jwGB+tashEOYPon7JWU0X
 pt1Cf7mFNiFujcXWqUFT9FJ/0yB7agP0LgTkpOd2XQyeydHvNeilcYzdGcjXl9pG6CYs
 iP7xdxRk5FtGw8/3bwoUdVP6twvYSjTnXB3eAKoG5Gputve82+jqcryAoPLKGrHXvp2I
 XnrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776845404; x=1777450204;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cTNd1u1hprCUZMJL2yb2q3hUIxgPirYwrESwBNPSHR0=;
 b=ALGYzom/toNBEt77inaNFi1Nir31NzAUyFUAeG+onuGcuOXmBoeuT5tWQPBzIxxWT4
 VNUD8eYtgCVv8Usq0gybO9cPt/um8O5Qy+dvJWs4RaMRLyKB+tvulllu1VG0489dA5JZ
 /PFXgoZn/VBT5lU0OCSMltsrk55sP08TJzpdPIL36/T1oADnpRFOKja5Mn+2V97ZXdQa
 yF0sn/FX+l0GdNTO+DJexWHx7pjbn+V85gaToeRIueTBjIB/o6b4jKuZWSbBeKdbuzIK
 POzXRVpEDRh8uImjH3zqVuBr3XX5PXkGLdPe3SW8VWDCfFpf47QJX99jLMq2PHhfP9pV
 f6pA==
X-Gm-Message-State: AOJu0YzY9whShzobVVaMuAbikGkiuiLsDIAcBIzggDwv80bhQO50zZ4R
 317qKbm2kjqA+MyDZtrCcFhHNzW70DjHs4VwlIkPTlTJ8X5u1m6Fg/4Qlbda3uebjmk=
X-Gm-Gg: AeBDieuxcDoINK1WMcirIL5S6RyEr/mr1UVBCTq9G3rKmzxTYZGcFgqlQoDDkndIIl3
 LET+H7NJuypiSRoSg8L3KaTtCroFo2H1iJHtdbAFgh4EE/6CapdtB9QPLnZCMfCRYrVackP27i9
 ML/sWRtynHWpHEAB2PCqlGH5JRg+7I4FCYnwzyQb1wwAQv/NOwiO0CrzSfzzgvff3AvtYgpidAi
 tKHt+BKmcJQUwK+nGR1stxws/nLF1v03RPYhUTUwcnyf0MOsj5IHs9L2Lx3lnVQaIT17K4wmGkK
 f0RoRR0G0OEZegNWFgF6FwxHXcD+RyFrVzujpps9TRCz/tBiQjU9WZT7SI9SK+f5SYLoxPeL4Xo
 lEA4B3DE8ugQ6ud0Guyn2jamrzdLQw/jHXq71BhUEWraxPd7Qrzi2irjjZDxA1UKsNavqeXHkDY
 OYm0PZcDvjpiEVba9NOWHX8sYHkCX39HQfUwcvfGfYbtOGTRe20DTzFuNgrkXxnQ/pJg==
X-Received: by 2002:a05:600c:4895:b0:488:ffad:6728 with SMTP id
 5b1f17b1804b1-488ffad67f4mr151063895e9.19.1776845404077; 
 Wed, 22 Apr 2026 01:10:04 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc0f8188sm453974945e9.2.2026.04.22.01.10.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 01:10:03 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Julien Stephan <jstephan@baylibre.com>, Michal Simek <michal.simek@amd.com>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Padmarao Begari <padmarao.begari@amd.com>, Tom Rini <trini@konsulko.com>
In-Reply-To: <20260329231151.332108-1-marek.vasut+renesas@mailbox.org>
References: <20260329231151.332108-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH] ufs: core: Fix heap corruption due to out of bounds write
Message-Id: <177684540351.2674178.13365031936092342071.b4-ty@b4>
Date: Wed, 22 Apr 2026 10:10:03 +0200
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

On Mon, 30 Mar 2026 01:11:36 +0200, Marek Vasut wrote:
> The ufshcd_read_string_desc() can perform out of bounds write and
> corrupt heap in case the input utf-16 string contains code points
> which convert to anything more than plain 7-bit ASCII string.
> 
> This occurs because utf16_to_utf8(dst, src, size) in U-Boot behaves
> differently than Linux utf16s_to_utf8s(..., maxlen), but the porting
> process did not take that into consideration. The U-Boot variant of
> the function converts up to $size utf-16 fixed-length 16-bit input
> characters into as many 1..4 Byte long variable-length utf-8 output
> characters. That means for 16 Byte input, the output can be up to 64
> Bytes long. The Linux variant converts up utf-16 input into up to
> $maxlen Bytes worth of utf-8 output, but stops at the $maxlen limit.
> That means for 16 Byte input with maxlen=32, the processing will stop
> after writing 32 output Bytes.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-ufs (u-boot-ufs-next)

[1/1] ufs: core: Fix heap corruption due to out of bounds write
      https://source.denx.de/u-boot/custodians/u-boot-ufs/-/commit/c7ebdb9871dfd6e170a6dfeee39be234c37a4b53

-- 
Neil

