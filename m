Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7057EE7716A
	for <u-boot@archiver.kernel.org>; Mon, 16 Dec 2024 02:27:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53462800D2;
	Mon, 16 Dec 2024 03:27:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FjtluJPU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB50F800D7; Mon, 16 Dec 2024 03:27:48 +0100 (CET)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4C0F8005B
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 03:27:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-54024aa9febso3568018e87.1
 for <u-boot@lists.denx.de>; Sun, 15 Dec 2024 18:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734316066; x=1734920866; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ms4y+wqzzd2e0EXgjJvJ8r/rRGQYglUIWCccTTQ+cx0=;
 b=FjtluJPUiB0fet+zlHpalp+rOdyuXCbqjufTMa0ze24vtNxmL825voUiRBcy2qqHGo
 m0oCtuarjkyunUoiHf9p4SI+BN2tZICfUj0s4+x31IBoaxsS0fgkfT2yCrdpeGLw0yMS
 uvoR0ll4s1KjgV9lmh49Ep1Lxb3yE4n0+yKeRx+pfQhTsaclLPF68zwqdShggUzXDWuW
 K4ZPl4UQnLAo0T+T3Jt669lRySwSZyTkbhOhFKGjo9VBEZe/VbL1TMhbqoDm0cFDCS8m
 8B7OqdW3BpH4R5w5RFPDTnUKS7LlVOR/d1TboVavydmnzIM3ihBuYE8cePjuPA075qVF
 U/Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734316066; x=1734920866;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ms4y+wqzzd2e0EXgjJvJ8r/rRGQYglUIWCccTTQ+cx0=;
 b=Q+hKt8zPlbkspqln2p0xt3AsRY+nXDO0cT44+ziAssI5sCdK2xMcmn0Z51ggHk2r0p
 65Ot1EsO6HC9BP2m//lTrCBOHL+dZLw4RzmcgGgD8xNUUjIe5VmgReysTr69W9pWb68E
 beQ2aSMPxtx8FufL0qccHk1oCJFot/7R6hdW5GhGps7nAddXfAVLeCxqFV0J6Sv+Kdd0
 T+pmuPYuGONAmUGKVW2fv+DaqDyfzuxdEn6xuX1oJKIkyRN0Xa6IgFmCTOrX4SlDiaPn
 3VI19FC73SyRq/UxoAhlXDdzlBpLnra9pPgoYjWAu+3gmGHoq640uvI21zOOtjS1kah7
 vtyQ==
X-Gm-Message-State: AOJu0YxUMl/syYgNbVnl1vZcXOKUgMBiJYFiNJzbFVqW3hChiz9lJAAl
 Q9CCBmYZmkoSC8/xjGEDbmv1i+1jPRC1K/yq3XLN2iVKhziP8K09Znr0GrALI+mSCF6Bvf3v5Oq
 poaNx7tVNceo2DHzJRqWGf6RqPyEOqjis
X-Gm-Gg: ASbGnctvJfwIWidHz9nOTaf75Z91NKsqXUOC7IcGxwuBGT4oOp/y0DI0/rrG/nhHeQI
 YmxjcaYNvswHrCIpfDs/3oleMteuUlZyF6pJN9ePPM86rQ9CtCsyfphN3VmXNFBeiPn5u
X-Google-Smtp-Source: AGHT+IGkuujqJNl+HNeJO4jbmyUMVwW/ss2tbhGJqQhcVnqiBou5gU/Xu3uD7YlUo8HxpscFXw2d8tXpICD+yy8Ly6s=
X-Received: by 2002:a05:6512:3a8e:b0:540:2ff1:3c7c with SMTP id
 2adb3069b0e04-5408ccff066mr3598484e87.7.1734316065744; Sun, 15 Dec 2024
 18:27:45 -0800 (PST)
MIME-Version: 1.0
References: <33e7b95383c1e5dd20f4cd2e30b88391a09e0858.camel@googlemail.com>
In-Reply-To: <33e7b95383c1e5dd20f4cd2e30b88391a09e0858.camel@googlemail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 15 Dec 2024 23:27:34 -0300
Message-ID: <CAOMZO5BezDHXphjvX+Kat6rFq5zYC5yVucET2NzTHdFYnYTqXA@mail.gmail.com>
Subject: Re: [PATCH] imx: hab: fix srktool -c usage by removing spaces
To: chf.fritz@googlemail.com
Cc: u-boot <u-boot@lists.denx.de>
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

Hi Christoph,

On Sun, Dec 15, 2024 at 2:04=E2=80=AFPM Christoph Fritz
<chf.fritz@googlemail.com> wrote:

> +  $ CERTS=3D"SRK1_sha256_2048_65537_v3_ca_crt.pem"
> +  $ CERTS=3D"$CERTS,SRK2_sha256_2048_65537_v3_ca_crt.pem"
> +  $ CERTS=3D"$CERTS,SRK3_sha256_2048_65537_v3_ca_crt.pem"
> +  $ CERTS=3D"$CERTS,SRK4_sha256_2048_65537_v3_ca_crt.pem"
> +
>    $ ../linux64/bin/srktool -h 4 -t SRK_1_2_3_4_table.bin -e \
> -       SRK_1_2_3_4_fuse.bin -d sha256 -c \
> -       SRK1_sha256_2048_65537_v3_ca_crt.pem,\
> -       SRK2_sha256_2048_65537_v3_ca_crt.pem,\
> -       SRK3_sha256_2048_65537_v3_ca_crt.pem,\
> -       SRK4_sha256_2048_65537_v3_ca_crt.pem
> +       SRK_1_2_3_4_fuse.bin -d sha256 -c "$CERTS"

What do you think about simplifying like this instead?

--- a/doc/imx/habv4/introduction_habv4.txt
+++ b/doc/imx/habv4/introduction_habv4.txt
@@ -244,12 +244,10 @@ Table Hash.

 - Generating SRK Table and SRK Hash in Linux 64-bit machines:

+  $ CA_CRT=3D"sha256_2048_65537_v3_ca_crt.pem"
   $ ../linux64/bin/srktool -h 4 -t SRK_1_2_3_4_table.bin -e \
        SRK_1_2_3_4_fuse.bin -d sha256 -c \
-       SRK1_sha256_2048_65537_v3_ca_crt.pem,\
-       SRK2_sha256_2048_65537_v3_ca_crt.pem,\
-       SRK3_sha256_2048_65537_v3_ca_crt.pem,\
-       SRK4_sha256_2048_65537_v3_ca_crt.pem
+       SRK1_"$CA_CRT",SRK2_"$CA_CRT",SRK3_"$CA_CRT",SRK4_"$CA_CRT"

 The SRK_1_2_3_4_table.bin and SRK_1_2_3_4_fuse.bin files can be used in fu=
rther
 steps as explained in HAB guides available under doc/imx/habv4/guides/
