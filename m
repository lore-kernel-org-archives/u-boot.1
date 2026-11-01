Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30774606A325
	for <u-boot@archiver.kernel.org>; Sun,  1 Nov 2026 14:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=tEGQYlWh;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=AS9wPvDi
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DB3AB80D64;
	Sun,  1 Nov 2026 14:59:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id io_GfpxmzYdL; Sun,  1 Nov 2026 14:59:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2016780D2B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793545167;
	b=AKAVMJNMvWfY/uBcEGIH/sgVGcOsJVFlgPNsJsaXiRaZtvoU2cYUbMdqrSmtZQ3edZim
	 wtz1XNtltNAo4aokkVs/NY3rZWZuZ++mb/e4LKZBk2jRPSjcszJWx16n7Es/jL4oKNwd6
	 7dHknymP8VKv58FI8Gg5zWnv9shddaMyyd18UlPHsi4kZ1JN8Y1MCx3Ab1jiTvxkFCUXO
	 VfrfpRj0HA4T0d5F3Cmzi22bmVnoSMt+ieLwoET5NSyEGAJbbVvaGO8AwCzYtvz88Zuc0
	 QOZCNHmj9rL0/IY5nwpPPti5UpBCEUJoXkJJYz/sXXK0DxzlsJtd/7KZLgYeb1IFzOg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793545167;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=c5/DUQedsaWfij8qAImYoe4bBENNc6bIp3uImO+29+4=;
	b=q2iE+QJRbA1N7IELwBLKLdUBtFGsv7ZklIOFPyFCkcflMtDw5Q5anTPSAAg9rfARLa09
	 V1bWvRi6ByTWBbyd4K0Azo4NtOPlwDnVWon+ChAzv4VlVHSSY5kUtRjfJ7N8OC4i9Sb3N
	 HevDlnWVGZlomx/eisNpw3NXoTjgaKqMZu/vJ2cHu2ATEcsCjCX7265HQmZ/q30Rnv9MN
	 jhU56WkIZ2WW+9jtgMmCa8AfRs/7TNdCug8jnqgdKWGkOmzehVI6WNNsO9xd9VidGn1PP
	 0yzmdk4XV+oheEyOHsGK7Fy3rxJbVh/bJTxYnQHm4ldfaGmZzkaH45t4j6gU9p2kgzw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793545167;
	bh=c5/DUQedsaWfij8qAImYoe4bBENNc6bIp3uImO+29+4=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tEGQYlWhxVbCUT5kr0YqrXWTYIN5DEqAlCzW5IUJfYmP4Xkn7PEdshbWJr+wtCdNJ
	 9PyB9ooXLt4F1bU2jjDv91SEa02qOlymm7IUQdgCR6wSPeXQIfqWtaS8OEIbUeGeOV
	 L6svvv/hF7UmVFnSamF+DR4qi7MYPuiNiCb9SnKbYPOqm8rU15iWboI1os6P62JjLN
	 7GgzgaU3CqdU7i7H1HPx3xSqgdacgQIPDF2VqCGmHJEh/ec+KA7ZrFrMOUVZtCqrsK
	 0EvsR6NIVouy/r/lQRPLsJkxqBuLtPyaA0aLEl1iRFJDY/fYB+AKdFoJtzoZnLnGhU
	 JLVTm2A1EACXg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2016780D2B;
	Sun,  1 Nov 2026 14:59:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id E0C682AC
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 14:59:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D256C6060D
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 14:59:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZbYuwMdLKSN1 for <u-boot@lists.u-boot-project.org>;
 Sun,  1 Nov 2026 14:59:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D52A86060C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52e"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793545164;
 b=MSoYWmvpVnGTo7Nv48heKinFqtJ5pLElTHBfMwB58O/OZUQUoaGzycoY+UuQSPgcGgRZ
 67pr35iT6oneROYI0MZ9X6UmbRcWH8aBLTMipnFYQXEAQykcxGbLfxEFPU1TM/yHUGjae
 CiTyK3FC6d8N112DxWAlEujRuM7M+8HgzosbVQqUi+hKUcHTV9prUQzXtim/KxGvFAaEo
 ccv8/XK8gMj7TsHLkeH0RCLeQgQ/BkMQZac+to2i7XOnSQrlQDu//XlCzRbL2jxNh1RNr
 QyjVd4xA8YaDOJPnV1lEyxvbLW3GSmT1qwQRWnulrRH84BxMR4d0XXG8CIhGb6+9m1g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793545164;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=c5/DUQedsaWfij8qAImYoe4bBENNc6bIp3uImO+29+4=;
 b=K/DzF0pApvXvBvd/S4/UyvPAP7tMzowJMo8B6/h5Ri27rMYNb+EEpdbHtgp0n+njG+iZ
 mZuYx727N/cGMV/3FCpsf6olOOYwkbAsZsAKeIlflIgQR+/8PxTY1eAtm1Xg2kgY5NfdF
 WL3MSiuwmw0ebpTmI7AUdFefWFeWayszWp8zyjlOtp3+Eqhvyd51yiPnASpzkA265FwyZ
 jHEu8Gjxg5rAw3rIsPtrUpEx6iTgxVPZPfGHubM6H4QvmGAJORvfs3an4cFXbqaXzRnAq
 Uuxf5fOGJI04MQ/XNN5OVUTI/ETUO226DWUAk1+FvjaJdiBeijoTL1tF7iFsf1TNCuA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=AS9wPvDi; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52e; helo=mail-ed1-x52e.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=AS9wPvDi
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D52A86060C
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 14:59:22 +0000 (UTC)
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6ae305e3bd9so3830304a12.0
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 06:59:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793545161; cv=none;
 d=google.com; s=arc-20260327;
 b=bhXQQ7abem6JzpVCPg2VSor794BHknEBoBCvs9jLxWi1xmITnd06ynYMgoylKkmv09
 HE00CSrKzRSklAq4UnXlg+o2FVl/I35eXq9DtwsvW6ajtgVUc5EABVOqnezKlGdWr0S3
 DUpxETPX42sW6CbpuVUvzl7XXujC03MHnHoVfrW7NCm2Fi/4f5Yge4eWY9q/vdfu1hQS
 wnHnCVu/2CHaXwhqLmrdevxFbEMuDG2kCag5b8WBfje0T558zaQBCwgPrluQlvdgbWdW
 AIv4OmAl1X6ZReVo6kQ176ZMxKYVvClSjCNF6hhIZBelCNF8jUY9Gd24vifDXhJD8AZZ
 x58w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=c5/DUQedsaWfij8qAImYoe4bBENNc6bIp3uImO+29+4=;
 fh=Au9DcMx0vgcOr13v6n8SKTs9BWPCsDm/uWXQI2wN0hw=;
 b=TWu0qbaCVGm2HH6F/l8U9WwlVkhlqDW7gMSIVOWBdzrHWQSwL7Cr+ZG0UzCZCATJ26
 QHEIOSqQLqgxMC397wqdcVYY1fCYJadY9W0kHW2IxpKPhZ3XNzKabn0nvbr/aciuo+dk
 JHS1B7yWmPlp/+6yDspDDJMpp9F7GhzN03uO8SSo9f7WpqwWr4LGN9AutHl1dmvpQyM2
 86R1acOo6XL9UIEeB4vsMh3xOC+WusIdN3Lc/YU8w+2Vvb+CQJrWcsbXNUgVRgLF+jMU
 3q5mjDhNVd5djhm1ee+chjeev6wEiUlg8QV4Nfh/b3aBohyiMC94yna2JIdz0EOKYUdr
 +ekQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793545161; x=1794149961;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=c5/DUQedsaWfij8qAImYoe4bBENNc6bIp3uImO+29+4=;
 b=AS9wPvDixt/JzpoqIe2vVQcm6LXaeCO7GUF+yAWRJVFcJ/EVvElwdXShn9+0d34ya/
 6dJmbmI2Cj+5jZt0/Ed2bzEk4IOcc86RkwcS5eqb8mISShSopHcFV7DgV2Yq6fYpnBYd
 PHdCWa4LEifnwJxR08hbNM2hS/xtm8g3qXP38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793545161; x=1794149961;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=c5/DUQedsaWfij8qAImYoe4bBENNc6bIp3uImO+29+4=;
 b=VPTdl5uM+XRE7yRPB3QsSO2AM0iB4hDQHqdEy7Es8kq+bxMZTJjYUN8Lu2T4Z7ICrC
 5hpl2HWhOhJisK1wzBWXDrQvVjAfp+zG1xbyFK0KHv0A75a7dNueFTQLu+3l4xK2W6tF
 srASsrb8BfOu8kVwWMD54QiEvjo/tAT08dOJolKe78aOjzi3nX1yfweOhDH97zyQqxj5
 8Npbw1C63IqqmYL/5MF+UvdDHePFxyRX3DGj7QQq90JdDEXcBe9SDC05jlarcJ0mAX2A
 y3Gx1XA8RorqD/UJu8HcpFj56PgdAERR9j1GkOeHX9Xsb77nqhSC105b3S9HgPcqhZiW
 gwkQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByycyKCs7jgmiakd7Jhwf4JWXWlaalCzV6elGBaOvTCJhq0W+2tfHDyvIsLoFJrq+rct7awnBw=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+aiakH4d2IODw6H7PWTX43kpJea4IoqAcprtWx8RkMUt7vGVg1
 UlPPIDpgWlwsvg1bcGzo0wNyOh9YUFiOTQOXOSyZWMF7/m+7CW0z7fcEdAAbq+wghmQG3cK8Otx
 +JI81bKcRey76JJ9CH2ozt+vKCAVCf5LrFCS6TmTy
