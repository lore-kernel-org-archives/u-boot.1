Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D63606A319
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 12:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=cHoGasaB;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=L5SX6KPX
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DF4D281276;
	Thu, 22 Oct 2026 12:20:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nYH0PYEw9eUj; Thu, 22 Oct 2026 12:20:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3D01B812B3
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792671635;
	b=i+JtCIyeNNyWIPF8qpeUnY4jV10dcRjmPLUSUWZ30Mnm+iB9tlsNMNnP2Myxesvlcdq4
	 AizuhFZr4Apj7r76Rn68elVFxTzAo3WiggS5qwwYxmossx6zYM7gq+NXnM32Ou7x+JBXR
	 Y47Fyl+ZXRqK7DPSWlTsMWFZNGonGrMc3tNYLZudwiV5T6dYLbyfM7tYsHi3INIKPVojz
	 UKVxW+HloAbkS9LHNQ3YhmrZsOp+8y1goPTxLrkhFqdbFHKRKHWA2MdWYvtc+XuX6g5Jc
	 EQWcsI6rZGlp1syZb6siZa5UjV367X4FrkZXIMZlcGBvrPuY67RBCB6RywC4D35iapQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792671635;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=H+KenO0PBZM3jtpU+U4aPTuF8Mn4bfmAG5wJDVxLkZU=;
	b=Qmq5uJ1zuzdxeRhMo8NLEL5OiOpn/lH3/Ih7F3u46+SZz6ThdQ1aJ+kJRQQO+Be6+Hp/
	 gqQp3oNT/jxw3DBkA3KFgnku8p8ZNI5BxVPGqF2I+mCeV5UvKQU0E5Ay7Ijqu+mOTxiMb
	 m4mYFqXkCOm69r4D+XuAJqTT1zc5ie1wIO07TC+iBKOwqoEepQJtpncqakKai2Kgtr4Ka
	 3bozGYgGUwyeQFMjZwn8yvWD3uqjFZi0aziXRphaqGgORkshY1LhGwxejdwb4e/mLSJqh
	 RNG5zYgeN72DF5LHSGaFKecEYD+5kBmDq6eJuAmZezqtAEyCJTiC2aMAji9pcJKVbTQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792671635;
	bh=H+KenO0PBZM3jtpU+U4aPTuF8Mn4bfmAG5wJDVxLkZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cHoGasaBoVmw5YMFVhXM96jS5mMh9RU7ECylja/M01E74kKRYGfGNoHgshVEB7PDc
	 je0QD14EbqVUNzipqZX8zIQnK0b+E9bx6I/46aU1YbkdabDt9gsN49VN5tuy/nfLT3
	 0XtVylAkyltKZfRtfqdLn8kCOYOAQMvp8CkyAP+xvZppsqx6xKilAu7/UOhj20026A
	 1vqwEhCbAmYyJOgumq1SyRvd3QkfqXBdO7XBRk8azmwLKEv0gHRhRL7eW3NjDGUJiV
	 xC/jAx2NcP++t8pbG7ZlN7k9wc3XwNb93Xno66YnBL9o/XZTe8N8akb+Sx2s0Vexw4
	 kQA07/9hDtGPA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3D01B812B3;
	Thu, 22 Oct 2026 12:20:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id A281C2A8
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 12:20:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9F8FD608AB
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 12:20:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BvK1ucHIelHI for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 12:20:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CCF95608A9
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792671633;
 b=C3QwrG65Khej98E6nmhL635G1uQBT90M5pafN7HnQ3KjjLaYpEmJLSYyPUkjJMjS3eWf
 hYP6Gk2/gt53K4uSQ+xzfQ0lyKJv9IwwIiSBANoF+HGWy+sA59CBY6Zo2rkyPgVerncor
 KsKTOGGLk3IuhH4sm8fa+MBgnXLkQiA2gSKGIkk2IYavguTy92lq02iUG0/R5OGrbtNbJ
 74lTPHFTu6fLfnOwDEBXWqpe6qklwcsjDHs1uK6IeF5Fo4rTHxhrQ8wjpHGJafVOmk9uP
 AU1BYT2ZpTsEo6psIhEbrKo2GiqNoGmtcUpvchdp1b0zXr4j3lQbseNPgDSgXvd5orA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792671633;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=H+KenO0PBZM3jtpU+U4aPTuF8Mn4bfmAG5wJDVxLkZU=;
 b=hRI6ipiKCDmkPUCAhYmi37YHyBjn4rBP8LGi8yK88iDJcdONLUyRCtnbnhWx3JwJwdwy
 uIXLm5MPPenrJPSw2CfruCeCfxMgmqV+iHPuw4QFzO9twhAlg41qIpl9BxAiTPtUGE1Tj
 gslrZCrBey7SKQdQLRDouCYKzWmaKldeT4wXxKh+LKqWNKY79XwjzetpKjfbsmT5vXvI3
 b67esSk9DtqW7XhKek0P738nnDtG17JED6NI596I1Xg+G18UDGfU2ANQfhb99pIACytZj
 cXD38E56pekAMDvMvhmy2NebXSuqZaE+vZ+JjN2VE/56iIWQrpyqqa7PgGG8rY6yftg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=L5SX6KPX; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=L5SX6KPX
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CCF95608A9
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 12:20:32 +0000 (UTC)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4a16aaf2067so20735485e9.0
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 05:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792671630; x=1793276430;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=H+KenO0PBZM3jtpU+U4aPTuF8Mn4bfmAG5wJDVxLkZU=;
 b=L5SX6KPXC51eiqmAJP+zvcssyrRyMgXwoGHW78ppTzILVqj01SDgQQl+/JgaeDThih
 lRyKxwSqNknmrYfm6eIJ0MKNc15evObSSJMkJLdsbNAacsqAt7tIEuH2mam0/mnekE0U
 JBv+Jif84xVHH0Q4CYT71dvRIV122r0rJ7CTOp7QIkKQNGjsGMZVvTRUvutEG6QkqfMZ
 5T/44U+MWmyFukIE5mnz4Bxvqs1oFmrvjdfim90vOiLx5Mo9DdrGhesmZ4rAgdKYI9RO
 1uWHpqXhHPXaqmG2Ajh5l7TbaJvwbOIJe1qGEk6qNwFOt/fB1fE6UjJflOYNiofqc5MK
 B/6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792671630; x=1793276430;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=H+KenO0PBZM3jtpU+U4aPTuF8Mn4bfmAG5wJDVxLkZU=;
 b=tzgtLSG7LUcGaKQvA4AJbaLJqVQZTzykL76bau0PVVjt4CnjxYvTem0wRcUxAqeiHS
 FpsEVVJuAWNSw2l8gbR/AbsGf7gn5Ux0L8zwh08q2mKFhA2Se42Cj9Dnc1VievGzmWFx
 rqQ80e2XVABY+BHqsfxHVfOZ1tJ86c0yyVhpqeYsNpaiVA4izma4kRhBLFd0XRJwR8ki
 DrhmMVIZuErPephtENvUOpOWqFF4UA4o17m0UgTGwmERteQB+C5ed5mmtNZzOd0ZMU7R
 a/isd7yyerclF7g5KjGrukzLZjLYPZyNQnMGT7fjN/jz+ZKPhD91tenxxmnbNybqbPTU
 8ZeQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByEp7vNEbgeT4ZCtPhW71D2IZFnJHQwe3H/C2Clr9KDJLE6a44a3V7zrRlrBqwk1Jh3eVxzwds=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYL1IjKwHd9Dlyj/+FyusWAHZ3S3xNrX0pLHIj2gCd0YL9bb/KHY
 s83mzstRGKEMuoFF59v+dPWysI8ZKyUnfXHUSzN1TRBbLhKna5thlud+
