Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E14606A319
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 17:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=o+Ea5NhW;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=PWAdufSO
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0EB89407C4;
	Tue, 20 Oct 2026 17:59:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qnolotFQoAVr; Tue, 20 Oct 2026 17:59:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1FE25406F5
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792519188;
	b=R15/8HaURv5yvW0M0vYdJ+CNW8RBCoINXSjgzykXRD3wVCpNgWiBNSIkH5WJ1NVfM5y0
	 vnRl14T7kLgkClQ7eBtsToF6Kz7crQuYuprTy1RgIa5a+cqwbQk3mgyootd55mGdZxa9Y
	 jBa+7K99OmF2/JkA+9uJa+Gyq6+slY/eitUZueafxkNi8Gxo/6u31iaabDkx6IxaLDXdd
	 1nyR+thCldbtrqXHYaky6NHJr37doMaIONAU+HB4ElCJESm2MezRqqsQdRlKAmuY6Lg/G
	 Hwub0GA+7vO06JJnp+S1uqo0xcdg2csINy+Bm8/toMs/gPlWd6c5iNko90zZn1WPXQA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792519188;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Z0XhREEwSWA8NoA198zv/gliwvbyLlcpQrnwqnkY6J8=;
	b=Q/epoHYzA5y5QMekhxo7bNE9kEk9/5FApryQQFAlOqywEABoBWHWtHWDK8pGCymvVgF2
	 ksSJqWZYSxInS1rV0bcWy3oJb9mn6yLO4piUjjp8Vd0xWv556noKaC+Bqb9JK6dBnciwh
	 wQ6MOUAvY5SVScOEfij24toD9UscTJB90unI/hInM4nHtrWISlcvxDSKTJv0dcCuT5gnh
	 K1pBh3sLsN+Z2QqMpo/J6XhrwXHO2J7jCZUDypnIfHX9s5iOhY7vVKYwj5cmiwJ6EQ+aA
	 F9iAvNIjyDi0JcD1w8qu//VZSZd82AHqdl3uiPWCXXrc+DX6/EYwY6Y1Q5jY8wJv0cg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=PWAdufSO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792519188;
	bh=Z0XhREEwSWA8NoA198zv/gliwvbyLlcpQrnwqnkY6J8=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=o+Ea5NhWdQ+89hQkme+yDpr/mle3DZEGm4A676zTqdBr4Q+e6oL3phnB99zlyT+fi
	 Cw7nYupWbo80wGJOYz6nff80IMzwXEDPo2c5oVRB4yN84G391HcuU2KTthwZ/+IjD3
	 aCLjen3LehOPmGKp2AElHwexZe+3rLrgwYsFF3P60hsXpS9pVcWIt3m4oSVatFqnZK
	 xAE51MS/o1yiPj2zqBo4HeBSUJnxNwODOyHyZoSJ5ntYpf0TijGCPSdjPiUl0TFNj6
	 UISHGbqF3zfSC8dQICGEnlGsx9ugebUAHZbtkeCc98K27B32Y4pw4oeHyP9tMR4xvc
	 XT5JQ9K7a3k8w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1FE25406F5;
	Tue, 20 Oct 2026 17:59:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 605AB2E0
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 17:59:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5D6D4406F5
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 17:59:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EoGf5rJsGf5j for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 17:59:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2E567406EC
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::531"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792519185;
 b=OPRphHnk1K1c6GzGb9ZM7l/QiP5G7DjE7dyXJ/jMIVGwVrkL2HrmE2ZogMluU/F93044
 V3qbLVtW+noB7uHLyfx37UBs9PxMq1pgAK37lixaSIxBTya/V2CJ6L98VzXc/77olLx4v
 MrQDJWH1HB2Wcuf5nCM7qGsBRTxEwNem41OzGycqTer5pT3w22Y3GA4ylvrqooiZQuSKJ
 cRngpHKOZYcZe6WXmPhD64ad6X+hfaAbxf3bnSrWlHK5hXiPJW77/QifRslsaRQNUkcx3
 loZpoLQh6W8DUEI7egYEqDHRcVFtJ8b0aGfYNK/pbJY+tAFOuZpqQvSjad/QH3CDPhA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792519185;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=Z0XhREEwSWA8NoA198zv/gliwvbyLlcpQrnwqnkY6J8=;
 b=PdcczEJxA1yi63evwrcqpSLAr/mi8d1eht3b3fyTSrxBkzgGYuvyYuiFGeXMD8MtatJI
 Z9zGc74gbyFGJGQF0isy3tGInQaKjNDwgQjoFYsFSlWVwdJ4stvWie1N+om/5N0xfmqmO
 wD/kXq+zTQY1qVe0NYqHOTKSxLrbkuv4TqTOnStz0qqNo9FxWUUPK8ZOhyQMLf8P/ApAE
 ppYKJi3mJYnTktHJnSpXVI6pZbivksYHaYuMYMbfr0I71gLninRqq5BM9jH41m9H1wEO+
 3AkJVfReDRg7iU8dpLvX/s+EGXwW0vKofN3v4g616BwRKlgLocYm3HU0LArxFP+GFSQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=PWAdufSO; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::531"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::531; helo=mail-ed1-x531.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=PWAdufSO
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2E567406EC
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 17:59:44 +0000 (UTC)
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-6b2237b596cso4901829a12.0
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 10:59:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792519183; cv=none;
 d=google.com; s=arc-20260327;
 b=newRfuTNkarroNxinOQICle7tN51/GORl0YTjePemyNxES+fgIJKgYSbVTpf0NC5OK
 KQ4TaZPjWz2rzbNNfkyf2yEmyL3g7S6htoxPd4+8MaFqECrFTsb/zPN+oR9pi3Ta0vgo
 obI7O+KORM5VWQ0K4KAww460QchDUm1R2U1xeod0EbtYESEBTnMbJubcsFzRSv6afPtz
 meHrKbNlGcKl5XfhhmUdXA9amCKme1CDiDzFQQQyqw1pkLitQuGpn6lTXBwu+m4aktaq
 TTVQNIdXgGBwfdwpu6lQF9/hdHqv1VXYQlcDU3GDjwWprqhxvhKEWEiEc8PxWkYIl415
 /3yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=Z0XhREEwSWA8NoA198zv/gliwvbyLlcpQrnwqnkY6J8=;
 fh=Z98iJJAqvw5Wc/tQkeniw6jCkpkg7czAKKTnRfLDd34=;
 b=TNBh6por8mAM0X+wSkkjXrjif6onAbBByXfbFLxbD0JVQ1CS5ieZaIimLFalvb9Vbo
 Xsimo/quxbC1iErrD1mwBbTUb1cTH4q/UYGEURqwD1L1EGpMYhf/bSgUzpw1d7KRR4/m
 wwtdBPm9lWULCvPlDIwEoVK+RiCXyDw8HLiG4ptNNqDgJBqIyCqGehSY1L33Py5/cMIJ
 70IIuoH+tgoGVvJue13xBJ5Xqr5svlvaL22Cq6/GFkrCwCglRJA7Yzfa7kegUISN7Iid
 aoKO4B/u4fnx0XIhAPzZWFbMI+3WcJLThXdvgDoVxfyOuZr5V7b/3LMuHMkUhqffGGJd
 AQuQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792519183; x=1793123983;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Z0XhREEwSWA8NoA198zv/gliwvbyLlcpQrnwqnkY6J8=;
 b=PWAdufSOhIEtfLn5fCQ/ZZduKhF2pywO4Jpb2R3PYbij8BaeKwHDxgOs4wWfuDrgZs
 NuK+NMSBF4Ubs4xNDAdkQ7ncJ1RqViie3Us2CfJbahgvG7znNQLg//IyefFniQUD+ZOq
 hjAAOsYL/nuOAIjgDDFP1rEydHyqC/FgdBlV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792519183; x=1793123983;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Z0XhREEwSWA8NoA198zv/gliwvbyLlcpQrnwqnkY6J8=;
 b=zyVisYXl28dpQgbuxe4sczJMbObYjQhtjiA9NccVJLMP5hTRA363vVYUPeU+xYfPhZ
 IX+9GF6sv5cy+0R262k1tY3UFckEwe25xt6WU4jO7hQUGmOylJGLsTMdElkwnFpmdWw0
 /B1HF6IEeoZPQiPM5qjo58pSEM0+bAt5MdN1QsNCtKSFBary6AiF7Ea1yPjxcTYqNTiC
 Xytu1QUR2o5lruMWuVq+lvUQwZJ6V6t2MG5ppsmgyk2HfTnP+Kp5l7E73Mbrz9yHjFZS
 xNEMKo5ItfqrYtBTVc4DXjuxLOhyfFn/02TtEYUvzAtpeiq3F+qBaNe0r3aP+pCqjSw5
 Qpcw==
