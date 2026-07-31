Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F9B7C55173
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 19:00:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 30F9C80DE9;
	Fri, 31 Jul 2026 19:00:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rUiVZ8vBG3R1; Fri, 31 Jul 2026 18:59:58 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E9F838096C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785524398;
	bh=ff+C2dUS6mJBkwcgwRjRCr0qEsBbDWcGq0DE8nVuz74=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BL2O1YJ5KVWSd+Wlun/50MZXk0XabHnysItFUjxt2q8NUjARxrfqx5Td+0iHb9F+n
	 sXcyMk+ZuNNuKD6QRYAbz3YBcY3tDhbMFRwHGWUkvtyEel5z9pa0bET37Mq4qQchMj
	 05BR7dQxeBwubaOEXu82WdnfVBPyOrUdxSPiJM/oVpIsN2vvdl16Ffc/+V86bwZ886
	 GV5C/myKw8tI3U70F8fStZTcE/XBg08mnKkF3dSSqBNIOdfiAX2iBmW3QXLBCeIpAd
	 5gcuTje1285iA3XVHwtDD7VS9H11PRmiIiNCZDW2YosW0LxtCMFGkHK8t23fgQPptG
	 mLuNg4MGl2EkQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E9F838096C;
	Fri, 31 Jul 2026 18:59:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id E235E36E
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 18:57:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D3CFD400C5
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 18:57:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id e_-jbFtD9J0T for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 18:57:52 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62a; helo=mail-ej1-x62a.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 9DC6D4007F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9DC6D4007F
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9DC6D4007F
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 18:57:51 +0000 (UTC)
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-c1c26d7e951so200822466b.0
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 11:57:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785524269; cv=none;
 d=google.com; s=arc-20260327;
 b=XnKqPgIrfN33zDWp/0/8kLAOQqyuN63okgYR0eOSofr+wQ4c9FU7a2sBkogyEXLJ94
 VF5/S8I4pSW6785PdRe9lhESL8ToHftTNCQHH8ZDdZ0XXNe0hRQAt72eeZUuvdrnFSSi
 365y8jyHDWZJtzynkmNL+UYVUyGvjOf80bZBcVrkb6pyiRi7EM+0x7GUonamnQVmDhLd
 UrwXyLlXAUrp9x8oBF+Sm1yZfGKgWXG6xbHUcD653WvUuiyZO98eYvIq/k5hh07jqncd
 VtbHTG6//P5fu7fqpcv/68gKsFsFzrwARqYP4lKsqdjtKUTQPT0GZ6afX1WUiRLtmdYr
 THNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ff+C2dUS6mJBkwcgwRjRCr0qEsBbDWcGq0DE8nVuz74=;
 fh=11Ocal5QlSLP51uxYgbR5Rl5YMgikbHXO6XNUh2omrA=;
 b=Vl3Q9LUUoo+GNtbVko76NBxTSVvIlvaErrcdgV6sKWcT3GMPHIjYSPvhJGH8VeIEFw
 V4avuU3xdkfnygWs0707zjyrtPQMdo+3iq9xFEWQgmJgroM457A9/OZ4ZHM5TJ03XHtf
 f3akiu+aSwC7mJxoMDi+bciaWD+w0fYOkXC/f3+9v+kFQlz4JqQJgXdjP3UK6i2Q1PvW
 3Hz6Xe2bx5EHra6PlnLqkPNvEzTw1ZeA/aEvVHOj4k1qoEtWhim0oQzXZ/ZEUPTG+BwQ
 HqpFlY9fdA7u+6ndUqWEM8FmV8p6iETn5uGLTkWHxzk5PebgYHkRfehmhfHD0TNwTSQR
 AWAQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785524269; x=1786129069;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ff+C2dUS6mJBkwcgwRjRCr0qEsBbDWcGq0DE8nVuz74=;
 b=EGzS59ZN2buDgQUX68OvlWmpc/4FQh4zP5n91LrlcKCgql1k9yBRJ93nv6VU0GTvIx
 SJFK8OIxr1aGFJuoZ2IX2ZxiC+XDao0Q/Fet8v+RJBK7y190E5/9Wu4YKNO+UOsJ7oom
 aK9vKIyRJCeYBrSb9OmhNXQIZBn6HshhylKxZDikkNdfxKhMwIHc8nJMc16wsqgfddH/
 cBIQGONXW1b67/Oz5w+GsTCNpDtIYe5Aj5MoQmWXiRCtnmUbEFOpp0DCZC3MuEB3acMY
 6TTlzF3V/ngHEGEUfF37oe/CHvWGQOyjX1mSXSz8ym1/W4QZtd3bagM0npppA1oskv4C
 UUcQ==
