Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 227D4C5DF85
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 03:55:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 500BA80C12;
	Thu, 20 Aug 2026 03:55:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 25KnVYiSdWtv; Thu, 20 Aug 2026 03:55:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787198125;
	bh=gKv+25glrLxl6iZ7QsyOXAwWdynfs6JoOe3llBFLoDM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=km5dgoxMAgSLbNR4PJEX0e0DQCLZW09ETnHFXecTiW3RkW3J/NIwukx5wPrXWKyCj
	 Nya8Xe485LW8U8k0aJtBOhVeoeiBOC5wCQOLRutZxIWFDLhD/g0Rz7BW9opNZCim7n
	 nepDkwJipDA7PHjWVpeMhepefIcWsPmBHLMaVJjr/t2xJ5J+fHUXPzXPFEVRaoV4eh
	 G7H11+mzswXWXj7LFed07Gydh9el0BntPZhhTPQ1jgtYrCY2+BPs1gTrTwSXqvJQf9
	 BegAz+MVd/Wpwqj13bGgAkYYcGCzF6GAwBE2q5fC7cn8HaTDDr+AoUNzI1+xhPcbjx
	 X9RhXKkJTHh8A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A75DD80BF0;
	Thu, 20 Aug 2026 03:55:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 83FA81EA4
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 03:55:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 66B4C6060E
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 03:55:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ESETiRrNQiyP for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 03:55:21 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.172;
 helo=mout-p-202.mailbox.org; envelope-from=marek.vasut@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=ovspDq5R
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5075860603
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 03:55:21 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hQV2Y6r5lzMlFt;
 Thu, 20 Aug 2026 05:55:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1787198117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gKv+25glrLxl6iZ7QsyOXAwWdynfs6JoOe3llBFLoDM=;
 b=ovspDq5RLKYIVTUzB8Cvn1ZD0XggRtV9W+eAwUq0e7A978j3MptOSdgeqjL2EGAG4Zv+zw
 eFtjzE0RHj6xVmEvqvz847/g7o0HsLnt/S8zl6a3HTdMeQ60pQHkB9vZYdKPE9qqo2Astl
 T2g7puuRDJAzMC0sP5Sq09L+MhH8ZlyfMVAKNZlD9fZ2XQYBqU/2qNd4ikLeE1WHofZh2J
 DmVmUCya5/1ffpf6lTPDANAt4DHzaOwRFdrI69APkqSChba4RTW2IcCDxOU7ldWflM43Ao
 o66u+m9fXJi6s4QChQKWuVSjRrkZGUi0Bj2Ea+XS98Ux7JIEmtDlhI8VezPaGQ==
Message-ID: <19a59fb4-b672-4afb-92a1-321b244a541e@mailbox.org>
Date: Wed, 19 Aug 2026 12:10:35 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 2/3] usb: ehci-vf: drop the empty bind hook
To: Mehmet Fide <mehmet.fide@gmail.com>, Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org,
 Mehmet Fide <mehmet.fide@screeningeagle.com>
References: <20260819093705.4143509-1-mehmet.fide@gmail.com>
 <20260819093705.4143509-3-mehmet.fide@gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260819093705.4143509-3-mehmet.fide@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: yj6qyunkr9ybogyccakwbn7hqajwi3ot
X-MBO-RS-ID: 59adb6cf69af410eda8
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

On 8/19/26 11:37 AM, Mehmet Fide wrote:
> From: Mehmet Fide <mehmet.fide@screeningeagle.com>
> 
> vf_usb_bind() only returns 0. Its comment describes a hack that keeps
> the second controller from taking sequence number 0, but no such code
> is there, and an empty .bind cannot influence the numbering the uclass
> does. Remove it.
This likely fixes these two commits:

0885cdb9d154 ("usb: host: ehci-vf: Migrate Vybrid USB to driver model")
b27347f425f7 ("usb: Update for new sequence numbers")
