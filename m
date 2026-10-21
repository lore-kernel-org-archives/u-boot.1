Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF08606A319
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 16:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=mJ4ELsuU;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sI2oPhBn
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7B49E60823;
	Wed, 21 Oct 2026 16:57:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8O5ztydsixIF; Wed, 21 Oct 2026 16:57:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9E00C6082B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792601833;
	b=m6g7wZTBkSewR0xUU4op+a4LG/n66ZDuc4sq+1GV+OiJg/fc+Nd2vsozBee5lc8zA8xZ
	 /z9LOGL+9DN3IxdlvUWNzUHbhqxXeeQ/ZxRBhNefZLbq3BdUruoYTSxQ6TRuIW0mFBsYf
	 z3FDOBCbZRGI/MaAPXVH6l/QlTMx3/LfpCjAUM+fDOKo096MJQr174x2oRkGuVlXrqMeU
	 TPWuFV+VPMQvYdiw3N5H5cuPHFcTIP7nqPOEHPAY3MvRNBhWUqCP3Bc2iXwN8c6iqaLHm
	 Ny4MBhL/ZC2cF9pnxcirHoHVQ9JysZHh35E6uPJ1PkXEBJFtol4pz7pSxuhFuXyTm+A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792601833;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=b6RwSuA8DJeiskGWPD4IoR0i1EoI4guNEYogPO61w/4=;
	b=JIgtSZhZjBsgIDlyhAQroZbVcD/w84TNEDUowfGnVxHvuGaOZMpNHpjuE1+Lhynxhj27
	 ONVg5tb0ilBCmqT1fyjzXUnLDBM6OnuINHf5RpyAb9v8vrpG2ousjHD5WCUAP5WYH/MVq
	 1Q17sWGn24hrHvXbOUfJkb7ZfqOXtimGFfZ14L+JLt3uGVJcPAX2Ebasj+qcUblEQ+Til
	 TNoMrUXWf/ZBsnaxGO+qXHcFpoAac5J7MJRjY6zZIfYlmjAHXhru4QWrG/tZVLTAwxF0b
	 jgv+iWcursNBaM3Me3sxwYhlvO6zj6zZy0t2PQnjGsPU5IJFcZiYxD0n1PKDVGh3Tvw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792601833;
	bh=b6RwSuA8DJeiskGWPD4IoR0i1EoI4guNEYogPO61w/4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mJ4ELsuUBoxcOgClrGRidA/68gJPZXbfHEQBm3CDU2RxzaHawi7usMPRGByqEOIc5
	 oMMWgdZXHG9fL7w38i6kCCfCDYwGj8GVLDsIl66CGKtjT22U1snViW+277LUO/DPhw
	 aBymg6R+9tWhZXrhnmtglKwn2LdBt6VXLqCwU6s0nsyLDXU/cD01kF6eLQSJRLWLbs
	 dTzJmzvftNKMW+JYXYnFi/Z4x4qbOc5qXsMqmmspxTj7gpIyX+fK2SW/sqSJHZGzf0
	 loFuHmEKx97fFGzKFtTB1Rv7OWoaNLvtA+Y3CliA2rpeGfcOlZxCpicmQxA/ScTTn5
	 MvGvFPkzinMpQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9E00C6082B;
	Wed, 21 Oct 2026 16:57:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7F2E5930
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:57:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 65729403C2
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:57:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bT434g2mERMU for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 16:57:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 45F354016D
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::632"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792601830;
 b=IqiZUZC1gsRwe4Bi9BNhl77slz5f5T+T20IZowEirsZnsJqGux1HAU+NZeew9kXnC9aH
 ObOFO+26XbEc4f8+dtWiv7u/ZB2Kume2YyvI0WhRRbSskDqV0zwzFf8mhZVMD4Jbb415u
 ojWtCV7R9AMQeqVRTCLkTcOrH0CXl4Rflip+Gy5TzWHI/1Ex2oLgMT2/KF/b6tjeIVc0/
 7qSDmX53/BvwAWYd51iWsx/0b1AWSVtNDpuNqv3ynabaX4XnPTb3h8CJKieOxujF6dN8H
 Lw7nLNL5aoh4IF4O6Kd1pxrZZfaueW3MeVLwD/VF1SinGRwkk6Vgw6vacAwro3XChkA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792601830;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=b6RwSuA8DJeiskGWPD4IoR0i1EoI4guNEYogPO61w/4=;
 b=H3loBHWC1cOB2+Jwc0pMcZ3JIFnoxIQL/S1NcH6AvEIMo5yZ5DvE22J/9BeNWgQVLtBx
 9fFgedymXQhsg7s3BxwFYQeX6K8t6qWojGXOxC49h9/cuNbqtmMcWmTpbZS16lvhfPCXm
 3YDmEnjzAGiiqP/98CDNYtcfQfvMUtET55S2whpQuNRfAVxVl9TYqMHSrE79rgGxtY9dv
 ua04iHxEdAC9T1AazLxstxa3RVa4wXd6NlCVgCcdUJNCddgZfJ7gBYQecoNCrqpzJxpxI
 JT0DUYx/3J9jOEw6cbnzddEXmFVSmCKGmoyuc6MYKpQ8pyrw6a2jF5gXp7eWX/P2f9Q==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=sI2oPhBn; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::632"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::632; helo=mail-ej1-x632.google.com;
 envelope-from=massimo.pegorer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=sI2oPhBn
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 45F354016D
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:57:09 +0000 (UTC)
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-c4677aad67bso106368066b.0
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 09:57:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792601828; cv=none;
 d=google.com; s=arc-20260327;
 b=T+k54Kk4H0GU/QOOPAiZd3bv1JkJC4u3n/YwPQsVoOktm9AtfSAqk5YfTqzhPGvTAH
 BdGjV9vPAaiCrGCHZnlVNXIllZ2A8p4xeXGl61O4PfpCcp1uiZXuOV8J98zG+ztMGjCM
 TYBZnxeBiFkOfQYf1FAvbzhJevyMXnDa6KQ/kb2RO2aNDUl1PUOIgNw31xbFRGCnYfuN
 V+KKo+F3s124hMFM0Z0pXMAzgaQIQ7Xqm25jzfbxT1dmExPEiNm/ZLWZoDSBqzllLS5Q
 o5w0Qc1PbCcfA1oThjI+22zet325NGYJG6BgD9BEi7YwUhNmVHW6eZkOCmZ/kqXPC+cq
 Lbqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=b6RwSuA8DJeiskGWPD4IoR0i1EoI4guNEYogPO61w/4=;
 fh=ccWVx8YZeCQv8KctAwvgrxv/hAQe0U0pAP09halNUWo=;
 b=T23cmL06TYAGQHh+YIBg7hU8kA9QhtbL3RbGFExqR43tUzwEw1UL3NPEidAsD2OIsI
 Z2MgW1/6k4HE8SKVTzGWfC4KzSnDOrZZnetaas0KG2zBIzyvwcFZyV8aWyy5sDggxJbg
 q5uJfi5J7x7g/pRSXdr/XAnKaKKSEw3I7kXUgz92gSq1dMg0pHdyEvIlzokMa1LayDZK
 N6++lTOwU0pA+uEyyV0vjRQ96PfuhhFilBMGuQSf2TO4J7aFweOLziKX4omfH1DZRG6b
 smPbjiYfq8cVToR/6l6Pcld9NE6d83gxuZdH1UXQ9uZlnUhtrtK3yDMdd1XuSFYh38e1
 0d1A==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792601828; x=1793206628;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=b6RwSuA8DJeiskGWPD4IoR0i1EoI4guNEYogPO61w/4=;
 b=sI2oPhBnsnBs15Sd7IOKc20o/kGuYsef8AxyAkj0/FqevCwzRhwRFzBKtxuXGvnq8y
 mVi+Pccls58Io1sxUB2Xyuen6oUvfu+ZsTZHiXNG8e0p/Mrby9gB7XNHrdnRwXWm1IyX
 caPlyaIoBiGhSlSfYSEvtsq0xXCgMiiyF5Ssj1g51JLlmDZ+9bLpLpjCrN1hSeBbN7rx
 DMXTx26oLJn9Y5OkvPmpVKOXuGg8B2vpTIgLWC2U0pn6TkDcmH+EiTd8jJoFNz1cP4YF
 2JZesphRZope7JBIecqhVWUgRaco2mzLdsJqaj5FXa/f2pY6k8SWEZaXIpRN9ZQDGbxJ
 MyHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792601828; x=1793206628;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=b6RwSuA8DJeiskGWPD4IoR0i1EoI4guNEYogPO61w/4=;
 b=I1V69id7qdRkLbL1MsAegcH1EUw3sedmVgJyAmPxHRn7LPqCg5lswZj6CHqbT0p98M
 lxsR0Y9dsU0FTZkjU7z9AkrlLJg/hdJTXgcPUkPQtSThnGBVX8XkYHG0AjBWcso600c5
 MV4wUfX+ZuQZHGc0s7iDUkd9UqJKVSmLYQOiwmk87NcLgV4E4wTF687AXXtmEn7L+iyq
 ZrO+EjyZUr5xB3Tyw9mAph8SSWYfh/R9QBKBE6vBhaJdDBzBuh8gSeMEDfjMfDGWn6jM
 p3yRwIy5A9FA7WYtU13UR9O9lCWBhuGPpra+P3V6uHYBr7PRNVeGS55mxRPAWqnF+0fT
 oUHQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByvEAB6j94dvmL31XkirXIrJaOvATvsSxo2pT3z/cuqKp5i2GkgpTGo3P9YHB2cHDs9olye3kk=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKgRoNzTj1vTBf94HhS73ch+1gkHLcZZ5bOdT/w5kPlNWEFVKsz
 1v9JXbNT5HRbOBYOKtcUf3eaRUUSGFBIREpEhe9ymQQ6WiwX8DL6IsoXqNPXPDFYZRT7WdXVIoQ
 gfbvFrvunyg6WNs/a/2wmESSRBof5Nrs=
