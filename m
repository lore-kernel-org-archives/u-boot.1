Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4560105F791
	for <u-boot@archiver.kernel.org>; Fri, 13 Mar 2026 10:29:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E86B38420C;
	Fri, 13 Mar 2026 11:29:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="w17Bj6nP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C69A8420D; Fri, 13 Mar 2026 11:29:15 +0100 (CET)
Received: from mail-yx1-xb131.google.com (mail-yx1-xb131.google.com
 [IPv6:2607:f8b0:4864:20::b131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F41D9841D5
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 11:29:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-64ad46a44easo2027748d50.0
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 03:29:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773397751; cv=none;
 d=google.com; s=arc-20240605;
 b=ENrmC3P9afzlH9EaCXPj2aCSjDPuW8Psf688GOx2BBlwHFA2OUzl84jqPN5qaSDk0k
 pAAHEBApjfJGH9evsKts2Xzb8eVZCHv0o7NEwL6F4wn4jx39zPklbdEPIVaREars5CD2
 Q1p2b0aiTH1t3GQx7lS+viaibM5f/KGk9ivqosoIfEnkF6XaeXqBz+SyyamCKwKdslQG
 1amHngPtWRBF3GgF7ovMr8DaJnAWq1sdUSv1KBJVZzz3bSty6kkl7VYWjHCkxRXJLVpZ
 EEHG5SpmXZWp9DDyRcCUQU0mMobBz7kDJF3SAX0CrmqhkbBd5zjdgnxgI/EvqJiqAiNf
 hhMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=BWiNAfaOB3cMhX5rRkJTrlTBpxpH5AsrboK6naK8wGg=;
 fh=wrhZen22MtbkREBrqvGymwuHbf+JYQB1yPUxtoA5vm8=;
 b=E41x1lQF7dhxHTfxPoQuTaa9yy1jictF85fCPJRIPMrvgU7b9+Cqfc8vlnyracyu7b
 rPIn9UjCer/2iVUS4vnxvHtDfxL6KNwlrXekur4bvFZWA7x3qRsc65lQUdvI5ZaV3wxg
 xsHpx77AWOX1o13bodaKkN6CTYeJDMCGhT+buYwdhTNCHVVx30pmHue/jTjJFL0DOtf/
 apgTpTcqLg5QaBKqR8gSIiTdbdypsQ6vD3wTqyN4mwM2zcrPvIckxM9I/HFnUp3jYSI+
 FEsa103qYNCGcjDIYmU+VMVGfen+jQwpMPb4hIrhHWH7SxqhdzFKPkT7R1G9HdvIrMEa
 p/mw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773397751; x=1774002551; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BWiNAfaOB3cMhX5rRkJTrlTBpxpH5AsrboK6naK8wGg=;
 b=w17Bj6nPbbi11gMP/5VOoMopyb01LmIQ2VVRK9yn6LZt3iEOLjUQiD4DTa8dkvMpgD
 fs20NA0xBl24lB71rRvY64JuCLVPkAJJ5uUX0Zd6JfXtTW7B74ifa1egl+mr1ShSp+zR
 8Zxv8XPjN2RHhDAgAMIhxwCHGAbFnIZSY0xGCdF0go5CZ7kMBmBIjGI9uPi3r8rOlUNh
 /5vKzuQRzoE+Ldm72fomeqySug62/5kmXPMGXglxCuj8D6YoIAScLp97WoKpaTV7l64C
 t4U2M1KT60nanIcelhgJ4GiTdMgfTfrOx19X5nzBIDm48aehKN7FkAaYKL6ttanp3lxh
 SQdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773397751; x=1774002551;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BWiNAfaOB3cMhX5rRkJTrlTBpxpH5AsrboK6naK8wGg=;
 b=IZJqFrAvKyTHHTz6pQkMkc/msfInERk0eXT4vhMsKpKgGQChOWvFfp8orfO43W0BmB
 SRMXjsic7DayvwkiEeElHBko8q58wrxSWOoGk5dCQ5ipROF/NPC/rFq6xqQH6Psi9IBy
 Xq6lbBov3jNoLMTZx1KnOm9AH+Emrg0BkP9NQCsSyNEwuNg8hzlwe1jdtEX+LVOP49xA
 D3+B1yXUYZnQzm3tdUE/deh84qF4JXEJOLImCDdhPgU2zDnHWaT4dp+9DMrovbCqfOmN
 py/gb+VxKhRdoW5REkaIzNT2nTLYpvMMQVqhfouQxuUliEiM/cPQYoJYnLZVNR9RvNl/
 88oA==
X-Gm-Message-State: AOJu0Yxgq757iQi2L5PPVYRuAmWVe/IHRc5B3IEAVWYKP1LAweDgesDd
 FD9CkAvD2oOKuJILqHHAmncM+OgoDk08TYKP5uPiPAWAzsglztT7Au+DiRZBZDy2oCdZ204nInj
 EkmR5iRacQuxt5QqRoJJI1I2wE5gIyfihEf+6gNHQcg==
X-Gm-Gg: ATEYQzzgqwnPmaLR07ftl0giQ+qdWokmaXOo8C0WWHMZalH9w4ChHbTpV4JiJPzF1No
 AJW1kavyPfNaso3MSeBwM7AaV9azWYlZ/BV9OGp0Ak28yrX5lCbq5LjcURMpucDXkXiS6jZkzq7
 vZGE+qPvwiPxpKwJwwPxhZS1hA2upbhDQVHkHM5GJoVR2EtaWNDbSSZVP45WzwNgfqp09O4vqhK
 1qrlLhZRhzXoj0yZdTq9gWdVYiQqU3wkIXtFI76pA4dT1Qo2s9CGm72UTUBRdKpswt9p5Eqa6tG
 UPUMRCrXJxRTwfeUZ7LpCyTV/HLl3A0xbInTPFfN/jIB1ln4d4kD9qqEpl5wxIOJHiZX4tivuFe
 2HySA2SXg0Y/vEd+l+kLzib1lwC5NVcf0JuBhXmRqZq8IMwSazTRGrY3oJzbczWp79k04uWH5Wb
 HTV91jEndpLipruf2jqwPo6HyxKYdBVncFXqPE+VhVQ0viBfuFfUy33G6QQjIBEwpYa+T5398B9
 9kIEtqmGyHfXA3nwXWSvyxxOMELaarB+vR5oLJkp50Tq4ywU1kad5ru4E5zTc4Zw6PSKmatzHm5
 COzIMhy2rZFbnp4Jbp51NJ6D8WVfTkeiGYW4dar0J4Td
X-Received: by 2002:a53:c351:0:b0:649:ed08:1a01 with SMTP id
 956f58d0204a3-64e62f6bcd2mr2047495d50.35.1773397750693; Fri, 13 Mar 2026
 03:29:10 -0700 (PDT)
MIME-Version: 1.0
References: <00b03eb724de3e8b3e46ec630860e751bdc40011.1773322038.git.michal.simek@amd.com>
In-Reply-To: <00b03eb724de3e8b3e46ec630860e751bdc40011.1773322038.git.michal.simek@amd.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 13 Mar 2026 12:28:34 +0200
X-Gm-Features: AaiRm52pwWESMz42tihXeubn38rxkdSfjJxF6oUQWeAQbz6kxWLTTFpGYlMp87o
Message-ID: <CAC_iWjL2OUZCvqAvEtdGHUyihsz6dekYsBYiP90Fi3wqz_H8yA@mail.gmail.com>
Subject: Re: [PATCH] efi_loader: avoid superfluous variable store writes on
 unchanged data
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@amd.com, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Shantur Rathore <i@shantur.com>,
 Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
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

Thanks Michal


The code looks sane apart from the runtime part.

[...]

> +
> +                       if (!memcmp(old_data, data1, size1)) {

So this will probably blowup in Linux. We had similar issues with
memcpy and added efi_memcpy_runtime()

> +                               *changep = false;
> +                               return EFI_SUCCESS;
> +                       }
> +               }
> +       }
> +
[...]\

Other than that LGTM

Thanks
/Ilias
