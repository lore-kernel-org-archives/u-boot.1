Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73348C2A062
	for <u-boot@archiver.kernel.org>; Mon,  5 Jan 2026 00:32:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CABD883990;
	Mon,  5 Jan 2026 01:32:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="FUyXuMtd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDF0F83A57; Sun,  4 Jan 2026 21:22:02 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49BC383A3D
 for <u-boot@lists.denx.de>; Sun,  4 Jan 2026 21:21:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4775895d69cso57089215e9.0
 for <u-boot@lists.denx.de>; Sun, 04 Jan 2026 12:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1767558119; x=1768162919;
 darn=lists.denx.de; 
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0eDfOhXwhmFmTB2j/SkXkwpf4/IyPaMNHRZS+exep0M=;
 b=FUyXuMtdFASn1lCiNmDrltR8Plul/yKG5KToq+J3PQyNVWU51+kAD/BH3KvtWoCFxt
 FMrTTciIXprrlMAPbetge9/Q6xQVokhFPysDTHobQFse+yk2RMuTRzDvJgclGPf5AKjf
 abof7gWfL7gi/+8J4QQNwHn74qRca+b9nnLbAtPKxO2mHUaIMhdsd35UY/p1pVQ+uG5d
 Eau9zaxWISfWt4ufEP0SdGNeDonCPYQQprwaUxSpRcFjwHIraTPZhOTtUFUC3qn5JXoH
 mM6ZamiZg0mgjrjg5Ic1twSouYHejvzoPjlbqrn3o1BzdJHzgYH76Me7oZonMfzo0876
 C9fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767558119; x=1768162919;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0eDfOhXwhmFmTB2j/SkXkwpf4/IyPaMNHRZS+exep0M=;
 b=LpcyjMGOjyFVI6ygmkjzoM4Z5OH4wOFvaP5BY38TIg8mAGD2wCNJogjOpwRKMG94B9
 +kmGm9en7UStarPQycc7A0GUvr85p6d2DxmH7cWqXSvsv82SnZaD9UtdZcqnzhxGhT49
 SFx+EKfdkemA+QbkH6Ulkhub1J17nFQjwToDu2JMs7SFqgVpuhhbJf/c0m/cbA3i33y5
 hqpp7eBM1hPvYLS3/cOZT4RGw3iKx9i1/GYQg+LIwwTQ/iOhtT64g5BMfLpW9/FgPxyb
 q7tljfBATTPxfu/EYHjS0Vfd9Uy7VYA9iCgXDhnxCkRtK4a2JsTYiMwcRxrFwUQwi1jn
 WI1Q==
X-Gm-Message-State: AOJu0Yx2hAUyLtNIgM9tZ69OSTnWH4Qgr3oL06nCYuYjbXqLk/6iq/bi
 q8Z6e1XNrFZ60BThT9xcysdHu+OZTIUN+5BMhFkcW5uaj8gGRvFIiuaudIboXuWyTQ0=
X-Gm-Gg: AY/fxX5244my0rEgN+MJn0STsaIZhmIYxYXN2jjsbAeINvtbAEwpnqy3ncNgtyEjEf4
 sJogTeA0qox4g1LdhiRRQCnDbz/jYr2+4UURw+uSg+xFVO+yolT2HcX3fsaqmUGTQ2vlNJQV/0g
 1Yy7bEM4QV7lpdI9eDIbGX2UMPsyM0TnS0fde5uSe6b+zagYwfQFIZWtNPwDh9VOls9cLplZLzf
 D3UlxLZv2uKNPvd70Zp8KjQw7sA+WOtCBB1EGarY8obRsYa4i4LrSOwK4A5YnUtVwcKl01Ym9ug
 CKwh4dwecNurYUqX7LbI27GV9w1KIizrCswj7wcJj4sXPO7RsAzZPSkJSacrVUDO4qgxLMdjFx9
 bStvSDvV0+fu9hGr6tRFseBrIMAqiXqyByDiV5z69lCYoYWujFeLwDpWNVQ3y+j/Hdsl5lyKrDx
 Y46tTo