X-Gm-Gg: AYBFou0eVXLIy17P7nKpAy5eWpXlt4L/sfihPsAw14DsflsyKdVLe7NwVqfyRgopRiq
 1N96DH2rFNhgaAYmg/eqjmQ/+qw5L9AFNe/2SzQYWxkKoZqwv9TvFWAralx19vH2ZKNaoAVWkvV
 4n23U9GjluncHcJaGXh5KFgunneZBARsDCWplI3W9RWTeZC/vLxlWfTCXLPkinEuc8hL+pE+Wnk
 Is62J0qmXS95rKyvHFAMV/Xfa6oPyLSvCME6HX2XE+VnaXrwv/dxM0+0eiK5JzBwpHj2tJeUOgz
 M4MeJcDHTHAcpeKSR9yJMxvP8hzAdJfeZKwjI6f+S3ZljISED8cppuxzDepwQpBng9G1m+IOU7c
 BQXP+eXNxHdInn5Z8FUMfkZK15+Ydg0jnBNeIaX443vo3AVN5tBS7Arqez/gfn87DVTSd4mYTHe
 WS0J8pr2NzViQ4Lf5pm121O5TIWZ50yAWcEdiOuY1Oh4kRi5OqCH5F3TbZUGSP0y1mk4xfzi4ih
 I4b1x1kdhyKzjpHd9uxI95Ua/XpN8mhAob2eaL89xTgulI2NhEY50TfpSdUlC4CUtWFUwKej4ri
 H6ZjbDk=
X-Received: by 2002:a05:600d:8654:20b0:4a1:fe26:24f0 with SMTP id
 5b1f17b1804b1-4a1fe2627ccmr76915935e9.20.1792671629985; 
 Thu, 22 Oct 2026 05:20:29 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e258420fasm12655504f8f.50.2026.10.22.05.20.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 05:20:29 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>,
 Stefan Agner <stefan@agner.ch>, Francesco Dolcini <francesco@dolcini.it>,
 u-boot@lists.u-boot-project.org, mehmet.fide@screeningeagle.com
Subject: Re: [PATCH v8 08/10] usb: ehci-vf: take the register bases from the
 device tree
Date: Thu, 22 Oct 2026 14:20:27 +0200
Message-ID: <20261022122027.3571290-1-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <51728b98-7aeb-431e-9367-fd5f5cf42380@mailbox.org>
References: 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Marek,

On 2026-10-22, Marek Vasut wrote:
> Mehmet, would it be possible to parse fsl,usbphy = <&usbphy0>; DT
> property to arrive at the PHY node instead ?

Our mails crossed. 8/10 reaches the PHY node through fsl,usbphy already
(dev_read_phandle_with_args()); the alias only gave the index.

> I think you might still need the portnr sequence number, or could you
> get rid of that too ? (I would be fine with a follow up series too) ?

v9 needs it only to pick PLL3 or PLL7, and reads it from the clock of
the PHY (VF610_CLK_USBPHY0 or VF610_CLK_USBPHY1), as in my reply to
Krzysztof. Dropping it altogether means enabling that clock through a
clock driver, which U-Boot does not have for the VF610 yet; I would do
that in a follow-up series, together with dropping the
board_ehci_hcd_init() call no Vybrid board implements.

Thanks,
Mehmet
