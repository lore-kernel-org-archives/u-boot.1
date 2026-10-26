Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA67606A326
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 16:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=xiqR+2/G;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=BrS/uNiE
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 80C8C40733;
	Mon, 26 Oct 2026 16:10:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2eqzR8w95HKX; Mon, 26 Oct 2026 16:10:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9A77C406F0
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793031021;
	b=m6tV8FxhxNGEHgNCZS6ZEmrIlKQfntPD1U5zwi5CdA+bJpOXiU8a1oWdvWjS5wVBnfD9
	 DA6vgqGlZTFdTc08hpVCmoe6V41EF1/Hm7h+x37gpS+K4r210CxFvIWE5FQqJTxsR8b0b
	 6oBgNo4Fe20VE04nB1vJHJSRvbPb5DU29ALvSVgu3g5kUvlkL+3mlv4CGgE2aAIdHUK49
	 V1SCVzSWb8mqvpEOv4x/8xQJwgUgVzs4WsVtNfPgy107l0eFwS1HxfP8i6CjeqEeuHeHV
	 prIRw7qt3s5wBy5hCwajgxzyRvv39U0W5wWkYASwY78edlTBOvREzmKjfhlQe4tH98g==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793031021;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=DNqHyF+yp2dzW0vKmA12vvMJETJXTumqE0CEFhVeQYo=;
	b=W+pVUXRNhIlnHL206q782cXWFa8dCQnSn9nrFdRJHflFaqYlnIkQlsN+VguLuDKjkAHb
	 KsCREH4UVYy0Ot1fpeiuqmSgGPT02O3He2RG2F4x54h6dikdejWNDygsh/v36564a/13C
	 Y3DGUYTXM9FruF7GL6nxz+8raEfsMaEHKDcq3jPvWwz/lYs2zVPzdCSLehnVsbm42PGLd
	 veNY0Rj0fuXlXSI7ahIqrC65FD4s5zfebP+EPTX19MQbcau0lhGK3hlDW0GrGhJN6sqFl
	 boeUSkq5DhkcPGPAhLyvX97re9QxkCcSQmyti3CWNlGbhbON4QfeG2VZ98K7kPCJ4Sg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793031021;
	bh=DNqHyF+yp2dzW0vKmA12vvMJETJXTumqE0CEFhVeQYo=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xiqR+2/GntKpEkeZS2plkScq9Hq8NP5kSU8IfvxqLTngiwFDHXXxkJfehs5O/5Aoh
	 E27acaqZvhFKIyNWYaj5fiEUySY3/PVLV7n4kOA/0Kvi6y01b93pLvYZ16BEAZDk1u
	 hJY1uDdmXBHFFLy6/NTAXSC8cbAUD3hXVGGKSeL7diK340imPARcax4W9nStAat/zj
	 6KxU6WImoXir2NgR9iHJfjQHp0hJH/cBe2QtiJy2IMbx9kJ/HEbWa1rJcD1Y/IatRh
	 QFk/mKalKxg+epsqu/pprkLgm4lHp/PgJfMiNQLh6dxJV2lLmlKF2matQ/1D8GPceb
	 93c1bv35ZNHWw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9A77C406F0;
	Mon, 26 Oct 2026 16:10:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id EC697235
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:10:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D22ED60612
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:10:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f7LmuzulaXcP for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 16:10:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org BAA6560603
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::102c"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793031016;
 b=BAKXQ4NxsjpFmJkzVq5sWfvGDpMO7uX/yIQaYgH5peEoOqCWqaa/b5TCjR4jLkirYU5J
 ivFIsRPl7aOYZ+BsbifKbE5PcPwJaEBp9dnG3/hIpGGqy33XJ9TZFGXkLDKwcMDMpxQSa
 lVw6L2AdI4JgBa6CsesLRrI3C5uhplLAzrJ0R2tBG2iG0nAM8V933lKHebWWNVT3tOxPG
 8m6NcsJMS2brx95Td/3BN/2s59mNN32jR4Rnlv0FJ72fYDZqw/vABjmQkemUaoruv7861
 tuqktxFN6UpHZPtlStu++HCdBBh6pGe1N4k6ht6NdTNMRTLC58rKo/btfTOvSKuiw4g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793031016;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=DNqHyF+yp2dzW0vKmA12vvMJETJXTumqE0CEFhVeQYo=;
 b=MaQ3jaw/A4bu2ZAtTLTLl/289gWVmk4E9306TCPD36TfKYO8HFyBYW7hBeYZCUSOmFvW
 hc55pvgNV+E+ihqauvrtxhu3DqwP+HbOpkbbePF29dvTaPiFBfaD5916lpf+4N7eODx0W
 94Y2bhfzStsEp1uA5yCKeWUW1+LWMPSZF99ECiCPYiTM0j7J2OmMi8WnVNbLp1UqPuTu1
 qWGgNk6xwn671L8GE/EOLhTTGcZp0HJHwGx2fF2gtLA3xVnN+/jdx150UVt8CUwVukKdL
 8T3vzP5J0YQ6AB53ZABbGJ0k3lW7R2NpwdCegOaPy3RtyxyCzEC4w3rdOGjgkcHZkZQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b="BrS/uNiE"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::102c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102c; helo=mail-pj1-x102c.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=BrS/uNiE
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BAA6560603
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:10:15 +0000 (UTC)
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-3ab60ff4273so2624127a91.0
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 09:10:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793031015; cv=none;
 d=google.com; s=arc-20260327;
 b=phH6u6pEC8egJIw+vw01EaFoZ9xy+Iblv/bx1GP42wJGAlbp0XDOpMFTZxkaeEIBmq
 Pe9Ex9kZv3P+hxeuV6C71cFcHjzKyom0JwSugX6PvWq/ADlajGVavXK0LMpMN4a3S/5U
 fADvg7bLtFA0XFBmOwxPDt+9tGOu7VU+dB82jYJuwkwGBGMQQkdG2erNE0KpzPh5yJa2
 DUb0BADsEOWF7GEjn9ayzUUdtTwqn7MMn7PRuobtu0j/RoLFFEgVG9FO67l1xJve8GDW
 7hMLxM7WOc/Eq8LuTDhTHOTXZxBIZ51M4zriqvuAm7vliTTx7WSsNwYR3t3J8eZlJd1e
 Ctuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=DNqHyF+yp2dzW0vKmA12vvMJETJXTumqE0CEFhVeQYo=;
 fh=FFvugHYPGJno2OmNliXs7Vu/zymgXzcY+BaC1fxfq3I=;
 b=iu96zpHtZF2iuda2Xqxy/WubHXOxKMzZuT57132Sj0wLBlDMtEHU1HvOx/MAxgLRu7
 quLq+z5B/N+YqLduk9kc78062IoQ+kXMXESn5ug8YaFqcbcwj6zdCDuhbMc313P2k+vT
 TMElpBuV5qxNQYXab0Wp0YjMdXhH6bpZG0EiDKkx8vWADQ/pmUWrdoerQhuHMPC5izBE
 75efUqFT1gV+n5mOYCWasu7p3VnQlJE7LaPOv7eTgsfNMhl++0X2NP+CqNo/peOd5X/7
 8w3UnrVEh1RnJr5/rAjhUpf8sOxHPLLEk3coCVDTyCK51++q5CxV0Gi6ughsHITHk4Tx
 6faw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793031015; x=1793635815;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=DNqHyF+yp2dzW0vKmA12vvMJETJXTumqE0CEFhVeQYo=;
 b=BrS/uNiE2EkLDXlFLO5qUGaihmLxXtOZLBBg0MgeE4/XskpsqivNR2Aj7n3WsXej/v
 ZE92hiOTL3OXHPgaWXoik+12fPtVeTCNh7MTsmipfcHdCcvzuz6Woy/IGHCWrhNRmJQC
 ezFOLSUQqCAOp0+CVh1fxvl3Iy9mJkbNLS4Hw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793031015; x=1793635815;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=DNqHyF+yp2dzW0vKmA12vvMJETJXTumqE0CEFhVeQYo=;
 b=B6LhTvw40sZUz2I+KZTDDXvlW5JEQQf8ktoa03WX1ZRpiWMJv3GMUIc9L0xPO/qXsm
 P9ihHRnp0a4aX0EgX81mlv3Dg3QivFEYQIf1przjEqbefD9NTQKpfkerGslGv8dEL/z5
 IJeGe0UBg5TkEIVUeS/g+CM623aaBUzI8/mN+XCZNyWc227iwo5EJ5TEt6efkbM7ROdw
 3xjyBi34Jdb6NfuQVpNI9i61rVNIQUV43tZZp4SfaAAnRf7+9texM9FvDFLCxMEzn0ZB
 A+Tq/5SkN22mzptpmKio5JvCsNHiKzSEXjpznSk0whfS0rAtQnltjIdXChXyClmNk4fH
 pyuA==
