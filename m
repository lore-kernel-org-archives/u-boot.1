Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED797CC6B1A
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 16:48:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B6BB560681;
	Tue, 13 Oct 2026 16:48:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QEJZgRX-n5gQ; Tue, 13 Oct 2026 16:48:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 02488607C8
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791910125;
	b=Pz41Yia5S4RUy465MDmzZh3+yt92yvXgQV+CXCFtSc8Ap3rMeij2js38iZYnnyTQ1HHR
	 vrYYgq+7t6ajAxZAnReY81UU1qojMxC85mx9riZJv3nAnSV6WQs6hfDPSC/7w6soJpi7N
	 ftBtk76NretjEinkjrlrSdfpm5/4sLW0FV9Cv4VvFncPtl2Kk+nnZUKDr73f+4979wVPY
	 XOqDvYRo7eKXbydcl/F7lgTIyLaTWwMpAGjhSvXXVMW4ycpgnldlowgZVC6LJQHNJxKMI
	 bByei3PJ3sl2OwrpUKPpD09ss1bn6HWVq7bjvOZG9abdoiQUYtc+VCwUsGU8p5e1iIA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791910125;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:In-Reply-To:
	 References:Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=OP+QMz+N2i+ebf8jPoc5kpRYqqTRSPiDDKEEd2iUd60=;
	b=pWW8bshGR1K6+iB2QhE3i4Q53GT0gR8H7fodL5zSdGmPeC4ghUuiqh3Lbnwod2Y4c8jS
	 +sFvy0Mqe32cKa7/gIP8xUmiEKEsbbmEhomTH1QIFJi4lGelmQBJnnyHdDEUIyBpW2Nxx
	 LvlfyTPBM2ISHHhS1jo79P1Asm0I360pYd8maxkfkovZlALUqpxsmYO32uT0gsm8+cNvs
	 jH1qLhmFDnMvZyeM6TnaamzxYR2ueq3oBY3eBptMsSI6nDtUxkbL5nDtlqdaZ4tB7qX6H
	 270z0k/F2EsVibXQ6CbY9h2u3jSR6EDcgl8NN3lAU9dvTWrvrX22tLT7JeCL6T+RojA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791910125;
	bh=OP+QMz+N2i+ebf8jPoc5kpRYqqTRSPiDDKEEd2iUd60=;
	h=Date:To:From:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vz4qWpM5md3TR1T0k7eiWe8VkeUvQtw+ign/RzvPsJzRqeOl9yTH9TdNiTP5iycMP
	 4zb9ATen/urHyXMpbv20FnYSUCjdaMYOwCqGJbW2D6oyxgKOE3o13fo/SfBoL9ag+g
	 NioYVt8/++Tq76a0r8yvqBQDfrwa8ECBFFZNTjkFYIuOExIjyFrJrUGAxx1FKihxd3
	 alIR96dElup4Ws3p998wzxW/6GSLtWc7HXy1YS3zudyha3UNslokCGEKyTsryRcvoa
	 tRprlG8bR3a5rjyuzveH894aKC3buMinA50sRM347oBzHh38jYYU5Cb653ELtZZMlV
	 s4XoOQfKlpXdg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 02488607C8;
	Tue, 13 Oct 2026 16:48:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id E32A1788
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 15:59:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C94B7404E0
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 15:59:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 55VNj0MNGLz7 for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 15:59:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C7DAA404C8
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=85.9.206.169
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791907176;
 b=j+wHIHJ9T3VVe0TywPn0CrYxqUxrr+uDDHjS/dTtaS4ruyoyaE3Pp4q//VPcqp7HjIvT
 fz3G5VvzlFy8ksCrq2EdRQlvGEB4Hwhl04qrC33kkyjYOBF48FcB6kpB44W5d8zkso9uY
 hOglztpCXR3g53h0Yu0qWGG5zWUEfsjl7P36zkKdh4T+5L0E21orFjFrpoUJMm5gkmdA3
 u8NHCZmwJaIuyFGfSGqjawgT1nr0KEageDrOCJodIa5mxnest60q6lSB+Ar5yoEL6X1ij
 Xw/WaeLxWVtuY8r6fRPoUQ5cnGsmVwTmbbUjbIu6MrMrtTa0fhSOjR3BVBMz53iDPpw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791907176;
 h=Received-SPF:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=OP+QMz+N2i+ebf8jPoc5kpRYqqTRSPiDDKEEd2iUd60=;
 b=WbQbe5p/gXJMPgDBT1oM5HuTsH8fIt/LtRIKOB3j6+ZP5/g8d+xioMmLQzo95JbZcCuI
 54b41sK06G6vYKLrQj31hOEeLo6FLUdU2+GkI/Aauz04L6KMlQMnKkK3gQ3i2GB4SVQbx
 /lHA7IsSN0NjSrSgtsDVieLMbSf8rtJCMj+wgjvdjbqNL+JDOMDDHTsmfNclTOBoWoJ1I
 p9X/DOs7E+CxxM4yqx+6cJpCwKsbkcp6gM3mQ+E5Q0imnpykxwtLpRgK2c4wSilnA0Ize
 3nAxlr0W5/jpe1sSTwPjPfVkQsIwNaTLiylbZPmkWTvZ7VfNSNVP/sWeEs3t6N3l8Zw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=protonmail.com;
 dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256
 header.s=protonmail3 header.b=GpTG6JfS; 
 arc=none smtp.remote-ip=85.9.206.169
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=85.9.206.169;
 helo=mail-05.mail-europe.com; envelope-from=petr.hodina@protonmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=protonmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=protonmail.com header.i=@protonmail.com
 header.a=rsa-sha256 header.s=protonmail3 header.b=GpTG6JfS
