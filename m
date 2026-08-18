Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25EF2C5DF70
	for <u-boot@archiver.kernel.org>; Tue, 18 Aug 2026 09:09:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 14F498064A;
	Tue, 18 Aug 2026 09:09:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IQH_NlLF6uc9; Tue, 18 Aug 2026 09:09:07 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B627080F3F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1787044147;
	bh=k416MjI+8rLAK93n8F+N5lQ5OG6N/h09DG6bRviQ/tk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QOOQlCvAlbyZwoSc079ufH4qB6Ts+bNhYcBevRmckKxWPQGlGFuLq7mgmsqo4GY0C
	 EwTXMP48YDkgFQWtrx3t735y2LSpc3f0lBcdXgzEbBP8hg9PRbWfhRFg4joU1YaAd8
	 XzOohg55u1EPuSAeN34RbAN+gDZfV3B17uk+drCobYQunA/OOCLX4XDE7LUCzPDHHA
	 ZLCKj5Iy73HB804gB2HBIu/TyV6cVjiKlJLWMJqiHuXAysDoYVnX3vgJPDgWLT0HEK
	 Ok6TeD1qHoibyUm0OIL6Ku0/Dk8f+dGCrnTnG6bAnH90MRzpNit61wnGqA8REN/c/N
	 5rFrIC9jcoayQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B627080F3F;
	Tue, 18 Aug 2026 09:09:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id E6CC9237
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 09:09:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D88C380F33
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 09:09:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sPTSv-76bbDS for <u-boot@lists.u-boot-project.org>;
 Tue, 18 Aug 2026 09:09:05 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::630; helo=mail-ej1-x630.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org EF38880EEB
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EF38880EEB
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=nnpOeS0E
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EF38880EEB
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 09:09:04 +0000 (UTC)
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-c197eaaab00so818515166b.0
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 02:09:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787044143; cv=none;
 d=google.com; s=arc-20260327;
 b=HN155Mdo+46GZeeLtUu3UDdrxNeGQbTTCko0GflO8eWX7Wsr1oTRq+7IiCC146/m2k
 kjv93a7rA+LKy99x+yVIr6gD5P9bCGarhrqvLyk1u05o8/850RAoj/24o8aaW0JqgdLJ
 O1fkMh6MtBKzsscfdvCNM+wt7xZ1cl2pVZW04Dz8g3iQr+4PJ3lQ7LUIixWZX/YOQgzg
 yZhPJQ/SOQy+CDVjFlihcB9GtKERnWaW2axNvH8etAAC31gJ66mn3zaqyIaZhjHdfkdZ
 2A53bTPXt64+P580XJgWOkCMkfWxXxVXuinL9F5otyMedPhipzdY/KIZdb8r3lnV4fij
 hpEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=k416MjI+8rLAK93n8F+N5lQ5OG6N/h09DG6bRviQ/tk=;
 fh=oeC4hiXUdh3cD7Z+46ECQz8jRnxlEFqJWOHzYTCxTpM=;
 b=ielF/j2oQlSmBe2gwDPKqgAKECLcsiMyd6P90cyBwyjwkascQBIKO3Bpmj/28/+u5d
 srEk+bIRor7UWsOa5KiJfiNCH7lClpBdqRgv2c8cRsQIACXRtxVv0cKCRRQYP6cYNVG0
 a9wRPQiDliqLGZpUdEVTj2xOu/6fOFsp5KjvJN3V6ROOljY3Jrvb1ZCb6gnlU7aMH/kT
 RVdMlPT3Iirw0VEj0GKRdPEvnolZKZ9TOZE+jpDKm8Y6TljwNvTLRlQURiqTyvvWkzFW
 vXvKYD6a4CrJoyEgOFd+IV5h4FDpjZDFKpJ71UdDfo+Z3mLgi+IxkYbfGkuL48YUCtV3
 p6Kg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1787044143; x=1787648943;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=k416MjI+8rLAK93n8F+N5lQ5OG6N/h09DG6bRviQ/tk=;
 b=nnpOeS0E0WzIbWYDmUaMx3NxDWB3gCaE89V4B0x3j8+unJvEdRPBKMsQ201CusuXA9
 dGVfJIe5IX7YYAkHyTGD3FnTZELUJT09CvMwjHpWFxLb5btZ2TUSwifVXkULem6RCcAZ
 Z3W48ni4o/1qhbG+gBR/Ijqe6SWPXcktnrclIb17msW7iO8YIaAOEj6aR4gYUc9b6T1Q
 tlHoeOPtvWnoXiAO4ii609Of8n7s+HVPKjvPQTfDa2mZO1RB8RpwfoA/acvjmWVXANLn
 F3Ej+c78+IzAeZskLmZ5RM5UzfoOaO1kKjeTpc4TUwoXie6e1+HCdY4hlJkU6mWFnzkF
 e9Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787044143; x=1787648943;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=k416MjI+8rLAK93n8F+N5lQ5OG6N/h09DG6bRviQ/tk=;
 b=Lv7wpLIVGhQrU1EYVCpyjsC1UVIZva+6Or4UOe/yPUhoZmGMU75coC7UFuATKesd38
 Xbn5ok3DcLltdNUP8Rb0eAGSJVLDyX66PO7jRX2oQapxeScvqRgk48iX14Fkc+SwzRSz
 i0uORycOSkMYtYqQs8zsNYEg8DX47fYg/fW/6jyGFOeobp8KV9xCSD1IlGul/nQdkX/V
 VshzRSAQqba25/2ZtkEMhdXUWy2htNdYSoTt118rbUI4Onl8zI9QkMxnzTbddU/t75Bb
 yXPl8yMQ5KviD7P6sjeqfliH+xXwe0N4ZA4aqNWTsvJcnaBUw3f9eeXFDz/hoKgAHjyq
 5lqg==