X-Gm-Message-State: AFq9FYJefCpcN1Sjl67BOWDhL5FejIuU70f0sGkvrMqj+P+CvxON4eyC
 TV5kroIEZeoN5s8ZwE+K+bDquc0YG1M5GrCXJ6ZYYtJ8g99Zl1JYRrg7fozL2DK+etn3Uj0ZXdF
 kLrbPvKmHCiIUQzFxaVWl291rl/HJsOpG1MQ0an/qvopozBZV2bk=
X-Gm-Gg: AYBFou345bqncy2KYQSJbyS3Q6G0Ym5SpTkiEb1ioaOEzWAJEIcWEQ9gfhH5TJDSjOm
 T4JNA2KcsFGdO+ANkRL3EdSfqcRXlXrIPcenvLQF7VHLw/e7DycuC0bymWNR/BOJGfcoq+29co2
 SDcUj1Yc1YOtrvkMq3caTx6kpjD8MDSjQIT2cyTvXOCImSJGH2v6fFtUFcRZNHK5fmrkKZ0qEhb
 CHq+qXr6napcmoIhKA9JIZUBlAUdmQzYqnMWbRV5i4VIsgqs191V3GzYvEnWMXBEOP8ShPAzpwz
 j450zJCVKq5WGb1n2KCfqsJf4eGz8dPDMu0GYrEWCOMts5nexGvQkCU9Unc9XwrjgDteoNptgT2
 smo0Pm4CgmkrfI05CPs4VLDngJ1rKCQBqKb0=
