Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90F7BCAC59A
	for <u-boot@archiver.kernel.org>; Fri, 19 Sep 2025 16:37:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF79A832DA;
	Fri, 19 Sep 2025 18:37:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="GBRsKfWX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="scwRU7im";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GBRsKfWX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="scwRU7im";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 924048331F; Fri, 19 Sep 2025 18:37:12 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75B048329F
 for <u-boot@lists.denx.de>; Fri, 19 Sep 2025 18:37:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=msuchanek@suse.de
Received: from kitsune.suse.cz (unknown [10.100.12.127])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F307B1F7E9;
 Fri, 19 Sep 2025 16:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1758299830; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X3kZUHqPdCzifrYQvSiszZFn8xYLEK2iB1hWqrejrAU=;
 b=GBRsKfWXtkSEnA+7U3lWlT9Ds4hcpu1lWmURbELs+Nq84tRmChITqhHY+wZP2kJqR9Y2pv
 RX9E6O5Tra6tu0cw8IRN0m3CzFe2iRsKm/E7UifNKCQktGh/+EYcyAI1qbx5UtHu/MFDlx
 xF22H0Ro65rZUS0HHsDGgSgelYABl8c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1758299830;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X3kZUHqPdCzifrYQvSiszZFn8xYLEK2iB1hWqrejrAU=;
 b=scwRU7imHSooZ6SW6vatYjO1N3nVHGJwHJ0WZh+BfGkFyYWkbgyL1s5JxbeBBwzZmA/afG
 cWoMABZrbppUXzCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1758299830; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X3kZUHqPdCzifrYQvSiszZFn8xYLEK2iB1hWqrejrAU=;
 b=GBRsKfWXtkSEnA+7U3lWlT9Ds4hcpu1lWmURbELs+Nq84tRmChITqhHY+wZP2kJqR9Y2pv
 RX9E6O5Tra6tu0cw8IRN0m3CzFe2iRsKm/E7UifNKCQktGh/+EYcyAI1qbx5UtHu/MFDlx
 xF22H0Ro65rZUS0HHsDGgSgelYABl8c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1758299830;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X3kZUHqPdCzifrYQvSiszZFn8xYLEK2iB1hWqrejrAU=;
 b=scwRU7imHSooZ6SW6vatYjO1N3nVHGJwHJ0WZh+BfGkFyYWkbgyL1s5JxbeBBwzZmA/afG
 cWoMABZrbppUXzCQ==
Date: Fri, 19 Sep 2025 18:37:08 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Simon Glass <sjg@chromium.org>
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: Seeking advice on API return type inconsistency
Message-ID: <aM2GtCEnhNc_59qw@kitsune.suse.cz>
References: <f5c94319-8ef8-459d-88b2-836702779cfb@linaro.org>
 <e10a39e4-9606-4ae4-86dd-11de4b39b5ed@cherry.de>
 <2d6457b8-c637-4531-8f56-e2aea320a319@linaro.org>
 <20250812143349.GQ124814@bill-the-cat>
 <cc82add8-5f9c-4ee1-87ea-a458e840e621@linaro.org>
 <20250812150359.GS124814@bill-the-cat>
 <56d03251-1185-44ca-98e6-f45ac0e0af53@linaro.org>
 <aJx54frzXkLRFcGO@kitsune.suse.cz>
 <CAFLszTicwDH4wY4UcN=tebfFJnqKa8us5A4cGOy_ZvXPE69a_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFLszTicwDH4wY4UcN=tebfFJnqKa8us5A4cGOy_ZvXPE69a_w@mail.gmail.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.984]; MIME_GOOD(-0.10)[text/plain];
 MISSING_XM_UA(0.00)[]; FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_DN_EQ_ADDR_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_COUNT_ZERO(0.00)[0]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[kitsune.suse.cz:mid, kitsune.suse.cz:helo,
 suse.de:email]
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

Hello,

