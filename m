Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3D7606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 14:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=I1dKvz1h;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=i+tEGBQO
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BC32140B56;
	Sat, 31 Oct 2026 14:06:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SCnbV-OrUqfb; Sat, 31 Oct 2026 14:06:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E0C6540B34
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793455578;
	b=gOEerN+jRqZfGWXeYcRBjJ9iPiicycTyFeZDA8Ps/1ab3+asZYkBf9aB+TjK6fCIJbM6
	 0wFBBoY8Qf8/OsLSegm2h10Yo89Ow7Ou7ZhaIB4p6dSJ2C29HA1M8mU3O8mKu9KngD9fV
	 5vGm0r8b0xhP7dWysmHJbp0aO/48A9hs+ERrP0gy3rlh5rtHXs3BMxmQjO9GxptHeOQaH
	 JUF9+IVhffQdRJNUmmdQRnN/sAGKJW9cHbKX3GP+BwX0n8JwYHMovLR2i0eXxg00ggdUl
	 B8WcNrEV0VLfzbIEzg9y7f4G4FFivbRTBFk4deRSqEGb5ae0l6kiHOklKGAWZ4aB29g==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793455578;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=7X55TcR1xnAjPaT2Mt2ed8a45+f6Aa6RWFk0o3+CJK4=;
	b=omGBrodDYz45Y80S7PJ6GJmK25Bp3g1D7r1B/Yswlra3Kljzh71PNSww4XTbGYEGetIm
	 vnESb5Uvn5DgTIxQqc2pXgxZYvyzEtKwOrWLzpzAhPWKkYD3gSIVkGSicuVd1PHYmmgwf
	 RTt/mpq0nwjvPegu9yS1rA7WyPKnz1idk+Txi4cyX7xWcw5bVfMob2gxKkbKaZwjHql78
	 1uIvJcnmf0fPxgubqaEZxp7Z50//fFO4msN1v4x3VipHLOiGSnidJta454PpLTsajmC26
	 uzUDKO/zdEmg/y31q4MF+Rx7AoPjz9vxXE3TyojylkQx7b8dAEnggrIZOSwI6edUmxw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=i+tEGBQO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793455578;
	bh=7X55TcR1xnAjPaT2Mt2ed8a45+f6Aa6RWFk0o3+CJK4=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=I1dKvz1h4YXMlZoxHxG3UvuxPuOK6vWoZTUiR26ZfS47YN7qzzDHRJ10g5CQWXzig
	 /EPCNx0OgCdHz7VO9AsNtjNB/lhXlHibSFMwikC+hyKbwzWwVzpVmkYR2iLZh4bAq/
	 YUkVsM2zVEjlAdmDGYNnbzPi3aii/wgawHeN58zngry+eXZWn1bOUmvltSL2996dXl
	 QZrKKm3xsKTWWXjFuvlTrjnemjqxpC/WtCg9JP213T999U1ovvZXq8iD8aIPMVJMqc
	 o+MypSEZJnnBHknSPf/6WeeUXKGoHF2v0xmjIKUH5UtaDx/KLrmnY1J7/wioNdUdv6
	 6iUS6tEDHLV6g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E0C6540B34;
	Sat, 31 Oct 2026 14:06:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1BAEA1DE
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 14:06:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F0D4740B69
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 14:06:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PjXa3olx-jaT for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 14:06:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 43A6C40B56
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::535"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793455573;
 b=ML4S/Y8q6Fjj1Ez3+TYfB85tQT6ldUqfSFV+AEXbWqyftajg4udYWg3nnUJ2cuEBkdwu
 2UIOeHL7X/j6sIXhDDZEp9I2RPOcoLzTLbwJ3GSoV0eBIyeetOG38Vva65EtB7VwnCCeI
 5qYsrxFzw3LNSd86x3YIwg7DZFmxzjUG56Kj7vcPtoo5Ph0n0bo4gvv80aRbNNdM5d1By
 Y0lkDIsC++bnl3iV0hWA8dxvK3W9Rben8vZybwNy6y53aZOV12DX5VAKSVZmVM6vWjJ+k
 SIU6A9c7dXDdE+I1c1kf8pVNys7sQCtOvU/2IeZQmqT2J0vtUDRPM69pg/z5ZnDNZVA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793455573;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=7X55TcR1xnAjPaT2Mt2ed8a45+f6Aa6RWFk0o3+CJK4=;
 b=fY8EeykRCwWwJCZVyGaSnjx/wrMASPqAshPKz80lAp3rBeQkK6toj/tT1FQEGlVEMxsL
 PU0jryyy5li7NFqh8gAzqUTVYA8RXvOPaHLF+WSU7/Fz+RQwXhoI1/gqiH/Nw2ZV0sgLt
 gAI2g5YWXkNrROHGXxuY9+2WkmdETuLTJgDc7+aGn9EFFcqTP7KKRMwWq+SsEAg9gOOAa
 b1j3tJ6zcN0bGox8/hHdP9PhRxU7hMxAy5TuETuYXWl8aUmgC9k1uhYPlUSm5GnP08a/Y
 ixJ0bb34d35AF2NZnDIyUnC2CmWdFYxDhDXoicR8jbhSZEQWmy6q48q1SEyFXeDJTmg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=i+tEGBQO; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::535"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::535; helo=mail-ed1-x535.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=i+tEGBQO
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 43A6C40B56
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 14:06:11 +0000 (UTC)
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-6afa651700eso2322266a12.2
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 07:06:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793455570; cv=none;
 d=google.com; s=arc-20260327;
 b=FBd1ZK3tE2ktKbUnFf20IcAP9BSO1mVzdIgyfTT8V2wPbyHAgZtX/30B2XseiKoKxZ
 TgkAjqjN68BCeFevTlhu7dxwIok2ytvRDwgMmlorlc/qrIIu+Vk6W+QrMwtOzkyswvBX
 UzwnTqw7VDETU+jzeRCWzkL07TZdcZImV13Pk6XYf94l7CfxfKiqaMDd7bgFceET6pil
 84vIqYmPWk2Ac6ypb2sWq2oYDiVIZTJzcnkCntg1S1Cf9Vn483NeeLMMzfkOHdkLNj0O
 8ItpTcLs9faZJwelCf1fd5kl4TaGjMAGr6W0SJS6G+YzdhvA3jTH652kq02YKu5pIZNc
 0eWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=7X55TcR1xnAjPaT2Mt2ed8a45+f6Aa6RWFk0o3+CJK4=;
 fh=ipqPYUDubS5RAIwRM7MUkwQXMyRNRHWTPro4J8KQldM=;
 b=LqN5cxlsiRKXoGopOmQZ4p8Xn45Aep9RbaG3jkKk8F/W79JxjxLJm8YXOjKUFuiyLt
 X1w8MsBSbunWTA4vLSk0sjRSX7cSXDsdQ9gM+mg8kX2lITR6PP2B5VkUKcEqgBOpfm8i
 NqB8Dy4ekXLbNEuNtjnbvCAomZbFe2EofVUqJrU3gyQFxWUyuaCx5MGE+765OjxwZLzY
 pZKYPjlpsbUD8Sz3XpWulDDG9zhj7hmlaXTU6xSgWh7vFvHYI4gkfgqXu75/nCvJl93C
 U88iHYQVDsmnuuy1eyQEp4ae+xTWZCauMCer5Neh2Vqk/B5km18DE1eGXoIrxjSk83eC
 FdBw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793455570; x=1794060370;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=7X55TcR1xnAjPaT2Mt2ed8a45+f6Aa6RWFk0o3+CJK4=;
 b=i+tEGBQOQ/o599qHyqizxbANDlbDZ0zqlaJVGlAgXY8a9gCwRlxXLD7FQIx5rbxx8+
 dgM0H+KIuZJ7ZkcIWC80GhyeytJQ8OyZudS2ILlUzPyKanZSd9BaMPZUEOzjjNIPVLku
 9j586S6XQzG5WL1cDgdt1+npEyaXvsxgkr1M0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793455570; x=1794060370;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=7X55TcR1xnAjPaT2Mt2ed8a45+f6Aa6RWFk0o3+CJK4=;
 b=JscQAIlivc4GE+Rd1yJix/bjUZ2s21ZDCpaCuWB0TyInFfRYkPfNpCM51Q8wmI/n1m
 gJ0IhJ7jzxA7Yg15mftTkZWRIFiikVG0jS6BoLUUVszUDzLlWKAS8bfudM+7JTMMRqFj
 10dKnXqWxPrsMV9HiC2W2Zvpibp+R1abBgTf8LCH3SKs8tjo+IVzemcXgoIN5yNtDRwA
 ZaMeTPc/9GBJ2Kk+k8Y7ztchwZv+fb+XSud/axCLxTS46rb1H4qS1qS/81I1PO89Q0rh
 8PbEfQRF7ZVLJotSm9jDVvEgVIytBvNSJvKt1IQy0B1gBe5ezzuPqXZmL+9Qgld5Q8sT
 GKWw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzOXqeCz746nu19EQ3+b0/J1N7Ddb5qFeOzMT+rGT3mwEOvAylhdR2nAyMUJWv2CR6ELnUOb7c=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKXJ8jaFwIVXM3qXKkDAiz9z+FetKl57DA1EdIpOKDYrx+eiJj5
 Oa1VLl9fnnRHiP262Iu2wn+hN7So/CuhPyWXW3NufreHsId7gwWGyYRcmaBolV3AYpa/ktwe1xF
 fNt3550DUE9jvMFsz0n0/pFEvBQOCUDCL7IFlQc4P
