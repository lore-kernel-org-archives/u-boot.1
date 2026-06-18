Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF0F6CD98F2
	for <u-boot@archiver.kernel.org>; Thu, 18 Jun 2026 15:13:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 682AD8499C;
	Thu, 18 Jun 2026 17:13:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cMA7M36j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BEFD849AE; Thu, 18 Jun 2026 17:13:07 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A95AC847C3
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 17:13:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-6870ad8072eso69793a12.0
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 08:13:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781795584; cv=none;
 d=google.com; s=arc-20240605;
 b=UVBYmCobV0kKo5khLesh8r2DcKjIzCatp2jE2xwBgfkEHfSIQsC/ocdmKBYdAbZLWT
 ZX8WFrwZZPLjKtSGueFhJUpQ2gPQmC10Q5iHhR8yse01ySy4J8H4rgOR+LdLXgEpK3GR
 Ri3CGk+WlUZXY+/r3dJehHGFFrBui/h/6Uuoqp8TQXWVWki0ZLiFLJh7LxUQ1/ZHaBFE
 aRUvJjiX7uByo3tIYmzjPgkzdEkLedwR4po31C0vifBXGMaagvPjQJTTi6P/C1h22xXr
 XEzJGASEeNPHFHBBAKj1Po8eduZYYJJj9N/iGVSRHvV8oAh/XfV0PbtP4Bkc5MkvBlAG
 IXMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=EtnNhmDR1QOm0jOAMCPdURitg2T0nlqC53yz9s/gYmo=;
 fh=VbcbHNWEtkMfc6LdZPwyljz3n5rXCa7uQDYXWjQsMbg=;
 b=I8DklgAECm9t/xi0yFFCcKGASchcgGMPAzCV0Au1LMDnb9JEwTfhXGcymPdlGGdUoo
 8uzTvsWUrl4ok4HkUWIz5nKOshIxOgZaHPXDAV3MOLFgxZMrbf9DFaUcykb7OjF7Cam2
 vFIWB4lXLFl/7OPuQYaR4SxJEiCtHRFNJaKjAZo0uaiK4vIA8UFecxuatpjK0+LUpWsD
 Nb7dZ1jQpKKWw0ycZNTkEFPyraAMqZrTnktUnGHZzZo5crlm7VQyWza8P6FeTejm1/5F
 icTHvSDJAXV+23qKoCZzs/0blDsid+e/TNblk028mJ//oS8vN+FjQk0z2HX71QXyfXdB
 Xc6Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1781795584; x=1782400384; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EtnNhmDR1QOm0jOAMCPdURitg2T0nlqC53yz9s/gYmo=;
 b=cMA7M36jIUV/Rh6FaGcxHRTNJvZA0o9XOywucAVKhs7ePRoz5/8D9nRtZY33IQfj20
 v0nimi/rQRhdR9yfCo5IUewQGR7xJv9m7tyiW1HOLjSu6jRKeMI00S6fWgvaXeFKGnZF
 PkoHOrGYZQWjFLHDBd0f+sJgpRCjINQ2stncY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781795584; x=1782400384;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EtnNhmDR1QOm0jOAMCPdURitg2T0nlqC53yz9s/gYmo=;
 b=VtLoHW6U3SP5cDCCsSiWY06hwQRg3Mhzk1Jj0DpENdif3gBIzTDZuW41NF1vhHRD0d
 sdSfJMtHA2VkZMyBX+Hq0tIqrbX+dKYllR43dXXr+20mW23k75gO2J4IX7lUNclr6DvD
 GdmwVtQReJ8fdCGPyQeCweW5IRoUwdPKEs1U6lEzIDRCidfokH1VmkDIKQ+7cfnBqzUC
 3YTPJz4NbT1rcS1SuPXE3xdSlqomswFmFRB7tCmtcSy1ggGCWZQZ//rjS/rM5PZmSI1Z
 w4RH8Mqe+wtCZQEAA0uhze+JxMLDYJxZqzQJjI22Nk8D2r9clZd/mcFfvIuKlpD+hD1p
 7A+w==
