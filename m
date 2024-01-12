Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2214BC4706C
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 15:57:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F4D787980;
	Fri, 12 Jan 2024 16:57:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PerWU+ob";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4A808797C; Fri, 12 Jan 2024 16:57:32 +0100 (CET)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F56187980
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 16:57:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-28c05f68d1cso1092807a91.1
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 07:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705075048; x=1705679848; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hSL4zy3iEquh7CMr/gsxsy6cH1Y1MzT3N4lOkkZxowI=;
 b=PerWU+obHQfkiTEDuuqA1L9DGpATMBlR0MJ3/zlRT/5/9O98pammOOQZD/P+kb63Fq
 Of7c+1yd+d1vSwzxwTwnvkKUFxjr/kq5/f9jtS2TFB/na6Ek/0dUnePq0JDPx/73ArOa
 oblfFg572Es4BktQtD6O9jvlzg/7xthi1EYtgWn5bFszHJNiltRn9E1gyIlqhk7kEnO4
 zeTUUVeDnIACED+zBD2MqpAcNLbq5uQz7h00tV5PL559DOC4WvSxilVIsc1l4rqyVKY9
 K+bh5CCAcWCisACAeZUrHA/al/Skt5VfgnNkiAqbQKQe5oFS9zb8OsT/CtcNY+NYF3Z7
 /Rzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705075048; x=1705679848;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hSL4zy3iEquh7CMr/gsxsy6cH1Y1MzT3N4lOkkZxowI=;
 b=QAIzoPzOL+wXNX7cWdtbCaxhxXK81aXKf+kaUGxd6S4q0TlDzqfWwAa6h+7XfoDQZP
 EAsYdKaMO1iGBqjgJJsDnw6Wukbdw87EzdCabHC7LBW1nybzxJv+S/KtyYtL58pmExkb
 SxDtBB/Im2zyEnwxPJHTye9E0SnamLkHu2Jtxb1r3DNFImpU9mSv1gCyz6wLys+krCQI
 FuWdARLzNEDIfX/usvmtffnDKee/imwQzBWldG99Ws2yHo83zJey5WT9iPpFWdgPH+Mf
 w0akMDx5fShJQPehT+L933sV/HhhEFhjjuAwKz0ELK1ga66HwM6fwYP+ZwoWDAnb74bK
 Vy5Q==
X-Gm-Message-State: AOJu0YwG9odUrEdBk7QIz5In76hTAql68aHioU24CvBU2GeXkrW8+g4G
 vCDXa58o4OyA53efMsfhGqWs/06P9tceyO8Q7+ijGGJnJTc=
X-Google-Smtp-Source: AGHT+IHMNUM6li5h03anJunXfOA7CHohjlDCJdIcnfk51HY7CYDTNtxaZqnitMZDcMFvQFVhs8TJFssBmus92i6ACD0=
X-Received: by 2002:a17:90b:384b:b0:28b:3637:e246 with SMTP id
 nl11-20020a17090b384b00b0028b3637e246mr2134460pjb.4.1705075047787; Fri, 12
 Jan 2024 07:57:27 -0800 (PST)
MIME-Version: 1.0
References: <1705043234-39185-1-git-send-email-ye.li@nxp.com>
In-Reply-To: <1705043234-39185-1-git-send-email-ye.li@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 12 Jan 2024 12:57:16 -0300
Message-ID: <CAOMZO5AsRnVnU+ektK0i173LjygDC+owiF_ib2qsnKAZ3LBWpw@mail.gmail.com>
Subject: Re: [PATCH] arm: imx: imx8m: Enable the SError exception
To: Ye Li <ye.li@nxp.com>
Cc: sbabic@denx.de, u-boot@lists.denx.de, peng.fan@nxp.com, uboot-imx@nxp.com, 
 thomas.schaefer@kontron.com
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

On Fri, Jan 12, 2024 at 4:07=E2=80=AFAM Ye Li <ye.li@nxp.com> wrote:
>
> To work with commit 2f3c920(imx8m: workaround ROM serror),
> we need to enable the SError exception and install vector in SPL.
>
> Signed-off-by: Ye Li <ye.li@nxp.com>
> Reviewed-by: Peng Fan <peng.fan@nxp.com>

Reported-by: Thomas Schaefer <thomas.schaefer@kontron.com>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
