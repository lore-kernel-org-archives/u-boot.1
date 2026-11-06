Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE70A606A326
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 17:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Zpjx2bfV;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=AZxakWYg
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B15CB4087D;
	Fri,  6 Nov 2026 17:07:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id I52CFyB8Ezok; Fri,  6 Nov 2026 17:07:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BD49D40723
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793984855;
	b=VmqxS9PjaIhPl8uM7R3WgJIM3Y0/AHahy92hc6XozWgOYwQMv8taaI6zCSoemXbFBbil
	 DNjlf6ItJbU1WyUpqXwukiF8rRIELmrQzUT23sl9FSgg32BFE52ewqQ0UgNv0z97cq7hG
	 5I0udHCoCeKFqZgSbnPzQjMXcHxKXFqBLQ24IMBo+RHPqEv9EakXNxULGJ4LHx15UKDHN
	 rROjROB0fFaUAB11TQNTVF6FjrKP6tMMgIsiZ5TJw5sC7xxc48139BxEQ8IQNoCEWtdFf
	 T0DLx1k1Ju3QxkqRpBnsW1e/FHHC67XLTHL8Wmy54Xg49zhEQv+MaTDpzT32tRryWbw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793984855;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-Amp-Result:Received:Received:Received:Date:From:To:CC:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=HcJGtYr95mfpi+f6kNIiMf6EBBsrxE6h3T+384qiQ1w=;
	b=o3ehrxNcH2L9zmuMrzPE1zv+zeFLxQzx5UG+gt1VQUdaOG38qdLEiAnguJxdhZySBj+v
	 QaRzw3Pn7o+edunQH1yvNmtiTwYt70K9awZnYKPn08UJ3H83bPfgesnfCt1hcJxLVqLvM
	 bJTnW+YJK1CHH3skrRiGyTdZC81EI+FvHRGeOg6Ow8c3R3jpf0Zm9wYfohMlTOvKWpF18
	 Sw07UCGY1qLjqAp27uh/utygc7wkdsw2s/lMLH/bu7IB6qq7WBc7AXdeFq+lJN+ENo+lV
	 0H0AQt295mHyhJJsdmVp6P/OMvU5S71QTSRW2E7222WPWyHKOFDBb8CKtAMbS9OHlxw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=AZxakWYg;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793984855;
	bh=HcJGtYr95mfpi+f6kNIiMf6EBBsrxE6h3T+384qiQ1w=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Zpjx2bfV75a7RAZIamHC8BdSzrECgKCteg72imdL1OL6JYBeXUV94frN3AKWanS+k
	 5rWC7OAk+QU05kJqWXZpEXgCmjzGcYX4ttN59TTZMmPWbBDZTBN22JjsNfjtSPYkew
	 mofTL3u9wPD/E7O3Hvi6S6objiItNx+EC7tZPVPgTlrrwoQT1RfjkM9uKKe/a14mOZ
	 c0wYDHVTH03rl076wqfH+E+ZV8RgSQ4aGO5BLeT9Eq4rzZ04/6fZyUgVVC435rKqrO
	 zFRD4cXHD112ePjcZ9Qnwp5aCFTUAvYms9iZfZTP64VhRp+3oyidGuI06NLq088uti
	 ZmHu7baIVqaGg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BD49D40723;
	Fri,  6 Nov 2026 17:07:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 617A234D
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 17:07:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4737840723
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 17:07:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ymhroNvy-yV8 for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 17:07:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3986340718
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=68.232.153.233
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=68.232.153.233;
 helo=esa.microchip.iphmx.com;
 envelope-from=prvs=763bc877a=charles.perry@microchip.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com
 header.a=rsa-sha256 header.s=mchp header.b=AZxakWYg
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3986340718
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 17:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1793984854; x=1825520854;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=mb54wwmN+WWcc3Bt038f6uhmL+SyYmK8GxCfIJb0qdM=;
 b=AZxakWYgLJLELq9tJGxNv+wMp4AAtGCVe7WMcSGQ4WuVDEhnodeB/3iW
 +kT8Bt5mqzdUYvxoAAVBQfmQ9Es2TFQUMpaku7DlcGhSjUSxmihF4G7gF
 8u+M37tcJzYSAaq0jza61+bHcRkz88K5BjLm1LdN1yotkZblcRUDUsOvy
 /Ts53IcyJ+eQsiQOF3ti1n7ZxQUGYTW3/PRAqLNODLJdSNJVE2g6Tivp9
 ppr62SlWNqnLNhvpTTDJA/y2/5xbHqnve/F1bRr40uiDeJx9sNrEZ+Red
 zXHYKrm2LQyQgA6F3a6O9ilAgK/wkPFWPAzeW6td+PfV3u4QmBT3mqVUT w==;
