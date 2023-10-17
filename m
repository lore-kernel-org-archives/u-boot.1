Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B859FCDB483
	for <u-boot@archiver.kernel.org>; Tue, 17 Oct 2023 19:05:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25EAB86EEC;
	Tue, 17 Oct 2023 21:05:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DMs9fYKB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8A6586EFB; Tue, 17 Oct 2023 21:05:29 +0200 (CEST)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 728DB86EE3
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 21:05:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6bcdfcde944so785303b3a.1
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 12:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697569526; x=1698174326; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xHeaztgjATvb63k0Unq/1X9aUKSmfMxx/Yb/eWIgvmE=;
 b=DMs9fYKBfKYfq7ycZRZAf77/DQrn3N1y+wUGXqp+Y4lvQhtl2sZzRjSR30XXJs9z1W
 ajZp7osvD8YQYX0xaz1PGg1wCin+yue5KBqWcCRRqVJF2x7oNdI1SlcSgU2E9Ykxux4F
 4/O6n8jn3gr2r7iov34N/voIjOoauPTTsrLbw6iC+g7BrWgKLxg31EbOpiQ8i51D4HRR
 yskEz8+cjT4PDvfc9K1WAJUyT/wDrVRuezUdQwr6UU8aKDWXF+gNQSrcmVpge/28JeY9
 fGtVf6faXXjintzaLQ6bqGUZWkrT6yAj6T00ofe4pQi30GdXdP8qSGehye+S/WilxsED
 gyOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697569526; x=1698174326;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xHeaztgjATvb63k0Unq/1X9aUKSmfMxx/Yb/eWIgvmE=;
 b=h1dWdfuH4ClX4pvR8zMUtooEmbCxaYUTbgDb+XCenuF9BT31Dsq29cIC/DU+QUz+wQ
 3Y9qDQb4EOUkruSkYI1N1Kv1herE5u43Yqnv5lpCt+0BIg4fq5GYQq0fpFGNP4XFcuP4
 hwtWsvclz/Im1rD8jaSbpIXlayziE2akPYuOzGi9XyFD88c5zaMs0RGgCNpggi//98me
 D891HCSPN3ffOFqQZ+r6QIh8dS43sKvZC1abGtg/rUF6+CRA+wJtc2QoP208HnAEDvW8
 GpnxSUScJG2+zXDUnUoa6BAq4WZlj8GO0vahKO3y2b6h3/NgtX3pttkLwPHpEHAzIxY0
 /Ujw==
X-Gm-Message-State: AOJu0YwCEU+thhVatCcJM6ENjW2x6jIsNsut8G1O5uBO/LOGVllAbNGk
 RuD9Wwgs4jBAgrzhYrWsbUNVTKCMdNUoIiYyZsqKY9CRuOQ=
X-Google-Smtp-Source: AGHT+IGl1xmgryYZ6fXYS0wo5QnpVS7s4kC9FDFat5FcNWzelwfkVzeVHxLeWLS6/O+K8bijBh8al+NDrV0r7OErZa8=
X-Received: by 2002:a05:6a20:d80d:b0:163:c167:964a with SMTP id
 iv13-20020a056a20d80d00b00163c167964amr2892866pzb.1.1697569525780; Tue, 17
 Oct 2023 12:05:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAJeqHvL8xNKOZ=WD3PVjQVGz_S-EU3qDRCV1LwY4auOWxTq1dQ@mail.gmail.com>
 <CAOMZO5BmGMUJq1m=eq_7ckDDx2FSg7LtU8bC6BE_fFc88MJZSA@mail.gmail.com>
 <CAJeqHv+V6KoddTR7XA6Z=Z7tzmGx=ZH1jZN2v=pAuURcR70FnA@mail.gmail.com>
In-Reply-To: <CAJeqHv+V6KoddTR7XA6Z=Z7tzmGx=ZH1jZN2v=pAuURcR70FnA@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 17 Oct 2023 16:05:14 -0300
Message-ID: <CAOMZO5C=2AAKC25ip1r5qKFdTyOmFphsXAzjCR0hpt3ar06aYQ@mail.gmail.com>
Subject: Re: failed to build u-boot mt7621_rfb_defconfig
To: Xiaobo Liu <cppcoffee@gmail.com>
Cc: U-Boot-Denx <u-boot@lists.denx.de>, ryder.lee@mediatek.com, 
 Weijie Gao <weijie.gao@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>
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

[Please keep the list on Cc]

On Mon, Oct 16, 2023 at 11:14=E2=80=AFPM Xiaobo Liu <cppcoffee@gmail.com> w=
rote:
>
> Hi
>
> I found the nand rfb u-boot mt7621_stage_sram.bin, no spi-nor version was=
 found.
>
> https://u-boot.readthedocs.io/en/latest/board/mediatek/mt7621.html
>
> Where can I find a version of the mt7621 spi-nor?

I am not familiar with the Mediatek chips, but mt7621_stage_sram.bin
seems to be generic, independent of the boot medium.

https://u-boot.readthedocs.io/en/latest/board/mediatek/mt7621.html
shows the same procedure for generating the binary.

Then the last line says: "Burn the u-boot-mt7621.bin to the SPI-NOR or
NAND flash."

Adding the Mediatek maintainers on Cc.
