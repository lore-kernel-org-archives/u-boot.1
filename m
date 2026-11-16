Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AC4606A31C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 12:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=UBiNS9fv;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=pCs6BCyp
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 92F7080EF4;
	Mon, 16 Nov 2026 12:55:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9xOonsJsVRjL; Mon, 16 Nov 2026 12:55:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9346280EF1
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794833717;
	b=nwaLr6Jz5RcrHYQ+EI/bXfItzqL4rvo4fCeGqOY2PQZCFxlUdZi1Q6LqcgFasXInl36X
	 BaopP3rCjmKTAyzXQQa7tgcfEaH4HyvYXbGvKm6qnp1lbbZy4wSGvi9G6tdRgZtg0NEU6
	 Uxs8UKyigNhyP7j1Q+/fQynCoCKkDgL2xUj6gw8ITjtv9CrJjt/TYgPT+zsRbA14jsb0j
	 R3DP6atWzg29fK3Z+TbHQmJsM4KsImN3ZqiMdZTg3SfWyUuT0C59z8pbdwQi0vWcKECZm
	 VEC3h0nswrwPirt4MkijhUiJ1FTp7Szr3FY+Zf8Sy2FucdVRwIQsYiwdMAnZo0bb2Eg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794833717;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=sritPCNMN5n/lN2VWuCzRZANGqysWlquIWzKal8rJbI=;
	b=ScA5Del8Gfa1l81BzaTbDmA7YQyx0Pl4Yw/ZpafXuRJ3LLCO4LJ/GwirFfEC1kXSQoLy
	 pzj5dsbruY1+NFvLnCJE331mSgNL4g8nzfJfbN6kPujtVGznZA94k+N8nGDNdA1gbJsQy
	 Xfw4o/SYgE824vGegBj3iv7RdPrmhsHdL0QM3Apa6bp7V82zGuZYs3y7q1R22jKmMLgMt
	 oFCg5oDoazjYBAZNn48MujJDqs15uTJ+L/cV6OobggOkxh6iAwSAgqye5Z6Cb5guaorB4
	 L/UddspGIdXXX0C/ymmJokLQa0cielLGcX2dv2mu1SswxYelU9+kipAmeOLT65x0JZA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794833717;
	bh=sritPCNMN5n/lN2VWuCzRZANGqysWlquIWzKal8rJbI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UBiNS9fv+cJ9nXJCjR/9WVCQEAlADmYydS6mmTeQYBiVM+JHWRfOiG1A4o9hyqWN2
	 1tUQe6QdqXFAekFfvlSilwFrx2tr8zrA98IqEYeulnvDEGq6teHUjY3dWF4WzOCR+N
	 +UKX8Dim3MbdZsXN85AJqN9Lr5woxuQFh2Nfph4rDOodI+Iuv2hWbx7U8wDy1pEk9K
	 c/Fv/zN7+Tss5TIeP0hK56hFgfeyrsL3A19R8n452gl/kQSlW5jpMQANhDwOdjOXru
	 evNqPcFXSDqUxFXG9I4pCNHZW5AEV2EqCFKdqDs1mv+s7Gr/uXjSWjY/CQlTU394e/
	 2w6c4oIhjwkZQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9346280EF1;
	Mon, 16 Nov 2026 12:55:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9CE9A1E7
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 12:55:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8305740588
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 12:55:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OfNlyW0iQbbI for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 12:55:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B283D4057B
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::530"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::530; helo=mail-ed1-x530.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=pCs6BCyp
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B283D4057B
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 12:55:13 +0000 (UTC)
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-6b56221d361so5300669a12.3
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 04:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794833712; x=1795438512;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=sritPCNMN5n/lN2VWuCzRZANGqysWlquIWzKal8rJbI=;
 b=pCs6BCypFDtE8kX0j3EQi9hF1OpSDbHrKLtHydcemPhyXaM+h/MFIoCP8d/aC2Ha+1
 aaTNo5R7IbAJU1ggWiGCwjLxvmCW079726OBWLBi9brBU+pHOkEiGsW1mFqIrDXvH/em
 yJ6yvZ8iQpyyJL0ECTYOz8CkCo/g2eO0jimkBgwIE5ceqXvP7RVHpj7AshFyIMOF1rEG
 HVgb42tzgYpCxucDV0J9HZVfYzrjC2gHRhFe80Ppq8C8elT0yQL8ysCAHalJwQv5J1MB
 7b2tLPVWfvH++047Mx2ngLMlReGDMartoc0DX/dy+ZTWBBMrr+6mIqZxU9AkO5nsQTQu
 kTlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794833712; x=1795438512;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=sritPCNMN5n/lN2VWuCzRZANGqysWlquIWzKal8rJbI=;
 b=rxw7rohIDV8xr9xFNXR5fV2fEv4cmAXNtlzRD6cLfmM+6i1cjpqxNHukxRrJ2j/rlc
 x+wZmCSR4pLgY6QxxjREicHAaG3QFeptBi2PWzb+40U3O+YCGeufGLAYOmpGh+4j4wgv
 Ttgb5q31pNanHS2ETHEqw8XYdVBgeuFudVwnJ2YEYTdfPj77fAJS53oSOGQn/EYZB/Se
 Njm+RcpDv+pnTIS156ODC0lXpkmoXxGoCERI/ifQP3pahBmCiYzefq5bQXcpbouZsgTt
 3MHgYOxeyCjURbgEfHn91YuwbSn0szG/Y4jqvjGlUVzIBKUkBwpkkGNmK3NC07M+CGkF
 zyBA==
