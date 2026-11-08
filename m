Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8452B606A320
	for <u-boot@archiver.kernel.org>; Sun,  8 Nov 2026 13:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=lVwmagq6;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z6y11cXt
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 44EDC80D1D;
	Sun,  8 Nov 2026 13:41:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dn3jbNbWzBui; Sun,  8 Nov 2026 13:41:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1ED1B80DDB
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794145270;
	b=Fy7cJta2Uu9axejIKW1/PaY98RtwNrrR6SSLQnHOfXVK/6lr9ZNIJbRSGnIK6QbM37YE
	 i/uD05AuYOfAKaN7Lwi5nVJfTpLeJDJOaEM6bv0CtZdQ8m2x8hO25WD9oWCmUzW2m33if
	 +pxA2XElE9eC++v75ZUD4LFGHqprt0qL8zCmKw3t6vkrvPDIT7KdGk1LODGyshjFIJGXb
	 DHKXdmUZ1aEmrtCiassuR/eBFOvu11YSS3TD5lxQUW6aTR3VGnPBN/T5Vo6ieCq+ogmNY
	 Z2yUg/5RKZvytVsWjrD0tV+3+dSuapBF/3CNsFtwV3LrrKlQjfKxSSFiyB9e17V/WTg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794145270;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=AM53tgI+N6c7a5pQPdQ4+VmI1taPckQ8iOD+Ti33Oc0=;
	b=JdPg3fXy6F1UCA2CQlCgZl6u9ZsS2W1o9snzoJp2EAKgzI2yx3KPjO7/ipKUA9uosJ1A
	 nA01i+Jqp0iT39w9Q13PgOtSFX8tykX5t27Zqytz+V0wnlszDbWGa6K8PnqeSPoWHglBD
	 xHibklupVkaMEj49EPVC8ouBfWgmxhe3yTVkDxdXxudFl3IINfwtbXJ5u1O3N0EhoIEY3
	 c4XvFA05y7PkU5h10G2S8nGvgcmJbhv4/O2K6RkH/+qW171wHAOzjD6B8xy45EOT+0LwK
	 hrdFy6jBOGcSRhyqQzk1YVdvCtYquTuQLKj9A9isjbbqH9zVWEYZBTN8c7JfEgO7zcw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794145270;
	bh=AM53tgI+N6c7a5pQPdQ4+VmI1taPckQ8iOD+Ti33Oc0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lVwmagq6xMze7oxxcMP+pGbLVSzSdH79iDIVIKEEMasc7ziSuQUUyvzCUJEEWxvmI
	 +vskyeYumlJNkKO0PZ0PzjHGQ+oPRonI7DBuohkm+ONSD+05lQypM8slJWrRQXwqzP
	 zXN8ZmQWon3Nlbt5OdDmsQtEZwchrB+8zQ+c8+PGb2bJNJjJbDAfZoIVL6nX1KpZB+
	 ntyOfEW/vQdnMpaPKxpYJcafo7Ebe2uOMOp5fyjT38tFwgB97tihQaNlE6r3Bn7aDC
	 cvjJjBIw4ap2BLlZgxA++pMkHDx+lJ05qRl3HNJPF6p9c9oJLKzmMuRxXZx//TA6mN
	 VANF1VXnuXh/A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1ED1B80DDB;
	Sun,  8 Nov 2026 13:41:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8DF2D251
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 13:41:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8B4BE400AC
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 13:41:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oDiqEQVPfGKo for <u-boot@lists.u-boot-project.org>;
 Sun,  8 Nov 2026 13:41:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 04FB640180
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::636"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::636; helo=mail-ej1-x636.google.com;
 envelope-from=massimo.pegorer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=z6y11cXt
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 04FB640180
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 13:41:06 +0000 (UTC)
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-c4d30639709so10285066b.0
 for <u-boot@lists.u-boot-project.org>; Sun, 08 Nov 2026 05:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794145264; x=1794750064;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=AM53tgI+N6c7a5pQPdQ4+VmI1taPckQ8iOD+Ti33Oc0=;
 b=z6y11cXtwSZtlqXnfzlZ4Ng6mGU7kw/DgHWRPIMwj9ym7RKnLcZCjZyGibMDnr6hu/
 SfJyDAZtzjm+0ff4GNQHkybrBHRqaCGozRhtHGhuB66BbGGo4/iaDsxtZiwitTO7pWF3
 uidGfGcHxfeB3jBNPnwHHxkmTGz7wF0ZLkRUdHF9Tm17bUOsSv7WZcCdDiyIJ9ACYVel
 Puy+WQuyThac3OAB9I/uyRfdFdr7F9D1Nae5o3yiYneMdF0fUuk6786jByc8VEJrJqed
 y/BzCEsxbKc+2+0CtXze58UHcEKKFnHyt/06rdwig6iT11fCG4ZcGr2axwS4Ti27wHe0
 +4JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794145264; x=1794750064;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=AM53tgI+N6c7a5pQPdQ4+VmI1taPckQ8iOD+Ti33Oc0=;
 b=Pb3X/rsJ77rGhrxUNvsN+BgZzUbBmX2WldQC6qXjGqDMuryevTn2wbcjEaVBfQmu3G
 PBf5Zauci84RyIfMQY4C0FDK5hkD5q1utEcfSKZzgU64woTI+hn23+QtkGXbpUdNhKmz
 eKiKEXZAiR5Ym8oNM/I+IZ2qGVVnN1wxjUV6tp01bZgj6xGxfCLyGhp0LQX0sOw1lrMW
 N9wWw/F8NUP3iB1jPaVdyx8Ek6iQtmyAUyLVmlfAzHC5z+UHlN2BBARUsPqXA7A2Zl/j
 Qi+PtcztMd4lbzjQYDMDqFAxSHPRGGXNPzKCITvhbxGiyEAqstEhTq9BcgcGolWNA5JX
 vE0w==
