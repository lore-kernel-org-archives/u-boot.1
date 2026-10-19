Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB747CCF2DA
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 08:43:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F08D46073D;
	Mon, 19 Oct 2026 08:43:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mbW4qw5UCScf; Mon, 19 Oct 2026 08:43:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3DC6D60722
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792399420;
	b=CBTPMwHkUYeFP4fdE6VfZxnm32Im5Bk+YzQd2uymOHEoM8YyEKeEs02UNrd8Os1iuJoX
	 DlvshE4V/bEjTAopF7Vx+GnHAL9PBhHngMtyH6pJv8tbinwIBuoPrVwfPy3qxG0vZVMlk
	 i+On/Se+r0Oe4M+AQ8giCdgunpvFSuf4fcN2JG7dUn+lwUZrdfJbjx584nu3CWX/row6/
	 pKzBO6IIxvUJgw+uvcOURRiIXDcEKUQlGoT0VFPSNm+4pdLN2NpvdIfcHqkCjFOd9kLvL
	 EJVqB18Ru7lSvO7dWI6egqhARLr5QdqLeg/GiZNJXAomgujqj4DbjN/jYCdtDcX+dOA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792399420;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=aFrmSz+JRTamJxjN71PdDlMFVsYQmmhetspsWH0v6KA=;
	b=R1jEetV/RnWP1zZUsHSYWucG9/uaeTvNjtppA6bk5ZdwmNwXhxCvgXDNzk2pr7hwpMOi
	 VTnxNGKWjnnTRvg7X/p/ab3dfo094Fl+u+I8mxDcUyKU+QUIIHS3KIPsWHgTn990Iqc7c
	 qdK8Ewzzs6dw1E5qHzYM1UdimcSHvmfMQmqCGMfhhlYv4EAesNc38UXUmot65AHj0QGOn
	 /kCqDyHqktC0HZ5aIaoAGhWQuYsfGcQV5WO2NDx0ayfSr4MTH5DBhU6MhkAcioT8ZGvON
	 WBJDcjsYE8jcqMYInmPbBwt44fAGEML1tiNUIEPRizRqiVV9QmGiiI2iLzTbJRjpQ4A==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=riscstar.com;
	dkim=pass header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=0n5t5asL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792399420;
	bh=aFrmSz+JRTamJxjN71PdDlMFVsYQmmhetspsWH0v6KA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xhB0EflaqX05nOK8lsXsFbyqzwozmE4cAOE+ScRzrnm8Yop0ClJQD9+iCl5/JIO1/
	 AP93JZ/jW6ZYn+owzVU9ym8Qy9D2LiOdNdEzhDg4PhABKzcslPUDTh7chkGWuaKwey
	 sr2qaq6RUmd5b1UVGAsgvXdXeCVNo61rKJdK/MVvcyS71Wa5tyHNrCvRuQECbIn+w8
	 ZjLYHgFL/FU20EX4NWDbt5LCToFMe7NbHI60b6or8B1dddRiT6OegnSdWbGZM5UcSU
	 8eBxXGRRKFVK0KllkIdt05xVFb3n6wlPBy2M/kOTQ61xx2s+QVa7PtK/7m8Ydl3Yei
	 zue6wDuE/4k5A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3DC6D60722;
	Mon, 19 Oct 2026 08:43:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4E713465
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 08:43:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4C19560722
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 08:43:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AxZ6gGmhA2g0 for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 08:43:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3D2F16069B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::233"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792399417;
 b=d2q3DjVm6rL4XjOZA7HBmeBONMUKnXbJrH4h2lVwWwUWx2g3g2EjAs5v/n0F+vI0RrKp
 nCWYVLpNiemvX+j7cXQTdowIgK72p5PrwjKsIPkU2YuFBR2kx4xoq5C7q8chVbcCGVvHV
 DmBaKA4+N9oHFkqBQp0U6K8vBjuVuDzQhDMxas/+hylhLX+dIOVB6qzvky0e7+m8ZGj+J
 s57A0S6kTADXQid3co9ABlpcTZpSM2D/dFGvRvmtOEDHXF4EFSWxN+OgWWSpmBoX/39+e
 glodRmoTZmH3BkeN+LpgCBJLq++brXyJwZXI1FGPgC/P7mlz+W1uEsTlyqwCH9h3B8A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792399417;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=aFrmSz+JRTamJxjN71PdDlMFVsYQmmhetspsWH0v6KA=;
 b=msZpPJh+DFIOVaaB1u29g5DyF4pVSK3IOLWrIhdC/yJUaDA6GpgMrYPOcdna0WZPgIyQ
 hS0pwFKzprmG3zcTjnWTHkVtQ+/rVGDPd0yygM8wPXTlEGWq/+YxXF+fC/pLF8STBg694
 QkOJ/zX8jodggP0rqCmccfhwSJ77e7MPXh0ExVJp4Q2IBtftpEuLr7v+Rlpvg9COuJIyB
 1zNc04sByXeH7i4rIJtbXwtsuXHDidz7RhkFqQj4jOb1SOtzqgLfxxyK3Chtgr5THB1j4
 OtCGaT3qmWyNy1YsdSOSDDX1atCJTTEKbT1Xhnm73bO4WMBkHZA+zj2a/2cgVcGyXEA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=riscstar.com;
 dkim=pass header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=0n5t5asL; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::233"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::233; helo=mail-lj1-x233.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=0n5t5asL
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3D2F16069B
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 08:43:36 +0000 (UTC)
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-3aae7df0971so12158501fa.1
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 01:43:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792399415; cv=none;
 d=google.com; s=arc-20260327;
 b=VkXyI/DHQ4uK1E+raASITrMvGuiNe9n8m3BhUKrI34+62omNjPSPZwv2vrEKq45BvA
 Wt6mLpMkVdhnP5Kqr+cVlDOt4uZfdSiz8W++fjLPYL/0K6F6btyEkd5rq1zEh2OacYbj
 EcwRxq4uXuW04D6WdkQ4Yw55ZKOuzYjUfWUOAlycnOAre5xeNE1G1vvhqJ77F2ebWFC6
 sc5DqZYsvTnn+oG/XzoUZ+kxYW0hOUuWhVnE2JhBu1tOz308joiApaGCQUVzjDDd8t7u
 6SszJk19AXw81vBQ94VvSMpGokdv0Do9GSY7T3w9Ei9QFcmijzA3TPriIwT+GZUBZy4U
 rMmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=aFrmSz+JRTamJxjN71PdDlMFVsYQmmhetspsWH0v6KA=;
 fh=PssCzfAZagILEbYV0uOcrKn/3Pne2m6Yt2vbWJ+c4C4=;
 b=N2h8qvGH0Y+8X2ppYjBKT2PmzP3VxheKnz6hio5fIpeR3Du0IaJ9A7zzMf4hq2pmLA
 iah5a099dYvmDGe7QW0HyNfaa/wlolZAbFpi1JNf1b4vs8yRM/Tmym0h2qSkrWl85mgS
 TnWGKoDdQPtkZJ4aYzrVbQCokg/nokVpY7WPMYPvzeu/4vizhFbUddligIGKDvX2O6na
 32TKttk8bXRSF9HtAmXfBTeCBf/6Qr+nY6E548ySWfJPULw8Cnx+1egepSOXb5iFXvEj
 oJbKcQ1oWGUaOoozq7WeD0Xrfs7Od1ApYRAmUnL6mwnlyB36rMT1bFeryhiwwg81M/9P
 xjew==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1792399415; x=1793004215;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=aFrmSz+JRTamJxjN71PdDlMFVsYQmmhetspsWH0v6KA=;
 b=0n5t5asLMI82vaFjXaOURUubbXiiBPK3W1Oqjgq8DjVi7i/tn6W49v2eHkx/wvBEfM
 Ja+6QcYJgQo40bEN/itaaX7bG4Vgc4BdPSTdr7k8Yy8h8xtWDJnPDaC3rK0OJfwGGO0c
 WQvkmhLX4E2a3FtEpUljxYAkuEHctKFJxPDldW4dGTimL8TCZluGpmfdur30DivBAeqM
 KELRZ2TA/CmUE9g599VDo0G41Qs5Z0sEbpt1p5YG3/JamQSg/d2vbKSVrvrocVFeqqtR
 X6sCr+z+rJl+TUbHdva5AqKjCBPaApuQb3g/0yeNCIWxHkB0w1Fotl/Pq4bfvByIAh5O
 Uqhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792399415; x=1793004215;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aFrmSz+JRTamJxjN71PdDlMFVsYQmmhetspsWH0v6KA=;
 b=vcFdpmEOotsfoKCXrBepS8Eh+5O3Py6Ci38KudtJCTSK8+Pd7TmzBO1uzpzv/0sOMR
 fX0vqP4p+c0Dwa1shPHZRHU0HvtwU1v8R0OuPIn0kQZkbZdwOtqwaLDt293nYaH1225O
 T30O3DwmABW4JHbXBSYHAviuU5EuqagdgkVTP87A5MDz6J21o8be5q7Ff21RG7Yzt7FP
 j+kfka0+Wxikfhoi5qCw3p3CXySWckPTyNZcAl5VWaceMj4sizjDIRyIhKOMNbg6gfLV
 Q96skxdwFfQjKh4MsB/Gcb6yZnPcKPoSlbMddf2nc4N+wUFcSQnT5rCQgJX5KRW2StMY
 VNEw==
