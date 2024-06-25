Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98018C2BD09
	for <u-boot@archiver.kernel.org>; Tue, 25 Jun 2024 01:15:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A0478845A;
	Tue, 25 Jun 2024 03:15:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=toradex.com header.i=@toradex.com header.b="g3Nk1d0M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 039F8883E7; Tue, 25 Jun 2024 02:06:42 +0200 (CEST)
Received: from de-smtp-delivery-113.mimecast.com
 (de-smtp-delivery-113.mimecast.com [194.104.109.113])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68E628751B
 for <u-boot@lists.denx.de>; Tue, 25 Jun 2024 02:06:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=toradex.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrejs.cainikovs@toradex.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=toradex-com; t=1719273998;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=orqsSZBwzqwNfXm1DMkA455bkJN+TvculOD+aRCXjWw=;
 b=g3Nk1d0MBvi8r+14pA0DB/fdTC1W5n7pzswCNtOS+v/F3mKGnmyzs9KFh3WqeZ6yLHEaIA
 QiJLV+jFz4Rd9kYifbaQGokrjjosTE6VRVuIbRAtlK4D4svYAbgIxPVgzc+Max4yLyOatV
 PH5opAT7eNfvcS3c4fJhbKMXyPfiZS8=
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com
 (mail-zr0che01lp2104.outbound.protection.outlook.com [104.47.22.104]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-65-9PN0nEnGMPu2s57NFnM1bA-1; Tue, 25 Jun 2024 02:06:36 +0200
X-MC-Unique: 9PN0nEnGMPu2s57NFnM1bA-1
Received: from ZRAP278MB0254.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1e::13)
 by ZR3P278MB1427.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:9d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Tue, 25 Jun
 2024 00:06:35 +0000
Received: from ZRAP278MB0254.CHEP278.PROD.OUTLOOK.COM
 ([fe80::69a7:1995:40d7:53cc]) by ZRAP278MB0254.CHEP278.PROD.OUTLOOK.COM
 ([fe80::69a7:1995:40d7:53cc%7]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 00:06:35 +0000
Date: Tue, 25 Jun 2024 02:06:33 +0200
From: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>,
 Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH v3 4/6] buildman: Always use the full path in CROSS_COMPILE
Message-ID: <ZnoKCXS5+Z0tM7Wb@toradex.com>
References: <20240623175622.1468600-1-sjg@chromium.org>
 <20240623175622.1468600-5-sjg@chromium.org>
