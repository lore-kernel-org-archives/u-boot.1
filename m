Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 424C1C4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 12:38:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D21F874CA;
	Mon,  4 Dec 2023 13:38:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="eUnyt13T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9486F87078; Mon,  4 Dec 2023 13:38:32 +0100 (CET)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BEFD1875B6
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 13:38:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3316a4bc37dso4147099f8f.2
 for <u-boot@lists.denx.de>; Mon, 04 Dec 2023 04:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1701693510; x=1702298310;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YFcB1YytL2KIKS/NaaBUHF8LYBwYi8Exfx5L7WRGXmA=;
 b=eUnyt13TihVKDtbFS6MsKnqEDUWHdAXYXyg8nIYSGM5jln7oZh3WwNE2y69HSk8D4B
 YYoq+PaI+3nc7d7+ps78ul2029Pcli2Nx3S4n9PT9VTKqtV2ZO9sYt/lz4O6AxX1BSlt
 LJTxBVNcwcB5e7B2nkW+LHBO7O9k7xhxnPwMOjo/dzOibDkWiXqioW9F6LFhks7PpY/f
 Dgj4lHKGy+hzVUBI2LevvtjWNPEvIlrlOqX2xNvLoY4QSynHjx4AnfjiE/sEw8UXjXiZ
 IFgUsMVa8499fOZyXbw1ttB1dbd+cBiF0e57EAti/pZjSIwIQuU/DrrWO3S6IV8cLe4O
 r1xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701693510; x=1702298310;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YFcB1YytL2KIKS/NaaBUHF8LYBwYi8Exfx5L7WRGXmA=;
 b=bkrF6gIrRcQH7CLiZ9uoHkoHu2MjnQGi8LtdGQ8IA2A2VjHSwfTo9VaIHg7zP4Epfo
 cgsncmh9QEH0DNAyWaSNyTF+iBFnO7tXMc2oOcP182/JjkOMYw6dSjOrUiMOpiZX7Z7i
 IyJfydTRBRJfryyfY/wxbdzwhUuo3p5DSeofCuz9kyDwbrkwuRhkqhXlcQ7aCLRL5rBc
 PwYER9QTWcQkH0q29i/Bk4Z7O3Iwz8A4VA1C2Igz/+iVWzvaFQeTxmNxcvhMg4cb7aQs
 tqHYgLzajpChLtUExEzuUEl72n32oxCBBCV+8fT9rMVRcOYz2YzZW3Mi3MLMKaHfsEyi
 lJ0Q==
X-Gm-Message-State: AOJu0Yy00Pe/ZRlB7xpf7k1Ir5BPIjz8yUl3b7JK2j07I4lD2qolxnov
 dglMupMXB2GnwQ3qTuLJjKTnfcPOk6vNU9Myd+PHO+VU
X-Google-Smtp-Source: AGHT+IG9p5Ds8fTt9z+1VhQbiQ3KaKveKcNtdbIWvtv/ChU5BzxFZpgi/JzUrepfvD/KN3G3+fqwjQ==
X-Received: by 2002:a05:6000:11c6:b0:332:c9eb:87dc with SMTP id
 i6-20020a05600011c600b00332c9eb87dcmr3126976wrx.44.1701693509765; 
 Mon, 04 Dec 2023 04:38:29 -0800 (PST)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com.
 [209.85.208.47]) by smtp.gmail.com with ESMTPSA id
 n6-20020a5d67c6000000b0033335333d88sm7641836wrw.43.2023.12.04.04.38.29
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Dec 2023 04:38:29 -0800 (PST)
Received: by mail-ed1-f47.google.com with SMTP id
 4fb4d7f45d1cf-54c67b0da54so3627617a12.0
 for <u-boot@lists.denx.de>; Mon, 04 Dec 2023 04:38:29 -0800 (PST)
X-Received: by 2002:a50:cd50:0:b0:54c:2a05:fab7 with SMTP id
 d16-20020a50cd50000000b0054c2a05fab7mr3563041edj.0.1701693508687; Mon, 04 Dec
 2023 04:38:28 -0800 (PST)
MIME-Version: 1.0
References: <20231119165501.1305136-1-i@shantur.com>
In-Reply-To: <20231119165501.1305136-1-i@shantur.com>
From: Shantur Rathore <i@shantur.com>
Date: Mon, 4 Dec 2023 12:38:17 +0000
X-Gmail-Original-Message-ID: <CAHc5_t3MwUvFdQQaZGeONxS-JNuB4mYXyU9YSexN8bCbQUTRYQ@mail.gmail.com>
Message-ID: <CAHc5_t3MwUvFdQQaZGeONxS-JNuB4mYXyU9YSexN8bCbQUTRYQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] bootflow: bootmeth_efi: Fix network efi boot.
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
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

Hi Simon,

On Sun, Nov 19, 2023 at 4:56=E2=80=AFPM Shantur Rathore <i@shantur.com> wro=
te:
>
>
> Currently bootmeth_efi crashes while doing a network (dhcp) boot.
> This patch series fixes issues and both network and disk boot works.
>
How can I help to get this patch series merged in?

Kind Regards
Shantur
