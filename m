Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF3D606A320
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 00:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=a73VhIsj;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B5A+tv9L
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 614BA8154E;
	Fri, 20 Nov 2026 00:53:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JTZk0fIqQqNS; Fri, 20 Nov 2026 00:53:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C1C688156A
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795136002;
	b=bGreBLmrSY1he0PyPWm/EDo+poBH1nW1yk+SoFpTVXW56Hhy0dBhJgmAYspexHxINWL/
	 WinvPKJ+bSWV2kFOBhdHyN2lwf3w0PWGSWLFUJ9c/3FqYUEJcSO7HG4kILbAqbgZu5+xv
	 utGPsvvbIJfxaexl9bNJSqFOoPPWkPJgs1TathQC+k98Bwh6IzvkhJuiUe7Z0pC9TdZVm
	 EPrgQehNMTTWjO2/UyHYcjqugd+10N5NAOaO2hSFJUYgH+LiB9Kz3XaRkMz7fbDOMmjW0
	 cuXXdwx3gjowZaX/OII8aWE+j0REt5ag12uizbO9iepmliqwwKbcPcKZL0ijjFFHSUQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795136002;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=YEBUMtAFUOMRvxbQakajb9uRleMgG0McAxCXFQgZe9o=;
	b=sA7Q7I6Hfs0ScHJOuvtr8lDvweOE5+xuq5qwRxTS15aBdjJPfVA6qeTnombdKU4ajj9B
	 dteiHEum8S1ru4ZqKOsV2uBetcYOME8qyALsEJ+uhvsNxq/wD9oHauplj5DnqFPb02lsb
	 vewX6Ji1QeiHp41qkmw10hO/v/MMchAT+0FNaSA6NhE0dKpEGI30vdGVxoQmej4z39Mxi
	 DLyQb0DdX5oPBN0hHfsGns9k+kJl1EO7k9pbrLhnea32NI2C7seoTVm0lMxD1UWMvQIO6
	 BOT/zuoQErj+EQ7hwnWnjSpCFP8vNevcBxIWX1E6u0fmqCwT7tW/hQGr/8xCOBFqZVA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B5A+tv9L;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795136002;
	bh=YEBUMtAFUOMRvxbQakajb9uRleMgG0McAxCXFQgZe9o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=a73VhIsjWeuV8s5UK3uXFgQm+WXh2i7JUndxf6uZXlJ4XV+nMN+wgVS4aPkntZp38
	 2X96cEuGeCG0Nx8+svRv8cTm+CJ3yXH5FyA2MPUj1LjT7Tercb/HVL2sulpcj4VR+Z
	 QIdTwWNXgIs4kwgW01wYiTsiaA4JtyY59llvqKHHPOqebsYX2QxVTOGBABAcc4zLjn
	 tnzLRfHR0//iKmdE2baD+Qu7JFx4ernBGDDiQYVldRyr0NBmfd1k21BE1VcOmUStoJ
	 pAmLzssXf4lpPkE5gFs2rR/Mke0AcG+kVKoLEVUk7Rkqw3PLGG6m2VqULfClznxH76
	 0fvH5ajfge+cA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C1C688156A;
	Fri, 20 Nov 2026 00:53:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 771CF1E7
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 00:53:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 74C878156A
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 00:53:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dOY_LWN4eC_x for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 00:53:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org AE10F8154E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::b12d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b12d; helo=mail-yx1-xb12d.google.com;
 envelope-from=bmeng.cn@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=B5A+tv9L
