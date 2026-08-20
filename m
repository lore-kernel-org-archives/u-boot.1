Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3AB0C5DF81
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 08:15:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 59AE1405B7;
	Thu, 20 Aug 2026 08:15:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wJIgMvLfz-Fq; Thu, 20 Aug 2026 08:15:01 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787213701;
	bh=xxkAx+ltGy1OR+HDUf8EJGeRvBrE/1UUUmKV1gcNqpA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NSabmAMEet/YnXQpAUzEgVkgWz9GRiNzo5CViFnNGD3wnWxCd/N9GW57qozsDD3N+
	 sbyxg6kkXCpYKeRLoiJIr1ft5LCXi7QNt6T9rYyzqkwL8x8ZXosqiNhQA5Hs9gr0hb
	 rGecX6Dxf3XpS9jQFE/P00YPhInqW2yBaqU7k9OWapp+02aW+LHBX/zB2x9WJMy489
	 yNETxekd1upSDVHfEkA8PXgBSCKdLYS34n4ew9T3G/LNKfRDLRYQCwD00gfOd6Mt+L
	 Oza6t4YeKDW0w6EEA35OjFcNeR/kBHV395K3jBTVrUNwIWZZX9s+GMGvQiJOAC+fws
	 hFO512gsHAhXw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0CDF4405A3;
	Thu, 20 Aug 2026 08:15:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8E96E29B
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 08:14:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6883E40253
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 08:14:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Yn42Pp54fdr7 for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 08:14:58 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62a; helo=mail-ej1-x62a.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=MnurRegk
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2693D40074
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 08:14:57 +0000 (UTC)
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-c15ca7a7ca9so221143766b.0
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 01:14:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787213696; cv=none;
 d=google.com; s=arc-20260327;
 b=B4Vuu0SQzs6ya47FwoTWEDCh+yftznMx1lvVS772BeUZzKrE7PWN5CE5W1d7zl4BkJ
 WC3EQ47mazwJcJpzxN5F0GCmZHJW7Vwe0pBfMn5bAP8F+3tQZl76aOiCF7lWHUzEIyj0
 mLn4IuMuiMOA1z2VpD/GWTavS+/mBGPILj7E5o0ocyByFmLXm0YS/XBbT33LRCmAdLEE
 J5YcNvtjZDB/5+o3eUKG2lN9355e0nqSWeVfsv81D5Pks5iRbS2E2D+T616ymQBLyDIa
 LpzOTT85jsJm0GsMfpHe18i01z2A83x5WVMyEVQ0hr8BgVkmrhCd33H6FPS627l/f5Uc
 zGlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=xxkAx+ltGy1OR+HDUf8EJGeRvBrE/1UUUmKV1gcNqpA=;
 fh=PKHuLxyScFTE4Ts1HhXkgmqGXfsiu1IsO2jeKtAaNgI=;
 b=Tuk4Cbn38S4Kl/asfDylLvEKyo5ok1eQDj5e5dTerMse0R6MzsHbnPvBk1y5GVPFUR
 u2OFj0JISTX6j7jPAcAvis9MGFXhp28a3QwGpYOldRMPE9gtVmukhU7HPKzUd1I0Pwnj
 SvXjeoCW0sDm15WL1z3H0lYj/FA/SrZg5/BFtoKRJf5AAJAeHGTq+id3M+M+6b8257UQ
 L8bRjlKwiz8/8BzKjjPNEKU4O6mEiDkeA46kzLHYilcvrykdrMHwsPPVHo3JgBfaH1Cg
 e0cK7RZuze8/FLZSII/cOPN6ojQye1ZmyEyPwolUL2fgpg+6Q1nTXl/IM9cYGWVoy5PU
 +X9w==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1787213696; x=1787818496;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xxkAx+ltGy1OR+HDUf8EJGeRvBrE/1UUUmKV1gcNqpA=;
 b=MnurRegkLZYnVYIvBI7h0W/ytvRa2MXY5zpYw31kTyo609BNnG0L541JlvsBt/ef84
 MoV97Fif6EFwsuujLzdcb+5u1jwha8QM/lk0c4HzgGTiCGVf7PT83AUj62gRJgqqwznF
 WPEy/rYa886gKT0yiW20zonKhY16URlC2ZBZVnJl5p60pSH7O7JfWIDORmmQaedHNIdN
 cCxCBLabFdg5tJ7eo/g5bkaJW/fR9IWuZ2ZAjHSFH+3rVes9tq4FShlS1ufLtjTqdN/V
 ynUoEk2rW0kkMBcPIlWS1qStEJtuNNX0p02G7CXKIQKbufdqLAHXGX7oMikziQ9eTCNp
 VHrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787213696; x=1787818496;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xxkAx+ltGy1OR+HDUf8EJGeRvBrE/1UUUmKV1gcNqpA=;
 b=BxMyeZnCkSdUV3S/LKGhyrDJ1WqsDk/jNT8eg1dch3SY3g9NbF9nljEYC2ya2UFRCA
 KOb3B50tdrib8ukPHbyXqadEVmhCTQ5Klw3ONhb/MyZB4nQ+B/ivCIC8f3tWAbXlHHuA
 dUxO/EG8wdGi0KG2QMbj0WsC1OOfBnd3nF/6p6UboLcw0Fg4VVfExVWXeFd8/L6TGT2u
 sT8afL78zaX0gcVKWnnTV45UYDuYjal3EMndFrR2mqWBqep75GzgO0IYtFDIWwuvitJ5
 ZmS8UR/VbsBC0dSjug87F3TzYvICk86Azh7bjycHPeib1CIwo9Wr35TT5dNzvOacBNsW
 QhQg==
