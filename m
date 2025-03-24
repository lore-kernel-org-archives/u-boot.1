Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C930C36002
	for <u-boot@archiver.kernel.org>; Mon, 24 Mar 2025 23:34:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C4F8819FC;
	Tue, 25 Mar 2025 00:34:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="W1p5/iqv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1180980F70; Tue, 25 Mar 2025 00:34:12 +0100 (CET)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E7F78186D
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 00:34:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-5497e7bf2e0so5800842e87.3
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 16:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742859249; x=1743464049; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1/p7uLnpA5TXHxH4UWNeAxmBkLxbxV7d/EcoT8mRN2c=;
 b=W1p5/iqv86TGwHx0ilvPAVZHPgwRsTgd9dX+ADd4FAeIKRx5XoGDRn+Lo1nAExbSZk
 faTVjl4TmMrXuEh63ash8iViIPYPPwcGW5Jkju/Jcj1yvaEbjD4F2ZjjPkjsVTVWxSqG
 mmEociOYZixTXowzgS0MdyrvFHp04oa7wbZxgrqdysyUq5MPNAMP8RoiBqO2/azy8Ihn
 6rCuW9tO4vTRh1YEgzkDalvyrid8S2ArHh7xw2dQhYGy+2e4ROXXSvgq01F2R6LvvlvD
 ZxGxHeock94xYSmOkNU4XdbGgGWPbfhZCvYTiNm3B4S7+M6OL+t1fsnTG7uJK0+keUgh
 /ayg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742859249; x=1743464049;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1/p7uLnpA5TXHxH4UWNeAxmBkLxbxV7d/EcoT8mRN2c=;
 b=Tf3kj/qxqo4tljgDjHfXJckvJ8F5sdN5K4+17Oxx407IKz12ZH9t3PFnymafVu32aW
 +NzG7A0GqP2GBmAb7bNKcFx/+6R6BIc0LKLIomDhMkuOE3oLc80hm656rW+ipIC2G2zR
 GdyTQ3ijpWunQ0lhbI32v0divV5tOpcl42r+mHT9Pg/5T7rIqmiRmxl5fBJIv1NRulR/
 J5eklIAsUw5xd6Woj/tBtZ+VcR11sVPXJPfmSeNexH1p9L+fFSNICa9ybAWdNVfzuu+N
 A5ZSY0hjH7UWfCj4YQyZJHqBD7Dbn72vq0V3atKJAfSgMZ3w7dF1NoosSx7H7b3FHw0k
 4vrA==
X-Gm-Message-State: AOJu0YyPvuiZeM1snyDaFu9QDJ9XGwuu/1Wcmpl15n5VyRcGEd3Y/O/3
 HtNKqED7YzuGftWJ9XI1cF5y1Zh8+HhZPt+DiyT8aFM9jecD6/E4ivXJpkD5pVZZHYYsg50NMTv
 tbLKfuh4IcbK1IL7KYit8lxi6TBLkyg==
X-Gm-Gg: ASbGncupT9vpIhriLyXTXHoJfbRVzaQbHMyhbGrNGdFP+9p2nq5m78JGhQ2L3ZhS/4x
 IA6A9I0/SkiaEPg7T5zEB8mFKLL+Or9ywKjJQsqhMGwApEd5A8m36aedih2xa4j20xnPydbRW6/
 EkPEv+Yf+hnU+7yMbos5CsI/V+hTxrRFno40DvCTbyVT2m28d3b2yCFSLe6Q==
X-Google-Smtp-Source: AGHT+IEFRkl3MNLPhLShi56toPEFvgiQF/8UVp4GFK32linz5bivpoPB7umXn8rg1G1rwWWS4/JTHbitnrg8RW8I1MQ=
X-Received: by 2002:a05:6512:1054:b0:545:2f0d:8836 with SMTP id
 2adb3069b0e04-54ad64f092cmr3739446e87.40.1742859248988; Mon, 24 Mar 2025
 16:34:08 -0700 (PDT)
MIME-Version: 1.0
References: <20250324232725.859935-1-aford173@gmail.com>
In-Reply-To: <20250324232725.859935-1-aford173@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 24 Mar 2025 20:33:56 -0300
X-Gm-Features: AQ5f1JoqlEbivoJnhd1UWkeBaosqEZP3uNwKYTh2PUZeZ5kCLOwr8Ae7LjeQxAc
Message-ID: <CAOMZO5B_TvFw47ZO5qFfQuB9n5E0r8e+nR0CwHPeowV0dT1BYw@mail.gmail.com>
Subject: Re: [PATCH] board: beacon: imx8mp: Fix GIC clock for Overdrive mode
To: Adam Ford <aford173@gmail.com>
Cc: u-boot@lists.denx.de, aford@beaconembedded.com, 
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>
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

Hi Adam,

On Mon, Mar 24, 2025 at 8:27=E2=80=AFPM Adam Ford <aford173@gmail.com> wrot=
e:
>
> There is a config option to run the PMIC at nominal voltages
> which is not enabled on the i.MX8MP Beacon kit, so it the PMIC
> runs at overdrive voltages.   Unfortuately, the check for this
> condition to set the GIC clock parent and rate is backwards from
> what it should be, and accidentally sets the GIC clock to nominal
> if the PMIC is in overdrive, and sets the GIC clock to overdrive
> if the PMIC is in nominal.  Fix this by inverting the logic on the
> check.
>
> Fixes: ab53bd43dbde ("arm64: imx: Add support for imx8mp-beacon-kit")
> Signed-off-by: Adam Ford <aford173@gmail.com>

Is this U-Boot 2025.04 material, or can it wait until 2025.07?
