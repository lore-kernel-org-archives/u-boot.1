Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0212A606A319
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 08:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ZC1IX5Vq;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=kO25zKWe
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C1C0D608A9;
	Tue, 20 Oct 2026 08:03:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZcRpj1lFDrJ3; Tue, 20 Oct 2026 08:03:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org EECEB60849
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792483381;
	b=EK2ZxtrBxeUI5qbH/8IlQg87sw+aitk+Y6KnxGZU6Yl5nnyuyQKOak5WqbRu5yOZ7Q/u
	 YG5Btgw6J6/s/RavkhEopdJdgDFalAGb8TzrqWPO8Mv/hIRkNXh1ciHWP/j+QheY4nVO9
	 nBCvkbK7ICBRbJ/eiN0cyw4AJlTVd7d1y6oU1AIwBn2RgpwHR7nF/EkniAK6YDor09iXi
	 YEun+OrKzWjUgychrNnglgPwIyMoZKFTvJ9Drx/4e5QurjCj6J714dkdIw2sUMs7r1AYf
	 MIrhS2y/5/cSaDZ2oyQ05KvtQ/Tpln7g2al9EEhq1f3FdNd+epywZZA7FnAHj2+SjLQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792483381;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=52fVBYFKWYBZN+qJBCefInOS+HrZEcqY3fVv792lxlY=;
	b=CyuWuqLDeIdfbVdIu8YFYhvl+2x0ptYE4OV1zqC7qgFE3YX9T3dYiok81jqb97jI/AvN
	 8Mr0B3k/vi1EzIfoA9W0fnbDxBsIMo0iBn1v8E/id9HtVca2v/ugM0iw7P28pSyi1tBNZ
	 WoltLAWYCvYzt3ynMsmyrYMz7wkHGedQFDIMFx/Mqc7Kh4SlhWfb+nx7vo2xu+ho9ZA8t
	 zhqrw/gDIRK6i6UvUGXyGVSbHA8TK7SvBGeOzdEr3AUhbszg73AGV364ZSIamEAvSkV8b
	 /3zgqJ2+wJXQvvYkWn8AP01mQoAx1LKFJmCphkNrDBXdRWIn0sjgkDhqGvLKaLmjljw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792483381;
	bh=52fVBYFKWYBZN+qJBCefInOS+HrZEcqY3fVv792lxlY=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZC1IX5VqLjdqgcQWGT1WQVQg4H3QmkwCnUqhJTzTtkqEQo+aRHrN0nJxJiZfIMIBw
	 R+Quyp6kvjTKx/bqoV3bO36scz1kVW4KYr9a7PvXjhqBHOKelo83a40QsQHdzQXpuH
	 ejDcs1VRs/2AdCjSK5hVWuXl05XqwQrKEMNQZ1H8bx3CLF0j8Px2ZiLCPzrxAFQkEP
	 57napfUDEK3xvwB65CIS5FmBZSVebniR7sywOt1EL23UjQ8Zr+ofAgHh/OvVq8chpo
	 pClHHrWZZmxz45OULgZ40jUIZInQ5J7zpz2wXEdT1eRQi3aR7elX4wWOilW7NryJx9
	 RjhUZPXFUfGgg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EECEB60849;
	Tue, 20 Oct 2026 08:03:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5DDC723A
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 08:02:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4C53080F90
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 08:02:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TGR1va4PJ7yt for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 08:02:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9B7A380E09
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::102c"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792483378;
 b=q0XVCsiKaA6aLRoolft6cCXhB26K1WjIVobHQjOk9zG3WeuJA7R7mYgcT36A0QdjO+VM
 K5vjSiPRFYkgd31LMHs9klc9Zy4ED1gaTIgNvJq3/bdYNZDfnc014mh4EG6IrcItv/5s3
 yasJ0pSZvw8qoEBeKpdlfFup8zNa9RMA9eljY8iCfJP/Ff11Gv+WefcLlmeHtl5T/YZjZ
 /WO1gYvrG2LvnQKILf8OJmgOudi/60x2yJp+8AKtHUjnaBECcSR3+A6RDfQdaYx0YoXxk
 dkRgJj5lnjOn7XvrppOnwrnXTlckzT871Xo5Vs8QH57mau+xLBNhjFgts3CwRRwNWVw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792483378;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=52fVBYFKWYBZN+qJBCefInOS+HrZEcqY3fVv792lxlY=;
 b=i6MGdn9SihaNsDd5SrOs7TW/Qslsmz/TCzJOU/14CefBSD4YkpGWri1ufh4cIPl1VcvE
 b5lyD2ennStQodPoeylWMUN8nyEymeCfsSIQuHYk8Ci87k2zMLy5S9NmADmUrtvJBPOo3
 q2TRWCYXy07rPs0WAQcb4gpgicg6FSmBIhrSTs6M/5sbYjXLvY5dN31fso4VJ1rcJ1AWQ
 p6VHjhhYB8mIIkYhALnFsCU0B+YQeMoMZcEj0aMsbVjYHPlVWkrhhgi7OGNnW+0S1g6ry
 0RdDbfKUGi+aTjRM6PlorvtcGuUKOsTNBMKu+Tsc70gFniPZ2Dw3RzONyLYW2ppeFGw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=kO25zKWe; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::102c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102c; helo=mail-pj1-x102c.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=kO25zKWe
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9B7A380E09
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 08:02:58 +0000 (UTC)
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-3ace9e6e1a5so291744a91.0
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 01:02:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792483377; cv=none;
 d=google.com; s=arc-20260327;
 b=GUvzdULE2CkgYWQ3Aux8J0pAq8oEgSbBPqjAfGEn/QwnDVp81kH228xermYUDngHjc
 7bcpGhkpuAM3zr8l3UuylxB4s+43ES+Ur6eHcj0FwMbupPoT91Gd0uYYALlHS/o12Ulw
 BpinoZHtzcPBSgmv6FCGbWB6VVtnhIBK17LKKxAQgghqGanD9mdwpkHO3YxomgJR7MaO
 jkL/mfY6zT2rm+L2We18/15BVMmCENWOH3cAwX4RgfMOTHTziRGO6Sn85KDV5HI013W8
 z6q9Oy68fTrfVY9CfgwsrxBJ74T5SOfN4y+4WZRFv1rBWuLOzxHV6VXOTUexGHJor8Ot
 L72A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=52fVBYFKWYBZN+qJBCefInOS+HrZEcqY3fVv792lxlY=;
 fh=tWtJHLJv0cKMy8d1t2aLwQwqChuuvJ6GMSFVZEvrAmQ=;
 b=lPSn6rpeYL7KsZXVdTAcGazs+jq5DoV8gktfUenemDqNCMvTKjtu7BRucx/EbC7EMy
 3t2FlgniB5buR5S+LiWu/LssyfWFYReTKY+gLsZP/SWNOTXTkV0t+hDqEFeBNyek1lE0
 3oky24Cz8wO0n8goubys5xuwyrFWePaZ146SKNjF3yQq9o9odRG0Jb4PVH4v3HWmKP3d
 BPIWeQ9GsejFBqqnTAmNFUwG0tea7Arit/glGnF0zqi+MF7kIsGaywnW3YnIMpd4qTCp
 vdcHpnAO2wC//S1PmPrmFJAOQbqPqdWB4zl0jjuHHb9xXyE5WKt1FAtvNuUhf0CpBTLe
 ebww==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792483377; x=1793088177;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=52fVBYFKWYBZN+qJBCefInOS+HrZEcqY3fVv792lxlY=;
 b=kO25zKWeH1Wt7/X83oA8PKPgUMFoAE5ndNzXlWLnLUTPMmKHtnFTHxYjsf82D4pm9X
 z/lEkuZDaRZ8XAleCJaAxQybkkb0FHyPNiAPYzErXZCWmBkPIoNK5jxGYrvbcgODCnEz
 dyIHm8OCru4jyooYpreaAYuGvq+Ah48PEniMo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792483377; x=1793088177;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=52fVBYFKWYBZN+qJBCefInOS+HrZEcqY3fVv792lxlY=;
 b=KK1ZGRY2ZQ1yMksxShrLLWcwDvb4AQPpcxoq5wrSRllykeQkg19R4TM2H1lvp0soAK
 m0DPxlV6P+Y5gHOQQ4ATv/HfFulwZ7hXSb59cJRhRlk2drcrCqNKQ7qUB96T91gw6x5e
 M9rXHIEGZOq3Xm6NrPOpDSZuXLYlL6GLnaK3Spc9kVWAwS8Q2WwHXM/4mJ9HGNh6Zs2w
 91AIoWxwFULPk1+TSvxgkp021tSynzHxYHpQsnIYv9jvEnfaJK1iMxbn57XYStWUSgBm
 DGOSrIRDPPCyLFwnhT9B24nC/tFGR4VuZJMR+zMvkJTVE2hpRgs+BHuDTfpJdzFYLXtQ
 p4iA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz4w5vXVAucb3J2e/FdM3NcFUq1JK9zlimmj6NNsD9KY8m6EFrUNVOc6qwnsJZ/m+l7t1WR2Pc=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLFozPvqLwRfeYO2MZvEl+bO4Lq8PHzE3NtUx41K/6qoVYyO4ru
 tjtKxMlvbZc6t/J6ZSHYVMB6pYGfvl+UxAzygbzzrHwgEBFZJ9BqF1ypqMxq9cU75CZu5KhVgdy
 xk4fd3TmVs7nnYpWINUPdFum3yUQRKB5Puo3vxkw7