In-Reply-To: <20240623175622.1468600-5-sjg@chromium.org>
X-ClientProxiedBy: ZR0P278CA0130.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::9) To ZRAP278MB0254.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZRAP278MB0254:EE_|ZR3P278MB1427:EE_
X-MS-Office365-Filtering-Correlation-Id: 90501af5-6306-4e18-d38a-08dc94aaad83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|1800799021|366013
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1fv9SsQ9EJOK7whLWbG2QTCWj6P98INlvkYFAZ2lqdgLgiFFKxBZU8eYiO5c?=
 =?us-ascii?Q?hM8QQde6JQRkwIlxh9QHQgt1ZxotadrcWBBmpQqtsw+Kl54woJgQB5t+j704?=
 =?us-ascii?Q?TsQ5r4AF2tK4hDJyrIoSDRzTSHGWWjzcbvkaqrwFoQEwt42/2c9O66V8I60w?=
 =?us-ascii?Q?OAxrVoGH6i4LQ5v7q90W3zb3U9g7KnE1WjQNnlcyBN6rsyazjGki4GfWvBUX?=
 =?us-ascii?Q?8shMBifQkYKlG4deMLpQPDmoXHBUI+6aWRw4Pj3+OCGLjzxvCr9GFfwYPHYt?=
 =?us-ascii?Q?seOHl10Da6OuTp7ZN0ozCMx0IjfgThGHW+4MgIuEomRu0pa+gV4mkMWhScMi?=
 =?us-ascii?Q?leqwcJhG3IKwThtvI9I2oHmuo2K9DxjpME3j+2wRidA2uZNJNttblNsgGqCn?=
 =?us-ascii?Q?IgV47fcwHhq0DqcximcdmOtkzwmADEZQNY+TYGShAOe+CLBqt6+ENeMOjp5U?=
 =?us-ascii?Q?bg8/NNBOn1Hh6Sdesag0Gkb59dx7HF++HSuV9yR7ygUjiq+yOwQ9F/JyOpVD?=
 =?us-ascii?Q?S6GvuYQ6b54bHCqyOjcoYmzTSYmY3dKAB64PRw5utgWCoxJH7+S8pCrCBHDL?=
 =?us-ascii?Q?4DwpkB2BWTyq6XTHojvqLnoFv3idPju0oG0ZOya12tGt39Lfa/kVhxfc7nDL?=
 =?us-ascii?Q?RNH87MUofOoWns2LgKvqRyG7RGyy4IRbqEFPoqeylPtZyl8oyExxeFwsWZIj?=
 =?us-ascii?Q?IhypRle0o6sAjfH50b/Ej5DoNMY/eupF77IEJbD68zMs4b9UKXXFXE4mjs3s?=
 =?us-ascii?Q?NyiIRxpg93woV+ZsRc4xpP6U79QzYc8HY+gdY5VMb+sBBICOPwzzF3C+gujW?=
 =?us-ascii?Q?oaZBDF++NYKvfvdml0DL/k1TX2lTBIB25lWuxxox4f00rZ1PeiCTqS3bs1wH?=
 =?us-ascii?Q?G/BH729+aBS1RyGS33Xm+l5JJkgaij6k9VRhYjwExSXeJVi/3SSEp7FyESav?=
 =?us-ascii?Q?agLwa0LS2zo/PCm7fTND6j2Jef1+qPi+mxse7Tc3JFySAdL8hd6eDCQvcBc9?=
 =?us-ascii?Q?7pPLvuJCT4QYttq2rJB+1GhW1dg+Wu9FO7kYMeiT+3Ss1Ox79ng14Y3YEMlw?=
 =?us-ascii?Q?64fYF4Q2D84KQvLAU65QQ1yCRmPUs4SdPtBZshWg555RsGwGm0k0nlpTnhL6?=
 =?us-ascii?Q?OORRPamIwK9j4sF5BWhiBEy1tHXCx+CX/KOWg+q3P+ejwcDhxqwoHLaUaMii?=
 =?us-ascii?Q?bktyCFAFxGUfBJ9ioVdiTo+bWEZWM/OJ98yto7ccQAYtIJMf2c1LsGZm2Gm0?=
 =?us-ascii?Q?ggYBe9b8VHQ7dm8wIBQl?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZRAP278MB0254.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230037)(376011)(1800799021)(366013); DIR:OUT; SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rhm7b0qLLmxaIr0a4CJugJFznHnelmXPfnvwouMALNhtaovFKotIE6Tfp4m2?=
 =?us-ascii?Q?fKrUhNbwF31QjQLi4dYIZlUjAUoJkzagtOxffIe2MyB/sIoiBDth8My8G/4b?=
 =?us-ascii?Q?UyPDzQTzw/oCv2TzgkFg5nFCCKG8+IDHVU1qOeCeU5G7Sd8cfWTdezcVUeR8?=
 =?us-ascii?Q?frybyajyMJ0YN6PXUFrQEXcbBytNuq4Hm8rRMFvIlr6S+dQxv1uMSzZOmLDz?=
 =?us-ascii?Q?00b9DdGiJLXWZaY5nB49wwcvWz/3+RUUamszARZctGwVXHhBgTli+biCM3a1?=
 =?us-ascii?Q?kCy1vUkbsNfQSm4UvBr17rx73Y1xM2g2mB8RrarQhP3owEoUAYFuJ+EXh/SY?=
 =?us-ascii?Q?pCiivQmT2CPgdrzScK0DoTlVpZKj0zg5TyzHn6Z87YFk81P3s9/xGfqooFWt?=
 =?us-ascii?Q?Z5CcfvvHkYRFVjDG0cES0xvK1LjOCxyyq+QnuUcCpULJ3s+XfXWtVWmQL1DV?=
 =?us-ascii?Q?XbtRqbtTqz0NVfkS0kGia1i7YQO3Ez5uhfgL96drSP8dffvnVbkIo3jxrPjk?=
 =?us-ascii?Q?KzGz/MPFD+FCv85oLqNXYshXs35043nx+aTVx/0z30X1J4RN7P0xTLx84xBp?=
 =?us-ascii?Q?ipAmzUtcLGOFoRyb9/REXztorPTcBmcjylUPM2FtU9ssztACQsX4Bkr+K+bx?=
 =?us-ascii?Q?0fgLuSmAgADFmZJyKWqzh40QQBQBz8pY0QDq1G1k8/mVO74CqY/RIJsSdpDu?=
 =?us-ascii?Q?AwTTyP15VkltGticyY6UebsrtggbdQwox4Xa/Vzuwt6uixZMtIqv755xuURl?=
 =?us-ascii?Q?IZOIBfAAF8oKwj5G8XNn14uL0v6qeAIsi4JKd74pugBVS6dQuti6BT4ecOr+?=
 =?us-ascii?Q?MBjOW7l5WAET/NiQCUqQej8Ky/5As7JbdKmOn5P5+aR3suZ4OaboSm7KOCnq?=
 =?us-ascii?Q?t+Npvrikj1C370Zrq0rnK4JloNS7AiKS4ntAEi/Q5L3zme4iyX8pUsKFmvdy?=
 =?us-ascii?Q?qomjNC6I6RKRQh5ofZCIefzUh7bGblEQEx4OIeM+OzDM8AtwvphlDVe2+1ud?=
 =?us-ascii?Q?Sbig0ApRCgzrUh3+2N09E8/DQMO+wSHaL1CGtB48gtHocPHvEQasqKn2Le4M?=
 =?us-ascii?Q?DHAKo/5hPXToemLHnvLm2jSOJ8yQQCSwRhn3VIyhXEUYdh1e65Mcb06Q4JQW?=
 =?us-ascii?Q?/2anrTiQzEaOk1Pb1g9SnAvSK9nkImLKi0tddwSiQ0uffbbXu7k4s0Y5iXru?=
 =?us-ascii?Q?Xtci4LKfVbVFKJ1Cvx0Q13PqGiIQn3N5E7bFmOXSA6fKJ1wiBKIo9O5jHkGA?=
 =?us-ascii?Q?3lXtQkpyqDrLs1wcFafhMSIP4sSzYOP4lNGkustWdubeKpt56hBOPqg3vJTK?=
 =?us-ascii?Q?g/lQi/ntudaGHVzXOrRHiR4p71XHLqrnUBZawoTPAKMF0992DIp+iStIZ/xr?=
 =?us-ascii?Q?rN9GSJL4tNKXqhHg2rJKSX3TIHeUfMLJ1p9lMRxUhoYSfe2la1jye47HeCdZ?=
 =?us-ascii?Q?8gP4GUpziasIUEfQ7OBj4axmtCluXlG26pc/LD8eQmRVO7BcIintXtSpEowH?=
 =?us-ascii?Q?kmRQT/iwfH4w++s+wnIFlsHbMShPF7G1D2FToED8Tpwd0bVxOSks8NlGC9y9?=
 =?us-ascii?Q?xeqBMQg1mKJn/tlglo+xNgmUB5jCwYoHKQlM0qk1wEHKDFmeubUD8UbCfB1i?=
 =?us-ascii?Q?Fg=3D=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90501af5-6306-4e18-d38a-08dc94aaad83
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0254.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 00:06:35.7441 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iSx8fDWEvxmus38vr5jQLwUXItwLmRjVVfAP77wqPDZx0DSEQa2aNuiZFJ86j9NiSzbegQSoftHwilVqX2/ub170oGxNl33vJNPE7DNMLs4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR3P278MB1427
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 25 Jun 2024 03:15:32 +0200
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

