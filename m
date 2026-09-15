Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85B68C88E75
	for <u-boot@archiver.kernel.org>; Tue, 15 Sep 2026 21:50:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E09EF606F7;
	Tue, 15 Sep 2026 21:50:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id g3uuU1V0dRLT; Tue, 15 Sep 2026 21:50:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org CA81E6079F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789509003;
	b=Xvl1fskS95LfYP3renug2VLiMf9lZbbmKn5B1FyjW/yfLRORxzfJAvZBlaoy7w5L22h0
	 Qz+osjZa1Ng0yR2Jku5tvTo7PWgJHBIGPYwzvgTjJRTW4T5Z6fnPbC3hWT+bpANtoTsfh
	 Q7r4/15d6WRAc8OZSzEdIsWGj1XJ1XVjagEClD1KC5nOByZgWR3ueZRTRqe4aOPDq2pqj
	 PwbZT6bk+lIBPX87QLFpAVI3/00RMXVR1YvdcVKM2B1+/yQqO9+ZLYH+J1Mr8IWvwKzEY
	 +48NRIDMKgAWG9+Yg0PTF9/Qc90UH6PUGPONf744YwOdEd630QT1Ck4oIJIFJTQebCg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789509003;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Filter:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=36qQk7hGwl+ZuzJIkKX/GhcG1eIByUvr99dktvLuFlk=;
	b=EjHzWwWJq3s9SvPKh1fZ5RnAiGXqzrO79jJGGAA35SfC0zWN5xL5PyCy5EVxfYl69Owl
	 N851/SfomXMcXb6yxvfwUu6gO/QbdRay6gnkV6eAKS0+jcrz9DEK/QlWCS7D3uUCCGvkb
	 8yN3z41uw50On/klHBzj/4tE6PSVCS5M8/3XN8bP6iDxd4NwwI8leEZ3O+z622+GR9rXb
	 POyhinfehoMnmZ9YGQ/VdAZY9MAbbyIhOlMRlTfR14ZLpQvduKWYO6MqANlMewq6GmXg8
	 q306i7evkuFZJQNosasDT549Fd6/vYSZBQpW/4+oAfqsizb4qClkdscAJVQOBwJ3RTQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789509002;
	bh=36qQk7hGwl+ZuzJIkKX/GhcG1eIByUvr99dktvLuFlk=;
	h=Date:From:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=YbUv3WCYmc/z1RqU9JP3pbMCP5pXWDdaueiRSxI7HovO+zZ9uH2Y+KLz4rUNkfDCr
	 39tyc8alJwrkv0zImG40M0rQjkfVLvhlnuu9Ky3dG3RqFzm3Bw8pVxho4ysWqM6Dqk
	 pVRpEDFH16DtSTEAqEoPGNjdQOBqithuoa+uI+XTlIURruhDG/DARfi6bQUVXvkzeN
	 b6lB/mhJlpIqG0p82t/klQX6LLVuvpAovkfyI8Nplc2aCvdixRd1d1w0Kd4l/82a+n
	 noTb8RZVCzwdIXRvmtEKpuPNOFxlNU0oZFPvlbOsvIPQx1KLaz9X8tgGDWKDmbrBxK
	 HGyAP6ar8uEzA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CA81E6079F;
	Tue, 15 Sep 2026 21:50:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 078952E3
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 21:50:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E1A8F4025C
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 21:50:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j0uWGb6P5l8E for <u-boot@lists.u-boot-project.org>;
 Tue, 15 Sep 2026 21:50:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 0C4834008C
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789509001;
 b=eZ37sdaSt/QZqyHF2G1NZbw37lBCZt8ZTVj6YSiDT64fx9nRVxrfT7Y+A3dV5G1SvS3q
 WMO4dKBNFBIHIeoqU4Do2JYG0MskIjv7E3nUeiNOPOEO0G7OWAPIMaVv3kQRGZ1jChoYF
 hYeEO9fQusfQQjDO1V+6Vf8MbFun33mBpY6XJB0jgoW9itsp/7SY2hnInwhQBbckHbvAw
 W9JHyCVCBepj/LRCkTXHIEJuKsJ97CM7ETIA2LR8iAG8CwZ17E1VQ5AlNs0ypWQK0SbaV
 BfPooJcsbuD2aCp+ncJDnwTsd9Q0l85ZBTlta0a65tSfFppz6v1H+wg4HBEIkc3we2A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789509001;
 h=Received-SPF:Received:DKIM-Filter:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:MIME-Version:Content-Type:Content-Disposition:
 Content-Transfer-Encoding;
 bh=36qQk7hGwl+ZuzJIkKX/GhcG1eIByUvr99dktvLuFlk=;
 b=SkgfzX/01W5kWOVeiGpCrvE7ztucExf6XWAO/5trCcfPahYg/8SkUzz0+vo8A8pJibt1
 OvcLu3yB53UEwdnRc9ROk+nNNkAUR8MuookqN74UHjr5/Er16WwUAy48QnWpL+FzUveaO
 5ZN/uwh6KyOohnhKyW1bmpx2xHegNEEfr1JvCuWb+NZzUcNpw/aE2ZJT0u3ThGl/8XkS9
 FlOiS57lbmklSgOm5Qpf1tuzuL8Y4QhKQMqsOaYLkDzVNX8xvxVIYWAN1B0L95Pv4dfj7
 VsWzYw7vS976L8sQvyNwzX1tBgIZMJhGwangWKIgOLYa05MPUp/CDbtVlmVQAo4nH9g==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=linux.microsoft.com; 
 dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com
 header.a=rsa-sha256 header.s=default header.b=rRrTRSgX; 
 arc=none smtp.remote-ip=13.77.154.182
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=13.77.154.182;
 helo=linux.microsoft.com; envelope-from=sriramsriram@linux.microsoft.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=linux.microsoft.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=linux.microsoft.com
 header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default
 header.b=rRrTRSgX
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0C4834008C
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 21:49:58 +0000 (UTC)
Received: by linux.microsoft.com (Postfix, from userid 1251)
 id 0293B20B7169; Tue, 15 Sep 2026 14:49:13 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0293B20B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1789508953;
 bh=36qQk7hGwl+ZuzJIkKX/GhcG1eIByUvr99dktvLuFlk=;
 h=Date:From:To:Cc:Subject:From;
 b=rRrTRSgX7cWxC4vlHOUOksoneJ1FW6mvCAb+5KjE2ZsafbSxwjCzJSyU7vTurlkYY
 U2zVoE7x+YG1Ml24zi029z55TBhqTD2+JNLyWpvcWhbHwHuAZx2qDyYzFZrhJkyeTQ
 WgteOsh8Yj3vDSOxJNoY0qm3s3eJjlhViBZNd2I0=