X-Forwarded-Encrypted: i=1;
 AL+hErHphkXSBXJuD4TSHmVi4B5OghrnSkQdDqYYeNgN2OBrBap4tXVUkM/GqjaHlEaSkbFDydq0Ckk=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z99P7/JJfh7QwAX2poXW8jrZ/dByV+BSFJqICyr4hjFhZVVYTTs
 6FeW+96mFnVZS3/eldZh8KDMyvuz38N5hL021X0ke0m3/PMm+2Eb7vwR+9vmj+sdY1PzsZKezH1
 tV5lTwFo0vl1/DaCUb7LGg7xv6UdRjK8=
X-Gm-Gg: AYBFou3H/Me3fUfOFaQHvEtro3j4faasMMX7QjLtOceQLtcNZX2H4ABzTApmjtqjIfx
 Xstm778P/eOA3JJ4upPFPsGf/2eZe/nUpPMVzClwJnzJMH0xY1Y/gJxTa0BlMoKL3dlBhTP0F47
 T+C3oqVzrRZD0kk+kqoHi+o2WFtfj8QjRT6YOQ0qLRg7NCaFXZGIfq7b31c0CXUQYZFUG6hfzfx
 zk3wfQc8PxIrcp9iFGTWJ0/1q4gz6cqzBSyNP0uHn5AfCLyu10Olcb4G4W/G8T70e75biV0AeBL
 pUD5A6z3IZbO2y0JBIVgpmWq8NH69J3pzVC4KGI2Gry+xkHuieSlBvWS0dDLB35WLPKTmNYyBnt
 MCMG/NWpLPo+po/y6jUPpXkux796C9l89ItBg
X-Received: by 2002:a17:907:2d94:b0:c4d:31ad:f641 with SMTP id
 a640c23a62f3a-c4d6da63b35mr106783166b.3.1794145264274; Sun, 08 Nov 2026
 05:41:04 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261026221147.483695-1-marek.vasut+renesas@mailbox.org>
 <20261104142958.GA1112376@bill-the-cat>
 <ca84f075-5f13-4275-98df-5521b14b9c15@mailbox.org>
 <20261105144209.GL1164024@bill-the-cat>
 <CAC928HbGeoLQuHjiDN+qBU7A=wLa=EgM7xQMppv9LvFh5kV_xg@mail.gmail.com>
 <e6f06550-772f-426f-8b43-da13b58b0202@mailbox.org>
 <20261105194153.GP1164024@bill-the-cat>
 <05e08b26-3dcb-4491-bdbb-77c6fcd5e847@mailbox.org>
 <20261105212346.GS1164024@bill-the-cat>
 <137d1afb-e65d-4d33-825d-c02fdde637b1@mailbox.org>
 <20261106201640.GC3741582@bill-the-cat>
