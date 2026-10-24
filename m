Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F80606A31E
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 13:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=TR3/oBfA;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=hPgCFLmi
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0F15C8195D;
	Sat, 24 Oct 2026 13:04:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eBkjj562Af7y; Sat, 24 Oct 2026 13:04:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 39B71809BD
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792847048;
	b=hihVmzZw3ic66cf4XZYw5J9T7SnYUCPu8Y1NUku+7CpGMi2aPkZxwYYmGDnsrccXF/p1
	 aiolBINyZLX0klek5OxEwFfwHu4R7bRqlE6fnopaFhAhqwMFrR3Q9q4rjPHBMJ+xxVx1+
	 qf0El3TXFtolH7RF1wd/JwgjRm7+Jg6Wma1TiRAGOjTW4R+axNRzfjSxvw1VyIBGOp0yG
	 bG6+aYJjpjNU4PwC58tPyDDGg1K9pF08YBGnDv7hgbx8YrsrAM6RyLM1Q+lRvfiFDJ5u6
	 pIA9zzQMttWpR2y36Dd0ZTlnH2UYG3ukNacxxx7+Ikg2fCaUXvZl96vvAP1QdCza7hg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792847048;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=2FBR81i6UMNwAoDluGv9Gi2Nl6iVrvV5EDO5wUUpWTo=;
	b=N8eAkB+1GXFwVLq51S+R8yjKEftzyrpgVlutVYToIdVCL7aB+AgkGyeqmyLrrLsWbTXO
	 V/+uV8McwDj+oRrDxedpNhGOy1Jvencc4oX20q4/P4qd8b0BLhb4COlbv4u69QF/mrNui
	 j63kLB9KTWeT6ozxOiRUxB64JwivU/T3DzUSRpfXoNM7QkL7qX54I9jo7/ZcNtJz+psR0
	 uROhFkKxiAurch/gGVDNgM374uHOS1KcnzoOuh+hQMyWEf79yvZHJYgNug5cTQhUAvFFi
	 LSmUBWprdDiZR2zn2ecWSmsf74LY/iBwipSy2FEeJOFOSa08ZBFhzQNl+u9cwdySwVg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792847048;
	bh=2FBR81i6UMNwAoDluGv9Gi2Nl6iVrvV5EDO5wUUpWTo=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TR3/oBfARJfEMAKzRVbyRZ6eKPAPHr/sc70hpmg3d7F5e5ubAovB3CIRuvDbt01/F
	 e6e27XkmKheUpr+pISdlUXxwfWsq45dQ4/4sC1/If1bcTcvJrv0prlg6x0dMMFbAtR
	 2rJxiPysk2KlZanF4ydGjPooBdQnm7OA8no/X3L1IODAG6+Oy8TMyZFTQ6W/4LvVa4
	 zDJtNuw61gfiKWAYXD3arPnMj+kXvKjrcGIL7TzjvAmOKuJZ6Z4CKGo1Sb/WAY5/B6
	 3T2Ti8vGFC+DEHRVKy1+kX6MqAqiEJQ9vMIG/cKmFxdoWrcA9OxCnX5qgLxyFIG4UZ
	 kxyySUHg5XRnA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 39B71809BD;
	Sat, 24 Oct 2026 13:04:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1A503765
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 07:02:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0071340ADB
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 07:02:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sCjrAlM5JbKk for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 07:02:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6A05240AB8
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1034"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792825320;
 b=iguLLEJjt+LnXR8meWGPx0zmfA8nTcfHrCUsgaIq01A880laVO7bDKf1sKRvaKjH7Iyq
 v3N0helr9OAUbQBdpyOhJBlF6D0pv/ZzcJcVERc//pRuZovu4cckCchPhCdp+B3JfhaKM
 O+KddXg1nF4MgzmGeymshSMINLvO/2cskia0/0ArUBwz2WDdpFh61DeQ7KkjZSAs0vN20
 eBrNvWsKESa76DrFXF99D9zbRLo+ekjs107E7yl8VI6JGRJFzTD7hhxCrwWNkTRSNerWa
 NWB4F2bj4+KTWmDSRSM7xgx4O5q71Xw3y5pRaZ9f8NbT8Vusz1oQdSHAsepH5NgBHqA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792825320;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=2FBR81i6UMNwAoDluGv9Gi2Nl6iVrvV5EDO5wUUpWTo=;
 b=LH4SUE+3k3PdTsl3Rjcqlky9sCxqinR+e5WVJzq7LidBpUjgwh1YVU1tmKg+cuSBlta6
 QWuAnAw2M3xPWfn0pxkcpCRxN0poL/lpQtdlfcYnI0L/BYcGhAQp0KF6eJ83ad04Vg/gS
 Wq03IQXsRqb07p0wsHI9x+xe2c5QAUlMMwBhS1JH8fgmSZsIlRPjF1i37H5lKBU4729aM
 XMJxIhBQNyMYaE5j6svspYe/SOFON6bcWNuQ5umZ3OnG34x5kX0PjnAKc82QM/EgmZ8vA
 m5LGed1iwFC/rAFTmZIlDAqhiBhHEvUe9nexPq59QE1NVQWE94YSJv/qDPlpwyywjzQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=hPgCFLmi; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::1034"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1034; helo=mail-pj1-x1034.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=hPgCFLmi
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6A05240AB8
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 07:02:00 +0000 (UTC)
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-3ac6794fe45so1298635a91.0
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 00:02:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792825319; cv=none;
 d=google.com; s=arc-20260327;
 b=P5FouyrK6yJ//n09QlQTP3M0rDJHfMuAYPMsyPOBhnjUHPbk4cFdpNvQtnlKbfNymP
 EINeZgpQjGYcZD6FTsp6MWPwBrRTZhR1GwYn2p3Ih5xmjX04xU7JRVtNB7w1qyCbWveB
 otQ6j394MKwSbCpvBU+wH3owMbdmMIlJGpmxC3vBLmYbLK5JSrONg8l5bc09Z8y7j2AQ
 g8Ks7YD8KqgDC7rpBT/HCt1uHmWEop0P4tMEP7e8i6acPhZ18OEI+4U783oizbdiZ15t
 VME0UdizAmuYgtCLVKtUgXb6RY11an9F9iM/UUtUX9J3oWO2hVngC8Mo7fRU6wXFruzC
 Nhog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=2FBR81i6UMNwAoDluGv9Gi2Nl6iVrvV5EDO5wUUpWTo=;
 fh=K3qBHk2ExO+3ijmhm2JLE5PguYt4WNVvCbTK1y2ofoc=;
 b=dXlwFZtP2FkfMMqSW7KAJl4BjrmufT4gS8PvTk10y4xp/R9qlpZI5EdilotF6rXaef
 kM8LUHZlAtiZuSnDpJUSCYyFJ6JtrWVMTAy6tZ3R3g1OsHypSi63ru60F1+kCJzYqjIZ
 MT9lbtXwboweDxVhsKY7T7EbDutWetzVgF3Gep4pylPoRaE9u7L56OHfMTWhp2f16YtR
 BEDqvoSgpiI67oafL2BGKyIBSqeO5wc48WEzVrMUS71wY8vcRpFSS2CwYJ50UTuemYBF
 Irbwym7RBu2uG7llBoCfuiT3MIfAYxwkD/ANPq63ht8cSC2vRRly8QArIF6ft7y+UOcO
 6VHA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792825319; x=1793430119;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=2FBR81i6UMNwAoDluGv9Gi2Nl6iVrvV5EDO5wUUpWTo=;
 b=hPgCFLmildjfow1hhT6NnZ2JkhkaNnj84QgoExHrPi6sdwldPimO98usAnbDn3I0eM
 b6YHvgDrfr4jH6EO9Daa+2nMErcSLDMbvV3da47F/R7ZEbEQL/VZmBoaFk48Lq74LEiy
 mSwmMgKDKZG8WKUIBVmbt5PiccGkFkSFdLezM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792825319; x=1793430119;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=2FBR81i6UMNwAoDluGv9Gi2Nl6iVrvV5EDO5wUUpWTo=;
 b=MA06zYNo+2HyZYPtIZfLSJkGRAnCWZatWBOG0l9K3Fc1P6iukhC3aOww8NUqaM/6AK
 eOwR0jyx5Z5IaMg9q+kTSjlkhISbd9l3FL46a3ydEAaEHyOHxyHIPrGp/E4W0dxtq0KJ
 dXEFI8rGAGXyyuy227WlJi1hNTLo5p5i6k4K/xIZl52tiiuyIaAk2TvArHkc6iNx2FV1
 KFaDEDeH7AXzCtO6PvcvzFodlIzFikRHwUzpj2ZsBnDm+9R+JPhjzHp2d7L3/B+yAn+Y
 JZ0cmQgyLMdHfnl6coBLsCYHhoqJJAWz+HSEV+c/eUptkDfDR6GjO04nBOuLTvwcV4n4
 qwZQ==
