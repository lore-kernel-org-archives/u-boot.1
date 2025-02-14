Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AECEC02198
	for <u-boot@archiver.kernel.org>; Fri, 14 Feb 2025 20:06:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A6F280B98;
	Fri, 14 Feb 2025 21:06:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hoUIJUbK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62FF680C7E; Fri, 14 Feb 2025 21:06:47 +0100 (CET)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F76680756
 for <u-boot@lists.denx.de>; Fri, 14 Feb 2025 21:06:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-30737db1ab1so24170461fa.1
 for <u-boot@lists.denx.de>; Fri, 14 Feb 2025 12:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739563605; x=1740168405; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BMiXbR/+ISLL2tl0mBC6PtmH2EKrjYLbGOAUL5NTrVk=;
 b=hoUIJUbK9P0d57u+4mUbpe2obMvhYKhhj2T3bPNZ/WV/LTAYzyLwmRrT/bEmBmaolc
 roHvNc6p/kKTJto2m4ncdANIwedibMA00jqvatBinxTpkudPZ++p7GxizMcW/ARJ43oG
 g+Nj0PW0ULz4t/H9A+M5OXQVyXeKMELUvwIoGjhqu6Wm+7mPFzEZ90q0yCiBwzsJ+d/4
 phIx60dFIMDu6H39PecraL/1rADK2Ea8tZkT5XGISnz7+UyybWCOgBPIBfhvn21pH7Mz
 Ldgn648QIcXlihkWZcAWddVZdOlUY/6nJx9CTRosf7iOfaAkDLFiIGZ8mpGNYFRUseXo
 fECQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739563605; x=1740168405;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BMiXbR/+ISLL2tl0mBC6PtmH2EKrjYLbGOAUL5NTrVk=;
 b=dQmZchD0EhtdmsMoYY+uY9wP2b73r0XXdf8AATix4obemZGU0BbG1KZh6Ud8/Lx8vw
 yKFB8fSzL/h9JUQnJz0b24VK9Cc0j24oxpeB7xdgMX5K74Kls/139UD4O93FavGrbcjW
 bJ0id9uBK8SDSrDC4+8cuatuu8npPnt1LYnI85R22xADl0rDGK944TtMXOJkXxSsPwmp
 SLAKhhDuZ9O3OL5fJzy4mmGmfSBBihUoA8NQwGenfS0XVpuVwgxuxfqWf4X+UMi40A8M
 oO1r7HpPWVquaNqpfkCIcruDe8umcMpoX51yziS0UhS3xXgzA47PI2rHS3MHJUsAQvEX
 vCcw==
X-Gm-Message-State: AOJu0YzKRCoFjnuq1t9IuqKaiuQvD3aGk8wR+Gdwes2/pLDcniwpjU20
 mmq8sydUQQZkWsG+RZdDLcPUWsksK6TRzAi8OfqzeTDnvd7S1byE+EqoUaASgiEAp3bZ/clU2vP
 G8LwqbNY8J9CPGu1QaSTsun07xQ0=
X-Gm-Gg: ASbGncsal77cInbn/vbpt8obOtRrz7sTdTll5WKukCoA5XUeb2UomkkG+OpN/Db0ucq
 QMzX97g9wPHnGkaRH+wVEYggNoRfWnKGjolJCO+UNF1zVFPAcK7keh3XgCkfVtCQet/4wxB3/IW
 bygDMh+JwPgnUccCTeLc9tc/39txZj
X-Google-Smtp-Source: AGHT+IFKxXui/BOd8UgpEH7NRQr15eCPGsdJYckht1dJ4wDNr1HMQOT8Ml10EhTtKToqJ0hLpdwXoaJL0teXPjU5wiI=
X-Received: by 2002:a2e:a163:0:b0:308:fa1d:d833 with SMTP id
 38308e7fff4ca-30927b283damr2967051fa.37.1739563604329; Fri, 14 Feb 2025
 12:06:44 -0800 (PST)
MIME-Version: 1.0
References: <20250130164758.GC1233568@bill-the-cat>
 <20250131100845.31380-1-atheiste@seznam.cz>
 <173955934703.3052361.10140738654072110732.b4-ty@konsulko.com>
In-Reply-To: <173955934703.3052361.10140738654072110732.b4-ty@konsulko.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 14 Feb 2025 17:06:33 -0300
X-Gm-Features: AWEUYZl0lstVOoWia_ey1qu-uam0qr167cx2HVwib7QEVtEAsG84EFx8Ddt20yM
Message-ID: <CAOMZO5AvRCmZHtOTuw6faW6M0BPJxTsnQ6uu9xHQTX6ovGi-RQ@mail.gmail.com>
Subject: Re: [PATCH] feat: Add CONFIG_BOOTCOUNT_ALTBOOTCMD to Kconfig
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Tomas Peterka <atheiste@seznam.cz>, tomas@dronetag.cz
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

On Fri, Feb 14, 2025 at 3:55=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:

> Applied to u-boot/next, thanks!

The author's Signed-off-by tag is missing.
