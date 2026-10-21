Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFA2606A319
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 12:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=vRj9rvUU;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=lL2aM3Dc
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AAA9E60834;
	Wed, 21 Oct 2026 12:47:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 22MsGNQAgkQn; Wed, 21 Oct 2026 12:47:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E24DE607E4
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792586879;
	b=MZ6T9i075etGori7bYTIhzaO/XsOkFGPBMIMSClFzCvv3GlCze+s2ISj5mjqWD9tmMQ3
	 pLL0kfyVencEjb2LHEkN04lMVXjacmRW1BdT8MRchK/RXeQFXqL1leKyfos1BEw+DaAAU
	 K8C7/gr2m7TmXjaPTZkfPw22pjzYrmlCICYHj+f+L15k70Wha9l3QJS5PyyuJw2hL2NsN
	 LDmcPhHGEFWFxacoBlkyrpZxzcqBSpJTcNKqVbQJGqaTu7p0kYginehGcUb/S00Xf0BIt
	 y63OI8nRxEnbt6romthnkWW/IdO8MqhKYBwyOSseVx7GfnnaD+w9rYgc5U0VZXbYKrg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792586879;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=bJ3lshCLB2k1NM/Xh6MsPZi+yJV3EGeyGCcrkx/Ht2g=;
	b=O/z5Bp27cXOq4Q8FOgUH9o+wPc05YTeP7XH+3lYLfIfJWM9xJt3HzmWXOTsJFBjW9VTO
	 5XDX5KLBZQyi5ulfJq5RpWcec6XpSyo+JyiRcTbPLDpQ9RsAkc1SXFbUXP0H3oaMzGKDz
	 MJSozv/rhvERxob79L2BHXAgA+JdRqoWQFMhohi81qfDzuepSPHzomi0ug27UwIawOvho
	 wj+cmGDbK0OMeF9ALYjDpUyMGZm2fSFANkoBU+V8Pkrgc7SJCM2vJvjI6BT4xEPnFCorA
	 rYQSF9r+DVbxi/0wKJe35yu1il4fdzD8jcAU32hXuMw7VE+eVyGkVyqKRwOynH7K2SQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792586879;
	bh=bJ3lshCLB2k1NM/Xh6MsPZi+yJV3EGeyGCcrkx/Ht2g=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vRj9rvUUQyf7dEANvqr+9b874Iv49sgpZw4sH00xcXnwXtSS9j+TuGLUfmT81Gc4V
	 DwLtcd76r9adA+rGYEQr4XufYwQSdfPtt1rVejgPsY76n6Qle6aTnkG+oKM8mjCfEN
	 bH/6UN9fv30eV+gXoW4IvTNQrJ2b1mFjUn3ckQhGVmJysy+KdN0A+Ui77JvWZ/e2s8
	 3m4GV5l8g2XQ1zgZ9HriygdI0SLsB/jgV2vXdJGW/c7iPzxjV3O35ayyctCZWQWc5D
	 v/hbaE05M2TS2IdPixrXwsDdekW7qwMgyh5DCXu7r1X5YT+nn+Dj4DNOpt8zyxbsv6
	 Ztckuihbfc2rQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E24DE607E4;
	Wed, 21 Oct 2026 12:47:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2505A3AF
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 12:47:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0B5C840866
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 12:47:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YFCNisc54t4R for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 12:47:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0925840820
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::530"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792586876;
 b=sv8tFhIoF99aTj7OsSpJQ32K7fySd9xUTRO+gZl0hADlRK1OBK+VtG3QHG/mASaExuXS
 PKcRFIau6NHglKuLUBca6oeZF/cubEsoAt5mYpX9wvm7LEQMqQPDiDCUgjQ20kI4RjyZC
 zHMm7Ov4l6dTmH6U52fAhzJQoyVuAfsuBXCVA+xKrVsp6ESxEB87cbgswBwamPAQzm0sh
 7xnw9T/p29ozQVVCN+s79AWrNMOsM9eeHUKYq6gCr98sUo1jaWxxCCDXO+bvsdwA9916+
 Lbywg2BcjW5lGvGI5RQW8/AP8/y6ck0xOYf1VpaGls0QXeJ3s6qg6T/j2hggMVdIVwg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792586876;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=bJ3lshCLB2k1NM/Xh6MsPZi+yJV3EGeyGCcrkx/Ht2g=;
 b=ff6/yUJf+3Xr9Xao3pDzDnqZN7H8EpJrUrbgd/UfyfRVGFJv/vQE7bq8anaZqK+liWEF
 Iv0+NZEawnhCFUMl7TdZiBUz2+Nx2vZ7dyXBtwqN/Y0/XETMSCyTPWTh2ankrRPvgDt1z
 r7CXSeeX8LdUdAzZopUtZ/BwzCK0Jp0iJViKx2h8z7Xjp0zXEK5h2lW2jBPrelR9ir4Fu
 kCSAAc7mMWAB27h2/ojER+kvN8a2DyK0Z2dPNYPLqdtNXqRp0iZiDuPrKh7+41cy9r3ik
 nvnsxE0KM8l/kBZZtZsoa+AbrKhv/oqX1B7zVoO3YzsVg/A8PIUktqA36BatHJYGcWw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=lL2aM3Dc; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::530"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::530; helo=mail-ed1-x530.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=lL2aM3Dc
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0925840820
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 12:47:55 +0000 (UTC)
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-6b1aa4d71e7so737154a12.0
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 05:47:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792586873; cv=none;
 d=google.com; s=arc-20260327;
 b=GBVFoJCWMgOx/ADlJz6EqlM1LJ4GguvAa23yYO4giFvd3EIhKhhYo6Ngy95IowlK0w
 Vi4ptL62mJxMOA+tnIEc300b9j/fTVyAWn4dvRbRbWR30cWrJV9dgfniHIgW3Zl1sNnL
 gTatqsDLnBaItbzqBmskqDqTLtdl923isaD5DZY40+X23RVp3vlS/6iAPYGP2DjCNXns
 EKkKunoEQ83Ea6AkmbaTXn1AVawLsXLIBGraNqTpTyc0tRtWXDAlER3esOd/XIWwkk89
 2gWZQ7B85NgO6oesv0783WHuohLL3fFd60JCbeG9/04fbIdp4aq3VLLUbRT/YBmHBKf0
 Ys9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=bJ3lshCLB2k1NM/Xh6MsPZi+yJV3EGeyGCcrkx/Ht2g=;
 fh=FntgapuohRHhKtts1VO7sadC0xcbo+inN3tDmGxu7Vc=;
 b=jAGVI0z5hbZFCNLDPw7pseeZuqbf271foLu/9+sk1EI+kSoNi7D9VlfvI2Bn9OqGLS
 F6M+xydz0/6UQE3VIg7P6zRe/KypLvGzjCXb+n8u2bLSbVRhucq7QPEwqFIt0vYqxK93
 5ZaSJymX1T1Tu330bmusvFLU3YShmhhILhfj0iJaSrdM+Voja7dSHwHYqvzkPNq1m3p2
 dFJ3W7VXr1bXgvF5oJuig1ewhF4ri5etbST/Jjzyp955Q7ZhmPJvPTK6/8Mu7gqeYSha
 HrEhXu4F7GQfvVYLqkSZglnh5LZHP14nYpy+tlj5QXyywiPsjS1fQKQBavMoVZryajkc
 EgpQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792586873; x=1793191673;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=bJ3lshCLB2k1NM/Xh6MsPZi+yJV3EGeyGCcrkx/Ht2g=;
 b=lL2aM3DcklUq84deXOajFU6xEoNfYVaaiXsXDX4Rco/T4vpeU6SKmh0lWailNFJdbz
 +UWhaUfcEE3Qb9/3mNHBWaBsEmVmlEwKS6G9Rz7lli5teabvlQ0qfnNBPT02goFmc+Fe
 HIKHL8A+no4dFdAKYYu4DQcvbJr8hnz/UizVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792586873; x=1793191673;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=bJ3lshCLB2k1NM/Xh6MsPZi+yJV3EGeyGCcrkx/Ht2g=;
 b=XT3xwdTQIHn9s3iSVTJFLolVyT2+qSdYeHZdxJybItetXBBJGJo13yRul6NuegT9eJ
 bks1GIvvhYFbQFopFY6DecJFgKzg/5AXUHpFPlPaW6w805BCRUWH6mkLUDITRjWxrcDZ
 kklPWyc25Q6njgyb5dRJDqsUeDb60qF+Q3Yw8JpzKpI3P508exJXLeaSv7q+IuMIEOcT
 xOaECvKCNdpd6uITKaxVwZPm0w2E9gGesFy4Quyvx7llSofNRZayiLFq5012NU5JcP+t
 QNU26KJ9cEf3M8dcv96v8QbMR/5Mzht4SXP++rOq9WbNLOKGJhGgmY5O1GQvkeCe/1Nf
 358A==