X-Gm-Message-State: AOJu0YzB/BjwwqeVu6HZRq5oXqZQaOhsdlg1rVHVX/v0N+9xNyA4inDQ
 pCX+vSKxAyAwhyouSOW4URbrzRWK4Eqn+8T+KLhUXRIu9eN//S1tokpHeMNDLO5UG0NOfub4Nla
 +jj+iLm9cW7+jHWn1cjl1CnruGFHiFkVHBbcHdCq8/A==
X-Gm-Gg: AR+sD10DFXX/jTS3ubqXmSW6gTw5SJQWIzfD6XbVYjf8/Z+54TdtyS0XNKUvxUT+wbQ
 gIZHp83jzbxU1tOm9bBG0NalIZ7UxIKxIOgviHRSnrzqBPPY73h9Chn/lLnjhqJDSNPHvM7YbsC
 VKI5sItVCL5a30D5Ztry8vJlNOoQT+dp7vptM6sxgnT5O4slQbAwaFEtDH+TD2n16ZRG1s06toI
 EFZQqKvqd97j3xjmVCcitZTZdsHBlb1ez7HF73FgX/C3Yv/M19lCwtSCRqfkDi5Rcgpc7RvZp2C
 NnSvmv7lVSqoWPTdXivvGjy1hHXCHIt+mWtcYKzRh3ajNvLHtO5Qxjl+imIvuBcL3vxSN3J7uHv
 7
X-Received: by 2002:a17:907:9289:b0:c19:6659:fdb2 with SMTP id
 a640c23a62f3a-c1fe813c229mr54319466b.36.1785524269373; Fri, 31 Jul 2026
 11:57:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260731-atf-falcon-v2-0-acb97c172993@flipper.net>
 <20260731-atf-falcon-v2-2-acb97c172993@flipper.net>
 <20260731184730.GO1773261@bill-the-cat>
In-Reply-To: <20260731184730.GO1773261@bill-the-cat>
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 31 Jul 2026 22:57:39 +0400
X-Gm-Features: AUfX_mySTc8rx3ciQpsq-xtk4Q6-DAXDHLlxMnTqGHiHS1xf8S-4Lay4VwqIkH0
Message-ID: <CAKTNdwH=DnE0LgPth3XFPbAvHR4ErnWbSS0yt5SJnHhpE4h8_A@mail.gmail.com>
Subject: Re: [PATCH v2 02/10] spl: atf: support Linux as BL33 with TFA
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Peng Fan <peng.fan@nxp.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Andre Przywara <andre.przywara@arm.com>, Andrew Davis <afd@ti.com>, 
 Hrushikesh Salunke <h-salunke@ti.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Ronald Wahl <ronald.wahl@legrand.com>,
 Richard Genoud <richard.genoud@bootlin.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Johan Jonker <jbx6244@gmail.com>, Daniel Golle <daniel@makrotopia.org>,
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Tony Dinh <mibodhi@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, Quentin Schulz <u-boot@0leil.net>, 
 =?UTF-8?Q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 31 Jul 2026 18:59:56 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1785524269; x=1786129069;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ff+C2dUS6mJBkwcgwRjRCr0qEsBbDWcGq0DE8nVuz74=;
 b=SSN/XACVdjguphjA+NFlimTbXMaQ/Eg6ulQw/hj9cV939JslW63skPuQ18J6JJXVK2
 LJ4RtH+SxuGavrJBzn426Rs+F0xyZFXagrB9pObvLAv5ML4qEfZQ2TvhofkiPzRSRee8
 a/oaP94FsIB2Tu57nyoGDOwkrEQSuowVkzouH30GhwDUbPd/a6lwp3Ly1+8YWtA/Kxp2
 Dk3ynUiPAd11QOOeH8CkjCk/oWdwI9mJDXDVPvXD8j+cDbk3Ezjs+b0t3lSJkov5Q+3A
 3n2SNqXuRSVEKqBKsQitKwP3gLFkzb2xI/SR/Gtyk98zfSE9dflHZ6a4Yfr1y/DZJ+nb
 PyBw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=SSN/XACV
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Fri, Jul 31, 2026 at 10:47=E2=80=AFPM Tom Rini <trini@konsulko.com> wrot=
e:
>
> On Fri, Jul 31, 2026 at 09:10:46PM +0400, Alexey Charkov wrote:
> > Modern SoCs such as Rockchip RK3576 need TFA to be running to provide
> > firmware services to the OS.
> >
> > Enable the TFA boot flow to allow using Linux as BL33 (including its
> > calling convention) to facilitate Falcon mode boot on such SoCs.
> >
> > Signed-off-by: Alexey Charkov <alchark@flipper.net>
> > ---
> >  common/spl/Kconfig   | 22 ++++++++++++++++++++--
> >  common/spl/spl_atf.c | 49 +++++++++++++++++++++++++++++++++-----------=
-----
> >  2 files changed, 53 insertions(+), 18 deletions(-)
> >
> > diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> > index 0618f42c9410..7c639ed8f763 100644
> > --- a/common/spl/Kconfig
> > +++ b/common/spl/Kconfig
> > @@ -1230,22 +1230,40 @@ config SPL_BOOTZ
> >       help
> >         Boot a linux zimage from memory in falcon boot.
> >
> > +       This provides an entry path which is unused when the OS is ente=
red
> > +       through TF-A, since SPL then only places the kernel in memory a=
nd
> > +       BL31 is what enters it. It remains selectable: SPL can still en=
ter
> > +       a kernel itself on such a platform, dropping to EL2 without TF-=
A
> > +       resident, just without any firmware services being available to=
 the
