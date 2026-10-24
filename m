Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9AD606A31A
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 10:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ZqFMtk3N;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aEYcgGbd
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D6F3360AC2;
	Sat, 24 Oct 2026 10:13:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SKU94a8R8atC; Sat, 24 Oct 2026 10:13:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org BD8A460A41
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792836791;
	b=nx8Kuop23+4ZYo3dfe1xUqf/1mhEZhdhNJzX0+S2DvqwkhavS9+hIwIpEFvL03uBmYZr
	 IESQ/ya0XS6QeEN3ObulROVWXTiDR/2uIfq5//sQShsqjDAmXhNHvUAtv94A7fJNebQEG
	 4bXwe9g03wvSF0Yh6jCnyBmR01p/3SXyktUdwz7k1lMN3RRZKf3BQB+4TMrzgKkT0CUM3
	 bK3E7+11VldcoxRR5ulQgfuo6nRUsOklTX1yBdksASZGMCHJFsHJi5yKnsjcJJkfSFqkF
	 1LeCI6zFfn1+SSM2Mr1+7bjbXJ2QL1n/L8zsCrnVWkrXNx7bgen1Cm6g94guzZnh1cg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792836791;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:From:In-Reply-To:References:MIME-Version:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=rG8LWOaG5YUxH6F2mvzlKRXwnVwA6W9eUkHhI0MNYwU=;
	b=jgFklvXzq/tol7/sLbCkIZMcl9kyTj0oeKhJWOZGO1OBRswZIKa6cOyNFEQTksYhrtEg
	 eBm1iD49HFMdudB/Orwdk6BdU87JkROs/kzn2o1uHz8b6DWsrvEOU1EQF6g2RIdSh+cUx
	 DHCi1yG5agXG/7pLPAUIjqDlLy85N9t6cRRX5SSciTER5u/YNNMNCIxEVFHqDr9vg/lWE
	 Xj7rvcGEiWYP7PXXHzbyVfScKcrx4DL/SIhDU3FxntLnjbS70sCGvkkSCKYpfu0yk1PEw
	 1vyE6iOr5XCVJ0YkjclIhfZwEfTAOPQhXRgBOmr0wBhrDw2A61IW/LcrogjuTPFfFog==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792836791;
	bh=rG8LWOaG5YUxH6F2mvzlKRXwnVwA6W9eUkHhI0MNYwU=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZqFMtk3NSpLjdfJdpZxSNYxt01VraIYNJBcIMPnGCRMp0WbYspnT1pJTXkKC/MH+/
	 DcEhjFenOMaM7ZVbrH7tB2OKiy0Z7nP86TvBHFwFBPgRnfrHzdBLYOfFPhUlB8i4tR
	 twwQ2h+ZXJfLISE2xrEnTbCO6KoAzALHQlBMMAu1kYYDWAy0CmOEk3hJ+PNTfrNMkD
	 2cTMbVKI885CBtpbRuDw4MIma9nuaLmk0QkAi+o2m2caz8Klv2Obv1DbzOVE4XkgaE
	 Fd6hep9S8xIgg289/b/lfPylFzZlqjsipWpqRPpI99jZX4EcnDh/s94mLPlpg+bzY1
	 h2EcJcjA1soXQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BD8A460A41;
	Sat, 24 Oct 2026 10:13:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id D2B2C356
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 10:13:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C44728166E
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 10:13:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mvWe4AGRw_ge for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 10:13:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B37D68169A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::230"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792836790;
 b=KL68kfHUPN5Zg3X/DqUGC/Ta+KFvjshxBxOz+d4zaZT4RO4/Zc+Ihgq4C7bFT+Uh9/R2
 OXzC/vu4er4txVQT161HOd0q/gANJ3EjaQ9C9g/JuJlCqrq/G08j491DfpcPoy33f6qEe
 9Tunw8ST+BqOdcryHO71d+7MXR44yxfqbXLp8xonOpmDNyvuXe21q6nXHsG3Z31NBzuDF
 m4RR1gNJe0xixQMDHBPpdEo7/JJeMv+uH06UQydiXqT2n5FiWXtjuA9qfy4TOPKcHxb6T
 /5aOU5eDXZBWcxCvFQZw38bBgHWpZge4kqO5Gd7QmnQZKbNipheF7ASYOsV517lobDQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792836790;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:From:
 In-Reply-To:References:MIME-Version:Date:X-Gm-Features:Message-ID:
 Subject:To:Cc:Content-Type;
 bh=rG8LWOaG5YUxH6F2mvzlKRXwnVwA6W9eUkHhI0MNYwU=;
 b=hytCHg8KUALmlAQUES8my/fOprRXNLOkiFcfBg1SeUaWhDHCzBM4y9bIkVpLfUtcmy+w
 9njmdunlPsRXM6m/i39B/KDCp6CKMexCQpsWvo8y8fWkIKY6PeVeF5Aud//9LfL2KPxfi
 nvOfNyjZq4UVyPfBlQZEoTBoMJX5w41ViyTD95SNCndqHO3ujUF+hmWipoD+DAzHNw+/j
 op/BYDiGFVP2SroEnhOp5a2JgIuBXVG7p1TqWC3AiNz6XK+NEvBPaxKbiCGOwJMQI9xW0
 k0EAPhbk/+gWUr3MAjJwpDTwcIcqYfoASfNgFlivjfadqIo/sRjym4EfU4COasKYU+Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=aEYcgGbd; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::230"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::230; helo=mail-oi1-x230.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=aEYcgGbd
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B37D68169A
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 10:13:09 +0000 (UTC)
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-4b28d7c729fso923943b6e.0
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 03:13:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792836788; cv=none;
 d=google.com; s=arc-20260327;
 b=eazPI8y5qEODgSKyovb/DnPZRjJKIxX9CjcDfBokFjD4kCXxUEptc221RvyvGgJTg5
 GZRVtGL6H9HSPsiHWvr9HjSVm50MHdNvPUB5fuGvMiDDM4bHJLRxR/j+vbGihg/Oa/ma
 rd5wLAeNGYC4K+Ey5/0ZwiXtr+TwecLWNRO4xKigkDR8Js3nBs2n0MsK83nzNyzJ7rGC
 Wa9RS9NFyGZYtND0ig0aq0pVNYN0ayl7BWVOJ9fDZGTg8f1PYB0P+PsMD/ShKCyEZJWD
 HRi3uF0M1aQmBZ1A8WMdGoDld5JL1V3sQrF12yFSzDbFgYmXt8bFkS0tmCoDhOx+S9Ss
 G2PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
 :from:dkim-signature;
 bh=rG8LWOaG5YUxH6F2mvzlKRXwnVwA6W9eUkHhI0MNYwU=;
 fh=Y1ZREHJ+pHB0HlzZ/KBn18KcwK0OUTCLdCrezQyH/Kw=;
 b=soP3JYeIQqj+QGb8Jmsj8vghIyuPLQJpQqeqrCt+Y52+43hkvuncKSVRjzHP5YYrfw
 ucIBT6CbwGKqGIaVA2GnFnDKOfPitNiX7YiW8MdlkyTajtXlaiFrWEaGGlykL1OGjhI7
 bC/YkHrygb/ZYnpk8IrtZuXxfkZWQUEDxCT7Nchx4F/QftRO7UKvgNLi4gddMJK83ds6
 WdT+jq1mLzewT1FkJLxZW/evlP53BAO0fSNJqj/obwQBcHhvMn2oR+3F8JkaGMIrTCl/
 y2AnTPx6OU/OSIeT+40ENAeq/PDbKeRu9IcPIPiMv6jZUosBQrgZ/4Hbs7BHtT05BJDn
 pIGg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792836788; x=1793441588;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=rG8LWOaG5YUxH6F2mvzlKRXwnVwA6W9eUkHhI0MNYwU=;
 b=aEYcgGbdGZuv7///s/r7qVEVkZnIh2aPWg0NqLdlN/xo4v0T1B1sWn9JkJAPl6sN3F
 HHDAl3P0ofGCHx/ASG5rCqXSidRa7nUPiMfQmMR1lEBl26FQ3RQxUmkRidt95h5p9IjE
 F8I22g5UnD2Hl6JtLQh7E0nIECOOwCt/ld3WqZswu1fObGjMCuluyNKEjpjrodfnDWAl
 akssWy0t2JljWHAg7t6jjtppP1vACWpr+XNZgwIsh20OKJjxG62iZi+finotZLuuXwsm
 Cd0vooTXT1RjdEe+duDz3PWc9Kswc6zyAY8cB4KUKTHOF8pCq5Ak3zFyBm6rCfkupnBk
 6e+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792836788; x=1793441588;
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rG8LWOaG5YUxH6F2mvzlKRXwnVwA6W9eUkHhI0MNYwU=;
 b=fBgs7Tlfc6F2yHmO+koMRYpJDa1xOExsShCbU+hi8uZE4upazBiw935iadASUDsYxS
 q8pKr4Gdn4nTajtlFUajprT2gZEEuUQhGRScZzZ905yslYnxRUgPSFP2U9I88Dtg9/s5
 0UFc+9xI2D/4YzEDf+pB1yCiYKa0NMeuutdJY/L5wQNzGUr+yO8TkEVbW6e9trbZd72l
 LjV8RoEn/6p9TQgWvl8r2XKH2vM0mYjWOxYmLeW39NTmBBj1xpbaA6XMLextq0LVZieJ
 bltf9awEx/OGTCt9QHr/akpopbNw24kmDIN3hgZ6qe5bi7ysBk9+i9M2L31LyxGiOlPk
 Oysw==
