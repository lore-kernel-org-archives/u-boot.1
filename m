Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC63DCCF9E3
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 18:07:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 304E68004F;
	Tue,  4 Nov 2025 19:07:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KgYrn6pV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 055B78390D; Tue,  4 Nov 2025 19:07:02 +0100 (CET)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2ECD8003E
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 19:06:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-5930f751531so5582444e87.3
 for <u-boot@lists.denx.de>; Tue, 04 Nov 2025 10:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762279619; x=1762884419; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+yhcuVcOcqBwHT2k5bEsxRtMQ4Fl1DU/3V8Ep4Szdhs=;
 b=KgYrn6pVBMUdr/R3FX7LiZnqKH9mn5PIQAp+/FTQL5SK7IVI2M/BSavEdFWUUFOD0e
 Ll2koEAcaKBZ3o1BCOldK2dVFmrh1FO7M1cbakqbV/rzwSwerVOSe/yw9V492ndTYyI3
 ok6g9TUL7n7kpIRIE3gC01P+RlRMKhLDJQUcpDAWKM+Vyw9QPKZzwOP7OJ2fvOoohzPO
 uhVwMJGt/f/5m8ScLrkGSKPMj27/mz/uI3n0Qk+XNFrm7mc9GjK1EeUEID9AYKRR5/nu
 GvufXq6QGDaz2MjJh5ZWYxkXVvLIrEEme/oV1ogksDOvSq8vosBsAPlGqM/jPLh31KSr
 kAug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762279619; x=1762884419;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+yhcuVcOcqBwHT2k5bEsxRtMQ4Fl1DU/3V8Ep4Szdhs=;
 b=E2app7OcpMtEjZoLZQ+ArQZ7rH1ZHyiIA7n/SqW4g8GOZfErvAqvDO89VoNxwNz5Cm
 /c2ZNGGOFTtycOv0ZceygTMJM+Ou40mXyE5VlKJLVESEuFk8EpYOA5AEWuwxVvWDUb2s
 M3EJmp3j1B7vcLOqlUPZm7Sgk1R4uy5E8G9ugp42HZD/6/8K26R2Z9+JVA/7I9qGsgDp
 AzncbXucNddiA/X4LuHCKcjwJQm9NhTCr3yhk7LCrJJp7XDlRHWHgRJTKzNEmbbeav9q
 inUc7Gtmg6ErdIBf9yyYXOL4CgtpFoG6Q98YSEIr3620XHrlxK0Y00xndTjACjs91lt2
 rUqQ==
X-Gm-Message-State: AOJu0YyjxvFDEjAfjjOb8xO3+lXYe/ol4paRwFMtOpnxnS/vE8q5RC07
 zNiXsXSrYayo+L1m6mTprzEyyutTspM3+tqXxDg/v3hPBM0CgV6z6zizYAFjoxXdFWS7A2XwO/J
 Lvp5bMEX6GfefjSavZ5KtCdSAOeA4fKY=
X-Gm-Gg: ASbGncush1OrcoPemR7iLciEfHu5m8i3mDABArshVXFhcAhr4R52KCbSIqoVs4PlK/v
 4lm6e09z7e/xXDo7Eg+mM5NbY8XomOqLORvEWY7N4KlWUCEgKhQ27lgdjvQp8r7PT3iI4eDz3gS
 dIEDKZqLVUd7JQbUYePRDjpSA8u/ZprUPKYFYHgCj5OSc4Zn0hRwuQ2nSBBDGiVywlLExbfeEo6
 OsBBMzk//e01+jNhSElHjaf9UdXqtl/QCpyhzfs4n5H97du4KOFxSMcRl4xmchs1h6E1EB6HmrY
 iTv1fRU0BMUqaUdT
X-Google-Smtp-Source: AGHT+IF8c0wjtHWI5yzusC/jRNgesfvLnfcyAFgTAt/dnmz+F+dVVdaXA80EqBzK4kI5znOnc+bjkS5Fxvi5t4QH4ek=
X-Received: by 2002:a05:6512:3d08:b0:594:27ab:2f7a with SMTP id
 2adb3069b0e04-5943d5176bemr29529e87.0.1762279618895; Tue, 04 Nov 2025
 10:06:58 -0800 (PST)
MIME-Version: 1.0
References: <20251104-imx-rproc-v4-v4-0-8bbc7b886737@nxp.com>
In-Reply-To: <20251104-imx-rproc-v4-v4-0-8bbc7b886737@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 4 Nov 2025 15:06:46 -0300
X-Gm-Features: AWmQ_bmE8qz0k-cxLvcNyl2QpLF7kO7f8XjGvWLUGc9akpJJlJNd3_GLyN7Xn_k
Message-ID: <CAOMZO5DJqtqG8GTAoHsHVewr2i4dfVcHH0o3OJRu9o3+ocmYmg@mail.gmail.com>
Subject: Re: [PATCH v4 00/12] remoteproc: Add support for i.MX8M[M/N/P/Q] and
 i.MX93
To: Peng Fan <peng.fan@nxp.com>
Cc: u-boot@lists.denx.de, uboot-stm32@st-md-mailman.stormreply.com, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Stefano Babic <sbabic@nabladev.com>,
 Tom Rini <trini@konsulko.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Beleswar Padhi <b-padhi@ti.com>,
 Udit Kumar <u-kumar1@ti.com>, Andrew Davis <afd@ti.com>,
 Judith Mendez <jm@ti.com>, Ryan Eatmon <reatmon@ti.com>, 
 Hari Nagalla <hnagalla@ti.com>, Ye Li <ye.li@nxp.com>
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

On Tue, Nov 4, 2025 at 7:06=E2=80=AFAM Peng Fan <peng.fan@nxp.com> wrote:
>
> V4 patchset pass CI:
> https://source.denx.de/u-boot/custodians/u-boot-mmc/-/pipelines/28137

Applied the series, thanks.
