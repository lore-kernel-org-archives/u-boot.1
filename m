Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327A3606A324
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 03:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=TSHlTo8l;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=MeSWcmBQ
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1760680DC9;
	Tue,  3 Nov 2026 03:35:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dyRxao0FnBcu; Tue,  3 Nov 2026 03:35:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 56C2D80DAE
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793676928;
	b=lZX7CXRkWO11tCyeOK0RQ9Se/7+uxJ2E0g5ce13Ltw/9PRnTqpE6o8m696RPNtuZSEH8
	 TCCmUqD2YZtnSlf8DNJPyBYOtGoyql2w94VsFvQvsFVSMiuLUqnRQZNAFn47J6s57JKpe
	 rR6KEfpCiCXigcjEvxNlyaLKT0Yq9Y3m+nNcxZnRSNKr42hBkTn68OPrkl0gNwldKCPKf
	 Qa3rtjdPRkjCYbdtHA4f7dfxkBL6dsghN6cqLZkc4CB1JwTN8e3VxPcrQXnXT95MgIw8+
	 153H0ESyUBDeFODYJi2Ix/aFQbu1R9Kdx/odUYcRjOY7zfJwAuFY06xwM8+vu6rm5Ww==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793676928;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=9UIkzZqMh2nm62BgmWPMVvKpnDdiKEfXlVo2FfUrtJ4=;
	b=hc00ZvBn68oMGa2KtIOJVdoCPe9U53wkyZIJcqOjlmjMGBBs68aIp8rqGtAK/NLjKgQD
	 V2KTOgIDrPWpt9ABtzoD5+saAKJHXSWLVU/A644m/oXhHDVF2U9Vf1hoDVqoOwBCROHma
	 CA1WChzR5CfL7PGTYb7X+1HqBzt+3+stD5YrZVrl6KL22+E7Wv18vJXvE/MgLLHs6c0RK
	 SjsnCb6JTYmKe/ZqjIf7+hSCFsDauyy/8hmI/ZGeCk4MmMAPnH7MGAvzhNFpMiDy7AIPK
	 pBVg8wcLx5hk12+I1y54XjK2wksGUoz2RF/2hE1HNQkmwksRhtzxo6edyTLf7PmdRaw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793676928;
	bh=9UIkzZqMh2nm62BgmWPMVvKpnDdiKEfXlVo2FfUrtJ4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TSHlTo8lKCIj4YqVIx5xdkFXL1/NyS5NCWgSZMp3w7R4jhyTft6LLgguzgE8uRxM+
	 /wxqQgn4vx3W6Ren+jqCAlZkjT/5jYYELnel+pYJ56HtJ6g888wrognFlk98LNwf+D
	 Rrm1+yZlqwtoamjg/dXfteh97kw9xoVqejTIlIhAI+PSQptTUiP3x9tvTy/+AO1Cro
	 HuxijBQINXoN4f01A/n+ZBaHR+QRbjY+gUagVDe7j4y3GfR94nF4sBKpX2Pc8jnlGk
	 sM9Gdkz1lSh/L25t3SX/gJF/kcn6DhwAZUMqjoAklsUjIgzZwOYGBTsazm6vqLvlgG
	 3j+iy2SLSUaHQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 56C2D80DAE;
	Tue,  3 Nov 2026 03:35:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 07E664BC
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 03:35:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D8DED404EE
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 03:35:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id e4Gkn_9tAL9s for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 03:35:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8370640400
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=80.241.56.161
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793676925;
 b=i8V0E3fE2d1SP2iWHnfGaa/i7TJABRIkoAGRmqzlKSC/WCzn5ZnF3eE6OZBXCAsIqEJI
 GcPXK06Lm1LQjxXeCraRrKd4jVGJjWp4IGGu7yPLpoOPT20/vfD+6LioAswQpkyOgfk2/
 VFyG3RR50cPijehr+XJBqmATh3YFs15A0xvsPHEMZrkA70aVj6fBcl/rUJ62AYo89EdM+
 rP4yGh/j1juwr1STse+N+ZzeEZmm+4oS394q8l90iwwnebnD+ENTcR1FNn/+fj2jXoY1p
 YvQc+WgxiPfynf4hNfjnJ3gxeZCw+/BLWm2arwHsGU/xto8LR20DPEatsmP0pybVr7Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793676925;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META;
 bh=9UIkzZqMh2nm62BgmWPMVvKpnDdiKEfXlVo2FfUrtJ4=;
 b=l7f8iD+bwsLu72Ju1Ne3Sx1oLXiHNRjoNvZ20+PG2ZfkmhnHao42oai1EN3wvKI8/Pck
 LTXA+9I3zFH4OMNgEls1tzxx1sUAqTMH3hDaTF9V8FZjYPKII89tU5bQAtGYmDSsigffH
 b39X9/XRSYxvSk8DC+70Y7iKJe4GRWDaafwFcmaiG41qR8qJjJLVRlpw8XAPz/IL994Ov
 cKpxii0E34ao9l70DJE1qJNIu2z5e2A13/LBSsWe8Nz5CLySpMXYHwVXUw/1J7DRokbsz
 iGfPxy6gWCea7vyX8vccMQoPYP67aGrK9BDkzp8QjPMBifCz1yziQj0sRIEcgpqWnag==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=mailbox.org;
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=MeSWcmBQ; 
 arc=none smtp.remote-ip=80.241.56.161
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.161;
 helo=mout-p-103.mailbox.org; envelope-from=marek.vasut@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=MeSWcmBQ
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8370640400
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 03:35:24 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4jJZ2x47XCzKnl2;
 Tue, 03 Nov 2026 04:35:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1793676921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9UIkzZqMh2nm62BgmWPMVvKpnDdiKEfXlVo2FfUrtJ4=;
 b=MeSWcmBQlcNUfcpUGIvWRLF/tADoEKv4fKBQmWsy+Ll7N9T8KRTMweZ0o6XfDa1me99uQ9
 S8asyn23wKiylNyk7bNxne/cI11cSjhck+HvitUANhGEWc2DQUVeyAdZcjsQhRbMxqnMU/
 SkHBf1VvLMK0xcrYzHOhyg0RJMjsKStUKxB3jQ6ttzwmEufTehDRHvUQg6vpVMv9OlkJvg
 M9ukLdUULgrCc4FP8IBlWdXex7x06VE2WrxZtmgEZfBBdikEC2NKZYIuFTum3KfPm+w25T
 335BUsWzsRtnW0wRg63xuYPKtPyQ+NbpEXkBI9WpTrElP3bWIBNcbYdeY/piqQ==
