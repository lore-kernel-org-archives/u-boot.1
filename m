Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ABD3C54798
	for <u-boot@archiver.kernel.org>; Tue,  5 Mar 2024 18:19:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92ADD880D8;
	Tue,  5 Mar 2024 19:19:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PYsC15vw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 393AA880D6; Tue,  5 Mar 2024 19:19:17 +0100 (CET)
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com
 [IPv6:2607:f8b0:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1277B86F6E
 for <u-boot@lists.denx.de>; Tue,  5 Mar 2024 19:19:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-5a0dc313058so653790a12.0
 for <u-boot@lists.denx.de>; Tue, 05 Mar 2024 10:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709662752; x=1710267552; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n+TMwIreO9Vz/6gwcQ6VWsiBS3SssxZ2i8BJF/kTTMg=;
 b=PYsC15vwL1BDtQDCikwk47kBLPpjKWaUjOvBTbslDrfi3S0sZya5zuR4cjSyGVKe4E
 frM81cDBSSVVnXEyI1f+dpllo7lPTbunpr8DRvUFrPVkKUINudK4inZKM+te58pZJl1l
 XQq6xzXCSooXpaWdJOTvVM6gZ15VdQA8ETKCqvMNTDsLfc/d99CQCxOvlJfCrhCNa1e0
 eZUhLr+ADOza5DK0eX/GsNnaKxEkoOrIUbrwqbII8Fc3w7me9jfughs7Wm7C3Y0IOujw
 itkVVLplvWzTpeVdUOSLAR0Br3k1lgVVoOdMFkTHSVBo8pmLD6Rutmoy0pjVyBMRTr/2
 YFdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709662752; x=1710267552;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n+TMwIreO9Vz/6gwcQ6VWsiBS3SssxZ2i8BJF/kTTMg=;
 b=XOPo8epRdo0o9sPGDCYhPjvZVJTxp/zWVzwKiH0/xlUNGtOqzX7hJEIHCWrZuAimNU
 XkAvfsWAv+AAC0Gp7vHfP04E8dqg4orzGQ/d7Arfd50uvaSYGWo8lBHt/nvydp6JJn5a
 qOp2/hjaiM/D9Zb/CwFMg9T0tZbDFFcgOHqcOx0xUfacC1cxWTuK7bAiMH+TPa+8bIOM
 LVU685heVTDNgWAEOYU+RJC9RVl7gFH0m3fzg2z/RyKPvKxp8rMZusBBm0CG54oW3Pc3
 wnuwknWX0DPBl2Oodqnbxd70RNQlKVA4EjbojsrRBVcy5jstmDyNG+tlXgDXm/nh9Ucg
 QsSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV84PiI5QnF3M5l+Y7DuwfRaoCSkSHIgEU7RUfTWLDLoQnlpbe3Cj792L0dnKVuK9bgYYNk8Gy4pKwZLEEUG+jSwd5+nA==
X-Gm-Message-State: AOJu0YzbLeyBlLbxFQgoFgoNyMozj+VlX83jRb2OpQC/6USATcr5ccLz
 iEKNDZMYtthjfiaH2qfk32XL1tlt6ym20Em7q4GIvS6Rjc+18xL/FJz1tSjz3bhUYg/CuOEHSuX
 yqyRPmbuvxz1Zt8XRozzuuNpR+6U=
X-Google-Smtp-Source: AGHT+IHz+Czjri14CsPq8ksaAaB2bCMEQl720v7oKxIZ9mnQJRYEZCf/Gg9/A91SHtpIUiEhdlILqLJCM0J23FyDmW4=
X-Received: by 2002:a17:90a:d504:b0:299:25ad:7c98 with SMTP id
 t4-20020a17090ad50400b0029925ad7c98mr1235801pju.2.1709662752382; Tue, 05 Mar
 2024 10:19:12 -0800 (PST)
MIME-Version: 1.0
References: <20240304-pcl-070-patches-v2-0-c534960c4b8b@phytec.de>
 <20240304-pcl-070-patches-v2-2-c534960c4b8b@phytec.de>
In-Reply-To: <20240304-pcl-070-patches-v2-2-c534960c4b8b@phytec.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 5 Mar 2024 15:19:01 -0300
Message-ID: <CAOMZO5D5iLjHfqevj6YmBQyiDxkF3M-UX-e0Eev7pV6X6DDL+A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] board: phycore_imx8mp: Use 2GHz RAM timings for
 PCL-070 from pcb_rev 1
To: Benjamin Hahn <B.Hahn@phytec.de>
Cc: Tom Rini <trini@konsulko.com>, Teresa Remmet <t.remmet@phytec.de>,
 u-boot@lists.denx.de, upstream@lists.phytec.de
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

On Mon, Mar 4, 2024 at 1:04=E2=80=AFPM Benjamin Hahn <B.Hahn@phytec.de> wro=
te:

> -       ret =3D phytec_get_rev(NULL);
> -       if (ret >=3D 3 && ret !=3D PHYTEC_EEPROM_INVAL) {
> +       u8 rev =3D phytec_get_rev(NULL);
> +       u8 somtyp =3D phytec_get_som_type(NULL);

Nitpick: Better to spell out 'somtype' or 'som_type' to make it clearer.

"typ" usually means 'typical'.
