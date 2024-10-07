Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 775CFCFB441
	for <u-boot@archiver.kernel.org>; Mon,  7 Oct 2024 13:26:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA34E88CEA;
	Mon,  7 Oct 2024 15:25:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="Av4VyRxK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5362188663; Mon,  7 Oct 2024 14:33:33 +0200 (CEST)
Received: from mx0a-00176a03.pphosted.com (mx0a-00176a03.pphosted.com
 [67.231.149.52])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A3C188AB9
 for <u-boot@lists.denx.de>; Mon,  7 Oct 2024 14:33:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=gehealthcare.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=brian.ruley@gehealthcare.com
Received: from pps.filterd (m0048275.ppops.net [127.0.0.1])
 by m0048275.ppops.net-00176a03. (8.18.1.2/8.18.1.2) with ESMTP id
 497BPcL4013573
 for <u-boot@lists.denx.de>; Mon, 7 Oct 2024 08:33:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 gehealthcare.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=outbound; bh=m
 Z/O0JCNlgPp0kvd6gJ7JXgopvqFDJ6wT2I4Q103hbc=; b=Av4VyRxKEAcpnAmOH
 Ey/LCUwvT/iP7nMjTUheyX1hzq72ikSKiL4HISwdzuI6O18SoLcCDJP7PgQ7LQ6k
 2zRlEU1DKXhE8z6h45/3p8E5hGaOoaSAtXG6iOt/vsU/ZZh7Kw4bqAjJoYeElfim
 lSDKUYwxDwa+wzhlPwu13EZ065idswc53WgPHOiuEldtPUf74f6chRSaGgyJBMXn
 l5ijTNqx6dxJ3+psPl+t7qQxux2L9SHtx91i1k6nDUjS2KnGgxHWiaRQcwlVVM92
 1LDrVwqS34ynDkcbxD4uklDrhH6sQJ3hYBWY8yZCf/UWXNBKoFgmh+FGNE3+DjsH
 htS8Q==
Date: Mon, 7 Oct 2024 15:33:18 +0300
From: Brian Ruley <brian.ruley@gehealthcare.com>
To: Simon Glass <sjg@chromium.org>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Ian Ray <ian.ray@gehealthcare.com>
Subject: Re: [PATCH v3 1/2] binman: cosmetic: code formatting fixes
Message-ID: <ZwPVDvsp2D4RzOKZ@zoo11.em.health.ge.com>
References: <20240930102148.854-1-brian.ruley@gehealthcare.com>
 <20240930161006.41052-1-brian.ruley@gehealthcare.com>
 <CAFLszTj_qCcSMqQ0KawZus1YoHR4iRDSwKYO2Ur=nLcG8c1HqA@mail.gmail.com>
 <ZvzrCt1_TMxTG6xt@zoo11.em.health.ge.com>
 <CAFLszTiNTK41R22ELniZRCwVMQcAEyJXcMHi8pFLbDJeZ4dKqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLszTiNTK41R22ELniZRCwVMQcAEyJXcMHi8pFLbDJeZ4dKqg@mail.gmail.com>
X-Proofpoint-ORIG-GUID: xQke77IBS0DQ58m3zwFbGsvrM3iUfi5D
X-Proofpoint-GUID: xQke77IBS0DQ58m3zwFbGsvrM3iUfi5D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-07_03,2024-10-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 bulkscore=0 spamscore=0
 adultscore=0 impostorscore=0 suspectscore=0 mlxscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410070089
X-Mailman-Approved-At: Mon, 07 Oct 2024 15:25:58 +0200
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

