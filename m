Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DA5606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 18:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=jmxg4L2M;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=zmv+JiUX
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BB47180EFF;
	Mon, 26 Oct 2026 18:21:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ehusWHMXtUM0; Mon, 26 Oct 2026 18:21:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8B9B180DB1
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793038879;
	b=XxieW3MXOZ4ymzG+vrIU3j6Xp+IaIlah+3QMZtUD7seh36T+aq63Gp3VOdOXfjx3GVmS
	 V9Wdiu+IirtXODdI0TCifVOi8iYfzL/WPkUsE/S299FXcIe+sv1m1qEXhTi45i4Yax+x/
	 fx5Vt2NzIJ6pDpNZ8zx+E+d9JAhXK7fVQ4yauTtUe78GsWrDD3ikjgUU/dwAMrAgZtMwQ
	 EsbItYHh6utMKfKf5Fxh71sr9WXdjqXEpmKTVhdxlbKbD+xQbaNQOPyrQwn4WGxA/0SzT
	 ql90+sNmqiK6W7WTjiDtw3sz66EBLr4eJsU0tZ7nq2VLakafVYWA8jcgLslm2+HSpCw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793038879;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-Amp-Result:Received:Received:Received:Date:From:To:CC:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Dpc1VB301/t1jLcXXGkquRoEXgFbeHPHr3g00A/VOSU=;
	b=YSj3z1rPPTENQd03E5dmOck2Ao34xAaLbThWObH199Hlr3Il6ocWiuv4zI1+iEJ07Asd
	 eQXanBaidqYDCDnxmPT4syC8IcunBXBWOcmts66sBO0bGMSrPX2e/8q/yBNavlE9Mcvhd
	 SfBOU0L/Laeq+oznZIf8Y1MAIT+Qd7mhEpN3hDt4AE6aR2B7QhJRmdTIRl+qp/6+85iD3
	 EIlGEuk53cw+fCPQPrnF+gzO4wbILxb+gHndaRBq6CbDKPY/MrzzQkadfS0RYUDEFG29D
	 HWZnt3M8cbyi6FvSyYhJNSHCgaVUvcDBHIuD4yykcYVD23VYxVaa/7ZsMteHmYm3JuA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793038879;
	bh=Dpc1VB301/t1jLcXXGkquRoEXgFbeHPHr3g00A/VOSU=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jmxg4L2M+wDJ28LA0IsNDV48+2IxZQHnrKW7/FBsLdMXnLsNyGfZuwspjpmsO3zyx
	 VDyZ3uOqCmYirWA0IxSomACovp7WZGLpzyVkWKVbLcGzmWaml540spOzukSIOadz1F
	 AEZMWxTIkHjbGDyfI4O6NJm6gOOWQjmQEe+xVxdpqMGNwOfA9d2Wp6x+wMgNvRWgQF
	 Cocayfjz6Mq4Si0BIKzF+yBxWqlr48wrdVOdP1C9N6SU11AM0dgEQqfCVqs87sBIfI
	 M2KaJtOIleZ13f6nkgVqOMPcDxSLx45baErMqKRQFFS7LF90N+Tjm0WYB8a5v6jZxH
	 z0EaQcwQxeY4g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8B9B180DB1;
	Mon, 26 Oct 2026 18:21:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7A83E2AC
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 18:21:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5FC1360607
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 18:21:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W4ZWHHN10beY for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 18:21:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2CF3660603
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=68.232.153.233
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793038877;
 b=eN+LhbeJl3MO+YUWS1nxBr4FnMVBOOZvSyBOhJabIK3y3BfNcjbmCD3EzyOAsEGo52sF
 CI4hwBlT/d7N4nzJAqZeQtIxfIPL32O7tnxQ3Wn8TUmMxHcr+036a70mYL4L32mS1s0sh
 zbx88sViID9GrucGMwGahd3okJa7bOZcL8NX/AWTpdiiGo2eXiJNP6fPxjszcKJzsrLMw
 H6RFrH6d4/HTKkOewdAO4t3ERYPwEW8n7GYBPbCmHIZp0+LjA4rJSmKFiyXdpWvOs0O81
 oe7hvDxSoehjhCtHofUOSXGofOxxbHSRMwNkrEeJpGYb4YB5QxgdQwsaCyCTDET5XGg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793038877;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-Amp-Result:Received:Received:Received:Date:From:To:CC:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
 bh=Dpc1VB301/t1jLcXXGkquRoEXgFbeHPHr3g00A/VOSU=;
 b=GmAerw3UEiwzi+ajnv+z6kN4DxHlDx74G0/RpckGEsC9gQamVIAQPK1KD+UoMw1o+CKN
 TC+0oN8R3kxUpgMsxvqdDtVtQN6r54k67BvMXeR0ubwb7rInGybTMV8bg+TPhs0j8ZAGq
 40nh46h38kOrQq3Yyp/lhGVpjOzYugpw1fOs/qVPhgkas7+QEiXDMdvKCy5wkvYPkofrP
 OPWX+6GNHPzqyO9pD/P9G/BWEX80J14PTbtOIhBJwy2sv+ZhI8A5xZhbC9+nLn1ZfAFFn
 Os2dAnCt07e4aPvrVYiSbYl1dkbkxoEY0qqZfv+sRYeFD+1Lt5vmLI44S7OlYxP1HBA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=microchip.com;
 dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256
 header.s=mchp header.b=zmv+JiUX; 
 arc=none smtp.remote-ip=68.232.153.233
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=68.232.153.233;
 helo=esa.microchip.iphmx.com;
 envelope-from=prvs=752c32f41=charles.perry@microchip.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=microchip.com header.i=@microchip.com
 header.a=rsa-sha256 header.s=mchp header.b=zmv+JiUX
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2CF3660603
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 18:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1793038883; x=1824574883;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=XwjRHSUlQaKgaOmDzh3QAo+kUhV67a3qUnces54K0rk=;
 b=zmv+JiUXvOaScSZPeyKk79z7wMEXCrHVfrWcIp4JpbLWzwj4Tdcx3Ufr
 x55smqljoebmXWBA5y8Go6rJfEbNLVxPY9IpxwVL/W5XtK8DGhQzgKW6l
 9FrcWVwoSBr4T5C+047FrxUkerD0/zNWQGJqPZiK7DvyqMd5k7MheN4At
 zJARFts1hz/S+gc7R3CDLXrKNW+GcuQgxHsDpQuRjWYd/5BwT7gDnra/Y
 Bz2BXJIyo967eOyT7LaFZMZSBCHZdA2AggDsptxTmUyT1del0h92mhelu
 CtvGQicXWP4jXLBEMQFg0witHw2ti+O7qnuOxAoi1vhfWkAGFtWzozur3 Q==;
