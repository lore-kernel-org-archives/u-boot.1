Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6297A606A31A
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 00:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=zF8nhMZC;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=A8EXdJTY
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 317DB813C9;
	Fri, 23 Oct 2026 00:13:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WmT100OzUUv1; Fri, 23 Oct 2026 00:13:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 12E8E813B0
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792714400;
	b=egxOOieGVlvqw32Upz63e7A3qajkYNMJnvpW0Q+/QvRqPuv8PWlDdtzt0U3Rn86ZVIp6
	 M55YXxDWezsbHIfCPrxV1f5YAYoFdRvQ1rr2y7C2/AbMgDEkz+CIcNTDz2mBTgkHhDaJk
	 ZNDs9iIF4idHT6P/H0osqjaFhEconTlLfx5blpP3AhXC8sie9aunNZBd56lJu+c7v9acJ
	 nToXfBXBlusVS3EDPsJTYZ1YS5+oytn7GazRIqcEZ53S0jZtcXtXH+f4PonOacs4QEoy3
	 1bT0oGzEmt3d9fLDn1D5snOsaPgp0J//KkrJZUHXZ8VrY8NiHoedF8RdF/b8Yfoh67w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792714400;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:From:In-Reply-To:References:MIME-Version:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=lejQtLem30rleocnbchCLMYHtXcB8wU7/ISkDBQCEec=;
	b=nGdK5ZqGoRyymgFY9Ahye9BEv69SHMliI/eXk2rgC3Jd/46BnJOJAdFYW5K3G/9LEihj
	 S604hhiUGcoOiXM6Y9ogJTyvb4QLhYV96S5yrqGm1IzZhGrM2VdFzAvE5UzgDtziOns2n
	 4Sc0UUokA92m9AkTiaeTqfmsBxt3zsAlVOle4S6lzJwoETQJiQ9fJu5Wep8DNCp5+MxRf
	 3vNQ2EDxMEcx/0sdy8gBjAlqGUe9IbftIMNW3yqBFn8HRA4UDAlNvUpONLCCxYpmcjgj5
	 t8Szf/REi2GvQIbCNxdFvRw7vB08uBxWk0IVal3cYX9+RCEpIFrKwjZmKXWg29dciQA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792714400;
	bh=lejQtLem30rleocnbchCLMYHtXcB8wU7/ISkDBQCEec=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zF8nhMZCRzdUNjMc5hIZiF+F4BaGq1hpvuTMyZqrQIEVL3OeUFNOo4Hw4yd8m95/D
	 FYfazwl1mHZOHZS+uVsj9knqAR3CeT/wZnWuvwOX/XZG17nKU5/mJ3rwaGxquq7+5C
	 L2nsgc+wFPhNIKonUF0HRQCHYZ/8bWb12uWcRdGPSLsrpCqZ8+/hBL+vM6u4pkKql1
	 DoLxYJ0w3Uu3YjmUdd3m5WkWuFWcdY89swBGu4tbZ/D9gH4qX5Woagw1ldBOraSPFo
	 FuydvEyeSnLFx77Xa2qCDH/IndhM2oy/sggJXgQMuJTQtykfaFvhmpsadMkwM9bFgg
	 NrQNruIIIyJKw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 12E8E813B0;
	Fri, 23 Oct 2026 00:13:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id C2BC149D
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 23:53:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A898940111
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 23:53:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jW3kHO1E-Ot8 for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 23:53:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 6F591400B3
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::335"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792713234;
 b=aCbBodxf8lhrWQ9AC+Q/lZBirYo4wbxdStROGzAv83zspBk1rucy4C614Xuke+HXKcz+
 9Okjngxebmh7NEOK89edrDxZl71bPPECn9Hxx+B8H8QgwPCE32DsTMeJD408gXbDpWURc
 0XKRZ5XVyUb8c17M1ZG7auoMZzZufu/rOR8gBitKaofAz/q0/ysMuZ0iqk3u7JaXLACua
 hndIcumALYJoxa8I/aTeHHlRlf+k9YTOEE+SA9ySqbACIciXJdV8mOF55Ddmeg/+QjXHA
 9CiuIaLqup02oM+XiGnWKXjXGMWyaM3wkm7TsKx+kHoLRrydFu4xbsHEntIfsOiSTcA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792713234;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:From:
 In-Reply-To:References:MIME-Version:Date:X-Gm-Features:Message-ID:
 Subject:To:Cc:Content-Type;
 bh=lejQtLem30rleocnbchCLMYHtXcB8wU7/ISkDBQCEec=;
 b=OoWVZJ4xic5FwqKpXM96bQB7uR6nUW62T0PRSKk+z0+/u1MJo7fC0RdWaPn+20wCiRxv
 hwdTQlDtryenl9og8f0FPHMk+7Xr+CSCw8Biyprk4o3svURuoDgqWVhaINXFHTIBHI35g
 4knwE5iIroDOSfASr0cFpsZyD85QupXrSvWXhvDAUqq18Z0o12Tm0tsZeojJDin7jDS5s
 QTKC72WE6MPhG74vX0V6oFqgmcN8MxiKLexOGUfYvmlJwY8TqwYt8lXlkGg6tIGmA1dS+
 TPipk3+3uXP9wKLenU85KGrmfZuUtRZEqQrLj3y6bll+JmssXoj4xGWGFDed5oLpyow==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=A8EXdJTY; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::335"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::335; helo=mail-ot1-x335.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=A8EXdJTY
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6F591400B3
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 23:53:54 +0000 (UTC)
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-825b40f8a26so152393a34.1
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 16:53:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792713233; cv=none;
 d=google.com; s=arc-20260327;
 b=VplbDDSZvb0ULTawrZ3iwaTw68krcgcKEn6rjnyIECs8A9MFkOUqAb48yfM9n5HPmM
 zyHFKuIVH++XWEPVeXGBci0UxkzZQ93k+pXYIYyCObekoNThJuuSdBXBxcpi/49LU1bU
 kqm+w1oXazmsuwBlo8BfZuFpGNEyfHAcupLL9YFtf0c9+T7bBs8DLwxDoZIzAbBeN35z
 kL33O/Toki36jGcEyJnAkOifT4TK06tZO7bwpg5DT0id5m38yn2/J3FLCZdN4TKMDdvi
 6IAKHF3BsKKhiw772d9mZvgEMUekAHuFaBQPVEuvnd7xeSb9bpC/Se7MBzO+o3a2aAH1
 /zdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
 :from:dkim-signature;
 bh=lejQtLem30rleocnbchCLMYHtXcB8wU7/ISkDBQCEec=;
 fh=u4xG2KwCOaAX3LACWiWdBW7foS+n2V4JX1MkoNaREaI=;
 b=j1Y90ViyL4fGUJeZb57dl2PNH23paBUlxr9Q4dfhlPTSE6aMJsnBvrgDt2dMGhMZKw
 wcRmK/r0BI1WjwdgZLUMCmFHvviYo96RYDz+Iv7A/XDusmG0v4RduvHa1Oz6Zoj+SRO6
 sbBBXGaiXzIgWZSAbiCa4/ftYl6gEuqXoDNran5+QjIL8gvLy/mkyFWoVTtnYivXA97e
 TLMDu3W0+zQtAFlw8p4fMkpxIasmHZ1oZW8uClbEhS+ElaBoQXfpFD9HkvwgQEb7ucnD
 Je7Qky0Qk2BabILLJhVsgHIggt/K5NNSLsWYurKBlxHNrdfguN6o733z7ThyTTbdsRii
 mtvA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792713233; x=1793318033;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=lejQtLem30rleocnbchCLMYHtXcB8wU7/ISkDBQCEec=;
 b=A8EXdJTY8s3j33yhZi7TV8uJ2ale0nw/afzTdnDBlE0m/sL8hJPYZ79Hdo+MEzj2ZM
 Z+1UF9EJAbc55Ky/BNrGqQ5DzxW/f4Kqea4DuadVTslrnZnfZwWBWzj4K0YCpDixDyFH
 W1XYSh59u8metfVqWfKIuKoHFps5DGChzogzUMuiovjXKw4zOdrwvWFwZ1DnjjUjy0VU
 BwzOzvHfC/V9RmHwNVCDrAFH7E/m3R7cQMqsEDOpcZgiUnXPn92sugTiKrFspUGLFVs5
 7Lx8ABfvWudeBlJjlk+rC52S0q/v3ngYlHPTyN0J4wjfpus0HLyNlunl18i4L41gAg6w
 FcTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792713233; x=1793318033;
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lejQtLem30rleocnbchCLMYHtXcB8wU7/ISkDBQCEec=;
 b=JdlSIsaelhn3wKsaUe4U59becZBT6tmZLg/KLes7VNvgkJYu1J9zGMho7xOc5XnJhU
 Vo44WhRDqCTGuTWw8Gp5RJD+rO0IqvkbVULHiz65Woj6C/XZpLITaeSZxXbE8cxx6V21
 5Ca4xjp60sRtW5qk+AhHCramvxqjSc82uIXX8ReBgr5usETObQp7JS6U9FoOSMGiK67a
 RDr3ahuubNYX1PwYWlSxnJj/cSelHa3/HJKsxLFgnUEfvm10zFSzkYFttTP3dyGpPG3O
 lRDjOpwJYH3Ln4t2KkkTc0kYYHsIT2QuYsYH1Ys5Wbj7zvcxE4+DzH90Ek5YzVNyyOUh
 kCMg==
