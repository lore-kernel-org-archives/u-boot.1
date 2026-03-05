Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0078F33A65
	for <u-boot@archiver.kernel.org>; Thu,  5 Mar 2026 13:57:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8729283F86;
	Thu,  5 Mar 2026 14:57:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="fbL0gzX9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66A8983F8F; Thu,  5 Mar 2026 14:57:38 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37B6483EDF
 for <u-boot@lists.denx.de>; Thu,  5 Mar 2026 14:57:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4fRWM16jkHz9sq6;
 Thu,  5 Mar 2026 14:57:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1772719054;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e0qLOtpkZ96WbMn0Pi8W+ERhRb9xorX8aIaDeGz6ZYQ=;
 b=fbL0gzX9QC9oh0B5j4eVia701EguisBnHLflkN9HGyLL6OztwhTTI5qQ3Qeo9KO482KZ15
 Ii9SujmFtkxxEweW5zEtzcUB/ikkMfWQxUz+QudxBYFXkuwN9CUxksOlab84a4hE5rzeQL
 ioWZg/4IFUn8d62JerX0MVKZLAdQUNsQ2L7yWDp/ZBZIuLY9Cq7RTPc5ZtMmo3Ha7KAB8g
 Ufay118m50F5VLN/A4yYPzXj1OwfeN2D0/7GT2UVx5Lc9K4sNyZDSgyzzrd5CbZBvEUo4Q
 jjzYjn5kf0g7uuK6qD5OSkJqApYIbBgnaOOZX82714NSjQ4gSFglpbwLYXIbCQ==
Message-ID: <7ddc616b-d99e-41a7-a186-d0388d9353ce@mailbox.org>
Date: Thu, 5 Mar 2026 14:57:26 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2] scsi: Adjust SCSI inquiry command data length
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
References: <20260305102324.2797478-1-macpaul.lin@mediatek.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260305102324.2797478-1-macpaul.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 38bfdc38d0c9eba31a3
X-MBO-RS-META: u4qj4d4hjttqkngnuxak7t8s73rbrdg3
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

On 3/5/26 11:23 AM, Macpaul Lin wrote:
> Per the SCSI SPC-4 specification, the standard inquiry data length
> should not be less than 36 bytes. The current implementation uses 512
> bytes, which causes detection failures on some UFS devices (e.g.,
> Longsys) that do not expect a transfer length exceeding the standard
> inquiry size.
> 
> Align the default standard inquiry length with the Linux kernel's
> implementation (see drivers/scsi/scsi_scan.c), which uses 36 bytes as
> the default. Devices requiring vendor-specific inquiry lengths should
> be handled through quirk settings in the future.
Reviewed-by: Marek Vasut <marek.vasut@mailbox.org>

Thank you !
