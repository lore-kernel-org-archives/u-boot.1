Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4038606A319
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 17:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=jeVD9L3O;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=RdxXFdWJ
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BCA2760727;
	Mon, 19 Oct 2026 17:04:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fnq2VzWsMCM2; Mon, 19 Oct 2026 17:04:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 121236070C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792429472;
	b=FKCV6Cj//XnCdxYZYCFwnaqoGDcXodQROQ8axj5lWjL3a7JuDWFWYCWEYv255Uxsyrzw
	 Qkc5BUMQiB5yxtNphlZ9IJNNvwXaEtP0M7Oc4kn6jhArvVhmZQtwJcAwCzM6DPipBZGW+
	 yCFRnQCz771vzAQ4YmK/Zmvj4/so0w4GBC6DyA2IGvz7mYfh2G0ZrOPApF52Yd6gDj9Wn
	 atZXsRDXaye8HcRvn75XOd9DhE5Wbxf6UE8W453TUhlP7Md8HLJEadFwGOQEZDntFAXA4
	 OVo2RJeVQuP5GXFrCzOmGy3HoGgFFsyZKSUY92yz03ZmsBHtPXWQei6qaZloGN0RKlA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792429472;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=UbejfGM+5Oi3olE+bNW+WiysalHtvWNXwBw9ez/IhKE=;
	b=TBVQi0tzo/XbToVRxdjavttBi/Fwn8mMWTvyFgZAj2B2shZEQZdNTNzYM75OgepimFno
	 FtP39boB348u+WS8u+NCF/NTPAE1H+AYg/49SUCD9ZMZrmop120kxk2Q7XCiVxiJ61/ou
	 VQHylEpaN3QwgtKKG5m3NZu5LrGdETrYPD7LqwwyB43rfOQM/XDJO+cRLDPiOS//q9kw5
	 r5dLEB2vBCnYX2NCg7b4/SYUjdalMtkXqufZ786WTqC42wEIlzljdQuBY+G4IikLOENUG
	 zepwchQSwvBGI77WVa8V3WPF8ZaBbbnrRf/5ZC5OW8gsI8hsr/U96VSoNzdQqIFQhAQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=RdxXFdWJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792429472;
	bh=UbejfGM+5Oi3olE+bNW+WiysalHtvWNXwBw9ez/IhKE=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jeVD9L3O9IjXZ8fyZjNuCe0dq2MoXvWPUlQEFdPShCWvOXk1w5aH4Nlw82v68+FI9
	 mGd6NBxDDtj+cGQ9qOIVjc3hmNF1MD/WJfCDnUuKiwZi6Kzzloz+Iae8rvsJ09jgUz
	 53q7mA20tEh4kqda3Cl8m18LhtxcpxqqfzNKBDqUtDuOcIrl0q1tvQIhPHL1/29Cv+
	 l3Tz5+eLhHYyyMAYH2kTI7vjAl4JyiTa+ncQIyZQuxBnDa8UREO6yXwcGQKymEXaiS
	 rebqHEqGpCq/E1mRjbK8Tqef7JvveAs14i8XvJXnJ+yyLJQ6x6921CJbrwlUCNPtGz
	 mcQ0RmwezOaDQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 121236070C;
	Mon, 19 Oct 2026 17:04:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id A025E279
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 17:04:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 867596070C
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 17:04:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ni4-cJy7Faej for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 17:04:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org EE59560613
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1030"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792429470;
 b=mFfLhemBOFDeLpz7Usin/sEoK+42TZo0x4z+j4qIbbg4ScFL4EA92DskPQJrgEddvp4d
 6nZMCwbn8Ojqp5MyuXYlBO+1Pr8QXWHETV/NmXSgV+GlSUNTRo/4rPEcs/fxTlAuHeINp
 YeGvGnTd+35qePdxxABNNBRJdE9NGEiTdNxurZyubhNr6Q62/HugxXmQqDaHibS51Nfyg
 cpVaOdtSdAWj96x+Clf9MNm5CGF+GDCFdcbAG72QqxkIVfwv4FfoSW1cLcXrFJfip2E1F
 +FcUKXXcIVOdInTRTzxKu1+OUo3gu+KIkBbUxsaPExE/RdQQ2G7uEfpigWicR6a92og==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792429470;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=UbejfGM+5Oi3olE+bNW+WiysalHtvWNXwBw9ez/IhKE=;
 b=c4MOP5D6a9gHhU0vH1CC7qeBcWZ0cEOaNL3iojFPpbKA3c6PpeFhVCnymg3WvG0UENAP
 KJdOhUw7BksdhdI8UGo7T9AQfa2QMMconK7ZDeotApTMa0c0NQjjE/aVPE2kxCoydkbf5
 TPa9mtQEq9tNaB2H9L6IMeAxGuPyYMhDcSqxSFnpkn+Vs08K+NPC04QU/qLfr3npQ1rfv
 8m2ZH0iWWH4Wx5xLYOvqUHRMMy8usFay7FE2R9BWJth93K34qcyDryK66rer98xTYANEO
 nLI+W1YeBcTvFADNRdVCo3UKni8GXEZVxsjTsMRtRTUS73pyx/nitIqwFFzncl3kjZg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=RdxXFdWJ; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::1030"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1030; helo=mail-pj1-x1030.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=RdxXFdWJ
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EE59560613
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 17:04:29 +0000 (UTC)
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-3acb512a7a0so1299977a91.1
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:04:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792429469; cv=none;
 d=google.com; s=arc-20260327;
 b=LZ46AsCmPfspJ6ttB+HbzL/7pplOGT5Oa758hqjmJ+tfnajjgJeDd2EhUwWJ+vfUKb
 +G4oVkZnEpvNAw56IPtzj4oey1euDEkOfTIAKEj6TxwRtb6v2cK5ZUl5WVADRz86JoWV
 vBQhYZH6BEcCsaCYB/ftUVh91PtLSHy/fq/OjDbzRYPP7w7+4BLMLMo0Te6hFjftFFdo
 Gevkzh3oWPWHGwjTE74/gmHmZ0PoXnEb459AVR2j+4WbhJIIl6lVf0ThJeq2BGtE0tzm
 7HEIb7sJfQpu5ic4mM77hjP58Mbv2SUgljkxOa8YcTpRWl6GdJ1n09SdRFHm8WkUlMa8
 DEtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=UbejfGM+5Oi3olE+bNW+WiysalHtvWNXwBw9ez/IhKE=;
 fh=++JBzAePevSC6uMi3eSxCjkmfuvC1IEYkZ9XG91cAsY=;
 b=IYP3N0JshfEBQSMbybrj+886b3aU8nNYjEZhyk3JJxOB/L1cZIBNOC906Be2yEl3Up
 tPVblctRyDsjc8kbX/5Khd7OnD0BuAERrkJ8n7d8Fb2sXWd+YhEfTt/kHhLc0bwKXbW2
 jcxrTEeXhcsq1D9Su8DtpZlkU5r3xIoMaiUCUVg59cKn8A+xlvGErxx2I2eno8g2fzTe
 VHuOTcs8xv9AL9qBToJN1uLvDvME4syPYCFUHGhf190gMoJzRn7JSf8MybuyKB0JWvep
 5gGCcb862MJi1zIFkCyDd/7Rjug4qfMsSDu5u2dnO38osJUIpnpp/6WJW5kx2ca0qMBC
 YL3A==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792429469; x=1793034269;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=UbejfGM+5Oi3olE+bNW+WiysalHtvWNXwBw9ez/IhKE=;
 b=RdxXFdWJ24QPWScdWUepWXYdcOmLHJymh/bHZkaaq33cGGWSK/SDaPfwFGtVai02SW
 A8GMrRuq9AanLrgN/r0kVpCQ5S9O3h7mAeEWoiKB23g2r8SG5MIx5lCO1pAelcpTDivw
 2VyOKPifBBrI6FNCPHLO5lxnHESjP4qWswZOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792429469; x=1793034269;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=UbejfGM+5Oi3olE+bNW+WiysalHtvWNXwBw9ez/IhKE=;
 b=XCYjUO1UWbzn/fGnOmKAisdCKvCkcB+lacXTGDNX7PArQYqNFSvyuJMCfKU+eDXRAw
 LRoBrjebwZQaEHdJBzrLWVFmJ0r0a4s4lOFYV1YWJoUafY0TE8kGwR8F11CFVZLvTiQZ
 RzPlFWiXTuLDe/14o8vd+okycn3rfGCd5Pgu/pacMA2W0xCUmLpRLKpxTHb9EYbloWbw
 9iDyMRfyYBFqHIZv0ahg/4PvyEPfDAxfjyHkullpKyd1m9A0pux0H4KAyBohuTtRkmdF
 eFT1IINlKFn322AFPUk419h4ENisVuMuOSHfCGJusSki/XKyIudDwaGi0HvbQi1R1axw
 eWqg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxkuB/+OHxZoRF2KlWLdPhqTJ3jxYhZcMzaG5wYOC1wGxBt6q1zdQENN9+BMTvpk6YQDP2N4dI=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYI8PWmKg6VKhrECQg/HtfXXaZF937pLHrXy1lHlrReAYEnfS422
 omDqyH7/LSf3IoZ9PFWxbafBRj0mfhKHpuvSno/jJdIg4l0Y+WI/6KuaI7xw1YDklBUFVNZsGCN
 VKxVm3C8rrLHux07yc5xb8YOAumsWFl3NgGcdvdaE
