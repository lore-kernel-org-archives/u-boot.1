Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A77606A31E
	for <u-boot@archiver.kernel.org>; Sun, 15 Nov 2026 10:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=DJadeHFE;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uYYqwxvS
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8D5B440711;
	Sun, 15 Nov 2026 10:33:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Q2Fqc4SHIDWr; Sun, 15 Nov 2026 10:33:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BD8B240712
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794738793;
	b=bHoL3kjplziDAJL5sXfdlaagXQf3gkIzy7F0AVEgy/6FCrFE8pr1tFTk1+5mJ/KK/+uM
	 93bIUQRZAdhp8JANz4jIF0fcqvM0eCW3UEj2S8AUosoVwC0corGaiKhgupQbaH3wiWZnJ
	 ur6+GVAB9wvV23CH40LTfe9A1PAEiTLl3adZGJGGkn+KGbDmAFJdbrZDz8SH+u4AvzUGH
	 Gz5b5iXZplD9CtZD0aZHHwcqMQEMHdSqNAXazuF2Jrye0AoEx+/fePD3NIqB1rdimSAwT
	 aq2V0StfiMW+UfD9h+2cGZkX/Qh7HQ33TB9k0EBEj4z8suSpj78r1TAfzbC1/9fKwzQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794738793;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=WO5G9Hzfg60NWi8i801fQ6DRORlXAJNajtGvZgplaO4=;
	b=DfRNyQm56d7EUIK1RpHEpTcUq13XkRfjLW8jJwD5xiuF3AE3VEWdkczq7jnslzMIdzUA
	 oMuqRyJVMXZ8M9ZMnSFR0u7Vkjagrj9f0tYI38eLka0BoP/1MtAbqiNjaJ8iyruNDC+eh
	 m64pMZlLTqaurC9GTSt2YSCk7iqijARs/j3hPtOz/RJZqGk+6nocvp8GMZSjM2SxUfS5a
	 jOl6qNc6jW4tZo94GXR64scbruAtKE9b1kbF0VoUYCvsGk7Ms92x2W+WNk0ghyzRoeqpO
	 HqT4uMYx+K4h4+iqu9ElCnZ7BXYt0wIajaq7YNXCdPJ43/5dghGLSjG/z6r+7MDPTVQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794738793;
	bh=WO5G9Hzfg60NWi8i801fQ6DRORlXAJNajtGvZgplaO4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DJadeHFEVxyEn967oVCMZ/QVXyOESRP5lKRP/ybExPSJhTNr+oL9OfAm847P/3bxA
	 11sypfUWDMn3iq5i98I4ZlVDjaJJKB4J08IuDuikumXnWK0cfeGeyU/G2QjXJRWFrZ
	 elqR/MsIMfrlyJ35QWWLylHnwGVRq6m+dA/zih6mUzVUOhzRgbKeG+T2mw5TAaAc0c
	 3sFCVPsSWz6VNbG6B15SGYf+cXeVOHy9ocM9ydb2NsXF53b+zDYLDHkgKx5X2Vm8yP
	 HeE+olwGg0q3m6HH1uj3ihSwgPaJ7wPIfFZGBdHe29ldI3CMgtAP5+Gl2sWjQbhtAC
	 bwxKBon13cdaQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BD8B240712;
	Sun, 15 Nov 2026 10:33:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5BD8F2FB
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 10:33:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 41CFB60634
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 10:33:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uj8KVMiJ0uPU for <u-boot@lists.u-boot-project.org>;
 Sun, 15 Nov 2026 10:33:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0A44360611
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52d; helo=mail-ed1-x52d.google.com;
 envelope-from=massimo.pegorer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=uYYqwxvS
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0A44360611
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 10:33:10 +0000 (UTC)
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-6b56221d361so3940473a12.3
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 02:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794738789; x=1795343589;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=WO5G9Hzfg60NWi8i801fQ6DRORlXAJNajtGvZgplaO4=;
 b=uYYqwxvSbbV+AMHEA930eBUUi4w7KskoOKxVGpsMbdXn02aRn5C9+ts1P/GF2vLY9b
 ZqHbmfwcUsdT5Z68tXq5t1Ke6naFh1PmaqC8emUT+enXu6UgIGeGKb1TysQv5LXndChZ
 XlBChfhHUkrFH36rgQiR6aDJ0hKhM2dLWnnfx7lf/fnhcM0SfdnZ1DpnOVoQOD0Bby2w
 9LBXMlnlsWr4YAC4dm38vyenCBkFxCHAcQG5YPI4QeysmLGzndVeeIfgVc5492mddL3/
 pXjvBjDRpyfrMkKJbUBC6ySux2EtAEbKL5vnZabUuCxKs1xD0NPfDeYyvKRoRr+UuDgX
 bUdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794738789; x=1795343589;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=WO5G9Hzfg60NWi8i801fQ6DRORlXAJNajtGvZgplaO4=;
 b=Kiy7j9EPbYsDyyXRheA4c1Thj7ttgCpAtrEkVuZJ6M7Jj4bQqPS5wNDx3L128ZAecr
 H62qH8cSaLAF8Lwc7U2zYuz4LDotKjvVus8M2R1eBGo2Seo9wmW7VE167Ru6ANAIcHDX
 sRol+nSt2AEO9KqUFhXXfuJsDzbX62CnwhxWpXjYz1QI/oM04Ks2pNROc6rms1cY++Uk
 7n5cT8JKessunF/ugHDJWtC8raV6a65FriZMuC8zqbMQy0OG9I1qPgBUFApiEloEYyEo
 pWSiOT7EmpwwVc22AMHBX8Zb5lEMpG6J9pxFQ0deBk5whevz+Fj1SZYFdfgYtaRVU8Jp
 /xPw==
