Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1B0FC4167B
	for <u-boot@archiver.kernel.org>; Thu, 30 Nov 2023 11:44:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 112C287116;
	Thu, 30 Nov 2023 12:44:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="maT7JfK7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="J2kMD9sw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 907F2870AF; Thu, 30 Nov 2023 12:44:35 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9433186B9A
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 12:44:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=msuchanek@suse.de
Received: from kitsune.suse.cz (unknown [10.100.12.127])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BEBE51F855;
 Thu, 30 Nov 2023 11:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1701344670; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lACsUfp1qs+QL8ULEb/Lg/hKEnjESq6uwEPGM4lHlwc=;
 b=maT7JfK7SyVt/1/7QFZqQ+cY+ezfU+G7hr0KPzsqm94/MprUWn9wrZ17Avf1FU+tSXlSQb
 jTiZFBDVBC0bd+NUJN+qcMoUxD3lr/3J+WNy1b0fgwClQDZoFUCD7kpa3/U2fiDlM218fH
 38nxBUBPOTr6vr0xrKBx2riSE70TLrs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1701344670;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lACsUfp1qs+QL8ULEb/Lg/hKEnjESq6uwEPGM4lHlwc=;
 b=J2kMD9swR4zJN28Qmwwg6KF43DHfwR09VTaZytusVE4WB1xL0HbqR1J2tx+LEQTs3ZM92M
 3Dp14FEEb+9skNCA==
Date: Thu, 30 Nov 2023 12:43:52 +0100
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Maxim Uvarov <maxim.uvarov@linaro.org>,
 u-boot@lists.denx.de, pbrobinson@gmail.com,
 ilias.apalodimas@linaro.org, goldsimon@gmx.de
Subject: Re: [PATHv11 01/43] submodule: add lwIP as git submodule
Message-ID: <20231130114352.GN9696@kitsune.suse.cz>
References: <20231127125726.3735-1-maxim.uvarov@linaro.org>
 <20231127125726.3735-2-maxim.uvarov@linaro.org>
 <20231127181607.GL2513409@bill-the-cat>
 <CAPnjgZ2CGQpCkBbHtSUAjGosiNv8XPs7P5MrO_gtjPzQ5QWoOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPnjgZ2CGQpCkBbHtSUAjGosiNv8XPs7P5MrO_gtjPzQ5QWoOQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-1.10 / 50.00]; ARC_NA(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
 MIME_GOOD(-0.10)[text/plain]; NEURAL_HAM_LONG(-1.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_SEVEN(0.00)[7];
 DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,konsulko.com:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_ZERO(0.00)[0];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_CC(0.00)[konsulko.com,linaro.org,lists.denx.de,gmail.com,gmx.de];
 BAYES_HAM(-0.00)[16.98%]
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

On Wed, Nov 29, 2023 at 07:45:28PM -0700, Simon Glass wrote:
> Hi Tom,
> 
> On Mon, 27 Nov 2023 at 11:16, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Nov 27, 2023 at 06:56:44PM +0600, Maxim Uvarov wrote:
> >
> > > add external lwIP library as a git submodule.
> > > Use STABLE-2_2_0_RELEASE tag.
> > >
> > > Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
> >
> > And just for the record, we'll re-visit submodule/subtree/whatever later
> > on, this (and the final parts for CI to be happy about it) are a means
> > to an end.
> 
> While I understand this, I would still like to see a patch containing
> the actual code. We are at v11 here.

This is why submodules are evil.

You *can* produce a patch that contains the code but you have to
*remember* to pass the argument.

And if the patch does contains the code it is likely not applicable
because then it does not contain the revision to which the submodule
should be updated.

Submoudules may be a generally good idea but they are not well
implemented in git.

Thanks

Michal
