Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C446C2BBCA
	for <u-boot@archiver.kernel.org>; Wed, 26 Jun 2024 01:59:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5B5B884CA;
	Wed, 26 Jun 2024 03:59:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=toradex.com header.i=@toradex.com header.b="i+bDV4Kh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6761588356; Tue, 25 Jun 2024 17:16:39 +0200 (CEST)
Received: from de-smtp-delivery-113.mimecast.com
 (de-smtp-delivery-113.mimecast.com [194.104.111.113])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BEC4F87572
 for <u-boot@lists.denx.de>; Tue, 25 Jun 2024 17:16:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=toradex.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrejs.cainikovs@toradex.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=toradex-com; t=1719328596;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=flx93FGYl0c5ZOQ2WB4jsXF/egl/sqY1DdAztF/IC0c=;
 b=i+bDV4KhvzhgitWx4H4u+KkjOys5j+UtJuOUZ5lFo99o5AuBtMqF/niWpYjBaC5cf92jG7
 hql/U0ZUrZjzzzTHL0IeNJjbZAWShyL6DTGS1UvWsdgz0Kp9XZFMAVdavDMDMIMDi36VBQ
 wQAiSKqY03ByiICODTjYnRetqH/hGfc=
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2040.outbound.protection.outlook.com [104.47.22.40]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-56-vbA51vlXMqmVrpX3jpd7cA-1; Tue, 25 Jun 2024 17:16:32 +0200
X-MC-Unique: vbA51vlXMqmVrpX3jpd7cA-1
Received: from ZRAP278MB0254.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1e::13)
 by ZR0P278MB0154.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:32::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Tue, 25 Jun
 2024 15:16:30 +0000
Received: from ZRAP278MB0254.CHEP278.PROD.OUTLOOK.COM
 ([fe80::69a7:1995:40d7:53cc]) by ZRAP278MB0254.CHEP278.PROD.OUTLOOK.COM
 ([fe80::69a7:1995:40d7:53cc%7]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 15:16:30 +0000
Date: Tue, 25 Jun 2024 17:16:28 +0200
From: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>,
 Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH v3 4/6] buildman: Always use the full path in CROSS_COMPILE
Message-ID: <ZnrfTOKroizhiPvY@toradex.com>
References: <20240623175622.1468600-1-sjg@chromium.org>
 <20240623175622.1468600-5-sjg@chromium.org>
 <ZnoKCXS5+Z0tM7Wb@toradex.com>
 <CAFLszTgKvEUVEGOUnuiSzVD3TQE2UjwdFS9Dm8sBpwbw9guaww@mail.gmail.com>
