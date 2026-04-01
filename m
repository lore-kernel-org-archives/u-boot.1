Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4E2B10FCAC0
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 18:20:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5526A83CE3;
	Wed,  1 Apr 2026 20:20:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="s6auvX+T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63DCA83D8A; Wed,  1 Apr 2026 20:20:04 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19FF680517
 for <u-boot@lists.denx.de>; Wed,  1 Apr 2026 20:19:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-66e02a7ee78so87452a12.1
 for <u-boot@lists.denx.de>; Wed, 01 Apr 2026 11:19:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775067597; cv=none;
 d=google.com; s=arc-20240605;
 b=T/MSm90rxaqYxVczZYCrX313gc6RuxK5i8Yaam9xCxkorU3wwsX2Zclk4fRnYkZNJd
 +u4vU6yaiJ1EaNHxBZcLQyE/ebC+hVq+pvi5RGdYClwkGzb21KRZi7/j/mHFVj98kkGQ
 zEGH+3yI1OrpW9sr2Vbn0H0mq0L3Jit6tMf6YvBVLHR9CVtC2uFscVv7D0ssKN6O+Hul
 IpJp2bKG/n+PkuDsYlk1KAWY70jBF8ng0vidqo5u6lbkEOKXWiEkZ9jITVXcUKmjQ8vd
 J16hewikRBV6NV5pC4Q3kYcp9KrwE4rqAUtNC3TRzgWcmHC07J7kO4pv8Hx/sgg5zdjY
 QWXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=LY74vE9PQkFgWmI3LVh84Q0dRfA1lMMeIRSOZKtAsjs=;
 fh=btOZ8CUH8xL9iDq9K53tFkAldBGwUZe0enzK/rY22Z4=;
 b=cE1QHJ+h1QknipkBgdoLA3E2SFyQ7CbIznnRnbQh+be7lXe4Nfy3fHtjHwvCreA/1Z
 tcjXA4coVfYtZ3KO/5moG95Ke2JWaNureD4WtZCDZXlVqHbBJUm5BdgfGAxQE4KULWoS
 WpzRsAza94rnRpGUdvBI5KE7hjTxeBz1rqVg6aFMhvL9tdj1KH9SifZaqsVpucqXeSkM
 p8zHISX7J86O0rhps9i5uS6CkaR9XifdNCvwne/qIBs5p3MgcCpEJSdOXPj/Ia0FYZjx
 XCqVFJ6kPbYWD/yiPVI0awgnug2eaemMEhe7VAuJMlFAFg7BpSc6KylEoahjLqFjfmch
 Y4vQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775067597; x=1775672397; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LY74vE9PQkFgWmI3LVh84Q0dRfA1lMMeIRSOZKtAsjs=;
 b=s6auvX+T99BmfSRV5UUeen2CJXZVTKmpRTdi1s6AKtwaM0SYQygYn7EV1Krc9p3r89
 DWMnTMN65oz95QeO1ZjeoZWQkFcdjOW+tE4ZIqar1eIQJK/nCawv4gb+0xmy5EuRB/IN
 mRrBFYr5GAkHJMaYQ3Hnhjb7i5vtu2ct/iyr3xItbJ0iy/TGSLfQCZePd+xfphBnxdF7
 1c0WUjibkEY39Vo83Spv/Z/kYdPc531CqP3SfHV7TMI0wNOUObljrWSdsYrXunI6h2PM
 G2M5LdmEUZjTvVOknj8/LLd5WvR29R7zeDooJ4uMhDT0xLkKXY8XSd7bG/Ao+AfMSYk5
 U3pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775067597; x=1775672397;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LY74vE9PQkFgWmI3LVh84Q0dRfA1lMMeIRSOZKtAsjs=;
 b=aGQtQk2YlPdRF6nsisnepZYJThIMWzV1JlFqQ0TVhS5n8yPmZ7Y7a38bsxOpfZ/kil
 QN2LMabFgopnFsfgPLUQJgsvdtNq3uciuOrpaESCIIC7jrUXXd63f19ajiq4V/VdB3Z8
 P7V2XR7pnFJkDt2uwZByfa6wZ41HuDL4drpA2ZEne22IhHfaiXCWwWHLKKM7C2Yz3qaP
 QEVJANksWw762F8g43oNE5O8UL7OjJzGuAJiN2uNyzXMmPTwC/42vTO5EdWD3tveZp2v
 zAZiXAFIZ6ydvK9BQjqu59KBwlIV6ORMe+XlhQHwiNSqd5Z+HEyScwmU8+ARqxANEgrU
 FRiw==
