Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C463C27C6E
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 16:55:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59A3488A38;
	Fri, 14 Jun 2024 18:54:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="E4Vg6ETD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3AC55889DC; Fri, 14 Jun 2024 18:54:56 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9721B889F7
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 18:54:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-humphreys@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45EGsg5f061824;
 Fri, 14 Jun 2024 11:54:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1718384082;
 bh=l4eBneDUoTa971BK4+SuX9TQkS4I84HzMfA7Y3usao4=;
 h=From:To:CC:Subject:In-Reply-To:References:Date;
 b=E4Vg6ETDte5gUf61lKKt1c+7xjh7MYK468dK1jzF7O4ynYuOi59WcoM+NGmCE7FC6
 hXBENupK4xkoP4kwUvYK4fNi49shx8U6cTDCIDu6qnRFfYdy8OKT9NN19BPuYPUGT8
 GmAid/0jDPORF+vHh6e4BvJqSlgA5B/OxZ2F2MtI=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45EGsgRr007756
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 14 Jun 2024 11:54:42 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 14
 Jun 2024 11:54:41 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 14 Jun 2024 11:54:41 -0500
Received: from localhost (udb0321960.dhcp.ti.com [128.247.81.241])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45EGsfPs050703;
 Fri, 14 Jun 2024 11:54:41 -0500
From: Jon Humphreys <j-humphreys@ti.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
CC: Sumit Garg <sumit.garg@linaro.org>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>, Wei Ming Chen <jj251510319013@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Joshua Watt <jpewhacker@gmail.com>, "Caleb
 Connolly" <caleb.connolly@linaro.org>,
 Alexander Gendin <agendin@matrox.com>, Sean Anderson <seanga2@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Tom Rini <trini@konsulko.com>, Mario Six <mario.six@gdsys.cc>,
 Simon Glass <sjg@chromium.org>, <u-boot@lists.denx.de>
Subject: Re: [PATCH v2 0/2] scripts/Makefile.lib: EFI: Use capsule CRT
 instead of ESL
In-Reply-To: <CAC_iWjLE05LthXeAL4o92oywjtkCmPa+T6K8DRBvV=DFqZVybA@mail.gmail.com>
References: <20240613202753.2528889-1-j-humphreys@ti.com>
 <CAC_iWjLE05LthXeAL4o92oywjtkCmPa+T6K8DRBvV=DFqZVybA@mail.gmail.com>
Date: Fri, 14 Jun 2024 11:54:41 -0500
Message-ID: <86le37ihwu.fsf@udb0321960.dhcp.ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Ilias Apalodimas <ilias.apalodimas@linaro.org> writes:

> Hi Jonathan
>
> On Thu, 13 Jun 2024 at 23:28, Jonathan Humphreys <j-humphreys@ti.com> wrote:
>>
>> Use the capsule's public key certificate rather than a prebuilt ESL
>> generated from the certificate. The ESL is now generated as part of the
>> build.
>
> Is there a reason to do this? I understand that the .crt extension
> might be well known while the .esl is not, but OTOH the system you
> build on after this change *needs* to have cert-to-efi-sig-list
> installed
>
Hi Ilias,

In general, I am following the principle that it is better to not include
in your source repo derived binaries that can be built at buildtime.

As far as the need to have cert-to-efi-sig-list, it is part of efitools and
that is already documented as a requirement for the build host ([0] and
[1]), and our baseline Docker file also includes it.

[0] https://docs.u-boot.org/en/latest/develop/uefi/uefi.html#enabling-capsule-authentication
[1] https://docs.u-boot.org/en/latest/develop/uefi/uefi.html#configuring-uefi-secure-boot

Jon

> Thanks
> /Ilias
>>
>> Changes from v1:
>> - Converted the single patch to a series to include a bug fix found during
>>   development.
>> - Created an explicit rule for creating the ESL file for proper makefile
>>   dependency tracking.  v1 had combined creating the ESL file and
>>   generating the .dtsi include in a single command.
>>
>> Jonathan Humphreys (2):
>>   scripts/Makefile.lib: fixes: Embed capsule public key in platform's
>>     dtb
>>   scripts/Makefile.lib: EFI: Use capsule CRT instead of ESL file
>>
>>  board/sandbox/capsule_pub_esl_good.esl | Bin 831 -> 0 bytes
>>  configs/sandbox_defconfig              |   2 +-
>>  configs/sandbox_flattree_defconfig     |   2 +-
>>  doc/develop/uefi/uefi.rst              |   8 ++++----
>>  lib/efi_loader/Kconfig                 |  12 +++++++-----
>>  scripts/Makefile.lib                   |  24 +++++++++++++++---------
>>  6 files changed, 28 insertions(+), 20 deletions(-)
>>  delete mode 100644 board/sandbox/capsule_pub_esl_good.esl
>>
>> --
>> 2.34.1
>>