X-Gm-Message-State: AFq9FYKe/UQEqmXmnXAFfwxgsjak21m6lNd7Fq53+9/IGB2OcXEiBXBj
 sAmFJGJoZKFdH3R7SVrcIYC8oB9HI304p6EtA6etJJi0FeupxQ0vx7Xxv5RrzckItSji5pLTEa6
 QqUelDGri8cAeQaHARiqs1ExIvMlOAP1Iwq4W
X-Gm-Gg: AYBFou1QGtTzYVBrYxR+NwIwR/pUzYFDLqE996zbHU/K0Bl4As7aToG9A1NnobAyCT9
 TiTr3KN2Qro5B+M6FyssZHtO0kRZ8u2X7V2x9xv7HcJNX2mklOXaLfV1DmH02sXTYskXbw8Pyc9
 3xPl/ltqHRr/QrNgJ72C9knot9L+KzczDMOOG5ZBkxlyf1Fm5ikIng6UCLK2U2kSQ88HM7Uj2PP
 dmWEZP8GPTAYq0KNa5I3/iLWcd/E8MyBLdunyXMwaTk/5S1QRTuIb9kvqiiLsmUPp+YcxB09nj8
 2GcdrzvdGRt+PVF2HDHXl3BJh8F+KXwffh5BOUiUhY8Qk1byToAu5qK69cZ0jp+iDVMBnFrk4Sr
 zPtI5O81E0z3fhzY8yMD/N0hWkMuk0rhV3vDMuxH+AUw1UHw7676YhpO3Oms=