X-Gm-Gg: AYBFou2a0wbVBcdNh/LmiPsCUuExL2DIo2fYjTcn973GeHF343ar95ecwb622TfVbkR
 SUPDgKoDJTLKzfHjw+gDLPBZnq7TfbybhmXdY7xLe7d3aAkt8bc4PVSvzejdlN319COHnw/hXeL
 n54HjP+PtI97YdketSlPC8WF/uXXc/n2sBIiiuz6adyY6ZcYOH+KMjs965uk/QJurPIkEFIqDnI
 3ockywtElxAsi+hoTFutQIiDOHj/vhggrwEi5p9NGoMOj0VUCyGuQ7UeybU1Ga0Tv9ktLRO3P0K
 z5M2YZCfrBnnNmEAXqWv55TFOmi183jMu83cuxhY71lZci2iJyHi/dmAPOYTTogE
X-Received: by 2002:a17:90b:582d:b0:3ab:c674:cad9 with SMTP id
 98e67ed59e1d1-3acef519dddmr7469245a91.54.1792429468835; Mon, 19 Oct 2026
 10:04:28 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 12:04:21 -0500
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 17:20:19 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261016072526.2277530-5-mehmet.fide@gmail.com>
References: <20261016072526.2277530-1-mehmet.fide@gmail.com>
 <20261016072526.2277530-5-mehmet.fide@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 19 Oct 2026 12:04:21 -0500
