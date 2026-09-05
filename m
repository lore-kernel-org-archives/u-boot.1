Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22B9DC624DB
	for <u-boot@archiver.kernel.org>; Sat,  5 Sep 2026 22:06:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8CE1680EE9;
	Sat,  5 Sep 2026 22:06:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GoIjHlgOqYSN; Sat,  5 Sep 2026 22:06:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org DAE5B80F14
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788646019;
	b=QZh+sfIDHAI77yga9MvzScgbrtWrF9NGI5XnoZDmWU2iU2qfeTLjTLmOG4VeU9A//H3+
	 EXpHY+2dJoehc5WdHgvyobo4avRsfBlWOQr/R/IH+RwjVJkADYT0JY+RVMtZDRE9/dXuK
	 Gt13JcvCCPY4ODedGVuQx3lCPn2bL7pUu3HZkBAQZ+Wo2ExH+hxH04KdjODEcuMui/ZIW
	 4YdgONUz5Cnxf9MOp6SR3t32bZjdZL7uRLKS+RFGbXr3C5IXhGwVVG0YKEBYspemRtAhB
	 9pFTlJbpWqPVOLrpyOuNkXdQ7BK1fGeWzxLWhRFS0lW8kOVEPA6JNcaknhiFkjODFyQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788646019;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Wi19GF31q0E8jxupfHLMtqsuQWcZNHtsEyeVs4Z4ctw=;
	b=go1pF5BDE4ycVtqt5hq1YiN19vSrZ0g8hsqVdlkbqMPwKEcPLWcCdXFiipMPu/5o1v61
	 FxehFZAXeXDfUugulAZdoh9jY6JaKpltlqUWk60mKSDVym9HUUP5hGlxB2rIPYPYp/WUd
	 g0kmoJXuxVvt5z75DzCWUFv4kbRibTr5kn2G1uh8ZeF43z/kN2RuFvktZv/LXVZIB9iU3
	 aR/Cl64+I0vZc1zILK6RikG56zVeA34RW/q1Sw1kqSPw69Yq9tS5xKqtu1VE8jqebprPn
	 FoXtW0iMAaZc2edMSQl7mF+JEIz9/Ou566B4Ak5u6ZE3C0VlULsisdLxdVGNFieee1w==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788646019;
	bh=Wi19GF31q0E8jxupfHLMtqsuQWcZNHtsEyeVs4Z4ctw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=P5mCLjjP0fRJIVUExriVoXRl0t+D2oBonoetIUTBZYLOrXR8KNAcBJXr17gmFGsxd
	 qT89pO8aBLNsRqtyF/LLtQV6GYOaGKqJzosSnEtuaz2rvDbknCbZu4fZ+FYSNSHpCH
	 G+GQhdr6ecrrPTTo2fBoZuqI4rIGi5A+ii3tVWBPvE8TmMY6HHQvtaLeM4VsdiDcED
	 WDK3LDo8ku7Pid8rHTiJcnpmghMal5T3yGcEqCXPUPfs9jtckToPJIBD3UaWUaCvLW
	 WNJpFz8/L8L3ON6L5ZbCqBOZ2I7p6i/RrtzSGNHh8iUcU/I2zXQe46QM+qB3jnOoTg
	 wTAikfPkF8Eew==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DAE5B80F14;
	Sat,  5 Sep 2026 22:06:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id AF59E105
 for <u-boot@lists.u-boot-project.org>; Sat,  5 Sep 2026 22:06:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 94CA140848
 for <u-boot@lists.u-boot-project.org>; Sat,  5 Sep 2026 22:06:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WuCKK3PbSrC7 for <u-boot@lists.u-boot-project.org>;
 Sat,  5 Sep 2026 22:06:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org DAB4440843
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::134"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788646015;
 b=NeZl/CLLS+6tCVptR/tsJelQDqTqZRor7UceLlgAREPgAbGbke+g+gmNGxqWClLZG8pn
 /np5Qlb5hTk5ZiWHMJHhUuoLmMEiwirUDPOIcHX+lCf35ItoN6044Mg2B6NT3zwqsKFdx
 4Actc3WbgsJUSn2tDT0z2mQknVR5nJzECuJNpPQTLY6VCT+HhtA3I9wt5Bdy5SPPAZlQx
 y0aEn3U/prHPeGSPgOgzgpW/a0C3gk2aedGvzoUzBHz8WFkIzwlMhj+duNZDOLy8UuQvo
 z5xhcvjHpESDvuQtMOcJ8IrMxmiuahhuRzDoyi3GRro8H9VRw8u6TcIt7uj+OALWGUg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788646015;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=Wi19GF31q0E8jxupfHLMtqsuQWcZNHtsEyeVs4Z4ctw=;
 b=SeGfW93aUNuX5RbRpJfnYArU0+9KOcVJQWupGSKkFdw/uMJDQzRCRLfUR0q6vqra4JWG
 g+jwZjGxUMOXSEqB2UnFYw/TwN913bN0PNaw5dDtAylqMaEapNPGGo4wHzdWwlm5U4NzM
 eOa+LkRCN2sdUX1csyiEu49rKvXMrnubBoXnHLEs3Ha/kTAJh9b4HPdMJrqyer8gl377n
 UPwFoi5elIxNDFnMxAIbLYPNfkq5ERQPyiGl2kFVBxfMkLgu/hUMnIMJR3pD+JIlR69oj
 AcB3+o2MoXkD5pvue5wrWPvYLhK/Eaxd2mBhsvc1cXrE4vfum67stNqPJqjvdWu/Dew==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=HpIHIDZx; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::134"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::134; helo=mail-lf1-x134.google.com;
 envelope-from=festevam@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=HpIHIDZx
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DAB4440843
 for <u-boot@lists.u-boot-project.org>; Sat,  5 Sep 2026 22:06:54 +0000 (UTC)
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-5b4a95ab94fso3305755e87.0
 for <u-boot@lists.u-boot-project.org>; Sat, 05 Sep 2026 15:06:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788646012; cv=none;
 d=google.com; s=arc-20260327;
 b=EEkBlCWJWJmVEdc/ToIQKA850IGAaU6rIrYk3b8/zvQJRYjdT9sDhNygzVrdKXAHoh
 GLk9ahHuEMra2dRMa8PSRzeVXDp5BY2umDhpJs+QSNRZ8VXmiM1cwRaACSvQ+8M57lpy
 4/ExEPJPIKhUZ2M4DOnv3mig16CIwy0XmUtdpfObRjuNzjkItdCz7suPPtyfHhLZvGN6
 Sv2rhxbc8UDerYvaDOra1MVkvnzEa9VSScgEQI82UqCkCKmp+FQ80ikX2SQFpOVNLEvn
 G85u7m8j24K+WsfjXpZ0mvdvHQ8EVobMNCv5q5lJSiOZMlz68GLoImC0fg1x8th9YU6v
 jaQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Wi19GF31q0E8jxupfHLMtqsuQWcZNHtsEyeVs4Z4ctw=;
 fh=fiPnOknUa2lnENxFObfchsw1chJFZ7fP2StYlaALqvM=;
 b=Me4vZB/fi9lG89PuC8ygeidglL/uFrqkYDutdX34HuiB/lIHnl3oU8+RKbWOn+FIKN
 1KnIQhGl+5WBy+rcUCUmmuijPFMCO4szlpYTasQ+gwt00d6l8fcdjZ+27ppZ7qBJhsPI
 e5v9wvJTNc5P/nq5Qvj0n8Pw7/Dr6n9NzfCwCtc1cORRf9U1JuKZUaPq7TGHHN1nyd8a
 z4KU1xNC/lqrx2SkcQfDPjNpRUCGK6TPGXmqVmk2bedyAUpR/pz8wq+ChZoUe0ZptL75
 Vj0zN6795SE7Vx+a61YrmzZLmpFRYVHelRKkn2oFIU1j91OUbRUcZfx+lVxWMZRBYKgh
 XQGw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788646012; x=1789250812;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Wi19GF31q0E8jxupfHLMtqsuQWcZNHtsEyeVs4Z4ctw=;
 b=HpIHIDZx6HPI5XvbzFwjFY+SyOqjT8MLMCmRf8lkTT7SAsJc5qDPj9je46PYeWDeIw
 IbwB7oRVfVBUebtxiZYA2WV2f9+xeO5/lFA326+4LJE56TuzGisY6fdawoFVinhfmX8O
 FHOAe5HzeABJPGNnJ7q5M6/4haJGJAeC0dDViEQMIQK5fA6Fiebo7fAqgfZNrKTDSOUE
 9r8hxfGO8k8rVNSJsWYfPfvL4beSptRp2M/x6T9UMOLXRDnFzW83seR4q7JyCBC2X9Tk
 cX4oc8W2kcaognZJzm5AbWT8XkQT53/YNf/TnKRs5lcf1eiBJQNIIk14/3rojvl+dTnj
 TcFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788646012; x=1789250812;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Wi19GF31q0E8jxupfHLMtqsuQWcZNHtsEyeVs4Z4ctw=;
 b=NQvCmLmN7N70z37vXmcE4V0WvGsBBfOxgV2K0qCYJ2Cy0Hf6rtmexJlggVcdinBEuP
 B+v1aezPytTF1wNJL2GKvEKIfrPWIg3wTj+3li3sWJQ+J4pW6LYuP3MqPZpC61w/5wFE
 HSSveM5dwO8Gpe87NlAWiw1bzi2LHwyPqsX5St262MAqL+OfABG3sckZ79G1fSIUStA4
 JNYK9HkRyu/olXTFO4PqVEjwUZ15ZEw1vwTXjas8PEVQjbqQuYMTM8cJLmQt7HjhQKQC
 yu+AL4lCSaLjtXKtbW6zkpQ4b8pv8eA77b96vdWOC0HUHbTEzAVK97TvSdvZMITt6f/Y
 G0sg==
