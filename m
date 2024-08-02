Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DBE5C3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 00:24:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6942788B44;
	Fri,  2 Aug 2024 02:24:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="t33JaEN9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E669188B77; Fri,  2 Aug 2024 02:24:12 +0200 (CEST)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCCBB889D2
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 02:24:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3db50abf929so1118776b6e.2
 for <u-boot@lists.denx.de>; Thu, 01 Aug 2024 17:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1722558249; x=1723163049; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xfa2T9scLmfRAiwndydkjieMrbdZ1Pa1x/1vUmwltTM=;
 b=t33JaEN9mM8T9sBumwWbSzSXBPaiFXngucAcTbfnsdGQMrt6ti7lKAywvLi1waoCWM
 uXCFVM8YaOAjLi8NF54+vODDASzdJ+GGPt6TsY+zUaQl9I/HTg3HtMj0Ym+gfZlcOsvO
 guTzcXwOVEpaPmlhAm4z52dlGcnHTiiWvFA/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722558249; x=1723163049;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xfa2T9scLmfRAiwndydkjieMrbdZ1Pa1x/1vUmwltTM=;
 b=rfUpE96BeQcL+oTd01AusSULFWFYBCd7HnOL1dD1EesEuSGujpR467xSfH8+JI3nOr
 al5CsSPhFtzMvf+esbohyJBene2fhamqSiRUOWSQXqqzOULfW1VYYyuFKem6yH1/s0DM
 sQLmLI3sanYLpOrsirCqJ7yRuYOM+T6lCFmvCjIpTP1m0RS11tAhrwBhkN1QsVbdPyMr
 h7hPTypHZpcZLtyZ2P8Vue5dDZXBXxTQ9qgEcElWJjLlGZgL3wdr5wRRpzcAocPcmoYZ
 c5AXEPT9srSUmoevGx0wvlYKmaBm7tOvEGrf8I3Q+hqepkwNQEmNSMAMzEW8SUa4DLKi
 Nx9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvoo3n/fztJlwZ1NcEde4HL61Ggq00bpOPkTW32MnUyRfuoLfngT1dD/O2W8d8SDfy3lrj5BPS4fLIb3G7Wj6RCpZN1g==
X-Gm-Message-State: AOJu0YwZPaqW7Pe/ZFXc4FP9jAwjSS9w2pGp+xfAJA+kzJUG2BGr053a
 2/huHKs5nkmWLgXpIOYqm4gJ+vP0u1pZwjtTpW8EJ1IHJsx51t/DQ3TSrvbfaD0=
X-Google-Smtp-Source: AGHT+IHCXFxshxGGGK3B9risABaIk1P4LhCmujjNZ+GzY6vUyc5nCehveivVadaG2W6dnrZZQ/JtPQ==
X-Received: by 2002:a05:6808:1495:b0:3d9:b33e:d3ef with SMTP id
 5614622812f47-3db557fed9cmr1892892b6e.3.1722558249489; 
 Thu, 01 Aug 2024 17:24:09 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-103-190.totalplay.net.
 [189.203.103.190]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70a31d9dcaesm232611a34.7.2024.08.01.17.24.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Aug 2024 17:24:09 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.denx.de, John Crispin <john@phrozen.org>, 
 Christian Marangi <ansuelsmth@gmail.com>
In-Reply-To: <20240628174114.8675-1-ansuelsmth@gmail.com>
References: <20240628174114.8675-1-ansuelsmth@gmail.com>
Subject: Re: [PATCH 00/12] clk: mediatek: add OPs to support OF_UPSTREAM
Message-Id: <172255824832.13067.13074238248729581346.b4-ty@konsulko.com>
Date: Thu, 01 Aug 2024 18:24:08 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Fri, 28 Jun 2024 19:40:45 +0200, Christian Marangi wrote:

> This series doesn't currently change anything and it does add all the
> additional OPs to make support of OF_UPSTREAM.
> 
> While converting the mt7681/7686/7688/7623/7622 it was notice lots of
> discrepancy between the downstream dtsi and the upstream one and the
> clock ID between downstream clock ID and upstream clock ID.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


