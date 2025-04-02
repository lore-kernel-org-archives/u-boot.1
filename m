Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A2ABC28B20
	for <u-boot@archiver.kernel.org>; Wed,  2 Apr 2025 09:32:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6084180FDA;
	Wed,  2 Apr 2025 11:32:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DkwImkQg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D97C81E6C; Wed,  2 Apr 2025 11:32:16 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B567580584;
 Wed,  2 Apr 2025 11:32:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 5E4B75C6173;
 Wed,  2 Apr 2025 09:29:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3456C4CEDD;
 Wed,  2 Apr 2025 09:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1743586331;
 bh=w4HoQfgwIGV5WRRxIH0AhBqRVbJ10thihbO0tXBPqjk=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=DkwImkQgNaFxXId75wNa1RQgyRqV1cipPhqPv9HSHS6GXdbeJWY+NrYoT0wrkaMyn
 mKb2gGWYpIqJUWlQUjMdHJjDB+fox8XyxNaAOxk3+3MpVqwCwDqtjCGjui3oJmeJ2I
 V4jRyQNOk0e5456W0g5Qf5G6xgbpWzlj8hatCjarGk8AfxhFM9R2JRtwkZDAd4TG9u
 QsBONCiZqhtrAtc7dVCQGZvsFlmuhd2EvM+F10q5PxW+2vdtuAttqzZw/Hu1d9kTIU
 Imr9Rr0PeglSsoxx2Pt5qUpCtnsEKPGQtG+Yq+QLrg8G0MN0zBQsrFU7pmpbypnFwI
 TTim5HvOEkSnw==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, U-Boot Custodians
 <u-boot-custodians@lists.denx.de>
Subject: Re: Rate of innovation in the project (Was: Re: Rate of change in
 the project)
In-Reply-To: <20250401171822.GM5495@bill-the-cat>
References: <CAFLszTgtdETGCYYtH3ni7Wv0W6Ckv1SoZRG8djQ-3uKBn1YZWQ@mail.gmail.com>
 <20250304152909.GZ2640854@bill-the-cat>
 <CAFLszTiNQSs51iE=rcM7qQjipmWCKZiPX+gV2ztb+ZAB8m2MBw@mail.gmail.com>
 <20250305162236.GT2640854@bill-the-cat>
 <CAFLszTjv54tYLHkG=RNeXJoZ+f-QHxMH=B_aU2=iOZhaoD7qKg@mail.gmail.com>
 <20250307144631.GN2640854@bill-the-cat>
 <20250310155336.GJ2640854@bill-the-cat>
 <CAFLszTirohLrKadFfdw28UMfH7nt2owKHOGdf-ehwQqemQUpDA@mail.gmail.com>
 <20250331155144.GX93000@bill-the-cat>
 <CAFLszTjNXzkVe_OULMOtt2imSD5KY-KPMgxT7FA=fFqnm0aaeA@mail.gmail.com>
 <20250401171822.GM5495@bill-the-cat>
Date: Wed, 02 Apr 2025 11:32:08 +0200
Message-ID: <8734equcx3.fsf@baylibre.com>
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

On mar., avril 01, 2025 at 11:18, Tom Rini <trini@konsulko.com> wrote:

