Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1939A606A31D
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 13:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=kNr5BqdU;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=n4eQyYYY
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DE6FA605D0;
	Tue, 27 Oct 2026 13:46:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T3vNe3k8HXI0; Tue, 27 Oct 2026 13:46:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 14F1660719
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793108791;
	b=Tc7ai38ydd/uywIWZRu19utCJgljSwlEIjoMRuJXScKhTyU90WYCGM1+0UsYkdj7MYt7
	 VrzExPFarspg0MQNTrbhKXRx5PZ2cC5loaVAVQ1wlHg1MoB1cbI1f/YJhsCqtTBSUqHQN
	 Or7e07ZhviUQLWKdMIH3w6HCEeu3n7iaB0L/nYbnXjw6zRUpejPliWKpWyEdV9JgNFXjy
	 Xs6DGFSgvkLFHliWoPhxCblx6dDeOqOaTmmA1MUsnVfHJW4wBR3zui0/0DNWTXcKjg1se
	 ns9oZ20/xPTwBUzeu/zMwMCwrCL3Hh+lfmvihqp7u9nGu6apUm0d+56yWNbx/mVIvhQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793108791;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=kcADL4e0Wajl42nrW/x8NHHpHl8/mlrfNPny3RdwjH0=;
	b=GKpB2HjqmakEihPEcCqIEjcTNbPVXAeGXU3kYh6rrnHhWzkuXKsN4iTYjEzNtUdwLk9+
	 0OAKUvO6SqllU5E0dFojnyZLl75qFHYcEz9UJmCyaugTiHNOHuKqNldjLZ+cXgPSzukAo
	 G8Yg+mB+4LBiq7OOMhJLS4PZFwq6PWpXluozkdpRzGTcd2vKKcwns5bJlH7MiNSi//MCk
	 +eT0PNjx2R7KzXTaR7V5MrZbuSUd4UL4JP7fwPkwPwyoa2Tei0sYSA4jv0G+qeu4UQXYg
	 aobFZUp5HgiDiOm0cGwNbwpCkBP6X7b6MLvX52+Ezt+ckn0LxkQMuObezijMVFkYBIQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793108791;
	bh=kcADL4e0Wajl42nrW/x8NHHpHl8/mlrfNPny3RdwjH0=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kNr5BqdUvILgCqgmU4TfpmvoMod8dpqfa52U7FVO0c0Zmnls0+AbT4Cn77CNYwoXB
	 kyRGuEoU1LEFUQwJYBWuBxcCQNjt+v+3z3jU0z00W3W+VEyAXei+nwwC8DO3keNmXI
	 G1Ab+NhJQ5lWl58NhZ8RUkcz8JdjAVGtUMbOZwLzvGBWPrQWZr3TZQL3Yt1Pi0haGc
	 EJ5cPtUDfO/s7O7Z1/wemKwdABz5BlgDkugKV7+SMhQgVvvytYTcfATzOt0A5SefRG
	 9lUITRR9MIOuZcSCLwDltAFcD+efQu9mB3P48VOt/HSmDoLGQoGXXYuXKVMgWnQHFV
	 FBXEOV8fr4ooA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 14F1660719;
	Tue, 27 Oct 2026 13:46:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3B716279
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 13:46:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2D31080AED
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 13:46:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HE7Jc34ILkut for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 13:46:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 38A1C80ADE
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::530"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793108789;
 b=YyDFYRKP/9t2wKNK6G+AZjg0bk8PPrXMiAInRBAsJL86jc8vd+aigZZm+Tr+2O+k4KzF
 79co4nhXTS74RlDcuIYHhFd3Sn32lRcYT0grm5wr0SE8xDOIBB61m8AWvHCuWy0aRJMn5
 aJUurOAJikaoM3akg31AI/L7bveZ9JR0vcmWf0jRypyhZ/Y8V6t9AhqWYHrbAtQPCJk2a
 fxgKydYGB2hHt2blqJzLULCJvQ917DrM0f/+XrLix9oKYC5nc/bDnwJUVYVmal/MYPQp/
 vKuVE9U5kfZXU0/HHYvQZRHj69ytq/YlNWOBADB1Ki8iQoZUDrxd4YZGDcqV15khgrw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793108789;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=kcADL4e0Wajl42nrW/x8NHHpHl8/mlrfNPny3RdwjH0=;
 b=KjtH8Sq9gSrSt/F6L5zEzMLZdAFBt/0IlwMTROYVcLGG+p4KNNb7Hil0oOxj2QYxnA5a
 es4PQLTLyOauGMNvIA8FOrRPjeepyvMTHTT2r9idQ2naURAn7m8oklwG83UMyCJdEsOUk
 sttP84NpAkq7vLoRAQGGKHxHPwmDQ4fHWkw0oWBeZRJ+MI/FJ5RTzVWW18FYqF/svG2nE
 mPwht3moXQ9ylWeVYTXm/lD2qXJuRAOlKrlr2lZ3xspjnMYqTObImUXptcfjVvjSvP0Mh
 k/8rjqjUJ6Tpr5XBdCwLVhdnKfr2Bqo/2ayPJ3jI/zORnP3nRt/J5zRBxbo2Pd8CBiw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=n4eQyYYY; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::530"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::530; helo=mail-ed1-x530.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=n4eQyYYY
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 38A1C80ADE
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 13:46:28 +0000 (UTC)
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-6b4883643ccso540985a12.1
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 06:46:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793108787; cv=none;
 d=google.com; s=arc-20260327;
 b=bQdHT3STnznFpwf43M3YCHuZdrBgRW+Pci4vuxJawO68acV/ImBIjPmdnuoqAYia2e
 PzICmEG3fA9CkCQ66hNc9M3/MbR5dBjdHSiXvi5THW0WktJO3zG/0ioHQESVs6N/+OWz
 u9YkuM0tQI+WwZX2tQbF7aGg3G9bA2tqOGadzofeuXYYS/7Eg+j7UCkLbi25eOlKEuEN
 KlT3PtrSorNpwWmXcrdpA2yl8pzMOJ7VjrNZx6ydb4uOOFwWvaowb6/XNFl3k5qV7eGg
 ZvCz+z0wZjuNu2OwKGPYKdLiyod4vImLjhiz6kJlVgGQuu81xrtJLBB/s++x5Mv8zWgL
 AFrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=kcADL4e0Wajl42nrW/x8NHHpHl8/mlrfNPny3RdwjH0=;
 fh=uOXiX/FK7Op6ux3YVCK3wLiLMkejBefoITtZ4+fQo+M=;
 b=Y5SB82I5Dh5ze+KmZK+ecHv6gjnHcxHn78hFp/axHOpwa5bzeq99b3HkDRSX1aVsbL
 ZM5bTagclFgW6jxtFcR9r2Xr06+3f2BqNNIf0bI4KzHogujMB7ho/YsLZsAK95XnUp+3
 QYIAIpfsRtZKBok+p9WkImuUwXle8vJ0qj20EtuIBiXd0E/6OLTrmlSm2AUVGg1C/nPl
 CB6qoOkjUmrDBNIHQX49zuGxgg4FhwlHYRaPcSBsKRG1ByIABS3ND3dYxuN/wUgr6jTJ
 0DvvHe+Vmxq876GlD0KJxGkQa3EaXIQdGNWUcCaV1Km74TN7SmkjgJ/nlzheyb4ei2Zk
 1CfA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793108787; x=1793713587;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=kcADL4e0Wajl42nrW/x8NHHpHl8/mlrfNPny3RdwjH0=;
 b=n4eQyYYYxQR0Mqm3xVzigClm71/7Ug/75YrtQuX9GX9ZRnkS4PY3/issjuwD2a2Hmy
 pBqKh4uJf75L/3YIu6BZXpQRU8TGedM06fHKBCHgcE+D786gI8ycWCCUdGY4qoShymSC
 j+dGFGyyJfQAc5BVsxAZd43Exa7b65YJD+FiU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793108787; x=1793713587;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=kcADL4e0Wajl42nrW/x8NHHpHl8/mlrfNPny3RdwjH0=;
 b=YFf0yfJ7KPSFr3C3efv+GO02QPJxrDW8i6cYyDrKPfVJmspkjKkSdQnaLD8HtChNNU
 3+wuCHPgzDrQRHUF0q/yZ0p//S3D/3EGlfks2Pt+EFjCGx6cunArv3QkQbKww91w6454
 ZhgQmMDz7220mnkGBx3RZzuMQROR6VfB2aW4WKU8UzOvfVH4SiU25og1DLooOmefCaPn
 O8d1J2IgtpLKuFD62fzfEEKeOtQwHWjqdW3RVkVR8wumpwjPkfkA+/UmVx2JalwRw864
 6A0hsoYu02YMlMGG3SVGdmzgqn3qX0IEgoAxdcKwAF3aUEyCmaV8YQazso+ct6g80IlQ
 OK6A==