X-Gm-Message-State: AFq9FYLeBOV2RQTYW8ii7ozLeXbM67gG3+xG+qab7wQ8Am/vtu0oaXpx
 L9J9PkctlpVpgCvyOLV2sO3N9DVpTBeSXWl4uKHaxIqMtSsSRL4q83ZQ9zxfIMkE70Vy1EFLxLo
 +QUFO1xHuTb6bUvA2zgG+q3DtuoN1HFn53HVY
X-Gm-Gg: AYBFou1R8qyUdSYpmo4Qh3qpXJ32d3ztyN1UJcoZozTXPRAfVdjQQDNTwB+snFgoj1w
 UMcCb2I8NaXnhCuJjf2hxuy55GkzsjRB4ignZ+qdpcyNNrFJB7fOt/dPBkb6yytgv33L8yZHNCt
 FGnzZSp59dabPYts3V53AQc9KpoPav1wFV6GjprlCzG3wBImad8Dnuh3XjDj2O2ULdLxK7TgXCB
 an2ZsaRR4mhY62nOoPm9MT/VSuFLXXoc6Uh8Kx0lyxQE57i4+6E6ogNGcwu+s/q9bjyJaSB8iiL
 XPPB4d/KYNLjahSSke9gS3uanfV3wFWBzezfJE9HzzxLbK43vq3+KqN75LxEqJdYHhYLAGKKjsw
 gMDc0WxyqiYjXT/2uNSBUeyQ=