X-Forwarded-Encrypted: i=1;
 AKwUvByKoNgHGIVeKM2NqIk5lgbCckDKxde85a3vSZgfx34JVltpWQ/BTEqfa8oWqxcTmBMOU/+/TdY=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lpbcNdWMDDvKp0bs1ZXTpqQhitqbkJXV105OASiTLBeBZM9AqS
 WO9qE+TwU0a3ZYk1FBWTPMQpnLOse0p7wj51BF9mF2jSJbTif1J8iQeqPUUyQqWmaxHjvmsSfXe
 bcrPuk77VZaC4xDv3VO9Go28EuAkEGVY=
X-Gm-Gg: AYBFou0cdfv12SOq++fpU1BLQl9RNt7a/gACwPzLwTk1kmRob2lITpKqUTGd000z/VC
 0KMgYa3mEoy+BwZgYmDQD0FtuWF/Du63fsmtP/01NefIYrSuZLrlzFU8SNVS+cqQBahQFSQPZWI
 KHEwK3PtLw+afVQ9B7tPkgaqKnUU5Oj15rO26SonFkJDuIqOwrQTsh12fXFgUDwDI8G7yrEvwR+
 WTtONpJv/FmD3d565Zdt+TzrRED6khb0WZqbGcLpVbZyD8Q7UveZckIvj85XhcAFkSq4iUumfzi
 NrCVvL4tsew3vJAU+vuw1xY8E3klo8t6nCCa7YqQmhtsWyIC6A7N5IGCD0dw202+otTEsY5RsM3
 xJ2cy2E8Cd8ItoOH2BNAYHGZsLw1bXGzkUy89TaGdMUNP
