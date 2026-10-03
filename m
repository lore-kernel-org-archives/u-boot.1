Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4396CCA5FEC
	for <u-boot@archiver.kernel.org>; Sat,  3 Oct 2026 13:05:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 10AE94145F;
	Sat,  3 Oct 2026 13:05:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YEOiRNBMOYJ0; Sat,  3 Oct 2026 13:05:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 55AAE41429
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791032700;
	b=J5WtpKaizeJWrK1N7S05oBnrGU9jihH1XFZ/pL3X45lxAS268VIFNEie420VeXXxFkoT
	 srviccrJta1uHSiW1hDRD1e8bEC/AFpfDIAPsqe3mvpYFhb6iKAVYPVDSXRrxxg0S6F/0
	 gEQTHxTvMVzhqbYbZiboefoSsHmtleAvxQ8TrLuYOQfdi/uf7kJgrpKhI8dElDtCcC25/
	 q/DglB83XxSjllq8bWKwEBdn6992aBFhn4ytK4ZgIdX78D4XtGE/H83IY3LO1vwxfsZuT
	 GRZAZx5yQ7jS68bGWydSf4FYemxMy0XIVe3FK+yRQRvqGe83HuqvwwST3BQjuD8IaFg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791032700;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=oCpm4UqdDrroyZLQRIpYb63zOY2rfz0FFnOGD6tH4aI=;
	b=rJa+eROU189bLE65H3SlYOgkQV3adewF5xai9IOvhOO4iHFAEGRetUjCgT6oDhDrmI74
	 qMiTrHeTcucyE7IqcGWg0dEzd5t2ZY+n5IAT3E+alCD7QNRtbcKI3Q1wGon9J/5I/lWRU
	 wkTfD3nqRgFaJxViHxssUdjKysOb7E8jb4k7SxJ1FQ4PIH8eaWUHDceBr4qEf0I8cYsXv
	 qNUvlsvA6BXSmR0WySpcxzJov3aax/dVHogaKIo0wjKj3/lpuCqDJYl/VguyDqrYEfS7n
	 dMLbjj5fHJvYRER4DjQmvwngBIZheqiStqtQ0WT4Jw40dNauco0WoXaHgM2Ohu8C/eA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791032700;
	bh=oCpm4UqdDrroyZLQRIpYb63zOY2rfz0FFnOGD6tH4aI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZWu0br7Gk13F4eXo7fm3jJeEOTkzbMphjWT6ogOh3pg4h+59g5rgGZrAwOf57ocL4
	 ZqLYZtndKrfdG3enhdm0RIWjJNuG3qAfUeuH5Ds/24iKm/AB91S2t9KkrW4A9oNrIM
	 Gax/VvEbcH6HT+I2BeETtD7Sb3n9m9Y7SMH9XktKzBiEpR1vcxOqe/t4GyWPMmdh8b
	 d2ubukcL7vn1W0+J1/55vD/hyv1YONBFYxZuTcmcTmyRU/1nIM8b0R3YVH/JONt86W
	 XxsMe8BlGUs+cgwDWotC05T0mab6JWAwuS21Hsuo6RUD69RhZEPb2Uzws6Luq23ZkI
	 o8hFvDnriY17Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 55AAE41429;
	Sat,  3 Oct 2026 13:05:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id AB42C179
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 13:04:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9C27F6067E
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 13:04:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JxhqttvIUDw5 for <u-boot@lists.u-boot-project.org>;
 Sat,  3 Oct 2026 13:04:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org A655C6064B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::2b"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791032698;
 b=MUz9ijLfQEjt9Cb4f9syELLzVfm/0lP14811njbkgosr4L994FBFuNj6wuNX7bZIzqI4
 ZyAsQxlEoeLP+H4w3NxeYdI+bmLCXS/oDpJme44euoA9BqrJFFiSJtud8/qcgPLNT6HO/
 5UO5F/3HkU70wnoiBPHD7gJR63UEP84WTcQaz5zbTMBP9qp0FqUmDELiEHBZm+OmdS6Fj
 sY9xlUfmyI1dvypOrbm9Vt+RCNsAnO7XjfUvRwgxkIgBJJWdEDBu10U2IBe99OCG2FXUO
 roK+iRI7+sjtuukwIfDRizky99eGOFW2jXEgATA7e5yiDDzOgSMv8ke0+6+1U+wDsXQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791032698;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=oCpm4UqdDrroyZLQRIpYb63zOY2rfz0FFnOGD6tH4aI=;
 b=oo+ELEMjIaPd+txWxxvI1PQ/3FSmQ15MciThL9i8r5Vn0R0SLtdzMZHV5zZZCQdwJ8ri
 ru/66mFmTvZYf5ofZEVNPQ1GlIcSr4BJNAbD575subRt8csB5t+pVbEr4U4G54H+2WfUh
 8KntowN3SW7ozU0qoGgRoe7oKAjgJEvRCEQex1QzZXYbTyZvL4PJ/ES2MQLERKwsVtWLz
 7CfoM+Yxoqa4ZMy/7F9r0w+tlGr+hTD001wpttAsecgU7q/3Bv9WZ/v5KrOqt3e0w6uFB
 JmUuNaXExT6HbFNC/1mvu0Ayli/Mu3eV7Jg0yMUaIj/bAUyNlU9rFRPGjTezYmTrHow==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=hSWLRWm3; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::2b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:33::2b; helo=mail-ed2-x2b.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=hSWLRWm3