> > +       OS afterwards.
> > +
> >  config SPL_BOOTI
> >       bool "Allow booting an Image style Linux kernel from SPL"
> >       depends on SPL_OS_BOOT && !SPL_OS_BOOT_SECURE
> > -     default y if ARM64 || RISCV
> > +     default y if (ARM64 || RISCV) && !SPL_ATF
> >       select SPL_LIB_BOOTI
> >       help
> >         Boot an uncompressed linux kernel image from memory in falcon b=
oot.
> >
> > +       This provides an entry path which is unused when the OS is ente=
red
> > +       through TF-A, since SPL then only places the kernel in memory a=
nd
> > +       BL31 is what enters it, so it does not default to y in that cas=
e. It
> > +       remains selectable: SPL can still enter a kernel itself on such=
 a
> > +       platform, dropping to EL2 without TF-A resident, just without a=
ny
> > +       firmware services being available to the OS afterwards.
> > +
> >  config SPL_OS_BOOT_ARGS
> >       bool "Allow SPL to load args for kernel in falcon mode"
> >       depends on (SPL_OS_BOOT || SPL_LOAD_FIT_OPENSBI_OS_BOOT) && !SPL_=
OS_BOOT_SECURE
> > -     default y if !SPL_OS_BOOT_SECURE
> > +     default y if !SPL_OS_BOOT_SECURE && !SPL_ATF
> >       help
> >         This option enables the SPL to load an args file (usually the F=
DT)
> >         alongside the kernel image in falcon boot mode.
> >
> > +       This is not needed when the OS is entered through TF-A, since t=
he
> > +       device tree is then taken from the same FIT as the kernel, whic=
h is
> > +       why it does not default to y in that case.
> > +
> >  config SPL_PAYLOAD_ARGS_ADDR
> >       hex "Address in memory to load 'args' file for Falcon Mode to"
> >       depends on SPL_OS_BOOT_ARGS
>
> Expanding on the help text is good. I'm not immediately sure on changing
> the default statements however. Maybe the changes are fine but just need
> a bit of a rewording to be a tiny bit more concise, the "which is why it
> does not default to y in that case" can probably be dropped and you just
> add text explaining when it's not appropriate to enable.

Makes sense, thank you, will distill in v3.

The change in defaults for SPL_OS_BOOT_ARGS also helps avoid the
prompt for SPL_PAYLOAD_ARGS_ADDR when selecting Falcon mode with ATF.
Otherwise it breaks non-interactive builds by endlessly asking for a
value (it has no default of its own, and there isn't any meaningful
arch-independent default to consider), even though that value is never
used in this configuration.

SPL_BOOTI and SPL_BOOTZ don't hurt, but are simply not useful here, so
I thought excluding them from defaults here would make more sense than
disabling them in every defconfig which wants to enable Falcon with
ATF.

Best regards,
Alexey
