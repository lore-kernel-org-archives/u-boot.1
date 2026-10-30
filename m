Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48CD606A31E
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 11:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=LSRx6gq6;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WHhmfEac
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8E2A0605F7;
	Fri, 30 Oct 2026 11:40:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5YL9dvr9SvZi; Fri, 30 Oct 2026 11:40:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E0A6D60667
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793360427;
	b=QgiMlqOWrHOJ3isHFHa2jkKQc5EqZwRlNCihpUIKRDFtNgxAgT3I8lvKMG5WfCJ1KwVa
	 WQe7wLQL2TP06E77/ooKHhDJX1EPQo0msTavfBZKsrRI+FMp5OzkD+mtlOh4lOOH2fdDZ
	 aas7e+4NNAY9T6vso50RSZLH9B7xGB8MnBdxb6hTaBhZuSzc8QXeovj/cSOYwYW/z++tX
	 9ZqGwi4dXBPisshgGUQ2VZKrHHkXlHWSVgpYyXL2vzmWdJi2gFiXZGwrsn6otdzAlHKAA
	 ZUCbsM8KhG1IW/RImKD8yKU10SAFeAWp+U91xuJk15k3Odkmg7x95MGfF0WJTR4sDtQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793360427;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:From:In-Reply-To:References:MIME-Version:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=icTHOeolgOMqZCPONvubWblQ/3rCamzWb3PXEXw5+Wc=;
	b=blo/HOixUi/IgQyt8zekl9mN05PrXzEXY2/GleQ6ZpMFyLprbNCqO90P7colnPq88Pv5
	 nCP5ae6xSrqtmfThgbvNFs+M/ekdgdZ56tjpEnIdMAm004MDiM3JZfuSjPE1zXyVTTRz6
	 WxEFZIbkSFQuQp74UG98Shb7n+/wF3aQgXOIa7Uv644uem7BagFlkNqo6WFvySrf+83kD
	 iHr8mgqwRunNI80mBhUGNPsvqiMDqylXeKoarUPu+UDMMhOnrzOvHHzQZXkFFuSuSRuaK
	 6xohOeBh42R1NArXMopw7DbamPgcsQ8nbg8LKyxcRhV6hynqjgaQutqXsn32Yc6aZmg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WHhmfEac;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793360427;
	bh=icTHOeolgOMqZCPONvubWblQ/3rCamzWb3PXEXw5+Wc=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LSRx6gq6sjMZUXnVxEDt+rxQSqlSVoH6ZjBHjtyZGLVFCNCxIFhtrTFc7huAdqy5p
	 oFxRMvl1IRiE0//r4yWZhbXWNeNUkfl0IKcC2Y+FebBr01fn/xuWzpHg0/Od3Pcmdk
	 tWm3bMZ4W4mWzsReUPCeMiFAENs47KVtTXfNZU0s7xMWbC/yWVGr+ATZo2oFWiyx2g
	 tZIXRB5TDSG8TY81A4tXWFgL8wnGqT3sElz/nrIcGwZf6bjBBM0I96Rlb3acX7WLg8
	 JFgPO0tCZaOhmp14du/2l3xLj1VubZjsCE7y7Ua8qJ/VjXZxjMH/S2+2wE2e67Yx0g
	 YVwJrvcLsHRKg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E0A6D60667;
	Fri, 30 Oct 2026 11:40:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 48FF74BC
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 11:40:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2F31460667
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 11:40:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0rrRMtkFoViv for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 11:40:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6867A605F7
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::329"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793360424;
 b=CJdIS4ZgFYErDJfj7J3cmwIuWArPQiMD5uazvg64i5rwKyuPNJg2ihYwAMrVNq2SjL3C
 fC7wGqzp0nZNYokymkjK3C8rOzpg1JO8B7vAvwzW0C2yxwUvPUx/rfd3jamh4O/eGDtT9
 BFCRekRan+LIQfsahalgID0CdrzGNl/UC5jThwN9Fk/jG5zy+Lh46pF+1RB/obw+FJGyr
 Hgbmf1NhopRiGffBa6KX1g7nd8yXtmO7jtn9VeroA/qaEzqxkAU3dtyluPV5wxDLj/Ad6
 VKlhyJEj6CxeHwFyOOwpDiLeqz9awzaM6DMgkJj+xVN8i5aimbwFpc0gShwvoltQcQQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793360424;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:From:
 In-Reply-To:References:MIME-Version:Date:X-Gm-Features:Message-ID:
 Subject:To:Cc:Content-Type;
 bh=icTHOeolgOMqZCPONvubWblQ/3rCamzWb3PXEXw5+Wc=;
 b=a0ZRpCiTaE0gCUIpYahR3YVBsoRv/6JxKrjre3WlWbwzDvyPelrlD9l5z6onFnunIccr
 WCvJmxsR/Wqi9JtNBNbP2dhGovrS0q6nC3OO8FDCmmVXnrwsxAkpiYYerS1at/G8hAh3j
 6oKyKMrufNt29KgKduObDNPmeSn9xl/xTrwNxstxs4jlcp9z/V8GzJ1zDLTOtEHzFeI/W
 UpWE5k0MMCCUdJuMFO0l3DW1rfscy0BytbBkvFsqHoGZEa5tZfBKQzaw8OzaL/D+0ie4G
 5+KMMTixF/nsMKoM8bdYejl/wianU8U8z0t9HiaLfaxcy0HloZAleT3ubSs0jkUByEA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=WHhmfEac; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::329"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::329; helo=mail-ot1-x329.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=WHhmfEac
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6867A605F7
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 11:40:22 +0000 (UTC)
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-8253bc5a613so450284a34.0
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 04:40:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793360422; cv=none;
 d=google.com; s=arc-20260327;
 b=JVaPHDOWEj2nlRC8z6gp9KNa8oBjImpBNfoXrX+nbAen2qKm73JLFDFkm1gttzvqaf
 gPE5uo66jVzdq/GZ7esooSw6u7ZeonIWmVOD8hC/Vc2YabvfVvKWOGvCydaWryTxRHIj
 waDuVRRRqMYof1two1ZuZprNn0+XGRejz7+ENIKYT9BXZGfEcpSouQlnr+rKEVJn5Fku
 rstgz43dFvsxbTMSzDy4QGRfBsGfRGOTvQXtm/8aNk/ItdlTPN31uBIfhr2UU9hXoSvM
 3ThXdi2Gf64s98KjVJP+ZD+mSG6CWQVFEPpqeEnDII1bayw/7IPrrlHgo1KWbGvuYzgr
 nRpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
 :from:dkim-signature;
 bh=icTHOeolgOMqZCPONvubWblQ/3rCamzWb3PXEXw5+Wc=;
 fh=Va7RntYurJVZjMZQwzXwPhWLPlvO/MEIwRi5/HUNmfo=;
 b=Q+EnV9gpIF11/ksKN1imrkV/2TquWi4l1EoIN3ejUFF8cHlrs/DC7u+xnSlmkQPNJs
 +s9M3KWZCDRFd5PDKyXTMa8/1fRrHk7rbiiI/U+mZ0Q54Ft4Jsvy7duat1Dr5gMv/D9m
 ytZ1EQUVkHsXwkv2TeV2G+c8WKXPOi8jm/4O/f5dp+w5Q9D+l+yVv78fIqjdxGTN4A4S
 wrr0mhVX4G+uzj3eD3//4NRuX+7I49SQRGx+DXnr2XBu17hCGifII+68hjeCr7V99IzQ
 HCryIHrWdLUr5bsNIgvaVQv7TJydli8rVmVqZVHT6sjq1isIozKZjMeEQ0a6OUK+aBP9
 svfQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793360422; x=1793965222;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=icTHOeolgOMqZCPONvubWblQ/3rCamzWb3PXEXw5+Wc=;
 b=WHhmfEaci9kU/4oKi5GdjauwzjNpsM4Bn8cDkhfXSuEHk48e4xrmraK+ug/xvPRwOp
 QfqlSlajb59xFO99DskN/5c5pVi7Y3ooh4jnTuVT7oW/hV+xXnISbKL3F+oOPPTjf5zP
 UXD6sp4fEQ6eB6HgthRavHyXGQd1/KZ0tfZbGuoXSNVR537LGWpn2oECdidEViZ185zO
 Vued3LbhePNn6cAgFHhR1TM8BlhGDV+cf+qvAOzxgzgMOQ+y/tsD6dn0ZzBrHjSIn6Ol
 hN3f1N+agsHicMOzmxX9f+06l6CPQwxY1LYdJccTTWX7vLClhJuVI+iEYAa2/AGdnv8C
 ABPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793360422; x=1793965222;
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=icTHOeolgOMqZCPONvubWblQ/3rCamzWb3PXEXw5+Wc=;
 b=n/hnjVN/a9E0/DjV3qAmwRpOmbK/IMgG8R1X3EqpruS3nhiG0uTXaham06V636EzP6
 TEuzU5ogiAcQMElw3YiD950r+tdqOs8fGdv3+HujiQZHB/HnerE4OzMg/ppyx9Y+mGj3
 8S0hLaTpFnZlCzG0/28vKqoOmcF0Pr8eXrYJUGkvWt8ZDUmNEDABqFxGviJWTkPdmeWz
 AAVrkR72Cnv2EbFgaWFeNsDEp7solJYAU+aSNP+u+okxGyFi89L/7tdPU8by4ltQSBo4
 lGXEymIWO8k0bbVrbR6pWjICj+RJjnmwj2qYobVTEHtXlYVrOY30i8T1s+/KjLLVP0jB
 cWFQ==
