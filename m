Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 788A9C19F2E
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 14:21:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0017E81110;
	Thu, 27 Feb 2025 15:21:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TUh6wmdy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C277A80F12; Thu, 27 Feb 2025 15:21:53 +0100 (CET)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41AD7811A7
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 15:21:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-5485646441cso1042390e87.2
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 06:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740666108; x=1741270908; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QdWtn5a8qbpOPrpMCCx+yHRkQWfVFFiw3YyTR3VDpR4=;
 b=TUh6wmdyQKclzsvMEzX3T+6Xo4SvoK68IaxkPitIJ6yOTCZyFKV6M0ac9BCZiKUiZl
 JjU1IYza9IXkGvxIIigg9HKTv7cxP8c0PcqpMOQ8uHDzVXlS6vr7HkuVVllaLnGVr5pR
 YxRu8Jl1/kS80ZxN06eveXpQBSLV0RNSdz8X8VL8kgf9Pw+nzSPKjonYQ+Pi3TohBNl2
 HayjAi+GEavKjtoVflrip0lxXdAAOqk4oSQKVkmlyeEroejKrrk6fZ4K2D16uf6qfOzU
 eFV+Lh44s8cDJniiV1lBJeQmbjs4tx/Pwwp18Wlw78xcz2omOKecQETVHOXEULNG/pZ1
 piYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740666108; x=1741270908;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QdWtn5a8qbpOPrpMCCx+yHRkQWfVFFiw3YyTR3VDpR4=;
 b=sHvV7jErhCQby7Y6k2moz5Wsyg3bffAgA/9I4XPDffZXpO7Kq6Qpu7SMUcYgv8VuLw
 3AplnpV7WkJSvRRhb5SfjqOXubx9zAt/yzvHi6FO0OAMOuBzVfi5taLeQmoP0rhM1Usi
 FkQdQ+Nxo8UfsIIrXfo/wEJbQ7FzjiwvsmPghyupgQ1WRqoGepnD++glHRGV+bIcT7bS
 bc4ywgm/8+/bhUO/+V+QAuXT9KCpXfo9OJV9KOr1FXO6bOqyjokIGIejctitzHj4vPRD
 yIVe49GCRY8b6opT2GGcH/vYmI0ret19kR49LajhM+JbEnjyweH2sN/O5IBcDJyY9Dem
 8nbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUn+gd0l7YBHYNI9c+znrA3ufN1pdvqHC/PLJW9L4EiWzIbKZTDcjYVRX5j0NGcbTaKrNY0OEY=@lists.denx.de
X-Gm-Message-State: AOJu0YxQBZqeErySbNOkE5LV9zRhhETo4EgMZTL3gMHlcAAZ4y7zC3eT
 +YaXEdTmG9Ks9a8AXnbrFvjxM8clHVLQE/o8EfJ9xySh2L1AdNgphV0vEtP9FVdTemyRLdjJoHO
 g7JxNs+9hyUnYjpYuiRTRcKerxOnS8Q==
X-Gm-Gg: ASbGnctxSYPZxnsFjtdzCmqbBoChnNBR5FWeBpZG31iOXBVQiBh7PA3uWlQPDFshRQp
 ia0bRQnIOeS7xJglAxoScINmO88o8GKN8Z+ygLiNnV3Avj81h9K4LpKRmNWvvsENl9a6/Odqxjb
 R2L1yfd18qEisVrQ33LddUTC+6MG32IDXv1p/SO8Y=
X-Google-Smtp-Source: AGHT+IFnzRcV7NxtZxNXkkGg9sN61scqaJ5Hmulf4DEcoN8EUAaELLodt2RF1oAHN+hrpYRapBFyfMHaX8fRBje48o4=
X-Received: by 2002:a05:6512:104b:b0:545:4cb:b25d with SMTP id
 2adb3069b0e04-548510d655cmr6679806e87.13.1740666108415; Thu, 27 Feb 2025
 06:21:48 -0800 (PST)
MIME-Version: 1.0
References: <20250203125949.1622368-1-festevam@gmail.com>
In-Reply-To: <20250203125949.1622368-1-festevam@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 27 Feb 2025 11:21:36 -0300
X-Gm-Features: AQ5f1JrceWL6NBZPCI7VCC2n8nk8HIx1H2AakWZL-2euwGaUV1bU2D5wAshZfEo
Message-ID: <CAOMZO5Cvfme5u=YSvRcq9VmQjhjt1KHt-rih6zGMaAzFjkGdPA@mail.gmail.com>
Subject: Re: [PATCH] imx6q-lxr: Convert to OF_UPSTREAM
To: festevam@gmail.com
Cc: trini@konsulko.com, u-boot@lists.denx.de, peng.fan@nxp.com, 
 Fabio Estevam <festevam@denx.de>
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

On Mon, Feb 3, 2025 at 10:00=E2=80=AFAM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> From: Fabio Estevam <festevam@denx.de>
>
> The imx6q-lxr devicetree has landed in kernel 6.13.
>
> Switch to OF_UPSTREAM to make use of the upstream devicetree.
>
> Signed-off-by: Fabio Estevam <festevam@denx.de>

Applied, thanks.
