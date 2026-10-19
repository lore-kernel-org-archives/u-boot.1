Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A54DCCF2D6
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 13:26:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D8C2F80F42;
	Mon, 19 Oct 2026 13:26:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cGTDjKT3VS3v; Mon, 19 Oct 2026 13:26:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DA61B80F75
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792416365;
	b=cKKBBRohW2IyLJk6uogmAeI3OlOmpAIvaxzaVXZPFBTqlxmzwZGnEHHsOlIpjMRnTBHb
	 ooXudREA98CUbuBHfYy1yq4x7iu+k3h4aI85BjrcsXMoT2WsJPmr6D4PEG5fWl8FPAtLB
	 YKnRSREirHcMU8OsUOeCnBqBV3I1v0sA2YAZb0Q+AmkaNXirOYKs92rDKgGcaN3XCbiN1
	 Vx2GU7EGzyRd6JUsVIazjasVo5iVIjH3E6yLbCQ1XUG2s6hKDDg/f9gfOB7qxm/n5aKzN
	 AfKqJ94t9YcDGW5MeLx1Toi1pK7ZoNs4Xw7yl6LdoOUfxVCPTGGdO40K5ZxItJXFdoQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792416365;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=BZ/JufzXA3Dfn8ksXD9GNdjagQSOoUsU2eA+lZ3Qzkc=;
	b=oWr6LCFHXGhIx3yQIKWZ96kZFSauU1/hDOOzmm1BCRPTF5RYWGgy/SyjlyhllNsW3U14
	 vvrZtSoGkXfhO6kKOoww9onB71a+WPW/1899EltS8pai1fnjX+iD9g5Q3g1T66ZSEedPM
	 YM8a3t006pyw7oscxcBvX96YYLTFHB33VpxeE37DD4Gf4Ub5y7MLoBz8UMFTXTHOrmF+R
	 Tk4S1eboV0k4T4N1gsU1wdl1w9oiwc3MgFGN5HW03ogW8hxMvCK1E5Grp42YlrKLhGPiQ
	 +K01aJ6HL068DmVB0NsJNLpJgAWHUkoTFydmg169+7m35RWrca/397pKxzJ1tAMNFMA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Ec0p2WGX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792416365;
	bh=BZ/JufzXA3Dfn8ksXD9GNdjagQSOoUsU2eA+lZ3Qzkc=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dRt5cqeGX+6XtORvw+cZVW4uXgibGs8GKd2boUugiDMA76My7LLzcfarw5MyzoZTO
	 TKTB4er9XnsNC3ThxOWssBsM300QV10dfyX+RJh+nWaH0yflOFpP8AUeEAbp2yoRv1
	 w3eYY7UQgixBzRyup/kwRs/wdfMupeavT9PE/mmcHeYC/4MHN0T5V/Zn22xB5BVAAg
	 ovTwUjWAVu6w8+LQZ6+Yf1bHa/vxOsh7HNBB4SbmpCP2EolnUDD7nTyGTWJmJs1YkX
	 Aw6rDzdGcr6N6sZBpFr5HnNYFkIDccxieY2sMATvYqviupnivwzfreKxKTWTJOT5Vx
	 h8WwP5VK278oA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DA61B80F75;
	Mon, 19 Oct 2026 13:26:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3217F1E9
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 13:26:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2EF0780CC5
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 13:26:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DT30qlZBXO2r for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 13:26:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3F9E980C25
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::532"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792416362;
 b=dnzSjX6f9XwAw5rrcL3TC/tMWn0uJa/aCSn6BklOmujPSPCmHlDU3IiemWI8AWq2pHkO
 2oYnHsObCZ/gnNrzCirECX2QuEHHXkjqoFm8EXe/EPwbaEfSd32usjkP7obAjF4ZuWw3K
 ZyXzXrbhX5nfzHEHjYDA2+E5XyjBBfOwG/x4FTJ+z/S36HUXPW6gdPsJSPJaScnzlAtdO
 TV6bmnkKeD2mqpFfvdetwO/Q4oroStzg+5D0SDM5Tn3AncN/GoB91F97v/F8Q373rm6Lh
 8gaREcaGcWI1cnmHGjI3Bw60dVkfk2uLlTA9JJHA6VvFCVUMjwQyBlXxEDucLXpIuNA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792416362;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=BZ/JufzXA3Dfn8ksXD9GNdjagQSOoUsU2eA+lZ3Qzkc=;
 b=syl3H0GBnAW373vOk++kLwxWpgIf17S4PxnYVL8Tnv/ez2W/cnRS2LU9npJmXwip2w3j
 ctXfhP4e5dPlfvZqb4qsQIfQXvoqasgS6EXywwCUJCthhEwA6LA0e0K5iojZ82y4Bjwjj
 RNSOmH0kPTek48KqsxAK53UMX3xuMixRhywd4AdoELH7xYcy6Wjypir5QvbquaTeRZB4h
 tdperLaITjUwTiHX3ZCi1fadHCQpiI2JizvisH2wuvHN6POuIJGkc3QSrbhxn3xuYJjZ5
 axbZAww995CME20bzFgcBzivEqL0VFp11BqcH10tSI3kHIf99XrGjz0SmbojCBYfayQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=Ec0p2WGX; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::532"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::532; helo=mail-ed1-x532.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=Ec0p2WGX
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3F9E980C25
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 13:26:01 +0000 (UTC)
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-6b1ab2ad719so3067397a12.3
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 06:26:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792416360; cv=none;
 d=google.com; s=arc-20260327;
 b=gTmYmBtg7sjR1DqdGBVukzsTeEnV/kyPZWHUANdDNUd0bjcpKLVDjjOLFt1HIlS41F
 GM2lo6+Dz9cEMch5owQnrXJLeJ4Ro9W1eoAuEs/RLpUkq9Tb7mv9LIDZXmc4qAsadSX5
 kFYiMpTlWs1L3vuhLTD5jW9EXu9CZSWb+Ccny9sSvr2fjCDdDzjDfyzFz9uzs15ZWZYe
 qC5lRYoMzhtWamDyi11Hw2Lw7xR+Z6MjhSL+n/KZVz6U1eT1KyRCVTHziIdgP+0vMU9n
 t+3G0cUAFS5JTjn03/uQyPHRY0X0xFpeaND8snDPdI9YYBARU9oTS0i0/N2DnpvjHTYi
 v3Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=BZ/JufzXA3Dfn8ksXD9GNdjagQSOoUsU2eA+lZ3Qzkc=;
 fh=/DD+xZkoNTprFhrw2DcgvRFrzcYjpf6tnw1WZgtxNVA=;
 b=kKrlYrX958pXbFGVPnXNTnybyhoo4tRvuvOsHud0tDq3QKrM0z90BoJ2ecT+CLCRZ1
 pOs3kuoESsq0mSh0veRUSpO7qHtC5/5TyW0z1uPH3/w3uOdhL4deSnusSX5KDzCoEwtP
 ZzmjIHzeTK0jU1i6tXJdopVtnfLi2smgSjQDIDN2w5rriQMQWmKFgpGOmN2aON7q3WjQ
 hJgYqPxROPa4r5xMWTMIKaLVlNlcvvs4YaLbM6i4y+/LqBVHzQhK7ZSUM7AUdfW9RVL3
 vvrlu+DyMdzVkG6r5viUDf/MAI0ofnY5AdroMPtN0WpvbW9sDfUuq4TZgYZhNGg6f+RX
 2yfA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792416360; x=1793021160;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=BZ/JufzXA3Dfn8ksXD9GNdjagQSOoUsU2eA+lZ3Qzkc=;
 b=Ec0p2WGXdM9+vlVjXr6Iespj6K8wVxP3RfwMH++HDs46FaTe6U2ephRpIiSeV6am+D
 MgS9Zdy2uJ6kbAx19bDAIe4qcqt95BT+dueeUOWyUYwDAVHocAvR9Xdd462GNuFDJ3h/
 OfL4OjN7z8Skw+BQpOzPLRRRUFucLJOST3XY0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792416360; x=1793021160;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=BZ/JufzXA3Dfn8ksXD9GNdjagQSOoUsU2eA+lZ3Qzkc=;
 b=fXmuV8imDqNnjlHZURqBGCosPuDWRy1ayOWUjiT5mipM215t1lwmcMWQ6dcrXvmlWS
 v2F4BRZwqYKQTrfN/rmv/CGw5SILswTA3hx9vpw4qp3VR1N18++fyS1F77yMgU0eqTZP
 LeID5ALx3NnbLVT3n8yrUiAyUOXM285Ly7lXej71OUMu0mppacaYp4XezHK05P5qUSWS
 9WJfk0j+fasY/9ra4sVH5KII6d4/Ea1ugZPmfyMaJOLHjs5QXQih3FLn12/t24zUd3xz
 CIP1AooLdhm3LAwY9eKbRwa5Vy4VX0X3qfnQJlDUqo9bOOQGoUpq8neLs7H0nmm3cDkZ
 LuOg==
