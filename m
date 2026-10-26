Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D16606A31B
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 23:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=vHwtsEtk;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JnHh1lQ1
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1115840572;
	Mon, 26 Oct 2026 23:59:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6b5kEanhWK7l; Mon, 26 Oct 2026 23:59:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0E3CD4050E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793059164;
	b=gL7217I3lafnZ2o5uGu+VtPJpvh3VtqWm/WhQGmMhgBAmzJ83kADgQYCkPx/VDBc9SYf
	 bcjqJqMhvqQcq4SulU9MV/ZjbUeznNQhYtfvBeTx3eyLrVz8fq3GBDG1BpdN0k9qtPgr0
	 fgyaQQylBoBgayg+Dk2+/2zjj9xjce5BWbpQx6mJ37W8FkRXf1rAwH0KGrTA4LSXNszgn
	 kd3DPuiT1XMAnPSYeYV+L+tI5P1diQyLPU/cHISJm7DpLOnY6In6cWjnCme6QFN0Vv1HL
	 NiET0D7Yems+pDy9fOTx0zrVWXR/bn4js0UoOqOwH0i3o4alTgJEI0hRUPZxBQszmlg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793059164;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=BE6VC720EFVkTJXYes16t76QVxf5MIiZDXzbJjeTXoA=;
	b=MQKB5sTDXHPGTVLhPmI8v/+EpQ9K7j1wA3UBfVNmnWg0qrJlV+s4ntFpxEJgbID/V6+3
	 TRXW62hgstK4xGtLqffs1/YtIP2nNCDKduxSPjdeyvaC0XhEFGcbvBW5AxOvpDIbE77Y9
	 HDMn/crqb/n55OhXJo5j6EGbIASy+hEay8TM+4OqV+EdukV7R2hJC9dszoxWHGd9xNeCU
	 J9SANVCJ9KZndvfH7Haq42wio487O293R6A5kAnoGDlQ+F/HT/j0DqUnj+vpO7Z1MWirV
	 lQWDqEDOPdCmPgXen9X/6Z/BP2pLOxSV4fXsXWFA/rReVjog2cc/qReHvMyhqWYOlAg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793059164;
	bh=BE6VC720EFVkTJXYes16t76QVxf5MIiZDXzbJjeTXoA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vHwtsEtkeNIDomJd4oAK3ozG8hEVm2coJYjXz0m0dsQDR73+v+VR+vSZVxc1ZDAwj
	 xDvOuiY9BcSfn4/uwyBD1ZabvAlHwvqQUFqtjL/xq5UfVtPeSPBWczLudIo5EcK1cn
	 euPXn2YtSDH4OphF45Uaq60bjrapAh183mgz9708OgNPp9TSTYkWRtv+ba84hPVBOg
	 HgKFM6LeoFyWYuYeNs5a7iSjGcJzv62UgGYqw+yKqvuNnMeAe19J6dZ+H+m6+FJk4y
	 Bq26NBHchB8jWTSfLhe4bw5Lu6RufHsq2Jwlwdh0V04yndOd7MnleD81xXVnKaReSZ
	 hBijl8qF6yKJg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0E3CD4050E;
	Mon, 26 Oct 2026 23:59:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8BC85356
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 23:59:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 717A060603
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 23:59:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LLPrv37rjboR for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 23:59:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5320C605F9
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::92a"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793059161;
 b=ZKN9HmuHcY11krfklUHVUl75bUaIqhjMx/JEl5LpR3Ok+rzOIHa1MHt55fZYTFRr5pXl
 7h+b6brBQLmxCtFtV/Dnjyjmhvv24oTXE3Lf7qfjzobsZJYK1r1PEpxsSQMQaXpWSllNe
 t5dRJE7NlQUUi64Ok67BnUmcFJaG/LJ6euGXL9VVjJnqaV5bs43w4zvUUvvZZKvdGagqq
 IxQJEksIX03IRrmn2AEQjVaT43UY7M/JxMMBPvS/L3MM3Jmq6YjDcM0efEWiuL0mPK4eV
 /rtVm17vfxu5JardO1E3Fl0nj7RhRvz84a8VYGMhLFXVPIN30Ljz5JI8Gg+07NtEwfQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793059161;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=BE6VC720EFVkTJXYes16t76QVxf5MIiZDXzbJjeTXoA=;
 b=GpjImnGf6SiaLx+xWEgcfGm4bTfsGZlSml/R8+QnDYjcLIGLiZGaup7MZvQkaavp2BqX
 ve0uzCZ2LLU3x+ojNgZBfogKsGGlUbkW/lvbKKfLyHJ+8L26AHbcn8srrXtJHNWnImBJa
 stwrVSGAxBYIW7uGNuM9FLjw78fmBmwNNZ0y2lNNDTgup4+Euq7nCnTyPVy8lNWsIwoZj
 ySLI6z+IW+G96RX2cWIUvhqXIFsO8yecK/L3b+QqhI1gZo7VM8SHLImBn8gp9K6YeZEeE
 /KhTtFWS8GqMvW8MEFdXza6AtTZrjQkTuRyG+cR3ls+ZSrADfmwHqgn8i3Yu5wba9Cg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=JnHh1lQ1; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::92a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::92a; helo=mail-ua1-x92a.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=JnHh1lQ1
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com
 [IPv6:2607:f8b0:4864:20::92a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5320C605F9
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 23:59:20 +0000 (UTC)
Received: by mail-ua1-x92a.google.com with SMTP id
 a1e0cc1a2514c-980c4258105so1969398241.2
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:59:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793059160; cv=none;
 d=google.com; s=arc-20260327;
 b=ac2YyMk4z6ns8RySGnGVuvYYO3eLR1ETDxYzS3EKi8W3BWhmfb27yuHCjA3hQGUsv3
 vWttTODz94nDcPY3Td2Cg494UHIL2JWKnDasuIOIWbzBz2Wkki+Hr7KCzu76aJPvtHd3
 ApZCEr1SqXxjbMKXALhsNqrRcCbxTZpCfEyie8dDZpVk5uyvAj68lDaAXz8y02zt1RKN
 MK3YpYePusH6AHqjqPki8ao3JGZFCXO4fkfZ30HcQrLWT4qOXVtNurprmo1t8V9ACbyM
 aQIvmOaoTfcHYbeedaSRIPWrrMeBpU4taTfNTYWN+o+Vn0Jj4sD1ia1VskJDpIa4WbGI
 5fxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=BE6VC720EFVkTJXYes16t76QVxf5MIiZDXzbJjeTXoA=;
 fh=OrYyFgv9X4p2jOVwvBx9nk4986sYQSAwyU+TCi4WH3g=;
 b=NNPOsI59a5xWzR8Fnq/MWe/cexUXahvO+aKFJeXdpAriGiQAZsEGkAeaWu5A4slgt0
 6pILr70do7EfC7xgmzDOWuY+Glrsyx7+xIoR8Dgnj45iLoABdsMvWYuWkE8MC8yuXShJ
 9ro12LzL3OxumA96hsXNTQjqXdl8JyjbTbsxpudxDgAFw02JvrcA75pAP0mRd+Eg7M+r
 5kKMwInxzxg5SWCpD+Wf8eZ+6PpEFS5ub0ccn8b2m2luqLioveJEzKhhKZs8n0puOlDP
 gOc/mwau03WiML49N2ZdNsILTVhfKnCg542z5fLU6wll+/h5ZOGF9fuoke+2ktpjI7br
 82sw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793059160; x=1793663960;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BE6VC720EFVkTJXYes16t76QVxf5MIiZDXzbJjeTXoA=;
 b=JnHh1lQ1e2iKOPn25g0CpIy/547tFjoX8ST1zfZK7ymVZA1nY2C4bQANQLIMcwVVMM
 rlid1sh9Pbdr/25iUiIRtryHTXXO4mzQNsxdRROBELZzCEn1SIEqRqBGXIZY6WSe1xXx
 yYpe0e7Y4AOVblpKyV+r84QS4IqaIi8/pcJkJiQHXHmo2hcVUKbfs38HZHqUxMP/k0wk
 dEcPX4GlozEnCG9puXxq2TbDUGisU0iNi5yTCBniz82gB3Bu9TOlHD+0yIO3x6cwgm9R
 uwWd3Kr6B8gvTcDxApb9oi1ImdK1AqD4yVppLsLEgRtrSDMUCF4LSrflwQ1yeDsD1v2S
 nu3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793059160; x=1793663960;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BE6VC720EFVkTJXYes16t76QVxf5MIiZDXzbJjeTXoA=;
 b=yIllS87NG5IeUeLz7H48XOB9B+DqCRuy7+/qtW67Qc92lXs08fuJGRM7cCW4lwMTUx
 nhch0voDZNKpH41fwHv/mwfvGzPLM96+j4tH+mI6ELDA3E+bgY4UUrunYn5JvSBhguMz
 hKk2He2JdyU6WwIPDYnF1FeS6qT9RaTIPNM32CVpF6Nrp+F3Uj4HjndRfx31svSlFRsc
 TIdZhwyMfCSqlM8MgHv5zHEx9nBVb/CRzuNrg1LIztfIZtIUeNF3951CRqOzPut5+Vjt
 TDb3Eg/SbxTlz5J9Rx+O/njXRUZVXLokoYPmfFfJrVrIvnEW1IDDAXQpl3PNGqKQO+Jb
 j8yw==
X-Gm-Message-State: AFq9FYI0ctVT6+9y72qakDsY1/bN3k94pxKw0xMMFyObPpBf6159fyDA
 vc4bO8bz8b6IrIzeF6jrFctB7ubvfeJuRLnTKyKBM1ReK9aN70IMj9Oc2st2xiTl3YaBa3G+yZE
 Tep/TFiAJYhVtGpdHgX2CyhUdWjqIHDA=
X-Gm-Gg: AYBFou3UOyxpmIDGoOPFQ0rTCfp6n84QoX+yC5fhkDImHbOU/SMi+b6rC0cqoSekBeQ
 luppq3NtWqvt7LzDodORGW7AUI2kKivqSNUCY3GbIOp9gxVLTrZQ2kASc/1cTi4WUSf2M4E+DO+
 8EMUU/1X1fB9SOKV6aog2VEXujcUcyuBMSolilavK0SoKzoknXs+pjxFT+cy8OCYgacsHwZJZ4w
 pwdJV0G7fBiMu6Q7WmnR7YnAUtlYvAis4cVmqZ+MLHwHgCfDqd7CS4ucqHlhY/xBgPMoaJPx1/3
 L8r5Fo41mxFOU8XXylMips/X8KVSk/zOrpebvdL8usgFiDdNqSEHtPaPpiL/zOBYSIoH/KAxIo1
 4AmyWUzPiuB+AsVJ8rD1/N53masT/ypSVsXK4MUQxfvAiZiFGEB7hB/es5oId6zWfMqC8m15VDX
 7xPbmuOT7r6ManqWqKAahiFeJ58vUaHyps3B3Fm+ptP25SGWkGPl6nEZQAmHioffb8xQ+R5T+6f
 JSfjO0KNqAXBl+2xFO14ywiOrUe8A==
X-Received: by 2002:a05:6102:a4f:b0:7a7:ad9f:53e2 with SMTP id
 ada2fe7eead31-7ce5ca0cac9mr3303137137.1.1793059158782; Mon, 26 Oct 2026
 16:59:18 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261026212853.453191-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20261026212853.453191-1-marek.vasut+renesas@mailbox.org>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 26 Oct 2026 17:59:08 -0600
X-Gm-Features: AclHuK_OLipyq8dgP2Xk_dhSw-oFi94hrJFM5eJgicDbMIxriWjqVTiklrdSxJo
Message-ID: <CADvTj4owSzHUg2xMqqw3uW_XFKbFXjN3bU48COrtxxgVzXaH_w@mail.gmail.com>
Subject: Re: [PATCH 1/3] net: lwip: Make timeout configurable outside of TFTP
 loop
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.u-boot-project.org, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@arm.com>, 
 Lukasz Majewski <lukma@nabladev.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 26, 2026 at 3:28=E2=80=AFPM Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
>
> Make timeout configurable outside of the TFTP loop invocation, and store
> the timeout in TFTP context. This is a preparatory patch for porting of
> the DFU TFTP to LwIP, which requires a different timeout than the LwIP
> default one.

There seems to be substantial overlap between this series and one I
recently sent, maybe take a look?:
https://lore.kernel.org/all/20261024-submit-lwip-tftp-combined-v1-v2-0-0f66=
3f735ee8@gmail.com/

>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: James Hilliard <james.hilliard1@gmail.com>
> Cc: Jerome Forissier <jerome.forissier@arm.com>
> Cc: Lukasz Majewski <lukma@nabladev.com>
> Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
> Cc: Quentin Schulz <quentin.schulz@cherry.de>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.u-boot-project.org
> ---
>  net/lwip/tftp.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/net/lwip/tftp.c b/net/lwip/tftp.c
> index 48c6eb7022a..1d0e95d826b 100644
> --- a/net/lwip/tftp.c
> +++ b/net/lwip/tftp.c
> @@ -36,6 +36,7 @@ struct tftp_ctx {
>         ulong block_count;
>         ulong hash_count;
>         ulong start_time;
> +       ulong timeout;
>         enum done_state done;
>         bool is_server;
>         bool wrq_accepted;
> @@ -59,7 +60,7 @@ static void transfer_timeout(void *arg)
>  static void restart_transfer_timeout(struct tftp_ctx *ctx)
>  {
>         sys_untimeout(transfer_timeout, ctx);
> -       sys_timeout(TFTP_TIMEOUT_MSECS, transfer_timeout, ctx);
> +       sys_timeout(ctx->timeout, transfer_timeout, ctx);
>  }
>
>  /**
> @@ -227,7 +228,7 @@ static void no_response(void *arg)
>  }
>
>  static int tftp_loop(struct net_lwip_ctx *net, ulong addr, char *fname,
> -                    ip_addr_t srvip, uint16_t srvport)
> +                    ip_addr_t srvip, uint16_t srvport, unsigned long tim=
eout)
>  {
>         int blksize =3D CONFIG_TFTP_BLOCKSIZE;
>         struct tftp_ctx ctx;
> @@ -248,6 +249,7 @@ static int tftp_loop(struct net_lwip_ctx *net, ulong =
addr, char *fname,
>         ctx.is_server =3D false;
>         ctx.wrq_accepted =3D false;
>         ctx.fname[0] =3D '\0';
> +       ctx.timeout =3D timeout;
>
>         printf("Using %s device\n", net->dev->name);
>         printf("TFTP from server %s; our IP address is %s\n",
> @@ -535,7 +537,7 @@ int do_tftpb(struct cmd_tbl *cmdtp, int flag, int arg=
c, char *const argv[])
>                 goto out;
>         }
>
> -       if (tftp_loop(&net, laddr, fname, srvip, port) < 0)
> +       if (tftp_loop(&net, laddr, fname, srvip, port, TFTP_TIMEOUT_MSECS=
) < 0)
>                 ret =3D CMD_RET_FAILURE;
>         else
>                 image_load_addr =3D laddr;
> --
> 2.53.0
>
