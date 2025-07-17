Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E05BC83F1A
	for <u-boot@archiver.kernel.org>; Thu, 17 Jul 2025 16:33:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F13C6834AD;
	Thu, 17 Jul 2025 18:33:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GjUoZwLD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D369834B4; Thu, 17 Jul 2025 18:33:53 +0200 (CEST)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FE5E83496
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 18:33:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-5561d41fc96so1377407e87.1
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 09:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752770030; x=1753374830; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8DwR+AKfEtK5lQjIRhCA4ZiyUS9NHHZ3ETui3g6AGx0=;
 b=GjUoZwLDsnHNbAUryj0fmAAeGYQIKThFTFb1pZn+H5J/DIk9uhQAAXXrYR6+xxAbmn
 +ODs5OOEOdfUI4RfWMjiDzSDE1Pn+J4+eBy/9quqwUzmiTTvOF60GYSMQ1oHY4vuGsD1
 jugN/fA0H/XysPwnOzjg7lTVcWCyiA6RHyVGywMRcFYYvWXFRXEK4yotYbF0vBBMrfYD
 Z81tf7k+0k8j3N/2oGCm6KWMXz2T4jvDiu0C3WEA5fkneOevYS5N50+xCu9ijoTvM1GN
 C9pvPzCgvjZsvzACoThDO/jAeO8H99nQif5ytnfQtFD9sXKBqB+Df+BKgODSWW9JIx0j
 bx1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752770030; x=1753374830;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8DwR+AKfEtK5lQjIRhCA4ZiyUS9NHHZ3ETui3g6AGx0=;
 b=qzuwBjDYDR5ZuC39NBxHflzOv0dMn78Kouph/3BqpVTWNxGQqaHuUskkSswbKA0+8N
 l2YXv9dG2rw/lNVmeEk699U3BTipQw8K7zzsy30YQwCUzYnAKBlup1Dn0VqjfHBm8oGi
 TAG38/ZRfnEoOC0xyWCa7SJ4/awshATqQcTTzJ8Gj9yOwMoPficV6x28UFA+UTQxOqFW
 gk8hZJuDgIvYxbh537Q+8zl5YA1h57XRwz9jN+dXsxrFilL8fJRyCmmj7RVS9gCJzZ0G
 fmtKH45DO3FvTkgbVYrZlc1N1/X+l7Rd2gamr6OuY0qIs0flsiNbCn58AZlRtbfDguKQ
 Cdlg==
X-Gm-Message-State: AOJu0Ywd1g5gvoShguE5egVfJ83u/LDNPU/jUTrIJ2d9p2bJaaRFagdB
 G1vaF22lMGomHvFOQuW7TDQ2esZ7s2LwEw15uMmYAM3a/Tm/Ot2wIoRAsmXgwnWiaMiUcs2saW3
 HDtLsUPAaEBE8L+6sP07YYJyBr/AEHAs=
X-Gm-Gg: ASbGnct6WXZVR+TlOSc0IcL0JLNWI4o8YnO+uSqm/Jl+yf8xzwjw0TvCl+l2Eu1TTBl
 RZ5a3Ai2M6icmji3lYA7BBzO+ppC2ce+pjrgmo0VGzAteM9cFEQppzxrCsX3wWCg2dAw+dMyvOc
 0bjwgionql6XiTeqheHfDFnpwfPfNWwSQ3ZyF5s1GwGHiZb4A+oqRiuKKVegNyRaI7t86hf7czu
 kXkFTzM3XzBcTErQo9xg3aSRleUv56UxJSj
X-Google-Smtp-Source: AGHT+IF6gL/l0U8RDAsiQkWR49xG7EA6j2mH7Yj5C8jbwJkq7ePpCZNydJiTYa+g3oThwyniUG8AUXzjxbXN3LA4qsA=
X-Received: by 2002:a05:6512:1113:b0:553:d6fe:b9e7 with SMTP id
 2adb3069b0e04-55a23fb2546mr2587142e87.51.1752770030165; Thu, 17 Jul 2025
 09:33:50 -0700 (PDT)
MIME-Version: 1.0
References: <20250714114347.2455172-1-holger.brunck@hitachienergy.com>
In-Reply-To: <20250714114347.2455172-1-holger.brunck@hitachienergy.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 17 Jul 2025 13:33:37 -0300
X-Gm-Features: Ac12FXyMgT3ACZMlTsQbPlkoH-EfcHX-Nhj48idJ5uZKkwSclAJL0JRVJM1FCu4
Message-ID: <CAOMZO5DSOEhBeM_tLTp0E4UJbahcvL+=kouVcNuB_kPGmpt20Q@mail.gmail.com>
Subject: Re: [PATCH] armv8: ls1043a: make some erratas dependent from USB
To: Holger Brunck <holger.brunck@hitachienergy.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com
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

On Mon, Jul 14, 2025 at 11:10=E2=80=AFAM Holger Brunck
<holger.brunck@hitachienergy.com> wrote:
>
> These erratas are only useful if USB is enabled. If it is disabled
> these erratas might cause issues.
>
> Signed-off-by: Holger Brunck <holger.brunck@hitachienergy.com>

Applied, thanks.
