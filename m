Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17C61CC6B1D
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 02:08:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 54DD3406FB;
	Wed, 14 Oct 2026 02:08:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mZ5OsQuscziv; Wed, 14 Oct 2026 02:08:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5F5EA406C4
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791943693;
	b=gifo9sLTuUD8tEekEXX2bT7tgqlp+F5L5rb7LOMjPpjYKy8mdUKweFqRH4KlCCNumzbv
	 Ei+QgsFE4nSH7+GGO2T8bddtsnXv7sqPjUehKt6zlVGrrl0m90NlbOeRnukiduGcV3FyE
	 EXDQLJjYieyOXL/CQ9NXvbO45y4ZSnkrzEBsDg5Au7zcG56n1kPmVJJjX+SPEUfIM6tuL
	 SDW/PJz/8G+x91oqWiTDaDu4J/6WNd+Gf1pgTKhvBPAXCR3S0fca7Go0rCNV/1Cgte5C7
	 QUygeXzbVXB6Sx8rQ0ZpdPwmpOzM8bei4dTQM47VvBVM8E4Tb8WknuO/MgsoMnqd4NQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791943693;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=KwmrJ2HyDukSjUibHNfPiL4NSTAmxcPkpcVyK9mRVHc=;
	b=BYZxHUJ3xrQvecN+Bdr/zpSuP/sewsu+pQR3gOzomVJpXsnJW5Kr3dAzg77VS3nCojHx
	 MjAagopCMcJqk8L+FGaCpGCQoXO5tCh0W1FO8mlc0feX9LceEuvL0HdS2MARpEEBkWZjZ
	 3ETdcMClS1Hq50knJxSzjJeUpMNZW4hC4RKu60tPM9juprcKssLVksJU2YJKkAqCki45C
	 HNz+MUzB89hVoWiiRZ0NlSIxHcwU7UmoGUr3rcCR2orpx/ufI1o5Zl+BacO0Tv8VDEQN9
	 BNMpbeFqAK9eVl+ux/j82D2xRvicmf3ljmJ5fUIfjPJHihI2Yrjq4sOkfdczzNtP7gA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791943693;
	bh=KwmrJ2HyDukSjUibHNfPiL4NSTAmxcPkpcVyK9mRVHc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=r4Jy87PqMG2VwGwDbY4wkH7lN+h2Vt5IclkukcO2/14MzV0i4k24j8NWRiFSqa4OC
	 hqHwxCQMX+hge53PDd0PdVlXqG+CMv+un2MlS47+XVUcJzqonuaNdhUpveTt8h+03p
	 jgSY6yEXJjYnldYS+fLZfPJEV/R8gsIrlKXTDCayBx/tb8zZD46y3dO8DPXa4DBaOB
	 r68YKJJnSvKbYhpK4yvdYm65sygHkdlFpVxknTzTqoJFBnfGzxn7KthpTGjIwzpMUH
	 JaWghtoHYCbgEfbUc4mvgyLKjKBCfehx/ajkoNxMMgm+8qe0sGUMu/x+rV1NcgR/sU
	 Uw+g6FBLEzHyw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5F5EA406C4;
	Wed, 14 Oct 2026 02:08:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2562B2AE
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 02:08:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0A6AA4008F
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 02:08:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yYRWB5Mdjpnc for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 02:08:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org CE38D40079
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::634"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791943690;
 b=EkIZHGnawyuarBZjkz7HhR/AcloJJUQ/LCeAOiboy6jw6K5OsqZ9Qfr3Bad7MDzffe/p
 5R/htNL7iM3+OUZZeC6LvlIf3iohcnc+tsUQVZA4E3Lqx94hZfxP1x5bCTh7BBEWGSxRx
 iG1eKMocCyGyuATuNfcM0yviuC8lp4aFY9HCur9Y8wg4vOB9U9cuvll7Hb+Ihv+N+Acxl
 mXLNZML19COC8awxIzg0XpUOvpF1oUmQ4fW4GofJd+Ny91ZIkDLd41t0lupwAUAc6k/xR
 mEqt76kg/ubS1Up3thx0YLaPOTYQKHXsXfk8kv1kNThT+CRxuvQVJ6aN1mv6Beivw3w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791943690;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=KwmrJ2HyDukSjUibHNfPiL4NSTAmxcPkpcVyK9mRVHc=;
 b=Has7B07vs2z7dKztmiS13RRQzm1KGRr+RMrwtGU3urzyZlvOnlhSeVZ0/bdCqS2PdUew
 dgu9hKF/bFutNvFNzXNw5pCWy38OS151Yv6sCoq8EwcmrEK9qGv2mj0IUgYZcsnykflXX
 WOw8w9vdQ+D+O+YSZND8yPmge0c4nRWi8WdS7uQFjfRqtjRcWEpnimYkpFk7kytsRMYE6
 IZ8h9ZyPvuXGfUZ+/ApgwMoHtN+k6XqujrZe2Hx/RcXqa05sIR6wU2xzRPY1ZUhylHzQc
 +aBTE5cbWGMaVhuXDEMRSoaXPWucIdNKVVUFjfGwgmvBWSta5KtgTGcZUIcmnjbjY5Q==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=VNmuv9fL; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::634"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::634; helo=mail-ej1-x634.google.com;
 envelope-from=jim.t90615@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=VNmuv9fL
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CE38D40079
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 02:08:08 +0000 (UTC)
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-c2dcbcc546fso440664666b.3
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 19:08:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791943686; cv=none;
 d=google.com; s=arc-20260327;
 b=g7aTYVaW2lUptrAg4G74+NWUV46Abs22H5jZWKdzYK4kifJxmkL9q5D5RPpJ3kx6G3
 ZCOpf7zsoGb3pi6WEGXRYWdviOrZQ3U/AvCbaej53Al1gWKoYUQr3n0VVXS8uCCbZDPC
 kfOEFgnQmZPohgifw1APnau9sSxyRuFiscp0h7yPgdA3f5/zsFM2ggdhwEnDnkMkd4gg
 4DAUKVf1Mjw6S8QL1+O4kP7cmJeaexEiyfKutmWOxQM/ldC/vox44DkE0EwVsjex7U70
 qupOKgqmfHFX/eErC65QGEwrTY/CBSzW9Z4kIoIR88JWxaVV/nK7YibN+9OZHvdfo6YY
 pHug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=KwmrJ2HyDukSjUibHNfPiL4NSTAmxcPkpcVyK9mRVHc=;
 fh=4/uT7Z/uYQWLh2M5pOpwJJK0pe1E9Zt3VME2NYTuCfo=;
 b=sbeMPF+DBmB1LIoIo8x/DYbv0WzdDL+MS7p78/z9PfHPUjC+zJWS9MeymzTyewNgZ8
 faC4qFdZuOkgf4OiD2HwSzh8j+/HFhGvuohx7uW3fMRcpp0xC1+DhPOZnyJLa95SNjGW
 nxCuvQl2NTToyzo2wE+waEsLJMBgoJP/y5wUPQCrhs2ApNLosTqfaHCJ3cAT8iwe00fp
 pRC+VHMd1obsQhPzr94vm3YjLjjF+yPXfmp71gTx8zhxSpMzI45pqxvFeAn+jKRaPNYL
 p2/DiKMBgRHawPmXrAfnNmi11ppv3t19m1GQkzXILqIXbsIN0Wjftm8wH7BnPFWi2Pxn
 r2Rg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791943686; x=1792548486;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KwmrJ2HyDukSjUibHNfPiL4NSTAmxcPkpcVyK9mRVHc=;
 b=VNmuv9fLY+ywbZ0yHMj+zdQiUdcMcNjFXd/efodCY1sSCJlj+QOO6Sbrhqw6fhP6WP
 LueK+6NZHidS63F9Hks2vLYeweTUmkrFaoD9/DajIZxRvq7/VFwATEOgOXIoRxPKEkiH
 VFNfs/kes7M72Dxtak6l9w09tZGDAW/MR2yNTvhim1htfFNjuPfS9FeT8tU02OKyYu+I
 DvdwE47TNVjZtcD8wmiOJnIhkzkD6I/v3sIGrD1WGwZC1M/oiPbGTcl1HFvFkGOGP3Ov
 2pzIYyGMF43c17ThMUaqg9sjaBmGJWrCwfADDUaQ2ugUifofn15UXIz+1gT5BEWBELDl
 rT9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791943686; x=1792548486;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KwmrJ2HyDukSjUibHNfPiL4NSTAmxcPkpcVyK9mRVHc=;
 b=oRRoIl8jB4Dt+3zVJCGA2a/O6XNK3wS1YJpSDp1wuGUxp4ZLXWHjaL6PqMDo0dwCmH
 pw9hRAoNjmO0izDTIqL8XX8SwCcpiQc8602g/O3rv495S5jceHvfBRuyUw/agGVlrm8/
 0nmihJSgYrDno7RTmDC+kKyPkE4UNl2I39bRE4VbC2K2JPTPV1zLFbBZKErOlfoI6H0e
 VzD24lODeoB9yv61fVmNQTxvq1haHwp55HBSGcIybx4KKQdkFrumeXpW3OD0w3x/rnDc
 8V/yLo/AzVTZUrpN96V1sokQGnJgKHRzkGny3qhaMuCma7tmVo2e6Evt2O7jwJaTIodN
 HD7w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxWd/1fr8sTKb2Yt2wAFKTLb9arm2HyLW3ecro6UJCltdG64u3VuWiQ/Du0DtOlUICUNaYWSyY=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIakslDDpbPDvfYKGYqLFCvUyGiWWCbCyT3+d/08UCwf6O0otdl
 brCWySdFyFYImUEXGaiZxnjjQFdZdqsTkaGeeEhtGGI2J6ZX+hFcatTFMlZq/jRpJO6IYdNk2Hn
 eIcAG+/KBP4RVNhUQzdG3Q3Zoy92U1j0=