Received: from mail-05.mail-europe.com (mail-05.mail-europe.com [85.9.206.169])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C7DAA404C8
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 15:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1791907167; x=1792166367;
 bh=OP+QMz+N2i+ebf8jPoc5kpRYqqTRSPiDDKEEd2iUd60=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=GpTG6JfSc5zhbSM7pNJ8LJIwsreyNoFqLhS6bIdXV/MSrUZGiq+nO1y0ZFlO8j7W4
 ykNRPiSjhQ103ppZLRtVaicJQrXjr6Gk1LM+UV0epMPoCeWKkhWEIw7kgWsAXzNhFX
 oUynuuvHm/SpfhPx3rGASdfSaI6gSXYp7+eiljm1K3WhTkwH21mnqjvZYSDK34x+9i
 8qBEev46avmhdBfXRdWQAVYvb3XtfoNNhZjcPN4oRzz3rEwRzYcVoLgLukT5x5DwK9
 WBTSiFK/mKSLQbCcjUq1tmlIekfGb/iir6TJZxjRnLOkh1GYHdaFqxhaKrdg7BHLs1
 rJ5LRwWnVvBHQ==
Date: Tue, 13 Oct 2026 15:59:22 +0000
To: Mattijs Korpershoek <mkorpershoek@kernel.org>
From: phodina <petr.hodina@protonmail.com>
Cc: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>,
 u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, Lukasz Majewski <lukma@denx.de>,
 Tom Rini <trini@konsulko.com>, Sean Anderson <sean.anderson@linux.dev>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Antony Kurniawan Soemardi <linux@smankusors.com>, Petr Pavlata <petr@acrux.cz>,
 David Heidelberg <david@ixit.cz>
Subject: Re: [PATCH 1/2] dfu: expand ${...} env references in dfu_alt_info
 before parsing