X-Gm-Message-State: AFq9FYJsxwPsZn0+RL+bednuqTUDMGgAxZibsmHBfGUiXl+29jsrbT66
 sHjrdO1fgdb9DfEzAFRqCY94lT7l5k1Kc1Bi6lJFAtOK8T8qjmVNyxYTLzb9to6ywny003dLjZF
 L1k/ZINmPoxumNjuH5UYEamphkWb8IVq5Q0sUa8in
X-Gm-Gg: AYBFou0dv0ZdIcNa6V9n3qoRTWjaSnLGHzM3TnUn8sIN7ao0Dt/GlbOKMcO36owMf3O
 RxjG/U3WuBeCNRu8AazZOwVzj33ITiFssIOVvBiLZ7+p1HFFTVxlGi6gGPoeIZKB+XtHlYmz3OU
 I4HaoRHqYxUD9shK7VdLcGjPk4N8V0bcgvxMNsBpT+tK6JrPH2ieRbYFroSwbzzHlLsVhXtRu9J
 A0/OXaRbjDFQ7lStg6ow+fCxEgO6bO8Nl3rhyqrcAHKKIjb6VxmjdOwoTfayC8TzJkn0NjaMk6O
 m4W1y16PvBLQli+sD5Hi/+IIZYJS9EseidbY8gnLtnGKELc7ZUZ/vNb5q05UYKP/zcO5zsrZ4pb
 sWhF+vqvCixumFoAZVoPxalR+cdzw/dJHH6c=
