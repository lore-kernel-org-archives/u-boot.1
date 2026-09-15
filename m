Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65922C88E77
	for <u-boot@archiver.kernel.org>; Tue, 15 Sep 2026 23:13:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 556E480974;
	Tue, 15 Sep 2026 23:12:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 88_Aoa0B5ElA; Tue, 15 Sep 2026 23:12:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 26449808C8
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789513978;
	b=tF8sFkviGidw5QllsC2FddjI+vPpWOcH7NJbqcUEz+XJA8Kf4iMUP5tzYTGM87qp/J5X
	 Qpjzp/gvagka8cuUim3n5o1SH35xCUlG6/s5HlQrvHhGOCLXDPcOzOt9pUFS2Y1+78+iX
	 y/F8HX9WGQh/3q+oSGaxiemRZ8zMGcM0KFnYO2J9SToqKezPGRFNet7Jae7diZB3r6IHP
	 H/mFDBsJyou9vmxzxxtwUG9rGPFsMwIA4XpDCFy+/mEJecKXM1Qx8swEUKcB9sSgjRn2C
	 8lKMhNV1dVuDw2XqbymSbdCq1uwaWvHqdFqfyRvdBUXnm5DyzkfYS0zFR3nMxNLuBLA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789513978;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Filter:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=WviTDzp/VN4hzSoD974FBcsuyEs4vgWSge40i8IQd9M=;
	b=MkliPEfOEwMIb7nTNw3c6fP0QEKN/GdUaVhHxmeqtrsLT+yt7Dd9OPZgyaK+GDHU6QUI
	 /tZDi4Cvw7b1NqZvRVK6sN11M2n8/J5dFLnEu/n2u6ohSiWK0S2+1E6NSabZI2KBtVz5f
	 omHMlU0EAT6N5DbN/appznCeZ8sUCrp9Z16lXDpWEUVSnTuIU6l2zB6ezZ0p6ZzruznE9
	 o41i53Z8zj1H4SGPFW9BlhcGTYOyTLpQlDJ7OX3Ijqle5mQCLRQR1l06WTloFNOm11Kqh
	 kSZx5to0AsGuzP45ZYSoAmWZdR5F7HWwFJAx5LKnYGW0ONCHdtoQrDllNL88Fu2+J+g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789513978;
	bh=WviTDzp/VN4hzSoD974FBcsuyEs4vgWSge40i8IQd9M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=doRP7TjTIX6WzVTriKBkB1BTN+KOvHSQUfqbobj3+Mu+sXudBkNxoaonB/ffj4tOJ
	 CsJPmfBQ5yaCcgjDj+rmsLicmq0La4dBg+EBbcFBFiJdKWyRMoUjLCXfW6UjqmzaGd
	 2UPU1Ys3+z6+8uk7OPJWhmFKd7lTHDwraTHtdNHbU/Y56b4CkNjAXVn3ifVXl72Fau
	 H4d78G8IS4j9dWpns69LhPqXUIPzIga3igoz5GGjaGOp9YZ8OlemZp4Ovqk6seItji
	 HVE11KgtuI5DDt6slxWvWo+39zNYWbFol2gRVd7OUkq6kPc9w1juGSlDGWwjEpTycG
	 Ubm9EAFVhbPLA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 26449808C8;
	Tue, 15 Sep 2026 23:12:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4C7AF388
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 23:12:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3EF8B4067A
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 23:12:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oGRU5aZQXdtY for <u-boot@lists.u-boot-project.org>;
 Tue, 15 Sep 2026 23:12:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 4E0734066F
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789513975;
 b=GuiD9/6tuIqS9TXL/kQYxnNiGOtOiCyGS+E8xrvUAPmXzT4xkInjMvpOmh+2FDx0IM13
 FA7S6bFt7KuBdTbRSLhHV88Ogp8fV46b1TzFBujTTfUhVIYs6MxC4wfZxKHVjY2ty4KuZ
 W3NvVIaM9lu4FrHNzEG8DGBvsIzn4N0KzUdNcSqYB1wdayNJwB9Fgm2vdKZQxMnOkPa8k
 QU25ZQe+L7y5QqBe5Xm7K6MDKAPfZJqzPypnvi7QcpcBGcJdacSkgJOUoIbQj3pVRXac+
 q/Qn2RZLQAeFqawcsWvivO5o4o8lMNjYxBUO6gUFVAb7u/uPCR0KBgPCiTK9uCMMfXQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789513975;
 h=Received-SPF:Received:DKIM-Filter:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
 bh=WviTDzp/VN4hzSoD974FBcsuyEs4vgWSge40i8IQd9M=;
 b=rgHKcPZVy3QOAIFGDwsZsDadlKoOPBTpbCBYE9QvLfVUx5KzRQQdesj55C4l6liRNWnu
 IRHbcSRoR8NgXFV9P4oGgHiWFO88NncxeA8myeBogCqyhWT1TDEr+hVaPSLPBBGQruOOL
 r56frZv/0SqUCpXswaHpj12HEb16jImXRBTwjOoTNGLeKRPuHWHPq4Ieg7St+mkvA7J0G
 plIZz9842Bauu/NOu1tMYBFwHsspFEmCNprp+fIgVddC1+IwaNyMlj+src7N2CHV3ioMG
 i5quKZFRSNHIdY1EUOFFkQ8gVLjigVoYlIEsUvC3OD9eS5hd0wN08fqFsANVnjeFuTw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=linux.microsoft.com; 
 dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com
 header.a=rsa-sha256 header.s=default header.b=GR9PJWRS; 
 arc=none smtp.remote-ip=13.77.154.182
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=13.77.154.182;
 helo=linux.microsoft.com; envelope-from=sriramsriram@linux.microsoft.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=linux.microsoft.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com
 header.a=rsa-sha256 header.s=default header.b=GR9PJWRS
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4E0734066F
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 23:12:54 +0000 (UTC)
Received: by linux.microsoft.com (Postfix, from userid 1251)
 id 6A0E620B7169; Tue, 15 Sep 2026 16:12:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6A0E620B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1789513930;
 bh=WviTDzp/VN4hzSoD974FBcsuyEs4vgWSge40i8IQd9M=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=GR9PJWRSQLpDRX5hGWaiJX963TOSY2zFG8eB0HLwhEcfV2sAhc/LNa4A3MrB2zDCm
 3J+TgGXV2t9FLUm3PgW1DJxC0JKkBpZc4tir84s5C7kk9U6AgJUJhBd9kpPl7NM135
 f9Qm4B1Zi0iJ9Bu9unS4Lr6an22CvxPJ2+Y3rO7I=