X-Gm-Gg: AYBFou1bHHa5k2r3xxXmCvOm5q4zxoUyrood4NGfUPosrTN5yrU4SVVMu5wRHiI/7Zv
 RzCvATUuX6JngCgz7VnzQkM82nGxnuLvIf4cJ0X/kB6EjJ7cyeji0Ro9xCiGkq/WQDbc7DefEbn
 9Tz2AzA4r96BbrpPcV/J5zGHohrhM+JChqYijXgX9s7uTshuhQDmLoXSVGZRF57+2HG1INKEm6Y
 +qBlaK+rost84+YBicwPzVUNFdt34L2TMzA2l24BZKUPg6xQGnqnskC4vOFgpzcZ2Wo7L4jXSEH
 xV0s2Suy6Dtfod3/jKrZo5p/wdgHk1YJdE5doHu7ZFEkHcMlvJ1QVhqjJZTLhn+YkfxPqkAtErA
 yGoRA/LPCmBwg25pnw437a4A/oAklpwvwC+mGE06Og8fqOQRMl0xeLiKZ8Dv64ETnMTic9Tc=
X-Received: by 2002:a05:6402:1d51:b0:6ab:7700:9371 with SMTP id
 4fb4d7f45d1cf-6b4d468b63cmr5103037a12.25.1793545160690; Sun, 01 Nov 2026
 06:59:20 -0800 (PST)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 1 Nov 2026 06:59:18 -0800
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 1 Nov 2026 01:35:47 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <e420f3ec-7b16-432f-a3dd-5eeaa7cfb1c9@gmail.com>
References: <1ea4ecf3-70d8-4469-be94-1943ab8e3337@gmail.com>
 <e420f3ec-7b16-432f-a3dd-5eeaa7cfb1c9@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 1 Nov 2026 06:59:17 -0800