Received: from mail-ed2-x2b.google.com (mail-ed2-x2b.google.com
 [IPv6:2a00:1450:4864:33::2b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A655C6064B
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 13:04:56 +0000 (UTC)
Received: by mail-ed2-x2b.google.com with SMTP id
 4fb4d7f45d1cf-6afa5b9150eso450017a12.0
 for <u-boot@lists.u-boot-project.org>; Sat, 03 Oct 2026 06:04:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791032694; cv=none;
 d=google.com; s=arc-20260327;
 b=OFcxPoYk5oav2Tpf4cesqKACvl16qSWmR18/qPSU4YPF7DdK/ttivquWW/LsOG9DWU
 rzq7TgtL1x+mX2KaLldw1/XXjesd+gZh/zRJkgsrWsxoAigwVh0JHKShYEYiWUFeK+aw
 mg7FRk+QTVVkBMyJBnUDMPhaFhwGgPwSUsdYYirDdfd56+p83bTdwrAQveVbXCtgzxfZ
 NvT2WzaBNb05DG0mjwgf092oWqSEh3AVSUSsaZMkZ+IJwIGvQu6uRhiJk2gRA8YSNF1f
 JgnABiL5eRuYCuSigZvX6wAJleOc2ZYdKf3eBNrdHho1h+g6GaDJPutZsm5IF6UcqbAv
 I9dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=oCpm4UqdDrroyZLQRIpYb63zOY2rfz0FFnOGD6tH4aI=;
 fh=BEoPNN0ojtgxNz8fjZSoyMObtb+XDDU+qZjnWDTAHBk=;
 b=nVxT4uzeGCWhCVrT4wGorZrV+zoyPK5wczjvf99NirUmzjy/2+Eh4MpKCYP6pPjMG9
 i3Ou6UiWHvQOab9vP0eiFh2SHLTT7u5R+ok7ng8QYiHgP6xLO1nX24cCX9D6xsxjsNln
 PgtaRhnBG7fZr2oTMUPra8fbDnzyB+lVnQ7QxyUudIZNosiuwsPbdwjLAedKmSR32Vkp
 mcO8SLb4dmgqDR8a19J7b1O1FlnYEKsSHPnufcb2mhhx1C2pJVGgPkhydS2kXNCBw5sT
 GhWVMt/JG70v7BINWeclV53ZkSopaX7x/0noqNDFasb3Z7sOid0ktOYprjxzIS+rlshi
 Jc9g==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791032694; x=1791637494;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=oCpm4UqdDrroyZLQRIpYb63zOY2rfz0FFnOGD6tH4aI=;
 b=hSWLRWm3gHKlK0c1X34cENdBQXPXkKmX1mXUw/QwYOrF6VNvQ3Py8Ebl0+Vpfidn4O
 +AT5l7C63KfG1xBTcSz29t52jYPFEShyDrg4XuF56W+7SXsLMS3fhYTPvYyXmBDjwgsv
 svcrJ6DZN/n4ffxZOGRLT7xDNQnOXevicOjkY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791032694; x=1791637494;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=oCpm4UqdDrroyZLQRIpYb63zOY2rfz0FFnOGD6tH4aI=;
 b=WQfc66RJk42SdxFJeJB8pCXin83a9QGIUw7LWqz5OCWsytUXgyd5NT5yrbR2rH+GUk
 OgZkLnHryALfQ8iZUS1tU93txxlvwx17D8MmuUX7FDfIt1xzyWd6xXLltiiGXTGYQuP3
 mzYHQwuNhunPVADGv103o4sPklaDTG21vXXXBo+5hTP8WUeGQSdXHtcdyVlX3HaebzBx
 Wmgz0cOM2f9Osyt62xizuuItVQS374NSFFugAQRh8hCrHJso2D5PKF6W9kP40X6gR/Mk
 tWe5wfU5mmZxD6M0IF6cw9TugfD35c+asnkok55SCdcQdrxKdu9fDGXzHVnyWml8FFhw
 U2yw==
X-Gm-Message-State: AFq9FYJsgaphHuMiFX4tc/XQnVXGbUwbMc0GiwKm+oCNwaftMHBe7WjA
 0VOsYnZ5SixuVSk/v0BhJETo/zymiaxVMFSd1HUiEOqn2nZX29wF+hmm/lD2j4L/8uMB6gQTXlZ
 m1vhdEoKohgd7loSE52AV4/r+okSqZArCzV1HV7bN
X-Gm-Gg: AYBFou3j073AvTMv9qEPvpKrYHaVci/DDj21MbRJhYJDpTkf0AjKY58cLU0ctLMJrow
 XawZoT2Fq2TCiHL87beyOtMEfY2pugpKtBe3GPteaiKTXLbd6d31UXCqSd5/2zIJiheO+KUfe7s
 2bWcHSXlcpFyREkpHaEYezegCiPaniEx0Oh8rxAmMVzsPpDGuSJ0q7kPusrcYszMNU0k3zwfIxh
 QIXthFCpJXPXmqsQKf00InpTD+WaFZt5uvkRWGfmwvx3nLp5I00ngTK28bDPu2INLD/x/nuk2aJ
 9kZxXubQgeHviLfb39YM/SJVcj2FE0kXOF4cJd0D9Q==
X-Received: by 2002:a05:6402:4544:b0:6aa:ec02:7de1 with SMTP id
 4fb4d7f45d1cf-6af9e2fc72dmr3358950a12.24.1791032694008; Sat, 03 Oct 2026
 06:04:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260918-ufs-spl-boot-wlu-v2-0-8a63e372bb6e@flipper.net>
 <20260918-ufs-spl-boot-wlu-v2-7-8a63e372bb6e@flipper.net>
In-Reply-To: <20260918-ufs-spl-boot-wlu-v2-7-8a63e372bb6e@flipper.net>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 3 Oct 2026 14:04:31 +0100
X-Gm-Features: AclHuK_iRkYM7O3O5Pvkqx8bJc825371rgvMNsXapPcqFuZDQDQqBqZtI9LfugQ
Message-ID: <CAFLszTgFeF_YQwUMv6-XV6Cqz=JfrYw1N7NrbnhXhK9QNoA8hg@mail.gmail.com>
Subject: Re: [PATCH v2 07/10] ufs: define the well known logical unit ids
To: alchark@flipper.net
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, David Lechner <dlechner@baylibre.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Julien Stephan <jstephan@baylibre.com>, 
 Simon Glass <sjg@chromium.org>, Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Richard Genoud <richard.genoud@bootlin.com>, 
 Casey Connolly <casey.connolly@linaro.org>, Johan Jonker <jbx6244@gmail.com>, 
 Denis Mukhin <dmukhin@ford.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>
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

On 2026-09-18T06:35:41, Alexey Charkov <alchark@flipper.net> wrote:
> ufs: define the well known logical unit ids
>
> A UFS device exposes several well known logical units that live outside
> the ordinary LUN range. Name them centrally, in the public header, so that
> both the driver and the SPL boot path can refer to them.
>
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
>
> include/ufs.h | 8 ++++++++
>  1 file changed, 8 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
