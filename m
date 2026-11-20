Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C234E606A331
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 17:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=VQxvCdw6;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=Ww0d2Rz6
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 168E340E6F;
	Fri, 20 Nov 2026 17:07:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0dz9HdplSpEj; Fri, 20 Nov 2026 17:07:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org EF71940E41
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795194466;
	b=UX/QhveCNuXvPbkhCO4mVm7pihfHBFfZaKn6+gMDAA/wDIXVGv9ZEHtublgl2kek+wYe
	 uw00ofcZBLbEYa/1RxAv8bkcRPm+OOhIVfwSBySpHn/RkCSTQnYyDE6tu2q1nODwd5wwy
	 2BySNJxb+u6BgUXhZkH3XS2FXMB+ffoi7xzbltBZPNCerRK2L3o+f1A4FAE2aI8YeMNA0
	 XPQVPsk9VavpOqT7H00t9n/je7EfLj2l7w6xYOEwOQSAvsM8thoMTGoGz0A79linfYS1Q
	 IqAQTJOA3+clzXDEEqdXAPrDVoQhO6icKjoCKjiDf3X2pPWwLfmQWCi8ksS+p5pdk5Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795194466;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-Zoho-Virus-Status:
	 X-Zoho-AV-Stamp:X-ZohoMailClient:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=0aP5e9lafbQQaiijzo3qi2MXCfpw+NjrhN5ylNPyzvM=;
	b=HYg9DfMiKizv2GJfaYUUGZXidAB0YSAGWGqYGL/CLqDqvniLodWudu9caEkc2Hxt5T+z
	 vbzoKfsxzdbATR1/XhVIYVZ7X3PbuTZwNOycdf/5/O/JUL/4v22tUJ36IXSsIexwf14M7
	 slZAW0C+1j+InmDyaO2yaWShWscPGvvs3wqZrIoCSO71kITmb8MGGE3y45me0fFj96LYe
	 V/98tgCT5rhFwJXxWRvWUQStlcxsesZrrS9Ng56ngGPjS41dQuRJDt+MQOq0Ml5fwBwFl
	 8OImX2ZkYcWqSqxjtABGD55GgGlQWw6+8qP8FeMsGMrurfJmXlzhfjVE5Yt4skakNQQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=ziyao.cc;
	dkim=pass header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=Ww0d2Rz6;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795194466;
	bh=0aP5e9lafbQQaiijzo3qi2MXCfpw+NjrhN5ylNPyzvM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VQxvCdw6pbyqvX24OcrQ3ThnjjCLfZFWkNVfQzgZlBUF1Ko34I4UeziaDxEyQWaG6
	 RUCRjioRxRBtU/Wk8bRtwZSPA3nPZr6CMBaRHpJzdPX6AKoqgkUsvrg8F77JDxCshU
	 +L9Y8EP6pFBwjZkpTjdQr9QeWHHD69jCANBYrmK0j2bgRrhkmbYdOqvmlNoXVWn6wW
	 WeWGjfEXsBbPESTdn1Vz4lzahneM/5Z9lSOP8Jso8kGdrdqCaAljgKBSPZrjJLLJhn
	 ou3tmM3zVJqbE3Xx0Bo0OoI768C5KZEKfSTCYl66f/FKW8N16Ga9p3//8To/BwFoXN
	 5hsZkbC1pN9/g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EF71940E41;
	Fri, 20 Nov 2026 17:07:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id D3661E22
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 17:07:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C4CB840E41
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 17:07:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bIBUACU38Uxa for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 17:07:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 74DE740E3D
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.15;
 helo=sender6-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=Ww0d2Rz6
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com
 [165.173.180.15])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 74DE740E3D
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 17:07:42 +0000 (UTC)
DKIM-Signature: a=rsa-sha256;
 b=Ww0d2Rz6n4rd175vdls/CTEyjMQUB2FBpbVglT3MPc2pehJixvHMAiuPaVGD9dubRTPrFR182K/DypBHGf8Cprm9VE4DYKGYqLUZSNxNnAZ3N7yeBl06Z3RkrpL30RxhzIYdVBrzeJbCOVBrOgilMu57ks/povyXQvwu/jsK7s0=;
 c=relaxed/relaxed; s=zmail; d=ziyao.cc; v=1;
 bh=0aP5e9lafbQQaiijzo3qi2MXCfpw+NjrhN5ylNPyzvM=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795194436433185.1379058585718;
 Fri, 20 Nov 2026 09:07:16 -0800 (PST)
Date: Fri, 20 Nov 2026 17:07:10 +0000
From: Yao Zi <me@ziyao.cc>
To: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, Yao Zi <me@ziyao.cc>
Cc: u-boot@lists.u-boot-project.org, Tim Ouyang <tim609@andestech.com>,
 Leo Liang <leo.liang@sifive.com>, Tom Rini <trini@konsulko.com>,
 E Shattow <e@freeshell.de>,
 Troy Mitchell <troy.mitchell@linux.spacemit.com>
Subject: Re: [PATCH v3] riscv: Disable M-IMSIC and M-APLIC nodes in DT passed
 to next stage in S mode
