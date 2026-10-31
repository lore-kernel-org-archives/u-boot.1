Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85DF606A31D
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 09:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=WXQCcFt/;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=da3u2JNh
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9B7FD811D0;
	Sat, 31 Oct 2026 09:35:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2xJl7KMUeggc; Sat, 31 Oct 2026 09:35:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A80E7811AA
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793439339;
	b=Dw4MWwPqZ3JYdp59wH2mlS09zvm1H1ZZeVQN0ESZwdqZAXt2oBSxoCbgOviEZ/tzGStp
	 YsZPbCykd7ZFmMEX665Lsmusph4laa2ncoswLfeRDQwZjg9JAIQQ8ara4Vbq9NbGtNIZw
	 gN+loiU6OUjKuCEydXlkpO+YbrRw2uZVIJC2/h25cDuNGgz8r21Ds/B4s7JpKlV8KoD8a
	 K/QprqBS0S9bPfnre84ILVm/Fiwv3P1lMlr16WgZ1jT1U+OAgUavBwfv3C+iGdPbd1bMe
	 K1PpzKX/7vAfEyGyNyW2kZ+nOKHRXZhiDQke0/Xkq9z2olr4aHjkefQ914zElo8aZCQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793439339;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=g4ZBZpo4+JX4l58l+8PX1ym9wmsJUu7Ht3xTdBEtq2I=;
	b=KS6AI+FeyMBTp0yNZGcxJF3GlMQpy7bhB5GebvV+ghHgYRzKxeogw/QI28kC5TPVyBAU
	 KrTJ2xxiRiHCHxBQ1pLL+bt0KAYQ/8Tshr492r/Pat5lyF9kPW5KTHgPzRiPTl5w39mIo
	 USs8wceYdc2o5eU6BwBqzu/SlQMiam5PpXBdltPDraK6Bna33o93xilGGl3YMoAYamEDj
	 8Ftq5zoKJvIZTxYAJt6qv88M3b0UbJrjzM4tKyShNNkmt082DfeSXA0yUhN7ftTt0zIIe
	 2IMBCkigcbN5Qb+EHi0bdW6s0bbCcFEYLuJIJrhosNvUmT8o4LH9lMNQ2Tjemk/Nnew==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793439339;
	bh=g4ZBZpo4+JX4l58l+8PX1ym9wmsJUu7Ht3xTdBEtq2I=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WXQCcFt/hWeTttFTADLldua3/Wu9v1q76e9uTnrDPxXu4Op1g9WaiDOugPtHIdxxS
	 j6rP/cGxhKut0amvuEtU2RWFmM6e7UT9Py4AW8h3+T99LvqnGYtou+kyUpvJ+Nqgux
	 LQZ/cip2nDQ/kJ/2ZOAmjHMTrxZv5clCKdPtg6SZIeMmweYHGPSDX+IVrGjnWBgQRs
	 XnqlarJt5HsSU+JstdcMxzJptYDYNSG/g6nSis7dghyi3SOOCrhOhfZKt9BwUyf3DN
	 cXXutiGOrLMU3SBANet/r0324IdfU8IJ+tjpmI8+EvXbpAo4qNNIPEGI8jkEYLXXAD
	 lrKOBRyJ1Y9mw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A80E7811AA;
	Sat, 31 Oct 2026 09:35:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 15A7A4BC
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:35:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id ECC5160B15
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:35:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BH-bwLgWazl0 for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 09:35:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 566AB60B00
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::536"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793439335;
 b=NRWtOHdID4m04+0UJm4k/pssY+Hk/r3y9XWzawZz6QN3EhZdNwOhX13vUeyKaIwMAZbk
 ruNkXnyoszrS3b2TIOmu76mscLoGPUO5HHLFrySmw5SYV0J+ua+kRLO3tb4Qo2jWRkxtC
 nsh5lwbBrQnryOJyqn4100TiunymfXZPixqBAmBwX8uEXgm9KbOmlDZANDBNp4rWKh8M5
 pXhdjnkKiIEX/jRjrHDBvpoeRRzyNdyCx42ot8xQ0oNT8+eA93SqE43cR6kaOV0291tgN
 JwjvHg6Xl0K7ZmEIAcZizgw2l2kDm46h6V/YUm1wuNpOgD2kAgPyF46QnTtn2BlNrIA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793439335;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=g4ZBZpo4+JX4l58l+8PX1ym9wmsJUu7Ht3xTdBEtq2I=;
 b=P/c7BcHlxNcAkIKCZn2+FgjA8a3FE3uEfN1NZeQYTpkgZEoV4Der21L9sW4Ixwj9g8Va
 5qECyI5jzOVe7AqWWLTX3zGMtcQMRCpo9QaujVU5vSYNTKA848qs/W/E73GImHH5Ks5W+
 SFBJ/6VoPyUf1QcFfD0WjFEhIHJPXmEs+PcauO2eHIYzN1lyVjANklxHooEIjBp06Ejxw
 uccvOhr9Wc5JMB8iz3/hH8inOjnAm9/bhGy1it7DCCxWiPQGm3ZLF5uTDilCPUUz4DA2Z
 WG5BQOQAqW8b1P7AZFV2hjZbbnwl9pjqCnmpG6jAF/3U+d7ngdEGgyshDrZilf0xBlw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=da3u2JNh; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::536"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::536; helo=mail-pg1-x536.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=da3u2JNh
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com
 [IPv6:2607:f8b0:4864:20::536])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 566AB60B00
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:35:34 +0000 (UTC)
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-cdab8873d9dso562391a12.1
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 02:35:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793439334; cv=none;
 d=google.com; s=arc-20260327;
 b=QBnbi7c0ospJdCDR2/AoKqy19VLQuLyB/c69FXA9djg2xbpNRyy16wtcog40sJqPA1
 rr0buv+EQMzovLCxF8Q7WTvQTloHXjqHKpC0ig69pK+KWz8ZDmPJ6A+gz5dC/RBKrDwX
 Ssx67jKpsOoQ1M3oOQbV9x9XV7isAPm2JH5lpyANs49S4ALq8SUXqmBNKtkLmkQrKTMn
 o3q0qKeqHXtVLWc/WYiOZsFRDnFH/7aWQv4iMeXd2TF5hofAfgz1oMwNANcL50Hkr37z
 AHdes+8e0YHn9BYkz2QV/KkkoB8G1a3PZ5HAgpy5hy8jvVt/KF30FVD/qtObztg56wMG
 cl5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=g4ZBZpo4+JX4l58l+8PX1ym9wmsJUu7Ht3xTdBEtq2I=;
 fh=/nKHbZh96oMsXBM2zLO/x2sYHjyPlmzJ81EQGadk+zg=;
 b=fpgi6WPYkkW9wVvE/yJdOLIklnq8+usk0ZtTTEp4rYdQFw5ScvLAMGpUZb0k4+EOBs
 r/RDmUnFna201CJNScgYccLpUXb+zH13521iftwOVIwQX3javQ5rcb+UxXjEFvFOEKSg
 qxLzSFRbS7syMzzZadJ7pFHDUf6BTXgwRjdmlwm33P+Pt6fCbNPX+s7eHWs2ZheuejGa
 uDkC2+cpnsu66Z8zTPlwbP0cKm/AwVbt+4b0QEOQW+7d5JFXDUAdq+PtJf86ty2CZI8b
 mGqcepJOuUfIkoTDH+BtEOdtKDdPqmNMaIaay/aLyhJ6IW84kzSpM3zGprDTqJ+hDUID
 TV5g==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793439334; x=1794044134;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=g4ZBZpo4+JX4l58l+8PX1ym9wmsJUu7Ht3xTdBEtq2I=;
 b=da3u2JNh7rpnJjqug2TK5DnbeU5gB6i05P3HAk/kdc7GaJViRmn7AP0R3jmHFKNYcl
 JndZs+wIHwIkPZ+8lFkIR6V7+gqBKavlpoPrVy+UepMpuK3IkLOqI1Z5wv6OHHqo2QEE
 GUUTKSArkYZ+jIRY7lWt8ArNkfioaP/9CCx5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793439334; x=1794044134;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=g4ZBZpo4+JX4l58l+8PX1ym9wmsJUu7Ht3xTdBEtq2I=;
 b=rsuecXKOCyezo28CeVWquGXdGL6Ewl9wzrwX1ZaEVc30dDew2Pzz/x2cplp6bpDAA9
 SP5ffd4B8so7ldY1sTb33FTclGou+CwZoFPbsIKeDXh5vDQyavaq9+xPD+ZYtSZ2NuJt
 UaYsH/gD2FSBgPjCwFRQISbvc2L05CIpupRDe9Gsl5o6VlIBOwQzRInN2hArHLM/FGqj
 VupJDdBOVCrZsLAdEkBwtQpJlDi7q3wZLV/Vj2Fb/HSsO1wTrLal1dulBGLhW8HLx8Hs
 ovNU2x4nFZGP0vZyz53JSKcGCpoVu6YAfoI4B7qTpFFX+tV86oMsEb7x1MyNyOtne7OD
 jVwA==
