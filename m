Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57B34C19F2E
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 14:20:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2F1880FE1;
	Thu, 27 Feb 2025 15:20:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="U2Es9exl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A32E80FF2; Thu, 27 Feb 2025 15:20:26 +0100 (CET)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DD0780F12
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 15:20:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-30b7f91218cso10169281fa.3
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 06:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740666024; x=1741270824; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IXrObpn63uempOrlBnPIH+iYCkwKQWzi+L53DpfASSU=;
 b=U2Es9exl89qfxiTTNYDHvkrGhjOrI1YE5/Mep62qo8523zSmjM/j8U/JAB7yoKR0Md
 R1GL1LnlO/cfj6JmP9lkd02kzHhCtUveYSuXEr5dxlgZeFDqmGxcKSqRTICwy+dFAPYc
 M5xE8Ym9g++AKv6MbROMGqhSge8UVg+32c8OsGs+Ij/L9Eh4XlbCjL1TMKQ1+9UqMO67
 4uER1/0cQNXfNIqBj4Kw6MNuk/4HOCVchbdBs9yB7nShV6oOz8rolmYWpegxRxNJoJWg
 6A9gC28+o6Mt1NYdXhcX1QbGz3rJiPAmNY2rMJwKyjV8TlfaSyx4N+kuZUWv3KMRuGHp
 QIQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740666024; x=1741270824;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IXrObpn63uempOrlBnPIH+iYCkwKQWzi+L53DpfASSU=;
 b=pfG3qmOJpgZ/WAg6TETY/ZL+44D/VKrjAa3O9Wi+xnm5NgvKg7vr7GSHBsa4FY1BxL
 PozAcxDh08Z5G42soH0ulftAmnRVE8AwN7EwImMHbf+0fAbMeCTyubosh8cg64OWRcg8
 wwxYVGFFwjC+eyTLIrn19rkpSBWLrUlcUa5q+1tw4s3MMIiUfYQ72zigIb+AqYUoJ7PE
 sk3EjNShN0Pwu5K29kbcrd6VfPe4t222QNRZ6+d3fhntSPomDMHWtTOwxtuHGYdcU5+t
 M4sKyPFEIPeBpxqFjOgY2SErSKDjx2sI/D1eDX6gTxF4kt/W+2DLTFWUvNkk1jDB20lR
 6BGQ==
X-Gm-Message-State: AOJu0YyXA1h9TAe4T7yTXuyPXAb3y6mGX6CYOdR9jDVszbJHwczmh+/v
 Agwcb9AlQKe0ak4ZhAwflo7VsFgPwjdpH2juE2+YBi0IXjNjTehvWEUG9eUQ1ykm9ELb9eYV4BH
 B3QMCIwZNJFSeTz9zs/FbJNVsDTU=
X-Gm-Gg: ASbGnctUtxKZhdSnLF8QfEoEfRuFJvU/gc4HeChkbe7puY0K0eNaFoQW4EkmXpnJVtt
 M4/hPjntLDvQuC40m2j/QNvLi8FAxknC0r2CUvN0532jWqk6MzaA9hlLfwdZpq9c12tjineznsn
 BfY5QzgFgC6tlGjC8zwulXDzSLQ8WQiSQK6b8ndCk=
X-Google-Smtp-Source: AGHT+IGEjbrtuyzHnhfvQnbcBnnGbQj3/qzi8dH7G9ociYJK6OFGVngnylGhyuUlmuMoJmGuc1q9XY5CV8kYlEUjKHE=
X-Received: by 2002:a2e:8ed3:0:b0:308:f580:729e with SMTP id
 38308e7fff4ca-30a80c69359mr60115381fa.27.1740666023507; Thu, 27 Feb 2025
 06:20:23 -0800 (PST)
MIME-Version: 1.0
References: <20250131100446.1668349-1-maks.mishinFZ@gmail.com>
In-Reply-To: <20250131100446.1668349-1-maks.mishinFZ@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 27 Feb 2025 11:20:12 -0300
X-Gm-Features: AQ5f1Jp7L-q5cKZCE3X9-bq3ne8ZtzWUOkvK15ngHzC59M65IV5M9jLQBqF2vHI
Message-ID: <CAOMZO5D3+qf3bddOju=0eC9-XNqYC=z4m7j6sjn+21+x2+a83Q@mail.gmail.com>
Subject: Re: [PATCH] tools: imximage: Fix potential memory leak
To: Maks Mishin <maks.mishinfz@gmail.com>
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

On Fri, Jan 31, 2025 at 11:13=E2=80=AFAM Maks Mishin <maks.mishinfz@gmail.c=
om> wrote:
>
> Dynamic memory, referenced by 'line', is allocated at imximage.c:761
> by calling function 'getline' and lost at imximage.c:793.
>
> Signed-off-by: Maks Mishin <maks.mishinFZ@gmail.com>

Applied, thanks.
