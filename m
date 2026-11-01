Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189F3606A329
	for <u-boot@archiver.kernel.org>; Sun,  1 Nov 2026 09:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=kBKRIBwa;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=VkS6RaAu
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D29A5405F1;
	Sun,  1 Nov 2026 09:32:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id g0-xciK4jc3f; Sun,  1 Nov 2026 09:32:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A73BD405D6
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793525532;
	b=TCmMKVwyvS5obbnrh05E50i3XHdxMtuIvAFN3y7JJ0dsLOcg6UZ/NQXEXapupSfnOFeI
	 3UEEgcpX420qeT5uv0fvcvLjLQ1GWeUbKaEJD4vM1hx2bkdFoZec2SUVwzEfUtKJHxlyH
	 KuUn5q5WyjAdLe2zj8zvxc+dLcqSbLIW9M1snY5kIMrMIt3suQn1dDh6vdNaBNfO/4VkO
	 FbgmJbogTCOKRuuawEmPHbdc6fk0BkobEdrbizKEFmf0GjUnMOlN4LlikYC+txdUPVITy
	 +sXCEXDICPTMNr9UCRTLEvjiyODCbalwV0m/szuwLi+/rMk3b9wseeRrK28yHWuz5Og==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793525532;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=4/IB1aoTMAhm+ZReYZ0/r7iv7M2FjbkFotcNlHQ8hfg=;
	b=O1wIx1wjyHvEqwWmM4zM5oYlLwPAose8Tq0+KfQmLmiOAziUVWF3p5GuZPi1lu7wnnCT
	 Ooj8Xv63jFSVUwUgDzOW5UyY7l7w84XITd1AkYZwZ/JFg1qeglH8JB26hraPQds9YvL8/
	 WxGgj1TKXuIxuvXAe5oo3y/dlHeEqQRidPxYedYF7dIUj/m0Xgs38feo7LcIv1z4SkA8T
	 M8ly/AkE81T/quyCfbmyUz34jvLYlkH7QsV07YPTFZdmwucKryxYfmlU9KAo9furK2tO1
	 uqWMT24ZeAd2lj06FTU+NstRFynWuyv+y7Ms/M4FU537k5etJfA921RDNfHeqBFuidg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793525532;
	bh=4/IB1aoTMAhm+ZReYZ0/r7iv7M2FjbkFotcNlHQ8hfg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kBKRIBwar50dVnwiL0EKRmbTU7VSRx3c19YsBMW587583Qei6gUzB7tywuwVxJ+9v
	 0bu518AZcrTQcOHC278X68VzuYkFBkneLGO9IPI35WD6sEqcb0byBFn9O7vSVx6iiV
	 RYaaPXRVUITAaJxXOGw2RF12RdxBmy3SJtraRx4bS+lLfHuVoJ+GLYrUHkjDK4ze5Q
	 KjaBg/Uu53TpICmHZd4Sy0Ulnmw9GSbOAOWYfLmNiEr0TGy/ZXpnIXYR4kOdBrqXsH
	 iMHQ7gCEPkvBp4ySKRHcZJcGQfYwWfKGNWWaPOQ0f4Fu7V4zdQS8nUZD6tKOOtiDzb
	 CCLc5F7KoCp3g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A73BD405D6;
	Sun,  1 Nov 2026 09:32:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 79F6E2AC
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 09:32:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6C1C860602
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 09:32:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GcS_TL9rsztM for <u-boot@lists.u-boot-project.org>;
 Sun,  1 Nov 2026 09:32:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 41025605E4
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::112d"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793525530;
 b=nEjM632rbMdAssi6zfu1Vs2Q1gFNIUI0gM601LBVXnrmYhofSdCqeNrU7C4cSTnE9JOq
 siSXNTrjhfhe4fWOsGpjnb8udx1lWryB157gZbf/Zq8bB9B/tzqMdxnB5tHci7hymjSU9
 EKDWczMiADO/plu4TU+ih93CifSDkavyohtxdbwgM/0JlEIK50bmPQnyoA/pI+z5i56vM
 W2GyrxNrLBTgLiqXcd0vjOx8AcqLegd+A/5J+ifmeGvm0Mfbhajfw2ESK9f+Kfc5WqCDb
 maC24kQvnqkaYVLxF5sZxkbOHUN30xlbkblHkl3Q2WzNZhfQ0VoKGCyhD9a0nS7pXFQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793525530;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=4/IB1aoTMAhm+ZReYZ0/r7iv7M2FjbkFotcNlHQ8hfg=;
 b=dfNnhZ1esJcf79XUmJoCwyx6bTRJM1f8qGWQjGhF6M2qA89q+ip/fYLB2BEXqBk0TQUu
 LbbqCZflepOTJ23ohG28MiF4XDGZStD/ykvvHzAGBjtfZcAk30oPATXWO+j6kQlYxSLyJ
 XJOFR6Ehm/f+ltrs7QSEFa7zepTuvukGOZYQ4XHF5RbeW5HYmQ5nHHjLlcn23Q6iFQyFA
 eLfoGcgM+0SUd2EqtCgVz6zuFUqvN3dluP5K1BsjGQEvkq8qsVzbiQG82O8LZrTTE39lu
 JQ956SyzqAg//5qnE+PpF3JPzIScIXvw8xdGwz1DQ0TArwtw/eP+msoGhaIvbUrGkwg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=VkS6RaAu; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::112d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::112d; helo=mail-yw1-x112d.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=VkS6RaAu
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 41025605E4
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 09:32:09 +0000 (UTC)
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-8b0cf2c0785so16129597b3.3
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 01:32:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793525529; cv=none;
 d=google.com; s=arc-20260327;
 b=GpO708r8upXffO9fi7QnIeDLPRQiwSrgEHsPuMWRAaU4eV/r+mwqtXJG6NWqHrtNMb
 PFRkVQ3a9sho6doyZzhwN6/qe5FnNFzLkiH4e1QbbPaDY3wTYyoazmnHaDgrtZN0b6YU
 4gpm5SDCIyE2PJPfOBJZXNwv+Dnlhcub5IseESPDtIfoVrNDw+Nj9x0hNB0TDaD8hT2q
 zbq0to1vPSFPEoJkD1+NQwpaUsAthzgG+FVzulDt69d5huMr6TjpjWX7Bg9JB1MucsWA
 vh33GTDYM/QeAcxIDQhoNDtRzVFAMHk5r7p8wrPZK4G2cZSPJ2VIGH0N6xdBkcQphml/
 MU6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=4/IB1aoTMAhm+ZReYZ0/r7iv7M2FjbkFotcNlHQ8hfg=;
 fh=YekaV/WTDglLyLvCLIwIyJp5mGS7l1TUztK3qclub3o=;
 b=k3NwsNlOP3b0oN/2+Fy8rVa3TeTj4G9rMNtjdvvuV+osjLe6e5GmDH25wAP36Pv9ev
 ttAC8vYMb0JXlwYIzq52ag9WptUAUSFKpLvibrvlTraQn+LzQal9P2M9ThzuHYtS5D2b
 0WfxllRDx0vGqSK5yYRSFUV54V99Rw+VS0xdOHPBJLHAYxtp1mNKQZiLHYwrQgUi6zoO
 6/nSd+ycvQwRFsGa+u9NLDLur9HqSXgg4yYdw8IBm4oxN4DQHrgjB+jw2Xxxc3xgVh1K
 MI2YU6fC+fWV7Z0GXmeoQHWyXDgd+Lx/oqyGLJwsZVfnOeP+D2YybzLkOdILSJDgAw84
 EApg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793525528; x=1794130328;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=4/IB1aoTMAhm+ZReYZ0/r7iv7M2FjbkFotcNlHQ8hfg=;
 b=VkS6RaAu0NJTQ3+r0M6/9z3fA6Q8XalFMn9boKzTMWwhijE/uR/QaRHgkYc78FG1qS
 yscbvrmS3GOkFrtP24BmWE7VfdYX7/BIs6RJjezMbS15hJBjOwd0ATKyhM4UG5L4scem
 7zFSp4YVumcpvHKImxN/mCYsk13tEVISzVX11HTSufaEBXTDAtaAqgmtAIxI3N1+JjQv
 cpmMnfWctSSQ3Whiq2FP/LNxN+SwPQgA95TfrTx22Apn1a5lyz420WrmAJui20kvWAw2
 uGc2Mm/9jkPWgpz+H+HBgZDLHPiase+uzeRbm2PdkjqXdm/Qi6xiwTAJLCpQ6Bw3vYVg
 Ka4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793525529; x=1794130329;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=4/IB1aoTMAhm+ZReYZ0/r7iv7M2FjbkFotcNlHQ8hfg=;
 b=F2V2Kz1ybGSO6XTqZOT4ddReWxdFxnDAUujvvlroS44P1Icr4z8n4Dz+GMvJGuyLoq
 su6PnLI6+9sNfb0eSeq1nOF3GMK9SVEkVV3Hl9lQm9lcZ7YEWXkykwBlBSEFAC6GHPS1
 UB6AMCxAwH5cPYezsV1la5k0tlUMt/yS0tkGSCjYHsCylqq+7rT37E6phoWzGzvEwFvv
 whvp42LO+mZWSbNaixPbdNCfyKyTJBUkveq7l4vJRZTxIzrz4+kOfF1Ceao95wOl454y
 xwqxnls6pJ/mS2bLbFLaHfutYEBesRFDuN2bx9FYVwXMcRxwyj3Mw8+9XSAiUNwV4J+h
 MiBg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzikavDT//ntqKYTaS8Jx3RANgdEpUznJuNPKM4/If5NosxIPU2vFgkhRg4e56aTizt3vCSjME=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/diNnPCg0tewIIWgg0pSrkNM9lI0t+2E38LAXcKtMUtCiNbuv3
 Yb4vuOOgoIrkCY1WWizUVSmzihU3n+q052yM5Sshz7zGi8eYG9riemDp7nWKZW0FUKG3PNDI4Xb
 MWa1FC4vE81SYdR54BXh+6lE5kM333/6OSd5fz3OVvg==
