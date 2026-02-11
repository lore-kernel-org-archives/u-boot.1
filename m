Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3313AEB597B
	for <u-boot@archiver.kernel.org>; Wed, 11 Feb 2026 08:22:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 447EA83A5A;
	Wed, 11 Feb 2026 09:22:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XfVzUz/D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 903B383D6C; Wed, 11 Feb 2026 09:22:17 +0100 (CET)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com
 [IPv6:2607:f8b0:4864:20::836])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F8318367F
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 09:22:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@gmail.com
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-5033387c80aso8948671cf.0
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 00:22:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770798134; cv=none;
 d=google.com; s=arc-20240605;
 b=YLUfCNzZfdsAJRUDrOyc5fwaLDHzeS7gF8XyEUsqM9eqMZTn4azq53MfniNK757GGE
 MqDNwRB9AEmWsU0IKIKTEEPLWj0qd3tIB11EdLQoEfnqY4R1wLyDcIqXPoZXE28UjAUG
 QwVMnS/k0Usn8tJEDVF6fVcdYfS1bt5Lvtfti9rnBERcsNEn72r/bQaHd4eHdU5VhZuV
 bf/5Cw6lMRcE94SVoCApulGGeKU1ZzWYn+ypEaSSA/2kSD6dRAvAtF/2+8wTo5ayFV2/
 GMo85IloP8F5hvShVaShSneJCaYgLtjGi+0ELJ1hvEu9dmKhlg68a3uvxd7hmRzf8ArU
 t2EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=eGFmNkBxmpjrpkhJzbwpwN1BmWxxLCIlYlO5TcuWO5Q=;
 fh=yfCs8wyjDqHdDmpzvevlxewdUnNAwbXHEDN1PCnc1ak=;
 b=F/m5KVQNcd2/AEr/Ftao0iXZLbvAtOQRoGoKD9M3+z7SvyHKiHkvvfdK/yyZaMwX3B
 ToyYhI2bD334y+zEaGIB1DhpTZuGiCvUu0sJIftSUlGkICC8vix4+bfFrRu+sb7MEOFO
 BtFScyNGAYCjl56BbHBoCIJWZN6LFPMXUx2qBnQpobOF5wLIgthEiUGu1T1LsKTHpNZ+
 MAc1Q7ujIh3a2x2B/B1P1NJNKq34//3gi50LjxEJ7IDKGFiBZHTNZTsMzlQrWuzKpLLh
 d1CJofyY8owrPuFk05K/JENs2qwZMjJOZ2Ly8tQhk1oMiLmQxH/yWYrF5VTOaq3TcXxx
 koAQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770798134; x=1771402934; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eGFmNkBxmpjrpkhJzbwpwN1BmWxxLCIlYlO5TcuWO5Q=;
 b=XfVzUz/Dh0iI0jWHzZiFTTEPNlTO+lIcMKWvaDPXFHfFXDIK+pZigFIpQWmUkQJ0Gj
 FTczsVCKfXB7lG1a/g6se1vZ98V26D7u0hb5h5P45XYvPoGOT0fr38sgQ7gbGGoYmimo
 GX41oSIaDQnbHUc1CJw98rUUB+yKJEqU8qZFpFKjxPAvPNEe5Yt5tRZcJuqTo3ZuY0sf
 QLA+j6TKACpjg33lMn8SN1PMMhCHEOyd92Rz9WSd0eFIwHq9A+o5fFbT06++JW9TGk7Q
 EuBrs+kTaIZR/Rq9upF1XwyezHFjEWArvVx0iKsViOygBHXHCTgqhomjK8LP5q8ax5PE
 zjWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770798134; x=1771402934;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eGFmNkBxmpjrpkhJzbwpwN1BmWxxLCIlYlO5TcuWO5Q=;
 b=KKELq/iGTlkQXmA5bEcjvS9kkRzdzEvEs9S0hvwYXwGw7GT8rU+XBbnZMv6U2jsXip
 aWbom593R0qA26TLKmuDEZ6Wx+tAnm4XC7GSn7kFl7GtevavaL0x+hnqsn17w0yi87fA
 PfMe4qG5adRm1xh4wHy13+PCH73JQ/q0xIQQLr8hx53KqoBwt3moynBe6onwtAQzQdbD
 ak79n7V4NZ5gE82YH9cdV+oTPGRneiIfWfY+XpT991o9Pyv7qwpsdi847ZXU1bL/yE/3
 XCBKjjHQXAfm8rUpBvHMMAaGj8hfFiq+B7TSF47R4gWnqq1gHkw/+iluxWpslZ1XCpQ6
 SGOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdT+e0v6Cb4cGuEwTDPEWmug5wqul7Yz/MY3qliZxHd41For2jwVa/mrwbc6ldWiDXuA+3XSI=@lists.denx.de
