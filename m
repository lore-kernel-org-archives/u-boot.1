Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C494C369C2
	for <u-boot@archiver.kernel.org>; Fri, 25 Apr 2025 11:43:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 294D582075;
	Fri, 25 Apr 2025 13:43:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AMMzAB0j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 640FE82075; Fri, 25 Apr 2025 13:43:15 +0200 (CEST)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5AC5D810EB
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 13:43:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-30db1bd3bebso22719821fa.2
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 04:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745581392; x=1746186192; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YovTss0jDEZNf/+rObeMDZYzP/JFItNjHGEx6jWZNRc=;
 b=AMMzAB0jBrFLs5SlPQqpUMLORkk5ytYBxOj81Syptx2w6K1Sy3dvlruPYqMzKgKLx5
 2HF2XwemaXPgee6mESEKCvVAms+RB3IY2RhCu4K5nsxmoZkZjGfZBMVW0iRQE/F8SG+x
 G7brJKQh54cvrUutNKrIY2gqR/MFjR1LYsuXdXayJXOwGYYxcQLpLMKHUWbG2E8FTN2r
 7tUdqD2rWw235WpDy8FieV7q+JAvBMLZwKlexU4ytN3FKU3RIucDSxiPdKMEsecFfzbk
 JGgzW3XBpFkT6paVXxvOzU10FIqJOamiZt129wkyiC/68hOokF+bw1VoHjrulYX0WWeQ
 FmlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745581392; x=1746186192;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YovTss0jDEZNf/+rObeMDZYzP/JFItNjHGEx6jWZNRc=;
 b=PjQP6UTOagFg4G+oQs55MDjhIm6dGAd3WNSecCQ24ezvpULIjimLAntoXp5Htui2ZH
 1OOCt/+E0BRN8vWFHBGk0lFF+mVul1Pn76x1WSvvyDymDpxNULzV6FUZCu/QuqJPP0/O
 LYuNsznA2KM6lzPBpab+NUlQE5WO3EP3orMDLL6ggHDqWaxddIk2um677dFwpQHuMH7f
 tMROrWVjSr3BC30UWSqKhcZEec5DxtiW1ebPNdgEbd+r8/aHrW2qeM1IfjkcBtnE546P
 WpIeK+Thfx8zz5tLO3wnYQbCcMm9jibOEFstrSMZyreNTbt+dKK2K/T9L3LGZ2MnHP8i
 nl4w==
X-Gm-Message-State: AOJu0YwYr1eHZgxAxoyJuryrKLjCgwTYYwJ4gLnq1kSrb3uX2YDp/IL4
 0F8hPXmu1QynAvE6uRB6Mvdmd9Ym2ZhrFblkvSh/RhtEwzNcv7R0WwfQCeUku4HPZFWqnVvFJXp
 eUYYFSWpnQItxf4pRTsWP5L2yB8s=
X-Gm-Gg: ASbGncu9xoLBTSrP61/7tawBwL7uMEbXeFXvNfyrp7zG+xufLuQIomLwkzdzpBRZvCK
 l+11Rd0iwigoqBQRCvefIHM0Yre1cBEKSk4JNONyj8JNOIAn5XNzewlQOHGsHGB4W4+xgoLlHmO
 OJCTf4ybJnoa/5QNCZrOUmQ34bsVzeRAIoPociFH1EKfTQNXsbawjoQTesUVFa3P4k
X-Google-Smtp-Source: AGHT+IF2CCfpQU4PWDry600/l1G2Uk8gOgfjYuQaOXL3O/bZQrdh5mOFI2vttTJoNw96P7rl1wUwcD1s60ubUIaGqfI=
X-Received: by 2002:a2e:b8c6:0:b0:30b:f924:357c with SMTP id
 38308e7fff4ca-3190634a245mr4855601fa.15.1745581392306; Fri, 25 Apr 2025
 04:43:12 -0700 (PDT)
MIME-Version: 1.0
References: <20250416090419.54781-1-hs@denx.de>
 <20250416090419.54781-3-hs@denx.de>
In-Reply-To: <20250416090419.54781-3-hs@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 25 Apr 2025 08:43:01 -0300
X-Gm-Features: ATxdqUFeozHis_Vr95vceK8R5Mpg5d31ilr5q-KovUaxtKrgg27xCV4kTogWaSM
Message-ID: <CAOMZO5CPNY2tTF-dE9HMYBswLKX=idqkhw04M5YZ6sfPnHfcCA@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] siemens: capricorn: enable text based default
 environment
To: Heiko Schocher <hs@denx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Walter Schweizer <walter.schweizer@siemens.com>, 
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Anatolij Gustschin <agust@denx.de>, 
 Enrico Leto <enrico.leto@siemens.com>, Simon Glass <sjg@chromium.org>, 
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

Hi Heiko,

On Wed, Apr 16, 2025 at 6:04=E2=80=AFAM Heiko Schocher <hs@denx.de> wrote:

> +initrd_addr=3D0x83100000
> +initrd_high=3D0xffffffffffffffff
> +ipaddr=3D192.168.251.1

Please don't hardcode the IP address.
