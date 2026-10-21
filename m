Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E803C606A31A
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 16:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=RlT/2Yv5;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=At1lWtQG
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C0E2560856;
	Wed, 21 Oct 2026 16:08:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TCsZsufhIag7; Wed, 21 Oct 2026 16:08:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B7A9560844
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792598899;
	b=ndygXNe997DSZI+NGmMgtwwsnRKTVwvpYFB+qJ+KMUn19imujjBBPvbtqtAiFG4O6vtw
	 JxneHb/1J/3qFFcy8S3Ilf8HQU0oQM99+5vBBOtN+RuYr2Qhm+WXtiuvVikQVo5VNhqqD
	 Q+f3lENzIUeP8AMaPFiu5LCEsnwhzAKE3WX5a6nW8psdObJnISs5TBqqmKA5XQpcLIUFB
	 S72s5KQzZlzfz7CXAzFFTOYTQwRVLKCVfxCZf8CzuLZYzeFy0FxBcRYVlaoD8Qdv/LTmh
	 a5BV3AzWLyMWGcZpWN8oTh4Z9BArxzL84uVD+mDDAcjgwNMCoG/Ak202heVrg3ttmwg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792598899;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Filter:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=LfZzLSPZ0VANr57id5Rgwqs/LdospUGPlderyNg8mkQ=;
	b=oNN/CRR5GGcBi2KQGjGvCS6jax1D8AWu3nrlckL64gEmq4fGGlNp16mioO7bHEgKFh6f
	 Go8O2Dl3azUWFLnFXHXaBw/fO7EpV4kcWl+7GP7r4ZEbQ0nQkRTbqP31pc9c8Onw8Tace
	 SqqyyNi5ZzHf54oe1/pXkCCwiSgaKQ9JWlDkfqT61CGpjFRizjibTtMx71B4V7+hK4Qbb
	 vc0znA3YAfm3WDSjeEmGUFku6pM4z75nWar4vk2kVNUMQ2yNM3b/FbR+p6wu3XmswkDeo
	 D3Scqudq82nrXFZIXvKeYxwyWPtZaHPwf39V2EsPfWTaEQRQnJzZnmlxz0WzA8WuICA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792598899;
	bh=LfZzLSPZ0VANr57id5Rgwqs/LdospUGPlderyNg8mkQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RlT/2Yv5RpIam6FYhX/zv+tOOmCS4yjA9fqhr1bnyTjYqVMRQuGJ2wKkxUZxP0KeY
	 tW4WqK4Tm0Rk4Y/opt5rvF8IBx/lHjunO/YmVVs2IqEUGzCIHajWtz6zBzcZLjP4Wi
	 xnb8t2i+mYhja4wMTunGsEL+nnvRXWQ+fFv0sE3UuOhAkMKrIayQ/v4IFk3+u5eY4y
	 C1W6e2QqkcjOTj593MC3wwSriYPLsj5shAJYGAa8Fp9di7FQ4P04ewKoh7NPSTV2lu
	 ATjrPI9Ge+PI3JgukpN8zoW/mPp0IcZIzL1MqVb179ZHVPpYtemP54YBya0nASKBxn
	 3DbqjWA2gyb5w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B7A9560844;
	Wed, 21 Oct 2026 16:08:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id CCEE795C
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:08:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BEB824039F
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:08:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LuE1mnACeEPY for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 16:08:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org B536540077
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792598897;
 b=B2i6VufTSgog1LrroIRVfY+PDDQuTA+ULtATF621lq8wmo5kPtQMZnc//eHF5S1LEm9i
 O+a8tFoaQTt0hCgnhis+on0My1v8ySFo70msqydzLQ7oYWb1EEQ9auT1wOUqmGHylC04J
 fwd4OZC8Gvei2vJcZ9hapfiKm5asD68jHy66NclnWFyEoitPDp9ronrqhJtUHipnx4HiB
 YPpFnsq0gbwIdgRG8c8G+HCKaP/3eBIeWB0Z7Ilk5Jw00A9NBBQRaAwgNHE49GZ85aTp4
 N6nZfLzRgN4CFveSxb782RITvC0D7VrMQVp7clFDO/GbSEOjTc4sI7MsR4EVgTgWPog==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792598897;
 h=Received-SPF:Received:DKIM-Filter:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=LfZzLSPZ0VANr57id5Rgwqs/LdospUGPlderyNg8mkQ=;
 b=r4TE8rU3jKnlvRmul9UGFK3KqqGv0IdDsn82DfujGi1E4NbTlCeUf9nhfIKRMjlQcdWd
 JqHc8Plbqduz29LRm1StrURWjKYjYM8doAmCLkbDkTTt0Ka52cxc6RptnHDTZvvplRKqQ
 CkgBnrFKMHwftAFzS0CyDLZqZhzgmTNKuOhGOQ0YLU0j4U+C1MtZGtb8MV9nyx41LGHrO
 NKmkUEIHjSE/nTniWhKPz/qbVSHIr7czOmGJRmTwdPfhOxK0nrG/bR3bBQo3P6pYH7Qgn
 U7xeAT1XrQ8pABwNOJt6USaQ4v59B9Usn5tdPmDExq/fRu1nn9G6MsVSWLMQa1iGmvQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=linux.microsoft.com;
 dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com
 header.a=rsa-sha256 header.s=default header.b=At1lWtQG; 
 arc=none smtp.remote-ip=13.77.154.182
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=13.77.154.182;
 helo=linux.microsoft.com; envelope-from=sriramsriram@linux.microsoft.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=linux.microsoft.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com
 header.a=rsa-sha256 header.s=default header.b=At1lWtQG
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by smtp2.osuosl.org (Postfix) with ESMTP id B536540077
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:08:17 +0000 (UTC)
Received: by linux.microsoft.com (Postfix, from userid 1251)
 id A888120B7166; Wed, 21 Oct 2026 09:08:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A888120B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1792598889;
 bh=LfZzLSPZ0VANr57id5Rgwqs/LdospUGPlderyNg8mkQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=At1lWtQG3Xd3IyvYVFCaPKmbpySeey22sUuG07UYdzkHbPW4uT9Z23VLn4lRPx6uW
 nqfOmkA293zO1bUwDUC0TsZxoGJklMFzEgrm7icscj8XSNHV81Q3b4gywGZ9ybXZjS
 onMfBVXqUjzVp5xCmS6H41/SzVxvLhjFMFWGK5iQ=
