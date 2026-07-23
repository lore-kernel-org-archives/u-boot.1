Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2F2CC531F8
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 23:48:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2E68D608D9;
	Thu, 23 Jul 2026 23:48:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YtmYIbt77dyM; Thu, 23 Jul 2026 23:48:18 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 611BA6072A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784850498;
	bh=H3/zo+r2sb5wTyBMmFmg1UyoUZfEoOxfpUpN0U+v/Ws=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wzbSJaQQXhnkdlU8FFRxv9Efj8ppz8rUi7UfU61ZHUMQrkMP+D90a5vj/z3LIWO50
	 RMbBEOlbT4l4x7cPgjDP3OmPTuCQXfldlX9d1Hmot4vTajOkA5NAAjhb3ylT6ltmCT
	 eybTnAoeDdXI1EKyn/5Q/dwuVxKjGF6WK4Urp3RctogX0okcuvww5Ltf70PXBrsUTh
	 dNZ/pZEdVm36SscCBuz6STPGAzg+5eySbBx+MuRP61eIL5F0P5TQ+uKDSgeYtvG/PN
	 o2IcRqJ3FPHhTCblJwTyQI/+poAmq3hIYyslS1dmHy0HgeeWldykx5/5nAFXTgoxba
	 kbs/Ekh6NuRyA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 611BA6072A;
	Thu, 23 Jul 2026 23:48:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id B52F4350
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 23:48:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A6AEB606A6
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 23:48:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Beb_i2asmIhG for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 23:48:15 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::12e; helo=mail-lf1-x12e.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org A8A0F60645
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A8A0F60645
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A8A0F60645
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 23:48:14 +0000 (UTC)
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-5aeb59d54b1so1222075e87.1
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 16:48:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784850492; cv=none;
 d=google.com; s=arc-20260327;
 b=IdGw3hCFJJa4ZUmHJpcpqDzidixQheDEPyPXc9zLmntiv4qIIh1Vn/R7BrocuBiHaC
 q61Y+QmkTYJ6bte0VPAcus4jIAuIN5XY84K5PQEOUs9CrDG3q/3aYuzo4cqQcu9iyCEQ
 CTo8zSFeytLNkmaQC3/De6b9omFTkIfrDceyVc//vbQmsAfcyDSVrk2DegNsgPqrm7Ff
 JLacO6x6PLnW2cwF8c66viJCJWZ95XeCswclKiOEShPRejFSUj2LGlJc0IaJv87wNDks
 IJ/ph6AsH78/wPpo70hZ/TfyImPl50Rru/ch8moqM+CAVR3ob2uWhgFkk3+Yh/DWV1gv
 D3NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=H3/zo+r2sb5wTyBMmFmg1UyoUZfEoOxfpUpN0U+v/Ws=;
 fh=RqBQv9bIgfT0O+GvqD5fbtRGEQYDBJY/TuxjR3k7Wng=;
 b=V9jpGbeV84lOnhIWu3YehjIUALcK9Qogds9Phw3f3CoocAapUKTeFvW/NT1uEmhd12
 KpAfhHtTVmZ1H/UjfixR4p7XeUtUDhazBZsi2rr16fXrmhaQlW2sXvsqrGOrAbbPovJS
 /PlL1aLGAwYGQ9BMpD/+YL1jaRBj38D9wayPS1XWL4qqz2PbWBtWqR8gFgpMUduKnpkv
 5ir+iDWMTt/iEjLT6xneDRoNY4/2JteO7prxpAoNP4lQNdcmwwLBsBwY3FmQFl1tMQ8J
 Hn/4K+G4RVhwA6t82qG9BsKthAEuwHrRoIfiWJKFnTHmfFNtKXyZwMP9ffehyBIZcZ/P
 P8/A==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784850492; x=1785455292;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=H3/zo+r2sb5wTyBMmFmg1UyoUZfEoOxfpUpN0U+v/Ws=;
 b=YvC4uwlV3RIyh/+TDJJwpBs+AVw5NpmGjyb6HUdwojNev4lGiPdM1+qX43wJTD0f90
 hFXMoqElsZq+VDtK9OVP5FjegXafi2iWo91qlpOUtUZBiJOFvQHGdJBXQajD173jLUyR
 LzcMQ3RR61UpM109IbIq4Tw9VRKedLiwIjmAIbG4KINnzMT1ed/j7DK6qgKLaJK1ADn8
 PzkQErI7CCofgeEUgfZav7Jh0VACM5hcEkhvvG3ri6883XmuBSAR2cxuXNAzvs2xhIDn
 zqjLmyQO4e+/E2k5fiYSHClQOrT1mZ+1r0RAtIiCvL8kAxephk+uW3ssrbyZhLS9F8yD
 Qkcg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoPSaT1mNCNcU+d/Na3S3tU+MD0IsZ4fBbtgEEbkCDQWe36SyHgMgD6wmhCXK0R1s0BhdwTge4=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yx0Ku4sgK7aKkZQO2H/wybM6Z6RmxNa8JimXWl8pt0kIoCgIF70
 aWmYTjWsqM+VBL+/kauCtSnzxYq0JWWgrMeQ+0VhwM+XZvs4M45DewGCeri0LonQVy0tdQsGyKC
 4WHohYguKKpXrkIfJQjVVnpABfVoOLhcYMAFb/c7jPg==
