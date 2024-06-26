Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1FC9C27C4F
	for <u-boot@archiver.kernel.org>; Wed, 26 Jun 2024 12:29:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF706883D9;
	Wed, 26 Jun 2024 14:29:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=toradex.com header.i=@toradex.com header.b="poJqOY4J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DFCD884CD; Wed, 26 Jun 2024 10:43:22 +0200 (CEST)
Received: from de-smtp-delivery-113.mimecast.com
 (de-smtp-delivery-113.mimecast.com [194.104.111.113])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2ECD87E0D
 for <u-boot@lists.denx.de>; Wed, 26 Jun 2024 10:43:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=toradex.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrejs.cainikovs@toradex.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=toradex-com; t=1719391399;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z6aBdoBWkYoRvadvXddMI5XGLtD9Y8zH0WXvtHYP+VQ=;
 b=poJqOY4JARNvuI7V5WwPV9VU9y0zIBIKumO5ADbBw9oYjTTslAOOycMjjAki8GAY+AcOBq
 qbAgDsXUmu8f9lvmU3KiGLkMnEDGXc9OJ8n95Jo+ff/gm9+MwCiTWvh5TaY7IqWpynqGoS
 1wSsh0CsH1+DZDW3mcKxar2QwPWbCxk=
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com
 (mail-zr0che01lp2105.outbound.protection.outlook.com [104.47.22.105]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-70-uoFvEdwVMY6ebO4CpuE2rA-1; Wed, 26 Jun 2024 10:43:18 +0200
X-MC-Unique: uoFvEdwVMY6ebO4CpuE2rA-1
Received: from ZRAP278MB0254.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1e::13)
 by ZR1P278MB1263.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:6d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 08:43:16 +0000
Received: from ZRAP278MB0254.CHEP278.PROD.OUTLOOK.COM
 ([fe80::69a7:1995:40d7:53cc]) by ZRAP278MB0254.CHEP278.PROD.OUTLOOK.COM
 ([fe80::69a7:1995:40d7:53cc%7]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 08:43:16 +0000
Date: Wed, 26 Jun 2024 10:43:13 +0200
From: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>,
 Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH v3 4/6] buildman: Always use the full path in CROSS_COMPILE
Message-ID: <ZnvUoW85DxzAIDJP@toradex.com>
References: <20240623175622.1468600-1-sjg@chromium.org>
 <20240623175622.1468600-5-sjg@chromium.org>
 <ZnoKCXS5+Z0tM7Wb@toradex.com>
 <CAFLszTgKvEUVEGOUnuiSzVD3TQE2UjwdFS9Dm8sBpwbw9guaww@mail.gmail.com>
 <ZnrfTOKroizhiPvY@toradex.com>
 <CAFLszTjTxRE03kX51L9cK_=LZXFPDWQLzyXM9swe=7aEYDmkKw@mail.gmail.com>
