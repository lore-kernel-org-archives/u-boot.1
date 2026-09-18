Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 974B7C88E75
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 07:12:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AE02160BCA;
	Fri, 18 Sep 2026 07:12:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i_AbNCW0-Xx7; Fri, 18 Sep 2026 07:12:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org DEFAF60BB7
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789715552;
	b=Uz7NxeRQKBu/S1x8QNDOXbJiWp6g3HYtO3VwHcdMF2RfqcOsaIyLa1Z8GDHukEIr14cY
	 RJyilNMzfhQvZFbmh1fifH0eYbxfJWrdCF4jtJ0fWhkVEPRSm6lVC5er1eWj6TL1LH6Qg
	 WNCB6Se09fla54PdUBkCAyhXPSF84y5TaLBT+cCwLBgGkSfsT+wrBYv6hsXW3oLa+lcCv
	 s3ji7K9QGVgA6Yq8sok7CsF6pP2KlQwvrHtT1XFKMdirhlMVH5sxNxF3fJuyhd4H1FM7O
	 QLqy+2pLJagP3MUL9s4nRDcvn/9BxwVnKHF5AlIiHk2WLoH+e4CC0JR+x9aWAHSpXJA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789715552;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=ZR5V/KMKC/iuD7Zpn00qjhKYkudK8OiIISSmCs4ZcJw=;
	b=eNA6RAC80VMtqY0wOUxAqmtBWMd83SjprDCpJ//JwVgK+L0mqOUgn0P0fnz87ngGSTjP
	 ofaoxFdU99W/bEqcNxDTLLoMEHtZSkPwlQO1oTyasgB0EX+ApClA8A2/Bdypz261J/7H+
	 cUi0ycknQ7uf+HMb5zhiB2j3EJyzzDNUPX/APQcIqijo6Y51jMiQzBAiHanK6yyyjQK4y
	 WCNTRRn1AXbxJc4QfPfIho5M7P/53o9yg6YnaJpOcKbx54nWIqTOVMtJovEjvNd8ftvPq
	 F9XjV0rsSzdPVJJzxdLMg0Yi4eNgP/xP6oTqwccsgmj8PduYDLB+oPZpzgxi3JDhvXw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=rmxSZ73A;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789715552;
	bh=ZR5V/KMKC/iuD7Zpn00qjhKYkudK8OiIISSmCs4ZcJw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jEFG29f0kmE9zz8AgStChOP2l//ioN/xxCSaaJ/6N2E0UsPCXtqRm991tUgnFgyPD
	 lSEscJ5CKNlH6kVWatdlHUu+5NmDshKelhTHvo758mXMp9RalpxNI3M+gafKC+ofnH
	 FRwOhomEtH8Sgcbydm6tWXu526G5vn++SS+6mOKLuFMqZ+DALELwDUEzJpmBuLoThN
	 UZWS0yQfmIGi7YcxxhxctNaDIvFiN/f5p2lLWNYl2fQfK/xCpHcNSLaGuAWgVfQwaX
	 L0mCUt2cpZ5xbV9bUiEVe4fiOyuNFNFsySWi1FGpvZeTEuYX3HEEh4n61dbSNednVi
	 M6em9PNR6RwhA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DEFAF60BB7;
	Fri, 18 Sep 2026 07:12:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2E5A929B
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 07:12:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2002860BB7
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 07:12:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6MgKooKfGjO9 for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 07:12:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 15B2660B7D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:41::f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789715550;
 b=HFJSR+MKhNuflXbpBOWQWSpFx3vSwMmp8PdG3w5yDOKoTQbR20s92CO3H1YU6J6jIIXE
 a6Rq59BQ3HLAS5WO37lU3HbVgxUDZTv25Eq/Dng/YtV55IHyU+gc/BOWenytyHw+f5wvh
 r07DdJarghfh2oiy8LFUWXbGSp812fGQf3dKRhffc9VwyqWkuYOD72MNSuTEjlldm+6FH
 GYrpqY/yEhiPJn6RjJx5xugxfinKeKv0wwgdPFD3gDicht1VutZFoJ3+AqQd/0Pinmmsk
 gbi/lSVD3BQAzebUsCgf8u/1eAiQecY2wzQyoTMVcwn5/sOim2rCOsa8AJkCgZrCGrA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789715550;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=ZR5V/KMKC/iuD7Zpn00qjhKYkudK8OiIISSmCs4ZcJw=;
 b=go631kGi5ISYeHA0LHy+Vdatk4d3RX18uEkZh6VbTR9hym2J3VI37YFwjZUmfTJ2jmfI
 95RiV1qoGULeET6iKTNeP2N3k8d3HdHH3BjITVIGk/azsAfTa5JT7cxAfP/9CfKPXrmA4
 7clB/WRM1WMwTwQN0O/qMu3Ok7nuJgmcghZ8IBACWmCWWxIJj3gET9j9J6H4xjl51j6EA
 fq0kCtnuAndqilLUP2E08TTNy2RYTLesHSwiyd0IAGQKJPm+va5a13ihu/13AFP3l/JFp
 IHEMD2f2PrIHHvq+KN7hrMXZ5MpQFANUKgRmumvgM50gucPZS2GpveCtrBF/M1XSIPA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=rmxSZ73A; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:41::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:41::f;
 helo=mail-yx2-x0f.google.com; envelope-from=ilias.apalodimas@linaro.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=rmxSZ73A
