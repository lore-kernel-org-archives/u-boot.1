Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AD28C531F9
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 11:17:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 04E0D409BD;
	Tue, 28 Jul 2026 11:17:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VDpp_yDlQtXp; Tue, 28 Jul 2026 11:17:33 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 32AD64099D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785237453;
	bh=4MnEwlCIIhB9u8xHq+o0/wAqVEhVaY5HS2KsADYZjDw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VXNccfGtZrD915XT68GsGeDzBJLbs0Gkn/J/VI/o7nZ3KvUSWwAA6WMsS2LwG/LBf
	 yvBh16IxgxNF7hHSp/5xF8XtepnMVQOlblvvyVdiTadWla+L2S+bBFcIsxEMLDKfxM
	 ghlstUQ4ENiYsKQ3vCjA52fWrz0aHNz8E3qSwIqvOoPrXBLdNNxMHoXkCqb/7t8fzS
	 nNdM4LN/LAHgV9zb5wL2gnF/ZH+qJbgQWmWCpGIAzjlHW6VYtVIfHcgRx7cfCoPGCz
	 9JgVXDIKe4AT86YgSRn/2yIhoLPhC7A4zR2h5a8fxWTMRfJL8PLlTHrK9bCXx8ZfSg
	 IP7kteOl+XjPg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 32AD64099D;
	Tue, 28 Jul 2026 11:17:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id AB79942A
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:17:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9D42F402D8
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:17:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0H67AFNUdOJ9 for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 11:17:30 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 55FA8400D3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 55FA8400D3
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 55FA8400D3
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:17:30 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2B4B8494B; Tue, 28 Jul 2026 13:17:28 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF86D848BA
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 13:17:26 +0200 (CEST)
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-69fc2261f2bso4490784a12.3
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 04:17:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785237446; cv=none;
 d=google.com; s=arc-20260327;
 b=IV3Ze6+yzNy9vIjBUAgqvAErv0h60wOhLEtxTDU6DoLZtdGPVbJJ3yJyRpWFUdJMwN
 kgqn+QcobK3a64gAlur7+/naqYKle88fIb59GwyNSwqSl6COye87VqeQOuD2uJvoylLw
 RiPEQyCC+m4ZnBRsq+nQR8bGr+slym/xJy7wwrkUBLg5Pk8EFkx1qMf7MmHQsfh1W2Z6
 fNBb/ryEagLj02Ewjvtd1KKSiPfUUUWTqAtunC5aUJ5P4MheGuPJXQybTYCRwIo6yrdH
 1lm/yPKJP/TiCXcXAxVBajetG3FkNgE2k2fNFH89Eb4dS1gojJbFApXeRVU2L2nbNJn6
 yRAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=4MnEwlCIIhB9u8xHq+o0/wAqVEhVaY5HS2KsADYZjDw=;
 fh=runy5GsEaBbwYs4tLCkIDKGakFI3WhxP+HVdMM9V8MU=;
 b=du8WrLNT0pc3/td8A4yKaR1Ae4BJD6MYAKSNffYO0vcrx+Ft4pl+e/KkeOPzsotlnt
 TF6Ra2ZT8YOJJjqdlWk42d7aLdDZz2nkdaFCZTbpMaE6FJ+kHh0z13getxBHZVWpzhs3
 YS1H7rFNKzjnk/GVr96FmKs7GR9EFZBjJ4C+ncCepglU8bC+FWwVHHoFUXodFmfz+rxt
 TZZJDYA0hTowftSV8dla8ME0ZGTwQ0PGyNpPMAYZiDu+AFRZc3syTOZNJcskHHx5Rbka
 YgI9SZpkviujN2GoYp2LNocZqm0DNHLhHDUc5qzDjigzL99wSuR4auMU1mEZxdYwpi+A
 3u/g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785237446; x=1785842246;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=4MnEwlCIIhB9u8xHq+o0/wAqVEhVaY5HS2KsADYZjDw=;
 b=olarz1uYAeOIrFFwNck9jJ9b9URhg72EglzXj+4i3tgzbeVzPNeJV0i9XuRJSvYQ1H
 fSn6IcfCyTjiKXqpVPGWXjM9hzzM8eWSHIjoTGyUSnSOkNB9nqrd9PqKiCq6Qrngp6nO
 IPFU1q/cmjg0KGUhA6pMm6/09Pj22DW2KC9/etMeclWzAzPI8VZkmBNZ46PrXrPDbyLt
 DkiJLnGQsvzD/wvBDdP/CXy689Y2bKVDZWaeZlwhMJ2o2j+kX2iGFOz6e4QiJvzHOF7N
 xdEIFQlY+WrK/MD6emR6N0QIgjqN8X/GOlL53TPJDgM41N3qPFyopmw4SoQ2mCIX7NnV
 5WXw==
