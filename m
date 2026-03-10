Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8AD0FD4F08
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 17:17:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A959840EE;
	Tue, 10 Mar 2026 18:17:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67C3A8412A; Tue, 10 Mar 2026 18:17:02 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 366EB840D8
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 18:16:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vincent.stehle@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4808914BF;
 Tue, 10 Mar 2026 10:16:52 -0700 (PDT)
Received: from debian (X72Y076X74-2.nice.arm.com [10.34.128.252])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B48C83F694;
 Tue, 10 Mar 2026 10:16:57 -0700 (PDT)
Date: Tue, 10 Mar 2026 18:16:54 +0100
From: Vincent =?utf-8?Q?Stehl=C3=A9?= <vincent.stehle@arm.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/5] efi_selftest: fix buffer overflow
Message-ID: <abBSBsF7Pb6gCSGL@debian>
Mail-Followup-To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20260219184400.257008-1-vincent.stehle@arm.com>
 <20260219184400.257008-2-vincent.stehle@arm.com>
 <db9de791-60fe-4308-b2d3-66ad6eb07684@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <db9de791-60fe-4308-b2d3-66ad6eb07684@gmx.de>
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

On Tue, Feb 24, 2026 at 04:45:48PM +0100, Heinrich Schuchardt wrote:

Hi Heinrich,

Thanks for your review and sorry for the late reply.
My answers below.

Best regards,
Vincent.

> On 2/19/26 19:43, Vincent Stehlé wrote:
> > The test of the UEFI LocateHandleBuffer() function clears a returned buffer
> > at some point to reuse it, but there is an error in the size computation,
> > which leads to a buffer overflow; fix it.
> > 
> > Fixes: 927ca890b09f ("efi_selftest: test protocol management")
> > Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
> > Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > Cc: Tom Rini <trini@konsulko.com>
> > ---
> >   lib/efi_selftest/efi_selftest_manageprotocols.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/lib/efi_selftest/efi_selftest_manageprotocols.c b/lib/efi_selftest/efi_selftest_manageprotocols.c
> > index 097b2ae3545..ccffa59095d 100644
> > --- a/lib/efi_selftest/efi_selftest_manageprotocols.c
> > +++ b/lib/efi_selftest/efi_selftest_manageprotocols.c
> > @@ -241,7 +241,7 @@ static int execute(void)
> >   		return EFI_ST_FAILURE;
> >   	}
> >   	/* Clear the buffer, we are reusing it it the next step. */
> > -	boottime->set_mem(buffer, sizeof(efi_handle_t) * buffer_size, 0);
> > +	boottime->set_mem(buffer, sizeof(efi_handle_t) * count, 0);
> >   	/*
> >   	 * Test LocateHandle with ByProtocol
> 
> Hello Vincent,
> 
> Thank you for reviewing the code and pointing to an issue.
> 
> The fix looks incomplete to me:

You are right: I broke down all the fixes into multiple steps, which explains
why the first patch ("fix buffer overflow") is not the full story.

I thought this would ease reviewing but now I wonder if that was maybe a bad
idea. Let me know if I should send a v2 with the series as a single patch if
that helps.

> 
> In line 167 we allocate a buffer with LocateHandleBuffer(). Assigning
> buffer_size in line 173 does not make any sense, as we free the buffer in
> line 185.

This is removed in patch 4 ("fix buffer size and count computations").

> 
> In line 223 we allocate another buffer with LocateHandleBuffer().
> Assigning the value of buffer_size value to count before the invocation
> doesn't make much sense.

This is removed in patch 3 ("remove unnecessary initializations").

> 
> You fix in line 244 looks correct.
> 
> Line 249 sets count to an arbitrary value that is not related to the size of
> the buffer.

This part is reworked in patch 4 to use buffer_size instead.

> 
> Line 260 sets variable buffer_size and buffer_size is again used in line 306
> to set count to an unused value.

This is removed in patch 3.

> 
> We should completely remove variable buffer_size from the function.

The patch series takes a different approach: keep both count and buffer_size
variables, and make sure to use those variables to contain quantities
corresponding to their respective names.

> 
> Best regards
> 
> Heinrich
