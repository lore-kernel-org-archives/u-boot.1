Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D33BCD5BAC
	for <u-boot@archiver.kernel.org>; Sat, 23 May 2026 09:22:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E7DD846FA;
	Sat, 23 May 2026 11:22:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="O+Uymit2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DF6B84704; Sat, 23 May 2026 11:22:30 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FAC2846AD
 for <u-boot@lists.denx.de>; Sat, 23 May 2026 11:22:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-bd22b2abaa4so1353064466b.0
 for <u-boot@lists.denx.de>; Sat, 23 May 2026 02:22:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779528148; cv=none;
 d=google.com; s=arc-20240605;
 b=L3I40gOPaG3ratqiS0Osy3KTKrPPUuRANNK7UFLH4Co+CEzULWS5lX9srALW2VKbT6
 HNKs+Oq/y3nKCJZGZxtHw6QKnrhSzRH4wzSGvEBjJ8tFq6UXw6ST/TVyqzV9YzTTWD91
 EuAWPHbq26t5Hk6f9rREE6c+Hg/HMGwBVizyohjqwZmFmxDJlwKC8rRH28cYYON9wwNw
 muuolkN85Ntm+CwS78lh12v2wI0SXcUd0CIlg3ZGRLJZWZz1bkNlLIA+jeHkrPBRSDOJ
 iZ53ElsgUjiDHqE+xw7y88QeYdKByEApX65t3XTyQW0Xm6k5lMf6srP0rKQWBa4UEJk0
 3bTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=xh7wRtFaL9/iUp73gwF5Bw9/Yx4X+wOrV03CwCH4aaM=;
 fh=BTFB4szhANUdeKdGhUtFNOkjp2T4RwfYw5Yk7MO0OCE=;
 b=DRB1hfFbpAKLLnzkus7rQMWiP1XI9Jm3m26OTiUXtWikqQkI4OpYz0FmpJgx/GPOaD
 WwEVTsqsTAnZafEUp+6R7YHgmSWaIg9FdkLKZyQNTOJk8tGcH71xdxHgqZKzmPUmk46t
 mgsXYFdUfcMowugj2GnQ6jMORefmRgnRA1yYn+Ej6+d3smNM7dkM8NCuyo6bjUnwiPXZ
 0acwvVlbpVD84jfeQ3FzhgB9Od41Lbc7opXnxE8bmsZDiQlHktO1OHZAR2hr6u9HaasJ
 il10/OrvvhPA0E+IS5dC29lcKMr9+MN6XQBRmT3WHHEnhye1AwFI6BQ2x/kSpm/YdPxu
 bK+Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779528148; x=1780132948; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xh7wRtFaL9/iUp73gwF5Bw9/Yx4X+wOrV03CwCH4aaM=;
 b=O+Uymit2a7ZazZsVMk5hbOj8Z2u9BHnr9quMU3GpNXekMa0ZxBsgjXzCEvLmKBjlGq
 VLLbfSFA2GWO8MBSbBAg3pZU/DBcNBopWwaK2NHk8clpln19PpI88Ufrmq8kD48h51u7
 s8Ssoy/gzuFhX7P9TKc/9FP3otQVzOjuYNuto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779528148; x=1780132948;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xh7wRtFaL9/iUp73gwF5Bw9/Yx4X+wOrV03CwCH4aaM=;
 b=Dwv6idSZwWixAMtLVb/Lx+yJNNSuITtQF4GQ9i+/Ot+rLC2pn6ykmVmCM8sqmhJPIu
 PTccpgbTTC5Uf+5DkbcpKUBqz05BVPGmzcEYuUWCmhEXCFmDndmFaZ+731nJCvBM1yBH
 yte/Kmq32tM4K88pSPBjY9Q7DcZcoduRjOhjNSk9O+m696692VgASsb6163fDcVMNjiV
 zHB2PEippeMKTVumo8ftXvITCzP1e1StyccXkeQEld3xzXU6JiPBs2MQmnSH1h8O03Ws
 +yXjgxETTGUfzbyBmseiO36fbreTa5ddRotzFHlYHzCAZVszSr+AhXVDEWNb2Wotte2J
 PvzQ==
X-Gm-Message-State: AOJu0YxWjD+g2hZs/KqPHgR4lIIrmUCJA8JDZS2jyvAYocbhFAVEctTv
 baymXNnmKbmWNFVgqjpIPNbBxcXSFzN/fZj5bx2jofPy4M1Zps3mR3G7KuN2oQOWmarQZ77FWYW
 IKPvLv4Lps09dFFpjATVBkOeHZzoisOQPrW4AWNmL05GKl0tZE0c=
X-Gm-Gg: Acq92OFgPyk1tU8ukG3kMbIUeSYu0wOR7JE4ugw2ahc4Lf82TUBcL/V4/paPFCkxRSj
 f5H2kq65lOQYLwHd6ihLMwboDUAiGfolNYlXo5+FS8JuPZh6cJ4QXqo3TI2KNH1xOS+2Na/X4Cx
 PVm8BXiTuBap8Woxj6JDnE8gIEhLLyPj9nBozGM4gWIEwOglZNiP/6I+MARY9T098Cl63V1UsMF
 neAm/piSpK4456S76bT0WEvFVDvqaTJF+cHes5CMdtge84PO5xqMwP6aN8PpVjB2sb8qa5NOisO
 ikfNsSDvyd7yDXzSDIiHD6lux5o=