X-Gm-Message-State: AOJu0YyN3qY6Yuzt3RhWhwCnndmrEHZEwmhiWgQxbbIh9mwXNQVYo3rW
 tfNR/OHJ1WRnVbioJksyP/l11QQeD2tQFcOlS1g7joRhnK5RwVXGUMnrOTqQCIWN72ntuzI4gmN
 CeonbB+7sr3cvr5JA/+FeS+bzf8FtOVgc/+97TKk=
X-Gm-Gg: AZuq6aJuXGU6R7pjquvpHFT+yOuwAeNfkp3Paj3PBcyf6Xb7HJ+Db5LAhqaawEiBFrI
 TZ9TklBGwMutfNLMxMXEWI6dJbeZbrmGJ+yP6ixZ4fLWZ569uIcz01oJqevTm/O5ot1LvZQ9jfn
 0fBGv2hVZ1W8b8Op9qH5YVlRrpOjONsg47Vjy95oQDZF8kxdCUtlSb2zvpV2X4ju+GPtUcXVynt
 7yuEtyBLVxWg1zb7bAeV/vKSLV4BjcuuFZmljJxCYG24wwWA0DRquKgMJiMEXxe5ESYfRpoJPvR
 eTOinbyIJTZPiiFUazbgVFuVC8C95T/YMxtxL19d
X-Received: by 2002:a05:622a:9011:b0:502:a218:1cf with SMTP id
 d75a77b69052e-50672dc8b7cmr64424341cf.4.1770798134066; Wed, 11 Feb 2026
 00:22:14 -0800 (PST)
MIME-Version: 1.0
References: <20260108133234.4001390-1-jonas@kwiboo.se>
 <20260108133234.4001390-2-jonas@kwiboo.se>
In-Reply-To: <20260108133234.4001390-2-jonas@kwiboo.se>
From: Alexey Charkov <alchark@gmail.com>
Date: Wed, 11 Feb 2026 12:22:09 +0400
X-Gm-Features: AZwV_QitrrjmW6aRqKRtnWQgpNhn2a4wKZVD7D3ZEVv2HrOFC_brYPXAM0m41uI
Message-ID: <CABjd4YzY3sQiVkH8ypZKuH=Yk-PPHnYgZ2V8Xa_x9TKFVGMPAA@mail.gmail.com>
Subject: Re: [PATCH 1/2] rockchip: rk3576: Allow pmu sram access for
 non-secure masters
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
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

Hi Jonas,

On Thu, Jan 8, 2026 at 5:36=E2=80=AFPM Jonas Karlman <jonas@kwiboo.se> wrot=
e:
>
> The firewall block access to pmu sram for non-secure masters by default
> after reset (0xffffbfff).
>
> Change the pmu lookup configuration to match the default lookup config
> for ddr and system sram (0xffff3fff) to allow loading TF-A using DMA.
>
> Mainline TF-A will re-configure the firewall to use an even less
> restrictive lookup (0xbffe3ff0), so this change is not expected to have
> any real security implication.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>  arch/arm/mach-rockchip/rk3576/rk3576.c | 6 ++++++
>  1 file changed, 6 insertions(+)

As mentioned earlier in the other thread, this also helps fully load
ATF and U-boot from UFS storage without resorting to bounce buffers or
anything like that, so thanks a lot!

Tested-by: Alexey Charkov <alchark@gmail.com> # UFS

I wonder what's the fate of this series going forward? It would be
lovely to have it merged, but it hasn't made it to any of the
custodian trees from what I can see.

Best regards,
Alexey
