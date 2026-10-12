Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0727DCA9ED0
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 22:01:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A3EA080AC5;
	Mon, 12 Oct 2026 22:01:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OVQhCxma6GD3; Mon, 12 Oct 2026 22:01:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F127080AE7
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791842465;
	b=BC8JrPmf2aYJW6oT0HvxaKCKpKq5Oot+Lt2p41BOcCV8XKeKLD3b9XDMNAVPO9OFspYG
	 DLlcN2TWPt1LV6ZrksIePmR4hY/NbQ9KHvsklwNKwanfbhbYDFjhSOD3oQdMhl81YYPYY
	 FJJLHFNPHYakxbCvaPko0stKYSrxglnvillP2OUab4exRavKa6uY9XDGpaZxrTIpClnbh
	 XK4AwAUZSXRhLeQt7AyCO8PR0ACQNmtsPUSiA5lbb9gQnPgT/zeOlzT/GWMglvFNbCxxG
	 OfaNmGuseQSrtd241Koifjpax21FpHyVtwMGg1b8b23xpWnYXnYMlcZcqi29BLeX+UA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791842465;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=tgoLpwPnAYbkItq/29JIGyEpApVcysl3C/E9I4fI6WE=;
	b=mJcGO3YrS1k6cNWLQLOV2bquA9fXJvoUXGkEsBI2BRn0KEJR1kwwOm/hV/1wzHDw6hWt
	 cmv6KKbZhfN/1IrAgRYDqT1GcXm24a29avy9E6smpQS1SlrAZMKXKzVuhIYXp7qbFcVFh
	 GOm5CqfeeAEIgTSRbbz5ve6ZYfVreJhcSskNoUf+rELrPkHJ3ghS+EsokOq9hUk2WzrLV
	 tvaf4A9sdL70dFe4Y39ESH9VZR/PAfSmsXmhFV0Kn9IgBiTspZXrvZkHEi3gOUa/TReFU
	 Jmc+Zt5Ks8yozuDoFIMnosEHLjd95Ayuuvp+AJAI7XnYYbmd74Zj2gcs2qhAG/knYSg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791842465;
	bh=tgoLpwPnAYbkItq/29JIGyEpApVcysl3C/E9I4fI6WE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Drx+xqsECd3XxkhuDJBSwoku47kYNVK75Fj0QEHA824sgA/f9GvznF+6yfbQMhiN8
	 ItfQ9BwYV/o3Q0eb9pS66MrXqrKInawcPtHIzQQMNFClt7IAm/OEZAQf91GAu57GWB
	 KaYjRIQzyZOsWo4fZGNRYrR99MyXHlm+HGDcW580rlb2oejwZvVjNkWdMxrw7axe2f
	 0YxQ/7U4F1YJmaBORwrkDpBvQwQas8zRtRNu2RUhnRVS9nQwHANmgq7l0SNugziygM
	 /c/RpDqWLrnfZdmeROJAxGIQukZ25xmsbkQvJPIgZ+XwPpdfQQW1x5ND50iYScYxtV
	 g6HJbvPlGUvqw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F127080AE7;
	Mon, 12 Oct 2026 22:01:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id E02402A8
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 21:50:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C632340558
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 21:50:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id I7LLHeLWXXi8 for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 21:50:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C6DE640539
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::633"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791841840;
 b=tNUuCEWu04RFhwleHWXXI7+luqFTnzR3N/IuAB8mWkFotMlmqN+TGNcb81FkZn5v0JBV
 q1GZTdwoOAR6QcK66UYfY8lnFn8EdL1ymJcRaqFxbxb37aQWgwPRFjvu8WSZLNYOyroK9
 aoUpqP7YtSMsk4FZOAUQ+7LHQ3Bj61jqaUj0Y2dkncpu225AlfW3k2J22ib7W1boWL++f
 EANkU6qg4mjIQ5Tp59uwRaZqG5Q9MLDeH5qxVBxAyBMm/J2WjtkyPXfxw/gkZvziaAQII
 vP8yj2hfycBGewouXi7yRzfYowtIopvnjxvIHytpy63dZXPy0GhdcU5YzER/c6/bkQQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791841840;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=tgoLpwPnAYbkItq/29JIGyEpApVcysl3C/E9I4fI6WE=;
 b=nUxtmk6ZsYVv96IOut0mflZMoIUrtizda/vHz9QStsKptMgsVNYcapwqJpccEFxU+ZJ3
 wVlIopm+djnoJG7dZ+nPn1oNL67Mf/KGCvnXdrabcyOKnD7igUhiTNXVji1Yt4hd+9NIC
 FizKDCjdaALQSB7QWrY9NA0xKh96b01/OjD3NKUZOVsRJY9mQnOYLFI7OhRvD4IRqe3Qu
 /2cMxHeCc4vDhoK+Nvc/eiI3h14YkR8RVe5nju9Mmy4Zz5edTCJuy5az18nIygcZqhLXx
 T2LbhT3VFuxJy+MJCGYsXFNm5QezPezQKbK60yJbEbKQedSOTtE2wIjuuR3YGYlk0Rg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Feo46lI2; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::633"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::633; helo=mail-ej1-x633.google.com;
 envelope-from=sebasjosue84@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=Feo46lI2
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C6DE640539
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 21:50:39 +0000 (UTC)
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-c2dc63f8d8aso385365066b.0
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:50:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791841837; cv=none;
 d=google.com; s=arc-20260327;
 b=dxEdHca85InCZt2ZFbSUGCSskn7VtI+kdGPWYCVK10qq7P8L+Kuq44tf5/i57tNTwm
 hH/8B6IIWLV+S4DOn0YgU3JzClv0wCZRDnaK41kO7WpBkItW2RIESswrAIETrXjj4uk+
 ca6ehKJfJNLwqaqf12hjftHmRwia5dEX3kf6UEliD8OabZ4apwTPfKHivXuJ+4DjPA8g
 FiQfXCYhiBULFGm1QZwX2+V3k5xEEqCZtVo6YcbrA0AZhTsf0qRl33bMt1EscdJovjE4
 pCisrBuled3+LOkxd9foguMWW0xPw68zz5iUvbYN5KTkeqj+a5pSWPuhD7bQkrjC1BnR
 t30g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=tgoLpwPnAYbkItq/29JIGyEpApVcysl3C/E9I4fI6WE=;
 fh=aSA+jXbUH5NcRdSe67N8YT11IVOotAJf4oaABXS0Edg=;
 b=k5+aqrtVU+I3wKY+vdLgS1HtYVMDTnRPLY2IIqNAjCkBnwjPmNgo0PF3kf6ONwh3Ic
 Z8OrbDeCWhVrPCLzy87MjCD+7Ixci57/tXN0x43KMfMg2rb8aySq/j0LLrhgmJaUEo28
 oR+WFtdiRLs08VdKdqYrKK96rwMbA8itM5Sc6Qhtr+YM+kT7nTZcSpbjHpPeysE6ILjo
 eT7aSwHPPDKxCZ0XMzZZbCItPW5AIp1K6b/xdbgG3zX/dDej1Jde/WOnNnMbygdCtUPm
 moHy6NZ4lmX3fwU11hEQsZwe5bHPP+Jfw5WV/UlTat1sGRcIVMYUvzlQnOBij6FYhl8T
 wF9w==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791841837; x=1792446637;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=tgoLpwPnAYbkItq/29JIGyEpApVcysl3C/E9I4fI6WE=;
 b=Feo46lI2mE9H7RLaaDlo0p01HLoffVHRx4PeePNK/vBGK+mAq0bSawfjdGTjE5nBu5
 BimsSInkvirLjZTOZwb1DF/tcRHyLEvhQsuRsr/9xskWZNMf7Gy1KHjXNNK431+4CWGY
 sd0n3q8DVCrwO+xyamxtBeWMeCWjaQwO9+MyMqqWl4Qa/S31+ywCQ8sCDcQtdocIjbuA
 HQyt1/+iUMmrM/LWj4LVOBewVO+w5RfoVTkTYk+/i8hAKjwqCkD8lDGJpkEVveq4e7oF
 ghGhAFpTESFZUJuEETuzdGeiXRI3TCcjA8/iRtNOcsVAl4kJrC0xAde5yOhxAzNuLuTH
 XtTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791841837; x=1792446637;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=tgoLpwPnAYbkItq/29JIGyEpApVcysl3C/E9I4fI6WE=;
 b=LcE71/F6kXHEojFaN1/591NL0n8+kz0GiAB+kduBx5ZsCJR/Bm1vwVFPIl8hT3ZoD8
 5Tm+IrLplUM80dka6+ExHkO5FBdyF8JY2lq+A/ykfuPfPsJFBDaWRo+7kAsUWa8thl+Q
 LNHkm6kh0r/JwHv6sGPMQnfm7F03RuJJ8eXpV20aChXKb2RbEPdxenQoRRzwZVmEfpOs
 TKplb2l5z1ygnYqtwcj1FZ2N1rJyCE19pLNKOpnCJUoCqw0Y7FXhtWjmo+kKXuCo6t4h
 pXI4Wh1glXEJT0kW+9Tl2QSG93JQ3SndZTLj2Sr961NICGlae1LH5ctMCh+513xj2/PO
 s56w==