X-Gm-Message-State: AFq9FYJlAJ9YtP/U43nsXMFAe0edNWMIco52Lu4mKqIlFeLWijgePkMF
 Ru+OHlnNBmCYd12CFFHRCkPFB9TOLYJ6vv+ZMQ+CYQCkGYvP+d3t8CSZ3LOOmZQgvEIZ/NIThaW
 SYocjg+B0ij+yV+C6DLZEqycx/slyzuAZMQVP+Gr97g==
X-Gm-Gg: AYBFou2sO5XE6vOhYkOlSwr7YumB8Md7kGNsJ0x2HHf+tZi4vmAnnYx9o6Qild43bKF
 F5FuU6etytk2BXaoHruq+9aNBdv/WcPQGuCA9Re+AwN28R3hHlDFjAegNk7NKg8lHNBj1JmVPDi
 S9GZVnMQzjliWs+tSIASi7b/i8wfWK+kt6nAnYgLYwi2/G59m7g67y4fTfJXADx6MRVylde7gzu
 GkT6Vy24XXxsgkCNjQvEki9vgi8QOIzkxnqdXUu8GCjim78xW/ZUMeFgv9CESK36NV2I8Pu+aXe
 Zp6pIA45YGKbYqu8iBP7UF8gTqoZ0zOjVNRjbb1PFePmPPiYUZ+/31wkD4darxOtlr+dpaPyR/j
 2fY3ocpFZ653k0GGwXG5H4qEze6uRe2WsDkrBJJggnW7Gsn0D/hq83JfnvuaYtTVrIuBLB42jYv
 geulV78yRlSeme
