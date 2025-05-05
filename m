Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 961E9C3ABB0
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 09:31:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED92B81F7B;
	Mon,  5 May 2025 11:31:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VmqrqN31";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC48881F7B; Mon,  5 May 2025 11:31:36 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D05581FAB
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 11:31:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id E3A3E43ADE;
 Mon,  5 May 2025 09:31:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06DCAC4CEE4;
 Mon,  5 May 2025 09:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1746437492;
 bh=7Zd55tdOoi0M5qtJPcKvEU7lePWnMTp7fYgFX2M6ST0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=VmqrqN31OSguVnv16vv7fqr81GIfDwwgpMMfCCHGJaGblTuSyDZuU32+XIYn7AEfu
 vJBNjrgSU/FskX7EHQ6dEtfUhalXiKBWa3XdaB/TkhwRpCkifAaFPcJ7567RkYZw96
 4pBUmYjGjSDdojp+cw5D9Ee2+bCOp2D7Tn/Xg6xQWEwv6uhHm22wcpIKTJ0iE0KBp3
 HkqmBei+LCCpek3YGvIVSyZWL5NqmXeSYj5RcbVWaRMKmquCrrzknPTDEd3nqUdvZk
 op2crbTdF5V1OLzY0Qn9AXI4mLq3swaqW8TXLo3bJ3o2R/qnx4dsgY1VokKb+5GA5H
 SRTeaZ3UoB5wg==
Date: Mon, 5 May 2025 15:01:25 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: neil.armstrong@linaro.org
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, trini@konsulko.com,
 casey.connolly@linaro.org, loic.minier@oss.qualcomm.com,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: Re: [PATCH] mach-snapdragon: Update fdtfile logic to work for RB1
 and RB2
Message-ID: <aBiFbRyGffUus86w@sumit-X1>
References: <20250423051132.292329-1-sumit.garg@kernel.org>
 <183C90A92BBF63A5.32718@groups.io>
 <0469bb8b-042d-4c6f-974d-6d1879262e91@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0469bb8b-042d-4c6f-974d-6d1879262e91@linaro.org>
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

On Mon, May 05, 2025 at 09:26:09AM +0200, neil.armstrong@linaro.org wrote:
> On 05/05/2025 09:23, Neil Armstrong via groups.io wrote:
> > Hi,
> > 
> > On 23/04/2025 07:11, Sumit Garg wrote:
> > > From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > > 
> > > RB1 and RB2 have three root compatibles where the last one can't be used
> > > to decode fdtfile name (qcm* vs qrb*). So rather just rely on the first
> > > compatible to retrieve the SoC name.
> > 
> > OK, so "soc" would be qcm2290 instead of qrb2210, what's the problem since
> > you have "board" with "qrb2210-rb1" ?
> > 
> > What is the difference between qcm2290 & qrb2210 that affects U-boot ?
> > 
> > Same for qrb4210 vs sm4250.
> > 
> > If you have a custom board code, you can still match on the root compatible.
> 
> Forget my comment, it affects the fdtfile construction....
> 
> > 
> > Neil
> > 
> > > 
> > > Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > > ---
> > >   arch/arm/mach-snapdragon/board.c | 12 ++++++++++--
> > >   1 file changed, 10 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
> > > index deae4d32378..dc8220e89b4 100644
> > > --- a/arch/arm/mach-snapdragon/board.c
> > > +++ b/arch/arm/mach-snapdragon/board.c
> > > @@ -437,16 +437,24 @@ static void configure_env(void)
> > >       /* The Qualcomm reference boards (RBx, HDK, etc)  */
> > >       if (!strncmp("qcom", buf, strlen("qcom"))) {
> > > +        char *soc;
> > > +
> > >           /*
> > >            * They all have the first compatible as "qcom,<soc>-<board>"
> > >            * (e.g. "qcom,qrb5165-rb5"). We extract just the part after
> > >            * the dash.
> > >            */
> > > -        if (!strsep(&tmp, "-")) {
> > > +        if (!strsep(&tmp, ",")) {
> > > +            log_warning("compatible '%s' has no ','\n", buf);
> > > +            return;
> > > +        }
> > > +        soc = strsep(&tmp, "-");
> > > +        if (!soc) {
> > >               log_warning("compatible '%s' has no '-'\n", buf);
> > >               return;
> > >           }
> > > -        /* tmp is now "rb5" */
> > > +
> > > +        env_set("soc", soc);
> 
> OK, so you should move the other env_set("soc", ...) code in the other else branch
> to avoid having a double env_set("soc", ...)

Sure, I can do that in v2.

-Sumit

> 
> > >           env_set("board", tmp);
> > >       } else {
> > >           if (!strsep(&tmp, ",")) {
> > 
> > 
> > 
> > -=-=-=-=-=-=-=-=-=-=-=-
> > Groups.io Links: You receive all messages sent to this group.
> > View/Reply Online (#1677): https://groups.io/g/u-boot-qcom/message/1677
> > Mute This Topic: https://groups.io/mt/112410772/900740
> > Group Owner: u-boot-qcom+owner@groups.io
> > Unsubscribe: https://groups.io/g/u-boot-qcom/leave/13197875/900740/1403832380/xyzzy [neil.armstrong@linaro.org]
> > -=-=-=-=-=-=-=-=-=-=-=-
> > 
> > 
> 
