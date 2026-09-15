Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 049DFC88E77
	for <u-boot@archiver.kernel.org>; Tue, 15 Sep 2026 19:11:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9944A8084B;
	Tue, 15 Sep 2026 19:11:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P__irKaxTD7r; Tue, 15 Sep 2026 19:11:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org D49A38084D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789499468;
	b=LxNLK3Q4F/faiL4W51uVhNimDp3mAAFhE3yS791T7YX2HY9j9wSHqFpLRVrPcefObxve
	 m/EH482C3lfLH2T/QZBCgMo/v/cB3JRrZOo2acQuYiA8qKMnloK7FgBJ9YlnStd35Ei3q
	 Z9aMQfORgnhmEN6UKW2LVVZxCGPE9Lnk1D0XECjim3xg3DrD5SlMjN4dxr7vcAdDr4xx9
	 +DvtrKMQu7dVWyIdaB00/LQstuxaPLLx2c6N73VA11yrvKTpSfXqzwDZU5WiHa03zsr4x
	 i5R0rb3lWHS2BTsFs1+Pg2ycIZJ3OaaWZXQteGCUs88yCXsaJH/kkYFKYkwQhEU6cLg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789499468;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Filter:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=m+iaBvCyZDT4yY7gif4zlTFK4Py9FYY7AOa0QMuoyEE=;
	b=BDm/AWMEaMZrFtHQscFtNIViEibEMI3wMqZA+8Vv2V9CCuRpTHyAQz4SqbF+2Em4x5Qd
	 avS3pEjy1kOvy2av8yjDaoZhUYWGARvd4kijq5WuXhQ+FlQlVvq+R0VaJNxNMFLFW3AVW
	 b/hgHAonrDXJVp+xJTva9+d47CVtd3lwHaue3uCmgKqbQTtO8nJbv+c1weTX1sZWEqvTx
	 hmp9QEqeWYIoO6Afi0TGGRApQPGHfvPbVI/pLjixLy5twA2t6K5QrLHHefCS7E6ScqjAh
	 HDSjaSODWmZ2hboupvaIM9VFE/D6ONbYZUFugU0OzO8BD/a7jQeUpKRsk9oO7kLagdA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789499468;
	bh=m+iaBvCyZDT4yY7gif4zlTFK4Py9FYY7AOa0QMuoyEE=;
	h=Date:From:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=xoJDMnKEb+ieKH/84Jlb4ZR9jm9pyr42UqSToMbmFhbUWRRmTGIcmRj3VR9imjko8
	 RbcFSbtLp7OrpUko7m0GJR3ZyRAQ3Mg1Ee9Z72nS42dMFFHR5MxghWaMFmio8YLwRZ
	 Tu/ihrwjgoNzHnKnjLoea8nUwIsfThtcZ8NTX90a5+2z+JJSNVyyO8wM7np2OVa8NI
	 Lm7W1cUwK7ve2zVK/X0C4EftcMFa3jj3sgPuQqID6ey99u+otyXJZYROetK3s1RYXP
	 X4xzcEMqfgJysJG3OmVeovH9tdrBTPm0/EpzeiT261sI23LKpxJQB/zgdIQgwrztcg
	 wL0AMDdPX5V7g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D49A38084D;
	Tue, 15 Sep 2026 19:11:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id EA9D82D0
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 19:11:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D0976606E6
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 19:11:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PlTVvqbgd8yU for <u-boot@lists.u-boot-project.org>;
 Tue, 15 Sep 2026 19:11:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 1343D60681
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789499466;
 b=FMgxfHL0O5FVmG9DdE3l/PRPeYMJjPCHhSlYECyqbUbBtTQxzTJE083lu1SlfOo2AXm6
 OaTYQoVhAd1pMVbf3xcFQgQZ9XG9u0LwXtdkO9RdM/zo21SovuERw7HKLteA5UA6Kt1j1
 vFpYOQ5pfZhsTJw7L9VDeZ4s975ql7w9zdG9LXSsACm9SfrdS+plOPIakjTq0qLYP6Tat
 voY6RdObrIXvKnqOdGG+DzrWCThLs7M9LrE/Yo8KLOnrjQ8KMq81SHTWpzKHeTwbQr2Q8
 6raunkaouWGq+LhgGESXKAN0c5LokcH+t5/x7Rq7igw931CjqoQmSxxZwlNUsEeT4Kg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789499466;
 h=Received-SPF:Received:DKIM-Filter:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:MIME-Version:Content-Type:Content-Disposition;
 bh=m+iaBvCyZDT4yY7gif4zlTFK4Py9FYY7AOa0QMuoyEE=;
 b=OZ+rfisifBnAmaQY7oh3AgfKoQVG+ibVx6hrNEAyCVTpgplh2ypVuKeDkjziKxDH8MvN
 jzqD7YsKrm7ACN2mPw+Bdf7TK336+uRL/5G2/Ui8JR4sTwcP5IHxpfwqpf8Mwseuh0V71
 tYUdkmn8m209Fbv8u/nKIZ41gRnZxMuJMgQ0xaaI43QIZnG2sau9K4pT1vxTLjtCNGK/e
 TRok9gS6R/OG2l0MScuT/b2JCYVpBoUZDQFGRjerayL9NfRsAY3z+LX//7UPgv/8A5N26
 Vpjeb7p0aJUWnAzwSCMn0Cp4MyWrl/VzCGaCUMPDM1ekYNqtGNdjLxoAepw0xE8WtbA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=linux.microsoft.com; 
 dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com
 header.a=rsa-sha256 header.s=default header.b=PPBbDMu0; 
 arc=none smtp.remote-ip=13.77.154.182
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=13.77.154.182;
 helo=linux.microsoft.com; envelope-from=sriramsriram@linux.microsoft.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=linux.microsoft.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com
 header.a=rsa-sha256 header.s=default header.b=PPBbDMu0
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1343D60681
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 19:11:05 +0000 (UTC)
Received: by linux.microsoft.com (Postfix, from userid 1251)
 id B8E8720B7169; Tue, 15 Sep 2026 12:10:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B8E8720B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1789499420;
 bh=m+iaBvCyZDT4yY7gif4zlTFK4Py9FYY7AOa0QMuoyEE=;
 h=Date:From:To:Cc:Subject:From;
 b=PPBbDMu0eiw96Nd4fZnNUTWQ0khd39vVRLBDxx1aqhh94OVIZvDpYcO6w5/ocjrXA
 6pr1QT5mg5iGeNHOT+sdNXvgzzoK16IrmKx7BLhzbCniu8C0GkFs4fJVDrR2Sonoa+
 8R04ABGryEKMB36C2eg/xKk/iGlgKqirpArpJ7fI=
