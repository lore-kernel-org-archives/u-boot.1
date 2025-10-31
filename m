Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9170ECCF9F0
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 01:49:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22F2683642;
	Fri, 31 Oct 2025 02:48:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mJP5t8DM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75C4383885; Fri, 31 Oct 2025 02:48:58 +0100 (CET)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 815508331F
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 02:48:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-378d6fa5aebso17985051fa.2
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 18:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761875336; x=1762480136; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c+Vyw3IQeiqhqm1ykF5EC1bW5tFSOqPrZ5g+HH4u7wk=;
 b=mJP5t8DM0frokQ/112x/WLjjrX9gqIqZayZOCoqNEGu8hNtpWTEEQrXjkODrSjwJi9
 xFgOr7381x3BWeq08gopDLBJ7zPLN41V2QK6P1g+qwzHuonk4rmk35YsxeUlyXedr4B0
 y+He4hSYvBlck6nr8AYTgqMB5e0w5QvEyf2oZ9UE+bNdiQ8EH/7VprJXX+IaIoQ2qyHI
 iexaggtyCC0xkvQFehSsyFjIBh/h+3vrYqpAI7q5zUuxG/UN8W/pPcbPV3cCFKxqwLEZ
 cTIGGJdwQ7tkm8jR+CBrb+FU5z5FNbZGsoo+cfsB5GuwbSGJ/hbjnTqFssxvQbyysnt8
 5BWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761875336; x=1762480136;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c+Vyw3IQeiqhqm1ykF5EC1bW5tFSOqPrZ5g+HH4u7wk=;
 b=jRDIWJS6zcIWzW4c7MtFCuXxqPa19ZB4BGkO80SQzgurw97vdT/4eh3ZrMJtO4kK/H
 5uxeV5ycYY6QL0c1ELV/cALGX0+V60AfF3ZcRPDK3pelgC1DP8x/9WMhtODG6ZGyvzIA
 9UEm1F406PAM/+lqbnT0gULySIYS345+4iLfLmlQWjI0/N0mHeXzut1jQD1Ya8lY0rGg
 iUg52KhT2Qhbme6r/+KR6ArE2wRvfZ/1LN4nO8+CEepsm8KqZl8sh0w82+0Qgj//eTOi
 hUybxWF0EiNQnxg7JrUk2/cCGJ91SILz1IRWiM2xE2qf3dyIJPKuNR8brsJtd2+3RPPm
 TNAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvANPx/6ErRTR5UJcP0XGLb9M2aiKLzGvUyDWCmYvEpVxfQXRh/DtE50DnW0GepC+gINXbjZs=@lists.denx.de
X-Gm-Message-State: AOJu0YzjNL0JB0Q5QCjJTL5hcBGyD2p38e15084i2OPddyr3uay5o8sV
 gtE6VCLHvMdrTHgN2J5ZaM67FyOpNd4nULWiWvfjh4kELCtvvVO/vNNutKHQ/EVtLZyWzahtNbu
 +59gXVrQI8sWZohAx/gfltH9CWU2gu9w=
X-Gm-Gg: ASbGncsE4JUm/cFFrBSqJegmAFyoNa+yQhNMbg0yGQTu9k1CZze9NgQa73blzg+YYnT
 DnOR4tDR7bhp5sVOFDj0HaiMtIU6P1SXvQKWpVW0Zbt1gfVPXWAdt5+6AKFf96CREeMdLsd6jTr
 r4EVAX9uCazqvOkhgbX+vwc3QSE2zAJNoklkoWKECpnu4Z6pPfwgjyAGIDf+c+lWwT/ftJ+kPA8
 ewdXhHjMTrUR0Kfb86Q/6oYAi5g4MmH8eHaLa0Jm6rhVW+mQkent6ClsCLjIJ4Sf7qmnFDE/A==
X-Google-Smtp-Source: AGHT+IFbVVowh0moH8jN6eHOhaUh9AOCRBXecXazFRPum88eDpJF2ff9emsKQCO7lAwMcDi8RkEBAz4+HEekplCxGLo=
X-Received: by 2002:a2e:8e96:0:b0:36b:b0eb:9d64 with SMTP id
 38308e7fff4ca-37a18dc48cdmr4860351fa.30.1761875335417; Thu, 30 Oct 2025
 18:48:55 -0700 (PDT)
MIME-Version: 1.0
References: <20251027115638.1186252-1-festevam@gmail.com>
In-Reply-To: <20251027115638.1186252-1-festevam@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 30 Oct 2025 22:48:43 -0300
X-Gm-Features: AWmQ_bnWozatA1q4P79NE0Vb8rLQPayU_K9aYSL958yZwDhJGtd57h8jcyWuBxE
Message-ID: <CAOMZO5B1sxS8Vh1awupGZd8oqqLhZ55abME07Kf5AZ-w9jUKhQ@mail.gmail.com>
Subject: Re: [PATCH] imx: Revert "imx: mx6ull: fix REFTOP_VBGADJ setting" and
 fix comments
To: uboot-imx@nxp.com
Cc: trini@konsulko.com, dario.binacchi@amarulasolutions.com, 
 michael@amarulasolutions.com, u-boot@lists.denx.de, u-boot@schwermer.no, 
 Ye Li <ye.li@nxp.com>
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

On Mon, Oct 27, 2025 at 8:56=E2=80=AFAM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> From: Ye Li <ye.li@nxp.com>
>
> The change in commit c1af358cf51a ("imx: mx6ull: fix REFTOP_VBGADJ
> setting") is not correct. According to latest i.MX6ULL fuse table,
> the REFTOP_TRIM[2:0] fuse is defined as below. So the previous codes
> are correct, only need to fix the comments.
>
> Set the REFTOP_VBGADJ field in PMU_MISC0 register based on the
> REFTOP_TRIM fuse:
> '000" - set REFTOP_VBGADJ[2:0] to 3'b000
> '001" - set REFTOP_VBGADJ[2:0] to 3'b001
> '010" - set REFTOP_VBGADJ[2:0] to 3'b010
> '011" - set REFTOP_VBGADJ[2:0] to 3'b011
> '100" - set REFTOP_VBGADJ[2:0] to 3'b100
> '101" - set REFTOP_VBGADJ[2:0] to 3'b101
> '110" - set REFTOP_VBGADJ[2:0] to 3'b110
> '111" - set REFTOP_VBGADJ[2:0] to 3'b111
>
> Sven Schwermer reported:
>
> "These are the symptoms: Very few of the thousands of devices that we
> manufacture (< 1%) fail to decompress a large XZ archive once in Linux
> userspace. We have not found any form of memory testing or other load
> that reproduces this issue. Reverting the offending patch fixes this
> behavior on the affected devices."
>
> Revert the offending commit to fix the regression.
>
> Reported-by: Sven Schwermer <u-boot@schwermer.no>
> Signed-off-by: Ye Li <ye.li@nxp.com>
> [fabio: Fixed checkpatch warning and added Sven's report]
> Signed-off-by: Fabio Estevam <festevam@gmail.com>

Applied, thanks.
