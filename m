Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27BB4CCD1AB
	for <u-boot@archiver.kernel.org>; Tue, 21 Oct 2025 19:35:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A5B3802C1;
	Tue, 21 Oct 2025 21:35:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="k7NNZP4N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B3F1807C0; Tue, 21 Oct 2025 20:42:10 +0200 (CEST)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DEB1A80107
 for <u-boot@lists.denx.de>; Tue, 21 Oct 2025 20:42:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-586883eb9fbso7347843e87.1
 for <u-boot@lists.denx.de>; Tue, 21 Oct 2025 11:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761072127; x=1761676927; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vE6+oM9byJqUf7XVSpGokmVudhS4zTua1VpX3gX+Vgc=;
 b=k7NNZP4N3vRgzRKRbl/7uLI4hjP0rAd4XPwWvwZEP8GdXFINJ0gD/qFmSollYfeCXp
 0Z39Ijwk21ttGXTKssyKAq6AcLfg8+f90xsLHP11D0+3y0ROSKp56OoFT0MFhWi/ezu7
 aVUUHM5tuXuO6VqCG4eteyHwYRpcQoCjxlFWxXXlddJ6Bjf74+x2U7aLO5D9bOJ2V8J6
 K8q6fcfAwtFJJHWe5h6Da0nIMMARkewswHbnAwU2ezD3x1nhVMxlXAw4jtHa7NvG9UN+
 RtrKC98T2C6EjlT3gvBnsZ5f+QQglDUkgWpVoPAg+Y6gN3bdgHTO58HGXROxbMbxnmMd
 HF+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761072127; x=1761676927;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vE6+oM9byJqUf7XVSpGokmVudhS4zTua1VpX3gX+Vgc=;
 b=Hy6IEs4q7+kq9pVa/1kfc9dWUIUwNKxtzG0g4ompVY4egoASLTa31HEdf2wtZSg3bS
 fz9sNfLpvGIqoK2J+rmj/Nrh6z77F6/fDGrB6DDbEq4FFTbnNUZmUPp/h1oBNyfQUqxw
 04gt/UxRXJbApz5sgmIKTBe6ykiqezqh5Ikf0c+do6UmpESGWNSQtirKkk5NNBnzYxUl
 Bld7Wak2OjVn16Wbfk6fStc5rs1Pq4QbYKLYgDedUQGL01g9JEjA4N9vfMQ10CSns9Sa
 DlmqSoo9Db9O5UOYVYpa8z+9IWHhlYJkzsh8cvhXuIa7lSY9Syte8Hu5Ix83eex8P94v
 P+Tw==
X-Gm-Message-State: AOJu0Yz591uSOq7LYAUY2Kt7Z9cCcg/JFv2WhHQoKqryl5IoVbuypFSv
 T1jc8AzQtx025FKNdTaZB9tHK2jeOTBTamCYh0iemhLGRpPpHlrdUbpjxFexH4wBABcr0eE0AXw
 vcmEHZOywBVFbsK4NyUoMbjZa77/ZIpI=
X-Gm-Gg: ASbGncv/bHenftbe92aKJVsZ2005UOepTdp0X4AfnhS2HI7UzpEGhIJkscE58Yk516A
 NBSR12kTqc/rTEjVikn3cShRgCCqUwvfK4Zd6iMozK8V190YzOWPpXnnyCuBBWrLayBCc4yd64e
 kzHB5eSGDzmIznYX8GQFXjErCIaAYlt0xnwtiRfXEiEqWrskWZQwPoYnwqgjm0fx/ALTVjQy8Rx
 cUtgW+li8QLOp8wqPtgnq61xwhqvZMJ/vO+KrNiTn/NfWicHJ6HFpFDYebJ8aBckm0dc/Fs/rhZ
 u/NbCkvdfV0R3dt5DFoIeVcyuA==
X-Google-Smtp-Source: AGHT+IGcNnP3DDWOKvRrPnpAdv15DH6urOjFVr0bF9cI4O7sBo7EB/imeOlU2Ay39ITsmAbwdQXVHo5/yww5Bq7Q7Kc=
X-Received: by 2002:a05:6512:2251:b0:57d:ffa4:56ff with SMTP id
 2adb3069b0e04-591d84f0abamr5270301e87.22.1761072126789; Tue, 21 Oct 2025
 11:42:06 -0700 (PDT)
MIME-Version: 1.0
References: <20251013-imx943usb-v1-0-293e79d4bc12@nxp.com>
In-Reply-To: <20251013-imx943usb-v1-0-293e79d4bc12@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 21 Oct 2025 15:41:54 -0300
X-Gm-Features: AS18NWDfxY6VadhqNCh6XaZWuoTXL4bdWfNi61BqJmSsm3qG2z8PbUMQSNVeEXc
Message-ID: <CAOMZO5CQvaVqhrOUJ9rTXRoR50pOSVWGXWBzj8Uc3vPM9xRA0Q@mail.gmail.com>
Subject: Re: [PATCH v3 00/10] Enable USB and ENETC on i.MX943 EVK
To: alice.guo@oss.nxp.com
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Marek Vasut <marek.vasut@mailbox.org>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, Alice Guo <alice.guo@nxp.com>,
 Stefano Babic <sbabic@nabladev.com>, Peng Fan <peng.fan@nxp.com>,
 Ye Li <ye.li@nxp.com>, 
 Jacky Bai <ping.bai@nxp.com>, Jindong Yue <jindong.yue@nxp.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Frank Li <Frank.Li@nxp.com>, 
 Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>,
 Minkyu Kang <mk7.kang@samsung.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>,
 Minda Chen <minda.chen@starfivetech.com>, 
 Tim Harvey <tharvey@gateworks.com>, Paul Barker <paul.barker.ct@bp.renesas.com>,
 Roger Quadros <rogerq@kernel.org>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Hanyuan Zhao <hanyuan-z@qq.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 21 Oct 2025 21:35:28 +0200
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

Hi Alice,

On Mon, Oct 13, 2025 at 3:59=E2=80=AFAM <alice.guo@oss.nxp.com> wrote:
>
> Changes for v1:
>  - Adding USB2 and USB3 device tree nodes with required PHY and
>    regulator support.
>  - Enabling ENETC1 and ENETC2.
>  - Updating Kconfig and DTSI files to support these interfaces.
>
> Changes for v2:
>  - Resend patch series with updated To list.
>
> Changes for v3:
>  - Remove logically dead code in imx94_link_config().

This series does not pass CI:

https://source.denx.de/u-boot/custodians/u-boot-imx/-/jobs/1270141

As I've mentioned multiple times, please run the series through CI on
your side first.

This is becoming a pattern with the NXP folks' submissions, and this
needs to improve.
