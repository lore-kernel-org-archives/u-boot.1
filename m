Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF15606A325
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 17:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=HxEZtNiJ;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Sl+XmEtD
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CED8060693;
	Mon, 19 Oct 2026 17:04:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1OU2X7BRn1cX; Mon, 19 Oct 2026 17:04:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 14EBE60613
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792429450;
	b=T2hWS+sxQC4oVl+XVbnC+9FCwAZk5sqT7kSH0nEbCpRnTkI+ncuoB2WVh2qaLMU6ddFZ
	 UxKRJAk+0Z+703FrTvASS76Vdt9FBNWyUhTxeMVd5AMuQiExLhHgBVFvB5V74kmTsEhzD
	 nsRVR4nQcRoaXiutdTqLYGYetXjQBueX8tTsTqGJG3C9DpMe8SulTSbEP8v19/lgbbakK
	 kGrk3r2YtYot6pSn3cmgoFZ6z1/kx/pDSvlEIaOg2STZMHU0UHzdbwHVAU4wOgh2ZShNM
	 6KdkVq0LfLlQLc2IRssg5MM1TODGk1mN5ZN2MMsFxqA8xMibr+Jwgg3qcbMJzc1QU3w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792429450;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=ndtfzTxLcT+sn7S5xNaKdfJ7n1KP+qd1y4nSnrFG0xA=;
	b=awbmdeZi/zyHV7+yt0Jl2MnORn91i7wAZnE3qpdO7wsNfVuySvPd7QxqiCrgygVxjBLJ
	 HsZbtOJ5kSYtfi345LgJMxerOHTIXiZgabKVp307s1iwuXTCRUfmA3XNNv/yZd+YPIwzt
	 gWYYcELhjE6rTcjP6UjCNkPfjK08O74LQxNPUoTWFMlCCS30bDielxPsscfNkZJinkahP
	 T4lTMYMsgMIW/Q5WPhHH3UQJGR1Q6zutnBe6Ec4SUlT7bfG0bYJsIUabI9y5/dL5OltJZ
	 COh0O0XJaLEzw3tj6mhvTybwAH8XF5J/wUzj6ZPshB/cUzRDR2N+UBBURQqJ+JYn3+A==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792429450;
	bh=ndtfzTxLcT+sn7S5xNaKdfJ7n1KP+qd1y4nSnrFG0xA=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HxEZtNiJD6h0IHiPhJP3MpqyWD0/m3RdZVXVDKje2l6BBn8W3FhKNEyrc+ZQ5AAnk
	 wbMFy0vhzqDEcyXo2YHsQxMxmzeBvY8w7RrFd5Can96YJgtp9ywA8BVQNzsP67354u
	 h9rSLkd8kLEWUswYRIYgRq3CgySqs4RUXl+QDlziUXAmXcBTiC5NW14eDQTGpFyvAd
	 ZWdkue96XJMEvA+vzVPZ9KhZ7FUAdcIZOXXcYBbuF7FhUusUipxMxcXVWycHZawBUR
	 6qsYJETstaLI9baf/exDuS8dPcswPjs0ilIlcR13tTsKU7NtP5o6bn5JbGN9vXCLUb
	 Siw5izAFyF0eg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 14EBE60613;
	Mon, 19 Oct 2026 17:04:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4999A279
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 17:04:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3D6F54066A
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 17:04:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rmNYxt9h8bJ3 for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 17:04:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3E0EE40669
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52a"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792429448;
 b=b0Ak8AQsaOYeVkmTXqIDW4gAQee13W22NBN/Aey8f71O/e7OazfhuB6ej0WrKml5Otd7
 dj0zYoopTR1bINemB8MgaHyPp0Xn263BCCRNtr8pqJMYNr8bTsDNWg64iwZUIe7oBRd/c
 N62PihNJisHGgw8PX9C9nBnLCf5PEJGo1jPMQCWZ5dVC5dogA4EAZEzrXdVvg2gpvCxzk
 MjFdI/tHX+IyEDVdKo+Zc5wv1N7VHAndeCstuD2n7ROAsrkxIG/nOgml0YBDhdOe+iQJP
 WZXSqnahxktFktK6iOcCCl8e6KjV+G3FAUJylsVXDA9BBenFwyfUBRWaMSFPLqoYZgQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792429448;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=ndtfzTxLcT+sn7S5xNaKdfJ7n1KP+qd1y4nSnrFG0xA=;
 b=F8V0T6hkgPYnSWAblo/dGqXbFnPVz/EHAW1hav8sdZ9hVb48mFDoQPgZfrTSge2c+NSg
 5kxGWyEd0PcT1eMHHgn/Y521fLm81bUeb9IHbxzdgFSG4Hm5cugmOeJ9r6Es0j2EOX8Ro
 z4B7+eAJGOXOksCEoFNE4v1eAw3es91BGC5wRmwBg1tsPd7JUwkbHBxE88j1tJmTVaiRk
 QSBmrq5RYeA/TlgMCUZX2vhGvO9X3as6PPY3qOtMInohxna7xf+QsmkO9bgqkdOMxz9eM
 AgMKjpvggYdSJkwdDhPe3ord3LKByDk3PRkf/urHjb125jOrhQaOekXIvHWhXL/Cayg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=Sl+XmEtD; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52a; helo=mail-ed1-x52a.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=Sl+XmEtD
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3E0EE40669
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 17:04:07 +0000 (UTC)
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-6af9a9451daso3385808a12.0
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:04:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792429446; cv=none;
 d=google.com; s=arc-20260327;
 b=SNmTi1z7VpEbkKKD2UVxj4bLWbtKVdrI/9VO7PY+WmasJoM2ZCVvEKdMCUqiHs6BIt
 IH79ssWE1tjmp1DSRBEfadQIgcBRf4WsPMRAFh8A6TRa9a6JxsKXnuX1113LiJk5+yHB
 mExR63Frzd9pitsXujUYBuDYfvNgGRgDq+UEjvHBDa2tibs8V2csEh5QFEL8q858+rhQ
 4391pf9Nd8Qp5h7WLuiaK7hc7CsORabGtSl+W0hsmbjUYgQenYkln9zt+vAbAT13vE4E
 KdjxG/LrGBRWPps+OC5kjzlp0jx8eGCYTslmYrszAu9SB/C+rqCNywbennaa2IcS4QKp
 HnNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=ndtfzTxLcT+sn7S5xNaKdfJ7n1KP+qd1y4nSnrFG0xA=;
 fh=TfTKEHB6d+qXOdfaIQChBYJ/ZotB2AJhmoE7vAvMjm8=;
 b=mvqCTeko//oEAUU53a2oQKOaBIdN+f8NZOct1LVgz1vRCdsLn8/R/orN638EOQpy7c
 fkNBzr3wmNi/hd3vurINWU+NQrzBSx8z5vzKacbqOTrSWnoBon5+qOI4XzmMBrf8UYoE
 T3ky46mHNwZUYI3R4rUfkB+XF//iHjkw33aM9ZD5cIBtU35zYi7WM8RZ7VxvwGd7fvJ9
 BS114DwkEyS4dgDi9ut8iY/E7vmgh01FKuiUpkRjf/LS5qgvtb/Pbmq+ou5mBcDFdOMf
 xDkI9nQTc5OSV9kWhgqdIe4PsmoJYZv+DzTOuZ4VvOoNi++gNww1hJvWPi3AHwgQYUBn
 Q+tw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792429446; x=1793034246;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ndtfzTxLcT+sn7S5xNaKdfJ7n1KP+qd1y4nSnrFG0xA=;
 b=Sl+XmEtDm9SQ5B8c2+nJr3rJMjSMebAmpss4AcaGK9sJGPEbjNfZpQQprUrrRCU/1D
 u9oOic/jDXSk7Qe3bUu2Oi/Hn/9J1w3ZmGKprEFzTzUGiK/u3ZwUy93LVqpBskcqIibv
 xdRHef6QjmI8FYl6l0zmDbmYzaeWDhus75nD4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792429446; x=1793034246;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ndtfzTxLcT+sn7S5xNaKdfJ7n1KP+qd1y4nSnrFG0xA=;
 b=ot8S7fj3/ciHWEuSoICzAs+e8CAchbB9FkbavpVBJQF4QvYqoDkvMqyJQFcfn32rxU
 CjerrU49rr4pXfEgmaH2EBvAAMUqkngK8Klt00HZHBLrurkdKcPyQ9BrCjtBlTFjJWlL
 TthWNsASiDf7A7g5/45NpNYNLzT0NBZ7Dc9ZyTREeVlqrvktx/piy3W242BeIzPqvsf8
 SmsZ7gR061wIvXA/FkvhvOIJGR9LrAKzG5MwY1R2pC9B6Ct9OlZT4ILMRuJaykPJJvfL
 GwZfj3QOpnxDIr1FBEWyraas6YRz5rOfOTaFzJ+w4CtBTmEkKXJWFRdQtHf2OykUS2Zk
 Oq1w==
