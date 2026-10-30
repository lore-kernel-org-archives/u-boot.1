Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A641C60A260E
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 10:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=vyCjNCkg;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=smikly0J
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 819EE60690;
	Fri, 30 Oct 2026 10:04:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4bxTeDz1vmIx; Fri, 30 Oct 2026 10:04:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CB56D60AA7
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793354689;
	b=Ki+nKa2lIV4tWalWyRH4u0m2B3HPoYBNkiEuo8OYjydUyoS2RLjnQa7RoOPYJIEaMxze
	 ZJWE1YRG7sWFwiDI4uCWu73kylLaPLR2D74sH8QqB0PN7kJZ/YKjYhY4fJchDKh7hMl0G
	 IccnQA6IkTAkYyxDdekAOKwWIpEzcl0psPhMh2I3U2WBdkIi8+zJVCP0VhvJzm3O3hY3M
	 lYvd8SnL0trMFHS24oRKzF3+lvjVGApbpyrESFkOv+T8lzhzOFuBj0OhbQbwBxJtZ8B47
	 z+16puhgx6fddVgbiPpT3R+MW3XlIxgjG18mw/QjcRb3QyNXJYuG8YnJ/PERJujJf6A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793354689;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:From:In-Reply-To:References:MIME-Version:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=UI3sjWEmwtH5uGaSmH8DSBkbkLfVjW7ZJU/VGllQ5Mk=;
	b=ZvQYxSrXNQlaS941uBJEEOGwEGowf0NcrR0bxtGC+mOcC3Yx57Zn5n7MbbLS/AMfG6bt
	 GzpiILplaUdp2pt6fkPwnSK2otvcDnUGaMf871nZJA4T/B+v5LT+QOrZPk2ZNCwyI4e0c
	 pfBRC8dqu/FIcqpBHvRHhWLglr8bzxEqWKrveNhWIJaqvtXbsT5uDtMutv4F6ddoGNz/L
	 eMADR77nzeq/Qy3QbYE3HXSHSPEtktlvPzM+tXJUcEwhOryu2ziy6PL2cI8Kerjf2Lf/g
	 Rb7fA68B/70oE6WVoGVKdDdOwJ68cxdVFj2rHlmy9N6IttlPB09ddj5uqkpx2n7Q3HQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793354689;
	bh=UI3sjWEmwtH5uGaSmH8DSBkbkLfVjW7ZJU/VGllQ5Mk=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vyCjNCkgleMaaVlIqkNoOqGknPP39M6Ep9dnRBQbABBjmaAfieGNeuUq9mTLedETz
	 h8zNdCYDQ3Xc55/pMJnuqxIfiT4L8zKOTIBezAeaEkQGT6ROXoTz8OC80DTfNAlM3m
	 bLk3AcAmRJwhS4FQ63PlE+wKR5RcwnSHlaTjD4b9XOTTZsaHc7YcjdP/5VMOA15kw7
	 I1QQQD5V8budmoKKWuGP+Q3J8DLOazANBlPJUNmAn9XkgcYjOOjXNZ6p0wvOcNx6E1
	 yCtX0iR9BK4WUbNtFjUth6mOR/aTH30o9ISqV7FP9udJ7oh4qcV0GLO+AAYFtRU/Rm
	 imgcz53jPSmXg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CB56D60AA7;
	Fri, 30 Oct 2026 10:04:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id C2CAE4BC
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 10:04:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BFFC140729
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 10:04:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id p509LrZE55Mh for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 10:04:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org ED118406AF
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::232"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793354686;
 b=jTDp2XkTpYLWCAkn3k3MHp78ggoCF7e6bEDL9aU6KzcrRn/v4D5o23LXzayHdI1HB0LN
 YKIQ2Qx3p81MqOQGATcqY2P3bLNmUP7SZJ5fNvWAGCnKeKDrUEhT8/GG6KGYww9Z/mG1H
 es0UW8u0OnxwamYiNOkTnWovxINRunyHSdCNDYD0f+xTFk0fWiTZf7Qagb6EaI2oTrFpD
 twAYmzQZ1o46gdCIIpXZwpXzYzJYyNZi+CrTC262JXc1rEyutooNqwg4rav5mQ1kjMnXe
 XmTlqx0V29Z6gOt/psxkG7jlbpj+OTeeaUW8XJ2BsaXdKT9Htn0TO1NKLai449lyaNA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793354686;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:From:
 In-Reply-To:References:MIME-Version:Date:X-Gm-Features:Message-ID:
 Subject:To:Cc:Content-Type;
 bh=UI3sjWEmwtH5uGaSmH8DSBkbkLfVjW7ZJU/VGllQ5Mk=;
 b=UYEilYTckuxMx7jRY55JPYD24nOzly1oMACwjTntzHRA5zpUTFYhEyLT0JcqjL1mbuKc
 schrOWg+bxe/PV1Jwo4dfNgbHKfElxiaVvE0+AGKD+zUi5wLTsOGJAqn6Zwm3OYDIot9D
 6kOd8jR23RxIzK+Nm4UkPVUa3oqevvpWo3nyCZCh1UaTYMkYv3e71DsavxvX0p53QTKWm
 3jOzz5ro/zmOUP7dWhu9DTnKj0GW4IhEBlJMCmXBmNdPPzbAxaTwQth3iGLc0rWf2ouXT
 VBCLLCNm8VlnDddtfwwgfQLSE9+LdYfE8KGyeTGcm76bp4LteZdrs7EnG2qD3UMpyfw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=smikly0J; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::232"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::232; helo=mail-oi1-x232.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=smikly0J
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 by smtp4.osuosl.org (Postfix) with ESMTPS id ED118406AF
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 10:04:45 +0000 (UTC)
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-5058b105df7so159813b6e.1
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 03:04:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793354684; cv=none;
 d=google.com; s=arc-20260327;
 b=i3eYB1HMFTdNNLriX+SWPn/06hXGT+Gb9wYoklpo7VDXv4bBjlUB0q1PfU1qlJF3bX
 AnyABLDsUayQpJvYhaslS4J1pt6uLuzsmm2nAKnhQ5PrXli1WIRUxHKpqxp1XIkSReKB
 rlOD8iuR0j2GurjhOD6g+MaWBsfqcf9i5kU3x874i8zgVegdg5onkcwOCKDHTk2+NhWJ
 PsHuD3E/06aZCpSnxl74hBfVnbnvjsZy4WhmZTRfsa0/Ltzu5EA/bXUb0kN+S4b8AipI
 JEfKh9mgoM/BzzQSjpZa28es2xOt6UX8KtRhlfw3YCjMbusnyrn4sCPMUZjeOouRoIX4
 WZig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
 :from:dkim-signature;
 bh=UI3sjWEmwtH5uGaSmH8DSBkbkLfVjW7ZJU/VGllQ5Mk=;
 fh=0/NjL8o7GK1Gqvi8LaMHvqkCbtWdfb9jHUbMCcbnqS8=;
 b=PIELis/8baEsYDClZj2hu8lYaLDlGLKHTAaJb2ofynky/ek45QXKQKxtVKfLNtD4zG
 D2E8pQCk8b1jDw7If65PVOTjKJvNfdiBfk4daZx4aQ2oFuxl/dnrV0MWC2JGG+k3+tIX
 C32nHQ+nr6q1UakUL0R6y/GDN4iq7RgC0W0Mve9l0nKHae+7KiWb3l+9glQBxUbN7w8z
 nkxTDdoUOSAiCwcYpu32uyBt4H8BrnXjKE3GHwJOZmS5INmvPPa6Btw1fxptM+VR90Ux
 p+JM/9fmecR3Uky2tgyMbJi2m4RSmva9UGIvPEhRTfByN92I71oBwwvLUHKjW2YDyfOs
 +wQQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793354684; x=1793959484;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=UI3sjWEmwtH5uGaSmH8DSBkbkLfVjW7ZJU/VGllQ5Mk=;
 b=smikly0JBriitHDpJkDvn5yKcnfi3HqBr4fGxS2tod+nxGiqNDROgCet6XnSTnAT/B
 zLQevWaMfwCgSJquS0sWJzv9BKCPxuHs4DBGwtCiC4YcMLaRxlkZebwHQ+x4Hp9ehoeo
 gH6BtN0IYcMVaN0vjkOq8P67xVcJ+K9nDOPN1+OJUs2kyNLEEQvx7MEpgSFWTR7VFhsa
 byJficmW2fos96jmi4TOV9XM/l2mU5I8v7G1a4wJnFxP7nsvjK3fUf15bqsdAvLWXO4e
 uLww9G5xE9GmGNiyj7i9CtJUw/Ps54rJao4bdvBRtatVysjjlRpm/gMfQwfhtumi0sCx
 +bIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793354684; x=1793959484;
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UI3sjWEmwtH5uGaSmH8DSBkbkLfVjW7ZJU/VGllQ5Mk=;
 b=JfHupYDbtxwzmsahIX5LyA38dYABIUXXR98G6YckHYfOnxuU0ZOqRcaaEnYLqNnqxV
 7tQT1NiYljuRK5BG3WdWr0PwPvmCKGDX6T0iW9Ml1oz0FNR6oqwJB7fwcAbUE3SV8Cgc
 SDxG7oq9kYrlowF/jnsVLC9KHdNPLiTldQPAejtyYDSCnYlOfZ2iMQAuJ7J9+eO/Obum
 X2dJIDlk8WHDuwBjcu92u5IvaMBn1JdKDdErIUg56OjYeL3AUQeP0b7WshBmooXK8uIY
 0df1dCt1XZWMlZ5rAEkNNtGByf9/RL6whOPTYcbaxbA/GmAdZwbpbWt2DfPd7fb/1F9F
 EtFA==
