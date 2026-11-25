Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9475C606A323
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 16:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=uREFhTbs;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=fO+JeL/S
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DF59B40842;
	Wed, 25 Nov 2026 16:58:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XsK0iW2U4BL0; Wed, 25 Nov 2026 16:58:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B82F64081A
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795625926;
	b=cQiMBvLUE3+QpMmCoH7qTudrvl1l5ST2qUk89ushs5O5KLYklWaN1LiDzdcVJkENoQWx
	 ANgs6KmPHC1noLyRw5UiwOqUX1JSsZErP6aL1bP7S/VaVo5VwnI/89oio/Ve4ZkgG/mUC
	 8akseIliLnhWU+S+Jcj5Ut06YdsNG6UH8mOJcecHzV7ZVMpGJoPJaksGmxyJiOWYPTVVO
	 4k+iofv+xbEzwy0PD2aW75Mn1/nwZ8Dos8QyxrJssu80MBmaYnYIMq9VYBYg9xGqqKzzp
	 9LEIuXNP0cKI7CMwXOO3RA+35Slgv00DcbNVVzpPxR3ENALFtK97pIYi1jRUqccLAKw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795625926;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-Zoho-Virus-Status:
	 X-Zoho-AV-Stamp:X-ZohoMailClient:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=GjHE3BihO956ygdT9VR6AURuh8PpmV2SJIIZ6AuNPMQ=;
	b=D+Ltco7Q+WhO+uTu31onhO5n8ivf2/mZdQQ3CwbONaDPLIk7a798fgaCPkeoD32CQG3r
	 Ur4PSOK6Ald0DIAY3JkwVR5YDj/awc6ZOBKj2M5KuSdjRxUyScwDqcC0YalInsPESPQW+
	 5PBslNdU7LnV8UNfUfTahckxN9V7bEo5RnVUTQGFasNJTp3COXVjecHuU80av0uuozGEG
	 bB+ommJIhaFIgMUz/oCvNctRftT0O7DMDQa29JVnQ/AwQbv4ZfXunugQsITjVQI3Lg0vh
	 3UH+w4/fkxCzmdW38lFec6yjk9w7BRETaGfz6nHwM0f4srlikjF5219UHjtp/Aj+FFQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795625926;
	bh=GjHE3BihO956ygdT9VR6AURuh8PpmV2SJIIZ6AuNPMQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uREFhTbsvOdhtnPDI7u2KSXkvPX8QDtKoAkNIEG0+mStGd2HSv2SJo8v02PUcEsN8
	 7YMCnM1H1EBC7En2LG379oBDZ2mgo9c/hlSl2vX3H5dA/z6NaNbvifGh5BNQItlKEv
	 p8p0SJoTSOc6IZbL7ocbhb3o0sk0ouColf4LDEKrYrYTeS36SmdtC9RDR48Hq/pLm5
	 aIxAVJ34rb8qMVDIuAjvqf9S3mq/fz1pB+UZLBZIp8T4J94w1xwhjt7nAwontci2k/
	 gNIMZ4syj/Nob41kvNmWeEFeniNHakbDqrLld2JzVDBfja+7Lujnkl0ZQ14D+LdNFF
	 wRGORcIeibNZA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B82F64081A;
	Wed, 25 Nov 2026 16:58:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7978F1C9
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 16:58:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5C7C640116
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 16:58:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BwzILHbCwMNB for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 16:58:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 2BA5340111
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.15;
 helo=sender6-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=fO+JeL/S
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com
 [165.173.180.15])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2BA5340111
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 16:58:43 +0000 (UTC)
DKIM-Signature: a=rsa-sha256;
 b=fO+JeL/SkOrTk+Y6IMFM7kRmQqazDDp5Kjs56CK1NvU8aDF2qoWQIsjJuLZcVpWS/Z4VqYBnyZ4LTYno9yAJzYXULfY7kqSyOl++lWfwMWy+V2Vm7S9fBqLTFz3/hwDfGpIz/+QnxKAq7bR9/mA3kaqS4oGTVJf0TDI1c/2fDNk=;
 c=relaxed/relaxed; s=zmail; d=ziyao.cc; v=1;
 bh=GjHE3BihO956ygdT9VR6AURuh8PpmV2SJIIZ6AuNPMQ=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795625897393937.0350466573833;
 Wed, 25 Nov 2026 08:58:17 -0800 (PST)
