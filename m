Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81D83C55179
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 12:33:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A93CC60750;
	Mon,  3 Aug 2026 12:33:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FH3w7DEH59an; Mon,  3 Aug 2026 12:33:03 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 69EB16072F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785760383;
	bh=WB7aAKoFoy4/PS7j8MGQ5gCDsfANg8G5NY4yL22Y9Yg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fRC5/mJHVx4YSY7Esl98Rn+BVAzsHwDkAhlusI4UKxuJViTx2Qu70NRaEzRX0Sq7S
	 Bn15DPBwC4gAEi00MgUgtjzXoS254QffHHyDnKm5pp+qZFGsO2lKmxRv/u8bkf3iqw
	 825wKZMWifKqq26Gc2fPRiuUgO15Uj30N0LJZTkLTqvqdSlKkFaPShoelP+aD7KAs3
	 dpo2k3PYs7DltYXQfXgT7/bvwJ13v2dajMdnBerDovLKhrcwJ+hmWZlx9rSPMNc4xR
	 Vf4z6236QWSEZUtORWKZxgi+WcJDM3O5LftkBKFCNHWLmplBSIclE5jxcQQulWv1iN
	 qHUpLtMFopKDQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 69EB16072F;
	Mon,  3 Aug 2026 12:33:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id C9F7E282
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 12:33:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BBFEC400C1
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 12:33:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h6QcTW0ZqZ4P for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 12:33:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::f31; helo=mail-qv1-xf31.google.com;
 envelope-from=pbrobinson@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 036F2400A0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 036F2400A0
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 036F2400A0
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 12:33:00 +0000 (UTC)
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-9063b380982so32498736d6.0
 for <u-boot@lists.u-boot-project.org>; Mon, 03 Aug 2026 05:33:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785760380; cv=none;
 d=google.com; s=arc-20260327;
 b=Y0KKE6PoyjSBuKjhrTncUBH/zd5T9p4HSyD9qw+66vM2UUwKgVXP0kfMciypvVkb8m
 NkTwv1B0kJ4KH1k8rQfOrZdUUMJHNwIIhWuMWrbPEAn3aD8u9b3Mn7/WrmpSXa5nQ7ws
 MRTFKg2KoVkuMPOJy1xCAcVwije2wuQk32zL7PC3++Aj9+sO/mkSSKCav/Kwh4R0D4Yy
 VZL6gwI4/ug/pl3NKPFH52pbX+dIU3DbKwQfIrvmaOYwSIYYE45+70Ix5ols9ODOzr6h
 9eGOl4wImKr1aGXJwIbRbpQoZnfWR1QRS3FSkM8jv9wvzTUOkt4CFUPmkP+ttMddTuMo
 OSNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=WB7aAKoFoy4/PS7j8MGQ5gCDsfANg8G5NY4yL22Y9Yg=;
 fh=SDlPTmTTdATptcwqDru8oKU+K01z8I8DkCUI/djVBEU=;
 b=LurweROcyWQKRq/yrc+ZQZPnKqKIhraFxB7y/EsT9Yr+GAkOhxPvJu73wso6UkVkX6
 Jn9JMsKcWS6iv+ROExV6VJWtGAQoeSXERCJu7fSi+vluUpCtQBGLeIMPiY80CgsZFlc/
 boERD/pFB0G6b2GfN08S453zooJsMmJf4W9NIuio3ixhKuL1+bOSpbo2ym+EXoXW0HbY
 btxIIymlGFkHZjyiBVyaHNFlVNHhkpXZ1qqEhNDkY/1LVYEY6gZ5YTL1RlQUrcbCWBUo
 u4cVcFstc2Ph9eCNnZBlTzSwm2Jepzj5Bytq0WLFj88UPLbabCBRAhK6rZjIayxnMdUH
 svtw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785760380; x=1786365180;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=WB7aAKoFoy4/PS7j8MGQ5gCDsfANg8G5NY4yL22Y9Yg=;
 b=BxHvbDuuc8LaNGBq8x33VpfHfTPJ1Uw87Mn1l3CdJvtDXD8o/OXw3RSNmNmZqWt5//
 s7KmBXvZYLgMc0FGWOGQNr9hccrznwvmY/XaMefD5Xdpk/+7bYt+KkvQpfkHy356ipOC
 BFenU9DJnr7NrfPkgIO9o25+sctiGKnE6lDjywjQr6Pjyaoe/BI0d6+ZS4xBm/OKBlHn
 uamJ11yzZIg0Sg8XlPpVT9bv/oWCN/w4yievcoqP/drh2JMIX8FpxH4ctFIVZz48GZRP
 0ZS1IYGJUHzscyrt5bIDHFfHYuqePzfdWX6ZCX7P11oEmI6vNi3iLW1pYfUO/ZgPqH0y
 w3ug==