X-Gm-Message-State: APuU4Z9TUSNvZG/RVstgui7GoGzaJmIk0bnzhZQaKR+q8n5Z8H7zPtk3
 IBSBPrfCmmyMupJHvqURRHlUTjU2yXB5w7VjwiyQVlJ0b/TImLswNLvQQepGe18f6rpP2OBwuuN
 8D3avFOCq5nGz6QdtxYk/AHsPPoPAtqY=
X-Gm-Gg: AYBFou3WDu/cfPEwSd+4uN4EG7Vx8ZGi7Y5ty2WNWrjCKc8MEw/W4bWwc0//4+xIfGD
 Hxhkcj0J2Dpw+7Mgwznen83byXiRsvaoc1U6YnvslEN6YaCj8Evvj/mzWbxTUJfl0q3A7/4NAA/
 edgH2N+6cKDfPvkWRzaC38PUixfqXmRZzPsN+Vibob4JBwATG/VUHH0f1ZcM/dfseQ4vhoY9fIB
 /gzn0WpzHbdYuCJHAsUTomc0aIYBrhC97dn6ae5n2iwv/AI4MOLQ6LKfZximiflyoLdImG+PiNi
 VcyixOsENrEuNL7Oz5cZkXD3IFq5X/tp/eL78VCNwbvHCPLS5UsO5Rk5UEsmMPgDCM/nNoJQLqX
 xV9wP5wEzpHP64wqqu4/PYQZME8+JvceTysDGoA==
X-Received: by 2002:a17:907:ea94:b0:c50:5e10:71b3 with SMTP id
 a640c23a62f3a-c50962edfb7mr592549366b.10.1794738788691; Sun, 15 Nov 2026
 02:33:08 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261025-ddr-multi-v2-0-b82ff9c860ba@gmail.com>
 <20261025-ddr-multi-v2-3-b82ff9c860ba@gmail.com>
 <3e4b8eeb-ac8a-447d-98ea-74ec0e2ad14e@0leil.net>
In-Reply-To: <3e4b8eeb-ac8a-447d-98ea-74ec0e2ad14e@0leil.net>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Sun, 15 Nov 2026 11:32:57 +0100
X-Gm-Features: AclHuK8QIJeuZkJEmgRO5-Tb-BCq87f_JH5vjidnRlumiVRCHcLGhloZfPgKZXA
Message-ID: <CAC928HZd33v=R6C24eZ4ST1mnLC_=OKest4f9U4XEbC=5d-zRQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] ram: rockchip: reduce debugging code size
To: Quentin Schulz <u-boot@0leil.net>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Quentin,