X-Google-Smtp-Source: AGHT+IFSh+Rn1npP0X1iNF38rcsyZEMuaT/2WTlDMThFevKbGZhv5Y2gbaorP/z7LAtnfFKhMw2rKw==
X-Received: by 2002:a05:600c:1d0b:b0:479:2a0b:180d with SMTP id
 5b1f17b1804b1-47d1954a5f7mr576733205e9.11.1767558118567; 
 Sun, 04 Jan 2026 12:21:58 -0800 (PST)
Received: from localhost ([195.52.160.197]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d6d34500fsm111585005e9.15.2026.01.04.12.21.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Jan 2026 12:21:57 -0800 (PST)
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=59e2924ea8f8f7f32b1852b8c144dc4aaffc969841d920aa98c74d1ee494;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Sun, 04 Jan 2026 21:21:48 +0100
Message-Id: <DFG3210Q1SC6.2U3BQSG1DEGUT@baylibre.com>
Cc: <u-boot@lists.denx.de>, "Anatolij Gustschin" <ag.dev.uboot@gmail.com>,
 "Yannick Fertre" <yannick.fertre@foss.st.com>, "Patrice Chotard"
 <patrice.chotard@foss.st.com>, "Raphael Gallais-Pou"
 <raphael.gallais-pou@foss.st.com>, "Sukrut Bellary"
 <sbellary@baylibre.com>, "Fabio Estevam" <festevam@gmail.com>
Subject: Re: [PATCH v3 3/4] video: simple_panel: Add tfc_s9700rtwv43tr_01b
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: "Tom Rini" <trini@konsulko.com>, "Markus Schneider-Pargmann (TI.com)"
 <msp@baylibre.com>
X-Mailer: aerc 0.21.0
References: <20251204-topic-am33-evm-lcd-v2026-01-v3-0-ca74853bd5f0@baylibre.com>
 <20251204-topic-am33-evm-lcd-v2026-01-v3-3-ca74853bd5f0@baylibre.com>
 <20251230173012.GA147611@bill-the-cat>
In-Reply-To: <20251230173012.GA147611@bill-the-cat>
X-Mailman-Approved-At: Mon, 05 Jan 2026 01:32:34 +0100
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

--59e2924ea8f8f7f32b1852b8c144dc4aaffc969841d920aa98c74d1ee494
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Happy new year!

On Tue Dec 30, 2025 at 6:30 PM CET, Tom Rini wrote:
> On Thu, Dec 04, 2025 at 09:31:16AM +0100, Markus Schneider-Pargmann (TI.c=
om) wrote:
>
>> Add timing data for tfc_s9700rtwv43tr_01b from Linux to the simple-panel
>> driver. To support hardcoded timing data as Linux does, add a new struct
>> simple_panel_drv_data which holds a struct display_timing pointer as
>> well. The hardcoded timing data is preferred over DT parsing.
>>=20
>> Reviewed-by: Fabio Estevam <festevam@gmail.com>
>> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
>> ---
>>  drivers/video/simple_panel.c | 62 +++++++++++++++++++++++++++++++++++++=
++-----
>>  1 file changed, 56 insertions(+), 6 deletions(-)
>
> This leads to CI failures in test:
> https://source.denx.de/u-boot/u-boot/-/jobs/1341980#L269

Thank you! I missed checking if the data pointer exists before checking
if data->mipi_dsi exists. Sorry, will fix!

Best
Markus

--59e2924ea8f8f7f32b1852b8c144dc4aaffc969841d920aa98c74d1ee494
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCaVrL3BsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlMc
jgEA/E13kqj2XC3Adm95PYrx/15Y9s4Tq5GFMTyIMBwDcNQA/j7x3S5vdwNk8ka8
FTuvrfp7+jjv+lFIY4DfQWr69+MP
=qnMR
-----END PGP SIGNATURE-----

--59e2924ea8f8f7f32b1852b8c144dc4aaffc969841d920aa98c74d1ee494--
