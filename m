Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38933C624DB
	for <u-boot@archiver.kernel.org>; Sat,  5 Sep 2026 16:24:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EE059605D5;
	Sat,  5 Sep 2026 16:24:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vf2dHP16u7oh; Sat,  5 Sep 2026 16:24:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 32EB5605D6
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788625481;
	b=NjrX9ootN1iWbdOHJrYD2+ZJNpljHIKSiO7SszGG5b8kDtNEDK3OV4q6LryzKti+6YJM
	 voaVIxtddfnxMxvDzgdnxg6x7wMhDD57cnhgaqI58oOM7n78qlxwxLV/z9acNptiSxoLn
	 M1qeb3UXMFoCfD22O5HdeLQ/BpbxCquYGNoICdOxPVHKviFBtKV7FtfCno09Te7gdX+4l
	 iWI9HlaNDXH/Ze5vhBwWxFIszcdVSjo7R7bELsL5JNpfTJeM4E08xlgFxxvq8Rzj/y4JE
	 uNId/4PQAacEivPM65YAGMB+jroui7e5Fl1uQXd7afo1H5PiiMIdUG3HYJjOU6iE/Yg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788625481;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=0k5vUf7tUXRU+6L0zB4Lqdio1dKX5cHLwuvZmSX9tyg=;
	b=c6dCotCC2GuohE4FebHeiEIHgWeURgpJ8GWjCSAsa11LTdfRfaKzobpTJ8jH6Z9EBioD
	 y+4nNgmtCHdsElZVLo0olIJvcrutRX7nRdOsYn1jw+lGv8cfXyQ4LYCXTealAcrddsWHc
	 z/RQOj4IsgwKpzYvwXvlh1ZKItUqA2stjmonY+Ub8bmw/H8YGvGg6mLEsafCU9nO+qPBj
	 GGSf2uYLDXfBWeIEyeJPtcu+gURaad0YTNTzJxL7EDW9b350mnVbK/yFvLOvMDDgKC/Xq
	 a+TSOg1jhWUZa7opPcTFk8HdSJ1fKVPLGjs1vIkqsdhqspk3q7EaaFjt3axAMdgmwzw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788625481;
	bh=0k5vUf7tUXRU+6L0zB4Lqdio1dKX5cHLwuvZmSX9tyg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fw9uRalNcYbVNHZxlb7297wHphYqiQs4NFmZj2o/Wr6FYJfc3PUS3Dw9xKl8yqPdF
	 TX0eQ1uezA+PIj+2ZCyIJNJ2wfnGMRNcOuSoZBbc+ayAAFx6yPAkpHGG/nXJhb/fA/
	 DPIwVxAN5UW4AjSzqG9kJEsutjBR/Mr8VWfFzmAXUGpynzfQZbnttlMVSJRzjqnsh3
	 E3zbUnbEp12ah+tAejXiPoehQqZjoKwOLO7sxDZwxB2u1XzsEi02HqYUtc13dNRyG9
	 gJ5v/ThGg68UYKOdsG3Jh7LQuQk3HMAp6MxP0ADx4fRHEpj21WdQQaF1xJqOPwyNKC
	 q7VsH9SfKgLEA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 32EB5605D6;
	Sat,  5 Sep 2026 16:24:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id A6F84118
 for <u-boot@lists.u-boot-project.org>; Sat,  5 Sep 2026 16:24:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8D59080FA9
 for <u-boot@lists.u-boot-project.org>; Sat,  5 Sep 2026 16:24:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eque2dxP5eRN for <u-boot@lists.u-boot-project.org>;
 Sat,  5 Sep 2026 16:24:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 88BE580FA6
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=136.143.188.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788625478;
 b=JYL7dTqGAqTW4QsvG8PK5/FJky3H35ppXPJnH83ODX1ySxJXMwLOdA6ivBb9uBS04vty
 c1PENner6lzACUUkhcVLnBqfsw7I0Pvt2EPiYZ349QMZIC3w7aXBTRAVYPm7d3bjU3Zyi
 2I/ZWH0J4n6N4ifA3/6LfqGhEdOKn9l/ciwvYppCUP53mOxzBSCNgUpz/XIuSn6CxbizP
 9T8+ybJH25NRKC2CmPvweae0U5B8WIwlIeajonIsrOjd8uT1uMB4NA0ejAFIFuGp+t4+/
 vLEgNPhq2XzYxhW6nfeEKR3bs/PBYPh3CltQi1wflVYgj/aY5+cmR28xg0RY8Fa0WlQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788625478;
 h=Received-SPF:DKIM-Signature:Received:Date:From:To:Cc:Subject:
 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
 In-Reply-To:X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient;
 bh=0k5vUf7tUXRU+6L0zB4Lqdio1dKX5cHLwuvZmSX9tyg=;
 b=oZb7ZnwD+A/H/jnDPGSVZohepoEGk3GMGkVQlxeuVgmUnIVG6DiU3QpvvY7YBGmCwt3f
 ohMz4/7oRgo86lkAbmKZUasTArSOrjJTzqbFtu/b5eHiFukXoAcsaDXjkvOLvAUGpqZVN
 cFJLN5zLPzhYmCDMxUiwXtaZmDUu8WKu3zbqBWQVhJSt3eLrrcttgkRnzDQJmfD0zeVFP
 YONvBw2vyktHinLxAPddtYIKDGCidZTDIZlntm5Kmcz0CEJMAmpSenqwhFZ9L+vX2FBl8
 V2+cW2mo+ayZmwmCKev5W9A8tDONvH7z/+SIyFvt0IrDcJ1EUeFWBL7FldWQPKXcyCw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=ziyao.cc; 
 dkim=pass header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=XqC6efiN; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=136.143.188.15;
 helo=sender4-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=XqC6efiN
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 88BE580FA6
 for <u-boot@lists.u-boot-project.org>; Sat,  5 Sep 2026 16:24:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1788625458; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=iZ5L4sZD60reU4tPocb2xzf/onbdXfl9RNwGpcq8pH4xpGBHpZPRl4nYeZWQOGC+LrEfJwpvKCGrTuKtORezjg9GzTF2WuloqYKLjOnjul4MmEoNVT1gXsUA3OQ7joKy3Hcsv8TFVt8FTB4RAHl8r2xE8Xw6gDpktIrXeEESd1g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1788625458;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=0k5vUf7tUXRU+6L0zB4Lqdio1dKX5cHLwuvZmSX9tyg=; 
 b=b/dc+h0fJ96fKGooynbbTGf9fTWA+CbdWF264wW5UpryrQug8GUV0jrDetlsxmPo2bmnYXqo2SNcg64DxJTc+a3K7Pv+q7GGOhP2qDCB8Vl/Q7OvSzyVmEsFry3GuVX7fSAqArivW+qWNi4PkRJUS+kfOpd3Xw5+BHiyGEYdb8s=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1788625457; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=0k5vUf7tUXRU+6L0zB4Lqdio1dKX5cHLwuvZmSX9tyg=;
 b=XqC6efiNbyyjA3/begKuij/pbBDY1VEGMV6S6kqH89XrmG1Rl/zNkgqSvkY/PuJh
 PZNlI27UtyTqdOsJxHmnGWHgT50OIo1kh5+o+XbtyM+pvzEZ867468O+Pj7VDBgC9CB
 3wEaPmCPKByXVHG53zcAdTnRgE2zxbh+ka+nUmWM=
