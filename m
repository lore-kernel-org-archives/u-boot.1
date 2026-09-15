Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30ACBC88E75
	for <u-boot@archiver.kernel.org>; Tue, 15 Sep 2026 22:17:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BD930607B5;
	Tue, 15 Sep 2026 22:17:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AgsrX8AJqNqW; Tue, 15 Sep 2026 22:17:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org C797C607A7
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789510644;
	b=AWEivU2ph2hfTx7Bxle8gfUukAgQ+lsooIvsLG/CGy6Ko2+2mA9pQLk1jERzYXQvWZ0P
	 vmOGaHJlkuN7IQ4ZpqXMB6TWgCOaateMkIawsC0LdD4EejJ+0g5J0tTKm5ZtcSzT7TQ3m
	 xTirDgqFtLxQD1dFMrq0d85KL3I1PLrTmkEMEO9ApQD92VBw6F5nH/eyVygbk14NUeU1Z
	 F8H41UKSU5+YmBb+/i7/Kq3+0w9qJ70UG3/EUvZxHrZ9044HWaOpa9wWl3Xp78L9D3WYe
	 i6/mMNdUbk80F2sNl2Kq1Up9AXGjrbbaZGFAGUOzVrm76IWpvxvs9eBTd1lonjKIdpA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789510644;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Filter:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=f67BPPOLITcFn4x77sbuTApQdIp48MMQaA/2YY+bpNo=;
	b=OX7/P+xdBtbDdCKRQFsNa3it5kwlSI4TgeaZsgy+g71lL/yQjqE/GQtNljhyze126Y82
	 hvml7drdIEStDvi1Dnxq3wtyLRNLTg7dZbH29nJZ9z8BoTiAjdQ92DQR5f3shGaagXMwJ
	 QsfZ1WehJwTcGo6yQPW8AuwCXcnB10gyLyPxnC2omjFX1q+Gw9JGsKM26ojEbs/wbASkf
	 Y3/GYuONXAExDI2y8qLdiWTfGbUvUGgOTdPD2z+a345VDTrqku+Ra1faonhnDKqOUPP5/
	 3hz0ihoI0n7llhWZ2mR1V59/GpBZKGUztHMRDj5ckmMmHicA9B2iIFXZnMG5zi1biUA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=MOUBkdyP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789510643;
	bh=f67BPPOLITcFn4x77sbuTApQdIp48MMQaA/2YY+bpNo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WjqW3lmc8qP7iQMDdhL559GGXOG4AyRm6+WyEVNO0SylGazY36EtI7C9kLsPTFjQx
	 LByUWyV9us3KdYdv19M1C6PA+E6e/8dN7+wCmR+YkzsdxP9ZRi+FXTuwPQQpQwMg98
	 6QF2SJqH/qMO1cx7ONmTT32Sf6Z/C7crKG50rAy1vRyYkkUGZcH2GC17NynTWHKh4z
	 3X+wsz8ojl23FoFTQADp2r10RoCwDLkJXjn86QtLawgel9RAn9xNVMAGEjJMMjbyaD
	 u625B45uJshvi62lbIdaag+YpiLbhXo9OuXuNy1Ic9c+wtedT/91MOcVYJiKnTUyIP
	 66FfN83eq4rGA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C797C607A7;
	Tue, 15 Sep 2026 22:17:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9990A388
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 22:17:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7FCB5607A7
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 22:17:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wIoDLhV-j6NM for <u-boot@lists.u-boot-project.org>;
 Tue, 15 Sep 2026 22:17:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org A1803605E9
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789510641;
 b=oxYciOmSr2Oio83E5tilBx5bB+KARviijLifFaT5hJKA2UHEraMvigWskZbhxq1wttO8
 t1cKJnSkjJtm4ErDGES3r0lkKqcamngiWwFGbMYhIQ94rJjflevjmTG18VP/cI1hCXf/E
 fS6DjyMsMq8QLhXzYkHcpHhudSxB21afnfgHHi390HNjchVMwmbQEZ1BQi4MMLsOZ5Ypd
 vBVWXkiZkE+4EMIM1QNgJE3WbX4skUQ+1m2ykk6jdZudTiM/P4v/THYXry68DjFfv0K9L
 fP2ez4j/6QQHJdwGrEn3uIQ3kh9eXJcs4/h0j7I+5tOjTBxiGc4c2F+zzDL1DRSZVTg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789510641;
 h=Received-SPF:Received:DKIM-Filter:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
 bh=f67BPPOLITcFn4x77sbuTApQdIp48MMQaA/2YY+bpNo=;
 b=BfnjetxcobhK70NrJIlH0D7BphpAKFwHomaYIvo5nNSUfbnkIH46yRjAr4/o80W7CrRC
 C+R7qbRzrSqP7iakQsbGLlFzVdt8ynOLr/3wQuqKT6EcRNcCFiX7GPOUjDl0eatWHwRmd
 uo+bH3DW4qNkLwoI1P66AT12N1TDLKM8sZLMlNoHrHzL35Lhdq/MaVvNYMbGBYcoTfW/F
 uUPogVWPB3DlftZ0ZWi543WxD1zNOtQfvUjAjRFBtF2E47qzyZ2WYJTUWqJzLp6mNh7hb
 rTrlPuk/z4g3HDF7AO5qTi2BN39emJhNDqGB9Sa7FzYAB/BiwP75qwNjOUKaZdoluMA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=linux.microsoft.com; 
 dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com
 header.a=rsa-sha256 header.s=default header.b=MOUBkdyP; 
 arc=none smtp.remote-ip=13.77.154.182
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=13.77.154.182;
 helo=linux.microsoft.com; envelope-from=sriramsriram@linux.microsoft.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=linux.microsoft.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com
 header.a=rsa-sha256 header.s=default header.b=MOUBkdyP
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by smtp3.osuosl.org (Postfix) with ESMTP id A1803605E9
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 22:17:21 +0000 (UTC)
Received: by linux.microsoft.com (Postfix, from userid 1251)
 id 0979A20B7169; Tue, 15 Sep 2026 15:16:36 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0979A20B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1789510596;
 bh=f67BPPOLITcFn4x77sbuTApQdIp48MMQaA/2YY+bpNo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=MOUBkdyP/4sDExlkMBnhStp2LQ7rcDobeySb5RbfAhwMhHYyiWt7xdkGQ8JJbINuM
 eGOa2j6JsxY4Q93cfgPIgbcFnkwoZHTWYyPnSbrGxZaUGE9RLvg4ZBD3253NJn0M/M
 YRTTaCd18oWLsiUAFvlUJPNwqlNt+6+Mz5Y5tpkg=