X-CSE-ConnectionGUID: Uq9rohjnQXyyh9GXQEdABg==
X-CSE-MsgGUID: zMFoLEpUQcOLZOSTvC102Q==
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; d="scan'208";a="76770860"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 06 Nov 2026 10:07:33 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 6 Nov 2026 10:07:32 -0700
Received: from MON-LT-C78453.mchp-main.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58 via Frontend Transport; Fri, 6 Nov 2026 10:07:29 -0700
Date: Fri, 6 Nov 2026 12:07:27 -0500
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
Subject: Re: [PATCH v4 5/8] firmware: rpmi: add a test and a sandbox driver
Message-ID: <au4JT4UvpwJS0MyO@MON-LT-C78453.mchp-main.com>
References: <20261014-rpmi_v4-v4-0-d53d34a49780@microchip.com>
 <20261014-rpmi_v4-v4-5-d53d34a49780@microchip.com>
 <CAPxK-6dAV__Pu4ACk+GNK6kXZUcWvp1jUpNd-7-E_ysCs1=18g@mail.gmail.com>
 <at-h15c5Nn-PpUZi@MON-LT-C78453.mchp-main.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <at-h15c5Nn-PpUZi@MON-LT-C78453.mchp-main.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-20.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 26, 2026 at 02:54:15PM -0400, Charles Perry wrote:
> On Mon, Oct 26, 2026 at 12:49:39PM +0530, Subrahmanya Lingappa wrote:
> > Charles,
> > 
> > On Wed, Oct 14, 2026 at 7:47 PM Charles Perry
> > <charles.perry@microchip.com> wrote:
> > >
> > > Create a new transport layer that sends the messages to a simulated RPMI
> > > firmware.
> > >
> > > For now, this only contains a simulation of the clock service group
> > > which is implemented using code from librpmi [1] and adapted.
> > >
> > > Also add a test in test/dm that makes use of the RPMI clock driver.
> > >
> > > [1]:
> > > https://github.com/riscv-software-src/librpmi/blob/3f3c4ca47339a8795432e260f17e1fc5091c9a3a/lib/rpmi_service_group_clock.c
> > >
> > > Signed-off-by: Charles Perry <charles.perry@microchip.com>
> > > ---
> > > Changes in v4: None
> > > Changes in v3: None
> > >
> > > Changes in v2:
> > >  - Reorder headers
> > > ---
> > >  MAINTAINERS                                |   1 +
> > >  arch/sandbox/dts/test.dts                  |  12 +
> > >  configs/sandbox_defconfig                  |   2 +
> > >  drivers/firmware/rpmi/Kconfig              |   3 +-
> > >  drivers/firmware/rpmi/Makefile             |   1 +
> > >  drivers/firmware/rpmi/rpmi-sandbox-clock.c | 446 +++++++++++++++++++++++++++++
> > >  drivers/firmware/rpmi/rpmi-sandbox.c       | 156 ++++++++++
> > >  drivers/firmware/rpmi/rpmi-sandbox.h       |  47 +++
> > >  test/dm/Makefile                           |   1 +
> > >  test/dm/rpmi.c                             |  48 ++++
> > >  10 files changed, 716 insertions(+), 1 deletion(-)
> > >

...


> > > +
> > > +static int dm_test_rpmi_clock(struct unit_test_state *uts)
> > > +{
> > > +       struct udevice *rpmi_dev, *clk_dev;
> > > +       struct clk clk0, clk1, clk2, clk3;
> > > +
> > > +       ut_assertok(uclass_get_device_by_name(UCLASS_RPMI, "rpmi", &rpmi_dev));
> > > +
> > > +       ut_assertok(
> > > +               uclass_get_device_by_name(UCLASS_CLK, "rpmi-clock", &clk_dev));
> > > +
> > > +       // Grab clock 0 and retrieve the rate
> > > +       ut_assertok(clk_get_by_index(clk_dev, 0, &clk0));
> > > +       ut_asserteq_64(20000000, clk_get_rate(&clk0));
> > > +
> > > +       // Change to 1GHz
> > > +       ut_asserteq(1000000000, clk_set_rate(&clk0, 1000000000));
> > 
> >  The test does not exercise the supported-rates path above. Please add a
> >  regression test that sends `GET_SUPPORTED_RATES` through the sandbox transport
> >  for both a valid clock ID and an out-of-range ID. The current get-rate/set-rate
> >  test passes without invoking this service. Enable/disable coverage can be
> >  added separately; shared-memory and MPXY command tests belong with their
> >  respective transport/command harnesses.
> 
> The RPMI clock driver doesn't even use the GET_SUPPORTED_RATES service as
> of now. I'll add the ->round_rate() callback for completeness so that we
> can test this service.
> 

I changed my mind.

I won't implement ->round_rate() because clk_round_rate() has very few
users and because it's not even possible to implement correctly.
"include/clk.h" states that clk_round_rate() should round as
clk_set_state() would round but without touching the clock. This isn't
possible to infer just by the info of GET_SUPPORTED_RATES.

For reference, the Linux driver [1] skips rounding entirely for discrete
clocks and rounds up linear clocks.

I think the responsible thing to do here is "keep it simple" and get rid of
the GET_SUPPORTED_RATES sandbox mode code.

[1]: https://elixir.bootlin.com/linux/v7.3.1/source/drivers/clk/clk-rpmi.c#L328

-- 
Thanks,
Charles
