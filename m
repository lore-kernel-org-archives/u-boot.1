Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE52CCCF2DA
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 09:43:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 814FD605F4;
	Mon, 19 Oct 2026 09:43:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AdDglF9f4duu; Mon, 19 Oct 2026 09:43:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C6772606CF
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792403002;
	b=sxITqTjR/rnwE5PlCHi+Mc6iQGd+WuhIzM4XmripocWu5C06EEYaAbrFGn8nEzh11h6E
	 zfEbKm6v78fBxv05Jw39Q+OoNFBkXFyWu8Gnf/cBJdtfUqkmlVUf4jOzDs0IGSjUbqrP1
	 KWvsvqBAuQGerk+Ii86ozk0ZI8bSpb9ssJ8p5kpLYz+qwbA+gq/7gtPeSp4P2TgiuNere
	 eaNjsu8Yy8ecNiVx+O4vEb7lLoKIzi++2BqNydSI2Z3/YLiyDrVuoqhe4Vu+77U2DO4Rc
	 RtXpmCZVKzfoJNGnCcfMgCjaWYqeaha8pEXaIt0ReHX0OhiIQnoZRiblhqEO7sDlB1g==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792403002;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=92R13RHjiFteSR1CnNoZAY/ODpDomsdx+0E5ipdqHI8=;
	b=fRAxTvV2fYxe+4LhZbg5arDueE/qRZFdGCEa9RCAg9YhlM9BS+kRoN9yE3ea8trlnOtC
	 tlF88krb70nscGBjyVgDXTZbPhs67VuwgxqsNKL8mJF0pgUjpvEJihivsKZ/Jsf9Skyo7
	 hEhxfrmvUNqxTpzMpdOtydVHD/r7zQewSBtqBOtbsS4qsrwPB2tEN/yDcdp/NRO6JdybH
	 WzHhEwJNkvZsn97S72tszhYySLHoCm0SzIuBfLRNt69Vv/TNQra9oGb7nPbDfbjVTLqNH
	 rkVGScsj1WtnOwWd/cYD23ONft4B6f86I/F4MJ/jpFRwL7jy10sieqO4Bzby537CYkA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792403002;
	bh=92R13RHjiFteSR1CnNoZAY/ODpDomsdx+0E5ipdqHI8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=a7jZcQahlVObmxVx3ju9aWv6v3eawn6UBVDXLULTPuf1gt1uMcklsyvqUbE5vt00k
	 sTgPm+MIhPhZVjGI6DXPZlkOL5ikJRnNAtnjd4ADChAh1vEfVAM/9bANxlvO7yOsxr
	 BDY2peXM9bUAUwSaH+pUlvucjILX6w6ekTIm8Ngw67qzFLdrAVkSaP/M2EduwW2Q7X
	 7tv9GkuG+dnYQXogfvopYrJkJreTYfTs+1tl0NeL6K5S2tFoFEUI3T3qkd5uhQwGY6
	 CH8yiuxovVGooRISibDLl3sFsZM9+coP0lpyWf/P/yGk1+GBzyqkf6gNYUupwyEjgZ
	 eP6MiIi3i0l8w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C6772606CF;
	Mon, 19 Oct 2026 09:43:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 106A423F
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 09:43:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EA5D7400B0
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 09:43:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1edCKYMghZkI for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 09:43:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 3C4B04008E
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::12e"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792403001;
 b=UVKghXKgs56esUrZgpAQfSmz1WmbqtGE0vlZ2zUz0JdrlkrTCWAgllYBONymWQEDvKkt
 z9Bus1iodJfiJqZcMlIt90vFrXkDdAyGGnRIS0XieeiW3+935oLgTAAv3/U9uca1C9X8+
 o0l7hgm+tfYn6pRs9MfNdgNvWQzJ2RDqYp6Zhe8Rm05ph4BQlggLC01XSz3LFNnj3suEv
 qRV4msgdvzbKEOBVHzkwkq+nHqbOJX7K2r+4j7+lqqHS094eORSnkn5e6b4u94XCvpADR
 rocMvD7FVHGCcMdrMOB/ICIenlbB5ATC2cZPc5lU5UvjuWv6gE2yUQSrX6Ov74p+/Mg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792403001;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=92R13RHjiFteSR1CnNoZAY/ODpDomsdx+0E5ipdqHI8=;
 b=l94Y6BSwU2CvFQEJByNT6zjmsqqblJsGP4fJ/lqsPQRJLrU1qBmUDM0MshMldojn4gK3
 BDDu6LcccXbI3Undskfo47YW9RkLPuHNoh69jh7DYNcTRauxMu7auLi/wvCyImxeuJFSH
 Vxl2ZfhZVsX0/7uuPgs4szFH2ytJwr54tBowvG028tauYcp7H36h0CeXgDJtNlXSnNnUt
 fd2KpFeB142WHDib9tnlsPJprrjCR3Z8uISNJJIR+MeT3+8IkTrtbRfo8jsklTPjusuDG
 b80XNSEa76jSiaJ64kYW2UjTYHN+4rlRz5u9H9xqH/wufbzZ78Pc/9yIMGaHq0cIMwA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=riscstar.com;
 dkim=pass header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=fn+uHG1O; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::12e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::12e; helo=mail-lf1-x12e.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=fn+uHG1O
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3C4B04008E
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 09:43:19 +0000 (UTC)
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-5bcc6094d7fso1479785e87.2
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 02:43:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792402997; cv=none;
 d=google.com; s=arc-20260327;
 b=OLyRjJh7PG1nYMsODjnnt2kERQaWgZJQoxAfwHx7cxGM5GwN3iccQBFppE694ff5zk
 ZU9OJgBCw5SrtYC/ReHBF8B0zcDVqTFBVLB5oDk7RyyFNgCoMKxIYt5FjgWR1AFT9XCv
 0cZ2mg3rYtcgQ9EpUkgjVhlRpFBkjYBBMnIw2WTTeljtpUWNPg/VDUJiV9sOLbe9yA7C
 kqtpQUmlMoByRcj/szYcIrAG4++xl8O5VijPBJZEYEMDGgxjbm0I5nrKUoPQM3nplGoA
 S4WRHqnM1FmWTtFSgyG+6Ee5dA2wtbWktXOw+5uaEUdBB+ZQS/iVeJI9nLUGQPveRNnx
 5Nkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=92R13RHjiFteSR1CnNoZAY/ODpDomsdx+0E5ipdqHI8=;
 fh=PssCzfAZagILEbYV0uOcrKn/3Pne2m6Yt2vbWJ+c4C4=;
 b=BkHrfX9t50KOoAHnNbPb82sX+Qran7e2WnkYmy6S5aBL8CNZxmEWAoVkt5tduFQ/08
 ckqQbI30W30wr10AElWhc0d1kenJcE/hQgyhzl92MBBhHA/ru7f7/ZpqrzcgMP+Mwi+v
 VkuIyweCJjrQFQJoVI01DbjeHCqer9BCQS1FvFySziaLRD1gTz1YHyb5iY+KS6ChSE7X
 recHnUhOc8Q8qiRUmn5ImeUEaM5brPwjhyhdh/6sYo462g6AqZSn02r++QzxSAJbtVl1
 PsCeykquzjHPWIgpR6TydCbQyed+o3lvLSTKEo6fixWJ/UPiM7f4hoFXiEcJgmZRJY7h
 u4SA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1792402997; x=1793007797;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=92R13RHjiFteSR1CnNoZAY/ODpDomsdx+0E5ipdqHI8=;
 b=fn+uHG1OYhWhRBJBL/n9k9EZY7k/5/CB5Sz5owUh8YOOhfoKKu2roTsc1Oob5QBSR6
 tGzxs5iUvzAoIWUjoxNWFpxJMTu8oITGnURD2A3WmYNFhgyj8w6CacdZBJstUjDfce17
 OlR8DJy7U02/fYZQ7SnVq4NHgfiPm9+dclSWVNJKdhhp+Leak9SXrsd/oi6r2lSk8n+Q
 IXwGK/s5qLr8UwIA/kz7Z/cjEYKK7n0ZaXwc0nzdUtLpLboXKoi2FdQwE4LMgJAfv4jP
 Il9f3gYxWEw9+QzREWQTPF8rGbysdTYJTffLXHngJtu7+nlxLoVHczzJyDkNdHwn+C2V
 acvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792402997; x=1793007797;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=92R13RHjiFteSR1CnNoZAY/ODpDomsdx+0E5ipdqHI8=;
 b=oZxwEXkCXVwFk5v6LY+4eDW5Q19xN6Cu5JGh/cBShbnPPcC1B2d9oq+i2af/LOCfqh
 43SdRFEivSF5duqW8ZJUD33mQfuOsBrrI5S4nf7UfdsLJr9NR2ZTsUUcxRQqiK5no66T
 YKBVeAgxRg8fTFuHeQmPb9QvjosCYbSyUXbiU8cC66bvxEEoG6gNTqPW0TNZsNqn08RU
 02TLmBZGjbFDIRpiiYL8/pjkPgrjSQ+ZwnbhDwTNvvUu7uBXk5hGC55eYcoyfcOTBnrf
 5tNAUGWJXrvDJMJNfDnxHkV7ctFZn7va/Q+PpTAogxyxJMd/hLf/qU3Xm95CxQUkaIcs
 CeVg==
