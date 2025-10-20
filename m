Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA13DCCD199
	for <u-boot@archiver.kernel.org>; Mon, 20 Oct 2025 12:38:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24AF2807C0;
	Mon, 20 Oct 2025 14:38:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GoCeUKAz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 411FB82E34; Mon, 20 Oct 2025 14:38:24 +0200 (CEST)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5355C807B1
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 14:38:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-57ea78e0618so4994922e87.0
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 05:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760963902; x=1761568702; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jd/rcZK4+jH15/VmbFuU5PH0qglU2DA0w6Mi/M0Zgwg=;
 b=GoCeUKAzN7Nb9DutDf+ojsrOiR2OFUgz0Rgljr5WdVqknHWzaf5x2yjPNvlbOe6BuM
 5SmSxUH21ok25bjPRE/zqE2+46yUl7EkKIGa+5D0adGYhzPXYKgNxrT4iJgJm3THTJH2
 xd5u6PdEkfn06Ue3q0juupt+uZM0+T4e/Nu6lqzlN//MREq31CFJk0+uWQOG7D9sKROj
 qtgOVm3IkAJPmVPvM71H5X3dY9iVrQbFX3wQMEj6PBIRkdvolLZMH8Gq67xl/C+5DZo0
 EKqNvSnramBTZnbs/ZU3g+FUKZY/L7+f3S3wi2xsu4xlRpEikQKdB5CeyYmXA0olZUaf
 rYaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760963902; x=1761568702;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jd/rcZK4+jH15/VmbFuU5PH0qglU2DA0w6Mi/M0Zgwg=;
 b=WAXxKUXSXZG5x9mxkne3NXgK7cleownIRDK9UWMGL8Om39Iy5yjP9okbocOCpD2Y7b
 1eroNXyoRTp5XPWH8XlYAFOuAhZFXY+DjO1ZLMEHyIyRLpAD8PNSdCEWuYB93GBgzjfj
 adRYv8GGaetnEZyaeeEWNQPffNAGndOrV9RQUNeGnRtAPMLaFvCjvsT4a9uWDgoFCMKk
 Z9rpVQ4eoYL2aHuwwRtQ5IXYIE5BrW4h+oybUYmmi4T929fDcph9aVzfQY6B6kWlY4Lx
 I/pWqDYme7P+tZr5YJS00qqC+lmxBTgiuLw23ZZPOPQPeiYMJpIFaEQXWIEIovM2yX6G
 d35Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNr6yOdwSJI75cyuWaFCOeOxQwAP+NtV2ptlZfsd+pIgYUH4u8JqLcXzOOop4pxDSx64syYWg=@lists.denx.de
X-Gm-Message-State: AOJu0Yw/K0YuHehpvVVXOX+uiV+UEN0zcu3zOlz+qEBK6Q64pKbBrgKI
 E8Pb89TPHq2RtaeVOmvi3hBDinn9PCrEwLvqbR/FnQOyQoa1T0dOxkhYm8WeoFIt5sARRdWZ0VY
 TRvXm+6fEVScW4IDoS3JrmRLjWmqzqKUvsg==
X-Gm-Gg: ASbGncuwlZrQhyMLpMSp3hotn+YwwuUJTqgD7O4gGYbVywma/YYrgLuXC7refvy3TvX
 mMhatoyvJ5fd1R9dhon+z9SmF93NJEwz0GOuTYhzsGbJMhD+ZrOgfnsNrEp9pnhmoUkLiqsumAJ
 gPHdfJ3SPt3SiBJkiw37KuTpbxZf9pQKe6vava7RDnsFTbPj7tT34+fQuUHFBusZEvGkJMdpgqr
 jvZMS08ffqqk1WAbmzWOiko2G3P9toAqNwO8Aj2pjdXFpLNZxlEaiJXYVwJPngIlbe5Zv4Zckx+
 FnjMwUxVA/VTgAOzYx+XsNw+O/o=
X-Google-Smtp-Source: AGHT+IHCAn7b+7bWzxUGt+wFrvpqiYipjF5RuWlkDJeotSrgLj+3qNm/mDijfcvSyiuGa/tk/SQysuRzcNUFale7Xmw=
X-Received: by 2002:a05:6512:31c2:b0:57a:33ff:c7fc with SMTP id
 2adb3069b0e04-591d859ea86mr4045267e87.48.1760963901275; Mon, 20 Oct 2025
 05:38:21 -0700 (PDT)
MIME-Version: 1.0
References: <20251020082304.1778-1-briansune@gmail.com>
In-Reply-To: <20251020082304.1778-1-briansune@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 20 Oct 2025 09:38:09 -0300
X-Gm-Features: AS18NWAp1pYTw8olsKjtbCToXogXjSFFpb88no4EoEpZ5aJXdN33j7G-g-z236s
Message-ID: <CAOMZO5D8vtV2oBmrNirqQsYTBbxU3x8TLsmibri2ZTngJM_6UA@mail.gmail.com>
Subject: Re: [PATCH] FPGA2SDRAM setup fix
To: Brian Sune <briansune@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

On Mon, Oct 20, 2025 at 5:32=E2=80=AFAM Brian Sune <briansune@gmail.com> wr=
ote:
>
> From: intel <intel@intel.com>
>
> After testing, w/o proper setup
> the FPGA2SDRAM bridge will not work and stall.
> Pulling from official fix and w/o this initialization,
> both 2025.07 and 2025.10 also suffer stall on U-Boot
> and distro. Any FPGA to HPS-SDRAM action will immediate
> stall the CPU. As such, this patch fix the issue.
>
> Signed-off-by: intel <intel@intel.com>

You should use a real name in the From and Signed-off-by lines.
