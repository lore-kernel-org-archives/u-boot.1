Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF77606A31A
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 07:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ErMB/uMZ;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=H40k3OEO
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E0DC140AAE;
	Fri, 30 Oct 2026 07:42:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pd7X-nziLOcf; Fri, 30 Oct 2026 07:42:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2037F40AB6
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793346156;
	b=PuzoVW8gMV9vLkRMudKt+50Q5x4p/zC+yCc0aMTNNGw2Vu/NcjsO5qMbm1HIIMSxdgn7
	 W8APTB2CmXRuPO6H1XPUm165HlKKE7b8+EEq4/tD94LzGrjNimvz0Kyol3jUOdhP8lUFk
	 byybe9MKOOVDNUVhr39UDK48vr04dWrY7K7XI9TKcBFKLiBxH91QwCopl3lNYPQLFYEfB
	 csmqfGopQOxujnR71NfkJtKI2hP+WtquwE2B65s+aZ3jY9tUgX/dRoFC9vh/FXZgygNtE
	 49lgjo6ttFi6/eBQt2frwY+t8N0uhKbmrREPsYqQj+6VxbnOiTN7ByhfRM0U7/6gL4g==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793346156;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ZZgvuyd9fkwLFLzhTM5/YhBtOz7kC7zHy6hQUymhCGM=;
	b=dYHrgP5j24EmMPp9Nrr+Qf0YaR1kCNtBwFOKDPGDOPMxBunknInufUuZCN1sWzLjfrsL
	 h5Fgp/XM90E60pI0hJU3KGD/k8Uo2RI/WeGORpd2LP3NRB5IRjIy+S2MWlelqT3/p4Nd3
	 w2clJEg3YrTNTvsfBpX1G3gfgpIFyoJpfr0pKqjfy/9WlhriP1Y+HP2k3/bru3rQyytGz
	 4NIMAyodmJbg/N8zsvS339wgryOMoltJT/uV30x8GR8hocwBcdHzDHCK3emsARYUwH7lu
	 CuQt1epBt0u2q6In/LJkwmMRmo8dxHuX+9QVWhF4NknRn5GSABPZ/sZLYNhE/iPb04A==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793346156;
	bh=ZZgvuyd9fkwLFLzhTM5/YhBtOz7kC7zHy6hQUymhCGM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ErMB/uMZmGcWnl2bcOzfYDxzwSprSktSuBVX3N7TK7nQGoxiZvy6LfDGIPMpJObqz
	 nxvwVU3H1hNudyUlra03MweyXDeGTXlEuoOR/36MRVnK7ForE/ZzXgvykbcl4bgJ3E
	 F6x3bZlSKdjZYP0kIEq3Tfo/IDmHCpZBza6Yun5xeF92qViMKWnJyAi9EsvmuU5+Wh
	 0DWjb82C+F0fopNvsTI4IewpwDxSLqy6iw5OL271r8x+vU47Fi7QSyHatSaH3bjc1W
	 vPvRz1lmEhJf7G+CkzQpk9VkL/XoX/Lx84PsFHXEamHW8CVtFkjgCqrIV2O5a0pqBy
	 Oi+SAHEPNwnEg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2037F40AB6;
	Fri, 30 Oct 2026 07:42:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 60471380
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 07:42:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 51EDD810C5
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 07:42:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GniBzg4gfjvD for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 07:42:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5179F810B5
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::112e"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793346153;
 b=TABQlB1Lxs2LIFVuAHXJJJh4tY+uvCqQf2MyOMW4rLmk+ylV0LLxlpCDITsfaB3wa7W8
 QALrM750evYmYM7bJVYu37z8QSAkEqid+erADboFgp7lkblSznyBIlTBWEA2StGQj2J2G
 BavdgIoPH3ODrapIGWX/EZJ/1sJLD/wW5oOt1mIC11jAsncQgl/RUfIZz0aFnRh2OnQXi
 uYeO/KzW4dfEzIooy21IESjfJow3zNrGrhea6/z9nUVucSD2r/dQrHkXwfxKCWX3oVBlf
 if20vnNzInnzQwSZ7oXZDKLtXmVaoipQ3Elrb0KQJ4n82Z0FwpXTMBdnWVCsnQqM65A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793346153;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=ZZgvuyd9fkwLFLzhTM5/YhBtOz7kC7zHy6hQUymhCGM=;
 b=mMxJUD3zoV+rx335K2DJljakL1HTPArIzhIhwoUjnx/hRIzLyleXLPklgLYjfreS1Fio
 DaNSF544icYinR46dvDd5wypUxUhMXQIKkVlgymhXRFJ5hUSFR23uJhgwH0s6g9RfhtbJ
 69EAcvkpCqHCAp9RYz1uMGxKS1xSjKcMroMn9JAIGLvTEo3jJ2fggWr0Oyphe8R7u7+aw
 OojQKYNjhjm4DG0i9mvbLSyhslMW909KdMSn4X4HBztnntAxTYxqYR7fRo0We9ejiikJw
 4KR8yE+eYqgPnpPKJ5JDo36DDY8BZeM17XTNDnxuni3J7iEbCtkeSAM22ornFR5qQaw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=H40k3OEO; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::112e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::112e; helo=mail-yw1-x112e.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=H40k3OEO
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5179F810B5
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 07:42:32 +0000 (UTC)
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-8ab37e44643so2915297b3.0
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 00:42:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793346151; cv=none;
 d=google.com; s=arc-20260327;
 b=Y6CvsIiVLmDdzF6zvKusTfJCjICSukAcwwU3zzhe4VYMmJzdXl0HKaAN8YYR3jTSMj
 iGxrt1zCI1gKJGucgDIBfIWPjs4+XSEVL6ep/OegAKHaAONIVoC76Y/irkEiCdzXa5/P
 KVxWAd3+jG5lu24W1CSdoYziHp036F8ieU0SFLrC/H80UX2Q4piRwx3B8iMnVWxly2Nk
 UHGR/kPW/TNG/KT9fgmcIWLNJLH9fGtnqo1rDyacVExo13COFkuTSz6tpETlcfAwxP4O
 PL39bZsqVKTp0tTHpLIkaXM0Tmy+HwZ+koL7EByb6tzESCfR9fWWMbg07EkjL4a5oKMk
 4Msg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ZZgvuyd9fkwLFLzhTM5/YhBtOz7kC7zHy6hQUymhCGM=;
 fh=OhOSfS6mWstEu/irkSxD71iDNWnMeRBAfsy0D3wuTYI=;
 b=gytLcw5fHF+kyuJ2KPiR7OYrlo7UQx3w5oYPXPydXyCVogdG3HFkSizWPFqEzp5Khv
 BMNcEm82Fx/L2JE8Xhbm7oIJvvE2T4EsXH5Yf4YIm0Gox2nl+Lhnh9qjbeZgKWKTMOqQ
 vXFf4IHIHlqMlR6f+CVL6zmS3vgt1nllXP5ALwV0Pp5FZXGYVpvRbgmwmZhn8B6jHxiN
 S4PA/BrlCDtnJBKtIKajBlXpA1eLV2EOmXrO3Oj+IENGHUaL+2F9ezUMRfZ8X9VmzQxi
 g3lRoK45ZU0t3Br/OaSnZZ6fA360d4/dBJwaurEzC6r/vFULQyE2QSCfBlXmgfWfVnfP
 K1Vw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793346151; x=1793950951;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ZZgvuyd9fkwLFLzhTM5/YhBtOz7kC7zHy6hQUymhCGM=;
 b=H40k3OEOsVS9h2D11XC5mhw6qsvdyX8CmAZZ6i+RbrOLo1zx85J/kcqhhQeKma4YFP
 08FrL+hHFG9Ypqnj7ClpxprSqAmvBkBG+pJ9xGh1wr4qhJfiL+m0kGUpEtLlbp6pAO4v
 +L8IeNc+Djee0ds6bYwAv0xSwHn07rNHZerofLYTPqOTs9XgAkVq2YaqsW4cu7YbrohU
 TQUE3etIA+ZKYFoE7zG42GFDhqChGz8/b+zV6qJzlIlMoI3gTIWHdi8+svoZOVeDpHXo
 /Fj2HCBjzGcKU/GSKA7u/foVjII01/ChYn8E+cpZsRUubG8K8SpqI516ixGag+/LvRd5
 OEnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793346151; x=1793950951;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ZZgvuyd9fkwLFLzhTM5/YhBtOz7kC7zHy6hQUymhCGM=;
 b=RToofRstIP6puPnqF/WeZJcwp0R+jxE5rXpXu2WFG7tYIB26KzH6qkJZURZkJoBWvb
 Vhs+taC2aR9jZvpOZKMchnQxb/nhmalv9sYVn/UM/8gIq/u2gbUdaw3sbtobioySZa2w
 Ykl67+SUVOQNbR5B99pd9TER/epQOdcsBwFELjTwqnjmWIt1gtuJxHLktlMheRnBps5a
 S9UHzYuvwMbmyMH/7QDfWFEsnakKiNgBkfpPapEcEedgGPIt5ev/KIsC0plFx1lT6S6O
 R75CNym3B3Ma/Kzb4zC7/I52EukTJwf1oWTwrJkVesQbdF3g9Ob+TWpqehm+AlqXUCbo
 fPVg==
