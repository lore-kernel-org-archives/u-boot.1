Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1531CC5B572
	for <u-boot@archiver.kernel.org>; Sun, 16 Aug 2026 23:49:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 478B940692;
	Sun, 16 Aug 2026 23:49:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IrCuKaz0VjEj; Sun, 16 Aug 2026 23:49:30 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 118DF4065F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786924170;
	bh=LsY/mo+HTxcJ+8Y/sAO0Mbg70KwTi9lIzeGBdFadfXA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rP8BvQ/RhGXdz8vVqhtAE9zAY9nnlTIVW4DEfwi8rDm/XDjTN2lu6JeUVl1lb8Ar1
	 nsL/w9X8xNKq1KMRf1DUWf1cAOjOSfrQUR7nUKq6eta8Lwl9YEfCbE7xwit1Ok4Vy/
	 wywC5zFvI6e8PXtPMfDduPUyKGpoJKlBhebHDUS/7SDO2+iimrULrs0G+ZjxuCYmm9
	 4EFRE2NBQFarlNxZ/dO+4RAEc95HN/B+L86ZeIbZjGR3yi06w3zxN2AjD4FoeIsQoG
	 3xj13+EHxZv/f9DdUPVIWLg4zYAT2C+Qkt5ZVkonGne2HYRDC9U5AShflH6cShYCVQ
	 n1HDijOzeHqag==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 118DF4065F;
	Sun, 16 Aug 2026 23:49:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 837C0194
 for <u-boot@lists.u-boot-project.org>; Sun, 16 Aug 2026 23:49:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8073880AAA
 for <u-boot@lists.u-boot-project.org>; Sun, 16 Aug 2026 23:49:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RVvAg29xtOCC for <u-boot@lists.u-boot-project.org>;
 Sun, 16 Aug 2026 23:49:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::230; helo=mail-lj1-x230.google.com;
 envelope-from=festevam@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org B2CAE80A8C
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B2CAE80A8C
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=jLD6Piwi
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B2CAE80A8C
 for <u-boot@lists.u-boot-project.org>; Sun, 16 Aug 2026 23:49:28 +0000 (UTC)
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-39c9452244aso21655851fa.3
 for <u-boot@lists.u-boot-project.org>; Sun, 16 Aug 2026 16:49:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786924166; cv=none;
 d=google.com; s=arc-20260327;
 b=ssSBbbFan1T/TL3UlmDN24I6nZkBhMJ+Ws/Nxn3zPl6y1ejfvk4rftGPX7xPmsh5hn
 QUVovSJtj5By8+ISgIrxi+8Jj9T3TOnDnJG9lh/UoYmvD7eDOErMXsHluujQaLCXKCUH
 BLzDfb6vYuHgiArj5Ov84wgH/lYqVOfxOY+mL0FlTYGPerSmks8a0VxYEzFnwTE72k00
 K4o6uWQTzL2j/DKVANFYrSH/svBiRvL7Zu7MdZuRfAECvHOE3FQhV2zMCPa1EyaueyCJ
 WX0U4gt3n1sbAkHJJbcq8KBllnvZjQ2bP/hcn932oOLKmW2KzXdAkoN51x5ttuPQxuis
 ZjVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=LsY/mo+HTxcJ+8Y/sAO0Mbg70KwTi9lIzeGBdFadfXA=;
 fh=nOinuMhr4+XTHvrvtZQQMWT4LwQWD3wtEUlh8MmOWas=;
 b=jCPHsQEgrlkV4OpVjHHYT285B8Vm7XGne8EGFFTJCtfp1ee+Szfjy/cKPdwaDQbJji
 8mRP8F+mRd71oBi33xK1LR9gDc4diF9B1fsrOHoIWsSyOKrtK2j5Wmbx/D8hqX68jMcE
 G3oukhd6Fz0uyV9qGToxgcjkK6EdP6dk+uX1UHb+/Ij1/nBeOyXkYlaepGuqslNx4EmX
 POLNypoFqiCMFKXLikrrXpSRKdl2QnzI22jYEKWB/D30aApPO76FjBgEuZ645pb7yYuo
 oku3GjmoCk3SmrH4ryZCrTWCLkjAiF2XUAss/HphxpLwmDtdnKoz+PDc/E82Lhzfk8i2
 wv9w==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786924166; x=1787528966;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LsY/mo+HTxcJ+8Y/sAO0Mbg70KwTi9lIzeGBdFadfXA=;
 b=jLD6PiwiXMCKjJDYaq6UfVJcUcwOufqfsroLDggmYVNKe3a9QQ/eeRAtsaFcPIgjCj
 NFFVEp9dboSpbLw4jQCFhWd/wZCwBZtsOWaSRZy0+tmrAJMBDLEupWpzUDasvnFBE+2l
 5o+Io4c+go6xt3ZY19azt9W6x5JO1/Sn38O2oWRzD30xqrsC/CYK2w0mYxmveEE9xGvK
 nBMp4aJuRDzOVnbSa8YFSnDtFFniCfwQPHzPoF86++J0Pzv7tGcxmXvvaXbsYmjqzD4g
 tn1mYqgpaitZRYZseF2n4wmSAXaMqU/Md+a459RpRrVCtqLbBs8T5+GRrNw5q1/nnPac
 cPGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786924166; x=1787528966;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LsY/mo+HTxcJ+8Y/sAO0Mbg70KwTi9lIzeGBdFadfXA=;
 b=NcFJhhNRYVAQhveHhv4vrGOVpDep6dVCDCjollGq27cAj1gd/qi65MMmFtU71idDNl
 vP4GTqxO4frSdm6rqVVXQrPGK/fO01GoJW227b7uoa6H9AViHrBoMx1OaLZjM/Qny6ue
 pcE/lV98q0gKFlKSrsl3oh+Cy93waczPMxLoc6KkdtlT2xZDB3MITXnu6WteJTA++SfB
 d0vTKa/UoC6Mpkw53SslccJdwq1AoPehT5ul0VVCYB0SAAsKEUj/mo8rXtVZgVp+qLoI
 ls7u6tSvRiVFpiEK3VJg2xq45yl8PBvbR7qf8wstQGZZ1NSxArIhqxNpTVG9x4Tdc3gO
 IW/g==
