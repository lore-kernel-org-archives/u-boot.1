Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D92DCD98E1
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 16:46:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0165184869;
	Tue, 16 Jun 2026 18:46:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=postmarketos.org header.i=@postmarketos.org header.b="neOMUygb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CECC848BA; Tue, 16 Jun 2026 18:46:25 +0200 (CEST)
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com
 [95.215.58.182])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB8348484C
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 18:46:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=postmarketos.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=funderscore@postmarketos.org
Date: Tue, 16 Jun 2026 16:42:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
 s=key1; t=1781628379;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PORO6CTYV1ARfsOTY2eOTu9bPIDTaUZUz6ZtUEHE1CU=;
 b=neOMUygbI+1Hr2EbOQAUclZHyc9VQNyZrW2jT7UEPUacj26Lz+cEiyfNCCrjaXuFsVdQNh
 CmSGssHtviPnFOuiTPljDSc78yTKvOvGfGVlO3fIkWGIb+4j378CitndVINp0pC+F+eLn3
 M2ulzxexn54vyDfXjhnYseiZy904wVd4yUi2SZdM2JK+nqJVbvaUpq16Jyp8cPztJAjUWd
 1ByGQS9ZQL4fmxduKE3f5h4Td2qR5IynOJYKZvpDD+llZ8ddjtksT36T978hovUO39sU/V
 v46j4SldI+PDKwYDN0cHpCMeRtSzQLTOANRY6F3F0YP15Rj9DK/7roLSYlvICQ==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Ferass El Hafidi <funderscore@postmarketos.org>
To: u-boot-qcom@groups.io,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, u-boot@lists.denx.de,
 Sumit Garg <sumit.garg@kernel.org>
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Anshul Dalal <anshuld@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tingting Meng <tingting.meng@altera.com>, Alice Guo <alice.guo@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Antony Kurniawan Soemardi <linux@smankusors.com>,
 George Chan <gchan9527@gmail.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Michael Srba <Michael.Srba@seznam.cz>, Simon Glass <sjg@chromium.org>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Subject: Re: [PATCH v3 0/6] arm: snapdragon: Add snagboot support for
 Lemans-EVK
References: <20260616-sngboot-v3-0-6fb0dee8125c@oss.qualcomm.com>
 <64718934-b054-4c47-9d01-dc6fac01dbd7@linaro.org>
In-Reply-To: <64718934-b054-4c47-9d01-dc6fac01dbd7@linaro.org>
Message-ID: <tgqh8m.i5334p2b63jo@postmarketos.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
X-Migadu-Flow: FLOW_OUT
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

Hi,

On Tue, 16 Jun 2026 12:26, "Casey Connolly via groups.io" <casey.connolly=linaro.org@groups.io> wrote:
>Hi Balaji,
>
>On 16/06/2026 11:22, Balaji Selvanathan wrote:
>> This series adds support for running U-Boot in snagboot mode on
>> Qualcomm Snapdragon platforms, targeting the Lemans-EVK board.
>
>You didn't respond to my reply on v2 of this series.
>> 
>> Snagboot is an open-source, scriptable flashing framework that provides
>> an alternative to the proprietary Firehose protocol for device
>> provisioning. Like the traditional EDL+Firehose flow, Snagboot uses the
>> Qualcomm boot ROM recovery mode (EDL) and Sahara protocol to download
>> and execute bootloaders. However, instead of using the proprietary
>> Firehose programmer, Snagboot loads U-Boot into DDR and uses the
>> standard fastboot protocol for device flashing.
>
>Glad to have some more info here. Please also add a doc page with this
>information as well as a list of supported platforms.
>

I suppose they are talking about this snagboot: https://github.com/bootlin/snagboot

But what's confusing me is there is no mention of any Qualcomm board,
nor any PR to add support for it. Is that in some downstream tree
somewhere? (to be clear I'm just someone interested in understanding
this better, snagboot is a very cool project that already supports
plenty of SoCs and it's great if it has or will have qcom support)

Best regards,
Ferass
