Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 915F2CCF2D6
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 08:36:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 34EC980E2C;
	Mon, 19 Oct 2026 08:36:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CTASi4PLhh8V; Mon, 19 Oct 2026 08:36:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 80A9280F5F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792398977;
	b=WyKhs004JUhjDt354AekN4HPehReUWrYHzbtGaoIA0yNvTFX/CWp1ouEhHC2axdmSI7c
	 H3VL65lBbtrr+TXjIRPRdiLONx6CZffMwSicaUr32QwJUzGZ56YQqTKezKdtNrkIf1NOv
	 hYKKNaptiyMT2pzmjVRHpH4MXnYoErAn5VdqMY7FuIqlAVjlZsYIlaK347p+a1Xx2KJqh
	 RDNEi1DhKOBOegItwh7VPK6VOi/VI14Q4VdJoM0eYYH2ZDl7D29Wvv09JS0KSdS/kpSiT
	 zcWt65fzMXkGXuhMspYMcfnVM1z4aD97r58IfgVEWpXh/Jw5FVu6XkAbW40Aorvjc5A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792398977;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=DcS0G807pDr/3yBF3UXDCw00F05JkTtwd2kZx1tYwJ0=;
	b=jGVvNIKpYx5tCUvWs8FgNm7kZFOEt8bvXFLiYm+IeYLqS0vVh3S0TojFL+wi+UuV0wbJ
	 W4WdprtDkkQE2r1fG70Tnn+1fyWNF2kLPykZ/uwt5gFZJJuRm5WTfvjHGIkt/UsSk/dSj
	 P2tZt0Ci8TSFldV2UX3hTZkrkcTLO1+bG4ZGsQK54cRSZfv8l88icNZKrxRakZGmOETjn
	 CJQ4ODQMQ36vR8/aOZS1L38/03E6xgb3EN/FH/bcP86bL+6j7/uQUWDB4N1Bg6DP0Cx+E
	 IH9sY7sBKEADB0MNhYF3gve6e7Xjzchc5K/ppDQxS6QIhGnh6A4J78YqETM6i1UPAQQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=riscstar.com;
	dkim=pass header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=oqgALZVL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792398977;
	bh=DcS0G807pDr/3yBF3UXDCw00F05JkTtwd2kZx1tYwJ0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gagSgfvMapbATaaCD137/z0C/t7hyjFY/xAf4fkbig51zO0Xlcrpg20uj2CFmh3tT
	 HFWkK5seVtTRwAL5c4UOG0g6mludxmCAdk18xfe+fpnw3VKgZlozfpg8NxfsnwGzRf
	 YBoVURrxLe8mB+FT3tBl1m6ZNuN9SXQeeHLWxEKRSHQYjO8rja4cbIjVLcc3MeI4Zw
	 V7XU5dBl6RGFFk47kemx9K9BWmvDP+PENEEkJT8t94Uh0UFecYgeV3cN6v3NRjv10u
	 ahZFHQZlEx1SJL5bpR/0xhzaSOqK1MHkiGMa+nowJrBaCRSgByRq7IOr5MPn8aPC/S
	 52UBk0D7I31Xg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 80A9280F5F;
	Mon, 19 Oct 2026 08:36:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id DA9791AB
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 08:36:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CC57080F5F
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 08:36:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Lg0VBg8A9GWz for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 08:36:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org AED1A80E2C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::229"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792398975;
 b=AWmKlarpZwgkw53QOzSb7isYfg6b2FVemRIHmPZVOxaU7TzObONTlHGI0A8J7R7RRI5A
 9YXAaF3CbPxJYJ8/AlBITK+ntLxSIi7t3aE1rFg5O0wF8gnhhWvGSQl9otRQvbjIjfNKD
 skIf7SB9GKlQ1a8CcBaa21ge6DO7ixlUlYARbaaiSh82w80GGwTeXOyH4Hl2qtZXdehzb
 YaJL0nWYUKbXHQCbfPKbBYdretJgJqMdsXKXZ0nepAHFGukaB36Oq747HsVTW2bPazhnD
 Hx/RIBSoFZe95dVTYGepZg582ZDHD0CXO7qezYpq87FAhK2nRkPIoKilRm2sQFmzxjw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792398975;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=DcS0G807pDr/3yBF3UXDCw00F05JkTtwd2kZx1tYwJ0=;
 b=UHiQDQ2kY2By6k2KGE3OnOq0Yw2RWEsEjXgAfYVE6AKO+CrzAY3XicX9/NMpYXe6x6+S
 XANBdGqVCH+PvKfrVs6iL6bHd82heW+0wLYb+4e5DLU/2YnNLVV/SobHIho0mby0+HEmv
 WFuEzphaYF5PydGgpMDH3Bw6VlKx1ltoqb7r3PGbWWoslGuZVHT7lzsqSfX2wCSYcGpny
 C2TrTnNSl/8THx4l+g5qEKCFpwGl+6NbKn2cXZxfUcjvfLN3KOt0mxTRqvGHlaJW+J1/x
 V+/7l2e2Gmk+2UdJ2P6rYqjmBbtari8YJi7kzM1YRNgqhYP4c5eCZmjOMkFBFYhFCTw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=riscstar.com;
 dkim=pass header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=oqgALZVL; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::229"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::229; helo=mail-lj1-x229.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=oqgALZVL
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AED1A80E2C
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 08:36:14 +0000 (UTC)
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-3a75f960be4so10420251fa.2
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 01:36:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792398972; cv=none;
 d=google.com; s=arc-20260327;
 b=MMsZVKELIGLBNE8Fo1oXzLt6C1Qdqb+WwDza866pMoQxjoIJddTXwHZD98O6DXYlpy
 oE8KVSpQHfa1/QeoKBOwxNlBSJbEl767weCL/PmIN7P7/C80JD0b1EdmeV6A1RrR0I5l
 N/bvFvZMyg6mS0T0kLRgLO2Al/c3W3vGZl5KYs2rRRmtGky4rtyAO2pfPU5BlHZjodqC
 krrQmbDgyUeulIFOMGiWjCNvA7FHsaqekmYfgQvAkpUGdcrVDmqi4oAYsf0K/Re3IRVp
 zEnaDD6U2U8gL/q6FA/nXZaPdJbgTm9QL8Jb8hTKINSEkT618ZC8XhNSw8lujtQy1esS
 JrMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=DcS0G807pDr/3yBF3UXDCw00F05JkTtwd2kZx1tYwJ0=;
 fh=PssCzfAZagILEbYV0uOcrKn/3Pne2m6Yt2vbWJ+c4C4=;
 b=Ivf80yWpVZAwb9IdFlpcY5mWJNGCz9eY85WBcwLpybYsWFclk6bITgw8mboBxv5SMB
 Q3DdS/d9obYwRmNcV/m3P8ktTznk4olvn+GM47NePRF/+WIWtgtR55NG5f3cOE0NkHdu
 9iDbjcjYABq8VjEY8CVsrrNGMGigOGnC2EFpmzY117XslyYo0XaVa6xnYn9sYGyRao7s
 VKRRskWkdM454aeypsi6fOKx1lCOKNTG1TXXIauDFEIc6vWKL85zxF2tg0wCkCXrV0Tz
 yDks7ph36NpT+b5j0LQ2R6+WeBoHcFoEYUsCnXWMclvZHmy6ESzCT3XgSnyZR7a1IqEC
 INsQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1792398972; x=1793003772;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=DcS0G807pDr/3yBF3UXDCw00F05JkTtwd2kZx1tYwJ0=;
 b=oqgALZVLu+eceqvShV42/j0yRD11jn5qqv8QXL9jPNXQ/zDwtv/PvYBrFWr87nNUES
 X/BGwgUUnBWAkuNL3Gjlm14KYZUUClHCbv/PdSyygEVW3bnVxvJk6cyAWydraIFbYjdH
 YaVrrNEbt9YpnFV6J9d+LDcMkJgXzsdtsrYu8ZTBofOfpceA7gogNvcAIwgg+2kwT8yy
 rq2w2ubcpFsd9jp79U6XhT5FtBZCcTnzd5MCcyEtUfqyASVYNs9OJnnPTiSg1OKhh91O
 9sJo8w3OhpGfsQqncx4ugt2/ELbMyw5QCtOP/n+w/72NRaYhASQDTdgNj1Hm0RQCW8A5
 17gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792398972; x=1793003772;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DcS0G807pDr/3yBF3UXDCw00F05JkTtwd2kZx1tYwJ0=;
 b=LQUx+jPkPkjI11xE26+9NTnIWuqRWyAs+J7kBH39r2EJ/GWwhKFbSVqxsbl76Bl6Bu
 9iNNQzynnacKQbaIXGuAITFKDH8MXH9BCIlvkxmVxusV/PXns61+nnsn9DJnU6MbgXTB
 s31zHUpnVliBUuSXn0H122nZz6YAiFKq4MkcTejyJO6ndeFCDj17VPgzRKlOMMPt3Sep
 nV1cXG9bHd43Pr50Nw0u5HIqXf3UAD+ZYbMScR5NS32+fC+EVyZThjvAqJMkILB5Hs7e
 RMCiq/FN1mokCWYRrzoiFi3+BEtC4pIy6raZAIKM1KhymHhWww+zTLq6WcFhVU6O88MJ
 RZxg==
