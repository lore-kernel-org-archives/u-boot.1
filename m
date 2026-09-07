Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD20BC79F89
	for <u-boot@archiver.kernel.org>; Mon,  7 Sep 2026 08:33:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5B4B280A8C;
	Mon,  7 Sep 2026 08:33:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k8WruaFMppY4; Mon,  7 Sep 2026 08:32:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 52054809E9
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788769979;
	b=HyTJtqfkOrRXi8SCWBT6XQo1wOwNnULkLYmgRMcvgG89iCfbhnNQqYFx17j7V2BZmE51
	 /wlNwIw+UZYmiM3k1bLMvGV0RQwG+3O88ke04eD6NQy0CNmN2qCYRJS13y+mLenU1p9tf
	 pzOFT/GPww56w6js2WlP1zGtjM5safegnaP8hi2RUHMuL9RoZvAX0/aVXbNozV3r0GqYu
	 0VLnnZ4Zvh4v/SV8o+/RFE638rZizM3DHThOkwReb65RydBCs/CW3vfKcNsYStZnly1D/
	 rmuyq6b1nlGawkb0HbbRE2QEWsICkoidNwcsO8N1DGQ/yHu3a98m7lR2SNlIkb9XN+w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788769979;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=E0CYmLhwOg0zwzT3PlHTzdtytdAhb1s5P64MfMz1/8U=;
	b=k4H2P0+XeNO8io7CRo7ylFub3eQbqx19bYoGxL4HN2HWHQnD70pLLUDPGJPC5/PYmaiM
	 hCaGP7CSjGAYANuZFc3Obip8IBbBz64TatepRasOqUuu3pUIkBr4dn22FXB5cU5mdSTZr
	 gaFy4qvXeYc4vkLrWxuc7CdGoOX0syPvUUv+nfW0e/Ypx3BzardooyA5tAGl4JSo16G60
	 uV4n5uQLZe/4mGDSccRlUk5QwlCI5jhmc/gOg+9jDgQPK9ZdDF0b/BhYX/bEtXUoMO8jd
	 ALtTFif3Jgwpo+uqxvNnoGb2zPa89k/IQ6mPkRvfvRGmMw24FnGA6Y+C5d5GVh2HbMw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788769979;
	bh=E0CYmLhwOg0zwzT3PlHTzdtytdAhb1s5P64MfMz1/8U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=s2dr5sgt1ZRLNS+zUemsqHm2ZC8V6kEL6IThbw0KpDrAU6KIP+XJESTEUZWIXkn+v
	 /6CGWCVDYdLdlwmBxARK7TAENayru+00G4rVAN9wfMkChDYDPu+tScjzzjGg4aQbRf
	 rzfHoJl+uh2B/fXSHDbWyDXQ+wC0DJoiQbd/Ny714sRiPLQaO/FqWgj2IWSkRwIbrR
	 A37xYVxff4vpx0eW74h9cIu7MyNuOU2t3ioKKtsHr40OOxqr0MEA4/bat1A5xOXk8F
	 igJuN1qS/wjrT4WKS8rKx7MWKQg3xg7mKiJAaAQM67ootYMbchV1wgr4fA+7qqnckZ
	 h39dkwuGtjfRg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 52054809E9;
	Mon,  7 Sep 2026 08:32:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 742CD118
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 08:32:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 64D8360634
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 08:32:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mHpCW3s-K5GK for <u-boot@lists.u-boot-project.org>;
 Mon,  7 Sep 2026 08:32:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 15BC060631
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788769977;
 b=PfQ+qAEhCu0+x1NfRJXwbMU8IaQ8WUF7yklB55s+BMcbelrs1y1iEmrDCu0u4SAKg2Gh
 fAC9R6/QDv63oOBC+djddrEmylrou8VBp+svmi07c4FuDn6dllgKlsKaBcO53s3ATSv9j
 jNguanWTLe5P8nqldC4deczfK8CAiDCkhrxAFE4tBtAeXp/uiLsKJ9SL8p6752nlsUKrY
 hEHnorrzLoA3HgHOlCYJUzeoVZ3O86WaPeMFJXou1aGlXB/xRi1S2bf0hcN3f2CLcZDmU
 iCK4HfigyxbMB+ZaFAK/rQWIIsW1wIWU6RGWQ5YqFm2V+Q+73sZZWbKuLpzZZiIyJuA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788769977;
 h=Received-SPF:DKIM-Signature:Received:Date:From:To:Cc:Subject:
 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
 In-Reply-To:X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient;
 bh=E0CYmLhwOg0zwzT3PlHTzdtytdAhb1s5P64MfMz1/8U=;
 b=IvSfItkSssKF8lBrc/X0rByG/3VEVk+B/fDagfGSZIKw80FzjeJZsINIb4l+F0TEnmqD
 OJnPtllZsiYl0SIOJDr4pBwJ5YPvDHLd9lhICEKN3VjPPTXpFo0Zk+aEHD6MKRg0Q7lyy
 NPexdbvLYaZeN2vWbMhsQHFqj6/5Y3bvyjDzJ097t+8vbBULWlfvJHN6ptUrHPVfkkcV1
 O1BgcZ3AhOV2ATJj6o/O1wFSXUwcYUNRyxFQ4qRIDoB7FkNB1U25Ts5adk9ruOJzrd3ay
 CpTbD+M5JdSg78oEqHdReCfPj2M1mBGQElyraquDDOzvTPJ/8L2tuD6j4Me4T4FifKQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=ziyao.cc; 
 dkim=pass header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=Ap6AwPpP; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.15;
 helo=sender6-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=Ap6AwPpP
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com
 [165.173.180.15])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 15BC060631
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 08:32:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1788769956; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ct/oeYikwIQrtNnXUtRW22yE/3KouZV+Zwaxp19J/0k/tmIdM2pPL9h3Wcbz7CSpw9iOY0ObBo3NXDC9V0b6FKbhq6l/0if3zhccV6wlmwxr17Z+MBPx7X/BBhBEJ16PEnzXUM5/EWD4Uz9eI43pEBhnHyJgXTXa5vslwGo4qpo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1788769956;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=E0CYmLhwOg0zwzT3PlHTzdtytdAhb1s5P64MfMz1/8U=; 
 b=coiH+UWEvdPEvbxukdJrtzRkEnWQNiQEXMTzYPXCT7MzT243rliSIndu5QPaepUgh8wyAg/bzyGUq8IIVZRUt6Jdf8JVT0QCjUH/dDcXCQl8xjoIaDAfjjeUz18KnDk8iuxdVWF9fhDYxnI4iHsRs7VkuTjlamCIhmwCd8w/QEU=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1788769956; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=E0CYmLhwOg0zwzT3PlHTzdtytdAhb1s5P64MfMz1/8U=;
 b=Ap6AwPpPTJoQQDMHBbYk1KVWHaFvrhS15VwdS3OiLcUi30BG6Tgz7ALkoRq+lHUv
 zNXM9g9vK4DfwvhVgXAHekgIRvNrjPRuLclN8EbS3+ZRts1hgtv7Tcf2+PziiGZN4s3
 W/v7/HGOJvE2viSy3JzC/kX70PBalYLFWYoGGTV8=
