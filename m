Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77B2ACF042F
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 01:58:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A67B89139;
	Wed,  9 Oct 2024 03:57:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AjQ/YRAB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E46298913B; Wed,  9 Oct 2024 03:57:28 +0200 (CEST)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A61AC89118
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 03:57:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6c5ab2de184so40395686d6.0
 for <u-boot@lists.denx.de>; Tue, 08 Oct 2024 18:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728439045; x=1729043845; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JlltkgqGVGAhMJ1qldWFTYcM9VXeMP3Mg4VhCVSeSBc=;
 b=AjQ/YRABVVsOpP5VBWiM62a36mfcgeyoOqnqBxp3S1x9rQW5jy8l1VeiJTaIt5k6zx
 aOvr8FaGwKUREA2aLruYy06Tcz0CQ/xy7Lc/mkYa2rfvdhe4mH7e0HY5Z0GaFjF+KW+7
 hnHVK7pDovuNAQx1sG9nIYX5szGzLaWdrkO9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728439045; x=1729043845;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JlltkgqGVGAhMJ1qldWFTYcM9VXeMP3Mg4VhCVSeSBc=;
 b=bzE8BjDvxN3vrt73m63fzlcMmrxZgvA/slx5uX86NAj6rcZvDOw2Dp/eoCB3UiYMFa
 PMdDqA/mrkgYjtwgTkVNRnvbcUWK3HR630JDQ+iM0OPNA6yB7Z5MBKwyGbm5dWEOjGen
 LTtQ4OyEBpMD3LH4mc52etCxu0C8YkPfliO9cCd86zDB5Dfdz6UTzKghuv5Ufow543FL
 yOAHOGUt8OJQrcODsrgojwV4kv1zdkxi6uzmelLpjIjDOBMe6knXdo3Ns+f+lJk6OsHc
 FkurxlgNSrtAxjS6Xxkl7fSCU0s+TD7Po0G/An/TiSZQZ3ZBbhX+/34N+4J8fB17PHcV
 6BmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRH7LVWRYxTuW7WxOr/y4HM+Ac+RTY/4T66o3YGWZthSfmmjKE0WAywN1pnhhR6smI0aaOHco=@lists.denx.de
X-Gm-Message-State: AOJu0YyxQrenlTYVY3IVQUJz2IVszrxt/Sk2C/ydu7z+pfvfyzI/Yrj4
 4uNeWuG9RaV0GrHKop6AzVjVanPAgrkuh+ZG3qsfLbri9gRKyI+y3i3Ui1S+j+/l623EQysjNSg
 Xxx8NERAKFkm5SNWyKt5m5Ogra13EGLmhZXcKp30leaf+etOT1A==
X-Google-Smtp-Source: AGHT+IHomWYsqsuKi6J0NBINc93e5gouDlW7vvLdqDZtoFqtuV7QWRFLNwJFmNiq5tlAl/feZYyzhXOf41hHf/GCnRs=
X-Received: by 2002:a05:6214:440c:b0:6c5:20c2:f33d with SMTP id
 6a1803df08f44-6cbc932bec9mr13740426d6.27.1728439045481; Tue, 08 Oct 2024
 18:57:25 -0700 (PDT)
MIME-Version: 1.0
References: <20240930102148.854-1-brian.ruley@gehealthcare.com>
 <20240930161006.41052-1-brian.ruley@gehealthcare.com>
 <CAFLszTj_qCcSMqQ0KawZus1YoHR4iRDSwKYO2Ur=nLcG8c1HqA@mail.gmail.com>
 <ZvzrCt1_TMxTG6xt@zoo11.em.health.ge.com>
 <CAFLszTiNTK41R22ELniZRCwVMQcAEyJXcMHi8pFLbDJeZ4dKqg@mail.gmail.com>
 <ZwPVDvsp2D4RzOKZ@zoo11.em.health.ge.com>
In-Reply-To: <ZwPVDvsp2D4RzOKZ@zoo11.em.health.ge.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 8 Oct 2024 19:57:14 -0600
Message-ID: <CAFLszThXz70K3972CY22o8r4vO9=xacUT6qv91DrX2o8G=2YUQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] binman: cosmetic: code formatting fixes
To: Brian Ruley <brian.ruley@gehealthcare.com>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Ian Ray <ian.ray@gehealthcare.com>
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

Hi Brian,

