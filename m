Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07C95CD37AC
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 13:34:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A24D83EF9;
	Mon, 11 May 2026 15:34:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qM5bX41X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CDA8845E3; Mon, 11 May 2026 15:34:12 +0200 (CEST)
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com
 [IPv6:2607:f8b0:4864:20::a29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71060838D7
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 15:34:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-vk1-xa29.google.com with SMTP id
 71dfb90a1353d-57512a429d1so2969293e0c.3
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 06:34:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778506449; cv=none;
 d=google.com; s=arc-20240605;
 b=OWqkLGhFXVtyhU63VsDDJlAsjvYAgVLxRAs0ACyVD0mfNUKIUWwBZcG+aMAbG7cqRx
 efiVqeDkH1RwxssgER45Ippm0+n8298UiUSOEKX4KPFC0Ud0+pDzFEYFyHGqSrIvQs3f
 9GTBoyuVGf+b2Mj4QBBKQBDOtmfuve6wpsNjwpl1LXnAl5xtLBNwN0+zBK15exTAjWJa
 QkkyRMhX8YL7qgesmWtWPZfjfo1AxYy2DBLM6m2mCA/3NYIEM+rVSiQH9/3QPvG5cxwI
 tFVAQENyBZ+q02faGkXEx7Ys6GnfSm+qdaEJU1raMTnQcXO2Cl2fy9tfjU4CFoQW6w5c
 wqPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=K0IodrZZ0LDDomd9go1czYrJ4TfeLowtx4Z+s11D6ks=;
 fh=bJsgV4Fow42DT1LyzRcp9VugVGrsGTmcIA/W2aWTvpA=;
 b=UuUfd9MsujF8vra+/pO4GjDh4RwFo1wsSAtQsNGJFwUZA1lS68hRRAAtxgMfMhfB+u
 +EuRjVbva+Si6aE0G0eZ/NdBvRA94GgQjY8G8UFU4sYoBb4DATcB/DK608j81AwX4i79
 EITaGyg0D9VyWjF8UI+koprnJGV2baskn3nClCErtt6HL3s10uycrtoWCUW5LX+c2uM8
 cudxPCAtVi68QkgLzJc2SdAagWBM87ucY+Q2Gi8Tqomgf8D3EqHyDg7lHDBMyMUaYpBA
 /ucPAKmD+uBs+Tc2gnb9l/HRUNeqgU6wY7GHCGaY3/pzvwt7jIdzLsL3sIiYV+odc/Wy
 /bXg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778506449; x=1779111249; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K0IodrZZ0LDDomd9go1czYrJ4TfeLowtx4Z+s11D6ks=;
 b=qM5bX41XoA52KSQczJ631oAN2dan6+Z8EqnIKH+oArF3yxTb313r1oahRa4zcUN2uv
 k49ZrGiJKr62jinfix3Lr788+pcs3FTj33tghLuSV2rd5UNKdG+DDPA5IP3VOwhPbbdK
 hglyxupf96ecR1X3xcO0bHu+na11O23IRpaASv+le9CO/lNck3txWgSeoIvCLMDajwBm
 FvzdTrP4EVFpE5iL1d7dK2622yBcp9lI82u4XMVsgkfAaHmmb51o1Hr40U1+4/sXctNw
 tSLj/WmFTMIQzfNNdC6gQIZPwHHJcy34pOYdmyFCWrV0Jt0AbX9+KRkgqTIznvpXw1Mv
 rUQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778506449; x=1779111249;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=K0IodrZZ0LDDomd9go1czYrJ4TfeLowtx4Z+s11D6ks=;
 b=beRFxsdOa0X7o4iuOv3ASysZaDgzvYC+oIlLlArxHnPBMM5/qUMuZX5regOfeEU303
 Z4O+/rSOfSIYJkzCU2ORkjexzO1i136wKp1J8i3+ReMvyCN5pF80itOZpuryyi7WYtGj
 XNje+Ir4O41MC0wQ89fAfVIozW7h0kzgJP6PzDu7ueViFMSaJwxTNK+KsT8+wFhCg9KT
 ElMZGKQRM5pRbtyswXK2GzufhQEBLVsGKxVwiLVtTahF88du2g2X53B9+z1h/Ez765iR
 1evCI2RiIvtdm5vKRM+LpGiaz1oCqG1QLm89VBR7qowQhCFsZFUv/koSvVyuimGzs7Af
 TkDw==
X-Gm-Message-State: AOJu0YzwVaejqw/lQRm1zoWSDkXwjGjpiHcaluAVkYMdRDLsWmL6lvp3
 hzn8fe3SHiqEKyJvUbabSCMcsP5bFJvYJZoe/cWUAXCcCUeWgDSgL54trr4WawhJhOV2HKFVfqW
 0wUQqs3XJUQC++vcTmdBVONOmoKrrC4g=
X-Gm-Gg: Acq92OHTrjqVnCSLfOxmSBypeHgzLnvCSCS2Y7u6LCGCqRVA696rl5CoCjMtNMIiz61
 CzxUqfpsXQcOvGh04WySWsicYNdxRl73PkuOiKpBOSc8RS0dkiVK6DmvPW9u69GBAjoRpzXdwqT
 9l4uBupm69EMzpGdyV85gYtJbu7/4GdVzqRJg8NzlukJXgGshvbU4G+GbGbhZsR6sNADnuTXKP3
 sUDOq0js6MdEEWvI/dBqcRXlGUTCHP6qYqn0+k7rdasaQ09A4GOPlkP7p9FSlV6Qx/XnRC1zWjj
 9TWa8Wt22EKd4GTFCGI=
X-Received: by 2002:a05:6122:4b13:b0:56f:317a:65d9 with SMTP id
 71dfb90a1353d-5755937d19emr13924483e0c.1.1778506449217; Mon, 11 May 2026
 06:34:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260509203136.46745-1-kettenis@openbsd.org>
In-Reply-To: <20260509203136.46745-1-kettenis@openbsd.org>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Mon, 11 May 2026 09:33:57 -0400
X-Gm-Features: AVHnY4K8FcpNJwD5CGg9Fpl1TXQyb2Icz8Ja_Ya1_neHTkUK0i_DJMmQMj028OY
Message-ID: <CAMDkj5x9q-64Z=ArNhOdULYB7xE=V53OQSkeWO3UjRoVZ9tYpw@mail.gmail.com>
Subject: Re: [PATCH] smbios: Do not fall back on devicetree without valid
 mapping
To: Mark Kettenis <kettenis@openbsd.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Janne Grunau <j@jannau.net>
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

Hi Mark,

On Sat, May 9, 2026 at 4:31=E2=80=AFPM Mark Kettenis <kettenis@openbsd.org>=
 wrote:
>
> The smbios_get_val_si() function may get called for a sysinfo
> property for which there is no mapping to a devicetree property.
> Avoid a NULL pointer dereference in this case by skipping the
> read of the mapped property from the device tree.
>
> Fixes: 83b28b55d74f ("smbios: add support for dynamic generation of Type =
9 system slot tables")
> Signed-off-by: Mark Kettenis <kettenis@openbsd.org>
> ---
>  lib/smbios.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Thanks for fixing this.
Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>

Raymond

> diff --git a/lib/smbios.c b/lib/smbios.c
> index d5f18c8bd69..906d2753517 100644
> --- a/lib/smbios.c
> +++ b/lib/smbios.c
> @@ -292,7 +292,7 @@ static int smbios_get_val_si(struct smbios_ctx * __ma=
ybe_unused ctx,
>
>         /* If the node is still missing, try with the mapping values */
>         nprop =3D convert_sysinfo_to_dt(ctx->subnode_name, prop);
> -       if (!ofnode_read_u32(ofnode_root(), nprop->dt_str, &val))
> +       if (nprop && !ofnode_read_u32(ofnode_root(), nprop->dt_str, &val)=
)
>                 return val;
>  #endif
>         return val_def;
> --
> 2.53.0
>