In-Reply-To: <CAFLszTjTxRE03kX51L9cK_=LZXFPDWQLzyXM9swe=7aEYDmkKw@mail.gmail.com>
X-ClientProxiedBy: ZR2P278CA0082.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:65::11) To ZRAP278MB0254.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZRAP278MB0254:EE_|ZR1P278MB1263:EE_
X-MS-Office365-Filtering-Correlation-Id: 80efd2a8-45eb-496c-d50b-08dc95bc058c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|366014|1800799022|376012
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9wZZDN996/votRnfWxg9VPa/kfxhLHZ2UTowdEv6UEsW+goGarnM+FiAkAwN?=
 =?us-ascii?Q?2gyziNBJsqlYywTxKWbqAomJenQVuWgXG54JCE1M27KWDJA+I2tZ8rP8JTkA?=
 =?us-ascii?Q?SBOdP+BESKZbwKZPnQPkHUVe4mpO+wr8Bha/buIPhN6QHJV2KxTy8a4bioA9?=
 =?us-ascii?Q?DBJkkvYoQxWTIoQM8moZHoJ63hYbl86T1bVdQ5OCKeJH6JfRKacSU1MDe9oA?=
 =?us-ascii?Q?6wyw1mUtW5crvsfz32el3b/JIW/ywEqa1bAUzh3pxqcMUGxGiibQKDpJEcB0?=
 =?us-ascii?Q?DhsHYZ6ZTgcGHtl76PJwwY90rkN02OiryRdfO+X7lmU19hSyRMyZvNQA6WAo?=
 =?us-ascii?Q?4XFrw5dIKtqQabLxzPUodrbtqrCtOshrpt5Pz22Z49DxM7060VrxPkMxs5pK?=
 =?us-ascii?Q?8deHwsZRs8etiqrFa8+Y5Iidn3G5tuNaLOXCbyswUd6py+4+UYYrC/tCm4iV?=
 =?us-ascii?Q?6YvTW6eyl/nEkZtKW9LTTcV5QhgGcDr4gFJEUm8bE+gVVHaauNOepRraO2K8?=
 =?us-ascii?Q?Wko6yUu96rXbkchl45ZBGQV0KLNNN/l7Z5eTGaRvPUaAjo5sL1kCMP28rJgO?=
 =?us-ascii?Q?vqAKLfugYDQE1caOeri4bDO2RufCGWNzND0GNie1Gdvh5cJ7VqsVefr4VTKC?=
 =?us-ascii?Q?AychORdL2v6psTop1gAYxtrjlpLDyVyZteB33KiZNawe1SGHRBYXCtymaY8b?=
 =?us-ascii?Q?j19QY5PDHKl4KgeP64mQd/wcOpSS5Wuo9GVojGxVj8wPEHLKwiwSVbIChwAM?=
 =?us-ascii?Q?co16vP+DYyIXzy4xapoo4oSqyCX4qhtKs8ImnM3ly8Vr/oDidMaUe923DJj/?=
 =?us-ascii?Q?hlaOfFSo/HUYTOdddfol0r9Qgc69jVKfAvglkIqS3Ov4dibdzwF7Cr0K5/iT?=
 =?us-ascii?Q?A2p2wyTRUzAf0oe+zDzApiozL4fOn7BY43y92DoLQcRUWlGAoTIHSfSJFE0B?=
 =?us-ascii?Q?xVgDWMLITSFKo5wPIX64ph9FnPPi3XDaDwvK9b8uJZNDcmUm84q2rc5/qodJ?=
 =?us-ascii?Q?l29jc2/gr2+MCjbfXueZPXQA9JcXZQ1fv1t1b0Ovr51mMLBpK2PPBvJWk1A+?=
 =?us-ascii?Q?w/Xghn3OFs5QT0DE5oDQSaBuQgW0yVHWZuESubn7LHytZjZ88kXm3E7NNmpM?=
 =?us-ascii?Q?KWt8V7pwHQKy9e0pDHeCICSW6KtvtvU2M0mSkqhigC10Goj6DzozuqdA2pJ5?=
 =?us-ascii?Q?DTTm6z1+H2LHdsYat1M4enzhCxpdUujEMpHbKb+AkwRWrh7QRbYFab3xQlqS?=
 =?us-ascii?Q?7qheEcaHclaMD7Ncvize?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZRAP278MB0254.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230038)(366014)(1800799022)(376012); DIR:OUT; SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Sa2jvePFMceVHDCeo1Cx3cbScSq0h9KuQUloi3H4udSRoZV2O5RqkBttgt6B?=
 =?us-ascii?Q?T1ZZa/0ye5QhpiDL2MOKb9JmD+RDEPedW2PUcFooPio+t07ywSY1QCHL5mQN?=
 =?us-ascii?Q?T62VmzoX9oXigxjQ+ch4RSqEqDljV0MMnod4FuqbRVyYeKLN5kk9YQXhDlho?=
 =?us-ascii?Q?reHOzq41Dkg/R7+JXujADF1hqpOrFUe4ZEQduT6xXtNZ+TwOZsYxgzt/7U0d?=
 =?us-ascii?Q?rJF/TgINtE54IedrW3Jzgp4DXOpko0JsSltxJBZ8hY1094ruA8O+uE4ojGpO?=
 =?us-ascii?Q?KFaO+EhLs5J4tSzYxTxSIIPFk2ne8tWin1PqMs/seiMx9vT6D1FBpcSaQSha?=
 =?us-ascii?Q?LrkE83BkJCwk1gJ3IAhBknc4YC9bD3HFVIXBZa0a6vM4GThQWxJmig7Y5763?=
 =?us-ascii?Q?+7TPoMz9SRFc8C7cNyvhub6mnzP1Nxjc7/egZn9/BrUcn5r2kx9oBPb4XH4F?=
 =?us-ascii?Q?F8jJUCiC5iEFyP7NsG/5Xsewn94qZH379ZDpM501VosNeqBJCNZHGpPAr2zA?=
 =?us-ascii?Q?/EmfXpuMYO7gDPkKcP8G8j++iG6r4DMZZi58DYu96BJDjBXnMZVCR5H+DAfe?=
 =?us-ascii?Q?AJK30dZaQQ+EIc87e5qoZgCEN2aUxxVz5Lxj8VF+eXHFP91TZ9ORJ2eKh5B6?=
 =?us-ascii?Q?FzADypZOCEOf3uzrUElceEqmHzsheaVAa1cPsA6WDqouTiDiPxL/7bPXgh5O?=
 =?us-ascii?Q?wivfSLJowcioaqwQUBSVFbimMr9t6fQJXIxPLsqnjqaPj29u2OF/o8YnY3sY?=
 =?us-ascii?Q?XtYO5rLC3O3QeK+S0fUiVBQTItHTRbLNCL6EAXIPLQvcvW5RQF94MPBiS3Pu?=
 =?us-ascii?Q?uArPQ4g+wivBzrlYiUM8FXdqcp3xKSwzfYQz5VSF44zRqFShwBiR/WXICBKz?=
 =?us-ascii?Q?+Kzm4+KWJsnFdlxrv1I3nOC+M05k7FxYycRAsFRLudERvJKvVIgU0k9quTRo?=
 =?us-ascii?Q?spk16u5oUlsO0PablamfjyMhFWtpJ1ij8Wu8+WWa0Y/NPGyTmRplWCkgCX1z?=
 =?us-ascii?Q?ISTf0urfdrEJauQ8Od2c1t5zEXeb+Jv6ZA+cWw6FxpHVHgtfcNSLGPPqqknf?=
 =?us-ascii?Q?P2pgECJc56fNxgcz3ogUZxDOtjCT++k4vdmhIZb1hVBsnsB9GM0FIACDQMrJ?=
 =?us-ascii?Q?+GeOOLXxZInuTdChDqDMus8nB9J1XE6AhuwWy5b+swabxePddwOSrDKvG3BQ?=
 =?us-ascii?Q?MmBO1JqVVgBdfAAGVef1sgTwibabcj+PXLAWAg33YvkzHjKInq7wj8Xyj+3o?=
 =?us-ascii?Q?RC/At6cKAXbqkKjZsp2TrOBeDL8rT5QPOduznrHuUb0CDCv/IDaDW9ycWo2s?=
 =?us-ascii?Q?aL4DpFpeb0CdHDhQCQ2CD9ir1yy0fBnHvACwUYVZFbWXxsji8PaKJFdsFiUP?=
 =?us-ascii?Q?ftApTumEQogVYSrlsUW3XrCEwVw2TO7Xd9/dwsKx5Fp2Sq69W6cWd1DNKNbh?=
 =?us-ascii?Q?19sAXfbYQImJic0D9TZ2zLrXMYZ6CE0JTzAWAq1KkdMpSDYbxOj1X02PwzHW?=
 =?us-ascii?Q?bzmmO4nG1tZVXtZYJN4m9875fr2B6I5TH8iMcb70e1428ssp4tVR+a+tf3v8?=
 =?us-ascii?Q?ueYSVkZ7i1+rsEEAiQ4udlOxihmlx/KIS8nFoj/vGK4eaSEJpkbSmURV1RAm?=
 =?us-ascii?Q?sg=3D=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80efd2a8-45eb-496c-d50b-08dc95bc058c
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0254.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 08:43:16.0382 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jGjsv/AK12lDoKMkVD6z1bLVoGxMlPl4U50nYWLOXYdFm1QPguDdpcwYsCcRENIMRcutDs968ggmqDvQWTGqsVBLXQSOTapEmT7a7Us2WW8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR1P278MB1263
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 26 Jun 2024 14:29:28 +0200
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

