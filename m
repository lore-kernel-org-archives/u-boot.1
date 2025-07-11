Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E632C83F1A
	for <u-boot@archiver.kernel.org>; Fri, 11 Jul 2025 02:21:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD583836E7;
	Fri, 11 Jul 2025 04:21:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="azj0UYpm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0049483744; Fri, 11 Jul 2025 04:21:47 +0200 (CEST)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 177C7836D1
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 04:21:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-553c31542b1so1564993e87.2
 for <u-boot@lists.denx.de>; Thu, 10 Jul 2025 19:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752200505; x=1752805305; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ioftgyIX/TR+K933s7XttkJiJBGdRwRaR+xOEpIsoW0=;
 b=azj0UYpmN7QZaceHCkqQRrn/GJCG6Nz5FsB3DMyW4NqnNIrFpWGLKc70dkeqlLJkjW
 wgigpLGSAekrtOneEdDMVWPV8O3yogIcHrE4LeqixMuLEFbo+QLOJjWOoKsaz6jNc1o+
 sdyXMsP0a7lhkgYbpy3wHvlDAIBdPRmtlVBWxIcNFAo3hGDNLVG8VX7XRx87dDSmiMlV
 EOpHYLwcysNjuTEckXQ/7QfQppPvke2Pg+NaoSfadamePqcKrzTWFtDIxP8Ax6m8hbT2
 YccGU3xnYrF8dxuNKrFy93K87MpbDamfv5DReZ6dgWXBaHpK4fvPvkJuOo1vvbcuz4Kz
 zu1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752200505; x=1752805305;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ioftgyIX/TR+K933s7XttkJiJBGdRwRaR+xOEpIsoW0=;
 b=OZ0LB1CFhb7xc9DQQOveBNU0H52jsYV6oIb3YRhZtUSUNg0GMFCjAh7L8lqmoedLue
 gtaQL9hNPHc+PCeh6IRrTEzilW8DqmSnUztBfhSrF9OpA2P/s9jcpeVQYqSjJ6ZHmNsF
 UhC4rEAdq+SNfTD9glq4tfjDECJmWCNYdmgDgKQa7b1MADRfGgvcMU87VXDQ7fycEy5l
 1TwCurkRaKXJzv4lHlSF4OECYsEo5+AMULBRcTONOPabdHnf9Wji4/mKA1Rqt8r4pQDS
 XrDZ5Ebzw7pLHnCr3vGnqJy7SIrhp+rbrWCXt/hTZ192mWG/uKm77aSsGMk7NBsr1siL
 fxhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDPFi+yq9Udk8I+HTmtlBd0tgj5LXQlCpDWSLNjMjDmubtaHvQJMEaXUJSpLwLSm7mledN35o=@lists.denx.de
X-Gm-Message-State: AOJu0Yx3aNWp65yvyIKhjiDJTvI9bHzx580hp6gLA0ioIwvCc0GmE6at
 Grprr34ngGo1BjtvWGGRippyK8IEXtYj5MIENAScpqq9KvjYGzcEoboL9UbsEpmuKVp4ZKboW/O
 ObiVpA+UzxXrNQLFB6o3Wiaa0W2iSkUcBDA==
X-Gm-Gg: ASbGnct8ssAyZ3zGQ307wy7dCs/tHiUMpiZfTSRkiM0CaI19aYEk98HKwNtdV8qIBtF
 Qs8pDE5uMGdU/Wfpujrtok1NMc/C4x1zZS+FvZ7O3sBQvb0Xkwi/NFeplO9gxWV3+BYpXp909Z2
 XihA7h4nyT7iyLImdo+idsWf8KdL/6t1OQkhnKHPOVC2sE8fQ7sj+TnYH5XJHKzXCBHpx8B4RIg
 utXIw24ztS2ansek+h2ssnOM9zWxlwfDVeZRzY=
X-Google-Smtp-Source: AGHT+IFJErmCHvUqoXLFH60Vimov2Mf2SpyKJq5s220JS5Vmb2/L7ubZgo2FbnY36Zdw4UJGk7IMW1CxJxIWXW1hJvc=
X-Received: by 2002:a05:6512:31c6:b0:553:37a7:b217 with SMTP id
 2adb3069b0e04-55a046039e1mr371098e87.35.1752200505168; Thu, 10 Jul 2025
 19:21:45 -0700 (PDT)
MIME-Version: 1.0
References: <20250701134504.1076115-1-ghidoliemanuele@gmail.com>
In-Reply-To: <20250701134504.1076115-1-ghidoliemanuele@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 10 Jul 2025 23:21:33 -0300
X-Gm-Features: Ac12FXxzhNQ8Vrf0eeIHFHoZqKyp4Xzq99Glr1AXs-64yyE7kS7pOIBRYiq3Sdc
Message-ID: <CAOMZO5DFzJ9TRsdAi8hUPjJjJTVLvSBd36o449x3iug30YZ4NQ@mail.gmail.com>
Subject: Re:
To: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On Tue, Jul 1, 2025 at 10:45=E2=80=AFAM Emanuele Ghidoli
<ghidoliemanuele@gmail.com> wrote:
>
> From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
>
> Subject: [PATCH v1 0/5] Enable RNG support for KASLR on Toradex arm64 i.M=
X SoMs
>
> This patch series enables RNG support to automatically populate /chosen/k=
aslr-seed on the following Toradex arm64 i.MX System on Modules (SoMs):
> - Verdin iMX8MM
> - Verdin iMX8MP
> - Toradex SMARC iMX8MP
> - Apalis iMX8
> - Colibri iMX8X
>
> This improves kernel security by supporting Kernel Address Space Layout R=
andomization (KASLR) using a runtime-provided seed from the hardware RNG.
>
> Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

Applied the series, thanks.