X-Gm-Message-State: AFq9FYIBWFLY7WbosRbMYXIsF7Vo70gi2zX75SOqsQn76XtBmAuVsiKj
 g1uo1V4KX24Af3V43G9xo8w8tBu7ltr2ZpQiX1sqDMmcxb+TuC7bfnp+o4lJJMYpnjC79s51BqP
 1RasxbMe1sZevW3KsAcquANwA2piU8+J8u4ab/78+WQ==
X-Gm-Gg: AYBFou0dXpDjCW8R71VESKutlnPqa7msVdgHZygKNde46qhIUOx/Tqn6l0ivHnXAOza
 C8H1QkwMA5cHyZ77CVoXFJhSCm2dwxcyfdFJ+E1bkZWBdf62LBeH+uFGTXehomSqrv8pvOQwnY3
 OSXEe+7o5SJolR9q6GcTS6BVtQDg5uYFvse4XgVU1n6gww58b731aTT5Hiy6KPmLBpS/i6JwxP8
 8iTMyJcwH2MPb6VHi79ARPdNeUYrF+jIByPrm9n8D/zSCfFTyGN4VMW6OPwEz84wh3lnb0cleiy
 ZAXFIfeciIy0lJyUGd69iF0qPFx0DwmVQPkM4wiya56j0R/f99/nKYth9fZ+JLUb+QQ0BJXdlB9
 VxtDfJY1EuFVM/FDsLmzloilI7qH9iGbAm0GnkByLuSmJ7MP3CwI3ybGy4LvlgzwROGjxeubyG8
 pkqYQD5jBRecx/
