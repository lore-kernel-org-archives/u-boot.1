Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 621AEC982E6
	for <u-boot@archiver.kernel.org>; Mon, 21 Sep 2026 16:58:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 017CC40AD9;
	Mon, 21 Sep 2026 16:58:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RkbA3TRlcTbz; Mon, 21 Sep 2026 16:58:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 1C44E40A72
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790009914;
	b=Dhw5e+0V2F8zHFCLqyhj9IJtL+5zSMO71FPJZU+GbuJMTg7fUP46DMH/Qe06Fk1j7hUf
	 reSek/1l0NfEYnyLs7RW4F1ab+4lalBMXbZvsss7BYcPE6S623JLVhI1vanEkeVzjiSb2
	 h1dtGYOI5OchdYNvo2S6YTY1FpbuLKPe24PIJjJGxVYce8jq9KtrZPYGI9s/cKeJV3y7f
	 ChjWVrMYwOH7vluaKzwf+JoVDLhxKn4uj8Eu2BsosON5VQwxvVt01rAa8yoY1ejE9q8Ta
	 XugBkCUmqHrEazglpNP9iOf3drn7uuL2scKa72kikrFO67N4V5GnF3mGlTiUVq8izJA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790009914;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=WXHyo3Z6DgA1ZKUJzIfoXOYMhOYnh5Kgcrn+mfhl2v4=;
	b=iHcCg9SmwT0ydCbqXB00aOCiHr7vvjaN6OA8c7+HeslYzbnxtv76e/I3TJ/4yHDd64Mm
	 5+GgXzEue80OWgRZyWavA+H29NWaMwr2IIm6yBUTY9vh25PxPDDmTlbYraRKxRq8pzhh7
	 3j+NjZgqxCvdfiIvXehNsI0+GC1Vdp1lAKk3JdGgoAFZ2VNyacpd24bUVc/S1doV8SZVx
	 BpnVEB/IrwQOfjMIQp4sSFlpLcqJhrLvX0LTkOfEw23fP1mc/L9QArwrmQiEsuTE0ccL0
	 h0uDGaip4If1rJHeDe4oL70//+sUeE94LBCD9G5A2mJJjr5AEUktUL3EW3qofafkUMA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790009914;
	bh=WXHyo3Z6DgA1ZKUJzIfoXOYMhOYnh5Kgcrn+mfhl2v4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NWDcFhbn3evVutQLvg2GDp9nq41PTGzw9qLHl/MNXv6NnTXgbkfyjJKwMY0SG6xK6
	 IxEqjhCSLR/A76riiuE3MN0BTOqHMi36+bN6e5EZNrh/fEU0GNTiDPEyXWJtBQYfMo
	 1Z7Xuuq8G3xE2zTryMS8j+DvqvjtYQhu7fkNdQE/c5+IZU+P7QHhc7T+k2XCiycdDz
	 sb30kqGHCBb7/2L3AftMMPZVpYf6pG6hh+MldVf2t3d63LFRrB76J36ysyMHfs2NV7
	 UKhBEdkl97wXzW7JDOgZZSlI8lQIwWLyPYMvaBng27XErEpJWYfIt9uq+Ka1CFeNPV
	 S26GVSPVq17wQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1C44E40A72;
	Mon, 21 Sep 2026 16:58:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id BD7AB12C
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 16:58:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AF49A60740
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 16:58:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Cvko7bpA-4Wp for <u-boot@lists.u-boot-project.org>;
 Mon, 21 Sep 2026 16:58:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org DF36A60730
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790009912;
 b=hs3pBCOtVdJwnolhKdxOzT/w/1rnoKM5pGu2rGC8tXQcgWAtUqfNPLKmnXreSrvifDnr
 rHblTZUHk98qLAQNo2yjQxcpKT3fso5KI2n2ttzyUibyYY9qL6CWO4FVs2ELRmxQ1z1rW
 UPjPSXqZEBbv8Vo48B3/ki5EMGhAH54yoPFLkjsny0eXYYocsy2WlVDBIcLQ5glP3GUUh
 Fs+/B73GW8O1o7Cjo/ogwpsgc5Dx+jPiW17PfV2tiGv0ij8caRGGS7/aQ20FtiqBzs54W
 JwRulwrzeamODsdoQthNTVG5lpCdPy3iAweE9VDn+lF4caEwvxy31eU2f75gI9awLIA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790009912;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=WXHyo3Z6DgA1ZKUJzIfoXOYMhOYnh5Kgcrn+mfhl2v4=;
 b=q9+HqUDKLOxjhB8mkE5wAdrchDOBMOclhhJrZBQNkSAwmwsWQ8yQI9fFtPnZs++g2Zto
 dGubzHGLmDDPrJYpLl5aXGRFM8VWqTTfSjbIJ1qMlPiJiqXnDjsL9yqHo8SQwFDYfweNF
 ODNLMakN4r1Y3BuAJwKOlb7Jgq23A7RdpyJlCVsjnMT6EnW+5YyJTFW/YhBIg31Evt6Yw
 jRyqLjXVrQfO/vSuupCzuNQSgtZ8w6zcUTfp8qRG767Sdob1yAbReLeAxNaF2KVwD3d+k
 S6ij9Z/QMLathuZsqPW5NJO031PJN0vHHsHtY5nXIPWTmrIQNwaDo8YLc9tCZ+FvxEw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b="WyWAs/uX"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::b"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::b;
 helo=mail-oo2-x0b.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=WyWAs/uX
