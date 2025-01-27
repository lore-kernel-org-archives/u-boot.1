Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E94DC02188
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 18:27:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 965AD8129B;
	Mon, 27 Jan 2025 19:27:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SKc5Euhs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA2A4812C8; Mon, 27 Jan 2025 19:27:20 +0100 (CET)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD05281292
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 19:27:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-5401d3ea5a1so4495112e87.3
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 10:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738002438; x=1738607238; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LzBVMgi2KD/vxzjKocSWz+OQK7CZ+O0snN8mU3EGWn4=;
 b=SKc5EuhscUfHOqX2CbbsGx9Ov2w2hZfXoy9NtK07XFjmhgye2qfX0tXytpEw6ym21p
 kp6AbbEmNYkWaC4G/sV5T/z0Rnwc4WnANaj/LQdj492USFQ7sOznQdT4kxAD0FmlOIQr
 NRbX1Rq4/fpotwPrQFkvgTP/9GA/6jmJA2h658tUb2GOvNMgH73l/D4+aCIlFzjNJ/83
 G7u8luxYxo0CE1NimzKU17+VFv/OC5yTRMVC3mHxzKcaHSo4gdvO9Jz2HMyljiacvSo5
 7Ww7IzAZXyHNCecbdzNaLRTXjxfArBQWbWRm63IT5behYlAy+AnTKD1w+1FoXtFQK5TC
 24eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738002438; x=1738607238;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LzBVMgi2KD/vxzjKocSWz+OQK7CZ+O0snN8mU3EGWn4=;
 b=HDoYKKZTk2Wthh/nz0zOnuHKMaCzYj8KiQSmaoeLWHeJV/FqWvfc1XFdy50wwzhyQM
 dHm8oMD2e9UJ++M70ajCd6pAkdYYhsWRYXnC590bd+aR+AQ6q3sanDlqdPO8ez8xSV4/
 EJGIBacOzEQGkUltINjKRJShrdarmP5BNamh1gwPs24jGXXrRm/B7NS/WfLHxit850Jf
 ngY606zgGrwU5pK3z46G26222/W+4kKPrNLh1gBxi3ZveMLwhLZlmX24QazqIUIhESiq
 caI4Fo7KM327YolYKRNOnm8r6v/xSntZcRQ3ANmxHVC6A03QVDlnNGBBqX0OuT0WJiIN
 b3Qg==
X-Gm-Message-State: AOJu0Ywsn9yOXPmh2z91lQyBggubV4E4YEdOPdVuvUtVfPeqjpkJaxkW
 SFZq9T6iyAe43n+YIezdFmaRhDISG4hj0Tm4eRk8eS78Af1nC/G7Y+ccp6TCn++9z8no4Dj4XC5
 FqP8QDX7txMARa0ohQKtat0aV7o181A==
X-Gm-Gg: ASbGnctt/xxJOcOYQsgWSiKCetfbxqDAPQ9a+XpQMKC3e5MglbbZsic01aoOV67unFA
 ENkZxYJ1G8D9lH2UHRUZRa2ZcK3foRbxz3AUpg5PCl3upYKY7KmsxVU9LwOKqTC08PHPDhHa21j
 TwTJg7o5TnrnFJtDQn4A==
X-Google-Smtp-Source: AGHT+IHMzHJCSNxyviOpgw1EaWhD9rBZ0ihDTu2uTn3+3gML1G9cQ4Gwct2ZZCzc5a1eTjoALa9iAfTtiDwK5DVkuCI=
X-Received: by 2002:a19:914e:0:b0:543:bb21:4248 with SMTP id
 2adb3069b0e04-543bb2143f6mr7047893e87.24.1738002437673; Mon, 27 Jan 2025
 10:27:17 -0800 (PST)
MIME-Version: 1.0
References: <20250126235728.500853-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250126235728.500853-1-marek.vasut+renesas@mailbox.org>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 27 Jan 2025 15:27:06 -0300
X-Gm-Features: AWEUYZm0CBtXyPDZpFJqH5rm5Mmfc809Ul6VGK7-Jyt23l7BmMCe06sV1t7QIgE
Message-ID: <CAOMZO5CwX6GxVNS0y0A-1wAyNX-yXN2k_1jb6g=N_S-xNrL1Fw@mail.gmail.com>
Subject: Re: [PATCH] test/cmd/wget.c: Fix loadaddr rewrite
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Jerome Forissier <jerome.forissier@linaro.org>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>, Yasuharu Shibata <yasuharu.shibata@gmail.com>
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

On Sun, Jan 26, 2025 at 9:15=E2=80=AFPM Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
>
> The $loadaddr variable is a hexadecimal value, not a string, it must be
> assigned using env_set_hex(). This may break follow up tests, like the
> dm_test_cmd_hash_md5 in CI. To avoid any interference with other tests,
> set $wgetaddr variable which is specific to this test and use it in the
> test.
>
> Fixes: 20f641987f83 ("test/cmd/wget.c: move net_test_wget() to the cmd te=
st suite")
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Fabio Estevam <festevam@gmail.com>

Thanks