X-Gm-Message-State: AOJu0Yw2JW+QqmnpPGDkap85qhIeihdJVIdZB5GXvDnvVHefgNQGx7vE
 jDd2O+SHepE0Upi36Wj6EpFt/HL8a2phGEl1NkXMuZt9loPZidupWJOzWPSZwrViJFPDY+CxsKM
 zmKh4OJalT7rXtAb5PC9uB5+lrbqQqN0ZUdpS
X-Gm-Gg: ATEYQzxkm+CIcSTvVzJMtqcyQhFeUyg0sSZOnutxYqq1sfZo18StQ63d+6w3kfD4QIF
 CrZWb0Lpyckv6x/x70ofu7pssZb0k7Q/krsEMZIEu5F4aS4BzTYI4Yg6pmClGdxLNdG6qnmaqmn
 XjgAePIYuRhj6y1DjRaQxZ4yM2DzjaEZcqrsclyc6x0dwymnxrpLm8d+aYwpvimGXm6lcU7FIDy
 ULAZ8HYhkOzUFjOkV5MCoeDL0MYuC1+kIUeUCTxz47qdNMVEjC02SdObmNlk9h2VVtmMbrxnjcU
 m4hOeNqExlWwPbsS6I4NNEoO2JrL0xukMlB1nT5VdHUUFfoNl12/dT1Sg6PeDr8FnaqOxHbU/4D
 kix9eWxdRXISHPsKAYuc4tFwafkXXlmnuK2Ih14qAhdLlwdljco15bEpB7f9qeH3uc4dOawidGS
 CU
X-Received: by 2002:a05:6402:51d2:b0:66e:4cc:e64f with SMTP id
 4fb4d7f45d1cf-66e04cce8b7mr18199a12.8.1775067597235; Wed, 01 Apr 2026
 11:19:57 -0700 (PDT)
MIME-Version: 1.0
References: <67f0f5ab-9514-4df2-915b-db983abdf3da@app.fastmail.com>
In-Reply-To: <67f0f5ab-9514-4df2-915b-db983abdf3da@app.fastmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Wed, 1 Apr 2026 19:19:45 +0100
X-Gm-Features: AQROBzCSmHPAUOiOAZjmW5CoGFM5fSRcC8N4ksPp3cAq6MKmaXCP9EHN0kjYfZQ
Message-ID: <CALeDE9MMcoWYPZ0VOFqvZfqZ72utFyUPm-A6fyUbG4ustP5M0w@mail.gmail.com>
Subject: Re: rk3399 u-boot docs - arm tf-a compilation failure
To: andrew@internet-e-mail.com
Cc: u-boot@lists.denx.de
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

Hi Andrew,

> Building TF-A (per https://docs.u-boot.org/en/latest/board/rockchip/rockchip.html#building) fails with the following error.
>
>   LD      /home/andrew/arm-u-boot/trusted-firmware-a/build/rk3399/release/bl31/bl31.elf
> /usr/lib/gcc-cross/aarch64-linux-gnu/13/../../../../aarch64-linux-gnu/bin/ld: /home/andrew/arm-u-boot/trusted-firmware-a/build/rk3399/release/bl31/bl31.elf section `.pmusram' will not fit in region `PMUSRAM'
> /usr/lib/gcc-cross/aarch64-linux-gnu/13/../../../../aarch64-linux-gnu/bin/ld: region `PMUSRAM' overflowed by 3928 bytes
> collect2: error: ld returned 1 exit status
> make: *** [Makefile:1031: /home/andrew/arm-u-boot/trusted-firmware-a/build/rk3399/release/bl31/bl31.elf] Error 1
>
> I'm using a VM freshly installed with ubuntu 24.04 and crossbuild-essential-arm64 gcc-arm-none-eabi binutils-arm-none-eabi. I'd appreciate any pointers.

Are you using a particular release or just building HEAD?

I've built 2.14.x recently.

I think that section for the rk3399 might be missing a section, the
rk3399 has a Cortex-M0 scp/pmu so you also need a armv7 cross compiler
and specify it with "export M0_CROSS_COMPILE=arm-linux-gnu-". I'm not
sure if it's auto detected so I wonder if it's trying to build it with
a 64 bit compiler.

Peter
