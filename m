Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C55E606A31B
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 04:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=k71XPpxl;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=OyAHni3c
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 389B8405A7;
	Wed,  4 Nov 2026 04:38:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WUtZCLCV7qoL; Wed,  4 Nov 2026 04:38:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 74C0A405C6
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793767125;
	b=ElflTaQK8kHQix/2O1H5EyjlAULfdxjx0E9IBW4K7wPrSTAT7iQa+51d3BB+Gi+2GLm0
	 XNyObvxJQsFploLi2LY7OryZ0vlAqsfNvbZDz83QTgw18DGodB/uUHrkRGom/gptqKA1Q
	 bGnojSL/ib5vd4mP09vk6IlC5HdpGtLUKmxCZ0mLumh4rBpWc9u9s7WAUUxdExHJE/EP6
	 ocVH2MAa7HkbHsvfB8uf/zw/DIGQNt0krl3WqIm7omZA3h6STUFmgPMYUrJaVZM7fEs0F
	 2OHlOnpereLUklc7PAC6vYMO9ZeEUeEnVM0DDweOEtKUMYWerdQ02n2hYLZs8RpFV/g==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793767125;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=W4LJJxTS0A7MlgfR6CGOfc9gB6YT14lqU7z/QC2TIL0=;
	b=bwDL5oTKd7tprgkqDWhGKcvEyBgibPH+pZ/4x5XuGdUYZtBnjqrYILoz01yJCJXXm8cb
	 cgppN2E0PmrH64gvaFe4SyB9iprQcrg6o609/hrzVIB4UJmpbYIl3UFsS3aLiSdcgOZCV
	 qztK21ozXG9wEG/zmCisYWTefQSbb9eS3CXK2YOuVUJjD9j+T3wv/2JbypqAAiA6KNbmp
	 KK8Ax5TtOrT9gQvRioj4q//5CnuvqrQpJr4BrzeCSJ6u9ji0uaYyDmQwsZcLw3cGjO/mW
	 aFwQ659ur4ESQkmDoDgDQ1km7OE+5Qf2RIfq9JIM90cjuI6+P9On6HD07JbWUplgnBw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793767125;
	bh=W4LJJxTS0A7MlgfR6CGOfc9gB6YT14lqU7z/QC2TIL0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=k71XPpxlC6xmC+yLtPRqRfv1SV72F1+ZsuuAb9TX+Rvwh4smKLnj9cRSYyOhSkiHe
	 /MNtSP7/S50pgL5VgDj66LkaCX+7EluFFMaN9KAVNSh2lKgGaPcXgiyPbj7pl6YgWp
	 S42qZXDoY2Wi8hFKvtPgaDvD8kS1qwtZP3jpDYe9JeDr5ujKgmDAQv4VxvVhXk1bgO
	 g8Qjrm49da1bzAMEVxDnWDCQFXo5nRp04tQgXSnvEfTczyRZVXMNeTw3WqH6yH4yEa
	 qM1iZGA36w9yHYKYrqR3QJdyxNN4TGnnNy3N9cvgtWw67roDRb1/eJGcvndITejObH
	 5zbvsqMOSY71w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 74C0A405C6;
	Wed,  4 Nov 2026 04:38:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 57DD5A10
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 04:38:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 495E580BD1
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 04:38:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NjpJatKsYihH for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 04:38:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8F46E80BB6
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793767122;
 b=MU4YfadZmxJHUMiEYtIeUxq767DW8s2BIstc/ceyjJ3y6LPfEzrWJmZ2ZbweYiN3Xhwh
 rgbhkPqlo5AlxvXoSLvNtDqnKlnYpfar27TMoUn4gH9V2Y6vn7cYuWNhqhgxdJS30FWY5
 oVdKJarYkfiRywAkBeHFWzdhnuOjCkKnAhgynQCGq1Y2ZzkDekwlom/xVquFbiSm2KZ1e
 RzF+59pHHeSu/SzFxn39Tvi0JZmqZnXsuAZmcWLix7Eiqfd6R87bYPhy8GDFqMlpZyHyI
 WwN3UMmXxw/KRiB9u7tb7GLrNz23EaNvUk0xkKD8k4xVETvJwh3mfoe+1JZKjH+9ejw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793767122;
 h=Received-SPF:DKIM-Signature:Received:Date:From:To:Cc:Subject:
 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
 In-Reply-To:X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient;
 bh=W4LJJxTS0A7MlgfR6CGOfc9gB6YT14lqU7z/QC2TIL0=;
 b=nlvFFR2kkRsjtVeiJ4boYPAUDXbBxn6g4/0lj3w1+mMdQWzOx5yVihVuZsnKbL0qP/c7
 T2ITe4AR0n0ywSQz7Uh/gOJeyMapMvi3eoGPMPOfEf3AdRx6sig3WaaFnZmYLp8t8IOy4
 ZdpjEd+ne6Vuyk1QqboA4e21xKyWmZUHqy7FEbS8UYiBhkf6oo3qXgmWxN7abWYGP0ekM
 Y4ADELE6kEF4uwENuuquF6o4Kv8wQ2UKZ2KAmsBB9ea3qbwBeWgniRTybeDUHs+nKKdTx
 f86iYNEGg9lA78hA1UAQpviJhzHQXgbuFOK+UaZuc36nPFWsTu7DsAejdBLkd7o60uQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=ziyao.cc;
 dkim=pass header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=OyAHni3c; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.15;
 helo=sender6-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=ziyao.cc header.i=@ziyao.cc
 header.a=rsa-sha256 header.s=zmail header.b=OyAHni3c
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com
 [165.173.180.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8F46E80BB6
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 04:38:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1793767114; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=gYJ7nJln/oCpd6lN2WFYi2ovdNwIAzlOWkr6WBEn+ukt9HLFHfp4BJNIMD8RHM6jDD7gd6z0l2gracBldIScBRDPnlVKW+7CVLbp2ChaYGozT+9rgaYAzAtKbvrMAQzBGh0iXKl4NtfEeQAigv3Xle3aUvIyyvZn32ptxygiXto=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1793767114;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=W4LJJxTS0A7MlgfR6CGOfc9gB6YT14lqU7z/QC2TIL0=; 
 b=mNU6dFnj8NtPy90tb9rlsuUmzCoSezm3ee3a8aDHfs8CM6LMUboBKvc3UTp2CMd2YrttwzMzHyC1hUJKQdNmKFyPm2T6ZJJW/p16e0bd58a4/u0mvJMIaGBJ7ExAFcJPc0dtu1WFCk8Rrs7rz3obqrFhQK8N6JhwhBbCudlQh6Y=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: a=rsa-sha256;
 b=OyAHni3cdiAc5Md/pIMG2LgPdM2Jrxx9S033WgcpPPftUcrDk321xqxCYhZfcqmIGQIyzJGiODAzdmrcweViNkR2Jgy2T+twgYalwPxyXxIVjH1B9vqrgvaAJ5GyuHRbpow3C4MTzlgsKcFsCYG2TqplgYa4jWAPwTm3thGK0Oc=;
 c=relaxed/relaxed; s=zmail; d=ziyao.cc; v=1;
 bh=W4LJJxTS0A7MlgfR6CGOfc9gB6YT14lqU7z/QC2TIL0=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1793767113526332.91325667018646; 
 Tue, 3 Nov 2026 20:38:33 -0800 (PST)
Date: Wed, 4 Nov 2026 04:38:28 +0000
From: Yao Zi <me@ziyao.cc>
To: Simon Glass <sjg@chromium.org>, me@ziyao.cc
Cc: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v6 09/20] LoongArch: Exception handling
Message-ID: <auq2xOM7t4GbZ80Z@pie>
References: <20261029050738.1107663-1-me@ziyao.cc>
 <20261029050738.1107663-10-me@ziyao.cc>
 <CAFLszTjY5vKOwaa2nis=HdNvSO3kFh_xu_MPevApBJnPPbZpWw@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLszTjY5vKOwaa2nis=HdNvSO3kFh_xu_MPevApBJnPPbZpWw@mail.gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/293.744.82
