Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7899FC47074
	for <u-boot@archiver.kernel.org>; Sun,  7 Jan 2024 20:10:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB7B087A22;
	Sun,  7 Jan 2024 21:10:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gj40Eofp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EAD387A25; Sun,  7 Jan 2024 21:10:01 +0100 (CET)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8006787A14
 for <u-boot@lists.denx.de>; Sun,  7 Jan 2024 21:09:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1d410fce119so3252485ad.1
 for <u-boot@lists.denx.de>; Sun, 07 Jan 2024 12:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704658198; x=1705262998; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ws9wq30uERRkeSPQLAyo1xIZL11Ogf0d0R35wrJG01U=;
 b=gj40Eofpyazrq8NSbH1nDTEtDGF8q4ZSbsmbmPJwDAAZqT08BhKBHod7dbaUIswoRB
 27KsIsOCgFU+HTFEjH7jFVkecPIcz9Sl+9fERinHc0Ur0oljylfZBnYiWe6ELTr+Mabd
 Aw5TE4sRu6G99s6REZkxRaN6JeDMg4mwS26C2Jc+NVXxAYV0hpOT4m5LGOSVmA28uEXx
 RgXcemjuwUxqHxEOk6YQSHKK7LyNi604u14Mb7XCM3UBhOaclYYtQ42nrnbiXa+iIJaP
 6ogkvNxMOwpq7dlm/B3R6wwIMdZp4HI7g2PwpEZLHzqObGTMNCoivH5sJz6b4opVJ6i6
 Cfkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704658198; x=1705262998;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ws9wq30uERRkeSPQLAyo1xIZL11Ogf0d0R35wrJG01U=;
 b=naKtfOaBSNUoK35F2aPN091STlsSZENhINfrYxsv9WARO0xsXcWRQLjCKjAf9kYBDG
 Y9IQuurCDo+dHu0LaOIVumtx7k25vKRFuqcXRsKqkVrE16DJizxDt3QCYh7XgcC436NU
 UNXQoL6tioBZg1G/3ndb0yVSu1717OlSqiKw/N2NT8yXh5Wqr70GEJQtOZv5syLAW8Fy
 Cl2/nj7UmR+D0pcGk0oqzBAwbTtcfMMKVkhOAtEGg+g72srVDhw+ef0sQSZEFSEpUZbH
 yNdtDEUuWoPYST2AgJRiYRTANDT5Mapp5F7KXTGIoRmCLwIZuueEoR59SRQOCp/YHMH/
 DtPQ==
X-Gm-Message-State: AOJu0YzuFVOcL7jcy9fbd0/bPRFfZPZstRbBT7sDFQRRBidZAhXrPEWw
 wSJiVRqznNTjjr32bk0edJEOvhEOUkGpnlIMRrrA9KT1jH4=
X-Google-Smtp-Source: AGHT+IE/B+gPGRKjrgPZwQX6+VctN2NTXr0hpEB8FM6azIzwlc8+4DppYnoDWAJpiFYe4SRxhDX9gdSqSOoaha3fy/4=
X-Received: by 2002:a17:902:b209:b0:1d4:e1d7:373d with SMTP id
 t9-20020a170902b20900b001d4e1d7373dmr5905073plr.6.1704658197703; Sun, 07 Jan
 2024 12:09:57 -0800 (PST)
MIME-Version: 1.0
References: <20240107200102.19249-1-michael@amarulasolutions.com>
In-Reply-To: <20240107200102.19249-1-michael@amarulasolutions.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 7 Jan 2024 17:09:45 -0300
Message-ID: <CAOMZO5AO5X3aHR0AyriijYa309USuA0HJ6oKrHTqQvhW7i8i9g@mail.gmail.com>
Subject: Re: [RFC PATCH V2] net: wget: Take in account tcp sequence number
 wrap around
To: Michael Trimarchi <michael@amarulasolutions.com>
Cc: linux-amarula@amarulasolutions.com, u-boot@lists.denx.de
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

On Sun, Jan 7, 2024 at 5:01=E2=80=AFPM Michael Trimarchi
<michael@amarulasolutions.com> wrote:
>
> Coming from some discussion on mailing about wget unconsistent. It's
> just and idea to play around
>
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> ---
> RFC V1 -> RFC V2:
>         - drop random train change in unsigned difference

Same behavior: I always get Bytes transferred =3D 1448 (5a8 hex), no
matter the file size.

Please try to reproduce the original error when you get a chance.