Received: from mail-yx1-xb12d.google.com (mail-yx1-xb12d.google.com
 [IPv6:2607:f8b0:4864:20::b12d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AE10F8154E
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 00:53:20 +0000 (UTC)
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-67da564d9f2so733036d50.1
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 16:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795135999; x=1795740799;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YEBUMtAFUOMRvxbQakajb9uRleMgG0McAxCXFQgZe9o=;
 b=B5A+tv9L67LQcQXLYaOptMs6sY8zZBRJdRjrwOInBfe524MZlyG6KUEYadqkXs7i79
 uL1xtFf8ShtqWYstF4TneL2kqWBHX0zf9DFwK7dv2WDSeRYF/ZCZ7wBOVS+AWq19w3Cw
 LwBWF1it0KoxPXbM38k3LFJ8fgd0YizjPhtPIbGnOLj0CxskKo0REJGyhpqmxktoC3as
 4xk/2xMencoIX6p5ajL/zeh4t2OHHTMgjwJX12h4LcL0fgH/HLk+ijYWr5nEyRAW6tEj
 zcy9vq562wmPeaWYZ0CYf8V6VcPKxuyeUJjH2zsNrCs5iy0xDgNhhRGK3EvspHwa2O9g
 uHFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795135999; x=1795740799;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YEBUMtAFUOMRvxbQakajb9uRleMgG0McAxCXFQgZe9o=;
 b=z7lqXMo7xaN0y2SyTVEQuTWz8HIDPpOpgInwj5EmPl3vpLaCAiUtHFjAmj3Ktx/GJc
 05iLQkQGt9sD84cvHK7oXqILMcmgYQoA2HnLrn3OV8NI6khclSrI+GIdTxP/tCM3ebJX
 ALaDTea599X5EclPv9+JgrAtHuyS0tNxbcJp1wYBReXBzd4EFfXaE/oO98LFw4A01V54
 cY3aB/Nul4FMLsnj+l+MtD897tpWjnh1qcIfg2gVzqPiSXAH4AEgnA766AICz1WyHCIJ
 8n6/uYiGNZUqqJeSUSIgm6oLUqUI1bnmkWbLbTvZvIaVPso4MHePTKYdc2rjm72+cFU+
 ry+A==
X-Forwarded-Encrypted: i=1;
 AL+hErHwymjDFMzWeuKHvOK/iZzYTsGT1XUv64KdNyrBkNl5iDsBdluZETeOGfTkA/zzxKomhIkrTAE=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8MB1JkHMo2jnw9+4fYTTZhxienPl5F5TcXOgaf6yObLCQapkuv
 IgYbTSkoT8dN6MnSTkMzzSOe8pEvYP8ZFWPh6PiSXF6PqouZJXbihHFhZoOiea9uzU7AzEnnCT3
 SCofsQCyNKFzed2FxM2YBRwB4UBa6fDs=
X-Gm-Gg: AZFdTZdPxqjr4uecRU4/U01WK6vplDhOVo6geuosFS3nTNgUDGCcE9mPPLNjqbsr1nA
 64J9twMgYihHljBGF7vQz7ewIYQag3Z7HvG73FxNUIDD54gSofqE/XA+O6Q0i8OLlTe4sKLJu7a
 kua4Q8kopAcuhFPgFVSJ3NW10ACnZ/3W9OzuFdCrQ4DJLiYyjNIds1HiNizaDZJ9EtrzFwEP4z0
 5dy0yub4r5rjZUtD7aQUPhWWcM/l2QPmBEJXOHVCjYsbmA4GOJ1zVPOd4Kz7IrU9Ray/dF4v9kc
 sPG6z1wPvN3NSSYq8jnU4U5V46sU2FiV5qZPGa81JEpTeGL903JBUz+sI9ddDT494k9BFhIvykS
 eA1SERUg/dN5KpyLOollZk4JEZ8DvhuDQzENk/0H2IO1PZ5Y5yNNd0s3XqBEb9DmXMs/t5rL5RA
 ==
X-Received: by 2002:a05:690e:128e:b0:67c:6b72:bc3a with SMTP id
 956f58d0204a3-67df43fb5b8mr674460d50.42.1795135999111; Thu, 19 Nov 2026
 16:53:19 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261113-nvme-fixes-v1-0-a181c72f40e7@flipper.net>
 <20261113-nvme-fixes-v1-2-a181c72f40e7@flipper.net>
In-Reply-To: <20261113-nvme-fixes-v1-2-a181c72f40e7@flipper.net>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Fri, 20 Nov 2026 08:53:07 +0800
X-Gm-Features: AclHuK8pUnYPBGA5kHGO21_r0BeHS_48oX61PwVuZemIhnPdz2RnLckYsHPnv2A
Message-ID: <CAEUhbmVJWxZDUZCTw9UEGDqjqHZH45thbshoWohDMCo3zSw2Kg@mail.gmail.com>
Subject: Re: [PATCH 2/3] nvme: Consume completion queue entries in one place
To: Alexey Charkov <alchark@flipper.net>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.u-boot-project.org,
 Zhikang Zhang <zhikang.zhang@nxp.com>, Wenbin Song <wenbin.song@nxp.com>, 
 Tom Rini <trini@konsulko.com>, Prashant Kamble <prashant.kamble223@gmail.com>, 
 Torsten Duwe <duwe@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, Nov 13, 2026 at 8:00=E2=80=AFPM Alexey Charkov <alchark@flipper.net=
> wrote:
>
> nvme_submit_sync_cmd() advances the completion queue head in two
> places, after a failed command and after a successful one. Each copy
> wraps the head, flips the phase, rings the doorbell and stores both
> back into the queue, so a change to one has to be repeated in the other
> by hand.
>
> Move that sequence into a helper, and keep the head and phase in the
> queue only, so there is no local copy left to fall out of step with it.
>
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> ---
>  drivers/nvme/nvme.c | 36 ++++++++++++++++--------------------
>  1 file changed, 16 insertions(+), 20 deletions(-)
>

Reviewed-by: Bin Meng <bin.meng@processmission.com>
