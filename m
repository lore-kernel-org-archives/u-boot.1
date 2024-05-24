Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0765C25B74
	for <u-boot@archiver.kernel.org>; Fri, 24 May 2024 16:27:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E4C1888BB;
	Fri, 24 May 2024 18:27:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FQzlWJ2m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C131B888C3; Fri, 24 May 2024 18:27:00 +0200 (CEST)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA49288647
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 18:26:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2bf5ba9a2c5so194907a91.0
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 09:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716568016; x=1717172816; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oksNA4uwkRSL0liMoe9TlPOQe2Vn6X27MRy5gQfHPnk=;
 b=FQzlWJ2maulZbsFlWaGVVD7QI0ROQfW/3nrHkG3ZhxeJ2Rmwm6mqEwtKQPSgJBnD6t
 OhBVkVXFdbx1ftbL4OxuBP6BJSFIfoS7cnxlM7ipuJidiypyajMAKaFRJUc1zj6zDsc6
 PmmDNMULwjy0UrKvd6xYvxR+sVZwB0O0sRKfkRmbgt9b6rCVLIwbmbwkorwYqrK6tlrQ
 xIiDgY8odnRsXuj3+ZHDdFWTFPTvQxiG5806Bkbi1h5w1rVORU0MJMwAwmoaidQMIxW6
 cwy+mb6eG0Vlk/fdbpzzWsPAK9Pqh2wL5UhyqS2aHo6DkXxMTHrq+T1S3iwWxVGfczZK
 yoqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716568016; x=1717172816;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oksNA4uwkRSL0liMoe9TlPOQe2Vn6X27MRy5gQfHPnk=;
 b=NLk4sYcOzaKD/4Dt5r6zwe0PLXh0DOQ7kW90+fxlR9lvqGZSskvT3prUYkPfEL8cO3
 dW2R+ByWxHWA2urafL+ldVtM++HePpPYEcS5VN0njHWLOjPHEz/SxuP9z5So/wq4/RTh
 SShmitjq1tiddKK+097qAoLjjpAY8xa/qI6BoYwquw88p3sb1tupy0FDoS3jGfwNKSEk
 LKkP+iWebBdHOX0Hj24aBzFsUWnGPisiH34a47KRDudDx4zU0ZP655Uuw1VAS4P46Y+K
 CNAQ4nf9sD2rj6CaPkvbaYO2QLnYi3ykl3NS6beHolr7rVUCAsdfEjHy0ueHv3X8EbaY
 cxYA==
X-Gm-Message-State: AOJu0YzHjbv23R6kgnFrrTH6fijLTZjCumqVNMZkm3STh2TvTqDA7yN3
 KvSA3YGtqpql9//YKMbGSnpockXc3WgrCfzqegxclq4GA3f5ZmmZ8PrH9tXVb08uMJvQfOVrfjf
 EbsUALiGjIH6a05dnliB7PG8gRLI=
X-Google-Smtp-Source: AGHT+IHJ/ZE/+q4R4aIAm3UpEf6pv8ZQdFLj2pJmEuXiMoq5mWbFRB1mtusp0T82UW5SR3mNBKq+wDry7lQA3Jr/HF4=
X-Received: by 2002:a17:90a:bc85:b0:2bd:9256:b8f2 with SMTP id
 98e67ed59e1d1-2bf5e179b58mr2725381a91.1.1716568016184; Fri, 24 May 2024
 09:26:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240521104834.11295-1-marex@denx.de>
In-Reply-To: <20240521104834.11295-1-marex@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 24 May 2024 13:26:44 -0300
Message-ID: <CAOMZO5DsyuCu+fjpa8GjB6mbp9b5n=YOGxtjgMkdSstGFmEUuA@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] binman: Add nxp_imx8mcst etype for i.MX8M
 flash.bin signing
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, anton.gres@ifm.com, ch@denx.de, 
 Tim Harvey <tharvey@gateworks.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Adam Ford <aford173@gmail.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Angus Ainslie <angus@akkea.ca>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Simon Glass <sjg@chromium.org>,
 Stefan Eichenberger <stefan.eichenberger@toradex.com>, 
 Stefano Babic <sbabic@denx.de>, Tom Rini <trini@konsulko.com>, kernel@puri.sm, 
 u-boot@dh-electronics.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, May 21, 2024 at 7:48=E2=80=AFAM Marek Vasut <marex@denx.de> wrote:
>
> Add new binman etype which allows signing both the SPL and fitImage secti=
ons
> of i.MX8M flash.bin using CST. There are multiple DT properties which gov=
ern
> the signing process, nxp,loader-address is the only mandatory one which s=
ets
> the SPL signature start address without the imx8mimage header, this shoul=
d be
> SPL text base. The key material can be configured using optional DT prope=
rties
> nxp,srk-table, nxp,csf-crt, nxp,img-crt, all of which default the key mat=
erial
> names generated by CST tool scripts. The nxp,unlock property can be used =
to
> unlock CAAM access in SPL section.
>
> Reviewed-by: Tim Harvey <tharvey@gateworks.com>
> Signed-off-by: Marek Vasut <marex@denx.de>

Applied the series, thanks.