X-Gm-Gg: AYBFou3w8w71H+PlEl3UP5uIuk156KB1/7rQqwgel9LA+M1yGnfXSp8sf7asSiJ4ovH
 FxO6H9NUH0pfD5SY40Jg/qw/wakUXcOwkphc5v09G/et9DABPqzKF/+KNgAW7WJWM5eRRJ+XyfH
 qy3ejvt1cMXwqegLflqB4qpw7q6x6y/1Sm+8aMR0r0GE+uv4VvKnrNvZ/Zy8NrNbcrqqM90mJDr
 3LpJAsP/e1QZtnIccG05o6eRqn2ofkrhKuqI6Q9ENk2/VvhO0vpLDbpO3OWqoxFrNS9/Z5zHVKY
 hA3RjnmjTiGd0fbSxQGF5GHtAdRmCxgdO92PY6t0/+TTq9nIJS4csRSeWrk0MwP8F4mOb+9Y1fa
 aZeU/I5pa9pbHF0K82t41ugg5zWpW+RNFxVA=
X-Received: by 2002:a17:90b:4a4f:b0:3ac:928a:68ce with SMTP id
 98e67ed59e1d1-3ad64bda54cmr845369a91.33.1792483377627; Tue, 20 Oct 2026
 01:02:57 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 20 Oct 2026 01:02:50 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 10:31:59 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <a79101a48ba04103503ad7c834c05f160964ec13.1791966831.git.daniel@makrotopia.org>
