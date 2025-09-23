Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8841CAC5AC
	for <u-boot@archiver.kernel.org>; Tue, 23 Sep 2025 18:33:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B63B6833ED;
	Tue, 23 Sep 2025 20:32:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bekwJEP0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61398833E9; Tue, 23 Sep 2025 20:32:58 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67634833E9
 for <u-boot@lists.denx.de>; Tue, 23 Sep 2025 20:32:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-631787faf35so6252701a12.3
 for <u-boot@lists.denx.de>; Tue, 23 Sep 2025 11:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1758652374; x=1759257174; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XBQSyiTFwa9ELiJTe/gpdGoQOIAsDtnxEBC3snkfV6U=;
 b=bekwJEP06E+LtYyVtiqqI6fiDLF3+ZNPcBYDwaslNZ773R8PPQfJ2a9x8sg/L/kjh8
 r1HBkVdW2BnTRdcLMbUhfDdhfnGYNMLGtKrtP16MaKqVQwkrES3ii4r/nN5bPHWQ+oFm
 1jt72jnIqWD2CaohNrHpvil8a1ovsBKaqOAZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758652374; x=1759257174;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XBQSyiTFwa9ELiJTe/gpdGoQOIAsDtnxEBC3snkfV6U=;
 b=QuNcoGx1kWWCdPD58niBq+6Lf2oLveeKQX6yeddinB2khmFZzwHDr2ilmwS6jtfo+n
 DnB07vsKuWxEvdFfRhyyqte8ACuLp0cGsCaqersQ5377NFH+2oDqkqEX4+gh7Rd6q6oX
 aAwJM2nu+V8sVQ0rQWIZRXHB8Wyr3vLH97D8YXKLBysNORFmOVl99NXiKOK2OQyh1xGE
 azvavxyF2CnRfGhzSlhA3Nold8DShowsXWoowCVztbL0h4IGrcqQCjZeHb3k/hu4liS/
 nCe7bb748hTh9ScHsG8JVxyLDGlX+fbhwnurGNOdPP7IGkXy/dB6PWAdQ8V9uHLSY421
 drgw==
X-Gm-Message-State: AOJu0YyZDcRrDZOpNeWkyYgfCqWC8rqldcJ9dsTcnGcUBq7LLnilztZ6
 Dusr7amgi5q3vMQVIwN+UxNyI/Xcx72r5PIyD1+xWD7ASCbOLIRVRvcwDQ1lfUQNSfMA0iLXOgp
 l2coPO3SuzAbn7URcaPKjowmW8JpQzt+ponQ3J/aN4r3BJbGj3Wl/8Q==
X-Gm-Gg: ASbGnct55KWPaF+lDoi8+YhpfmxNucCR+OQsagkVBmz4OcxucA6tjH7IfYyiHxJWv2P
 cc95LHfcRSATacwSgeFwRabg9IfTdMLadZIbe9brgstitii1vhPYk57cdLVMybchnIcwmXgws4l
 RcbpWLjwGuLpXVpOJZ8HrYG7m4MmepgcldZPJ0vvJeV+0pvtnDkI9p9Sw/CShfu4KsFNGvv2XYL
 DTGfQ==
X-Google-Smtp-Source: AGHT+IGfDND6dwBobc4p3118UEUaU+SP6i9s4p1IP2sAOcE75OIIae3DDE/Waw+bjEDe5niA/O+F7okd+IBKAtVq8Jw=
X-Received: by 2002:a17:907:7f92:b0:b29:1c4b:3d4e with SMTP id
 a640c23a62f3a-b3027a49e67mr336771866b.28.1758652374189; Tue, 23 Sep 2025
 11:32:54 -0700 (PDT)
MIME-Version: 1.0
References: <20250923183053.786043-1-sjg@u-boot.org>
 <20250923183053.786043-2-sjg@u-boot.org>
In-Reply-To: <20250923183053.786043-2-sjg@u-boot.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 23 Sep 2025 12:32:35 -0600
X-Gm-Features: AS18NWCMuelTwAKbiddfTnFfePH6vmocFRCEiVYRTYoEFcQ0Z7942VJZlvZb16g
Message-ID: <CAFLszTjaywLVSv+nfFOjUkj_ARP7AGZ61B5urrEtotR+ChML4Q@mail.gmail.com>
Subject: Re: [PATCH 2/4] scripts: Update build-efi/qemu to support disabling
 pager
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
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

Hi,

Sorry for the noise, please ignore this patch.

Regards,
SImon


On Tue, 23 Sept 2025 at 12:31, Simon Glass <sjg@u-boot.org> wrote:
>
> From: Simon Glass <sjg@chromium.org>
>
> The pager can interfere with tests and there is a lab test which uses
> the build-efi script. Add an option to disable the pager so that the
> labgrid test can request that.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
>  scripts/build-efi       | 3 ++-
>  scripts/build-qemu      | 2 ++
>  scripts/build_helper.py | 2 ++
>  3 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/build-efi b/scripts/build-efi
> index 131aad50897..27446295b2d 100755
> --- a/scripts/build-efi
> +++ b/scripts/build-efi
> @@ -155,7 +155,8 @@ class BuildEfi:
>
>      def do_build(self, build):
>          """Build U-Boot for the selected board"""
> -        res = command.run_one('buildman', '-w', '-o', self.build_dir,
> +        extra = ['-a', '~CONSOLE_PAGER'] if self.args.no_pager else []
> +        res = command.run_one('buildman', '-w', '-o', self.build_dir, *extra,
>                                '--board', build, '-I', raise_on_error=False)
>          if res.return_code and res.return_code != 101:  # Allow warnings
>              raise ValueError(
> diff --git a/scripts/build-qemu b/scripts/build-qemu
> index 62f0bc41fad..522325a8d57 100755
> --- a/scripts/build-qemu
> +++ b/scripts/build-qemu
> @@ -200,6 +200,8 @@ class BuildQemu:
>          self.build_dir.mkdir(parents=True, exist_ok=True)
>          cmd = ['buildman', '-w', '-o', str(self.build_dir), '--board',
>                 self.board, '-I']
> +        if self.args.no_pager:
> +            cmd += ['-a', '~CONSOLE_PAGER']
>
>          self.execute_command(
>              cmd,
> diff --git a/scripts/build_helper.py b/scripts/build_helper.py
> index 21162e5643e..d401da0215c 100644
> --- a/scripts/build_helper.py
> +++ b/scripts/build_helper.py
> @@ -301,6 +301,8 @@ def add_common_args(parser):
>          help='Use KVM (Kernel-based Virtual Machine) for acceleration')
>      parser.add_argument('-K', '--kernel',
>                          help='Kernel to run using -kernel')
> +    parser.add_argument('-n', '--no-pager', action='store_true',
> +                        help="Disable the pager (for testing)")
>      parser.add_argument('-o', '--os', metavar='NAME', choices=['ubuntu'],
>                          help='Run a specified Operating System')
>      parser.add_argument('-r', '--run', action='store_true',
> --
> 2.43.0
>
> base-commit: 136c959dd2d089710fb131956081d09b9da3bea4
> branch: labh
