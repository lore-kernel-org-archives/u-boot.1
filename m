Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 233FBCDB482
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 03:41:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A089B86E0F;
	Thu, 12 Oct 2023 05:41:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RVYGSx+g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A372886E15; Thu, 12 Oct 2023 05:41:32 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2CB086D20
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 05:41:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-53dd752685fso900662a12.3
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 20:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697082090; x=1697686890; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hBhtxDbIc9QGcuRsb6q6t657MWmaEMwB9SKqSkL9agk=;
 b=RVYGSx+g3ayAO0e3LefQY4zlmYKC1iFARR3aaEzw8G7mHMOUgFA2UZH4WTSVOWh74d
 TT1EW+7w85PZnTFzKp+9pZDqZrAYwPC27CAZA6JWym08/GFaISkjiyUorWetIu4Igb/w
 /0GDcgm8VKX6JHK9ZDpL6rzKs3auKDg7c39go=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697082090; x=1697686890;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hBhtxDbIc9QGcuRsb6q6t657MWmaEMwB9SKqSkL9agk=;
 b=lMVlJdaKbAG7UArdubUGzJoxj/KL3ZmDPzqKPbLsuTjrceYTXnG0VMDGZrOlOdvTsN
 Z8eHLwnYZyOvw44EsLtnxFTVn2tWudQKYTAKbeeBVI8W1VauWB/JsD1HmIQaaS28ZZHW
 3WTOI97uOH1KWNW9neRWe5+jRss1fF3SLDRXj4uL4NFmeuV05fTXE9GABz6yBtsFbkj7
 o86YC7Ul05RHwV4v0LYtg3HdvZGNft8MOmCoaGwltIMjIrGz6xxg7Ytrz2jXzu+SBHXO
 H7Rt01JV61aAqFhccjh3Lyx3P+kaIR5MclzyQu5Wukp/BTHo3xRmlxlcf9R9KaNrV3W+
 RDZw==
X-Gm-Message-State: AOJu0YwuXxKs3+oURerf42mVLf8/kEpLK4L4emoIxO3jb9JRTqTmYX37
 wTbqZbuzNW33FfykgZzk6duzOrdL4KJ5iUzEdLTr4g==
X-Google-Smtp-Source: AGHT+IEAmUrKCc3Xf1prA7QA0dV6zJtNdz+8iCTMvgtRlxnf+He5sENBj510NfN0oA5fp2PNq4l4GRr6nbYc/hRvcvA=
X-Received: by 2002:a50:f613:0:b0:53e:1721:2419 with SMTP id
 c19-20020a50f613000000b0053e17212419mr47269edn.18.1697082090065; Wed, 11 Oct
 2023 20:41:30 -0700 (PDT)
MIME-Version: 1.0
References: <20231011-binman-firewalling-v4-0-a08085d300e9@ti.com>
 <20231011-binman-firewalling-v4-1-a08085d300e9@ti.com>
In-Reply-To: <20231011-binman-firewalling-v4-1-a08085d300e9@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Oct 2023 20:41:02 -0700
Message-ID: <CAPnjgZ3NG+8-VLi5i7+h4t1aP_qa1Va1ZJdhiJzfVyd7jrHPmA@mail.gmail.com>
Subject: Re: [PATCH v4 1/8] binman: ti-secure: Add support for firewalling
 entities
To: Manorit Chawdhry <m-chawdhry@ti.com>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, 
 Andrew Davis <afd@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 u-boot@lists.denx.de, 
 Udit Kumar <u-kumar1@ti.com>, Praneeth Bajjuri <praneeth@ti.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>, Nishanth Menon <nm@ti.com>
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

Hi Manorit,

On Tue, 10 Oct 2023 at 23:25, Manorit Chawdhry <m-chawdhry@ti.com> wrote:
>
> We can now firewall entities while loading them through our secure
> entity TIFS, the required information should be present in the
> certificate that is being parsed by TIFS.
>
> The following commit adds the support to enable the certificates to be
> generated if the firewall configurations are present in the binman dtsi
> nodes.
>
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> ---
>  tools/binman/btool/openssl.py   | 16 +++++++-
>  tools/binman/etype/ti_secure.py | 90 +++++++++++++++++++++++++++++++++++++++++
>  tools/binman/etype/x509_cert.py |  3 +-
>  3 files changed, 106 insertions(+), 3 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

I'm still a little worried about the error reporting if the user
leaves out a property. Does it do the right thing?

Regards,
Simon