Date: Tue, 15 Sep 2026 15:16:36 -0700
From: Sriram Sriram <sriramsriram@linux.microsoft.com>
To: Tom Rini <trini@konsulko.com>
Cc: Tony Dinh <mibodhi@gmail.com>, u-boot@lists.u-boot-project.org,
 ankluemk@microsoft.com, v-dmunic@microsoft.com, jerome.forissier@arm.com
Subject: Re: [PATCH v2 3/3] fs: ext4: widen ext4fs_update() block-group loop
 counter
Message-ID: <aqnDxAE7vFfSm1M+@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <aqm9WMSA/H8sJzhT@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20260915221246.GF858934@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260915221246.GF858934@bill-the-cat>
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

On Tue, Sep 15, 2026 at 04:12:46PM -0600, Tom Rini wrote:
> On Tue, Sep 15, 2026 at 02:49:12PM -0700, Sriram Sriram wrote:
> > jerome.forissier@arm.com; ankluemk@microsoft.com; v-dmunic@microsoft.com
> > Bcc: 
> > Subject: Re: [PATCH v2 3/3] fs: ext4: widen ext4fs_update() block-group loop
> >  counter
> > Reply-To: 
> > In-Reply-To: <CAJaLiFxMbEO1hk0o6ja6w1SKN-hVK4tGkvUo90uO+eFgAc631Q@mail.gmail.com>
> > 
> > On Tue, Sep 15, 2026 at 02:23:12PM -0700, Tony Dinh wrote:
> > > Hi Sriram and Daniel,
> > > 
> > > On Tue, Sep 15, 2026 at 1:52 PM Sriram Sriram
> > > <sriramsriram@linux.microsoft.com> wrote:
> > > >
> > > > From: Daniel Munic <v-dmunic@microsoft.com>
> > > >
> > > > ext4fs_update() iterates over all block groups with a signed 16-bit
> > > > loop counter:
> > > >
> > > >         short i;
> > > >         ...
> > > >         for (i = 0; i < fs->no_blkgrp; i++)
> > > >
> > > > fs->no_blkgrp is a uint32_t. On a filesystem with more than 32767
> > > > block groups the counter cannot represent every index: incrementing
> > > > past SHRT_MAX is signed overflow (undefined behaviour) and the
> > > > comparison against the unsigned no_blkgrp never terminates correctly,
> > > > so the bitmap/group-descriptor write-back loops misbehave. The mixed
> > > > signed/unsigned comparison is also flagged by static analysis.
> > > >
> > > > Use u32 for the loop counter, matching the width of no_blkgrp.
> > > >
> > > > Signed-off-by: Daniel Munic <v-dmunic@microsoft.com>
> > > > Signed-off-by: Sriram Sriram <sriramsriram@linux.microsoft.com>
> > > Reviewed-by: Tony Dinh <mibodhi@gmail.com>
> > > 
> > > BTW, since you are testing this ext4_write, it might be worthwhile to
> > > see this commit:
> > > https://github.com/u-boot/u-boot/commit/53cc4332b3b37218a7cdab8bdb953da57eec2668
> > > 
> > > Thanks,
> > > Tony
> > > 
> > > > ---
> > > > Changes in v2:
> > > >  - No change, rebased onto current master.
> > > >
> > > >  fs/ext4/ext4_write.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/fs/ext4/ext4_write.c b/fs/ext4/ext4_write.c
> > > > index 1abedcede72..2fba2197c19 100644
> > > > --- a/fs/ext4/ext4_write.c
> > > > +++ b/fs/ext4/ext4_write.c
> > > > @@ -67,7 +67,7 @@ static inline void ext4fs_bg_free_blocks_inc
> > > >
> > > >  static void ext4fs_update(void)
> > > >  {
> > > > -       short i;
> > > > +       u32 i;
> > > >         ext4fs_update_journal();
> > > >         struct ext_filesystem *fs = get_fs();
> > > >         struct ext2_block_group *bgd = NULL;
> > > > --
> > > > 2.49.0
> > > >
> > 
> > 
> > > Reviewed-by: Tony Dinh <mibodhi@gmail.com>
> > 
> > Hi Tony,
> > 
> > Thanks for the review.
> > 
> > > BTW, since you are testing this ext4_write, it might be worthwhile to
> > > see this commit:
> > > ext4fs: Fix: Read outside partition error (take 2)
> > 
> > Thanks for the pointer. 53cc4332b3b is already in the tree this series
> > is based on, so the read path is covered here.
> > 
> > What caught my eye is the note in that commit message:
> > 
> > 	Looks like we also have this overflown problem in
> > 	ext4_write.c that needs to be addressed.
> > 
> > As far as I can tell that is still unaddressed. ext4fs_write_file()
> > has the same wrap you fixed in ext4fs_read_file():
> > 
> > 	long int blknr;
> > 	...
> > 	blknr = blknr << log2_fs_blocksize;
> > 
> > and on top of that delayed_start, delayed_next and
> > previous_block_number are all plain int:
> > 
> > 	int previous_block_number = -1;
> > 	int delayed_start = 0;
> > 	int delayed_next = 0;
> > 
> > which makes the casts at the put_ext4() call sites
> > 
> > 	put_ext4((uint64_t)((uint64_t)delayed_start << log2blksz),
> > 		 delayed_buf, (uint32_t)delayed_extent);
> > 
> > ineffective, since the value has already been truncated on its way
> > into delayed_start. The fix would mirror 53cc4332b3b: lbaint_t blknr
> > plus a separate long for the read_allocated_block() return and error
> > check, and widening delayed_start/delayed_next to lbaint_t.
> > 
> > I am happy to write that up, but I should be up front that I cannot
> > test it. The largest medium I can reach here is well below the 2^31
> > sector point, and since this is the write path an untested patch
> > risks writing to the wrong LBA.
> > 
> > Would you rather take it yourself, given you already have the DS116
> > and the 4TB disk set up from the read-side reproducer? If you would
> > prefer that I send it, I can post it with you on Cc and leave it
> > pending your Tested-by.
> 
> Hi Sriram, your emails keep having some header looking content at the
> start of them, what are you using for an email client? Thanks.
> 
> -- 
> Tom
I use mutt. Sorry, I am new to this. I will be careful next time.

Thanks,
Sriram
