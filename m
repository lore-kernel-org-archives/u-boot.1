Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999C1606A31B
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 15:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=lq+MpT7q;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gep6sLau
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7054960607;
	Mon, 26 Oct 2026 15:12:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9nLEmW2muWPK; Mon, 26 Oct 2026 15:12:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9105060612
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793027539;
	b=enmDJ/gL6wUW7jn3vaswpVbiLtX3DOrHyfokIpaxVxFTvpBPyU+JZmiMz3CylDZR0D+h
	 50NB1QL9kUz1t64IpENVH+lceRZSs/D/dajC9B4TY+WQOV7DTFZgXyNyP2w3Q7uYWQuo1
	 dzJZ778Qvc/1PjHQUZgO61OimKQR+mw1kbBGnmxftmdPs7nOZ5bxohEWx/Vj0OCZx6ZTC
	 mHsaSRv9kymMIizlsykzF/upDSJ+LJiF6DMUeRFdFB3MWRaF2YMuMUtTOILPaRjN9ZSd0
	 mEITXFLajMnQ8D5Wv7WwrKZq3T1qWbKaVvGV7kT+GE2YAz7hI42QGUUCXC6w5dS2ESw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793027539;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=5UJG97hDvNuiTsJ8kr/C166iBv6pXFy3viLBEBLO4kA=;
	b=IB+rlJ9e6fr0q3aV63o1dtDZR9EGPIWyoKzy/boO4IQ+04iFHsfAfCgptCVqW6nwMtvS
	 QxttAoGKrSxY+9r+ouTsXeA6JIIfvgabv0pKsTtRQHcrtTPa53/qeuKWQQ5jqI/uMe8xj
	 JylTO76oXbij+gU77ximNX8S+fRuTw2D5DqlOuWj7xTmPoVzGfcGOdFRgkgiqXM1RkYXz
	 vtlRTpzl/Z88ElqxrzhKzlA1Ouo1l/WP6GUEONCyGQU6YqUnVcU+p0Cbg7Om8Jo5u1W/q
	 m6gGB9eT9qwzH4xmHbTbzNy9fvG0qwLsfQsXcxoJb4lJuPoSUcewxKBGI2NcxgNkF5w==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793027539;
	bh=5UJG97hDvNuiTsJ8kr/C166iBv6pXFy3viLBEBLO4kA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lq+MpT7qvT1HyvE4+M1ObrpI27qOwTEEN9zYxeZBU5OJJ6fDJ+teRJqLlXVDs/65W
	 5+UOBdktj06Aro328fSORidr+BSnKXaeUUA5pL/NRBKdKwOd9eEnHorLKq/SCLigVp
	 /6V/2Uh8LL7pCEmYqjgaw94obkJhaMt2i4N3e2RdbdDAgJVrOLq4hOXO1fSZESKrpy
	 fljCGnr5vGqdN5BEnqj7QNlFQTonGKtby1eDR56NRCv/xU+V7N6AqlrYSAr2s9q5Zw
	 bLjl1rT/hFzOvFaJdvxOENKREdbk3ar8ITIljLgoQZW0lONaA6Whm+T+t3Z1wJzYg3
	 zWJaUIk/ZeXlg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9105060612;
	Mon, 26 Oct 2026 15:12:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 60DBC3A7
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 15:12:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 46D4440093
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 15:12:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EllYnzBMzgtG for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 15:12:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 6F6DF40062
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::f2f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793027537;
 b=rz79hpjIpbpeCSPwrSFX931o/6w+eSAoRNTxRSLAr0wmSPfuEXHmmkkcy0LeML17jG8n
 1KRmYIbTAZteJ6GyCs48zzH6gdBciGwl/FRtwhd4cHTuo3kqxv2BzEHpUkghX2Sp83cpw
 qpHdVrjXITtN6eMUloBDEb2EolAYSg06Gl6jvci6Rl/49vA/4xdoCK0GPZoJMiKLwkkKF
 kQmSDbThoskpLJZlVWiLsYZKfwQwEVAnlarMKQdZsD31JrDsG9tuH9vUVfSDuG+nReMBv
 IJT5mKUkgfLyXAmMUN74/8TUuthNE2RwKdHSq/7jxOoSWXwmk6Z5eryW3KkvSgqdZog==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793027537;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=5UJG97hDvNuiTsJ8kr/C166iBv6pXFy3viLBEBLO4kA=;
 b=MUozOfATvZUNiA0P7hxpeky0M1T828dl1C3JCeWimNlVMq+HhzhzmFNwXPceiGB35YvG
 vHu55Xli73VllCKP3bsGXytawvF5kPXeKN36+ctZKS1ggD7pBN97HkX7L3WenPNL+3Ima
 iVUEyj1f3HzvtDpRJeBhpSGtwvU70nrW6EB0iwUVs6W68iBzXSwUjnn5HaiSf9ijZ5DD7
 gidGOcaQmSQcg4Ymy8nssijSEOT6dJm8PQAqXBxHu46jN8yWx1pcRslAqWsLU2/ZOyAqY
 OnVOJ+Q4w440KmULu7pYZUjtXwy9FBk16XIjkCt1G/PKWtMS/JLflPx5JnVH7vACd3g==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=gep6sLau; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::f2f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::f2f; helo=mail-qv1-xf2f.google.com;
 envelope-from=ansuelsmth@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=gep6sLau
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6F6DF40062
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 15:12:16 +0000 (UTC)
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-91c63449320so7745996d6.1
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 08:12:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793027535; cv=none;
 d=google.com; s=arc-20260327;
 b=KuMrdcBLCSEhOr9Kr6mEOd/2Z6bBSSns+G3/kl/alBiVdI3l/Q2cJDGsju2x9wc6Zx
 hd8YPJsNTJFaAfBTJbQJR/xSm86C6keVCfDzbX5PUdPkvpAo3q7soaCCUZeJVC4fVh9r
 EsT4UWEoHQTfOW1pLbQfI97RHf5NqphGgdEzrlPeiTHpCAOJpcO2AdFXyZJNWZAGsjxH
 86L4sEpuLodtkmM+7hiGhGtSwlyiCfrwg6LWQkQql1h87XYP/w2Oix63GinXBrZM7G53
 jiNZlaNFi62mg4QCnQYv+8Hh+MrPCiDjWf4vUEYYUotmissKpg05oskXIf46dS75QyD7
 lHTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=5UJG97hDvNuiTsJ8kr/C166iBv6pXFy3viLBEBLO4kA=;
 fh=DLJVrdCKLDNOfM48TbixWpTvBgR1R9UwtCy3lOSiX7s=;
 b=BLIJPsH7Kp6trhEzlMbbfNAJV0wcpuiPxEwfM2cIn2kj9t5pYf0ay3uWpyJQkYcsrv
 s2FF32zThcmgmQwkdGSQBXTC0lnLBf/KHUDoBFCJUGCXft2IFaS6M9Ypbuow8TCL9zLo
 PMHndnveanzGt12TXclg4nRnhP3vYwMunMcK69gwzUScL5I2PDSfbd/v1IOMVQwXm331
 0r5T+/0bxSF5/AgEnLsoNXeNjVKZj16Iy5tLFdm/KHdF2cwgOH2TNwUw8/vswBGwENiy
 5nZil4N5rNgHI+RCnYn+Q1Bo7biOWirVmUp67QmlT0r+3gICCRQV1QkU/5pmJ1Rc5YVw
 I5Xg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793027535; x=1793632335;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=5UJG97hDvNuiTsJ8kr/C166iBv6pXFy3viLBEBLO4kA=;
 b=gep6sLauCqgMwYBpttwY1adDC5hGLhZHXuNcnCtN8fxJ7VbYCEwselVyCSl8u8nyB6
 oAzKkoc8yluIKVleCZyvnRiU9NJ/qramU13a+AsJETWfIdpMsEcKFvStOhS+DEac4bJ3
 ZwrgOle3WvkECcgtLeMOgTG/XTOXgSX6JMjo0Jg80K63yurzoxO698Fo1DgWhqdz8Zmg
 eUACTVih5G0bTietb/gvFQAyVV3ZULpwbgxjTJuLf5t1I+2MKJDHtTjOieCj11yIYWzs
 gkBgLPcA4eVykUcqMB06dSCNsUh/7UkA0Tjz78wWQlV+HguS+HO5NJ0tqktbjH0VLXmu
 IPiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793027535; x=1793632335;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=5UJG97hDvNuiTsJ8kr/C166iBv6pXFy3viLBEBLO4kA=;
 b=VKBITNYMqhj/DldF4ttvvxHExwfGPQdrR1sxqnjszA5uJ0xG2xKHQEmojZGxV/cBKD
 SraTttv1pt/2jD/kpFulV8U8XQ9fbTJWX/vVtnBmkHxYvsp2XmaDLzspNARdcz+4aAlv
 d8gJRpwc9aRVJztm6CtvrCY+wXR5gpZA58EcnJvM9/kncYPv/VUOspUu8fHZKlCgaG2J
 l95XuVeoPgFHbWNjXrt9JNS4IgGHvlv0NFfCU8k91NnRr0DLezkRe1Pno4oEltTr0dj5
 mg4xHuHZxf3Rn0dwovlfEWodrzFF5+B/qs3o/cmc+rGmutOwcYIdH/frCr9NntxnzYKI
 4sZg==