X-Gm-Message-State: AFq9FYKwH+hkyrzHn9k09n3+T2YU0vUr8ZqypO88X/dMQC6eQUi/4Io3
 pqB6zo8MDlkdzSnSLneGAmlhqCfe1mJeXPVJ81WxbjzPE3eXOBlqKwyOcxJFfqwz8GAo6WEQXqQ
 lQSOknX/rSQ9YwjuplPida1MP2UAzSMs=
X-Gm-Gg: AYBFou27wsilmiQrw6OzX5Ay9NLwtJWL/vyIbGQ6IEbRsaxPOXoVMWKjfnvEoyLGLdD
 cFm/5OmBOMZF+WghYwR08DXUlkEa4IC4wDOGD72plYEtiqxYLZsZ0TAE/ajRKo2D86vU3mfh5HQ
 SGE9HVolBdd+rvDFlQ6B1AuKDxuwaE2J6JszbAhyhowE3I8hPg4PwBaXr4IUWPx6YFyohp6TAQG
 BGmzztJi1XjPq8aPIURwnw36CnvsECwCv3hszmPWkGz0xG0y1dnP1KKEwBqjbnEi0S56LWcUvq2
 NfmDKWfkYt4ROzJcIojC3OEmE4BxxJDqPMyPApXMTpZejA+mfEN54ucD/Wn2PXXHljAKcUt5Q1p
 66xLcN4+RcKzuLesKcVz84JPNAMN9bDTSG08MGg==
