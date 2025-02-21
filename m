Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9911FC021B5
	for <u-boot@archiver.kernel.org>; Fri, 21 Feb 2025 23:42:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27EBC80F53;
	Sat, 22 Feb 2025 00:42:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="J3+bwCoH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26A6A80F56; Sat, 22 Feb 2025 00:42:24 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 978B9806FE
 for <u-boot@lists.denx.de>; Sat, 22 Feb 2025 00:42:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-aaf900cc7fbso404685266b.3
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 15:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740181341; x=1740786141; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bPdOi/8h0EIQtu/wX9pCocdIYWF8ftOF0Gsk0wKHxas=;
 b=J3+bwCoHlKl8E02Xprgo5ENWcoqDBwgNhuHUcoSBDIch3SUDpHyStAyhyhMreyqIIJ
 pDsW0o2iOPwGGg2r3spkARMYkKLThnMM+fB1wvRpuL8bK5491GORHTQVsA2vr7meZVuv
 GBKlhW/NJnifdfs1zAkVzDgGStYlDhPqW3VMA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740181341; x=1740786141;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bPdOi/8h0EIQtu/wX9pCocdIYWF8ftOF0Gsk0wKHxas=;
 b=DkDrBLMTZcvsigVip78ukZSXXXVfGvBlAGkV+Miru6DtaTH13Uignco0LAAD0F6Lae
 rgm0WUCV4KBDeIYJWck81ziaRj604VdGaCC9mp56IFQQvIr+ygEulUwR6/S3rT2kg/8u
 W4Fi6A3fLgaumvaUJ3GNa3rOBOTQwEdsJ6XDndXZFg344gejFXL3KIETXV/UTZeocB4e
 wT0WEiNmUXD76mEeI0z48QyZaaqC2MdXEJOQozbdegkWAIKU+eCn+y69O5A+Q0DgKX0+
 hyY0iN154JjrZJ+kibi0jd5ZOnpPw53P1coOmB+lmjfQxVmOYvbnfkNBTJ+YZ4O6Rum0
 ZBlw==
X-Gm-Message-State: AOJu0Ywr3epGTaiZYd0XcV+dW9s3a5kHDgEN6H3huBZ+PhGSWUZIeShP
 FjUqIK+Ft8aG2J43PvTtRBHY6sBNPhR9gIe87s0Adsg/lPEdbQyo/S9qGdRT9Nhp50eDfgRzgPc
 zLRSCJhOkkiN1qlf118meNXbdRwd9+F28CyOe
X-Gm-Gg: ASbGncsXkUpcDnTCxTxqrxqjqTDDzIDNn1cQKDUqJ+nkXaqRyidaFTvrNp38MwXnRGZ
 Rjoc9YHelxngn+BuRYTvCIe5meRkIbKgFwpdhJ+0NHW4tttOfck282NUAwLrf/eqykbnVGDxaJn
 Rwph/ux7Zh
X-Google-Smtp-Source: AGHT+IHb2M3Z5hCuqoJWO4qrhOSOFbQEbui4/ADJ8AQkuh7jRg8UTWR168vohVT1drKEak5lRFcC/RwAY2SMAUVCg/U=
X-Received: by 2002:a17:907:7705:b0:ab3:4b0c:ea44 with SMTP id
 a640c23a62f3a-abc0d97c783mr391099866b.9.1740181340972; Fri, 21 Feb 2025
 15:42:20 -0800 (PST)
MIME-Version: 1.0
References: <20250210162518.GA2902864@bill-the-cat>
 <CAFLszTidZzhttm99Eafxwp2y-61yhY+0o5OWmfwowKNC+nQtZw@mail.gmail.com>
 <20250215144147.GM1233568@bill-the-cat>
 <CAFLszTi3D4g5LadMvaxEAn3uUu2V5L1wKCEBLu8=dzicb0Rbww@mail.gmail.com>
 <20250215181227.GT1233568@bill-the-cat>
 <CAFLszThJ11Ph-8zaNV_D0u7-UD18XtULm0kwhgQmMAj5xFgHtA@mail.gmail.com>
 <20250216160744.GA1233568@bill-the-cat>
 <CAFLszTiihyuqFBcdacu+2wfd3ivDzjf4nVqfU0BgKUc0u1s6=Q@mail.gmail.com>
 <20250216215230.GE1233568@bill-the-cat>
 <CAFLszTiydBJ8BseNHNJO+tf21QwPSJ-Od1Jnp6QWUTsPOmgFdg@mail.gmail.com>
 <20250217141409.GJ1233568@bill-the-cat>
In-Reply-To: <20250217141409.GJ1233568@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 21 Feb 2025 16:42:09 -0700
X-Gm-Features: AWEUYZnNnDLYMBkxd4e0mf3mPMgi45fgVrtTRsvfkHGJENTXPkp3LdOb_okE3RQ
Message-ID: <CAFLszTij+suCqQ+c0bmTEsHEu6+xUWWCMEG-gJ5DYbjhv0oJGg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] CI: Move default image under global defaults
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Tom,