Received: by mx.zohomail.com with SMTPS id 1788769953568403.5802039993597;
 Mon, 7 Sep 2026 01:32:33 -0700 (PDT)
Date: Mon, 7 Sep 2026 08:32:07 +0000
From: Yao Zi <me@ziyao.cc>
To: Eric Chung <eric.chung@riscstar.com>, u-boot-spacemit@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>,
 Leo Liang <leo.liang@sifive.com>, Yao Zi <me@ziyao.cc>,
 Wei Fu <wefu@redhat.com>, Huan Zhou <pericycle.cc@gmail.com>,
 Guodong Xu <guodong@riscstar.com>,
 Raymond Mao <raymond.mao@riscstar.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Anshul Dalal <anshuld@ti.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Johan Jonker <jbx6244@gmail.com>,
 Sumit Garg <sumit.garg@kernel.org>, Yixun Lan <dlan@kernel.org>,
 Iker Pedrosa <ikerpedrosam@gmail.com>,
 Alex Elder <elder@riscstar.com>, Andre Heider <a.heider@gmail.com>,
 Trevor Gamblin <tgamblin@baylibre.com>
Subject: Re: [PATCH v12 2/7] mmc: k1: add sdhci platform driver
Message-ID: <ap52h-_UQz15JRVU@pie>
References: <20260906-m4-v12-0-89eb5a8f879d@riscstar.com>
 <20260906-m4-v12-2-89eb5a8f879d@riscstar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260906-m4-v12-2-89eb5a8f879d@riscstar.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/288.762.58
X-ZohoMailClient: External
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

On Sun, Sep 06, 2026 at 05:11:04PM +0800, Eric Chung wrote:
> Add SDHCI platform driver support for SpacemiT K1 SoC. This driver
> implements the necessary platform-specific operations for the SDHCI
> controller, enabling MMC/SD card functionality on K1-based platforms.
> 
> Signed-off-by: Eric Chung <eric.chung@riscstar.com>
> 
> ---
> v9:
> - Disable CMD18 (multiple-block read) for SD cards in SPL.
> v6:
> - Remove ".data = 0" in spacemit_sdhci_ids[].
> v5:
> - Remove MMC_CAP_CMD23 as the CMD23 support is now a separate series.
> - Use tabs for macro definition alignment.
> - Use read_poll_timeout().
> - Set pinctrl state based on selected timing mode.
> - Add the definition of SDHC_DLL_REG1_HS400_VAL.
> - Remove the condition based on quirks.
> v4:
> - Add bulk release operations on reset and clock.
> v3:
> - Enable CMD23 in capability.
> v2:
> - Enable ADMA mode support.
> - Use CMD23 for multi-block read/write.
> - Move ASR/AIB register into pinctrl driver.
> - Correct pinctrl state from "fast" to "uhs".
> - Migrate tuning support from the spacemit linux driver.
> ---
>  drivers/mmc/Kconfig          |   7 +
>  drivers/mmc/Makefile         |   1 +
>  drivers/mmc/spacemit_sdhci.c | 684 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 692 insertions(+)

...

> diff --git a/drivers/mmc/spacemit_sdhci.c b/drivers/mmc/spacemit_sdhci.c
> new file mode 100644
> index 000000000000..4731c9ca0832
> --- /dev/null
> +++ b/drivers/mmc/spacemit_sdhci.c
> @@ -0,0 +1,684 @@

...

> +#define SPACEMIT_RX_DLINE_REG		9

There's an on-going series containing fixes for SpacemiT MMC controllers
in Linux upstream, and I noticed this patch carries same issues for the
delay granularity[1] and minimum RX tuning window[2]. Should it be fixed?

...

> +static int spacemit_sdhci_execute_tuning(struct mmc *mmc, u8 opcode)
> +{

...

> +	if (max_pass_len < 3) {
> +		log_err("Tuning failed: no stable window found\n");
> +		return -EIO;
> +	}

and here.

Best regards,
Yao Zi

[1]: https://lore.kernel.org/spacemit/20260902-07-k3-sdhci-fix-v1-5-b15c5d0f64fd@kernel.org/
[2]: https://lore.kernel.org/spacemit/20260902-07-k3-sdhci-fix-v1-6-b15c5d0f64fd@kernel.org/
