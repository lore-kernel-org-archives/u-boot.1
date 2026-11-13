Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACA7606A330
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 06:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=jUlPLSSd;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=lK4+gHC7
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 884DE81601;
	Fri, 13 Nov 2026 06:44:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id krKuKUlbME1z; Fri, 13 Nov 2026 06:44:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CE1E181586
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794552268;
	b=TITbN3rJfaDx9qZOlkqe9bCa8cM6rnBcouHLdQ1ch5HG2k0Ahg0Hcd+vTRhAMsIT7+KS
	 fSok8ymvnIijZiXUmNhsPRiJxrvl8ADIz1tovoVpDbYBg5jPoeW9MxOR1PhFocamY+StX
	 Cuq1GlfVyFUHr6NIxoiWie175VNc2FPbbFAA2a1movQ2CRFFLO/FWw4ShPd3mtYSsV2nH
	 gzDAncYtUd+a+1IucScks9WdnUnfgh/wnxL8RmJUqhseTdPCtgFiCR6DCkS7Et12MWD6r
	 ZPJagAmoGrJQlIWNQM7HLPpuh8rv3SwLKb9GvdBPTdOWmQqN9Z+pz19ln+jyAu+Xbhg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794552268;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=FtyXzdkcMAYemaTO2u5gQNOgovo/hM7oSB8TMYHGbOI=;
	b=BgbKN30yZMdW2K94vY6Dn84YF3h119wGP5IXX+KYrxu2lrClnMLzhGYty4w+5DdnLj0k
	 IAbcHxB0gM+G7WGjHDRkCG5cPWHhwSiZtVCQep0F9w8nn3hqBtyH6ZPXCia0MaqMV8EJv
	 lOTuSft5cvBkhFgntzeuS6rFizwJ33Uk8jbYNINcJjhGKJ6vG/ivlwmacNRWOWhylWNYg
	 otVznBpkm/c7ZgXyJV2GU5yP+akyP+HgLR//2yVTwKfssdJ8AYudxLWRU/0J7ZLue6fq2
	 /+0+wGfJhayBFfF6rqBpzEn1kH0HBVP64V+CCroRJkO0TFXS8AoIZncmU3a/zGYtnIQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794552267;
	bh=FtyXzdkcMAYemaTO2u5gQNOgovo/hM7oSB8TMYHGbOI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jUlPLSSdU1gTzXhsM/iK9cKqUg+vTPRs8bptpAfFgkkioSonpSQt3gP6IrvII7M1k
	 Au+xRB5SGvB+mbxHT+ldWPN0rg/VE6Q1JY1t2pFxpMCQKEhQK8LySs+Pk+3awObD9o
	 RRM6KPcB9LHmT38FRCTP7QRrG1ePb4S9oMD6HtNJUG2GtIMVvQlZDVxabkjvvC2E1c
	 uobTbN2NZ9JjZdbl0yjYOFvQmeteS9nUSW1QZFFLRAyX2RLrLCAH92+sHzudQzotyM
	 kW1IZyZir5hKZxwcSeV/1WUYakmL8vJQBzprzayYTcMyWtm0h5noea3STVOdj/YaeV
	 Rw6QbJNU5rtCA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CE1E181586;
	Fri, 13 Nov 2026 06:44:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7A9E9AF8
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 06:44:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 60D8E4007B
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 06:44:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IJc4wQAe6bxT for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 06:44:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 3D4B140060
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=80.241.56.171
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.171;
 helo=mout-p-201.mailbox.org; envelope-from=marek.vasut@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=lK4+gHC7
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3D4B140060
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 06:44:24 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4jQnmP1sSzzMlmX;
 Fri, 13 Nov 2026 07:44:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794552261;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FtyXzdkcMAYemaTO2u5gQNOgovo/hM7oSB8TMYHGbOI=;
 b=lK4+gHC7lQHCw7kPG94blr4jCR8Gua0QPihlzFANr+lvPJCiuKq+Vt+vt6l6lo2R6csPJw
 Fuwz+DoqgPqYd6ULACAfpRReVnTjiVr1W/qymfbem2Pe1aE24ceB3fZ6pQvgEcTekYcenP
 qMw/6XLrfOVl4rwPoqEgIucjlShGotKX3CzZCtZ20J13XEq+Odps3q0vvMLkx7KAmRnBiI
 eLYwHA9YNLLDXeo716HfwjL7hMwzAY7QxY3too99PtTQEyuS41887AM58aMa3GlaO90/2p
 A6ipoC2uz5QhDnpcT6V4i+wC4bRMfXMwiWP3GeWnU17XoMjBwRKG6lqoBf9rIA==
Message-ID: <1a972549-2593-40ca-bfd3-534dbac4ebd1@mailbox.org>
Date: Fri, 13 Nov 2026 04:45:17 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] usb: onboard-hub: Add support for VIA Labs VL817
To: Hung-Chun Tseng <alan.tseng.cs@gmail.com>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Yixun Lan <dlan@kernel.org>
Cc: Tom Rini <trini@konsulko.com>, Huan Zhou <pericycle.cc@gmail.com>,
 Eric Chung <eric.chung@riscstar.com>, Alexey Charkov <alchark@flipper.net>,
 Guodong Xu <docular.xu@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>,
 Zixian Zeng <sycamoremoon376@gmail.com>, u-boot-spacemit@groups.io,
 u-boot@lists.u-boot-project.org
References: <20261113031613.435429-1-alan.tseng.cs@gmail.com>
 <20261113031613.435429-2-alan.tseng.cs@gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20261113031613.435429-2-alan.tseng.cs@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: hai1t334zkaupmxoz8qwm6141qrpdb9i
X-MBO-RS-ID: 3c09af35db899a2bd0a
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

On 11/13/26 4:16 AM, Hung-Chun Tseng wrote:
> The VL817 is a USB 3.1 Gen 1 hub controller with one supply and a reset
> pin. Use the same reset time as Linux.
> 
> The Milk-V Jupiter and the Banana Pi BPI-F3 have one in front of all
> their USB ports. Without this, U-Boot leaves the hub unpowered and in
> reset, so no USB device is found.
> 
> Signed-off-by: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
> Tested-by: Zixian Zeng <sycamoremoon376@gmail.com> # Babanapi-F3

Reviewed-by: Marek Vasut <marek.vasut+usb@mailbox.org>
