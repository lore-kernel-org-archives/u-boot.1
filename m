Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13541C79F8C
	for <u-boot@archiver.kernel.org>; Wed,  9 Sep 2026 07:08:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A9C51406C3;
	Wed,  9 Sep 2026 07:08:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MCma-zq7dBzW; Wed,  9 Sep 2026 07:08:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org E271D406D4
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788937727;
	b=XU0OAi7eI+YvPLn2+IiKoye0r+94qbe04lBXVVQA2HcslSfzU+lNRLDqcMu3qzR8j3HL
	 XI3IebwZwCzIqBBIyr7ThZsi3EjmBW+qCfLCuxVybTiFYWjKP4BW+iYBbyZ+795E78s/u
	 HaI8bJkFN+gp9EsI2ntFaK7bWXth02hElrSSwOGtmEME6SinW3cZ5hide87NUYxJlC0yk
	 UkPMlYuwU8qdQ5kBnkRprA+bHj5M1K92WEn4e2uOs5uSxNifmRVbpUsfYNU+eFM0TmW0x
	 NABBYrKtcJg1ABVg5T+EB/vyuYm7HzzTBzdq3CcIznGtoKTBSlceurXcYIMiUU1K3YA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788937727;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=pzzlMbT9zR2b7T/uoO168PYKrkmF7HQhXQelK6zSY9M=;
	b=AlyvWw7EB5NwixNebSdUkhbr7cRvRbqlLNXat51mw31E4DGyqtQq/562xJto0B6LPP5m
	 X2eCtOIU0ts2qowDTMbAgpX8tOy/nEI4ASdl7Lc8KkH/xkLuhhlHVBp3idbjvvBtmQNrG
	 Q42YfnrIq0hohvGAZ0drjDVxQPCDEplfj9ZAO0bO0TDdZJG04U3lTbOfXElF5NLJDLgRz
	 Jn5DmlR/BVFSYyMoLCNe2bLxpjLZyu7ZBXgi4zSeoVvljA7IsZwYWdX/u7Loblo8gKvmL
	 O21Qe/LM/gvom9m/DCHptVvm/7M1B49VlOfb7Rt3sU+PlpfNqVnBc6Bmvjs3XIPS/1w==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b="X8B/wB+H";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788937727;
	bh=pzzlMbT9zR2b7T/uoO168PYKrkmF7HQhXQelK6zSY9M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zB9cR5QmPV6W1hk0YzvM7qaYBXepKsfPWphRyFoBrwYAgEFM/reElcaULGh27U+hE
	 cCLPxP6FUu+saxmkFZYl4V6d5GiqarRvdjEAbiisyXzYv7h/3+y0lqG7h6bZgkQYRS
	 ZhGd2W3R4hFiutnzCDqFc18HWyB9rWY+ZroOutLZPwW3gEV/a0Wwp/zs6HB5e4/gEf
	 QsXy6yww+DeEta5htTFTU5LxG8SFWY0w8P1/eHSyoOw8HIxOFO1tnCQcJPS3ldt2/8
	 4E4Ym45esZ+Xgle2x9ibc1Jlc+HRHmAr8BS+kqo0XvODj8m3IF+vUoqgtdPReOoqId
	 LxEZTVpdPrW5Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E271D406D4;
	Wed,  9 Sep 2026 07:08:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8F5D229B
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 07:08:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 81169406D4
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 07:08:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CMPf4DR9VETH for <u-boot@lists.u-boot-project.org>;
 Wed,  9 Sep 2026 07:08:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 83806406C3
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1129"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788937722;
 b=SR1D6waaf+B/mRwmwaAOVjB95JHvSpMYI9HJHb5BRpj0oSsq0S/SBTIfXWxjpAaVvn+b
 F+nXTtdWeSxs3CwTZBUWZ+gOReMjfQLJvAnC6E3fPxSSyHPLE+LzoMrT92OC07Frw/lNg
 uZAPeVDhmrvhFZF/26rPz99vVEus019XNPI3bvdL9906vWNuzdoDd4KuqUGCrrD5bwYss
 6oJZCDPkqnyC1CCZIkSejL6axhL0WfqJMKsZK9oPfPJapIR2E//vHbR1++VpbtB9GWmFY
 rg6FOXqQAfDdNYT/r9VLhQrwODPmp1GZ22ssqGzNF7wDlSqlf4pC1dXRFw4pboFPiJw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788937722;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=pzzlMbT9zR2b7T/uoO168PYKrkmF7HQhXQelK6zSY9M=;
 b=tcjmRkLsav1D+glPk4K2xyihw0TaJiI6EnL4EWOd2ZH1sUhU4k9CPIvPqaDcrQPBYXfX
 Zsqnu0Y4S/mq4GWAk/PLH5Pg+rjvuVEIiJ8etHB3dJurwJ78x4GJumoyBnxDV21v3fb7j
 KtnGGtxeJPajzT6/ewpsI+DoTBTN9538Z2pKxhHSxQW3iJHLpB+CFoQpRpwQmvGwJ80Ya
 rhMop8E+P9Dovs8uOEX/SZyiekdccUQ9LC//lBK9Udlq49cWjvJ7Y7VS+nJl4/c12lmeE
 SAlgHCflcFmczOthVI7khjUQtqE74omZwN1cORbgvMtl3xRXnGXwojros9sD7EEkZUQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b="X8B/wB+H"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::1129"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1129; helo=mail-yw1-x1129.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=X8B/wB+H
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 83806406C3
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 07:08:41 +0000 (UTC)
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-8565d77c277so71796097b3.0
 for <u-boot@lists.u-boot-project.org>; Wed, 09 Sep 2026 00:08:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788937720; cv=none;
 d=google.com; s=arc-20260327;
 b=TIb0qDpFhl8qBRnolnkkMRuB1un50Hf4JnZnf0ZGVlmtXFS29bvket9IMximcTI8w0
 FgZ1jBNUOXnzAmRUFBLH8f/8ymEOjLx4jHNQZdmGr6BhGCtpy8Tq5iwC/+KmziCqY8V4
 ex1Blq2Zik5Hboh/b9mmlsGCVi9aqDFvI1dbxHzta9rnYcE7+wQ2qJZPlwccy8bUqaW1
 hvI4VfWkRO7EC6i8TfFZimM4x68HTNlCW1jt4/tJAtDUL4l8JlGcmiCT0qptXeC4iOOL
 wdTm/rTCivZ+vwJblJrWA7Azlh4iNoRbSpTXMIdFzPZWP/lmjTzIlrZic4A0M0RWVTAI
 Qdmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=pzzlMbT9zR2b7T/uoO168PYKrkmF7HQhXQelK6zSY9M=;
 fh=tNLf/+MrBZDRr7Ng5fSui9q2ZXbx1IfYZXPMDuKbLt4=;
 b=qd6BqCdABQ8yJPZELChPWExHKHjrHMwiUKNtJ5yM/dJY+8OSCWMRNRefLxxh4sfMfQ
 HanTHqUfLpcM7+r194sP0BRaYgKRip/X8QiNMOOZNjd81nBH/d3IB2/u/BMUyGe8vkvY
 4fWO95D4rtJUmDzn95tRUk6iLK+QnqdJFDWf6cCgJrMXFgNe2ZjApQ5JtRWmPqzJtDq6
 k7kyFvocoheKJMlIhjloAkqwxZH3ypZxcDu4Vf315GHcpnPG/QUHi0U8am4EYy3Zue5N
 XCnpGmN6+mAWPSNR0Rob4AwV+sCNr9h0mnPpTGSJr1kvL5IghccxKu3HLSLyKKZILx0F
 mO+Q==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788937720; x=1789542520;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=pzzlMbT9zR2b7T/uoO168PYKrkmF7HQhXQelK6zSY9M=;
 b=X8B/wB+H3jTwb9FBQnBUmvZnNQ50+3+pwf66eJgnZcyUxBZXAKmL7ouWWmRrv6DikE
 rN1ATwaXveHo1FjJ3eyPS4DAelbtTrdMbBrRUznZhBGOw6FMHNK3BOa7byNrmT59JkOy
 VlIGlandRHsQf756jUJ3Mg6+RrSqPngzmR7O9yRer2aR4zex9DAVLxUFARNZqNYQM0+M
 vIhn9nw93iEaOau+MRCbnmrgXlssf4pPNPYbMCVtBwGEtsley9JSerWWbn7KFUjZfxLL
 /vScnqE3q92YlGvQ8y9Ab9HzSkjyf+ySqT52sKFWKExsGR88VDPJa6+QpdmV1FzeG0mX
 mm3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788937720; x=1789542520;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=pzzlMbT9zR2b7T/uoO168PYKrkmF7HQhXQelK6zSY9M=;
 b=rWZuyjRCRbgRmWWNgZItXZHcHldY9i3A66qRl1IBezC3BXO8+9gnkymBukHb3LWJFE
 2jAdfopXR7euiUXc+o9cwSFCkZWt2sQeWEsU0d4UEkZrU6Ig3TCBN6a4i9aBwwv68iZl
 cBYfliYnQs1hkw2N4/WBejU7khrC0OXyXlCExZ4klZia7ILta8CFnVxrBNrNwtsVZyKB
 qEYnsr8LXC+WhkNLtkcVdpmnmV9f/3AB0/jE6cqhOBmvuHkniFq57//RU/SYv+coCD8F
 GKfBMKJJ27oJHSN1erU6Iol3UKOcAbSth7zCrBKuJXqvjDA3QrwCbwpSRHOp+AdsoMMF
 8N/Q==
