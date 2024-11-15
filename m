Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1262D68BCF
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 19:03:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 442FE8911B;
	Fri, 15 Nov 2024 20:03:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GPitSPiC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DF5A88F49; Fri, 15 Nov 2024 20:03:02 +0100 (CET)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9AA358911B
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 20:02:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2fb5a9c7420so22708551fa.3
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 11:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731697379; x=1732302179; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UOG34eLIahuyCF/8Ebz574vhb50GL82D+MieXP1s5XA=;
 b=GPitSPiCAiXeYRcorumt/N/Nse5OE26HYNmvZxx4uMLypoIJ6T4+uT0r/S04SmbaAo
 /1NrVIf/CAH7e3t52vgDLztvCA10X34CH3c3L5jzmwfgWMz8KDbL+2fWLs8Gajd8OVtu
 Jo8scObrflp3ohFcVJ9X5BOsev2kg4+yYwWl3Z3vwp3a3u9O7zLiMKDHqEDGn5wrb+7j
 Z1L/AtRXo0QL7W8dN4m94/J+fZ8lW2Kk8eCxD9ZFV56dwIuIuUeEIKZVatQsDLn0pyLW
 2tJ/JUgmSOPZq2/O6E+O5if5LCYwhkVFuRHibjVaY7q7OoSzJZlY+uubgTVjNMw2697M
 dTgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731697379; x=1732302179;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UOG34eLIahuyCF/8Ebz574vhb50GL82D+MieXP1s5XA=;
 b=MtT3I6h7c2LULrLUVNiqEUwq531bvjJA1XU3LaqOL10G2k8GkKxhGZhU/03EX49NZ/
 OLI7kMB7HVL3D4Yz88h+849vDa4N9Xj/s8THgFNGK/7ojc2evx+FTHl44YOeYvbTLirZ
 GvRSlDCIKFHPitiH2+UB1OkIkUTHxqoTQx8rvnrjBYZ22V9byB02sKajPHBk76647oEI
 qFQBOPb7aekAGd7lMNSbqbmTx13l4oZbIeV3LXw+M/DClOuRE2PcZiKfec4DhEEb+KEC
 jVPekV4rbbP59PXXgD3T/2tAk2mdj4fwD/h9GsFz1P2Tgdwrw95qnmoEdvu3CTjIWIYk
 MYhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXb+bAgpTAd3KhRZ6IBpOkEWecFATqQRwht1gCaTHZwYY1TnB1W9VmAZruflJmUhckQczdOw4w=@lists.denx.de
X-Gm-Message-State: AOJu0YzUbt3ecZhX8Q0rRDttDn9O6xvGgxVVOYQTzyJ2nt+HpNn9UvNC
 bv5mq1tJdjyo3AHCh+kEQXSDbI+1qbbrAumyr+0GMXMqBwRQgtnUFURWayCvPyHtylNWsNor/gl
 w4go7jH/46EomWP21EDa8xW3q9GQ=
X-Google-Smtp-Source: AGHT+IEDOrtWq7efYL5hQZS4HsPnmJ5L9A7gh3RPgP00E741B2IT3bICRs0CFzwX6MoocIGIkgsn7In+VwehOMnfxBc=
X-Received: by 2002:a2e:9fc9:0:b0:2ff:59be:7c77 with SMTP id
 38308e7fff4ca-2ff60662397mr23813621fa.3.1731697378530; Fri, 15 Nov 2024
 11:02:58 -0800 (PST)
MIME-Version: 1.0
References: <20241112023854.2289656-1-festevam@gmail.com>
In-Reply-To: <20241112023854.2289656-1-festevam@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 15 Nov 2024 16:02:47 -0300
Message-ID: <CAOMZO5CHAYKufRNsE4aCy4GdDRTTujr9vPUFJfux3K0G99iWYQ@mail.gmail.com>
Subject: Re: [PATCH] tools: imx8image: Add missing break for CMD_DCD_SKIP
To: trini@konsulko.com
Cc: hs@denx.de, u-boot@lists.denx.de, Fabio Estevam <festevam@denx.de>
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

On Mon, Nov 11, 2024 at 11:39=E2=80=AFPM Fabio Estevam <festevam@gmail.com>=
 wrote:
>
> From: Fabio Estevam <festevam@denx.de>
>
> The CMD_DCD_SKIP case misses a break statement.
>
> Add it.
>
> Fixes: 254c00803b63 ("tools: imx8image: add possibility to skip dcd")
> Addresses-Coverity-ID: 514648: Control flow issues (MISSING_BREAK)
> Signed-off-by: Fabio Estevam <festevam@denx.de>

Applied, thanks.
