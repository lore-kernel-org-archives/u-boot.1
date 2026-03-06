Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3710F513ED
	for <u-boot@archiver.kernel.org>; Fri,  6 Mar 2026 01:22:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C0F4838BB;
	Fri,  6 Mar 2026 02:22:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kvV+OQFA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E5B3839A8; Fri,  6 Mar 2026 02:22:29 +0100 (CET)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 533ED836D3
 for <u-boot@lists.denx.de>; Fri,  6 Mar 2026 02:22:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-660b497acd1so3868386a12.0
 for <u-boot@lists.denx.de>; Thu, 05 Mar 2026 17:22:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772760147; cv=none;
 d=google.com; s=arc-20240605;
 b=KFIO8efSj4HprKZhqvknCb13cBmOginLywd7xjEHtogCoMaBHmf88gRIXG0K32mPTZ
 /f/P1IOZVpgUuaiPZXb/T0ntkev9mVd53h9eQ2OQ5B32EA1QoNougXT2wQhPkc8tjTcC
 pBO141eZS5SCFcupJpxfgn2bN7Iv5dbszCVgh54+rs2vvr0Hbi9WYNn8D3Pyivq30Sb2
 hClmYB4mQzSoLAwqRosTHlR/7wWUuBe+ZARbUFAPXKstfi0+u9DYvAbOE3eOwz1XU3zB
 yncLB0lhmdYCKlV3jiRddRME2UmvcGWvwczOHer9jN9X88lKFggrCLCtM9JfLF8dcATL
 xrHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=BdLCou7Pjmi9CZBPd9YPOOpkvOUlB73pqaSL59/qzA4=;
 fh=4DFTJmnbnoavr7DkriXzQ9I9R7vzWReDuCo5cTrJ7MI=;
 b=c3kVANrxzDjF84nINSyco/kypVfmUfy290S/8A34KDbUlcdWeMxe9W9AHgOLYQdc8z
 z9JNKCnkVPCv9LplJmXWnUKN0vgnqzc4UWgar8N5Elf/2JdaLDJOd/YOJDZryPkRYxrn
 dGopEOa+3bgi0v2E7eZJbISp9BKnE3lqxLbeKDV7SY0m74jyuKlIGFEMTmOInRPQvxxH
 DBK71VgDcYVwWMZmMLb7TVzvvKKps5syOhPw34M2XR1Zw7GgxATJnk5V7gEeIWWTRJKP
 8GaLub7pG09sTbgJGUF5s9J59VQGOrTIYu4nBVE7FhpjlRPZe7Xh6BRbj7PeW4+9ZvYI
 cGnA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772760147; x=1773364947; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BdLCou7Pjmi9CZBPd9YPOOpkvOUlB73pqaSL59/qzA4=;
 b=kvV+OQFAST+fsATw8OCQz4uO2l9n+Qcpao+O/p4nelS+MgHicMGu7BDCMhKRdsGp42
 7i1J1y89n8x983QpxE2yJlYiKE6bD1GczymLUnrRlwrSCt76wIvik6K+BLwLw+8NBBsB
 7RbRSi+lbUH5j9NFv6VqCEUB3wsMGDFn9rvGk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772760147; x=1773364947;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BdLCou7Pjmi9CZBPd9YPOOpkvOUlB73pqaSL59/qzA4=;
 b=aXGFhD+fWyPhFDOXF/eWcAqhtY0l5hKAxzJqHyp1tuQ3ApsMcc6vnCg4G+s3vUxZUy
 9vP2IGYsRHs60VYT0ShZ1QSpfYePD+xtkUi31LyM/pX0FcNTwj5Q24hvVP4rGU6NEaKt
 AUrpH1GcYPyWKfikG5dtXz+DdGwWPOqMXRdlnHVv0dmAg4h0jG3K7qLmNEJlLMBb8CHQ
 pgttcuHpPJtfmU0fCWF9QeqeP0cqDZSHMVxOLuXUukLQqCNbuD93GyImCSIAOULd645Q
 sDYsIdVIEvEDv0/szgfMI40XbQ0LXoAhjtUYDVPeYcMbFl5xFb9Ilw7bpw6jr2wTE8Jk
 fCjw==