On Mon, 17 Feb 2025 at 07:14, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Feb 17, 2025 at 06:14:06AM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Sun, 16 Feb 2025 at 14:52, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Sun, Feb 16, 2025 at 12:39:34PM -0700, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Sun, 16 Feb 2025 at 09:07, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Sun, Feb 16, 2025 at 07:10:12AM -0700, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Sat, 15 Feb 2025 at 11:12, Tom Rini <trini@konsulko.com> wrote:
> > > > > > >
> > > > > > > On Sat, Feb 15, 2025 at 10:21:16AM -0700, Simon Glass wrote:
> > > > > > > > Hi Tom,
> > > > > > > >
> > > > > > > > On Sat, 15 Feb 2025 at 07:41, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > >
> > > > > > > > > On Sat, Feb 15, 2025 at 04:59:40AM -0700, Simon Glass wrote:
> > > > > > > > > > Hi Tom,
> > > > > > > > > >
> > > > > > > > > > On Mon, 10 Feb 2025 at 09:25, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Thu, Feb 06, 2025 at 03:38:55PM -0700, Simon Glass wrote:
> > > > > > > > > > >
> > > > > > > > > > > > This is a global default, so put it under 'default' like the tags.
> > > > > > > > > > > >
> > > > > > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > > > > > Suggested-by: Tom Rini <trini@konsulko.com>
> > > > > > > > > > > > Reviewed-by: Tom Rini <trini@konsulko.com>
> > > > > > > > > > >
> > > > > > > > > > > Please make v4 include the way you redid the second patch and be on top
> > > > > > > > > > > of mainline, thanks.
> > > > > > > > > >
> > > > > > > > > > That's enough versions for me, so I'll let you do that, if you'd like.
> > > > > > > > > > It probably doesn't affect your tree as not as much is done in
> > > > > > > > > > parallel.
> > > > > > > > >
> > > > > > > > > I am disappointed.
> > > > > > > >
> > > > > > > > I'm sorry to disappoint you.
> > > > > > > >
> > > > > > > > The background is that I looked at the difference between our trees
> > > > > > > > and the gitlab files are quite different. My CI runs take about 35
> > > > > > > > mins and it seems that yours is around 90 mins. I would like to reduce
> > > > > > > > / remove the delta (for time and patch diff), but I'm not sure how.
> > > > > > > >
> > > > > > > > My goal is to get CI runs to below 20 minutes, best case.
> > > > > > >
> > > > > > > I'm sure CI could be quicker still with a number of faster runners. But
> > > > > > > if you can't be bothered to make changes against mainline, what is the
> > > > > > > point?
> > > > > >
> > > > > > If you recall, I was working with your tree and had various ideas to
> > > > > > speed things up, but you didn't like it. So I've had to do it in my
> > > > > > tree. This is not about more runners (although I might have another
> > > > > > one soon). It is about running jobs in parallel.
> > > > >
> > > > > And I wasn't sure more runners in parallel would help (as it would slow
> > > > > down the fast runner which is what keeps the long jobs from being even
> > > > > longer) as much as adding more regular runners would (which we've done)
> > > > > and noted that in the end it's a configuration on the runner side so to
> > > > > go ahead. And I reviewed and ack'd the patches here which exposed the
> > > > > issues your path revealed. I just can't apply them because they need to
> > > > > be rebased (and squashed).
> > > >
> > > > You have already added tags for things, but (IIUC) they are around the
> > > > other way from what I have added.
> > > >
> > > > I have a tag called 'single' which means that the machine is only
> > > > allowed to one of those jobs. The world-build jobs are marked with
> > > > 'single'.
> > > >
> > > > For other jobs, I allow the runners to pick up some in parallel
> > > > depending on their performance (for moa and tui that is 10).
> > > >
> > > > So at most, there is a 'world build' and 10 test.py jobs running on
> > > > the same machine. It seems to work fine in practice, although I would
> > > > rather be able to make these two types of jobs mutually exclusive, so
> > > > that a runner is either running 10 parallel jobs or 1 'single' job,
> > > > but not both. I'm not sure how to do that.
> > >
> > > So unless I'm missing something, in both cases the bottleneck is that
> > > for world build jobs you don't want anything else going on with the
> > > underlying build host. You could register 10 "all" runners and 1 "fast
> > > amd64" runner (and something similar but smaller for alexandra). If you
> > > update the registrations on source.denx.de can you then shut down your
> > > gitlab instance?
> >
> > I've put a tag of 'single' on things that should run on the single-job
> > runner. Everything else can run concurrently, e.g. up to 10 jobs. So I
> > have two runners on the same host. E.g. tui-single has 'limit = 1',
> > but 'tui' has no limit and is just governed by the 'concurrent = 10'
> > at the top of the file.
>
> Yes. And you could move those runners to the mainline gitlab. There is
> no "single" tag, that would be the "all" tag. And "tui-single" would be
> "fast amd64".

They are still attached to the Denx gitlab. Nothing has changed on my
side. I'm not sure that your new tags are working though. I have a
feeling something broke along the way when you made all your tag
changes. One of my servers makes a bit of noise and I haven't heard it
in quite a while.

If Denx would like to give me access to their gitlab instances, I'd be
happy to play around and figure out how to get it going as fast as my
tree does, and send a patch.

I also have another runner to add.

>
> > From my side, I have found it helpful and refreshing to have a gitlab
> > instance which I can control, e.g. it runs in half the time and if my
> > patches are completely blocked by Linaro, etc., I have an escape
> > valve.
>
> Yes, and I have no idea what any of that has to do with anything other
> than leading to confusion about what tree is or is not mainline. Since
> you own u-boot.org and ci.u-boot.org is your gitlab and
> https://ci.u-boot.org/u-boot/u-boot/ is your personal tree.

For now I am working with my tree, so that I am not blocked by Linaro,
etc. but as you have seen I can rebase series for your tree as needed.

Regards,
Simon
