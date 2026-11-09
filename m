Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0B0606A326
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 17:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=w4NemJcZ;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=iN1L2+Fk
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7A94C8109E;
	Mon,  9 Nov 2026 17:29:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M-BDMGVunTNi; Mon,  9 Nov 2026 17:29:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CDCB1810AE
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794245394;
	b=sNhqG5PNPEDLGrXL+LvRk9oMjT76EV4ylcpqfboED4izlSXJFglmGYp32jIevoLibi2X
	 OrdQxnTDWsDjP6SsWjZdjfIOZK/c0upGiAIZ5Xo3sq64e9HxiAIPizytBZkL2AI0z4NS1
	 0t7RWFI61qrLBbJaDkosKyACYtYvByS08JKukvbSRCp3VnVCaY6OuByxzVlcolj0Vaev/
	 v5ETuar/1Vng7enrmYjzy6JXQ5LGm5BaCp5a3g5McqemLr9takp8aQdF9AQKnfx3TacQx
	 xqW0zCJ6/XwBn+GllQoixt5kv6EUCSJXGAqZUPWtU4PpU2/darEvbU0YKWUmYgo1ehQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794245394;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=LAk32CEywAF9vqELrihdKwa5w3cWytAbnM1cno6jElA=;
	b=hRQ5mtYNaN8pJ7MUNDQlHlMlUniTTZMtCPmwlLbNX/LKqVz+HjOpKqIwWvR4bo+6jEbz
	 +t2XTkiOxwYW/SuN28tT3Y2U7u1ZtRMJb7q1BvErOI7U00cgP6O54BKh370Jf3jXVF3e7
	 czkG5PYRZnt55u9BiWdES9qpCEJFx7IVpNF2u/gMhLJrgNWQhYc4T8KltmBcFCU41aA92
	 nQj7c4AKxtyxoANc5X1KyEukODHZIg0h1L2+rHp3M3AKIXdnOWNiCBtOw233vxdF6VgKz
	 H+wYCdXXucnmAnwtHOic3RsLTZKG6zy5azbAWQFtFWNCZEsbrSLEZRZ/XyaY4buftMQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794245394;
	bh=LAk32CEywAF9vqELrihdKwa5w3cWytAbnM1cno6jElA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=w4NemJcZzZsu50pTxTiqpPJ/eDfV9k/BJccUxToVCVVo5tm2LkIvgVtPjzLeDPFsV
	 tMhe1xgmytIylHwiIjVLk28v4YQxZVS7YBIWpAri+/2QOqD/FhcGFuNcP7EgNjhvQs
	 ZdZWGDMHbsJqcgMz/2lR15pzMW64a9btWJ72YfimeTPVsRpCauIMDiKPAyXLbHst5C
	 +w9gW87eookrRgRpLLhBUR+O4JEVNoVOefI430atGqQG2uRnwImaLSb93pzlacdcKu
	 Hr+N9dcC2w0SiSuye3Zg5j0qXUB/ONPPlfkM5np5nuDWObv1xsuqWpHG0/mx4XfLvb
	 Z87ly6V8g86Qg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CDCB1810AE;
	Mon,  9 Nov 2026 17:29:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6DD3B971
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 17:29:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5FB8140769
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 17:29:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vEF3C9EXej6s for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 17:29:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C024840756
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::333"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::333; helo=mail-ot1-x333.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=iN1L2+Fk
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C024840756
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 17:29:51 +0000 (UTC)
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-85f39332862so458632a34.3
 for <u-boot@lists.u-boot-project.org>; Mon, 09 Nov 2026 09:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794245390; x=1794850190;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LAk32CEywAF9vqELrihdKwa5w3cWytAbnM1cno6jElA=;
 b=iN1L2+FkcT3Zam29oI++JnIcLeNXG4z1GpxasxncxzMKVbaRymuYBH0Gtw9AhR4YSA
 LYwKyKsmmx3ZxAmudyjTipJeDydYQrxfebDq34LRQCXQu+Py7WlXOg7WLVmqkPAICoRW
 39/rgmlUIGKgCkIRn7YS2nDE7zz8e1Wg7aYiA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794245390; x=1794850190;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LAk32CEywAF9vqELrihdKwa5w3cWytAbnM1cno6jElA=;
 b=TJTcI1Jz5dFegXtbgiW2VEXODuGkS1Ik1Yz3BJD0qUndFHfqdKJfwLP+rlqU/ePsSK
 2hcIRspnzCd638/vfCsTzgqTE7AjxJtuQy4iAqc9w1VdtVbf/KLH/YOD4I5dewRBWqL3
 mHAMpAeiRiJWv3jEijZnBjLPnAGkK5aczSk+KprFsRcwztSsDbTgLZsMdfE6w0Ls3Kx9
 jPReqZ88+GN+fYZ7C0G9UEZ7lWIqXJ6gpTZHcSCW3pESdq5wAu8iCiuAX5V3VEYs0H9N
 RhlOCysnueeCfXzQHcYfUcYNJRJzB7wR6utJ11r3uRn06qZMkm6l1z4kfXC4LdtuUbAV
 twyw==