X-Received: by 2002:a05:651c:150a:b0:3ab:2bd8:41b6 with SMTP id
 38308e7fff4ca-3ab2bd84c78mr13400331fa.2.1792398971771; Mon, 19 Oct 2026
 01:36:11 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1790975598.git.DaveWK225@protonmail.com>
 <b8f3a43efb9393b4a852c1d8ee9674e7c8a2a894.1790975598.git.DaveWK225@protonmail.com>
In-Reply-To: <b8f3a43efb9393b4a852c1d8ee9674e7c8a2a894.1790975598.git.DaveWK225@protonmail.com>
From: Eric Chung <eric.chung@riscstar.com>
Date: Mon, 19 Oct 2026 16:36:00 +0800
X-Gm-Features: AclHuK_3MQdLSMpv1qLcVkoeAJpwiBsTET4AJK9H-bKE7VIFvME5rsc7QbyEWgk
Message-ID: <CAH22mJyfKS7du8W1pTwc1eFbgfn7O9Wq_oaSDp=wxBV6MVBw8w@mail.gmail.com>
Subject: Re: [PATCH 2/9] pci: spacemit: hold the PHY interface in reset until
 link start
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
> The probe sets APP_HOLD_PHY_RST and clears it again straight away,
> before the PHY is initialised, so the controller's PIPE interface comes
> out of reset while the PHY is still unconfigured and its PLL unlocked.
>
> Linux's pcie-spacemit-k1 driver sets APP_HOLD_PHY_RST at probe and
> clears it only in start_link(), in the same write that sets LTSSM_EN.
> FreeBSD's spacemit_pcie driver, which runs these controllers on the
> OrangePi RV2 and R2S, does the same and notes that releasing the PIPE
> interface before the PHY is ready leaves the LTSSM stuck in Detect.
>
> Keep the bit set through PHY init. The write that enables the LTSSM
> already clears it.
>
> Signed-off-by: Dave Klotz <DaveWK225@protonmail.com>
> ---
>  drivers/pci/pcie_dw_spacemit.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/pcie_dw_spacemit.c b/drivers/pci/pcie_dw_spacemi=
t.c
> index 7ca5a5ad1a..04b3161e94 100644
> --- a/drivers/pci/pcie_dw_spacemit.c
> +++ b/drivers/pci/pcie_dw_spacemit.c
> @@ -245,12 +245,14 @@ static int pcie_dw_spacemit_probe(struct udevice *d=
ev)
>
>         ret =3D generic_phy_get_by_index_nodev(port, 0, &phy0);
>         if (!ret) {
> +               /*
> +                * Hold the PHY interface in reset through PHY init; it i=
s
> +                * released together with LTSSM_EN when link training sta=
rts.
> +                */
>                 reg =3D spacemit_pcie_readl(pci, PCIECTRL_K1X_CONF_DEVICE=
_CMD);
>                 reg |=3D DEVICE_TYPE_RC | APP_HOLD_PHY_RST | PCIE_PHY_LAN=
E_CTRL_MASK;
>                 reg &=3D ~GLOBAL_PHY_RST;
>                 spacemit_pcie_writel(pci, PCIECTRL_K1X_CONF_DEVICE_CMD, r=
eg);
> -               reg &=3D ~(u32)APP_HOLD_PHY_RST;
> -               spacemit_pcie_writel(pci, PCIECTRL_K1X_CONF_DEVICE_CMD, r=
eg);
>
>                 ret =3D generic_phy_init(&phy0);
>                 if (ret) {
> --
> 2.55.0
>
>
Reviewed-by: Eric Chung <eric.chung@riscstar.com>
