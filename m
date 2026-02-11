Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3F6FE9E2E7
	for <u-boot@archiver.kernel.org>; Wed, 11 Feb 2026 11:09:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C86982BF2;
	Wed, 11 Feb 2026 12:09:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="s7gPL/gp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C641283D5D; Wed, 11 Feb 2026 12:09:40 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2C3480050
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 12:09:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4f9wgN5TM6z9tqB;
 Wed, 11 Feb 2026 12:09:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1770808177;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5J2AZYO7WkdNPmGAEl8AgQBH7XEdoh1UYPfweM/Uni0=;
 b=s7gPL/gpN68997tTK1IJWyZgJABLq9wDLg/8GUHVdtv1XwlfEih5Wo1ETUr1i1iG/d0ai1
 UCKVTYOPiyV2LvFT3Zl0S7AcbypZcoGVffrZ5yq8xS4She8D18wF+ThFL1BRgPwhy8rbXP
 jIEgzfX4VqpxyxLDqTpN4CyADCSws0sIZpPX5wqXoFRVi8uxWDx2kEcGUYsIw8x7Vldc6f
 tbX2Bo0tEoxOJAO9pDPa/W1H40hKYILuZvlejsFpCTjgV7dR7iABYSEdvmdM6gKgqZls3T
 kYnfN4sjZH1N3T+3lvrf8/6XvfSCtmOsH3ffkeU2+eg/IRDS7WjOvVdmYjjsqA==
Message-ID: <52bb5837-ed36-4749-824b-e1215bedfce4@mailbox.org>
Date: Wed, 11 Feb 2026 12:06:50 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] scsi: Adjust SCSI inquiry command data length
To: Macpaul Lin <macpaul.lin@mediatek.com>, u-boot@lists.denx.de,
 Amjad Ouled-Ameur <aouledameur@baylibre.com>, Tom Rini <trini@konsulko.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>, Ryder Lee
 <Ryder.Lee@mediatek.com>, Sam Shih <sam.shih@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>
Cc: Bear Wang <bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>,
 Ramax Lo <ramax.lo@mediatek.com>, Macpaul Lin <macpaul@gmail.com>,
 MediaTek Chromebook Upstream
 <Project_Global_Chrome_Upstream_Group@mediatek.com>,
 Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Casey Connolly <casey.connolly@linaro.org>, Bin Meng <bmeng.cn@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, "ht . lin"
 <ht.lin@mediatek.com>
References: <20260211104043.2445588-1-macpaul.lin@mediatek.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260211104043.2445588-1-macpaul.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: e03aae273fd1275517a
X-MBO-RS-META: dhgwdw6c5p1ogqof5cc3myzxohhx98uh
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

On 2/11/26 11:40 AM, Macpaul Lin wrote:
> Adjust the data length of the SCSI inquiry command to accommodate various
> UFS device vendors. This prevents SCSI detection failures on Longsys UFS
> devices. Verified with Hynix, SD, and Longsys UFS devices.
Can this be quirked using some vendor/device ID match , so only the 
problematic devices suffer the consequences ? Thank you
