Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB2A7CDE008
	for <u-boot@archiver.kernel.org>; Fri, 26 Jun 2026 09:03:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 310008460E;
	Fri, 26 Jun 2026 11:03:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=maquefel.me
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=maquefel.me header.i=@maquefel.me header.b="n7/jIkhQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCD7084704; Fri, 26 Jun 2026 11:03:36 +0200 (CEST)
Received: from forward502b.mail.yandex.net (forward502b.mail.yandex.net
 [178.154.239.146])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 950818404D
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 11:03:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=maquefel.me
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=nikita.shubin@maquefel.me
Received: from mail-nwsmtp-smtp-production-main-89.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-89.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c11:2281:0:640:870e:0])
 by forward502b.mail.yandex.net (Yandex) with ESMTPS id BBD4080F93;
 Fri, 26 Jun 2026 12:03:33 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-89.sas.yp-c.yandex.net (smtp)
 with ESMTPSA id V3WL6hPd78c0-9uLnvStj; 
 Fri, 26 Jun 2026 12:03:32 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
 t=1782464613; bh=TPnDVhfjapdS6dVhU/tS3pkJxcpqARXNEbibzRAMFSY=;
 h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
 b=n7/jIkhQawdWqzehPZICWB69SSu6YhixO7tt31aGbNfHIozPCrH75eeN0A0qk4IQ6
 l05Q8KJO3WPyS8HBf761bQqo2GeeVeiibI/4BlETFMMpPtza2/5BI0VBT4Mty/aBLr
 xW0PaK5cMtsOXY6UAItSIREnvke1GHaVjKgzjelc=
Authentication-Results: mail-nwsmtp-smtp-production-main-89.sas.yp-c.yandex.net;
 dkim=pass header.i=@maquefel.me
Message-ID: <fcddaa72647633aca663eb07a8057bfc1a4de24a.camel@maquefel.me>
Subject: Re: [RFC,0/2] RISC-V SPL: fix OpenSBI FIT loading and OS entry
 point retrieval
From: Nikita Shubin <nikita.shubin@maquefel.me>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Date: Fri, 26 Jun 2026 12:03:35 +0300
In-Reply-To: <CAFLszTjR1xm+LZV3Ys++sdc-1viQgx_jAvT5JTP=sSyL1WyssQ@mail.gmail.com>
References: <20260619-riscv-full-fit-image-support-v1-0-c6477cf4f410@maquefel.me>
 <CAFLszTjR1xm+LZV3Ys++sdc-1viQgx_jAvT5JTP=sSyL1WyssQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
MIME-Version: 1.0
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

On Thu, 2026-06-25 at 11:59 +0100, Simon Glass wrote:
> Hi Nikita,
>=20
> On 2026-06-19T12:52:56, Nikita Shubin <nikita.shubin@maquefel.me>
> wrote:
>=20
> > Changes in v2:
> > - EDITME: describe what is new in this series revision.
> > - EDITME: use bulletpoints and terse descriptions.
>=20
> Please fill in the b4 EDITME placeholders so reviewers can see what
> changed since v1.

Sorry - there is no v1. I had a b4 glitch and rolled back to v1, but
forgot to delete auto-placed "Changes in v2 ...".

>=20
> > Question is - if Full FIT wasn't tested with RISC-V U-Boot SPL or i
> > am
> > doing something wrong ?
>=20
> I suspect you are right - SPL_LOAD_FIT_FULL is rarely enabled and
> most
> RISC-V boards use the non-FULL FIT path. Thanks for looking into it.
>=20
> The series is missing test coverage. See test/image/ and the SPL
> sandbox tests; OpenSBI loadable handling should grow a regression
> test, otherwise this will silently break again. Please can you add
> one, or say in the cover letter why it is not feasible.

Agree.

>=20
> On the design - stashing uboot_addr and kernel_addr in spl_image_info
> as a side channel from spl_load_fit_image() to spl_invoke_opensbi()
> works, but feels indirect. The real bug is that spl_invoke_opensbi()
> looks in the wrong FDT (the OS DTB rather than the FIT). Would it be
> cleaner to keep a pointer to the FIT itself around for this lookup,
> rather than caching addresses by OS type? What do you think?

I need to study the proposals in detail to reach a solution that
actually solves the problem. The current one was more of a prompt for
an RFC and a way of identifying the existing problem.

Thank you for the detailed and thoughtful reply.

Yours,
Nikita.
>=20
> Regards,
> Simon
