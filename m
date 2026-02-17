Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39C51E63F29
	for <u-boot@archiver.kernel.org>; Tue, 17 Feb 2026 07:17:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C41E83981;
	Tue, 17 Feb 2026 08:17:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GhFyG7QE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 954E883C32; Tue, 17 Feb 2026 08:17:19 +0100 (CET)
Received: from mail-yx1-xb129.google.com (mail-yx1-xb129.google.com
 [IPv6:2607:f8b0:4864:20::b129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA5CF8063E
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 08:17:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-64ad79dfb7cso3689588d50.2
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 23:17:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771312635; cv=none;
 d=google.com; s=arc-20240605;
 b=WXe2xuuMKhLCJ761bcWdq7yiv8n6jEIT28i8TPC0PT795BUFHNdklVY7HYntE3nE8C
 +VQy3OiAYcDZx5dDm55PtaawbAL2KIjx7JGXhCt4qMsSTXcq+WGvubqjaTP5htxOsztW
 7too2Y1dsxKw0VkwXwWMg7mac98XRpZ71fm9WbbaBLs/9bixOvpHTrzqbo/L4KrPMz+y
 NtgPIlzXcaC4FrotkaJ43w3l1d6CTCm+dr5wUgND3H2htldUsvQA7d2YS7H+GuzfmdHl
 TO47qT9KtjyMMcWGYvWTsdyZyjkZP6d/EtJNgAXAwfcfyiyUyKLD5wzLT+cvwcxgJXqu
 h2zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=2+JXIIRJ/TJivOgIOF4YpMARdxXECCeSPZ2QjO5R4V4=;
 fh=HMo1EPWwGoozHp4urU/Xv1ky/Jp1zB+ZimkLAjhvYkQ=;
 b=F1+oUYZN234wRFuI/x5+ZML102nzPh7Viup3O6ri6HeR7UoqelIWgDkUN+P4qtovCg
 Yb0hC2KfYBMhpxmDrs6peLr4peHAeCIB23gy2zj8K5JM4EfHRXi271g2fkgA4SEBohvR
 gVNUS6+Tzi0B7C7HQnXuKYzjzacXN1DXcvMi2afBHRMVLgXSbZebgNT6gKwyH6CjJssh
 Vmb/5vygOmsiCTUdgVxBVcnpO7NNAuGUmXSJMtI+uEbOOct/dVmKySj93KnMf3TaRCxx
 ycfmst5LaZUk6gpHbqjyV39k0eArrIsgUPGuOGsqs+7k9WU4tmi5TZYUXJ+za2AwwcFT
 /0OA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771312635; x=1771917435; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2+JXIIRJ/TJivOgIOF4YpMARdxXECCeSPZ2QjO5R4V4=;
 b=GhFyG7QEil4CREXjTGQBUau2hpxRrjpCvInK09JLqFXLZt6P5NnchC2sLfenoyhJeH
 hdQNBMHt2NJh35z/xub61KXSXt5WMfwXhNAzmGRA2+P+E6vcITfnSNRcKQDPCnsT2Fis
 r/YrzhOUGueLryX6lAK2lPJ2vqScnu1F7CQDlFoW3koy5gEEd+jV9SD1aes0Y4Pc3nGM
 xXOCsR/wNLq6LuDH0JqxQ4+b1+LhY2Tlgida/Uf4VLtOqRR9w/Z7epMTXL9ZE661cWd5
 /33Ti2dh6y01HKf36MMnmkb/jA50A5qEcthmKUk+KafHy/NO/oLjIaHjmk0Lb940xvT1
 Bq3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771312635; x=1771917435;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2+JXIIRJ/TJivOgIOF4YpMARdxXECCeSPZ2QjO5R4V4=;
 b=eUD4aRpmhcoR4EtahwuvA4Q1tCGXxaKVax2XImyq5yD8pxO8xYX3bHRMQp+BXzBgsc
 5DipJ8epclDLfou1clu+1Nf2pkhOmNLA5DItwkz4GNl9hhMsR7AX3Y0Q8V2RKvrPwedy
 ztaJPZq9Lk5MqCqZDU4vRaSt1UKXmcxlGD7tuV2/At+32QBzMJXrsZkahWMalI/Ljb0r
 tWMKZcN3nGf4k5N3WN0SUHLxzjYzfp64yPWBKdwD0/ogmoywRVbAGEKpSjcWomqtGk2p
 4PhOijJw4v81Yffce0vg7EFS5GrupRwKKxr0nGHcleM0Fl5vp1ZhAjtdF3ri5z5YhNnT
 Xobw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsWDMHRRrdHWSg1mSF0WMDVGK6iSYG9w8jInE/6QMh0mwxW6sFOcLW1cZYKb9Az1VsJzBt97s=@lists.denx.de
X-Gm-Message-State: AOJu0YwLIP4jPPqFgKTHfLbqg1D/E9QE8FD2rLII1fJukX9UfNMw0spf
 CoTd3i3ZkeDHzrEln6Fq//UM2bqbjqPmY69xGwgcN/ePVtOvSQG7jd1TqG+2QcDNGBwhHy8wLhf
 tKf7ElNzJlcvRyf0tovDsgbrKMAqoA2RWTv0OBIDwmw==
X-Gm-Gg: AZuq6aIGnCpXw0dP4+ZBgtUctDocmQTuL/uvIShndGUzp9p4BoSdG+UnXXhNh2PqO2R
 nTZ6Ljo17jLvupKclc5AuknObgn9wO9uKlPEzkzfR1qGO4LDNCi1SmxAPQsdYHcvCsgw84gPt1/
 Bni3RjkGwUfK1C6vJIoXtJrr1hCqigCD1uycqssoyy/q4Ijnxz7n85UxNcXxtiavhuxPGPSh21s
 2hzE9CeYLdfq5d3hNYPWnM/m4R2gn516kfMDGh2hDjgaCEttM1n65FJJaT1vtn2CGQRSgoKL1W1
 y8uZbZbuWYGIy3XbTORtJfGgBrUCTYgsjFweI5V8NoqalJuJeWwTc1+DJYG2WlshUicCpLj9eNE
 yHb4AUZZzC8Oh8N16Ry23YQdRB9e95UqeKLgo3rShw03h7pjuitybywfCJBtsSVPnnr3pfTf4XD
 Q4MYZzQns14jZsqicmCKUi/YgPKvedxMZ1lBh8i3DaubdnTOXksXKFKaSKwxzL2b13CB85mFNMJ
 112W0HNBcFVgONfTCJJYqe7tdjMNscjPNgI9+VLcTKFWDHR5ZyhAPzhgEm88d/QFu0+1hkJkhem
 lMq4bjHrMTcdTUy2XH5Z8+OEGXPMNwJUKNigN0zoRLrB
X-Received: by 2002:a05:690e:c45:b0:648:3d3:790a with SMTP id
 956f58d0204a3-64c197a3d8fmr9875330d50.17.1771312635490; Mon, 16 Feb 2026
 23:17:15 -0800 (PST)
MIME-Version: 1.0
References: <CAFLszTjgsSj47P6u2JohHv3vV1=sOWQxQ7qS3RDuBYBQsejKWA@mail.gmail.com>
 <CANqXHyEShK3bCA-5K4K=zH_b19i9+o9DRPYW8LHo-gFpMB2Hkg@mail.gmail.com>
 <CANqXHyH3OwPEpo=rv6E+uSP01quOQisEJ3_aD2-r=DkNDK4_+g@mail.gmail.com>
 <CAC_iWjLKotX4X9mD1qnJbnkbh9xBHfnyF+b=b--XvMjjbCrU-g@mail.gmail.com>
 <CANqXHyGZSGybzchkqSE0-7s3HgfY=UBjpkjS1wjuRkZzOLDMWQ@mail.gmail.com>
 <430A021B-7511-4C08-B30C-72C153A25A27@wolfssl.com>
 <CALeDE9M7ENPccTD18b3YKrvYEu8yU0cXT1ePXM_tagV4Ou+Z0w@mail.gmail.com>
 <CAC_iWjKnbp_gtHQ6nMZEHEOx92NA2U1OLFKkgDtyqS_aDHO6GQ@mail.gmail.com>
 <48C4A401-E824-46BF-BC93-1EA9A45AC374@wolfssl.com>
 <CAC_iWjJD+_spstOX5z2tDoyEUZwbV7QXNz_s5ffz7FWK9QopEg@mail.gmail.com>
 <20260212194620.GD2747538@bill-the-cat>
 <CC9C4133-1AF8-4A32-8DEF-CBB716817422@wolfssl.com>
In-Reply-To: <CC9C4133-1AF8-4A32-8DEF-CBB716817422@wolfssl.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 17 Feb 2026 09:16:39 +0200
X-Gm-Features: AZwV_Qj8VDwRSHpGWoSvRuIpp5rKj58Eo-3h4AGhwPDQ72sWyHdt0H5LRa0oLyI
Message-ID: <CAC_iWjJa_AmUBjsct2ddsL-QaYoyXBQjUiMzE4uWGy3RSshU4w@mail.gmail.com>
Subject: Re: U-Boot support for wolfTPM and firmware update for SLB9672/SLB9673
To: David Garske <david@wolfssl.com>
Cc: Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de, 
 Todd Ouska <todd@wolfssl.com>, Larry Stefonic <larry@wolfssl.com>, 
 Wolfram Kusterer <wolfram@wolfssl.com>, Aidan Garske <aidan@wolfssl.com>,
 Tom Rini <trini@konsulko.com>
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

On Mon, 16 Feb 2026 at 23:30, David Garske <david@wolfssl.com> wrote:
>
> Hi Ilias,
>
> Can you confirm that the patch was received correctly? It appears it was =
based on the link Tom shared. Let me know if you have any feedback.

Yes I found it in my patchwork now. I'll try having a look by the end
of the week

Regards
/Ilias
>
> Thanks,
> David Garske
> Software Engineer, wolfSSL
> +1 (530) 409-2990
> https://www.wolfssl.com
> https://github.com/wolfssl
>
> On Feb 12, 2026, at 11:46=E2=80=AFAM, Tom Rini <trini@konsulko.com> wrote=
:
>
> On Thu, Feb 12, 2026 at 02:58:19PM +0200, Ilias Apalodimas wrote:
>
> Hi David,
>
> On Thu, 12 Feb 2026 at 04:11, David Garske <david@wolfssl.com> wrote:
>
>
> Hi Ilias,
>
> Thanks for your reply. I did submit the patch via git send-email on Jan 2=
8 to u-boot@lists.denx.de with subject "[PATCH] tpm: Add wolfTPM library su=
pport for TPM 2.0=E2=80=9D. Can you check if you received it? Copy of the e=
mail is attached.
>
>
> I haven't and i can't find it on
> https://lore.kernel.org/u-boot/?q=3DAdd+wolfTPM+ either. Any chance git
> failed to send it?
>
>
> It's:
> https://lore.kernel.org/u-boot/20260128171112.1818705-1-david@wolfssl.com=
/
>
> --
> Tom
>
>
