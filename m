Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B8ADEB8FD2
	for <u-boot@archiver.kernel.org>; Wed,  6 Sep 2023 14:21:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB14B86546;
	Wed,  6 Sep 2023 16:21:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gc/RZfjO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B6E88643D; Wed,  6 Sep 2023 16:21:45 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF4D3865A2
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 16:21:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=BIxy=EW=robh_at_kernel.org=rob@kernel.org
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 455D9B81AD2;
 Wed,  6 Sep 2023 14:21:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46689C433C8;
 Wed,  6 Sep 2023 14:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1694010101;
 bh=QbAd/TQ8WCHZRFkkxQMRVcDckFRyvm+rJV5QkeUeW8A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gc/RZfjOd1UDlSN6a8sVoaPlTbE+9NRr2Dc7fpKD2yECCxZxB1Z7O/pirs3Jwpqu6
 FJv3bXDzpt7T3++1iXHMh82jIfS+G3bNLJ1cbcd2MlE37mgKxoLyyPkK1pZna6a2U3
 f2wYup5Wfq93lX3KsJt5+i9jIzT9aW8efb7088tByfU7hpZ6AxNbsltY3dd/NUUWXQ
 2l8fPIsN2YjrOrTJjyWoOny9aRGgWgu8m3500un4hxS5vSz7zbwfGp55sJis/hxfcP
 NJdatDKEdVqZAcpU7dxxIL7KOGTAJeXld3LVzz0aChTvbo1ySSJ+q6zuC6kPErMmEz
 /sPMMv/1DHFhQ==
Received: (nullmailer pid 1275640 invoked by uid 1000);
 Wed, 06 Sep 2023 14:21:39 -0000
Date: Wed, 6 Sep 2023 09:21:39 -0500
From: Rob Herring <robh@kernel.org>
To: Simon Glass <sjg@chromium.org>
Cc: Peter Robinson <pbrobinson@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [RFC PATCH 0/5] Allow for removal of DT nodes and properties
Message-ID: <20230906142139.GA1236014-robh@kernel.org>
References: <20230826090633.239342-1-sughosh.ganu@linaro.org>
 <CAPnjgZ3HVJ9+-PjmHSKwQRgCMkcNPWAcfMkk5SMMgiHAcY0SsQ@mail.gmail.com>
 <CALeDE9MMiA9HVfbeOV3tGqfAAC9oYf9qvizBW0T=hLmqcYD=qw@mail.gmail.com>
 <CAPnjgZ1pgvxhntJvkuAsxKXUVxcWACNTpuDqgonFCrOLr=934Q@mail.gmail.com>
 <CALeDE9ODEwV0Z9APwb1N8QNZFQSB1dkMTMHPW2p2xTLiUZjQ1A@mail.gmail.com>
 <CAPnjgZ1FiqjjxjL+Ve-s5WEafksOZsSP3XyW4xYdjyP-U_TZzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPnjgZ1FiqjjxjL+Ve-s5WEafksOZsSP3XyW4xYdjyP-U_TZzQ@mail.gmail.com>
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On Mon, Aug 28, 2023 at 04:09:29PM -0600, Simon Glass wrote:
> Hi Peter,
> 
> On Mon, 28 Aug 2023 at 14:29, Peter Robinson <pbrobinson@gmail.com> wrote:
> >
> > On Mon, Aug 28, 2023 at 6:54 PM Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Peter,
> > >
> > > On Mon, 28 Aug 2023 at 10:37, Peter Robinson <pbrobinson@gmail.com> wrote:
> > > >
> > > > On Mon, Aug 28, 2023 at 5:20 PM Simon Glass <sjg@chromium.org> wrote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > On Sat, 26 Aug 2023 at 03:07, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > > > > >
> > > > > >
> > > > > > Provide a way for removing certain devicetree nodes and/or properties
> > > > > > from the devicetree. This is needed to purge certain nodes and
> > > > > > properties which may be relevant only in U-Boot. Such nodes and
> > > > > > properties are then removed from the devicetree before it is passed to
> > > > > > the kernel. This ensures that the devicetree passed to the OS does not
> > > > > > contain any non-compliant nodes and properties.
> > > > > >
> > > > > > The removal of the nodes and properties is being done through an
> > > > > > EVT_FT_FIXUP handler. I am not sure if the removal code needs to be
> > > > > > behind any Kconfig symbol.
> > > > > >
> > > > > > I have only build tested this on sandbox, and tested on qemu arm64
> > > > > > virt platform. This being a RFC, I have not put this through a CI run.
> > > > > >
> > > > > > Sughosh Ganu (5):
> > > > > >   dt: Provide a way to remove non-compliant nodes and properties
> > > > > >   fwu: Add the fwu-mdata node for removal from devicetree
> > > > > >   capsule: Add the capsule-key property for removal from devicetree
> > > > > >   bootefi: Call the EVT_FT_FIXUP event handler
> > > > > >   doc: Add a document for non-compliant DT node/property removal
> > > > > >
> > > > > >  cmd/bootefi.c                                 | 18 +++++
> > > > > >  .../devicetree/dt_non_compliant_purge.rst     | 64 ++++++++++++++++
> > > > > >  drivers/fwu-mdata/fwu-mdata-uclass.c          |  5 ++
> > > > > >  include/dt-structs.h                          | 11 +++
> > > > > >  lib/Makefile                                  |  1 +
> > > > > >  lib/dt_purge.c                                | 73 +++++++++++++++++++
> > > > > >  lib/efi_loader/efi_capsule.c                  |  7 ++
> > > > > >  7 files changed, 179 insertions(+)
> > > > > >  create mode 100644 doc/develop/devicetree/dt_non_compliant_purge.rst
> > > > > >  create mode 100644 lib/dt_purge.c
> > > > >
> > > > > What is the point of removing them? Instead, we should make sure that
> > > > > we upstream the bindings and encourage SoC vendors to sync them. If we
> > > > > remove them, no one will bother and U-Boot just becomes a dumping
> > > > > ground.
> > > >
> > > > Well things like the binman entries in DT are U-Boot specific and not
> > > > useful for HW related descriptions or for Linux or another OS being
> > > > able to deal with HW so arguably we're already a dumping ground to
> > > > some degree for not defining hardware.
> > >
> > > I have started the process to upstream the binman bindings.
> >
> > I don't think they should be in DT at all, they don't describe
> > anything to do with hardware, or generally even the runtime of a
> > device, they don't even describe the boot/runtime state of the
> > firmware, they describe build time, so I don't see what that has to do
> > with device tree? Can you explain that? To me those sorts of things
> > should live in a build time style config file.

For the record, I tend to agree.

> I beg to differ. Devicetree is more than just hardware and always has
> been. See, for example the /chosen and /options nodes.

There are exceptions...

> We need run-time configuration here, since we cannot know at build
> time what we will be asked to do by a previous firmware phase.

Really, I don't want to have to care about the binman binding. If it is 
u-boot specific, then it should stay in u-boot. I took /options/u-boot/, 
but now I'm starting to have second thoughts on that being in dtschema 
if it is going to be continually and frequently extended. Validating it 
in SR does little. If a vendor is abusing /options/u-boot/ in some way 
they could just as easily remove the node in their u-boot fork to pass. 
SR is certainly not going to require the node be there.

On A/B updates, that really doesn't seem like a u-boot specific problem 
to me. No one wants A/B updates in EDK2 or anything else?

Rob
