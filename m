Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83AAAC02183
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 22:14:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCB378033D;
	Thu, 16 Jan 2025 23:14:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="T3U7G8n0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F37F8069D; Thu, 16 Jan 2025 23:14:30 +0100 (CET)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com
 [IPv6:2607:f8b0:4864:20::b30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9EC088022B
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 23:14:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-e398484b60bso2416640276.1
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 14:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1737065666; x=1737670466; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jvDo3+X1eRyT2RDPYEoPtgsL9brxtsYnSt/QNMkCJec=;
 b=T3U7G8n0/zX8q3bRMvK/R2e1wrPs6Kk6bW4Fgjw6fA1fykvQ0LBfOc1PonoUYYMQea
 ckIH5VqFhWGh9vxDW2zI7opK0KrK6LGB9rubNU9Xx8bVXCyhkIbo0NyWE2NLMN9hJ+2Q
 4rnuevy4qCyAgVIDmhZPbBn+CZQNINvt/2XimJpscBW1xvLEqvkbeY/25GftbrjKPOfV
 dMRZFZxYmH3LCgxGRhDuE3lo6+XErSUqafDQ/Xlb/1V9O7pzoo/AGgumNPc0LMARiaYV
 ySN6/cKS3thELXjmjIHQI9gqCbgEjHra1160N4eJq7YpzIfmkx7q1dMo4ovKliq9ccHP
 GrTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737065666; x=1737670466;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jvDo3+X1eRyT2RDPYEoPtgsL9brxtsYnSt/QNMkCJec=;
 b=TY7Kf7TEksUhSnhXiuBehI45wUcU4bLsNPZDPphwnamelSuCGpali3wl0a7g0q2u1e
 Ek9E7qlrebkOyvkvMxtj+ujJd492H9rbUlTOkbQHPfGeltNRZoqHlqDw9GV01ll2qUXT
 9vw74magZQJnoYSoz77Vm1vrgkDaHNvQc+ZAjMxaYn+Oi4B7OnR0iDpn/Jm/eZLvJ5LW
 zhRE9u3bAV44z3C5HjY3JoLgivyA887oyJwK8uOUp3xEO4HVqrMImUuIpuJmwB0aHX7D
 HXF9gaN2P7K0Eu4VMzAQ6dLx654wtdVT82wp8XR0Rb3Wr2ROymUqBIyqkEpNEBRMOlk/
 sOKg==
X-Gm-Message-State: AOJu0YyrXvyqwi4zrSPYcJnkKgVvbdv5noCWzjsXnPFoQI8/SecEViwX
 zVhd1ffxrowmWfPT0jlXnHTXMHV4VtDNoIVI5HpkqaL3nkVlOunZQZ6ANgC2jcz5EIpzyVMC2wI
 NDBkNOlDBpLxBS43IqAYkjM4E8FyEATgFEALUSQ==
X-Gm-Gg: ASbGncvEn0uz7a3BpS6cPns4jHVVvyaAtMYPReHuwzUXy4+5CW+Qj1Ht+vMyvAokLL6
 XqBkKJJiQfIuWTIP12ddmuu5W50XT61XTxxtlXQ==
X-Google-Smtp-Source: AGHT+IHZjTRvuN6SXURC0D4Nt+hbX5VLZyOzMlEMsiZRBr/8zwp9dpdRMspm2SKdVc0G3rUbrK0ugXj62bTOhQja6BU=
X-Received: by 2002:a05:6902:2847:b0:e54:dc5f:3ae8 with SMTP id
 3f1490d57ef6-e57b134bde0mr153526276.48.1737065666529; Thu, 16 Jan 2025
 14:14:26 -0800 (PST)
MIME-Version: 1.0
References: <20250116040449.306098-1-marex@denx.de>
 <20250116040449.306098-13-marex@denx.de>
In-Reply-To: <20250116040449.306098-13-marex@denx.de>
From: Tim Harvey <tharvey@gateworks.com>
Date: Thu, 16 Jan 2025 14:14:15 -0800
X-Gm-Features: AbW1kvb4sXXplHbiVcqA7arclx8FBZp_XRKltwiFXHd0RlXy8it3SBNv14USAVY
Message-ID: <CAJ+vNU0g-XdX25oVUKHZK5xtCEuvwuLtPvEWrFxouSoHXyDcpQ@mail.gmail.com>
Subject: Re: [PATCH 13/13] net: fsl_enetc: Update enetc driver to support
 i.MX95
To: Marek Vasut <marex@denx.de>, Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de, Ye Li <ye.li@nxp.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, 
 Markus Gothe <markus.gothe@genexis.eu>, Peng Fan <peng.fan@nxp.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Robert Marko <robert.marko@sartura.hr>, 
 Romain Naour <romain.naour@smile.fr>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
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

On Wed, Jan 15, 2025 at 8:05=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> From: Alice Guo <alice.guo@nxp.com>
>
> i.MX95 uses enetc version 4.1 controller. Update the enetc for i.MX95.
> Add ARM-specific cache handling and i.MX95 specific register layout
> handling.
>
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> Signed-off-by: Marek Vasut <marex@denx.de> # Clean up
> Signed-off-by: Ye Li <ye.li@nxp.com>
> ---

Hi Marek and Alice,

Reviewed-by: Tim Harvey <tharvey@gateworks.com>

This is very clean and works for me on the imx95-evk after:
- arm64: dts: imx95: add NETC related nodes (upstream linux commit
4511acd9eb3c52efa0252cdd7e6438ab3073bfaa)
- arm64: dts: imx95-19x19-evk: add ENETC 0 support (upstream linux
commit 025cf78938c22a02ba7f8aae3f46186e59cfc3af)
- enable CONFIG_PCI_INIT_R such that pci_init is called early in order
to enumerate the network device

Best regards,

Tim