References: <cover.1791966831.git.daniel@makrotopia.org>
 <a79101a48ba04103503ad7c834c05f160964ec13.1791966831.git.daniel@makrotopia.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 20 Oct 2026 01:02:50 -0700
X-Gm-Features: AclHuK8iuPEam5lkY2EG38UHH7nX_dTYRmgm7AaXzXnEj4HPG-7dIGBq0ZEy7kI
Message-ID: <CAFLszThhirzXMxf_TXGYL05EpCK8Jn+ZM_aMp1ucm+4GXDPq+g@mail.gmail.com>
Subject: Re: [PATCH 08/11] boot: bootm: set the imagemap from bootm_start()
To: daniel@makrotopia.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Aristo Chen <aristo.chen@canonical.com>, Vincent Jardin <vjardin@free.fr>, 
 Anton Ivanov <anton@binarly.io>, Randolph Sapp <rs@ti.com>,
 Anders Roxell <anders.roxell@linaro.org>, 
 u-boot@lists.u-boot-project.org, openwrt-devel@lists.openwrt.org
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
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-14T08:38:38, Daniel Golle <daniel@makrotopia.org> wrote:
> boot: bootm: set the imagemap from bootm_start()
>
> bootm_run_states() puts the imagemap back into the global images struct
> after bootm_start() has zeroed it, which leaves the invariant split
> across two functions: any later state that calls bootm_start() again
> drops the pointer, and BOOTM_STATE_RESTART is already close to doing so.
>
> Pass the imagemap to bootm_start() and let it set the field while it
> initialises the rest of the struct.
>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
>
>  boot/bootm.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
