Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC1BECA9EC1
	for <u-boot@archiver.kernel.org>; Sat, 10 Oct 2026 14:51:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9DD426066F;
	Sat, 10 Oct 2026 14:51:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QhHIOTGLPQXN; Sat, 10 Oct 2026 14:51:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B9CA66065F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791643909;
	b=hLRr6a9T+ohjAWTiO0Au0a7bzCy6Qn/XGlg4A2lZwvMQGT8aMBYkcU/3cSSw2jK4T8N8
	 2lDlnUeCERqEym1VlaS9+oblMniWj6jlzxRH5iYh/WpKrZPkU+Dl6xjxEFCEf71flDBO8
	 A/jB9Cqd0T2rd/h1HV2AzzFxSAZHqKdU0ikkZqI5kgpwikdcGDYXmWZJiZbHzzNmFFut/
	 IpOzWf4mTnfhl87yPguqhDkeOAe0j8rzkeAA122B9grlvsGkR9aRsLPnOAmmMLqG9jrd5
	 1mKvxsR6N/SD5H+bc65XXG2tA7gA0Kwd1jDn6JueKh20yOceXQ3NADmr8pGWrELkK3g==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791643909;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=yDq52i5NN2z6O2kg/b2znCzhdJwLLK9jo/u75D46IYs=;
	b=XIa6qCD4zKFGolI2xRAYp4i9K49kYW6aX0GOqdJfslIOxy7Erogh/HRioLeLavYFLqHf
	 24k0vyaRvvNkOeMbdSQoRM8jtHAKWS4IL/ZJQkqPYMLq3+PICjpq14EzmJ62aVJ9aqCM0
	 rbZEKBYhZU/zMAv68o6xJHKSXXCAPiexBnVTAj828wpeDU3ZnGRzcbB10cXKBhqp5ug2t
	 zvrs2G4ZOffG2Z8j5sxi8KWbv7jxP+KNiGPQ0cVVXMOIy1YsPbML36K4nw0Euc5dJVMA3
	 EKsrULR6S43dST3ZJCt6kOmjm1/6z7eqobW3+3dgiKM7c7B0NqgHPuVsfl2VHcQOOxg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791643909;
	bh=yDq52i5NN2z6O2kg/b2znCzhdJwLLK9jo/u75D46IYs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qCVxyW+u9irLj7owrzA7Y1Q0/zYoQGZw3Ik3NQ7pnvsuYw+j7ChQpcedcz/LhLG9r
	 GMr5UsLUZdv2pTHh4vWjmbo0TNhCcQ4SzilqbE8efKoCv26zIt9DLz0kR8Yowmxg7/
	 dMIrPMleybhb7c8+sEO/Zas187Qb/KTd64CrhSF4hiL8Rhz65X1Ev80UPNXq8EewIQ
	 ROl8OuLzhLSHVYoR/0M14V3pSsB2JVHssebEHF9eE3dq4hl4wlEh8qTG4r752i5mNF
	 pqn89Htb+tyI+enRaMnUFjnTvTwtL5rKoPmRDBeNanKW24/Jq4LbYZNV7wxPp70jjB
	 9Y9V6STaUPjpA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B9CA66065F;
	Sat, 10 Oct 2026 14:51:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 88D01105
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 14:51:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7A15180F80
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 14:51:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ODQouNpBsO0r for <u-boot@lists.u-boot-project.org>;
 Sat, 10 Oct 2026 14:51:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 71DAE80EFC
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::f30"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791643907;
 b=be1NmU84iKBCz4pdvMrzbRd8Dq8wzopZ4PlxBYu9Cj3akXWT5F/ek1jMy/DjQwZgpF0r
 hdlntMMzl06d1eYDFIyT7CU9CNKcJHE6v3WtMJaSy4WXwlqOT5HBmHJbk6Ju16Jt7qyyT
 GkRJuvxSlluq2PiZk7CRI0tFwepVDB50lax1lnZCrVYbJdDsDr0pZ5/ZlSntiHlKlR1/w
 pKCtfNpGd0s6YiCFz2UulLtOIL3XKBoCZe7jOjJuHGBQDIBVVr+l3vJIUovigbGinp4J+
 DQ6rKC9DvAN+iJYTs1M1hQ1Ciq5d/ca+h3rZRXr+TJ+ti7TyV99hKCfdbTuoIN+JEEg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791643907;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=yDq52i5NN2z6O2kg/b2znCzhdJwLLK9jo/u75D46IYs=;
 b=btbeV6r1vO7Ls2TvygS+jcDa0fz7g9hXKTZefrH5F3nyl+1tl2fwTKcLzqUUNcTPRCtD
 7gsGwsVS3Bac9qgsUisW5+/lvN7yWApmlO8nMxWCszmNpDLBadi+bvx4Hx15N9Zn/OSj3
 wxlFY4JvaewGbilCQtw1m2LZwF/8gvOV+Excg4eGfoE1SUtCOZSa/BLP41GAZNmPujNyK
 hApHJdEMUjLrMNf+ZJp2oh71BuQxLcEGK4fQWdZ3jcPNAXs6rPQHRokKE4cT4GqclZ7RA
 LzWtbUFOAoBUsqN0+i+jIaYvmv88P8PILQaTzQS+NoF2fE9gLCOCwq2tYSMDIHrOffw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b="lI/w23js"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::f30"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::f30; helo=mail-qv1-xf30.google.com;
 envelope-from=pbrobinson@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=lI/w23js
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 71DAE80EFC
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 14:51:46 +0000 (UTC)
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-9178aabd30dso7890206d6.1
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 07:51:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791643906; cv=none;
 d=google.com; s=arc-20260327;
 b=Tksk0Ec/tlMjmD/RWOMgLjz86vFe11ny8JfayLnHWotxu10Mju7mAav4fWQPAflinP
 Vtm7fqiceHbFT/t7efK29jh0MAkZwU865KqUj+FcZdgtTY6bWKiv+CamPUMqBCJFtcld
 a7NLDGUJ8kFraooEifF4RXLMk7fG6fYomjsYchCymNdHe4HUP8PAcOV9spVau60bXwsl
 sR8cd6O596O1F2Y/TnMejXmubn4q2UD1NKuH2quvpCoeewj2KxHSSzQyHAWZsyL1ZtIF
 9MMkfqRmp4fs/dw8O4LPsVIZXJMnHOa/paBnyXsstkddrbs6nzXJQZ5T+khBDUYZ4h2z
 5DCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=yDq52i5NN2z6O2kg/b2znCzhdJwLLK9jo/u75D46IYs=;
 fh=ySexYK7hriEXT5mKEYHSzSDgOzUeVf+hbYMutm8kdro=;
 b=cVF4+e50irF/uTq0lO3gUG0poVAYU90V2Agg3sxMY3ajlXRx793Qre01yb9qFFCL5J
 YcTeogptEBwdVdV0YiRToo8vLYGu8qsxj6bN1RUw1Yk4KQKnnM6nQhjqGsoHbdO5u4S8
 PKEsLcnWhWyVjcFqRnGNvfOqfAjT6lKDmOgDI0nWoKbZP9wX3jdmfeo60huPzHEd6ISF
 1lM9pw7q8id2WkP3IyBS0lLQdv2+T6B7mFmQj+3GzKpWWtxePofz5+I2aF0yrC3z9pPf
 Vj5Ju/VcQv/0AwA/PSeOy/eoiZsu6RB/b/siTIsQZnaAgoY+c0FD22EPrN8wzhHkB6Qd
 D9qg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791643906; x=1792248706;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=yDq52i5NN2z6O2kg/b2znCzhdJwLLK9jo/u75D46IYs=;
 b=lI/w23jsqGUe/LAH+YvR/OlGreg7ISPr9ScnbNDs8TWmjra97ANap/41OB6zsdZoma
 YU4AH/8JMgUihH9tCB23XiWdisnd3KDKbZS9sxZJJ/JMGFG4Ehtxu6dgo/h6ZmXfVSRa
 lTXaDArdj0NKIwIccxenO/VwtKOTIQ7lLf1+6HB9t5f3qeflUBPZvJ2VGGlE07qWGiPx
 o2EQUvJwzeaMouuPFVck0T/DNV0ehquvWZ+sDWgoQn9murGhD3Peq/x2swKbqkdg0mRE
 qesVFd7X6wsgOg9/jgOxMhmOuX/JkC0+F0leV7d9E3Q/hC67SyfDy2/4UU6NuSbF/ydE
 U/qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791643906; x=1792248706;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=yDq52i5NN2z6O2kg/b2znCzhdJwLLK9jo/u75D46IYs=;
 b=edQ9Q4zZJI40dn0yzEVuDIKLOwnl7FhnuI4ZULkknVw5qFmrt5Ax6aelE/DluGFVDr
 h99FFahtsdysDLaywLDiEsmbP0/8EpN9x/GuHBkcz0sdF0PiLqeTDJhXmpllQwwWnw7B
 770SYCv97FKglUGPnU98Jvn1ju1A/W1PTA/8DZgS2qvwpOfTtaErDEFjkZBV2rnDgqYy
 YXuHLs7pM4lRWeqaMk3An9ilJAfCutWmZhZymlH54DYABZy1nxoUN22d/z7OfgXqWSac
 i8UMZSgb/0v4ijZuMoennSEnUw7XEp0Pm90wErFH6SVLegzQFajsoQd+Or1zqELFQfyV
 k08w==