On Fri, Sep 19, 2025 at 09:51:15AM -0600, Simon Glass wrote:
> Hi Michal,
> 
> On Wed, 13 Aug 2025 at 05:41, Michal Suchánek <msuchanek@suse.de> wrote:
> >
> > Hello,
> >
> > On Wed, Aug 13, 2025 at 11:58:19AM +0100, Andrew Goodbody wrote:
> > > On 12/08/2025 16:03, Tom Rini wrote:
> > > > On Tue, Aug 12, 2025 at 03:46:56PM +0100, Andrew Goodbody wrote:
> > > > > On 12/08/2025 15:33, Tom Rini wrote:
> > > > > > On Tue, Aug 12, 2025 at 10:17:47AM +0100, Andrew Goodbody wrote:
> > > > > > > On 11/08/2025 17:36, Quentin Schulz wrote:
> > > > > > > > Hi Andrew,
> > > > > > > >
> > > > > > > > On 8/11/25 5:24 PM, Andrew Goodbody wrote:
> > > > > > > > > Hi,
> > > > > > > > >
> > > > > > > > > I was wondering what people's thoughts were on API return types. In
> > > > > > > > > particular there is this and other examples in include/clk-uclass.h
> > > > > > > > >
> > > > > > > > > /**
> > > > > > > > >     * get_rate() - Get current clock rate.
> > > > > > > > >     * @clk:    The clock to query.
> > > > > > > > >     *
> > > > > > > > >     * This returns the current rate of a clock. If the clock is
> > > > > > > > > disabled, it
> > > > > > > > >     * returns the rate at which the clock would run if it was enabled. The
> > > > > > > > >     * following pseudo-code should hold::
> > > > > > > > >     *
> > > > > > > > >     *   disable(clk)
> > > > > > > > >     *   rate = get_rate(clk)
> > > > > > > > >     *   enable(clk)
> > > > > > > > >     *   assert(get_rate(clk) == rate)
> > > > > > > > >     *
> > > > > > > > >     * Return:
> > > > > > > > >     * * The rate of @clk
> > > > > > > > >     * * -%ENOSYS if this function is not implemented for @clk
> > > > > > > > >     * * -%ENOENT if @clk->id is invalid. Prefer using an assert
> > > > > > > > > instead, and doing
> > > > > > > > >     *   this check in request().
> > > > > > > > >     * * Another negative error value (such as %EIO or %ECOMM) if the
> > > > > > > > > rate could
> > > > > > > > >     *   not be determined due to a bus error.
> > > > > > > > >     */
> > > > > > > > > ulong get_rate(struct clk *clk);
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > get_rate is declared as returning a ulong but the description says
> > > > > > > > > that it can return negative errors. A simple test of the return
> > > > > > > > > value for being less than 0 will always fail so errors can go
> > > > > > > > > undetected. Casting to a signed type seems less than ideal.
> > > > > > > > >
> > > > > > > > > What is the best way to deal with this? Cast to a signed or update
> > > > > > > > > the API to be signed or...?
> > > > > > > > >
> > > > > > > >
> > > > > > > > Note that clk_get_rate() in the kernel has the same function signature
> > > > > > > > so I would refrain from changing the type otherwise we'll have some
> > > > > > > > "funny" bugs to handle considering it isn't that uncommon to import
> > > > > > > > drivers almost as-is from the Linux kernel.
> > > > > > >
> > > > > > > Ah yes. The difference being that the kernel does not seem to attempt to
> > > > > > > push an error code through this API, you get a rate or you get 0.
> > > > > >
> > > > > > How is the error code pushed? Or is it up to the caller to decide that 0
> > > > > > means on a case by case basis?
> >
> > Presumably it returns -EBUSY which is then implicitly converted to a large
> > positive value. For pointers there is IS_ERR macro to decode that, and
> > for integers there is another corresponding macro (I don't recall the
> > name).
> >
> > For memory this assumes that the last page that holds the 'error'
> > pointers cannot be mapped, and there was already a bug in the kernel
> > that this was not true.
> >
> > For clock rates this assumes that rates close to the maximum value are
> > invalid which is not guaranteed in any way whatsoever.
> >
> > Consequently, this should not be used.
> >
> > 0 is the only clock rate guaranteed to be invalid.
> >
> > As far as I have seen in the u-boot code almost no caller checks the
> > result, and those that do cannot do anything meaningful with it anyway,
> > at most a message is printed. That can be done by the driver without
> > passing around the error.
> >
> > > > > In the Linux kernel almost no code checks the return of clk_get_rate at all.
> > > > > Some code will check the value is sensible and 0 is obviously not sensible.
> > > > > But pretty much the call to clk_get_rate is not expected to fail.
> > > >
> > > > Perhaps getting lost in the specifics then, but perhaps for this case we
> > > > should just do the same? But your question was more general, so another
> > > > example might help.
> > >
> > > I suspect that the answer is always going to that it depends on the
> > > specifics of each case. The U-Boot implementation of clk_get_rate seems to
> > > have become more complicated leading to the addition of returning error
> > > codes. This leads to the question about what level of compatibility should
> > > there be maintained with the kernel? That addition of returning error codes
> > > in U-Boot already means that the API is no longer compatible with that of
> > > the kernel.
> >
> > I would suggest to abolish returning 'errors' as clock rates.
> 
> I don't think that is a good idea. Debugging drivers then becomes
> quite complicated since there is no feedback and you must head into
> the clock subsystem to see what is going on. Bring this into U-Boot
> more generally and it will be very painful. At the moment at least you
> can enable CONFIG_LOG_ERROR_RETURN and see what happened.

Does that really work with unsigned return values containing negative
error values as large positive integers?

> Better I think to create some new functions with the API you want
> (e.g. panic on failure, ignore failure). Or rename clk_get_rate_int()
> - for internal - and create a new clk_get_rate() that does what you
> want / what Linux does.

The problem is that once an error is returned as 'clock rate' there is
really no way to determine if what you got is really a clock rate or an
error. You can assume that the values IS_ERR decodes as errors are not
clock rates but there is no guarantee that is the case. While IS_ERR
only uses small part of the avaiale range the valid values are not
spread evenly over the range, and hardware-specific.

Thanks

Michal