X-Received: by 2002:a05:651c:19aa:b0:3a3:2550:d76a with SMTP id
 38308e7fff4ca-3a372ccb3b8mr13394091fa.6.1788646011661; Sat, 05 Sep 2026
 15:06:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260816232404.1223819-1-marex@nabladev.com>
 <CAOMZO5AOmyEbHS7tMdLaWuEoGgkOWSiVUG6Ln54ATPCUqWxCkQ@mail.gmail.com>
 <c5a9255d-b56d-4c05-bc75-f1a5688b9ad2@nabladev.com>
 <CAOMZO5A1gbzoFFc9PrvTpNBgz1WV8eb9aabhc7_EM2OqSjRvcA@mail.gmail.com>
 <6ad35fab-5fba-4a79-b5fc-4819cf199938@nabladev.com>
In-Reply-To: <6ad35fab-5fba-4a79-b5fc-4819cf199938@nabladev.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 5 Sep 2026 19:06:39 -0300
X-Gm-Features: AcwNN1UWHfNDgCoOMp5SQeBdCMZLwLOR9Mm4JlUa-u7lA3_7kkTG9I2Rh9Ia6xY
Message-ID: <CAOMZO5C-PVy31xtQkwU++0VVMxNWFqqF7sLsf+S67tY5CvS-iA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx: Fix EEPROM address on Data Modul i.MX8M
 Plus eDM SBC
To: Marek Vasut <marex@nabladev.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Stefano Babic <sbabic@nabladev.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Marek,

On Wed, Sep 2, 2026 at 12:53=E2=80=AFPM Marek Vasut <marex@nabladev.com> wr=
ote:

> I have sent one more fix
>
> [PATCH] arm64: dts: imx: Increase malloc area size on Data Modul i.MX8M
> eDM SBC
>
> This is still not in main, so maybe you could pick both and do a PR ?

Yes, I'll pick both soon.

Patchwork is down at the moment, which does not help. I'll pick them up soo=
n.