X-Gm-Message-State: APuU4Z95/SQtoLDUPeFsWpMs6zP6B4QqvQnbud7iEBTx8dEGzmrZq2eq
 e/BSdVL6etRIngTg+4YpJRgtOJfLCTt2CM094HdZtEJZEDIJurBM55L8XRN/skQvMUZOm1SBVtZ
 MfGr6r37ah8tJ
X-Gm-Gg: AYBFou0V3jC0L9chG755K6vN0r4bT3o5i5oklbJH8J3zTIYvcgeXz9vUno1SPbSDPEX
 Guj+XPlDJ0txNzEkBGgEVEntIpjr43DixD5J16pTcUqu2tL5QDZkLgR3kjGLghpfTklHcxQUaPe
 utLxjKXnhxprvhWyvR6+qPi8weC59Hajvu5NmPu0bqOuA/sWwDM/Z2Oop8DbAaagCdfNLb9KzUW
 Ndjmm7S83/ufIxOQPgMsFLHjaMUF3V4ijj/dcEdJ9NPXnRtX0tnkgQNydLaPP48O4CmtwD3GoyX
 MgjA5GLpwHJCeNgPNlVDT/LARav+qgFljxRANsfh2d5SLO1ASUu8c/fQkAdi/oHCa2eV82WeDTV
 TilcXsjQV9EB5gVSHzRSoj9DK2kL/zeda8cgmMGCGHRhvY9vDShM6EU+GgyesG5d3ytrackgrtn
 ZD5tN4vE+3g8OV6g4WwvTeI36fxYQiYvzuGPbt98eKPcNAZSRc3r45KxYlH8iDTQNSNuOkdoEzS
 F0mHOU7TFAjjRdD+qJmWLWxa73W9bZEMRKjDFo5/tgP8X9n4zTASPfs0FLbxUIq3ZRP6abptD3I
 9ThBb2DGQt8RDBqyCx8L6rQ0EfWRoWV7dvQkFpu9NSz+tws1nvA8VDiNyOoFY+VhmL3LEH8vHvJ
 Zu0VJQGSmz1Yqou5pRXCrxsXcFwjhNec3xvfa8EuHpFiTXYlU8sCir/ZKVK5AQqp1Q5U8LmhBiB
 QEA4A1OUwB7nYt9BgPtcNdSyV6uttf8g==
X-Received: by 2002:a05:6830:915:b0:822:527e:f653 with SMTP id
 46e09a7af769-85f507ca25dmr4958314a34.13.1794245390177; 
 Mon, 09 Nov 2026 09:29:50 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-860db8481d7sm200546a34.15.2026.11.09.09.29.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 09:29:49 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <20261025231839.1155290-1-marek.vasut+renesas@mailbox.org>
References: <20261025231839.1155290-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH] remoteproc: Make REMOTEPROC_MAX_FW_SIZE depend on
 REMOTEPROC
Message-Id: <179424538954.2040456.2304809187402236003.b4-ty@konsulko.com>
Date: Mon, 09 Nov 2026 11:29:49 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 26 Oct 2026 00:18:25 +0100, Marek Vasut wrote:

> Make REMOTEPROC_MAX_FW_SIZE depend on REMOTEPROC, else it shows up
> in configs which do not have remoteproc enabled.
> 
> 

Applied to u-boot/main, thanks!

[1/1] remoteproc: Make REMOTEPROC_MAX_FW_SIZE depend on REMOTEPROC
      commit: a2f26b3b41f60474c8cdab70ec0912d30fd6220f
-- 
Tom


