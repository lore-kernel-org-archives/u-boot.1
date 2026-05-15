Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DC85CD4F47
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 14:11:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3694384707;
	Fri, 15 May 2026 16:10:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bjfhJosz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7745584707; Fri, 15 May 2026 16:10:57 +0200 (CEST)
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com
 [IPv6:2607:f8b0:4864:20::931])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BBF0846AE
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 16:10:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-ua1-x931.google.com with SMTP id
 a1e0cc1a2514c-95699e8e26aso2749496241.0
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 07:10:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778854254; cv=none;
 d=google.com; s=arc-20240605;
 b=VY48QCTNakAGvJnvOqAaC6k8QFIpZ+WqupA1Aqfpx3EcriJrlxVIw9E8f7MEQbB65+
 pHphqYGN79+2Vqx+iWcgeslFfoqybHRQP2GZLap0wYVYenzVyECiaaJRrpGgEz0s2eoO
 VDH8xcWusq4myU2O8Dvjvmitpd1E5ivNOZL5QFR6yfZm6XnjipB9GGXAP2C02SQy/8Ir
 w7zYGUEg3uTb6wG0ZVcBSDTueqgQDv+qFegsGHH4ArypnMNNgS+yrrUZnZXlJICxfJTu
 tJmV1HeOFovzEwDMwv3NlhDHaFLEtMESLL3H71XDFce0/JDziZcK8kOXcZpmHcnAE4st
 qfQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=kPEX6BELjbFEr8DQmzcKgY8FZPyL7BOLdCyyTnR1dPs=;
 fh=3cGkqt4Xgv2w9dTeeIJFEJ5AO4AvGobPArcY4WlS1wc=;
 b=T4ij+Iw9Z+xNfBCZ9Yi5XB6c9rdWR1DId3xA5/XpKtMJZerw66xbaHM81hDNGMxyf2
 bK2z1ttAzjfS8vXfbQsIZp6atZEQaUqUY75DOlxs6GctzJ+Dd9TvnaP/BEHJ5PWbJZ4B
 rUYZQPv1xXfagcUvmewxun9dvqXTBkG+vKirCvdDTiwcfEjf9MQXoMDhz+AUkofNMRic
 cIQUMts7NOT55SioWCv78Pw+PuV9iHNZ44SblKZb+FiL4vzgTRzuQf36gm7NO5PgkMX9
 ajjUCyXXmrxniY3XHd0xfBlPpvKgkUlW/2JQs9VEozepapnkaTSxq1PT8feW7PRN85I+
 WLuQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778854254; x=1779459054; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kPEX6BELjbFEr8DQmzcKgY8FZPyL7BOLdCyyTnR1dPs=;
 b=bjfhJoszy80txWDYrDeRZgQRMe3cBaS9c4WEYEfAO3buiz3P6bO2rC59FXEIpKtfLT
 5JnpABB14dchWCRicXy+jHOWYLZvamnRMGs48hH4wK5WCxgGpdlt72cOazupS7SFoknR
 6G1H/afl9lYfqJIe6txgRgxEA2KOXNI9QA/Hc6SqAtnUuDLS7Z7/xlcutTACmiEogZtC
 QM9Gxgxuxu6XLlYptXXAOjH05bnTjhIEdnp+k9IOBF9O5M7upZM88P/UgFhnAM9E5Wni
 bI18pVauSzN4dxyCc0avDHxNLVtxMG4jRNMonUmOcmAjU31pODBRtkmfJ26/lVVAwDXV
 Fq9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778854254; x=1779459054;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kPEX6BELjbFEr8DQmzcKgY8FZPyL7BOLdCyyTnR1dPs=;
 b=UvHV9DK3cXON8JKynG/mlRphlkUL0hi8x8IPP9xb7pfZdALC3wVLhhdxV9E4YqlZ0T
 otOkXft9oLRVjT8Sr3ew3h9E4zvRT2/cKuaSnZCJdt89mWVhcr/5lXC0RSSuWP+7M1oA
 YQQ454lQ89KlV4QUwVJra3PsBwoabLE7Kv2qBhOBXQs9VuUO8uFVZwaRaspkFrLBuTfd
 cUK7Ag80lZxfld8ECb+TCyEs9sn1aQlOQrDq+R3hVZE0gZmoHLqKO42wMrVl1T0o3R2Z
 fMnr6O8wEnP4wPSZQ4frNgsvV7x7PhMQI/iKjNHoLSFIXFKjwZLSailxNRTtaDKmtFIH
 zU+Q==
X-Gm-Message-State: AOJu0YzlKyCEvyPOmNPPLvEd0QAFAYDHRZnnV7dXySIcDygqaU7rZbXF
 iTJTpEffAudsthXPB/NfYa+ppsd+frtEdqzzOTeTzsXiwCjznq0kIwhj5MhzwzCFFlc/TBbzbzf
 DFtS+/vvSkR11GYYcdy3swBvSjqOP5FibWByx
X-Gm-Gg: Acq92OETO7LrlTJK3sYX9hX1kTiQ6l1Ql2v47uWbltiVTeUH4+skvaT/Bp7t0o5nz9K
 shH26Yclvk5F6UKKp3f1IpVr7mlTLyu/UWvYrrrsb3rdyUfVzpVjk0rCGBU0hNtyySGqOIMY4bb
 l6X15N9nbp/cKeS6872+jLDhwj4hSNYahDdz/WmpvXuGcWWZ/OOcY5uuyA+qWOy4AOHevR8A/lC
 HwCuhZ3fsCiFdBacKWN7DN7aYYQ+E7yur/jCXR7V7+rnkIgDyE3BpL5je6C/CbEYP4hDDmYj+de
 5Lh2Fh+k
X-Received: by 2002:a05:6102:cc8:b0:636:46ee:2f0b with SMTP id
 ada2fe7eead31-63a3cf2201cmr2080364137.12.1778854254114; Fri, 15 May 2026
 07:10:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260514175457.4047707-1-trini@konsulko.com>
 <20260514175457.4047707-3-trini@konsulko.com>
In-Reply-To: <20260514175457.4047707-3-trini@konsulko.com>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Fri, 15 May 2026 10:10:42 -0400
X-Gm-Features: AVHnY4K7Yf0Lak_0ffMondx6RqWvVDvCnDlOl-uBwRkQ61ClWI0T1XQ2nmKh0Zg
Message-ID: <CAMDkj5yW4C9qxPHMkapv+ZSKOBQCR_Knr_O8+FfmmfrMzyJBuQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] bloblist: Demote not finding a bloblist to a debug
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

Hi Tom,

On Thu, May 14, 2026 at 2:02=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> The message about not finding a bloblist will quite often be seen at
> least once, and is non-fatal. Demote this to a log_debug message from a
> log_warning message.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
>  common/bloblist.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>

Looks fine to me.
Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>

Raymond

> diff --git a/common/bloblist.c b/common/bloblist.c
> index d084be899588..09afdd1f96b4 100644
> --- a/common/bloblist.c
> +++ b/common/bloblist.c
> @@ -613,8 +613,8 @@ int bloblist_init(void)
>                         ret =3D bloblist_check(addr, size);
>
>                 if (ret)
> -                       log_warning("Bloblist at %lx not found (err=3D%d)=
\n",
> -                                   addr, ret);
> +                       log_debug("Bloblist at %lx not found (err=3D%d)\n=
",
> +                                 addr, ret);
>                 else
>                         /* Get the real size */
>                         size =3D gd->bloblist->total_size;
> --
> 2.43.0
>