X-Gm-Message-State: AOJu0Yz4Ff0AoRzG66U11s7+pE/P78ZBOieUDKZmaECjXCUKtWDRPS5C
 nbdLO0SrSyHK6lr+1U6kZdAtrXhd4b6sT90epmIc0757VZ/VGaAGedYbmRw7xtvgsLFwS08VqPj
 n6PccWqcBR2NEXIv1fQIR19PCIBOXrIEsyUBavnwJ
X-Gm-Gg: AR+sD12tZkrC0tKYeNKYi7R90Px/UGKLJ0qvkZTKDF6q15LcaHke43L3MQ6UlHZbxET
 sUOVozHYW5PBou7c0cfwFBUGCWwDsZPvv6R+KNPADVOvpFjki1wvmRRwtGMTJ1iHPfhl44Iplh0
 nyP1n9Y65A7kqQhr6eKPNqx6dpeBwNmntshaiYDrf4x6zw0Vj7lA1PyFZVjQ81aNbkVF+cA8Q0O
 ks+dCZt3lJpEdEB7SkEszKUQnOZIhLMmkD2JMWJl+yH4jHw+76AFgDXXJl+
X-Received: by 2002:a05:6402:51cc:b0:69f:e13d:b9de with SMTP id
 4fb4d7f45d1cf-6a034a87c75mr1044862a12.36.1785237446107; Tue, 28 Jul 2026
 04:17:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260716223401.378989-1-dmukhin@ford.com>
 <20260716223401.378989-8-dmukhin@ford.com>
In-Reply-To: <20260716223401.378989-8-dmukhin@ford.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 28 Jul 2026 05:17:11 -0600
X-Gm-Features: AUfX_mw52nq7MbYRZK-mIj4_UlMC-l3xeOme7Cj4-jQWzay4TJHWjXo-krvvYSA
Message-ID: <CAFLszThCv+jZauSokXt4PchY-iTdV_O+Shx_icYWbCyDz2Nj1g@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] tests: add blk_dflush() coverage
To: dmukhin@ford.com
Cc: u-boot@lists.denx.de, neil.armstrong@linaro.org, seanga2@gmail.com, 
 sjg@chromium.org, trini@konsulko.com
Content-Type: text/plain; charset="UTF-8"
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785237446; x=1785842246; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4MnEwlCIIhB9u8xHq+o0/wAqVEhVaY5HS2KsADYZjDw=;
 b=H2QgCpKau5u0Bn/joUza0OoXU1iKNaarcOLsCVWFx6FVaY5Gav1YP1JHX1p329sERn
 IO7pW/CdjCbm0PlNOjdbYHI+vt+IJQCiFl20vR8SJxeGGSq+c77fRHZs2+SXlyg0nwzw
 O7jIVhPBtSy5DbnbnnL6ePU+cuixI6V027HNc=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 spf=fail smtp.mailfrom=chromium.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=H2QgCpKa
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=sjg@chromium.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=chromium.org header.i=@chromium.org header.b="H2QgCpKa";
 dkim-atps=neutral
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Denis,

On 2026-07-16T22:33:54, None <dmukhin@ford.com> wrote:
> tests: add blk_dflush() coverage
>
> Add minimal test invoking new blk_dflush() API.
>
> Signed-off-by: Denis Mukhin <dmukhin@ford.com>
>
> arch/sandbox/cpu/os.c   | 5 +++++
>  drivers/block/sandbox.c | 9 +++++++++
>  include/os.h            | 8 ++++++++
>  test/dm/host.c          | 2 ++
>  test/dm/mmc.c           | 2 ++
>  5 files changed, 26 insertions(+)

> tests: add blk_dflush() coverage

The subject says tests, but this patch also adds os_fsync() and
implements flush support in the sandbox host block driver. Please can you
split the sandbox bits into its own sandbox: patch, before the tests?

> diff --git a/drivers/block/sandbox.c b/drivers/block/sandbox.c
> @@ -52,9 +52,18 @@ static unsigned long host_block_write(struct udevice *dev,
> +unsigned long host_block_flush(struct udevice *dev)
> +{

This should be static, to match host_block_read() and
host_block_write() - it is only referenced via the ops table.

> diff --git a/arch/sandbox/cpu/os.c b/arch/sandbox/cpu/os.c
> @@ -139,6 +139,11 @@ int os_close(int fd)
> +int os_fsync(int fd)
> +{
> +    return fsync(fd);
> +}

The function comment in os.h says this returns a negative error code,
but fsync() returns -1 with errno set. Since blk_flush() propagates
this value to callers, please can you return -errno on failure so the
caller gets a meaningful error?

> diff --git a/test/dm/host.c b/test/dm/host.c
> @@ -62,6 +62,8 @@ static int dm_test_host(struct unit_test_state *uts)
> +     ut_asserteq(0, blk_dflush(desc));
> +

This covers the direct blk_dflush() path, but nothing exercises the
partition-level disk_blk_flush() path added in patch 2, where flushing
a partition flushes the whole device. Would a test for that be
worthwhile?

Regards,
Simon
