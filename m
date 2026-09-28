Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6443BCA5FA5
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 15:18:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3915980D29;
	Mon, 28 Sep 2026 15:18:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id efobA1TWbU-n; Mon, 28 Sep 2026 15:18:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 7161380E85
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790608728;
	b=mBWEtVTxIl5OaQaiJx+qQQHF5Q/UYqG7936Hs4BLtR7kZzqcAwL8OpRtRDCKyLGmVDcF
	 AzXEdc9BGDf74UGTmGLAGGSXjN1SeaviFza9qEAO3mT9uhf7Ww3BuDTYHKBW/3mOxqYPG
	 A58aCpr8SWn/xZdTx2OZkQht38Z6+bwDYNAYrvYRJdGwJyV9j7/8OjbbVtNYN7SXId+Eh
	 MGyTjxYIb98nlTPRt9kD1kocAHnkHyY06Pc2xam99e0XXB3H7FestkK5ATNzWudtmSbMd
	 ByjvYioZW0iZN+lvr/MTXpyv1lknnUK33Ha4zDRc8/MFqVJ06nJPsVoVHYQxhU9w4CA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790608728;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=7pEAI6OV0HIbKDNniMWL+YOuWmHQgBEENVRNaibyW0k=;
	b=dUJ/hYSz6gJrFgWkH9Rw57wb/xvOBk9rHlsvXiTX8s840Hx7gR0VnkIs9F6m5XHfKIoH
	 n32x7zOiEahtAulx/x8PvBpdg4XB67YQFT1y+KXA9AvOJxMuCTN/nH+I2BHDLX5xbFRaB
	 PNZ5+La3V5OjFg+UQ4/dekSZMFsZ5Z6tzC1Kux7yUxVXsCb4BpK7YLaCdzfx7q2HDVFL0
	 kTzWJ9ESYRhIHnh7L8XOJ14L4saRHCQfZspXBMxSTI7go36PqEvIGlJbFTVfNxLKzLsXq
	 6f7QcfkOky6GW11x0s7rx1h2z5y21AnfCDCkWw2/peag3DNkCiBpwVsuOMhMVhHZObQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790608728;
	bh=7pEAI6OV0HIbKDNniMWL+YOuWmHQgBEENVRNaibyW0k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bGzvyMnpVvcT8N+EhQCY2VfRf70VnOebtT9ScKokW7ncMrEZK7ZNwg9NdOIFqS2cT
	 KY65x5UeudFiTmz6ZwiJjZoPBM13os8izRZMfitK8uVxJQpyW3tn/7LTvmrYkvDhgJ
	 WE9IK/Ems6VKqNzSDs6ZiNAhChcdQ5bh9i1X+ClDeFLXdAJLxLXlvSZBqUF0FL/dto
	 VFQvI0xcBV/K9xLnhrvFt+07uY8cd0ez2ijO3WRmryIvrTgWBGTazVWxJ0hspk/dko
	 SrNuGpY9aDPnfDlMuyIoTOz33G3GpKEQmcGVYXhkuKHkVNDfrdOsX9UKD34ea9p1Lq
	 Xmmv5NnwPP34g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7161380E85;
	Mon, 28 Sep 2026 15:18:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 58C733A0
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:18:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 56315606CE
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:18:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DaUcDQm6Wjhd for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 15:18:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 7217E605EB
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52e"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790608726;
 b=tbtf0c87N+Y+xmpQOyCQVbhfogVPJso3/SBvgtW1snFt/qF8f1AynNfp6xeSkgAWNcuT
 xll5usKqOCIcYdLY5Wj6tpJ9h24X/GKHGozCUxtycjJCHOKvNce+hLY23vU/pp0WuQjUz
 R3ptSIkrtq9kDfl9y3BYObKHR33jj+Bgt1j1q/J8VzvnrY3Pbq9ikHg+5U5Xh0H9wcVG8
 ibOZ2e73ue6DC7w0Dt8MVMMy5PbLAPYFL1RTL7oO9pibnv+PY1TZyicjo+SwVwEFpJjaU
 o1N4FFvOMVTvOXxDBNbuTzNNK/sO6lJ+VHAqoD9XwHgcLZ4lxfXYxvgHO8LqiJ9udHw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790608726;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=7pEAI6OV0HIbKDNniMWL+YOuWmHQgBEENVRNaibyW0k=;
 b=GSWtbeo4dcV4c8AwKzVdd97/4GK9YVJc5KVJfDkqLmOwXirRiyno8PJIpctpyZMaEu6C
 yDyi070739sqaw2uNsHr+IRTa9Im/JGQdDaMF0kzrMUfrFFBpS9OuFYR0tCQ+0aop+Gae
 m86gE12oCclK3WSFDeKI9m5J+aSkt/iWPtWk0mFegsVowmFi8sVvHIvd4RpIlrjiQ+3Dt
 LHgp90LRuCQZXaJ/Z5ZpiQvbXcU4f+96mOPjxUq/t2j+jJSvD2xpp814JjWzRdeYKLgPx
 GC49/In1a4EB4clLQ66WGrWTiAp4Xa77W9rce2TOLLkmCFnMP9cH/HxlnxkdrW70pDA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=S+ksLVSc; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52e; helo=mail-ed1-x52e.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=S+ksLVSc
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7217E605EB
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:18:45 +0000 (UTC)
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6aae37d33cbso4161405a12.1
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 08:18:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790608724; cv=none;
 d=google.com; s=arc-20260327;
 b=esCumPLN1CyZwEM2/nXLEz1WQ4GiXhkwBpmsEbaefM/TOCXQKSRRmNeQ0uFK7SV9jz
 J4pMNeYstN9TE60eTgtxkjmLdTEUhwiFpXbJGqMSBWIlzpuyMqznebVYJFyZLt39+RND
 8Za8aRiuvc1Qn0urR0cN4sdjRIpd2aJ2vfdrbL/JmH/FZg0PYJQQ4XbmsgaiC6oY6mCd
 TBJ+gc6vwSLJrmU13bk6nF4nAaDrm+ti3C9IiI16M3LlPA+GoBBcdXIuK3/eYBjk3nX1
 p7JR2lVVki/RmNhWPfYiL8T+D+UiF1zWAX9dArhn2h1nQfqUgVj4sjNUrGUrPBiJWvHt
 rZQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=7pEAI6OV0HIbKDNniMWL+YOuWmHQgBEENVRNaibyW0k=;
 fh=8DuR7XNy5AEjb4gBS1/LVK9PjPsoKjz3k9sgz9THXC0=;
 b=mtWfVNZ8r/+8/22UkocsLqLvxsyRu2lpDP4S6xXf3UjYFK4qvnj61croK2StQzUSHs
 YntY0XpjF5Y7XvkfbTexi5VyvlP/fxGCFkASqltDvOYPUk8KRJBZV6mvym7E4EPcS3Aj
 H7Q+iTMx0a/XrBJHU32WeB600JDZZ1gSO0b/RlBMXqhHdToKyF6H1FDqJ2swB/RbuB+c
 xJTdjK9zCHFqmytQniajCzxEbZZNLLRD5x9FX2x5Z03+ew+/2nm6nUyBT/HxH9dHSPLk
 YjVc6QRvLzTr+qQtAN5txTzeWKHVfyYtJBwHWQQplNbumUcDl3Bv80I+xrpstMGAFTSh
 e3ZQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790608724; x=1791213524;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=7pEAI6OV0HIbKDNniMWL+YOuWmHQgBEENVRNaibyW0k=;
 b=S+ksLVScsdIiZsN/bCLxQ14WjICqu8kNVBKj97/W5ofj3dFUCBPw+VcXDVMVKSHv2z
 0EVGrxMsZtY/7PO7ucn2zBs8frP7xNTp/GS1jOUQLZ92rq+NM0i7At3VeCLpbv6Qtu63
 +WdXcRptX73QeQm9xXCaquxcKtTbuat0oXmxs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790608724; x=1791213524;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=7pEAI6OV0HIbKDNniMWL+YOuWmHQgBEENVRNaibyW0k=;
 b=xdszyPWs0fTEqpg2S5Z5CNhKCE/yWk+AOU1BG3/sZJAXPMuQ4xyPG+mBnYV0icFu//
 Us38fpIpppm2zvPz5Y1jZs1+KfzG34xb6kWgenqILoyJcSNL93nw2h0egB1pholzovrW
 7MjOGQRYWtuE/hj9d5mlx9xvGh1n0G6zZ4rjkMXxysWWoNZ2nLeRXOUo9BjT+LYTIAuV
 8xlzp+km2hPgrq1u8V2pfUJQ+otg2VeBpI/OmxGSmuk3VTZ71iLAImoIGLhHgFH7EwVG
 i++2JRkIaFzh9rJekUsz9p0fBOeNiQWGhTRJ1lSGnQLWPyEd9gNK/hIqg+TSVTqCSF8y
 w8SA==
