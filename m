Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26854C5B572
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 22:44:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E6C2D60B16;
	Fri, 14 Aug 2026 22:44:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id abdIb9Wdy7n8; Fri, 14 Aug 2026 22:44:21 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 517A960B08
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786747461;
	bh=IohWjD877cD89110PdPu8QiSqdtahow3620r14paBzg=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=vG3N9w3KC9vudD38WL7s0Y1KAq52ghIQv4ApkoKGiATEXRkdLvYnGnp/qeUovIGCD
	 lNAR9figTK8YnEFq0sRXYztdnSMc07P4xJikc7FX1B6KiUR5a/j58uzE8ATOdyGTep
	 xWwvpvPnIdZCOVxpaQN55JRJEDD3tel3erLO2N2ExkNLjaN8XApxqypQnr7ttSas3D
	 9TS3DFbpKYFN1ilgGwBnSOeq3S4VyJx8WF4vej8g17EiE2rWjc8FOEz1BpSVXy23np
	 kPX8BYVgKKY3cqE31fZFiVRK6fMN7/pouJSjZu+V6tmQUy1S7YLFlTBDSAPKzpUKlZ
	 +zs/tA95ifsUw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 517A960B08;
	Fri, 14 Aug 2026 22:44:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id D00B12B2
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 22:44:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B5EC960DC6
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 22:44:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kCbctGuM__ao for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 22:44:18 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::101; helo=mout-p-101.mailbox.org;
 envelope-from=marek.vasut@mailbox.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 6CF2F60A86
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6CF2F60A86
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6CF2F60A86
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 22:44:18 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4hMHN01x1xz8tc4;
 Sat, 15 Aug 2026 00:44:16 +0200 (CEST)
Message-ID: <08f0d251-6f85-434d-ba70-aaff2f70d73a@mailbox.org>
Date: Sat, 15 Aug 2026 00:23:56 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/8] board: schneider: rzn1-snarc: add rzn1.env
To: Ralph Siemsen <ralph.siemsen@linaro.org>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Udit Kumar <u-kumar1@ti.com>
References: <20260814-rzn1-2026-10-v2-0-56b6acef0439@linaro.org>
 <20260814-rzn1-2026-10-v2-2-56b6acef0439@linaro.org>
Content-Language: en-US
In-Reply-To: <20260814-rzn1-2026-10-v2-2-56b6acef0439@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: h6w583ygts5wpyy84g3izuirf5mkoimm
X-MBO-RS-ID: 01e6a5c3ea67a793c55
X-Rspamd-Queue-Id: 4hMHN01x1xz8tc4
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

On 8/14/26 8:38 PM, Ralph Siemsen wrote:
> Add default u-boot environment for Schneider RZ/N1 board:
> - Ethernet: default MAC addresses, use end1 interface
> - dfu_alt_info partitions for DFU
> - legacy bootargs
> 
> Signed-off-by: Ralph Siemsen <ralph.siemsen@linaro.org>
> ---
>   board/schneider/rzn1-snarc/rzn1.env | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
> 
> diff --git a/board/schneider/rzn1-snarc/rzn1.env b/board/schneider/rzn1-snarc/rzn1.env
> new file mode 100644
> index 00000000000..bc4f7e77b8f
> --- /dev/null
> +++ b/board/schneider/rzn1-snarc/rzn1.env
> @@ -0,0 +1,21 @@
> +ethaddr=00:00:0a:02:57:cd
> +eth1addr=00:00:0a:02:57:ce
> +ethact=end1
> +dfu_alt_info=
> +	sf 0:0=sf_fsbl raw 0 40000;
Use dfu mtd please , that is the future proofed replacement for dfu sf .