On Wed, Oct 02, 2024 at 04:55:30PM -0600, Simon Glass wrote:
> 
> Hi Brian,
> 
> On Wed, 2 Oct 2024 at 00:41, Brian Ruley <brian.ruley@gehealthcare.com> wrote:
> >
> > On Mon, Sep 30, 2024 at 12:52:24PM -0600, Simon Glass wrote:
> > >
> > > WARNING: This email originated from outside of GE HealthCare. Please validate the sender's email address before clicking on links or attachments as they may not be safe.
> > >
> > > Hi Brian,
> > >
> > > On Mon, 30 Sept 2024 at 10:10, Brian Ruley <brian.ruley@gehealthcare.com> wrote:
> > > >
> > > > Conform to the style guide used in the project by making the following
> > > > changes:
> > > > * Use single quotes for multiline strings (except docstrings)
> > > > * Fix line width to 79 cols
> > > > * Use f-string instead of formatting a regular string
> > > >
> > > > Signed-off-by: Brian Ruley <brian.ruley@gehealthcare.com>
> > > > ---
> > > >  tools/binman/etype/nxp_imx8mcst.py | 28 +++++++++++++++++++++-------
> > > >  1 file changed, 21 insertions(+), 7 deletions(-)
> > >
> > > Reviewed-by: Simon Glass <sjg@chromium.org>
> > >
> > > Thanks for doing this.
> > >
> > > Some of my comments on the other patch could be applied here, if you prefer.
> > >
> > > >
> > > > diff --git a/tools/binman/etype/nxp_imx8mcst.py b/tools/binman/etype/nxp_imx8mcst.py
> > > > index 8221517b0c..0c744a00d7 100644
> > > > --- a/tools/binman/etype/nxp_imx8mcst.py
> > > > +++ b/tools/binman/etype/nxp_imx8mcst.py
> > > > @@ -23,7 +23,7 @@ from u_boot_pylib import tools
> > > >  MAGIC_NXP_IMX_IVT = 0x412000d1
> > > >  MAGIC_FITIMAGE    = 0xedfe0dd0
> > > >
> > > > -csf_config_template = """
> > > > +csf_config_template = '''
> > > >  [Header]
> > > >    Version = 4.3
> > > >    Hash Algorithm = sha256
> > > > @@ -53,7 +53,7 @@ csf_config_template = """
> > > >  [Authenticate Data]
> > > >    Verification index = 2
> > > >    Blocks = 0x1234 0x78 0xabcd "data.bin"
> > > > -"""
> > > > +'''
> > > >
> > > >  class Entry_nxp_imx8mcst(Entry_mkimage):
> > > >      """NXP i.MX8M CST .cfg file generator and cst invoker
> > > > @@ -69,9 +69,21 @@ class Entry_nxp_imx8mcst(Entry_mkimage):
> > > >      def ReadNode(self):
> > > >          super().ReadNode()
> > > >          self.loader_address = fdt_util.GetInt(self._node, 'nxp,loader-address')
> > > > -        self.srk_table = os.getenv('SRK_TABLE', fdt_util.GetString(self._node, 'nxp,srk-table', 'SRK_1_2_3_4_table.bin'))
> > > > -        self.csf_crt = os.getenv('CSF_KEY', fdt_util.GetString(self._node, 'nxp,csf-crt', 'CSF1_1_sha256_4096_65537_v3_usr_crt.pem'))
> > > > -        self.img_crt = os.getenv('IMG_KEY', fdt_util.GetString(self._node, 'nxp,img-crt', 'IMG1_1_sha256_4096_65537_v3_usr_crt.pem'))
> > > > +        self.srk_table = os.getenv(
> > > > +            'SRK_TABLE', fdt_util.GetString(
> > > > +                            self._node, 'nxp,srk-table',
> > > > +                            'SRK_1_2_3_4_table.bin'
> > > > +                         ))
> > > > +        self.csf_crt = os.getenv(
> > > > +            'CSF_KEY', fdt_util.GetString(
> > > > +                           self._node, 'nxp,csf-crt',
> > > > +                           'CSF1_1_sha256_4096_65537_v3_usr_crt.pem'
> > > > +                       ))
> > > > +        self.img_crt = os.getenv(
> > > > +            'IMG_KEY', fdt_util.GetString(
> > > > +                           self._node, 'nxp,img-crt',
> > > > +                           'IMG1_1_sha256_4096_65537_v3_usr_crt.pem'
> > > > +                       ))
> > > >          self.unlock = fdt_util.GetBool(self._node, 'nxp,unlock')
> > > >          self.ReadEntries()
> > > >
> > > > @@ -118,7 +130,7 @@ class Entry_nxp_imx8mcst(Entry_mkimage):
> > > >          tools.write_file(output_dname, data)
> > > >
> > > >          # Generate CST configuration file used to sign payload
> > > > -        cfg_fname = tools.get_output_filename('nxp.csf-config-txt.%s' % uniq)
> > > > +        cfg_fname = tools.get_output_filename(f'nxp.csf-config-txt.{uniq}')
> > > >          config = configparser.ConfigParser()
> > > >          # Do not make key names lowercase
> > > >          config.optionxform = str
> > > > @@ -127,7 +139,9 @@ class Entry_nxp_imx8mcst(Entry_mkimage):
> > > >          config['Install SRK']['File'] = '"' + self.srk_table + '"'
> > > >          config['Install CSFK']['File'] = '"' + self.csf_crt + '"'
> > > >          config['Install Key']['File'] = '"' + self.img_crt + '"'
> > > > -        config['Authenticate Data']['Blocks'] = hex(signbase) + ' 0 ' + hex(len(data)) + ' "' + str(output_dname) + '"'
> > > > +        config['Authenticate Data']['Blocks'] = (hex(signbase) + ' 0 '
> > > > +                                                 + hex(len(data)) + ' "'
> > > > +                                                 + str(output_dname) + '"')
> > > >          if not self.unlock:
> > > >              config.remove_section('Unlock')
> > > >          with open(cfg_fname, 'w') as cfgf:
> > > > --
> > > > 2.39.5
> > > >
> > >
> > > Regards,
> > > Simon
> >
> > Hi Simon,
> >
> > Sure thing, I'm glad to contribute. I'm quite new to upstreaming so this
> > is a good learning experience for me, and I thank you for your patience.
> 
> Well you seem to have figured it out :-)
> 
> >
> > I didn't have time to respond yesterday, but I sent a new revision
> > based on your comments.
> >
> > Only one I didn't quite get was
> >
> > > All three options seem to read the 'nxp,srk-crt' property, so you can
> > > do that once the if() to reduce the amount of duplicated code.
> >
> > Each is reading a different property "img-crt", "csf-crt", and
> > "srk-crt", with the latter read only if "fast-auth" is set.
> 
> Yes I see that now.
> 
> >
> > As for the testing part, after I got `binman test` working, I
> > experimented with creating a test for the `nxp-imx8mcst` etype, using
> > what you had done as a starting point. FYI, it doesn't depend on the
> > `nxp-imx8mimage` because it's for invoking `mkimage` when building
> > SPL, for example. So, what I did is just create a fake FIT image
> > inside the nxp-imx8mcst node, and run the test. I can send the patch
> > if you wish.
> >
> > The test, however, was unsuccessful because a PKI tree is needed to
> > sign the assets. I thought maybe you would have a comment on that?
> 
> Could you use a test file? There is another etype which has test
> yaml-files in tools/binman/test/yaml/
> 
> There is also tools/binman/test/key.key , I think for the vblock etype.
> 
> Regards,
> Simon

Hi Simon,

I got the test working.

> Could you use a test file? There is another etype which has test
> yaml-files in tools/binman/test/yaml/

Like a test FIT image or what? The image has to be either a FIT or
mkimage.

> There is also tools/binman/test/key.key , I think for the vblock etype.

I tried using it but didn't get it to work (tbh, I didn't try that many
times). Regardless, it's just easier to create keys of the type CST
expects, and include them in the test. I'll send the patch, so you can
take a look.

Also, you haven't responded to the v4 patch I sent -- is it good? Just
want to make sure if there's something I need to do still regarding
that.

Best,
Brian

