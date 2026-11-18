Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7D8606A31C
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 08:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ondloc8x;
	dkim=pass (2048-bit key, unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=RgS1fSKH
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 74CEF6081D;
	Wed, 18 Nov 2026 08:08:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CE_keVpmTUKF; Wed, 18 Nov 2026 08:08:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9E0306084B
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794989295;
	b=H+/SxqOIBnT1i/LG6qpAXkP7Jd7H1RNEunbeyLYEC3MLL77bPy+nfB6uklyckJdmM3FN
	 9Vwfk4SoyrccUZbWAsUu5oV/lP/WDbvd8Cbkr6tDB7DWIBYu4xPrJGrK6/zpUKJR5dDRX
	 8cOOy9zAEz9YhHAEkhZzbGF+UL9gwyXjbar0iJ/vQVRY3LBw5n4pw57ZhSfPJ9yR961Kb
	 Qk0cp6/4Hf4P6hXp7QP7imn5RJNl2HrU43elf0cq6DsB70n1977lzi+8zP7EDdoeM/fTq
	 PLCO53FQrJte9fXtj0/P3dI3rt9Hots1as2pkOitKMafweClGZ1VJUolP6GY8fde5KQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794989295;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 Content-Language:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=xR6DM66XjFzYSSLTgogjGibN94GTElUrMzc+ytoqgCc=;
	b=IYi8vQeyAtoN8hPLDnpcUnVwcxi15QD+xp8CQ8FoclaA9rseRPLQmbs9cActOCcGx1Fi
	 TBSvUVrdvz/M4W4HEooP1JDQAQ1JJvb54heX5r77xdC3AAsqvnfnmnoxrMo1Lb+PGb0h5
	 LQUMyedZCr2EFCqGPs67iWiQIEGevYtDLITxApfiD4Q6IGvaqUxFiMBGx92KrwBciQ/Pd
	 PU5SxcVkYZEwuKpgIzVhZ9z/6G1j+GjFMbpQEKHNsgWS5OQI3cMU9gBdXA/vSU/vS2HoI
	 PyIhXeGjGuy2Usb3FB5FSkN9ziEyRInSYBx4UdcYX+UwN5vrcFTEulbeY51ES9Xza1Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=nabladev.com;
	dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=RgS1fSKH;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794989295;
	bh=xR6DM66XjFzYSSLTgogjGibN94GTElUrMzc+ytoqgCc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ondloc8xi9cS62mz/E+oa1A2i0/xUfbLBXHxGJZ+fC33Jgg1MuOnrKQZwCdBbonRC
	 4pDC4DXIIy+N0+++/WQbsFovIZHYHDCe79tHq0Hv2WhMQIenBwbFJqvgxZTL5YKwZ6
	 PqEGTHP2Ge8PoXvWcSTEEjaLv/Zs1hXWHTGpl3GNMlq6hIP0Tcn+VP+IuOWWsfsUy4
	 eh1P6aEAbI4V+5sHD3F3uNeI6rP5OyLLarrk+flGOTpx6ogNTq9B1jBbOEvQdfAhZf
	 otYwimlut6AOUQazfVbm748GTPGGcriz+Y5/LvcwtfQvSH2fLQaE+got1JiACB/HMM
	 EFWqoPK4MdDmw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9E0306084B;
	Wed, 18 Nov 2026 08:08:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 581F31E7
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 08:08:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3E5166084B
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 08:08:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ow6SXmBWPLi1 for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 08:08:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org EFB9A6081D
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:f820:417:0:178:251:229:89; helo=mx.nabladev.com;
 envelope-from=hs@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=RgS1fSKH
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EFB9A6081D
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 08:08:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id B1F6810F8F8; Wed, 18 Nov 2026 09:08:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1794989285;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=xR6DM66XjFzYSSLTgogjGibN94GTElUrMzc+ytoqgCc=;
 b=RgS1fSKHGs0JJHrq0YJ4y+/YsDL7/FKpHRXG9Bi5AIwjxeSkfzosGNb2pOWDJsKOkfKcbw
 Qp4UKE8aS3VhBvQt4Q++kqr81Wn4P5qwWcxbxfPHou8myA/qB3t53sSZk4u8SCVmF23YG6
 u0lfCLnQwKi+0yFPbg2vLGFQjcQ92c7nkwpBCd+J+OPDlByT5eURW+AL2w6SW5bIyRV7ZG
 b3RYh6dLlIEanzqXDtzRmeKl+0rA1h3DuaeqAcNxz0+hwqUxZ/RlBdwIvX9pn03RCMdEqB
 uhZwuA6mciD2+Gp9c5WM7+x7qObpXHYJMh71r570becvGb6mvf9Gzl5uvyTgaw==
Message-ID: <dbe6b314-bba3-df1b-caff-349f1baf3237@nabladev.com>
Date: Wed, 18 Nov 2026 09:08:02 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] i2c: stm32f7: Fix zero-length transfers used by i2c probe
Content-Language: en-US
To: Frieder Schrempf <frieder@fris.de>, u-boot@lists.u-boot-project.org,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Tom Rini <trini@konsulko.com>, uboot-stm32@st-md-mailman.stormreply.com
Cc: Petar Krstov <petar.krstov@kontron.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Alain Volmat <alain.volmat@foss.st.com>
References: <20261117093726.582644-1-frieder@fris.de>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <20261117093726.582644-1-frieder@fris.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello Frieder,

On 17.11.26 10:37, Frieder Schrempf wrote:
> From: Petar Krstov <petar.krstov@kontron.com>
> 
> Zero-length messages (e.g. i2c probe) skip the data loop entirely,
> so the driver never waits for the address phase to complete before
> handling STOP/NACK. Add an explicit wait for TC/NACKF/errors in
> the zero-length case and initialize status to avoid using it
> uninitialized.
> 
> Fixes: 3bf699f7a8c6 ("i2c: stm32: do not set the STOP condition on error")
> Signed-off-by: Petar Krstov <petar.krstov@kontron.com>
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> ---
> Cc: Heiko Schocher <hs@nabladev.com>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: uboot-stm32@st-md-mailman.stormreply.com
> Cc: u-boot@lists.u-boot-project.org
> ---
>   drivers/i2c/stm32f7_i2c.c | 17 ++++++++++++++++-
>   1 file changed, 16 insertions(+), 1 deletion(-)

Reviewed-by: Heiko Schocher <hs@nabladev.com>

bye,
Heiko
-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