Date: Wed, 25 Nov 2026 16:58:11 +0000
From: Yao Zi <me@ziyao.cc>
To: Anup Patel <anup@brainfault.org>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Cc: Yao Zi <me@ziyao.cc>, u-boot@lists.u-boot-project.org,
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>,
 Tom Rini <trini@konsulko.com>, E Shattow <e@freeshell.de>,
 Troy Mitchell <troy.mitchell@linux.spacemit.com>
Subject: Re: [PATCH v3] riscv: Disable M-IMSIC and M-APLIC nodes in DT passed
 to next stage in S mode
Message-ID: <awcToyC5PCkhpPnI@pie>
References: <20261119-mimsic_maplic_fixup-v3-1-e028e28fb958@oss.tenstorrent.com>
 <awAlGMMg-6tcb1N7@pie>
 <CAEev2e9SdqXvipxXGXFjLqe77RA=LsbGSY8AFnL9VbbYAC0ZJQ@mail.gmail.com>
 <awB-PvfuEDIu_t0l@pie>
 <CAEev2e-SFv-CLxBYZ6CfPPs__BggKc3AsH5PnhNF9uXo_FccXQ@mail.gmail.com>
 <CAAhSdy2faWHx401xHTKQm7xARJt9XiK_fHbzq7LOP_uY2MdnLQ@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhSdy2faWHx401xHTKQm7xARJt9XiK_fHbzq7LOP_uY2MdnLQ@mail.gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/295.600.19
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 25, 2026 at 08:47:40PM +0530, Anup Patel wrote:
> On Fri, Nov 20, 2026 at 10:54 PM Anirudh Srinivasan
> <asrinivasan@oss.tenstorrent.com> wrote:
> >
> > Hi Yao,
> >
> > +Anup to this thread
> >
> > On Fri, Nov 20, 2026 at 11:07 AM Yao Zi <me@ziyao.cc> wrote:
> > >
> > > On Fri, Nov 20, 2026 at 10:09:49AM -0600, Anirudh Srinivasan wrote:
> > > > Hi Yao,
> > > >
> > > > On Fri, Nov 20, 2026 at 4:47 AM Yao Zi <me@ziyao.cc> wrote:
> > > > >
> > > > > On Thu, Nov 19, 2026 at 09:47:07AM -0600, Anirudh Srinivasan wrote:
> > > > > > When U-Boot is running in S mode, the DT passed to the next S mode stage
> > > > > > can either be the bundled in DT U-Boot and the previous M mode stage
> > > > > > use, or be loaded by U-Boot from some boot media. In the former case,
> > > > > > the M mode stage can fix up the DT to disable the M-IMSIC and M-APLIC
> > > > > > nodes on an AIA system (for example, OpenSBI does this fixup). These
> > > > > > controllers are to be managed by M-mode software, so this is done to
> > > > > > prevent S mode software from trying to probe them.
> > > > > >
> > > > > > This fixup doesn't happen in the latter case because U-Boot loads a
> > > > > > fresh DT from boot media. Add a fdt fixup to do this similar to OpenSBI.
> > > > > > This gets rid of prints like this during linux boots.
> > > > > >
> > > > > > [    0.000000] riscv-imsic: interrupt-controller@a0000000: no parent irqs available
> > > > > > [    0.000000] riscv-imsic: interrupt-controller@a0000000: failed to setup state (error -22)
> > > > > > [    0.000000] OF: of_irq_init: Failed to init /soc/interrupt-controller@a0000000 ((____ptrval____)), parent (____ptrval____)
> > > > > >
> > > > > > [   10.727605] platform cc000000.interrupt-controller: deferred probe pending: platform: supplier a0000000.interrupt-controller not ready
> > > > > >
> > > > > > Reviewed-by: E Shattow <e@freeshell.de>
> > > > > > Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
> > > > > > ---
> > > > > > Changes in v3:
> > > > > > - Reword commit title to say M-APLIC/M-IMSIC and drop references to M Mode to avoid any confusion
> > > > > > - Link to v2: https://patch.msgid.link/20261119-mimsic_maplic_fixup-v2-1-e29e04bf1b76@oss.tenstorrent.com
> > > > > >
> > > > > > Changes in v2:
> > > > > > - Rename riscv_aia_mmode_aplic_imsic_fixup to riscv_aia_mimsic_maplic_fixup
> > > > > > - Drop most references to OpenSBI/Linux in commit message and just use M-mode/s-mode software
> > > > > > - Link to v1: https://patch.msgid.link/20261118-mimsic_maplic_fixup-v1-1-52dea8f39779@oss.tenstorrent.com
> > > > > > ---
> > > > > >  arch/riscv/lib/fdt_fixup.c | 86 ++++++++++++++++++++++++++++++++++++++++++++++
> > > > > >  1 file changed, 86 insertions(+)
> > >
> > > ...
> > >
> > > > > > + * riscv_aia_mimsic_maplic_fixup() - Disable M-APLIC and M-IMSIC nodes in DT
> > > > > > + * @fdt: Pointer to the device tree in which nodes are to be disabled
> > > > > > + *
> > > > > > + * On RISC-V AIA systems, M-mode software manages the M-APLIC and M-IMSIC.
> > > > > > + * If S-mode U-Boot loads a device tree from boot media, the DT nodes for these
> > > > > > + * could still be enabled, so fixup the DT to disable these nodes before passing
> > > > > > + * it to the next S-mode stage.
> > > > > > + *
> > > > > > + * Return: 0 on success or error otherwise.
> > > > > > + */
> > > > > > +static int riscv_aia_mimsic_maplic_fixup(void *fdt)
> > > > > > +{
> > > > > > +     int offset, err;
> > > > > > +
> > > > > > +     /* Disable M-IMSIC in APLIC-IMSIC configuration */
> > > > > > +     fdt_for_each_node_by_compatible(offset, fdt, -1, "riscv,imsics") {
> > > > > > +             if (riscv_node_handles_mmode_external_interrupts(fdt, offset)) {
> > > > > > +                     err = fdt_status_disabled(fdt, offset);
> > > > >
> > > > > Should we use "reserved" instead of "disabled"? Quoting the devicetree
> > > > > specification,
> > > > >
> > > > > > "disabled"
> > > > > >       Indicates that the device is not presently operational, but it
> > > > > >       might become operational in the future (for example, something
> > > > > >       is not plugged in, or switched off).
> > > > > >
> > > > > > "reserved"
> > > > > >       Indicates that the device is operational, but should not be
> > > > > >       used. Typically this is used for devices that are controlled by
> > > > > >       another software component, such as platform firmware.
> > > > >
> > > > > Another possible problem is that these loops overrides the status
> > > > > unconditionally, turning already "reserved" devices into "disabled".
> > > >
> > > > I don't think we should be using reserved here. OpenSBI sets the node
> > > > to disabled, so we should be doing the same thing.
> > > >
> > > > I'll add a check to see if the node is enabled and disable it only then.
> > >
> > > I think this is probably an OpenSBI defect, please try raising this to
> > > OpenSBI upstream.
> >
> > Hello Anup, I've added you to this thread as you had added the code to
> > OpenSBI that marks M-APLIC and M-IMSIC nodes as disabled. This current
> > patch does the same for a DT that U-boot loads from boot media (hence
> > is missing the fixup OpenSBI does) and passes to linux.
> >
> > Do think these nodes should be marked as "reserved" instead? It seems
> > that "reserved" is to be used for devices controlled by different a sw
> > component, which seems to line up with what's happening here.
> 
> The next stage after OpenSBI is S-mode so that's why OpenSBI disables
> M-APLIC and M-IMSIC DT nodes because S-mode access to these
> devices is blocked (or disabled). For DRAM where OpenSBI runs, the
> situation is different because typically we have on DT node for covering
> all DRAM banks so disabling this DT node does not make sense. Due
> to this, OpenSBI marks portion of DRAM as reserved where OpenSBI
> runs from.
> 
> To summarize:
> 1) Disable the DT nodes of devices which are not accessible in S-mode
> 2) Reserve the portion of DRAM which is not accessible in S-mode

I think you might misunderstand the things which we're talking about.
"Marked as reserved" here means change values of their status property
to "reserved", which has nothing to do with reserved-memory nodes.

"reserved" is defined to be a possible choice of status property in the
devicetree specification[1], and represents

> > > > > > "reserved"
> > > > > >       Indicates that the device is operational, but should not be
> > > > > >       used. Typically this is used for devices that are controlled by
> > > > > >       another software component, such as platform firmware.

> Regards,
> Anup
> 
> Regards,
> Anup

-- 
Thanks,
Yao Zi

Meow-mrrp-mrow, I'm a cat.

[1]: Page 14 of https://github.com/devicetree-org/devicetree-specification/releases/download/v0.4/devicetree-specification-v0.4.pdf