X-Gm-Gg: AYBFou0D0epzEp3WfYnxle9qbdj+/H/Xft2Hcqa7c+y3YKFOGFmyn42rM9a6U92DVD0
 NhGHqLZAv5J4K2LKv1Z6e1HNtULKfK/soMJOETrvyk2shyXIzhlhFo8/vSOogsUhq4zkk34om6F
 H87qDIcNQfj7F+fi70ypT2b4dgjGXb++M0zVnsUBbtAXCy5NV27ee/pw7cSwPxiUeYmNZ1rxg8E
 u0vhu4/fnhQOgEW+/bSZWg1bTwK3DVtuGYQYwu4Wpy5l+EdBUqMUnZehQ7xW36zpAZtya1kE3l7
 qiIFFYC1D9LXg46FpDa/T3LlGuZQmZD+sm5+se1yk6P8mSxHEcg77v8m
X-Received: by 2002:a17:907:6e90:b0:c2d:ca32:2176 with SMTP id
 a640c23a62f3a-c31a9fd2ca0mr1448007466b.8.1791943686384; Tue, 13 Oct 2026
 19:08:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260914091613.1194020-1-JJLIU0@nuvoton.com>
 <d354dd07-f33d-4e23-ba81-0a5b2b1030de@arm.com>
In-Reply-To: <d354dd07-f33d-4e23-ba81-0a5b2b1030de@arm.com>
From: Jim Liu <jim.t90615@gmail.com>
Date: Wed, 14 Oct 2026 10:07:54 +0800
X-Gm-Features: AclHuK-4jDQ3NjxMcq06n-cyGB1Sg4LP66leCMfU5npWgNCc1iUs_iQPaY_hCak
Message-ID: <CAKUZ0+GHDOccujC7389VS3o1r=JgFUhz8-JF4LrLT9HaV-x1Kw@mail.gmail.com>
Subject: Re: [PATCH] net: designware: Disable SGMII auto negotiation on NPCM845
To: Jerome Forissier <jerome.forissier@arm.com>
Cc: JJLIU0@nuvoton.com, trini@konsulko.com, u-boot@lists.denx.de, 
 u-boot@lists.u-boot-project.org, Stanley Chu <yschu@nuvoton.com>,
 nd <nd@arm.com>
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