X-Received: by 2002:a17:90b:5746:b0:3ac:8897:7b92 with SMTP id
 98e67ed59e1d1-3adeafd647bmr5986189a91.57.1793031014572; Mon, 26 Oct 2026
 09:10:14 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 26 Oct 2026 09:10:09 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 26 Oct 2026 10:48:49 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261026-rfc_i2c_nak_suppress-v1-2-bc01e8393b9a@ti.com>
References: <20261026-rfc_i2c_nak_suppress-v1-0-bc01e8393b9a@ti.com>
 <20261026-rfc_i2c_nak_suppress-v1-2-bc01e8393b9a@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 26 Oct 2026 09:10:09 -0700
X-Gm-Features: AclHuK_A_FELFWaNrv_Ru7OnFOVp9eZnzqZpz6fJpzq_gZq7WiVyTjfdirFJZYY
Message-ID: <CAFLszTgTM_H=2f-iqBRULVVH8ViFaxDBy0pmzdUwxTGSdXBrNA@mail.gmail.com>
Subject: Re: [PATCH RFC 2/2] i2c: omap24xx: suppress NACK error log when
 I2C_M_IGNORE_NAK is set
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
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Swamil,

On 2026-10-26T07:16:33, Swamil Jain <s-jain1@ti.com> wrote:
> i2c: omap24xx: suppress NACK error log when I2C_M_IGNORE_NAK is set

>
> Some I2C transfers expect a NACK as a normal outcome. Add an ignore_nak
> parameter to __omap24_i2c_xfer_msg() so the "error waiting for ACK"
> message is only printed when the caller did not request
> I2C_M_IGNORE_NAK, avoiding noisy error output during expected NACK
> conditions.

This patch does more than silence a message. With the flag set, the
NAK no longer counts as an error and the transfer carries on. Please
can you update the subject and commit message to say so? Please can
you also say which part of the SiI9022A transfer gets the NAK
(address, a data byte or the last byte)?

>
> Some I2C transfers expect a NACK as a normal outcome. Add an ignore_nak
> parameter to __omap24_i2c_xfer_msg() so the "error waiting for ACK"
> message is only printed when the caller did not request
> I2C_M_IGNORE_NAK, avoiding noisy error output during expected NACK
> conditions.
>
> Signed-off-by: Swamil Jain <s-jain1@ti.com>
>
>  drivers/i2c/omap24xx_i2c.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)

> diff --git a/drivers/i2c/omap24xx_i2c.c b/drivers/i2c/omap24xx_i2c.c
> @@ -1009,10 +1010,12 @@ static int __omap24_i2c_xfer_msg(void __iomem *i2c_base, int ip_rev, int waitdel
>  		if (status == 0 || (status & I2C_STAT_NACK)) {
> -			i2c_error = -EREMOTEIO;
> -			printf("%s: error waiting for ACK (status=0x%x)\n",
> -			       __func__, status);
> -			goto xfer_exit;
> +			if (!(ignore_nak && (status & I2C_STAT_NACK))) {
> +				i2c_error = -EREMOTEIO;
> +				printf("%s: error waiting for ACK (status=0x%x)\n",
> +				       __func__, status);
> +				goto xfer_exit;
> +			}
>  		}

One thing I'd like to check here. Nothing writes I2C_STAT_NACK back to
the status register, and wait_for_event() returns as soon as that bit
is set. So I suspect every later pass of the loop sees the same NACK
and returns at once. Unless XRDY or RRDY is also set, no data moves.
For a read the buffer is left untouched, yet the function still
returns 0 and the caller treats the EDID as valid. Linux
omap_i2c_xfer_msg() treats this case as the end of the message: it
clears the status and returns 0. Doing the same here seems safer than
carrying on, e.g. going to xfer_exit with i2c_error left as 0 so the
FIFO is flushed and the status cleared. What do you think? It would
also be worth checking on the hardware that the EDID bytes really are
read correctly with this patch.

Regards,
Simon