Received: by mx.zohomail.com with SMTPS id 17886254554561021.1837940838271;
 Sat, 5 Sep 2026 09:24:15 -0700 (PDT)
Date: Sat, 5 Sep 2026 16:23:53 +0000
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, Yao Zi <me@ziyao.cc>
Cc: Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] MAINTAINERS: Include riscv_timer.c in RISC-V entry
Message-ID: <apxCGQssLJY3trYo@pie>
References: <20260904193517.22312-2-me@ziyao.cc>
 <20260904200247.GT1764417@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904200247.GT1764417@bill-the-cat>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/288.604.18
X-ZohoMailClient: External
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

On Fri, Sep 04, 2026 at 02:02:47PM -0600, Tom Rini wrote:
> On Fri, Sep 04, 2026 at 07:35:18PM +0000, Yao Zi wrote:
> 
> > Maybe because it was added after introduction of RISC-V architecture,
> > the generic RISC-V S-Mode timer driver, riscv_timer.c, isn't included
> > in the RISC-V MAINTAINERS entry. Cover it with the RISC-V entry.
> > 
> > Signed-off-by: Yao Zi <me@ziyao.cc>
> > ---
> >  MAINTAINERS | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 2b3a9ac1f2ae..ab8e611e4eb8 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1518,6 +1518,7 @@ F:	doc/arch/riscv.rst
> >  F:	drivers/sysreset/sysreset_sbi.c
> >  F:	drivers/timer/andes_plmt_timer.c
> >  F:	drivers/timer/riscv_aclint_timer.c
> > +F:	drivers/timer/riscv_timer.c
> >  F:	tools/prelink-riscv.c
> 
> I think adding "N:	riscv" would be a better idea, it will capture
> other missing files too like ./drivers/cpu/riscv_cpu.c

Sounds reasonable to me.

> -- 
> Tom

Best regards,
Yao Zi
