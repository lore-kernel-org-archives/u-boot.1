Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67076606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 08:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=UmWArVca;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=D9INkR8U
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 40B4960ABD;
	Sat, 31 Oct 2026 08:55:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id K2S68Ju8CL7C; Sat, 31 Oct 2026 08:55:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1F9FF607A0
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793436914;
	b=pBQFg5zUWxnkmuFtCIdCtDNyPh7cdxmLvAjOU3PnEd7YObxnCWSAqbLrgTlqisi5swZZ
	 aXi70RF8U7pqyzBdwDiwTX6C7vyToF8PHte+MeHBBqJeewhmaTzxnJ45jzAagymMt7E6r
	 RNF/+lpUYUjMlZAwy0s+KvDfGnfETHmJtR5Z3O2WZrzkF0yBA73pc0xYWlsZA63apQdi/
	 D913N2zMSzmi+PYbMZOtSaHJLqGdNPc4pFpxvxGSbjhvQg/F4VFK7lHn8zfD4AAABdinr
	 YtO9A5rOBjgct4ZiU2GmeLqzKOlGxak/uGvhyB6cLSeSBye3S+gdx5lZ1DNwQDHCabg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793436914;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=gdCQc9fLTo5rpnv44SP6lJN77H9K94aJvrM0SKAeDmg=;
	b=aQViz0hxXeZK8Ey4irRfj3Hxqo/zWwf5O9LWbW/lWxWu/emCE59kl9toyWP6prmfLSR/
	 l1zolvJA4TewzIhM9PfM7XJYxl73NrZIa7jhN1eH59btQTbdD1J8Sn2bD9vhnAKhO11wf
	 JrYNSO5jIIMcKpM0FTb3B0xMognMCdB2oPLDk5NO3IPpgD+jKq6HSxgiMWgSnmhMyoQxo
	 XqTZ/y0lEV+KLeNCPYCzJi/BTJs9fPrdnbic1WmGE4W1LOnBpTE1S5u5TskTBIgPOFEkU
	 EtqRbrrX3aS4uPCdY41LocT8pMdNGzrZvy5+rV4uPzTJC4KGasPYziI2P5bQLjtX6oA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=D9INkR8U;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793436914;
	bh=gdCQc9fLTo5rpnv44SP6lJN77H9K94aJvrM0SKAeDmg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UmWArVcaT6fabFUE2tp+FX3HroXW04EmkMP4u/MLbHLkB36BQjgr7yuFH42cr27Yo
	 lGMeODZ+ADHNjTmguheuQdPlWiF5oecXgQMfRbMBxHaXMKHKg+J7xH0gfgRAslco+t
	 xK8Z6uWW9bhvXLKVUo2srFtxmLLqYFVsGjfIYMrG1yxsuGMru+jR+1vstDj+ihrU/O
	 YphEfzsC5K8xo61i6IoxbOmskixg6+GsghXZiWuXFnJxW7sdbbPjY7BcRz1IU2dh2x
	 +2WSgWbReTtSn1rPVTa1umlq0e3aPw4lO8lUuLxAq/suRbjOpP9Rw3ff6SbkumyIad
	 SZhkm8xwIHuMA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1F9FF607A0;
	Sat, 31 Oct 2026 08:55:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7EF7D380
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 08:55:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6FE23607A0
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 08:55:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8y1K3Vjxo_vA for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 08:55:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 83CFE605C7
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::529"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793436911;
 b=DzuX3ol/hYfKL3tAMKki2OzrhpqhXp5zg5bHXI/knwlVsU5ewZSjUj9JaxD+0meGxMwW
 f/UtkDeWKwIhqAFKjEUTi0XFbFm4B0xKUDi2+8DCNKFy/iXn7TSV6D5s92O/jq4YsTfoc
 3Lgbm3C7JjniTpSSR8ztLsGJdzMxkSbCUx1zDoIpe4fJH6xA09yUQq4kL8wtQMldFXOzv
 T4oLt4/Uz97991DxzH9Zvix+2aST6HgHeSnlKmmneSpwRE2tpgISzP3d8LCvJE4QEzi4v
 y5F5hBGIR4/O9NliXZsQQS9VPicE9VCxC8DMZMynzdlkAGXrE+pyNg8mCmg8ynkuriQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793436911;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=gdCQc9fLTo5rpnv44SP6lJN77H9K94aJvrM0SKAeDmg=;
 b=q/bO1lw8qvW73qWNutcMPs8NxDL2hYk+z9wOOGgrkND43Oo5km2FChoxlqGh2WL1U+HX
 4e457oG4+aynwNfjmQrDuwxzCrnWiJ/keAxqgA0gYl/VpCdXOfPuKD4XGrzPUL78CuLfj
 SqogJRHrEE4/ajziBAx+vHcCoG6+0KQevMELjNnM93l/UymAr9UQ76ZR6+B3V1QIiYM2L
 1L4UY5ky5omXgGENM2ORAi4iKByEYwKPV6nB/zeGGJ/uH/iq/1Oykxw/8vGfydSm6MgEy
 wXI//fOcLiUsqrAN9+pYczclW2UjX0qkmKcDUFBVh1xSv3bGDrjHlM4uHEBHKaF0Eig==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=D9INkR8U; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::529"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::529; helo=mail-pg1-x529.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=D9INkR8U
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 83CFE605C7
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 08:55:10 +0000 (UTC)
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-cc7e79c1eaaso574762a12.2
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 01:55:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793436910; cv=none;
 d=google.com; s=arc-20260327;
 b=GdcrgVX8F76JJiyERzKUCAdju4CaOdqv2HPD8UpfbxSQtj7yL/3Id5czCBnylnKLbI
 GGTjgsJXUoAQmE+MadteYVHmfdsKyHeOkh0bKxEXf97Clmv6V+eh3VzloLAyQwZ6Qr1v
 m5Vyd2Nf7QGVTykpX2kg9ak2IXT0tGfqQ9s7Pala/xxkegh88ptSPB8rbMiADco9YjUI
 2Y2shxWiLyehnQrv06cSAw1UeIxDkPf4c0/y04jW/27q35EgmXf0R668jSu17tKHCRpf
 oeHdoHT6YcOHdxDKIS8fJ8fzEP70MSMj3+NFA+iz13u7DUMqQjzSG3IrI/AqIW1RjTN5
 iDnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=gdCQc9fLTo5rpnv44SP6lJN77H9K94aJvrM0SKAeDmg=;
 fh=jhNF5vviHcOci4XYv1cB7uNlFTrIF4JcwAizolJ/B4c=;
 b=B3AmZwGrpaWF1s7HKGwNw47DDLCQ9u1sn1lkqHMcA2hD3FqQbOnQ7d/A9I8Z9HVpC9
 y0JB38PtoNgD6VO4xM8024wcL1YJEjtoM08NQa2aIhoYDXe5NK8eQwjXTLNOOHs+mpIL
 vI0ivNQs3l7SZuYeQi0w6EKN7gNf7rSV+PNrPJ9GQ6ZB0dVlgfoeKf8ihYv1wfeztKfT
 mCJKietrIWmY07G4yxWjYMrkdFDpV1DasWadtSmt7qw6U+rREP5xhOhm2cg+msgrbS59
 zA0wXtNl6B44lXO9k1GRY9gABnefI/F3GugjO+XzNC6CqVbAkhNOdpbwRY3rdtvTt/Qq
 WaiQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793436910; x=1794041710;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=gdCQc9fLTo5rpnv44SP6lJN77H9K94aJvrM0SKAeDmg=;
 b=D9INkR8UFoxuHLAMS4mcS7V6RZAsEKeKrGKHXgZPy9b1H8yJxI0Ju8i4C8Sz/Iwv+t
 BZpKVArvsyOcGoRNucjhvdeGYRY+N9EbY2kdcQFAkGl7XLBr22vazeqFY6cbJloIwiJ1
 T/BFvqV/AM7uLXo00pBYZL3vVLzosyoZot7EU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793436910; x=1794041710;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=gdCQc9fLTo5rpnv44SP6lJN77H9K94aJvrM0SKAeDmg=;
 b=ZpL2rOZoViEkgQ/54mxK4UYqqgvQRy3s0OuQjEC0tfsyioKHwf9RojtIejboZnamqD
 DVKdtxAse1+dW/nQwipV9ODByo1FgSr+FvlYFdJ8OLjWnZg1/bE8GJYuWHJ4FVN65sSs
 ICGGSXlwOTJq1B9H666e2MzGkWfC74nKqnGZFEtNrwfjVFk/lOQAbOS6KvTlJ6/ymUFj
 OQQG9rNZj1PvBJdYCJkSdT5CAReUSdljh/+X7pNTyl7Ppb/yubomNRdoiIYmktqvnQFq
 9toX4/ZDmqbAt27gYyXamydjSFQzUEWN6Y06Vo/UXe3b83Ha5/CnsmT/cbDG/1mNLZTZ
 8okQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwsyU2zWgzvMtIF5BmDXtI24oSSpSb66MrhGnUn6O2PjW2FJocFs+1/G0xYrs/Ldl5wCLyDuk4=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKzTSAji0FZSxzMOkmXeZHjblSFxQs5pIesPjokg4ETH3JBdsid
 SieHiulw38KYrNjQoNJpAFr99LGJnk3Q8G15l0D2rqsqHt7PlawyeJB+0MvySiokuM0+bicC59L
 uvMXW8EhXcqfDr16c3FLGdHf3bQMDYAlrH0z2OrtN