X-Gm-Message-State: AFq9FYLob/SF9fiasUxsc3VKDLbA+u9BhGt0RQEITpufQ7P1BNBuvBKL
 SwTyK8rFlwrRk/lqbwJH+E/2pm0fUBSjX1Hrq9QXBUQiZmGkY7nJ9GGv21OROkWt22WqJMAZDyH
 SoaTIJ5R1/tFXSVb3nTPJw2koouc44ySW+VKPyCzkTFyWXCRsgTxP5QIyZw==
X-Gm-Gg: AYBFou2dzfgefK+Pdc7zhW5y3mT53Jgu03U9+tTM4O62379WOk+ImE7iO77Kc8DEbla
 xdWTqoskOftJCFQbEsJIeGCTuJ93ufrzATa5bHF3MblbuGjF+tQNKew5NDaHg1vUJd8y7frrLNK
 nzLp8ibR3zdWhloIKgw4FCZ6ak3oDeZWoXYZrPvYquKcLjQVjBTy6pJDCGVzNghb5o24OVqpVi1
 Do81vW+IUcTwULIHq5qpimhsmYHt82/0HLl6FvnE7AXWLVlAo151AFg1JLMXsaIHiz5KmciyKL8
 oEsWzZjq7tSmEKjnAmznUsGYwsUi62baDmYL/D139+Url+SgqDfV82IAtiaGWS2EwGu+VkZLS2c
 k+HgWFGbXxaXdqIray8hbMyYQ/SM4fj9CTDcoDOVsTMeSuPWFfUcQYtGMRuYBGnZGPrTkD/GddW
 ifIHQFahfMV3sIwcknSXwCDdidSGXuXoCjA+FO87RDuBik6EvPkGEUTCSBnsYNCu84DdLMzvbGN
 O1tx1iVAPhqwzWdE8H3ylGxbCZvi0DfQ8ZeyQSGQZHPN4IKj8dDYeGXCaxwdLuBryaV0cbmYiX2
 rsBdbXdberHOxEIJgIHIFa57GVrOnNXtrR1/l9ZjkqSB/Bayg6mndlSsek/hzJyvlXVVyMJa3jq
 SqAyzQlC1dTFINe/526YZSWvpQD8U7o9BMXMT8EwgrfpB7OxOcK0eB0TM+U0E9rRqwMDRD6cf26
 G0suvq7f+dmvP5CSkbTtVq5JdF0NcotuB2LKY=
