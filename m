Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0653CCDE00B
	for <u-boot@archiver.kernel.org>; Fri, 26 Jun 2026 01:09:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A490B84994;
	Fri, 26 Jun 2026 03:09:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TqpxfkOW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CA288496E; Fri, 26 Jun 2026 03:09:35 +0200 (CEST)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56EDF84974
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 03:09:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-69e1f777bcaso287180eaf.1
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 18:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1782436172; x=1783040972; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pJ5naKPDYxIE3UMlJQMOyTKbY1eNlwMXg522AOzwo94=;
 b=TqpxfkOWTKO7MHsugLYbWO27K56mWNYlLZC4KvdiXOKOJ0iwgcq/RO+KlZXrzLG6/A
 fBxwghXf8IdAiIy3H7vtgJtCx++eWmJlJyNTKXZa96kck4vihOiYoi9Qe8+dUOhlXPxa
 XkeBX1MxRANIPUIEE0omxIXyxxev7eE7cTHTc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782436172; x=1783040972;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pJ5naKPDYxIE3UMlJQMOyTKbY1eNlwMXg522AOzwo94=;
 b=XjncoR7bwUuv0y4frR6uzxDxoj+JXeOqwY2DxT+Dkpr6Bq19ncP/u4nvsHwAhUUM+z
 k+8Li69g4vjiZ9qCpDSh9eSWo8g10iAxg1dQkrTmudMh7vesW5otu6yD+5Ghx6BnPE3n
 Ikl8q09nGxI/Etziusp8elJt5LLe6BLiFPgWpCgUQvwxRHBQ+P/HptYSFTBBKwkJ/FJl
 p+P0Emg7939fWrldIamiSvYnGX2aj1CvavytapxbWlvXhd4u63BwkcR3g/KeKYTBQdGL
 ft9ErIyYFPFcTJ8aZeAxnUJ82dODp/1GZU8SJJRE1SML/UqTzKyB7T2yZoJeIXHc2WcU
 Jxdw==
X-Gm-Message-State: AOJu0Yy/qFBZJxE7D5o0K1mAHdCFOWJ4d+B3aJmyxAaAvBGzJiclH6tS
 aa6x8Bhmjpw7NqtHBk4WpRn3ofTebt0dlEAf8Z+Fa2CeosshWy8GbrQUcLPk4phj388=
X-Gm-Gg: AfdE7clRyFPIfFgbTa+EFIyPV1/3qupVy5FgUw2rqfSklJ0vEZkLWZQIdxBsW9pmgh3
 KxDnsxSC//o3oB8neYen4YSUctakjd6nwFYIdPp2/TqigKxB9Yhm1sEpmMQLpnKPR/TAp/YkDRf
 uF4vNjcnrSiahfFHa75dlRqdrJN4uaHr2xh5PUzVcJ9Siq6V2Cf45BC8vXSIVgkkgX0tER7RIxd
 5OLKu2CdIJCX4ulBv3ZAOTwHKhZbQc2aajVnML1yFmzQNRwDpF9Y0EM4retmmhgK+tjBZHbE0mO
 SkhDdVKudLnLW5mrje3+q8kJbqVGGwr8YjMd7O1OKZi2l0pFlF1Nw/sN7AuN2dGtP3oOViFMw2U
 BKaZMvJCAoCHjpJICLSALeFymcw4vlMLG8U2JEjlvyEJYdUjRu/XiSLQw43SdQjtKi+VTX533IL
 vC1/zs2JmVVFrrjfbGTLD9kE1/GqFWGSFqpVXAy9EIm29m43Hq064YDoyTTGzxoSPDchSZ0w+rV
 KpOFdixCZel4TL5kvQjwcum+H1udxVPGcIP+18=
X-Received: by 2002:a05:6820:4b87:b0:69e:53fb:7867 with SMTP id
 006d021491bc7-6a13434f2a1mr3321548eaf.17.1782436172019; 
 Thu, 25 Jun 2026 18:09:32 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-103-245.totalplay.net.
 [189.203.103.245]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a141048ebbsm526043eaf.0.2026.06.25.18.09.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 18:09:31 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Johan Jonker <jbx6244@gmail.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <d1270724-50eb-450d-8847-a3271ea27a2a@gmail.com>
References: <d1270724-50eb-450d-8847-a3271ea27a2a@gmail.com>
Subject: Re: [PATCH v1 0/8] Kconfig restyle
Message-Id: <178243617088.3992068.17828081506736908238.b4-ty@konsulko.com>
Date: Thu, 25 Jun 2026 19:09:30 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On Tue, 09 Jun 2026 03:22:44 +0200, Johan Jonker wrote:

> The Kconfig menu attribute '---help---' is deprecated.
> If we change to "help" the text has to indent.
> This again has to align with other attributes,
> so we have to restyle them as well.
> And as there's a script then change all Kconfig
> to start with the 'arch' and 'board' directories.
> 
> [...]

Applied to u-boot/next, thanks!

[1/8] Kconfig: armv7: fix typo
      commit: 0c0074f983cc97c0a721f44851fb48df4add2931
[2/8] Kconfig: powerpc: mpc85xx: fix typo
      commit: 4b199a549fca5027fd24f9e2d951581c76a68845
[3/8] Kconfig: power: pmic: fix typo
      commit: 08fc979a61aff7ede01a89d2b68b86128af64361
[4/8] Kconfig: themal: fix typo
      commit: d20d285cf0b72347b7ba37694272206865d86824
[5/8] Kconfig: misc: add empty line
      commit: 2ffe9687013b615a6053e3a85080433626c6f3b5
[6/8] Kconfig: arm: restyle
      commit: 0caac78a06f21cbe25460bf8c0dbe8094f73cb73
[7/8] Kconfig: arch: restyle
      commit: f952ddb7ece20997dd6c12250124d1e377693d44
[8/8] Kconfig: board: restyle
      commit: df3d87bd695656f879604b2089434a64ef74dbb6
-- 
Tom