X-Forwarded-Encrypted: i=1;
 AL+hErFOxI7RyylaQVqorxu/0PXCjkc4sgOx0duSHgR3z7IEBYKutY9xz+2xzn911xhNyyB4ucuvFJk=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z93qqR3JEd7Pk1Pc3YmgqEzDYzvGo0ZZ3dECehm9LVGdg5GPzIe
 a1apBTh//V8z05wEa4HRd9bJI9fFEKLSkZk6EETq7xkoQStRm6C2qXjM3EBK5kr9tto=
X-Gm-Gg: AYBFou0qlIkCZyp9sjsv+ynSeFRIH0Edk4WzIIuJd3M7NV5aMFJisWHUADhklOgKRsD
 Mqzy7C1UBdt0nG1M49XXVdIkEg5T5Ne2ldp1ky7caZ6OJIyaxhrQUDxLL9WhC6SV2DIgheSmfI5
 Ph/utR4fuV3PCnSOt5J8vBs3M4exVQ96c2woWJjiAIm35G/tuFiKzrKvBgTWnI8hGHmzgeiAgKc
 +Cx8HqHgy0S+9WqE5+y9zZ9LYe9oI4KuG2cHAvNUAKesL82DOMrnfDpnfzxuytJ5NTcLoXncNKL
 pIgVSRIqjBFR3OQd6nyYDX9IB4JnJT5tmUITZY83jnKm+tZY66+Fui6dP4S156mTbkPs96gDZLX
 i70jQWswSXofApblfOCllkmZYv3HQwWT0dPiNywhZelrc2F4mEyA23iG4/NGnLmtGTySR13th0S
 THKz/16keIaeSdgh6xHkIYFJVlKOfutFbOuqhgwEvb0ECwasxgowlqlXLUpD+ByzyNqBJWxAePD
 tpQjvtiSsClCVKBAoewSI3t1J8QBUN4e4bDmR/4zTOiXAtvb/bNI3fyRz0hheqvOaBgqR9IDjro
 ASbVEzN5yXpq5RC5uLeOc/XmIl8HEqyN5328v/JadUNr9FINCFeN5aL3E53ZqDniRJyNaabhMCC
 wAMj2W4tkSTDSD0TiaZXNvtd8WUuHXN9xAKw=
X-Received: by 2002:a05:6402:2115:b0:6b7:793a:2d78 with SMTP id
 4fb4d7f45d1cf-6b7c0952d30mr7877719a12.15.1794833712023; 
 Mon, 16 Nov 2026 04:55:12 -0800 (PST)
