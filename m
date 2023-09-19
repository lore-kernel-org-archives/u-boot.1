Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87152CD3445
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 07:22:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7056886A3F;
	Tue, 19 Sep 2023 09:20:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iMLAwznu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4636C86AF4; Tue, 19 Sep 2023 09:20:27 +0200 (CEST)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CCDF86A3F
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 09:20:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-502e6d632b6so8234035e87.0
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 00:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695108025; x=1695712825; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PEBL8Zdb6+/Aow20YugkXtG2ktjeQAGyxCvI2RzvmW4=;
 b=iMLAwznubHBHt+ykbgRdC6oKFwct7AL5O+mQBCwYiNLQegRMgO4iFFBoTop/iqi0LC
 Zlfj0OAtxWtvs5waETI6CXDxX1IfBKnAQ/580wjufzeR+/u+mUkaZNhNUDwIUF8qBEba
 FN+deuFZ4GN9JCrEU3iVWuqJK1SZOyaJyL5ZiIT676UbG8iB8OR3l8kJiZjAuDI7phf/
 v2CtOJJevLea833v5tBam3V87SnpbyNj4k9A0LCEKL7meAtJaVeTWd6XWt58qdRr5+h4
 86Mm+BXkow5Mi/ethEhBy6uw6WQ3f3y7PYaojANfFEszHgxAGUnm7MjGYlf3AGtnrl4h
 1bBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695108025; x=1695712825;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PEBL8Zdb6+/Aow20YugkXtG2ktjeQAGyxCvI2RzvmW4=;
 b=GvQjqaA2dGx7WxDj+hhkImW+5Esc3hASEVEKltzijZZbSzppZ8yk3aG+qcnI3pfSAg
 9tbOfrH5wcUf59pvtx2oJRB0dDYEyImtAprtb2Crva39aaCgD8uIVRHGYTmQMHMaqDrG
 ka/2/Z0+vXGXemEoIf4jaREOnm7IS3vQFHVCoTyvpTUvUCHroTag7WV1v2kcHeW+AVQM
 7c3TbYNPf0HJKDNlBXX0GQ5SLRzPNm0ijcLOimKpKY2jFN5MIo4g4zhwPJP2R28sa6nJ
 e/FwSe5akO7ArJAHLiELkL/PcbvPEewkqAhm2rFHJeai/Pn03289WGl3yuHMbSYuCI8Q
 uuBQ==
X-Gm-Message-State: AOJu0Yyfvsfb8PYAAn8uc6QYdjd3dfpHSWrnVUaWRJzeRy2TlonJqyl3
 buuA3PVJdp/51J3coNBRbg5N+YiRIm04KO8pKDA=
X-Google-Smtp-Source: AGHT+IHFMmxNcgTMC9HGlu/CcOs5Z7qr+WLyLcDwkhdVCiNZ3Yxeyu3QV11TpdMLJ1V/6w9A7rsflP42CHc5scqIz8A=
X-Received: by 2002:a05:6512:2207:b0:503:985:92c9 with SMTP id
 h7-20020a056512220700b00503098592c9mr7092270lfu.22.1695108024666; Tue, 19 Sep
 2023 00:20:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230823211059.1235147-1-sjg@chromium.org>
 <20230823211059.1235147-21-sjg@chromium.org>
In-Reply-To: <20230823211059.1235147-21-sjg@chromium.org>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Tue, 19 Sep 2023 15:20:07 +0800
Message-ID: <CAEUhbmVqSb4ha6q8A2z+Mnqoog8=D_wugf3pc1dcLVMk+0UHJw@mail.gmail.com>
Subject: Re: [PATCH v4 20/20] x86: doc: coreboot: Mention 64-bit Linux distros
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
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

On Thu, Aug 24, 2023 at 5:11=E2=80=AFAM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Add a little more detail as to why coreboot64 is preferred for booting
> Linux distros.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v2)
>
> Changes in v2:
> - Add new patch
>
>  doc/board/coreboot/coreboot.rst | 2 ++
>  1 file changed, 2 insertions(+)
>

Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