X-Gm-Message-State: AFq9FYJxMPLq0aJ5LrGx4LsfSO68cujz1m3yjtbpLU/R1TFtCm/Hi6GW
 VL3Rmv/CvIz4Jj7KxKhl/CQvNKcZQ+2Wv9egpoZr63Rhxs+t02g6VnE8o6YMOy4ZtMIluZbXUgX
 Cf9MC0TKl/k3MFi2OJyrRBAOy7uu3sn0nH/aPEx1MXg==
X-Gm-Gg: AYBFou2cp85SDPuJP8rEmmqrlh6A9Rn1FL4rPvS9WH5qiG3vFpt3r9YB4KZLkjoMmpa
 Y0DiK7+7W/QWkKlD1F5HUwEXAx3zepN+Ftztr3UcXki0/Y3D+xsR9aSZCBMRrg4HBjqytqZAV1m
 Q3tb1DbHNCeLZP9pZwo+/oSRfC0h2SW6P7jOUiouM8CRrDiYLZTapCOoTE6sTwQ1TmczvDmwUal
 M2Fo7wY0YldySmHAY/rYjjRVOX/pVfVqdyPIW0lDV62zTKcOkM1o7VPJq2Ogfq/8W6+ACv771Nl
 ui/48xhwXiQ0SXpvyfltgkqtaUhjrJ7xuttM6kDVUwrPJ4CdgtS9Rt+dDIRXwDGFEhG8dksCz6Q
 fHqx2bHhG8yluTlT+Df0l61FzyojWisGUYsJqg3IV/kdkK/JT93dYr96YTDHT3ONhjeeduZcUPR
 xcY+pA7ghnIM2E