X-Gm-Message-State: AFuF++lkn3wLr2t8HGtPp+2pLWRVgFj3/c3qSEzZjYyJapmMwMohOEch
 lnjtd3537eh2NogLAk/Ombx9BhwfJYpp+JFyIpXEA3AtUfXQSlTzlKH6/lMzCbJGZQ7ehMVQMGB
 JAf0gS22uFFBEbqKhp5iSCn7OtT+5eTYy4OZIFjJ44NKs1ggWXJQGjAX/+w==
X-Gm-Gg: AYBFou0umY8JD1nGFxA8wnHX9LA5TkvByf8Svish5G7W9Kah9n5It+nTrWUG9htO5eD
 NKsLUweN5VALMZcLrX4XCMM9bSlTbgfJluEkQmfh9IQkTTJVNXun/TZWKazE39dkxNsg8mYzkyz
 4umpAiVFyFdKtGHtOYwV9bN3KKvB9p1JR+6wn/MkVvIKBNQdpsVYwDbCANz8AegiR+7/zAh6rVF
 9TaeTfvzPGRUCo6CCX+AYasM8Yr7WFdsw1a7QQ4Ly3AjXzNRM6yLIiGokOBl0msvoOhtvqBbeJz
 m0+a4/o1zk7k5qtT8Fl3d+bcP5RGBsb0lhels8bkSQg6VbhHfFa617awDmNjqAxHZBRPPCSIEZM
 ZJ8pUhRZ61MtIoECC8s14xCKM4/4/4zCdYrNyafGS7X6xNjCt8b0eOjf5/nsNjkLWGIic85T+yB
 par3+5+cfoq1WHpAHBZc722xqOEo7Oe8k0p+FFJyQ9dEI8mtwt6Bp+gwxwvwap26jpFjcCHPj3L
 L/3uQTSiErFLFo5uPQJ0MWdLvrVfWllon8+ZpOptG2iXIefAwdl94G/dgv1hfkQHCgcCd525zR/
 U/dFIZN2z3G367FhxYJjvzat6g3PA0Kcb4i3rMUIP/P5zlyJgLVPISmu/MsuwOJGGSjHpk5Qmv0
 3nyKz8d04tkJJZ6d6ag4WhBA2jB4YuYi8G+KxJEL25VDphxLJJ/D6GQ==
