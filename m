Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC931606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 08:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=zuw2niyc;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=fgQgr0UZ
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BCD8480DF5;
	Wed, 28 Oct 2026 08:56:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iJHGQM7gsorE; Wed, 28 Oct 2026 08:56:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F396F80C88
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793177791;
	b=dLEl5w+PQox/niQV8cBQfye4Oh4G+bqwMTVCJHMvTCdl1Q9mMqayS/Q7zEkFwk72tumP
	 cG1rfSdpW1TMkyetN9x84I1NVRn+OlEa3XeK0iGUm9eGeZBqZoQcArcWLTNPLfgui6eaJ
	 9QSg54+msR0/p4djuo7KARuYqihWbKOFQztyR59kfhZl2F9QZFDtpNpa3Dyz1azGRv8lZ
	 9TRBZ0HUzbTY5RmdQ+7niTwl/TG3qY8aw19NmRVJBd7y/u9c32PGkOYgbWV2mR7lEn/FP
	 yJSqZ3IzzlsoDzse6EQz2JRDv8fOYL7x5E8pQWadpHk3SLJegXxXJUO3K8u9DM/Octg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793177791;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=eVFC2jevGZGVfGRVKKxsCgtyOZigiXfss5LySmkU3S8=;
	b=pMQgn3LLu7s/IuDHAKI6dKf7PgG8D5GXQJvhJ/VW5DNl3/WADIk8xxxn7BfXPNXs7oxv
	 yIEOs3SDSRVug7mR7/4E4PWAWQRi17/0Ypec0ysXAm8KvXljlhfiwescGoxKtZQOjRN8X
	 BtPHEUrt29+px1WyM4FOvsk565DlVPV9eYyDB/LEFJccl8lTY/J1swKtIgQT08aHG1sjm
	 05JpoRQsA4DShjnCBFzPWTxMYtCZ1EukE+7kh67WIegwN+Cx0zxYsA5mMgZvTpMhIKbuE
	 vjvWXcYTmKlS27ethrPn7laftMA5XQ9414NFkSM/4jlv/lhDttlo4TrGcq77Z6o7cuQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=fgQgr0UZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793177791;
	bh=eVFC2jevGZGVfGRVKKxsCgtyOZigiXfss5LySmkU3S8=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zuw2niyc4ApeLxL01h/3A9pI0Ms2TwzBhy910aH0hLjpNeacLGqEnox7EncI5S0Xu
	 rZcUlnT4fZ7TD9ro98ttisVKjTZpKw2BoO9eZ/PDnqgsMJWW9qLA0rqH3K/Qkpm7a3
	 TKQjXDl3u1cGC6d7A+wG0coU2+eU3HdIipG6K83M5wOoLM/0d2OgN6Kvmt92+sUrYd
	 B2TvI0rkKwMmD1+Co/JWsaPRpfRIwBYGRB/ZGHCrZDTTonIrvylSh+h6SZPRj4kDSb
	 mb0E0B/OzcBPuqLqS/45DB3sRe/iJaLjYD5ww3Xehq0zgh8Goi78rEaKqcYjvYpkYS
	 YJ5yKtXDNq55w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F396F80C88;
	Wed, 28 Oct 2026 08:56:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1FB124BC
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 08:56:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 05DD480C88
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 08:56:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VlhyWT3an3TK for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 08:56:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 09A8D80C1E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::535"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793177788;
 b=k7h3UbKasjfds3NyEJCd6hWIAPsAxsbjzrNp8Vx9uCLfGCQ7WCCSeAiNvhOUZX4HfI6x
 1ujzL6zoX54E+v89CPERy8a6wkCPR/jrwEF4PeKsv8MQ7A7/qwsI4cL5w6EZj6h5CJCW5
 4jQs0TNEWwJl2Uwgt0YLzS/4yruzB+eq7k2KdbEYxorRD+krnCKDk6+xLpe9m6gEMNm0+
 5OG/I9yAdWLMpz1V9ofJHhLb6rusj+REn3qXt4kv8dn5C6nrA02iLMBgXqN34cUkLPEn8
 TaX2Z3wvUA/CEnkkblIhI+Jfq1kH2C4LU+yXV94+GCI15DxUUGxBvsZXuBknPZv1Sjw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793177788;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=eVFC2jevGZGVfGRVKKxsCgtyOZigiXfss5LySmkU3S8=;
 b=r2XULKWgBNXDM1GC25ibZ33nbSrzD+TBWhtIZXzXkDbnweVVuk/SqsnqHKDLBlSUWvG0
 KRLRTJ/u3O5v0HMja5LIbRVOj0Ah1wMtbWr4xnprNr+mb/58ozHXRy8tXOj2D8vAzWNnf
 v+o4Td52GGIs6MJ4hE31h35ChrFhu+C35hVD68qBL9ll4s10U6RZY5qbC+/tJfc2ZKTaN
 GB7r6JN3kfCuFfokkEd/XkLD44sd/WiBVS2W85XhmYZnO0eUjMQOy5H5JuTvvUyN1QviM
 2f8GYOpXLUNUlq8WZwR0QmOj40PXrmgey+4Chu2b5Fpko8XYNvPQ3R660MVfg6XybMQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=fgQgr0UZ; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::535"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::535; helo=mail-ed1-x535.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=fgQgr0UZ
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 09A8D80C1E
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 08:56:27 +0000 (UTC)
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-6b1ab2ad719so733719a12.3
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 01:56:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793177785; cv=none;
 d=google.com; s=arc-20260327;
 b=nt7ONwNd0SOJXV5SeY6op9NUbhIrpZ01o/9guwj3ZnDQjUnIhuYjBFSfe14nUjYdft
 xmrdGAR0Ki0n7Dg62teKoSrZBq0KKw++WSSS91UEFEsyOUBfXB0efLc2I8RUF52PZYPW
 zUydd7NRM7oRY5QCkc0KrYGgF6F9yyriaG/+JP4Vcayw+qEVxe+aKKbzscgVcK82KhQ2
 CgOb9jIKvNA5+cefdRKq2iflJjTfj/S9PsiSrKClG85T0SM5gVpQIQ7spUNU3jaXeeGW
 vxkrY3kGWvZJGztpGqFki23X4IVAXwQpY/rvJIEtaVTpRPlOZDedojrKQnEfVZvGUyB+
 v9kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=eVFC2jevGZGVfGRVKKxsCgtyOZigiXfss5LySmkU3S8=;
 fh=5qTs2tb+e8bmB7pS4pybe3RzoCwfT2TEiQfI1pZDoLU=;
 b=FXK1hL75wHocFXgOrMtdo8BKjX7PWJx6rHx/ilxQk/Zf1NgQptklO5d5FrMo8wxK1L
 ytjyp9TuibBM9Q9taziH6issSII60ii9/33W4aZ0E3GoPE5A5+jQNmjEmtyj6QKuoknm
 wjQL/KPw17DgscAO9pPW02sKfZzYSSHiQb0j+BGiyxSHyJGtBokOuYqh5bXCkeFEwapK
 rkv7OaQSKJR9B2EfMG5NmL94THUFmJ1yGbNX7XA25gY6ED1SyTM/Z2zctCQaWTRSgvHG
 VV6a6DyXJwGSgUhbxwZsAr46Zh46K4KdU1wAuH+KvWzcI7K7C/9L28CtL97nh+RBx5ZP
 uwaA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793177785; x=1793782585;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=eVFC2jevGZGVfGRVKKxsCgtyOZigiXfss5LySmkU3S8=;
 b=fgQgr0UZdy7vC31/MYvuqNQU62GNqjVJdjvkhipE8hhRd6tDh7NMD5+mn27ECWN/CG
 3cSaLEOkFuwyDOYZCHqvO1KKJP/mC1GNw+zzMIRNIEzO/JbV40iB5NtwPOISOBGhm/FZ
 7AWvG03dO4f5A4saLUKLrBlYW520In44lyBkc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793177785; x=1793782585;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=eVFC2jevGZGVfGRVKKxsCgtyOZigiXfss5LySmkU3S8=;
 b=VrONcT2JS4XR4tiB12MUwbax75PaDUQVJGWVcRgQY13Ivuy65BPDh1VRXY7b2Hy0vK
 3sZRmDkQtHQ9rrAKXeTciwbH2OGqFyt+T9gruzpurAbtnmPmGk2piiOnDrUKVDLk+pwP
 JhtOE3JkzLOcKVfLCyjilx2t+bV3aweDLhBMpliiAmuHHnQezoxXKgVKC4UJRBPjAgl4
 94XbGFoSzodgwPX0ig2Ji+k952PJg7nmzQrd2O7te+MbqWuj3djJ5//HTeTAt9PSoobt
 OQijdvQWP/Ee+B5sNl/4IdzQPCdhdz48vz7OMWj6sAMpyMFbAF5bziYdXaFOhjrBg0VR
 G+eg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwkhinCms9XBOuLTsUe5b6dj6U/xdhR6KA9sGc1mJiCM4BARa7Nqf6//xQcptLLy/dNq+Wkbuk=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJC/Q80g9DEldjRklpxo8xChrtQU+hVOYjGV9NH4T+Yh3V7iKv9
 nLnUFgWRn5jvLJ0Di2UGCt8EDDlJyjPoCjXNugwfKhQf9w38oLizcp+shj61YeBV8nnb8M4B7YT
 2cjNnSjmZYuBHRF5UKiY9FaCtFIH2fR52MBjFic9ORdOAKowWg213FA==