X-CSE-ConnectionGUID: pdsba+dXQgyXsXEgcRep6A==
X-CSE-MsgGUID: R4/oXp38S0Slw0xfbugyhg==
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; d="scan'208";a="76059740"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 26 Oct 2026 11:21:18 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 26 Oct 2026 11:21:11 -0700
Received: from MON-LT-C78453.mchp-main.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58 via Frontend Transport; Mon, 26 Oct 2026 11:21:10 -0700
Date: Mon, 26 Oct 2026 14:21:08 -0400
From: Charles Perry <charles.perry@microchip.com>
To: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
CC: Charles Perry <charles.perry@microchip.com>,
 <u-boot@lists.u-boot-project.org>, Yao Zi <me@ziyao.cc>, Rahul Pathak
 <rahul@summations.net>, Anup Patel <anup@brainfault.org>, Paul Walmsley
 <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Romain Caritey
 <romain.caritey@microchip.com>, Mame Maria Mbaye
 <MameMaria.Mbaye@microchip.com>, Tom Rini <trini@konsulko.com>, Rick Chen
 <rick@andestech.com>, Leo Yu-Chi Liang <ycliang@andestech.com>, Michal Simek
 <michal.simek@amd.com>, Conor Dooley <conor@kernel.org>, Peng Fan
 <peng.fan@oss.nxp.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH v4 2/8] firmware: rpmi: add support for the SBI MPXY
 transport
