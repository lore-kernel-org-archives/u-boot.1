Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4949E10F6FB3
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 15:01:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AAE48407E;
	Wed,  1 Apr 2026 17:01:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hh+8H36g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8749F84011; Wed,  1 Apr 2026 16:52:41 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94DB983F7D
 for <u-boot@lists.denx.de>; Wed,  1 Apr 2026 16:52:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ernestvanhoecke@gmail.com
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-43d01d6b50cso2575210f8f.1
 for <u-boot@lists.denx.de>; Wed, 01 Apr 2026 07:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775055159; x=1775659959; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dYmzC4qzJCwpf9crBTUi+Fh0te/S41UEwAC7h5ZDbQk=;
 b=hh+8H36guCVw91Bdttllos+7hOjCT1sUEKm38GQdnQfRrfh+yD2PUrszwDI5B8TeY6
 GzQFoDI7JiL+HrnsCcCAxYdwRc12bmT4Cdqi3UyVcnmVPONhoxlqmUTka1t3n1XjbviB
 vdZwNN8iP+Y5RQi53LhVneYrU/IEzUHKkSTynU+ieUAz3XuOJXofb+N/lIq7GDu3nvvz
 cEHiHT6enVGSfu734ERkakU8af96Vdgw03TCQPNIPItJvm8n9uNB7OWjOef2aKaMtc43
 DlwBbYN/CwPq672hyz31Pves2ol0/+6htbFUlHY+0GfWrzz2PdQsS4EG3WEca/aqVDYE
 B/zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775055159; x=1775659959;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dYmzC4qzJCwpf9crBTUi+Fh0te/S41UEwAC7h5ZDbQk=;
 b=B4+bxkIyi3nqREu+7r9NjrQo1P7uzKJQAAxw5IAWZrA4ZseBezlpTh4qnh/iw+2vaL
 DJXRxKrG2uyM/i9A6an9pFIWtDMkpnnZUFyP91P+CqMkNQcywFGSOnhM9zzB6t77vkab
 eQLGSThZrrKApSkFIRvezlVRQRxSdUCE0IT4duwevgn88uo7CrVbLftQvPJEngIxauYH
 Ybe/n2wL2ZTU07qijoU7I9htd0U8E9vTwCN5rGErGebKvBKD7YuzKKb3p7RkNBdy/9t0
 XkKNBMq+dZCIoRaRJFGVgRNE2j/V7jQPLVMTC8F4UWkIj+TlVum/c+0O250MZbM80xfm
 MZtw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX342govHkh77c+wnvYB6zE5LMXmIVhHvXt3cIIQZHCSHGXMPTvhOioUW/IgLHxh8msqYbdJwQ=@lists.denx.de
X-Gm-Message-State: AOJu0YxZ/WxGk52PsbWyoVCMW/I2mW4n90Kvjg9WVyFq3DCMyYDl1f6I
 aMGXs/HHM1lQlNyc9tYhrUvlY930uzM8vo2vS/rA6Sman0BbQgj/+z8nGL6ZXA564Os=
X-Gm-Gg: ATEYQzy5TPJHSchzUoOacLjxcmls8LGEXKjoiTGVYqqLg1H9ZEeNMYHMfL8b8MI64Gw
 x4YKRdVqnACFd9c9kAl9SFxNBtuJQTtN4hmn3Vl/9XV7PaPwcpoeaYMTMcrSc/uVvh8+hyj+a0U
 tMWr2lkz6BAyvBttXc/wXZt3ghCwjf8lIB4KVeMJqc28/IkZdyY/Z4Pn4PzO9g2N57fvLH1YyBo
 dAbaym/hKjSycF9uBJ7cqkR4MTmB4KCCoilc0HvoZL5yvYi+yvUYmJEERfLdKPF3U6e7FJ7LZIU
 YY6+Oc3LBBkayGY+pKMiGSJDzDhT5mJX6o+sZ6bS9/m8yAyskbgbI7p05Kcyzz+qckEsGiv40IT
 307QkdCBvVs8kXy6y78XrjGVtPjm0a6J5SW7MAxEX7wFJJNKaPwdU9JXyjXSvDuJ5xIxBJrl2+K
 Np+TaDySBQ0h0iB3pRf89025u3tKKamgWZjGKd94GBotwewbKuA+1y35ZcT7oetpU1ehRXmhNxl
 Tnu0MVsnxC46ED9qpV64XxlBO8=
X-Received: by 2002:a05:6000:250a:b0:43d:2be:e4e with SMTP id
 ffacd0b85a97d-43d150e05b0mr7455460f8f.46.1775055158604; 
 Wed, 01 Apr 2026 07:52:38 -0700 (PDT)
Received: from ernest.hoecke-nb
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d1e4f7d4esm299243f8f.34.2026.04.01.07.52.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 07:52:38 -0700 (PDT)
Date: Wed, 1 Apr 2026 16:52:37 +0200
From: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, upstream@lists.phytec.de, 
 u-boot@lists.denx.de, Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Teresa Remmet <t.remmet@phytec.de>, Benjamin Hahn <B.Hahn@phytec.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Leonard Anderweit <l.anderweit@phytec.de>, Yannic Moog <y.moog@phytec.de>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>, 
 Matteo Lisi <matteo.lisi@engicam.com>, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v2 2/4] imx8mp: verdin: Convert to DM_PMIC
Message-ID: <qmd2bembjd56truquyhagkvog2ocug4duxf6wi4oi2lfutrsxw@evgti4ov55d7>
References: <20260330-power-legacy-v2-0-47dde3182a2c@nxp.com>
 <20260330-power-legacy-v2-2-47dde3182a2c@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330-power-legacy-v2-2-47dde3182a2c@nxp.com>
X-Mailman-Approved-At: Wed, 01 Apr 2026 17:01:32 +0200
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

On Mon, Mar 30, 2026 at 10:04:04PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Convert the board to use DM_PMIC instead of the legacy SPL I2C/PMIC
> handling.
> 
> Changes include:
> - Enable DM_PMIC, DM_PMIC_PCA9450, and SPL_DM_PMIC_PCA9450 in defconfig.
> - Drop legacy SPL I2C and PMIC options.
> - Remove manual I2C1 pad setup and legacy power_pca9450_init() usage.
> - Use DM-based pmic_get() with the DT node "pmic@25".
> - Update PMIC register programming to use struct udevice API.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Hi Peng,

Thanks for your work on this.

Tested-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
 