X-Gm-Message-State: AOJu0YwaKEQ/RmnS0uWzDsEg+0KGMDExWhDtOYtqGHKRs0C2Yw4XjWbu
 rkMgg8fT8a9qHpAqkRfGjCOKpJ6kKgf75bTwyuyhHGnBxm2kp74Tpho2ppwYX/zAlpTkj5opu53
 RhW7lTKT/whqPFYNfUwAC4R3UExH9o4TP+EQ0X+xRqg==
X-Gm-Gg: AR+sD12YTif6vnGnkW26QK1cm/Gi7r8mHiLnr2dWAkKy/g4hjYBSAfDayykp0KfXOFc
 QxvxQCVN6mcFu0VdXEV/8cUH3O/GwSOr0IOkpEemHm6lfNlfvVpG98E1PLgXOOOw6r6ERQROJh9
 U05TAwLqwQG3+BFbSZ8Lswy+zkG138Pwd8+phsXvs4n6fQh+oDBlMFqWNg/HRL3513knMxi8DgH
 sPAXWJ7LZQ+rV7uePu3tt9T9lXnEBUeoVeZopxLZ8JKqV2mYu+Nz2y/ZuDF1HfODtCeYMSDNxBV
 uAv9SxiVkP3nkihKFo/HReF34Tlji6dP0LUx+8ApBic1glVhxq2wSQBE8VNvWSEvuExQ0pyZgbX
 I+Q==
X-Received: by 2002:a17:907:97cd:b0:c12:9b98:209e with SMTP id
 a640c23a62f3a-c242e2454e2mr642073966b.23.1787213695962; Thu, 20 Aug 2026
 01:14:55 -0700 (PDT)
MIME-Version: 1.0
References: <10e92a74c8a22cc2cd54f5dcccc31594016d4263.1787015208.git.Munzzyy1@proton.me>
 <CAKTNdwHMga0XG1zfgLYirMbVK8iVpWgjyr9x49sQ2ofPNu+w3Q@mail.gmail.com>
 <69c35eba7ee1a353107459b8f8032e92506a3fb1.1787045568.git.Munzzyy1@proton.me>
In-Reply-To: <69c35eba7ee1a353107459b8f8032e92506a3fb1.1787045568.git.Munzzyy1@proton.me>
From: Alexey Charkov <alchark@flipper.net>
Date: Thu, 20 Aug 2026 12:14:47 +0400
X-Gm-Features: AcwNN1VNKEx9wWiyJxyyOyaS2COdI0NN82FLg3Y7ePqYZOcVXrwLXUamjgTdrpc
Message-ID: <CAKTNdwF1NCoxumA135A+itxpvyxL3ekkjFTnvuQ3KfS3ZVSArA@mail.gmail.com>
Subject: Re: [PATCH] spi: rockchip: skip the unused FIFO direction on a
 one-wire device