X-ZohoMailClient: External
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Oct 31, 2026 at 01:43:22AM -0700, Simon Glass wrote:
> Hi Jiaxun,
> 
> On 2026-10-29T05:07:18+11:00, Yao Zi <me@ziyao.cc> wrote:
> > LoongArch: Exception handling
> >
> > Add exception entry assembly code, import stackframe.h
> > from Linux, provide debug prints when exception happens.
> >
> > Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > Signed-off-by: Yao Zi <me@ziyao.cc>
> >
> >  arch/loongarch/Kconfig                  |  19 ++++
> >  arch/loongarch/cpu/Makefile             |   2 +-
> >  arch/loongarch/cpu/genex.S              |  21 ++++
> >  arch/loongarch/include/asm/stackframe.h | 175 ++++++++++++++++++++++++++++++
> >  arch/loongarch/lib/interrupts.c         | 185 ++++++++++++++++++++++++++++++++
> >  5 files changed, 401 insertions(+), 1 deletion(-)
> 
> > diff --git a/arch/loongarch/lib/interrupts.c b/arch/loongarch/lib/interrupts.c
> > @@ -0,0 +1,185 @@
> > +#if IS_ENABLED(CONFIG_SHOW_REGS)
> > +	show_regs(regs);
> > +#endif
> 
> show_regs() is already __maybe_unused, so please can you use a plain
> if (IS_ENABLED(CONFIG_SHOW_REGS)) here, as you do for FRAMEPOINTER
> just below? LoongArch has no SPL support yet, so it is fine to leave
> out SPL_SHOW_REGS.

Sure, but I'll use CONFIG_IS_ENABLED to take care of SPL cases as well,
since I'll definitely work on SPL support later.

> In any case:
> Reviewed-by: Simon Glass <sjg@chromium.org>
> 
> Regards,
> Simon

Best regards,
Yao Zi