X-Gm-Message-State: AOJu0YwHTuLRX2oJMHp88KVo3S+x0wbINDBBCaYN+gj/+k8n/S0dGZVv
 ImGDQ+xg3ab5Nck6PcBb+1aIftTla99XMOUO8y5DmZEPbFUZI25Pb+0H4nXqR1f3PR9fwzZydG5
 q63OLmOL1i8qSQrNa+gIOigUE34Mij5mDDg==
X-Gm-Gg: AR+sD13upFvl3+vZVewYeh+XOa6mn2UY5ZStMwrLGEBkQ4N6FfiWILrCqoaeetoiBXF
 V+YTTew3y9EYd3krSTdaiEm1wUWaiwD/AJRpNpeNLHUxPPICi0hf80+3eAXUOkJAiDs6wUC0WBb
 nIM7YKvesGi5hWbSZbDpedlVNIargZncjaP3Skt24J1CLEseLonPIcQP7eFHWO3a3/PCFNwqRMH
 5AhIP1uuDP5efoB9Qsk6HvvFvYjyXauvEPG+D6lGsjkqZNf7PV5ThyoEK7mq/NXCcQvjg4DSwRa
 gvierTJIy+BFA96cEUwVG+7IABHDLrWtG9sVJ6U42G/2RA5GD1dEKAl+yo63JNnPKCU+YhNT/0t
 VRc7MPKs0/oohkVMWOGNDJs2FjOUvY3DPxA==
X-Received: by 2002:a2e:a986:0:b0:39c:8c37:bfa8 with SMTP id
 38308e7fff4ca-3a1327dffdbmr19618851fa.29.1786924166073; Sun, 16 Aug 2026
 16:49:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260816232404.1223819-1-marex@nabladev.com>
In-Reply-To: <20260816232404.1223819-1-marex@nabladev.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 16 Aug 2026 20:49:14 -0300
X-Gm-Features: AcwNN1UJqiSOfBBm8GCAFUEVS4ProeHqfNPrdhx_6jwmQsUliCu-yVRT3EH4QEw
Message-ID: <CAOMZO5AOmyEbHS7tMdLaWuEoGgkOWSiVUG6Ln54ATPCUqWxCkQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx: Fix EEPROM address on Data Modul i.MX8M
 Plus eDM SBC
To: Marek Vasut <marex@nabladev.com>
Cc: u-boot@lists.u-boot-project.org, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Marek,

On Sun, Aug 16, 2026 at 8:24=E2=80=AFPM Marek Vasut <marex@nabladev.com> wr=
ote:
>
> The Embedded EEPROM address on Data Modul i.MX8M Plus eDM SBC is 0x51
> on all boards starting with revision 902 and newer, update the EEPROM
> address to 0x51 to cover all production hardware.
>
> Older board revisions had the EEPROM strapped to address 0x50 but the
> EEPROM was not populated on those boards. A subset of rev. 902 boards
> also do not have the EEPROM populated. Rev. 903 and newer boards have
> the EEPROM populated and strapped to address 0x51. Therefore, setting
> the EEPROM address to 0x51 unconditionally does not break any users.
>
> Signed-off-by: Marek Vasut <marex@nabladev.com>

Does this need to go to main, or can it go to next?

Also, any chance to convert this board to OF_UPSTREAM?