X-Gm-Gg: AYBFou2Jou4uIvhX4IeclOHZ93f9wncnMGLKGo30CPmZkMJdZmvlmYGRXx3A42Hn75i
 oPbWtYnlg0Dk3PJy3O7IWqSJLo6+nHvk9hC+IePGIvVoJS+zR6rwZeObXdq1NOP+CCC13F9tJVH
 xubVqlmaufpzfzvqEeEkIhFzwog+Kn28arF3yUsvY47Qiem8tli7AEiJGImjDVvl6lwb9qOo9Ip
 QD1MGXb5UESkvsN/v/jtFLBUXGdG/8Z0zxEJnTQLITgUOpK4znluKNJ7abrdQtfxFezOoDNnwXr
 iCViy9TMbAnlgDP3mvkbtZ1p3P/amdZ9senzh9i7gvI/f1s7zdlOzWdmtky0ZJ9UO/wQFc/i7ue
 Cn7NX/t3h1IwslawdLw40VTmkJdYjVA3ZN6+fUUaqTnStychS6i8BYB2+k71Rw2S22kxDz8dwMZ
 pKALHpAKKvW9nw8WeEQfzV8wKCgGfVEfsPzL0HKPqlgvMJiCLP5CpODuXS1CdWtjvUXIiC/d2fE
 gcvwUAQUFiaTCVTTcId14/WzYu7KEMa2jubMLq4XqpEQ68PMidSOVGNA9/Xdjp4HrfpTXGJSEsF
 ewjbCgYqrmwAnYbO6c9pFIE1UPItVJrNKaa/b5h2Z1XxRRa9ORRet4HLyuz8nKNp0Q8YWLg6jfr
 wY26fh03KSe9xEGmR6BoV/32P+b9dhVUYyX7xZfU2Y+ZWv1sXW7wXdHEtSFeRY3j7z8h9AqFMuN
 VrVXU6KRrsJTTVESmj+jzLe9dz0pfYpZjBn7Q=
