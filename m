Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B741ECF258D
	for <u-boot@archiver.kernel.org>; Sun, 13 Oct 2024 20:24:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FCA789069;
	Sun, 13 Oct 2024 22:24:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KlV24AXr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D023D890BF; Sun, 13 Oct 2024 22:24:19 +0200 (CEST)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E43D489067
 for <u-boot@lists.denx.de>; Sun, 13 Oct 2024 22:24:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-539f6fede4dso223503e87.1
 for <u-boot@lists.denx.de>; Sun, 13 Oct 2024 13:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728851057; x=1729455857; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1eWtpe3LZcA6e9EziyBEVHD5OaHKd0IwHKaX2zuVcuM=;
 b=KlV24AXrU381UbjnxnR/VGxIimPEYbq3sfANnOn/VmoY8T6Zywm5mIbEi/srrwAAGh
 C/8iJXkZDed6DwBN6hJ6khE0F6CTsXeFnakH2I9p/yUTF6XLcXOeKp9CFBwOElIpCdQh
 ootKImMDXCoyx/bwI4HeW3nrUz5IDiy+m70gACaaEj+dZkGCe4fVNtSYsAxrzMFzlj9S
 garTh36XtLXkCQighnAPOd8npnVYnGyIC57IZTPe3rsW2QErw27uLM8ygpx6Qe5Ms2I9
 oOjD1es6HJXIFYBKiZdsSBo1VgE5bLwK5QcMcF7E3VxoDO/kaWvz7C0HsS48ZAIC3B0N
 Aqag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728851057; x=1729455857;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1eWtpe3LZcA6e9EziyBEVHD5OaHKd0IwHKaX2zuVcuM=;
 b=Gpa/X06UyjQbLuqIlB/50ckdWKMdOl2XUEc2G5zIKJWEUn0R68BJqabo6hEz6I6wKu
 y8P/qrvsIeGj1ow9EFY1d4NUeEpBnd88dTff81R6/9PEeUninmslXHQp1K/g3170LLW7
 t7bER/AoKoPiGztC9XmD8muG9jOH6Sr1ZHvFCcnWrqu6ZZr0FiaqijyP/T5cumtfd3Qf
 Zxad/RINehkuYbEWN1eDsBXnUFA95+4Sglyd1gROv9gHi7wki9xCiTHuIVlxWRhGo5oA
 FXTmHOx3VIfbHea6OamFSxtTIElPB0s6b/ix3TDHDfouzKWnP8GvcYOKWmDtKt3MTPxt
 tCAA==
X-Gm-Message-State: AOJu0YzAH1TMu/1G1V5a26s2SRAbZd62Yh2erA9JxTy7zM1y7E8s8KVX
 PmrjXAq9MQ+uB2THb2j/3M/IwU0MOkowOloNeWSyEDXnOR5S5uVI/waoPeSP9GS/DHG+V+zKgn+
 AyCrJee+Xvpk+Dt73qn8Gw2HCN8w=
X-Google-Smtp-Source: AGHT+IHTC404Zz93M6s87nZKteFQgiW6EihNodIEh02raZvonkU6Ph7RBQAkzrXPFwXLjrlURc9MEmhGyJ6Uz8PaaSI=
X-Received: by 2002:a05:6512:3ba0:b0:539:e873:6d7 with SMTP id
 2adb3069b0e04-539e8730854mr1601052e87.1.1728851056880; Sun, 13 Oct 2024
 13:24:16 -0700 (PDT)
MIME-Version: 1.0
References: <20241006231142.126771-1-marex@denx.de>
In-Reply-To: <20241006231142.126771-1-marex@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 13 Oct 2024 17:24:05 -0300
Message-ID: <CAOMZO5AbLNdPpj4nCY85p48NTEW7Bo9Gw1Nex3bKaNzFwFgOkw@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: imx: Update MAINTAINERS file globs for i.MX6
 DHSOM
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Andreas Geisreiter <ageisreiter@dh-electronics.de>, 
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Fabio Estevam <festevam@denx.de>, 
 Tom Rini <trini@konsulko.com>, u-boot@dh-electronics.com
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

On Sun, Oct 6, 2024 at 8:12=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> Update the MAINTAINERS file glob to cover all of i.MX6 DHSOM related file=
s.
>
> Signed-off-by: Marek Vasut <marex@denx.de>

Applied both, thanks.
