Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91B07C369DC
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 16:09:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1FA182103;
	Mon, 28 Apr 2025 18:09:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BWDtFERU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9193A8210E; Mon, 28 Apr 2025 18:09:49 +0200 (CEST)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90BDE8056A
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 18:09:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-54c0fa6d455so6367675e87.1
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 09:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745856587; x=1746461387; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qWZN0vk+mTOC50xTf8+D+c3KhT56RcPJzZ3KHwOEulM=;
 b=BWDtFERUnkpQAeA+bOXqaawA3mLKh2xo7H9lKIiVLWGkb1E3wAveCx6FOv4PZ34Rbf
 q8AkZepRu18VycHpZ05VteNhBvBA97zZ0vWeP1U4y1cb3c94fIYjIQJ7ADCjDWey19mL
 E1mTHz/Qsn/rRLvBRt6UOgmN8rTLEki+ogweoa8EsXTLjNl/BlSwrt+RXZcwSNF2nf9C
 8WfpFuk5OgoHGc1k09m4kJDgzaAt4+fIOJLlN7EHBATUGRgWyYUgXjV+1jVF/1CGCBYa
 0aVLpA8MSdpzcmkkP7bqwE2J4KXS1vxcNFhFCINpgqCnEgR6Zc8O0ksNPK9R3VubSUqF
 zJoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745856587; x=1746461387;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qWZN0vk+mTOC50xTf8+D+c3KhT56RcPJzZ3KHwOEulM=;
 b=MfW13rQ8w6RIVnvxDtgkws5cRATBLku4eHYEvxkdsVHML+iLNRkoMNerwc46+onHRq
 QRGJdRzPf7TvExIYwX1R7iye5ys2bbDfeE89oJNuXRv5w75cOD6AcISvAtcYqtoo7lqq
 ocHRzDpD3SZUM/coLfw1BnPXH4gaCn6pmi6pYMYJrLBjGp7loZ/KGbNl5uc1Peq/DrJY
 zAlgl7U7dUjYzjWhZWFeQfA/WfbVaWT81dfyPZUZU6tn4rW4nMRp5WfQN3mnVgwdlKUr
 PcN6NiLoQWDqzox5zEXaXzbx+JlZRvlnpE5T5cmIFCINGsqVd7bjZdkMpnt9plhocBcQ
 lv4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8LomLRChBees6JhmkO/EtLKn25vRG40pzo7cwoEE4kmCQhea8FORrdCmzebEXt0H2GPfo4x4=@lists.denx.de
X-Gm-Message-State: AOJu0YyRLBtOJaThzqRnXhVlXd37BqCJl1bSYW/CJJW+9YD8pQnrGnB0
 WticEIlzt52XF0pfdJbVc7L5KizmwNyjv+L1U/AIvYUSGysqm2FUvOvSLkwFZD7wVd+tYIq6zif
 Sb/YMaPb9o1lldr0rfcqmlOHJXjg=
X-Gm-Gg: ASbGncuLCv/w2mxzdwmrJiPdyeKcBDcVnjygYVBMqyfPCsagpIqiY5HdhQWXesm+C9v
 kQv/m9UPDrWZipX/93iR4I4qUHH6rVYEUZ5MrVa47AwImDr4pKih7cV4g846R0KA0C++URN8ngp
 OB+n/8/kOEW2UiyraDt0C8+AnfnRPR6Z0lQ30TsF73zuyNM/o+EJ7JtQ==
X-Google-Smtp-Source: AGHT+IEDEqmOJVHapK46Uo8gHLJ3a9NeYkWyFkh7Akfu5t11n3MApw8lzChPA6UFIDBko8X32cD3QH09Rah4l4O0SUA=
X-Received: by 2002:a05:6512:1391:b0:545:1049:eb44 with SMTP id
 2adb3069b0e04-54e8d18d767mr3450849e87.36.1745856586620; Mon, 28 Apr 2025
 09:09:46 -0700 (PDT)
MIME-Version: 1.0
References: <20250425173901.1965597-1-festevam@gmail.com>
In-Reply-To: <20250425173901.1965597-1-festevam@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 28 Apr 2025 13:09:34 -0300
X-Gm-Features: ATxdqUFYCjgoyZ2NAiWQ-IaSlWuiAUS9xrrWX7yT06jwprV3xF5SY9iQ5WdAjOA
Message-ID: <CAOMZO5B_XHEMZnmt7xaBYqmvwhiaxtuROBM_X=Mv7owASZg_KA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8mm: Make osc_32k available in SPL
To: marex@denx.de
Cc: trini@konsulko.com, aford173@gmail.com, u-boot@lists.denx.de, 
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

On Fri, Apr 25, 2025 at 2:39=E2=80=AFPM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> From: Fabio Estevam <festevam@denx.de>
>
> Since commit b4734c9c333b ("clk: imx: Convert clock-osc-* back to osc_*")
> SPL takes a long time to load U-Boot proper on an imx8mm-evk board.
>
> The reason for the long delay is because the osc_32k clock is not availab=
le
> in the SPL phase.
>
> Fix this problem by passing the 'bootph-all' and 'bootph-pre-ram'
> properties to make the osc_32k clock available in SPL.
>
> This also aligns with imx8mn and imx8mp-u-boot.dtsi files.
>
> Fixes: b4734c9c333b ("clk: imx: Convert clock-osc-* back to osc_*")
> Suggested-by: Marek Vasut <marex@denx.de>
> Signed-off-by: Fabio Estevam <festevam@denx.de>
> ---
> Changes since v1:
> - Sent a standalone patch that makes osc_32k available in SPL. (Marek)

Applied, thanks.