X-Gm-Message-State: AFq9FYLkz3+809e/9Ovh/ftDDYgzjpCtIB949rB4VFc7u2xtiYqhpR1P
 IdXo7wSI2fLd6sYOwASBNHYzzeri0/HGDNDl74Vkkie5cY3Hqv/d371+kCsN23NQyaUs2rTZ5cJ
 9aaxf7vOhqGklgpu19huFnr0ITau24cGAtwSRkRN+Ls/6ova0mL9/3A==
X-Gm-Gg: AYBFou0SNyQpIugk7eBFJZVSHQh6O8xs9E0Epj7guT5XcuaZ7sKso8AuE4Cgj/Gud2W
 RVl5HbwZseYgW52FtEsGKMSTgwgGRRfRxH5SnBT0WUK+V/aYulcAXvd/71z3e54g8Bk4rDNrTcB
 /axAADLeuGwkYAjGEbuWQpT3KysnmCcyL3zp1hs0vh1yU9KEhiU4F7psCBC7b+VslU6TE3cPCjv
 KtuujjmZfrBN54D8yDapOS7ag/cf9bsWe2XGQ+7vri8RgzSUWSwh2Iyf4bcTvJ9oYIYQnesmUVD
 +QFo4E5hYUPYQUuuaRX4I40BiFe0aY7c7AoxMPE2z0ou8F6M+JMS6ROHK0t9IGcE