Date: Tue, 15 Sep 2026 14:49:12 -0700
From: Sriram Sriram <sriramsriram@linux.microsoft.com>
To: Tony Dinh <mibodhi@gmail.com>
Cc: u-boot@lists.u-boot-project.org;, trini@konsulko.com;,
 ankluemk@microsoft.com;, v-dmunic@microsoft.com;, jerome.forissier@arm.com
Subject: Re: [PATCH v2 3/3] fs: ext4: widen ext4fs_update() block-group loop
 counter
Message-ID: <aqm9WMSA/H8sJzhT@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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

jerome.forissier@arm.com; ankluemk@microsoft.com; v-dmunic@microsoft.com
Bcc: 
Subject: Re: [PATCH v2 3/3] fs: ext4: widen ext4fs_update() block-group loop
 counter
Reply-To: 
In-Reply-To: <CAJaLiFxMbEO1hk0o6ja6w1SKN-hVK4tGkvUo90uO+eFgAc631Q@mail.gmail.com>

On Tue, Sep 15, 2026 at 02:23:12PM -0700, Tony Dinh wrote:
> Hi Sriram and Daniel,
> 
> On Tue, Sep 15, 2026 at 1:52 PM Sriram Sriram
> <sriramsriram@linux.microsoft.com> wrote:
> >
> > From: Daniel Munic <v-dmunic@microsoft.com>
> >
> > ext4fs_update() iterates over all block groups with a signed 16-bit
> > loop counter:
> >
> >         short i;
> >         ...
> >         for (i = 0; i < fs->no_blkgrp; i++)
> >
> > fs->no_blkgrp is a uint32_t. On a filesystem with more than 32767
> > block groups the counter cannot represent every index: incrementing
> > past SHRT_MAX is signed overflow (undefined behaviour) and the
> > comparison against the unsigned no_blkgrp never terminates correctly,
> > so the bitmap/group-descriptor write-back loops misbehave. The mixed
> > signed/unsigned comparison is also flagged by static analysis.
> >
> > Use u32 for the loop counter, matching the width of no_blkgrp.
> >
> > Signed-off-by: Daniel Munic <v-dmunic@microsoft.com>
> > Signed-off-by: Sriram Sriram <sriramsriram@linux.microsoft.com>
> Reviewed-by: Tony Dinh <mibodhi@gmail.com>
> 
> BTW, since you are testing this ext4_write, it might be worthwhile to
> see this commit:
> https://github.com/u-boot/u-boot/commit/53cc4332b3b37218a7cdab8bdb953da57eec2668
> 
> Thanks,
> Tony
> 
> > ---
> > Changes in v2:
> >  - No change, rebased onto current master.
> >
> >  fs/ext4/ext4_write.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/ext4/ext4_write.c b/fs/ext4/ext4_write.c
> > index 1abedcede72..2fba2197c19 100644
> > --- a/fs/ext4/ext4_write.c
> > +++ b/fs/ext4/ext4_write.c
> > @@ -67,7 +67,7 @@ static inline void ext4fs_bg_free_blocks_inc
> >
> >  static void ext4fs_update(void)
> >  {
> > -       short i;
> > +       u32 i;
> >         ext4fs_update_journal();
> >         struct ext_filesystem *fs = get_fs();
> >         struct ext2_block_group *bgd = NULL;
> > --
> > 2.49.0
> >


> Reviewed-by: Tony Dinh <mibodhi@gmail.com>

Hi Tony,

Thanks for the review.

> BTW, since you are testing this ext4_write, it might be worthwhile to
> see this commit:
> ext4fs: Fix: Read outside partition error (take 2)

Thanks for the pointer. 53cc4332b3b is already in the tree this series
is based on, so the read path is covered here.

What caught my eye is the note in that commit message:

	Looks like we also have this overflown problem in
	ext4_write.c that needs to be addressed.

As far as I can tell that is still unaddressed. ext4fs_write_file()
has the same wrap you fixed in ext4fs_read_file():

	long int blknr;
	...
	blknr = blknr << log2_fs_blocksize;

and on top of that delayed_start, delayed_next and
previous_block_number are all plain int:

	int previous_block_number = -1;
	int delayed_start = 0;
	int delayed_next = 0;

which makes the casts at the put_ext4() call sites

	put_ext4((uint64_t)((uint64_t)delayed_start << log2blksz),
		 delayed_buf, (uint32_t)delayed_extent);

ineffective, since the value has already been truncated on its way
into delayed_start. The fix would mirror 53cc4332b3b: lbaint_t blknr
plus a separate long for the read_allocated_block() return and error
check, and widening delayed_start/delayed_next to lbaint_t.

I am happy to write that up, but I should be up front that I cannot
test it. The largest medium I can reach here is well below the 2^31
sector point, and since this is the write path an untested patch
risks writing to the wrong LBA.

Would you rather take it yourself, given you already have the DS116
and the 4TB disk set up from the read-side reproducer? If you would
prefer that I send it, I can post it with you on Cc and leave it
pending your Tested-by.

Thanks,
Sriram