X-Gm-Gg: AYBFou1u/tCCbvyLbtYtGCVM0XAXAUmUXP7leXSClv8tdDvujrq2eldpl0ytAAoD/Bz
 d36KigPHOlXlKZu69VpqbChXsjucrkgLYFv6uSjSljbuW4W/pmLIqxWfngOXDQHMyqbZTDJGtbJ
 wy4pMQXNoU8FfnBcSlm/ZPD3Edb5xydXaRKppmWh2YrrBcMkvJWNSzggRfnOxRnESX+iVycjqc8
 zjyinH+ipZUHCLkWWbg/pA1TxcOfk0eqh7MnwiAe/Mgl1UICstb5n4FQjRdg/J8ylGlRtFnYh2f
 cnT8FaKIqcee8UL8tLo+Ef0RbKtdjEpTJbgLmoyQw1dlMwkvtR6eoeT7qs0E7f+LclKNFpr85qu
 t0ac+IOY6g7VvsmeyjdNNjT+X9HSR6qXeTZ0f
X-Received: by 2002:a17:907:1c8f:b0:c2e:2252:6ddb with SMTP id
 a640c23a62f3a-c467961da02mr251781566b.10.1792601827684; Wed, 21 Oct 2026
 09:57:07 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261020092137.242656-1-fiona.klute@gmx.de>
 <kmHpEJEOTD24XAfa7fSobw@sigma-star.at>
 <a7a3ddfd-e7de-4cd7-8231-be5391c88c4c@nabladev.com>
 <maJhRK5WQ1CTiNrAorY2gw@sigma-star.at> <87cxt31pi5.fsf@prevas.dk>