X-Received: by 2002:a05:690c:f05:b0:89a:63da:fa8b with SMTP id
 00721157ae682-8b2b675930emr38416497b3.70.1793525528491; Sun, 01 Nov 2026
 01:32:08 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261024174056.3529978-1-aswin.murugan@oss.qualcomm.com>
In-Reply-To: <20261024174056.3529978-1-aswin.murugan@oss.qualcomm.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sun, 1 Nov 2026 11:31:32 +0200
X-Gm-Features: AclHuK8erxsVsiYdwJY_9rrUlEuTAjsO_cuEc0Wz1_aNvo4TF6IXazPBv5A_FRI
Message-ID: <CAC_iWjJO7Xi3RrSnQw4sALirSfjS85PV6wyfyrupN5npC9YY4g@mail.gmail.com>
Subject: Re: [PATCH v2] armv8: mmu: sync emergency page table attribute updates
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Cc: trini@konsulko.com, casey.connolly@linaro.org, 
 u-boot@lists.u-boot-project.org
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, 24 Oct 2026 at 20:41, Aswin Murugan
<aswin.murugan@oss.qualcomm.com> wrote:
>
> mmu_change_region_attr_nobreak() updates only the primary page
> table, leaving the emergency page table with stale attributes.
> The emergency table is used temporarily while the primary page
> table is being updated.
>
> As a result, speculative accesses can reach regions that were
> intended to be blocked in the primary table, leading to XPU
> violations.
>
> Update both primary and emergency page tables when modifying
> region attributes to keep mappings consistent regardless of the
> active translation table.
>
> Since splits can now happen in both the primary and emergency
> tables, double the number of page tables get_page_table_size()
> reserves for runtime splits.
>
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>