In-Reply-To: <CAFLszTgKvEUVEGOUnuiSzVD3TQE2UjwdFS9Dm8sBpwbw9guaww@mail.gmail.com>
X-ClientProxiedBy: ZR0P278CA0105.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:23::20) To ZRAP278MB0254.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZRAP278MB0254:EE_|ZR0P278MB0154:EE_
X-MS-Office365-Filtering-Correlation-Id: f7840efe-7920-4f55-0a84-08dc9529ca84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?t4T/Ig9LQ+Nh/qMkdJljnGcmez2l6krTd3S373wvLdHC6BMTgHIzIuSx4nUh?=
 =?us-ascii?Q?GwFTJqSf5zmc75HfplMerOu9HOezkFS2s8VqFBBkZNPFaqwv/58T7SfaQ36r?=
 =?us-ascii?Q?bzSvKLlgNgJ7oVv9euPNmzxKYtIN2reccjy4EZEcTIdRgrVtetzL/ZlyWAjd?=
 =?us-ascii?Q?7C5XrQ32M5kYjAkxwIhHz+Jl07AcGBM8ogcHD1drh6YYkEIBjk9g6Jtgb7r3?=
 =?us-ascii?Q?hD59OvWM/MN1tATQIGL5B+E99HqOzf4rN+eRUEWk4Bo86gWBt/B45pELUtq2?=
 =?us-ascii?Q?MeKFe6AnOJ+JXa//K2J0qA8UcfiIctNuAgIqStF/HFXMa/NjgJg/f7M/qpkn?=
 =?us-ascii?Q?cOHcjfaOdHfyAXIbjJMuTjZ9DnfOFQr/6sHP/Bwk2h5jF5kY4KjVe1SVPtv4?=
 =?us-ascii?Q?cB4RZn1PJVWDFb4Tcf2HjVnxrY76vrIWuDqrNfS972pFv/u4XzHyksGQx8tg?=
 =?us-ascii?Q?n125n2wbkKb9iuWBnVg9eonCTDvl6yJdZWumFdaz86o6Qk+kStGzB747dysZ?=
 =?us-ascii?Q?zADQA7osZkJrwRqyFd8Q3kJ21Lx9x9UklrIHX8IyhtESW9X/zAK6HFfY2Utf?=
 =?us-ascii?Q?LeGyU5FV/p+LstZEHE8iwiU+XSJDVFqGuKVxVAn0LwFM1lpUpEGsS3vsaasx?=
 =?us-ascii?Q?qeUmf5VmFCtPpsHByItERHyL2YWZNE25akKR7S+uW33E2yG5a5oVLT2Z6XJU?=
 =?us-ascii?Q?ltaRQEIRP+3uu4hb5WI1jJwZX/4jMSMv1INIsC6fChWAJRsCW4Xju9AOTXhI?=
 =?us-ascii?Q?8jDimE222WCumKz4eTa1c8HGD8Byo+cEcrhbCRvf6gEcf9fzj8/kBp3QhTBz?=
 =?us-ascii?Q?g+dQeC3JrxsXDuh0NrdG5JmKF9+ZBC6RvOyG3Fjv5zPyviHjI+BOVMs4ERgw?=
 =?us-ascii?Q?cQRJfR79tTOJRCtDqr3ZCQ1XZ8YT7JmoSKCO7MOZyhv8PFtV33z8vV9Sz0b6?=
 =?us-ascii?Q?WC4fphMKphk+jYgpIBY/WEkgukT04d/A3FdpV95V7Ly/zRzjAoGqq9M5GbLK?=
 =?us-ascii?Q?7CwI0OKXvlm5szkd2sbCJICeO9SUUPuJbgoWSml2B3S+E4W9dwWEl0j7F9Ap?=
 =?us-ascii?Q?QX2h4Lo34EW79J2ITpNOaroACrTn+HjOF83rtvlTEfnvmn138K6hbgBfbTLZ?=
 =?us-ascii?Q?mB6zAc6j/wKGb2Ggh0SX/o1HAEcSExOvVK1gqjK06HfD9gprarLL+CLPgGnY?=
 =?us-ascii?Q?Y9tvHAypmaUNVTsnjUx0tvwwyx2gBNWF+8q9kB4kJ3T+7Wic+cXJbDkWbl9x?=
 =?us-ascii?Q?O8J8xfSr1Z299mRc0QJMp4qgWb1+J4DMuErk1OIC6+3MLWCOPr+hdkY6RlbB?=
 =?us-ascii?Q?HHE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZRAP278MB0254.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230037)(366013)(376011)(1800799021); DIR:OUT; SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dpxalNwDw4+PSRM1GBY5YaIfAPdHiFdwqArvFLVtfzjQSXJ2ewjaF7OmmGHM?=
 =?us-ascii?Q?vhZsy0fVMpAGLfvQ9k8C7BIgQfl0j5V+NAbh1gR/Q0BEqiM8gnzPSFO/Eo1x?=
 =?us-ascii?Q?px+nC1mogkJb4deVZ54KiqfFutwE4kUGAnVNb6IEUCUV+z808Tf2kT9dwzhn?=
 =?us-ascii?Q?oSSmnIDpeM0DaPtXEQE4lvpFNAg+vvIVzDdDU/8jS3k498NkPLQjg7zIkyN7?=
 =?us-ascii?Q?kdZJ2ZEsUzvzbHbMroyWceuSO1lhXGV1Sy3xIGRa5tBBuSqNxliWaLKTLdSX?=
 =?us-ascii?Q?zSPJykXVy+7yVLW1QAjcRpaKsDPq2bj3qB32T2QWCYl3ihnsIl6NGnKSW0ec?=
 =?us-ascii?Q?LXFoetAPHL3tWVIhTIyCqKUJNqU1eUFsjpaMMNhsSxoPu7y3wGdslRLgfuPG?=
 =?us-ascii?Q?fEQEBUQ2hmvSl5XUF07bHkyGmkXgVBPxqNtShFO5dAvcFx3jgBrDrH+SZKzv?=
 =?us-ascii?Q?MsH0rV4LDrHCVV98jMGfniVlcfRpRf7Yxlrx31+7t2ldCS3lZnarnsvRCv24?=
 =?us-ascii?Q?UXgL0zjuj/WOCM4H2Ioql97Ypj2w/t2DlmXgCwf913ZliIBKfCLiDrbWP17/?=
 =?us-ascii?Q?rfY3CJPgdtKFyoNSQbyE3G575WAVJdFR7SdLcPEI/MGMMUphAWTfVlGCjd8v?=
 =?us-ascii?Q?/9xVSquD4gbXXpKGQ28VySIEbfMVB19qZkqF+rvEu2J2kwLrY5/3Mrj40P0J?=
 =?us-ascii?Q?+fRi2SJup/RagCuPAIGKq7EWWcF8cPeINT6x5LTHWGF7UvC0ZZmnoTrm2pS4?=
 =?us-ascii?Q?vI6yyRBDPS+ATBR+raiV8bNoM1Pz6bulVCMeqVvKR++D3onwSMQqUICXIQ+A?=
 =?us-ascii?Q?ZeoQYtHPgMHjKTZGJoZUZ0EMqAePPSsUHPVeeyUV11GvfmnoCFuu4PwdoxT3?=
 =?us-ascii?Q?Q/IQ4AfK8e58s3dXj/sLqIpwv6jxJr8t0IDeGIa5NR8kw2iOX81kw12fqWwC?=
 =?us-ascii?Q?uSApTM2Hg/4GYb765pqISjE4fvpcnG0Rj9oVxj6mI4z88oi2cmWjXT21DbbR?=
 =?us-ascii?Q?WdZjuX9xqMf1BRKHCxJdNygNUV4zbtrZ37zyf/fSlRenQe5DwDg1i3wOqdoZ?=
 =?us-ascii?Q?vam/BKccuqgFap3uV/8vffauAeIAqeH8RllMjPyBRPL/toWJYdvie4FowF0Z?=
 =?us-ascii?Q?Vbf5P5n8DFbuYUV/C1pUOm+hbg5tgaosydOxzo+yKlDdv7QAxnQoWIaxZi71?=
 =?us-ascii?Q?rNUZ/3/2iXIZNTKpTdbSoJHXnpfgr/fxLmzpnHJbZCaSzn6TUq/xxmkWgWVF?=
 =?us-ascii?Q?ufX1ISLk0YYtfEB7RDeFU9q68TbVboVhohbwNoNjQAqnYhRmZWVEykn81r74?=
 =?us-ascii?Q?6N0ah7lidurZxiH2kYvu4iXRM1m8GE6xvs03vukIo760xG4F/sXYa/o5w3k3?=
 =?us-ascii?Q?QA0L/tODge0lBrXJnpFp4PpZJHK7jfouzWHqNiq5SlZI3chyEQBSdk5E25rE?=
 =?us-ascii?Q?sqzgDrwlEfWadflgyfMeWMnniNIAI3ajRx6TBo2miUzKK3ZTSHvzXDAXmP8y?=
 =?us-ascii?Q?YqtQalhw2vkWyuAPLsrI7EQiasCcfIendEgJqq1ujttsmz4HlyIsfnQ59hgk?=
 =?us-ascii?Q?ObHWnjm2m7k/J3oTO0LTNn0VpigOYqykLG/AXoLMeAuSiizFyHtgyCphUMHp?=
 =?us-ascii?Q?ug=3D=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7840efe-7920-4f55-0a84-08dc9529ca84
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0254.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 15:16:30.6523 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EU01QYWFDdGnJZKLVydAlP6I9XRH3mQ+zl2BUZflV+d+gc6SU+Bas7P4TmEOPxqRWqnil4HjsHOW7qcWZCOM0zPTn1d/8GY8kiHOAC449LM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB0154
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 26 Jun 2024 03:59:08 +0200
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