X-Forwarded-Encrypted: i=1;
 AKwUvBx3y6hZufARH9sd5K0iK90o0+qQUEejjfk+r+kWOU3pIHitZt2T4ctUgZou65wdUSpPxgrIAKU=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIIvJKyQ+F47bue7MGe5WLLqgtwqVCq3utjrH4ScaG6mHB8bmUH
 hjjQgKTNw8rDoWUp9/L+EYTre10mxkMaiTlIiglAMATDjyu7LvuxX/qHCM0xLY675bLd4Ebvr9V
 8Dhp6XIgAJ1+2FAZcTgB+kq3Gifc0fbg=
X-Gm-Gg: AYBFou1+e2b0c1ShCKj7A8QRqizwrfQxDgpxL877l3oaBHYEMshQ39xjCX2GoWJU3eK
 hxvNoUIGli8jiKenPFzdCi6QFKs7Gk1soYzHxFvk65u+BJrZvWhR0VenorU3mFGMxhfCz/oerGh
 Bx4vgxnW8bwvQS8r3H532lLox4zps5TZxDWjtAQEOloCSLrF5xE7DhgLb0VYgNLiO9TCdlDWxo7
 3VuUmuoLMr9DdbhaH8yzhnym9cBdX4v9OgkSitC/Uk4zYzHcjIybOxJFaNu27mX3vdwDHNz8CTP
 oK/SLfaIL5vZV107EJR1QiEvkpxy3uG5ur58Nwd5bKog+jM43k/C8ZDAW7IPMzCAVFrh/2ht9Xo
 Pfq9He28T6esF0RtJeIg1jHGLFw/B3ivSfZwm0r/VEJJXmLKzHAPEBk2JYv9rVQJpeeg=