X-Received: by 2002:a17:90b:3c03:b0:3ab:e588:c2a8 with SMTP id
 98e67ed59e1d1-3adeafc7dc7mr1176071a91.64.1792825314725; Sat, 24 Oct 2026
 00:01:54 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 24 Oct 2026 00:01:51 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Oct 2026 12:16:35 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261020-spl-fit-compression-v3-15-6647aa23ade5@flipper.net>
References: <20261020-spl-fit-compression-v3-0-6647aa23ade5@flipper.net>
 <20261020-spl-fit-compression-v3-15-6647aa23ade5@flipper.net>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 24 Oct 2026 00:01:51 -0700
X-Gm-Features: AclHuK86-IbM53oP5xhG7E-78a5ue1jEWErXu_EAvbZG5JcBdYJo0Y_UAOwSxMI
Message-ID: <CAFLszTicUekN7HHRAyXu0KzmtATNLjyKhb7SajjpxNsukLm2xg@mail.gmail.com>
Subject: Re: [PATCH v3 15/23] test: spl: Cover FIT image decompression with
 gzip
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
> test: spl: Cover FIT image decompression with gzip
>
> sandbox_spl does not enable CONFIG_SPL_GZIP, so load_simple_fit() has
> no gzip coverage either.
>
> Enable it and add FIT_INTERNAL_GZIP and FIT_EXTERNAL_GZIP the same way
> as the LZMA and zstd pairs, registered for the NOR loader.
>
> The blob is generate_data() output for the seed "gzip", compressed
> with:
>
>   gzip -9n -c plain.bin    (gzip 1.14)
>
> -n keeps the timestamp and file name out of the header so the blob is
> reproducible.
>
> Signed-off-by: Cole Munz <Munzzyy1@proton.me>
> [alchark: pick the blob by the IH_COMP_* image_compression() now returns,
> check for gzip the way image_supported() now checks for lzma, and keep
> the algorithms in alphabetical order]
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
>
>  configs/sandbox_spl_defconfig |   1 +
>  include/test/spl.h            |  10 ++
>  test/image/spl_load.c         | 360 ++++++++++++++++++++++++++++++++++++++++++
>  test/image/spl_load_nor.c     |   2 +
>  4 files changed, 373 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
