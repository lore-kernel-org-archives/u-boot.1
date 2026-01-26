Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C71EFD13C09
	for <u-boot@archiver.kernel.org>; Mon, 26 Jan 2026 13:17:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC11A83B27;
	Mon, 26 Jan 2026 14:17:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TodjLesO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5757783B91; Mon, 26 Jan 2026 14:17:29 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0BDD83B0B
 for <u-boot@lists.denx.de>; Mon, 26 Jan 2026 14:17:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 727F8600C3;
 Mon, 26 Jan 2026 13:17:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79187C16AAE;
 Mon, 26 Jan 2026 13:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769433444;
 bh=EjQGpqFwIWtDe5OBO/ho/pt9kYqUfiFw5qi9d7rpa+g=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=TodjLesO5TMs2SK0FYmkAs7g1fI8CyMIG7qBGDey0hqIRfqjP1Ohjy9dSQWRoB960
 YHYaN5/5P67+FaHoiLypoImf4TRNS5Q3ZktZJ9vbcpbiQKGD8R4nSvkwZCTMdt1Is6
 iOG7egtfQex76di/4CHQX1o0jqWFVmyZqucCI/4E6Oi5V/u4e4O0acAXzCoBmxHf4i
 y4Oe2H9Mejt8YZ0fuZkHHBOAVsmUgTWLXucQr+fyNWMHkaBVY2nGpAROPh2xvWxXGF
 GqZBPK42P3V8nJmXz5mrpviRi63RdYASPbZbStzlr0m+9Uko+KSaF4wBELWfl9TrcE
 k/4rYkqR+guvQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Tom Rini <trini@konsulko.com>, Quentin Schulz
 <quentin.schulz@cherry.de>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Casey Connolly <casey.connolly@linaro.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 5/5] doc: develop: process: Document using b4 and
 patchwork for custodians
In-Reply-To: <20260121150655.GU3416603@bill-the-cat>
References: <20260120223405.469050-1-trini@konsulko.com>
 <20260120223405.469050-6-trini@konsulko.com>
 <1d8efe1e-91d1-4ae4-a680-3e4200042fd9@cherry.de>
 <20260121150655.GU3416603@bill-the-cat>
Date: Mon, 26 Jan 2026 14:17:21 +0100
Message-ID: <87sebso6n2.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

On Wed, Jan 21, 2026 at 09:06, Tom Rini <trini@konsulko.com> wrote:

