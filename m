Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90274C4345F
	for <u-boot@archiver.kernel.org>; Sat, 20 Apr 2024 18:36:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B49D887C4;
	Sat, 20 Apr 2024 20:36:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KP8wDJTW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09B71887C4; Sat, 20 Apr 2024 20:36:47 +0200 (CEST)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E033188791
 for <u-boot@lists.denx.de>; Sat, 20 Apr 2024 20:36:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2a2cced7482so332368a91.0
 for <u-boot@lists.denx.de>; Sat, 20 Apr 2024 11:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713638203; x=1714243003; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yevntBiloQ6gCeWNwFD8gqL2mQZFKVDb2G6PCp/dGhA=;
 b=KP8wDJTW5wSpRQxiY+rg3LPvt8AYlTP3azu/uZ48K7f7f5Ydxm7TITI/dChV10h1B0
 pFGv3ia463ba9RZjLv6oHBlId4ppQti2ZGUrOO4437qzylnUoxjcOHviY/ObKAec4ZHn
 A0Hziq5fSk6LL1+Q1cZMDSD8bH+Xsxfv8dIHNog1efnW6bVfCGnNDHC66h4qVBzxMimF
 Ua7zqIUufTMyjBfLP26dN+XvHN+KsFIojBh4HY22Wwtozl3PScbKf+O4wX/x0iIIK+Kv
 PCJDrtO2ag/6Ff8vSHQ2cztTh5Rw8xT/R26bN1x8Uy2n9O/mWnsGfMnnW/cRqdj1iE5I
 Nr1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713638203; x=1714243003;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yevntBiloQ6gCeWNwFD8gqL2mQZFKVDb2G6PCp/dGhA=;
 b=YCJJeFm06OmLARwM/w3v3qdCPgWCREDRc5wyn6ynnWeXZB1WMFsKLiNbeVG36vG/0B
 OpAT8Pvt7gBAflPS2NSdU/pqXESaxKvlY+3hqQ4y6Ab6jMkakjx4Ct/McNmunn3ZoJhA
 hYFj9mPdOeZKd0mt5sxIomiwHDXyOfyTtjIHUEGmgegt6NZ8Iu6VvnWgGm6hN2b1NiuK
 0+WYW6PP0Zi5Ygin1cxmOZ1AmrUrGSs+V4BNnSIGS1xRmydZ6ElI/xs7Az/5billN4SV
 kxTe1mmjtVdXlTHjnjCyUQhWANI38CvzF+Rr6TDUikR6lGk6dHsCxg4l+ASJT8FGRVgk
 5XLA==
X-Gm-Message-State: AOJu0YxWsJJEvqXSzF9tncN5LNsbBkh6cXXDvMnUD3jDcK5YZgz+aAoL
 yuWz11MCF7vt/8j+/MDbH++WzDCP8LIk/NfdtdTx5cj7+JbyI/rFa54hArLTTolbotEr/K0P5KI
 RPJncwExmgxMMNYm8XdrfRwtt0hJLvg==
X-Google-Smtp-Source: AGHT+IG2pGKRIccOLiGzXlRAYAC6676+kI7d600m05JxRJbrqqucgcggQhWloKtL3zi+GZ8m1v7rFOclxS98YXl2I24=
X-Received: by 2002:a05:6a20:2986:b0:1a7:94ba:7b03 with SMTP id
 f6-20020a056a20298600b001a794ba7b03mr6288255pzh.6.1713638203469; Sat, 20 Apr
 2024 11:36:43 -0700 (PDT)
MIME-Version: 1.0
References: <20240417200325.3749018-1-tharvey@gateworks.com>
In-Reply-To: <20240417200325.3749018-1-tharvey@gateworks.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 20 Apr 2024 15:36:33 -0300
Message-ID: <CAOMZO5C5PCp25o1NQjgW1gq6fAKAJr3Q0MYg803ZiAHxDaSLdQ@mail.gmail.com>
Subject: Re: [PATCH] imx8m*_venice_defconfig: enable ipv6, wget and tftpput
To: Tim Harvey <tharvey@gateworks.com>
Cc: u-boot@lists.denx.de
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

On Wed, Apr 17, 2024 at 5:03=E2=80=AFPM Tim Harvey <tharvey@gateworks.com> =
wrote:
>
> Enable ipv6, wget, and tftpput support
>
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Applied, thanks.
