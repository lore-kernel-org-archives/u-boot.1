Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60559C531D0
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 21:40:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 051C4407F4;
	Mon, 27 Jul 2026 21:40:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YP4aky5VSsYT; Mon, 27 Jul 2026 21:40:54 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9572C407E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785188454;
	bh=elMLl1Rwsn+crmsFdPxly1OucTXJ0ZaMKbDEQeXHCs0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lJku8hHnLIR6GsgGI+CcZ6P4bfGcHULeCLIDDgTZxBdKQe48PJAXePVSDGdmXEDHC
	 DKMma0pN6GHhe8JEAeOsUcNtajYHT/ox78LDULaXZMtPL9dMQqXhIkYq65RFIs3KrM
	 LwcYDXCtktkpoeNjn1AjH0+qcv7JsFJ264s0jk8u6XAMA+9DHpWClu7KYIjnYTF7iZ
	 34PVlbhKJHMwZjq8uy6gY13+FDyKx/zogvZ75C58kAUJw5aox514T1B2ykWjqn3Fbi
	 zof5K2PFUE5Fqr8wfRnRIMDXWkXKboFrlvvzjWdzsfBNP6ED2F7nhoH8r4jmrf8U7X
	 Jp+/eUCmIPwaA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9572C407E0;
	Mon, 27 Jul 2026 21:40:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 81BF0194
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 21:40:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 73AC340098
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 21:40:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1085GELW0g8g for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 21:40:52 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=festevam@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 6E2C940193
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6E2C940193
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6E2C940193
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 21:40:52 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08B6F846A3; Mon, 27 Jul 2026 23:40:49 +0200 (CEST)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 150A882991
 for <u-boot@lists.denx.de>; Mon, 27 Jul 2026 23:40:47 +0200 (CEST)
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-5b0115b9e17so3053378e87.0
 for <u-boot@lists.denx.de>; Mon, 27 Jul 2026 14:40:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785188446; cv=none;
 d=google.com; s=arc-20260327;
 b=eJiQLDDVJf9uv5OUVjspCSi1p8D4DAF1EAoRtocDM56OOFKLYiecGasj8IYsFsGgih
 3n4qHY+XCRfNPifDD/VFScILX0Boa5cjSfInpWQDIUQI04F04NIwMDtn0yhOC7bHp+dw
 2MZn7GdHco5Is9G2c+VZ2JHxcPwHI6CWBZv4QKCRFjDDinLD7HDQh7L04jnmoeOEafVm
 LMhcutynZLJxGW62dZgqZ3eioR53brXUIC2OaKzzrP9RvPT/xU5oADttQMCSx4RXfG3Y
 RJW6h+bcqHT57LzqOEtw97jrKw0RgwaH5LLVY4oUn+P3Cf3b65EwpgG8bUnIF6gRWkSS
 nh5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=elMLl1Rwsn+crmsFdPxly1OucTXJ0ZaMKbDEQeXHCs0=;
 fh=1CXxYWTWHNA4GYmA0B/sD7jGiHFHLCEJ/7IYan6VUSE=;
 b=a5B6iHYTWYo0JoDlXwpsNECyZGneA41WE0EesEv707JxdbcvDy1HTIrGqaCUsfcend
 wCPoCl3EbD4Z1c+pRy4Tsqrl8d3kNqUSKgLDMHGkcGFn+sl244BjPBX7yuoXfZGGd22n
 Cb76vBg5plN2bOl7+/8NUIHm67Se5zBNcPqGfuf3Z9vWJYdh8WKTKgOEsdg/38G7FwYc
 6NlmiluifEfN3Bf24v0Ka3h0RSA/wIE2tNtMtjnFShHBQxTzjPK5hIY5VZVaU5gYo2nC
 ZngbsdIuj7zr2azTt4zvmZn6XJLI/ZbIbqSZNqZimOplLBAJDj0dXsoJCp5TX4gMc/ro
 294w==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785188446; x=1785793246;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=elMLl1Rwsn+crmsFdPxly1OucTXJ0ZaMKbDEQeXHCs0=;
 b=Xa33FosF3TcTYBB8lyTTUCFe9mIHEtELj7y+cCl4meWFm2SzlCaLbWSBicIeolybAz
 AypVVAXtOXGDnsRL4NPHJMyvof0a5Mw3LlqrINVtDn9Vi8Cb7Usg7+/yWEvwMn+3vJ5s
 W90D1G0eOoNr9YOTF3dpoQsvv6PnpA/zG25IhW6zx+rMNAW9x9MZpBmu+W/avrUbgrr2
 lPflPa5yg41y9YJipoO+X4cATcAmNjMlBCWyeW8ZmNf4CvGbBMJgr8TkZgaDFXMmpt5A
 d1oETtWpMm3AcbfVqGkBftwB+NjzUDb7odlpJDJK9WJMyxnIpSFvJ2agdrmRSlUB42Ox
 PXNw==
