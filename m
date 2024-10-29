Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79B70D3A66D
	for <u-boot@archiver.kernel.org>; Tue, 29 Oct 2024 16:06:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B54C289174;
	Tue, 29 Oct 2024 17:06:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ArIqCrSt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9701F8917E; Tue, 29 Oct 2024 17:06:01 +0100 (CET)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFAB688EF7
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 17:05:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2f7657f9f62so48960421fa.3
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 09:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730217959; x=1730822759; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UEo/ihWjxrIg/uLX6NcmFdLWWqNiJtRL/o0PNRZBClU=;
 b=ArIqCrStIsH8qz95pRl6Cy6LvnX35OPKoOf+F+b2m8xFiFrf1tv07u2y+0dCQvNp/b
 4jKn4/xyakCS+vz4mXbKGWO0VuWyNwSwX1YqUdAHgqLwYjxUAIP/1lGQBLb1TtHvB2y0
 UtA4aNRrhaPvq4f0wPGtmBcfU2/hao9yACRXBIHCAidf+XzfIro48V09WDmNUxCNylxc
 iTYBd/yNzVZ1YkQbaK6nb9WEFIHKH9J3N+gp9K6X4uDee+xhUy+zT8nyVTiLLB891QGY
 M/HiBX2WplNNMsl/SS+Xq3YZcgI1P4s9Tk/xDznaQWphmvA1ya6mjftsFsQGTg2q2020
 VYFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730217959; x=1730822759;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UEo/ihWjxrIg/uLX6NcmFdLWWqNiJtRL/o0PNRZBClU=;
 b=VYaxxwlgt5yCJOjxmtlL1nqG8lTbDlM4JT48IsAWfkRdZdiLqDKVx6gxhXoXYCWwkI
 c3hV/vQZBesKF/Ct33XVywOAPYywNp7MAlSPCxusCIZzfbNZm1ocTYJLa8p5m/3EeSWB
 i99Z0jaNAvCgn9DwoyZMByEF1LzBsVhE7wsPwLBbQZlSvBHB2Y+ENaKFppYzPx6tzCBH
 YPLRvLN/3jnSmFxJDlaZ5yxVIocR+yyF/ojNVmOx9coZeDU+SxYVp79OG67JWBr3UbUq
 wgi5QlIDLOGy/RFvBzRHdb+noOsTqk3zHM5aqH+x1a1ANGvxJ9zTkmX3XNk33m8kC8+6
 2boA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZnROU7bEe+XUoJXu+1sahv0WFjyPEMRuBGuQKvidAXy8+l/0+giKtEo0NTJbUnjap4eFsFUY=@lists.denx.de
X-Gm-Message-State: AOJu0Yw/xckNXwfDj42+/befjsnUurTG9cCt+RVJp0eb10LvJH+ULp6Y
 hbQJM/gSx5hCaDfjDFzpwdJ+giF0QYvIOhm8y5b9L4kPgvJYHLFz9PT/zqxDlISkLJoLJoN5ow3
 lQnmY9AIBVyaHAaiqg30fIStgrwg=
X-Google-Smtp-Source: AGHT+IEbqyXtDXmxMG0mVkKr1FCJ6/OFhKvQzS9dKLTsb9kqLRZtfyPEzTE6rVcEsK5tpwvW4kzQEAseDjG8qoyKGao=
X-Received: by 2002:a05:651c:50b:b0:2f9:cc40:6afe with SMTP id
 38308e7fff4ca-2fcbdfae574mr63902441fa.14.1730217958603; Tue, 29 Oct 2024
 09:05:58 -0700 (PDT)
MIME-Version: 1.0
References: <20241007130109.227305-1-brian.ruley@gehealthcare.com>
 <20241021073749.63-1-brian.ruley@gehealthcare.com>
 <20241021073749.63-2-brian.ruley@gehealthcare.com>
 <CAFLszTiVrdqvixoKH4nhTadcVOFo0TJ9kFTjDish3ZBuh-YgGw@mail.gmail.com>
In-Reply-To: <CAFLszTiVrdqvixoKH4nhTadcVOFo0TJ9kFTjDish3ZBuh-YgGw@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 29 Oct 2024 13:05:46 -0300
Message-ID: <CAOMZO5C2q3EUAT3VJrtA5Mkk4fnOa7gz-cJcXRKbFwatAcm2OQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] binman: expand test coverage to nxp_imx8mcst
To: Simon Glass <sjg@chromium.org>
Cc: Brian Ruley <brian.ruley@gehealthcare.com>, Tom Rini <trini@konsulko.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, ian.ray@gehealthcare.com,
 u-boot@lists.denx.de
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

Hi Brian,

On Tue, Oct 29, 2024 at 12:52=E2=80=AFPM Simon Glass <sjg@chromium.org> wro=
te:

> Could you please rebase on -master and resend?

Please copy me on v4, thanks.