> Changes in v2:
> - Added a `root` parameter directly to `find_pte()`, `set_one_region()`,
>   `set_regions()` instead of renaming them and adding wrapper functions.
>
> - Doubled the page table reserve in `get_page_table_size()` to account
>   for splits now happening in both primary and emergency tables.
>
> Link to v1: https://lore.kernel.org/u-boot/20260926092635.2712021-1-aswin.murugan@oss.qualcomm.com/#t
> ---
>  arch/arm/cpu/armv8/cache_v8.c | 28 +++++++++++++++++-----------
>  1 file changed, 17 insertions(+), 11 deletions(-)
>
> diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
> index 135bb62ea72..f22cf3f67f2 100644
> --- a/arch/arm/cpu/armv8/cache_v8.c
> +++ b/arch/arm/cpu/armv8/cache_v8.c
> @@ -173,7 +173,7 @@ static int level2shift(int level)
>         return (12 + 9 * (3 - level));
>  }
>
> -static u64 *find_pte(u64 addr, int level)
> +static u64 *find_pte(u64 *root, u64 addr, int level)
>  {
>         int start_level = 0;
>         u64 *pte;
> @@ -191,7 +191,7 @@ static u64 *find_pte(u64 addr, int level)
>                 return NULL;
>
>         /* Walk through all page table levels to find our PTE */
> -       pte = (u64*)gd->arch.tlb_addr;
> +       pte = root;
>         for (i = start_level; i < 4; i++) {
>                 idx = (addr >> level2shift(i)) & 0x1FF;
>                 pte += idx;
> @@ -816,9 +816,10 @@ __weak u64 get_page_table_size(void)
>
>         /*
>          * We may need to split page tables later on if dcache settings change,
> -        * so reserve up to 4 (random pick) page tables for that.
> +        * so reserve up to 4 (random pick) page tables for that. Splits can
> +        * now happen in both the primary and emergency tables, so double it.
>          */
> -       size += one_pt * 4;
> +       size += one_pt * 4 * 2;
>
>         return size;
>  }
> @@ -1003,11 +1004,11 @@ static bool is_aligned(u64 addr, u64 size, u64 align)
>  }
>
>  /* Use flag to indicate if attrs has more than d-cache attributes */
> -static u64 set_one_region(u64 start, u64 size, u64 attrs, bool flag, int level)
> +static u64 set_one_region(u64 *root, u64 start, u64 size, u64 attrs, bool flag, int level)
>  {
>         int levelshift = level2shift(level);
>         u64 levelsize = 1ULL << levelshift;
> -       u64 *pte = find_pte(start, level);
> +       u64 *pte = find_pte(root, start, level);
>
>         /* Can we can just modify the current level block/page? */
>         if (is_aligned(start, size, levelsize)) {
> @@ -1044,7 +1045,7 @@ static u64 set_one_region(u64 start, u64 size, u64 attrs, bool flag, int level)
>         return 0;
>  }
>
> -static void set_regions(u64 start, u64 size, u64 attrs, bool flag)
> +static void set_regions(u64 *root, u64 start, u64 size, u64 attrs, bool flag)
>  {
>         int level;
>         u64 r;
> @@ -1055,7 +1056,7 @@ static void set_regions(u64 start, u64 size, u64 attrs, bool flag)
>          */
>         while (size > 0) {
>                 for (level = 1; level < 4; level++) {
> -                       r = set_one_region(start, size, attrs, flag, level);
> +                       r = set_one_region(root, start, size, attrs, flag, level);
>                         if (r) {
>                                 /* PTE successfully replaced */
>                                 size -= r;
> @@ -1085,7 +1086,7 @@ void mmu_set_region_dcache_behaviour(phys_addr_t start, size_t size,
>          */
>         __asm_switch_ttbr(gd->arch.tlb_emerg);
>
> -       set_regions(start, size, attrs, false);
> +       set_regions((u64 *)gd->arch.tlb_addr, start, size, attrs, false);
>
>         /* We're done modifying page tables, switch back to our primary ones */
>         __asm_switch_ttbr(gd->arch.tlb_addr);
> @@ -1099,7 +1100,12 @@ void mmu_set_region_dcache_behaviour(phys_addr_t start, size_t size,
>
>  void mmu_change_region_attr_nobreak(phys_addr_t addr, size_t size, u64 attrs)
>  {
> -       set_regions(addr, size, attrs, true);
> +       set_regions((u64 *)gd->arch.tlb_addr, addr, size, attrs, true);
> +
> +       /* Keep the emergency table in sync with the primary one */
> +       if (gd->arch.tlb_emerg)
> +               set_regions((u64 *)gd->arch.tlb_emerg, addr, size, attrs, true);
> +
>         flush_dcache_range(gd->arch.tlb_addr,
>                            gd->arch.tlb_addr + gd->arch.tlb_size);
>         __asm_invalidate_tlb_all();
> @@ -1112,7 +1118,7 @@ void mmu_change_region_attr_nobreak(phys_addr_t addr, size_t size, u64 attrs)
>   */
>  void mmu_change_region_attr(phys_addr_t addr, size_t size, u64 attrs)
>  {
> -       set_regions(addr, size, PTE_TYPE_FAULT, true);
> +       set_regions((u64 *)gd->arch.tlb_addr, addr, size, PTE_TYPE_FAULT, true);
>
>         flush_dcache_range(gd->arch.tlb_addr,
>                            gd->arch.tlb_addr + gd->arch.tlb_size);
> --
> 2.34.1
>
