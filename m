Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7042E7717D
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 12:25:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74E8289654;
	Mon,  9 Dec 2024 13:25:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YMVyKyQH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFE20893A2; Mon,  9 Dec 2024 13:25:27 +0100 (CET)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D15AE88835
 for <u-boot@lists.denx.de>; Mon,  9 Dec 2024 13:25:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-5401ab97206so1166610e87.3
 for <u-boot@lists.denx.de>; Mon, 09 Dec 2024 04:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733747125; x=1734351925; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I3LWt6Uo3HO+zBIzG7sKa3LOiyWXqRUxEf/2WcFRSzs=;
 b=YMVyKyQHj5/8hC8RxuDitt0AX/82+OaLgEXkMSkPGxt77uxWl0wMiFqMXXgrg+4mvS
 ODFLCwNrxjjP1exyMM+8UaqBUYItywy6HYSvG5daRl80QkcwB+K2oUd0HFzj36ybOQBW
 21NamCPTlyAUAaFzv9z602aDs7qV5l+YWntFWu0cqdSDFd1adcG0q/vigpntHl+oprES
 ZQJRUry86i+HUjumX461HOIkwnC/WfZkiMDdhDOkTpk0nl8JoHUIfW7TjLrtsBK3Gj/x
 zT6eJS/ewf3gRpHcARKojxQ+AyoEuRViixDY8W3yiIZkhE/V9gZEv26AZqJfziNOednv
 tDkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733747125; x=1734351925;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I3LWt6Uo3HO+zBIzG7sKa3LOiyWXqRUxEf/2WcFRSzs=;
 b=nGDhtSAysk8g/nqjo5+BeJMBsrmmc0eGI7Zgn4u8wLjeXgAzMHsIOHmY/24tAWZnEj
 j83HmNdEjOg+TwSuwICk/fplj2MJLLfrV9E+5B5c7sVMP0ThFsqjv0XxwNUEp0TFd0E+
 Ff4IMKeJgwOnNUOH4NOMjNm64ZvyRZMxH8NnP1mbXU2NKvIUA9sk7OPCndblZWPMhj4Z
 MuqBbPvbmGSAgthGWxAC0NckRlpdRZLyzQcpk9bNZG6Qedil4PfIc3eXhdD3ULKuFq0b
 O5YLAQB8K2uvBv2NB3WSINzW0wh75FKvUcEhgk2iPj/ZSEhSk7ORmPA/Z7wqv2sMKA2H
 /Zjw==
X-Gm-Message-State: AOJu0YyFvDJloeltHW//iWHeMD03s0TGNHeqTvTKvxpuPDhbVV+CkULv
 7CVO5n+6tHVQ6vtD56Fd2sDNkADeX+O8x5HabKTaCQvWeKWPECiMT6w0rC4i36mqb89Tq7jPiu1
 9Q4+n9x/HdLs0e25oH9vFViGuUfS1Vw==
X-Gm-Gg: ASbGnctwtkTjE1GpQ2rk+EFV8n6l0LTJBmwpkehU3nP2KAgF7hq4CsOBSWJ02fJPEse
 5mNrYnBnFBr/vmTPRkTQYNmNwSaqks9AoSHoibe0x2LbCS3DsVnaLQwxULS1OvT8=
X-Google-Smtp-Source: AGHT+IHmzo3oiv2+PNQmeXb1jddKxWyDydar3stFW8XNNc8SclwKMatDg3EfHLraRA55dB2srFjmNi3MKL3FRSP686U=
X-Received: by 2002:a05:6512:2810:b0:53e:24fa:ce2 with SMTP id
 2adb3069b0e04-54024112f52mr92739e87.38.1733747124761; Mon, 09 Dec 2024
 04:25:24 -0800 (PST)
MIME-Version: 1.0
References: <20241203094235.693693-1-y.bas@phytec.de>
In-Reply-To: <20241203094235.693693-1-y.bas@phytec.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 9 Dec 2024 09:25:12 -0300
Message-ID: <CAOMZO5CyKeoev_0BtJHn7ZXAovwr1gBrd7ULUZ9MED3sn2WO0A@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] phycore_imx8mm: Switch to using env text files
To: Yunus Bas <y.bas@phytec.de>
Cc: u-boot@lists.denx.de, t.remmet@phytec.de, Y.Moog@phytec.de, 
 B.Hahn@phytec.de
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

On Tue, Dec 3, 2024 at 6:42=E2=80=AFAM Yunus Bas <y.bas@phytec.de> wrote:
>
> Move the environment into the board directory and convert header to a
> txt file. In addition, this patch also applies following changes:
>
> - Change default nfsroot path to /srv/nfs due to compliance with Linux
> FHS 3.0.
>
> - Rename specific variables as stated in the bootstd documentation.
> Renamed variables:
>         fdt_addr =3D> fdt_addr_r
>         fdt_file =3D> fdtfile
>
> Signed-off-by: Yunus Bas <y.bas@phytec.de>
> ---
> Changes in v3:
> - Removed sd_dev entry
> - Added Maintainers and reviewers
> - Added changes description

Applied all to u-boot-imx/next, thanks.
