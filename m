Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E05EE77188
	for <u-boot@archiver.kernel.org>; Sat,  4 Jan 2025 01:22:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D917680295;
	Sat,  4 Jan 2025 02:22:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="JHgTSAy8";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="r1PQZVxt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF8CB8034E; Sat,  4 Jan 2025 02:22:41 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93A698007D
 for <u-boot@lists.denx.de>; Sat,  4 Jan 2025 02:22:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4YQ2k71MQcz9smK;
 Sat,  4 Jan 2025 02:22:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1735953759;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lo7AlV96j6e4+tFC/5olvK6YxF5BSPqPU5ikI7cLbAI=;
 b=JHgTSAy8gcs0pNbo2+5bP/vfvnqQNGwWls5pUIUBSFCWAXFuarjFMVEJrIO3RLliOwjPmf
 kVezN+claQY1w0t6YlBtT/a5WhFMMVIeVduaVCmHmr3fQC5dhdL8OXQNqmfglQiJvIPVaP
 yi5U24aD//olmuJFizCeMK5+9HtOYuUaf1akea8jmYzauMjxefkIwlCA6QXiYzRTWGhoVA
 7yFLFQVzJylVS/Lbe1DJgrOT6GRNFQp63IRO2iKfdMsZ7ObBpBtT6Getsf5QfHHLkxUggt
 12AH1lnmKvIyZVk1j7CqOfDc4/+KLC3No/dMUqQEGWN8vneX/BWZK5+kbWbhuA==
Message-ID: <f1e4c012-4f96-4609-a4a7-6908581cf04c@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1735953757;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lo7AlV96j6e4+tFC/5olvK6YxF5BSPqPU5ikI7cLbAI=;
 b=r1PQZVxtv1fKK4/EyTujvMpua4+OpG7TGZmBub37sCbeW2czdUQzvmrr9DpNcaWC4KcPde
 8z1jB4hhooT/IyeLNr5cFpeGXZY9PwI+OnJ5xoZLwaIwENpuP53JXLeRWvSCdY5zVLrbGZ
 G6LeBRW3J/+TbYf43rTB9wZ4aQSDIPY8K2LP2e3XdBCZOE9sT8iPQaUOAFdosU2RvrYH2Y
 5KI9GsvPkEsPgc/u5dNfGakkHTCpiLIYhk3iaxccQQJVkbPTTrQeWFK2hqbUwyKn0NAWB+
 AxAp5a+XtZsfnN3lamlGtlPVViqfiQMsbwIGFcgwzorN8FcqqhmCrPvTrdfRAA==
Date: Sat, 4 Jan 2025 02:22:35 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] fs: eliminate YAFFS2 implementation
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de
References: <20250104003402.8863-1-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250104003402.8863-1-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 8361176f605fdf09739
X-MBO-RS-META: 7463w1n3xemq8zx63ku9so1jbco6raez
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

On 1/4/25 1:34 AM, Heinrich Schuchardt wrote:
> Upstream development stopped 2012.
> Linux eliminated YAFFS2 in 2010.
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
