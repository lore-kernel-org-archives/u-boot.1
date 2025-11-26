Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7C21D1037B
	for <u-boot@archiver.kernel.org>; Wed, 26 Nov 2025 11:07:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40A3A841BE;
	Wed, 26 Nov 2025 12:07:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LitWi/lL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F3C9841BE; Wed, 26 Nov 2025 12:07:30 +0100 (CET)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8727A836D3
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 12:07:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-5957db5bdedso6851457e87.2
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 03:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764155248; x=1764760048; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bCXbhccinfyaQR+Ro4DNSPt3GwP9p7+HNsX6ndq7iDA=;
 b=LitWi/lLueOuHd4DKysxHYvZb/wAkXXGd67Rhs/SXE+LuVHFWmnNkzloCgaiyRFDjR
 Qwrx0+9iqkYqIRyLJ7XL6XhdVSz8FkvDC+bWXnmHgy1c74KereMiwMpYAmdDddI5CjlG
 /XUaz+s/tLqRfP+u8mi3a18Np/YwGz7YtXnv0YUQbyxYgS2F4KlaDm6LF5YxyO+kuIq2
 R3rGW+tLhn5Klp37DP/+nS7W3i721WXX8PI3oediWixifPaoYi6MvmZEMWKGmj7CmX8g
 os12pcAzPSh5jVGGmaAt98/FgInvJZM+ByoDtC9qv73Z/qoGFB2SksLgLQQW6THvJJCt
 CCiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764155248; x=1764760048;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bCXbhccinfyaQR+Ro4DNSPt3GwP9p7+HNsX6ndq7iDA=;
 b=uPpolzVWt9blhXfvP3TN2FzK5IvsnIyvx8/mYYJVpYijV5q/4/W/O4DhiFcODXEnDi
 ai6+8y48mygIQAJ6cw4MJzPdR4ldm2NUeqaZJgp607pkLHtRJ5bA9AYImgGDc22sDstO
 /AOXsegXV5rb9PStSvx2VCx9Gxh0blmqQZYwL+HmZSa8ekjSbHvQ0WiXIDYZlLmpA/7s
 USw/NNwodjEWxc3cV9BrT45+aZdOg3i5hskQhncF1erAkEsWeV35hKPDikodwUkIuhxq
 FpXrV1yg/AZngxVu/D/nhRpWo3aDj7YvuLhSC5v5+PlRRs3Z0oeucfBhk4j9yoWxxYpO
 hl7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvvT/puUiGN1pJXOtZjt1qsKFIlzjp2nQwQKFGa5wMYFy86gAHYhnvVdVqyIQtJTb8pWb9P1U=@lists.denx.de
X-Gm-Message-State: AOJu0Yy3PYjgsBzuHZTAVH+Zgvw9gg6gm3nukKWsNHvByQVbFfw4+97i
 rekNIUOe0h/68d/bMfW1kRKXnLn5v294JdmF6z8Do+XbFh/OZP1i6iHe6ymaOwyjTTDga7+3oAE
 ECvWkD9MilUVh+Y2DIinAe9AoLDt/Uz70od/Z
X-Gm-Gg: ASbGncuQWROcqS2cy3uMybzhh2NMRs/6APphnNP6ER2BcONVnyvM5SRFQ9bwQA03C8E
 LeOnJhUM4nd0eA8FgoFzvyIxqmc90Zw47XkQ8FSLXLGW7Lw4mRc9VZNYLwaMntHZDI4x8oBE35/
 CaymSom8bA9W5AJbL02O9gbX3juzvKkMEsh+yEP2NCc1/3meotzTzu9Mb1ROVwWxb+2+w3kfd3U
 WS05680ectttnbyKw+CfQggNXIGWGEooMvPBGYsxUvWgubxb4VxdpaAIamVubh4w1BwD78+Ybem
 XvqemTUWESioyDI0bULDdGUNIQ==
X-Google-Smtp-Source: AGHT+IFRzGIJwmKE1ZRIWDjAW37PNMJikKQL6pXDsGiUkOzvBGUlxfGboaM2hSEWe4nvi8I2RKfGl8k/P15reh0TQ78=
X-Received: by 2002:a05:6512:3a8f:b0:595:7fed:aaed with SMTP id
 2adb3069b0e04-596a3ed058fmr6886717e87.26.1764155247579; Wed, 26 Nov 2025
 03:07:27 -0800 (PST)
MIME-Version: 1.0
References: <20251118144815.1242023-1-ernestvanhoecke@gmail.com>
In-Reply-To: <20251118144815.1242023-1-ernestvanhoecke@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 26 Nov 2025 08:07:16 -0300
X-Gm-Features: AWmQ_blqkPGLwiT3Qm88NGHkgGtMcFc8XwcskMsSOe0BMKqx37irjef5KT9hiCI
Message-ID: <CAOMZO5BoVMg9ydNM6yXEbXx4Mb9ygjxsLc2Siw_NayfxB4n9mg@mail.gmail.com>
Subject: Re: [PATCH v2] configs: colibri-imx7*: set 'fdtfile' generically in
 PREBOOT
To: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
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

On Tue, Nov 18, 2025 at 11:58=E2=80=AFAM Ernest Van Hoecke
<ernestvanhoecke@gmail.com> wrote:
>
> From: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
>
> In TEZI (Toradex Easy Installer), we use one U-Boot binary for both our
> NAND and eMMC Colibri iMX7 modules. Currently, CONFIG_PREBOOT sets the
> environment variable 'fdtfile' depending on which defconfig was used,
> adding the '-emmc' variant for the emmc defconfig. Since we always build
> the TEZI recovery U-Boot with the standard (non-emmc) defconfig, fdtfile
> has to be overwritten later or it will be wrong there.
>
> By using '$variant', the fdtfile var is properly constructed at run time
> for both the NAND and eMMC variants, and we do not have to worry about
> setting fdtfile again when building the recovery TEZI U-Boot.
>
> This also synchronizes these configs with how we handle the iMX6ULL.
>
> Fixes: 327381e8b57c ("colibri_imx7: use preboot for fdtfile evaluation")
> Signed-off-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>

Applied it for u-boot-imx/master, thanks.