X-Gm-Gg: AYBFou3NMAEVZeZlvRKMZnDIXznOnjcTVSc49fM+CvOcjPH/NegsngCGFAv3uNM2zrM
 G8hEQOdle40mxmy5tXu38Tu284z+Y+ZD9dIopKIkMQ/qkIC5JrWWfMsZI4twqJzNxPj0PDplV4f
 Syd1pGpbdP91naGKX5g1HPJYGmdO2svIkSpJeGEN/l4DShzkX0BjsFRZeuoJEa7NniujiaNtovy
 YpoCrk6JreKANgNoSvyI2fRhy/OM7OljQpDUq71rlRfeYYu5VXeUVIAhdL1yr3TbfcrP6AAvzDN
 e1pB2tyX/Yym1AsEUA6ADB7JJccMQb09juHy+dEohNny6UVHMbtCYVqUsp6iOpefMfF3MEiGWgH
 NxNAcgjOrhxqkX/bGjuIJEzA4EMS9WAeEelg=
X-Received: by 2002:a05:6402:434c:b0:6b3:f240:c0e7 with SMTP id
 4fb4d7f45d1cf-6b49cc0eecamr1016165a12.36.1793177785438; Wed, 28 Oct 2026
 01:56:25 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 28 Oct 2026 01:56:22 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 28 Oct 2026 00:29:38 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <6043b488-de34-4505-8951-74f58cadc062@gmail.com>
