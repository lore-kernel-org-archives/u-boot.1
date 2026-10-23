Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18373606A31A
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 13:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=zUA2QzIn;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=NWOo6+Qt
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7CC466070E;
	Fri, 23 Oct 2026 13:12:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sPMsOUrrFPQ1; Fri, 23 Oct 2026 13:12:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A84A5606BF
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792761156;
	b=tSph+f4EwMNEF7MhUxeOEj7Xj7EiALj8HPGnpmEcG6TITKSYuvdcR6PjNTiqR3agsxQx
	 mbRZgCKYoXWmtkZ0sVV71vOojtEpXU7Fy67HuihAVXtNUaHz0vTpKzJO1nuz0nTtQq+Ha
	 P/w2LzTqUb+UGLdSZzfsW4lwGERCMxiKOGzbePN0uDDSFQMAohLDzOtZ4yctLd1m8K+Wf
	 EBupyfjGQgY1DbXlm+sbodV0BELWtYKYWdoW5vr9fHOwOZs4hgJjs6c9iss4A6REaKsmK
	 9+m1La3kNXdoN5R9He/j86opp/MmjlaSqXpsXjiKGi/ZRl15s9aB/9yShaPgX/BqvQA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792761156;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=OhtxxY6sB6u5e8lxLgf8VWiEyobE7+yJqs1Ajkjrex4=;
	b=jas3WGEr3/yuPqRFxEADcFtkulwVVhMF0sYmB9/wSCH/NuUjsJco32nSnoiivOVZFHW4
	 DrJch/3ozwiQiqXurcK08yXswTPQ1SOCtGaQqVr+UiVnnsiUVEo5m5c0qi7hVK33mI18H
	 ubt/O0MoBXrZmpekRMszrVoKgLN3YxO7ubRjV7QgmSr5o5pHQ0V6f2cNkL6w3jzaNLtqA
	 phCwHMD7JVIS4jax2czeY4yOYKBeN1d6CSmnb8Teh4pBv0mVvfO2dE0I8DTjGX+dElIJ6
	 pVDiQavIylhs6SIZBVB+7FW9gqV6pRW0mcFKcaVYS9nwU+eMgaqs33Mlg23qD50h9Ug==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=NWOo6+Qt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792761156;
	bh=OhtxxY6sB6u5e8lxLgf8VWiEyobE7+yJqs1Ajkjrex4=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zUA2QzIn6NYr/xSXZNUGROWMke4E4FMbkcpdp22GctHzLQzM8rrlMBGt7dqtqB0XX
	 9vtHN1/Efd/HO7I5asffYpT7OLeylPtqc37r7SNnDwUAT1EgmquGA366u4l283Ijnh
	 BZb0mFN2okKcE9eBtp+taW47YK6yHL40Wuk440kSAtyCkB6AoBiwsuo21VNHmgf6k2
	 oF3carcc0f2cL0xcMQdMg0FeICadZ0n9NyXojoCU9xjx9I4csvjw6Zl+4NjsfT3sNp
	 Fo+I8QoQqB9FkMbaYM02R0/KMWSWweVfYYuOWc3wJXouPpWBnGpw+hNS0sMIUmqo6m
	 O/qQNFvbAqmGw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A84A5606BF;
	Fri, 23 Oct 2026 13:12:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 09DDF235
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 13:12:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E42B2606BF
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 13:12:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HUFoiuRZ1acM for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 13:12:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D9F616069D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52d"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792761151;
 b=U7QJ523mpLpXmNvKHAxaEaUHmI3JP54ezLlet2lczcfPPw/wUSkpWEVrtAWQmchaww3L
 tTtgAXZ0jsfqhnI64I9yrfN3SCYAMI+H5DTdMdqG0gC2Gmx2WO8dGpK0PSQhNScnPV42l
 JAAHVEiFXJcjlJ61yBoF4YVsxyBqflQ2HH7c1c8+LcWCtMClHic1QGATf7HqE/z+M/PEG
 36jJrdJc/a2xshLS0cLBrVy9XZmellz1ISlUi3NWi5jIYQn5sHoLQfFT/hBrXn5ujkVnK
 lcXiZxV6B8PMF9+c2noqJEDiUKbugcw767jiBlENbjelvGXck0XtOgJW0aruCl7JUxw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792761151;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=OhtxxY6sB6u5e8lxLgf8VWiEyobE7+yJqs1Ajkjrex4=;
 b=iA/dDwOVTuLisJRqP7TjuPTYSMmREwrBN0BjBy9RnoZGuwNCUYvgxb9eigpiH/ztsj8M
 EwK/7iFFdNdySPaeZopADkYS+Lz7iYYcP1ahFTqNXDnXcQ7WCX9pphLJamn5FKOwcIVnd
 9N8PP01HYh3H+ZDT3VAiXt7AuJOGoPmwPMPRk+P6GGGtOFEdoPpWcNHLFiw0J807wNyd/
 D6soLNURFypQhkC+K23jUXD5p0WomZZ6nKP1BIZ+PBYsj4Yk8UaO3gNgVtfBtdy6ZJeBI
 0RZuozUpGXsue9qdZejYs65dVIA+kpx9FVRm1iVlDlgZlfx1B/wGJV+gycVasLzkuvg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=NWOo6+Qt; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52d; helo=mail-ed1-x52d.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=NWOo6+Qt
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D9F616069D
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 13:12:30 +0000 (UTC)
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-6ae305e3bd9so1441156a12.0
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 06:12:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792761148; cv=none;
 d=google.com; s=arc-20260327;
 b=UT6b+ulfo427SEtsV25LxuFNGmY/5tjaQJGNJFMIxs3Vc7++SRa4pQfoqcsSC0c2JF
 161LZY1Rm9jrwMcNNyLWVOIDiBqPxEw4f+GE9PVo1Flo1QiwwqFYsNay8ysPHr2hJIwF
 JFmNEJX50Oh3zJ7TL9D0UJY+aeBmPh2hj7w40uU80DvCgK7w57DAtHonFjKibyXETEhK
 lRuSr3w+lz2/Zde1Ipa2tr5glVw2VQtez5ipE+I98Sk3ob1L7Bqi0syIU0YFe6K4euSP
 UC8OiUoZDVAUO0RxmywG/Fr1XXgSiD/rFEv1qrYZxc7Y98KZZDEE9ZU1tcsjtYOJkWJG
 1NQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=OhtxxY6sB6u5e8lxLgf8VWiEyobE7+yJqs1Ajkjrex4=;
 fh=PXm9ue6djbjwq8+KBxeQsHfB33baUaJW43ctaY4bLhs=;
 b=fO35RZJp0NL4cLqMae82AcrzirMWg8NSBevwTZXv2GAcy+tRyP/RewPDOE3bIz8l2c
 0m/aKiobfK6pK8AVxXWo8eDM5/nfwXcHgFAN3XW2wtFhHPPem0u1vmbAiOWMUfVQD7qu
 lWtMfmI4PJ2GoxtVorRceioQJW1siOq8/GB3BfjGnH/8+vMfe6YpSr72NIOE2MGi1s4j
 A/wV529mzMtP+MjN4rXrScykQPB735mX/FcUq7xni0T5dAGImyr6cGc0PHhvRrPSsIiT
 Rskr+x8y7TFTPo6AUKoKxGmMJwmyfAFCehGZbn+IWU2tHgBok8RosUoBQYvwW8pJGjiQ
 N8jw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792761148; x=1793365948;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=OhtxxY6sB6u5e8lxLgf8VWiEyobE7+yJqs1Ajkjrex4=;
 b=NWOo6+QtkkwIh1Gc5MDiuKjOvD1GGtB8H5Z4jTDVtOOlF/8kjI12wTCEAjEtHLLn84
 PlkeV6e9vzFXru94Gk/3XYfzse5ubH/aW5jz+e7qGrzZsgfmD5Icy5+1T9EoFPjgfaqT
 rnIcf7e60NFOI6VK7l3WpHRhUYySsGmCNP/xI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792761148; x=1793365948;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=OhtxxY6sB6u5e8lxLgf8VWiEyobE7+yJqs1Ajkjrex4=;
 b=LDhrFtf32VON4pCiVzjXiJYXaAKXHKn4xKY/O7UO7hhbi41e0ac04ENfSDBJHu/bWe
 TiZe2C3eR2gXPCYJbFhYGQ6202Pwrqfe0apiIAGyTtLzr82/8dZEXEdHOQJFATfIk47+
 8HUdwmXOO1jEkkW+Bq2I0u8Qidg8S3aEmxER+KHgUbkCL3fnqL2i1GiLV0Uww4a/1ooE
 R8DkvJpSvAzxsPocAUD643M91jod/Y2wgNdGcuNSErD7pWXUMFvHy3exXVqGEsgMeqJ3
 YAdVNBJlj8TGAiNUda2L3aX+eF+fnUubOEVH0r9RNuRH1fOigJCbNTv281J8jkIDsTFT
 DuxQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByfbJS3LVbR1ly+2GyduPCcWrM9pWzmpmOH7r90df5MvKqUr8yAEOUyy/P0iE6i77sN+2bckbs=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKpJw3xyRxqZLPC4B9R1sLSJ/8YFHDQzlWRzDIXrfAzHvcQo9Ne
 u2iS8w66G02NAm4sLtnq7XcXf9wuhl1+yc0HNf+RN9nt6V6FOIH48XJ1C8qpizemuAYiIHvz2/B
 e3RT/nsUXqcLhXauQ4mDldGtpdmCpl+JMCzNYNwBl