X-Received: by 2002:a05:690c:c:b0:873:5c6b:a2f8 with SMTP id
 00721157ae682-8735c6ba5e3mr98716437b3.38.1788937719688; Wed, 09 Sep 2026
 00:08:39 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1788879818.git.jan.kiszka@siemens.com>
 <be1c09bab90ef372999f78b8e369d8c0eb2d6246.1788879818.git.jan.kiszka@siemens.com>
In-Reply-To: <be1c09bab90ef372999f78b8e369d8c0eb2d6246.1788879818.git.jan.kiszka@siemens.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 9 Sep 2026 10:08:03 +0300
X-Gm-Features: AcwNN1UU7pH7o9_fNMKPrcU-XFKkP8fsUo5LTdeX3U4FYD94Wv3Cf-P2e8OLl_o
Message-ID: <CAC_iWj+b_9BSxym2CuhA4+uMsc6pnN=a0rPmKfmr27Quh8fBMQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] tee: optee: Factor out service enumeration and
 binding functions
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: U-Boot Mailing List <u-boot@lists.u-boot-project.org>, 
 Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
 Sai Sree Kartheek Adivi <s-adivi@ti.com>, 
 Alexander Heinisch <alexander.heinisch@siemens.com>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>
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

On Tue, 8 Sept 2026 at 18:03, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> This already avoids code duplication between the different enumeration
> commands. It will furthermore allow to implement a third one for
> services with RPMB needs.
>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>  drivers/tee/optee/core.c          | 33 +++++++++++++++++--------------
>  drivers/tee/optee/optee_private.h |  3 +++
>  2 files changed, 21 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> index 4d67c948ec1..2871760a7b7 100644
> --- a/drivers/tee/optee/core.c
> +++ b/drivers/tee/optee/core.c
> @@ -156,7 +156,7 @@ static int enum_services(struct udevice *dev, struct tee_shm **shm, size_t *coun
>         return ret;
>  }
>
> -static int open_enum_session(struct udevice *dev, u32 *tee_sess)
> +int optee_open_enum_session(struct udevice *dev, u32 *tee_sess)
>  {
>         const struct tee_optee_ta_uuid pta_uuid = PTA_DEVICE_ENUM;
>         struct tee_open_session_arg arg = { };
> @@ -176,31 +176,34 @@ static int open_enum_session(struct udevice *dev, u32 *tee_sess)
>         return 0;
>  }
>
> -static int bind_service_drivers(struct udevice *dev)
> +int optee_bind_services(struct udevice *dev, u32 tee_sess,
> +                       unsigned int pta_cmd)
>  {
>         struct tee_shm *service_list = NULL;
>         size_t service_count;
> -       u32 tee_sess;
> -       int ret, ret2;
> -
> -       ret = open_enum_session(dev, &tee_sess);
> -       if (ret)
> -               return ret;
> +       int ret;
>
>         ret = enum_services(dev, &service_list, &service_count, tee_sess,
> -                           PTA_CMD_GET_DEVICES);
> +                           pta_cmd);
>         if (!ret && service_count)
>                 ret = bind_service_list(dev, service_list, service_count);
>
>         tee_shm_free(service_list);
> -       service_list = NULL;
>
> -       ret2 = enum_services(dev, &service_list, &service_count, tee_sess,
> -                            PTA_CMD_GET_DEVICES_SUPP);
> -       if (!ret2 && service_count)
> -               ret2 = bind_service_list(dev, service_list, service_count);
> +       return ret;
> +}
> +
> +static int bind_service_drivers(struct udevice *dev)
> +{
> +       u32 tee_sess;
> +       int ret, ret2;
>
> -       tee_shm_free(service_list);
> +       ret = optee_open_enum_session(dev, &tee_sess);
> +       if (ret)
> +               return ret;
> +
> +       ret = optee_bind_services(dev, tee_sess, PTA_CMD_GET_DEVICES);
> +       ret2 = optee_bind_services(dev, tee_sess, PTA_CMD_GET_DEVICES_SUPP);
>
>         tee_close_session(dev, tee_sess);
>
> diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
> index 1f07a27ee4b..25b6b3c3218 100644
> --- a/drivers/tee/optee/optee_private.h
> +++ b/drivers/tee/optee/optee_private.h
> @@ -27,6 +27,9 @@ struct optee_msg_arg;
>
>  void optee_suppl_cmd(struct udevice *dev, struct tee_shm *shm_arg,
>                      void **page_list);
> +int optee_open_enum_session(struct udevice *dev, u32 *tee_sess);
> +int optee_bind_services(struct udevice *dev, u32 tee_sess,
> +                       unsigned int pta_cmd);
>
>  #ifdef CONFIG_SUPPORT_EMMC_RPMB
>  /**
> --
> 2.47.3
>