In-Reply-To: <87cxt31pi5.fsf@prevas.dk>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Wed, 21 Oct 2026 18:56:55 +0200
X-Gm-Features: AclHuK_gJEXmI7H3ZTjJAMF1xOeDs3jxSAuZsp3q7OQqU8Sh86EGXn6fvNTSceQ
Message-ID: <CAC928HZxdfyyCtb=XyHXS4qEs6e0pW-ur5kcq81UMMZC4dtzjg@mail.gmail.com>
Subject: Re: [PATCH] doc: fix description of CONFIG_ENV_WRITEABLE_LIST
To: Rasmus Villemoes <ravi@prevas.dk>, Fiona Klute <fiona.klute@gmx.de>, 
 Richard Weinberger <richard@sigma-star.at>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org, 
 Marek Vasut <marex@nabladev.com>, upstream+uboot@sigma-star.at
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Il giorno mer 21 ott 2026 alle ore 09:28 Rasmus Villemoes ha scritto:
>
> On Tue, Oct 20 2026, Richard Weinberger <richard@sigma-star.at> wrote:
>
> > On Dienstag, 20. Oktober 2026 12:22 Marek Vasut wrote:
> >> >> -   writeable flag can be written and modified at runtime. No variables
> >> >> -   can be otherwise created, written or imported into the environment.
> >> >> +   writeable flag can be written from stored environment. This
> >> >> +   restricts only environment loading, not runtime modification using
> >> >> +   "env set", etc.
> >> >
> >> > Wow, just wow.
> >> > I always assumed that the protection applies also to "env import ..." too
> >> > since the documentation explicitly said "written or imported into the environment".
> >> >
> >> > Instead of fixing the documentation, are we sure that this isn't a serve (security)
> >> > bug which needs addressing?
> >> If the attacker has access to U-Boot shell, then they have unrestricted
> >> access to the system and it is over (the attacker can e.g. modify memory
> >> which can be used to circumvent other protections). For the writeable
> >> list to have any meaningful effect, U-Boot shell access must be disabled
> >> (e.g. bootdelay set to -2 or similar). The writeable list protects
> >> U-Boot from importing undesired data from the external environment.
> >
> > Well, I have a different use case in mind.
> >
> > What if you have something like this in your bootcmd: "env import -t ${loadaddr} ${filesize}"
> > to import variables form a file like /boot/extraEnv.txt?
> > I like this a lot because it allows applications to set various u-boot variables.
> > And to make sure to allow only a trusted set of variables, CONFIG_ENV_WRITEABLE_LIST
> > is configured to that set.
>
> You can do this today, but not through ENV_WRITEABLE_LIST. If you give
> 'env import' extra arguments, those are treated as names of the (only)
> variable settings in the imported env block to honour. So you can do
>
>   env import -t ${loadaddr} ${filesize} ${safe_vars}
>
> That can for example be used to have a completely static environment
> (i.e. never store/load it to/from permanent storage), yet import the
> metadata necessary for doing A/B slot selection from somewhere that
> userspace can update when installing new firmware. Obviously, one should
> also sanity check those imported variables, but the point is that one
> doesn't risk the above command overwriting/setting $bootcmd or $verify
> or similar. And if an attacker has had sufficient access to manipulate
> whatever mechanism is used for communicating A/B metadata between
> userspace and the bootloader, he could just as well have bricked the
> device there and then.

Thanks to Fiona for the clarification (I wasn't aware of the "env load" command)
and thanks to Rasmus for reminding me of the details I'd forgotten on how to
make "env import" safer. Indeed, I agree with his approach. Having the "env
import" command built-in with just the variables that need to be imported
specified should be like having built-in these variables flagged as writable
and everything else not.

Regards,
Massimo