X-Gm-Gg: AYBFou0uB90F6syATsFO+ru2ut2342feCtkdIQ0AsQ1ebF/kvucMs1KY1/V79+uB3nG
 ho0PRXrxXFV+w50N5E77oN2Ecpkc+1VBcplIbMqTxolFS0PUoed6fGHn74ToEBEEzE8/rVfnUXh
 SQWnSUEGF+ozs3qLYnIUv0oYngGQpmY8nEvEW5T+fn+zZ31tRjj3sTXQS/pBRIqct6CcMh9JLfF
 6/kORfsAGW/wufB+m6qsFRWKRx4M1fbPs8nY/iXHK1UGFz0Scd6hK8TG2PBzZeOWXnDHQchl4wW
 tYCfR//5GJABAoZM4D2Cw4Fgjh9lVu6j4I6YFUwTaQGcd9SSToGriFPWGoGE4AgC407R2LZ+mey
 4mlQihfdpnG4G9EaydrnjAkdnrcCF4+0ToYE=
X-Received: by 2002:a17:907:da7:b0:c44:16ad:c31d with SMTP id
 a640c23a62f3a-c46a9008aefmr340401466b.4.1792761148469; Fri, 23 Oct 2026
 06:12:28 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Oct 2026 09:12:26 -0400
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Oct 2026 11:55:17 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261022194049.670889-3-ansuelsmth@gmail.com>
References: <20261022194049.670889-1-ansuelsmth@gmail.com>
 <20261022194049.670889-3-ansuelsmth@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 23 Oct 2026 09:12:26 -0400