Message-ID: <aj8wvIhFZdSil-1q2YQVmKKzohzAE5YcQ-Qb5PT-k7NI29-4EtV5b03isWC-dHOh9tjjyKP-1SWvZgmcfYcus6ip4_5C2y7v8LKldPJG0hg=@protonmail.com>
In-Reply-To: <xhkdbjynl7kcz.fsf@mkorpers-koolstof.csb>
References: <20261004-b4-dfu-alt-info-env-expand-v1-0-700eb0e54b61@protonmail.com>
 <20261004-b4-dfu-alt-info-env-expand-v1-1-700eb0e54b61@protonmail.com>
 <xhkdbjynl7kcz.fsf@mkorpers-koolstof.csb>
Feedback-ID: 23468634:user:proton
X-Pm-Message-ID: b58a57bb0e8c2297720ee37ae0026e8abaa82380
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 13 Oct 2026 16:48:38 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Mattijs,


On Tuesday, October 13th, 2026 at 4:20 PM, Mattijs Korpershoek <mkorpershoe=
k@kernel.org> wrote:

> Hi Petr,
>=20
> Thank you for the patch.
>=20
> On Sun, Oct 04, 2026 at 22:48, Petr Hodina via B4 Relay <devnull+petr.hod=
ina.protonmail.com@kernel.org> wrote:
>=20
> > From: Petr Hodina <petr.hodina@protonmail.com>
> >
> > As dfu_alt_info is read via env_get() it needs to expand the ${var}
> > references using cli_simple_process_macros.
> >
> > Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
> > ---
> >  drivers/dfu/dfu.c | 16 +++++++++++++++-
> >  1 file changed, 15 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/dfu/dfu.c b/drivers/dfu/dfu.c
> > index 90d8b45ce8a..fa074db242c 100644
> > --- a/drivers/dfu/dfu.c
> > +++ b/drivers/dfu/dfu.c
> > @@ -6,6 +6,7 @@
> >   * author: Lukasz Majewski <l.majewski@samsung.com>
> >   */
> >
> > +#include <cli.h>
> >  #include <env.h>
> >  #include <errno.h>
> >  #include <log.h>
> > @@ -178,7 +179,20 @@ int dfu_init_env_entities(char *interface, char *d=
evstr)
> >  =09=09return -EINVAL;
> >  =09}
> >
> > -=09env_bkp =3D strdup(str_env);
> > +=09/*
> > +=09 * Expand the dfu_alt_info here as it's read via env_get() which
> > +=09 * does not expand references the way hush does for a command line
> > +=09 */
> > +=09env_bkp =3D malloc(strlen(str_env) * 2 + 1);
>=20
> Can we explain why we picked strlen(str_env) * 2 + 1?
>=20
> Is it an arbitrary choice or is there any justification?
>=20

It's just good enough solution to work the problem of flashing the pinephon=
e pro and skipping the USB3 phy enumeration issue for the maskROM and rkdev=
eloptool commands :)

Then again you are right here to ask about the implementation.

Looked around and there are two more consumers in 'boot/pxe_utils.c' and 'b=
oot/bootm.c'.

My take on this expansion size problem would be to add a helper function th=
at runs the expansion first just counting the size needed. Then allocate th=
e buffer. Say implemented as such:

-       env_bkp =3D malloc(strlen(str_env) * 2 + 1);
+       size =3D cli_simple_macros_size(str_env);
+       env_bkp =3D malloc(size);

Alternatively we can preallocate some buffer size and attempt to increase i=
t in a loop (bounded to some max size).

What do you think?

I'd later also send another patch series that would fix the expansion in th=
e 'boot/pxe_utils.c' as it's fixed to CONFIG_SYS_CBSIZE and does not check =
the return value. Matching the implementation we deem as a correct one.

The reason is we'd like to use the PXE to boot the CI images later as alter=
native means to the DFU.

'''
        if (label->append) {
                char bootargs[CONFIG_SYS_CBSIZE];

                cli_simple_process_macros(label->append, bootargs,
                                          sizeof(bootargs));
                env_set("bootargs", bootargs);
        }
'''

 
