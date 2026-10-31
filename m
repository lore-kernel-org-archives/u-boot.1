Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E82606A329
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 00:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Q1aI/lAj;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=UHvdLRWY
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 57D4A810ED;
	Sat, 31 Oct 2026 00:14:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nQgzP4sLI4Gd; Sat, 31 Oct 2026 00:14:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9CFD8810F0
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793405691;
	b=EWt9W0Pv6XoV9XJGZMV1KJl5xeCW6bkZEdVhwUJyHixk5AXI3OJSWJsarFR3yYQ9WEot
	 /NqDOA0THMFFny5m3cIiLnhRbgHdm6gIXb93fKsTM37nMkDGlueQqE3hOyqWt2YKcf8Ww
	 XceBkQO/FZeMR7k96sUlkMEibyo4BTnJnEBdoSx8C2ycMpUO6bSG3FzDED/pqFJG/+t6k
	 CsNd/bTnyBWxsh2CV6Z4CSulmQe4G5Tg2Z9VAOe9rLHbsuwmJBeG7j6M9TMjnIV6geVTb
	 uO4ygbId9eFR7l6y9T5sqQszmNS+/ZPvzO1JF7YAvQFTHHkAHFOnfJKB3ht7h027qHw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793405691;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:In-Reply-To:References:Subject:Message-Id:
	 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Fu9s3bhFcBTpARhbkpQtrxP1a6aZP7KaNNf0xg1s9vw=;
	b=bwO8PXwquWTzb5a7w2EpqXXYLSiY5YVmEtENyBuCmLrTx6KQy6e9dwJJcrKycjUn3z9T
	 lrtprXTjScp3B/nXoDsgAY7nvF4tzRnFHLurD30/rjDgMbsQ6we9TN0gnZR+wGnDrtp/F
	 l72jUkbboPuat/1WkEFP0VZJt/LiM9XIGcD+YRa3f+GBV/cewYAkU7cR1ZLLTMf4iUqje
	 J+vofUALL2IzPTd4JP6jd6BgQJSgXCLjKZaifvuycX6+fvAoLVXRwDYk8MJcnWepsME3s
	 65KRpif5YLhZQjx1jFYN0IKlJik1SwIcnuWXz62qFsVgbwePHpvLtNOvbpYKcareQlQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=UHvdLRWY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793405691;
	bh=Fu9s3bhFcBTpARhbkpQtrxP1a6aZP7KaNNf0xg1s9vw=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Q1aI/lAjYrg0dhPeOI7RVWUusvI4Y6xvyAcZ4Mf/8HCrZ6hDNnR0zi2kK4Nv3ExSt
	 W/vUy9KNKJkNS1r0tWcHC5Anj6Hpt9WdL+qyJu4uEN/LZXDMFn4zA4xcNU6V9Do0eD
	 z9IYSXf3tSeeFskZMPHAJ4GCKazDgSD7ALoA7TGiZHvCB12nhZj89OS1OqQZpfRy2u
	 oXxwrAjr87yYMwsqUNKRQI2zQcZihAl+ZKGDgfYzRjQ9dbDuuZJCanGGlmYlgxFbpY
	 OjR+tIcC7y4ysp8XH6KkEiW6QuvaV/bKPh8sGKFQWYNZ4uWc5ipMcoV8PM5VsN/20I
	 aQyONDZ7lf0Tg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9CFD8810F0;
	Sat, 31 Oct 2026 00:14:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id EADB832A
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 00:14:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C77EC810F0
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 00:14:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VVIiwQTqugp8 for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 00:14:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 03462810ED
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::232"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793405690;
 b=ZHgpIFI3g6AaTIzYHdj8WkqDQeL+W/THYMLdP35lyopD0vpiXLxSjv5Fc08eUeDVKo3D
 A9g4KuQKmlvCaOwVj558962APa2CJr0Sv8bJsp9rUp+Kh56Eaoz0FmBH2oDfGr4a2QHiF
 4WTlo+9zTPN8ODtZvjlO33jtQMztCns5Wb81ajrZrXLOf/BUPKlKkOqef+7DPwYOVoB7a
 e9Bjkl1XQ15zBp3FL7cVysMEy91BS7NaE+I0AqyovXzwAxFFcmEC7ht6/M6z5qNcW9Gab
 aFe/0Q1DgLlFmJ9qVIEsYpj/aISpRzDvwHv559PlSzR6/1RPi2T1QWdrwCdbFn2/Qow==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793405690;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=Fu9s3bhFcBTpARhbkpQtrxP1a6aZP7KaNNf0xg1s9vw=;
 b=IqvvH1vT2MDF0YTYDcgQHKUJ/Ns3ysITfs4ze9v73Xj65ftd8SwLA8aHNrs5wqBU0UBy
 e2oY1faBErfjaTma+GqfDQNRN7H8Msxfim6HRQtY9ruAjkCPW5Vv6JS1OIC/VIusPp2z3
 eOIz0opcEZg+N21OlDEcAHWPCz3OWVzka6ttyug1dgpzjAhm/nukuoAg4tfiDrVJ48t+W
 3Bvk4TRnMLLsFcyQOIy9HLsGzjZkJzSlVl8eFf4u1ukEi1MiV9XB5bOr3lfWiNrlNDOli
 /d70jNIrFwej+6j9VtPxDARtAjM3PhbD7o3QM/Tjaltu0fOlOTMn0KMya4NTUXAcu+w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=UHvdLRWY; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::232"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::232; helo=mail-oi1-x232.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=UHvdLRWY
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 03462810ED
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 00:14:49 +0000 (UTC)
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-4b190cdc9feso851028b6e.0
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 17:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793405688; x=1794010488;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Fu9s3bhFcBTpARhbkpQtrxP1a6aZP7KaNNf0xg1s9vw=;
 b=UHvdLRWYJjbgzpItCaNEe4PoL4Up89hUWOQihlBflGHt41AZII613TuIfjxwrG+fNy
 aXdtMbWPKoqiMPH5Yg2PWdhRWqiz83ld6pta2mzFiQtir51M6sJHHf15NaLxfUjQ1ZXu
 J9zdmMPA6xJmwDv47cgls7h33BqKBOxJtBCS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793405688; x=1794010488;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Fu9s3bhFcBTpARhbkpQtrxP1a6aZP7KaNNf0xg1s9vw=;
 b=WP6dur7Em2KUtd03CfYXwfXrQVxO9VLyc1yCvogwjunKaq5OlqpR+WvjBnUEq150oS
 HbpWA9+KBcPMwyH4ZZ9+8E/fohcjx7VdC8SlKuWsabDzL64MFWdH0gqTc+CuLddD7Ioo
 cAjSW+XTCTGWrRswy2HnphWC5xMnwU2qBhb0F0l8i1LlMmILrSpPzB78upvqnlhYNHZ0
 1kwaDdQurskU8t1y7M2I5nrQD8pK/5YkU5/9y6UZFtXx0c8JXba1l7wnvKzbOYI30rIf
 mNAqLnyRfHWtBFcEJZ3iSr+xxcWrpsGDVQJg6az4mKU08gqjMiNQMgLdmRgTEjS44y9h
 8uIw==