X-Gm-Message-State: AOJu0Yzxzgq9EmWlCyGj2DCoIbeVIWWOzeckQAEwvMuDxOOTVCRtreRS
 v/36Xucb61Cz9EQ1+LyswQj0TO1FDYUMllMeKrXyxcSXV7allv7nNOXVFQqANq229SEmcl+7Dfa
 ZuTEBE0wbomCIYAG3Hw5jLfhReD38PRi+IqPZN6TQqQ==
X-Gm-Gg: AR+sD13Pa40sg8E0IlyHnjhGL0n5O1nsLMFxRxSEtjF347fX3lY8o/mZ44L3PiIHw3m
 6Rps5p/sCWARq9xAFmkHwIMFLDkf6NOBDKSKNnRQCBAH5fWWd7RNr5JWOiBU6KjxNH6Sr+6Jyry
 9UGjhPwGaVNBvoKN/L8tmebYY2TKkYsiLUtl45vJ48fl7E/DXMDKh5yS754bgo/GyiBLrPF/XZ0
 NAXnWWbeSnkRZXLon77ZeEzrhpRfQ0ayk+ZACLHj8Z19gOX4ah+39MNAs9z55Z2UDoNjas8G6gK
 8QhdZ15jL3yLOWAdsCBL70ULuPffvqEswhmQZ4p98N/tYxi6sgUMnpKcUhrM4glKReCULG4NhwV
 sxQ==
X-Received: by 2002:a17:907:f448:b0:c16:8adf:f183 with SMTP id
 a640c23a62f3a-c212a0443cfmr1465374866b.14.1787044142808; Tue, 18 Aug 2026
 02:09:02 -0700 (PDT)
MIME-Version: 1.0
References: <10e92a74c8a22cc2cd54f5dcccc31594016d4263.1787015208.git.Munzzyy1@proton.me>
In-Reply-To: <10e92a74c8a22cc2cd54f5dcccc31594016d4263.1787015208.git.Munzzyy1@proton.me>
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 18 Aug 2026 13:08:54 +0400
X-Gm-Features: AcwNN1V_KNVsPyCXk8V7vljEK3U5z-2Gdyb5F-NrU17ZGofmMwlLI5ULGUnxvns
Message-ID: <CAKTNdwHMga0XG1zfgLYirMbVK8iVpWgjyr9x49sQ2ofPNu+w3Q@mail.gmail.com>
Subject: Re: [PATCH] spi: Handle spi-{tx,
 rx}-bus-width 0 as SPI_NO_TX/SPI_NO_RX
To: Cole Munz <Munzzyy1@proton.me>
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

On Tue, Aug 18, 2026 at 5:15=E2=80=AFAM Cole Munz <Munzzyy1@proton.me> wrot=
e:
>
> The spi-peripheral-props binding shipped in dts/upstream allows a bus
> width of 0, meaning no RX or TX is possible on this device. The
> switches in spi_slave_of_to_plat() only handle 1/2/4/8, so a width of
> 0 falls through to the default case and warns "spi-rx-bus-width 0 not
> supported" on every boot, even though the devicetree is valid per the
> binding. The fact that the wire is missing is then dropped from
> plat->mode.
>
> Map 0 to new SPI_NO_TX/SPI_NO_RX mode bits, as Linux has done since
> v5.12 ("spi: Add SPI_NO_TX/RX support", mainline d962608ce218).
> Bits 16 and 17 are the first free mode bits.
>
> This comes up on devices with no MISO line at all, such as a
> write-only SPI display described with spi-rx-bus-width =3D <0>.
>
> Signed-off-by: Cole Munz <Munzzyy1@proton.me>
> ---
> Raised as a boot-log warning on Flipper One, whose display has no MISO
> line at all: that pin is reused as the end-of-frame GPIO. Reported at
> flipperdevices/u-boot#33, and sent here rather than to the fork as
> suggested on that issue.
>
> Verified on sandbox at 527115ef6783, with spi-rx-bus-width =3D <0> added
> to spi.bin@0 in arch/sandbox/dts/test.dts and CONFIG_LOG disabled, so
> warn_non_xpl() reaches the console the way it does on the board.
>
> Before:
>  $ ./u-boot -T -c "sf probe"
>  spi-rx-bus-width 0 not supported
>  spi-rx-bus-width 0 not supported
>  SF: Detected m25p16 with page size 256 Bytes, erase size 64 KiB, 2 MiB
>
> After:
>  $ ./u-boot -T -c "sf probe"
>  SF: Detected m25p16 with page size 256 Bytes, erase size 64 KiB, 2 MiB
>
> It warns twice in sandbox because both the pre- and post-reloc DM scans
> run there; the board logs it once.
>
> ut dm spi_flash, spi_xfer, spi_find, spi_claim_bus, spi_set_wordlen and
> spi_flash_func all pass with the property in place. Nothing consumes the
> new bits yet, matching d962608ce218 in Linux, where the consumers landed
> later.
>
>  drivers/spi/spi-uclass.c | 6 ++++++
>  include/spi.h            | 2 ++
>  2 files changed, 8 insertions(+)

Thanks a lot for the patch! It looks like this has no users in the
current tree, making it an effective no-op (apart from silencing the
warning).

Rockchip's SPI controller could further benefit if those bits were
wired up in the driver, as it can disable the respective FIFOs
altogether when unused. Could you please look into that as well?

Best regards,
Alexey