Received: from mail-oo2-x0b.google.com (mail-oo2-x0b.google.com
 [IPv6:2607:f8b0:4864:31::b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DF36A60730
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 16:58:31 +0000 (UTC)
Received: by mail-oo2-x0b.google.com with SMTP id
 006d021491bc7-6aaf6076546so1939383eaf.1
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 09:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1790009910; x=1790614710;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WXHyo3Z6DgA1ZKUJzIfoXOYMhOYnh5Kgcrn+mfhl2v4=;
 b=WyWAs/uX+f9mV4Q6WOhbKt7E/R2VJxwVGnO7OFIajlNODV53HD6z3bPUmHhhKtpq7A
 8nIsCDhi3WfBFyQE9H74n13KbBKq34IIotwE97j56p4tOnzgJa6cO9np5UvE2+RrjrB4
 X582ZcYyrRc5SvxKS6pwEUSqR3l3YNpmE55zw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790009910; x=1790614710;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WXHyo3Z6DgA1ZKUJzIfoXOYMhOYnh5Kgcrn+mfhl2v4=;
 b=H9/jjV8HGhtw0zgegGV0egoaTrdtd5tXqPJ5+vssP+f+v1ABb+nkgwsuRL8EBOs4HV
 SZctCqnZl03k1OFe0I+sYblrPOezDnyNGElA6pSzwKdXZAsRpLGRif3WhYlY+1T/pn17
 +G6EMwswEeNTTOPI7ds7iM9/JkgeWsA9kbW4gWDczFmvnbbhnhPHhEBaWaaexSdTmOK5
 85bPrMifkoKr4VFkFEn2o5W5fsG3sSQmD2X/bSfGHpJE5ztHnRsMGO2LYQXGHLevOSXm
 nm9QR+0P+L8CEvxLoztXEbvWGnS+EsgWrV8/myrQzvSfzT9F7SjFZ6qxPF31n5rSTXxK
 OLBQ==
X-Gm-Message-State: AFuF++mPYM8X9H/Uzp9HijFNvlrpcstCmNGPd06O0/1DDMAGWMZd1io8
 WbWj8irmCz4stP/jB2WKzpYV1oxZ2/3dH1Yz7pbenu0+fDaWA3kNjyyqhDCDGxiCw7gtiVdDqa7
 Byeh02AJhJwB4UTU=
X-Gm-Gg: AYBFou3ZWufk4c331g3Nw5bpaCB8sl4OIOxSk0v+ZV6i2RMXMWRmQidtXDax7HtBwcE
 wyt/udZusnpBCetG4vAudW3yVC0YF8VAZgNgssvslslxYYTbLGSml3mTaODca4SMK738J3FrvdL
 1ASpsKZjkAp6wW5id9XvPgTIOGEaMV+9ysKlAHp2TPKWD/40ProXW6K0mbIFkjppYJbz1AfGrYd
 f385q+WXQrcaYKN6r1Xeax38m63wUvCo7A1O4euDyiysGPQQEqaqjr4Wa+gDcTrPHL6IOTyKGkB
 ojXJ0zUTyX9wKZwUcFQ24JVyM+lHZXQGveHhhjZBk1psOqripuz9p/K5sW2zCUNtWwPyzF8TI2V
 cBwSuu+EdFr/ZZ9sRLV6pxoHRzE3mOxZVhHCOP0De3MUPFqTfr6sX6R9/zIT3qyAI4I4oPyPPLD
 zJhY94QPh6VHGJztqStUjIEVjL7Bv5aRl+O2xiY1iyW6EABPWYShLhnmNM6ADfTfGD8uRbVkjWE
 QdD3LHxvdCPzVdsHPI5mEB4Ah9e9Nvux0OsHOrnDEWmQ6NImEOWprUQx6gQfPyGf8uH3OEAnxh0
 EktdVi94/8YEdehFQQA=
X-Received: by 2002:a05:6820:a285:10b0:6ce:7f39:7c2d with SMTP id
 006d021491bc7-6ce7f48c1f1mr3554739eaf.81.1790009910497; 
 Mon, 21 Sep 2026 09:58:30 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4881f4d7861sm9261433fac.1.2026.09.21.09.58.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 09:58:30 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <u-boot@0leil.net>
Cc: u-boot@lists.u-boot-project.org
In-Reply-To: <20260918163622.351793-1-u-boot@0leil.net>
References: <20260918163622.351793-1-u-boot@0leil.net>
Subject: Re: [GIT PULL] Please pull u-boot-rockchip-2026.10-20260918 into main
Message-Id: <179000990979.3174152.205896980142873898.b4-ty@konsulko.com>
Date: Mon, 21 Sep 2026 10:58:29 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Fri, 18 Sep 2026 18:35:24 +0200, Quentin Schulz wrote:

> CI for this pull request is available here: https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/pipelines/1325
> 
> The following changes since commit a44f46af0aa17e48572e0d46c0d082886ee353c3:
> 
>   MAINTAINERS: tee: update Jens Wiklander's email address (2026-09-11 10:22:58 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/main, thanks!

-- 
Tom