Date: Wed, 21 Oct 2026 09:08:09 -0700
From: Sriram Sriram <sriramsriram@linux.microsoft.com>
To: Jerome Forissier <jerome.forissier@arm.com>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Drew Kluemke <ankluemk@microsoft.com>,
 Daniel Munic <v-dmunic@microsoft.com>, nd@arm.com
Subject: Re: [PATCH v2 0/3] Bounds hardening in NFS, TFTP and ext4
Message-ID: <atjjabSILKYStdbD@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260909192016.217183-1-sriramsriram@linux.microsoft.com>
 <20260915205210.260404-1-sriramsriram@linux.microsoft.com>
 <cde13a24-7ee8-42a3-9f7e-46b08ae3fab0@arm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cde13a24-7ee8-42a3-9f7e-46b08ae3fab0@arm.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 21, 2026 at 11:50:51AM +0200, Jerome Forissier wrote:
> > Three independent hardening fixes found by internal static analysis and
> > code review. They do not depend on each other.
> >
> > Changes in v2:
> >  - Dropped "boot: image-fit: add overflow guard for FIT decompression
> >    buffer" (2/4 in v1). As Tom pointed out, max_decomp_len is used both
> >    as the allocation size and as the unc_len bound handed to
> >    image_decomp(), so a wrapped multiply cannot leave the bound larger
> >    than the buffer, and image_decomp() already fails cleanly on a bound
> >    that is too small. The claim in that commit message was wrong, so the
> >    patch is withdrawn rather than reworded.
> >  - net: tftp: replaced the four bounded strncasecmp() comparisons with a
> >    single check that the packet ends in a NUL, per Tom's review. It is
> >    smaller (+16 bytes of .text on am335x_evm_defconfig instead of +24)
> >    and it also covers the dectoul() calls, which v1 left unbounded.
> >    Retitled to match.
> >  - Rebased onto current master (a44f46af0aa).
> >  - No change to the NFS and ext4 patches.
> >
> > Daniel Munic (1):
> >   fs: ext4: widen ext4fs_update() block-group loop counter
> >
> > Drew Kluemke (2):
> >   net: nfs: add bounds checks on memcpy into stack-allocated rpc_pkt
> >   net: tftp: verify the OACK packet is NUL terminated
> >
> >  fs/ext4/ext4_write.c |  2 +-
> >  net/nfs-common.c     | 10 ++++++++++
> >  net/tftp.c           |  7 +++++++
> >  3 files changed, 18 insertions(+), 1 deletion(-)
> 
> Applied to u-boot-net branch for-main [1], thanks!
> 
> [1] https://git.u-boot-project.org/u-boot/custodians/u-boot-net/-/commits/for-main
> 
> [1/3] net: nfs: add bounds checks on memcpy into stack-allocated rpc_pkt
>       commit: a9631ec898a6f71334c88d29c8e6c9cdb1334a41
> 
> [2/3] net: tftp: verify the OACK packet is NUL terminated
>       commit: 2044f0c8ac168e3a2d23a47e21c61f248f93f285
> 
> Best regards,
> -- 
> Jerome Forissier <jerome.forissier@arm.com>
Great! Thank you.

Regards,
Sriram