X-Gm-Message-State: AFuF++m1ljpCC6mbE1ff/8NXUYDwbVRVrXzURTBA/p5NGXYtkkiVgGYe
 lZM0CrBXW8Q2cJ3CXSv0OY567hBz9aBu/y+faO8jSK9tjT7WCbuyNzezYNexbwaHJGwsrizTngm
 bUruO5jav+p9KNwDgnuCJ1xVbE76PCdaQzMnImxOS
X-Gm-Gg: AYBFou0ihAVasYQXIk+BkU9qv2KUNFdW83zIMOn9vgE9gskwrJbFxu65z2q9t1NZgOA
 5nFth0YCXYQfgVUGXAnuEFc1kEBI2m3R+glTkiT709TIZBPGh8Uhsl2D5pnU4esZrK4HDSeCvqI
 0TdMBsTDtqwWPcoJTDuWQbub59danIfRhU5LBpnlySljEbpyeFJAuUAEPFLXvcHrQU0G3FLGn7m
 75Q5hkmNHKxEK/6nWFLrT9sJIESnXWTV99k25dp01IPdrPUZbJPmenVcyyUgCz+zWi4ZocF2XQc
 ZaELigH6UFi/EdUm6h14jJGr1F2I/x4n9X6aNWGP2xogE/vgyZSV8w==
