Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15F2BC5CFC1
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 22:44:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C13FE60AB9;
	Fri, 14 Aug 2026 22:44:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 19jz0Y2Jn2sd; Fri, 14 Aug 2026 22:44:14 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F0B2160831
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786747454;
	bh=a2jYFF7mr78OOCLy97d//WxA5YRfQdjuInYRw7sl8Mc=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=vtQNSp/kjpuln4vpJ4vDA7wrIhB4G1ytyh+/ddqx9hg57W65p7EjGtQneQWZFYp6N
	 1cOHZVV/pbcAjqex70g7de9Z/UeP6ggluWZpJBew0MEkkkQl48kur012huyxmcxbRQ
	 YOC7twtqexVBQXj8suvq8hJmPa7VqG1Nj7nFOhMR78YlYrjW5Uh5x5HYa4ij74cZgf
	 dDH7eHIRTn0rjHrPFDHrfdi6/Y62dOqWXCXt2TaBB1DMSYnSz2cZfClUp++Dji1LZj
	 APE1Zwy0QlaqzAer/eQKcfOfqNdJjd7nlQXmm48NIEEJVZTa5sWEITZjI9PKwjTwb9
	 zdbAySJ4wSF4A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id F0B2160831;
	Fri, 14 Aug 2026 22:44:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id AB3C43A0
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 22:44:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9764D40C6A
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 22:44:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a3gf9ymcWLMZ for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 22:44:10 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::202; helo=mout-p-202.mailbox.org;
 envelope-from=marek.vasut@mailbox.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 9E3FA40C8A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9E3FA40C8A
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9E3FA40C8A
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 22:44:10 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hMHMp1BpdzMlGk;
 Sat, 15 Aug 2026 00:44:06 +0200 (CEST)
Message-ID: <fc87cb26-7c06-430e-a858-c514d492c046@mailbox.org>
Date: Sat, 15 Aug 2026 00:04:40 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 3/3] spi: cadence_qspi: Use APB write protection
To: Ralph Siemsen <ralph.siemsen@linaro.org>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Padmarao Begari <padmarao.begari@amd.com>, Anshul Dalal <anshuld@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Johan Jonker <jbx6244@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Patrice Chotard <patrice.chotard@foss.st.com>
References: <20260814-rzn1-2026-10-spi-v2-0-973d5fa092f2@linaro.org>
 <20260814-rzn1-2026-10-spi-v2-3-973d5fa092f2@linaro.org>
Content-Language: en-US
In-Reply-To: <20260814-rzn1-2026-10-spi-v2-3-973d5fa092f2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: d8ewejmwsxxwscbibp3cgf4qwth693sy
X-MBO-RS-ID: dbd71d40b8b5fd4fb52
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
From: Marek Vasut via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Marek Vasut <marek.vasut@mailbox.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 8/14/26 8:28 PM, Ralph Siemsen wrote:
> Add an option to make use of hardware write protection in the QSPI
> controller. This helps prevent flash corruption due to stray writes.
> No stray writes have been observed, this is defensive code.
> 
> When enabled, the controller is configured to block writes to flash. Due
> to known errata [1] the full 32-bit address range is protected, even
> though the flash occupies only a portion.
> 
> The protection gets temporarily lifted while intentionally writing
> to flash, for example using "sf write" command.
> 
> [1] https://www.renesas.com/en/document/tcu/qspi-contoller-issue
> 
> Signed-off-by: Ralph Siemsen <ralph.siemsen@linaro.org>

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