X-Forwarded-Encrypted: i=1;
 AKwUvBzs8o6BUX8oSI05EWt/I6m9C9Yfit1zZ3h2qB54YERlkiwUbRGSDd2drxKbFRRjPT3j37zvRbY=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYL6tDSK7S5T/1aXgnbP73PArSO6AjXcjFfz/UwnaKOIz3WY/i+V
 KLhbV4Wor3PRbea4R79WXHV+tyMucK+mglcHZ7h0dO8xw4cJZcCGg/Cthsbkw5/DqphSeT494oO
 uKvhUjqS2S3x6F6QE3U1OO9uF5okWsI/F/WCiDuZ+
X-Gm-Gg: AYBFou20NaTUPAYuhvOo8fdIZco5G0ouJadCWqG16/A/Zn1dVIt3JgzmJvHskmBp10a
 4ki7kVpEVUvjsvHImJkdtzIdIfst9LXW8Aif2YLYOns7bZWbbUuZkg09kADqhEfPOE0MI6dgEdU
 ky9/FnWNE9pXQuuQopsnpbsEQaImXxiKzTjybeW5apP3absyFmqwF3BnpaWz9/5a59tDyUZIKwJ
 mD4fIj4V2NBaTv1clazeYMwJrkqmrjcSylTyXyKgOxiUdSkWDhqLuR5FYNz/Jqz4z87dP5/3ICR
 0bXqadG7LuPlBFxksRNJJqlY+Tvcec230zZOxTDYAbDIELNbBYumjZJHfhDxi632