To: Cole Munz <Munzzyy1@proton.me>, Quentin Schulz <u-boot@0leil.net>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Boon Khai Ng <boon.khai.ng@altera.com>
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

Hi Cole,

On Tue, Aug 18, 2026 at 1:34=E2=80=AFPM Cole Munz <Munzzyy1@proton.me> wrot=
e:
>
> The controller has a transfer-mode field that can run transmit-only or
> receive-only instead of both, which leaves the unused FIFO out of the
> transfer entirely. The driver never used it for that: claim_bus always
> programmed TMOD_TR, and the only other mode came from an opportunistic
> switch to TMOD_RO for read-only transfers.
>
> A device described with spi-{tx,rx}-bus-width =3D <0> has no wire in that
> direction at all, so now that the width reaches plat->mode as
> SPI_NO_TX/SPI_NO_RX, pick the transfer mode from it. A write-only
> display stops clocking receive bytes nobody reads.
>
> The transmit-only case needs one more change. The 8-bit loop paces
> itself on the receive FIFO and sets toread unconditionally, so with no
> receive path it would wait on a FIFO that stays empty forever. Leave
> toread at zero there and let the existing wait_till_not_busy() at the
> end of the chunk handle completion, which is the same thing that
> already covers a transmit component today.
>
> The restore at the end of a read-only transfer went back to a hardcoded
> TMOD_TR, which would undo the device's own mode. Restore what the mode
> asks for instead.
>
> Signed-off-by: Cole Munz <Munzzyy1@proton.me>
> ---
> Alexey, this is the FIFO wiring you asked about. It applies on top of
> "spi: Handle spi-{tx,rx}-bus-width 0 as SPI_NO_TX/SPI_NO_RX", since it
> needs those bits to exist.
>
> You are right that the first patch is a no-op on its own. With this one
> the Flipper One display bus stops running the receive FIFO at all: the
> MISO pin is the end-of-frame GPIO, so every byte the controller clocked
> in was discarded by the loop anyway.
>
> The part that is not just a mode select is the 8-bit loop. It sets
> toread =3D todo whether or not the caller passed a din, and drains the
> receive FIFO to pace itself. In TMOD_TO that FIFO never fills, so it
> would spin forever. Leaving toread at zero and letting the existing
> rkspi_wait_till_not_busy() close out the chunk keeps the timing the same
> for the transmit case, which already relied on that call.
>
> Verification, and its limits. I have no Rockchip board, so this is
> compile-tested and reasoned from the driver, not run:
>
>  $ make jaguar-rk3588_defconfig
>  $ make CROSS_COMPILE=3Daarch64-linux-gnu- drivers/spi/rk_spi.o
>  CC      drivers/spi/rk_spi.o     (exit 0)
>
> checkpatch --strict is 0/0/0. A full board build stops in binman for want
> of BL31 and tee.bin, identically with and without this patch, so that one
> is my missing blobs rather than the change.
>
> What I cannot check here is the hardware behaviour: that TMOD_TO really
> does leave the receive FIFO idle on a real part, and that a write-only
> display still clocks out correctly. If you have a board in front of you,
> that is the bit worth a look.
>
>  drivers/spi/rk_spi.c | 25 ++++++++++++++++++++++---
>  1 file changed, 22 insertions(+), 3 deletions(-)

Looks like you've missed running scripts/get_maintainer.pl on this
one, as Quentin is not on the recipients list and he definitely should
be. I've added him now. Please try `b4` for future submissions, as it
does both checkpatch and get_maintainer automatically, and also
records the base for the patch series in easy to parse metadata.

It probably makes sense to send it as a small series with your patch
[1] to the SPI uclass which this one depends on (and which otherwise
has no users without this patch). There is also something fishy going
on with your SMTP headers, which makes the tooling assume this patch
is a v2 of the prerequisite, so please resend.

[1] https://lore.kernel.org/all/10e92a74c8a22cc2cd54f5dcccc31594016d4263.17=
87015208.git.Munzzyy1@proton.me/

On a positive side: I've just tried it on the Flipper One, and the
warning is gone while the SPI screen still works in U-Boot for the
transmit-only mode, so please feel free to include:

Tested-by: Alexey Charkov <alchark@flipper.net>

Best regards,
Alexey