X-Received: by 2002:a05:690c:e0dc:10b0:8b2:aea2:64c5 with SMTP id
 00721157ae682-8b2b67a4c2dmr5998097b3.96.1793346151283; Fri, 30 Oct 2026
 00:42:31 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <633dddd6-ee22-4cd6-a8b6-cb7df0650fae@gmail.com>
 <5b986292-b889-4e1e-9e0f-9012ea225366@gmail.com>
In-Reply-To: <5b986292-b889-4e1e-9e0f-9012ea225366@gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 30 Oct 2026 09:41:55 +0200
X-Gm-Features: AclHuK9FaqXNU7Un2pV--YfiWWud-7j04VVWKnr7avTGOuwsAuMUTbbT9o3e-UQ
Message-ID: <CAC_iWj+3smqn4zNk-cAr-VFWBezE6Tu1XcWdnu+BJ1a5iSQH0g@mail.gmail.com>
Subject: Re: [PATCH 03/10] efi_loader: reject a PE section whose end wraps
 around
To: Ana Bobillo <anabobillo3@gmail.com>
Cc: u-boot@lists.u-boot-project.org, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Tom Rini <trini@konsulko.com>
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 30 Oct 2026 at 08:13, Ana Bobillo <anabobillo3@gmail.com> wrote:
>
> From: Ana Bobillo <anabobillo3@gmail.com>
>
> efi_load_pe() computes the end of each section as the sum of its
> VirtualAddress and its size, both u32, so the sum wraps around before it
> is widened to unsigned long. A section near 4 GiB then yields a small
> virt_size, and the memset() and memcpy() of the section write far past
> the allocated image.
>
> Relative virtual addresses are 32 bit, so reject a section whose end
> does not fit into 32 bits. barebox, whose EFI loader is based on this
> file, fixed the same in b6598389d46d ("efi: loader: fix integer overflow
> in PE virt_size calculation").
>
> This runs before the image is rejected when Secure Boot fails to verify
> it.
>
> Fixes: cb149c66342c ("efi_loader: Add PE image loader")
> Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>  lib/efi_loader/efi_image_loader.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/lib/efi_loader/efi_image_loader.c b/lib/efi_loader/efi_image_loader.c
> index 35cf3cd268f..b15a662e5d6 100644
> --- a/lib/efi_loader/efi_image_loader.c
> +++ b/lib/efi_loader/efi_image_loader.c
> @@ -1062,9 +1062,20 @@ efi_status_t efi_load_pe(struct efi_loaded_image_obj *handle,
>         /* Calculate upper virtual address boundary */
>         for (i = num_sections - 1; i >= 0; i--) {
>                 IMAGE_SECTION_HEADER *sec = &sections[i];
> +               u32 end;
>
> -               virt_size = max_t(unsigned long, virt_size,
> -                                 sec->VirtualAddress + section_size(sec));
> +               /*
> +                * Relative virtual addresses are 32 bit. A section whose end
> +                * wraps around would make virt_size too small for the memset()
> +                * and memcpy() below.
> +                */
> +               if (__builtin_add_overflow(sec->VirtualAddress,
> +                                          section_size(sec), &end)) {
> +                       log_err("Section %d virtual address overflow\n", i);
> +                       return EFI_LOAD_ERROR;
> +               }
> +
> +               virt_size = max_t(unsigned long, virt_size, end);
>         }
>
>         /* Read 32/64bit specific header bits */