X-Gm-Features: AclHuK_o2Wmee_ql85tsblfHOy4H9-TBr7CnVspXOz6gciHDRQZGRr8RAW8joxs
Message-ID: <CAFLszTj60DoqLLgEb7oeO+qJ=6nk-ZSMmoNSPfswQovXZJrFSQ@mail.gmail.com>
Subject: Re: [PATCH v3 13/14] efi_loader: Index the GPT entries directly in
 tcg2_measure_gpt_data()
To: anabobillo3@gmail.com
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org, 
 Simon Glass <sjg@chromium.org>, Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Bin Meng <bmeng.cn@gmail.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Alexey Charkov <alchark@flipper.net>,
 Javier Martinez Canillas <javierm@redhat.com>
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-11-01T07:01:22+11:00, Ana Bobillo <anabobillo3@gmail.com> wrote:
> efi_loader: Index the GPT entries directly in tcg2_measure_gpt_data()
>
> tcg2_measure_gpt_data() now measures the GPT that part_get_gpt() gives,
> whose entries are always sizeof(gpt_entry) bytes, as
> validate_gpt_header() refuses any other size. So index them as an array
> rather than stepping by sizeof_partition_entry, and read
> num_partition_entries with le32_to_cpu(), as the rest of the GPT code
> does.
>
> No functional change on a little-endian machine.
>
> Suggested-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
>
>  lib/efi_loader/efi_tcg2.c | 24 +++++++++---------------
>  1 file changed, 9 insertions(+), 15 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