X-Gm-Message-State: AFq9FYKND52yVEGcVkoOysHBd2Dhd+q0xM3XYQyzUa7mDVbCEQrUexpT
 4nMZ9cLBSUNLJ/k/t+0SNwhjFTiGt7/snmYPebO62IzETi9/bVujjOfXD+m9tKHr3HE2/h/Dxwn
 IF83UqU48TF7kQL+hU1Yvor/X/TtmM0A=
X-Gm-Gg: AYBFou27hVymK72dg6rOT64sRCtKrGV3BIRUjH0gvN0jkbrNiKiWAmKxr1WdoY/n57/
 dlV8SCdx5cj7HObESU30KexaynjZaV2y/KZQ2QFGHel8x1os9jR2UTh3x0tuZng46AHOC3fLzVc
 heRllC7v1KICEbPBdmd5nr31dH0jnjv8EE7oFtmxBCFbrjf68jYPwU+zqidL8JshaqbZJFJiUMk
 GxMtR1L5Dm+49r808UNz8yKdXgC+WNz/PlUgsaDvFomjth9Oz5kr7m94NnsOIDsqXe6KPfg2WUr
 ga2N1hGkTgby9EdpR3HP1+z8Y1kEzEz76OrYLDO0IS527GjqO+Fb5xr9hAuhwykeLxIvgs5KYp5
 yYSqbfsAC64jVh90yclnvfZYLCSaAN3aU8PotDKo+x/8IB8rrrN3hO3q4nvHT