References: <01ba3f81-06b7-428b-9224-bd887c35e1c3@gmail.com>
 <6043b488-de34-4505-8951-74f58cadc062@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 28 Oct 2026 01:56:22 -0700
X-Gm-Features: AclHuK8Sf18dGGrx7oRX-J-gFhSTjYwU_rpuMrqwa3ShJ9TQQDgymuYgrr3ws08
Message-ID: <CAFLszTgCQJSFMsT+BckcBsbtEcktHUmjOOg-wUw5CTMZ4Yd6DQ@mail.gmail.com>
Subject: Re: [PATCH v2 02/12] block: Add blk_valid_blksz() to check a block
 size
To: anabobillo3@gmail.com
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org, 
 Simon Glass <sjg@chromium.org>, Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Bin Meng <bmeng.cn@gmail.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Alexey Charkov <alchark@flipper.net>,
 Javier Martinez Canillas <javierm@redhat.com>
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

On 2026-10-28T05:50:48, Ana Bobillo <anabobillo3@gmail.com> wrote:
> block: Add blk_valid_blksz() to check a block size
>
> A block driver sets blksz and log2blksz from what the device reports: the
> READ CAPACITY reply of a USB stick or a SCSI disk, the LBA format of an
> NVMe namespace, the sector size of a Xen backend. Apart from the virtio
> block driver and the host command, none of these drivers checks the
> value, yet the partition and filesystem code relies on it:
>
> - part_get_info_extended() and print_partition_extended() read one block
>   into a buffer of blksz bytes and parse the partition table at offset
>   0x1be, past the end of a block smaller than 512 bytes
> - fs_devread() converts bytes to blocks with shifts by log2blksz, masks
>   by blksz - 1 and divisions by blksz, which only agree when blksz is a
>   power of two; with any other value it reads more bytes into the
>   caller's buffer than the caller asked for
> - buffers of blksz bytes go on the stack, so a block size in the
>   gigabytes overruns it
>
> Add blk_valid_blksz(), which accepts a power of two from 512 bytes up to
> BLK_MAX_BLKSZ (64KiB, the largest logical block size Linux accepts), so
> that the block drivers can check what their devices report. Use it in
> the virtio block driver and the host command, which then also refuse a
> block size above 64KiB.
>
> The next patches check the block size in the USB storage, SCSI, IDE and
> NVMe drivers, and the last one in blk_post_probe() for every block
> device.
>
> Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
>
>  cmd/host.c                  |  5 +++--
>  drivers/virtio/virtio_blk.c |  2 +-
>  include/blk.h               | 21 +++++++++++++++++++++
>  3 files changed, 25 insertions(+), 3 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