X-Forwarded-Encrypted: i=1;
 AKwUvBzrA0TcC3TafCA+X11EH5C0QUFRXICzdnQld8MT4aTMkqTaAHYRQf8vpCeWNC4tg5UXX3ldoh8=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYK9HBa4v9p520Xx0/h3qhlKo5Qa2HZOuXarNe6j4SnBdwVGy1iX
 jUxS73rEdrB5pw6XlBae7unvIVqqRhCQA8BDXUti6z3qF8Z2InirmSqgOuDoeXzhBP83rNFITAt
 ZN79MT6LS7NND7+rH8c49Wsuj7zLLA7x2OGoq
X-Gm-Gg: AYBFou2B6fANxAbIpw68GDhCOWod9MejEB2Uo8cvMqqIe1BiLZQpcxYCqEz8hLAVmJc
 qpCtXCcbdBBejyaveYEvjXPlwJa28MZkt2r9uWqgVx35g+HSK0qQvvpnCdSKChczx6LXaRS5UmE
 2+YGQzcTgOw5rrebGkRGYGcOAFXwoMNMphRAgSA+px6sH93akrZcGn6YyLV5XqbMtSGkU8BAMYe
 pFcIQ1lcP8V3lXvDsbx894yb3/6xgTsAnRhU3JHymiYnoxmZ1UhN3QOJzVgDQEol4ME+sdRbbBr
 NUpri9rPnllA4v7I2NEFCxkILzr1zHXpHAZ3SV1bhu7cQGWiBsnIim2FDzNLAeTeMrzOf5OJSfA
 oWuToHmw0HGqR2bl4I218OXxeYKydIQRMXadrIsoFJpWUWx7TYnv2aRvAiZ81bh8w6UKPuKrirX
 TbfCRH0oH5L2x627SNaVHDhJzjnv5cKO05JTP5/9K0iCUaYSyxoYVaOhhXQgId