On Sun, Jun 23, 2024 at 11:56:20AM -0600, Simon Glass wrote:
> The feature to set the toolchain path does not seem to be needed. It
> causes problems with venv (see [1]). Let's remove it.
>=20
> Add some tests while we are here.
>=20
> It does not look like any docs changes are needed for this.
>=20
> [1] https://patchwork.ozlabs.org/project/uboot/patch/20240621131423.23632=
94-6-sjg@chromium.org/
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Suggested-by: Tom Rini <trini@konsulko.com>
> ---
>=20
> Changes in v3:
> - Drop the PATH modification altogether
>=20
>  tools/buildman/bsettings.py     |  3 ++
>  tools/buildman/builder.py       |  5 +--
>  tools/buildman/builderthread.py |  4 +-
>  tools/buildman/cmdline.py       |  2 -
>  tools/buildman/control.py       |  6 +--
>  tools/buildman/test.py          | 75 +++++++++++++++++++++++++++++++++
>  tools/buildman/toolchain.py     | 20 ++++-----
>  7 files changed, 92 insertions(+), 23 deletions(-)
>=20
> diff --git a/tools/buildman/bsettings.py b/tools/buildman/bsettings.py
> index e225ac2ca0f..1be1d45e0fa 100644
> --- a/tools/buildman/bsettings.py
> +++ b/tools/buildman/bsettings.py
> @@ -31,6 +31,9 @@ def setup(fname=3D''):
>  def add_file(data):
>      settings.readfp(io.StringIO(data))
> =20
> +def add_section(name):
> +    settings.add_section(name)
> +
>  def get_items(section):
>      """Get the items from a section of the config.
> =20
> diff --git a/tools/buildman/builder.py b/tools/buildman/builder.py
> index f35175b4598..7c563cddada 100644
> --- a/tools/buildman/builder.py
> +++ b/tools/buildman/builder.py
> @@ -255,7 +255,7 @@ class Builder:
> =20
>      def __init__(self, toolchains, base_dir, git_dir, num_threads, num_j=
obs,
>                   gnu_make=3D'make', checkout=3DTrue, show_unknown=3DTrue=
, step=3D1,
> -                 no_subdirs=3DFalse, full_path=3DFalse, verbose_build=3D=
False,
> +                 no_subdirs=3DFalse, verbose_build=3DFalse,
>                   mrproper=3DFalse, per_board_out_dir=3DFalse,
>                   config_only=3DFalse, squash_config_y=3DFalse,
>                   warnings_as_errors=3DFalse, work_in_output=3DFalse,
> @@ -279,8 +279,6 @@ class Builder:
>              step: 1 to process every commit, n to process every nth comm=
it
>              no_subdirs: Don't create subdirectories when building curren=
t
>                  source for a single board
> -            full_path: Return the full path in CROSS_COMPILE and don't s=
et
> -                PATH
>              verbose_build: Run build with V=3D1 and don't use 'make -s'
>              mrproper: Always run 'make mrproper' when configuring
>              per_board_out_dir: Build in a separate persistent directory =
per
> @@ -336,7 +334,6 @@ class Builder:
>          self._step =3D step
>          self._error_lines =3D 0
>          self.no_subdirs =3D no_subdirs
> -        self.full_path =3D full_path
>          self.verbose_build =3D verbose_build
>          self.config_only =3D config_only
>          self.squash_config_y =3D squash_config_y
> diff --git a/tools/buildman/builderthread.py b/tools/buildman/builderthre=
ad.py
> index a8599c0bb2a..c23c3254d2d 100644
> --- a/tools/buildman/builderthread.py
> +++ b/tools/buildman/builderthread.py
> @@ -404,7 +404,7 @@ class BuilderThread(threading.Thread):
>                      the next incremental build
>          """
>          # Set up the environment and command line
> -        env =3D self.toolchain.MakeEnvironment(self.builder.full_path)
> +        env =3D self.toolchain.MakeEnvironment()
>          mkdir(out_dir)
> =20
>          args, cwd, src_dir =3D self._build_args(brd, out_dir, out_rel_di=
r,
> @@ -569,7 +569,7 @@ class BuilderThread(threading.Thread):
>                  outf.write(f'{result.return_code}')
> =20
>              # Write out the image and function size information and an o=
bjdump
> -            env =3D result.toolchain.MakeEnvironment(self.builder.full_p=
ath)
> +            env =3D result.toolchain.MakeEnvironment()
>              with open(os.path.join(build_dir, 'out-env'), 'wb') as outf:
>                  for var in sorted(env.keys()):
>                      outf.write(b'%s=3D"%s"' % (var, env[var]))
> diff --git a/tools/buildman/cmdline.py b/tools/buildman/cmdline.py
> index 03211bd5aa5..5fda90508f2 100644
> --- a/tools/buildman/cmdline.py
> +++ b/tools/buildman/cmdline.py
> @@ -121,8 +121,6 @@ def add_after_m(parser):
>            help=3D"Override host toochain to use for sandbox (e.g. 'clang=
-7')")
>      parser.add_argument('-Q', '--quick', action=3D'store_true',
>            default=3DFalse, help=3D'Do a rough build, with limited warnin=
g resolution')
> -    parser.add_argument('-p', '--full-path', action=3D'store_true',
> -          default=3DFalse, help=3D"Use full toolchain path in CROSS_COMP=
ILE")
>      parser.add_argument('-P', '--per-board-out-dir', action=3D'store_tru=
e',
>            default=3DFalse, help=3D"Use an O=3D (output) directory per bo=
ard rather than per thread")
>      parser.add_argument('--print-arch', action=3D'store_true',
> diff --git a/tools/buildman/control.py b/tools/buildman/control.py
> index 8f6850c5211..3ca9e2e8761 100644
> --- a/tools/buildman/control.py
> +++ b/tools/buildman/control.py
> @@ -653,10 +653,8 @@ def do_buildman(args, toolchains=3DNone, make_func=
=3DNone, brds=3DNone,
>      builder =3D Builder(toolchains, output_dir, git_dir,
>              args.threads, args.jobs, checkout=3DTrue,
>              show_unknown=3Dargs.show_unknown, step=3Dargs.step,
> -            no_subdirs=3Dargs.no_subdirs, full_path=3Dargs.full_path,
> -            verbose_build=3Dargs.verbose_build,
> -            mrproper=3Dargs.mrproper,
> -            per_board_out_dir=3Dargs.per_board_out_dir,
> +            no_subdirs=3Dargs.no_subdirs, verbose_build=3Dargs.verbose_b=
uild,
> +            mrproper=3Dargs.mrproper, per_board_out_dir=3Dargs.per_board=
_out_dir,
>              config_only=3Dargs.config_only,
>              squash_config_y=3Dnot args.preserve_config_y,
>              warnings_as_errors=3Dargs.warnings_as_errors,
> diff --git a/tools/buildman/test.py b/tools/buildman/test.py
> index f92add7a7c5..ae9963eed4f 100644
> --- a/tools/buildman/test.py
> +++ b/tools/buildman/test.py
> @@ -146,6 +146,7 @@ class TestBuild(unittest.TestCase):
>          self.toolchains.Add('arm-linux-gcc', test=3DFalse)
>          self.toolchains.Add('sparc-linux-gcc', test=3DFalse)
>          self.toolchains.Add('powerpc-linux-gcc', test=3DFalse)
> +        self.toolchains.Add('/path/to/aarch64-linux-gcc', test=3DFalse)

Sorry Simon, but me and others love to be consistent.

Best regards,
Andrejs.

>          self.toolchains.Add('gcc', test=3DFalse)
> =20
>          # Avoid sending any output
> @@ -747,6 +748,80 @@ class TestBuild(unittest.TestCase):
>          self.assertEqual([
>              ['MARY=3D"mary"', 'Missing expected line: CONFIG_MARY=3D"mar=
y"']], result)
> =20
> +    def call_make_environment(self, tchn, in_env=3DNone):
> +        """Call Toolchain.MakeEnvironment() and process the result
> +
> +        Args:
> +            tchn (Toolchain): Toolchain to use
> +            in_env (dict): Input environment to use, None to use current=
 env
> +
> +        Returns:
> +            tuple:
> +                dict: Changes that MakeEnvironment has made to the envir=
onment
> +                    key: Environment variable that was changed
> +                    value: New value (for PATH this only includes compon=
ents
> +                        which were added)
> +                str: Full value of the new PATH variable
> +        """
> +        env =3D tchn.MakeEnvironment(env=3Din_env)
> +
> +        # Get the original environment
> +        orig_env =3D dict(os.environb if in_env is None else in_env)
> +        orig_path =3D orig_env[b'PATH'].split(b':')
> +
> +        # Find new variables
> +        diff =3D dict((k, env[k]) for k in env if orig_env.get(k) !=3D e=
nv[k])
> +
> +        # Find new / different path components
> +        diff_path =3D None
> +        new_path =3D None
> +        if b'PATH' in diff:
> +            new_path =3D diff[b'PATH'].split(b':')
> +            diff_paths =3D [p for p in new_path if p not in orig_path]
> +            diff_path =3D b':'.join(p for p in new_path if p not in orig=
_path)
> +            if diff_path:
> +                diff[b'PATH'] =3D diff_path
> +            else:
> +                del diff[b'PATH']
> +        return diff, new_path
> +
> +    def test_toolchain_env(self):
> +        """Test PATH and other environment settings for toolchains"""
> +        # Use a toolchain which has a path
> +        tchn =3D self.toolchains.Select('aarch64')
> +
> +        # Normal case
> +        diff =3D self.call_make_environment(tchn)[0]
> +        self.assertEqual(
> +            {b'CROSS_COMPILE': b'/path/to/aarch64-linux-', b'LC_ALL': b'=
C'},
> +            diff)
> +
> +        # When overriding the toolchain, only LC_ALL should be set
> +        tchn.override_toolchain =3D True
> +        diff =3D self.call_make_environment(tchn)[0]
> +        self.assertEqual({b'LC_ALL': b'C'}, diff)
> +
> +        # Test that virtualenv is handled correctly
> +        tchn.override_toolchain =3D False
> +        sys.prefix =3D '/some/venv'
> +        env =3D dict(os.environb)
> +        env[b'PATH'] =3D b'/some/venv/bin:other/things'
> +        tchn.path =3D '/my/path'
> +        diff, diff_path =3D self.call_make_environment(tchn, env)
> +
> +        self.assertNotIn(b'PATH', diff)
> +        self.assertEqual(None, diff_path)
> +        self.assertEqual(
> +            {b'CROSS_COMPILE': b'/my/path/aarch64-linux-', b'LC_ALL': b'=
C'},
> +            diff)
> +
> +        # Handle a toolchain wrapper
> +        tchn.path =3D ''
> +        bsettings.add_section('toolchain-wrapper')
> +        bsettings.set_item('toolchain-wrapper', 'my-wrapper', 'fred')
> +        diff =3D self.call_make_environment(tchn)[0]
> +        self.assertEqual(
> +            {b'CROSS_COMPILE': b'fred aarch64-linux-', b'LC_ALL': b'C'},=
 diff)
> =20
>  if __name__ =3D=3D "__main__":
>      unittest.main()
> diff --git a/tools/buildman/toolchain.py b/tools/buildman/toolchain.py
> index 324ad0e0821..739acf3ec53 100644
> --- a/tools/buildman/toolchain.py
> +++ b/tools/buildman/toolchain.py
> @@ -90,7 +90,7 @@ class Toolchain:
>          if self.arch =3D=3D 'sandbox' and override_toolchain:
>              self.gcc =3D override_toolchain
> =20
> -        env =3D self.MakeEnvironment(False)
> +        env =3D self.MakeEnvironment()
> =20
>          # As a basic sanity check, run the C compiler with --version
>          cmd =3D [fname, '--version']
> @@ -172,7 +172,7 @@ class Toolchain:
>          else:
>              raise ValueError('Unknown arg to GetEnvArgs (%d)' % which)
> =20
> -    def MakeEnvironment(self, full_path):
> +    def MakeEnvironment(self, env=3DNone):
>          """Returns an environment for using the toolchain.
> =20
>          This takes the current environment and adds CROSS_COMPILE so tha=
t
> @@ -188,25 +188,23 @@ class Toolchain:
>               569-570: surrogates not allowed
> =20
>          Args:
> -            full_path: Return the full path in CROSS_COMPILE and don't s=
et
> -                PATH
> +            env (dict of bytes): Original environment, used for testing
> +
>          Returns:
>              Dict containing the (bytes) environment to use. This is base=
d on the
> -            current environment, with changes as needed to CROSS_COMPILE=
, PATH
> -            and LC_ALL.
> +            current environment, with changes as needed to CROSS_COMPILE=
 and
> +            LC_ALL.
>          """
> -        env =3D dict(os.environb)
> +        env =3D dict(env or os.environb)
> +
>          wrapper =3D self.GetWrapper()
> =20
>          if self.override_toolchain:
>              # We'll use MakeArgs() to provide this
>              pass
> -        elif full_path:
> +        else:
>              env[b'CROSS_COMPILE'] =3D tools.to_bytes(
>                  wrapper + os.path.join(self.path, self.cross))
> -        else:
> -            env[b'CROSS_COMPILE'] =3D tools.to_bytes(wrapper + self.cros=
s)
> -            env[b'PATH'] =3D tools.to_bytes(self.path) + b':' + env[b'PA=
TH']
> =20
>          env[b'LC_ALL'] =3D b'C'
> =20
> --=20
> 2.34.1
>=20