X-Gm-Gg: AR+sD137SPI0tuRV/ryGc+HIsVoTbTADoxeav9qDaEMBpZqZ5p4YbRuTqWacodqAerf
 0JWn0AxiNCNBE12ZIeyDdzAxG2QJ4GbwcOoXpwSp/dD84BEOyGpS3ubsP68HRClNUCLM+Z7P85B
 yONtCSosXMrHdeyA8fhUa+/bzBfingVFrMiFTe11bPULkgC23wQC/2UPsyNzfzHEQ0NE+a9El89
 HDcEip5ExQHdCGO8XRXUg7T5hnK0AwYZxv5qTKTEdw3qU7ifa0dzz5rU2oqMkqg/8qCyaapGzUb
 c4XkTOe3jrW0d6ivP5fRC9yPHsm38uKvprhM0jBsIW6vRfct2MGVk8xbaXkPizpixHshn+2A9co
 unSr8gaOZFydGahiX6aKyREFqSOXvxQ==
X-Received: by 2002:a05:6512:3410:b0:5b0:5b69:9135 with SMTP id
 2adb3069b0e04-5b2b2f915dbmr1026893e87.49.1784850491987; Thu, 23 Jul 2026
 16:48:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260707-m4-v4-0-dbd01185f911@riscstar.com>
 <20260707-m4-v4-2-dbd01185f911@riscstar.com>
 <DK63T7X6VF21.7PVRSS31IVWQ@pigmoral.tech>
In-Reply-To: <DK63T7X6VF21.7PVRSS31IVWQ@pigmoral.tech>
From: Eric Chung <eric.chung@riscstar.com>
Date: Fri, 24 Jul 2026 07:48:00 +0800
X-Gm-Features: AUfX_mysYEffgyDvATQx_x_HvO7iB-7RefJnZzdRewUBW8Onv3lRABW9NfBVKG8
Message-ID: <CAH22mJyoQjVpmmdipY74UC_xmezWkYJS6AF==OWZybAnW=Skdw@mail.gmail.com>
Subject: Re: [PATCH v4 02/10] pinctrl: k1: add IO power domain configuration
 support
To: Junhui Liu <junhui.liu@pigmoral.tech>
Cc: u-boot-spacemit@groups.io, u-boot@lists.denx.de, 
 u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Peng Fan <peng.fan@nxp.com>, Huan Zhou <pericycle.cc@gmail.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Kaustabh Chakraborty <kauschluss@disroot.org>, 
 Han Xu <han.xu@nxp.com>, Yanir Levin <yanir.levin@tandemg.com>, 
 Christoph Stoidner <c.stoidner@phytec.de>,
 Balsundar Ponnusamy <balsundar.ponnusamy@altera.com>, 
 Daniel Palmer <daniel@thingy.jp>, Anshul Dalal <anshuld@ti.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Angelo Dureghello <angelo@kernel-space.org>, 
 Johan Jonker <jbx6244@gmail.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Sam Protsenko <semen.protsenko@linaro.org>,
 Guodong Xu <guodong.xu@riscstar.com>, 
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>, 
 U-Boot <u-boot-bounces@lists.denx.de>, Yixun Lan <dlan@kernel.org>,
 Yao Zi <me@ziyao.cc>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1784850492; x=1785455292;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=H3/zo+r2sb5wTyBMmFmg1UyoUZfEoOxfpUpN0U+v/Ws=;
 b=esXosIRHSbjDDcQsKv2N6iLKjwj61nLOg57HHaKvZE839twcSoIgRTXpSlJ2VrIofI
 HXKwYGKgb62dXZ8a/5GpyC35SV/rV0J/8aRZlSHabgJ6XeSpdMmEzjwHD76aQqTJXbax
 rKiL36BPLUT+h0U6qV3jkkc9dnFV3oofHV4Wuv48cIfa03CRyd1wEbMwJg5WZXBs25RR
 1QKBIgEf+frkznNH15lSl1wD+/ez7vGfmv0Ie9Gocq4EJsyImUQ9lWDcb2RL3wIgD4ds
 taEBDhnisWwnM+cloZ7hLPKBlUBiR+3Y22H29GgbDmifWruyIQUik6W+FC3R2dpHz2SP
 ZCJA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=riscstar.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=esXosIRH
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