X-Gm-Features: AclHuK-XXLIWwQyULM3hgidNYaI8U7tjwh_AY3UHlgERgV0_ETnza4x1u-WdWSs
Message-ID: <CAFLszTj+sti-+-O9OjMu3YBiq9X8TwEr_UFYXSxb5efHdRgGAQ@mail.gmail.com>
Subject: Re: [PATCH v8 2/7] misc: fs_loader: reorganize and split to FS loader
 and FW UCLASS
To: ansuelsmth@gmail.com
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Heiko Schocher <hs@nabladev.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Alexey Charkov <alchark@flipper.net>, Daniel Golle <daniel@makrotopia.org>, 
 Aristo Chen <aristo.chen@canonical.com>, "Lucien.Jheng" <lucienzx159@gmail.com>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>,
 Casey Connolly <casey.connolly@linaro.org>, 
 Michal Simek <michal.simek@amd.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Johan Jonker <jbx6244@gmail.com>, Anshul Dalal <anshuld@ti.com>, 
 Romain Gantois <romain.gantois@bootlin.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>, 
 Marcello Sylvester Bauer <marcello.bauer@9elements.com>,
 Tan Siewert <tan.siewert@9elements.com>, 
 Peng Fan <peng.fan@nxp.com>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Yao Zi <me@ziyao.cc>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Martin Schwan <m.schwan@phytec.de>,
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
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Christian,

On 2026-10-22T19:40:35, Christian Marangi (Ansuel) <ansuelsmth@gmail.com> wrote:
> misc: fs_loader: reorganize and split to FS loader and FW UCLASS
>
> In preparation to the introduction of variant of the FS loader,
> reorganize and split the driver to generic fw_loader UCLASS and
> specific fs_loader function. Create a dedicated directory for the loader
> and move the internal structs and functions to a dedicated header file.
> While at it also drop some redundant check and rename some variables as we
> are updating the code for the UCLASS rework.
> Doc are renamed and updated to a more generic name and for the new UCLASS.
>
> This will permit to reuse all the property and logic of FS loader
> with container that are not exactly a readable filesystem.
>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
>
>  ...{fs_firmware_loader.rst => firmware_loader.rst} |   6 +-
>  doc/develop/driver-model/index.rst                 |   2 +-
>  drivers/misc/Kconfig                               |   8 +
>  drivers/misc/Makefile                              |   2 +-
>  drivers/misc/fs_loader.c                           | 328 ---------------------
>  drivers/misc/fw_loader/Makefile                    |   4 +
>  drivers/misc/fw_loader/fs_loader.c                 | 176 +++++++++++
>  drivers/misc/fw_loader/fw_loader-uclass.c          | 188 ++++++++++++
>  drivers/misc/fw_loader/internal.h                  |  91 ++++++
>  include/dm/uclass-id.h                             |   2 +-
>  include/fs_loader.h                                |  47 +--
>  include/fw_loader.h                                |  19 ++
>  12 files changed, 494 insertions(+), 379 deletions(-)

> diff --git a/drivers/misc/fw_loader/fs_loader.c b/drivers/misc/fw_loader/fs_loader.c
> @@ -0,0 +1,176 @@
> +	if (plat->phandlepart.phandle) {
> +		struct blk_desc *desc;
> +
> +		ret = generic_fw_loader_get_phandle_desc(plat, &desc);
> +		if (!desc)
> +			debug("%s: No device found\n", __func__);

generic_fw_loader_get_phandle_desc() only sets *desc on success, so if
device_get_global_by_ofnode() or blk_get_by_device() fails, 'desc' is
read uninitialised. Please can you check 'ret' instead, e.g.

   ret = generic_fw_loader_get_phandle_desc(plat, &desc);
   if (ret)
           debug("%s: No device found\n", __func__);
   else
           ret = fs_set_blk_dev_with_part(desc,
                                          plat->phandlepart.partition);

Regards,
Simon