X-Gm-Message-State: AOJu0YygqFjZzEaHy6/kBk/QwTcq37HSQqWYx/PMEivYlN4uoe2x3kNn
 uH/aloyexHmK3bkKPMBBQDKiptlFdKgDlmpoHHWXKF8pcY9+rqBOrnvmmSRNAlP6ybIDSKWd9vy
 2WYgJWduh1OWyvwLn20qCFd/yHpvQqiebbDjtfhOQ
X-Gm-Gg: AfdE7cnA/t/CPNlfA1OxGkzcVbmW/YqbRUBbOFZcMAx9xBqLTyUpPb/F5Y8ayeAg480
 o4busMfaTfSHyGVDdggoR4rX9F+FAnqroHkCLbAfs8rU9J8geWYUsiSZqEYzaCqF9OyJw5GbiHT
 KJ9UnCAyIOtr1+Qxy0SKeNWeHzuYJx70eExRv++E6t/t3ssfUuaT8hvRnwhs6dmyUX8q9V2J6t+
 ZwwHbiGGYAlUqhgcuQvee6nvS+mOXgwq6XOKxhKzC83otqprX2XycCIrlEuf0eLskXTi7evtg==
X-Received: by 2002:a05:6402:28cb:b0:68f:cd4c:7297 with SMTP id
 4fb4d7f45d1cf-695baa10f17mr2075502a12.14.1781795584186; Thu, 18 Jun 2026
 08:13:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260523085455.750591-1-sjg@chromium.org>
 <87ik7tzcvs.fsf@kernel.org>
In-Reply-To: <87ik7tzcvs.fsf@kernel.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 18 Jun 2026 16:12:50 +0100
X-Gm-Features: AVVi8CcL5GPFL5jfwdTq2FV_nRFVZ4exBtblhM0YwOvzdw_UNPfqVx5Y1imwoaw
Message-ID: <CAFLszTiW0Q0U4NVSpWvve3y0k4NT7_XrorQiE-T6arbiLoXnUQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] Move test/py image creation into separate modules
To: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jerome Forissier <jerome.forissier@arm.com>, 
 Kory Maincent <kory.maincent@bootlin.com>, Kuan-Wei Chiu <visitorckw@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Marek Vasut <marek.vasut@mailbox.org>, 
 Marek Vasut <marex@denx.de>, Martin Schwan <m.schwan@phytec.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Philip Molloy <philip.molloy@analog.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Raymond Mao <raymond.mao@riscstar.com>, Stefan Roese <stefan.roese@mailbox.org>,
 Tom Rini <trini@konsulko.com>, Yao Zi <me@ziyao.cc>
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

Hi Mattijs,

On Mon, 8 Jun 2026 at 09:53, Mattijs Korpershoek
<mkorpershoek@kernel.org> wrote:
>
> Hi Simon,
>
> Thank you for the series.
>
> On Sat, May 23, 2026 at 02:54, Simon Glass <sjg@chromium.org> wrote:
>
> > test_ut.py has accumulated a setup_*_image() helper for each image that
> > the bootflow tests want to boot. Each one is mostly shell script and
> > partition layout, so the file is large and the test logic is hidden
> > among image-creation details.
> >
> > Move each setup function to its own module under test/py/img/, with a
> > shared common.py for mkdir_cond(), copy_partition() and the
> > make_extlinux_disk() helper. Each patch moves one image at a time so
> > reviewers can see the relocation cleanly. The modules are named after
> > the bootmeth or feature they exercise rather than the distribution they
> > are modelled on.
> >
> > While here, also redirect the generated disk images to the
> > persistent-data directory instead of writing them under the source
> > tree. The sandbox mmc, scsi and usb-flash drivers now look there first.
> >
> > Further improvements are planned, such as using the context manager
> > when creating partitions.
>
> I've tested this on sandbox using:
>
> $ ./test/py/test.py --bd sandbox --build -k ut
> $ ./test/py/test.py --bd sandbox --build -k bootflow_android
>
> Tested-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

I appreciate you reviewing this - quite tedious work!

Regards,
Simon