In-Reply-To: <20261106201640.GC3741582@bill-the-cat>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Sun, 8 Nov 2026 14:40:53 +0100
X-Gm-Features: AclHuK_WEmJTC4ju7XXNMHvhps3Gkvd3B1I3jHL7VuiKcFGMQV1cm7pqEzimcYw
Message-ID: <CAC928HZHBi7pjH=HVbiJk1gQayEZdxc7ewMUxxec7JmLO54TRg@mail.gmail.com>
Subject: Re: [PATCH] remoteproc: Hide REMOTEPROC options in REMOTEPROC
 conditional
To: Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.u-boot-project.org
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
X-Spam-Status: No, score=-17.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Il giorno ven 6 nov 2026 alle ore 21:16 Tom Rini ha scritto:
> On Thu, Nov 05, 2026 at 10:30:41PM +0100, Marek Vasut wrote:
> > On 11/5/26 10:23 PM, Tom Rini wrote:
> > > On Thu, Nov 05, 2026 at 09:03:55PM +0100, Marek Vasut wrote:
> > > > On 11/5/26 8:41 PM, Tom Rini wrote:
> > > > > On Thu, Nov 05, 2026 at 08:10:26PM +0100, Marek Vasut wrote:
> > > > > > On 11/5/26 7:51 PM, Massimo Pegorer wrote:
> > > > > > > Hi,
> > > > > > >
> > > > > > > Il giorno gio 5 nov 2026 alle ore 15:42 Tom Rini <trini@konsulko.com>
> > > > > > > ha scritto:
> > > > > > > >
> > > > > > > > On Wed, Nov 04, 2026 at 06:33:21PM +0100, Marek Vasut wrote:
> > > > > > > > > On 11/4/26 3:29 PM, Tom Rini wrote:
> > > > > > > > > > On Mon, Oct 26, 2026 at 11:11:32PM +0100, Marek Vasut wrote:
> > > > > > > > > >
> > > > > > > > > > > Add conditional around REMOTEPROC menu entries, turn REMOTEPROC into
> > > > > > > > > > > configurable boolean, and update all defconfigs and Kconfigs which
> > > > > > > > > > > previously only selected REMOTEPROC driver to also select REMOTEPROC
> > > > > > > > > > > itself.
> > > > > > > > > > >
> > > > > > > > > > > Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> > > > > > > > > > > ---
> > > > > > > > > > > Cc: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
> > > > > > > > > > > Cc: MD Danish Anwar <danishanwar@ti.com>
> > > > > > > > > > > Cc: Tom Rini <trini@konsulko.com>
> > > > > > > > > > > Cc: u-boot@lists.u-boot-project.org
> > > > > > > > > >
> > > > > > > > > > Unfortunately this misses some handful of at least TI K3 platforms. I
> > > > > > > > > > think using qconfig.py to confirm which configs have REMOTEPROC set
> > > > > > > > > > before / after, and that they match would make sorting that part of the
> > > > > > > > > > problem out easier. Do you have time to do that, or should I pick it up
> > > > > > > > > > and do a v2? Thanks.
> > > > > > > > > I can respin this, but do you know which platforms got missed ?
> > > > > > > >
> > > > > > > > I lost the list, sorry. It was a number of the r5 builds. Perhaps some
> > > > > > > > fragment got missed? But qconfig.py -f REMOTEPROC, with a db built with
> > > > > > > > and without the patch will quickly show which oens it is.
> > > > > > >
> > > > > > > This is the result of comparing the two qoconfig.py outputs:
> > > > > >
> > > > > > u-boot$ git log --oneline HEAD~4..
> > > > > > 1e29311663e (HEAD -> master) Revert "remoteproc: Hide REMOTEPROC options in
> > > > > > REMOTEPROC conditional"
> > > > > > 97162e533ca remoteproc: Hide REMOTEPROC options in REMOTEPROC conditional
> > > > > > df3b8e16e6d remoteproc: Make REMOTEPROC_MAX_FW_SIZE depend on REMOTEPROC
> > > > > > d1d45c926a5 (origin/main) Merge branch 'main' of
> > > > > > https://git.u-boot-project.org/u-boot/custodians/u-boot-riscv
> > > > >
> > > > > Wait, your new patch didn't just replace the old patch?
> > > > Nope, it is two patches now, simple clean up one, and more extensive change
> > > > one.
> > >
> > > Alright. I can't reproduce my failure either. That said, should I just
> > > squash these two patches together, along with adding the fix for the
> > > newly added TI rproc option and post v2, or do you want to? Thanks.
> > Nope, keep them separate please, they were intended as a simple fix and
> > larger rework. In case the later breaks something, it could be reverted
> > separately too. Thank you.
>
> After fixing up the patch for the new driver, this patch causes us to
> link time discard rproc code on:
> imx95_15x15_frdm imx95_19x19_frdm_pro (possibly new platforms since the
> patch was posted, missing the same change other imx9 platforms have)
> along with iot2050 phycore_am68x_a72 j721e_beagleboneai64_a72
> j784s4_evm_a72 j721e_evm_a72 j721e_sk_a72 am69_sk_a72
> am69_sk_a72_ethboot am68_sk_a72 am68_sk_a72_ethboot j721s2_evm_a72
> j742s2_evm_a72 aquila-am69_a72 am65x_evm_a53 as the k3_r5f driver seems
> to be missing. I see all this through using buildman's size comparison
> flags, but just "size" shows the basic reduction in text+data.

