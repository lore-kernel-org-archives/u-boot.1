Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47720C02182
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 13:48:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0CD3801CF;
	Mon, 20 Jan 2025 14:48:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="S/W5ejNu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B82980711; Mon, 20 Jan 2025 14:48:07 +0100 (CET)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7717780077
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 14:48:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-303548a9361so36356481fa.0
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 05:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737380884; x=1737985684; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0k2w4Q42Hv7E65ocNGS8dLWd09l+QqTtkN/Bxx6mNYc=;
 b=S/W5ejNuqTtACWzK9Fz3WmXgl3RLv03/4eVb1tXzvkahm+J271Oro2aTFViOigmuKf
 ZVVTTVT3bh29Ynv9EjZQ7LRCDHKywnfdQHBWpxpCht/vNYrVWzOlPaQNJUQbvqfBDRw1
 Kxp0ER0/puUWvdhl67f4IcORkXxR+5Qko8T8jEXC9R8ALpC6WfFWVtSko83uSVAw6KDO
 RTnSm7ce56AMIQ/PaHj8WEUFBWVYp/i1y8UoOGq1AcnluvINAo+VnUHyYIotWQ1v4aIa
 /CWdS0n+aIggIMFrrPESAJNbRd8/p6apqb49PIyhSzX4mrur6cSY0xb8nAfwmou12EGO
 nWbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737380884; x=1737985684;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0k2w4Q42Hv7E65ocNGS8dLWd09l+QqTtkN/Bxx6mNYc=;
 b=vK4PzZ2CvamfDMQNlFCmc9sb6RfU5TR/CKyIhZD7q13nrRky4xMVBkN6MY3mczi4zt
 Y5lf/CT+35XFZ4f7NTL6oGO53MZEN1HJeOv9JqWuYbgpsb3QBKD/XND+JTQ2UiObI5T6
 QwZZ+ryVocukaZthPz7XJQw2a9FFwFUI1F0X4b54uyodmUr978FV5KBakID/tY9UZs+M
 47v5DEsaAsrpFbCVa6nnEkX39EztUaNTuWP2weD8MKfo1c9lsmMNakinbDICq702Nug+
 ryw+mXGn/9fTGBUvaQkzEse85FtjwVz21WeD9SQyKhPqapLAUc2YQ9gGTHS3o6XMN3mD
 C15Q==
X-Gm-Message-State: AOJu0YyKJ6dF/T83hmVj1WgnnbwAshc3lWG6m95VDOn53/hZRbzhN6Km
 /0E7D1pLLVEgXmc0pFzuTnn5KamXtW1R/q+U6xOeTh+TGsLsdqpztehUTHQiOK68DeuX4RUypgh
 +lgVaYsWtZ8oItx2X4ywawg9kQ+s=
X-Gm-Gg: ASbGncv3JcgH7LILmVbwPeYZ7z3vC0jr++zbjd73lNLuJlZMMKJ0zdkv2GIQjKYVUsc
 EKMoU5l/LdO4B1BOftsRttZeAy3P9UxgPgfhTKkBiKzxeO8JxIuxCnxsdFj6N/b+jLpcLpzUVJQ
 XCEfct/Oc=
X-Google-Smtp-Source: AGHT+IFTQa2mlvQHQCSq/N+OKEZ82hbh47L53LECH5gb2FJB6yc333dqfPhjKEaOYepT/gTqia3PoioYSxyykP80zGg=
X-Received: by 2002:a2e:be1a:0:b0:302:189f:ea58 with SMTP id
 38308e7fff4ca-3072cb13467mr47572181fa.27.1737380884397; Mon, 20 Jan 2025
 05:48:04 -0800 (PST)
MIME-Version: 1.0
References: <20250117132013.123064-1-l.anderweit@phytec.de>
In-Reply-To: <20250117132013.123064-1-l.anderweit@phytec.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 20 Jan 2025 10:47:52 -0300
X-Gm-Features: AbW1kvY-mbaR0xeDMvYYNHrLdm264S45dOn0fCzewQev6hARmw1bEGbIjlbdgfI
Message-ID: <CAOMZO5CXrUfn=EH2zD4yoLtC--Hv5THbdHUfOFpuiq-RG2WLVg@mail.gmail.com>
Subject: Re: [PATCH] phycore-imx8mp: Enable CAAM in spl
To: Leonard Anderweit <l.anderweit@phytec.de>
Cc: u-boot@lists.denx.de, Teresa Remmet <t.remmet@phytec.de>,
 Tom Rini <trini@konsulko.com>, 
 Benjamin Hahn <B.Hahn@phytec.de>, Yannic Moog <y.moog@phytec.de>,
 Wadim Egorov <w.egorov@phytec.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
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

On Fri, Jan 17, 2025 at 10:20=E2=80=AFAM Leonard Anderweit
<l.anderweit@phytec.de> wrote:
>
> Enable CAAM in spl.
>
> Signed-off-by: Leonard Anderweit <l.anderweit@phytec.de>

Applied, thanks.
