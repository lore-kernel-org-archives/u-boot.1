Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8562D606ABB0
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 16:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=KDXvr+Pa;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=ZecdHxZA
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 46FA881100;
	Mon,  2 Nov 2026 16:22:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zIcWX-yjatvJ; Mon,  2 Nov 2026 16:22:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4AED681127
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793636533;
	b=NwmKcXO6hYWwEoLahNAEQfXiLE76abiRx76tGEbRwqSkmvLiUv8QHANO3RyvPRTt93QE
	 k5F19+k+C5CwnhV1E8yGdxK0WZC4Savbta0q/k28k7yzzHszon1yRwsRZOzs8lX5+BE/W
	 0xDCTjEQfbzhXfS0P9fQial7q4rDYHeiqETa5/+Bby2L0k9ZphZieCqFvbuTguaWH/cFZ
	 QXD7Qc07J0bVMJvsZY4jnWqPw+H6RJu+X96kIMlsXmPutdRQ8JojX5HwIw4VnqB8R0Okn
	 72Qb9tnkTiC8nxNuNQ1W8lK5w7RBhWH3rx/CdzXe7dt7xfQwkMUyVtfIBm/a0zdyMqA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793636533;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=kJYXVhftcmasDjHip+alBpMtgX0z2T3SCDe+1ZPF0BI=;
	b=QhtXkwKRiho01W8us8pBv9xLjFrWxIEDbC7rnd5dtq/upThnQJVgiBLXHTbGzILguXJA
	 9iT9SkLK2erTW50U9hcVmxgQm1Piot5A8hTrwqPJ/CDphc3FO+DQ3+qc7gPZubRXu9Sex
	 P8KOJu1ullCne1NNpJrMkJh54l88IAa/uigt/bR7SEy9x4aZk8z8ceiP2NkNBV13mkp/9
	 A4BHF6JvlSE55mZUbq3EylgfFkXTk9MfjTOZEpz182m1u6+rBuodv0pN6oM+0rCdz9djS
	 3ROR0JQ5r5IE8C11G5UeJ6Sgpu7UD+BiHq9zebSa8nZW0ADWuA6z2cFB//jmpVXmYfA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793636533;
	bh=kJYXVhftcmasDjHip+alBpMtgX0z2T3SCDe+1ZPF0BI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KDXvr+Paa0wgbZeZBuUxI3qj68XcTxzYQl+tomo8KSYksc5qGK+QkmbWJ8NGVcyzk
	 CFmFVN2ZMvOZXrBmCU1+rxMSCaoizfUEc5aCIKMnlt/ej+HdHOFBhv/O0CbWGRm5S2
	 AWbZAYNuZR3Y5pOvR3bploqyxs9UbVDfo/cE/dPSf2nA1awEF5BI0TuqbcOIoNOBtl
	 g/usObZeSXaYYiQ492MIChiWgku2miQyqAxij03qZVl7iYW4dpWL0Vq8LW5gjhQjcw
	 tbQkz8lAuw+kTcRSkz3B5NMCfSoucyM3maI0eWsRz3kqWrd6Fe4VT7WDqXy3hGNw7Q
	 cv2CRitvy+omA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4AED681127;
	Mon,  2 Nov 2026 16:22:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id B2746120
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 16:22:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A2C2A40719
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 16:22:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0trJ3lCcVCJv for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 16:22:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org EB157406CE
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793636530;
 b=hegeTGQOV1vWrSRTSV9vyfLeY6xHoWURHn6+eQRLC/YH7eaQvAkNjarpiG5PxWh0tNsn
 ja5RVNgDcBCfgE7YnIGRjgAok+szbB8EDRQ+jOvbYI1OQvObWx3RmPEjf1MSg5gjD49qD
 7u7ziuJEZhsHvBQb+MbfSvCEe4ByK6SVLpYwq8ACFkvOc2Etrr8ap57cJ7u+3l0QWm2kb
 g3GtDmaajHCHS0TbHunYzapgOIwdC/vHjIvoFARFCQZvftM7mUEIo9t981HjxXmrddT4d
 HUlj06PqQ1iv5+lolsDk9HOhFFYWYbOZJ/GIKuhWaqWCOPylxGraYgWqixxvRosIGtw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793636530;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=kJYXVhftcmasDjHip+alBpMtgX0z2T3SCDe+1ZPF0BI=;
 b=BMXeduh4Oz4Mx0wOFLd8MQsAOq4BCzqdTprGM7bA2sreLhhWmcf0ovQUOXzOROwqbaKC
 OZMaLV7UZpQRoM6Fy4Lp9qH8HNItOFsKYP1UV963G1O3qO5VaeV7x0WkUFDlfSCkJX70P
 z/1Cy9S2E9lkb+IoHMQX6CYjezBRkCOkjWpUDb46fFFtay83O0kpXPdZtk/M1GOfKN0TS
 T29BfDp8a7UszgsPFxF2RRmdLIbgssV0jbligovJ4ju4bphwf8tkfGiFBj6//U1EKnoVn
 ECKKWLFDQSTa1gkMHRftTVBwkdX6b4H9qoDbsgfNQv9h7fVGZ1+lBE1lZFo5A7lr2PA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=ZecdHxZA; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22f; helo=mail-oi1-x22f.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=ZecdHxZA
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EB157406CE
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 16:22:09 +0000 (UTC)
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-4d7034a99a9so2004981b6e.3
 for <u-boot@lists.u-boot-project.org>; Mon, 02 Nov 2026 08:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793636528; x=1794241328;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kJYXVhftcmasDjHip+alBpMtgX0z2T3SCDe+1ZPF0BI=;
 b=ZecdHxZAaEEq8CwGSjbJTEoPk7YrfRNHeWUxXrNFvN9YfH02Fjnrw+Gtb1RVJk6Z1m
 +o6o0STYc/LSFO6aAiGdGU2RXFxQlQGdepLLuUQALeTvBVG/5ACjuTPmT/v24/rFLZi2
 PAP1bl2kcDYbJrBQhPPc0DF76yZfWNGiIwBv0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793636528; x=1794241328;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kJYXVhftcmasDjHip+alBpMtgX0z2T3SCDe+1ZPF0BI=;
 b=fZouna9tUU6QzvJ6UMaCwfdbeR0KyPE5ZxUFH61O/6qbaaZThH0vatAhd1T5Sev+N0
 YFk1RId+UJ6d8P+piWrgYJXYs+jB/oT55D51x43xFtRXSjsKH5sdmsONY2ff6z9EK3bV
 L1uskW6T0xg9LNc1Tp4onpOWXJ+DCFo8f05ir4PuWIlFubvnSl44mcUz9DBso2KTtvNr
 /cOFR63VknxprLApjeAD3rwfCVC3wxhH0k7TFpZZpIn4unsvMASgpsb8yrWLvNEzd0X6
 /gthVzTdZSGjU1UIGERGYCl6zK+4hkWt0sR8y/MU44ta/s4Sq/ekUqh7wZ63dsKOBfRf
 67dw==