X-Gm-Message-State: AOJu0YztUbKn8GHZ8FPLtfuixw2L34/vhsW61ywhhx28bcjUlV4KA4TV
 44Q2zCI36CYVhPf+/NBKdx0xaFnLSoZt7QLxfpGcl26kIJIzPvJFPKdrXl3/IeJ1jhXa16rirvP
 RL/sbez5BMzJ0aC69Wk9huHWYiZuDFhf0H2SYpIxQ
X-Gm-Gg: ATEYQzxXR6GpYfXbDU55vrKmQncM6FlntzpnygY3dB4yiHxgqlYxG7cCmOARk0Pw7K4
 y5SHuEU+BrbPJy0T9eUCFLfDPjahNtyrP6dSwmlqAL8GlpuVAHjHVkKHVV5eC+milenDLVN30S4
 mMEdNxMy4oZPL7LqN5eAoBUDElvkXp75C8G+KltyUGgkCY1x+KuwCwZmdfcXJ+5kS1eqGi+7alq
 0hCe2uaEumKFeBr0jXt7Zl4wKyJGX82QkBjzBHwzTAX4xsFcQOnlzjfbya/3tRL5xwrA/RGOzyF
 UR2EjA==
X-Received: by 2002:a05:6402:274d:b0:65c:3c43:d9c4 with SMTP id
 4fb4d7f45d1cf-6619d47bb56mr188244a12.10.1772760146809; Thu, 05 Mar 2026
 17:22:26 -0800 (PST)
MIME-Version: 1.0
References: <20260304135202.1535134-1-sjg@chromium.org>
 <20260305193802.GH1388590@bill-the-cat>
In-Reply-To: <20260305193802.GH1388590@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 5 Mar 2026 18:22:15 -0700
X-Gm-Features: AaiRm52fSQ2pfq27z2zuvJaiXCwyBEY8y37WSadAg0pBB-0k_SV_VxBY4WSrhNM
Message-ID: <CAFLszTjC8m8XMSq0k7Etk3pH7KPdQJFO2DDifp0jhNC+zy4Vpg@mail.gmail.com>
Subject: Re: [PATCH] boot: Add fit_config_get_hash_list() to build signed node
 list
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Ahmad Fatoum <a.fatoum@pengutronix.de>, 
 Ludwig <ludwig.nussel@siemens.com>, Simon Glass <simon.glass@canonical.com>, 
 Daniel Golle <daniel@makrotopia.org>,
 Enric Balletbo i Serra <eballetbo@kernel.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
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

On Thu, 5 Mar 2026 at 12:38, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Mar 04, 2026 at 06:51:48AM -0700, Simon Glass wrote:
>
> > From: Simon Glass <simon.glass@canonical.com>
> >
> > The hashed-nodes property in a FIT signature node lists which FDT paths
> > are included in the signature hash. It is intended as a hint so should
> > not be used for verification.
> >
> > Add a function to build the node list from scratch by iterating the
> > configuration's image references. Skip properties known not to be image
> > references. For each image, collect the path plus all hash and cipher
> > subnodes.
> >
> > Use the new function in fit_config_check_sig() instead of reading
> > 'hashed-nodes'.
> >
> > Update the docs to cover this. The FIT spec can be updated separately.
> >
> > Signed-off-by: Simon Glass <simon.glass@canonical.com>
>
> This breaks:
> FAILED test/py/tests/test_vboot.py::test_vboot[sha1-basic-sha1--None-False-True-False-False] - AssertionError
> unfortunately.

Yes, as the messages change. I'll send a v2.

What do you think about the 'No images in config' message? I doubt it
would happen in practice so we could perhaps drop it.

Regards,
Simon
