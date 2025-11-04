Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3EF8CCFA04
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 18:32:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42F4D83655;
	Tue,  4 Nov 2025 19:31:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ShpbFnOy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 855A6808AF; Tue,  4 Nov 2025 15:54:58 +0100 (CET)
Received: from mail-yx1-xb132.google.com (mail-yx1-xb132.google.com
 [IPv6:2607:f8b0:4864:20::b132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1E1F8004F
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 15:54:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-633c1b740c5so5251276d50.3
 for <u-boot@lists.denx.de>; Tue, 04 Nov 2025 06:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762268095; x=1762872895; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YvPM66gKWTOzldNBR7QSz8YehQh/qOUdISS2BEivRcs=;
 b=ShpbFnOy9rTJHNyy3vs/7BTMgISkcmAWQZ6ihq/5N+v+oK2PHORPAyc/ut39GXYk5o
 5kpuhc/6tXaHMX4wgL9wBszddFoTRw2A0StVN3Wq2F7q4ogJSw1VZot5ACFFG/xzC/3H
 wRYkA+wvyTeIxfeA3j5JovOzpLFlRdv1s2ukSIy8W2+Ym8ClXVxQ4lj2+cDCOmX+4rdF
 LA0WyxzirHMxesupFYszor62OK5Cm8sDeXtwIH+QCN+jceggTcAy8nPhD8GehLn8Q46S
 49lbXoFvn2j6cSEU0lhvMh7HPpdYiZyUzk22I88/Q89Y99lYQMa0pW15/7ni8LMETni5
 gzQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762268095; x=1762872895;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YvPM66gKWTOzldNBR7QSz8YehQh/qOUdISS2BEivRcs=;
 b=xIZuCVLh8qUbiMdK3JvTvajXoKEjZ0xzIPBZUXgaMk3u55Ey3by3Skii9aTH/pai7i
 nOPAVTHn1DrMiVkW6MdztlSWmCu4bkkYEBBjokhhke0OHCcij3YKx/ySzAp7J2KCt45z
 JJxXiIBXkjfJSovfPJmjvW+5R1Or4ZfHQjJYAj8OabS54BWLBm4PCa1ZiU3EVmPJ1nk6
 6Ev+MUicNzIwLE9kamr6TfnxBSxoJeOdGvxVDEbdEUpVjzUXNCUzh4DJXXGq/3WsWUlj
 sPLReCK9BLG/d+Xs/Gg0G2Yyo9DOVaAM5kXKxRmP57uWLacM4/Zc5t5ZLRS0qbw7FRMY
 Qp7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFcJKTkz5coP9JHv97oxXAfkKBW9RfrI4dj8DmyJHQzbb+ihuGkfbqmV/+02Wq/RSsBpQpvjE=@lists.denx.de
X-Gm-Message-State: AOJu0Yx1JjYu2JhLRk7QcdKl8/3pTzB9dXxXFE91VPQWgNGjh+qFZUPV
 7hfXhjhgcOVEtlK3G8LJFYSUTzsVTOTrMfAEPAWWnhGvBnEL8zJzhY2oy4U6gi5ps+cCD9LmFUT
 vKH/UIW2fvJWLxHHYEj9JjbzRHMf0rqyHqw==
X-Gm-Gg: ASbGncsr1uI7ZDaCYwslhGCxvwSm0yKa7pXxfzRSVahW9tJd7+OrvOnAWKwPO+sJN0g
 4SZOtoNsF+S3YQ6Ava7aTlwTaUmlkQXChCZK9QdKusbD+r6V5DWS9AyZxEOyTCRzrMuHf+ndeq5
 Zm7Q3LhiIjnxtNKhGjpD5VUTwi2NM39B6LPNQru+CMV69PFNoxq+o1DMy3CG3qPjKso1sPF6WM3
 2MZ0fFuZO7v/w0ZVHeiD7Adeg6EFiKHPMJL1NpYwiX0tVuc67Ywqz1lb90g
X-Google-Smtp-Source: AGHT+IET+wVMWk3/P1XTVYDCRx8JZuaMOFnBoXy7YW1KhnFqoZ98Qy9qIVp4HFdKpFDmrutwuRgn9An66r1cc5F4n1M=
X-Received: by 2002:a05:690e:1c05:b0:63f:9fda:e7f7 with SMTP id
 956f58d0204a3-63f9fdaec90mr9655281d50.53.1762268094569; Tue, 04 Nov 2025
 06:54:54 -0800 (PST)
MIME-Version: 1.0
References: <20251104110240.62368-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20251104110240.62368-1-heinrich.schuchardt@canonical.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Tue, 4 Nov 2025 22:54:42 +0800
X-Gm-Features: AWmQ_bmp-jvP2s_BIc_uVqxMaaNBu5RBmteO2mAgTfIw1X2KCZPPAa6s0EhRR90
Message-ID: <CAEUhbmUfd3-HMWiVNckut4o_Rt55xk6vu8QahkoSeFaZexKguw@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_loader: correct struct efi_priv description
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tobias Waldekranz <tobias@waldekranz.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 04 Nov 2025 19:31:58 +0100
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

On Tue, Nov 4, 2025 at 7:13=E2=80=AFPM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Add a missing colon ':' to match Sphinx style.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  include/efi.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