Il giorno mer 11 nov 2026 alle ore 16:54 Quentin Schulz ha scritto:
> Hi Massimo,
>
> On 10/25/26 8:30 PM, Massimo Pegorer wrote:
> > Slightly optimize SDRAM driver debugging code to reduce required space
> > in the case of PX30 SoC TPL, allowing further code to be included such
> > as multiple SDRAM types support.
> >
> > Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
> > ---
> >   drivers/ram/rockchip/sdram_common.c | 49 ++++++++++++++-----------------------
> >   1 file changed, 19 insertions(+), 30 deletions(-)
> >
> > diff --git a/drivers/ram/rockchip/sdram_common.c b/drivers/ram/rockchip/sdram_common.c
> > index b7a8fce607c..b46de5d9044 100644
> > --- a/drivers/ram/rockchip/sdram_common.c
> > +++ b/drivers/ram/rockchip/sdram_common.c
> > @@ -11,39 +11,34 @@
> >   #include <asm/arch-rockchip/sdram_common.h>
> >
> >   #ifdef CONFIG_RAM_ROCKCHIP_DEBUG
> > -void sdram_print_dram_type(unsigned char dramtype)
> > +static const char *sdram_get_dram_type_string(unsigned char dramtype)
> >   {
> >       switch (dramtype) {
> > -     case DDR3:
> > -             printascii("DDR3");
> > -             break;
> > -     case DDR4:
> > -             printascii("DDR4");
> > -             break;
> > -     case LPDDR2:
> > -             printascii("LPDDR2");
> > -             break;
> > -     case LPDDR3:
> > -             printascii("LPDDR3");
> > -             break;
> > -     case LPDDR4:
> > -             printascii("LPDDR4");
> > -             break;
> > -     default:
> > -             printascii("Unknown Device");
> > -             break;
> > +     case DDR3:      return "DDR3";
> > +     case DDR4:      return "DDR4";
> > +     case LPDDR2:    return "LPDDR2";
> > +     case LPDDR3:    return "LPDDR3";
> > +     case LPDDR4:    return "LPDDR4";
> > +     default:        return "Unknown Device";
> >       }
> >   }
> >
> > +void sdram_print_dram_type(unsigned char dramtype)
> > +{
> > +     printascii(sdram_get_dram_type_string(dramtype));
> > +}
> > +
>
> issue: make the above a separate patch
>
> It makes it easier to see individual changes and the impact each change
> has on the final size.

I agree. I will drop this and the next one from v3 of this series, and will
evaluate rewriting them after running some tests on TPL size, taking care of
your suggestions. Thanks.

Regards,
Massimo



>
> >   void sdram_print_ddr_info(struct sdram_cap_info *cap_info,
> >                         struct sdram_base_params *base, u32 split)
> >   {
> > -     u64 cap;
> > -     u32 bg;
> > +     u64 cap = sdram_get_cs_cap(cap_info, 3, base->dramtype);
> >
> > -     bg = (cap_info->dbw == 0) ? 2 : 1;
>
> issue: make the removal of the bg variable its own patch
>
> Same reasons as above.
>
> > +     if (cap_info->row_3_4)
> > +             cap = cap * 3 / 4;
> > +     else if (split)
> > +             cap = cap / 2 + (split << 24) / 2;
> >
> > -     sdram_print_dram_type(base->dramtype);
> > +     printascii(sdram_get_dram_type_string(base->dramtype));
>
> question: why this oneline change here?
>
> Isn't that exactly what sdram_print_dram_type() is doing? You can always
> forcefully inline it, even though I'm not sure it's necessary
>
> >
> >       printascii(", ");
> >       printdec(base->ddr_freq);
> > @@ -57,7 +52,7 @@ void sdram_print_ddr_info(struct sdram_cap_info *cap_info,
> >       printdec(0x1 << cap_info->bk);
> >       if (base->dramtype == DDR4) {
> >               printascii(" BG=");
> > -             printdec(1 << bg);
> > +             printdec(1 << ((cap_info->dbw == 0) ? 2 : 1));
> >       }
> >       printascii(" CS0 Row=");
> >       printdec(cap_info->cs0_row);
> > @@ -80,12 +75,6 @@ void sdram_print_ddr_info(struct sdram_cap_info *cap_info,
> >       printascii(" Die BW=");
> >       printdec(8 << cap_info->dbw);
> >
> > -     cap = sdram_get_cs_cap(cap_info, 3, base->dramtype);
> > -     if (cap_info->row_3_4)
> > -             cap = cap * 3 / 4;
> > -     else if (split)
> > -             cap = cap / 2 + (split << 24) / 2;
> > -
>
> question: does the move of those 5 lines at the beginning of the
> function actually help with anything?
>
> thought: I'm thinking there are additional ways to make functions in
> this file smaller
>
> There's a bunch of checks scattered all over the file on dram_type.
> Considering we know what we want to support via the
> CONFIG_RAM_ROCKCHIP_* symbols, I'm thinking we could have a bunch of
> #ifdef/IS_ENABLED in there and make the functions smaller. It needs to
> be done carefully though. Maybe in a future commit, not necessarily for
> you to do.
>
> todo: split this into its own series, we don't need to have it depend on
> the PX30 DDR auto-detect thing. We can merge improvements and bug fixes
> separately from new features. The next patch could be part of that
> series, but I'll only start reviewing it now :)
>
> Cheers,
> Quentin