Message-ID: <6a7e2f00-3ff7-49e8-8211-bc05be2758f8@mailbox.org>
Date: Tue, 3 Nov 2026 04:35:19 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: dwc3: gadget: make Set Endpoint Configuration macros
 safe
To: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>,
 Marek Vasut <marek.vasut+usb@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 u-boot@lists.u-boot-project.org
Cc: Lukasz Majewski <lukma@nabladev.com>, Tom Rini <trini@konsulko.com>,
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>
References: <20261102-dwc3-depcfg-macros-v1-1-0def219ced9c@oss.qualcomm.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20261102-dwc3-depcfg-macros-v1-1-0def219ced9c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 51d39a921c33a9a6ab7
X-MBO-RS-META: 9wdxb3d19rxswz8nha5ygok79fbrjies
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/2/26 10:11 AM, Igor Opaniuk wrote:
> The DEPCFG field macros shift their argument without masking it, so an
> out-of-range value spills into the neighbouring fields. This happens
> on every SuperSpeed bulk endpoint: no gadget function sets
> usb_ep.maxburst, dwc3_gadget_set_ep_config() programs maxburst - 1 =
> 0xffffffff as the burst size, and DWC3_DEPCFG_BURST_SIZE() sets bits
> 31:22 of parameter 0 - the data sequence number and the configuration
> action as well as the burst size. The fastboot bulk-out endpoint, for
> example, is configured with parameter 0 0xffc02004 instead of
> 0x03c02004.
> 
> Mask each field to its width, as Linux does since commit 7369090a9fb5
> ("usb: dwc3: gadget: make Set Endpoint Configuration macros safe").
> A maxburst of 0 still yields the burst size of 16 the endpoints get
> today, so only the fields beyond the burst size change.
> 
> Fixes: 85d5e7075f33 ("usb: dwc3: add dwc3 folder from linux kernel to u-boot")
> Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
> ---
> Tested at SuperSpeed on QCM2290 (DWC3), host Linux 7.0, with fastboot
> and with the mass storage SuperSpeed support from u-boot-dfu next:
> parameter 0 of the bulk endpoints goes from 0xffc02004/0xffc22004 to
> 0x03c02004/0x03c22004, the burst size stays 16 and the throughput is
> unchanged (fastboot download of 100 MiB in 1.76 s).
Reviewed-by: Marek Vasut <marek.vasut+usb@mailbox.org>
