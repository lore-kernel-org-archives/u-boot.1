Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E6D8F417E7
	for <u-boot@archiver.kernel.org>; Mon,  9 Mar 2026 14:38:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85C3483F8A;
	Mon,  9 Mar 2026 15:38:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79DA983952; Mon,  9 Mar 2026 15:38:17 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 81E2183952
 for <u-boot@lists.denx.de>; Mon,  9 Mar 2026 15:38:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vincent.stehle@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5AF111570;
 Mon,  9 Mar 2026 07:38:08 -0700 (PDT)
Received: from debian (X72Y076X74-2.nice.arm.com [10.34.125.13])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AB6EC3F7BD;
 Mon,  9 Mar 2026 07:38:13 -0700 (PDT)
Date: Mon, 9 Mar 2026 15:38:10 +0100
From: Vincent =?utf-8?Q?Stehl=C3=A9?= <vincent.stehle@arm.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/4] lib: uuid: add EBBR 2.1 conformance profile GUID
Message-ID: <aa7bUobdKM7AOd_h@debian>
Mail-Followup-To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20260305161349.2317130-1-vincent.stehle@arm.com>
 <20260305161349.2317130-2-vincent.stehle@arm.com>
 <3d35df48-0669-4c0c-a770-86bfa6b65d79@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3d35df48-0669-4c0c-a770-86bfa6b65d79@gmx.de>
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

On Mon, Mar 09, 2026 at 01:19:32PM +0100, Heinrich Schuchardt wrote:

Hi Heinrich,

Thanks for your review; I will modify as per your suggestion and send a v2.

Best regards,
Vincent.

> On 3/5/26 17:13, Vincent Stehlé wrote:
> > Add support for printing the EFI_CONFORMANCE_PROFILE_EBBR_2_1_GUID as human
> > readable text.
> > 
> > This is added in the GUIDs range, which is compiled in only when
> > CONFIG_CMD_EFIDEBUG is set.
> > 
> > Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
> > Cc: Tom Rini <trini@konsulko.com>
> > ---
> >   lib/uuid.c | 4 ++++
> >   1 file changed, 4 insertions(+)
> > 
> > diff --git a/lib/uuid.c b/lib/uuid.c
> > index 0a166320e07..d9d5414d4bf 100644
> > --- a/lib/uuid.c
> > +++ b/lib/uuid.c
> > @@ -254,6 +254,10 @@ static const struct {
> >   		NULL, "EFI Conformance Profiles Table",
> >   		EFI_CONFORMANCE_PROFILES_TABLE_GUID,
> >   	},
> 
> Some boards have tight binary size restrictions.
> 
> If CONFIG_EFI_ECPT=n, we don't need the GUID text. I would suggest to hide
> it behind an #ifdef.
> 
> Best regards
> 
> Heinrich
> 
> > +	{
> > +		NULL, "EFI EBBR 2.1 Conformance Profile",
> > +		EFI_CONFORMANCE_PROFILE_EBBR_2_1_GUID,
> > +	},
> >   #ifdef CONFIG_EFI_RISCV_BOOT_PROTOCOL
> >   	{
> >   		NULL, "RISC-V Boot",
> 
