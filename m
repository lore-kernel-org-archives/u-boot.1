Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D90DCC5B572
	for <u-boot@archiver.kernel.org>; Sun, 16 Aug 2026 23:44:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4AD35606B4;
	Sun, 16 Aug 2026 23:44:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CTcpK3G1hUf6; Sun, 16 Aug 2026 23:44:40 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0C27C60645
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786923880;
	bh=QMDIlS7HH/6oXjKuo6Iu9/SLlnLvH3DfMVbSIf0E1QE=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=0hpRkjNCBGdxajgjjVnOfO6zUgHdgYnjZN/WxH7G83bfqewQa+Kbj1v9B53UG8hhR
	 axf2ZZ7HZSQj7veKxJwXrKe75f1WjqXbPcEaw1t3lJO3VFDDlXMC8tb4DFFI51vHUG
	 nN6hExCdgtYSVGzR+e6KWpk9KDTLuEDmoJQ2UYlLQjqlZ4h1Cb7uORT9h9r+af8d+k
	 tN21qadzT1PAR8FQvecs1wveLeze8mG0b+afkJiDL654pU+XTjEDc+oZX+WKCIfco7
	 aesdVIn8cy62Szgry7r6RwAmciqknowd6sUte0CWQrCJZYWma4dhzWu2n3f1JsUti1
	 f6MRHUKbCEh/A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0C27C60645;
	Sun, 16 Aug 2026 23:44:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0C28A147
 for <u-boot@lists.u-boot-project.org>; Sun, 16 Aug 2026 23:44:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B891380BE0
 for <u-boot@lists.u-boot-project.org>; Sun, 16 Aug 2026 23:44:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cvgeRGWPDSa9 for <u-boot@lists.u-boot-project.org>;
 Sun, 16 Aug 2026 23:44:38 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::201; helo=mout-p-201.mailbox.org;
 envelope-from=marek.vasut@mailbox.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org EC93E80B42
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EC93E80B42
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EC93E80B42
 for <u-boot@lists.u-boot-project.org>; Sun, 16 Aug 2026 23:44:37 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hNXcg2pWKzMlFV;
 Mon, 17 Aug 2026 01:44:35 +0200 (CEST)
Message-ID: <429a5b6b-cffe-4ab5-ba22-8e985c1c3a1e@mailbox.org>
Date: Sun, 16 Aug 2026 13:25:09 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 5/8] ARM: dts: r9a06g032: sync with upstream
To: Ralph Siemsen <ralph.siemsen@linaro.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Udit Kumar <u-kumar1@ti.com>
References: <20260814-rzn1-2026-10-v2-0-56b6acef0439@linaro.org>
 <20260814-rzn1-2026-10-v2-5-56b6acef0439@linaro.org>
 <ab4604be-aba8-4193-97b3-cc997ea05861@mailbox.org>
 <aoBalbRFgBNJqZAV@maple.netwinder.org>
Content-Language: en-US
In-Reply-To: <aoBalbRFgBNJqZAV@maple.netwinder.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: e549ycwhnfzj76w8p7ny6yk6pwoes4js
X-MBO-RS-ID: 1ff74276f48051e483e
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

On 8/15/26 2:24 PM, Ralph Siemsen wrote:
> On Sat, Aug 15, 2026 at 12:26:16AM +0200, Marek Vasut wrote:
>>> ---
>>>  arch/arm/dts/r9a06g032.dtsi | 270 ++++++++++++++++++++++++++++++++++ 
>>> +++++++---
>> Can you use dts/upstream/src/arm/renesas/r9a06g032.dtsi instead ?
>>
>> Can you switch to OF_UPSTREAM ?
> 
> Almost, but not quite yet. The upstream version is missing the QSPI 
> node, which just got added in the kernel side. So once that gets synced 
> into U-boot then we can switch.
Can you put the missing bits into -u-boot.dtsi ?
