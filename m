Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A2A606A31C
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 07:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=tAWdIsPJ;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=KYSyofRF
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 186C880F19;
	Mon,  9 Nov 2026 07:08:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dp4ihYUWUK6i; Mon,  9 Nov 2026 07:08:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 04DB280F1B
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794208107;
	b=EpcgQWCCCxntGH4wLXUlUTw99Wc68NG/5zdthoks9Bp7mYDxoB1JdzwIWC+6dpw/MQeq
	 SxqTbNuvZx2aCY/3RDg+ZOyaWOSJod46OGBGTQvnOyvIO7K8Ol7i7W6dLwamz9TNQw61s
	 Gz4UKo2MVWH5xvG+1zg7WNduNEmkNOAzKxHbyJIXG4hKLnQSqcYCz6E09mv7h6tpEnd/h
	 OtH8dQLhlh3VDxtRJz5XNVsVOQ3crYTEtE+azxOaK2MFpM6hdq9TvykLVlImTlTN1RtDC
	 FuCbCDGBJOY7V2Oi/77hIs15F+u45V3RFc+toSwiPvaWX02kFaZCe1cY5CfwMqX+rqg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794208107;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=qLjeMP4xxwGPkDv2ndLN4iIJGtlajq86O2jJuP89B/w=;
	b=S/0QOBlTtVjh46knykfrFEYTN4Xhl9WEYhd3Y46wreGvTMXJ8KTdpcbhB3bPM+aayOpy
	 bX7zEMhUVqQ4q9SggwHJ437pTUFPodgp1gjoKd/smdHhPZR0BdkIwOnEgTlq+kYnnsGu7
	 /VLr4cTnlFwimIg5NhKEfEGDXBisWmjKRhfSQgxo//RkcYLBU/GkzQb5EUyOG2MRzTOj8
	 8bPuzCoOcIo5Z52KcztaZByXu79sFI1E9889AEtV5J66cRjkD825LSVGFA2Lw0yCRpjF/
	 ct7XiHjGO6zfxAkAkmQDrP05dtI92okQGpPPx8ksHv4z7g4Gs3BEX8W3aaA3FRWVMGg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=KYSyofRF;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794208107;
	bh=qLjeMP4xxwGPkDv2ndLN4iIJGtlajq86O2jJuP89B/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tAWdIsPJmNJHuKLoyWby9+GwCqljdtLbugLGaG48mVW3HLlccrtw1hIdGItd5owPi
	 oBXIt1UMBD8rtdve1wlU5+79dnLL0B+CwKL4zp+2xGOTU6udkcM+YRLAYct9VKXoxj
	 mCxbFpMdtUZ+w4YH5ZnFBVXJ1rL2tfSuUXA/UaArMucUku5tn63NVbTA/a3Tjfl9R6
	 toO0sPM+kleYRcf0ux0C5IloqntFHnu8oXQqHvub8/derprin1wlAbKiobrrek5tgz
	 feQpXEXVuuU6ixc4AzGUBWptO794awAHa6l55jxRFjjexUrCCMDLiXbEHfcxSwe2Ux
	 ix+8YUc/yMwOA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 04DB280F1B;
	Mon,  9 Nov 2026 07:08:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 29ECF111
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 07:08:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1BEBA80F1D
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 07:08:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vVpif7bXjfWa for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 07:08:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 503AD80F1B
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=80.241.56.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.172;
 helo=mout-p-202.mailbox.org; envelope-from=stefan.roese@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=KYSyofRF
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 503AD80F1B
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 07:08:23 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4jNLTw0WRVzMlGh;
 Mon, 09 Nov 2026 08:08:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794208100;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qLjeMP4xxwGPkDv2ndLN4iIJGtlajq86O2jJuP89B/w=;
 b=KYSyofRF2y3/GAmZunOggsGxnncZIN+83RA4q7c+qU9/Y0BpkdLmcRhuR6ZBGjqriWjFiv
 USe5ijB19bty/fuAwIkT1EWle4MxqBBi2Lr+zE7BjQsn4wuSgcDMzLIlzhK8Eps8TXbN7n
 5Sc+mJTBEt318yn8vOTx4PSdHG8lHXNSwfXI4LhrmXq50ooMNIMFPH7ibruISUwUcks63r
 0YvE7fP+Z1pjxLqOjZ8zWillzxLt7WyVu97AQWV6nYABQf4md7tfHeiALQ2mMdiLepvNvE
 tcX/RoNF0r7OtXL07d4tK+PEuf7nGEGg5bAGEyh2JzUNaQ0K2u+Pr+lekprUTA==
From: Stefan Roese <stefan.roese@mailbox.org>
To: Ozan Durgut <ozndrgt@gmail.com>
Cc: Greg Malysa <malysagreg@gmail.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 U-Boot Mailing List <u-boot@lists.u-boot-project.org>, linux@analog.com,
 Tom Rini <trini@konsulko.com>, Utsav Agarwal <utsav.agarwal@analog.com>,
 Ozan Durgut <ozan.durgut@analog.com>
Subject: Re: [PATCH v2] watchdog: adi_wdt: get SEC fault source ID from DT
Date: Mon,  9 Nov 2026 08:08:16 +0100
Message-ID: <20261109070818.1546408-1-stefan.roese@mailbox.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20260730190256.114708-1-ozndrgt@gmail.com>
References: <20260730163621.83050-1-ozndrgt@gmail.com>
 <20260730190256.114708-1-ozndrgt@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 35d1f31856ffdc82a36
X-MBO-RS-META: j8yfk19754gwhgwwtuaajbkp1acfc6gg
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Ozan,

On 30.07.26 21:02, Ozan Durgut wrote:
> From: UtsavAgarwalADI <utsav.agarwal@analog.com>
>
> The ADI watchdog drives a reset through a Security (SEC) controller
> fault source. The source index was hardcoded to 3 in adi_wdt_start(),
> which is only correct for the SC5xx parts that happen to use that
> index; other ADI SoCs map WDOG0 to a different SEC fault source.
>
> Read the index from a new "adi,secid" device tree property so boards
> that route the watchdog fault to a different SEC source can configure
> it. The property is required; if it is absent the driver prints a
> diagnostic and fails to probe, which makes a stale device tree from
> before this change easy to spot.
>
> Set adi,secid = <3> in the SC57x, SC58x, SC594 and SC598 device trees
> to match the value they relied on before.
>
> Co-developed-by: Ozan Durgut <ozan.durgut@analog.com>
> Signed-off-by: Ozan Durgut <ozan.durgut@analog.com>
> Signed-off-by: UtsavAgarwalADI <utsav.agarwal@analog.com>

Sorry for the long delay on this one.

Reviewed-by: Stefan Roese <stefan.roese@mailbox.org>

Thanks,
Stefan