X-Received: by 2002:a05:6214:5892:b0:919:867b:5225 with SMTP id
 6a1803df08f44-91b55344021mr95530496d6.2.1791643905800; Sat, 10 Oct 2026
 07:51:45 -0700 (PDT)
MIME-Version: 1.0
References: <CLfytip-colyUOPhc3sBqUDEz8ZvN5khfJZr8p_mbfHvbe4fWk4JDYQk6Nj4ZjjD1wDbeFldMUbcI16zcLHK4u_Z6ej6LkT3V8Hq4WIrV7k=@pm.me>
 <20261010142922.GI769217@bill-the-cat>
In-Reply-To: <20261010142922.GI769217@bill-the-cat>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Sat, 10 Oct 2026 15:51:33 +0100
X-Gm-Features: AclHuK8UnADlQyl80gOCzDWlqFBrChgwdzN_atafwQtxzaLH_3K8UyG_FAaiiSY
Message-ID: <CALeDE9Ow3UEu=cW3qn2LPeSJOku6Goot73O6b4dyb4pYWGQ3-A@mail.gmail.com>
Subject: Re: Downloads of latest version and RCs are missing from ftp server
 and mirrors
To: Tom Rini <trini@konsulko.com>
Cc: Michael Pratt <mcpratt@pm.me>, u-boot@lists.u-boot-project.org
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

On Sat, 10 Oct 2026 at 15:29, Tom Rini <trini@konsulko.com> wrote:
>
> On Sat, Oct 10, 2026 at 09:07:51AM +0000, Michael Pratt wrote:
>
> > I see where the website directs you for downloads,
> > but historically we have used the older mirrors.
> > I'm mentioning this just in case you're unaware.
> >
> > https://ftp.denx.de/pub/u-boot only goes up to 2026.07
>
> Yes, we've moved away from denx.de infrastructure. We'll have some
> additional mirrors configured and announced soon, in addition to them
> being available (still with GPG signatures) on
> https://git.u-boot-project.org/, thanks.

They're also linked from the main site: https://u-boot-project.org/