X-Gm-Gg: AYBFou0RnlaUffc1IZik/3+HS0d3ENTus3LNkQaGB1gUPao416BtTcC8Ykiy/+RLpZP
 mCHTXlijjd+95+Msfgx8p2Rv7L/oredYYjYeZOtlhk9Bto1FZ8eMeFDWk16HTASR/DEKrYjSBHD
 98onUpNzCGGBL5IIDXOk3vCtTC/pmH5wUMQJiavsVzx5W+ZttQYNEmpcYnc+YEVujQNc46tkDa7
 cq0T6G/JChWvdf104tVljboj1XVvYFDhTmNASgOXUuvNVJ7sIu0ZDdUQd4EIEIg0bGjBivX4Xg+
 fya9oL7JM84J7k6kv2w7UkUHfTRCwtbC9yzKaTP8Ab7TCTFB63YLQCC3uTddAvMBH0Tf4gvfE1z
 EOPB8e5qlpaA+0zzDtaGo8SRn9Ip7eQhqa1HxiId0Hx+0AfyhbAv1z+tao0m4JWWVJOj/lN3LcI
 be/dKRT/8K0yPdwluQ
X-Received: by 2002:a05:6402:428f:b0:6b3:e89b:126a with SMTP id
 4fb4d7f45d1cf-6b4d428fa3fmr3757670a12.12.1793455569946; Sat, 31 Oct 2026
 07:06:09 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 07:06:07 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 07:04:52 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261029-main-v1-6-b5a878627107@kontron.de>