On Fri, Jul 24, 2026 at 12:51=E2=80=AFAM Junhui Liu <junhui.liu@pigmoral.te=
ch> wrote:
>
> Hi Eric,
>
> Thanks for your patch. However, I found a couple of issues while
> testing.
>
> On Tue Jul 7, 2026 at 11:21 PM CST, Eric Chung wrote:
> > Dual-voltage GPIO banks default to 3.3V, but when externally supplied
> > with 1.8V the internal logic must be explicitly reconfigured to match.
> >
> > Add the ability to program IO power domain control registers through th=
e
> > APBC block. These registers require unlocking the AIB Secure Access
> > Register (ASAR) before every read/write, since configuring a 1.8V domai=
n
> > while 3.3V is externally supplied can cause back-powering and pin damag=
e.
> >
> > Signed-off-by: Eric Chung <eric.chung@riscstar.com>
> >
> > ---
> > v3:
> > - Add SYSCON dependency in Kconfig.
> > - Fix not sorted issue in the driver.
> > ---
> >  drivers/pinctrl/spacemit/Kconfig      |  2 +-
> >  drivers/pinctrl/spacemit/pinctrl-k1.c | 83 +++++++++++++++++++++++++++=
+++++++-
> >  2 files changed, 82 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/pinctrl/spacemit/Kconfig b/drivers/pinctrl/spacemi=
t/Kconfig
> > index 6aab89e160c..ff754f5839c 100644
> > --- a/drivers/pinctrl/spacemit/Kconfig
> > +++ b/drivers/pinctrl/spacemit/Kconfig
> > @@ -1,6 +1,6 @@
> >  config PINCTRL_SPACEMIT_K1
> >       bool "Spacemit K1 SoC pinctrl driver"
> > -     depends on PINCTRL_GENERIC && DM
> > +     depends on PINCTRL_GENERIC && DM && SYSCON
> >       help
> >         Supports pin multiplexing control on Spacemit K1 SoCs.
> >
> > diff --git a/drivers/pinctrl/spacemit/pinctrl-k1.c b/drivers/pinctrl/sp=
acemit/pinctrl-k1.c
> > index 3ebc397213b..95344f4ec72 100644
> > --- a/drivers/pinctrl/spacemit/pinctrl-k1.c
> > +++ b/drivers/pinctrl/spacemit/pinctrl-k1.c
>
> [...]
>
> > +
> >  static int spacemit_pinconf_set(struct udevice *dev, unsigned int pin_=
selector,
> >                               unsigned int param, unsigned int argument=
)
> >  {
> > @@ -456,6 +526,9 @@ static int spacemit_pinconf_set(struct udevice *dev=
, unsigned int pin_selector,
> >                       dev_err(dev, "Invalid power source (%d)\n", argum=
ent);
> >                       return -EINVAL;
> >               }
> > +             if (found)
> > +                     spacemit_set_io_power_domain(dev, pin_selector,
>
> CONFIG_PINCONF is not enabled in spacemit_k1_defconfig. Therefore, with
> the default configuration, the generic pinctrl code skips pin
> configuration properties and spacemit_pinconf_set() is never called.
> Consequently, the IO power domain configuration added here is not
> exercised when building with spacemit_k1_defconfig.
>

I've enabled CONFIG_PINCONF in the #5 patch of the patch set.

> > +                                                  priv->io_pins[i].io_=
type);
> >               break;
> >       default:
> >               return -EOPNOTSUPP;
> > @@ -485,6 +558,11 @@ static int spacemit_pinctrl_probe(struct udevice *=
dev)
> >               dev_err(dev, "Fail to allocate memory\n");
> >               return -ENOMEM;
> >       }
> > +     priv->regmap =3D syscon_regmap_lookup_by_phandle(dev, "spacemit,a=
pbc");
> > +     if (IS_ERR(priv->regmap)) {
> > +             dev_warn(dev, "no syscon found, disable IO power domain s=
witching\n");
> > +             priv->regmap =3D NULL;
> > +     }
>
> The APBC node with compatible "spacemit,k1-syscon-apbc" is bound by
> drivers/clk/spacemit/clk-k1.c as a UCLASS_CLK device. It is not
> registered as a UCLASS_SYSCON device, and the node does not have the
> "syscon" compatible required by the fallback path in
> syscon_regmap_lookup_by_phandle(). Therefore, this lookup fails and
> priv->regmap is set to NULL.
>
> I added a direct MMIO write to the UART registers here to confirm the
> failure path. The original dev_warn() is not visible because this probe
> happens before the normal console is initialized.
>
> To fix this, I suggest either making the clock driver register or expose
> the APBC regmap through the syscon infrastructure, or avoiding syscon
> here and obtaining the regmap directly using dev_read_phandle_with_args()
> followed by regmap_init_mem().
>

Thanks. Let me check this.
> >
> >       ret =3D clk_get_bulk(dev, &clks);
> >       if (ret) {
> > @@ -512,6 +590,7 @@ static const struct spacemit_pinctrl_data k1_pinctr=
l_data =3D {
> >       .get_pins       =3D k1_get_pins,
> >       .get_functions  =3D k1_get_functions,
> >       .get_io_type    =3D k1_get_io_type,
> > +     .pin_to_io_pd_offset =3D spacemit_k1_pin_to_io_pd_offset,
> >  };
> >
> >  static const struct udevice_id spacemit_pinctrl_ids[] =3D {
>
> --
> Best regards,
> Junhui Liu
>