X-Gm-Message-State: AFq9FYKqhvbNPRQMKgqVXtwto3Oy+PKxY+wChavBbzls0hr1l9DFOMN0
 ZroYiHO8R/aS0GfBvSGkS3aelBNzLf3mHz24RczVe9+yWAw1MLxNWt3m/IOXihywb7eS0hUEruE
 JnTDuZoGrOfI1
X-Gm-Gg: AYBFou3mxH/xs9XPgdUDjssBe4mti7sQgxnwky+baeSyeXqNCdpF+FSic/xcZA1tVsE
 Xb28Tjaf58nJDwqM7zqRBWNw+nToPwrwkoE5sYud+vSGHrBurQbDZEUOidC+ngVaerizIP3ZoVp
 ciJyjltrfvdQIOK25Hd9nJdOVmu6y9fXsKEPMqqIq6uQjDEIcZNwYijowmtO2O5VquQ+IffyHnc
 2cRSz6LYlL8ClR0Pec3Gt0oYdFTFOJ2qoqS2KILNbTcMag5cMQ56/UDrHEvwM3jC2h26Q+5x5af
 yJjQ3/WryzoYfr9MwbnbkvPv/zVfS4KUcDd7vRI3HppJKha4ukAwq2aXkXi4nGc4kKc03PmbRyi
 848UbdfykDiX29G4Fg3kF4b1yXu0beL+8Is0iXFwM41I36SfqS7y3XdeoKF3Z/W1WuZoByjnMhs
 26zlxIKUQ7tODNaU7antSfASxhJ88UlhMG4UwQ89lKnZYt6y0eTcatiLDwWLR3O+CAWbqDCqTbx
 iWG5hNGsm0j1gKfYtdrx4wr1rbWVfqH0De13ulapncENc189aqP0+SZ8zeCllpuFdjgWb1rQKQX
 CtykWtjb379Se2HyuTNkPDBdb/cNiOTNhfXCqjQKAMP1fMy6ASW49X1nifEyT9PPucEG1eh9KoF
 LclvJpwenVzkGYLkLnoiWCK1J44tFJBZPjSbQztDJBQgltJvp41132qGKWeSaujYoLNGJSDdRi2
 ecDA7ub/mVzW7h/lJcjLTmOvT8YAexVA==
