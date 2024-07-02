Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DD07C3064D
	for <u-boot@archiver.kernel.org>; Tue,  2 Jul 2024 13:00:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56A37886C3;
	Tue,  2 Jul 2024 15:00:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cjrcrZeZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 688F688081; Tue,  2 Jul 2024 09:00:20 +0200 (CEST)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 522CB874AC
 for <u-boot@lists.denx.de>; Tue,  2 Jul 2024 09:00:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=l.rubusch@gmail.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-65011d9bd75so3161857b3.2
 for <u-boot@lists.denx.de>; Tue, 02 Jul 2024 00:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719903617; x=1720508417; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1+3JPUlcqyLK+A5PVP8cnOPDk+FAJjOJLpNF8fOQMT0=;
 b=cjrcrZeZb3vVH2hxe0rgFBQqHZWLUrrzRsWfJA+lxS/gftCM/Z0BBIAXzQ46MYnp5e
 V4x627Cziv/sSDQQurgSrJQ2cZ4T+ye0D57hILClLobfbGr3LNln1v31vsinp/Dc2ufO
 4OPEztJ8Xt+9stTloBjygc6Y8aa3whmbFsHER9mS+vqeD9R3wN1lk9+tXk0EzFrJPOC9
 gtTEm+F+zSC4bso5Ml2Koe2E9rDNQrp/wrBx4LuTkR4cPS24DP7SWO2EcRTSxnKkAUPk
 8IMkRFC6c/l2rMftByRjuZYDL6PPmuQT8AQtA3s+GgCcgqx/9ftdDVkd3j0R02LutUMG
 XKZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719903617; x=1720508417;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1+3JPUlcqyLK+A5PVP8cnOPDk+FAJjOJLpNF8fOQMT0=;
 b=DNLtQIfTQqe91zY2zM57ddZyQSLp8Y4qWF08RuBtcauAObStX7CsDWeCy35IVFXhqW
 im7Fna/LRrVwVJ2Qf/CCPdrRjHNApTd8a+Xk7T6apF0Ps65pPTz3VEoLf33A6dE2q1lJ
 GdoQKLWlEkEppZJrTabdxiVn821fKFpT2N03lnGrXhcs25bxGNWm3OffFIfArBEp4Vh+
 mt3O7wzUEprdY6Mf2sCmyTAmsTqXc0Z99ZbdwHFzbGaBRWVVAM5z8aENLQ2NBqwUdnOH
 2UDttMMX2mST8prlah+8fs7BJ7jRI4mh5RGoel9PB7JrIQetqhEE6AxZ7hkHTrdXKgT/
 45rQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUaC68BszfLH9TerGdgp78oN99Wb6OtGUv+I1XtAysPLpOMNRiVtgIAKSMZFUVGuPLGNYMVumTm3UMtws/v7khU3Ftumg==
X-Gm-Message-State: AOJu0YzK/hU3RuibobToaYBu+D/TwfcPKUatlgq+tkH0otugPi1OPnum
 kqBQDoAaFgR3KnzeOzSK9ad/xGGR8lI+n7Wu6RcwX2cwVMcLmcs8BivgC+M9QoygK1+dXUV4pxK
 3T3Lc4iGjP/zFQ65C98JPnHLJD8o=
X-Google-Smtp-Source: AGHT+IEFZAYR0t2F4x3LHsS77VUVo7DVavxGA+JvcvD4wW1ilDDPVeaVjmjDe1zhy5PiPm1A1mUC9fF5M104FOYpTqo=
X-Received: by 2002:a81:b04d:0:b0:618:ce10:2fcd with SMTP id
 00721157ae682-64c71cd7bb7mr86104107b3.26.1719903617177; Tue, 02 Jul 2024
 00:00:17 -0700 (PDT)
MIME-Version: 1.0
References: <20240701215927.285961-1-l.rubusch@gmail.com>
 <bc923c6b-e2d9-4a12-be6f-7e5d404b1665@denx.de>
In-Reply-To: <bc923c6b-e2d9-4a12-be6f-7e5d404b1665@denx.de>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Tue, 2 Jul 2024 08:59:41 +0200
Message-ID: <CAFXKEHZML4WUg+ZftybRvEcCJ0i4t7K2h9kQT5dUEmySpdh8fg@mail.gmail.com>
Subject: Re: [PATCH] ARM: socfpga: fix broken function call for arria10
To: Marek Vasut <marex@denx.de>
Cc: simon.k.r.goldschmidt@gmail.com, tien.fong.chee@intel.com, 
 trini@konsulko.com, sjg@chromium.org, ilias.apalodimas@linaro.org, 
 xypron.glpk@gmx.de, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 02 Jul 2024 15:00:15 +0200
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

Hi U-boot-teers!

(...)

> Reviewed-by: Marek Vasut <marex@denx.de>
>
> Could you by any chance also send a patch to enable this QSPI NOR
> support on one of the A10 targets, so the CI would compile this code and
> this code wouldn't bitrot again ?
>
> Thanks

I've sent you now a series of one patch showing the error for me. And
another one with the above fix. NB: I did not apply reviewed-by tags,
so far.
Also note, it is not supposed to turn on the (bloody) cadence QSPI
flash permanently. We have this piece and having turned on, it can
lead into situations due to ...interesting hardware behavior.

Best,
L