X-Gm-Message-State: AFq9FYKUZctb9Osqvlx33GAPvHExF+7TMigmUtKtGT4bYOVYCdEoWIea
 mC9p0EPBaTaEbwnWw7up/p+8zOI1DefqetbdDCHIZ/a80vgoY0J32wkbrNeyO6w7FQA99b9Tu9w
 E2Gx3zwHq0rPscpVFg6f8t24O3vwvLv90d+IOuJa1
X-Gm-Gg: AYBFou34xwXb/LgW+yGUs4V5/xsS3LWK3odcHf8WrdXjAtQUcfD0MMFfVPOJw4bvYyM
 2eVoUriq+mo7K20A23hkO/9l4cAN6RuFmNgSeU7GEfc99sZ351gBd5G+4hs7cOuZgSUQgGVoDWz
 6kROjqrBI3yH52ZI8x9FKHm8UKTvXWNkXCOr6tbL6bTjp0UXio/fssUaaBs0EA2bCfytgfg1QLm
 Mp4HqgAbYx3YApBuPZAxtLO7S31HP1HDnMkj8Ezqn4toC+Wb+N+2LDlSb9XHYt/UTh7QE736J1A
 pQJPaxPueud3Y+gmGKlvW0QAo2WQzQGuAKQmSR7PXE4U6wdO0rWZ3Q==