X-Received: by 2002:a05:6808:3505:b0:4f6:1ef7:6cd9 with SMTP id
 5614622812f47-5640de4145emr1292911b6e.64.1793360421746; Fri, 30 Oct 2026
 04:40:21 -0700 (PDT)
Received: from 1077388689865 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 30 Oct 2026 04:40:20 -0700
Received: from 1077388689865 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 30 Oct 2026 04:40:20 -0700
From: Ana Bobillo <anabobillo3@gmail.com>
In-Reply-To: <7a1b30ab-d70d-4303-bec2-47d86b9e0fad@gmx.de>
References: <633dddd6-ee22-4cd6-a8b6-cb7df0650fae@gmail.com>
 <b0084d2f-a136-4032-96ed-c4a03e392259@gmail.com>
 <7a1b30ab-d70d-4303-bec2-47d86b9e0fad@gmx.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Fri, 30 Oct 2026 04:40:20 -0700
X-Gm-Features: AclHuK98jUjrJMsfzBjEffncl-Bqz12sP2RFXDYLmJotJRlnvSKwVs1pvK3UPaA
Message-ID: <CAJnxHsit-Ua_GFPpAk0rg05JG7_S096Uc6HjFnAje6fVk5p48A@mail.gmail.com>
Subject: Re: [PATCH 01/10] efi_loader: check the NT header size in
 efi_check_pe()
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.u-boot-project.org, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Heinrich,

On 10/30/26 12:15, Heinrich Schuchardt wrote:
> We continue to use
>
> IMAGE_NT_HEADERS32 *nt;
>
> though we check against IMAGE_NT_HEADERS64.
>
> Shouldn't we be more consistent and use the same type everywhere in the
> function?

Yes. efi_check_pe() only reads the signature, which sits at the same
offset in both, so in v2 I'll declare nt as IMAGE_NT_HEADERS64 * and
check the size against sizeof(*nt).

Thanks for the review,
Ana
