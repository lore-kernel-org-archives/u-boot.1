Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F8EACA5FCE
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 06:44:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 246A340655;
	Mon,  5 Oct 2026 06:44:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HhnnVGjcFYnL; Mon,  5 Oct 2026 06:44:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 854D340656
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791182678;
	b=Gw1ZkAMKL58dMLAR6b1lDs4WRxPpPDTAhDegQUsqIBgUKs59aEcRNlRdrQe1D48+20M5
	 yAU3rYe10/J9TwMkQ1nvrO2P52smZnPbvRqExyb24h3tdnY8eVgxQONlpHYhp3UfbtMAv
	 0WeS/CRpxNVVkqIPVCobWEjBj1YyyQEw2jpZneSH6B09bkV8QoJV2MhoIdfRYX3VyyY05
	 57RD6gwYiiwuXXi2v3Qscga9s2mP2suU+PBVdMLM9od+D77z0cI83kP/SrqLT1VRRqg5T
	 xxImCIrjFj4CisNf1FIceYgcoU/mXzAczfUE7z8QQobiUIlN3znWBYw+d/Mk3nYEmCQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791182678;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-Pm-Submission-Id:From:To:Cc:Subject:In-Reply-To:
	 Organization:References:Date:Message-ID:User-Agent:MIME-Version:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=YRQVKXJA0hIJOgSwKf7Gr4Aw0AxbYSw5ht0g/Dfhg1o=;
	b=de8lbHK1zwrd75DAqzGJgN2Q3j1++A+Rzbb3iBbx02TVSlLUibkq5EhbUOGmsj42YUmt
	 9iBd6uZaEnPTPO3ROMjRAqgkac2PJDjWnHQWY6izIBYXQitgznNtB45LIJuv0z9zCwAWy
	 QmWegD+61sON6OFl9gHmuuAUKF2PLwIBr0UyC5fJSACPoGLCsHrxFOdqUPFFtBwnP64sR
	 Z0Excjes+z6PS5mxLOzN9lleTFzImQrFkHqiCxEQiCDRXP23g0sVvWGe0QLgZNSV/tRhe
	 8blFymWY4bdIJGVz7vey0XrZ7YQ3jfg7WkEMi1rqjTgNDYDxpwVCQWNmD1zg9PTdwxg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=rasmusvillemoes.dk;
	dkim=pass header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.a=rsa-sha256 header.s=protonmail header.b=l3AmndoH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791182678;
	bh=YRQVKXJA0hIJOgSwKf7Gr4Aw0AxbYSw5ht0g/Dfhg1o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wmN39d0JbqazKwD7TPAuSW6LL9d0awH89OAZjdZYszuh9isFoZyTb8ysSWatlXfv3
	 IXyEzA1bcN6X/ulR3IZK7XTTogsp7PJNWyZDN9F70+Lg3XYqiw3nJzkvGgOqIrGvFA
	 lX/Wi6ygAZqJLLt47DCoLZiLWtdWPXyt+sSsf7yh1ZiA5CwMHl1T8l6HiI80GSLImL
	 rq918svRywTIfZiaJsQxSF9eVW1hHuB6bvyI7WQh2AiKFA/PaIAKUdpCOGEN4KS8e7
	 p3JzIeAHm/1S46ng5wb/oXo7KvW/5CVpL/ZHB7K65HN+kPGmACqsFaLYn4mLDp4hXN
	 ZjCPwzhgwhidw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 854D340656;
	Mon,  5 Oct 2026 06:44:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1241032F
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 06:44:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EC0C240656
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 06:44:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gINgn4ZYiuru for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 06:44:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 3167D40655
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=85.9.210.45
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791182675;
 b=OCeb4pjhxs6JLHqgcvvifUW/QLQtyALbwLSohmhRg3xqLxTXOFxDq+u6oKXPV+G4sL/K
 6wwMjtYTSV98rUyQfYdDfU2anzdJJA71tZUfPradWRskp4nWEAFl58KjIFe8JQu4TGxvy
 3UkkxbmXYW8+CtrH+X0ITB8Z+dQ8xFXzq0UpoM7w6TyQLxxsBUWj48wEI64EgIMPsrF66
 HaJ0tJQNNk4SoDFYaDOKid4cAkClXTswnHHhpAiRF7n0OPvg1QR1Yx2ysASceoSUYlcHb
 d95H87NZGi/ism1HLY7NH9TZsvkmp9Ejz7upa2uGbGR9oMSbPK+saxGkrSJfn+JzkHA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791182675;
 h=Received-SPF:DKIM-Signature:X-Pm-Submission-Id:From:To:Cc:Subject:
 In-Reply-To:Organization:References:Date:Message-ID:User-Agent:
 MIME-Version:Content-Type;
 bh=YRQVKXJA0hIJOgSwKf7Gr4Aw0AxbYSw5ht0g/Dfhg1o=;
 b=aVS5J/82QdOrzHkPFQRXS4kr4C2SJat6zK5hXOxzCSq5WibLwRfUREifgWL61mFkt8nh
 h41HBnIMQ11bVBRI64Q3TMcXXv8Rmj07HgOPK0fx7GkaBqs1Jii7QgHsD4M5SpPXYT9+G
 sGraZKrh0u0Wt9uJYJ1UxldulQmwqYDmUoUJOhmkyDhlQGa9zFBASarUFteGzCT7gAlX3
 tLO/ZeCJLCWMS0DDwc9/scTjb9MXwNNsj7hwqpptLydiJb8obdreAE/qplBh6aWg/UA42
 h4NAvr4Ic9bUInHZuD20XNjyTcAdUW08bLivT17oL/XB+AwGmCkdWNnze6sy/snkbvA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=rasmusvillemoes.dk; 
 dkim=pass header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk
 header.a=rsa-sha256 header.s=protonmail header.b=l3AmndoH; 
 arc=none smtp.remote-ip=85.9.210.45
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=85.9.210.45;
 helo=mail-06.mail-europe.com; envelope-from=rv@rasmusvillemoes.dk;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=rasmusvillemoes.dk
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk
 header.a=rsa-sha256 header.s=protonmail header.b=l3AmndoH
