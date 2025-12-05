Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39AB0D2F7D8
	for <u-boot@archiver.kernel.org>; Fri,  5 Dec 2025 10:43:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 728188419A;
	Fri,  5 Dec 2025 11:43:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hQltUUn1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBD34841A2; Fri,  5 Dec 2025 11:43:20 +0100 (CET)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0B62840FB
 for <u-boot@lists.denx.de>; Fri,  5 Dec 2025 11:43:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-597d712c0a7so1897483e87.0
 for <u-boot@lists.denx.de>; Fri, 05 Dec 2025 02:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764931398; x=1765536198; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aop5NeC0eP5PPJHcGEaWWBqQEphQVmdEpI+20J1+BuQ=;
 b=hQltUUn1dE6hwks+ycOUHW732iu+d+/HptYoLMg6pBKeKXVZxYkg1bkcQb9Vd+VZjj
 Rw2GWg+DWzEYMPRYjzf5L/F3oS6VNUKCWwBi4UZx8OpW1r0MLCDbx6YBPD/9qQEXbXvK
 spavOhJv7P3XPU8Q06ik+HnfGDbLb+irJIWo79QWXd7NiWGRACBD6TCWRoAoW1EBqjhq
 F54xFh055379QCKNnZYA1BkAidOMgdtUPsIJwORQh/U5kyxoEVoJ4R1GJ+RfuQdQBlbJ
 dV38LFaBbgpKCEKNL3f8K3USzk5yH2MOowadQ//AmnO+Q+GR1vmatRAGzANglVkfN8el
 QM9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764931398; x=1765536198;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aop5NeC0eP5PPJHcGEaWWBqQEphQVmdEpI+20J1+BuQ=;
 b=PghgcCP/KR6lTHPGfSUqTEOudK7m5MFODqRD37/b5l91zlC+HgkIN/2aBOpmf1I5Wq
 uinXPnyurpeuUqShGMzkTgH2M1ketkkcrBafsG9RghpO+rHISkXkYSYVFjtzPX/pqSHO
 pnHui50XIwKTvCyDYd9Ywv9YvowWXpLO3EJjL8QCcYu+0wZ8Lh0zKysJ606o9AUrXlxU
 GVvUjjhJhhNa48oi+nGK02qjY1LyaLDhIwSqYyS+KNXAH5lOHvtABv+NeoiowI2BkYYv
 bHx2RqA/Djvh31VBe/6kcl5kewWF+m0zRC8sOuwfbtAmzb2htP0uWOE+r4PTh0mR7qur
 JSYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXl/aaH4zlvRRNWNK0ew9AT3s2oBOhVKEardu9X81VjkkEnE7TwG+rDrbWszq/FLgVTXLWqUH8=@lists.denx.de
X-Gm-Message-State: AOJu0YxC1zPRcuPKf0+taKeFZLzMDDmdNp3V13il84P1FPgVHBtSU8+j
 OV7sRUSu+iY+r5zrsfeOofVBgUvdxSLq+ics+dvDV72EU8m7dPxSGSKqlIapmAyeU3+PE0sj/jQ
 blO1/y/brVXrLdC3owJuulqZxzbpDxLo=
X-Gm-Gg: ASbGncve7nnhwvLQOXLaANr+wwQiyCyw9pVJsyORuqyiKH2RqYUok9WFndQ8zKZj+Vp
 9huIMQ6jKpOde4jZFBungDEqovwKOoBB880nYhiw0p2jLt9/kJD0nJCtsZKbQsXo+ySSvNw8gqs
 SokKW5Y123Sz7KlVgmRN9FagaQhgvrx3AXyDKIsuU80qAk0ZjszO/JaaudfSfUzkhKaJR0ayt+U
 Gb/dqDMTa1JuQEnzH9ecHRzywv/V9FmJTkpxTY51GPgQjNbSSwuqOdYTgTOmSJEewLjjveMFXq4
 03YScZWdf7bkv0nFxzhGRKadeA8=
X-Google-Smtp-Source: AGHT+IGFupYDw8StKiYP0uxp8aWeQpIQ3ZKKYtOpee+hlLmMRYOyE+4O28qFUZeM7Wm0TXjVeBOBTAJEtbWt5/ayWAs=
X-Received: by 2002:a05:6512:3192:b0:595:8fee:fd8c with SMTP id
 2adb3069b0e04-597d3f0176amr4093932e87.8.1764931397930; Fri, 05 Dec 2025
 02:43:17 -0800 (PST)
MIME-Version: 1.0
References: <20251202-imx91_frdm-v2-0-992b8aa99375@nxp.com>
 <20251202-imx91_frdm-v2-2-992b8aa99375@nxp.com>
 <CAOMZO5Bu6735Rb=CfwBMeiJdStqx6ATZVQU9=-EngzkK2qhVng@mail.gmail.com>
 <93024512-1ab0-4fdd-aed0-f52849528c21@oss.nxp.com>
 <CAOMZO5B+NtDy1WOgOF71F2OzrpNzbDeUctvOKk5eK55H9Z4f6g@mail.gmail.com>
 <8eb15a35-bc1c-46b8-8f49-a2f37d2638d6@oss.nxp.com>
In-Reply-To: <8eb15a35-bc1c-46b8-8f49-a2f37d2638d6@oss.nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 5 Dec 2025 07:43:06 -0300
X-Gm-Features: AWmQ_bk9raBQzZSrHskaKkuYfWMjZGIv5YPLhTz0tdhVumew2bU5NFf6mFL4cAg
Message-ID: <CAOMZO5DzVrxeVWaWPmnqQaCDtdpZWmsWr2HpJGhnBLdsDkbYww@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH v2 2/2] imx: Support i.MX91 11x11 FRDM board
To: "Joseph Guo (OSS)" <qijian.guo@oss.nxp.com>
Cc: haibo.chen@nxp.com, Joseph Guo <qijian.guo@nxp.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Ye Li <ye.li@nxp.com>, 
 Alice Guo <alice.guo@nxp.com>, Adam Ford <aford173@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Simon Glass <sjg@chromium.org>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
 Francesco Valla <francesco@valla.it>, 
 Jacky Bai <ping.bai@nxp.com>, Justin Jiang <justin.jiang@nxp.com>
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

Hi Joseph,

On Fri, Dec 5, 2025 at 12:12=E2=80=AFAM Joseph Guo (OSS) <qijian.guo@oss.nx=
p.com> wrote:

> I understand your requirement. But as I said, the IO voltage switch only
> happen on u-boot stage, so it is kind of u-boot specific requirement.
> So you mean we need to add this delay control into kernel driver, and
> add this property into kernel dts even kernel stage didn't need to
> control it?

What happens if U-Boot boots from a medium other than the SD card
(eMMC, USB download mode, SPI, etc.) and mounts the rootfs from the SD
card?

Will it fail to mount the rootfs mount due to the lack of this custom
SD card property?

This mechanism is not fully understood, I'm afraid.

Why is it used only on some imx93 boards and imx8mm-evk?

I'm trying to avoid perpetuating this hack.

> Since we don't have this issue on FRDM-IMX91. How about I remove this
> property on this commit first. And we can have further discussion on how
> to resolve this property.

That sounds great to me.