X-Received: by 2002:a05:6402:20d8:20b0:6b3:d0a0:22ed with SMTP id
 4fb4d7f45d1cf-6b3d0a03633mr1183018a12.9.1792416359993; Mon, 19 Oct 2026
 06:25:59 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 06:25:58 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 05:08:59 -0700
MIME-Version: 1.0
In-Reply-To: <20261017184622.3925389-5-alan.tseng.cs@gmail.com>
References: <20261017184622.3925389-1-alan.tseng.cs@gmail.com>
 <20261017184622.3925389-5-alan.tseng.cs@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 19 Oct 2026 06:25:58 -0700
X-Gm-Features: AclHuK_kFVzKMre0-Du1_e1oCE03_U2-laI0DC-g1hxLcB4_NmmSkjVI5omA-Pc
Message-ID: <CAFLszThoyohb2BCaf5Qmw2icN7FvNPb3M5TJkwyfncUXv1s0cw@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] virtio: sandbox: Let tests emulate the device side
 of a virtqueue
To: alan.tseng.cs@gmail.com
Cc: u-boot@lists.u-boot-project.org, bmeng.cn@gmail.com, trini@konsulko.com, 
 visitorckw@gmail.com, sjg@chromium.org, xypron.glpk@gmx.de
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

On 2026-10-17T18:46:22, Hung-Chun Tseng <alan.tseng.cs@gmail.com> wrote:
> virtio: sandbox: Let tests emulate the device side of a virtqueue
>
> The sandbox virtio transport ignores notifications, so a driver that
> waits for the device to answer a request cannot be tested beyond its
> probe. The virtio-rng test works around this by writing to the used
> ring of the driver's virtqueue before reading.
>
> Add sandbox_virtio_set_notify() so that a test can install a handler
> which is called when the driver kicks a virtqueue. The handler can then
> process the available ring and fill in the used ring, as a real device
> would. Without a handler, notifications are still ignored.
>
> Signed-off-by: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
>
>  arch/sandbox/include/asm/test.h | 25 +++++++++++++++++++++++++
>  drivers/virtio/virtio_sandbox.c | 15 +++++++++++++++
>  2 files changed, 40 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
