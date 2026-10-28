Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C3F606A31D
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 08:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=yGF6nUDi;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Fy7TLxG4
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 102764066C;
	Wed, 28 Oct 2026 08:56:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6CA81Uv6ZiEx; Wed, 28 Oct 2026 08:56:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5722140651
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793177817;
	b=IqKSOlk1Gka1FUI6Tc/5KTlwpcC1ZbOd7+mWlqlo8Ae3HA2ze75aUtkCAmzsYT63P6tp
	 XIU98EGaP7/T2kBHY5Unk1OHDFpOG6jVqUL7nTqnXIfCd1L5J59iGX5Gk//2Pqk1xQo+O
	 O0BFF6fyjBi9fEJ6y8Jsi2NhvrrZr2Yn12v2cC//vPvvE2Mcpj0dMSehXpWWy8kSpXLx3
	 ln43ExwC/wl4S9UvgFMT6GwH6MPz8M405LQxfhIeSU+Y6FREQzZ/zw6nYm2+I7CdMHSWm
	 3BGWkyGQQvFDyiuSVhBb0OgWHqY2zbXAyBHJ10k/JCE5NhdGrT0DCmpbIedUJPrUmFQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793177817;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=YR85CeqTvsoq3zd8fFPbeJKLVnFHM2ifMvvpANFQfIw=;
	b=Pf+MzQAFygCEKcuRt5FGmU4NYhhjPoPbMOTFqfXuPDu2UmivSPLNujbXFZjw2ddNzhes
	 JEDzyEptYGZ9YXJ91pMLw+TcC2Z7HtCItWiavuaAiKkkCwnXBKH22izPl9hWorEf0Dcdj
	 I9VqeqfVdkvjt5rJDqI2yg6P/QSswN6mIsppvguWtI8hWZ9rtL2VSFUK5rtEYB2rOcHtn
	 m8i/K0WjuVUO1nrzPV1239QTxkYjwtdvyFjzbd1PrACUze8r+KkYc59FKWV2C9mHcOTWW
	 S2TgdAmEwlF2fq/NKWclEqVd3epJ05fGoEN5Uq4/PoKqDrs2e0fEds1W+V7zE+H91EA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793177817;
	bh=YR85CeqTvsoq3zd8fFPbeJKLVnFHM2ifMvvpANFQfIw=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yGF6nUDiq4qwH90lRIToXJ/kgblb5ieLy4OWL3hpfmH+A0Z/TbHIikgq9bfxLVqEW
	 0lX/YyD0kofAUOTjUyW9Ocxaz0SXwRNKb6MJnTyoK0aoItplTiMRYR7zXQvAdB5NRO
	 +VEmHFWXcsY7q1Sj5jsIM4X9IDzo7616dqxlD4/DSbo2w4UzWV6lclNmLYKDUsFBIb
	 yV9l1Uoqval4tou9yBerLUSRZC0PvkqdFTedYiRBGzRZ6RnX76OZWgNkCJ52+NUqjc
	 bQezYEGp7zdSJe6BbjKCy5VcfnY2GXG1tv3MjMIp2l28bbIP0PoLzf505gqioa3kuc
	 MDWDwGyhRRXMA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5722140651;
	Wed, 28 Oct 2026 08:56:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4DA3D972
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 08:56:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 33AE580F55
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 08:56:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3dlM2TTKe0Hn for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 08:56:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9238E80CB9
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::634"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793177815;
 b=T28TxOH3U0ZI+hoR2isNz/ENX0jjMVkR2kqgze9Qwcwb8zfqOs0lBb6R1lBaxOuBbhCL
 VRSwbKnKQu4WhrigaFIBZbt5HY3tEP6mAmWD5GkLm4i33aIESQT3XG6K8+w/W08kP2XaC
 A4C3sXYacXvRJ2L9t9fefldMB7kSIX63MT4X6MTkz+uxJHss9BlgD0b75OmJzA5dDKXCZ
 /+2qQ6Fsr/wtxTqSxTKwaMetaLHJJ0f2Gddpvn8Na/FdP3s8ImjzpI20AGaW4khhwt+6Z
 TDQ6TmmMac64VhHuneRvT6bC6oZiMO80zq41QXS7Qj+dKwHOK5RkV4+hXG8LBl4T+Fg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793177815;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=YR85CeqTvsoq3zd8fFPbeJKLVnFHM2ifMvvpANFQfIw=;
 b=n1RzgTZpehBzylJLFg/cckfgOSUQLPVWkK9+dPjDHmb750r/K/KlIaqofvhCLPqKSNAh
 TaWK7IMT/CnXCT5T45F9iw+dOXZ61Ust/lfkENPq/LRJ50uTV8xQyQec55hvge4z0Mgnc
 13KaDiqEt7YaD5LFs1OrnimEFS6Fbz6+0zx8Y/DDPR4P1XhFw9D/toANZVO0znoeKHz5s
 NmSkNlUDts+OeJAw+qhgDJG3jrB8xqdMNifOj2lQu57CRLCEA1lLhal8h+jjgDt3DrTwn
 QDxGYkcREduE8Pu0yZlE1+IxRTNaIXOW7TwqB+DDlXpDJ3YAA1Bi2hbiJT+MxZlJxFA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=Fy7TLxG4; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::634"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=Fy7TLxG4
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9238E80CB9
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 08:56:54 +0000 (UTC)
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2e9ae391a05so4695605ad.1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 01:56:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793177814; cv=none;
 d=google.com; s=arc-20260327;
 b=iU26qLGwc8i60DWLQxwz6CBvVgExdGl24JJ4/G3RdCnf5969fdc8e6yKygj0oJpt3D
 aW53jUawvD6e/zR80RDgtLX/e+Dm50Jfn52XI8cpFwvm3eZGbf9EETZ2os3DNXx/VC9A
 frQ2s80XNeNew3kzjYZRTROPW2gloy7Ly+zpfUyol+L03oNgxtcvYxdBxpGRh5sKK1N/
 tZea7kV02RZphbl8cSdkIdc2aBoJQjIyJkHrhxeLAC8XFCFv+NiYJBVg+gDeyE4oHZG9
 0IzODghYc2hMApmTWFtWSesL6RRuztVu9amIbOEToOTuodvZKGdQ8Jox7WzvB5xp/kR2
 Yi6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=YR85CeqTvsoq3zd8fFPbeJKLVnFHM2ifMvvpANFQfIw=;
 fh=kJr29fJg3Nxc7WYs2Veih7CWcVKhB5GCXnfwepyAR38=;
 b=opN5yJ+MHN15+6Wi3Edw8LzcE6w3s2AUAAw09CTGrY3NtXdns6MSI8fihB8Ki0/JOU
 KcCsWpytGQ4ZwpnxAIX+OCUFCFXx+lD1T2GwGziO0Y2Y09SVBrt9LspNwoqggwAY0QpD
 cRLhn4Wgw5tyGstnXd344CT24oueeVTIU98xY9th4guRbmPglEl/cbNhPfeFTwQDOAFI
 W93qGaVnzo7l8E9cYo+nzvaVOvtOfs613Dm+HXkib9+aezlBqrFLGrJX47zBSg9VYoiy
 g2PUeOqdJfuGLJwTzb/14sWmhrCoPXFS3AWJISy5qQm7zGw+sVW50RrF2DwdVg+PBx5B
 PGXg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793177814; x=1793782614;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=YR85CeqTvsoq3zd8fFPbeJKLVnFHM2ifMvvpANFQfIw=;
 b=Fy7TLxG4jbgorW9rTKZAltEJ+Wj9M1LrX7j0bSePRCcg2v0jPVDnER3o+f8pr8CQVO
 O+tLEbpjddsdIrOkdQFLhYz9W+pYTyIzDUv2afw69nu7gBzjF0P+KFdG7UaMdoskIB2v
 G3H9hCFXnJsBjDqXqyMuLhu8Q2dvn4VgtoUjc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793177814; x=1793782614;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=YR85CeqTvsoq3zd8fFPbeJKLVnFHM2ifMvvpANFQfIw=;
 b=xsz/DPFkxT6UvPaeu2/WcBy0GY4xoZcP2qx6nC2jZi32deB48iM3ABByn4STkheyaQ
 BZvuGiOTiY470thx1DsLWd02Qbp0ny0/IvOBHVmzJFQjw53Run0njUgh1cIfbe8NOMl1
 YU09PshzKO9VbOGtXKCwhdsMpWto0y9RuuFQsS7gHRqHLFLvIXBTQkL/8ZKgoH3OKlVO
 3xhuIOmmf+NosATs8B8MNTVExgCOJ1/opO5E3kwfQKcBQHp1nlMfhwPPDCpbbL2shMj6
 OiEwnGAEAoEkhKBYUJcya7bDJTIFz+BlIZxaJ6JODuSeXWq0SGJoPvpsxbKtdT3XWLDT
 TQFw==
