Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 260B6C3DA4A
	for <u-boot@archiver.kernel.org>; Tue, 20 Aug 2024 07:39:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A76988CD7;
	Tue, 20 Aug 2024 09:39:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="24EcT4W3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E1FE88D41; Tue, 20 Aug 2024 09:39:40 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19A6188D2E
 for <u-boot@lists.denx.de>; Tue, 20 Aug 2024 09:39:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-371a6fcd863so1925918f8f.1
 for <u-boot@lists.denx.de>; Tue, 20 Aug 2024 00:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1724139576; x=1724744376;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=B9POGw+0dkCoo38oZMpvHEa3RpeTyI0hVTEIEfkm3nA=;
 b=24EcT4W3QdtP4fTcJigXvxZXXPmv9piSdX0rRyvGOCZikZHGL2km/BvdyMHcMhVS2p
 N9Fks5I2eYwGvpqBzG9UcLVxX7krsBXIbGiwGnGPBOHhra1p4bveo5u2aWmHADfqMQaW
 T+zWKEW7r6EG7Fwb2YW81ARepxyknChXhGh4tsV4K0mLMK2A0uPX2iNQKtz1BCg05JB8
 ZRwTb8Xu0fSXvvJ33UnoITi0gF9OSaTmzBvsPe/4CFh2sURr9BlSf51LeXsrVa28kQ1q
 O1kdWavALxiEn+vhKpEfdumNlwfZjHpjuyYK72lZPrJ35mHt5cSbQjOqN0PIRMzep/D3
 Ho/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724139576; x=1724744376;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B9POGw+0dkCoo38oZMpvHEa3RpeTyI0hVTEIEfkm3nA=;
 b=OigT6sa/Hae2JLcC3J51N8Gc+Ymm88b95oNElChpgG2wGdJCYAaTl099k0ViJOvVkG
 jZPE5Wkb2s4N7lC6ItbiUlwNMVqkKXAI4mFUAwwE+5LIL6P46+Hw3MiMc0fwcfeZceY1
 SoEUjJC+9ZEjukXwKsiC9/lq6xDPtHom7KnJc5Y34/Trdanx5TKTtRk5D5RSTnLw23kF
 aHGGOzgrTj3HTVSsyjq7BbRLDLzRLJGwFLTxEW5Lzs/3GzVKioqLl8ivk+wDdxaiSACv
 9IHyTG8rw+HHECs+4ZHQ++piZ/ccM65SNln4mGrIfQmeAiF4UMnkkHjoUZakTVGiE9+6
 If/g==
X-Gm-Message-State: AOJu0YzXeYGdXZ57vw0AiyLfdYR+hiKi+rTL0mcqYhe8bzSAsy6Lvpwq
 BJGi0TeTsUy/4nbkHENknjaYiw8wziN5aURIDcCMesZpo8pKZ7bE0IWebR953HAkRBsAHQdYGqS
 P
X-Google-Smtp-Source: AGHT+IGIue6x2TN8F22YpzS8vmSmD05X6SxRDI7LYETZ5omDHcbEvzZwNwPKWZ3Es1mCqvn5Qi0gow==
X-Received: by 2002:a5d:5e0b:0:b0:371:9388:2cdd with SMTP id
 ffacd0b85a97d-371983d5f44mr6437368f8f.17.1724139575984; 
 Tue, 20 Aug 2024 00:39:35 -0700 (PDT)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-429ded364fesm185157655e9.27.2024.08.20.00.39.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Aug 2024 00:39:35 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, Lukasz
 Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>, Zixun LI
 <admin@hifiphile.com>
Cc: u-boot@lists.denx.de, tools@linux.kernel.org
Subject: Re: [PATCH] cmd: bind: Use device sequence instead for driver
 bind/unbind
In-Reply-To: <172413500327.69624.5444644456831665790.b4-ty@baylibre.com>
References: <20240802092820.917450-1-admin@hifiphile.com>
 <20240802092820.917450-3-admin@hifiphile.com>
 <172413500327.69624.5444644456831665790.b4-ty@baylibre.com>
Date: Tue, 20 Aug 2024 09:39:34 +0200
Message-ID: <87wmkbve15.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

On mar., ao=C3=BBt 20, 2024 at 08:23, Mattijs Korpershoek <mkorpershoek@bay=
libre.com> wrote:

> Hi,
>
> On Fri, 02 Aug 2024 11:28:13 +0200, Zixun LI wrote:
>> Currently uclass index is used for bind/unbind which ignores alias
>> sequence numbering. Use device sequence number instead as it's
>> the number explicitly set in the DT.
>>=20
>> Also update documentation to use sequence number.
>>=20
>>=20
>> [...]
>
> Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u=
-boot-dfu-next)
>
> [1/1] cmd: bind: Use device sequence instead for driver bind/unbind
>       https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/0c4850=
7eee08b5e7d4e8484727efe47cfabff0ee

Somehow, b4 did the wrong thing here when running:
$ b4 shazam -s -l --check 20240802092820.917450-1-admin@hifiphile.com

Grabbing thread from lore.kernel.org/all/20240802092820.917450-1-admin@hifi=
phile.com/t.mbox.gz
Checking for newer revisions
Grabbing search results from lore.kernel.org
Analyzing 12 messages in the thread
Assuming new revision: v2 ([PATCH] dm: core: Show device sequence instead i=
n dm_dump_tree())
Assuming new revision: v3 ([PATCH] cmd: bind: Use device sequence instead f=
or driver bind/unbind)
Analyzing 0 code-review messages
Will use the latest revision: v3
You can pick other revisions using the -vN flag
Checking attestation on all messages, may take a moment...
---
  =E2=9C=97 [PATCH] cmd: bind: Use device sequence instead for driver bind/=
unbind
    + Reviewed-by: Simon Glass <sjg@chromium.org> (=E2=9C=97 DKIM/chromium.=
org)
    + Link: https://lore.kernel.org/r/20240802092820.917450-3-admin@hifiphi=
le.com
    + Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
    =E2=97=8F checkpatch.pl: passed all checks
  ---
  =E2=9C=97 BADSIG: DKIM/hifiphile-com.20230601.gappssmtp.com
---
Total patches: 1
---
Applying: cmd: bind: Use device sequence instead for driver bind/unbind

It applied:
https://patchwork.ozlabs.org/project/uboot/patch/20240802092820.917450-3-ad=
min@hifiphile.com/

Instead of:
https://patchwork.ozlabs.org/project/uboot/patch/20240802092820.917450-1-ad=
min@hifiphile.com/

I have fixed this up manually, see:
https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/73f5b54a589cb6=
ff97aaca55e7c97d68b43997ee

>
> --
> Mattijs
