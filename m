Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BA68CCF2C1
	for <u-boot@archiver.kernel.org>; Sat, 17 Oct 2026 10:43:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9398B812BB;
	Sat, 17 Oct 2026 10:43:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8dHFfR8tobAX; Sat, 17 Oct 2026 10:43:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D1BFF812D9
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792233791;
	b=pNr0AlotPi8TeeD4UcTybgBM61xaiTzf2mZj2AUYQSrdLdLD8tLVwDXnpXyjqj8RVoAL
	 syJHJA+6oR1LDK3Fxi0W3ujlIJdf5iOhKwH0/KB1XCnohNJIWgeABV1tYJBIUBXB7UuZ1
	 3akuiOZoHOaHTwnToFl+zhQEsXnjWiTgloSK9AulbDgZLxA4JSHUWbdn+fNh+YK0KqNok
	 VQ5mE8uH7Ddva2pKdbts4rZ9STLrYI+tMFjqt7I6gw7AatvaWTA2WH39Lrmyk6Un1oR0N
	 icbmGAaUT3I4zq5h2jEcdKwyI2O4b+LUqVuKfvhGmyyPtc+gLYv5DhJuprytuHgVwaQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792233791;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=0kl+izacbrPemxZZc20tlwha/669i4cvIIMqzPHcPt8=;
	b=NXrP1/Ecr2639WiUSyMnvEOcpzv1nStCvg81sLSP0rSeYkP4d1lWybtyQ/Ms7w58rhf/
	 OEYkiXzTVD4uLwWWIaTKoTsiSUA3yzX37K6JVWJffWpqcuepB0P5uHvgCSTmDyvV6/TX+
	 aI3Xu7aqFDPe6I+lwe4pJaw+kdJeXAeQhws+lfqd1Vj7oJBcnxmjhU56+EwIxL+9EiXwS
	 e4Lhz7s0sdlnvKZnyIL0dimFH8+lDnBBJ16vZoaCwGplsl8dJ23Y3ysv2NJQf++bFW5eo
	 WoEfCAzytKcaEcZZ7cUe6bqy8xqEwN2GytOVBzUluAKrUbtsjaaxf0T75GdX4cj2sLg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=KGVvaswg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792233791;
	bh=0kl+izacbrPemxZZc20tlwha/669i4cvIIMqzPHcPt8=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fIsyMG8EMKsl5xK/HxyB5jRCVQEnXHtWkBibOrK8s/L0F29kyd8J1mkJqWYx69uum
	 W5ilG1+iJHVwKmUL4L8c2cf5774vPCm4Gb0eBMJcj05Ya0IAbC4mrx5ihUcypyjeUB
	 luX6T1DuAKESos55hzd2igdkRI6OVQe66sNxjhDSKW6NIXbd+0oRWa81tUWz5Xb7NI
	 qG2+yMd5yN4x4wKW1jl+OzMUwUrsJVTtwt73O7etK9bE1QBRn39ck/KH7CW/M/gtum
	 6XIlae8Ikg+ElT76pRSdgKhk2b5NfYtA3RxHZGq0u3RnGaRUEwdBV9GOe6rKGjb7YD
	 BXl31mCdaJRrw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D1BFF812D9;
	Sat, 17 Oct 2026 10:43:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7D570105
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 10:43:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6331E812DA
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 10:43:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9YNsuFHAbCtR for <u-boot@lists.u-boot-project.org>;
 Sat, 17 Oct 2026 10:43:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 58262812BB
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52a"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792233788;
 b=K4AxTZER6HYKPE/nh8hCW5BdyZF4H70gJmkeS0r5JvBStLEHd8m4Uk1LFhy8Igysb/xy
 VZbo/9qczICHRWRn0Ir52cmGh10BvFOT91PgM1Vl+R1g7Am9hiw8LivVB+P6UQgMjiv3G
 YAEBlUeFWzebW874AA1Q6fqBNfYSXUThUuGi5GVdv8SLroVjuthW78DT+oSIFE1SRp+xj
 0KFhXydyCNjKmk029cB9NCIQtsmdBrNlfUt+ev54B8Fg8vuevYFdzaoBe5Q02NVFp4ziF
 XhpM5KTfqQy/L1Qt0IUZJvm+hmGOEubj2lMIw2LHtWapoo6RhhjfNDLzyQIGxw1Wz9Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792233788;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=0kl+izacbrPemxZZc20tlwha/669i4cvIIMqzPHcPt8=;
 b=RkTV/i7yFsD+zC35+3C1R9kqx4cUy2Mp5gvyFMJNhYvFHb+I4RDYaWaHA1mzhURSBKPI
 33PI4YGsHinCqmlq34Ru3KOcUHkONuX7K+1JklODwgF2vVooVyVzIo0jN3WA1Bf/pwsTD
 x7TlVvZau+aRtATHOlrnK8LpqJkrIuBOZPQM2P/qoeVxW+5a/MrvZmNEwLU7eYxAhy8VN
 iX4mv+JhMILLFuszvsnXkIwDmTHe0DzcHGuOLbTKXLdRFLH8GXP4igmPPWPBlXk5X5igk
 NT28hCAbCYBNaZWDjRptU1Je09WTO6u0LfoBiZtWauriB0mzmmprDc/Hp3r8ynOsc+A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=KGVvaswg; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52a; helo=mail-ed1-x52a.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=KGVvaswg
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 58262812BB
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 10:43:07 +0000 (UTC)
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-6a0794669a6so853673a12.2
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 03:43:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792233786; cv=none;
 d=google.com; s=arc-20260327;
 b=CFx46kukL+NvOG+nQYSMcux4yz2qEXRfz3oKDPhQPQv1hyF5gxOj596H+jsJiLo/Bw
 ulVa78HFAICa1y0tdd4hga+isqtF32b9Sq1coOhX/zO+gzMaQ1CalR5uXEp+WgVAU4Ze
 pRfHXO6wjbPb6fWgaARJRPUXyB5n6IkrEyQydZlhnl2ylHKE7AguQ2bwv5gwZ4jkfUUI
 AhcPY/wdcNowaYXuytvoMtM/G9cVrmhtzGZ/D0nZW/jwEvMv8L7E5Hb1/HHARHHd5Wdd
 krP+5UvkApOdPtQPc2FBb5NFWPB3y1VLGtN3nFsoL4Xi4hASeTVJ9y+pUX69xR2qcX6j
 Nw9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=0kl+izacbrPemxZZc20tlwha/669i4cvIIMqzPHcPt8=;
 fh=3Mxaz3JzistlWdRzxvs/KdjLBST3fkYfK7v74nvuHiU=;
 b=THXdovrEFfbr79OTUUfj+jwYNTlQcqV7RxhyPzR18grRpo9b04/5rN4/YD6IiMNMfb
 qDKbNDY3r+sAPXxHItvPEjvdaZOgLt4/OdI8GeRrTt/XJZJJdFbIARrqLsHJjUHs/rXh
 GiADTrJ9j14BcZwjIlXrhO4n4oG8MOiPkjFHbbErNxjV8KHkwzAoKLlU4sWm96dAiTI0
 yddq/U3+PQyWnQuYEeYg4xgtLs/3wTw0rH7sjyaiC+mhOaLmhXPIUsQk2XzNHcmbQpto
 aS9vCMNSHQkYjZyNlQhBb6sS+8E/HditCMSzO4OVQsrQUuZYBTKrjt6YWACgMyFQoIIP
 ZRow==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792233786; x=1792838586;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=0kl+izacbrPemxZZc20tlwha/669i4cvIIMqzPHcPt8=;
 b=KGVvaswgeTyTAdZ84Ya+qb4eeKyA2zYTZUqgzVXz5l/TJzNiH4T1bU9CQdW4ut3Pak
 JaqOfsimczr9bg4LkYACXtg+p7hD6Z8489GiLMrpRvzXDGT9DYiNpAWivATxAWdqn7vz
 dGTqN8SWZ/W771FTYmJnI9c8zYOWFLRIPyAgY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792233786; x=1792838586;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=0kl+izacbrPemxZZc20tlwha/669i4cvIIMqzPHcPt8=;
 b=uBQNFfOvPaz+mJaOIrTEpcfqHHeKFvbVe0U5b+aXcFTUTKRjlZhKC3rAVh80WV8zfT
 7OaruPUzVF2QMSlK0M5Wwj+OFxkpz/xUd11pr8S5c0XMxGU50FAZSrv7g30BtKCkop+g
 PXvRqzOKhAtF0OSxPbDWuEyLVfEHwwhT9HxL/WJqsgGTS+K3ahybqkoboBbXMHw5/fnG
 ZtDayBdJco82EftouK/b5mWn2NgXmOxs0WckQEQk7eUIUBAI6PD4H9L4/MffpFKoUFCZ
 9lUDjY77TjFIGRwWHWAlKb33WBkmhBdKPp3JIvv8WXt8ib28bMlvqGGbqeFpH17Flkn1
 qN6Q==
