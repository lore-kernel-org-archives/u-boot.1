Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91779CA0FED
	for <u-boot@archiver.kernel.org>; Tue,  9 Sep 2025 12:59:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E714C83106;
	Tue,  9 Sep 2025 14:59:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Uh0+dUT3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D1B383106; Tue,  9 Sep 2025 10:46:30 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62BB380422
 for <u-boot@lists.denx.de>; Tue,  9 Sep 2025 10:46:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sidharthseela@gmail.com
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-b04ba3de760so350120466b.0
 for <u-boot@lists.denx.de>; Tue, 09 Sep 2025 01:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757407588; x=1758012388; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6W0vEuyoK6VMOlzA3TiVbQhsLo69tRRYhcaXw6uic6U=;
 b=Uh0+dUT3Y90F7CH20zNsg8rGM4OsWgFZ0rxLjEgQURsb4cUp4a0a5X7p5fQT0uNaan
 G+SqnaZtT+rWFumUMeYZrlGOF1oB/iisqid4YLUDF1F9q+YXhP6MNn+aj0DEzpCEhsCv
 YkkQY4Kh076QGAW7PWdHcIcLydz4HsDrCH4/j1eQK+WA/I4wZUKEABeFb3r8bip/TS/b
 2CuHdv6LAGZmvj9226DSGgR/t4xjzGtnXQDX62NlUtrSwn92bu80/R6RtB5VLUAhiyZz
 jqxpTzH1LQnGA8680KHs9C4toDhPgCMwj99kJ53vh3V5BbVSRr5fRh1R1CGnQUYi7k5b
 fvJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757407588; x=1758012388;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6W0vEuyoK6VMOlzA3TiVbQhsLo69tRRYhcaXw6uic6U=;
 b=FC9uztDsxRgjZHnr7YBYx+uupNEUhAISaHFGko7XoBdI2k9vvQZxQFibYnQEXEKFgc
 veiVYVMnqFjgHnwYdrQ1e6O6iAOlwJgafPBCRxRyKHzjDm/2nvh1VJcL+SQIG4bCG0Ka
 bmLTPpwEhKSakquzn8lmGHvm9ZFA68+zrqaGRhQzoyClBdq4sPVaE0Ps9WTR77tOaTpV
 NeAwqOb5jtcKbWnCi9fshTqNy5xojP36wphBSm/83a59BS8UhCayDupa8B7JpNhC2PQC
 /gldSSO/l+iIINH4agTzYTbcFlciRkrlHPk7fLwQVpIjSJdc2uJwzESi+P9nZCdDGtzA
 ucPQ==
X-Gm-Message-State: AOJu0Yzp/MZvJGSTu2C3xQ91kQ5xwyyP9Wk6oKW9TSUDVHQqJbxvJf6E
 OJP2Ypl3s7IJN2b99FXrENijvm554riU9Hp5qx1L6NMBur/Z7dtU/SQlKAEk0haNXtTYTutRtG8
 vTqnOnFzlbpP/bvZOtgdXd9uxB+nR62X9bw==
X-Gm-Gg: ASbGncvbLGeGsqo5KnTJ+e3BUFei6fxqjCc1bGOScUr7MY+3SXJhsRRulyQNYFFcjhj
 v6LsmwArd8fwAzPV3LNzZPPItAkogeLXuY2dFZ45nmaNzVUWzem5O7MnhIcnUZ7KArUdutxuJ86
 k5YG8tFhbowtWBdylcxLJwfzxApiOCK6t6h2D7Ts1/KKDtDjJ+jkzXEMcwnjwOgMumXf7i6TJ5Z
 7SWSweT
X-Google-Smtp-Source: AGHT+IFrcPqXOr+psNV3XKXq4GanuZuL7vboMzkShLp8UXNXAIlqfOZCC1TfU2KGiUvgOMsuv+lBRzEmtMogvQ6l4Qg=
X-Received: by 2002:a17:907:6090:b0:b04:1457:99 with SMTP id
 a640c23a62f3a-b04b1451f8amr1109366066b.14.1757407587654; Tue, 09 Sep 2025
 01:46:27 -0700 (PDT)
MIME-Version: 1.0
References: <20250903202043.285746-1-sidharthseela@gmail.com>
 <20250908055429.598536-1-sidharthseela@gmail.com>
 <20250908215825.GT124814@bill-the-cat>
In-Reply-To: <20250908215825.GT124814@bill-the-cat>
From: Sidharth Seela <sidharthseela@gmail.com>
Date: Tue, 9 Sep 2025 14:16:16 +0530
X-Gm-Features: Ac12FXzLzv9xgCNo1zTi2AO-yUgzvhKfXx7jJTFa49KTvJwSiFOxKeEy3GaRaaM
Message-ID: <CAJE-K+C0FHwxi4DneqqasD0D7H73BNk-ZO4GE+ZWSN=a0fdtqQ@mail.gmail.com>
Subject: Re: [PATCH v1] doc: board: ti: am335x_evm: Add documentation
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 09 Sep 2025 14:59:55 +0200
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

On Tue, Sep 9, 2025 at 3:28=E2=80=AFAM Tom Rini <trini@konsulko.com> wrote:
> I think just documenting it as per your patch is fine at this point.
> It's not the default way to use a platform.
Yes, Falcon mode should be used more in my honest opinion.
Thankyou, for confirming the doubt though.

--=20
Thanks,
Sidharth Seela