Message-ID: <awB-PvfuEDIu_t0l@pie>
References: <20261119-mimsic_maplic_fixup-v3-1-e028e28fb958@oss.tenstorrent.com>
 <awAlGMMg-6tcb1N7@pie>
 <CAEev2e9SdqXvipxXGXFjLqe77RA=LsbGSY8AFnL9VbbYAC0ZJQ@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEev2e9SdqXvipxXGXFjLqe77RA=LsbGSY8AFnL9VbbYAC0ZJQ@mail.gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/295.181.54
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 20, 2026 at 10:09:49AM -0600, Anirudh Srinivasan wrote:
> Hi Yao,
> 
> On Fri, Nov 20, 2026 at 4:47 AM Yao Zi <me@ziyao.cc> wrote:
> >
> > On Thu, Nov 19, 2026 at 09:47:07AM -0600, Anirudh Srinivasan wrote:
> > > When U-Boot is running in S mode, the DT passed to the next S mode stage
> > > can either be the bundled in DT U-Boot and the previous M mode stage
> > > use, or be loaded by U-Boot from some boot media. In the former case,
> > > the M mode stage can fix up the DT to disable the M-IMSIC and M-APLIC
> > > nodes on an AIA system (for example, OpenSBI does this fixup). These
> > > controllers are to be managed by M-mode software, so this is done to
> > > prevent S mode software from trying to probe them.
> > >
> > > This fixup doesn't happen in the latter case because U-Boot loads a
> > > fresh DT from boot media. Add a fdt fixup to do this similar to OpenSBI.
> > > This gets rid of prints like this during linux boots.
> > >
> > > [    0.000000] riscv-imsic: interrupt-controller@a0000000: no parent irqs available
> > > [    0.000000] riscv-imsic: interrupt-controller@a0000000: failed to setup state (error -22)
> > > [    0.000000] OF: of_irq_init: Failed to init /soc/interrupt-controller@a0000000 ((____ptrval____)), parent (____ptrval____)
> > >
> > > [   10.727605] platform cc000000.interrupt-controller: deferred probe pending: platform: supplier a0000000.interrupt-controller not ready
> > >
> > > Reviewed-by: E Shattow <e@freeshell.de>
> > > Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
> > > ---
> > > Changes in v3:
> > > - Reword commit title to say M-APLIC/M-IMSIC and drop references to M Mode to avoid any confusion
> > > - Link to v2: https://patch.msgid.link/20261119-mimsic_maplic_fixup-v2-1-e29e04bf1b76@oss.tenstorrent.com
> > >
> > > Changes in v2:
> > > - Rename riscv_aia_mmode_aplic_imsic_fixup to riscv_aia_mimsic_maplic_fixup
> > > - Drop most references to OpenSBI/Linux in commit message and just use M-mode/s-mode software
> > > - Link to v1: https://patch.msgid.link/20261118-mimsic_maplic_fixup-v1-1-52dea8f39779@oss.tenstorrent.com
> > > ---
> > >  arch/riscv/lib/fdt_fixup.c | 86 ++++++++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 86 insertions(+)

...

> > > + * riscv_aia_mimsic_maplic_fixup() - Disable M-APLIC and M-IMSIC nodes in DT
> > > + * @fdt: Pointer to the device tree in which nodes are to be disabled
> > > + *
> > > + * On RISC-V AIA systems, M-mode software manages the M-APLIC and M-IMSIC.
> > > + * If S-mode U-Boot loads a device tree from boot media, the DT nodes for these
> > > + * could still be enabled, so fixup the DT to disable these nodes before passing
> > > + * it to the next S-mode stage.
> > > + *
> > > + * Return: 0 on success or error otherwise.
> > > + */
> > > +static int riscv_aia_mimsic_maplic_fixup(void *fdt)
> > > +{
> > > +     int offset, err;
> > > +
> > > +     /* Disable M-IMSIC in APLIC-IMSIC configuration */
> > > +     fdt_for_each_node_by_compatible(offset, fdt, -1, "riscv,imsics") {
> > > +             if (riscv_node_handles_mmode_external_interrupts(fdt, offset)) {
> > > +                     err = fdt_status_disabled(fdt, offset);
> >
> > Should we use "reserved" instead of "disabled"? Quoting the devicetree
> > specification,
> >
> > > "disabled"
> > >       Indicates that the device is not presently operational, but it
> > >       might become operational in the future (for example, something
> > >       is not plugged in, or switched off).
> > >
> > > "reserved"
> > >       Indicates that the device is operational, but should not be
> > >       used. Typically this is used for devices that are controlled by
> > >       another software component, such as platform firmware.
> >
> > Another possible problem is that these loops overrides the status
> > unconditionally, turning already "reserved" devices into "disabled".
> 
> I don't think we should be using reserved here. OpenSBI sets the node
> to disabled, so we should be doing the same thing.
> 
> I'll add a check to see if the node is enabled and disable it only then.

I think this is probably an OpenSBI defect, please try raising this to
OpenSBI upstream.

[...]

> Thanks for your comments. I'll address the style issues.
> 
> >
> > --
> > Thanks,
> > Yao Zi
> >
> > Meow-mrrp-mrow, I'm a cat.

-- 
Thanks,
Yao Zi

Meow-mrrp-mrow, I'm a cat.