X-Gm-Message-State: AFq9FYJnWsE8OYIqbRWvqyuklSNBlMl48kKbINglyqngYEaAUT12oNVP
 9Ed+oaJ5/xL5Ofg/0t9LB4lIpcJSB2rz0sHRkY4W519A0wjBP+SdQ3HjWC24OvTI4TlfMbnX/Dh
 qjDSJD4fN+ml2ToH06leUX5/MktQg2w1rIIaRE2+y
X-Gm-Gg: AYBFou1dlTQYxfe9WmPGdBHunRygmGUlgi+wMRPGidZTngoxYOXnDtcK656wlX38mdY
 ixOijJacDU6NTKjZjSUXBNVbPN0vmrbkZQlYojYYqUo4HNweAi2xCyF22Eqt8Ea3HVlxbV4Uvg0
 lGRcP6ZN4E9RRqXfVkVp4UEexafjhQCRGZd3CaqfnDAOa7vfUyJATixCH+c0qiEAiY7WimXMtws
 IJs6Gfpur4mHOg3R/no3uBQZON5H+EYFLnP5YOHvg2Kv9MYtCMfayBuITgAVs96X2ET5y23gaeP
 Fc/ZPeZj1Ow5twECssFsav1JUsr9x7ofRhBgFGtljHVpTbKJNQt5LF9Lgvz6uuhqn0MVjFSDGOK
 OuKEUEI2mdD6K6rS3TIh+Kr3HLL35/LcKbwk=
