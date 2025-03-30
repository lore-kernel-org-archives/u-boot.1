Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDC09C36011
	for <u-boot@archiver.kernel.org>; Sun, 30 Mar 2025 14:07:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC73E8171B;
	Sun, 30 Mar 2025 16:07:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yxqvZMyS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69EF881EC0; Sun, 30 Mar 2025 16:07:36 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8012D8171B
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 16:07:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=christopher.obbard@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43ce70f9afbso38359955e9.0
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 07:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743343650; x=1743948450; darn=lists.denx.de;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=N76In/0piXS0aeX5p2AMkMjgjcX1rd71d9vP0UWf0Vg=;
 b=yxqvZMyS5fLmfUGZcPMHKNwB8JmHuwOsCvtSs8utNGwf7Nm8LzAeVD2ZxXzOS3V6tG
 48+WMiCJMc4QW25VPQuz2ZeiTqLqpwSQzL/ijtsk7ZFGNH8JgC6SvnSgGV6jxPQISir0
 6Fgyv8vWozwaS5qhjue74OpbpugOdHNQqPeXFvgBHWspnipC8Lm7Q0NGlAicErGXGyT5
 Q0tWGPtMhlgZwwvwU+lIDJnDU54ke9V2yWCqY0hL26FrkoVcYwgWUxxOFc+Hp3gcUQ3S
 CyKbcpE627swbUZsULmMG/QyRkP0x2nt68PJlya6Nf9e229ySANFB4UJKeVhAjPTDHW3
 4KgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743343650; x=1743948450;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=N76In/0piXS0aeX5p2AMkMjgjcX1rd71d9vP0UWf0Vg=;
 b=NsphfyYIUAe04oEGLBeZ5r69oSdnU/s60NpcwO/d2HX9sgKL4z/Wy1+Kl+diQQjsxO
 aLsDCP3TelUdpAhh/jBSx6JLuHChNOwh2JUOdQnz3CcOQOj4nJv4xvSI+46Rqnm60wVE
 WOkHQcLHTL8yet5apJmnC/0DU2NtESTIciVzarQHoXzOyizU0CaB/3Q6sml0J4UDyu4g
 bQnlhD5mN9UlJLd0V82Xllgr6v3BDRTMMGL8QlqpqKEi9Mz9maK/ETP+dghVgNHcpSBI
 Ov1td4Wn8aL1s7uAY3uz7YbfWicgzuz4iJ59Wot/atWdNWRMe3wmNuYJzIqbyh7y1EnK
 xlaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5dw8/IxU74cbbLL3DzTIJt8BhI1OG+c02cX8lp4ddRINaxcEwtJOLp31CXN5cRqvm+4kV8Ng=@lists.denx.de
X-Gm-Message-State: AOJu0Yyy7SndvVlJN3wUEf0PdMfOM5Jf4GyKcuNo1hdUtIOcWEFpKSCd
 LZR6WFmGr5fDKQuqBYxO1WZe5sSbXrphjnh+JviIX2DLWz1YRthIphsz/brqZlw=
X-Gm-Gg: ASbGnctvUkNFQbQ80jfN8mautxdAgx0TYX3pfc1pjtixa43B71NTQm5th0dKCf84JQz
 z3PrhBEwBDZ5J+VZwII+xZ2mdaG89HD5lONQmQNwmgqzI/WEFw3tGo1L6HZFVphy8xlqCNorUMH
 sVnPUO9klC0aIEZAU/1txQiJkbFdDItjt6XZccVSMrhyR7yhJsPU48GYgipIyc+9XXJge2/pfoK
 aNlKThikpilo0nFbBA9mACKmxje0nL1buBTybdBYS3Rlg6WrByeKklN7IzdN9AvZMyXZYa4FpwC
 XkvE5r/jLz70XlByYXnQRZiOr98LgjbLdEqX7pTHA0XJOpoqs3bkjf1ilKvzplcIO/PyKBD3Mcx
 DTJARlz0Aw0+4pgcf0RaDdMkzY0MO
X-Google-Smtp-Source: AGHT+IFVx7nSJy3W7hj1pfWAR7B2DUvn1bujE1lu65edciPCaFvNODKtGO2zJi5KDi8hrwMQx85Gag==
X-Received: by 2002:a05:6000:2181:b0:39c:1257:cd41 with SMTP id
 ffacd0b85a97d-39c1257d4f0mr2833252f8f.59.1743343650572; 
 Sun, 30 Mar 2025 07:07:30 -0700 (PDT)
Received: from ?IPv6:2a00:23c8:b70a:ae01:9cf7:b69:fc50:980f?
 ([2a00:23c8:b70a:ae01:9cf7:b69:fc50:980f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0ddeecc9sm7488978f8f.83.2025.03.30.07.07.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Mar 2025 07:07:30 -0700 (PDT)
Message-ID: <4e3963dacbbe38af1bba9bc3faedc69c3cf2c9c8.camel@linaro.org>
Subject: Re: [PATCH v4 3/5] rpi: Drop fdt_high and initrd_high
From: Christopher Obbard <christopher.obbard@linaro.org>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Stephen Warren
 <swarren@nvidia.com>,  Matthias Brugger	 <mbrugger@suse.com>, Tom Rini
 <trini@konsulko.com>, Peter Robinson	 <pbrobinson@gmail.com>
Date: Sun, 30 Mar 2025 15:07:30 +0100
In-Reply-To: <20241220003447.2913443-4-sjg@chromium.org>
References: <20241220003447.2913443-1-sjg@chromium.org>
 <20241220003447.2913443-4-sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
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

Hi Simon,

[resending as I used the wrong e-mail address which isn't on the list,
oops]

On Thu, 2024-12-19 at 17:34 -0700, Simon Glass wrote:
> These are not needed now since there is a bootm_size setting to keep
> things within the lower part of memory.
>=20
> Drop them.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Tom Rini <trini@konsulko.com>
> Suggested-by: Tom Rini <trini@konsulko.com>

Reviewed-by: Christopher Obbard <christopher.obbard@linaro.org>
Tested-by: Christopher Obbard <christopher.obbard@linaro.org> # CM4 1G

> ---
>=20
> (no changes since v2)
>=20
> Changes in v2:
> - Add new patch to drop fdt_high and initrd_high
>=20
> =C2=A0board/raspberrypi/rpi/rpi.env | 7 -------
> =C2=A01 file changed, 7 deletions(-)
>=20
> diff --git a/board/raspberrypi/rpi/rpi.env
> b/board/raspberrypi/rpi/rpi.env
> index a327fccc77f..9b9fad82828 100644
> --- a/board/raspberrypi/rpi/rpi.env
> +++ b/board/raspberrypi/rpi/rpi.env
> @@ -66,13 +66,6 @@ dfu_alt_info+=3DzImage fat 0 1
> =C2=A0 */
> =C2=A0bootm_size=3D0x20000000
> =C2=A0
> -#ifdef CONFIG_ARM64
> -fdt_high=3Dffffffffffffffff
> -initrd_high=3Dffffffffffffffff
> -#else
> -fdt_high=3Dffffffff
> -initrd_high=3Dffffffff
> -#endif
> =C2=A0kernel_addr_r=3D0x00080000
> =C2=A0scriptaddr=3D0x02400000
> =C2=A0pxefile_addr_r=3D0x02500000