X-Received: by 2002:a05:6512:61a:b0:5be:50d5:3bd7 with SMTP id
 2adb3069b0e04-5be50d53c13mr1491924e87.14.1792402997418; Mon, 19 Oct 2026
 02:43:17 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1790975598.git.DaveWK225@protonmail.com>
 <da9405675d3b0527e90e4d59d81b3a7ec24d1075.1790975598.git.DaveWK225@protonmail.com>
In-Reply-To: <da9405675d3b0527e90e4d59d81b3a7ec24d1075.1790975598.git.DaveWK225@protonmail.com>
From: Eric Chung <eric.chung@riscstar.com>
Date: Mon, 19 Oct 2026 17:43:06 +0800
X-Gm-Features: AclHuK9Fr3mHWUsBhzf7Jr8jFSogwJlrgwLPC36b105-EHcECCsTifqLSX5Vdak
Message-ID: <CAH22mJxN+PGx2Y78BOb9KZr47+uDRpmT6h8_JY1UmzquLhQKZQ@mail.gmail.com>
Subject: Re: [PATCH 7/9] pci: spacemit: do not advertise ASPM L1
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

On Sat, Oct 3, 2026 at 5:31=E2=80=AFAM Dave Klotz <DaveWK225@protonmail.com=
> wrote:
>
> The root port advertises ASPM L1 support in its Link Capabilities, so
> software that configures ASPM from what the port reports, such as an
> EFI application or an operating system that does not reinitialise the
> controller, may put the link into L1.
>
> Linux's pcie-spacemit-k1 driver clears PCI_EXP_LNKCAP_ASPM_L1 at init,
> as a workaround for errors reported on some NVMe drives. Do the same
> before link training starts, so the port is set up as Linux sets it up.
>
> Signed-off-by: Dave Klotz <DaveWK225@protonmail.com>
> ---
>  drivers/pci/pcie_dw_spacemit.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/pci/pcie_dw_spacemit.c b/drivers/pci/pcie_dw_spacemi=
t.c
> index 6ac1d6bea4..3b5c2dc4e0 100644
> --- a/drivers/pci/pcie_dw_spacemit.c
> +++ b/drivers/pci/pcie_dw_spacemit.c
> @@ -71,6 +71,12 @@ static void pcie_dw_configure(struct pcie_dw_spacemit =
*pci)
>
>         dw_pcie_dbi_write_enable(&pci->dw, true);
>
> +       /*
> +        * Do not advertise ASPM L1: as Linux's driver notes, some NVMe d=
rives
> +        * report errors with it.
> +        */
> +       clrbits_le32(cap + PCI_EXP_LNKCAP, PCI_EXP_LNKCAP_ASPM_L1);
> +
>         /*
>          * Keep the hardware's supported speeds unless the device tree li=
mits
>          * them with "max-link-speed", as Linux's DesignWare core does.
> --
> 2.55.0
>
>
Reviewed-by: Eric Chung <eric.chung@riscstar.com>