X-Forwarded-Encrypted: i=1;
 AHgh+RoTzmhEMnWDv0QwJGVgMXuXFWbkGDSsu3n6UO3sHG2D5KPjPQrsjwnKey3X7mCX9Kku4KAMxaM=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yy+qSDvDreQMo0rnXlJqWLJMkHgXKp1fhIYKfecPx1UouEENqBz
 4SofOZ0vn/anwqIVVBHB/ud0xSZTXzRekUZk5nD9yUgmgGK5HZ0ZxJWrrMdjocQLkcesnRqSPg6
 pFoMIk9R3ZfybogSKeqjQuBIqtUy34rM=
X-Gm-Gg: AR+sD106q6U1pIu62jPoSjMO5Vg5l3w4iMNuD4yN3P9db7Pozgj0dIwJwyTv96njmdG
 /Fgmw2kjHrb+F+kG4qw9cPAJfn8E8tIALy5cZ0A1pF4mVrwQkx5TPErunINlOEy+4heRcXJ3vsx
 GQki8ku0PkuP7aosAxTQIshitA4jR1c4apSICYPUaEh9l9NgXrF+t+dH4dr5U0C2cOWVKDuOeH0
 TqDIg8yZ8Examm3oAfnnf0JUB/NOk81/bTxMw/r0Ipg4XSOx9Cu8EPHs4SYssCEjJ2W28ncFpZi
 TZNF0Ot6ShwURR9CZbEA2zXOULXk7xQye4bZX59MkGi/h3lQYLxRczY9vg80kc8zqUdALtqxib6
 EewGvZ1t1SzslMUAMidQCVAOGpuyk2YgxGwIliudkReJvGGPDifKYjFafQ4P9mgtMOjFBnPwnk3
 5eh8aZcEgpBSDCs1elA6KzdM0rkhKtddumEcbRLCE=
X-Received: by 2002:a05:6214:19e8:b0:908:2369:df1c with SMTP id
 6a1803df08f44-9084967348cmr186919866d6.20.1785760379662; Mon, 03 Aug 2026
 05:32:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260731-gpt-4k-v1-0-a3f1f16b53ae@flipper.net>
 <20260731-gpt-4k-v1-2-a3f1f16b53ae@flipper.net>
 <CAC_iWjJniUgONw47_WXAZZRsvrT_y6SJTyMLMOa+Hn9zy5BeFw@mail.gmail.com>