Received: from mail-yx2-x0f.google.com (mail-yx2-x0f.google.com
 [IPv6:2607:f8b0:4864:41::f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 15B2660B7D
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 07:12:28 +0000 (UTC)
Received: by mail-yx2-x0f.google.com with SMTP id
 00721157ae682-85d43ac8d1dso2695387b3.3
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 00:12:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789715547; cv=none;
 d=google.com; s=arc-20260327;
 b=KIAlo/zOMEDi+oO4tAvMsatxlaoQjf/Y8NNdty2XtBtCRFSOa1HYjKX7GrRCkfb/TU
 9VVk3yjaRYxTVgSia4r8t2AqmQ9pBSFxPFYEemzTt5udI64u8zjb24BYuqmc/twbDuM/
 FaS5tVDURj0WWu0ypIcP+MY/GnShJdPhSi1XLjEbT38NqeGzsJz6hmF/WHoVQAT3AfTl
 9jtPvObmLEwSaTkvyzTOOeHahGcIu1LHVkAkTDYIT263E8PycsBhEj/6f2KBVC+IGiLD
 gTZJzcE5PAT95ZczkEGGYCZysyie0MksUFykfGcAj5rXaYlwQ3xosiXe+ga52GSDzmfd
 wVEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ZR5V/KMKC/iuD7Zpn00qjhKYkudK8OiIISSmCs4ZcJw=;
 fh=46nIEu4ejEkAGahw7KYl+VlkagpCEtcKik9WC8/Lin8=;
 b=dMZ6nPTN5LZg0KZ8VrYVK0XEtHuaRPqFF2grLKAqIcQIKWEbNeecSI8YuWc1BEK7+/
 uqRGyeFjsiWvH1B3jEQM+qB/z792EF0xxGQ+YYTJq/iGQZSn7NWoE1zXoRAkZhSj0l5H
 8TJL4m6zm7efGiav3X7UXA/lvnlU7bbTUb8rrZCzRyDovhq5ylm2ZhxjWQ/PjnupZ9Mx
 nUiSQh8zKtI6jxw/JCFrJOeIZt3Y93DfK9FERN6GsoMI8tckZt5EUYmmnoaozvDYbH7g
 g0MZaj49SCbjppUVql35VkAZ0ZZXqkVSGG7+hgkk5vesbxDbrPqSjXnyU+fBow9cH1ne
 9mww==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789715547; x=1790320347;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ZR5V/KMKC/iuD7Zpn00qjhKYkudK8OiIISSmCs4ZcJw=;
 b=rmxSZ73A58kjCPu5aXE92HQKxloQKNb1/rQJnvjgXPOmI3O5v5kLnJOkO34PHFyb/1
 nsWxfhqXXx+OVnS6Ccp/EtlNM5ESXfLyYyXYbjbxSjSEAo3jv85GCUBmmGy7ONHeF7B2
 /cM5iJmiWCOWf8APjYk2D3qPWu2Ao5fbCj3MZUw3zMSTA/vhqbn8JdZXk+SUoCjTpS/L
 hTQ/RoaSKYBzHR4dsxx6Wy/atb3BH/vecaQjGgQ7zXnDeAB4tPvP4ZaT83RE6nvWLYjR
 EnqVmBNfbjSLFb+bYN67HVCoPrPNj6Acw6FaqemN0SeazNH6mY1Og0wdjubitexPeCQ7
 5v1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789715547; x=1790320347;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ZR5V/KMKC/iuD7Zpn00qjhKYkudK8OiIISSmCs4ZcJw=;
 b=m31PR+qfsD8j9xfpsNR6MdegnXHMvA+d2Of6FR2fj69+UKYxESUdfE945Yj45GqgBz
 dFgTbX7EQE3kuM3bAua5hJAqfMJItqM8WONHG1QG8riR2+7SuTwbCsK/5xdZMeobqwe8
 82gB8ZwqL7ge0pD8jivTapeoqkWURTpzUCt0z8Bs9GIXNaeDZq9U83RYEVB+S/yWE5WB
 FivxMSLFfwUzkuA3qLgniy/aajQo73HHQDis9GQxRCxe60zwOctl8t/e7GeuxHR3C1iy
 hXikX3M57/SX5LT66kamSlGcUhWbdWDLfowPLAIqmKVVtpXV/Vr8HimcV+zG7WegT3FO
 IT3g==
X-Forwarded-Encrypted: i=1;
 AKwUvByCpCQ+JCxa0mpIH0QPAeMzCcDODwCnk30xbtSHhowi7d+gCaz8a0f8LRTCEZ/ChXpzvuSbfU4=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nlHMaESl3wUdW6OGuxbFYCnCaikeeWfKD81fgI8BB7a+VZE1x0
 +nE62eogE63kgbBkiClEeerH7SmKngLtotfK8fTRU2BOIC1HLLhMXa7pDtazebhSfy+7g3GIryD
 y5JXgu0C3r0eTCYpbHV1F7L570+kEL6fm08Hdps6Uag==
X-Gm-Gg: AYBFou0WsQ6mefbAQ/Pp696hg9jq7xLI6ct7UuA5jtZ6RNmd56SDsR9Km9GDzriW1U/
 eLgYkifqfoVGcsByxnxmpRH/RiElBeUdwWls5M8iTPlO5Aj7EgKMYvfj4rTFEbkkWOPQKD8PyH9
 /psMdvtuMw2ikbYrtgWW51jzqmlCXp2xJBB254TDcedMFrId+86aZ8FYHRxvrmcozVl6dQjX+GZ
 5NmI9E2MNJUXEMh858nNbrN7ZvFwAmHyw8gsgCdRMXkCxFyABbRQLMwbmEF9rfZLEM/HW9SDVrF
 XkcHD1+KQvcM2bH1B7RSYYxubV/+obKM5/WTdothefbLl18XbLUAIkwaFa/MK4srE3hYK0YGp+O
 OxWxymooOOQqJF6m2P5vlyobAu/DhDlE8FPgRvhwnY8/Sx0Xmaj35j+PzgMCyh0IBkgvTHW2Fc9
 ZoPOUyZ/ZEY4RsERh9/ANuD69jLLvfwdswrjLPnPzSCH7kDjtIIDJPhZmiIlJfiMTq0YTlzT1c0
 M/RPt7/dSuZkfVhqzaLYgPIvm1gUFKss7bhK/0R1vmDgcMOti5P7myoRx1+RbKTetsMGt5nCISZ
 EV276+ZfLMB0Mm1V+voiLU2pTjTz3a8pcRJg1PV3NlZdb8haEAWIIQLO0sVbR4qDrf8e/M1r9/y
 ZtUDYVpHOtDbvAEAMa5c6z/sGiwggRMrcqNRyFj1Y+4ZjjZxgMtDEGA==
X-Received: by 2002:a05:690e:807:20b0:671:6dff:215c with SMTP id
 956f58d0204a3-6717fd90702mr368185d50.51.1789715547293; Fri, 18 Sep 2026
 00:12:27 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1789023381.git.jan.kiszka@siemens.com>
 <1a6e9dffe86b43d3c62ba185859d30a376fb61cf.1789023381.git.jan.kiszka@siemens.com>
 <CAC_iWjJ7b=Dh+8k49Mq7W5=-b1dZV=L7Z_E6epeOCoej65unyA@mail.gmail.com>
 <5d4aff06-f1a6-4634-b7e3-4e054d5117d3@siemens.com>
 <CAC_iWjKnBrDYErLbDkQyv5tp545-_pfFJA6z1kmGcXvCPt3JBg@mail.gmail.com>
 <abb5973b-b417-4ab0-92e3-d3117ef68bf7@siemens.com>
In-Reply-To: <abb5973b-b417-4ab0-92e3-d3117ef68bf7@siemens.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 18 Sep 2026 10:11:51 +0300
X-Gm-Features: AcwNN1U0KlkgK2i8gBZZc2GgjOd6q3YmPggjkmEnLriMrXDRa51JoqRvD8tHNlc
Message-ID: <CAC_iWjJaBtq5r=DJtdf_UWUxv0Hn6PrUFXi9xxDT86BdHibtFw@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] tee: optee: Add support for enumerating services
 that only need RPMB
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Jens Wiklander <jens.wiklander@oss.qualcomm.com>, 
 U-Boot Mailing List <u-boot@lists.u-boot-project.org>,
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

Hi Jan,


On Thu, 17 Sept 2026 at 18:24, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> On 17.09.26 16:57, Ilias Apalodimas wrote:
> > On Thu, Sep 17, 2026, 15:04 Jan Kiszka <jan.kiszka@siemens.com> wrote:
> >>
> >> On 17.09.26 15:01, Ilias Apalodimas wrote:
> >>> Hi Jan
> >>>
> >>> I pinged Jens for some help with the OP-TEE path.
> >>>
> >>> [...]
> >>>
> >>>> --- a/drivers/tee/optee/rpmb.c
> >>>> +++ b/drivers/tee/optee/rpmb.c
> >>>> @@ -191,3 +191,23 @@ void optee_suppl_rpmb_release(struct udevice *dev)
> >>>>  {
> >>>>         release_mmc(dev_get_priv(dev));
> >>>>  }
> >>>> +
> >>>> +void optee_rpmb_available(void)
> >>>> +{
> >>>> +       struct udevice *dev;
> >>>> +       struct uclass *uc;
> >>>> +       u32 tee_sess;
> >>>> +
> >>>> +       uclass_id_foreach_dev(UCLASS_TEE, dev, uc) {
> >>>> +               if (strcmp(dev->driver->name, "optee") != 0 ||
> >>>> +                   !device_active(dev))
> >>>> +                       continue;
> >>>> +
> >>>> +               if (optee_open_enum_session(dev, &tee_sess) != 0)
> >>>> +                       continue;
> >>>> +
> >>>> +               optee_bind_services(dev, tee_sess, PTA_CMD_GET_DEVICES_RPMB);
> >>>
> >>> so both optee_probe() and this function will now call
> >>> optee_bind_services(dev, tee_sess, PTA_CMD_GET_DEVICES_RPMB);.
> >>> In OP-TEE that ends up holding a mutex in tee_rpmb_reinit(), but I
> >>> don't know OP-TEE that well to figure out if this can deadlock.
> >>>
> >>
> >> I was developing this under the assumption that probing and init paths
> >> are single-threaded in U-Boot - aren't they?
> >
> >
> > They are but iirc the responses from OP-TEE are RPC calls in the RPMB
> > case, they aren't guaranteed to run to completion.
> >
>
> Maybe it would help (at least me) if you can sketch a control flow you
> are concerned about.

I didn't have a specific sequence in mind. I just noticed the mutex
locks in op-tee and was wondering if there's a chance we can re-enter
on a different OP-TEE thread while holding the mutex. But I can't
reprocude it locally with or without CONFIG_OPTEE_SERVICE_DISCOVERY
(which changes how the device is bound).

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

P.S: I'll fixup is IS_ENABLED() during merge

Thanks!
/Ilias
>
> Jan
>
> --
> Siemens AG, Foundational Technologies
> Linux Expert Center