X-Received: by 2002:ad4:5c8d:0:b0:917:8d82:ad9c with SMTP id
 6a1803df08f44-91c48e58627mr124484156d6.24.1793027535382; Mon, 26 Oct 2026
 08:12:15 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261023190034.911023-1-ansuelsmth@gmail.com>
 <20261023190034.911023-9-ansuelsmth@gmail.com>
 <CAFLszTjh1+FGtL4sZLuKrXMvXds-GuG-JaOsZQnLEQ5a+K_05Q@mail.gmail.com>
In-Reply-To: <CAFLszTjh1+FGtL4sZLuKrXMvXds-GuG-JaOsZQnLEQ5a+K_05Q@mail.gmail.com>
From: "Christian Marangi (Ansuel)" <ansuelsmth@gmail.com>
Date: Mon, 26 Oct 2026 16:12:03 +0100
X-Gm-Features: AclHuK_yqwmBxMC83mokd4YY-eMOS7R51vMTfgoetfudlw5LeU3rBq50CLSuAK0
Message-ID: <CA+_ehUyRhx9+cP+Xt9oVGWTDX+wpEXjX-3ENrXQqZw97y3qPnw@mail.gmail.com>
Subject: Re: [PATCH v9 8/8] test: dm: Add test for FW Loader feature
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Heiko Schocher <hs@nabladev.com>,
 Alexey Charkov <alchark@flipper.net>, "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Daniel Golle <daniel@makrotopia.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Mehmet Fide <mehmet.fide@screeningeagle.com>,
 Casey Connolly <casey.connolly@linaro.org>, 
 Michal Simek <michal.simek@amd.com>, Aristo Chen <aristo.chen@canonical.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Anshul Dalal <anshuld@ti.com>, 
 Johan Jonker <jbx6244@gmail.com>, Neha Malcom Francis <n-francis@ti.com>, 
 Marcello Sylvester Bauer <marcello.bauer@9elements.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>, 
 Tan Siewert <tan.siewert@9elements.com>, Yao Zi <me@ziyao.cc>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>, 
 Randolph Sapp <rs@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Martin Schwan <m.schwan@phytec.de>, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Il giorno lun 26 ott 2026 alle ore 16:08 Simon Glass