On Wed, Jun 26, 2024 at 09:00:43AM +0100, Simon Glass wrote:
> Hi Andrejs,
>=20
> On Tue, 25 Jun 2024 at 16:16, Andrejs Cainikovs
> <andrejs.cainikovs@toradex.com> wrote:
> >
> > On Tue, Jun 25, 2024 at 01:38:07PM +0100, Simon Glass wrote:
> > > Hi Andrejs,
> > >
> > > On Tue, 25 Jun 2024 at 01:06, Andrejs Cainikovs
> > > <andrejs.cainikovs@toradex.com> wrote:
> > > >
> > > > On Sun, Jun 23, 2024 at 11:56:20AM -0600, Simon Glass wrote:
> > > > > The feature to set the toolchain path does not seem to be needed.=
 It
> > > > > causes problems with venv (see [1]). Let's remove it.
> > > > >
> > > > > Add some tests while we are here.
> > > > >
> > > > > It does not look like any docs changes are needed for this.
> > > > >
> > > > > [1] https://patchwork.ozlabs.org/project/uboot/patch/202406211314=
23.2363294-6-sjg@chromium.org/
> > > > >
> > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > Suggested-by: Tom Rini <trini@konsulko.com>
> > > > > ---
> > > > >
> > > > > Changes in v3:
> > > > > - Drop the PATH modification altogether
> > > > >
> > > > >  tools/buildman/bsettings.py     |  3 ++
> > > > >  tools/buildman/builder.py       |  5 +--
> > > > >  tools/buildman/builderthread.py |  4 +-
> > > > >  tools/buildman/cmdline.py       |  2 -
> > > > >  tools/buildman/control.py       |  6 +--
> > > > >  tools/buildman/test.py          | 75 +++++++++++++++++++++++++++=
++++++
> > > > >  tools/buildman/toolchain.py     | 20 ++++-----
> > > > >  7 files changed, 92 insertions(+), 23 deletions(-)
> > > > >
> > > > > diff --git a/tools/buildman/bsettings.py b/tools/buildman/bsettin=
gs.py
> > > > > index e225ac2ca0f..1be1d45e0fa 100644
> > > > > --- a/tools/buildman/bsettings.py
> > > > > +++ b/tools/buildman/bsettings.py
> > > > > @@ -31,6 +31,9 @@ def setup(fname=3D''):
> > > > >  def add_file(data):
> > > > >      settings.readfp(io.StringIO(data))
> > > > >
> > > > > +def add_section(name):
> > > > > +    settings.add_section(name)
> > > > > +
> > > > >  def get_items(section):
> > > > >      """Get the items from a section of the config.
> > > > >
> > > > > diff --git a/tools/buildman/builder.py b/tools/buildman/builder.p=
y
> > > > > index f35175b4598..7c563cddada 100644
> > > > > --- a/tools/buildman/builder.py
> > > > > +++ b/tools/buildman/builder.py
> > > > > @@ -255,7 +255,7 @@ class Builder:
> > > > >
> > > > >      def __init__(self, toolchains, base_dir, git_dir, num_thread=
s, num_jobs,
> > > > >                   gnu_make=3D'make', checkout=3DTrue, show_unknow=
n=3DTrue, step=3D1,
> > > > > -                 no_subdirs=3DFalse, full_path=3DFalse, verbose_=
build=3DFalse,
> > > > > +                 no_subdirs=3DFalse, verbose_build=3DFalse,
> > > > >                   mrproper=3DFalse, per_board_out_dir=3DFalse,
> > > > >                   config_only=3DFalse, squash_config_y=3DFalse,
> > > > >                   warnings_as_errors=3DFalse, work_in_output=3DFa=
lse,
> > > > > @@ -279,8 +279,6 @@ class Builder:
> > > > >              step: 1 to process every commit, n to process every =
nth commit
> > > > >              no_subdirs: Don't create subdirectories when buildin=
g current
> > > > >                  source for a single board
> > > > > -            full_path: Return the full path in CROSS_COMPILE and=
 don't set
> > > > > -                PATH
> > > > >              verbose_build: Run build with V=3D1 and don't use 'm=
ake -s'
> > > > >              mrproper: Always run 'make mrproper' when configurin=
g
> > > > >              per_board_out_dir: Build in a separate persistent di=
rectory per
> > > > > @@ -336,7 +334,6 @@ class Builder:
> > > > >          self._step =3D step
> > > > >          self._error_lines =3D 0
> > > > >          self.no_subdirs =3D no_subdirs
> > > > > -        self.full_path =3D full_path
> > > > >          self.verbose_build =3D verbose_build
> > > > >          self.config_only =3D config_only
> > > > >          self.squash_config_y =3D squash_config_y
> > > > > diff --git a/tools/buildman/builderthread.py b/tools/buildman/bui=
lderthread.py
> > > > > index a8599c0bb2a..c23c3254d2d 100644
> > > > > --- a/tools/buildman/builderthread.py
> > > > > +++ b/tools/buildman/builderthread.py
> > > > > @@ -404,7 +404,7 @@ class BuilderThread(threading.Thread):
> > > > >                      the next incremental build
> > > > >          """
> > > > >          # Set up the environment and command line
> > > > > -        env =3D self.toolchain.MakeEnvironment(self.builder.full=
_path)
> > > > > +        env =3D self.toolchain.MakeEnvironment()
> > > > >          mkdir(out_dir)
> > > > >
> > > > >          args, cwd, src_dir =3D self._build_args(brd, out_dir, ou=
t_rel_dir,
> > > > > @@ -569,7 +569,7 @@ class BuilderThread(threading.Thread):
> > > > >                  outf.write(f'{result.return_code}')
> > > > >
> > > > >              # Write out the image and function size information =
and an objdump
> > > > > -            env =3D result.toolchain.MakeEnvironment(self.builde=
r.full_path)
> > > > > +            env =3D result.toolchain.MakeEnvironment()
> > > > >              with open(os.path.join(build_dir, 'out-env'), 'wb') =
as outf:
> > > > >                  for var in sorted(env.keys()):
> > > > >                      outf.write(b'%s=3D"%s"' % (var, env[var]))
> > > > > diff --git a/tools/buildman/cmdline.py b/tools/buildman/cmdline.p=
y
> > > > > index 03211bd5aa5..5fda90508f2 100644
> > > > > --- a/tools/buildman/cmdline.py
> > > > > +++ b/tools/buildman/cmdline.py
> > > > > @@ -121,8 +121,6 @@ def add_after_m(parser):
> > > > >            help=3D"Override host toochain to use for sandbox (e.g=
. 'clang-7')")
> > > > >      parser.add_argument('-Q', '--quick', action=3D'store_true',
> > > > >            default=3DFalse, help=3D'Do a rough build, with limite=
d warning resolution')
> > > > > -    parser.add_argument('-p', '--full-path', action=3D'store_tru=
e',
> > > > > -          default=3DFalse, help=3D"Use full toolchain path in CR=
OSS_COMPILE")
> > > > >      parser.add_argument('-P', '--per-board-out-dir', action=3D's=
tore_true',
> > > > >            default=3DFalse, help=3D"Use an O=3D (output) director=
y per board rather than per thread")
> > > > >      parser.add_argument('--print-arch', action=3D'store_true',
> > > > > diff --git a/tools/buildman/control.py b/tools/buildman/control.p=
y
> > > > > index 8f6850c5211..3ca9e2e8761 100644
> > > > > --- a/tools/buildman/control.py
> > > > > +++ b/tools/buildman/control.py
> > > > > @@ -653,10 +653,8 @@ def do_buildman(args, toolchains=3DNone, mak=
e_func=3DNone, brds=3DNone,
> > > > >      builder =3D Builder(toolchains, output_dir, git_dir,
> > > > >              args.threads, args.jobs, checkout=3DTrue,
> > > > >              show_unknown=3Dargs.show_unknown, step=3Dargs.step,
> > > > > -            no_subdirs=3Dargs.no_subdirs, full_path=3Dargs.full_=
path,
> > > > > -            verbose_build=3Dargs.verbose_build,
> > > > > -            mrproper=3Dargs.mrproper,
> > > > > -            per_board_out_dir=3Dargs.per_board_out_dir,
> > > > > +            no_subdirs=3Dargs.no_subdirs, verbose_build=3Dargs.v=
erbose_build,
> > > > > +            mrproper=3Dargs.mrproper, per_board_out_dir=3Dargs.p=
er_board_out_dir,
> > > > >              config_only=3Dargs.config_only,
> > > > >              squash_config_y=3Dnot args.preserve_config_y,
> > > > >              warnings_as_errors=3Dargs.warnings_as_errors,
> > > > > diff --git a/tools/buildman/test.py b/tools/buildman/test.py
> > > > > index f92add7a7c5..ae9963eed4f 100644
> > > > > --- a/tools/buildman/test.py
> > > > > +++ b/tools/buildman/test.py
> > > > > @@ -146,6 +146,7 @@ class TestBuild(unittest.TestCase):
> > > > >          self.toolchains.Add('arm-linux-gcc', test=3DFalse)
> > > > >          self.toolchains.Add('sparc-linux-gcc', test=3DFalse)
> > > > >          self.toolchains.Add('powerpc-linux-gcc', test=3DFalse)
> > > > > +        self.toolchains.Add('/path/to/aarch64-linux-gcc', test=
=3DFalse)
> > > >
> > > > Sorry Simon, but me and others love to be consistent.
> > >
> > > That's fine, but do you have a comment on this patch?
> > >
> > > Regards,
> > > Simon
> >
> > I was just thinking about aarch64-linux-gcc (should it be
> > aarch64-linux-gnu-gcc, btw?)  without path for consistency.
> > But this of course is very minor - feel free to disregard my
> > comment.
>=20
> Oh I see...the point here is to test a toolchain which has a path
> prepended to it, That is why this test case is not consistent with the
> others.
>=20
> Regards,
> Simon

In this case:

Reviewed-by: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>

Regards,
Andrejs.