X-Received: by 2002:a05:6808:1798:b0:4e5:a74e:d6c0 with SMTP id
 5614622812f47-5640dea5592mr3210897b6e.64.1793405688687; 
 Fri, 30 Oct 2026 17:14:48 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-5640fe45587sm2625427b6e.15.2026.10.30.17.14.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 17:14:48 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Aristo Chen <aristo.chen@canonical.com>
In-Reply-To: <20261017123554.211799-1-aristo.chen@canonical.com>
References: <20261017123554.211799-1-aristo.chen@canonical.com>
Subject: Re: [PATCH v1 0/6] cmd: pstore: fix out-of-bounds accesses in
 display and save
Message-Id: <179340568779.3856789.8418079789600660607.b4-ty@konsulko.com>
Date: Fri, 30 Oct 2026 18:14:47 -0600
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

On Sat, 17 Oct 2026 12:34:15 +0000, Aristo Chen wrote:

> pstore display and pstore save read the records that the Linux ramoops
> driver left in RAM. This series fixes three ways in which they access
> memory past a record or a buffer. Each fix is followed by a test in
> test_pstore.py that fails without it.
> 
> Patch 1 checks the record header. pstore_get_buffer() copies the bytes
> from offset start to the end of the record, but only rejected a record
> whose size is 0 or larger than its zone, so a start beyond the size made
> the length wrap around and crashed U-Boot. The ftrace records are read
> without checking their signature, so leftover data in RAM is enough.
> The record is now rejected, as Linux does in persistent_ram_post_init(),
> when its size does not fit in the zone after the 12-byte header or its
> start is beyond its size. Patch 2 writes such headers and checks that
> the records are skipped.
> 
> [...]

Applied to u-boot/main, thanks!

[1/6] cmd: pstore: check the record header before using it
      commit: ca0b83af174cb1d9fa9d227aeb535acbc5c4a493
[2/6] test: pstore: check that records with an invalid header are skipped
      commit: 748d8fba4dd3e3b0adabc8228dd6d7bf14e2495d
[3/6] cmd: pstore: size the buffer again after pstore set
      commit: 2b03bc4d7dfa2ecd0ed8d623ee0bdd94b0fca605
[4/6] test: pstore: check pstore save after a record is made larger
      commit: c24eb8c92cf88f8a1975430a64fac6641db8d724
[5/6] cmd: pstore: look for the end of the dump header within the record
      commit: f5794cf41b8bbfd6af847b11a2de86ba22216867
[6/6] test: pstore: check a dump record whose header line is cut
      commit: 885d0fa66485d8a046ac56473bb3b3ee9985fe17
-- 
Tom


