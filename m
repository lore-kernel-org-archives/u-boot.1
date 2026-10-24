Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C64606A327
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 13:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=yOmuoT85;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=mNs/RDDp
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 74D3C60A98;
	Sat, 24 Oct 2026 13:03:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DrcJp2AM_zOz; Sat, 24 Oct 2026 13:03:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9846160608
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792847027;
	b=cOnAqYLKi4ZN4zOkk8WBtjmYP24NGYabINQU3UACW86gz5i/S/rq8/NDrb2CzNbnjzVg
	 RR5Qhqp+p/7vaiJWN0tYlQpW2Wo8rwq8mPgr00QueCSRum88v9sSJdFqbB9Xuj+zSl6WG
	 88xr6Hye5yiMtYY/FrLBVKzyf3fv1pi4s4/tAALbodDi0pHSr6yNEhEP94htqqQ1wn27h
	 5gHn2pUKOjY43DGLecz4ZWLPALIItlhzZUAHZeFoCwHjjR8DW3OGqWK7b47bH2ODuLy3J
	 OsmxZwRaAUsAcvAe5fHaLNk6FMX2qI6zM3gSl1I9TALz4TF8We8yVS+9ti9ZcuMw06w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792847027;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=zQJ9W9tP910bEhFtt2l1ksJsV0/XXTV69qdbmdfi+q8=;
	b=UMXIf0t6rMH936keAs20ufbiLUDTKNLdInD9vajxr4HBSEwiBZG10lFq1ZrFpuGDh79Z
	 8Md+G0RU/+jsnNCIDzWUpJ97IeiIiki5IYBZtVjjQ9RX/30kCOwmSjhPWlyvKrNn/AJFO
	 hvqppVhCeWw9rTTO7xdJFZn3sADSIdLc1+P+sLK5WsjgB5xzSVIK21smkLbK7s2fKG7BO
	 0OE2FihBZRFdkdMYBTveISlDqm2e4oentRXQoTXR8F9bAckmyTLmg5ZOqf34oCBBjGgrc
	 htIcFSgvyNU147gXU98dZfTT65emdEpk6Ls0vm1xhl2voufKBWSUq2ULLm7As9+nA1Q==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b="mNs/RDDp";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792847027;
	bh=zQJ9W9tP910bEhFtt2l1ksJsV0/XXTV69qdbmdfi+q8=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yOmuoT85gjYYefMlaSU4JFtFckGQriGezqGnXbPN6/UbonLHBr2aay20igyHULMlo
	 BONV7kxwLAZ8518oMZSfkVIZ8kCSkna3JggD7Rj6htWVVdcvacFfgQs2Aqf4JHQIIP
	 lsv2ROKnTA4HqMkOkVH7+vHvlB2ZAZ6j/x/s/3lIsMFQcJwOqCxV0rQQvfGoUhPz9n
	 fqGS0pJLHIRDxMb7Zra0rfw2u/LX00Cg2EEEiB02CXqHiUdmlsfItioL6eLFIQHBE4
	 HG87LYD5irZ0ZZcSBBR4oH4q4JYozLczFDd5kaVzaTffsinGXEm803D64pZ0X4DVcA
	 ehFw4oeUgz6dQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9846160608;
	Sat, 24 Oct 2026 13:03:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 48355235
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 07:00:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3A67560A6F
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 07:00:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iNXvfte_hGRP for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 07:00:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 589F560A59
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::532"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792825236;
 b=DszB48JTu3IIn7oekvDCW2/cSod/tGaz2Zy1WcnPne7B51zFot7olKl16jFPuK54HQxH
 sg5rbdxpUZPWip3uAU0tYVyD65N+DNq16PnpjDIFB6CsvjLTeGeASwiGEro5bylTPhpR7
 DHt8Jx3GWFTW+sjGbsvEXB1gP7sxJHQuGkmhTWa0VHcCyviXAvKdMTZ/B0zqYNaeoNcgV
 odNgdf/xTVf78jxd/UtWajkqNoAec2+ZBsAqrDikVgkVdjqYcWQHNyNWQZTQymGGa/vW9
 vzQQ6xQkAU5941rDNJr+MyxxDO6MBHAO2ekSSMSfgY/FMUnL6u91pdtZCfUontwwoJw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792825236;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=zQJ9W9tP910bEhFtt2l1ksJsV0/XXTV69qdbmdfi+q8=;
 b=oJCHy0gPij9c3JcbynQJnQlAJaZYJBDTCmo2fuZpBnq9GDqpHAtiWzrLWUpzg3uAvt6e
 kRfQs3PKyGc4t+iYf1HyRK9RybcVE7PnjGhf1naqQP+VnGPgVzM4uA5kMPQyN2FIrgQF6
 fOk9ZT0zZGgZnli1JD3BIS3PacPWp/qrVP/5SCETMizAZGktoxE5XlPM4LUszw1hHLfAC
 EmOAin7VMM7GTvYL/j5xqZfAtf+sg3kwzB5p91Lh/CkMaRsVMcqJIngSBJhRXWd0zvYVv
 UxWlPptqAvU1gIbKA+v2SvevmroiPPBIYEz6nLUfjUIs2G4cxk4Y/fgVgawjdGuztHQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b="mNs/RDDp"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::532"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::532; helo=mail-ed1-x532.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=mNs/RDDp
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 589F560A59
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 07:00:36 +0000 (UTC)
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-6b429f71dbeso1441305a12.1
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 00:00:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792825234; cv=none;
 d=google.com; s=arc-20260327;
 b=eWJwcCBXq0HkwAxcE6i+MFhRaLLdX6/YqW6WDxCUexPFRV5htGj/QUcnP/ioMObsvH
 jExSiOVYSN93t5s2W8dlois77b+2QDMFfZnho/6Uy7p4L0x/BjvxSz8FUw3EMPu5rG2j
 IR04YPyKCEGzq47JJQrS1ZxLSZNF0CcydqaE5dIr9+1eB6tYxR2vjePhMbQp2Sw0JIlr
 Hx8J3h9rIfCBS75KLiI2yIVdWJTAfMd/O7twDIhXGRFJN4Jz17oyz2PCyiEuWYtCXiiH
 j4Ci/+/YYkJWYQTdMwjS93K4120Q6L49K9s5IEevq5SvqlkszWTpHse1DvgbP/AtKPUx
 /urw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=zQJ9W9tP910bEhFtt2l1ksJsV0/XXTV69qdbmdfi+q8=;
 fh=K3qBHk2ExO+3ijmhm2JLE5PguYt4WNVvCbTK1y2ofoc=;
 b=gzCTjnFbX1syimG3WkaFjDybqBRDyId46hKzoCc3rxoEsrpx/Ry7GpPTbDCaJ965pc
 WxORTEFr4RQAJUCj9EbIZ24bn4nNn8NVIKzwD6A4h9z4ZIFpFIw+1S5d9uUbc6N/592P
 sidQP64D6N4eTAV2EhQuQmdpeMHln241GrhGDPoJh4BskCz8O69iuGYRzXXsmuLOXXqp
 3RxpJOAhYwOzu+1kUHG/mNHRb7whkq5rHFRxdQv3ag8IMfX5rnZQtD4GlFkBeza9hBY3
 /yoqU58I/J125MfwvGnWemINouGCYQz5Jgz4MZzGLAx6b2nAA2ddkDhMlWc4FYyVpXvV
 9Vaw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792825234; x=1793430034;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=zQJ9W9tP910bEhFtt2l1ksJsV0/XXTV69qdbmdfi+q8=;
 b=mNs/RDDpLnlkCvUh4VzH9XimeBicx7L96W0iZrvMOqYw7yAUCJvHrCCWos4Xi+i5vG
 TyxMyx9Ba6vpXVgjGXJZlGw+VZvpsNHblbhh2pkxxFeMbgEUsUKyH74/2T8iLG772ygV
 TDoIiXLFGE7Z9QNKGq4qyGQTAOVlDgOPqG31U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792825234; x=1793430034;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=zQJ9W9tP910bEhFtt2l1ksJsV0/XXTV69qdbmdfi+q8=;
 b=EjSTx+tk7DrRZPkiZyV8AkD7ni3sKKe9yemQptYqg7TSGewZrJF8dktsPHRy9VgV+J
 Qm6PwufTUuCE4gpTi5GEm3w2tSiD3ke8rc7ANHX0y7riekfN5heC8QK4H/zuiOQPyka/
 faViLWMlMj40FG0YvF7MkYFm1rBOid9Ncv3uCKKnwQrzE1a2l0S3NkA8/iwrgFUOvDYr
 GRAurUA1y2/cR5Kd9MUbJq1HRstZe484hgAHolH/mnd4eh2OAddSpz0XEF/l35TI1k7Y
 MFH3rTJgyxHHl/G73Z1aAzKRJna2dQwJQIF/PdWQ2WBl4otz+K7v8SSoDfTZIQ80njWB
 Uz9w==