X-Received: by 2002:a05:6808:1983:b0:4c3:4e34:c69e with SMTP id
 5614622812f47-55bfff6cae2mr1176711b6e.8.1792836788474; Sat, 24 Oct 2026
 03:13:08 -0700 (PDT)
Received: from 1077388689865 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 24 Oct 2026 03:13:07 -0700
Received: from 1077388689865 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 24 Oct 2026 03:13:07 -0700
From: Ana Bobillo <anabobillo3@gmail.com>
In-Reply-To: <CAJnxHshO21nXubiOWq9+MRtAY9TWqWvLn5nZWNtKKBQAPiL6Dw@mail.gmail.com>
References: <CAJnxHshO21nXubiOWq9+MRtAY9TWqWvLn5nZWNtKKBQAPiL6Dw@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Sat, 24 Oct 2026 03:13:07 -0700
X-Gm-Features: AclHuK-IpevXVZfXHEIlRF8Dyx34eTadEWB_TZR_bgarYQ1hRb3cqG9XPcU0IzA
Message-ID: <CAJnxHsjBSkQzuEtPMoU+XK3rZE-u2bAUm-cgMiRyga2OeG5iDg@mail.gmail.com>
Subject: [PATCH 7/9] disk: part_dos: Walk the extended partition tables in a
 bounded loop
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, Bin Meng <bmeng.cn@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alexey Charkov <alchark@flipper.net>, 
 Javier Martinez Canillas <javierm@redhat.com>
Content-Type: multipart/mixed; boundary="000000000000eaee11065e935779"
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

--000000000000eaee11065e935779
Content-Type: text/plain; charset="UTF-8"

From: Ana Bobillo <anabobillo3@gmail.com>

--000000000000eaee11065e935779
Content-Type: text/plain; charset="utf-8"; name="0007.patch"
Content-Disposition: attachment; filename="0007.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: cf154e1f2591337f_0.1