X-Received: by 2002:a05:6402:2346:b0:6b4:1037:2b9c with SMTP id
 4fb4d7f45d1cf-6b443113977mr11764155a12.41.1793108786827; Tue, 27 Oct 2026
 06:46:26 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 27 Oct 2026 06:46:25 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 27 Oct 2026 06:41:41 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261026-fat-fs-fixes-v2-0-41ae696cd353@siemens.com>
References: <20261026-fat-fs-fixes-v2-0-41ae696cd353@siemens.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 27 Oct 2026 06:46:25 -0700
X-Gm-Features: AclHuK-09KR1T8BMDmKl2Y6W0nHT3ygUgv5cdtJ71T2LfrvIC_s0d7zZpOH1dcA
Message-ID: <CAFLszThTrnvyhkLgD0OyX-rcpaOLRkMj4rc-CcNvTLfFeX691Q@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/3] fs: let EFI Write() keep the end of a FAT file
To: cedric.hombourger@siemens.com
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Qu Wenruo <wqu@suse.com>, 
 Alexey Charkov <alchark@flipper.net>, Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Vincent Jardin <vjardin@free.fr>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
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
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Cedric,

On 2026-10-26T16:37:26, Cedric Hombourger <cedric.hombourger@siemens.com> wrote:

> fs_write() with an offset trims the file at offset + len.

Just to check, this isn't true for all filesystems today.
sandbox_fs_write_at() opens the host file without O_TRUNC, so on
sandbox hostfs (and semihosting) fs_write() already keeps the tail.
FAT and exFAT trim it, and ext4 replaces the whole file. So fs_write()
has no defined behaviour for the data after the written range, and its
comment in fs.h doesn't mention this. Please can you document in fs.h
what fs_write() does with the tail, as part of this series, so callers
can see how the two functions differ.

> 2. fs: add fs_overwrite(). It uses an optional overwrite() operation in
>    struct fstype_info. A filesystem without it falls back to write().

I don't like the silent fallback very much. fs_overwrite() promises to
keep the tail, but exFAT would still trim the file and ext4 would
still replace it, and the caller has no way to tell. I would rather it
returned -ENOSYS when the filesystem lacks the operation. EFI can then
decide what to do, e.g. fall back explicitly with a comment explaining
the limitation. What do you think?

> - Naming: fs_overwrite() is what I chose. fs_write_inplace(),
>   fs_write_keep_tail() and fs_update() were also considered. Please
>   suggest a better one.

To me 'overwrite' sounds like replacing the file, which is closer to
what fs_write() does now. How about fs_pwrite(), since the behaviour
matches pwrite(2)? (fs_write_keep_tail() is also clear, if a bit
long.)

> - exFAT has the same trim (exfat_fs_write() calls exfat_truncate() with
>   offset + size). ext4 refuses a non-zero offset and replaces the file at
>   offset 0. I did not touch them. Should exFAT get the same operation in
>   this series?

I'd add exFAT in this series. It has the same problem and looks like a
small change, since exfat_fs_write() could just skip exfat_truncate()
when the write ends before the end of the file. The new operation then
isn't FAT-only from the start, and EFI behaves the same on both. ext4
can wait, as long as the fallback question above is settled.

> A test for efi_selftest is not included yet.

Please can you add one, along with a C test that calls the new fs
function on a FAT image. I've made suggestions on patches 2 and 3.
That way a later change to set_contents() can't quietly bring the bug
back.

Regards,
Simon