X-Gm-Message-State: AFq9FYLUiPcRO0ckYP0lI8L9UIUicyFtVAKlWL8XCb07X0/tlNMns9xG
 4sQMg4FBQzfDD1sW1uOM/e40umJ/hSz7Dog5zBv2d9M7k9CuKF+lKbS7i0+t76TX1UhFjjSPYdu
 2q0BFGlEe16CJf6jNdr4mpuHk0xdQgCgZkUfyeVNs
X-Gm-Gg: AYBFou1lfa1+kB/0IymMrNpcC09kpIQvaasJOkkPyop6CIifU256Tb0BxlDOrtoCScy
 FPRuBMNoc+/I1f76y7TC7QMBdvAcw+dIY8iNwGnAt9sN5BceBOWR21n84g4wjBAmITICivbRxJX
 35MQyl3BJYXV2sP9g+Yr0zBH7fn/Cg7B/pQDf/hf1H9d7sSwPz8XmX0iDoj69zyLRCx+IDEMEEU
 9pcBuEzuw8DW9JbmpKHI67sY2dKKuWVXC1v2aUvew5oRE8oz6T0F0eG8l1J09p90c7eXb4QQAW4
 +nAMuUZxUkYVYoVIApmb4PCfR9+XN0A/SUClG3lSIJxe9COMu30Q6vs5GD/QTwBGPkeoRJ66PSo
 NW7XbSedNmKyhHawDjZyVXy+zsh5v2g9yBcI=
