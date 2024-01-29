Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F925C47DB3
	for <u-boot@archiver.kernel.org>; Mon, 29 Jan 2024 14:03:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5BD187B7C;
	Mon, 29 Jan 2024 15:03:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="CNPTva+q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4F9187BDF; Mon, 29 Jan 2024 15:03:40 +0100 (CET)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADDB18796E
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 15:03:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-dbed179f0faso2940147276.1
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 06:03:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1706537017; x=1707141817;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wUVclHl+4BS2pXi7+NHrcFUFMEpVtPdUze1Bzszanfo=;
 b=CNPTva+qg7rR1F8xI4kJ4ZZeBnwgETRdFPCkaaZRMbWDDkqVHixja712UcqQ70rBWy
 em+G8JWX6nxUTi+rQA9WcShS9+ZvNz+xt8wqDEzX3zsYoQDHk0da9JO05ddLSCe0wyL4
 qdYb97MwLrWvt259eytum3g2BzZNCQ2uwgQQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706537017; x=1707141817;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wUVclHl+4BS2pXi7+NHrcFUFMEpVtPdUze1Bzszanfo=;
 b=Aowmd3gJT/XlxckOs2HIs0yNQjSi3044Z2HC6SdrN/YuM9e2471DEw6veMW9tEeJO3
 Rhn8gNfs0aMtKqBNqLl9DHu6ha2orQtpR6gZjGMLeCqtp2AuAdOkZCfDrBJlHwzSJAQV
 IahXzfLiyOtG7aFhp1Y2Iaiahq5IkBtxZsuH7qLUG/eCLluzPVnpyMkBsBe3ym6pkylz
 34aTkb4v+j7F9gsR+qI/2hCJOzhkZFPTvZJ3Z8Qf16gRHBL+aucIdd7yFan+uIYIfMUe
 DvIN7u+vz5zLcEMcHocl6TgcF/dc2sJYqzaIPDyiomRrtSyApGcvJTBRWoPmDYsS8ZOp
 H2Cg==
X-Gm-Message-State: AOJu0YzNnClIPZV2i/RToly+uLyKcI7Bs8+28Moox0N41+naQDZtc1H7
 8gvNoOBV/FDwfpQ27vSje3QzJgNwcJXTdhzVeNUsTdXSTno4+XFcZT14QITHL/BHTrPy9rBmy6x
 BA6v5OilXYzI4WXn5QBDT7d3vzVB6VHqTrG/W5A==
X-Google-Smtp-Source: AGHT+IGLYDuhscX7vIGx5aktl0Cikw/XOx+Xy9hQLg7iYvd72nu4ouFsQHd3DjM6S2a0w5EuosZC0bkicK4A1k4G3GE=
X-Received: by 2002:a25:6841:0:b0:dc2:6b6d:f130 with SMTP id
 d62-20020a256841000000b00dc26b6df130mr3573693ybc.19.1706537017372; Mon, 29
 Jan 2024 06:03:37 -0800 (PST)
MIME-Version: 1.0
References: <20240128155458.56712-1-marek.vasut+renesas@mailbox.org>
 <20240128155458.56712-7-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240128155458.56712-7-marek.vasut+renesas@mailbox.org>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Mon, 29 Jan 2024 19:33:25 +0530
Message-ID: <CAMty3ZBnWn46bpBBwte9w_TvBDHCryb7aqt2-+UMmeX8kyRt9Q@mail.gmail.com>
Subject: Re: [PATCH v2 07/11] mtd: spi: renesas: Add R8A779H0 V4M support
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Hai Pham <hai.pham.ud@renesas.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>
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

On Sun, Jan 28, 2024 at 9:25=E2=80=AFPM Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
>
> From: Hai Pham <hai.pham.ud@renesas.com>
>
> Support RPC SPI on R8A779H0 V4M SoC.
>
> Reviewed-by: Paul Barker <paul.barker.ct@bp.renesas.com>
> Signed-off-by: Hai Pham <hai.pham.ud@renesas.com>
> ---
> Cc: Jagan Teki <jagan@amarulasolutions.com>
> Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
> ---

Reviewed-by: Jagan Teki <jagan@amarulasolutions.com>