Date: Tue, 15 Sep 2026 16:12:10 -0700
From: Sriram Sriram <sriramsriram@linux.microsoft.com>
To: Tony Dinh <mibodhi@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org,
 ankluemk@microsoft.com, v-dmunic@microsoft.com, jerome.forissier@arm.com
Subject: Re: [PATCH v2 3/3] fs: ext4: widen ext4fs_update() block-group loop
 counter
Message-ID: <aqnQyndPL6kcbdtP@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <aqm9WMSA/H8sJzhT@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20260915221246.GF858934@bill-the-cat>
 <aqnDxAE7vFfSm1M+@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <CAJaLiFxTXB_nTR1nd5xFn5ttQx7TBPF-Lpgdk3CuwzxWY7UGig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJaLiFxTXB_nTR1nd5xFn5ttQx7TBPF-Lpgdk3CuwzxWY7UGig@mail.gmail.com>
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

On Tue, Sep 15, 2026 at 03:41:32PM -0700, Tony Dinh wrote:
> Hi Sriram,
> 
> On Tue, Sep 15, 2026 at 3:17 PM Sriram Sriram
> <sriramsriram@linux.microsoft.com> wrote:
> >
> > On Tue, Sep 15, 2026 at 04:12:46PM -0600, Tom Rini wrote:
> > > On Tue, Sep 15, 2026 at 02:49:12PM -0700, Sriram Sriram wrote:
> > > > jerome.forissier@arm.com; ankluemk@microsoft.com; v-dmunic@microsoft.com
> > > > Bcc:
> > > > Subject: Re: [PATCH v2 3/3] fs: ext4: widen ext4fs_update() block-group loop
> > > >  counter
> > > > Reply-To:
> > > > In-Reply-To: <CAJaLiFxMbEO1hk0o6ja6w1SKN-hVK4tGkvUo90uO+eFgAc631Q@mail.gmail.com>
> > > >
> > > > On Tue, Sep 15, 2026 at 02:23:12PM -0700, Tony Dinh wrote:
> > > > > Hi Sriram and Daniel,
> > > > >
> > > > > On Tue, Sep 15, 2026 at 1:52 PM Sriram Sriram
> > > > > <sriramsriram@linux.microsoft.com> wrote:
> > > > > >
> > > > > > From: Daniel Munic <v-dmunic@microsoft.com>
> > > > > >
> > > > > > ext4fs_update() iterates over all block groups with a signed 16-bit
> > > > > > loop counter:
> > > > > >
> > > > > >         short i;
> > > > > >         ...
> > > > > >         for (i = 0; i < fs->no_blkgrp; i++)
> > > > > >
> > > > > > fs->no_blkgrp is a uint32_t. On a filesystem with more than 32767
> > > > > > block groups the counter cannot represent every index: incrementing
> > > > > > past SHRT_MAX is signed overflow (undefined behaviour) and the
> > > > > > comparison against the unsigned no_blkgrp never terminates correctly,
> > > > > > so the bitmap/group-descriptor write-back loops misbehave. The mixed
> > > > > > signed/unsigned comparison is also flagged by static analysis.
> > > > > >
> > > > > > Use u32 for the loop counter, matching the width of no_blkgrp.
> > > > > >
> > > > > > Signed-off-by: Daniel Munic <v-dmunic@microsoft.com>
> > > > > > Signed-off-by: Sriram Sriram <sriramsriram@linux.microsoft.com>
> > > > > Reviewed-by: Tony Dinh <mibodhi@gmail.com>
> > > > >
> > > > > BTW, since you are testing this ext4_write, it might be worthwhile to
> > > > > see this commit:
> > > > > https://github.com/u-boot/u-boot/commit/53cc4332b3b37218a7cdab8bdb953da57eec2668
> > > > >
> > > > > Thanks,
> > > > > Tony
> > > > >
> > > > > > ---
> > > > > > Changes in v2:
> > > > > >  - No change, rebased onto current master.
> > > > > >
> > > > > >  fs/ext4/ext4_write.c | 2 +-
> > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/fs/ext4/ext4_write.c b/fs/ext4/ext4_write.c
> > > > > > index 1abedcede72..2fba2197c19 100644
> > > > > > --- a/fs/ext4/ext4_write.c
> > > > > > +++ b/fs/ext4/ext4_write.c
> > > > > > @@ -67,7 +67,7 @@ static inline void ext4fs_bg_free_blocks_inc
> > > > > >
> > > > > >  static void ext4fs_update(void)
> > > > > >  {
> > > > > > -       short i;
> > > > > > +       u32 i;
> > > > > >         ext4fs_update_journal();
> > > > > >         struct ext_filesystem *fs = get_fs();
> > > > > >         struct ext2_block_group *bgd = NULL;
> > > > > > --
> > > > > > 2.49.0
> > > > > >
> > > >
> > > >
> > > > > Reviewed-by: Tony Dinh <mibodhi@gmail.com>
> > > >
> > > > Hi Tony,
> > > >
> > > > Thanks for the review.
> > > >
> > > > > BTW, since you are testing this ext4_write, it might be worthwhile to
> > > > > see this commit:
> > > > > ext4fs: Fix: Read outside partition error (take 2)
> > > >
> > > > Thanks for the pointer. 53cc4332b3b is already in the tree this series
> > > > is based on, so the read path is covered here.
> > > >
> > > > What caught my eye is the note in that commit message:
> > > >
> > > >     Looks like we also have this overflown problem in
> > > >     ext4_write.c that needs to be addressed.
> > > >
> > > > As far as I can tell that is still unaddressed. ext4fs_write_file()
> > > > has the same wrap you fixed in ext4fs_read_file():
> > > >
> > > >     long int blknr;
> > > >     ...
> > > >     blknr = blknr << log2_fs_blocksize;
> > > >
> > > > and on top of that delayed_start, delayed_next and
> > > > previous_block_number are all plain int:
> > > >
> > > >     int previous_block_number = -1;
> > > >     int delayed_start = 0;
> > > >     int delayed_next = 0;
> > > >
> > > > which makes the casts at the put_ext4() call sites
> > > >
> > > >     put_ext4((uint64_t)((uint64_t)delayed_start << log2blksz),
> > > >              delayed_buf, (uint32_t)delayed_extent);
> > > >
> > > > ineffective, since the value has already been truncated on its way
> > > > into delayed_start. The fix would mirror 53cc4332b3b: lbaint_t blknr
> > > > plus a separate long for the read_allocated_block() return and error
> > > > check, and widening delayed_start/delayed_next to lbaint_t.
> > > >
> > > > I am happy to write that up, but I should be up front that I cannot
> > > > test it. The largest medium I can reach here is well below the 2^31
> > > > sector point, and since this is the write path an untested patch
> > > > risks writing to the wrong LBA.
> > > >
> > > > Would you rather take it yourself, given you already have the DS116
> > > > and the 4TB disk set up from the read-side reproducer? If you would
> > > > prefer that I send it, I can post it with you on Cc and leave it
> > > > pending your Tested-by.
> 
> Unfortunately, I don't have any free 4TB HDD left to test with at the
> moment either! That 4TB HDD is no longer available.
> 
> All the best,
> Tony
> 
> > >
> > > Hi Sriram, your emails keep having some header looking content at the
> > > start of them, what are you using for an email client? Thanks.
> > >
> > > --
> > > Tom
> > I use mutt. Sorry, I am new to this. I will be careful next time.
> >
> > Thanks,
> > Sriram

> Unfortunately, I don't have any free 4TB HDD left to test with at the
> moment either! That 4TB HDD is no longer available.
>
> All the best,
> Tony
Okay, I will ignore that part.

Thanks,
Sriram