X-Forwarded-Encrypted: i=1;
 AKwUvByYYMV4BLozZxI8MMY54w/6fa7Ulyi/hK9A+6vV6JGhNalimVUFV8bwdJ60RXZwupQgR5v6Z8U=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJw+5JeDxceGsbqi3kXuEIPyXjCD4bB+NlmUQRBFvB97Rv1nTD7
 YeBEpZXUNgnt3z1if1h7IVHda0D8Cjw8h2YifHXbSZKCsUFJSu5JnD33YrlRcUDsgmUWhRNuc7i
 w8nrbSqalx20W5tyiviP/ELxnzBeBX9kG8A+E7gBT
X-Gm-Gg: AYBFou1vh+hWF8z7K3ENrleZ3ECTUH97N5x0RfZaIo/+ZDPeQmzA6JN5rB3xzrqswBi
 z1oH97isd+bM7kONC8lYO4FKBuP6/vFCAYESinqbwcqcrFD3ytlDT5TPiG69Yi0gH4lkpdpNr91
 RrGWR5Q6j0jcVbQOoDbsw/TacYx7aa9FLF5CI+SVyZsIfZeb8qdfM/UPRqXiEhl02giJw0Kau6m
 olwp4wxdINJ5LcY2Iccgf1wyxekjdHYqY+otP9lVgZFYihZmzJXn/alswrkhSNeF/SpJe5/+mKl
 9sn5zEPV+t1A2uT53FFA1Mt8qUGmJWgI9DCLNEI4qxJOMuHTDzzaGG5iV+Gvb8nmwJvc3AOphS5
 SFrJCp3GAgKf03HqZ1zfRTYuEh/0RxKldsOLv/xnDx7QTqVpqc1IxPPw+
