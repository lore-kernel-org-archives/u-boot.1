Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04902EE49A4
	for <u-boot@archiver.kernel.org>; Sun, 10 Sep 2023 22:37:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0599686C40;
	Mon, 11 Sep 2023 00:37:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="NkvvOR4N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C052F86CC8; Mon, 11 Sep 2023 00:37:03 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 379DD86A6B
 for <u-boot@lists.denx.de>; Mon, 11 Sep 2023 00:37:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-31dcf18f9e2so3830560f8f.0
 for <u-boot@lists.denx.de>; Sun, 10 Sep 2023 15:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20221208; t=1694385420; x=1694990220; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oPVbMOq2rPa3ZqaSs2i8/MuEVsitNv40bGg6Q9ran8k=;
 b=NkvvOR4N5WSDR2FpCLxxs4MEmBcV1bE0m+0f5TsKtad9q70Koe+2VXtYuqhX1MFTxz
 4WSzFTnA/CsRIIsIMwOxiYDpAcFGxsx1d0HoILKPS6X/kYxvuN8gnMsIso2QMyoec4bN
 stquk0ikth0DtUBepCguDeN6vRIgL/JUMBgtTrlYZFDEhk2R031ir8oOcAsjzI0RME+8
 Y3PFQaZNPKrbj89oeSN6VnlNSPRanPmhEMBGKknCcIWDZsBjJsHqOZ+1zLefJdzc2qJl
 NXx4zFT4lZsSu+CI0JFhCh5y+1Mx2SxXNpO6v4aWFM72Gr21vqaUaJVKwG2EbEipikPf
 SkmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694385420; x=1694990220;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oPVbMOq2rPa3ZqaSs2i8/MuEVsitNv40bGg6Q9ran8k=;
 b=DyBtTEbXJ6NeGZnuFop+dYFVF3UeaBqvME/nsYanOXIJ/T9CCqXebWjnZTAZOWqjHg
 6BAUU3KAUPX2VCQeBtMUfHwTtB/rhxyBpVm+ZXNo3V92ekYLanzYsD5xrob3AtiIKhwn
 D3MV07EeAkwjVlYjU0QlnpTbq+pNBB98JBzjaDC0V0nWsWD8et7Q4b9LMY7KaxK8vMKu
 8Nv8QBg+0cxfuV9A8DpFrSL8EG0ONYYH02N41Ymop6vBciC8QPCANDXe9a/yT1JfnfD3
 ASlZS+p9tqFQqhMMBO5EIN2E7i1Gt6fsCK3aTMLDRcV6sy0b/lOoDjsZmDUzoS1nJXdV
 xiEw==
X-Gm-Message-State: AOJu0YwhpdLdnLT+Yz7MMHglXlfc4HPvKg4vDFlxhu9S9MhWI9yWiIvS
 EwzcfujvEIeychgOL+m6JrCpW2nKz0IZqN4yxVa0rw==
X-Google-Smtp-Source: AGHT+IHGxNRMI8hMbUYXIRZ5XfOBjlsXvCTdg4pQELtcgmwMx3+A0zRIYxSwGZSR3hX+VUwJFh1e2ralAXLjau5XEKc=
X-Received: by 2002:adf:fdc2:0:b0:317:5d1c:9719 with SMTP id
 i2-20020adffdc2000000b003175d1c9719mr6848866wrs.9.1694385420497; Sun, 10 Sep
 2023 15:37:00 -0700 (PDT)
MIME-Version: 1.0
References: <CA+9LrUHa5fZpRkgjYjDQft-L32Tzpa=FzOmMnLzM-q8RttqVeQ@mail.gmail.com>
 <CAPnjgZ33SiNPRdrMXmrwvRrKgi+mp+sJ+OBbu7=yDf19Gydd9Q@mail.gmail.com>
 <CA+9LrUEGqmsUL9xu0KzwgqhWptWOU1z4x3ncvXMYUJFomSv+ug@mail.gmail.com>
 <CAPnjgZ3458G_-+Nm-GzCbcVGV4uu7DNzYKd2cNQ=JFYZVS78dA@mail.gmail.com>
 <CA+9LrUF0ZjeXpG9UC3s0BLssN03wmVG3NRHG3xuXcZ=9vGnmzQ@mail.gmail.com>
 <CAPnjgZ3sgh-b-f3WVu9aWh82A4GA-L7nRuuApas=q4xMVhST9A@mail.gmail.com>
 <CA+9LrUFHH3gV29oDWW-oM0x-7Y5f1gYCMVvaEcHNJc9GHbfJ9Q@mail.gmail.com>
In-Reply-To: <CA+9LrUFHH3gV29oDWW-oM0x-7Y5f1gYCMVvaEcHNJc9GHbfJ9Q@mail.gmail.com>
From: Simon Glass <sjg@google.com>
Date: Sun, 10 Sep 2023 16:36:41 -0600
Message-ID: <CAPnjgZ1UAui2cNZYFtdhyz_aTc+=JWN=KrGBAs866axh7_BdMA@mail.gmail.com>
Subject: Re: NVMe support on RPi CM4 board
To: Luis Alfredo da Silva <luis.adasilvaf@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Luis,

On Tue, 5 Sept 2023 at 17:17, Luis Alfredo da Silva
<luis.adasilvaf@gmail.com> wrote:
>
> Thanks for your answer Simon,
>
>> Can you check if the device has PCI bus master enabled?
>
>
> I think this one will take me a bit more time, should this be in raspberr=
y pi=E2=80=99s eeprom firmware?
>
> Will the disabled PCI bus master also be a problem for the Linux kernel? =
As this is working as expected

(BTW the quoting seems broken in your email; also the text came out
white so at first I thought you had sent an empty reply)

Actually I can see that nvme_probe() turns on bus mastering.

So no, I don't know what is wrong, sorry. Perhaps there are some
quirks in the Linux driver which need to be added to U-Boot? Perhaps
there is a power GPIO to set?

Regards,
Simon