X-Forwarded-Encrypted: i=1;
 AKwUvBx24Lta8/9p89WF2UnafC27l/ODhKJnhKMTDl81lmr0+FfPS94MBauLqig3tD01kwkJuRbTk5s=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLI2c0Vzw9jKbcq7UsnyVU0FAY1tAfULbgsFRuxvbZf+rIGJ6ok
 dckrgGTBHOw7GQxolGKQvL+YK+h7jK3gCWg+flOe0zi7Sr7hbJzAum21pQ2bRHqMFMrWcG0Y24g
 HtXs5qRHwm2luN1ZF07IBZMeR+fGK0fSJqn4Y032T
X-Gm-Gg: AYBFou1IW87h2/Hpi4/f0p36vCmdyi93bEuXsu0fe3Qt3wcgQz/4d28GaK2/UeCs1Uu
 5AbQg6GUtU2+D4bzP9zIFT4yut3Nb9ffMxsGxBBwLu7wrCFE0/7gn2JrBVY1r+BDx5Kp6iH/7wC
 QBi44X2RA+kHvy2gik0nAv8YuvoHk/QB+sz+9rd8PC//CCaEc7IC50Mug1WE8onZoHOqroAQ0dp
 EqxPuJg1JOJbKYoJNXUKLztNwGSL+N/q+Ovddww0MciFQRr24JqAaGpmlLGEPwVoBDn4n51TbiL
 0KNAeTlhX+uf/wmAgr3/Wi67b2EJJKrqCfcFv5XS43j+p0Sv9B7OhiL8UGdSbTDIb1mZPtvp9Ek
 HWmEpkyHKb1JXIy0RonWrLhZ4uWV5gNrRRoNtv5KPazFqDoBIzv9uISw+R+RrPkOkPjnSreI=