X-Received: by 2002:a05:6402:1ed0:b0:6b1:dd07:8e64 with SMTP id
 4fb4d7f45d1cf-6b408db0f95mr1379918a12.5.1792586872570; Wed, 21 Oct 2026
 05:47:52 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 21 Oct 2026 12:47:50 +0000
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 21 Oct 2026 11:40:31 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260902211501.127915-1-bhargavdas100@gmail.com>
References: <20260902211501.127915-1-bhargavdas100@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 21 Oct 2026 12:47:50 +0000
X-Gm-Features: AclHuK9tgJW8TrjWYurCu4ZUKg-EOhS8ckw8JeIvRpBmFVbvvh-NZKSwIglx6hM
Message-ID: <CAFLszTjqZBSfiyqAepgedG6U4oce_xM2zjFr-XUFD6c_MxDjOw@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Add initial support for Raspberry Pi Pico 2
 (RP2350)
To: bhargavdas100@gmail.com
Cc: u-boot@lists.denx.de, u-boot@lists.u-boot-project.org
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

Hi Bhargav,

On 2026-09-02T21:14:48, Bhargav Das <bhargavdas100@gmail.com> wrote:
> Bhargav Das (4):
>   arm: Add RP2350 architecture support
>   arm: dts: Add RP2350 device tree
>   board: raspberrypi: Add Pico 2 support
>   arm: rp2350: Add driver for RP2350 hardware timers

The series isn't bisectable as ordered (see my comments on patches 1
and 3). I suggest this order: the SoC code and the timer driver first,
then the devicetree, then a board patch that adds the target, its
Kconfig and the defconfig together. That way each step builds and
runs.

> Flashing Procedure:
> -------------------

Please can you add a doc/board/raspberrypi/ page, with an index entry,
covering the picotool conversion and flashing steps, the UART1 pins
and the current limitations? The Zephyr example could go there too.
Otherwise this information only exists in a cover letter, which won't
be in the tree.

The MAINTAINERS entry should also cover the new timer driver in
drivers/timer, which patch 4 doesn't add.

> Changes v1 -> v2:
>   - Addressed various community review comments regarding code architecture.

Please put the change log in each patch, so reviewers can see what
changed where. Patman's Series-changes tags do this for you. Also,
'various community review comments' doesn't tell anyone what was done.

Regards,
Simon