X-Gm-Message-State: AFq9FYJEiStpKnqb2qfviq5K5m36i93WRhpLbaGUwFw6bCLca8+FGauQ
 3Lzk6ql3WET74SJZD68wrqi/f6VQKu7+8/KU20iLxSE1ajnZ0k2E/BkapTvJYmYzD/+8mIOPMXU
 mBWPiWaFOI2xA3UHTaXaa0T9aL+HsZWY=
X-Gm-Gg: AYBFou39Cb2imXN46a1Xel6c/1kF6lPsBECiWo4AVXIL5TarVIIOl/HusDarnzFONUy
 HWQSXUqMIcUVh5eeu2kD4aPZt60U1idJcA06caI1oRMfQLgYAKAN8292nK1HhbsIdt+5x7542xp
 +vG4Q1Z3HoEToc+I4J4xjw1oiy25h39lts8kZEjR7sJ0Hhp2qGASrvUPwqkKKVc/3jr79Tj1mWE
 27iukGnYcQzeMD9fEPcS5LFIQB14ZSO/JumHPZIRSLcR9CBtIghcndS6VZU4KyxL7/0sI+7rhMe
 oqMaz8M8Ke9pLvwfoIid0eqnKOvS0UrFBnk9CMhPDOkWkE5KZy4cq4LqfnghuiebqXUVnUGUnto
 nfessyx7c7oTE