On Mon, 7 Oct 2024 at 06:33, Brian Ruley <brian.ruley@gehealthcare.com> wrote:
>
> On Wed, Oct 02, 2024 at 04:55:30PM -0600, Simon Glass wrote:
> >
> > Hi Brian,
> >
> > On Wed, 2 Oct 2024 at 00:41, Brian Ruley <brian.ruley@gehealthcare.com> wrote:
> > >
> > > On Mon, Sep 30, 2024 at 12:52:24PM -0600, Simon Glass wrote:
> > > >
> > > > WARNING: This email originated from outside of GE HealthCare. Please validate the sender's email address before clicking on links or attachments as they may not be safe.
> > > >
> > > > Hi Brian,
> > > >
> > > > On Mon, 30 Sept 2024 at 10:10, Brian Ruley <brian.ruley@gehealthcare.com> wrote:
> > > > >
> > > > > Conform to the style guide used in the project by making the following
> > > > > changes:
> > > > > * Use single quotes for multiline strings (except docstrings)
> > > > > * Fix line width to 79 cols
> > > > > * Use f-string instead of formatting a regular string
> > > > >
> > > > > Signed-off-by: Brian Ruley <brian.ruley@gehealthcare.com>
> > > > > ---
> > > > >  tools/binman/etype/nxp_imx8mcst.py | 28 +++++++++++++++++++++-------
> > > > >  1 file changed, 21 insertions(+), 7 deletions(-)
> > > >
> > > > Reviewed-by: Simon Glass <sjg@chromium.org>
> > > >
> > > > Thanks for doing this.
> > > >
> > > > Some of my comments on the other patch could be applied here, if you prefer.
> > > >
> > > > >
> > > > > diff --git a/tools/binman/etype/nxp_imx8mcst.py b/tools/binman/etype/nxp_imx8mcst.py
> > > > > index 8221517b0c..0c744a00d7 100644
> > > > > --- a/tools/binman/etype/nxp_imx8mcst.py
> > > > > +++ b/tools/binman/etype/nxp_imx8mcst.py
> > > > > @@ -23,7 +23,7 @@ from u_boot_pylib import tools
> > > > >  MAGIC_NXP_IMX_IVT = 0x412000d1
> > > > >  MAGIC_FITIMAGE    = 0xedfe0dd0
> > > > >
> > > > > -csf_config_template = """
> > > > > +csf_config_template = '''
> > > > >  [Header]
> > > > >    Version = 4.3
> > > > >    Hash Algorithm = sha256
> > > > > @@ -53,7 +53,7 @@ csf_config_template = """
> > > > >  [Authenticate Data]
> > > > >    Verification index = 2
> > > > >    Blocks = 0x1234 0x78 0xabcd "data.bin"
> > > > > -"""
> > > > > +'''
> > > > >
> > > > >  class Entry_nxp_imx8mcst(Entry_mkimage):
> > > > >      """NXP i.MX8M CST .cfg file generator and cst invoker
> > > > > @@ -69,9 +69,21 @@ class Entry_nxp_imx8mcst(Entry_mkimage):
> > > > >      def ReadNode(self):
> > > > >          super().ReadNode()
> > > > >          self.loader_address = fdt_util.GetInt(self._node, 'nxp,loader-address')
> > > > > -        self.srk_table = os.getenv('SRK_TABLE', fdt_util.GetString(self._node, 'nxp,srk-table', 'SRK_1_2_3_4_table.bin'))
> > > > > -        self.csf_crt = os.getenv('CSF_KEY', fdt_util.GetString(self._node, 'nxp,csf-crt', 'CSF1_1_sha256_4096_65537_v3_usr_crt.pem'))
> > > > > -        self.img_crt = os.getenv('IMG_KEY', fdt_util.GetString(self._node, 'nxp,img-crt', 'IMG1_1_sha256_4096_65537_v3_usr_crt.pem'))
> > > > > +        self.srk_table = os.getenv(
> > > > > +            'SRK_TABLE', fdt_util.GetString(
> > > > > +                            self._node, 'nxp,srk-table',
> > > > > +                            'SRK_1_2_3_4_table.bin'
> > > > > +                         ))
> > > > > +        self.csf_crt = os.getenv(
> > > > > +            'CSF_KEY', fdt_util.GetString(
> > > > > +                           self._node, 'nxp,csf-crt',
> > > > > +                           'CSF1_1_sha256_4096_65537_v3_usr_crt.pem'
> > > > > +                       ))
> > > > > +        self.img_crt = os.getenv(
> > > > > +            'IMG_KEY', fdt_util.GetString(
> > > > > +                           self._node, 'nxp,img-crt',
> > > > > +                           'IMG1_1_sha256_4096_65537_v3_usr_crt.pem'
> > > > > +                       ))
> > > > >          self.unlock = fdt_util.GetBool(self._node, 'nxp,unlock')
> > > > >          self.ReadEntries()
> > > > >
> > > > > @@ -118,7 +130,7 @@ class Entry_nxp_imx8mcst(Entry_mkimage):
> > > > >          tools.write_file(output_dname, data)
> > > > >
> > > > >          # Generate CST configuration file used to sign payload
> > > > > -        cfg_fname = tools.get_output_filename('nxp.csf-config-txt.%s' % uniq)
> > > > > +        cfg_fname = tools.get_output_filename(f'nxp.csf-config-txt.{uniq}')
> > > > >          config = configparser.ConfigParser()
> > > > >          # Do not make key names lowercase
> > > > >          config.optionxform = str
> > > > > @@ -127,7 +139,9 @@ class Entry_nxp_imx8mcst(Entry_mkimage):
> > > > >          config['Install SRK']['File'] = '"' + self.srk_table + '"'
> > > > >          config['Install CSFK']['File'] = '"' + self.csf_crt + '"'
> > > > >          config['Install Key']['File'] = '"' + self.img_crt + '"'
> > > > > -        config['Authenticate Data']['Blocks'] = hex(signbase) + ' 0 ' + hex(len(data)) + ' "' + str(output_dname) + '"'
> > > > > +        config['Authenticate Data']['Blocks'] = (hex(signbase) + ' 0 '
> > > > > +                                                 + hex(len(data)) + ' "'
> > > > > +                                                 + str(output_dname) + '"')
> > > > >          if not self.unlock:
> > > > >              config.remove_section('Unlock')
> > > > >          with open(cfg_fname, 'w') as cfgf:
> > > > > --
> > > > > 2.39.5
> > > > >
> > > >
> > > > Regards,
> > > > Simon
> > >
> > > Hi Simon,
> > >
> > > Sure thing, I'm glad to contribute. I'm quite new to upstreaming so this
> > > is a good learning experience for me, and I thank you for your patience.
> >
> > Well you seem to have figured it out :-)
> >
> > >
> > > I didn't have time to respond yesterday, but I sent a new revision
> > > based on your comments.
> > >
> > > Only one I didn't quite get was
> > >
> > > > All three options seem to read the 'nxp,srk-crt' property, so you can
> > > > do that once the if() to reduce the amount of duplicated code.
> > >
> > > Each is reading a different property "img-crt", "csf-crt", and
> > > "srk-crt", with the latter read only if "fast-auth" is set.
> >
> > Yes I see that now.
> >
> > >
> > > As for the testing part, after I got `binman test` working, I
> > > experimented with creating a test for the `nxp-imx8mcst` etype, using
> > > what you had done as a starting point. FYI, it doesn't depend on the
> > > `nxp-imx8mimage` because it's for invoking `mkimage` when building
> > > SPL, for example. So, what I did is just create a fake FIT image
> > > inside the nxp-imx8mcst node, and run the test. I can send the patch
> > > if you wish.
> > >
> > > The test, however, was unsuccessful because a PKI tree is needed to
> > > sign the assets. I thought maybe you would have a comment on that?
> >
> > Could you use a test file? There is another etype which has test
> > yaml-files in tools/binman/test/yaml/
> >
> > There is also tools/binman/test/key.key , I think for the vblock etype.
> >
> > Regards,
> > Simon
>
> Hi Simon,
>
> I got the test working.

Great!

>
> > Could you use a test file? There is another etype which has test
> > yaml-files in tools/binman/test/yaml/
>
> Like a test FIT image or what? The image has to be either a FIT or
> mkimage.

Sure, if that is really necessary. Remember that it doesn't actually
need to create a valid image. It just needs to test the code in the
entry type. But if FIT is the easiest thing to do, then that's fine.

>
> > There is also tools/binman/test/key.key , I think for the vblock etype.
>
> I tried using it but didn't get it to work (tbh, I didn't try that many
> times). Regardless, it's just easier to create keys of the type CST
> expects, and include them in the test. I'll send the patch, so you can
> take a look.
>
> Also, you haven't responded to the v4 patch I sent -- is it good? Just
> want to make sure if there's something I need to do still regarding
> that.

I just haven't had time for anything recently...it happens from time
to time and I normally catch up eventually. But if there is no review
for long enough, Tom will likely apply it after having a look.

Regards,
Simon