cGFydF9nZXRfaW5mb19leHRlbmRlZCgpIGFuZCBwcmludF9wYXJ0aXRpb25fZXh0ZW5kZWQoKSBm
b2xsb3cgdGhlCmxpbmtzIGZyb20gb25lIGV4dGVuZGVkIHBhcnRpdGlvbiB0YWJsZSB0byB0aGUg
bmV4dCBieSByZWN1cnNpbmcsIGFuZApzdG9wIGF0IE1BWF9FWFRfUEFSVFMgcGFydGl0aW9ucywg
dGhlIGxpbWl0IGFkZGVkIGZvciBDVkUtMjAxOS0xMzEwMy4KQnV0IGEgbGluayBhZGRzIG5vIHBh
cnRpdGlvbjogYW4gZXh0ZW5kZWQgcGFydGl0aW9uIHRhYmxlIGhvbGRpbmcgb25seQphIGxpbmsg
YmFjayB0byBpdHNlbGYgZG9lcyBub3QgYWR2YW5jZSBwYXJ0X251bSwgc28gdGhlIHJlY3Vyc2lv
biBnb2VzCm9uIHVudGlsIHRoZSBzdGFjayBydW5zIG91dCwgd2hlbmV2ZXIgYSBsb2dpY2FsIHBh
cnRpdGlvbiBvZiB0aGUgZGV2aWNlCmlzIGxvb2tlZCB1cC4gRXZlbiB3aXRoaW4gdGhlIGxpbWl0
LCBldmVyeSBsZXZlbCBrZWVwcyBhIGJ1ZmZlciBvZiBvbmUKYmxvY2sgb24gdGhlIHN0YWNrLCBz
byBhIGxvbmcgY2hhaW4gb2YgdGFibGVzIG9uIGEgZGV2aWNlIHdpdGggbGFyZ2UKYmxvY2tzIG5l
ZWRzIG1lZ2FieXRlcyBvZiBzdGFjay4KCkZvbGxvdyB0aGUgbGlua3MgaW4gYSBsb29wIGluc3Rl
YWQsIHJldXNpbmcgdGhlIG9uZSBidWZmZXIsIGFuZCBzdG9wCmFmdGVyIE1BWF9FWFRfVEFCTEVT
IHRhYmxlcywgYXMgbWFueSBhcyBNQVhfRVhUX1BBUlRTIHBhcnRpdGlvbnMgbmVlZCwKc28gdGhh
dCBhIGRpc2sgd2l0aCBhcyBtYW55IHBhcnRpdGlvbnMgYXMgYmVmb3JlIHN0aWxsIHJlYWRzLiBM
aW51eApib3VuZHMgdGhlIHNhbWUgd2FsayBpbiBwYXJzZV9leHRlbmRlZCgpLCBieSB0aGUgbnVt
YmVyIG9mIGxpbmtzCmZvbGxvd2VkIHdpdGhvdXQgZmluZGluZyBhIHBhcnRpdGlvbi4KCnByaW50
X3BhcnRpdGlvbl9leHRlbmRlZCgpIGZvbGxvd2VkIGV2ZXJ5IGxpbmsgb2YgYSB0YWJsZSwgd2hl
cmUKcGFydF9nZXRfaW5mb19leHRlbmRlZCgpIGZvbGxvd3Mgb25seSB0aGUgZmlyc3QsIHNvIGl0
IGNvdWxkIGxpc3QKcGFydGl0aW9ucyB0aGF0IGNhbm5vdCBiZSBsb29rZWQgdXAsIHVuZGVyIG51
bWJlcnMgdGhhdCBjbGFzaCwgYW5kIGl0cwp3YWxrIHdhcyBub3QgYSBjaGFpbiBidXQgYSB0cmVl
LiBGb2xsb3cgb25seSB0aGUgZmlyc3QgbGluayB0aGVyZSB0b28uCgpBZGQgYSB0ZXN0IHdpdGgg
YSB0YWJsZSB0aGF0IGxpbmtzIG9ubHkgdG8gaXRzZWxmLCBhZnRlciB0d28gbG9naWNhbApwYXJ0
aXRpb25zLgoKU2lnbmVkLW9mZi1ieTogQW5hIEJvYmlsbG8gPGFuYWJvYmlsbG8zQGdtYWlsLmNv
bT4KLS0tCiBkaXNrL3BhcnRfZG9zLmMgfCAgNDEgKysrKysrKysrKysrKystLS0tLS0KIHRlc3Qv
ZG0vcGFydC5jICB8IDEwMCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysKIDIgZmlsZXMgY2hhbmdlZCwgMTMwIGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9u
cygtKQoKZGlmZiAtLWdpdCBhL2Rpc2svcGFydF9kb3MuYyBiL2Rpc2svcGFydF9kb3MuYwppbmRl
eCA0YjU2MGZkZTFmYi4uZjQ1MWFlZjc2YTggMTAwNjQ0Ci0tLSBhL2Rpc2svcGFydF9kb3MuYwor
KysgYi9kaXNrL3BhcnRfZG9zLmMKQEAgLTI4LDYgKzI4LDEzIEBACiAgKiB0byB1c2UgbGFyZ2Ug
bnVtYmVycyBvZiBwYXJ0aXRpb25zICovCiAjZGVmaW5lIE1BWF9FWFRfUEFSVFMgMjU2CiAKKy8q
CisgKiBBIGxpbmsgdG8gdGhlIG5leHQgZXh0ZW5kZWQgcGFydGl0aW9uIHRhYmxlIGFkZHMgbm8g
cGFydGl0aW9uLCBzbyB0YWJsZXMKKyAqIGxpbmtpbmcgYmFjayB0byBlYWNoIG90aGVyIGRvIG5v
dCBhZHZhbmNlIHBhcnRfbnVtLiBCb3VuZCB0aGUgbnVtYmVyIG9mCisgKiB0YWJsZXMgcmVhZCBh
bG9uZyBhIGNoYWluIGFzIHdlbGwsIGFsbG93aW5nIGFzIG1hbnkgYXMgTUFYX0VYVF9QQVJUUyBu
ZWVkcy4KKyAqLworI2RlZmluZSBNQVhfRVhUX1RBQkxFUyBNQVhfRVhUX1BBUlRTCisKIHN0YXRp
YyBpbmxpbmUgaW50IGlzX2V4dGVuZGVkKGludCBwYXJ0X3R5cGUpCiB7CiAgICAgcmV0dXJuIChw
YXJ0X3R5cGUgPT0gRE9TX1BBUlRfVFlQRV9FWFRFTkRFRCB8fApAQCAtMTM1LDEwICsxNDIsMTMg
QEAgc3RhdGljIHZvaWQgcHJpbnRfcGFydGl0aW9uX2V4dGVuZGVkKHN0cnVjdCBibGtfZGVzYyAq
ZGVzYywKIHsKIAlBTExPQ19DQUNIRV9BTElHTl9CVUZGRVIodW5zaWduZWQgY2hhciwgYnVmZmVy
LCBkZXNjLT5ibGtzeik7CiAJZG9zX3BhcnRpdGlvbl90ICpwdDsKKwlpbnQgdGFibGVzID0gMDsK
IAlpbnQgaTsKIAotCS8qIHNldCBhIG1heGltdW0gcmVjdXJzaW9uIGxldmVsICovCi0JaWYgKHBh
cnRfbnVtID4gTUFYX0VYVF9QQVJUUykKK25leHRfdGFibGU6CisJLyogYm91bmQgdGhlIHdhbGsg
Ki8KKwl0YWJsZXMrKzsKKwlpZiAocGFydF9udW0gPiBNQVhfRVhUX1BBUlRTIHx8IHRhYmxlcyA+
IE1BWF9FWFRfVEFCTEVTKQogCXsKIAkJcHJpbnRmKCIqKiBOZXN0ZWQgRE9TIHBhcnRpdGlvbnMg
ZGV0ZWN0ZWQsIHN0b3BwaW5nICoqXG4iKTsKIAkJcmV0dXJuOwpAQCAtMTg3LDkgKzE5NywxNCBA
QCBzdGF0aWMgdm9pZCBwcmludF9wYXJ0aXRpb25fZXh0ZW5kZWQoc3RydWN0IGJsa19kZXNjICpk
ZXNjLAogCQkJbGJhaW50X3QgbGJhX3N0YXJ0CiAJCQkJPSBnZXRfdW5hbGlnbmVkX2xlMzIgKCZw
dC0+c3RhcnRfc2VjdCkgKyByZWxhdGl2ZTsKIAotCQkJcHJpbnRfcGFydGl0aW9uX2V4dGVuZGVk
KGRlc2MsIGxiYV9zdGFydCwKLQkJCQkJCSAhZXh0X3BhcnRfc2VjdG9yID8gbGJhX3N0YXJ0IDoK
LQkJCQkJCSByZWxhdGl2ZSwgcGFydF9udW0sIGRpc2tzaWcpOworCQkJLyoKKwkJCSAqIEZvbGxv
dyBvbmx5IHRoZSBmaXJzdCBsaW5rLCBhcworCQkJICogcGFydF9nZXRfaW5mb19leHRlbmRlZCgp
IGRvZXMsIHJldXNpbmcgdGhlIGJ1ZmZlcgorCQkJICovCisJCQlpZiAoZXh0X3BhcnRfc2VjdG9y
ID09IDApCisJCQkJcmVsYXRpdmUgPSBsYmFfc3RhcnQ7CisJCQlleHRfcGFydF9zZWN0b3IgPSBs
YmFfc3RhcnQ7CisJCQlnb3RvIG5leHRfdGFibGU7CiAJCX0KIAl9CiAKQEAgLTIyMCwxMSArMjM1
LDE0IEBAIHN0YXRpYyBpbnQgcGFydF9nZXRfaW5mb19leHRlbmRlZChzdHJ1Y3QgYmxrX2Rlc2Mg
KmRlc2MsCiAJQUxMT0NfQ0FDSEVfQUxJR05fQlVGRkVSKHVuc2lnbmVkIGNoYXIsIGJ1ZmZlciwg
ZGVzYy0+Ymxrc3opOwogCXN0cnVjdCBkaXNrX3BhcnRpdGlvbiB3ZGluZm8gPSB7IDAgfTsKIAlk
b3NfcGFydGl0aW9uX3QgKnB0OworCWludCB0YWJsZXMgPSAwOwogCWludCBpLCByZXQ7CiAJaW50
IGRvc190eXBlOwogCi0JLyogc2V0IGEgbWF4aW11bSByZWN1cnNpb24gbGV2ZWwgKi8KLQlpZiAo
cGFydF9udW0gPiBNQVhfRVhUX1BBUlRTKQorbmV4dF90YWJsZToKKwkvKiBib3VuZCB0aGUgd2Fs
ayAqLworCXRhYmxlcysrOworCWlmIChwYXJ0X251bSA+IE1BWF9FWFRfUEFSVFMgfHwgdGFibGVz
ID4gTUFYX0VYVF9UQUJMRVMpCiAJewogCQlwcmludGYoIioqIE5lc3RlZCBET1MgcGFydGl0aW9u
cyBkZXRlY3RlZCwgc3RvcHBpbmcgKipcbiIpOwogCQlyZXR1cm4gLTE7CkBAIC0zMDIsMTAgKzMy
MCwxMSBAQCBzdGF0aWMgaW50IHBhcnRfZ2V0X2luZm9fZXh0ZW5kZWQoc3RydWN0IGJsa19kZXNj
ICpkZXNjLAogCQkJbGJhaW50X3QgbGJhX3N0YXJ0CiAJCQkJPSBnZXRfdW5hbGlnbmVkX2xlMzIg
KCZwdC0+c3RhcnRfc2VjdCkgKyByZWxhdGl2ZTsKIAotCQkJcmV0dXJuIHBhcnRfZ2V0X2luZm9f
ZXh0ZW5kZWQoZGVzYywgbGJhX3N0YXJ0LAotCQkJCSBleHRfcGFydF9zZWN0b3IgPT0gMCA/IGxi
YV9zdGFydCA6IHJlbGF0aXZlLAotCQkJCQkJICAgICAgcGFydF9udW0sIHdoaWNoX3BhcnQsIGlu
Zm8sCi0JCQkJCQkgICAgICBtYnIsIGRpc2tzaWcpOworCQkJLyogZm9sbG93IHRoZSBsaW5rLCBy
ZXVzaW5nIHRoZSBidWZmZXIgKi8KKwkJCWlmIChleHRfcGFydF9zZWN0b3IgPT0gMCkKKwkJCQly
ZWxhdGl2ZSA9IGxiYV9zdGFydDsKKwkJCWV4dF9wYXJ0X3NlY3RvciA9IGxiYV9zdGFydDsKKwkJ
CWdvdG8gbmV4dF90YWJsZTsKIAkJfQogCX0KIApkaWZmIC0tZ2l0IGEvdGVzdC9kbS9wYXJ0LmMg
Yi90ZXN0L2RtL3BhcnQuYwppbmRleCBhZDM3ZDdmNDA2Zi4uNGUzMTNlNTA3NTIgMTAwNjQ0Ci0t
LSBhL3Rlc3QvZG0vcGFydC5jCisrKyBiL3Rlc3QvZG0vcGFydC5jCkBAIC0zLDEwICszLDEzIEBA
CiAgKiBDb3B5cmlnaHQgKEMpIDIwMjAgU2VhbiBBbmRlcnNvbiA8c2Vhbi5hbmRlcnNvbkBzZWNv
LmNvbT4KICAqLwogCisjaW5jbHVkZSA8YmxrLmg+CiAjaW5jbHVkZSA8ZG0uaD4KICNpbmNsdWRl
IDxlbnYuaD4KKyNpbmNsdWRlIDxtZW1hbGlnbi5oPgogI2luY2x1ZGUgPG1tYy5oPgogI2luY2x1
ZGUgPHBhcnQuaD4KKyNpbmNsdWRlIDxwYXJ0X2Rvcy5oPgogI2luY2x1ZGUgPHBhcnRfZWZpLmg+
CiAjaW5jbHVkZSA8ZG0vdGVzdC5oPgogI2luY2x1ZGUgPHRlc3QvdXQuaD4KQEAgLTI0OCwzICsy
NTEsMTAwIEBAIHN0YXRpYyBpbnQgZG1fdGVzdF9wYXJ0X2dldF9pbmZvX2J5X3V1aWQoc3RydWN0
IHVuaXRfdGVzdF9zdGF0ZSAqdXRzKQogCXJldHVybiAwOwogfQogRE1fVEVTVChkbV90ZXN0X3Bh
cnRfZ2V0X2luZm9fYnlfdXVpZCwgVVRGX1NDQU5fUERBVEEgfCBVVEZfU0NBTl9GRFQpOworCisv
KioKKyAqIGRvc19zZXRfZW50cnkoKSAtIGZpbGwgaW4gb25lIGVudHJ5IG9mIGEgRE9TIHBhcnRp
dGlvbiB0YWJsZQorICoKKyAqIEBwdDoJCWVudHJ5IHRvIGZpbGwgaW4KKyAqIEBzeXNfaW5kOglw
YXJ0aXRpb24gdHlwZQorICogQHN0YXJ0OglmaXJzdCBzZWN0b3IsIHJlbGF0aXZlIHRvIHdoYXQg
dGhlIHRhYmxlIHR5cGUgc2F5cworICogQHNpemU6CW51bWJlciBvZiBzZWN0b3JzCisgKi8KK3N0
YXRpYyB2b2lkIGRvc19zZXRfZW50cnkoZG9zX3BhcnRpdGlvbl90ICpwdCwgdTggc3lzX2luZCwg
dTMyIHN0YXJ0LAorCQkJICB1MzIgc2l6ZSkKK3sKKwltZW1zZXQocHQsICdcMCcsIHNpemVvZigq
cHQpKTsKKwlwdC0+c3lzX2luZCA9IHN5c19pbmQ7CisJcHQtPnN0YXJ0X3NlY3QgPSBjcHVfdG9f
bGUzMihzdGFydCk7CisJcHQtPm5yX3NlY3RzID0gY3B1X3RvX2xlMzIoc2l6ZSk7Cit9CisKKy8q
KgorICogZG9zX3dyaXRlX3RhYmxlKCkgLSB3cml0ZSBhIERPUyBwYXJ0aXRpb24gdGFibGUgdG8g
YSBzZWN0b3IKKyAqCisgKiBAZGVzYzoJYmxvY2sgZGV2aWNlIHRvIHdyaXRlIHRvLCB3aXRoIDUx
Mi1ieXRlIGJsb2NrcworICogQGxiYToJc2VjdG9yIHRvIHdyaXRlIHRoZSB0YWJsZSB0bworICog
QHB0OgkJdGhlIGZvdXIgZW50cmllcyBvZiB0aGUgdGFibGUKKyAqIFJldHVybjogMCBpZiBPSywg
LUVJTyBpZiB0aGUgc2VjdG9yIGNvdWxkIG5vdCBiZSB3cml0dGVuCisgKi8KK3N0YXRpYyBpbnQg
ZG9zX3dyaXRlX3RhYmxlKHN0cnVjdCBibGtfZGVzYyAqZGVzYywgbGJhaW50X3QgbGJhLAorCQkJ
ICAgY29uc3QgZG9zX3BhcnRpdGlvbl90IHB0WzRdKQoreworCUFMTE9DX0NBQ0hFX0FMSUdOX0JV
RkZFUih1OCwgYnVmLCA1MTIpOworCisJbWVtc2V0KGJ1ZiwgJ1wwJywgNTEyKTsKKwltZW1jcHko
YnVmICsgRE9TX1BBUlRfVEJMX09GRlNFVCwgcHQsIDQgKiBzaXplb2YoKnB0KSk7CisJYnVmW0RP
U19QQVJUX01BR0lDX09GRlNFVF0gPSAweDU1OworCWJ1ZltET1NfUEFSVF9NQUdJQ19PRkZTRVQg
KyAxXSA9IDB4YWE7CisKKwlyZXR1cm4gYmxrX2R3cml0ZShkZXNjLCBsYmEsIDEsIGJ1ZikgPT0g
MSA/IDAgOiAtRUlPOworfQorCisvKgorICogQSBsaW5rIGZyb20gb25lIGV4dGVuZGVkIHBhcnRp
dGlvbiB0YWJsZSB0byB0aGUgbmV4dCBhZGRzIG5vIHBhcnRpdGlvbiwKKyAqIHNvIGEgd2FsayB0
aHJvdWdoIHRhYmxlcyB0aGF0IGxpbmsgdG8gZWFjaCBvdGhlciBpbiBhIGxvb3AgZmluZHMgbm8g
bW9yZQorICogcGFydGl0aW9ucyBhcyBpdCBnb2VzLiBDaGVjayB0aGF0IGl0IGVuZHMgYW55d2F5
LCBib3RoIHdoZW4gbG9va2luZyBmb3IgYQorICogcGFydGl0aW9uIGFuZCB3aGVuIGxpc3Rpbmcg
dGhlbS4KKyAqLworc3RhdGljIGludCBkbV90ZXN0X3BhcnRfZG9zX2V4dF9sb29wKHN0cnVjdCB1
bml0X3Rlc3Rfc3RhdGUgKnV0cykKK3sKKwlzdHJ1Y3QgZGlza19wYXJ0aXRpb24gaW5mbzsKKwlk
b3NfcGFydGl0aW9uX3QgcHRbNF07CisJc3RydWN0IGJsa19kZXNjICpkZXNjOworCisJdXRfYXNz
ZXJ0ZXEoMiwgYmxrX2dldF9kZXZpY2VfYnlfc3RyKCJtbWMiLCAiMiIsICZkZXNjKSk7CisJdXRf
YXNzZXJ0ZXEoNTEyLCBkZXNjLT5ibGtzeik7CisKKwkvKiBhbiBNQlIgd2l0aCBvbmUgZXh0ZW5k
ZWQgcGFydGl0aW9uLCBmcm9tIHNlY3RvciAyICovCisJbWVtc2V0KHB0LCAnXDAnLCBzaXplb2Yo
cHQpKTsKKwlkb3Nfc2V0X2VudHJ5KCZwdFswXSwgRE9TX1BBUlRfVFlQRV9FWFRFTkRFRCwgMiwg
MTAwKTsKKwl1dF9hc3NlcnRvayhkb3Nfd3JpdGVfdGFibGUoZGVzYywgMCwgcHQpKTsKKworCS8q
CisJICogbG9naWNhbCBwYXJ0aXRpb25zIDUgYW5kIDYsIGVhY2ggaW4gYSB0YWJsZSBvZiBpdHMg
b3duOyBhIGxpbmsgaXMKKwkgKiByZWxhdGl2ZSB0byB0aGUgZXh0ZW5kZWQgcGFydGl0aW9uLCBh
IHBhcnRpdGlvbiB0byBpdHMgb3duIHRhYmxlCisJICovCisJZG9zX3NldF9lbnRyeSgmcHRbMF0s
IDB4ODMsIDEsIDQpOworCWRvc19zZXRfZW50cnkoJnB0WzFdLCBET1NfUEFSVF9UWVBFX0VYVEVO
REVELCAxMCwgMTApOworCXV0X2Fzc2VydG9rKGRvc193cml0ZV90YWJsZShkZXNjLCAyLCBwdCkp
OworCWRvc19zZXRfZW50cnkoJnB0WzFdLCBET1NfUEFSVF9UWVBFX0VYVEVOREVELCAyMCwgMTAp
OworCXV0X2Fzc2VydG9rKGRvc193cml0ZV90YWJsZShkZXNjLCAxMiwgcHQpKTsKKworCS8qIHRo
ZW4gYSB0YWJsZSB3aXRoIG5vIHBhcnRpdGlvbiwgb25seSBsaW5rcyBiYWNrIHRvIGl0c2VsZiAq
LworCWRvc19zZXRfZW50cnkoJnB0WzBdLCBET1NfUEFSVF9UWVBFX0VYVEVOREVELCAyMCwgMTAp
OworCXV0X2Fzc2VydG9rKGRvc193cml0ZV90YWJsZShkZXNjLCAyMiwgcHQpKTsKKworCXV0X2Fz
c2VydG9rKHBhcnRfZ2V0X2luZm9fYnlfdHlwZShkZXNjLCA1LCBQQVJUX1RZUEVfRE9TLCAmaW5m
bykpOworCXV0X2Fzc2VydGVxKDMsIGluZm8uc3RhcnQpOworCXV0X2Fzc2VydGVxKDQsIGluZm8u
c2l6ZSk7CisJdXRfYXNzZXJ0b2socGFydF9nZXRfaW5mb19ieV90eXBlKGRlc2MsIDYsIFBBUlRf
VFlQRV9ET1MsICZpbmZvKSk7CisJdXRfYXNzZXJ0ZXEoMTMsIGluZm8uc3RhcnQpOworCXV0X2Fz
c2VydGVxKDQsIGluZm8uc2l6ZSk7CisKKwkvKiB0aGVyZSBpcyBubyBwYXJ0aXRpb24gNywgYW5k
IGxvb2tpbmcgZm9yIGl0IGhhcyB0byBlbmQgKi8KKwl1dF9hc3NlcnRlcSgtRU5PRU5ULAorCQkg
ICAgcGFydF9nZXRfaW5mb19ieV90eXBlKGRlc2MsIDcsIFBBUlRfVFlQRV9ET1MsICZpbmZvKSk7
CisJdXRfYXNzZXJ0X25leHRsaW5lKCIqKiBOZXN0ZWQgRE9TIHBhcnRpdGlvbnMgZGV0ZWN0ZWQs
IHN0b3BwaW5nICoqIik7CisJdXRfYXNzZXJ0X2NvbnNvbGVfZW5kKCk7CisKKwkvKiBhbmQgc28g
ZG9lcyBsaXN0aW5nIHRoZW0gKi8KKwlkZXNjLT5wYXJ0X3R5cGUgPSBQQVJUX1RZUEVfRE9TOwor
CXBhcnRfcHJpbnQoZGVzYyk7CisJdXRfYXNzZXJ0X3NraXBfdG9fbGluZSgiJTNkXHQlLTEwZFx0
JS0xMGRcdCUwOHgtJTAyeFx0JTAyeCIsIDYsIDEzLCA0LAorCQkJICAgICAgIDAsIDYsIDB4ODMp
OworCXV0X2Fzc2VydF9uZXh0bGluZSgiKiogTmVzdGVkIERPUyBwYXJ0aXRpb25zIGRldGVjdGVk
LCBzdG9wcGluZyAqKiIpOworCXV0X2Fzc2VydF9jb25zb2xlX2VuZCgpOworCisJcmV0dXJuIDA7
Cit9CitETV9URVNUKGRtX3Rlc3RfcGFydF9kb3NfZXh0X2xvb3AsIFVURl9TQ0FOX1BEQVRBIHwg
VVRGX1NDQU5fRkRUIHwgVVRGX0NPTlNPTEUpOwo=
--000000000000eaee11065e935779--