References: <20261029-main-v1-0-b5a878627107@kontron.de>
 <20261029-main-v1-6-b5a878627107@kontron.de>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 31 Oct 2026 07:06:07 -0700
X-Gm-Features: AclHuK_aKtQxPoCfTW_NxGULtyyLY_pPt0-e80gysML_aFSJ4GTT_7ux8-Vu2-o
Message-ID: <CAFLszThRj-uY=BVBgoVfceRTHw51FW_VS58cmR1SimMS78jKHQ@mail.gmail.com>
Subject: Re: [PATCH 06/10] bootstd: rauc: Optionally check the partition names
To: frieder@fris.de
Cc: Martin Schwan <m.schwan@phytec.de>, u-boot@lists.u-boot-project.org, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Aristo Chen <aristo.chen@canonical.com>, Alexey Charkov <alchark@flipper.net>, 
 Daniel Golle <daniel@makrotopia.org>, Johan Jonker <jbx6244@gmail.com>, 
 Francesco Valla <francesco@valla.it>, "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, Michal Simek <michal.simek@amd.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Frieder Schrempf <frieder.schrempf@kontron.de>
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Frieder,

On 2026-10-29T16:23:07+11:00, Frieder Schrempf <frieder@fris.de> wrote:
> bootstd: rauc: Optionally check the partition names
>
> The RAUC bootmeth uses any MMC device on which the boot partition of a
> slot holds a filesystem and the root partition exists. This also matches
> devices with a different layout, for example a single-system image or a
> standard distro installed to eMMC. The bootmeth then claims such a
> device and creates and saves its BOOT_ORDER and BOOT_x_LEFT variables in
> the environment, which makes it difficult to run BOOTMETH_RAUC alongside
> other bootmeths.