X-Received: by 2002:a17:907:c317:b0:bda:d08:35ea with SMTP id
 a640c23a62f3a-bdd283a64bdmr448700666b.48.1779528147687; Sat, 23 May 2026
 02:22:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260513141027.351280-1-ludwig.nussel@siemens.com>
 <CAFLszTifT1G2XwBvvTZPtrsBM47Y-DD1GFn8rx=ieRcTFHaN4g@mail.gmail.com>
 <58360478-3c15-4c1f-ad4c-c5ce25ea2b82@siemens.com>
In-Reply-To: <58360478-3c15-4c1f-ad4c-c5ce25ea2b82@siemens.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 23 May 2026 03:22:14 -0600
X-Gm-Features: AVHnY4KJUpxR6QE7nM7NgNtoV-UOn2tkGEGKxFm0nWdiFQDRc4nIf6finsu4KEE
Message-ID: <CAFLszThohFGs=27jQKNrKL5Whv7jXXBpNpWZi4wDxxbP3NzJwA@mail.gmail.com>
Subject: Re: [v4,0/6] Improve FIT signature handling
To: Ludwig Nussel <ludwig.nussel@siemens.com>
Cc: u-boot@lists.denx.de
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

Hi Ludwig,

On Mon, 18 May 2026 at 10:07, Ludwig Nussel <ludwig.nussel@siemens.com> wrote:
>
> On 5/15/26 15:41, Simon Glass wrote:
> > Hi Ludwig,
> >
> > On 2026-05-13T14:08:10, Ludwig Nussel <ludwig.nussel@siemens.com> wrote:
> >
> >> The tests were created with the help of copilot and manual fixups. I
> >> have to admit that the log output of those tests is not something I can
> >> grok. I've left the tags copilot added in the commits even though
> >> checkpatch complains. Not sure what the policy is.
> >
> > Thanks for being upfront. For my work I have adjusted patman to drop these tags.
> >
> > The "log output I can't grok" part worries me more than the tag. If
> > you can't follow what the test is exercising, neither can the next
> > person debugging a failure :-)
>
> Meanwhile I got it. The AI helped me to get started.
> Anyway, here is what confused me. Suppose we introduce a small typo:
> -                      'No signature node found', False)
> +                      'No signature node fond', False)
>
> Then run
> $ test/py/test.py --bd sandbox "$@" -k 'test_vboot -vvx
>
> You'll get a dump of all kinds of irrelevant things like openssl key
> generation or u-boot startup. Then finally:
>
> FAILED
> test/py/tests/test_vboot.py::test_vboot[sha1-basic-sha1--None-False-True-False-False]
> - assert 'No signature node fond' in "1769 bytes read in 0 msWorking FDT
> set to 100image_pre_load_sig_setup() INFO: no info for image pre-load
> sig check\r\r\n## Loading kernel (any) from FIT Image at 00000100
> ...\r\r\n   Using 'conf-1' configuration\r\r\n   Verifying Hash
> Integrity ... fit_config_verify_required_keys() No signature node found:
> FDT_ERR_NOTFOUND\r\r\nBad Data Hash\r\r\nERROR -2: No such file or
> directory: can't get kernel image!"
>   +  where "1769 bytes read in 0 msWorking FDT set to
> 100image_pre_load_sig_setup() INFO: no info for image pre-load sig
> check\r\r\n## Loading kernel (any) from FIT Image at 00000100 ...\r\r\n
>   Using 'conf-1' configuration\r\r\n   Verifying Hash Integrity ...
> fit_config_verify_required_keys() No signature node found:
> FDT_ERR_NOTFOUND\r\r\nBad Data Hash\r\r\nERROR -2: No such file or
> directory: can't get kernel image!" = <built-in method join of str
> object at 0xa46de8>(['1769 bytes read in 0 ms', 'Working FDT set to
> 100', "image_pre_load_sig_setup() INFO: no info for image pre-load sig
> check\r\r\n## Loading kernel (any) from FIT Image at 00000100 ...\r\r\n
>   Using 'conf-1' configuration\r\r\n   Verifying Hash Integrity ...
> fit_config_verify_required_keys() No signature node found:
> FDT_ERR_NOTFOUND\r\r\nBad Data Hash\r\r\nERROR -2: No such file or
> directory: can't get kernel image!"])
>   +    where <built-in method join of str object at 0xa46de8> = ''.join
>
> To my untrained eyes that just looks like a lot of garbage :-)
> To find the failing line of code you have to scroll back to the actual
> backtrace. Now in this example it's kind of easy as we know what we
> broke. If u-boot produces different output for some reason (like my
> patches) I found it really hard to spot what's wrong in all the noise.

Yes I agree this is quite tricky. Part of this is pytest trying to be
helpful, but I'm sure we can improve it.

>
> The parametrized test_vboot function doesn't make it easier either, esp
> since some of the parameters select an entirely different set of tests
> (test_global_sign/test_required_key/test_with_algo).

>
> The ubman.log.* calls would explain some context and progress but are
> not in the console, only in the html. The HTML could be more useful due
> to the structuring but isn't as the distracting stuff is on the same
> level as the actual tests. All output leading up to the failure gets
> displayed by the js but the relevant output that is actually looked at
> by assert() is in just one line.
>
> Last but not least even if the presentation of all this information was
> improved, there's still some information about the good case missing. Ie
> what did the output look like when the test was written?

The split between console and html bugs me, too. Thanks for looking at this.

Regards,
Simon