X-Received: by 2002:a17:907:7216:b0:c2d:be57:f742 with SMTP id
 a640c23a62f3a-c2dbe5826f5mr445467966b.32.1790608723953; Mon, 28 Sep 2026
 08:18:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260912124454.13578-1-aristo.chen@canonical.com>
 <20260922123630.608961-1-aristo.chen@canonical.com>
 <20260922123630.608961-2-aristo.chen@canonical.com>
In-Reply-To: <20260922123630.608961-2-aristo.chen@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 28 Sep 2026 09:18:32 -0600
X-Gm-Features: AclHuK9u8DfTStmV53RbmzjylZQ29RpuXJzU6mE8TGhnf29Q-DAYtD1UZbUBWbg
Message-ID: <CAFLszTjdozH3LsxMZTV+kbYTABnVsTtJfXMWXMbv+yG9e+_WLA@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] include: image: drop the duplicate FIT_ALGO_PROP
 definition
To: aristo.chen@canonical.com
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Daniel Golle <daniel@makrotopia.org>, 
 James Hilliard <james.hilliard1@gmail.com>, Anton Ivanov <anton@binarly.io>
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

On 2026-09-22T12:36:21, Aristo Chen <aristo.chen@canonical.com> wrote:
> include: image: drop the duplicate FIT_ALGO_PROP definition
>
> FIT_ALGO_PROP is defined once with the hash and signature node
> properties and a second time, with the same value, in the cipher node
> block added by commit 7298e422504e ("mkimage: fit: add support to
> encrypt image with aes"). The identical redefinition compiles silently,
> which is how it went unnoticed, but it suggests a separate cipher
> property where there is none: the 'algo' property name is shared by
> hash, signature and cipher nodes. Keep the first definition only.
>
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
>
> include/image.h | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