X-Received: by 2002:a05:6402:52c3:b0:6b3:cbe9:7231 with SMTP id
 4fb4d7f45d1cf-6b3cbe985c0mr2386283a12.5.1792429445655; Mon, 19 Oct 2026
 10:04:05 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 10:04:04 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 08:20:16 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261016072526.2277530-2-mehmet.fide@gmail.com>
References: <20261016072526.2277530-1-mehmet.fide@gmail.com>
 <20261016072526.2277530-2-mehmet.fide@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 19 Oct 2026 10:04:04 -0700
X-Gm-Features: AclHuK_ttnQJVV60_Ae_RKp0QkmCveaLeeyPO4-MGsp4RtC9_gy9XFf1whhGh84
Message-ID: <CAFLszThZDt_LaG7e9dFav3Ug82hXxdTrK2PKKKTDBfuVe1MyWQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/8] fdtdec: match an alias to its stem only when the
 number follows it
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
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-16T07:25:19, Mehmet Fide <mehmet.fide@gmail.com> wrote:
> fdtdec: match an alias to its stem only when the number follows it
>
> fdtdec_get_alias_seq() and fdtdec_get_alias_highest_id() compare the
> alias name with the stem by strncmp() over the length of the stem, so
> every alias that starts with the stem counts. On a Colibri VF50 the
> aliases usbphy0 and usbphy1 matched the "usb" stem, the two USB
> controllers were given the sequence numbers 2 and 3, and ehci-vf
> indexed its two-entry tables with them. The live tree disagrees: there
> of_alias_scan() splits an alias into the stem and the number and
> of_alias_get_id() compares the stem exactly.
>
> Match an alias only when the stem is followed by its number, as the
> live tree does. A test covers both lookups with the sandbox aliases,
> where "test" is a prefix of testbus3 and of the testfdt aliases.
>
> Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
>
>  lib/fdtdec.c     | 43 ++++++++++++++++++++++++++++++-------------
>  test/dm/fdtdec.c | 35 +++++++++++++++++++++++++++++++++++
>  2 files changed, 65 insertions(+), 13 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