<sjg@chromium.org> ha scritto:
>
> Hi Christian,
>
> On 2026-10-23T19:00:21, Christian Marangi <ansuelsmth@gmail.com> wrote:
> > test: dm: Add test for FW Loader feature
> >
> > Add basic test for FW Loader feature for the Filesystem way and FIP.
> >
> > Additional MMC testing image are added that loads a dummy firmware.bin in
> > a fat partition or a simple FIP blob.
> >
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> >
> >  arch/sandbox/dts/test.dts          |  38 +++++++
> >  configs/sandbox64_defconfig        |   2 +
> >  configs/sandbox_defconfig          |   2 +
> >  configs/sandbox_flattree_defconfig |   2 +
> >  configs/sandbox_noinst_defconfig   |   1 +
> >  configs/sandbox_spl_defconfig      |   2 +
> >  configs/sandbox_vpl_defconfig      |   2 +
> >  test/dm/Makefile                   |   1 +
> >  test/dm/fw_loader.c                | 218 +++++++++++++++++++++++++++++++++++++
> >  test/py/tests/test_ut.py           |  58 ++++++++++
> >  10 files changed, 326 insertions(+)
>
> > diff --git a/configs/sandbox_noinst_defconfig b/configs/sandbox_noinst_defconfig
> > @@ -21,6 +21,7 @@ CONFIG_SYS_MEMTEST_END=0x00101000
> >  CONFIG_FIT=y
> >  CONFIG_FIT_SIGNATURE=y
> >  CONFIG_FIT_VERBOSE=y
> > +CONFIG_FS_LOADER=y
>
> sandbox_noinst already has CONFIG_FS_LOADER=y (next to
> CONFIG_SPL_FS_LOADER), so this adds a duplicate. It also doesn't
> enable CONFIG_FIP_LOADER. Since FW_LOADER_UCLASS is enabled,
> test/dm/fw_loader.c is still built there, and sandbox_noinst runs
> test.py in CI. So I expect the dm_test_fip_loader_* tests to fail on
> that board, as nothing binds to the fip-loader node. Please can you
> drop this line and add CONFIG_FIP_LOADER instead?
>
> The new lines in the other defconfigs also look hand-placed:
> savedefconfig would put them next to the other drivers/misc options
> (as in noinst), not between WDT_* and FS_CBFS, or between BUTTON_CMD
> and FIT. Please can you regenerate them with 'make savedefconfig'?
>
> > diff --git a/test/dm/fw_loader.c b/test/dm/fw_loader.c
> > @@ -0,0 +1,218 @@
> > +static int dm_test_fw_loader_get_dev(struct unit_test_state *uts,
> > +                                  const char *name, struct udevice **dev)
>
> This is a helper, not a test, so please drop the dm_test_ prefix. Also
> please use 'devp' for the output parameter.
>
> > diff --git a/test/dm/fw_loader.c b/test/dm/fw_loader.c
> > @@ -0,0 +1,218 @@
> > +     ret = request_firmware_into_buf(fw_loader_dev, "firmware.bin",
> > +                                     buf, firmware_size, 0);
> > +     ut_asserteq(firmware_size, ret);
> > +
> > +     ret = request_firmware_into_buf(fw_loader_dev, "firmware.bin",
> > +                                     buf, firmware_size - 10, 10);
> > +     ut_asserteq(firmware_size - 10, ret);
>
> The FS test only checks the return value, not what is read. Please can
> you check the buffer contents as the FIP test does, e.g. clear the
> buffer and then check it against the 0xaa pattern? It would also help
> to use a non-uniform pattern in the image, so that the offset read is
> actually verified.
>
> > diff --git a/test/dm/fw_loader.c b/test/dm/fw_loader.c
> > @@ -0,0 +1,218 @@
> > +     /* uuidgen -n @dns --md5 --name test = 45a113ac-c7f2-30b0-90a5-a399ab912716*/
> > +     ret = request_firmware_size(fw_loader_dev,
> > +                                 "45a113ac-c7f2-30b0-90a5-a399ab912716");
>
> This UUID string is repeated many times, so please put it in a #define
> (with this comment) at the top. That also fixes the over-long comment
> line.
>
> > diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
> > @@ -685,6 +686,61 @@ def test_ut_dm_init(ubman):
> > +        # TOC Entry End Marker: Zero UUID + size set to size of entire FIP
> > +        # Assume alignment as 1
> > +        fh.write(uuid.UUID(int=0).bytes +
> > +            struct.pack('<QQQ',
> > +                fip_toc_header_size + 2 * fip_toc_entry_size + len(data),
> > +                0, 0))
>
> The comment says 'size', but this value goes into the offset field and
> size is 0. That matches TF-A, so only the comment needs fixing.
>

I posted v10 some h ago... I will address these comments and resubmit.
Sorry for not waiting enough time.