X-Received: by 2002:a05:651c:324b:b0:3a9:74f3:17d5 with SMTP id
 38308e7fff4ca-3ab28f49124mr14888621fa.3.1792399414727; Mon, 19 Oct 2026
 01:43:34 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1790975598.git.DaveWK225@protonmail.com>
 <d1c78810bc9c32630aea7329250676fdb8ed21e9.1790975598.git.DaveWK225@protonmail.com>
In-Reply-To: <d1c78810bc9c32630aea7329250676fdb8ed21e9.1790975598.git.DaveWK225@protonmail.com>
From: Eric Chung <eric.chung@riscstar.com>
Date: Mon, 19 Oct 2026 16:43:22 +0800
X-Gm-Features: AclHuK_Z-31zWoehYkaelbgX_YlblHkcDWtbEK2PhRIFbznimOPnrJsEsZfNYnQ
Message-ID: <CAH22mJzJ1mUuS5-dXmg4Yfq3ie28Tvh7YHiNLnBa5u4=96gGCA@mail.gmail.com>
Subject: Re: [PATCH 3/9] pci: spacemit: soft reset the controller before
 bring-up
To: Dave Klotz <DaveWK225@protonmail.com>
Cc: u-boot@lists.u-boot-project.org, Huan Zhou <pericycle.cc@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Yixun Lan <dlan@kernel.org>, 
 Tom Rini <trini@konsulko.com>, u-boot-spacemit@groups.io
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On Sat, Oct 3, 2026 at 5:30=E2=80=AFAM Dave Klotz <DaveWK225@protonmail.com=
> wrote:
>
> The probe brings the controller up from whatever state it was left in.
> After a warm reboot, or when an earlier boot stage has used the port,
> the link can still be trained; the driver then prints "PCI Link already
> up before configuration!" and skips the link configuration altogether.
>
> Linux's pcie-spacemit-k1 driver and FreeBSD's spacemit_pcie driver both
> pulse PCIE_SOFT_RESET in the APMU control logic register for 2 ms
> before enabling the application clocks and resets. Do the same, and
> drop the "already up" shortcut, which can no longer be taken.
>
> Signed-off-by: Dave Klotz <DaveWK225@protonmail.com>
> ---
>  drivers/pci/pcie_dw_spacemit.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/pci/pcie_dw_spacemit.c b/drivers/pci/pcie_dw_spacemi=
t.c
> index 04b3161e94..b85de73ad3 100644
> --- a/drivers/pci/pcie_dw_spacemit.c
> +++ b/drivers/pci/pcie_dw_spacemit.c
> @@ -106,11 +106,6 @@ static int pcie_dw_spacemit_pcie_link_up(struct pcie=
_dw_spacemit *pci, u32 cap_s
>  {
>         u32 reg;
>
> -       if (is_link_up(pci)) {
> -               printf("PCI Link already up before configuration!\n");
> -               return 1;
> -       }
> -
>         /* DW pre link configurations */
>         pcie_dw_configure(pci, cap_speed);
>
> @@ -133,6 +128,22 @@ static int pcie_dw_spacemit_pcie_link_up(struct pcie=
_dw_spacemit *pci, u32 cap_s
>         return 1;
>  }
>
> +/*
> + * Reset the controller, so that nothing left over from an earlier boot
> + * stage or a warm reboot (a trained link, a stale LTSSM state) survives=
.
> + */
> +static void spacemit_pcie_toggle_soft_reset(struct pcie_dw_spacemit *pci=
)
> +{
> +       u32 reg;
> +
> +       reg =3D spacemit_pcie_readl(pci, PCIE_CTRL_LOGIC);
> +       spacemit_pcie_writel(pci, PCIE_CTRL_LOGIC, reg | PCIE_SOFT_RESET)=
;
> +       /* Read back so that the write has landed before the delay */
> +       spacemit_pcie_readl(pci, PCIE_CTRL_LOGIC);
> +       mdelay(2);
> +       spacemit_pcie_writel(pci, PCIE_CTRL_LOGIC, reg & ~PCIE_SOFT_RESET=
);
> +}
> +
>  static int pcie_set_mode(struct pcie_dw_spacemit *pci,
>                          enum dw_pcie_device_mode mode)
>  {
> @@ -216,6 +227,8 @@ static int pcie_dw_spacemit_probe(struct udevice *dev=
)
>         int ret;
>         u32 reg;
>
> +       spacemit_pcie_toggle_soft_reset(pci);
> +
>         /* enable pcie clk and deassert resets */
>         clk_enable_bulk(&pci->clks);
>         reset_deassert_bulk(&pci->rsts);
> --
> 2.55.0
>
>
Reviewed-by: Eric Chung <eric.chung@riscstar.com>