Message-ID: <at-aFP4vrscdO9K2@MON-LT-C78453.mchp-main.com>
References: <20261014-rpmi_v4-v4-0-d53d34a49780@microchip.com>
 <20261014-rpmi_v4-v4-2-d53d34a49780@microchip.com>
 <CAPxK-6eEg4AdPOB70gBM6_tZt6y-CurTc44UYxydBqWAFNPepw@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPxK-6eEg4AdPOB70gBM6_tZt6y-CurTc44UYxydBqWAFNPepw@mail.gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-21.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 26, 2026 at 12:38:51PM +0530, Subrahmanya Lingappa wrote:
> Charles,
> 
> On Wed, Oct 14, 2026 at 7:47 PM Charles Perry
> <charles.perry@microchip.com> wrote:
> >
> > This adds an RPMI transport driver for the Supervisor Binary Interface
> > (SBI) message proxy (MPXY) extension [1].
> >
> > This is for S-Mode U-Boot where some supervisor software (such as
> > OpenSBI) runs in M-Mode and handles the low level communication with the
> > PuC.
> >
> > [1]: https://github.com/riscv-non-isa/riscv-sbi-doc (chapter 20)
> >
> > Signed-off-by: Charles Perry <charles.perry@microchip.com>
> > ---
> > Changes in v4: None
> > Changes in v3: None
> >
> > Changes in v2: (from Yao Zi review)
> >  - Reorder headers
> >  - Remove struct sbi_mpxy_rpmi_channel_attrs and struct
> >    sbi_mpxy_channel_attrs for simpler u32 arrays
> >  - Don't null check pointers before free()
> > ---
> >  arch/riscv/include/asm/sbi.h          |  57 +++++
> >  drivers/firmware/rpmi/Kconfig         |   9 +
> >  drivers/firmware/rpmi/Makefile        |   1 +
> >  drivers/firmware/rpmi/rpmi-sbi-mpxy.c | 410 ++++++++++++++++++++++++++++++++++
> >  4 files changed, 477 insertions(+)
> >
> > diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> > index 47124dbaac84..10e03257d8e6 100644
> > --- a/arch/riscv/include/asm/sbi.h
> > +++ b/arch/riscv/include/asm/sbi.h
> > @@ -10,6 +10,7 @@
> >  #define _ASM_RISCV_SBI_H
> >
> >  #include <linux/types.h>
> > +#include <linux/errno.h>
> >
> >  enum sbi_ext_id {
> >         SBI_EXT_0_1_SET_TIMER = 0x0,
> > @@ -104,6 +105,17 @@ enum sbi_ext_dbcn_fid {
> >         SBI_EXT_DBCN_CONSOLE_WRITE_BYTE,
> >  };
> >
> > +enum sbi_ext_mpxy_fid {
> > +       SBI_EXT_MPXY_GET_SHMEM_SIZE = 0,
> > +       SBI_EXT_MPXY_SET_SHMEM,
> > +       SBI_EXT_MPXY_GET_CHANNEL_IDS,
> > +       SBI_EXT_MPXY_READ_ATTRS,
> > +       SBI_EXT_MPXY_WRITE_ATTRS,
> > +       SBI_EXT_MPXY_SEND_MSG_WITH_RESP,
> > +       SBI_EXT_MPXY_SEND_MSG_WITHOUT_RESP,
> > +       SBI_EXT_MPXY_GET_NOTIFICATION_EVENTS,
> > +};
> > +
> >  #ifdef CONFIG_SBI_V01
> >  #define SBI_EXT_SET_TIMER              SBI_EXT_0_1_SET_TIMER
> >  #define SBI_FID_SET_TIMER              0
> > @@ -132,6 +144,14 @@ enum sbi_ext_dbcn_fid {
> >  #define SBI_SPEC_VERSION_MAJOR_MASK    0x7f
> >  #define SBI_SPEC_VERSION_MINOR_MASK    0xffffff
> >
> > +static inline unsigned long sbi_mk_version(unsigned long major,
> > +                                          unsigned long minor)
> > +{
> > +       return ((major & SBI_SPEC_VERSION_MAJOR_MASK)
> > +               << SBI_SPEC_VERSION_MAJOR_SHIFT) |
> > +              (minor & SBI_SPEC_VERSION_MINOR_MASK);
> > +}
> > +
> >  /* SBI return error codes */
> >  #define SBI_SUCCESS                    0
> >  #define SBI_ERR_FAILURE                        -1
> > @@ -139,6 +159,43 @@ enum sbi_ext_dbcn_fid {
> >  #define SBI_ERR_INVALID_PARAM          -3
> >  #define SBI_ERR_DENIED                 -4
> >  #define SBI_ERR_INVALID_ADDRESS                -5
> > +#define SBI_ERR_ALREADY_AVAILABLE      -6
> > +#define SBI_ERR_ALREADY_STARTED                -7
> > +#define SBI_ERR_ALREADY_STOPPED                -8
> > +#define SBI_ERR_NO_SHMEM               -9
> > +#define SBI_ERR_INVALID_STATE          -10
> > +#define SBI_ERR_BAD_RANGE              -11
> > +#define SBI_ERR_TIMEOUT                        -12
> > +#define SBI_ERR_IO                     -13
> > +#define SBI_ERR_DENIED_LOCKED          -14
> > +
> > +static inline int sbi_to_linux_error(int err)
> > +{
> > +       switch (err) {
> > +       case SBI_SUCCESS:
> > +               return 0;
> > +       case SBI_ERR_DENIED:
> > +       case SBI_ERR_DENIED_LOCKED:
> > +               return -EPERM;
> > +       case SBI_ERR_INVALID_PARAM:
> > +       case SBI_ERR_INVALID_STATE:
> > +               return -EINVAL;
> > +       case SBI_ERR_BAD_RANGE:
> > +               return -ERANGE;
> > +       case SBI_ERR_INVALID_ADDRESS:
> > +               return -EFAULT;
> > +       case SBI_ERR_NO_SHMEM:
> > +               return -ENOMEM;
> > +       case SBI_ERR_TIMEOUT:
> > +               return -ETIMEDOUT;
> > +       case SBI_ERR_IO:
> > +               return -EIO;
> > +       case SBI_ERR_NOT_SUPPORTED:
> > +       case SBI_ERR_FAILURE:
> > +       default:
> > +               return -EOPNOTSUPP;
> > +       };
> > +}
> >
> >  struct sbiret {
> >         long error;
> > diff --git a/drivers/firmware/rpmi/Kconfig b/drivers/firmware/rpmi/Kconfig
> > index 54fd77ad8f48..708d931263ff 100644
> > --- a/drivers/firmware/rpmi/Kconfig
> > +++ b/drivers/firmware/rpmi/Kconfig
> > @@ -7,3 +7,12 @@ config RPMI_FIRMWARE
> >           protocol for communication between an Application Processor (AP) and a
> >           platform microcontroller (PuC). The RPMI specification is available
> >           at: https://github.com/riscv-non-isa/riscv-rpmi
> > +
> > +config RPMI_SBI_MPXY
> > +       bool "RPMI over SBI MPXY transport"
> > +       depends on RPMI_FIRMWARE && SBI
> > +       help
> > +         Enable support for transport of RPMI messages over the message proxy
> > +         (MPXY) extension of the supervisor binary interface (SBI). The
> > +         specification for the MPXY extension is available at:
> > +         https://github.com/riscv-non-isa/riscv-sbi-doc (chapter 20)
> > diff --git a/drivers/firmware/rpmi/Makefile b/drivers/firmware/rpmi/Makefile
> > index d69c718d150e..71c4aeaed910 100644
> > --- a/drivers/firmware/rpmi/Makefile
> > +++ b/drivers/firmware/rpmi/Makefile
> > @@ -1 +1,2 @@
> >  obj-y  += rpmi-uclass.o
> > +obj-$(CONFIG_RPMI_SBI_MPXY) += rpmi-sbi-mpxy.o
> > diff --git a/drivers/firmware/rpmi/rpmi-sbi-mpxy.c b/drivers/firmware/rpmi/rpmi-sbi-mpxy.c
> > new file mode 100644
> > index 000000000000..9ccca0eb59b2
> > --- /dev/null
> > +++ b/drivers/firmware/rpmi/rpmi-sbi-mpxy.c
> > @@ -0,0 +1,410 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2026 Microchip Technology Inc. All rights reserved.
> > + */
> > +
> > +#define LOG_CATEGORY UCLASS_RPMI
> > +
> > +#include <asm/io.h>
> > +#include <asm/sbi.h>
> > +#include <asm/types.h>
> > +#include <dm.h>
> > +#include <dm/device_compat.h>
> > +#include <linux/bitops.h>
> > +#include <linux/kernel.h>
> > +#include <log.h>
> > +#include <malloc.h>
> > +#include <rpmi-uclass.h>
> > +#include <string.h>
> > +
> > +/* SBI MPXY channel IDs data in shared memory */
> > +struct sbi_mpxy_channel_ids_data {
> > +       /* Remaining number of channel ids */
> > +       __le32 remaining;
> > +       /* Returned channel ids in current function call */
> > +       __le32 returned;
> > +       /* Returned channel id array */
> > +       __le32 channel_array[];
> > +};
> > +
> > +enum sbi_mpxy_attribute_id {
> > +       /* Standard channel attributes managed by MPXY framework */
> > +       SBI_MPXY_ATTR_MSG_PROT_ID = 0x00000000,
> > +       SBI_MPXY_ATTR_MSG_PROT_VER = 0x00000001,
> > +       SBI_MPXY_ATTR_MSG_MAX_LEN = 0x00000002,
> > +       SBI_MPXY_ATTR_MSG_SEND_TIMEOUT = 0x00000003,
> > +       SBI_MPXY_ATTR_MSG_COMPLETION_TIMEOUT = 0x00000004,
> > +       SBI_MPXY_ATTR_CHANNEL_CAPABILITY = 0x00000005,
> > +       SBI_MPXY_ATTR_SSE_EVENT_ID = 0x00000006,
> > +       SBI_MPXY_ATTR_MSI_CONTROL = 0x00000007,
> > +       SBI_MPXY_ATTR_MSI_ADDR_LO = 0x00000008,
> > +       SBI_MPXY_ATTR_MSI_ADDR_HI = 0x00000009,
> > +       SBI_MPXY_ATTR_MSI_DATA = 0x0000000A,
> > +       SBI_MPXY_ATTR_EVENTS_STATE_CONTROL = 0x0000000B,
> > +       SBI_MPXY_ATTR_STD_ATTR_MAX_IDX,
> > +       /*
> > +        * Message protocol specific attributes, managed by
> > +        * the message protocol specification.
> > +        */
> > +       SBI_MPXY_ATTR_MSGPROTO_ATTR_START = 0x80000000,
> > +       SBI_MPXY_ATTR_MSGPROTO_ATTR_END = 0xffffffff
> > +};
> > +
> > +/* SBI_MPXY_ATTR_CHANNEL_CAPABILITY bits */
> > +#define SBI_MPXY_CHAN_CAP_MSI BIT(0)
> > +#define SBI_MPXY_CHAN_CAP_SSE BIT(1)
> > +#define SBI_MPXY_CHAN_CAP_EVENTS_STATE BIT(2)
> > +#define SBI_MPXY_CHAN_CAP_SEND_WITH_RESP BIT(3)
> > +#define SBI_MPXY_CHAN_CAP_SEND_WITHOUT_RESP BIT(4)
> > +#define SBI_MPXY_CHAN_CAP_GET_NOTIFICATIONS BIT(5)
> > +
> > +/* RPMI message protocol specific MPXY attributes */
> > +enum sbi_mpxy_rpmi_attribute_id {
> > +       SBI_MPXY_RPMI_ATTR_SERVICEGROUP_ID,
> > +       SBI_MPXY_RPMI_ATTR_SERVICEGROUP_VERSION,
> > +       SBI_MPXY_RPMI_ATTR_IMPL_ID,
> > +       SBI_MPXY_RPMI_ATTR_IMPL_VERSION,
> > +       SBI_MPXY_RPMI_ATTR_MAX_ID
> > +};
> > +
> > +/* Possible values of MSG_PROT_ID attribute as-per SBI v3.0 (or higher) */
> > +enum sbi_mpxy_msgproto_id {
> > +       SBI_MPXY_MSGPROTO_RPMI_ID = 0x0,
> > +};
> > +
> > +struct sbi_mpxy_chan_desc {
> > +       u32 id;
> > +       u32 max_xfer_len;
> > +       u32 attrs[SBI_MPXY_ATTR_STD_ATTR_MAX_IDX];
> > +       u32 rpmi_attrs[SBI_MPXY_RPMI_ATTR_MAX_ID];
> > +};
> > +
> > +struct rpmi_sbi_mpxy {
> > +       struct udevice *dev;
> > +       void *shmem;
> > +       unsigned long shmem_size;
> > +       u32 channel_count;
> > +       struct sbi_mpxy_chan_desc *channel_descs;
> > +};
> > +
> > +static int rpmi_sbi_mpxy_read_attrs(struct rpmi_sbi_mpxy *mpxy, u32 channel_id,
> > +                                   u32 base_attrid, u32 attr_count,
> > +                                   u32 *attrs_buf)
> > +{
> > +       struct sbiret sret;
> > +       int i;
> > +
> > +       sret = sbi_ecall(SBI_EXT_MPXY, SBI_EXT_MPXY_READ_ATTRS, channel_id,
> > +                        base_attrid, attr_count, 0, 0, 0);
> > +       if (sret.error)
> > +               return sbi_to_linux_error(sret.error);
> > +
> > +       for (i = 0; i < attr_count; i++)
> > +               attrs_buf[i] = le32_to_cpu(((__le32 *)mpxy->shmem)[i]);
> > +
> > +       return 0;
> > +}
> > +
> > +static int rpmi_sbi_mpxy_send_message(void *shmem, u32 mpxy_fid, u32 channel_id,
> > +                                     u32 msg_id, const void *tx,
> > +                                     unsigned long tx_len, void *rx,
> > +                                     unsigned long max_rx_len,
> > +                                     unsigned long *rx_len)
> > +{
> > +       unsigned long rx_bytes;
> > +       struct sbiret sret;
> > +
> > +       if (tx)
> > +               memcpy(shmem, tx, tx_len);
> > +
> > +       sret = sbi_ecall(SBI_EXT_MPXY, mpxy_fid, channel_id, msg_id, tx_len, 0,
> > +                        0, 0);
> > +
> > +       if (rx && !sret.error) {
> > +               rx_bytes = sret.value;
> > +               if (rx_bytes > max_rx_len)
> > +                       return -ENOSPC;
> > +
> > +               memcpy(rx, shmem, rx_bytes);
>  `rx_bytes` is checked against the caller's buffer, but not against the
>  allocated MPXY shared-memory region. Current callers pass bounded response
>  buffers, so this is defensive hardening rather than a demonstrated overflow
>  in the current clients; however, the helper itself accepts an arbitrary
>  `max_rx_len` and trusts the SBI return value. Please bound the response by
>  both the shared-memory allocation and the channel's maximum transfer length
>  before copying.

Ok good point. I'll make this case return -EIO since this would be a bug in
the SBI.

Thanks,
Charles

> 
> Regards,
> Subrahmanya
> 