> On Wed, Jan 21, 2026 at 12:16:23PM +0100, Quentin Schulz wrote:
>> Hi Tom,
>> 
>> On 1/20/26 11:31 PM, Tom Rini wrote:
>> > - We already have good custodian documentation for patchwork, add a
>> >    reference and then link to it here.
>> > - Add a reference to the existing b4 documentation, and reference it
>> >    here.
>> > - Note and link to patchwork integration, am/shazam and ty features of
>> >    b4 as these are the most likely useful portions. Be specific about
>> >    keeping the default ${summary} as that includes important information.
>> > 
>> > Signed-off-by: Tom Rini <trini@konsulko.com>
>> 
>> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
>> 
>> Thanks!
>> 
>> Additional comments below.
>> 
>> > ---
>> >   doc/develop/codingstyle.rst     |  2 ++
>> >   doc/develop/process.rst         | 29 +++++++++++++++++++++++++++++
>> >   doc/develop/sending_patches.rst |  2 ++
>> >   3 files changed, 33 insertions(+)
>> > 
>> > diff --git a/doc/develop/codingstyle.rst b/doc/develop/codingstyle.rst
>> > index 7304eea0056a..2a69162fa95f 100644
>> > --- a/doc/develop/codingstyle.rst
>> > +++ b/doc/develop/codingstyle.rst
>> > @@ -24,6 +24,8 @@ The following rules apply:
>> >     <https://peps.python.org/pep-0008/>`_. Use `pylint
>> >     <https://github.com/pylint-dev/pylint>`_ for checking the code.
>> > +.. _b4_contrib:
>> > +
>> >   * Use the `b4 <https://b4.docs.kernel.org/en/latest/>`__ tool to prepare and
>> >     send your patches. b4 has become the preferred tool to sending patches for many
>> >     Linux kernel contributors, and U-Boot ships with a ready-to-use ``.b4-config`` that
>> > diff --git a/doc/develop/process.rst b/doc/develop/process.rst
>> > index f436a98433a7..fd81d9c5ebd4 100644
>> > --- a/doc/develop/process.rst
>> > +++ b/doc/develop/process.rst
>> > @@ -232,6 +232,35 @@ feedback to the submitter of a patch about what is going on:
>> >       work on an individual submitting a patch when something does not
>> >       apply cleanly.
>> > +Tooling
>> > +^^^^^^^
>> > +
>> > +There are a number of tools available to help custodians and
>> > +contributors alike with their contributions. As a project we make use of
>> > +the Patchwork project hosted at `OzLabs <http://patchwork.ozlabs.org/>`__
>> > +and more discussion on how it is used from both a contributor as well as
>> > +custodian point of view can be found :ref:`here <patchwork>`.
>> > +
>> > +Another useful tool is `b4 <https://b4.docs.kernel.org/en/latest/>`__
>> > +and is documented from a contributor point of view :ref:`here
>> > +<b4_contrib>`. It also has a number of useful features from a custodian
>> > +point of view:
>> > +
>> > +* `Integration with patchwork
>> > +  <https://b4.docs.kernel.org/en/latest/config.html#patchwork-integration-settings>`__
>> > +  which allows for automatic state tracking.
>> > +
>> 
>> Can we have this integration added to .b4-config so there's less to do for
>> custodians? Ideally also with steps to finish the setup so that patchwork is
>> fully working for them?
>
> Yes, I can follow-up and add defaults for everything but API key.
>
>> > +* `"am" and "shazam"
>> > +  <https://b4.docs.kernel.org/en/latest/maintainer/am-shazam.html>`__
>> > +  for applying a patch or series of patches. Of note is that with
>> > +  ``shazam`` review tags can be applied automatically and cover letters
>> > +  can be integrated as part of merging a series.
>> > +
>> 
>> Is there any reason for using b4 am? (I only use b4 shazam myself).
>
> I use it from time to time when "shazam"'ing something results in a
> merge I have to fixup and so "ty -l" doesn't show the patch. An "am"
> will put it back in the ty list.
>
>> Should we hint at --check also?
>
> Not sure. I don't use it because I have something else that runs and
> logs checkpatch later.
>
>> """
>> Tells b4 to run a series of local checks on each patch of the series and
>> display any problems. When b4 finds a valid patchwork project definition in
>> the configuration settings, it also looks up the CI status of each patch.
>> """
>> 
>> We can configure which command to run by setting
>> b4.am-perpatch-check-cmd in .b4-config
>> (https://b4.docs.kernel.org/en/latest/config.html#am-and-shazam-settings)
>
> Right, but we have checkpatch configured already in-tree.

Personally, I always use --check when applying patches for review.

I usually run "b4 shazam -s -l --check <msgid>"

>
>> We should absolutely make clear that both am and shazam fetch the latest
>> version of the series, regardless of the link being passed to it (except if
>> -v or --use-version is used). At least that's my experience with shazam and
>> the docs states it should apply to both am and shazam.
>> 
>> I'm assuming the cover-letter being integrated as a merge commit would be
>> behind the --merge option?
>> 
>> We may want to hint at -P or --cherry-pick as ways to only pick specific
>> commits out of the patch series.
>> 
>> I'm not sure how much we want to hint at here versus letting custodians
>> figure out their workflow on their own.
>
> The last point is the one I agree with most. I know at least Casey and
> Mattijs are using b4 as well, so I'd like their feedback on document

I think mentioning like done in the patch is good enough. We don't want
to repeat the upstream b4 docs too much.

For b4 ty, there is some configuration required though. I have:

[b4]
    thanks-commit-url-mask = https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/%.40s
    thanks-am-template = /home/mkorpershoek/.dotfiles-private/u-boot-dfu/thanks-am-template
    thanks-treename = https://source.denx.de/u-boot/custodians/u-boot-dfu

Where thanks-am-template is:
""""
Hi,

On ${sentdate}, ${fromname} wrote:
${quote}

Thanks, Applied to ${treename} (${branch})

${summary}

--
Mattijs
""""

> here vs expect people to read upstream docs. As for example, I also
> didn't mention "mbox" but I use that for both re-reviews as well as "oh,
> this patch broke X, I need to reply now". But I would also expect
> someone using b4 to see/know about that, or have their own workflow
> already.
>
> -- 
> Tom