> On Wed, Apr 02, 2025 at 04:45:37AM +1300, Simon Glass wrote:
>> Hi Tom,
>> 
>> On Tue, 1 Apr 2025 at 04:51, Tom Rini <trini@konsulko.com> wrote:
>> >
>> > On Fri, Mar 28, 2025 at 11:42:20PM +0000, Simon Glass wrote:
>> > > Hi Tom,
>> > >
>> > > On Mon, 10 Mar 2025 at 09:53, Tom Rini <trini@konsulko.com> wrote:
>> > > >
>> > > > On Fri, Mar 07, 2025 at 08:46:31AM -0600, Tom Rini wrote:
>> > > > > On Thu, Mar 06, 2025 at 09:10:47AM -0700, Simon Glass wrote:
>> > > > [snip]
>> > > > > > Again, back to this thread, if you want me to migrate things, consider
>> > > > > > applying the sunxi patches as I have described above. I will then look
>> > > > > > at the next target for bootstd. But while you hold this up, I cannot
>> > > > > > move forward with more bootstd migration. It doesn't seem that much to
>> > > > > > ask.
>> > > > >
>> > > > > I will take another look at what's still relevant. But I believe it's
>> > > > > still blocked on the fact that it changes behavior and breaks users.
>> > > >
>> > > > In details:
>> > > >
>> > > > https://patchwork.ozlabs.org/project/uboot/patch/20241113150938.1534931-2-sjg@chromium.org/
>> > > >
>> > > > Now that the underlying BLK problem is resolved, this can just be
>> > > > dropped I believe. Removing the BLK dependency from BOOTSTD can happen
>> > > > when you're supporting a flow that lacks a BLK device entirely. This
>> > > > would be another reminder as to why putting unrelated changes in a
>> > > > series is a problem.
>> > >
>> > > OK, then just don't apply this patch. Problem solved?
>> >
>> > Well, for a hypothetical v6 you would not include it, sure.
>> >
>> > > > https://patchwork.ozlabs.org/project/uboot/patch/20241113150938.1534931-3-sjg@chromium.org/
>> > > >
>> > > > This is fine.
>> > > >
>> > > > https://patchwork.ozlabs.org/project/uboot/patch/20241113150938.1534931-4-sjg@chromium.org/
>> > > >
>> > > > This is not fine. This is also not a sunxi problem. It means that we
>> > > > should drop bootmgr from rockchip, where the conversion has already
>> > > > taken place, and would need to drop it from future conversion too.
>> > > > Neither of which are desirable changes.
>> > >
>> > > Why do you say that? I don't understand how this relates to rockchip
>> > > or why we would need to drop bootmgr from that.
>> >
>> > Then you don't have enough of a grasp of the details of the area you're
>> > trying to solve problems in? Or maybe you need to refresh yourself on
>> > the details of the area you're trying to work in.
>> 
>> Or perhaps there isn't a problem? The sunxi case is special because we
>> have a FEL boothmeth. That isn't present on rockchip, for example.
>
> Again, you seem to have forgotten what the problems with the series
> were.
>
>> > > > This patch in particular is
>> > > > where we have the note:
>> > > >
>> > > > "Yes, the introduction of boot standard changed the boot order and
>> > > > specifically deprioritizing scripts is unexpected."
>> > > >
>> > > > Which should have had more attention than it did.
>> > >
>> > > From memory the scripts are a fallback used when the other things
>> > > don't work, so that was the decision I made at the time.
>> >
>> > The key point being we changed behavior that others depended on, and
>> > didn't document it well and didn't make sure the change would work for
>> > them either.
>> >
>> > > > This is the thread that to me spelled out in details where the
>> > > > conversions are now blocked. We changed behavior and that in turn breaks
>> > > > users that have come to rely on ordering.
>> > >
>> > > I don't know what action to take on that comment. We cannot have 100%
>> > > backwards compatibility with the scripts, which after all weren't even
>> > > documented. But it is very close.
>> >
>> > You need to get feedback from the people you want to migrate from the
>> > scripts and ordering and rely on to something else and see what works
>> > for them.
>> >
>> > > > https://patchwork.ozlabs.org/project/uboot/patch/20241113150938.1534931-5-sjg@chromium.org/
>> > > >
>> > > > Is an alternative to the above which then turned in to a discussion that
>> > > > I would very briefly summarize as "no discussions were had between
>> > > > stakeholders before integrating efi bootmgr with bootstd".
>> > > >
>> > > > https://patchwork.ozlabs.org/project/uboot/patch/20241113150938.1534931-6-sjg@chromium.org/
>> > > >
>> > > > This is fine, but only relevant once migration happens.
>> > > >
>> > > > https://patchwork.ozlabs.org/project/uboot/patch/20241113150938.1534931-7-sjg@chromium.org/
>> > > >
>> > > > If Andre is fine with this, this is fine.
>> > > >
>> > > > https://patchwork.ozlabs.org/project/uboot/patch/20241113150938.1534931-8-sjg@chromium.org/
>> > > >
>> > > > This is a generic bugfix. I will take this to next today.
>> > > >
>> > > > https://patchwork.ozlabs.org/project/uboot/patch/20241113150938.1534931-9-sjg@chromium.org/
>> > > >
>> > > > If Andre is fine with this, this is fine.
>> > >
>> > > Well, is he? I thought he was. Can you check?
>> >
>> > You're free to. It's one of the innumerable examples of why when you
>> > group multiple things in a series and there's problems with another part
>> > of the series, unrelated changes get dropped.
>> 
>> It would be easier for me if you could apply the patches as I've suggested.
>> 
>> But if you are willing to apply these patches and just want me to send
>> the series again without the BLK and RFC patches, I can do that.
>> Please let me know either way.
>
> Again, you should:
> - Take the non-bootstd sunxi enhancements, rebase them to next and post
>   for Andre. By themselves. This way they won't get stuck.
> - You should work with Heinrich to come up with something that handles
>   efi bootmanager and bootstd without breaking how our actual project
>   users use us.
>   There's no reason to migrate *more* platforms until we have this
>   fundamental problem sorted out.
> - You should work with any FOSS distributions to get their feedback on
>   what would make their life easier, from a user of U-Boot perspective.
>   bootstd won't be useful if it's not something our users want to use.

I can't speak for other distributions but for Android, it seems that the
direction is to use EFI boot via an excutable that implements the Android
bootflow. This is named GBL, and here are some pointers about it:
- https://android.googlesource.com/platform/bootable/libbootloader/+/refs/heads/main/gbl/README.md
- https://lpc.events/event/18/contributions/1704/attachments/1550/3231/Android%20Generic%20Boot%20Loader.pdf
- https://baylibre.com/android-bootflow-experiments-with-u-boot-and-gbl/

So in my opinion, at least for Android, bootmeth_android (bootstd) will
be deprecated in favor of EFI boot + GBL.

>
> -- 
> Tom