X-Forwarded-Encrypted: i=1;
 AKwUvByhPSTpgIngfvKuOEQQNr5cYBCXybnOgswJGVkr0l87p7/Ki725NqpyBNNN7H+QABXOSOJ14RA=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJ4elifsWZah7/FCA4Zhdo/5KBvfYFSzPVfaiUAYnIGzS2Lye3y
 GjgjV279FB77Uzn7lVIZNPaVD+LXM5n3wcjitOu8C8V15o700LCAZcOli+jO7mbvkGND2eVbnhq
 HNqxpIuBVDnGGffZhRPhYJ2FsgEaM7SMRmcvAKINa
X-Gm-Gg: AYBFou3c4f8TKRF5dAlIFX8Vc9O1AkQXchBdTMPn9seGqRH8FcYDv8NxyFBKzrRMpvV
 0h8TgIhNY7vyX0h9pFYCtIY/sDCw5GW17OcfC0FpV/64BNY+76JRE2Brin6sBipq0hboRNFyAri
 r3Fr3wPLDgwsGDSzANXD9mhlBAuz3KqirbuwnqDGVugVlwvDNjF/yyXnIb2UhcDkLOl3nXVMmNV
 z/AkT6jOxvMLTRAMhuzASau1uYiN8ft+vIlN9XkQmEevWVmxOuoBGB49vnTZLLf+8HJItuZRX3P
 p9/h6+PkpjKBp7BP14PJ2YDdYrXtqjKJ1IEW3T6XFxG2Jd3Pu0ZtEv6GjKi0zEqMai32uRUhWHc
 N2FCEmtr5EfulLV+QoXy9lWtFc2HpfTa3q60=