Your list matches the one I had got from the qconfig outputs comparison (except
for phycore_am68x_a72 which my inaccurate copy-paste left out of my email).

The following two patches, squashed with Marek's second one, should fix the
issues. I have run buildman on the 126 targets interested in CONFIG_REMOTEPROC,
before and after applying Marek's and these patches, and everything seems fine
(assuming I ran it and read the results properly).

Regards,
Massimo

diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
index 27a8bd366c1..2b64070c8d9 100644
--- a/drivers/remoteproc/Kconfig
+++ b/drivers/remoteproc/Kconfig
@@ -102,7 +102,6 @@ config REMOTEPROC_TI_K3_M4F

 config REMOTEPROC_TI_K3_HSM_M4F
        bool "TI K3 HSM M4F remoteproc support"
-       select REMOTEPROC
        depends on ARCH_K3
        depends on TI_SCI_PROTOCOL
        help



diff --git a/configs/am65x_evm_a53_defconfig b/configs/am65x_evm_a53_defconfig
index 5878816f63b..c517872fd1a 100644
--- a/configs/am65x_evm_a53_defconfig
+++ b/configs/am65x_evm_a53_defconfig
@@ -132,6 +132,7 @@ CONFIG_TI_SCI_POWER_DOMAIN=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_REMOTEPROC=y
 CONFIG_RESET_TI_SCI=y
 CONFIG_DM_SERIAL=y
 CONFIG_SOC_DEVICE=y
diff --git a/configs/aquila-am69_a72_defconfig
b/configs/aquila-am69_a72_defconfig
index 2ced2e16cc6..3e6f7e63e53 100644
--- a/configs/aquila-am69_a72_defconfig
+++ b/configs/aquila-am69_a72_defconfig
@@ -147,6 +147,7 @@ CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
 CONFIG_RAM=y
 CONFIG_SPL_RAM=y
+CONFIG_REMOTEPROC=y
 CONFIG_RESET_TI_SCI=y
 CONFIG_DM_SERIAL=y
 CONFIG_SOC_DEVICE=y
diff --git a/configs/imx95_frdm.config b/configs/imx95_frdm.config
index 62459f75c1a..51a5e20a91f 100644
--- a/configs/imx95_frdm.config
+++ b/configs/imx95_frdm.config
@@ -126,11 +126,12 @@ CONFIG_SPL_PINCTRL=y
 CONFIG_PINCTRL_IMX_SCMI=y
 CONFIG_POWER_DOMAIN=y
 CONFIG_SCMI_POWER_DOMAIN=y
