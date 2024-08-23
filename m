Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14911C531DC
	for <u-boot@archiver.kernel.org>; Fri, 23 Aug 2024 20:30:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60B5F88915;
	Fri, 23 Aug 2024 22:30:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nb6wyrQa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8AB6A8895A; Fri, 23 Aug 2024 22:30:19 +0200 (CEST)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C93288580
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 22:30:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-7a66907fa39so146039585a.3
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 13:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724445015; x=1725049815; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1HkC0Kl+KqCNgnh03G4jF2K3iMkrzhejCwUJxKvmAqQ=;
 b=nb6wyrQaQiiGtIjSNctWE4C0GnHknfdO89NKbOc/UNp1VnCDjOjXVAMwj1vTwQkw+l
 yZ55terUB8xN7udjzS33bs4ojQdKYV8gBwtKlfZVO5p+GRNCZR0CzO31lsW6RdRYfaSQ
 m6/4ustzC94nEJEQJQoNH9Hu3w0swekrEjzIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724445015; x=1725049815;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1HkC0Kl+KqCNgnh03G4jF2K3iMkrzhejCwUJxKvmAqQ=;
 b=cW7aoRjsg6NWunHJhfGPhcOsgnRo1J9k77Oj5jmfvZcLt5/VXR0ESSqTvUakRMzupM
 CkksvXaSyKQ4aKcT3yEWYuOkSp1m/LhHbVb2Xe7Cc7NUgp+rnP2EYnQyXYVbOkBubXi5
 oTGMeyzVQbBqw1TqI/WkmMbR6jFyeGMvwJyTl1mhPTLc93G4lI74p6sNJD/+U2oRv1Np
 y+fTS9hxzVWjYMEJi3XJkUfsP6P9CCqkvDCDRAOvBoXfMbP3yVRyJImrpucsEiCNuFzT
 e98DEsD+gDNAxPwzky59mu2YGnBGiz1LU7ISucCzDbSDJVCFgB9TKkup3fhf9EtMbVRl
 oGng==
X-Gm-Message-State: AOJu0Yzyd2brw2pqNVCyNvCE44pIiJGegwSLPm9WYWtukfgOVePjKO6u
 QirhUny57zZLp6RkncotyDpCPLQzbojJ8uPHrWodpjlE0POkMJcAaQcoprSbnxPyNtYrX3l73VK
 SM2fgssqicBxhYXdvZ+UdEir0ulUN/1XIhm+0O/gu2VlElEJsZQ==
X-Google-Smtp-Source: AGHT+IEch7j96+38/tfYnjUMAnf1NjXYIlUg2TmkJHVHVPtU+oPB67bQYfdvpWQTVeFaIsPlskjgmFvR5q73WsggzZc=
X-Received: by 2002:a05:6214:188b:b0:6c1:6f3e:480b with SMTP id
 6a1803df08f44-6c16f3e484emr29178216d6.41.1724445014924; Fri, 23 Aug 2024
 13:30:14 -0700 (PDT)
MIME-Version: 1.0
References: <20240821161927.695717-1-sjg@chromium.org>
 <20240821161927.695717-27-sjg@chromium.org>
 <20240823133450.GA1627158@bill-the-cat>
In-Reply-To: <20240823133450.GA1627158@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 23 Aug 2024 14:30:04 -0600
Message-ID: <CAFLszThQKH-pM1nTNJv5HwLanc9tGL4ZgvPLzxWk48LmxHa+NQ@mail.gmail.com>
Subject: Re: [PATCH v2 26/35] global_data: Reduce size of early-malloc vars
To: Tom Rini <trini@konsulko.com>
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

Hi Tom,

On Fri, 23 Aug 2024 at 07:34, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Aug 21, 2024 at 10:19:18AM -0600, Simon Glass wrote:
>
> > The early malloc region is normally quite small and is certainly less
> > than 4GB, so use a 32-bit value for the limit and pointer. Update the
> > comment for clarity while we are here.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > (no changes since v1)
> >
> >  arch/arm/lib/bdinfo.c             | 2 +-
> >  common/board_r.c                  | 2 +-
> >  common/malloc_simple.c            | 7 ++++---
> >  common/spl/spl.c                  | 4 ++--
> >  include/asm-generic/global_data.h | 6 +++---
> >  5 files changed, 11 insertions(+), 10 deletions(-)
>
> This breaks booting on am64x_evm_a53 which is an odd platform that does
> SPL->SPL->U-Boot.

OK, I can repeat that on the Beagleplay in my lab. I sent a v3 patch.
Thanks for bisecting.

I'd love to be able to push trees to gitlab and have them run on my
lab. I think you said that the patches[1] break your lab, so let me
know if there is anything I can fix.

Regards,
Simon

[1] https://patchwork.ozlabs.org/project/uboot/list/?series=420392