On Tue, Jun 25, 2024 at 01:38:07PM +0100, Simon Glass wrote:
> Hi Andrejs,
>=20
> On Tue, 25 Jun 2024 at 01:06, Andrejs Cainikovs
> <andrejs.cainikovs@toradex.com> wrote:
> >
> > On Sun, Jun 23, 2024 at 11:56:20AM -0600, Simon Glass wrote:
> > > The feature to set the toolchain path does not seem to be needed. It
> > > causes problems with venv (see [1]). Let's remove it.
> > >
> > > Add some tests while we are here.
> > >
> > > It does not look like any docs changes are needed for this.
> > >
> > > [1] https://patchwork.ozlabs.org/project/uboot/patch/20240621131423.2=
363294-6-sjg@chromium.org/
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > Suggested-by: Tom Rini <trini@konsulko.com>
> > > ---
> > >
> > > Changes in v3:
> > > - Drop the PATH modification altogether
> > >
> > >  tools/buildman/bsettings.py     |  3 ++
> > >  tools/buildman/builder.py       |  5 +--
> > >  tools/buildman/builderthread.py |  4 +-
> > >  tools/buildman/cmdline.py       |  2 -
> > >  tools/buildman/control.py       |  6 +--
> > >  tools/buildman/test.py          | 75 +++++++++++++++++++++++++++++++=
++
> > >  tools/buildman/toolchain.py     | 20 ++++-----
> > >  7 files changed, 92 insertions(+), 23 deletions(-)
> > >
> > > diff --git a/tools/buildman/bsettings.py b/tools/buildman/bsettings.p=
y
> > > index e225ac2ca0f..1be1d45e0fa 100644
> > > --- a/tools/buildman/bsettings.py
> > > +++ b/tools/buildman/bsettings.py
> > > @@ -31,6 +31,9 @@ def setup(fname=3D''):
> > >  def add_file(data):
> > >      settings.readfp(io.StringIO(data))
> > >
> > > +def add_section(name):
> > > +    settings.add_section(name)
> > > +
> > >  def get_items(section):
> > >      """Get the items from a section of the config.
> > >
> > > diff --git a/tools/buildman/builder.py b/tools/buildman/builder.py
> > > index f35175b4598..7c563cddada 100644
> > > --- a/tools/buildman/builder.py
> > > +++ b/tools/buildman/builder.py
> > > @@ -255,7 +255,7 @@ class Builder:
> > >
> > >      def __init__(self, toolchains, base_dir, git_dir, num_threads, n=
um_jobs,
> > >                   gnu_make=3D'make', checkout=3DTrue, show_unknown=3D=
True, step=3D1,
> > > -                 no_subdirs=3DFalse, full_path=3DFalse, verbose_buil=
d=3DFalse,
> > > +                 no_subdirs=3DFalse, verbose_build=3DFalse,
> > >                   mrproper=3DFalse, per_board_out_dir=3DFalse,
> > >                   config_only=3DFalse, squash_config_y=3DFalse,
> > >                   warnings_as_errors=3DFalse, work_in_output=3DFalse,
> > > @@ -279,8 +279,6 @@ class Builder:
> > >              step: 1 to process every commit, n to process every nth =
commit
> > >              no_subdirs: Don't create subdirectories when building cu=
rrent
> > >                  source for a single board
> > > -            full_path: Return the full path in CROSS_COMPILE and don=
't set
> > > -                PATH
> > >              verbose_build: Run build with V=3D1 and don't use 'make =
-s'
> > >              mrproper: Always run 'make mrproper' when configuring
> > >              per_board_out_dir: Build in a separate persistent direct=
ory per
> > > @@ -336,7 +334,6 @@ class Builder:
> > >          self._step =3D step
> > >          self._error_lines =3D 0
> > >          self.no_subdirs =3D no_subdirs
> > > -        self.full_path =3D full_path
> > >          self.verbose_build =3D verbose_build
> > >          self.config_only =3D config_only
> > >          self.squash_config_y =3D squash_config_y
> > > diff --git a/tools/buildman/builderthread.py b/tools/buildman/builder=
thread.py
> > > index a8599c0bb2a..c23c3254d2d 100644
> > > --- a/tools/buildman/builderthread.py
> > > +++ b/tools/buildman/builderthread.py
> > > @@ -404,7 +404,7 @@ class BuilderThread(threading.Thread):
> > >                      the next incremental build
> > >          """
> > >          # Set up the environment and command line
> > > -        env =3D self.toolchain.MakeEnvironment(self.builder.full_pat=
h)
> > > +        env =3D self.toolchain.MakeEnvironment()
> > >          mkdir(out_dir)
> > >
> > >          args, cwd, src_dir =3D self._build_args(brd, out_dir, out_re=
l_dir,
> > > @@ -569,7 +569,7 @@ class BuilderThread(threading.Thread):
> > >                  outf.write(f'{result.return_code}')
> > >
> > >              # Write out the image and function size information and =
an objdump
> > > -            env =3D result.toolchain.MakeEnvironment(self.builder.fu=
ll_path)
> > > +            env =3D result.toolchain.MakeEnvironment()
> > >              with open(os.path.join(build_dir, 'out-env'), 'wb') as o=
utf:
> > >                  for var in sorted(env.keys()):
> > >                      outf.write(b'%s=3D"%s"' % (var, env[var]))
> > > diff --git a/tools/buildman/cmdline.py b/tools/buildman/cmdline.py
> > > index 03211bd5aa5..5fda90508f2 100644
> > > --- a/tools/buildman/cmdline.py
> > > +++ b/tools/buildman/cmdline.py
> > > @@ -121,8 +121,6 @@ def add_after_m(parser):
> > >            help=3D"Override host toochain to use for sandbox (e.g. 'c=
lang-7')")
> > >      parser.add_argument('-Q', '--quick', action=3D'store_true',
> > >            default=3DFalse, help=3D'Do a rough build, with limited wa=
rning resolution')
> > > -    parser.add_argument('-p', '--full-path', action=3D'store_true',
> > > -          default=3DFalse, help=3D"Use full toolchain path in CROSS_=
COMPILE")
> > >      parser.add_argument('-P', '--per-board-out-dir', action=3D'store=
_true',
> > >            default=3DFalse, help=3D"Use an O=3D (output) directory pe=
r board rather than per thread")
> > >      parser.add_argument('--print-arch', action=3D'store_true',
> > > diff --git a/tools/buildman/control.py b/tools/buildman/control.py
> > > index 8f6850c5211..3ca9e2e8761 100644
> > > --- a/tools/buildman/control.py
> > > +++ b/tools/buildman/control.py
> > > @@ -653,10 +653,8 @@ def do_buildman(args, toolchains=3DNone, make_fu=
nc=3DNone, brds=3DNone,
> > >      builder =3D Builder(toolchains, output_dir, git_dir,
> > >              args.threads, args.jobs, checkout=3DTrue,
> > >              show_unknown=3Dargs.show_unknown, step=3Dargs.step,
> > > -            no_subdirs=3Dargs.no_subdirs, full_path=3Dargs.full_path=
,
> > > -            verbose_build=3Dargs.verbose_build,
> > > -            mrproper=3Dargs.mrproper,
> > > -            per_board_out_dir=3Dargs.per_board_out_dir,
> > > +            no_subdirs=3Dargs.no_subdirs, verbose_build=3Dargs.verbo=
se_build,
> > > +            mrproper=3Dargs.mrproper, per_board_out_dir=3Dargs.per_b=
oard_out_dir,
> > >              config_only=3Dargs.config_only,
> > >              squash_config_y=3Dnot args.preserve_config_y,
> > >              warnings_as_errors=3Dargs.warnings_as_errors,
> > > diff --git a/tools/buildman/test.py b/tools/buildman/test.py
> > > index f92add7a7c5..ae9963eed4f 100644
> > > --- a/tools/buildman/test.py
> > > +++ b/tools/buildman/test.py
> > > @@ -146,6 +146,7 @@ class TestBuild(unittest.TestCase):
> > >          self.toolchains.Add('arm-linux-gcc', test=3DFalse)
> > >          self.toolchains.Add('sparc-linux-gcc', test=3DFalse)
> > >          self.toolchains.Add('powerpc-linux-gcc', test=3DFalse)
> > > +        self.toolchains.Add('/path/to/aarch64-linux-gcc', test=3DFal=
se)
> >
> > Sorry Simon, but me and others love to be consistent.
>=20
> That's fine, but do you have a comment on this patch?
>=20
> Regards,
> Simon

I was just thinking about aarch64-linux-gcc (should it be
aarch64-linux-gnu-gcc, btw?)  without path for consistency.
But this of course is very minor - feel free to disregard my
comment.

Best regards,
Andrejs.