X-Gm-Message-State: AOJu0Yz6Y86TkCzFO4fN3AJhDlK8SrwlQT/mmu6e9LOc1czlIAMOxKll
 xBaoNl/r/+v+sI2zgiRAXkt++8VsJQMS04UaGlVVF8nloZ/ZN8F6LBBsB8Tda78wxd12P/1gaAR
 vDY85qqvEs8RHZknjzgHeeHE/VzbrZ6c=
X-Gm-Gg: AR+sD13XYXVGg0n8thloWOcpKacmZB+EDN0AhMDvCPpM6PaH3C0Z9v86hEaWRCmAxK6
 Ub8kb84Tq9J7p/X4++AO6vUkE/8PWdZCdeXI2C870l7WP80LhwKgxicHa5aKi//YAdasSohXOMZ
 4ANiEHbGX7tUPOm9FXt2KemB6SFFNxuCu6LlauRsgvYhR5dOQ+TrGVkKDUbIlqRsy+m0JbZzB+X
 riH1rwnvhATgQ33ngppow1Ue/FA+l/cEd/8jUfYFsBBySxqVddXSITLL40kdhwHHaO4tXDjL4BU
 HyiB0VCG6ytjUAg0Kl7ndoCsWf0dXMa2Y2HnVjrIFhcGc0n8pRo=
X-Received: by 2002:a05:6512:39c5:b0:5b2:a600:e496 with SMTP id
 2adb3069b0e04-5b2c1b0e83fmr2007930e87.24.1785188445867; Mon, 27 Jul 2026
 14:40:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260630123951.13385-1-shofiqtest@gmail.com>
In-Reply-To: <20260630123951.13385-1-shofiqtest@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 27 Jul 2026 18:40:34 -0300
X-Gm-Features: AUfX_myNNU-3DQve2nSIODtrC32t8BHT_JIYFk5EBSzYGIyePfmMQspvEAmzNs0
Message-ID: <CAOMZO5BdPcG4UFGYcjtta+g3sHM99+NvvFoA7MCkTXEdNP7Zkw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] imx6: fix LDB clock guard and clk0/clk1 swap
To: Md Shofiqul Islam <shofiqtest@gmail.com>
Cc: u-boot@lists.denx.de, ian.ray@gehealthcare.com, HuanWang@gehealthcare.com, 
 brian.ruley@gehealthcare.com, martyn.welch@collabora.com, hs@nabladev.com, 
 lukma@denx.de, sbabic@nabladev.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785188446; x=1785793246; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=elMLl1Rwsn+crmsFdPxly1OucTXJ0ZaMKbDEQeXHCs0=;
 b=UAG9OWeDKzTbf5z4btGLjPbZ5FvFYTZc4F0bX/Hyyv5rK2Jxz8WkabNy71VBFl+xv/
 XWy7nvfKNmBIhhCmhNyjH+Zw6a2zlFnKU1WTqTAxEQsTs8lRGu4YT+R2X7xYj1xUlPrQ
 zXPiUuttXVlimi9Ej2eZzxAY0Oze8fHYf175hohGqP0sW35uOLFDDqWSOhOn+rSIrfWS
 w0gHh7sERAf3OadcsLL+A6gZNRukzr15OEEhpwT40Qd7ma2Rmj2bTI2hCDFgnTvbk7CU
 Ns/MEdm0Im7Hh4ZVB87x2dWjaQWVRzypSX4MxprK4IkbF1wcOUiYbnLdhaz4I8Z4Jh85
 XlgQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 spf=fail smtp.mailfrom=gmail.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=UAG9OWeD
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=festevam@gmail.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="UAG9OWeD"; 
 dkim-atps=neutral
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Md Shofiqul.

On Tue, Jun 30, 2026 at 9:39=E2=80=AFAM Md Shofiqul Islam <shofiqtest@gmail=
.com> wrote:
>
> This v2 series fixes two issues with LDB display clock initialisation on
> NXP i.MX6Q boards.

Please rebase and resend, thanks.