X-Forwarded-Encrypted: i=1;
 AKwUvByjOeO8zAaM2CFlkphGIjOvnHlv02+1iOyWQBlxRwK7onTFlBOmM/m1wL5YAgCXH7wV74vHMUU=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYK9r5bLNV1SWJAzupLfuHMiwFww6rtNAc3DABgEdLsH5+VfHdIM
 DJ8/CeqlKvtFOa1PO3uRHzpN+zE39fKxEddGmJIs0B1SO/sL8+isLAWnAxdZsFvtDD5E2LIxi4S
 XAer3d8AjTGFyWXctlmBpgBcpZJ5AxUEAQZo1uHqs
X-Gm-Gg: AYBFou0xxgtPB+Vwt0Xr5ZVG0KvuWRwgkBYc5l/3hblSXId6dJowsMTOGh/pIGtm6dL
 EYb+OCdDZEvAcXlEy61RWrzW3VcZOa9386wegHALNgdFiXAeBtkqxj5AlSWZP4Ke1aEsr3gPq1F
 l+wy5nVdMtCzuzrR8xi0warjgJD5CP9cuS28RxrwirmTi7jp/jcUy/xwWD5U3QU5VlMhmE34ajd
 GJv0RY52w5wzeIyNCRwZlOzdThTuiAlTPoqZpawXq1lg4kzfgJVZ3WJqBKnysjlloGJ6MWxz+Xu
 WNyZr4ClntsBS41CuLq+BBosv2NQLKyUAyVkQY9IYKhmujcnAN+74Q==