X-Received: by 2002:a05:6808:f0b:b0:53c:9db6:3586 with SMTP id
 5614622812f47-5640dc291f3mr1288786b6e.17.1793354684347; Fri, 30 Oct 2026
 03:04:44 -0700 (PDT)
Received: from 1077388689865 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 30 Oct 2026 03:04:44 -0700
Received: from 1077388689865 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 30 Oct 2026 03:04:44 -0700
From: Ana Bobillo <anabobillo3@gmail.com>
In-Reply-To: <CAC_iWjLxG3kTOgUQW-C7xbrQCm3Xfbaxry9UYY2nVWLG8ybybA@mail.gmail.com>
References: <633dddd6-ee22-4cd6-a8b6-cb7df0650fae@gmail.com>
 <be672b54-42c4-48fa-a7ad-994a7ab47ea7@gmail.com>
 <CAC_iWjLuP0zLWHKCnaCzGL-iG1bR4gR7AqumaPm_yQ9MqgBfrg@mail.gmail.com>
 <CAJnxHsjrmr_6T1vXxOfX0y2N6_Te1w5dKwEHnkUfyW-7yJ+i6w@mail.gmail.com>
 <CAC_iWjLxG3kTOgUQW-C7xbrQCm3Xfbaxry9UYY2nVWLG8ybybA@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Fri, 30 Oct 2026 03:04:44 -0700
X-Gm-Features: AclHuK8a4Etz0vZXSNjhyT_mzmPBC5zyw2Iuoh1-c7822MOrDfi6gZEj2tTTA7M
Message-ID: <CAJnxHsgcE56menF4oGHCzseHREqG6Yf9Dy6+1Bo8QNe0hf=QBQ@mail.gmail.com>
Subject: Re: [PATCH 08/10] efi_loader: do not load an image that cannot be
 measured
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
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
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Ilias,

On Fri, 30 Oct 2026 at 11:23, Ilias Apalodimas wrote:
> What kind of Image are you expecting to boot and measure via EFI if
> it's not one of the defined types (10,11,12)?
> If you are worried about such an image shoudn't we check that in
> loadimage or startimage? The UEFI spec itself only lists these [0]

Sorry, my last mail was much longer than it needed to be.

None that is legitimate. Such an image is only interesting to someone
who wants code to run unmeasured, so I agree it should be refused in
LoadImage(). That is what EDK2 does as well: CoreLoadPeImage() returns
EFI_UNSUPPORTED for any subsystem other than 10, 11 and 12.

In v2 I'll add a patch that makes efi_load_pe() return EFI_UNSUPPORTED
for any other subsystem, before the image is measured.

That leaves 08 with images LoadImage() takes but efi_image_parse()
can't hash, e.g. a FileAlignment that is not a power of two once 02 is
in (the case the test in 09 uses), and with a failed PCR extend. I'd
keep it for those.

Thanks,
Ana
