Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3CD6CCD185
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 11:14:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7926D840E4;
	Fri, 10 Oct 2025 13:14:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fALaDvIL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E287D8410C; Fri, 10 Oct 2025 13:14:51 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22FCE840E4
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 13:14:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-639e34ffa69so2947127a12.3
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 04:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1760094889; x=1760699689; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mZ5l6axcPX1Jv/UrOwLivJxk9kOV0uJRMNh9tqF1tQ0=;
 b=fALaDvILvVb4UQyFuXKv3zwaRP/0BrpWnf5QJv5XrsCPCyZ3bnIGWT6xbxVrJmtCUI
 tbxCOBnv7p4ZMe8oA/dNYloDseRQJMuhkf+GazIe35IjdNKi2sYlAx7QQE9pTVr5vghW
 mKwzlsdhSoCiXA7L0DWVDSnPGnaxcu+N1vDoU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760094889; x=1760699689;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mZ5l6axcPX1Jv/UrOwLivJxk9kOV0uJRMNh9tqF1tQ0=;
 b=dnesr+UH75oxT3PpHb77NA0Mhye0vRCHZjy4a/774p/88TMXNZ5GDxUJruoTdgDk86
 Mo8OTv+uPAPJXIAUHRb//MYBv4IokYyQYa/VKE4q0Zo9vGw+Ar3eqrPhvD5ClLd3RZmH
 H8M/My1CHQ2IlJzNLDntdKby1p9Bt2iSAd9dKv2EizbTs9L7mxjAOkGaGDs2CYgaTml6
 I7X0CADCMlS1niWX9Rtyg+1FurPga6I+1XznSDQ96kZYHazL/0NVVzheTPQcfZeL0EJL
 PVhT/KdV7OHxNURvled3xXlJGRKCJnBPa12tDNiRU6fM+AlVD/dXLsq2sMi90ixAL/XY
 UMFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLyNVshrscERyNR6naggoenlhpSEciftXAHIFpT/eF6sJWGepb2Fx2c1zxb/JCuunf1j7MxSQ=@lists.denx.de
X-Gm-Message-State: AOJu0YwxDyFq5BEqWl5HXojvWodAbYrFupCcAilp+CiQRib8cmlLhjxn
 W1RXEZcGRMBp2jBF1MihWBojrAUlqF0tMXH5YK4zTvZTXlg4ivb36JvjRafbhmLtVEvsZBy6BzG
 QXi+NiOdqQgrL7fEkZRHNj27/7hJ86rbeut6+Sf14
X-Gm-Gg: ASbGncvyKAhHnGXwONaxNZ1yT2l1p5HGL0dDsuGciio7XTtC4fandaHDPXXge8PN/OB
 oYKbpELuUQoV/P24vbGUSywH6DZDyfcWLLMFB8rMLWdEPZhoWxcGUXOe/wx8aIkbJm/bur3ixMK
 WhmO309v86N/nnS0OZiMkZv/tOEYUlcGJwBNzt51aAJg3aTQVi2d3sGbgOv9nmttr+pw1B2ZqEz
 jLAwke7zIWG5TsVl1CsuA==
X-Google-Smtp-Source: AGHT+IG8Htjz2aciej4nEUhnfClXUsJ7g6jlf6KtvQrK52SJGJcNYm210rf8oKHib267YHAh6OpQ+oDYluMVvFblmV0=
X-Received: by 2002:a17:907:3f21:b0:b4f:ee15:8ae8 with SMTP id
 a640c23a62f3a-b50ace22a13mr1153636766b.58.1760094889654; Fri, 10 Oct 2025
 04:14:49 -0700 (PDT)
MIME-Version: 1.0
References: <20251009-feature_sysboot_extension_board-v2-0-e09b39e54de5@bootlin.com>
 <20251009-feature_sysboot_extension_board-v2-17-e09b39e54de5@bootlin.com>
In-Reply-To: <20251009-feature_sysboot_extension_board-v2-17-e09b39e54de5@bootlin.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 10 Oct 2025 12:13:34 +0100
X-Gm-Features: AS18NWCo85uuci1wh-NIHS4DdVYscDgalRJ2e0M8DUSmW0hxFQe6X-hw9h0fZyk
Message-ID: <CAFLszTjZGxK3_O9_OXTNHCwEkZXmZz5epXbH5wEdQ-1QNHcyCA@mail.gmail.com>
Subject: Re: [PATCH v2 17/18] boot: bootmeth_efi: Refactor
 distro_efi_try_bootflow_files return logic
To: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
Cc: Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>, Hans de Goede <hdegoede@redhat.com>, 
 Mario Six <mario.six@gdsys.cc>, Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Roger Quadros <rogerq@kernel.org>, Bajjuri Praneeth <praneeth@ti.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

On Thu, 9 Oct 2025 at 15:51, Kory Maincent (TI.com)
<kory.maincent@bootlin.com> wrote:
>
> Simplify the return path in distro_efi_try_bootflow_files() to prepare
> for adding extension board support in a subsequent commit.
>
> Signed-off-by: Kory Maincent (TI.com) <kory.maincent@bootlin.com>
> ---
>  boot/bootmeth_efi.c | 31 ++++++++++++++++---------------
>  1 file changed, 16 insertions(+), 15 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