X-Received: by 2002:a05:6402:5106:b0:6b3:b3f9:c418 with SMTP id
 4fb4d7f45d1cf-6b3b3f9c45fmr7587667a12.12.1792519182642; Tue, 20 Oct 2026
 10:59:42 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 20 Oct 2026 17:59:40 +0000
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 20 Oct 2026 13:59:35 -0400
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261016072640.772964-1-jan.kehren@emteria.com>
References: <20261016072640.772964-1-jan.kehren@emteria.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 20 Oct 2026 17:59:40 +0000
X-Gm-Features: AclHuK8Z8w1OgJHq3MWTCYAZjustG7KF16UxrEcWVEGAo8EjutWI1DgAv24K-Y8
Message-ID: <CAFLszTh2h9Wg=axjSj5ny6d2ED5NAwxfJrmZnswJ+8XX3osaMQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] avb: Support verified boot from non-mmc storage
To: jan.kehren@emteria.com
Cc: u-boot@lists.u-boot-project.org, mkorpershoek@kernel.org, 
 igor.opaniuk@oss.qualcomm.com, glaroque@baylibre.com, sjg@chromium.org, 
 trini@konsulko.com
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
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Jan,

On 2026-10-16T07:26:37, Jan Kehren <jan.kehren@emteria.com> wrote:

> On the total_compute motivation: that board carries only CONFIG_LIBAVB
> since 867e16ae05e2 dropped AVB_VERIFY and CMD_AVB, so its
> "avb init ${blk_dev} 0" fails as an unknown command, not a usage error.

Thanks for tracking that down. One thing I'd like to check: patch 3
still calls total_compute 'the user that benefits', but this series
doesn't make that board work. Since 867e16ae05e2 was a savedefconfig
resync, AVB_VERIFY was probably dropped because the board doesn't
enable one of its dependencies. After this series AVB_VERIFY still
depends on MMC and FASTBOOT, and total_compute has no FASTBOOT. So the
board's env script will still run a command that doesn't exist, and
that script is the only in-tree caller of the new two-argument form.

I suggest you add a patch that turns AVB back on for total_compute (if
FASTBOOT is acceptable there, or the dependency can be relaxed), or
reword the patch 3 motivation so it doesn't rely on that board? It
would also be worth copying the total_compute maintainers so they can
say whether that Android flow is still used.

Regards,
Simon