X-Gm-Features: AclHuK_HV7jUXG1vvU17W9I-zM4i1DD64GR3b_waJzeMjBjygj8hNg5jLCaZUP8
Message-ID: <CAFLszTjJQMYt32qUL-oXySTHcYynO=gR=NLNeprNv4zHGyOGNw@mail.gmail.com>
Subject: Re: [PATCH v6 4/8] usb: ehci-vf: drop the empty bind hook
To: mehmet.fide@gmail.com
Cc: Marek Vasut <marek.vasut+usb@mailbox.org>, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>,
 Stefan Agner <stefan@agner.ch>, 
 Francesco Dolcini <francesco@dolcini.it>, u-boot@lists.denx.de,
 mehmet.fide@screeningeagle.com, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-16T07:25:19, Mehmet Fide <mehmet.fide@gmail.com> wrote:
> usb: ehci-vf: drop the empty bind hook
>
> vf_usb_bind() only returns 0. Its comment describes a hack that keeps
> the second controller from taking sequence number 0, but no such code
> is there, and an empty .bind cannot influence the numbering the uclass
> does. Remove it.
>
> Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
> Reviewed-by: Marek Vasut <marek.vasut+usb@mailbox.org>
>
>  drivers/usb/host/ehci-vf.c | 15 ---------------
>  1 file changed, 15 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