Received: from macbook (host-95-246-144-141.retail.telecomitalia.it.
 [95.246.144.141]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b7c23dde49sm4771790a12.23.2026.11.16.04.55.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 04:55:11 -0800 (PST)
Date: Mon, 16 Nov 2026 13:55:10 +0100
From: Carlo Caione <ccaione@baylibre.com>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: York Sun <york.sun@nxp.com>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, u-boot@lists.u-boot-project.org, 
 Sebastian Siewior <bigeasy@linutronix.de>, Rob Herring <robh@kernel.org>,
 Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Francesco Valla <francesco@valla.it>, 
 Anton Ivanov <anton@binarly.io>, Aristo Chen <aristo.chen@canonical.com>, 
 Petr Hodina <petr.hodina@protonmail.com>,
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>, 
 Guillaume La Roque <glaroque@baylibre.com>,
 Lukasz Majewski <lukma@nabladev.com>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marex@nabladev.com>, Michal Simek <michal.simek@amd.com>,
 Peng Fan <peng.fan@nxp.com>, 
 Daniel Golle <daniel@makrotopia.org>, Sam Day <me@samcday.com>,
 Pengpeng Hou <pengpeng@iscas.ac.cn>, Alexey Charkov <alchark@flipper.net>
Subject: Re: [PATCH v2 0/7] Support fastboot boot in SPL
Message-ID: <avr9DX4apWNryHVi@macbook>
References: <20261104-ccaione-upstream-spl-fastboot-boot-v2-0-cf9781441ed5@baylibre.com>
 <179458689495.70612.1391691837782870153.b4-ty@b4>
 <xhkdbld6tqcto.fsf@mkorpers-koolstof.csb>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xhkdbld6tqcto.fsf@mkorpers-koolstof.csb>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 16, 2026 at 11:40:19 +0100, Mattijs Korpershoek wrote:
> Hi Carlo,
> 
> On Fri, Nov 13, 2026 at 17:21, Mattijs Korpershoek <mkorpershoek@kernel.org> wrote:
> 
> > Hi,
> >
> > On Wed, 04 Nov 2026 10:40:20 +0100, Carlo Caione wrote:
> >> Support fastboot boot in SPL
> >> 
> >> Test farms need to run successive U-Boot builds without rewriting boot
> >> storage. Add optional fastboot boot support to SPL so an already-running
> >> SPL can receive U-Boot over USB and hand off to it in RAM. U-Boot proper can
> >> then load the operating system using its usual boot methods.
> >> 
> >> [...]
> >
> > Thanks, Applied to https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu (u-boot-dfu-next)
> >
> > [1/7] spl: fit: reject failures loading an explicitly requested FDT
> >       https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/1a3297db459c3baebdd7d51a7b6e740d3e29816e
> > [2/7] fastboot: invalidate stale and incomplete downloads
> >       https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/6abd0cfcf58db69fad1130a8b4b1c3584b2f7de4
> > [3/7] usb: gadget: fastboot: do not boot after a failed acknowledgment
> >       https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/72e4069217d76b4d358f561dd2c8160acf0fe485
> > [4/7] spl: ram: allow loading FIT images from a supplied buffer
> >       https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/154c4246d60a2012d5fb23920fd1e77e7159ea55
> > [5/7] spl: support booting FIT images downloaded with fastboot
> >       https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/fddc8df36f5219e3742e3b8eb3a9b0f21c30b315
> > [6/7] spl: fastboot: support legacy U-Boot images
> >       https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/02172ea8e838e9a3a00b30bf7f868d5b273af173
> > [7/7] spl: fastboot: support raw U-Boot images
> >       https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/4dce3b1e0e17625ed73f37784433c54da4cd719c
> 
> This series seems to introduce some build errors in the CI:
> 
> Building current source for 1 boards (1 thread, 112 jobs per thread)
>    sandbox:  +   sandbox_spl
> +common/spl/spl_ram.c:109:12: error: ‘spl_ram_load_image’ defined but not used [-Werror=unused-function]
> +  109 | static int spl_ram_load_image(struct spl_image_info *spl_image,
> +      |            ^~~~~~~~~~~~~~~~~~
> +cc1: all warnings being treated as errors
> +make[3]: *** [scripts/Makefile.build:272: spl/common/spl/spl_ram.o] Error 1
> +make[2]: *** [scripts/Makefile.xpl:553: spl/common/spl] Error 2
> +make[1]: *** [Makefile:2452: spl/u-boot-spl] Error 2
> +make: *** [Makefile:179: __sub-make] Error 2
>     0    0    1 /1              sandbox_spl
> Completed: 1 total built, 1 newly), duration 0:00:34, rate 0.03
> 
> Link:
> https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/jobs/146829
> 
> Can you please fix this and send a v3 ?

Oops, yes, I'll fix this and send a V3.

Thanks,

--
Carlo Caione
