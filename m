Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C1FEC04FFE
	for <u-boot@archiver.kernel.org>; Sat, 18 May 2024 00:19:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CFB3885D1;
	Sat, 18 May 2024 02:19:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1715991574;
	bh=dcSyEpNck9ROkj3i9CF0Ox6UfnG7pDyJcM394h9QP98=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TkOves3dCBL8Z+dDPQTMyMdXR3mFqnkKHXiASuUi6g78myMmzErqUSCadCD0NmEoJ
	 tKybcWUscnCNo2ii2M6J07sSwIK10hOWxwXSlIriFbWRTNnTkdFbiOPRKkhE1uBWXl
	 DPZ/toPEZdzbWV4dN9Cujx8wGSbvm4Bq808prEtfR+eb57KcTy9AEduZKTsxxUWLNP
	 SRV1EjmRS6cSQ/kPekYB37bWR86qOuNaWjeEF8gEE0jAo78UXSENXWd+SqaB8WllCk
	 w7SgfczHob2aWd0n2J8RceP+7bBLBtctZd5Gswi1SGWAOoNH4e/bHdkAwsiPthcS9P
	 44Lia09dfGAag==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id DF036885E1;
 Fri, 17 May 2024 23:17:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1715980674;
 bh=dcSyEpNck9ROkj3i9CF0Ox6UfnG7pDyJcM394h9QP98=;
 h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
 b=RRWHjKWfaa3lMxCO7SutW22sCSucze6CMKNVYzBlGT9xEJKTbPsUv/NG0g+EqCOyX
 93ssvdq7Eekg9zjwwuG3D5BZ9lqKAQCL7niB5dLxyAA2j/G1jVhgzqVSNS2vSf+YWZ
 7/rvbXJft69qYQ+hZnlD6VGr0t2sRn30l8cKN4ZqOZrF+BnugbBUBsEekwdIzupbY6
 5uOP1t98hv7W9hEvQz9JA0L9eGHZNGAtzpG7qZQ4dyB+SERhNg2szZdPM5rnet6X80
 hiHJ+0yseqxW3i70yPB+wYI4+RgUJovEBw2/bgXJrkt9A8JKwn8WGYT3dbpVcyKG5w
 zci2Lw/n4JyPA==
Message-ID: <92b158da-b023-4874-bdf2-dd3a1aa014af@denx.de>
Date: Fri, 17 May 2024 23:16:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH 1/1] usb: Assimilate usb_get_descriptor() to linux
To: Philip Oberfichtner <pro@denx.de>, u-boot@lists.denx.de
Cc: trini@konsulko.com, patrice.chotard@foss.st.com,
 caleb.connolly@linaro.org, neil.armstrong@linaro.org, sumit.garg@linaro.org,
 michal.simek@amd.com, bmeng.cn@gmail.com, ryder.lee@mediatek.com,
 weijie.gao@mediatek.com, chunfeng.yun@mediatek.com,
 GSS_MTK_Uboot_upstream@mediatek.com, iwamatsu@nigauri.org, lukma@denx.de,
 mkorpershoek@baylibre.com, eddie.cai.linux@gmail.com, neal@gompa.dev,
 j@jannau.net, sjg@chromium.org, teik.heng.chong@intel.com, jonas@kwiboo.se,
 nm@ti.com, seanga2@gmail.com, festevam@gmail.com, tharvey@gateworks.com,
 othacehe@gnu.org, fabrice.gasnier@foss.st.com, xdrudis@tinet.cat,
 marcan@marcan.st, richard.habeeb@gmail.com, artur@conclusive.pl,
 simon@holesch.de, clamor95@gmail.com, ion@agorria.com,
 miquel.raynal@bootlin.com
References: <20240517091820.3992-1-pro@denx.de>
Content-Language: en-US
In-Reply-To: <20240517091820.3992-1-pro@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Sat, 18 May 2024 02:19:31 +0200
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

On 5/17/24 11:18 AM, Philip Oberfichtner wrote:
> Before this commit, usb_get_descriptor() failed for some flakey USB
> devices. We hereby adopt the more robust linux implementation [1].

Can you include which exact device fails and how? Details of the failure 
are valuable for the next person who runs into such a bug. Search 
engines index the ML posts too, so they become searchable using those.

Which kernel version is this imported from ? Commit ID would be good to add.

[...]
