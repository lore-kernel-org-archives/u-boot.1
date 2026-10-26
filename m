Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F51660A2607
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 16:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=VHMl4KDi;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=W58dTcZI
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 27858406F9;
	Mon, 26 Oct 2026 16:10:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FHQ6YujgZ_XL; Mon, 26 Oct 2026 16:10:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E4DA1406C7
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793031019;
	b=T6GxgZetqOjhlYW3SYzgXvS2eyjM3tZ67RVjI7DJCg9n91V7YTJdYE9KtaBOuBSm/lgC
	 VPXBpqGrl9OjctCabQsMvVXJ7n0GTTicVAmBTFMLkNyF12xBO1AJ33mrc/LrieE/HmjJs
	 NKswX2lXOHFhdnPtMQKmq20q06RShT/7vlOLr63wZnJiNW7kRtkpl5/l9v3KURc9Vontz
	 TTpVy6OU17H45857KnlYAK8/enY97PtiSjgaeSv6Zogd3iUSec9Q6P4uPp4q0Aqhcap1Z
	 BQjV1RpHWJ1Ejy23mEzULBoh29aDDAwgxoNvBC2EskgCAVB+ZzVxTn8Hw+e1JD21YQw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793031019;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=2NycxenlzOURHbmQmk8Nb+snGJcvw073epC7CnqKeNc=;
	b=mRdulMJreKcY9LkrlrlaUUQ3hYyG/XR/zQiLXMkprsN03/mu89kmXnWXuuH27UNj6g8O
	 WwowUxvJT3ISB+YkkId64ndtqTS5lsEqFJZKWrEcp/ScBJlrYu5QPBxwYPe85c6vknuH0
	 OYKVAkysfN2fFzmaOXc3P2jfbjsENMie/h55+h8gw4wPJ2o9+i4N/nbNntUXl5PpVeEeZ
	 ikmY+2c7cYKoJGt9oMATkDUGZX1w7bmyounAj5u1Arw5djcJiHE8OeQ8QQ9uYRgmijPyD
	 gieAz1a37XdNJvPiKCVZcPTlXiCL+NKz4p3wqiSFLq5xCFDHGLajyHyf1zcWQbr+lbg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793031019;
	bh=2NycxenlzOURHbmQmk8Nb+snGJcvw073epC7CnqKeNc=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VHMl4KDiFqb3pYZKOu/EEa1kucw8j62c4q4/8u8Udq3Zj4rP3b/6JKQ6MEZTEcvt0
	 LwgzpEDYKF01X0jDAwK97SXMI5G5qRIyhPuIwu6fPucRyMqLAzxA1vA5VQUwsheusR
	 LNN+Bc0Cp7twtTsV+OI9HaziO/tNdddHMBWOQC9ilQjvJmCXXfsQ0eTpG37f+W1A/f
	 BodtBv0Wg5xPYk5ZZoDDDvSfRgHYGoGacdlj8d8DTGdtw/ETliw7G5IHy9S0IJ4YFd
	 Lyr5Ap0BpLBYGVa/5Gv6OMxDb03S453rvh0z64R0lfkC9TrGPHCUgcBEu7i5ioefB7
	 VEiaw8kG1Eeng==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E4DA1406C7;
	Mon, 26 Oct 2026 16:10:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 48FF62F5
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:10:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3A64D80E78
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:10:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zeZM5pcpLvNy for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 16:10:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DB7C280DDF
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::52e"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793031016;
 b=DZ2FPhLOHz3zVo4wfptB3XCMmKqQJkkjq8eciAu6xttaRKze4zGJ8XD38mZk8aUYA8Wj
 sAuuYsgVryfH5MtN9Jdc58FYdWO6uIZHesz73pwBcxhdB/jusb3HgPT8ltQEUwiY5pD5Z
 17pigZzpOgegbVFnFSrKccbry0hnYXMqfCYbGrGskO36t96r7Wgdv4DB4+H6NJvEqOCHb
 wcaOAWLYDeoD54Ddx/l2AGMMfhchalm3dHBYr+WdGXaWYcSTn37q1AhIlojjPVpCDc0Gb
 pj7fPFVGq90MRbwAacfDEq7RlUdGJ9Cwdj9p+f/WYMSZXTgn/CpSLZWEkCQtdxZoS/Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793031016;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=2NycxenlzOURHbmQmk8Nb+snGJcvw073epC7CnqKeNc=;
 b=HnB3uCpEudo8775ZcctIOQ+xQnqdee5UVGuAfkHInyIcJhN0TzoTq2HXRLNX2zVf5r9O
 4btXt98s4RdCXgPz49ofww/TnIFaFIF1pgOH310k6kA5piTN6QWvGWKUNp5SV9ZpJOrLW
 /OBSW/KpBw9ragULwYoORerO2EVPbKRtqUqJJlQVItKKb2a6m48W/cblQqiZiNdWGCq6x
 xaAbr3r8ycAs5wtyqzJ3TmFqlLOOnPxZiWRYw3sZ6qEbkLxr/pFSVgf22QSqt+pAfMU64
 gdp5nqjEi31ijYMA1p1wq9HtSOSeGtRUGTPXIZ68tVOWtHMu9gqxAQmxbr+c3SBPeaA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=W58dTcZI; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::52e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::52e; helo=mail-pg1-x52e.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=W58dTcZI
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com
 [IPv6:2607:f8b0:4864:20::52e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DB7C280DDF
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:10:14 +0000 (UTC)
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-cd5e2d696e0so1717635a12.1
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 09:10:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793031014; cv=none;
 d=google.com; s=arc-20260327;
 b=ZRtryjkTWdG2ickM9ayEmiYtyI1b300604y6eNhS8QGujMyxr5F+jWuOiH8gYg750m
 mX3Rn4TffNzegnPYyVlS5iJxODlXP/URDZfVbdXfbn9YKYnhl5ecp/Zmq0R1fNPCrbEt
 UCkbetZOaDBitvv4Y7eAJ0gnh6+I5AgVZfGsNN0BIao4vz6aQKLsCpIwzyvKuEveJR/I
 IyGs2CLlyxkRkN7KGZdV1YkGYCaoRohFGB62Nn2mxk5nuRt/4Ugwp0GLSiLcswEaE5MU
 BqEDW0nqi3+SKIBa4fXYXjFUA+cLoVZq/PN1a4qj/lSLMdH5tyGvBSg9CAQGYeSY3UA4
 A3kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=2NycxenlzOURHbmQmk8Nb+snGJcvw073epC7CnqKeNc=;
 fh=FFvugHYPGJno2OmNliXs7Vu/zymgXzcY+BaC1fxfq3I=;
 b=VWx24QRorLf3JypGZv3nQNzeuHgMYR8Hz41QDbo5Br0StU0Fs1O4/foAqCLgl/0b/K
 IeRJeXSWIkpX6+xKQGSdy1Y3SGEyRKQZFpPtkZFSBCLP5L8oNYHYd2ZEUUGoWFkU7MTq
 Ce6l0mja1Wsc63SSQxAoE8mBMXeuxB+W2RfFDs1vCMpmDrfDBRUSWoV7FZKPxkk0BKll
 LhGffePkSbk0/TUGi8rtmJzLr5gdC3VW0SMdxezGSptfTMlATUD4TlkahtEcs9f75qGE
 Vp9MA/Hsd/irCSpmSWBtrj9FI5bC9tJSX3bk/XOJ2pbwxCnIIdFdOaKlU607jz9LdvuJ
 3wog==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793031014; x=1793635814;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=2NycxenlzOURHbmQmk8Nb+snGJcvw073epC7CnqKeNc=;
 b=W58dTcZIwZlgNMtcpIKcuuU2OChlJ+mXjJeUzexSOIZbSxT7rV1C9z2QgWEYLOuvOs
 vixnLIfYZOjtAYR0hGLfTGb9qhbOcaKI6sQNCpFxM4ogK7t9DBr4/dpd93KF1TkHGEXY
 bSO+EDR2E0OrP+/ko6+nTiP1QzUEjJZRxiq+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793031014; x=1793635814;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=2NycxenlzOURHbmQmk8Nb+snGJcvw073epC7CnqKeNc=;
 b=HtGBUkbR4IYoUFCcKmx36aHL044W6ZAy5VptH4Dm/SQu4RltlBa4sfx3CsiSbxvaXB
 L6NPzWcF599BsVT4TdAWHqbahe3l11mlISrznzPY3vQLJxrr8HOzk/us6iwUgHPZT298
 tLBAQQ4q++6DH0C8KAiO3iMBLLCRQB+pbjK3MkgsFMLyw/1f+MfBtMmOTluG11mb3iE6
 ywQxXM0E5i+RIVl8o6QtcOhHIrnyoPKsV8NU06mQu7wiwc4Lyen/cRtP3YHKbrw8SS8u
 M5Ipdem+awY7fv92Idg4RROqIOxqUawWaLicnCbGauxOsso3pN7I1m4B7f80iT1wQYZh
 6ijw==
X-Gm-Message-State: AFq9FYKkam8ENeC+53MJZbBncAgveQBIRKBVIbb0iJ/4St+i2hjnOoLQ
 IkHUHHqWxaWSk/9F1+sPiPSQaD6Mdh5VFKk9iTurKG7D6JxbIffpoFW5hQiHkZ8Ys0Gm3uSaR6i
 E/cEGRY5lCFo6uCSYGmh9IpftxatUpPkBdQ+DraVz
X-Gm-Gg: AYBFou0fYKEzQqwM2mpxmR0TQVjMXtUKx7+smLLzNoqWwU8QUCarzPOfct5ImsmcXAZ
 dgAAxTennzOrudkMeRg0L4vtTX1nW+Cm/RHZw82ONdB9YgiUHPBR1iEsj9jjFbGmWmRshbYc65Y
 pqpDTB8oRtZaXmGIDibjQGvGlJRERc+R4WLHpGfVq3/0OJWQh9vauvhOeZMt12WoSNJ8fuyW0+l
 0CfBKs2vj9pcbFD772AsQymZV2lfwVCEZz3fRkRYL38QrFe1Ieg8mLVGBShvA2Zz1jyO9DmkKXt
 vhePfrrfxJRGDamB5Cc6h6niKJZjluf3nDCberwkGmu67GBN0anSHf8NEmJe4SP6rO4uRRIryz5
 W6P5GAWyim5Nd3YMt0Ox2Z7XYXKJ+wzvTW0M=
X-Received: by 2002:a17:90b:4a81:b0:3ad:ce24:acfa with SMTP id
 98e67ed59e1d1-3adeaae632emr5851208a91.20.1793031013641; Mon, 26 Oct 2026
 09:10:13 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 26 Oct 2026 09:10:08 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 26 Oct 2026 08:48:48 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261026-rfc_i2c_nak_suppress-v1-1-bc01e8393b9a@ti.com>
References: <20261026-rfc_i2c_nak_suppress-v1-0-bc01e8393b9a@ti.com>
 <20261026-rfc_i2c_nak_suppress-v1-1-bc01e8393b9a@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 26 Oct 2026 09:10:08 -0700
X-Gm-Features: AclHuK9b3bocfQjUUDi-6ZM62Z22EcrLO-oHhHYMqGzBtJpz7TgqgL2EqMhRez4
Message-ID: <CAFLszThHJ4XBDyUBKVNwCPzOg_5Ym9sTAh-+zZLKNk=PsarK4w@mail.gmail.com>
Subject: Re: [PATCH RFC 1/2] i2c: add flag to support ignoring NAK responses
To: s-jain1@ti.com
Cc: u-boot@lists.u-boot-project.org
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
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Swamil,

On 2026-10-26T07:16:33, Swamil Jain <s-jain1@ti.com> wrote:
> i2c: add flag to support ignoring NAK responses
>
> Add generic support for the DM_I2C_CHIP_IGNORE_NAK flag and
> I2C_M_IGNORE_NAK message flag. This allows I2C transactions to treat a
> NACK (negative acknowledgment) from a device as success, which is needed
> for certain devices that respond with NACK in normal operation.

I2C_M_IGNORE_NAK already exists in i2c.h, and mt7621 and tegra186_bpmp
already handle it, so this patch only adds the chip flag. Please can
you put the motivation (the SII9022A EDID read) in the commit message,
since the cover letter does not end up in git history.

>
> Signed-off-by: Swamil Jain <s-jain1@ti.com>
>
>  drivers/i2c/i2c-uclass.c | 3 +++
>  include/i2c.h            | 1 +
>  2 files changed, 4 insertions(+)

> diff --git a/drivers/i2c/i2c-uclass.c b/drivers/i2c/i2c-uclass.c
> @@ -65,6 +65,7 @@ static int i2c_setup_offset(struct dm_i2c_chip *chip, uint offset,
>  		msg->addr |= (offset >> (8 * offset_len)) &
>  			chip->chip_addr_offset_mask;
>  	msg->flags = chip->flags & DM_I2C_CHIP_10BIT ? I2C_M_TEN : 0;
> +	msg->flags |= chip->flags & DM_I2C_CHIP_IGNORE_NAK ? I2C_M_IGNORE_NAK : 0;

A chip-wide flag ignores NAKs on every message to the chip, including
the offset write and all register accesses. Real errors, such as a
missing or wedged device, then turn into silent success with garbage
data. From the programmer's guide it sounds like only the EDID read is
affected. In Linux the client driver sets I2C_M_IGNORE_NAK on just the
message that needs it. You could do the same here by building the
messages in the bridge driver and calling dm_i2c_xfer(), with no
uclass change at all. What do you think?

If you do keep the chip flag, the flag translation is now repeated in
three places, so it should go in a helper.

> diff --git a/drivers/i2c/i2c-uclass.c b/drivers/i2c/i2c-uclass.c
> @@ -283,6 +285,7 @@ static int i2c_probe_chip(struct udevice *bus, uint chip_addr,
>  	/* Probe with a zero-length message */
>  	msg->addr = chip_addr;
>  	msg->flags = chip_flags & DM_I2C_CHIP_10BIT ? I2C_M_TEN : 0;
> +	msg->flags |= chip_flags & DM_I2C_CHIP_IGNORE_NAK ? I2C_M_IGNORE_NAK : 0;

A probe works by checking whether the address gets an ACK. With NAKs
ignored, dm_i2c_probe() succeeds for any address, whether or not a
device is there. I suggest dropping this change.

Also, the flag only works on controllers whose xfer() method checks
I2C_M_IGNORE_NAK, and very few do. On the others,
DM_I2C_CHIP_IGNORE_NAK silently does nothing, which should at least be
mentioned in the comment in i2c.h

Regards,
Simon