X-Received: by 2002:a05:6808:124a:b0:4e0:1d24:cec0 with SMTP id
 5614622812f47-55be80be39emr431995b6e.8.1792713233251; Thu, 22 Oct 2026
 16:53:53 -0700 (PDT)
Received: from 1077388689865 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 22 Oct 2026 16:53:52 -0700
Received: from 1077388689865 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 22 Oct 2026 16:53:52 -0700
From: Ana Bobillo <anabobillo3@gmail.com>
In-Reply-To: <CAJnxHsiYXMS--ZjXXN_pOZMbHyyGX3ANAj=fYSMKvjgjxzeWTQ@mail.gmail.com>
References: <CAJnxHsiYXMS--ZjXXN_pOZMbHyyGX3ANAj=fYSMKvjgjxzeWTQ@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Thu, 22 Oct 2026 16:53:52 -0700
X-Gm-Features: AclHuK8J-zZtD_Pz98PZ7bwfF8K786AG_7jmRlD9CH4aBbMSUufyjIeVN3KRRNk
Message-ID: <CAJnxHsiDWx6fLoNc8u_dM5STMjvTuM=ZCffa+r3BChf0-mk+Sg@mail.gmail.com>
Subject: [PATCH 6/6] test: lib: add tests for the capsule size checks
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>
Content-Type: multipart/mixed; boundary="00000000000073e2c8065e769315"
X-Mailman-Approved-At: Fri, 23 Oct 2026 00:13:01 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--00000000000073e2c8065e769315
Content-Type: text/plain; charset="UTF-8"

From: Ana Bobillo <anabobillo3@gmail.com>

--00000000000073e2c8065e769315
Content-Type: text/plain; charset="utf-8"; name="0006.patch"
Content-Disposition: attachment; filename="0006.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: 458934cb93143e54_0.1