X-Gm-Gg: AYBFou2ezXweINHYRAvmWnA5oXrNWshoSvxGmSfKWQwGXNYlCtSTqlsyoUSXIB2KaVo
 hRjyCNsEjfBwLiVAMKkDBgxRDrq+Mpfjvl4q7AL+ymcIgbmEQGrab0ij65BtqilqmBVZwqUWLYk
 qq1450toO/ZZIUfXPDQ97eNOHg+R/dJIpJCOymtbxMZ0v5MgNFrEjXXcdjui/xkN33HVQ2G9zxR
 3RZbqH7Q95W1b0zXQfgvNOk/wfZ7g+f+a6EazXztoQopUngS7ywXRLF6eiyYSpwHIMG8oui1S6/
 rQmRxLcAPsc1VjweuFsjzLEFa6X5OSFAkDE241WSL5XlCVAYvox1u5+wx719YUNmOqglQzIbiaI
 Cx+gm04bcHzWTIoz8v7H9f1n+2tdGVGjgdIqLxYwsAghUWZSnf3cRVxrfNUj2jLAFDjyOiUA=
X-Received: by 2002:a17:90b:4f8a:b0:3a4:ca46:840f with SMTP id
 98e67ed59e1d1-3ae896f8655mr3704295a91.8.1793436910379; Sat, 31 Oct 2026
 01:55:10 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260923114940.349985-1-ludwig.nussel@siemens.com>
 <CAFLszTiM+-BsYPjaw7aD7xfzU+3kK-BO9mkYKrtXpjPOv4SjcA@mail.gmail.com>
 <11fb0589-8ef2-4870-8490-077389ce9e53@siemens.com>
 <20261012144457.GB3722450@bill-the-cat>
 <44849c78-b187-4a20-bf2c-0eebaf8a2e9b@siemens.com>
 <20261013150127.GA4042005@bill-the-cat>
 <CAFLszThDcdt14Chi=UeO0i-gpzUvXMQR1Dd8c1ZVVk6Xgtvidg@mail.gmail.com>
 <20261019181943.GD720525@bill-the-cat>