X-Received: by 2002:a05:6402:42c5:b0:6b3:9b66:2bbc with SMTP id
 4fb4d7f45d1cf-6b44300dcbamr1786503a12.32.1792825234105; Sat, 24 Oct 2026
 00:00:34 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 24 Oct 2026 00:00:30 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Oct 2026 08:16:33 -0400
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261020-spl-fit-compression-v3-13-6647aa23ade5@flipper.net>
References: <20261020-spl-fit-compression-v3-0-6647aa23ade5@flipper.net>
 <20261020-spl-fit-compression-v3-13-6647aa23ade5@flipper.net>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 24 Oct 2026 00:00:30 -0700
X-Gm-Features: AclHuK88ixTuMudOtLXWgtuenQ8ILbVxYdLTOTxN1vy9AubE4oFQ_VWNhhMkHnA
Message-ID: <CAFLszTgsaZyXrNkvus9i9ivGeaOeDZNbjcO-ZkHyWMLZhBKdMg@mail.gmail.com>
Subject: Re: [PATCH v3 13/23] sandbox: spl: Enable zstd
To: alchark@flipper.net
Cc: u-boot@lists.u-boot-project.org, Sean Anderson <seanga2@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Vincent Jardin <vjardin@free.fr>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Michael Srba <Michael.Srba@seznam.cz>, 
 Cole Munz <Munzzyy1@proton.me>, Simon Glass <sjg@chromium.org>, 
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 =?UTF-8?Q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>, 
 Richard Genoud <richard.genoud@bootlin.com>,
 Daniel Golle <daniel@makrotopia.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, Quentin Schulz <u-boot@0leil.net>, 
 Kever Yang <kever.yang@rock-chips.com>, Johan Jonker <jbx6244@gmail.com>, 
 Max Merchel <max.merchel@ew.tq-group.com>, u-boot@ew.tq-group.com, 
 Petr Hodina <petr.hodina@protonmail.com>, Bruno Banelli <bbanelli@gmail.com>, 
 Carlo Caione <ccaione@baylibre.com>, Peng Fan <peng.fan@nxp.com>, 
 Marek Vasut <marex@nabladev.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Jonas Karlman <jonas@kwiboo.se>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sat, 24 Oct 2026 13:03:24 +0000
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-20T16:40:47, Alexey Charkov <alchark@flipper.net> wrote:
> sandbox: spl: Enable zstd
>
> Nothing in the tree had SPL_ZSTD set, so nothing noticed that it could
> not link. Turn it on where the SPL FIT loader is exercised, so a build
> says so next time.
>
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
>
>  configs/sandbox_spl_defconfig | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
