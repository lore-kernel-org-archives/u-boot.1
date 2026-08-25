Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 938DCC61DBD
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 19:13:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5B0D46071B;
	Tue, 25 Aug 2026 19:13:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WXg2H24Mwmrt; Tue, 25 Aug 2026 19:13:12 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787685192;
	bh=v7HWi89YUNHJ7Dd5d38N9+H9lhXSZVAFnEQEkMPDS/I=;
	h=References:In-Reply-To:From:Date:Subject:To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=McXilnW3VVYS7nmuSDmkBXTjkLGwe4B/PIQb4zNzDfdxH/ifA4JMG+rBe4XC2YqQB
	 XYN7KP4KQxtP2irtjF0bF2MGQFSXAYzFszpmRRhfHfjBGi4vLmIQJ5h7UDxMHOFKYP
	 MSKD5iCaoW2VGWFa5/KAkBG550PjtFT58ekHZup1OZxwDqLXG8aWdpT7mE6/D20ZRi
	 ku48lyztDD2N288NqhixztFPXyIFZsleueREys1Bxo7MkcxX7j0Rlj1/C2JYP75Dcu
	 rx3cCy3t3crAET+LY9Jax3ILvUqoWK7CFTwrJn71SakPhKQldcVN8Ytn9POVa9kyzb
	 QLE+BPMOZVnBA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D8959606E1;
	Tue, 25 Aug 2026 19:13:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id E623F105
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 19:13:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C83CA40055
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 19:13:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pqnd3Qzv27n7 for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 19:13:09 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=linusw@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=jbrqIupk
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2AB1A4004E
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 19:13:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C03D06011F
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 19:13:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EDB31F0155A
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 19:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787685186;
 bh=v7HWi89YUNHJ7Dd5d38N9+H9lhXSZVAFnEQEkMPDS/I=;
 h=References:In-Reply-To:From:Date:Subject:To;
 b=jbrqIupkif/4YNpGAmm2z1DIFa4TNA9o2ukSYhM1tse1L1VNDMP6z2ZEHc7b86iKs
 ZlxBw4pohWzzBiDihdmBjCwfMGizbLEFpn9aY6R/OZizv9GUF/Wq8e0GCGywKe6qhK
 GiJDX3RzUYepUhKaqhoA59mhhbjF5Ay52ZX0RxtaEe3nisyaY+phMn9LkRK3fkcjQJ
 525Xvfl6jvqTmEGtQ5ZkYOJSpPppOrjbCBXN3x/vr9viDc7DOSMb1k4oOwK/LOJX6p
 I/AbJH4Aae2OvSChNp5W1nyrRPKY+sGSbZlHztUeOdbK/WVgkRJmvsjHTxAFXfNs/m
 sCNzzWzFnH7vA==
Received: by mail-lf1-f48.google.com with SMTP id
 2adb3069b0e04-5b2b92065ffso116607e87.1
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 12:13:06 -0700 (PDT)
X-Gm-Message-State: AFuF++lu/aoFD2CdTbAw3rjiq3JAU/KLAl5B280H5PzuHSq9jYWUN9Pe
 j66txQYlcOTLvT6MDM/1OOjTdgh1ZuY2EqoLJtep6ManI+0SgfJ+ojPaFti2iA1MyfcOZ7rqtwW
 kLTtGO+IneTkhrQY++Itk+heBZxFCrgY=
X-Received: by 2002:a05:6512:3d12:b0:5b0:11b4:fd7f with SMTP id
 2adb3069b0e04-5b4a90519f1mr123586e87.10.1787685184891; Tue, 25 Aug 2026
 12:13:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260825-ux500-external-sdcard-v6-0-61446b6c289e@kernel.org>
 <20260825-ux500-external-sdcard-v6-4-61446b6c289e@kernel.org>
In-Reply-To: <20260825-ux500-external-sdcard-v6-4-61446b6c289e@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 25 Aug 2026 21:12:51 +0200
X-Gmail-Original-Message-ID: <CAD++jLnMUwRQdt23C-9YuWYrNWjX66F0gqnnj1hs0FHyC3B4VQ@mail.gmail.com>
X-Gm-Features: AcwNN1WtnJEuGB0oHD7yDiSXzbUKAF1jFeyyBeu-w64QbC68m2nOW6wjSX1YF3k
Message-ID: <CAD++jLnMUwRQdt23C-9YuWYrNWjX66F0gqnnj1hs0FHyC3B4VQ@mail.gmail.com>
Subject: Re: [PATCH v6 04/13] power: regulator: Add driver voltage clamp
 callback
To: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Stefan Hansson <newbyte@postmarketos.org>,
 Stephan Gerhold <stephan.gerhold@linaro.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On Tue, Aug 25, 2026 at 9:04=E2=80=AFPM Linus Walleij <linusw@kernel.org> w=
rote:

> The regulator core can clamp a requested voltage against device tree
> constraints, but it cannot account for discrete values supported by the
> hardware.
>
> Add an optional set_value_clamp() driver callback. Apply the regulator
> constraints in the core before asking the driver to select the closest
> supported voltage in the resulting range. Drivers without the callback
> retain the existing behavior.
>
> Signed-off-by: Linus Walleij <linusw@kernel.org>

As Stephan mentioned, I forgot to actually use get_maintainers.pl :(

CC the power maintainers to bring them in, will fix in next patch
iteration, mea culpa.

Yours,
Linus Walleij