One thing I'd like to check here. distro_rauc_read_bootflow() still
calls env_set() for BOOT_ORDER and each BOOT_x_LEFT before any
partition is looked at, so these variables still appear in the
environment for every MMC device scanned, including those that fail
the name check. This patch stops the RAUC bootmeth saving them, but if
another bootmeth (or something else) later runs saveenv, they end up
in the saved environment anyway. If the aim is to leave other devices
alone, please can you move the defaulting of these variables to after
the scan succeeds? scan_parts() would then need to use
CONFIG_BOOTMETH_RAUC_BOOT_ORDER when BOOT_ORDER is not set.

>
> Add CONFIG_BOOTMETH_RAUC_PART_NAMES to set the expected names of the
> boot and root partitions of each slot, in the same format as
> CONFIG_BOOTMETH_RAUC_PARTITIONS. If set, a slot only counts if its
> partitions carry these names. As only GPT provides partition names,
> this also rejects MBR devices. The option is empty by default, which
> keeps the current behaviour.
>
> Assisted-by: LLM
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
>
>  boot/Kconfig                 | 13 +++++++++
>  boot/bootmeth_rauc.c         | 68 ++++++++++++++++++++++++++++++++++++++++----
>  doc/develop/bootstd/rauc.rst |  7 +++++
>  3 files changed, 82 insertions(+), 6 deletions(-)

> diff --git a/boot/bootmeth_rauc.c b/boot/bootmeth_rauc.c
> @@ -138,6 +161,11 @@ static int distro_rauc_scan_parts(struct bootflow *bflow)
>  			ret = part_get_info(desc, slot->root_part, &fs_info);
>  			if (ret)
>  				continue;
> +			if (!distro_rauc_part_name_ok(desc, slot->boot_part,
> +						      slot->boot_part_name) ||
> +			    !distro_rauc_part_name_ok(desc, slot->root_part,
> +						      slot->root_part_name))
> +				continue;
>  			slot_found = true;

Only one slot has to match for the device to be claimed, and
distro_rauc_boot() then picks the active slot from BOOT_ORDER without
checking whether that slot passed. So if slot A matches and slot B's
partitions have other names, the bootmeth still boots slot B when it
is active. Since this option is meant to make the bootmeth safer, I
suspect it should either require every slot to match, or record which
slots passed and have find_active_slot() skip the others. What do you
think?

Also, part_get_info() has just filled 'fs_info' for the root
partition, so you can compare fs_info.name directly instead of reading
the partition a second time.

Regards,
Simon