In-Reply-To: <20261019181943.GD720525@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 31 Oct 2026 08:54:54 +0000
X-Gm-Features: AclHuK8vWY2dojj5kzNCQKyY4LwTGCjzVJ40ucPLsm8C1-j-M_YfYTsI9MGBCxU
Message-ID: <CAFLszTgb2oQ0ffsZqcsTtD78ObQRJDFvC4awtAGozAMWrdMKiA@mail.gmail.com>
Subject: Re: [PATCH v10 0/7] Improve FIT signature handling
To: Tom Rini <trini@konsulko.com>
Cc: Ludwig Nussel <ludwig.nussel@siemens.com>, u-boot@lists.u-boot-project.org,
 Alexey Charkov <alchark@flipper.net>, Anton Ivanov <anton@binarly.io>, 
 Aristo Chen <aristo.chen@canonical.com>, Daniel Golle <daniel@makrotopia.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 James Hilliard <james.hilliard1@gmail.com>, Johan Jonker <jbx6244@gmail.com>, 
 Mehmet Fide <mehmet.fide@screeningeagle.com>,
 Raymond Mao <raymondmaoca@gmail.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On Mon, 19 Oct 2026 at 19:19, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Oct 19, 2026 at 08:57:41AM -0400, Simon Glass wrote:
