Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 387A9C5B572
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 23:59:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 70DE280C6A;
	Mon, 17 Aug 2026 23:59:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PVCQABoYIr5E; Mon, 17 Aug 2026 23:59:14 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2372080B53
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1787011154;
	bh=KjYKoHNb+tB5SAn5RGrldgjmGJ/b79XIaWze+pZovE4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PIWdKKFtM3Tz2OrinX6HTLuOJPI7mqwWJPExRhUOdRhRMqzmj5XQ6uuRVXagPwchL
	 2J/sG5Wgq4MF82rE6pCrona+5jScOVqvyJ5KRSoPBEK1e5NBlHa2u733CsCZsUDxqe
	 zYQfahG8LKBZadwbKF+pCEn0mu+QS9qBxy31ogXoSUUICb+fHg6F+8VuyT1Pu2vr11
	 Lk9vpg605oCVckrPQd6GBVGf7woqgEbWYEfF7RATm/fbmOCxj8IKZtzvuTbsZjgdt2
	 D1v8hHY3YPFWTrHRnPVe82ma3aQSQeCnTlSQ0/EnSlWQIwCkTNpd9GHTPkDYr/P/zd
	 8h5yIBmCu+Lcw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2372080B53;
	Mon, 17 Aug 2026 23:59:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2C251147
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 23:59:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1E8F04008B
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 23:59:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EC7hZ0Y1ZNMo for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 23:59:12 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::202; helo=mout-p-202.mailbox.org;
 envelope-from=marek.vasut@mailbox.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 2B2D74005E
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2B2D74005E
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mailbox.org
 header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812
 header.b=v8pfv3/J; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=QnB8rbZ4
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2B2D74005E
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 23:59:11 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hP8v11wvVzMlLG;
 Tue, 18 Aug 2026 01:59:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1787011149;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KjYKoHNb+tB5SAn5RGrldgjmGJ/b79XIaWze+pZovE4=;
 b=v8pfv3/Jvz9dLzEOrmKey7CW9/vXXpYdCC59reJ3fVbOB7m7bPUm+f34DzHztASPI96//Z
 FU/3Y9DWuF/poHa4FmUHzx/OTEP3uQ6/a4qWK2rPESeRgCRXKGCCvxSuy3Rb/IbbKIm139
 va5N9xr/u4cGuSU0uXUVeAUV4TGyVL77aut0ml2w7ctAs8CVzJof3aqDXm1JImqffZdbhN
 GeJfX5+pIfqH+zN4bef/oa0XAop3k6CiaPwh5eIv/ruRTKJykoIJFWmXe9mYL5XTb6zBTl
 qMNFQpNIZJNVzwE0UQ9lRF5UVwT7uVMAAmeSQYg3tSMFOuYSJ1hSDLPIfso18g==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=QnB8rbZ4;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <8027af57-95e2-42b6-af7e-fe0bfac6a54e@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1787011148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KjYKoHNb+tB5SAn5RGrldgjmGJ/b79XIaWze+pZovE4=;
 b=QnB8rbZ4SlgjD0hSlpj4j37bttWak1eWQ2+LVx2C1/ANOGLkZWOVJXW0dAH6FpFCfz3fS2
 fpHoGFSXOkD1STeifgesqOywSsf3UbfZItROzdqlOPe6hV7C7tL/uq818OwGJdJSNpu385
 6PKHJA8hFCV2XC4cUDw5Z/a4g0pdI1tfHoQQPjE+s0gITW25/+lSw3FzxTDfiyoK64bAJV
 CjR39esgvG+ZiuP05+rx2GXZpeKjljRgVT6pmBK8uMexoJShRltQeSrSi1eq4BcXv5wfuZ
 6sgvO57EEMxZbqqcT8DR1/3bE6OTxvXMLhWPeuVWNrFnzLZmV7i67+Q9SHCTKQ==
Date: Tue, 18 Aug 2026 00:45:05 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] usb: gadget: f_mass_storage: Remove useless rc
 variable
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 u-boot@lists.u-boot-project.org
Cc: Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Tom Rini <trini@konsulko.com>
References: <20260817-move_schedule_inside_sleep_thread-v1-0-0023194e8c47@foss.st.com>
 <20260817-move_schedule_inside_sleep_thread-v1-1-0023194e8c47@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260817-move_schedule_inside_sleep_thread-v1-1-0023194e8c47@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: oncfcs6khghp57qwgju9ksaokejmkx36
X-MBO-RS-ID: 2a77a22286a8002952f
X-Rspamd-Queue-Id: 4hP8v11wvVzMlLG
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

On 8/17/26 5:41 PM, Patrice Chotard wrote:
> rc variable is used as sleep_thread() return value.
> It's initialized to 0 and never updated inside sleep_thread(),
> remove it and return 0.
> 
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>

Reviewed-by: Marek Vasut <marek.vasut+usb@mailbox.org>
