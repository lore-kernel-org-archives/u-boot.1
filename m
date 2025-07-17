Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE732C83F1A
	for <u-boot@archiver.kernel.org>; Thu, 17 Jul 2025 16:30:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F24E83440;
	Thu, 17 Jul 2025 18:30:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="F+SuSD6g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33B2D83444; Thu, 17 Jul 2025 18:30:13 +0200 (CEST)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 424078343B
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 18:30:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-32f1df5b089so11443691fa.3
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 09:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752769810; x=1753374610; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=swAD3jn+qqKGqW79PE7LPIghBjbPSjGJsBUQIl38uLY=;
 b=F+SuSD6gXWpln/hZVjP5PDWdKyLSvkupXdCgRocg0ROCKOmXqmInM3yt1hlwAgkzG7
 6AZf0WW6A41FHzwIeF+/uF+tWsBPE7dbsj/dYIx7HKzFYXUTtq6L3xREbWeIyL+uAVvw
 47OsKoa5evdTX8PRsKAs0V1XUpSPUvcj4SIxENblapUZoMwxF2PIlloEREPLk6G81F9K
 FnK5IPyIBw7FJdeJA4A0newi/dhEciY7/uBherTi7NLFFujh0QUJRSki9wyDKGqSvZjy
 wdfHHeFF6xvgNBRDkav+SUm8BMx0JeweNNQKang8+ztA8aOUtGsaP4VbRjGZ1M0x3HbZ
 fytg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752769810; x=1753374610;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=swAD3jn+qqKGqW79PE7LPIghBjbPSjGJsBUQIl38uLY=;
 b=bqXU7a2bFZTkc05gjJswmfCwa54yS6Gcl2vsmijMEjhCi4zfjWCFGzjT+OzjLzPkmN
 GLEFxaEVaqb6fPiahWO/E0IiqdBNFHjRfUSLSCvVhhV1I9KieOathbaaSUtG1HWqDFIR
 9ucvrNv1iCamAjMpch0bftfZH2PIFbgr9+CrnRLlOAX/OP846VhyRih5e0s69/KbbvYu
 TgKXBL0KuXe5PsqeSmT74tWhwpOlk3OOMKletCiAcf7SrRGWZzyIUlfWeApx7KlfbnC8
 RyFpvPYvyODfRNuhk0DhIunr7LgMNFNwOezBTgkzOz9Ne95IgXcwEZlvwtQtOXQG1rgH
 kZTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUK749lRlJiDYRORV6fvFg6uUCvp4xypbtG4kVSIvWCx2XLvNqAvhP/qo/IV/WGrvPuejUCpg0=@lists.denx.de
X-Gm-Message-State: AOJu0YxRAT4Q6iCCoVxc+2jZMRB2G1DYTucAVaHbYYmcPsMd1g6w2ztj
 LzSPHovzGhix2VH6wC0P+3xt0rQhdTwkvpGpYmErX+4m5rF2U+Vi3PfxEQOyo+AM6cwiNwEQx6v
 smyxKkbthPKtgIeqagNJG8jjnULh/tE0mkQ==
X-Gm-Gg: ASbGnctqAJ1miA8S7S+cIROEheh6AgR+XgAWOH6YkZDIMC63RWYpSWKglnLjvapQceo
 2lY6NpqZ3Swv5c7r9vnqV5bJRER/S+VnAQzi3NPzP+lJ8hGuJhkCLr4AH4hlbZFXL2yJB+9frd7
 dXYbOti+0B0mYkCveApkwMik9yDaUDGINWAzyO4oLBa77v2JVd0sHwwF6F6IaoW42xcpkO+a/9u
 R7cPvKGIExA3YbCaYun6Cng2AAeWqY4KUxN
X-Google-Smtp-Source: AGHT+IESaz19Y9qYrAucj4S0krUSj5yLYCZB/uRksZjrkH6wawrhNPIpiG7uKk8n0HAVzLTqQEVzTuVF9UTVoikgRJY=
X-Received: by 2002:a05:651c:4190:b0:32c:a097:41bc with SMTP id
 38308e7fff4ca-3308e38b29bmr22951431fa.10.1752769810039; Thu, 17 Jul 2025
 09:30:10 -0700 (PDT)
MIME-Version: 1.0
References: <20250708-imx95b0-v1-0-01759e9c855f@oss.nxp.com>
In-Reply-To: <20250708-imx95b0-v1-0-01759e9c855f@oss.nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 17 Jul 2025 13:29:58 -0300
X-Gm-Features: Ac12FXwGkfM_RgGkoBTa5V6CFFBPh8oqe95_kVWf80L9tWV47v8QU2dN-KP4FCY
Message-ID: <CAOMZO5A3hx_1uEDnwrtix4mkb_3WmniFKUOCXO-=XwSCcpOzEA@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] imx: add i.MX95 b0 support
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Cc: Stefano Babic <sbabic@nabladev.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Alice Guo <alice.guo@nxp.com>, 
 Ye Li <ye.li@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
 Peng Fan <peng.fan@nxp.com>
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

On Tue, Jul 15, 2025 at 3:40=E2=80=AFAM Alice Guo (OSS) <alice.guo@oss.nxp.=
com> wrote:
>
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> ---
> Alice Guo (2):
>       tools: imx8image: Add 2 new commands CMD_CNTR_VERSION and CMD_DUMMY=
_DDR
>       imx95_evk: Add i.MX95 B0 support
>
> Ye Li (2):
>       arm: imx: Update ELE get_info structure for i.MX94
>       spl: imx: Add support for new PQC container

Applied all, thanks.
