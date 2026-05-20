Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77149CD4F3C
	for <u-boot@archiver.kernel.org>; Wed, 20 May 2026 13:08:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F78D84843;
	Wed, 20 May 2026 15:08:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TNmD28Hs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7745884857; Wed, 20 May 2026 15:08:47 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B726847F6
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 15:08:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-48d146705b4so53671015e9.3
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 06:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779282525; x=1779887325; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wD6SIrnXBxWcESNCM6FGD7IUJzjO9tAa+RUC2PlW7/E=;
 b=TNmD28HsJ/8lomNxihkxsQUc+txI89e8Lst0bxyINGuqz1QPhAnLrzjhxDGS3OjeEK
 xF53DYU7+XQ7ZDR04mPc6zBv8VohOngZ081Uc0n0woxti0V6SXl6taWco5SJx40uRMZ7
 0qtWUvZxmjYaoLoELxj5P+grMexL3Y/y1TkdpiNdQTCYWvN/FfSzgAHDGawDqbicxwWV
 WxJorLVUx4xBcT++kcdniAAd0e9KAJ1gfKMZDMh3p05jXqn4nsGU2iKF6RLvlEQtAwJj
 w/I6W1JbL1NwO16wiEV0jJljJC5u1rzlzlboDGM6gesctyJY23NHxBfFz0u7wWmmgdWM
 NYPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779282525; x=1779887325;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wD6SIrnXBxWcESNCM6FGD7IUJzjO9tAa+RUC2PlW7/E=;
 b=hWOWzE3VSupMkZ/kWDfIme2O8UsDEY4RckmA83oLk4Vz4YuuA479UDiS51h5IY1WXZ
 IVZ+rCddnEU6vuq6nDMyTs6bOnF+b0Rk9vOgjxqFUsCjpyLDW3HPLo3RdLRks1pKKBqx
 3icj/gf6OnDd/IAahKMPm1WnehcM5zSICVeDQNv0jzH3KXnPjqGf/akWIPytHN2AISvg
 epKZPGivbt8ZVaL/wTgwyhBKZHg/+1wWUN3aEmcDCx27EkMGEbu16pR5EvnUK7wGnSBW
 pfMqHWCfHH9MlyvhNDRu5FmLiI8uD7XwgsFVcVlrP0zvNL0q7BxDaAulKa8Tk5yyEFe3
 DUQg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/gZvz533WkkXlmeeB1tN4rvBB62CZ8btX/MiogctGnT+DnPVg1r26KvAwCI17FphQRJBrGWiM=@lists.denx.de
X-Gm-Message-State: AOJu0YzgoY1sWnbAcRpppIII6QH2MXsd8JNWFKlCN4ZcB3KG5Ugyv677
 qlCpT+k/M170ZMJ814VUE4l4te2qvLe2RD0XCJ/XrRChcvlRwSZmuFqdEwI6fkmYx+336f71nM6
 YrvCK
X-Gm-Gg: Acq92OGA+hRU7RBA/tsUk1k4Gu1X8Sxk9kYzgtV1tJJS/iykC/QztftC4XTdMS8oZli
 hb7PLB2pC6vYYyBd6grGLtcNII6G8FyKBXyNd3RZhQDyy8NCRxFWwYC6DnUdVKKitoaWuAYqyoD
 jA67Gt3SIMN9SVa7YA03uqz/1JpuuHTjmJ9JOwL13uwT3bb5DAn1S5kZkBI/oaITAN/ezUBIWqY
 9ZNL8ZxBL9axyizt//7dwzizZAW4sYq1cNVcsT1sNppjThg714SPJm9ECU4T7hoyWMEcesObac5
 F8nVN9HgcCcPYKd68WK3DprloUucfHdvc0ecPy/RJAWUqK/hYcfAtJRgHtT/QcFoeIKEbrtjWn5
 1tryZMQ+HYJi0+AK59gvnkQMdxYCzxj8bWJHDcOjYeFdQqm/Zi9ZF1t+VCMNTnkO9SviP8WJc/4
 Ty5mSeu2neywCUOzZO4v8Lv3phTbObLgUOYUVlcbmYl8VCRFfpCLqM7UI=
X-Received: by 2002:a05:600c:c167:b0:48f:d410:6065 with SMTP id
 5b1f17b1804b1-48fe66138dfmr374843165e9.29.1779282524630; 
 Wed, 20 May 2026 06:08:44 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe5694fcasm371316615e9.5.2026.05.20.06.08.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 06:08:44 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Prashant Kamble <prashant.kamble223@gmail.com>
Cc: Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, u-boot@lists.denx.de
In-Reply-To: <20260518060915.45607-1-prashant.kamble223@gmail.com>
References: <20260518060915.45607-1-prashant.kamble223@gmail.com>
Subject: Re: [PATCH] nvme: fix command ID wraparound handling
Message-Id: <177928252410.3008922.14994022267796044360.b4-ty@b4>
Date: Wed, 20 May 2026 15:08:44 +0200
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

On Mon, 18 May 2026 11:38:44 +0530, Prashant Kamble wrote:
> nvme_get_cmd_id() returns 0 after cmdid reaches USHRT_MAX,
> but fails to reset cmdid itself. As a result, all subsequent
> calls keep returning 0 indefinitely.
> 
> Reset cmdid when wraparound occurs so command IDs continue
> incrementing correctly.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-ufs (u-boot-nvme-fixes)

[1/1] nvme: fix command ID wraparound handling
      https://source.denx.de/u-boot/custodians/u-boot-ufs/-/commit/d6eb327828a384c3bf325de05633a77f66688f53

-- 
Neil