Hi Jerome

The changed code is inside the existing "#ifdef CONFIG_ARCH_NPCM8XX"
block in dw_adjust_link() (added by commit 5354774b6b3 "net: designware:
Add npcm8xx sgmii pcs support"); the #ifdef line is just outside of the
diff context. PCS_BA and the SR_MII_MMD/VR_MII_MMD definitions come from
<asm/arch/gmac.h>, which is only included for NPCM8XX, so other platforms
using the DesignWare driver are not affected.

Best regards,
Jim

On Tue, Oct 13, 2026 at 7:57=E2=80=AFPM Jerome Forissier
<jerome.forissier@arm.com> wrote:
>
> Hi Jim,
>
> On 14/09/2026 11:16, Jim Liu wrote:
> > From: Stanley Chu <yschu@nuvoton.com>
> >
> > Disable SGMII auto negotiation to avoid link-up timeout on NPCM845.
> >
> > Signed-off-by: Stanley Chu <yschu@nuvoton.com>
> > ---
> >  drivers/net/designware.c | 33 +++++++++++++++++++++++++--------
> >  1 file changed, 25 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/net/designware.c b/drivers/net/designware.c
> > index 6ed9c6d538a..5ff84c13bf9 100644
> > --- a/drivers/net/designware.c
> > +++ b/drivers/net/designware.c
> > @@ -498,16 +498,33 @@ static int dw_adjust_link(struct dw_eth_dev *priv=
, struct eth_mac_regs *mac_p,
> >       if (phydev->interface =3D=3D PHY_INTERFACE_MODE_SGMII) {
> >               ulong start;
> >
> > -             /* Indirect access to VR_MII_MMD registers */
> > -             writew((VR_MII_MMD >> 9), PCS_BA + PCS_IND_AC);
> > -             /* Set PCS_Mode to SGMII */
> > -             clrsetbits_le16(PCS_BA + VR_MII_MMD_AN_CTRL, BIT(1), BIT(=
2));
> > -             /* Set Auto Speed Mode Change */
> > -             setbits_le16(PCS_BA + VR_MII_MMD_CTRL1, BIT(9));
> >               /* Indirect access to SR_MII_MMD registers */
> >               writew((SR_MII_MMD >> 9), PCS_BA + PCS_IND_AC);
> > -             /* Restart Auto-Negotiation */
> > -             setbits_le16(PCS_BA + SR_MII_MMD_CTRL, BIT(9) | BIT(12));
> > +             /* Disable SGMII PCS Auto-Negotiation */
> > +             clrbits_le16(PCS_BA + SR_MII_MMD_CTRL, BIT(12));
> > +
> > +             switch (phydev->speed) {
> > +                 case SPEED_1000:
> > +                     /* SR_MII_CTRL.SS6=3D1 */
> > +                     setbits_le16(PCS_BA, BIT(6));
> > +                     /* SR_MII_CTRL.SS13=3D0 */
> > +                     clrbits_le16(PCS_BA, BIT(13));
> > +                     break;
> > +                 case SPEED_100:
> > +                     /* SR_MII_CTRL.SS6=3D0 */
> > +                     clrbits_le16(PCS_BA, BIT(6));
> > +                     /* SR_MII_CTRL.SS13=3D1 */
> > +                     setbits_le16(PCS_BA, BIT(13));
> > +                     break;
> > +                 case SPEED_10:
> > +                     /* SR_MII_CTRL.SS6=3D0 */
> > +                     clrbits_le16(PCS_BA, BIT(6));
> > +                     /* SR_MII_CTRL.SS13=3D0 */
> > +                     clrbits_le16(PCS_BA, BIT(13));
> > +                     break;
> > +                 default:
> > +                     break;
> > +             }
> >
> >               printf("SGMII PHY Wait for link up \n");
> >               /* SGMII PHY Wait for link up */
>
> You mention NPCM845 in the commit description, but this applies to all pl=
atforms using the
> DesignWare driver. Could it cause regressions?
>
> Thanks,
> --
> Jerome