In-Reply-To: <CAC_iWjJniUgONw47_WXAZZRsvrT_y6SJTyMLMOa+Hn9zy5BeFw@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Mon, 3 Aug 2026 13:32:46 +0100
X-Gm-Features: AUfX_myVLyFu7mURwEXAPjJwr4SZh1PdP45dCuv5a6GRNqRTGtEhl3p5uwk_BXg
Message-ID: <CALeDE9MOOjXRf4MAt=N-BmDdEQ522nQabEB7uoAcmf6t9fADQw@mail.gmail.com>
Subject: Re: [PATCH 2/6] disk: part_efi: Add missing endianness conversions
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Alexey Charkov <alchark@flipper.net>, u-boot@lists.u-boot-project.org, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Tom Rini <trini@konsulko.com>, 
 Anton Burticica <mouse@ya.ru>, Javier Martinez Canillas <javierm@redhat.com>,
 Simon Glass <sjg@chromium.org>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>, Quentin Schulz <u-boot@0leil.net>, 
 Kever Yang <kever.yang@rock-chips.com>, Jacobe Zang <jacobe.zang@wesion.com>, 
 Jagan Teki <jagan@edgeble.ai>, Heiko Stuebner <heiko.stuebner@cherry.de>, 
 Jonas Karlman <jonas@kwiboo.se>, Suniel Mahesh <sunil@amarulasolutions.com>, 
 Klaus Goger <klaus.goger@cherry.de>, Tim Lunn <tim@feathertop.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785760380; x=1786365180;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WB7aAKoFoy4/PS7j8MGQ5gCDsfANg8G5NY4yL22Y9Yg=;
 b=gn2nYlBzPFFfrkNjND/XnWGPVf30VdrOi9t57hFXDNYazSt6/14WfZ+waPd4H+aA06
 8FysZUWta5IeoILmQCPVfDcf9d5mhwMOi5YVY3qDB5XB2rsEjE5AS2QbW7ZGd9a4S1l9
 IjzIe2hiU3NVCWlaB2IW1MOmtQcf75FcvbbbXDS2dh7siGQd5Apb1gYNTZ6gtsPBNwI2
 AmB0bVkI088TWPMNFrbKoVx6QViR5C+6Z+BwldD/PcJ9ERu9WLK/kDM2xGjEZx0e7/Vp
 8YUOSE50Y/k8chNeHNLoH/IqedlvrblKnoBgcNPRlCrcLfIAREIOgmYF4ZvxozVxl+M9
 Ijzw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=gn2nYlBz
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Mon, 3 Aug 2026 at 13:20, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> On Fri, 31 Jul 2026 at 15:40, Alexey Charkov <alchark@flipper.net> wrote:
> >
> > Several GPT header fields are read without converting from
> > little-endian, which is wrong on big-endian hosts.
>
> Probably because we got no BE architecture running EFI.

Isn't the EFI spec explicitly LE?

> > gpt_fill_pte() takes my_lba and partition_entry_lba raw when working out
> > the region a partition must not overlap, so on a big-endian host both
> > bounds are byte-swapped garbage and the overlap check does not do
> > anything useful.
> >
> > gpt_verify_partitions() compares the loop counter against
> > num_partition_entries raw, so its "More partitions than allowed!" guard
> > never triggers.
> >
> > It also swaps gpt_part_size, which is already in host order, having been
> > computed from two le64_to_cpu() results a few lines above. Drop the
> > conversion rather than adding one.
> >
> > All of this is a no-op on little-endian targets.
> >
> > Signed-off-by: Alexey Charkov <alchark@flipper.net>
>
> In any case it;'s good to have
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>
> > ---
> >  disk/part_efi.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/disk/part_efi.c b/disk/part_efi.c
> > index af311867a285..062389c3af0c 100644
> > --- a/disk/part_efi.c
> > +++ b/disk/part_efi.c
> > @@ -462,10 +462,10 @@ int gpt_fill_pte(struct blk_desc *desc,
> >         char *str_type_guid;
> >         unsigned char *bin_type_guid;
> >  #endif
> > -       size_t hdr_start = gpt_h->my_lba;
> > +       size_t hdr_start = le64_to_cpu(gpt_h->my_lba);
> >         size_t hdr_end = hdr_start + 1;
> >
> > -       size_t pte_start = gpt_h->partition_entry_lba;
> > +       size_t pte_start = le64_to_cpu(gpt_h->partition_entry_lba);
> >         size_t pte_end = pte_start + gpt_pte_blocks(desc, gpt_h);
> >
> >         for (i = 0; i < parts; i++) {
> > @@ -851,7 +851,7 @@ int gpt_verify_partitions(struct blk_desc *desc,
> >         gpt_e = *gpt_pte;
> >
> >         for (i = 0; i < parts; i++) {
> > -               if (i == gpt_head->num_partition_entries) {
> > +               if (i == le32_to_cpu(gpt_head->num_partition_entries)) {
> >                         pr_err("More partitions than allowed!\n");
> >                         return -1;
> >                 }
> > @@ -877,7 +877,7 @@ int gpt_verify_partitions(struct blk_desc *desc,
> >                       (unsigned long long)gpt_part_size,
> >                       (unsigned long long)partitions[i].size);
> >
> > -               if (le64_to_cpu(gpt_part_size) != partitions[i].size) {
> > +               if (gpt_part_size != partitions[i].size) {
> >                         /* We do not check the extend partition size */
> >                         if ((i == parts - 1) && (partitions[i].size == 0))
> >                                 continue;
> >
> > --
> > 2.54.0
> >