X-Gm-Message-State: AFq9FYIsdauROLD0lI+KAD6In9WpZHvi6J5+EYyzQysw6Rhzupsw2vDJ
 KBefV9gyNZUHiDsfqOxXzsdtpWFfB4AOpfuDxPXdpMTCeSEN6DsTDFnkGvo/f/rYue0=
X-Gm-Gg: AYBFou1ALOTDdE5CaE2jJGZfeY5nnc9M2eG2OuM0uYh2rmtSgMJZ9/GD6yW+4sImV3m
 EzBLCi0F9ryVvJVuU7dlszj6OWflCniWHoLvC3IWzWOPDZR32WId691VCJlCSiwXFwSMgUprxyk
 5ec9Xb38Kl/ecFEFG4wvoItVuwSQJL7vjcOAiar/joU6X+pJUwGkFFlV17JBo8zmcvFcaWmYbMJ
 glGjt878CpNj46D9GIvtuYePPufxm50RaEgOLsANFpVpdjkhfwrJCVogQCF4hrp8FzYo4hW/+N5
 e3TDMHVu4Pkb/d6v014K2hnLaT1v700JSIVXv/c5NaLMqaHbNLPL+RMDxSPluFXPYVMv+FvS7QH
 wLc4OscWqH7D1KXMHTyZY5t02EjXfPmJNi3RcxQS4Um+um7LOT7fhkWXJ9Nr5Y8lf1zXQgcPps9
 2Hv0DgWnao9/eLshJDjWWZZJzC+DgBwr+0lOtKQ+vPt9gnLpZQKPLRmGdA0+jKMisSV9PzkaeJV
 N7Z4BzHBt8GQ1pWdihI7t2J5/0g7ZBZk0LYQ+jZeq2Vr82M2KJFlrtbziYByHRJBtsSko8gOAGQ
 Idw3CKNDw30JN6ukmibgaxzWBu87FU8PUyS4u4gCkNIYnHjtmAJtnU8Uy/o+FW9q8VEJ5CUWFWN
 qnhZRnXHo8cWzhDB8Jsw/pg5qubvBeYtM/ikq9R1NbgXkv34CeQ7r0qfq8Yr5VtndOOgEIVoM5f
 wgO588GT+Kw45ZYhpvApfzHtu66VIVVw==
X-Received: by 2002:a05:6808:508a:b0:53b:87e5:8c9a with SMTP id
 5614622812f47-5640dc1a3ddmr6926398b6e.17.1793636528337; 
 Mon, 02 Nov 2026 08:22:08 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-5640fdce8f5sm8653353b6e.7.2026.11.02.08.22.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 08:22:08 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Andre Przywara <andre.przywara@arm.com>
Cc: u-boot@lists.u-boot-project.org, linux-sunxi@lists.linux.dev, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Paul Kocialkowski <paulk@sys-base.io>, 
 Christian Ratzenhofer <christian.ratzenhofer@cdnm.at>
In-Reply-To: <20261102114733.3468703-1-andre.przywara@arm.com>
References: <20261102114733.3468703-1-andre.przywara@arm.com>
Subject: Re: Pull request: u-boot-sunxi/master for 2027.01
Message-Id: <179363652736.461671.11865031137018647495.b4-ty@konsulko.com>
Date: Mon, 02 Nov 2026 10:22:07 -0600
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 2 Nov 2026 12:47:33 +0100, Andre Przywara wrote:

> please pull these sunxi changes into main. Please note that's the master
> branch on the remote side, the main branch is immutable, so I couldn't
> push a fix there again.
> 
> Not much to report here, some cleanup for some older V3 SoCs, also a PMIC
> fix for some Olimex A20 board.
> H6 boards with 3GB of DRAM now work again, and the A133 build process gets
> adjusted to the now mainlined TF-A support.
> 
> [...]

Merged into u-boot/main, thanks!

-- 
Tom