X-Received: by 2002:a17:903:b0d:b0:2e9:4ecb:24a5 with SMTP id
 d9443c01a7336-2eb0734f4f0mr4210275ad.2.1793177813621; Wed, 28 Oct 2026
 01:56:53 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 28 Oct 2026 08:56:45 +0000
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 28 Oct 2026 00:29:44 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <3a36c968-146d-4471-84c0-6673337aa4a2@gmail.com>
References: <01ba3f81-06b7-428b-9224-bd887c35e1c3@gmail.com>
 <3a36c968-146d-4471-84c0-6673337aa4a2@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 28 Oct 2026 08:56:45 +0000
X-Gm-Features: AclHuK9OOUCzMqeHuW9ItgJWDonJL8MLxKA2vGlUEjwi84cIZ-54XmA1e6WAs0g
Message-ID: <CAFLszTgTU-z78atCqGeUi39cyKsYtN3rgxW3w4q=rJ12JbGURw@mail.gmail.com>
Subject: Re: [PATCH v2 08/12] block: Refuse a device with an unsupported block
 size
To: anabobillo3@gmail.com
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org, 
 Simon Glass <sjg@chromium.org>, Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Bin Meng <bmeng.cn@gmail.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Alexey Charkov <alchark@flipper.net>,
 Javier Martinez Canillas <javierm@redhat.com>
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-28T05:50:48, Ana Bobillo <anabobillo3@gmail.com> wrote:
> block: Refuse a device with an unsupported block size
>
> blk_post_probe() scans a block device for partitions with the block size
> its driver set from what the device reports, and nothing checks it in
> between. The USB storage, SCSI, IDE, NVMe and virtio block drivers and the
> host command now check it where they read it, but other drivers do not,
> such as the Xen PV block driver, and the partition and filesystem code
> relies on it, as the patch adding blk_valid_blksz() describes.
>
> Refuse to probe a block device whose block size blk_valid_blksz()
> rejects, or whose log2blksz does not match its blksz, before its
> partitions are scanned. This covers every block driver in one place
> when its device is probed.
>
> The check does not depend on PARTITIONS, since the filesystem code and
> raw reads rely on the block size too. It is left out of SPL and TPL,
> though: there it adds some 180 bytes, which takes the SPL of imx28_btt3
> and popmetal-rk3288 over their size limits, and its message needs a
> putc() that the SPL of evb-rk3036 does not have. In SPL the USB storage,
> SCSI, IDE, NVMe and virtio block drivers still check the block size
> where they read it.
>
> A device with neither a size nor a block size, which is how the SCSI
> code leaves a removable drive without a medium, is still probed, but
> outside SPL and TPL its partitions are no longer scanned: part_test_dos()
> could otherwise parse 512 bytes of a zero-sized buffer.
>
> Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
>
>  drivers/block/blk-uclass.c | 15 +++++++++++++++
>  test/dm/blk.c              | 41 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 56 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