-CONFIG_REMOTEPROC_IMX=y
 CONFIG_SPL_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_SPL_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_REMOTEPROC=y
+CONFIG_REMOTEPROC_IMX=y
 CONFIG_DM_RTC=y
 CONFIG_DM_SERIAL=y
 CONFIG_FSL_LPUART=y
diff --git a/configs/iot2050_defconfig b/configs/iot2050_defconfig
index 5111b51b7fe..3d4a8c327ff 100644
--- a/configs/iot2050_defconfig
+++ b/configs/iot2050_defconfig
@@ -125,6 +125,7 @@ CONFIG_SPL_PINCTRL=y
 CONFIG_PINCTRL_SINGLE=y
 CONFIG_POWER_DOMAIN=y
 CONFIG_TI_SCI_POWER_DOMAIN=y
+CONFIG_REMOTEPROC=y
 CONFIG_RESET_TI_SCI=y
 CONFIG_DM_SERIAL=y
 CONFIG_SOC_DEVICE=y
diff --git a/configs/j721e_beagleboneai64_a72_defconfig
b/configs/j721e_beagleboneai64_a72_defconfig
index dc76504eb83..7fe91953fc6 100644
--- a/configs/j721e_beagleboneai64_a72_defconfig
+++ b/configs/j721e_beagleboneai64_a72_defconfig
@@ -140,6 +140,7 @@ CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
 CONFIG_RAM=y
 CONFIG_SPL_RAM=y
+CONFIG_REMOTEPROC=y
 CONFIG_RESET_TI_SCI=y
 CONFIG_DM_RTC=y
 CONFIG_RTC_EMULATION=y
diff --git a/configs/j721e_evm_a72_defconfig b/configs/j721e_evm_a72_defconfig
index ed94fff0885..0b89544563a 100644
--- a/configs/j721e_evm_a72_defconfig
+++ b/configs/j721e_evm_a72_defconfig
@@ -168,6 +168,7 @@ CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
 CONFIG_RAM=y
 CONFIG_SPL_RAM=y
+CONFIG_REMOTEPROC=y
 CONFIG_RESET_TI_SCI=y
 CONFIG_DM_RTC=y
 CONFIG_RTC_EMULATION=y
diff --git a/configs/j721s2_evm_a72_defconfig b/configs/j721s2_evm_a72_defconfig
index b1fbad2fef0..0d09f6ae38a 100644
--- a/configs/j721s2_evm_a72_defconfig
+++ b/configs/j721s2_evm_a72_defconfig
@@ -153,6 +153,7 @@ CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
 CONFIG_RAM=y
 CONFIG_SPL_RAM=y
+CONFIG_REMOTEPROC=y
 CONFIG_RESET_TI_SCI=y
 CONFIG_SCSI=y
 CONFIG_DM_SERIAL=y
diff --git a/configs/j784s4_evm_a72_defconfig b/configs/j784s4_evm_a72_defconfig
index c374024b0dd..853359c2911 100644
--- a/configs/j784s4_evm_a72_defconfig
+++ b/configs/j784s4_evm_a72_defconfig
@@ -152,6 +152,7 @@ CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
 CONFIG_RAM=y
 CONFIG_SPL_RAM=y
+CONFIG_REMOTEPROC=y
 CONFIG_RESET_TI_SCI=y
 CONFIG_DM_RTC=y
 CONFIG_RTC_EMULATION=y
diff --git a/configs/phycore_am68x_a72_defconfig
b/configs/phycore_am68x_a72_defconfig
index e74e604e1bc..bfabc7c2b0a 100644
--- a/configs/phycore_am68x_a72_defconfig
+++ b/configs/phycore_am68x_a72_defconfig
@@ -167,6 +167,7 @@ CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
 CONFIG_RAM=y
 CONFIG_SPL_RAM=y
+CONFIG_REMOTEPROC=y
 CONFIG_RESET_TI_SCI=y
 CONFIG_SCSI=y
 CONFIG_DM_SERIAL=y
