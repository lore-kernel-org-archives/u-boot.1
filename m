Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8CEBD3B7E0
	for <u-boot@archiver.kernel.org>; Sat,  6 Dec 2025 20:04:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E7A883A41;
	Sat,  6 Dec 2025 21:04:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MmtHVci6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F17B83A5B; Sat,  6 Dec 2025 21:04:57 +0100 (CET)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48C8783957
 for <u-boot@lists.denx.de>; Sat,  6 Dec 2025 21:04:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-5957ac0efc2so3680090e87.1
 for <u-boot@lists.denx.de>; Sat, 06 Dec 2025 12:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765051494; x=1765656294; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AeOf1gpaN1QschjHcZ0SIkHyJcly/cIjcT1wSgxqs3A=;
 b=MmtHVci6LWA1mJdhWnWbZp0mnJiRVkr7abkHBQCUkvpwXsUSe9E+WkXs+RLEaE/Qcb
 +qL8LGAtWOoG+4QD9nTnxN8Ed3YFkfEl7eVRrm2bXLbcEC9tekDcCvdqq09y+E6NIgVC
 vBj/l+N9GXZvBPGnlM3DRTNAIZGjYW+mZAOF7Hc6qOL1owy1okisRvx8OU5jfUnLPaZ1
 eM6KigNglRdM2/ZiQJB74SZNgpU5tkZmb47iJgmBm+1RByR31GR77LOsTiIB1uLzxOM5
 nzyRm8ZphPQ8EIqaQnm+ebdzF4zxjcENST8iemsnYtaZP2HE7QsWdP/lg3eQ8xGZkyqh
 r+Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765051494; x=1765656294;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AeOf1gpaN1QschjHcZ0SIkHyJcly/cIjcT1wSgxqs3A=;
 b=u2gtoOaQk6VQsbSlz8hi5p3DR+tKfJSh3akKj1YGp6/wpWItA6vT6L7SnQevSCXlGQ
 5XlSVxk76PWC3TfLhI54qZx/DETSZblJuTXtfDr47agtuc/4oNPmVfxFr0/IyAPV9aOa
 JIsJ4Huogcz//LgAx2aCWzlJ99g+BqjlFmsDRbrXsOit9PdeqMOvSuSxW/YksyItDA30
 srb3J2GO5cRAaX1ol7qtxxnH0ZSU956NdTAJ+BNMmO5kSXtWN6yOs8b+mamMZhp12EOj
 iZ965YPhvZmkjyUr0aynoC6cp/8FiaWCSPK0LWZD6cLnBBU3QPLYfMA6AW6vDaI7uhVj
 iELQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXD0/m50OJs/T7XvQTxYE51BONc/5yxo8+SM4w83x9XkuZDF18dr6ewb1UUX0Js/apPK3RlwIU=@lists.denx.de
X-Gm-Message-State: AOJu0Yx63I7y2hD85r1NljEQXJM/hkTD3V9arIs8PAWd519kDp/y/RbE
 wZjAZWzKZK2TrzbyGy5sLadqWixRpSOD9/KWRvvDCztDvvQi00se3jsPyOoeD2iVQQ2JZTzkUoY
 aMdAjEx304d9O44EqugGyydsV/RHEZQM=
X-Gm-Gg: ASbGncsgge3YojcdsJQxIubzsbrugUHD0vvDa7TljEkHvV0xvp9kGDyuF/l2FSbjzOl
 YbIEwD11NwLoLF0ziFYq6eeshY7rwc8PFUapr6TK0NHsiax2QQ44roENHpYAXabGV0fa3UcFYIP
 SrBI2ypuUiKvzSdbGjeOGpaUcwm9XtaSwQQ+9+Y0ZFD4lHN/dFn8OOB8TfutFz4FaajIbB4Yd1h
 arm/4WNfyQl9uZM5sSKttcU1+LeVA2GrdyTFSXE5zr2WvVEJ/4UJiZc4NT6THl5L/cAAKlIPLU9
 9uTFZpbp0RrbeDBmp1jr9i11eCg=
X-Google-Smtp-Source: AGHT+IGg9DTI8S5nzOzBSs1XaWLTyv6vkxwDWKLAwQnk2WxLb7cG32LGTbd2XQWmdkwT8R+zdxEn3aqDVryn3Q8OxCw=
X-Received: by 2002:a05:6512:68b:b0:594:48e6:26b8 with SMTP id
 2adb3069b0e04-598853caf93mr1111601e87.39.1765051494388; Sat, 06 Dec 2025
 12:04:54 -0800 (PST)
MIME-Version: 1.0
References: <20251205111044.3195322-1-primoz.fiser@norik.com>
 <20251205111044.3195322-3-primoz.fiser@norik.com>
In-Reply-To: <20251205111044.3195322-3-primoz.fiser@norik.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 6 Dec 2025 17:04:41 -0300
X-Gm-Features: AQt7F2qCWrs03BiD0qZhDWQYIgtcyF1MednBCw5ESfDoCHNvQTiGPeJ_GsjjK6E
Message-ID: <CAOMZO5DzSPxx_fBkLy_k6oHCYp5CWuufmqZRcGYvn=62rGG0_g@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] board: phytec: phycore-imx93: env: Add required
 uuu variables
To: Primoz Fiser <primoz.fiser@norik.com>
Cc: Mathieu Othacehe <m.othacehe@gmail.com>,
 Christoph Stoidner <c.stoidner@phytec.de>, 
 Stefano Babic <sbabic@nabladev.com>, uboot-imx@nxp.com,
 Tom Rini <trini@konsulko.com>, 
 Benjamin Hahn <B.Hahn@phytec.de>, u-boot@lists.denx.de,
 upstream@lists.phytec.de
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

On Fri, Dec 5, 2025 at 8:10=E2=80=AFAM Primoz Fiser <primoz.fiser@norik.com=
> wrote:
>
> Add variable 'emmc_dev' and 'sd_dev' required for NXP uuu flash scripts.
>
> Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>

Applied the series to u-boot-imx/next, thanks.
