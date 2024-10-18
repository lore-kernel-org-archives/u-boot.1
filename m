Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C6E2D30000
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 12:31:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01096890E7;
	Fri, 18 Oct 2024 14:31:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ngrZWkDt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72F378910A; Fri, 18 Oct 2024 14:31:47 +0200 (CEST)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F93A890E7
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 14:31:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-539f8490856so2463431e87.2
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 05:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729254705; x=1729859505; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1RBNbqboh0JPfpxONSuUooSuYilM64q9No2STNbeOEs=;
 b=ngrZWkDtKA4pKZCALE8bv8v2UYZ6QTNS5pZL+hdfhgMw/lg0QC+9joCgHzqyObMYlb
 EZ4+yrVl27rVI2jEUTOvpWMq9D5IsR4LrcriXzlEm/wDU/wVtGdylvmUYITDOOLh+e55
 RUExiAEucYzjn9nuglw7xGvtmJzIw0hzCCzQY5CmlCYiD3dcnSZJKSyXTEpvY0opVcft
 UlRVVjjtBTEQ8Nk+4QabkD4Ai1fOwRcNoP3jnYJ4wEyQe/clGp3e5W2Hi+mThWW0eYLH
 3YiH9sCDdX3W2QxWX3liuLyolGqhB+/vQCNmXv/ve1nN72XUbrSM8m400zzD1HVO10O1
 GOYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729254705; x=1729859505;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1RBNbqboh0JPfpxONSuUooSuYilM64q9No2STNbeOEs=;
 b=bQ/RAt8gLDLLxH2dVW0A3N38WqBangqoXsukE1aBbyjktM+dbkt97KwDvQc7zvL4UO
 TqnhN8/T4iaGSQsr82RhlQt12Y1uvzzJRVy/tqan8lamwPFJfF3N51DELR6s3qwk6VDD
 gW+4fi6AE83WTDSI8VY2tx6s5Pegf9007riNf3gYMmZpWBPzhyorDiBbMeIwspxbftpi
 4OzWDV6J9C8/mgmf5w62JVB749Ignf9bFinxNA5P6ooFdCIrMP2sJP9WScpA1rOzewZR
 fY3GU+MHOJ8B/oiqgXfuF1qgplqVU7539TYKzlKLqoGaCgSczqnlbwi5Z/4dMuuO7ilI
 SyWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwNBnUcRzTrzVdDmGjDAv0YxCAaQxF2mS0Z7OmGUao8IC3bQmqx2urr/39D8H6mKU7UBdslgE=@lists.denx.de
X-Gm-Message-State: AOJu0Yzvytrj8yo7qx4mynpdvhL7/FpO3rMAVsFJeYqM2nHAh8N0gb8O
 F9lQDT4xOc+Y5iVLHOeJKdbFNFxW4S6H7rB+nqc3U7Tp/bpF4OCL46eM3m3b85zR7RtykwmHFyY
 4DGo+7kOftMWVO/cqGyael3H02pE=
X-Google-Smtp-Source: AGHT+IHVyuC8DErFWUtZgLM3N7uMct+2waD9Adn9xnl/jMcvOTiXQXZ9ljYQANUuhM0hzStDpwMV0HK7ZlQ53zqZWxc=
X-Received: by 2002:a05:6512:6ce:b0:539:fc86:ce0e with SMTP id
 2adb3069b0e04-53a154b22c2mr1517134e87.35.1729254704465; Fri, 18 Oct 2024
 05:31:44 -0700 (PDT)
MIME-Version: 1.0
References: <20241018073432.18234-1-peng.fan@oss.nxp.com>
In-Reply-To: <20241018073432.18234-1-peng.fan@oss.nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 18 Oct 2024 09:31:33 -0300
Message-ID: <CAOMZO5DYX-6sALV1OO_afqxk-XuamKyUPwmvL8DvocMg6T=JjA@mail.gmail.com>
Subject: Re: [PATCH V3] cpu: imx8_cpu: Avoid revision to corrupt device tree
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: sbabic@denx.de, u-boot@lists.denx.de, trini@konsulko.com, 
 uboot-imx@nxp.com, Peng Fan <peng.fan@nxp.com>
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

On Fri, Oct 18, 2024 at 3:30=E2=80=AFAM Peng Fan (OSS) <peng.fan@oss.nxp.co=
m> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> U-Boot device tree is padded just after U-Boot proper.
> After the whole stuff loaded to DRAM space, the device tree
> area is conflict with BSS region before U-Boot relocation.
>
> So any write to BSS area before reloc_fdt will corrupt the
> device tree. Without the fix, there is issue that =E2=80=9Cbinman_init
> failed:-2=E2=80=9D on i.MX8MP-EVK board.
>
> Drop 'revision' and use malloc area in cpu_imx_plat->rev.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied, thanks.
