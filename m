Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2FC6CA5FE0
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 09:52:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 422C080C9C;
	Fri,  2 Oct 2026 09:52:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lp5yBLSwis7z; Fri,  2 Oct 2026 09:52:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 849C980D66
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790934760;
	b=iG6yN2vaF8jSuGRJKUnp1lOE6HuPjJMW9O+pcDAG7GqJWJtrbcbxems3XYvIRHEsIp9Z
	 +omYHniVkSjXSLKc6YZ6EmQa7fjT7i9huy8e4Ln5o6vybtc9z9Yi1QYBMzgwspR3XWiXW
	 zNkJCA5HHOFkidBVmGIkTMY1pknXF7b2FiWT99BNqE34NXBAziT8kbHWP7D7r1gUGLain
	 O5G/mBCCoaXUvUY0xRDA94bAekjaLwvnEx6wdb0kX5IBe9fOhl3gV5tmdzpfUsciq5cZU
	 PHgqhff00tLISXaOTfDAEV53bCx9xk+0CuVF4FbJRAtyKdvt+zUkROctJEGNRTrQZUg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790934760;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:X-MBO-RS-META:
	 X-MBO-RS-ID:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=rVjxglnB23AdAHbCcF9bBo9ZLm3nWqNv0tsMDeav4PI=;
	b=MLLUUoCMVEJ+57YYDAW7qnUWF9DP4umpz7Hq7Ru4tRjSU7pLJd+Scy6ENxxr0X4a6pOe
	 Y8rRAZSeLgtZ7csluOlgKHKScLEPAt/CIv2kushnPpwYoIp0gbDtQWQGrMTNZ6SiNg6ja
	 +hJdlhKIkL8dYa8BLUQihmIVZthfg+JwBxjeV+n1FmPE6ZmVXbzQZGXiFJPB2hQsRpzJq
	 V9ZnxBmcUfhgJ/TbMqkVz8l6zS8OstXoum6wjxlw1eVv9XvgB9gD9zx1cCMCO7p37AXEJ
	 5eIQVSnSXQm1goEci5F/y28Gpjw9hbsveFNH3TxMv4QVtDS2zqHg4qYDYGGAtcn1kSQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790934760;
	bh=rVjxglnB23AdAHbCcF9bBo9ZLm3nWqNv0tsMDeav4PI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Qoh6hCuPFRbkw4q63qz9SROE0qzOzPkBB24msPBkjkr8h1t8RMbIGk46X/ifm/Rlc
	 du5VeZWv/QylJjZrhkIKx3QDK/g5j/otTDFrg5xXIQL4FphBnmJXJtVH166ynHGiAr
	 TjzIqwmStzGP7TVkUnpf+OYeCXbjyV0Hvq9kBLvIFX1JYH+Dfw1SzJ0KC7WYW8Uibs
	 oHx9R0H9P0e7PoOtJFs6CYuGCRuX0ZyAZyjLbitapqsNj0Z9GsLD6WPFIQ5P5KkCs6
	 CB7R6ZTanQUu2F+hp4RDeM7bKwdDPBU7BQ/F25X0pO/DdDctwO4I3skIneIuroX6yq
	 w2dbeygwzMrag==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 849C980D66;
	Fri,  2 Oct 2026 09:52:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 35243282
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 09:52:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1A88F60653
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 09:52:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pxOLorB5kn6E for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 09:52:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 4401560645
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::103"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790934758;
 b=ZEWdfmDGT/symimyua74hapIs4TVr0YHE3fL8bc3m5lKGwu1YUCkQD5ueqmwfCta+nyy
 OYupzwy+3Py9tVZ0pSPIquOcRZR9cSynRczIoOcWUaU0WtvTyY5rAeTu2Ixp9OmWsKWl+
 CA82ABx/qtbu6hkRt+fHcKAuyDUX1RyCjNOUm+Diu0DewmtifT2ITPbnEu60FQFGEUM5x
 HweKKD+kqiJk85rkjZYpBCBgSE6HTMn6njGnPCYKm9cw8dt+RYOeyHw9PiSwgdAfnbZ/h
 EO9mdC+JaFZt8r/U3tkj6HOnBJx0pYp6uJZwxPVQv6dcR7i3Jr1b3YHwmb5m2Wohsaw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790934758;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID;
 bh=rVjxglnB23AdAHbCcF9bBo9ZLm3nWqNv0tsMDeav4PI=;
 b=jILsEjOEnbIv5iDW+DwAiDnbGU3BQDNTSFQLYGq2wJg+U4/6+T3wFispvEUHZhCc1xpR
 auwTyTZDMjW/22vs0SBDejDBrqdCPna5faokd2UfvGFVMir+R5j5md63wic9jMMnpkVkE
 tqjI0HWEY/VbmFSsShk0Xqq23L/xEpmlVLEO/vm39AyZfmwOXMeGEtP+W2o8v970n8h/s
 xNdL2MGsy3ib9GxKDXbeTYneHwvJUokf3jAMh5sw7DzOE0e72Q00YCM5k2iPOPAczAnu2
 vlrgGbFDQ+iALH3J7SUMVVkVyN55eyxFBnWSag7QiuSU+nMGqEemCxi+cUijCl1qplA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=mailbox.org; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=OLw93T4F; 
 arc=none smtp.remote-ip="2001:67c:2050:0:465::103"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::103; helo=mout-p-103.mailbox.org;
 envelope-from=stefan.roese@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=OLw93T4F
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4401560645
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 09:52:37 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4hx3wx3QqbzKmcl;
 Fri, 02 Oct 2026 11:52:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1790934753;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rVjxglnB23AdAHbCcF9bBo9ZLm3nWqNv0tsMDeav4PI=;
 b=OLw93T4FARU7w1XGd3O8hFA/c5h0Cdz0001q3nZqKpMdVShU7AlmRa36WFhlrj0RrAbzgZ
 mIl+wC/DraF3exR6ZX5AtldSsfS96eCa5no746CkUJhoBMP+lZqMTC568JTR4q9ctRA9at
 i+VVutbeis9bpPDzG2eB5+b9j07BjBMsvIu3700INabiU1VrrgO2f4fZgHZ4kWcZZiWeIs
 dX+Z05QwQAjmgfILAK7XdQLzWae9lis/4HFyjaIQCk15NrGtR+LdKCofds0phZnw+8jagl
 Y24e7lt44ikrhdIBhxmDllIJDcRdCw52hxO0pdYVu5sb1NleJ9i/PKBPwyk5Ew==
