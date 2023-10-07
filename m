Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16DB6E95A61
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 12:52:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79C2286D14;
	Sat,  7 Oct 2023 14:52:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Kfe+YS8h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BDE286D3C; Sat,  7 Oct 2023 14:52:32 +0200 (CEST)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E571D8477A
 for <u-boot@lists.denx.de>; Sat,  7 Oct 2023 14:52:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-27730028198so505831a91.1
 for <u-boot@lists.denx.de>; Sat, 07 Oct 2023 05:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696683148; x=1697287948; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IZH1wiSy7bap3Z6t/idXe2h/qd7VJUai+nfRaG5LUQM=;
 b=Kfe+YS8hHIUHG4cBmZI4dQ3290vHl24Ng354bLb84mwYi8hdaO0gx8jKaRrMgycI79
 nkI79JvyrW8WM3jtq5haiJMjhsvaU3UnldkfVYhM84eQWKhbxx/4+Gzqsv9uykiKPsso
 R3wfjsI5KEqI5yI4LQNDGIw8L5Y49lHfTOPwQqo/WQ9X2aCsfuDy83UhwWAOlyQqL2GM
 TeZ8hiW5OZHrzvvtBKTGOy9kV/aM83DhFLy1/EvSIhLdxgTsdVXM4FN4ZWt2Q5EhnDa9
 5mcneAkQOJ0S9imQ613gwqO7ZT1u4bzSrNu6HOL7WjxukY5aDH51beMzQV+3emorrThA
 L0tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696683148; x=1697287948;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IZH1wiSy7bap3Z6t/idXe2h/qd7VJUai+nfRaG5LUQM=;
 b=VaQnkLSgdcuyl3g1bUk9aZViJBvj8QOG5+6AZvjPdVuqBhKTJfidtTZjhI3OuLq2Lv
 +L/kw+YxjbrHRX08BadqMGVZY5tm+fO/V/e8E7/Tiki1GbZxBFSGy19lcLjCuVR6PX81
 Q9Ts+sva2Sq1hySoAF1PCGaiHTBFvCjr8Ut6DWWdU7/MkOXuOc8quVazOu8MmOdM//1X
 s/wF5+oNUQC4OO0Lqi1aFO+zP0xYbp7DJQLIZSh7tZ2xZXGCJai5LgBrfP/Hk93aDu84
 SN8uqXCse7mP8QSeoI4NhyMoFMMjN2WXcf6o3VeletwTJqRsB0I53/hsqBHHVAIx+6l2
 +e6Q==
X-Gm-Message-State: AOJu0YyP7Gh4oQZuVKRed/zFr6ajMDD5E2JKxxfGLiM097d0dzEo3sH0
 Irx/DhxlYm4JaGtoD5McJuAtqUy0jn3nbe7U52HP1Q/qaPk=
X-Google-Smtp-Source: AGHT+IGKhv9//47JphqPrrtnqIkijmFIrws/6k0TpjIFYki4E8tm3xUPC98rxmiIloqTMA5J9d5wYP4uMOyebWiDBSo=
X-Received: by 2002:a17:90a:43c2:b0:278:f656:ca0e with SMTP id
 r60-20020a17090a43c200b00278f656ca0emr9766014pjg.0.1696683148204; Sat, 07 Oct
 2023 05:52:28 -0700 (PDT)
MIME-Version: 1.0
References: <20231003212654.53139-1-hiagofranco@gmail.com>
In-Reply-To: <20231003212654.53139-1-hiagofranco@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 7 Oct 2023 09:52:16 -0300
Message-ID: <CAOMZO5AcsRTeSu_FjpZQx0wfr9EB5Kniag9=oLS4hxLhG9ebtw@mail.gmail.com>
Subject: Re: [PATCH] arm: mach-imx: Makefile: Extend u-boot-nand.imx padding
To: Hiago De Franco <hiagofranco@gmail.com>
Cc: Stefano Babic <sbabic@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Hiago De Franco <hiago.franco@toradex.com>, u-boot@lists.denx.de
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

On Tue, Oct 3, 2023 at 6:27=E2=80=AFPM Hiago De Franco <hiagofranco@gmail.c=
om> wrote:
>
> From: Hiago De Franco <hiago.franco@toradex.com>
>
> Extend the padding process of u-boot-nand.imx target by adding 10k bytes
> of zeros to the end of the binary using the 'dd' command.
>
> The existing padding method did not generate a functional binary,
> as discussed in more detail in this thread [1]. Instead, we adopt the
> end-padding calculation method documented in 'board/doc/colibri_imx7.rst'
> as a reference, which is relevant for iMX7 with NAND storage.
>
> Adding 10k bytes of zeros provides an approximate value that makes the
> proper padding for these NAND devices.
>
> [1] https://lore.kernel.org/all/CAC4tdFUqffQzRQFv5AGe_xtbFy1agr2SEpn_FzEd=
exhwjdryyw@mail.gmail.com/
>
> Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
