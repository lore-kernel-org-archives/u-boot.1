Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EF2EC2BD09
	for <u-boot@archiver.kernel.org>; Sat,  6 Jul 2024 20:50:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12737881AD;
	Sat,  6 Jul 2024 22:50:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="j3Pf/zyM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6EDD88850A; Sat,  6 Jul 2024 22:50:33 +0200 (CEST)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C1B3881AD
 for <u-boot@lists.denx.de>; Sat,  6 Jul 2024 22:50:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-52e9901f858so298536e87.1
 for <u-boot@lists.denx.de>; Sat, 06 Jul 2024 13:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720299031; x=1720903831; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6YWfWDccSkmjLbiZ+bUp4Hq1iA8tV3ea3bolPPT6pKs=;
 b=j3Pf/zyMyIuwnUPZzJSQIrFhuCw5rbA9vGfqX1kOwTX41+lSjuZoswNoc9PktGaMMX
 ULqQ9pStIOjFjTGVfbUsxngkHFvB8aEyYxJC6agUhI8aRSQG3UsaG8WLPtU1UGP0ZuO/
 UL5M9a/ih+nAuEiWOjtSYmAhrugKUS3TjBV+a7kXoXGj0ntzkFdheCreu8SdEqCPFi46
 yZ4PzbqtDKaQA4lR9DiIRml3nDd4WyZJVnQEgUPMMxexHFJ2ThlKwxUjXYfjq6ZuXi/N
 YBRb3DKzk/1WRlPlECXhEeDGUaNZLK4P3madlv6unuouk0R1jSYqchRDyGnlUb4x32Sx
 l4kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720299031; x=1720903831;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6YWfWDccSkmjLbiZ+bUp4Hq1iA8tV3ea3bolPPT6pKs=;
 b=vyH8XZ3/a+sCfi6pU0kXfqw7pNF+Y17mkR8ajo9JqwrU48TUN53w9H45JbgSa9Aaio
 Cuwt3/o+WYllfV/yOy32oHBai4STO4ro1ppADKHtLhPn3LvOBULWaKFCtGIs1ZZR2FxC
 Raw8sTf61DpDyw4Dei4sMOpzwCnLWKd61bnFqh1HCIf3PmD4EVcFoT47mBpguOV7gLK3
 R83xJ4vezEUNgNg/D0ZFDxm5dEFhyjEpZF19LJJDOg1T/fVqFyv0Cd09IAPGucBWxdU7
 IrX1IBJjBEYFmT8CAg7LZD0TVcYfgVTxG3QjagfI40YBI5WCFn1ZxlcP4MYA/TKQhnfG
 D0/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTN1mKLn+X/RN2lOQtDZ7qySKQDuaM3YDs1B++QwNX3X66xNVgII3OPKqB9KWDsYZjsdxRsFSDeBjTLQ8UOI9i/XxR7g==
X-Gm-Message-State: AOJu0Yw0qiHIyvKKbynV70mLXLc0cF0rZYwzRwjZdr9DBIFlvS/7P8Nb
 J4cQNqtURX5JWHmw6FJd5f2xA3DAoGbxDs5CRtum4tJBPCPycqoC/FFpc5PWUdFirz4z56PBPXB
 AAn69NTyAE7pR3ZwNhQmCiMmzZUU=
X-Google-Smtp-Source: AGHT+IEjiOA6x7usSx+k5UXBFzrAml8pWWcz56f1gXLFBG8XqjH6L4Eax5hbk5QZGXlieQd5J9YAE5b63Wbsigq5AJg=
X-Received: by 2002:a19:5218:0:b0:52e:9daa:25f4 with SMTP id
 2adb3069b0e04-52ea0641d7cmr4822531e87.2.1720299030675; Sat, 06 Jul 2024
 13:50:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240705071952.12245-1-michael@amarulasolutions.com>
In-Reply-To: <20240705071952.12245-1-michael@amarulasolutions.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 6 Jul 2024 17:50:19 -0300
Message-ID: <CAOMZO5C4xKRCwgov9avRss0hzyYrTYhMArBcksAET9VY_3+fOA@mail.gmail.com>
Subject: Re: [PATCH V2 0/2] Support imx8m composite mux
To: Michael Trimarchi <michael@amarulasolutions.com>
Cc: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>, 
 linux-amarula@amarulasolutions.com, u-boot@lists.denx.de, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>
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

On Fri, Jul 5, 2024 at 4:30=E2=80=AFAM Michael Trimarchi
<michael@amarulasolutions.com> wrote:
>
> The mux ops for i.MX8M composite clk needs to be specialized.
> In order to reduce the code duplication we need to make public some
> interface and write a specific function in the mux ops. Those patches
> implement the behavior.
>
> Addressed comment in V1
>
> Michael Trimarchi (2):
>   clk: clk-mux: Make public the clk_fetch_parent_index
>   clk: imx: add mux ops for i.MX8M composite clk

Applied both, thanks.