From: Stefan Roese <stefan.roese@mailbox.org>
To: Juuso Rinta <juuso.rinta@nokia.com>
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 aaro.koskinen@nokia.com, antonio.borneo@foss.st.com, me@ziyao.cc,
 patrice.chotard@foss.st.com, peng.fan@nxp.com
Subject: Re: [PATCH v3 0/6] watchdog: report effective timeout
Date: Fri,  2 Oct 2026 11:52:25 +0200
Message-ID: <20261002095228.2322791-2-stefan.roese@mailbox.org>
In-Reply-To: <20260824043536.2004812-1-juuso.rinta@nokia.com>
References: <20260818-rinta-watchdog-gettime-v3-0-423f5caf526d@nokia.com>
 <20260823071511.687900-1-stefan.roese@mailbox.org>
 <20260824043536.2004812-1-juuso.rinta@nokia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: shicj5y96bi8qsftn8yfajfko9td71r6
X-MBO-RS-ID: 55ad453b54f77829cab
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

Hi Juuso,

On 24.08.26 06:35, juuso.rinta@nokia.com wrote:
> Sounds good. To clarify on the next steps: the follow-up will be a
> separate series on top of v3. It adds a get_timeout() operation
> that is called after ops->start(), and uses that value in the print
> when the driver implements it. Otherwise, keep the v3 behaviour.

Good, looking forward to it.

I'll take v3 into next now, with Simon's v2 tags on 3/6, 4/6 and 5/6
as discussed. For the whole series:

Reviewed-by: Stefan Roese <stefan.roese@mailbox.org>

Thanks,
Stefan