X-Received: by 2002:a17:907:c60e:20b0:c31:e958:408c with SMTP id
 a640c23a62f3a-c31e9584622mr592422766b.38.1791841837231; Mon, 12 Oct 2026
 14:50:37 -0700 (PDT)
MIME-Version: 1.0
References: <20261012015542.1156811-1-sebasjosue84@gmail.com>
 <20261012015542.1156811-2-sebasjosue84@gmail.com>
 <20261012202330.GI3722450@bill-the-cat>
In-Reply-To: <20261012202330.GI3722450@bill-the-cat>
From: =?UTF-8?Q?Sebasti=C3=A1n_Alba?= <sebasjosue84@gmail.com>
Date: Mon, 12 Oct 2026 15:50:25 -0600
X-Gm-Features: AclHuK83XEeb_kLgJF7YoTmGhCVeeLTuHjqcP4Vrq0YzLcap2hq-KCk-3fAzRe4
Message-ID: <CAJD=UNfzhDO1BCCNwu5xnn-evxeN1gaNNCX-GT0+F-B45-j8vg@mail.gmail.com>
Subject: Re: [PATCH 1/2] spl: atf: Check the return of the entry/load lookup
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, sjg@chromium.org, michal.simek@amd.com
Content-Type: multipart/alternative; boundary="00000000000033b2bf065dabb05e"
X-Mailman-Approved-At: Mon, 12 Oct 2026 22:01:03 +0000
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

--00000000000033b2bf065dabb05e
Content-Type: text/plain; charset="UTF-8"

> We change the return type of spl_fit_images_get_entry and now don't
> check what it returns. We do add a new and useful debug statement.

Yeah, fair point. The return value wasn't buying anything - there's
nothing the caller can do on failure, since the default it already set
up is the fallback.

The out parameter is the actual fix. fit_image_get_address() bails
before the assignment, so bl32_entry and bl33_entry keep what
spl_invoke_atf() initialised them with. Before, the function returned a
stack value that was never written and clobbered that default.

v2 makes it void. opensbi is unchanged - the return is checked there
because there's no default to fall back on.

Thanks for the review.

--00000000000033b2bf065dabb05e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">&gt; We change the return type of spl_fit=
_images_get_entry and now don&#39;t<br>&gt; check what it returns. We do ad=
d a new and useful debug statement.<br><br>Yeah, fair point. The return val=
ue wasn&#39;t buying anything - there&#39;s<br>nothing the caller can do on=
 failure, since the default it already set<br>up is the fallback.<br><br>Th=
e out parameter is the actual fix. fit_image_get_address() bails<br>before =
the assignment, so bl32_entry and bl33_entry keep what<br>spl_invoke_atf() =
initialised them with. Before, the function returned a<br>stack value that =
was never written and clobbered that default.<br><br>v2 makes it void. open=
sbi is unchanged - the return is checked there<br>because there&#39;s no de=
fault to fall back on.<br><br>Thanks for the review.<br></div><div dir=3D"l=
tr" class=3D"gmail_signature"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D=
"ltr"><div style=3D"text-align:center"></div></div></div></div></div></div>

--00000000000033b2bf065dabb05e--