X-Received: by 2002:a17:90b:4a46:b0:3aa:f2c4:12e9 with SMTP id
 98e67ed59e1d1-3ae8953617fmr4251664a91.3.1793439334078; Sat, 31 Oct 2026
 02:35:34 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 02:35:30 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 04:09:19 -0400
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261011222930.1085075-23-jonas@kwiboo.se>
References: <20261011222930.1085075-1-jonas@kwiboo.se>
 <20261011222930.1085075-23-jonas@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 31 Oct 2026 02:35:30 -0700
X-Gm-Features: AclHuK_fuEw-4j040jR_hwtYMkz88k_4OLxMcFgIS5JLnaG_JAnyY7Wt14o1rJE
Message-ID: <CAFLszTjysxDivzR618q55J0TiS_jP-DYd=pRYpuYK_nxLKtHpw@mail.gmail.com>
Subject: Re: [PATCH v2 22/37] clk: rockchip: rk3576: Fix CLK_I2C8 rate change
To: jonas@kwiboo.se
Cc: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Lukasz Majewski <lukma@nabladev.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.u-boot-project.org,
 Elaine Zhang <zhangqing@rock-chips.com>
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-11T22:28:36, Jonas Karlman <jonas@kwiboo.se> wrote:
> clk: rockchip: rk3576: Fix CLK_I2C8 rate change
>
> Add missing break to prevent rate change of CLK_I2C8 to fall through
> and also affect the CLK_I2C9 rate.
>
> Fixes: 3919310b37ec ("clk: rockchip: Add rk3576 clk support")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>
>  drivers/clk/rockchip/clk_rk3576.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