X-Received: by 2002:a05:6402:4414:b0:6b1:bcb9:15a with SMTP id
 4fb4d7f45d1cf-6b3a818f957mr1424585a12.20.1792233785870; Sat, 17 Oct 2026
 03:43:05 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 17 Oct 2026 03:43:03 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 13 Oct 2026 06:23:23 +0200
MIME-Version: 1.0
In-Reply-To: <20261012104805.17297-1-yan.wang@softathome.com>
References: <20261012104805.17297-1-yan.wang@softathome.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 17 Oct 2026 03:43:03 -0700
X-Gm-Features: AclHuK9w6pbtazz2cwO6l-fuWNy7O1evtkPLGBsfuaiYxiZlUEiZ6-Q_dKolKcU
Message-ID: <CAFLszTjVm0ApA=N-9ATAVd-ZvUu-NgCGJ3iUyOUP25h-ivNHRQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] binman: Add HSM signing support to pre-load entry type
To: yan.wang@softathome.com
Cc: trini+nodisclaimer@konsulko.com, sjg+nodisclaimer@chromium.org, 
 alpernebiyasak+nodisclaimer@gmail.com, marex+nodisclaimer@nabladev.com, 
 philippe.reynes+nodisclaimer@softathome.com, 
 paul.henrys_ext+nodisclaimer@softathome.com, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
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

Hi Yan,

On 2026-10-12T10:47:59, Yan WANG <yan.wang@softathome.com> wrote:

> The implementation builds on the existing pkcs11_tool btool: a sign()
> method is added that drives pkcs11-tool to perform the actual
> cryptographic operation.

Binman can already describe a PKCS#11 key for FIT signing: fit,engine
set to pkcs11, with fit,engine-keydir and key-name-hint, which become
a pkcs11: URI. This series adds a second scheme of eight properties
that works quite differently. It would be better for users if pre-load
followed the FIT conventions, e.g. a single PKCS#11 URI property for
the token and key plus the module path. Then both entry types would be
configured the same way. What do you think?

Regards,
Simon