Date: Tue, 15 Sep 2026 12:10:20 -0700
From: Sriram Sriram <sriramsriram@linux.microsoft.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org;, jerome.forissier@arm.com;,
 ankluemk@microsoft.com
Subject: Re: [PATCH 2/4] boot: image-fit: add overflow guard for FIT
 decompression buffer
Message-ID: <aqmYHG/KDZT6K8AB@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

ankluemk@microsoft.com 
Bcc: 
Subject: Re: [PATCH 2/4] boot: image-fit: add overflow guard for FIT
 decompression buffer
Reply-To: 
In-Reply-To: <20260910190944.GN1764417@bill-the-cat>

On Thu, Sep 10, 2026 at 01:09:44PM -0600, Tom Rini wrote:
> On Wed, Sep 09, 2026 at 12:20:14PM -0700, Sriram Sriram wrote:
> 
> > From: Drew Kluemke <ankluemk@microsoft.com>
> > 
> > Add an overflow check before the 'len * 20' multiplication used to
> > compute the maximum decompression buffer size. On platforms where len
> > exceeds ULONG_MAX / 20 the multiplication wraps to a small value,
> > leading malloc to allocate a tiny buffer while decompression writes the
> > full stream -- a heap buffer overflow.

> OK, so lets assume an overflow, or just an invalid max_decomp_len,
> shouldn't image_decomp handle this case and fail and we catch it?

You are right, and I should not have sent this one as written.

max_decomp_len is used for two things -- the size of the buffer we
allocate, and the unc_len bound we hand to image_decomp():

	if (load == data) {
		loadbuf = aligned_alloc(8, max_decomp_len);
		load = map_to_sysmem(loadbuf);
	} else {
		loadbuf = map_sysmem(load, max_decomp_len);
	}
	if (image_decomp(comp, load, data, image_type,
			loadbuf, buf, len, max_decomp_len, &load_end)) {

so if the multiply wraps, the buffer and the bound wrap together.  They
cannot diverge in the dangerous direction, which is precisely the
scenario the commit message claims.  And every arm of image_decomp()
does honour unc_len -- IH_COMP_NONE has an explicit "image_len <=
unc_len" test that returns -ENOSPC, and gzip, bzip2, lzma, lzo, lz4 and
zstd all pass it through as the output size limit -- so a too-small
bound comes back as a failure and fit_image_load() catches it with
"Error decompressing %s" and returns -ENOEXEC.  That is exactly the
behaviour you describe, and it is what already happens.

For the record on reachability: on 64-bit ULONG_MAX / 20 is about
9.2e17, so len would have to be an exabyte-scale subimage and the
multiply can never wrap in practice.  On 32-bit the threshold is about
205 MiB, which is reachable, but per the above it degrades to a failed
decompression rather than to memory corruption.

So please drop 2/4.  I would rather withdraw the claim than try to
defend it.

While re-reading this, two things nearby do look like real (if smaller)
problems, if you think either is worth a patch:

1. aligned_alloc() is never checked for NULL.  A len that is merely
   large, with no wrap involved, makes the allocation fail and we hand
   the NULL straight to map_to_sysmem() and then into the decompressor.
   The IH_TYPE_FLATDT branch a few lines below has the same shape and
   follows it with a memcpy(loadbuf, buf, len).

2. image_decomp() takes "uint unc_len" while max_decomp_len is a ulong,
   so on 64-bit the bound is silently truncated.  The truncation is in
   the safe direction -- the bound ends up <= the allocation -- so it is
   not a bug, just surprising: we can allocate 20x and then refuse to
   use most of it.

Happy to send (1) as a standalone patch, or to leave both alone.  The
other three patches in the series do not depend on this one.

Thanks,
Sriram