QWRkIHVuaXQgdGVzdHMgdGhhdCBwYXNzIG1hbGZvcm1lZCBGTVAgY2Fwc3VsZXMgdG8gZWZpX3Vw
ZGF0ZV9jYXBzdWxlKCkKYW5kIGFuIGltYWdlIHdpdGggYSBjZXJ0aWZpY2F0ZSBsb25nZXIgdGhh
biBpdHNlbGYgdG8KZWZpX2NhcHN1bGVfYXV0aGVudGljYXRlKCksIGFuZCBjaGVjayB0aGF0IHRo
ZXkgYXJlIHJlamVjdGVkOgoKLSBhIGNhcHN1bGUgZW5kaW5nIGluc2lkZSB0aGUgRk1QIGNhcHN1
bGUgaGVhZGVyOwotIGFuIGl0ZW0gb2Zmc2V0IGxpc3QgcnVubmluZyBwYXN0IHRoZSBlbmQgb2Yg
dGhlIGNhcHN1bGU7Ci0gYW4gaXRlbSBvZmZzZXQgdGhhdCB3cmFwcyBhcm91bmQgd2hlbiB0aGUg
aW1hZ2UgaGVhZGVyIHNpemUgaXMgYWRkZWQ7Ci0gYW4gaW1hZ2Ugb3IgdmVuZG9yIGNvZGUgbGFy
Z2VyIHRoYW4gdGhlIHJlc3Qgb2YgdGhlIGNhcHN1bGU7Ci0gYSBjZXJ0aWZpY2F0ZSBsb25nZXIg
dGhhbiB0aGUgaW1hZ2UuCgpFYWNoIGNhcHN1bGUgaXMgYnVpbHQgaW5zaWRlIGEgbGFyZ2VyIHpl
cm9lZCBidWZmZXIsIHNvIHRoYXQgd2l0aG91dCB0aGUKY2hlY2tzIHRoZSBjb2RlIHJlYWRzIHRo
ZSBieXRlcyBhcm91bmQgaXQgYW5kIHJldHVybnMgYW5vdGhlciBzdGF0dXMKKGZvciB0aGUgY2Vy
dGlmaWNhdGUsIGEgd3JhcHBlZCBpbWFnZSBzaXplKSBpbnN0ZWFkIG9mIGZhdWx0aW5nLgoKU2ln
bmVkLW9mZi1ieTogQW5hIEJvYmlsbG8gPGFuYWJvYmlsbG8zQGdtYWlsLmNvbT4KLS0tCiB0ZXN0
L2xpYi9NYWtlZmlsZSAgICAgIHwgICAxICsKIHRlc3QvbGliL2VmaV9jYXBzdWxlLmMgfCAxOTMg
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKIDIgZmlsZXMgY2hhbmdl
ZCwgMTk0IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS90ZXN0L2xpYi9NYWtlZmlsZSBiL3Rl
c3QvbGliL01ha2VmaWxlCmluZGV4IDlmYzRhMWE5YjVkLi4wZmI2YzZlYWJkZSAxMDA2NDQKLS0t
IGEvdGVzdC9saWIvTWFrZWZpbGUKKysrIGIvdGVzdC9saWIvTWFrZWZpbGUKQEAgLTEwLDYgKzEw
LDcgQEAgb2JqLXkgKz0gYWJ1Zi5vCiBvYmoteSArPSBhbGlzdC5vCiBvYmotJChDT05GSUdfRUNE
U0FfVkVSSUZZX01CRURUTFMpICs9IGVjZHNhLm8KIG9iai0kKENPTkZJR19FRklfTE9BREVSKSAr
PSBlZmlfZGV2aWNlX3BhdGgubyBlZmlfbWVtb3J5Lm8KK29iai0kKENPTkZJR19FRklfQ0FQU1VM
RV9GSVJNV0FSRSkgKz0gZWZpX2NhcHN1bGUubwogb2JqLSQoQ09ORklHX0VGSV9TRUNVUkVfQk9P
VCkgKz0gZWZpX2ltYWdlX3JlZ2lvbi5vCiBpZmRlZiBDT05GSUdfUklTQ1YKIG9iai0kKENPTkZJ
R19VU0VfUFJJVkFURV9MSUJHQ0MpICs9IHRlc3RfY2x6Lm8KZGlmZiAtLWdpdCBhL3Rlc3QvbGli
L2VmaV9jYXBzdWxlLmMgYi90ZXN0L2xpYi9lZmlfY2Fwc3VsZS5jCm5ldyBmaWxlIG1vZGUgMTAw
NjQ0CmluZGV4IDAwMDAwMDAwMDAwLi43ZTRlMWU2OTU0MAotLS0gL2Rldi9udWxsCisrKyBiL3Rl
c3QvbGliL2VmaV9jYXBzdWxlLmMKQEAgLTAsMCArMSwxOTMgQEAKKy8vIFNQRFgtTGljZW5zZS1J
ZGVudGlmaWVyOiBHUEwtMi4wKworLyoKKyAqIFRlc3QgdGhlIHNpemUgY2hlY2tzIG9mIGNhcHN1
bGUgdXBkYXRlcworICoKKyAqIENvcHlyaWdodCAoYykgMjAyNiBBbmEgQm9iaWxsbyA8YW5hYm9i
aWxsbzNAZ21haWwuY29tPgorICovCisKKyNpbmNsdWRlIDxlZmlfbG9hZGVyLmg+CisjaW5jbHVk
ZSA8cGUuaD4KKyNpbmNsdWRlIDx0ZXN0L2xpYi5oPgorI2luY2x1ZGUgPHRlc3QvdGVzdC5oPgor
I2luY2x1ZGUgPHRlc3QvdXQuaD4KKworc3RhdGljIGNvbnN0IGVmaV9ndWlkX3QgZm1wX2NhcHN1
bGVfZ3VpZCA9CisJRUZJX0ZJUk1XQVJFX01BTkFHRU1FTlRfQ0FQU1VMRV9JRF9HVUlEOworCisv
KgorICogQ2Fwc3VsZXMgYXJlIGJ1aWx0IGluIHRoZSBtaWRkbGUgb2YgdGhpcyBidWZmZXIsIHNv
IHRoYXQgdGhlIGJ5dGVzCisgKiBiZWZvcmUgYW5kIGFmdGVyIGEgY2Fwc3VsZSBhcmUgemVybyBh
bmQgY2FuIGJlIHJlYWQgd2l0aG91dCBhIGZhdWx0CisgKiBpZiBhIHNpemUgY2hlY2sgaXMgbWlz
c2luZy4KKyAqLworc3RhdGljIHU4IGJ1ZlsxMDI0XSBfX2FsaWduZWQoOCk7CisKKy8qKgorICog
Zm1wX2NhcHN1bGVfaW5pdCgpIC0gc2V0IHVwIGFuIEZNUCBjYXBzdWxlIGluIHRoZSBtaWRkbGUg
b2YgYnVmCisgKgorICogQGZtcF9zaXplOglzaXplIG9mIHRoZSBGTVAgY2Fwc3VsZSBmb2xsb3dp
bmcgdGhlIGNhcHN1bGUgaGVhZGVyCisgKiBSZXR1cm46CWNhcHN1bGUgaGVhZGVyCisgKi8KK3N0
YXRpYyBzdHJ1Y3QgZWZpX2NhcHN1bGVfaGVhZGVyICpmbXBfY2Fwc3VsZV9pbml0KHNpemVfdCBm
bXBfc2l6ZSkKK3sKKwlzdHJ1Y3QgZWZpX2NhcHN1bGVfaGVhZGVyICpjYXBzdWxlID0gKHZvaWQg
KilidWYgKyAyNTY7CisKKwltZW1zZXQoYnVmLCAwLCBzaXplb2YoYnVmKSk7CisJZ3VpZGNweSgm
Y2Fwc3VsZS0+Y2Fwc3VsZV9ndWlkLCAmZm1wX2NhcHN1bGVfZ3VpZCk7CisJY2Fwc3VsZS0+aGVh
ZGVyX3NpemUgPSBzaXplb2YoKmNhcHN1bGUpOworCWNhcHN1bGUtPmNhcHN1bGVfaW1hZ2Vfc2l6
ZSA9IHNpemVvZigqY2Fwc3VsZSkgKyBmbXBfc2l6ZTsKKworCXJldHVybiBjYXBzdWxlOworfQor
CisvKioKKyAqIHVwZGF0ZV9jYXBzdWxlKCkgLSBwYXNzIG9uZSBjYXBzdWxlIHRvIFVwZGF0ZUNh
cHN1bGUoKQorICoKKyAqIEBjYXBzdWxlOgljYXBzdWxlIGhlYWRlcgorICogUmV0dXJuOglzdGF0
dXMgY29kZQorICovCitzdGF0aWMgZWZpX3N0YXR1c190IHVwZGF0ZV9jYXBzdWxlKHN0cnVjdCBl
ZmlfY2Fwc3VsZV9oZWFkZXIgKmNhcHN1bGUpCit7CisJcmV0dXJuIEVGSV9DQUxMKGVmaV91cGRh
dGVfY2Fwc3VsZSgmY2Fwc3VsZSwgMSwgMCkpOworfQorCisvKiBlZmlfY2Fwc3VsZV91cGRhdGVf
ZmlybXdhcmUoKSBtdXN0IGNoZWNrIHRoZSBGTVAgY2Fwc3VsZSBoZWFkZXIgc2l6ZSAqLworc3Rh
dGljIGludCBsaWJfdGVzdF9lZmlfY2Fwc3VsZV91cGRhdGVfZm1wX2hlYWRlcihzdHJ1Y3QgdW5p
dF90ZXN0X3N0YXRlICp1dHMpCit7CisJc3RydWN0IGVmaV9jYXBzdWxlX2hlYWRlciAqY2Fwc3Vs
ZTsKKwlzdHJ1Y3QgZWZpX2Zpcm13YXJlX21hbmFnZW1lbnRfY2Fwc3VsZV9oZWFkZXIgKmZtcDsK
KworCS8qIFRoZSBGV1UgY2hlY2tzIHJlamVjdCBhIGNhcHN1bGUgYmVmb3JlIGl0IGlzIHBhcnNl
ZCAqLworCWlmIChJU19FTkFCTEVEKENPTkZJR19GV1VfTVVMVElfQkFOS19VUERBVEUpKQorCQly
ZXR1cm4gLUVBR0FJTjsKKworCXV0X2Fzc2VydGVxXzY0KEVGSV9TVUNDRVNTLCBlZmlfaW5pdF9v
YmpfbGlzdCgpKTsKKworCS8qIFRoZSBjYXBzdWxlIGVuZHMgYWZ0ZXIgdGhlIHZlcnNpb24gZmll
bGQgKi8KKwljYXBzdWxlID0gZm1wX2NhcHN1bGVfaW5pdChzaXplb2YoZm1wLT52ZXJzaW9uKSk7
CisJZm1wID0gKHZvaWQgKiljYXBzdWxlICsgY2Fwc3VsZS0+aGVhZGVyX3NpemU7CisJZm1wLT52
ZXJzaW9uID0gMTsKKwl1dF9hc3NlcnRlcV82NChFRklfSU5WQUxJRF9QQVJBTUVURVIsIHVwZGF0
ZV9jYXBzdWxlKGNhcHN1bGUpKTsKKworCXJldHVybiAwOworfQorTElCX1RFU1QobGliX3Rlc3Rf
ZWZpX2NhcHN1bGVfdXBkYXRlX2ZtcF9oZWFkZXIsIDApOworCisvKiBlZmlfY2Fwc3VsZV91cGRh
dGVfZmlybXdhcmUoKSBtdXN0IGNoZWNrIHRoZSBpdGVtIG9mZnNldCBsaXN0IHNpemUgKi8KK3N0
YXRpYyBpbnQgbGliX3Rlc3RfZWZpX2NhcHN1bGVfdXBkYXRlX2l0ZW1fbGlzdChzdHJ1Y3QgdW5p
dF90ZXN0X3N0YXRlICp1dHMpCit7CisJc3RydWN0IGVmaV9jYXBzdWxlX2hlYWRlciAqY2Fwc3Vs
ZTsKKwlzdHJ1Y3QgZWZpX2Zpcm13YXJlX21hbmFnZW1lbnRfY2Fwc3VsZV9oZWFkZXIgKmZtcDsK
KworCS8qIFRoZSBGV1UgY2hlY2tzIHJlamVjdCBhIGNhcHN1bGUgYmVmb3JlIGl0IGlzIHBhcnNl
ZCAqLworCWlmIChJU19FTkFCTEVEKENPTkZJR19GV1VfTVVMVElfQkFOS19VUERBVEUpKQorCQly
ZXR1cm4gLUVBR0FJTjsKKworCXV0X2Fzc2VydGVxXzY0KEVGSV9TVUNDRVNTLCBlZmlfaW5pdF9v
YmpfbGlzdCgpKTsKKworCS8qIFJvb20gZm9yIGVpZ2h0IGl0ZW0gb2Zmc2V0cywgYnV0IG5pbmUg
aXRlbXMgKi8KKwljYXBzdWxlID0gZm1wX2NhcHN1bGVfaW5pdChzaXplb2YoKmZtcCkgKyA4ICog
c2l6ZW9mKHU2NCkpOworCWZtcCA9ICh2b2lkICopY2Fwc3VsZSArIGNhcHN1bGUtPmhlYWRlcl9z
aXplOworCWZtcC0+dmVyc2lvbiA9IDE7CisJZm1wLT5lbWJlZGRlZF9kcml2ZXJfY291bnQgPSA4
OworCWZtcC0+cGF5bG9hZF9pdGVtX2NvdW50ID0gMTsKKwkvKiBUaGUgbmludGggaXRlbSBvZmZz
ZXQgbGllcyBwYXN0IHRoZSBlbmQgb2YgdGhlIGNhcHN1bGUgKi8KKwlmbXAtPml0ZW1fb2Zmc2V0
X2xpc3RbOF0gPSBzaXplb2YoKmZtcCk7CisJdXRfYXNzZXJ0ZXFfNjQoRUZJX0lOVkFMSURfUEFS
QU1FVEVSLCB1cGRhdGVfY2Fwc3VsZShjYXBzdWxlKSk7CisKKwlyZXR1cm4gMDsKK30KK0xJQl9U
RVNUKGxpYl90ZXN0X2VmaV9jYXBzdWxlX3VwZGF0ZV9pdGVtX2xpc3QsIDApOworCisvKiBlZmlf
Y2Fwc3VsZV91cGRhdGVfZmlybXdhcmUoKSBtdXN0IGNoZWNrIGFuIGl0ZW0gb2Zmc2V0IHdpdGhv
dXQgb3ZlcmZsb3cgKi8KK3N0YXRpYyBpbnQgbGliX3Rlc3RfZWZpX2NhcHN1bGVfdXBkYXRlX2l0
ZW1fb2Zmc2V0KHN0cnVjdCB1bml0X3Rlc3Rfc3RhdGUgKnV0cykKK3sKKwlzdHJ1Y3QgZWZpX2Nh
cHN1bGVfaGVhZGVyICpjYXBzdWxlOworCXN0cnVjdCBlZmlfZmlybXdhcmVfbWFuYWdlbWVudF9j
YXBzdWxlX2hlYWRlciAqZm1wOworCXN0cnVjdCBlZmlfZmlybXdhcmVfbWFuYWdlbWVudF9jYXBz
dWxlX2ltYWdlX2hlYWRlciAqaW1hZ2U7CisKKwkvKiBUaGUgRldVIGNoZWNrcyByZWplY3QgYSBj
YXBzdWxlIGJlZm9yZSBpdCBpcyBwYXJzZWQgKi8KKwlpZiAoSVNfRU5BQkxFRChDT05GSUdfRldV
X01VTFRJX0JBTktfVVBEQVRFKSkKKwkJcmV0dXJuIC1FQUdBSU47CisKKwl1dF9hc3NlcnRlcV82
NChFRklfU1VDQ0VTUywgZWZpX2luaXRfb2JqX2xpc3QoKSk7CisKKwljYXBzdWxlID0gZm1wX2Nh
cHN1bGVfaW5pdChzaXplb2YoKmZtcCkgKyBzaXplb2YodTY0KSArCisJCQkJICAgc2l6ZW9mKCpp
bWFnZSkgKyAxNik7CisJZm1wID0gKHZvaWQgKiljYXBzdWxlICsgY2Fwc3VsZS0+aGVhZGVyX3Np
emU7CisJZm1wLT52ZXJzaW9uID0gMTsKKwlmbXAtPnBheWxvYWRfaXRlbV9jb3VudCA9IDE7CisJ
LyogT2Zmc2V0IHBsdXMgaW1hZ2UgaGVhZGVyIHNpemUgd3JhcHMgYXJvdW5kIHRvIHplcm8gKi8K
KwlmbXAtPml0ZW1fb2Zmc2V0X2xpc3RbMF0gPSAtKHU2NClzaXplb2YoKmltYWdlKTsKKwl1dF9h
c3NlcnRlcV82NChFRklfSU5WQUxJRF9QQVJBTUVURVIsIHVwZGF0ZV9jYXBzdWxlKGNhcHN1bGUp
KTsKKworCXJldHVybiAwOworfQorTElCX1RFU1QobGliX3Rlc3RfZWZpX2NhcHN1bGVfdXBkYXRl
X2l0ZW1fb2Zmc2V0LCAwKTsKKworLyogZWZpX2NhcHN1bGVfdXBkYXRlX2Zpcm13YXJlKCkgbXVz
dCBjaGVjayB0aGUgaW1hZ2UgYW5kIHZlbmRvciBjb2RlIHNpemVzICovCitzdGF0aWMgaW50IGxp
Yl90ZXN0X2VmaV9jYXBzdWxlX3VwZGF0ZV9pbWFnZV9zaXplKHN0cnVjdCB1bml0X3Rlc3Rfc3Rh
dGUgKnV0cykKK3sKKwlzdHJ1Y3QgZWZpX2NhcHN1bGVfaGVhZGVyICpjYXBzdWxlOworCXN0cnVj
dCBlZmlfZmlybXdhcmVfbWFuYWdlbWVudF9jYXBzdWxlX2hlYWRlciAqZm1wOworCXN0cnVjdCBl
ZmlfZmlybXdhcmVfbWFuYWdlbWVudF9jYXBzdWxlX2ltYWdlX2hlYWRlciAqaW1hZ2U7CisKKwkv
KiBUaGUgRldVIGNoZWNrcyByZWplY3QgYSBjYXBzdWxlIGJlZm9yZSBpdCBpcyBwYXJzZWQgKi8K
KwlpZiAoSVNfRU5BQkxFRChDT05GSUdfRldVX01VTFRJX0JBTktfVVBEQVRFKSkKKwkJcmV0dXJu
IC1FQUdBSU47CisKKwl1dF9hc3NlcnRlcV82NChFRklfU1VDQ0VTUywgZWZpX2luaXRfb2JqX2xp
c3QoKSk7CisKKwljYXBzdWxlID0gZm1wX2NhcHN1bGVfaW5pdChzaXplb2YoKmZtcCkgKyBzaXpl
b2YodTY0KSArCisJCQkJICAgc2l6ZW9mKCppbWFnZSkgKyAxNik7CisJZm1wID0gKHZvaWQgKilj
YXBzdWxlICsgY2Fwc3VsZS0+aGVhZGVyX3NpemU7CisJZm1wLT52ZXJzaW9uID0gMTsKKwlmbXAt
PnBheWxvYWRfaXRlbV9jb3VudCA9IDE7CisJZm1wLT5pdGVtX29mZnNldF9saXN0WzBdID0gc2l6
ZW9mKCpmbXApICsgc2l6ZW9mKHU2NCk7CisJaW1hZ2UgPSAodm9pZCAqKWZtcCArIGZtcC0+aXRl
bV9vZmZzZXRfbGlzdFswXTsKKwlpbWFnZS0+dmVyc2lvbiA9IDM7CisKKwkvKiBUaGUgaW1hZ2Ug
aXMgbGFyZ2VyIHRoYW4gdGhlIGNhcHN1bGUgKi8KKwlpbWFnZS0+dXBkYXRlX2ltYWdlX3NpemUg
PSAxNzsKKwl1dF9hc3NlcnRlcV82NChFRklfSU5WQUxJRF9QQVJBTUVURVIsIHVwZGF0ZV9jYXBz
dWxlKGNhcHN1bGUpKTsKKworCS8qIFRoZSB2ZW5kb3IgY29kZSBkb2VzIG5vdCBmaXQgYWZ0ZXIg
dGhlIGltYWdlICovCisJaW1hZ2UtPnVwZGF0ZV9pbWFnZV9zaXplID0gMTY7CisJaW1hZ2UtPnVw
ZGF0ZV92ZW5kb3JfY29kZV9zaXplID0gMTsKKwl1dF9hc3NlcnRlcV82NChFRklfSU5WQUxJRF9Q
QVJBTUVURVIsIHVwZGF0ZV9jYXBzdWxlKGNhcHN1bGUpKTsKKworCS8qIEJvdGggZml0OiB0aGVy
ZSBpcyBubyBGTVAgZHJpdmVyIGZvciB0aGUgemVybyBpbWFnZSB0eXBlICovCisJaW1hZ2UtPnVw
ZGF0ZV92ZW5kb3JfY29kZV9zaXplID0gMDsKKwl1dF9hc3NlcnRlcV82NChFRklfVU5TVVBQT1JU
RUQsIHVwZGF0ZV9jYXBzdWxlKGNhcHN1bGUpKTsKKworCXJldHVybiAwOworfQorTElCX1RFU1Qo
bGliX3Rlc3RfZWZpX2NhcHN1bGVfdXBkYXRlX2ltYWdlX3NpemUsIDApOworCisvKiBlZmlfcmVt
b3ZlX2F1dGhfaGRyKCkgbXVzdCBjaGVjayB0aGUgY2VydGlmaWNhdGUgbGVuZ3RoICovCitzdGF0
aWMgaW50IGxpYl90ZXN0X2VmaV9yZW1vdmVfYXV0aF9oZHJfbGVuZ3RoKHN0cnVjdCB1bml0X3Rl
c3Rfc3RhdGUgKnV0cykKK3sKKwlzdHJ1Y3QgZWZpX2Zpcm13YXJlX2ltYWdlX2F1dGhlbnRpY2F0
aW9uICphdXRoOworCWVmaV91aW50bl90IGNhcHN1bGVfc2l6ZSA9IDY0OworCWVmaV91aW50bl90
IGltYWdlX3NpemU7CisJdm9pZCAqaW1hZ2U7CisKKwlpZiAoIUlTX0VOQUJMRUQoQ09ORklHX0VG
SV9DQVBTVUxFX0FVVEhFTlRJQ0FURSkpCisJCXJldHVybiAtRUFHQUlOOworCisJbWVtc2V0KGJ1
ZiwgMCwgc2l6ZW9mKGJ1ZikpOworCWF1dGggPSAodm9pZCAqKWJ1ZjsKKwkvKiBUaGUgY2VydGlm
aWNhdGUgaXMgbG9uZ2VyIHRoYW4gdGhlIGNhcHN1bGUgKi8KKwlhdXRoLT5hdXRoX2luZm8uaGRy
LmR3TGVuZ3RoID0gMjU2OworCWF1dGgtPmF1dGhfaW5mby5oZHIud1JldmlzaW9uID0gV0lOX0NF
UlRfUkVWSVNJT05fMl8wOworCWF1dGgtPmF1dGhfaW5mby5oZHIud0NlcnRpZmljYXRlVHlwZSA9
IFdJTl9DRVJUX1RZUEVfRUZJX0dVSUQ7CisJZ3VpZGNweSgmYXV0aC0+YXV0aF9pbmZvLmNlcnRf
dHlwZSwgJmVmaV9ndWlkX2NlcnRfdHlwZV9wa2NzNyk7CisKKwl1dF9hc3NlcnRlcV82NChFRklf
U0VDVVJJVFlfVklPTEFUSU9OLAorCQkgICAgICAgZWZpX2NhcHN1bGVfYXV0aGVudGljYXRlKGJ1
ZiwgY2Fwc3VsZV9zaXplLCAmaW1hZ2UsCisJCQkJCQkmaW1hZ2Vfc2l6ZSkpOworCS8qIFRoZSBp
bWFnZSBzaXplIG11c3Qgbm90IGhhdmUgd3JhcHBlZCBhcm91bmQgKi8KKwl1dF9hc3NlcnRlcV82
NChjYXBzdWxlX3NpemUsIGltYWdlX3NpemUpOworCisJcmV0dXJuIDA7Cit9CitMSUJfVEVTVChs
aWJfdGVzdF9lZmlfcmVtb3ZlX2F1dGhfaGRyX2xlbmd0aCwgMCk7Cg==
--00000000000073e2c8065e769315--