Received: from mail-06.mail-europe.com (mail-06.mail-europe.com [85.9.210.45])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3167D40655
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 06:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rasmusvillemoes.dk;
 s=protonmail; t=1791182666; x=1791441866;
 bh=YRQVKXJA0hIJOgSwKf7Gr4Aw0AxbYSw5ht0g/Dfhg1o=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=l3AmndoHK32+mU6Cqb2mTxMpQ6TM9G41njt6y7UyfZRCFZL6Dwl3Lx/mlYXV4LHYm
 +ZQj8b7XJ8lpAmH7+46vvbklBWp+AFTjrEU7XFPXby/lQosCrAP+GTk+NxWf8lJem/
 bIC6zCgZb4pOA6LLhGMTSjTnnN6KfPvR3LWDAHz7GQcd5nQmbcp44NFGJn8QEpRbOr
 vpycvz1rUHNMsJN74ENQyKOjEA7YQgOmPEoKY+otSF2jgezM6Y4Q8YPVoAEqVlpbwm
 XXmUrFhZXVyJV44GMbnVtWf9dML0zBGMG0a2bDdw29vWzs5nG9N+lPJJyPEgX112T0
 gpF3qYsSAE22w==
X-Pm-Submission-Id: 4hyqcS1M8Gz2ScNr
From: Rasmus Villemoes <rv@rasmusvillemoes.dk>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.u-boot-project.org,  David Gibson
 <david@gibson.dropbear.id.au>,  =?utf-8?Q?H=C3=A9ctor_Or=C3=B3n_Mart?=
 =?utf-8?Q?=C3=ADnez?= <zumbi@debian.org>,
 Mattia Maldini <mattia512maldini@gmail.com>,  Simon Glass
 <sjg@chromium.org>,  Tom Rini <trini@konsulko.com>,  Vagrant Cascadian
 <vagrant@debian.org>
Subject: Re: [PATCH 1/2] kbuild: Pass -Eno-node_name_not_empty to DTC if
 supported
In-Reply-To: <20261004061826.1028380-1-marek.vasut+renesas@mailbox.org>
Organization: Prevas
References: <20261004061826.1028380-1-marek.vasut+renesas@mailbox.org>
Date: Mon, 05 Oct 2026 08:44:23 +0200
Message-ID: <87mrsspry0.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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

On Sun, Oct 04 2026, Marek Vasut <marek.vasut+renesas@mailbox.org> wrote:

> Since DTC 7c78c8542d73 ("Added empty node name check") , U-Boot binman
> use of placeholder node names such as @fdt-SEQ and @config-SEQ triggers
> DTC ERROR (node_name_not_empty). Inhibit the error, as these placeholder
> nodes are updated by binman and replaced by proper nodes, the encoding
> in DTB is temporary. Since -Eno-node_name_not_empty is only available in
> DTC 1.8.0 and newer, introduce "dtc-option" make function which is very
> similar to "cc-option" and other such Kbuild functions, and add the DTC
> option conditionally.

Is this the best way to handle this? This also removes the error for
empty node names that might appear in the "real" part of the dtb, no?

I'm not really familiar with the binman magic, but is there any reason
those placeholder nodes cannot be binman@fdt-SEQ and binman@config-SEQ,
or anything like that? Sure, the binman code would need updating and
there would be some -u-boot.dtsi files to update, but I'm currently
counting less than 70 instances, about half in tests, so it would not be
a lot of churn, and changing it now would mean we avoid having to carry
around that dtc flag forever.

Rasmus
