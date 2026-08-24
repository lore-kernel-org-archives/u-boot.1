Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F754C5DF81
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 08:54:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AD0E8406CD;
	Mon, 24 Aug 2026 08:54:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8SGEAXKExs8a; Mon, 24 Aug 2026 08:54:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787561678;
	bh=oogP6udpof+i1qJxpXwKa5RAEy9yRwdzkJixnIFU2JE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=V/+qFzbZ1gosQ0R9s1zdzF1cZYPD8KRcY1+btnOoja9oYeU+lrtSE/4uIPl7m9dH+
	 Zedqe6xXHmwpoEHrE32ZsY63NW9vO/jJV1YotMHW0DEq/8XYcjrGQlDyFYDFs9Ml//
	 TEQZA6vhdn923TspytBrFRdtLgJ/0u9r0PZmOopnu8Jjh7XNt1Qct5v+sVjxWRnzHo
	 Zq5GsjXJsMJ4LCmLAIjej3e8OEuK+pkH6FIDMhOeJUFqB9en+DiHy6eg93afeS0aQ7
	 kIosF3dryggGv5r17Vf0+ncPq8kEb/m0J+qtHBx7zv9tgVtP5/t/ifU9/P6uF8SEVv
	 iddgBmyUn8GvA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7DF8840573;
	Mon, 24 Aug 2026 08:54:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9A6E2230
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:54:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 808FA80E01
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:54:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5BSO_Br412Rk for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 08:54:37 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=lTK4/Cta
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D03CE80DFE
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:54:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 48E7641223;
 Mon, 24 Aug 2026 08:54:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A81AB1F000E9;
 Mon, 24 Aug 2026 08:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787561675;
 bh=oogP6udpof+i1qJxpXwKa5RAEy9yRwdzkJixnIFU2JE=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=lTK4/CtaYm4CjNPyixclZ1aZR7h6zxD2MFJEB8KAj7SErHBYxvhGdqh6B97n7fKNA
 Pd8kVrgcvT21JhXBSV8cfX5vrCwU/GaNjvpHQWeG3yQ6BDNXkgM9OCdrw9LPKSJOqj
 AB8JY43CAaKtNPUz/Gs7IHnxycAkBNlDfUhqi2C7q2v+IxDI9auhs9UE+31QB+7/GR
 71pJwVWI+w3Hca3uP15XuLfZ/v6GlWQkv4UTrzujhfGegvAqg/hGiCS9LNOdDv4H0g
 ChnDZATus4wQGZhBam3EfpmPc/p76IMXKr+VYevRWhGPHmtlhfm2CCMOTedhT4gU85
 6R1freAum32Sw==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Anders Roxell <anders.roxell@linaro.org>, u-boot@lists.denx.de,
 marex@denx.de
Cc: ilias.apalodimas@linaro.org, trini@konsulko.com, michal.simek@amd.com,
 alchark@flipper.net, jerome.forissier@arm.com, Jens Wiklander
 <jens.wiklander@linaro.org>, Anders Roxell <anders.roxell@linaro.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v6 18/87] usb: dwc3: import from kernel v4.14
In-Reply-To: <20260821084829.2070426-19-anders.roxell@linaro.org>
References: <20260821084829.2070426-1-anders.roxell@linaro.org>
 <20260821084829.2070426-19-anders.roxell@linaro.org>
Date: Mon, 24 Aug 2026 10:54:32 +0200
Message-ID: <87h5kjoq47.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Anders,

Thank you for the patch.

On Fri, Aug 21, 2026 at 10:46, Anders Roxell <anders.roxell@linaro.org> wrote:

> From: Jens Wiklander <jens.wiklander@linaro.org>
>
> Sync Linux kernel dwc3 changes from v4.13 to v4.14.
>
> The following files are preserved across the import:
> Makefile Kconfig dwc3-meson-g12a.c dwc3-meson-gxl.c dwc3-omap.c
> dwc3-uniphier.c dwc3-generic.h dwc3-generic.c dwc3-generic-sti.c
> dwc3-layerscape.c ti_usb_phy.c
>
> Skipping unused files:
> debugfs.c drd.c dwc3-exynos.c dwc3-haps.c dwc3-imx8mp.c dwc3-keystone.c
> dwc3-octeon.c dwc3-of-simple.c dwc3-pci.c dwc3-qcom.c dwc3-qcom-legacy.c
> dwc3-rtk.c dwc3-st.c dwc3-xilinx.c host.c trace.c trace.h ulpi.c
>
> Note that this is a raw import and doesn't build.
> A fixup commit at the end of the series fixes that.
>
> List of commits: git log --oneline v4.13..v4.14
> Commits imported:
> 551684708356 usb: dwc3: ep0: fix DMA starvation by assigning req->trb on ep0
>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