> > Hi Tom,
> >
> > Tom Rini <trini@konsulko.com> wrote:
> >
> > > But then we would need to provide the whole device tree, yes? I think
> > > this ends up being a tricky case because we're on QEMU for this. We're
> > > just checking the signatures on later loaded FIT images. Maybe the
> > > series that adds SPL to QEMU could be helpful here, since we do have a
> > > normal path there for applying an overlay to a device tree, I would
> > > swear...
> >
> > Agreed, a whole DT is the wrong direction here: U-Boot cannot know
> > QEMU's runtime shape (memory, CPUs, devices from -device) so it must
> > keep using QEMU's DT at runtime.
> >
> > The merge code in patch 1 is already doing the right thing in
> > principle: take a small built-in DT that only carries the signature
> > nodes and merge it into QEMU's live DT. The remaining gap is just that
> > OF_OMIT_DTB=y means no built-in DT ever reaches the binary, so the
> > merge is a no-op by default.
> >
> > So I think the fix is to arrange for a tiny signature-only DT (e.g.
> > generated by binman from the keys, like the normal vboot flow) to be
> > embedded when FIT_SIGNATURE is on, and leave OF_HAS_PRIOR_STAGE alone.
> > An overlay fragment would work equally well and is probably cleaner,
> > since the intent really is 'apply these extra nodes on top of what the
> > prior stage gave us'. A test under test/py/tests covering the merge,
> > perhaps using sandbox or the SPL-on-QEMU path, would catch future
> > regressions where the merge silently early-exits again.
>
> So as I kinda thought, we're in a funny spot here, because it's QEMU.
> And so yes, going the overlay fragment path sounds like the right way
> forward because that also should match what real hardware would look
> like (we're given the tree by some prior stage and need to augment it).
> We might need a little re-tweaking of the Kconfig logic (some new flag
> to say we need to build overlays, and not fall back to "and now we try
> and build a dtb for the board") is probably required.
>
> > I can't help mention (again) that this would all be a lot simpler with:
> >
> > https://patchew.org/QEMU/20250405191352.2597585-1-sjg@chromium.org/
> >
> > ...if we were able to explain how U-Boot's use of the devicetree
> > includes configuration information.
>https://patchew.org/QEMU/20210926183410.256484-1-sjg@chromium.org/
> And I can't help mention (again) how unhelpful it is to bring up ideas
> that were rejected for good reason.

This prompted me to take another look at the thread from 5 years ago
[1] - it's been a long time! The objection in the end was basically
this:

'My take is that this is u-boot doing weird custom things with the DTB
that aren't "describe the hardware". You should be able to boot u-boot
by putting those custom DTB extra things in a separate blob and having
u-boot combine that with the actual DTB when it starts.'

So this series is responding to that. I have heard a similar opinion
from a few others too, but that doesn't mean it is correct, or even
then, that projects should not try to accomodate each other's
differences. At bottom it comes back to the 'just describe the
hardware and refuse everything else' thing which comes up from time to
time, but that is not how U-Boot works. For good reason!

Perhaps more bindings in dt-schema would help? I see that bootph is
pretty common in Linux now. Would adding verified boot's public-key
schema to dt-schema would make sense?

One point raised in that thread was that allowing users to modify the
FDT using the QEMU cmdline is a recipe for breakages and user
confusion. That seems like a reasonable concern to me, although of
course in practice it isn't any different from having U-Boot do the
merge.

Regards,
Simon

[1] https://patchew.org/QEMU/20210926183410.256484-1-sjg@chromium.org/
